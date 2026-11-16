Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844418;
	b=Or82seuyw5VU4t08LylKH1rYb8OB9R92HkF1ZGiMWarbtCvB0VXxvc146RCHOHKOyz85
	 kbXV3yIC09fSKlsE+7A9M1FsfPMPajm0rEsEs2eaaaLX0cnd9isE7rMgh7TO46inWQ6cq
	 TgX2h7GE7hnrBcOqc10KiSJtn/65JpjPGxPL77+D1U9G2PSBXHeDVcQ4g0oEFuO3RR+Fr
	 aIpWt3R9u3rRhAE6bmbzpdxCUwsCrOsJ9vVWcIOqGCRBLB09NVJfG2zeTGxVqrjfxVtTw
	 77sMQ5MgQ9aPUiia7DZ06Y3WUL0z+QDvuBbV6H11rhy9/5vbL8XYEul6AqfbJ3PrAXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=77Vy6pi0eW8S6m5ZbqHe4qT2EgUKr5qQ13vlMUJ+mT0=;
	b=hujhUOxUA6IM+svd5AF8lNhKwxULFbZP3rpp/eN2l6FXg3nzjWigwAqm5XtMl+6D/EMB
	 ZpUJ+OB6alH6VSWV/1wpDKwUKFFj6Fa1qnbux0k45W9f/DVZZRzbOdN5yKmUuAwbsGNoh
	 I5Zy4dI8e8WodYDZKaemFNrZbRGyHlT4J2e24eDGe/tULMNvwbIf+2tu07R8hX5GtJcM3
	 vkJYON+YpYOOCXR5Ac1H/ZSwXKzKNGDIR0N9GJcVGPklqWNV8lPM+FWRG0ncGg+zN9Cfj
	 2yLKml/tsYQAFk5Y2nh54oFNTizzGHm6KtA0+ol+dNKF2XOcoiZetuICRQOD1ouQd0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=NHWeTTst;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C4F606A322
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 15:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2C4F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=NHWeTTst
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c45551fa84eso694883166b.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 07:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794844416; x=1795449216; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=77Vy6pi0eW8S6m5ZbqHe4qT2EgUKr5qQ13vlMUJ+mT0=;
        b=NHWeTTstFZ+kVJfn1A8995fcswKcQX82ZyhzZaHkuiCEDRkst+ZIx45Js1RCSPznYt
         0ep6/4+htLd2fTq1pt9+be5hgG5Aedhg8Zck1CjTOLI2Qafaw74Eg4nrvemkbVRrljGt
         4pCoHFCjuLRdSP8UPO2jGbvTsQFvrXtwAM4nA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794844416; x=1795449216;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=77Vy6pi0eW8S6m5ZbqHe4qT2EgUKr5qQ13vlMUJ+mT0=;
        b=QbP3sXUf6O05lyfX7R6nyWWS2UGEzmamFNmU0pSd6zcEy86+ckkkBOStOIgtQqUBtm
         8mP1iywgaC6suxUjCiBOvChfEbnOTFqWE1FHvrHh7969y3mpjVkrOdumWY7z9zmFhpA+
         JSE9jZFNIZl9q5XZiXPBdMsoBudmSP4PB2ses3tGr1GR3lSrTJud+SDuAanBH+SvWFYD
         Dy3J0J+Wgw86cs+FRNK0jqgb7dMro8nIp9D5mJ7xZQVJC0jTfCQONXENc8v4vtvQx+9V
         f8MLfz8QlCezeOFVHHYHXTBlC02nRMNkXd0n3zMGfUi2mLdG6SBS9N1YYUkdRqIhFVQP
         0mag==
X-Forwarded-Encrypted: i=1; AL+hErG5137U/R+VPi5LQONDFG04xPPISMm5zH7BxPMo7G62wLA6NLRzMtDEKfi5JVF8mqteiqjekRA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hsndpef2U152PrOFQLjlkU5xpPxoDk7JABjQB7iDdn3poUJBA
	bs/fA1x8x3TGgsUorKsEfh6dmfWZzsjlGdxmuEsOj6CAAFgR3fccoTKsBLiQrinY8cb4QPc0Qjx
	8/CKm8lw=
X-Gm-Gg: AYBFou3/pgrBRnAVenalCOWYQONnCDK+nlgT1MWS6MK+B8Cr79lRhKgrU1K1R2nzqSt
	U07CpMaonL6bdDMHvK88KSA6b18lnAGvE36EugdUUPEsLNmDGsMArluHi9QTi4A4zo4ydCHiZF/
	UGGW95sFen+wYhf8MzFv710IFBtMfg8Oz9AsC9mYSCdfc7VkjRXz4nT7rbfHnYVxpLo9eCUv8U6
	9j5XAo+X8QkYmStRxPaUVRdwCC/5NHmIFc9qDVz7RTAZcxICqXgOZV45XywJb/cgHchpuOWjbdN
	zyzBNaUFtOEHSONXddBB9XbnenqQo/e8ws92bJ7AXUs5JIvj2KsD57Pv0SycOkE20DqJnYEmQdc
	bvWj927jQF3QIVpFdCv6CC4bQSg0rIJvuZT1xO4D7G0sNIK4Ty8qcQ2Ry5NGX6vcNF7WLKypQ0/
	Uug44nr8IgdSXvZ5sEFdvAliJ8MLJsTws4IRuY0IOKM+3HiS2zjlAHR3GeeY/JhQNUJzGSid9vJ
	SVLf5boyMnmhtYuOQYyBJz6eu5XN9VFCNuAQkZLkdz0VAwEEVjfX+cwY42Bl2F1E5wYazEpe+Pe
	c9yz4LoGLlnZ5x5rvoIEFE6ufR8mcJWxHYfQdLxfGez591rB1N2oRZh6KkcRoZ5r
X-Received: by 2002:a17:906:c14f:b0:c50:4a99:f6ec with SMTP id a640c23a62f3a-c5096423769mr915816066b.34.1794844416034;
        Mon, 16 Nov 2026 07:53:36 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50d915a8bcsm163331966b.22.2026.11.16.07.53.33
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 07:53:33 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c45551fa84eso694871766b.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 07:53:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGVBnFMD1Z1fZqh6rdBpi1z10XQfEa3E/TBMuX9hDPUtNQFI0z0Xy328rrVL1iw2p7FBHPIXo4=@vger.kernel.org
X-Received: by 2002:a17:906:ee85:b0:c4d:906:e979 with SMTP id
 a640c23a62f3a-c50961992c5mr867398366b.3.1794844413120; Mon, 16 Nov 2026
 07:53:33 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179480914308.3191731.6125228756396043444.tip-bot2@tip-bot2>
 <avrPcQ4sOkgJPbkZ@gmail.com> <20261116130159.GA1327949@ax162> <CAHk-=wgmkoWHWwaQ6nsGoCiBp0hrpJuiwmoVbQ=Efun8JyUNKw@mail.gmail.com>
In-Reply-To: <CAHk-=wgmkoWHWwaQ6nsGoCiBp0hrpJuiwmoVbQ=Efun8JyUNKw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Nov 2026 07:53:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wik3FXL4wPpu14MLt-9cbvDyPzqBoqiMGKbUCfqTd4tzw@mail.gmail.com>
X-Gm-Features: AclHuK-oq9zA6wa45J4bwxg_9Mpam6vUSgLuWJ97x9ACi2ZaU1ZwVndk4hAsNuk
Message-ID: <CAHk-=wik3FXL4wPpu14MLt-9cbvDyPzqBoqiMGKbUCfqTd4tzw@mail.gmail.com>
Subject: Re: [tip: x86/urgent] x86/build: Do not allow X86_NATIVE_CPU to be
 enabled when compile testing
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Nov 2026 at 07:48, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Or even do '$(CC) -v" and '$(HOSTCC) -v' and check for 'Target' being
> the same, and having a CONFIG_CROSSCOMPILE thing for that?

... and maybe we can just make '-march=native' be a generic setting
and *not* make it x86-specific?

Although it appears that at least on arm, it should do '-mtune=native'
in addition to -march.

                 Linus
