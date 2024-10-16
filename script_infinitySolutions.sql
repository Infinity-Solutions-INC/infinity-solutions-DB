CREATE DATABASE IF NOT EXISTS infinity_solutions;
use infinity_solutions;

create table prompt_ia (
	codigo_prompt int primary key auto_increment,
    descricao_prompt varchar(100) not null
);

create table curso (
	codigo_curso int primary key auto_increment,
    nome_curso varchar(60),
    turno_curso varchar(20),
    modalidade_curso varchar(15),
    valor_mensalidade_curso double(6,2)
);

create table instituicao (
	codigo_instituicao int primary key auto_increment,
    nome_instituicao varchar(60) not null,
    cnpj_instituicao char(14)
) auto_increment = 100;

create table unidade (
	codigo_unidade int primary key auto_increment, 
    nome_unidade varchar(60) not null,
    logradouro_unidade varchar(30) not null,
    numero_logradouro_unidade varchar(6) not null,
    bairro_unidade varchar(40) not null,
    cidade_unidade varchar(30) not null,
    estado_unidade varchar(30) not null,
    cep_unidade char(9) not null,
    fkcodigo_instituicao int not null,
    
    constraint fk_unidade_instituicao_codigo foreign key (fkcodigo_instituicao) references instituicao(codigo_instituicao)
) auto_increment = 1000;

create table funcionario (
	codigo_funcionario int primary key auto_increment,
    nome_funcionario varchar(60) not null,
    cargo_funcionario varchar(40) not null,
    email_funcionario varchar(60) not null,
    senha_funcionario varchar(20) not null,
    status_funcionario varchar(10) not null,
    fkcodigo_unidade int not null,
    
    constraint fk_funcionario_unidade_codigo foreign key (fkcodigo_unidade) references unidade(codigo_unidade),
    constraint chk_funcionario_status check (status_funcionario in("ativo", "bloqueado"))
);

create table curso_unidade (
	fkcodigo_unidade int,
    fkcodigo_curso int, 
    dt_registro_curso_unidade date,
    
    constraint fk_cursUni_unidade_codigo foreign key (fkcodigo_unidade) references unidade(codigo_unidade),
    constraint fk_cursUni_curso_codigo foreign key (fkcodigo_curso) references curso (codigo_curso),
    constraint pk_curso_unidade primary key (fkcodigo_unidade, fkcodigo_curso)
);

create table turma (
	codigo_turma int primary key auto_increment,
    ano_turma varchar(4) not null,
    semestre_inicio_turma char(1) not null,
    quantidade_alunos_turma int not null,
    fkcodigo_unidade int not null,
    fkcodigo_curso int not null,
    
    constraint fk_turma_unidade_codigo foreign key (fkcodigo_unidade) references curso_unidade(fkcodigo_unidade),
    constraint fk_turma_curso_codigo foreign key (fkcodigo_curso) references curso_unidade(fkcodigo_curso)
) auto_increment = 100;


create table recomendacao_enviada (
	codigo_recomendacao_enviada int primary key auto_increment,
    fkcodigo_turma int not null,
    fkcodigo_prompt int not null,
    descricao_recomendacao_enviada text not null,
    dt_hr_recomendacao_enviada datetime not null,
    
    constraint fk_recEnv_prompt_ia_codigo foreign key (fkcodigo_prompt) references prompt_ia (codigo_prompt),
    constraint fk_recEnv_turma_codigo foreign key (fkcodigo_turma) references turma (codigo_turma)
);

create table motivo_evasao (
	codigo_motivo_evasao int primary key auto_increment,
    descricao_motivo_evasao varchar(50) not null,
    dt_hr_registro_motivo_evasao datetime not null,
    fkcodigo_turma int not null,
    
    constraint fk_motEvas_turma_codigo foreign key (fkcodigo_turma) references turma(codigo_turma)
);