Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D73F37DAB1
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788623364; cv=pass; b=SE8cby4aWyxhiUQiLoN0YulK/0vxIr4qdgeTR9QrVfbjByvNn74Wh5yohNJQF3cpReRxUZ7qZPcGRbeUez+MobIUB4RQ8cg1yZiv58njTaQxBLlZmtge1Eu3G27EKE6+v+OVOMIug7SGwK7TbxQOD3nXozfyY+OXmpm1UsZ5OLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788623364; c=relaxed/simple;
	bh=2LwFOMHYcHPNL5fcYnEFfP+h7yQAgL85lT+A0zfsnu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kByPZKVyaWvZ7vVok21gzdk2dOidZf+qSw3um8UC+hGM+kQcVWzIo/u+G+YoFdIGcrHAT71SEATzdAAv4LGQV1Sa/7iLnc5OtdHSye9+NJiiQ2N6blRUbus5IcG4oUgc50GZDU4fIkIz144XKKxXoj2uEqNTndPdyyfZs0WTiJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Cc2KkhV1; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Cc2KkhV1"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3a309f92daaso18426811fa.3
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 08:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788623360; cv=none;
        d=google.com; s=arc-20260327;
        b=DwtcIohJ5gZnWDDVhcMXH1WWo/lERIJxR86uvVK7ZEoSIVLrvQcpkKesSC+htsl5D5
         ZMBPwXLV36e1HFoT+uzroid8nUFlvhNodDw2zKLJQ0zFaGYo7BItt5TuSE/miClL/+cv
         br4g5ilGj9VBiZF/n1YC+YqHM94O5UHDKxzqsVUOuWlPhX52gAW8Fy0RCpYUwtLpmg+K
         r2bapeAb97fX0XBMH+SWN7XtYQ6Yb1ZmrDAYcOq9wo9TNvhYIFejiQNDwxMentUiUU3O
         qFPxDr3dLoHou7VdbWGNKtb11na1bNHnVB91EFnu/+U5RCCNckmdH7ScbHaV9ZKQz/GZ
         mhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7P80H4tHjRKtSyI0SMuxw7P27fwaqKXH5g+cij3jlRc=;
        fh=gXaquLJ+J3FTjw3mGna0V38peaC2ppwslB0EAr9UkIE=;
        b=IaKpiHjDtqlvgerID5GbVvSxNC5O68INVi+zDGL+9q/xcgiANBMfsgzpa6zc9RDpxA
         jRWzz5ZlCl1IOstPV/0cQSD1p5yQOxKxsPFwMDt6JUkLxwOHD3fP4bFo2+wmjqGLRokW
         hqzAWu4LgD/b82gDdptJhoAeZoNgR1KURW65PKYJBPVGBVM3JU8J/f1i1IbvT0uGy/yX
         HEomn8Isab1wIlhtyz+TcfWqhD1lBSn0ndM1y/VmrsIJCdc2ws5j3M869OfiRLYheARn
         D2PHxaU3grRV5BAZ8A5nDX9eks+xPlP4nEo5s3WGK+1hvFxCGWVTyia5oGwnpASOHZ59
         uI3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788623360; x=1789228160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7P80H4tHjRKtSyI0SMuxw7P27fwaqKXH5g+cij3jlRc=;
        b=Cc2KkhV1j+/18WC5hFEIUMGnWkUluvOifIbnfB/BiExKK1a0NeQB9NP8P1nWLvIRqQ
         T2rfWqbjnNniAmkm2sqnP0aRl9XQx+qxFtXty1LjzrShELKmiELlQmgIn5PsuNsFzXqp
         Av/1e0AOe/tuyKe8apb9iB5ALThFvoPyIy9Go2huNDRTm779l0Nn/NRDVJyXBfHJ1BrP
         7oFSUW1UhMXgx7OFyEAY1PxAPsoL11yEy6CLxxUwZ8EzoDCD3gf6T8qF8j+6JL5dUKWX
         1w4K6nzf+UGqrx0iOQBSgpW5DJq44zfnIigafTokLeFpYrZJEXAbbJdQBSYbjahwZCrl
         7tXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788623360; x=1789228160;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7P80H4tHjRKtSyI0SMuxw7P27fwaqKXH5g+cij3jlRc=;
        b=IQpgYHKhLyNzlnqaePw3sgSIubdJL8RTj1jeWgt8haJP5FbpNq59vkpllOhyyuWeNW
         yMzwVMe9o4MYBp+b6hEJpPBYJ1c581KhLrzL28/1pX6r6PydtlduuYSVqGrHo4DLcm3f
         m+/itq5wJoBefdYrm4YQRhhDRzlWcUzp67ndAJZGnJjGtH5kLOiOVSMde+Cp+70rh9iG
         KO5sK5IhtHYA66mPAFhHXfkZ+OY53XI1+t9sJtVmQNMKQX+DM0Wj/kl2tGzeTVChEab8
         PTKc70kL+bdw91OGy5bGUZRiEt0c3UuifxjGwEY1COQVmAnYCAPPk6Ehk3CuM/X5STPX
         0d/A==
X-Forwarded-Encrypted: i=1; AKwUvBy4JDn4HkMedw68I9Cva9UtLHtN1NDTwoizM10AvgjCbZfV1NY6DHKJDRNxPV6W298DvtSRxgU=@vger.kernel.org
X-Gm-Message-State: AFuF++k0RhnLOaSYbuILVEVmPsZ6u+FwWK75DRM65oPp9AGpnpWH+DWn
	U0Aq4dEpLHIPDwb7u2R3Jahkh2kA+UhuGUbQKdOrSx0cbQmjJtxcZvtjOfdIuESoKFpPTv6QTmp
	Jh4kymo/ewtXXJlj0FI6HJNGkjHgntsv8dSOiXtOdPas=
X-Gm-Gg: AYBFou0msYZ8VArD9tbweVjOatV173XZ8P5jr4VLxp2s5s/knzgxMzLmQPXV+Oh/C5C
	VyNNim1FBCUUvCqgVsQnC3Yb9c74P9AoIYkQ/DYr9eGcCoIdxCBLukNJdUk3P0jTtNnI6zykGvy
	F6rUMRLxOQKHgtHplLb1T/oMtfcBfOyMi8SXL8GCdOO4Ea2Bug75mO6f0F+zHXYPMRNDVVGCFWa
	T4ojmS5aW0IPwM7du6AuKf/6dZ/SMR20FLR++60X8UHmtLSPW/VhKIJRuVfG3QypadL1xpm3/bs
	dqyMfzrd/82dh/PZtmY4BbaN/EDW3xgRmNmA7FiaLXTRFZ9YylZuK5JXXTFeXyzJ8ESBt+Lddt4
	=
X-Received: by 2002:a05:651c:19a9:b0:3a1:b1e4:419c with SMTP id
 38308e7fff4ca-3a371baf690mr14631721fa.10.1788623360266; Sat, 05 Sep 2026
 08:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <133b6aee9e2c908c9da37d5585b3d2cd016906cd.1788187473.git.zihanx@nebusec.ai>
 <20260905151227.75099-1-horms@kernel.org>
In-Reply-To: <20260905151227.75099-1-horms@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Sat, 5 Sep 2026 23:49:05 +0800
X-Gm-Features: AcwNN1UcU-1X1BFtOnvDk5MJ1fV5cvayGVe7JghclzXcqqZSvXM9lAAOeXUWdos
Message-ID: <CAANe3eRpVGnYpygfiQTsXd2VmBO43P-P1RfREkdDypgXBZB9Uw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] udp: diag: bound bucket lock hold time
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xemul@parallels.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 11:12=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/#/patchset/133b6aee9e2c908c9da37d5585=
b3d2cd016906cd.1788187473.git.zihanx@nebusec.ai?part=3D1
> ---
> udp: diag: bound bucket lock hold time
>
> This patch limits the time the UDP hash bucket spinlock is held during
> netlink socket dumps by collecting a bounded batch of matching sockets.
> It takes a reference to each socket, releases the lock, processes the
> batch, and resumes from a preserved cursor.
>
> > diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
> > index f4b24e628cf8d..18cfe0df654dd 100644
> > --- a/net/ipv4/udp_diag.c
> > +++ b/net/ipv4/udp_diag.c
> [ ... ]
> > +static void udp_diag_dump_done(struct netlink_callback *cb)
> > +{
> > +     struct inet_diag_dump_data *cb_data =3D cb->data;
> > +     struct sock *sk =3D (struct sock *)cb->args[2];
> > +
> > +     if (sk) {
> > +             cb->args[2] =3D 0;
> > +             sock_put(sk);
> > +     }
> > +     cb_data->dump_done =3D NULL;
> > +     module_put(THIS_MODULE);
> > +}
>
> [Severity: High]
> Does this module_put() introduce a race condition with module unloading?
>
> When an active netlink dump for UDP sockets finishes, inet_diag_dump_done=
()
> invokes udp_diag_dump_done(). This function drops its module reference us=
ing
> module_put(THIS_MODULE) as its final step.
>
> If this was the last reference, a concurrent rmmod udp_diag operation can
> proceed and unmap the module's text segment before the thread executing
> udp_diag_dump_done() executes its return instruction to return to inet_di=
ag.
>
> Could this result in a kernel panic due to the CPU attempting to execute
> unmapped memory?

Yes.  If that module_put() drops the last reference, rmmod can unmap
udp_diag while dump_done() is still returning to inet_diag.

I will keep the extra module_get() in udp_diag_dump(), and move the
matching module_put() into inet_diag_dump_done() so it runs after the
callback has returned.

v2 incoming.
