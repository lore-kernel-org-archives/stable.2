Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795569839;
	b=fBZQxMv//d5slDHLlBCFNup3rzcKPqb5bYSzdCA1FOlGQEtouzBuAz4oCtrY32M+er5n
	 b4T+GqsDSsYmuAfLUfMf8XIcRzB6ohFr5hmuYgItz6y9aVHlp6iTDTFuBn6bxVIyBthRJ
	 +YugdNS7DeAr1l5azdNxz9yG3vCUaDnPZgRViD48J6svPB4cIXNmP0EZ0KvBh41krlKi7
	 YqQwlVEZ0g3xNVltXapo5JeJQ/aPdyBAZ7gX9zBt5OSw83bWzxt9F0WzPbAML6uS3IOgX
	 fg/fvbyvgQa3VRp3ks0owQaM+V/n+B8r1WE91QjnKWm+q8YDelzwq2qpZSBgHzRR3lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795569839;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=d1QAiGAHhWT+sXznAZYe7m6A0ojC4Tbz1ncmAmz+vKE=;
	b=MGR3OpHzUKELFsnWCS7vFyZ/gF4zL0uUstw7JuPvsa2tIHLoATAmu7qJcjvDqPuOtimJ
	 y9higzmIqlqIM2Fj1lqph9kzfAUzsazF4jKMfJBusrM+JYWoW0G7GFw1qCSNgo5n82zAT
	 Vt2TlTXwysEDut1SidfLFTnl7JYA8Cml9s+qR8Bn/t3RJYtIwdSBHrXU8cJcKn9P5seaj
	 ZpFGokdEQqQuTUyz+XLLyKW8TwlV3a5YP/m3c1tQBBxMGCGhg6DFFmUEhmgN0LwvcUK6t
	 OwUSgAZsszqzRqywCdjhwq6QmK47qQkfZgKTSq07KKBa1uDjTPq4RT/pXghgw1g89Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23899606A31E;
	Wed, 25 Nov 2026 01:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23899606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=d1QAiGAHhWT+sXznAZYe7m6A0ojC4Tbz1n
	cmAmz+vKE=; b=vkSutyYhF9s7YPMoqfTYw5+u+nVE1aXgYxGkqBGPLpX+b0CNLn
	7th/5biaal9ByEBX+ewmX3Zg0ZI6VPw495eC8QeBxwngiHzi/MDJGLk7SXVIgqXl
	j9yVz/Bw61o53UfvQWjG2wlZHEAVevcBJ0uuYsosRy8d7dljxjbpZBRpk=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkA2PP+VOAZrp30uAg--.48700S2;
	Wed, 25 Nov 2026 09:23:33 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH net v5] can: dev: reject unusable bit-timing constants
Date: Wed, 25 Nov 2026 09:23:32 +0800
Message-Id: <20261125012332.6945-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkA2PP+VOAZrp30uAg--.48700S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtryUJr48KF4kZry5GFW5GFg_yoW3Jr15pr
	4DJr45Kr90qr42qayxtwn7AF95WwnYqF4Ykr98Xwnay39rXFW0yrW7GF45Z3W3GrnrCry8
	t3yjqF47Wws8CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYx
	BIdaVFxhVjvjDU0xZFpf9x07bYCJdUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUHD2sFqFk9XAABsz

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

Also limit the bit time to CAN_MAX_BIT_TIME_TQ.  The loop in
can_calc_bittiming() walks all time segment candidates from the maxima
down to the minima; with a bit time near U32_MAX its bounds wrap around
and the loop does not terminate while RTNL is held.  The bit times of
the currently supported controllers stay well below the limit.

can_calc_bittiming() also divides by the clock frequency, gs_usb and ucan
take it from the device as well, so reject a zero frequency while the
device is registered.  The data bit timing builds on the nominal bit
timing: CAN-FD requires CAN-CC, CAN XL requires CAN-FD, and the XL PWM
constants require CAN XL, validate the constants along the chain.

The 32 bit overflows of the prescaler and of tsegall * bt->bitrate are
not caused by the constants and are fixed separately.

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
v5: https://lore.kernel.org/all/20261123093809.5154-1-25031212351@stu.xidian.edu.cn/
- describe the bit time limit and the non-terminating loop it prevents
- CAN XL bittiming requires CAN-FD bittiming, the XL PWM constants
  require CAN XL bittiming
- the AI review of v4 found a divide error with a large brp_max, the
  0 % 0 in can_calc_pwm() and the tsegall * bt->bitrate overflow.  The
  brp_max * bit time limit stays out as requested in
  https://lore.kernel.org/all/20261123-loon-of-wondrous-aurora-cb3d93-mkl@pengutronix.de/
  (a separate fix moves that multiplication to 64 bits); the other two
  are pre-existing and do not depend on the constants.
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
 drivers/net/can/dev/dev.c | 74 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 769745e22a3c..01d74321f330 100644
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
 
@@ -632,8 +672,34 @@ int register_candev(struct net_device *dev)
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
+	/* For CAN XL:
+	 * Ensure CAN-FD bittiming and validate CAN XL bittiming
+	 */
+	if (priv->xl.data_bittiming_const &&
+	    (!priv->fd.data_bittiming_const ||
+	     !can_bittiming_const_valid(priv->xl.data_bittiming_const)))
+		return -EINVAL;
+
+	/* For CAN XL PWM:
+	 * Ensure CAN XL bittiming and validate CAN XL PWM constants
+	 */
+	if (priv->xl.pwm_const &&
+	    (!priv->xl.data_bittiming_const ||
+	     !can_pwm_const_valid(priv->xl.pwm_const)))
 		return -EINVAL;
 
 	if (!priv->termination_const) {
-- 
2.34.1

