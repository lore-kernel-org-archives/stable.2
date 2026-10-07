Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C590D448B89
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791389848; cv=none; b=W3AXb1rmGe7jRfDjqjN5aX2bTuXyl5xrc4nx6KqYl6nBbtVwC4CShgK3gTP5FFtZ+S4IrEfBWh4Oi0QkUQ/zkIAT5wlDueciu9HSRoAweQN6qGldxy1hQ2YLL+gO7O9F4tgu322TLkYrqzr+NxgDYx/EGFRuTLILpJtH19+mgmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791389848; c=relaxed/simple;
	bh=a89fgaBK7g9X0Q9p3i7HU0eZuNNDuBA7NFi5fgWdtzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biGMlidwxM15tT9IkCI5JZtdd+1BVi+rIJkwEl2QT/mhJNsRwgMQ+jg/lzsQWK/M4uomhb0b+bAilC7ORKJYSXiBXCTe5lniLSMDyMw5C8Wx2aJXi1RbshOTLzuNJMWqU46bqF2rlpBXVF4aGRGTRi7tj8Nw53Rwv3+l5rPIv5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnewXcSr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnewXcSr"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so18565835e9.2
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 09:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791389845; x=1791994645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m8p7v3GmFSxW6TAqCAy75L7noVc64c91U1hmvayd/Cc=;
        b=MnewXcSrkmX/H8djIkSszfqYGhZkwfV8o25HAavqwjEV6cunuqj0e2FgnEPDVNcHoQ
         rmQ4Dfzs0Jy42cvMmqHwTLgaQRZBYxvv/TfkbdegO3k41ml2FbQhxhh+kDDOVtuHCur3
         FXS962Z870PeiAjjfXHOyB96rz2CNBCmo24XCXd6D0cGk/f91vj9IbJmz90cVs+JB5cR
         +q5gXtXRQTDN/Jmf9a+aOJtBE2PxB6p6yMdxOJ+/l7V+77FwfETDJ1wSlP9llEjP/N1Y
         QOdtOBmODz1Icm6FTiOtezvEsICqqEnshXi9NsDExc+QYBC6WI/yX4f7KkgubRoTFnBG
         K93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791389845; x=1791994645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m8p7v3GmFSxW6TAqCAy75L7noVc64c91U1hmvayd/Cc=;
        b=zUGtdfZ65w9koVyjG2b/FkENp3OMYQTmi4JvbikX1WL0/hHgAuUR926Wrjj4G3/y7L
         O89BC00nvLyE2DAd2CR3IHQeNSHLItG4Kiqnn2a3+JK3x6NbbEd3opqkM8fYrnmraCIn
         YdfNlEDsW99GuWA4FCTyoaiYavoKf2nbIXiJj+6jFHa4RS6uWT9HHcSKVuCro2VCiuhZ
         8Qw3f3hd1iViv1ubsK7rWCLVkSby75qn84pvpJe1FKSPRiLAetG38wwURcZ47IjUiS8n
         8aWbGfOP2Ui48OE4iUdHkdNzz0SB/9CPgCB2nElmzXPP7ZaIZ6L65oLyWHCm5KTHgxLs
         CUAQ==
X-Forwarded-Encrypted: i=1; AKwUvBypJRCDxRYJUFvL/EAGH/UkDS+47Bsi887UllPVkBNnXMETr/TFidPTWhGaQ1pCmWOxVLt8SfI=@vger.kernel.org
X-Gm-Message-State: AFuF++nY32S8k+PRFDORJfEvHyfmICHlaAt5tP+WY0ciY4BQN8aPKd/s
	WdlY2dyKWf5VOwUpOciC/eUKWJ3qi0yP5Fay6HyD9JqXsWI5dIfxX7Q=
X-Gm-Gg: AYBFou3Y9Pxw7v2vrXqnzF1FaiuweZAdQ7fYJgSwWHt6CjAFlsrgg+ueU7KMqnjZKqj
	G2Ip37j6qNZ+FM+WjI0/ZApaBeNWL2LBSz8HnQNPFJWD0j8VUHejEv1uVd9Vu8Wr929ZtyDV9fZ
	EnfvRUA6kxyMWO3MXUsvKSCz3x/Pyt3HlIB9uN4K0NKjONBid8MEaUFQ+YzeAsvI7s7nrTjvvCp
	Xq2NN8Fa5msf01Bk0QDU9EgdJcnUEdKuojo56IBRotAWntws+ekvTfQ7/Hh6mQa+zcgo4Hz7V/i
	2mVqAeZYhRpgkGaLLbjQyu2zy8cnwH0wtfsASdcZeBacNB3cUpes2b9mHk+ht3/xUC+Qci4ADZ6
	hOBws42u99bvic2KVfZ7C09ossl5KP0qJWrBF2VflC4oZeXuNE8bbHPYfiY0jigDJGsDSZoOgPZ
	3jN7Q41LlYVKzMjvUXTQyz3AyBNxFIID+oc/Q2d0s=
X-Received: by 2002:a05:600c:8b6e:b0:4a1:78da:d271 with SMTP id 5b1f17b1804b1-4a18064be59mr47434215e9.30.1791389845063;
        Wed, 07 Oct 2026 09:17:25 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843aac98sm2685295e9.9.2026.10.07.09.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 09:17:24 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	Po-Hao Huang <phhuang@realtek.com>,
	Chin-Yen Lee <timlee@realtek.com>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless v2 2/2] wifi: rtw89: fix IE length passed to cfg80211_find_ie() in WoW AKM
Date: Wed,  7 Oct 2026 16:17:21 +0000
Message-ID: <20261007161721.261452-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261007161721.261452-1-tristmd@gmail.com>
References: <20261007161721.261452-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

__rtw89_wow_parse_akm() computes a pointer to the IE area from an
association request frame:

    ies = mgmt->u.assoc_req.variable;

but then passes skb->len as the IE data length to cfg80211_find_ie().
Since skb->len covers the entire frame including the 28-byte management
header and fixed fields, cfg80211_find_ie() may read past the end of the
actual IE data.

Fix by computing the correct IE data length as skb->len minus the
header offset, and validating the minimum frame length before parsing.

Fixes: 480dd4dddfc5 ("wifi: rtw89: enter power save mode aggressively")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/realtek/rtw89/wow.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 2dfa24c54e7d7..178c59692b13f 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -16,10 +16,14 @@ void __rtw89_wow_parse_akm(struct rtw89_dev *rtwdev, struct sk_buff *skb)
 {
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	size_t hdr_len = offsetof(struct ieee80211_mgmt, u.assoc_req.variable);
 	const u8 *rsn, *ies = mgmt->u.assoc_req.variable;
 	struct rtw89_rsn_ie *rsn_ie;
 
-	rsn = cfg80211_find_ie(WLAN_EID_RSN, ies, skb->len);
+	if (skb->len < hdr_len)
+		return;
+
+	rsn = cfg80211_find_ie(WLAN_EID_RSN, ies, skb->len - hdr_len);
 	if (!rsn)
 		return;
 
-- 
2.47.3

