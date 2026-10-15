Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777C47CA78;
	Thu, 15 Oct 2026 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052180; cv=none; b=kYhg5jV5/CHs+HFOJdU4B2lWwoxovKBSUUyMYAt4wRDUjHlleNWdQ5F/QW6v8uSgSYMuYwcgf78YfTM4XbsDnhHFQcb0SgwFqgXRKzjejgx36+15wqxcKTeiZ82xfp4/ZqMtt0MFivRklp7oNQOmvIZoDHXK/eKAsMbNVv5Rb8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052180; c=relaxed/simple;
	bh=zSp/0smSuBPwfFeyUuptM9TS3bG+0NXC3vr1OeVzcv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJPqahbdeQieKT1o1ypkQCHA8MZYiz6fpT0uIdOd28Vp+ws5ypaNojM/SdNcp12OjjhHOJqeGRFKJGuRw+3H9PBMKD4DHOWOEQH7UHCvoagt5VWxfuuDSDQ/8khx7dRswV1rSFY4cdEitns8vyWfIKuY6I9h8APbrmD9mDkbT6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aELCwXc9; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aELCwXc9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=CB
	Aj3G+A0LrLf0RdIqssokkB7lUH9geW4Rqsu7O8qVI=; b=aELCwXc9RqBtWjs3Tg
	RgWfjpTNWT9ZqWA5fTKQTn1tER4FxDd3md2+Jc6hHe09/nQuybY48YCaDldK9xNK
	jXtHEjn4NyimUIAojY6asfrdVDwj8NHcNbK52Nsm3mQzPY+xk1CovlsRk3HQvjlv
	8B4ovmYCuNK/jXIh95txy78rg=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD33yxpi9BqNwrbEQ--.39729S2;
	Thu, 15 Oct 2026 16:14:34 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH v1] sched_ext: finish scheduler init before publishing ops priv
Date: Thu, 15 Oct 2026 16:14:31 +0800
Message-ID: <20261015081431.46628-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33yxpi9BqNwrbEQ--.39729S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyDWrW8uFy5ZrykAF1UJrb_yoW8Kw43pF
	ZxXF4akryUJry8uay8Za1vka4rWrWfAry7G3WYgw4rAr4jqF4Fg3y0qa12gF9xCr95AFy2
	qF1av3sF9r1jy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UWMKZUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC4AvLr2rQi2tAYQAA30

scx_alloc_and_add_sched() assigns ops->priv before initializing the
scheduler's kobject, list linkage, and sub-scheduler kset, and before
consuming the BPF arena reference.  BPF kfuncs resolve the scheduler with
scx_prog_sched(), whose readers dereference ops->priv under RCU.  Once the
pointer is published, a program can therefore use fields that the creation
path has not initialized yet.

Attach a sched_ext struct_ops program that reaches one of those kfuncs
while registration is still completing.  Delay publication until after all
failure-prone initialization and arena setup have succeeded and
cmd->arena_map has been transferred to the scheduler.

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection.  The issue was
not observed at runtime; it is identified by code inspection only.

Fixes: 105dcd005be2 ("sched_ext: Introduce scx_prog_sched()")
Cc: stable@vger.kernel.org
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 kernel/sched/ext/ext.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 3219f0da0fe4..bd79bb692cb9 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -7305,13 +7305,6 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 	INIT_LIST_HEAD(&sch->sibling);
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
-	/*
-	 * Publishing makes @sch visible to scx_prog_sched() readers. Failure
-	 * paths after this point must free @sch through kobject_put() whose
-	 * release path defers the actual freeing by an RCU grace period.
-	 */
-	rcu_assign_pointer(ops->priv, sch);
-
 	sch->kobj.kset = scx_kset;
 	INIT_LIST_HEAD(&sch->all);
 
@@ -7345,6 +7338,14 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 		sch->arena_kern_base = bpf_arena_map_kern_vm_start(sch->arena_map);
 #endif
 	cmd->arena_map = NULL;
+
+	/*
+	 * Publishing makes @sch visible to scx_prog_sched() readers. Failure
+	 * paths after this point must free @sch through kobject_put() whose
+	 * release path defers the actual freeing by an RCU grace period.
+	 */
+	rcu_assign_pointer(ops->priv, sch);
+
 	return sch;
 
 #ifdef CONFIG_EXT_SUB_SCHED
-- 
2.43.0

