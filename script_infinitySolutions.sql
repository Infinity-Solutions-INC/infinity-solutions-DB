CREATE DATABASE IF NOT EXISTS infinity_solutions;
use infinity_solutions;

create table IF NOT EXISTS prompt_ia (
	codigo_prompt int primary key auto_increment,
    descricao_prompt varchar(100)
);

create table IF NOT EXISTS area_curso (
	codigo_area int primary key auto_increment,
    nome_area varchar(60)
);

create table IF NOT EXISTS instituicao (
	codigo_instituicao int primary key auto_increment,
    nome_instituicao varchar(60) not null
) auto_increment = 100;

create table IF NOT EXISTS curso (
	codigo_curso int primary key auto_increment,
    nome_curso varchar(60),
    fkcodigo_instituicao int,
    fkcodigo_area int,
    
    constraint fk_curso_instituicao foreign key (fkcodigo_instituicao) references instituicao(codigo_instituicao),
    constraint fk_curso_area foreign key (fkcodigo_area) references area_curso(codigo_area)
);

create table IF NOT EXISTS funcionario (
	codigo_funcionario char(6) primary key not null,
    nome_funcionario varchar(60) not null,
    cargo_funcionario varchar(40) not null,
    cpf_funcionario char(11) not null,
    email_funcionario varchar(60) ,
    senha_funcionario varchar(200) ,
    status_funcionario varchar(30),
    fkcodigo_instituicao int not null,
    
    constraint fk_funcionario_instituicao foreign key (fkcodigo_instituicao) references instituicao(codigo_instituicao),
    constraint chk_funcionario_status check (status_funcionario in("ativo", "bloqueado"))
);

create table IF NOT EXISTS turma (
	codigo_turma int primary key auto_increment,
    ano_turma int not null,
	qtd_ingressantes int not null,
    qtd_alunos_permanencia int not null, 
    fkcodigo_curso int,
    
    constraint fk_turma_curso foreign key (fkcodigo_curso) references curso(codigo_curso)
) auto_increment = 100;


create table IF NOT EXISTS recomendacao_enviada (
	codigo_recomendacao_enviada int primary key auto_increment,
    fkcodigo_turma int not null,
    fkcodigo_prompt int not null,
    descricao_recomendacao_enviada text not null,
    dt_hr_recomendacao_enviada datetime not null,
    
    constraint fk_recEnv_prompt_ia_codigo foreign key (fkcodigo_prompt) references prompt_ia (codigo_prompt),
    constraint fk_recEnv_turma_codigo foreign key (fkcodigo_turma) references turma (codigo_turma)
);

create table IF NOT EXISTS motivo_evasao (
	codigo_motivo_evasao int primary key auto_increment,
    descricao_motivo_evasao varchar(50) not null,
    dt_hr_registro_motivo_evasao datetime not null,
    fkcodigo_turma int not null,
    
    constraint fk_motEvas_turma_codigo foreign key (fkcodigo_turma) references turma(codigo_turma)
);