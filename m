Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434044;
	b=eA7VjuQVQoc9WP8TLQiXGrA3K0D9cifqlgqHn3kEu2JDoecO7YoCScJy+S+fW+dAICyq
	 lTncf6bN8606imna4UZGCA4G4t6tBWvE901JDJ/mu5ip6fbamW+jIBmYHWmQrqIResrN6
	 84+cu8o54aonynx9mu7bq3H3wRkl+fB2t8U++o1gUIy+olRDeAFjcUJvZ7tFT0V8zqFVz
	 TVoZameXZjux1VK8NHQxGpO+j+y1sWMIKPBlVGHzSGBGaYffAIpYMcsLgqyodxJntxW5L
	 4+cMNJvHJpgqedsSJNbSAUAuFufKpHewQL9z23W4IWv6FrI0fJEJc77XW6QrbmpGKZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434044;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hPA+fu9c0eiFI0kD+EAZDiNVDC8pWETQJZNKgYAh3VA=;
	b=TXH46ayW1ftoFUk1ol+BkkqGKPAvI8aMQkL2y+QFmwluL9u9gMbTHsXC043bQD3KEZyR
	 s/FTFNfotJ7pnHB5D5HnY3MmSGcvO6oAWo9HoR4S/G/3FAz4yfeAvp8EAYVPsTTrZiyVM
	 Tnz9h1pC47bl3skiDluf/RHpqY9CC7r/2tIP8Yg1P1vLw6StciQFjGIUnzu0ErutRb5vS
	 STGF1zh8NU0xM+wc0CGIzdNsa2NKoTwfofSRDY0YEltLzD6Fud6Jxz3q6roBZQGqHjC1O
	 i8HALVzD5iGD8yOKcRh0/eSdq+YTT75ETMaJ2ktmIE0RBZBnVPdcLSgkNKOQv4qnWCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6fYCzH9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9C606A332;
	Wed, 11 Nov 2026 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6fYCzH9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F961F00A05;
	Wed, 11 Nov 2026 21:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434043;
	bh=hPA+fu9c0eiFI0kD+EAZDiNVDC8pWETQJZNKgYAh3VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I6fYCzH9vtquPOYO2/OGhOXQLElzmSJourux0mDbKslwE779M+rDv9rZg2EPmpaB2
	 +W/+rpyY2B1MY5Ak7oLqSBb5F8LIpPyLqeYLTiASg897wK358FSri8vCHIM6Rzi/In
	 vyGVqtcZLFp5XPEKHS2MdV1pP3OQC7Bq1Wh1m6KaC83CidrR5kKv0PEinzAAtl1yVF
	 N3ZQqxdz1Eh1DL6iC+yPeOoUX3KJpbsA19yWzgglHFwn96uk6UvHxH6T802SPx360k
	 lPr677ptj4jCC2mfKG3Atso2I9joI4ci/RDpBUeepQdbRJGaZ8H+YhCeZNeK4wH6SK
	 UCoSssM2wiCJA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Peter Pearse <peter.pearse@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Joachim Eastwood <manabian@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/10] dmaengine: pl08x: Defer OF DMA controller registration until slave setup
Date: Wed, 11 Nov 2026 21:52:39 +0000
Message-ID: <20261111215349.1983909-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261111215349.1983909-1-lee@kernel.org>
References: <20261111215349.1983909-1-lee@kernel.org>
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

pl08x_of_probe() registers the controller with
of_dma_controller_register() before pl08x_dma_init_virtual_channels()
initialises the slave channels list and before
dma_async_device_register() registers the slave DMA device, and
pl08x_probe() does not unregister the OF DMA controller if subsequent
initialisation fails.

Move of_dma_controller_register() after dma_async_device_register() for
the slave device and unwind slave device registration if OF controller
registration fails.

Fixes: aa4734da6674 ("dmaengine: pl08x: support dt channel assignment")
Closes: https://sashiko.dev/#/bug/linux-4e233fb9-3b0c-4442-b601-c6706c9f5aba
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/dma/amba-pl08x.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 543c2eb8cfa8..d8441e338502 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2678,6 +2678,12 @@ static int pl08x_of_probe(struct amba_device *adev,
 
 	pl08x->pd = pd;
 
+	return 0;
+}
+
+static int pl08x_of_register(struct amba_device *adev,
+			     struct pl08x_driver_data *pl08x)
+{
 	return of_dma_controller_register(adev->dev.of_node, pl08x_of_xlate,
 					  pl08x);
 }
@@ -2688,6 +2694,12 @@ static inline int pl08x_of_probe(struct amba_device *adev,
 {
 	return -EINVAL;
 }
+
+static inline int pl08x_of_register(struct amba_device *adev,
+				    struct pl08x_driver_data *pl08x)
+{
+	return 0;
+}
 #endif
 
 static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
@@ -2944,6 +2956,15 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 			__func__, ret);
 			goto out_no_slave_reg;
 		}
+		if (np) {
+			ret = pl08x_of_register(adev, pl08x);
+			if (ret) {
+				dev_warn(&pl08x->adev->dev,
+					 "%s failed to register OF DMA controller - %d\n",
+					 __func__, ret);
+				goto out_no_of_dma;
+			}
+		}
 	}
 
 	amba_set_drvdata(adev, pl08x);
@@ -2954,6 +2975,8 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 
 	return 0;
 
+out_no_of_dma:
+	dma_async_device_unregister(&pl08x->slave);
 out_no_slave_reg:
 	dma_async_device_unregister(&pl08x->memcpy);
 out_no_memcpy_reg:
-- 
2.56.0.567.gdb80ae8cd5-goog

