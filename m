Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B94BE437
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647742; cv=none; b=p046P0vku5TWyVwo6UmERArLPzH9h80MyD3A1vxsC+pnqbnxnZbdcwMU5fEdJnrIH+ZWLDqRi4kbvuYkkGqUpPKb7qB4KioPfv+z3lfw3EVozWaktWSXsDsGjRtBVPVGGQH2bPP4ji/SvtckbMOTUox28xXYj149BS5+IKA8et4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647742; c=relaxed/simple;
	bh=g0bdFEp165C2AD6nwvlIUU4+9x/xgS5Nk0xlq49gsLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hh+2GNHD6p0L88TlgW/R04sSRRlt1Iik8KS0zqoShT3GhCkH4f1Dg8pOI2X0a8yLTJO07oX+HRo+ytMSzLtTae/Y4Wboyd5d5keDu46uKMg8bv5KWz/RA7Oudxk03iUO/Nml6dh3XAj3BlFJvDTFt7/TWYOk7/oW2bByOxJTQM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSv+nxHt; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSv+nxHt"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so708443a91.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 05:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789647733; x=1790252533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BdQwb9cZ0fnhKPkeH9+sCKU6IXQWmPIm14OBXxFtvO4=;
        b=QSv+nxHtOtAMNnECfF981ajiftX6qt+tZtgyuSvm2Aqz2qEOeNyS7aRURsLJj2Visk
         c8R44wll7BD721B7rbDyj1wkhaBcELNr7CyZd9TALQnu5D1bEQA20/0MOo8f4f++QRHX
         O25bwT1gkTCd1t81g7L7Cci5Shiisxb4JuduQrFcS9/ZD7tchbDy55csIAKQjdUTMM4w
         CA3ypsvPrTG8RXYbKtEDBESJSwnJHZfiiXmTWse1jx0jtxh7jfW3pHpK5TuX/516IsqB
         qx0Shxs0QVur3cXGho2eTkDzXLThkBw8Bkk/18l6OaDGmCQ3w5tKoo5GPgIAgBgnwYG6
         R4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789647733; x=1790252533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BdQwb9cZ0fnhKPkeH9+sCKU6IXQWmPIm14OBXxFtvO4=;
        b=OKglaZ75Lq6eNKsxlay/hgrFYO2bjCMLstCBMIJ9Shnsh1uaL4/0xXKkBQs8YZ4RW5
         Z02YgKiLaMAH7Z907NLx9aqyEXsSwz6/X5MPJXFSG3WNUoQQJk1ET4FwpFB62X7DRTi6
         BVKs8wZWqXdxdFiwdEHEcdqGYhOq6XgKa6F4CjPyiHsOYIQMd7cM2szAcmU/PSfLDdyN
         k8YFlTEamVfqSUV4wSkrZmJJyYPPUSEgZAsEFBL6QDECSATY2JYwPnTytImIU5TUVl6F
         hBHGyKZa9K2tLAFAkmF3qhWFyM+rUBjiGj0NAfcQunR7aTA+KJJ5XFneaIt+z+aaOc/R
         RAUw==
X-Forwarded-Encrypted: i=1; AKwUvBw0TcPoqczIiHtDPZu2sNaMvdp6xAoIi0O6bJHDeu1Ezu1+0bBAdCbyF4zggKD3B0EBcIQm6C4=@vger.kernel.org
X-Gm-Message-State: AFuF++lizLKkP21d3QdT9LF+zOKTka2lWumu5WqwwKw+40xXDhG/nXLg
	gA9oNMNpmgcYNwVmjdVwmO4yA9nx4LtxfTHtWHl+jDpYFpuxqJPttVD+
X-Gm-Gg: AYBFou2jm3JFg1KkwAu901Jf3jQkEdEAL/Yz+sLeMjwiDEfhTiQJMhFrEXCS/+Ge7DG
	HXoZTOm2vK9FXSuE/DO9E+4bnoSMJjTtl4dbm1OElNgjeeR/QIxUxRjmRF9aW3UubloTLtpJIgl
	x4og9SZ7nB5yBa1MK31M6WlCHf35U8lD4dGKHAxMHTecjLMjMZyavHHUiuI0EQNF+wNHxB7/I2b
	vX1F1E4Y9MPDczEADt+zOJ6H+iuf8Rb1WrVfODRBH/YjwoA4P6Er/3e75ttTeG1uOAC88LDo5FV
	lV2y132++v3+lf27JxgIVHmSANIauEeKGhGJeZ0wizrjNEzfugm9Au4xXWHmdWNaH0VlGxOPTrU
	XGtlcTvoeyS169JgnKfquvczor8r4kcZt3jLvQhAH+QVaeJiKlp5ppviC1pGHnEEQOOZCXXfGb0
	6sNtpMBgIePk04FQ6/UcYVJmcNjx39P0tBbRO3PG9cNFwAW+p6RDxcR1FpLSK+m4ra0nBQl2pDB
	mWp8Oc68mO2xieRy13X+pNyS+S1
X-Received: by 2002:a17:90b:2b8f:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-39e1e24fa85mr14609273a91.4.1789647732855;
        Thu, 17 Sep 2026 05:22:12 -0700 (PDT)
Received: from localhost.localdomain ([183.194.144.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a6a175sm16360661eec.9.2026.09.17.05.22.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 05:22:12 -0700 (PDT)
From: zjamg <ndaugoing@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zjamg <ndaugoing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] net: fix OOB read in qdisc_pkt_len_segs_init() on negative transport offset
Date: Thu, 17 Sep 2026 20:21:52 +0800
Message-ID: <20260917122153.62722-2-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917122153.62722-1-ndaugoing@gmail.com>
References: <20260917122153.62722-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qdisc_pkt_len_segs_init(), the header length up to the transport layer
is computed via skb_transport_offset() or skb_inner_transport_offset():

	/* mac layer + network layer */
	if (!skb->encapsulation) {
		if (unlikely(!skb_transport_header_was_set(skb)))
			return SKB_NOT_DROPPED_YET;
		hdr_len = skb_transport_offset(skb);
	} else {
		hdr_len = skb_inner_transport_offset(skb);
	}

Both offset accessors return a signed int, but hdr_len is declared as
unsigned int.

If a packet undergoes header operations (such as skb_vlan_untag() pulling
stacked VLAN tags without updating inner_transport_header, or other header
stripping that advances skb->data past the transport header), the offset
becomes negative.

When stored into unsigned int hdr_len, negative values are converted to
large positive numbers near UINT_MAX (e.g. (unsigned int)-16 is
0xFFFFFFF0). Subsequently:

1. pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)) evaluates
   0xFFFFFFF0 + 20, which overflows 32-bit unsigned arithmetic to 4.
   Since the packet length exceeds 4 bytes, pskb_may_pull() returns true,
   bypassing the bounds check.

2. th = (const struct tcphdr *)(skb->data + hdr_len) zero-extends hdr_len
   on 64-bit architectures, creating a wild pointer pointing ~4 GiB past
   skb->data into unmapped memory.

3. __tcp_hdrlen(th) dereferences th->doff, triggering an immediate kernel
   crash (page fault / KASAN wild-memory-access panic).

A similar unsigned overflow occurs for UDP (SKB_GSO_UDP_L4).

Fix this by declaring hdr_len as int to match the return types of
skb_transport_offset() and skb_inner_transport_offset(), and explicitly
rejecting negative offsets by returning SKB_DROP_REASON_SKB_BAD_GSO.

Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
Cc: stable@vger.kernel.org
Signed-off-by: zjamg <ndaugoing@gmail.com>
---
 net/core/dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ecfbd72d5d1a..f2dbf99181ec 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4159,8 +4159,9 @@ EXPORT_SYMBOL_GPL(validate_xmit_skb_list);
 static enum skb_drop_reason qdisc_pkt_len_segs_init(struct sk_buff *skb)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
-	unsigned int hdr_len, tlen;
+	unsigned int tlen;
 	u16 gso_segs;
+	int hdr_len;
 
 	qdisc_skb_cb(skb)->pkt_len = skb->len;
 	if (!shinfo->gso_size) {
@@ -4182,6 +4183,8 @@ static enum skb_drop_reason qdisc_pkt_len_segs_init(struct sk_buff *skb)
 	} else {
 		hdr_len = skb_inner_transport_offset(skb);
 	}
+	if (unlikely(hdr_len < 0))
+		return SKB_DROP_REASON_SKB_BAD_GSO;
 	/* + transport layer */
 	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
 		const struct tcphdr *th;
-- 
2.53.0

