Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262C54E4331
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779382; cv=none; b=SItM4yQ+wMdt+8XFYzahs2JQjp1DHdwUgubcayUzdP8jvj6fIga7dH60nUZSk5KtJFSz+alCY3o8trIQKpuFpIHo/qMC3NO6DKREmUYBIpoW7jUfIwLc1ZK8jyD/VHAaJ/1bfAhscCQDIMhQa+gRVDFEENme6Kqt8yuVOLa8be0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779382; c=relaxed/simple;
	bh=8UcWVXM+EmggUJG9RPNWsrlMH3hzHO+NyygDLU1YsGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HN4U+Q0T6M4AAw0Ahh3PuZ/ucggMTjf44Aw0HyEUjurJ9jBpSAbWfNJOauwDYVjodHgGj5vq9sAINfIPBc0CaTqNn2hjC7XgcS/a7EHyzxXWlJoxZbmM8RcOtVluLLcW3MkTw6G7F97C4wnnx3JCq3HLg9G08RjYUr+cj9UfiWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dy32UqnP; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy32UqnP"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-8209a96e0e3so254337a34.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790779371; x=1791384171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lCYghwym+9Y4w6eXWM454UE/qTUCfuDedvhfnXRMawY=;
        b=dy32UqnPl+BzkaikiClvupMqvPh0AuM/W63XwSJmOz3zVdaePgQuOESYOQyeo8Tc9R
         PcH1UnP0d68nfvfRIpnqKYXCjNIHpkmIMDqTK4ekfip38Ur8PuKC7xRXpxyc2JXlU27H
         HBApB4YGWEtZGNL4it5Dbokc2b1me2xYUnEmPhN21LCP5PmZYV5fOG0TdAaI90kTVORZ
         OVbnnHvHJPsm+7BOsvUCZ0339uG7ptC7F/+lUEdn/KrhphQcXL8GeoYj6O2c4NLy2DPy
         1lTbHy9V0T94+QeRMYLACUBLcOLzV73wvB402U48SBk5ZZjHXm+P0MSEMJpZ+cRIBNPf
         OHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790779371; x=1791384171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lCYghwym+9Y4w6eXWM454UE/qTUCfuDedvhfnXRMawY=;
        b=URdoOzj29HzVwGQHdFNs6sQ6L+Ehb7UeWexE4DszlE7iP55zd8N3xnVsKkD2bmh9PY
         Yq9tDEjSpTFAnDRI0mzVWEJ9vePGKPJ7HmnXhJeYHr7KJf/b4mPbZCRAWclQjQ1AnNM2
         zZUVcIlY6m9fKZL8sq6VtvJTGY2Cfbk8NJXcY0ZD9ZPGvGe2UBnJ7wjXhaGxTOH/KZz8
         GbyCczL8CxwgfFhywHl9MHs6DiYdpES/sejghy3Y4hJFxtg3KS6sS9tYXWsDQFwG5zv+
         39pUKxxxp+JllWvZ/WzSNKGuIGakggGAV/4A0kllCYMDr+59FLcJO0CxdugKTI0AW9t3
         K3ig==
X-Forwarded-Encrypted: i=1; AKwUvByzeyuDk9yO4UwTfjyI3c9jTVZxYJgB9E2oTyKWdHrFVhTu4Hwm7n3beX0SEWv8PKnvaRxGlmA=@vger.kernel.org
X-Gm-Message-State: AFuF++ma7fJ5ydspWrEmTpjfKxgkfIBhC9e05bRJB3K+uMwulIyvrLPK
	3NDUoUqz29bv9UIAVyi9+a+WQbjWFpGh8MSXcPJ98r2JNz1S2Fp1KsX4
X-Gm-Gg: AYBFou2RnqUhUP5kkqt+PlAA/rJSDQVTCeOz4ykVOwEvpVAKyJkdP70SqSWJ8hEtKM2
	z1liVry92DpG/v1Aa1HxJdNtKmfHKcONevaoMa5d6Paj2d6E49AhpUxSNvZyx6h/bJ4X7MY78Ah
	hEDtw1gThkcB/ygg13h2QS1nP2cwOxZcOgKTxwrTwAvF9gE69ekuduYnWUldXNr4fjvGFusW8DO
	c3dOoEfcNCokizta6cS2+0C/uz4UzLlvN+XdJayelNwHacltu0JiLnubTxCx5Psc6ltOIVSW9Ku
	ppyemIdjVhN5MPkk0tXQ4euI9+R5ItpOkgvEFeyTBzyJNM+GBsQ+LOc8jYTl/jDA1sTTJ+CmFJW
	JWAkO0BT/LEi3ycehDW8sSd/R2HnuZXFtMmPc0AzhZ/TUi4IsWjeNgnH9j53/cZu7MNjRmbuoBi
	BqvG8nj8nZWfWrELlbKinMd6NFh1l5BFwRjG3ubQpIf9csEdDOrPl7i/uNF57voXYq8WuWm3SVG
	nIylKvF7DzDJBms0EYu1fJDoCQE0vwoJTmg4Turi6pnOUoOe84=
X-Received: by 2002:a05:6820:60f:b0:6b8:ce67:77d5 with SMTP id 006d021491bc7-6dcf1ab0479mr1793103eaf.13.1790779371494;
        Wed, 30 Sep 2026 07:42:51 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-820635e68b3sm1091810a34.17.2026.09.30.07.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:42:50 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Marco Elver <elver@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] perf/core: Don't send SIGTRAP after exec removed the event
Date: Wed, 30 Sep 2026 09:42:48 -0500
Message-ID: <20260930144248.59858-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sigtrap event must also set remove_on_exec, so that its SIGTRAP never
reaches a program after exec. But the signal is sent from task work,
which only runs on the way back to user space. If the event overflows
shortly before execve(), the task work can still be pending when the
task enters execve(), and then runs when execve() returns. By then
perf_event_exec() has removed the event and the new program has default
signal handlers, so the SIGTRAP kills it.

The exec_stress test in the remove_on_exec selftest catches this and
fails about half the time in a VM. A process that opens a sigtrap event
on itself and then calls execve() is killed by SIGTRAP in 15% to 50% of
runs, both on an AMD machine running v7.2 and in a VM, with or without
close-on-exec on the event fd.

perf_event_exit_event() sets PERF_EVENT_STATE_EXIT when exec removes the
event. If the event fd is close-on-exec and was the last reference to
the file, exec also queues the file release as task work. Task work runs
newest first, so perf_release() runs before the SIGTRAP work and moves
the event on to PERF_EVENT_STATE_DEAD. Exit is already caught by the
PF_EXITING check in perf_sigtrap(). So don't send the signal when the
event state is PERF_EVENT_STATE_EXIT or lower, which means the event has
been removed. That also covers PERF_EVENT_STATE_REVOKED, where the PMU
is gone.

Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Notes:
    Changes in v2:
    - Skip the signal for every state at or below PERF_EVENT_STATE_EXIT, not
      only EXIT. With a close-on-exec event fd the file release runs first
      and moves the event to PERF_EVENT_STATE_DEAD, so v1 still killed 360
      of 2000 children. Reported by Sashiko.
    - v1: https://lore.kernel.org/all/20260929182935.355892-1-danishkhateeb03@gmail.com/
    
    Tested on v7.3-rc5 x86_64 under virtme-ng (KASAN, lockdep, 8 vCPUs on an
    AMD Zen 3 host):
    
    - selftests/perf_events/remove_on_exec: exec_stress failed in 9 of 20
      runs before, all 20 pass after.
    - The exec_stress pattern in a loop (30 inheriting children, 50 rounds):
      a child was killed by SIGTRAP in 17 rounds before, in none after.
    - Each child opens its own sigtrap + remove_on_exec event and execs:
      756 of 2000 children were killed before, none after. With
      PERF_FLAG_FD_CLOEXEC: 836 of 2000 before, 360 with v1, none after.
      On the bare-metal host running v7.2.6 the same program kills 297 to
      1033 of 2000 children across runs, and 1012 of 2000 with
      PERF_FLAG_FD_CLOEXEC.
    - sigtrap_threads, watermark_signal and mmap pass before and after. No
      new kernel warnings.
    
    v7.2 fails the same way in the VM. I did not test kernels older than
    v7.2. gcc W=1 and sparse show no new warnings.

 kernel/events/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 634d2ccbab82..eabe6cdf7a88 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7631,6 +7631,15 @@ static void perf_sigtrap(struct perf_event *event)
 	if (current->flags & PF_EXITING)
 		return;
 
+	/*
+	 * The event was removed after this signal was queued, e.g. by exec()
+	 * (remove_on_exec), which may also have closed its fd (close-on-exec).
+	 * The new program has default signal handlers, so a SIGTRAP would
+	 * kill it.
+	 */
+	if (event->state <= PERF_EVENT_STATE_EXIT)
+		return;
+
 	/*
 	 * We'd expect this to only occur if the irq_work is delayed and either
 	 * ctx->task or current has changed in the meantime. This can be the

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.55.0

