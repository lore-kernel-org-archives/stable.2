Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D523403E5;
	Tue,  9 Jun 2026 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991286; cv=none; b=t5p490KgbzYee4QjPbb3vczYD11qqgI+4nDP94Gz4AND3PhUTl0BDGqyyF4CbgCWBmBapSfw3mY8JbyOhrJdKTaG6pQIeQ0/hg3mSst71WVLp+vrcgi7Ybwc2g/vCw3/a+QEgVLnkeBfd6viE0jlqequKCgSEiZrkq8kjzz3qHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991286; c=relaxed/simple;
	bh=/o1SYOIQeWiDGm8oxZkRrSnENORAyIM+gTugl8z996Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=utsuBZlH11aiCHT5/lGOj5LI21E0b7jWN3uqUAbghs9rGkrfvh6zV+5fJkkMjEOaf7WUqvUXD3qMYFO1VEVBrhZuoI++Uqy6PVsmDbX3yZhTaHCOuxX4u874bODvqL1Nhg0MkRGu02SyZ7Sy/rpKUWy0II9nc2vyx2gT7M/XPxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAntQgpxSdqVK7NEg--.12531S2;
	Tue, 09 Jun 2026 15:47:53 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: rmody@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] bnx2: fix refcount leak in bnx2_change_ring_size()
Date: Tue,  9 Jun 2026 07:47:46 +0000
Message-Id: <20260609074746.206312-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAntQgpxSdqVK7NEg--.12531S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1DCF4fGr47XF47KF4DJwb_yoW8Gw4rpw
	4ayr98ArykXr1akayxAa18Zr15Ca1ft3s8Wr4xt3yruws8AF1UAF1vga47WF1kArZ7urnI
	vr12vrnxCFyDZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU8nNVPUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkNA2onpjNyLgADsH

The error path in bnx2_change_ring_size() when reopening the
device fails does not balance the intr_sem semaphore.
bnx2_netif_stop(true) increments the semaphore at the start of the
function if the netif is running. On success, bnx2_netif_start(true)
decrements it. However, when bnx2_alloc_mem(), bnx2_request_irq(),
or bnx2_init_nic() fail, the error handling calls bnx2_napi_enable()
and dev_close() without performing the corresponding decrement. This
leaves the semaphore permanently imbalanced, eventually causing
stall or deadlock on subsequent internal synchronization.

Fix this by calling bnx2_netif_start(true) in the error path to
properly release the semaphore count.

Cc: stable@vger.kernel.org
Fixes: 6fefb65e78f0 ("bnx2: Close device if MTU change or ring size change fails.")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/broadcom/bnx2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index f5722e929833..7f8ade29b7e5 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -7360,6 +7360,7 @@ bnx2_change_ring_size(struct bnx2 *bp, u32 rx, u32 tx, bool reset_irq)
 		if (rc) {
 			bnx2_napi_enable(bp);
 			dev_close(bp->dev);
+			atomic_dec(&bp->intr_sem);
 			return rc;
 		}
 #ifdef BCM_CNIC
-- 
2.34.1

