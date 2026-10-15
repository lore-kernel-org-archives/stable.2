Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C4252CCFE;
	Thu, 15 Oct 2026 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066921; cv=none; b=A9xUBCAEhv+WJ1TO4S4oXaDgIkeE83BR5DryoshR6rZETF5wHdopqFyfUQfEsEBw5++MUPnQE3lTwfyHMB3X0eA34rYAmzBIDtzJmEXtYfBMXXVYfNUOvQoURrS5FH+OrskgZSo+V7nJbNmVv8i2XLxcltJrqTRgmTWmmmwMux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066921; c=relaxed/simple;
	bh=dKNN/EH8GL3qLHh0IcQ51UVvx+k5Kp4Q2t6qbt/LkUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwjsSI9FgP0SwfLapWQXKFEathidsQFkGjMy/HMvdG6CAC1OpQKZE4+TMWhP7Yf0osqJmMk9AkxZ0m9KPkaJPS+4GNrtXUeKqocXbr1y4PoozYsNypOTvrCkTILBnOiSFPeUXdshjTEZ2CT7CoGBWe4fd3A/tQV/tGPejUxfUn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mXw6qVya; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mXw6qVya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392E51F000C4;
	Thu, 15 Oct 2026 12:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792066919;
	bh=7ujLFHSn/IU9kC3by9aTd568WZFKGl9fGQfkT7glOnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXw6qVyadTpsl146Fh5aCR8XfuxC36iFvnIPADLHOtDo2AViUcVm4nqyvhi/xSLp9
	 lx+0GF/k4SAFm1ApDUWd4B7TFmGQyWWjQ3h/Ov7D96VaGZsDgtjeRnvc7VBPFcLYCa
	 s0PmPjxK49Tz7cYuE0tqxOW7Pprk+EdwRV+W3hEM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.190
Date: Thu, 15 Oct 2026 14:21:57 +0200
Message-ID: <2026101557-skinny-handbrake-8c0e@gregkh>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026101556-skinny-abstract-77eb@gregkh>
References: <2026101556-skinny-abstract-77eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index df48f250f320..e4c0c25b58ed 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 189
+SUBLEVEL = 190
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/include/net/ip.h b/include/net/ip.h
index 414772ca7bb7..49e86b8bf9c9 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -72,6 +72,13 @@ static inline unsigned int ip_hdrlen(const struct sk_buff *skb)
 	return ip_hdr(skb)->ihl * 4;
 }
 
+static inline int ip_check_csum_start(const struct sk_buff *skb)
+{
+	if (unlikely(skb->csum_start < skb->network_header + ip_hdrlen(skb)))
+		return -EINVAL;
+	return 0;
+}
+
 struct ipcm_cookie {
 	struct sockcm_cookie	sockc;
 	__be32			addr;
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index a22ff6767f6f..10b8134c22e4 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -40,9 +40,13 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 	int err = 0;
 
 	/* for offloaded checksums cleanup checksum before fragmentation */
-	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (err = skb_checksum_help(skb)))
-		goto blackhole;
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		err = ip_check_csum_start(skb);
+		if (!err)
+			err = skb_checksum_help(skb);
+		if (err)
+			goto blackhole;
+	}
 
 	iph = ip_hdr(skb);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 3b81f1787222..f9597dbfd422 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3409,6 +3409,7 @@ int skb_crc32c_csum_help(struct sk_buff *skb)
 out:
 	return ret;
 }
+EXPORT_SYMBOL(skb_crc32c_csum_help);
 
 __be16 skb_network_protocol(struct sk_buff *skb, int *depth)
 {
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 4f3c932e37ed..a09b90552cf6 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -153,7 +153,7 @@ void inet_sock_destruct(struct sock *sk)
 	WARN_ON_ONCE(sk->sk_wmem_queued);
 	WARN_ON_ONCE(sk_forward_alloc_get(sk));
 
-	kfree(rcu_dereference_protected(inet->inet_opt, 1));
+	kfree_rcu(rcu_dereference_protected(inet->inet_opt, 1), rcu);
 	dst_release(rcu_dereference_protected(sk->sk_dst_cache, 1));
 	dst_release(rcu_dereference_protected(sk->sk_rx_dst, 1));
 	sk_refcnt_debug_dec(sk);
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 707c634c0305..da0707f5fb8b 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -776,9 +776,13 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	int err = 0;
 
 	/* for offloaded checksums cleanup checksum before fragmentation */
-	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (err = skb_checksum_help(skb)))
-		goto fail;
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		err = ip_check_csum_start(skb);
+		if (!err)
+			err = skb_checksum_help(skb);
+		if (err)
+			goto fail;
+	}
 
 	/*
 	 *	Point into the IP datagram header.
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 9c5d227b749c..38ce407af8fd 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1060,7 +1060,7 @@ static int tcp_v4_send_synack(const struct sock *sk, struct dst_entry *dst,
  */
 static void tcp_v4_reqsk_destructor(struct request_sock *req)
 {
-	kfree(rcu_dereference_protected(inet_rsk(req)->ireq_opt, 1));
+	kfree_rcu(rcu_dereference_protected(inet_rsk(req)->ireq_opt, 1), rcu);
 }
 
 #ifdef CONFIG_TCP_MD5SIG
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 3d522248b45b..015ffb11cb65 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -29,6 +29,7 @@
 #include <linux/netfilter/nfnetlink_queue.h>
 #include <linux/netfilter/nf_conntrack_common.h>
 #include <linux/list.h>
+#include <net/ip.h>
 #include <net/sock.h>
 #include <net/tcp_states.h>
 #include <net/netfilter/nf_queue.h>
@@ -370,6 +371,20 @@ static int nfqnl_put_bridge(struct nf_queue_entry *entry, struct sk_buff *skb)
 	return -1;
 }
 
+static int nf_queue_checksum_help(struct sk_buff *entskb)
+{
+	if (entskb->protocol == htons(ETH_P_IP)) {
+		if (!pskb_network_may_pull(entskb, sizeof(struct iphdr)) ||
+		    ip_check_csum_start(entskb))
+			return -EINVAL;
+	}
+
+	if (skb_csum_is_sctp(entskb))
+		return skb_crc32c_csum_help(entskb);
+
+	return skb_checksum_help(entskb);
+}
+
 static struct sk_buff *
 nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 			   struct nf_queue_entry *entry,
@@ -429,7 +444,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	case NFQNL_COPY_PACKET:
 		if (!(queue->flags & NFQA_CFG_F_GSO) &&
 		    entskb->ip_summed == CHECKSUM_PARTIAL &&
-		    skb_checksum_help(entskb))
+		    nf_queue_checksum_help(entskb))
 			return NULL;
 
 		data_len = READ_ONCE(queue->copy_range);
@@ -838,7 +853,7 @@ nfqnl_enqueue_packet(struct nf_queue_entry *entry, unsigned int queuenum)
 		break;
 	}
 
-	if ((queue->flags & NFQA_CFG_F_GSO) || !skb_is_gso(skb))
+	if (!skb_is_gso(skb) || ((queue->flags & NFQA_CFG_F_GSO) && !skb_is_gso_sctp(skb)))
 		return __nfqnl_enqueue_packet(net, queue, entry);
 
 	nf_bridge_adjust_skb_data(skb);
diff --git a/net/netfilter/xt_CHECKSUM.c b/net/netfilter/xt_CHECKSUM.c
index 9d99f5a3d176..1fb0f8118404 100644
--- a/net/netfilter/xt_CHECKSUM.c
+++ b/net/netfilter/xt_CHECKSUM.c
@@ -15,6 +15,7 @@
 
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netfilter_ipv6/ip6_tables.h>
+#include <net/ip.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Michael S. Tsirkin <mst@redhat.com>");
@@ -25,8 +26,11 @@ MODULE_ALIAS("ip6t_CHECKSUM");
 static unsigned int
 checksum_tg(struct sk_buff *skb, const struct xt_action_param *par)
 {
-	if (skb->ip_summed == CHECKSUM_PARTIAL && !skb_is_gso(skb))
+	if (skb->ip_summed == CHECKSUM_PARTIAL && !skb_is_gso(skb)) {
+		if (xt_family(par) == NFPROTO_IPV4 && ip_check_csum_start(skb))
+			return NF_DROP;
 		skb_checksum_help(skb);
+	}
 
 	return XT_CONTINUE;
 }
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 290059d9e08e..32dd61f7f7b6 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -753,16 +753,22 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		err = skb_checksum_help(skb);
-		if (err) {
-			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
-			kfree_skb(skb);
-			return err;
+		if (skb->protocol == htons(ETH_P_IP)) {
+			err = ip_check_csum_start(skb);
+			if (err)
+				goto error;
 		}
+		err = skb_checksum_help(skb);
+		if (err)
+			goto error;
 	}
 
 out:
 	return xfrm_output2(net, sk, skb);
+error:
+	XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+	kfree_skb(skb);
+	return err;
 }
 EXPORT_SYMBOL_GPL(xfrm_output);
 
