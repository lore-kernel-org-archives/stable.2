Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933991;
	b=LeDaVcfFcGZX/WjaD/hftN7U7fFcnKES6MOBJ87udxGHZL6zNqP/XPSQOQ72MRhPfats
	 ttlR3MLtoHF1v1+Xt3RBFgCWNtVS0DJdzYlgwgOTElFWQDDtQ00Qy7ur5kx6wGhHXbb8e
	 VVLsQNXfjScTPsChyV3DLNPbE5Czcg+6vWQZe+Di/7xked5tNmepAw8J3hdrjTpkn3fj1
	 JfhCKIrhaNHPrkfAUbDUHq2dR4WN2yVHVVtSmpaQ1fgzl074UlHxu5FEme4LKT6vkaaz5
	 WEpKcDZvrX4Y1H6Me4MQjj457m/HbdlXj21uu1lE8aXVeBONpdJKmSgIrxZBoFg8sgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=oKKCe8ygh7GrMUkWBfeX/37zckwQuQ0kbjpZzRD5XkA=;
	b=tE39yyT2GFs4JmNg25tOBfoc2uBndPa+oMZSB4DC+TSIbm+XmV8CdgL26X+Rw2unB/ZY
	 0FYe3DKpGXFf+no4sH/bCV5WrG1NO1NP1yrvwyZyRpu0OXrkVrV91rwRadZqLUj7cJyi+
	 Sswnzw0e44raYm8USWpPYhWLHGj8fJ/56nHfATatS2QCGqOozuOyUXpUsYi/JBWJoJ+4i
	 6kGvLxQmydHY9bEfLFr0XM7QwDti6IKjGYSsgiSELuJCsn3+8TR6wiQMCCVxKHymbUa9C
	 AD6kAjuOYfkW0W1Lgg0QYLRyIaAgZUsrAT1VuTJnul6st03H6LHTnsBFahZ3TgNuuQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=GgwgrVWk;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F755606A330
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 16:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F755606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=GgwgrVWk
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so627295e9.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794933990; x=1795538790; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oKKCe8ygh7GrMUkWBfeX/37zckwQuQ0kbjpZzRD5XkA=;
        b=GgwgrVWkhEfrk3N6EXagZRK+5loEKGHlA7VwYYe+uq/MeGrHeC3JmNuHlMkmAk7Aeg
         sM0j2MXA6GjiiTUYHVM2uYdJy/cxQxCuxPmnWSGeD2ErSbMsyuAdnHtN0+FS3WBIwbNr
         XbNP0uJPM2Vbv/jFoL5RaoZqvUsK1kmrCuzDi+7EBLOH42pHj+8VzuoqdQpZMCVnQ8Y3
         A1dG9jSRObf7HxfX1X6SpRVFiOkBBXaHgDQsRmQBtKUJsoS7SWTyWE5jb1q/hkd7OC9g
         kgLxLOYhXk8ZSynLQvYLLChpHtgkKdWJdB0Q5Qt2c/JRhSgsGbLDw+RJgX5z1zs0+osK
         sbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794933990; x=1795538790;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oKKCe8ygh7GrMUkWBfeX/37zckwQuQ0kbjpZzRD5XkA=;
        b=CLqhicnCvrD9y2V01XESRSxVBgyDO8CbapsDQVSVqQ7Qhp4YWmUDnGQfOxP9aaecMf
         5k1uquvmZSFI5SXxE3ue/5dgmGnpBRsRcXEhEg3BRPAtzFfQV8bFi+RwIf/FCH8OSEj8
         V4GSG1P0ltDfehyap14j2YPAvivlka3pX/8io5Y3e/tojTc60VJwyTMkof9cudCWPeGX
         OkWAI2URCVyWON8w2Si0NKnO1eCWD45ioXBNrbhGQ5SPs/U/i2oa01gpL+11aJlL2hj/
         8dbaSpGrSmMrnavoRRB8/Wj0yhWetOmH2ruOc61/ch5iVu9ajerqf+zSWvh8wlME9yI6
         Rduw==
X-Forwarded-Encrypted: i=1; AL+hErFFWyGXBSzp9dTrUKN92rhUZYwDC5RlE3NxTc1b9cFCSRjDIHDqPRWESWcN1AIShFpRXWdsGXU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YXvgTgMQ83TsTFg0cBouA4mAZ/UvEYTJ42o3vw5uk+WkIjybH
	nP1gu0g6b0mmJLoD/ho9cWaf+JcldFphiFt4vJhZu7W1RS1PmrSl1f9qUr14G1Pz41ah
X-Gm-Gg: AYBFou3N1EPAjHAtBmSxAOzMZTvBwTjrk3F+k7BHc8Cho00IpZMltWzLN10PuZVuch/
	BNccHRZtkuR0oBo4hnviANCJEfQN24zsq/pR0ZQBv1Euha4XMJxuJgl3rQBTvSGyc/gUBl3P84g
	F2ak+3Aeku9KPllfLmKpHnJPSK3X/Vow5zyDEjbYHblrvw9tUSxlkJbcTnSmWOlKIr3tAFrsTwq
	T2d5IP4tnkIIMFOXa3orxDg5wqKoMAnpOxax5Eq8diwrPtsRZVG8lnveuH1Jpdv00wfyt1qYs4X
	+SHMDGkGK/JEl7JiVvsf1ZOZdxh22ac8HU6zbc31ARNB+YhMrMdR9KbvvzIK8031LxwVwjCAGn+
	kIrmJijf/2wtWY93oTrdecE0yH2RM4jCSEk78LXMQOr5ZhxVjtz+dhmeBTQf4lHdreorUsP7184
	g2kPCZ0fJLEnXLHdtl0SE5djXyVH9CmFXOGkffOsA+zkhUVHNTzez6rGnA6fcSPtjcdYzIY2ARN
	E7FVY5YXeo7v9eGuCG9u2QaibRJutnRo61sxGm2UAoBYV6kzLnIY8tMUHM2XE2vHcX5EEVBBolK
	FTKN2Zn+tfTGKpzOKxdG0cW5Kzu0KRFVno6+bGymUkqDjBfac0L4iedYItCWYxTd5G1TtqYONlw
	rlhLctuk599e93sHPpoQdy09rsTaFffKQxvJ2YJ/3eh7OGT4rCFVqsAjX
X-Received: by 2002:a05:600c:8b81:b0:4bb:5f45:c97f with SMTP id 5b1f17b1804b1-4bb5f4f93f3mr237361265e9.27.1794933989639;
        Tue, 17 Nov 2026 08:46:29 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:dd2a:c8cf:5d96:bf5b? (p200300cf572c2800dd2ac8cf5d96bf5b.dip0.t-ipconnect.de. [2003:cf:572c:2800:dd2a:c8cf:5d96:bf5b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a4de4cb1c3sm3411859f8f.8.2026.11.17.08.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 08:46:29 -0800 (PST)
Message-ID: <ef8fced5c2a9d60040e631cef986bafbee28c352.camel@amutable.com>
Subject: Re: [PATCH] devpts: create pty nodes under the parent lock
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org, Cheng Yongkang <teel4res@gmail.com>, 
	stable@vger.kernel.org
Date: Tue, 17 Nov 2026 17:46:28 +0100
In-Reply-To: <20261117-work-devpts-pty_new_locking-v1-1-9ad92fc3bd93@kernel.org>
References: 
	<20261117-work-devpts-pty_new_locking-v1-1-9ad92fc3bd93@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-17 at 16:27 +0100, Christian Brauner wrote:
> devpts_pty_new() creates /dev/pts/N with d_alloc_name() and
> d_make_persistent() without holding the inode lock of the devpts
> root.
> A lookup of /dev/pts/N that misses the dcache holds that lock shared,
> gets an in-lookup dentry from d_alloc_parallel() and calls
> simple_lookup(), which hashes it as a negative dentry. Nothing
> serializes the two, so the pty can be created and hashed after the
> lookup missed it, and simple_lookup() then hashes its negative dentry
> for the same name right in front of it:
>=20
> =C2=A0 lookup=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 devpts_pty_new()
> =C2=A0 inode_lock_shared(root)
> =C2=A0 d_alloc_parallel(root, "N")
> =C2=A0=C2=A0=C2=A0 miss
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d_alloc_name(root=
, "N")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d_make_persistent=
()
> =C2=A0 simple_lookup()
> =C2=A0=C2=A0=C2=A0 d_splice_alias(NULL)
> =C2=A0 inode_unlock_shared(root)
>=20
> Both dentries are now hashed under the same name and the negative one
> is found first. So stat() or open() of a freshly allocated pty fails
> with ENOENT until the negative dentry goes away. Cheng measured about
> 26k bogus ENOENTs in 6.5 million lookups while ptys were being
> created
> in a loop.
>=20
> The parent lock used to be held here but was dropped in 8ead9dd54716
> ("devpts: more pty driver interface cleanups"). b4a76faf9d96
> ("convert
> devpts") then switched mknod_ptmx() over to simple_start_creating()
> but
> left devpts_pty_new() alone.
>=20
> Do what mknod_ptmx() does and create the pty node with
> simple_start_creating() and simple_done_creating(). That takes the
> parent lock exclusive, so creation waits for lookups in flight, and
> it
> reuses the negative dentry a finished lookup might have left behind
> instead of hashing a second dentry next to it.
>=20
> devpts_pty_kill() doesn't need the same treatment. It only unhashes
> the
> dentry and a lookup racing with it either still finds the pty or
> misses
> and correctly reports ENOENT. The index of a pty is only freed in
> ->remove() after the master was closed and devpts_pty_kill() ran, so
> devpts_pty_new() never finds a positive dentry for the name it
> creates.
>=20
> Note that ptmx_open() calls devpts_pty_new() with the tty locked. We
> never take the tty lock under the inode lock of the devpts root:
> lookup_open() drops the parent lock before do_open() calls ->open()
> and
> devpts has no ->atomic_open().
>=20
> Reported-by: Cheng Yongkang <teel4res@gmail.com>
> Closes:
> https://lore.kernel.org/20261115163620.225761-1-teel4res@gmail.com
> Fixes: 8ead9dd54716 ("devpts: more pty driver interface cleanups")
> Cc: stable@vger.kernel.org

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/devpts/inode.c | 8 ++++----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index bd1e8eb26edb7..65f6aee74fa45 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -521,15 +521,15 @@ struct dentry *devpts_pty_new(struct
> pts_fs_info *fsi, int index, void *priv)
> =C2=A0
> =C2=A0	sprintf(s, "%d", index);
> =C2=A0
> -	dentry =3D d_alloc_name(root, s);
> -	if (!dentry) {
> +	dentry =3D simple_start_creating(root, s);
> +	if (IS_ERR(dentry)) {
> =C2=A0		iput(inode);
> -		return ERR_PTR(-ENOMEM);
> +		return dentry;
> =C2=A0	}
> =C2=A0	dentry->d_fsdata =3D priv;
> =C2=A0	d_make_persistent(dentry, inode);
> =C2=A0	fsnotify_create(d_inode(root), dentry);
> -	dput(dentry);
> +	simple_done_creating(dentry);
> =C2=A0	return dentry; // borrowed
> =C2=A0}
> =C2=A0
>=20
> ---
> base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
> change-id: 20261117-work-devpts-pty_new_locking-9b3d01e643c3
