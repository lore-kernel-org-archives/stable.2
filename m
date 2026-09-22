Received: from mail-yx2-f20.google.com (mail-yx2-f20.google.com [74.125.224.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA7741D11F
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.148
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065596; cv=pass; b=VeYSX2wn65cZEph3TymdLVVG/SMDEZws/4x1P1K/tQsRlavurp14jUnZNG//7966ENOSsFKjceA/ax3JXeBDYSHZP4EZH0wI6Ck+xCgDEB0c/g4YB01qYMR5paESvLxZSB33HffDlL/QE06jTga/3FAJyWgLRF8AlLsry+eGK9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065596; c=relaxed/simple;
	bh=lvacjQG68N2xcrdqTRJ9VHj4mhfJsAvTAX68qY7zwqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdg3tCaT0xWYMa3F31SmxnjdOW25cTAPZHq4ef976V6aRMymwCfuc3Y8W+9iH98XtvrmVLFEb5Z5hFLDmp7DjtRbi6vJU9gUtcU9r8CelxWRjBJaD3NmQzddS59Rz24ozTJ/Sr1FNDdfLp/vYT4iVflfFi1ovA9sjtKTY1G0nDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHhcjsp4; arc=pass smtp.client-ip=74.125.224.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHhcjsp4"
Received: by mail-yx2-f20.google.com with SMTP id 956f58d0204a3-672c2880f58so764050d50.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 01:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790065594; cv=none;
        d=google.com; s=arc-20260327;
        b=iaKjyZKPmlASv96UbpOe2LlNKHCjv84QI+hMrlXeb2jmxypl1gB1gk97FBYK8HRu9v
         PStxWkWN9mpEz7onhMqYzM10yqCNc1Ke+Wr15j1doOq6A6qAdfqvfOsfcToengd8V6KC
         ug67Qhj65JVCeM2lIa6/rQwZ3CO2dpS1I0Sxt1jDKLBYYwjnNHHNbCx6Cunw5VwQD5mi
         PeVZCktHSjhRyzS/7KV+IeH/iyk9INkkG18UQqr7oQR7tc9XxOSxfMPQVeXuK1IH5gNR
         WjEKaA/7nod7rocIA6O3Q5dPKYb8tM1QHCVmgaTZVlTrZgQ50PyA22sefSimuyP4SDdS
         jPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=99LwW3jpXQMD0BKLN315tdPNzOGqAVo36rmxu/uCw48=;
        fh=nZ2V2xE9smRzy45DC/oL2ZTV6dBDOo5pwdHF+XdGX2s=;
        b=gIaMV4BbXvzN2Lqya9mo8b6eJzHaqnh5sbtcyvlNk7TV9gFQ8qAGOT7CMjcOTqQyFZ
         ADR5n473GmqKEMHRlI+XLL9R78DUJhOqEa0GL7JZ86L+YPB+xmQuDdeSr/oKoeOFwFdu
         rJto8es1c312fM/8qU2Slyx0xtVpBIjaWI1+GJuRgy4Falf0IoFmGPocTHyEPEbgXSdY
         WzurqbM37cgin3++VLzCNZsv5ZhvfiiQICgrmLfh2c23zLshDUySHoOSayiAD+59oKLV
         NnfVa232Rnlt0dh/S4ehVNS5AkgVntSGKd/nbbwglQMqFw0cnRCjzIrAsMoD1keMA+lB
         /kOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790065594; x=1790670394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=99LwW3jpXQMD0BKLN315tdPNzOGqAVo36rmxu/uCw48=;
        b=bHhcjsp4gEOP5ylEWN1PmBWC113BvpM4G49UlW0jHo0CR4HKz7FeKaws1/xMgYycpf
         RRMFs1Ik611/CaYKiv+NfMORhcbp/fuWxxkY6uXX+TjEFYsO5qM7YKu918wya07Nxr/Q
         K52i0ox8PVrkp/K+5kjVHjvQJ5AoZEQ+xTewGbXRyiNUjuhrLOoLVR50OigAjeTFwycD
         1+lq8kYlL85j2qwp6gDJtWhyHqtRZz3tnwADB9pUAWIUfcVwsRMqq/NTvUpSfIzdyxIL
         U5ALdrp+HrnLucIWIPwDTfAthYr+pk91m+8O9EjEGjPoPUg5nAKizKZTiGhkf9O+MwCh
         uEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790065594; x=1790670394;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=99LwW3jpXQMD0BKLN315tdPNzOGqAVo36rmxu/uCw48=;
        b=KB856OA2yznjiBs7HwvP+gTB/FVc6s1iclhEDGkcfOzUit8VmctGzb8CIEavnow7NC
         Uv9WAIy7go45KmtOFXZrT8q4uMTPbGCqhwQPT8UWOSWn0fykihKzHTt19WxJHTMT6aZh
         Y1hwy0ENQcF0HmFlOTUl5LkxHKnatAx1Zr1XpStYnxTSZ6zJg6lNhlACYrUtVFyMfw30
         RXbHzPMbXVlAqMaPS+pZWLAkHYNd8/boHnt0JkSEb03/eBMsvs5Y3JLBZdSvpF/YsKi1
         ARDbXp65dz8BQN99FTKNTDm6xFE1B9/aUZ0g2DEcTXuWC82PJLhgpJZW1KaAecpVfdAJ
         9Giw==
X-Forwarded-Encrypted: i=1; AKwUvBz4aoEohBDxEFZc78e9Ud0XkDjD3T5nPWRG9qfK4MiKDIpmUAoTBmGkCn6yQPmyjHAV+KgaVeY=@vger.kernel.org
X-Gm-Message-State: AFuF++mJIrk4Ntg1nRW9QdPG2Ilh5F4Ps0cFiABqIlX/U5B2xaYw7wQ/
	Qi1Ez+OSfrjNzAIuz8KKD88VSvtDlI5ZemdBpZaQB1fj6mfTifeDTyIiDAJaiKml6Afq3cOwqzL
	WPFXNvSgA9GkJ1vebmXP80ufTnudrMro=
X-Gm-Gg: AYBFou0uzRqGRhMk920mF6aIu2/YlyChBJ5gcE94Pqj8UETKoUW9oLwRc3M3EvP4AfU
	WjT3P7Nm/fV774+uMAXzD0JWuoJ+wVl0ZgkbYOMP5XP+OaF4CrnhIi6uF9DEeq2Pf2qSpvMP+1l
	SSbHFQZuW2xnMParfRWXeCwnBWCtG/SJVHgMCkHx5EWSsGT0Uzfgk6rljZEpalrGsLPs+CtA30g
	h+hTPaIlDtIGG0ynRHUAhTwyhZclHNTyQr2my/Ioo38Ugv0iCAvM+Xc/K4fMapCWjDKw3nWIt7z
	m1MNwRGok1QMcapP7KABlclTxOuTvw6nHe11glaUuFSfLzpoowq2smhpig==
X-Received: by 2002:a05:690e:4087:b0:671:316c:3945 with SMTP id
 956f58d0204a3-6717fc63363mr4790057d50.18.1790065593563; Tue, 22 Sep 2026
 01:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919173405.3718408-1-lgs201920130244@gmail.com> <4ca4f5c5-5021-4a63-bb14-4b7d0502eef6@suse.de>
In-Reply-To: <4ca4f5c5-5021-4a63-bb14-4b7d0502eef6@suse.de>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 16:26:20 +0800
X-Gm-Features: AcwNN1Vp1Z9Tq03Y5viAHRjjzoW0XTYRpGaxw2OWC81kqrhnlnCGwEcxNi_VTN4
Message-ID: <CANUHTR-AHqeBhiuTpoVSrGjBqpWzug2JW3npaQEv7ZDZj7q9BA@mail.gmail.com>
Subject: Re: [PATCH] scsi: libfc: fix directory server rport memory leak
To: Hannes Reinecke <hare@suse.de>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Robert Love <robert.w.love@intel.com>, 
	James Bottomley <James.Bottomley@suse.de>, Joe Eykholt <jeykholt@cisco.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hannes,

On Mon, 21 Sept 2026 at 16:48, Hannes Reinecke <hare@suse.de> wrote:
>
> On 9/19/26 7:34 PM, Guangshuo Li wrote:
> > fc_rport_recv_plogi_req() creates an rport before allocating the frame
> > used for the PLOGI LS_ACC response.
> >
> > fc_rport_create() does not add FC_FID_DIR_SERV rports to the discovery
> > rport list. If fc_frame_alloc() fails while handling a PLOGI from the
> > directory server, the function returns without starting the rport state
> > machine or dropping the initial rport reference.
> >
> > Since the directory server rport is not present in the discovery list,
> > there is no later teardown path that can find the object and release
> > that reference. The allocated fc_rport_priv is therefore leaked.
> >
> > Record when the failed frame allocation leaves an unlisted directory
> > server rport behind and drop its initial reference after releasing the
> > rport mutex. Keep the existing lifetime unchanged for ordinary rports,
> > which remain owned by the discovery list.
> >
> > The issue was identified by a static analysis tool I developed and
> > confirmed by manual review.
> >
> > Fixes: 3ac6f98f4113 ("[SCSI] libfc: correctly handle incoming PLOGI req=
uest.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >   drivers/scsi/libfc/fc_rport.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/scsi/libfc/fc_rport.c b/drivers/scsi/libfc/fc_rpor=
t.c
> > index c25979d96808..884b233c2f72 100644
> > --- a/drivers/scsi/libfc/fc_rport.c
> > +++ b/drivers/scsi/libfc/fc_rport.c
> > @@ -1848,6 +1848,7 @@ static void fc_rport_recv_plogi_req(struct fc_lpo=
rt *lport,
> >       struct fc_els_flogi *pl;
> >       struct fc_seq_els_data rjt_data;
> >       u32 sid;
> > +     bool drop_rdata =3D false;
> >
> >       lockdep_assert_held(&lport->lp_mutex);
> >
> > @@ -1940,8 +1941,10 @@ static void fc_rport_recv_plogi_req(struct fc_lp=
ort *lport,
> >        * Send LS_ACC.  If this fails, the originator should retry.
> >        */
> >       fp =3D fc_frame_alloc(lport, sizeof(*pl));
> > -     if (!fp)
> > +     if (!fp) {
> > +             drop_rdata =3D sid =3D=3D FC_FID_DIR_SERV;
> >               goto out;
> > +     }
> >
> >       fc_plogi_fill(lport, fp, ELS_LS_ACC);
> >       fc_fill_reply_hdr(fp, rx_fp, FC_RCTL_ELS_REP, 0);
> > @@ -1949,6 +1952,8 @@ static void fc_rport_recv_plogi_req(struct fc_lpo=
rt *lport,
> >       fc_rport_enter_prli(rdata);
> >   out:
> >       mutex_unlock(&rdata->rp_mutex);
> > +     if (drop_rdata)
> > +             kref_put(&rdata->kref, fc_rport_destroy);
> >       fc_frame_free(rx_fp);
> >       return;
> >
>
> Wouldn't it be better to always create an rport for the directory
> server?
> That would make the teardown path far easier.
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

Yes, that sounds cleaner.

I kept the current directory-server special case to minimize the change, bu=
t
using the normal rport lifetime would avoid this extra cleanup logic.

Do you mean adding the directory-server rport to the regular rport list as
well, so the existing teardown path can release it?

Thanks,
Guangshuo
