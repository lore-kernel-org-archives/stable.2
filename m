Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4677147A877
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151429; cv=none; b=TDhmBbzRix6R8kU4ouX2C+5qIOgqgfEI6TFJvoMBF2JnbbIN19hE6BT+BKH6wOXnZCQ82IzhJvHO7u8klzU3Qr5Z4HetmYnwyb/vBhZ9+tVuTc9HDmzqr6ebAcQLM7CemlPaPbOAH9M3udJfSK4SCaLWAwmxzcQYJaA2lBbhQOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151429; c=relaxed/simple;
	bh=ALJyWNvEZEZHSAVQOCi2T1YAHkP/KlTZOSct9cf5+2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aw0YvtvpmSyuszdydtihgDp9fovUMWKvIsjLYmCvbMcOayZfnP6WpyYmi4b/ziO64zP/Z9wuXdE6m6BKl+0wOhSnwG0+mH/XO1/cwT7O2R+0/0vEeKouSWu0RoufxfvcF8IJcslc9xDT89GtFgVLfXmy8OmdFxTVHdRqOLq/Nis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpHnPyLv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpHnPyLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B2F1F00A3A;
	Wed, 19 Aug 2026 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787151422;
	bh=bNmNhl9/rQfOJK199Hj3T7EBcXzxn5m9Fli/dVIEKHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dpHnPyLvE52WtgALgk1AkWiJ0QkxLIwtOFQRStotCd/5lJuZp600aJItkGlV5+yyk
	 5bfriUQlOewcOAswyQXSpOXluaqZjaVL2v65K+EXjYzsuwiJ2biXJ/TsW1GdGbnd0K
	 2jYyF8MXzqhfo3ByD5BsPeBGFsAuG3J8CsGYLBIwFXXRt+6aXNjB9yfE/cTz49ikSH
	 iQUqDlXnWkxn/C3NII/l5YzsbeXaPw5Fq79w7kwmjPjSis1h8N83LUK2ae1mKxs4tB
	 wSDMm9LyHIU7ulh9HviE95rO+FhqE3GeBtqjZ6MeM4X23tnf2kl+ql3/h2t8uA7XFF
	 sF7DamvPGC3PQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sun Jian <sun.jian.kdev@gmail.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] veth: fix skb length accounting after XDP frag adjustment
Date: Wed, 19 Aug 2026 10:56:58 -0400
Message-ID: <20260819145658.3901994-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819145658.3901994-1-sashal@kernel.org>
References: <2026081750-parcel-sulfur-b578@gregkh>
 <20260819145658.3901994-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sun Jian <sun.jian.kdev@gmail.com>

[ Upstream commit cb6379feaaff11c4e1e79c26c745ffa23182768a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/veth.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index e37fda3069cc..e7049b48825f 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -868,18 +868,24 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 
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
 
-- 
2.53.0

