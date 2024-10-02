CREATE DATABASE IF NOT EXISTS infinity_solutions;

create table prompt_ia (
	codigo_prompt int primary key auto_increment,
    descricao_prompt varchar(100) not null
);

create table recomendacao_enviada (
	codigo_recomendacao_enviada int primary key auto_increment,
    fkcodigo_curso int not null,
    fkcodigo_prompt int not null,
    descricao_recomendacao_enviada text not null,
    dt_hr_recomendacao_enviada datetime not null,
    
    constraint fk_prompt_ia_codigo foreign key (fk_codigo_prompt) references prompt_ia (codigo_prompt),
    constraint fk_curso_codigo foreign key (fk_codigo_curso) references curso (codigo_curso)
);

create table instituicao (
	codigo_instituicao int primary key auto_increment,
    nome_instituicao varchar(60) not null,
    cnpj_instituicao char(14)
) auto_increment = 100;

create table curso (
	codigo_curso int primary key auto_increment,
    nome_curso varchar(60),
    turno_curso varchar(20),
    modalidade_curso varchar(15),
    valor_mensalidade_curso double(6,2)
);

create table unidade (
	codigo_unidade int primary key auto_increment, 
    nome_unidade varchar(60) not null,
    logradouro_unidade varchar(30) not null,
    numero_logradouro_unidade varchar(6) not null,
    bairro_unidade varchar(40) not null,
    cidade_unidade varchar(30) not null,
    estado_unidade varchar(30) not null,
    cep_unidade char(9) not null,
    fk_codigo_instituicao int not null,
    
    constraint fk_instituicao_codigo foreign key (fk_codigo_instituicao) references instituicao(codigo_instituicao)
) auto_increment = 1000;

create table funcionario (
	codigo_funcionario int primary key auto_increment,
    nome_funcionario varchar(60) not null,
    cargo_funcionario varchar(40) not null,
    email_funcionario varchar(60) not null,
    senha_funcionario varchar(20) not null,
    fkcodigo_unidade int not null,
    
    constraint fk_unidade_codigo foreign key (fkcodigo_unidade) references unidade(codigo_unidade)
);

create table curso_unidade (
	fkcodigo_unidade int,
    fkcodigo_curso int, 
    dt_registro_curso_unidade date,
    
    constraint fk_unidade_codigo foreign key (fkcodigo_unidade) references unidade(codigo_unidade),
    constraint fk_curso_codigo foreign key (fk_codigo_curso) references curso (codigo_curso),
    primary key ()
);