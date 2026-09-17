Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B74D4D179C
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670391; cv=none; b=lm3ipFWWfjWO53yaTSyVis7qnAOfYDHdw/VLZXW8G4l7F4GyJMcfJvp/cfW3FbZLkZq90o93z7fXmv0UdQ7TXywgONjB3ME0Jjmmh+ch8Tyl04dQwnZFk0bkE7HRjo1q5SGkFwANvzz7bLTaH40Tgorm9wTFGnRIqdM7a07dnj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670391; c=relaxed/simple;
	bh=4bukM7ywybQOAOC0xiIOg32rMK71xx63RwH0RtyYJks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXoi1qc2xquUqynf+ig4FOfu+Honuk5d3jhltNPIqWPzmumaDkGb+wSfceSlf2rS1aCqWP1FWZ0LM0g8lyWLX4CBkOPw4pOjo6OD/lrTW5Lf9isaMAfuNVhSkzBu1ndmkhBfzwLkZqrF05pj5XdDLigBb9X7B9u9AljdSTDyapk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9flyTDb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9flyTDb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8921F000FF;
	Thu, 17 Sep 2026 18:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789670387;
	bh=ag97WXIu/tWI+LVpUmCpJe8D/lUlwWiyecU/6sSSGHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N9flyTDbwkJEk61l+tm3jWKEd79ChSVZofLbsDDZlM9uBtCvqFSnrT+FQ4gKezHXe
	 3CE7Kvf4iesXmNYTkqG5XJA1e0HY/IPy/3fc2j+dFsZMTG3BFAZQPF9d6IrS+0HWeI
	 s/5YSzia7L7FmsBiLnJr5HuAvT8t2jCBKDl4KgMU+8gU8mZNJF+B5S49gf7lluuWUI
	 wIFASQJM1j9uvnHqvjkE9X40ZnFi0klcpnREGj+lMle3O1is/W8MpkvZBVqEpdVHu2
	 I3nl/LfeQ4qk6XY153rFQCGjXOz6Gc230GDtX8QASYf+J1STSiPjDHKwu878hmJq5X
	 sSz3zrJfuon/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ipv6: mcast: Don't hold RTNL for MCAST_ socket options.
Date: Thu, 17 Sep 2026 14:39:44 -0400
Message-ID: <20260917183945.1201473-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091758-subsector-deity-17bd@gregkh>
References: <2026091758-subsector-deity-17bd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit e6e14d582dd2cbee362c48a1865f8d03ca0a5611 ]

In ip6_mc_source() and ip6_mc_msfilter(), per-socket mld data is
protected by lock_sock() and inet6_dev->mc_lock is also held for
some per-interface functions.

ip6_mc_find_dev_rtnl() only depends on RTNL.  If we want to remove
it, we need to check inet6_dev->dead under mc_lock to close the race
with addrconf_ifdown(), as mentioned earlier.

Let's do that and drop RTNL for the rest of MCAST_ socket options.

Note that ip6_mc_msfilter() has unnecessary lock dances and they
are integrated into one to avoid the last-minute error and simplify
the error handling.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250702230210.3115355-10-kuni1840@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Backport adaptation for Linux 6.12:

Keep setsockopt_needs_rtnl() unchanged.  The stable multicast join and
drop paths still require RTNL, including source-group joins and the
leave-group cases in ip6_mc_source() and ip6_mc_msfilter().  The stable
addrconf_ifdown() also still publishes idev->dead outside mc_lock.
Retaining RTNL avoids depending on the missing multicast lock-removal
predecessors while keeping the referenced lookup and filter locking
changes needed by the target.

Move the existing multicast lookup before __ipv6_sock_mc_join(), matching
the location used by the target's parent.  A plain patch check succeeds
without this move, but a three-way cherry-pick otherwise sees the target
as modifying a deleted helper and conflicts.  Keep the helper's inet6_dev
return type and existing callers; no additional helper is introduced.

Prepare the existing ipv6_sock_ac_join() lookup for target commit
b775ecf1655cedbc465fd6699ab18a2bc4e7a352 as well: use dst_dev() under RCU,
take a tracked device reference before releasing the route, and balance
the references for the explicit-interface and fallback-device paths at
the common exit.  Keep its RTNL requirement and the existing device
lookup APIs.  This supplies the target's anycast context without adding
functions or importing the unrelated anycast lock-removal series.

[ sashal: Reduced backport -- upstream e6e14d582dd2c touches 2 file(s), this
  backport carries 2. Not backported here:
  net/ipv6/ipv6_sockglue.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: b775ecf1655c ("ipv6: start using dst_dev_rcu()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/anycast.c |  25 ++++++++---
 net/ipv6/mcast.c   | 108 ++++++++++++++++++++++++++-------------------
 2 files changed, 80 insertions(+), 53 deletions(-)

diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index 0627c4c18d1a5..19ab520ea049d 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -65,8 +65,9 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct net_device *dev = NULL;
 	struct inet6_dev *idev;
-	struct ipv6_ac_socklist *pac;
+	struct ipv6_ac_socklist *pac = NULL;
 	struct net *net = sock_net(sk);
+	netdevice_tracker dev_tracker;
 	int	ishost = !net->ipv6.devconf_all->forwarding;
 	int	err = 0;
 
@@ -78,32 +79,41 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 		return -EINVAL;
 
 	if (ifindex)
-		dev = __dev_get_by_index(net, ifindex);
+		dev = netdev_get_by_index(net, ifindex, &dev_tracker, GFP_KERNEL);
 
-	if (ipv6_chk_addr_and_flags(net, addr, dev, true, 0, IFA_F_TENTATIVE))
-		return -EINVAL;
+	if (ipv6_chk_addr_and_flags(net, addr, dev, true, 0, IFA_F_TENTATIVE)) {
+		err = -EINVAL;
+		goto error;
+	}
 
 	pac = sock_kmalloc(sk, sizeof(struct ipv6_ac_socklist), GFP_KERNEL);
-	if (!pac)
-		return -ENOMEM;
+	if (!pac) {
+		err = -ENOMEM;
+		goto error;
+	}
 	pac->acl_next = NULL;
 	pac->acl_addr = *addr;
 
 	if (ifindex == 0) {
 		struct rt6_info *rt;
 
+		rcu_read_lock();
 		rt = rt6_lookup(net, addr, NULL, 0, NULL, 0);
 		if (rt) {
-			dev = rt->dst.dev;
+			dev = dst_dev(&rt->dst);
+			netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
 			ip6_rt_put(rt);
 		} else if (ishost) {
+			rcu_read_unlock();
 			err = -EADDRNOTAVAIL;
 			goto error;
 		} else {
 			/* router, no matching interface: just pick one */
 			dev = __dev_get_by_flags(net, IFF_UP,
 						 IFF_UP | IFF_LOOPBACK);
+			netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
 		}
+		rcu_read_unlock();
 	}
 
 	if (!dev) {
@@ -144,6 +154,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 	}
 
 error:
+	netdev_put(dev, &dev_tracker);
 	if (pac)
 		sock_kfree_s(sk, pac, sizeof(*pac));
 	return err;
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 92f321635e4ec..8a37e878e5f8e 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -166,6 +166,39 @@ static int unsolicited_report_interval(struct inet6_dev *idev)
 	return iv > 0 ? iv : 1;
 }
 
+static struct inet6_dev *ip6_mc_find_dev(struct net *net,
+					 const struct in6_addr *group,
+					 int ifindex)
+{
+	struct net_device *dev = NULL;
+	struct inet6_dev *idev;
+
+	if (ifindex == 0) {
+		struct rt6_info *rt;
+
+		rcu_read_lock();
+		rt = rt6_lookup(net, group, NULL, 0, NULL, 0);
+		if (rt) {
+			dev = dst_dev(&rt->dst);
+			dev_hold(dev);
+			ip6_rt_put(rt);
+		}
+		rcu_read_unlock();
+	} else {
+		dev = dev_get_by_index(net, ifindex);
+	}
+	if (!dev)
+		return NULL;
+
+	idev = in6_dev_get(dev);
+	dev_put(dev);
+
+	if (!idev)
+		return NULL;
+
+	return idev;
+}
+
 /*
  *	socket join on multicast group
  */
@@ -290,34 +323,6 @@ int ipv6_sock_mc_drop(struct sock *sk, int ifindex, const struct in6_addr *addr)
 }
 EXPORT_SYMBOL(ipv6_sock_mc_drop);
 
-static struct inet6_dev *ip6_mc_find_dev_rtnl(struct net *net,
-					      const struct in6_addr *group,
-					      int ifindex)
-{
-	struct net_device *dev = NULL;
-	struct inet6_dev *idev = NULL;
-
-	if (ifindex == 0) {
-		struct rt6_info *rt = rt6_lookup(net, group, NULL, 0, NULL, 0);
-
-		if (rt) {
-			dev = rt->dst.dev;
-			ip6_rt_put(rt);
-		}
-	} else {
-		dev = __dev_get_by_index(net, ifindex);
-	}
-
-	if (!dev)
-		return NULL;
-	idev = __in6_dev_get(dev);
-	if (!idev)
-		return NULL;
-	if (idev->dead)
-		return NULL;
-	return idev;
-}
-
 void __ipv6_sock_mc_close(struct sock *sk)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
@@ -362,16 +367,16 @@ void ipv6_sock_mc_close(struct sock *sk)
 }
 
 int ip6_mc_source(int add, int omode, struct sock *sk,
-	struct group_source_req *pgsr)
+		  struct group_source_req *pgsr)
 {
+	struct ipv6_pinfo *inet6 = inet6_sk(sk);
 	struct in6_addr *source, *group;
+	struct net *net = sock_net(sk);
 	struct ipv6_mc_socklist *pmc;
-	struct inet6_dev *idev;
-	struct ipv6_pinfo *inet6 = inet6_sk(sk);
 	struct ip6_sf_socklist *psl;
-	struct net *net = sock_net(sk);
-	int i, j, rv;
+	struct inet6_dev *idev;
 	int leavegroup = 0;
+	int i, j, rv;
 	int err;
 
 	source = &((struct sockaddr_in6 *)&pgsr->gsr_source)->sin6_addr;
@@ -380,13 +385,19 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 	if (!ipv6_addr_is_multicast(group))
 		return -EINVAL;
 
-	idev = ip6_mc_find_dev_rtnl(net, group, pgsr->gsr_interface);
+	idev = ip6_mc_find_dev(net, group, pgsr->gsr_interface);
 	if (!idev)
 		return -ENODEV;
 
+	mutex_lock(&idev->mc_lock);
+
+	if (idev->dead) {
+		err = -ENODEV;
+		goto done;
+	}
+
 	err = -EADDRNOTAVAIL;
 
-	mutex_lock(&idev->mc_lock);
 	for_each_pmc_socklock(inet6, sk, pmc) {
 		if (pgsr->gsr_interface && pmc->ifindex != pgsr->gsr_interface)
 			continue;
@@ -483,6 +494,7 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 	ip6_mc_add_src(idev, group, omode, 1, source, 1);
 done:
 	mutex_unlock(&idev->mc_lock);
+	in6_dev_put(idev);
 	if (leavegroup)
 		err = ipv6_sock_mc_drop(sk, pgsr->gsr_interface, group);
 	return err;
@@ -491,12 +503,12 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 int ip6_mc_msfilter(struct sock *sk, struct group_filter *gsf,
 		    struct sockaddr_storage *list)
 {
-	const struct in6_addr *group;
-	struct ipv6_mc_socklist *pmc;
-	struct inet6_dev *idev;
 	struct ipv6_pinfo *inet6 = inet6_sk(sk);
 	struct ip6_sf_socklist *newpsl, *psl;
 	struct net *net = sock_net(sk);
+	const struct in6_addr *group;
+	struct ipv6_mc_socklist *pmc;
+	struct inet6_dev *idev;
 	int leavegroup = 0;
 	int i, err;
 
@@ -508,10 +520,17 @@ int ip6_mc_msfilter(struct sock *sk, struct group_filter *gsf,
 	    gsf->gf_fmode != MCAST_EXCLUDE)
 		return -EINVAL;
 
-	idev = ip6_mc_find_dev_rtnl(net, group, gsf->gf_interface);
+	idev = ip6_mc_find_dev(net, group, gsf->gf_interface);
 	if (!idev)
 		return -ENODEV;
 
+	mutex_lock(&idev->mc_lock);
+
+	if (idev->dead) {
+		err = -ENODEV;
+		goto done;
+	}
+
 	err = 0;
 
 	if (gsf->gf_fmode == MCAST_INCLUDE && gsf->gf_numsrc == 0) {
@@ -544,24 +563,19 @@ int ip6_mc_msfilter(struct sock *sk, struct group_filter *gsf,
 			psin6 = (struct sockaddr_in6 *)list;
 			newpsl->sl_addr[i] = psin6->sin6_addr;
 		}
-		mutex_lock(&idev->mc_lock);
+
 		err = ip6_mc_add_src(idev, group, gsf->gf_fmode,
 				     newpsl->sl_count, newpsl->sl_addr, 0);
 		if (err) {
-			mutex_unlock(&idev->mc_lock);
 			sock_kfree_s(sk, newpsl, struct_size(newpsl, sl_addr,
 							     newpsl->sl_max));
 			goto done;
 		}
-		mutex_unlock(&idev->mc_lock);
 	} else {
 		newpsl = NULL;
-		mutex_lock(&idev->mc_lock);
 		ip6_mc_add_src(idev, group, gsf->gf_fmode, 0, NULL, 0);
-		mutex_unlock(&idev->mc_lock);
 	}
 
-	mutex_lock(&idev->mc_lock);
 	psl = sock_dereference(pmc->sflist, sk);
 	if (psl) {
 		ip6_mc_del_src(idev, group, pmc->sfmode,
@@ -571,12 +585,14 @@ int ip6_mc_msfilter(struct sock *sk, struct group_filter *gsf,
 	} else {
 		ip6_mc_del_src(idev, group, pmc->sfmode, 0, NULL, 0);
 	}
+
 	rcu_assign_pointer(pmc->sflist, newpsl);
-	mutex_unlock(&idev->mc_lock);
 	kfree_rcu(psl, rcu);
 	pmc->sfmode = gsf->gf_fmode;
 	err = 0;
 done:
+	mutex_unlock(&idev->mc_lock);
+	in6_dev_put(idev);
 	if (leavegroup)
 		err = ipv6_sock_mc_drop(sk, gsf->gf_interface, group);
 	return err;
-- 
2.53.0

