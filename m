Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810319;
	b=yn6OGJ16K0XzziKZQegGo3nz4NsuNeNsF1WRijrPFlZIQGqbZ5cKLYpcpWkMLkBxfB8T
	 zilTcO45LW4peKuigHVwzxRI7IBsQ6fTKFU6IwbAXxXRADRbCatHLC+0zOBoCU7Ra75Hi
	 P2Epb39pfAMB0C7PI1v8jIZA78+OSDAegk0JYtjZOTjEXW2KVjjPvK+Cz2j0t9NHYMD9t
	 VFVQdhqd4XCNvB7vYLjt9sKjfrodxlxkTeHDUM/fpuqi9a6gXZ+WH/yzHm6hmGrTd9te1
	 w1BtIAMSZIlhAiV8tGaY0fL0QFGDcAyg8VieDE1UarLouoqHJE4tySKBY6Xn2DqJRzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810319;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TGdaHVzy/TUk/mIBc2ElvcqkeMlmv5/KahQqahLiwJs=;
	b=AbVbrFzIVoBa5tvmNShMWn9175qa/+uA1jkMlAtE/mZ51yE0kI0565HOHqUN6GtOeYpZ
	 idYHznNmjw980WxQGKNG1F5KvCxV3LT5EeHnZTnm4gPhJ0OrQrsXjs4Pw3cZDdBFgXPoL
	 srz2xlHV1eFxbhckj+nSwE6SManpR5feKYv2MCUCBjXaUznXJ1cyNXF3jeXysH6qyOMnC
	 0OHjh3iI/QbcVQ3z7pm4l6ov+j4ta6jSmMwBvC6NaIuOnwcBNXlisYhkc4hZ9Xp/J3PqP
	 I8z2h46/91hnLImOyCwJmkirZy/3weortvRE2uXQwh04uK+MG+VxVJIUh4XY1/pGDQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=no4FcMFw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F0E606A31C;
	Fri, 27 Nov 2026 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=no4FcMFw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8669C1F000C1;
	Fri, 27 Nov 2026 20:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795810318;
	bh=TGdaHVzy/TUk/mIBc2ElvcqkeMlmv5/KahQqahLiwJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=no4FcMFwJ3XaH7YHgu8/4rby4BpZeLRm/4WPmcCCGuITCOEnnrNo6V8I/9mE27eyb
	 +r8zB83Ex3nlZ4qVXPHPRycs8J4uwLgNIQ6dTPmCukrOivH5nsPDxPmKZmnDKif8V1
	 kpFINygNNBT3GMiEv2QVYkV3mPlXV5mHKUOfCV114PLNgfAYDZZ9YLuOQddA+clhPM
	 43jDw4kdv/+7wLuAXwl0oqAcgwjGzeFpz/q4S7FZ5U6uF+a9pnLPQbNdrnJYQ5SPgs
	 rn7YVSeJZzAFG8n9Hhdts05LTjFLtjlWrYjVuzUU5KxKfJX4tYiHYs3cyYNFFliZRp
	 4ZWk/2A4aYB9w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jens Reidel <adrian@mainlining.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 09/10] Input: goodix_berlin_i2c - check i2c_get_match_data() for NULL
Date: Fri, 27 Nov 2026 20:10:03 +0000
Message-ID: <20261127201050.3532488-10-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127201050.3532488-1-lee@kernel.org>
References: <20261127201050.3532488-1-lee@kernel.org>
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

goodix_berlin_i2c_probe() passes the pointer returned by
i2c_get_match_data() straight to goodix_berlin_probe(), which
unconditionally dereferences ic_data.  If the driver is bound via sysfs
new_device without matching OF or I2C match data, i2c_get_match_data()
returns NULL and causes a NULL pointer dereference.

Return -EINVAL when i2c_get_match_data() returns NULL.

Fixes: 4d395cb071a3 ("Input: goodix_berlin - add support for Berlin-A series")
Closes: https://sashiko.dev/#/bug/linux-59243248-bebc-4f35-8608-d25e5ec38f26
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/touchscreen/goodix_berlin_i2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/goodix_berlin_i2c.c b/drivers/input/touchscreen/goodix_berlin_i2c.c
index 929090a094bf..7c85415ea409 100644
--- a/drivers/input/touchscreen/goodix_berlin_i2c.c
+++ b/drivers/input/touchscreen/goodix_berlin_i2c.c
@@ -36,6 +36,9 @@ static int goodix_berlin_i2c_probe(struct i2c_client *client)
 	struct regmap *regmap;
 	int error;
 
+	if (!ic_data)
+		return -EINVAL;
+
 	regmap = devm_regmap_init_i2c(client, &goodix_berlin_i2c_regmap_conf);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
-- 
2.56.1.839.g22a8290db9-goog

