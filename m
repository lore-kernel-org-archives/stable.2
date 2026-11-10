Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319411;
	b=25efeAtA8kcOdldvbvghPD/MiX/Sysq/TbhtTgSIwfJcYNAZVJDdTJGOdTGKh2S2zyWH
	 yOg/bcYKNV7e4jsZPWh5KXpeCR6dW5SIiypxYdQY0viwq9uQB1LB+C4dHzi4HWsWrUucs
	 oCye6aAQtqy3ENPvs0qY1H7r4j9wy5yewIfrduPz33i+PHBjp6JO5P7YnGVmuqUxRMNtN
	 WxGGTlUe4M71FyMvJ5qoyw3roTv2MCvRqQwzucdlWrc+jgvE/meha52ea/C2r2odaTCBt
	 izDN4qUazWfkLeP8f/5eJI8yOigUkQyK7ZS2ap4ccbZH9ZIA3ZeohJZkK7Ltr2OpSrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319411;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JIc2aCJ7mBIA0GPO3wRKANcSpq7BoNW6rw/gCbln3J8=;
	b=bmbOdh75qlssO0bX5d7aFVUckxhrFJ3fdJYMVoayL8sLqvk3qIXGSmNqFvAcxas8ClaG
	 MyqN2rf6EQdrwMDQyrTfbDXlUxtuF8i1+RtUpnALEmGLldyjPH3QnK4ygxk21Whp6ivmD
	 2bWFEWOPPhPuMUSJS+btpo0zM2BuuOao7df9dZN0jr+TRuaMh6dkAGYvcVPewkrZiiSY1
	 cilWEMeY0R3VuTZBhQmm+Btjx+YmnrIP3YfwX2Wc0rcRNNbYgs3GDSu/ZJnNK8kVKHARI
	 8NjYH1ujxlLliku1PTJIYjqi7GUMODVlJfzhrO+jTZ3DLs36v9fzZ5UcMl0vt54qyIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAeKnCqC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F2D606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAeKnCqC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A98A1F008A2;
	Tue, 10 Nov 2026 14:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319411;
	bh=JIc2aCJ7mBIA0GPO3wRKANcSpq7BoNW6rw/gCbln3J8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CAeKnCqCMNZkItaEinVRfOb9sXZY48g/p5mzNr/b3HD384zgDxHcae1Xj6AVrljpP
	 0odzlZi+GFKAY0lsLzRcd5H32iSd0CpPGWUoP7z6+sBYa8xpAOAJ0sTMFIY4fH+Mvp
	 oTXhAGrKtyTyTLEnjll4pIIud9A+r6PuFLV4TJHxD9JAGDmyEDL1RwY3a456Qx+bd6
	 uVBdDd2yUg7s8cYWgLUcXWPoZM+iQSP8wG/uUcGim7T+0dk+AXkrZh4HdRogXPwjcO
	 kLSHr0F4Vvsf8FO3ufjci42ohdtyRx5c3oNIoyuSQY2r6HSDTG7W2jqcx4a+5ofedz
	 7G6nPxwkaPXpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] mfd: wcd934x: set DMA mask on parent to silence "DMA mask not set"
Date: Tue, 10 Nov 2026 09:03:28 -0500
Message-ID: <20261110140322.1823724-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110140322.1823724-1-sashal@kernel.org>
References: <20261107060004-failed-5.15-b296be1dc008@kernel.org>
 <20261110140322.1823724-1-sashal@kernel.org>
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

From: David Heidelberg <david@ixit.cz>

[ Upstream commit b296be1dc008fe3a536341afae01f66bb302e67f ]

The wcd934x MFD parent (a slim_device) never initializes its
dma_mask/coherent_dma_mask. When the DT-aware children pass through
of_dma_configure() this triggers the "DMA mask not set" warning for
each child.

Cc: stable@vger.kernel.org
Fixes: f959dcd6ddfd ("dma-direct: Fix potential NULL pointer dereference")
Assisted-by: tencent:hy3
Signed-off-by: David Heidelberg <david@ixit.cz>
Link: https://patch.msgid.link/20260903-wcd-dma-v2-1-189cff560a28@ixit.cz
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/wcd934x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index ac84d45a31ef9..8b83d600b365f 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2019, Linaro Limited
 
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -212,6 +213,11 @@ static int wcd934x_slim_probe(struct slim_device *sdev)
 	struct gpio_desc *reset_gpio;
 	int ret;
 
+	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to set DMA mask\n");
+
 	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return	-ENOMEM;
-- 
2.53.0

