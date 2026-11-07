Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049224;
	b=h6yX4uMN42AJma/MK+K1DQYck2GK8RMwt6mJrEJ+RxnLxy9Qe8QWWJ+mWQCp5QODajPG
	 xFRhUzGVBG3qBoytBKRPF+rKyblSGg1RFujL10ab2UMeWnNdL/r5UiDmLLMPejs2n0dFO
	 RJaSCEXv4cI1NhIhGAM49+iP/HhCjJdXcswdIpzfwqXQ4WOt0uPknHpyKXWCynHkG581K
	 bnehxZFCynvnbqHs3XNPDJMQDRWZHRkH+9TIFCGvtBLlHvD9oGPuOj/2Rxk6WcMI1pHWs
	 mOyEDDgyzGqQwA3g9ILWB3iM9CJsM3Cb91GL+ghSyafT43YuDv66Zf4vrMn0BT1oC8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049224;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1dux/bRdNMtL4rxhL3LJmECUgaG3vS4GHLThxcseBmA=;
	b=v2P69aGq4+iKL9Qgq7mJOmr2TP1fbUeij8rfhkTg7jzkBHJn3Rg7tgJ3yUvuHgXqss/0
	 37uLOQh/pJ9zMEh1JA1oDKRH1Xe3awHt+HtdZKxf7Iw9VvyGIbmME7m5NmibnuYT5ocPY
	 EOTnbdTeMxqz5z8aAxog05+GjwuBiYjRS3kjJ3DJgDHSJSkEwsHUejKY+Wrrsd30HbA/d
	 VcqQnuOGE4xYZgr243Hs0v/y+LRdzMKJyxw4ty8YaYdvIiBjBv6iArJhv8iSUtGidoDzx
	 3Svk7QssR460K/cZVN9BfBTjur+fKy5p7e4IxB1HU/pX9nHjvdVQvLwo6TsbphJFqPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lugGWp4s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816BC606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lugGWp4s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB8A1F0089F;
	Sat,  7 Nov 2026 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049224;
	bh=1dux/bRdNMtL4rxhL3LJmECUgaG3vS4GHLThxcseBmA=;
	h=From:To:Cc:Subject:Date;
	b=lugGWp4sBbRF19i7AYPbzh+njV/RpRicmNG7mupfKsRLe5uvqEI5Kjb3mw/u0iklg
	 XQmEK/SRmLu7SCFxLI8J4lV8aXt/bWDmTr1xiXG8EVHj6Fqi1g9AN2wK7wUUVHmSfp
	 DJoSBN4JUHzTImN85D9goktn1juQiAxA4kLnhndM5siH6cTFUzLS0LQwjJJbkhUw6M
	 lFYtErqdKECido5Beh+znp092yHJkBXOX9Hi8mV5wsVsWad8fg0v6Ek0feplHOR5mR
	 ssDXEHE/3Av6p8bXhezJkIbiFfpjzdXQl+JHA13EE6VcwT8rANC3tyYlFeda7L9kVS
	 I8GXY6dJj6zRQ==
From: Sasha Levin <sashal@kernel.org>
To: leitao@debian.org,
	paulmck@kernel.org,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dcache: report a Tasks-RCU quiescent state in dentry_kill()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:00:22 -0500
Message-ID: <20261107060022-failed-5.15-a647a53bc89a@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a647a53bc89a046bee4a12a0a5627f2dfaaef807
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060022-failed-5.15-a647a53bc89a@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




