PGDMP      5                |         
   railway_db    16.2    16.2     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16468 
   railway_db    DATABASE     ~   CREATE DATABASE railway_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE railway_db;
                postgres    false            �            1259    16469 
   body_parts    TABLE     �   CREATE TABLE public.body_parts (
    serial_number integer NOT NULL,
    name character varying(100) NOT NULL,
    manufacturer_code integer NOT NULL,
    production_date date NOT NULL,
    amount integer NOT NULL
);
    DROP TABLE public.body_parts;
       public         heap    postgres    false            �            1259    16472    braking_equipment_parts    TABLE     �   CREATE TABLE public.braking_equipment_parts (
    serial_number integer NOT NULL,
    name character varying(100) NOT NULL,
    manufacturer_code integer NOT NULL,
    production_date date NOT NULL,
    amount integer NOT NULL
);
 +   DROP TABLE public.braking_equipment_parts;
       public         heap    postgres    false            �            1259    16477    chassis_parts    TABLE     �   CREATE TABLE public.chassis_parts (
    serial_number integer NOT NULL,
    name character varying(100) NOT NULL,
    manufacturer_code integer NOT NULL,
    production_date date NOT NULL,
    amount integer NOT NULL
);
 !   DROP TABLE public.chassis_parts;
       public         heap    postgres    false            �            1259    16480    maintenances    TABLE       CREATE TABLE public.maintenances (
    id integer NOT NULL,
    date date NOT NULL,
    status character varying(100) NOT NULL,
    empl_contract_number integer NOT NULL,
    body_part_number integer NOT NULL,
    chassis_part_number integer NOT NULL,
    st_device_part_number integer NOT NULL,
    br_equip_part_number integer NOT NULL,
    railroad_car_number integer NOT NULL
);
     DROP TABLE public.maintenances;
       public         heap    postgres    false            �            1259    16483    railroad_cars    TABLE     �   CREATE TABLE public.railroad_cars (
    serial_number integer NOT NULL,
    railroad_car_type character varying(100) NOT NULL,
    malfunction_type character varying(100) NOT NULL
);
 !   DROP TABLE public.railroad_cars;
       public         heap    postgres    false            �            1259    16486    shock_traction_device_parts    TABLE     �   CREATE TABLE public.shock_traction_device_parts (
    serial_number integer NOT NULL,
    name character varying(100) NOT NULL,
    manufacturer_code integer NOT NULL,
    production_date date NOT NULL,
    amount integer NOT NULL
);
 /   DROP TABLE public.shock_traction_device_parts;
       public         heap    postgres    false            �            1259    16491    station_employees    TABLE     �   CREATE TABLE public.station_employees (
    contract_number integer NOT NULL,
    full_name character varying(100) NOT NULL,
    contact_info character varying(100) NOT NULL
);
 %   DROP TABLE public.station_employees;
       public         heap    postgres    false            �          0    16469 
   body_parts 
   TABLE DATA           e   COPY public.body_parts (serial_number, name, manufacturer_code, production_date, amount) FROM stdin;
    public          postgres    false    215   �*       �          0    16472    braking_equipment_parts 
   TABLE DATA           r   COPY public.braking_equipment_parts (serial_number, name, manufacturer_code, production_date, amount) FROM stdin;
    public          postgres    false    216   L+       �          0    16477    chassis_parts 
   TABLE DATA           h   COPY public.chassis_parts (serial_number, name, manufacturer_code, production_date, amount) FROM stdin;
    public          postgres    false    217   �+       �          0    16480    maintenances 
   TABLE DATA           �   COPY public.maintenances (id, date, status, empl_contract_number, body_part_number, chassis_part_number, st_device_part_number, br_equip_part_number, railroad_car_number) FROM stdin;
    public          postgres    false    218   �,       �          0    16483    railroad_cars 
   TABLE DATA           [   COPY public.railroad_cars (serial_number, railroad_car_type, malfunction_type) FROM stdin;
    public          postgres    false    219   �,       �          0    16486    shock_traction_device_parts 
   TABLE DATA           v   COPY public.shock_traction_device_parts (serial_number, name, manufacturer_code, production_date, amount) FROM stdin;
    public          postgres    false    220   �-       �          0    16491    station_employees 
   TABLE DATA           U   COPY public.station_employees (contract_number, full_name, contact_info) FROM stdin;
    public          postgres    false    221   M.       2           2606    16495    body_parts body_parts_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.body_parts
    ADD CONSTRAINT body_parts_pkey PRIMARY KEY (serial_number);
 D   ALTER TABLE ONLY public.body_parts DROP CONSTRAINT body_parts_pkey;
       public            postgres    false    215            4           2606    16497 4   braking_equipment_parts braking_equipment_parts_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.braking_equipment_parts
    ADD CONSTRAINT braking_equipment_parts_pkey PRIMARY KEY (serial_number);
 ^   ALTER TABLE ONLY public.braking_equipment_parts DROP CONSTRAINT braking_equipment_parts_pkey;
       public            postgres    false    216            6           2606    16499     chassis_parts chassis_parts_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.chassis_parts
    ADD CONSTRAINT chassis_parts_pkey PRIMARY KEY (serial_number);
 J   ALTER TABLE ONLY public.chassis_parts DROP CONSTRAINT chassis_parts_pkey;
       public            postgres    false    217            8           2606    16501    maintenances maintenances_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.maintenances
    ADD CONSTRAINT maintenances_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.maintenances DROP CONSTRAINT maintenances_pkey;
       public            postgres    false    218            :           2606    16503     railroad_cars railroad_cars_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.railroad_cars
    ADD CONSTRAINT railroad_cars_pkey PRIMARY KEY (serial_number);
 J   ALTER TABLE ONLY public.railroad_cars DROP CONSTRAINT railroad_cars_pkey;
       public            postgres    false    219            <           2606    16505 <   shock_traction_device_parts shock_traction_device_parts_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.shock_traction_device_parts
    ADD CONSTRAINT shock_traction_device_parts_pkey PRIMARY KEY (serial_number);
 f   ALTER TABLE ONLY public.shock_traction_device_parts DROP CONSTRAINT shock_traction_device_parts_pkey;
       public            postgres    false    220            >           2606    16507 '   station_employees station_employee_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.station_employees
    ADD CONSTRAINT station_employee_pkey PRIMARY KEY (contract_number);
 Q   ALTER TABLE ONLY public.station_employees DROP CONSTRAINT station_employee_pkey;
       public            postgres    false    221            ?           2606    16550    maintenances body_part_number    FK CONSTRAINT     �   ALTER TABLE ONLY public.maintenances
    ADD CONSTRAINT body_part_number FOREIGN KEY (body_part_number) REFERENCES public.body_parts(serial_number) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 G   ALTER TABLE ONLY public.maintenances DROP CONSTRAINT body_part_number;
       public          postgres    false    215    218    4658            @           2606    16560 !   maintenances br_equip_part_number    FK CONSTRAINT     �   ALTER TABLE ONLY public.maintenances
    ADD CONSTRAINT br_equip_part_number FOREIGN KEY (br_equip_part_number) REFERENCES public.braking_equipment_parts(serial_number) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 K   ALTER TABLE ONLY public.maintenances DROP CONSTRAINT br_equip_part_number;
       public          postgres    false    218    216    4660            A           2606    16555     maintenances chassis_part_number    FK CONSTRAINT     �   ALTER TABLE ONLY public.maintenances
    ADD CONSTRAINT chassis_part_number FOREIGN KEY (chassis_part_number) REFERENCES public.chassis_parts(serial_number) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 J   ALTER TABLE ONLY public.maintenances DROP CONSTRAINT chassis_part_number;
       public          postgres    false    4662    218    217            B           2606    16575 !   maintenances empl_contract_number    FK CONSTRAINT     �   ALTER TABLE ONLY public.maintenances
    ADD CONSTRAINT empl_contract_number FOREIGN KEY (empl_contract_number) REFERENCES public.station_employees(contract_number) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 K   ALTER TABLE ONLY public.maintenances DROP CONSTRAINT empl_contract_number;
       public          postgres    false    4670    221    218            C           2606    16570     maintenances railroad_car_number    FK CONSTRAINT     �   ALTER TABLE ONLY public.maintenances
    ADD CONSTRAINT railroad_car_number FOREIGN KEY (railroad_car_number) REFERENCES public.railroad_cars(serial_number) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 J   ALTER TABLE ONLY public.maintenances DROP CONSTRAINT railroad_car_number;
       public          postgres    false    218    219    4666            D           2606    16565 "   maintenances st_device_part_number    FK CONSTRAINT     �   ALTER TABLE ONLY public.maintenances
    ADD CONSTRAINT st_device_part_number FOREIGN KEY (st_device_part_number) REFERENCES public.shock_traction_device_parts(serial_number) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 L   ALTER TABLE ONLY public.maintenances DROP CONSTRAINT st_device_part_number;
       public          postgres    false    4668    218    220            �   ~   x�-���0kj
/���D�%�Į� .2C51��E26���Sa��/8�H4e#e͑-J!a:�|���'��L8|��lI.#Gʗ`�w'~��䋯��:%���R�}A,�o!�?T�9�      �   �   x�m���0�r4`��Cz���&!��p�0|@i�Ӟ�#
�Ж5�qGW���zNo���H�W���p�-)��U}H�L�\��Up�a�ҟޒ����Z����/vB�z��Ĕվ�t3���9���f�      �   �   x�����@D��*h`�����$p�ȁh!B	��$-�;�9!$�e��i4y1�b�pÀ��1��q���1��5��vZ�8�sq9Q�Y�$��$Q�D��d%���Y����@۪�̜Y"3q���wn�\VKu�[���?t�      �   Q   x�%���0���, �]*�0L�a v�VH6�R-K~Bc^������߸�G��]H�R)L�d@��cf�fI�MU�^      �   �   x���;�0D��>r�Hw�0�HP��@��6�D&Q�fo�lh(�X�ݙ�c��m�\��� �T����h9zb�D��-�꛸�,E+5f����ј�K���a/R��,o�xž(:ދ�(\��]/Ӣ�	!��� 'K����`���$G���ů�r�e1X
��
��0� m�1�|,���      �   �   x�=���@D��*����y��b"	�#�� 65�;�$K�5Ҽ��I�+�u_�X�c�N�U�L����2�u��B�5�M���JT9�AsFT�s��ٺB�6w&�׆�[�����0��#�-�Jl�;c�jcP      �   �   x�MOI
�@<g^1/3c4��/���077�,(x�"J`��j~d�h�����j!\)+���������?��kG����P�zID�����ppK�/�pp�K;��9�T\��	�9ͨ�� �:�v�K e��dO���Wd����¯���I���/IR��Ev	�W;B�H�	��c��>fD�����H��{-5�     