Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1A5187C0
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028107; cv=pass; b=gUq2UaFmdKzmmky3fqg1C8mxGZmt2/9+4yPiVqdnS5+3iKBXmCCHI08l2xLRTyZj87J1YtgNTNpJYab3xwp3kulSVm+Xd64Tfr+ZgjQrkDhNAatgvDELLN51UEEW3WUvOtCWcB7VHcGFSPu1w3opUGuhRNFhZktTqTkZvA4fvqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028107; c=relaxed/simple;
	bh=U/IwgPrpaHxi79QzKG2CWLERd7nUYg2eWaJtoYv4Wv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnMT50zoHNdfZ8svh9JKJ7wNMHA3GaEv4vya2wWlowq67XVgS0Fi5SDjmjXjNFBcKz6nPAHmfyOrvNj106o6r3WND4cz5a5PgnV9nmdWGrJvprAAA/omRHDYQDO9oTTXHn0eAStLPheQ4vKfj3DCy4vad/Iy85DPlnjn3uxUkA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c85lj3Lw; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c85lj3Lw"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39931869b4aso221129a91.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 15:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790028103; cv=none;
        d=google.com; s=arc-20260327;
        b=nDUfAOCDKtBX/iStgfknvPMnPaSOCwR5XM1tpBdB0EK6yF6o6j72ZSPvnRG5h0m+sL
         TZXcS9vBbKNqfV+/EPDOttY6uWBN59e25nOfAw/SoQwMyhTHzK0m8UBskW2Z+ZlVy1SG
         PwpgFzcqgG04EmS6SLF7SPz7hyiASfHvPBLQ+bRJUu0URkui/ZStOaCg/xHWTWGwq+u0
         0/PGM3qWlcmCpMvP8zLJfkRbwtxiGBfb+WO7CpOTnAvPvq3ybg86IFWwrDsfH8pGkLSJ
         om7Meu0ImSUGrpBG0I9Yb1ZzadDMGG7NjWcXo0ysN7l430cHCEMHlLd9EsKFLp3b8eD8
         nOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1J+saQss82xL8Ce5qI/Gv+3joKI+8Uu+v3gbZJZO9EQ=;
        fh=swPayT+Kw21+QWJwV/2zP6XLlMSByzys57qnvO0zkic=;
        b=O39899MvDM53bsspBnY7RzFqDkq/puxLm6RCDvvb4eaW1XQ/Qh6UmFBNSm+M3l2z0n
         Q5U3pTRWctHoaPOYgJ6MkVYI13Qi4q2BQ9oZy1pk3GyR1rqAeMXwVRE1gdYemzOQFAPA
         74pW3Kk53bP7wg7hocCjx7EsfBhG/BhVco3CsFOXH3Jwcu5x2/x///iKZ2oFpTl1HNee
         zGoFnTl+7w/p7rsGVU/TPpegkfr/AFTvPT/0ZcHS3TFQ6EUYKPh+ASWOYJO8jb8HyGwL
         GfGwQJ3e4HDPfd5XmlS7ax7+QVOlqzst/Yd3XeVsMF7Tbi27CpYGmg/J+ssZwLCLoylg
         hwEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790028103; x=1790632903; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1J+saQss82xL8Ce5qI/Gv+3joKI+8Uu+v3gbZJZO9EQ=;
        b=c85lj3Lwlpy6DWSDIg6jI2pKT4YFX/DyhNGDgwgfUCb+KE59K6olrjodsONX4Ocu0e
         EjUJUfP6Dg347oAeYCXmgPyx7eYzhjpik7cKSBNHEUfkfkaEJ7GiyqBslexWfbttaSnQ
         m54YW1q9ZqMwwGYc19VUXj1cEEmhfqc7vjqUVKgXoJaXjaZzA+4N01qcE0+hmLi5Msli
         YgU9atgqzIDpljF9xgg+4NhevIh93qyiTxdFTlQCKOWK7NuEEqUST0HgfczE+VTCuD1G
         JZy92xoOFgHprPjSSU+RBJZQcYGRRCynTBf84iA23pR7r2yhvTEn76VVWNOtlnG24SGQ
         OPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790028103; x=1790632903;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1J+saQss82xL8Ce5qI/Gv+3joKI+8Uu+v3gbZJZO9EQ=;
        b=ej1Lornqq+NaGblCaZz8sTN+WNoT+ci4zPoGWs5daIcJhRVs5X6jEcbBv7fI4rpxIz
         JIgrWGsT+a5Syfw6s5XltnqVGi4IpbXRuuZmDiQd9p/xHENUYs85eDneWc/ZpuopTQj3
         hSsM29y3y3Ph0twGSQBA5FS/yzZg57xDZzhlJEs2K+St7DVv24ao1Pu/o44c7bym6NBZ
         EDu0KfmCSRdb/Uaw0tx+mh0KCe478UUqLiWnnCJoP8RXO8102Mdg2c6eK9XayumWdpwN
         gfn/GwU4792ZsFDYhOAgt7RWxDwxVG4CNrMznDSMdlTBvjibYIUOLt73PEpyTxaYXdaD
         bM7Q==
X-Forwarded-Encrypted: i=1; AKwUvBz7IysIQIk8y5sgVVp/0ZRryf3fF8MagNEm9wV7e+2tbP+zZyf/120IayM1KWYKChVIK4VUZNQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mHKRfUVs9kD/MBRBpx4MOva+uUQyW5dzTzD+sEKMm6wBAnLH+F
	cahMwjcIgqmiUR1I6kGZCIEvTd3LbYaH36merTQj0Z6hPqKLx2SO2jOW30khHZ9plO2YkjQEs0X
	qZp26C4qulbnI/eD2KTbTUZywwJPCsS4=
X-Gm-Gg: AYBFou3nHRU/YLd/3duyQtOicz11m1Q/U9i/y4fBLX+ZoGyIlbILsYiosB98tmUhHTP
	OXQ4+pPKnFe2E6hzodedvmbDv6a8NsXqUT0JtPgBLfqVZS+IO8ZKGdUFoOH1Umms9NCk7w/BAlb
	YRwujmCvJ1t/bHyEGWM5aYz/S7B9DFwrZeoNQ4fgFHWp1EGm9GmPIJ6GzDSDwLrkazjXArNF/Ed
	3jZA4HTCGK5IZHqEEkfzFHfJ9NlqCe3qIT45GcJglJl5NF0ndsfOAidjqHdj7eSfH5/PbVnxSve
	ypWilF2T4f/u7yJ9haa4aZNaPQxS+mVHL3l7edJ8a5c1tuCn6pqa1nbk32HouS/9jRGjYa8qOMM
	UYSq8+P9GKuiRNYZV2hsIuuY41oM/qX9dZ7tb/Gcpug==
X-Received: by 2002:a17:90b:50cf:b0:39e:2f57:67c0 with SMTP id
 98e67ed59e1d1-39e591e3bd8mr22753640a91.0.1790028103022; Mon, 21 Sep 2026
 15:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921103318.353216-1-lgs201920130244@gmail.com>
In-Reply-To: <20260921103318.353216-1-lgs201920130244@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Sep 2026 18:01:31 -0400
X-Gm-Features: AcwNN1WqVwSStsMay_gri4_rw5IDdLWdJymJyP5EtqkVYtYOv-9on_0dL0POVzk
Message-ID: <CADnq5_M39zRZW57prCham1JSmUEo1dZOaaannkAsTA=LeLz8Rg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix ACP MFD device leak on init failure
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Ce Sun <cesun102@amd.com>, 
	Tao Zhou <tao.zhou1@amd.com>, Brady Norander <bradynorander@gmail.com>, Kees Cook <kees@kernel.org>, 
	Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Mon, Sep 21, 2026 at 6:51=E2=80=AFAM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> acp_hw_init() registers ACP child devices with mfd_add_devices() before
> attaching them to the ACP power domain and initializing the hardware.
>
> If attaching a child to the power domain fails, or if the ACP reset or
> clock enable operation times out, the failure path frees only the
> source cell, resource, and platform-data allocations. The child
> platform devices already registered by mfd_add_devices() remain
> registered and are never released.
>
> Remove the children from the power domain and unregister the MFD
> devices on failures that occur after mfd_add_devices() succeeds. Keep
> mfd_add_devices() failures on the existing cleanup path since the MFD
> core already rolls back partially registered children itself.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Fixes: 25030321ba28 ("drm/amd: add pm domain for ACP IP sub blocks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_acp.c
> index 9014678d75ab..be4d00ac96b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> @@ -318,7 +318,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_blo=
ck)
>                 r =3D device_for_each_child(adev->acp.parent, &adev->acp.=
acp_genpd->gpd,
>                                           acp_genpd_add_device);
>                 if (r)
> -                       goto failure;
> +                       goto failure_remove_mfd;
>                 break;
>         }
>         default:
> @@ -443,7 +443,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_blo=
ck)
>                 r =3D device_for_each_child(adev->acp.parent, &adev->acp.=
acp_genpd->gpd,
>                                           acp_genpd_add_device);
>                 if (r)
> -                       goto failure;
> +                       goto failure_remove_mfd;
>         }
>
>         /* Assert Soft reset of ACP */
> @@ -461,7 +461,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_blo=
ck)
>                 if (--count =3D=3D 0) {
>                         dev_err(&adev->pdev->dev, "Failed to reset ACP\n"=
);
>                         r =3D -ETIMEDOUT;
> -                       goto failure;
> +                       goto failure_remove_mfd;
>                 }
>                 udelay(100);
>         }
> @@ -479,7 +479,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_blo=
ck)
>                 if (--count =3D=3D 0) {
>                         dev_err(&adev->pdev->dev, "Failed to reset ACP\n"=
);
>                         r =3D -ETIMEDOUT;
> -                       goto failure;
> +                       goto failure_remove_mfd;
>                 }
>                 udelay(100);
>         }
> @@ -489,6 +489,11 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_bl=
ock)
>         cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
>         return 0;
>
> +failure_remove_mfd:
> +       device_for_each_child(adev->acp.parent, NULL,
> +                             acp_genpd_remove_device);
> +       mfd_remove_devices(adev->acp.parent);
> +
>  failure:
>         kfree(adev->acp.i2s_pdata);
>         kfree(adev->acp.acp_res);
> --
> 2.43.0
>
