Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ED2440A12
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663676; cv=none; b=bSuIHdRZ4ApTZ91eQrolc7G5uMx968n/orSLPBZP2b5RPkOyVs5GoJ1Qu8hsx9iHcPpt9AJxXuelW2AGk2xDyH9lQWIDCzg7oZhjwYJ1gpzjsnpE2SH4hqlbqf1G66L7W6CIX04xDwdXf1PpUdHK/hEo//UxtuykuMKyBg4/Cgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663676; c=relaxed/simple;
	bh=5OhMj2ftZ6BSu8yyfbptJMftncRPt30xSHA/dzE6GgA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dYBgg+kvckVS6PP4H3JDJSN4O5EY2T8fkv9AyhA5bjI9jhebsgO7rvARF+b0wAioYiFnuKt396ePJPurBKC/Q1E9HiDyYBZ/VoNmVkAlZQO1pRF78WPtrY4BXlcyG0Dxdgo05Y+4KPdEggmuhn6195QHxcX3tuQOXgm24EoQduY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xbNeIZRe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xbNeIZRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB441F00A3A;
	Tue, 25 Aug 2026 13:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787663672;
	bh=orBN0WkUZJh7/eDbvDDqxrtuqkQomDHjPL1Cy6yJDoI=;
	h=Subject:To:Cc:From:Date;
	b=xbNeIZRe5ny3pT5kdj9N6Na3ffh40qwdoTuUY6OK2QFwA0DJLsI4+MtJOOfLVyTBw
	 uc3UJAcVHuUUl/boHsWiqHlY2UP4r4c1BZyhRY7Rx3ZBR/xaR2MwV8ElkUWMtgcEGz
	 BC9aP+EgBianUmuTVbzvb5LZABNnIR2rZC+Ghh04=
Subject: FAILED: patch "[PATCH] HID: nintendo: register input device after capabilities are" failed to apply to 6.6-stable tree
To: yijiangshan@kylinos.cn,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 25 Aug 2026 15:14:26 +0200
Message-ID: <2026082526-entryway-slick-acd7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d723bc1fe2e72b9252234e94c11af644ec477bf7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082526-entryway-slick-acd7@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d723bc1fe2e72b9252234e94c11af644ec477bf7 Mon Sep 17 00:00:00 2001
From: Jiangshan Yi <yijiangshan@kylinos.cn>
Date: Thu, 30 Jul 2026 18:15:06 +0800
Subject: [PATCH] HID: nintendo: register input device after capabilities are
 set

input_register_device() exposes the device to userspace immediately.
In joycon_input_create() it was called before joycon_config_rumble()
configures the FF_RUMBLE capability and the memless force-feedback
device, so a concurrent EVIOCSFF could dereference a NULL dev->ff.

Registering early also means the initial udev event lacks button and
axis information, which can make input managers ignore the device.

Move input_register_device() to the end of joycon_input_create(), after
all capabilities, the IMU input device and the force-feedback callbacks
have been configured.

Fixes: 2af16c1f846b ("HID: nintendo: add nintendo switch controller driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260730031927.25444-1-yijiangshan@kylinos.cn?part=1
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Link: https://sashiko.dev/#/patchset/20260730031927.25444-1-yijiangshan@kylinos.cn?part=1
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 32eed94a7c8b..9df05bfdf580 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -2198,10 +2198,6 @@ static int joycon_input_create(struct joycon_ctlr *ctlr)
 	ctlr->input->phys = hdev->phys;
 	input_set_drvdata(ctlr->input, ctlr);
 
-	ret = input_register_device(ctlr->input);
-	if (ret)
-		return ret;
-
 	if (joycon_type_is_right_joycon(ctlr)) {
 		joycon_config_right_stick(ctlr->input);
 		joycon_config_buttons(ctlr->input, right_joycon_button_mappings);
@@ -2244,6 +2240,10 @@ static int joycon_input_create(struct joycon_ctlr *ctlr)
 	if (joycon_has_rumble(ctlr))
 		joycon_config_rumble(ctlr);
 
+	ret = input_register_device(ctlr->input);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 

