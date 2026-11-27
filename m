Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795786841;
	b=uRs2KNjqBOLZP1hcKAiGMjvxF79TRu/4ws6DFg3rWSmmiI9bG7sWuwh5BmRdT/5nwSaR
	 YUM6R7knYOJYImRhe28sTmGT5I0K7bVrRztGebdkVncDD8cVt/5vj6eaH36A5W8BeSu5u
	 cnj3B7MHFgzMtXLpSyImxdb8I40ifse/KmmZvFXRCMGqcQ0tz6HeHXu6QfHPOwkrSfG5Y
	 ER7cuvjmubwrAjuooFHZaW2DMO1bk/HDM0+OMem+vzezuS7zCFZt/JtOfF8vZC1+BLQ5s
	 ehvU+Yv+476vmSDD6uA5g8lz4n5XCceWgoVS4lENdrQPonTLEUF5PzOXhB+l0Ep7BiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=W6jq9zG8qTie1UEKVvkOyRB8yWcqAk3YziZ4QEPwCjY=;
	b=o7eiBHnYctum6tTqPKyBcWon0ig2ZPFoudgG1G2w7CheR/DfGd3ql7iE+aLLWRQJlVz7
	 F04fRisJFAZqpJ8BNsxq/miLdGoQoF41c7+Px0ms4KyGD1rCz1ZNZnwjTAiU+bQQMXrWs
	 Ze09rlTPn316Oy83hgbPpLFBVe3EzLUkxeWakMiXLBHZQKwwe2uqm478FIQ7w5YCePUPV
	 tc20c/JClQMkhY2xzFJ1iP5ndz6bzjGU67RJyXISyVpF5vlx4NY5mFIk7IhWPs2DashnQ
	 URD2WlSF+U9kEwv3cXZ443h7J11+552zcCXRN2G8mUmYB2flqmhxWQ9NOIdo8U+Qo4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iMOYvmyi;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8F606A32D
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 13:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CB8F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iMOYvmyi
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b66d1a08ccso5651459b3a.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 05:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795786841; x=1796391641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W6jq9zG8qTie1UEKVvkOyRB8yWcqAk3YziZ4QEPwCjY=;
        b=iMOYvmyi8ceJgJ4tNV935CSfaXAW2UUPeryP3zW6Ux3+GzyqOlf7tlk0C5hvfu0JYU
         Sbd9r0Y8kfTZxGgZjOWpAWKIJZKeSZj2Lvf7JWhjJLhgBWKRGWH4QOrUdqqT/SYNI1WB
         5oNavjqAKp5FEs844JbzG0OQIs35plPLMvXuvJvSo0uvMG4Tl7x1fEhZeOmlCnFQiKkq
         GIQns+ltr0OXXzzVvEs7AJRq5FYWBRr1gvoza5hO+3uoDAVtiQJUc16k7wOKE9J+Q6WE
         P8Bbz0GKvv6s/g7UawWC/ExNZ+vDSNEL3PMtNRwujQWjnuCkY9QIJR+9Zjln/6HgC1L4
         NKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795786841; x=1796391641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W6jq9zG8qTie1UEKVvkOyRB8yWcqAk3YziZ4QEPwCjY=;
        b=uUiWRs/G5tSairGwPMF31iNrRIzmg5sNxfy1OokRCkN6L3xkuAAWayF+zQDXAcBcKE
         UWv7crWhXZIMaYVmi7WMnXYf3V+0tJwwf8XKOlyLS0K0cpQseJ0gN7nYs7NFG3bXE0Ha
         ibNyFMg9gXiFpsew1xga7rcZP0d9VeOZD6mCUF0Bnz2QqKjikHeIJhMEhtfarVAIWLIB
         v0XXSnxF6WPBJns/tDOygxNM+UtF12c9bJPaJGmYcnucrjXoIfq8k6IALh5r/4EcWJqW
         aF21/0ceuhCKXPzsnlONjvwoEF+WIobiY/5BJeNmGD0ZOLGbohEWHsz6VmGBuKWOT2rW
         +azw==
X-Forwarded-Encrypted: i=1; AL+hErGicXv8c7JNQ+E18UbVaVnD36vtxUSZQtchKhaK8z+J2PTyriWjHWNgeKjU+DdGvpUjJmaiM2s=@vger.kernel.org
X-Gm-Message-State: APuU4Z9We53qlHAEKKZHrnxkKgY4b6k33HolqYT0Z58kBfV9ndf8RNTx
	ohWIbgbjFffHwFvNkQEH5sTG55baI6opIj57UwmKHjSnhWbB+KCeY4QFMytlLgYKUA/4wzSy
X-Gm-Gg: AZFdTZfcQ4A29jzv3XXb/UnJKSMqFJlFynqUHILiy60V/FEW1P6YggPOT0LhIfelfVa
	pxSX5mMcy/7UZFo5yybyP+ZDDyo6mhsYDZY82F635y3WzaOUASK0r0SEzR3Udbr3xZguQWpzylP
	fwKiA5pOmh/UsbYMJRhexEKnpnM5Ybw2hf+NeODyDxxwV/Ca6N4yiJX6+0FDyyYGaaYMi5cK4RR
	5CeUKAWwb2AVWGG/7uFiobUKqIneKaogPMJ3XvmCxMDLO7b84r3B2Ef+6wzTUfl6eNhjEadRmEC
	wWqJ2SiZ12xKJMcwZFZ1d6Z0freWLsUlVwcDcbiRk/zy3FYBB9Mu/VhNZeySBJlSZaeD3IHL7+v
	rzrnRfvQSIPqSNgNzqXZx70ixgQcG8GmPm4VSD7kHn6/3UAyu+Zp9RPpUnFuKeaBpsy9KNdI1rD
	C0kVRppnnTNJWiBw/+/OzSZ9uRITywnRPYevhvEySSqxPf41FqtAgnKifzEH/j2+VuIOE69p4Ro
	/UCKwBRMNKBsbTQqcl+gEO4e0rVFFATjwoji22T0oQUh7a+Ex0LROrsnElPCojzlsWoozvMjxzB
	3QP3+thhfjWOIgnpLaNq5c2l8jryhuC2SDwdYRwqaBKULUjYgs0xDxCXbqBqeJqmk76v7DTTtjF
	fWOjaXq7foEdQGBHJCLqXUTZDDK7a1iP2TUNOvCHM4PYQeih03ECT0bjE8qX6XAXK+7wrupfpeE
	Lr0Zojii1gLTDljckj9NjyOH9gGAjGg9pY6li+rr3k
X-Received: by 2002:a05:6a00:b80c:b0:873:f7a4:433f with SMTP id d2e1a72fcca58-8c87beac95dmr23402128b3a.26.1795786840675;
        Fri, 27 Nov 2026 05:40:40 -0800 (PST)
Received: from LAPTOP-3B99V33A (ec2-18-138-229-8.ap-southeast-1.compute.amazonaws.com. [18.138.229.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285b60csm12705838b3a.9.2026.11.27.05.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 05:40:40 -0800 (PST)
From: "Bin Luo (University of Electronic Science and Technology of China)" <luob87709@gmail.com>
To: oe-linux-nfc@lists.linux.dev
Cc: johan@kernel.org,
	david@ixit.cz,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 1/5] net/nfc: fix skb ownership on data exchange errors
Date: Fri, 27 Nov 2026 21:40:25 +0800
Message-ID: <20261127134029.1813-2-luob87709@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20261127134029.1813-1-luob87709@gmail.com>
References: <20261127134029.1813-1-luob87709@gmail.com>
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

NFC data_exchange_cb_t callbacks may receive a non-NULL response skb
together with a nonzero error. Because callback ownership was not
documented, multiple consumers and wrapper callbacks mishandle skb
lifetime on error (and in ST21NFCA DEP, also on several normal/error
returns).

Document the data_exchange_cb_t ownership contract so callbacks always
own a non-NULL skb regardless of err, and update affected callbacks:

- Free non-NULL skbs on error paths in rawsock, LLCP, HCI/NCI-HCI
  wrappers, Microread, PN544, and ST21NFCA core.
- Fix skb leaks in st21nfca_im_recv_atr_res_cb() (including the
  READER_F success path and r < 0 returns) and
  st21nfca_im_recv_dep_res_cb() (including unknown PFB types), as well
  as their error paths.
- Handle nonzero err in nci_nfcc_loopback_cb() by freeing skb and
  failing the pending NCI request rather than reporting NCI_STATUS_OK
  with a NULL resp (which could cause a NULL pointer dereference in
  st_nci_loopback()), and free skb when conn_info lookup fails. Note
  that on current mainline nci_data_exchange_complete() requires
  NCI_DATA_EXCHANGE to be set (which loopback and NCI-HCI send paths
  do not currently set); keeping these callbacks compliant with the
  contract avoids regressions once that separate gating is addressed
  and protects stable trees.
- Splice queued HCI/NCI-HCI rx_hcp_frags onto a local sk_buff_head
  under rx_hcp_frags.lock before walking/reassembling so concurrent
  error purges cannot race with skb_queue_walk(), and purge partial
  fragments on error.

Found by static call-chain audit and code inspection; the rawsock
error-path skb leak was additionally reproduced and verified under
QEMU with KASAN and kmemleak.

Fixes: 98ff416f97c5 ("NFC: nci: Add status byte management in case of error.")
Fixes: 23b7869c0fd0 ("NFC: add the NFC socket raw protocol")
Fixes: 30cc4587659e ("NFC: Move LLCP code to the NFC top level diirectory")
Fixes: f3e8fb552789 ("NFC: Modified hci_transceive to become an asynchronous operation")
Fixes: 412fda538f4b ("NFC: Changed HCI and PN544 HCI driver to use the new HCI LLC Core")
Fixes: 11f54f228643 ("NFC: nci: Add HCI over NCI protocol support")
Fixes: 1c53855f6be2 ("nfc: nci: Add nci_nfcc_loopback to the nci core")
Fixes: 1892bf844ea0 ("NFC: st21nfca: Adding P2P support to st21nfca in Initiator & Target mode")
Fixes: 1c54795da05a ("NFC: st21nfca: Align st21nfca driver with other nfc driver")
Fixes: cfad1ba87150 ("NFC: Initial support for Inside Secure microread")
Fixes: 97f18414af39 ("NFC: Separate pn544 hci driver in HW dependant and independant parts")
Cc: stable@vger.kernel.org
Signed-off-by: Bin Luo (University of Electronic Science and Technology of China) <luob87709@gmail.com>
---
 drivers/nfc/microread/microread.c |  3 +--
 drivers/nfc/pn544/pn544.c         |  3 +--
 drivers/nfc/st21nfca/core.c       |  3 +--
 drivers/nfc/st21nfca/dep.c        | 26 +++++++++++++-------------
 include/net/nfc/nfc.h             |  5 ++++-
 net/nfc/hci/core.c                | 25 ++++++++++++++++++-------
 net/nfc/llcp_core.c               |  4 +++-
 net/nfc/nci/core.c                | 10 ++++++++++
 net/nfc/nci/hci.c                 | 23 ++++++++++++++++++-----
 net/nfc/rawsock.c                 |  5 ++++-
 10 files changed, 73 insertions(+), 34 deletions(-)

diff --git a/drivers/nfc/microread/microread.c b/drivers/nfc/microread/microread.c
index 2bfafa9..f221ec7 100644
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
diff --git a/drivers/nfc/pn544/pn544.c b/drivers/nfc/pn544/pn544.c
index c4fa70e..82f7107 100644
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
index b5c1ca3..68327ca 100644
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
index a5fab4f..c907b6e 100644
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
index bcafab5..bdf2ac3 100644
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
diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
index ba6f031..1b43f1e 100644
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
@@ -859,9 +859,12 @@ static void nfc_hci_recv_from_llc(struct nfc_hci_dev *hdev, struct sk_buff *skb)
 	struct sk_buff *hcp_skb;
 	u8 pipe;
 	struct sk_buff *frag_skb;
+	struct sk_buff_head frags;
+	unsigned long flags;
 	int msg_len;
 
 	if (!pskb_may_pull(skb, NFC_HCI_HCP_PACKET_HEADER_LEN)) {
+		skb_queue_purge(&hdev->rx_hcp_frags);
 		kfree_skb(skb);
 		return;
 	}
@@ -873,12 +876,19 @@ static void nfc_hci_recv_from_llc(struct nfc_hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	/* it's the last fragment. Does it need re-aggregation? */
-	if (skb_queue_len(&hdev->rx_hcp_frags)) {
+	__skb_queue_head_init(&frags);
+	spin_lock_irqsave(&hdev->rx_hcp_frags.lock, flags);
+	if (!skb_queue_empty(&hdev->rx_hcp_frags)) {
+		__skb_queue_tail(&hdev->rx_hcp_frags, skb);
+		skb_queue_splice_init(&hdev->rx_hcp_frags, &frags);
+	}
+	spin_unlock_irqrestore(&hdev->rx_hcp_frags.lock, flags);
+
+	if (!skb_queue_empty(&frags)) {
 		pipe = packet->header & NFC_HCI_FRAGMENT;
-		skb_queue_tail(&hdev->rx_hcp_frags, skb);
 
 		msg_len = 0;
-		skb_queue_walk(&hdev->rx_hcp_frags, frag_skb) {
+		skb_queue_walk(&frags, frag_skb) {
 			msg_len += (frag_skb->len -
 				    NFC_HCI_HCP_PACKET_HEADER_LEN);
 		}
@@ -886,20 +896,21 @@ static void nfc_hci_recv_from_llc(struct nfc_hci_dev *hdev, struct sk_buff *skb)
 		hcp_skb = nfc_alloc_recv_skb(NFC_HCI_HCP_PACKET_HEADER_LEN +
 					     msg_len, GFP_KERNEL);
 		if (hcp_skb == NULL) {
+			__skb_queue_purge(&frags);
 			nfc_hci_failure(hdev, -ENOMEM);
 			return;
 		}
 
 		skb_put_u8(hcp_skb, pipe);
 
-		skb_queue_walk(&hdev->rx_hcp_frags, frag_skb) {
+		skb_queue_walk(&frags, frag_skb) {
 			msg_len = frag_skb->len - NFC_HCI_HCP_PACKET_HEADER_LEN;
 			skb_put_data(hcp_skb,
 				     frag_skb->data + NFC_HCI_HCP_PACKET_HEADER_LEN,
 				     msg_len);
 		}
 
-		skb_queue_purge(&hdev->rx_hcp_frags);
+		__skb_queue_purge(&frags);
 	} else {
 		packet->header &= NFC_HCI_FRAGMENT;
 		hcp_skb = skb;
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 74bf817..0736a0e 100644
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
index 73e3a96..efd4e5e 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -411,8 +411,18 @@ static void nci_nfcc_loopback_cb(void *context, struct sk_buff *skb, int err)
 	struct nci_dev *ndev = (struct nci_dev *)context;
 	struct nci_conn_info *conn_info;
 
+	if (err) {
+		kfree_skb(skb);
+		if (err < 0)
+			nci_req_cancel(ndev, -err);
+		else
+			nci_req_complete(ndev, NCI_STATUS_FAILED);
+		return;
+	}
+
 	conn_info = nci_get_conn_info_by_conn_id(ndev, ndev->cur_conn_id);
 	if (!conn_info) {
+		kfree_skb(skb);
 		nci_req_complete(ndev, NCI_STATUS_REJECTED);
 		return;
 	}
diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
index c03e8a0..aca05ca 100644
--- a/net/nfc/nci/hci.c
+++ b/net/nfc/nci/hci.c
@@ -432,14 +432,19 @@ void nci_hci_data_received_cb(void *context,
 	u8 pipe, type;
 	struct sk_buff *hcp_skb;
 	struct sk_buff *frag_skb;
+	struct sk_buff_head frags;
+	unsigned long flags;
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
@@ -451,12 +456,19 @@ void nci_hci_data_received_cb(void *context,
 	}
 
 	/* it's the last fragment. Does it need re-aggregation? */
-	if (skb_queue_len(&ndev->hci_dev->rx_hcp_frags)) {
+	__skb_queue_head_init(&frags);
+	spin_lock_irqsave(&ndev->hci_dev->rx_hcp_frags.lock, flags);
+	if (!skb_queue_empty(&ndev->hci_dev->rx_hcp_frags)) {
+		__skb_queue_tail(&ndev->hci_dev->rx_hcp_frags, skb);
+		skb_queue_splice_init(&ndev->hci_dev->rx_hcp_frags, &frags);
+	}
+	spin_unlock_irqrestore(&ndev->hci_dev->rx_hcp_frags.lock, flags);
+
+	if (!skb_queue_empty(&frags)) {
 		pipe = NCI_HCP_MSG_GET_PIPE(packet->header);
-		skb_queue_tail(&ndev->hci_dev->rx_hcp_frags, skb);
 
 		msg_len = 0;
-		skb_queue_walk(&ndev->hci_dev->rx_hcp_frags, frag_skb) {
+		skb_queue_walk(&frags, frag_skb) {
 			msg_len += (frag_skb->len -
 				    NCI_HCI_HCP_PACKET_HEADER_LEN);
 		}
@@ -464,20 +476,21 @@ void nci_hci_data_received_cb(void *context,
 		hcp_skb = nfc_alloc_recv_skb(NCI_HCI_HCP_PACKET_HEADER_LEN +
 					     msg_len, GFP_KERNEL);
 		if (!hcp_skb) {
+			__skb_queue_purge(&frags);
 			nci_req_complete(ndev, -ENOMEM);
 			return;
 		}
 
 		skb_put_u8(hcp_skb, pipe);
 
-		skb_queue_walk(&ndev->hci_dev->rx_hcp_frags, frag_skb) {
+		skb_queue_walk(&frags, frag_skb) {
 			msg_len = frag_skb->len - NCI_HCI_HCP_PACKET_HEADER_LEN;
 			skb_put_data(hcp_skb,
 				     frag_skb->data + NCI_HCI_HCP_PACKET_HEADER_LEN,
 				     msg_len);
 		}
 
-		skb_queue_purge(&ndev->hci_dev->rx_hcp_frags);
+		__skb_queue_purge(&frags);
 	} else {
 		packet->header &= NCI_HCI_FRAGMENT;
 		hcp_skb = skb;
diff --git a/net/nfc/rawsock.c b/net/nfc/rawsock.c
index f7d7a59..3bf65b1 100644
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
-- 
2.51.0.windows.1

