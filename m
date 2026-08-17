Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A606F29E116
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970879; cv=none; b=pLC18cpbbV9Sr4x0bYRd2FTzj8EiAzphx6dAp46f8NUdBfNjvaAsRbXBVTOeFyUkigAjxjU+1a5KamLzDSfdF0ZG4xeb3RsVaVHYlN5ACMxfJcDIzr8K4XeBN/VyfsFeJ88XL32Dykly/xEoKhVqE6r1MchaKEUSeaUPysNj7tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970879; c=relaxed/simple;
	bh=fdeROv/LgoP17I4rLZQSjcu3QSPy47pLPbvNdtHbS6M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dKvrfxMmawt2qEL7EZX1yaQm5UlmRzBzppLBoizmJ5qt1IQNWlPLvgIDaaN6lmBwyfl6MrnKpweLDqrfd9kUEjN/5GgBp2dqOjPH9HTsIcsQsBY1L1vk/Mrw+/200m8xRQMelzhBNuQEwVnv9LOTz2d3lZJ28zICASnh+NxN9PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tFldFvxc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tFldFvxc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031771F000E9;
	Mon, 17 Aug 2026 12:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786970875;
	bh=sBOc1n5DxuU7CZY+z10dA84lN61YflgYcJUJZ79yJro=;
	h=Subject:To:Cc:From:Date;
	b=tFldFvxc7NboCeSYgCqWUjrb4HJJoGP7PjfzbuyyiIVDfBUyx/xQs0r4etzLgiPPd
	 QCqf6S4Peqx0Udhi4MvEZHq4UWe7QvTYnF9jRRYSLdoiqEVw74Wk+QzBz6D7YLZV1I
	 Qjw7Hkcb456j3h2LR8doycLe9iExo/tNBKYhszk8=
Subject: FAILED: patch "[PATCH] veth: fix skb length accounting after XDP frag adjustment" failed to apply to 6.1-stable tree
To: sun.jian.kdev@gmail.com,kuba@kernel.org,lorenzo@kernel.org,mohsin.bashr@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:47:50 +0200
Message-ID: <2026081750-parcel-sulfur-b578@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x cb6379feaaff11c4e1e79c26c745ffa23182768a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081750-parcel-sulfur-b578@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cb6379feaaff11c4e1e79c26c745ffa23182768a Mon Sep 17 00:00:00 2001
From: Sun Jian <sun.jian.kdev@gmail.com>
Date: Mon, 3 Aug 2026 22:40:39 -0700
Subject: [PATCH] veth: fix skb length accounting after XDP frag adjustment

veth exposes non-linear skb fragments through an xdp_buff. If an XDP
program adjusts the fragment area, veth_xdp_rcv_skb() copies
xdp_frags_size back to skb->data_len but leaves skb->len containing the
old fragment contribution.

After a fragment shrink, this makes skb_headlen() larger than the actual
linear area. In the reproduced UDP receive path, __skb_datagram_iter()
copied 1024 bytes past the actual linear tail to userspace, starting at
struct skb_shared_info. The copied bytes included the affected skb's
nr_frags, xdp_frags_size, and a kernel pointer from
skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
amount and truncated at the end.

Subtract the old data_len before replacing it and add the new data_len
afterwards, keeping skb->len and skb->data_len synchronized.

Additionally, bpf_xdp_pull_data() can advance data_end while leaving
frags present. The skb is then still non-linear, so the old
__skb_put(skb, off) triggers SKB_LINEAR_ASSERT().

Use skb_set_tail_pointer() and update skb->len explicitly instead,
following bpf_prog_run_generic_xdp(). Unlike __skb_put(),
skb_set_tail_pointer() does not require a linear skb.

A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened by
1024 bytes from its fragment area. Before the fix, all 10 runs produced
corrupted payloads. After the fix, all 10 runs matched the expected
payload exactly. A forced-tailroom reproducer also exercises
bpf_xdp_pull_data() with frags still present; the old code triggers
SKB_LINEAR_ASSERT(), while this fix passes 10/10 runs.

Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept non-linear skb")
Cc: stable@vger.kernel.org
Reported-by: Mohsin Bashir <mohsin.bashr@gmail.com>
Link: https://lore.kernel.org/bpf/80687d9c-9c27-494c-b3f2-efd0230b1895@gmail.com/
Suggested-by: Lorenzo Bianconi <lorenzo@kernel.org>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
Link: https://patch.msgid.link/20260804054040.613675-3-sun.jian.kdev@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 00e34afd858e..f80f6584a6ff 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -865,18 +865,24 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 
 	skb_reset_mac_header(skb);
 
-	/* check if bpf_xdp_adjust_tail was used */
-	off = xdp->data_end - orig_data_end;
-	if (off != 0)
-		__skb_put(skb, off); /* positive on grow, negative on shrink */
-
 	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
-	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
+	 * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribution
+	 * from skb->len before updating data_len, then add the new one back.
 	 */
-	if (xdp_buff_has_frags(xdp))
+	skb->len -= skb->data_len;
+	if (xdp_buff_has_frags(xdp)) {
 		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
-	else
+		skb->len += skb->data_len;
+	} else {
 		skb->data_len = 0;
+	}
+
+	/* Synchronize the skb tail with XDP's updated linear area. */
+	off = xdp->data_end - orig_data_end;
+	if (off != 0) {
+		skb_set_tail_pointer(skb, xdp->data_end - xdp->data);
+		skb->len += off; /* positive on grow, negative on shrink */
+	}
 
 	skb->protocol = eth_type_trans(skb, rq->dev);
 

