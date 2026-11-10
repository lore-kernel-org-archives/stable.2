Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304838;
	b=KUeVmG5NMnrOfr8SIO5WO4OZLc9GaFBs8H7M7SE7VgibersudH5LrQF2SDmapO8K+Psr
	 Hgj3hOeDF2b8YYSJnZh8mm2sz1GL79kAnJPmR/nSI/RHdFmAg+Dm2xKK8rssMm2BEemDB
	 zvnb5x7DDIDzsTHV6nq7Wkam2IJS5yy1R7UC576L6t80ADF1FAQq1tfk1yy9l3oDj9URC
	 1PV0z7eEli4cAVb+xKbUih/Lv5NwxPuy/ajaQIGxNvUyHhqDqAgkplmT+r86iCyKn+CYH
	 RTwtfGqvxPD4FgI8Q7NdfmBUvkFS4PQ8bdUWn6Ka5nGQEIVRi9Pvbp68UEizLkdKRDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304838;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7QSpnhvQHBRkk3tb8p/YA1UrZAquAgYiGc77d8Y6Tdc=;
	b=i55PjkPP1L77QxwhlGelGqKsnDU33gj2JnwTHmdupWH0Jrp8ySLX2vrpx2qPTz/hxLSo
	 cTrK5NGCdFvo9LVPKRhylEVHA5igrO8zOHR83TTbHGzuXylt4I5HbpuQReRHGEMs9j2fm
	 zwdbuTmyDrVdWeV/oi2zfdyBvMpD5v4ddG9LRMQsvEr1IiRbFSPMksWFnIeTU1ZlcOP1U
	 2sM+g8a0d9MYzMn+FBO14u6W6v6hcqo/OUsjUxN7YLl93eMIwg0A1zjIIsvDooSSC1bSn
	 P3JBsuP7RNRUe+Pe3nUMZwpUJmairrnH2WrZlNB8ZOdCveJN8Kb3ykwyjVqc6rKj0nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aW7P35uY;
	arc=none smtp.remote-ip=115.124.30.113
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE88E60A380E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE88E60A380E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aW7P35uY
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794304833; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7QSpnhvQHBRkk3tb8p/YA1UrZAquAgYiGc77d8Y6Tdc=;
	b=aW7P35uYNdFPMQvVeA9B4d1CdnQVz5wuqCBXYy/IRzmjlpLjmOkOGT8np6i1gprrdCArvwxzTUiQwa9lxs2JpmEqIr0FVLqyWnkF5GKujNiAhMhAVpqq7URxZG5eZWFE/nVHqEynKuQN7pb0Ac2/LECxPXt54jRkS8hfDYaSXIQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=zhejun_huang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0XEUszp5_1794304832;
Received: from localhost.localdomain(mailfrom:zhejun_huang@linux.alibaba.com fp:SMTPD_---0XEUszp5_1794304832 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 18:00:33 +0800
From: zhejun_huang@linux.alibaba.com
To: zhejun_huang@linux.alibaba.com
Cc: stable@vger.kernel.org
Subject: [PATCH] dmaengine: Free channel ID after device_unregister()
Date: Tue, 10 Nov 2026 18:00:27 +0800
Message-ID: <20261110100027.96779-1-zhejun_huang@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
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

From: Zhejun Huang <zhejun_huang@linux.alibaba.com>

__dma_async_device_channel_unregister() frees the channel ID before calling
device_unregister(). Between ida_free() and device_del() a concurrent
__dma_async_device_channel_register() on the same device can reallocate the
ID and try to register a device with the same name while the old one is
still present, failing with -EEXIST.

This is reachable in practice: idxd calls these functions from its
per-workqueue probe and remove callbacks, which are only serialized by a
per-wq mutex. Enabling one wq while another is being removed therefore
runs them concurrently on the same dma_device.

Move ida_free() after device_unregister() so that device_del() removes the
name before the ID becomes reusable.

Fixes: 0821009445a8 ("dmaengine: fix channel index enumeration")
Cc: <stable@vger.kernel.org> # 5.7+
Signed-off-by: Zhejun Huang <zhejun_huang@linux.alibaba.com>
---
 drivers/dma/dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 34be53487a21..2642abf105d7 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1171,8 +1171,8 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
 	device->chancnt--;
 	chan->chan_dev->chan = NULL;
 	mutex_unlock(&dma_list_mutex);
-	ida_free(&device->chan_ida, chan->chan_id);
 	device_unregister(dmaengine_chan_dev(chan));
+	ida_free(&device->chan_ida, chan->chan_id);
 	free_percpu(chan->local);
 }
 
-- 
2.50.1 (Apple Git-155)

