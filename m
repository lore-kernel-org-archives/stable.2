Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903D532B11C
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787515059; cv=none; b=naY1bijoVKXjzPGxdssKuEP7vuzmZexGnTGtuUce8f8gMShPky1+mOYkpcMgdJGTERpepExMF6kmEOLFBkY5yY+TuH+cKihYt/FGq9XmXusnG0rvvDOv5frwwvhDRFIKXKLtowt7xRPDLdRJV1dX7HGp/p3u+dxqEy5d4ztS21w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787515059; c=relaxed/simple;
	bh=Gk/7UroqYu8xW3qXwaYdRfxdTRLSMms8GPc4wLd/IMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iz2kNCW9jtwrDjT9/5d77tUR5zo1Ohlfdzj62F4NKdisQuHoBunNnlTVK/5CojR3S5xHEObcAgSvLF7sB6cMm1thRlwQEdELtiMxr/b0LrzPccyzrFq1Z+qsTy/ZDJ/1iOq8tiv97b6g4XdoIxoM0ETtUXm8xG2/tgnqMskU9Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=vTBzdOLS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="vTBzdOLS"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c197eaaab00so454937366b.0
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 12:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1787515056; x=1788119856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=drU16NpqjOVFYwneScziNmmGyeG2YnXzmWqCFYgIDxs=;
        b=vTBzdOLS6vWwc8BKf2ADBa8oH1s4o6pG+Zvg/RYI73ELvkZrF6G8EEf3IQ6DY7ysuQ
         iLEkYs+rBdAgYjgoS25h6YjlIXn4RE7C3zCvcPZL5uXu1xZ8/sNNeJ7z+E+Hw8+im9LU
         O3nZul1T+Jz/ItYRI6XLWalVeWxvghmHgXazNDFuRbLKdf0m4qSakM3ZslRCEMDD9TbO
         CdyU33POx3ElrxkDQCGO3AE5uVj4n9luABUGDEaLvWT0mdXmiJaAh6T5gU9wLtPR+Rdo
         qOPrkQ55B3W+fkohUaI5f5/SzMJAUpN/uiRGt2Kc74dxyItLDEXKxQ4lLlGNilvrqtDa
         Qsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787515056; x=1788119856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=drU16NpqjOVFYwneScziNmmGyeG2YnXzmWqCFYgIDxs=;
        b=Av2FvJ4ofDV7i1Pql0hdDk/4o0p8QREnNlH+1NC0Nx6HVjnpc5idHuuhOPT3MGYlSg
         u6AhCsx6MsanqGoNVf3NklmsbPyuvTAMMSq+BZCyyvDcmWcSXvCl8QhlfIgWazXXXH5l
         B/Ood1igo6K8DzAG24f9PGRshpKJgD/MhpyJk/lO8qP/4XAMSx4VWughhzNltyl+hksJ
         XMCHUvcoMMtnWH0UGxZuIbcY0VWaFFUFp816UUH41jQn5DIYK4k2zbX/6q0jZGWxWAJx
         YYvG92JrvtssWvTe6FdqxfvWjif85SDgKa+DnwFR9go4+b2uS/aVOcd81jeMIySL1zUf
         MiMQ==
X-Forwarded-Encrypted: i=1; AHgh+RqyPI0fYO0Uycep7rRmHzqN8CRCdIuJOeUYtE5hlZs3eP3pcGF/wftgnxFwQ/iEJ6IeAPtly3E=@vger.kernel.org
X-Gm-Message-State: AFuF++l1K8I74OazqRSqIzzlEq4UFsosiBf6rvNlmQPo8J6JtiyC2SQQ
	GgqaDBhDkehcvcvYXs6uzd/HLKWH1O1zV1VVrwrCaOBV2zMg32ET6aANY32i7bNooQ==
X-Gm-Gg: AR+sD11uldI/gimlUssk3bkHAoLtMjAvXd5XRfxwc2IZexATkzdlnAVfgAebWziPBek
	b5JhRHKuqfyPRaKlpZJVvJQZYneOwKrIorz6dSMYedlHGbKkjvB9QZ9OvyqBpX4n1crrBbN6XsV
	1QrAuxEj0dfdfP/nznzSJuDQKX4UrZX2SbCWNw66H7MGKauA4NEZ/nzh6h4qilANAYqdf6G/4so
	NC0OvKvxacoBJm4aBwj+QajvFO3To/cuzCon1vegfqfrCUEBLdnfNkxBgf8nDD2MRvJ6qzdP28E
	5b1FmdxJoujOuAKgTLREQBqjtVZJvJYrdN0lr0D3hT8UPehKAqTYHDZAwh986lssP93OfvkrNLa
	jioUDmFOrubRjqwHKhQrxxpxMZtVpCJQt/L7YROd08F5XIqDUVcobnI4iKW6x82PQaAtNrKPjR7
	LkpQyu2fvjOlhQWj76WWEKN+2Am38cJ+FuON/dcJ2lfXJ0ftXR+nCWBWgJ1Rwn3N7HcmZsHQsbJ
	wwQwwEHRenFFenBp+5/454yQudbxEaQlgge7RhMwXzdQpd/N0RQLsB1X47WGxk7HUkJRYEOEAOS
	+wEfj/UpbCSxpFXyqhgdaivziZKlzxjI+jI/AhmOiiZmo+J1KcxyTPp2oH+MYkKsXQaFB9pyOQ4
	2JoyE/pWmnbEVjDjvPNQK/bZxYPkbn9W5MCzibxe3D9DJBrnZ8cw4BNxC+8+gaCMsVJUGFUqyaN
	GtJrCPegqh2fT1
X-Received: by 2002:a17:906:9f8b:b0:c1f:c061:569a with SMTP id a640c23a62f3a-c246a4c6d63mr2074267466b.7.1787515055706;
        Sun, 23 Aug 2026 12:57:35 -0700 (PDT)
Received: from Desktop (pd9513a95.dip0.t-ipconnect.de. [217.81.58.149])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8edsm889532666b.6.2026.08.23.12.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:57:35 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/4] wifi: ath11k: free tx skbs through ieee80211_free_txskb()
Date: Sun, 23 Aug 2026 21:57:00 +0200
Message-ID: <20260823195703.49198-2-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260823195703.49198-1-julius@bairaktaris.de>
References: <20260823195703.49198-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ath11k_dp_tx_free_txbuf(), reached from the HTT tx completion handler for
the REINJ and INSPECT statuses, releases the frame with
dev_kfree_skb_any(). Every other tx completion path in dp_tx.c hands the
skb back to mac80211, and this one is the last that does not.

A frame freed that way keeps whatever state mac80211 was holding for it.
A data frame whose socket asked for tx status has a clone parked in
local->ack_status_frames and an index allocated from an idr bounded at
8191 entries; ieee80211_free_txskb() releases both through
ieee80211_report_used_skb(), and dev_kfree_skb_any() leaks them for the
lifetime of the hw. Commit 29d15589f084 ("wifi: ath11k: Cleanup mac80211
references on failure during tx_complete") converted three sibling paths
for exactly that reason and left this one.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Cc: stable@vger.kernel.org
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1
Assisted-by: Claude:claude-opus-5
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index cac970c92806..52c4a9924a31 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -305,9 +305,10 @@ static void ath11k_dp_tx_free_txbuf(struct ath11k_base *ab, u8 mac_id,
 	skb_cb = ATH11K_SKB_CB(msdu);
 
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
-	dev_kfree_skb_any(msdu);
 
 	ar = ab->pdevs[mac_id].ar;
+	ieee80211_free_txskb(ar->hw, msdu);
+
 	if (atomic_dec_and_test(&ar->dp.num_tx_pending))
 		wake_up(&ar->dp.tx_empty_waitq);
 }
-- 
2.53.0

