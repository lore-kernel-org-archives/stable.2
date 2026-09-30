Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA81D4A3F3D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767398; cv=none; b=mnMLmLfv+xGk+kMOwhVbV4Qg82g026rZICm+94bf2ypQQu04lhoEpiR/BO+K1b4KDpJtyCb7YiYvS7bOvnJLj51J0IpvN4PMgOOJhlIQHM3Gw00i75XBLL+afkbTXrcIk1urz2aoYCJSfkfnDndmfWaINdQK4I3SwtUnbCxM08k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767398; c=relaxed/simple;
	bh=nOq+zHfKhaQgxtpjoAxMw3LLlYnxlEmnTb4XbTFDmOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dne5+C2XSuR03lkzxk24b6v2ZWlKRNXg/NYNKDNi8WhtRLLVhcxpPmbhHPphAzh9mDHESQO32zhCsZEf0iC4CjYXmJvwVHAh2Y5iZC+cBLv7gtnnLiC89BArVuAGA21NtYM8Qn1mC6ssNPF/LF39gao2fISV9qM9ttdbmwpzLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTmQh3/7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTmQh3/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC5E1F00899;
	Wed, 30 Sep 2026 11:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790767397;
	bh=tU1ugLWSje6oFnDVC7wLsLycDOO9Loj5tocIIMfW/fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bTmQh3/7/OX5fj7ZWJma3JvGCYzQHuCzu65zd/UuSWzaTQ4cgcoiMx/pV7AqXT9ZP
	 YHpIMopEELKuKUpnfxwABBwRbTOmgJxpPNjvD/ZKqGNlUa6S2g+pNAw9lFk6GphmhT
	 w64digBjaYbvQmdeGgWJxE38Jv0KogmyD4Aka+PxKdcSoUgqocU4wBEFO0vcq2lFUt
	 t2akX4DNRFrZyNbgb3Esu9VMfLKVr86Yee5GbxXXmIDOY1MvfWjHpAs7457VSDOO/I
	 rAOUL3nQzQpKf5IRr5Qm5LL1/34jL/+hIPnU6cqSiLTJgFjuNtV0CdyvlioOmEsyLg
	 ixAXH7RvFuwbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] net: ena: fix MMIO read buffer leak on probe failure
Date: Wed, 30 Sep 2026 07:23:14 -0400
Message-ID: <20260930112314.1216332-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930112314.1216332-1-sashal@kernel.org>
References: <2026092919-snitch-prompter-ea9f@gregkh>
 <20260930112314.1216332-1-sashal@kernel.org>
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
index be030e50ecb71..5831f7bd81c23 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -4517,6 +4517,7 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_device_destroy:
 	ena_com_delete_host_info(ena_dev);
 	ena_com_admin_destroy(ena_dev);
+	ena_com_mmio_reg_read_request_destroy(ena_dev);
 err_netdev_destroy:
 	free_netdev(netdev);
 err_free_region:
-- 
2.53.0

