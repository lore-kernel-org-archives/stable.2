Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363926;
	b=NbS4Vdzvnwzu1QOBruip3dSdu1UAoSna8ye2MRH42RK3IIvKca03hW/1GVm2u2tx54jk
	 hZqQA763eh3yBcqFqNiuxdlVIfCbm53d/PPiODxHc/cVgT9IebG2B3e6pxZBX9ueg7krQ
	 w2IoU34ZuRPDhDKs4jCFXnrO8HZB71jYrY0iqy09+L5+SBz3tygZmBsSx0GEjrPKgxCXP
	 k/uVetb8txmV9QzK1A8XkqlxkeJQywoKL74AJJLjb2yIpvaGKk2GKh2c0OCFYnzH5KLfH
	 hvr9kTP8kPyiui4NVG3IEzJqdkDO4QxBrBn8xJ2c8AhonPjdZ6BMKsjbmjN5qNG7HyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363926;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=c9HTRoee33M/fUdkvJQyZvRmvA//Hh8Tp7LdfKRTrcI=;
	b=vyzRn3rXXEyRd81osesgmXVqhIsVQGQ4VIh65sJ1M/2YFqWgzXwQyBRR0Xh5SAwdgSy6
	 /mQ9tfdXd7PWVGGP8JYPB7BpoOh7nJc+UOYK8+5gCj1eS87ltGTaz2As5wKuBoYmQKNYV
	 BBpUtxqukLUuMIIo4y/+snrZ9PUzkVXxOHsPPF8uQJYwHv1b5vh7T2jTOapKliEzAWff2
	 pK8ha9wAQrVE31nwPQgpa30SJNXNqqf1xSMkcmChoFtjnfjHDSU2XEn/Ko4qGOKc6b4zR
	 /P3SkOgcFv38R+a9KOrirB3cMdCDHNUKcjXeKvnUsx3HOidIiKQ5B9CD3UOrfYT0g3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=St7c30TK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EDA606A31C;
	Fri, 30 Oct 2026 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=St7c30TK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25B31F00A02;
	Fri, 30 Oct 2026 12:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793363925;
	bh=c9HTRoee33M/fUdkvJQyZvRmvA//Hh8Tp7LdfKRTrcI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=St7c30TKN5YXJXI+oNZGmkIDHp20JjLOw3mRALm0E+TDVsDemi7e0B40p34kMT7tu
	 fOO26y5/VOsEieg+GiZlPQ3xaRuJcC3kTwcak7CAPBp2cnUKLesZtoIQGkduffqwFe
	 EyA4PJPF1C1FV7QIY5SAuGwQBfbHYk7dv24uaJiAshlZ57emR8zUVdaTlGg7ekcjts
	 eSBw2S4YJfY3l1Z3mXIe0ixT01XjzD71hh6AYw92ab41BY7iX/BNfOOHSw6Y25qSjm
	 /oPWv3Ih5hXe6KOB5aXC6j0wkUkKPtJY3pHyhYn5Ttlz7HSNWZxw8Fprch0KqoOwuk
	 AneYOgHDqyWCQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Oct 2026 13:38:22 +0100
Subject: [PATCH 1/3] dcache: let d_invalidate() wait for a d_set_mounted()
 in flight
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-work-dcache-ai-v1-1-cd6b86e0ccc7@kernel.org>
References: <20261030-work-dcache-ai-v1-0-cd6b86e0ccc7@kernel.org>
In-Reply-To: <20261030-work-dcache-ai-v1-0-cd6b86e0ccc7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Karl Mehltretter <kmehltretter@gmail.com>, 
 Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6477; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LuGYCrTaJzu0wDHZGHIdG5EvFs/8qLIEYv+jHeGJ7iw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ96T+3scxoM7dlHduqnr7DdRMWzJnosL6zVoTDf/K7M
 1quCe97O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy9TgjwwKmvVEzvjTsETn4
 afa808xXupY8lJUUmJrLO2nrvhaxOzcYGTat2tHwP4WNuaP7/IF991tyr1d1uP84KZyw/caplCe
 HLvIBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

d_invalidate() and d_set_mounted() are supposed to exclude each other.
Either the mount fails with -ENOENT because an ancestor of the
mountpoint was unhashed or d_invalidate() finds the mountpoint and
detaches the mount. d_invalidate() unhashes the dentry first and then
searches the subtree with d_walk() which starts out lockless and only
looks at the seqcount of rename_lock.

Since d_set_mounted() switched to read_seqlock_excl() nothing makes that
walk wait or retry:

  CPU0: mount on A/M                 CPU1: d_invalidate(A)
  d_set_mounted(M)
    read_seqlock_excl(&rename_lock)
    A is hashed, go on
                                     __d_drop(A)
                                     shrink_dcache_parent(A)
                                     d_walk(A, find_submount)
                                       read_seqbegin(&rename_lock)
                                       M is not a mountpoint
                                       need_seqretry() == false
                                     return
    M->d_flags |= DCACHE_MOUNTED
    return 0
  mount gets attached to M

The mount ends up below an unhashed dentry. It can't be reached anymore
and pins the subtree until its parent mount or the mount namespace goes
away. The window grows with the depth of the mountpoint. With a FUSE
directory 3000 levels deep a bind mount racing with
FUSE_NOTIFY_INVAL_ENTRY for the parent of the mountpoint survived in 151
of 200 attempts.

Before 5e317d23f6c6 the seqcount bump made the walk wait while
d_set_mounted() ran and retry under the lock when one had run in the
meantime. That was the right thing to wait for on the wrong counter:
every rename_lock reader paid for it, d_lookup(), d_path(), the ".."
step of the RCU walk.

So give d_set_mounted() a seqlock of its own. It is the only writer and
d_invalidate() is the only reader. After unhashing the dentry
d_invalidate() runs an empty read_seqbegin()/read_seqretry() section on
it. That spins while the count is odd, i.e. while a d_set_mounted() is
between its ancestor check and its flag, and goes round once more if
one started in the meantime. Nobody else retries anything. The ordering
comes from the locks both already take:

- If that d_set_mounted() saw the dentry hashed its check ran under the
  dentry's d_lock before __d_drop() took it. So the count is odd by the
  time d_invalidate() reads it and d_invalidate() waits.

- Once the count is even again the flag has been set under the
  mountpoint's d_lock and the walk takes that lock to look at it.

A d_set_mounted() that starts after the unhash fails its ancestor check
and never touches the flag. So the only flag the walk can pick up
belongs to the one mount that saw the dentry hashed and is still in
flight, and there is at most one of those because namespace_sem
serializes mounts. Either it gets attached and detach_mounts() takes it
off after waiting for namespace_sem or it fails later on and drops the
flag again. In that case the walk goes round once more and finds
nothing. The same goes for the mountpoint that attach_recursive_mnt()
preallocates on the root of the tree it attaches. IOW, d_invalidate()
does at most one extra round, which the removed-name trap (cf. [1])
relies on.

Note that on PREEMPT_RT read_seqbegin() takes the lock instead of
spinning on a preempted d_set_mounted().

The cost is a seqlock around the ancestor walk for every new mountpoint
and two loads of a cacheline that only d_set_mounted() writes for every
d_invalidate() of a positive dentry. Walking the ancestors a second time
after setting the flag would close the race as well but doubles the
cost of d_set_mounted() with the depth of the mountpoint: about 1us at
64 levels and 75us at 4096 levels.

[1]: https://patch.msgid.link/20261028-work-mount-trap-b4-v1-0-f20d9d0730d6@kernel.org

Fixes: 5e317d23f6c6 ("d_set_mounted(): we don't need to bump seqcount component of rename_lock")
Reported-by: Josef Bacik <josef@toxicpanda.com>
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/dcache.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index efd9332c8407..72b8e0adab0d 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1590,21 +1590,25 @@ int path_has_submounts(const struct path *parent)
 }
 EXPORT_SYMBOL(path_has_submounts);
 
+/* odd while d_set_mounted() runs, d_invalidate() waits on it */
+static __cacheline_aligned_in_smp DEFINE_SEQLOCK(d_set_mounted_lock);
+
 /*
  * Called by mount code to set a mountpoint and check if the mountpoint is
  * reachable (e.g. NFS can unhash a directory dentry and then the complete
  * subtree can become unreachable).
  *
  * Only one of d_invalidate() and d_set_mounted() must succeed.  For
- * this reason take rename_lock and d_lock on dentry and ancestors.
- * Likewise for dont_mount() which marks a dentry that is being removed
- * under d_lock.
+ * this reason take rename_lock, d_set_mounted_lock and d_lock on dentry
+ * and ancestors.  Likewise for dont_mount() which marks a dentry that
+ * is being removed under d_lock.
  */
 int d_set_mounted(struct dentry *dentry)
 {
 	struct dentry *p;
 	int ret = -ENOENT;
 	read_seqlock_excl(&rename_lock);
+	write_seqlock(&d_set_mounted_lock);
 	for (p = dentry->d_parent; !IS_ROOT(p); p = p->d_parent) {
 		/* Need exclusion wrt. d_invalidate() */
 		spin_lock(&p->d_lock);
@@ -1622,8 +1626,9 @@ int d_set_mounted(struct dentry *dentry)
 			ret = 0;
 		}
 	}
- 	spin_unlock(&dentry->d_lock);
+	spin_unlock(&dentry->d_lock);
 out:
+	write_sequnlock(&d_set_mounted_lock);
 	read_sequnlock_excl(&rename_lock);
 	return ret;
 }
@@ -1876,6 +1881,7 @@ static enum d_walk_ret find_submount(void *_data, struct dentry *dentry)
 void d_invalidate(struct dentry *dentry)
 {
 	bool had_submounts = false;
+	unsigned seq;
 	spin_lock(&dentry->d_lock);
 	if (d_unhashed(dentry)) {
 		spin_unlock(&dentry->d_lock);
@@ -1888,6 +1894,11 @@ void d_invalidate(struct dentry *dentry)
 	if (!dentry->d_inode)
 		return;
 
+	/* wait for a d_set_mounted() that saw us hashed to set its flag */
+	do {
+		seq = read_seqbegin(&d_set_mounted_lock);
+	} while (read_seqretry(&d_set_mounted_lock, seq));
+
 	shrink_dcache_parent(dentry);
 	for (;;) {
 		struct dentry *victim = NULL;

-- 
2.53.0

