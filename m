Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6B5426EB7;
	Fri, 16 Oct 2026 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137339; cv=none; b=uA4sHzzH+wcGG2fe+b7ncz2zsGyhbtguG/fv9WImgd2cy52FG33VexvNjxNe+vZDBcRvQvL+GV41Mr9a9RqUbmDn+jcK3foZcJdIDfZsY1Kys22hu8qyLg32hx1Kb020234Cvij4B35l+fyeWO+3Qb0RVWX5avCsQ1gIAt7CZws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137339; c=relaxed/simple;
	bh=JoXuSMmICTJiARkn5vtLovlQ/zg36H4wogFtNkxSwj4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sg+xMuumL3Uhg6Kkf1zsnSHtC3vrJjHH8ZPU8MgzhDHzfhB+uKeKjNeSTPu5I3Rin4vkCfbb4UnnWCAjm/kEwecMGPY0qPe1iD6Zuxj5BX7fVi6Mvk2LQqbcCFN41e0vxL7Pqccu7ATCNp0jyh1BUqHw55y9xzX3w+o3o0ZmOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c1Ysd++d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OIKb4VHH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c1Ysd++d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OIKb4VHH"
Date: Fri, 16 Oct 2026 07:55:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792137334;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8JGJxYjAh3S8zQg9t4gn4BpuOpa6oyb1sCXm6d9llo=;
	b=c1Ysd++dDTV+ajDSwTmtbMg70DiRJ2MkQZjOkbcBgm3hxr6tIsDlPRIThx4fYsMLiAnvJV
	5jbK2a4nChClVK9Uoyz6DxyC/qnj1F8fjV6Dul/vy7TiF2Mms3xXcJZzR7qnN5gpfCN2TB
	aIXACk93fDZlYbs6CEeh+MVgzt19LxvFXICSyAL+FTBPJten3W9dHknzlZ5zipRMMcnLnk
	61HjYzrAUxO+MsG4U3KtvwROdOfVB77hfS+jYIsTuhZKWFdN5MZMtcPlfOywaULInKUWQL
	1Ra55x51ooYoQds24vhIPkpzUQCUz02+Q36CrLTmVbjPL3Ye9n22bpnWkTOYKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792137334;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8JGJxYjAh3S8zQg9t4gn4BpuOpa6oyb1sCXm6d9llo=;
	b=OIKb4VHHo8CuWJQXhyhrCVG4S/e52A8njaUssEF47i4dz8XRQXbq8tIE4cTkZz+80loVT3
	FoWZDYVuJrtbjhCg==
From: "tip-bot2 for Antoine Huret" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf: Update cgroup time when rotating multiplexed events
Cc: Antoine Huret <antoine.huret@bull.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261015-perf-cgroup-rotation-time-v1-1-93e177dfee5d@bull.com>
References: <20261015-perf-cgroup-rotation-time-v1-1-93e177dfee5d@bull.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179213733278.2666988.9877476391312937926.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     e4c7c401c6b9174c0c893084fdaa6a84bd2520d7
Gitweb:        https://git.kernel.org/tip/e4c7c401c6b9174c0c893084fdaa6a84bd2=
520d7
Author:        Antoine Huret <antoine.huret@bull.com>
AuthorDate:    Thu, 15 Oct 2026 14:55:56 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Oct 2026 09:49:01 +02:00

perf: Update cgroup time when rotating multiplexed events

Since commit bd2756811766 ("perf: Rewrite core context handling"),
perf_rotate_context() only updates the context time before scheduling
out the flexible events. It no longer updates the cgroup time, which
ctx_sched_out() used to do.

Cgroup events take their times from the per-cpu cgroup clock, so
between two cgroup switches the rotations see a frozen clock. The
events rotated out lose the running time they accumulated, and the next
update, usually a read, credits the whole interval to the events that
happen to be on the PMU at that moment.

As a result, the time_running of multiplexed cgroup events is wrong,
and so are their scaled counts, as long as no other cgroup runs on the
CPU, e.g. a busy job alone on its CPUs. Counting cycles over one second
of a busy loop in a cgroup gives from half to several times the max
frequency of the CPU.

Update the cgroup time before rotating the CPU context, as was done
before the rewrite.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Closes: https://lore.kernel.org/r/PR3PR07MB69223331EED5BEBE150375B7849C2@PR3P=
R07MB6922.eurprd07.prod.outlook.com/
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Antoine Huret <antoine.huret@bull.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261015-perf-cgroup-rotation-time-v1-1-93e177=
dfee5d@bull.com
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index dd3c82b..c4217c9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4639,6 +4639,7 @@ static bool perf_rotate_context(struct perf_cpu_pmu_con=
text *cpc)
=20
 	if (cpu_event) {
 		update_context_time(&cpuctx->ctx);
+		update_cgrp_time_from_cpuctx(cpuctx, false);
 		__pmu_ctx_sched_out(cpu_epc, EVENT_FLEXIBLE);
 		rotate_ctx(&cpuctx->ctx, cpu_event);
 		__pmu_ctx_sched_in(cpu_epc, EVENT_FLEXIBLE);
