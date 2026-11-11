Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410765;
	b=xlIwQn/eyLyZ3k6AM4XCaitCZ5twiBsQynJJe0B8jE8HDKZF28iiA2h9Roo7Zg3HB9th
	 wki50Uc8ElozssD7vIGaRIfoTFW6T/XmSKO0aEWdyAQ/ZatOBuTtY+WYW+V15NN1mnO77
	 Gb5u8gwuQ3kk2r7Lv/LipawhtjLd3JtAlbs/kh/6Y42H+OmEbNGkSr08aYEic+NIvFFap
	 yogn0NwBsi+o+bYLewTruSFSu5nOhsdeNLlDFjPwTv0iyoFbJJC5Y8Lm3hY0+x0lxzmZz
	 cMgjAsr8xmrL3LrOvXjDxo4mw2RkaQi1P0NNx4ZUogaJOUz9yUw2nFvn5fyBIOJHC4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410765;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jSVeMqql4Ls8KmsFpOKwEKjN3JuZfboH0MjOCd+mdVI=;
	b=F7PqSl/VXUIv1MPOq0yWHPf52xyQmMTIDuji9Sm20etESzMzGiMBiuJaI0bYeW9Ml8vd
	 MKBNyQ04Sdi/aI4Y/y6OYMmjt35g9jZTqoN2yVp8ltwlsLIw/EHj4E05QUN1vnVmPK1Jo
	 ATsuRC4uHEDJMzvo0SqlS6GqdmfqlPV2PNHqe4aQTuuibgSbfyppO69v9GsV1ujhMlO7X
	 C8tU6lNJ+5RTYyheOUd6xx8CjfXDnRtj6ZSP4R6AdKc9ValfKR39R4kutTD4yN6P+6m9U
	 8uTIi27mzPBa4GAhxahEzDST19omB3sy3LseJgUbgrB3+g3LBl+gI7C/By5wskFPSig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4G6UK9I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE85606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4G6UK9I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FF01F00A05;
	Wed, 11 Nov 2026 15:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794410764;
	bh=jSVeMqql4Ls8KmsFpOKwEKjN3JuZfboH0MjOCd+mdVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F4G6UK9I4pq+pGifFYQWgKmaBLvkrra2v02N4CyaduLzH3ioCSqap85/OkCn0EIa2
	 hD/qYLLo7+3dD8P5PQGNFHXSe6p1lKQGSgQU55oy5Sa0yCZogUrkQFsqoYIvEfFSv6
	 RmHMTPuW+U9PQvxw48l0t3GP9q22U0FfOZ+BLt7btwMJf31LN4haY+35pC93g5doW7
	 xuKONI6aLP2HQHtm3w+327cTD0egL/cUbrBq6MJ4J9hfjcvIYUtOJlaG20KoaTbvQE
	 yqE1vHhw+JLBiboAgj1eGyZ54pZ9VDc1i75LqixWPbApG0DyNG/nGO9a5C6Qbjv7iz
	 EVO6VbiEDdGlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Ambrozewicz <aambrozewicz@nvidia.com>,
	Kent Gibson <warthog618@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] gpiolib: cdev: don't set GPIOD_FLAG_IS_OUT
Date: Wed, 11 Nov 2026 10:26:02 -0500
Message-ID: <20261111152548.2664784-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053635-failed-6.6-974d2712cb15@kernel.org>
References: <20261107053635-failed-6.6-974d2712cb15@kernel.org>
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

From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>

[ Upstream commit 974d2712cb15014019595799b3ed68fef5fe9695 ]

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
[ sashal: adapted GPIOD_FLAG_IS_OUT access to FLAG_IS_OUT through flagsp instead of &flags ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index c6689f66a2d29..f8e8e418d05c2 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1417,11 +1417,6 @@ static void gpio_v2_line_config_flags_to_desc_flags(u64 flags,
 	assign_bit(FLAG_ACTIVE_LOW, flagsp,
 		   flags & GPIO_V2_LINE_FLAG_ACTIVE_LOW);
 
-	if (flags & GPIO_V2_LINE_FLAG_OUTPUT)
-		set_bit(FLAG_IS_OUT, flagsp);
-	else if (flags & GPIO_V2_LINE_FLAG_INPUT)
-		clear_bit(FLAG_IS_OUT, flagsp);
-
 	assign_bit(FLAG_EDGE_RISING, flagsp,
 		   flags & GPIO_V2_LINE_FLAG_EDGE_RISING);
 	assign_bit(FLAG_EDGE_FALLING, flagsp,
-- 
2.53.0

