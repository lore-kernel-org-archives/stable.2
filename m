Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351642;
	b=g4xnSamZ0uNvgSQ7GrnsfVr2UfUranSmGv0p3wzwxDtlkAF6VOsaBbQkekUBT14PENAH
	 ZWfYkxWwjQ2+dPVzVRbLInFSmLaG8DOWqs4/8bWZlejHR99RPbkv+ovnRYryZfqXrlM+o
	 tNBzMZiMf0yJ3UMQAv9PswgcQXeT6gNjNQxrbnLjKUDdqJyraR5MEU+aFSDNdV4dcI0vT
	 Zvyk9llG0y1z6EVSgjFHaaKob/+Q5QxoYzsAE0CduB2FCmhe1Xl4SXDRlPyakPgU544sD
	 pIskFNFNa6o8Rkb3BS508WkUlK//M+t0IjYzkUOcRB4pOqJ66fqcCEVLliSN7xE79RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351642;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oHapOwhFRFeUTzaE/p/QV/uARWz5N6oTgTnV0o+a520=;
	b=k/CmbsLvXEYCw7eA+YPXNyuG3WSJZs1z2weC28JPbWDIJp4lslafAbhSjNqdAokH6W7o
	 ZEVU+J2yXjx5cvY4Vl2G5/14oHdI/BPvmPqz/Wb6hmNpOxPUmcPfJVFDyShqogDGs3kQB
	 ukwffh3mS1RSCd8zAIXBly7zNVSPoH3T34386VBlCSZbfyG9m07M/4kGaaJq8+zflFnFc
	 auvRuQO2GyagVhIeDi3D9/UeU+hobjUlq8yLcQxGTo8k0yuO5EZXLO1xXs9k0sRIzbYIt
	 DpDSdu9KxQj6ProuAj+Wu5mZW/6YicBzANPUnSD/u5TEGvln8fMHu8XFmXwhEhV8XLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDhafUoC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1502D606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDhafUoC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2DF1F0093C;
	Tue, 10 Nov 2026 23:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351641;
	bh=oHapOwhFRFeUTzaE/p/QV/uARWz5N6oTgTnV0o+a520=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hDhafUoCsHB/LSYScDpJLKLuaXirCaSwosMYLe8HBSiuXiYILid/j3DVNdGXujHK2
	 5txrezz1UlE228QcoeNd1Xm0+f6lwSvBzhdXqOZZWFgWiKhm9ikGxa6CT+0sQZ4hBm
	 ftBfdxN61gRwrTYTAAimc28WaR+YPK+SoOvlkL/0WQmFS5Yqd5YHwLwSeODYNSQ4/x
	 n1Ceg5l9nX32a1nxkVqK1XTtizeFL3T5haOViSbbBXYSE8iqoYenf68anjjdwJq5pY
	 fxJJ412mfo/12/f13xu8Q4HqGU/DcqJd8YzvEVTZIIyMW5o6eHVX8QD8JkfsyUOl/n
	 fP2xQKlEYbVVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Su <sh_def@163.com>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] perf evsel: Restrict incremental open error unwind
Date: Tue, 10 Nov 2026 18:00:38 -0500
Message-ID: <20261110230028.4133712-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050507-failed-7.3-16d1234793d4@kernel.org>
References: <20261107050507-failed-7.3-16d1234793d4@kernel.org>
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
index c6c5ebf0e935f..667160f9e2cde 100644
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
@@ -100,9 +108,80 @@ static int test__tool_pmu_with_pmu(struct test_suite *test __maybe_unused,
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
index d4cb455f4a7d4..eb429087ebfee 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3127,7 +3127,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			FD(evsel, idx, thread) = -1;
 		}
 		thread = nthreads;
-	} while (--idx >= 0);
+	} while (--idx >= start_cpu_map_idx);
 	errno = old_errno;
 out:
 	if (err)
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index ed544dca70c38..96aeb379e169d 100644
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
index 5c30854b4644a..d2f7591747d94 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -349,7 +349,7 @@ int evsel__tool_pmu_open(struct evsel *evsel,
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

