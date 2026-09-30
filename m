Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D5533BBCD
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781801; cv=none; b=NwoPe1ZwthUFlYJyD+XGoEdcY2scqOfyc8qBuMHzdiKD+LyC/bY0M6B31qViknsPwDAh67w2QCZzJoeJzRDMWeBWNZBrebg2593ngxladQLmASlkahq+z/oKz5JAhviQgladIuvO/gfVR8e85kHYGTfhAhLOaoMh3S/2JfTmDxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781801; c=relaxed/simple;
	bh=sdM5OqfoRJtAgwFkFqSFmLUbG2Nc3dHxv4AAkg6BVbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHghtneSGBkjiST8iiiPa4heoaX9Sl9k7M0DfDFtJmkGnEOZc8TdhU+P8XThQPoWcQgNIJDgrJ5ZfLPoqZWDSi8AIVI8yf7UON+o3heeLX7LJ0HQNCYzrMTtjlE71eIgZwUSTROd4fYM0Ukl/HikI7ceEuDqkuWcYiVwqOgZWFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=kn6Vmu0c; arc=none smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="kn6Vmu0c"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ab0c3c3af6so6738264a12.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 08:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1790781792; x=1791386592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dZiN99RMvoVLUY5C2k2n+LK4gqTaVAVijYhxlYv7sT8=;
        b=kn6Vmu0cWpKlboHA8mjFZfz8pzCN5pDEARsBWZ2BAvk1R5r4VwGkExL1o5nHNHX8kR
         LF1iWeKDT28Oc+ekMQJ5eqbb9LvuZJCMDVJA5j2Rms/qy40Ntx3v+VZgM5/uMUfOHWCQ
         xBWlSY/mNygvXevb+qw/Hi8WN+ECLD6yV4mPD6YEV+kbQgx/JVimZrfJ+376+E5Ng3kB
         cGhA0tzPjLv9YuE1CMSRClFEWsu3pfC+PC1hQD2xaFx8yvmaheH7cgSEWkgNcVWP4z8W
         Dz7jVNEUqdievka/P9MUgnccQJPpe92gR7Z395qjt2LWaNiRmRlPGk9jKF6K4laB9YtY
         0dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790781792; x=1791386592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dZiN99RMvoVLUY5C2k2n+LK4gqTaVAVijYhxlYv7sT8=;
        b=kuKNnlP2Ms/Bn33anYFImySxoihq5d0zYMNVSqvxP3SmtxMK5eafs5PmWEPzJFNHev
         BRg/3LGETCs7lQ1TZ/RXaTwc4gkFZijjBmHwPbWIgpooMVoP3F5uPf0uUghixW4ow1Lj
         j3Ao32dM0+3U3Z9YBw8OtDOUCx8yBBYn3aoar+mN5TicHDLn5PmQuRYuEg8B0PoY7gSw
         7aPc/wM2vLWuW7pStEmSujeRonr/jMiJy6OcqMA7iL1iuAXJ5nrm4KoLnr8kkerAqFLO
         bgRgCpmLiWXw113ZYZE2D/ZwBYUhDSaINOtTyW4mjxxrxtOVvhk58THpKJZAvm/S8XsQ
         PnWw==
X-Forwarded-Encrypted: i=1; AKwUvBxSnkalmUvYXpZbEZ1qwRVEInEzO/tzHe6ijHre3zMnbP8/MJDfSLFnDtq1jhq8kRx15/ceB48=@vger.kernel.org
X-Gm-Message-State: AFuF++mSZ9yaGp0r9PI4uUn8KwNzgSbkGtrclQ527teWb6b0kyQqfQ+M
	BmcEHXdeNawSLaDgh2Jl6hpXdaYhjOCnkxkgyftZR7Z2wc9+Sv7nfQcrPjpJLq+/7w==
X-Gm-Gg: AYBFou0IJi3TTmvrQ/hWCKnzNEAb2yv7SAXgiUVR25wRjRgZCYJ/mvaPA1dz9GR9z7x
	gHON4L+2SWliA5Z9BfsIUU1LKsLII+k1JEaCZ1O4bo5m4XM4WIcGxY9XgRY5u9upydvyLbM/Der
	6lTTKdtGQEUGOGEcN49WsH58GkA1KWQD3q0Wqtk5Ig4XYew1C25VV+d5FGaug8RJiLVPw5NfDY+
	bt29HFJ+FF4iZ2j9wJGwkExYpiOVq8yZu+w/Z/mkT871yBNAscFIa9HnSJtp3MPIaVBxZOI6xg+
	SKujVf/Cg/HnzBMQ1XQ5wimhyqna2WiS8uwnj6TZSJL7yROGJbUabOoS6uXp18bovJ15setsp/M
	wROwAdPjvy90KELKQi8G5nFAbPi2w6Ov8XYeHDJ4HJ9LTHx4o4cPXbO6duRlNDFozistS7s0LOO
	qTzkLfOi+Oeg5KvjMoiCk6KGz4C4mTrOhQQtMDbb/T/3+1AmLHXC6Vvpf33uDfTloyxS6Tdocnp
	qy2D44XAYMJyRkSQfHwlg==
X-Received: by 2002:a17:907:9688:b0:c29:5151:16b8 with SMTP id a640c23a62f3a-c2e23763c99mr142129866b.2.1790781791769;
        Wed, 30 Sep 2026 08:23:11 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31ce6499sm23874966b.33.2026.09.30.08.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:23:10 -0700 (PDT)
From: hengyul@cs.unc.edu
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hengyu Liang <hengyul@cs.unc.edu>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] ipv6: route: do not validate nexthop of routes promoted to reject routes
Date: Wed, 30 Sep 2026 11:22:28 -0400
Message-ID: <20260930152229.1453929-2-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930152229.1453929-1-hengyul@cs.unc.edu>
References: <20260930152229.1453929-1-hengyul@cs.unc.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hengyu Liang <hengyul@cs.unc.edu>

ip6_route_info_create_nh() promotes routes that use the loopback device
as their nexthop device to reject routes, except for local and anycast
routes and routes to the loopback address, as true routes via the
loopback device would result in kernel looping.

Before commit 21ec92774d15 ("net: ipv6: fix panic when IPv4 route
references loopback IPv6 nexthop"), fib6_nh_init() also treated these
routes as reject routes, so it neither validated their gateway nor
checked the state of the loopback device. That commit restricted the
check in fib6_nh_init() to explicit reject routes to fix IPv6 nexthop
objects that use the loopback device. As a side effect, the nexthop of a
route via the loopback device is now validated like the nexthop of a
regular route before the route is promoted to a reject route, and adding
such a route fails in cases that used to work:

  # ip link set dev lo down
  # ip -6 route add 2001:db8::/32 dev lo
  Error: Nexthop device is not up.
  # ip link set dev lo up
  # ip -6 route add 2001:db8::/32 via 2001:db8:1::1 dev lo
  RTNETLINK answers: No route to host
  # ip -6 route add default via ::ffff:192.0.2.1 dev lo
  RTNETLINK answers: No route to host
  # sysctl -qw net.ipv6.conf.lo.disable_ipv6=1
  # ip -6 route add 2001:db8::/32 dev lo
  Error: IPv6 is disabled on nexthop device.

As the loopback device is down in a new network namespace, the first
case affects routes added before the loopback device is brought up. The
SIOCADDRT ioctl fails in the same way.

Restore the previous check in fib6_nh_init() for routes created by
ip6_route_info_create_nh(). IPv6 nexthop objects and IPv4 routes with an
IPv6 gateway are never promoted to reject routes, so they keep the
current check and the panic fixed by the above commit does not come
back.

Fixes: 21ec92774d15 ("net: ipv6: fix panic when IPv4 route references loopback IPv6 nexthop")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
 net/ipv6/route.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 153ce16628c1..49ff87aa3756 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3592,13 +3592,14 @@ static bool fib6_is_reject(u32 flags, struct net_device *dev, int addr_type)
 	return false;
 }
 
-int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
-		 struct fib6_config *cfg, gfp_t gfp_flags,
-		 struct netlink_ext_ack *extack)
+static int __fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
+			  struct fib6_config *cfg, bool lo_reject,
+			  gfp_t gfp_flags, struct netlink_ext_ack *extack)
 {
 	netdevice_tracker *dev_tracker = &fib6_nh->fib_nh_dev_tracker;
 	struct net_device *dev = NULL;
 	struct inet6_dev *idev = NULL;
+	bool reject;
 	int err;
 
 	if (!ipv6_mod_enabled()) {
@@ -3646,9 +3647,17 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 	fib6_nh->fib_nh_weight = 1;
 
 	/* Reset the nexthop device to the loopback device in case of reject
-	 * routes.
+	 * routes. If requested, also treat routes via the loopback device as
+	 * reject routes, as ip6_route_info_create_nh() promotes them to reject
+	 * routes and their nexthop does not need to be validated.
 	 */
-	if (cfg->fc_flags & RTF_REJECT) {
+	if (lo_reject)
+		reject = fib6_is_reject(cfg->fc_flags, dev,
+					ipv6_addr_type(&cfg->fc_dst));
+	else
+		reject = cfg->fc_flags & RTF_REJECT;
+
+	if (reject) {
 		/* hold loopback dev/idev if we haven't done so. */
 		if (dev != net->loopback_dev) {
 			if (dev) {
@@ -3725,6 +3734,13 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 	return err;
 }
 
+int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
+		 struct fib6_config *cfg, gfp_t gfp_flags,
+		 struct netlink_ext_ack *extack)
+{
+	return __fib6_nh_init(net, fib6_nh, cfg, false, gfp_flags, extack);
+}
+
 void fib6_nh_release(struct fib6_nh *fib6_nh)
 {
 	struct rt6_exception_bucket *bucket;
@@ -3917,7 +3933,8 @@ static int ip6_route_info_create_nh(struct fib6_info *rt,
 	} else {
 		int addr_type;
 
-		err = fib6_nh_init(net, rt->fib6_nh, cfg, gfp_flags, extack);
+		err = __fib6_nh_init(net, rt->fib6_nh, cfg, true, gfp_flags,
+				     extack);
 		if (err)
 			goto out_release;
 
-- 
2.53.0

