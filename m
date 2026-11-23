Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415605;
	b=tfRHqVRf3OdGYElwtsF9hXecfL4ASJHnntFZdlPsnQnEsLcUPuRMc+NrlNLYj25CnVQ4
	 Yz81A151S2LFq8sN0zQjKjw8INaNx+YZcFGhqGJEpPmW3WTBMrcxAsf0KYbGzkv0ePvbq
	 v5/beJPXdT/Fbyj3jO2ksCz1TbQ1cnMt7+vQZ4i6YWSC8gDjIWU+5F9fIf0De0uGhnE0P
	 XsU2OgtMscvoZIMPmoGtN9uZ5tx5jVEozMgJVCPWVsLOjLftJpZO7uPEtuuhgjYVo0eFZ
	 WrwV5n7JNlqG0E2gJ1WuoudC3sWypZS78RgbKV8j2x9V61RxKQ7eV7/gDOn9sNStHYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0YjauvCbMtcgi1NJw9RJvNx0fzakdAt5sZ+cRre4t5I=;
	b=moU9KppLyA5D0Pgnpv6Ct9yGp0iA3Pp4M70Raz7GYh+7LYyHty7U1VAhwCK7LmOU2ekj
	 ygclyKdLwq3FrhFTXWzAsKzgnUkeKQgRkus887vSbqRYgvLl/EDv9y5BZMJIYDdjKa5Np
	 N8aGbQIzppef3Ie2JlNZoLczWj6aO3SOWzWQW2UKpedm4oAlLiXAanlDpr3pY8yGWKyeG
	 U0/I+q69zBPL+ztKvCCd5mlrNSeZtEd4mRis2P80qHrKi+uAw29GGFfyR0g7lCXoD/rBC
	 4RSTWn53Oe9Yv0SVGhDhDfzOjcRgndkXSmbXlJ5BUCB4Sl1sXbBsmO6LoHQLm/eXKyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AqSLG7RM;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553F606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 06:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D553F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AqSLG7RM
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso6460327eec.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 22:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795415603; x=1796020403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0YjauvCbMtcgi1NJw9RJvNx0fzakdAt5sZ+cRre4t5I=;
        b=AqSLG7RMmlKBqQTR8H+swg3MDCqmm4Eyr/Q89INsz4rheHor78+P/Bm46f/qtMmtsj
         YPY9BO9buqPEbkBz8W69Zm/NbAntrNIaAuM7uaaICTxeWKjMskUclXLcRiz4IRQocCJg
         85+bnweDrm3NsRqFV0GK+/wlg84peKTqHATFI5cAySmGEqNUfolOITgW04vLccBIsbUx
         PTHuM/L7YrZowew8WqPzCe1Y0WgU+YWE+EsyK4hH0ETWHmyjonkjT+SGyc4CUkf5M0G2
         Agp46kkVDaUrQuior0bbzxZ8ES55k7mlwjpM0DcLJ85oi4e/YDSHTQtzYi9G8EpX+u6v
         /6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795415603; x=1796020403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0YjauvCbMtcgi1NJw9RJvNx0fzakdAt5sZ+cRre4t5I=;
        b=xQ6bHAXPUxAYyebVkMZ8VLZv/2iVyJ3QWR2hL1DpLdgfZPHNr8y5jyfZXqeWc74MiY
         CH89TlhhprxeWOALvYH51n1ux2YLZi2+cTa4Vcn1g0x2WFxcHvtvApr7uTQtVdERAHdm
         Xz30SXXUnP5b+oTJbI+KEJBSpu8DKKn+TD0stNYThwfjcFHA6buQ45yozTKzSuTyyz44
         s9t+LK/pgpQuR2ZBd3zeMPdAQ9RRasaX8T19LWFqWmEAg6gSzSx1qke2tFI0n0ZlEodk
         gmtQwuEYcOz+RJbywuayAJO3dIWITK8VHIQU3gGC2f0otrKDwGJjVN7k5CkBrsPhWGtc
         FQdA==
X-Forwarded-Encrypted: i=1; AL+hErHsjipFsj/361egmk/jbK0Jzq1fyPpcbbX/diz56P0zpoagKnPuuPzekdgwqcH+baGtKv1byZU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7OFduuq5tI1xcmo1aNw6TEnxWs3p9mqdMka33daUv/V80jGHr
	nCkYUPBtIYB10ecb3em+Sx7KR9f1yqttQFq4hflik5U8Mgg3tLY9sBZ2
X-Gm-Gg: AZFdTZe+SaffJUn39ThrpligdCYrpGqOM2VmzhisJ4NKN6qA3pN7XqKgUYJqQ9zJg8T
	IdcR9uqpxfpDOPZhrNcibtCLGMlE8KCW5up3NREi1SvGXF4j1lYB11W0mbmpwo+jxiFVnoI4JEc
	00sUCSybPUvtK5Yc4Jj/y0yCvFiqlfRi9hEX5/IySLar+9JCfEdkkL6IkiawZtUnrKB17AT07ZT
	ExKxJ3yd7WZ+82cjA57/p6rhF+XnW7WkoLz9MRMcZjoLYduQPE5jvlW2JZq50VZyVITlo63Z3Qu
	ysmIFs8Ge+RvbU2YHONGdyJvQhAQu/ex88HQyvdJIoc7eJsUIeIN37+O4OyepkCTUAuooYDHx54
	KM5Qrp0cJBUH+vrOideQgYLnZftPQtZvKeCNzq0dL++dFmeO6XdT/EbuA8RdzltBG/4mHwVtGqy
	kyW0PMscablFVg7w/35xrElQOjOQ8YNrHqHUHf6FrPW1rGDoRgR4zfMbJy6mNHS2tjEPOBOSNaS
	xXrP6TpJ7tiOvsz1xLt9FWtZm9JQM9NIrx1cvqUv81xXAk9LDCrx0v6H3dANcAEADX92iFH6OLe
	TAfx1dhEeIeNzDx5h1RzdLZwbd1CDGJdHy3cR7b9PT3Xqi+vyquL3n5rvak9BlPzwcOaEDZhFRN
	q/bGriMNjdN0uFUfa+d9EhxlUzsOVLh6WjZzN+xfH3FlKV+AfQHaYwnJN59HdHbJ8HdrtnmTwnU
	8MqueZ2jWE9VpDK/NXTACZ/ggFvJqnfqLqKcHUhEBYWKI=
X-Received: by 2002:a05:7300:bf27:b0:36d:3c0f:cc6f with SMTP id 5a478bee46e88-3856c9a7dd1mr13169707eec.3.1795415602807;
        Sun, 22 Nov 2026 22:33:22 -0800 (PST)
Received: from LAPTOP-3B99V33A (ec2-47-129-70-252.ap-southeast-1.compute.amazonaws.com. [47.129.70.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385d2b93dd9sm35452817eec.24.2026.11.22.22.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:33:22 -0800 (PST)
From: "Bin Luo (University of Electronic Science and Technology of China)" <luob87709@gmail.com>
To: oe-linux-nfc@lists.linux.dev
Cc: johan@kernel.org,
	david@ixit.cz,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	"Bin Luo (University of Electronic Science and Technology of China)" <luob87709@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] net/nfc: fix skb ownership on data exchange errors
Date: Mon, 23 Nov 2026 14:33:09 +0800
Message-ID: <20261123063310.1267-2-luob87709@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20261123063310.1267-1-luob87709@gmail.com>
References: <20261123063310.1267-1-luob87709@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NFC data exchange callbacks may receive a non-NULL response skb together
with an error. Several consumers return on error without releasing that
skb because the ownership contract is not documented. Some provider
callbacks free the skb only on success, while forwarding paths leave it
with the upper-layer callback.

Document callback ownership and make affected paths release or consume
the skb. Complete terminal Digital DEP failures through the registered
callback, and drop queued NCI/HCI fragments when an exchange fails.
Transfer PN533 responses to its queue before subsequent error handling.

Fixes: 98ff416f97c5 ("NFC: nci: Add status byte management in case of error.")

Cc: stable@vger.kernel.org
Signed-off-by: Bin Luo (University of Electronic Science and Technology of China) <luob87709@gmail.com>
---
v3:
- Audited the data_exchange_cb_t ownership paths across NFC, HCI, and NCI.
- Added cleanup for outstanding NCI/HCI fragments on failed completion.
- Routed terminal Digital DEP errors through the completion callback.
- Made PN533 response queue ownership explicit.

Validation:
- Both patches applied with git am on a clean tree at 6628e7d4c6b2.
- checkpatch --strict reported only UNKNOWN_COMMIT_ID because the local audit
  checkout is shallow; the Fixes commit itself was verified separately.
- Full baseline and v3 x86_64 builds passed with all modified NFC drivers
  enabled and no build warnings or errors.
- QEMU TCG ran 32 NCI status-error exchanges as euid 65534. Baseline
  SO_ERROR was -240 and kmemleak found 47 objects; v3 SO_ERROR was 16 with
  no unreferenced objects or KASAN report.
- Ten test-only KUnit callback tests passed, including PN533 response
  aggregation with an injected allocation failure. They are not part of
  this patch series. Real NFC hardware was not exercised. Final QEMU runs
  used one vCPU after a two-vCPU KASAN boot hit an early scheduler int3.

 drivers/nfc/microread/microread.c |  3 +--
 drivers/nfc/pn533/pn533.c         |  1 +
 drivers/nfc/pn544/pn544.c         |  3 +--
 drivers/nfc/st21nfca/core.c       |  3 +--
 drivers/nfc/st21nfca/dep.c        | 26 ++++++++++++-------------
 include/net/nfc/nfc.h             |  5 ++++-
 net/nfc/digital_dep.c             | 32 ++++++++++++++-----------------
 net/nfc/hci/core.c                |  5 +++--
 net/nfc/llcp_core.c               |  4 +++-
 net/nfc/nci/core.c                |  1 +
 net/nfc/nci/data.c                |  2 ++
 net/nfc/nci/hci.c                 |  4 ++++
 net/nfc/rawsock.c                 |  5 ++++-
 13 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/drivers/nfc/microread/microread.c b/drivers/nfc/microread/microread.c
index 2bfafa94e..f221ec7b0 100644
--- a/drivers/nfc/microread/microread.c
+++ b/drivers/nfc/microread/microread.c
@@ -383,8 +383,7 @@ static void microread_im_transceive_cb(void *context, struct sk_buff *skb,
 		info->async_cb(info->async_cb_context, skb, err);
 		break;
 	default:
-		if (err == 0)
-			kfree_skb(skb);
+		kfree_skb(skb);
 		break;
 	}
 }
diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index b0133e51d..f7bdc0795 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -2138,6 +2138,7 @@ static int pn533_data_exchange_complete(struct pn533 *dev, void *_arg,
 	}
 
 	skb_queue_tail(&dev->resp_q, resp);
+	resp = NULL;
 
 	if (mi) {
 		dev->cmd_complete_mi_arg = arg;
diff --git a/drivers/nfc/pn544/pn544.c b/drivers/nfc/pn544/pn544.c
index c4fa70e45..82f710798 100644
--- a/drivers/nfc/pn544/pn544.c
+++ b/drivers/nfc/pn544/pn544.c
@@ -581,8 +581,7 @@ static void pn544_hci_data_exchange_cb(void *context, struct sk_buff *skb,
 		info->async_cb(info->async_cb_context, skb, err);
 		break;
 	default:
-		if (err == 0)
-			kfree_skb(skb);
+		kfree_skb(skb);
 		break;
 	}
 }
diff --git a/drivers/nfc/st21nfca/core.c b/drivers/nfc/st21nfca/core.c
index b5c1ca3ac..68327cafb 100644
--- a/drivers/nfc/st21nfca/core.c
+++ b/drivers/nfc/st21nfca/core.c
@@ -743,8 +743,7 @@ static void st21nfca_hci_data_exchange_cb(void *context, struct sk_buff *skb,
 		info->async_cb(info->async_cb_context, skb, err);
 		break;
 	default:
-		if (err == 0)
-			kfree_skb(skb);
+		kfree_skb(skb);
 		break;
 	}
 }
diff --git a/drivers/nfc/st21nfca/dep.c b/drivers/nfc/st21nfca/dep.c
index a5fab4fd5..c907b6eec 100644
--- a/drivers/nfc/st21nfca/dep.c
+++ b/drivers/nfc/st21nfca/dep.c
@@ -449,11 +449,10 @@ static void st21nfca_im_recv_atr_res_cb(void *context, struct sk_buff *skb,
 	struct st21nfca_atr_res *atr_res;
 	int r;
 
-	if (err != 0)
-		return;
-
 	if (!skb)
 		return;
+	if (err)
+		goto out;
 
 	switch (info->async_cb_type) {
 	case ST21NFCA_CB_TYPE_READER_F:
@@ -463,7 +462,7 @@ static void st21nfca_im_recv_atr_res_cb(void *context, struct sk_buff *skb,
 				atr_res->gbi,
 				skb->len - sizeof(struct st21nfca_atr_res));
 		if (r < 0)
-			return;
+			goto out;
 
 		if (atr_res->to >= 0x0e)
 			info->dep_info.to = 0x0e;
@@ -475,7 +474,7 @@ static void st21nfca_im_recv_atr_res_cb(void *context, struct sk_buff *skb,
 		r = nfc_dep_link_is_up(info->hdev->ndev, info->dep_info.idx,
 					NFC_COMM_PASSIVE, NFC_RF_INITIATOR);
 		if (r < 0)
-			return;
+			goto out;
 
 		info->dep_info.curr_nfc_dep_pni = 0;
 		if (ST21NFCA_PP2LRI(atr_res->ppi) != info->dep_info.lri)
@@ -484,9 +483,11 @@ static void st21nfca_im_recv_atr_res_cb(void *context, struct sk_buff *skb,
 						ST21NFCA_PP2LRI(atr_res->ppi));
 		break;
 	default:
-		kfree_skb(skb);
 		break;
 	}
+
+out:
+	kfree_skb(skb);
 }
 
 int st21nfca_im_send_atr_req(struct nfc_hci_dev *hdev, u8 *gb, size_t gb_len)
@@ -561,11 +562,10 @@ static void st21nfca_im_recv_dep_res_cb(void *context, struct sk_buff *skb,
 
 	int size;
 
-	if (err != 0)
-		return;
-
 	if (!skb)
 		return;
+	if (err)
+		goto exit;
 
 	switch (info->async_cb_type) {
 	case ST21NFCA_CB_TYPE_READER_F:
@@ -596,7 +596,7 @@ static void st21nfca_im_recv_dep_res_cb(void *context, struct sk_buff *skb,
 			size++;
 			skb_pull(skb, size);
 			nfc_tm_data_received(info->hdev->ndev, skb);
-			break;
+			return;
 		case ST21NFCA_NFC_DEP_PFB_SUPERVISOR_PDU:
 			pr_err("Received a SUPERVISOR PDU\n");
 			skb_pull(skb, size);
@@ -606,10 +606,10 @@ static void st21nfca_im_recv_dep_res_cb(void *context, struct sk_buff *skb,
 			*(u8 *)skb_push(skb, 1) = info->dep_info.to | 0x10;
 
 			st21nfca_im_send_pdu(info, skb);
-			break;
+			return;
+		default:
+			goto exit;
 		}
-
-		return;
 	default:
 		break;
 	}
diff --git a/include/net/nfc/nfc.h b/include/net/nfc/nfc.h
index bcafab5c5..bdf2ac30a 100644
--- a/include/net/nfc/nfc.h
+++ b/include/net/nfc/nfc.h
@@ -31,12 +31,15 @@ struct nfc_dev;
  * data_exchange_cb_t - Definition of nfc_data_exchange callback
  *
  * @context: nfc_data_exchange cb_context parameter
- * @skb: response data
+ * @skb: response data, owned by the callback if non-NULL
  * @err: If an error has occurred during data exchange, it is the
  *	error number. Zero means no error.
  *
  * When a rx or tx package is lost or corrupted or the target gets out
  * of the operating field, err is -EIO.
+ * If skb is non-NULL, the callback owns it regardless of err and must free
+ * or otherwise consume it. Providers must not access or free it after the
+ * callback returns.
  */
 typedef void (*data_exchange_cb_t)(void *context, struct sk_buff *skb,
 								int err);
diff --git a/net/nfc/digital_dep.c b/net/nfc/digital_dep.c
index 968547c30..cd6eff012 100644
--- a/net/nfc/digital_dep.c
+++ b/net/nfc/digital_dep.c
@@ -703,7 +703,7 @@ static void digital_in_recv_dep_res(struct nfc_digital_dev *ddev, void *arg,
 
 			rc = digital_in_send_nack(ddev, data_exch);
 			if (rc)
-				goto error;
+				goto exit;
 
 			return;
 		} else if ((rc == -ETIMEDOUT) &&
@@ -712,7 +712,7 @@ static void digital_in_recv_dep_res(struct nfc_digital_dev *ddev, void *arg,
 
 			rc = digital_in_send_atn(ddev, data_exch);
 			if (rc)
-				goto error;
+				goto exit;
 
 			return;
 		}
@@ -734,7 +734,7 @@ static void digital_in_recv_dep_res(struct nfc_digital_dev *ddev, void *arg,
 
 			rc = digital_in_send_nack(ddev, data_exch);
 			if (rc)
-				goto error;
+				goto exit;
 
 			kfree_skb(resp);
 
@@ -742,7 +742,7 @@ static void digital_in_recv_dep_res(struct nfc_digital_dev *ddev, void *arg,
 		}
 
 		PROTOCOL_ERR("14.4.1.6");
-		goto error;
+		goto exit;
 	}
 
 	ddev->atn_count = 0;
@@ -759,7 +759,7 @@ static void digital_in_recv_dep_res(struct nfc_digital_dev *ddev, void *arg,
 	if (resp->len < size || dep_res->dir != DIGITAL_NFC_DEP_FRAME_DIR_IN ||
 	    dep_res->cmd != DIGITAL_CMD_DEP_RES) {
 		rc = -EIO;
-		goto error;
+		goto exit;
 	}
 
 	pfb = dep_res->pfb;
@@ -767,7 +767,7 @@ static void digital_in_recv_dep_res(struct nfc_digital_dev *ddev, void *arg,
 	if (DIGITAL_NFC_DEP_DID_BIT_SET(pfb)) {
 		PROTOCOL_ERR("14.8.2.1");
 		rc = -EIO;
-		goto error;
+		goto exit;
 	}
 
 	if (DIGITAL_NFC_DEP_NAD_BIT_SET(pfb)) {
@@ -777,7 +777,7 @@ static void digital_in_recv_dep_res(struct nfc_digital_dev *ddev, void *arg,
 
 	if (size > resp->len) {
 		rc = -EIO;
-		goto error;
+		goto exit;
 	}
 
 	skb_pull(resp, size);
@@ -787,7 +787,7 @@ static void digital_in_recv_dep_res(struct nfc_digital_dev *ddev, void *arg,
 		if (DIGITAL_NFC_DEP_PFB_PNI(pfb) != ddev->curr_nfc_dep_pni) {
 			PROTOCOL_ERR("14.12.3.3");
 			rc = -EIO;
-			goto error;
+			goto exit;
 		}
 
 		ddev->curr_nfc_dep_pni =
@@ -802,7 +802,7 @@ static void digital_in_recv_dep_res(struct nfc_digital_dev *ddev, void *arg,
 		if (IS_ERR(resp)) {
 			rc = PTR_ERR(resp);
 			resp = NULL;
-			goto error;
+			goto exit;
 		}
 
 		/* If resp is NULL then we're still chaining so return and
@@ -847,7 +847,7 @@ static void digital_in_recv_dep_res(struct nfc_digital_dev *ddev, void *arg,
 					     ddev->chaining_skb,
 					     ddev->data_exch);
 		if (rc)
-			goto error;
+			goto exit;
 
 		goto free_resp;
 
@@ -855,7 +855,7 @@ static void digital_in_recv_dep_res(struct nfc_digital_dev *ddev, void *arg,
 		if (!DIGITAL_NFC_DEP_PFB_IS_TIMEOUT(pfb)) { /* ATN */
 			rc = digital_in_send_saved_skb(ddev, data_exch);
 			if (rc)
-				goto error;
+				goto exit;
 
 			goto free_resp;
 		}
@@ -863,19 +863,19 @@ static void digital_in_recv_dep_res(struct nfc_digital_dev *ddev, void *arg,
 		if (ddev->atn_count || ddev->nack_count) {
 			PROTOCOL_ERR("14.12.4.4");
 			rc = -EIO;
-			goto error;
+			goto exit;
 		}
 
 		rtox = DIGITAL_NFC_DEP_RTOX_VALUE(resp->data[0]);
 		if (!rtox || rtox > DIGITAL_NFC_DEP_RTOX_MAX) {
 			PROTOCOL_ERR("14.8.4.1");
 			rc = -EIO;
-			goto error;
+			goto exit;
 		}
 
 		rc = digital_in_send_rtox(ddev, data_exch, rtox);
 		if (rc)
-			goto error;
+			goto exit;
 
 		goto free_resp;
 	}
@@ -883,7 +883,6 @@ static void digital_in_recv_dep_res(struct nfc_digital_dev *ddev, void *arg,
 exit:
 	data_exch->cb(data_exch->cb_context, resp, rc);
 
-error:
 	kfree(data_exch);
 
 	kfree_skb(ddev->chaining_skb);
@@ -892,9 +891,6 @@ static void digital_in_recv_dep_res(struct nfc_digital_dev *ddev, void *arg,
 	kfree_skb(ddev->saved_skb);
 	ddev->saved_skb = NULL;
 
-	if (rc)
-		kfree_skb(resp);
-
 	return;
 
 free_resp:
diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
index ba6f0310f..0557fa3fd 100644
--- a/net/nfc/hci/core.c
+++ b/net/nfc/hci/core.c
@@ -713,8 +713,7 @@ static void hci_transceive_cb(void *context, struct sk_buff *skb, int err)
 		hdev->async_cb(hdev->async_cb_context, skb, err);
 		break;
 	default:
-		if (err == 0)
-			kfree_skb(skb);
+		kfree_skb(skb);
 		break;
 	}
 }
@@ -833,6 +832,7 @@ static int hci_se_io(struct nfc_dev *nfc_dev, u32 se_idx,
 
 static void nfc_hci_failure(struct nfc_hci_dev *hdev, int err)
 {
+	skb_queue_purge(&hdev->rx_hcp_frags);
 	mutex_lock(&hdev->msg_tx_mutex);
 
 	if (hdev->cmd_pending_msg == NULL) {
@@ -862,6 +862,7 @@ static void nfc_hci_recv_from_llc(struct nfc_hci_dev *hdev, struct sk_buff *skb)
 	int msg_len;
 
 	if (!pskb_may_pull(skb, NFC_HCI_HCP_PACKET_HEADER_LEN)) {
+		skb_queue_purge(&hdev->rx_hcp_frags);
 		kfree_skb(skb);
 		return;
 	}
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 74bf81700..0736a0ed3 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1636,8 +1636,10 @@ void nfc_llcp_recv(void *data, struct sk_buff *skb, int err)
 {
 	struct nfc_llcp_local *local = (struct nfc_llcp_local *) data;
 
-	if (err < 0) {
+	if (err) {
 		pr_err("LLCP PDU receive err %d\n", err);
+		if (skb)
+			kfree_skb(skb);
 		return;
 	}
 
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 73e3a9647..678f744a2 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -413,6 +413,7 @@ static void nci_nfcc_loopback_cb(void *context, struct sk_buff *skb, int err)
 
 	conn_info = nci_get_conn_info_by_conn_id(ndev, ndev->cur_conn_id);
 	if (!conn_info) {
+		kfree_skb(skb);
 		nci_req_complete(ndev, NCI_STATUS_REJECTED);
 		return;
 	}
diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
index 4253edea5..3bbebb950 100644
--- a/net/nfc/nci/data.c
+++ b/net/nfc/nci/data.c
@@ -220,6 +220,8 @@ static void nci_add_rx_data_frag(struct nci_dev *ndev,
 
 	if (status) {
 		err = status;
+		kfree_skb(ndev->rx_data_reassembly);
+		ndev->rx_data_reassembly = NULL;
 		goto exit;
 	}
 
diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
index c03e8a0bd..a67bf6a72 100644
--- a/net/nfc/nci/hci.c
+++ b/net/nfc/nci/hci.c
@@ -435,11 +435,14 @@ void nci_hci_data_received_cb(void *context,
 	int msg_len;
 
 	if (err) {
+		skb_queue_purge(&ndev->hci_dev->rx_hcp_frags);
+		kfree_skb(skb);
 		nci_req_complete(ndev, err);
 		return;
 	}
 
 	if (!pskb_may_pull(skb, NCI_HCI_HCP_PACKET_HEADER_LEN)) {
+		skb_queue_purge(&ndev->hci_dev->rx_hcp_frags);
 		kfree_skb(skb);
 		return;
 	}
@@ -464,6 +467,7 @@ void nci_hci_data_received_cb(void *context,
 		hcp_skb = nfc_alloc_recv_skb(NCI_HCI_HCP_PACKET_HEADER_LEN +
 					     msg_len, GFP_KERNEL);
 		if (!hcp_skb) {
+			skb_queue_purge(&ndev->hci_dev->rx_hcp_frags);
 			nci_req_complete(ndev, -ENOMEM);
 			return;
 		}
diff --git a/net/nfc/rawsock.c b/net/nfc/rawsock.c
index f7d7a599f..3bf65b1fb 100644
--- a/net/nfc/rawsock.c
+++ b/net/nfc/rawsock.c
@@ -156,8 +156,11 @@ static void rawsock_data_exchange_complete(void *context, struct sk_buff *skb,
 
 	pr_debug("sk=%p err=%d\n", sk, err);
 
-	if (err)
+	if (err) {
+		if (skb)
+			kfree_skb(skb);
 		goto error;
+	}
 
 	err = rawsock_add_header(skb);
 	if (err)

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
