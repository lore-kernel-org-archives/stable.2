Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875B93BB11B;
	Sun,  9 Aug 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786267208; cv=none; b=ABjWtm+cFh4oRcdnuQYe4D1J0OfTNR/bVw5OoNWhe2y1+HjLIZe/Ggs5XSi/o3mF/Ywnen+lVVOYnIa8NVkAlrs6LOv+JGP3B5/dOZq4DV06SH5+H850xHffHI8+UZBj/VSp9l/7gJ+PhNDbPSUMG+7nDOMJX/WcCMzXSc/hwMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786267208; c=relaxed/simple;
	bh=/No38Ra+3pG/453CTZE6d/h8bvZ2aQUcbwyRnr9L1Jw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T7r+mDX0Np3RAFjSr18GN2c+J++QoWtNc7Z7kY4MTHsZpdZaLn+qjmugfVu+IGmiVaGqyE6/QAbvgqKuddmniLzvTha3YL6isvKmKUSh1pkMu2v0UE/hbN/5j1zbzjszek4pMnWj9zq4w21P2EZktq2DLxj0j17Y4gCI68So1U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=kBret1gs; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="kBret1gs"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 494c179ed;
	Sun, 9 Aug 2026 17:19:55 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH net] mptcp: upgrade network refcount before socket lock
Date: Sun,  9 Aug 2026 17:19:49 +0800
Message-Id: <20260809091949.3618191-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fe5d2584c03a1kunm46e7b7ba7c1df
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSx4eVk5PSBhMGEkdGE9LSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=kBret1gsjsemOBWJ4jcyX3xdnvJLiSf4Q21YdTfV1r5y0C0mI8FafW3R+Zdl2QnKvseYtG/4njoicMHNsv7h9icwhVxovjca+rXAqzFeJBxZmNcdHaQhZf9xu4jPmiSscH/+Gp7PxLu1VDY2hNqyRLv6A/xV/REQl8YG2qFDTzU=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=99FXYjG0C4YFsFDm5Y4zJl930m5GBw7Mg6F1ozywC2w=;
	h=date:mime-version:subject:message-id:from;

sk_net_refcnt_upgrade() calls get_net_track() with GFP_KERNEL and can enter
direct reclaim. Calling it while holding the newly created subflow socket
lock can create a reclaim-to-socket-lock dependency cycle.

Upgrade the network reference before taking the socket lock. The socket is
newly created and has not been exposed to other code at this point, so the
fields changed by sk_net_refcnt_upgrade() are not accessed concurrently.
The error path still releases the socket normally after the upgrade.

The PatchProof static-analysis tool detected a GFP_KERNEL allocation while
the socket lock is held. Manual source review of v7.1.5 and current
mainline confirmed the lock and allocation ordering.

A source-level check found `sk_net_refcnt_upgrade()` after
`lock_sock_nested()` in the original function and before it after this
change. A POSIX-thread lock-order model made the reclaim lock unavailable
while the socket lock was held, observed `EBUSY` for the reclaim lock, and
then completed with the reclaim-first order. The model checks the ordering
invariant only; it does not execute the kernel MPTCP path. No live lockdep
MPTCP test or reclaim fault injection was run.

Fixes: 1d2f3d3c6268 ("mptcp: adjust to use netns refcount tracker")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 net/mptcp/subflow.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e1f20ff8fdb4..a9f951cc6a0e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1786,6 +1786,12 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	if (err)
 		return err;
 
+	/* kernel sockets do not by default acquire net ref, but TCP timer
+	 * needs it.
+	 * Update ns_tracker to current stack trace and refcounted tracker.
+	 */
+	sk_net_refcnt_upgrade(sf->sk);
+
 	lock_sock_nested(sf->sk, SINGLE_DEPTH_NESTING);
 
 	err = security_mptcp_add_subflow(sk, sf->sk);
@@ -1795,11 +1801,6 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	/* the newly created socket has to be in the same cgroup as its parent */
 	mptcp_attach_cgroup(sk, sf->sk);
 
-	/* kernel sockets do not by default acquire net ref, but TCP timer
-	 * needs it.
-	 * Update ns_tracker to current stack trace and refcounted tracker.
-	 */
-	sk_net_refcnt_upgrade(sf->sk);
 	err = tcp_set_ulp(sf->sk, "mptcp");
 	if (err)
 		goto err_free;
-- 
2.34.1
