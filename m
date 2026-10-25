Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792948483;
	b=EYg22iCNmQTmzxUlmdgN2K7q+9TlkxbAOrkd1a6vzCiqqLznuDrQybhItWLpgTFhueFC
	 kX3RhX5sJ5uK3peYQ4TFzWM/VJOri8evJJ401i5In3LuwF8UILCuHMZBp/vy5Mo3PurHV
	 t87H0g9CsTsG3PWkvGZQ8X2zszLXtQk/Tuh2cSlV8y/5elVnKxsQ9mQazPC43/+nR5qbG
	 QyfRu2fg1NFcX23UgYOSi46pZ+sAW5PiWBDZLlJXpOKJIV3kGveGpRvOEaW66qtmGSoGI
	 k9hHYfNDJQVVjNdqztKmVeTYcZeZ21rvI7hV32wjeegwgBcdosWMU4SjzP+FD8k97Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792948483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=7JrC81/JDOyBUDBe9YoZXJ79Yq7IMjS+qhUOLmCOSZE=;
	b=Q4oY8dNyNk+58G2p8av47CjI+Rx/nWY50P0AcF5jTxRzRthWbRs5bForbTmSFE/VT/cV
	 0h3N96gXfkGbCz6qsoP+U+Ezq9c9UdSL0UspUrpXvqdrFSt85IQibRiOZYQBiqFQrWpR8
	 0giYeDqbYPg7J/IIWmUMG9t3TvT7u4kEQlCPIBM+jdwsja953rpnwSUcn/TMELOyvKFxl
	 gDJ6Xcv/SHqlHM2Buk7LGMdu27WsZX1dqaDB8pV0/Y+LqW+CqqMyzIumHuilmYckNRdWO
	 btp35EKrHYsGl8NikikWL87iw+xA6S4EQvDK+00PPAWPSM4C7cOQY/C6uSJyTjOVUmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KvMwArvH;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CCB606A325
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 17:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62CCB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KvMwArvH
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so18338455e9.3
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 10:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792948482; x=1793553282; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7JrC81/JDOyBUDBe9YoZXJ79Yq7IMjS+qhUOLmCOSZE=;
        b=KvMwArvH9k6JfX9liMWu0e74r6uqHxpvhjNcomAXo+O5kCyyI7tLepo5vX2Gpl2mvq
         1jOYZ6kTYyqnxX6ThdO34AqE+zBRFK65Z6+nCzOUKuP+ObuUarYZJj0eUHPvCeu5lDh0
         JqGzI8ONUstfBPfOirZRrE3U/xfOpXdLgD+CNNihnve7BzkWDzGVsOnuVzYfzM3xaall
         iGe9kASdW3TP7Zc+X4BJ3asw9qiHjX7uuQrIkNM8kOLM46hJoMB8rWCxig5csoCVLBxw
         eXpdolCANhmXtjCGHehzkqHUkyNg1K3ld5fxrJRX+SH6D5Gw8qiq+w2CdcYQvl3AKwhn
         bmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792948482; x=1793553282;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7JrC81/JDOyBUDBe9YoZXJ79Yq7IMjS+qhUOLmCOSZE=;
        b=zlSSa4g7N3prohdRYoXUJ7BZiLRe5BD+sLtibUpVYHLyaVEcUaPTmgGqBQ7l8jkjoO
         Fv03psN/A3pwInP+WULV+6TFGh9e2cN2BkmIiCYR1e4OGl0nuNj+ZwELtrTS2x9QaiS+
         /ZYaIFjlYK3BNENV9e4WXSnrrTBIsOty7+sUqatR9tS2yhVLAVWuVIrhp3ZH++5vtmwd
         K70/zzqYfmkPgRb7BKIxU2lhTfmem3Xh+2AjHXuIE4bgmEf+r9jIvBXp4kBPtu3MqDWF
         Pt6VxwFpydgj5ph/DPkTi13itBlFnFzrGwdHIBfx7WzEKBeGSL2eaBAFI3uP0UcPcvt7
         rR5Q==
X-Forwarded-Encrypted: i=1; AKwUvBxLRvMBUfaOBaA2JTrbj1FgcLNMnLWDx9aM2AzYG4xOg4h3ZN+9LhAVAVMeMuT2Dnif7GNCfFo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwCtSBYvn15+49xvuXC3DIX+mykp8GB44d3kUfrZMd4uteglJU
	DTtmM1QGb5+7dxXJmaPw1tp8hNtM0xgrTlvD+XNqi6693zTlejA/LVhL
X-Gm-Gg: AYBFou0qN7Li0CzwYqZz2R2af4osisEnBKjEN5e9EDTGU2vd1oSXEn2rNyj2kIA8PzN
	7pDu5P6iTugCxTjFG5zH1rit1EMdyB9GjkmrjhUXA8wzcM4Tv3p5IW1Jsf33G8KNPIoW4FmmHNc
	w/CvbTTMKn02OJ6+gcyWFM5eYoZjLNd6fW4mt3bkn0HFxsC9XfApd1qwOGQ5UZVfr/uEXQO6QQ5
	M16lBky9lBKjL9JiGmsTEsHBkTM8oNsKD6CRPpNaixIaRs2Iw9ozlafqnD8EoVW1IaxRDStIbhh
	8t5WfBmkoAOM4r6Rt5v6rAuULlhzBq/arB4sbNvXxaephhMweONsbaRpGBCbiUae+90HEQc628q
	iB8pIOspsllC7+BushSB6ogdz8D/YASmX7yxFo2FibJubLUH1rPSd+pjNiDz4WXASFJNevvu4gJ
	UaKu9NGIdQ/yctlwYNSvWK8gPG+7vUeYCZjUs5XHhdPgahiNhIbGNFUzBE4xUOZz/DLUX323U9P
	Y1gqbWc74f6c7nJGdbCDcuZxvOIYhGA5Z9I31ddTVP3gQRhx2VvAj437FoDuL8623oGhBkoUQpm
	uFAJ6qZWoswRaJk=
X-Received: by 2002:a05:600c:4746:b0:4a3:59c9:a744 with SMTP id 5b1f17b1804b1-4a35ac8bb3fmr87648485e9.7.1792948481674;
        Sun, 25 Oct 2026 10:14:41 -0700 (PDT)
Received: from timur-max.localnet ([62.245.128.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0a9cafsm142731345e9.5.2026.10.25.10.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:14:41 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
Cc: christian.koenig@amd.com, Maciej Kucharek <qchcio@gmail.com>,
 stable@vger.kernel.org, Maciej Kucharek <qchcio@gmail.com>
Subject:
 Re: [PATCH v3 2/3] drm/amdgpu: reset CIK ASIC on Apple boards with VRAM at 0
Date: Sun, 25 Oct 2026 18:14:40 +0100
Message-ID: <0lACxgrfQz2H5tv1x9Ohww@gmail.com>
In-Reply-To: <20261015181837.41690-3-qchcio@gmail.com>
References:
 <CADnq5_NXGqXy7_Ntcv0aGSQt8Ax48-SgWpSv4rTzNjDL-H_8_Q@mail.gmail.com>
 <20261015181837.41690-1-qchcio@gmail.com>
 <20261015181837.41690-3-qchcio@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On 2026. okt=C3=B3ber 15., cs=C3=BCt=C3=B6rt=C3=B6k 20:18:36 k=C3=B6z=C3=A9=
p-eur=C3=B3pai t=C3=A9li id=C5=91 Maciej=20
Kucharek wrote:
> On MacBookPros with switchable graphics, the firmware puts VRAM at MC
> address 0 when the iGPU is enabled.  A later post (S3 resume, GPU
> reset) moves VRAM back to the VBIOS default.  The SI fix resets and
> posts the ASIC at load, so the driver uses the VBIOS layout from the
> start:
>=20
>   "drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0"
>=20
> No MacBookPro has a CIK GPU, and no affected CIK board is known.  Add
> the same test to cik_need_reset_on_init(), so that SI, CIK and VI
> handle this firmware layout in the same way.=20

Just a side note: some old iMacs have a Bonaire GPU, which is CI.
Not sure if those boards are affected or not, but it definitely won't hurt.

> gmc_v7_0 reads
> MC_VM_FB_LOCATION once at init and does not reprogram it.  A CIK board
> with VRAM at 0 therefore has the same problem as the SI boards.
>=20
> After the reset, FB_BASE is not 0, so the new test does not fire again
> on a module reload.
>=20
> Only compile-tested.
>=20
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Maciej Kucharek <qchcio@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/cik.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c
> b/drivers/gpu/drm/amd/amdgpu/cik.c index d29991a4a..e1029239b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -1927,6 +1927,16 @@ static bool cik_need_reset_on_init(struct
> amdgpu_device *adev) {
>  	u32 clock_cntl, pc;
>=20
> +	/*
> +	 * MacBookPros with switchable graphics put VRAM at 0 when the iGPU
> +	 * is enabled.  Any later post (S3 resume, GPU reset) moves it back=20
to
> +	 * the vbios default, so reset and post on load to start with the
> +	 * vbios layout.
> +	 */
> +	if (adev->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE &&
> +	    !(RREG32(mmMC_VM_FB_LOCATION) &=20
MC_VM_FB_LOCATION__FB_BASE_MASK))
> +		return true;
> +
>  	if (adev->flags & AMD_IS_APU)
>  		return false;




