Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645533;
	b=pVfLnhuCqOCLQKzcwsKB4/7w1E7nyTtDMEoJSv1JwOuBfKGsJRmogmP8ffdT+BGX4HqW
	 KOSTPw4pRy6jMJ53OU5AV0bJhAtYKNk1OUtH70fUcrt+pINvDR3s7EijaIW1HVsHp5qIn
	 8iSM5hlH6YhkG8jS8xzXKETycNnuroinZtUrPm4OYJWIFQCk2DIaGkIBo38smSSBGT1dG
	 l2+fmn8tINHG049xNzmeIZFaN5LaXcn5g1rdJS4Tv70tPRHk9uv/hzWZ4N9QLU1O4x9IB
	 wqWltELwu/sBciLcKbloWzFLFVWdeX8T9oHmVOFxH0JVt55VudtWKlaljruPi52rtNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=AOwnGeEvMBKI7TRyjGtfXvp7wm6CBN9E9DeU964AMeM=;
	b=E/KWG+e1XDpczFaGoS+Ae8eyiYBMdSlU0ZfgIxUpPNqpkqN53duN9XOylJaK7FGnLnM6
	 GK7c2a7LUw6wLZax/4MDLgu34z6A72tKDkVugAZXpxYhyq6xl106YhLRdlc+dALWok447
	 R/Qz3V0Ou716fICRF+P12MgIKigHeoMATNiI74xMJM8uWKpNIi5AMSm6TzqtAPWXXdKFf
	 YhrF/XuDMNWtg9/F+rruDXI/1z3uN5j5eKCa8cGp7/N4HxGzrXbSDDGYV2gQe2l4yGkmi
	 QaG8jypUwiiHYEk7EQNSgMBoPkp3XiXcu06d5dnB7A8jc2cKtsQGx0K8lStodvEohig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N+NGbYVl;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB5B60A383A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EB5B60A383A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N+NGbYVl
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-154e9d2d94fso1838009c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645532; x=1796250332; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AOwnGeEvMBKI7TRyjGtfXvp7wm6CBN9E9DeU964AMeM=;
        b=N+NGbYVlBfL98IPFmKAjC1XYyQvnY5lprM97Pumr2c0OOHqIaUitEFRHxM5XS662R8
         jwdsuuDJig/pZiFY+GhpPUIhX+5boAMy94bl+TZ5XkNceFAAb03PYkGPLstnTY9PXTEr
         IYgJHGLd8pd8vXE9IZHU4fgICZIIUOEqTH3dPS0/OIbTq3l/vXsCRMjj+N6gec8+6D2c
         DgavwgOWhOw1Jc9yWh3es+caQw7J+wYzHC5wVCuT3dkpfqImG12php2IcV97KyXMJx+O
         pLT+wzRcC9GGW49lvglEUL1QFphEFfsvncZZ/2RZtldsgHI5Dr6Bjo6mMQaVKDcwYHfC
         /Miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645532; x=1796250332;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AOwnGeEvMBKI7TRyjGtfXvp7wm6CBN9E9DeU964AMeM=;
        b=inwRBm5Mm0+zezEpJKt1pV2BJcLxAAKUBgdd8BlyAiJsXUfhnObr2+Bis1LkgP1cGk
         ANpSYe1Tz+QP4FPQhiEq8rJEPthqKhNSYGIAryjJwwYcXbsR9d6AK+urVQOP/Y86lPo/
         +lnNasq4r9hY2WRa6/YakDPiKXYHUQ7xqUzyv6Q0RaxPLoXGQkDaF3ZBxIdYmsrPZH2K
         aPF4GFd3QQUcPhwruSYgkPXak7ozWx2ADc3qwywGglBzWs6+MZMh742TXv6G7A6wQQ1c
         O+2eBS/fzhF9ExXDbPrXkgOC0iHsZ6L74VdQw6C6YE7QjY6hFf6bG9oeWD14qm1s1aBP
         lJaQ==
X-Forwarded-Encrypted: i=1; AL+hErG7a4oGaDIoBONT4/JaV3ttg0pxTNXAp9Ye7dyCpztgP+gOxWZZpy8p9fVPC+DRpRtaZsjCqvQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bOPn1s7zOB1b3+rbA4LFcfsH7Rvq9S/PkdAG8jcM0WTNuGviB
	ra5c5v/NVdEikCvsoCM3Iy0kFTgHZfnxsztCcF1OyxaARZ8Q+gpXeADhBa4WrMWuOpy0gHnPaS4
	6dA==
X-Received: from dldz4-n1.prod.google.com ([2002:a05:701b:4184:10b0:1b3:af3d:1632])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ed02:b0:149:50cb:2175
 with SMTP id a92af1059eb24-1b5568fda53mr18476947c88.33.1795645532051; Wed, 25
 Nov 2026 14:25:32 -0800 (PST)
Date: Wed, 25 Nov 2026 22:25:11 +0000
In-Reply-To: <20261125222513.1446099-1-elkin@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125222513.1446099-1-elkin@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222513.1446099-2-elkin@google.com>
Subject: [PATCH 1/3] drm/sitronix: st7920: Use DMA-safe serialized TX buffer
 for SPI writes
From: Elkin Cruz <elkin@google.com>
To: Iker Pedrosa <ikerpedrosam@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In st7920_spi_write(), u8 reg[CMD_SIZE] is allocated on the stack and
passed directly to spi_write(), violating SPI DMA safety requirements
when CONFIG_VMAP_STACK is enabled or an IOMMU is in use.

Embed an ARCH_DMA_MINALIGN-aligned TX buffer at the end of
struct st7920_device protected by a DRM-managed mutex, and pass
st7920 to st7920_spi_write().

Fixes: 88b09229f34a ("drm: Add driver for Sitronix ST7920 LCD displays")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---
 drivers/gpu/drm/sitronix/st7920.c | 43 +++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix/st7920.c
index 616d83387d31..091e80d8bda5 100644
--- a/drivers/gpu/drm/sitronix/st7920.c
+++ b/drivers/gpu/drm/sitronix/st7920.c
@@ -7,9 +7,12 @@
  */
 
 #include <linux/bitrev.h>
+#include <linux/cache.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
@@ -24,6 +27,7 @@
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -86,6 +90,10 @@ struct st7920_device {
 
 	u32 height;
 	u32 width;
+
+	/* Serializes SPI command and GDRAM transfers using tx_buf */
+	struct mutex tx_lock;
+	u8 tx_buf[CMD_SIZE] __aligned(ARCH_DMA_MINALIGN);
 };
 
 struct st7920_plane_state {
@@ -165,16 +173,21 @@ static int st7920_store_others(int cmd, const void *data, u8 *reg)
 	return i;
 }
 
-static void st7920_spi_write(struct spi_device *spi, int cmd, const void *data,
-			     int delay_us, struct spi7920_error *err)
+static void st7920_spi_write(struct st7920_device *st7920, int cmd,
+			     const void *data, int delay_us,
+			     struct spi7920_error *err)
 {
-	u8 reg[CMD_SIZE] = {0};
+	u8 *reg = st7920->tx_buf;
 	int size = 0;
 	int ret;
 
 	if (err->errno)
 		return;
 
+	guard(mutex)(&st7920->tx_lock);
+
+	memset(reg, 0, CMD_SIZE);
+
 	/*
 	 * First the sync bits are sent: 11111WS0.
 	 * Where W is the read/write (RW) bit and S is the register/data (RS) bit.
@@ -190,7 +203,7 @@ static void st7920_spi_write(struct spi_device *spi, int cmd, const void *data,
 	else
 		size = st7920_store_others(cmd, data, reg);
 
-	ret = spi_write(spi, reg, size);
+	ret = spi_write(st7920->spi, reg, size);
 	if (ret) {
 		err->errno = ret;
 		return;
@@ -232,14 +245,14 @@ MODULE_DEVICE_TABLE(spi, st7920_spi_id);
 static void st7920_power_on(struct st7920_device *st7920,
 			    struct spi7920_error *err)
 {
-	st7920_spi_write(st7920->spi, SET_DISPLAY_ON, NULL, 72, err);
+	st7920_spi_write(st7920, SET_DISPLAY_ON, NULL, 72, err);
 }
 
 static void st7920_power_off(struct st7920_device *st7920,
 			     struct spi7920_error *err)
 {
-	st7920_spi_write(st7920->spi, SET_DISPLAY_CLEAR, NULL, 1600, err);
-	st7920_spi_write(st7920->spi, SET_DISPLAY_OFF, NULL, 72, err);
+	st7920_spi_write(st7920, SET_DISPLAY_CLEAR, NULL, 1600, err);
+	st7920_spi_write(st7920, SET_DISPLAY_OFF, NULL, 72, err);
 }
 
 static void st7920_hw_reset(struct st7920_device *st7920)
@@ -257,10 +270,10 @@ static int st7920_init(struct st7920_device *st7920)
 {
 	struct spi7920_error err = {0};
 
-	st7920_spi_write(st7920->spi, SET_BASIC_INSTRUCTION_SET, NULL, 72, &err);
+	st7920_spi_write(st7920, SET_BASIC_INSTRUCTION_SET, NULL, 72, &err);
 	st7920_power_on(st7920, &err);
-	st7920_spi_write(st7920->spi, SET_GRAPHICS_DISPLAY, NULL, 72, &err);
-	st7920_spi_write(st7920->spi, SET_DISPLAY_CLEAR, NULL, 1600, &err);
+	st7920_spi_write(st7920, SET_GRAPHICS_DISPLAY, NULL, 72, &err);
+	st7920_spi_write(st7920, SET_DISPLAY_CLEAR, NULL, 1600, &err);
 
 	return err.errno;
 }
@@ -296,8 +309,8 @@ static int st7920_update_rect(struct st7920_device *st7920,
 			data_array[array_idx++] = line_buffer[j];
 		}
 
-		st7920_spi_write(st7920->spi, SET_GDRAM_ADDRESS, &i, 72, &err);
-		st7920_spi_write(st7920->spi, SET_GDRAM_DATA, line_buffer, 72, &err);
+		st7920_spi_write(st7920, SET_GDRAM_ADDRESS, &i, 72, &err);
+		st7920_spi_write(st7920, SET_GDRAM_DATA, line_buffer, 72, &err);
 	}
 
 	return err.errno;
@@ -309,7 +322,7 @@ static void st7920_clear_screen(struct st7920_device *st7920, u8 *data_array)
 
 	memset(data_array, 0, BYTES_IN_DISPLAY);
 
-	st7920_spi_write(st7920->spi, SET_DISPLAY_CLEAR, NULL, 1600, &err);
+	st7920_spi_write(st7920, SET_DISPLAY_CLEAR, NULL, 1600, &err);
 }
 
 static int st7920_fb_blit_rect(struct drm_framebuffer *fb,
@@ -812,6 +825,10 @@ static int st7920_probe(struct spi_device *spi)
 	st7920->width = ST7920_DEFAULT_WIDTH;
 	st7920->height = ST7920_DEFAULT_HEIGHT;
 
+	ret = drmm_mutex_init(drm, &st7920->tx_lock);
+	if (ret)
+		return ret;
+
 	st7920->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(st7920->reset_gpio)) {
 		ret = PTR_ERR(st7920->reset_gpio);
-- 
2.56.1.839.g22a8290db9-goog

