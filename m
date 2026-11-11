Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414191;
	b=xgv0lqSNQQMK7T76CqY6cUJ8rA+Nd5jb41WMNlpfBU1O1dhOXYR+V06GT3TpU4yye5Wc
	 jHbqOEv/JZjlaBuFyiUaBm/UUQtM/vh3iO7YC9u+ZfKM98kincxk8SnrVw0unHvjHZuvP
	 FrPDAlbDtdOGaGQbSHm5cUu1/B01f1vGp6og+2244MJ5dE6ptAAIJOfhTSpqdsc7i+STV
	 /sMZE5BOsg3Uxlixdn86rYXAwIHZmyzKDLiA0Y51Nn5kuw45EQUQwtxA7HKKjfiYQfRKl
	 uhXbkFXdSoOj2IbI99wYeJmUEWrcNrSx8k9c7t8wgih1snjeTqqbTMKCLysqj8ORL8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414191;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=t5O+twYPrxrW47gy4zNXnb7Vgv6od7L/9XOyE2vOkSY=;
	b=FUkWWMmpPggB0mkFlf+fW4FugFJPMGQ+TBHLLOpnXKZav2sb7SnkYysB+5JZc0E70QC5
	 HrKb+DY+sj0l+LxIUeRHVN7vkGjka0TxrNi1EhsaevsiYM0lkZvyDZcbhPeUvDwx/9Oc+
	 a3LlyBphBe5E+Of9sWANgmD/NjHNVPBWyFPxTbHOwmuLu7UJa2pOXphZJzea6SZNNUU8R
	 yCxdufiZ0LjrRSiWs+qq2f06Qj4cUGZgvkVvhKx6qL1gd1iK8BtG46VNCUCSlQo5rHJZm
	 T1lSUP9eXfa0e7S67IQWV0ALFJiDYGcaeDuDSblDkhkld7QHhAcDon726juNwHbQ+Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHzDOIu+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EFE606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHzDOIu+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883B91F00A05;
	Wed, 11 Nov 2026 16:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414191;
	bh=t5O+twYPrxrW47gy4zNXnb7Vgv6od7L/9XOyE2vOkSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UHzDOIu+o5maATn5G1Dmbeh39MNZos0Caxw9r9P+PFTMwwbQ1sqbvIxDEHvA+cPe0
	 md+s7O2ih2kTFfYsOBc5SbHm4Stg73AsHNeJcnF6jmUH2T17q2TayYgQd1gqTU6jVM
	 LhSsj13mnPyI0Dw+hLHcfTVV+R7OBxBhRDzS8OBrvhZj3kVvcIeaySle3qutNM+qiy
	 Hzz+LqI0Szfoy8gFF7srGM5uJjqTdza9Oxw244Gge2JxwxsjZ9dx1qFwNOdfKmBlxH
	 G+4ZxQkToo5McfCXuugfRgkHv8kVmcGOGUxVjdvxmv0U7sdyBVeo1G4AQXR03zcd+W
	 Um3kCsoz85Aiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] ipv6/addrconf: allocate a per netns hash table
Date: Wed, 11 Nov 2026 11:23:06 -0500
Message-ID: <20261111162230.3239471-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111162230.3239471-1-sashal@kernel.org>
References: <20261107062657-failed-5.10-6ace56ed7b13@kernel.org>
 <20261111162230.3239471-1-sashal@kernel.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 21a216a8fc630161e69eaf02cbebdd1816ff1a13 ]

Add a per netns hash table and a dedicated spinlock,
first step to get rid of the global inet6_addr_lst[] one.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 6ace56ed7b13 ("ipv6: remove ifaddr from hash during ifdown list cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netns/ipv6.h |  4 ++++
 net/ipv6/addrconf.c      | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index f179996c61844..4703f8229433c 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -97,6 +97,10 @@ struct netns_ipv6 {
 	struct sock             *tcp_sk;
 	struct sock             *igmp_sk;
 	struct sock		*mc_autojoin_sk;
+
+	struct hlist_head	*inet6_addr_lst;
+	spinlock_t		addrconf_hash_lock;
+
 #ifdef CONFIG_IPV6_MROUTE
 #ifndef CONFIG_IPV6_MROUTE_MULTIPLE_TABLES
 	struct mr_table		*mrt6;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 8daa9f564eec7..8429bd481706f 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7116,6 +7116,13 @@ static int __net_init addrconf_init_net(struct net *net)
 	int err = -ENOMEM;
 	struct ipv6_devconf *all, *dflt;
 
+	spin_lock_init(&net->ipv6.addrconf_hash_lock);
+	net->ipv6.inet6_addr_lst = kcalloc(IN6_ADDR_HSIZE,
+					   sizeof(struct hlist_head),
+					   GFP_KERNEL);
+	if (!net->ipv6.inet6_addr_lst)
+		goto err_alloc_addr;
+
 	all = kmemdup(&ipv6_devconf, sizeof(ipv6_devconf), GFP_KERNEL);
 	if (!all)
 		goto err_alloc_all;
@@ -7176,11 +7183,15 @@ static int __net_init addrconf_init_net(struct net *net)
 err_alloc_dflt:
 	kfree(all);
 err_alloc_all:
+	kfree(net->ipv6.inet6_addr_lst);
+err_alloc_addr:
 	return err;
 }
 
 static void __net_exit addrconf_exit_net(struct net *net)
 {
+	int i;
+
 #ifdef CONFIG_SYSCTL
 	__addrconf_sysctl_unregister(net, net->ipv6.devconf_dflt,
 				     NETCONFA_IFINDEX_DEFAULT);
@@ -7191,6 +7202,15 @@ static void __net_exit addrconf_exit_net(struct net *net)
 	net->ipv6.devconf_dflt = NULL;
 	kfree(net->ipv6.devconf_all);
 	net->ipv6.devconf_all = NULL;
+
+	/*
+	 *	Check hash table, then free it.
+	 */
+	for (i = 0; i < IN6_ADDR_HSIZE; i++)
+		WARN_ON_ONCE(!hlist_empty(&net->ipv6.inet6_addr_lst[i]));
+
+	kfree(net->ipv6.inet6_addr_lst);
+	net->ipv6.inet6_addr_lst = NULL;
 }
 
 static struct pernet_operations addrconf_ops = {
-- 
2.53.0

