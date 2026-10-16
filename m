Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5D625393E;
	Fri, 16 Oct 2026 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141909; cv=pass; b=jegj4NAImH1Wbh1aUPFdF1bGNbe01QZTUQAKt0V0FF/Fj+MfE1UHPX4ZUSM9iguJhp8IHMReZE+XD0r/KA/XBPCjTOT4HqsrHTkvKyKgISmkqd9xRQFgXa2shHmIUW7ZqK25c5mY9o63x5nFb6EK5Dxxn4DFsqqPnUEgnbfivxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141909; c=relaxed/simple;
	bh=9kgQLHIyTupaZVsN70ZpTZ4CGVoaqpMzJzyyuYvpcl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aU0shqe7sLCgmV3c2OhnbyDX+kPppzVQ0fxAep54V/TnesKCruh6Q+BJ6Vh7/b+HE4iBV1seJS+R8kPCJ+oYrYmqpca6km99n2L+RjyNuE/LhQOnIBREJn8E2hHHhn6vZzCX4nMyiWur3gIuv5VNIu/FoV8lYgVNLxF48OagWxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=JqPHkrdW; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RK3erq6A; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="JqPHkrdW";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="RK3erq6A"
ARC-Seal: i=1; a=rsa-sha256; t=1792141904; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MTGh1PFh3s72UhR7TxIgebZQSStm3Gq8uKiw4Y97H+CEuEUtIzBCTOMnFJy3qYZpk8
    eyr7XNPlCojJtDRE5N71AZJrEzCU+3oEIvfgA4JvvN2G9AcF0DCQaQgewOuKBfryn1hO
    jzFs2r0qr/jQh2EqtbelQJtiDUDuEKZSsmrPfkR7dUJHj4HJRIKUBVfelS9Knuq33Vld
    ha33mWTsSEyV254HFqMHgZ34+oghS+eJMOw3TH+o81bSOhXC1kbnmbRn7/ewQ4C0aERi
    cl5rioGdueESd/iAM0vSeolHPJ1gKj1xTVL4uAxtuVpI5yjYD82PaowRBMse8WyQaCHd
    +HrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792141904;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=atRHD41eakfJSTan24t5d7G7fi2+t+J9Uv2GTZ/4eKc=;
    b=eF4v8lAmjBYamgciRy7v8U5KwHYjLqZ2fvFSM/4DuzJ5X3b3uLX1jKlIwcnUpGOf9T
    kMxLSWPlg8kRXaxJBz1cJO/fvbJAOkCqYR8EIfhUUqsnkIDrsDRd1cfQ6t+nO2zyrUOB
    MvqKucMq7rfsa9WjEPCsMM9nw5crIYjhQ7dcw9yqEORlIbFrkCTCNGXN+s2fiv9SgQTB
    IsyPLDpSWZFanvF0Nq72zXBrpj8HmmXX4IBM86WbVnEc7tl8eUSF+HzpbYisOXNG+RBO
    /P6meU4UfHTfWe3xTWconm+RlHZkTqQq6tdhIEO7VS+DaphM/iJEy8cYE6uaJaiFZlDU
    FnBA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792141904;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=atRHD41eakfJSTan24t5d7G7fi2+t+J9Uv2GTZ/4eKc=;
    b=JqPHkrdWkqAihkdnhlqUUGiWaB4b+ujt0Flr5aF9FqG5zwI7mCJyqSgPEDaVffnXog
    DE3NDJSADfjZ2DFSzv0jsmKJms4t+FbDyL5JbwmarPxxDC88BJzN4CyRjw9X6DhACxe0
    LpmqQPQMwSagulwsz0vSDdvU0bRdajUvl+FhpRPAQcCAQgZZKzDHioyiPblnZkS90EN6
    MQuwRhZYEfQtpcMtRD1ps7Gu8NTDg+Q1QtSV6v9nn1QMBDD0pgdVfHgqmYBDnIK16LRe
    I2JMuq/KCQ44mES860zU5g9XYKL2FxtoRyy7QEwciv5U4vqRhli5kQpiBVtQ7A7vBNDz
    yUcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792141904;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=atRHD41eakfJSTan24t5d7G7fi2+t+J9Uv2GTZ/4eKc=;
    b=RK3erq6ASd+zAJ/q63Izzmss10jqeKXnz/b8wwCL1asUCTcWdKYdD5DiTrs9ywtAWE
    HZYpzHbq5ILcgGVaZoDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29G9BhLK8
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Oct 2026 11:11:43 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Norbert Szetei <norbert@doyensec.com>,
	stable@vger.kernel.org
Subject: [PATCH can-next v3 2/3] can: bcm: fix filter removal race between release and netns change
Date: Fri, 16 Oct 2026 11:11:27 +0200
Message-ID: <20261016091128.325332-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016091128.325332-1-socketcan@hartkopp.net>
References: <20261016091128.325332-1-socketcan@hartkopp.net>
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
dev_net(dev) is stable while the device specific filters are removed.
As the notifier chain is always invoked under RTNL, bcm_busy_notifier
can not point to the released socket anymore. Replace the now dead
busy-wait loop with a WARN_ON_ONCE().

RTNL is only held for the notifier list removal and the removal of the
device specific filters. Once the socket has left the notifier list,
bcm_notify() can not access it anymore. So the procfs entry, the tx_ops
and the filters for 'any' CAN device, which live in the socket's
namespace, are removed after RTNL has been released. This way a stalled
reader of the world-readable procfs entry can not hold up RTNL, and the
removal of the 'any' CAN device filters does not delay RTNL anymore.

Fixes: 8e8cda6d737d ("can: initial support for network namespaces")
Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Cc: Norbert Szetei <norbert@doyensec.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 47 +++++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 3d637a1..b1bb3db 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1926,17 +1926,30 @@ static int bcm_release(struct socket *sock)
 
 	/* remove bcm_ops, timer, rx_unregister(), etc. */
 
+	rtnl_lock();
+
+	/* The netdev notifier chain runs under RTNL, so bcm_notifier() can't
+	 * be walking bcm_notifier_list and point to this socket. The spinlock
+	 * is still needed as bcm_init() adds sockets without holding RTNL.
+	 */
 	spin_lock(&bcm_notifier_lock);
-	while (bcm_busy_notifier == bo) {
-		spin_unlock(&bcm_notifier_lock);
-		schedule_timeout_uninterruptible(1);
-		spin_lock(&bcm_notifier_lock);
-	}
+	WARN_ON_ONCE(bcm_busy_notifier == bo);
 	list_del(&bo->notifier);
 	spin_unlock(&bcm_notifier_lock);
 
 	lock_sock(sk);
 
+	/* Remove the device specific subscriptions under RTNL */
+	list_for_each_entry(op, &bo->rx_ops, list)
+		if (op->ifindex && op->rx_reg_dev)
+			bcm_rx_unreg(op->rx_reg_dev, op);
+
+	rtnl_unlock();
+
+	/* bcm_notify() can not access this socket anymore. Release the other
+	 * resources without holding RTNL, e.g. remove_proc_entry() waits for
+	 * concurrent readers of the procfs entry.
+	 */
 #if IS_ENABLED(CONFIG_PROC_FS)
 	/* remove procfs entry */
 	if (net->can.bcmproc_dir && bo->bcm_proc_read)
@@ -1948,31 +1961,13 @@ static int bcm_release(struct socket *sock)
 		bcm_remove_op(op);
 	}
 
-	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
-		/*
-		 * Don't care if we're bound or not (due to netdev problems)
-		 * can_rx_unregister() is always a save thing to do here.
-		 */
-		if (op->ifindex) {
-			/*
-			 * Only remove subscriptions that had not
-			 * been removed due to NETDEV_UNREGISTER
-			 * in bcm_notifier()
-			 *
-			 * op->rx_reg_dev is a tracked reference taken
-			 * when the subscription was registered, so it
-			 * stays valid here even if a concurrent
-			 * NETDEV_UNREGISTER already unlisted the device.
-			 */
-			if (op->rx_reg_dev)
-				bcm_rx_unreg(op->rx_reg_dev, op);
-		} else
+	/* 'any' CAN device subscriptions live in the socket's namespace */
+	list_for_each_entry(op, &bo->rx_ops, list)
+		if (!op->ifindex)
 			can_rx_unregister(net, NULL, op->can_id,
 					  REGMASK(op->can_id),
 					  bcm_rx_handler, op);
 
-	}
-
 	synchronize_rcu();
 
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
-- 
2.43.0

