Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319108;
	b=2+gRO/pfO/2a+6p80aIXOyDLWLsCn7uANCxt6stVD2adHLI5afNekITsU2de+R/aDHeX
	 6CksH5TYL/1FBdmIm1hSX3IuxIOWSciWp8dWF8RMaSGlLuwZPreAQn9LekOqrei2J8xCY
	 uKHl4S4PnR9Zhlf61sc8Q7A8hFvhcNWVlRP1mJucwqjbao7MNvhWZEb08+K3kZtJCExc9
	 q4uArs6tBOc6fgAXkwmtgZYQBBGz+aFuPcQmQHWUQKRBiHKjtWo3oOeRUT5mKJzOGJWP4
	 oMdFyB7NXosNwrCrlPckURvHA3w7Wx7DR1YkfYyDOsdxiX4rZEIQcQDFdCJvSoJkdCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319108;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GvsKJlHJuD3dx0o8C+58u2Lu9LmJpXRsCD+5upNkmAI=;
	b=f2IHiiqM7QwdqHDrXvP9RA0sAK1EjT7HE4MAK+9FsXMz5+9qmkQA+51RBtMUR7VU16iG
	 D5y3774MFIej2muoKVZEvuPLPcI/pQHl7xGM13tSEKBO9wyuGpj+i4b7udqM9yMYiH77X
	 OGVfHil4c+WiJowUrj78VAOz9lzwWhVRV0qNAq7w4QIyY6hZ6YEmOjDtNQZV66hd6ix4V
	 LqNBwKW46lt7evOaEM7oiy5bqjnVi6OIIqlRvc4SE5/i9NZC3ngTyxs/k4t7+7eI/kmok
	 H281RrX8sgUFdBKkCXTYpkjsY+adRKWma+GSdOjtyJf5si9OuCAsubXTfg61Bt2LOwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ifbp1KYD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C803606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ifbp1KYD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A63B1F008A1;
	Tue, 10 Nov 2026 13:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319108;
	bh=GvsKJlHJuD3dx0o8C+58u2Lu9LmJpXRsCD+5upNkmAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ifbp1KYDSvg20YAKMpIQwbcWnygrcmSvaCTK5MBAWpH4D3qvnAoaaJ0iRZIlSYKts
	 Txbj0KuJ2uo6r4yiPekNPkc0C3FpAFi4XTY0VA/GXcAu9mzGNXT3wjI0QO15DVDqxa
	 ANAqq/avR2R1GtoiRKtBfwtLEe967z7Ue+Y7eAkrpGZFaxvGGGqIgSiPHqRd3+4b7m
	 gFOUuXvrQdFgbfletjPArR9RxyU0jBhmdpsyGLpQfl6OP6UqpozuKIiUUvpceKtNXh
	 F89nGduFciSKVGOfF2ZP6TxO/OdVRQgk4tMZk20k+A21VxcoRntgTAaeJcCGeMtNJp
	 MBnM5j6Vikkqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] dcache: report a Tasks-RCU quiescent state in dentry_kill()
Date: Tue, 10 Nov 2026 08:58:26 -0500
Message-ID: <20261110135809.1812783-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061710-failed-5.10-a647a53bc89a@kernel.org>
References: <20261107061710-failed-5.10-a647a53bc89a@kernel.org>
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
[ sashal: applied the cond_resched() replacement in __dentry_kill() instead of dentry_kill() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index d17c98508a088..34e8a97e0323e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -595,7 +595,7 @@ static void __dentry_kill(struct dentry *dentry)
 	spin_unlock(&dentry->d_lock);
 	if (likely(can_free))
 		dentry_free(dentry);
-	cond_resched();
+	cond_resched_tasks_rcu_qs();
 }
 
 static struct dentry *__lock_parent(struct dentry *dentry)
-- 
2.53.0

