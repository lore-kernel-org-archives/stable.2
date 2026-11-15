Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794770899;
	b=dbL/eTPFcgVw/WTpih35pv47gjuhD/jXgL3UtZptpICxq+XCZ5oItsfmzCuG9gR5tnx2
	 +nGnVYTd3/txXgCRdcSQv8XD3WPNs++g+YWf2iS8WslUpYKJv2gl3830h8daiKPt+Q2tq
	 HuJ6Qy3AY2Kik778zDn/QDHrcgoi413JkHf0Ecns2xP3fA864ZqiHM4/KfA/0SXTSEWsQ
	 fgGCGTdnyVKiqgxhnDs0kOZvVaoU1xcM/lD+kIF5qzYqFNkb84cUzDXNEiuezHe61xxEb
	 3OZrAN/nWCza+Jo3M9i1Es4uVOhg3+BdpJNNryJSK2R0g97+rTYHFE/Rfzcx+S8z2fA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794770899;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=yYntjNZbni0Iutvtd2719yhws2sfxl6/Jy95mRh6jNo=;
	b=JaCcDMPRyRCzn1E6HhDieESj9H5qInDkOTnAyD/RkcsxeTV91bWsF2405/k9lBo5sjo4
	 OO+zWusZ69Xgt40a5F4RSr8T+9xDpP4sEQ9CGJA8cgW+53y46x1uRmeOWEpQ2AXkgIQnv
	 PpjKTqnGE6ZMfHSy4r6JGClc+d+Q3X1Qx2e1wzcu3bHhHKADsyUfXGdTECW5iCSYIlQlC
	 Kk7+xIYsFKMIIS6oWSujSQn1vGuYFmwb63c6ncS/90rjRZmFDSPK7SpsS6/PVH2k2UznF
	 Q11E5vT3d/F0Uj9dzrZR+FjY2VqpAqpBENXZLI0eqVApuCPiCAuRTaMEGa5p4YHQHAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=Wa750nLG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731D7606A337;
	Sun, 15 Nov 2026 19:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 731D7606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=Wa750nLG
ARC-Seal: i=1; a=rsa-sha256; t=1794770879; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MfWWPDZ2UfrCPqGtSUccRB3t8d36wAbe+A4iyrcEZ6LwOHoxKK16Sa+W+trxQ4CiD7oH5mUGXx94t0etP5uJLnKRNiJivAE5XZZENgUR482BfdUS800o9wge3TrsSD1HYMwY0W0WvAHkz7BXW3SSdQI9MeaVFEWMCzP/W4lHW88=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794770879; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yYntjNZbni0Iutvtd2719yhws2sfxl6/Jy95mRh6jNo=; 
	b=JGM6IVF/MyaUiqfEBnJ7FxvCjw+oUCfar4AbICGtjv3gzonjDe5hefxfqeYeQ42rDNEJ9S1Px5Bfw5fbD8CCd+5jCCKEjIxYdO0LaP7AKr8N/iPfj9IPO6yCjYxK+y321FdflWW1PKQk93BywDFTFrxmqHhhx4YN360H3QjIMcI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=Wa750nLGSyktQ6G87OITP2VoxTFuEpp7Mj73+OU1dHW+39X4h3MpDy3fIQyJlC4Gafu8vS0S9iQEMlvVaJq/yd5QcvQrXZYf8PJgsyBVbrDjwjviJk1EQkpkk/yG7mZm297rDt92T3Tc05XKemJTF/3vEjkxpCO2xouhYDWReLlVNNKvWXT/zNZRPp3dtHLlZOQdi/LsFg0t1qQsHMGSlYj4H2bzcH2dR1teFdBCM0JvP7gp6YQ/IeUyiYljUNGC55lIio2hOreo8kUN58Jyfsmh6tTE23GDKKYp8K9BP3y5hDhW1s3vCxv3rpcppxuq7USwggjAwcdeo/KL/RGv0Q==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=yYntjNZbni0Iutvtd2719yhws2sfxl6/Jy95mRh6jNo=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179477087734999.64132555381343;
	Sun, 15 Nov 2026 11:27:57 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Mon, 16 Nov 2026 03:27:02 +0800
Subject: [PATCH 1/7] platform/x86: lenovo-ymc: Use enumeration to represent
 device posture
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ymc-82yl-v1-1-fac1a2b01a84@rong.moe>
References: <20261116-ymc-82yl-v1-0-fac1a2b01a84@rong.moe>
In-Reply-To: <20261116-ymc-82yl-v1-0-fac1a2b01a84@rong.moe>
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Gergo Koteles <soyer@irl.hu>, Ike Panhc <ikepanhc@gmail.com>, 
 Andrew Kallmeyer <kallmeyeras@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mahir Faisal <mahirfaisalantiq33@gmail.com>, Rong Zhang <i@rong.moe>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

There are five known Yoga modes: unknown, laptop, tablet, drawing board,
and tent, but lacks symbolic representations for reuse.

Introduce an enumeration called ymc_posture to collect and represent
them. The lenovo_ymc_keymap is also refactored to use the enumeration.

Cc: stable@vger.kernel.org
Signed-off-by: Rong Zhang <i@rong.moe>
---
Cc stable as the later fixes depend on this.
---
 drivers/platform/x86/lenovo/ideapad-laptop.h |  9 +++++++++
 drivers/platform/x86/lenovo/ymc.c            | 14 +++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.h b/drivers/platform/x86/lenovo/ideapad-laptop.h
index 1e52f2aa0aac..e29f741ffbf3 100644
--- a/drivers/platform/x86/lenovo/ideapad-laptop.h
+++ b/drivers/platform/x86/lenovo/ideapad-laptop.h
@@ -15,6 +15,15 @@ enum ideapad_laptop_notifier_actions {
 	IDEAPAD_LAPTOP_YMC_EVENT,
 };
 
+enum ymc_posture {
+	/* Some devices cannot recognize their postures on boot. */
+	YMC_POSTURE_UNKNOWN		= 0,
+	YMC_POSTURE_LAPTOP		= 1,
+	YMC_POSTURE_TABLET		= 2,
+	YMC_POSTURE_DRAWING_BOARD	= 3,
+	YMC_POSTURE_TENT		= 4,
+};
+
 int ideapad_laptop_register_notifier(struct notifier_block *nb);
 int ideapad_laptop_unregister_notifier(struct notifier_block *nb);
 void ideapad_laptop_call_notifier(unsigned long action, void *data);
diff --git a/drivers/platform/x86/lenovo/ymc.c b/drivers/platform/x86/lenovo/ymc.c
index 91de02d989a0..70f3ae20d3e3 100644
--- a/drivers/platform/x86/lenovo/ymc.c
+++ b/drivers/platform/x86/lenovo/ymc.c
@@ -64,15 +64,11 @@ struct lenovo_ymc_private {
 
 static const struct key_entry lenovo_ymc_keymap[] = {
 	/* Ignore the uninitialized state */
-	{ KE_IGNORE, 0x00 },
-	/* Laptop */
-	{ KE_SW, 0x01, { .sw = { SW_TABLET_MODE, 0 } } },
-	/* Tablet */
-	{ KE_SW, 0x02, { .sw = { SW_TABLET_MODE, 1 } } },
-	/* Drawing Board */
-	{ KE_SW, 0x03, { .sw = { SW_TABLET_MODE, 1 } } },
-	/* Tent */
-	{ KE_SW, 0x04, { .sw = { SW_TABLET_MODE, 1 } } },
+	{ KE_IGNORE,	YMC_POSTURE_UNKNOWN },
+	{ KE_SW,	YMC_POSTURE_LAPTOP,		{ .sw = { SW_TABLET_MODE, 0 } } },
+	{ KE_SW,	YMC_POSTURE_TABLET,		{ .sw = { SW_TABLET_MODE, 1 } } },
+	{ KE_SW,	YMC_POSTURE_DRAWING_BOARD,	{ .sw = { SW_TABLET_MODE, 1 } } },
+	{ KE_SW,	YMC_POSTURE_TENT,		{ .sw = { SW_TABLET_MODE, 1 } } },
 	{ KE_END },
 };
 

-- 
2.55.0

