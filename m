Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793716542;
	b=tM3aEz8vhrA/vpnQ8YVZeVbHJ4wyLOtmf9VPBue/X3klqiO2Ve1VsZnDzsErBQsjytr3
	 yeq1wGcUXrbb4qSMdeDNSXIudbKr0ZS7dBdFAqKTmNxqdx+70Y2Ms5GVt0aKmtfQeYdia
	 jPp94DV3zOF/ZsbQxuhUIQ3j8NvCOVNHhEV8uvc0umJgfWWbXKleG0a6x9f6LDJ595kHb
	 anVrFs/ppM9fksdO1iJh8EJjg+PXfOc7ISmcU2XHK3bjI/NtTHouemS+IfTumgdgLAcmN
	 nL8FtzYmdDBi8ybp+KcktjapEn4d0sATL+5yDCGMBMOqqiOxjO0PM9GfFNm1uRqVDAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XR0Bzo9nCDXtzTFfI+PIJF4f5OVzgMjX1gFs5CwTiGI=;
	b=Lm3o4rtY1qk4qVWGLhmltS2OeW5atFn85aQgq3rdQWP69QYrUNp6HVSIssv+YIG779sV
	 8hPWgstQYQ5E9X3M6s3p8X0H+q8lq1LoPDQJuovrqWJf3HeZXQf9lHjpejQPGVkSjMqyl
	 cingPG9ntZjoGHuirBzSIp0q1b4dXmhex5c4gtHm4mn/yfWbvzpNsAyOCayc/zyXsuJQn
	 fmg6F8K61arItlCD1XzXgnvP3ZNQmHtqMIMAzN0kpAtJNjDijwJab8m/n+PjmLHnN/wx/
	 14Sjp1BR32DSBxVpn2so4WJ+wYsYi/2wgdr7o2NyMgBBxxoFnzQHA5oqdGL2ybGw4NQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ngrYs6iK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA1F606A326
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AA1F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ngrYs6iK
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36a1c464349so558597eec.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793716542; cv=none;
        d=google.com; s=arc-20260327;
        b=gXzHPh5soPIj5aHLQ/F0eKlxChhOhQIC1VGXj+uvdUFR0GnMLA63GsvtwwhfI+dhLH
         xk39XK0vSPpxr9/vMQFuBbzlxzlV0YsxABmwvSEKoBv/Nyk/cOJdJ48zbIgRBLiQKsbi
         NAyQyWq6ukzkQKZnrcpI+9O5qlrPuOrqHAcWgD48TdMek2wGuwWd6+fA8Z699UyXtFg4
         5Oh76OpyP5fmV7+fR89WX9HyapysB6ozl8JK36KkbZHNrtmH2bylpaTrq7dEf+xoaum/
         zAuVmp2kUlA4KjDoAZVqcK/t2uGUF0daHzBZGRXvDNoagMKpooh+GT//sG52tH5FEMpV
         zXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XR0Bzo9nCDXtzTFfI+PIJF4f5OVzgMjX1gFs5CwTiGI=;
        fh=QRV8PfTU45gJJOahN3HdKFLoF+CD+Sz0pr99S2+6pbM=;
        b=j6EL8HVMJfjHVqKivk1lxBw7pvOZy8QOQXMT2yeX8v/5dymYUbXK3/ziSKDF7b45Er
         077P/l4ddemPJoC2V2urGDmSfpLdVYA19v28j90GJjrnwWbrNY42LjCiAQBw8zljn4OR
         GyJsgqnht/pb2xEDDGxrF5yj8JuVbdV6hi0w+cGlD8k7g0Hm3u/EGN2fm+rKabZmtYop
         cmnE9r24Zet0Hhicw+mwon5pjWDi74jN0oArFA9VvVhbwIcTX9PdXvr2d8GaydgOQCyW
         N0Z5ZQujy5Tof0qqXWANMM/R03Rg1kgc0x6KCoz9cOW9zbF1urN8sAqcxT75tn3qRC7v
         shFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793716542; x=1794321342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XR0Bzo9nCDXtzTFfI+PIJF4f5OVzgMjX1gFs5CwTiGI=;
        b=ngrYs6iKAcb/5/vYddfosLd0IbrUF6dp+qvsbOQhS3QfYNS0Y80I5mCi9mJ/ydjmxv
         9lytQY+4iPX0/okKf2tclejjwP5CZHhKEeMJ/nx6jPIpUcYYZRv5JtwcqTl92hlr0Rqk
         tIyXh1APynp9/AHwJqkHCogZW4naXp7dc9yvgniWoVWAisStPNL80Q9l1XuLMg3zzd+w
         CVz0yALjwRUiTNq+3FzZC57euPYrZC1NAMWWQwQy1bJh3oDE7ufcnSEdan4k/uXC1Shl
         u3vYA/FeeCWhC3XLyd+8qXuZGg7SvpOn83O69vaVL1iOK1x3xv/tydjjaEUV/lV05g6W
         qr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716542; x=1794321342;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XR0Bzo9nCDXtzTFfI+PIJF4f5OVzgMjX1gFs5CwTiGI=;
        b=OdvJZt74eYUFLXfUpkh0RijoLS1DR1ottXu2pUdHdSI+8AaKTqJODJjEAHxKJxll52
         UGMOm0spZi+uipP8qy7bBXjYudzuEpAMSEZJ4HiHhTVsOblgL3rzveuov8B3yUZEIZq4
         ZVyy5GwPAlec83cyP4CA9NPGOSYtSL7pHVgXNtFheod+g+smCVWClpnW7ZF8b8phX+LP
         xrUO4qwz5TQs3pj1yQT+p1IKJk1KjDsmuzNQ70o79srpT0VsS20K99+oq+sGv2N35lWS
         hmFdKmfr/n/qEW+4pT0OR6MXhMobwOt/xlaPEbGF1FP+KsXrMWRL72KP4lNKxVKnPd3N
         LM+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxAv7pZnDqy2IqsziR61wWdvkjRuS3lwHBqsYWHR8hELtQY3b1WTuFJwADPAoz7gfKu3qKJwAU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YbBmpj1+cB31eOLEtKtFrUx9+qX0ccW0rJkyzYAIRggQbp/CD
	fHUAdZAWAekBsYMGXei6yoFXc/kFWwZPYu6KgtU3Kj28sEQIuGSEHL39XiikDbyBYO0i0x5/cxm
	9ixf3qZNeWPVJlg4CLhjpBQgJhF5uB7U=
X-Gm-Gg: AYBFou1iYIfxuL5gsqC73AVMXM5RVvCextnJCpIpNgJ6CrkwEKXf2Sz0Uq1nxXFvNZ2
	hwk7ljR88rf2LuwggVrIRoT2uhtm7uk4dQp60t3TMzyY98Mysuh6szTX8kOQdDezI3FSYUOTsij
	J8KzvlPDVYc5p27uLP5jbxFgdffcUWThBtlMJ6eSCFmfXASq8Ae3c+MUGuEY7TTlsEQIqDxkUK7
	Of1zQb+jBuoCvOL5oOEJwDn80GJJLyO5T1XLVqwNBQf7ogwkU3RlS7RG4erCYvwTC6nJI3rYrJz
	NPgKIQE6qmE9Fa3IHXIh91iw1QN5EBF+YnZWmfGzrq/Kn4JUsUQ8sCebUKnqljwtT0XSj5aHW5s
	UhbPdXmi+MeZtRBYOgB73EZAVxLZAnQa4N06FMF8byszLsdhtrXwigmsQqvf5cYGKEPmTOHfxir
	SqZ6F48Ht4SK9awCpKFpGuHrY=
X-Received: by 2002:a05:7022:b053:20b0:144:fd17:3b21 with SMTP id
 a92af1059eb24-1ac500d67e6mr32546852c88.0.1793716541521; Tue, 03 Nov 2026
 06:35:41 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024162109.307247-1-dev@deq.rocks> <20261102232450.61301-1-jahs@jahs.net>
In-Reply-To: <20261102232450.61301-1-jahs@jahs.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Nov 2026 09:35:29 -0500
X-Gm-Features: AclHuK8qKEQ3sadc6FgPVgIka6386fD7xEODSenxCq71uFCEpk0SM6ipVCbP90w
Message-ID: <CADnq5_P5Ly4Pb8WqPaN28yDHG8jSjoEHAfDKAqSgTrSj14Pr1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: use the VBIOS trained UCLK levels on the
 MacBookPro16, 1
To: James Skillen <jahs@jahs.net>
Cc: Andre Eikmeyer <dev@deq.rocks>, amd-gfx@lists.freedesktop.org, 
	Alex Deucher <alexander.deucher@amd.com>, Kenneth Feng <kenneth.feng@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jesse Zhang <Jesse.Zhang@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 3:21=E2=80=AFAM James Skillen <jahs@jahs.net> wrote:
>
> On Sat, 24 Oct 2026 18:21:09 +0200, Andre Eikmeyer wrote:
> > The Radeon Pro 5300M and 5500M of the MacBookPro16,1 (Navi 14 boards
> > 1002:7340/106b:0210 and 1002:7340/106b:020f) stop answering SMU message=
s
> > as soon as UCLK switches into its third level.
>
> This is the hang reported in drm/amd issue 6005, which has the
> umc_info analysis and test results from both boards:
>
>   https://gitlab.freedesktop.org/drm/amd/-/work_items/6005
>
> Could v2 carry a Closes: tag for it?
>
> I tested the patch on a MacBookPro16,1 with the Pro 5300M (1002:7340
> rev 0x43, 106b:0210, VBIOS 113-D32207P1-019), on linux-t2 7.2.11 (Arch
> v7.2.11-arch1 plus the t2linux patches) with this patch on top. The
> userspace pp_table upload from the issue was disabled for these boots,
> so the corrected levels came from the patch alone.

Can you try this patch instead:
https://patchwork.freedesktop.org/patch/765668/?series=3D174386&rev=3D2

Alex

>
> All at DPM auto unless noted:
>
>  - both "UCLK level ..." lines at boot and again after every resume,
>    pp_dpm_mclk 95/496/598/736
>  - forced pp_dpm_mclk switches through every level transition, idle
>    and under memtest_vulkan load (57 switches, every 3 s): all landed
>  - UCLK pinned at level 2 (598 MHz): llama.cpp benchmark and 180 s of
>    memtest_vulkan, no errors
>  - 60 min soak of llama.cpp runs with idle gaps, and 30 min of normal
>    desktop use with the soak running
>  - 8 deep suspend/resume cycles (rtcwake, lid, systemctl suspend)
>
> I ran these with the internal panel on the iGPU and again with the
> Radeon driving it (apple-gmux force_igd=3Dn). No "SMU: No response", GPU
> reset, ring timeout or DC errors in any of them. With the stock driver,
> level 2 hung within seconds.
>
> For the runs with the Radeon on the panel I also had
> amdgpu.dcdebugmask=3D0x1. That is for a separate DC issue (the MPC pipe
> split on the 3072x1920 eDP plane makes DRAM clock change unsupported,
> so UCLK stays at the top level). It is not related to this patch and
> I will report it separately.
>
> Tested-by: James Skillen <jahs@jahs.net> # MacBookPro16,1, Pro 5300M (106=
b:0210)
>
> The testing above and this reply were prepared with help from
> claude-opus-5-5; I have checked the results and the text.
>
> Thanks,
> James
