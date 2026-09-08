Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE62C53CA80
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870043; cv=none; b=Y+x0aYsYfxNEHlOvF5lp6oyGRkOLwWUF3vESMaIIqI3wq3Mtj7/r24M0k6VqWqjd/QYbbYWeRAShCZcq7M2OU8xeUlP0kSx5RuWAeM0ytiSUwLUYr0ehjJzrU+TkJJznTqPsc9T5f2abzG3v11o4N+rk06LxkvFiBP3LnWbaGOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870043; c=relaxed/simple;
	bh=7d92Rq+AkvbLc/nbYHj8CfqM3M1dwYqZ0A0+rgWp3tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDkL5KAcmJMkFJ7DMZJUenjmlkyvOPWSKNRtBbQwHE7/k2FRb77Ay7AMS9xl8LywxSjs/TTMNAuBsUuFEspzaMOAp4sunkQE2vhxzZhR9QYKloOyE4ftO7khc71A6QUV54IoVSi/elaeLpyW6T1i44OmyGFs0AI3RU+Q8QhmZMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A1D1F00A3F;
	Tue,  8 Sep 2026 12:20:36 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lars Poeschel <poeschel@lemonage.de>,
	Willy Tarreau <w@1wt.eu>,
	Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] auxdisplay: Move init_display to hd44780_common
Date: Tue,  8 Sep 2026 08:20:33 -0400
Message-ID: <20260908122034.2053198-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090350-stencil-mud-1d68@gregkh>
References: <2026090350-stencil-mud-1d68@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lars Poeschel <poeschel@lemonage.de>

[ Upstream commit 01ec46dfa633a52ccfe38d4a194460d6adb2ba00 ]

The init_display function is moved over to hd44780_common. charlcd uses
it via its ops function pointer and drivers initialize the ops with the
common hd44780_common_init_display function.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

[ stable 5.10: The hd44780_common infrastructure and the prerequisite
  refactoring series are not present. Drop the init_display move and carry
  only the charlcd backlight enum normalization needed by the follow-up fix. ]

[ sashal: Reduced backport -- upstream 01ec46dfa633a touches 6 file(s), this
  backport carries 2. Not backported here:
  drivers/auxdisplay/hd44780.c
  drivers/auxdisplay/hd44780_common.c
  drivers/auxdisplay/hd44780_common.h
  drivers/auxdisplay/panel.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: e3e3bf40916c ("auxdisplay: charlcd: cancel backlight work on registration failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/auxdisplay/charlcd.c | 6 +++---
 drivers/auxdisplay/charlcd.h | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 5aee0f5463514..e74e25ff030b2 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -124,7 +124,7 @@ static void charlcd_bl_off(struct work_struct *work)
 	if (priv->bl_tempo) {
 		priv->bl_tempo = false;
 		if (!(priv->flags & LCD_FLAG_L))
-			priv->lcd.ops->backlight(&priv->lcd, 0);
+			priv->lcd.ops->backlight(&priv->lcd, CHARLCD_OFF);
 	}
 	mutex_unlock(&priv->bl_tempo_lock);
 }
@@ -141,7 +141,7 @@ void charlcd_poke(struct charlcd *lcd)
 
 	mutex_lock(&priv->bl_tempo_lock);
 	if (!priv->bl_tempo && !(priv->flags & LCD_FLAG_L))
-		lcd->ops->backlight(lcd, 1);
+		lcd->ops->backlight(lcd, CHARLCD_ON);
 	priv->bl_tempo = true;
 	schedule_delayed_work(&priv->bl_work, LCD_BL_TEMPO_PERIOD * HZ);
 	mutex_unlock(&priv->bl_tempo_lock);
@@ -862,7 +862,7 @@ int charlcd_unregister(struct charlcd *lcd)
 	the_charlcd = NULL;
 	if (lcd->ops->backlight) {
 		cancel_delayed_work_sync(&priv->bl_work);
-		priv->lcd.ops->backlight(&priv->lcd, 0);
+		priv->lcd.ops->backlight(&priv->lcd, CHARLCD_OFF);
 	}
 
 	return 0;
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index 00911ad0f3deb..993f03652f2a8 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -9,6 +9,11 @@
 #ifndef _CHARLCD_H
 #define _CHARLCD_H
 
+enum charlcd_onoff {
+	CHARLCD_OFF = 0,
+	CHARLCD_ON,
+};
+
 struct charlcd {
 	const struct charlcd_ops *ops;
 	const unsigned char *char_conv;	/* Optional */
-- 
2.53.0

