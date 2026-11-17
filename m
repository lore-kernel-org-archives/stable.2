Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794883015;
	b=CxOG+CIoSibg/nCDQ5PdQAOLq8Ulg8Mx75Koe1BaL0QJJo9ycypVtmI0fHZRQptXl2l9
	 +gHLHUkJVO4nDjcqhfS7NeFGi9amE97VqL67SOq6/T8XTm1eJm4cx6dVDUan0Bg2RgS/F
	 Ck3nfRLB1WxcswyNwqGFnjdG9JGpJ1f9hD/MXWLIihzB/8ovbjPcMz84rklcjdpPGeJ1S
	 sRFTjPzEsuD5saFf9h0twF2K9il6mDj0+U0ascieZdMCnmE3w1yOSEC4XWXmOnt7/e1e1
	 Om99rmg6VFhNuXHM4F6sYDEaeCYq0eEwaN5IYo0X5dSrCrtzUxpjgwLMA+P7mRhCdbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794883015;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Nc0Kx1j/LAZLLQGwSBqbBP8FB/6wPqlG0izEEFd5vzQ=;
	b=2HhKPjfurkPVdo+ZtMAA8KPsC/HdJxCAY3MPrJNQnThOnSBQ1jz5ym7nlYorDeMWHG2a
	 yOAzsC9MxlMoyvK9Q+yEHNFeTC61Z+pH1tl12VvrMsvFSsGLB02FjLSz8pqX+PISVbC6K
	 X2rSN22E9gpqzCCER/LGiT7QOU73CVSkHL9yMiA9vXrsffGJIOLy53eF4G+L6L7CClq2b
	 YKzNgcs63X8tsQXl8INxhgCQvYP0WxsGeU9PHjeou8uwgkn8usFYYfRIDMUR5/vHMVxX5
	 dPvv55g5xNow7e30F4+dHVFuV9GbFctqv8ZYqZyw7XczFoqLio9qChcDRwBznzij/Pw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rua9RebK;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ljzSf5Ms;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75521606A329
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 02:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75521606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rua9RebK;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ljzSf5Ms
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794883013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nc0Kx1j/LAZLLQGwSBqbBP8FB/6wPqlG0izEEFd5vzQ=;
	b=Rua9RebK8CtpD1x6eef9GPQtHxxISo5+T3Ml6MBcjMVtlUJhqywzMCeTK01tQFU/22cKrk
	qOoCg3kc93YtzCJ7qc7nS8xmdHFKqP3AF2TvrREcZ5nz5i4EBOmPOrmvHLtx0rFQ8uAQTe
	RjNOJb/DxfGG9+GpFLjxMszzrPxJ2rc=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-saR_YHsGP3-nQ-TB6sxr-w-1; Mon, 16 Nov 2026 21:36:51 -0500
X-MC-Unique: saR_YHsGP3-nQ-TB6sxr-w-1
X-Mimecast-MFC-AGG-ID: saR_YHsGP3-nQ-TB6sxr-w_1794883011
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-67c0efb7b97so6773744d50.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:36:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794883011; cv=none;
        d=google.com; s=arc-20260327;
        b=CkoBYV2Gp1PfyLkQKUdTSiPpSFmtg5yjFmLhUFApgxsOCEtEsxSz2AWflbZJDHnpID
         0tkdBUFNFJX1qA6MV+VZjonPQtawUHr7bnyU6cFXmKkVtLaHj7whksy/Pv9cZ1JnkXzc
         egj9gC3laUeWBhy/Wb92l2OwLhb1b/B4B9t6os6o24jZUuWPUZIsjaCS6eDFHkKdOQtc
         VxqJ/v8n+I8CrDsNVa6bjsl5uyyCzhPitF7HLxC+TLnQMexOjwdMXU1cBDzSMPpXYD+F
         WSDE4AV4mxE3cFAYnMJt09HF5sIOb7D5iExKSh+o4pIcBA/7C/dG4wWglFLxSgmJZXX8
         XhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nc0Kx1j/LAZLLQGwSBqbBP8FB/6wPqlG0izEEFd5vzQ=;
        fh=9vVOGMHFwSW5uSwNDbvRAHnMWUUoVH2V8xbqC76TUeI=;
        b=dziflHlN9EmzP2MRJ0z6X3VfJzase3oIEH5vmGYByno/glMAidPraOHYzCue8zXCiC
         QKkEoh77Ry2+WAZ0q57jTCWi5BN4YqkbozF1Nf7pviuqFzANiTwWWSPhADYkjgL42U1f
         dEOENB2VLkZGn778cr935lBt9ClFaUVEB2Z7X19LcK4hYQxPJfHGequhwvJScevET6pI
         TLPmCDk9DolVT3i8mvaQkbtuEpsdoHpSunh0/adhRM6tts4RFie6iq6rb3urw4Rbm4yx
         2sXlxvM2wseAFuUf9JR04fN2UfhGivcAwtEMu7hgxKPOW0plrYR9Ee7103T4KvV6YfSL
         BlQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794883011; x=1795487811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nc0Kx1j/LAZLLQGwSBqbBP8FB/6wPqlG0izEEFd5vzQ=;
        b=ljzSf5MsrfJHSCbtn64qvX3AyFJhYDYCWoHUOGaXhbS1K50YTAu4r6P6q1Z2KXEqzu
         AQByMFtCw2qN4+4y2JVorbyAL7NFBSqfVfeTB6PmjagJfIKZsuToKnaXUlxA6hCVwhoA
         OHhy3nulmmQbNHBYsEv1kZYIyrKN4GlFwMMOqOMsnGduGWrGc7ousssl9SqT8DqrRe8W
         EYyCwrZ3aPyUrPJ57FELuC/yVe60+IxUrGCXTphhc8Vx2ynp7msSmFIfCjzKG8RxBh37
         WPcbsTdT+v6b8S/HjkEkImSyCKmjSxs9ibv9W/q7TAx75nzXv8l6om2V3d6IbEJp+DPJ
         o3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794883011; x=1795487811;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nc0Kx1j/LAZLLQGwSBqbBP8FB/6wPqlG0izEEFd5vzQ=;
        b=KVlcow02Im3Uf3i3qJjzBdF3Z+EGvJz+vypYWvMz2y3odXBkpJlr8c8hMWcKEv2CmF
         4FBonRojNyj1c/ouK2i6bR7+7jbI0BmELA+VLfmamGX5HjFRwU/dfucayyaqRz1aLIrZ
         ORVury6xZDaZdeoR9EcJF9SW63nRooAGuMiDW2zSmvWUIHKccac7oJlgkppMVPOegZtH
         1sDbKHFlwZcMZLBHtjSYeFEjxsHO7NT12hAbhwdIMqYPYOBsTaMo/LOhnubENFiw2zTS
         Kgc7Tio9ADvepRUOK6SuP4D+97nM8/68REarU59MmE7wf2bFov4aa84RmUkB/7bC8xcf
         w+vg==
X-Forwarded-Encrypted: i=1; AL+hErH8kvf8tvMmNFGW3GGjsFpA9st0i+nr4YcBfpYooDb/GscRwmoxgOT8VV6zbueYzMlWsNBdb40=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hPGVetPbd2c+k6Bk/0HohdLhkobNlRwvYM2QiTlijFuwtToz4
	dQr3vElMicIO0+rzk1b1Cw6k6zrEf7dnix+h92BzOBSFnZH0m5PYk//8/EfteZMDZfR533Xpty7
	uf3d93eFnlb4gFDf0Q+NtN48WiuAvjp3h7obfNP+S8YxbdMY/1kuO0jXSBepS1OoxxR6QC9RhXg
	F03vjU7cxWVbe6/nXdLC/BFH5tNBfaOIFQ
X-Gm-Gg: AZFdTZe+m9PES27+N/IJ4wjxyiTqOiDEDyXBEFOg8VWeMwC7nmUvU/j1afiyByyjNo6
	GTw0hxKNBg6De2r0jOtdOeyqSgD4/gYsYKtbhMzRuppvTZxRPosPrGmr7+l1Zaytsyp0kP0snNT
	FoRDguBbH8tqfd9CkHU5Ho0ZiVwK7/h02HEAmo24KarThrlxBiO4SFopKw0/x68r6dycQQi05+J
	bkqC6Yvb57KR1MUL/BxLOSodGzHgU0na1fTHZTgkKjkfQ==
X-Received: by 2002:a05:690e:1286:b0:67d:ba39:f922 with SMTP id 956f58d0204a3-67dba39fc87mr2249541d50.105.1794883011239;
        Mon, 16 Nov 2026 18:36:51 -0800 (PST)
X-Received: by 2002:a05:690e:1286:b0:67d:ba39:f922 with SMTP id
 956f58d0204a3-67dba39fc87mr2249529d50.105.1794883010751; Mon, 16 Nov 2026
 18:36:50 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116180002.44336-1-founder@logarcheon.com>
 <20261116220843.378480-1-agruenba@redhat.com> <20261116232409.46988-1-founder@logarcheon.com>
In-Reply-To: <20261116232409.46988-1-founder@logarcheon.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 17 Nov 2026 03:36:39 +0100
X-Gm-Features: AclHuK8jipT2sqTxWhLP9_-fF2K8gGmgIWV6DE8puWPi_tixSxFnVaitHavNBps
Message-ID: <CAHc6FU5=ELOJiaP6VWg7q5S+=jULvgrB4mF7diNSUpOg1aiZZg@mail.gmail.com>
Subject: Re: [PATCH v2] gfs2: Fix NULL pointer dereference in gfs2_seek_data/gfs2_seek_hole
To: William Chuang <founder@logarcheon.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 12:24=E2=80=AFAM William Chuang <founder@logarcheon=
.com> wrote:
> gfs2_seek_data() and gfs2_seek_hole() call gfs2_glock_nq_init(), and
> independent of the outcome, they call gfs2_glock_dq_uninit().  When the
> gfs2_glock_nq() call in gfs2_glock_nq_init() fails, gfs2_glock_nq_init()
> returns with an error code and gh.gh_gl is set NULL.  This causes a NULL
> pointer dereference in gfs2_glock_dq().
>
> Fix that by only calling gfs2_glock_dq_uninit() when
> gfs2_glock_nq_init() succeeds.
>
> Fixes: 3a27411cb4bc ("gfs2: Implement SEEK_HOLE / SEEK_DATA via iomap")
> Reported-by: syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D5a5f492ccae698fd7434
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: William Chuang <founder@logarcheon.com>
> ---
> v2: Adopt Andreas Gruenbacher's version of the fix -- skip
>     gfs2_glock_dq_uninit() via `goto out` when gfs2_glock_nq_init() fails=
,
>     rather than guarding the dequeue with gfs2_holder_initialized(); rewo=
rd
>     the commit message to match. v1 posted at
>     https://lore.kernel.org/r/20261116180002.44336-1-founder@logarcheon.c=
om
>
>  fs/gfs2/inode.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 2c2dc459c037..d4678e4832b3 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -2253,9 +2253,11 @@ loff_t gfs2_seek_data(struct file *file, loff_t of=
fset)
>
>         inode_lock_shared(inode);
>         ret =3D gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &gh);
> -       if (!ret)
> -               ret =3D iomap_seek_data(inode, offset, &gfs2_iomap_ops);
> +       if (ret)
> +               goto out;
> +       ret =3D iomap_seek_data(inode, offset, &gfs2_iomap_ops);
>         gfs2_glock_dq_uninit(&gh);
> +out:
>         inode_unlock_shared(inode);
>
>         if (ret < 0)
> @@ -2272,9 +2274,11 @@ loff_t gfs2_seek_hole(struct file *file, loff_t of=
fset)
>
>         inode_lock_shared(inode);
>         ret =3D gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &gh);
> -       if (!ret)
> -               ret =3D iomap_seek_hole(inode, offset, &gfs2_iomap_ops);
> +       if (ret)
> +               goto out;
> +       ret =3D iomap_seek_hole(inode, offset, &gfs2_iomap_ops);
>         gfs2_glock_dq_uninit(&gh);
> +out:
>         inode_unlock_shared(inode);
>
>         if (ret < 0)
> --
> 2.43.0
>

Applied.

Thanks,
Andreas

