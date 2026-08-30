Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9531E2DD5F6
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788130656; cv=none; b=dS7ncXaSPf2R643oqsl93lDSHhvEb5Xf8GBWnaYLtdKmpjad9HMSkd3WFMLco9trBrhWyQ4X8cor/P5naO54QX9rb0Zlm/OK5juNLcGS9z2ZNzYdqAhR8Z95pk4UbbEqHAQlc45Kj/T6hbUt80fcHjjDzXs8puiWhkM9Hr5qDDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788130656; c=relaxed/simple;
	bh=Ad9yRHvDQtFuoBqA3+pe46EqYnhK2EEZFrfm0wDqIJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=drw6CPMi20Rd9th3GkPwF6lukyiGZ8AkB4j150c02eTll3JLbBeeK8gWzVKPFrIHpwF90rT94cY9jreyGXzOxvGZCfpfbfsOg1UYTmzG1kV02BdtJSWrr1/OJxQ3ys86IrAzokM1tbeajkrFOa0+C9UvZswwPOIqVQ0ev1r7L3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A0D1F000E9;
	Sun, 30 Aug 2026 22:57:34 +0000 (UTC)
From: Andi Shyti <andi.shyti@linux.intel.com>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>,
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v2] drm/i915/gt: Fix request use-after-free in heartbeat()
Date: Mon, 31 Aug 2026 00:57:08 +0200
Message-ID: <20260830225708.3959691-1-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

heartbeat() detaches engine->heartbeat.systole with xchg() before
checking whether the request has completed. If the request is complete,
dropping the detached systole reference may free it. Concurrently,
idle_pulse() can observe the empty slot and publish a newer request.

The worker then sees a non-NULL engine->heartbeat.systole, but continues
to dereference its stale local rq. The newer request can therefore make
the shared-slot check succeed after the old request has been freed,
causing use-after-free accesses to emitted_jiffies, submit, and sched.

If the detached request is incomplete, heartbeat() can also overwrite a
newer request published by idle_pulse() when it unconditionally restores
the old pointer.

Use cmpxchg() both when idle_pulse() publishes a request and when
heartbeat() restores the detached request. Drop the detached reference
when restoration loses the race, and reload rq from the shared slot
before dereferencing it.

A KASAN-enabled i915 mock selftest reproduces the use-after-free before
this change and completes without a report after the fix.

Fixes: 4c71fd099513 ("drm/i915/gt: fix refcount underflow in intel_engine_park_heartbeat")
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: <stable@vger.kernel.org> # v7.0+
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://patch.msgid.link/20260808184302.1509585-1-shuangpeng.kernel@gmail.com
---
Hi,

I'm resending Shuangpeng's patch[*] so that it's tested by CI

Andi

https://patchwork.freedesktop.org/patch/745366/?series=171942&rev=1

- Changelog:
v2: Use the correct fix tag

 .../gpu/drm/i915/gt/intel_engine_heartbeat.c  | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
index 6424ecce8bcb..fc6c53c93cf5 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
@@ -81,10 +81,18 @@ heartbeat_create(struct intel_context *ce, gfp_t gfp)
 
 static void idle_pulse(struct intel_engine_cs *engine, struct i915_request *rq)
 {
+	struct i915_request *systole;
+
 	engine->wakeref_serial = READ_ONCE(engine->serial) + 1;
 	i915_request_add_active_barriers(rq);
-	if (!engine->heartbeat.systole && intel_engine_has_heartbeat(engine))
-		engine->heartbeat.systole = i915_request_get(rq);
+	if (READ_ONCE(engine->heartbeat.systole) ||
+	    !intel_engine_has_heartbeat(engine))
+		return;
+
+	systole = i915_request_get(rq);
+	/* The worker may have restored its detached systole in the meantime. */
+	if (cmpxchg(&engine->heartbeat.systole, NULL, systole))
+		i915_request_put(systole);
 }
 
 static void heartbeat_commit(struct i915_request *rq,
@@ -152,9 +160,11 @@ static void heartbeat(struct work_struct *wrk)
 	if (rq) {
 		if (i915_request_completed(rq))
 			i915_request_put(rq);
-		else
-			engine->heartbeat.systole = rq;
+		/* Keep a newer pulse that raced with the detached systole. */
+		else if (cmpxchg(&engine->heartbeat.systole, NULL, rq))
+			i915_request_put(rq);
 	}
+	rq = READ_ONCE(engine->heartbeat.systole);
 
 	if (!intel_engine_pm_get_if_awake(engine))
 		return;
@@ -163,11 +173,11 @@ static void heartbeat(struct work_struct *wrk)
 		goto out;
 
 	if (i915_sched_engine_disabled(engine->sched_engine)) {
-		reset_engine(engine, engine->heartbeat.systole);
+		reset_engine(engine, rq);
 		goto out;
 	}
 
-	if (engine->heartbeat.systole) {
+	if (rq) {
 		long delay = READ_ONCE(engine->props.heartbeat_interval_ms);
 
 		/* Safeguard against too-fast worker invocations */
-- 
2.55.0

