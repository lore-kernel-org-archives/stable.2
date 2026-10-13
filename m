Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A633EFFA8;
	Tue, 13 Oct 2026 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891409; cv=pass; b=BgItBbQqfCZYcjunXAe7CCjCYeLvWEAwTdV6WTxz9/vppdbiPFRF82FS0QXC0fG6HL4ZRYE0e7eKJjvO/qnNN7Dd4Ox3NHbrfrBshDwTIhF+KKMwcDlW5zECo1BnXBtKAIwz3o+EcrbfxpJjVJetVMxXU8TJAWK8tDf/fWgdwC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891409; c=relaxed/simple;
	bh=0eieI49GKSYaLWQyfEMtgZkoWqiAb51Z54E1IJDNfZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TS0sqJEY9tyHRjlO334LgrqKz/a1nQMnwbbYZ6PrlhmQjfc29h2gfh4nc/MA4Uv+WnQvBi0ZPeSeorH4cjRQb886BB1CcVvxyQ82Fm/wjoqwsSWmrtwXJIjCIT31czC5fU24rc6U0ajroEE61OjggJOvJ/fp4wJwY2rt7c8YaZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Lnd0Yodk; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=a5GyDdZ9; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Lnd0Yodk";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="a5GyDdZ9"
ARC-Seal: i=1; a=rsa-sha256; t=1791891403; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=S2EUgz0oz4UbKo52L40y0Qq7Dlyji08SUAH7IGlZ8CaX4jmNHF79/gHjTBba7dFVmU
    f7EPnMfPxwMOExBHjlHetmvlYq7C1HLC+9oEp5LpiGhAqI19MpDsaQMB+IVW2hXIpmSS
    DBrC+Cl3yohI4ccizV8xpx2lHOy9RTKrNXY9QHtfgPwX+PpTAwzgU1f9V3qXZjfWlnvF
    W4dGAQ/1prIIduGfh0RiKDAo/qagrd0b14m6boYAQBEVzzEwKSCdhHVWcICUNdbub5B6
    MC3sx0gsYsSubTUMBFyq98K2v4R36M80OR7v3TMgk3jWYhsYXwdiTozQIkd3H4IWhYXC
    3e5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791891403;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=t4GqaJ5Eda9C4Lipna5ZBdK9RgO6931sj9w4m8IwJgI=;
    b=IXnYo/PCqHYP+/6dIM0dEyqwQBXbVazzGTAxaN9n58KFCpGWFSdcPFZmOiiDlhVAPt
    EqARrwNh2P73UYqCDGsmGtjGcZMY87XNvAdGi16J8wUCSCGjWD8el2c2boL3+7GPEapP
    WXjAtAoXJmlJdG8z0aLSarZ5OxjXQoifdMshv1WahRvStUpcZ1VqMS/Rf/8jJCH5GHYa
    D9UHxJwuqUMPPsfCLrM4C8Zle2j6l8fJUOnPmW15S4qxyo7RKPs4jmzQ0IbRVcwcrah+
    MUHQG+2I4rjQArbuIzZY4iuU8cKuo3nx1rQtB+0NoNVAF9COPiVW6uHmjQY+0UbmwhNF
    O9RQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791891403;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=t4GqaJ5Eda9C4Lipna5ZBdK9RgO6931sj9w4m8IwJgI=;
    b=Lnd0Yodk4hz2ukq4rz96GOLkFnmsbJg45ZH6bgGSkw4n9swARtxRYtwvcMGm8d/mOr
    ueqKX2u7G1/G6P0ScxCR5sctfMqZWGoAo7UT0hFrrPuV4R7zjeitF0mZjmCwmxfxqEg4
    VpgoZZPGdrVTHHCy+f6PIaDVzzsDgqE8UAc7AGSmzthuL0Cu3qK8X0z/edz2zjhXbPUL
    74IHRRIv5GzAT8r/KGvUF9HpstX2/kVhnPiXBEAJ7RDhdIt/k/8fcCYzwDLjPeWriNPh
    QUvS6pkBE9CJ5+7z8MVWgtBO5yCqqgB7zjEtjNRBxPxyn6+Exc928r2x4PynowzmF6xg
    RfEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791891403;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=t4GqaJ5Eda9C4Lipna5ZBdK9RgO6931sj9w4m8IwJgI=;
    b=a5GyDdZ9U9Ql8ZcWlONLcPn/04oUC3wcenvoRlcCyKXOe9E5f7l6zHyK3PVJeoHfW6
    Q3xxEYRS4g7womh4D9Dg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29DBah66a
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 13 Oct 2026 13:36:43 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Norbert Szetei <norbert@doyensec.com>,
	stable@vger.kernel.org
Subject: [PATCH] can: bcm: fix filter removal race between release and netns change
Date: Tue, 13 Oct 2026 13:36:28 +0200
Message-ID: <20261013113628.104020-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
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

This is the same problem as reported for isotp_release() and fixed in a
separate patch: if the bound device changes its namespace in this
window, can_rx_unregister() can see a different netns than the one
passed in by bcm_rx_unreg() and silently skips the removal. The op is
freed anyway and the remaining receiver leads to a use-after-free in
bcm_rx_handler().

Take rtnl_lock() before removing the socket from the notifier list, so
that bcm_release() and bcm_notify() can not both skip the removal and
dev_net(dev) is stable while the filters are removed. RTNL is dropped
before synchronize_rcu(). As bcm_busy_notifier can not point to the
released socket under RTNL, replace the busy-wait loop with a
WARN_ON_ONCE().

Fixes: 8e8cda6d737d ("can: initial support for network namespaces")
Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Cc: Norbert Szetei <norbert@doyensec.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 3d637a1e0ac1..4765c14947fc 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1924,16 +1924,18 @@ static int bcm_release(struct socket *sock)
 	net = sock_net(sk);
 	bo = bcm_sk(sk);
 
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
 
@@ -1971,10 +1973,12 @@ static int bcm_release(struct socket *sock)
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

