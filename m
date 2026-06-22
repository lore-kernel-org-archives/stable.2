Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8557342173
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150830; cv=pass; b=VkG/w3aHgIHjfx4konjCUUQH5/W809ZDtaUtLvfVMrF/TEQO95gq8M/cszMlO4brDeWWjiUwo6AM+foUVT9nDXglMapK8hN4vVQSAj2eEJ+Go4BV8hUaFKwQlLDzwCUW2m1f9kKBzQb+dISZbXPEwGa7n7I6ZhPda63LLSf1AfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150830; c=relaxed/simple;
	bh=792JthRakdk5sbEo8g+d1nmVLBE1qYjza4D99D/L3GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkIToCq68MfWuCcl8nCmSDPTUbCU5iHuYsp5uVB8TUaaFAg8Pt2j8QrWNrk9pE6taqhwG4hJ9vV/XpQp5c6OOK53dgvNvDOHQs4q8jjsXYAAhMWBRNYyfNpv7RFAPYeaA1ZDu84lRg5B9+mTcrr3rNcqmno9yVYHUUjMJquREQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnrzrHxQ; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnrzrHxQ"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69767cb5d4aso5215239a12.3
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 10:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782150827; cv=none;
        d=google.com; s=arc-20240605;
        b=P75wp5Qk8LptxDEh2qBLkusQz12QDHjPwdpPa1AfxbEstqfQKHkRHqa+WbgXbtpvpI
         hxeF0fgQlGODsHpFGyH2Joc3cVW7LCmTNzvdN8Kjsrhl5xpmInV/FxsiGwxQXk6OVF3H
         ETA+AKG01rxBrJhe1jR01e1NTYL25AsFmHaYZ4YyVH7dYhxjG49CARpjvuHAvowhS1oK
         /Uvoa+PmsRwn/FtJ0d82sukG62xhuB2kNQ7rosnIWMJDplWKlBF9mmp82EJgXJQB0XxA
         aGdJ6PzYfFO9WyZPA83TYrgG7lQe7rm0kcXmdnP4COadCYfJOpQIyOjhPrQ6NQe/Ag6X
         TP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xWxywB8yX97dTgz4W7+C3cuW4P0X8MyukDE24mZ3+gk=;
        fh=TtxxF5ZLr4IUGSD146dL6PVjebaFaYUdPbH9CxMcxm8=;
        b=cLxYL7p4lPx6QRzJqTqV5MESF74xw+9vtSK+hBW6uvVSNU1kBSDLkavZm2RpmoHPsI
         /gXy0pgJirNGdN/fXZ6oQ/I0iJMwhkuEid5l+YiAnYNKdIJwNXU4/8RtTNzOko9QnmH0
         Rwq8YS9Jczrozn1uRayKp8fsWzhXV4eKBAp06vzxaDPTqDkW8OThmCFMsw3O5/4nQ0pv
         Vsu9XDMuIR4gIbi7qK2/jJXsxoSlzFO/VeWA/bUcfvbyPF8FZvawT46/BF7X/lw507xS
         hYq2m2LcW9vdTOLs4IHAP1AEEjsgv+OR6HTvkRfq4UhXPzpyrmU6Dc4ffbWaZjj9obue
         5O8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782150827; x=1782755627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWxywB8yX97dTgz4W7+C3cuW4P0X8MyukDE24mZ3+gk=;
        b=jnrzrHxQU4ZCqVsfPnMHcES83wfZKqap5cReGyCqbz9z/JH3Ib2VF3TOMyS5lOGPId
         t+3/cMOJpByjoo7vhP9JPzGRpE/UyJY+qF31uXXiKgk1AaMN3o63jcxXTxybOLPQ52Xp
         T3JWvp24yvXO3YuK9WojYHgtjQPeIe3lSm1zy30Pbkku+40t5L60LSZ6SGqeiJDA0Aey
         Pt0v8BJ+EfTcRqTaH4UyiJ3PuSv5dTZyx4nw2wNTZyUWFxIj9PEwle/i6pkNrcyWYFvI
         PPOf+VcPLdsPJlH4nl+bMUtZfaNace3aopN9xDAkXRlTLuHfE3zMnOeso/IYCWHuMWob
         VNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782150827; x=1782755627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xWxywB8yX97dTgz4W7+C3cuW4P0X8MyukDE24mZ3+gk=;
        b=MEV0YSLIkwq5tSr6LUPQejvGaP/YsOc9n/uuW7IWIdL8yR+6K68EnHrfU+TeShf3l/
         vDaLbPtO86ETf7LMwYJo8SSIyxk0WwLJgSXaCrX3Bg+sMECBXb3RjgaRjY1eCdqf1Pgn
         Vtr2jm91m42/1uwzDMZCVlMoRYbB0umslUo+Ou8few7f4SqLq92NeNidWw7V+KaUY6H4
         96o0Xhpr2W8Zlu82dweCpjeykaL1BPhJ7TBucsltATMzT/NaCtOqZH7EXYr6QbiwCJcu
         oxwwria8VzusNxTKTKJ/nt36Hm12V4SC9RK206LsDxsHZA2BZk70MHWOyZpP+1mmsHa5
         O7dg==
X-Forwarded-Encrypted: i=1; AFNElJ8J5Wcyn5YD/rEgbMzmMpNZ+pQUoBN3kEX6AKUy+k2KK8mI8oD1rRt8Cuo6C+VJn8cM+j1kpAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOaCKAmtJNNIXiT6tWzfLhQXp0sG3M0IULJB7HV5z9X6JAdS28
	BDf86YTIaxMVfiLu2te3gdv/WelhBpJ5OEMcuaZrOiZtmgsjgX+KJj8n6TBVRTuZPVtepJqejEl
	wCBsk4FgakGAx4bB4BVhPOOM2FwOEsrU=
X-Gm-Gg: AfdE7cmoEs+xnm4dymMbLolpwvqyBmSWntMWPaKEjG+8RkKjCBouJgJq29K2hGVR/gA
	41sINtdKUZnlEa4HNlrXTA6IFWoKkH+9wKeYammMUgBTZV51XPNyBQgiroW+446WAEXYS/JG+KO
	UCu/IZXwWBsU7JnwtAbd2sW/Jp19N/0afJqlemybozSebonhdXEOpF+D0FdZgwtqDa/dEYnJXW6
	H+Fwa3O7/hf61uKih7EQWLbWLM9H9uXRuZ2NBFFk6kmjmS81ljEdSDFROuQjA7HuCBmsnKmY2rZ
	EJ7YXGD8UI9O62rGtm4uL3q9O51/B2g=
X-Received: by 2002:a05:6402:ea0:b0:671:a18b:32b8 with SMTP id
 4fb4d7f45d1cf-696e5275851mr6985046a12.0.1782150827279; Mon, 22 Jun 2026
 10:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619120026.2630196-1-tristmd@gmail.com>
In-Reply-To: <20260619120026.2630196-1-tristmd@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 22 Jun 2026 19:53:36 +0200
X-Gm-Features: AVVi8CflF_ZPJwZiHQ-Fm5jcIlERe35O8dwHLZPmPNek-7hP-ECJ3tNgWCYTdTQ
Message-ID: <CAOQ4uxhEqS-ALvuP_YxBi=MDpF5fWOsWfgBm2BBOu+GT=d+xKQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: check fi is not NULL before calling fuse_passthrough_release()
To: Tristan Madani <tristmd@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	tristan@talencesecurity.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 2:00=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> fuse_create_open() calls fuse_sync_release() with a NULL fuse_inode
> when fuse_iget() fails. This propagates to fuse_prepare_release(),
> which passes the NULL fi to fuse_inode_backing() via the
> fuse_passthrough_release() call, resulting in a NULL pointer
> dereference.
>
> The existing comment in fuse_prepare_release() documents that the
> inode can be NULL on the error path of fuse_create_open(), and the
> fi->lock access below is already guarded with if (likely(fi)), but
> the passthrough release path added by commit 4a90451bbc7f ("fuse:
> implement open in passthrough mode") was not given the same
> protection.

But passthrough open happens after this error patch, so this sounds
like an invented problem

>
> Add the missing NULL check for fi before calling
> fuse_passthrough_release().
>
> Found by syzkaller.

Where is the report? where is the repro?

>
> Fixes: 4a90451bbc7f ("fuse: implement open in passthrough mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/fuse/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index c59452d60b8d..9b368eab159c 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -313,7 +313,7 @@ static void fuse_prepare_release(struct fuse_inode *f=
i, struct fuse_file *ff,
>         struct fuse_conn *fc =3D ff->fm->fc;
>         struct fuse_release_args *ra =3D &ff->args->release_args;
>
> -       if (fuse_file_passthrough(ff))
> +       if (fi && fuse_file_passthrough(ff))
>                 fuse_passthrough_release(ff, fuse_inode_backing(fi));
>

This should not be possible and if it were possible, this code would
be leaking ff->passthrough.

I don't know how you got to this issue and why, but if you are sending
me code fixes from an hallucinating AI agent without really understanding
and really reproducing the problem please respect my time and don't!

Thanks,
Amir.
