Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2236043F0B2
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976533; cv=none; b=VKm78Lli/ORDCc56PalWYGRHS5I7GxZmmJPKM+5ba/NYM9LnliD0w62qR2qF5ZTKNlehfNsvdjDRu7VeyMs7T7AXNnXzxIBblFO3nO6sUihR+c1p/Om6GPUzotJYKA4G5Ph3SRhvwpnQ4c+0mbCnqpDCnii1+5f2GcPTooPlKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976533; c=relaxed/simple;
	bh=6q5OvduezYDttcoOa+Vp3n3pmhhO/TNjR5O4tftm/Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AButRP+rBU1is/RDBbfGJxFUFiaM63thuTGV+IDriX1gJRr61F2+27ESakDu8R/Dlx2clAvALQNViuFAwuB12xodX6Gp62qusvucGEc+zOrIquZpRuW77IyAOSpThP8XsQUeN9/R62Y5q5M9pf5TV+mMOizGuI/sDBjrp0o4BLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ms5BoYqY; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms5BoYqY"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso2188603a12.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 00:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976530; x=1790581330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DDHdZIxZcbNH45d5axWRvE/ipmo1BiWw9gWA7FH3ihE=;
        b=Ms5BoYqYr5teC5rECBj2VncEItGwRBZjcJIzSWBqb/CMQpwGP60/+zvTcBpqMdIF0H
         /CkVjPSpRlNsUY62IdICXOnwrD/M5ldxhcLJqmnDXiXIVxrzL1BDZDOtlLVnSnDyhOq6
         urIc2PALgiWt1+GkUSWasHn9dyTRUarEcerH8fJbEWN2wsHa1XIP3lOkmnGSx8/N24N7
         E3/+rsc6YUEqnxLRg3bwIpmJaet+NB8au5hJ0u826lSIK7aMTRaDAZIx4XC8zdoqeVj9
         8Z2c8ZNxXFoqJz0UXbeFULBHQX9cU8jS15S1g2sMKBge7L7A2/e3Zof5wQyRqoga4pMY
         wXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976530; x=1790581330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DDHdZIxZcbNH45d5axWRvE/ipmo1BiWw9gWA7FH3ihE=;
        b=B2zme4QtLBCCh4Un4z1+spTNbdFc136AFCHuHX7AHzvx94rS3ymlYKQ1Y6ZP+FfQ1F
         f4jGiBD6wnMksUUqcJKwulwl3AdO1dCiQKMz4s4ukJLeSgsXZFLk/h6slBUAXL7keWc/
         gmyWx0Iia93DnC2Iab3XJCYgbaQc9tsNzLyXKCCTVRx9AYuYYTAn1BKfzA2TPtBN0Om2
         0W/IAGKBLp10VnkTQWMk7+SFNOS2x2f2WAv85GKe4Xn7mgpvXNxTByd0R5b9k4Qt/tiJ
         h0RocxdqpAANw/pl4hTXKcuRg91VMBt0RW/Nm3Z3ZMT19LtmW9/MVogDg21Y2vJEcWjZ
         eXYA==
X-Forwarded-Encrypted: i=1; AKwUvBwHYH0ZeOcyxVEEGeHV6jgwZSbJHG4GjWQxDzQ16RxCokQ3/v39knZmRABmUHScA4R41xS1szU=@vger.kernel.org
X-Gm-Message-State: AFuF++kK2GhN7VJs6hhoLrFuPuIBqb2Ek6zjqA/DQ3ulJkPpcm3M/M6b
	RGJE7y8ve1Sx+7Eb0Eb4PJ2dOT3bSDN23WQ2pLJU0aGcOaGjWe2kTEhX
X-Gm-Gg: AYBFou0k5gdNWGoOsovUz8iLk8X2jr5oIceLizFar/RZAwI6Z1J3Q2DuKFT4POmizMp
	ArjyAv3Sdjuuf7388HCl+PSrQL6OTDiuJX1/FGW5nuQrzsUNYqHiSl7s2wAiAUc+XXkz/YszGmD
	WfKRcJnAlKW5rZwET10IKcuICZKTRJEcvp2KIwj2uNZhfZANHwO+YvXRr9ITbdnxfHCExqToffJ
	W5/uJChQ7EyX7DvEW3Gd6h/XcRbp2eK17DRfFvS4mv39UtDtJuJYhxgL/xb1kaG1MuNWwaD7VQu
	4HJTjsrfjvC3sgcgWbreQg5yHzxV9GV2gQd2nGmHOzjRdAKlvsrZIZOofYJdLnClBONRGdsf5Tb
	Ixrc1ChWCNrTd1YI8e+oiVybpL21mLi+U0HzxXylCbsJ7E91kYdIjUi650OUwmr1dax33/xloM2
	hgKDzDG4dbU2bD8ncz553O8++4r7pRcOQhMst5+xX5SUTDyTC/MqMu6vIwS5Oa41Hs9fwph6LP/
	5/QZlbsdIYeuX0Pw22+0cqODfhiQrv00ldNGo3Ys86m5rvv5za01wCgl6c0YqYJRBNHgo4+8Q0h
	ZVA+kQz1PA==
X-Received: by 2002:a05:6a20:1605:b0:3cc:2552:ddd7 with SMTP id adf61e73a8af0-3dd8c2ddcb5mr17987536637.5.1789976529965;
        Mon, 21 Sep 2026 00:42:09 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae70637sm3048650a12.6.2026.09.21.00.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:42:09 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 4/4] ieee802154: mcr20a: fix 1-byte out-of-bounds read in mcr20a_handle_tx()
Date: Mon, 21 Sep 2026 07:42:07 +0000
Message-ID: <20260921074207.2289391-4-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919213639.3316625-1-benquike@gmail.com>
References: <20260919213639.3316625-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mcr20a_handle_tx(), the 1-byte psduLength prefix (lp->tx_len[0]) is
already sent in a separate SPI transfer (lp->tx_xfer_len), while
lp->tx_xfer_buf transfers the payload from lp->tx_skb->data. Setting
lp->tx_xfer_buf.len = lp->tx_skb->len + 1 causes the SPI transfer to read
1 byte past the end of lp->tx_skb->data:

  BUG: KASAN: slab-out-of-bounds in mcr20a_handle_tx+0xf5/0x150
  Read of size 17 at addr ffff8880057f7500 by task init/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   kasan_check_range+0x125/0x200
   __asan_memcpy+0x23/0x60
   mcr20a_handle_tx+0xf5/0x150
  ...
  The buggy address belongs to the object at ffff8880057f7500
   which belongs to the cache kmalloc-16 of size 16
  The buggy address is located 0 bytes inside of
   allocated 16-byte region [ffff8880057f7500, ffff8880057f7510)

Set lp->tx_xfer_buf.len to lp->tx_skb->len.

Tested in QEMU with KASAN enabled by transferring a 16-byte tx_skb->data
buffer in mcr20a_handle_tx().

Fixes: 8c6ad9cc5157 ("ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out as patch 4/4 covering only the mcr20a TX SPI transfer length
  fix as requested by Miquel Raynal.

 drivers/net/ieee802154/mcr20a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index d01b277d33d2..d7e076397550 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -867,8 +867,7 @@ mcr20a_handle_tx(struct mcr20a_local *lp)
 	/* add 2 bytes of FCS */
 	lp->tx_len[0]		= lp->tx_skb->len + 2;
 	lp->tx_xfer_buf.tx_buf	= lp->tx_skb->data;
-	/* add 1 byte psduLength */
-	lp->tx_xfer_buf.len	= lp->tx_skb->len + 1;
+	lp->tx_xfer_buf.len	= lp->tx_skb->len;
 
 	ret = spi_async(lp->spi, &lp->tx_buf_msg);
 	if (ret) {
-- 
2.47.3
