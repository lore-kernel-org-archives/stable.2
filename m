Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325050;
	b=4rqDYSjKg2CiHMZjt/R5HcrsAXw1IHDwAlxyMzR2WN2Pu+cPh25TjARZR4sx3gtNlDLt
	 tiqRH9ZLso5SebZn2BtcuGIaNQ9Db1dSUT+ONThnUYCzYGi1IhsSnQVMhYB16RIMNGfPr
	 OF7zS4fJ2pnOpEiNixkhVhgYibW/GGRIy+iQyrSOw8DOXWdbogyTHI/hIvsCSolg+WkjI
	 v03NMW4s70cf2szPHjY1wR2pUBb0gRP5UblQJH7HDeXhdWoq20O8bSFqJR17hmYY/wExj
	 icqlo2hz/TW11+BNNSBNTIn4E+3lpRnb2lk6srBRABaAyL3uhqNRCh8YcFBoMcqnxHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325050;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3yckJkPVbqrwTvc0tNFCg+JD398HEGXbIJGAM6kbx7I=;
	b=YBNtha92ZAcXJS1k7XfnpadCFq6oKc+jJybOJllFPULy2eWyvwGjpHAYOFBsLi9jv3+J
	 8Vq1NcNSLigMdz3ztnfKURpOzhNSOWzHuxgL2wzYLBqJ7eSxtx0VDehf2BAtmGp+mZegX
	 ZQ9/FyhVf4uVC0A+RSPwVw299ycL6eUA9Rg9HDZlp5+/jAL65aGgvuEfxdt51IOIqdo0n
	 VV9M/P0i8No0GrwPnDTYr2nJRXX0kfXy1iF6lYjNeAcXYHjXHilX+1TGaveqO7DZ9opbU
	 U4QfX7Z5SRm1oZ4ET8oEVVQNt/5CYbiZ1WirN9NqeV8JI3qAVLeqCNcD6hD57f+BdFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFC6B1oS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D233606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFC6B1oS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054671F0089F;
	Tue, 10 Nov 2026 15:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794325049;
	bh=3yckJkPVbqrwTvc0tNFCg+JD398HEGXbIJGAM6kbx7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oFC6B1oSpDL0OEIjfszAUWTSmFAhsQ+vT+5EtkesiFwFceZxJccK74SDfIRx3jcEt
	 m54LLnjWTK1INl6h4Z8hN3az7l83x4m+SgjS5bd21m3LUL5Ehh1hHPFOxaXmiFyYbk
	 NvtzOYOMM1QDM3dKDijajWC904apz/oKBJMCtm9A4R90V8Xm9uSKOtpHkKk+LnhWJK
	 hs6FUfyvERB/yzIYSL18v3yWhFGXEJmH+U9ioJtx1PiSHY8eQEt5GbapFKBrNUVTM+
	 O3gDDSIuUiplJ51UyvPnyMEUalmU2JqZsEPRDdxQgC32Y2bCAUpG3j6sRwjpvtnm5+
	 B55zqw1fghZ2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Francesco Orlando <francesco.orlando99@libero.it>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] Input: xpad - add GameSir Nova Lite support
Date: Tue, 10 Nov 2026 10:37:27 -0500
Message-ID: <20261110153715.2315172-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060616-failed-5.15-2e6f2e5799f3@kernel.org>
References: <20261107060616-failed-5.15-2e6f2e5799f3@kernel.org>
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
[ sashal: added the missing XPAD_XBOX360_VENDOR(0x3537) entry to the USB device ID table ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 4417cd8fa6d31..32f5d9ef34cd5 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -363,6 +363,7 @@ static const struct xpad_device {
 	{ 0x31e3, 0x1300, "Wooting 60HE (AVR)", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1310, "Wooting 60HE (ARM)", 0, XTYPE_XBOX360 },
 	{ 0x3285, 0x0607, "Nacon GC-100", 0, XTYPE_XBOX360 },
+	{ 0x3537, 0x1040, "GameSir Nova Lite", 0, XTYPE_XBOX360 },
 	{ 0x3767, 0x0101, "Fanatec Speedster 3 Forceshock Wheel", 0, XTYPE_XBOX },
 	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", 0, XTYPE_XBOX },
 	{ 0x0000, 0x0000, "Generic X-Box pad", 0, XTYPE_UNKNOWN }
@@ -493,6 +494,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x2f24),		/* GameSir Controllers */
 	XPAD_XBOX360_VENDOR(0x31e3),		/* Wooting Keyboards */
 	XPAD_XBOX360_VENDOR(0x3285),		/* Nacon GC-100 */
+	XPAD_XBOX360_VENDOR(0x3537),		/* GameSir Controllers */
 	{ }
 };
 
-- 
2.53.0

