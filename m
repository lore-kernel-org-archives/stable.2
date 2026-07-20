Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB343C079
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564097; cv=none; b=Y9HajI2BRW+N+BmOun2LRWkcvr+MPwHUT3ryeCrho+wnN3bStdy57X90oIl05TMEjgb2e0aLpLwgBdzG4txDnPnTiA79vs2kcF5uc0bbNhn5YM1auc3lggOgZY587LxFLEA8j/UwYsAxRbF6fYTZZlAhdFfDGmK+ngSUu6Q6DNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564097; c=relaxed/simple;
	bh=D7CIYEbZZHHjn53Kb+TqqcrqFccJSt/dGYEFccOJc/0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T2uFTlA9IkoCZ+FSa/Thtrhc+WYNVH3PxKGB00XfP1JLkDWgaf5Di6kRoufVjyT4UYX+OorenMUKPr0Fe4jEJGzvxfK9GUS4VrIkbeP5fN6vFyfrGdqS/oXiUniXYSHgTNNcti3uvJRDfsw8yooCtnSGtzxAOGqwftdQPsKJZOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wMBHeRl3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wMBHeRl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0101F00ACF;
	Mon, 20 Jul 2026 16:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784564068;
	bh=Hxs3xvIMxZ/wTMdmiSbiJ/qXYXCig3T8TNlZ67EbR5w=;
	h=Subject:To:Cc:From:Date;
	b=wMBHeRl3WJq1ky00gghbGlGZqLmOQOc0JhbAb4h5+15/WEmNQLNdj8wlFxrEHJAj8
	 Felby5iG7VcUOqDVNuYtI/tvekA3OGHJqY+g/sy0EmX4UIkk4RkNJoA4n5eAxN6sjG
	 08cYEmMkTuUDqgTTW4j1X4eAKKfqhghlObrUVwIU=
Subject: FAILED: patch "[PATCH] gpio: mt7621: avoid corruption of shared interrupt trigger" failed to apply to 5.15-stable tree
To: sergio.paracuellos@gmail.com,bartosz.golaszewski@oss.qualcomm.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 18:11:39 +0200
Message-ID: <2026072039-grip-phony-0a5a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1781172526d1092323af443fa03f00e6de560401
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072039-grip-phony-0a5a@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1781172526d1092323af443fa03f00e6de560401 Mon Sep 17 00:00:00 2001
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Fri, 26 Jun 2026 08:01:09 +0200
Subject: [PATCH] gpio: mt7621: avoid corruption of shared interrupt trigger
 state

The bank-shared fields like 'rising' and 'falling' are modified using
non-atomic read-modify-write operations. Since every gpio chip instance
represents an entire bank of 32 pins, if 'mediatek_gpio_irq_type()' is
called concurrently for different IRQs on the same bank a possible overwrite
of each other's configuration is possible. Thus, protect this state with
'gpio_generic_lock_irqsave' lock in the same way it is handled in irp_chip
'mediatek_gpio_irq_mask()' and 'mediatek_gpio_irq_unmask()' callbacks.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Link: https://patch.msgid.link/20260626060112.2498324-2-sergio.paracuellos@gmail.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index a814885ccd5d..ceb99641baee 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -187,6 +187,8 @@ mediatek_gpio_irq_type(struct irq_data *d, unsigned int type)
 	struct mtk_gc *rg = gpiochip_get_data(gc);
 	u32 mask = BIT(mt7621_gpio_hwirq_to_offset(d->hwirq, rg));
 
+	guard(gpio_generic_lock_irqsave)(&rg->chip);
+
 	if (type == IRQ_TYPE_PROBE) {
 		if ((rg->rising | rg->falling |
 		     rg->hlevel | rg->llevel) & mask)

