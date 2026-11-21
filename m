Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795226295;
	b=XonvpUBGU1y9hQHMvWFWG3QsotH9M1aIU0j9bLAqQ2jBuKSFpD0ybZidHDyB+DiMwl9A
	 Zum2m3Dl97Z6n8GofTFI6oITWPinnpow161uypzlxKlP8U1nZ5cWdltCH1/qWEhjZ6yXk
	 9hC62Fvb/lgUI0Rs6C+MRn5x+/JLqbxkJfy+6BRXhDOlEeY2SuUdRxf42wkIJXiMef5EK
	 vF4GqwiF7rcJ1ScbTNQLV6gh5W4UeBCujYiA9fUP02FIVBPiBigbaV1ggKwH8CE4Med39
	 7YSe9V3A8hzH3YoRCUzWmKnt4GjYBp4b5d/OMBVBgYoiYbFObrvQB7BLoV8UCxxNpGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795226295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ViePrhkW9tmaFAR9u/XBSqg02m0Nj6G4/uTmbScrP0M=;
	b=FFjeEpLuGXgd0A4+lj6NyCNu90nUTYWjstGJs0QI5piRVbiEYSWZWECFJij1jw7Xr0S0
	 tIJjKn3Fc/MLwJITPYoj/7jS+87gTz2mnhxLPkSJgMV4VST31N5aXjoH/DUgYRIYZx7vR
	 qoWW7Xj48pzsw4HL6Zk7o3GF/oh/ydzGIzlnS/B1Kaso1vQpVhZvJzDm/xBo+7NIQG7m2
	 BwS9r5QlbLa7cqS1rJIL99JlBiUFqvdKmtqamNIMMszFSPg4GB1YXqpMvXYV08qVXQOwM
	 ITneIbBf6/qRm/5Dd9M8VRIvyLWw4Fgu+6o+9+FTuf7GgvB+9VF/q9uPp/dTE2EvGCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KvoL8HAD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43D606A6A0
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 01:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C43D606A6A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KvoL8HAD
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5bfa65c8617so941542e87.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 17:58:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795226291; cv=none;
        d=google.com; s=arc-20260327;
        b=VHkx2FLA96cB7aXe7BWwP+jWSn1Nj+3s3ZgivgYU1rsrIXrkd1H1Yr+g/aT4JjBRxN
         dVsR4snUS2tpJycTTkzF6PbzWSExSqSxQ3I516rImw7sU1FlUbOQWaoonuz2NuIf+V3H
         E3L4yAxcVlmuyEIKDSZZZrnGbpsqFuSHXPXPtByEEmrrj0m37jECfN8XUyXLYpEfvDB7
         eWZgGxYkJZRXvAYAo9a2T5T6L2HUG4Eq2VnnebVH733K/8kksHO6Mh14E0xOh5h7E/qs
         w++y/jdWQdPQ9sm9sdNUvD8q0crcoklu5P/sfUlRlY67/ZKrhFJkQAhSODklNRK2HfnF
         70Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ViePrhkW9tmaFAR9u/XBSqg02m0Nj6G4/uTmbScrP0M=;
        fh=qd74c63802Tpt/7IDQJBli5GNhr03W3FdAxySosqodA=;
        b=b6vwjzh3yygsunc75uIS+yQZiT+RhcP2fr16VUHGYVyPobkOb+4DBBf2lQhsU0nrIf
         sAJNWR1jU/83VcVZzsreOKRSmVOI95+3x3qSvT14ReLxTilwvOt2XiEfBPBaPb78L/jm
         sAFitZdb8pV2Jqb2Ki+739Nn+qt1S6H82CKb7WGlGKBJjv56lIVYa53mpkIHnV4tY42K
         xPGMK2LE3thOiDUwBe+NPW1ki1nchUsy2QHrtsQ4feNL84XOt6h/0Z6t32B3CeFeX4fW
         G08yq3MTNAUzMIabAMLkJGKu5We/AV0J7mdLuPOI9B3PD45lcP+P7p2kFZgd1Ar0yKev
         9YTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795226291; x=1795831091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ViePrhkW9tmaFAR9u/XBSqg02m0Nj6G4/uTmbScrP0M=;
        b=KvoL8HADhptaP8Sly/9m4hTBRi9BTQAOM8HOsxop7jXKORfHKjHLdZsAhzWMyPi7ZE
         boW31RuWMrl7q9UsvKKHRU8pt+nL1JQYCdk+d6DyY2WUT1SAE8O0UTdmkGlxNP22wFbA
         Si4zujzjCuVc5DxN6WFjUU725qvuTPuye2lrhIB+dqbiZvzx5Q4L75jXB2uJ83PEODGZ
         E3hTLp3AH9g9L5C73VcSa49roEYs9OSuqdRTyfcjohLsziffe7/tdlhjzViUIZQgSMFz
         zFuhtq1GahBT6HKFX/8pilkxZHOd9d/U4/TeITC1AH6AGJ0Fz9pmQo/NOnz/VnmZ/2UE
         v9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795226291; x=1795831091;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ViePrhkW9tmaFAR9u/XBSqg02m0Nj6G4/uTmbScrP0M=;
        b=XRB0edJcQ8FfJ5GiADBRUhwuTzjqtNfWfzR769ZtgTVWXQsNR7Ftzqs2ZKPgbcBGXi
         BhzGsw4ROE8gcChjVK2kiAeCN58Q0QH5zzDpPmyatzSA6FrwEbEexR5ljrdvPW4q1T5l
         IxcomK56R/zNOpx+wewZYa5u2E9AGh46u7z40sIbrtv+JQFoho+0RIoq7V6qC8+UnC7L
         /AlTgZODf/kL50y7w4AP0SAd2oezsT9DW3GqdPoh0XN5zC2vTgmTd25uyodkvw5GYtTU
         Zqo5B3AuICqjlbDhvaMjzASMxKKPr8oDcFRIaOcf7FjVP+l+0UyM5ofHGr9Rg13lfNBo
         Pr0w==
X-Forwarded-Encrypted: i=1; AL+hErEon/xm+XZo8NP/Pp8t4LeCaL/n4EFtF5/FNYKpQCySxxX06FVgrtTi2e9JOv1Q4yzPGnC1zXU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/QDWXXJX7Pxs7Mlvlf+HeybmEpVZ6KySgiJ/6lV0yjT7IVaEhq
	qSoAMGp8UtX1k26Cid5LB1oLhgLzwh8I+KXNqJcn7w7zv9kLHkyWDBUsnZQfQ8bi+HtWbEDosK5
	vsP9Ev5JITqAs9NosE5OLgb1KS13ETLOCiX8FfFE=
X-Gm-Gg: AZFdTZdT9NrCdr5d0hbzya59pyiP6yghle7bsgMfD3plqHNNl/+09dD0w+/JRSXHmTp
	p7ixqfptojAtscaetLVzoMLLflQWeP6qm5ptY3JASCuG+zKT2JrXHfF30fLH8/sLmQavkuyXxI0
	bEycPLsIpjcF4EYUxjBIzbvhD5lctleA7gnJ7rJoWkFKF3/38PhY7s6V3siM83wTeymp9CgwaWe
	jEu9R3JCr0zLHyC3brlBGJ/gsIUtys2dEX2eVFM2ZfJ48VXb7PEkAnqHNJQiJ6bty45UeqdhwIZ
	bJSARRIPaA4oMpZshcxZCgQGLKZr8yaCepeIufCsia5jT7dDYgep7u5c/girJZ5ua4DRi3JHwvq
	0ercmW2Tv5c4AdlY0dk7RRrQrVwPo20krHJ8+
X-Received: by 2002:a05:6512:3c8d:b0:5c1:ac77:25e with SMTP id
 2adb3069b0e04-5c1bc7bcc06mr1704756e87.14.1795226290518; Fri, 20 Nov 2026
 17:58:10 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120155021.1618964-1-liubaolin12138@163.com>
In-Reply-To: <20261120155021.1618964-1-liubaolin12138@163.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Sat, 21 Nov 2026 10:57:32 +0900
X-Gm-Features: Aa3M54pm2AqGJ8rfhMyI-qjsY_0TNOQdzS6bz0LFsIAGC_D4K0CAlmgi2iF89qo
Message-ID: <CANFS6bZHFoG-6tmH2squCBbfzEmfGsfcfuf5HRVq5S0=qhGHxQ@mail.gmail.com>
Subject: Re: [PATCH v1] ntfs: limit MFT mirror comparisons to system records
To: Baolin Liu <liubaolin12138@163.com>
Cc: linkinjeon@kernel.org, d3nchk@outlook.com, ntfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 11=EC=9B=94 21=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 12:51,=
 Baolin Liu <liubaolin12138@163.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Baolin Liu <liubaolin@kylinos.cn>
>
> Windows 10 can leave $MFTMirr records from record 16 onwards stale on
> volumes with large clusters. Comparing them can falsely report
> corruption.
>
> Commit 749357bd48c1 ("ntfs: mount hibernated volumes read-only regardless
> of errors=3D") made these mismatches force a read-only mount even with
> errors=3Dcontinue.
>
> Limit the record checks and comparison to the first 16 records within
> the mirror, following ntfs-3g. Keep reading the full mirror for runlist
> mapping and location checks, and leave mirror writeback unchanged.
>
> Fixes: 2beaa98b46c4 ("ntfs: restore $MFT mirror contents check")
> Cc: stable@vger.kernel.org
> Link: https://github.com/tuxera/ntfs-3g/commit/85e208176ffd16ce9a51a9f534=
b194f0ebbde6e3
> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/super.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 98e6449fd79f..103d2b1b630b 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -1207,6 +1207,14 @@ static bool check_mft_mirror(struct ntfs_volume *v=
ol)
>                         ++index;
>                 }
>
> +               /*
> +                * Windows 10 may leave mirror records beyond the system =
files
> +                * stale.  Read the full mirror to map its runlist, but o=
nly
> +                * compare the system records, as ntfs-3g does.
> +                */
> +               if (i >=3D FILE_first_user)
> +                       goto next_record;
> +
>                 /* Do not check the record if it is not in use. */
>                 if (((struct mft_record *)kmft)->flags & MFT_RECORD_IN_US=
E) {
>                         /* Make sure the record is ok. */
> @@ -1250,6 +1258,7 @@ static bool check_mft_mirror(struct ntfs_volume *vo=
l)
>                                    i);
>                         goto mm_unmap_out;
>                 }
> +next_record:
>                 kmft +=3D vol->mft_record_size;
>                 kmirr +=3D vol->mft_record_size;
>         } while (++i < vol->mftmirr_size);
>
> base-commit: 4862a81576e3b20ba40cb94a38c5df0450047ffe
>


--=20
Thanks,
Hyunchul
