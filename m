Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933550;
	b=4Vgw7c0LEVMLbCuiB+lO9cY3HQlWPk+5bSB/qgaRzwJMtexRjTAl7/O5fwA4UHq3sdaH
	 wAOJ+cjvbetR2o+jzYc30U12bOMOd0DsaT29nbQFbyvbZpXbvvulqE0Y5wigd+HZDfxBs
	 Op/4kHfYrCYp7SpAmKlxGpV408nPZJWnO41wxFsL8aMXGqLjB7xwJ3RMqA5aQJQJG7dew
	 ce/WkVgVjccENixvoV8Juyo3ZE2VI2/ZGYE4vfYvV3TDVfHhKcSO7osMexFXcOOMqmL64
	 vyCHJa9FV64pY6RsiNiVGbx4M5p5nV1iCwPIpS30NzqVakZQRNrXJg/5fQGbIqlHHAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933550;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Jid4wZhSaEhGIgM1uFhcH9xtWnWfBCXJVXpzzKBsbxg=;
	b=xHpjjFcDcV4c1a41759XocYIVR5WGH1hMm5Ng4rR8tDitOI0Z/U8nej1BNC/F51bXse2
	 NBVE4y2ySpbXkqxA/UlVO/fFp4Y8Am8jZS0a4NQ/OFZ5v54zcTwbTke4pO+IFjKlEQEDm
	 mRyptgB36Jw0eRFratqQMFG5aJQZ6y3LT9FYCwt5maYbxY8JGsesQWkv7vTUvSseArAeR
	 MipD5wtUJ8Vy5FGmSLjEnNpceeuvnCQdoevziU1PKpx+6BMRI7Iqu+up7lSSFIGrzY2b3
	 mO3cUUT2YbHE5JKGyrWjeY65ibz8p4uE82zJK7UKEh5HLLOl47J1OrDRiSlZm99Yh9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IT8nOVgd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C491606A32F;
	Tue, 17 Nov 2026 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IT8nOVgd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1601F000D0;
	Tue, 17 Nov 2026 16:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794933550;
	bh=Jid4wZhSaEhGIgM1uFhcH9xtWnWfBCXJVXpzzKBsbxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IT8nOVgdXAtSdWbzG7cgl+pyboXrd0FKFO0LawBaxE4zHCnjZ4tHWpB8u0+6t+qCD
	 ocAmZEKkX8DStWPNyh9zploDu0Z3g3QGc+TGfgWfPejscoGyhzLr35XGvSsqf6xKEd
	 /LXKCjU4YGB8WPJOJSVkbYkzH8yKkILdZLYjtwSKzbOdEMcalTY9/qTfW6jcFceWPz
	 0wxexa8St69tRB77j3Un6v+6yn8ErcuJFgbDLJukQF0CDYtsskszlE2jHXoKNzjQbR
	 UPIx27+KJzy5HuxDOiBC+bdEiO2W5ua3O4rpU/kJO2/xPl8DXMgb4eDA2WFWW8fiNA
	 NjzM+E8fo1znA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 07/11] dmaengine: arm-dma350: Query dma_cookie_status() under vc.lock in d350_tx_status()
Date: Tue, 17 Nov 2026 16:37:08 +0000
Message-ID: <20261117163809.622249-8-lee@kernel.org>
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

Calling dma_cookie_status() before acquiring dch->vc.lock in
d350_tx_status() races with d350_irq() completing the active descriptor
and starting the next queued transfer, causing d350_tx_status() to
observe a stale DMA_IN_PROGRESS status and falsely return DMA_ERROR.

Move the dma_cookie_status() call inside the dch->vc.lock critical
section.

Fixes: 5d099706449d ("dmaengine: Add Arm DMA-350 driver")
Closes: https://sashiko.dev/#/bug/linux-524816d7-ed1c-4f2b-b4c3-65a7e8bb45a3
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2: No changes

 drivers/dma/arm-dma350.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 52f5242ea332..8c1725588f1d 100644
--- a/drivers/dma/arm-dma350.c
+++ b/drivers/dma/arm-dma350.c
@@ -381,9 +381,8 @@ static enum dma_status d350_tx_status(struct dma_chan *chan, dma_cookie_t cookie
 	unsigned long flags;
 	u32 residue = 0;
 
+	spin_lock_irqsave(&dch->vc.lock, flags);
 	status = dma_cookie_status(chan, cookie, state);
-
-	spin_lock_irqsave(&dch->vc.lock, flags);
 	if (cookie == dch->cookie) {
 		status = dch->status;
 		if (status == DMA_IN_PROGRESS || status == DMA_PAUSED)
-- 
2.56.0.679.gc527c65306-goog

