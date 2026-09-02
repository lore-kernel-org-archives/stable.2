Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E6E217648
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 00:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309212; cv=none; b=uhNfUL3UDIUPxXvTsnNFGFk7zh9XNDvYXPqA5VFGVOZPDRymwYaAQmjg9k+nhe//fDHMQfSIMSodTdE2t5keBEKKNuJJ8nMnmrbADXtPtHVO3kLQMYWo7bgG5Ky1j9bsBVHTHZASyWK6ECHmOafwuPFh+KRWdK78cP42e1NIp2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309212; c=relaxed/simple;
	bh=vjPCorSFFWnngYXF5GaDIWsjYLQL6NWs+FH14t7WjOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfLbldPwhg8fmn+91JChnYleS43W+8q5XdtNqY91gSorlLQQ4u7C2scTMywL1VHarL5z60XT7dv+VJ1/usv5h6TmHcsV8scpvhZg70wJ9tZwcL0uclCqwIABeq/K2cKz4CeInV98MoexbOrOtc5vrqtwz0d1Lc9faXd0k79btj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOI1K9Su; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOI1K9Su"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02B21F000E9;
	Wed,  2 Sep 2026 00:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788309210;
	bh=IDMz+8r71rFX6CWyj/27xmuvgIboAVqlfwoUWYtC/Mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DOI1K9SurOk41m6H5jE68HO7Jl2cKMO373nw3KSjRMXhVn7CSqOabcF/GWWmIYED4
	 F+pb+JplfSJngCJ2arQ/mihEcpHZZf+MoIDOUUSuqHqj1XM11vJTNXKssFPMqHgInl
	 wlkWQIxtXzNoNhPYfwe2a/lAAIT3SPUcM9/TbdXpbjY6wVo32SNK+D6k6IF/ppqhQe
	 yljf4477fcGAE21gjHO0O8l/Q4z30JJW1N3lgnUZK4j9G+OOreCPMDNMNbI1chV5da
	 79J2qPnIxlRq8dVu28BOeS66CWc8lu3fYb+XXb1TjEe2Co8nbWAU+YHpAW5XX1PaUX
	 TijZ+xcPU6DfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yue Haibing <yuehaibing@huawei.com>,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] ipv6: mcast: Add ip6_mc_find_idev() helper
Date: Tue,  1 Sep 2026 20:33:26 -0400
Message-ID: <20260902003328.1792382-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083119-uncoated-animal-60e3@gregkh>
References: <2026083119-uncoated-animal-60e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yue Haibing <yuehaibing@huawei.com>

[ Upstream commit 60c481d4caa569001c708d4e9622d19650b6bedc ]

Extract the same code logic from __ipv6_sock_mc_join() and
ip6_mc_find_dev(), also add new helper ip6_mc_find_idev() to
reduce redundancy and enhance readability.

No functional changes intended.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Link: https://patch.msgid.link/20250822064051.2991480-1-yuehaibing@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Extract the same code logic from __ipv6_sock_mc_join() and ip6_mc_find_dev(), also add new helper ip6_mc_find_idev() to reduce redundancy and enhance readability.

No functional changes intended.

Stable 5.15 note: omit the multicast refactor, which is unrelated to the dependent MSS fix and conflicts with the stable multicast lifetime model. Repurpose this dependency as a context bridge by carrying the prerequisite per-netns IPv4 min_adv_mss conversion and compatibility macros needed by the newer route code.

[ sashal: Reduced backport -- upstream 60c481d4caa56 touches 1 file(s), this
  backport carries 6. Not backported here:
  net/ipv6/mcast.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 2640e6419594 ("net: advertise TCP MSS from the configured MTU, not the learned PMTU")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/dst.h        |  2 ++
 include/net/ip6_fib.h    |  2 ++
 include/net/ip6_route.h  |  2 ++
 include/net/netns/ipv4.h |  1 +
 net/ipv4/route.c         | 27 +++++++++++++++++----------
 net/ipv6/route.c         |  5 ++---
 6 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 9a23986f1071a..9de6b49cfd3dd 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -561,6 +561,8 @@ static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
 	return READ_ONCE(dst->dev);
 }
 
+#define dst_dev_net_rcu(dst) dev_net_rcu(dst_dev_rcu(dst))
+
 static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb)
 {
 	return dst_dev_rcu(skb_dst(skb));
diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index d72cee4dff70b..275d35f0a5514 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -239,6 +239,8 @@ struct fib6_result {
 	for (rt = (w)->leaf; rt;					\
 	     rt = rcu_dereference_protected(rt->fib6_next, 1))
 
+#define dst_rt6_info(ptr) ((struct rt6_info *)(ptr))
+
 static inline struct inet6_dev *ip6_dst_idev(struct dst_entry *dst)
 {
 	return ((struct rt6_info *)dst)->rt6i_idev;
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 5efd0b71dc673..ebab85b70641a 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -263,6 +263,8 @@ static inline bool ipv6_anycast_destination(const struct dst_entry *dst,
 int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		 int (*output)(struct net *, struct sock *, struct sk_buff *));
 
+#define dst6_mtu(dst) dst_mtu(dst)
+
 static inline unsigned int ip6_skb_dst_mtu(struct sk_buff *skb)
 {
 	unsigned int mtu;
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 8bc0d865338e4..a94de70312654 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -86,6 +86,7 @@ struct netns_ipv4 {
 
 	u32 ip_rt_min_pmtu;
 	int ip_rt_mtu_expires;
+	int ip_rt_min_advmss;
 
 	struct local_ports ip_local_ports;
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 5b277e12f3984..f61bc949f601a 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -120,6 +120,7 @@
 
 #define DEFAULT_MIN_PMTU (512 + 20 + 20)
 #define DEFAULT_MTU_EXPIRES (10 * 60 * HZ)
+#define DEFAULT_MIN_ADVMSS 256
 
 static int ip_rt_max_size;
 static int ip_rt_redirect_number __read_mostly	= 9;
@@ -127,7 +128,6 @@ static int ip_rt_redirect_load __read_mostly	= HZ / 50;
 static int ip_rt_redirect_silence __read_mostly	= ((HZ / 50) << (9 + 1));
 static int ip_rt_error_cost __read_mostly	= HZ;
 static int ip_rt_error_burst __read_mostly	= 5 * HZ;
-static int ip_rt_min_advmss __read_mostly	= 256;
 
 static int ip_rt_gc_timeout __read_mostly	= RT_GC_TIMEOUT;
 
@@ -1372,8 +1372,14 @@ static void set_class_tag(struct rtable *rt, u32 tag)
 static unsigned int ipv4_default_advmss(const struct dst_entry *dst)
 {
 	unsigned int header_size = sizeof(struct tcphdr) + sizeof(struct iphdr);
-	unsigned int advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
-				    ip_rt_min_advmss);
+	unsigned int advmss;
+	struct net *net;
+
+	rcu_read_lock();
+	net = dst_dev_net_rcu(dst);
+	advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
+				   net->ipv4.ip_rt_min_advmss);
+	rcu_read_unlock();
 
 	return min(advmss, IPV4_MAX_PMTU - header_size);
 }
@@ -3579,13 +3585,6 @@ static struct ctl_table ipv4_route_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-	{
-		.procname	= "min_adv_mss",
-		.data		= &ip_rt_min_advmss,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
 	{ }
 };
 
@@ -3613,6 +3612,13 @@ static struct ctl_table ipv4_route_netns_table[] = {
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec_jiffies,
 	},
+	{
+		.procname   = "min_adv_mss",
+		.data       = &init_net.ipv4.ip_rt_min_advmss,
+		.maxlen     = sizeof(int),
+		.mode       = 0644,
+		.proc_handler   = proc_dointvec,
+	},
 	{ },
 };
 
@@ -3675,6 +3681,7 @@ static __net_init int netns_ip_rt_init(struct net *net)
 	/* Set default value for namespaceified sysctls */
 	net->ipv4.ip_rt_min_pmtu = DEFAULT_MIN_PMTU;
 	net->ipv4.ip_rt_mtu_expires = DEFAULT_MTU_EXPIRES;
+	net->ipv4.ip_rt_min_advmss = DEFAULT_MIN_ADVMSS;
 	return 0;
 }
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 43b8995142e2e..8d3dc03238682 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3183,15 +3183,14 @@ EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 
 static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
-	struct net_device *dev = dst->dev;
-	unsigned int mtu = dst_mtu(dst);
+	unsigned int mtu = dst6_mtu(dst);
 	struct net *net;
 
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
 
 	rcu_read_lock();
 
-	net = dev_net_rcu(dev);
+	net = dst_dev_net_rcu(dst);
 	if (mtu < net->ipv6.sysctl.ip6_rt_min_advmss)
 		mtu = net->ipv6.sysctl.ip6_rt_min_advmss;
 
-- 
2.53.0

