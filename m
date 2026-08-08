Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ED93812D1
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786214623; cv=none; b=Yr+1UfUyzhWeJH+oMpPqFQjXo5CyWgD3qjFuiYnxXTf7V9Hhos6/EwArJbmT7jluvkoPAF5aLS8fuhxxZ4nJm71RBhhoadpROc/Vm8UKDqkiEMyHUyRwHi7TTP/asIPYXROOmcLONhgSvhqFMm+ftitIUCe+Dc7YBTGVsNQpzRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786214623; c=relaxed/simple;
	bh=+f80H6CGsdL14mjsjky1UiCV67OSbQcf10vSwhEKeqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uzHz7/Nk/kM9iJFs6WTZi4lqNnqVp5zNLrxHtDBtR/fE8Qx8nUxCxf7kb/yOQU0WaT/swMOYY31S+6/sl9+kllqV/ozs68YIf0b71IX9QUQZ2Y0BjN+539pmkB+mKfb1+sbmzVFb+7+1SQjAS4PAqFFkSRchtg0lcfugsYgotHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVR1u2FL; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVR1u2FL"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51a868b6962so6808991cf.2
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 11:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786214620; x=1786819420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IcA2oqrVgPRK/4M6/qUH3MmuJSmZ2LO0m1bFg3C3ijo=;
        b=aVR1u2FLX3HRYLWHPPJXm8Oji3DF7plripw3vEJWRmXMKI0Ks8QCp2hGVQla+llA+d
         qbXaTOL+f30RyKMlquVpQ9WfLHrnqz/XInpRqaGQ4xOjzx8CLTSEmMjiQKWEJgvCGS0x
         /Sz8ZNC4KvXxcGcIqcQmGOzG3oc3n0PoQNc1M8IAD+M8fELwvZ4533MpBPmAMZIR2cEO
         o8nILxlSshgMMC0Kdc6b0bA/voC8GRih0Rqu890Ow9HbuJMDtA4xCoS0731/WfhJJkZ9
         4BvV3P9YoxZbSZ0dm126qGgLvdktHhRS51N7lAuzXqTNCg8+6seowORPdDFi3lXO9nab
         wErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786214620; x=1786819420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IcA2oqrVgPRK/4M6/qUH3MmuJSmZ2LO0m1bFg3C3ijo=;
        b=O456Cj7srlJxh9It85VC6tmHzScRMFJUl1cNy+sYcAzZ0UAC77CDtcPg/0Buupj4Q6
         +kiehb4fqB+tFDfHMtdhjN5t1LfeZFMUUNjDw47xpuzlHgQiE9PU4XBBfdEiR+7yQ8yy
         0dDFXt0H8s9IjxYY4nYwxLs4SOcQRPvMOT0GR+Rq4GEHuuvmSJ9Ws/APv6Gg1rwUo3Jb
         blcMV0Z5CK7CkwMQAznrOPvYUmP5dqLWFeDFsDRBs+wMn/OWtl5N0dV6CqiIh5rW3byQ
         x2yX83fdxZy4eY3sZQYQrIfWefJC22tiVCyp7c1VG3OB000h56nVSelGcnOsn8B+wqU1
         /Heg==
X-Forwarded-Encrypted: i=1; AHgh+Rq4oQYslLBT15xHSSxjvYBabE0ejX7OcdRqq9YWILqqORz+Cj1Q3xqECZeYSJUKEcHXRPatoKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjYFtdn86LfmVt/rNwjerVwMtwojfX+MUg0/DuRfXAxNbkVdQh
	wA7HYj82fYo2MxRYxknvj/eDTUBb6QXKaQpSHTe6moGy9Xz79winubj5
X-Gm-Gg: AR+sD13uFdBAcz0sGUIC8kh0pAF/PXyYPbLgCpg36TfkSfI042a94HPdVP1cXZvDF7i
	+xMvcTovVONUO1+SOBpc1f33483oXZIHY3dpGEBcpScaF8COt0CVQuKDWvBnY5IgzP9k8N5sK9j
	GTC8foy4DvKCUFTnSE5eoBFc/+4tv9XG8WAltfwaLlh+h/VG6kCo88MRHvKDpsPzBws6b5Ni5ni
	xEN/QGu8UNGRN2mahOT+jCjMgZZ7bYxCb1rcQqA2gdJ0/C9Ds8Dusb1/SyoKjlrsHmFGAdlCYK6
	oYmYq7QQcFHit6R6lQxhO6Pow9Po/lpZihNRDo+E6Gd5F6OtGuY1dHISpGZMHxdg4U75j1Zi4Yu
	1M/F4bYKXQcIb+vtO2TP7298BP01GAteQnXWPCNUDQDzmwVhcYl4q/QLvvkB5BoxvK62PHVxPS7
	CEGLdkXZOR/tkceXJNlD6csl6cxCtO06a1rYjYRp8EUmHdszYmwVCew/hUO19LCsp4RJeyWuqcz
	p8zvKROppoWPd4q3A==
X-Received: by 2002:ac8:5842:0:b0:517:6d82:ceff with SMTP id d75a77b69052e-52d2095c085mr103116771cf.13.1786214620580;
        Sat, 08 Aug 2026 11:43:40 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d1663e9e1sm38128721cf.30.2026.08.08.11.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 11:43:40 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/gt: Fix request use-after-free in heartbeat()
Date: Sat,  8 Aug 2026 14:43:02 -0400
Message-ID: <20260808184302.1509585-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Fixes: bf9bd6a5128a ("drm/i915/gt: Track the most recent pulse for the heartbeat")
Cc: stable@vger.kernel.org # v5.11+
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
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

base-commit: a59f57e2aa127c5354168d2ec4bac920df1be4f4
-- 
2.43.0

