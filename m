Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B7B3812DB
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789614839; cv=none; b=RDOL6XEICkyKVYCqXYs0/xaOoa4+JDZUKjW+qaOAp7UquPZPmYnaPX0VLFQByAm4sH0sq9AnXdjQSpHRLlkeT0tbLWaiymN6AaQcTl29VI+iB8GzD0k6Au4bl2Wo/BLd/TxBfKCdUKitz57pAimHYz1MZc5Jh9RszW5mrHZilcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789614839; c=relaxed/simple;
	bh=CtWBSCi8XcYM0O9EvEZY/t/ZoYjKR26fbR4Jm/ndR1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6eISYBgLMQ6ggdeJiWlLBSlp/FQgzJ5w0nIYoho6sARKUZcnLHDFWaiAGdV54ylF3FATEzTAPsoDv0Dlr8gIqdkEZC30BBfVmrlYEl6JOnFNtgex1+wlyBOlDyeBNZ+FdVEyQwSctDU7usfJCQyMyYxTf1C4wwNM1JOp04bXtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/YScU2r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/YScU2r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460191F00893;
	Thu, 17 Sep 2026 03:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789614838;
	bh=HVKpaBxfcb42Tz8iGJQephGjey8vpX4Oc1r4Mprm7XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l/YScU2rlC5WjHzH9Oh7ttaxkY53nLspAgNwJVg3O9mdJ1Mu2IdjQed7ZLCj/2RjL
	 lbtavOIFNbpsm71wZqWrPfpe5rS2JAHRA3rAF6gbGRCj3xSWTj72fMQ69hedPIewcO
	 OvK/q7yylULbo+4t12hZ6r5+tYgQqdME8Ne1WtyTf0brKXVZHqMB2H0e9IDHwMjdgQ
	 jDyQ04XsDqXh3CsiHPLlzYG2iq16nL8BFvVH8z6NoiwD2g0/WV6y0TVkh3PlrIMHv0
	 OIS4ej/QDJZuiy9ulQWnkVYnTOoED+243SY4DgRbbOy2k/95Cx7t66KdATG5daxWr/
	 KOf8G6GyjLKdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ido Schimmel <idosch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/5] ipv6: flowlabel: cap duplicate leases per socket
Date: Wed, 16 Sep 2026 23:13:52 -0400
Message-ID: <20260917031352.3971853-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917031352.3971853-1-sashal@kernel.org>
References: <2026091655-synthesis-number-1f2b@gregkh>
 <20260917031352.3971853-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

[ Upstream commit 8d6cd188508513503805c156165de38e4e4a8615 ]

ipv6_flowlabel_get() allocates an ipv6_fl_socklist entry for every
successful GET. The recheck path for a compatible existing flowlabel
links another lease without applying any lease admission check. Repeated
GET requests for one shareable label can therefore grow a socket's lease
list without bound.

Reject a new unprivileged lease once the socket already holds
FL_MAX_PER_SOCK leases. Check this on the shared recheck path so reuse
of a globally interned label, including the fl_intern() collision path,
is covered as well. New-label admission remains under the existing
mem_check() policy.

Use capable(CAP_NET_ADMIN) rather than ns_capable(), matching
mem_check(). An unprivileged user must not bypass the cap by creating a
user namespace and a netns where they have CAP_NET_ADMIN, which would
still consume host memory.

Check the capability only when the socket reaches the limit, so
successful unprivileged GET requests below the cap do not generate a
capability audit. Do the admission check before updating linger and
expires so a rejected GET does not refresh the shared label, matching
the existing socket-list allocation failure path.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/83f8535972ff6e3741548476a1d50dec24c758be.1788415194.git.zhilinz@nebusec.ai
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_flowlabel.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index 04ec8f0bda7d1..c004c687b2d18 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -462,6 +462,21 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 	return NULL;
 }
 
+static bool fl_sock_at_lease_limit(const struct sock *sk)
+{
+	const struct ipv6_fl_socklist *sfl;
+	int count = 0;
+
+	rcu_read_lock();
+	for_each_sk_fl_rcu(sk, sfl) {
+		if (++count >= FL_MAX_PER_SOCK)
+			break;
+	}
+	rcu_read_unlock();
+
+	return count >= FL_MAX_PER_SOCK;
+}
+
 static int mem_check(struct sock *sk)
 {
 	int room = FL_MAX_SIZE - atomic_read(&fl_size);
@@ -672,6 +687,10 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 			err = -ENOMEM;
 			if (!sfl1)
 				goto release;
+			err = -ENOBUFS;
+			if (fl_sock_at_lease_limit(sk) &&
+			    !capable(CAP_NET_ADMIN))
+				goto release;
 			if (fl->linger > fl1->linger)
 				fl1->linger = fl->linger;
 			if ((long)(fl->expires - fl1->expires) > 0)
-- 
2.53.0

