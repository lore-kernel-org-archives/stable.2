Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412948;
	b=eOSkae3QWNTt9Wr0agcrCtK22WEDZM8Y0VRGC/bjKWfhlp6SltqBTf+xYKeMKq6Q03cj
	 rx58GJb4Lzb3tiX40z6ukj5AjWvhDgvmahjmDvC2n47bhdl8oTRzJ9vyESpRiyFnnFG9/
	 J0kad89QzrY+7TAvygK1Iinrg9TwuBwT/cVWBInZj4RKK3JPfYXMJQ6eV1HMG3rMjby2g
	 +XGAXPdOL4ewrs47+TnQeBX1DkhrA/zCmhgkHQ7bTbHOUr95cGALz0CwDzqiCOzRgswxb
	 6XgqekNZfhvahzj7egzVpHEmTWZTqYRGpHlNmRPYILTkceCop4Bk4tUp/J+BntOdoSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412948;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MwVdZnfTFiHkJlPfXCQB/+ggEFsb5AU+D643rYr1aa4=;
	b=kEBNPkA4v3CzJyZQCNPc73+T7wols38RxvLP1qxLTYZZYtJCC8QHVU/HJ+8l/EMXCrG9
	 5pdIBK0YYedUwL300mFqRQDDLAusifTFz3iBBZrlid9YQNBOTLuU3PyxRhoMrLTTfCX/P
	 H6uOWuqdUNC8NyxRlgiw4tMHsCVxEif03L3HgkJIi4KtPk9TPH4VSfgJaBn4S3dvzvaa9
	 wX5IDz5hqAMnxvuDx01Ci0NYmcwgcntjnZ8fEPTc/0bippTBaZLpDxomZ5/WA4b7PZ0P2
	 K78lf2vuJCQNwlXgfMwUv6zyVWFsMLFuO1hPZEmu7zUrGK/vca0gA/zwsl/pR6vARjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m73yk7wF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C0C606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m73yk7wF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14291F00A08;
	Wed, 11 Nov 2026 16:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794412948;
	bh=MwVdZnfTFiHkJlPfXCQB/+ggEFsb5AU+D643rYr1aa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m73yk7wFnQRC79Eyl6ivqlqW46+h3xcQj1UjUXirMzyIp+Ix1or7Pzz0qm2g+O4yN
	 B4bgyNJ0/8OsNdQVdZ5OILsYkzKqE1bEAtn3bDD0Ip8oIXgwRt8iyK4WoCb0QNXlDq
	 EoAiMZLxqVkExdGHwNjaEgJ4uZNsoeGu+GzkgXxfpCO6/wV5hadV22AXK0G0rdciQb
	 V3OoPOwt17d4PEf3S8PjZK92cvNSCTsyRMTeWWu82OzS+CVCHSTSjUgSmnZBY0nGEY
	 za/q9OH3bMDIooawohH5TATPxwaTLWqlwnXiA/EyZMcAMmbK4XWPRzQZQ4t6v3A8wf
	 FzcCfN8KdY9ZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] ipv6/addrconf: allocate a per netns hash table
Date: Wed, 11 Nov 2026 11:02:23 -0500
Message-ID: <20261111160144.2767084-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111160144.2767084-1-sashal@kernel.org>
References: <20261107060950-failed-5.15-6ace56ed7b13@kernel.org>
 <20261111160144.2767084-1-sashal@kernel.org>
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
index 181b44f6fb686..d38aa787fc159 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -94,6 +94,10 @@ struct netns_ipv6 {
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
index 9bfb98add9889..e4f1c67c6c511 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7206,6 +7206,13 @@ static int __net_init addrconf_init_net(struct net *net)
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
@@ -7266,11 +7273,15 @@ static int __net_init addrconf_init_net(struct net *net)
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
@@ -7281,6 +7292,15 @@ static void __net_exit addrconf_exit_net(struct net *net)
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

