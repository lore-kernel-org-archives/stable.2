Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB12F4B049C
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445970; cv=none; b=hFCRsizNNsy7d2vQ40v7Y66FPr1Ob1EFLJkqRjzzexa39KcWaErUs42zl9QS8ldpjIbET/eaoKiR115e38E9W+VXQNaByxuQ8QeR4CCporIOwVO3A3FHHbnQmFmATrFZDM2SzF1r2cRLUPfBAy7okw24ZrLRV9J4yXoB6jzx6l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445970; c=relaxed/simple;
	bh=tJ634aXB558+9XqFFZxv9dXJaM/Pe6U4i7JUNZos69A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KzCuQTRA1NljudWOAqhPakAJgqlmWRfN5nmkucyPpmOpyEnnTA4ewQ6B1pIRRWZvVBn9r2zb2ub6MkyJm+FXATtGKolmmU8Wx2tYZreHQLlHmCsxUsSyRohN/Aglz0cS5RXbFM2/eFoO/RmYmuCmoIdh7wBlT77CL8JrZeD03JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IjLnGkWH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IjLnGkWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5FA1F00A3E;
	Thu,  3 Sep 2026 14:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445957;
	bh=M4skw0r0DpAkjmc7YqWdYhQD9w27jrpwDGSqV7jENzo=;
	h=Subject:To:Cc:From:Date;
	b=IjLnGkWH55pY/t7DsnRDd6/Fy0Qlq2JtTj11i1p2P8H0fw4RonZ2iRVS82B18FLRX
	 2wdNrJaFJ2boRTQ0q0CrwDtpvQ81XatLqz9hmnZnk9eXHdi65xmtOKhA6Z1Cv+VykP
	 o2NgF45tZQjch6Gnnl+vtI2YpLAy3YYejd8Wa3lE=
Subject: FAILED: patch "[PATCH] sched_ext: Fix exit_task leak on fork failure during enable" failed to apply to 6.18-stable tree
To: fangqiurong@kylinos.cn,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:14:20 +0200
Message-ID: <2026090320-scrooge-flashing-ac37@gregkh>
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
git cherry-pick -x 03506edca637a8465dba9f635c50e9884fbcaf4e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090320-scrooge-flashing-ac37@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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
 

