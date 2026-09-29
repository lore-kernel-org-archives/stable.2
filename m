Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34FA53FD2B
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706582; cv=none; b=Gg2zQdBqQftkauorH8BjWNiDE+dsdlsc7jQVzSYoVKyxQguMRqC5qAw4GEas0KdUf3p2mP1gSBZMzdtSVBZlR51HdZHlnyUVlcwDPm1sBM9bQ9nqWKJs1xobPLsC0SdWUjeXzvysjWqUw3+5jOD6uOT5mas+3XDR7R2b8PCbums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706582; c=relaxed/simple;
	bh=/5++U61XAoH/VSVR//J0hU1yz7OfZSDFFShlI6bBPSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZmNuVbBY5c3wTnG+jwC/w9cxt8fmf9sJu/WOq+NyZ2y5ufmjDRtu1oAcK9fKithxFoSrEMTHepW+5R5BW2ZoPW4FkjJBdfFFjRsR5O5RmezUSGUtdlZOMI4k92BPXniuz3dG7rKqvt5dGOLrvyWq+JaW7WCssQxNnwyH6BUcAfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd+Ek8qX; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd+Ek8qX"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-8137b129131so3010296a34.2
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790706579; x=1791311379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tHysdsRd5NU3JnGkGkLnvGMuzNOaAa664hZky0TTqHs=;
        b=gd+Ek8qXyOpE9n6Jo1f5u8uKmu0f9afK+GbuncFu6rrXqQ8/7v9oPtwE9XtOphxMdD
         peCW1l1O6XOvR2biQxyTBz8t7f6uk3/XPKdXwTwel67k8BbsBQxQM4TyNn+MGegVl/ro
         CuuWfPe3stP3fLwLkm3YVUOfh3+Z5T3TN3KtbI8kfxC6wDn0sxPqC6SEyoIeFUoS0loA
         UL/sFMIQ9TmeanCr3zXa/8edcPXhpnZL1IAy7wx0a2o8OXSWakX2/lw2vXXZFZYwSIkd
         sVZXxFrxOiAJ+vQ0Tq7VdCFoiZ6RJdnEMAflNGnoR/QQ4n0xfKN6U060nhUC+civXuh7
         Fbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790706579; x=1791311379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tHysdsRd5NU3JnGkGkLnvGMuzNOaAa664hZky0TTqHs=;
        b=m+YjlC1XU4Nzw651ZvZtNzV0KQywx7dK93irlRi8M7l0gC16YxmZdNKa8Jmfi7DzEG
         hY1AVolP6VmSLK8QLWBh4OLKEdeCC5JH5zfd1NKCX8AM9wrh2C3EViyhOB5QgjpUAlr2
         mizFonB/mPm6Ymgh8hSDLL6Td2lYfVbFKeafjo7Q+wxNAn+XbzKerJHJA9MH2f0XqgIQ
         LhM1sQCeYUuLRgHgfb4Q8CsNW/sIjJjYhHH6PZR5+f3ZCUJECr0yMwOfq/emb8dwJswu
         SDyCB5ZPdZxYt9nP0J33fA+O4YTeXM5yvUUQ6bEBgWEI4eNiyWJSfN86UORi1EY2a70p
         hTQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNplnXuaxLHVJiWDK7hrRXu59dhU4psdjTyZ9GgcuqnDGf8QyfCtpwaTAZKDgxe3O3+5XYvbw=@vger.kernel.org
X-Gm-Message-State: AFuF++mPltkbhPg/xfLeTY7MDalJ5SClc1/B3e94zsh1Wvo+trHY9avI
	jX1PZOH5SDsq5/KHDjjl6ndkUrUfJC4vni6OL18dzR9YWPaqSpG8jO8ZFVpbXD2Q
X-Gm-Gg: AYBFou06fkHhRnZkFNV9yvPyBHnVtNPRn7KCyudY6l54PWTyeq/TmJknK74JFYglK8X
	ZRiaRUwxci7depQErwNrXkh6C5G0BZpYEukhS0uHGIJgU2EPKmqZNkUlNmR4eWz/hyS1pu8Wcio
	Kmwnjb3ldSY0OI4/v6o5vHDIME3LNSMJU5Rpg1ML7OS8l+azsdiJowQZEQLhKv0joTQbhNARWLh
	+9y7DyLbPN41UT5qcpW4RopkuTLG6/9vGGHP8YP3AbWZexgPmH5Z8FplFYzMN+UGMvyST97auAb
	0bIncpsnRyzr/fgurMlFKrOQoU85M2s76K+k4mQW75y9Zci1Jz8FrtKCOThNMaAvLt6EcwzxbB+
	xMC5ZrAqt64D3iykuov38XdbKrif21MvYnVNqIowXJ1W29f1q6cGDJPFG8l3srZflRtsEgaK56j
	NeDQ9d7rcgZ441QBfCc6Wj9q7Kn5ixMbjYxhnNnqEXwoSlqBNKiI0P6RI+7EQgXUTj7D+llM7c0
	tHRbPZ+G5w3PL/yDbcTLasfpbdCdacDxvQvESwY
X-Received: by 2002:a05:6808:2385:b0:4d6:9293:9bc3 with SMTP id 5614622812f47-4f06f2dcc17mr348674b6e.61.1790706578607;
        Tue, 29 Sep 2026 11:29:38 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f0ade01337sm821b6e.8.2026.09.29.11.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:29:37 -0700 (PDT)
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
Subject: [PATCH] perf/core: Don't send SIGTRAP after exec removed the event
Date: Tue, 29 Sep 2026 13:29:35 -0500
Message-ID: <20260929182935.355892-1-danishkhateeb03@gmail.com>
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
on itself and then calls execve() is killed by SIGTRAP in 15% of runs on
an AMD machine running v7.2, and in half of them in a VM.

perf_event_exit_event() sets PERF_EVENT_STATE_EXIT when it removes the
event, on exec and on exit. The exit case is already caught by the
PF_EXITING check in perf_sigtrap(), so an event in that state there was
removed by exec. Don't send the signal for it.

Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Notes:
    Tested on v7.3-rc5 x86_64 under virtme-ng (KASAN, lockdep, 8 vCPUs on an
    AMD Zen 3 host):
    
    - selftests/perf_events/remove_on_exec: exec_stress failed in 10 of 20
      runs before, all 20 pass after.
    - The exec_stress pattern in a loop (30 inheriting children, 50 rounds):
      a child was killed by SIGTRAP in 20 rounds before, in none after.
    - Each child opens its own sigtrap + remove_on_exec event and execs:
      1078 of 2000 children were killed by SIGTRAP before, none after. The
      same program kills 297 of 2000 children on the bare-metal host running
      v7.2.6.
    - sigtrap_threads passes before and after. No new kernel warnings.
    
    v7.2 fails the same way in the VM. I did not test kernels older than
    v7.2. gcc W=1 and sparse show no new warnings.

 kernel/events/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 634d2ccbab82..948583ffeb53 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7631,6 +7631,14 @@ static void perf_sigtrap(struct perf_event *event)
 	if (current->flags & PF_EXITING)
 		return;
 
+	/*
+	 * exec() removed the event (remove_on_exec) after this signal was
+	 * queued. The new program has default signal handlers, so a SIGTRAP
+	 * would kill it.
+	 */
+	if (event->state == PERF_EVENT_STATE_EXIT)
+		return;
+
 	/*
 	 * We'd expect this to only occur if the irq_work is delayed and either
 	 * ctx->task or current has changed in the meantime. This can be the

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.55.0

