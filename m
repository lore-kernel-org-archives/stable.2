Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323846;
	b=bhjDNm4CBL9zBHbSUwhcgBU4E4isAE+aemLoKjrDrF7187mZEweSRP5frrZ+HBedDQBW
	 7To3g0o6VJXtyXhWau+9nQvdiUx2aeJNwqfJl6Vun/j1yv3OtUW+n8tIuprDgjjm/GukV
	 ztIVUJj2c54XXvpGydK4qgcyNlv9Z0yadK3BumOSFIzXhXHf/yCnjbepAx3ttsdIJEvR4
	 t0AN/hzAJ7YYvmxLQta3+5EvVqhEHwb7EnNsc/a0wLPFh33MklwZvQbPhjYrDDMAC9MP6
	 Wlz4sg5JUYPVIokW97l1GLmBQdNSEn1rmfk4cMKUQ1StE5dWUcUxkX69zlRe4qu8NhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323846;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9H3DCsrKplGjPc0HFdwAciY3I24Kj5obiDKtjAzJiS0=;
	b=0HLNbdOUAjkLlPpge6ddHpGNknL0YvV6O2vYbR/sJmbgUh8hQS+rWhOWzqu8IAWhdf9U
	 FnnqhKbXoz+HQgfUpx4/JkqecMFe/DcxLvTkVHGhob5WhOiJme/mdf/7sI95/W+xZDl2W
	 Krgnwlb4UQyLAmAUoYhe3sNP8HLY8t8BS/xiqksPuGGCeFYfBhoaaJHeBq3UcfOKh3XxR
	 Er/1so7D1R75CTtPSg4MIh0Hi35lrAPBiXlfq7+C55eu7D5LnN59VkmpLypd5mdTCjNiW
	 L/TG3JtlXys2XCZAeZjcXfLP9S1gTC0E474bGZV441B2Am28+D6APUXZk6WdJpcPW/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GTHx+hod;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10AD606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GTHx+hod
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C9A1F008A4;
	Tue, 10 Nov 2026 15:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323845;
	bh=9H3DCsrKplGjPc0HFdwAciY3I24Kj5obiDKtjAzJiS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GTHx+hodAKAE+N08JMsk2gzVKsbmJRLRYpX4FR4GFhRpVvte6jsvnpCuoVZbFG23g
	 +Ed5pAplvzv1RevsWW/A3bvMzfFMNh2pMe4Ellfa6/asIQ6z7rQymiT7qB5Fh3rU0o
	 YbRjsozA5FnYxKbxZOf1Y5I0g6yucvDSgSwdN+TZhgbYZZdDEuh5zenvXvVXqHtpD7
	 Juy1fl8xpYmN8vMS+gAnNGXkO7kZ/8Y4uj5H/+KXX0lzyQU2zw0uUK7O0iDZ1Kw1HK
	 08sBzPZQ5rFcN7T9bc2jTBfKjOSR6L7eyjhVi6rpyYnL14sI9lFwyazkXzLCFN02ud
	 bKoU8tE1AIjuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Francesco Orlando <francesco.orlando99@libero.it>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] Input: xpad - add GameSir Nova Lite support
Date: Tue, 10 Nov 2026 10:17:24 -0500
Message-ID: <20261110151713.2069882-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052231-failed-6.12-2e6f2e5799f3@kernel.org>
References: <20261107052231-failed-6.12-2e6f2e5799f3@kernel.org>
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

From: Francesco Orlando <francesco.orlando99@libero.it>

[ Upstream commit 2e6f2e5799f328ca0879dad14d7f3709c7f7496b ]

Add vendor and product ID for GameSir Nova Lite (0x3537:0x1040) in
XInput mode to enable force feedback rumble support.

Signed-off-by: Francesco Orlando <francesco.orlando99@libero.it>
Link: https://patch.msgid.link/20261011165821.72698-1-francesco.orlando99@libero.it
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[ sashal: Adjusted context to account for missing CRKD SG and ByoWave Proteus entries. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 3086fc4a0642f..5e83766a308f9 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -432,6 +432,7 @@ static const struct xpad_device {
 	{ 0x3537, 0x1004, "GameSir T4 Kaleid", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x100f, "GameSir Nova 2 Lite", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x1010, "GameSir G7 SE", 0, XTYPE_XBOXONE },
+	{ 0x3537, 0x1040, "GameSir Nova Lite", 0, XTYPE_XBOX360 },
 	{ 0x3767, 0x0101, "Fanatec Speedster 3 Forceshock Wheel", 0, XTYPE_XBOX },
 	{ 0x413d, 0x2104, "Black Shark Green Ghost Gamepad", 0, XTYPE_XBOX360 },
 	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", 0, XTYPE_XBOX },
-- 
2.53.0

