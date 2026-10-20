Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792513616;
	b=XwM0qLMb0P4xqKgJIu9uCSLsIXumTajjAmSlHcqRYvHv7Lh1D8imxmJwKzLPMsEV2SI6
	 ydSWG9BcmBawWLpt8aNLTD1x0WyYGT0O0G2vm3Ga3Rc6rzAGTxj4HD61PLQ0c+e6ZDhcU
	 65HTxjvjeonnHxrbI8u22fJtO2zyLjGwaLCsL1CWVWTa3kiTfBPKVILJfmBF2+Qr+zx15
	 hN5TLUXZYpw+1YTdJSKZ01BmiuqxwT9v8nZJujuPO47vsV5cCKm0v2ZfqfvmXcKsgv2Gw
	 Te7zY2HtvAtpYpchmzXriNscrOvGkPanm2UIyN+K9tbJV+jM1/R18V87JYxXBeW9vNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qOESWozW3cJc2E6iGkcUb3B9JJiCfcQEn0fPW36B1sc=;
	b=AyfJ5dfdIjDyxnISoNQn4pZLwP75aW4+QMRWRB/pxn0SS3yDhGffAIqsWxPFvx+UyArt
	 AxgaVRGzNO9KAX1zz+y3cgVwhS8BrMBhVbsxLbzPl/J3fYiiGbf8SQ8yS0v/vw/dEAkdJ
	 rFYpFfuNyDW07S97AaXsZlz2ksMc7OibyeqryBlxAkqO5bKi4cMTqL411mptUNZLdPzf4
	 CbsvjPAI/zjkgMhKguzP9Kj1fcFRk8elVYqu9gDIMqa6nyPHfVa3kx2D86iQKXlnwTXXj
	 TwdINQDijz0KdNospuoJILjVVU0VDsG00h1Q68znjqKIewdipn5RYg6EZG+iTwirMmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WE4lIXk+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7121606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 16:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7121606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WE4lIXk+
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-313bab9cfe7so480317eec.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 09:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792513615; cv=none;
        d=google.com; s=arc-20260327;
        b=I488xNFSOcG/EpsiiOYWok0nw1OrTQzlZGOYO+r9UuBQsoFHNKHPiCtz1EMl6ZB2zs
         we5uLHs8Ce//dvBVTt8BC/X2+IBtmvFYskZMI/ddy/aTm7P8rMUcQJ72JpK+9wnG0FCK
         4QPBCxj7poNA+iM92fQ5lsAs9dZ4+Rza+bF/K8t12U50cGktckqr1cKvq6fFKKiTCp8v
         I6C8BEOX84AlT4uMdGUGSKbnswuPB3JdO71sCQvHi+qh9Q3wwU0t80KFOQG3iAzuOUNo
         5FXyLGbaZJAlz4r/RgA8JheBWpM01m2Uf9iQJFBPFsndYcvwadZ6UYk9D0KfkGIa48eq
         3ZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qOESWozW3cJc2E6iGkcUb3B9JJiCfcQEn0fPW36B1sc=;
        fh=VVsbAsrLflDcbROXb5wh2nzsojWmNDvgL2JEMNUEYeo=;
        b=acWkoOgDZoTyOo9mqsAWAdsw78RwO0CTtvL5Ly9+eNNlKyWxbAdBXEPuiR2JgElTc8
         tYnh7vyw40/JGaXTqCvqx5HxIVqPtBAYQYtXWCvzRxpw7jDvbup/8sQIr8lQi7TNJX/M
         0SL/Toh3QooMkCnAVNtVVybxFzyaS3w4T4pmYVBPduOigc0X/FeXJdHEogFN3KSXU5tb
         xvMS+mgl0r1eGjq0LKcQeOiS/jZjljsxkqo21PnzWz8QWl8BTj6F0zsuYToY+b0b0d61
         W3/2bXDBJLDaK1fBdodb9aMKvJDzQL/LqkkP5KcIMwWZ7QgXVCBOD48ger/WxFleG/bF
         1vKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792513615; x=1793118415; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qOESWozW3cJc2E6iGkcUb3B9JJiCfcQEn0fPW36B1sc=;
        b=WE4lIXk+BHOeAzDtb8uZnAtJY7MnXkL5iHBk1cO17ifVS7WecT24hdyHPIcyPmnY3Y
         6bfwRzM6ryGUMQPE2xRpWjQSP2b4Anh3i1/oHkXE7VLT9qOxFtwP+pCEcYD743lxqgbn
         kP7sb+73hBE8yczxJHrRI7pFL7gtjnI168sd4uepSZD25WhXCy0Fi3dc3HBnVixm9oZi
         0N70QvsrFVawppJBGfahkjjEiXCbmfa7DDvdEm8VR7AvW0QzP+pUIFhoOxAeLpVxTvFC
         gRXHHm416qPIfoErI3plIUuDbqEz/dbSlwucAdnwfjs0vOj/bg2P04bWzR29ckaKS0iC
         yk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792513615; x=1793118415;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qOESWozW3cJc2E6iGkcUb3B9JJiCfcQEn0fPW36B1sc=;
        b=Usp4fS6lcxeXQTvgZOBL/vx12qJpsKbkcYZJk5gWvKUDpTu3RQXHP2iDm4RXXrRYqq
         09/IUhEjsD2I9EXX6hcnOpXI2TcFZ1UbWBsT9blWE9LD2hUOX1184YxmWZPbbkF0MB9C
         cU0m4sDZBOWX9jrJC0duOBu7KwAaULv8pEOBT3O9OqJf2acMTitR7ps8eD1ca/jWNH7l
         mLLYRrwRyE6qxrmvv79b/G/sOmwxBoRse75VSSWLwsKDk53J41BX8EZ9I1qW/JOr2jm1
         G+sSr6N8MTb8FCpJfZSwe908CF5A6q/X35cSCn3aVoRHZQb9U/SLqEH3we9lYVd+IUzJ
         kMtA==
X-Forwarded-Encrypted: i=1; AKwUvByoplcEIWxggXeC1PkVS/lXI2ILRj3kf6Irn90evGVg5HxOra0dwYif0SiGxvbGSPKX/Xe6Ui8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWzVpTvNrug2DhlPeFzWTMGUE/UkHWA/noOrQ63+qUkjMvJFdT
	GxX3pn2dcnew9e5R+cKNdidrjYBrHjkJRgR5iCY/w4Lv0zKpahyVQT8orjLELOrvkqD1qA07Bhz
	9tp1il7Se+FgAQvtl7eV8B0pMotoGNFc=
X-Gm-Gg: AYBFou3yvdlWcVAyTNwFigyWrPxj34LNjArV1o1/xH6RCp9X0v60l8E7iCn/pLd4B4A
	0GWqL75pM9p8RJNOdZeQGZQ0Ll1VouCGK4IsWv5E3sg6D9BqWCkoLaBgUTHC80W44qA4pPTBXm2
	JhmNXHpc6+njsj7UK8zNfbrryHims+jnJvm9L+zZx8WkniBhQnDPI7J3DswXP+7HDoxD4Op+v2D
	aAkygnd703Ityn+RPG55OdzlZQIfmIbyb77dQT+5frLxBPF62JKZjoNO0FJXPlNGHIR2PdZsCU0
	Zd65u250WTvCDDbbH7oDphmGy47nHbHPA9qRoxvCR5fSU7BaqUj++ZXnC2Kl0NBS9dD41OoWu8E
	eB0qAuKGo3WhuLCJfPoGgUq1x3O27X6klKhTfck/O1AEmpEA9DTor
X-Received: by 2002:a05:701b:4510:20b0:16b:4f52:a08 with SMTP id
 a92af1059eb24-18507ce1c04mr24731580c88.0.1792513614444; Tue, 20 Oct 2026
 09:26:54 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019153942.4067-1-leo.liu@amd.com> <20261020152701.18355-1-leo.liu@amd.com>
In-Reply-To: <20261020152701.18355-1-leo.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Oct 2026 12:26:42 -0400
X-Gm-Features: AclHuK8Cp_D7QapbPE0L8K1pGGV7MXeckR-FGl5_FE_xGeWy-d5hcCGBTW_amtI
Message-ID: <CADnq5_O3Bst-E_BUH_JYiQH4m-G8HzNxK8zd=sUdnhywROv7ug@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: cancel idle work in hw_init failure paths for vcn/uvd/vce/jpeg
To: Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, "Liu, Leo" <Leo.Liu+amdeng@amd.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 12:06=E2=80=AFPM Leo Liu <leo.liu@amd.com> wrote:
>
> From: "Liu, Leo" <Leo.Liu+amdeng@amd.com>
>
> When hw_init() fails, amdgpu_device_ip_fini_early() skips hw_fini()
> because status.hw was never set.  For VCN, UVD (including UVD ENC), VCE,
> and JPEG, hw_fini() is where cancel_delayed_work_sync() is called.  Any
> idle work queued during the partial hw_init() is therefore left pending
> after sw_fini() frees the adev state the handler touches.
>
> Cancel the idle work in each hw_init() error path, immediately before
> returning the error, so that hw_fini() remains the sole cancel site on
> the normal teardown path with no duplication.
>
> Link: https://github.com/ROCm/amdgpu/issues/234
> Fixes: 416e1fab4752 ("drm/amdgpu: drop redundant cancel_delayed_work_sync=
 call")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:Claude-Sonnet-4.6
> Signed-off-by: Leo Liu <leo.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 11 +++++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 11 +++++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 11 +++++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  9 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  9 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  9 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  9 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  9 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  9 ++++++++-
>  29 files changed, 166 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v2_0.c
> index 72069b77f6f1..c88cedfd4aa3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -163,7 +163,11 @@ static int jpeg_v2_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>         adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>                 (adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>
> -       return amdgpu_ring_test_helper(ring);
> +       int r =3D amdgpu_ring_test_helper(ring);

Don't mix declarations and code.  Some compilers will complain.

> +
> +       if (r)
> +               cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v2_5.c
> index 2968256d4cd7..46293664fd28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -221,10 +221,14 @@ static int jpeg_v2_5_hw_init(struct amdgpu_ip_block=
 *ip_block)
>
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v3_0.c
> index 564e40899df2..0e4dee12db11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -178,7 +178,11 @@ static int jpeg_v3_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>         adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>                 (adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>
> -       return amdgpu_ring_test_helper(ring);
> +       int r =3D amdgpu_ring_test_helper(ring);
> +
> +       if (r)
> +               cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0.c
> index b29ca3a49939..4e8eed2b62db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -204,10 +204,14 @@ static int jpeg_v4_0_hw_init(struct amdgpu_ip_block=
 *ip_block)
>
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v4_0_3.c
> index 0343a64595f2..1925d3092d02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -435,12 +435,16 @@ static int jpeg_v4_0_3_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                                                         VCN_JPEG_DB_CTRL_=
_EN_MASK);
>                                 r =3D amdgpu_ring_test_helper(ring);
>                                 if (r)
> -                                       return r;
> +                                       goto error;
>                         }
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v4_0_5.c
> index 4da3f9c995c1..a1496412810c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -232,10 +232,14 @@ static int jpeg_v4_0_5_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                 ring =3D adev->jpeg.inst[i].ring_dec;
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_0.c
> index dcdb089b4308..1a4594d5d952 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -173,9 +173,13 @@ static int jpeg_v5_0_0_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>         r =3D amdgpu_ring_test_helper(ring);
>         if (r)
> -               return r;
> +               goto error;
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_1.c
> index f2debf6b6bd0..efdc537ec81e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -307,11 +307,15 @@ static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                                                     VCN_JPEG_DB_CTRL__EN_=
MASK);
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_2.c
> index dd0abce73687..eb3dc9558e0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -280,11 +280,15 @@ static int jpeg_v5_0_2_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                                                     VCN_JPEG_DB_CTRL__EN_=
MASK);
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_3_0.c
> index 8ddd12740a04..0cbb2b8a7e78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> @@ -156,9 +156,13 @@ static int jpeg_v5_3_0_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>         r =3D amdgpu_ring_test_helper(ring);
>         if (r)
> -               return r;
> +               goto error;
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v3_1.c
> index ff7128a11cad..97c265daa2bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -710,7 +710,9 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *i=
p_block)
>         amdgpu_ring_commit(ring);
>
>  done:
> -       if (!r)
> +       if (r)
> +               cancel_delayed_work_sync(&adev->uvd.idle_work);
> +       else
>                 drm_info(adev_to_drm(adev), "UVD initialized successfully=
.\n");
>
>         return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v4_2.c
> index cf304b489d87..90b57a08d6dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -198,7 +198,9 @@ static int uvd_v4_2_hw_init(struct amdgpu_ip_block *i=
p_block)
>         amdgpu_ring_commit(ring);
>
>  done:
> -       if (!r)
> +       if (r)
> +               cancel_delayed_work_sync(&adev->uvd.idle_work);
> +       else
>                 drm_info(adev_to_drm(adev), "UVD initialized successfully=
.\n");
>
>         return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v5_0.c
> index 564d8fb58905..aa75b2691d57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -190,7 +190,9 @@ static int uvd_v5_0_hw_init(struct amdgpu_ip_block *i=
p_block)
>         amdgpu_ring_commit(ring);
>
>  done:
> -       if (!r)
> +       if (r)
> +               cancel_delayed_work_sync(&adev->uvd.idle_work);
> +       else
>                 drm_info(adev_to_drm(adev), "UVD initialized successfully=
.\n");
>
>         return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v6_0.c
> index dcb8487e22b1..3016227cf0ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -515,7 +515,9 @@ static int uvd_v6_0_hw_init(struct amdgpu_ip_block *i=
p_block)
>         }
>
>  done:
> -       if (!r) {
> +       if (r) {
> +               cancel_delayed_work_sync(&adev->uvd.idle_work);
> +       } else {
>                 if (uvd_v6_0_enc_support(adev))
>                         drm_info(adev_to_drm(adev), "UVD and UVD ENC init=
ialized successfully.\n");
>                 else
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v7_0.c
> index 46222fc30be6..48eac56f758e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -583,7 +583,9 @@ static int uvd_v7_0_hw_init(struct amdgpu_ip_block *i=
p_block)
>                 }
>         }
>  done:
> -       if (!r)
> +       if (r)
> +               cancel_delayed_work_sync(&adev->uvd.idle_work);
> +       else
>                 drm_info(adev_to_drm(adev), "UVD and UVD ENC initialized =
successfully.\n");
>
>         return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v1_0.c
> index b1428f5bbc81..0ba9bab7c921 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -651,12 +651,16 @@ static int vce_v1_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>         for (i =3D 0; i < adev->vce.num_rings; i++) {
>                 r =3D amdgpu_ring_test_helper(&adev->vce.ring[i]);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         dev_info(adev->dev, "VCE initialized successfully.\n");
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->vce.idle_work);
> +       return r;
>  }
>
>  static int vce_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v2_0.c
> index dd870ecac2a4..20a4cb6d17fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -483,12 +483,16 @@ static int vce_v2_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>         for (i =3D 0; i < adev->vce.num_rings; i++) {
>                 r =3D amdgpu_ring_test_helper(&adev->vce.ring[i]);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->vce.idle_work);
> +       return r;
>  }
>
>  static int vce_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v3_0.c
> index d5adccd3e689..7637305df7e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -482,12 +482,16 @@ static int vce_v3_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>         for (i =3D 0; i < adev->vce.num_rings; i++) {
>                 r =3D amdgpu_ring_test_helper(&adev->vce.ring[i]);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->vce.idle_work);
> +       return r;
>  }
>
>  static int vce_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v4_0.c
> index ee445d8abe47..4e1fbc7b50f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -533,12 +533,16 @@ static int vce_v4_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>         for (i =3D 0; i < adev->vce.num_rings; i++) {
>                 r =3D amdgpu_ring_test_helper(&adev->vce.ring[i]);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->vce.idle_work);
> +       return r;
>  }
>
>  static int vce_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index 76793a5caa70..b3e63d6e79a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -252,18 +252,25 @@ static int vcn_v1_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>
>         r =3D amdgpu_ring_test_helper(ring);
>         if (r)
> -               return r;
> +               goto error_vcn;
>
>         for (i =3D 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
>                 ring =3D &adev->vcn.inst->ring_enc[i];
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error_vcn;
>         }
>
>         ring =3D adev->jpeg.inst->ring_dec;
>         r =3D amdgpu_ring_test_helper(ring);
> +       if (r)
> +               goto error_both;
> +       return 0;
>
> +error_both:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +error_vcn:
> +       cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>         return r;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_0.c
> index 7d2b9e4b913a..12ac20484396 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -294,7 +294,7 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block *i=
p_block)
>
>         r =3D amdgpu_ring_test_helper(ring);
>         if (r)
> -               return r;
> +               goto error;
>
>         //Disable vcn decode for sriov
>         if (amdgpu_sriov_vf(adev))
> @@ -304,10 +304,14 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>                 ring =3D &adev->vcn.inst->ring_enc[i];
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index 10ef5616b2f5..be198680334b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -481,18 +481,25 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block =
*ip_block)
>
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>
>                         for (i =3D 0; i < adev->vcn.inst[j].num_enc_rings=
; ++i) {
>                                 ring =3D &adev->vcn.inst[j].ring_enc[i];
>                                 r =3D amdgpu_ring_test_helper(ring);
>                                 if (r)
> -                                       return r;
> +                                       goto error;
>                         }
>                 }
>         }
>
>         return r;
> +
> +error:
> +       for (j =3D 0; j < adev->vcn.num_vcn_inst; j++) {
> +               if (!(adev->vcn.harvest_config & (1 << j)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[j].idle_=
work);

Do you need to remember how far you got when you do the unwinding?  If
the ring test failed on the first instance, will cancelling the work
on any of the other instances cause a problem?

Alex

> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 0f4f4d66e2e4..a532fe72ed75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -417,18 +417,25 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>
>                         for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings=
; ++j) {
>                                 ring =3D &adev->vcn.inst[i].ring_enc[j];
>                                 r =3D amdgpu_ring_test_helper(ring);
>                                 if (r)
> -                                       return r;
> +                                       goto error;
>                         }
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 4b7f7bbe18da..8345c45ec5df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -349,11 +349,18 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 3f39aa83c319..a2d5b9901fef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -395,11 +395,18 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>                 }
>         }
>
>         return r;
> +
> +error:
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index f30f80c1b07f..86d766f0c61e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -303,10 +303,17 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         return 0;
> +
> +error:
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 7b7c3bc9f046..a4d0de29fd26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -267,10 +267,17 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         return 0;
> +
> +error:
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_1.c
> index c9e990ab297d..e64ca2bb05e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -342,11 +342,18 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_2.c
> index ed47ddd5b08c..ebf98878c2b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -257,11 +257,18 @@ static int vcn_v5_0_2_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +       }
> +       return r;
>  }
>
>  /**
> --
> 2.43.0
>
