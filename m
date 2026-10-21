Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594940;
	b=CfuIYKUYACllpKl/8/axnnDNag9MtqgzKAbpKeM8X7UPm0qbwUxPNpScXS9I0WTqLba7
	 Ss1bFMYKHGko0jnFhSqpiICqbnaAUKB6/UfRmhaP/h/LCqPaax6vOJE4z2MvzdyaP/3Mc
	 xuvnHQ7LJmqPbIc0sxYLsA/KciAKFAWl8x0mYqwDLRTSxffs9zrbOfXO/7VMrCjeQkTmE
	 jttnVSp1gohdd5MMVv8aFT8Pw/c64xW6XLhTYwv+BQl7OmYUpd7KLlmPM4gue8mcDWT8N
	 5326kl4aaH8uYfrV1Seq+o5gbWyyrrOLqmOUusay+vzW7G0upRo2Fc0gYFUz3fScc4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594940;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sTQqxp6IRefhLdRym85ZR83lEh3ipXz8xToRrlODhGs=;
	b=MxtBGwRX/1R9ytegt9HTfb1ZHbtxGbpXIC64JcnGsLNbKHcBX2o8AaC8i9eIqeJCSPhP
	 1gAEUaRp6wyZ93+ukikd06z4MRy33EW2kd2PQydiOO6V7LvXZ5w/ODE0mg+5Lyl+cPTPG
	 dRkY+tmkfsK7jqusHF3mQ3r1K/0LmqJESzZ+6p9tl1R8Tq2z2yy8lLeiPsSvXOKzrbWJa
	 B6hbb9vjVAqCg7PDbg9uA0Xb9H8dFql5tG6fekEcU7tfLqGirEiaPYV3Vak4lVK8cB7i8
	 HVlY6I0n+30RjKZiwGRbXCaMzMXGEe4Bi3JXe8RD93/hKDCh3GNqVJ9V99jmM0T51tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LIunwQK4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714AC606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LIunwQK4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61901F000C2;
	Wed, 21 Oct 2026 15:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594940;
	bh=sTQqxp6IRefhLdRym85ZR83lEh3ipXz8xToRrlODhGs=;
	h=Subject:To:Cc:From:Date;
	b=LIunwQK4YV4fK2dtrGH2Btaf03nQQZksU31hGqFgBdQsv53ZlJdlJtdVFoKCOU4/4
	 lMYBoXXBTzjApMgNqFMfY10gWsVllNNN2ZVaNvYOE6kUiEhmDUrin6/qQ6XlhNJnr/
	 JXiMYMvJbbhuNhk6TOROx8rFxT0ULcUy6NvYrTxs=
Subject: FAILED: patch "[PATCH] sched_ext: Fix the bypass dispatch claim for schedulers" failed to apply to 7.2-stable tree
To: tj@kernel.org,arighi@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:50:05 +0200
Message-ID: <2026102105-slicing-rupture-e72c@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 5bdeca322a6f8d10acaf67cccab1f69747ee7be3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102105-slicing-rupture-e72c@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5bdeca322a6f8d10acaf67cccab1f69747ee7be3 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Sun, 11 Oct 2026 11:35:12 -1000
Subject: [PATCH] sched_ext: Fix the bypass dispatch claim for schedulers
 bypassed by an ancestor

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
Reviewed-by: Andrea Righi <arighi@nvidia.com>

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

