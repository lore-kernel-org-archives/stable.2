Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933503;
	b=s+522LO0Q7J1tW5qmdhlxjL8BPKQ4bQDjEBK3RBulC4s2pUuKI9kLWlZTo2wLsHFP+6i
	 hSFcqwv+7+y9FccNNrair+82NC5uBxM/LQw0Yko8SqNWBh0TgZThnNvBTNZUWadDwJGU/
	 uXF2yXg5FBNqWbeLLC6+ZY/hA1SGCygcuv//kgE7+MaogfMQAZeSwPlbTwiuc1qij1436
	 rPNIRgMCqsIwhJvaEKJ7CmZU3VBYtXiUW60+i283W/9qUU03J3E8R6nJDIgG+7fKou3qF
	 tHynRohEiKtwRxJWZ6NmVqs1HbT59GbWkyTxdYvZnkdOVLQ2eWJjCGFZMPGHu511WwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933503;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RNvs836lkpszr0VZ6j0KYnnJes31voSHxc9/JuZkd5s=;
	b=K5V93tO3uYbO/ZE8jOIBertesvCLJ2+ah4H0hvP3ZqiGuw3ti0/pYXA5K9J15JwNyecM
	 hO37vsvfOEBmtfXphVcjFkVGLZ3bq5u92KU2EjfpL5VTNmUOPn9ljR82HlrFuGQ4RxSmc
	 AIpJeBzK5c6PD/0IJoFxJju1leystlUGIBrIug99mVVFygw3dEUxTwZrH6B/Uc80KnbpN
	 lssvmoTdhxq1RS7bADdGRGfXd5EDilp0hw/bT6wNLVeoOj7B19sL2oEJC+8FtK40sAR6L
	 lB/gdZnmcpyRklE7+ESkdazs2wwmmmuED823No85wrxhyQQkJysiynS3dddL+aSibrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5b1ENAb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5C6606A31C;
	Tue, 17 Nov 2026 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5b1ENAb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9497B1F000C7;
	Tue, 17 Nov 2026 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794933503;
	bh=RNvs836lkpszr0VZ6j0KYnnJes31voSHxc9/JuZkd5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D5b1ENAbK4VRD+buz4eC5wL1ADUOsO2UlDylvQypGW/2AvOU5sc3bj6ftLtNcil72
	 gMj+FZPFka8Jpddm13/l1TlevYpE9eZucjscwJxYCkRAhB3WwYyYsWH8UaSBqQPf3b
	 1/o0Br/vPExjaMtahe6KCP7bENqx/mIoSgJkCMyMVXSoywcGkvyy7dvZaSLZxK3JGL
	 u7s1tdwVjdvvxHmTo7G4z2fEOC9R5gFgiOu73AvJjVMgphbFWytIzvCPJxXZgjttm4
	 Gu1qVntjSXlkQ268Qxsh/lrZMPvgA9aCsdpZgNq7zlKP9rbG1BBbLGZpvwAQWLlNws
	 GZlcgB4fEvRlQ==
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
Subject: [PATCH v2 01/11] dmaengine: pl08x: Defer OF DMA controller registration until slave setup
Date: Tue, 17 Nov 2026 16:37:02 +0000
Message-ID: <20261117163809.622249-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
In-Reply-To: <20261117163809.622249-1-lee@kernel.org>
References: <20261117163809.622249-1-lee@kernel.org>
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

v1 => v2: No changes

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
2.56.0.679.gc527c65306-goog

