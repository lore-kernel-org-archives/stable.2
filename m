Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212CA4C33CA;
	Fri, 18 Sep 2026 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729332; cv=none; b=R5rXfFojAJ9szvPjYdzz2Q0L5zGqbog5nstV3IMY+juoPQgey9qDtzr536IY/Qp9vhGuQ0lZR1uDMsABy3N4szJ5abf2MlnI4hvlMo+ene7It+v+G5dfhoUiGrYDqCJ/06iSL/UKs+TOz8kuEGVIW69H2f/OGBYeLNQFhlcRMAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729332; c=relaxed/simple;
	bh=cQA/QRPrFSugC+1Fgs8XBJLJypCe10VFvkjnvjfomzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=i7orfLHJavM3UL1jpp78iaCqpE/uRVT14L5TMQ8GatQcC0zD4AqRDu8yGhlSYyQYuvaYl5FWn4gZ4Lut3Pgsuxhuwajem3laNl3pZNJolxxzV87c4STTa30ieNYNRQgmDoraZj2iyo1QeiZloLCymMs7UVY9B686EmEZKOo+d1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=LRPpEHDh; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="LRPpEHDh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=yNCJGYtUbTT8E3qKjtNife4BAAwO0+mUmglbRc+3YPM=; b=LRPpEHDh48DfdaAvI+KK89ZbF4
	MbfjxnmjtGFDd7OzGViyzrU+4Tab0ptTejY/2ttFQMPRfojq7sUPe3ux0CJhqkHMxThnFOiRurkBw
	i5U6NV0++PVkatb2wBE/0eS9TGir2EE7oIkJcMGQ72LwjC3onXo6efFMCBmPhHKfkHLwH0aqI49lN
	LDOpuaY0SMSeGTsnhKEGQ8/ILpj6Ksej9NuHM1Rrsn5v9tkH3ETwsFyQCS/CZHYnt1lYTf7K4GjzH
	ML8N5Rnyy6TDzmmTfnXIX0EU5Ttr2g6tuCssHrfxdrkXVXVFn2+BD4cLsglRNU2LBp2H5YwEOxHAC
	eMGxJ4lQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x7WM2-006fie-1o;
	Fri, 18 Sep 2026 11:02:06 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 18 Sep 2026 04:01:57 -0700
Subject: [PATCH] dcache: report a Tasks-RCU quiescent state in
 dentry_kill()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-dcache-task-rcu-qa-v1-1-963ec83e6d0b@debian.org>
X-B4-Tracking: v=1; b=H4sIACQarWoC/yXMTQqDQAxA4atI1gac0Yr2KuJiJsaaFvyZqAji3
 Z22y2/x3gnKQVjhmZwQeBeVaYwwaQI0uPHFKF002MyWWW0q7MjRwLg6/WCgDReHvvDkTd6bhy0
 ghnPgXo7ftGn/1s2/mdbvCa7rBgSNhFB2AAAA
X-Change-ID: 20260918-dcache-task-rcu-qa-b4bcb13f1524
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, paulmck@kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1633; i=leitao@debian.org;
 h=from:subject:message-id; bh=cQA/QRPrFSugC+1Fgs8XBJLJypCe10VFvkjnvjfomzg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqrRorl6kxNiItGfl8qa1rWpBUJhQYFlwJGJXHb
 ah8uCsVBmeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaq0aKwAKCRA1o5Of/Hh3
 bY+JD/9zwrzBXMrELtGSV9TDQlLn3dQ/0ICtzDCqMbj0aIV8/7wa7nE30OIuePNJcPcPvtSOcgb
 cZin7GyT+yhgyFPBNKzInovAfoVnejS6yH4k3rFcsinnHi39sYv9FvAlususw1rEggsYzYNdVxp
 FH61wOwmCSX3JjECkh0vsPNEYXtRvtIvYPmzD9MpFEHadzG7BS8VEa7obiWaVSZ+amQnnya2ioZ
 f01ZtBeHng2WnsY3jowVYVYRTFgC8vycAjvguXPa2q3JeSffqPhj86WXxzgfQ9FAyfgirltgYEY
 neHIQAoihA0NhMmm1SlurOioJc/h9XnLQjjPE0nTMdAMecVA0gTkFiLQLOUOSnmzM30koXA58si
 MGcYZkhd8+KMEAtETe7+tzJzOR8PGsxSYHqTg2t0a13xMKEKJt3J9LTO3vyw3ft18I+WfRIKNwX
 qvDD8g2Gnf0WzPZWDqV1AY94qGnUQGhXmd+rlNDr41xqU6+kJokMwP+6ZVv7kqAa5NRKO7CjUrF
 8V0m5bS1IAoOn/VHZjrj5VjvQWGEhBKv+1fNzaAoUuKrzMkXQbFnYw3DeR1gP2ik8zlQ0IhFY7e
 qjo5xpPbKybXyiZKEEvdkdE9Y2s2Z+2z/xIHfKRBqvXDr2cN2IVZ3fx5nnm5JjARbMLckZ/9D0t
 hUzSzMh39QN3JhQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

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
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1b1a81f10da67..b89c8480b655b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -830,7 +830,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 	if (dentry->d_op && dentry->d_op->d_release)
 		dentry->d_op->d_release(dentry);
 
-	cond_resched();
+	cond_resched_tasks_rcu_qs();
 	/* now that it's negative, ->d_parent is stable */
 	if (!IS_ROOT(dentry)) {
 		parent = dentry->d_parent;

---
base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
change-id: 20260918-dcache-task-rcu-qa-b4bcb13f1524

Best regards,
--  
Breno Leitao <leitao@debian.org>

