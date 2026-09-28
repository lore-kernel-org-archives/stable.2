Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4593B4D17BF
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790638683; cv=none; b=UCIrYdttNS2vvqXzpzr0Sibdv1O2Yxzm6tX1MVPaPsHN7zWkMyR2pZxO6bqMQF5S12YjrGD0qbFTtRcgsu9I7O+DleyQf5MayLX25WdMYvF7A3HTLBWARmO42/VdHejAKULV79DhdJNt0TjO6Jz8FCT7vFk1eLZcIZNs4LCt7Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790638683; c=relaxed/simple;
	bh=UizoVDxMJSChmzHkokQBY5XFbU+b82UuYjggKsQ1RCA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q5lOHdy+gJG3PCUQ6WPEodyeC36Kv6cCghnnmIKPkoGyGy8C3i0Be7YmCBWvlU6i7eTIsg4zui6bHDOVCx5PdN0ajdwYqWKgfPwNV639/MrKDr2w7Yp8VqCLKm9h/cQlqAzOF+fyJJTINf8Mxo1/1wFq3YbDdCTes+WS/J5/2LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d6AzCEvH; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d6AzCEvH"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-14373747468so3284229c88.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790638681; x=1791243481; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=26dak7J/RLVeINbEtqAzmWrMUxm9/Y3gwde42VTpH7c=;
        b=d6AzCEvHyWFNhyU35ROzXAEq55gnz0856Nl1XjQ0NmMMWDzdHREuk5auKiZVpY0EyT
         4JdEAHZDSLLkh1dMpGYCKJC082leaE6Rx9M7Kaj9M14yjuGptnLqBDudqdLzjWqnjF/G
         +z13OWsBiSbiChbuzUQAjespCTxnjy8xPj92JuQgeEm+RSLbo1h/217NQbU52KFvdelx
         5HX7Z01cUScRoX5Vqix195o+V+kTbhpNqf7jOnC/DH2Pqb6M9F8P70Ateaux2FgkCmAS
         wPM/P/4/r0sG1eK0YoUI2qYN3x3NCQlDPIrkKCh3vbkFPvt6JJF3PrhlX9fy+Py9xz+X
         ha+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790638681; x=1791243481;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=26dak7J/RLVeINbEtqAzmWrMUxm9/Y3gwde42VTpH7c=;
        b=V5ovHainEf3NptOykulUJGVrW4GCO69Wpn+6CiOrCr1DLc7WYzVPSpt8R6d4K9sy5m
         JNCdjrJE+Z2o84JzlP1xJKrwgmDXLd7GyAjtjP75JKJB9koa5BGuFGjGAz075a0NyQ4W
         9vrOF3ysTbDmzBR6RoBdO0zC3orjLSO9oM+9cUd9iaQmWTgNHwRf49Oy5NsA/VVxo8Av
         4p7RKU4bNg2JIysq+OS0bEoQoTMMrDZnx5ZiBebkeJ74WBcu1rUWnJwGYGcuoeTzIwfn
         fF4rC0sa+fc4Xwc5QG7tgZxr6HaBlXRUKPgsqItY6+E6KRLOiBsx01QzeYdXwbeJZ9Ay
         eWLw==
X-Forwarded-Encrypted: i=1; AKwUvBzd/hp7R908zJsvXO0ygaqNIRBKEkfCxzwfhWm2RHqqX7psE9uiVjmHMumn12NZqF/HEEPyt1s=@vger.kernel.org
X-Gm-Message-State: AFuF++mJ2qVmqKfc9B8h7cG4KOCqm9DrcrWgP2uxJXxwu+9F+O0zt8t3
	QwzR2pXp+uCBFVAKd64XNl+6zSRZXGfRjzW+wwqgwAwijvG3D4nAA2vswZJBQXItPvNQD8v2ZRe
	DZV11Qfde6Q9HyA==
X-Received: from dlbpu5.prod.google.com ([2002:a05:7022:e885:b0:144:f4b8:ee5e])
 (user=stevensd job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:281b:b0:144:f4b9:9be4 with SMTP id a92af1059eb24-146ce492cb6mr9987436c88.15.1790638680897;
 Mon, 28 Sep 2026 16:38:00 -0700 (PDT)
Date: Mon, 28 Sep 2026 16:37:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928233743.3777102-1-stevensd@google.com>
Subject: [PATCH] sched/psi: clamp negative cpu_clock() skew
From: David Stevens <stevensd@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Suren Baghdasaryan <surenb@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, David Stevens <stevensd@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When working with timestamps, psi is careful to only compare timestamps
from cpu_clock(cpu) with the same cpu argument. However, on systems with
a stable clock, that cpu argument is ignored. This means that despite
psi's best efforts, there will be some cross-CPU cpu_clock() timestamp
comparisons.

The cross-CPU skew in cpu_clock() timestamps is generally orders of
magnitude smaller than psi measurement intervals, so the cyclic times
counters naturally absorb the jitter. However, if get_recent_times()
executes immediately after a task on another CPU enters an active stall
state, then negative skew can cause the u32 active state duration
calculation to underflow. If that state had not been active since the
previous execution of get_recent_times(), then times and times_prev will
be equal and the very large underflow value will be passed out to
collect_percpu_times(). There, it will be zero extended and folded into
the u64 total accumulator as a very large delta of about 4 seconds
scaled by that CPU's share of nonidle time.

That large jump can lead to spurious wakeups for the PSI_POLL aggregator
or incorrect values for the PSI_AVGS aggregator. Spurious triggers or
nonsense psi values (e.g. full>some, psi values >100%) can cause
userspace to take unnecessary corrective action, such as a userspace OOM
daemon killing processes to relieve (non-existent) memory pressure.

When running browser workloads on an Intel N100 with a sustained
psi.mem.some of 2-3%, this underflow is observed once every couple of
hours.

Clamping elapsed time to >= 0 prevents this jump from happening. It does
result in the total accumulator being slightly elevated compared to what
it should actually be, but that error is bounded by the skew and is in
practice always smaller than what is added today. Note that expanding
times to u64 to prevent the u32->u64 conversion from causing issues
would result in userspace-facing total counters no longer being
monotonic, which could break consumers that derive rates via successive
total values.

Clock skew can cause issues in two more places. First, negative clock
skew in record_times() can propagate through the times accumulator to
the delta calculation against times_prev in get_recent_times() and cause
it to underflow. Second, the elapsed time values calculated by
successive executions of get_recent_times() can appear to go backwards
if the first execution has positive skew and the second has negative
skew. This can cause the delta calculation to underflow, since elapsed
is propagated in the times_prev value. However, both of these require
that the growth in stall time between iterations be non-zero but smaller
than the inter-CPU skew. Neither issue has been observed in practice and
they are not addressed here.

Cc: stable@vger.kernel.org
Fixes: eb414681d5a0 ("psi: pressure stall information for CPU, memory, and IO")
Signed-off-by: David Stevens <stevensd@google.com>
---
 kernel/sched/psi.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 4e152410653d..893ad16ff42c 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -305,8 +305,24 @@ static void get_recent_times(struct psi_group *group, int cpu,
 		 * (u32) and our reported pressure close to what's
 		 * actually happening.
 		 */
-		if (state_mask & (1 << s))
-			times[s] += now - state_start;
+		if (state_mask & (1 << s)) {
+			s64 elapsed = now - state_start;
+
+			/*
+			 * When sched_clock_stable(), cpu_clock(cpu) ignores
+			 * the cpu argument, so we can end up doing cross-CPU
+			 * comparisons. A negative clock skew can result in
+			 * underflow to a very large u32.
+			 *
+			 * While the u32 cyclic accumulators in groupc could
+			 * handle a very large u32 from underflow, folding it
+			 * into the u64 totals in collect_percpu_times()
+			 * would result in huge jumps. Clamp to avoid that.
+			 */
+			if (elapsed < 0)
+				elapsed = 0;
+			times[s] += elapsed;
+		}
 
 		delta = times[s] - groupc->times_prev[aggregator][s];
 		groupc->times_prev[aggregator][s] = times[s];

base-commit: 1fb28c664a19df8d45a6afa04d28d102b04ea680
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

