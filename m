Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048668;
	b=w3llHG2RowhX941Y43iiem80QfEZcp39qQfHVn2N/4DM++LB0hJ+hwrA0lyImHS4kHID
	 hOs9qyqCk1yCJlYhqUcfTANMGm8Ra0m2TGb4lS3GvVJtHuGLG8+affFFrsMwmNm6dt4WR
	 onImUF2DWh55kzrHhV/AeZSyXJ/t5pGqz3HlH6GHdyg0cVQN9p4Q73mlRbGbHn5aWUXw6
	 uc4XkPN9wU9lsr+e/Lff70NOmK3b9bahgSGcHMiExE9+1tz1wOFBm+kV6nlmOw9CZfdZt
	 uiavRcPkS5TjY1FHgYDHZxKErhL9VDduKMFphHEKWd/UxyTz4rG0mwWikIi2E1r17zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048668;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=w4/kFR6L88+Z1IROyLaMXxTqukFBQZ+45b8kZUWQOf8=;
	b=2BKvAYhC6aiQRq6W2K/SRKQwKCvM8KSWXhIumLdkCrfqpR14pEocKOnChQtkK3SSYt5C
	 2VS63JRK4T+icFr/5zb9q2PlIHfyhk/gnyeK3s6GpJeEXSwsTjpsXHsamiNbziWUeJb85
	 VXAhnlDDxysRxxrHpfx1Vd6ni1Ysmd4HMvbzCBZdrC31u7Rd87R21Jvo0YrlIqyMmqNr1
	 +/DoXMJVZ2W3Jk9LtUkJIZmZK9kUe5qL8GJ5kF/ePGKoP8jaoFcTgIdXeWRjvN1NYvm21
	 Vb75hOSwPTS6aS/uXZoSwOaBb906VxQZyOrlNiXTASk/pQb9ICBSqnUf8CuWzUvLcxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hwctt1+z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46F7606A333
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hwctt1+z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E611F0089F;
	Sat,  7 Nov 2026 10:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048667;
	bh=w4/kFR6L88+Z1IROyLaMXxTqukFBQZ+45b8kZUWQOf8=;
	h=From:To:Cc:Subject:Date;
	b=Hwctt1+zj+oIupjEy+Y4kOzL4kHkXsp/XFwtqVL9jiRPiD2YL4w1C1E4g3s3+dit/
	 zZc3hW5xKmgx27zZizvR5DYSbSA11NY960lwthF29oiJQQhk7px9nE6WYiE4cQsMDD
	 tO5k5BmNEvCukfxEoQXeGf+WlOr5VwaxEWGb7EXQxUY7X0Y+5z73mQ752XBUtMepe2
	 xrQxYUqoREcZ6F5GXgMg/N+i7eempxY40FSm+BSQ2yTpyxyStBiDQ2rWJDT9rfQnfl
	 rCp+ojhPqRVvn8ZNmVI4RKS4P7LAg8aZBH3iQgJhvYfx6KWLHzP7NkR5eOnVaLwFDJ
	 9dN/lNtQq7LhA==
From: Sasha Levin <sashal@kernel.org>
To: aambrozewicz@nvidia.com,
	warthog618@gmail.com,
	bartosz.golaszewski@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] gpiolib: cdev: don't set GPIOD_FLAG_IS_OUT" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:51:05 -0500
Message-ID: <20261107055105-failed-6.1-974d2712cb15@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 974d2712cb15014019595799b3ed68fef5fe9695
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055105-failed-6.1-974d2712cb15@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




