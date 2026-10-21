Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587030;
	b=AOqnUCi2kkkKQ8q9z8IeHfHNED8aAkkidUiD6FKtRNd29ggkWlK6vcGeFtFk7s9NUZ1C
	 n+GXttra54QQnK1s688rUa/HUQq2yF8Ec8hmtvGkgojG4FoqHZoszh6TwJAXxze+HLpg8
	 fRerEa21wvwRYph3vYzrDpGmi6+/DrKpW+XMX+lQeu6JNZa+xV6mqzMcttY/6NX15NR8h
	 lO0eGeJDNBi17ARYLWy1Cc56GWJobQzA3XGAYPtSShrGl8y049QYOng7UVJWXqJGz5zou
	 HOPCkLfMrfIY5KJt7yGDtkc1XwwgHDdci5f8AtgNY8P1M4wiFoTggRYVfrDmkgEvYMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Sh9adS1hWGFrVRHbKh++Je7qyXxMfA8cN2D8AczDFWM=;
	b=Z7MJRUKHufkLuKE9/MBJ+W0nAsovBp0POJ0gI3ErSj/+SN5B2oavsyR/hZwqHLNdUJbV
	 R/VA3hA4QILQC1JQYvgkpJTuNqtaDnxTJ8oZ6bsaDtnxjVTqvddwAcN53zBsPl9M6EYii
	 85nzHK4AlK/XU4N/q7bVVb9y7U4DAz7VXXwJw2dKkecKYRrSZfrSS95NnSOMnGIFo4VrY
	 ioYskvhuCNRTRYZ2HP/75umL+V0eiODn65xk8xEPyaGEISyj2Q3zLQFWnSey8rft5X4rf
	 ssjUL5TaTmc+dLEVue4UoXq+l+9Nhrd7cfY9pQQhTON2xFDfdjOH7CeLmIuwqFFN40w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JiyQTmCV;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF0A606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 12:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FF0A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JiyQTmCV
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1f31c63ebso2756667a12.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792587029; x=1793191829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sh9adS1hWGFrVRHbKh++Je7qyXxMfA8cN2D8AczDFWM=;
        b=JiyQTmCVmGKe2+nE2u+HS4je0wOjsZg36TZwX7toVtzs3H3lTLhUebgRH75hPxpJGe
         4yU/D6GPHoBM5FyRwxJ5CPlrm4gxLq0v8KS0In1uPwet9Y3P3NnoV2kZEz5sfpwY7l82
         XxzQUwNUsBwrjnr4KqZ9dJW+MXq/psb/gNoiXk2UaA3YxwNPlcCYLu9L9HR4n0D3DJlY
         pZJpzKzL7QYY/7ZEIoEiWaYQk6Z0dcvKfeWBGbSkKyHjVqf47JwZ2xORNm9Qs7WJqABs
         5vA4Pn9WdrfUkVvJJPS3OJa68espceU8oGZK2APmHvJj9KSmAIUTxNr6IU40XGL0odvJ
         H4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587029; x=1793191829;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sh9adS1hWGFrVRHbKh++Je7qyXxMfA8cN2D8AczDFWM=;
        b=Pm630/6KLMa4AAWzkzHR8GIDh8+jqvF1bIF+09wvhIXSYN3Ecas9Lv8leZ0VnJHavg
         8FQ0vtMb5jqdtENs5Eem62PEthStIxdQGNT7lTAv1+vowhHQFu2xjlCUu9mFA5snwyFo
         KcauUGHXPt3EyEBc0k8nQ2C+QeONyxQdn9rK8IQRrigXrO1IQqd4KtIXBGOBaCV6umlh
         uEacxwNFJ37bu0TYcYCbCYknqR+8VdTj3DGoIjd4sp0UZ94ESvVKLuQ0AX41JR6Ac9UH
         m7QABLKCUxg7Fg0ZN/TYin3R5M6lOntulHmYsiUVfcgY/6Pb7FKafySoRh1fM2QkwWOM
         pjXg==
X-Forwarded-Encrypted: i=1; AKwUvByS6GG+igOhSHKhOPV2OQS5ac7yxKCBDFdWSIpEmC1xZTBALSupM2/0/ZQrZIG+7V7I2xEvQfk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKF/sfHX0b6xJ+WckAvD+McBTmTF81Apb9NMKAAgyF/aCM1HJRE
	NxD5mWJjgbBjQYwrUBsJdDrP9tabU/sJhc3j4QKyNOD+ZHgcGi7BVEK9yeOdxvetFw==
X-Gm-Gg: AYBFou21KPQZrT7Ct4qVApIpqWmeHlkimO55q2VReoYP8KYKbKhohJ+o6eSEFXC4Ixh
	S0WFKqsdt7GBf+GaaVaFqMelLUqcSEsvy9MXVseeWaUSAXtVznGFUWJWmHSiQCxE+ZP45KX9baB
	DoChv4gz265uBXN0qq4OHzbhcvi+j3nW848rBmub87WVldjl6FkeBeb45bC7df+Q2lk9L8FWqTT
	6uD18wXuZoh8xO/dojwTxF4+DQVdoX0rhqOH1tUjj2TTn0m00IRmSdnEo7Qwb8SAHRChOu8M0PK
	zTqxKiIJogyiZW08MZeaMaW1iAqYBvzlEB/cVmChjJO3BR17Otd1FGIFfxknRxrT0GGkCtrB8Mc
	BO1/vpPNMnfiAoz8TtCVwGRU0S47pDj1wCcc1SLB/KYL5YMnyh0h1UCCVHgs35ANG6NptLx0uVu
	wSpkDxqv65ywuQH1atDCNYpfofePq9rLJWgGuc+quhNQm8CfcA1B1vSRDj/kUEAb2zvaxsRFNt7
	AzSAmRwVrCOZ6Q1J9IlBco7QR1ujWaHamkhcd0EFueCtCPssTIx2cXNiD99CxBN8A/nlkWZ5iBe
	Zc2Lm76TGZhyQDJfxAozyoGE
X-Received: by 2002:a17:906:c114:b0:c2e:22f7:59c5 with SMTP id a640c23a62f3a-c460370aeafmr447928866b.7.1792587027947;
        Wed, 21 Oct 2026 05:50:27 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4678e5acc9sm74841366b.9.2026.10.21.05.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:50:27 -0700 (PDT)
Date: Wed, 21 Oct 2026 13:50:22 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: oupton@kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, joey.gouly@arm.com,
	seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, kernel-team@android.com,
	fuad.tabba@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v1] KVM: arm64: pkvm: Clear GICv3 LRs in the hypervisor
Message-ID: <ati1DrtmMd-63bIN@google.com>
References: <20261021110000.508827-1-vdonnefort@google.com>
 <86qzhjz1iz.wl-maz@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86qzhjz1iz.wl-maz@kernel.org>

On Wed, Oct 21, 2026 at 01:22:28PM +0100, Marc Zyngier wrote:
> On Wed, 21 Oct 2026 12:00:00 +0100,
> Vincent Donnefort <vdonnefort@google.com> wrote:
> > 
> > The LR registers are architecturally UNKNOWN when the CPU boots or
> > resumes. However, in protected mode, only the used ones are reset.
> > During boot the HVC __vgic_v3_init_lrs() is never called because
> > vgic_present is only set in init_subsystems(), after cpu_hyp_init() was
> > called.
> 
> Why don't you fix this rather than making the init even more
> different?

Ack, I'll make a patch to fix that first.

> 
> > Also, the PM notifier isn't registered for pKVM and the HVC
> > becomes unavailable after the host is deprivileged.
> 
> Sanitising the LRs on PSCI_ON is probably the right thing to do, but I
> don't understand why resetting the LRs is out of reach from the host,
> given that the host is fully in charge of the interrupt injection, and
> therefore controls the LRs.

I suppose I could reinstantiate the pm callbacks for pkvm to at least reset the
LRs?

-- 
Vincent

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
