CREATE DATABASE IF NOT EXISTS infinity_solutions;
use infinity_solutions;

create table IF NOT EXISTS error_logs (
	id int primary key auto_increment,
    mensagem_error text,
    dt_hr_captacao_error datetime
);

create table IF NOT EXISTS cargo (
	codigo_cargo int primary key auto_increment,
    nome_cargo varchar(30) not null
);

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
    nome_instituicao varchar(60) not null,
    cnpj_instituicao varchar(14)
) auto_increment = 100;

create table IF NOT EXISTS curso (
	codigo_curso int primary key auto_increment,
    nome_curso varchar(120),
    ano_curso int,
    fkcodigo_instituicao int,
    fkcodigo_area int,
    
    constraint fk_curso_instituicao foreign key (fkcodigo_instituicao) references instituicao(codigo_instituicao),
    constraint fk_curso_area foreign key (fkcodigo_area) references area_curso(codigo_area)
);

create table IF NOT EXISTS funcionario (
	codigo_funcionario char(6) primary key not null,
    nome_funcionario varchar(60) not null,
    fkcodigo_cargo int not null,
    cpf_funcionario char(11) not null,
    email_funcionario varchar(60) ,
    senha_funcionario varchar(200) ,
    status_funcionario varchar(30),
    fkcodigo_instituicao int not null,
    
    constraint fk_funcionario_instituicao foreign key (fkcodigo_instituicao) references instituicao(codigo_instituicao),
    constraint fk_funcionario_cargo foreign key (fkcodigo_cargo) references cargo(codigo_cargo),
    constraint chk_funcionario_status check (status_funcionario in("ativo", "bloqueado", "aguardando verificacao"))
);

create table IF NOT EXISTS turma (
	codigo_turma int primary key auto_increment,
    ano_turma int not null,
	qtd_ingressantes int not null,
    qtd_alunos_permanencia int not null,
    modalidade_turma varchar(30),
    mensalidade_turma double,
    turno_turma varchar(30),
    
    fkcodigo_curso int,
    
    constraint fk_turma_curso foreign key (fkcodigo_curso) references curso(codigo_curso)
) auto_increment = 100;


create table IF NOT EXISTS recomendacao_recebida (
	codigo_recomendacao_recebida int primary key auto_increment,
    fkcodigo_turma int not null,
    fkcodigo_prompt int not null,
    descricao_recomendacao_recebida text not null,
    dt_hr_recomendacao_recebida datetime not null,
    
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

    
insert into cargo (nome_cargo)
values
	("Diretor(a)"),
    ("Coordenador(a)"),
    ("Secretário(a)"),
    ("Administrador(a)"),
    ("CEO");
    
    select * from cargo;
insert into instituicao (nome_instituicao, cnpj_instituicao)
values
	("Mackenzie", "12345678901234");
    
insert into funcionario (codigo_funcionario, nome_funcionario, fkcodigo_cargo, cpf_funcionario, email_funcionario, senha_funcionario, status_funcionario, fkcodigo_instituicao)
values
	('vJ8Heo', "Luana", 1, "48825269803", "luacruz2014@gmail.com", "220206", "ativo", 100),
    ('AB2Dce', "Caio", 2, "48825269803", "teste@gmail.com", "220206", "ativo", 100),
    ('Gf2E14', "Patricia", 3, "48825269803", "teste2@gmail.com", "220206", "aguardando verificacao", 100);
    
