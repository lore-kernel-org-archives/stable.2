Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046351;
	b=RJIGvhv/aUj1KqB0oGEQLKk2t9eVxMeDUpeu1ieI7pf7YkYL8Wwo5kp12dlcJmgHeVTU
	 P6nvHxrqVX4LfSFu02XIxlBxxmis/hSfxpZROsPZa/21Yu4YK3EY/Cm5STjol1ZbrId6w
	 Mj4YC69XukZ0lSDUNwDpYvjOmEAekswAcr6mOFLx5uuv3obLUsKZtxXXAga27MhRz5QV9
	 +JOTrnfBmGGusR2j24YK2erUoixZgJdlgewaAHo9VwnHnXC+eH6buW5UXfHnJmbpkRwgx
	 mrph3kmYAUmrmfWaeVnGSk7hyxfEyt9PV4zyTLuL6TaQBJ3eO4SOMSGjRV8m4+CLIPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046351;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yXDwiXiIcgqpyAzYO+RfMb6ejZFhN6Cfhp/vAzv5tco=;
	b=VtC0DwzUb9WeS+McUkIKu5ArVoXe7wwiBXf543p/JXDC2KfSgYO7K4R0aPQ6FXCJy+i+
	 IUwHwY6tdthiymjWT3Rz9166bP9ha6OxUcyuOxSbKRvQ+yiuqvryv7x+gHiijEHooDVrE
	 kPJdVa5nw6frz8KEneX8OXAhXANQuC09zN4djT3PIkdC4/HUL972vcVapzONiBsU70zez
	 mYIw76875q1+tnpPFwkzeZ7wUZiBgmNgio2FZt32d45D0eNQWwZKg7OxyWkWi1YqID162
	 +nlhkE422pAObii0i1eTy0Wg5lTd6dIIgdSr+9Pji8txrIO1vHvt0dVVYQzJe+iqwGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uoau+IIe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858E8606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uoau+IIe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6491F008A1;
	Sat,  7 Nov 2026 10:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046351;
	bh=yXDwiXiIcgqpyAzYO+RfMb6ejZFhN6Cfhp/vAzv5tco=;
	h=From:To:Cc:Subject:Date;
	b=Uoau+IIe+ldZuKNySfu7RFpO4OVNtNxJhX6n6QJcUussZzVnlT6/7alLqrO6z2RQu
	 yC8TRUj2k1xWnIXjJVAuWODdikYGxjDkrXmxMXCXXBaPeHuTM0KBqyAosG0GQ0dH0z
	 fTzkmBrk1t20LlZw0B9eCvw6VGiOXWN94ajEfJedE0xLL/zcdUGAzTomhuRAcQVoAW
	 g7Qmgc0KWH63nR3uecEf6VEu7eS+0nHiz5Y35KjmWzJGq8J1ghBjjbmFZrzAZ2/mtp
	 aqYDIaKy4XET2xOe7Qb6P+147qjTNVynmcqSefct8Cixmisl1btNY5g5XKQFbERlaN
	 H+oeYrkcMekvg==
From: Sasha Levin <sashal@kernel.org>
To: acme@redhat.com,
	sashiko-bot@kernel.org,
	irogers@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] perf evsel: Close the fds opened so far when disabling missing features" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:12:29 -0500
Message-ID: <20261107051229-failed-6.18-16d1234793d4@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 16d1234793d42a5a594db99522845996ab8e0d29
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051229-failed-6.18-16d1234793d4@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 16d1234793d42a5a594db99522845996ab8e0d29 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Thu, 15 Oct 2026 22:07:03 -0300
Subject: [PATCH] perf evsel: Close the fds opened so far when disabling
 missing features

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
---
 tools/perf/util/evsel.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 59318fef03cb1..d060fca8090f6 100644
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
2.53.0




