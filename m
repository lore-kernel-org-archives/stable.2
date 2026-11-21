Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795243515;
	b=o8MCj6Ga2FM0hl5gECWFDwKK9XiX9vAvN2GOVWe/PDRPOsAdfVceQLrw0RlKQCuy1wmC
	 TFyGc2bZ6L6zrw+yqC+dQrNne0+S1Gza5r92HDbVvCciPpNjA7XLOQg3mCTIJWW4f6i7C
	 UHwOGuyh4iNBeP8hW4C28lDqGVQPo7geY1NPB+5q7ofNaxdgYAtyXvhuQZpgG3J9ObmFU
	 nhJj+lBM4cgaSnMMaKsvWlE8TaCiPHN2Po8Va7p3Kl3+bV1D60pKeLQjZUnU1AlC6sSs3
	 pd9yY13GtwDy/cb6sAueSgWdr3s99ho1BlPSKiFEUBH9twSrG9QloJ5VNxgqXB+4hnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795243515;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=FbE77umev5juPy7Fs4gx65Zwxt75bhSJ44VTn9JcJ4Y=;
	b=twCzlpDxHGcXdHiN/hS2TAzwpGik86VweA7TswpF7pOW1EG9TqlcgOU0nwheT1aBnyXC
	 vUSK9ZNebg4Xw9mFRJu7pzC/rPaTEr9gv9hVe60SLBtuNpojxc0++LbrHa/cvi8mLE8m7
	 LWxfrMCTeYKNa0Fq97BoGN/44RiDwt4+DaT69XRnJTC1snhpWgE1mlrSDRNpoe59gkHxO
	 BbUwYCq7MBpWxPZWn1Y9XT6l+n6+JO9S+CLebvQwfviAdNinqvP4jA6oQo8SjM6/5NhL4
	 7w3Mi2xBLbHXKOEWdSpdNVAkj+Mg9IO90xKOFw/FoiOlsr3zRcVoJFnfPw9MGzdpaOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18214606A680;
	Sat, 21 Nov 2026 06:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18214606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=FbE77umev5
	juPy7Fs4gx65Zwxt75bhSJ44VTn9JcJ4Y=; b=Y4CIKsr3x7Cm9O6HIuAXbBOH5r
	u1dqMLZ1mFyfz7ROoDbId3LZO1aJdOw0A8xVXJUq1L/gcOVvbClp25ytDlbJMyWc
	KV1xZQsDAmTMcr8xG5ScAkGu3noDx6tWiKuc+N3dk5KzBo1CzY5YOHaaL78ziuR3
	f9vqCVuWHRJqoYThU=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkDGCP7hPQFrhz3+AQ--.18087S2;
	Sat, 21 Nov 2026 14:44:50 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH net] can: dev: reject unusable bit-timing constants
Date: Sat, 21 Nov 2026 14:44:49 +0800
Message-Id: <20261121064449.9706-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkDGCP7hPQFrhz3+AQ--.18087S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1fKw4rCrW3KF15KFyDWrg_yoW5Jw1kpF
	Z5JFyYkFyqyw4j9w48trs2y3yrG3ZaqryFkryYywnYkrn8Z3WFkrW5GF45ur43tr47AFy2
	vFWjg3yUWr45CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU00oGPUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUDD2sAZMkq1QACsw

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

Reject such constants during registration, so that a device or driver
handing out unusable values fails to probe instead of taking the kernel
down later.

Fixes: d58ac89d0d38 ("can: dev: register_candev(): ensure that bittiming const are valid")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/net/can/dev/dev.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 769745e22a3c..749da996331a 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -601,6 +601,20 @@ can_bittiming_const_valid(const struct can_bittiming_const *btc)
 	if (!btc)
 		return true;
 
+	/* can_calc_bittiming() rounds the bit-rate prescaler to a multiple of
+	 * brp_inc and divides priv->clock.freq by brp. A zero brp_inc divides
+	 * by zero directly, a zero brp_min lets brp become zero.
+	 */
+	if (!btc->brp_min || !btc->brp_inc)
+		return false;
+
+	/* The time segment loop counts down to tseg1_min + tseg2_min. If both
+	 * are zero the unsigned loop counter wraps around and the loop does
+	 * not terminate.
+	 */
+	if (!btc->tseg1_min || !btc->tseg2_min)
+		return false;
+
 	if (!btc->sjw_max)
 		return false;
 
-- 
2.34.1

