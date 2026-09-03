Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCFB4B2051
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444387; cv=none; b=YeYo8ceuYmErVsS0XvNTJYu7edXLUyChblL6pLbivyJv0CjQdCMOJfu2Qb9B2H+yTr+I0L21trbKRLVeNDmwCLOjHXCN74X8k0UWXHZNuoi1ruxSayP3skq92qqVHcEq2UfLncH3D8ihL4f+ltaf4Qs1LXbUTWnPxGo/+5PpPSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444387; c=relaxed/simple;
	bh=Bcyr3zCJSYW94Hpox2yBMi/LwfX8gqtMEOzddd5hS5k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rklboOXscnyQZIENliWBww2seWbDnTN2KfTXOwogWXEe5jg4WvcIMMiijtq7r5Vz+zwjJqvV2erRbyxq9sC2RY91QMr1ArWyawgnmp7WwVbxPm1F4RjCFjPM49CYOuf4YE3fMFN5FuDZFd7pdhgcjgL1PwAa2y/4fH9XxFgBc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mmL2lt3S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mmL2lt3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0FC1F00A3E;
	Thu,  3 Sep 2026 14:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444377;
	bh=puT6LM80G1FO7zqE0/7IOE9B1yw+4eeAnJuH3iMsJ4s=;
	h=Subject:To:Cc:From:Date;
	b=mmL2lt3SdX4NodPc0cfAqxw9gFVclTLHriilcnbe2L1bC/PoDpi7lBafooi7WYH1q
	 rSShcSZl5CKaSRTDCCWrftmVSY2jSH2YsldomCY4Y3hSwowEuJkgFCb54hrF3eYEcx
	 I3SqMuDhDuSdkFTuVygqQ2uJ3nhnFoZ+gCdYBty8=
Subject: FAILED: patch "[PATCH] auxdisplay: charlcd: cancel backlight work on registration" failed to apply to 5.10-stable tree
To: getshell@seu.edu.cn,andriy.shevchenko@linux.intel.com,geert@linux-m68k.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:45:50 +0200
Message-ID: <2026090350-stencil-mud-1d68@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e3e3bf40916c1e810df03958cfa7ba6883cdce79
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090350-stencil-mud-1d68@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e3e3bf40916c1e810df03958cfa7ba6883cdce79 Mon Sep 17 00:00:00 2001
From: Hongyan Xu <getshell@seu.edu.cn>
Date: Sat, 15 Aug 2026 18:59:50 +0800
Subject: [PATCH] auxdisplay: charlcd: cancel backlight work on registration
 failure

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
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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

