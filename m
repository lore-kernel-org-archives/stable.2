Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F882D5432
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 02:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697073; cv=none; b=cXp34JvE2IViXDhRhchROA1I89RGvdWbz5Tbsw5aAiIrQAXwK5ryakpdPcn0qB8b/7HGfPNmZds8R61N4ORHbxMYXwdrMUiwCpoQnJVZlhKgVJUHl908uOm/4YQ3/i9Hw5UlDrAaT7T26U2/lugHR2chiZGKn62+B1nY6dza86A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697073; c=relaxed/simple;
	bh=UkhzmiDRxOJm/KkY5kZc/kXeWdTV119sUKWsG2ZBJ0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOeFpEJZw5C9Al7kSZBSEKGegaUoeU4/jWIS5tvxXSSEG2HIJe3ft0IRhUUi2bAyzBDnbFu/mbS1WTTK1mj6sDCwNwCsNoYUVYvYPgPYfm4LmD6DirfDWu0wsdUkU9BpR7zp3wlyMIJldCSnkYqLwCYAaaID4P6TF86WStZ6Q8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jELWBBhT; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jELWBBhT"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-868a9c48f9eso339969b3a.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 19:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789697065; x=1790301865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k+ZmYKPJxwk4ppbLxhtM923pOwtZYQbBQl5io1pIn2g=;
        b=jELWBBhTNaYxjuEQzafD4ICzvqECtnk5UIDQH4e1cHpg3oae9s1iqZ8TW3gIlQeRkH
         JPLeYQQAzw6p5K3xcxHKhGxI1JBzfTD5mkOCI+GwtmoQihOTk3EXvqgcsRo0IZ8cEf/K
         KbeZ47H/kfeGbIDYE1AKVB2X/Q69zqb9+zCX2a02ISI40CVB+Cv+rKTPWCi5EVXimJLX
         +kNn1HGluS83//RngeWft3BO0fbPU/WIAanciH7s5cAVGMypvmc8lJashoE3Xxulttqq
         7NLhop9JRcVxHrI0yqEOjRXgqIrBFLLn0efVA8Dlxrz3OqeY+h6zHkAp+8H5K0+O/E4F
         RRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789697065; x=1790301865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k+ZmYKPJxwk4ppbLxhtM923pOwtZYQbBQl5io1pIn2g=;
        b=wXoUoOdIsYRhh+MSn5A3Xn51EuPPoY6w7C3vNv+/RThVBmZVVhphvyNMVdeCiwKcOE
         uDXpYae2utBD3EZF3aHabUin4uDdoQI4NdbxwZ+8Zse2fIymc+yruOhx6QiBowls5GID
         7wh2dSO7esvpQOU9SKrX88yx5t4BX7dnywwG+7PikMxC3Q/b5LnnacyjW6C95+JjFBy7
         fyyWUWIbkfm86YbXkwDE04i+QrQBj/00i8oRKpN5CHufle+J4nGXszYgkWmNfmDRcucM
         2078ePcRkdtbTcYEgRIT8pG3zwzvbwVQsWmtLcvNUl79fRzO9A0jcU1IpFbXvN8e1Dzw
         CVCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxUOp93IPdn2glIXEmjquV1eQwxV+w7ao0WhOQDEypb4fTuj0UXyKf/gtTaDin/Z2t6Qen+xo8=@vger.kernel.org
X-Gm-Message-State: AFuF++mRV7wKNZh8EsgqMg1a0IaTn3+qUsdwJQjL0nTN3M7F1aPIVdVT
	YgOPtPvfF46o8m/Bp1CsMOjL9H/fWY9Fqa3bmAAXaaB0+mOqzMeGokAh7urmvt+uXQ6ocQ==
X-Gm-Gg: AYBFou35K7cbZBpxOpvtyRz/HrOmvsNq1SgPsuZa8jIWjzZ+Wmdbl7vDgv4y8uP5zgE
	mwVJdVpm6pKzrt854fM8hAFk6Q4rwPMHiGJBF3MTNqlfONMQEdciWHuMMPNXdtpLjkZt/jNi6xm
	xIaNhjJgZUWB+Qq1eqfI53VB7aWS8MhGSeD1vObADe8qIYw4+YQyunZVZXtM2iKmrvtliF8w0jF
	T5ybSJ3A9bHrHMMAiwMI/OBLSTdSt9713mLmHDGNn85iEnRxATjM8yc/GKenJJuHuEFpjrR/kV5
	ANX/Kbql4MXgsQK7y9b0YnHw1m3b24ai7dLm95ir/50jLAILUoXkszUsHWqOtoKYA8D+GwnIUEB
	BWGQ5p+Z2dchwMm9yFkB0pxech+0r+rrc5veiQyEFOcb7oIOkig1j2OH129Ry+c/jb5cMxcs5KA
	QONBQFMaxc8iAjZ4C6uisFe1mpP9WODGnu/W3HFxJ8hxJldrp1T6KcDnOSDBH4Y0sWvG/dZyNoc
	vLcGC3dCyUZtmI9lOOffCfc7oE71Q+Nx6ljm/4=
X-Received: by 2002:a05:6a20:c989:b0:3dd:85aa:4532 with SMTP id adf61e73a8af0-3dd8c5eaf0emr1932234637.36.1789697064675;
        Thu, 17 Sep 2026 19:04:24 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:79ca:7a54:4576:24ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c2890b915sm136049eec.30.2026.09.17.19.04.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 19:04:24 -0700 (PDT)
From: zjamg <ndaugoing@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: Christophe Ricard <christophe.ricard@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] nfc: nci: do not process unexpected or invalid CORE_CONN_CREATE_RSP
Date: Fri, 18 Sep 2026 10:04:12 +0800
Message-ID: <20260918020412.82878-2-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260918020412.82878-1-ndaugoing@gmail.com>
References: <20260918020412.82878-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuchao Zhang <ndaugoing@gmail.com>

When an NCI_OP_CORE_CONN_CREATE_RSP packet is received,
nci_core_conn_create_rsp_packet() parses it and creates a logical
connection entry in ndev->conn_info_list.

However, nci_core_conn_create_rsp_packet() suffers from several issues:
1. It does not verify that a connection creation command is currently
   pending. An unsolicited or delayed CORE_CONN_CREATE_RSP packet
   unconditionally creates a rogue connection and calls
   nci_req_complete(), prematurely completing unrelated in-flight
   requests.
2. It lacks bounds checking against sizeof(struct nci_core_conn_create_rsp)
   for the packet payload, leading to potential out-of-bounds reads.
3. It does not validate rsp->conn_id. Dynamic logical connections
   assigned by the NFCC must not use NCI_STATIC_RF_CONN_ID (0x00) or
   collide with any existing connection ID.
4. It inserts the new connection at the head of ndev->conn_info_list
   via list_add(). Because connection lookup (e.g. in nci_tx_work() and
   nci_data_exchange_complete()) uses first-match semantics, prepending
   allows a newly created connection with a duplicate ID to shadow the
   static RF connection or earlier connections.
   Furthermore, ndev->hci_dev->conn_info is mistakenly updated even
   when the destination type is not NCI_DESTINATION_NFCEE because
   cur_params.id and nfcee_id both default to 0.

Fix this by:
- Adding an NCI_CONN_CREATE_PENDING flag in enum nci_flag to track
  in-flight connection creation commands, and rejecting unsolicited or
  delayed responses.
- Adding packet length verification before reading payload fields.
- Rejecting responses that allocate NCI_STATIC_RF_CONN_ID or duplicate
  existing connection IDs.
- Appending new connections with list_add_tail() instead of list_add().
- Restricting ndev->hci_dev->conn_info assignment to NFCEE destination
  types.

Fixes: 736bb9577407 ("NFC: nci: Support logical connections management")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
 include/net/nfc/nci_core.h |  1 +
 net/nfc/nci/core.c         |  2 ++
 net/nfc/nci/rsp.c          | 37 ++++++++++++++++++++++++++++++-------
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
index 664d5058e66e..a4652ffc173d 100644
--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -31,6 +31,7 @@ enum nci_flag {
 	NCI_DATA_EXCHANGE,
 	NCI_DATA_EXCHANGE_TO,
 	NCI_UNREG,
+	NCI_CONN_CREATE_PENDING,
 };
 
 /* NCI device states */
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 5f46c4b5720f..b5fa17f0524e 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -134,6 +134,7 @@ static int __nci_request(struct nci_dev *ndev,
 	}
 
 	ndev->req_status = ndev->req_result = 0;
+	clear_bit(NCI_CONN_CREATE_PENDING, &ndev->flags);
 
 	return rc;
 }
@@ -709,6 +710,7 @@ static void nci_core_conn_create_req(struct nci_dev *ndev, const void *opt)
 {
 	const struct core_conn_create_data *data = opt;
 
+	set_bit(NCI_CONN_CREATE_PENDING, &ndev->flags);
 	nci_send_cmd(ndev, NCI_OP_CORE_CONN_CREATE_CMD, data->length, data->cmd);
 }
 
diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index b0ab4f5acbce..a56a7392ab5e 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -305,15 +305,37 @@ static void nci_nfcee_mode_set_rsp_packet(struct nci_dev *ndev,
 static void nci_core_conn_create_rsp_packet(struct nci_dev *ndev,
 					    const struct sk_buff *skb)
 {
-	__u8 status = skb->data[0];
 	struct nci_conn_info *conn_info = NULL;
 	const struct nci_core_conn_create_rsp *rsp;
+	__u8 status;
+
+	if (skb->len < 1)
+		return;
 
+	status = skb->data[0];
 	pr_debug("status 0x%x\n", status);
 
+	if (!test_and_clear_bit(NCI_CONN_CREATE_PENDING, &ndev->flags)) {
+		pr_warn_ratelimited("unexpected CORE_CONN_CREATE_RSP\n");
+		return;
+	}
+
 	if (status == NCI_STATUS_OK) {
+		if (skb->len < sizeof(*rsp)) {
+			status = NCI_STATUS_SYNTAX_ERROR;
+			goto exit;
+		}
+
 		rsp = (struct nci_core_conn_create_rsp *)skb->data;
 
+		if (rsp->conn_id == NCI_STATIC_RF_CONN_ID ||
+		    nci_get_conn_info_by_conn_id(ndev, rsp->conn_id)) {
+			pr_warn_ratelimited("invalid or duplicate conn_id 0x%x\n",
+					    rsp->conn_id);
+			status = NCI_STATUS_REJECTED;
+			goto exit;
+		}
+
 		conn_info = devm_kzalloc(&ndev->nfc_dev->dev,
 					 sizeof(*conn_info), GFP_KERNEL);
 		if (!conn_info) {
@@ -339,21 +361,22 @@ static void nci_core_conn_create_rsp_packet(struct nci_dev *ndev,
 		 */
 
 		INIT_LIST_HEAD(&conn_info->list);
-		list_add(&conn_info->list, &ndev->conn_info_list);
+		list_add_tail(&conn_info->list, &ndev->conn_info_list);
 
-		if (ndev->cur_params.id == ndev->hci_dev->nfcee_id)
+		if (conn_info->dest_type == NCI_DESTINATION_NFCEE &&
+		    ndev->cur_params.id == ndev->hci_dev->nfcee_id)
 			ndev->hci_dev->conn_info = conn_info;
 
-		conn_info->conn_id = rsp->conn_id;
 		conn_info->max_pkt_payload_len = rsp->max_ctrl_pkt_payload_len;
 		atomic_set(&conn_info->credits_cnt, rsp->credits_cnt);
 	}
 
+	nci_req_complete(ndev, status);
+	return;
+
 free_conn_info:
-	if (status == NCI_STATUS_REJECTED)
-		devm_kfree(&ndev->nfc_dev->dev, conn_info);
+	devm_kfree(&ndev->nfc_dev->dev, conn_info);
 exit:
-
 	nci_req_complete(ndev, status);
 }
 
-- 
2.53.0

