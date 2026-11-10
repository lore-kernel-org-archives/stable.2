Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351642;
	b=bmCY+8zJLHf33Md5br3hQyZU0AetKhtCB3+Nhg8DdVDDpQClk5LJOhbmc/ws9Ux/EAgd
	 1sC4pNpmJlNbCPN1Z4VS6f7uqUymPh3PbovlyeLN345zuHZuIswqrcunB4iKw7rzIO9R2
	 k2+qe9h2gbW7D/1WDjyxHC8wxyqSKTy0a8jm80s07RmMWD3ZxSm5qpjqKnoKWjhVep66v
	 e3u2SQwx5R/w3Daf3wUnAjpPSFIlb+bnzJ/QtstJ2s0QXlu95r0j/FDFN5XJIPALfvB07
	 a+BAVKld+L67rn6dCBsYJLM0Fn8mOKGBH139aPqT5RPr6MJ2uZd5znv2Wy7UOwFdWmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351642;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dMg5Uz5BsCQW8OwBfFKaYi8KZ4zKvK5tFVV+tF8CBoQ=;
	b=M6IyckRvUsHpdEQYDoFi3A+qR5Rc/5fUaTjA+2HhMn+OfVtXOxtNXPboXk4Obl/0e0d1
	 FCLnv3CE4zWGAw707dhoBvapAcMYba5ajU+vAOnaewYY/R26JjIVU4KHiosG9OweZWJ01
	 istYe2dUFcXe9l/f8JVnOLiC4ijmBuCarXRmbqvf0dRMO0WDjkfU+NDbcqTKcLm/nvS9a
	 yOYK7fsr2nqHEGbcYDo2bw4nfQNLtnEfbyy2peCOpDvGSIZVMAJejClqpda5QNNqdLOIq
	 rLwTLf/gAN628RvNZxnul+4dZtz/IR9p7S0Xr+rqpuDj5lxGMTBZjcaVpj4E+ucTS0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NlyiuflK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9042C606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NlyiuflK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A091F0093D;
	Tue, 10 Nov 2026 23:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351642;
	bh=dMg5Uz5BsCQW8OwBfFKaYi8KZ4zKvK5tFVV+tF8CBoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NlyiuflK4rt6PE3CDed/atRZFwGeEd11AEOMI5lHhc0iCIvwllnxXVRvGhq4Y1sdW
	 JVebMLhlfi3Vj61MOugJsj2IhcPARPntXsJxRRiwbHu9bE37NYWXeR/jypoSYH6wr1
	 w3WqX87yd5u7ztPjooX6Up8q7p8L6gRfWZ+Df/nLgI8yPJ9Z0Uw7cP9Z2JPphEImEa
	 bDeIbYfFke4yQFrTRVYLBHLLOX7tvWvDxT/FJ3TjJM+ROUNugEqPRf5Dl98r1czZcM
	 M0AIeSRN8NxOBojPSUb7VRgTvvllQnTYwmW5j92msDXa8ekcgFdySm+rRV/hTWOtN4
	 /Pz7ds6sTVfbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] perf evsel: Close the fds opened so far when disabling missing features
Date: Tue, 10 Nov 2026 18:00:39 -0500
Message-ID: <20261110230028.4133712-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110230028.4133712-1-sashal@kernel.org>
References: <20261107050507-failed-7.3-16d1234793d4@kernel.org>
 <20261110230028.4133712-1-sashal@kernel.org>
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
index eb429087ebfee..5db43520f25e7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2974,6 +2974,19 @@ static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu
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
@@ -3109,8 +3122,14 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
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
@@ -3120,14 +3139,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
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

