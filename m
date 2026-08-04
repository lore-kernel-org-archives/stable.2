Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAD62DCC05
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785822062; cv=none; b=Mbp6Kopg0SjWtxUnigj1hlZSwHOogFKkkh+/gXpoHgSRrJmxswITKA3r+S1CgA8RPinDkGKR5EASUa6fPvRoK61qdCu67j8J5LfhWZ63W2rUJKJsYYdS9x+KOKSs5QQhBh75TbUH3vOVrF3R6qMQ7gGK48fzvXJGNBNy/Cub1fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785822062; c=relaxed/simple;
	bh=+HpGf3LoSzduFxk132QfTs1NVy4vbdD0zOb0d/ZqjPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUjPfqsZ3Pr1m9FxX6kslxO0W8x2qedP1zZrro9jcrla6Ucfvb0++Jl1dKLEjplY/ME9gtWV6lpxT/HQBBXDWJG8kTIn6ntLS24aNqMvUuXjnWojA4rGwn5g4rAspkuDIT4L5E1x5D4cO3GxZj4kEfPAOkUeS+EKrl+xPy7eZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3GPIwQC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3GPIwQC"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84e507b079dso2987862b3a.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 22:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785822060; x=1786426860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hVYoynVbiX5DkPohCYrGWG74ca2waR9to+ufYwdKFiY=;
        b=E3GPIwQCNVm+YqxS+ydy4QDGcerW3x0UUcjMNs6fRL/W/kbBFU+ztm8F1LhuMqe3YV
         PG+Eprk2lTety8jsAlecig4HIkCFTKQxKHFaCbLdYidwCRDg8OFORm3Fyj1daS8D22Gt
         e+K/xA9KRV8rGAeUZvx595OGS53fONdIcNzZgPDUKPDHqFNw2YKNw7kvlKYngyHeWoSq
         0R2e0Guamp0hpWkkcyAbCWBzy8hAcjS4JVFwhMGhl2sAdVN9TSLL4ctyMG5WOFrfkL91
         mpz5S0BOP1ZpcIYgrwVhChtgF3lGAglujnuWCBsA2pLn1hqpFzvddyXf/s3fokEeU6cO
         xB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785822060; x=1786426860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hVYoynVbiX5DkPohCYrGWG74ca2waR9to+ufYwdKFiY=;
        b=Ac6yYtcdiPfjvqJ0lF9aBxVhidD8Pq1xa2gAhOjIbWiEC2b34WzQXhmJBq4X957qL0
         /MdKAEYLKTy46QQRiqj8XI0OpLEWQGlFH7IUG2WbHalOSJXv/Ft7dUopaJdj1D3Pr2BD
         g+sen4IHKTOqZpDmsDbEKc1TQR+5y9k3BMgpGtBdLkemitTYxc6RJsG0pU4yPf+UMWMC
         ygQf5cUJ3JzUHWaXjAFPh/Q84o6c8EDBEPYk6UJG5V5oFHJDPn7DGPwcEPCgCuEfq1J/
         5hwQT5v20RAlL+r6DPk79Po/hTSVNGMIYuPH+KSZIN8OZPOepf24W0BTLuF7bOsbPetn
         XFRQ==
X-Forwarded-Encrypted: i=1; AHgh+RplgX8+3UIWvyT5dg/xUjDwRehbyhnAiiF5Az9PktSHvrQlax9PPGjcMgE39vakyDR0arw0B+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3GLjR4+yMsjcIHmpNiZIqJqJSm0bphSkonXkAp8iWMAwdZuC4
	fp9MXSffFN8+hHCYuzUORMgDuwW7CwDGHM0j1G6I0kelEo7ow7P1qHJU
X-Gm-Gg: AR+sD12LQCDTj+3H+l5bGjveUCen8vwJQWz7SvzESkqG+mmePZ05XqEN7LaDSnLv0IG
	IRmnHtpyc7SYHbzcPWZ+/4JUpbW2IvHMpHnh/cdNqM9xJcQhjjn1TwTle7i9K4l9A4+uYW3JCPq
	q6Gw8P4EBh0KXeV/Lz7pZ2fLAhk5EJZTzWXoD4G7ycC8uWVOg02oo8prw8OnebOZvzs+xoFiUlv
	arJ7iqkwsH/LkARCIbMq88MUVjccRjAF04RuDSfMoNTexsiXdDiScMPzfy51myQFKU/K6EU7sc/
	hJfw1GywRBIpyRjUbFQ8ixjSooeCPwN2ORl3tPFB3mOyyhPU2AhU7gFlUMj4a56fPsEA6UoPr1D
	F/uK+gxASb3cts1xGUPTxs8K+6OIxefloFxuIhD6HSl3S2U8hhwHmo6UjOp2LfXbZj2d35pwfIn
	OHl5irWn2vUuqSp85g5EQXqJpALMJb2VSjUkQXXCvXXjjcRU9tu5xO8wfylxd3euo9P9E5/cLQ5
	GFWAQEc0ei5XBcRuXK8A523d6QyZnhXp0whucWTfKBqFE/ZtWG3wg2QkkLLoduhjQ+Moaftdv/E
	mSKxl05HDEfDMBMC/KFOBt0=
X-Received: by 2002:a05:6a00:3d44:b0:848:7731:d95a with SMTP id d2e1a72fcca58-84ee48bc67emr11526034b3a.37.1785822059843;
        Mon, 03 Aug 2026 22:40:59 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.localdomain ([60.168.97.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe5702bsm4678737b3a.16.2026.08.03.22.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:40:59 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: netdev@vger.kernel.org
Cc: Sun Jian <sun.jian.kdev@gmail.com>,
	stable@vger.kernel.org,
	Mohsin Bashir <hmohsin@meta.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
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
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net v3 1/2] net: fix skb length accounting after generic XDP frag adjustment
Date: Mon,  3 Aug 2026 22:40:38 -0700
Message-ID: <20260804054040.613675-2-sun.jian.kdev@gmail.com>
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

Generic XDP exposes non-linear skb fragments through an xdp_buff. If an
XDP program adjusts the fragment area, bpf_prog_run_generic_xdp() copies
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

A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened by
1024 bytes from its fragment area. Before the fix, all 10 runs produced
corrupted payloads. After the fix, all 10 runs matched the expected
payload exactly.

Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
Reviewed-by: Mohsin Bashir <hmohsin@meta.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 net/core/dev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5933c5dab09e..5c37cf6c4aa1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5517,12 +5517,16 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	}
 
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
 
 	/* check if XDP changed eth hdr such SKB needs update */
 	eth = (struct ethhdr *)xdp->data;
-- 
2.43.0

