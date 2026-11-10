Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316570;
	b=4RiTLeDgySQSroNknHz5LChpcKxp5ZZLASqx1L0O/Zo2D9IwKah6ETsAyt8ldds3xrQQ
	 RlR8DBg7kdKvdrURoV90xDvCAWDz+VWF8MbcjQzOPgdHYLtP2A4h6op/2bYqPDmBOH5mm
	 LwzN3/xyzzPSTrFkHi5GxOOmhXX0LyUX/Tb05lVHPj6reY3puYNXrQH2dW9ZxOYhjmQsS
	 3nS11SWfd7F4smWfUp1DhTBoC7j5ZI1qo4sh2HBiNP17+ncEqtmvHweKHrk/SQAFjAWgv
	 lrCZLPE47KXXrbXOdZilYr2az2vLmlM9jrM61Te61Kq89caB4AaD7pNAQyaHQPQ2sPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316570;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Y4wnUq90PEd/DpoX3brEoXSwFXGQlvHuggwHgIe95sI=;
	b=kp+AIpjfNzRz+MEVlNabQvHM38PCZy8ENAHZMz59ELBurhwWdh74gfnTLxdOo83f8icl
	 IUPkrKqn6qi7vOBIT9yQ8cyNk2ST3X8om/XUKh2mQeGETBdHKQumXNedgO58RltCieSDL
	 G55sW2hvqyTL6iMZLRMYNOcRg6HgzRP3xBEqzuTdMQ7JNjwWEuUzDNUmG5SjIzqS58ZB/
	 VGw2VY561VEYS1Z7Lyu4XR7hhF7B9Riyusq781mG3HxLxVSDczgNnBP+/xEl70mlN6f4x
	 xdd7QtJnYd1yoh3zavJD2bUDtypgHd4ZQGM46s4sAOk9yPRYkcaHPAdrXrC6DrRWdtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmz8j8IL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E2606BFE2
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmz8j8IL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482051F0089F;
	Tue, 10 Nov 2026 13:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316570;
	bh=Y4wnUq90PEd/DpoX3brEoXSwFXGQlvHuggwHgIe95sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nmz8j8ILfosGlpN1AkEm4ConW0ZzhNUlJCwtKQhq0ijjN93Wr87a02u8v0p813KtN
	 8QuOlW/B+bHGZxxOrYBMXFPhXKHY+t1AD/PL/A5Y/PcyWWX63oMj8nkisRtUcjXgKb
	 sBtV8WmqjxvFp+bZRZZCI6yJ7CcWFmOPMBoWwskldhhqYyXh1rFKPQ5vhCo3RsFIhj
	 rCexOmZ65KePNYwjslGScHhO08Va3lcbO56TyQ+19VkJZ1w9evIy2JUQXPMZgX24br
	 ibmYdMQSoEZDfAemPzfMh4ZwAMRuS88jmqyjoBTbdohXAv3qc3m6L88ZY3NsK5X3mR
	 ocgALGjKVy8Jg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] dcache: report a Tasks-RCU quiescent state in dentry_kill()
Date: Tue, 10 Nov 2026 08:16:08 -0500
Message-ID: <20261110131530.1663170-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053020-failed-6.6-a647a53bc89a@kernel.org>
References: <20261107053020-failed-6.6-a647a53bc89a@kernel.org>
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
[ sashal: applied the reschedule helper replacement at the existing end of __dentry_kill() instead of the restructured dentry_kill() location ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index e1f4a9e61e589..023a9ab9c7574 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -625,7 +625,7 @@ static void __dentry_kill(struct dentry *dentry)
 	spin_unlock(&dentry->d_lock);
 	if (likely(can_free))
 		dentry_free(dentry);
-	cond_resched();
+	cond_resched_tasks_rcu_qs();
 }
 
 static struct dentry *__lock_parent(struct dentry *dentry)
-- 
2.53.0

