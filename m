Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048183;
	b=XV0ZsY/ZQImMfl6CHLHvkxJJTZNdvoUEedjinvjlW42xvB3PTsLVrvGy3zmt32/APKoK
	 YQgXAHZuoo7/B9KZI5n0WArFTmkFny43pJdCQ1ApJ8UffohkxPxRNOZg4qsQb2L0cvM04
	 FFreoYptRVALKlMFyDpuCFb7NocXC4XF+dSGFF4qsHYxl9aFsDwzR+MMbQeiBb2GJEFO6
	 DaFdAPF/MNqcZg3jWYwkka/hGbqsozaLleOwrL5Q8ZsJd5GlzGg1p3LO2UZFvRf9sWiB7
	 f/BFeXkad4v7KpTuJmJufaH7FCQtZnF8Lzqr9RHDcJVeI1OmZsgJr4tUVwWESDb9nmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048183;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lGk4IVSYr39DxsiFeJ2ra0nOFgzf3fzodIUYFcVUFL0=;
	b=Dr+4S+QUgr0o8hYGIIIoolYbDDjHK3G8iHDac2dlYNykw40p08LEgNexeqt/tPQhpdzB
	 rolGHFJ11+vpKln7nnuLdZ/VDlmfh1AfB1pXR2KEa/WXmiwTVzFGQWnZYrm9+2CxdeQt0
	 XKs2RAGtCxCk9B0kLZqEr3nOneNpafIwzVPACVTVe4YTAkHz102WL3vw3qB7VtM2w9wdh
	 0hO3QkDKBe7tYHyUFiFymeh4/ZcT6GNi+OQpz1yMiqTBXGcHzX2UO7yIOitnkpc1THsxb
	 zJbTmYyr5Jyn61uYxDt4AXRoXKpAyskwf/1YsJ/jj+X6w+zkcPiZ8AQ2w3dIaDc2axQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kowd8WyP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52044606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kowd8WyP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B4C1F0089F;
	Sat,  7 Nov 2026 10:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048183;
	bh=lGk4IVSYr39DxsiFeJ2ra0nOFgzf3fzodIUYFcVUFL0=;
	h=From:To:Cc:Subject:Date;
	b=Kowd8WyPhQ2giu85Z7fUVKjSNbF4vAaJ2DUqIvW9CQ9nwvlw/egg/m9nR461eRf/C
	 8YIi6rWbMB7blue3MNGjFhF6x7jUZ+6CBuTCez5H1t9iecQZE5s/Mlby5Dd6Dqcwe3
	 stINx+wOJZNE5mVsbFKVy4pQ0pmTEEdcddLAHOAMWJfqcuiFpP4U38bBetK49MjYeD
	 pxJnnmfWSiIaBjNDIWeV6qGfjx5UQNG4n0VDJj9kfwOlV8ES0+YponOYSjxpct3VvB
	 FxAK7S/nhUFrqJSsPypJ0fd+ex6ONa+I4JX2mX9JCVsx3HSuxm6+W1FmpEbHmoZ2SO
	 Vag8A6MUk1cFA==
From: Sasha Levin <sashal@kernel.org>
To: leitao@debian.org,
	paulmck@kernel.org,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dcache: report a Tasks-RCU quiescent state in dentry_kill()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:43:01 -0500
Message-ID: <20261107054301-failed-6.1-a647a53bc89a@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a647a53bc89a046bee4a12a0a5627f2dfaaef807
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054301-failed-6.1-a647a53bc89a@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a647a53bc89a046bee4a12a0a5627f2dfaaef807 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Fri, 18 Sep 2026 04:01:57 -0700
Subject: [PATCH] dcache: report a Tasks-RCU quiescent state in dentry_kill()

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
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 8f17db2724b38..e974d42b03e72 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -843,7 +843,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 	if (dentry->d_op && dentry->d_op->d_release)
 		dentry->d_op->d_release(dentry);
 
-	cond_resched();
+	cond_resched_tasks_rcu_qs();
 	/* now that it's negative, ->d_parent is stable */
 	if (!IS_ROOT(dentry)) {
 		parent = dentry->d_parent;
-- 
2.53.0




