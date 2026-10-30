Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357540;
	b=5BRJGBPmFxlDJHJE4xM08unz9fSFFcUvEBhUEOOuJNXfwnD5ycy4xg1Cx3GupXO/7G6N
	 aM5WSv/JYkeXm9R16gLAtwF0Ag0Z6vIScH1GLqJ7EcqrXkpZC1bZ/XrrFvjWDNsAPCM7/
	 8EqMaOjxCm3M9WfRzUnrA1Nn+yKpkxhfZ8VSdkUD5Q9lfM6WfKod7n9K6jet0Q1RlkU7X
	 c9Db97PydB5f8j2yNleIE0yUMhKT3WsHxisBil4c+h5VpKBWQtnoCRsu5Bq9cY4KDPA2d
	 lWGhUq7QKBLvX6t16w0Zj1DnsmWtvdYqXN1qJ4NO56ueTv4tHIyrq7cllKECm+2s1ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357540;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NuqhF3q08xTeVZvsMIZpMZAJJHD2ldPf/dpMypivwf4=;
	b=yG2e/BvN0qTj2hws48XCyFl4LPEEZjhInCqA4XyKgNLZR7ktk01z/rD3gsZkErl65Rtj
	 Vwp0gGXWAtHhQCVd7ie+1bvTRhtH6XiQ0z8bYrdK88VRiqE2yXidjxF/EmKHD5C8zHkQN
	 x9CgOJ83SGFdKdYq+4g47tfIxTgM9oSOr+zEKD0vF5HKIML2cbQjsMczNmDPw3yqXcOKY
	 QUC2BQ6Wzsn+pQbAHt7GGlM1FUfo4LbDylzP/fFsnrm/4kcK4z/dL/4LOc2Gs0hGZgPz1
	 CrWtDc+qSN01EPju/knldRc9PuZQlwavIURWX5zZm8r0pcLO8lk5K5BQnIKlhdB0w5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mmo+IT34;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9F4606B83F;
	Fri, 30 Oct 2026 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mmo+IT34
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704881F000C1;
	Fri, 30 Oct 2026 10:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357539;
	bh=NuqhF3q08xTeVZvsMIZpMZAJJHD2ldPf/dpMypivwf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mmo+IT340Wk40uvY52LPqMCNNCxpEOIV8Pxhh74RgyEky2w6OeE4AtACskrsXJ7xf
	 KbYyH4LQTcJb49Snv18jZ0J/D/2mLe5gJoLPmFVvXaShay+icRTQFXtgg1G3Ezn76t
	 r1SLxQ8rsqQdSCR+RowA9XrBsLo1qB6RVkcCFVM260KpwTA4owHEdxtYV5wtVswCMr
	 EK1z5OHMfj+VSALvMdVi0JChDanv4/897hwtN+zcOQcsCrvGRYYoUZGw2B4b9/9Rdr
	 iYFfNnumKT+m93ZH1ggpjNWAul1J/sLac4RJqmbF6E3s5XMgFDPk1mCrjv7W7cQNic
	 2tWEBabpiIz3w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 18/21] soundwire: amd: Synchronise parent IRQ and disable work on manager removal
Date: Fri, 30 Oct 2026 10:46:57 +0000
Message-ID: <20261030104840.3361217-19-lee@kernel.org>
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

In the ACP top-half interrupt handlers, amd_manager is retrieved via
dev_get_drvdata() and used to schedule amd_sdw_irq_thread when
non-NULL.  If an interrupt is already in flight on another CPU when
amd_sdw_manager_remove() runs, the handler can call
schedule_work(&amd_manager->amd_sdw_irq_thread) after cancel_work_sync()
returns and after devm frees amd_manager.

Disable SoundWire interrupts, synchronise with the parent PCI device
IRQ, disable both manager work items with disable_work_sync(), and mask
interrupts again in case amd_sdw_update_slave_status_work() was running.

Fixes: f93b697ed98e ("soundwire: amd: cancel pending slave status handling workqueue during remove sequence")
Closes: https://sashiko.dev/#/bug/linux-ab458b2e-f505-4a41-8238-a93ceb5d9c77
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/soundwire/amd_manager.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 1d8a08bda261..f39f4f04db7e 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -8,10 +8,12 @@
 #include <linux/completion.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_registers.h>
@@ -1199,8 +1201,11 @@ static void amd_sdw_manager_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
-	cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
-	cancel_work_sync(&amd_manager->amd_sdw_work);
+	amd_disable_sdw_interrupts(amd_manager);
+	if (pdev->dev.parent && dev_is_pci(pdev->dev.parent))
+		synchronize_irq(to_pci_dev(pdev->dev.parent)->irq);
+	disable_work_sync(&amd_manager->amd_sdw_irq_thread);
+	disable_work_sync(&amd_manager->amd_sdw_work);
 	amd_disable_sdw_interrupts(amd_manager);
 	sdw_bus_master_delete(&amd_manager->bus);
 	ret = amd_disable_sdw_manager(amd_manager);
-- 
2.56.0.317.g454f8302e1-goog

