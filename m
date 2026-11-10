Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352557;
	b=ffJ303PKudZIIvucYm3irK9GoiyUKlPIFj9ak3boeRcRNSn/0dnC/TC754yoTmETomiF
	 wA27VNzuXjHnVmnMVK5V2EY+PIZ0b85OXpuzal538X3jhpopnMdb0vW7pN8DxfOGL0FMW
	 4kh6b4tR80ZEl5ne0mQU1Hl55+kcyb9/8p2NMS6yyQ7sxQEGJUuAoll0Dmz7QTPEjXqXJ
	 haf/QwZlA6hqDcpBXM63iIgugEHTWZb3uYAcvY7WeXmhSCziA9SZ7wDHwUx/Hh/XLDz4B
	 tOWHuWISVm8wOwVhwEAXhF3XLCZ3e8SqS7A7nM2iJJ8AiihAx6cBZdgS93A8NpNNVhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352557;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Museo8it0wG573lWE+ORLezRYLN5f0x5kMTWf6XHwNw=;
	b=zUDvUzy0HYg6cWjQ3fkkhj1sAyALgB8FmjGfZuRHap4OoDT1WH+1fyJ+wsckj6nK0XUr
	 7JiH3jF8usi9cjufad4Q91TkwrWvnGAFvogUG87gQV3roB9SXe93wGPTc2OMy62jWVF5U
	 7gEKv/hrCUWHu8ixE6trAykAN/XAzoEHl8TALnAMGCEFJIvTnQhbquutHQuLDgF3EvoaS
	 sbd9WGIUbrEr7eJJFcZe4SnvS+h8ieuAVv5ORmKkEwzxF2OJZXrKwjJEFM+OVMVeIRofR
	 Pxrr2VGyQMo+ikTL7K6QAQUOK73SG7gzuHn06CEFZ9e8QNsIThx54fsHOwwnWEQPriA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z11Foj8X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97637606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z11Foj8X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0631F0093D;
	Tue, 10 Nov 2026 23:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352556;
	bh=Museo8it0wG573lWE+ORLezRYLN5f0x5kMTWf6XHwNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z11Foj8XBNrKJIg8xcBqN7Ms/CgDsnDf3CvjN90bWXlEenkPrvWOyOUdM05H8ShaK
	 0TJlbDG6BzSGT1QQyDdWWKPnyaGmjtd2BwAOxGh9SEBSjtKL8WQqI+xKHAHnll14vt
	 Jwqbe1X6O2dOlJDjP+CRzFlQLVi+k9I4dcZnL5Ivg25fbyJAwjyJj1YkkvrLuAwzT1
	 RmQ0rc/BchB9gQ3OrQ1SVi8GImSBVgEybZxA5qm1fqcxWL2q6XnlkUujzjPF771Q/I
	 ssQJ2s2qKkxMQ/cYL7g0a2al2sjAM9O8LJMBiBlH22IR98CPZud27JKiY9PQdCZNn7
	 5dlNnsWsveimA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Su <sh_def@163.com>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] perf evsel: Restrict incremental open error unwind
Date: Tue, 10 Nov 2026 18:15:53 -0500
Message-ID: <20261110231345.67315-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051229-failed-6.18-16d1234793d4@kernel.org>
References: <20261107051229-failed-6.18-16d1234793d4@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hui Su <sh_def@163.com>

[ Upstream commit d023b2110d0d7232ba952a486c497ba8817f6f66 ]

evsel__open_cpu(), evsel__tool_pmu_open() and
evsel__hwmon_pmu_open() support opening a subrange of a CPU map, bounded
by [start_cpu_map_idx, end_cpu_map_idx).

Their error paths, however, unwind using "while (--idx >= 0)" all the way
back to CPU index 0 regardless of start_cpu_map_idx. If lower CPU indices
were opened by an earlier invocation, a later incremental open failure
therefore closes those existing file descriptors and overwrites their
slots with -1.

Before this fix, running the new incremental open test demonstrates this
corruption:

  $ perf test -v "Tool PMU"
   12: Tool PMU:
   12.1: Tool PMU                                                      : Ok
   12.2: Tool PMU leader                                               : Ok
   12.3: Incremental open error unwind boundary:
     FAILED: CPU 0 FD overwritten: FD(evsel, 0, 0)=-1, expected 4
  FAILED!

Stop the unwind at start_cpu_map_idx so that only file descriptors
opened by the current invocation are rolled back.

After this fix:

  $ perf test -v "Tool PMU"
   12: Tool PMU:
   12.1: Tool PMU                                                      : Ok
   12.2: Tool PMU leader                                               : Ok
   12.3: Incremental open error unwind boundary                        : Ok

Fixes: 4804e0111662d7d8 ("perf stat: Use affinity for opening events")
Fixes: 240505b2d0adcdc8 ("perf tool_pmu: Factor tool events into their own PMU")
Fixes: 53cc0b351ec99278 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Hui Su <sh_def@163.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: 16d1234793d4 ("perf evsel: Close the fds opened so far when disabling missing features")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/tool_pmu.c | 79 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.c     |  2 +-
 tools/perf/util/hwmon_pmu.c |  2 +-
 tools/perf/util/tool_pmu.c  |  2 +-
 4 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
index 1e900ef92e378..5b41c90637c36 100644
--- a/tools/perf/tests/tool_pmu.c
+++ b/tools/perf/tests/tool_pmu.c
@@ -1,8 +1,16 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include <errno.h>
+#include <fcntl.h>
+#include <string.h>
+#include <unistd.h>
+#include <internal/xyarray.h>
+#include "cpumap.h"
 #include "debug.h"
 #include "evlist.h"
+#include "evsel.h"
 #include "parse-events.h"
 #include "tests.h"
+#include "thread_map.h"
 #include "tool_pmu.h"
 
 static int do_test(enum tool_pmu_event ev, bool with_pmu)
@@ -99,9 +107,80 @@ static int test__tool_pmu_with_pmu(struct test_suite *test __maybe_unused,
 	return TEST_OK;
 }
 
+static int test__tool_pmu_incremental_open_unwind(struct test_suite *test __maybe_unused,
+						  int subtest __maybe_unused)
+{
+	struct evlist *evlist = evlist__new();
+	struct parse_events_error err;
+	struct perf_cpu_map *cpus = NULL;
+	struct perf_thread_map *threads = NULL;
+	struct evsel *evsel;
+	int ret = TEST_FAIL, fd0 = -1;
+
+	if (!evlist)
+		return TEST_FAIL;
+
+	parse_events_error__init(&err);
+	if (parse_events(evlist, "tool/user_time/", &err)) {
+		parse_events_error__exit(&err);
+		evlist__put(evlist);
+		return TEST_FAIL;
+	}
+	parse_events_error__exit(&err);
+
+	evsel = evlist__first(evlist);
+	cpus = perf_cpu_map__new("0,1");
+	threads = thread_map__new_by_tid(getpid());
+	if (!cpus || !threads)
+		goto out;
+
+	/* Step 1: Open CPU index 0 successfully */
+	if (evsel__open_per_cpu_and_thread(evsel, cpus, 0, threads) < 0) {
+		pr_debug("Failed to open CPU index 0\n");
+		goto out;
+	}
+
+	fd0 = (*(int *)xyarray__entry(evsel->core.fd, 0, 0));
+	if (fd0 < 0 || fcntl(fd0, F_GETFD) < 0) {
+		pr_debug("CPU index 0 FD is invalid (%d)\n", fd0);
+		goto out;
+	}
+
+	/* Step 2: Intentionally trigger failure on CPU index 1 */
+	evsel->core.attr.sample_period = 1; /* Not supported for tool PMU -> -EINVAL */
+	if (evsel__open_per_cpu_and_thread(evsel, cpus, 1, threads) >= 0) {
+		pr_debug("Unexpected success opening CPU index 1 with sample_period=1\n");
+		goto out;
+	}
+
+	/*
+	 * Step 3: Check that CPU index 0's FD was NOT destroyed by CPU index 1's unwind.
+	 */
+	if ((*(int *)xyarray__entry(evsel->core.fd, 0, 0)) != fd0) {
+		pr_debug("FAILED: CPU 0 FD overwritten: FD(evsel, 0, 0)=%d, expected %d\n",
+			 (*(int *)xyarray__entry(evsel->core.fd, 0, 0)), fd0);
+		goto out;
+	}
+
+	if (fcntl(fd0, F_GETFD) < 0) {
+		pr_debug("FAILED: CPU 0 FD %d was closed by error unwind! errno=%d (%s)\n",
+			 fd0, errno, strerror(errno));
+		goto out;
+	}
+
+	ret = TEST_OK;
+out:
+	evsel__close(evsel);
+	perf_cpu_map__put(cpus);
+	perf_thread_map__put(threads);
+	evlist__put(evlist);
+	return ret;
+}
+
 static struct test_case tests__tool_pmu[] = {
 	TEST_CASE("Parsing without PMU name", tool_pmu_without_pmu),
 	TEST_CASE("Parsing with PMU name", tool_pmu_with_pmu),
+	TEST_CASE("Incremental open error unwind boundary", tool_pmu_incremental_open_unwind),
 	{	.name = NULL, }
 };
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index e01103443b23f..4fa7cbc51047c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2810,7 +2810,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			FD(evsel, idx, thread) = -1;
 		}
 		thread = nthreads;
-	} while (--idx >= 0);
+	} while (--idx >= start_cpu_map_idx);
 	errno = old_errno;
 out:
 	if (err)
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index b24cdc3299447..7c1ac23e41324 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -803,7 +803,7 @@ int evsel__hwmon_pmu_open(struct evsel *evsel,
 			FD(evsel, idx, thread) = -1;
 		}
 		thread = nthreads;
-	} while (--idx >= 0);
+	} while (--idx >= start_cpu_map_idx);
 	close(dir);
 	return err;
 }
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index f075098488bad..601fbf6ae4098 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -296,7 +296,7 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 			FD(evsel, idx, thread) = -1;
 		}
 		thread = nthreads;
-	} while (--idx >= 0);
+	} while (--idx >= start_cpu_map_idx);
 	errno = old_errno;
 	return err;
 }
-- 
2.53.0

