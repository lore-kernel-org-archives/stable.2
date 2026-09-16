Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58B04A92EE;
	Wed, 16 Sep 2026 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551369; cv=none; b=uyO5ScCE1Grm5cZOw12R7ahZ/1wMGocIhxgaHZ2XVYCfBIDXkDD0VDAVsRJhrL6tDb1GXOTo5pkEzOCUO/S7In4kcGkiVG0zPupW24lIg3Fm5WB+fhY0OBt/Qh+vRIDEoQy0wIHs7lODxUkS8oiryuQoChShMVTNtR/eM6JJhMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551369; c=relaxed/simple;
	bh=ueezB6h466N78udxdAAs3+YL41YsMPmJ91cXLkgiYls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NyORo7RNto3mvJEpiOkc/HbJwLIihiloaBPvz2UOJ2lxsd1zeOx7L87WJvO2l7Dn1xfhj6G5YIxRU2HMys35ylcQXW9eProCCJSetcFmdcqaT4PoXA/ReECKRO8d8hy8aXr7fGuohzMelSeEHMUwQl8hX67RAylTEE+6/wSUixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnqjj7YqpqpXTgBw--.42407S2;
	Wed, 16 Sep 2026 17:35:55 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: arm-scmi@vger.kernel.org
Cc: cristian.marussi@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	sudeep.holla@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: Fix msg use-after-free in virtio_mark_txdone()
Date: Wed, 16 Sep 2026 09:35:27 +0000
Message-Id: <20260916093527.2004594-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnqjj7YqpqpXTgBw--.42407S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF18CrW5CF4kJr4DKFW5GFg_yoW8AFy5pF
	4qga9xGw4UJF4xta48AF4kuFya9anYgr9xWry29aykCan8JF18XrWUAwn0gFyUArWxGa4j
	kF4ktrZrGF1DZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUOM
	KuUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQMA2qqP4eVTAAAsz

virtio_mark_txdone() can drop the last reference of a polled message
while msg->poll_lock is still held, returning the message to the
free-list where a concurrent sender can re-allocate it and race with
the unlock at the end of the critical section. Hold a spare reference
across the poll_lock critical section and drop it after the unlock.

Fixes: 5a3b7185c47c ("firmware: arm_scmi: Add atomic mode support to virtio transport")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/firmware/arm_scmi/transports/virtio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/firmware/arm_scmi/transports/virtio.c b/drivers/firmware/arm_scmi/transports/virtio.c
index 326c4a93e44b..4bbd9dd2de83 100644
--- a/drivers/firmware/arm_scmi/transports/virtio.c
+++ b/drivers/firmware/arm_scmi/transports/virtio.c
@@ -616,6 +616,14 @@ static void virtio_mark_txdone(struct scmi_chan_info *cinfo, int ret,
 		return;
 	}
 
+	/*
+	 * Hold a spare reference to msg so that it is not returned to the
+	 * free-list while it is still accessed under poll_lock: a message
+	 * sitting on the free-list can be re-allocated and re-initialized
+	 * without taking poll_lock.
+	 */
+	scmi_vio_msg_acquire(msg);
+
 	spin_lock_irqsave(&msg->poll_lock, flags);
 	/* Do not free timedout polled messages only if still inflight */
 	if (ret != -ETIMEDOUT || msg->poll_status == VIO_MSG_POLL_DONE)
@@ -624,6 +632,8 @@ static void virtio_mark_txdone(struct scmi_chan_info *cinfo, int ret,
 		msg->poll_status = VIO_MSG_POLL_TIMEOUT;
 	spin_unlock_irqrestore(&msg->poll_lock, flags);
 
+	scmi_vio_msg_release(vioch, msg);
+
 	scmi_vio_channel_release(vioch);
 }
 
-- 
2.34.1

