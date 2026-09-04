Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D39B51C343;
	Fri,  4 Sep 2026 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546929; cv=none; b=roHntLqCG1rHiP0R4GngLjYKvnVRupND5aOVxA4QwDJZuTzPMUuSLaeJulnIOTb/hIdDbehdZeD76UJ4Rh/y4XBS0YLvxKtxhTwmVqwttJunIVcOI5RhhqYnnzIrI3XsVRdCv5f2cOQfFUZfTZ7mjozcAi/ymxkTmJI/QOgWNu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546929; c=relaxed/simple;
	bh=9lJqvQ+yXq8ZPaS0SGsVbI6vDiHKx/gsEsZmyik4UGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a33ogwWlQcR3BAEL6ee+s+3qs8Sy0aBhlWHKZj7DDVx/K9y68AFLRlgg/f7qor6pj6F89+HeUDjInKMB+GEraDYtuLnJo+0t2AOTDP5wHDedemg4K4ZGAEq1VNQCNlHUQns1MIq2oMMl0F9futHN4ii4wdFDJ1c3oYK+7LgcL+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=vehI5gJl; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="vehI5gJl"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 13BFCC0000E4;
	Fri,  4 Sep 2026 11:35:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 13BFCC0000E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1788546907;
	bh=9lJqvQ+yXq8ZPaS0SGsVbI6vDiHKx/gsEsZmyik4UGE=;
	h=From:To:Cc:Subject:Date:From;
	b=vehI5gJlNTbYzqJXBpn1xntQA8FkTRuiYyBQiSdl9EqHTNgCSeAGgjMqcEDx7Mfi8
	 RJbSYLk80Q/AAAgWbW8+UiKwm0jM13klFJPLPY24HH5P0eC7govkNSJVRqUJK0pUtw
	 UwsRvglrQqG3XVxWjsAK2eJnlRBk7nl40nPMqJ68=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 9E49BA9A;
	Fri,  4 Sep 2026 11:35:06 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list),
	mptcp@lists.linux.dev (open list:NETWORKING [MPTCP]),
	bcm-kernel-feedback-list@broadcom.com,
	atul.joshi@nokia.com,
	joakim.tjernlund@nokia.com
Subject: [PATCH stable 5.10 v2] tcp: fix potential race in tcp_v6_syn_recv_sock()
Date: Fri,  4 Sep 2026 11:34:56 -0700
Message-Id: <20260904183500.3841094-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

Code in tcp_v6_syn_recv_sock() after the call to tcp_v4_syn_recv_sock()
is done too late.

After tcp_v4_syn_recv_sock(), the child socket is already visible
from TCP ehash table and other cpus might use it.

Since newinet->pinet6 is still pointing to the listener ipv6_pinfo
bad things can happen as syzbot found.

Move the problematic code in tcp_v6_mapped_child_init()
and call this new helper from tcp_v4_syn_recv_sock() before
the ehash insertion.

This allows the removal of one tcp_sync_mss(), since
tcp_v4_syn_recv_sock() will call it with the correct
context.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69949275.050a0220.2eeac1.0145.GAE@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260217161205.2079883-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 858d2a4f67ff69e645a43487ef7ea7f28f06deae)
[florian:
 - net/ipv6/tcp_ipv6.c:
   - Set `newnp->ipv6_fl_list = NULL` instead of `newinet->ipv6_fl_list = NULL`,
     as `ipv6_fl_list` is in `struct ipv6_pinfo`.
   - Guarded `af_specific` assignment with `#ifdef CONFIG_TCP_MD5SIG` instead
     of checking `CONFIG_TCP_AO`.
   - Used `if (tcp_inet6_sk(sk)->repflow)` instead of `inet6_test_bit(REPFLOW, sk)`.
 - net/smc/af_smc.c:
   - Dropped changes to net/smc/af_smc.c because SMC did not implement
     `smc_tcp_syn_recv_sock()` in 5.10.y (added in 5.14 via commit e94a869818ab).
 - net/dccp/:
   - Updated `syn_recv_sock` implementations and call sites for DCCP, which was
     removed in upstream kernels prior to this commit.]
Assisted-by: Cursor:gemini-3.7-flash
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Changes in v2:
- Updated the DCCP subsystem (net/dccp/) to handle the additional
  opt_child_init argument in syn_recv_sock callback, fixing build
  failures when CONFIG_IP_DCCP is enabled.

 include/net/inet_connection_sock.h |  4 +-
 include/net/tcp.h                  |  4 +-
 net/dccp/dccp.h                    |  4 +-
 net/dccp/ipv4.c                    |  4 +-
 net/dccp/ipv6.c                    |  7 ++-
 net/dccp/minisocks.c               |  2 +-
 net/ipv4/syncookies.c              |  2 +-
 net/ipv4/tcp_fastopen.c            |  2 +-
 net/ipv4/tcp_ipv4.c                |  8 ++-
 net/ipv4/tcp_minisocks.c           |  2 +-
 net/ipv6/tcp_ipv6.c                | 98 +++++++++++++-----------------
 net/mptcp/subflow.c                |  6 +-
 12 files changed, 74 insertions(+), 69 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index cfb66f5a5076..ba99da8eedb7 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -41,7 +41,9 @@ struct inet_connection_sock_af_ops {
 				      struct request_sock *req,
 				      struct dst_entry *dst,
 				      struct request_sock *req_unhash,
-				      bool *own_req);
+				      bool *own_req,
+				      void (*opt_child_init)(struct sock *newsk,
+							     const struct sock *sk));
 	u16	    net_header_len;
 	u16	    net_frag_header_len;
 	u16	    sockaddr_len;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4c87936a33d6..5488e66ee69a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -438,7 +438,9 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 				  struct request_sock *req,
 				  struct dst_entry *dst,
 				  struct request_sock *req_unhash,
-				  bool *own_req);
+				  bool *own_req,
+				  void (*opt_child_init)(struct sock *newsk,
+							 const struct sock *sk));
 int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb);
 int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 int tcp_connect(struct sock *sk);
diff --git a/net/dccp/dccp.h b/net/dccp/dccp.h
index 0218eb169891..f9744455113f 100644
--- a/net/dccp/dccp.h
+++ b/net/dccp/dccp.h
@@ -272,7 +272,9 @@ struct sock *dccp_v4_request_recv_sock(const struct sock *sk, struct sk_buff *sk
 				       struct request_sock *req,
 				       struct dst_entry *dst,
 				       struct request_sock *req_unhash,
-				       bool *own_req);
+				       bool *own_req,
+				       void (*opt_child_init)(struct sock *newsk,
+							      const struct sock *sk));
 struct sock *dccp_check_req(struct sock *sk, struct sk_buff *skb,
 			    struct request_sock *req);
 
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 2c7c1bdd39e1..7fa905cf19bd 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -397,7 +397,9 @@ struct sock *dccp_v4_request_recv_sock(const struct sock *sk,
 				       struct request_sock *req,
 				       struct dst_entry *dst,
 				       struct request_sock *req_unhash,
-				       bool *own_req)
+				       bool *own_req,
+				       void (*opt_child_init)(struct sock *newsk,
+							      const struct sock *sk))
 {
 	struct inet_request_sock *ireq;
 	struct inet_sock *newinet;
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index aa311ab960b6..725579449124 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -403,7 +403,9 @@ static struct sock *dccp_v6_request_recv_sock(const struct sock *sk,
 					      struct request_sock *req,
 					      struct dst_entry *dst,
 					      struct request_sock *req_unhash,
-					      bool *own_req)
+					      bool *own_req,
+					      void (*opt_child_init)(struct sock *newsk,
+								     const struct sock *sk))
 {
 	struct inet_request_sock *ireq = inet_rsk(req);
 	struct ipv6_pinfo *newnp;
@@ -418,7 +420,8 @@ static struct sock *dccp_v6_request_recv_sock(const struct sock *sk,
 		 *	v6 mapped
 		 */
 		newsk = dccp_v4_request_recv_sock(sk, skb, req, dst,
-						  req_unhash, own_req);
+						  req_unhash, own_req,
+						  opt_child_init);
 		if (newsk == NULL)
 			return NULL;
 
diff --git a/net/dccp/minisocks.c b/net/dccp/minisocks.c
index 91e7a2202697..6ea298259b03 100644
--- a/net/dccp/minisocks.c
+++ b/net/dccp/minisocks.c
@@ -192,7 +192,7 @@ struct sock *dccp_check_req(struct sock *sk, struct sk_buff *skb,
 		 goto drop;
 
 	child = inet_csk(sk)->icsk_af_ops->syn_recv_sock(sk, skb, req, NULL,
-							 req, &own_req);
+							 req, &own_req, NULL);
 	if (child) {
 		child = inet_csk_complete_hashdance(sk, child, req, own_req);
 		goto out;
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index cc860f2dcf65..29fb93cb3228 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -201,7 +201,7 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 	bool own_req;
 
 	child = icsk->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
-						 NULL, &own_req);
+						 NULL, &own_req, NULL);
 	if (child) {
 		refcount_set(&req->rsk_refcnt, 1);
 		tcp_sk(child)->tsoffset = tsoff;
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 92d63cf3e50b..edaa6dabfc3c 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -262,7 +262,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 	bool own_req;
 
 	child = inet_csk(sk)->icsk_af_ops->syn_recv_sock(sk, skb, req, NULL,
-							 NULL, &own_req);
+							 NULL, &own_req, NULL);
 	if (!child)
 		return NULL;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 855cca214a02..f1e10db3d625 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1535,7 +1535,9 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 				  struct request_sock *req,
 				  struct dst_entry *dst,
 				  struct request_sock *req_unhash,
-				  bool *own_req)
+				  bool *own_req,
+				  void (*opt_child_init)(struct sock *newsk,
+							 const struct sock *sk))
 {
 	struct inet_request_sock *ireq;
 	bool found_dup_sk = false;
@@ -1591,6 +1593,10 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	}
 	sk_setup_caps(newsk, dst);
 
+#if IS_ENABLED(CONFIG_IPV6)
+	if (opt_child_init)
+		opt_child_init(newsk, sk);
+#endif
 	tcp_ca_openreq_child(newsk, dst);
 
 	tcp_sync_mss(newsk, dst_mtu(dst));
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 866055e1b801..876104fe47bf 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -770,7 +770,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	 * socket is created, wait for troubles.
 	 */
 	child = inet_csk(sk)->icsk_af_ops->syn_recv_sock(sk, skb, req, NULL,
-							 req, &own_req);
+							 req, &own_req, NULL);
 	if (!child)
 		goto listen_overflow;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 523aa2efdc49..12118d5d98a1 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1217,11 +1217,48 @@ static void tcp_v6_restore_cb(struct sk_buff *skb)
 		sizeof(struct inet6_skb_parm));
 }
 
+/* Called from tcp_v4_syn_recv_sock() for v6_mapped children. */
+static void tcp_v6_mapped_child_init(struct sock *newsk, const struct sock *sk)
+{
+	struct inet_sock *newinet = inet_sk(newsk);
+	struct ipv6_pinfo *newnp;
+
+	newinet->pinet6 = newnp = tcp_inet6_sk(newsk);
+
+	memcpy(newnp, tcp_inet6_sk(sk), sizeof(struct ipv6_pinfo));
+
+	newnp->saddr = newsk->sk_v6_rcv_saddr;
+
+	inet_csk(newsk)->icsk_af_ops = &ipv6_mapped;
+	if (sk_is_mptcp(newsk))
+		mptcpv6_handle_mapped(newsk, true);
+	newsk->sk_backlog_rcv = tcp_v4_do_rcv;
+#ifdef CONFIG_TCP_MD5SIG
+	tcp_sk(newsk)->af_specific = &tcp_sock_ipv6_mapped_specific;
+#endif
+
+	newnp->ipv6_mc_list = NULL;
+	newnp->ipv6_ac_list = NULL;
+	newnp->ipv6_fl_list = NULL;
+	newnp->pktoptions  = NULL;
+	newnp->opt	   = NULL;
+
+	/* tcp_v4_syn_recv_sock() has initialized newinet->mc_{index,ttl} */
+	newnp->mcast_oif   = newinet->mc_index;
+	newnp->mcast_hops  = newinet->mc_ttl;
+
+	newnp->rcv_flowinfo = 0;
+	if (tcp_inet6_sk(sk)->repflow)
+		newnp->flow_label = 0;
+}
+
 static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 					 struct request_sock *req,
 					 struct dst_entry *dst,
 					 struct request_sock *req_unhash,
-					 bool *own_req)
+					 bool *own_req,
+					 void (*opt_child_init)(struct sock *newsk,
+								const struct sock *sk))
 {
 	struct inet_request_sock *ireq;
 	struct ipv6_pinfo *newnp;
@@ -1237,61 +1274,10 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 #endif
 	struct flowi6 fl6;
 
-	if (skb->protocol == htons(ETH_P_IP)) {
-		/*
-		 *	v6 mapped
-		 */
-
-		newsk = tcp_v4_syn_recv_sock(sk, skb, req, dst,
-					     req_unhash, own_req);
-
-		if (!newsk)
-			return NULL;
-
-		inet_sk(newsk)->pinet6 = tcp_inet6_sk(newsk);
-
-		newinet = inet_sk(newsk);
-		newnp = tcp_inet6_sk(newsk);
-		newtp = tcp_sk(newsk);
-
-		memcpy(newnp, np, sizeof(struct ipv6_pinfo));
-
-		newnp->saddr = newsk->sk_v6_rcv_saddr;
-
-		inet_csk(newsk)->icsk_af_ops = &ipv6_mapped;
-		if (sk_is_mptcp(newsk))
-			mptcpv6_handle_mapped(newsk, true);
-		newsk->sk_backlog_rcv = tcp_v4_do_rcv;
-#ifdef CONFIG_TCP_MD5SIG
-		newtp->af_specific = &tcp_sock_ipv6_mapped_specific;
-#endif
-
-		newnp->ipv6_mc_list = NULL;
-		newnp->ipv6_ac_list = NULL;
-		newnp->ipv6_fl_list = NULL;
-		newnp->pktoptions  = NULL;
-		newnp->opt	   = NULL;
-		newnp->mcast_oif   = inet_iif(skb);
-		newnp->mcast_hops  = ip_hdr(skb)->ttl;
-		newnp->rcv_flowinfo = 0;
-		if (np->repflow)
-			newnp->flow_label = 0;
-
-		/*
-		 * No need to charge this sock to the relevant IPv6 refcnt debug socks count
-		 * here, tcp_create_openreq_child now does this for us, see the comment in
-		 * that function for the gory details. -acme
-		 */
-
-		/* It is tricky place. Until this moment IPv4 tcp
-		   worked with IPv6 icsk.icsk_af_ops.
-		   Sync it now.
-		 */
-		tcp_sync_mss(newsk, inet_csk(newsk)->icsk_pmtu_cookie);
-
-		return newsk;
-	}
-
+	if (skb->protocol == htons(ETH_P_IP))
+		return tcp_v4_syn_recv_sock(sk, skb, req, dst,
+					    req_unhash, own_req,
+					    tcp_v6_mapped_child_init);
 	ireq = inet_rsk(req);
 
 	if (sk_acceptq_is_full(sk))
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b13cd310882d..c9cf0fdbfbdc 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -532,7 +532,9 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 					  struct request_sock *req,
 					  struct dst_entry *dst,
 					  struct request_sock *req_unhash,
-					  bool *own_req)
+					  bool *own_req,
+					  void (*opt_child_init)(struct sock *newsk,
+								 const struct sock *sk))
 {
 	struct mptcp_subflow_context *listener = mptcp_subflow_ctx(sk);
 	struct mptcp_subflow_request_sock *subflow_req;
@@ -582,7 +584,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 create_child:
 	child = listener->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
-						     req_unhash, own_req);
+						     req_unhash, own_req, opt_child_init);
 
 	if (child && *own_req) {
 		struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(child);
-- 
2.34.1

