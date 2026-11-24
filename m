Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556826;
	b=gyc5d4KicA8PP66frIkahRwFYfl3mt7wrmVTi10v2sAaIe7ly/eWoP/BleB5YxeBim/i
	 D6QsudcKJ+UZWhm1ULNfWPDwJXQVBGrSzNVBtjKYM0GpEHHylF3mvj/8J0agc8leZAKBp
	 Sh+F9E/Wph/JUhBhRPTQnYf2r3tzwF28OdP+yneuwvX6dWO8Ir9+/gQMbd6vQs64DNYIH
	 ZKqg0/kCeAZ5uUQ/kIujYDUcVY5P+EII3tc4qniEJgaW8I6OZi/1OWmbldjZUoNOwQBDI
	 udSCEB7zTaCHCWw0PghvsaW8mR+34xTaBmNQjKvQ2vtr/xcJfGVaXbflM0dLVFy/66A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556826;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=sFe35NL2iJhCjBiZ3K/RSgr7tROyU+38r4TrRpybbew=;
	b=NVlTz76w7DjMgEMakJfStyU0X+fQID0v2ukvlaSoSaoEyZ3hoGG8QN50y07IEqseEXfB
	 zdh+VEHWSSCXtQA+fyp3SDT4tObs/vW/M+g2IM/pNUJsjXkqOtfyyV0+ofQb6VhP0tPdL
	 E6M3hQEmH305mxG9DbohbAgnDojBbHcY1eSVdnKrD24CxJiS69j9eoJHcbk2ZcPYcrhym
	 38DPZcbNdUFeWsyorc90wjvbwLosM/72H5KPY/yrrHNuSWCaQi3kwHWpRrBb3RTcbfgKA
	 0/MlZ01ieXOCVVDyIlfXYXk4u+vVmKiu3eSU1wyL9eO++EFIW2oucgSf4BJNlTE8PAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIJHfmrh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D25606A31E;
	Tue, 24 Nov 2026 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIJHfmrh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2507F1F000D2;
	Tue, 24 Nov 2026 21:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795556826;
	bh=sFe35NL2iJhCjBiZ3K/RSgr7tROyU+38r4TrRpybbew=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=LIJHfmrhZ7lrXDJXCs6W+Dw/Cr5iY0xF+c/2cg0y4faZ1mylrzWx6jmgtl4HR7K2H
	 oC0UEmunA1vMtW3DjQ/QzvIaeGOllcGax6wEdjkeXF3ICLFdw7HaXblWyc/7L9qRc6
	 H2eZtCyugDGzy3Pl5MyGdoUMjjVY0MXoVhuSZbtknmDMXPYm4dH8oiWBUltUoDckUg
	 XBB4y1gEvApJjcr9q2XioWz1PiPs19JpDTrClU9ZtQ+DMVqU+69nI07ZQWnUT+hbK7
	 1JVT7wLzIJZ0OQXx4kJppMHzQA6IgMJr0oa5Qh35F1Wg6F4L3w/qTKq16B9ZglK/ca
	 2RaVb607Y2jSA==
From: Srinivas Kandagatla <srini@kernel.org>
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261118-324f82bd41-slimbus-qcom-0@mail.sdu.edu.cn>
References: <20261118-324f82bd41-slimbus-qcom-0@mail.sdu.edu.cn>
Subject: Re: [PATCH] slimbus: qcom-ngd-ctrl: Fix potential DMA buffer leaks
 on teardown
Message-Id: <179555682488.425418.18392814995588121009.b4-ty@kernel.org>
Date: Tue, 24 Nov 2026 21:47:04 +0000
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
X-Mailer: b4 0.14.3


On Wed, 18 Nov 2026 22:16:47 +0800, Guangshuo Li wrote:
> DMA teardown terminates transfers and releases the channels but leaves
> the coherent message buffers allocated. A subsequent initialization
> overwrites their addresses, and removal loses them permanently.
> 
> Free the buffers after terminating DMA. Clear channels released during
> initialization failure so teardown cannot free the same resources again.
> 
> [...]

Applied, thanks!

[1/1] slimbus: qcom-ngd-ctrl: Fix potential DMA buffer leaks on teardown
      commit: 43cf5a5e34ba866b0220901cdd2d3a21373f03bd

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

