Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561194;
	b=GGnzYG3iTDujJqT5v0JCzUrTFQ2rZ/RPGHKsJ9yB9Zycuz0yW717DYdEaoJEiTsad/jh
	 +bSUiGNQVLqBdiptVqgdU/RS5hjJeidFHE3fsJe0JhR4L9bdT7l+Via/h9/MoJ7g5YDup
	 7Hgc1KwZ8m1MS59RdrLc96VrGFrpa1otZcGLSJcZ9ECgGVxWGgKmtD6lALYcQUXo+D0/8
	 puDZPdvG+Cwh1FX8VPX8j3DOqP2xfFmrjq/rLSTVytVtj9Gj3lOr5TimHEXnPgHk5w11L
	 iFlFMlZEIdNqXgd0+hvxLr3631SofdoL6/WqteyJFh2egWgq3zCDu7EgX+XKAmOH5Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561194;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FAvU2wBAS6YDbd/Yj36MbSgD1wbX+rF4ce9SRDIwpHw=;
	b=TzkzTF4F6Ynbi7Fm+oBrmhg+mC4SeUpKLfsw7BAqKV0bLZVqTYv2K0Wxh1xFiJvaF9iI
	 +jdByA3SeVtrwFiP2imqoh1ijRj1Jb0AIr43KXwDyTkoZTtqHDd1fd9OW4mcuXpSsuC14
	 AnHF71wLlV5Au8B2cREEWHl0sxr41mAKSdDqunttkxTewWlthfHKhPsaPT/s3Lk04h8M6
	 Cju5GU//2nKXHQdR+4RBSMB+DLoUsTGkskHgg1yjnv1ELO3QPntlT/Kvl3zmd+j+cHg8G
	 HwkE/WwEU5JKm6VtcknyhBAOXbNLSQIoPdRGXwLYROgVij8QS+Ehz62pXHXraQ6FdLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzo83BCN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664C5606A329
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzo83BCN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4361F000F0;
	Tue, 24 Nov 2026 22:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561193;
	bh=FAvU2wBAS6YDbd/Yj36MbSgD1wbX+rF4ce9SRDIwpHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jzo83BCNaHWRemqq51hhsBEAPF6khfOyn2PQQpNIZz/ilFbEtImyw9aa0jAa6AGkM
	 31acAPmEMmayKZDlJLGpoy22QMk9PFGVlkkkGpuTogegfu0hIpUxm9SKt7bsQn8+BN
	 0azO3QXEvGRuaO36Kpk4oYLg5Z8TgdfOjbLu+S3+l6foNpfy3ofETI6j5of2kqB14a
	 YGBf7oig9iym5eEpSuon3fGwQFVpUqUGA2mx+yDeQw1LbXEIiYXGPA+sJIJGsMDo77
	 YZdckfEuvAUNC+9AlcRlrkhm+GdVftizSAnyKZHO2cp6AzfRRLq8SMrtEnHt+50mTz
	 yYpuolT2Je6qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] macsec: reject frames that decapsulate into runt Ethernet frames
Date: Tue, 24 Nov 2026 17:59:51 -0500
Message-ID: <20261124225928.3162910-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112440-matrimony-ranking-b2f6@gregkh>
References: <2026112440-matrimony-ranking-b2f6@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

[ Upstream commit 1d5e2c57e9ffc134e14b3f837c8d7c53b508bd22 ]

When an SCI is unknown and the C bit is clear, macsec_handle_frame()
removes the SecTAG and the default ICV without checking how much of the
frame remains. A short frame can therefore become an skb shorter than
ETH_HLEN. eth_type_trans() cannot pull its Ethernet header, and a second
stacked MACsec device can copy stale skb headroom into a packet delivered
to a packet socket.

The matched-SCI path has a related hole: macsec_validate_skb() accepts a
short_length of one, so a frame that passes the existing length check can
still become a 13-byte Ethernet frame.

Require enough bytes for the MACsec overhead and a complete Ethernet
header before decapsulating an unknown-SCI frame. Apply the same bound
in macsec_validate_skb(), using the selected SecY's ICV length, to cover
the no-SA, synchronous-decrypt and asynchronous-decrypt delivery paths.
Leave other unknown-SCI handling unchanged.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>
[ sashal: Adapted the nosci path to use this tree's DEFAULT_ICV_LEN macro name instead of MACSEC_DEFAULT_ICV_LEN. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macsec.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 15bfe10b2cf91..0af5157efa111 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -417,8 +417,10 @@ static bool macsec_validate_skb(struct sk_buff *skb, u16 icv_len, bool xpn)
 	int len = skb->len - 2 * ETH_ALEN;
 	int extra_len = macsec_extra_len(!!(h->tci_an & MACSEC_TCI_SC)) + icv_len;
 
-	/* a) It comprises at least 17 octets */
-	if (skb->len <= 16)
+	/* a) It comprises at least 17 octets. The SecTAG and ICV must
+	 * also leave a complete Ethernet header.
+	 */
+	if (skb->len < ETH_HLEN + extra_len)
 		return false;
 
 	/* b) MACsec EtherType: already checked */
@@ -1309,9 +1311,12 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 nosci:
 	/* 10.6.1 if the SC is not found */
 	cbit = !!(hdr->tci_an & MACSEC_TCI_C);
-	if (!cbit)
-		macsec_finalize_skb(skb, DEFAULT_ICV_LEN,
-				    macsec_extra_len(macsec_skb_cb(skb)->has_sci));
+	if (!cbit) {
+		len = macsec_extra_len(macsec_skb_cb(skb)->has_sci);
+		if (skb->len < ETH_HLEN + len + DEFAULT_ICV_LEN)
+			goto drop_nosc;
+		macsec_finalize_skb(skb, DEFAULT_ICV_LEN, len);
+	}
 
 	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
 		struct sk_buff *nskb;
-- 
2.53.0

