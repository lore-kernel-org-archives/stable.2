Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586137;
	b=dLvTK0blm8dLfauNdbO/1WTGueG1gHzX6OF4uB0jH/2yZyO2qMD3mmPEzoZEBAFQLtap
	 71Mxcln7kAPKvYXdCQNRAIp+lv8yjwNuBn20cd5JuwtE/0PQQLTByfTP66KK+SQqU++/l
	 Fy4pploXQm+xDO3q6/wxXiOUQcIV9SGKgmDaCKuMINaB2wSwTs2FywI74GPtPNgb9HTWT
	 MZ6oHBdL1IkdULhPJUU9+7q89Tj1TmUbXBxqlTjBvYAV/0UrZsnL5ad7n78avcPJEIvR7
	 B8LGJd0dKr0aFnORbja6aDh98HN4EgqXuClM8X2PBeBOlLyUv9po1HmSJI1frgcTaWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586137;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rFPU6DIac1ryfwQHStTCHYDynid1R1ubblMiuAUWKSc=;
	b=2i1cgwmM7x3dwu2jGdYs+hNEwctbIc5YlrgAcuPy/S5zAy6L654lHnH6+Gk5iwk5oTiw
	 HoZwdvFKc4mo5RBiTDa82Jrj/p2Or2lp+wI5wTTrctVo6dldLgw2W3CQ5w43KHtvorBpd
	 e71bLZI+fHnzT0XLBRxkY+L7EthvdAl4QLVW5CvZD0JmdhhckN3EITBDzh6J/5naklyWi
	 X2EKW7ezyLFGs65a3zyNVKcoryZ7PqVx1uOxCmgP8316JMRD/dh8rt6mtQv11Sq1T5004
	 Y+kcfZ90IF2CNBCtsGyoJJBDKlyEytMbSIL6lflOqV55grOkwb5FIcHst8tRmUHF7CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFRK4csR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15C4606A321;
	Wed, 21 Oct 2026 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFRK4csR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48BB1F000C7;
	Wed, 21 Oct 2026 12:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586136;
	bh=rFPU6DIac1ryfwQHStTCHYDynid1R1ubblMiuAUWKSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SFRK4csRHUuMNDzrY1mW2+YuymdscmtojJB4MpO/s3NL02/YmX0fO3EkllJjm2QyP
	 27PjdVPDcdrDPdVfwtSPksJvBIF2rnDUWjwTci21PqH4YEdlekCahsX7yE1rK2LSJr
	 sVG/DHEQEcjluTbE0WWIZl3ylq1gM+kp+E59TvQRi/iOflRl3ATaQpOXktD/nqACzO
	 z2dCK4qkXeLwj0U+TzgScZDItzvZ5u9ojdQHLQAGYZPY/0NxwE9ZjmyZPQhuZ+sdvY
	 jLheMI41Y17e215UZfZiSJe+UPZl/nb/1V/56sdekHEYbiwzBLN9yM9623F7JN4dFN
	 QTi56td6sA35Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Bryan Wu <cooloney@gmail.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 13/21] leds: aat1290: Prevent out-of-bounds read in aat1290_brightness_to_intensity()
Date: Wed, 21 Oct 2026 12:32:22 +0000
Message-ID: <20261021123406.3163547-14-lee@kernel.org>
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

When a flash strobe event or external strobe update resets
led_cdev->brightness to LED_OFF (0), a subsequent V4L2 torch intensity
query passes brightness == 0 to aat1290_brightness_to_intensity().
Subtracting 1 unconditionally indexes led->mm_current_scale[-1] out of
bounds.

Return 0 when brightness is LED_OFF before indexing mm_current_scale.

Fixes: ac69b9038f82 ("leds: aat1290: add support for V4L2 Flash sub-device")
Closes: https://sashiko.dev/#/bug/linux-9e7db3d9-0ea0-42f2-8027-01aa467d3a7d
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/flash/leds-aat1290.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/leds/flash/leds-aat1290.c b/drivers/leds/flash/leds-aat1290.c
index ea9af6c3fbf4..223bbba9114f 100644
--- a/drivers/leds/flash/leds-aat1290.c
+++ b/drivers/leds/flash/leds-aat1290.c
@@ -393,6 +393,9 @@ static s32 aat1290_brightness_to_intensity(struct v4l2_flash *v4l2_flash,
 	struct led_classdev_flash *fled_cdev = v4l2_flash->fled_cdev;
 	struct aat1290_led *led = fled_cdev_to_led(fled_cdev);
 
+	if (brightness == LED_OFF)
+		return 0;
+
 	return led->mm_current_scale[brightness - 1];
 }
 
-- 
2.56.0.218.g1ec904b173-goog

