Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791581;
	b=HqWTTA3x6PIC9rr9+1RCZY6R3mu55QULY5k01HamcC4NbgVWWFP3bqs4xYP7dFa4hKIa
	 Kc56/DPDJS57x1612jtmajAWIcjNyo4oidLFXzLwSqsJrTCCQLg741XeI1JkO1spmzZET
	 XAtNjPUZZYAbpkXZRjTtFsy9j3q876htdxk02HTSVGeBt97r6nodTP9ZUMYQWnKYTx4Gh
	 mm7PBEVlWKwVClcWbA4Wqgrl1uKVaUnXk31+dQ+0fMvmrSeZ8nvgF7vV8020Lud0PGTpB
	 G8fro2rioP3IPv84K1b1XdDnob1G93Xoxtid0c753ZFisyewrY5UFqKANEYW6Dkc4fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791581;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aqgEGVY8i1oDSbWio1gHAr1fehWt8x39GITP8SJlzSE=;
	b=lbFJe2MawbXZ0Rn/ukM6BcXYk+9VBPZDiD8gjhUmbTi7eRAQLEyUg57gX/pLWnGi1qd9
	 h6boruh+pHGNlZSfFdJUmH57jywnsEhWVmHZviY2/Vi4CHK/Mz9GtBCTdtz3lNIN2Mrdl
	 Y3P3g40YSr4ybWZEjQTqMSoKHSCPNqUUZZqnmH+4qycFSuFX4CmzZYxmBdNjaYLrm27Ro
	 4RUR0oF3QFJhphWRxoXvsf8y4geb63F+wWdMsMHGU8qGWBdtNk2rxVyL4Y8y/gpCo61IO
	 siV1FiwsTwdkknmZH4KN6t2e0FzGpnC2IxvROsJ7MywaZpfewa7fSwtuoukmDLP2ung==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aguh6ksT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56AC606A31F;
	Fri, 27 Nov 2026 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aguh6ksT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137691F000C1;
	Fri, 27 Nov 2026 14:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791581;
	bh=aqgEGVY8i1oDSbWio1gHAr1fehWt8x39GITP8SJlzSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aguh6ksTBJes23HlW0mRkr8BD+U+1xIH7wndcu89stk2csFJmiTMzGpT1ePMSXRhM
	 j0HliDhmcVEChZhVvTbkUCvQObMjnG9SksBitd37Yvc5XQaMmPNUIQZdBupp2k8Bdt
	 eX/2A6Y1Sf1j1WXQHGrFWCcrL+qokQY+34EKMn2Y+yeX2MH2Tpdq9RyUFz9LDPpcje
	 2prFAH0d630Km7x2kPsaFjDAOWH0ZxIrV8vDtQ6/1uLLEQdZVHGDgPc+GKyFoZx84B
	 duo69t0q0pHV9QgTzwLeMfNISIdDVqxrOczbBFIFOVbCEzDf5bC+hb96SVoragMNt2
	 p+eMWlOBrmXMQ==
Date: Fri, 27 Nov 2026 14:59:34 +0000
From: Lee Jones <lee@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: maz@kernel.org, andy@kernel.org, jic23@kernel.org,
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	mfd@lists.linux.dev, linux-iio@vger.kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, crofts@kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	stable@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v5 3/4] mfd: mxs-lradc: Pass parent IRQs to child drivers
Message-ID: <20261127145934.GW38590@joneslee-macbookpro.roam.internal>
References: <20261119134041.16611-1-festevam@gmail.com>
 <20261119134041.16611-3-festevam@gmail.com>
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
In-Reply-To: <20261119134041.16611-3-festevam@gmail.com>

On Thu, 19 Nov 2026, Fabio Estevam wrote:

> The MFD driver stores raw DT interrupt indices in IRQ resources but
> registers its child devices without an IRQ domain or IRQ base. The child
> drivers consequently receive the indices as if they were mapped Linux
> IRQ numbers. IRQ index 0 triggers the platform_get_irq_byname() warning:
> 
>   0 is an invalid IRQ number
> 
> The children then try to recover the indices from their resources and
> map them against the parent OF node. Besides duplicating IRQ names in
> the parent and children, this relies on invalid platform IRQ resources
> and fails when IRQ 0 is rejected.
> 
> Resolve the interrupts with platform_get_irq() in the MFD parent and
> store the mapped IRQs in the shared LRADC data. Drop the child IRQ
> resources and duplicated name arrays, and have both child drivers
> request the mapped IRQs directly. Map the MMIO region once in the
> parent and share the mapping with both child drivers through
> struct mxs_lradc, removing the child memory resources.
> 
> Tested on an i.MX28 EVK. The mxs-lradc-ts driver probes successfully,
> touch events are reported, and the touch-detect and LRADC channel 7
> interrupt counters increase as expected.

Doesn't apply to my tree.

-- 
Lee Jones
