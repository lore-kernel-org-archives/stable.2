Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DAC44470C;
	Fri, 16 Oct 2026 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185704; cv=none; b=suODhe4SvvD+X/4/X9aIFV/vyQ/GwVJk0Dvx/I/dfGCPoZLmKax7ZcyMQ/m9ScZvCo9RznZ/UeWxYMG75aROz5JO/7Id1xQqy1POiWLvRfZrdSRquf+Y1YH2bG8pCT9ouazSARYMM1oJgud1Tuoc4ZFEHsM4zi3pWY5asJkCPM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185704; c=relaxed/simple;
	bh=LRq8J5VI/c5F4mdl9yO6INb5fMccOMFyxeFMLCWierg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mm/wFsH5TW+vM67i1tvVs0kL7lE1K8mOgwIo+qsPXT21gaXEs/elBnJs3AOHFiv/6MHDlHHdHpztcqWex/8o42ij9G0UjhiLMNt9g4GenUKVohKOsJHxS+Md4+EzYyNGPVkWu5H2PwK7xKcFj/bcx7BqZRsUMHg1P2ykfNj8wkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hl+J3gmh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hl+J3gmh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57B91F000C4;
	Fri, 16 Oct 2026 21:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185702;
	bh=92DCjrzrW+PZSmkPKLfzePb6H6t+YqDZbYECatKavO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hl+J3gmh4rwaWVZ1f/17Jk1JJ1SU78I0R6YEbETkhAVFuEJYB0aD6JkaNWa7JxW62
	 XZOiuaKIPr7e7P2Xe4W6Cwbc6QklHgo/9JP3V87kr0glcPieVPO72KUzPr1/tIZaeh
	 v/13vYp8ZNV/bDwHJUD2cv/0p4zyGKNbuodNM2/TG8R8RM0gxmwHQqNjW5KL3Z8s1R
	 gcJQAuilNKbnYeBN7lg5qL5i2ISMoVHYcWA7GaIksSREilHZx8p822xh8jkMhsB6R1
	 aZkfzVnr/0zo+s+hgQmbGnJMg7JCcAfUuWKbkifZtoiyl71SEi881LDMpYVESoZ2d+
	 UdZjKr+58NVRQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v4 10/21] perf evsel: Close the fds opened so far when disabling missing features
Date: Fri, 16 Oct 2026 18:20:51 -0300
Message-ID: <20261016212102.76550-11-acme@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016212102.76550-1-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

evsel__open_cpu() opens the events one by one and, when an open fails
with EINVAL and evsel__detect_missing_features() has a feature to leave
out, goes back to fallback_missing_features to open them all again from
start_cpu_map_idx, without closing what the abandoned attempt opened:
the fd of every CPU or thread that was opened before the failing one is
overwritten in the FD() array, leaking it.

Close them first, the same way out_close does when returning an error,
leaving the entries at -1 for the retry.

Fixes: af954f76eea5 ("perf tools: Check fallback error and order")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-173532@kernel.org
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 59318fef03cb17ff..d060fca8090f6e26 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3005,6 +3005,19 @@ static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu
 	return false;
 }
 
+static void evsel__close_fds(struct evsel *evsel, int start_cpu_map_idx,
+			     int cpu_map_idx, int thread, int nthreads)
+{
+	do {
+		while (--thread >= 0) {
+			if (FD(evsel, cpu_map_idx, thread) >= 0)
+				close(FD(evsel, cpu_map_idx, thread));
+			FD(evsel, cpu_map_idx, thread) = -1;
+		}
+		thread = nthreads;
+	} while (--cpu_map_idx >= start_cpu_map_idx);
+}
+
 static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads,
 		int start_cpu_map_idx, int end_cpu_map_idx)
@@ -3150,8 +3163,14 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	if (err == -EMFILE && rlimit__increase_nofile(&set_rlimit))
 		goto retry_open;
 
-	if (err == -EINVAL && evsel__detect_missing_features(evsel, cpu))
+	if (err == -EINVAL && evsel__detect_missing_features(evsel, cpu)) {
+		/*
+		 * The restart opens the events again, so close what this
+		 * attempt opened before its entries are overwritten.
+		 */
+		evsel__close_fds(evsel, start_cpu_map_idx, idx, thread, nthreads);
 		goto fallback_missing_features;
+	}
 
 	if (evsel__precise_ip_fallback(evsel))
 		goto retry_open;
@@ -3161,14 +3180,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		threads->err_thread = thread;
 
 	old_errno = errno;
-	do {
-		while (--thread >= 0) {
-			if (FD(evsel, idx, thread) >= 0)
-				close(FD(evsel, idx, thread));
-			FD(evsel, idx, thread) = -1;
-		}
-		thread = nthreads;
-	} while (--idx >= start_cpu_map_idx);
+	evsel__close_fds(evsel, start_cpu_map_idx, idx, thread, nthreads);
 	errno = old_errno;
 out:
 	if (err)
-- 
2.55.0

