Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795544295;
	b=fPRGKzcPIAfKcvmQclXkq65vqx6P+P6O7OrcYMLe+emtVxj/3QykWcSHq2LWTW1Klo58
	 ykyXYeKpbDq5SpOS77OWqjKup7J2qMsF9F1AQ/zcBlpfo14m4OG29hmYBJjVjZjXkXL5/
	 ZiD/8V48BDrhT/vLjvIt6E9TbgQhxBal7FQvQBNNq5ZG66xManc379vY9yBEuzYo4cZMK
	 P/Rx+u23evQUjX6uqIo8lu+FMU4PiSAfEr+2xHzfDjGubj9bUnmCspd22hkSfti37Rro5
	 R29cjoQ+uEpkQKw0keQdfrJKJcM73v4t+PeyW8rdxRytiOZULWnTbkdrsIxwY/cfnng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544295;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=Y+uNJIbS/k6izE8dGFqKxEPaK91Runn4AMeZIObm+bA=;
	b=LF7993X2dTFSZPa7ZZsUVSnvsu3pCnqLQCeTxkPob1N4aQZQYoN126h+awB39piVMmgO
	 yLuD+iaLd/fudExKIUnxRPNi3nT0rkzRRPCZeBy6lNr+egRwY+a+JazqsjEkhPyvEVLEu
	 tuZffQE719tPAEedTD2nYYf06O/zzFTGjSbU3yWc9++wQewFvbGAwr2uIjiysEOsKZtRY
	 fpcmx6+1O6J7Sc81Ts5A9bVv0OWJSQcYasm0R+sNutq8cm4KE+LBJtwqxB/VC3OJcDY2f
	 EyVu3VxEzCTDpqMomHD6laUU26oPiP8ze5NMyE/OLnpOqXPG2nc64vRdGN6Q877Z6vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=CODfaRwq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
Received: from sender6-pp-f112.zoho.com (sender6-pp-f112.zoho.com [165.173.180.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05986606A690;
	Tue, 24 Nov 2026 18:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05986606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=CODfaRwq
ARC-Seal: i=1; a=rsa-sha256; t=1795544267; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jN8O5sQUWyJ8VcDTExBi4FE44UqiB2pqCmzsNWcdOJq90Z6jq3EbmlqpReDW2OWGQBNIuLhA4SK1JdJKovlKnFCctLuXFUzS3bRbD5by/ncsgfx/rj9dvkhoXNRFAZqJ+eQDnu3AdZRyZGiWm/gca9GUyly2IFco0z3TPpIQCy8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795544267; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Y+uNJIbS/k6izE8dGFqKxEPaK91Runn4AMeZIObm+bA=; 
	b=bDAl+6dTCHQNLtXKwiRfgn2fKyocUMiG4CVQuQHIJWWR4ef5IxiD+k7SMJ4wytfqbAXVAUnS9SMNJDw1/kXvkF7Fwjzj1aZ9MIH6jsocjwcIe33lmZDSdAlYyIuAzOT9iqguUtdFWlCOQkzqllP+E3zb4tIEC47fDk/CondLzHY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=CODfaRwqka+NkCA/f8DG63/UzZMOSDX1rZOIkt2C+xhAi4Y2cwdRR0B6nCn7w9qFB+AYox0k/MgaCvhaea45rxz+28vlyZMcbCdpFIh3l5PMB5L7SyXHZ+iKvJRS8oJILyYEwdwT2cbeNSNFLgf6Y/2Y7jIMyesdqGvWC8bznq9aDlroZ6lxxZCqsK7QWUVHhXmHkpZM7G44TVJT3bcKVWGwbF/FO8BUwHz361xgc1MDtvJQu4K1u6JR6mlXdDyFiHuACslM4vxfHsjcRpvqRYEuGvOLqeWtyMGmDusY4cAXz5mw1TgNbIrf5n8dZCgqsfLpeJUJCGI9lj7bN9qhDQ==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=Y+uNJIbS/k6izE8dGFqKxEPaK91Runn4AMeZIObm+bA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795544265691658.7158953103936;
	Tue, 24 Nov 2026 10:17:45 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Wed, 25 Nov 2026 02:16:57 +0800
Subject: [PATCH v2 1/7] platform/x86: lenovo-ymc: Use enumeration to
 represent device posture
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
Message-Id: <20261125-ymc-82yl-v2-1-624bdcb3c50e@rong.moe>
References: <20261125-ymc-82yl-v2-0-624bdcb3c50e@rong.moe>
In-Reply-To: <20261125-ymc-82yl-v2-0-624bdcb3c50e@rong.moe>
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Gergo Koteles <soyer@irl.hu>, Ike Panhc <ikepanhc@gmail.com>, 
 Andrew Kallmeyer <kallmeyeras@gmail.com>
Cc: Eduard Aliman <edialiman20@gmail.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mahir Faisal <mahirfaisalantiq33@gmail.com>, Rong Zhang <i@rong.moe>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

There are five known Yoga modes: unknown, laptop, tablet, drawing board,
and tent, but lacks symbolic representations for reuse.

Introduce an enumeration called ymc_posture to collect and represent
them. The lenovo_ymc_keymap is also refactored to use the enumeration.

Cc: stable@vger.kernel.org
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
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

