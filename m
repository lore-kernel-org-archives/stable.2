Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755EB3E3143
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533170; cv=none; b=BgPSoFrvPjj0z516lS49ftYODEpX45GU55I972jk/wf+/lqhxt6IqU+Nii+qzcc4X9Mb6nUHgDYF2BLnLI85kVyOVXHJmzgon9vh2yJ+GMtIghZ/0LfwUnffTuMrlCtdxTf4aHXhacLoUNJ0uAnpIRP8kChqR5ceIWSX0mS/Dr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533170; c=relaxed/simple;
	bh=q+fa7HCjI5qt7iR4II10HFy8J16/FDubJd/u/ep6fMc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FNaTm3sZc1gAHIPCjEgl4nQEKP3uAlLoxkboKuBMfSy+yIZM/km6zdhRO2lMWP+0lHDXApxOAyamEuGdDLTmENgkVXXlfpusLYIhVchKN6cirqHSWdaYa75ibiU5IQK3qjjbQ3125GRLzJdwYf0NEIdKBIrmtiodzP0XE21G/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hegYbum/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hegYbum/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FFC1F000E9;
	Mon, 15 Jun 2026 14:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533167;
	bh=ZC2uWNhlU+kWAdr1FVgTUw+h9tpF5Mgr+QzYdXZQnAo=;
	h=Subject:To:Cc:From:Date;
	b=hegYbum/NRA6UURlURkY2Ds1OtvIUph6kdGCkWlC+ztj+LUWnFZLwpkwaGl06METy
	 IPPuuaBT7BgSX1WTgH9STf59X39v2NB1G0P1ED4UIPbXFIFOTvuFwLZwqtYBqcUiwq
	 i2Y+pnUz5fwFnnwaSpdxBhlkgQF6lpc/rc0z5K+o=
Subject: FAILED: patch "[PATCH] io_uring/wait: fix min_timeout behavior" failed to apply to 6.12-stable tree
To: lk@c--e.de,axboe@kernel.dk,tip@tenbrinkmeijs.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:18:11 +0200
Message-ID: <2026061511-underhand-neuron-492c@gregkh>
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
git cherry-pick -x 29fe1bd01b99714f3136f922230a643c2742cda9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061511-underhand-neuron-492c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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

