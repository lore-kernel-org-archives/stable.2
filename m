Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B113AE71C
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882309; cv=none; b=aZ3Cy9z3DQ9xzG3kRDdXSyp6pUIc9AQYaMh1sqLw2c8aRv+zudYUDBSoxHrwhmyDWhIyt1vxEWd31/ssQCs3TVlETJ4P7FwhBV6hAzhYVDgjLsPBegW0rp8u8Hxd3Drh0NBKM/t999oorMQxSvs8RZ6myO6TqdsViT5ik0LD9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882309; c=relaxed/simple;
	bh=zrZtvSjYbhB8n6LuAJQLZtLvnsLb+OhtNasHz8G2Dds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMFKWZLh740uAfdkix5pGowNYuGw9eb7jpU5ekKQ7gQqII6N+uHyN8qqdh4IVWpnlMRo2XHmYpMBHfN+1a/apvpP1uZZ/kx4YbGE5IsIXY7JHwr+vfuT9H8iWxEgifsfJDYlewa3un48UK1dA3EdlFHBwzcqWm3vG8dbCk4zuM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4bZRmcy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4bZRmcy"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-89a837bf00eso187159b3a.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791882307; x=1792487107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HcqY9R2YTOxIE+yhKySAd0E4+Lidx60M519S7MZ1pW0=;
        b=P4bZRmcyDS12MRJygdM6MIV1Y6IMA8jp7G9nojuwoAjdJi3SkyKbB2FJPpoqvQGmI0
         p/vMCSn/n8uvb1+q4nOB6qk1nYpKirLeVO4IepsVuUhIr578CmpihYFB0YdyPhVc6jeb
         PZRIo4cxWb49b0VH1TK5As9fP8QGJC5tjsBJzDbaEcEB07sTevsBYi84TFHCBoLm+GZ7
         uQ82KI8H9jBHtHqXwxy1tF3g5BwJmjImTCQBZkCyuPKNIqQpKRbzPDnoJiUOIP6fafjV
         dm8IebrVdSLyxioyeKJHdsMOqt5WKqnVf/JhQB+1QvJLOXoJ24JMVPliE49tVu7vuhSv
         DwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791882307; x=1792487107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HcqY9R2YTOxIE+yhKySAd0E4+Lidx60M519S7MZ1pW0=;
        b=fHb26WjhinlCfGym9HImNnOzMWRaE1qaCmVLSMHHhzEEewBfdU3A5tmB1RAyqKF/0u
         ZIYZmM5JHfzFAaHxaJNXGVm3MNVdGBB5a5Bdq/d8Lo2CujJyQe7CDDGyw2PjKWNFmpuR
         IfrH1GYLwwZkuSVnjcPZ1GO6MQ+l5ib71ucwPgdKRzqt1LxF5s8NjGqnO2fAvtYSjeaC
         ZNgkLdtarHLIhCXJ8QWJVhDnFUip1kAXSt2w9KU/5799Bn6oWOAw2NdoOVs4uawrQb4I
         eKi/uOChqt0spfx7M/1NByDryLaImtnRTAXtkgu/ucyo9QAq92siisZYdRnA8B4pydhI
         x/OQ==
X-Forwarded-Encrypted: i=1; AKwUvByp0uq1vCWYE4p7jtMaBPjtzgKsm/UGjfe5PsVX9JvYLMXtmA2hPjMJ8YL7JF/BimgxHC2fVSA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRrrgMKrKJKWHGsPBdXJX6D3IscOVKC/Mvxn8cexCng4iTEj/B
	YlVyP6zfrcoVVBG7AOjUYLEWMPJwAaf//HjuR1LZsl9kb0p6a9QBH1Dm
X-Gm-Gg: AYBFou24D0W0kZkT2KZExIq+hd8O8Qya+Fg+DGF1uqt6c1BiCtfZ82tiEvHmkCX17Gj
	bh+65bORxVAqK0ajL9a3jaoMxoBlpgE4AfkRErelwv1Se1J9wlcBPQ8YDY6lPvFpRsKZbeba13S
	9nemJwghRthSlpSy14fKvN0z+qa7ljD8E5mJyQ+gdnD4t/jQAe21JaF0nPaDcxkOb0xrRrso8iN
	5+7VuicvffaNMsvP84h0uMgEgOnEZwi6ustYsXRtfeko1tBUDJKKBgqIFYUZy8duQPd8075TNCR
	h7GnI77t5U9WLUoCd4MVcS5y7g5fyO1qpUbXFyHymV6lMZpQYRWuEOvc7FB/TJtgzhaHt84qMxg
	X7VHoYbsGZknNcW0fuLrM9hS7X5qRH+nALVjSe08QElU9cJGknYbwSA+DFHA7qyz3DXaa5L09Ip
	LWgf9MqRTkAZl0SJGCL9vvgvhi059bz+pxS8wlCJiKVBVe7hvip3B7YdWmKtUPpRPDrUKPbOHh/
	G5c3GoiSg1LpIcaozOZBRCPEUd0uHLmY0cVt9Xk7b+in4tulm9G8L1QQCjeAapT
X-Received: by 2002:a17:903:244d:b0:2d8:f4d4:7044 with SMTP id d9443c01a7336-2e8429aa861mr157495525ad.3.1791882306646;
        Tue, 13 Oct 2026 02:05:06 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b53dsm38790462eec.6.2026.10.13.02.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 02:05:05 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: James Chapman <jchapman@katalix.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] l2tp: snapshot sequencing state when building transmit headers
Date: Tue, 13 Oct 2026 17:05:00 +0800
Message-ID: <20261013090500.1180376-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates to send_seq from netlink, PPP setsockopt and receive-side
negotiation race with packet transmission. The header length is updated
separately, while transmit reads both fields repeatedly without
synchronization.

For example, transmit can push a ten-byte L2TPv2 header, then a concurrent
writer clears send_seq before the header builder reads it. The builder
writes only six bytes, leaving four bytes of uninitialized skb headroom
in the outgoing packet. The reverse mismatch overwrites the beginning of
the payload. A later hdr_len read can also make the UDP length disagree
with the skb length.

KCSAN reported:

  BUG: KCSAN: data-race in l2tp_session_set_header_len / l2tp_xmit_skb

  write to 0xffff888100d0944a of 2 bytes by task 116 on cpu 1:
   l2tp_session_set_header_len+0x81/0xc0
   l2tp_nl_cmd_session_modify+0x122/0x2c0
   genl_family_rcv_msg_doit+0x170/0x1d0

  read to 0xffff888100d0944a of 2 bytes by task 115 on cpu 0:
   l2tp_xmit_skb+0x9c/0xc80
   pppol2tp_sendmsg+0x21c/0x2a0
   __sys_sendto+0x28c/0x2a0

The bug can lead to leak kernel base address for KASLR bypass, the
corresponding reproducer can be provided per request.

Initialize hdr_len to the maximum header size and leave it unchanged
when sequencing is toggled. Snapshot send_seq once per packet and use
that snapshot for the actual header length and header construction,
including the sequence flag. Use the same length for headroom, the header
push and the UDP length. PPP callers can safely reserve the maximum size;
L2TPv3 header sizes do not depend on sequencing.

Make send_seq a separate bool so READ_ONCE() and WRITE_ONCE() can be used
without sharing a bitfield storage unit with other configuration flags.
Preserve the netlink attribute's existing low-bit truncation.

Fixes: 3557baabf280 ("[L2TP]: PPP over L2TP driver core")
Cc: stable@vger.kernel.org
Assisted-by: GPT-6 Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/l2tp/l2tp_core.c    | 51 +++++++++++++++++++----------------------
 net/l2tp/l2tp_core.h    |  6 ++---
 net/l2tp/l2tp_debugfs.c |  4 ++--
 net/l2tp/l2tp_netlink.c | 11 ++++-----
 net/l2tp/l2tp_ppp.c     |  8 +++----
 5 files changed, 35 insertions(+), 45 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 4712cc41881a3..7e042a3e648ce 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -915,11 +915,9 @@ void l2tp_recv_common(struct l2tp_session *session, struct sk_buff *skb,
 		 * check if we sre sending sequence numbers and if not,
 		 * configure it so.
 		 */
-		if (!session->lns_mode && !session->send_seq) {
+		if (!session->lns_mode && !READ_ONCE(session->send_seq)) {
 			trace_session_seqnum_lns_enable(session);
-			session->send_seq = 1;
-			l2tp_session_set_header_len(session, tunnel->version,
-						    tunnel->encap);
+			WRITE_ONCE(session->send_seq, true);
 		}
 	} else {
 		/* No sequence numbers.
@@ -937,12 +935,10 @@ void l2tp_recv_common(struct l2tp_session *session, struct sk_buff *skb,
 		 * If we're the LNS and we're sending sequence numbers, the
 		 * LAC is broken. Discard the frame.
 		 */
-		if (!session->lns_mode && session->send_seq) {
+		if (!session->lns_mode && READ_ONCE(session->send_seq)) {
 			trace_session_seqnum_lns_disable(session);
-			session->send_seq = 0;
-			l2tp_session_set_header_len(session, tunnel->version,
-						    tunnel->encap);
-		} else if (session->send_seq) {
+			WRITE_ONCE(session->send_seq, false);
+		} else if (READ_ONCE(session->send_seq)) {
 			pr_debug_ratelimited("%s: recv data has no seq numbers when required. Discarding.\n",
 					     session->name);
 			atomic_long_inc(&session->stats.rx_seq_discards);
@@ -1138,7 +1134,8 @@ static void l2tp_udp_encap_err_recv(struct sock *sk, struct sk_buff *skb, int er
 
 /* Build an L2TP header for the session into the buffer provided.
  */
-static int l2tp_build_l2tpv2_header(struct l2tp_session *session, void *buf)
+static int l2tp_build_l2tpv2_header(struct l2tp_session *session, void *buf,
+				    bool send_seq)
 {
 	struct l2tp_tunnel *tunnel = session->tunnel;
 	__be16 *bufp = buf;
@@ -1147,14 +1144,14 @@ static int l2tp_build_l2tpv2_header(struct l2tp_session *session, void *buf)
 	u32 tunnel_id = tunnel->peer_tunnel_id;
 	u32 session_id = session->peer_session_id;
 
-	if (session->send_seq)
+	if (send_seq)
 		flags |= L2TP_HDRFLAG_S;
 
 	/* Setup L2TP header. */
 	*bufp++ = htons(flags);
 	*bufp++ = htons(tunnel_id);
 	*bufp++ = htons(session_id);
-	if (session->send_seq) {
+	if (send_seq) {
 		*bufp++ = htons(session->ns);
 		*bufp++ = 0;
 		session->ns++;
@@ -1165,7 +1162,8 @@ static int l2tp_build_l2tpv2_header(struct l2tp_session *session, void *buf)
 	return bufp - optr;
 }
 
-static int l2tp_build_l2tpv3_header(struct l2tp_session *session, void *buf)
+static int l2tp_build_l2tpv3_header(struct l2tp_session *session, void *buf,
+				    bool send_seq)
 {
 	struct l2tp_tunnel *tunnel = session->tunnel;
 	char *bufp = buf;
@@ -1191,7 +1189,7 @@ static int l2tp_build_l2tpv3_header(struct l2tp_session *session, void *buf)
 	if (session->l2specific_type == L2TP_L2SPECTYPE_DEFAULT) {
 		u32 l2h = 0;
 
-		if (session->send_seq) {
+		if (send_seq) {
 			l2h = 0x40000000 | session->ns;
 			session->ns++;
 			session->ns &= 0xffffff;
@@ -1225,19 +1223,24 @@ static int l2tp_xmit_queue(struct l2tp_tunnel *tunnel, struct sk_buff *skb, stru
 static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, unsigned int *len)
 {
 	struct l2tp_tunnel *tunnel = session->tunnel;
+	bool send_seq = READ_ONCE(session->send_seq);
 	unsigned int data_len = skb->len;
 	struct sock *sk = tunnel->sock;
+	u16 hdr_len = session->hdr_len;
 	int headroom, uhlen, udp_len;
 	int ret = NET_XMIT_SUCCESS;
 	struct inet_sock *inet;
 	struct udphdr *uh;
 
+	if (tunnel->version == L2TP_HDR_VER_2 && !send_seq)
+		hdr_len -= 4;
+
 	/* Check that there's enough headroom in the skb to insert IP,
 	 * UDP and L2TP headers. If not enough, expand it to
 	 * make room. Adjust truesize.
 	 */
 	uhlen = (tunnel->encap == L2TP_ENCAPTYPE_UDP) ? sizeof(*uh) : 0;
-	headroom = NET_SKB_PAD + sizeof(struct iphdr) + uhlen + session->hdr_len;
+	headroom = NET_SKB_PAD + sizeof(struct iphdr) + uhlen + hdr_len;
 	if (skb_cow_head(skb, headroom)) {
 		kfree_skb(skb);
 		return NET_XMIT_DROP;
@@ -1245,9 +1248,9 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
 
 	/* Setup L2TP header */
 	if (tunnel->version == L2TP_HDR_VER_2)
-		l2tp_build_l2tpv2_header(session, __skb_push(skb, session->hdr_len));
+		l2tp_build_l2tpv2_header(session, __skb_push(skb, hdr_len), send_seq);
 	else
-		l2tp_build_l2tpv3_header(session, __skb_push(skb, session->hdr_len));
+		l2tp_build_l2tpv3_header(session, __skb_push(skb, hdr_len), send_seq);
 
 	/* Reset control buffer */
 	memset(skb->cb, 0, sizeof(skb->cb));
@@ -1290,7 +1293,7 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
 		uh = udp_hdr(skb);
 		uh->source = inet->inet_sport;
 		uh->dest = inet->inet_dport;
-		udp_len = uhlen + session->hdr_len + data_len;
+		udp_len = uhlen + hdr_len + data_len;
 		if (udp_len > U16_MAX) {
 			kfree_skb(skb);
 			ret = NET_XMIT_DROP;
@@ -1759,16 +1762,11 @@ static void l2tp_session_del_work(struct work_struct *work)
 	l2tp_session_put(session);
 }
 
-/* We come here whenever a session's send_seq, cookie_len or
- * l2specific_type parameters are set.
- */
-void l2tp_session_set_header_len(struct l2tp_session *session, int version,
-				 enum l2tp_encap_type encap)
+static void l2tp_session_set_header_len(struct l2tp_session *session, int version,
+					enum l2tp_encap_type encap)
 {
 	if (version == L2TP_HDR_VER_2) {
-		session->hdr_len = 6;
-		if (session->send_seq)
-			session->hdr_len += 4;
+		session->hdr_len = 10;
 	} else {
 		session->hdr_len = 4 + session->cookie_len;
 		session->hdr_len += l2tp_get_l2specific_len(session);
@@ -1776,7 +1774,6 @@ void l2tp_session_set_header_len(struct l2tp_session *session, int version,
 			session->hdr_len += 4;
 	}
 }
-EXPORT_SYMBOL_GPL(l2tp_session_set_header_len);
 
 struct l2tp_session *l2tp_session_create(int priv_size, struct l2tp_tunnel *tunnel, u32 session_id,
 					 u32 peer_session_id, struct l2tp_session_cfg *cfg)
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index ffd8ced3a51ff..25ae4c25d3eff 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -76,7 +76,7 @@ struct l2tp_session {
 	u8			peer_cookie[8];
 	int			peer_cookie_len;
 	u16			l2specific_type;
-	u16			hdr_len;
+	u16			hdr_len;	/* maximum L2TP header length */
 	u32			nr;		/* session NR state (receive) */
 	u32			ns;		/* session NR state (send) */
 	struct sk_buff_head	reorder_q;	/* receive reorder queue */
@@ -94,8 +94,8 @@ struct l2tp_session {
 
 	char			name[L2TP_SESSION_NAME_MAX]; /* for logging */
 	char			ifname[IFNAMSIZ];
+	bool			send_seq;	/* send packets with sequence numbers? */
 	unsigned int		recv_seq:1;	/* expect receive packets with sequence numbers? */
-	unsigned int		send_seq:1;	/* send packets with sequence numbers? */
 	unsigned int		lns_mode:1;	/* behave as LNS?
 						 * LAC enables sequence numbers under LNS control.
 						 */
@@ -257,8 +257,6 @@ void l2tp_recv_common(struct l2tp_session *session, struct sk_buff *skb,
 int l2tp_udp_encap_recv(struct sock *sk, struct sk_buff *skb);
 
 /* Transmit path helpers for sending packets over the tunnel socket. */
-void l2tp_session_set_header_len(struct l2tp_session *session, int version,
-				 enum l2tp_encap_type encap);
 int l2tp_xmit_skb(struct l2tp_session *session, struct sk_buff *skb);
 
 /* Pseudowire management.
diff --git a/net/l2tp/l2tp_debugfs.c b/net/l2tp/l2tp_debugfs.c
index c12d5e1ee550c..58d1d6a7768ef 100644
--- a/net/l2tp/l2tp_debugfs.c
+++ b/net/l2tp/l2tp_debugfs.c
@@ -182,12 +182,12 @@ static void l2tp_dfs_seq_session_show(struct seq_file *m, void *v)
 		   session->pwtype == L2TP_PWTYPE_ETH ? "ETH" :
 		   session->pwtype == L2TP_PWTYPE_PPP ? "PPP" :
 		   "");
-	if (session->send_seq || session->recv_seq)
+	if (READ_ONCE(session->send_seq) || session->recv_seq)
 		seq_printf(m, "   nr %u, ns %u\n", session->nr, session->ns);
 	seq_printf(m, "   refcnt %d\n", refcount_read(&session->ref_count));
 	seq_printf(m, "   config 0/0/%c/%c/-/%s %08x %u\n",
 		   session->recv_seq ? 'R' : '-',
-		   session->send_seq ? 'S' : '-',
+		   READ_ONCE(session->send_seq) ? 'S' : '-',
 		   session->lns_mode ? "LNS" : "LAC",
 		   0,
 		   jiffies_to_msecs(session->reorder_timeout));
diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index 38aac59d052c4..89ef04c78787d 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -700,12 +700,9 @@ static int l2tp_nl_cmd_session_modify(struct sk_buff *skb, struct genl_info *inf
 	if (info->attrs[L2TP_ATTR_RECV_SEQ])
 		session->recv_seq = nla_get_u8(info->attrs[L2TP_ATTR_RECV_SEQ]);
 
-	if (info->attrs[L2TP_ATTR_SEND_SEQ]) {
-		struct l2tp_tunnel *tunnel = session->tunnel;
-
-		session->send_seq = nla_get_u8(info->attrs[L2TP_ATTR_SEND_SEQ]);
-		l2tp_session_set_header_len(session, tunnel->version, tunnel->encap);
-	}
+	if (info->attrs[L2TP_ATTR_SEND_SEQ])
+		WRITE_ONCE(session->send_seq,
+			   nla_get_u8(info->attrs[L2TP_ATTR_SEND_SEQ]) & 1);
 
 	if (info->attrs[L2TP_ATTR_LNS_MODE])
 		session->lns_mode = nla_get_u8(info->attrs[L2TP_ATTR_LNS_MODE]);
@@ -748,7 +745,7 @@ static int l2tp_nl_session_send(struct sk_buff *skb, u32 portid, u32 seq, int fl
 	    (session->peer_cookie_len &&
 	     nla_put(skb, L2TP_ATTR_PEER_COOKIE, session->peer_cookie_len, session->peer_cookie)) ||
 	    nla_put_u8(skb, L2TP_ATTR_RECV_SEQ, session->recv_seq) ||
-	    nla_put_u8(skb, L2TP_ATTR_SEND_SEQ, session->send_seq) ||
+	    nla_put_u8(skb, L2TP_ATTR_SEND_SEQ, READ_ONCE(session->send_seq)) ||
 	    nla_put_u8(skb, L2TP_ATTR_LNS_MODE, session->lns_mode) ||
 	    (l2tp_tunnel_uses_xfrm(tunnel) &&
 	     nla_put_u8(skb, L2TP_ATTR_USING_IPSEC, 1)) ||
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index ef8fdfaf051d4..4f311d473a646 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1195,9 +1195,7 @@ static int pppol2tp_session_setsockopt(struct sock *sk,
 			err = -EINVAL;
 			break;
 		}
-		session->send_seq = !!val;
-		l2tp_session_set_header_len(session, session->tunnel->version,
-					    session->tunnel->encap);
+		WRITE_ONCE(session->send_seq, !!val);
 		break;
 
 	case PPPOL2TP_SO_LNSMODE:
@@ -1307,7 +1305,7 @@ static int pppol2tp_session_getsockopt(struct sock *sk,
 		break;
 
 	case PPPOL2TP_SO_SENDSEQ:
-		*val = session->send_seq;
+		*val = READ_ONCE(session->send_seq);
 		break;
 
 	case PPPOL2TP_SO_LNSMODE:
@@ -1546,7 +1544,7 @@ static void pppol2tp_seq_session_show(struct seq_file *m, void *v)
 		   state, user_data_ok);
 	seq_printf(m, "   0/0/%c/%c/%s %08x %u\n",
 		   session->recv_seq ? 'R' : '-',
-		   session->send_seq ? 'S' : '-',
+		   READ_ONCE(session->send_seq) ? 'S' : '-',
 		   session->lns_mode ? "LNS" : "LAC",
 		   0,
 		   jiffies_to_msecs(session->reorder_timeout));
-- 
2.43.0

