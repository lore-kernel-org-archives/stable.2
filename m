Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C733F929E
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533162; cv=none; b=o+2BWzbfzlJ1HHY00IXZOA3wdApmK3SMSmi2K+D4jhf/7Gmke/P5VycJe50+aK542/FQiWXu1sOON2tSNc59wU0XXEWaapI8iA+1LRYOLlLACnJix1m4ZZvWth1LczboGegQfBqa8AKh7ec4TPev3/H8YM4kEYjsFUEaMEBWMyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533162; c=relaxed/simple;
	bh=Hx70rjGizQtilLOza84jz94zSkpE6s+/RP5Z//ehRnk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CSTOcI5ER7utlJQ1T5IROeZPNPdGaasFujBIpmqh4tEgoQuAxfCzk5Zi/61Jb/pJZf2GjaCDommRRRq3EIAebz3RS4gq+luhR9xoumK+0YSOT0nIwagwja5M+pDHa5071BQuRi8Yj3kcsout5EmINzm/CHH4dJiVMZniiYgbv5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ycXnV4z8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ycXnV4z8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DC51F000E9;
	Mon, 15 Jun 2026 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533158;
	bh=gxjdpLpb/+/vwJeTQu05dKV7lH63Z61VJrDubeezAeY=;
	h=Subject:To:Cc:From:Date;
	b=ycXnV4z8mIUidY2WOSqlZcIrAxfiERhRmVaEm3IoirpZ+8C0OF/gP1hY5DiAdeBCD
	 hDGDqhoxtvfcXdZCyfzLuzwGBXxJWHFQ+/yPMC/MOj8Ze0dNeZe9lfVHXOE1pe+o7Q
	 ApNwAWb49B0Ef5DmK4jFK4hjPI6QRL9UG5jDt1Cc=
Subject: FAILED: patch "[PATCH] io_uring/wait: fix min_timeout behavior" failed to apply to 6.18-stable tree
To: lk@c--e.de,axboe@kernel.dk,tip@tenbrinkmeijs.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:18:09 +0200
Message-ID: <2026061509-unwatched-transpire-cd39@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 29fe1bd01b99714f3136f922230a643c2742cda9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061509-unwatched-transpire-cd39@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 29fe1bd01b99714f3136f922230a643c2742cda9 Mon Sep 17 00:00:00 2001
From: "Christian A. Ehrhardt" <lk@c--e.de>
Date: Sat, 6 Jun 2026 22:11:20 +0200
Subject: [PATCH] io_uring/wait: fix min_timeout behavior

The wakeup condition if a min timeout is present and has expired is that
at least _one_ CQE was posted. Thus set the cq_tail target to
->cq_min_tail + 1. Without this commit a spurious wakeup can result in a
premature wakeup because io_should_wake() will return true even if _no_
CQE was posted at all.

Cc: Tip ten Brink <tip@tenbrinkmeijs.com>
Fixes: e15cb2200b93 ("io_uring: fix min_wait wakeups for SQPOLL")
Cc: stable@vger.kernel.org
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
Link: https://patch.msgid.link/20260606201120.1441447-1-lk@c--e.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/wait.c b/io_uring/wait.c
index ec01e78a216d..d005ea17b35f 100644
--- a/io_uring/wait.c
+++ b/io_uring/wait.c
@@ -103,7 +103,7 @@ static enum hrtimer_restart io_cqring_min_timer_wakeup(struct hrtimer *timer)
 	}
 
 	/* any generated CQE posted past this time should wake us up */
-	iowq->cq_tail = iowq->cq_min_tail;
+	iowq->cq_tail = iowq->cq_min_tail + 1;
 
 	hrtimer_update_function(&iowq->t, io_cqring_timer_wakeup);
 	hrtimer_set_expires(timer, iowq->timeout);

