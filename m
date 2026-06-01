Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2C18E025
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 01:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780278705; cv=none; b=kEJTfqQRXxSjvIt1P8QI23m/5EUA6X5fM7ybImmL3xxgZXN1U4NZcSsbf8w+RuK755SAs3ti8I6Yt9G7j0z4GmbI+hxWcSVfS2JB8v6WkPPKXMe1iaJudOiqpd1Rt6B7Qlsznc8byqSgZZUHpHN4ta4uG187+FPl3mifJ1m1G58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780278705; c=relaxed/simple;
	bh=TiOr63QrLYqodw9q8r7YXM4pEJHBv/q0IJvdE8kbxQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAAhI0N4CVS7FrbCKQ0lUen+ajKpLUhYvz9xiDpBdPJcRuEe4LXQxlAPaoXTQija56kVxU+dyH+apmMgkLcEzHLQYuIALTflR10CKz1Wn3P7IjktCOK/90VYavFh444MX9+/ygN4/rRNoNSfstI6cg+KFqz/rNfvF6J4GbmMyz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnIW3cei; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnIW3cei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3691F00899;
	Mon,  1 Jun 2026 01:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780278704;
	bh=/prnaV6OnvMGIpqEAXxZfD5+7o3yxNw3kC5Sn19gTzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PnIW3cei/ua5ESV32e5SdoLNrQThXx+qWJK38brx4Sjvc00MpSO6BSBwG6Gw2cE+R
	 BVgHTcGxkvCpO/SEIos6upZbbwx+ZQTSsbkQKf6ySJ/i2rFPMH6jZyMhzkV5R2LAe+
	 wlqwQ7MDoyUl+q93iqv0zYJyRctKRuR4NGmDpUZZchNocXHGu+uK9Z06cW5KyddSX6
	 VYkVfBSsC35I2THiCpZanZ0Y+WXZMREzcNpA/9ohR6QSPEIJjH7nyGglaGsUj9al4w
	 3bLd4xI2ZC3bsyUuHbac5cPW0S1ifgEAT6fM7YHsi2tWG0Qn0iIPU6XfHiuWIUWtVE
	 1FXTBwjnbhjTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] spi: qup: fix error pointer deref after DMA setup failure
Date: Sun, 31 May 2026 21:51:42 -0400
Message-ID: <20260601015142.161971-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601015142.161971-1-sashal@kernel.org>
References: <2026052837-retouch-quotation-3aca@gregkh>
 <20260601015142.161971-1-sashal@kernel.org>
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

