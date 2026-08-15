Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C813E5597;
	Sat, 15 Aug 2026 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786791607; cv=none; b=Fk/JWmB4+MGOm26eqwJ/O3XIJkDulDdDeHfiXvndO1NglpG0bpLyKbjoMoz76BGGyuYyaGISyl9xHw9luN9rW+hiT62R0xMnEM5K1eMTWoXh5kvv+WTAlutHdJDllxLjHWyTqYmwfOJrj0BM/U2+l4HU7K54ZiIDuwr569gVLms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786791607; c=relaxed/simple;
	bh=IxQYtUnxC7ypQ0W3xXA9a4Tw2ArFtk+Pme7EPeFhlfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WWuLyqS1nrsWF2ylBvw7KWpLxPKZFr2dB37l+zHBlz53HQiLDQWjGoq+oKBEkrTdgPWWQqhNd38sxCbvv0sDnkBzDTGsDr1VTmNyXlvHUXnqnLwDuHz2JNYNecsYmMoIu+MmZG+dfGaEtTxlloh5fZa06b8tIPyi0LQB1bJD/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Bl83rdnU; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Bl83rdnU"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.46])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a18d00a4;
	Sat, 15 Aug 2026 18:59:52 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Andy Shevchenko <andy@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	Lars Poeschel <poeschel@lemonage.de>,
	Willy Tarreau <w@1wt.eu>,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH v3] auxdisplay: charlcd: cancel backlight work on registration failure
Date: Sat, 15 Aug 2026 18:59:50 +0800
Message-ID: <20260815105950.1109-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa00513ff8003a1kunm8a5f04f88811d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTElMVk8YS01LTk9JTB4ZGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VT01ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Bl83rdnUa6Qctt7FzHoO3wYAaWTbLb5wEbZwa5BVdOPbS6UqNRe+iGdp5i3kkvcy+Qr2xMYfiLAeHDKNkh/WS5JwBHVEjLGZV3ptW9CiQYiKw2BTTzuCspmV49P3xvHaXX33z/YF8YtkDZAn1AqsXqG4yYefDAJHIF/fYbdzNZo=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=mPNWPXZxtyUvG3jAFyp2u/hbL/X9NiQFk87ViIjDq6o=;
	h=date:mime-version:subject:message-id:from;

With CONFIG_CHARLCD_BL_FLASH, charlcd_init() schedules bl_work before
charlcd_register() calls misc_register(). If registration fails, the
caller frees the charlcd object while delayed work still contains its
address.

Add charlcd_deinit() to cancel the delayed work and turn the backlight
off. Use it for both registration rollback and normal unregistration.

Fixes: 39f8ea46724e ("auxdisplay: charlcd: Extract character LCD core from misc/panel")
Cc: stable@vger.kernel.org
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
Changes in v3:
- Add Cc: stable@vger.kernel.org (Miguel).

Changes in v2:
- Factor the backlight cleanup into charlcd_deinit() and reuse it from
  charlcd_unregister() (Andy, Geert).
- Add the Fixes tag (Andy).

 drivers/auxdisplay/charlcd.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 09020bb8ad15..ae2692ec3963 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -595,6 +595,16 @@ static int charlcd_init(struct charlcd *lcd)
 	return 0;
 }
 
+static void charlcd_deinit(struct charlcd *lcd)
+{
+	struct charlcd_priv *priv = charlcd_to_priv(lcd);
+
+	if (lcd->ops->backlight) {
+		cancel_delayed_work_sync(&priv->bl_work);
+		lcd->ops->backlight(lcd, CHARLCD_OFF);
+	}
+}
+
 struct charlcd *charlcd_alloc(unsigned int drvdata_size)
 {
 	struct charlcd_priv *priv;
@@ -654,8 +664,10 @@ int charlcd_register(struct charlcd *lcd)
 		return ret;
 
 	ret = misc_register(&charlcd_dev);
-	if (ret)
+	if (ret) {
+		charlcd_deinit(lcd);
 		return ret;
+	}
 
 	the_charlcd = lcd;
 	register_reboot_notifier(&panel_notifier);
@@ -665,16 +677,11 @@ EXPORT_SYMBOL_GPL(charlcd_register);
 
 int charlcd_unregister(struct charlcd *lcd)
 {
-	struct charlcd_priv *priv = charlcd_to_priv(lcd);
-
 	unregister_reboot_notifier(&panel_notifier);
 	charlcd_puts(lcd, "\x0cLCD driver unloaded.\x1b[Lc\x1b[Lb\x1b[L-");
 	misc_deregister(&charlcd_dev);
 	the_charlcd = NULL;
-	if (lcd->ops->backlight) {
-		cancel_delayed_work_sync(&priv->bl_work);
-		priv->lcd.ops->backlight(&priv->lcd, CHARLCD_OFF);
-	}
+	charlcd_deinit(lcd);
 
 	return 0;
 }
-- 
2.50.1.windows.1
