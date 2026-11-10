Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305558;
	b=up6aMEp07FXahSeptCGnJ1ce5ve8jKdcfaqgV0ad4a1fUk/uF8kIQEv14KfPXOfgVkzk
	 4jeLZpY0wg9OUvGfujP9Ymdr7iG59RYo9Wtch/uz2wWH+5fhMhkOx0t8EF6SWzgVDmqKH
	 F0Yd69VbKSKxZnVfuEzD7dZXT59B21YSJZQ1dbXNsssGMoDwSn8JG+gdvMOs8Lq4klyxV
	 OZkhFIeCfWWUMxCH0/t9W9EwRVgHFBOAndfhgdSjehYHpSy6X/XRcFkS7eu0Y5KNtR02O
	 swD6qQKzdtUgOlMrnF1i0x/ceky3P4bRayMVYm5007ZjEJbZ1UGl61+m+CDEgnxa4iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305558;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dPioBLrQavDl1oDERVdJfgiE5w3wxNV9+Q+s93Fp5bo=;
	b=kYQWhrtqGfndXo+9zdEuxPzZlR1AAHSHoXoyf1u65czeZxUaJj0ASK22KvSxZLSqU55w
	 /AU7qzMjmKbfyQdAnlL37PypVB4ltiy7byhSiZb6bsvODewcWjtfTdU/nU5UCe/fgHCK7
	 QA5XeEKXQD7OAR1isxPt1BUAcJh/3eZFUZJOnNq5v2tb/wFHo+liXYBAJZ7KQBihNHo8A
	 ypT9sj9hE/bE6BKnDf07lXXYpIFhzzpJ7nXNW1BpZ50CKSFzJMUF6PyowW1REgijcaFAG
	 R8hsOJ2jkzZ3W3IbGgySIjJBzozWM/jpNSZhrygtETq15lVVkQT+EN+86pMFwaVT/cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=L8VSgfeZ;
	arc=none smtp.remote-ip=115.124.30.133
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4118C606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4118C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=L8VSgfeZ
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794305548; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dPioBLrQavDl1oDERVdJfgiE5w3wxNV9+Q+s93Fp5bo=;
	b=L8VSgfeZ6Qqt9eF+Sk51fcOQIvIZzeOHA/kjrOgTqdqIQG9wxZDx7Le0BeUtRGda4MEh84fkIE2BZVqQ7s2oaoTfAjfj5EUx34twMM1g4NFOt75OZl2MNIub1uxNjPdUDNgghapA7g1PHs7t7AiYhHLYyDHN5ZigoWeQN0UnCm0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=zhejun_huang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0XEV0g9h_1794305547;
Received: from localhost.localdomain(mailfrom:zhejun_huang@linux.alibaba.com fp:SMTPD_---0XEV0g9h_1794305547 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 18:12:28 +0800
From: zhejun_huang@linux.alibaba.com
To: zhejun_huang@linux.alibaba.com
Cc: stable@vger.kernel.org
Subject: [PATCH] dmaengine: Free channel ID after device_unregister()
Date: Tue, 10 Nov 2026 18:12:17 +0800
Message-ID: <20261110101217.10118-1-zhejun_huang@linux.alibaba.com>
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
 

base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
-- 
2.50.1 (Apple Git-155)

