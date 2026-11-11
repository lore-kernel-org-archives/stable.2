Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368011;
	b=Ua9xYbrepFOeWkWfxKL2uu2VMmom6X9Gky33Eg9svCVObPAP4WsUUmKKMVJxVBvuGo7+
	 pjfFwJhpTG6In+78leB1/gk1sdLkU9UpGxGUpV7jQRDSlDlGRKxr2bsFloIGp1cXhgxmv
	 CujeGZ3+cyg9Ey5miAfHp18v9kFeDlZzoHHofIrgwhKJ7Tid6XjLqOqSOyTbDGbDPB14q
	 ZORcW6gsWDIDodJMoAVAB3ZFSP6gO6sAsrM7XE5Naw3QR+ZiViFpbD+nhl0cvY1xZHidr
	 MeJVrwWcky79G9ZPk+yY29aA8o2Y1iE4Q5dg7hsdYBjYvaEmJyone9YsgbrkJ9LwHIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368011;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1AuWj1mFqkp5pUXRMMdzW5vqvMcYIuWZzTOHEdwcYxQ=;
	b=l2ShTz1QXDrKlQXjcD8r6Jd92cO7fGamqT2US6R+SSAJ7BkZ6RXcw50O0QOJ2My0kaJ4
	 3doB1BjhHl9zEmIxVV6BQQDNmsfTDpccA8J7hRubb++FU3u61yUPLibh5NpHuRDPeV8jB
	 YmJDP+zoaLh199ItrJ80keLZR8g2xqRqpto6/9SHoYdDfbElSp6YiPxWJ6jdtenY8tDZs
	 5mJ1Z/IGRC0fstS+WU4ocSKLgggthnsKrKUeG3oyCNBCsMQVnKVQpMO9mIMOsjcZ3wTZP
	 /xS9yfvkhiENhkyAGrk+Nr6IdfbpxM3z+C0i2bO+mEI3BVtZEuhf6TOJNHgSGOhyJZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ax7xi3jm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16122606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ax7xi3jm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6F31F0089F;
	Wed, 11 Nov 2026 03:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368010;
	bh=1AuWj1mFqkp5pUXRMMdzW5vqvMcYIuWZzTOHEdwcYxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ax7xi3jmCI1fqQN2wrBe+LAeAoQjBzPlKcjp2hfSxooKSpaGLOLZSzLIWJormDZs5
	 L78LuZwO3p/sXQPlvhl7VJnUyf6IiaRB2qN72j//ddUduRk8Wn6NtSmZ2YOJzrv338
	 1arRHql6WogR/nJoYfmmZsUsIIe7e7nFWaY1Cjna89XWNGPQ4FCliWmcD/nfWf3Kdw
	 GZkLGSVGAm6mVvF6vhbUNHDK2kh2TTiweTLs0C7xTeVCcRQ/PJyVMxNVal8Z+QLqnJ
	 5UIqjQ1VKjzTGM7Fvr9GkM2k+N0rUo2rsyZ7jR0+RZuxpbkJu0s+pF3FUvVjJOboP4
	 HZta1cbwMrSQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ridham Khurana <khurana.ridham222@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] hwmon: (lm70) Fix rounding of negative temperatures
Date: Tue, 10 Nov 2026 22:33:28 -0500
Message-ID: <20261111033235.895117-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060016-failed-5.15-eddb0aaacce4@kernel.org>
References: <20261107060016-failed-5.15-eddb0aaacce4@kernel.org>
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

From: Ridham Khurana <khurana.ridham222@gmail.com>

[ Upstream commit eddb0aaacce4baa9d8176eb2f4bd9e99e867f8fc ]

temp1_input_show() drops the low bits of the temperature register by
dividing the raw value (raw / 32 on the LM70). These bits are not part
of the temperature: the LM70, LM71, LM74 and TMP122/TMP124 always
return some of them as 1, and the TMP125 fills them with copies of the
temperature LSB. Division rounds toward zero, so a negative temperature
with any of these bits set is reported one LSB too high.

For example, the TMP122 returns 0xffff for -0.0625 degrees C, which the
driver reports as 0. The LM70 returns 0xf39f for -25 degrees C, which
the driver reports as -24750.

Use an arithmetic right shift instead, which drops the low bits and
rounds down.

Fixes: e1a8e913f97e ("[PATCH] lm70: New hardware monitoring driver")
Fixes: a86e94dc946d ("hwmon: (lm70) Add support for LM71 and LM74")
Fixes: cd929672a9ef ("hwmon: (lm70) Add ti,tmp125 support")
Cc: stable@vger.kernel.org
Signed-off-by: Ridham Khurana <khurana.ridham222@gmail.com>
Link: https://patch.msgid.link/20260924205326.1739229-1-khurana.ridham222@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ sashal: Omitted the TMP125 hunk because TMP125 support is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/lm70.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index d2a60de5b8de9..0a9d7bdd0d3c1 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -90,17 +90,17 @@ static ssize_t temp1_input_show(struct device *dev,
 	 */
 	switch (p_lm70->chip) {
 	case LM70_CHIP_LM70:
-		val = ((int)raw / 32) * 250;
+		val = ((int)raw >> 5) * 250;
 		break;
 
 	case LM70_CHIP_TMP121:
 	case LM70_CHIP_TMP122:
 	case LM70_CHIP_LM74:
-		val = ((int)raw / 8) * 625 / 10;
+		val = ((int)raw >> 3) * 625 / 10;
 		break;
 
 	case LM70_CHIP_LM71:
-		val = ((int)raw / 4) * 3125 / 100;
+		val = ((int)raw >> 2) * 3125 / 100;
 		break;
 	}
 
-- 
2.53.0

