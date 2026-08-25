Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342602FFFA4
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 05:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787636743; cv=pass; b=YKu3cfMsp7I4lyxGexOnB7FyuAWQ2Y43jBVq9YNYiiDMDyiitkW2gIRDkKSrpBWaatyiU+SYNz5rAlfnyLP95+PWKZkRLtM6tYvxqcg5N4kUiTOhoX1vG2bp0vQJYCo2ASnO6oMW+R6RQ6cwVawjxHSXC+SVjO2k1akWetOZIlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787636743; c=relaxed/simple;
	bh=fVKmBJGxjhinLcjH37If02pe9z8nlCMRKqdziirEWes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QX3ekDGWV6eEVq40NO2pPrz1Wi9aw2HPcxyIoIwG95WlyIBDMYRste72C/ZZe95+p27dDq10ZsSPTmRl60wkxnvWWOSipKcUtSQNqENqAZwFOikW2pbXVua/hIa5VQklD9G5gqHPLiMroJLmTcwFW7Pc8IzpsFFTVUirbmmdU4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEO9dKFh; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEO9dKFh"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b2a22c52c1so4046406e87.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 22:45:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787636740; cv=none;
        d=google.com; s=arc-20260327;
        b=FGr8Raj93vTMCEokmOl/op+lQZuR2DTjSeIwvfejn6oSvaMgfJM8e2sSctqt+kJKCn
         3P6S4hgM/GZsWcuztGSgyjGvwsJ3LRlFw5nNIRudwPNhVRGkHM8HAorTQea1pC1kHM0N
         z+0vKBUnTLgX9CNqoNVJ1QkXOuJgFabXG3T6leL8KRaa45rJF3W9fYRhDfT9o1zM5CCE
         TzjjJLWiTCOLEvPZQkh3mIqEbcT8Iyv9/UHs3uQPqZTxhQBBLu5wwqAGXBnqQa2Fd2j7
         LF3RGdUWMzJeyatYa9wtnZZKskLLi66vkkIq+rY5u6nLI5iPEg4+hyE37t2zQ7lHmRJZ
         o+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nZm3zCM2V5j8UkW0i/0Tml0ywqi5opHYJwOAEvHaea0=;
        fh=b5leH9fA9Xq2TyY5n4EBtfP5P5gLwZk7k85DoHl9zPk=;
        b=D5/xY9aS1RmdI56Lpm3CzAVtyVULQy9ZXe6JUODH/hYDMMCaGAJkD2+J312K7ZIiCE
         Kj9o8uxNfFVVl8r3OhkrSQPIlppw/twncpnN9tZXtOUwK42fKIgjLZwWtFU6AQ4YAbxi
         EQZXa9KT/k1j2ls19noa6OAsux/uBfQkl1dCMZzyNPCp82m2debrPCvn5YhT7g4g3JKZ
         M9CVJENg+pGiVKTBPJ+axqU8fhRxhY+Tj8d5MF4vN97m1mENSFA7Yn4TginrMv4ddpp8
         SDh87BGGkSl0hpVwvuRORbTdXW5JOZNeTJZpafVQFT5qshJdCHq3HBBImfoNhPa/5SPZ
         9S5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787636740; x=1788241540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nZm3zCM2V5j8UkW0i/0Tml0ywqi5opHYJwOAEvHaea0=;
        b=iEO9dKFhqFJ6QsB/o49CjWSsfTJD7JAQquh3CbUZyhSi8Uf94NPSHL8VIxUTwWsOJ+
         PDD6if21msKYGLZmH/6QjecwoJgFfUofl+RZEE3Dio3axXXtWN2s+zArCuEIE6R7xfgF
         LCft24Zo1uVW1MAgntsD5fO2lGX15+ZHdBXC2+yjTyXiCzQPleV6wmYCD44eolmwoHZX
         7bGTV3d9DN0THDCzpzrqYzqK3fNvvWh5Wx//Wbf/kPVmoQf9IAKL6J71BMyG2HbO/vlf
         zs9r7GshxfGe5Mobkbvp0QJkWzvKekpFLUqN7PEFPWVJ8bztgK0bRvdekIuupXkA16i1
         iJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787636740; x=1788241540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nZm3zCM2V5j8UkW0i/0Tml0ywqi5opHYJwOAEvHaea0=;
        b=k/tD/tM8mkBYVFAeLGBQZncWfC4/xOBPcxnRGF9dfqt5hJ48rmDdeQdSx3K6B3UBF0
         2sQIAjVgNJhJtOzX/8BxQj5NDDONyiHcGP1+tzFwiLvuSnjcHQDfV9uct1pSy33pmjAa
         pApKEQviHVsfXE9jMSJAgov3u+/VJmSwjZjSs9/7/tUr+9/ZmStZ0AbbHzYu1KatOECV
         +Le9g0p/Sdih82DvqOTn5DXx2aiUuXGfMHIE3aN0cv7h/xuzXiVJhOnkH7+OPFs/WqsF
         5cFKbSryTjpGdj7aWFJJyfowBe7iIii8bz0vDIO24oAOAlf+8veng8usUBTOD4n3ZnlC
         x7OA==
X-Forwarded-Encrypted: i=1; AHgh+Rrt25LPkBziexA3PtVaKti7KiOrAQqHzk7R+ciKgDFP+DLlVkzPqKRbCJUNqARX1y9Hj82ponU=@vger.kernel.org
X-Gm-Message-State: AFuF++kjsqos5ujvTXmuD4wWvWVuAzyX3Apxr+j0H5f9LOvZuLn5a5Ao
	dpoSz2NRWW7Jp0K5lHaxvEiJN8SLe1yjVnuK532opEG1FNVjyJnqc5gfBQfvM6ee4gZRGS3ECWl
	EvEjWji4y+2rb7BuRp3QkJkg0m845iaALZG5p
X-Gm-Gg: AR+sD13cKNJBwKFJpCtUcNzISBoPBgyf+uTdMYGFzyTmx9TkjHyFW6CNBPLhjCR1tZb
	ZVj3u4jDnCHZ55uZ4TjQWgxFDi8ap7l8lKsuBeB9LquzEiCbSbc4txg0LeMUVYysjXZv7fb6Qwk
	gq8zQ0g6aMplpS6ypMXgRHTzgdk6rZrNr3OA7oM4d05pGDYW3AXYZFVXrhrmK9ppWRDmDzLmBWY
	NqQU3+f52B6KwQ9aVL25w97m/YNK0wAgc53FZRanwEla9L9keHtAz+Xd5LeXsQhrHiFTVTNM9Ly
	hjWSYgIOnCT+VgGkg/o+ar1MECUTpVfKLPBPqacWzVkl
X-Received: by 2002:a05:6512:6c2:b0:5ae:b59e:aa45 with SMTP id
 2adb3069b0e04-5b48b89675dmr6626651e87.17.1787636739775; Mon, 24 Aug 2026
 22:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824075935.170457-1-zenghongling@kylinos.cn>
In-Reply-To: <20260824075935.170457-1-zenghongling@kylinos.cn>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Tue, 25 Aug 2026 14:45:28 +0900
X-Gm-Features: AcwNN1U11ydoTh6uaw40HLjsN2bokfkPv25rkwZoOV36XuEEmlRAqCwe6v9Q9XY
Message-ID: <CANFS6bZczfbx3HKO9pN2wOm9Wy8oCX0GAA_uAoXzhu1j34Jo7w@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix memmove overlap in ntfs_new_attr_flags
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: linkinjeon@kernel.org, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hongling,

2026=EB=85=84 8=EC=9B=94 24=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 4:59, H=
ongling Zeng <zenghongling@kylinos.cn>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> When the record shrinks while the payload offsets increase (e.g., enablin=
g
> compression reduces padding, making arec_size < old_arec_size, but the he=
ader
> grows by 8 bytes), moving the name first can overwrite the old mapping_pa=
irs
> before they are copied. Move mapping_pairs first in this case.

Can this situation occur even when
it is not a crafted image?

>
> Since mp_ofs is derived from name_ofs, they always change in the same
> direction. Checking name_ofs alone is sufficient.
>
> Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>  fs/ntfs/ea.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
> index 534f7efaf128..c836d33ab0d3 100644
> --- a/fs/ntfs/ea.c
> +++ b/fs/ntfs/ea.c
> @@ -729,15 +729,36 @@ static int ntfs_new_attr_flags(struct ntfs_inode *n=
i, __le32 fattr)
>         old_arec_size =3D le32_to_cpu(a->length);
>
>         /*
> -        * Move payloads before shrinking the record.  Otherwise resizing=
 moves
> +        * Move payloads before shrinking the record. Otherwise resizing =
moves
>          * the following attribute over the old payload before it can be =
copied.
> +        *
> +        * When offsets increase, move mapping_pairs first to avoid name
> +        * overwriting the start of mapping_pairs.
>          */
>         if (arec_size < old_arec_size) {
> -               if (a->name_length && name_ofs !=3D old_name_ofs)
> -                       memmove((u8 *)a + name_ofs, (u8 *)a + old_name_of=
s,
> -                               a->name_length * sizeof(__le16));
> -               if (mp_ofs !=3D old_mp_ofs)
> -                       memmove((u8 *)a + mp_ofs, (u8 *)a + old_mp_ofs, m=
p_size);
> +               if (name_ofs > old_name_ofs) {
> +                       /* Payload offsets increased: move mapping pairs =
first. */
> +                       if (mp_ofs !=3D old_mp_ofs)
> +                               memmove((u8 *)a + mp_ofs,
> +                                               (u8 *)a + old_mp_ofs,
> +                                               mp_size);
> +                       if (a->name_length && name_ofs !=3D old_name_ofs)
> +                               memmove((u8 *)a + name_ofs,
> +                                               (u8 *)a + old_name_ofs,
> +                                               a->name_length *
> +                                                       sizeof(__le16));
> +               } else {
> +                       /* Payload offsets decreased or unchanged: move n=
ame first. */
> +                       if (a->name_length && name_ofs !=3D old_name_ofs)
> +                               memmove((u8 *)a + name_ofs,
> +                                               (u8 *)a + old_name_ofs,
> +                                               a->name_length *
> +                                                       sizeof(__le16));
> +                       if (mp_ofs !=3D old_mp_ofs)
> +                               memmove((u8 *)a + mp_ofs,
> +                                               (u8 *)a + old_mp_ofs,
> +                                               mp_size);
> +               }
>         }
>
>         err =3D ntfs_attr_record_resize(ctx->mrec, a, arec_size);
> --
> 2.25.1
>


--=20
Thanks,
Hyunchul
