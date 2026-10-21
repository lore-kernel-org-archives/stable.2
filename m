Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792590954;
	b=UqGDCwqTOL3de2f/5rrqUfVDeZx3x+2K3eeoFf1tH/ClXiK71mj/3Yua5WffaTyNaLZS
	 AtEBulUrRq2KmcsbILMTegoPw9cZx/wlCY3rDDRT4OHM2fjdhRozQANyL0bQCCBBKgGKf
	 GaDccGywFKKl22Lt/DKktKcWbGTkSS1dZuhHMdiv3STU7LV9wA+S1YLSWand3XAeY95vf
	 05/6A9cExUo31KjaWhiI+wWJWZkv27EKxcWLXcuOaEQTaT7ehk5PFjzDkQPjo411O7/UV
	 OarDRSD9LP7LHCbjGjuUXilO1rh0UGEQkQuiyAUOr61Rf6MmxlTpltp9wSkJEAhyeUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5FnNm4UIzvKOc10FAL7wfxfBN4PLxD36wKJfb/jCtec=;
	b=PM6+7OacEd7R2r9JrGwdLNLfb7Eap2GsR9t2jk7R8JSp+Lk83CBMnEzz+TTACu7jP2Hf
	 acQQZCqblWuHvAycRIWJj5KBG4T/mXFv5v6CwNfX2P/8Ue3Q0NoxHs2YXEO861sbpqgh6
	 5u5wBqWmifAs4H2VZl4LYrx92pujfOaKpIg5CmmEG3E3hioZvCMtzSygEmWdhLt/Wml8T
	 ElJtB93jVYX/zCZCfWqMWtt57cE7bW6xmiKevEnnI9zxPeDCX6lSDBPwq2imMkcwWPptK
	 47P1L/Vm8LqAhQ9wQ6OPCIebGPB5ZyG1xBFJ3fcn/7feXiaAe5wctc3qJhfEd+XrWyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pQNyC44P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849E3606A31E
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 13:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 849E3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pQNyC44P
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-313bab9cfe7so111394eec.3
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 06:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792590953; cv=none;
        d=google.com; s=arc-20260327;
        b=S6t5RgJkKjAPm+lOcnP3p7rayw+rX9xyIgm0sVURt3nKgvREHaiyPKOZFUHKSiEiFP
         6dQXsrwD5x/yoR45OjyJaN8J43jrSN1hu6s+JjxE1PXhxwU9v6+wzr0Lu0zv7X6PMWVn
         E4mROC/WikdsVDQSO7F+lRpwTgGhbxGsx829Xc1itRTtm3IdbRRGk8WtKLHsScyTztkz
         1xlfH/j2zAPZ3F0aTetpwoniQJmvsnWA3etAvsZdbkRrJuT2Kel00TVJJ2GTc/00n6Jz
         fHnULOrYrS0gnJj+qoxwVGbu8NXxgVFpAiLr8vn/6solBC1cXQjT+AXSI2WZzfXr87cV
         j2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5FnNm4UIzvKOc10FAL7wfxfBN4PLxD36wKJfb/jCtec=;
        fh=dfc9B3ZEaXYF6InR0IIRXCJvOSXYB+nOqeXG80y0HW0=;
        b=HUgYdW0pl6osqnqmsPMABAw7l6jP5zJ2qKy02dkaE+9YF1W5ntGrsdh+t9KusW50KM
         uEx9v2tyHhi8QLIlariEfXJEF3scmGu5jq7biFpDfzQj9C05cv7McBsTdvgwj3jKRdIE
         VPOLxkQv5S5EA56arMprpCX+GW1Hi+Cr3mN5Li/L4auoYQHbhbXwDDxkAFRO4EOCkT42
         N+SZCCWi4B56g3+iMG/3wNnxz5LhXQhNchCUApwVEm0/qxHMZvqUwonzUhHVDR1yzWjK
         xeqUUyss6BNHLngyIkGpoY1Yim+N5MOPlARDfMs/gvANGn5WdByn1EJyP1ujJFWrnPS7
         /aMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792590953; x=1793195753; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5FnNm4UIzvKOc10FAL7wfxfBN4PLxD36wKJfb/jCtec=;
        b=pQNyC44PCZnVANfGOfMk5hGWRfiufkic0qpqMZixUndC0/8PFvuHJYQn7pMoaCyKhP
         FtVv+6luTKfLsGkZ/FyGOr4KW5qtz6Z4TyvonWRfggy/dh96hxs0xPYsm75m1KCbzRb1
         /SMSLyuR7WmY/BzVE9/vjsHdVJxAuzg0JcnljB83Upfzn54PvBIA6TFsHZ7/AdpHwCod
         4W9fu8Qo6mlxAbLiLSRweXCR2c3Lbzuwf8eg/lLbkAlsSNq2E1xBnGLQzc+XUrm2Bx5n
         yUrWftV+TY6y2Us68vl87tX0NhczA+ccHtEzJoIuYeeEp87D2trXU3yVcc96bHoFxQaJ
         a4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590953; x=1793195753;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5FnNm4UIzvKOc10FAL7wfxfBN4PLxD36wKJfb/jCtec=;
        b=BUar3349q59DC686+Azqdto8zjjaypT4r0izWzzs42G+DcDqJ6FCMhN25K1xFFN3xZ
         NCBbR2FjvwSIcF1eWPpcHDrpPTVttV0VEqCTXMWSYtF6JaA1f2AXaCNOhkiCT9kRGPgw
         C7L2dmeHbAKJAZ1OwttNyizO9hWh2PV+3Qlftd+/pwiDPgl1rg6s0P0z6YAJdIWgDurs
         tqCtPfWK71/4jtnT9Hfv7tdFpwBLhog+K9/w2CWUl6q2hJ2QZ4xuSVA9fy0VhbdVER6a
         n6NHRKlAaIdAHn8siiYFX0yykmq9qm+JQsdeRSLCgxaxFs1PC8j8uRETEhkzjYyJkrjf
         PiAA==
X-Forwarded-Encrypted: i=1; AKwUvBzUNppuqKAyOOX0qnbxI+OMBEJBzXrP3Q0K3PcrAbJUz3OLL92EmRsPTgGR4kJRxdhhVDOKhM8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLOCnrXggjtI84BJeOkRvUd1bInqf/00jGm3nvESGVg9ViAxYDn
	3AH/gV7BkKc0C/4LeikgbVaSiiHvikKdNC2lFypgYj6dlMO2NuRcQEGwc47lNbGngoYTVmBKm4p
	9Em33iNr7qaVvrvgaO2St3s336YYYYaQ=
X-Gm-Gg: AYBFou3Nj5+KGBVbJH44vcLxysCGpJ1iHs7uhCR3uO8bnnkF7OXmIwnD9SaROgQP+qm
	aUMTLSQrYT3hMdlHCw4rvnzK5AO17L/syIkQJWQ7FsLy4n3UqThkElfcF1dNYJN8WwIgxEVZhxd
	ieM78upjsQzZoNgYiCFX7jPHiIcV6a0P+MIBR3gQnZgLjqeubNS5tYdbXSDKjr8N+2C+ME5yfl0
	ZydhuLuB6xqXe31ag61aagkd9h0FQFbyOIx0YY2V/qJYrP6KvJCYEKT+ISJUbEvxDakKa6Quwff
	DrQGDiYQa3P3HRYIG4PN4vd5dpBUk+2E7xOYi9+CP6MuErfi1jqqVj/iEv1o+xOycWzIE++PEyS
	oLSzQku1rrExx4GEg4XMgxca7M8e34R4BAPg23qNJdvjr/UG4PzmEqY0IDUX0c2PuDiBb3pzs4d
	BU5h0ZV1VA+mZXfDGT8XibUeI=
X-Received: by 2002:a05:7023:a5c:10b0:183:d275:cf76 with SMTP id
 a92af1059eb24-190a370711dmr3874782c88.2.1792590952298; Wed, 21 Oct 2026
 06:55:52 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020193212.19760-1-leo.liu@amd.com> <20261021125444.27886-1-leo.liu@amd.com>
In-Reply-To: <20261021125444.27886-1-leo.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Oct 2026 09:55:40 -0400
X-Gm-Features: AclHuK_zA362IJvERjz0zM7z5G1b1Wc0keW-WIwDM1q8U4r3hHcL2Ls8dDka5w4
Message-ID: <CADnq5_PC_i7DcpZX_yJOY4SujRUz-f_BggvO83Su-CRL9RE+pQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: cancel idle work in hw_init failure paths
 for vcn/uvd/vce/jpeg
To: Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 9:31=E2=80=AFAM Leo Liu <leo.liu@amd.com> wrote:
>
> From: "Liu, Leo" <Leo.Liu@amd.com>
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

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
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 12 ++++++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 12 ++++++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 10 +++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 10 +++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 10 +++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 10 +++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  | 10 +++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  | 10 +++++++++-
>  29 files changed, 174 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v2_0.c
> index 72069b77f6f1..7ce3396b1431 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -159,11 +159,15 @@ static int jpeg_v2_0_hw_init(struct amdgpu_ip_block=
 *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         struct amdgpu_ring *ring =3D adev->jpeg.inst->ring_dec;
> +       int r;
>
>         adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>                 (adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>
> -       return amdgpu_ring_test_helper(ring);
> +       r =3D amdgpu_ring_test_helper(ring);
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
> index 564e40899df2..361d0f4b4bc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -174,11 +174,15 @@ static int jpeg_v3_0_hw_init(struct amdgpu_ip_block=
 *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         struct amdgpu_ring *ring =3D adev->jpeg.inst->ring_dec;
> +       int r;
>
>         adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>                 (adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>
> -       return amdgpu_ring_test_helper(ring);
> +       r =3D amdgpu_ring_test_helper(ring);
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
> index 10ef5616b2f5..2b2abe689508 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -481,18 +481,26 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block =
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
> +       for (i =3D 0; i <=3D j; i++) {
> +               if (adev->vcn.harvest_config & (1 << i))
> +                       continue;
> +               cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 0f4f4d66e2e4..6543f21daa1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -417,18 +417,26 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block =
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
> +       while (i >=3D 0) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +               i--;
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 4b7f7bbe18da..8b5646297c2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -349,11 +349,19 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block =
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
> +       while (i >=3D 0) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +               i--;
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 3f39aa83c319..0c58ca25d7b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -395,11 +395,19 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_bloc=
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
> +       while (i >=3D 0) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +               i--;
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index f30f80c1b07f..a6eaa57ec2ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -303,10 +303,18 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_bloc=
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
> +       while (i >=3D 0) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +               i--;
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 7b7c3bc9f046..055729a42094 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -267,10 +267,18 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_bloc=
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
> +       while (i >=3D 0) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +               i--;
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_1.c
> index c9e990ab297d..55a4b2f9463f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -342,11 +342,19 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_bloc=
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
> +       while (i >=3D 0) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +               i--;
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_2.c
> index ed47ddd5b08c..ea6cdbcb6352 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -257,11 +257,19 @@ static int vcn_v5_0_2_hw_init(struct amdgpu_ip_bloc=
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
> +       while (i >=3D 0) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +               i--;
> +       }
> +       return r;
>  }
>
>  /**
> --
> 2.43.0
>
