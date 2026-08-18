Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CD21DA60D;
	Tue, 18 Aug 2026 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065248; cv=none; b=FpQnvYYrD6bjvBqd+R7J5MJVpnx8/WaocKeYoHl49kGSPWIhAo5Acxn8/1OnJdxvF8GvmGQZANrp11v95dlaFy4yXnwse4VmnAxWsOrDBlDbYOCeOqSNE4SRVXdKbLK9e0TbHF7zKD6k4TbJr8x7R4SNPKM7DgRn8Du0WXw1rlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065248; c=relaxed/simple;
	bh=geAxcum7c/dj+hk+H0/LINFb0jj708HeBqzRjzrEowo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tCrSzZMsXhII6YbTKJ0wcdSHlxvlHNoBUEalK6xt9uMfys2SLLnams3lm0+fo1xSz9Z6gYEORD94N4fNlxEmRGaPVZ+axK4/qKjGFj3IisBewmO8Xk2CTYmsDXI/rXHrcOm242sgSB5JC5xtYqK80zMEZ3ffekpULwGBH9GeP50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=r+ej3+4D; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Mhumq221; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="r+ej3+4D";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Mhumq221"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hPXvB1Cp9zMlMg;
	Tue, 18 Aug 2026 17:00:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787065238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fzSp6XdF4qx9FvRVGbtcxUKO0CVaFkqpl04Pebdb8JE=;
	b=r+ej3+4D1Hxky7xJNBzfXLLXodmjz87H56YWXAdeh9M8AnmHfmjAszxV8acIKJ/36qHrEB
	IrcNwuK+ncbPbvsBhKUJVAV3635Kexn70ujhCJHMlN0imXxo+l08UyoDe3nFPUbPUhlTUu
	bfw76gAZdX3AZ4yEuJD1Q1Yz7TotxSJBW0GknYnTT5PhZgtZXAQ/UU0/zRehHmz6kg+o21
	70c5z5A/mC/eqioNe1MUUhR5YR4GiFYumpg3V4RBtfda+7PQq27n73k69VNt4bKbNFauK9
	DK5df70u5a4dhgCglqSnb9+XMNGPZidbO9f6dkNakFnyMR8/NgkcI7z5lJotPg==
From: Qing Ming <a0yami@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787065235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fzSp6XdF4qx9FvRVGbtcxUKO0CVaFkqpl04Pebdb8JE=;
	b=Mhumq221Fdr0s8CVGtRCtK481Y0GDUogPduetl9bAwhOw61+jCJgy3KpBHhaNl1fiYgMcF
	LOl9pc/QruXU76CQzqkej+TwvkrU9Elq2hNqWyVHkOADF+iPIC7RtxZDD978kMgoTuN3Gj
	Q4t+vykdSUBYIAVG2aWNn+wFg0qYjF7lHJ24Jf+ZCl35IYrqdj40qJCQHunHZERWxSiRHx
	BXIQMK7VvDzrVjz8WclWqQNTB/LrZsX+WIGkfAeNjRxGBuCO9EI7TW+CwkiGrtVHGNr45m
	gUUiXEMv9Ypp+NQZjlUDsnS0sLp0BJJcimcArc27gFTwPN4FUr7BhfGmui9KKA==
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org,
	kuniyu@google.com,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qing Ming <a0yami@mailbox.org>,
	stable@vger.kernel.org
Subject: [PATCH net v5] gtp: serialize PDP context updates
Date: Tue, 18 Aug 2026 23:00:00 +0800
Message-ID: <20260818150000.7670-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 62b6b3cf25f229d6e6a
X-MBO-RS-META: wb5a6z8qiobbp7ehbq1or3ar4mq6imtq

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
Assisted-by: Codex:gpt-5
Signed-off-by: Qing Ming <a0yami@mailbox.org>
---
v5:
- Keep gtp_pdp_lock held through the final pctx use in the NEWPDP path.
- Keep the RCU read-side section around the full pctx use in the DELPDP
  path.

v4: https://lore.kernel.org/netdev/20260814031526.118216-1-a0yami@mailbox.org/

 drivers/net/gtp.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 9a12cc53da00..2f6e77cce385 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/skbuff.h>
 #include <linux/udp.h>
 #include <linux/rculist.h>
@@ -108,6 +109,7 @@ struct gtp_net {
 };
 
 static u32 gtp_h_initval;
+static DEFINE_MUTEX(gtp_pdp_lock);
 
 static struct genl_family gtp_genl_family;
 
@@ -151,7 +153,8 @@ static struct pdp_ctx *gtp0_pdp_find(struct gtp_dev *gtp, u64 tid, u16 family)
 
 	head = &gtp->tid_hash[gtp0_hashfn(tid) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_tid) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_tid,
+				 lockdep_is_held(&gtp_pdp_lock)) {
 		if (pdp->af == family &&
 		    pdp->gtp_version == GTP_V0 &&
 		    pdp->u.v0.tid == tid)
@@ -168,7 +171,8 @@ static struct pdp_ctx *gtp1_pdp_find(struct gtp_dev *gtp, u32 tid, u16 family)
 
 	head = &gtp->tid_hash[gtp1u_hashfn(tid) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_tid) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_tid,
+				 lockdep_is_held(&gtp_pdp_lock)) {
 		if (pdp->af == family &&
 		    pdp->gtp_version == GTP_V1 &&
 		    pdp->u.v1.i_tei == tid)
@@ -185,7 +189,8 @@ static struct pdp_ctx *ipv4_pdp_find(struct gtp_dev *gtp, __be32 ms_addr)
 
 	head = &gtp->addr_hash[ipv4_hashfn(ms_addr) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_addr) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_addr,
+				 lockdep_is_held(&gtp_pdp_lock)) {
 		if (pdp->af == AF_INET &&
 		    pdp->ms.addr.s_addr == ms_addr)
 			return pdp;
@@ -220,7 +225,8 @@ static struct pdp_ctx *ipv6_pdp_find(struct gtp_dev *gtp,
 
 	head = &gtp->addr_hash[ipv6_hashfn(ms_addr) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_addr) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_addr,
+				 lockdep_is_held(&gtp_pdp_lock)) {
 		if (pdp->af == AF_INET6 &&
 		    ipv6_pdp_addr_equal(&pdp->ms.addr6, ms_addr))
 			return pdp;
@@ -1555,9 +1561,11 @@ static void gtp_dellink(struct net_device *dev, struct list_head *head)
 	struct pdp_ctx *pctx;
 	int i;
 
+	mutex_lock(&gtp_pdp_lock);
 	for (i = 0; i < gtp->hash_size; i++)
 		hlist_for_each_entry_safe(pctx, next, &gtp->tid_hash[i], hlist_tid)
 			pdp_context_delete(pctx);
+	mutex_unlock(&gtp_pdp_lock);
 
 	list_del(&gtp->list);
 	unregister_netdevice_queue(dev, head);
@@ -2053,6 +2061,7 @@ static int gtp_genl_new_pdp(struct sk_buff *skb, struct genl_info *info)
 		goto out_unlock;
 	}
 
+	mutex_lock(&gtp_pdp_lock);
 	pctx = gtp_pdp_add(gtp, sk, info);
 	if (IS_ERR(pctx)) {
 		err = PTR_ERR(pctx);
@@ -2060,6 +2069,7 @@ static int gtp_genl_new_pdp(struct sk_buff *skb, struct genl_info *info)
 		gtp_tunnel_notify(pctx, GTP_CMD_NEWPDP, GFP_KERNEL);
 		err = 0;
 	}
+	mutex_unlock(&gtp_pdp_lock);
 
 out_unlock:
 	rtnl_unlock();
@@ -2134,6 +2144,8 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[GTPA_VERSION])
 		return -EINVAL;
 
+	mutex_lock(&gtp_pdp_lock);
+
 	rcu_read_lock();
 
 	pctx = gtp_find_pdp(sock_net(skb->sk), info->attrs);
@@ -2154,6 +2166,7 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 
 out_unlock:
 	rcu_read_unlock();
+	mutex_unlock(&gtp_pdp_lock);
 	return err;
 }
 

base-commit: a3dee9bb902ee4357fa02e49b415d7724ee0140a
-- 
2.53.0
