Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586156;
	b=tbQDQ+63gDREDCNotfPln8YIE3CJOAXid5W5w8GAr4dQyOPBlJguYb6f6VG1dnjGNGR/
	 Q1ysMyANvK78dND/TD+9fIru43rZFZdC9TIaVF2eijOwLG+qhjX+g3cJus3nWVYVi9nz0
	 d0FBkzbw3K7GbiYH3jBCOIdMAnQCgUluMZ6iI9eLEqnVA6rT0IzIzMZEUzssPkkR1i12j
	 Jl4FWniowQ7b2Z0/2VOfwR+AZdqz6xM/gJpSqcvc4O9csblvwxFWSFHOR8fURr9/w0VLe
	 QSNgNDjgKGMl4xm8amN7qmrb4NoW/qxk90jsvJq2oVGPW8ezQe+MVoEWdqTRh2HYA/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586156;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QhyHOu089+UU44rYgvZ+971lrIFZgmG/SKe33HQUXJU=;
	b=UYujKKh0ogZrZaiB0gmM5l8dFq/7S6Ff4G235yYBE3RJdpQXGeLuJHyYPef0lKVE9ZDk
	 ebdSPYn/zooOZgJm8DEi8D8fkyQF7jrZdMGyjSfm5QPJVr4FRfIrY5lZIINYm75Jf1ei+
	 m6dhRU7f0nDx9l6EmPipQdKRLRwgeDfVhMikgA1qz3iUzS6rHJS82Gn993yUnOPQtX8qI
	 /IO2fAj9XJHqFcvo0cZ0CXYA48SPudT2sigm5zxrtZjBRuhx4IiWCOHAnTIh157MDFJFc
	 EVXW76zlgj4mbM1hGqhxyAscp30XgWzskjO/x54EiCzsSEzo3zey98SviSJk2zPQfNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIkb7dwe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA08606B4E6;
	Wed, 21 Oct 2026 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIkb7dwe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B511F000C4;
	Wed, 21 Oct 2026 12:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586155;
	bh=QhyHOu089+UU44rYgvZ+971lrIFZgmG/SKe33HQUXJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gIkb7dwerMcox8yBbQnQNVDsDkt0KAqm3l/9f3BN5WOY0iNkEXdxucLtPO6N98+O/
	 s7pScyd0fhS8XQ3cI06qYFL7+fNKzBE7HxwF+1MjNe6gynfmy9K0PqI/d2AoTzWja7
	 hkbyLFHgDsn1BjPGmQh5r6gyuh0xH8titG+Sz5VAOAf6jJ7QZf44llU4EJcHa1yKXK
	 d0MWiUDQrLkdIhsKgZkqWofrJjHm4plz9Iwhe59CJrr0hH0nE4WoCkt9pE1tQdIb12
	 iFfT4EPKdtdnrjgC3M7uQWyi/5YR1N2726d6gnKy/pV9Gz/AUw/VAnX8lBSYkDA2Y2
	 bWdkrpHQDOURw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Dan Murphy <dmurphy@ti.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 16/21] leds: lm3532: Clamp full-scale current to minimum bound
Date: Wed, 21 Oct 2026 12:32:25 +0000
Message-ID: <20261021123406.3163547-17-lee@kernel.org>
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

lm3532_parse_node() bounds led->full_scale_current to LM3532_FS_CURR_MAX
using min(), but does not enforce the lower bound LM3532_FS_CURR_MIN.
If a firmware node specifies led-max-microamp between 1 and
LM3532_FS_CURR_MIN - 1, subtracting LM3532_FS_CURR_MIN in
lm3532_init_registers() underflows and writes a corrupted full-scale
current register value.

Use clamp() when led-max-microamp is present so led->full_scale_current
is bounded to [LM3532_FS_CURR_MIN, LM3532_FS_CURR_MAX].

Fixes: 517ea49a7b23 ("leds: lm3532: Add full scale current configuration")
Closes: https://sashiko.dev/#/bug/linux-114b6c69-6d76-4f4d-bb87-0980b1e15bbd
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/leds-lm3532.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/leds/leds-lm3532.c b/drivers/leds/leds-lm3532.c
index 6fe752889487..327460de2ff8 100644
--- a/drivers/leds/leds-lm3532.c
+++ b/drivers/leds/leds-lm3532.c
@@ -615,14 +615,16 @@ static int lm3532_parse_node(struct lm3532_data *priv)
 			return ret;
 		}
 
-		if (fwnode_property_present(child, "led-max-microamp") &&
-		    fwnode_property_read_u32(child, "led-max-microamp",
-					     &led->full_scale_current))
-			dev_err(&priv->client->dev,
-				"Failed getting led-max-microamp\n");
-		else
-			led->full_scale_current = min(led->full_scale_current,
-						      LM3532_FS_CURR_MAX);
+		if (fwnode_property_present(child, "led-max-microamp")) {
+			if (fwnode_property_read_u32(child, "led-max-microamp",
+						     &led->full_scale_current))
+				dev_err(&priv->client->dev,
+					"Failed getting led-max-microamp\n");
+			else
+				led->full_scale_current = clamp(led->full_scale_current,
+								LM3532_FS_CURR_MIN,
+								LM3532_FS_CURR_MAX);
+		}
 
 		if (led->mode == LM3532_BL_MODE_ALS) {
 			led->mode = LM3532_ALS_CTRL;
-- 
2.56.0.218.g1ec904b173-goog

