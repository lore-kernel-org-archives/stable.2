Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050706;
	b=JM+y4DmH7qRmEsArRoMrBiyvm5Yz5J0zZYgPRtvQfJQPqa5990a5nuxFY0kJyFgBqT8i
	 OQDS79fAXwprpLQ7hK4r2TdT2zKX6mzeLZV8jVl5ajUYe+5xJ+3ce/NYKYA6nbWthhaHH
	 vnjnXT08FTSgHpfUDmpTC/V5rc3kdctYP/d42VnImQnx2NeiSeLJYYSGdlKHcA0ghyusU
	 UhDINDOuuBvYbq6ApukJqz7mJomqI3IRSH+3BENZii4EtUNqEmaLuTnZiw4Oo42dBKeE9
	 ROcuHih2KUsxZVMLjScOSOQ4W3mwj6QUHhyhcvjuNSxbkwWy+uqZXYXUq6YlR8R2/uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050706;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=O2YB7tmAA6TkKe5qzjDzoyUmZL6NBtS78AfymOQvj7I=;
	b=CeB5YM1iacO3gglSgCw+Dv+BS56HnqcpQ8f6CEdpBYrJoDI/wDQFrSdEALZHKxn4z7rH
	 TH05Mpj0TW13hjqOw1ISnvXhd9ATmC8Ujfk2igmru09YbQOlko41iGpoBDk5UkzsKx2mL
	 onqEeuvsJ602mGjkjsnzdsEZORcsbn4sa4G/SIGmrKSH/s7p89r0eXZxpodNjfNKdHxJ/
	 MP+nxFbGnFkygpZR9zqYDAYxGtmBk23qw71LYfP1No3/Lne97qlewt8xykdN77qnYhjYP
	 fYWDtvjoTT0sXcPN+NNV22Vypt3wMvXAMjlEAsgbtnMnWLeHcoUE0hsUKhCPHcd/hsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S7KJC2Hj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374CB606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S7KJC2Hj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B821F0089F;
	Sat,  7 Nov 2026 11:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050706;
	bh=O2YB7tmAA6TkKe5qzjDzoyUmZL6NBtS78AfymOQvj7I=;
	h=From:To:Cc:Subject:Date;
	b=S7KJC2Hjy7w9LDeeGZo8jgOXDVoKf+WoJTymYxSJjfX+Jadx21BuhBb6xTqCo1Fuq
	 97UUraNIvmICd8MSCfM4D8EkLa2CMEuTZsarB/6d182e4hBNRjV1hgcCn9nyUfUplI
	 pA83Tv2ajnmdDwMsPHFuRRgKeDAKb6NeAaQx9JDbs8lai1svMdV6xhhD3pMalmr/uD
	 BETq1o5QOzNH+orqn5DYAavn8ULsl78J9XAeTwVR2s+80XkI+h1nCkCnMMieXsVUVD
	 Css7O+4eXLJOy3HyBbcHbOBFlO8WJoIvOZ8uoL9DLBaWivZPR54POQ3DCOkuJX/ZL5
	 77oCfjXtop+yw==
From: Sasha Levin <sashal@kernel.org>
To: aambrozewicz@nvidia.com,
	warthog618@gmail.com,
	bartosz.golaszewski@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] gpiolib: cdev: don't set GPIOD_FLAG_IS_OUT" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:25:04 -0500
Message-ID: <20261107062504-failed-5.10-974d2712cb15@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 974d2712cb15014019595799b3ed68fef5fe9695
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062504-failed-5.10-974d2712cb15@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




