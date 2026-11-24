Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479791;
	b=VXPz89J3o++50dlJkXSnLJaFWrkNet5U8IGZeYlDsHX8jNCX86zhiACIX+uKkNQu+5ND
	 QVhIbwJjJiXdZoIh/h1aVeVMeJ86xOAyhooUm0g7XGFJlrYB5rax3C824e6zwoLj73VY2
	 7f2V988rkt8hJ/S2x+9vTx5zxapgAHCuGxzXoFwFtCLfDhGwoCCqkpVDDJmu316/XKitI
	 j55XtI+QF+61AJnEf1JIrnPeEUDQK6/bo5maAUssAg4o0C0vHJbzoEMJa/xZSaSog8/px
	 UsSgV+IBhezyYXhZEHnwAxr/Dg5mdi960PcuBfCYThTSHefilvE7tOmo9wuhlFauUNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479791;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1dMnNM7pmuvkJ/hHM2AR4ElZtw3RAVpO4LdI2iGJ1xw=;
	b=UGA4np/R+bhTgxVAui2y+dkVnAuA8vKH52V1ueg2295kQSI8iqccCkiOVLKv385hb3sL
	 kL4JZYsHkzqo+rxJX9gq2BPHhEfOqSq2H0vyJaMvzavo//iXDeGhKRQoPKnFXyhbTMv6/
	 ORDXIoAJRra84dU29F//1/lVa4j4ma5D4bLDbb1Z21/QgCywBjrfUq/4NhfpFQxEbZD+a
	 bl8VsJC8AiTQoY8uON0d+mZxNDAODwUpQtX8eFirJRorGEIprQKpZxTQQKUN3Jo5IJ1iT
	 AW+Lm/nyK7ol0LVJ1wYeCrRLPQe+7hmLODb2X3Raw4Kiybafj4YTGLmpbPp4jUO3XoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4sckAXr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3EB606A334;
	Tue, 24 Nov 2026 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4sckAXr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AD61F000C0;
	Tue, 24 Nov 2026 00:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479791;
	bh=1dMnNM7pmuvkJ/hHM2AR4ElZtw3RAVpO4LdI2iGJ1xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N4sckAXrWbV8cWKs5c/KUL0YY/a6Djj1oTkT8q03UNyz4pfEHNbJTrk25PdmlPuTX
	 XanLG4f80hfyAM2mDS4DgU+cg0rbmsafQVj6M5pky4OWdPnx/B3qo4Kx2ktpfifhgp
	 U0vDcJ9YFbh8T9vtkt8EIYgFBRBT38hp0quA6ft98DmL4V3/w38SWeeTO6gTAQFt7L
	 kw1TxHZuGWWBcmLhs2WqtUrwfSYWRw+a0cEgSurh9yohTA7+QakbgZL0In1BU/Pxvd
	 GQay5exxsgvmGP4KqR1MKAJ9zrIq95arm6NtO3ph2fejNYDpOxAnTkzPidKlbyBndK
	 iio1UJUxcTzsg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mingwei Zhang <mizhang@google.com>,
	Jim Mattson <jmattson@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [RFC PATCH 01/26] perf/core: Fix lockless time read for exclude_guest events
Date: Tue, 24 Nov 2026 00:22:38 +0000
Message-ID: <20261124002303.1785363-2-yosry@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261124002303.1785363-1-yosry@kernel.org>
References: <20261124002303.1785363-1-yosry@kernel.org>
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

When a host perf event has exclude_guest=1, its elapsed time should
exclude guest time.  However, lockless time reads through
__perf_event_time_ctx_now() only subtracts guest time while a guest
context is loaded, unlike __perf_event_time_ctx(). As a result,
time_enabled and time_running read locklessly include past guest time
after the guest context is put.

Subtract guest time regardless of whether a guest context is loaded. Guest
time does not advance while no guest context is loaded, so use the
accumulated guest time in that case.

Undo a minor optimization that avoids adding and subtracting 'now' while a
guest context is loaded, to make it clearer that guest time is always
subtracted, and only how it's calculated depends on whether a guest
context is loaded.

Fixes: 4593b4b6e218 ("perf: Add a EVENT_GUEST flag")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 kernel/events/core.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f5f2261f1fe6f..6f076e5483cb7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -850,7 +850,7 @@ static void ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum e
 static inline void update_perf_time_ctx(struct perf_time_ctx *time, u64 now, bool adv)
 {
 	if (adv)
-		time->time += now - time->stamp;
+		WRITE_ONCE(time->time, time->time + now - time->stamp);
 	time->stamp = now;
 
 	/*
@@ -887,15 +887,19 @@ static inline u64 __perf_event_time_ctx_now(struct perf_event *event,
 					    struct perf_time_ctx *times,
 					    u64 now)
 {
-	if (is_guest_mediated_pmu_loaded() && event->attr.exclude_guest) {
-		/*
-		 * (now + times[total].offset) - (now + times[guest].offset) :=
-		 * times[total].offset - times[guest].offset
-		 */
-		return READ_ONCE(times[T_TOTAL].offset) - READ_ONCE(times[T_GUEST].offset);
+	u64 time = now + READ_ONCE(times[T_TOTAL].offset);
+	u64 guest_time;
+
+	if (event->attr.exclude_guest) {
+		if (is_guest_mediated_pmu_loaded())
+			guest_time = now + READ_ONCE(times[T_GUEST].offset);
+		else
+			guest_time = READ_ONCE(times[T_GUEST].time);
+
+		time -= guest_time;
 	}
 
-	return now + READ_ONCE(times[T_TOTAL].offset);
+	return time;
 }
 
 #ifdef CONFIG_CGROUP_PERF
-- 
2.56.1.809.ga0b61035b5-goog

