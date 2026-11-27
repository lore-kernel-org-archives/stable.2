Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795786848;
	b=m0mUyfYHBKRf8pC2gPmyb9Pp4EJCgPZJl7yvEOsnxvc/TzVWLNmGlTS5NyQYrTJx5KUF
	 7UKcJhZ6dxzOz/leEbq6xR6EA7KfJJemR2Cu49jz5awhvtUtfVtinY02P9nV6Rc7yXlol
	 3P0QhBRk/tHwNAq3V6n4Y9MqU7MNb2UwUtV0AkSxzpRQobKL2T7EluanJuJ/A6iekXhy2
	 umxDTTTD+f8Pn4IYaCXWV7qozNfTVF36I7ethZO1FsyiqpPfb+MvUIPbyNmRxFe40NKE6
	 TPJK9oWga2l5qBTjTt5a06MgqXrArViCp+6GxQmj2Q/3PdHB6wbkyUdzALpR+udL3ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Sua3zmSI3nL9OitX0T3+r5SPaTOlATxaZ+LIkj+VHWQ=;
	b=sXG0FUNuT+4vqu9mvGGEW4u12ie6HOArtTQzq6F3eeRkHLsKHcW3d6BpCaOTWn0Q2LNv
	 QoCr2lJ0SWhQINvryhGg9hV2wq3Wvv78IfcN6vqnp/HV+CxDteMrLceHFRXFeSMSXnbxR
	 keZyif2z+xpRNkOCOpiUo/xlbrpCAdXRLfm80XlEypdpquvCHkrIVENwjX9AgXys22AGF
	 aX283nukZ/q6/r1YFQzdOWYPUUcM77YD+7ZHS90RyeNY/7ys4+GCavj8Sg1rRYJ45ay3p
	 //Z5YbMxbqgO9FQvVS1FPXkZ9wp33aUO2IPgkui8mIcLMTVuPY05Jk6Yh7aBcovYdaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jsWlbbzF;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAD3606A323
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 13:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CAD3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jsWlbbzF
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b2f59de176so5956522b3a.2
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 05:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795786848; x=1796391648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sua3zmSI3nL9OitX0T3+r5SPaTOlATxaZ+LIkj+VHWQ=;
        b=jsWlbbzFg5LaQQust3PO7MDmY47VCJn6K+oluznWTM69t6c25a5IOn1tArUTR956cp
         PpNdE+xElQGdaHZQDIFX1Gld5LfN/ZpDt+DK7ck3G07pwxid7YnETBM7kbRXdIT4e7Vu
         jNUWZSPa7x3gsZlcaiCY3nu2LG8FrbLvV3pFuG85+CC/Qc1uZdaGxDMvDG96QDUM3ss/
         vZgVQuJAuvE6APEq2+alJvPbePJ9Z9m+qBts5ohxfTXNeF3lx4WgCyKthiVxxetVxJ7d
         d+QYogXxheR+SVHF4GBz3Jlx9fd2H9IeTYiyYwigBGO7iIwEQh1/i1/4VphzJmhu+7q9
         kVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795786848; x=1796391648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sua3zmSI3nL9OitX0T3+r5SPaTOlATxaZ+LIkj+VHWQ=;
        b=mbl6n/GulWolhX+2X/mkaJbuDWdXgg5E1JaJczUo7s86YPB+/41w+SF4GiF/uTYUUq
         JECtSH82VeNnVTo52khulURCsSukzaoMihe1jM49MHiwujd6NvxlSa+ceFEgPX7fd077
         cq4K3uCA7atuTD9Rn1evpB6U+zRQE3fNk318FMpaz14fXOGghNcnZqoYRFgvcRjwesCR
         xKJcgW+gI/Aj2ai3bjlvpBj7phdf3ec6fkdUzijHuSqGMb002eOOI/hCVtCy19AQRub7
         h7ulYZT2A10EBHnWEDaKkz9gEogYer/Fjw1q8Np41rBeyBCsZA2BLDh/f1jpte1eLMrT
         qfvQ==
X-Forwarded-Encrypted: i=1; AL+hErFy0cMZoJGgHNM4dAVLeFIg/5ZLpqsu+D2RT4DBV5LQ+9RgP333kOIOjyGrr7U4zTO+BEGzg2Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uLOthn3bpnN9fqXrPbg0mRTkDhsiMnIxbrixcXrX+AHpAXyZr
	0z+Du0xNBCwwKxclcpru4tt6yRID0O8PUymPgiCZL1Ck0N3LPyqTBmluYiBDwimCMy+vBOfT
X-Gm-Gg: AZFdTZcYwzQCrvtaPXVNp2+XUQLpgjecenUHw8PfAYf1V1qbFxcB7q6OGLc9d5P620f
	Hficic/hdNdaa3sFyt6NDEFlqrNA35g6DAjEPmPqogO7qOLnwSmRAh8s86kmD2MlTHb/pUZ5WRO
	WAe0DGADC0ZJugtX/NR2ANQKaIsoWUK3vTYT3NM3h12WiEcNlGrdZhnp1cmFURGb80Zuw/Ua4Ip
	A6ayBHXqUfNSqvEdbHO9mLmkxvQ2riOhXXrCRtJR0gIrQPeHTsmVBd7BGX6zT7CmoitJMRlbmgM
	RYTJ1zJYx9YNDWPMdHmhj4isUAEFV38yi/0Wt5uct28EGB6OoxfdBP1CPEtDCsC3/4VgdLLmwao
	K/FGqvLrjP40Ib9IDsCu067qkBEOd13SsduL9JhrJC1HAZ8vlvpfh53CTAKaVsmF0S4DxvKgJs7
	Y7qvY2y8qJZJxWQxcSUxekYioit5psYh+ZVtrBjmW55pHTCeX2LC+8FyBcEhAwTvXqdAavHgz9F
	6IPcKtP1zPrbTWpIDkGk0QBARRf1EM6r9R5PnZkboyILbzzifcvbwsTSy+FXrddIYL42rQXb89y
	R+ToDou6UYL28vNR+3IuQe5jTzi9mHurcwDgdAX7Gowf4Akl87ltkbBOxtXAVxO/rF5l372vr29
	UYjHX7/fanrLjkAXO5lSrmTkIBaUyJNTitIe2qiXTbOTEi5rcvhf/YU+q6aQwg5+0oryfd3e50H
	txdjJ7uMpreYDSkIP8UD0euTEWHbVglgi+0tX8yh8=
X-Received: by 2002:a05:6a00:13a4:b0:886:3827:c4a2 with SMTP id d2e1a72fcca58-8c8792b5df2mr22233457b3a.3.1795786847901;
        Fri, 27 Nov 2026 05:40:47 -0800 (PST)
Received: from LAPTOP-3B99V33A (ec2-18-138-229-8.ap-southeast-1.compute.amazonaws.com. [18.138.229.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285b60csm12705838b3a.9.2026.11.27.05.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 05:40:47 -0800 (PST)
From: "Bin Luo (University of Electronic Science and Technology of China)" <luob87709@gmail.com>
To: oe-linux-nfc@lists.linux.dev
Cc: johan@kernel.org,
	david@ixit.cz,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 3/5] nfc: digital: complete DEP data exchange on terminal errors
Date: Fri, 27 Nov 2026 21:40:27 +0800
Message-ID: <20261127134029.1813-4-luob87709@gmail.com>
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

In digital_in_recv_dep_res(), terminal error branches jumped to the
error label, bypassing data_exch->cb(). For callers such as AF_NFC raw
sockets, missing the completion callback leaves the exchange hung,
leaks the socket reference, and leaves tx_work_scheduled set.

Route terminal errors through the exit label so data_exch->cb() is
always invoked, and drop the redundant kfree_skb(resp) because the
callback owns any non-NULL resp skb under the data_exchange_cb_t
contract.

Found by static call-chain audit and code inspection.

Fixes: 7d0911c02fa2 ("NFC Digital: Add initiator NFC-DEP support")
Cc: stable@vger.kernel.org
Signed-off-by: Bin Luo (University of Electronic Science and Technology of China) <luob87709@gmail.com>
---
 net/nfc/digital_dep.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/net/nfc/digital_dep.c b/net/nfc/digital_dep.c
index 968547c..cd6eff0 100644
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
@@ -892,9 +891,6 @@ error:
 	kfree_skb(ddev->saved_skb);
 	ddev->saved_skb = NULL;
 
-	if (rc)
-		kfree_skb(resp);
-
 	return;
 
 free_resp:
-- 
2.51.0.windows.1

