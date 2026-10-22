Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673729;
	b=3ZsMDvl2pPbAy3vu1Fl17t2ab2aLNu9lku8sYoRlKHBkrJf0d8Hhr3KImTMQdwCzHz7u
	 ocTCDqsnnT6l5y+IhO1h30xuZ54ZuCmFFnIxrxBib3yucXWioGFKanZe5kg2zbtSei6kV
	 6ukz3H/aCtHrY2qKANUdBbNFJUZkNqU8GzDiSH7uHtwEweQcoen+pKpwZBf0J+CY/sw2A
	 ZHbUumsAcPwO5RM7rqBZNMHp5EeXDLv5wmhvb/TkQfIOIdcG25O0q+iEtiNhq1WkNotMp
	 pAHrXzAsgrINA40gubh0rG6xI0PJzFQhnV/T3SzwoqeyB/ujemKH7x035R87aM8Vc3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673729;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Y2X+9l5yeMsznu8XzBdikZjkUHM89U7faIRWTNrKhII=;
	b=u00eLINaTxQWagtIdCrC91Y3EM0WUYeCe/FxwpjmSidGOyK4PDSYo57tX0t/bogwM18f
	 Z4+HwI1NWDS8q2mBGgwMwgIfG3DoVXl5trJ8N51xeEhtQeCXt7o+YtFnj5bjL2OaSaqVg
	 hlBDf8M72eb2QPuW+smOva0xE1DNvv8Y2if6c/Bfk5gK4pvFdGgyyHpGRVF2Pw/8gPsG4
	 Y08qyGrU/1hggtHR8jaZOYCrGaNQGWmLlfQwCjz/Cpm1kffmOZyUHZMwRb5HJ/PoADzI8
	 HjqyaNTk8tmhq4Tl9nOtpWekTR+bZ3ik8alCTUlxZTMGcRBOu/RGkcnI7rBQMC6HETQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6jpUYAi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D39606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6jpUYAi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196441F000C1;
	Thu, 22 Oct 2026 12:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792673728;
	bh=Y2X+9l5yeMsznu8XzBdikZjkUHM89U7faIRWTNrKhII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f6jpUYAiR0uc38N4j4boJYk4YLCH8IXDIfm01YDBoDXekF5L/r3Yw3stu9CtEC1o9
	 CUa6hh/e7OpJ0TNGv+uKlAQZ5UbPajb0orqySt2rvo9gjh2NrD7Yu3oUSUEJrnQ+Lj
	 q0MV77bWFI7dgALleWCwVK9xNB9Wplb8pAQC8T2vhFrlBPTMS8zaG+0vJNHwtMo19v
	 iE/vAzVM2LlTmzBTRVDCy6uMzSVMvC2+KLeT2UjpB0iv3pF1j3bNKlQt+dBkMfhX5c
	 0vH8eVKxMHqNNA/5BQJBC+FfGoLes3Fxc1SKOjkhTUQaxRJrszEiHfZBbq7+oztnyd
	 jZh40d/8xUFYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] sched_ext: Fix the bypass dispatch claim for schedulers bypassed by an ancestor
Date: Thu, 22 Oct 2026 08:55:26 -0400
Message-ID: <20261022125419.1189016-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102105-slicing-rupture-e72c@gregkh>
References: <2026102105-slicing-rupture-e72c@gregkh>
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

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 5bdeca322a6f8d10acaf67cccab1f69747ee7be3 ]

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
[ sashal: Changed scx_disable_bypass_dsp() calls to disable_bypass_dsp(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext/ext.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e8497c967763d..515829b53a8cc 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5708,15 +5708,12 @@ static void enable_bypass_dsp(struct scx_sched *sch)
 
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
 	 * bypass_dsp_enabled() test is used to determine whether to enter the
 	 * bypass dispatch handling path from both bypassing and hosting scheds.
@@ -5809,16 +5806,19 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
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
 
@@ -5894,8 +5894,12 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 	}
 
 	/* disarming must come after moving all tasks out of the bypass DSQs */
-	if (!bypass)
-		disable_bypass_dsp(sch);
+	if (!bypass) {
+		guard(raw_spinlock)(&scx_sched_lock);
+		scx_for_each_descendant_pre(pos, sch)
+			if (!pos->bypass_depth)
+				disable_bypass_dsp(pos);
+	}
 unlock:
 	raw_spin_unlock_irqrestore(&scx_bypass_lock, flags);
 }
-- 
2.53.0

