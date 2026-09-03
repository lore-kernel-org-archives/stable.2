Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5E843636A;
	Thu,  3 Sep 2026 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433502; cv=none; b=tTVzSXGATY+1qxfYnuAyNo1HJCdUnpvNN4+xN6lCdb7tpHtVHWn1fYICVjgi231nklvPDMcTSIjEodsWPhVaOGW+EoYv+U3rO9absJSFmGb0Czc1ELdikLSiEZ5/g34wUDrPSVxq93IMFZ5fELeu56zASAysjFzC4HVlN0fnhp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433502; c=relaxed/simple;
	bh=iMmhh7e612un5M2KNTkrg/HSz6ZbI48Agss/+UGUoD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xn7aweRnb/bW+Tk9cCNhi0tMZi6EJOwnb/fxT3koU6VUduVoXsjt5bIv1idbxAf8B1zVyDN17bH86bHwPRt/YRRAYvyQmt9yeiiLSf0AaG1UST0+iOXHMusVQeyJQYItqHH5E0hvCKJ5/yX0qg9xOfDWJTvaYePwXqjyX8Wmjsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hznulwf9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hznulwf9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5304C2BCF5;
	Thu,  3 Sep 2026 11:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788433501;
	bh=iMmhh7e612un5M2KNTkrg/HSz6ZbI48Agss/+UGUoD4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hznulwf9u192ttU2KTqnlSIVZ3SvLhZ4i3AJ5fsZg3lM+z3ENrXA2NyvgHU0FSO1K
	 BhdAhc5E/QMX2wwyIjDUGJgcEVEvm66bR7k+kHqKTj/gVZk9xUI+VamP4gBgFy60qE
	 CBRNhdC4/wVb8i4WR4+2xYHCsQUTWJqbT/mvob1JX1BAPSiRUhNntCZmWShTp6cFNT
	 GRPRpxBl4NPtTBKJffM5CTT95ibGxMA8Lfejj4jVQjM05jZhdSl7l+gsLpgjdEOznr
	 vuTQBeqUyeuwWSAPFbPNRlgxmq18gxoABhtzQGZM+DgSccCkyx14F7nz5BKCts0Q76
	 575GiT1RWvycg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA9DC61DD3;
	Thu,  3 Sep 2026 11:05:01 +0000 (UTC)
From: Mark Amirkan via B4 Relay <devnull+markdamirkan.gmail.com@kernel.org>
Date: Thu, 03 Sep 2026 04:04:20 -0700
Subject: [PATCH v2 1/2] perf evsel: Validate branch stack before byte
 swapping
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-sympwn-linux-002-final-v2-v2-1-0aee1fca1f95@gmail.com>
References: <20260903-sympwn-linux-002-final-v2-v2-0-0aee1fca1f95@gmail.com>
In-Reply-To: <20260903-sympwn-linux-002-final-v2-v2-0-0aee1fca1f95@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Mark Amirkan <markdamirkan@gmail.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788433501; l=3687;
 i=markdamirkan@gmail.com; s=pscsi-20260818; h=from:subject:message-id;
 bh=58e7OflNXA7OlGA05i/f/QWuPoVOC00wOH0fz7PzXT4=;
 b=EPmwj1Tjal5+mJNekCWUSZubAYjydL+rdYgsRfy/U4aF7/xJsUiOhIG2spvr5UWJLbSWpTrRl
 13wuHmbzPyeBrgjwY5zs7BnKA9RBU8Nz8ieUrBohavknG3wm7kZk/5U
X-Developer-Key: i=markdamirkan@gmail.com; a=ed25519;
 pk=/wb49ibt4gZFDncmhFQBYtjPvzT1tfJtvK4Mqt1P2Wc=
X-Endpoint-Received: by B4 Relay for markdamirkan@gmail.com/pscsi-20260818
 with auth_id=961
X-Original-From: Mark Amirkan <markdamirkan@gmail.com>
Reply-To: markdamirkan@gmail.com

From: Mark Amirkan <markdamirkan@gmail.com>

When perf reads an opposite-endian branch stack, __evsel__parse_sample()
swaps each entry before checking whether all entries fit in the event. A
truncated sample can therefore make the swap loop read and write past the
event boundary.

A truncated perf.data file makes perf report crash with SIGSEGV. ASan
reports an out-of-bounds read. A regression test puts an entry just past
the declared end and shows that its flags are changed before the parser
returns -EFAULT.

Move the bounds check before the byte-swap loop. Valid samples are handled
as before.

Fixes: 63c12ae2f246 ("perf evsel: Add bitfield_swap() to handle branch_stack endian issue")
Cc: stable@vger.kernel.org
Assisted-by: Symbolic
Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>
---
 tools/perf/tests/sample-parsing.c | 48 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.c           |  3 ++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 32dbc484487a..583951534937 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdbool.h>
+#include <errno.h>
 #include <inttypes.h>
 #include <stdlib.h>
 #include <string.h>
@@ -417,6 +418,49 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 	return ret;
 }
 
+static int test_truncated_branch_stack(void)
+{
+	struct perf_event_attr attr = {
+		.sample_type = PERF_SAMPLE_BRANCH_STACK,
+	};
+	struct {
+		struct perf_event_header header;
+		u64 nr;
+		struct branch_entry entry;
+	} input = {
+		.header = {
+			.type = PERF_RECORD_SAMPLE,
+			.size = sizeof(input.header) + sizeof(input.nr),
+		},
+		.nr = 1,
+	};
+	struct perf_sample sample;
+	struct evsel *evsel;
+	u64 flags = 1;
+	int err;
+
+	input.entry.flags.value = flags;
+	evsel = evsel__new(&attr);
+	if (!evsel)
+		return -1;
+
+	evsel->sample_size = __evsel__sample_size(attr.sample_type);
+	err = __evsel__parse_sample(evsel, (union perf_event *)&input,
+				    &sample, /*needs_swap=*/true);
+	perf_sample__exit(&sample);
+	evsel__put(evsel);
+
+	if (err != -EFAULT) {
+		pr_debug("truncated branch stack returned %d, expected -EFAULT\n", err);
+		return -1;
+	}
+	if (input.entry.flags.value != flags) {
+		pr_debug("truncated branch stack modified data past the event\n");
+		return -1;
+	}
+	return 0;
+}
+
 /**
  * test__sample_parsing - test sample parsing.
  *
@@ -433,6 +477,10 @@ static int test__sample_parsing(struct test_suite *test __maybe_unused, int subt
 	size_t i;
 	int err;
 
+	err = test_truncated_branch_stack();
+	if (err)
+		return err;
+
 	/*
 	 * Fail the test if it has not been updated when new sample format bits
 	 * were added.  Please actually update the test rather than just change
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d4cb455f4a7d..cc0bc0857754 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3639,6 +3639,8 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			e = (struct branch_entry *)&data->branch_stack->hw_idx;
 		}
 
+		OVERFLOW_CHECK(array, sz, max_size);
+
 		if (swapped) {
 			/*
 			 * struct branch_flag does not have endian
@@ -3654,7 +3656,6 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 				e->flags.value = evsel__bitfield_swap_branch_flags(e->flags.value);
 		}
 
-		OVERFLOW_CHECK(array, sz, max_size);
 		array = (void *)array + sz;
 
 		if (evsel__has_branch_counters(evsel)) {

-- 
Git-146)


