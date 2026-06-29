Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8803DCDAD;
	Mon, 29 Jun 2026 08:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782720549; cv=none; b=LA+5TGFByGsdn54K7z11q0uebFUVvLzbNU0dqJL/tyEfYcu5yg0wAC1IjXX720ufkLulYUUnu6ONi8F07bIp0WYofa3vH1erqYVFz3+Yihm7kLNRqXc0rN7A/HA4sDhTI7kQjx0gdHEnk6tHOAk7RJf8f4Pn3oXPEwC1WCH3sCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782720549; c=relaxed/simple;
	bh=Vxoi1cmDZfQArHjfngvHJ3m+cmHDV9o3Lr0fhwyX5is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZY7g8g0YSwp5KJpxBuT81RdwSuv0F0iz+Noumop8jdb7IWgXI0ODZgOlNuQm5MJoITln2ia9Eryvu47+tAIldSXRr6wOkmfHd0SROZzeTcqS/s5VDUx5YzA+7GAOMkgjod+S1nkgpbj2FyBRiwjpB/TDn77zNgeTfDnBaPgSwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=LviCPR3Z; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="LviCPR3Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782720405;
	bh=i2DdokORhd2J9b8fMGYTamdftk3sCUnAFClIAvIlENQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=LviCPR3Z9ksI/Cgwjqaw3FIWaOyix7Pv7T5FkjvKA7IW/ZzdjUAeXLkO5c5QPH8v7
	 Bak0qRAbrSP0prGSIyNqi62R4p6MZMlIWOClWDRgg2g4jh/r6Dlr4dnsuEqr0XxDBm
	 uz6I443MNLFbKTUf8NAa5/UL3nbO1a/QSuFvpB5U=
X-QQ-mid: esmtpgz14t1782720386t569d4ab0
X-QQ-Originating-IP: 261MedjCVxDuM4UpNE1QoVSXNH3HdjfqTuqpgpoG9j0=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Jun 2026 16:06:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8126023900001592942
EX-QQ-RecipientCnt: 11
From: raoxu <raoxu@uniontech.com>
To: tsbogend@alpha.franken.de
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-mips@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH net] net: sgi: ioc3-eth: fix split TX DMA mapping lengths
Date: Mon, 29 Jun 2026 16:06:23 +0800
Message-ID: <4E1486BC4536407E+20260629080623.908426-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Naz1YHCzw2jIHC7m24qCCb6HuBzpVCcNaxUWCyk2JEeHoRtla8cPwZHV
	Rlo5N8f2MPQPpbng4adW1FV48Af4rwt/xtI0rCbEWtlIvcgY8tsTZkFHtGMtjGUVVapoCTc
	QiVnzxod3Mekjnqv6yxkUuaTYay4UiIs036oY34n6APLG1wzOc8GManQq730KraNTU02pok
	RNoe9kIdvyUPab39n+Kh/4SGcNmK9450AnUNOJI4CZTvVhhn5gQbbVVpAAj4NzVYqk2jfrr
	t+Y9wt+1sdzkdpSmMeWYc2URGDvzm35CaXSi6pEagmPattZxB1Nbj8jEmG+VdzbLiWIV7ZD
	ZBMR8cub91hA5fAJtBnSMSvfPpa6/W9M1dTlMIo8euMo5V/pzw1AwrG8FdNPkXDMEdjMfjs
	5Da5bTcDKTuJ16XGvU3LP/tri+aDLkwyArbQNSLYThz/ChcKiRT05ifxxduZOhe74hKNzHJ
	wv6FJCrgdzI2HDjYKf1cykX8MAnI5NxkXawpg6oZlXoEC8eKqUnNz2hB1PTu5WHDZ11kEaR
	DU30KgxXbfb+it8NQbH2gvllmARQhif+pxJIoVjVeDjzK58nAfvDy9x2zt2HLEes637IkGL
	mkQcp5bHS9GtA2uwOi7IH5kc9Fgi6/nm4zF3ThYoCFPDOf50GEsZxrKtIaNVaXXIuM3ONWC
	IJQoNRKUtVkH/lCGVTv9v4xYzt6BtbXhvijUOdSseNivTCQtphy2E8xIrz+f9gK3iag29+r
	SM//FR37LLdh6VPa0oh6nvYyQoPmpcQL6A8wTNW0eXBv+0IOG9ph1c7uDCOvg3VNHB1BJro
	dQwknvyYBJzIH2PXZS9wc92jUOab+WStqKH0wHp8NfycbTJk+/7CzYBoZyDQhLGI0FSZW3n
	jgTDVxQGEuAOLZ7DmSdx1qGxbdUfjrqQrzaS5UlV66sTjOSZGJf3wu3SVvINDBXOw402lDb
	EIlITKvAM0+MDYl+mYSpEZF0uUAkYBUG1tTK2zvFr4O9pP/QhCc+wuwZs3vjrpGH2JlNOIQ
	szpsj+43W+tOAgw7GdDpNenHr+P3iTIzYwUt6d4g==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

When a linear skb crosses a 16 KiB boundary, ioc3_start_xmit()
splits it into two buffers of lengths s1 and s2.  The descriptor
advertises those lengths through B1CNT and B2CNT.

The first buffer is mapped with s1, but the second buffer is also
mapped with s1 even though the device is told to fetch s2 bytes from
it.  When the lengths differ, the DMA mapping does not cover the same
region as the second descriptor buffer, which can result in incorrect
cache maintenance or a DMA fault on implementations that enforce the
mapped range.

There is a separate mismatch in the error path.  If mapping the second
buffer fails, only d1 needs to be unmapped.  d1 was mapped for s1 bytes,
but the driver unmaps it using the full packet length.  Streaming DMA
mappings must be unmapped with the same size used for the corresponding
map operation.

Map the second buffer with s2 and unmap the first buffer with s1 when
the second mapping fails.

Fixes: ed870f6a7aa2 ("net: sgi: ioc3-eth: use dma-direct for dma allocations")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 3973106..261f2d3 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -1061,9 +1061,9 @@ static netdev_tx_t ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		d1 = dma_map_single(ip->dma_dev, skb->data, s1, DMA_TO_DEVICE);
 		if (dma_mapping_error(ip->dma_dev, d1))
 			goto drop_packet;
-		d2 = dma_map_single(ip->dma_dev, (void *)b2, s1, DMA_TO_DEVICE);
+		d2 = dma_map_single(ip->dma_dev, (void *)b2, s2, DMA_TO_DEVICE);
 		if (dma_mapping_error(ip->dma_dev, d2)) {
-			dma_unmap_single(ip->dma_dev, d1, len, DMA_TO_DEVICE);
+			dma_unmap_single(ip->dma_dev, d1, s1, DMA_TO_DEVICE);
 			goto drop_packet;
 		}
 		desc->p1     = cpu_to_be64(ioc3_map(d1, PCI64_ATTR_PREF));
-- 
2.47.3

