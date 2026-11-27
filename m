Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795616;
	b=zuc/gzs2ONutrWSiVlm80m+yADUuGHqzwev7wt6vKC9sDoz1chrslU7R5DH0YRXyjLEW
	 x8DJfD4DjM1d3VOxdJd/D5enjOloPGpVWbq+ArBQf+2HixItVDlT4K9eu/15HzuOumbk5
	 NwH7WDp3yLY67hXGRB1kP4iX0E/QAOPKCnaxaLgQU8f/2OTC4/1S5L6GZeOdH33wtJeja
	 px+XxkCSUxKF9+QojGPES898wrpNY6T0dyqCFPlUSKUIPZ56XeT+O1FDPIsW8dCwnXiZV
	 brXOFR+xGG9dlkBVLougQAlKUeOM1LlDWiUbA+OZP1d6Y07/jmAL2CmJzyxvd65InOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795616;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=M4EvdhyPClJMonTpG0zYcUFgKQRAM7QCzBagwXo5SNI=;
	b=uscmbL1RDiBLaU54RYgnydogwRhdPimEufRnqj1p0ePKgHku2cfhlEOv4vmdfNZYi7GE
	 f+YUai/Iat7ygByJGC+UAD8E79GJfCFpI/YIpbRbKK7tbrjz48fm1M4atoOBpkJqVQ6ne
	 ibycjT37RzWyWUmgUya8zqRm4Dhk4Ocn6r9ZpyWwV6arIyQrFuo77mBZ0v6LYuJdMyVb3
	 S0Yj8R+p1jQHnk23y7wnIYTwbAhsazSJ2WYvrDFjoUIMF8Kg7qsx6WON7I+phqUH3Jg/i
	 aTwkFizAlQxbbZLOHzpZL2Oj/o51KkvKCG9xNGUviFU4yFUJ3FYUbu3aeG2RZ5PwZ5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTMA9QsA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE88606A31C;
	Fri, 27 Nov 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTMA9QsA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1351F00893;
	Fri, 27 Nov 2026 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795795616;
	bh=M4EvdhyPClJMonTpG0zYcUFgKQRAM7QCzBagwXo5SNI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=fTMA9QsAwB8bJPOSJOPUWFydDiG1PFYiPq8NMLN6HWt97nVhIQlKvDBFizn8Y+Dkg
	 phSPHhMZIxvj782ArtqbmQsFo+AeXb1JlY5DogSChOcv9ttQY1BVFALOtQav0XmHWw
	 uc2MDzMvRZyxyoZjdI38ro+caUANoCjYBXq5onvAxX5Vz3Rv5bGtHtE7VM/jbOAx5L
	 2HUTHyPPGKgAxIhqSpNSF5uVpqog/mf1EFF02gn/gnPdEw84bXRrvHYZRajIzsftUX
	 Jgn+EzB5bTbwqAPTLOpxw5F2S3d2pt2KHNCsbeAaFg/0AiLcrHx2zTw69wZGmyGNJX
	 QH5BIIYAtcxwA==
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
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] phy: exynos5-usbdrd: gs101 PIPE3 init fixes
From: Manivannan Sadhasivam <mani@kernel.org>
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, RD Babiera <rdbabiera@google.com>, 
 Juan Yescas <jyescas@google.com>, kernel-team@android.com, 
 phone-devel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261123-gs101-usb-phy-orientation-v2-0-3361fa5f7543@linaro.org>
References: <20261123-gs101-usb-phy-orientation-v2-0-3361fa5f7543@linaro.org>
Date: Fri, 27 Nov 2026 21:36:46 +0530
Message-Id: <179579560687.13164.8486442411400032367.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=mani@kernel.org;
 h=from:subject:message-id; bh=BDcgJiWbnqhGl/C9aGkP0Jx2TSH6tbuFkGPv6K1lORk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrCaqZxGLwsp+vABHqDZIpMAqVrDp7VLN3WHr2P
 Y3OeQ44F26JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawmqmQAKCRBVnxHm/pHO
 9amwB/wMm5K3gEqZushzryzNcFitBxYM6BVq+8mETT90/M4B2CtNodxrMJToUpKpRJyS6NZWadt
 3Yee6EJtro3np+SYKcl3iEOzS6bSu27QDA1HhTaw6CmhZBpKs8wXEjh+nS81QjwlIBxZun7lbpb
 zTt3QsH109D8cS239fDSVSOnVOubRA4hocjnZoqEiYa1AFWR2wjEdD/3b7cjjcewPXJqrHnnoJH
 roFHJ+SRVfQ2CYVNLT/ce2AsglbLDFtMm/UKYbtcuOz0jumEs+FbJ1ZeUYHF5p8sqBJyT1I3I2r
 QrY8CC/ikYP2abjZKV5c00yX6hIuCiFO6dWeuTaGcrdNk6h7
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-11-23 14:25 +0000, André Draszik wrote:
> Hi,
> 
> This series contains two fixes for the USB 3.1 PIPE3 PHY initialization
> on Google Tensor gs101:
> 
> 1. Re-initialize the PIPE3 PHY from the Type-C orientation switch
>    callback when the orientation changes while the PHY is already
>    initialized. When a cable is connected during boot, the PHY can be
>    initialized before the TCPC reports the orientation, and DWC3 runtime
>    PM is forbidden by default. Without re-initializing, the SuperSpeed
>    lanes stay programmed for the wrong orientation and the link comes up
>    in high-speed only.
> 
> 2. Apply the existing gs101_tunes_pipe3_postlock[] table once the PLL
>    and CDR have locked. It disables the high-speed RX squelch detector
>    in P3 / U3 to save power while the link is suspended. The table was
>    added in commit 32267c29bc7d ("phy: exynos5-usbdrd: support Exynos
>    USBDRD 3.1 combo phy (HS & SS)") but never applied.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani


