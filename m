Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318E1248880
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222072; cv=none; b=K5lY4pTkXCtD+g28LiSgHKmLuEQa5mnKQQoMDmj+5rYXIzmSh/BaUZ37wiAm3YENctsQN9kXDzrVhq1oH/mpG+q3J2nHMCEwKvJd8aDQxgmzdb23qtQKLsLbQZ2PlQb05sNJzV63buNC8SEXfGXbZgcm6RaLkd0Z+ZFUyZmhCU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222072; c=relaxed/simple;
	bh=v3Qj8gyEhNR/P24ALF9llT65SyXyOLIrI+TFK0bBI8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0iTT4A+/XKfubffGHMiq6F6Se0BIGuzqQ6gvsUNEX+Vkx8gTMPWka7x6s8NR54UKCGtEuSLHFm+SFsTKeksTxkAJORzYT487fBbsE8BpGrA2RgD6Z5vvUocRbczqXEC30+f5fCS1HK7onzqrnnXHlHW/JhuJuaF99ZDhudUA5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFA0iK5N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFA0iK5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CA51F00ACA;
	Tue,  1 Sep 2026 00:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788222070;
	bh=507tVR160RPUl3BlyD6J2VrNxZc8p7HqzjWniuMt/jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KFA0iK5NQRH3dOSW6oCro6CFdS9D6VDFQsaALKwkLv7QAqCYz6aeKXsvRh25Szzcx
	 urBXPVPpa+Ul3D+W912Zww06PpfU1SiNsek3zSGjdiqT0XGv75ZXWXpLuyHprkY/k0
	 UNaZlHQtPqbeXicK/M6yurH+4PXSYVMyDyl/m1nex7m/NgZVJkctGJ3ZWP8amjrbej
	 Hni18bV9ixj6RNp34/sMmvnNtil1Lg6ayfF4i0dewbLU2zaIl3cMekkZ3a8QP7Bi+e
	 VnhndZ6CenOziG03fukfd35pu+MR3LUko6pyw2+q7ZMb6IKWfQtYDMzgLBNkcYm+Y/
	 Jyeisrx0aWZSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qing Ming <a0yami@mailbox.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] gtp: serialize PDP context updates
Date: Mon, 31 Aug 2026 20:21:08 -0400
Message-ID: <20260901002108.2024915-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083159-appetizer-scanning-c174@gregkh>
References: <2026083159-appetizer-scanning-c174@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qing Ming <a0yami@mailbox.org>

[ Upstream commit 498386b6d402737db1e2eeed4c385acbf0ef9e34 ]

PDP contexts can be deleted through GTP_CMD_DELPDP or while the GTP
network device is being unregistered. The latter is serialized by RTNL,
but the generic-netlink delete path only holds RCU.

Running both paths concurrently can therefore make both paths delete the
same PDP context. The issue was found through static analysis and
reproduced on a KASAN-enabled kernel by a simple two-thread program
racing GTP_CMD_DELPDP against RTM_DELLINK:

  Oops: general protection fault, probably for non-canonical address
  KASAN: maybe wild-memory-access in range
         [0xdead000000000120-0xdead000000000127]
  RIP: gtp_genl_del_pdp+0x1c1/0x420 [gtp]
  RBP: dead000000000122

The second deletion dereferenced the poisoned hlist pprev pointer.

Serialize gtp_pdp_add(), gtp_genl_del_pdp(), and gtp_dellink() with a
shared mutex. Keep the mutex held until the final use of a PDP context in
the NEWPDP path, and keep the RCU read-side section around the complete
PDP context use in the DELPDP path.

Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Cc: stable@vger.kernel.org
Signed-off-by: Qing Ming <a0yami@mailbox.org>
Link: https://patch.msgid.link/20260818150000.7670-1-a0yami@mailbox.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adapted the locking changes to the older IPv4-only PDP context API and omitted the absent IPv6 lookup hunk. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/gtp.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 7bb3da8f25363..0f8c9b303dc28 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/skbuff.h>
 #include <linux/udp.h>
 #include <linux/rculist.h>
@@ -92,6 +93,7 @@ struct gtp_net {
 };
 
 static u32 gtp_h_initval;
+static DEFINE_MUTEX(gtp_pdp_lock);
 
 static struct genl_family gtp_genl_family;
 
@@ -129,7 +131,8 @@ static struct pdp_ctx *gtp0_pdp_find(struct gtp_dev *gtp, u64 tid)
 
 	head = &gtp->tid_hash[gtp0_hashfn(tid) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_tid) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_tid,
+				 lockdep_is_held(&gtp_pdp_lock)) {
 		if (pdp->gtp_version == GTP_V0 &&
 		    pdp->u.v0.tid == tid)
 			return pdp;
@@ -145,7 +148,8 @@ static struct pdp_ctx *gtp1_pdp_find(struct gtp_dev *gtp, u32 tid)
 
 	head = &gtp->tid_hash[gtp1u_hashfn(tid) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_tid) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_tid,
+				 lockdep_is_held(&gtp_pdp_lock)) {
 		if (pdp->gtp_version == GTP_V1 &&
 		    pdp->u.v1.i_tei == tid)
 			return pdp;
@@ -161,7 +165,8 @@ static struct pdp_ctx *ipv4_pdp_find(struct gtp_dev *gtp, __be32 ms_addr)
 
 	head = &gtp->addr_hash[ipv4_hashfn(ms_addr) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_addr) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_addr,
+				 lockdep_is_held(&gtp_pdp_lock)) {
 		if (pdp->af == AF_INET &&
 		    pdp->ms_addr_ip4.s_addr == ms_addr)
 			return pdp;
@@ -1119,9 +1124,11 @@ static void gtp_dellink(struct net_device *dev, struct list_head *head)
 	struct pdp_ctx *pctx;
 	int i;
 
+	mutex_lock(&gtp_pdp_lock);
 	for (i = 0; i < gtp->hash_size; i++)
 		hlist_for_each_entry_safe(pctx, next, &gtp->tid_hash[i], hlist_tid)
 			pdp_context_delete(pctx);
+	mutex_unlock(&gtp_pdp_lock);
 
 	list_del(&gtp->list);
 	unregister_netdevice_queue(dev, head);
@@ -1506,6 +1513,7 @@ static int gtp_genl_new_pdp(struct sk_buff *skb, struct genl_info *info)
 		goto out_unlock;
 	}
 
+	mutex_lock(&gtp_pdp_lock);
 	pctx = gtp_pdp_add(gtp, sk, info);
 	if (IS_ERR(pctx)) {
 		err = PTR_ERR(pctx);
@@ -1513,6 +1521,7 @@ static int gtp_genl_new_pdp(struct sk_buff *skb, struct genl_info *info)
 		gtp_tunnel_notify(pctx, GTP_CMD_NEWPDP, GFP_KERNEL);
 		err = 0;
 	}
+	mutex_unlock(&gtp_pdp_lock);
 
 out_unlock:
 	rtnl_unlock();
@@ -1567,6 +1576,8 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[GTPA_VERSION])
 		return -EINVAL;
 
+	mutex_lock(&gtp_pdp_lock);
+
 	rcu_read_lock();
 
 	pctx = gtp_find_pdp(sock_net(skb->sk), info->attrs);
@@ -1587,6 +1598,7 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 
 out_unlock:
 	rcu_read_unlock();
+	mutex_unlock(&gtp_pdp_lock);
 	return err;
 }
 
-- 
2.53.0

