Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414316;
	b=WSVQZQPZojDge5GEZHgovcb8OrFq0sgsqy6wLNzjaAOvNM3bTyvuS8TaPEPbFK1Z9CLg
	 odDz635sXw+0TSo6Abm2qePP7wIYHFT63i56KH/6edpRZovVXi0bn+kSK8e7dYZ7BiXcN
	 rQ7gBwooOkOw8JlmCujjw4O3SC11inAj8NZ82HkGR2tLfze1uiYw5MuyP4Qtze6QMpqsy
	 +FDcW1njb9OyIrVYFIMm3D2U5EcSq02tIMCUfz8adbydl6qA3INXXK+sDIn0bkyKlpKgd
	 sxa0lLmPxbumm8XaOq0Q58/MG1aIJYeGTl1KbIQEjToRXutNXr7CU5tYJg/p9nVuODA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414316;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pP9d5RaHpOwO9UEvHqRdqR2ooLlMU0BpqVLisy58mZM=;
	b=kXdYoA1wRVWagbiSafnsZd3qnBoucNzviJH2Ee7FsM04CniRJ7rt/yTicC+1hns7YRZ4
	 wL0vfAGEUhFasPW8pQTxei3cUcag5ZHTEnB4WrejEEvd2X5lNHLs5+Y8cAnP5PUWE6jVQ
	 rpmN2q5T6XWYslUWqgCwW7sAPgbOSnyAQQVX+X0+CfWBck9r5A6Yfo2JgmDJ5MyZnq4B1
	 tkLUgnMADSVsF2+xNkYK8JrTZvmd+28Z7D/Ko5lZn6SLLXiWbohGLxHunH/qwoZ5HIVQc
	 F+kSaTXiL8sSO6iTenBBT2NbJv+L4cntOVqYeRDYAz4AgFW6g80ZOhq7vlBnTk/oXHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXpqASdR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612B0606A338
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXpqASdR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3F81F00A05;
	Wed, 11 Nov 2026 16:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414316;
	bh=pP9d5RaHpOwO9UEvHqRdqR2ooLlMU0BpqVLisy58mZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lXpqASdR7KlDiMaLyVnE6c67VUQn5FC3jIhMNYBf8WDzIpRnq6gS+KGD32fZAi45/
	 ya5h0eZihwdjMISAoMO/Qad00IUWM0bh3/iupIw3j1njnDm3m4qPOI8eXGWwK8vXEh
	 am8mzJmfCNrlILjOU4w/g0zcQ4dZCEzgAlxMM3p58+XkpIau8Bu9CrNE3uqh9j1yT1
	 k3hzz60y5ZWwmyiT1ALR0wQ3mWaZ3zBsZCSi4KjvX54kdHVVbjqm8YHe4R2FKJkAX3
	 Bdyy+rwwVVhTBEQTTH0GOSOcCzlrViZ30ihQcy381cZ6pjJ5vGFJN/X0vkIrxMo/FK
	 KR19soYT2kzZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Ambrozewicz <aambrozewicz@nvidia.com>,
	Kent Gibson <warthog618@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] gpiolib: cdev: don't set GPIOD_FLAG_IS_OUT
Date: Wed, 11 Nov 2026 11:25:14 -0500
Message-ID: <20261111162459.2716578-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060814-failed-5.15-974d2712cb15@kernel.org>
References: <20261107060814-failed-5.15-974d2712cb15@kernel.org>
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
[ sashal: Adapted flag handling to FLAG_* names and direct descriptor access through flagsp. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index b1e4571401c9a..8894206de3dca 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1054,11 +1054,6 @@ static void gpio_v2_line_config_flags_to_desc_flags(u64 flags,
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

