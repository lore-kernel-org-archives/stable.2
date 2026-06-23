Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683063C2BAF
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782253471; cv=none; b=ed2BTpdYWRcXo7i3grv4SYK1e3DLE1Fsb00FdCF/Uo+cGy7fHYwGHbin+FCa+ImzonaASndnLmFRTlFq8v5UX/K0Q+u1V+aeWZwTeWTh/z5H3OPK1GwRt1y5lwtGOUTkh3bRc+m2+8DUs0W/6N67tVa/TWUAqzwJRDtltqEZT30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782253471; c=relaxed/simple;
	bh=1YhKA2IR2noap56s+wFYYMoqh9rUzZYHvDIQPXPdHYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QnRvxEf58etdQMqPHTBUSBpNur7hR7eRb95YaFvooCWo3F17E2xg2EVV0mRWgZ/LuzVvdZUmboxfF63wtWm2QOVFqQFvq5ddZlzC4wc6AD2iU31GbLGgBx2G9gTrK/TohT3e2JiraP5yi/SKBuwj2zew2MQXsWz1cQVfJGJb+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=ay/YrN4Q; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bynar.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b="ay/YrN4Q"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-691c5776f35so575555a12.3
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 15:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782253468; x=1782858268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9EL/E+9kbwK4PLUI4WhiNWopf73sV8df3AbcMljHGbw=;
        b=ay/YrN4QBCYx5PotKUvMHbOwy57zt0NzJ11m4iZxT/zdFOr4jVMOd9xAC0Y+NJunlQ
         urf7uTe1bQEoBmtW1tgtXh+ejovbnltBe3gqKdwKh5t+/3vOZ8tyFjVq4maN10oeRmpl
         oxtpHJy1zMHcqnMu+FAJlJhf5BpQHEcNpTvwOGA/5wN0rOi20EjyMQmTHMQZJN4YJVR1
         BfJQS0fsDW2O+5/Dgjnps3k6JUlfi7r9atKZtoRYOLtwqDQRLDtG1FeR4UCumXlmXvgo
         t4dbwrNT7UyLNefLQxMhrSITyOG7DB9Cm9G2VBPA2NFFROcvp7zMWyzQt+iG8LhU/DDY
         iUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782253468; x=1782858268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EL/E+9kbwK4PLUI4WhiNWopf73sV8df3AbcMljHGbw=;
        b=DcZ3HtAa+opMEH7LKR8RDIZ2Xj2jxdU1oYvfqhOs7a/RbYZj8Hthf2pIMQJQG7032b
         bsX75YkoR7XnvNbmaNgwQGOpqhtANQ4n421vgNUFK/UoolmuIesk4K9Q+UAm3C2qgAfp
         fndqDu//O07HJ2mmysLlDJSNeHHdXTIj/qP4ypd8nfHngdAvVyj2RL3QlSmyIPF1khgt
         Um5Fn+IatJyXLFm8mo+3pX0UvT4cRG1Fm4RyJnQno482uaATVjkNsLvImB3tIivh7hHV
         cFn+3wEvy+l7Q79E2QO5vWyIKrO3XDqsaBTBamfKgFc9gKuUqGlTQpLxloIGQkpl19Up
         BIBw==
X-Forwarded-Encrypted: i=1; AFNElJ+PN0w4UG326ZKgT07O7iAb6V9+0uM8jPZZgolLV/lJLOyS+Ny8xFfymv5Vogh+KXAL9pK0MtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzd4xdSUiBU1Idv6UogXg+IsFmNiYtT1rVN3VQDNbbcVykxu1C
	ASF/ftbXp/+rAabVCwatA/DBNMFRoEq3I93ocseVaUngr5vrtDXDz5F0kGRnv0lovJqi
X-Gm-Gg: AfdE7cnPkf2MQbKbJFCSBUjgPSuYKs5EwoNz67weJxwKK4g8fjTAL0K8MJAcXsPiLUu
	2pyl7SZov3k6n7H270gpsdVx4vMfMe5/ctWWbO5MnuDXyDjYCtH4cOqKyANPpZHduMMXyeFIazG
	GpX1zQ6CkaidE/vqO6oyRrp7sjdjQzVeztTFtWflvUCZ5ilPqEfiW81iqIaSBqLGKOn0wDVAF8G
	qCEEumGHVxQPxplooySshVIYcQX7pshuupviYOXPwBpvFIniojdcIhk8F706RKk8HYkLHHhRrwG
	gRcaHQuGf//KYHdKYWiFLkTu8DcdsSF1sPpQ45OOMq/Wkh0G7R5M9n1WHjm6BfYJmoH3pqX32bm
	T7B7LXWbKAV5sCd44VqDA/aFR7gXOpdcOkY4e2a2Yb8B7A1t6mIVbr4LJpgNYW3FrDqFQyjpZxK
	QW
X-Received: by 2002:a17:907:96a8:b0:bec:687f:6603 with SMTP id a640c23a62f3a-c119e45a11fmr20199066b.28.1782253467082;
        Tue, 23 Jun 2026 15:24:27 -0700 (PDT)
Received: from localhost ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c610e5280sm579916966b.53.2026.06.23.15.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 15:24:26 -0700 (PDT)
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
Subject: [PATCH net] nfc: nci: fix uninit-value in nci_core_init_rsp_packet()
Date: Wed, 24 Jun 2026 00:24:02 +0200
Message-ID: <20260623222402.175798-1-sam@bynar.io>
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

Bound both parsers to skb->len before dereferencing the variable-length
parts, rejecting truncated responses with NCI_STATUS_SYNTAX_ERROR.

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Fixes: bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
Cc: stable@vger.kernel.org
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
---
 net/nfc/nci/rsp.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index 9eeb862825c5..cdcd23c8ca95 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -50,6 +50,9 @@ static u8 nci_core_init_rsp_packet_v1(struct nci_dev *ndev,
 	const struct nci_core_init_rsp_1 *rsp_1 = (void *)skb->data;
 	const struct nci_core_init_rsp_2 *rsp_2;
 
+	if (skb->len < sizeof(*rsp_1))
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	pr_debug("status 0x%x\n", rsp_1->status);
 
 	if (rsp_1->status != NCI_STATUS_OK)
@@ -58,6 +61,15 @@ static u8 nci_core_init_rsp_packet_v1(struct nci_dev *ndev,
 	ndev->nfcc_features = __le32_to_cpu(rsp_1->nfcc_features);
 	ndev->num_supported_rf_interfaces = rsp_1->num_supported_rf_interfaces;
 
+	/*
+	 * supported_rf_interfaces[] and the trailing nci_core_init_rsp_2 are
+	 * addressed using the on-wire (unclamped) interface count, so the
+	 * response must be long enough for both before they are dereferenced.
+	 */
+	if (skb->len < sizeof(*rsp_1) +
+	    rsp_1->num_supported_rf_interfaces + sizeof(*rsp_2))
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	ndev->num_supported_rf_interfaces =
 		min((int)ndev->num_supported_rf_interfaces,
 		    NCI_MAX_SUPPORTED_RF_INTERFACES);
@@ -88,9 +100,13 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
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
@@ -104,10 +120,16 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
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

