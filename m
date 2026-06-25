Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA7F3E7141;
	Thu, 25 Jun 2026 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399869; cv=none; b=lTtmokfQreaNZoA9B/xfxDO2WCILJgOpAVHLwPHgn34lzCo7VKRWgU5g+cB+Al+iIeCN8qMhfZtH2xLb7nh3kLq4MdfXNzeoxIJDfauMXrmVQPx3rNDd22lZh0oF+7XbUZIeDYW1HQ4ewYXadaY/akbL+hExc4GjNYxcD03EM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399869; c=relaxed/simple;
	bh=54BcscrR6WoZrpNk1CB2ki4w/Xh/hTfnbttLdNL5aKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=I4MPtEi/iOhTSpuLjVLCRSWARRByqqmLP5erLEsIE483/xAiMLyjWt4eEvd/q1ZyHkIeHDHVk2PwDvaF1l9TvHyrEm+NU366pq+EVvnw4Y702iOyG2YFea0V64Mzl02L4ACk2XoSYh9SQmGlo8XkANcg+314VTuRoEO7Msq7Pa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-03 (Coremail) with SMTP id rQCowAA3HONzQz1qPAvUFQ--.9833S2;
	Thu, 25 Jun 2026 23:04:21 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	axboe@kernel.dk
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drbd: Fix double put_ldev in receive_SyncParam on fifo_alloc failure
Date: Thu, 25 Jun 2026 23:04:17 +0800
Message-Id: <20260625150417.69968-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3HONzQz1qPAvUFQ--.9833S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4xJF48WFW8Gr4xWF1DAwb_yoW8XF1fpa
	9FgF42yrykGF45tws8Za90gF4jyan2yFyrCr18Z3sF9ry3Xw43ZayrWayUX3WxKrZ7Xa1j
	qr1DCFWxCF18uaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgoJA2o9JdJK-wABsS

In receive_SyncParam(), when the fifo_alloc() call for the resync
plan buffer fails, the error path executes put_ldev(device) at line
3790 and then jumps to the disconnect label. The disconnect label
also calls put_ldev(device) when new_disk_conf is non-NULL, which
is always the case by this point (get_ldev succeeded and
new_disk_conf was allocated).

This results in a double put_ldev, causing the ldev reference count
to underflow. All other goto disconnect sites in the same function
correctly rely solely on the disconnect label to perform the single
put_ldev — the fifo_alloc failure path was the only one to
prematurely release the reference.

Remove the spurious put_ldev(device) call before goto disconnect
to fix the double put.

Cc: stable@vger.kernel.org
Fixes: b30ab7913b0a ("drbd: Rename "mdev" to "device"")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/block/drbd/drbd_receiver.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 58b95bf4bdca..f618d03fd2a6 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3787,7 +3787,6 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
 				new_plan = fifo_alloc(fifo_size);
 				if (!new_plan) {
 					drbd_err(device, "kmalloc of fifo_buffer failed");
-					put_ldev(device);
 					goto disconnect;
 				}
 			}
-- 
2.39.5 (Apple Git-154)

