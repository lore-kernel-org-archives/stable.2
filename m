Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C479F1C2324
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 04:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787632607; cv=pass; b=RX/NJsZiJ+8vT7azRd9+MOUYwLtLfph9mtUvrljjU7GOTD8jX2DoczbD8xNo6zzrC8Ay23AhxjLLWZxY6TP9dQK2ZmOjATtzsFr6YuV1oV19lCw/c2nDjgyc+OIzeAGov3oNWmIO4MYfKsz/Si/e5BgmtWSc08tomcNsMsY0xio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787632607; c=relaxed/simple;
	bh=8KXDg6v+jwLGL46qS1rvYXZT24b9H8EIN1Re7A2aD84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwSVD+GK++v1SMk2cnG6pFv0uXjnaz3YtiYlDxFpbWPKruZeOcnXp7UP/KamONDdf9HnMPjvcc1jlaTJ19A+hLgkQJwf1VINQssug7vuF2EetXVmYil82D0vfe/+q8xSvroY20voiVslFS2Suhf7NoEOA467VlEnWvRolqpunzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p17JMiCC; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p17JMiCC"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c8dbf4f38so41364921fa.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 21:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787632603; cv=none;
        d=google.com; s=arc-20260327;
        b=D4GIRRJnKVwljzJoc9BKKPGObNi7+IcOm225FgAgHkoLS5yHEB/r7kMQvmkw5iFfif
         j6tb82AL1IUvcoGj9vdxSx2AN1mL+AHF/iMawBfmh7oNsZc1d2H87ZktYFCIvVCHSofF
         7bZe7//4RelNvm3QG87bx95p0xzUcdZlJxPE4Zsrrn5b1EiPR5HMKo6Id8Ko0WNExshg
         yv3q8dvB6OhT3HnImZL7Q439Q0CRJxBp6Qsvg3VhwgsJx+k703OAJcCAbsZLHVOhEWKW
         ZnUw4j/LiStrWQ0r0mrnZDkeAkjcHvu0mV2hk+/5aZhMSdgeYYw1sV9TdMUXKTTjPt/n
         NTjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ig8RAVfekwF2wIGK7Q5QZITkYd9OOtlKfCSkZ8UG+zA=;
        fh=uW3Cgw+UFFug7GjXXjan6qOvqEQ0ighux6DNfpKvY4A=;
        b=l0oQ07JQe2hEvI/tqdAdq8/bMTV8As7Y3Or64N4KYL/gobNFPvbAwZHO4stpYKJXnW
         HMf9lUQqZ7De9xFwFKITm4x9XIp5Hy7ZqEiR7CArE1Rs4a09zxptbm+DrrSwJNEoeE3e
         2lrP54dSlZlLA3uy3/cZYgYtluQQsmHcDfFKV50coF7CXdPs3vCjawJXGEFGyvQ7EoGy
         3nlDlwlfsKiKyBWuUZPdjPS2pDkvl3StbjR6KJTZ7J0Odf0yQKpXrIIENqF3ndobUPiF
         X9Xe4jBvx47ZJH4+57nqFYcJNVIsGNBEffkYvSMVebBaLLuC2VwXea28clkiZkCUjn3l
         SsPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787632603; x=1788237403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ig8RAVfekwF2wIGK7Q5QZITkYd9OOtlKfCSkZ8UG+zA=;
        b=p17JMiCCLZ3pWI/UyRyuhhaTMKNL1ePy2mkuzgjEwGQo9jN5m2ENRbOFKM8EvtlvbN
         Jz7fwHu4IhtzeAlgwhCR2WoeFO4bLrQ29mRuUQGDYmwy5HBUF56pwGMQ1XBXRvv4z4N3
         tXAXW/C/GwZDRrCLUjUSvxT2CbH4ypLs0neB8+BSPA92gGFt22Wzgyqpgq5o5SiPbbhU
         +J3ZJBEwCkwf3rmnp1psSqYPUMlueRCd5SwSlg8Ojev+ytgGlN1uPDp6yEd0n51+03BP
         EBAAeTqRZ3LRbj4TRrLeTE2m7BNA6KIeKbWvALut7V4D7V7GVbgzFAXsN0HmXp6+EiGi
         dZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787632603; x=1788237403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ig8RAVfekwF2wIGK7Q5QZITkYd9OOtlKfCSkZ8UG+zA=;
        b=L7pcxnFhPpsjo/vAdpnm1AsFHhli83WmBNBRVmMQ4y13wpMHIdNjBqpVhNn7ecNB1u
         eCSVFwz8MCsykfsuIPdaK1cdW3B2mXY6YZ8INLa6NW34BiI2gVuRHHFv00jyNOEJdA7S
         PIYl+HZRIEbnvmzj0lBUpgMztOWeIk/Jx5xyOndl1iYjfIvy/YAHUjk+gqRTL9c4YNaV
         XNE3FAFY3wcz0AuiephiML6WFqpo97DXX39144i8UVFKikJHRgVsFTy8OCu/krT3Dw9a
         Et7adjxLrPcAzb+4rSI0sTYHEZqFwP5sWxWDKoBN5iBXViFAN2UB3wbAifjr6pHiGIwI
         lBwg==
X-Forwarded-Encrypted: i=1; AHgh+RrOwbx3vlwUZ4RSKCM8fEIbpurZu+yoHrZE3AsBezzPR/pOLFRBd3LLzGTkLAc6SxiEyOJtdCM=@vger.kernel.org
X-Gm-Message-State: AFuF++mDf+g4iHrCzZ1jWNYXRDZfK0e/ro5vBlmi3LmvKwSMvMxRB2vF
	cOXc6tl1prKKsbuEChTS9v8TGPE7QVK+9WcHdEaWgTMNUUgIb70fQZVR2ssUA3UUL3uvd1pv6rW
	HuLS58yiOTbdf6XKNrUKiQ0evYMjf2lY=
X-Gm-Gg: AR+sD13egCIhVF4J256wTdLZccDuhPIu1kcUzRnV4fHpptsCHkCbMtj9gG/kyOS/Qlk
	H8DyFbBTGBx/qw8PUf9sp2N060/QMwlY+BYFfTMyfEIXvs6ARGM0sjBvBQjqpxWzmWZCxFDl67z
	vPmGhpyTjz2Qv6dQyztSZQwl5z5ASiM+fC7eFXPKAZLCqGndDlmg7hGEkXJD2znQ/mqyQUjVSnd
	BznooLpFEV8kJIjP1EruAOkz6IJQLCK+DVETYDqL3RAjCLTLyTvA7PwpDxIFxzJRKDLYvjX+wNs
	j/aVBrJh/EQc+jxWNfLUQAoj0QYRQcr0G/9ED9EDSmrf
X-Received: by 2002:a05:651c:f16:b0:3a1:90f8:c14c with SMTP id
 38308e7fff4ca-3a1ef3ef2acmr6706201fa.11.1787632602487; Mon, 24 Aug 2026
 21:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824054115.114298-1-zenghongling@kylinos.cn>
In-Reply-To: <20260824054115.114298-1-zenghongling@kylinos.cn>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Tue, 25 Aug 2026 13:36:30 +0900
X-Gm-Features: AcwNN1W0Ie8ThfGLQSZuvnEXV8DGnfK_q6Z4Wo1bvi5W-Srfd1h8RCYobcvQFiw
Message-ID: <CANFS6bb9BPEuiv2NVG4dMJRRoQyiC6fE+UokPxpMMiReOseT-g@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix incorrect MFT record pointer passed to ntfs_attr_record_resize
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: linkinjeon@kernel.org, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 8=EC=9B=94 24=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 2:41, H=
ongling Zeng <zenghongling@kylinos.cn>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> ntfs_new_attr_flags() passes the wrong MFT record to ntfs_attr_record_res=
ize().
> When the attribute is in an extent record, ctx->mrec points to the extent
> but the function receives the base record pointer m, causing incorrect
> size calculations in memmove.
>
> Fix by passing ctx->mrec (the actual MFT record containing the attribute)
> instead of m (the base MFT record) to ntfs_attr_record_resize().
>
> Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/ea.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
> index 44252f2c2ca6..534f7efaf128 100644
> --- a/fs/ntfs/ea.c
> +++ b/fs/ntfs/ea.c
> @@ -740,7 +740,7 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni,=
 __le32 fattr)
>                         memmove((u8 *)a + mp_ofs, (u8 *)a + old_mp_ofs, m=
p_size);
>         }
>
> -       err =3D ntfs_attr_record_resize(m, a, arec_size);
> +       err =3D ntfs_attr_record_resize(ctx->mrec, a, arec_size);
>         if (unlikely(err))
>                 goto err_out;
>
> --
> 2.25.1
>


--=20
Thanks,
Hyunchul
