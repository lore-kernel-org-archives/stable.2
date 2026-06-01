Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEC639C645
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311072; cv=none; b=lZmr3aKpux/908qiwSikyv2XN8spDRzvsMbHJQGD7g6qtiCHADvlscl9bzZFHvC2qrHrg8hgC3WvCxi0tc+EW4zd7o+1+8cX6BP+AZTu57Gwlj6A6S+pzIsQjBd1iFQXd2mkOu4lX0wGh5/fWtBSxAy5Pt0USPagdEfM/wFvdeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311072; c=relaxed/simple;
	bh=TiOr63QrLYqodw9q8r7YXM4pEJHBv/q0IJvdE8kbxQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7EcDmhq5aIqVVixSvCfsxCCbM3FyU0PnZ1fT+nqgPWymp8BexQtnzNcOHBWSGswdCBtDgpOJgJcU99nurf9l5EjApdwJ5RXmwWsw82+88AooPW2cGIZdGfXq7fDX38/oeHupQJ6Q1k8qiSrnORUQnnKJlB37gBj9iQNn7dFF4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lx+jxdlx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lx+jxdlx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2171F00899;
	Mon,  1 Jun 2026 10:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780311071;
	bh=/prnaV6OnvMGIpqEAXxZfD5+7o3yxNw3kC5Sn19gTzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lx+jxdlxDLsUH9tXbvZ0+XSvP0I0XMUGSiGvR+kExRsEIsQrJKc7SSo0Y54aXLK/B
	 jzZiZd0LfTbAlQprGsgcdf48yyqKa/T3do5NOerAA2aJl1LsMvBL48sINYnha+YLRT
	 TEixl4jNLmIs/X5JjzlBdrtGFyq47tz0eBEvrIPj+vD9hJlJDYXf7rvJCU1UQdpP47
	 wmoI82h6DaJqZzmJJ8xEclWoJnOX05VBCSGCfGnD9oLXy3duI6q66fUf2qIlYNYXbA
	 WJ/j/yuZkjpL7+DQvHvVI2OhQFZ+074DTBehVzi5V7xaBN6v26HqTVhcVbcOA4ISnL
	 zzWezDfFpcQCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] spi: qup: fix error pointer deref after DMA setup failure
Date: Mon,  1 Jun 2026 06:51:08 -0400
Message-ID: <20260601105108.378152-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601105108.378152-1-sashal@kernel.org>
References: <2026052838-tank-lucid-17e8@gregkh>
 <20260601105108.378152-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit a7e8f3efd50a165ba0189f6dc57f7e51a7d149db ]

The driver falls back to PIO mode if DMA setup fails during probe.

Make sure to the clear the DMA channel pointers on setup failure to
avoid dereferencing an error pointer (or attempting to release a channel
a second time) on later probe errors or driver unbind.

This issue was flagged by Sashiko when reviewing a devres allocation
conversion patch.

Fixes: 612762e82ae6 ("spi: qup: Add DMA capabilities")
Link: https://sashiko.dev/#/patchset/20260505072909.618363-1-johan%40kernel.org?part=4
Cc: stable@vger.kernel.org	# 4.1
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260512074334.914735-1-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-qup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index bfa06e61a7e52..e57c4f29f4e5c 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -969,8 +969,11 @@ static int spi_qup_init_dma(struct spi_controller *host, resource_size_t base)
 
 err:
 	dma_release_channel(host->dma_tx);
+	host->dma_tx = NULL;
 err_tx:
 	dma_release_channel(host->dma_rx);
+	host->dma_rx = NULL;
+
 	return ret;
 }
 
-- 
2.53.0

