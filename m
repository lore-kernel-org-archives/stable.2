Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793652353;
	b=CuIqEJXFGh0JASrfJLcRbRZUizCqblN28O4e8aOGD364cg4pvxIi4ePe9nleiG9Ryu5V
	 5dqGX8ird0wQg2BCdpnWxf2aB0nJEiZiAtvJZ/E8CgHvpTLd5a+RU6Ek1vUDqzZeZP4Yq
	 kMjqDQ6u0PoncodsJcfwWTKBULuj0bulaPUWYrFYYir0SpcoXL1a62HkV8w0Uz5Hq/jCx
	 FGoq4hbZEKNZUEBM7eSVvLoqWsPsQj6u6xnK7u1ZsWOlY7ZMiVkEpX1hO37qsTeiUoxdn
	 4qgpmLsLH2YjKZG//DR9rspWfvvIN8PAXGZtM91maX97XM/HpPuz31VOSavNKc04ZOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652353;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7ThmsoPh60jmutFn026Y/hjznit6Y4ModXUl1yao9uM=;
	b=YpQY553VqfX8w/znTJh4wP01OXOWQi11rYwT5kv5ZcNZcOT/c7CFrAmutX+dQm/kYUe2
	 TwXm+daLmOE3EMGREL0BmwTCufLgl0KsWh9A1ekZ7e0ARj8hLCVkbt0S27em7Wzszz32i
	 rx9EWeFeYy4LxiAH6DGVOpSEPMjT1LoQVNZuqAM2EactpA3WiHjzV7qbE7T6AfDc959HU
	 QJWe3FK3tfqUX6dAEnDZHYjNtE7xU8ZI8JrBn9Ga2H+YvnkSwseA+AgSyQUIMpNuiNPQk
	 XNCv1GZusqfuXdi6+FlEGIz7UTGm2/k1r02b2SKqZZvpDsjjhlqAHFpfvcLGRq9yxAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTmgDvHd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D7606A326;
	Mon,  2 Nov 2026 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTmgDvHd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D9A1F00A16;
	Mon,  2 Nov 2026 20:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793652353;
	bh=7ThmsoPh60jmutFn026Y/hjznit6Y4ModXUl1yao9uM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=nTmgDvHd7M7rUgQ8Fm/Kj3C/r6+rzaMr9BAiGT/lATmBvq2mmK8+y2ivo7eAqyO/3
	 aCZr9avpICBhpnPlG4gA5TjcvnDReHsgrYYE77iqeme6nmdoEQOG0Tq6yJS0+jciRN
	 GQtiYccCw9Oon5/tNSu5YHV1Z0GeOwo8qRXmI1ImOpEGH/r+Z7XiXjnY5njenp6yV4
	 q7LasGRnGD/GGSiOsXJpFG7qMypRVpwDyT6VzeQmh/3fR6ILjGpW9Az4qx2aP5+PlH
	 1lfx4k+CqzZtguSJjYNFX6AzzGPRH4rRnm24ChvvnFSOKYqBiaOl4Lw0NYNzXtoNd4
	 WthqyiL+HnMdw==
From: Brian Masney <masneyb@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Patrick Fischer <admin@tsv-stahl-riesa.de>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, linux-clk@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261029-upstream-speedo-t114-v1-0-81457cc9d94c@tsv-stahl-riesa.de>
References: <20261029-upstream-speedo-t114-v1-0-81457cc9d94c@tsv-stahl-riesa.de>
Subject: Re: (subset) [PATCH 0/3] Tegra114: Fix CPU DFLL voltages
Message-Id: <179365234171.396420.249086277895104244.b4-ty@b4>
Date: Mon, 02 Nov 2026 15:45:41 -0500
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-5d8fe
X-Developer-Signature: v=1; a=openpgp-sha256; l=773; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=jhGhmhENPXajYLqAAD1Uh6BoIa3evnNJu1mZGjUYTVg=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLJefCvf8NggI/XWoqt66aJ3PgjIGyvf1fkqpXFqq9qMx
 ruHX86Q6yhlYRDjYpAVU2RZkmtUEJG6yvbeHU0WmDmsTCBDGLg4BWAibnMZGW60zo6KWcZ/Wf3b
 ges1nPvN9j5LefRpTuQX4xSDth4fxlaG/yk/57pfOd0jkjP/gkPCBx+n4IirBW3OQbFOt/N0L8e
 YMgEA
X-Developer-Key: i=masneyb@kernel.org; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087


On Thu, 29 Oct 2026 10:32:58 +0100, Patrick Fischer wrote:
> Tegra114: Fix CPU DFLL voltages
> 
> Since the Tegra114 CPU DFLL got its CVB tables in v6.18, it computes
> the CPU OPP voltages from tegra_sku_info.cpu_speedo_value and the step
> of the vdd_cpu regulator. On a Tegra Note 7 (Tegra114, TPS65913) every
> CPU OPP from 306 MHz to 1810.5 MHz ends up at 1000 mV, and the DFLL
> never changes vdd_cpu: it stays at the 1.10 V left by the bootloader,
> and the CPU runs at about 1.34 GHz whatever cpufreq requests. Three
> bugs cause this:
> 
> [...]

Applied, thanks!

[3/3] clk: tegra: dfll: Get the voltage step of range-based regulators
      https://git.kernel.org/clk/linux/c/fc1f8f0ceb3b

Best regards,
-- 
Brian Masney <masneyb@kernel.org>

