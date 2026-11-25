Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623434;
	b=iCM+BmVZZU8Wn0w70g35zRUydsafXxUbkZGuaGabFwroDkf5tOkZKmasLk2+9rN6SGg7
	 oPSDr7bHGeqN/IEHKv6/pGOkx95M4+Q8rZS2VONmdUy5mYv/iyPnMwuKcYNieKhqrdBjc
	 6F4L6AimNhTzU/OX9l/Di6bkx1zQ8PaJqu1aYpvWwLzZvcmbajbBS7e+6YyIJ5LbmjtJm
	 9sKPS8qo+U2Te5yVC1no3iudlSD+dEgFwu08E7NZKS3xAUjmeVLDZNpNlAuFD98Metwgs
	 SrxI1xMKcMMaHiAdnbp6fmgasn8wVUWxej6vgIjtfPtA7NjPDXjPbJglVEoPU6VYwiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623434;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RzdvxBihKwoFxJdwhrN5p7e14b1CC7v7HqdADYqbl50=;
	b=FrSpDezpMwtaPpHob3pS8nRD/br0hp1daFLxccFx9nS/hbqGLVQq0STVTtio8q9i57Ph
	 RI55thC9OJ5SW07szc9kEuFMvYeTiuD3L837SvvFasOOf/q3YSgaJSbCrKtYw1MgnWW1P
	 8ldrh0VYlb9bbp5usDJ4bGE1NwUsmlA1flyw2Bmn27Qi1L/Vr9OA2zl9Z9ZfVjnzLKel7
	 5CEnNj6GR4l3ev51C+qpX44RiXzV31n7jBCVD7k+duUAzC0INZIsXFm+1IdjuGGerIgJo
	 GJdlLUqrZMWYqZhf/lj7zyt0VH4npHUbIcluMYFGg7iJibldgnhpjwS/XcAMQz3XY3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8Rv1snv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7CD606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8Rv1snv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608FD1F000C4;
	Wed, 25 Nov 2026 16:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795623434;
	bh=RzdvxBihKwoFxJdwhrN5p7e14b1CC7v7HqdADYqbl50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M8Rv1snvnGvuPFMQ31oPvomDWoGGAAeob0wmK3PJXT3VOwW6zC/HRyvWlqDitRq1o
	 1asotxl3eEpqdHzD/mJflGW/szBLBVp3CJxKlWxRSFGpCSSUEDvCNSxtSr1qzxEswJ
	 h/65nJe9/4CDxD+RgfF5qDfmg5f1DpqEjgeyWRsbqrnXhuHDWZTxrJEXawZ8eu1g62
	 NaK+kjUEpEf/W1SLKH5854sWRkHyfQWWh7RwMF0DUgiXi4wDV9EK8gsmTZe2yPH8fq
	 l2w2TlGBNx/aVl8aD4rf/5NZTC9pA97K2ufesYHg9DkkzVsyR7K2Or2QkvqANO3gWW
	 71PJqz0rRyMPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] cgroup/cpuset: Correctly set isolated_cpus when switching partition state
Date: Wed, 25 Nov 2026 11:17:12 -0500
Message-ID: <20261125161646.726278-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112532-stitch-earthy-8c0e@gregkh>
References: <2026112532-stitch-earthy-8c0e@gregkh>
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

From: Waiman Long <longman@redhat.com>

[ Upstream commit 56681bc448a80bb2473026b41c44c133766bc38d ]

When update_prstate() is called to switch the partition state from
root to isolated or vice versa, the whole effective_xcpus is passed to
isolated_cpus_update(). However, if there are child partitions present,
some of the effective_xcpus are dedicated to those child partitions
and their partition states will remain the same or get invalidated in
the case of child root partition with isolated parent in the latter
update_cpumasks_hier() call. In the latter case, their exclusive CPUs
will be returned to their parent.

Therefore isolated_cpus may be set incorrectly with child partitions
underneath. Fix that by excluding their exclusive CPUs in computing
the correct cpumask of exclusive CPUs used by that partition alone.

Add new test cases into test_cpuset_prs.sh to test for such cases.

Fixes: 11e5f407b64a ("cgroup/cpuset: Keep track of CPUs in isolated partitions")
Cc: stable@vger.kernel.org # v6.8+
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Ridong Chen <ridong.chen@linux.dev>
Tested-by: Ridong Chen <ridong.chen@linux.dev>
Signed-off-by: Tejun Heo <tj@kernel.org>
[ sashal: Adapted to the older helper names and control flow, with no housekeeping error path; test rows use :S+ for nested partitions, and the comment says child CPUs stay dedicated. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cpuset.c                        | 19 ++++++++++++++++++-
 .../selftests/cgroup/test_cpuset_prs.sh       |  7 +++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 7e7ef1469a4d3..a8024feac0bd6 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2950,7 +2950,24 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		/*
 		 * A change in load balance state only, no change in cpumasks.
 		 */
+		struct cgroup_subsys_state *css;
+		struct cpuset *child;
+
+		/*
+		 * Need to scan child partitions, if present, and exclude
+		 * their effective_xcpus from cs, as those CPUs remain
+		 * dedicated to the child partitions.
+		 */
 		new_xcpus_state = true;
+		cpumask_copy(tmpmask.new_cpus, cs->effective_xcpus);
+		rcu_read_lock();
+		cpuset_for_each_child(child, css, cs) {
+			if (!is_partition_valid(child))
+				continue;
+			cpumask_andnot(tmpmask.new_cpus, tmpmask.new_cpus,
+				       child->effective_xcpus);
+		}
+		rcu_read_unlock();
 	} else {
 		/*
 		 * Switching back to member is always allowed even if it
@@ -2983,7 +3000,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (!is_partition_valid(cs))
 		reset_partition_data(cs);
 	else if (new_xcpus_state)
-		partition_xcpus_newstate(old_prs, new_prs, cs->effective_xcpus);
+		partition_xcpus_newstate(old_prs, new_prs, tmpmask.new_cpus);
 	spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(new_xcpus_state);
 
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index f52678bb2efee..c49228c603d96 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -406,6 +406,13 @@ TEST_MATRIX=(
 	# affect cpuset.cpus.exclusive.effective.
 	" C1-4:X3:S+ C1:X3  .      .       .     C      .      .     0 A2:1-4|XA2:3"
 
+	# Switch PRS state (root <=> isolated) will properly update cpuset.cpus.isolated
+	# even if child partitions are present.
+	" C1-6:P1:S+ C3-6:P1:S+ C5-6:P2 .  .    P2      .      .     0 A1:1-2|A2:3-4|A3:5-6 \
+								       A1:P1|A2:P2|A3:P2 3-6"
+	" C1-6:P1:S+ C3-6:P2:S+ C5-6:P2 .  .    P1      .      .     0 A1:1-2|A2:3-4|A3:5-6 \
+								       A1:P1|A2:P1|A3:P2 5-6"
+
 	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
 	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
 	# Failure cases:
-- 
2.53.0

