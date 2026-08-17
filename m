Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD155279903
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980389; cv=none; b=asK6YYmQm+FEPh92+GKf+x3VcynNu/cr4uhq7xEdJ5vv3GsjEDKk/wVF5vZqz6Boe68h2T2VAeuCeMicg8vnaEVkpJqWrCDN9RRcA5En0GQJg5QwbURpT9GqD/KMeF5KDlPfwgcmo3HwmDhpwC0vrCK8gB+oQse3XJBZXdRVmkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980389; c=relaxed/simple;
	bh=LJWoRfPHE2+lG419s20SuhMDSMRW1EUgE3Gji521P14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dyDHYjw0clJNG97mQs9NlwCEqEueDlMD/UQFqJQHUpPr2Rf5IZnGcA3nhZYi7T8hj5c68LQGI67Zwjgud4ynyMuIWqmw8wI8I1URtQm9hu2dLIHTFlNSif/P9ik9BvaHw2FqYKfWl4VMFkjGhYiJWZeFYDTyNMVJ+zP3Sbm0XjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdiCinDK; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdiCinDK"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8f1e274ccb9so16579156d6.2
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786980387; x=1787585187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5H9dh4FxhaHEHhhWqbPHlAZDZeIrPiXZx4M8+NdC4qg=;
        b=WdiCinDK1jdpT7Lr7PqowvdxC9LgwhK/mPsxlll4pStduH2bLf6eid8P6UmKvWTFJw
         xuhudqu1ui6C5Y8cj2Sx7ugq650Fl+xxmCZLIbQVCx4QPJnY9hvhyVp3IPBoVK/IJoRx
         K5yTDyrcXUACPndX8oIr38daoidElfM7QDdmcM7lP5HwNVwlar1m8RbUfhjbdzUjNCDY
         Vr8wxAP1DZU8KlJYEplMECRQ6rIeAhCM4XnRlRGAh6R/+iUlQxhF6a1OyGeYUnTh3rgN
         isXmYiL7n+5kzQFqka26G9Dg63fbwkmVUk6SbtEvuM6aNVfZ1BwXr2Jx+djX9Wz4QfOV
         ECiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786980387; x=1787585187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5H9dh4FxhaHEHhhWqbPHlAZDZeIrPiXZx4M8+NdC4qg=;
        b=Alq/i7TKMFzGnV5rA2VPx5JZv9QfocJze/f8EhgkYUWP/ofwlszGq3ttyQVybBtizm
         U8+ZjusrwHbtJ/W6RqUYZnh4vu528PL4wFMnlr1DmXijoejCbegIcYdCRVgkldllFpW4
         kbkzwAH70sGkNmJ7roWnOHempnJhAnKQmiDpeI+9A1wBnrYfaMX8c4D+8vThv0kQAcg/
         QjqCAk58bnn5gM3WtQpwAPFQWLFHPTqiVu3snMzGi0rM2S9iVL36YzGa8DuP+O0NTUTK
         hQ4+l9R5+NpMgV7Ld65OeZHLYjpjF0A25Xs23O1PI/Eg1BeIQVSDNWQbrWDR7SxEabRR
         KxoQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQC8rWqcS0RsBHXIafPAn5lE3qCGyd2FNZLZh96tBiAji86y+7odKmSpf/E2dK25/8oNpkOFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlmNzjZ6Dkw9ktKJhMY5IMcO5fdRmVOxdPgI3vOz77HkBIY41c
	kJk/tOWT779l+Ry2z0bPmaSy6ImnfivsavdkX1shbqO51TGx71SXHJHq
X-Gm-Gg: AR+sD13ErVrver2jGNja5g++vF0LosVZpZ+qXPIUXNxijkxSkr0H8CGGBsMu4TRiETv
	L5mCFGKEeyWOYmKIk2Ys4sQ1u7TlozG+yd4exvrVwhUOAh5xrLm7+4dXUohT3fRA3W8UCE2vHkX
	Bx6tt+21t8AkqzK5NckmWiZyUm8CUpktpc75Fg+SkXz8vcQAnNwcbTcuAThMhbLT9aDkjeAbdij
	qTMT0vQEK8eZaJUBdozC1l2YQ8H+P93NuI2lFncAVmlAgSsrSlGSJYQIxJ+VJOXVEVcDNOJlGPo
	lpK7wEnAKUEz6RLIUPsXH+pl6U+JOaDkj3unWqth2b+BvEI4hk+gJg95LaFqCA6Y+wHNFP65RXT
	1i/qWS8/3yRknq2eDi+GyLBgRb7GBgwjZgHHt9Cs0VBFEM8nTEvFCM7x9ogQqLIkgZlVqj+29cF
	3d1VxR+yXNeiMbFIpnbHR567CIV3BDzrS2pl0RyP2MLTTzWtO46Qe5YfE+ITn8w5xK8vboiHIdF
	srw8yajyz5/49vigMVhFlkZUMXeONgoMm0XOPjOiQ==
X-Received: by 2002:ad4:5cce:0:b0:8df:98e0:4594 with SMTP id 6a1803df08f44-90a91d5fae4mr262527506d6.15.1786980386455;
        Mon, 17 Aug 2026 08:26:26 -0700 (PDT)
Received: from holowork.tail3176d.ts.net (static-68-235-46-81.cust.tzulo.com. [68.235.46.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c45950413sm11070806d6.35.2026.08.17.08.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 08:26:25 -0700 (PDT)
From: Fabio Piparo <holofermes@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Amit Barzilai <amit.barzilai22@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Fabio Piparo <holofermes@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/ssd130x: Set the address window in ssd132x_clear_screen()
Date: Mon, 17 Aug 2026 11:24:59 -0400
Message-ID: <20260817152500.703770-1-holofermes@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ssd132x_clear_screen() sends its zeroes without setting the column and
row ranges first, so they land in whatever window the last
ssd132x_update_rect() left programmed. A partial final update then
leaves the rest of the screen uncleared, with fbcon the last damage is
typically the cursor cell, so blanking keeps the console content on
the panel.

Set the full-screen window first, as ssd130x_clear_screen() already
does.

Fixes: fdd591e00a9c ("drm/ssd130x: Add support for the SSD132x OLED controller family")
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Fabio Piparo <holofermes@gmail.com>
---
Exercised on an SPI SSD1322 under local enablement patches for that
chip; compile-tested only on the SSD1325/1327. ssd133x_clear_screen()
has the same problem, left alone here for lack of hardware.

 drivers/gpu/drm/solomon/ssd130x.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 0b0fc6fe3df..256d370e240 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -900,9 +900,20 @@ static void ssd132x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 {
 	unsigned int columns = DIV_ROUND_UP(ssd130x->width, SSD132X_SEGMENT_WIDTH);
 	unsigned int height = ssd130x->height;
+	int ret;
 
 	memset(data_array, 0, columns * height);
 
+	/* Set column start and end */
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE, 0, columns - 1);
+	if (ret < 0)
+		return;
+
+	/* Set row start and end */
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE, 0, height - 1);
+	if (ret < 0)
+		return;
+
 	/* Write out update in one go since horizontal addressing mode is used */
 	ssd130x_write_data(ssd130x, data_array, columns * height);
 }
-- 
2.43.0

