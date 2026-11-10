Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316771;
	b=lkpi9pyJz1NzfFnfETPUH+pn+7Zg0a6pJAH6fCgUO3QLspximCND32rYdQWnCb02duA0
	 ElT3abpGsDQiuUMkOt6wsmVu17oKA1RsLIHqxHE8VOTWq+QG1ot2d/5jZQVlMQkMeDCxF
	 gUx+K5d39sZwCza65gY0Da3F5G+/2siridUAXHaHQsBFdmACpTQFr0o+u5q/qv1lgmwEr
	 ck2ktxfthAcGQKiwgyLLG4ZU1JqK3uT+dq67du0H7E71qRJ603aSU5P9Y6ZqHm8BUteH3
	 YE2pALUa2ezmFwO/WCYWtNprDJ8I7gUo9tS5JEjtZ9TMC8Lt0GqMLb/2ZZTxUOetlsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316771;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1tJZJF/ZsCPtMo8he9iLF18ZSbR5KYRunu33upum5ac=;
	b=o5Acpii1VTs4dqBD44YXg/mG3A8cHYwRp+Pwnzu9Gv0Xqqm07mRg+IouORXmFvM4D1tB
	 5eDE7JVp7/7B3Mdv1J4JVCowOtojwhTB55y4EyYAQ1Cf/XWIFXJCG9anezN3JOp/9fToE
	 B/o4YgIpWBNCReNZivUAPFbmSY+DkoLH5UsMzTujAoEmOwqtggn/4H/VpAKpME720b1IQ
	 fTbTtM7Z4HEGWVX3YdkuKSeWTPgzedMhTJEIutyf2woPIHvfDvg2JMIu2ovts1Z8oZW25
	 yAIMbCaDorZxBxaBvsdihM5GFwkpb4OUHCT2F2rt/S21OCJGD7bXypPB4mMRzVFj35g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z6BSUIZl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456A0606A7CF
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z6BSUIZl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784121F0089F;
	Tue, 10 Nov 2026 13:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316771;
	bh=1tJZJF/ZsCPtMo8he9iLF18ZSbR5KYRunu33upum5ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z6BSUIZle7xmCpSUtQPsD5JR+9ZLHJYyTG3/+c8LnJjLfhyY8/mPVQvyFgQm38SPF
	 8afbS5kqv9npiHShiuOqxspYJe4emHC/JNcrpRHEv09Gbv7FkaVIF6pi3iDm+4BSiC
	 m/xV9obLkAI3kEsNP+26GQ7M5Cif7uD7A4ff4imUG6jWmivvDmY4+zh8P7TvykYIuI
	 YjA/lFfk6mpfs4qe8CCcp03sBsnvxJdKC1bszHYgpSHhfj6CgsJ7ON0S6mTHX1WNOo
	 B58bxypaSMhMSrM+lTKLMq1qHZpYWwZ7RrEJXCNU3zsnTNHSEdkVja8gmwJwxvtFAK
	 M7o9z4YmzFWVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] dcache: report a Tasks-RCU quiescent state in dentry_kill()
Date: Tue, 10 Nov 2026 08:19:28 -0500
Message-ID: <20261110131912.1715750-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054301-failed-6.1-a647a53bc89a@kernel.org>
References: <20261107054301-failed-6.1-a647a53bc89a@kernel.org>
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
[ sashal: applied the change in __dentry_kill() instead of dentry_kill() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 205552e31b200..a03646aff093d 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -623,7 +623,7 @@ static void __dentry_kill(struct dentry *dentry)
 	spin_unlock(&dentry->d_lock);
 	if (likely(can_free))
 		dentry_free(dentry);
-	cond_resched();
+	cond_resched_tasks_rcu_qs();
 }
 
 static struct dentry *__lock_parent(struct dentry *dentry)
-- 
2.53.0

