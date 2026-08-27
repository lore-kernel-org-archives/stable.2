Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3431D72E
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 02:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787798643; cv=pass; b=kWeUP9sn/ZO6M6FtPorQRz8t80ccHOzRwl//heLqkQqGHt65LmgojGXbviqF2LI9OcfSUGgjMlB+RThdOqEy/RJPLbqooVuOGpzFX0s0bQe3UOz/7bufsUZF4axIeDkCaORK5v9WJTJ8xHHXY0Gy9kb37xH4CRUurinvNl4/CJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787798643; c=relaxed/simple;
	bh=TTZYNnPP9NazSWxhID0pmfTudmtLXlSKGgVSNsokZpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYaHtFP4UNr/K/o5CnPFN9y+5iiB2+BnqvOT6xrMFId2d61aylxQUGaF6ntVRcECsa95rBGGnBb3w221qvSsHT9xxO4HUSYKj0E4ii+9hVCRmV/gUfKBiZxoUGa3f1vKYXPyk737T5DFV7lOFD/0Xa68s9M4vgOe8TRsC2Akkn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APPs2eR7; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APPs2eR7"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b0f19bea2fso1514775e87.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 19:44:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787798639; cv=none;
        d=google.com; s=arc-20260327;
        b=pfHjvsTXdZ+PSqRPiTQ7k3RrgNVG+bvWy6KlbgQasQE6QL6GPorXvM9hOzuhUFShLj
         7TqGmOTz6soi+cCxmjDDf0tw19RLWQ5OaO7WIaTJJ28NK4oZe2sU4LzV1hgqaTMbx2Fj
         wQRve3lzr9lLS1qE0m2uDEpcp8VstEIh4GFpfppuQBWJlt+sHYc7Yz7LAFPQu6KYZvqG
         HGZVuoWpFfC/e4W3mHkQCFHpe01gMV6xMiJxzI87QymKSrX+w+GnoIbIXSAj4CIeE8m8
         pJ4vJEtusbreyG5EzdO8wxOQWJ3K19U2u+b1OPQ/0MCW81ARx/jvLTc9UOEyaE4kPcUA
         fyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zqvJoTlziQDX70znP8ECNAInbQoTi/mvAJEVOqS/Uf0=;
        fh=FNscpCu/cdQF0DlcWQXawwaWB5wz7tCrZACrwMWogRM=;
        b=B+qg/jSBJrzLiehpRyXNlVptRQ26MnAV7ehBmQGqQjwZFcS2lvlwm0v4L38oTQLlHg
         b0n2Ceb8t1Tbsk6ne6GFY4xluYyXPhd4ThhepUS1gOZhvG/KpHWFttM7htt80lE8KIsc
         OMCxldklG+daqwzeGrVjJb9Iy6FkmsbKZMi/Z1BM61GoxM4PZPNS4BCjbfsC/PHiGQdO
         bPNylBurQF8jtnyigy5zy/vBwKYY4VC664vGC0lQNS4h1pWmOlYxN3eCC5zALkcWQn+h
         MIN1qO54AS8BH06yfoUitr0XI2uPkpUtN1t6fZM55ge0vjfNiGwUtHlTEzXrFCVE9n30
         2kgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787798639; x=1788403439; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zqvJoTlziQDX70znP8ECNAInbQoTi/mvAJEVOqS/Uf0=;
        b=APPs2eR7LGjXSZS2tCOFtLY1l3p6l/TwBl8zL/tnrNVk0pLF9E5fDKDmaYwhgAZaVU
         vmmCjpVl8p2Xz5rsqcyWffuzqabaQ4Y2Z1fGjIEXVUCOuXOmHb9RPMx5wmJRtaI4b0+k
         i4ycxMOEdAnSi+5LpY1/VRx7fJ9SlwoNKYrOl9+66310zH6/GS8iGSZm88I8ckcwDBfi
         7NZq7c5+VxnYnMy/NP0pFPQC4cPCLJC7wNTJs925DfCBNoUz7yQu2SWZnKDzhEkmw/Ri
         TdF0CHXRxjoy+FbvGBVhXBZ7KOuubk+tjXCoYwMyJUKi7ufPKfTvaoHnyeIM2BqF9EYf
         a8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787798639; x=1788403439;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqvJoTlziQDX70znP8ECNAInbQoTi/mvAJEVOqS/Uf0=;
        b=Eu8tSoOocXB0EUSX33H/jBmOUQ9ufNfqYoqiIFR1tZFqVQ/p+1kfRr9ViLxmjnRxs4
         wET5urGRkQYGRIe9CRq4Yx3xsnDhCqOTYg3z8yOy4V1MWsR4tETzXW6VV21+KwSyGfHN
         /rNbzvFHgzlmZFUlEUZslJ8rbEbc0GQgzU2f4DAJWm9tgZ9SrajPIu1w5cnRx9LgOGWy
         uA5aPHWNUlAbHl70atONlGBeffSkp1dyFzaQ0/6njGy1nKydSEtIpPvjCs5AlbVsKNL4
         pen5QZWDgUgpA2qHXCt3g2m0upABDajNH5AnlWDz9wOHzuAULh4IPKUTkIuz/S0KgWXE
         ubhA==
X-Forwarded-Encrypted: i=1; AHgh+Rrdhj1jiQYe1wP+QntaHFC6X3G4d7BGhe/Mljew7jcYrebccnWmsNo2xSQJNhm3CIisAx0RHqE=@vger.kernel.org
X-Gm-Message-State: AFuF++keL6LCsXzKyMvU2NMLSii6tgQtvYkjStj5M8sqSvCksqIwwSUa
	UzC2e5Ujb3UQN1l4KJQ4ob2ZOAxrZeNWeNiBR9AruiSkRhYuh6o4IxkQQYxgCF+XkqY3EQ9xXQl
	8xKcNTS2d9Svk8m0789OoglaLzW8k8LFROw==
X-Gm-Gg: AR+sD13Ehj5wO+vNVelmpLep995T6KbRX3E6CbbTi7xMolmr3J+rbhhMW6dzzhsVmku
	XIvVZZxXWWsnzTsHXDL0nxQwhVrmaKztgwvmNuF+UzPnBkhw0r82Sqk7641eUo/bmhyAbeVYe4P
	oZNIuozMuZg3cEZju1H6zwCFiSL0Ts+0N/CSsnkTEVkTGRgMc3ZDVGxQ+FAH1BvEvsNTsng7X+e
	/Db/LPmNGwmOSA3vmV7IgWlJ9OmqRuSlalgT/VW2cDznn0XYQCLb7swhoQGBXloVJba+4ripzK4
	R3X5lvMhdh9ATcsCxtyGceSU62nxjJRtXM0NCUZNSJQ4
X-Received: by 2002:a05:6512:10cf:b0:5ae:b969:417d with SMTP id
 2adb3069b0e04-5b4a8e672f0mr3686763e87.0.1787798639149; Wed, 26 Aug 2026
 19:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826054204.1364589-1-zenghongling@kylinos.cn>
In-Reply-To: <20260826054204.1364589-1-zenghongling@kylinos.cn>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 27 Aug 2026 11:43:46 +0900
X-Gm-Features: AcwNN1UkaDT5W_Z6HI7OoA4IkQTjvljt2A2kTCf4G4MSGG4h02_YbW9SMmzlD1E
Message-ID: <CANFS6bbVZ3jZa+a8FTjz1w3RuPvFTgjfBh134J4a-9fK549UxQ@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix race between fallocate and mmap reads
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: linkinjeon@kernel.org, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hongling,

2026=EB=85=84 8=EC=9B=94 26=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 2:42, H=
ongling Zeng <zenghongling@kylinos.cn>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> The fallocate implementation only takes invalidate_lock for punch hole,
> collapse range, and insert range operations. For standard allocation mode=
s
> (mode =3D=3D 0, FALLOC_FL_KEEP_SIZE), the lock is not held.
>
> During ntfs_attr_fallocate(), new clusters are mapped to the runlist via
> ntfs_attr_map_cluster() before being zeroed by ntfs_dio_zero_range(). Thi=
s
> creates a window where concurrent mmap page faults can read uninitialized
> disk data.
>
> Since mmap uses filemap_fault() which takes invalidate_lock in shared mod=
e,
> it can fault in pages during this window and expose old disk contents to
> userspace. This is an information leak and data integrity issue.
>
> Fix by taking invalidate_lock for all fallocate operations, not just for
> punch/collapse/insert modes. This prevents concurrent page faults from
> accessing unzeroed clusters during the allocation window.
>
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>  fs/ntfs/file.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 88747217ba61..6958a1469fb0 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -1153,11 +1153,9 @@ static long ntfs_fallocate(struct file *file, int =
mode, loff_t offset, loff_t le
>         }
>
>         inode_dio_wait(vi);
> -       if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
> -                   FALLOC_FL_INSERT_RANGE)) {
> -               filemap_invalidate_lock(vi->i_mapping);
> -               map_locked =3D true;
> -       }
> +       /* Take invalidate_lock for all fallocate operations to prevent r=
aces */
> +       filemap_invalidate_lock(vi->i_mapping);
> +       map_locked =3D true;

map_locked can be removed.
Otherwise it looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>


>
>         switch (mode & FALLOC_FL_MODE_MASK) {
>         case FALLOC_FL_ALLOCATE_RANGE:
> --
> 2.25.1
>


--
Thanks,
Hyunchul
