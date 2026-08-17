Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907123F6C22
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967464; cv=none; b=Ab/Q69iqYIUPhGzE0cCDfmvzT695jcxBtaqT4oPeWFsFwjrXcS9rkWmF1FQ1LnD/Jdbh5hSMygi//3OlJidUbGt4xa6Nl0P5sOPmeDiE2aiK/F7htpLtKl5Wv6ssNTC52B5CQ8RlDsCbvg01//mF/0cD1Y0DSWcAixandMx+hJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967464; c=relaxed/simple;
	bh=Rb+PG2Xoo6f1d3pwtGJNGKngwBVPdNavp02FhKE0vZw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RyX1PLVSMoyTj9R4VCknR8ueyULG7kX5zlEB9Gk7y2u3eWhJox9B8snnUd/PuM8Uw9e3R8px3LUvbbGC+s46O4VfAWYaWbuW7w8Yniv84hLaMko87x1HsL7Fc3mf/EgV+oixVAWDEXiKHTer4MKtt6upQ8ruOi5bsvPpCtnqskU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JpC6HcJ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JpC6HcJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5121F000E9;
	Mon, 17 Aug 2026 11:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786967463;
	bh=ZQr5cZiTB+zpk2AyaNPhpAm7Y8mClQDuGX3IyYheKkI=;
	h=Subject:To:Cc:From:Date;
	b=JpC6HcJ6T4vw7PMWrir3WSCxpWu7tkj8IPvJvDTCnXsG7ZLq3BKdr2Jl4hcXaHAkt
	 6EIiEAUvjnxUpVaS8K4ZiVxtw1FjP7kqf6h1flNkLIfcSwu8yrkN10U9BgR7cTJafl
	 vUHiiZ8N17xhEV+dFzNX1wb4HwgSGD/1qTAmOr3U=
Subject: FAILED: patch "[PATCH] packet: use consistent hard_header_len in TX_RING send path" failed to apply to 5.15-stable tree
To: q.h.hack.winter@gmail.com,kuba@kernel.org,willemb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 13:50:46 +0200
Message-ID: <2026081746-railing-baffling-3449@gregkh>
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
git cherry-pick -x 21b5953e7494c16a42e6cd8cf110e18d13ae4a6b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081746-railing-baffling-3449@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 21b5953e7494c16a42e6cd8cf110e18d13ae4a6b Mon Sep 17 00:00:00 2001
From: Qihang Tang <q.h.hack.winter@gmail.com>
Date: Wed, 5 Aug 2026 20:57:29 +0800
Subject: [PATCH] packet: use consistent hard_header_len in TX_RING send path

tpacket_snd() reads dev->hard_header_len independently for skb
allocation and header construction in tpacket_fill_skb(). Concurrent
netdevice reconfiguration can therefore make the reserved headroom
smaller than the amount later pushed, or make copylen - hard_header_len
negative.

Snapshot hard_header_len once before processing ring frames and use it
for the frame limit, headroom allocation, copy length, and skb
construction. Pass the snapshot to tpacket_fill_skb().

The separate SOCK_DGRAM consistency problem between hard_header_len and
header_ops->create is not addressed here.

Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang Tang <q.h.hack.winter@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260805125729.19220-4-q.h.hack.winter@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index b7af45c809e4..435756877aba 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2587,6 +2587,7 @@ static int packet_snd_vnet_parse(struct msghdr *msg, size_t *len,
 static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 		void *frame, struct net_device *dev, void *data, int tp_len,
 		__be16 proto, unsigned char *addr, int hlen, int copylen,
+		int hard_header_len,
 		const struct sockcm_cookie *sockc)
 {
 	union tpacket_uhdr ph;
@@ -2618,8 +2619,8 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	} else if (copylen) {
 		int hdrlen = min_t(int, copylen, tp_len);
 
-		skb_push(skb, dev->hard_header_len);
-		skb_put(skb, copylen - dev->hard_header_len);
+		skb_push(skb, hard_header_len);
+		skb_put(skb, copylen - hard_header_len);
 		err = skb_store_bits(skb, 0, data, hdrlen);
 		if (unlikely(err))
 			return err;
@@ -2750,7 +2751,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	void *data;
 	int len_sum = 0;
 	int status = TP_STATUS_AVAILABLE;
-	int hlen, tlen, copylen = 0;
+	int hard_header_len, hlen, tlen, copylen = 0;
 	long timeo;
 
 	mutex_lock(&po->pg_vec_lock);
@@ -2797,8 +2798,9 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto out_put;
 	}
 
+	hard_header_len = READ_ONCE(dev->hard_header_len);
 	if (po->sk.sk_socket->type == SOCK_RAW)
-		reserve = dev->hard_header_len;
+		reserve = hard_header_len;
 	size_max = po->tx_ring.frame_size
 		- (po->tp_hdrlen - sizeof(struct sockaddr_ll));
 
@@ -2835,7 +2837,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto tpacket_error;
 
 		status = TP_STATUS_SEND_REQUEST;
-		hlen = LL_RESERVED_SPACE(dev);
+		hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
 		tlen = dev->needed_tailroom;
 		if (vnet_hdr_sz) {
 			data += vnet_hdr_sz;
@@ -2853,10 +2855,10 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 						    vnet_hdr.hdr_len);
 			has_vnet_hdr = true;
 		}
-		copylen = max_t(int, copylen, dev->hard_header_len);
+		copylen = max_t(int, copylen, hard_header_len);
 		skb = sock_alloc_send_skb(&po->sk,
 				hlen + tlen + sizeof(struct sockaddr_ll) +
-				(copylen - dev->hard_header_len),
+				(copylen - hard_header_len),
 				!need_wait, &err);
 
 		if (unlikely(skb == NULL)) {
@@ -2866,7 +2868,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto out_status;
 		}
 		tp_len = tpacket_fill_skb(po, skb, ph, dev, data, tp_len, proto,
-					  addr, hlen, copylen, &sockc);
+					  addr, hlen, copylen, hard_header_len,
+					  &sockc);
 		if (likely(tp_len >= 0) &&
 		    tp_len > dev->mtu + reserve &&
 		    !vnet_hdr_sz &&

