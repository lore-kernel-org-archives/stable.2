Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357533;
	b=gnPCxpr1SzWWA+kC/jQzfcBorSuIGojRbPcn0WS/Z0j4G+C0h/RfvGhFVLkWN3YvOe62
	 5xbBfH63DUH55a+uzzgetScBSH/asUBhBuduIreU2pd85sr81DrBhW2xcsd+7Tb4Sid/1
	 9tiDHW55C+AEv5hs1iWDan4IQ3ApFWSTXSOLWf0IpWsXLVaQvFyQwTNRF9ZlXibOcTfvB
	 J+y/2cinZ8qtI4ZMkRnJT4Az4tRw6RiJexZUR9gyYXZqHb7N0guoqdgO50N4J+hjLKci6
	 PasTohmxeDj+nihdind4BOsZ2Xj+7L8++eIsaLcAhmlJKNsdWM4XtvtvVjiGBAOWpDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357533;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5zH9TXWdjZFi1KC9joNWtcqdKw1UekwzbafvjRyV3T4=;
	b=cYB0rN2fjsK/LfnswX5WP0amjAOVCYpSBWeeM/vhOinaUtwFrdVUhuVRnGdYC6GVx34Z
	 Ey0/e7N9dv1NwL5glq2CMnAy3GxI2h1SL5VkHU9+StZ1GTAeYPjuWhd3+KErRC1WD8ZR9
	 X4WcGi8YhNjtEoRlzhG3TLxNgnJeg8r4VeAhmc5fU9p6R2pZlnjlHoZYGK+3csbfDk1M8
	 W+lI7ZzGOdTrAgIXNOV8+wCXm0EqAJGyUUVWYHtd3BX6Dc8GZNYyq0nMbKgljvDt01F+k
	 VMtrrPhO4WGD/7fxm+3vgJ6CIhlc24TmPf/xzb8P00CBnUgEYL042BNEQ8Xi09sjQpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b0y9mx8S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98108606B816;
	Fri, 30 Oct 2026 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b0y9mx8S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB88B1F0093A;
	Fri, 30 Oct 2026 10:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357533;
	bh=5zH9TXWdjZFi1KC9joNWtcqdKw1UekwzbafvjRyV3T4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b0y9mx8SPQE7Ks7DtUO+XKMm25tnCWONNqdKS/Jtpp6cAD3JpqTwG7Ja0okAZ8Bk2
	 GGuCCV4BD+GH0yfmTle1z2TO6Y7OJHZE1c+yxg4qaTB/ipnQYoH7FWKtnYPrYOoLQX
	 DK88g8cNAmwG3XWcoBNIB2mcsmsoCluGHkwnfC2gU3DRpziwuTOWiQg8D243iUyTbr
	 7wXmCffsXP/Slm8h0jo1Y9ih6/4Q0SANnDMpNYGaYWps6EOu7SpPwAERpx1OPac5pC
	 iIJCdluKivisFCjyoPkdFC6gHEbK0z0HUp6Mc4Tj7p+9vWFCY3wBR0PcDnkzMisbZy
	 Pt5raCp//YXkg==
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
Subject: [PATCH 17/21] soundwire: amd: Resume manager before hardware teardown in amd_sdw_manager_remove()
Date: Fri, 30 Oct 2026 10:46:56 +0000
Message-ID: <20261030104840.3361217-18-lee@kernel.org>
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

amd_sdw_manager_remove() calls pm_runtime_disable() and immediately
accesses MMIO registers in amd_disable_sdw_interrupts() and
amd_disable_sdw_manager() without waking the device if it is
runtime-suspended.

Call pm_runtime_get_sync() before disabling runtime PM and balance the
usage count with pm_runtime_put_noidle() so the controller is awake
during teardown.

Fixes: 81ff58ff71ad ("soundwire: amd: add runtime pm ops for AMD SoundWire manager driver")
Closes: https://sashiko.dev/#/bug/linux-dad4d803-06a7-473d-829d-66860776f4d6
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/soundwire/amd_manager.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 2e1038ea0f36..1d8a08bda261 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1196,7 +1196,9 @@ static void amd_sdw_manager_remove(struct platform_device *pdev)
 	struct amd_sdw_manager *amd_manager = dev_get_drvdata(&pdev->dev);
 	int ret;
 
+	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 	cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 	cancel_work_sync(&amd_manager->amd_sdw_work);
 	amd_disable_sdw_interrupts(amd_manager);
-- 
2.56.0.317.g454f8302e1-goog

