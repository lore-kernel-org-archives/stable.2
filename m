Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356252;
	b=NM1oSOZV68cre0xGrW7udeE4FelX/vaDuwV6Oc5Eykr4ZG2EziyFAqW0x5+gmpzuEvLe
	 zhApVxOUY3yoor69+DTIzL5e4tzrvZGeVJPLYD/62fChZW9tQ/NoFulOQeYewAB4rdIY1
	 a5fWP6WtF2RCrROxPDsOYcui4q0fgqyOL6xGstOMB1TGF8JURUPM6kJqBGfKxqWxRc1Sg
	 0qHjFZ2IdN9LxVzJ34LFXr3Hra1XoosG6a4TStG+MGs8Mca91a8O3BA9Cxm/Hj7VlD45a
	 Ahh9sThQN9CbPWr9323y6wl0ORPe4pda4G77MXhSU/g/j/FaWOBP8BpScnLebGeCnCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356252;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=axTxW/PaO6ADHko9jZHtE3FNMaXmmgMRll7ro78HxO0=;
	b=mI2u1/maXsauBVlf/welkZuN6NqxAjF1FrlYoJokRbwZK3U/VdxTBFSCRVgGU6UkiKFC
	 64ShygbPKhrRNhMwG841vWbE08tKV+har9dAU8FNkEu2dAsMyZzt00Lo26C+GTHPN4aEr
	 PnjFv1ncKxqfkz8GXDo4wWLSsQWguUQcALubPppBPiCRk/bQHgbZ9sCTNEopcxUbQhvmb
	 B232pi9GGNir6vTLlZ/mmjbcafA8uyREYXMtXrlkVfBZbp33NKOO4a/1EYe4n3VD6Z0jF
	 Npejh9vCMLrrW7rvyH+2aYV8M3TpJkTyd0+J7xIA9mCR+GhfjFAKaOWt43GXUSJAq4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9iSjf0x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13FE606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9iSjf0x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB001F0093D;
	Wed, 11 Nov 2026 00:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356252;
	bh=axTxW/PaO6ADHko9jZHtE3FNMaXmmgMRll7ro78HxO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M9iSjf0xxWuAezlu/0zppoQ7qHgzzaoCe9haD1LiE+RguiCCINmDJ4kSzrh4OlNhG
	 KC/bG++uUHYQicMQTgE/Kkt8AwKIprgR/kf0EOUqUrA0PmICKMRulYHH0XQm8U0alm
	 DAS+A34bYKwlZXUIu3iACWSKHANot5r9TKCQV9O/letDngwQooPssf6xVkoHVInjcD
	 FpxCEBZ46o86u1N1QxeoFxjRFgCLbN6swjJkfNhjeFCQO24gOoK1GOSMXl8NVcoAen
	 1HGzMcWbZUfpkXevxNyk+/Mc1JOSGTuUBWQ0tTkOcd26ujxnhVPn0pX54SGsfHVi4O
	 4jvUpgyBmZ+BA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartu Alev <bartualev@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] platform/x86: asus-wmi: fix TUF keyboard power state shutdown naming
Date: Tue, 10 Nov 2026 19:17:27 -0500
Message-ID: <20261111001652.217391-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111001652.217391-1-sashal@kernel.org>
References: <20261107055306-failed-6.1-3d9a175707ee@kernel.org>
 <20261111001652.217391-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bartu Alev <bartualev@gmail.com>

[ Upstream commit 3d9a175707eeb15a2d577af1e669b98e0236719b ]

The fourth state flag of kbd_rgb_state_index is named "keyboard" and has
long been treated as having no effect.  In hardware the flag, BIT(7) of
the payload sent to the TUF RGB state device, gates whether the keyboard
backlight stays lit while the machine powers off: with the bit set the
keyboard lights up white during the ACPI S5 sequence, with the bit clear
the machine powers off dark.  Verified by A/B testing both values on a
TUF Gaming A15 (FA507NV).

Rename the fourth field and its index entry from "keyboard" to
"shutdown".  The write format is unchanged, the value is still
positional, and the diff is two variable names and one string, so it
backports cleanly.

Fixes: 61f64515299e ("platform/x86: asus-wmi: Implement TUF laptop keyboard power states")
Cc: stable@vger.kernel.org
Signed-off-by: Bartu Alev <bartualev@gmail.com>
Link: https://patch.msgid.link/20261010101601.888709-3-bartualev@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 2506f15ce53a1..3a9aaf13d5b4f 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -801,10 +801,10 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count)
 {
-	u32 flags, cmd, boot, awake, sleep, keyboard;
+	u32 flags, cmd, boot, awake, sleep, shutdown;
 	int err;
 
-	if (sscanf(buf, "%d %d %d %d %d", &cmd, &boot, &awake, &sleep, &keyboard) != 5)
+	if (sscanf(buf, "%d %d %d %d %d", &cmd, &boot, &awake, &sleep, &shutdown) != 5)
 		return -EINVAL;
 
 	if (cmd)
@@ -817,7 +817,7 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
 		flags |= BIT(3);
 	if (sleep)
 		flags |= BIT(5);
-	if (keyboard)
+	if (shutdown)
 		flags |= BIT(7);
 
 	/* 0xbd is the required default arg0 for the method. Nothing happens otherwise */
@@ -831,7 +831,7 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
 static DEVICE_ATTR_WO(kbd_rgb_state);
 
 static DEVICE_STRING_ATTR_RO(kbd_rgb_state_index, 0444,
-			     "cmd boot awake sleep keyboard");
+			     "cmd boot awake sleep shutdown");
 
 static struct attribute *kbd_rgb_state_attrs[] = {
 	&dev_attr_kbd_rgb_state.attr,
-- 
2.53.0

