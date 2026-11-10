Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304032;
	b=Bz/5qqfVhWRwgxk2DBaAZSeMMA46qwADp0OsVBxXVSpzo4n9XuY7DDBxGdVs5cqvJAd1
	 jbvllQbesWTdGfgVpIkBKa5xr4vgQIhtkwzRGCm0GESSnWUhcBpRoBvI+qVMXixy15N3Z
	 IGuU4asAiaCsfv5umaE3ewgWdrO5bEbYbtfjcNQ4TG6pEEpZc0ebLuaQ6V4Ij/8moN4pJ
	 hUHu7Gf+M0ypThzH88beKRWAbvOGPNqOuGT5i8Hp41AAyTQEs5x7xbiwJHqbl1ndSn2D8
	 soPJmKfsNLtpF9L1W1i//nXoOdSvRpYPZlg9Em9V63yWHN6gP7KT6AliPMGXN9ISFkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304032;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QkjN0wBsqjGO3H5qooYFf0kiOCvPO8XDbbU+IAEN6Ok=;
	b=tj7cuQam/R0umtUuM+V45Z+nOEhmPIlhUDA3AliR81IHRwike43mYQOX0eCxdJ/g+0iG
	 G+cDbIMnqn4Yw1zSwvwxIDEFtOdvfXxhpCme2Hm3YXD+gwulMiyA5sT3VYywNPTRI8Gxl
	 4VuZccaJqdE4x1BJEBxTtZe4wqH/5VqDIPHqgXAzzZaSKnlXAEiwwP+GymbzSaeICsKZC
	 K7NfINRvSnCQ1X9tW4PC8hM3URcGjU4OQR9kNrNiawgdFQ+umBEtrUx7pfVgT6vGb1VCj
	 zMoLdJIx1OHTyjF12ijtx/eyQb43r2WA0U3X6j8gTj2ikftTLzCl7+Or1HguePayrcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RsHrnomM;
	arc=none smtp.remote-ip=115.124.30.119
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A663D606A913
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A663D606A913
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RsHrnomM
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794304027; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QkjN0wBsqjGO3H5qooYFf0kiOCvPO8XDbbU+IAEN6Ok=;
	b=RsHrnomM5/8TQw7r/rwXfFNInQ+VrEdXKkkthoTJ3k3gC/14jjqxmfzZgZFzyglGUwOVZagJ4gr5crdgbOX+OmiqNGhF8ypp94hXJiIZQQlsuOvYtmCMQnqbNkPs12O6Gm24woBlSNryhcotgE6jA+UYS5yMehg3tEbqqq3E5jw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=zhejun_huang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0XEV.Q-R_1794304026;
Received: from localhost.localdomain(mailfrom:zhejun_huang@linux.alibaba.com fp:SMTPD_---0XEV.Q-R_1794304026 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 17:47:07 +0800
From: zhejun_huang@linux.alibaba.com
To: zhejun_huang@linux.alibaba.com
Cc: stable@vger.kernel.org
Subject: [PATCH] dmaengine: Free channel ID after device_unregister()
Date: Tue, 10 Nov 2026 17:47:00 +0800
Message-ID: <20261110094700.85340-1-zhejun_huang@linux.alibaba.com>
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

This is reachable in practice: idxd, the only in-tree user of the dynamic
channel API, calls these functions from its per-workqueue probe and remove
callbacks, which are only serialized by a per-wq mutex. Enabling one wq
while another is being removed therefore runs them concurrently on the
same dma_device.

Move ida_free() after device_unregister() so that device_del() removes the
name before the ID becomes reusable. This restores the ordering that
existed before the IDA was introduced, when the ID was freed from the
device release callback.

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

