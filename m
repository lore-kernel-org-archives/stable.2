Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0951F42CB02
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929606; cv=none; b=kOjawuwKDF/ec7jLg6lkfQVz9eA5uQSMT+ECmH2oxiHf/wNIvFm+lKP+KKaDjHW2fNYsf12GiuwnqtdtS+swLxu3Ck23btmEawNNuVO8Eyd5Ib27KktpTLtKjfznI6CdmV7H2+K7BAD0yHz02Ud3hvm9b6uFFcAfzz/7Hy8tEyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929606; c=relaxed/simple;
	bh=QGW3DXOT9whq23Mj0DO7S5KSsylK+EVUwXqUMf2tUs8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=khcJbajoDv5Q8aQyzZYSHXFYDdU/qfsB/tW9MJlbYhOJP3pv7OYZB72SAtDcYc3aPhKjD0SNwo6OZFnD9HX5lk5+6QadxcsZ3zeyRkUbmjTHr0rZ8g6wBJk00FjRmcS7qxFuEXQPUyq2dZEUGqIAvOm04mjbgZN6734XtnopqeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YVsxoVuz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YVsxoVuz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159E51F00A3A;
	Wed,  5 Aug 2026 11:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785929604;
	bh=t+Rqk7053liS3yxSnXq3MiBjrLq+b00b2vdgGZWTbXQ=;
	h=Subject:To:Cc:From:Date;
	b=YVsxoVuzkX24xNuYr9bLnijehyDnMktC6T7UkARy/OQHZTfCikNx0O4FnQPY7c6ST
	 4iRmkXwUygNeDDpjvLRvuYLPHiK6DP0IYXIMGkMbPaxquIQpzV38Vdru/S+fz87WO3
	 JbASkY+vHL6wgsMIqb+aTeovUmBbdnm+UH7cwBJE=
Subject: FAILED: patch "[PATCH] veth: convert frag_list skbs before running XDP" failed to apply to 6.6-stable tree
To: mfleming@cloudflare.com,kuba@kernel.org,lorenzo@kernel.org,toke@toke.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:33:07 +0200
Message-ID: <2026080507-delighted-scouring-7597@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d0d6415963040c401e7a7e4e482a698ba52448cb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080507-delighted-scouring-7597@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d0d6415963040c401e7a7e4e482a698ba52448cb Mon Sep 17 00:00:00 2001
From: Matt Fleming <mfleming@cloudflare.com>
Date: Wed, 22 Jul 2026 20:19:25 +0100
Subject: [PATCH] veth: convert frag_list skbs before running XDP
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A frag_list skb can reach veth with data_len set but nr_frags zero.
veth_convert_skb_to_xdp_buff() only converts skbs that are shared,
locked, have frags[], or do not have enough headroom. It later uses
skb_is_nonlinear() to decide whether to set XDP_FLAGS_HAS_FRAGS and
xdp_frags_size.

That exposes frag_list data to XDP as if it were stored in frags[], but
frags[] is empty. AF_XDP copy mode can then trust the bogus XDP fragment
metadata, walk an empty fragment entry, and crash in memcpy() from
__xsk_rcv().

Route non-linear skbs through skb_pp_cow_data() before exposing them to
XDP, and only advertise XDP frags when the resulting skb has frags[].
skb_copy_bits() already handles frag_list input, and skb_pp_cow_data()
builds frags[] output with skb_add_rx_frag(), which is the
representation XDP multi-buffer expects.

Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept non-linear skb")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@toke.dk>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20260722191925.2192070-1-matt@readmodwrite.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 1c5142149175..00e34afd858e 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -756,7 +756,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	u32 frame_sz;
 
 	if (skb_shared(skb) || skb_head_is_locked(skb) ||
-	    skb_shinfo(skb)->nr_frags ||
+	    skb_is_nonlinear(skb) ||
 	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
 		if (skb_pp_cow_data(rq->page_pool, pskb, XDP_PACKET_HEADROOM))
 			goto drop;
@@ -771,7 +771,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
 			 skb_headlen(skb), true);
 
-	if (skb_is_nonlinear(skb)) {
+	if (skb_shinfo(skb)->nr_frags) {
 		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
 		xdp_buff_set_frags_flag(xdp);
 	} else {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 18dabb4e9cfa..ba3dbac80fb4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -927,6 +927,18 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }
 
+/**
+ * skb_pp_cow_data() - copy skb data into page-pool backed storage
+ * @pool: page pool to allocate from
+ * @pskb: pointer to skb pointer, replaced with the copied skb on success
+ * @headroom: headroom to reserve in the copied skb
+ *
+ * skb_copy_bits() handles both frags[] and frag_list input. If the copied
+ * skb remains non-linear, it uses frags[], which is the representation used
+ * by XDP multi-buffer.
+ *
+ * Return: 0 on success or a negative errno on failure.
+ */
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		    unsigned int headroom)
 {
@@ -936,12 +948,6 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 	int err, i, head_off;
 	void *data;
 
-	/* XDP does not support fraglist so we need to linearize
-	 * the skb.
-	 */
-	if (skb_has_frag_list(skb))
-		return -EOPNOTSUPP;
-
 	max_head_size = SKB_WITH_OVERHEAD(PAGE_SIZE - headroom);
 	if (skb->len > max_head_size + MAX_SKB_FRAGS * PAGE_SIZE)
 		return -ENOMEM;

