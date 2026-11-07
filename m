Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049697;
	b=1OdL82FGdk64F+4UHRuaCNh/3NU9Pq6SH9foScA08LJF2i3XTe3Enx+VGTC2jii/kveQ
	 j2fPeR4qcwkhGWsrhab0wP3s5bFWyFlXSjo6fbSJ0OttizJcmBuLKBK7X4s8a0x/64NLx
	 k5uvQlJWlLNUMI0FYoc3MwU0qwZgVd3iou2ofesa3nP7pvPB7UWI8DzZCUNciPM5fxrg1
	 OAhMNe4cNIICohBbvcZsG9G1t0gC2UnlDy3XxBPjYY2vWtRj/p0tvfoJtkGx+pr/bKkzd
	 JnaqBfnZCj0y00CJWyE9XZMyD5jg20GlOtvRJ0DT2lGkil455vGz89SdF//AmA1BYiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049697;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AkvJrOruoRYUbkYLMrY9HFiHHaT0ez/PizjR/sXKPl8=;
	b=iHBmWxJalcWe32f3CeWj5W03+5AiErYQ3MGhVHIuzIETH7MJ4V1ahrZLQQVoZhzNam28
	 Hp/4zL8a6JbsDMSVkNVV0dFdt0B99okftDa147Ck2+W5xy0n70q+P5++XPa3q/MCUanI+
	 AdDUkQ7ZDhla1h0adyFmcdu0wUasyhGEJruVKeVr9kYIBFVr1V5KTHKAWOwmW3NDkjkUw
	 V+YEymuMH00ECGTdZdPSD07oSVq7LkWyBf2p7nbfSzEWkWUU29YFWF6sc+RAIpz1ijsqN
	 b3gMkHbA4zJOAwZMGqHZDpYdIv/le5ZRqpgEw9if7qzOfyG699ewG4J1BlkkJFUVsOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRXvdGym;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRXvdGym
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581791F0089F;
	Sat,  7 Nov 2026 11:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049696;
	bh=AkvJrOruoRYUbkYLMrY9HFiHHaT0ez/PizjR/sXKPl8=;
	h=From:To:Cc:Subject:Date;
	b=GRXvdGymyrmL5HfE5X+UzOpNSyQCVvkdl2HtVhh9zwigPGYKteH2gC5CXBHliQysa
	 eHocpMt3JBSpoRqAtjp0TKSndeOyTgNxAKY84EJOOm8QsKOOY94BiDS4Z1RpQnFbnD
	 95o8DV/GeBlrc/GNTd9BNDUlc06hhGsGNuoh/j/cWXnKXpO4N0fNy9KrmYsPcMZ36Q
	 P/qV7UpQJ9aYw6QFykTnD4cZbI/xOMgPRazbVhfv/kOBucEPN1llHctWEukpWQIrDQ
	 pLYhuBudB3p9R2oxOfL3trCCXbvP9TdWoIV4kNG3DB1ScZnBJ2FPMwpLIt2zKC5oZ1
	 b/HfHErmVh8BA==
From: Sasha Levin <sashal@kernel.org>
To: aambrozewicz@nvidia.com,
	warthog618@gmail.com,
	bartosz.golaszewski@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] gpiolib: cdev: don't set GPIOD_FLAG_IS_OUT" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:08:15 -0500
Message-ID: <20261107060814-failed-5.15-974d2712cb15@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 974d2712cb15014019595799b3ed68fef5fe9695
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060814-failed-5.15-974d2712cb15@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 974d2712cb15014019595799b3ed68fef5fe9695 Mon Sep 17 00:00:00 2001
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Date: Fri, 16 Oct 2026 12:22:58 +0300
Subject: [PATCH] gpiolib: cdev: don't set GPIOD_FLAG_IS_OUT

When a line is requested or reconfigured through the v2 uAPI,
gpio_v2_line_config_flags_to_desc_flags() copies the requested
configuration into the descriptor flags, GPIOD_FLAG_IS_OUT included,
before gpiod_direction_input_nonotify() or
gpiod_direction_output_nonotify() asks the driver for the direction.
If the driver refuses, for instance with -EOPNOTSUPP from
.direction_input() for a line that can only be an output, the ioctl
fails but the flag keeps the refused direction. gpiod_free_commit()
does not touch GPIOD_FLAG_IS_OUT, so this outlives the failed request,
and GPIO_V2_GET_LINEINFO_IOCTL reports the line as an input while the
hardware still drives it, until a request without direction flags
makes gpiod_request_commit() read the direction back from the driver:

  GPIO_V2_GET_LINE_IOCTL, line 0, input:         -EOPNOTSUPP
  GPIO_V2_GET_LINEINFO_IOCTL, line 0:            input
  GPIO_V2_GET_LINE_IOCTL, line 0, no direction:  ok
  GPIO_V2_GET_LINEINFO_IOCTL, line 0:            output

GPIO_V2_LINE_SET_CONFIG_IOCTL updates the flags in the same order.
There the line stays requested, and since commit 92ac7de3175e
("gpiolib: don't allow setting values on input lines")
GPIO_V2_LINE_SET_VALUES_IOCTL on it then fails with -EPERM, though the
line is still an output. A line whose driver refuses to make it an
output is likewise reported as one.

gpiod_direction_input_nonotify() and gpiod_direction_output_nonotify()
set or clear GPIOD_FLAG_IS_OUT themselves once the driver has accepted
the direction, emulated open drain and open source included, and
nothing between the copy and those calls reads the flag. Leave it to
them, as the v1 uAPI already does.

The other flags that the helper copies stay as they are. Active low,
drive and bias are what gpiod_direction_*() applies, drive and bias
possibly before the driver refuses the direction; edges and event
clock are the character device's own. None of them is read back from
the driver, so there is no earlier state that is more accurate to go
back to. A failed request releases the line, which clears them, and a
failed reconfiguration leaves the line, like the lines before it, with
what was applied up to the failure.

Reproduced under QEMU with a test GPIO chip whose line 0 refuses input
and line 1 refuses output: both refused requests and both refused
reconfigurations leave the line info with the refused direction, and
setting the value of the reconfigured output fails with -EPERM. With
this change the line info shows the direction of the hardware in all
four cases and setting the value works. First seen on real hardware
with v6.12.

Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Reviewed-by: Kent Gibson <warthog618@gmail.com>
Link: https://patch.msgid.link/20261016-gpiolib-cdev-direction-v2-1-aambrozewicz@nvidia.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-cdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 5d53bfcdf7268..f4d78113ade2c 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1229,11 +1229,6 @@ static void gpio_v2_line_config_flags_to_desc_flags(u64 lflags,
 	assign_bit(GPIOD_FLAG_ACTIVE_LOW, &flags,
 		   lflags & GPIO_V2_LINE_FLAG_ACTIVE_LOW);
 
-	if (lflags & GPIO_V2_LINE_FLAG_OUTPUT)
-		set_bit(GPIOD_FLAG_IS_OUT, &flags);
-	else if (lflags & GPIO_V2_LINE_FLAG_INPUT)
-		clear_bit(GPIOD_FLAG_IS_OUT, &flags);
-
 	assign_bit(GPIOD_FLAG_EDGE_RISING, &flags,
 		   lflags & GPIO_V2_LINE_FLAG_EDGE_RISING);
 	assign_bit(GPIOD_FLAG_EDGE_FALLING, &flags,
-- 
2.53.0




