Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC18250BF2
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788101749; cv=none; b=KwHG400nBMgv8XpVUzQDkizCKBjZNWo8LfN6UdpoCPfKuvVsYXXj+bB8Hcom5E2LUvn3h9l6AvBDydUBm281Z0T1nNCUt8Fyfs6b27Tqh1H+oZt+P1XyzBRrqZ6ErTTEit5P0zAdjnGZhDKoGK43sG1SjY+q4PYv7K8uIS/oe2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788101749; c=relaxed/simple;
	bh=QByGBxzU220ZERAIuEw8xUkWTZggFPrYCl7mjEOxDnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Um4iT7UabMgxdk1wyp9oA0+ZZFZN+AjYpi5FTQrwiwnZ+wnKYlhCJ5lrVkO+BEx8AiTC3I8nmO9EoYaQG+q+tHtQ3xMaYUkdDNFEEU8vIURNTdrWCOrJWcEz0PyHSrMLKdLGXXhoIBjlW6T5EhwGvhouMbqcNTx2v3AsprqMpxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egT1EcFJ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egT1EcFJ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3966791a6eeso3156346a91.3
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 07:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788101747; x=1788706547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f8qfcfBi8NC02RZX5r4ch9EYMf8t0tHqhPistvQsuBk=;
        b=egT1EcFJoJn0o0szhuxUYKyHx+xzAaVnjW5LPVVA1uTCd8xaXOfGmWXwZwC+rE196V
         liTBvsQK0CsPBHFx68w/DiYrwtrhjYjQtUHp8utVcHI0ui9e/2bH55N23ZOsVMEOwuIk
         i0oIqwKwV9RWsPtfqlMh/C/yyU37DKE00IH72DdpgZzAabf827ZeIt3Lql0k5KodyxLQ
         i35HrEMMAISEGD0bU5y/7nEK5NJK7tIlPJWIZPFza1lSCnr40fUlqF+w5a0gDzRMNOrQ
         ib8WT2GCqlxparv+k48OClMEQPEM24YqNagN9e29lsFlEgd7+ygJkJa25gGenlijhn/9
         FGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788101747; x=1788706547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f8qfcfBi8NC02RZX5r4ch9EYMf8t0tHqhPistvQsuBk=;
        b=lQa8Z5NYo2WXZryTsoHzzBOpCO/GaPc6WRnq2RkzQDouoHLUCQb45lShLLH3Sf99iP
         lcvwWTr+05HSontoCUTh6gh29/6T4wbC16qa+XEO8RTSw7u9D1Bb10GLTG8IWrNwz9bj
         oWZFIUzBpmmC0nIgGun+xoYH4UyqFHQ6z3/i+vHMUN5amR9eIW+dxykHBe+TFJ+yGnLy
         5nyuh/reTmtmYFMSYp9TJlZXuiUdQ4/8Ni/e0PEU3n4tfxbQ4QBB0gvL66T3p3EmAzyv
         tURIhrIyN/icDfAC2Fdh1KAay9/LTG+DP66rNRThGvPHF1Dge9FhUBIj/SiGQ6M7PWsc
         AA7g==
X-Forwarded-Encrypted: i=1; AKwUvBzqPUe+eynAj7qzo211hdMcN57YuC0FuBp8p9gKmWfgS/UEuf7tfm1FLXrp2ZX6NwtSdFsay/8=@vger.kernel.org
X-Gm-Message-State: AFuF++nI5P577fPgHjPXsRy6ixQsayfF9AycfJsNw+2cQoIxBeYcysSU
	z1qQwVVitcd6weAwmmzJVKSdcKzNrEfeTGAzSWDmoAsvx6MdRssd5ykwNn7z2A==
X-Gm-Gg: AYBFou3SE4qC1c0CuGlRy/wxlzmsDqNOh9LpQEt5sE1FMW/V9WiqjkZtQ5ObvCRv6NF
	2mkE5LZWZ9sohylqT5dzDP9h/3sfgxe2TnpB7ZeBg9HMjlos5qbL73FRNNY8208jtSExUOc6cdM
	xC4TYRKr74rg5Oj9ORcNSF7Waad9eHQ94+d0roULfwleuPlMUvxOlrIJ3YQboDjMxdSpuma8tFm
	LB1Q4OgxAEYCeNST8DiwNismxBb2O0r+o5mNrO83A5hetdeLAwQYXusMf5jAz4qAVRKSBP7py88
	fqLkdasP3ehoQVygFNAucPt7gwAD4EhnY5h5ID6vR1Yt+lGCEzySQbOECqSiHOP0zhs8Ttohiik
	q3y6N8xzz4T6FRdyvRtqrd0INgW+16RoCw+0+4T3e/z45nGasxapHOZX3KluBMrYQ99u+GUYf1m
	+V9V/2NIIM5u7D46kwvTf3A3nLQUpitSFj36R0Cn4ZW90VC3nQLBSXRwOPJiQLchhsf9g90P+GN
	93fX8kjYcHIMC/+35mrLIGDhN27FFv/WT7I/EU=
X-Received: by 2002:a17:90b:2e4b:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-396d0d7b9bdmr31281365a91.6.1788101747319;
        Sun, 30 Aug 2026 07:55:47 -0700 (PDT)
Received: from localhost.localdomain ([180.101.244.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396dda7aaaasm11757472a91.6.2026.08.30.07.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 07:55:46 -0700 (PDT)
From: Aohan Mei <ljp1205831794@gmail.com>
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH] perf: Fix mmap_count accounting on the perf_mmap_close() race path
Date: Sun, 30 Aug 2026 22:55:05 +0800
Message-ID: <20260830145512.2583689-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

perf_mmap_rb()'s raced path (a concurrent perf_mmap_close() has dropped
rb->mmap_count to 0 but is still blocked on event->mmap_mutex inside
refcount_dec_and_mutex_lock()) installs a fresh ring buffer and then
does refcount_set(&event->mmap_count, 1).

That is wrong: the blocked closer still holds a pending decrement and
the count is 1 at this point. The refcount_set() leaves the count at 1,
so once perf_mmap() drops the mutex the closer observes a 1->0
transition, detaches the *new* buffer via ring_buffer_attach(event,
NULL) and drops its last reference, freeing pages that the racing
mmap() is about to map. A later munmap() of that mapping then finds
event->rb == NULL and crashes the kernel in perf_mmap_close().

Restore the pre-59741451b49c accounting on the raced path: the count is
guaranteed non-zero there, because the closer's decrement of
event->mmap_count only happens while holding mmap_mutex, which the
mapper holds. Use refcount_inc(). Keep refcount_set(..., 1) for the
genuine first mmap, where the 0->1 transition is required and
refcount_inc() would WARN.

Fixes: 59741451b49c ("perf: Identify the 0->1 transition for event::mmap_count")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
 kernel/events/core.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4638544205f2..adcc04ca05f8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7273,6 +7273,7 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 	long extra = 0, user_extra = nr_pages;
 	struct perf_buffer *rb;
 	int rb_flags = 0;
+	bool raced = false;
 
 	nr_pages -= 1;
 
@@ -7314,6 +7315,7 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 		 * event and continue as if !event->rb
 		 */
 		ring_buffer_attach(event, NULL);
+		raced = true;
 	}
 
 	if (!perf_mmap_calc_limits(vma, &user_extra, &extra))
@@ -7338,7 +7340,21 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 	perf_event_update_userpage(event);
 
 	perf_mmap_account(vma, user_extra, extra);
-	refcount_set(&event->mmap_count, 1);
+
+	/*
+	 * On the raced path above, a concurrent perf_mmap_close() can
+	 * still have a pending decrement of event->mmap_count: it sits
+	 * blocked inside refcount_dec_and_mutex_lock() on event->mmap_mutex
+	 * (which we hold) with the count still at 1. Using
+	 * refcount_set(..., 1) here would make that closer observe a 1->0
+	 * transition once we drop the mutex, causing it to detach and free
+	 * the buffer we just installed, while this mmap() still maps it.
+	 * The count is guaranteed non-zero on the raced path, so increment.
+	 */
+	if (raced)
+		refcount_inc(&event->mmap_count);
+	else
+		refcount_set(&event->mmap_count, 1);
 
 	return 0;
 }
-- 
2.43.7

