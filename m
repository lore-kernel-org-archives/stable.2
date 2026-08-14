Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1AE3242A4;
	Fri, 14 Aug 2026 03:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677362; cv=none; b=uUB5R+6I6xYd8Y1IgbvTjKurXni4jK6L9roq9uaUg5JaG7TzxfWcPk8p/dLSwQXuPY+wZ6Un/3eO4w4AT8n/prFrseS6/O+IwmlAJaJD/+EEYFV+EppOFX1Fom3p5rGqzgC4XczrB4AWWjdABTjRgjWM4FLB0fvhB6TiW2uJx3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677362; c=relaxed/simple;
	bh=WdfXccHZH/tQhVXJSPz90vcVwbeiDuCh7PBGBs0WbFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RjOdKMCIuoRjmNfOL6g2tL8EzotRBxoIKAatUdee5y7CCUcsbGShsstsXXThLY1Ecw6ga/SMVe0vd0y1cDUArNw+UsDFHBYaXykBgvf9O/3CXzav+Zfjyr1QjIHmd17eCZ+h2e5DV6Pc5jxqBoY7hFZHlUoQy9uQCxcGo1E1fDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fXls6qP5; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=bFNSpCwM; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fXls6qP5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bFNSpCwM"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hLnRp6V4HzKnR3;
	Fri, 14 Aug 2026 05:15:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786677350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PgW0nNEeRaSLuGVQ0tbwEA3FRbrJWaeTdYUV3Yc7Dok=;
	b=fXls6qP5/heNel168IHHsYvN6zDvFOIw2c+/04pT/JLCLlGJ5PXw0ZIwot/FtmcAdzzyeg
	vQcCtwCEJGbUdzXVWWlHpd0afxOPr1fQ8lkPdjlXLVQGhWPwOOwXIkTb2eQmeF9jus+koA
	wlYvBadppCZtXfxGObcuqf2ccOJIBtdLeR+GQhAQhRb0AivVgXwNqeGzzkY+inIoF2WAaL
	Rop8E3zYOsWwXKIK3SZ3HrXY29ktLmMcZJqZFuiyo3p9ZvxcCxKNvEkQ3sOgs+AC6I7OeM
	8OQnQeHgp2UkGs8EZoa8pZhk6GFBbjnKARj6ptnYSjbjJACcUaaY4Sb20yzSyg==
From: Qing Ming <a0yami@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786677348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PgW0nNEeRaSLuGVQ0tbwEA3FRbrJWaeTdYUV3Yc7Dok=;
	b=bFNSpCwMxXLzuj1vaEYg46TzNeRqGbi1AAZbbeju7VmETqy0j9owKUXY48vdYvZEZzFwaj
	ECMO3qlsDo50bRA91ktZUaiPdmonliefUxId0AzDFwBEXZRAYQm8kInvRqntZ6riszXZ+m
	2eHs/kSMB2XfEXlxW0nN3+cg2ir8o7t/lp4zcDaSkbXvFPcJ9liJ6ARL9rUgYYykhf9v8A
	0l1/plO4gVnvj2oS6H+DdZ96F1c2GGqALGQLg77/Jbicj1Qj17ugDI1GCDFILY4Fukcekh
	/CKpO7eQZhe8oX/FHScCuHRgULn+qVuwdjph87m6SqKS7zVKMZopTH24vL1xXg==
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
Subject: [PATCH net v4] gtp: serialize PDP context updates
Date: Fri, 14 Aug 2026 11:15:26 +0800
Message-ID: <20260814031526.118216-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cd66ncaa1ym3ob8obuwbyqoxa6ouwjjm
X-MBO-RS-ID: ae4c0d2be76c36ecd6c

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
shared mutex. With this change, the same reproducer completed 50 races
on a KASAN- and lockdep-enabled kernel without a KASAN report, oops, or
lockdep warning.

Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Qing Ming <a0yami@mailbox.org>
---
v4:
- Replace guard() with plain mutex_lock()/mutex_unlock() in the
  GTP_CMD_NEWPDP path.
- Narrow the RCU read-side section in gtp_genl_del_pdp() to
  gtp_find_pdp(); gtp_find_dev() uses dev_get_by_index_rcu().
- Add mutex-aware lockdep conditions to the shared PDP lookup helpers.

v3: https://lore.kernel.org/netdev/20260811022012.5416-1-a0yami@mailbox.org/
 drivers/net/gtp.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 9a12cc53da00..ea83a6b6aa1a 100644
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
@@ -2053,7 +2061,9 @@ static int gtp_genl_new_pdp(struct sk_buff *skb, struct genl_info *info)
 		goto out_unlock;
 	}
 
+	mutex_lock(&gtp_pdp_lock);
 	pctx = gtp_pdp_add(gtp, sk, info);
+	mutex_unlock(&gtp_pdp_lock);
 	if (IS_ERR(pctx)) {
 		err = PTR_ERR(pctx);
 	} else {
@@ -2134,9 +2144,12 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[GTPA_VERSION])
 		return -EINVAL;
 
-	rcu_read_lock();
+	mutex_lock(&gtp_pdp_lock);
 
+	/* gtp_find_dev() uses dev_get_by_index_rcu(). */
+	rcu_read_lock();
 	pctx = gtp_find_pdp(sock_net(skb->sk), info->attrs);
+	rcu_read_unlock();
 	if (IS_ERR(pctx)) {
 		err = PTR_ERR(pctx);
 		goto out_unlock;
@@ -2153,7 +2166,7 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 	pdp_context_delete(pctx);
 
 out_unlock:
-	rcu_read_unlock();
+	mutex_unlock(&gtp_pdp_lock);
 	return err;
 }
 

base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
-- 
2.53.0

