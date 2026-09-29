Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061ED51C079
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683825; cv=none; b=cx1a0mVPAvhWckM5LAeObilZhKzYZaCGSY1Gz3CKutveeBG+KS2tjKLOQyogGhwge7/KPWnUJhQ3wbIoaGS/yYXYF9zSvr4fRa5rAAOVQk6x/yT8mKSye8RUZLgK7exSlkDAas9itgREdnFcLWbO2D04ALBHOrs1viCeCC1/sS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683825; c=relaxed/simple;
	bh=YiEc6fquk+Aui8uCUZXSkbLumTvIm2G+BzJ5UIl38U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSgMIiruAOnmeCTwZ4g2xK7GItq/md0WjkshUo3NAkO1wIds3SyDYN3HSf1BifnSbPh9STKCRdhm0AcCYTVmezLx7REWEQRrSZxvWiJcF4wkZ+daYyatXJp462b6s0f8ZxED8CLIq2uOX6pMmyZLo9FInVc54C8VwIVcjHP0Fco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvtzbP2W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvtzbP2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148B81F00893;
	Tue, 29 Sep 2026 12:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790683822;
	bh=vz1lVsbEQRtgDcmvJYc4djCyNmQHtnvtDDV6IETssns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OvtzbP2W11NPu37Z0WdIJ4ZQece7Tj4YDTFpwxU5KnkhvOX9wg16jpTDSjAAdK0kK
	 TDcjbxqtfYbyeP1Sk8anJuU5jq+piz/np7nJTwZY+dbKnEwJhsjV7Q39mFMDk+bQGP
	 3/xIPpz6+PH6CCfpf2c7jS/rYIWFCEmFWwXjFhcGcfEM1aG3RIbAKUU4rO8Y0xTWOu
	 GTIpJa+xa6/cesrB5VYAneLJfxcVRhAYYNlh55Xr/AqLVbxATbv/Bxfx7i4hruVOlf
	 3p/YRvrhlVMqEiwG+HFtLfwJEs6dMr97S98RwPT8lgpoGVRk5WGbhBzISkdhcABwSn
	 ayfpj0vvq9/sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huawei.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] cgroup/cpuset: Move up prstate_housekeeping_conflict() helper
Date: Tue, 29 Sep 2026 08:10:18 -0400
Message-ID: <20260929121020.3306361-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092918-captive-docile-ef46@gregkh>
References: <2026092918-captive-docile-ef46@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Waiman Long <longman@redhat.com>

[ Upstream commit 6cfeddbf4ade9202849d75c27c4d0c82b42c73d1 ]

Move up the prstate_housekeeping_conflict() helper so that it can be
used in remote partition code.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Stable-dep-of: 31c88350b7dd ("cgroup/cpuset: Return PERR_NOCPUS in remote_partition_enable() on subpartitions_cpus conflict")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cpuset.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6ab677c002181..14ad95ef37ed1 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1449,6 +1449,26 @@ static bool isolated_cpus_can_update(struct cpumask *add_cpus,
 	return res;
 }
 
+/*
+ * prstate_housekeeping_conflict - check for partition & housekeeping conflicts
+ * @prstate: partition root state to be checked
+ * @new_cpus: cpu mask
+ * Return: true if there is conflict, false otherwise
+ *
+ * CPUs outside of boot_hk_cpus, if defined, can only be used in an
+ * isolated partition.
+ */
+static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
+{
+	if (!have_boot_isolcpus)
+		return false;
+
+	if ((prstate != PRS_ISOLATED) && !cpumask_subset(new_cpus, boot_hk_cpus))
+		return true;
+
+	return false;
+}
+
 static void update_isolation_cpumasks(bool isolcpus_updated)
 {
 	int ret;
@@ -1751,26 +1771,6 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	remote_partition_disable(cs, tmp);
 }
 
-/*
- * prstate_housekeeping_conflict - check for partition & housekeeping conflicts
- * @prstate: partition root state to be checked
- * @new_cpus: cpu mask
- * Return: true if there is conflict, false otherwise
- *
- * CPUs outside of boot_hk_cpus, if defined, can only be used in an
- * isolated partition.
- */
-static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
-{
-	if (!have_boot_isolcpus)
-		return false;
-
-	if ((prstate != PRS_ISOLATED) && !cpumask_subset(new_cpus, boot_hk_cpus))
-		return true;
-
-	return false;
-}
-
 /**
  * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
-- 
2.53.0

