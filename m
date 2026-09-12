Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA5727FB37
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789230294; cv=pass; b=p6Q+pvEx5aFpR7Y04h6VxSO9HrNso8flcGHrefXvRUL5oGS91g11rvoUWUZRvghatxVMt0Lly8SdWvaJ7nnT+LUwUAvP8gam1AJZVY2kufU1j5biCVvwyBRAiOaI+N1F8L1haPlUNxDk4inVGFKyP/s1YT7/f8mnrM4/W9ZsTlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789230294; c=relaxed/simple;
	bh=8iDBeNCiN0hHJUZMaq7UhQbMSbgVa6Ej4eiaggtYEBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhxWSe3uWKsSaUEsBBYos9en6914AqYG6CwKo8Pa+i7c9weHr0eXwcKVNZ3IcTzlnfHoinN4CszcIzv1Q3xGYGKcoIDPlYg4KoEsjAHFALmDtQ9u+3PFh6i1EifM79Q0ppzwheM/yRfembfqxghMiRkE8hzqlt5VE4BJ4GTGGOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c05ff+xw; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c05ff+xw"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff16dd47so4298771fa.3
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 09:24:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789230291; cv=none;
        d=google.com; s=arc-20260327;
        b=RSe+JBPOGbShJqF+suCMupgwwK54WYKyP4orqGE4c0TOvAtB9HOW0u37IzaOS2hKwx
         9klA1haO+ooE5Xi2egLWYwAIiKtWWQDQKZcFtl5FlaBpJkHcGfhgs/iCITDUei2DA2BN
         KVAJq9gos1s4JdiuBdiu/iEHJzJXk1Kdgc6nB0eooqAWoSAloJXG/czbUrJ8AVgyGwQU
         BAInQCa18UKv/33fQOA56xNrSlRPo8H6+oizT12JF1r/OJSc3SW+wa79zIj3a1GjoqOv
         3e+RvUiNNNwPD9+iUsPOmogFMUUQqnvuJhaf6f5nBbGNBtljsSYILIU7gonU4G8Jl2xf
         x6PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z9q+sCcYZMF4wQ4+sdiAoeIwVGno+N9kY6E86HHMjfQ=;
        fh=q8zlvLWwhT0G53+ko+Y6fUztWaUl3b18T7emS1snFrc=;
        b=dj0hWzWuSNHV0LML98Rp670LBPu4p8RapU6s8131qRTfckIVsZ01jVOj/GoRhYGcxZ
         jIahdEwImk72jvwDs9Mr5O8/Ru4fPJZlWDCAf+2+a6SF40ZQvRIaOqX7KyDehiGCaRSA
         d2g0tU11XXJO7u6lLsiD9tP1h8+JW1pgNDJDX9s6NZ4oeNGeFW2PlBvCuXxv8VVnVZis
         XjgxjmOaIOizGjmWyiA/GzexuRqJA3Zu7rTCXMQzaqhqiySAZWWha3eNsaxsFayxjcAQ
         MPL6xZVI2WEqNjC4+twD+DMZ18WFM1vPb5dZb9Ynvs/RFEdxgqwk1+OfACRsUZgnjGG7
         TNTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789230291; x=1789835091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z9q+sCcYZMF4wQ4+sdiAoeIwVGno+N9kY6E86HHMjfQ=;
        b=c05ff+xw3t1/PamLjrh79NSjrsIy+9mW1LgGg0f24Hc78w5gT1Ea9HNss/HPh2ca8a
         ttUjMS2NOH/qIuu7IeIzmUYjFWipgGfKFIJshyhlU1um3adZ6VB88rl/GIP70yNkaUEi
         J/OECcJCOyiPND6UAX4ljOrW9A3b+trr6rFsKaNuqllfVKE6h93I9tEAyZBaAEgnfEqQ
         zW/GHOFcSg9HYcIRQXp227xXkFy855/CIK31WvQpx3nWiZNDvbwjBCcU7dzB2vJxDiQd
         1Q5uwy1ZFIHQLH4v4bvrErrujGQko5SJQOThp1SdburxwdquI9MdolHQpi49ruD8OCpY
         +ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789230291; x=1789835091;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z9q+sCcYZMF4wQ4+sdiAoeIwVGno+N9kY6E86HHMjfQ=;
        b=dYGtAdTwfqBxWzIOoSuFzd/xlAcSn92oqC8Gk3WTUSDtRhqBs1Y2WluDKpOle/YwAU
         L4hONBUQjRn2bHOzkvAYbYL2SOdChsbo17KAtN2gse3lWeRlRAuRcU6nkPDuxqNzkGUW
         FHRWis28UPIdPEDnEn83w8iBOdh1PGyXJMXYjUxgeujSk6bXQeVrzwwkr70Ys9cExFat
         iWleOP83bpwGHNj3RS82yTZEZW41ELw2Q1k3GwaYZ0nVdHWuymEJVopoX/MtKj0VtBBq
         tUdVfvm2bG5OMJtsGodVQgdi89J2HFdjoL6iM8BuflGirwmrw9SdJQlPMtAIF4PBdUUZ
         tHfQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSJsr5o94+GgA6yeFqcWeLkpMFkOaUgqHjePHSIq8WNzV4aJ/bqE4N19K5wKAQmouLhbFw4zE=@vger.kernel.org
X-Gm-Message-State: AFuF++lVokCjmHOlERhzBUFG6Q2Ru0798hrC/DwPbsJhllgNo7NaR+pn
	nWHnG+Sf9KwcxCpcj5HDcLzJ94/tK6AsiXjhfRYbm+JrVL4QWIMeJYMhamrKSQqqyxSuzVYdw5p
	bmmEmIKy1Wby7JkwfmfUF0pCcQcLTD/s=
X-Gm-Gg: AYBFou17iou7rb2NV+EFGkbz+eexqTilgqBpJ0sL9LAgYaup49q3lhYAsTL5aRSrI1z
	dV/GO6NQp5yvWDHBi0N/iTSfhdYGpeVnN1eSG/VJYe+43GNrnR45MKBqvL7az6QOQMSfGZsQVMi
	cNPswGV08qYecqG+l58scWtP5gpSnCZ5uuXc/6aUoa2ZbzcZ2Fnh2CKzoRsa78SJnhzaSeA3dxS
	n0Ip+HjotAtL/B7B+paB7FQv63rdtlhxuY1X91DRiubnnRcOY7zwQ0CvUxaNEn5UBIES6pbhy9z
	v+NFbMDJIxgZdbqskBi4cXxAWiNQQUGAg40Xf+uS4Lp5xwOnPKa6mwWa
X-Received: by 2002:a05:6512:1313:b0:5b6:4ae:3ff3 with SMTP id
 2adb3069b0e04-5b8a8ed97e0mr693001e87.27.1789230290482; Sat, 12 Sep 2026
 09:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908094416.10534-1-linkinjeon@kernel.org> <20260908094416.10534-3-linkinjeon@kernel.org>
In-Reply-To: <20260908094416.10534-3-linkinjeon@kernel.org>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Sun, 13 Sep 2026 01:24:38 +0900
X-Gm-Features: AcwNN1XDLR-1H_F4yGUTT9D4WfusOmIw2y2Qd1zPkFSejgc6LpuAEUYxXKcLDqo
Message-ID: <CANFS6bbhcXLw9LSo+9EFEZ_t21R0ABezPG3iTXyQ75ehm+mEDg@mail.gmail.com>
Subject: Re: [PATCH] ntfs: account for MFT records added during allocation
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: ntfs@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 9=EC=9B=94 8=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 6:44, Na=
mjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> When no free MFT record is available in the initialized $MFT/$BITMAP,
> ntfs_mft_record_alloc() extends $MFT/$DATA and formats the requested reco=
rd
> together with a dynamically sized tail reserve. Those records become
> visible through the $MFT file size before charging the requested record t=
o
> the free-record counter.
>
> Account for all newly visible records before releasing the MFT allocation
> lock, then subtract the one record being allocated. Keep MFT counter
> updates independent of the asynchronous free-cluster scan and update the
> counter when a record is successfully cleared in the MFT bitmap.
>
> Store the clamped result of the MFT bitmap scan and keep statfs from
> exposing an invalid cached count if an accounting error occurs.
>
> Fixes: 115380f9a2f9 ("ntfs: update mft operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/mft.c    | 11 ++++++++---
>  fs/ntfs/super.c  | 12 +++++++++---
>  fs/ntfs/volume.h |  6 ------
>  3 files changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> index 61d4ee3a57fd..f0656d0bbeeb 100644
> --- a/fs/ntfs/mft.c
> +++ b/fs/ntfs/mft.c
> @@ -1539,7 +1539,6 @@ static int ntfs_mft_bitmap_extend_initialized_noloc=
k(struct ntfs_volume *vol)
>         ret =3D ntfs_attr_set(mftbmp_ni, old_initialized_size, 8, 0);
>         if (likely(!ret)) {
>                 ntfs_debug("Done.  (Wrote eight initialized bytes to mft =
bitmap.");
> -               ntfs_inc_free_mft_records(vol, 8 * 8);
>                 return 0;
>         }
>         ntfs_error(vol->sb, "Failed to write to mft bitmap.");
> @@ -2135,6 +2134,7 @@ int ntfs_mft_record_alloc(struct ntfs_volume *vol, =
const int mode,
>                           struct mft_record **ni_mrec, const s64 mft_data=
_vcn)
>  {
>         s64 ll, bit, old_data_initialized, old_data_size;
> +       s64 nr_new_mft_records =3D 0;
>         s64 max_mft_no =3D -1, reserve_start =3D -1, reserve_end =3D -1;
>         s64 candidate_reserve_end =3D -1;
>         s64 *reserve_endp;
> @@ -2501,8 +2501,13 @@ int ntfs_mft_record_alloc(struct ntfs_volume *vol,=
 const int mode,
>                         mft_ni->initialized_size);
>         WARN_ON(i_size_read(vol->mft_ino) > mft_ni->allocated_size);
>         WARN_ON(mft_ni->initialized_size > i_size_read(vol->mft_ino));
> +       nr_new_mft_records =3D (i_size_read(vol->mft_ino) - old_data_size=
) >>
> +                            vol->mft_record_size_bits;
>         read_unlock_irqrestore(&mft_ni->size_lock, flags);
>  mft_rec_already_initialized:
> +       /* Account for newly visible MFT records before dropping the lock=
. */
> +       if (nr_new_mft_records > 0)
> +               ntfs_inc_free_mft_records(vol, nr_new_mft_records);
>         /*
>          * We can finally drop the mft bitmap lock as the mft data attrib=
ute
>          * has been fully updated.  The only disparity left is that the
> @@ -2813,6 +2818,8 @@ int ntfs_mft_record_free(struct ntfs_volume *vol, s=
truct ntfs_inode *ni)
>         if (base_ni->mft_no !=3D FILE_MFT)
>                 down_write(&vol->mftbmp_lock);
>         err =3D ntfs_bitmap_clear_bit(vol->mftbmp_ino, mft_no);
> +       if (!err)
> +               ntfs_inc_free_mft_records(vol, 1);
>         if (!err && base_ni->mft_no =3D=3D FILE_MFT &&
>             mft_no + 1 =3D=3D vol->mft_record_reserve_pos &&
>             mft_no < vol->mft_record_reserve_end)
> @@ -2822,9 +2829,7 @@ int ntfs_mft_record_free(struct ntfs_volume *vol, s=
truct ntfs_inode *ni)
>         memalloc_nofs_restore(memalloc_flags);
>         if (err)
>                 goto bitmap_rollback;
> -
>         unmap_mft_record(ni);
> -       ntfs_inc_free_mft_records(vol, 1);
>         return 0;
>
>         /* Rollback what we did... */
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 60d43339c590..0867d6a82ebe 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -2064,8 +2064,7 @@ static unsigned long __get_nr_free_mft_records(stru=
ct ntfs_volume *vol,
>         /* If errors occurred we may well have gone below zero, fix this.=
 */
>         if (nr_free < 0)
>                 nr_free =3D 0;
> -       else
> -               atomic64_set(&vol->free_mft_records, nr_free);
> +       atomic64_set(&vol->free_mft_records, nr_free);
>
>         ntfs_debug("Exiting.");
>         return nr_free;
> @@ -2131,7 +2130,14 @@ static int ntfs_statfs(struct dentry *dentry, stru=
ct kstatfs *sfs)
>         read_unlock_irqrestore(&mft_ni->size_lock, flags);
>
>         /* Free inodes in fs (based on current total count). */
> -       sfs->f_ffree =3D atomic64_read(&vol->free_mft_records);
> +       size =3D atomic64_read(&vol->free_mft_records);
> +       if (unlikely(size < 0 || size > (s64)sfs->f_files))
> +               ntfs_warning(vol->sb, "Invalid free MFT record count %lld=
.", size);
> +       if (size < 0)
> +               size =3D 0;
> +       else if (size > (s64)sfs->f_files)
> +               size =3D sfs->f_files;
> +       sfs->f_ffree =3D size;
>
>         /*
>          * File system id. This is extremely *nix flavour dependent and e=
ven
> diff --git a/fs/ntfs/volume.h b/fs/ntfs/volume.h
> index 2b60d14fc7ef..bc85a9592245 100644
> --- a/fs/ntfs/volume.h
> +++ b/fs/ntfs/volume.h
> @@ -258,17 +258,11 @@ static inline void ntfs_dec_free_clusters(struct nt=
fs_volume *vol, s64 nr)
>
>  static inline void ntfs_inc_free_mft_records(struct ntfs_volume *vol, s6=
4 nr)
>  {
> -       if (!NVolFreeClusterKnown(vol))
> -               return;
> -
>         atomic64_add(nr, &vol->free_mft_records);
>  }
>
>  static inline void ntfs_dec_free_mft_records(struct ntfs_volume *vol, s6=
4 nr)
>  {
> -       if (!NVolFreeClusterKnown(vol))
> -               return;
> -
>         atomic64_sub(nr, &vol->free_mft_records);
>  }
>
> --
> 2.25.1
>


--=20
Thanks,
Hyunchul
