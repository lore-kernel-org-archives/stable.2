Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A59142CB02
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929614; cv=none; b=Jj/n1kndFXH8n+/4ct7jNmDo/uHSq+TWSpGwcUszad4etbh5Kes7iUs/aD6PZTi6Y2gsyy39tRDB4HdOX5K9vhw8g6HNYh1pEwLvkCu4Qht2PSNIFf6OPcDW7UwSzeQr/E9yEPn25W6NpxJ7/cWkVhTAcanyHfDNfp6jWCvs7ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929614; c=relaxed/simple;
	bh=/MXAPx+xgskwS8aX7pmYTo4LgwSQiHayvGN4SdNa/zs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qcJgMN2Or6fs4QfzvHNLmD9cUQAm+OZxJllehI9NS/4LC8z2A5AhciI9J6crWs2z4q0P2amA9TlCx5CjDKpSBu11Yxl0PDpR0lwJa3JFKDablNiE5UqofKSOxrjvMFVUjGD8j6bUyyayrcjFmHtT19fg/sNy29LuKWIxUdIT73U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i5zj1kVM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i5zj1kVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7332C1F000E9;
	Wed,  5 Aug 2026 11:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785929613;
	bh=c5yi+Mp/W7hP5vPbfrdiR/ZOdlXrTC32q8Kka4YK8DQ=;
	h=Subject:To:Cc:From:Date;
	b=i5zj1kVMPVo9W0q9z3kbmwv40+426wJwR0fFLmMxCPrv96xCz0PndGkdGfbYSSKny
	 RZ+Qypth80FzUwurvFzxuI1QiKpcXybx+to/F9mtJdRC02qJEZ2FUIJ0zTafhm6iIh
	 NIawM04lr7RWeNWyASBB+OOaOJMU3jaazoKp/+I8=
Subject: FAILED: patch "[PATCH] veth: convert frag_list skbs before running XDP" failed to apply to 6.1-stable tree
To: mfleming@cloudflare.com,kuba@kernel.org,lorenzo@kernel.org,toke@toke.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:33:08 +0200
Message-ID: <2026080508-marbling-excuse-5244@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d0d6415963040c401e7a7e4e482a698ba52448cb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080508-marbling-excuse-5244@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

