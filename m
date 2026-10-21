Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586149;
	b=ErwcFGk2bPqPX4/GibK033g40IoWu8Dlmlk0g8hA+lHFuv9ElpXSI5BpEBfci2CWCdjt
	 wDKAwXMOxpZovRb/BYKTis8VQYwBmTrmYgofeOib21hpIBwXlHwJ/MulrC9Z/714uwr+S
	 Gb3dmg+6XSN8Te92RkBh88ZH/xbwnmom6wQZPSZMcSGYQRx56XkM50Wdw/gpbQ8qCdBdu
	 7IPqHwRJYv/PqjGD0zDsUaiubzG/bkz6DQ1T1IYDCr5b9Zb0LWGCcdMd/oRS/9kyNSGb8
	 VmRBQxw5KKihXH34S1BKand9pYJ4jhKVd+c5N76i7Emi0OxSxCp10/0SkFyUCG7O0QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586149;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AZELaNsqUY1zY8qX4VQB7ia07pe12nJCXrkSAQxmaMY=;
	b=LYDYtBBMD0+iozn1gMxp2WkYlT/Jg8N+KVvfxGKikTpdJVsOw0adbJ+AFSMqQziDWryM
	 fcsP5AcQHzC7IKJIRkn/DeJIjCMy495hEzkoFi5A9Bd4/7HcxwahPx2yAG7a0vAZlFLMk
	 vjUPLA+1U9WUr6Px48De+g3aDxW7/08ka8wl5H3yjn0REShYYMKCHND6alejAUdBMaNXX
	 egbY6KfYhKTbyj61Z27XoEI85yi5c7hWwLOXbHtxTi5odPFNc+Va+o0U729yajY6xOOIn
	 8cY27kO2QEmRwtZhk74rRx3ciOV8cFkPAFfokbzsy/BvfQ8W6LJr8C32rX3YC7Yccuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dvtk9Wam;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820D660A3827;
	Wed, 21 Oct 2026 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dvtk9Wam
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A3F1F000CE;
	Wed, 21 Oct 2026 12:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586149;
	bh=AZELaNsqUY1zY8qX4VQB7ia07pe12nJCXrkSAQxmaMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dvtk9Wamcb2cTkdAlw40Ol5yeVqjdeCmwOwNXevNAKkx33VxrBvNwmnOKfwOr9x0a
	 e0TomlBQ24MxQGL8PC871okmV9nqMsYY9Catlev66fyjAkaQnWc/0mModX6aiOKU56
	 8WLqiJds5jq9eRkn6G7qHivKzwTCwaR/Gz5PjFQNPWqWjESeR9Gg+HNjFRFAVxdQe2
	 Bl5XksYM4oWEz3Ow9un2Hpqv1x9+hjs38vFWOZQ+sOItKrOvnYf0V8ByJ8972zitpK
	 /GyDDscbDE1KrRuVkNxswmsX8MuZ9GgoHRPwMPrjrqT6rSqTIzrYwYeOVjlmshDSCT
	 IxTJIYvL6mbag==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Dan Murphy <dmurphy@ti.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 15/21] leds: lm3532: Validate LED string indices in lm3532_parse_node()
Date: Wed, 21 Oct 2026 12:32:24 +0000
Message-ID: <20261021123406.3163547-16-lee@kernel.org>
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

lm3532_parse_node() reads the led-sources property into led->led_strings
without bounding the individual string indices.  If a firmware node
specifies an index of LM3532_MAX_LED_STRINGS or greater,
lm3532_init_registers() shifts beyond the hardware output configuration
fields and, for values of 16 or greater, triggers a 32-bit
shift-out-of-bounds.

Reject LED string indices >= LM3532_MAX_LED_STRINGS with -EINVAL when
parsing the firmware node.

Fixes: bc1b8492c764 ("leds: lm3532: Introduce the lm3532 LED driver")
Closes: https://sashiko.dev/#/bug/linux-f6f7a3f6-4dc4-46b4-84e3-c26fc9099572
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/leds-lm3532.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/leds/leds-lm3532.c b/drivers/leds/leds-lm3532.c
index cfad4e791e4b..6fe752889487 100644
--- a/drivers/leds/leds-lm3532.c
+++ b/drivers/leds/leds-lm3532.c
@@ -649,6 +649,11 @@ static int lm3532_parse_node(struct lm3532_data *priv)
 			return ret;
 		}
 
+		for (int j = 0; j < led->num_leds; j++) {
+			if (led->led_strings[j] >= LM3532_MAX_LED_STRINGS)
+				return -EINVAL;
+		}
+
 		led->priv = priv;
 		led->led_dev.brightness_set_blocking = lm3532_brightness_set;
 
-- 
2.56.0.218.g1ec904b173-goog

