Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFA647C0EA;
	Wed, 23 Sep 2026 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157172; cv=none; b=CqGhUs2HeVfX7mXjSgw8VdsqyjQr6WsVYNGQUM0zeEDWRywq6NqMMEo/aVFOZhKaBqY+jSt+/CDKq2jQqtp6uKZsnO3QmqNxJ0mFYRijeR6nVUO/LYTmqyWJw3uh0Nha2YvOJsILIlMxKmGxQ8pFclgtwffQTtC5ghKO3iGFQPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157172; c=relaxed/simple;
	bh=1QMoG4n56/0LQMnl4pbBIVut65qm7D6YN4JBtJ56Lz0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pDXKQHw4/gqWaeJXCuz1R+mEGsZubRucLHlqTK5QWE8HPWqESL8epQEtFWBQ0CEBRdh2/ngcwWZ9Ng56KqNdegXYgQdsSHsaN/9D6RaLzJZ1HH/KQRdy2EG5tJZ829dqmG7rKttp1LtXNanhyAk4SCuzBpqTA62DKRTEIn+au1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eLVxxOaC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wC/i6cnl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eLVxxOaC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wC/i6cnl"
Date: Wed, 23 Sep 2026 09:52:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790157168;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4UI1fj5unVF69dzyeP91wpXfFNaG/4t0EduMtMFyO0=;
	b=eLVxxOaC6yJQh+wNuFVYGk7eHzQgXgKWhtBG9frSmIJlI5PfJiaZqzP/XwRbsyQINkbztB
	2g2KAgbOHynblaEjrLs65vcqoeFaJOR1F0/2XSrBO4V+M6I4KaI3Go2cOTa0RVU8Kx6a94
	YEGLrEbWNj/FDbvqLJEefy7/QpZrZcFz9GVgCkneZrA0SeZMLFCPbIKRJwyxGrD7hm6zTT
	TcN1eQYalwhccN+U1007Z59TeZDNO/89oqDuBI3eEMs7J7IWEbRm+RiXST8jSKyg2ql+Ks
	oObr3i9ZtJURB+f2M4hR7KhcrES7T/NMGP647OBOxRs+LtoYTeN+10Ut4M4E6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790157168;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4UI1fj5unVF69dzyeP91wpXfFNaG/4t0EduMtMFyO0=;
	b=wC/i6cnlhj0aNu7L4xdwJ5Ckkudfr/dtHhOnv27dLbhldNmIhNwvibrjuQ7lFaMVm5yXqQ
	Uo9nPsi3XGt5Q4Aw==
From: "tip-bot2 for Puranjay Mohan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()
Cc: Puranjay Mohan <puranjay@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Yifan Wu <wuyifan50@huawei.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260810133540.1947118-2-puranjay@kernel.org>
References: <20260810133540.1947118-2-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179015716661.2819794.5713532256161030607.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     36bb85cf36cab15fb611cb44b78a5df06e4e69a2
Gitweb:        https://git.kernel.org/tip/36bb85cf36cab15fb611cb44b78a5df06e4=
e69a2
Author:        Puranjay Mohan <puranjay@kernel.org>
AuthorDate:    Mon, 10 Aug 2026 06:35:34 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 23 Sep 2026 11:48:35 +02:00

perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()

perf_pmu_sched_task() returns early when cpuctx->task_ctx is set, and
cpc->task_epc is only non-NULL while a task context is scheduled in on
this CPU. __perf_pmu_sched_task() therefore always passes NULL:

  Unable to handle kernel NULL pointer dereference at virtual address 00
  pc : armv8pmu_sched_task+0x14/0x50
  Call trace:
   armv8pmu_sched_task+0x14/0x50 (P)
   perf_pmu_sched_task+0xac/0x108
   __perf_event_task_sched_out+0x6c/0xe0

Pass &cpc->epc instead, the CPU-wide context for this PMU, which the
function already dereferences a few lines up to find pmu.

armv8pmu_sched_task() is the only in-tree implementation that
dereferences the argument, and it only reads ->pmu, so the oops needs
BRBE, added in v6.17.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Yifan Wu <wuyifan50@huawei.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260810133540.1947118-2-puranjay@kernel.org
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e180134..7ce72f3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3914,7 +3914,7 @@ static void __perf_pmu_sched_task(struct perf_cpu_pmu_c=
ontext *cpc,
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	perf_pmu_disable(pmu);
=20
-	pmu->sched_task(cpc->task_epc, task, sched_in);
+	pmu->sched_task(&cpc->epc, task, sched_in);
=20
 	perf_pmu_enable(pmu);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
