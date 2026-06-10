Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387ED23EA8A
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 01:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054108; cv=pass; b=ah2CtYgpvBlgAfpuyQZ3ClqIu/TtRyfhArR69BbxlBaxrZ4CVK+wdU6j5DSkXjfL/J6mYdQOuC7jBUT5AcHVdhgJIVY0tNXoFtPiETbwAKGQVKWOyu6CPJJNC8N5o2f4xhwn37qhMgiW02iVoqi9Kdtatd4BSlHMPT5li5jSML0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054108; c=relaxed/simple;
	bh=UeAssUqYMd9I/hNomjKDWuBothPBNmM7nGphuECKV1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1hCBdohnHPef55KEtTsfHIVsohKHI3er19vs1FeIU9ics7ocwFREip0Cxk3TQ0dSW1rD8Jk9LVZppGkV1YOvcsHfDWpAy4aapkeSUfSLWrQjC7RaJ68i6yLXuZVctQcPi7KgR/YIooSJdaG4z4HDmdUzsng87k80og71KEPEiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=qMjegCCc; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="qMjegCCc"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf3781ca51so57294055ad.0
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 18:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781054106; cv=none;
        d=google.com; s=arc-20240605;
        b=i7bLPGxvsVfAN/XIXHa+vEyP/gpUxUttFcfl+XENyfI0qBCMMwMMyvw+25cj+Bb77M
         5yEMHVRZMqUMSgWnicvadE0Ogs2hbRFsAI8yuqUnVi6Fxqhv0m4b9V6OEWr4YJIDFvik
         A3EPhWZgr0cZ9v7oaikj+rf16ga1kosVFkaH2HnKnpZSoIzKy+jvT67aD8lMvn8Sxnuv
         cjIE7rHgnna2ey1gbgNWd/X2Az4z9ReIIvNqGxzaJ1cV1kUbdveIvmJIBpbKhvKL2Rz8
         34FjIS3liWp8MxKK0tSva65PHJtXg1zh4dNOJEsFYH5tzAFLoQZSoTnHr+j7NGNnKiR2
         G0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2Bj40WPn3U8Z/ILKnmF/fVa3Ekp1JSrXZv/lmEeSBo0=;
        fh=ETGlVWZQiSXF8K+hWXx3xwo++PEUKOkyYAm9AaU5tas=;
        b=bG6RyegUpfVwVeWdCVcAeM5NjS1sFdWP3IIGSzONta5LqlMhIJriChIIsKWZAOPnGB
         YLluJUaC2FeI2JBizUxL5U8NLeaeTNtEBPxXAj+gkJfFlf+GTfImPiRqa71quZRBmvkN
         VTuKtbet7/9OoMMFUozDT8+Trk9s4EGsQNRUp9dj8vDId2XBq3q2BtnbwAvZxvIK/7hB
         N9W6Qe1LcCUiGV66MuaiiCOxD8ceh5HJn4G1gQ6rTYxeZrzo5OpwZOKBI8NhdrGX8c4R
         2N535Wy44xnYSX5RkBq9irovOQVpeHvAzH4vkvJHDMO26Qk3bahjp7ju278WLbwwXenT
         nF5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1781054106; x=1781658906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Bj40WPn3U8Z/ILKnmF/fVa3Ekp1JSrXZv/lmEeSBo0=;
        b=qMjegCCcUBDxXDPpfJ9kUjrMc0PeKNq3qpNPV4QavlcRiZSK99bDy4G24FJO3temQ/
         f7Zv3uYHOTUIwARONd/StE6tPPjor/oI5kCeJZ7TFLqJn5c/8P0M0BEh1vLajwJaYBUD
         Myg4BfP5r5PX5ieSW2QJ6eVoar+LkRDgNl6GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781054106; x=1781658906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Bj40WPn3U8Z/ILKnmF/fVa3Ekp1JSrXZv/lmEeSBo0=;
        b=PvXx1iB3wePbqWAhcGKHte4UYajlve9PPqntKccocpTOoKOD5CnbsWEE03r9KPKXea
         usyl+a+pB8ZMWB+PfLd4ReGqgpGFXjRWbUYPdMlcmBEjim5KPfKu691Z3IL/+Nn5Y5h9
         RokvnlhxwynEyJtOS/aBe9mY1IBV1SbgSFCnLGVgYEhigTZlsefwfYwHQIqQw7CyD6E1
         CCJQVZR/AJKZmWFC3VdnYwI3Z33l3UYO3Dxj3O9nOQhJ+sa2CmwXjSXymPUJWxmv7oTQ
         /KYV4M7ORc3nHXIBHhJhj5F+J/nk1BLQqZOKoSS/IMPA3tBEx0MB5uO622Bvfw+DCtqG
         afkg==
X-Forwarded-Encrypted: i=1; AFNElJ/YxKkDpdyYl8sd4/4TaENft5SKWdZoa+yVJDilzDsDevZUgzCHd7f7iNKhiziAviV0a6YrT9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJ5I0pONrwYuHXaoNPRciMhw681lzVvXg39yOa031pGsga5sy
	pHD20reS7no8uKspYIxRwbTepgn38Jb7nE0Y13x6mEAk1nUg0aDet4bNry8t7ce/yv49c+tGwkT
	3eVM/Q3C/RKvTQtYcDP9+W/f0dINxD2PupuKAydTuVg==
X-Gm-Gg: Acq92OE0BPBscWJtnpPNryZrNXK7bUsM75JwpTdtd99yfX2RayxR/qVijP1oExV75VP
	OZsWsboYps0WK8B8CWn4F6KVcyjS/XHbJWIhauBRk/MawlY7T3LNxZupbXvqKq7cSpSQ7vObLHF
	hOGdeAfxkzvb9VuN4f1gEfb+Yxu5MByDAd/IVDYegnAFqlmb4y4WJ0Fnx86KRJT2SQGpdKiJhau
	sQ3ipIzRbauQ8oBTy9SvHsGdt7A6rw90usMiEHIKO5N8KJdLxnEgTREQGrKVrKwVim8gp7earBj
	bcQKBAhYiK2ALSBrfXbTVZH8hOWQtW7J0IUJeIHDCweCVDAItmRFt/GW2DGfy+nXqseNXjiq52r
	S7lCUWL0fMb61XOibjnsPLd6jyBDZoStI8hBslnggrW6q0lv71U7eUmoUGINEpbjjWuIo1eimsi
	5nkTh2Ic+TcM5oTvXBxokR0oI7ws93Dhu0C/OFN46cyJPfX8mJIcrbn4+aBtq1
X-Received: by 2002:a17:903:708:b0:2b7:abc0:3bd7 with SMTP id
 d9443c01a7336-2c1e7e3adb6mr148795125ad.9.1781054106527; Tue, 09 Jun 2026
 18:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601041336.9497-1-daniel@quora.org> <ecavEnqJTDXvfFykc9uJb5No7ioighpjrCdw2CFZ4c8Izr5DxpTs-606Bg7K0RtHTaOqksWivHxWQLzMBP6qow==@protonmail.internalid>
 <20260601041336.9497-2-daniel@quora.org> <ec7c564e-745a-4998-af9a-e9632fe063f7@kernel.org>
 <CAMVG2ssnyH=KUKrdfnUOtPYU7p17inyzcYWcKhT4EAZxDzDjfg@mail.gmail.com> <cb37e7cc-4fb0-4c24-8f89-f6f9eb08a107@oss.qualcomm.com>
In-Reply-To: <cb37e7cc-4fb0-4c24-8f89-f6f9eb08a107@oss.qualcomm.com>
From: Daniel J Blueman <daniel@quora.org>
Date: Wed, 10 Jun 2026 09:14:55 +0800
X-Gm-Features: AVVi8CdzfDox6mz_iOGKn72MQqEfSSNkYmI5x8N9Awxjs-n8z1eY5R0tOZeJjNw
Message-ID: <CAMVG2svgnGKix5vSe8kG694Vm1dU=0Z=MZqR4M5LFOxCXoXYXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: hamoa: Reserve low IOVA range for Iris
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, "Bryan O'Donoghue" <bod@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 14:39, Vikash Garodia
<vikash.garodia@oss.qualcomm.com> wrote:
> On 6/2/2026 9:05 PM, Daniel J Blueman wrote:
> > On Tue, 2 Jun 2026 at 18:27, Bryan O'Donoghue <bod@kernel.org> wrote:
> >> On 01/06/2026 05:13, Daniel J Blueman wrote:
> >>> On X1-family hamoa platforms, Iris DMA below IOVA 0x25800000 (600MB)
> >>> triggers unhandled SMMU page faults
> >>
> >> How do we know that is a correct address - does it come from qcom
> >> documentation or trial and error ?
> >
> > @Vikash, beyond your comment I linked in the patch [1] kindly cite a
> > source for the different stream-ID <600MB behaviour, and share
> > specifics, eg if silicon, firmware, or driver and constraint, defect
> > or otherwise, so I can include a definitive description.
> >
> > Also good to know if my workaround is good for long-term, or on the
> > other hand handling streams <600MB is important/useful.
>
> Thanks Daniel for raising this patch. Did you also try the memory fix i
> mentioned in the bug [1] discussion ?

With this patch, my Lenovo Slim 7x spontaneously rebooted after
opening 3 tabs of https://ui.com rather than 1 without it. No
crash/reboot is reproducible with the patch I proposed.

> 0-600MB range, VPU hardware would reserve this to generate different
> stream-IDs primarily for internal (non-pixel) buffers.

Thanks for the clearer description; I'll respin my patch with this and
the DT fixes shortly to get the X1 user experience under control until
a real fix.

@all I appreciate the ideas and discussion already ensured!

Dan
-- 
Daniel J Blueman
