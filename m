Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5B356754
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 03:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785468266; cv=none; b=eoeTwJ2DwBI+Il1MJ5Y21IoVAe9GJzKDPP8djNa9eSDzy/sr7eVitPbFhnlxeAYL2hKdDzwCL4jYus8uLqMfX32uwABTjlCBFjyoj+IciiRiZOUzLrtFMHpUO6CHJsrfMoK/Cs8HT/NNNqDWDkITPVJn6TY9FZbBZfxoMLNPKag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785468266; c=relaxed/simple;
	bh=QCmNAq7aCQLV03SF/CeI12nYPYT+cLzDIfhbN9XF/Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/et9nww0fdq12c0WXI0kp3uLu12lMWTw5RUypMQC22OmR2/jmGyepQ46uR1jZDcNEHvf5eNgTZ/C/4ImYOeT6EkBuIM9SgavtYi0IzEembGaSrQByf/6oQbTniWdw6F4i+C3TbND+yCR1rLtgEoD2vws6xZb8xIML98f8m+cic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CM4rOyEK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CM4rOyEK"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2caf228a910so3092735ad.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 20:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785468264; x=1786073064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mDiNHR6lmF8BBewyLoqotO1eTvzYBv3I+mg7fsH65Xw=;
        b=CM4rOyEKWCE23uFCGnvBwbY/Qi/Afn+0rGiuEYXyoi15jSwJ75Fekng/1zCy1/QHil
         yln0hR/iwQU8SMz9lJrePVF3j4jP37oGwRQMrf1Rd54n6eMj/6fsrh9IDq+W793sCpXy
         1/NUoJya9LvJxNrHxboyQDrxRSrEPEoE+ol4V++M2zd0mtAxbKBcgVX4LU2delvq8VMJ
         yA4fo4hz01Zjw/8REg41+nI2UXFOwNrwOsjwGvFHL5iP1v2VUmhuZWJ8JN2hGBSNnpqH
         QRu65ip9A3iDfhoe/wRRDO/s77df/3Di9Bs5hSrD9Qh1SLgmLaTsEjCX7WSPgOavQlos
         MQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785468264; x=1786073064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mDiNHR6lmF8BBewyLoqotO1eTvzYBv3I+mg7fsH65Xw=;
        b=jatr3TN9kWd2LrAmTzn/NLPVSPBQ+ltXzeflY7TfhuacHG/6C1IFFKabloH1Hv8V5r
         xu9DTQIZ8/KcCf+uJrjyR/PHLRmoAv+Hxo8E/uwZlR/VZvix1SXdw/4qxahNGpqJfynN
         14DkDlgs0CLdg+OHnFKNVtJHHo/2QrueH/ntm0eGAxZ2HbE832jFVz/S2GZMBUlQO9tZ
         UxfKrMm0cL89dUJJj1hOQxqhcSQnGYUlylGf/6cKuXdEHDGqJNVsYrUB6SQ4STAvAXVn
         BTKXyTm+I7/5VEcl5516D9e8UidIbEWyr/62W/gAHfzed851Z5DCDnly4guWiEPIQ2k/
         KwAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq5DcfxZz78iK/JrQvulrciiZSA4BCjry36ueB400vCK3gtZ1RFeu7H+HvRjbAbnjh+7syhEs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqcBemAD2n529lmR15gNMg6GSK9WAEfi3cuCQGxdpc+TYYLLy3
	07sA2HqSn5jL1XvOncFRg64hGRopCQItBvaUaH5HPuZuDziyoV38Zp3J
X-Gm-Gg: AR+sD13Zd2uGqKSgpBZfNhCgcTb/Qh9fU31ZggfYo/2LFV3P6q+YoyU5z8ByXnz/+2R
	iT9pk8B+pXjPbYmqYf+rVQJQ6TC6i69LvRXaUTEfH+PjGE5WmCsib0nykooVz3tRQC0UXK6puuF
	6BjYANLX2sIswshaqVBR8RZv3pcOO+vCpx4yjQ3beRlj2HATm2J5cxg3Ak9lwb18UAFwWkwe5oE
	0hnlAMOtoNROSuXR9cQiEN4qj2ELQQGYTWyMnH+WiJdCVQgPUAoLmks0wT9KbMZoAyMeDSuh0mY
	WBhY9BE4gV5FBflj7NlmHPpm1K3Dp7rI5+4gRmVLUB0DZ6SlkDiiS9rU2MzlH8gR1UFGqYbPZ+w
	rQc8whHe2Ua/R7Hubs5nDQVz94oIyZHXVn9sNv4qTRnQJuqBApcVGoc4u7+OApFl091dO4GfT6W
	LhesjxU28fgHUHtlW7oVvszZ43N4ycv7LFriqqKRLRVz3BhZN9LaP8QdENQJlhqoCCeZOsVuAir
	fDv7yiFs13U7l2xeT5ksUZFq77nepi3QTIZsnpMGbejchKZ
X-Received: by 2002:a17:903:2f0f:b0:2c6:90ec:f601 with SMTP id d9443c01a7336-2d046d7b74bmr5195485ad.8.1785468264475;
        Thu, 30 Jul 2026 20:24:24 -0700 (PDT)
Received: from localhost.localdomain ([202.8.105.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d047c42b4bsm869275ad.78.2026.07.30.20.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 20:24:24 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>,
	maciej.fijalkowski@intel.com,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] veth: fix skb length accounting after XDP frag adjustment
Date: Thu, 30 Jul 2026 20:23:57 -0700
Message-ID: <20260731032357.6114-3-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
References: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
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
nr_frags, xdp_frags_size and a kernel pointer from
skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
amount and truncated at the end.

Subtract the old data_len before replacing it and add the new data_len
afterwards, keeping skb->len and skb->data_len synchronized.

The fragment accounting must run before the linear tail adjustment:
when bpf_xdp_adjust_tail() shrinks the packet into the linear area it
releases all fragments, and __skb_put() requires skb->data_len == 0
by that point.

A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened by
1024 bytes from its fragment area. Before the fix, all 10 runs produced
corrupted payloads. After the fix, all 10 runs matched the expected
payload exactly.

Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept non-linear skb")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 drivers/net/veth.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 00e34afd858e..348391e87e14 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -865,18 +865,25 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 
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
+	 * This must precede the linear tail adjustment below: a changed
+	 * data_end implies that no fragments remain, and __skb_put() requires
+	 * a linear skb.
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
+	/* check if bpf_xdp_adjust_tail was used */
+	off = xdp->data_end - orig_data_end;
+	if (off != 0)
+		__skb_put(skb, off); /* positive on grow, negative on shrink */
 
 	skb->protocol = eth_type_trans(skb, rq->dev);
 
-- 
2.43.0

