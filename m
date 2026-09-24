Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30334CA784
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 20:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790280596; cv=none; b=h0rDlUC69Y2PX4a0eSy3M837p8Wc8ZfCasfQhLvAU71zjjclgbQ9T7Pi7dRXTFBfEIsUlJlfH5pzRv5hm5w9W1XUmBzo9DWLT7jXYvPuhA00q47S7hahW/ItTj8cr783ZCd8dJwgFOHd0cx60L5r1ybeMh6Rt+dAHa8Xpm+1CCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790280596; c=relaxed/simple;
	bh=CQTqQgmVstq3o9NzeleortOun0qhbXmPLnoN1FTQcmw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F4iW07Dwjyz3WnnxiUDxfkU6EudIh+we2rVErHFONJwNFwdCZN+v/j2aJS3cFMcIoZv/tXrVkPwlGgM5VNR7WDOPqB8JaXsJxlh+VggTnMsRPqLuYAXbDNmrO0bDaOdDhsDc02mgf1QGgrIBO10+IFToAnE1IoMA0eQGvV7ZNLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=rPz019yV; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="rPz019yV"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a860e532eeso1619707b3.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 13:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790280587; x=1790885387; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rg7QM4KETiLUj6hqqqxzETMVSyrQCG8CKSaSlcksQCs=;
        b=rPz019yVGrH8tG3ukLpoh+8TBaTueCxyo0Xm6fu/672t0iKcb7514UCmxfTKEjB/Kt
         AorzWNwpQe/vb21e4cQP+/UNM//sB8SYbjMrHfxUHFKEEGe+/O92zrJMZFr+QBtS6sC/
         H+2Li4OubuRrN2G8/QfiP6XJ+2MbsREcwn08uG6XlJL+GdUBXZnUeKxg8mDXZXInilVb
         wTEdWDifUeCsfNDN2rw9z3cVHdlDNTXU99RyJrLvrFxUfYn5/ZC6kJRKH3SorL9UAcUi
         kQjcs1rdOcZBh/Jp2ewRswOstp3kyUxWl5pcls9GNYel7nhPCuehtNSm8zBwe9ACQFO5
         XIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790280587; x=1790885387;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rg7QM4KETiLUj6hqqqxzETMVSyrQCG8CKSaSlcksQCs=;
        b=AqfuMOZRkwSPqfCCMtK8EytjHnOx4JQSA5/wZCYXYRjsRDND8pGvZaa9Z617NwUOuW
         bdUaI+HdWXvX3JlR3jeOhHvzJ0R6cK3KNJgYu6riShgTvLNtotwWG9tF6nvpiKxmRbBM
         3WVkcRiX9AD3SafzlvkKbCFpbSYz54QIctcsj14s6RdiUvuFzN2DiSEbV2yDjImF2rjM
         i4001y9MSn8hCwrrbVLXQZwAlEg8vYnYDo3QNGjU5wZ5SH+HhKDgJiRLAzN1L8AsE9q+
         vepuz+MPbRqh8rD2fJpuCgpEc5LIRR9peve3u+A1BYfpbFXBVzJ0ycDMGTv9RKuW47Vh
         MZNg==
X-Forwarded-Encrypted: i=1; AKwUvBzUNLys3hciNujQENWUEDBJaa+I6AHy4yMjfQOFjGhuBjkoyoOcPQWkvbQGVaX8hVMyLKOcpkg=@vger.kernel.org
X-Gm-Message-State: AFuF++nB7HM4e2OQ1bHH3umryxfDNARs4AvK8R1Ex+dxCNcHRhkdE2us
	cr7CE3R9gX813K82Nqucdv4GynRvzW03BXHCH25BiiOxD2NJE5Gf0h0TSkbLbgZc0JZP2q+f24p
	AKoTK5KP02w==
X-Gm-Gg: AYBFou2WpKoW0nvsGT1SkCa8k++fJ0yL3+aZJ6ehYmVrf3J4Vs6/vxSfq9423OXqo1y
	GJluLLUrchy8Qd7A7fIa5RqPb9PJFwt+rkIzuP1NgmTPXhZ8yHLRLESZmQJeVwBs2t2d2zOONHM
	h1pJzp+VXDbBVV5brtV3tp5zoxfaZJ7ZMkqOQW8qPQuVp0/o2w4BAosPORIRae2z36CE+IeyvmH
	enH2Np0ZAecHb358rja7Eemg6oPHUoS6lKsnxj++U+B22JcekMrFoe2UVb4flsLSyAltICkCoZP
	Laz6O3I0CeCZhOsqu1Zbx8eO7Wb0ejwYG1YmsO2CLwlP04XatvOmJVVGTSBBLGOWyru0+3V6IYS
	9OGz6ni38av4Gbx/l1INC3iywjzcIxjAc5Bl8kGP8vLjrbWkP5vzLAXvXpsn9PO5ovvRQR7beop
	N7LzR9g51kUNzeQ7PD4pG6GAqfMow1jZwHn4L/UnhJPbAseE07rxLqlvXojaGHBvwIROc2Cy1Fx
	LmRllwbnTa/Oeu6yzExPKxsANKW+Qu5ObULmt4hZB8VAfwzeRMMvZwLxhAzRCKLmpMHMFJ6/sJp
	VyRCi55MviyhL/mH+qV5PZTdPm7IPjm/GZPE1RBp8zh6NQk+/RHtEYnKxm0KgGTQGsoWUDao2aA
	=
X-Received: by 2002:a05:690c:ec5:b0:89a:63da:fa96 with SMTP id 00721157ae682-8a648ec58e4mr20513967b3.81.1790280587624;
        Thu, 24 Sep 2026 13:09:47 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:4935:3bd4:e0b7:fd95? ([2600:1700:6476:1430:4935:3bd4:e0b7:fd95])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860f85e57sm1357087b3.19.2026.09.24.13.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:09:47 -0700 (PDT)
Message-ID: <2612157454a2e08c4478aeed9df236ab7f0f2090.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: validate allocation block parameters in
 hfs_mdb_get()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hui Peng <benquike@gmail.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 24 Sep 2026 13:09:45 -0700
In-Reply-To: <20260924070410.2629558-1-benquike@gmail.com>
References: <20260924070410.2629558-1-benquike@gmail.com>
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

On Thu, 2026-09-24 at 07:04 +0000, Hui Peng wrote:
> In hfs_mdb_get(), drNmAlBlks (fs_ablocks), drAlBlkSiz (alloc_blksz),
> and
> drFreeBks (free_ablocks) are read from the on-disk Master Directory
> Block
> without checking their mutual consistency against the partition size,
> and
> failure to allocate HFS_SB(sb)->bitmap returns -ENOMEM without
> releasing
> HFS_SB(sb)->mdb_bh, HFS_SB(sb)->mdb, HFS_SB(sb)->alt_mdb_bh, or
> HFS_SB(sb)->alt_mdb.
>=20
> Validate that fs_ablocks is non-zero, free_ablocks does not exceed
> fs_ablocks, and drAlBlSt + fs_ablocks * (alloc_blksz >>
> HFS_SECTOR_SIZE_BITS) fits within part_size, and clean up via
> hfs_mdb_put(sb) on error.
>=20
> Tested in QEMU against Linux 7.3.0-rc3 by mounting a crafted HFS
> image
> with drNmAlBlks =3D 10 and drFreeBks =3D 50: on the unfixed kernel
> hfs_mdb_get() accepts the inconsistent MDB parameters, causing
> filesystem
> corruption ("hfs: (loop2): extents (cnid 0x3) bitmap corrupted");
> whereas
> with the fix applied mount fails immediately with "hfs: inconsistent
> allocation block parameters in MDB" (-EINVAL).
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v2:
> - Validate consistency between drNmAlBlks, drAlBlkSiz, drFreeBks, and
> =C2=A0 part_size in hfs_mdb_get(), as requested by Viacheslav Dubeyko.
>=20
> =C2=A0fs/hfs/mdb.c | 12 ++++++++++++
> =C2=A01 file changed, 12 insertions(+)
>=20
> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> index 277de712f9d4..665753a2cba9 100644
> --- a/fs/hfs/mdb.c
> +++ b/fs/hfs/mdb.c
> @@ -214,6 +214,14 @@ int hfs_mdb_get(struct super_block *sb)
> =C2=A0
> =C2=A0	/* These parameters are read from and written to the MDB */
> =C2=A0	HFS_SB(sb)->free_ablocks =3D be16_to_cpu(mdb->drFreeBks);
> +	if (!HFS_SB(sb)->fs_ablocks ||
> +	=C2=A0=C2=A0=C2=A0 HFS_SB(sb)->free_ablocks > HFS_SB(sb)->fs_ablocks ||
> +	=C2=A0=C2=A0=C2=A0 (sector_t)be16_to_cpu(mdb->drAlBlSt) +
> +	=C2=A0=C2=A0=C2=A0 (sector_t)HFS_SB(sb)->fs_ablocks *
> +	=C2=A0=C2=A0=C2=A0 (HFS_SB(sb)->alloc_blksz >> HFS_SECTOR_SIZE_BITS) >
> part_size)

I would like to see the dedicated function for this check. Currently,
it looks like a mess.

> {
> +		pr_err("inconsistent allocation block parameters in
> MDB\n");

pr_warn("filesystem possibly corrupted, running fsck.hfs is
recommended.\n");

You can add more details about corruption in the message.

> +		goto out_err;

I don't see the point to introduce this way of managing the error case.
Let's return  the error right here.

> +	}
> =C2=A0	atomic64_set(&HFS_SB(sb)->next_id, be32_to_cpu(mdb-
> >drNxtCNID));
> =C2=A0	HFS_SB(sb)->root_files =3D be16_to_cpu(mdb->drNmFls);
> =C2=A0	HFS_SB(sb)->root_dirs =3D be16_to_cpu(mdb->drNmRtDirs);
> @@ -305,6 +313,10 @@ int hfs_mdb_get(struct super_block *sb)
> =C2=A0	}
> =C2=A0
> =C2=A0	return 0;
> +
> +out_err:
> +	hfs_mdb_put(sb);

You don't need to do it here. The hfs_fill_super() will do it in the
case of error.

> +	return -EINVAL;

It is not the case of -EINVAL. We have corruption here. Another code
error should be used. -EIO sounds better, for example.

But we have invalid free blocks value. It sounds to me that we still
can mount the file system in READ-ONLY mode. Am I right?

Thanks,
Slava.

> =C2=A0}
> =C2=A0
> =C2=A0/*
