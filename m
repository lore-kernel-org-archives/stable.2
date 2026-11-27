Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788395;
	b=ERNJWoXKrCp4F4n/cOnavaEMD4VKrnxaZ4AG2mu8Rbu2XQ2AiV1VaSyN0W+gU8r8Z7xQ
	 cvBqNvyDrggNG+/w+Ot4KQGd8kMTQvyEr7jL1rsxwzqvLPv5Lt9WaJqOrlEbO8z5FdB0W
	 8biN/lga5BiRG4vtNk/tuHEUjBOYdx+CL6xvpltRCoDSSCIbPBsFVCcGYweh0HLRltCy2
	 c9gAMOesHMURU4uNU6uBCF+xnjbXWunM+aIo30NORHiqmstmU1DhX/831Em6Sh3j+fwVH
	 5FXE3TMo52XN19hhj1E4SLnqrhn2GFnXpRTEOoToKuiEaokbRYgxmbymEHidANduluA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788395;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cl3WMRh8WfbyggNJj0mYrqYIIHZqYdXVuU2aAEiLuBQ=;
	b=cWHa+SSZmU+SXa1KrKa3IGzH0avc5awpFORGnOyiz0zoVIECvmNu0U7PVV8vdcN+OVyX
	 3vM8n29Fo7EwXD8ql+2SVdAB2e9zcdRFPQSEKNlV+ZOldV27P79EQx5eHmdyI/rBuW3tP
	 ZHzT37imK1EHSnpMOHzcMSbZ9aDIctvNnp2d8hQAr05rLVgXmig6F90Bp0DCMonDcGVNi
	 uWs/SnFJpN8ULyIdQaagOfenIrwRKKvYCfi+W3X1jb0CgEoXdu0yYGmTOpvyBfw55BB+f
	 NkX70kHymjY9BOL/BwZwsX0Kp1a+QEuNNp0l3jh452aq00rFf4QzNEjKMuO3w4RIzbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFqdRanC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC2F606A326;
	Fri, 27 Nov 2026 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFqdRanC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E781F00898;
	Fri, 27 Nov 2026 14:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795788394;
	bh=cl3WMRh8WfbyggNJj0mYrqYIIHZqYdXVuU2aAEiLuBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PFqdRanC2eAH+EKS7miBakhKmzTw8oeFVqlpXTT9gATFls6BiAEdB/F4IO3rOB77C
	 rvvnINPUVac78BJyVuW4dxrAMNbN28bOTm4jgTuLq7y/sm4xFtdHskJxBGNZMW4QRI
	 RqfZ8ohcgcW3BxOoWoqngd2dOV0r7AJY63a7nEiMheyBroR8GB20qJDd8NKN8y2L8x
	 jQxt6Y8ROQboXJf5timEN6AJ09gi17ZmFgUJ6HOdkYFnhiYfI/2gPx18+gzjq5vwDw
	 M+2VzX+15fLltZwkRifYbmDu+1hVtyiDu8MoZhBJ4mdgL5XsTe/CgSAoOqdjqzNemk
	 Vok4ycVsyDWXQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3 04/12] pinctrl: nuvoton: ma35: Assign fwnode to gpio_chip in ma35_gpiolib_register()
Date: Fri, 27 Nov 2026 14:04:52 +0000
Message-ID: <20261127140602.2790001-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127140602.2790001-1-lee@kernel.org>
References: <20261127140602.2790001-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ma35_gpiolib_register() registers all 14 GPIO banks under the same
parent platform device without setting bank->chip.fwnode to the child
bank node.  Consequently, all GPIO banks share the parent pinctrl node
for OF/fwnode lookups, preventing consumer drivers from resolving
phandles to individual GPIO bank child nodes (&gpiob, &gpioc, etc.).

Set bank->chip.fwnode to bank->fwnode before registering each GPIO
chip.

Fixes: f805e356313b ("pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver")
Closes: https://sashiko.dev/#/bug/linux-cbafd8f2-6541-4311-b97b-f7285d2e1992
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v2 => v3:
 - Rebase onto pinctrl/for-next; no functional changes.

 drivers/pinctrl/nuvoton/pinctrl-ma35.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index 797b4dece7b1..b6411fc4d98b 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
@@ -519,6 +519,7 @@ static int ma35_gpiolib_register(struct platform_device *pdev, struct ma35_pinct
 		bank->irqinten = 0;
 		bank->chip.label = bank->name;
 		bank->chip.parent = &pdev->dev;
+		bank->chip.fwnode = bank->fwnode;
 		bank->chip.request = ma35_gpio_core_to_request;
 		bank->chip.direction_input = ma35_gpio_core_direction_in;
 		bank->chip.direction_output = ma35_gpio_core_direction_out;
-- 
2.56.1.839.g22a8290db9-goog

