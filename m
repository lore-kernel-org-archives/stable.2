Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339541F0E29
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445970; cv=none; b=YH1eURgvJQtdOD1f0yaek249VafRKoX46flSetSVug8qpE9BAfKyUcXk8HSFvAt1lRxN4O8uwYpWVd7mlrDaR5WddOc3tqLMlXqzfPq+d9Aeq0J0Ly3s4Jjh0IOQJKcf9+cFD1YC1jpSvc6LVtcdW26q1N56ISqNRoUlctYVndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445970; c=relaxed/simple;
	bh=w7V2GEi+6qMfR287r+FFicZM30O3IS8XwszrX1MjLVU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Zs0uOZAOejh/oxbuyKw58TG31WOtzp72vYsQeNpxhSAMlMV/c8Qq154WofIq3f2HEx7W7rMKUYK6aCBKioPRC4U9ZkrXVQlWeh1+8SfEqSXUR4V9ebIxaMy/+JvdlF03ba+O05yGwxxGx4HeZQQTjLgJgbgkH1+GQI4aBMs4lC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bjwV/qV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bjwV/qV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9820A1F00A3F;
	Thu,  3 Sep 2026 14:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445960;
	bh=1HLKotwUx7SoDiyhLgRRW6Ca+7raeEpRKr41pjySp/I=;
	h=Subject:To:Cc:From:Date;
	b=bjwV/qV2kboiw7v8uWIgbbmRGuOZAeaHiJ6uupsendHLeA1m4BwOm9RoQGMmI2EE2
	 R+5I+nhaTghoM3+xXo+y29obTboRljHxOWdQvwNAWzg7KlGkCAYVC4q3oWzQJap8nD
	 kzSZNKruPAoHPEAi2ZK0Uuur51jZQQZop7JCuzyc=
Subject: FAILED: patch "[PATCH] sched_ext: Fix exit_task leak on fork failure during enable" failed to apply to 6.12-stable tree
To: fangqiurong@kylinos.cn,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:14:21 +0200
Message-ID: <2026090321-untoasted-cedar-1c9c@gregkh>
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
git cherry-pick -x 03506edca637a8465dba9f635c50e9884fbcaf4e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090321-untoasted-cedar-1c9c@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 03506edca637a8465dba9f635c50e9884fbcaf4e Mon Sep 17 00:00:00 2001
From: fangqiurong <fangqiurong@kylinos.cn>
Date: Fri, 14 Aug 2026 11:26:23 +0800
Subject: [PATCH] sched_ext: Fix exit_task leak on fork failure during enable

scx_fork() initializes tasks when scx_init_task_enabled is set, but
scx_cancel_fork() only exits them when scx_enabled() is true. A fork
that fails in the enable window (between releasing scx_fork_rwsem and
setting __scx_enabled) runs ops.init_task() but never ops.exit_task().

Gate scx_cancel_fork() on scx_init_task_enabled.

Fixes: 4269c603cc26 ("sched_ext: Enable scx_ops_init_task() separately")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: fangqiurong <fangqiurong@kylinos.cn>
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 61b156d7fc4b..2adf2bde0cb1 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4163,7 +4163,7 @@ void scx_post_fork(struct task_struct *p)
 
 void scx_cancel_fork(struct task_struct *p)
 {
-	if (scx_enabled()) {
+	if (scx_init_task_enabled) {
 		struct rq *rq;
 		struct rq_flags rf;
 

