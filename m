Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065883C060B
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138934; cv=pass; b=lWtH/oivPQguWG+0xSXkpy2ov0EFWIhZVPhONkg+yyEvr/A8QDV+4oucUOuI8jT7hFRDoplFc9fWZ1HSVIBSYilLc14Ma5IDvW+oZwkhcX0lgl7SScB8B3gvevNAOZMDoFyybYxxaTNfgUNnuaALhLUm1YgRCK6k4FP//gt5es0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138934; c=relaxed/simple;
	bh=5kiKMGs8UaV/eHteQs7xbhc5GoA/wGvkbIwlpvrZGQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnoFnJPk04lkdppL5VHoVomo4mDu1u/Q3F4wcHrkTTwlxRqmBNQcwEWMc1oeyjx0jHDmFebrkLbzEGxDo8VtbjLju+XrG/D5rViGb+DcWiCcQFBJjS5ZLgYF7R/b23TeHisxYZm/zj7SKhK9pHJv9xX0zCLXNiwRShyMrppc6f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAROu274; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAROu274"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66843304cbaso3395331d50.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 00:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785138932; cv=none;
        d=google.com; s=arc-20260327;
        b=VKQTJllnGGWUR1XQMbE7nPZREzkUTrrTh1sN0q9Y8tJHDWMb3Q6Gk51xkjrYaqEL3j
         WZUA2xWBEwdW3CIdj7RdZuNsTz5IWWRCWM5l6BjRMJP0WeByrO96mKFyKTY2QJuZoWdl
         kc2mteODRt4c2nzzDYfDqwUb2HnZ9IbR7/oKrzjGLirrJ2osJQyeHczwv0qD4T4Szt51
         CmSi1rgHoIE7IpRFFtQgVslB6LZ3ZT28LW5SV8/uEyQH1XSsLCOWDXOKQCdMv5UTc7p5
         rsek3u620M3pMUyNBoP0/tLttUOJi5wXP3ROo82YAqXHgADmRBaIZwZTZ4/WkYbSM3Zk
         QJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BUifjiB5LkuqwnzVZHJ+zwFcaQ7v2d/LZe+mtk+fDr0=;
        fh=VKojZImqsqk8W68BmVyF0TbVyYs1HLwbts6Cu4uVOqo=;
        b=aCGZ6YIlVT5Hl0uhLV4R56Vhh5O4G2fks7H+Vc16/uXpParnizsdQ10tU96cOUSLHD
         1StzVbtwlGRM4iYHOJVE7w9QHZm47pRoNliTxjgqGg2x3ZiKgwGFUZbquOxJp/NCyVGS
         oLlV1afTLfMNE4RZ0AF6yu6FNw4Y7SsSp80HfNNk/UujIUi3SMSFsiH13bfxpCacEI6H
         o5u8uzY5320nxIU9NZvsp5C+UjDfdGJR6KnJa6wH/EKe9cfTt5X/Ue8ijEsyrvrdkLiU
         049QUZnjPMG9PloVC4HsRNYmYrNhM9uLTdVVvYR/bhIcFPLpvLEnVojP9IWKvKIXIj1r
         S48A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785138932; x=1785743732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BUifjiB5LkuqwnzVZHJ+zwFcaQ7v2d/LZe+mtk+fDr0=;
        b=MAROu274SQTOfRLv9T6l2eqx2xRmi4+Ib4NjO2NbgqWnb2AIkRdyU7eK/KkcNrat/e
         IC9JaAuy31O6TmsTE3P1C0pve2o2KLpKaZz4ChVPCPnAvVBmTnuJsRhXi4rk8hSKknar
         8MigRBA/UJ6DWnuHFaXHR9WNkdx7WRyW4/BsFYwYdO7XeE8qB7+SIm8Sl+eDKjCuXwbM
         XQxI7lIy216ODbGBIUYkHkLe9fPVh23xTYKzSnQ0SA9S7Yhzh5ERKE0v60FBaEtyotUF
         TEHpo6W3nRpV8sWvpo3RRWxyFMrqyu+lJhqC6GZRBxm9qinDW6G6XovuZxmWNS1sejX3
         NIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785138932; x=1785743732;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BUifjiB5LkuqwnzVZHJ+zwFcaQ7v2d/LZe+mtk+fDr0=;
        b=ssT6Z6RRzu9GKjhDU6fjR2FbIMpSYPXUWLO7sJBVCaaZVoyEoVyEN7a/W1PArQVxjx
         QsoTh93Gh9jtOSYZZCOlxKRClqxWpsSzd7Fu7sH+cfeFSPBv8W2ePE5GkJsPcJ4Q1nMx
         5nHMSlhGhrwk//xAjJpE7OlkjpoTHHMVNN6cAXyFNma2zNIM8bXUxCrp1SZQBMPzoIge
         VLEz9fZwxSQYjnOgf8iw4imtKYPCxB0C3AaPOXwb+cTzmqz/yUqt+S17AbW0yryWZbgW
         F1eUqbDhWrMHWkWs3ANwbHgGQZ5Uixj792o7TUFoGbdVeCtYIk+O3dNNpfYe78yAxnG3
         zbeA==
X-Forwarded-Encrypted: i=1; AHgh+Rrc9+Uu48FJXlOleGJ1eWYzhFEGcokBSwBp7uZ12acVSjier83O4QgZqkA7oAY7CQvJITDnli0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz58TMXv1TOstGMFSbUzYjb1Ac4v+FTi7+pUVnaKQckT9FJ6rzb
	TiG48UqIoN2wHG1Wz7q3CglrcaV2V9Jcj8CE/7PucE4v5O8ArUirQsi59w0WI6nVrHZ5wWRkOBb
	MsQJ4WMDS1YONtPA8zfayJengrRIkWuM=
X-Gm-Gg: AR+sD10zjIGIHJTQ6wgNE+NCNgXNm3VFZ2L/bCO1yGaylE69CaTTbmDp7nEREdMk8na
	k7sYYMOmYxPa8PuC1YmIe/toWIT9IVlFx/zJISblcvl6VRGy3UIOAbZsjg3XG4g5KYM14Zs+NiY
	ryV1z4clr1NQoYetkpjgJG+eM1DjYBrcMCzy1w0nq6/ZK2TXyVu17GV/dO1PUhCLLRLxDKtvgcU
	SIBtzzLD3pszxTDDFuWRbgdUZpUBMihaKL+j8mfrRGq8LU19c/bqmE2tRSUCglPILHn5pRmnnuA
	2D+2qtGM1OPexhztPJE2v3PTvnjlwAr6icCCRDMM7lUoqvOWHgxzy+M=
X-Received: by 2002:a53:acce:0:10b0:668:96a9:e6e with SMTP id
 956f58d0204a3-668c7a3d204mr1641353d50.40.1785138931899; Mon, 27 Jul 2026
 00:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615070530.371640-1-james010kim@gmail.com> <20260723235220.588424-1-james010kim@gmail.com>
In-Reply-To: <20260723235220.588424-1-james010kim@gmail.com>
From: James Kim <james010kim@gmail.com>
Date: Mon, 27 Jul 2026 16:55:20 +0900
X-Gm-Features: AUfX_mxRttKxLzXTwPT7oMYpy4EfbZKaNTiYZJpbiHJ-MwoztPSDUlB2viFtbHk
Message-ID: <CAPdMtffZuRXKJgT+RKtzWkqnEvYcFW4KTDYLzEYhPsPYE-qLKw@mail.gmail.com>
Subject: Re: [PATCH v3] rapidio: mport_cdev: fix use-after-free in dma_req_free()
To: akpm@linux-foundation.org
Cc: mporter@kernel.crashing.org, alex.bou9@gmail.com, error27@gmail.com, 
	gregkh@linuxfoundation.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thanks for picking up this patch.

I noticed that the version currently queued in mm-everything appears to
correspond to v2 (commit c044e529fa01).

The v3 update includes one additional change based on your review by
clearing req->map while holding md->buf_mutex:

        mutex_lock(&md->buf_mutex);
        req->map =3D NULL;
        kref_put(&map->ref, mport_release_mapping);
        mutex_unlock(&md->buf_mutex);

The v3 posting is available here:

https://lore.kernel.org/lkml/20260723235220.588424-1-james010kim@gmail.com/

If it's still convenient, could you please replace the queued version
with v3?

Thanks!

James

On Fri, Jul 24, 2026 at 8:53=E2=80=AFAM James Kim <james010kim@gmail.com> w=
rote:
>
> dma_req_free() acquires buf_mutex through req->map, drops the mapping
> reference with kref_put(), and then dereferences req->map again to
> unlock the mutex.
>
> If kref_put() drops the last reference, mport_release_mapping() frees
> the mapping, and the subsequent mutex_unlock() dereferences a freed
> object. This is a use-after-free.
>
> Fix this by caching map and md before kref_put(), clearing req->map
> while holding buf_mutex, and using the cached md for mutex unlocking.
>
> The bug is reachable from userspace via the RapidIO mport character
> device interface.
>
> Fixes: e8de370188d0 ("rapidio: add mport char device driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: James Kim <james010kim@gmail.com>
>
> ---
> Changes since v2:
> - Correct the Fixes tag.
> - Clear req->map while holding buf_mutex.
> - Clarify that the bug is reachable from userspace.
> - Update Dan Carpenter's email address and add his Reviewed-by tag.
>
> Changes since v1:
> - Rebase on v7.1.
> - Add Dan Carpenter to Cc for lifetime and use-after-free review.
> - No functional changes.
> ---
>  drivers/rapidio/devices/rio_mport_cdev.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/d=
evices/rio_mport_cdev.c
> index 009b3b595bbf..ad82c2108a56 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -564,9 +564,13 @@ static void dma_req_free(struct kref *ref)
>         }
>
>         if (req->map) {
> -               mutex_lock(&req->map->md->buf_mutex);
> -               kref_put(&req->map->ref, mport_release_mapping);
> -               mutex_unlock(&req->map->md->buf_mutex);
> +               struct rio_mport_mapping *map =3D req->map;
> +               struct mport_dev *md =3D map->md;
> +
> +               mutex_lock(&md->buf_mutex);
> +               req->map =3D NULL;
> +               kref_put(&map->ref, mport_release_mapping);
> +               mutex_unlock(&md->buf_mutex);
>         }
>
>         kref_put(&priv->dma_ref, mport_release_dma);
> --
> 2.25.1
>
