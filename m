Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098204266B1
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195246; cv=none; b=LMBzr8PhFdTo3UFB/piwOPyFLa242j5nPt6QHMNAdv6CHkmLCKtTD+u/VKSk6eMAbEZvEwo+EuTj+XmUMulvbJ0qSygD3Wzcl/sEYHfSIESYvuhvOqvuIYZ2im4YJjjaQjJWJf46s3vS5vICisUm+u7ITi5ZqMDaFueHwwxdWbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195246; c=relaxed/simple;
	bh=A8tMHRZ+jlwjkwTJ703+ZnI5YYR5LiNC6BgBVzaV7sU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c83CwocDsHEIPMxN7h7fgamZEThYjIIzyfII4KI8JHGZcK5V0Y+9vtmWx05VldUm+WgCNQeDOv7m3zb6Xo7WFHb4WKKUbSVFudx5AAaRJt+19gSGiHt3KQF+mv29TXr7aMWNX2eWLIVbSgfcmL2Akbn2wmnFtyzYL6xanbUlKRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs6XbelL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs6XbelL"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45ef93a0b0fso1457f8f.2
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781195241; x=1781800041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KkKnjsGGzb7NsTQucsijuq+HFGUV8ktC3DxrHhupXYA=;
        b=Xs6XbelLYzLmrFvcTwifisxbRuBjCQ7pRQIv+EPghzMn2A89yjtTOgVvRYLPhS68/M
         d2oQyM+jq0fG57XtmGW0NvZI9nLgjtOPSl5owZGTN4jPzE5AF56X4YMDxBut0qRPl2Au
         M/Yl1mgAipKzyLsAoYd4wkYbh6H2d3sxnjJJkmXR3YPQQghgVESjxzYLwq7E59EmnHDB
         uPcMZmojOG239FdbDjYqt9OpyzakTT4y8ktyumXZPAMe/TLqvghEpF/wZHpuLhUiJooY
         1SYOWjmVQwfVj7mzWge67L7nOo2lVq6ThosyhEyif6GjAfXiGLVCQEMtTgWVtyWUciFA
         Q2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781195241; x=1781800041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkKnjsGGzb7NsTQucsijuq+HFGUV8ktC3DxrHhupXYA=;
        b=e8hm3KI1gj9uA0yqRFMBgMgxPKYjk+Bf8d8uVEiT5WplyWXRVYgRHaf7HQ755FmzJb
         /eAfs6KF/4KJ01XTUA7NGVCG9QqBduzrzmc8D3ypzcbJ95LfcjR56cTYDX+/lj12y6VG
         LgllwFc3sNanTbK2wk02a4aJvDCM87QNc77kU8p9RKJhBiwt3Sc/6pAsKvMH9AlIDwD5
         8V+DT+veWyxAGyTEbyw79UB21H8QXSZPso0yQe+yBAL4GaHJwGemXTzsOhP0HgMdATby
         fVVl8bdMmwilp1ET/kt933Af8lGtEU+jin7XSE9ofGD9Lnkc4fW7/lRVsfKURfX5yXrI
         hCbA==
X-Forwarded-Encrypted: i=1; AFNElJ/wnQLyXbd5rTNtWEThUXEWv3V4cu1bRFtcd2W9+WYfjZCLYxFjZqnX9KewGgJ6KVC0jKtePgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD3lBXBxhEbUl1SPwroN9MJgtwTuCZyNUevGSRtNghotDzH3Kk
	WHoR8qE7omWhxUfZLWO2cNprsx7fdajdh4Ae+DaBgEZdawDUKfwr8KYb
X-Gm-Gg: Acq92OHnL/vlmV3x+TFMEflP/4Bt6A22SFQOJ1ETCjF4vsHN7yWmgiXuflDb+suXC4R
	3ZPnazUHeNyAxxtl8IuJiDbVmSLDgqb9EJf2Ha6mYZglCHSusdCcN70IfGkiEQEBArIu0PSkDUZ
	vC7yPGUf4Pbm4GivO7VoVioTARv3ctfkbEOWPgOmDITEhz3opS4ClJFZ+7cgYBzvtqOxZtJG2Zx
	Ze0WcULcm9lZtme2+86bmUr0SEOigN/TWKG0a1oA9000xFTwdhqc8xSrJQxLkZRBRmp99d+o2N/
	W9R7nrzf1qAz+fv3mapl44JREMpAXgy9oIm1b4mAIbxi99YRBH6xrm6UCtIjOyEQn9Q/en6cyCm
	9dSvoYWDwnKwhC1/mdyBar7wsd5BeWrns2Kos7JIEJ2OTQmoJT7W+qZoDfjpzToOZ6Q9c3k1UfL
	Nw9qEt105DiihbQb7lLH/l/Dt+g7l01EzXFs1R+0IvTENe/3448kHWAkDhhNc2v1i0AxO5o0wrF
	yLukgc=
X-Received: by 2002:a05:600c:4443:b0:490:e190:39b1 with SMTP id 5b1f17b1804b1-490e564075dmr23542205e9.7.1781195241107;
        Thu, 11 Jun 2026 09:27:21 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc4.inf.ethz.ch. [129.132.161.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e52ac9aasm64984155e9.4.2026.06.11.09.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 09:27:20 -0700 (PDT)
From: Zijing Yin <yzjaurora@gmail.com>
To: David Heidelberg <david+nfc@ixit.cz>
Cc: Zijing Yin <yzjaurora@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] nfc: nci: validate packet length when parsing NCI 2.x RF interfaces
Date: Thu, 11 Jun 2026 09:27:16 -0700
Message-ID: <20260611162718.2301552-1-yzjaurora@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nci_core_init_rsp_packet_v2() parses the variable-length list of
supported RF interfaces carried in an NCI 2.x CORE_INIT_RSP without ever
validating the controller-supplied lengths against the size of the
received packet.

Each list entry is a (RF interface, RF extension count, RF extensions[])
tuple. The loop walks the list using the per-entry extension count
(rf_extension_cnt, up to 255) taken straight from the packet, so a
malformed CORE_INIT_RSP can advance the read pointer far past the end of
the skb data buffer. The stored interface count is clamped to
NCI_MAX_SUPPORTED_RF_INTERFACES so the write side is bounded, but the
read side runs off the end of the buffer.

A malformed CORE_INIT_RSP from the controller, also reachable from user
space through the virtual NCI device (CONFIG_NFC_VIRTUAL_NCI) once the
device has entered NCI 2.x mode, therefore makes the parser read past the
end of the response buffer while walking the interface list, copying the
out-of-bounds bytes into ndev->supported_rf_interfaces[].

Reject responses shorter than the fixed part of the structure, and make
sure each interface entry and its extension bytes lie within the received
packet before dereferencing them. A truncated or malformed list is
treated as a syntax error, which fails the CORE_INIT request instead of
reading out of bounds.

Fixes: bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
Cc: stable@vger.kernel.org
Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
---
 net/nfc/nci/rsp.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index 9eeb86282..152b5f57e 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -87,7 +87,8 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 				      const struct sk_buff *skb)
 {
 	const struct nci_core_init_rsp_nci_ver2 *rsp = (void *)skb->data;
-	const u8 *supported_rf_interface = rsp->supported_rf_interfaces;
+	const u8 *skb_end = skb->data + skb->len;
+	const u8 *supported_rf_interface;
 	u8 rf_interface_idx = 0;
 	u8 rf_extension_cnt = 0;
 
@@ -96,6 +97,11 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 	if (rsp->status != NCI_STATUS_OK)
 		return rsp->status;
 
+	if (skb->len < sizeof(*rsp))
+		return NCI_STATUS_SYNTAX_ERROR;
+
+	supported_rf_interface = rsp->supported_rf_interfaces;
+
 	ndev->nfcc_features = __le32_to_cpu(rsp->nfcc_features);
 	ndev->num_supported_rf_interfaces = rsp->num_supported_rf_interfaces;
 
@@ -104,10 +110,20 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 		    NCI_MAX_SUPPORTED_RF_INTERFACES);
 
 	while (rf_interface_idx < ndev->num_supported_rf_interfaces) {
+		/* The supported RF interfaces are a variable-length list of
+		 * (interface, extension count, extensions[]) tuples supplied by
+		 * the NFCC; bail out if its lengths would take us past the end
+		 * of the received packet.
+		 */
+		if (skb_end - supported_rf_interface < 2)
+			return NCI_STATUS_SYNTAX_ERROR;
+
 		ndev->supported_rf_interfaces[rf_interface_idx++] = *supported_rf_interface++;
 
 		/* skip rf extension parameters */
 		rf_extension_cnt = *supported_rf_interface++;
+		if (skb_end - supported_rf_interface < rf_extension_cnt)
+			return NCI_STATUS_SYNTAX_ERROR;
 		supported_rf_interface += rf_extension_cnt;
 	}
 
-- 
2.43.0

