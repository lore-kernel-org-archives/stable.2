Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E62BE033
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 04:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618102; cv=none; b=bfwphMQQF/gpUWDgI0lKVApZD7r9J9Vt92BxTdcHlqK4qsbhEphKlE54UmjPH2RqnUGjyMZ8BoKCCh3zyX0zYiRT8eSl2Mb/chdolp9Shh48hhdFrie1meHw7LSjQCVZW/X3hmsWbwIL/6/vmBB2WBZAjSitzg0LAWwI6NM0YSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618102; c=relaxed/simple;
	bh=GAAZwrVhuhFeWyO0AuK5ID14xJoFkgJCpOpiP67d89Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGrIFWidVfyl75EUEa+GZpTijb+utcCZIfbHbHjJEdH7/pwTCFqeuL/g2gZCH8qGzdwOwuqp99+Q+Rm1OWGLOoy2+YT5XVH0kH76gOrBFEb0yrSEIZmHnF/r1I/HlulBD4Bb9KkYZAcQimf3SZPvPlCvV4cfuw9Lks33rlO2BVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouJeETl8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouJeETl8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1951F00898;
	Thu, 17 Sep 2026 04:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618100;
	bh=fYTuO2ug3ICs2TcjzfOE3cQ9MsXnMVCbsvuhksEFPEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ouJeETl8dHErU33yjMUwYdqIR2zhOGDrbfegJ/hXIvZz5bjzTCsn3XMFKYulYJ4PW
	 gErSXOKhSQ1OorQYYCy2Nb8jL0K8lRFCMFNjRiXeLtP2XyZ8tAL4JthHX/ohTrf9OH
	 SBOIhuCK+QyAs7rz6c9nKLP9jX8rleSOMo74NDpsnYBkViL5MmtXPwb10I92YTuenl
	 D5F7WRiSYynJ3XtuXtLAoNSJrk6S/2AOuk7ovIFQDWFmQFGCjTfJoh0MqIPvPO7p7H
	 xBN0xGhwzcvmkHaM8OAYIdTDgz40u6d/7sdQB4GC3OhPe0l26CKi1p5B5dgjThdp65
	 JBIjFQ4EJEBIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/5] ipv6: Move ipv6_fl_list from ipv6_pinfo to inet_sock.
Date: Thu, 17 Sep 2026 00:08:14 -0400
Message-ID: <20260917040815.4171498-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917040815.4171498-1-sashal@kernel.org>
References: <2026091657-voter-although-5ad8@gregkh>
 <20260917040815.4171498-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 1c17f4373d4db1e1f0ebd3ddcd8e7a642927a826 ]

In {tcp6,udp6,raw6}_sock, struct ipv6_pinfo is always placed at
the beginning of a new cache line because

  1. __alignof__(struct tcp_sock) is 64 due to ____cacheline_aligned
     of __cacheline_group_begin(tcp_sock_write_tx)

  2. __alignof__(struct udp_sock) is 64 due to ____cacheline_aligned
     of struct numa_drop_counters

  3. in raw6_sock, struct numa_drop_counters is placed before
     struct ipv6_pinfo

.  struct ipv6_pinfo is 136 bytes, but the last cache line is
only used by ipv6_fl_list:

  $ pahole -C ipv6_pinfo vmlinux
  struct ipv6_pinfo {
  ...
  	/* --- cacheline 2 boundary (128 bytes) --- */
  	struct ipv6_fl_socklist *  ipv6_fl_list;         /*   128     8 */

  	/* size: 136, cachelines: 3, members: 23 */

Let's move ipv6_fl_list from struct ipv6_pinfo to struct inet_sock
to save a full cache line for {tcp6,udp6,raw6}_sock.

Now, struct ipv6_pinfo is 128 bytes, and {tcp6,udp6,raw6}_sock have
64 bytes less, while {tcp,udp,raw}_sock retain the same size.

Before:

  # grep -E "^(RAW|UDP[^L\-]|TCP)" /proc/slabinfo | awk '{print $1, "\t", $4}'
  RAWv6 	 1408
  UDPv6 	 1472
  TCPv6 	 2560
  RAW 		 1152
  UDP	 	 1280
  TCP 		 2368

After:

  # grep -E "^(RAW|UDP[^L\-]|TCP)" /proc/slabinfo | awk '{print $1, "\t", $4}'
  RAWv6 	 1344
  UDPv6 	 1408
  TCPv6 	 2496
  RAW 		 1152
  UDP	 	 1280
  TCP 		 2368

Also, ipv6_fl_list and inet_flags (SNDFLOW bit) are placed in the
same cache line.

  $ pahole -C inet_sock vmlinux
  ...
  	/* --- cacheline 11 boundary (704 bytes) was 56 bytes ago --- */
  	struct ipv6_pinfo *        pinet6;               /*   760     8 */
  	/* --- cacheline 12 boundary (768 bytes) --- */
  	struct ipv6_fl_socklist *  ipv6_fl_list;         /*   768     8 */
  	unsigned long              inet_flags;           /*   776     8 */

Doc churn is due to the insufficient Type column (only 1 space short).

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20251014224210.2964778-1-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Backport notes for Linux 6.1:
- Keep this dependency to provide the socket-based flowlabel iterator used
  by 8d6cd1885085 ("ipv6: flowlabel: cap duplicate leases per socket").
- Omit the cacheline documentation, which does not exist in this tree.
  Preserve the stable ipv6_pinfo layout apart from moving ipv6_fl_list;
  the upstream size/cacheline measurements above are not asserted here.
- Clear the relocated list in the existing tcp_v6_mapped_child_init()
  callback and in both DCCP child paths. DCCP still exists in 6.1 but had
  already been removed when the upstream dependency was written.
- Retain ipv6_flowlabel_get()'s ipv6_pinfo pointer for the stable repflow
  bit. This tree has not moved that bit to inet_sock atomic flags.
- Use ordinary RCU for the socket-list iterator and its readers, as the
  target's new reader uses rcu_read_lock(). Keep the hash-table BH locking
  and all writer locking unchanged.
- Name the existing global unprivileged limit in mem_check() to match the
  target's patch context. The admission test is algebraically equivalent;
  retain the 4096-entry table and existing atomic accounting.

No functions are added by this dependency.

[ sashal: Reduced backport -- upstream 1c17f4373d4db touches 7 file(s), this
  backport carries 7. Not backported here:
  Documentation/networking/net_cachelines/inet_sock.rst
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 8d6cd1885085 ("ipv6: flowlabel: cap duplicate leases per socket")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../chelsio/inline_crypto/chtls/chtls_cm.c    |  4 +-
 include/linux/ipv6.h                          |  1 -
 include/net/inet_sock.h                       |  1 +
 net/dccp/ipv6.c                               |  4 +-
 net/ipv6/ip6_flowlabel.c                      | 77 ++++++++++---------
 net/ipv6/tcp_ipv6.c                           | 10 +--
 net/sctp/ipv6.c                               |  8 +-
 7 files changed, 54 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
index 65d4a39634be4..83f1b39b3b88c 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
@@ -1198,12 +1198,12 @@ static struct sock *chtls_recv_sock(struct sock *lsk,
 		struct ipv6_pinfo *newnp = inet6_sk(newsk);
 		struct ipv6_pinfo *np = inet6_sk(lsk);
 
-		inet_sk(newsk)->pinet6 = &newtcp6sk->inet6;
+		newinet->pinet6 = &newtcp6sk->inet6;
+		newinet->ipv6_fl_list = NULL;
 		memcpy(newnp, np, sizeof(struct ipv6_pinfo));
 		newsk->sk_v6_daddr = treq->ir_v6_rmt_addr;
 		newsk->sk_v6_rcv_saddr = treq->ir_v6_loc_addr;
 		inet6_sk(newsk)->saddr = treq->ir_v6_loc_addr;
-		newnp->ipv6_fl_list = NULL;
 		newnp->pktoptions = NULL;
 		newsk->sk_bound_dev_if = treq->ir_iif;
 		newinet->inet_opt = NULL;
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index c27c9efcfab83..844f09ea2eb03 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -288,7 +288,6 @@ struct ipv6_pinfo {
 
 	struct ipv6_mc_socklist	__rcu *ipv6_mc_list;
 	struct ipv6_ac_socklist	*ipv6_ac_list;
-	struct ipv6_fl_socklist __rcu *ipv6_fl_list;
 
 	struct ipv6_txoptions __rcu	*opt;
 	struct sk_buff		*pktoptions;
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 2c2b41ea7f81d..c491627b9d061 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -210,6 +210,7 @@ struct inet_sock {
 	struct sock		sk;
 #if IS_ENABLED(CONFIG_IPV6)
 	struct ipv6_pinfo	*pinet6;
+	struct ipv6_fl_socklist __rcu *ipv6_fl_list;
 #endif
 	/* Socket demultiplex comparisons on incoming packets. */
 #define inet_daddr		sk.__sk_common.skc_daddr
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 572b95da0309d..6c9957f53b17b 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -441,6 +441,7 @@ static struct sock *dccp_v6_request_recv_sock(const struct sock *sk,
 		newdp6 = (struct dccp6_sock *)newsk;
 		newinet = inet_sk(newsk);
 		newinet->pinet6 = &newdp6->inet6;
+		newinet->ipv6_fl_list = NULL;
 		newnp = inet6_sk(newsk);
 
 		memcpy(newnp, np, sizeof(struct ipv6_pinfo));
@@ -453,7 +454,6 @@ static struct sock *dccp_v6_request_recv_sock(const struct sock *sk,
 		newnp->opt	   = NULL;
 		newnp->ipv6_mc_list = NULL;
 		newnp->ipv6_ac_list = NULL;
-		newnp->ipv6_fl_list = NULL;
 		newnp->mcast_oif   = inet_iif(skb);
 		newnp->mcast_hops  = ip_hdr(skb)->ttl;
 
@@ -500,6 +500,7 @@ static struct sock *dccp_v6_request_recv_sock(const struct sock *sk,
 	newdp6 = (struct dccp6_sock *)newsk;
 	newinet = inet_sk(newsk);
 	newinet->pinet6 = &newdp6->inet6;
+	newinet->ipv6_fl_list = NULL;
 	newnp = inet6_sk(newsk);
 
 	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
@@ -520,7 +521,6 @@ static struct sock *dccp_v6_request_recv_sock(const struct sock *sk,
 
 	newnp->ipv6_mc_list = NULL;
 	newnp->ipv6_ac_list = NULL;
-	newnp->ipv6_fl_list = NULL;
 	newnp->pktoptions = NULL;
 	newnp->opt	  = NULL;
 	newnp->mcast_oif  = inet6_iif(skb);
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index bb528d0ddb73a..731d28be6e304 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -66,10 +66,10 @@ EXPORT_SYMBOL(ipv6_flowlabel_exclusive);
 	     fl != NULL;					\
 	     fl = rcu_dereference_bh(fl->next))
 
-#define for_each_sk_fl_rcu(np, sfl)				\
-	for (sfl = rcu_dereference_bh(np->ipv6_fl_list);	\
+#define for_each_sk_fl_rcu(sk, sfl)				\
+	for (sfl = rcu_dereference(inet_sk(sk)->ipv6_fl_list);	\
 	     sfl != NULL;					\
-	     sfl = rcu_dereference_bh(sfl->next))
+	     sfl = rcu_dereference(sfl->next))
 
 static inline struct ip6_flowlabel *__fl_lookup(struct net *net, __be32 label)
 {
@@ -254,37 +254,36 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 struct ip6_flowlabel *__fl6_sock_lookup(struct sock *sk, __be32 label)
 {
 	struct ipv6_fl_socklist *sfl;
-	struct ipv6_pinfo *np = inet6_sk(sk);
 
 	label &= IPV6_FLOWLABEL_MASK;
 
-	rcu_read_lock_bh();
-	for_each_sk_fl_rcu(np, sfl) {
+	rcu_read_lock();
+	for_each_sk_fl_rcu(sk, sfl) {
 		struct ip6_flowlabel *fl = sfl->fl;
 
 		if (fl->label == label && atomic_inc_not_zero(&fl->users)) {
 			fl->lastuse = jiffies;
-			rcu_read_unlock_bh();
+			rcu_read_unlock();
 			return fl;
 		}
 	}
-	rcu_read_unlock_bh();
+	rcu_read_unlock();
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(__fl6_sock_lookup);
 
 void fl6_free_socklist(struct sock *sk)
 {
-	struct ipv6_pinfo *np = inet6_sk(sk);
+	struct inet_sock *inet = inet_sk(sk);
 	struct ipv6_fl_socklist *sfl;
 
-	if (!rcu_access_pointer(np->ipv6_fl_list))
+	if (!rcu_access_pointer(inet->ipv6_fl_list))
 		return;
 
 	spin_lock_bh(&ip6_sk_fl_lock);
-	while ((sfl = rcu_dereference_protected(np->ipv6_fl_list,
+	while ((sfl = rcu_dereference_protected(inet->ipv6_fl_list,
 						lockdep_is_held(&ip6_sk_fl_lock))) != NULL) {
-		np->ipv6_fl_list = sfl->next;
+		inet->ipv6_fl_list = sfl->next;
 		spin_unlock_bh(&ip6_sk_fl_lock);
 
 		fl_release(sfl->fl);
@@ -462,35 +461,38 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 
 static int mem_check(struct sock *sk)
 {
-	struct ipv6_pinfo *np = inet6_sk(sk);
-	struct ipv6_fl_socklist *sfl;
+	const int unpriv_total_limit = FL_MAX_SIZE - (FL_MAX_SIZE / 4);
 	int room = FL_MAX_SIZE - atomic_read(&fl_size);
+	struct ipv6_fl_socklist *sfl;
 	int count = 0;
 
 	if (room > FL_MAX_SIZE - FL_MAX_PER_SOCK)
 		return 0;
 
-	rcu_read_lock_bh();
-	for_each_sk_fl_rcu(np, sfl)
+	rcu_read_lock();
+	for_each_sk_fl_rcu(sk, sfl)
 		count++;
-	rcu_read_unlock_bh();
+	rcu_read_unlock();
 
 	if (room <= 0 ||
 	    ((count >= FL_MAX_PER_SOCK ||
-	      (count > 0 && room < FL_MAX_SIZE/2) || room < FL_MAX_SIZE/4) &&
+	      (count > 0 && room < FL_MAX_SIZE / 2) ||
+	      FL_MAX_SIZE - room > unpriv_total_limit) &&
 	     !capable(CAP_NET_ADMIN)))
 		return -ENOBUFS;
 
 	return 0;
 }
 
-static inline void fl_link(struct ipv6_pinfo *np, struct ipv6_fl_socklist *sfl,
-		struct ip6_flowlabel *fl)
+static inline void fl_link(struct sock *sk, struct ipv6_fl_socklist *sfl,
+			   struct ip6_flowlabel *fl)
 {
+	struct inet_sock *inet = inet_sk(sk);
+
 	spin_lock_bh(&ip6_sk_fl_lock);
 	sfl->fl = fl;
-	sfl->next = np->ipv6_fl_list;
-	rcu_assign_pointer(np->ipv6_fl_list, sfl);
+	sfl->next = inet->ipv6_fl_list;
+	rcu_assign_pointer(inet->ipv6_fl_list, sfl);
 	spin_unlock_bh(&ip6_sk_fl_lock);
 }
 
@@ -510,9 +512,9 @@ int ipv6_flowlabel_opt_get(struct sock *sk, struct in6_flowlabel_req *freq,
 		return 0;
 	}
 
-	rcu_read_lock_bh();
+	rcu_read_lock();
 
-	for_each_sk_fl_rcu(np, sfl) {
+	for_each_sk_fl_rcu(sk, sfl) {
 		if (sfl->fl->label == (np->flow_label & IPV6_FLOWLABEL_MASK)) {
 			spin_lock_bh(&ip6_fl_lock);
 			freq->flr_label = sfl->fl->label;
@@ -522,11 +524,11 @@ int ipv6_flowlabel_opt_get(struct sock *sk, struct in6_flowlabel_req *freq,
 			freq->flr_linger = sfl->fl->linger / HZ;
 
 			spin_unlock_bh(&ip6_fl_lock);
-			rcu_read_unlock_bh();
+			rcu_read_unlock();
 			return 0;
 		}
 	}
-	rcu_read_unlock_bh();
+	rcu_read_unlock();
 
 	return -ENOENT;
 }
@@ -551,7 +553,7 @@ static int ipv6_flowlabel_put(struct sock *sk, struct in6_flowlabel_req *freq)
 	}
 
 	spin_lock_bh(&ip6_sk_fl_lock);
-	for (sflp = &np->ipv6_fl_list;
+	for (sflp = &inet_sk(sk)->ipv6_fl_list;
 	     (sfl = socklist_dereference(*sflp)) != NULL;
 	     sflp = &sfl->next) {
 		if (sfl->fl->label == freq->flr_label)
@@ -571,21 +573,20 @@ static int ipv6_flowlabel_put(struct sock *sk, struct in6_flowlabel_req *freq)
 
 static int ipv6_flowlabel_renew(struct sock *sk, struct in6_flowlabel_req *freq)
 {
-	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct net *net = sock_net(sk);
 	struct ipv6_fl_socklist *sfl;
 	int err;
 
-	rcu_read_lock_bh();
-	for_each_sk_fl_rcu(np, sfl) {
+	rcu_read_lock();
+	for_each_sk_fl_rcu(sk, sfl) {
 		if (sfl->fl->label == freq->flr_label) {
 			err = fl6_renew(sfl->fl, freq->flr_linger,
 					freq->flr_expires);
-			rcu_read_unlock_bh();
+			rcu_read_unlock();
 			return err;
 		}
 	}
-	rcu_read_unlock_bh();
+	rcu_read_unlock();
 
 	if (freq->flr_share == IPV6_FL_S_NONE &&
 	    ns_capable(net->user_ns, CAP_NET_ADMIN)) {
@@ -636,11 +637,11 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 
 	if (freq->flr_label) {
 		err = -EEXIST;
-		rcu_read_lock_bh();
-		for_each_sk_fl_rcu(np, sfl) {
+		rcu_read_lock();
+		for_each_sk_fl_rcu(sk, sfl) {
 			if (sfl->fl->label == freq->flr_label) {
 				if (freq->flr_flags & IPV6_FL_F_EXCL) {
-					rcu_read_unlock_bh();
+					rcu_read_unlock();
 					goto done;
 				}
 				fl1 = sfl->fl;
@@ -649,7 +650,7 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 				break;
 			}
 		}
-		rcu_read_unlock_bh();
+		rcu_read_unlock();
 
 		if (!fl1)
 			fl1 = fl_lookup(net, freq->flr_label);
@@ -674,7 +675,7 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 				fl1->linger = fl->linger;
 			if ((long)(fl->expires - fl1->expires) > 0)
 				fl1->expires = fl->expires;
-			fl_link(np, sfl1, fl1);
+			fl_link(sk, sfl1, fl1);
 			fl_free(fl);
 			return 0;
 
@@ -708,7 +709,7 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 		}
 	}
 
-	fl_link(np, sfl1, fl);
+	fl_link(sk, sfl1, fl);
 	return 0;
 done:
 	fl_free(fl);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 501f81939257f..31914804f6c83 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1241,6 +1241,7 @@ static void tcp_v6_mapped_child_init(struct sock *newsk, const struct sock *sk)
 	struct ipv6_pinfo *newnp;
 
 	newinet->pinet6 = newnp = tcp_inet6_sk(newsk);
+	newinet->ipv6_fl_list = NULL;
 
 	memcpy(newnp, tcp_inet6_sk(sk), sizeof(struct ipv6_pinfo));
 
@@ -1256,7 +1257,6 @@ static void tcp_v6_mapped_child_init(struct sock *newsk, const struct sock *sk)
 
 	newnp->ipv6_mc_list = NULL;
 	newnp->ipv6_ac_list = NULL;
-	newnp->ipv6_fl_list = NULL;
 	newnp->pktoptions  = NULL;
 	newnp->opt	   = NULL;
 
@@ -1319,10 +1319,12 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	newsk->sk_gso_type = SKB_GSO_TCPV6;
 	inet6_sk_rx_dst_set(newsk, skb);
 
-	inet_sk(newsk)->pinet6 = tcp_inet6_sk(newsk);
+	newinet = inet_sk(newsk);
+	newinet->pinet6 = tcp_inet6_sk(newsk);
+	newinet->ipv6_fl_list = NULL;
+	newinet->inet_opt = NULL;
 
 	newtp = tcp_sk(newsk);
-	newinet = inet_sk(newsk);
 	newnp = tcp_inet6_sk(newsk);
 
 	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
@@ -1338,10 +1340,8 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	   First: no IPv4 options.
 	 */
-	newinet->inet_opt = NULL;
 	newnp->ipv6_mc_list = NULL;
 	newnp->ipv6_ac_list = NULL;
-	newnp->ipv6_fl_list = NULL;
 
 	/* Clone RX bits */
 	newnp->rxopt.all = np->rxopt.all;
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 107255d92037f..4354e56350dd1 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -767,9 +767,10 @@ static struct sock *sctp_v6_create_accept_sk(struct sock *sk,
 					     struct sctp_association *asoc,
 					     bool kern)
 {
-	struct sock *newsk;
 	struct ipv6_pinfo *newnp, *np = inet6_sk(sk);
 	struct sctp6_sock *newsctp6sk;
+	struct inet_sock *newinet;
+	struct sock *newsk;
 
 	newsk = sk_alloc(sock_net(sk), PF_INET6, GFP_KERNEL, sk->sk_prot, kern);
 	if (!newsk)
@@ -781,7 +782,9 @@ static struct sock *sctp_v6_create_accept_sk(struct sock *sk,
 	sock_reset_flag(sk, SOCK_ZAPPED);
 
 	newsctp6sk = (struct sctp6_sock *)newsk;
-	inet_sk(newsk)->pinet6 = &newsctp6sk->inet6;
+	newinet = inet_sk(newsk);
+	newinet->pinet6 = &newsctp6sk->inet6;
+	newinet->ipv6_fl_list = NULL;
 
 	sctp_sk(newsk)->v4mapped = sctp_sk(sk)->v4mapped;
 
@@ -790,7 +793,6 @@ static struct sock *sctp_v6_create_accept_sk(struct sock *sk,
 	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
 	newnp->ipv6_mc_list = NULL;
 	newnp->ipv6_ac_list = NULL;
-	newnp->ipv6_fl_list = NULL;
 
 	sctp_v6_copy_ip_options(sk, newsk);
 
-- 
2.53.0

