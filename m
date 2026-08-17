Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E45F3BCD24
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786956599; cv=none; b=NQg4vgL1fIzf3ZPPfS9owlFUh7tRc7gjK3lLdYqIxVz7PWsjO3VohGc/rnjwEA8tx1wcNCbLnT+AZuHNpYEFmg4hgMaPcmtT/CCimnLYmJcTdws53N032E8xAOAFOG2QjMWgNr/HiAG2JeVbMcPGZwKVVb/HZhN2xxRr5Mnnu+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786956599; c=relaxed/simple;
	bh=as2SDlcdmZszLVLpp6U0wTu9/8GUPviDLNz+v3rqc6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QC7juJzb12G9R8DjcGP3pXpeIGa/04sda85i1DPMfWBPhllzG3oHw9HT77sivlyM8NSOTl1zAN3tNhyHTHSKVInQMNg7hhCZ0h2DHp6/PDlYspGgh8PzF+s6gyTaKlNswTfgjErwwX6DU7KsTyTyonCBN104KqErBkuttL3ebrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=BxIpjygb; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="BxIpjygb"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c04bf4711so31489451cf.2
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 01:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1786956597; x=1787561397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6lLhWIiCgpmicN480/UwG2uhnEik8ZpJA1z/kNF7n0I=;
        b=BxIpjygbPBsERGuqYa65TdvDLAtwrPMxEugGngYmCrYOzDhdHE1Mcruipw1JP8Clb5
         6liZ75ZtWhzFUW1mHjkiihQnNEb27cQNugUHVO8JoyXEWc6ss20S2LBvGui9TBABY5RB
         jnUIaSOOswXGOACCJyhSl5I3S5J+xlYzG95UyU2f43Cmp4IAUZdv5dfkWqkL5hoNVQfq
         XzkDowMZrDNSEczKjPTxgHY2ItLi1/dtrRs16a5hxoVHk2bOF+V9ZOSobX33rH+yIqDL
         9RMvyHBHzqrHzNpdW/U0QjOddYLYk5So0WezB5jFW2ED/GMpzLuIDAlxoUQaVnxQx0QU
         Xw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786956597; x=1787561397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6lLhWIiCgpmicN480/UwG2uhnEik8ZpJA1z/kNF7n0I=;
        b=KSjgIQFZ4vUnCCT0vHpbajA+QhirNxhm6kypAIhEipUNMgjVZT7S+UdWWIqQ/9Ptsl
         ssIqkDoW8yicj1iwXs+X6mb+pJjO3LTsHoyv/IMskhUsB52ux+SSX3hyFxLcvJY0V14Z
         rbW70u0o9NL7SvY3jjo6fX1klKaEfTPNE/M2TkBto5zvCVF9ODcC7GrmsyaX7vGtReB2
         y57sybG0ckKz70gg5fKJEG3taV1CH26ztnCHQSUxncfxsex9XAbULKvq17ODfY4pgU04
         WAEZhaAXt3nGSSh6XzLywIvy7ugqNIzI/EiDkF8ybAvFnl+0aGaYKSS/G/Of1Fcug1UQ
         wUgA==
X-Forwarded-Encrypted: i=1; AHgh+RpU+TJrzcU7DASlVXYhYFBNqG1aSU/mKK5lfUo1oJhA6iWGJqFhGK7S1IgHWhnSb1Q9oo3VmFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5dX9AxjIIY3QZsVqSXP/1RWXEBd1b4klZXjrj6Lyj4KrkMgRo
	rlwXLrIKEOsaeSQW9ItTF0nmjT2SyTruk/r4crHFg2VuhYGrxhZSQDROhuYnt3CyGg0=
X-Gm-Gg: AR+sD10w16Pu8Eu49U+yWAuxM2RpwYFOvDcpxWrTEFkvokc3ZN5qPherGLmJlfKvcLK
	6dV+/IihRfiP7mO2enmE+IJRie3nPuJ9w3eGwCngOnNppcnmQQEagWhEPdeh2r6RcQsVEqjOOoY
	8fEDSyJCYcSYiK+kYnL5w23El9aUvEj+rYwPAk6QMobGAHU1sC6KUGBPMoMbKX4BHPAO4k2ICKP
	cPCBR5VGt7f4fHllSEI4DA2P3DAWxcJ77L6lfysEAFtRgJzBFtv+epKHT8o3LP6S97/cwoRUEp9
	+uc35vIjhPSFpFwioCxXi6SBakRAfbx4kYXd6VCSPVjzGDrdjrvo1O795iZX+/YdgmEA+3v1CGX
	EUrRKGWzzU1KiGunPZyuaJFGBxYtW3eRntl0Vh3XVK5SSQgRCk3BvxwR5VRUMtrqAKKJaWRwe8Y
	OvT8Mp7Lc+9qolGNlZcRRUkiTYY4i7RLT+r1reOFVxx3ysl1gblFLAAo2ccaRf3EvkDOU=
X-Received: by 2002:a05:622a:3d4:b0:51b:fb82:67d1 with SMTP id d75a77b69052e-52d8542c8e8mr204942221cf.20.1786956597000;
        Mon, 17 Aug 2026 01:49:57 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-52db60eb85csm9405991cf.4.2026.08.17.01.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 01:49:56 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org
Cc: Kyle Zeng <kylebot@openai.com>,
	davem@davemloft.net,
	linus.luessing@c0d3.blue,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH net v3] batman-adv: reject unrepresentable multicast TVLV offsets
Date: Mon, 17 Aug 2026 08:49:54 +0000
Message-ID: <20260817084955.944189-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

The network and transport header fields in struct sk_buff are 16-bit
offsets from skb->head, and U16_MAX is reserved as the unset transport
header value. batadv_tvlv_call_handler() sets both fields from a received
multicast TVLV without checking whether the TVLV end is representable.

If the end offset exceeds the field's range, skb_set_transport_header()
truncates it so that the transport header precedes the network header.
The negative difference is then returned by skb_network_header_len() as
a large u32. batadv_mcast_forw_packet() consequently accepts an oversized
multicast tracker and accesses memory beyond the skb data.

Add skb_set_transport_header_careful(), an offset-aware counterpart to
skb_reset_transport_header_careful(), which validates the final
head-relative offset before assigning it. Use the new helper in
batadv_tvlv_call_handler() and reject unrepresentable TVLVs before
setting the network header.

Fixes: 07afe1ba288c ("batman-adv: mcast: implement multicast packet reception and forwarding")
Cc: stable@vger.kernel.org	
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v3:
- Rename transport_offset to thoff so the comparisons fit on one line.

v2: https://lore.kernel.org/netdev/20260810145754.828936-1-david.lee@trailofbits.com/

Changes in v2:
- Add an offset-aware careful transport-header setter and make batman-adv
  handle its failure, as suggested by Sven Eckelmann.
- Restore Kyle Zeng as the patch author and correct the sign-off chain.
- Move the research credit below the commit-message separator.

v1: https://lore.kernel.org/all/20260731135222.566367-1-david.lee@trailofbits.com/

Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Trail of Bits has a reproducer for this bug that triggers a
KASAN use-after-free and can share if needed.

 include/linux/skbuff.h | 24 ++++++++++++++++++++++++
 net/batman-adv/tvlv.c  |  5 ++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 22eda1d54a0e..ed6a2bc23db5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3126,6 +3126,30 @@ static inline void skb_set_transport_header(struct sk_buff *skb,
 	skb->transport_header += offset;
 }
 
+/**
+ * skb_set_transport_header_careful - conditionally set transport header
+ * @skb: buffer to alter
+ * @offset: offset to add to skb->data
+ *
+ * Hardened version of skb_set_transport_header().
+ *
+ * Returns: true if the operation was a success.
+ */
+static inline bool __must_check
+skb_set_transport_header_careful(struct sk_buff *skb, const int offset)
+{
+	long thoff = skb->data - skb->head + offset;
+
+	if (unlikely(thoff != (typeof(skb->transport_header))thoff))
+		return false;
+
+	if (unlikely(thoff == (typeof(skb->transport_header))~0U))
+		return false;
+
+	skb->transport_header = thoff;
+	return true;
+}
+
 static inline unsigned char *skb_network_header(const struct sk_buff *skb)
 {
 	return skb->head + skb->network_header;
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 1c9fb21985f6..c384db16bcac 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -433,8 +433,11 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 			return NET_RX_SUCCESS;
 
 		tvlv_offset = (unsigned char *)tvlv_value - skb->data;
+		if (!skb_set_transport_header_careful(skb,
+						      tvlv_offset + tvlv_value_len))
+			return -EINVAL;
+
 		skb_set_network_header(skb, tvlv_offset);
-		skb_set_transport_header(skb, tvlv_offset + tvlv_value_len);
 
 		return tvlv_handler->mcast_handler(bat_priv, skb);
 	}
-- 
2.53.0
