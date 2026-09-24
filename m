Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AB340B6E9
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230971; cv=none; b=SEzF7HIqbxNh/h4eJKzsAMCHaT5S026ShAPqYl7KKs2dirYuEhmqxew+L5/MhfCsdrs6XNPJEDFY0OgA7Lv0xgrkK8FP6eARF3JJsoLCk+dq4itWGwQ8N/eEaCQdkIcVfDCg5/HaBlgAAiA2+KhKQyUy7I6F/j7BOfgWNLzi4oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230971; c=relaxed/simple;
	bh=Mk3fSgu7F2inklm698FGg8xtY/UC1g+hSJQWE9hH+Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRcEnia3x25Hq9CzkxL0Q2nuQG+mce8N0qJCn0aEEy/MjhuPLYkCoWgvBjBXunQm0XFrJSEcAwC/5GryfMbS03OyIZlWkZICxjECJV/5kZA4jGzcyopP+UEBTfgigzFVZwdH4y9baOGJJesekCUIHBzQg8nVaOcERSc89XxOTFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXLUwcyY; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXLUwcyY"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f0b25dso10729065ad.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 23:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790230968; x=1790835768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WltmE4hNoTkSsXOgrdp6cz7c6fyzqTtuC0otv1UOPu0=;
        b=RXLUwcyY11ngfU6rR6/2T7DlRzxh+9CrigcCDJRWkT3YvLgZ5p841K+AzGkJZJsni0
         ELpVot0+3i38FyUJe5WHt31yJblyEpAG2v4n8/BZRm5UNZ012pKFT8VrzOxgST0eCf07
         6WmhzmAJr1J71un8VZTSNYc6CE9h2LFhOdTmy3G1dgCwD68QSMD/iAGjzWzFaM4Q+0su
         ho/R0xJ0jeMdKGIkXUmuUIrJjYAnFwIaxtg7hXChgDtZL1ScD4SlspnV2xp3CWoZmJyz
         txYzjvPltzW7oAYYhzB24tLh/qc2NvGwKy0v+ycEX2+nbhPRcv7HpNDKOJSAlN3E5IOb
         kYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790230968; x=1790835768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WltmE4hNoTkSsXOgrdp6cz7c6fyzqTtuC0otv1UOPu0=;
        b=pmdV1TfKsZXVzTH16Ip8jE3riSf1K/4GoCKtcnEkWEQqmQvKMtYPnLPbso9RqM3COy
         h8Mb1vsWLfusfMo3qo6GET8wXsz73NiN0F4DWtW7Hi5yYmkuwtE6tCbcTsK8EMi1QIh5
         7Y4xDT5jJf5Yl7g9r9TYj9gCy+8x+6sYj7TGEg+tlBC/Lbi7FbCpDHO4wzUHlC7UcFc+
         Hf/cbASDwLkzx4ywh20eiqmtA8qHKHI342jHxlZMthOqqmFl72FB3kfV55HOiF7RWCy/
         dr5fqRykGa/4z5TCSVve6Prec2TdnTeGFlchSmPDm7OjhUyGeJJCUtqY95YLkJbDsFOT
         ykrg==
X-Forwarded-Encrypted: i=1; AKwUvBzjyd2IQ8Xy9l31K7zZiDRLq5Qz4joYjggTk1S2sCzGVsP8VmhrZsA5849GK5wm84bDiLKaWmk=@vger.kernel.org
X-Gm-Message-State: AFuF++k0gIlATpReN7YZoN2LRB+ViWC3qV1ywFI3KGPo7Y2i6CDAvq1N
	wnoUSV6hbpD6VxqSqDF2MQtb2yZkcAC2zTVtAglFQC6EKK7ThybCmqtx
X-Gm-Gg: AYBFou32oiERHWH+jZH65ugKwWxbhlLX0L9zRuxpdxUwAzqE524AJQKRLvmtiOmudch
	XXfRf6IvclOm41Um3SJ3xivv4W233CAgPjYTfUMrZrMu33FIDBGR5yZ/1RwQnPp7bt3SSFYinyR
	lkOCTZWdVH6AzdQcmcR9WINPHjuhYlyERwGDVshaJO5jGtulT5sxiyFMGwaY/8DkcNSKEhPk35l
	v2/q63bWtzfBmKE9olf2yt+5z6ilYe2Jg1mUTAqzFoxaKqaPUAhiE8A0xgSwaSrBt+kyUk1G5pa
	+OBrfdQ1M10j2tZtmXJYpWscWxVysjA1qz81oOk1K1TsKU7t4A3W5M0yEoSDUyX8PQrwu/kX6Zi
	ImRHcFdGTWjDzET5xPw/moO5b61Bia5owyu/naZ6CCyItkSB00pIzoVvfU+iSdAAd7cSmptnJfQ
	i7Wd370suaDmRe6NKErqgtlN89U1cAeppx/bwn4qznU5E2vPKEk2BzRpqAR2sAoKkV7fvOIFSE+
	9lyYqnlwUiSrTgy4FuH7aSgPcsbw16FuGYlbOu1OD+ifdliHgUY49hy/0f+//eJ0HlL89kvZ/Cq
	Wu3bAw/9eA==
X-Received: by 2002:a17:902:e946:b0:2dd:c100:313d with SMTP id d9443c01a7336-2df7e2530ebmr11495365ad.57.1790230968400;
        Wed, 23 Sep 2026 23:22:48 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5d7a48sm21220615ad.48.2026.09.23.23.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 23:22:48 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: h.morris@cascoda.com,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	stefan@datenfreihafen.org
Cc: david.laight.linux@gmail.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v3 3/3] ieee802154: ca8210: validate data_ind length upfront in ca8210_skb_rx()
Date: Thu, 24 Sep 2026 06:22:44 +0000
Message-ID: <20260924062244.2444225-4-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260924062244.2444225-1-benquike@gmail.com>
References: <20260924062244.2444225-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ca8210_skb_rx(), data_ind is read at offsets 22 (msdulen), 23
(mpdulinkquality), 29 + msdulen (hdr.sec.level), 30..39 + msdulen
(security header), and 29 .. 29 + msdulen (payload) without verifying
that the received SPI frame length len covers those offsets, causing an
out-of-bounds read when msdulen exceeds len - 30:

  BUG: KASAN: slab-out-of-bounds in ca8210_skb_rx.constprop.0.isra.0+0x137/0x160
  Read of size 64 at addr ffff888006453ddd by task init/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   kasan_check_range+0x125/0x200
   __asan_memcpy+0x23/0x60
   ca8210_skb_rx.constprop.0.isra.0+0x137/0x160
   ca8210_net_rx+0x96/0xc0
  ...
  The buggy address belongs to the object at ffff888006453dc0
   which belongs to the cache kmalloc-32 of size 32
  The buggy address is located 29 bytes inside of
   allocated 32-byte region [ffff888006453dc0, ffff888006453de0)

Consolidate all length and msdulen validations into a single upfront check
at the beginning of ca8210_skb_rx() before allocating the skb.

Tested in QEMU with KASAN enabled by passing a short data_ind buffer with
msdulen = 64 and len = 30 into ca8210_skb_rx().

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- No changes.

Changes in v2:
- Split out as patch 3/3.
- Consolidated all length checks in ca8210_skb_rx() into a single place
  at the beginning of the function before dev_alloc_skb() and dropped the
  unrelated hdr.seq assignment as requested by Miquel Raynal.

 drivers/net/ieee802154/ca8210.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 8aa7ffe..ab245ad 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -1758,19 +1758,15 @@ static int ca8210_skb_rx(
 	u8                    *data_ind
 )
 {
-	struct ieee802154_hdr hdr;
+	struct ieee802154_hdr hdr = { };
 	int msdulen;
 	int hlen;
-	u8 mpdulinkquality = data_ind[23];
+	u8 mpdulinkquality;
 	struct sk_buff *skb;
 	struct ca8210_priv *priv = hw->priv;
 
-	/* Allocate mtu size buffer for every rx packet */
-	skb = dev_alloc_skb(IEEE802154_MTU + sizeof(hdr));
-	if (!skb)
-		return -ENOMEM;
-
-	skb_reserve(skb, sizeof(hdr));
+	if (len < 30)
+		return -EMSGSIZE;
 
 	msdulen = data_ind[22]; /* msdu_length */
 	if (msdulen > IEEE802154_MTU) {
@@ -1778,9 +1774,25 @@ static int ca8210_skb_rx(
 			&priv->spi->dev,
 			"received erroneously large msdu length!\n"
 		);
-		kfree_skb(skb);
 		return -EMSGSIZE;
 	}
+
+	if (len < 30 + msdulen ||
+	    (!priv->promiscuous && data_ind[29 + msdulen] > 0 &&
+	     len < 29 + msdulen + sizeof(struct secspec))) {
+		dev_err(&priv->spi->dev,
+			"received truncated data indication!\n");
+		return -EMSGSIZE;
+	}
+
+	mpdulinkquality = data_ind[23];
+
+	/* Allocate mtu size buffer for every rx packet */
+	skb = dev_alloc_skb(IEEE802154_MTU + sizeof(hdr));
+	if (!skb)
+		return -ENOMEM;
+
+	skb_reserve(skb, sizeof(hdr));
 	dev_dbg(&priv->spi->dev, "skb buffer length = %d\n", msdulen);
 
 	if (priv->promiscuous)
