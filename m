Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B54E0B8D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773640; cv=none; b=gCQbawnQrky/fEXUaO6s0adtGxYD601Zwat8g56pt62NXZTg7wsbP9utnHAc/2hJz2zWoHzyDfWROKb+Uqrt8e3qG8Y3jHANj7RvMSQ/cpnjwFS11mBQ1gF7WT9Hoatur3GX7T5nmEZtcgBylhRfAiGmDiVKTvIaU3x1TMwqanQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773640; c=relaxed/simple;
	bh=Z4NU9XWmkHtsh2SM32HrRLPVP57H9Le/8i6kFtTTVZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6gl9sGnfcAfw9PLkEtsmmvSqVE/OK82d5noSHrgyZKeXktbGVRxfeYwnLReL4Pf9JUg/4qfTti0SGRLUyqwPyIPnJFWCRjiMSXNb73Zbg0kTUU+Wn1LMGAIx0qiYhhPU9yAcOO75T1sXh1ZFLGQKvBC4vA7T8eKOBv5xm5APk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMeUbuyP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMeUbuyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33861F000FF;
	Wed, 30 Sep 2026 13:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790773628;
	bh=0G3A5ISEUtBFDtNfZwfaLyNVonzuc4/e/bI9UmH1JuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GMeUbuyPIW516TrR9xHCcn3akQwJ1Snu4l/M1C0fKzctlTgcfyyBg456m9ehmW6bG
	 waKuE512vHDWl48Tfnkq7LDfCS4OANk4cqQQl0WhTZEBdAdKe+Cji84jRl+jxIkBAU
	 FIOAQL+vhVsCXx4rjwOhCyJoZkNS4yBGDBWL9RX3cyQYLPwsLx3G0DhmcEjco68J0z
	 UzwX+tAYRumNCejhQ0pRjg+HZ2nrugMrHUgYkWXYW1HBu/PbJTKVifeBrBm7RrXJEX
	 ukKeJSkWkmnQa0cgmENy6VY7FXVA8DqauP5ZOpXjpLJw55R6YY+DrUVDDebOYiBtMW
	 B/DdNooCkRjgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: ena: fix MMIO read buffer leak on probe failure
Date: Wed, 30 Sep 2026 09:07:06 -0400
Message-ID: <20260930130706.1704870-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092920-urgency-education-bc42@gregkh>
References: <2026092920-urgency-education-bc42@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit 9476b4468862927297c94c440863cd8ed1e7cc83 ]

ena_device_init() initializes the MMIO read mechanism with
ena_com_mmio_reg_read_request_init(), which allocates a coherent DMA
buffer for MMIO read responses.

The normal removal path releases this buffer through
ena_com_mmio_reg_read_request_destroy(). However, if ena_probe() fails
after ena_device_init() succeeds, the error path destroys the admin
resources and eventually frees ena_dev without destroying the MMIO read
request, leaving the coherent DMA buffer allocated.

Call ena_com_mmio_reg_read_request_destroy() in the probe error path
before releasing the remaining device resources.

This issue was found by manual code inspection.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Link: https://patch.msgid.link/20260921154202.471662-3-lgs201920130244@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adjusted context for missing PHC, devlink, and customer-metrics cleanup in Linux 5.10. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index d054ad138d5f0..221315404cfcc 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -4356,6 +4356,7 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_device_destroy:
 	ena_com_delete_host_info(ena_dev);
 	ena_com_admin_destroy(ena_dev);
+	ena_com_mmio_reg_read_request_destroy(ena_dev);
 err_free_region:
 	ena_release_bars(ena_dev, pdev);
 err_free_ena_dev:
-- 
2.53.0

