Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABBE495AF1
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585589; cv=none; b=QB3fnx8NeX6i0Y6pP6Zqv1KJVSrb+GMGkF1V36FZm5a9JetXraSGFXiKA866DZrVHcUjrEq8tanqWnYQFx82xuqHdtuXBOOoB82G3/sFL7ZyVad2YmmZlk7kHsb3nK0w8bVIE01zaeGWX/5L3duLWOKjjapVTxjrW+WPBrz9i2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585589; c=relaxed/simple;
	bh=at37MEHK1PoDpKTrPGD29SbuwXSfyiMebXazPTAKj48=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N+2ys+GnbcsESe77t3UwyX7vCiHr4WKJuQa4p5+1jtMdTF/awZTfXVIFQfTkk5KJnW7eNavh1icSjAQxDxrvP8OZ5YLiNosAQb0E1Go7hFUH7qIf7kMBtioT0zJD0CoaOvbjMo6fQP8n4iNvlcuO1WOa+Z50DMUF9RbaRMEBiNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=FMHFlIdV; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="FMHFlIdV"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-67109935888so20845d50.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 12:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789585580; x=1790190380; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ca4yrRqL6+DdXUu9p1R9aXY14Me7n+gPWyjhGW+2Sug=;
        b=FMHFlIdVI8Es+9oD00reBuLNkm8HT9JaW/cOr8zKkzIpcj3Mzh/TTyrMxqtrv7aB+S
         ueO2iHI6db2h5J5DNUsiq2OKGXTn5jEglCdTVqJ9MiOCDcCYeZndLnAQ1nMaR6iz0DBS
         gMd+gMIl3+OeIdwNzwN0Oche5igdQIb2innc5aRHbp67giMPmPbkVnfn9FDuPVof4v0W
         qlGdXv9XyLSJF8NQrVRm5qJ61Bd5Y9g2kibJevDhU87hWc0fAZMx5KpjyAEqtXMeO+tM
         bPYLdZrmed52fowoKk5M8fkXVA0PbUDpwnZQjb6GTeakwHfZAwoFkHNYIBblQXz1PVac
         gqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789585580; x=1790190380;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ca4yrRqL6+DdXUu9p1R9aXY14Me7n+gPWyjhGW+2Sug=;
        b=rnU40Sn56eRz7/G5Jh4Bzt5VjT3809JtZpO6oPA93JXSYtbN/p+i6L0bu2UXvgksOO
         PRY4QWIHf/CU9Pw3wX6BElbdyy2CPNEXakeGO1gTTLd3ZjYAQTFaVwH1R/dZpj/yeQCx
         5qM2mZvIbSjc0gNDBhefbl/17IPaF1GMY0x1sv2VWMf+dKtTlbtczEsWee2MHsJg5mxo
         g1VvQZigC9bwIbyhvayUW085kTWmsX9rXFT+eiNC0KR78Jkiw2FmDhS9qEduWgJVrpVO
         llnbBmKHTI/f6uszWCxJ646S45GiUVMVNUg9qoLZ3ET2nqQxHm3slCctDWC1eOD21a6u
         2H7g==
X-Forwarded-Encrypted: i=1; AKwUvBxIkuz1VbVoFjeByMz5v0PvKJQyctuKHWVesc4UwqbV/LeRNIVdaB/8zyvXBPCthe/ZDTIb/sw=@vger.kernel.org
X-Gm-Message-State: AFuF++mer8NFp96Qsuo15vFTkGsXDo8WD4sSvrcznj/g8Xrz2mMn3wR6
	CFkcGuIZpWYyK+rvHlGYAO2hwvubCFK6B0J9I1nTKnHll8gEDz8kF+nQ8CreNcJhi6A=
X-Gm-Gg: AYBFou2L6+1e77Sv/V/4NJjksoxoTlqVjkWwNFd4FJs3hDRWG1BngTFP3x/DLvSgXlM
	FOhMTJ/ybK8P5t0Rt6wa2NecZLbN7tYZFExbawcmihQZ4jmCwG1fgrwzWjrUnvLJcZQJccXI3MM
	rI321BtnTlXYOMNg7Ele967vuWPiTMClvdZ/KSwBGPKLUTJjM478gmXRiVpOlBPBeLVjXaJGc3v
	zh+WqRlWkHqru5fdlFQOJJ3FfffKCUX8KRz/8kuKD1dt4yU5t4cjF6HoaPI+EL/mueWFFJ9pjZ6
	7IYxlOnMJr+SKNnEY8QH6iJMYJr99G/qx4Ue+6SPH4BAlr/KwgtBKnLD8OtmAXnFA9W65oqM76z
	II09qwogPJz+r7aama7M9lQVzmbxeF//4u0B313LA8U07TLA7ThZFpfl50W39ngJ/aezNgkEYrI
	a6kfyskQwPfFLRTUDhs223kjRyh0pD5/qkOKemDzSfRhYMFbzwdk96CMsOXxbADdE2xlo7ZkO9V
	ICyppcQJQOnroF0UyzlFarw2sVY3BNWXyZJzdQMUmxKhkS5qDzKi5lbDakysQ1Ju0MK16XjKxcu
	uamRAcZcF3vRqyEzSrYAGqx2Whwp303qCocUDH6kWYqA9E6+IjKZIOdbpho/wPtw
X-Received: by 2002:a05:690e:4391:b0:671:70d2:5285 with SMTP id 956f58d0204a3-67170d2542fmr87564d50.72.1789585579861;
        Wed, 16 Sep 2026 12:06:19 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:f547:a2c0:72f7:6671? ([2600:1700:6476:1430:f547:a2c0:72f7:6671])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6715f79ca1asm1651972d50.21.2026.09.16.12.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:06:18 -0700 (PDT)
Message-ID: <8eef80c6c8d21e863c5a3721b1ae681fc4ccf54f.camel@dubeyko.com>
Subject: Re: [PATCH v2] nilfs2: validate segment number in
 nilfs_sufile_get_suinfo()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, Ryusuke Konishi
	 <konishi.ryusuke@gmail.com>
Cc: linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 16 Sep 2026 12:06:16 -0700
In-Reply-To: <20260915195223.3331909-1-qwe.aldo@gmail.com>
References: <MSG-ID-sufile-v1> <20260915195223.3331909-1-qwe.aldo@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-15 at 16:52 -0300, Aldo Ariel Panzardo wrote:
> nilfs_sufile_get_suinfo() subtracts the caller-provided segment
> number
> from the total number of segments without first checking its range.
> If
> the requested number is greater than the total, the unsigned
> subtraction
> wraps and the function may process segment numbers outside the
> filesystem.
>=20
> Cache the total while holding the metadata semaphore and return no
> entries
> when the starting segment number is at or beyond the end.
>=20
> Fixes: 6c98cd4ecb0a ("nilfs2: segment usage file")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
> =C2=A0fs/nilfs2/sufile.c | 10 +++++++---
> =C2=A01 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
> index eceedca026..573646c5f7 100644
> --- a/fs/nilfs2/sufile.c
> +++ b/fs/nilfs2/sufile.c
> @@ -870,10 +870,14 @@ ssize_t nilfs_sufile_get_suinfo(struct inode
> *sufile, __u64 segnum, void *buf,
> =C2=A0
> =C2=A0	down_read(&NILFS_MDT(sufile)->mi_sem);
> =C2=A0
> +	nsegs =3D nilfs_sufile_get_nsegments(sufile);
> +	if (segnum >=3D nsegs) {
> +		ret =3D 0;
> +		goto out;
> +	}
> +
> =C2=A0	segusages_per_block =3D
> nilfs_sufile_segment_usages_per_block(sufile);
> -	nsegs =3D min_t(unsigned long,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nilfs_sufile_get_nsegments(sufile) - se=
gnum,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nsi);
> +	nsegs =3D min_t(unsigned long, nsegs - segnum, nsi);
> =C2=A0	for (i =3D 0; i < nsegs; i +=3D n, segnum +=3D n) {
> =C2=A0		n =3D min_t(unsigned long,
> =C2=A0			=C2=A0 segusages_per_block -

Looks good to me.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
