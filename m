Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB61A9F96
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 05:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785822067; cv=none; b=osFb2+k+Apho5tzVst/sRPK9qa4navEWOYtXGIHgbch+NL7F1Tx8VbSUT/Vngr/eA1vjXgxP8dXGMKQQktL7sHY/KGnGMnW6AHOBuqwEkQE5wMl2HjdIg/re2+GV81pZ7yYZfuEs2wHgxJyjDuhiEs+AtD7o0hbReMaPp0u21a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785822067; c=relaxed/simple;
	bh=Q9Zjp3I9pBir8KDg6eL1VgCK+F5yHVCmOmThi2HVJSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEc70GO6Brnm9GwRGgW2BO1Bckhb3MOUQe3G55haf5ZQ7UMacgKNqvM69ls+frpVcsyZL9QtwJKniil9daAy5LZIzCk3H3XmAK8J5wmfxr4Cv7a7CppKzKbBEviNPdj3K3yi5zycf/Tg9wmSA0etSRYBzXHMmexOMrzvRmnE5uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oIPZ23BP; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIPZ23BP"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so4875517b3a.2
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 22:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785822065; x=1786426865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UAxgFdZ6v+I2ajwY1kMmxdMZU7gGzS8VeggrnnIGVU0=;
        b=oIPZ23BP6yHz5cwvCPTvTbVkZABd9GvclWqSbjzmoaxYwpIw3cuTnLlAQrLajVFnIa
         703i0BXDj6dymTwROUtkO7G9bAVkdU9dAwZ8O03ASNovdWR7fdVXs7mozfupu3h/RjQN
         wHMBHj6bzmLbnbKK0Yb4vmL1SQp7OPFVcWFjB71i0SaYqY76+z7q71xlmvSQa+z09FoS
         Xq+AL+b8234fqGkhkFLsMW7lD5oC6ad9FTIHcVVXOhsreHuVT9nzQN0LYNh9yh1IxyBf
         qMiQu54qSf0mMMmbbgofzFXKCN33DFNDb1sdKuMMGqRdQ6lvBjEsNJqMxz9ANWQNLkJB
         pJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785822065; x=1786426865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UAxgFdZ6v+I2ajwY1kMmxdMZU7gGzS8VeggrnnIGVU0=;
        b=KAdOLxMHgSgHH92zWK9ELvAl5vlZGfmRGasHsg7DmOne/mudpJsWyEDGN+ZTPANBDK
         xBadgheBFh5HAnYDe7gVp9CDPjSQyCpCsBUhTzGWSx75flJN6y6BnuLYMOhh89axncIg
         2h7YwVthjl4gMZ54xtETz3UshSg6bCGuMjmBM4fATzeZD5W8u9FDEhbK7epnLGpZrRS+
         f9SBzlDRz6W9oqL91j01k7+hfdvIPN6AviV1Mtb+sVIFEryvLcrHdje++JipHdldYYHF
         75h07TXG8W2dHYKtsfuxQqU3qpnaNyF9z5VaIzHiWT0ZRke0+iwDA9oaaLoAItrd63gl
         bE7w==
X-Forwarded-Encrypted: i=1; AHgh+RqBHbX36BqCCKK3GsllsYvCqRYKx5GKCIwdSCqMUeu0rMVb60RLw0GVf0uUrGTdUmHOrRI8MH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNzmBPdrCF6ygmwNqODCf3jaIMUhkSJmhvd3uduLxP4Ul0TyQl
	9RHyKfRENItQfGu7TtTbzvHIGmhPjfFy+ijNxksjf3vzM7snn5XL6jqd
X-Gm-Gg: AR+sD12XQIR/M1gqQkqsQJPh/g36DIr12J+V9hK/chziFUHJ9CPm/hx+AFe1PJlocsg
	8tXmI3+9yRz8Wq8d8U2bbCQgJSGkvH2zXcoDprW0K47UheVNOauIJlXaqy4E19+kLPqgiW1YYNw
	EdnsXH+FiCTavpKWbV1qlDJVnNbCZVcOzCMchTPUmlqfsxjcYH6HmoaPOuJ926ipyG66AH/+Gl+
	9TRa6D5PJuSXmUzgv2uOIJZfteED9iXStwh4xaYRC0sqrzxnaTCRP8ENqI5ItCyd5ltSQiIcbmT
	0Mlmijl4sH5/ovbN5JmnYCOrOpUcnMr1wSj0obcn9jq5P0ItkivbzpJNJmysKrSJknffZhL5hNJ
	cmFzliDsPNb3x3ODIj/n24oaY0L1Qv8C1a7ghaEsqw1oOcxIu+t6A4d4lVOONseuXOt11Dnj3lL
	1LvBzq3AwoNCgWHMOseExpfnjlJlobtbIWtRm5zsOblCZcA2M0KD/1PMXKn5t+AM337+efqcLVt
	KJxtlNpH/GkzAnP3dQFzOiXYJtzkm0nTNDtmIw2IBR31v7nqtZj5zeXVr5CXQZHV9KLiGWAleoF
	2WrdjrebEL1e
X-Received: by 2002:a05:6a00:9513:b0:848:2f73:8fff with SMTP id d2e1a72fcca58-84ee493e7b5mr11233088b3a.72.1785822065267;
        Mon, 03 Aug 2026 22:41:05 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.localdomain ([60.168.97.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe5702bsm4678737b3a.16.2026.08.03.22.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:41:04 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: netdev@vger.kernel.org
Cc: Sun Jian <sun.jian.kdev@gmail.com>,
	stable@vger.kernel.org,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net v3 2/2] veth: fix skb length accounting after XDP frag adjustment
Date: Mon,  3 Aug 2026 22:40:39 -0700
Message-ID: <20260804054040.613675-3-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804054040.613675-1-sun.jian.kdev@gmail.com>
References: <20260804054040.613675-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/net/veth.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

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
 
-- 
2.43.0

