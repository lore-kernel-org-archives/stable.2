Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795051084;
	b=gdwr16K+4e4ZNorNv7aeIXPPrrZKALKKB+xoGi1wez7zGPHw6tz7Vd2Xv6w+oF/26Gud
	 PTUgDE3MneaFduFozWy/6QEKHL4s2XxhagJUQoe++4kJDGpsaCLBcsqjOh5jBDnwN/QKE
	 JkohLC4RnYiAGuZq3YsPln0kLq0nVJDhKbrmVRff2o+uzspduIFIPmxvtCdtgHoNJeZhu
	 szb3LFEpdZOqZxqx5FZcUkXlRrijyB6VLXkVIeL9klleXRxbYsjaZfHk+jDTIbfFUBgSJ
	 V+G7Dlehwyv05TJiMyO/wXO3JP7RmrazW5JABfKvlFd2KKF4Sp2PQIuq1wkpgnpqI+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795051084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=IidocJDbGJXK47j+zgIJSmib9dFoFVHbL0vp9LH6UT4=;
	b=abTl4x5f5bG706oi98vEtSbkiReg+ErPPQ2R6WXszYZ32wcEn4go/dG5ZtxGiLfnVvj/
	 mUgnHjyp6UH6XSio3+wuaA1I2BxBZ1kymSsevx3/kM2RN69ph5T09Rha9fFMwiT3ikXp9
	 lNegrBMZgU6rCu97YLmbkh3jzv52tcVM3uKABt58aTga0uiQqkoLRgZokcnTHQANCVjLj
	 4yt/q4IbWCaG7Nkq8uPLzXNo4NVo7bQSgOFVmJGXZxvKsBPqN3xDqwFsZxf/tMCUA0pe1
	 bJ6ugr1xqbTyFwVNZ3T7af57fnQiBWuZX7k5Yuh7s0y1bZeFEFNBrLgOAT4TSNWZGMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Jojg/YbQ";
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D03606A32F
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 01:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86D03606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jojg/YbQ
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e96502e447so13803565ad.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 17:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795051084; x=1795655884; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IidocJDbGJXK47j+zgIJSmib9dFoFVHbL0vp9LH6UT4=;
        b=Jojg/YbQOeRzdIBj/fYFrVukt/Ls5lmcD3GIUXCppGRqv7lbjgwn/oENJLpDieve8V
         bVKsmCrsy2wQSnCAS6ZXVPCQI1dLYQPHRvHtc3Q5JJJlGWSopr1dNRFskyxafkgaKhGi
         KkFEbrHK+AOEOmxxNVH+ue8SObZ71SgCVeAu1OkZxPeQgJDkdeoBvEQ3w8nY+r03XHLH
         0sYeRSUJujeK+Fd8sNjcbFgTwTWiUiDn32GpAMu+Ya5Wed0yYA+CE7c11gvrTUCg9Ke+
         S1F5shdZ7InVWMZLJ5+9thwOYBpXQv6jEcTVOly45bAvdLU2afbXNfBvz9hQZRYmk1fm
         hLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795051084; x=1795655884;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IidocJDbGJXK47j+zgIJSmib9dFoFVHbL0vp9LH6UT4=;
        b=EajKeXWDNFJOLb5br1cCyft8uBxMCAh7tEXXOy2o03vcF1HeyyKrr0wxyP50B5YrOc
         g938CBL/xE9q3MwKImriuEtMKYwrSR7EJABuUDpWCkVUYDc7tysqAN+Z5gqDHGiSJ8gi
         67ESN7xLT7ohP2b1jEapwaRgguQP4Ye0mBlerVbS/UJQkHQFayP2V+RW0RRKDP9ir6E/
         E9SWsAYcoQ5vQUlos7eGVgIGTz3SwBEGa85ZX7xzMuFkLYbhxV7kqSNDFdBey+PsUh3y
         3HcsjwGnMY2DmWge2UI2iF1uP7LpXH68Vlmm+Tjy5+78ev7vCoXLhVcHoRrbXMZs+C5y
         HBAg==
X-Forwarded-Encrypted: i=1; AL+hErEMHuVUXCOMK2bV6TXDEyozcuORxFJqg7l1gzrZ1hnQhPzYtimxRHzgYIomY+Ov3hQS5CvlwKw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7fAyDM8wTTKQUf6l4ogLVfIam2CkommATXDZd/s9xJz/O1FF+
	7Xxy9lK2MeeIBtz+YxQIFv5hfDFtlrAMO6Q6YOkMcD5x5vYfNZfNhB5F
X-Gm-Gg: AZFdTZfi5mkdAKu/p5d06nUQyD8Z+v5O9TJdHcZ82W0srkWE3v9DRTSElMJwfqhgyhH
	x4BW++Yin9yS/gwKQcOwEefI+7oV8eDDpYbJhdgoiFI71yYso5BMibbADHrbCUse+ay2VucYyrn
	Lioc7IBlOZ9pOcpbQC3EqkUVAdlZpK5mLz3kjkdJVpjFCGB/A7CEl1i3/xrGIBKML4Xl/Gvsju/
	Isa28ZGSl3ThVD0aAbqFGSHOxN+pkuFZTvoo6hjUHWCAVoWzk8Khqqwh97SFdJu+Vdhe+x+hJlN
	OYFwguq0uYI56CGChx9yIsNry+qWd7NZt4sZpfOr//GTefvviB9mo+4TjjqXcHZf4hNKL770qoI
	KHLFvHKRj5Bsr+3ozKkywPiAo9ja1tLMDYgbr/57Vc4RTu26XEfLAF6RBCwFkAdFwGK0Fhzzulh
	G4suNWSTPCZmuyPoNuyoEv6FWGxcm9hsL57J00+SPrnXR3RRuOJSSXCicJiUE60d7QEFrKtypJo
	XinX85iJHS0DNZLlXaJGLd58JXVt37pBE/zLhH8rLKmWQbkjJeRSUSjtFGwtI1zG1PYaKVEI07j
	B1pUbix4DmsMzjsASDah+oOCiUfKtO3+ygKBhD4poMkxO7vKKVlXU5Jd80dwIqCT4N8QFMKWBxN
	TeURq4zqIBAbeJ3RyQIaziyG8P6Zx9Z9LSg==
X-Received: by 2002:a17:902:d489:b0:2f0:943:1178 with SMTP id d9443c01a7336-2f009440af6mr27265855ad.32.1795051083737;
        Wed, 18 Nov 2026 17:18:03 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff6182330sm20533265ad.36.2026.11.18.17.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 17:18:03 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 01:18:03 +0000
Message-Id: <DMYSI3BOQWOC.2P2FZB0H872DR@gmail.com>
Cc: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: Mitigate Spectre v1 in the BPF interpreter
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ryan Roberts" <ryan.roberts@arm.com>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>
In-Reply-To: <20261117172341.3152407-1-ryan.roberts@arm.com>
References: <20261117172341.3152407-1-ryan.roberts@arm.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 17, 2026 at 09:23 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
> The arm64 JIT implements BPF_NOSPEC with a speculation barrier, but the
> interpreter calls barrier_nospec(), which falls back to a no-op on
> arm64. Programs executed by the interpreter therefore lack the
> Spectre-v1 barriers assumed by the verifier. Contrary to the code
> comment, kernel-wide SSBD does not provide this protection, since it
> mitigates Spectre v4 rather than Spectre v1.

Nack.
In bpf-next arm64 has no interpreter when the JIT is built.

