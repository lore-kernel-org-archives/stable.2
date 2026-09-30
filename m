Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6045013BE
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781198; cv=none; b=ZqNTM3LaN5l/Yg7dtIgrrMIJDx3GD3oOKDeSC0IKsVC2aeySTMWHVeD+KZT/2JvPsvD7rhCigfF1lz3dlGmI20Chg39Wf6k+EIGTVHylqc5Bk+TExwNpiiuGA5wIYTQ6X6AvECO3r+hk8u2fzb4ktymA0ZZYZYmQnhzr6d6OFbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781198; c=relaxed/simple;
	bh=Zp4YHpwh8lalzUQisIhuqPKrhQ5oJqejhOkgKVRxXVs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TN/u0pSIivrz6k6vQ0W1+gVqsaaDyNyX4Wg1Jvtfg0D7WoihL87Smzn3t6Q88WZ62496NsG/OYdPsHlwFxIEcCTKX2aMezja4OX5AH0Et8VFxoqEYJOGdEdtC5r/5u1vuGZl+DVrtqionlAJMHn5LzEjSTXlrXRyFr0wxZHjDxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PE2JwwUq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PE2JwwUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCF31F00898;
	Wed, 30 Sep 2026 15:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790781187;
	bh=/7dh4zTAE48xtrIS8/zmGIJ7LI0wsAYAgx/VFXja5c0=;
	h=Subject:To:Cc:From:Date;
	b=PE2JwwUq7etY0VjBrXTLqkLAe9LKdKOAFW7UVQ26wvs4Moz1rXh5Rc8wxnmjtonlp
	 7IzA9HJIcTP26wrkTlgj+0JLIvVw6cCkLMC6uMlWFjCWuahLT2CEwW647W/NrRnTV5
	 iDbUtfNsZPbLgjppPnyHrtRGI4Ive+Q5C+UHa5es=
Subject: FAILED: patch "[PATCH] net: vxlan: prevent NULL deref in vxlan_xmit_one" failed to apply to 6.6-stable tree
To: atenart@kernel.org,b.galvani@gmail.com,idosch@nvidia.com,kuba@kernel.org,liali@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 30 Sep 2026 17:12:53 +0200
Message-ID: <2026093053-earache-hubcap-d19c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1f73a56f986005f0bc64ed23873930e2ee4f5911
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026093053-earache-hubcap-d19c@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1f73a56f986005f0bc64ed23873930e2ee4f5911 Mon Sep 17 00:00:00 2001
From: Antoine Tenart <atenart@kernel.org>
Date: Wed, 26 Nov 2025 11:26:25 +0100
Subject: [PATCH] net: vxlan: prevent NULL deref in vxlan_xmit_one

Neither sock4 nor sock6 pointers are guaranteed to be non-NULL in
vxlan_xmit_one, e.g. if the iface is brought down. This can lead to the
following NULL dereference:

  BUG: kernel NULL pointer dereference, address: 0000000000000010
  Oops: Oops: 0000 [#1] SMP NOPTI
  RIP: 0010:vxlan_xmit_one+0xbb3/0x1580
  Call Trace:
   vxlan_xmit+0x429/0x610
   dev_hard_start_xmit+0x55/0xa0
   __dev_queue_xmit+0x6d0/0x7f0
   ip_finish_output2+0x24b/0x590
   ip_output+0x63/0x110

Mentioned commits changed the code path in vxlan_xmit_one and as a side
effect the sock4/6 pointer validity checks in vxlan(6)_get_route were
lost. Fix this by adding back checks.

Since both commits being fixed were released in the same version (v6.7)
and are strongly related, bundle the fixes in a single commit.

Reported-by: Liang Li <liali@redhat.com>
Fixes: 6f19b2c136d9 ("vxlan: use generic function for tunnel IPv4 route lookup")
Fixes: 2aceb896ee18 ("vxlan: use generic function for tunnel IPv6 route lookup")
Cc: Beniamino Galvani <b.galvani@gmail.com>
Signed-off-by: Antoine Tenart <atenart@kernel.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20251126102627.74223-1-atenart@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index a5c55e7e4d79..e957aa12a8a4 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2349,7 +2349,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	int addr_family;
 	__u8 tos, ttl;
 	int ifindex;
-	int err;
+	int err = 0;
 	u32 flags = vxlan->cfg.flags;
 	bool use_cache;
 	bool udp_sum = false;
@@ -2454,12 +2454,18 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 
 	rcu_read_lock();
 	if (addr_family == AF_INET) {
-		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
+		struct vxlan_sock *sock4;
 		u16 ipcb_flags = 0;
 		struct rtable *rt;
 		__be16 df = 0;
 		__be32 saddr;
 
+		sock4 = rcu_dereference(vxlan->vn4_sock);
+		if (unlikely(!sock4)) {
+			reason = SKB_DROP_REASON_DEV_READY;
+			goto tx_error;
+		}
+
 		if (!ifindex)
 			ifindex = sock4->sock->sk->sk_bound_dev_if;
 
@@ -2534,10 +2540,16 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				    ipcb_flags);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
-		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
+		struct vxlan_sock *sock6;
 		struct in6_addr saddr;
 		u16 ip6cb_flags = 0;
 
+		sock6 = rcu_dereference(vxlan->vn6_sock);
+		if (unlikely(!sock6)) {
+			reason = SKB_DROP_REASON_DEV_READY;
+			goto tx_error;
+		}
+
 		if (!ifindex)
 			ifindex = sock6->sock->sk->sk_bound_dev_if;
 

