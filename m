Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89E503BE0
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683833; cv=none; b=o0G28X31zyevTNN7Cy7/DpBaKX3va0haiW3dMu4MhrOUY7mxBqPxHv6GBS40Fdd17P1Z4hFGA14tTQI2YruRwQeeQbgwQgdA5AajcAxOG+WCnCSKNx1GApJdTHegG345arX6/B9Yy6yCj7cWTiU9eEey2mriCBb7hDyTX2V4t3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683833; c=relaxed/simple;
	bh=xTlLcDlJd4gC0PI83WFZi90s8iRLyUj7rwuoQQPmRUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXJRr0SDN7gWrVb1G8tH8iQDUKsPOcxfNuCQlytZ42qHx2Ee3CDHKCuocPEMCMa7y1t5stzkvHvbreZ/0rMRYDRS/tTraFpOko49sqH7inkF4lHnX+ik/mv6AexbONwnmilPlNaD0EkRXTHVj59xafGMdNDv44U8yBTqNMVJJNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpPHJU92; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpPHJU92"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67D51F0089A;
	Tue, 29 Sep 2026 12:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790683824;
	bh=OEH/ZxS2zah0MypDyhKJppv566Bu9su1vO57zJjRsEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UpPHJU92ZZQqic3dfw8bl/a04ENFpnvUjkr6MAyvHFPj9DcYEyet1Ax70TAwXBQoT
	 Xj6fONY2R8e0tOeAkpuxstrrde33pDihuWydXITTod5WQ+KHtE6Vtc8ZE8GVDpciKL
	 vyabY7+jfb7WPYYhxo77a2A6DBlRr0QK6qwl16vzti6Vep5Cgbb9KgOSffeUkIh1J/
	 glT/Criz0oDQ2G2nr0AKCz9wMwhX36vhDJ9aFIVGjvbWtnkpojfxXM8c8RSi75h2Y1
	 +LOBj3UjFgdw2CqCvCR9yRRi+u/8W++dtaWS4XyXOrMrQPUmzHSJPo+aRHIqdzq81I
	 PHVYQPygTdFoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Peng <benquike@gmail.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] cgroup/cpuset: Return PERR_NOCPUS in remote_partition_enable() on subpartitions_cpus conflict
Date: Tue, 29 Sep 2026 08:10:20 -0400
Message-ID: <20260929121020.3306361-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929121020.3306361-1-sashal@kernel.org>
References: <2026092918-captive-docile-ef46@gregkh>
 <20260929121020.3306361-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hui Peng <benquike@gmail.com>

[ Upstream commit 31c88350b7dd1522792f726f79607f31bb55c50f ]

When a remote partition is created underneath an existing local partition
via a non-partition (PRS_MEMBER) intermediate cgroup, update_prstate() sees
parent->partition_root_state == PRS_MEMBER and calls
remote_partition_enable().

Commit 86888c7bd117 ("cgroup/cpuset: Add warnings to catch inconsistency
in exclusive CPUs") replaced the cpumask_intersects(tmp->new_cpus,
subpartitions_cpus) error check in remote_partition_enable() with
WARN_ON_ONCE(). As a result, remote_partition_enable() emits a warning
and proceeds to enable the remote partition on CPUs that are already
owned by the ancestor local partition in subpartitions_cpus.

This can be reproduced on Linux 7.3.0-rc3 with:

  mkdir -p /tmp/cg1
  mount -t cgroup2 none /tmp/cg1
  echo "+cpuset" > /tmp/cg1/cgroup.subtree_control

  mkdir /tmp/cg1/A
  echo 1 > /tmp/cg1/A/cpuset.cpus
  echo 1 > /tmp/cg1/A/cpuset.cpus.exclusive
  echo root > /tmp/cg1/A/cpuset.cpus.partition
  echo "+cpuset" > /tmp/cg1/A/cgroup.subtree_control

  mkdir /tmp/cg1/A/B
  echo 1 > /tmp/cg1/A/B/cpuset.cpus
  echo 1 > /tmp/cg1/A/B/cpuset.cpus.exclusive
  echo "+cpuset" > /tmp/cg1/A/B/cgroup.subtree_control

  mkdir /tmp/cg1/A/B/D
  echo 1 > /tmp/cg1/A/B/D/cpuset.cpus
  echo 1 > /tmp/cg1/A/B/D/cpuset.cpus.exclusive
  echo root > /tmp/cg1/A/B/D/cpuset.cpus.partition

which triggers:

  WARNING: kernel/cgroup/cpuset.c:1594 at remote_partition_enable+0x1c1/0x300

and leaves both /tmp/cg1/A and /tmp/cg1/A/B/D as active root partitions
claiming exclusive CPU 1.

Fix this by returning PERR_NOCPUS when tmp->new_cpus intersects
subpartitions_cpus in remote_partition_enable(), matching the error code
used by remote_cpus_update() for the same subpartitions_cpus conflict, and
add a regression test case to
tools/testing/selftests/cgroup/test_cpuset_prs.sh.

Tested in QEMU on Linux 7.3.0-rc3 using the reproducer above and
tools/testing/selftests/cgroup/test_cpuset_prs.sh.

Fixes: 86888c7bd117 ("cgroup/cpuset: Add warnings to catch inconsistency in exclusive CPUs")
Suggested-by: Guopeng Zhang <guopeng.zhang@linux.dev>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cpuset.c                            | 3 ++-
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 17d4ef96794c1..eebbede820700 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1623,10 +1623,11 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	 * above it or remote partition root underneath it is not allowed.
 	 */
 	compute_excpus(cs, tmp->new_cpus);
-	WARN_ON_ONCE(cpumask_intersects(tmp->new_cpus, subpartitions_cpus));
 	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
 	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
 		return PERR_INVCPUS;
+	if (cpumask_intersects(tmp->new_cpus, subpartitions_cpus))
+		return PERR_NOCPUS;
 	if (((new_prs == PRS_ISOLATED) &&
 	     !isolated_cpus_can_update(tmp->new_cpus, NULL)) ||
 	    prstate_housekeeping_conflict(new_prs, tmp->new_cpus))
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 592e533cd4d7b..6f7e387f68e5b 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -297,6 +297,8 @@ TEST_MATRIX=(
 	" C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 \
 				   .      .      .      X1      .    0 A1:0-1|A2:2-4|A3:2-4 \
 								       A1:P0|A2:P2|A3:P-1 2-4"
+	" CX1-3:P1 CX1-3  CX1-3    .      .      .      P1      .    0 A1:1-3|A2:1-3|A3:1-3 \
+								       A1:P1|A2:P0|A3:P-1"
 
 	# Remote partition offline tests
 	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 .   0 A1:0-1|A2:1|A3:3 A1:P0|A3:P2 2-3"
-- 
2.53.0

