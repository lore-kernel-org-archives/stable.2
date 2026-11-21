Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254352;
	b=XKwF3kDa1YuyoxT1vmzHvgX2Qw6/jCfxZMOuRtf1JfgufWY7RLkDUsZFj4baUaoyvSIi
	 kAkPpnMLaRGJgk7fJwyzeNIwkayT5Kb3V/kgXwUkvijYMfVqLBQTUQpb9/iSqFQanpXsb
	 C/7WmE6LvqJeUSvFyLC4oa+nsevKFub+H+HzSAa66NaRIHwc7K5YY5/cdwu/T2uKh1QLQ
	 nnbtIfnaneiISJJ/+uP54RmUxt1UfslDHlBUkYXJeWRMvcwRdoDwCek/LGxz6IJBVz0iI
	 O44pHImPTASbe/rsF/3ruI2BC54eOyOr6Nl+ibPXjZAViDukFbuKSc+lFe+V+VetklA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254352;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=CHj6ANP9LzC53BHT4QiDAxfHHlrC+wp5JFq9rYP4O7c=;
	b=3R+yevYGPw7uS0RPVBcQwq0lyZm66+CPKGhtZ7ABh9EinyPUlD5pbJojuz+6gaMraK92
	 AbpDh4G6F/yPjFK4kjErGbniKpY6Whp3xDiBvNYhb9SK2baDdlakO5EoGJj7PBWxDLES4
	 rakawq7yI031I7FLDl+CdOIb/d0AwlBXmqcHmwbirffp5pJItbuPaKEtc4sIE/kH/NOWD
	 swWiXDUcV2ytOhus7J8DEyIgTFAVROsKux2BFpPnCiPzG/DXhQTj9qr/AJZM2F2VQG7Xj
	 CwlXvCfQ22PWKWqBGQboO/TUurL6WaNHnp/Td7sqtpMczrUfLwpAipJO7nj6QnMdX1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBD0606A325;
	Sat, 21 Nov 2026 09:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DBD0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=CHj6ANP9Lz
	C53BHT4QiDAxfHHlrC+wp5JFq9rYP4O7c=; b=ejbABg0AbfXNwxNkcWAChSAq5u
	OA5waN2STaDK4eLCG4FX/xqgxkgWhCNgliyotJ+ihm2EmZ4wJ0mNJgww4y/nD6mZ
	tX8gT2x02lcIcmcYdq4CpAIEPlW6cmFLdHgVz+0F1TGzz0TrRqrW1Otpa992qWfT
	4HqBjYWFofD0zGwyg=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkD2GwI_aAFr1F0AAg--.63532S2;
	Sat, 21 Nov 2026 17:45:35 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH net v2] can: dev: reject unusable bit-timing constants
Date: Sat, 21 Nov 2026 17:45:34 +0800
Message-Id: <20261121094534.5221-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkD2GwI_aAFr1F0AAg--.63532S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1fKw4rCrW3KF15KFyDWrg_yoWrZry7pF
	s3JF98Ka4qvw4jvw4ftwn7AayrG3ZaqrySkr97t3sakwn8X3WFkrWUGw45u3W7Gr47AFy2
	qFWqgr43Gw45C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8RbyJUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUED2sAZMnEuAAAs2

can_bittiming_const_valid() is the hook register_candev() uses to verify
the bit-timing constants a driver registers, but it only looks at
sjw_max.  The values can_calc_bittiming() actually depends on are not
checked.

gs_usb builds its struct can_bittiming_const from the response of the
GS_USB_BREQ_BT_CONST control request, so the constants come from the USB
device.  A device that reports brp_inc = 0 crashes the kernel with a
division by zero as soon as a user with CAP_NET_ADMIN configures a
bitrate:

  Oops: divide error: 0000 [#1] SMP KASAN
  RIP: 0010:can_calc_bittiming+0x3dd/0xcd0
  Call Trace:
   can_get_bittiming (drivers/net/can/dev/bittiming.c:146)
   can_changelink (drivers/net/can/dev/netlink.c:594)
   rtnetlink_rcv_msg (net/core/rtnetlink.c:7137)

brp_min and the time segment minima are just as fatal: with brp_min = 0
the prescaler can stay zero and is then used as a divisor in the same
loop, and with tseg1_min + tseg2_min = 0 the unsigned loop counter wraps
around instead of terminating.

The maxima need bounds as well.  can_calc_bittiming() doubles the sum of
the maxima for its loop bounds and walks the time segments from the
maxima down to the minima, and both it and can_fixup_bittiming()
multiply the prescaler by the bit time.  Values close to U32_MAX wrap
those computations around, which ends in a division by zero or in
billions of loop iterations with RTNL held.  Reject constants whose bit
time exceeds what CAN controllers use and whose prescaler range does not
fit into 32 bits.

The 32 bit overflow of tsegall * bt->bitrate is not caused by the
constants but by the bitrate supplied from user space, it is a separate
problem.

Reject unusable constants during registration, so that a device or driver
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
v2: https://lore.kernel.org/all/20261121064449.9706-1-25031212351@stu.xidian.edu.cn/
- reject constants with an inconsistent minimum/maximum range
- bound the maximum bit time and the brp_max * bit time product, so that
  large but non-zero constants cannot overflow the loop bounds or the
  prescaler arithmetic
---
 drivers/net/can/dev/dev.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 769745e22a3c..db541f935d10 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -595,15 +595,50 @@ static int can_get_termination(struct net_device *ndev)
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
+	 * brp_inc and divides priv->clock.freq by brp. A zero brp_inc divides
+	 * by zero directly, a zero brp_min lets brp become zero.
+	 */
+	if (!btc->brp_min || btc->brp_min > btc->brp_max || !btc->brp_inc)
+		return false;
+
+	/* The time segment loop counts down from the maxima to the minima.
+	 * Zero minima make the unsigned loop counter wrap around, a minimum
+	 * above its maximum makes the loop bounds inconsistent.
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
 	return true;
 }
 
-- 
2.34.1

