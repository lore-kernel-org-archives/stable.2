Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEA85448B4;
	Wed, 14 Oct 2026 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987707; cv=pass; b=ZZgrBY6xykxoPTIYoGt+Gvms0FOUGIQaotrQ1MkPa3Kr31kuJeqbP5meZgiv/2LXjm6ewDG50ZBnOKy3HB3hidrEROxIYj/06/9JhpfJfi4sDED1qf0A/c4ll7dOfWopZp0QQzllJkIR32mS1xZRm14eg77pkQuDnBug2APY/w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987707; c=relaxed/simple;
	bh=2jURpkQ6RMlfWLazkOtFpPk/yBhNRhc4MHgkQrd0W8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gf5uk/gMMjG88tY0dW6urGd8pU8QTZelUm3A+6QkW0Y3wdPZFXilYrLk0tLGOy0aS4E9ryqM46Cc1ir/6qzWc+f6KWllDiFASaYxmlOuWUUlP1tdJRnlHBhMReiH1S8ldDjDZ8gO2oEXmxafcyn4QNddg6/bsi3I45Rewkj/qTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nO21Y0M2; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=O48OSf2n; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nO21Y0M2";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="O48OSf2n"
ARC-Seal: i=1; a=rsa-sha256; t=1791987696; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=A75v7wsjrif8ZQYCMozmrKSGFdGwvRE8k5vYiRzAGlfySfQJzMVMCvrrhLTIq3TyNY
    pHemABg3k8Y/QegBJQB8W0an59OaJKAv/bMUNb27qRwt84YnlDhtJNb74JfyDjQmquBI
    6oxsTn1cB88K1U6f4C/HBCJnw7PLxiPypfHpwc8GhB66zbGPg2PbuDCqgEPcWb2aBOTx
    uQM0xlZslpXD1xP7zQhDhNRzQXmDs5HQhxswh6QE4icQWvr8COMhZ8NHE7wUeoSD5djW
    HREI8p/8rX1iDSFoX67r7+WkM82kX6JQsZGT1V1qlTL/bGnFl2LNWpE9fcyxvgd9XKup
    2cAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791987696;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WQIWkhAEJUThg9RPUogsiW1tQocn+N+9ezp+2pACGWw=;
    b=BOa9oBg6ScSza+UJsL1j6I8X99DCqf4y6lSppsWo9lmZOTVy6ERx3Cf6UCxZ/ErNo8
    zkDj8Rug/8c6eCG6KIOChahMFfwCjhqve/mK7tpPPeY8bPSkc72dBYUPhmtIZDyuU1X3
    4a59NLHN82Koth4Tw+S1+qqeK9Nrts5jt2gqmLTsplYDkYxjjRHJ6GBgSP/W00y8zcPV
    mSUBhcCfKTwuSGztf3KQ8s7/aPbuiJNWDvxN8mrncU1JOQQ7xPTpjybZjj2GDNC0uElA
    TRRFC++edKt0JjpT004m/VbE20NopgQEEM6Zp+q56Oq+KuVzRhkSl72RyuwRSLmhz4H/
    NuWw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791987696;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WQIWkhAEJUThg9RPUogsiW1tQocn+N+9ezp+2pACGWw=;
    b=nO21Y0M2O/nXdwfZ0HFq3GpsJT4zPwkHDNIKPnmkXYbJtGK4eNNvPdDYrCL1EuzKtw
    sZXwMfvJw7RRuVfs3R8P6DpxJjmrBj4hqaH9OI+HjS9EUnzdZHKDcXkYk++DfWcfxvsv
    H2tFvS+dDmelFgpgodPOC7JoxXvHGhgwDWmxMOmKWOO5J82VX7Z2RKSI7QKttWltImgN
    5OTvCp6yotNOCNDjas1h4huoJQ8HyO/mTZq5TLSs0lw3A14AwNFWWttrLxOIqMrCrNaQ
    RiOd+SrzI0A/oHXJh2QmkhzIUQ/tr0VngEMB+wR/u5fOILJuAX7LGFaZ1M8M7Ce64lR4
    wKaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791987696;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WQIWkhAEJUThg9RPUogsiW1tQocn+N+9ezp+2pACGWw=;
    b=O48OSf2nimJYcxRJ8c1/G/v/nVSMHtqLsoU4OAOvXdd16HfTQ4ni7XpAidh2F0v2uy
    QSBBKF1gl8GWG1ZnmcDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29EELaDZZ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 14 Oct 2026 16:21:36 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Norbert Szetei <norbert@doyensec.com>,
	stable@vger.kernel.org
Subject: [PATCH can-next v2 2/3] can: bcm: fix filter removal race between release and netns change
Date: Wed, 14 Oct 2026 16:21:13 +0200
Message-ID: <20261014142114.280279-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014142114.280279-1-socketcan@hartkopp.net>
References: <20261014142114.280279-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

bcm_release() removes the socket from bcm_notifier_list before it takes
any lock that serializes against the netdev notifier chain, which runs
under RTNL. A socket that leaves the list in this window is skipped by
bcm_notify() and has to remove its CAN filters itself.

This fails when the bound device is moved to another network namespace
in this window: bcm_rx_unreg() reads dev_net(dev) without holding RTNL,
and can_rx_unregister() silently returns when this namespace does not
match dev_net(dev) anymore. The op is freed anyway and the remaining
receiver leads to a use-after-free in bcm_rx_handler().

Take rtnl_lock() before removing the socket from the notifier list, so
that bcm_release() and bcm_notify() can not both skip the removal and
dev_net(dev) is stable while the filters are removed. RTNL is dropped
before synchronize_rcu(). As the notifier chain is always invoked under
RTNL, bcm_busy_notifier can not point to the released socket anymore.
Replace the now dead busy-wait loop with a WARN_ON_ONCE().

RTNL is only needed for the notifier list removal and the rx_ops
unregistration. Remove the procfs entry and the tx_ops before taking
RTNL, as remove_proc_entry() waits for concurrent readers of the
world-readable procfs entry, which could otherwise stall RTNL from a
plain close(). bo->bcm_proc_read is cleared so that a NETDEV_UNREGISTER
in bcm_notify() does not remove the entry a second time.

Fixes: 8e8cda6d737d ("can: initial support for network namespaces")
Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Cc: Norbert Szetei <norbert@doyensec.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 3d637a1e0ac1..f439bdbf37b1 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1924,32 +1924,45 @@ static int bcm_release(struct socket *sock)
 	net = sock_net(sk);
 	bo = bcm_sk(sk);
 
 	/* remove bcm_ops, timer, rx_unregister(), etc. */
 
-	spin_lock(&bcm_notifier_lock);
-	while (bcm_busy_notifier == bo) {
-		spin_unlock(&bcm_notifier_lock);
-		schedule_timeout_uninterruptible(1);
-		spin_lock(&bcm_notifier_lock);
-	}
-	list_del(&bo->notifier);
-	spin_unlock(&bcm_notifier_lock);
-
+	/* Remove the procfs entry and the tx_ops before taking RTNL:
+	 * remove_proc_entry() waits for concurrent readers of the entry and
+	 * must not hold up RTNL for them. Clear bo->bcm_proc_read so that
+	 * bcm_notify() does not remove the entry a second time.
+	 */
 	lock_sock(sk);
 
 #if IS_ENABLED(CONFIG_PROC_FS)
 	/* remove procfs entry */
-	if (net->can.bcmproc_dir && bo->bcm_proc_read)
+	if (net->can.bcmproc_dir && bo->bcm_proc_read) {
 		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
+		bo->bcm_proc_read = NULL;
+	}
 #endif /* CONFIG_PROC_FS */
 
 	list_for_each_entry_safe(op, next, &bo->tx_ops, list) {
 		list_del_rcu(&op->list);
 		bcm_remove_op(op);
 	}
 
+	release_sock(sk);
+
+	rtnl_lock();
+
+	/* The netdev notifier chain runs under RTNL, so bcm_notifier() can't
+	 * be walking bcm_notifier_list and point to this socket. The spinlock
+	 * is still needed as bcm_init() adds sockets without holding RTNL.
+	 */
+	spin_lock(&bcm_notifier_lock);
+	WARN_ON_ONCE(bcm_busy_notifier == bo);
+	list_del(&bo->notifier);
+	spin_unlock(&bcm_notifier_lock);
+
+	lock_sock(sk);
+
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
 		/*
 		 * Don't care if we're bound or not (due to netdev problems)
 		 * can_rx_unregister() is always a save thing to do here.
 		 */
@@ -1971,10 +1984,12 @@ static int bcm_release(struct socket *sock)
 					  REGMASK(op->can_id),
 					  bcm_rx_handler, op);
 
 	}
 
+	rtnl_unlock();
+
 	synchronize_rcu();
 
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
 		list_del_rcu(&op->list);
 		bcm_remove_op(op);
-- 
2.53.0

