Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1AD48877F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331195; cv=none; b=aEyNqfVIZLrbfMTngnqjnmxIkSly806BHjUEEOuWp7vAqI5khpnWdRphUZEgLK8F6rKYlOg1hMohzvCvZzYRj0J/LJmEtBCQUwShMlSmRTIOSwuwY1jWXKpxlYaoNJaRPGKcD6eChpvX2T+P7wd9XLIAeOCNjwGuRC8qSVAdrJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331195; c=relaxed/simple;
	bh=kdlhdT6qgk713ttnMT/RjwDbI68wlDahWZC3PMz1mLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quBmO2dxGBJQbkb3IzBxh0QW2y9aGCHfbnlqiTDPKUNp0yEwVdjiLoPZhSnpjYVaBEaRSJIbpGx81M/75zL3Ao6UsDNO6XpEmtJ2Y164TOMcTcgETSkvQuIVTWo8w8RV8DqI6tB9zOkklybszmepCcFLZaEYAI3FZiPTt1YihCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=kyZImTR3; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="kyZImTR3"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81f3b227a4aso15156517b3.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 06:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785331190; x=1785935990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KMXrirPZU7fXTxWoE1e8bDQ+DkmRVCXCwha59Dx6pk0=;
        b=kyZImTR3THa0m/yIk5XiF7x+UKKcf5afFRr83ZbZaeYX8yzQR1HlcI9GtosxtHzd2l
         NAK4LEShW79QhghNxBFnU7m81yXpEfntUXBQnSUraChlJ4rQY18FPA4HObtRd2fGLAfw
         kpTOEA3T9Qv9gHaYzswu+uLsEo8UbQA8kcLit1Wi4UY5WFUqRuhVeRRL1z3RmWQSPruH
         Z9GnvIk2GJrGSFl7HXT1N6JAJHW5wHJMP48EchGM5KOZU+641YhjafOZS5QOBuLZwCjx
         e+vQYwlHMm4H8K5pzFsAKmCNh3u5JwTh9ULOKfetPQO2D886PoJYDyfr929RwlMPyvjI
         pjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785331190; x=1785935990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KMXrirPZU7fXTxWoE1e8bDQ+DkmRVCXCwha59Dx6pk0=;
        b=F3iMypLkrwWcFbK2/MQhIZCk8Dtwf6/LqP4LoxeUsxV4uRy7JQSHh4vQJ2ESbKKCuw
         FbzxcbWPPSmU9OfRdlOTVI/jf7sQCRRMEdQGMSEDs1hx6asdu4r3hUTAeRIS86nyZPbO
         GFUQbjsiTyaElUvXtE8RyLV8xz37qDSSbasoH+qgAhimbjbjYxBxOp6cZh0T5LxNwQ3x
         1rnb1jRCxms22hPr7YVzQ8BxZ0o1tmZq7PaZTq/pocQEzDJYoTtVk3hZErHn9lSDNXIk
         BkS5TMKI/e4gQ78Wo7LRAaZ9VaQ5xDtCRDBMvpILJr3/rgsjpWzVKXodvhbxWE5KD4yt
         vkzw==
X-Forwarded-Encrypted: i=1; AHgh+RqLayB+edtUoG6Bot1gsYLfo5a2XOMupKNbLFSzaUARzSK91SX0OjkG/AheM8IduFlyAREV/y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxVbxcnzgDO0VN2MmnAm7qhaYlyo/M1CdpwVroiYOHPiRVyaDg
	tA4Jul14tjhec/KnQmOuj2HKcQXGex7O/0CqCIx1yKGfOiGIaTGT/HmH0TAsXiAbfbM=
X-Gm-Gg: AR+sD12xgURwnfW4uWDTLFO2Wvd1+uAInSAdVqdzPHexv7NqPgoqvdQgFFm7Zj/fmVO
	JvbYMXWM+sRN5rkzgfRXhlLMU09fkYjxPAH4Kt8c3WVouZLxUrSUWh69ETTOEOfaMJXqok9YHLw
	It+eCf/4vS2+T2soQRHBdfU8dw6sr0rOUSajkKUjRTpCOB2xK7QXdjS8jmtV3k+tvnl4t4rJZ9Y
	Gu3ykRnB0fcrNTtUzsOalz39UQLjIQk1jJGus7wxUBl6LbCB4Zzau1TOcUvdEIv+F7W/LMFeg9c
	VC8v8qhL1r4Om9Pbyk1kK7PBDIb1j94gq8jQu3lUHUZUNquHdqmVVt6Zo6TDuk45uqpCZfKx8nQ
	eI4+pxJNP7euSLrmu9o2LeAGBjCy4D2/3tI/dUo/Plu1cGTF0NHnD5A0zyxbUS1iJ8a7Y5eAFaF
	RNuH4sAmRF8Y0SwYZsXmOfN31t+dEW9JdXBADzfu5TmF9YFnnQmHB/XZuqHceL/ztcgnXX5KT8i
	J1ri2wHABIYyyGjCUoOD2L6mjYdc7a30N3UFbs5QNFdMqTODESMbjMfM0hqnFNHFWZgXhFcp9Z1
	KmiQMgAn4WHoqZVUE+Bbbu/si2hQIA==
X-Received: by 2002:a05:690c:62c7:b0:814:5312:47bb with SMTP id 00721157ae682-81f993f145fmr33494437b3.69.1785331190331;
        Wed, 29 Jul 2026 06:19:50 -0700 (PDT)
Received: from buildmachine.tailf331da.ts.net (ec2-3-14-143-233.us-east-2.compute.amazonaws.com. [3.14.143.233])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa275691asm17653907b3.4.2026.07.29.06.19.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 06:19:50 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	Baul Lee <baul.lee@xbow.com>
Subject: [PATCH net v2] net: bridge: mrp: fix uninitialised bytes on the wire
Date: Wed, 29 Jul 2026 22:19:41 +0900
Message-ID: <20260729131941.10254-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260726062518.43774-1-baul.lee@xbow.com>
References: <20260726062518.43774-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_mrp_alloc_test_skb() builds MRP test frames on an skb from
dev_alloc_skb(), which does not clear the linear data area.  On the MRA
ring-role branch the sub-option TLV header is appended with

	sub_tlv = skb_put(skb, sizeof(*sub_tlv));
	sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;

so sub_tlv->length is never written, and the two trailing alignment bytes
are appended with a bare skb_put() that does not clear them either.  The
neighbouring oui and sub_opt regions are explicitly zeroed, so three
uninitialised bytes are left in every MRA MRP_Test frame that goes out.

Put the sub-option TLV header and the alignment padding in a single
skb_put_zero(), which clears both.  The AUTO_MGR sub-TLV carries no
payload, so the zeroed length field is already the value it should have.

Fixes: f7458934b079 ("net: bridge: mrp: Update the Test frames for MRA")
Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
v2:
 - fold the alignment padding into a single skb_put_zero() for the
   sub-option TLV header, dropping the explicit length assignment and the
   second skb_put() (Nikolay Aleksandrov)
 - drop the paragraph about observing the leak, and the Reported-by tags

Link to v1: https://lore.kernel.org/netdev/20260726062518.43774-1-baul.lee@xbow.com/

 net/bridge/br_mrp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index 179d2470b..ef16d0703 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -224,11 +224,9 @@ static struct sk_buff *br_mrp_alloc_test_skb(struct br_mrp *mrp,
 		sub_opt = skb_put(skb, sizeof(*sub_opt));
 		memset(sub_opt, 0x0, sizeof(*sub_opt));
 
-		sub_tlv = skb_put(skb, sizeof(*sub_tlv));
-		sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
-
 		/* 32 bit alligment shall be ensured therefore add 2 bytes */
-		skb_put(skb, MRP_OPT_PADDING);
+		sub_tlv = skb_put_zero(skb, sizeof(*sub_tlv) + MRP_OPT_PADDING);
+		sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
 	}
 
 	br_mrp_skb_tlv(skb, BR_MRP_TLV_HEADER_END, 0x0);
-- 
2.53.0

