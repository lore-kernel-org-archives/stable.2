Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AD621CC59
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788919099; cv=none; b=AGgDENJ4Kj0zaM7T8Pp/WarAFjZiSGxKHXEwNMpOcBW1Y1/9itWDAorMTiI9r7lOV9VDEBTvv7O8PdS7m6TfjpGl1qgtesiEu3itGlpn7YZtXIplAFjmTk/GEjdJ4EXnSCDCqVPMohonEVSC6dp6Wf3pZnFhgqyfbIgY4bCIcnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788919099; c=relaxed/simple;
	bh=c9+dcxHb4FPqhivgYW7sQNwixSI2Ew6uxytFc476zoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wy4JYiiYgkuCOWmfvtfCP+vmNC1QNKeTEjI9hh5gd+yUQd/dWKSu1l17YGOaF5JPFV7TC8hU49m8ksKeKgjgEV2GuVOYF4AFr8sSHIRcskGP0+fRc+FZh9S1xoSkSQqW8r/EStLBuvE9B5Pxdok3iOmBtHXSVIMTM0UosAJk0UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlpfOpiN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlpfOpiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E3E1F00A3A;
	Wed,  9 Sep 2026 01:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788919097;
	bh=zPQnzNz/k+lwKUhFaVnKjh/JBon9IeY3qyI3CQKZgcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TlpfOpiN6YbT/XpEK1Pv6x2hz9ZnlV7HH+/2s3fpwU+Qt117Ra6tjENLeM9x8sC7q
	 zyDBXY1yEAK7UZaZKBuCqrvgpnwyMduWkfnSIygvLYgLwhiEykjgrYz98kB40Pu6Ki
	 FwSmq0AaXCy+YzDZz8y4CLVlJyIZCOVSt6JIXxzliV97eRUgXeK211seZx4nWsjzQ8
	 AuKANJ6V6nfislFsyQbWihF/RIuDyFoYkAsceLciEkp7zE4LYmARgYyHnDO1j3Z/Mz
	 UyByhVWWQWjurZJ9ZON3s+l+fNIlgnKRPXDD0TczNl+vi7N0Nzc30qcrgPe4zJCv6V
	 f0YNsbWiEanKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: fangqiurong <fangqiurong@kylinos.cn>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] sched_ext: Fix exit_task leak on fork failure during enable
Date: Tue,  8 Sep 2026 21:58:15 -0400
Message-ID: <20260909015815.982562-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090321-untoasted-cedar-1c9c@gregkh>
References: <2026090321-untoasted-cedar-1c9c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: fangqiurong <fangqiurong@kylinos.cn>

[ Upstream commit 03506edca637a8465dba9f635c50e9884fbcaf4e ]

scx_fork() initializes tasks when scx_init_task_enabled is set, but
scx_cancel_fork() only exits them when scx_enabled() is true. A fork
that fails in the enable window (between releasing scx_fork_rwsem and
setting __scx_enabled) runs ops.init_task() but never ops.exit_task().

Gate scx_cancel_fork() on scx_init_task_enabled.

Fixes: 4269c603cc26 ("sched_ext: Enable scx_ops_init_task() separately")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: fangqiurong <fangqiurong@kylinos.cn>
Signed-off-by: Tejun Heo <tj@kernel.org>
[ Adjusted the target file path from kernel/sched/ext/ext.c to kernel/sched/ext.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 428cde37130df..e4b4621427fc3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3829,7 +3829,7 @@ void scx_post_fork(struct task_struct *p)
 
 void scx_cancel_fork(struct task_struct *p)
 {
-	if (scx_enabled()) {
+	if (scx_init_task_enabled) {
 		struct rq *rq;
 		struct rq_flags rf;
 
-- 
2.53.0

