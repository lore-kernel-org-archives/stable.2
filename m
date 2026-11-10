Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352557;
	b=QrvbvTjtIqkcJSXoFaumbuoUNXHGipaTX6MRmzEJ2JKtBso1aTvf3WOTt/SLus38BPd/
	 ANfiqLcSA2pGmCm50VlcQicbula4FCc8txojg2nyfwygG1lpMzRjGM1xO63aKP2QsTwC2
	 CrGK/rMVy1YiGwSlcFAK1TwR4O99k0XlNoXuoIc4d86nbCEd6l2d0ZIw8xSa55K8fqtQ4
	 crxHYmVajL/SZdqDO/9ZcNDIhsom1af+xG3ffxJ3g5UA49leM4S49YBAYzU7tmE0iALYg
	 hpzTX5SHpxTZ8h7B9Ljkb5ap+d/I+AHxD8Hmz0JXKBKN6fC6e7wWH1KNe0nP9JjRcXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352557;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PC1f9f2W0JhgJ3KjLzic6BCYqLOuskWe9p8KoczSyOA=;
	b=2zfPWULcMNReDkIpD38iKRjJ5mCS9oKQykDcbHbw7S1FyMvNWHpliLEh7t/qFuzybNRi
	 z3YgAm0nAjE2PxQJzwsQDIkkwr7MbejRmNTjhM5BLTQYxlXi3oilj8vt+giv+tDUZTvH6
	 AkM7WYgjzyv+eximarFvkEscYM6j7pkt5oKrw77xodfzbx4bnzW8M8QmzAgSdWTrlj1QL
	 dlwPwScUd1X+8nLDGIRP4kfPIo+C//d5trx/qyOpL+yJzb9Bt0ajFvFYsfUKgOx0pSEts
	 llt+yqKAquNL6iEBhBo7U5x1zfr5DDu+TbipKRaUluMzXJwAQ6HqtX0qs5u4apbFH9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=URW1TP2C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D97606A327
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=URW1TP2C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C86F1F0093E;
	Tue, 10 Nov 2026 23:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352557;
	bh=PC1f9f2W0JhgJ3KjLzic6BCYqLOuskWe9p8KoczSyOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=URW1TP2C/8nWKKUfqguBldhqVKefZRz6SvyZ5dgTHe8z8dqigqqnPQtcWoA4i6YzR
	 Jwyo1oRHFq6mQMVJtBz2/y5yv1QaJtiuFLKb5Di+mlnj2MNESqswSABgDklaGc1uLP
	 g2VC3rPhfFEEpjYYZ6VUP+ONUJt3H9subTxuu528RcedOMT2uJvw8CJ0qi+iIV/5Un
	 aNg09aI1OytNJvyYWYDeqYY1hfdNdBcqNMSGQ2a3JY8qlOYjgr3TqAOi7jevlRi7Lf
	 MasA4mVFgms+78jCDoaHhbna6N19SNmypYQc3ufSS7dBrJv80qUCImT02thN9WPoPU
	 DiTzpfTbs8P4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] perf evsel: Close the fds opened so far when disabling missing features
Date: Tue, 10 Nov 2026 18:15:54 -0500
Message-ID: <20261110231345.67315-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110231345.67315-1-sashal@kernel.org>
References: <20261107051229-failed-6.18-16d1234793d4@kernel.org>
 <20261110231345.67315-1-sashal@kernel.org>
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

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 16d1234793d42a5a594db99522845996ab8e0d29 ]

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
Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Ian Rogers <irogers@google.com>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/evsel.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4fa7cbc51047c..654e9bbd66f98 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2642,6 +2642,19 @@ static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu
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
@@ -2792,8 +2805,14 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
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
@@ -2803,14 +2822,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
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
2.53.0

