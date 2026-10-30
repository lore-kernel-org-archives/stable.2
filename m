Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357527;
	b=0r1dgMrQv8roqIhjO4jjEs05Djr5D4Z+FAijYUqLOwRG85IrsfjDoeMSocNEa+cahFpf
	 3zaFuQHr4+y22aCMgoScbMa66lksPm2Cx9UJ4JKpJLimVrHB6b8lYrlAmaYUoSDJk9A1T
	 1hekqlyOx0GyfVM+rxOWiJcpEFR9VN0UpDdGy3QoZsHadyTnaLcS62qgqVreiikbAfcQN
	 ixuv+5bHyGzfqyCiEjU/WwdoxtHXMThHsdKhy9XwgskRdEL0+ESOuLwKHW995TFzwVTj1
	 jxBcCugq8SudlL2Xafy7Ft0J+GBzRZvGgNwGN+BaP7OtUnlc+4jJ//ATCvrDDNS5DgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357527;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lhrGsKLVMbV7XTHftd0nqllhoDlhDEA9CHLB3lRNBB4=;
	b=IQQGM19rGlOhh5iRGYvIXi/zWQ+zdJG+X06bayo6L8yzHYrBpYFdusTEzuu4e2heSZkY
	 Emad4l84Lr/ptJ+xnj7nIjRmp5OW7Kd8y/FodCTrDXDgsfgZ8OfQ0D4rU4Kr6/G4nPYjM
	 +Cqhc9hEXaOGoK/hofsYNSFF+U7TkJ/HB1HWQ7vwXdzOHx3ZtAG6r7oaTqX7qR6ToyVc1
	 6UFeKzQN1Fpq1BNlyFx1Xe6W1lBWRMHOADvpzCL0KOGtLWX4Lo3A1QGcIwmzhz45Eoo25
	 jc1MS2QWgeOsMSXokoOgSjG03gIoe70+W9uUah3CVj9Xjb6IT2XhpNYpI5sZN4usJ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBn6qrXs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AB760A2600;
	Fri, 30 Oct 2026 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBn6qrXs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F591F000C1;
	Fri, 30 Oct 2026 10:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357527;
	bh=lhrGsKLVMbV7XTHftd0nqllhoDlhDEA9CHLB3lRNBB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EBn6qrXsPtybZJRtAuM3J6ydPP2NzcOGFSNGMHH3yhYyxK6XYN5B3Uc9Lq6eZYUxy
	 CDwJbu6se6Kc6pbCdVr0X0Mmu2QuHyBIev0dURXork61rrZJsTbcIyOo1kiPXTxG5m
	 85HInDq4Wn7tq4EHcwfN6ed9sfsOAFX3359KuzlbmpeYCJ7TD28j8gW6Skk3AXz8D0
	 Q1xz8pQ/eNSP4h2orfGq9X+lcz9u/8xtmDrxr6WhzThPnzTA73HIT6uTqslYWFrGEk
	 1WiwfzMLwU+Ll3eX5lYiT8vJuWEK9WwmN00zeqoq2GF+eCs//kjFxU9RYTTRwFyOmL
	 YHeSTSOYRs7bQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mastan Katragadda <Mastan.Katragadda@amd.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 16/21] soundwire: amd: Initialise and cancel IRQ work around manager lifetime
Date: Fri, 30 Oct 2026 10:46:55 +0000
Message-ID: <20261030104840.3361217-17-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261030104840.3361217-1-lee@kernel.org>
References: <20261030104840.3361217-1-lee@kernel.org>
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

amd_sdw_manager_probe() publishes amd_manager via dev_set_drvdata()
before initialising amd_sdw_irq_thread and amd_sdw_work, allowing an
early interrupt to schedule uninitialised work.  During removal,
amd_sdw_manager_remove() only cancels amd_sdw_work without first
cancelling amd_sdw_irq_thread, allowing deferred IRQ work to re-queue
amd_sdw_work or dereference amd_manager after it is freed.

Initialise both work items before calling dev_set_drvdata() in
amd_sdw_manager_probe(), and cancel amd_sdw_irq_thread before
amd_sdw_work in amd_sdw_manager_remove().

Fixes: 65f93e4096a0 ("soundwire: amd: add SoundWire manager interrupt handling")
Closes: https://sashiko.dev/#/bug/linux-9890e8dc-4b7d-44d3-bfb0-171dc421e28c
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/soundwire/amd_manager.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 98b09d81f3b8..2e1038ea0f36 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1185,9 +1185,9 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 		sdw_bus_master_delete(&amd_manager->bus);
 		return ret;
 	}
-	dev_set_drvdata(dev, amd_manager);
 	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
 	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
+	dev_set_drvdata(dev, amd_manager);
 	return 0;
 }
 
@@ -1197,6 +1197,7 @@ static void amd_sdw_manager_remove(struct platform_device *pdev)
 	int ret;
 
 	pm_runtime_disable(&pdev->dev);
+	cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 	cancel_work_sync(&amd_manager->amd_sdw_work);
 	amd_disable_sdw_interrupts(amd_manager);
 	sdw_bus_master_delete(&amd_manager->bus);
-- 
2.56.0.317.g454f8302e1-goog

