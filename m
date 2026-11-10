Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324201;
	b=d62rlM9LeASUpaHAh1sRBs+lHDJUKkooEJPLepFjsgJWD2WlmWJUj81GzTdJ12z0NpNj
	 X4Q0PhMI8fVNJ9WWQha3o4qcxPw6+K7Vi6KyS8fXD71z0eqZc+/r9sHeR5ysVjCOu467m
	 lPLzVTsJ8qOLLidEKf4SLaoRRs+ojd/9ok4zWb+KFleIlx22iXX4pB1+E1NnBsU7z1/kY
	 gfvmxD7EhQXlexi4vJaMKFzFW7YnuDHJV6TRg9v98FxaqVznSyqMDZWmEmGeuF5TmPEOI
	 jvrBmGC/tTj3jASwJR3cW+AHXV34ruXpexeREj6CpqfjNsm72T5rDUQ1aIS/Wz0KdcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324201;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2fYS3m2doX0Q5EAu8sK1lNisCUFQ5EKdwqQEv6l+9Kc=;
	b=uGRhr3A2V/Dl9PBCQf3xLrlly9BM5WfZwWiybsy8vPJZLXf4BdHMG8p3ukAs/8tnc3w6
	 k6gnaMLCr5tmcfuWW1tYGVn2KOluQCIom4rAkGLMMGZ8ckpairTwXr0E1qHK6BtXm/sa+
	 +LUk1GnR+jFVexySW9tjzuNEEjLPfG5OFpil1rcb9G+VFTZjHXNeshzXYWk7v3ablxrRY
	 OJIQOCbeab/jK+6z+3yKMTiCgIVDUCnC4ZgD0P0AxcIMfRsjpnfRfwaET4krGNyCSVSA+
	 hA7lqdgwqtJ+so1fKjhFrNA+aioflYbiIjdUhV5fjxlSkLHzLI/tlCgpAPjEdTj/T5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PvJ50P6j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4A1606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PvJ50P6j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EC91F0089F;
	Tue, 10 Nov 2026 15:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324201;
	bh=2fYS3m2doX0Q5EAu8sK1lNisCUFQ5EKdwqQEv6l+9Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PvJ50P6jQCJCzYNlSikA6d91zTGfD08r7OgP40KO0TS++1Ie3tyx3507rmsdL7ok9
	 6gqhw8u8h6fNTRu0zDjmEdioAcMqU2mVwEZO5irjZD/yCL2TOOVWKWtLv51isEy0QW
	 FIzv8b09G+TQhF28DzsHP4/tMMi/3dO3uk0SRWRsyfdI098ks08GaXYL+oPBcXeo74
	 Au2EW9n4Z/HCvV3a94tYTlUcWkGri/h2QpXwNCg+JYHv7NyckIJtoDKBJcr4jZg08H
	 kaFxpehg6FW44UT30hSnoML+Nb1HByiHkEmk13sFzjyOlXCbEaq/XKAzOavR4qTc4H
	 LA4mtGjm7JVWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Francesco Orlando <francesco.orlando99@libero.it>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] Input: xpad - add GameSir Nova Lite support
Date: Tue, 10 Nov 2026 10:23:19 -0500
Message-ID: <20261110152300.2101199-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053502-failed-6.6-2e6f2e5799f3@kernel.org>
References: <20261107053502-failed-6.6-2e6f2e5799f3@kernel.org>
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
[ sashal: adjusted device table context due to missing CRKD SG and ByoWave Proteus Controller entries ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d46e0ad742307..904e701ed6ae7 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -431,6 +431,7 @@ static const struct xpad_device {
 	{ 0x3537, 0x1004, "GameSir T4 Kaleid", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x100f, "GameSir Nova 2 Lite", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x1010, "GameSir G7 SE", 0, XTYPE_XBOXONE },
+	{ 0x3537, 0x1040, "GameSir Nova Lite", 0, XTYPE_XBOX360 },
 	{ 0x3767, 0x0101, "Fanatec Speedster 3 Forceshock Wheel", 0, XTYPE_XBOX },
 	{ 0x413d, 0x2104, "Black Shark Green Ghost Gamepad", 0, XTYPE_XBOX360 },
 	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", 0, XTYPE_XBOX },
-- 
2.53.0

