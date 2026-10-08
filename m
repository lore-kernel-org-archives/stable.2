Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40D7495510;
	Thu,  8 Oct 2026 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463288; cv=none; b=q1CYRCEAzNwcCX+pG/R7ERskTBCpauem1Uw5jI/9DIM6Hu0bZD6Dki4+RKFebYz/iYlTfogJOsvzNcBHyL/Pg29479R/MTQ1BYsOFUbTpg0d9fz7JMSyqwceHaKHJ3aboIvvewaziT2KN9aF6m6r8EwG+XUwKmFZyfK/R5w3yrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463288; c=relaxed/simple;
	bh=cvouQ6O6J76G08fzoqFWkC5wVChJfGk9TzWCMh6SRoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JMS1Ocb8H9OlUVY0yNb64/Kb5gBMnFWp/LNRRUipF/uu6UqvvlT7o9uyoGcGLhtyisHdNkaSugPgJ8Zpuyx9j4skc0EB5VnBB8bde/W6dIDVETBmMs+sTFXfRibJ7oth5VJ9pHNJOPHcWdkiFaMTBRrMOtGUWVRckNxyavbaDug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=fw8v4Qyk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fw8v4Qyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254351F000FF;
	Thu,  8 Oct 2026 12:41:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=fw8v4Qyk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1791463283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ty+NSzztoWZlSPZSksR8rahvfmn17KCWrjnEiYBF2m4=;
	b=fw8v4QykQDjG9xgzttrNQaHVThpeDmZpPX8GMHvm+33I7AY0JycRACvgjRAcpFHnjFyXgz
	JGt8JPecE0gOT2fUo1u5mmTiwDf8KNvGT4sBwDBq5un62gS753d2bm1cAgtSoLaenYgw0C
	bLpJ51IPpexQVVL1tIv1YXjxedWt2l4=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 623b9651 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 12:41:23 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	willemdebruijn.kernel@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-pm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <jeremy.jean@oss.cyber.gouv.fr>
Subject: [PATCH net] udp_tunnel: drop packets when hibernating
Date: Thu,  8 Oct 2026 14:40:21 +0200
Message-ID: <20261008124106.665014-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The kernel's various networking applications keep churning away after
userspace is frozen during hibernation, even as a memory snapshot is
being made. This can lead many network applications to an inconsistent
state, replaying packets and cryptographic state changes. For example,
on wireguard, there's the possibility of this sequence:

1) hibernating begins
2) handshake state cleared
3) keypairs cleared
4) new handshake round trip completes
5) machine memory is snapshotted
6) packet is sent using new keypair
7) machine is restored to state (5)
8) packet is sent using new keypair

The idea is to prevent (6) from happening, especially if (6) and (8)
contain different data, but the same key and nonce. Presumably the same
issue applies to other users of udp_tunnel too.

Fix this by just dropping sending and receiving packets during the
hibernation sequence.

Cc: stable@vger.kernel.org
Reported-by: Jérémy Jean <jeremy.jean@oss.cyber.gouv.fr>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
I wrote this patch in response to the issue Jérémy raised, but I'm not
actually super familiar with all of the hibernation mechanics. If
somebody working on PM would think about this matter too, I'd be much
obliged.

 include/linux/freezer.h    | 1 +
 net/ipv4/udp.c             | 5 +++++
 net/ipv4/udp_tunnel_core.c | 5 +++++
 net/ipv6/ip6_udp_tunnel.c  | 5 +++++
 net/ipv6/udp.c             | 5 +++++
 5 files changed, 21 insertions(+)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 0a8c6c4d1a82..21d708dc4092 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -76,6 +76,7 @@ static inline bool cgroup1_freezing(struct task_struct *task)
 #endif /* !CONFIG_CGROUP_FREEZER */
 
 #else /* !CONFIG_FREEZER */
+#define pm_freezing (false)
 static inline bool frozen(struct task_struct *p) { return false; }
 static inline bool freezing(struct task_struct *p) { return false; }
 static inline void __thaw_task(struct task_struct *t) {}
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b090bd1f59e8..5021932ad9f1 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -95,6 +95,7 @@
 #include <linux/netdevice.h>
 #include <linux/slab.h>
 #include <linux/sock_diag.h>
+#include <linux/freezer.h>
 #include <net/tcp_states.h>
 #include <linux/skbuff.h>
 #include <linux/proc_fs.h>
@@ -2425,6 +2426,10 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 		if (encap_rcv) {
 			int ret;
 
+			/* Drop if we're hibernating */
+			if (unlikely(pm_freezing))
+				goto drop;
+
 			/* Verify checksum before giving to encap */
 			if (udp_lib_checksum_complete(skb))
 				goto csum_error;
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index a128fe85620d..e3666ed96af7 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -3,6 +3,7 @@
 #include <linux/errno.h>
 #include <linux/socket.h>
 #include <linux/kernel.h>
+#include <linux/freezer.h>
 #include <net/dst_metadata.h>
 #include <net/flow.h>
 #include <net/udp.h>
@@ -172,6 +173,10 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 {
 	struct udphdr *uh;
 
+	/* Drop if we're hibernating */
+	if (unlikely(pm_freezing))
+		return;
+
 	__skb_push(skb, sizeof(*uh));
 	skb_reset_transport_header(skb);
 	uh = udp_hdr(skb);
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 32525a051a6f..4a31e8cc8887 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/in6.h>
+#include <linux/freezer.h>
 #include <net/udp.h>
 #include <net/udp_tunnel.h>
 #include <net/net_namespace.h>
@@ -86,6 +87,10 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 	struct udphdr *uh;
 	struct ipv6hdr *ip6h;
 
+	/* Drop if we're hibernating */
+	if (unlikely(pm_freezing))
+		return;
+
 	__skb_push(skb, sizeof(*uh));
 	skb_reset_transport_header(skb);
 	uh = udp_hdr(skb);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 93478d1ad576..db9c2050887d 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/indirect_call_wrapper.h>
+#include <linux/freezer.h>
 #include <trace/events/udp.h>
 
 #include <net/addrconf.h>
@@ -848,6 +849,10 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 		if (encap_rcv) {
 			int ret;
 
+			/* Drop if we're hibernating */
+			if (unlikely(pm_freezing))
+				goto drop;
+
 			/* Verify checksum before giving to encap */
 			if (udp_lib_checksum_complete(skb))
 				goto csum_error;
-- 
2.56.0

