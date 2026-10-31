Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793457756;
	b=Jxh9RpMo9XfeOPdOOCwPbkG5JZzmAbTZTRDV2qtitZXQuo0zhZS3tgfYYs7NGdESWMuk
	 z6hBtqDDDFeOhp877bY0dUhhDXKJXYhxNm2S7y+7/aRHYIIa/owljULq+lfWMA0VU0liv
	 NIVxXjGXSMPmbRWdg1Vz5RHCieLgdfKd56gKdn0sSTD7HN7B8VWsCpPJTnN4nUozpPVkK
	 vg9eVjJAZN4LS58TpvSKIfb3GkF6vP0zB/avZVZ27kCD1Ftu48Mu5ZE9qjRzvT8SBm0r0
	 Bt5wkaBrlJmJoZu4BFgpNO41VRq6E9gZnQd1SbqN2rZ2BhcXmjZIT1owASUQ49us+mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793457756;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=OEX1w6NcDUbMHOGr/tpCTmQO5YjPoq7wqyclJKvBe3Q=;
	b=xQQrLFxMuYaXL+QK6MdIwRaCbpyxWsihml8oGApdRuA6Dp++hWI27VcZQ/12ucVhUnIH
	 TdGvOE003D+iEIC2LWIbRi24AJeW4mYrcRm3UPlFNllQrerVMwaIx7G6/cfvO3FYqns8b
	 vwlHMKvVlepu8908oXbFc8BzYhBCymycxcie5q+gHXFGshZmOEXPOLKqIAeP8+E4J/rWn
	 7jaNVKc3JmDtQkzMbJNqQY8h/U+54ZXja2sdixxPtFBGSts5ybM+zsm/mt6W9gxtRmwkQ
	 8QDWnb6YfLg6Li+a555gCbjHwOVh0gEH3VyWz52TIA/UCdAUZ6zHDKULO0g8mAjsGRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSIuD74i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BA1606A320;
	Sat, 31 Oct 2026 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSIuD74i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7493F1F0093A;
	Sat, 31 Oct 2026 14:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793457756;
	bh=OEX1w6NcDUbMHOGr/tpCTmQO5YjPoq7wqyclJKvBe3Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RSIuD74iMbJdg+zRyPl3toTOEJPWVCBT+HvQ/GmDkFnZlwVrGWwN6U9vmvmDV2nQ5
	 w0f44m0cyOe3aceGiZw+tocv8BmkAdxVc7Z1e6jLt2AYL5fcgUTr+4N13RB1y2q2wL
	 vFgVkv8KFLaL+Jn+XSKNT1iRI0jAMZy90i+cwYiJHXv+Q2hYz9ijCUe2VnOwKINJqV
	 f/n89qkEdR9bZCe2NqfbSGRSlRsDUkmX/W4vGybTfmQUlE1SBvwuA9GkOK2BO4SXlP
	 QdkdoyQ6n/GDIAjJ8nBoquy/28aHRgcW6M4lSb+UCxanDKfAf4mvG5RPZanJHWWWGD
	 XE1/11r7i8ASA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Boris Brezillon <bbrezillon@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: stable@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>, 
 Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20261030152405.281376-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20261030152405.281376-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2] memory: atmel-ebi: Disable SMC clock on probe
 failure
Message-Id: <179345775319.31057.10245295412977375850.b4-ty@b4>
Date: Sat, 31 Oct 2026 15:42:33 +0100
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


On Fri, 30 Oct 2026 16:24:06 +0100, Krzysztof Kozlowski wrote:
> Unprepare and drop the SMC clock reference, if probe fails to avoid
> resource leakage e.g. during probe deferral.
> 
> There is no remove() callback, presumably on purpose so only error paths
> are handled.
> 
> 
> [...]

Applied, thanks!

[1/1] memory: atmel-ebi: Disable SMC clock on probe failure
      https://git.kernel.org/krzk/linux-mem-ctrl/c/3bbb9a75ec35e77907b990ae163b596e8e67fb46

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

