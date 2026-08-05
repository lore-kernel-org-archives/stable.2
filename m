Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAAA41BA8A
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924118; cv=none; b=ujd3qXsa16Gp3IhgKeXXKDx7PYnkH/88RP1OdbiDGJHNZeEjgk+HDdB19VI9g5yC7OZagKzddeEgTgkXMXeqyZh1NT54vHO9p2sh76tCdpu15ls5g9rv3HA5Cl8vQFFgUdovSqH9bX1Pl5fDieQHnh8ZPxjP2iCH4GqWgQT9Z1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924118; c=relaxed/simple;
	bh=804MoK1/qgKtYK1haJrkmGhKwa9+WxJwxY1NN0N6G1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0gH76850zy2YjEsrN6QC88+kHGi3bx8cwkrEy9ngTn3RxuD32goRdrc46OKuTlV48t7N07C60Y6EMcl15JAftUCbfRDqK91v76UT5PklDqRQZh2d/7WsyDRGgJtEatggfB6Lv0GrBq7r9Fc/KeD/4sYJQiGj3RA4tGB8JSzrm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=On2ih9Un; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="On2ih9Un"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a17cb94b26so446365a12.3
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 03:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785924115; x=1786528915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Auqb/Pc8pm6mSfDL4VdTlzAtlbQlPaebkU+VML+2HK0=;
        b=On2ih9UnRE8GHNArJjBYq5+m3bQYd5GUHrJW+xFKR6OCerVibnYkaWMdcAwWqRZ6bH
         wCAJFKkhR2L6SJhimmljxaObz38mI3C7uhxAYH6f/XRF8K/pyN5/DQHu0Vdat0CS9hoT
         7C8vdbju8AD0tSDbpc4HdeOBtHDUMNI0RgDlN/gpKq8/wAuZvvVURl3gv/SrerZtjE/Q
         txIYFzS/tzU2Vg6iCGfWMDZDxSjQpHHNeHdi9QPahUwcwoR8lWly8l/EvHgJsnctdzeL
         zaJwCD64bvy6LgkcAsGot1eo7hLi5IhzGgKjEqLs/zMbg5no/GDNzWdEFyIM1Ug3J7G0
         6S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785924115; x=1786528915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Auqb/Pc8pm6mSfDL4VdTlzAtlbQlPaebkU+VML+2HK0=;
        b=CgJC6SVIEJbMDl+3Cu5XfWUNa2JNY/VPAU3SOQNIrLrq1K95NtPoLvU+dAZC1AbTO8
         m8bjQ1sJA9iYa29Fv84fXqM3ZWm25t+/Wo4UvPF3oG7tKMasFPCS9p4UMP3qCRPLATfL
         HGoSmChlmayZuH8K79SMQuLRqevfQdtQS+837DvI/ssBWXrPcPhmu3YhUDt+IRvd+o1H
         HAzd0ytBZXTu5/7lv6toQsXv8IiZB0cCVlarYCFpqgOQlzNaec3czGN8FCOkMO2vhXc8
         FFNuT9PmNvKrTzUrKLi2R6zhqc00MtiPPMvW9DT5a/cUf0WSVaq9XqIC6K1HeLuVl2n2
         rP2Q==
X-Gm-Message-State: AOJu0YxsGsDfzsvHPng6wpB9uuxiGq4gwxtr7RlihxU0jVnMOqebvazA
	TqO9LbO0e9HLkNy93uSKQV+VKxiT0a9lBMhhMElRRAwTdw/tf+yudlfIS9BXNdFf
X-Gm-Gg: AR+sD12vtIT4u5TaGAzHw8MMQypAnL0hQwcFKYkxmMMAzEPG1ToQ4dKFuMWj9X1H3kX
	SvE5WIxj6TrIeyOPZyIY22LkWn458qErdvaTP80g3P6cDqAuhIcKDSwXL2/CuREfNTROPcSH4VJ
	epFqP8bn6w/kqNphlw25jdV3Ks+ko79y33yMyOYG1To+BRISpUhXKlZvMbIklaT4gNfF/80hO5/
	LLgkKtVvrqwX2WN0fkr+WQVMmkXDvJHXfYb4h+xpDMMm5B9wMpB3RO2b8IwtX69IphzvlYYuEPG
	mCcJnj0+HdOyHEQwcZwtG2B0MCabDdOzQijV3zZX22JDGd58iNxhkDHoWhIMeroxm4s/cLHPgNh
	Ou//Ra6pHidE1MEGSdGT88xwHu1qWHjqrBebxKTEvf5iHowV7FYH25754qSXJER6THu80WXMXS1
	siZ6vO/suzStBoSLDSOmu2G+lr/jrZUka6/Q9ZEfutxewde0/lfr/X/5VzsxQmaQ==
X-Received: by 2002:a05:6402:4008:b0:698:5610:76e5 with SMTP id 4fb4d7f45d1cf-6a14f104110mr3334876a12.6.1785924114935;
        Wed, 05 Aug 2026 03:01:54 -0700 (PDT)
Received: from arbab-X395.dbs.corp ([110.93.227.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec249a5fsm7344776f8f.33.2026.08.05.03.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 03:01:54 -0700 (PDT)
From: Arbab Haider <arbabhaider649@gmail.com>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.0.y 5/5] net: stmmac: fix transmit interrupt coalescing
Date: Wed,  5 Aug 2026 15:01:36 +0500
Message-ID: <20260805100136.59101-5-arbabhaider649@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805100136.59101-1-arbabhaider649@gmail.com>
References: <20260805100136.59101-1-arbabhaider649@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

The accounting for transmit frames does not count the descriptors
correctly. It uses:

	tx_packets = (tx_q->cur_tx + 1) - first_tx;

however, these are indexes into a circular buffer, so cur_tx can be
less than first_tx, and when that happens, tx_packets becomes a very
large unsigned integer. When this is added to tx_q->tx_count_frames,
it has the effect of reducing the count of frames, possibly causing
it to also wrap to a very large unsigned integer.

Fix this by using CIRC_CNT() to calculate the number of descriptors
used.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/E1vuoIl-0000000Aouz-0ttb@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Upstream commit dd53a0e85969c6b2a5a4e4e46ba05b3187231017 ]

---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 81a6ab19a45b..0266b09f0faf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -14,6 +14,7 @@
 	https://bugzilla.stlinux.com/
 *******************************************************************************/
 
+#include <linux/circ_buf.h>
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
@@ -4511,7 +4512,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
 
 	/* Manage tx mitigation */
-	tx_packets = (tx_q->cur_tx + 1) - first_tx;
+	tx_packets = CIRC_CNT(tx_q->cur_tx + 1, first_tx,
+			      priv->dma_conf.dma_tx_size);
 	tx_q->tx_count_frames += tx_packets;
 
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && priv->hwts_tx_en)
@@ -4789,7 +4791,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * This approach takes care about the fragments: desc is the first
 	 * element in case of no SG.
 	 */
-	tx_packets = (entry + 1) - first_tx;
+	tx_packets = CIRC_CNT(entry + 1, first_tx, priv->dma_conf.dma_tx_size);
 	tx_q->tx_count_frames += tx_packets;
 
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && priv->hwts_tx_en)
-- 
2.53.0

