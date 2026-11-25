Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622931;
	b=o+SGd0kO6qyzBjUkfv8r8pCtooJQd01m8za41tq6uUqliZNqJjeHmvpOABwhflKwZsvS
	 +J/Efc4/ABmvjEMlEbK6lRFKtH1C1FWdKO0m9fuj7XsQj7dAkJZvhOnVJwWc1JS70uBxF
	 2I9eiMLdnSjoGhR28dpg/7JxPkMQ5J3yaj44IovFvyeazDPtqmQkrEwUAZnApaRQf8wZV
	 XwagrTym5+SM2/mPLTHBym1e0ZVr732N8HOqHmWBcoRicdEsnXWs4WbDz25rW47Cb1vMJ
	 DwSdpuBudUdrpDgSR0AYQgm208z0lgKO5GGUrAGByqqmVgabwwqj+Xch8lG3KsOcC6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622931;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QMIDdWZH2uDwkA1AO+sd6FxNJcoyy9Ot2XFdQY3MGFE=;
	b=kH8WyOa/hF7Zff3t0cDnpXkUbWh8egArTBdJFbeW0GGrhMeb0h66YzBzZ99sfZj3SU54
	 XXU22XwSCyrWnKwNxPBD6r8N+5jdqZMQz4OdOha9rzgLRVNL4UXenqA8I3vSdTA/J2oty
	 +5zh1KikwXtkqK9HzOMQd6yUGeLCWp4a8W16kup6Ljx67u6mQVqrDol0TRRWuShqID5Pa
	 WFXl6HnnhXYfFFrsfhqAuPp12wzTKrsIKcZTWt2pQPuGO7rf+S/VxLB8zBwXmH5k1JMm0
	 nvgqzTvT77jXJDH1PFwDiVmbs5s+WbcttIW3C5phTeF7ypJwbkJ4u/X5xNLRTsGT1nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oi1BLaOF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA420606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oi1BLaOF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714AA1F000D0;
	Wed, 25 Nov 2026 16:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622931;
	bh=QMIDdWZH2uDwkA1AO+sd6FxNJcoyy9Ot2XFdQY3MGFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oi1BLaOFsqH0G6W3/oQrBXQMHgDVIaH5QZaMQnVN811zr1WmpykISeXlOp0BVXf+F
	 5EN1mKxAJ9P9K+OuqG4mCDTocRDo3wV/ZZ71es4FHqVvYxDe9+jFECHJjoZ4+IHfeV
	 EeOm+70ITanVgN25/5GJNi3n4seyod+F3MFyWtRCbdGnB8NOeekSQXgM/TNbNiA1At
	 9KT0PvDkeLQfPuhL4BdYKAOQS78621Ml7XZc6LyoVEk+o+kWFnJkyQeYpWS3MwcCSm
	 mB0h1pFjrnxNr5NO+cjwmvIzwQNegjuWF2laNnQgDuEJ3aQGH8wQIkSNLNdxL/v2+e
	 4pOaEAt8JZEHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] cgroup/cpuset: Correctly set isolated_cpus when switching partition state
Date: Wed, 25 Nov 2026 11:08:49 -0500
Message-ID: <20261125160807.675472-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112532-pellet-unvocal-7a50@gregkh>
References: <2026112532-pellet-unvocal-7a50@gregkh>
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
[ sashal: Context differs because the tree lacks the PERR_ISOPARENT check and has a different if/else shape, and the selftest matrix has different neighboring rows; the added lines are unchanged. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cpuset.c                        | 21 ++++++++++++++++++-
 .../selftests/cgroup/test_cpuset_prs.sh       |  7 +++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 9bd1753dbcbe2..52eed70c2eb43 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3235,7 +3235,26 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 			disable_partition = true;
 			err = PERR_HKEEPING;
 		} else {
+			struct cgroup_subsys_state *css;
+			struct cpuset *child;
+
+			/*
+			 * Need to scan child partitions, if present, and
+			 * exclude their effective_xcpus from cs. In the case
+			 * of switching to isolated partition with child root
+			 * partitions, those child partitions will be
+			 * invalidated in update_cpumasks_hier().
+			 */
 			isolcpus_updated = true;
+			cpumask_copy(tmpmask.new_cpus, cs->effective_xcpus);
+			rcu_read_lock();
+			cpuset_for_each_child(child, css, cs) {
+				if (!is_partition_valid(child))
+					continue;
+				cpumask_andnot(tmpmask.new_cpus, tmpmask.new_cpus,
+					       child->effective_xcpus);
+			}
+			rcu_read_unlock();
 		}
 	} else {
 		/*
@@ -3273,7 +3292,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (!is_partition_valid(cs))
 		reset_partition_data(cs);
 	else if (isolcpus_updated)
-		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
+		isolated_cpus_update(old_prs, new_prs, tmpmask.new_cpus);
 	spin_unlock_irq(&callback_lock);
 	update_isolation_cpumasks(isolcpus_updated);
 
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 25eef20c17466..2e8270a784922 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -441,6 +441,13 @@ TEST_MATRIX=(
 	"C1-4:P1:S+ C3-4:P2 .      .    T:C4-6   .      .      .     0 A1:5-6|A2:4 A1:P1|A2:P2 4"
 	"C1-4:P1:S+ C1-2:P2 .      .    T:C4-6   .      .      .     0 A1:4-6|A2:4-6 A1:P1|A2:P-2 ."
 
+	# Switch PRS state (root <=> isolated) will properly update cpuset.cpus.isolated
+	# even if child partitions are present.
+	" C1-6:P1 C3-6:P1 C5-6:P2  .       .    P2      .      .     0 A1:1-2|A2:3-4|A3:5-6 \
+								       A1:P1|A2:P2|A3:P2 3-6"
+	" C1-6:P1 C3-6:P2 C5-6:P2  .       .    P1      .      .     0 A1:1-2|A2:3-4|A3:5-6 \
+								       A1:P1|A2:P1|A3:P2 5-6"
+
 	#
 	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
 	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
-- 
2.53.0

