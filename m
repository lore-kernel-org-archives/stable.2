Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A183EE1C3
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791627422; cv=none; b=uWK0lE4cQUZYP9qQdt+v7FWmnKYNshIt6u04574+pmqR/nATveVF0AsISgsm7+JrAMIaBkMKLx6KEbBlzvlnQeErKjvnKlJK6S9bH1o5EX0HBpYBB+LHJndePssB9PGIphtT6Jw2NWm550/N/mPg2Wvbl/V6qt7il5ELI2r2lzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791627422; c=relaxed/simple;
	bh=vmMrai/SZHWfjpubrhmvNZYZ2tmXfd2uKqkrZBhCMj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WX02ok4VnhP8ATL87aF09qmuJknbM75Eoi5v+ICrPEibkzJfiz0W6TEckYa9VO7pCWVhf3kUBSYBNOPYJJQOv0lY8Eq0F7uwvopaU3Pgz88KoayonVL44Xpnn82J3fP4C0Y74ET0hgoryTnsz3fF5KrEC/ZEtOZLn8cTRhAUcS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImA1fi7n; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImA1fi7n"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48b042c0728so86369f8f.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 03:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791627410; x=1792232210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yyaHXbmIQ7chKBwYcW/anldepruSkhnw3Mp3qDjouh8=;
        b=ImA1fi7n+XdMirxe3q9Ap09ai0W6LTkCdufJd177sCP2TTuohTbROPxc3ZqxHOFEXo
         A5oW6diohPBDWJpvhDWgLC4cg6MvJZjHZ4RopxLJUQ9T6FDSUlJkQ0knHhydUpwaP4Rg
         7u7k/an51Oy0udCazGGS8vryd2nu/wJNzWkbdO+J6W9Y4/EdQTj+SoCw0dbQRZHcFmep
         udCjDF1CY7uQlOxMBU9/b2mjwVa2Fjk3waikbmVKpPnprDS/loIr/o4czEfpZpvSn6xF
         Gb7zfuvvL+2YQfDzrqHoS/zkmkBw1lzfBDosofWm5lF1OLdIgJEOJF/6ydpWsitciLNM
         ElJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791627410; x=1792232210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yyaHXbmIQ7chKBwYcW/anldepruSkhnw3Mp3qDjouh8=;
        b=Sqvfs+FYX9xgPlRQq6TCEP/XRXHrprexcLpwiGpb1KJc7uVdrmVuXVAODT3Wv+kCZa
         MeVyFdFyy91hVJhSRGkG3PyT2WlW7UF62GMBC3kVK7NNnJ4al1Z62R5EufI7t6WN7SHT
         rYyR2UvUaAaOUT9m70R4SsHRRCMWmxbPkKIXtISfTEJm7KUf6OpxgwEMAyMa9VLK4Dqk
         R2o3Jsz2c0Hyuk1PKZn905vtXYF1ruj28nRMn+Gaya2ede0Ret6h8jmu+gncetTfGQtP
         t2n02CKGvr5Os5w2xOwdACJ+d+UB4IQyF4W1mVG1ge+0ZDfuGYN8NfXDYOPgTzAd9fOQ
         dliQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYBdRU2TxK3YCc6Tt81PbQFY4WYfG+LurEWepLKqo9zB6r3nMfygH0ei7LErrN8xG+iX27KdQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVnsq1+GUieKN71g61ouW6Pfw0/W/tfX9KnqMNydre9PXcZW+m
	8a7XebbRlYWLlItiZXaXYbobsvHcw75/GnruYckhht8a+DW13K4QQMPl
X-Gm-Gg: AYBFou0VRopiye+gTVvX0VpWguBfbHlJzc+8taQL9I3IMbjvFkUasx7sW7ml6SU8uyP
	sparNemqtoh3WM6e4iFTXVLKW7KDjeJbYTr5twllVIBdEQBD1ILLVAZ9O6ZfkRMhOGVr/sK6A6D
	M9GFBq2W8H5hnhj2RT9JpPSb65CbCwn1xe1KV+Ge9HUbvpYB18ARh6P1SI2jlVA/pDClXVUE6s4
	XcPbEcp9BB2Wsc9F8bo0wscHo18XcxzV79IRPhkVxAJ0YH+qoZ8dj8nsOOtCi29UNhQ3HTlNaaN
	pbmFOCSyDjFFHL2N87QdQthjexVc1jKOXX4JL+1wTEzvlpFFoeQ0Xmpn8s+CnHI4YguiOWBqeGm
	ix1hzX2q69wB+HULJqkm787Fu5PE6U9UoEKfz8vSuMIbXrfAttSTTbrHWPpz3yYNv6lAzAS3F6/
	goxMpKHAiAQNBTEYIRt3pfvzEi9p/Kfz2mS7mC+yuyUdsiqn1jn6rHkZd9sbk=
X-Received: by 2002:a05:6000:2f89:b0:488:89ed:4430 with SMTP id ffacd0b85a97d-48dbacdfc52mr8738925f8f.33.1791627410079;
        Sat, 10 Oct 2026 03:16:50 -0700 (PDT)
Received: from ASUS ([85.105.252.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db98c38f4sm9417856f8f.27.2026.10.10.03.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:16:49 -0700 (PDT)
From: Bartu Alev <bartualev@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	luke@ljones.dev,
	denis.benato@linux.dev,
	benato.denis96@gmail.com,
	corentin.chary@gmail.com,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartu Alev <bartualev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/5] platform/x86: asus-wmi: fix TUF keyboard power state shutdown naming
Date: Sat, 10 Oct 2026 13:15:58 +0300
Message-ID: <20261010101601.888709-3-bartualev@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010101601.888709-1-bartualev@gmail.com>
References: <20261010101601.888709-1-bartualev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/platform/x86/asus-wmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 5adf7a289f82..5cc71bfac841 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1119,10 +1119,10 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
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
@@ -1135,7 +1135,7 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
 		flags |= BIT(3);
 	if (sleep)
 		flags |= BIT(5);
-	if (keyboard)
+	if (shutdown)
 		flags |= BIT(7);
 
 	/* 0xbd is the required default arg0 for the method. Nothing happens otherwise */
@@ -1149,7 +1149,7 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
 static DEVICE_ATTR_WO(kbd_rgb_state);
 
 static DEVICE_STRING_ATTR_RO(kbd_rgb_state_index, 0444,
-			     "cmd boot awake sleep keyboard");
+			     "cmd boot awake sleep shutdown");
 
 static struct attribute *kbd_rgb_state_attrs[] = {
 	&dev_attr_kbd_rgb_state.attr,
-- 
2.56.0

