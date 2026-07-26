Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998E9481DD
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 06:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047126; cv=none; b=B5/3RQBhGrLS9AcgMaXnOhVpSuQSM7rmFzLuBbG7fsjkv+9Y66uRmNmV77XnJZGfYIsQxXnRmedQ8ADjYY3qRUIKRxGnJrewy7yJ/JzsdtsugndMlMA1EYQB6jiNeIT/3wabpVJtHxjgfWSr4rG120LsmSEf5/OUm27JRcFjRtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047126; c=relaxed/simple;
	bh=dP3h+hLKsGm5KC/K2M0ypRB2Gy3z0jV1Y4qouUEoGl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g7ss3CcWuEvJ0FT2HS4y6zCxAF7mZdOe5xW/6aewxaVg81Fv1mJ7eCXAC/h67Dq0vJdN9BoxIB4AHkUB/QiVKZbvhc5ux3fe/yLOEWnp8glN3KnR1FFBhOE6pg313pgnA6IrOmi3/wcnFusmel92Xdd4d5OgoTqe9wNIXB1ZjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=DC8ydt89; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="DC8ydt89"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cace91f112so18405385ad.0
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 23:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785047125; x=1785651925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P8zGbl4R2Ffos3phLd71l7Q80RIBm+fS5r/cqYD6HXU=;
        b=DC8ydt89KOZEagcMMu3d4p3qXlpjtNzUqC6SBtDRfRRn6IA4UBcJb4vvxeU1S6ongN
         1ocJuhDlGZl4swBGSH26xfWmqGaD45xEZBcvgZPD1OJWRF4r5YPHs13IL5unD+NjrQYR
         6Q3v0SBrClUqt2QfC4jSU3PO/SGza66hq27Z5/1Cpy40Iw4uRBpjpIStNAkju4CHObHN
         ZiKT3PTpvzSAldfxgb8NH4sXuz9luEvKTMSdZH72vYDkqt5ANkT4FTOjvLwv9U9egwoJ
         xKxpHO7qWutYuBH5+4C3gqEPFbunnvZ6bg8aqLgWfGfOwanGdlqM6Lu4ac/YH+HnI+gU
         5JXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785047125; x=1785651925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P8zGbl4R2Ffos3phLd71l7Q80RIBm+fS5r/cqYD6HXU=;
        b=jc6O2/nAtQCUggCPCxO/UCFnZY9jz4vVuLb80ap3sql4RIAiSToWredUi9KGtQXWgX
         i5aWl08dnwREpNGD2Hz9peoIFT9LQTaFuuBnqwfN0yPbdn2n54EaWY8KVI7HLzQ6FeBe
         8Hqp4/3udrmNIg3GVEPbJKv3rgt23t2kUDggJ4qeKpanvYrqeNhK/kDLrQPse/rwubpp
         7qe7Qoz3M9T4U9KARdZ2MXb9V0/3T+crryKDAnWcPPG6ap/3u2iTVPaFFFv226TNmV0m
         zJTWTBd+IbaMI51BjeaOCyPye6SjOKNfKz8UevbzbZo7DYtjL70JHqS1Hamk3a3743jW
         B2fQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpz3Fe4JrMtwPcm2JMnKKMLNXFEfQGjwgE0Jei/m2fajlYJPpsZohSOIwDitw+KDaY/1wFKt+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8cWT95vBH7pf3wrTzgCAoGQHUSA3U7Ux8d1r0rWXAcqvpnp17
	epRbMHpXZNWUFoNSniNwsttrySO5qa9+wrJkQBWQDKt8aInUybFGRkJt6HANchfpBhw=
X-Gm-Gg: AR+sD13WcqyCaVIcIlqKqZk7dew/qtVc8C5E2ktKwTevbe0Z1lpUP1ujhEpAE3p/nol
	4qLzBJNkVsu1yLB13P84uZ7yml4JD7v+3UCsFuq7OqvnDHuqu8KdvMYHjTENZw2KBvbuIavl61a
	YOFG8F7VoAOzM42GGzXDtmkJoIBrRQkbOINuqr1djcdh1vU85JOZJIQL1yzUQyt9AOcRCVXhuDB
	xSNphzMSlG87y63QvXJ486NcG0WN2tfagBYv1TSen2frlfZGhys+Z/7Zk6yk3bDglJUieiNT6F9
	gD54CACGsXKmh6UNRCjBfXcDQ6nRrxcWojs4Bj42/AA9dHactKtdUEuPoDB5CfaRNtg2EflyHCX
	W3vCmL47S7TlPRA+HiRJaK+7R917Ob2zDqciWHTLzf/pJ8Kq2Nz3t+P9xUX6xq07Y+vevl/FpOW
	SdSUIClKcX+z7Y3g6jOLZk/W+jySUsGBTWnZdbVrJeGPdkDTXsuZvS5ckJ2Kvj
X-Received: by 2002:a17:903:2310:b0:2c8:1f56:9fc5 with SMTP id d9443c01a7336-2cfde868609mr35863255ad.35.1785047124945;
        Sat, 25 Jul 2026 23:25:24 -0700 (PDT)
Received: from localhost.localdomain ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bc413sm16689195ad.44.2026.07.25.23.25.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 23:25:24 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: bridge: mrp: fix uninitialised bytes on the wire
Date: Sun, 26 Jul 2026 15:25:18 +0900
Message-ID: <20260726062518.43774-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_mrp_alloc_test_skb() builds MRP test frames on an skb from
dev_alloc_skb(), which does not zero the linear data area.  On the MRA
ring-role branch the sub-option TLV header is appended with

	sub_tlv = skb_put(skb, sizeof(*sub_tlv));
	sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;

leaving sub_tlv->length unwritten, and the two trailing alignment bytes
are appended with a bare skb_put() that neither writes nor clears them.
The surrounding oui and sub_opt regions are explicitly memset(0), which
bounds the exposure to exactly these three bytes.

Every MRA MRP_Test frame therefore carries three bytes of stale
page-allocator memory, at frame offsets 65 to 67, to any observer of the
MRP control traffic.  A capture on a kernel without
CONFIG_INIT_ON_ALLOC_DEFAULT_ON shows those bytes varying frame to frame
and, after a page-allocator spray, carrying the sprayed pattern; the
same reproducer on an otherwise identical CONFIG_INIT_ON_ALLOC_DEFAULT_ON
kernel leaks nothing, confirming the source is uninitialised allocation
memory.  Reaching it needs CAP_NET_ADMIN, which is self-satisfiable on a
stock kernel through unprivileged user and network namespaces.

Assign the sub-option TLV length explicitly, which is 0 as the AUTO_MGR
sub-TLV carries no payload, and append the alignment padding with
skb_put_zero().

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: f7458934b079 ("net: bridge: mrp: Update the Test frames for MRA")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 net/bridge/br_mrp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index 3f7126a7d720..a5548f475604 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -226,9 +226,10 @@ static struct sk_buff *br_mrp_alloc_test_skb(struct br_mrp *mrp,
 
 		sub_tlv = skb_put(skb, sizeof(*sub_tlv));
 		sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
+		sub_tlv->length = 0x0;
 
 		/* 32 bit alligment shall be ensured therefore add 2 bytes */
-		skb_put(skb, MRP_OPT_PADDING);
+		skb_put_zero(skb, MRP_OPT_PADDING);
 	}
 
 	br_mrp_skb_tlv(skb, BR_MRP_TLV_HEADER_END, 0x0);
-- 
2.50.1 (Apple Git-155)

