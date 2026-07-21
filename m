Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4760E3403E1;
	Tue, 21 Jul 2026 05:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784611751; cv=none; b=ekjQITEOh8VlCTmAOJCgSLFsGveIjW3pgXwYFsGemP2E0vBf+rtCE3jiYLSaExV+lm1T2G8/Oms8bQizwj/4jQ7FmchvtQTAUcpTm549F1zI7b6zHE6MPIU17xK6V8hNdHG7HcaBI7efKloIiQnkKDg1noJxnjh+3dMZ9wc36qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784611751; c=relaxed/simple;
	bh=Jsl4XsjolC2q22fxg/W6qtyOPVZT5V818r5o9ySmTh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5slbe92vw4UrC6O4u6GATnmHkvDDGA5Dn0Ew4vewb9gVlJJc+U0P0w0e8EwWNsmNhJd6W+6l0xOrtO0ST0xFWcQohnCyVLqddd/4VQwMNfNbFVSiay/dkKa9bug7OhNuOc+srbjaVJBm4nAuRvSj4zjrP+5yCf+NAqsp0d+WzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8CTjt72; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8CTjt72"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035241F000E9;
	Tue, 21 Jul 2026 05:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784611750;
	bh=BH34Iq02e1ZazbCpDnoF+kImwBIgT5OJqyLihxokqHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e8CTjt72VaCg+aJnSkrJ04yGIVv5AuEHKW8BjUVWAQaa2ukJaYCXIa8C/fmJyWHTd
	 Jwa+JdE0CdNHLStEQUvHw0sR7HS+tVOSZUw/+zIBstRaNwsg5143Eiw60EwukeDGEI
	 VN2jRsHGxdjBgd1h6wNThlfS7UcH9qurRymXq/C7AvE5PWljpHbO3eVnydY+k1TWRy
	 Pjg/QMXHPJTZP+KZOBRLtEF+8E1JBYlxMY7D7AS8MRn+GvuH6HxfKh5mAr2sOr4Nla
	 q3W8BSBfQyaT3eZXCRvO4I1hlzzcAu9w4AA9dNR0P3yACKN9czXx2JsIetntGV5Tqa
	 OBcV9x9UGskYQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/damon/core: trace esz at first setup
Date: Mon, 20 Jul 2026 22:29:01 -0700
Message-ID: <20260721052901.167162-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072016-imprison-unknown-9cd4@gregkh>
References: <2026072016-imprison-unknown-9cd4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

DAMON traces effective size quota from the second update, only if a change
has been made by the update.  Tracing only changed updates was an
intentional decision to avoid unnecessary same value tracing.  Always
skipping the first value is just an unintended mistake.

The mistake makes the tracepoint based investigation incomplete, because
the first effective size quota is never traced.  It is not a big issue
when the 'consist' quota tuner is used, because it keeps changing the
quota in the usual setup.

However, when the 'temporal' tuner is used, the quota value is not changed
before the goal achievement status is completely changed.  For example, if
the DAMOS scheme is started with an under-achieved goal, the quota is set
to the maximum value, and kept the same value until the goal is achieved.
Because DAMON skips the first value, the user cannot know what effective
quota the current scheme is using.  Only after the goal is achieved, the
effective quota is changed to zero, and traced.

Unconditionally trace the initial quota value to fix this problem.

Note that the 'temporal' quota tuner was introduced by commit af738a6a00c1
("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL"), which was
added to 7.1-rc1.  But even with the 'consist' quota tuner, the tracing is
unintentionally incomplete.  Hence this commit marks the introduction of
the trace event as the broken commit.

Link: https://lore.kernel.org/20260520150311.80925-1-sj@kernel.org
Fixes: a86d695193bf ("mm/damon: add trace event for effective size quota")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 7e6cc35f5283eab81a14231a64ecd640b690c48c)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2b7e0ee772f32..9fb96d55d13a7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2237,6 +2237,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	if (!quota->total_charged_sz && !quota->charged_from) {
 		quota->charged_from = jiffies;
 		damos_set_effective_quota(quota, c);
+		if (trace_damos_esz_enabled())
+			damos_trace_esz(c, s, quota);
 	}
 
 	/* New charge window starts */
-- 
2.47.3

