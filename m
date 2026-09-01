Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A493D75A6
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788227681; cv=none; b=quic3ei2fChfHl+RXcN0vIXzXFxAS27cg/JB6zdQO94UxFfh1js1AD4+nco5ikguht9i9LZ6P03kKUFO8/PXcDian1nTNdgt6Es41gJp1OXzHu0+pCs+OcRMU5ZxRSfliuOTa/zkWXGamrCdI1N77B+kueYGKUvXPcvG+qjRF8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788227681; c=relaxed/simple;
	bh=kS2yiY4uVq/iAHjeSzigXn87XyirMDh6N6qdgUyzFZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vE2AW/1+ubaltx+rdA8m+szK4yBzf3h0k33Cv1Q/W79WhVUJxEGnKOQMtIuQ6QBoIFy1jQUeNHGCwVjkMt59tf9oZxVn1MshqiBkDxCJ8wYHTkTbkx60UK6V7pXgoLBbQ9JY49DFWlege/LVoHyp3yq5Q2QMJ2Z1SKgjj0CRSxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ammtO91D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ammtO91D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74F21F000E9;
	Tue,  1 Sep 2026 01:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788227662;
	bh=YyWKp74dKHrG8Xs9ZiU9enhUZEX54ElLd64xmqKtvqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ammtO91DWTFns+lPr5yk4H63tBpLfDnobtokj7p/SN+36cbVkDRVuC5RgKkHbUwpe
	 Tcq9Le+XfRlbIdwsoASF4rzR/dqefB9j90iSomQtvWx2skb2/sAjYZipVdPGVDpjaD
	 zUZ7u5O2CXhl44H1kHHf/3U7x8ewW3CTTvSwiAzWG72zd2k/2LlCJUVq/vRFdvX5dp
	 CLDLLbxYILyAg32InMU6wOLMqzdMqsuGDhrMrmdxDBAdmoClOP3KQLTE9L7xOJgfH2
	 yc4TH7TUTVRuuibTVvL440ME3JgR6y3k3lQIoi2LjXbOXyG7e+kWIYMuCUhuou/Hl8
	 4wm2hYVXQeYSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qing Ming <a0yami@mailbox.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] gtp: serialize PDP context updates
Date: Mon, 31 Aug 2026 21:54:19 -0400
Message-ID: <20260901015419.2065671-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083100-implosive-divinity-5dca@gregkh>
References: <2026083100-implosive-divinity-5dca@gregkh>
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
index 8f76fd927ff4a..57698316a2bf0 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/skbuff.h>
 #include <linux/udp.h>
 #include <linux/rculist.h>
@@ -82,6 +83,7 @@ struct gtp_net {
 };
 
 static u32 gtp_h_initval;
+static DEFINE_MUTEX(gtp_pdp_lock);
 
 static void pdp_context_delete(struct pdp_ctx *pctx);
 
@@ -109,7 +111,8 @@ static struct pdp_ctx *gtp0_pdp_find(struct gtp_dev *gtp, u64 tid)
 
 	head = &gtp->tid_hash[gtp0_hashfn(tid) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_tid) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_tid,
+				 lockdep_is_held(&gtp_pdp_lock)) {
 		if (pdp->gtp_version == GTP_V0 &&
 		    pdp->u.v0.tid == tid)
 			return pdp;
@@ -125,7 +128,8 @@ static struct pdp_ctx *gtp1_pdp_find(struct gtp_dev *gtp, u32 tid)
 
 	head = &gtp->tid_hash[gtp1u_hashfn(tid) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_tid) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_tid,
+				 lockdep_is_held(&gtp_pdp_lock)) {
 		if (pdp->gtp_version == GTP_V1 &&
 		    pdp->u.v1.i_tei == tid)
 			return pdp;
@@ -141,7 +145,8 @@ static struct pdp_ctx *ipv4_pdp_find(struct gtp_dev *gtp, __be32 ms_addr)
 
 	head = &gtp->addr_hash[ipv4_hashfn(ms_addr) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_addr) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_addr,
+				 lockdep_is_held(&gtp_pdp_lock)) {
 		if (pdp->af == AF_INET &&
 		    pdp->ms_addr_ip4.s_addr == ms_addr)
 			return pdp;
@@ -720,9 +725,11 @@ static void gtp_dellink(struct net_device *dev, struct list_head *head)
 	struct pdp_ctx *pctx;
 	int i;
 
+	mutex_lock(&gtp_pdp_lock);
 	for (i = 0; i < gtp->hash_size; i++)
 		hlist_for_each_entry_safe(pctx, next, &gtp->tid_hash[i], hlist_tid)
 			pdp_context_delete(pctx);
+	mutex_unlock(&gtp_pdp_lock);
 
 	list_del(&gtp->list);
 	unregister_netdevice_queue(dev, head);
@@ -1110,6 +1117,7 @@ static int gtp_genl_new_pdp(struct sk_buff *skb, struct genl_info *info)
 		goto out_unlock;
 	}
 
+	mutex_lock(&gtp_pdp_lock);
 	pctx = gtp_pdp_add(gtp, sk, info);
 	if (IS_ERR(pctx)) {
 		err = PTR_ERR(pctx);
@@ -1117,6 +1125,7 @@ static int gtp_genl_new_pdp(struct sk_buff *skb, struct genl_info *info)
 		gtp_tunnel_notify(pctx, GTP_CMD_NEWPDP, GFP_KERNEL);
 		err = 0;
 	}
+	mutex_unlock(&gtp_pdp_lock);
 
 out_unlock:
 	rtnl_unlock();
@@ -1171,6 +1180,8 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[GTPA_VERSION])
 		return -EINVAL;
 
+	mutex_lock(&gtp_pdp_lock);
+
 	rcu_read_lock();
 
 	pctx = gtp_find_pdp(sock_net(skb->sk), info->attrs);
@@ -1191,6 +1202,7 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 
 out_unlock:
 	rcu_read_unlock();
+	mutex_unlock(&gtp_pdp_lock);
 	return err;
 }
 
-- 
2.53.0

