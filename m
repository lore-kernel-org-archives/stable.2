Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C3F3C3F68;
	Thu, 16 Jul 2026 21:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784237463; cv=none; b=PIbj5GK/QmdagZ0Korzn8KOcvrteybMby25i8f69r1HvxpbI3VIBKRHIfKKoAAHgDW5SqDgzMOI3NNt/2t2G87J6QQtqjC/JWmjCKSOtkdrNKCWPxE9KyES8xDf5DDPusijrAOmalBP+91S9UB0x4z4Z+oNE63f0woUjxz8UDxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784237463; c=relaxed/simple;
	bh=5XcRkEatVXnCaiaZDch8URxqKDgAzOMTWN03R+Wgkmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DACGG+zXraOgjvVu8o4d2m1Jv8HWDXJt1GKkpybT3ks8AQKZ2xIR58+3jwZIb/duQfJ95QRPp6ogb4+6kUDp96HHr0raDyonBFw88DYJIc5fAXlGVaPQ27BiUV7kqwA0ERmcoBbXf6vyHJMjyFek3Pr1y2iwi4WX5aWplu/PUAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVF6cmHz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVF6cmHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778C71F000E9;
	Thu, 16 Jul 2026 21:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784237461;
	bh=egTboFz70l3OBqWVwTUDzfHwtFuMvrqkhwzSSovfjVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gVF6cmHzSSQVZnvNJz7pPT97RGsnL+KYe+mqZaaVbZ4qz34a2rCXuBKUqU6Y6rdYC
	 OJ+cj4cARdaeZOdRjLXRfIWAdYUzrt9JEKlP7AruKdV18XzL8mepjRFY6ToLnkqk1a
	 gHFH7EcbV7/+j+l7FXl9TsZs1U0hOYnWPc/UASCsFDUtsVCyg4Cw2x3vUq1ljvvG3c
	 V+cFpyyLUFa6hqc5/mpctktAJajxoTf+lwMEVu9nW9fUiBX3Q59J6FbX7jQ09DZObd
	 jff8wP8SzFA+SVPtDo6yaus6smu5RW3TbYaFLE6bZVt7ExIr6Xznbc/PcRK8vrYtqa
	 ogadb8lrr3Ejw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] sched_ext: Take cgroup_lock() first in scx_cgroup_lock()
Date: Thu, 16 Jul 2026 11:30:56 -1000
Message-ID: <20260716213058.1739522-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716213058.1739522-1-tj@kernel.org>
References: <20260716213058.1739522-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 kernel/sched/ext/ext.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 46f135bddd46..58898cd0727b 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4580,20 +4580,25 @@ static struct cgroup *root_cgroup(void)
 	return &cgrp_dfl_root.cgrp;
 }
 
+/*
+ * cgroup_lock() must nest outside the rwsem write side: a writer waiting
+ * for cgroup_mutex deadlocks with cgroup teardown, which holds it while
+ * draining a set_* file write blocked on the rwsem behind the writer.
+ */
 static void scx_cgroup_lock(void)
 {
+	cgroup_lock();
 #ifdef CONFIG_EXT_GROUP_SCHED
 	percpu_down_write(&scx_cgroup_ops_rwsem);
 #endif
-	cgroup_lock();
 }
 
 static void scx_cgroup_unlock(void)
 {
-	cgroup_unlock();
 #ifdef CONFIG_EXT_GROUP_SCHED
 	percpu_up_write(&scx_cgroup_ops_rwsem);
 #endif
+	cgroup_unlock();
 }
 #else	/* CONFIG_EXT_GROUP_SCHED || CONFIG_EXT_SUB_SCHED */
 static inline struct cgroup *root_cgroup(void) { return NULL; }
-- 
2.55.0

