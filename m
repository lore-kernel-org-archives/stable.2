Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415197;
	b=KJtU5g4/O/i4A27trLjDvZGu8exskqUJhaw9G6ANKmU914k/89G+nizCKi9kRNhgvLMm
	 Jbh05wIVaRr82mFztLm5uX6XHul6gu0AO0NhznnF5prLuN25r528gjgdpxKsdffeWBS44
	 rN2oVQWnJmsBD6mJcEJKONIGet1VM1inAvsLsydc2YxqyaWDT2MJmvlcT3qTxCF88Xuvr
	 smFg+GuVb9y6uXnJoNM1+Kpv0gHb4NrvjBUbvAdxhKqcy54zKMy+tOLgN1+4zHH12sy0j
	 9OYDwqQNLIHobiW2L7rmQ6MAXB5D6uWBiWk3+OuTKlzJZ954zep9e5S+OovYc1yiytA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415197;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=exnUoKpvpmJ2B/BUEzqP6hBJWWRaHpKYrl2DpcgiPBQ=;
	b=eDiNv0Fua2RIfcnS/7/WBTzeMj8d3Sw35LWCpY7+r/7xOmiHsPpv0UTbinZqGbjkAgyx
	 lw0ocoBvxjhaPjddYyxeAjZyGRqpc1xf0aKYO6dRVV0vY62+QtCD/ZOl4NKftZJiARmbh
	 E2TJTWYFbakqscOb0sIiOqxdqTGgatP1SnSgdLPCfbtzDF6lwiE3WOa8VEEoCT0qpiRXS
	 qZN1VhjMFBy3S5E58yCBbvOucoE90YKuIzG0FH2/v0j/ATkHUJUwq6ODAKNlwRIJk2SFp
	 NDqtw4L+nHHKR5NEjPqZBA1+lOMPPVcvgWgLkRiI5zoc523o3iqUpimCZo52E/AuHMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6C4606A31F;
	Mon, 23 Nov 2026 06:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE6C4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=exnUoKpvpm
	J2B/BUEzqP6hBJWWRaHpKYrl2DpcgiPBQ=; b=MGmUGL9HWrNtQxwfpdEfX+Ux+W
	Hzu/i6U9hyPjmmzZoK4UsCGFQskFPjEn5RM2VHKAjsYHABw2hIQusvDszxQnsPHw
	3S615AOXADx1bRLSOs+MDEdSJrIfnLC7W176m2QV6KNr4XnW1fLl49kMnFWzas35
	W2JKOhI8GMXw53azs=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkA2XAKG3ANriPwZAg--.25402S2;
	Mon, 23 Nov 2026 14:26:15 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH net v3] can: dev: reject unusable bit-timing constants
Date: Mon, 23 Nov 2026 14:26:14 +0800
Message-Id: <20261123062614.7811-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:BrQMCkA2XAKG3ANriPwZAg--.25402S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtryUJr48Kw45Jr1fArWkWFg_yoWxZrW8pr
	s5JFy5KFyqqr4Fvayxtwn7AFyrWwnIqFWS9ryDJ3sayws8X3WFyrW7GFWY93W3Grs7ZFy2
	q3909F4UGrs8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
	W8JbIYCTnIWIevJa73UjIFyTuYvjxUkwvKDUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUFD2sDBVgdigADsv

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

Reject constants that cannot describe a working controller:

- a zero brp_inc is used as a divisor, a zero brp_min lets the
  prescaler become zero, and a prescaler range with the minimum above
  the maximum has no valid value at all;

- a time segment is at least one time quantum wide, so a zero minimum
  does not describe working timing, and a zero sum of the minima makes
  the unsigned loop bounds of can_calc_bittiming() wrap around;

- the loop walks from the maxima down to the minima and the prescaler is
  multiplied by the bit time, so bound the bit time and the prescaler
  range to keep these computations inside 32 bits.  Unbounded values
  wrap around and end in a division by zero or in billions of loop
  iterations with RTNL held;

- apply the same checks to the XL data bit timing and to the XL PWM
  constants, whose shortest symbol is a divisor in can_calc_pwm().

can_calc_bittiming() also divides by the clock frequency, and gs_usb and
ucan take it from the device as well, so reject a zero frequency at the
point of use.

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
v3: https://lore.kernel.org/all/20261121094534.5221-1-25031212351@stu.xidian.edu.cn/
- validate the XL data bit-timing and the XL PWM constants, too
- reject a zero clock frequency at the point of use
- describe the checks as rejecting unusable values instead of
  predicting crashes
v2: https://lore.kernel.org/all/20261121064449.9706-1-25031212351@stu.xidian.edu.cn/
- reject constants with an inconsistent minimum/maximum range
- bound the maximum bit time and the brp_max * bit time product
---
 drivers/net/can/dev/calc_bittiming.c |  8 ++++
 drivers/net/can/dev/dev.c            | 63 +++++++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 42498e9d3f38..7cd64e1f4c8b 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -106,6 +106,14 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 	u64 v64;
 	int err;
 
+	/* gs_usb and ucan take the clock frequency from the device as well, a
+	 * zero frequency would divide by zero at the end of this function.
+	 */
+	if (!priv->clock.freq) {
+		NL_SET_ERR_MSG(extack, "CAN clock frequency is not set");
+		return -EINVAL;
+	}
+
 	if (bt->sample_point)
 		sample_point_reference = bt->sample_point;
 	else if (btc == priv->xl.data_bittiming_const &&
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 769745e22a3c..32b0e0c5a274 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -595,15 +595,74 @@ static int can_get_termination(struct net_device *ndev)
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
+	u64 bit_time;
+
 	if (!btc)
 		return true;
 
 	if (!btc->sjw_max)
 		return false;
 
+	/* can_calc_bittiming() rounds the bit-rate prescaler to a multiple of
+	 * brp_inc and divides priv->clock.freq by the result. A zero brp_inc
+	 * divides by zero directly, a zero brp_min lets the prescaler become
+	 * zero, and a prescaler range with the minimum above the maximum has
+	 * no valid value at all.
+	 */
+	if (!btc->brp_min || btc->brp_min > btc->brp_max || !btc->brp_inc)
+		return false;
+
+	/* A time segment is at least one time quantum wide, so a zero minimum
+	 * does not describe a working controller. A zero sum of the minima
+	 * would additionally make the unsigned loop bounds of
+	 * can_calc_bittiming() wrap around.
+	 */
+	if (!btc->tseg1_min || btc->tseg1_min > btc->tseg1_max)
+		return false;
+
+	if (!btc->tseg2_min || btc->tseg2_min > btc->tseg2_max)
+		return false;
+
+	bit_time = (u64)btc->tseg1_max + btc->tseg2_max + CAN_SYNC_SEG;
+	if (bit_time > CAN_MAX_BIT_TIME_TQ)
+		return false;
+
+	/* can_calc_bittiming() and can_fixup_bittiming() multiply the prescaler
+	 * by the bit time, keep the product inside 32 bits.
+	 */
+	if (bit_time * btc->brp_max > UINT_MAX)
+		return false;
+
+	return true;
+}
+
+static bool
+can_pwm_const_valid(const struct can_pwm_const *pwm_const)
+{
+	u64 shortest_symbol;
+
+	if (!pwm_const)
+		return true;
+
+	if (pwm_const->pwms_min > pwm_const->pwms_max ||
+	    pwm_const->pwml_min > pwm_const->pwml_max ||
+	    pwm_const->pwmo_min > pwm_const->pwmo_max)
+		return false;
+
+	/* can_calc_pwm() divides by the shortest PWM symbol. */
+	shortest_symbol = (u64)pwm_const->pwms_min + pwm_const->pwml_min;
+	if (!shortest_symbol || shortest_symbol > UINT_MAX)
+		return false;
+
 	return true;
 }
 
@@ -633,7 +692,9 @@ int register_candev(struct net_device *dev)
 		return -EINVAL;
 
 	if (!can_bittiming_const_valid(priv->bittiming_const) ||
-	    !can_bittiming_const_valid(priv->fd.data_bittiming_const))
+	    !can_bittiming_const_valid(priv->fd.data_bittiming_const) ||
+	    !can_bittiming_const_valid(priv->xl.data_bittiming_const) ||
+	    !can_pwm_const_valid(priv->xl.pwm_const))
 		return -EINVAL;
 
 	if (!priv->termination_const) {
-- 
2.34.1

