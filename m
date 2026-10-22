Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695003;
	b=pDppA4RoVy9pbLMlemUfDKnjdA/Hz2xuWSFkvn36bi2fO2NVI3DbgERIhSYnpDIESM7i
	 SGQ2Y2m4+Jmwnkdd1Sl3DRz3Lrv0shQ6cEVksAoeh2Z5roq4i3kvMIpsqI2j5sTcuNI3V
	 oyb+2BA4FOUbrirDBQr0acMULbXv1fhpmryAbVpJoiXvcQToYDkvftp8ZZd2lyGauJTd/
	 WBU2fmOzzPJRqGBOSU/LXt/PVDn3zFcG+/Al/LIwNLCYupnWY4M5WyZXbDPYwWcykyet0
	 TwOyojEUYcDOmS7b6hx77MYqkt8MxU8BCQ2RyJVaBlis9DxshQSKdzNooHVPuYIqvCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=4qvmDiHEwTv6lkZ2XdFtXA3yyxYvfoE67suroCO1YPE=;
	b=28JrrAI97Ba7CV6vv+VPTfoRUF5x3FJKbQcCITL26ZB7hRiMOTwkFl7ttxVcBUKqoNTM
	 TRUskNZS1qK8gJkKRGoMwlCiHyCotdMSVx1vFhpcEGLCABquv9XPns31/MrDd0BW27ve1
	 Yext4XE/k39VoO4lRGbTF0BjHqk7BWpAty3WUukEFPAW1sHftPUH58CnbyMm3YDRzu+wk
	 hmuzXxbTEGWZJHO2Cc71mu/ImaKKtk8Lq4r/d2rLntK3O1iOqVIoFETrNnePQ7teNP3Ae
	 KITIdEPhj2ap45/KvnFcD+cYYGoocELabtXxV4443mff86jR6IGf6/dveTQyb9xNDDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="Y80/5xT6";
	arc=none smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53417606A329
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 18:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53417606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Y80/5xT6
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-679a2b540f3so180234d50.2
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1792695001; x=1793299801; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4qvmDiHEwTv6lkZ2XdFtXA3yyxYvfoE67suroCO1YPE=;
        b=Y80/5xT6RQdtVxnlxfHG+AVNqCuBLe7snoBueXb5p/Qjs2La7QNzsGb2V52286vOR+
         nyvK+l9XYof7HSB24Pned7AUCVhFIb0hrJiJ8YhUOjoJuPXScNMosQl4k40aOovI5zA4
         gNlJ342f2Oj4yLu95cv+Q3P0rHjOia3Qfq8rcVmCDy1AKPQEHyLm8QIUDQZrTjODYd+R
         zxYr7LWm6EvwmNKHIrUOZBYcWFL1IcplejCiDZYU7OsKfG75J5K6T3sip44zRsLfkTHN
         vzlnM3yHDfQ23rSbXZSNcFQOdNRLU1WG9feNbkA/rSkqjV7rzOcS/qRJgUrtVHfL7RsX
         kMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792695001; x=1793299801;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4qvmDiHEwTv6lkZ2XdFtXA3yyxYvfoE67suroCO1YPE=;
        b=Ra1Ev9jhsg9lpcPoBg4up00UMeph8jQd3+yHLlJySoZrPs/rK/W+V5Ss74fHbftux4
         4eXMh5iMoF+2wGnONJwvXqtrBoPj9Erb7YIJfJjX4zBbir+wiYDqQaz6b7SOdJkZSqal
         Gpx+rcKlcKtasKrjFrvX72tySiNmJz8GjLEm0kcY3EUTTD6L+7xVPvtxhQkSYi3emH6m
         NmlUUXV1LvpWCRx2olpmick2LFrDJ3OzwHyRdbMULBsjKk+/GYAfw85Ns1APazN/w+ap
         Hx1EG0BnF0eD1lnVSnwawS3Y0Li2yKNLpqYcBzQPKFEz0sK/GzWGgKXOS+T5Gpi1d7OT
         uqdg==
X-Forwarded-Encrypted: i=1; AKwUvBwdMkEZdyGHXKfSkY8dJBBw2hl7Xc/Fj8uS7Eiw8ESmEntrpyk0jyHT/MYv7AbmXWJyAMPQuA4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkjhOkvZeqSTMilfGfSAJ+i65P1WVslw/+Aox8ypggslAmALAu
	7GSM1bHQoBy44lnK2S7lqFBQHyhplf/ZctU6ZXewMvMS7+mgNeH9t/GlCiYCfXyAcas=
X-Gm-Gg: AYBFou261SGb2I6CYI8ApvSPD4kckwdye3+R9EMIqiS9XM8kpvBIFVfFN3iPChnXh3K
	u3e/Nb5suItCD/2n5ULjnpAtWngQeYNc+hRPHH+oskwIBShjd/MzElWrgqIf1KR5ONTFy6IZDWl
	Lyb/eF93MkxvfvheJUtYW/rRIoHFlM2dPQsvODPL0i42bD/EP2OiGmVkaCKJ9vvokNEYcwAY+Fg
	YjfcDI20683DlYYztGVdgBLVNcIsGc0IBk6SxJCAAxHXp9s6lJXk1qjqx9lzN/a6fBAaxdOx4cc
	uu4wtnVpi7mxatjOgSLnSxzxWWHhTnl60Y/E0qniQWIT7vMyBUXhDp1+GLRwgtPqetjAlIHg7pt
	48HCGteicJ7Qxb9K9JTCEVg46wOkql/vIUcx8rwznm5dxDP8HqHHD4JfaRx+Cr/MeO01PsZ0eDM
	9XeEW8rjrocAuS5Meku5uNlbcQ6J4An2EZ0OnuuOQKgMocibBtiZo3xE/OH1OlrVGoPHA+B8EuG
	uS2BQu92CNCHv4IvhtAq8Pmw1ju1WKZ9WasRMal448RTS3frjgAZHZGjDcB+KUnNfFpzmmP8/ZZ
	oSh7kfCK+QLRos6G7MBQKnr7VVNgQTY0CfKgaxSpyoBbcK50x/0ubRY7w9ewIXwSlumnNfHw9R0
	6JX5J6YB99xe/xIP+KkjWXgFXNS8+sqklHBtO4njT2C5rAA==
X-Received: by 2002:a05:690e:400e:b0:677:d89c:5f52 with SMTP id 956f58d0204a3-67a0e5795ecmr2838241d50.73.1792695001172;
        Thu, 22 Oct 2026 11:50:01 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:d350:a0e4:db9b:3217? ([2600:1700:6476:1430:d350:a0e4:db9b:3217])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a33eea199sm175680d50.3.2026.10.22.11.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:49:59 -0700 (PDT)
Message-ID: <a5830eb2ef9f0dfd43a9cd1255caa3f9f77541f1.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfsplus: preserve FinderInfo when listing extended
 attributes
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 22 Oct 2026 11:49:56 -0700
In-Reply-To: <20261022094058.1169039-1-hengyul@cs.unc.edu>
References: <20261022094058.1169039-1-hengyul@cs.unc.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-10-22 at 05:40 -0400, Hengyu Liang wrote:
> Commit aef507847129 ("hfsplus: fix generic/062 xfstests failure")
> made
> hfsplus_listxattr() return zero when the inode has no records in the
> attributes B-tree.
>=20
> However, osx.com.apple.FinderInfo is stored in the catalog record,
> and
> hfsplus_listxattr() has already added it to the result at that point.
> Setting the result to zero drops it. As of now, a file whose only
> extended attribute is FinderInfo gets an empty list on a volume with
> an attributes B-tree, which mkfs.hfsplus creates by default.
> getxattr()
> still returns the value.
>=20
> The issue can be reproduced with:
>=20
> =C2=A0=C2=A0=C2=A0 truncate -s 64M hfs.img
> =C2=A0=C2=A0=C2=A0 mkfs.hfsplus hfs.img
> =C2=A0=C2=A0=C2=A0 mount -o loop hfs.img /mnt
> =C2=A0=C2=A0=C2=A0 touch /mnt/file
> =C2=A0=C2=A0=C2=A0 v=3D0x54455854$(printf %056d 0)
> =C2=A0=C2=A0=C2=A0 setfattr -n osx.com.apple.FinderInfo -v $v /mnt/file
> =C2=A0=C2=A0=C2=A0 getfattr -m - /mnt/file
>=20
> Without this patch, getfattr prints nothing. With this patch, it
> lists
> the FinderInfo entry.
>=20
> This patch keeps the result of hfsplus_listxattr_finder_info() when
> no
> attributes B-tree records are found, as is already done when the
> volume has no attributes B-tree. A file without extended attributes
> still gets an empty list.
>=20
> Fixes: aef507847129 ("hfsplus: fix generic/062 xfstests failure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> Changes in v2:
> - Restructure the error check as suggested by Viacheslav Dubeyko. No
> =C2=A0 functional change.
> - v1:
> https://lore.kernel.org/r/20261021174534.482192-1-hengyul@cs.unc.edu
>=20
> Tested in KVM with KASAN on a804c5742bff, without and with this
> patch:
> - The commands above, and a C test of listxattr() sizes and buffer
> =C2=A0 lengths: a file with only FinderInfo gives 0 without the patch and
> =C2=A0 25 with it; a file without extended attributes gives 0 on both.
> - generic/062: 10/10 passed on both kernels.
> - Full fstests (805 generic tests, 608 not run on both kernels): 186
> =C2=A0 passed and 11 failed without the patch, 187 and 10 with it. The
> only
> =C2=A0 difference is generic/795, which fails at random on both kernels
> =C2=A0 with fsck "Invalid volume file count" (1 of 11 runs without the
> =C2=A0 patch, 2 of 11 with it). generic/089 and a small test that only
> =C2=A0 creates files and unlinks them while open hit the same error on
> both
> =C2=A0 kernels. This looks like a separate race: hfsplus_file_release()
> =C2=A0 updates file_count without vh_mutex.
>=20
> With this patch, getfattr above prints "osx.com.apple.FinderInf". The
> last character is lost by a separate bug in copy_name(), which
> Maurycy
> Pawlowski-Wieronski's patch fixes:
> https://lore.kernel.org/all/20260828-hfsplus-copy_name-fix-v1-1-75ed9f0f3=
78c@maurycy.com/
>=20
> =C2=A0fs/hfsplus/xattr.c | 8 ++------
> =C2=A01 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 71364e093fa7..45571d6f3abd 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -837,13 +837,9 @@ ssize_t hfsplus_listxattr(struct dentry *dentry,
> char *buffer, size_t size)
> =C2=A0
> =C2=A0	err =3D hfsplus_find_attr(inode->i_sb, inode->i_ino, NULL,
> &fd);
> =C2=A0	if (err) {
> -		if (err =3D=3D -ENOENT || err =3D=3D -ENODATA) {
> -			res =3D 0;
> -			goto end_listxattr;
> -		} else {
> +		if (err !=3D -ENOENT && err !=3D -ENODATA)
> =C2=A0			res =3D err;
> -			goto end_listxattr;
> -		}
> +		goto end_listxattr;
> =C2=A0	}
> =C2=A0
> =C2=A0	for (;;) {
>=20
> base-commit: a804c5742bff224d4cb4d25dd383554d598be32b

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
