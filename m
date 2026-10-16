Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B008274B53
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 03:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792121293; cv=none; b=Z7abyCnYbU79YiKEJSDtgC5gEoEpdg9dFB9xl2qS07Hqoo8e2/3/e2bJZIFLghy4njO8QsJz2dRWCFpFinl34mOzf62bDoKb9IoxsUcxKDJ9tPyUy7vTNNZMFWfx3/bzdu4KHY/WH7zI07+FrPmnXNPKEiP8QDiWdDVfGiMdKz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792121293; c=relaxed/simple;
	bh=XSSPdOCNAc5WWi5tUc5olPewciaW+9RyoAozlFhXOiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IrWr3+JHZK/hSJmWEyhMMgbZWt9FqEJ640wFXIfFD59QTWsL7vDOtlC3x91ghY7sa74uj0iK1FF1tNYZxf/h+Syz3HXWfwe1pnm0VhsD7xXZmqtmQTBNcgONrlDed04LOYbWMtO3+0ZB3uK9AqndPloBwVKjtEt3//DCF/KDht0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0JFIXSf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0JFIXSf"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e5378b281aso34262625ad.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 20:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792121291; x=1792726091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=57IwzSravw3Iqow3SrotqKeFlKBEhaoHY1IKJqGvUEA=;
        b=f0JFIXSfuzsPUJL1qjcRIc1Lr50f0NSEgnZYWbxu+P2x4vL6juoaQV2p33mYhpDxW3
         i2iQBUyptC49for8BqemK7oft5sEdHcwwU/phFFaSpqpqfFXUcfyan/D5LgnJYegjdk/
         yhlFHdKi4nRMDwDG7droc1l0TXTku8IYeSJSu/mKniDbB4bh8S1WTxD7vLWSoW68aHcJ
         Y6YnfnW4g3ZuD9VLdObEleDgk1AM6akLdGesgw30amaRqwNPumwDiS7MZhyXa/q7Te2t
         moRF5CwfrWHrIPVQy1dk2q5IOcMFKq1aFmqIB+mEG81HIs5VPSgoe/O8MVG41/wCVOqM
         2i3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792121291; x=1792726091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=57IwzSravw3Iqow3SrotqKeFlKBEhaoHY1IKJqGvUEA=;
        b=jBNXqiCKJ6t/Su/TtReI4ZzdLiM2xdLS6yqiGOSlY2tIq2/qLEPPf5J6RNirILABPH
         GvL8hdb9LjxbHomPFR8DRHLxOiVvw6B/EJhV7C49yyjOm5jjbOeEbXduAt3eZHyC4KZ5
         Cdt4652WmkKhCYByrPdSkY5mrOmYBQn210mCu2pHUGsU85/RfnksQc9v+Bzrpa3eNkeo
         kjUSYGbKCA2n8BHug++pAcnhyoDDTmUSgabfrVznVs3k1hyW4S5B6got7pkwbwDcT4Hz
         6t64SwGtOy6WFA6LaQzufDG2RjdYgRPm++Hrr451ofpsQyKjJJ5udBPP2qSfFqoLzoD2
         Iupw==
X-Forwarded-Encrypted: i=1; AKwUvBz4Hkf88FnU1oR9aHE3zE0CdjgenAMkx+TsVCr6Q/+TwYEu7R9QbJjCFsfsZbxo2WZ5AGAVzfc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZCmY5VKkS1mX/dbx19d+5h5uHEfYbgnjh1uYSOF/fszOOenk5
	8SDoK0JPn4mubcSK1Zs3Q7cnzIXERmFoRGnvnTdrZidgP3B/7BXI1aah
X-Gm-Gg: AYBFou3qoxQ8kZtnIMEX5PKvu28yQQLD95V9ClHjdxehpOOQA2prMUOSLZQpMMxOAVE
	aK+lD1d6DDTFP7JZxN4wIqZ2t0W4jMwvTO+4G3fQEYcOZt0UJ72eBjdDj9IxBoXSXAcHYcNCM+f
	0mSEAbr9pjtlnwl2NLJLpVdJT+hEYNVhv5szZ6gIJE32Q90KWV5PVQlB8zfq+9xvB3D98o+ZNL4
	03iXg4GLhaQQNqT8VTFtmM2aedE/pE561O70Xke3OUmL7bsHnMCbHX5Bs9XytAwRoPWur9fRui0
	zU4/Fx7bLccMAym5y4pTXAJ/p+LL6CHsad25TrpZU5EBqXCSDt9VhwoldTj/sjRjsmJZAWbyRlX
	lJUE64mzHD+m6PvZMvG9oU/YSqGFdED7/zTE3HgOTAMb7TP7GNr5ZlejicdA9NN7dC9ZAPfYARH
	kEfGegm9xH2gUvM2s8vRAe6kd5GbgV8N0DN9oymDTvik307N8h5qn5YwmfIBysZTO7QWNVA64eW
	GdRakkPevlrFGI/S3hzYwo=
X-Received: by 2002:a17:902:ce12:b0:2e2:aa17:477f with SMTP id d9443c01a7336-2e842f11b4bmr193459365ad.58.1792121291215;
        Thu, 15 Oct 2026 20:28:11 -0700 (PDT)
Received: from localhost.localdomain ([202.8.105.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e834ef9sm3672935ad.42.2026.10.15.20.28.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 20:28:10 -0700 (PDT)
From: Jemmy Wong <jemmywong512@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	tim.c.chen@linux.intel.com,
	kprateek.nayak@amd.com,
	yu.c.chen@intel.com
Cc: chen.yu@linux.dev,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jemmy Wong <jemmywong512@gmail.com>
Subject: [PATCH v3] sched/cache: Avoid publishing partial LLC utilization
Date: Fri, 16 Oct 2026 11:27:59 +0800
Message-ID: <20261016032759.45279-1-jemmywong512@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update_sg_lb_stats() sums utilization over the CPUs in both
sched_group_span(group) and env->cpus, but takes capacity from
group->sgc->capacity for the whole group. record_sg_llc_stats()
publishes both.

Rejecting an all-affinity-pinned source runqueue removes that CPU from
env->cpus and retries group selection. The retry can publish the
partial utilization with the full capacity.

can_migrate_llc() then treats a busy preferred LLC as having spare
capacity. More tasks can aggregate into it, migrations out can be
blocked, and two busy LLCs may not fall back to generic balancing.
This increases CPU contention and task latency. Found by inspection.

Skip publication on affinity retries using LBF_ALL_PINNED, retaining
the first-pass snapshots and avoiding repeated cpumask checks. On the
first pass, publish either shared LLC statistic only when env->cpus
covers the whole group. Load balancing still uses the affinity-filtered
statistics.

The same window exists during CPU hotplug. env->cpus drops a CPU at
set_cpu_active(false), but the group span and sgc->capacity still
include it until cpuset_cpu_inactive() rebuilds the domains. Keeping
the previous snapshot avoids the mismatched publish. After the rebuild,
the next periodic balance records both statistics again.

Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Suggested-by: Tim Chen <tim.c.chen@linux.intel.com>
Fixes: f025ef275388 ("sched/cache: Record per LLC utilization to guide cache aware scheduling decisions")
Cc: stable@vger.kernel.org # 7.2.x
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Jemmy Wong <jemmywong512@gmail.com>

---

v2: https://lore.kernel.org/r/20261013084338.55100-1-jemmywong512@gmail.com/
v1: https://lore.kernel.org/r/20261010113425.34829-1-jemmywong512@gmail.com/

Changes since v2:
- Clarify that LBF_ALL_PINNED identifies affinity redos here and that
  retaining the recent first-pass snapshot avoids publishing partial
  utilization against full capacity, as suggested by Chen Yu.
- Add Cc: stable@vger.kernel.org # 7.2.x, as suggested by Tim.
- Add Reviewed-by tags from Tim Chen and Chen Yu.
- No functional changes.

Changes since v1:
- Skip publication on affinity retries using LBF_ALL_PINNED, retaining
  first-pass snapshots and avoiding repeated cpumask checks, as suggested
  by Prateek and Tim. Keep cpumask_subset() for partial group coverage
  during CPU hotplug on the first pass.
- Update the comment and commit message to explain the retry behavior.
- Add Fixes and Suggested-by tags.

 kernel/sched/fair.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 57360f5cdde4..7df5b5d2dce1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12111,6 +12111,16 @@ static void record_sg_llc_stats(struct lb_env *env,
 	if (env->sd->child != rcu_dereference_all(per_cpu(sd_llc, env->dst_cpu)))
 		return;

+	/*
+	 * Here, LBF_ALL_PINNED is set only on affinity redos. Keep the recent
+	 * first-pass snapshot, since env->cpus may now be incomplete.
+	 * Hotplug can also leave env->cpus incomplete on the first pass;
+	 * do not publish partial utilization against the full group capacity.
+	 */
+	if ((env->flags & LBF_ALL_PINNED) ||
+	    !cpumask_subset(sched_group_span(group), env->cpus))
+		return;
+
 	/*
 	 * At this point we know this group spans a LLC domain.
 	 * Record the statistic of this group in its corresponding

base-commit: 2f2f7eeef8b0a1a9b9ca998231419873ccae8d4e
--
2.25.1

