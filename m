Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E432C2363
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757235; cv=pass; b=kCrXhZ/Cw9M9ZffLWj/PCCnpZPxDZdmnMIFWOHf1W0tW4jrCCLwIhSKrEGGBYnRiOx4jNktekXcoaUEQfVJDjT/sHJL5LPbp92KrIZq1WKQEPHPnL4kV3l6BL+P14qoS5s3ERHeRu7q+8K0zZCqmMl+MPzjLDYLz4/uxGNILmog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757235; c=relaxed/simple;
	bh=qEjagWBTwfkSAxoL6vSmSzsmFrQjMPNq1akoI4Tt7+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGMhfMhjoC/o8IPajA62D+44oNDmJj2yN3UPJRZZfyVobT6FddVmcPMww7y4tkRypzDVgIpZCJfkpMwk4X5v2sUzh00W3JXha1rf88iCKSuI4nKhjXL//cxw0ncbQRtE8ICRAPsCwmEwdkiqzHhaXz+Vqexbo8VPEqkHTMGYaBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aoYwlF3s; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aoYwlF3s"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aeb688ae83so230e87.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 14:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784757231; cv=none;
        d=google.com; s=arc-20260327;
        b=Iqhu83ivey17tWszBZh6ls0uNXD8jOL6vFUMI7OsDHK4PalMUBJPji+m4th2MwL2xR
         IeMtM2SRWnnBi2Oh+ctR2gQ+bl2MRp1+DV071c+mwbhRUIe1UuEkeMOYr+DKQ3IdG3Ad
         oR5GJo79bBF+SQU+4ZRnxkYO0rqb/JbEpYQv3fLUqK00QjTKNpnf9szWdDhel/bArS5v
         TJklybxmcuoGh2vjgw22ukHxWECBC2BLJPakt/ULgm1tZ615Z3n17KqfC6aO89kZ++4X
         /NFYMYyfW7FeMk2S7gMJf6bQe59jY4M6tzdg1gLpHqW7WauKQXyx6QNkDZtqfTFIFQMN
         dL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3UirpLV1ZtIxhwqN9P10MkPtE1lhmhI/AHpOOHSx3qE=;
        fh=RWU5hydi/yeefSABX6Z/o8rCMsUdG6Rl7ar71MVaoOk=;
        b=U+DNWf/oNAOj35RQz65q6cvH4qdPxve/rk9zkz/kez/iVtDdD17FstRgLJXng/GBbW
         8us5dCXsTVQtjdR1bYSfhxMnJ7ESdMMBQgByQuTVnQg+JrgPX9af70xGpAH4toid7kF1
         5EFO/DpNsjrt63GHmpPUShTQQ3V88RZfh0QfNNYWW73EwXfUtcwl4IOsTGgdcz2PriOF
         MNpx8t8awK4SDb2tsLbOOf5+RK8SdfzJAjhwS2nyNO5v+wLK4aUfG7xVFND72zOjnU7r
         hlWxAQA4gqgLjAxMwx3q1oeLz3Q2dEFLTa3o0VCOp42XwlfLmL5HGcdhMEx6RXKDyVYc
         lSHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784757231; x=1785362031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3UirpLV1ZtIxhwqN9P10MkPtE1lhmhI/AHpOOHSx3qE=;
        b=aoYwlF3sdaQNJPjvwXYlEpbIy9Cd6d9hKJDlrZic69XsxKmb67rn5e2lhCOnPo2cUY
         o7mTp10nZF/NsHKMS1Wxrnh/iCB5gjwTnEEf1rgu1a4R9y3uLyBp6UTbtMbfv1fGkz4/
         B0yh5j6dJ7TwHA/oRJdPzM65gym3dTelZN73kUZjLHGLM7ht/v+w1IiT13XPLzNo5lrv
         mUSQWxrIXtbg1xgDCenlLRx4Efz9C2XFvJeFrpjViQyIznJVQU/6Jp4ntVzYEJaoKk1r
         l7e8ZytIDYD+6gMb+mqewgr5XRYMa3MwTLCvjaeeur0ZAZMeoKlzG6SiPVj8740wMuCv
         Fd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784757231; x=1785362031;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3UirpLV1ZtIxhwqN9P10MkPtE1lhmhI/AHpOOHSx3qE=;
        b=FiJAhT7D40OCN0OkTyWUjnRGblqLHYJ1f7cukw7kCneSbliqCNLYXvNW5o/E0oroQT
         xBxoTEItseS9DVbCCpJzgzZq82Mg1S+u9sJkMYoumj1yshg+2TZHHbJpCW4scoxhQimI
         Y4bFuUpILr5Hc7bHKm0I1VS0lWfQNofQyfedyArNBaVYi6JpjyhnqqQ7zAgEkuoir9UJ
         JVDps4WDFn6d8y6s4PRRHiiv7fJu62u0SnFo0N4243aryQp4pNjh5NyIiPbGJlbTl9R3
         Dh1Kv1IrbgBZrb/fA0/suzb7pCgNa/r4rVwyiesgaD1zjE3wS+Pvl2TnfD2YQdnIFtLY
         mAiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr6eimwx0w5/DIndf8xSW7VfZpUiHio6PP/YbzrhnH82hVR1niTAIlSCF/te0YegrfJRZdGuxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAX7nGv9HmYXBDDFE5WHL6mUs/6Df1oPmAFYuYAo2I86wxr1iL
	LuEW3T3i7zWFXEdumJ1pvbRnmFzHHeRJi7muODDA1SmYCrdMjKXayi8LT6GvDU1DQgJKKkhe1l2
	ejnD3EAzKLsX35HnoV7IcKzrLkx5RsatLu27xZ8Q=
X-Gm-Gg: AR+sD123AlUPlBHegEgfWUMwquRlzRQyDriAzYDSF8124b1mDnJ0QKd+REfkmZDtJzc
	zXaWWfw3PF4MYYQKJz26dQGXqdqlovJ8gsbqrnrbN8TfCmqJG1TKZ/GR/QK2GBWuOp4bZE0weYo
	BqlyohwioDH7w8wbzd2XcR7W7DEszjiCjBpUjUzd1hl0KZ28D8vrH0MViQVX0alcHR3ayI1+obW
	S3M1IE3GSKidSMd15ORbnHw+t1tUM/PLtxKeOZnVIyU2R0AJ2wFHdYIE0A=
X-Received: by 2002:a05:6512:3e07:b0:5ae:ae6f:8b09 with SMTP id
 2adb3069b0e04-5b2b0e25fcdmr55344e87.10.1784757230622; Wed, 22 Jul 2026
 14:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609164047.486227-1-xuehaohu@google.com>
In-Reply-To: <20260609164047.486227-1-xuehaohu@google.com>
From: David Hu <xuehaohu@google.com>
Date: Wed, 22 Jul 2026 17:53:37 -0400
X-Gm-Features: AUfX_mx6lXFHuf0Wgd2wPQM1BjAzgoxGSU-8B31GXW_8srvK8ZED4wSLL-WfrUA
Message-ID: <CAPd9Lg_30aqB6x342xLeFAc4exgXwWzwBc4KWh6+3p-N=yAwsw@mail.gmail.com>
Subject: Re: [PATCH v7] dma-buf: Fix silent overflow for phys vec to sgt
To: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
	praan@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 12:40=E2=80=AFPM David Hu <xuehaohu@google.com> wrot=
e:
>
> In case MMIO size is bigger than 4G and peer2peer DMA goes
> through host bridge, we trigger a code path that assigns the
> total linked IOVA (which is greater than 4G) to mapped_len.
>
> Previously, `mapped_len` was declared as 32-bit `unsigned int`.
> When accumulating `size_t` lengths, this leads to a silent wrap-around.
> This truncation causes truncated lengths to be passed to functions
> like `fill_sg_entry()`.
>
> Fix this by changing `mapped_len` to `size_t` (64-bit). While
> at it, fix similar potential overflow issues in `calc_sg_nents`
> by using `check_add_overflow()` for `nents` and using
> `unsigned int` for the loop iterator in `fill_sg_entry` to match.
>
> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping=
 routine")
> Cc: stable@vger.kernel.org
> Cc: iommu@lists.linux.dev
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: David Hu <xuehaohu@google.com>
> ---
> Changes in v7:
>  - Added a missing blank line after local variable declaration in
>    `calc_sg_nents()` (Leon).
>  - Collected Reviewed-by from Leon Romanovsky.
>
> Changes in v6:
>  - Used `check_add_overflow()` in `calc_sg_nents()` for safer
>    accumulation (Leon).
>  - Dropped explicit `!nents` check and added a comment noting that
>    `sg_alloc_table` handles `nents =3D=3D 0` (Leon).
>  - Collected Reviewed-by from Kevin Tian.
>
> Changes in v5:
>  - Removed WARN_ON_ONCE from calc_sg_nents() to avoid log noise (Jason).
>  - Added explicit check for `!nents` in dma_buf_phys_vec_to_sgt() to
>    cleanly return -EINVAL on overflow (Jason).
>
> Changes in v4:
>  - Added WARN_ON_ONCE() to the nents overflow check to prevent silent
>    failures (Claude Bot).
>
> Changes in v3:
>  - Removed leftover sentence fragment from the commit message.
>  - Kept `nents =3D 0` initialization (previously stated as removed in the
>    v2 changelog) as it is strictly required for the `+=3D` accumulation
>    loop in `calc_sg_nents()`.
>
> Changes in v2:
>  - Fixed 'IVOA' -> 'IOVA' typo and expanded commit message (Claude Bot).
>  - Added Reverse Xmas tree formatting (Pranjal).
>  - Folded in extra bounds checking for calc_sg_nents() (Pranjal).
>  - Folded in type consistency fix for fill_sg_entry() (Pranjal).
>  - Collected Reviewed-by from Pranjal Shrivastava.
>
>  drivers/dma-buf/dma-buf-mapping.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-=
mapping.c
> index 794acff2546a..80f6ab2f4809 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -5,12 +5,13 @@
>   */
>  #include <linux/dma-buf-mapping.h>
>  #include <linux/dma-resv.h>
> +#include <linux/overflow.h>
>
>  static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t=
 length,
>                                          dma_addr_t addr)
>  {
>         unsigned int len, nents;
> -       int i;
> +       unsigned int i;
>
>         nents =3D DIV_ROUND_UP(length, UINT_MAX);
>         for (i =3D 0; i < nents; i++) {
> @@ -40,8 +41,12 @@ static unsigned int calc_sg_nents(struct dma_iova_stat=
e *state,
>         size_t i;
>
>         if (!state || !dma_use_iova(state)) {
> -               for (i =3D 0; i < nr_ranges; i++)
> -                       nents +=3D DIV_ROUND_UP(phys_vec[i].len, UINT_MAX=
);
> +               for (i =3D 0; i < nr_ranges; i++) {
> +                       unsigned int added =3D DIV_ROUND_UP(phys_vec[i].l=
en, UINT_MAX);
> +
> +                       if (check_add_overflow(nents, added, &nents))
> +                               return 0;
> +               }
>         } else {
>                 /*
>                  * In IOVA case, there is only one SG entry which spans
> @@ -95,9 +100,10 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_b=
uf_attachment *attach,
>                                          size_t nr_ranges, size_t size,
>                                          enum dma_data_direction dir)
>  {
> -       unsigned int nents, mapped_len =3D 0;
>         struct dma_buf_dma *dma;
>         struct scatterlist *sgl;
> +       size_t mapped_len =3D 0;
> +       unsigned int nents;
>         dma_addr_t addr;
>         size_t i;
>         int ret;
> @@ -133,6 +139,8 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_b=
uf_attachment *attach,
>         }
>
>         nents =3D calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
> +
> +       /* sg_alloc_table will cleanly fail and return -EINVAL if nents =
=3D=3D 0 */
>         ret =3D sg_alloc_table(&dma->sgt, nents, GFP_KERNEL | __GFP_ZERO)=
;
>         if (ret)
>                 goto err_free_state;
> --
> 2.54.0.1064.gd145956f57-goog
>

Hi Christian et al,

Gentle nudge on this. LMK if there is anything else needed.

Regards,
David
