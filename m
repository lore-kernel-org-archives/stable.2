Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A8D37E5C9;
	Sun, 11 Oct 2026 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791754833; cv=none; b=UrdCpWp3PfB329586n21PZKhHlAdLH7ruFfKRojUohIePqslg8TRgBuQA/rI1IagKMW6fCa560pxgFCYuGbl4tBndWRaQG1Sy3D6g6n+A/XqkjXC+9UVwOLAK5zwYfwu9qkSbPO+FFGTD8TKbgMnnNRl70174tLiXfxQ3lEkvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791754833; c=relaxed/simple;
	bh=35aG5eOCLJAUzUcWTKBJJKxovy5s4tN16HtgnnO4Crc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0Vmq4SEII/7Ye8iLBeeR9wHoY4WPgz6wo6UHoDobxNGgPmDZnZYuGCjYLCTlQI93+8TqRkWMgFs20JF03CCCrOqPjSGfDiPpTzebLidAtNafJDYzajLIQTO/KbtzKJ1RulOO0jTxQWPOvbg3Km6jAMSN5BbIVRM97mtYlBgPH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bStsu4Yw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bStsu4Yw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED791F0089B;
	Sun, 11 Oct 2026 21:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791754831;
	bh=4y80yLjldmJgxg/F+k8ClU+tSYjrWWhk6QqhRI8No4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bStsu4YwwJhlDI61JQOga9ovUJtbEI2uQSsUdZS2zmCufsQuG4+Sjz5Gg6l+8lgvz
	 b3F8vcP0HBfKDzRU38qtCTdfjY3h5j2JyOXYdT6qXVNo3+smTMScuMXimgxDBvZUTv
	 BbtFFTWkOKLLA8eCMckyo6BDSh4ZWPpJ8uoz0u1NWAb1PmAKAnMUvp0iEevo2ZMedN
	 KximoRkZVb+teEAXlv2X+U1nXq9hFUN7PYP4bJJyCl1010UIm/LGQPQ6RFRoIWl6vf
	 Ytgpy1gaLKgK1hYKRDzIz/9qZ4mhfN3YW2dpjp6cGZ1SBiBeZlTWKWzfZD9+FgHdEm
	 alvr3SrpG43Dw==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] sched_ext: Fix the bypass dispatch claim for schedulers bypassed by an ancestor
Date: Sun, 11 Oct 2026 11:40:28 -1000
Message-ID: <20261011214028.743546-3-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261011214028.743546-1-tj@kernel.org>
References: <20261011214028.743546-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bypass() claims bypass dispatch when the scheduler's depth goes from
zero to one and releases it when the depth returns to zero, but propagates
only the depth to the descendants, not the claim. A descendant that starts
bypassing with its ancestor never claims, and one whose own bypass ends
under the ancestor's keeps its claim, as its depth does not return to zero.

A sub-scheduler enable whose bypass ends under a PM suspend thus leaks its
claim: the parent keeps hosting bypass dispatch and the sub-scheduler's next
bypass trips the WARN_ON_ONCE() on the claim. A sub-scheduler disable that
starts under a PM suspend has no claim, so once the resume lifts the root's
bypass its tasks sit on the parent's bypass DSQs with nobody consuming them.

Claim for every descendant whose depth goes from zero to one in the
propagation and release every scheduler in the subtree whose depth returned
to zero once the tasks have moved out of the bypass DSQs. A parent that is
bypassing itself when a descendant claims consumes only its own bypass DSQs,
empty until it leaves bypass and becomes the host.

Fixes: aa2a0a19686c ("sched_ext: Separate bypass dispatch enabling from bypass depth tracking")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 3edb51bdd0ef..7303c2c45964 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6099,15 +6099,12 @@ static void enable_bypass_dsp(struct scx_sched *sch)
 
 	/*
 	 * When a sub-sched bypasses, its tasks are queued on the bypass DSQs of
-	 * the nearest non-bypassing ancestor or root. As enable_bypass_dsp() is
-	 * called iff @sch is not already bypassed due to an ancestor bypassing,
-	 * we can assume that the parent is not bypassing and thus will be the
-	 * host of the bypass DSQs.
-	 *
-	 * While the situation may change in the future, the following
-	 * guarantees that the nearest non-bypassing ancestor or root has bypass
-	 * dispatch enabled while a descendant is bypassing, which is all that's
-	 * required.
+	 * the nearest non-bypassing ancestor or root. The parent hosts them
+	 * unless it is bypassing too. Then they sit further up and the parent
+	 * consumes only its own bypass DSQs, empty until it leaves bypass and
+	 * becomes the host. Either way the nearest non-bypassing ancestor or
+	 * root has bypass dispatch enabled while a descendant is bypassing,
+	 * which is all that's required.
 	 *
 	 * scx_bypass_dsp_enabled() test is used to determine whether to enter
 	 * the bypass dispatch handling path from both bypassing and hosting
@@ -6232,16 +6229,19 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 	 * Bypass state is propagated to all descendants - an scx_sched bypasses
 	 * if itself or any of its ancestors are in bypass mode. A descendant's
 	 * depth is the sum of its own bypasses and its ancestors', so every
-	 * call propagates whether or not @sch changed state.
+	 * call propagates whether or not @sch changed state. The descendants'
+	 * claims are released below with @sch's, after their tasks have moved.
 	 */
 	raw_spin_lock(&scx_sched_lock);
 	scx_for_each_descendant_pre(pos, sch) {
 		if (pos == sch)
 			continue;
-		if (bypass)
-			inc_bypass_depth(pos);
-		else
+		if (bypass) {
+			if (inc_bypass_depth(pos))
+				enable_bypass_dsp(pos);
+		} else {
 			dec_bypass_depth(pos);
+		}
 	}
 	raw_spin_unlock(&scx_sched_lock);
 
@@ -6330,8 +6330,12 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 	}
 
 	/* disarming must come after moving all tasks out of the bypass DSQs */
-	if (!bypass)
-		scx_disable_bypass_dsp(sch);
+	if (!bypass) {
+		guard(raw_spinlock)(&scx_sched_lock);
+		scx_for_each_descendant_pre(pos, sch)
+			if (!pos->bypass_depth)
+				scx_disable_bypass_dsp(pos);
+	}
 unlock:
 	raw_spin_unlock_irqrestore(&scx_bypass_lock, flags);
 }
-- 
2.56.0

