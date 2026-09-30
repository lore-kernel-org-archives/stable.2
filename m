Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F324BF92A
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767177; cv=none; b=SZhg1RwwvL/OhXjeuyco4jbkdTMmm4cNqRDNnrmhXlS2Qgicb9BqcblTssZA7+mqWShfZ0F4jFWKKJFwfsETHnPEF8MtaBq/i8nUbL9PiDhtn4ZAKGxWLijwFoh41Cm7FEjv60LEuz3Bs0NWdwnaZTVjNtWtZGoh6oMokIK7OQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767177; c=relaxed/simple;
	bh=TOVO9shaH7rY62s7j0bP15GMX1Gsny0VtoNt4Gov95k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyIhDoxyiDlqpTtqBFuihPcpZsfd1GkIu84jPZjKI0o1ZYNHEo79IwkcfV4QpBNsVUS8lOUKUAzsBbN16lJEzn1DCBvH9T6z6UgsN7b4lsVtnS/QyXDBhFm1clWe9HFC3DeVw4uQ5gnpR2x98vMk5QC7QTs6HDY0oJlaNMPiOUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGejs1kA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGejs1kA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8231F00898;
	Wed, 30 Sep 2026 11:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790767175;
	bh=8EVSwR0qprciXRna1kIJlGwp6YuJXFf4nEBkIMW0utI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QGejs1kAdWHbzs2nEjLfDz97obEuKwsbXEzOerYBZkL/tkd/tZRCiZuTbJxYTwAGs
	 LBwW0/AVSXn73CZ78ubDEj4YkPIHjbSYqJvCPU8VHKRXJWodRnKQFkZRRCsx6DSfsS
	 OcpihXYum9W9zWKL6sSAi4URSu2mth65MSTAHgUkvfKfSEjb2fWXrZPL126Hc3ViaL
	 KaXqDtCnYTF8kjxgXjEi7d5lWUPXnqr2PFcbzU0++m0MeWzgQ1tOnL3AFsKjdk7Q6t
	 o/RVJMcxj2L1beElfwfhROCtiRSt5lMwV/JQrprbjGiHCUPdfzyfazI6jiWRUNmR0k
	 jevYWG+WwH3/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] net: ena: fix MMIO read buffer leak on probe failure
Date: Wed, 30 Sep 2026 07:19:33 -0400
Message-ID: <20260930111933.1214240-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930111933.1214240-1-sashal@kernel.org>
References: <2026092919-casualty-fetch-4223@gregkh>
 <20260930111933.1214240-1-sashal@kernel.org>
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
index 5159fb9fbe66f..9e92ccf13419f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -4497,6 +4497,7 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_device_destroy:
 	ena_com_delete_host_info(ena_dev);
 	ena_com_admin_destroy(ena_dev);
+	ena_com_mmio_reg_read_request_destroy(ena_dev);
 err_netdev_destroy:
 	free_netdev(netdev);
 err_free_region:
-- 
2.53.0

