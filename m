Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548FC451076
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138066; cv=none; b=tTw7Icj2Eb5K+oG4xgkUAl2IGHmryfJ9qv5tJNI9fM1DkCJtNl+wEUYIaN3P8gaRfZgjdg6EXxeudrZhBkOCaST29ZPfqo2XILYiaAQB86qhXeLP39bfRjEV18Mv3gM4rDBCP0lUM/YtpAW3YvGKJNbT3Crq4D5DzJ1dLLZErfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138066; c=relaxed/simple;
	bh=qAzakh8S+VnudCNbLq2w7rSM/Si02Av1VhrAao59bnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u607X3PmWTsvNJmRWg8Y/cTzK95hKFSBWyBSclbvvLMFrrZDtBsAl00WMWEQfZvYRQJoPppBRiiDhXLTCUie8abA4xZxZM9oCAvtXSQkpKed0C9HLk2vl9tbSkhG5/mfHo/+2GaNrGpAHVW+30W+tJCtm5CMXgQG8jM/fXosazc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUkk3dYu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUkk3dYu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E42D1F00A3A;
	Wed, 19 Aug 2026 11:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138065;
	bh=qScY45F6hwdRx0V7V8NNaOiAJ/dftWEI6YW12fWJHSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XUkk3dYuUhpNY+X9TUExiZIoHtHhkyVIcSxZ9cOrROEcSBXYrF2xGwoTm2WUGuPEU
	 zCHK6kpo6Vc+xYJ4+EW1yda0hSUvi0KnK/D1j9tXueu2bLk65BcC0/Z2mkiuRiwVH9
	 tr93sevgbRvB2oZUdbJXZsitMDLhavYNDMCwKnqkj6f80CHeZy3vz1LQSUAzmCO8Mv
	 YwFXiypgraQ6Ncye9JelnYh26cfOkkyftrOQ11Sbk8qKiJ4v/DWZF5k5QUWsCCp5n6
	 cG7PRXzOzwcBoqqcjMtaCrFUuzKmIkXvm7aRdKBoalU/hDZhepX8lNBm1TkxVFH54A
	 Wbi9e7hs4cyLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] sched_ext: Take cgroup_lock() first in scx_cgroup_lock()
Date: Wed, 19 Aug 2026 07:14:20 -0400
Message-ID: <20260819111420.3549656-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819111420.3549656-1-sashal@kernel.org>
References: <2026081715-muscular-drizzly-bfad@gregkh>
 <20260819111420.3549656-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 5f8b69642d18e1f3e11996707842ac530444e959 ]

scx_cgroup_lock() write-locks scx_cgroup_ops_rwsem and then takes
cgroup_lock(), which can deadlock through kernfs:

  scx enable/disable         cgroup rmdir           cpu.weight write
  ------------------         ------------           ----------------
                             cgroup_lock()
  percpu_down_write(rwsem)
  cgroup_lock()
                                                    kernfs_get_active()
                                                    percpu_down_read(rwsem)
                             kernfs_drain()

The enable path waits for the rmdir to release cgroup_mutex. The rmdir,
deactivating the cpu controller's files, waits in kernfs_drain() for the
write's active reference. The write, in scx_group_set_weight(), waits for
the rwsem behind the pending writer.

Take cgroup_lock() first. The set_* paths take no cgroup locks inside the
read side, so a pending write-lock then only waits for read sections that
always run to completion, and no dependency from the rwsem back to
cgroup_mutex remains.

Fixes: a5bd6ba30b33 ("sched_ext: Use cgroup_lock/unlock() to synchronize against cgroup operations")
Cc: stable@vger.kernel.org # v6.18+
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
[ dropped the `#ifdef CONFIG_EXT_GROUP_SCHED` guards since the code already sits inside one, and applied to kernel/sched/ext.c instead of kernel/sched/ext/ext.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e53ebad5f84b..b5f95b379ea6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3313,16 +3313,21 @@ void scx_group_set_bandwidth(struct task_group *tg,
 	percpu_up_read(&scx_cgroup_ops_rwsem);
 }
 
+/*
+ * cgroup_lock() must nest outside the rwsem write side: a writer waiting
+ * for cgroup_mutex deadlocks with cgroup teardown, which holds it while
+ * draining a set_* file write blocked on the rwsem behind the writer.
+ */
 static void scx_cgroup_lock(void)
 {
-	percpu_down_write(&scx_cgroup_ops_rwsem);
 	cgroup_lock();
+	percpu_down_write(&scx_cgroup_ops_rwsem);
 }
 
 static void scx_cgroup_unlock(void)
 {
-	cgroup_unlock();
 	percpu_up_write(&scx_cgroup_ops_rwsem);
+	cgroup_unlock();
 }
 
 #else	/* CONFIG_EXT_GROUP_SCHED */
-- 
2.53.0

