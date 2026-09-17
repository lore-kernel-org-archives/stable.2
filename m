Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B72383C84
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611549; cv=none; b=fCieUZAD9hvOScolYfYb8ZY4ubOkESkLLu0L/d8PJZ4KKer304tVdLbMfn15YvJuakhcxajXHw5l2HMnm3JGO0ztalDYaChK29BgyjKbMgRxk8J8DxpXf+/J1sW9kA4pnJpQkfM8t1c4N5RVBGj5yKvUMPamNGWqR48B0p6sYis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611549; c=relaxed/simple;
	bh=y7QcHBfBVu6LIIDtKLXQ+1QCqw5spegpUnFekZ+TD/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osXE+uLAXsd6T6x6ZDppwN3GIU7bbjNznfj/xUhEB6W+wPgl2gFTJOSfY9iCn7nptTa6SNnT2K4GjNzRIIySOLQBbAzVIa7VK93NfjMjhAJgL8YX2LzZ+hoftQ0I0KOZz9x1KOyP36b5LfhE2/XJ/ZRaQgQ8Le/+MbE+9wheGss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWZseoRZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWZseoRZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44821F0089B;
	Thu, 17 Sep 2026 02:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611546;
	bh=Xoj4xKw1rTgkmU0NhU3rnV1IQdIGjMBhSDFVI8hN/5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DWZseoRZyGrMy/JFonvQMZWSvrwu+DjRoXZNB+pVEvvjfgEIFYGErLQlMvxzuejI9
	 resOZezXwbo3DoWjSk7fIb5UQLDbQtBh6f5IRIwo08I4Tm6w4nQy3qTZsdE11IVeMF
	 n2QSjZZoWFfsPJLLl13xAYduQ/Gn4kcQP+X9Ao9ZELYSaEncrNYVMbRHBdiQdupCze
	 4GY+iUaMgFWoWZCKPoZ9pcRA/IvlIZms+nFTe0E0UpCrSkF0ZEz1JqPb4jHxeryvRQ
	 t7Vj+2jnPfOE8cqZMf6Mky7Lgg+CeGYyDyEST9JWvXdJ5N90zpCd/d80SrTy5GdK0V
	 U4gWE442dBSQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 6/7] ipv6: Move ipv6_fl_list from ipv6_pinfo to inet_sock.
Date: Wed, 16 Sep 2026 22:18:58 -0400
Message-ID: <20260917021859.3810309-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917021859.3810309-1-sashal@kernel.org>
References: <2026091655-dejected-hammock-755e@gregkh>
 <20260917021859.3810309-1-sashal@kernel.org>
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

Stable adaptation:

Keep the stable TCP mapped-child initialization callback introduced by
9ed654e340f4c ("tcp: fix potential race in tcp_v6_syn_recv_sock()") and
reset the relocated flowlabel list in that existing helper. Update both
DCCP child paths too, since DCCP is still present in this tree. Preserve
the existing cacheline-documentation format and add only the new field.

Name the existing unprivileged total limit in mem_check() and use it in
an algebraically equivalent room check. This supplies the context needed
by 8d6cd1885085 ("ipv6: flowlabel: cap duplicate leases per socket")
without importing the later per-netns accounting or changing admission
policy. No new functions are introduced by this dependency.

Stable-dep-of: 8d6cd1885085 ("ipv6: flowlabel: cap duplicate leases per socket")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../networking/net_cachelines/inet_sock.rst   |  1 +
 .../chelsio/inline_crypto/chtls/chtls_cm.c    |  4 +-
 include/linux/ipv6.h                          |  1 -
 include/net/inet_sock.h                       |  1 +
 net/dccp/ipv6.c                               |  4 +-
 net/ipv6/ip6_flowlabel.c                      | 48 +++++++++----------
 net/ipv6/tcp_ipv6.c                           | 10 ++--
 net/sctp/ipv6.c                               |  8 ++--
 8 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/Documentation/networking/net_cachelines/inet_sock.rst b/Documentation/networking/net_cachelines/inet_sock.rst
index 595d7ef5fc8b0..2485ef9cdd7dc 100644
--- a/Documentation/networking/net_cachelines/inet_sock.rst
+++ b/Documentation/networking/net_cachelines/inet_sock.rst
@@ -9,6 +9,7 @@ Type                    Name                  fastpath_tx_access  fastpath_rx_ac
 ..struct                ..inet_sock                                                     
 struct_sock             sk                    read_mostly         read_mostly         tcp_init_buffer_space,tcp_init_transfer,tcp_finish_connect,tcp_connect,tcp_send_rcvq,tcp_send_syn_data
 struct_ipv6_pinfo*      pinet6                -                   -                   
+struct_ipv6_fl_socklist* ipv6_fl_list         read_mostly         -                   tcp_v6_connect,__ip6_datagram_connect,udpv6_sendmsg,rawv6_sendmsg
 be16                    inet_sport            read_mostly         -                   __tcp_transmit_skb
 be32                    inet_daddr            read_mostly         -                   ip_select_ident_segs
 be32                    inet_rcv_saddr        -                   -                   
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
index 6f6525983130e..6d69c19ea7c30 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
@@ -1197,12 +1197,12 @@ static struct sock *chtls_recv_sock(struct sock *lsk,
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
index 0ac14eab99e74..ad5f09765e0c7 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -269,7 +269,6 @@ struct ipv6_pinfo {
 
 	struct ipv6_mc_socklist	__rcu *ipv6_mc_list;
 	struct ipv6_ac_socklist	*ipv6_ac_list;
-	struct ipv6_fl_socklist __rcu *ipv6_fl_list;
 };
 
 /* We currently use available bits from inet_sk(sk)->inet_flags,
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 394c3b66065e2..ad7e740c6441a 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -212,6 +212,7 @@ struct inet_sock {
 	struct sock		sk;
 #if IS_ENABLED(CONFIG_IPV6)
 	struct ipv6_pinfo	*pinet6;
+	struct ipv6_fl_socklist __rcu *ipv6_fl_list;
 #endif
 	/* Socket demultiplex comparisons on incoming packets. */
 #define inet_daddr		sk.__sk_common.skc_daddr
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index c1db853667479..3c43dd8561f8e 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -456,7 +456,7 @@ static struct sock *dccp_v6_request_recv_sock(const struct sock *sk,
 		newnp->opt	   = NULL;
 		newnp->ipv6_mc_list = NULL;
 		newnp->ipv6_ac_list = NULL;
-		newnp->ipv6_fl_list = NULL;
+		newinet->ipv6_fl_list = NULL;
 		newnp->mcast_oif   = inet_iif(skb);
 		newnp->mcast_hops  = ip_hdr(skb)->ttl;
 
@@ -523,7 +523,7 @@ static struct sock *dccp_v6_request_recv_sock(const struct sock *sk,
 
 	newnp->ipv6_mc_list = NULL;
 	newnp->ipv6_ac_list = NULL;
-	newnp->ipv6_fl_list = NULL;
+	newinet->ipv6_fl_list = NULL;
 	newnp->pktoptions = NULL;
 	newnp->opt	  = NULL;
 	newnp->mcast_oif  = inet6_iif(skb);
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index 9d06d6a50c6d2..ad9210266b77e 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -66,8 +66,8 @@ EXPORT_SYMBOL(ipv6_flowlabel_exclusive);
 	     fl != NULL;					\
 	     fl = rcu_dereference(fl->next))
 
-#define for_each_sk_fl_rcu(np, sfl)				\
-	for (sfl = rcu_dereference(np->ipv6_fl_list);	\
+#define for_each_sk_fl_rcu(sk, sfl)				\
+	for (sfl = rcu_dereference(inet_sk(sk)->ipv6_fl_list);	\
 	     sfl != NULL;					\
 	     sfl = rcu_dereference(sfl->next))
 
@@ -257,12 +257,11 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 struct ip6_flowlabel *__fl6_sock_lookup(struct sock *sk, __be32 label)
 {
 	struct ipv6_fl_socklist *sfl;
-	struct ipv6_pinfo *np = inet6_sk(sk);
 
 	label &= IPV6_FLOWLABEL_MASK;
 
 	rcu_read_lock();
-	for_each_sk_fl_rcu(np, sfl) {
+	for_each_sk_fl_rcu(sk, sfl) {
 		struct ip6_flowlabel *fl = sfl->fl;
 
 		if (fl->label == label && atomic_inc_not_zero(&fl->users)) {
@@ -278,16 +277,16 @@ EXPORT_SYMBOL_GPL(__fl6_sock_lookup);
 
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
@@ -465,35 +464,38 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 
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
 
 	rcu_read_lock();
-	for_each_sk_fl_rcu(np, sfl)
+	for_each_sk_fl_rcu(sk, sfl)
 		count++;
 	rcu_read_unlock();
 
 	if (room <= 0 ||
 	    ((count >= FL_MAX_PER_SOCK ||
-	      (count > 0 && room < FL_MAX_SIZE/2) || room < FL_MAX_SIZE/4) &&
+	      (count > 0 && room < FL_MAX_SIZE / 2) ||
+	      room < FL_MAX_SIZE - unpriv_total_limit) &&
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
 
@@ -515,7 +517,7 @@ int ipv6_flowlabel_opt_get(struct sock *sk, struct in6_flowlabel_req *freq,
 
 	rcu_read_lock();
 
-	for_each_sk_fl_rcu(np, sfl) {
+	for_each_sk_fl_rcu(sk, sfl) {
 		if (sfl->fl->label == (np->flow_label & IPV6_FLOWLABEL_MASK)) {
 			spin_lock_bh(&ip6_fl_lock);
 			freq->flr_label = sfl->fl->label;
@@ -554,7 +556,7 @@ static int ipv6_flowlabel_put(struct sock *sk, struct in6_flowlabel_req *freq)
 	}
 
 	spin_lock_bh(&ip6_sk_fl_lock);
-	for (sflp = &np->ipv6_fl_list;
+	for (sflp = &inet_sk(sk)->ipv6_fl_list;
 	     (sfl = socklist_dereference(*sflp)) != NULL;
 	     sflp = &sfl->next) {
 		if (sfl->fl->label == freq->flr_label)
@@ -574,13 +576,12 @@ static int ipv6_flowlabel_put(struct sock *sk, struct in6_flowlabel_req *freq)
 
 static int ipv6_flowlabel_renew(struct sock *sk, struct in6_flowlabel_req *freq)
 {
-	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct net *net = sock_net(sk);
 	struct ipv6_fl_socklist *sfl;
 	int err;
 
 	rcu_read_lock();
-	for_each_sk_fl_rcu(np, sfl) {
+	for_each_sk_fl_rcu(sk, sfl) {
 		if (sfl->fl->label == freq->flr_label) {
 			err = fl6_renew(sfl->fl, freq->flr_linger,
 					freq->flr_expires);
@@ -609,7 +610,6 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 {
 	struct ipv6_fl_socklist *sfl, *sfl1 = NULL;
 	struct ip6_flowlabel *fl, *fl1 = NULL;
-	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct net *net = sock_net(sk);
 	int err;
 
@@ -640,7 +640,7 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 	if (freq->flr_label) {
 		err = -EEXIST;
 		rcu_read_lock();
-		for_each_sk_fl_rcu(np, sfl) {
+		for_each_sk_fl_rcu(sk, sfl) {
 			if (sfl->fl->label == freq->flr_label) {
 				if (freq->flr_flags & IPV6_FL_F_EXCL) {
 					rcu_read_unlock();
@@ -677,7 +677,7 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 				fl1->linger = fl->linger;
 			if ((long)(fl->expires - fl1->expires) > 0)
 				fl1->expires = fl->expires;
-			fl_link(np, sfl1, fl1);
+			fl_link(sk, sfl1, fl1);
 			fl_free(fl);
 			return 0;
 
@@ -711,7 +711,7 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 		}
 	}
 
-	fl_link(np, sfl1, fl);
+	fl_link(sk, sfl1, fl);
 	return 0;
 done:
 	fl_free(fl);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 61192ecc5c18b..3b3f8741dbd7e 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1348,6 +1348,7 @@ static void tcp_v6_mapped_child_init(struct sock *newsk, const struct sock *sk)
 	struct ipv6_pinfo *newnp;
 
 	newinet->pinet6 = newnp = tcp_inet6_sk(newsk);
+	newinet->ipv6_fl_list = NULL;
 
 	memcpy(newnp, tcp_inet6_sk(sk), sizeof(struct ipv6_pinfo));
 
@@ -1363,7 +1364,6 @@ static void tcp_v6_mapped_child_init(struct sock *newsk, const struct sock *sk)
 
 	newnp->ipv6_mc_list = NULL;
 	newnp->ipv6_ac_list = NULL;
-	newnp->ipv6_fl_list = NULL;
 	newnp->pktoptions  = NULL;
 	newnp->opt	   = NULL;
 
@@ -1426,10 +1426,12 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
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
@@ -1445,10 +1447,8 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	   First: no IPv4 options.
 	 */
-	newinet->inet_opt = NULL;
 	newnp->ipv6_mc_list = NULL;
 	newnp->ipv6_ac_list = NULL;
-	newnp->ipv6_fl_list = NULL;
 
 	/* Clone RX bits */
 	newnp->rxopt.all = np->rxopt.all;
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index b45cc51dfc353..79be52e6a76f9 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -784,9 +784,10 @@ static struct sock *sctp_v6_create_accept_sk(struct sock *sk,
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
@@ -798,7 +799,9 @@ static struct sock *sctp_v6_create_accept_sk(struct sock *sk,
 	sock_reset_flag(sk, SOCK_ZAPPED);
 
 	newsctp6sk = (struct sctp6_sock *)newsk;
-	inet_sk(newsk)->pinet6 = &newsctp6sk->inet6;
+	newinet = inet_sk(newsk);
+	newinet->pinet6 = &newsctp6sk->inet6;
+	newinet->ipv6_fl_list = NULL;
 
 	sctp_sk(newsk)->v4mapped = sctp_sk(sk)->v4mapped;
 
@@ -807,7 +810,6 @@ static struct sock *sctp_v6_create_accept_sk(struct sock *sk,
 	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
 	newnp->ipv6_mc_list = NULL;
 	newnp->ipv6_ac_list = NULL;
-	newnp->ipv6_fl_list = NULL;
 
 	sctp_v6_copy_ip_options(sk, newsk);
 
-- 
2.53.0

