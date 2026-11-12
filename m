Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516325;
	b=0hm6N3B4q6Ko2dnE1CbdK0zYXAbmW47N2o9FDXFEGsNLvRPry4UVOlJmSPGRdAm/R+FV
	 r0BPNTriyK1T6J91u8RkIn3o19TVFJ4wT8aH/4CuaJGEf5oMM5qcbaLRQmHc2dt/11FRt
	 Je5TAn8Nd74G2HUjTCjEl4uiB+tSSzlm9HOgkj6GoemWSp13+mzQYY6go10bfaRWEEb6i
	 /KfKeHgpweGnvKk/gfaQXazkB61inL9L3u7TvohwfCFq/eJz+pg9VTaAwdIEFHsV8elFq
	 tXZlR2tmD2CJBSVzroUNF+1CDf3Ql1Ld5K386Llav8R9MXLXuIAU5UAUY0fnryK3hHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=iXGHywZFNojrHd2KwpmIrJ8ca2HrRHqgEFVKWK/ZGM4=;
	b=kOV1bH2R6V2ez75MGO4QgWuY0Vq7dehb1vpIhxJaSjUD8kPSwTpU07TIJBtNBIkn8WLv
	 yIzdwmXtrCJF8aM9iCuAdfS87J+m1xwuSGFauVtVevQQhA1Bj1yBg4SYdJ+/bYuMkCvIm
	 +UngpWy9wsjReALOnAao9F5LFjkdn1yB0mQ5+D/aC9wLKXWvlUBA7Exq9fc0br85qJoB0
	 9fDHDk6MbFEu8iR3K6dyeyIacXi7usMiScRpezz0kJ52TD4f2gO5KoSp0lZdWZS1nahj/
	 2psM/3cZn+R/I+smJqDohq+4lpmMhJ61T8aWzKVatohEwEPmDeTMnEFRN4fxd7AFnGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Oc7eStj1;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E40E606A32E
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E40E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Oc7eStj1
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b31448caccso3228647b3.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794516324; x=1795121124; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iXGHywZFNojrHd2KwpmIrJ8ca2HrRHqgEFVKWK/ZGM4=;
        b=Oc7eStj1TstmNeupx6yzNDRP13iRRMeE/9vdU4XtbLp466Xx0zvrPfr4sCdY80OA4t
         3PMSsrITYf39yhgq473pVTnF5X2j4khSR4ukGysWobfSKYTGmRNmRYpayHccg4SfCyWE
         9P8WgNmkz6x5RxSHPepPFVr2P8hG9Ysnng2KQsccZaUz5qPZnIfX68EWk4CCIXhGJeSO
         ES43IyZGYVLNfRGGTV3SIhMkm32XvR7aqMyzyrsavH4YBV2m68KnYj+QJytsQuqBiLNP
         mzLWPZigDsQ0nWtxPoRhtwnh3xSXVu+cMyq9n47rhv3sEz8+4Fbj9mBfhXgU3/b6vGOM
         bNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794516324; x=1795121124;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iXGHywZFNojrHd2KwpmIrJ8ca2HrRHqgEFVKWK/ZGM4=;
        b=N8fptnv/HNz7OieDz2q23KjspbEmJOTp4OMwGVJcIpFIHJ/J5Muq4qMEh8Tj24AT7i
         vbkYamEwltbjxZs0CUc3u1sAgQeqYwYWMtSkVlShlvKhzwub9vGGzsTUXztZPJIN6em4
         rvFBrHJRSE+etowmp9xpvWxPGrP1l8F+OAse7cEwa38sZZOL6QAYNxCbmmf6FfWNqnoU
         64G1C+gQ28xjUB1GEhIgREzGLFzXOSSPn6Y4+I/sLsZFO5UJqOCWrwRMQRArxInI8RcA
         ZH+PQ9fDcB78Ev8jo0o12XbS0mKjinZk5AdROsLZV9eA0CiurNzq8DWtJDqLP9B9bmES
         i60w==
X-Forwarded-Encrypted: i=1; AL+hErEOn1BE5nkz7zvwjiZQKx2Vj62WUA9BxDiMhgxDpgp7YKFY9TQHL6+WBovrV3tcLpxDP8AxdOE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8X6RA6qQYAM5BRbYdH7As3Td04ruTaeRSBZTIzYLxL9BNTde8c
	FJAFtpI66LGTtq3JMPf94WLuIIAOBy5vPKnHIwsJN0+N9fiD4igwFkBDRW9/HVKdYBW49Y2n4m0
	tNMlywf4=
X-Gm-Gg: AYBFou2qCDf3e/cTvo14MB/SkKaRQLWVH49XnVWknDePz37DHpKX5z1g2lVwKbzi8wZ
	e7Yp6TrnnpMLgHRnCXeHxc/obAJ80FaOx8jS7kc/YT5w9j5xOeAuC+ueOSX1JUcMVvJAj9L7ULZ
	O4EAjoaMmWI6xIsfYafkaIk0dCXKQvU/3FnslziB3eaoH0DwNGc5CVTDC2SEmvrVJMCm7amproD
	/Nlv7t4t/rRTIoK4Pw6M6AzxU0sm+jNChU7bUAWcp00VDkqGHYTmWGUNY/KMQekNxET2/vla2+5
	Mrdau+/24wSDmNzoHA+lyq/qAg87KlPutZSENNuonUlfEaVBLrIQEQ2HDIB6jmofQK7yUGoMSl5
	yN7BdD3mPie2sNAf3U2M0PeDmTD610qi3501P1AY8FuHzCzd+/b4beTE2pEGc633hyqDBUGsnGH
	R30DPldXHF+6YOB+uHR7DJkb+tmdnajRoYm/KUdC1yPX+EJYu2frQI/l1aW/H9QkDtu+2Kk/2Jr
	M5tS1PPe9zlZRFIfj32VBkujdgmQn7rcUrwjqxBZd95rWxsY/Lj1mCJ25pSezgzE3DnuoT5ZKUy
	ywoBA3kHwvt+k2TN/+BIkJ4ShEjsxbEO+uRhh5NWvK/hz/W1kpHNT8zmjgrm8pjcHPBxcBcl1Ff
	+v4jvdOscCfKDCRnKeAtybOxN7Jt850En6Q9F3bvgh7n3YYASTL/Gu26+u4baVykPTXXVoxk=
X-Received: by 2002:a05:690c:f8a:b0:8b0:e680:616a with SMTP id 00721157ae682-8b4aa32151bmr5071387b3.24.1794516324008;
        Thu, 12 Nov 2026 12:45:24 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:3a31:6c95:5610:70f6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa99f7a1sm4740207b3.29.2026.11.12.12.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:45:22 -0800 (PST)
Message-ID: <bf79e0f0ba166bef46dc5d196b0877dabe252248.camel@dubeyko.com>
Subject: Re: [PATCH 1/2] hfs: do not end readdir at i_size after an unlink
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 12 Nov 2026 12:45:21 -0800
In-Reply-To: <20261112111745.4094283-2-hengyul@cs.unc.edu>
References: <20261112111745.4094283-1-hengyul@cs.unc.edu>
	 <20261112111745.4094283-2-hengyul@cs.unc.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
 NFdvziOa4FgUBC4X71upsZIoZJeii2V/Jtc3B4g==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-11-12 at 06:17 -0500, Hengyu Liang wrote:
> Commit 7fde7e806657 ("hfs: rework hfsplus_readdir() logic") stopped
> moving the position of open directories back when an entry is
> deleted.
>=20
> However, hfs_readdir() still ends when ctx->pos reaches i_size, and
> i_size drops on every delete. As of now, a program that reads a
> directory and deletes what it read sees the directory end early and
> leaves files behind.
>=20
> The issue can be reproduced with BusyBox rm on a new hfs volume:
>=20
> =C2=A0=C2=A0=C2=A0 mkdir /mnt/d
> =C2=A0=C2=A0=C2=A0 (cd /mnt/d && for i in $(seq 1500); do : > f$i; done)
> =C2=A0=C2=A0=C2=A0 rm -r /mnt/d
>=20
> Before commit 7fde7e806657 ("hfs: rework hfsplus_readdir() logic"),
> the directory is removed. After that commit, the result is:
>=20
> =C2=A0=C2=A0=C2=A0 rm: can't remove '/mnt/d': Directory not empty
>=20
> and 304 files are left.
>=20

Currently, I don't understand how the issue happens. Could you please
explain the issue at first?

Thanks,
Slava.

> This patch will end a walk that continues from the saved key where
> the
> records of the directory end, and keep the i_size check for a walk
> that
> starts from a position.
>=20
> Fixes: 7fde7e806657 ("hfs: rework hfsplus_readdir() logic")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> Application impact (Ubuntu 26.04 user space): a folder with 1500
> files
> on an HFS volume is moved to the trash, then the trash is emptied
> with
> "gio trash --empty" (the call behind "Empty Trash" in GNOME Files,
> done
> by gvfsd-trash 1.60). On v7.1, all files are removed. On v7.2, the
> trash
> looks empty, but 478 files stay in .Trash-0/expunged and their space
> is
> not freed.
>=20
> =C2=A0fs/hfs/dir.c | 27 +++++++++++++++++++--------
> =C2=A01 file changed, 19 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
> index b6b8945712a9..b0858512f4d2 100644
> --- a/fs/hfs/dir.c
> +++ b/fs/hfs/dir.c
> @@ -51,10 +51,16 @@ static int hfs_readdir(struct file *file, struct
> dir_context *ctx)
> =C2=A0	char strbuf[HFS_MAX_NAMELEN];
> =C2=A0	union hfs_cat_rec entry;
> =C2=A0	struct hfs_find_data fd;
> -	struct hfs_readdir_data *rd;
> +	struct hfs_readdir_data *rd =3D file->private_data;
> +	/*
> +	 * i_size follows the valence and drops on unlink, so it
> says nothing
> +	 * about a walk that continues from a saved key. That walk
> ends where
> +	 * the records of this directory end.
> +	 */
> +	bool resume =3D rd && rd->pos =3D=3D ctx->pos;
> =C2=A0	u16 type;
> =C2=A0
> -	if (ctx->pos >=3D inode->i_size)
> +	if (!resume && ctx->pos >=3D inode->i_size)
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	err =3D hfs_find_init(HFS_SB(sb)->cat_tree, &fd);
> @@ -93,10 +99,9 @@ static int hfs_readdir(struct file *file, struct
> dir_context *ctx)
> =C2=A0			goto out;
> =C2=A0		ctx->pos =3D 2;
> =C2=A0	}
> -	if (ctx->pos >=3D inode->i_size)
> +	if (!resume && ctx->pos >=3D inode->i_size)
> =C2=A0		goto out;
> -	rd =3D file->private_data;
> -	if (rd && rd->pos =3D=3D ctx->pos) {
> +	if (resume) {
> =C2=A0		memcpy(fd.search_key, &rd->key, sizeof(struct
> hfs_cat_key));
> =C2=A0		err =3D hfs_brec_find(&fd);
> =C2=A0		if (err =3D=3D -ENOENT)
> @@ -105,10 +110,12 @@ static int hfs_readdir(struct file *file,
> struct dir_context *ctx)
> =C2=A0		err =3D hfs_brec_goto(&fd, ctx->pos - 1);
> =C2=A0	}
> =C2=A0	if (err)
> -		goto out;
> +		goto end_walk;
> =C2=A0
> =C2=A0	for (;;) {
> =C2=A0		if (be32_to_cpu(fd.key->cat.ParID) !=3D inode->i_ino)
> {
> +			if (resume)
> +				goto out;
> =C2=A0			pr_err("walked past end of dir\n");
> =C2=A0			err =3D -EIO;
> =C2=A0			goto out;
> @@ -146,11 +153,11 @@ static int hfs_readdir(struct file *file,
> struct dir_context *ctx)
> =C2=A0			goto out;
> =C2=A0		}
> =C2=A0		ctx->pos++;
> -		if (ctx->pos >=3D inode->i_size)
> +		if (!resume && ctx->pos >=3D inode->i_size)
> =C2=A0			goto out;
> =C2=A0		err =3D hfs_brec_goto(&fd, 1);
> =C2=A0		if (err)
> -			goto out;
> +			goto end_walk;
> =C2=A0	}
> =C2=A0	if (!rd) {
> =C2=A0		rd =3D kmalloc_obj(struct hfs_readdir_data);
> @@ -162,6 +169,10 @@ static int hfs_readdir(struct file *file, struct
> dir_context *ctx)
> =C2=A0	}
> =C2=A0	rd->pos =3D ctx->pos;
> =C2=A0	memcpy(&rd->key, &fd.key->cat, sizeof(struct hfs_cat_key));
> +end_walk:
> +	/* This directory can hold the last records of the catalog.
> */
> +	if (resume && err =3D=3D -ENOENT)
> +		err =3D 0;
> =C2=A0out:
> =C2=A0	hfs_find_exit(&fd);
> =C2=A0	return err;
