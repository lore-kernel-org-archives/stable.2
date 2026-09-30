Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC1E556BB4
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790189; cv=none; b=jPaWSdIpc2mvnCKKbZSM7jIngyp414Os4quWY+nxem797UZNHOzhXJip54WVt78Bgm9gpNXgBk/4M2YT2eawZOjndG5N7z9znxLUQxdF1fc/j6cDd9vZFDOvEr5yI+fThEI3AT77+iIkGFxnYvl54qyrtwHWcbpPGfhCL4aZsmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790189; c=relaxed/simple;
	bh=UYWFfT44qCgKFqPwam4Q1wFJ7E32+ivz3LmtE3DJwQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ne+MPZMukuVQbRqJgoZXoJmfecHQlgS6y80S3EVpLvOVN7tMftdPBp3q0VqsrfP2CNNtYN7kg5JHtthMnUbk2B3/wlNkS7SYdY2FwTyACb/PUeGs/dxv6NoLh7StwrZ+isiGCEEge6HdgIc7UzjV9T0LgSQ+7k7IfJ09Kry2AFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJZI4hJp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJZI4hJp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790790188; x=1822326188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UYWFfT44qCgKFqPwam4Q1wFJ7E32+ivz3LmtE3DJwQ4=;
  b=cJZI4hJpnpktTU8Ua3WhEs9f4jt8o5WXefdbwivKArkN44n034gW37fU
   QQZ7tcCvS9dd4QO9GBzv54bn4JSGOpJ+sken/CBcQCgylPckjgXrqbY8B
   K1MZAYVi4YKvBeCLmy72OFa1d9+YuaCQQoK49Yiqx/RqZU+mIZECVV91B
   vYNMC806FgiAtt2QmogGPzit1E0T3nBb46bvrPdTT826YKmwJTVx1rzBz
   M24Ja9K6ODIKunaPtQywqKy/NSgjkXwYmVkajtKdlqPpz67khoHWR+7p2
   yZk3xUuPHVQma5rpScPDKykHmh4jBOaonvTh0mpsIvZ74vh6YbqcSDPv7
   Q==;
X-CSE-ConnectionGUID: LywgNEYOT0OT1QzVre2IIw==
X-CSE-MsgGUID: nVedr7TNS3K8yyYpKvrMeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="91633354"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="91633354"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 10:42:57 -0700
X-CSE-ConnectionGUID: 69FUCbrPSM6P8srWTGx2aQ==
X-CSE-MsgGUID: fEPgM0+lTBSoohGtoF+new==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="303684053"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa001.fm.intel.com with ESMTP; 30 Sep 2026 10:42:57 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chen Yu <yu.c.chen@intel.com>,
	Lu Wang <wanglu.priv@gmail.com>,
	Davi Chaves Azevedo <davichazbh@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	stable@vger.kernel.org,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	stable@kernel.org
Subject: [PATCH 7.2.y 6/7] sched/cache: Skip kernel threads for cache aware scheduling to rubustify the code
Date: Wed, 30 Sep 2026 10:48:08 -0700
Message-Id: <8b55e169ad762300bf4882376f3d1499935dc698.1790790344.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1790790344.git.tim.c.chen@linux.intel.com>
References: <cover.1790790344.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Yu <yu.c.chen@intel.com>

[ Upstream commit 65efcccddc83d6a19e8a2e2a6117811e39e589bf ]

Kernel thread should not be covered by cache aware scheduling as
it borrows the statistics from the user space thread. Filter the
kernel thread in account_mm_sched().

In theory a kernel thread does not have any valid
cache group, so !grp should gate the kernel thread.
Add the PF_KTHREAD check explicitly here for safety
reasons, to guard against future modifications and
to pair with task_tick_cache().

Fixes: df0d98475954 ("sched/cache: Introduce infrastructure for cache-aware load balancing")
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@kernel.org> # 7.2.x
Link: https://patch.msgid.link/058f0c6ea7b991c177a17de347fa3157f25489a7.1790035273.git.tim.c.chen@linux.intel.com
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0b8d9c6c63dbe..b6cace1d0e322 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1868,8 +1868,14 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	/*
 	 * init_task, kthreads and user thread created
 	 * by user_mode_thread() don't have a cache group.
-	 */
-	if (!grp || !grp->pcpu_sched)
+	 * In theory a kernel thread does not have any valid
+	 * cache group, because sched_cache_fork() is not
+	 * invoked for a kernel thread - !grp should gate the
+	 * kernel thread. Use the PF_KTHREAD check explicitly
+	 * here for safety reasons, to guard against future
+	 * modifications and to pair with task_tick_cache().
+	 */
+	if (p->flags & PF_KTHREAD || !grp || !grp->pcpu_sched)
 		return;
 
 	pcpu_sched = per_cpu_ptr(grp->pcpu_sched, cpu_of(rq));
-- 
2.32.0

