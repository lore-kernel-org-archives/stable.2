Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEBE365A19
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735123; cv=none; b=mz7Ey5ok1CiEB8+xrmJN6IrKy5UoFWZUf9LSIjC9pkEY9xJXCQluU75g68NkIqeZS6aGqAI2iOCPwa17Hg8j+SWh5VKICR/KFBGCEuBy5hsJUkLMuqqVr4KEC0CFp1pBcIrmim1eCdsooukCEZ3jg5hO9a68DULgXuyBo+KwzTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735123; c=relaxed/simple;
	bh=FV0z06mjkSzZk71LCNB0QGS2nrh/YzNlIHIBAfnEIDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZFKOYmrSGeTqAajHmO24CmfazoFaNp+BV85tAlKQhuTrjDxnsgtnD7Ww/xVnv3Hgrn+HJQNM5WMMUtFJF3OBC3jE9sAx5aTnFgOS4QOTwLmFCBDUKJ7657tJ6Gg8tP8lLypVGlZwb4biETfj4XaUua3W6a4Xehvx+fA6GC0SYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COj1cvAV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COj1cvAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5971F00899;
	Wed, 30 Sep 2026 02:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735121;
	bh=s01R58ckHU2JRhYGrhZ8hItZnrtj67to8GRgX2E68W0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=COj1cvAVadTiyuoKtzSKSw2xYJ6olHeGazE9hQEd+bNluva/1sPnceDbQy4VO3UIm
	 Jf3Av1A8Mgsiz8Jtbu10SHvTulLJOtPahU/njJqGoIqIu4kWhszpmMdiSDSfUQm3F9
	 P6MdFrOdmACT/g/8dRAIWcDWRUrVsnGDEDnTfCTTK9SyE+M/KCS2pWLQ4OOsP+59gI
	 cyguNJwPDt5bShrBFzHJ3B1l+vq+jaZudtIzi33mFCeC8lx4X86FXTMEYKp91FaarO
	 Uv9pXBW3pndFXC8JipcKKuu4wUQI9qXX5s5USieRRsw0KqdlvYZeRteVg1UW5LQ/vP
	 BfdfS/+wqmj5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] net: ena: fix MMIO read buffer leak on probe failure
Date: Tue, 29 Sep 2026 22:25:18 -0400
Message-ID: <20260930022518.3389176-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930022518.3389176-1-sashal@kernel.org>
References: <2026092918-goldfish-rocker-07f7@gregkh>
 <20260930022518.3389176-1-sashal@kernel.org>
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
[ Adjusted cleanup context for missing PHC and devlink support. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 9b77dc4a146a8..10e3e8e1898fc 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -4088,6 +4088,7 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_device_destroy:
 	ena_com_delete_host_info(ena_dev);
 	ena_com_admin_destroy(ena_dev);
+	ena_com_mmio_reg_read_request_destroy(ena_dev);
 err_metrics_destroy:
 	ena_com_delete_customer_metrics_buffer(ena_dev);
 err_netdev_destroy:
-- 
2.53.0

