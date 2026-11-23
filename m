Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426714;
	b=CZBMNsAirjFh+L/x57D9bmgcAIBxEIVHXGuE/33f50e8e6gaafub8dnhtlLRvv9TuXri
	 dEKLeeWSKuXN3F+xMWiXiaSIJFZu7aY28vnTi3g6KY0pKpK2ARtTT17Lg68hOZVaAoEtk
	 Ti9550zvNZ2g6ug8ys538mUguDV2G/B0fWAJ9cOIfFB3ueA1ZQ17+9PIsg8UPxWTkXox9
	 7sBwXTpGyrratD8Mtok8Ar5GZ0pe/TJWQSdrsRHyqcBLkN43TLsepP1mAQVyu0KX2V8s/
	 8UFu+Gne3q1iDMdnD90MT3UAnTZKG+X7EsWW616d0ipso46ft+i+PAYEMZ3I2oC+KnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426714;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=lvpypAiJlblh4fELwTtTXu0MlEx5B97kH+hMlKAqU3U=;
	b=4VpQRM18377RicAlit9QfE44g0SwxvAqFBuaj0OdTFRnrs7GvikM1eP1/D9vuKsvOU0s
	 BJtLZr28UVlWgeLZ2NfePV8G3ZCzaMACYfDh7mD3dwEti4ldbY8n6d8CLQawI3foX38+j
	 clmkGmosuzyMtWrLfG6yHYZQDawvB4Tej3GVjCao12L3kotzcBdZelm2ymW6xR1FOE//e
	 M8TITpB+XIm1gOdsvOYD83RQ5vMXlhVGhlqLb/iGK/iYdKpoYIBUWjxbws0Z73eU7iIHc
	 sUr0l67xeJfHS5TL3YcHH072oQHKd+Wlyt57kAIUILqqgvNs/aP5HLYOOz8TnN23doQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C081C606A31F;
	Mon, 23 Nov 2026 09:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C081C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=lvpypAiJlblh4fELwTtTXu0MlEx5B97kH+
	hMlKAqU3U=; b=MrmDC5uVvUzrDaL5f4hSqdtYN67IdmZVArYX/PVdlS2fkN+aWl
	qehV0o/pCULE4EamNWvgsQk282X3wxuUfYF2BE9FNav1Qxv2YeDzRYQVHVTEtNQx
	xzp7Gr2NhuRljyYzkucLnrND+/qoaRj5TOJfN+BKTpe0oFjJ7+iQw7ZME=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.33])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkCmxfuCCQRr38IbAg--.672S2;
	Mon, 23 Nov 2026 17:38:12 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH net v4] can: dev: reject unusable bit-timing constants
Date: Mon, 23 Nov 2026 17:38:09 +0800
Message-Id: <20261123093809.5154-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123-loon-of-wondrous-aurora-cb3d93-mkl@pengutronix.de>
References: <20261123-loon-of-wondrous-aurora-cb3d93-mkl@pengutronix.de>
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
X-CM-TRANSID:BrQMCkCmxfuCCQRr38IbAg--.672S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtryUJr48KFy7ZF4kGrW3Jrb_yoWxJr1kpr
	s8Ar45Gr90qr12qayxtwn2yF95Ww4vqF4Fkr98Jwnay3sFqFW0yrW7GF45Z3W3GrnFkry8
	t3yjqF43Gws8CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUcw0eDUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUGD2sDBVituQAAss

can_bittiming_const_valid() is the hook register_candev() uses to verify
the constants a driver registers, but it only looks at sjw_max.  The
values can_calc_bittiming() and can_calc_pwm() depend on are not
checked.

gs_usb builds its struct can_bittiming_const and its clock frequency from
the response of the GS_USB_BREQ_BT_CONST control request, so both come
from the USB device.  A device that reports brp_inc = 0 crashes the
kernel with a division by zero as soon as a user with CAP_NET_ADMIN
configures a bitrate:

  Oops: divide error: 0000 [#1] SMP KASAN
  RIP: 0010:can_calc_bittiming+0x3dd/0xcd0
  Call Trace:
   can_get_bittiming (drivers/net/can/dev/bittiming.c:146)
   can_changelink (drivers/net/can/dev/netlink.c:594)
   rtnetlink_rcv_msg (net/core/rtnetlink.c:7137)

Controllers may read the bit timing constants via USB, check the
minimum/maximum values and avoid divide by zero in the calculation.

can_calc_bittiming() also divides by the clock frequency, gs_usb and ucan
take it from the device as well, so reject a zero frequency while the
device is registered.  CAN-FD data bit timing requires CAN-CC bit timing
and CAN XL data bit timing and the XL PWM constants go through the same
calculation, validate them as well.

The 32 bit overflow of tsegall * bt->bitrate is not caused by the
constants but by the bitrate supplied from user space, it is a separate
problem.

Reject unusable values during registration, so that a device or driver
handing out such values fails to probe instead of taking the kernel down
later.

Fixes: d58ac89d0d38 ("can: dev: register_candev(): ensure that bittiming const are valid")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v4: https://lore.kernel.org/all/20261123062614.7811-1-25031212351@stu.xidian.edu.cn/
- move the clock frequency check to register_candev(), CAN-FD data bit
  timing requires CAN-CC bit timing
- re-order the checks to the order of struct can_bittiming_const
- replace the comments with a short summary
- drop the brp_max * bit time limit, the multiplication is fixed separately
- use check_add_overflow() for the shortest PWM symbol
v3: https://lore.kernel.org/all/20261121094534.5221-1-25031212351@stu.xidian.edu.cn/
- validate the XL data bit-timing and the XL PWM constants, too
- reject a zero clock frequency at the point of use
- describe the checks as rejecting unusable values instead of
  predicting crashes
v2: https://lore.kernel.org/all/20261121064449.9706-1-25031212351@stu.xidian.edu.cn/
- reject constants with an inconsistent minimum/maximum range
- bound the maximum bit time and the brp_max * bit time product
---
 drivers/net/can/dev/dev.c | 66 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 769745e22a3c..9325406ff1a8 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
@@ -595,15 +596,54 @@ static int can_get_termination(struct net_device *ndev)
 	return 0;
 }
 
+/* Upper bound for the bit time in time quanta. The bit times of the
+ * currently supported CAN controllers are well below it, the limit keeps the
+ * time segment scan in can_calc_bittiming() bounded.
+ */
+#define CAN_MAX_BIT_TIME_TQ 1024
+
 static bool
 can_bittiming_const_valid(const struct can_bittiming_const *btc)
 {
-	if (!btc)
-		return true;
+	u64 bit_time;
+
+	/* Controllers may read the bit timing constants via USB, check the
+	 * minimum/maximum values and avoid divide by zero in the calculation.
+	 */
+	if (!btc->tseg1_min || btc->tseg1_min > btc->tseg1_max)
+		return false;
+
+	if (!btc->tseg2_min || btc->tseg2_min > btc->tseg2_max)
+		return false;
 
 	if (!btc->sjw_max)
 		return false;
 
+	if (!btc->brp_min || btc->brp_min > btc->brp_max || !btc->brp_inc)
+		return false;
+
+	bit_time = (u64)btc->tseg1_max + btc->tseg2_max + CAN_SYNC_SEG;
+	if (bit_time > CAN_MAX_BIT_TIME_TQ)
+		return false;
+
+	return true;
+}
+
+static bool
+can_pwm_const_valid(const struct can_pwm_const *pwm_const)
+{
+	u32 shortest_symbol;
+
+	if (pwm_const->pwms_min > pwm_const->pwms_max ||
+	    pwm_const->pwml_min > pwm_const->pwml_max ||
+	    pwm_const->pwmo_min > pwm_const->pwmo_max)
+		return false;
+
+	/* can_calc_pwm() divides by the shortest PWM symbol. */
+	if (check_add_overflow(pwm_const->pwms_min, pwm_const->pwml_min,
+			       &shortest_symbol) || !shortest_symbol)
+		return false;
+
 	return true;
 }
 
@@ -632,8 +672,26 @@ int register_candev(struct net_device *dev)
 	    (priv->bittiming_const || priv->fd.data_bittiming_const))
 		return -EINVAL;
 
-	if (!can_bittiming_const_valid(priv->bittiming_const) ||
-	    !can_bittiming_const_valid(priv->fd.data_bittiming_const))
+	/* Validate CAN clock and CAN-CC bittiming */
+	if (priv->bittiming_const &&
+	    (!priv->clock.freq ||
+	     !can_bittiming_const_valid(priv->bittiming_const)))
+		return -EINVAL;
+
+	/* For CAN-FD:
+	 * Ensure CAN-CC bittiming and validate CAN-FD bittiming
+	 */
+	if (priv->fd.data_bittiming_const &&
+	    (!priv->bittiming_const ||
+	     !can_bittiming_const_valid(priv->fd.data_bittiming_const)))
+		return -EINVAL;
+
+	/* For CAN XL: validate CAN XL bittiming and PWM constants */
+	if (priv->xl.data_bittiming_const &&
+	    !can_bittiming_const_valid(priv->xl.data_bittiming_const))
+		return -EINVAL;
+
+	if (priv->xl.pwm_const && !can_pwm_const_valid(priv->xl.pwm_const))
 		return -EINVAL;
 
 	if (!priv->termination_const) {
-- 
2.34.1

