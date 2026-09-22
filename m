Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70F03FD12A
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790064494; cv=none; b=ShP8W7iWDa8t42dNi+0zduIdYO+csv9L/9PaVAc6RwY1gJTgfbhlk7ZJSsB//Qzb8HKYVsD6qQkXzTNbbwWQXfovb4vv5HzNwlaIgp+9/vaUzKmXChfrCK/B4+Oi6rvcSdkqCzvIVDMO5GKP7i0FGzoxohV9Pw3pi3l6+zTJ+cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790064494; c=relaxed/simple;
	bh=PB10iJXwaQiQpgWMplLuUrRqupycNcSJ1CXoBYEhb+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5CJlmGbBhE6tsggSx7P/VbPtArc1+UPIT+/158vBIrcV+qz6Z6zSje0lllxIMS2K7zMY87bZ6Eb2CZG98msiJYta2P+ZqvnPbPcbpLvlOqfGZDmhklWhpHNP3kkSme3xJFhT9YN4xWMDIbuFli5QBQIOfeo0QPU6raCuCGHmzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hW7eogJm; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW7eogJm"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d91ede8035so46620055ad.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790064480; x=1790669280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qRPMgMOIc56QBWBupM6kM1mJ5Xh3d/f5V1FOIpaRUQI=;
        b=hW7eogJmi7wBX3TS/82OiMHwtUW0ANzbNAl3SmwRZXM5okmjtgIzaTORE1dKhbwvTv
         yFzG42GKPXoldCbk/lgv2AXNFIfNZrousO0Hvotz6Th5CvhvKsuwzpSW9nPxLnpee4El
         ZLSrIyzEuYg2tKZy6BM+AiUx6cdcUwWIJtkwqxMD4EEIj5O0djeK9lKn5h7flJO/tFWN
         dStcUlPEkC/b8cEbzejgYQjdfbbn28vP0SWc3XJiUYuP5YrqpcB85WbnS9GVPd2QkBxX
         +j8atyVlQXTau5dp+ee9IhodZKL3GWmFGGoF+wdXUumbRJNMSk7paDnRhXdHef55oYaG
         M/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790064480; x=1790669280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qRPMgMOIc56QBWBupM6kM1mJ5Xh3d/f5V1FOIpaRUQI=;
        b=QvpoZ8zb4I5LiWhBA7FEOoy9XvJi0Jud+8+E5a3o0DjJ+O0JbLWh6HFlaXPPjgajLM
         jYyelOt2c9uN6dmxGFslsdbaqPo9H+95mwIZv1aCV3zONWdQLIbIo/8NP7SS8OnlkoJJ
         QWWFEPJIIb3iUagcjmRfz9lzV16vS4Fax0qWq7nHPVRBuofcH8O88uMyf41Bu1BbQNc2
         Is6F3v80rUnVaKXF5K2nJO56HVBbwig0pxX66dE3VEUguA0+DlNUwjn3scw0X8PhAPum
         7nsi68kwIATVvin8obiVzu7rZ09ix/+tiKxuoejr9F8n+QplEC/V4us8nRUjMhD4YkUl
         8cXg==
X-Forwarded-Encrypted: i=1; AKwUvBy/Sew+RsGlOv9H+eR4PfAwVIO9e1Hc1eDJ2Lgau9gucv3bw7dOGuXoqpwfihIXAo0kVkbvvco=@vger.kernel.org
X-Gm-Message-State: AFuF++nOlZEIKygMnwX7oYtMG0omcplKFEEvK0idW8WLMUxYC8AKgEbr
	9Q502+/bTDGzF51lhgvqciIpR7SSr9t131at7jacLVOxCz+fRnJSB5Bo
X-Gm-Gg: AYBFou2MFE6jO1Lq7cPhUwL1fipPmbg9aCqUr6cF2CAmyAc4iB5l1mbYpDlMfkNEU6a
	O4zKE1C+ZmXg0qChgqjHAAxuJpVfMN15/YSl3Tp+1Bn5FlIgnGNAzj2b6jm603WGVEDa9uqFDbQ
	KJPzO8xyJfRBPJtBxf9/K6zCINlBwxfhxGebgl2TdgzkGnGQN9KydaYtmLAKNTCGYZoL86n867W
	d3g3zPhm1nZSvkV0JaP3F0qv44EoRgsozfoLJ2M2bOC6aMRx644Z5bZIzwAbUuvTl3VB9XcSm9v
	8CTLhblw42XRL5h5l7XrLOA71km2Il6+ovAgfakQZXLEVsYIjZMUPLNuzbXo8uUUqfjx8H/pyBN
	isrDmljurdUG9hgU90p1MISymqP8ZtVz9hDD9tubrQ1pilnM6wZh5Xn2Ahq002nwtdKCnpQsNB1
	Wggog3CmZzJkAL9IC4VG1jYlwfKgCAIZXpG26jFDuBpR0RWvyNx5+5+1UshqpwF+nRsbs8yrwov
	ltslGa4wQ8w9Cm55sZRjZJRvFraDhr8FDNxLjE=
X-Received: by 2002:a17:903:19cf:b0:2d9:484:861d with SMTP id d9443c01a7336-2df609ad034mr4138015ad.10.1790064479957;
        Tue, 22 Sep 2026 01:07:59 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:c92a:4bc0:f68c:8fc1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d0581f0sm5584365ad.74.2026.09.22.01.07.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 01:07:59 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH v2] nfc: nci: ignore unexpected CORE_RESET_NTF and CORE_RESET_RSP
Date: Tue, 22 Sep 2026 16:07:50 +0800
Message-ID: <20260922080750.35929-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260921125805.224979-1-horms@kernel.org>
References: <20260921125805.224979-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
added handling of CORE_RESET_NTF in nci_core_reset_ntf_packet(). When
received, it updates ndev->nci_ver, ndev->manufact_id, and
ndev->manufact_specific_info, and calls nci_req_complete(ndev,
NCI_STATUS_OK) to finish the pending reset request.

However, unlike other notification handlers in ntf.c (which validate
ndev->state before completing requests), nci_core_reset_ntf_packet()
does not check whether a core reset request is actually pending.
If an unsolicited or delayed CORE_RESET_NTF arrives (e.g. after a reset
command times out or from a misbehaving NFCC), it unconditionally:
1. Completes whatever request is currently in-flight (such as CORE_INIT,
   RF_DISCOVER, or CONN_CREATE) with NCI_STATUS_OK, leading to kernel
   state desynchronization.
2. Overwrites ndev->nci_ver and manufacturer info. Because
   ndev->nci_ver is used as a selector for subsequent packet formats
   and parsers (e.g., in nci_open_device() and nci_core_init_rsp_packet()),
   unexpectedly modifying it can cause protocol format confusion.

A similar issue exists in nci_core_reset_rsp_packet(): an unexpected or
delayed response packet can prematurely complete an unrelated in-flight
request.

Fix this by ensuring CORE_RESET_NTF and CORE_RESET_RSP are only processed
by the core layer when a reset command is actively awaiting them:
- Set NCI_RESET_PENDING in nci_reset_req() when sending CORE_RESET_CMD.
- In nci_core_reset_rsp_packet(), ignore the response if NCI_RESET_PENDING
  is not set. If set, clear the flag and complete the request on failure
  or for NCI 1.x (checking skb->len >= sizeof(*rsp)).
- In __nci_request(), ensure NCI_RESET_PENDING is cleared upon request
  completion, cancellation, or timeout.
- In nci_core_reset_ntf_packet(), skip power-on notifications (trigger
  0x01, identical in NCI 1.0 and 2.0), then check and clear
  NCI_RESET_PENDING before updating device fields and completing the
  request. The CORE_RESET_CMD trigger value is revision-dependent
  (0x00 in NCI 1.0, 0x02 in NCI 2.0), so both are accepted and gated
  on NCI_RESET_PENDING alone. If unexpected, log a warning and return
  0 so driver-specific handlers (such as fdp firmware patch handling)
  still receive the notification.

Fixes: bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
v2:
 - Do not abort the notification pipeline on unexpected CORE_RESET_NTF (return 0
   instead of -EINVAL), preserving driver-level hooks (e.g. fdp firmware
   patching) per Simon Horman.
 - Skip power-on notifications (trigger 0x01, identical in NCI 1.0 and 2.0)
   while gating both NCI 1.0 (0x00) and NCI 2.0 (0x02) command-triggered resets
   on NCI_RESET_PENDING alone.
 - Check NCI_RESET_PENDING in nci_core_reset_rsp_packet() to avoid completing
   unrelated requests on unexpected responses.
 - Explicitly check skb->len >= sizeof(*rsp) in nci_core_reset_rsp_packet()
   for NCI 1.x handling.

 include/net/nfc/nci.h      |  5 +++++
 include/net/nfc/nci_core.h |  1 +
 net/nfc/nci/core.c         |  3 +++
 net/nfc/nci/ntf.c          | 17 ++++++++++++++++-
 net/nfc/nci/rsp.c          | 24 ++++++++++++++++++------
 5 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/include/net/nfc/nci.h b/include/net/nfc/nci.h
index 09efcaed7c3f..2ac45adba088 100644
--- a/include/net/nfc/nci.h
+++ b/include/net/nfc/nci.h
@@ -140,6 +140,11 @@
 #define NCI_RESET_TYPE_KEEP_CONFIG				0x00
 #define NCI_RESET_TYPE_RESET_CONFIG				0x01
 
+/* NCI Reset Triggers */
+#define NCI_RESET_TRIGGER_ERROR					0x00
+#define NCI_RESET_TRIGGER_POWER_ON				0x01
+#define NCI_RESET_TRIGGER_RESET_CMD				0x02
+
 /* NCI Static RF connection ID */
 #define NCI_STATIC_RF_CONN_ID					0x00
 
diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
index 664d5058e66e..504ea91ddf27 100644
--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -31,6 +31,7 @@ enum nci_flag {
 	NCI_DATA_EXCHANGE,
 	NCI_DATA_EXCHANGE_TO,
 	NCI_UNREG,
+	NCI_RESET_PENDING,
 };
 
 /* NCI device states */
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 5f46c4b5720f..5a90591cd9af 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -134,6 +134,7 @@ static int __nci_request(struct nci_dev *ndev,
 	}
 
 	ndev->req_status = ndev->req_result = 0;
+	clear_bit(NCI_RESET_PENDING, &ndev->flags);
 
 	return rc;
 }
@@ -163,6 +164,8 @@ static void nci_reset_req(struct nci_dev *ndev, const void *opt)
 {
 	struct nci_core_reset_cmd cmd;
 
+	set_bit(NCI_RESET_PENDING, &ndev->flags);
+
 	cmd.reset_type = NCI_RESET_TYPE_RESET_CONFIG;
 	nci_send_cmd(ndev, NCI_OP_CORE_RESET_CMD, 1, &cmd);
 }
diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index f5c9a8ab7ec1..57f99bf46a22 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -36,7 +36,22 @@ static int nci_core_reset_ntf_packet(struct nci_dev *ndev,
 	if (skb->len < sizeof(struct nci_core_reset_ntf))
 		return -EINVAL;
 
-	ntf = (struct nci_core_reset_ntf *)skb->data;
+	ntf = (const struct nci_core_reset_ntf *)skb->data;
+
+	/*
+	 * A power-on notification must not update core protocol state nor
+	 * complete a pending request.  The CORE_RESET_CMD trigger value is
+	 * revision-dependent (0x00 in NCI 1.0, 0x02 in NCI 2.0), so both
+	 * are let through to the reset-pending gate below instead.
+	 * Return 0 so driver-specific notification hooks can still run.
+	 */
+	if (ntf->reset_trigger == NCI_RESET_TRIGGER_POWER_ON)
+		return 0;
+
+	if (!test_and_clear_bit(NCI_RESET_PENDING, &ndev->flags)) {
+		pr_warn_ratelimited("unexpected CORE_RESET_NTF\n");
+		return 0;
+	}
 
 	ndev->nci_ver = ntf->nci_ver;
 	pr_debug("nci_ver 0x%x, config_status 0x%x\n",
diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index b0ab4f5acbce..3a2491497e4b 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -32,14 +32,26 @@ static void nci_core_reset_rsp_packet(struct nci_dev *ndev,
 
 	pr_debug("status 0x%x\n", rsp->status);
 
+	/*
+	 * If no reset request is pending, ignore unexpected responses to avoid
+	 * prematurely completing an unrelated request.
+	 */
+	if (!test_bit(NCI_RESET_PENDING, &ndev->flags))
+		return;
+
+	if (rsp->status != NCI_STATUS_OK) {
+		clear_bit(NCI_RESET_PENDING, &ndev->flags);
+		nci_req_complete(ndev, rsp->status);
+		return;
+	}
+
 	/* Handle NCI 1.x ver */
-	if (skb->len != 1) {
-		if (rsp->status == NCI_STATUS_OK) {
-			ndev->nci_ver = rsp->nci_ver;
-			pr_debug("nci_ver 0x%x, config_status 0x%x\n",
-				 rsp->nci_ver, rsp->config_status);
-		}
+	if (skb->len >= sizeof(*rsp)) {
+		ndev->nci_ver = rsp->nci_ver;
+		pr_debug("nci_ver 0x%x, config_status 0x%x\n",
+			 rsp->nci_ver, rsp->config_status);
 
+		clear_bit(NCI_RESET_PENDING, &ndev->flags);
 		nci_req_complete(ndev, rsp->status);
 	}
 }
-- 
2.53.0

