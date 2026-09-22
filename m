Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F215519DF0
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089832; cv=none; b=Yh0kNVBoGzo11vMXrTReR4vFhIZ2K3PogBM3aLfNQc9xEXNSN0LZmpWJ49ORWf+oIK/7ix1xPZQieiMQ8jkZ1rLHrDgjnE+90ghTcL2FkTDWL85L1vWt/+jV4mGJ8S2IGRdMjbPXKQGjz7Kh79/fVY8NnpKZt1LLbiOY0B5YpSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089832; c=relaxed/simple;
	bh=VWoJG3LFmFUNtd9xSzFfW3oe2xif+ecBoTz9MjRN86U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=R32p+H0XiFh0jsZ6nHs6TArjj8tURou7O8E2/yNrFlobng3YRaavsLyeV8uPtl97SmNXD/52Jpa+5MP7fPApk/OPTd6KFgRgYgB1dpnQ9vSVMc0oFqegDj22J/taH6OP0FIQgEX2cwOAdJ25qh+UiWb/8fPM1d02ES35F8bTcUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oPosHbm1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oPosHbm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F731F000FF;
	Tue, 22 Sep 2026 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089831;
	bh=UEveT+pnbqJr+U9Vp1UAkmSRxujkJaSmpxbClZy+oYg=;
	h=Subject:To:Cc:From:Date;
	b=oPosHbm1MoONaWsHwAS333/R4xipAelCp2kHROj1aK5G4RAIEwuAo/GfNokTX6cUq
	 kisJ6lBZxi/aFQ+GDca5WgGhAKK9oCADx+r5eSjjzYoveh+1wtoeVEtaadNi5kOrKS
	 kFVXqsh66uUY+M3grJ04szXegyEZ8+o0hm3bCLIg=
Subject: FAILED: patch "[PATCH] Input: hp_sdc - shut down kicker timer on module exit" failed to apply to 5.15-stable tree
To: runyu.xiao@seu.edu.cn,deller@gmx.de,dmitry.torokhov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 16:53:15 +0200
Message-ID: <2026092215-retrieval-garlic-5b53@gregkh>
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
git cherry-pick -x 309731e95917125bbd13626a7a5600490a5bf44f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092215-retrieval-garlic-5b53@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

