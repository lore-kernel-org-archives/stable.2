Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403BD36E46F
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277562; cv=pass; b=SLidYemLjngKpwTr1P3Gd5gL1+pYg9bIeHvfJ9b9cU1mc5ka9ZBbsPfTjVSZK0oMHK4Q5/r+omgqx/B6P5kg1uygCiPjKuRFk1uNXTfR+NYskuBYn5TGzBzXEn8Y1PB6osg4skHJU6gdI/gIw6SkcFrC1931DWQVBX5QCoczXyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277562; c=relaxed/simple;
	bh=eDOwdQXSRtgOf4mTyaflzKqNbnrUr4pbbePUikXSLlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UC7przJoo/U4V7+YbdpjQ+1O1fwU5H0ywrj46W87LKpevNAdeXirdI9aWhmbHSaqCkvO7USLDg3mSvMcTOCrI7nWX7HR7HQ7AZNmxM29Klt1pfnHGVsY3dZ7NGUkLhpWUA0u/4aEXBN0B0SLj4G6qwxkiVliuPSolOlUHYut9+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeLD69Jb; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeLD69Jb"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6b057877851so819699eaf.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 08:46:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788277560; cv=none;
        d=google.com; s=arc-20260327;
        b=VtDUlW2QuI6esfy8WUzB3RRuzBlWSDSejHWL3GmIASVIthaziPVd/VtLv/02vySsaT
         JPORie+MwGsWiCsNkdIfoDSvo12U+6q0L/SAJCy/TJYLNvRsSW0PPYaZCdyJpeIsBb7/
         /59l0lNFdLe9/tb4czqsq7tTsPv+QBCxBpPI5D62SnNqtBSq+X3oIb6vQZ7HRo0TTIlz
         BKUKkejj7NAbtUzo+XKrUyDVFX3JZITzHQnIcbrNTFDzbStrwPmMLu9swINm5xjHC4Dl
         Er6FaazG3F5wgSI+nOhJxRWlGFUxA1Vxuxnqi0Uq9gq65n7xiXL+mZJLaI2Nlu8cU0gk
         i0HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gsQFi1OZbsAa51qs2HRH0J2IDHT8L9xs8AMXHKs0Nzs=;
        fh=kDcNqQxVQh0CgTC0UwCdAqG8b98gR4ZjW0Mp1JNZom0=;
        b=nj+WgUU7EFOEZpyo6d9QcjJN05IoVWIIAHrdEr7tbe7RWyEj530sxdlV3L9Ozx2ybv
         YAtsMPKbDziOitia7tgizbwz/SqSKRh9mLEa2bl0Gf7WNlwiU8c4veStkns3YnYja7Gu
         kmvUrVYEXAJi0QaZK29QjFERt7TXoPMebzoQak8/8KnDJ//mUnWnPrJVZOdjZjpv3IS9
         akS+uQMQ3NxA4S0s6UP6B+i7eILw/ErxcUgJHnklpo+YTw9Z+s1wA/N2nxIBVfzUlu7T
         gjhsK6ZIXZZ2/+lbNEwaONBGrXwH3mQQdiH5F9mI2QaPSEyHDkso9H0uKcOfccmHG7Ub
         UQ/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788277560; x=1788882360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gsQFi1OZbsAa51qs2HRH0J2IDHT8L9xs8AMXHKs0Nzs=;
        b=FeLD69JbsHIAxDWi6r76ivUtRMUHszrYWwV3ny0LM95P5+sEsVjubd4zy6KvUOf+PZ
         utlWLWqBeg5aj+pXKGr4lcYqG4NH7lmulUwXt9MqdXa9YdvG7/CDadSGzytx6DvU7a+B
         2mRz9wJZUpIGLnRgxdmXGsUBYnQIxmrgd9ce9D+64RHKXB4G8Cmu1mvBZYgfXgXTjNax
         wVG8HCSM1ipYHazASi83xWTZranH8duNAlos/cggpwzPtexoVwSOgs+YY7CZscyMcrXN
         /6MVobTkVGnYVCxdPEZQzMUWZKfFbfAAHzXKnxQWUQGuCqwMhE0eLvJ+WMnUAolpVHYm
         hBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277560; x=1788882360;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gsQFi1OZbsAa51qs2HRH0J2IDHT8L9xs8AMXHKs0Nzs=;
        b=qAaTSO1u2CjwbvGGxMB6+6Lh4rQJudTW3BIIv8ig/xL9tvHR/tgL4d6BvWEFrrLUw8
         upC4zxediHN/AGvlrpf4U/o0MK4YjPaUlTMrq18huFr1ScQmXrsTeeH0LSWG5Z6eWr54
         U0byGSJ9ONnIwlHbTbsMhoe19tM1ErsBx0efyrSM5vC0Lj5haub7ORcuRBpKFFvNiWhS
         qDTehUmUaB8y0gt302vuiYpygXO8YQWais8RaR/wCfUyTy6lUbfYI1wzlcMf1IPfudBZ
         L9szrKFgbYGiYOCPkN4D3EkKq5rt++7g+hk3/tJ5FJINHpUe6JK79iEoLfLXh9PXxg4m
         DLlQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrmcod5TPW2AhgF/RS3j4A1779dJTelZRgL20zOWerOOKt9tBOPX6qfGXnK6gPLwR02DwTp0Ek=@vger.kernel.org
X-Gm-Message-State: AFuF++nlrHhhEgfzmZKUMjvIRfETec+ysbHXaD+DnVEZHMrbpoqNynfI
	9+lo/rs+kSpGjiQnsvc06TCRkvuk8nsX/5pW62+J6BeLo5gy9FUnyPiIlP99xbvGXeweZDxjFVr
	XPOkr5jykrXaHcbgUs6DtKIgHZHeH4Eaa8YPe
X-Gm-Gg: AR+sD10bKQGHHN2t5d7Q5/8yMvAP9On/bAfLkk0B7ff15jYXmWMB6bH0dJWSZvs9xbV
	L927ggxXv/Ga6E14gsi/Mdy/TYZ72YLwc5kxLI/p9FBkFW+/DHBA9pu9mOnaWB07P5jPS3E6Uq6
	ATJO2yqW5r3Lh6wQlrZ5AMdteW6YPLs/udpT2G0mNzGkh8CmluJSY6C2npTcxEg5OLGeMqbz5+M
	CBfJDQa5FeNGkvYGV/Li1qO0udXHlJQX+tDM9cwGdz0UzIc50nwJyh9O90U5mEc61gkKqaWyQa8
	EuLd5pD/X2cyHZkyUeWfG63PgEBdAV4zpHwk4XrG2omf7c1SN7ZxQQOy2klF6ZCxAEOFxWJ/jag
	J4IWxcY7clIUMFspKvTs9WKyadJ/ikqGXByShjIN/9dJ2
X-Received: by 2002:a05:6820:4dee:b0:6b1:d18b:4057 with SMTP id
 006d021491bc7-6b1d18b4cf3mr27183383eaf.14.1788277559579; Tue, 01 Sep 2026
 08:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901142438.237586-1-yi1tang.yang@gmail.com>
In-Reply-To: <20260901142438.237586-1-yi1tang.yang@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 1 Sep 2026 10:45:47 -0500
X-Gm-Features: AcwNN1WAKibAn_iMgh1g7gL5eDq1EGX5D1bvCdF1UgBxd1UvQDqs20gt_SkRPh8
Message-ID: <CACVXFVNs=yx1M5_S3QDawanrpjC1Kaiou++9BX-XcQVgAcFyrA@mail.gmail.com>
Subject: Re: [PATCH] ublk: add missing DEL_DEV_ASYNC to unprivileged
 permission check
To: Yitang Yang <yi1tang.yang@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 9:25=E2=80=AFAM Yitang Yang <yi1tang.yang@gmail.com>=
 wrote:
>
> ublk_ctrl_uring_cmd_permission() is missing the UBLK_CMD_DEL_DEV_ASYNC
> case, causing the command to always return -EINVAL for unprivileged
> ublk devices. Fix it by adding the missing case.
>
> Fixes: 13fe8e6825e4 ("ublk: add UBLK_CMD_DEL_DEV_ASYNC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yitang Yang <yi1tang.yang@gmail.com>
> ---
>  drivers/block/ublk_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 6c5bec7da97c..ade5d7fddd9d 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -5716,6 +5716,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ub=
lk_device *ub,
>         case UBLK_CMD_STOP_DEV:
>         case UBLK_CMD_ADD_DEV:
>         case UBLK_CMD_DEL_DEV:
> +       case UBLK_CMD_DEL_DEV_ASYNC:
>         case UBLK_CMD_SET_PARAMS:
>         case UBLK_CMD_START_USER_RECOVERY:
>         case UBLK_CMD_END_USER_RECOVERY:

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming Lei
