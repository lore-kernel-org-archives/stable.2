Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.130.202.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794979967;
	b=IWEyhPjVKhN0yihO+38OxEb/9e5gNOsIicJAklVLIFsgndhjnI+8MtlS00/T+5zkUQMR
	 JGHGChDqy+dUBjk0gkUyZWXramMM3b7/jb1yclE60wz8f6T2h2+yUgmW4I6OshaZtC3GJ
	 Ku4DiB1B5ZB6J/r0/cPV8PYZ1cfxJ+tEVrnJZZpn8QYjXQDCkQihsJlCJOIVgstkoPvjU
	 yqvdmc3BebG1Xb8/5+jaQtZVnvV341qVENm6AN9fyybS2U0hiW7pmxDviZOX8Cm3dcF84
	 3riyJ3UYaopv7W2k5isC4BmYpyrQMFag8Vo01FVPjeTn5fDOx1mKa/svE5pQ6qKZFIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794979967;
	h=DMARC-Filter:DKIM-Signature:Received:X-Iguazu-Qid:X-Iguazu-QSIG:
	 Received:From:To:Cc:Subject:Date:X-TSB-HOP2:Message-Id:X-Mailer;
	bh=oHVtRigFa93zwH9aRafwj8JP9ksXFuUfUF8JGhGhU0w=;
	b=ayUeYtvyVWcd5ElXc/Zry1p7poJlTa8bG7lFQlY6MvXX6AGp7yJO62hnqB7yg4GrW5Xm
	 YLUMTsAUrBOTm8EYsxKJeLvnpKXAbGhBT8Q2VC0K38hQrG9GjfAEQSAwYapOhTGjOgdVC
	 OBm101UU24EVAyDKNT+nzESoBA2uAF0YBzOBXhXT42D8u+lZdSDKPQ8UFh/gyXWrvOtXG
	 ULFaOx4ESK/rqJghv3tBak9QxLx7JUVh/DrCQkIDODzZlk42GFDM+zpJH7HNFw+Zyl+Px
	 4KLeirWj6wiPrRK159WmLjfPKKI/dpbs7c4bxkqiZZeiaST8QBg7LM57k6UjKn0uYrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.toshiba;
	spf=pass smtp.mailfrom=mail.toshiba;
	dkim=pass header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=uY4KntUf;
	arc=none smtp.remote-ip=210.130.202.132
Received: from mo-csw.securemx.jp (mo-csw1121.securemx.jp [210.130.202.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74719606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 05:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74719606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=uY4KntUf
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1794979948;x=1796189548;bh=/A/8oMDD1IL21a81l/K9n99yn+Svv09fLZ7i3Ow19qE=;b=uY4
	KntUfm0Sa2VvpYmWyH6d7Fa+Ykklj8cyydm4+2fmmNCzYeAzbIV2yQ9uxshO4F/TI+DTRXmgI5F73
	4Iy4Y2ZiSBmZK49mdML8lZ3a5KdkwqLpJG6VvnyRTYpxcRYIL15lyBvDJaFVGH6G21+tJWVtpF8aP
	uqGZLYL3tLXeriTZ0z3VhovgJMX6a4r0prxQWcjj+olLctn4RmPO+ZGnaXjwcXmRVH72AvwVZb7Os
	B3sGLMkrJYfnwBewgKWUwi+ZfATrssYqe17ore5wnR47DWK5JAqDJC6VJk54hKwX2gwCyaSX5M6qt
	UAcssXmgfAG7zDDvvC7qT053XtmCC7g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 6AI5WRPX093145; Wed, 18 Nov 2026 14:32:27 +0900
X-Iguazu-Qid: 2rWhEvwfQZThFW9SMl
X-Iguazu-QSIG: v=2; s=1; t=1794979946; q=2rWhEvwfQZThFW9SMl; m=/BJyROZirB/5A5P/00niClJQLgVg3BG3Y7RKVUY9ccI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jTqx604N3z4vym; Wed, 18 Nov 2026 14:32:26 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org,
        Zilin Guan <zilin@seu.edu.cn>, Felix Fietkau <nbd@nbd.name>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 5.10.y] mt76: mt7615: Fix memory leak in mt7615_mcu_wtbl_sta_add()
Date: Wed, 18 Nov 2026 14:32:19 +0900
X-TSB-HOP2: ON
Message-Id: <1794979939-14045-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

From: Zilin Guan <zilin@seu.edu.cn>

commit 53d1548612670aa8b5d89745116cc33d9d172863 upstream.

In mt7615_mcu_wtbl_sta_add(), an skb sskb is allocated. If the
subsequent call to mt76_connac_mcu_alloc_wtbl_req() fails, the function
returns an error without freeing sskb, leading to a memory leak.

Fix this by calling dev_kfree_skb() on sskb in the error handling path
to ensure it is properly released.

Fixes: 99c457d902cf9 ("mt76: mt7615: move mt7615_mcu_set_bmc to mt7615_mcu_ops")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20251113062415.103611-1-zilin@seu.edu.cn
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 62a971660da7..ff5a1edd8dfc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1379,8 +1379,10 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 
 	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(dev, msta, WTBL_RESET_AND_SET,
 					     NULL, &wskb);
-	if (IS_ERR(wtbl_hdr))
+	if (IS_ERR(wtbl_hdr)) {
+		dev_kfree_skb(sskb);
 		return PTR_ERR(wtbl_hdr);
+	}
 
 	if (enable) {
 		mt7615_mcu_wtbl_generic_tlv(wskb, vif, sta, NULL, wtbl_hdr);
-- 
2.55.0


