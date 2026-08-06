Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43427384CFE
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 05:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785993598; cv=none; b=RQ60Kuk+Vw1DYRg5a5kuEYxrZYIs3FeMfc/swpBYZNCU8f1kaG6f7+6PT8y1hRk2HEpmRZ9W52E7edFstrc/8jjcs5UmbI+1lD15Uj39gnyYw9CqgXmtZRe9zRs1bqKHqer0XrGrMfzVW9LNPo/cpoCejMG8+p0OkU1l9VcXK0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785993598; c=relaxed/simple;
	bh=h3B0Vezh45bp+syJ6ykSwwSFwyswAprgVvK7vldvF7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLk57QBoNqJfFHg/VcatnSyA/evY0XP48BsFbylhklKGPSN0/t0PlALntpvBn+vvOGjy0EBF5UWsNoOwgrq9fF6RwppkrJ7iieRCJs0owlp5xSt5IyHU1iNZ01+nNQsyzZLv+/nzz8mrlyOzSQSJcr8s6Ugz7t0rYvD67obx0aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBis4whZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBis4whZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46801F00AC4
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 05:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785993596;
	bh=b8whuCMGhsKq/LH0NvSUcTIg3gAsgHMfunKkOmlEMio=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CBis4whZds88XVH50UWb2WVKpzccj6Jzgnunw2rRr0IJoSstSosCXZ+PKMIwg6bhl
	 sLa4pl7J61hNkNIZljmPdksrSULiWj5jagoFErkmvqRV1C93h++HchVa2X6fHmbIO9
	 R8A7lBkxCyN2v+IGr6W4vjIiT03hSfcN4liKrEyYoJvyiWyKHD2H45LMvnxwwOQED0
	 32mvUAUQexnzp4w0hGlJLWNqqpni5hf2C5slRRsK733nXDMSl/aLmJoCj0gkq7iBqS
	 BCp5LlwTft6ty9hjvNaSQzD1LBVRqQNAOiOMACJTbzINuV6fWid7akyakIJfzo55zZ
	 aMdH2/eRhcynA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1670dad7a8so264561766b.3
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 22:19:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrhgIswCh4vdaoGLoi0S7O8+x6x0aXClOJsqZcQehGRiOax3mb/bqioE00rKfii9MPcioc6218=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY1no3WDiKOsCGtMSkjZAXN3JG5BdWI1GawRoxQK6o7Yq015/R
	pXkYpOf/6CdsWtwuoElLKNGjq+xDxwpypqRKCQzDPU32UEqNK9B42uVyJdBaxC3D4qFhG95ORbZ
	6WCZRJ8ZN0mDYxsjt2RFviI494C+zTSk=
X-Received: by 2002:a17:907:9410:b0:c19:523f:5a0 with SMTP id
 a640c23a62f3a-c2039b373b4mr556793766b.11.1785993595492; Wed, 05 Aug 2026
 22:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806013903.8526-1-zenghongling@kylinos.cn> <6A73F3A9.7020608@126.com>
In-Reply-To: <6A73F3A9.7020608@126.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 6 Aug 2026 14:19:43 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8xYZvB1N94+wPEcvGRVeBv77vfPXX2DKDbg0Rna8hRFw@mail.gmail.com>
X-Gm-Features: AUfX_myQIAvDC1YdMzdLaqH2q-orUwM34tqAXVhglKPDiU_ekBatU-cCg0BE234
Message-ID: <CAKYAXd8xYZvB1N94+wPEcvGRVeBv77vfPXX2DKDbg0Rna8hRFw@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: fix name offset validation in ntfs_non_resident_attr_value_is_valid
To: Hongling Zeng <zhongling0719@126.com>
Cc: Hongling Zeng <zenghongling@kylinos.cn>, hyc.lee@gmail.com, 
	alexandro.calo@nozominetworks.com, ntfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 11:39=E2=80=AFAM Hongling Zeng <zhongling0719@126.co=
m> wrote:
>
> Hi:
>
>   Thank you for the review. You're absolutely right on both points:
>
>    1. name_length is u8, not __le16 - my mistake.
>
>    2. Moving the check outside the if (name_length) block is better as
>       it covers both named and unnamed attributes.
>
>    However, I have a concern about using ATTR_COMPRESSION_MASK here.
>
>    In ntfs_attr_update_meta() line 3610, the actual conversion check is:
>
>        if (sparse && !(a->flags & (ATTR_IS_SPARSE | ATTR_IS_COMPRESSED)))
>
>    This uses ATTR_IS_COMPRESSED (0x0001), not ATTR_COMPRESSION_MASK (0x00=
ff).
>
>    If a malicious MFT record sets flags =3D 0x0002:
>    - Your check would skip (0x0002 & 0x00ff is true)
>    - But ntfs_attr_update_meta() would still do the forward shift
>      (0x0002 & 0x0001 is false)
>
>    Should we use ATTR_IS_COMPRESSED instead to match the actual conversio=
n
>    predicate? Or is there another reason for the mask that I'm missing?
You're right. Can you send v3 patch after updating it ?
Thanks!
