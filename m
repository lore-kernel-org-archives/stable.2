Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175AE42087F
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 20:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783455990; cv=pass; b=PiwMxtxiL9i7ulhf6QFEjCwoQEgrgM6DD5713h8nPBcYBd1TNd2hvfcOkDNeMNvEizmOFpd9aUXFCWLPlsTAFMNkt3po9L6RjHaCTTC05WK0qxhU456zRPfFUqmWFBYjpgiZNBH7YzpL62AWPlxsBwJgGvBgsY/0EkJZt72/8C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783455990; c=relaxed/simple;
	bh=Okcmnx4iuWETJzhrDNCEP79hq9OYC+3w8fa0OQDGGyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZ/WFtfYtZ8RvjV6wDp/UszTmb/aZbJxs3yyAgV37ExBSLqLvlY/BsO5TAS8Ib66h6cIgsu8/EjtizUzhUAdWcgzX6uu92s7ThoiHUxum4XzpoPWGc8xt2Tig59y4r5tD99tsBpoq1P7GoxIxfPbF4b1kXbS72SwOZZFwSSp98o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUwTMGkf; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUwTMGkf"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39b27812c96so39322531fa.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 13:26:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783455986; cv=none;
        d=google.com; s=arc-20260327;
        b=IQGNAsfbqnjeAs/6YsrI6+6UNIQfXa/cG6YwgzRcgewLN2pTJ/627Wsg6+Cl4W+1Z7
         tZlfJlscOcnAK27M1AdQJnRBTzPnMikXlLXRVY2YM8mXiEDC0iOHykr5V0tOGKpLS1Bi
         5xhAWxmMiFQQ1avGFcHVpfERZvkapDr3/SFWL/ShP7nMnjZEbgeOraAP266xijO0lMW8
         72tFeZYbeBxxYmNeK77Yn2q8E4PbjxAVPuHUbtl+pmyhypsmSs//5y55XuooOgRdrEwD
         v2BM+Pdh7CV8iWct5s8aXTDahuRH4u01gzI3Y2wwouq7J88HavR6yJ9dNKdLBPhevXE/
         OlbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2vdqMWf3OTU2hmQJltOEb8z7E4SemE8YxCiIWickk4Q=;
        fh=5Cgkhb1Wb3e5iFzFxainyrnStiB92JUufiQaxQce/sg=;
        b=GtmGWvTGVsf8/7Emf2I3rF/CXGyGxajIkBt0X15sXkLCgCvMLH0rmt0gwHEQZn2dXK
         JaAcw45Iwbb2JhWWWFbEBoeNukHhX2Ya/uor1PzLd13E2jnkyMZOyB9ofl994fnpBbyy
         Gd/OknswIs+smN9ljVN0M0aytGvKaWJ9cIbe3wafx97UC0zAHM3T62rx7aj25y2KcH5E
         B9TykcxEFD8SP6DxtAql0h4lgUmIvOa04JQMhr8xi8uV/uyxOoMmF3L1dsXW3EMAU/qO
         AYzZMpOIEUiDoIx9uav8Xh9FlxT2Np/86qnLmJSWivROwr/OuTF7RxpFr8ddVcAhQszw
         QdeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783455986; x=1784060786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vdqMWf3OTU2hmQJltOEb8z7E4SemE8YxCiIWickk4Q=;
        b=IUwTMGkfRbsC48X3oZOsebcM+ZM5r1pt3/aw9RUKTGe8VvhBheazswwmdkNw2/zd4q
         +aCKdlLsFRzVaNnR1cUTMy6ARBwaPgHCN3Bd8WJ1TOedmBaJ7btulVubfZqpkh0jJd1y
         WYEQ4dqbhYJf2rJ++OVDRe4j4R69xNFu87vcroecqXT+6twzhG/w0Bk+NnOX2WgwNUNu
         TX2yyOcac1tY43zPtXjoXo8JW//yBDbqqI0n4f+ajG+q/r8JyfLmbPTwBHmo+LcSMj2t
         X4dgsADman4AmsDU0R7HLwEKfq53I40eAmH1qrw6bSnx+bG6nvrp11WprUFrpbAW2VjR
         vaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783455986; x=1784060786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2vdqMWf3OTU2hmQJltOEb8z7E4SemE8YxCiIWickk4Q=;
        b=NNq4l4oBAnmAIvBsrl+QsM/JjWEMLBb730kgXE/UaCxIiIHcuZVMHzICCXmJIa0MT0
         4GLKZakVNs0EXQGLZ5Q2PQzF7swyWqFVtn9wHigeleyzkMt6nknxkCuodPqNCWR/PTUy
         KHpry/q65bvQLEipWfbpKyJwNNfFcUysJrrxYexi0hFDyEVGjqsKvD35L8XZuH4Hljcb
         B5UfkqMeAPZZOhiSM0gC8FDxtjeNqemOhlacVEmcAvpHvYrub+mcDVG9AOpmVw9ht3VL
         XKnfkb/073jbdDep5zTvvqjbUSBgAKDasm9ugMjwTbFHrWDQZQRRpFKdBOwG7ooBhL0x
         1nHg==
X-Forwarded-Encrypted: i=1; AHgh+RqEmY21sZ+B2mXAFuAfsIb6bNOGwlDlqkmZtkAKUhBfI3AD5GJTzal6FMdK8rR7J5nwIjbhRt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBC7DM6wSlRVzWd8ojBOf+qCBzSYAFJB17g85ngXbMTfpsqfWn
	dtgelgtXvBkGIDvXElXKKxMrRUxsple+8wubQ4jgHGLnL3KYho8gikuhOhbV/XhxHSobgxJaNoU
	2K+URBcvjy50OinBJ0NuasYiqMh6cDPE=
X-Gm-Gg: AfdE7cnN1TkrhrFVeTgb/oXgQPHOSrIc6cSnFbxmwqjgRK7qG8BD+Pcp0QxG35pgTEV
	m+K4DQNbkGqQtGdHOFhE89kvPWU6mjO0aLqkzkZ92e3w0do8NRsuP5/Tf4MqYuUyP6URshm0BpT
	0hXhg0x89aDFkP+/gPHmkeNw+hSice95AuyuebIehY9A4+Nqso6kOHkHefnXUqGC1TOODhiF7oO
	Mcqn96cb/2CxSatgW9zpA5/nTz7oLEAjRlNnF0YnColEl64kp8afUPLkaj35KkIEw7FkwlTplNO
	/mdbTuRAMVSx4i6Clg+KDd+oteKrcSRIlb60y4LYdRZPBTST9ILGPcap
X-Received: by 2002:a2e:a312:0:b0:39b:2df2:9014 with SMTP id
 38308e7fff4ca-39c5fd6fd0fmr12640621fa.7.1783455985858; Tue, 07 Jul 2026
 13:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704160759.236249-1-meatuni001@gmail.com> <20260704160759.236249-2-meatuni001@gmail.com>
 <66b8977e-edd1-242d-1715-d5fe7f11f244@linux.intel.com>
In-Reply-To: <66b8977e-edd1-242d-1715-d5fe7f11f244@linux.intel.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Wed, 8 Jul 2026 01:26:14 +0500
X-Gm-Features: AVVi8CcdUkq0i8mQirRHfJIdYYuAkr_5uIzqk3y6EcE5X_hrh6bBIdI-08bpIZs
Message-ID: <CADqcGBmuhY1XUU3gpwJ0mPPRi2pxME=aa55nGjomtEDbAfGAXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] platform/x86: hp-bioscfg: pass validated element
 count to package parsers
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: hdegoede@redhat.com, jorge.lopez2@hp.com, Thomas.Weissschuh@linutronix.de, 
	platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org, Mario Limonciello <superm1@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

I've posted v3 of the series, which splits the prerequisite changes into
separate patches and updates the commit messages based on your review.

https://lore.kernel.org/all/20260707202111.35414-1-meatuni001@gmail.com/

Thanks for your review.

On Mon, Jul 6, 2026 at 10:57=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Sat, 4 Jul 2026, Muhammad Bilal wrote:
>
> > hp_init_bios_package_attribute() validates obj->package.count against
> > min_elements and then hands off elements =3D obj->package.elements to
>
> quoting elements =3D obj->package.elements statement in this context is
> confusing. I don't think it's usually necessary to copy code like this to
> changelog, here you can just state "elements" (which even happens to matc=
h
> the struct member's name even).
>
> > one of the five per-type hp_populate_*_package_data() wrappers
> > (string, integer, enumeration, ordered list, password). None of these
> > wrappers receive that validated count. Instead each one re-derives it
> > locally:
> >
> >   hp_populate_integer_elements_from_package(integer_obj,
> >                                             integer_obj->package.count,
> >                                             instance_id);
> >
> > integer_obj here is elements, i.e. a pointer to elements[0] (the NAME
> > field, always ACPI_TYPE_STRING). Reading ->package.count off a string
> > object aliases ->string.length in the underlying union acpi_object, so
> > the "count" passed down is not the real package size at all.
>
> Only at this point you're actually telling what the problem is.
>
> My suggestion is to rewrite this so that you start by telling that wrong
> size (count) is read and passed on by these functions (sort of summary of
> the problem). Then explain what caused that.
>
> > For string, integer, enumeration and password attributes,
> > hp_populate_*_elements_from_package() bounds its iteration using the
> > corresponding per-type ELEM_CNT constant (STR_ELEM_CNT,
> > INT_ELEM_CNT, ENUM_ELEM_CNT and PSWD_ELEM_CNT). This relies on
> > hp_init_bios_package_attribute() rejecting packages with fewer than
> > ELEM_CNT elements before invoking the parsers.
> >
> > Relaxing that check would allow shorter packages to reach these
> > functions, making the fixed loop bounds unsafe.
>
> ??
>
> You might be doing this in some later patch but then you should say
> that an upcoming patch is going to relax this check, otherwise it comes
> out of nowhere.
>
> So I think you're trying to solve two cases here:
>
> 1) Passing wrong count.
> 2) Allowing count less than what those consts define (but this is only
> needed for some later patch?).
>
> But it's so that fixing 1 ends up also solving 2? I think the changelog
> should mostly focus on 1 and then only state in the end that it also
> prepares for an upcoming change that requires supporting 2.
>
> > hp_populate_ordered_list_elements_from_package() doesn't even use the
> > count for its main loop bound - it iterates unconditionally up to
> > ORD_ELEM_CNT:
> >
> >   for (elem =3D 1, eloc =3D 1; eloc < ORD_ELEM_CNT; elem++, eloc++)
> >
> > which relies entirely on the same coincidence.
> >
> > This is only safe as long as every caller is guaranteed to hand these
> > functions a package with at least ELEM_CNT real elements. A following
> > change relaxes that guarantee to allow shorter packages through, which
> > would turn this into a real out-of-bounds heap read of the
> > elements[] array once the real count drops below the fixed ELEM_CNT
> > loop bound.
> >
> > Fix this at the source: thread the real, already-validated
> > obj->package.count down through each *_package_data() wrapper instead
>
> "thread down" sounds odd to my (non-native) ear in this context.
>
> each *_package_data() wrapper -> *_package_data() wrappers
>
> > of letting the per-type code guess at it, and use it to also bound
>
> "guess at it" sounds odd to my ear and is now even correct given your
> explanation of the problem.
>
> > hp_populate_ordered_list_elements_from_package()'s main loop.
>
> > This is a
> > no-op for any package that already meets the existing ELEM_CNT
> > minimums, and is a prerequisite for safely accepting shorter packages.
> >
> > Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> > ---
> >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c               | 5 +++++
> >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h               | 5 +++++
> >  drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c       | 3 ++-
> >  drivers/platform/x86/hp/hp-bioscfg/int-attributes.c        | 3 ++-
> >  drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c | 7 ++++---
> >  drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c  | 5 +++--
> >  drivers/platform/x86/hp/hp-bioscfg/string-attributes.c     | 3 ++-
> >  7 files changed, 23 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/pla=
tform/x86/hp/hp-bioscfg/bioscfg.c
> > index 27fd6cd215290..768330d291da8 100644
> > --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> > @@ -731,26 +731,31 @@ static int hp_init_bios_package_attribute(enum hp=
_wmi_data_type attr_type,
> >       switch (attr_type) {
> >       case HPWMI_STRING_TYPE:
> >               ret =3D hp_populate_string_package_data(elements,
> > +                                                   obj->package.count,
> >                                                     instance_id,
> >                                                     attr_name_kobj);
> >               break;
> >       case HPWMI_INTEGER_TYPE:
> >               ret =3D hp_populate_integer_package_data(elements,
> > +                                                    obj->package.count=
,
> >                                                      instance_id,
> >                                                      attr_name_kobj);
> >               break;
> >       case HPWMI_ENUMERATION_TYPE:
> >               ret =3D hp_populate_enumeration_package_data(elements,
> > +                                                        obj->package.c=
ount,
> >                                                          instance_id,
> >                                                          attr_name_kobj=
);
> >               break;
> >       case HPWMI_ORDERED_LIST_TYPE:
> >               ret =3D hp_populate_ordered_list_package_data(elements,
> > +                                                         obj->package.=
count,
> >                                                           instance_id,
> >                                                           attr_name_kob=
j);
> >               break;
> >       case HPWMI_PASSWORD_TYPE:
> >               ret =3D hp_populate_password_package_data(elements,
> > +                                                     obj->package.coun=
t,
> >                                                       instance_id,
> >                                                       attr_name_kobj);
> >               break;
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h b/drivers/pla=
tform/x86/hp/hp-bioscfg/bioscfg.h
> > index f1eec0e4ba075..416d7e7aaaae3 100644
> > --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> > @@ -401,6 +401,7 @@ int hp_populate_string_buffer_data(u8 *buffer_ptr, =
u32 *buffer_size,
> >  int hp_alloc_string_data(void);
> >  void hp_exit_string_attributes(void);
> >  int hp_populate_string_package_data(union acpi_object *str_obj,
> > +                                 int str_obj_count,
> >                                   int instance_id,
> >                                   struct kobject *attr_name_kobj);
> >
> > @@ -411,6 +412,7 @@ int hp_populate_integer_buffer_data(u8 *buffer_ptr,=
 u32 *buffer_size,
> >  int hp_alloc_integer_data(void);
> >  void hp_exit_integer_attributes(void);
> >  int hp_populate_integer_package_data(union acpi_object *integer_obj,
> > +                                  int integer_obj_count,
> >                                    int instance_id,
> >                                    struct kobject *attr_name_kobj);
> >
> > @@ -421,6 +423,7 @@ int hp_populate_enumeration_buffer_data(u8 *buffer_=
ptr, u32 *buffer_size,
> >  int hp_alloc_enumeration_data(void);
> >  void hp_exit_enumeration_attributes(void);
> >  int hp_populate_enumeration_package_data(union acpi_object *enum_obj,
> > +                                      int enum_obj_count,
> >                                        int instance_id,
> >                                        struct kobject *attr_name_kobj);
> >
> > @@ -432,6 +435,7 @@ int hp_populate_ordered_list_buffer_data(u8 *buffer=
_ptr,
> >  int hp_alloc_ordered_list_data(void);
> >  void hp_exit_ordered_list_attributes(void);
> >  int hp_populate_ordered_list_package_data(union acpi_object *order_obj=
,
> > +                                       int order_obj_count,
> >                                         int instance_id,
> >                                         struct kobject *attr_name_kobj)=
;
> >
> > @@ -440,6 +444,7 @@ int hp_populate_password_buffer_data(u8 *buffer_ptr=
, u32 *buffer_size,
> >                                    int instance_id,
> >                                    struct kobject *attr_name_kobj);
> >  int hp_populate_password_package_data(union acpi_object *password_obj,
> > +                                   int password_obj_count,
> >                                     int instance_id,
> >                                     struct kobject *attr_name_kobj);
> >  int hp_alloc_password_data(void);
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/dri=
vers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> > index af4d1920d4880..3aa2c440e0528 100644
> > --- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> > @@ -304,6 +304,7 @@ static int hp_populate_enumeration_elements_from_pa=
ckage(union acpi_object *enum
> >   * @attr_name_kobj: The parent kernel object
> >   */
> >  int hp_populate_enumeration_package_data(union acpi_object *enum_obj,
> > +                                      int enum_obj_count,
> >                                        int instance_id,
> >                                        struct kobject *attr_name_kobj)
> >  {
> > @@ -312,7 +313,7 @@ int hp_populate_enumeration_package_data(union acpi=
_object *enum_obj,
> >       enum_data->attr_name_kobj =3D attr_name_kobj;
> >
> >       hp_populate_enumeration_elements_from_package(enum_obj,
> > -                                                   enum_obj->package.c=
ount,
> > +                                                   enum_obj_count,
> >                                                     instance_id);
> >       hp_update_attribute_permissions(enum_data->common.is_readonly,
> >                                       &enumeration_current_val);
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/driv=
ers/platform/x86/hp/hp-bioscfg/int-attributes.c
> > index d96e160953e39..107e4cf1efb8a 100644
> > --- a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> > @@ -279,6 +279,7 @@ static int hp_populate_integer_elements_from_packag=
e(union acpi_object *integer_
> >   * @attr_name_kobj: The parent kernel object
> >   */
> >  int hp_populate_integer_package_data(union acpi_object *integer_obj,
> > +                                  int integer_obj_count,
> >                                    int instance_id,
> >                                    struct kobject *attr_name_kobj)
> >  {
> > @@ -286,7 +287,7 @@ int hp_populate_integer_package_data(union acpi_obj=
ect *integer_obj,
> >
> >       integer_data->attr_name_kobj =3D attr_name_kobj;
> >       hp_populate_integer_elements_from_package(integer_obj,
> > -                                               integer_obj->package.co=
unt,
> > +                                               integer_obj_count,
> >                                                 instance_id);
> >       hp_update_attribute_permissions(integer_data->common.is_readonly,
> >                                       &integer_current_val);
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c=
 b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> > index f09489a085c86..a50d074125268 100644
> > --- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> > @@ -145,7 +145,7 @@ static int hp_populate_ordered_list_elements_from_p=
ackage(union acpi_object *ord
> >       if (!order_obj)
> >               return -EINVAL;
> >
> > -     for (elem =3D 1, eloc =3D 1; eloc < ORD_ELEM_CNT; elem++, eloc++)=
 {
> > +     for (elem =3D 1, eloc =3D 1; eloc < ORD_ELEM_CNT && elem < order_=
obj_count; elem++, eloc++) {
>
> This looks like a separate fix belonging to own patch. It allows you also
> to write more focused changelog text for each patch.
>
> >
> >               switch (order_obj[elem].type) {
> >               case ACPI_TYPE_STRING:
> > @@ -301,7 +301,8 @@ static int hp_populate_ordered_list_elements_from_p=
ackage(union acpi_object *ord
> >   * @instance_id: The instance to enumerate
> >   * @attr_name_kobj: The parent kernel object
> >   */
> > -int hp_populate_ordered_list_package_data(union acpi_object *order_obj=
, int instance_id,
> > +int hp_populate_ordered_list_package_data(union acpi_object *order_obj=
, int order_obj_count,
> > +                                       int instance_id,
> >                                         struct kobject *attr_name_kobj)
> >  {
> >       struct ordered_list_data *ordered_list_data =3D &bioscfg_drv.orde=
red_list_data[instance_id];
> > @@ -309,7 +310,7 @@ int hp_populate_ordered_list_package_data(union acp=
i_object *order_obj, int inst
> >       ordered_list_data->attr_name_kobj =3D attr_name_kobj;
> >
> >       hp_populate_ordered_list_elements_from_package(order_obj,
> > -                                                    order_obj->package=
.count,
> > +                                                    order_obj_count,
> >                                                      instance_id);
> >       hp_update_attribute_permissions(ordered_list_data->common.is_read=
only,
> >                                       &ordered_list_current_val);
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c =
b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> > index 4d79eb8056a5d..89316d90454d2 100644
> > --- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> > @@ -388,7 +388,8 @@ static int hp_populate_password_elements_from_packa=
ge(union acpi_object *passwor
> >   * @instance_id: The instance to enumerate
> >   * @attr_name_kobj: The parent kernel object
> >   */
> > -int hp_populate_password_package_data(union acpi_object *password_obj,=
 int instance_id,
> > +int hp_populate_password_package_data(union acpi_object *password_obj,=
 int password_obj_count,
> > +                                   int instance_id,
> >                                     struct kobject *attr_name_kobj)
> >  {
> >       struct password_data *password_data =3D &bioscfg_drv.password_dat=
a[instance_id];
> > @@ -396,7 +397,7 @@ int hp_populate_password_package_data(union acpi_ob=
ject *password_obj, int insta
> >       password_data->attr_name_kobj =3D attr_name_kobj;
> >
> >       hp_populate_password_elements_from_package(password_obj,
> > -                                                password_obj->package.=
count,
> > +                                                password_obj_count,
> >                                                  instance_id);
> >
> >       hp_friendly_user_name_update(password_data->common.path,
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c b/d=
rivers/platform/x86/hp/hp-bioscfg/string-attributes.c
> > index fe5a9a3a4ef17..da5e81f1d188f 100644
> > --- a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
> > @@ -267,6 +267,7 @@ static int hp_populate_string_elements_from_package=
(union acpi_object *string_ob
> >   * @attr_name_kobj: The parent kernel object
> >   */
> >  int hp_populate_string_package_data(union acpi_object *string_obj,
> > +                                 int string_obj_count,
> >                                   int instance_id,
> >                                   struct kobject *attr_name_kobj)
> >  {
> > @@ -275,7 +276,7 @@ int hp_populate_string_package_data(union acpi_obje=
ct *string_obj,
> >       string_data->attr_name_kobj =3D attr_name_kobj;
> >
> >       hp_populate_string_elements_from_package(string_obj,
> > -                                              string_obj->package.coun=
t,
> > +                                              string_obj_count,
> >                                                instance_id);
> >
> >       hp_update_attribute_permissions(string_data->common.is_readonly,
> >
>
> --
>  i.
>
