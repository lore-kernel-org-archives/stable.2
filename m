Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5622B2D7
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 00:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783297543; cv=pass; b=qChIO9z1dsAi9JXer7o8IvmcNGb/h7CwOXS3t1Zmm/zj10IBRbz5u+UnsLym2Dfr83Y8qW2HwrSHm7Cgj8xQmZGPpsCZC0FVYibKTK8h8A2CA7rgsYGZUr/8nV0/0MEKOJhEEPUtwylVSge5dCxqOIrOU4DzkdXxV9bY92eBPcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783297543; c=relaxed/simple;
	bh=DT+z1Y1+R31jv9XpirsEiChiGFeY4BwCSTaKiootkMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ekm3CzzhVtgU7CYOQyZFzlp2m6hcPxT63LniHG/cTvPFCjX+99xCvAn+2SXjvTl2OHcZ6t6VsAVGMiYFcAMDFEtrPztJ5ym5+Ew+tiS1K6h0Hx7cRIVYed8bkXjT1QpmIoWm+ToBxFvVPgKfhXxufCh5S3Fvlrn3XPUy+KR3PL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awTql6/9; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awTql6/9"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeb2b17167so2992271e87.0
        for <stable@vger.kernel.org>; Sun, 05 Jul 2026 17:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783297540; cv=none;
        d=google.com; s=arc-20260327;
        b=iVp2gLvgX0JrSbz4O8QGgZTTKumWEc+f7j9mpFlEeWmD3SQRiCRRjHeHNtlRhhPczI
         OyTcj6UEg42aqQ+xsEwe4RCwn3BnkbR1brfh+x0AgseCLOfbYdZ/wbCiKLlTs+1EEGM7
         o2U+dcCNB2lvscd67kbtN17DB4TQQDhAJzuYGKU+QgVL0adRtUzbQ1c3JdMAKGzGoX4E
         oWyvabXVq8uN4pAxnc5t2T2sqN3drtdgD87nrPznQrvZXarr3n1MA9QsGckLuZB1Odwr
         +MMDG4nzd35zAv8JULu6UgmJ1yh1Px4iVLsAwWw8xSJb1tsBhNYhlWsHIFWvlaijvNFT
         aBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d9E3SIQfAuL6IPexY6CDkGAiXkVbs7KgM9pILjSs0EI=;
        fh=JmtY2xovNNLE+7I4LlbpncPM7wxV0/FkrVn052Iyki8=;
        b=LMJorosaVUZwtXUWRzqPqOG3KWsUJyPhOxvHkedcn0qUrh9ZXOwkv/W5Z7s/CcTsvs
         J7FvHuSujjJPM8mWpnLxvv8uWs1BB68zBcyzkPxNgSSkoo4V/uQ3VenT5Gli9tEgV+QB
         cIB0wefigCd5c+oL69wejtiDGjfhCIgubca1ucYpcmiE8N1b9P5cWH7mtz9futgLBcyc
         qc7OVOPlkNuhHCBF5rxwRH6tkCW/DQ1ZBKddMOGeM13fKg7nguTddGsJ45CwEanfxNjN
         fFbg3z8ewU2JDxRGfajSReo7vlwYAQkOKGQCHlmTXEASHBNFUxc6GQ5BDxU93jsC1RW/
         Q+tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783297540; x=1783902340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9E3SIQfAuL6IPexY6CDkGAiXkVbs7KgM9pILjSs0EI=;
        b=awTql6/9PuucrMnqXALO/X6AWzqbnQX19qvRDMbLA+Ob7+MdidtpiLEFiIJzbxBXQ5
         K4dL72Qq8JSuh0fhbGz2fI/+SuxnDgBfe8yJFmJWcxiJmeUfAn0zGxqZ1UFDrQ+xDd1Q
         49a//ZvIknw+SqsIhQGHUuV2UVxXXNpKwrBP6Wp/kl+n6DDgf0U4ww4XfAMo4cFUWGWs
         FikDRSotUiVeHwRQ7FXzMXhJLYwft/YU126puf1KSKjlnVH/yVMqrznhlZWtdxRUdBDo
         qeI4dLtm+z2GwQRVO4r0UOC9cS2SrseF6HCDQ/EniCTYYy1bjK9T60b1b/2Js3NiabW1
         9LhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783297540; x=1783902340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9E3SIQfAuL6IPexY6CDkGAiXkVbs7KgM9pILjSs0EI=;
        b=jvNDdJo7agUlOYuEPA6pO8aWxeOk45aeoKTpq3vjqF2eRXmCNMb0xtMvmN978WIiF+
         cNOR8AF45ljyEaujnwyPbYdAUtuTsuRMaHsVHVB5PYTPHUOUc9sNenUD09cb0WnnJ1zz
         V7EHQIfrTn7f2+KlS1VFFonKpykgOZgnPhejp5tlPVM4QubdFpaMGK0EO7ugrYn36P7K
         VjWqlNMMjKab0ZyuxQ9RMldEKcJ31vUFmzxI9dCsmAAoIAqW27bgmlUs6LpgyfLzSrAf
         RuO1ImSldTlMznhrXgBVAL7mLjb9IvTU5XNG1IRaqM6iGLiwaHeVtgcpCCO2cgWA5CTQ
         HEqQ==
X-Forwarded-Encrypted: i=1; AHgh+RqrK4HD9qVEJ1XNONoy6aFdE1Vs6ItdU8S81+4Oudozy61rUxEUO/24P6Vv5Bk+Y7gC38KH7t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWENOxcmUqd+zrJZW2gz0W4aVBfU+G6bp11bBIgnJT8+patx4l
	SY/uCcKMeGeTQQCMzXfZt37O0rcaS9tN8g4251dcwc47C5Tm9YA1bTRd6toO1isQ+ynfO2k1MAh
	MQXJGAqKnwPEvcsvweoYJnstihLCzVx4=
X-Gm-Gg: AfdE7ckDJMfI2FFCeGZ5ziRSwC/2k+qNA+XmDE6MzI3+KLUdXxtaA51Y9eJbDVnypZD
	y6DvLsNOH/N1eh2Liv2h5rxPP7I5d/jAXrJMGfjmBflnAddPjbK4LUAPu8ggi+ZdS7fwvwq0gKC
	VqFNw3dpjXXb6x/xt/q1VeIav6Ef4aPFgfR7VdTtckc3XAJt1tZlfPDiqmVON5U+TEIJQoL2cF2
	0oMdUTcmy2GwbhajrsuUy3hzZ4aG9H4Ysvab3KAkOuKuUJ8RENrEK0iovoDg1yZZ0OMj9gD/c/I
	zxgOeUk=
X-Received: by 2002:a05:6512:b94:b0:5ae:c2ea:b3f1 with SMTP id
 2adb3069b0e04-5aecf4b8764mr2461325e87.10.1783297540126; Sun, 05 Jul 2026
 17:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5A2D944D5FE68879+20260705100554.3797781-1-peiyang_he@smail.nju.edu.cn>
 <01B02B3C02CE4CD1+20260705111409.3834024-1-peiyang_he@smail.nju.edu.cn>
In-Reply-To: <01B02B3C02CE4CD1+20260705111409.3834024-1-peiyang_he@smail.nju.edu.cn>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 6 Jul 2026 09:25:28 +0900
X-Gm-Features: AVVi8Ccin6hdwwNj7OHqDu4688cL1PIaoZ995U2bRzdQdRwitb6Fb85ob2Ln5jc
Message-ID: <CANFS6bYw6Cpf=JkZquN1OqEGwi5csC9ZDRwK8CQWAYDeYRHSSw@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: fix hole runlist memory leak in insert range
 error path
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 5=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 8:14, Pe=
iyang He <peiyang_he@smail.nju.edu.cn>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> ntfs_non_resident_attr_insert_range() allocates hole_rl before mapping th=
e
> whole runlist. If ntfs_attr_map_whole_runlist() fails, the error path dro=
ps
> ni->runlist.lock and returns without freeing hole_rl. This leaks memory
> of sizeof(*hole_rl) * 2 bytes.
>
> Fix this memory leak by freeing hole_rl before returning from
> that error path, matching the later error paths in the same function.
>
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
> Changes in v2:
>   - modify commit message to resolve checkpatch.pl warning
>   - add Cc: stable@vger.kernel.org tag to the commit message
>
>  fs/ntfs/attrib.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index dd8828098511..55603df0a2ed 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -5325,6 +5325,7 @@ int ntfs_non_resident_attr_insert_range(struct ntfs=
_inode *ni, s64 start_vcn, s6
>         ret =3D ntfs_attr_map_whole_runlist(ni);
>         if (ret) {
>                 up_write(&ni->runlist.lock);
> +               kfree(hole_rl);
>                 return ret;
>         }
>
>
> base-commit: 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
