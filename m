Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318893;
	b=GdA3b5RcsRvCHWQeJE0RqqIGK3SIt2tlYmdl1Ilnt0RMB+Ula9DH3HS9AkT/u15IRi0B
	 Xegblo4IuZWvTz7SaG5U1bQaC5A5nWiA5pcfBQQFm156/Qj30Yf4BQVNGkt+95hYFl8kO
	 1rWxiCQfEjOgNDXJcnAPT2VmDofVPavJKX4N2XexB2gus3/jhjpgQ2UZ9jRkDT+0Hi34o
	 3V2K3TmiDOr0zV2Xo3r8HKrC43aSamJI/VQ0cUpjwHn9q7SuKkvtiBoyhFPynZUe0S9Hj
	 EVQv2wQc5RL1plXfoMUx6aS+YPZD65FSHIV6OelRqICVTfPFGWaGYQL2Pci0QAj2Ujw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318893;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4N781dsrUSN6kUlh44EHq5fY/11pfi6X7/JwU+utkJo=;
	b=FqcB0kwS+kGm1o/j5qwQUDXTJuuX8LjtXyGmcN4Pyc1KsfTv86TcIhUbkpXqZPOxButV
	 3t5zxZN+O3F3ZuftHf5liJcCMtLjCOeHuJG+/XQqlW3RHsehm5Zn7/PoeH1ABkjkkEzR5
	 okaktm9BDolxTXq7dM6pG9q4jc99/edCn/b8ePq0CJ8rU9XmZXzAYpJWLXhQOhBGoschm
	 xvcJRAJ3tR9qqC3K0gz46seIDPgxfp5Zrz9uvw27olKhuNj+GwNCe+IlJ70rTVIVUSwjM
	 WqMZRfdEHYDfTxfhZ86JX52IRZMEJ0inp2DNcVK19fRlP9mjq/Se1C+UGVu76SsY5ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqUE8rTj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DADF606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqUE8rTj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7AA1F008A3;
	Tue, 10 Nov 2026 13:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318892;
	bh=4N781dsrUSN6kUlh44EHq5fY/11pfi6X7/JwU+utkJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mqUE8rTj31FSHXkgAuzL9gH0Rek72N71vWoDyO3DAtV0XTzh6CmW531CPumgdZL8C
	 CDdSaXhqm5+nMlwTgAT1UChfIzcEuxS6f1FbXPw/LJKjDRo+NEFxu1IA20saYiKTfp
	 lZX5ViixBJAbIP3PqIkznB4GfiMNCFAAlVX92NyqZaRvASjftHtl2qEOXSGxZe7ZmA
	 /MggiXPnnqcQxwTqfDeKNszFyhQwTObTsio+zZJrC37TVX4AmT9xkCiQO6ZYAcXwl1
	 Vc1hAaAk1IKOdmi0+aQbj5NQPojJpBs6HMUzlPJGCwu7YN13UjQndCXNvlsjKGh0Zm
	 9lp55uLSi8vnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dcache: report a Tasks-RCU quiescent state in dentry_kill()
Date: Tue, 10 Nov 2026 08:54:50 -0500
Message-ID: <20261110135433.1729031-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060022-failed-5.15-a647a53bc89a@kernel.org>
References: <20261107060022-failed-5.15-a647a53bc89a@kernel.org>
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

From: Breno Leitao <leitao@debian.org>

[ Upstream commit a647a53bc89a046bee4a12a0a5627f2dfaaef807 ]

I am constantly seeing the following warning on Meta's fleet:

  INFO: rcu_tasks detected stalls on tasks:
    native_queued_spin_lock_slowpath
    locked_inode_to_wb_and_lock_list
    inode_io_list_del
    evict
    __dentry_kill
    shrink_dentry_list
    shrink_dcache_tree
    d_invalidate
    btrfs_delete_subvolume
    btrfs_ioctl_snap_destroy
    btrfs_ioctl
    do_syscall_64

dentry_kill() is the common funnel for dentry teardown: dput(),
shrink_dentry_list() and shrink_dcache_tree() all reach it, once per
dentry, and its cond_resched() is the only reschedule point on that path.

cond_resched() is not an RCU-tasks quiescent state.

Use cond_resched_tasks_rcu_qs() so the teardown reports an RCU-tasks
quiescent state as it proceeds.

Fixes: 9c5f1d30199d ("dcache: move cond_resched() into the end of __dentry_kill()")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20260918-dcache-task-rcu-qa-v1-1-963ec83e6d0b@debian.org
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ sashal: applied the rescheduling change in __dentry_kill() instead of dentry_kill() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 7d75ff9d507d2..ac8f2b6c95576 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -598,7 +598,7 @@ static void __dentry_kill(struct dentry *dentry)
 	spin_unlock(&dentry->d_lock);
 	if (likely(can_free))
 		dentry_free(dentry);
-	cond_resched();
+	cond_resched_tasks_rcu_qs();
 }
 
 static struct dentry *__lock_parent(struct dentry *dentry)
-- 
2.53.0

