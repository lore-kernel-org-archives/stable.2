Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D535A2F260C
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089826; cv=none; b=QxDWOpReJGRryLePQdXZC9hGpbWf5iMycQiHcSE3emuDsgm4A41VwhAHRCTHuMH6XJuW9Zuvsae2chNb/jsKoBTS0pECQhE9InSk7iVoShx32XdnXJ/8wQHGU3kFpK6zPLvYGnF76qKfwV73sSqb+Lr6yCfYQUur+//+7JpcLfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089826; c=relaxed/simple;
	bh=GFi55UPyZZ2gRjg4G3GhaQuBAeDrDwyVmzvbYgJy2Oc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dc6eLenCwLflL1KwxExhICWpDj04vRFw1n4rJGrXy1ELlhAiS1ks8n5zLmc36DZ2oyR/NoQxG3AuE8Izdx719uXogOgoWfx/EsWm02B4UMRKQpIF+gtRAmvjEvwwOINAlzqmynlWNyxNn31wh+nB5n4nMYX/cNMSwFKKJsZ5Dck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VlyLnJeL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VlyLnJeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100241F00893;
	Tue, 22 Sep 2026 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089823;
	bh=7yIWuHa2gkXdkGsub0LAhMR/tdXtV6exi87Z8PvgG3s=;
	h=Subject:To:Cc:From:Date;
	b=VlyLnJeLWBf4YZ+d7eFtVRUGn/YjhNa6aWwLJWhjNcG3FPZzbeO4QBpv7gFcIo8TH
	 DG9eRMTB43yvj2RAmgssLPYY1VMF2keHOad5tlj9neMWUBLXLG+cmJHLbild4069HM
	 MYgC50K4z2jtr8CKlbrNcNds9bij5qzEXX43tgIA=
Subject: FAILED: patch "[PATCH] Input: hp_sdc - shut down kicker timer on module exit" failed to apply to 6.12-stable tree
To: runyu.xiao@seu.edu.cn,deller@gmx.de,dmitry.torokhov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 16:53:13 +0200
Message-ID: <2026092213-clinking-taunt-b525@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 309731e95917125bbd13626a7a5600490a5bf44f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092213-clinking-taunt-b525@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 309731e95917125bbd13626a7a5600490a5bf44f Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Wed, 2 Sep 2026 23:40:04 +0800
Subject: [PATCH] Input: hp_sdc - shut down kicker timer on module exit

hp_sdc_kicker() rearms hp_sdc.kicker with mod_timer() after scheduling the
tasklet.  The module exit path uses timer_delete_sync().  That waits for a
callback already running but can still leave the timer rearmed.

A callback can therefore leave the timer pending while hp_sdc_exit() tears
down the driver, allowing timer activity to access dismantled driver state.

Use timer_shutdown_sync() for final teardown.  It waits for a running
callback and prevents rearming after module exit begins.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Acked-by: Helge Deller <deller@gmx.de>
Link: https://patch.msgid.link/20260902154004.3595416-1-runyu.xiao@seu.edu.cn
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/input/serio/hp_sdc.c b/drivers/input/serio/hp_sdc.c
index 1461ef319f92..ecf5347b63ab 100644
--- a/drivers/input/serio/hp_sdc.c
+++ b/drivers/input/serio/hp_sdc.c
@@ -981,7 +981,7 @@ static void hp_sdc_exit(void)
 	free_irq(hp_sdc.irq, &hp_sdc);
 	write_unlock_irq(&hp_sdc.lock);
 
-	timer_delete_sync(&hp_sdc.kicker);
+	timer_shutdown_sync(&hp_sdc.kicker);
 
 	tasklet_kill(&hp_sdc.task);
 

