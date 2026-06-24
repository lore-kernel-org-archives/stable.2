Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D254A274FD1
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782341122; cv=none; b=c4SC7kWRDSsbHznTiz5ToxLZcoY/8a6B9pOIrf+kBASGyFKK85Vy3elgWOuXGC6S0L82lwYnefVGDQbcT1QOrsOTzajkF5jFRYw6S/YhtjQ432DgMF/7SDYUgc29JJbqzCra3oB/IYWXMeJwfipThYjtN+8WCi68hyt34fESSUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782341122; c=relaxed/simple;
	bh=F9Kyj9psFA3CcUgAE4ZqMqWA0H5hu/8LTdI7oKfL23g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zd5f3OZFb6HVp8TK6FRTws/noFXcIEhXRwlLCkSI8vthJvgjQZ8EWow4OLdDLoNR91GPYamCzAqQ9KPu48McVey6KodfcP8p7A313njhXYZQrjS87JRbF3zAUOJJBx2vKBj9Xeavs+VPKko5zBL36eL6fDCRvEIB2qcP+DBK7GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=a2xcvEO/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bynar.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b="a2xcvEO/"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bec450b950dso281903266b.2
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782341119; x=1782945919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OIv0SNIrWvan8AixNggFQO+S0jupCa7X1WRFdoPzAug=;
        b=a2xcvEO/u4eMoyWkO3g0O7rq+d9euVX2ADJCaP/pZ4WgBapkIx/rDC6K/KXetrPMhP
         jU3xc8B4zLOTTpXJi4CZyHi40VaU47033EoIZKc+coaYkpp6ovw7K77PHqfODQOwgXsf
         0ca4VgEO+MGh6dQ+wIO/03bN7MYaUDKRptbgQFmm9b4exAznwjVqhex3t9No0VnW0QMZ
         CUqDsjx2GgMyQAbAV3iTfpfqa8RqOBHo+ZcZEp5kjrJylOSoIW16Z7gy9Why6/Z/Lswm
         uIb1ngm+sNdr+2puiZwtz1y8KgnSsD4JCXFkm1w5XxbYllaM6JeZDr3zeuxhssPtnYwb
         WWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782341119; x=1782945919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIv0SNIrWvan8AixNggFQO+S0jupCa7X1WRFdoPzAug=;
        b=dZmUVkBYtZrO79dv7qHA+GFtiFCS5a0pmfDAFCEQ7ad672Ejieio99zs4qZZnbnmZH
         UsTjHRxkVs45eGKEibNu46cb2tSraBbIjnIOQ6Q98wsLVzyAVsjvuS9w86FO/1xf9gtJ
         Gv8y89rDW/jM2jwZcaRg3Xt7SlCCqCXwMrakrXP+/Y2a3Dm4KjVcjDlqR7HaXBfyvAYt
         m+U9TjObeyZ29/436U2xqFsSyoyvMZe57FdFgVo2Hnjqx3DUn96hL2D3tIhYOD03R5nh
         uDenJpshxAnAtrg6ltbp1JpU3W3dGmZXHyXrSJx1jiA5JFWgQiW//kwfYxB7dpun/F/C
         W8yw==
X-Forwarded-Encrypted: i=1; AFNElJ9eeBI5dVlLpP74Js4/F2svI7ZlyRo1+hPo10y98UkC02v4iEiOVtIl1ZyclAr3aMZRYiSpKPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+H6LAqgQeGlcs5qYWhPcCxZZOYi16P/SCkjYq7G5j2uAUd0ZA
	cpeaL2KQR3n1xYILD5pbkAHdpKWwug91NiRcxeKFHWnbFVmPbMTT0f7e+K4l7L2aqG4Z
X-Gm-Gg: AfdE7cnQn+DMhb2EwJhnbI+biFMTZw5ylpvjr5ayggkVf9bWxUtMXQZhovYqiAXRkM7
	eXrBo7+HaUk3esorHDPHV/Ohd80w0rIsnJ7W8hpYm167ehKU72u1tbr5qgue0eeCySxvXBEKwbl
	3c6ACapuHs8hUIyBiS2/52eAPnQK6TpZW4v8aT0bRgeTzWBqp4N0xwWyyg4mzFcrWbhO6GdpCx/
	ZjJhMi8UFC+vSHMeHu/aUVYENx4lBtYA3so1UiSFWz0ygxajyDS70TJHPE4LCH1ZycP5NBJ1CAi
	5tFqVIRV/+J2H6y5wOJp4D4gs+eJIzSZw/JvGTbqLDaSSROlLzuiWzR5bzfqwTiXPXrrZJd1Pcg
	F7gPRbD7m/ayjqDzqTV8KFNmB4kha3njhKg8LGFSW6PV9tIkcWbxAm8AkEwEkml5XDO0ZLQIM0m
	uDRtwyvs5vpmA=
X-Received: by 2002:a17:907:6d07:b0:c02:6fbc:203b with SMTP id a640c23a62f3a-c10801b77fbmr541038366b.46.1782341119093;
        Wed, 24 Jun 2026 15:45:19 -0700 (PDT)
Received: from localhost ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe6220esm51310366b.45.2026.06.24.15.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 15:45:18 -0700 (PDT)
From: Samuel Page <sam@bynar.io>
To: David Heidelberg <david@ixit.cz>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] nfc: nci: fix uninit-value in nci_core_init_rsp_packet()
Date: Wed, 24 Jun 2026 23:44:55 +0100
Message-ID: <20260624224455.999374-1-sam@bynar.io>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CORE_INIT_RSP handlers walk the response using length fields taken
from the packet itself, without checking they stay within skb->len:

 - v1 computes
	rsp_2 = skb->data + 6 + rsp_1->num_supported_rf_interfaces;
   from the on-wire (unclamped) interface count and then dereferences
   rsp_2, and memcpy()s the advertised interfaces - both can run past the
   received data;
 - v2 walks supported_rf_interfaces[], advancing the cursor by an
   in-packet rf_extension_cnt with no bound.

A short CORE_INIT_RSP therefore makes the parser read past the packet
(into the uninitialised tail of the RX skb); the values are stored into
struct nci_dev and consumed while bringing the device up:

  BUG: KMSAN: uninit-value in nci_dev_up+0x10f3/0x1720
   nci_dev_up+0x10f3/0x1720
   nfc_dev_up+0x187/0x380
   nfc_genl_dev_up+0xdc/0x1a0
   genl_rcv_msg+0x5d4/0x9e0
   netlink_rcv_skb+0x28f/0x530
  Uninit was stored to memory at:
   nci_rsp_packet+0x68f/0x2310
   nci_rx_work+0x25f/0x5d0
  Uninit was created at:
   __alloc_skb+0x540/0xd40
   virtual_ncidev_write+0x65/0x210

Validate the response length before parsing or storing the
variable-length parts, rejecting truncated responses with
NCI_STATUS_SYNTAX_ERROR.  In v1 the check is done before
num_supported_rf_interfaces is stored into ndev, so a truncated response
cannot leave ndev->num_supported_rf_interfaces holding the unclamped
on-wire count, which nci_init_complete_req() would otherwise use as a
bound for the fixed-size supported_rf_interfaces[] array.

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Fixes: bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
Cc: stable@vger.kernel.org
Tested-by: syzbot@syzkaller.appspotmail.com
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
---
v2: validate the response length before storing num_supported_rf_interfaces
    into @ndev.  In v1 the unclamped on-wire count was stored first and the
    length check returned early on a truncated response, leaving
    ndev->num_supported_rf_interfaces > NCI_MAX_SUPPORTED_RF_INTERFACES; a
    subsequent CORE_INIT completion then walked it in nci_init_complete_req(),
    which the syzbot CI run on v1 flagged as a UBSAN array-index-out-of-bounds.
    https://ci.syzbot.org/series/2a9a8657-37a3-4dce-8cb5-2035027791dd
    v1: https://lore.kernel.org/all/20260623222402.175798-1-sam@bynar.io

 net/nfc/nci/rsp.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index 9eeb862825c5..6b2fa6bdbd14 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -50,11 +50,25 @@ static u8 nci_core_init_rsp_packet_v1(struct nci_dev *ndev,
 	const struct nci_core_init_rsp_1 *rsp_1 = (void *)skb->data;
 	const struct nci_core_init_rsp_2 *rsp_2;
 
+	if (skb->len < sizeof(*rsp_1))
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	pr_debug("status 0x%x\n", rsp_1->status);
 
 	if (rsp_1->status != NCI_STATUS_OK)
 		return rsp_1->status;
 
+	/*
+	 * supported_rf_interfaces[] and the trailing nci_core_init_rsp_2 are
+	 * addressed using the on-wire (unclamped) interface count, so the
+	 * response must be long enough for both before any of it is parsed or
+	 * stored into @ndev - otherwise a truncated response would leave
+	 * ndev->num_supported_rf_interfaces holding the unclamped count.
+	 */
+	if (skb->len < sizeof(*rsp_1) +
+	    rsp_1->num_supported_rf_interfaces + sizeof(*rsp_2))
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	ndev->nfcc_features = __le32_to_cpu(rsp_1->nfcc_features);
 	ndev->num_supported_rf_interfaces = rsp_1->num_supported_rf_interfaces;
 
@@ -88,9 +102,13 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 {
 	const struct nci_core_init_rsp_nci_ver2 *rsp = (void *)skb->data;
 	const u8 *supported_rf_interface = rsp->supported_rf_interfaces;
+	const u8 *end = skb->data + skb->len;
 	u8 rf_interface_idx = 0;
 	u8 rf_extension_cnt = 0;
 
+	if (skb->len < sizeof(*rsp))
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	pr_debug("status %x\n", rsp->status);
 
 	if (rsp->status != NCI_STATUS_OK)
@@ -104,10 +122,16 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 		    NCI_MAX_SUPPORTED_RF_INTERFACES);
 
 	while (rf_interface_idx < ndev->num_supported_rf_interfaces) {
-		ndev->supported_rf_interfaces[rf_interface_idx++] = *supported_rf_interface++;
+		/* one interface byte + one extension-count byte must be present */
+		if (end - supported_rf_interface < 2)
+			return NCI_STATUS_SYNTAX_ERROR;
+		ndev->supported_rf_interfaces[rf_interface_idx++] =
+			*supported_rf_interface++;
 
-		/* skip rf extension parameters */
+		/* skip rf extension parameters, bounded by the packet */
 		rf_extension_cnt = *supported_rf_interface++;
+		if (rf_extension_cnt > end - supported_rf_interface)
+			return NCI_STATUS_SYNTAX_ERROR;
 		supported_rf_interface += rf_extension_cnt;
 	}
 

base-commit: a986fde914d88af47eb78fd29c5d1af7952c3500
-- 
2.54.0

