Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EDF3264C3
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766860; cv=none; b=pcQAVD8sdlmNAKgnfnEyUK9qJZu2NWJLYY9VIJwFVwrkzEwwGH4xN8AO3fF2k2l5mlvP/wLjzF2coHS7Z5dsLIn7r453UnA9glQN5Vlj/yiuA+n3rgGYs/LLX1LcbwYOEpA5uJwd+0RxSzhF9Y0T78wYX+WtMhZ+t1aG4oKQ2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766860; c=relaxed/simple;
	bh=wNUq3/gUZ3jK9+OTGcM33ujGPjfK6euvoBQldmTPSNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RR84xOnWqCYOYSKvpMpbz1rGEyJYe/ndH2rRV93Ynx+ScD8C4fqlknVg+Ei29yoTda9vxkazFtPFSdzigEyU+HrSxixpkhgw0swzQtxyKmuJkZHmfcX/I2jkgCwgmQ2J2AxglQIeU54hvwAtS1Lshf5BBvmCpLYMFSFQaHeIQ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaMuYJfW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaMuYJfW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BD71F0089A;
	Wed, 30 Sep 2026 11:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766858;
	bh=HC0QDRe66y/MOwSaBAAUMWIYFf+PejQdKn/6hrBLtbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OaMuYJfWx+pfMtj9Q+ffH0pAW82N4yqZHnF0ssKVC+kv7F1A/agllDMhch4da528g
	 X5dMPYSEnhb+FzUska0a0jaUJXOSIk97SK2VH88a7iE+7+QJ4xioi1DVFNe2F7YkTD
	 gZ+LTk5yXNnt3QXCoUXcqq7/HyHLE20zp+eQz8fCVGQJrsXOaPSxO/tFC8laanOoTD
	 gM10CuCqe2XAe1YRLK8oY+NobRIv0h0B7GqT8ZnCojBP4ddrzjsUZH1qwoekv24lFu
	 748Zp2C4UdA7Q8GyJH2C+t2tX4BJpk7Ggzv6bcpDlsRJ+nwXmZnkzNRQrM/N95yIQL
	 yi5QeDxvI+cBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] net: ena: fix MMIO read buffer leak on probe failure
Date: Wed, 30 Sep 2026 07:14:16 -0400
Message-ID: <20260930111416.1207140-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930111416.1207140-1-sashal@kernel.org>
References: <2026092919-valid-armadillo-00ba@gregkh>
 <20260930111416.1207140-1-sashal@kernel.org>
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
[ Adjusted cleanup context due to missing PHC, devlink, and customer-metrics code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 4d7446bb66b77..1f26851fadbda 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3988,6 +3988,7 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_device_destroy:
 	ena_com_delete_host_info(ena_dev);
 	ena_com_admin_destroy(ena_dev);
+	ena_com_mmio_reg_read_request_destroy(ena_dev);
 err_netdev_destroy:
 	free_netdev(netdev);
 err_free_region:
-- 
2.53.0

