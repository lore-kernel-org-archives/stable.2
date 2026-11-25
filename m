Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795630157;
	b=FW5QT04lTqQ2LjDd83BP1Zo/3cgCYoX7C9Z6wrznjvwtv9zF2K1l3lNCetq7yaJ91N2K
	 QWhLIH6YynJooy9hdMz3R5nPgM9MTf4jvkVU3lk6Q6bFpfeJ5TTrx2cIBFWpcCurMezjU
	 1CBpo8AUr8oR24m2SGEmr1Pp7o8WbIw4mLjTVZwj66eKOzCrRmEabJOBSd7Be/U3D9v+Z
	 7XYdbMwTp6GxuLLo2HPcbr7r6txd7PBZVo85hZ9KnEHcpZ+weWC1Z9Tw02KrdriGuoKt0
	 8QJWz6Gx1yCRXSb92u//DVdHLXA10Rgbc5PfIB0vbIAW/Do6hI3rDMbLfM5a1MdJpDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630157;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=0oa+uNW0wOwW7Lr7NxZMOJplZAq/xLXvfIbveJB+fR0=;
	b=1iN87TURIfkHhl51Z+Fy5xn3oX2kj8DPC6cfIgShwr+R0bm1Zg0LZ8flbBKQXj7wDGFw
	 IhkjCPGMUX9JlCTMbxuFKB19K0+I0al62FgF2oixKcznVS+KHJxDY2DaKu9su39uPO0NN
	 4gU8J4WMx4ahDGBcjFkagfArs6K5PwXGv9eA1LLC7P/lS07TzozZqR5k8yAi/7VUD++Pt
	 /Ppy3ysRzfPyLPMr9CJH8JLOxgE6/iO5lmCT3Et+MrHWTMq+InLPsfCfKGLc8L13qyXOd
	 myb8GKUee7g5ubHw/W/fzLpmxjX7t9XSe0SMtldC2tG0ZI+dJKbn/roHPOZrBggMvDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=g1Qpyx8g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
Received: from sender5-pp-f112.zoho.com (sender5-pp-f112.zoho.com [165.173.182.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17F1606A323;
	Wed, 25 Nov 2026 18:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C17F1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=g1Qpyx8g
ARC-Seal: i=1; a=rsa-sha256; t=1795630129; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jP2W5MviC9MpcK9NsUagIzhTQ85TNhAAKUf7HOZxc6WcfbbwCuOT9dSGaN5PviUxubbdIpRXQgIQ4aP+VB7m7bIP9lzCDKE4n4a9VwNMnLfgpU8araXZRex41nnAAU1wWu2TGFYGe7YL9JGdp1FbbsAmo1Zi7cODWUDhUk2nXuQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795630129; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0oa+uNW0wOwW7Lr7NxZMOJplZAq/xLXvfIbveJB+fR0=; 
	b=UboFKgf4bouGpwrqfeS5Jf2A7m/92NNFWJf6adpJY9lFF5ZeOFHURHELsN/CkLeA7Pxt0ciQCpI5by2louYZxBXPrwt8JTB6N5HZGRsLk2qlrojhPsE4Aw2fezsS/YQh40zgOeKwv/SqcVXMa3DRrNr+3jnolkqHe4oAUHrgZUk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=g1Qpyx8gpz7bvfMBwVlrc78cddTRppzKLj+Pu6lrgZeMQycyd1EPmfDiHxPXb/OeuyqtBW4dF/V2zHH0fFVcE4mPjwcyA9wMwRDTKEUBkMnytEtfQx28XMp2PMck4STPueJQvzczQbvtTnX4Pj/Yg6MtbWSQQsWbUqNWJB+8TE/liaPYIGTog0IFCV1lsQynq/9rCqpRLkcpKe08psoIrPdEmtSOfsU0qc2a1ZNRgYjT9SJJknl9+X574h3T2Tvny+w5aReyCR9jB/A62AEMFIMJ2beTWmGsnV4wrOtYVsAFPE8rTXwzezm8EW+sk3Na5oD+H4gDnBRtIvcgi2312w==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=0oa+uNW0wOwW7Lr7NxZMOJplZAq/xLXvfIbveJB+fR0=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795630125598602.3462109190962;
	Wed, 25 Nov 2026 10:08:45 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Thu, 26 Nov 2026 02:08:19 +0800
Subject: [PATCH v3 1/8] platform/x86: lenovo-ymc: Use enumeration to
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
Message-Id: <20261126-ymc-82yl-v3-1-e30842671ec3@rong.moe>
References: <20261126-ymc-82yl-v3-0-e30842671ec3@rong.moe>
In-Reply-To: <20261126-ymc-82yl-v3-0-e30842671ec3@rong.moe>
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
Tested-by: Eduard Aliman <edialiman20@gmail.com>
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

