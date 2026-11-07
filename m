Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047422;
	b=dk3ig8HcbXUK2vJ8KTp6mqoz3jZA3e+teYeBiVIf2HLhl5IEGjXxYuSveJsTi3mlGdgb
	 MRrymOfqVR4RLYnvcQgBxL2Z3AutTrbRdORnPQQKtou+HobhvJTJU4BlzW/wtbPPlEuKf
	 S2E7ckI9g0wqpTW9Pj+riae5Wz275DrA1LTel6PXd7KL1a7rKh1xt33oM1EkRQ5zVbNyx
	 udq2YwjYAcXXwFKPJcO4bEILQdrgkrwJB8uFXsPj9aZqZZTMGAhSLudU3fIKE//m4yZsD
	 FQ5N76egUaI654OOAoYMvugQhPOewUnR4Fv0AXbQmaTQjfqRq/Ywwr3+PFUTdN8SeyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047422;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mY5+AyVy0KLDQGUnrkzG2BDMD3LH8vLzV45Zssvek7Y=;
	b=3vXuHzEa0uRzksVu9kiqsjK+I2P82w0Wx9f6ucfsdvv+374VV4l4VzAsgRVEYiQ4tU45
	 n7VinRwvfpu3pCGU29P7HAVaqi0QCxwwU7TBBjzzKNt0Ptc19RKq/oEI8N3IuWjuznm6i
	 fqazQWVUShQLTCmGXP0KSmRERVqkDBLLJ7G0dvO4MQ6sgZE7nvDpnwZMYl1uC28gljHF6
	 M6sKF29nZguBvU0Ox8qsieyOEEurofwzjqL/wxe/ubtlkw0GWXtzAD8mdHwllzIa7PA1Z
	 uylIMyacZnF/HrQDo12ZwMRSZAPBbTk3UISex10n0AwDM6SEtCKUfI8feNuWQ5CCWIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZ5jMGFZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3A4606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZ5jMGFZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58411F0089F;
	Sat,  7 Nov 2026 10:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047422;
	bh=mY5+AyVy0KLDQGUnrkzG2BDMD3LH8vLzV45Zssvek7Y=;
	h=From:To:Cc:Subject:Date;
	b=RZ5jMGFZkUEnZhPQABM5SbFVUwb0bapFDw94pBTP7o32biFIdHLzSSDUvhj3OmGlb
	 w+FX9Owb9og54TYZ9Ghr5fMExUVHYtgpYwx73JYwzMVt4i4Zxr2AWgv2/UEqHKujSh
	 UEyQomQOSS5IXCTQRI199ZW9Iq9vxBtXtMu/0lDP1VFAzuhrQ+yhrs1rE+4sipudFH
	 o967CUIYLdERb+YhruygL5sTpTGw9OFxz7Tlx87GCJiO8Xs+du/y8avh5Lrjv/0rqe
	 vbu/6qOyohfsCZBJ8gJI0Wd+GuUwJe80SS/Rc1mZOehQiFZ36jM+t092wUypM8DcF4
	 t1/U5o39umRUA==
From: Sasha Levin <sashal@kernel.org>
To: leitao@debian.org,
	paulmck@kernel.org,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] dcache: report a Tasks-RCU quiescent state in dentry_kill()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:30:20 -0500
Message-ID: <20261107053020-failed-6.6-a647a53bc89a@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a647a53bc89a046bee4a12a0a5627f2dfaaef807
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053020-failed-6.6-a647a53bc89a@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




