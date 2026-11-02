Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641048;
	b=d5RgG1ovRkEvQF0QUZ461pEc0dzIHlXuXd/dMVN75EUX4Wynsm8JU5/22OKg7e6yEAvf
	 b1MKDid7OJQu5OIqxfCMmiWQYptrUDvfNB0Jh7YVK5mOgFch7/W8YKqXYubnx6up3P9iV
	 QlVio3uRTGHEsXiVX58+jDmkBU53NPt6WTussg9PbZ8hf9zM/Fbe/p/rnP0LiNXZtMzPX
	 3FJhtCpt+6HRfG81ysgxoUOugCKv+essMhb7Sodu3tvDl84S0CLVHxtIRz4ixBJ6gyIOP
	 BHwASPmGtcKRG4XAiDRoaUtmmM5merrsZaqCiDBb6xKc1wAhU4S8ZQZj04xsf95i4+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641048;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=aKrAeD5fTC0mVauxyRD2jZ+rJcwnyQ067MPIevVp9iw=;
	b=qUCGLld1P2+ak7xIIPVwwSULNc6XcZY0ZjgyQQR9ye/887sebJgBOVcnET9c9WBdmTOr
	 U+Q5nuuSymM1AYOCmOeAZQHbkNJbk8rgMXeyXsPRN9eSAqFTGxqFdB/QVt43PDh6MfLm9
	 tD/00sTp8sKTQOy5Lge4GtJQjd2hzYxDEoEaiIohuqqD5Axdpa7rIjR2V9GmM9PC1tlXH
	 PUNYTMUrazBYPpXh5ukxIvj7ifegkEcUHzAm6Iikccw795+SNy+cWRI5Kj03blZ3I2YW9
	 8bVdp3hFXqfL9u37FnIs0AuwwMnR6N4rArBdbuUXYoJ1v4Td7XeKDrVPAflF9g1O8Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aLrddxu9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3B6606AB85;
	Mon,  2 Nov 2026 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aLrddxu9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3FA1F00A16;
	Mon,  2 Nov 2026 17:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793641047;
	bh=aKrAeD5fTC0mVauxyRD2jZ+rJcwnyQ067MPIevVp9iw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aLrddxu9YmnVGehFCVik3o8rcNzdRoOGqtr9gCJ72D7BrQUqgzzi7Qbuvhv3vMSXd
	 NBzqxQKVxhwSCUyR2u4huv7tr82/m3Zo7Er12ASoOvsWha8DctNoimrjObr7FcO+Fz
	 N98LrwwWmPkOBPxDdfFBkPkLkNDYgJ6kx5hgftdHOmAW18FP6EWki4GzY1CRl6pQB2
	 PokjZ3jgmU9k1F0pzSqnw+zb8VNDD+SbjmUNeTX8k0FsWQQusUDe03gPHVr2KButEt
	 L8weFaI5DyFrM92tUfPnQWMVZB73wuPTal2Y//h3PwAUAFBMzmrpQX8R1Y+bQMOSGq
	 Co8q6EosgE3yA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-samsung-soc@vger.kernel.org, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, stable@vger.kernel.org
In-Reply-To: <20261102125826.3111447-1-m.szyprowski@samsung.com>
References: <20261102125826.3111447-1-m.szyprowski@samsung.com>
Subject: Re: [PATCH v2] ARM: dts: samsung: exynos4210-universal_c210: fix
 BCM4330 Bluetooth GPIOs
Message-Id: <179364104613.252892.2457874270468485723.b4-ty@b4>
Date: Mon, 02 Nov 2026 18:37:26 +0100
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


On Mon, 02 Nov 2026 13:58:25 +0100, Marek Szyprowski wrote:
> BT_REG_ON (BT_EN) line of the BCM4330 WLAN/BT combo chip is connected to
> the XMMC1CMD pad (GPK1[1]), while the XMDMADDR_4 pad (GPE1[4]) is
> connected to BT_RST (BT_nRST). The Bluetooth node however used GPE1[4]
> as shutdown-gpios and left the real BT_REG_ON line undriven, so it was
> kept low by the default SoC pull-down.
> 
> This worked only by accident: the internal regulators of the BCM4330 are
> enabled when either WL_REG_ON or BT_REG_ON is high, so the Bluetooth core
> was powered via WL_REG_ON driven by the SDIO WLAN power sequence, while
> toggling GPE1[4] only released it from reset. Once 'cap-power-off-card'
> was added to the SDIO node, the MMC core started to power off the WLAN
> part (asserting WL_REG_ON low) whenever it was idle, what cut off the
> Bluetooth power as well and resulted in HCI command timeouts.
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: samsung: exynos4210-universal_c210: fix BCM4330 Bluetooth GPIOs
      https://git.kernel.org/krzk/linux/c/78d082e4eb600de4a28e36db89cc528712b2e928

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

