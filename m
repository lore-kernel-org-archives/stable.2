Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB78D3A9002
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791287032; cv=pass; b=HG9cn/uzODDx+LFEKvIWAU1AzKv5LRvw9kjvk6L20KO925mfHoRpuGq2kp3Jz5O0A94nOhnqPD948K063FW2SA6MCYDqAqCDxWOIe2refD/+xxMcntX7jTE/wI6sJpf4wXmK20lC5KTCDotFlkYRus2HVOqjyE0fGmGUIJ9/ITE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791287032; c=relaxed/simple;
	bh=x3rZMdKi3vGTqXwDbjr6PJPvmHZfAQUVoS4iSMA9MB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TH+V2O2wFFr3B6uOSO14fFQAL+Zux86eG5ojCMZ3nwQRN/WJGVMlEDo2q+316ka25w3if+II9hetgNxkcLjishpzO5odZh+dgTaCm0aoykYY0e7duFtUo+uKPNyg39VnWNMG6drQJsUQrfxI0ThwNpSR+FmduV2xkjxqYDYkrkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVS6Ld/A; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVS6Ld/A"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so25914525e9.2
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 04:43:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791287029; cv=none;
        d=google.com; s=arc-20260327;
        b=K4DQMjN/x2HbvmWwjBTnIdczJWYtv0xpQD1wnNQr2/GyVDvOSGG6/7obaITJvmS3Do
         88c8Tc0KUILKOjRDFfoLnAj/YprKtqYmP40/qIArrivfhqLNDCBmmYqqXt6BiQKQKE4k
         hgxl+ZzPHWAedztrDKCSANJRWKdlByKeGKyief7vPQEPVlu6SauhhxuXcMnk50O1J4Y9
         z2a42NuGbR6b+fG2cdIENlCdQkPFxvv1mjJug8HfPuZwxJ9vf8eFsmF3t9BI2opz9xMX
         clX5EQirYrkJjZzUB8RWu8Fvbv5e9RDSVtZcp68Tmaq4TVnJFo+yR+af2nj5esuHnv3m
         KRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0IOK8vNrGs/AYi3igHXIRIEgzlu5V8i6x1q3/Az/h04=;
        fh=LUnQUFaCr1io9MfChIzvZqVAB70eEL9IS1Djw11hGFA=;
        b=bdtAPFdIUx/1a8YwBqYiGMxvneevzeuYxQwtB90hC7rdRmHUpM5Y8oYmgxsKz4BW6X
         Iwtl5MloOnc0TBeHfHEFK8iYcKuHF3x8aSyo9LJzgOD2ZJkl309lnjV5224dn/GDxpla
         xKhJYwwaW26c2u1pleDNTMPqmkdxepr54LWzvbAbl1oDzc+SC5NUDTRRxIxzRfc2RLd0
         +K8ehqylHmTFN/yQ8gfzt8JBf8GTGMS7hgwyrxU1XBRr466DUVYrSSxK3tWv70Febhcw
         pCE2La5FsbZ0Aft8zKV/fAd7RnEIPqClFUiCJCFjS5ipa49qtCpt4buk3veYUsTEY3+b
         cCNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791287029; x=1791891829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0IOK8vNrGs/AYi3igHXIRIEgzlu5V8i6x1q3/Az/h04=;
        b=lVS6Ld/A+7Etdh5Ig9jEnV5cvxOl3AIKY03S5aXRvcWae1Ttb1+S5WFKNBikMH0eXd
         Gfratt2vdBCf7QylGUZg0oJ5HmwWFAI+uyxUQxIMcGqZt9qQG8e/R01G1Q1DfrGsGUA+
         a0svZqbDkEDYk4dbXFiDpmlbNtGyNFWvtl/fj4yHpgAG4WDgvzsw5zM9/rTozYEMCGdL
         UNqLkHeByNpAOTgF3pnLVrsoLkcGvwjU4UWAubh4NzQXt3zrMUEwnmmX/awfa3VUBfzW
         TfHXKHdEp434R9d+gvWhXDTdhYjmUQOP3hx7T9b5mO7qY0VG3pYjzs3dgSG2/UGmXF2X
         BCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791287029; x=1791891829;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0IOK8vNrGs/AYi3igHXIRIEgzlu5V8i6x1q3/Az/h04=;
        b=Tc0Mqikk3MsDEHKu9ATTe/VHhig+XIz/s45P2P4qSa1Nb7nLUHBsX50vcbwbX7Y3Ac
         D/Ol07H/LjJVXydKxeyCEka8WONMYLkS/VS7WQEBf1GU/OC0Jl+m/QDf9iAXkPA7kxQN
         WvWwIagMNNOBOTi9sVDF/6gtVT2HTAYe3ZwfPr1oGQTdcrxxG58b/Xt4DZAZ9g32ySOy
         L8n9tPC0sIX56WZn9QEKc9LrOjWMPI6n/4ezNy1j9PvU3RaJSIGnVR8Kksl3ZQ/HiiuG
         TamgSWIVgAGHExU+SfW+lEwGZfdtCZD86uvEz7O+VcLOa1D++Twj+Vh4BAB20C3hrgUI
         FZdA==
X-Forwarded-Encrypted: i=1; AKwUvBxyZog8qkSGFTuTMdUihHQDEA+6sSME9QSy6riPcTblItgKiqxGKGyD9v32jVHpF/UrDSujQok=@vger.kernel.org
X-Gm-Message-State: AFuF++nrBIZxXP1ESQJG4OqjVlLb6eCGk6mGYcwHiPf2Wnb2blKXHEEM
	MD/9KoyPposA/mt3rEzLAjNuUum3mRHmcLAxUQgWtwBvJBC0qUGLXojHQtJXf2zztmeDGOfSINT
	wnkrg6ZuoCrX74ATW+0ueaoK7am9hp2ItQRBz
X-Gm-Gg: AYBFou1HQO/MnACoG6Z43V9Wkt7Ee4rYu6sieynMFRVxzL9fRepjfBqSvMRJuhmxNNM
	uxHir18aImeOBF3++/VWhRfjbTo1ZkUUmiz5ug+3LF0dCZAkcRMFQNnUv1RdftxXTkwFjipNd/D
	sxWKzwYyDub3CnGfP1yQcZVc1dlxDboMPq1uHwzTZiXvpzClepIQWsb6Ica2vDMp4fcZ0+gpXV0
	xweIM9+oP9T0aE9xr/a6pjxWTM5BWuKlT4Vu6U5P00vWdNMV1H1K2i2Y5g5GCNGJuaJnO8uhce4
	7GOtuSg7Y+I27tLYFX3AnL+Z4+Jy45XtMSv89yy7Kj0aT6MKMn9UIYAuSB+B2Y+6E44e3/BA0JJ
	IhGbrOg2UgOW+daR38kjMYfw23VCiW+75N+hdxO6qAgJh8kbSH3emdjGy5kkArWSmMGaNaQffJe
	zudMVS5vw=
X-Received: by 2002:a05:600c:45c3:b0:4a0:2540:b46 with SMTP id
 5b1f17b1804b1-4a1680e5babmr175664345e9.12.1791287029030; Tue, 06 Oct 2026
 04:43:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929-mali-c55-irq-supend-resume-v1-0-e3af34afff12@kernel.org>
In-Reply-To: <20260929-mali-c55-irq-supend-resume-v1-0-e3af34afff12@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 6 Oct 2026 12:43:23 +0100
X-Gm-Features: AclHuK8EEYHZRufa5Q70T_3oX3Ok7xh0rXwO38lzCRt9fe8SDgh9FN1A00CzUvk
Message-ID: <CA+V-a8sSaGYcMUpXhX+mr2C44zLj2Hgnwj4pQS1t5YrZN1ejqQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] media: mali-c55: Fix IRQ lifetime and wake handling
To: Linus Walleij <linusw@kernel.org>
Cc: Li Youhong <dayou5941@163.com>, Daniel Scally <dan.scally@ideasonboard.com>, 
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, Nayden Kanchev <nayden.kanchev@arm.com>, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Tue, Sep 29, 2026 at 1:08=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
>
> This is essentially my reply with the "proper fix" for:
> https://lore.kernel.org/linux-media/20260903025526.2657105-1-dayou5941@16=
3.com/
>
> Keep the Mali-C55 interrupt requested for the driver's lifetime instead
> of changing interrupt ownership along with the runtime power state.
> Synchronize and disable the IRQ before power-off, and enable it after
> power-on. Hold a PM reference until probe installs the IRQ, and stop
> runtime PM and drain the IRQ before removing the media entities.
>
> Allow platforms to mark the ISP as a wakeup source. Hold a runtime PM
> reference while IRQ wake is armed, resuming an idle ISP if needed and
> preserving an active ISP's configuration. Balance the reference on resume
> and failure. Hibernation still uses the power-down path.
>
> Wake events require a configured stream and an input that remains active
> during system sleep. The internal TPG shares the ISP's power state;
> external sensors and receivers need their own wake support. An idle
> pipeline is not started by this series. Hardware wake remains untested.
>
> The first patch extends the binding with the standard wakeup-source
> property. The second patch updates the driver IRQ and PM handling. The
> third patch retains ISP power while IRQ wake is armed.
>
> Tested on the Renesas RZ/V2H board with the other in-flight patches
> (DTS changes and the TPG enablement) doing full suspend/resume cycles
> with wakeup from RTC and NMI and capturing images before and
> after the test.
>
Can you please share the dependency patches or branch, as these don't
apply cleanly. I tried the latest 'next' and 'media/next' branches
with no luck.

Cheers,
Prabhakar

> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> Linus Walleij (3):
>       dt-bindings: media: mali-c55: Allow wakeup source
>       media: mali-c55: Keep IRQ requested during suspend
>       media: mali-c55: Keep ISP powered while IRQ wake is armed
>
>  .../devicetree/bindings/media/arm,mali-c55.yaml    |  2 +
>  .../media/platform/arm/mali-c55/mali-c55-core.c    | 96 ++++++++++++++++=
+-----
>  2 files changed, 78 insertions(+), 20 deletions(-)
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260918-mali-c55-irq-supend-resume-30b507a20011
>
> Best regards,
> --
> Linus Walleij <linusw@kernel.org>
>
>
