Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5959551B19D
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683828; cv=none; b=uCQZW8n+YU90P1KFRF8lPhQ5qWaMA5u2tZYjI0aiqR4xwi+S3Z7gUwveE9K2G9etHU8ZqQh3GHvBvCCf3WyeaMv4J9QGBj35j48qQVzxm2ZaPu9vkxhte30s4Y9LgCEXAp02SxzRVwuaZfz6bwg2c+R0CrUwjl/eEfJu2hr5aWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683828; c=relaxed/simple;
	bh=vUkbxxPBpuyf2wVVjm4bVWKgRRudgP34Vnya18i442A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7FNWKlQ3sWSKLSL50CUhUYIlI59fmijDHGJIrNVwcKLOH2ebzTB+JGb+9HcM10bmRCSkwGjldFmN0KRFmM0nRhW8xat2Xb2w9/HYbJODg2rBIU0Y7S3/szs3GI+i1CRkiK7P21qZRglig5l5sKWHB4sc1V9T2N1GVqrfKae5rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeXNKNlm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeXNKNlm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E007D1F000FF;
	Tue, 29 Sep 2026 12:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790683823;
	bh=7TFXatqgW1bruDpAes98F46Jbyp7Lymv6CkQOyMePH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VeXNKNlm0seYb+xcB1g1WQlOzq0VYSbv4dRMe8xEPsc//jouE0dUPOVc9WqRkORNe
	 +iNagr120dkSMq8TLElbiFGDgALNVxFZxPURFuE+A7rCIR7w9C+eTiZGkbmeKoA8t7
	 heMvqEKBNqUHyJ367mWlvfV9DAoNSgIvv+XzX5NkHXNUFZ1e2ib/jUDSOULB3n7xgD
	 791soqcYwM2M0UINNHr8JrVX/hadpd6hUHj/KCdtmwR20jo3v0AO+ICzVtOPCmJCdz
	 8yCuqP7u5NsGldmT9mZOFbqWrm+5DGFb5TfeQh5EbAtbJb/C1GWcTBoPh5G/a5hLmZ
	 MqB8vZ7UXXNeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huawei.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] cgroup/cpuset: Ensure domain isolated CPUs stay in root or isolated partition
Date: Tue, 29 Sep 2026 08:10:19 -0400
Message-ID: <20260929121020.3306361-2-sashal@kernel.org>
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

From: Waiman Long <longman@redhat.com>

[ Upstream commit b1034a690129acd8995137bf4462470b4a2aa690 ]

Commit 4a74e418881f ("cgroup/cpuset: Check partition conflict with
housekeeping setup") is supposed to ensure that domain isolated CPUs
designated by the "isolcpus" boot command line option stay either in
root partition or in isolated partitions. However, the required check
wasn't implemented when a remote partition was created or when an
existing partition changed type from "root" to "isolated".

Even though this is a relatively minor issue, we still need to add the
required prstate_housekeeping_conflict() call in the right places to
ensure that the rule is strictly followed.

The following steps can be used to reproduce the problem before this
fix.

  # fmt -1 /proc/cmdline | grep isolcpus
  isolcpus=9
  # cd /sys/fs/cgroup/
  # echo +cpuset > cgroup.subtree_control
  # mkdir test
  # echo 9 > test/cpuset.cpus
  # echo isolated > test/cpuset.cpus.partition
  # cat test/cpuset.cpus.partition
  isolated
  # cat test/cpuset.cpus.effective
  9
  # echo root > test/cpuset.cpus.partition
  # cat test/cpuset.cpus.effective
  9
  # cat test/cpuset.cpus.partition
  root

With this fix, the last few steps will become:

  # echo root > test/cpuset.cpus.partition
  # cat test/cpuset.cpus.effective
  0-8,10-95
  # cat test/cpuset.cpus.partition
  root invalid (partition config conflicts with housekeeping setup)

Reported-by: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Stable-dep-of: 31c88350b7dd ("cgroup/cpuset: Return PERR_NOCPUS in remote_partition_enable() on subpartitions_cpus conflict")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cpuset.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 14ad95ef37ed1..17d4ef96794c1 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1627,8 +1627,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
 	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
 		return PERR_INVCPUS;
-	if ((new_prs == PRS_ISOLATED) &&
-	    !isolated_cpus_can_update(tmp->new_cpus, NULL))
+	if (((new_prs == PRS_ISOLATED) &&
+	     !isolated_cpus_can_update(tmp->new_cpus, NULL)) ||
+	    prstate_housekeeping_conflict(new_prs, tmp->new_cpus))
 		return PERR_HKEEPING;
 
 	spin_lock_irq(&callback_lock);
@@ -3109,8 +3110,9 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		 * A change in load balance state only, no change in cpumasks.
 		 * Need to update isolated_cpus.
 		 */
-		if ((new_prs == PRS_ISOLATED) &&
-		    !isolated_cpus_can_update(cs->effective_xcpus, NULL))
+		if (((new_prs == PRS_ISOLATED) &&
+		     !isolated_cpus_can_update(cs->effective_xcpus, NULL)) ||
+		    prstate_housekeeping_conflict(new_prs, cs->effective_xcpus))
 			err = PERR_HKEEPING;
 		else
 			isolcpus_updated = true;
-- 
2.53.0

