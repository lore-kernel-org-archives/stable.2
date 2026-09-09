Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984C929E10B
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788918827; cv=none; b=lNFybEQGqclrPx8RS84KRyVMVffvKOhAe1/3aUis7OkIPab0H0QwFJcYnplAbRYnhDHY3sHvImL0YoPUYTXTPjKc9x1i5BhbgLPgUnsDtelFyrh6qlxfyqOGIaI1mjQRTPE1xFWgEQ8L6DoUabFyQWfCmNb841evvkxgSxc098o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788918827; c=relaxed/simple;
	bh=tXsdZaq9rVu9BvgKiNbRENC2bzD5QJl7XYNoLxKmMws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJ5kU8LsH7r+FgSqyus+k13kJV3RaWYAPsQfQyaa+RDU1Nu+fkaKceXzY0EMLHK9emtPIA9Po/yolTPsBFUsV/jvVem6TFtQavYONo/rVmCTZzhWbG1he5uFBtHD3pbTiqbBK8MK22wB5VNy6PymQoAUB0lm9qfDVDX24syIpEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IikMc9e2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IikMc9e2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9160F1F00A3A;
	Wed,  9 Sep 2026 01:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788918826;
	bh=qv8s+lRRz5rCE3Uv1NhX0VbQfuKzTEGZmzaCd5h1Vps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IikMc9e2sU+cIP37/dJ+JipIyk7kfFXNMmz0i3ogR249KrWDRmDNd1C7NKCFXTNBh
	 H+zyy7fkwfFyWQMcZkQkJjgvMNmWV4U+OZKrpL+CffCkwHcR44ziCfZynkGev5RNfP
	 u52SyXQ3VJGm/Q4mRS+1ANpwz52ccB1Ymf/HSh7pGKDeSVQTAeHFBfsR4aSV4Wu6vG
	 /xL04zyF14DxRyMIA5tvcPhSAmIWpjXO9awLFgza+wN4ApfzvtaIUqP6mP91uhxi/Y
	 F3y2fJ2az8G2jaLV53VX+SML6Nu5H6euQtpXfYdy+tEDnByWoOv4REmku9fruz+jr4
	 qslAX3HAUs2mQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: fangqiurong <fangqiurong@kylinos.cn>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] sched_ext: Fix exit_task leak on fork failure during enable
Date: Tue,  8 Sep 2026 21:53:44 -0400
Message-ID: <20260909015344.949840-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090320-scrooge-flashing-ac37@gregkh>
References: <2026090320-scrooge-flashing-ac37@gregkh>
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
index b5f95b379ea6c..a8a507988e419 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3007,7 +3007,7 @@ void scx_post_fork(struct task_struct *p)
 
 void scx_cancel_fork(struct task_struct *p)
 {
-	if (scx_enabled()) {
+	if (scx_init_task_enabled) {
 		struct rq *rq;
 		struct rq_flags rf;
 
-- 
2.53.0

