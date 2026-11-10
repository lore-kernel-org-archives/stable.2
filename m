Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305781;
	b=UwJGJhwa3TYD01nU0DuinbM2noWKjsx72+AeSTr4tX5brS8VYcZtEpEPLY1vHwhaMXOS
	 aY0JAIRBOIdErhcoLqpqDqGi48FHMl0DgCbzioYSCDpMLTjDy9JIW7hdsrMy/p5mAC2jc
	 E5ngGz2AhECtss5zoMZdImeSs16VQXMGHiJAJHCQ7wjZrC1/KBhCRWDdVZ4zzVE9QQw9D
	 pXMtLT2KkFAaUiUjB8KXEq1o6XQ26pB3wT5HxK3yN4Uokux3DSuOD4wCsIfJYKxfkqxha
	 B6OMmEpk2wJPq3cwckalrHz5tUZuvhwxHHn95eHEAPNOuM4TMnNePVr/U8SnjvdBw0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305781;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dPioBLrQavDl1oDERVdJfgiE5w3wxNV9+Q+s93Fp5bo=;
	b=XOsSAq/SlxWyB9QPrGe/LcApKKdS9WgHNsWD8TVxtGjtCDYErVaAMFjN1nZvLtg3et4W
	 LeD9WygL8DKv1u7aVQg0GJvIxWU4td46K4md68tcBVQsANXg+y7Y1Nfph2e0ZgWe8heK4
	 5gJUIYv//rbLjuzEeM3Uli/M12fM5jUqlL93BIj3S/yzktiWBwQ5ia4K1o6iJaf4W85yM
	 kNstnmmnStvw/3wLKSNrEVVhMTVHGq9znZjYuzV7Cs7IjR18NTIuzbVYPgOKPkchzuVNv
	 oFcBO7BIioQnlu1uiixVkP/bZzlcuPIBuutTxGu9VJUand3hyzDoJNEPfn29aoovd6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P0IfwGw6;
	arc=none smtp.remote-ip=115.124.30.133
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF00D606A336;
	Tue, 10 Nov 2026 10:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF00D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P0IfwGw6
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794305774; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dPioBLrQavDl1oDERVdJfgiE5w3wxNV9+Q+s93Fp5bo=;
	b=P0IfwGw6edmM73e3dc8MnUX7LyikwELDPfsmWrENtRPDTScZOOdqsArM484rKQYlz04v9R1it0wMBrs+e1ZW+Le410IEjvTLJvRime8Pzwdxgyy/WQOxJNTN4yqfPYWdD+phSkKGOLPM/PltdSs9ActL9x9RuEZarUPvMAxplsE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=zhejun_huang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0XEV0hO6_1794305773;
Received: from localhost.localdomain(mailfrom:zhejun_huang@linux.alibaba.com fp:SMTPD_---0XEV0hO6_1794305773 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 18:16:14 +0800
From: zhejun_huang@linux.alibaba.com
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhejun Huang <zhejun_huang@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: Free channel ID after device_unregister()
Date: Tue, 10 Nov 2026 18:16:07 +0800
Message-ID: <20261110101607.13784-1-zhejun_huang@linux.alibaba.com>
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

