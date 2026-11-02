Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641050;
	b=d19wfTt5SzR54PMwpEcIKU/F4D9UKuLxbzCP0x+YPdxSb2cRw9jMHddW6f4ISMGd7M+d
	 XVRF12HpmoBo7aboGBKLmU5UjDexaEM7XdZdOymL5ILwKhVbhEpiT/nRDclun6cRIOafV
	 spPmTW9JlOTw+xD+FgZvL1RFA89YopV0e1C03y+7+9dmCfJxLb9dWGiXxHYvbnEglr/yP
	 MPbEUHC6TSpZvINGUX/kpOd5Q879ISHZzWbiCkLq/eA62hreAaGljUCHSuwLP+MstHKvt
	 RI170gp4iRqhtwRvCgQv0heVh+6Ce/jxjsUK7INxXmXFQiFMLczW37t1bJX1aqqTyjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641050;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=QYPyRlbCKKI097qvjDIOpJsR6/GyhhM/pN8zdgPgDIg=;
	b=AEn3t+w8XSHNjeUsek2uER7202gcotHtAJnawPQRd5tO9cMK6Ib86qqlPUQyF2UOJ9oP
	 WtKwpcY5JkBERNrAR/Q+AIPuMox88Xwhge8AEr8zVsM6DS0xnzsObm10iO4ugeB+O4SwU
	 ofrtNU0Ec1S7CtBe11WmiJphKpnH5MljtfARPGXBpn30FUY80GCgPSp1MtrtnDq/IV+EY
	 c9d6o97Zo9KSj7d+Z6/J3+LBu5u3PeFt7+P6ucyNSo3E1NZSEOPr9Gq5rNZajKLLoTI/F
	 KRwGHkl9OkGlIx6AgCjIBZRJuZoPJBNZ6ZSIdCx+IGnr/eTMtKQU812syCt/BoNgbpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SW22rfIK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149BD606AB88;
	Mon,  2 Nov 2026 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SW22rfIK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413971F00A17;
	Mon,  2 Nov 2026 17:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793641049;
	bh=QYPyRlbCKKI097qvjDIOpJsR6/GyhhM/pN8zdgPgDIg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SW22rfIKVMtd7pBurH4w/w/trv2WJxKT/KP85YZL7nYcSOcyuAO/xaB2mgCzW/5ap
	 +Qfs0xMztkK86q4AaaRmXDmgUpHlsEa9gWc8r7DWv1Z5FqD3r37BmfKSbqTslziPgj
	 v+0rMWODWAGQS7h/tJieg0tGot35Db+HS/Y+jR2RWJD5EVZ+xjP9UzHMF+MpQQZ3Yf
	 TWvOjw3bw85OjsBGPSkJzvTVMXB38Mj5Xk+eFZdGItyKTy7vYOqGSLoRpOVrCOtDsv
	 AoCPqMO4Q9SkpDBYfClTNgsdpcBtPCKPsfhNTVKKeyw3PCVR0dSPM1I/kfNx2k1N3h
	 J3AHcgnvMg61g==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-samsung-soc@vger.kernel.org, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, stable@vger.kernel.org
In-Reply-To: <20261102125811.3111427-1-m.szyprowski@samsung.com>
References: <20261102125811.3111427-1-m.szyprowski@samsung.com>
Subject: Re: [PATCH v2] ARM: dts: samsung: exynos4210-trats: fix BCM4330
 Bluetooth GPIOs
Message-Id: <179364104797.252892.14779552227648755373.b4-ty@b4>
Date: Mon, 02 Nov 2026 18:37:27 +0100
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
X-Mailer: b4 0.16.0


On Mon, 02 Nov 2026 13:58:10 +0100, Marek Szyprowski wrote:
> According to the board schematic, BT_REG_ON (BT_EN) line of the BCM4330
> WLAN/BT combo chip is connected to GPL0[4], while GPL1[0] is connected
> to BT_RST (BT_nRST). The Bluetooth node however used GPL1[0] as
> shutdown-gpios and left the real BT_REG_ON line undriven, so it was kept
> low by the default SoC pull-down.
> 
> This worked only by accident: the internal regulators of the BCM4330 are
> enabled when either WL_REG_ON or BT_REG_ON is high, so the Bluetooth core
> was powered via WL_REG_ON driven by the SDIO WLAN power sequence, while
> toggling GPL1[0] only released it from reset. Once 'cap-power-off-card'
> was added to the SDIO node, the MMC core started to power off the WLAN
> part (asserting WL_REG_ON low) whenever it was idle, what cut off the
> Bluetooth power as well and resulted in HCI command timeouts:
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: samsung: exynos4210-trats: fix BCM4330 Bluetooth GPIOs
      https://git.kernel.org/krzk/linux/c/a6b33da67ef16a4bdf359d4e76870b1ba1a1360a

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

