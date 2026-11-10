Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354962;
	b=isSEoXAiU1Ao23nYwu88A3KW/b2OOJX+cvtq95eb481N4pPJAYTaiKNTO4hNR7QoL4Dj
	 lmvTaS5kNj2VWJYIkjVPUtPSdSIc9e4eDC0VKT+tb+L0stm3FnztgwU2PuX5BRvFLMkxE
	 fvNaO3idzQPUrBKnIAgJdJRLCqk743dokBpgsIkns9RT6Obm9izqnMASdFafI1xJ2y1jl
	 1oT++fijZWXy8/zLzrTLO67gKg/PMkjmp3jdgmA9r0izPbi0vxp+ThhLujm1EYoaAODZX
	 Nvwhx5if11zfCHlZfF/g2fF888CUkorD3f0WQp4ghA3hJKyEdx1pAL8GgmuQfRxKTlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354962;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XQZ288RnSi7+6VSVkRczUOvvaHC1CnXsp1eQjHgNkZ0=;
	b=RtqJYgsKgrobPZ2xTswxP/8uzj4KcAQVgVOW6QpvbBGGMZsd2tGdvkwrFow+xgvwhSub
	 ZITtfLCK8oKQU8DgOKsLod+IPUvs47F16mICKRgD72dY4c4aY7JI9m1rzCRI0BjsqoVkM
	 runxvqyiqVxP1N5CrLSUa9M1UrIdV1MDZcf4WfrgsQuYKc72iC/1Vgr/1cuY8WXP3e3l9
	 1ys4l62Q1aqYNYelsdowm6Xu5RYb+CbPK1is9ENZetDEruYrriKUZkWnf8gPoYf9IKDNr
	 OvGslB3irJ6jPoFuN7xmtxjmmksrIDI/LJ/q52eGbUvYh83MfUvMykj7KGVLF9AtvRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtwQzyb1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34908606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtwQzyb1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D2F1F0093C;
	Tue, 10 Nov 2026 23:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794354962;
	bh=XQZ288RnSi7+6VSVkRczUOvvaHC1CnXsp1eQjHgNkZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dtwQzyb1TOlRj+2hKa7afUaJL49GLT7E/5z9NMTksPG7pTGqx7yh6A0nHxBEniatl
	 IvGC00vKnA/naFi60dQlFG3zgHRjpqOsgjpYu3qQ93kaFvYsvejGIcFX21JPLTU7Vs
	 7T2pBhWxdL6mPNuPhrxOIsdMd3nurhZBMxQsWdM35T6XiNVb5Jp8QIM5abItlEcNsw
	 Bd5T9dMMg94hVbFufJuAi99gVJC7G4oCOT+AasoNDH7Ha8zCR1KgITgWDr1AKuwSIO
	 5+UIij93yE1WbbCSgVUUjqdQ9zbs+CepiG6oM/vXMPBKXrZ9FDWlMV5k+s//pk9t/E
	 XDXp4otOhEX8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartu Alev <bartualev@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] platform/x86: asus-wmi: fix TUF keyboard power state shutdown naming
Date: Tue, 10 Nov 2026 18:55:58 -0500
Message-ID: <20261110235541.191333-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110235541.191333-1-sashal@kernel.org>
References: <20261107053801-failed-6.6-3d9a175707ee@kernel.org>
 <20261110235541.191333-1-sashal@kernel.org>
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
index 2701ab8270fdf..f1f159f974cab 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -931,10 +931,10 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
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
@@ -947,7 +947,7 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
 		flags |= BIT(3);
 	if (sleep)
 		flags |= BIT(5);
-	if (keyboard)
+	if (shutdown)
 		flags |= BIT(7);
 
 	/* 0xbd is the required default arg0 for the method. Nothing happens otherwise */
@@ -961,7 +961,7 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
 static DEVICE_ATTR_WO(kbd_rgb_state);
 
 static DEVICE_STRING_ATTR_RO(kbd_rgb_state_index, 0444,
-			     "cmd boot awake sleep keyboard");
+			     "cmd boot awake sleep shutdown");
 
 static struct attribute *kbd_rgb_state_attrs[] = {
 	&dev_attr_kbd_rgb_state.attr,
-- 
2.53.0

