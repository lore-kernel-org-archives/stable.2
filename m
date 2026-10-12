Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2539CA4E
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791784031; cv=none; b=isjEWCbmaDMXDywvpce0k3YUzS2XhXAhXLRCL+IUhjQE3Q6+ls/bp+NCbhJhV7imptE/Kmg82dC6PE8qhBzK21B1CsqywywImz/Y9dZEsvniNqL6uS0lXMFokFlVI2bPo1WaHGXx80++bXeCrMCIguZhZXGHdNm25hQSbmQHSHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791784031; c=relaxed/simple;
	bh=JKtx164rQ3IBnQ98CXs3p4GB7yxaiC1CiGR6/2EuIwc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y7lQH2BEYpzOyVFfu8ZdS1zYU2z76n9TLBf0dTh1insaKUYhjVkkmEkPolgU+QZfPTP7umH9sgCMg8rfWTnHyTr5M5t3MIyQp+sJfuiM9/50AIYZvEe/i/Y+wx8EKw0+Yi/stunFHxvaFW1xu2/9oKunlwM1g/t1jGOKbBaov3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0IJ9Z13D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0IJ9Z13D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65D91F0089B;
	Mon, 12 Oct 2026 05:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791784029;
	bh=FX2eyj8Ih1e9bCXNDN8lr9vroAq2I5QeetjcB91Jhak=;
	h=Subject:To:Cc:From:Date;
	b=0IJ9Z13Dy/42C8kg5ag/RVLuZ+kIymF43N2vCJGnLPAfcl1zDlm1vumQGONWw00Zs
	 hTFLpcaIPsSPAfHFf+8vuTpyEEqyoeH1bmfJtnAkZScFLTJWcSeZ/M90sxZ5fzWx5w
	 VRpw4v6DE1iSCs/BqpdOGB3aZrinV0aQSH+1d45w=
Subject: FAILED: patch "[PATCH] packet: Add GSO/csum offload support." failed to apply to 5.15-stable tree
To: sri@us.ibm.com,davem@davemloft.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 07:46:53 +0200
Message-ID: <2026101253-lapdog-dragonish-3b23@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x bfd5f4a3d605e0f6054df0b59fe0907ff7e696d3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101253-lapdog-dragonish-3b23@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bfd5f4a3d605e0f6054df0b59fe0907ff7e696d3 Mon Sep 17 00:00:00 2001
From: Sridhar Samudrala <sri@us.ibm.com>
Date: Thu, 4 Feb 2010 20:24:10 -0800
Subject: [PATCH] packet: Add GSO/csum offload support.

This patch adds GSO/checksum offload to af_packet sockets using
virtio_net_hdr. Based on Rusty's patch to add this support to tun.
It allows GSO/checksum offload to be enabled when using raw socket
backend with virtio_net.
Adds PACKET_VNET_HDR socket option to prepend virtio_net_hdr in the
receive path and process/skip virtio_net_hdr in the send path. This
option is only allowed with SOCK_RAW sockets attached to ethernet
type devices.

v2 updates
----------
Michael's Comments
- Perform length check in packet_snd() when GSO is off even when
  vnet_hdr is present.
- Check for SKB_GSO_FCOE type and return -EINVAL
- don't allow tx/rx ring when vnet_hdr is enabled.
Herbert's Comments
- Removed ethernet specific code.
- protocol value is assumed to be passed in by the caller.

Signed-off-by: Sridhar Samudrala <sri@us.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/include/linux/if_packet.h b/include/linux/if_packet.h
index 4021d47cc437..aa57a5f993fc 100644
--- a/include/linux/if_packet.h
+++ b/include/linux/if_packet.h
@@ -46,6 +46,7 @@ struct sockaddr_ll {
 #define PACKET_RESERVE			12
 #define PACKET_TX_RING			13
 #define PACKET_LOSS			14
+#define PACKET_VNET_HDR			15
 
 struct tpacket_stats {
 	unsigned int	tp_packets;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 53633c5fdb1d..178e2937bbaa 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -80,6 +80,7 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/if_vlan.h>
+#include <linux/virtio_net.h>
 
 #ifdef CONFIG_INET
 #include <net/inet_common.h>
@@ -193,7 +194,8 @@ struct packet_sock {
 	struct mutex		pg_vec_lock;
 	unsigned int		running:1,	/* prot_hook is attached*/
 				auxdata:1,
-				origdev:1;
+				origdev:1,
+				has_vnet_hdr:1;
 	int			ifindex;	/* bound device		*/
 	__be16			num;
 	struct packet_mclist	*mclist;
@@ -1056,6 +1058,30 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 }
 #endif
 
+static inline struct sk_buff *packet_alloc_skb(struct sock *sk, size_t prepad,
+					       size_t reserve, size_t len,
+					       size_t linear, int noblock,
+					       int *err)
+{
+	struct sk_buff *skb;
+
+	/* Under a page?  Don't bother with paged skb. */
+	if (prepad + len < PAGE_SIZE || !linear)
+		linear = len;
+
+	skb = sock_alloc_send_pskb(sk, prepad + linear, len - linear, noblock,
+				   err);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, reserve);
+	skb_put(skb, linear);
+	skb->data_len = len - linear;
+	skb->len += len - linear;
+
+	return skb;
+}
+
 static int packet_snd(struct socket *sock,
 			  struct msghdr *msg, size_t len)
 {
@@ -1066,14 +1092,17 @@ static int packet_snd(struct socket *sock,
 	__be16 proto;
 	unsigned char *addr;
 	int ifindex, err, reserve = 0;
+	struct virtio_net_hdr vnet_hdr = { 0 };
+	int offset = 0;
+	int vnet_hdr_len;
+	struct packet_sock *po = pkt_sk(sk);
+	unsigned short gso_type = 0;
 
 	/*
 	 *	Get and verify the address.
 	 */
 
 	if (saddr == NULL) {
-		struct packet_sock *po = pkt_sk(sk);
-
 		ifindex	= po->ifindex;
 		proto	= po->num;
 		addr	= NULL;
@@ -1100,25 +1129,74 @@ static int packet_snd(struct socket *sock,
 	if (!(dev->flags & IFF_UP))
 		goto out_unlock;
 
+	if (po->has_vnet_hdr) {
+		vnet_hdr_len = sizeof(vnet_hdr);
+
+		err = -EINVAL;
+		if (len < vnet_hdr_len)
+			goto out_unlock;
+
+		len -= vnet_hdr_len;
+
+		err = memcpy_fromiovec((void *)&vnet_hdr, msg->msg_iov,
+				       vnet_hdr_len);
+		if (err < 0)
+			goto out_unlock;
+
+		if ((vnet_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
+		    (vnet_hdr.csum_start + vnet_hdr.csum_offset + 2 >
+		      vnet_hdr.hdr_len))
+			vnet_hdr.hdr_len = vnet_hdr.csum_start +
+						 vnet_hdr.csum_offset + 2;
+
+		err = -EINVAL;
+		if (vnet_hdr.hdr_len > len)
+			goto out_unlock;
+
+		if (vnet_hdr.gso_type != VIRTIO_NET_HDR_GSO_NONE) {
+			switch (vnet_hdr.gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+			case VIRTIO_NET_HDR_GSO_TCPV4:
+				gso_type = SKB_GSO_TCPV4;
+				break;
+			case VIRTIO_NET_HDR_GSO_TCPV6:
+				gso_type = SKB_GSO_TCPV6;
+				break;
+			case VIRTIO_NET_HDR_GSO_UDP:
+				gso_type = SKB_GSO_UDP;
+				break;
+			default:
+				goto out_unlock;
+			}
+
+			if (vnet_hdr.gso_type & VIRTIO_NET_HDR_GSO_ECN)
+				gso_type |= SKB_GSO_TCP_ECN;
+
+			if (vnet_hdr.gso_size == 0)
+				goto out_unlock;
+
+		}
+	}
+
 	err = -EMSGSIZE;
-	if (len > dev->mtu+reserve)
+	if (!gso_type && (len > dev->mtu+reserve))
 		goto out_unlock;
 
-	skb = sock_alloc_send_skb(sk, len + LL_ALLOCATED_SPACE(dev),
-				msg->msg_flags & MSG_DONTWAIT, &err);
+	err = -ENOBUFS;
+	skb = packet_alloc_skb(sk, LL_ALLOCATED_SPACE(dev),
+			       LL_RESERVED_SPACE(dev), len, vnet_hdr.hdr_len,
+			       msg->msg_flags & MSG_DONTWAIT, &err);
 	if (skb == NULL)
 		goto out_unlock;
 
-	skb_reserve(skb, LL_RESERVED_SPACE(dev));
-	skb_reset_network_header(skb);
+	skb_set_network_header(skb, reserve);
 
 	err = -EINVAL;
 	if (sock->type == SOCK_DGRAM &&
-	    dev_hard_header(skb, dev, ntohs(proto), addr, NULL, len) < 0)
+	    (offset = dev_hard_header(skb, dev, ntohs(proto), addr, NULL, len)) < 0)
 		goto out_free;
 
 	/* Returns -EFAULT on error */
-	err = memcpy_fromiovec(skb_put(skb, len), msg->msg_iov, len);
+	err = skb_copy_datagram_from_iovec(skb, offset, msg->msg_iov, 0, len);
 	if (err)
 		goto out_free;
 
@@ -1127,6 +1205,25 @@ static int packet_snd(struct socket *sock,
 	skb->priority = sk->sk_priority;
 	skb->mark = sk->sk_mark;
 
+	if (po->has_vnet_hdr) {
+		if (vnet_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
+			if (!skb_partial_csum_set(skb, vnet_hdr.csum_start,
+						  vnet_hdr.csum_offset)) {
+				err = -EINVAL;
+				goto out_free;
+			}
+		}
+
+		skb_shinfo(skb)->gso_size = vnet_hdr.gso_size;
+		skb_shinfo(skb)->gso_type = gso_type;
+
+		/* Header must be checked, and gso_segs computed. */
+		skb_shinfo(skb)->gso_type |= SKB_GSO_DODGY;
+		skb_shinfo(skb)->gso_segs = 0;
+
+		len += vnet_hdr_len;
+	}
+
 	/*
 	 *	Now send it
 	 */
@@ -1420,6 +1517,7 @@ static int packet_recvmsg(struct kiocb *iocb, struct socket *sock,
 	struct sk_buff *skb;
 	int copied, err;
 	struct sockaddr_ll *sll;
+	int vnet_hdr_len = 0;
 
 	err = -EINVAL;
 	if (flags & ~(MSG_PEEK|MSG_DONTWAIT|MSG_TRUNC|MSG_CMSG_COMPAT))
@@ -1451,6 +1549,48 @@ static int packet_recvmsg(struct kiocb *iocb, struct socket *sock,
 	if (skb == NULL)
 		goto out;
 
+	if (pkt_sk(sk)->has_vnet_hdr) {
+		struct virtio_net_hdr vnet_hdr = { 0 };
+
+		err = -EINVAL;
+		vnet_hdr_len = sizeof(vnet_hdr);
+		if ((len -= vnet_hdr_len) < 0)
+			goto out_free;
+
+		if (skb_is_gso(skb)) {
+			struct skb_shared_info *sinfo = skb_shinfo(skb);
+
+			/* This is a hint as to how much should be linear. */
+			vnet_hdr.hdr_len = skb_headlen(skb);
+			vnet_hdr.gso_size = sinfo->gso_size;
+			if (sinfo->gso_type & SKB_GSO_TCPV4)
+				vnet_hdr.gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
+			else if (sinfo->gso_type & SKB_GSO_TCPV6)
+				vnet_hdr.gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
+			else if (sinfo->gso_type & SKB_GSO_UDP)
+				vnet_hdr.gso_type = VIRTIO_NET_HDR_GSO_UDP;
+			else if (sinfo->gso_type & SKB_GSO_FCOE)
+				goto out_free;
+			else
+				BUG();
+			if (sinfo->gso_type & SKB_GSO_TCP_ECN)
+				vnet_hdr.gso_type |= VIRTIO_NET_HDR_GSO_ECN;
+		} else
+			vnet_hdr.gso_type = VIRTIO_NET_HDR_GSO_NONE;
+
+		if (skb->ip_summed == CHECKSUM_PARTIAL) {
+			vnet_hdr.flags = VIRTIO_NET_HDR_F_NEEDS_CSUM;
+			vnet_hdr.csum_start = skb->csum_start -
+							skb_headroom(skb);
+			vnet_hdr.csum_offset = skb->csum_offset;
+		} /* else everything is zero */
+
+		err = memcpy_toiovec(msg->msg_iov, (void *)&vnet_hdr,
+				     vnet_hdr_len);
+		if (err < 0)
+			goto out_free;
+	}
+
 	/*
 	 *	If the address length field is there to be filled in, we fill
 	 *	it in now.
@@ -1502,7 +1642,7 @@ static int packet_recvmsg(struct kiocb *iocb, struct socket *sock,
 	 *	Free or return the buffer as appropriate. Again this
 	 *	hides all the races and re-entrancy issues from us.
 	 */
-	err = (flags&MSG_TRUNC) ? skb->len : copied;
+	err = vnet_hdr_len + ((flags&MSG_TRUNC) ? skb->len : copied);
 
 out_free:
 	skb_free_datagram(sk, skb);
@@ -1740,6 +1880,8 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 
 		if (optlen < sizeof(req))
 			return -EINVAL;
+		if (pkt_sk(sk)->has_vnet_hdr)
+			return -EINVAL;
 		if (copy_from_user(&req, optval, sizeof(req)))
 			return -EFAULT;
 		return packet_set_ring(sk, &req, 0, optname == PACKET_TX_RING);
@@ -1826,6 +1968,22 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 		po->origdev = !!val;
 		return 0;
 	}
+	case PACKET_VNET_HDR:
+	{
+		int val;
+
+		if (sock->type != SOCK_RAW)
+			return -EINVAL;
+		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec)
+			return -EBUSY;
+		if (optlen < sizeof(val))
+			return -EINVAL;
+		if (copy_from_user(&val, optval, sizeof(val)))
+			return -EFAULT;
+
+		po->has_vnet_hdr = !!val;
+		return 0;
+	}
 	default:
 		return -ENOPROTOOPT;
 	}
@@ -1874,6 +2032,13 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
 			len = sizeof(int);
 		val = po->origdev;
 
+		data = &val;
+		break;
+	case PACKET_VNET_HDR:
+		if (len > sizeof(int))
+			len = sizeof(int);
+		val = po->has_vnet_hdr;
+
 		data = &val;
 		break;
 #ifdef CONFIG_PACKET_MMAP

