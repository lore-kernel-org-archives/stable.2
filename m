Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62C176026;
	Tue, 18 Aug 2026 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787035212; cv=none; b=GtOwRgS1WX3xKGgerHmNkvoYg3vPqQ9xHgiRVq1rUbplGJNTM+jv8xXVzVwCngB1x/nvTKDRbsAmsZYIeVsdWGIr3dLvu1Q7N/kCv0XwnnXgsA8b8pEmiXDL1gKclOfTsknXYvE/pnn+srwsWW6AdIVlSlK6wZ79jmFFV2SqfvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787035212; c=relaxed/simple;
	bh=OaAR/3tnIIqHDn4LW0gta2OryXk9M+Y0mBqwD8TRKlc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q9VZFpL27kDvBK4Nkk8J0qCD8A66ZDYo2gQ/AF+0cZIuvxghV97oG4OgTV+s3sizarL8XOJzfxPFZ33zMzOtPwjkT57+wTywphZbZh5fBLdOgKW+LD5R0d+Q2wdMZlJ266rSqH8aiJX/S1St2ChP9CeHzPV6LVcH8wIJJy2CM9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDnOGQ7_oNqgZGiAA--.26236S3;
	Tue, 18 Aug 2026 14:39:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgAXY8c1_oNqZ0L4Aw--.23563S2;
	Tue, 18 Aug 2026 14:39:55 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] can: kvaser_pciefd: fix use-after-free in bec poll timer
Date: Tue, 18 Aug 2026 06:38:32 +0000
Message-Id: <20260818063832.383829-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgAXY8c1_oNqZ0L4Aw--.23563S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?rJhsWwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI0osi4h2mLwQPBhTJ8YXMPOr9JId3qYK5paZlKljE4n/w+A
	61bmZQQFyu0z6rowZYLN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww15tF4DJw1kWw1UKrWkXwc_yoW8AF4kpr
	s8KF47Aryvvr4Y9w17uF4kZFyUZw13Crs7u34xt3y5uF4Svr1UJFyY9ay3WFWakr4vvFy3
	ZF4UZwn8Ar98ArgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
	JbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

The bec poll timer is rearmed from the interrupt handler, so the
timer_delete() call in kvaser_pciefd_remove() neither waits for a
callback that is already running nor stops the handler from rearming
the timer until the interrupt is freed later in the same function.
The timer can therefore still be pending or running when free_candev()
frees the CAN device, causing a use-after-free in
kvaser_pciefd_bec_poll_timer().

Use timer_shutdown_sync() instead, which waits for a running callback
and makes a later rearm a no-op.  Also drain the timer in
kvaser_pciefd_teardown_can_ctrls(), which frees the CAN devices on the
probe error paths.

This issue was found by an in-house static analysis tool.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c | 1 +1 +
 1 file changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
index d8c9bfb20..a0597db72 100644
@@ -1739,6 +1739,7 @@
 			iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 			kvaser_pciefd_pwm_stop(can);
 			kvaser_pciefd_devlink_port_unregister(can);
+			timer_shutdown_sync(&can->bec_poll_timer);
 			free_candev(can->can.dev);
 		}
 	}
@@ -1879,7 +1880,7 @@
 		struct kvaser_pciefd_can *can = pcie->can[i];
 
 		unregister_candev(can->can.dev);
-		timer_delete(&can->bec_poll_timer);
+		timer_shutdown_sync(&can->bec_poll_timer);
 		kvaser_pciefd_pwm_stop(can);
 		kvaser_pciefd_devlink_port_unregister(can);
 	}

