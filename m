Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C23752BE45;
	Thu, 15 Oct 2026 12:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066914; cv=none; b=EqhOsc8fBS91YTlMA6KWY4JzjrDxxQsWKWy09aFor6sZSBIQ21x+GDbcek0fy1wIEOxBXiG8jMlKZeVYs2gDYESLhIMecvVjCNECH3/zdNvC7J8W3Mm64b619ULCgr794vEtOmXcgHwBc/uDie8W/GHz9l+4LZTmhlbHqV3dE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066914; c=relaxed/simple;
	bh=rxQR/nAXOSaJWLQqUewNcnfWAfAU7YLHHZV4gh+las8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWup0HJiN8IKN8mDRyuMSaY+SD1wO7pe6MMUhCxccIeoCvqBMr2HS5904QYvHoQNfpZD2xB0hSxGzVTf/1RQCB0zs75IBaGMI9vo1wZg0RdgyDVHtFu1NDgrL52Qh4dg8/ADW/wVk9Of6lZ60HfvvZOp70uJPY7e1q57oiT90IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nwu2kLIC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nwu2kLIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74F71F000C4;
	Thu, 15 Oct 2026 12:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792066913;
	bh=ixXV6LA9YRRsev4J8ALGRPxiTc640PhxDRkmRqWVfQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nwu2kLICY0MUJmhW+yLNRn+r+EvJt8yOT3lQWmW3uGvjerSPVSmDFJniH5JfvyjSO
	 u8ZKSeBaMuUvxt9ZM7ahGV9S2EdwJs71VRs+f0H+LNlnaOGm7qm/YHEg+jDBJuoaED
	 xVwsfsn6HIdAbz4B7SRqx/a21jrFlpGcWSFkOXGk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.223
Date: Thu, 15 Oct 2026 14:21:50 +0200
Message-ID: <2026101550-imprudent-impaired-8553@gregkh>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026101550-fifteen-symptom-216d@gregkh>
References: <2026101550-fifteen-symptom-216d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index d18cd6c1fc78..95ad57e8d444 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 222
+SUBLEVEL = 223
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/include/net/ip.h b/include/net/ip.h
index e25a2d5519c5..acacf18457b7 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -71,6 +71,13 @@ static inline unsigned int ip_hdrlen(const struct sk_buff *skb)
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
index 31ee5af07409..73ce7e18a03c 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -39,9 +39,13 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
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
index 14c9a23db1b0..7197b18b052d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3365,6 +3365,7 @@ int skb_crc32c_csum_help(struct sk_buff *skb)
 out:
 	return ret;
 }
+EXPORT_SYMBOL(skb_crc32c_csum_help);
 
 __be16 skb_network_protocol(struct sk_buff *skb, int *depth)
 {
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 0701de762c4c..cbb1bf83a3a2 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -156,7 +156,7 @@ void inet_sock_destruct(struct sock *sk)
 	WARN_ON(sk->sk_wmem_queued);
 	WARN_ON(sk->sk_forward_alloc);
 
-	kfree(rcu_dereference_protected(inet->inet_opt, 1));
+	kfree_rcu(rcu_dereference_protected(inet->inet_opt, 1), rcu);
 	dst_release(rcu_dereference_protected(sk->sk_dst_cache, 1));
 	dst_release(rcu_dereference_protected(sk->sk_rx_dst, 1));
 	sk_refcnt_debug_dec(sk);
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index fb64f5fcc422..e7baf948c6dd 100644
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
index 32b55a6b5e03..3a4dce8ea95c 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1040,7 +1040,7 @@ static int tcp_v4_send_synack(const struct sock *sk, struct dst_entry *dst,
  */
 static void tcp_v4_reqsk_destructor(struct request_sock *req)
 {
-	kfree(rcu_dereference_protected(inet_rsk(req)->ireq_opt, 1));
+	kfree_rcu(rcu_dereference_protected(inet_rsk(req)->ireq_opt, 1), rcu);
 }
 
 #ifdef CONFIG_TCP_MD5SIG
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index a239efbb87ba..fb01f9119c39 100644
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
@@ -426,7 +441,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	case NFQNL_COPY_PACKET:
 		if (!(queue->flags & NFQA_CFG_F_GSO) &&
 		    entskb->ip_summed == CHECKSUM_PARTIAL &&
-		    skb_checksum_help(entskb))
+		    nf_queue_checksum_help(entskb))
 			return NULL;
 
 		data_len = READ_ONCE(queue->copy_range);
@@ -831,7 +846,7 @@ nfqnl_enqueue_packet(struct nf_queue_entry *entry, unsigned int queuenum)
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
index 3e27daceebfe..a8ecd407b562 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -752,16 +752,22 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
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
 
