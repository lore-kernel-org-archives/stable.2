Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561355;
	b=WQOReQUP8cpT99IEIRvNgUVQeNdshXcULkn49nPUf27+MB4NhC4Qo9rCYCncttL5kO/F
	 muoYKnrOEYmihvooN/KGBT3OH5OdSc98fLTxwg9KHZQgkp0v0x5fZsqSHFWBVqM42ciSZ
	 d/1bUbby2Rv2vC0tdvQPZOBdB+CS3aPcf+ZN4160RoWBDvY7pwC+WhyUDpm1jQFEF5hGT
	 DYPxuAdjqFtEyIC60/sZqrgViWgRLM59wBJm6Pt7exvoZBCMR+1z9KhaimmLTzzJgFYrC
	 LGK/Pcj9HmHGSfZ/5IaYdxUYMcdRc4w1K0yymgp/yH6pL0bb2zal42O3Ai0PKyHlVMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561355;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BrGf6F0ds01w2sEjpmETxxxGalauS8R7LkJNgD80EI4=;
	b=3vLt2zJbCkPbJGCzUR09HVcRxvPwiTeBG7SbIrnPLdFRO4sHUmupTSgiOW43Kln+36dE
	 wZZb+wHcbirqg2XEY0d16BCJ5DV/MJsH3KdOL8pb763JRj2kHzA2j2qFPXYhA2IO6qAmB
	 MIoZsk9b18rdWgKLjohAFc1M/spDh04OMCp+DLTbrCkEfqe/NAjgshDpBNXVXzLZvFi5h
	 aSFBO0+Pz8FgSJCQUZ20JxwGzaIeplEIIqVDZ/NmnfaqsV+jWOs3scHKVJIYdj3OEzyaa
	 kEoq930i0b3WsmzKp9nSJiAee01E2Gov00PZWZ5RLNI3A7inhnIiClhVXAnQBaMQKdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrwzBAS3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7EA606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrwzBAS3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA84A1F000C0;
	Tue, 24 Nov 2026 23:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561355;
	bh=BrGf6F0ds01w2sEjpmETxxxGalauS8R7LkJNgD80EI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WrwzBAS3pxxCx9MTXC490bJZWl1quBf4oaGQaJKoosnznlAhIcvE/h+J7SQfj5oWF
	 nWfay67m1U0IdkTzUQVWj+gzZctm05mUlfFzinq8DamvPI34CI3FTKCWCH9nPPiu0E
	 +tpgMwruf3553vdW2QKgfepPJeth4+MPM9mFJLIg7csR+5V+EVrSfzKjXrO93qAWjU
	 v5fYwZQ021yE/WiyCr/qf7kfiL7+tyHMI9zhoyUdUpd7QaVqBDsOvWZ0FLA6DmsJxw
	 1Y0bFey0JF3LdHvFKINzvwyCi4Dl1iE0bl8wIpy/ZqMYsT/Z2qPxyx1sZTrfzFmlsO
	 bF32u6d5t3qJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] macsec: reject frames that decapsulate into runt Ethernet frames
Date: Tue, 24 Nov 2026 18:02:33 -0500
Message-ID: <20261124230209.3183849-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112440-cranial-zen-ea50@gregkh>
References: <2026112440-cranial-zen-ea50@gregkh>
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
[ sashal: adjusted the ICV length macro name from MACSEC_DEFAULT_ICV_LEN to DEFAULT_ICV_LEN to match the older macsec.c naming. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macsec.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 7cbae621a4f00..8cd21629914c1 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -416,8 +416,10 @@ static bool macsec_validate_skb(struct sk_buff *skb, u16 icv_len, bool xpn)
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
@@ -1313,9 +1315,12 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
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

