Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53383DFC80
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 19:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672776; cv=pass; b=PLXEqt1Lombmlw90NGihkzmMPoRPkNrFaZhbTzF7GmLDeLHufxxg97rPVr6KZq28oPwpC08go7fLCdZvnLjgyUgTO3IPmFFx2oBAEu+cgvbkjB0hcYO6/z7iq+5psBhlxioLA8GVnNFf/w2HAIamGaJ/tYwTlUtXQcjNhU0uAlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672776; c=relaxed/simple;
	bh=vg/HnBjL6ui8rIqhl2mHTCgUWM64HScF5/iWIe/ShIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfvxfHLUpOyyY+MSbA8lb1ww8FnUukr8mEhrYmAp53Oiv0vgtYbctkqQQKE5/pNnOESM42GUL9n8fmX27LQQdrBBW8U3auzvfJDFytiljNbUYBXoHJPJ9+tcsg4GgUrGkd5x/bz78fMxCXf7TxOY1J9F/W74Ja24CJfvJjdv3UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=nLybyOiJ; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="nLybyOiJ"
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C5C4F3F98E
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 19:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1789672766;
	bh=9ZQkQJ8DBmzRmP+IXbsxhfErJtZ6ER/ycldjmLcGGe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=nLybyOiJ7SKhwDnpnmvhMCEFIaInDvUq8COaa8Wp+wRRI4aOKLDA+6lnwYzawaCj0
	 LkF3zgmWRAgiG5ZOkoCJav5IlSDycklo3IyplmPXxmisalPOVcreZibfdoe+fNSjgK
	 7BcebBbr5R6XlMUJ9BJa+yI8eSLSOyS91NyC8yOv+HALineqoU2m16mkWmy7t1BoQf
	 cF/fI9WEomcqcXhKjhvHUgQQ1apEfSgizZF01mc33DYOeh3uEAqKP2qwvJkaioVJ4y
	 fHBI0nfp2UYZSG1QYzrc5P0leByRPN92yIfCqLZ+pO09ecMx0Q47qdctZ0tAB8dv3Z
	 febwGU8Kmz0AOeBUyXSZF+8Vtp+SMkTlC66xBIrCcaBZYc3OvZxbpv7ARCgn8apbFb
	 4ADmgxLS1HTkh6V8OI3mMxWlmPxvtxlCTwpPpV8h+ati2+k5fqCc6Ua/DcdTHfcKbs
	 mIFa6F7S4vu4NkZG5qYnB30mMx1X+5FdXL8aVu9ZwYzr2Ke/cWow1WbEsfUpugvLgw
	 V4g7hTYvTwvxrBFqfT8eM7pGYJjKOzjNOpRN9O3AAUVbL0/9pK5Ook5QxwBGOGlmhC
	 +baUGAsZQZKxIx/TJDIezTUUfAVEuYPPQD3sPht9ZfQtLI8DcEXZEsGazpGvKex0+B
	 A/q/Hl+hZC+43aAv2s2NrNY0=
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c29386c5fd0so166879866b.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789672766; cv=none;
        d=google.com; s=arc-20260327;
        b=Y0XKiOXLdFQeO3XFjWO1PbiVIxuOCDcL6D39W3VDInFAPZX2pvBBNxTiBSfeB3OKeU
         hWL5bj3oVSFD7JOAJKAvDEZ7DrIr+3kYvR6CQ7C9tVC0FlHpqEFdrcuDJhGyN11/d1JO
         iQNd/2X0hHuWscvUhh0Tzr/2O/g/U4U4w92VLOmwAPgW8MbkWn/e0rdXVoR8cdSePvTY
         4Fl2ttgaewHEhSHvbo9cm78Ns2nAtaXLe6GdhkMlmnecCeQ9tccmS7gbNFVgjGaBgJAk
         yM1cUGc9gW693WuVCO8qnUtX/+yNv1iKEwW2N78TMsf9etnWcUu5m0e6okZfuJzepwUn
         fzww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=9ZQkQJ8DBmzRmP+IXbsxhfErJtZ6ER/ycldjmLcGGe8=;
        fh=/16Sz1MZITUUhpPjv/3QHq8mz9DDeknu65erElxycPo=;
        b=cY7yeBUYMagNiDjpMkEFxrTDwHsUFYaqrTPFFCq4E/g/+dPZnwtV9ngjgihUixYnu3
         pBno1iSW47vlsLfG9+iqSV3PsFXRKKAdiH5ScUzCnERyiqjGU0CEboe/axicts1iQ0kx
         w796y1n4VcPC2C/fp0iUj9ZpcSa3BwhVZoFYpeRbFYMQLKi4mbrRpN+rzxjRtV0es8W+
         L1SaFF0liRKIS86+j5Abbgg9KtZLYmDusI74iX6dSfx6wSepeNpztPj5SDpkpiOas10+
         IoqYXC5jOT2ltSqfpzbKwxIWq3j7aQXMXA0XVMh/+qwWqrkNWthMPYB3Z8PP8PhSb5nG
         aU9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789672766; x=1790277566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ZQkQJ8DBmzRmP+IXbsxhfErJtZ6ER/ycldjmLcGGe8=;
        b=Sp3N3OJTq+e5GZt/KBS2rqpSfLtn+G/Z80KI/bcOtbDx5RjstRT+NK9AdISDZFYprG
         bcDbfZagmILRo7yXUHCPv5hj54iBfEETbrmuem/KQiTW+MnOVcVdnVinLx/Svik//pof
         8SeIN/iBU8soHaqAAn2zK6870cGuJHmqPLo8XAivth736XDNa5ptAczOH4c7L+b+knwX
         068+4Sgu9pHabOz0aC75ILuD0xLs20j1H5UQlTkliteoIvmuapL4o68IFMpX6kAgBsyo
         JUPpYmDWI61833lZ/NnNpt7HeTw2NtkqZhtAh0o4pGLKclyMMYnR8lazVASfqvJpX2Of
         dyDw==
X-Forwarded-Encrypted: i=1; AKwUvBxyyHO2J+g0x36XxyXnLOs7SwcEhHgYS2XXDYjrTALhf1M+vx+bsnnOk4ZNNxI4gj8jupvvt5w=@vger.kernel.org
X-Gm-Message-State: AFuF++lbntNCfxg+voxRp/qf5JEKoCyIdcSmYSj2oGFf0SoxGelVJW/o
	Dwxq/r6aop1rQ72tM98l6VjTqC6l78Rhf8cjGeEZDY/MSZrqlAnbSuhuR+8VDrgbNvRmNdb8vVg
	ij7MNiLXy+GneNCitiU38icGht1EvsLUGa8lPXHW+P4TEM4QRWCX4p3vay941wsXQqLbflVO59A
	8Zd9Vt+VygXqH8XxgpXTTMax9gO8dPCGl7vxXKz13QRgm506r+
X-Gm-Gg: AYBFou0swTCYyESgZcOJrD+za7De4bZ0KcAttWyIyuy/8vRc4HMgktzB1P73eIZGgbB
	DZqTkAC3Jmgz6/P0N0iJjv8xQN3NxhUpOuMOgdWAcm2zEn8R9OoR/KNOGG2pzrsjwZI/9Zramz5
	80AL49UJNhThXbY3hzvQYp9ROmn+68kwcbiG5X0hhSgMLBoyQIY8Zs6GtetIMMbVzFYgkEL+kMJ
	HJzUTG2rYARP/2T4y7bfeIWkhig8TWaS5Yvw4xVxqQ=
X-Received: by 2002:a17:907:d07:b0:c26:1691:b374 with SMTP id a640c23a62f3a-c2a15827d9fmr13365066b.45.1789672766388;
        Thu, 17 Sep 2026 12:19:26 -0700 (PDT)
X-Received: by 2002:a17:907:d07:b0:c26:1691:b374 with SMTP id
 a640c23a62f3a-c2a15827d9fmr13363866b.45.1789672766071; Thu, 17 Sep 2026
 12:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917164136.2162858-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917164136.2162858-1-vulab@iscas.ac.cn>
From: Ryan Lee <ryan.lee@canonical.com>
Date: Thu, 17 Sep 2026 12:19:12 -0700
X-Gm-Features: AcwNN1Wzvx_67694p1o28AQ7birKEsyjcvTFnAQ2BuPeUqdnKMT1U0VxjCdP-Ys
Message-ID: <CAKCV-6uui82r4U3+ab=2ZFQvGQYnxfhYMHJNzLim-HEw6pRp7A@mail.gmail.com>
Subject: Re: [PATCH] apparmor: Fix label reference leak in aa_unix_file_perm()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: apparmor@lists.ubuntu.com, jmorris@namei.org, john.johansen@canonical.com, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, serge@hallyn.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 11:59=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> w=
rote:
>
> The inner block in aa_unix_file_perm() re-declares plabel, shadowing the
> outer variable that is released at the out label. The reference taken by
> aa_get_label_rcu() is thus lost when the block exits, and aa_put_label()
> at out is a no-op on the still NULL outer plabel, leaking one label per
> permission check on a non-filesystem unix socket.
>
> Drop the shadowing declaration so the outer plabel is used and released.
>
> Fixes: 88fec3526e84 ("apparmor: make sure unix socket labeling is correct=
ly updated.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  security/apparmor/af_unix.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
> index fdb4a9f212c3..ecb40cfe7e14 100644
> --- a/security/apparmor/af_unix.c
> +++ b/security/apparmor/af_unix.c
> @@ -758,7 +758,6 @@ int aa_unix_file_perm(const struct cred *subj_cred, s=
truct aa_label *label,
>                            unix_fs_perm(op, request, subj_cred, label,
>                                         is_unix_fs(peer_sk) ? &peer_path =
: NULL));
>         } else if (!is_sk_fs) {
> -               struct aa_label *plabel;
>                 struct aa_sk_ctx *pctx =3D aa_sock(peer_sk);
>
>                 rcu_read_lock();
> --
> 2.34.1
>
>

NACK: this exact patch has been proposed before, and unfortunately
exposes an additional latent bug around plabel handling that results
in a use-after-free if the shadowed declaration is removed without
additional fixes.

I can try to dig out the relevant exchange from the AppArmor mailing
list later, if you'd be interested.

Ryan
