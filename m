Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4B755D898
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874119; cv=pass; b=n6hUTm8H+nugbvnx029pdEtsXvRq7lpFzEXme5vgkL/sIJ1nxG12aNr/U99YA6V7D+/Ql9J8wRDGOuVHEtO2Mo/WbqGo1Uta6xJlNQnd07EqISCMW+mRdB4vS3UO+xUqgkfSXLvapIeHiEkoLHOIHFjtIYCBXeyJ8CXAM6/7458=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874119; c=relaxed/simple;
	bh=XrWPQdu6aVkIEftfYKLA9OZgTitSQ0N+EPeHqgtL9RA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qu6zH2UpogsZDPAPwmGGtYNU/n0vWEiLZfNT0HvWUSbloZasmYa5u1Y+sryYHWEJDdIq3f0IzhOfTU3l7r7d73OjaOK2A8/+kb3zgbvj6dIV0Ze7fJ3IwBFQNKKupJrZqQO6qjdYw/qjlA43EhtNYzsawbsPlkkfNg2pTit/mwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDzKyIQe; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDzKyIQe"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8623e5d435cso304477b3a.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 06:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788874098; cv=none;
        d=google.com; s=arc-20260327;
        b=cvUsL+PKIzi4P8nzdnkj0YE7uydJNXJoWAomBiEHoDoE3hi95o6zt47cQcP1m2ySxT
         fv9cq2LUCrMFPHzcxbKHyyf/kC5yyJzUjvnNrXFsgJONRl+2W/th4YqXYNiogC81wlyw
         SJxq8fnPC/Dsp5svhF9MuOZJcibndleK419HCr4ryitYCoSM3EoQlhZDMBKUetBB42fH
         JgC7sUv9jcMPSUhMajZCpPN5GIkUPxSiOW75KU+F1AddhC72x+sxClLollVU1IN+kHzq
         6GUMTlHPYE77c2j4sWNe6POfxaqyEUAk+Mtsx0hbvcrBac8q8+nRvUAlu4eAaxW31UmC
         5+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JKqux52iVKTfYQy6cAyWyQ3ntl+32JLmlvNYP6anbHY=;
        fh=gMaCYE7yR9JV7nOhkLvv4kT0wDXvp5DmrDqlCExLtlM=;
        b=Jr3hsljAUmwVNREmtbAeOBEr+8BM1hcI6iJFK6Xkya8YUj0UETFq8YYk6pjNgts6wx
         MQMhF6f7H1r8fIjcX7WF+kWXEvZY1kofgp5FBjS3hqbG0fpR59cwPdEOoUiHGW8ODF4f
         joKqgZGigDUSZBZ6j+B+gKsJRC36SAR6P64dSqvLNqrjGiP8IfMELLKwRgm1Daq2Y8yV
         HFWegIgcfUHAW56Dh41fokL0ic+g2REVXgFrSaxGL0YEyzLsFFoTGrGYU0JeBs5BJqcX
         ybrhZO9sCbnIHG2SOmQnV2FW18AeoUriEN65rrj3MTSdkAHBJ8HYskLK7DmfMf9cywSp
         Z1Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788874098; x=1789478898; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JKqux52iVKTfYQy6cAyWyQ3ntl+32JLmlvNYP6anbHY=;
        b=GDzKyIQe6gkTpY6dg7Tc7eMqvtKCONPfezqQzQ5kSDS69CAoCuxI+JOe9Ujb/wFLW4
         NNv+wf/qu5jdSqGH7GT5mO72kF2aRTO2AuMqtrXHH7wlTZ4+aSuFaIJWNgQUXuAMYx7L
         UOXdcc7cxtrl+qMW51cYjvQYfA/iqjn8lj81IVJQxRjJq1gfEBFvoqh+lJXly7YKFn31
         tKPwVvmvAVxONDj/w2fFNezBOlbgpMWRrSC6k0kPaKxjvM9ePRZMOPaXiM8t3LZzy41R
         //xbVtYL4P+kxfcx0gk3zPTtdLqVTnyxH1f72xn30RhM3jKP1qExiEcevXkcF6slhrMp
         xLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788874098; x=1789478898;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JKqux52iVKTfYQy6cAyWyQ3ntl+32JLmlvNYP6anbHY=;
        b=qgHyzwsSgk/1RQLTTovZTLM3k9PBJEZoB/1jGw2gQKdIDAEzljRl6ecepCrKQTcO7r
         Oc3ssAA5qGkI26B64Ux8eQpKNP/RQ0oMYxPCN2uXCJT7n9UArYMQnIHLuwmi4XpAzuAG
         5kaNq7doAjBrg/U5QIYitY/j/2TJu8Qy1EOWPSoYuFKbcjfpf7Wta95f2DMhZJL2rY4r
         1LIVfhrqsDuACcsJ6FxA0Gm3mpiARzxGs3lVVJKXg8FvNwlmEyFN5gLxWloQTXm8El2u
         CeinLin2q/H8+oQDrChJEMhkb4erHvR+wTdtegtrsOYibCqFI260GajeUaxpTyoIQKQy
         HygQ==
X-Forwarded-Encrypted: i=1; AKwUvBypldPMdT6r6yvw3DldWEVx+kcUz97bmq/RddC1odzpBDuHuMB6fbFqLKG5Lwglxg/S5F9Ijrc=@vger.kernel.org
X-Gm-Message-State: AFuF++ku0L0qkfOqmIeV9KonxmeE57nrAY+p8fQ6q8eAzY7AkVN4dYVC
	qxPwpyLdP4odHFUL9xbWyrxQMTyLG3kHxCXtowl6cl7yim+90KmsHJJ+RyGCGYoIYHJ70/ucYjC
	S0pYBdwqmsf/1RI1DMxs7xu/lHTmTcrQ=
X-Gm-Gg: AYBFou3Sr2nyA+ousjL1H7qCNA511GpenX2Wv3v6M4KxJz5Jr86UuF0+aPFJikk5Da0
	q7lpWQnx6Af5P5jq8ASdV6deJQoHEHa1eGdUBm3eiZ+LxwU2hn3wg6Z7DkncEA0yqih4kdi7PKV
	8j3enTmdXC38pGsMl/BaUJis0cJlAq7NY0EVebhxH72KhHgA4eiLWn6bnLL4IB0LABBGDqFhMod
	TrXMpndLT+/tBLQcE3eE36o0UjbCNI4twmeClNzgXDegCJ84bY4zXd2/S6njzjnymcGOrZH5Hrm
	vSGmauM2cqKq6A8Rssdo4bp7WSBqugk1lkGjObM8xXIuO19qLMYkt2Wv
X-Received: by 2002:a05:6a00:1395:b0:84e:cd14:aeba with SMTP id
 d2e1a72fcca58-86698fe1ea8mr6346255b3a.6.1788874097889; Tue, 08 Sep 2026
 06:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907151428.643841-1-adrianox@gmail.com> <ap-4khETBju3X8-T@hovoldconsulting.com>
In-Reply-To: <ap-4khETBju3X8-T@hovoldconsulting.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Tue, 8 Sep 2026 10:28:06 -0300
X-Gm-Features: AcwNN1UwNNi1uUL8ZrK4YlYg6vVWK6_rZXfk738aK_31iCexOOmSxAgWI8zqjXg
Message-ID: <CAMGU2hXrURUh3NknkgLnmyiJiEwEqZdDz3Ujy5tO8oqVMD9OJw@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: fix use-after-free in vub300 teardown
To: Johan Hovold <johan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 8 sept 2026 a las 4:26, Johan Hovold (<johan@kernel.org>) escribi=
=C3=B3:
>
> On Mon, Sep 07, 2026 at 12:14:28PM -0300, Adriano Cordova wrote:
> > Do not dereference mmc/vub300/udev after the final kref_put, because
> > it can release them via mmc_free_host()/usb_put_dev().
> >
> > Fixes: 8f4d20a71022 ("mmc: vub300: fix use-after-free on disconnect")
>
> This commit reverted a buggy change so if anything is broken here, this
> isn't the commit to blame.
>
> > Reported-by: syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com
> > Link: https://syzkaller.appspot.com/bug?extid=3Df312381a95cc080992fd
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
>
> Are you missing an Assisted-by tag?
>
> > ---
> >  drivers/mmc/host/vub300.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> > index 2dae474dcd06..a1a6aa1aafdb 100644
> > --- a/drivers/mmc/host/vub300.c
> > +++ b/drivers/mmc/host/vub300.c
> > @@ -370,13 +370,14 @@ static void vub300_delete(struct kref *kref)
> >  {                            /* kref callback - softirq */
> >       struct vub300_mmc_host *vub300 =3D kref_to_vub300_mmc_host(kref);
> >       struct mmc_host *mmc =3D vub300->mmc;
> > +     struct usb_device *udev =3D vub300->udev;
> >
> >       usb_free_urb(vub300->command_out_urb);
> >       vub300->command_out_urb =3D NULL;
> >       usb_free_urb(vub300->command_res_urb);
> >       vub300->command_res_urb =3D NULL;
> > -     usb_put_dev(vub300->udev);
> >       mmc_free_host(mmc);
> > +     usb_put_dev(udev);
>
> This makes no sense at all as the driver data is freed by
> mmc_free_host().

mmc_free_host() only frees mmc (struct mmc_host) and vub300
(struct vub300_mmc_host), but the udev (struct usb_device, linked
as mmc->parent) is not freed by mmc_free_host() and has to be
freed separately.

But it cannot be freed before mmc_free_host(), because the kobject
cleanup code of mmc_host accesses it in mmc_host_classdev_release()
via host->parent->of_node.

>
> >       /*
> >        * and hence also frees vub300
> >        * which is contained at the end of struct mmc
> > @@ -1794,8 +1795,8 @@ static void vub300_cmndwork_thread(struct work_st=
ruct *work)
> >                       construct_request_response(vub300, cmd);
> >                       vub300->resp_len =3D 0;
> >                       mutex_unlock(&vub300->cmd_mutex);
> > -                     kref_put(&vub300->kref, vub300_delete);
> >                       mmc_request_done(vub300->mmc, req);
> > +                     kref_put(&vub300->kref, vub300_delete);
>
> This order has been here since the driver was merged.
>
> >                       return;
> >               }
> >       }
> > @@ -1946,8 +1947,8 @@ static void vub300_mmc_request(struct mmc_host *m=
mc, struct mmc_request *req)
> >                   satisfy_request_from_offloaded_data(vub300, cmd)) {
> >                       cmd->error =3D 0;
> >                       mutex_unlock(&vub300->cmd_mutex);
> > -                     kref_put(&vub300->kref, vub300_delete);
> >                       mmc_request_done(mmc, req);
> > +                     kref_put(&vub300->kref, vub300_delete);
>
> Same here.
>
> So if this is wrong (it does look suspicious, but this driver is just a
> mess) then that's the commit to blame.

Hope is more clear now, it makes sense to me, and I think the Fixes:
tag is right.

>
> >                       return;
> >               } else {
> >                       vub300->cmd =3D cmd;
>
> Johan

Best,
Adriano
