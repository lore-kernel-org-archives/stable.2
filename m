Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965503;
	b=qvSg+C5poB2v9V0VHX7y0S1hKJLeNQHovA+V7Ff/3oY8Ety7ymUa4m04OM9GvTPzo2CJ
	 zARcSpkoI/UEKVaZM+W/wsiXrKffaGc5LiPiwEim6HgnuRcLcDcaGcXINY7Ej31HY3BLT
	 DNBMYlI3HF+6WXvL7dwG+ibPP0RNI8vPUX2fbgrEv7Kux4KLOwPonUFKqumwBAjJ0fhQA
	 BpUIEFb0XGd7MFXJPwz7ZMKOFvW05fjQmiXuTbnkxrabPJe9BY2hJ1afGjK4eC/DjvLjv
	 6io3fcR+lHSijybByIWljP7LdeFxjkG1BOOUag/n4xZduvEV2zru/eo9CKBpTlU267g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965503;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kvZ3lSi6Tt2Wj33E5oFIA9PxiWNdWQfCeDMs2YC+DR4=;
	b=1EpbpC950mur6JAAEmgugB84Oe8UXVcezbvgD4sLM0LRHz/85EJPYPzhBCxCO/AitlCz
	 2IzaUvEc0fF6CnljeM7ZFnbzPgIq8/ckTufME+sKs57hu+5J8QP0nnD75NOB+X+ebOU/O
	 nyF4PTff+6rLadvDGWRujyJl2sQDyiSGwqRiOsUz0n68yiqbY6XFbuYQe5W9LWaMEOML/
	 r1+38ePnYoYXu4l3AfAgn7tVjPq7K+QdInL5jvCI80VSFlzbsPw6dGmC+SBF+7docKKxY
	 OJ3BEO7lYm1lHQAub3+waOjhW+6IxFxr8wKIOnBhty3axVECK5Y9Lrj8LQ13gi+ql+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KQxHI0dA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D149606A31B
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KQxHI0dA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF8D1F01829
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 21:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792965502;
	bh=kvZ3lSi6Tt2Wj33E5oFIA9PxiWNdWQfCeDMs2YC+DR4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KQxHI0dAJiLxxdbR4qfQm6fsrrKTOB9IG0PelY/iqQJiw5sNeUlPGnIfItTQ3U/78
	 eWWgnXjPE17D3vAyueewP2qtqIBrmTntZfkljJXGMgIJICzGDZr5QvYPHvRx/vK0t3
	 LjrNc2LoScJwzkxo6Miil34nN446FUQgXUJd3Pwmv94fLvsrpkuBmuHoeJPWqT+9OB
	 Qy/6In445T4fhu46mZtPTz+a/e9OHK8C4QMvgJRpFk6+8DzTMsqofeT9eKJbKq1iwJ
	 CxR4x818i76Khapo5Z/GceMo+HSHmxOfY2U47DwuUcF7vpa/OhL3Y4LimNWihxkTX3
	 v5bulLWMMilWg==
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1931ff67a29so5458541c88.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 14:58:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzZPTpYx+Fj7bPZRixDlziUxdS6Lp/oJ8RORTXfF4QujPUYifEF24d6h7wcuBf0qvtwsKW6eMI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOFKsm3vDun2DW3UNKFr58jBeduTw5eUU4+4HxBnxdqH3Y4KLZ
	xSHb+h3fcNzJGa/yZ5wCfZpJHY/yPPknEnIWoAMO5s01384DQQ/jXgzWThdrdqi1iXR3L47DvQI
	UtQfaZDsdwriVAMclCyEFoIRmKkAGhbg=
X-Received: by 2002:a05:7022:b90a:b0:14d:baf5:c415 with SMTP id
 a92af1059eb24-1993499de9fmr7765063c88.7.1792965502214; Sun, 25 Oct 2026
 14:58:22 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025204534.122506-1-ebiggers@kernel.org>
In-Reply-To: <20261025204534.122506-1-ebiggers@kernel.org>
From: Fan Wu <wufan@kernel.org>
Date: Sun, 25 Oct 2026 14:58:10 -0700
X-Gmail-Original-Message-ID: <CAKtyLkEoM0denNMUygkhVxrREfAjD7C6x1JKRhG+g0OXuLMsdQ@mail.gmail.com>
X-Gm-Features: AclHuK9DXVo7gzKYi3TIlVq-U2b7yv3AWnPgaGZUiil2pj-fz5cZeytCqyAm4uc
Message-ID: <CAKtyLkEoM0denNMUygkhVxrREfAjD7C6x1JKRhG+g0OXuLMsdQ@mail.gmail.com>
Subject: Re: [PATCH] fsverity: Tell LSMs about signature only after verity is enabled
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-security-module@vger.kernel.org, 
	Fan Wu <wufan@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 1:45=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> FS_IOC_ENABLE_VERITY calls security_inode_setintegrity() before verity
> has finished being enabled.  That's broken because enabling verity can
> still fail at that point, e.g. due to insufficient xattr space.
>
> Afterwards, arbitrary contents can be written to the file, which doesn't
> actually have verity enabled.  The in-core inode stays the same, so the
> LSM considers it to have verity enabled with a valid signature.  (Or
> rather, in the case of IPE, which is the only LSM that implements
> security_inode_setintegrity(), it also checks IS_VERITY(), which can be
> bypassed by enabling verity with no signature after the file writes.)
>
> Fix this by moving the call to security_inode_setintegrity() out of
> fsverity_verify_signature() and into a new function that is called from
> the appropriate places.
>
> Fixes: 7c373e4f1445 ("fsverity: expose verified fsverity built-in signatu=
res to LSMs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---

Thanks for the fix!

Reviewed-by: Fan Wu <wufan@kernel.org>
Tested-by: Fan Wu <wufan@kernel.org>
