Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586162;
	b=FvpuhTRYIlmmKtYt2ayLGDtmU92Mk7xheXx1nghgig9Fu/hC+38pwyNecXsRh73QQ/61
	 iH0WY3A28NO12WiO0Z6XFmZFA++UQ0YbrFiQPgeeeAjw+cZuWeE6ljMV9kdSS0kJjBXx/
	 pC43xLEiFKbqI6UQQAJokLX7yfntBvVxMcwDGlQWGj6bF/uuXkm3IMellGttF2va5jkAq
	 cDETATZkPkFgg5hQDv2QyJn/6G4GiK/EhukyxGGt1qP8SS8nM7W/yXAAmp35VeJn5o8do
	 aRrt+pinX4eq/+HrFwrO1W0SVvRiCTkAyFYgDZcZvTOHNkMS+pSA1UL0NLJr0GLUDog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586162;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2K5S9w4cCwOySgftzPZG6nvIMBo591OI8YQ52/3vrBY=;
	b=LlL6anbK15fDdSqLb+cnnwPSX0MrEtKzdRF8jPye5G0zZ2MPTWVNVfLo52MUepSrSoOA
	 eGkoj3NnmMNtZyRBoIe337YvkmRrHahXVZkZXslZtqyvIcOsEMOA0HvFCdFDOT8KerSqy
	 7dC9yyhG8jiJ82403VARuuHJTQEGJ9S9qvnF9R1mLs8ybw8E8ByIQOg5badNShaxeA5jn
	 LDLRPMEx3SoyVkQDgAhv2NP7i1h6nyZ0erS8vSVnISAlS7qN34iMU/lW+je20tz1VldY+
	 d6gRtGkEQjbUO3bfclOtwbaDRIfOvQDQFbxYN73Q3AUiY1suxpsRBDz9Pge6PUtkYXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYHLEZDw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D69606ABC2;
	Wed, 21 Oct 2026 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYHLEZDw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461CF1F000C5;
	Wed, 21 Oct 2026 12:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586161;
	bh=2K5S9w4cCwOySgftzPZG6nvIMBo591OI8YQ52/3vrBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hYHLEZDwknHKGybSJuNG12vUA++6+EAYqo5SR2+whWXrpez4u0a5p5peMcBzA2Tj6
	 c8xjINYCvnQ4BCoboSd6cR9UPaDowH3LyNy8FxvlP6EGnx7Dyw32coG6LjCd1tHTZP
	 WsRMCJJDWxLhV3jCoK5csxqXMiF9ia38DIQlYXYBCvyln7X+XRU+ztTWCQWc3fvLsy
	 yFveVAu8t4L2BIJlNA3WbA8JQ1jNDAAHawL3vlaBp/4D7GvScTI/jvNzxzxmGKqEq0
	 qDY22MQ1QEeEIC59ICrtS//BEsbp1cuUj8djZVxKwMtp0TpbM21A7LHjQfe0RDfSvh
	 509zT0Af3wVcg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Bryan Wu <cooloney@gmail.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 17/21] leds: aat1290: Avoid leaking devres pinctrl handles on strobe source changes
Date: Wed, 21 Oct 2026 12:32:26 +0000
Message-ID: <20261021123406.3163547-18-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021123406.3163547-1-lee@kernel.org>
References: <20261021123406.3163547-1-lee@kernel.org>
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

aat1290_led_external_strobe_set() is a runtime V4L2 control callback
that calls devm_pinctrl_get_select() every time the strobe source is
switched.  Because devm_pinctrl_get() allocates a new devres entry and
takes an additional pinctrl reference on each call, repeated updates to
V4L2_CID_FLASH_STROBE_SOURCE leak memory and pinctrl references for the
lifetime of the device.

Use pinctrl_get_select() followed by pinctrl_put() instead, as the
device's underlying pinctrl instance is already held across the device
lifetime.

Fixes: ac69b9038f82 ("leds: aat1290: add support for V4L2 Flash sub-device")
Closes: https://sashiko.dev/#/bug/linux-e1e22682-0cb6-4dcc-9a7f-01993691f7b0
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/flash/leds-aat1290.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/flash/leds-aat1290.c b/drivers/leds/flash/leds-aat1290.c
index 223bbba9114f..fc7904966183 100644
--- a/drivers/leds/flash/leds-aat1290.c
+++ b/drivers/leds/flash/leds-aat1290.c
@@ -413,13 +413,15 @@ static int aat1290_led_external_strobe_set(struct v4l2_flash *v4l2_flash,
 	led->movie_mode = false;
 	led_cdev->brightness = 0;
 
-	pinctrl = devm_pinctrl_get_select(&led->pdev->dev,
-						enable ? "isp" : "host");
+	pinctrl = pinctrl_get_select(&led->pdev->dev,
+				     enable ? "isp" : "host");
 	if (IS_ERR(pinctrl)) {
 		dev_warn(&led->pdev->dev, "Unable to switch strobe source.\n");
 		return PTR_ERR(pinctrl);
 	}
 
+	pinctrl_put(pinctrl);
+
 	return 0;
 }
 
-- 
2.56.0.218.g1ec904b173-goog

