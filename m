Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67AE49B1E1
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327697; cv=none; b=toZ7wRm3CfE6IdVaTbhd882XfqOzF6LJDCDpU4waQimUGrQ4jVgsRNZ5M8Bv3SSDdyhbopQY1H6BaP4kSkUD/Nkc1PEXeT/p75OlD1U4tEF9BSKkIj2pgdVryLd7WttKCv+HwWJGiR0kjNCj/EdjiAS1FW74E8mar9a8VuW1P3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327697; c=relaxed/simple;
	bh=WHfKqs47WRFyxZKZD0j330jkPnh+adg61QI7v5/oMMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2CHmPLMH+kBaPzfR13h8n3xx3gm7tyf9sVt9dbSWhqaOqQkujBWWTJ9QFrPfdbE69PQdwfRFoWEUK9gV9yoao7DdMvZJ31Fs0YGzFF/SP8BNnlQpkslWr/hepZh3kTvSZ0gfZet2eU/tkU5Mswca2pDiZSwEC2hhuNMwFOkSXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XToaIPoT; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XToaIPoT"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-89f639ba307so405340b3a.3
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792327694; x=1792932494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lm6hadMr/YvEaZWMdI0VsBY5S1pV7Un37ouu2piB0RE=;
        b=XToaIPoTxj5rRiFL8x9PFh5WFfwqI3CaLeWiGUKM34jAtLJ9pa1Hzzc6sm6/ceVafF
         Dsh/MYkZVjwqqivf4k0nWZDwMyd/NPwOuHCONKWfGy+MlHFUjPa8Iu9n2nr3uofyQ+wz
         NA9BA2xg7snI1BtQAJG7NAz8ouy5HCyItCEMQiKQdVC1Lzj1yocMfoIfpuTa8r0/IYuy
         pqhNL1+Gzk7xQLrLroGue28vMgqSJW+VlC/TVUS9OdN6haNqODhH7oWp8VFDVu3lKW1f
         DVnUj1RCc+E/gsM+dGCPSIkCLBVkFTd6aQUQTaqaHNvxYhwfPCMLB7lRni87kCtuoolf
         VJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327694; x=1792932494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lm6hadMr/YvEaZWMdI0VsBY5S1pV7Un37ouu2piB0RE=;
        b=0JWG1fLdvTniPMNakkOAuTDb+fCdZUzJ52+qs8NkDF3KzuUVPm6xKIWguIlduR0mKk
         hDaASyIf+c0Za0Gy0UT85W1pt2OoPsyOMTu6rApAxzyDBe8y3kxyvTnbELWV/nNX5p4/
         0s/+A6l9kSACmj8K8gzysnXpWzaKzZJKz33jUW7SSdZbZADt3RcJAZA1sLa7hNxTGEAr
         oX1dc1n2XtrhFu55iPcsZP3FFKryZAo9DMy+dWLP2M1nBJGBeV5wZO1Grfsyfpo8KhkX
         8JnjaMFTlxPB8Bz9h0bodasqUkFboWOK4aHHtA8sZILoLZ6DkC6nZNB/wYoSRul3j82D
         UHpQ==
X-Forwarded-Encrypted: i=1; AKwUvByDiryAMyj4R8+RjNvWDxzs60fiI8VAip5WEXYA5P3Na2mt9E5dHQnLQ9Z0TerX5byKX1MWfEs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJimWHK4kTngfUrJoTzQIbXWvh1Mk4pLjK/YG5+romt5ZEQulpP
	Ii0FCqc3fksqOjxSKKx986Wo/dTQmI1ZufemQwEDz6fmaW8isVjK7XVD
X-Gm-Gg: AYBFou2m7aPkxu305UGo5YN6nQLsglpBsYjxeqwQSECuBwLiFAnVfLmANGKHQYrAvME
	P7lw82xpcOSidnOd9YIx/0XSEGbf00ESnX1oxOHw5aubfeL4m9yzJc8Xfzi0BIyk6qCkqH11Kjy
	Jms3HjHU2LR/9DvNl2Hw5FJ7LUjFF9UXmgPugRdyVGkoMbI/rxa23M3JMxAAYSJv9x1UYMtqZBm
	HuNqjKexZOUKZnTOlXc4sS8JE0UPS8m5/IVRQWMw2kOPIFcZGVKPLITO7G47Qsj17boDqVn8iA2
	LmxTjLGtDnZnUGTbvvnITx2ccAp6Ms6VqgGXvEqNYDC89PYkQoDu/751PTtZRwzfTYIKqUWaOkr
	t4eEqSjXYIpbeQhTw3hdoirwmjpyTKZti/hyQEG15bsjYLtjGMuj2YBupqcUm3b3LABeKfRIo9O
	1eL/tb78FhDYZpZfSOML0eAOnmzWa+ZXtqNOFiEPhafUwv703M2A+M/O/0Mr+N2I9+lR3M9PrZz
	xS63/knPIpcHD3Rt06p50b3XFiHkMHz6g==
X-Received: by 2002:a05:6a20:2591:b0:3e2:4c65:5905 with SMTP id adf61e73a8af0-3e24c655b0cmr425923637.60.1792327694156;
        Sun, 18 Oct 2026 05:48:14 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549ee946sm2804669a12.20.2026.10.18.05.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:48:13 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v3 4/6] HID: wacom: add NULL input guards to wacom_intuos_bt_irq()
Date: Sun, 18 Oct 2026 21:47:53 +0900
Message-ID: <20261018124755.850888-5-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018124755.850888-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018124755.850888-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_intuos_bt_irq() dereferences wacom->pen_input in every switch
branch, both directly for dev_warn/dev_dbg and indirectly through
wacom_intuos_bt_process_data() which calls input_sync(pen_input).
pad_input is also used in wacom_intuos_bt_process_data().

Both can be NULL when the corresponding setup_*_input_capabilities()
returns -ENODEV during a successful probe. For INTUOS4WL, pen and pad
are always expected together, so guard both at function entry.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 drivers/hid/wacom_wac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 65829de86363..e0bf03123cf9 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1263,6 +1263,13 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wacom, size_t len)
 	int i = 1;
 	unsigned power_raw, battery_capacity, bat_charging, ps_connected;
 
+	if (!wacom->pen_input || !wacom->pad_input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: expected pen and pad input devices\n",
+			      __func__);
+		return 0;
+	}
+
 	switch (data[0]) {
 	case 0x04:
 		if (len < 32) {
-- 
2.53.0

