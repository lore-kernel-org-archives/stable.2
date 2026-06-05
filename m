Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2131388382
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690943; cv=pass; b=Xy+QXRFlfwT5/Gg9cBwHw7dXM+fF7IpbGXmxdAPTJbrijW3IEVwWGii1eKQk8PVHIf372Q4Cf3crJ+zAIn6Rzwy191pjZlptPXb089zTJx3HJVsHxXJSW0F7q65NsGYr/3uqb+HdNlB4bVj4xqtRsDwSkthHY9l5rl83MzZWR40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690943; c=relaxed/simple;
	bh=ntVHIrDqdpVdp00P0BNYVr6jVg4MJUDRyW7ggEFOpn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bo0jTK8IR/FbUXmTCRbR7s9nvWIeWTU35yY6btpGvVwGKHNZZrSna7wY/+FUPIaRCjzdRtkI09FM1RWC1OzVSg+P/DPkM3LANVEPTi/pQHZfguNnaryU7ANhuhdyAs6eKBQajf92To22Ra0nkYr6i+T5mwC8OkusnAk9t9m1Ilg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZXqFebk; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZXqFebk"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-137dd3bb44eso47492c88.0
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 13:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780690942; cv=none;
        d=google.com; s=arc-20240605;
        b=Y7zm+xSqJgzbo/wkSU0T47btvxm6zMPvmO1J/YEESUhOqa0GyVPnjHRdKvSGBdJHMm
         ExtulEVF0J8VVwGXkasLqYbgMhMd9jZJSfAplSNCPoF0p9VAebKqKC+RCO7cPDdHy83Z
         6EW1IMqzMKkChb52CXSwk4+8/O/0Z/NRVXlCfJhel+d+cimFCKeUCmzs27t/fkLMl48v
         DFqjy/cBsj3vLIaeQ5zcs4Zp6GwHAriz6R0kF0swRcKwYNsE1oev3d5Xnvqf87eQd9xc
         GJ0iNKWvEvmUAGd/gplQco0PLq2BF0pDljyCWgKSYAwvrNW7YL+Mw8zpAnO/b/J6V5yM
         dNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jd8zZoj15MB4D27exy0vziD0YMpZOpqLLJrmgLP/VUs=;
        fh=wdfYIt3HJwD5qWDIiSF37mWu1Q/xD+9oa/9sgS278cE=;
        b=A26aroK6VokTPAzhjAhcN2RfIv6B1sj5/+nqD9+6/0GYn/2ZbPTjXfgrCl/4mhkLoI
         VXUhJLp90aTCdwlrKtRNxdgLzbHX4UAoOdRQRLLTapWECJLGUCtgSdpY0MQ9p0R4hYSG
         GWFxj6wewgOnMO/k7XO5Lt/JfctU5vHDKEU9vJZwXqkUaIeJKKcQT8PgBVulF8z7hjoa
         Dv82v4SEOjl3y5t+vm8JoXNTroE6mNM11ysa9Cjsa3ELItSxHRrLKItG0J1SoODz3s3Y
         k9+faqUmMAssGuuCokITtGxuuZiiJ1vI3QmUi5znmkj126VsxlcO516KBkY2SaVQGd84
         PXIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780690942; x=1781295742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jd8zZoj15MB4D27exy0vziD0YMpZOpqLLJrmgLP/VUs=;
        b=HZXqFebkT65uBuy+8vdYxDHmgysVaZxYi0jxeJkNTHuodXXEHEl8APKxa9twe+NUe2
         iaAV9tCGWjUioNSlvMO6Ou2SHInT/C9kD88jTk4LflCzqXlFRwzD3+XgeOo3R20Ga0N0
         03mXKO1o8kxzb1NODTGkBF2rODasB9xVktDYOYVrnH8wRJfgrJE/828kLjG++iXvl5AM
         xD7g/860ku+C+G1qYKcM8zTA4RMSkxMP4p5829KHKc11Our7Jn5y+k5Jm9rTv6b7FvY4
         qzM+ty0jm1jvLfYqWBaeunc6CGUbiLJDpmOwKlv2ZQL22NPqEzn9L+6cJRXTXZb86IvC
         adLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780690942; x=1781295742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jd8zZoj15MB4D27exy0vziD0YMpZOpqLLJrmgLP/VUs=;
        b=eKvjn/WbqdkDI3a3sHbxeDI3ayC5mpl/RlGagi5OCag68bPjLUPkQN7afta/DJZg3o
         tXViJTMbJEUp8Ar//RemyuSAkBqLTkYTHNgP1qc9/Sp+Nwfz+71pxaiKFthKr1y0BuI/
         iH+ThYjh7ut+K8bXdVE8SCjRtBFtZbx3QxIHrSx0aKe7ffzVCiS+IbpgvaXtauCGopIb
         PRjQ0/u0mXZDFasyVnuNBJEO8j4Ok7hCseKOEtwi5D3ri6GjxG/EzsqC2cz31g2hO55d
         ywQ6kDyJe3OxUlHBM8h7pnrRSHdI+YyI4uG1l4YUyh52sed0YS4buUdNh9rX2xV9lQkB
         YVOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+xG+VcIyPf89KUN9KPoW/GStlyqItPRaNl32XLmfkDzdUApf26vITRe1/IGpz2rpRTppr3wKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNzwpNV5DCTBMRSfftA7vTs7k/lfY/KZsn7ECwRKu/M+EIEXWz
	LUY34tZValSr/AoojtPZIY29jtqiUHIQRbSMTFbLw5CO9RGgUev3j94jOeEmA7tFgPUk+wlp50C
	FpIDqJD6ZJPeaN2il0tL8r4oDvPhiz1w=
X-Gm-Gg: Acq92OHbFIcPYyZH6P5EJvoEllBJW5phH9J8EyK7AjEhaGe9rK3en5ECHrr486f6IXS
	FXGHaMhRM48ZwiH0ek1x5XG23QC+fRP86P5GqF0cI03cLvdLgTqDo/NK/+sh1av6vVvTLK91wqJ
	DEcWi7mDhVb/eDePc7p91ZSpaScOYQwMsAOK6ElRKKq8FvZ42/DLS6EoAIWvR9d52584DhW+Q8r
	FtKEYEE7iPWe7OdCfPQRZu8pQ9GivzpwopiK38/QsQ4UMZ6UJINQY7778Sdd5BbRVwii/s6aE20
	DY36A78TohLRwqbXKLqIBHuzoiQbLZjxr/hNKPNQy34E0nxfF3Xd3e+dK8zWzBMe34X0IV8ejcf
	AE3m8
X-Received: by 2002:a05:7022:423:b0:137:fdce:fec2 with SMTP id
 a92af1059eb24-138067f0b96mr1031445c88.4.1780690941599; Fri, 05 Jun 2026
 13:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605091803.6018-1-vulab@iscas.ac.cn>
In-Reply-To: <20260605091803.6018-1-vulab@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Jun 2026 16:22:09 -0400
X-Gm-Features: AVHnY4Itf_LGBLOFfworAGpTyhoHXZvSw8OTwPFhRJI4fD0sd3Y6MHVuNEzj0Ic
Message-ID: <CADnq5_PejRC_QGGYvph_0jAyGWX475LvxTVHZVo3qvH7ZVgv+A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix fence reference leak in amdgpu_gfx_run_cleaner_shader_job
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
	simona@ffwll.ch, lijo.lazar@amd.com, aurabindo.pillai@amd.com, 
	superm1@kernel.org, Hawking.Zhang@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 5:24=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wro=
te:
>
> In amdgpu_gfx_run_cleaner_shader_job(), amdgpu_job_submit() returns a
> dma_fence with an elevated reference count. The function correctly
> releases this reference on the success path after dma_fence_wait().
> However, if dma_fence_wait() fails (e.g., due to a signal interruption),
> the code jumps to the error label without calling dma_fence_put(),
> resulting in a reference leak.
>
> Fix the leak by adding dma_fence_put(f) before the goto err when
> dma_fence_wait() returns an error.
>
> Fixes: 559a285816af ("drm/amdgpu: Replace 'amdgpu_job_submit_direct' with=
 'drm_sched_entity' in cleaner shader")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index b8ca876694ff..88bec4e93712 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1686,8 +1686,10 @@ static int amdgpu_gfx_run_cleaner_shader_job(struc=
t amdgpu_ring *ring)
>         f =3D amdgpu_job_submit(job);
>
>         r =3D dma_fence_wait(f, false);
> -       if (r)
> +       if (r) {
> +               dma_fence_put(f);
>                 goto err;
> +       }

I think all of the clean up paths have issues.  How about something like th=
is:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 321d7aa52f042..848846ac9391e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1701,7 +1701,7 @@ static int
amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
                                  &sched, 1, NULL);
        if (r) {
                dev_err(adev->dev, "Failed setting up GFX kernel entity.\n"=
);
-               goto err;
+               return r;
        }

        /*
@@ -1729,16 +1729,12 @@ static int
amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
        f =3D amdgpu_job_submit(job);

        r =3D dma_fence_wait(f, false);
-       if (r)
-               goto err;

        dma_fence_put(f);

+err:
        /* Clean up the scheduler entity */
        drm_sched_entity_destroy(&entity);
-       return 0;
-
-err:
        return r;
 }



>
>         dma_fence_put(f);
>
> --
> 2.34.1
>
