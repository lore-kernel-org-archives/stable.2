Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645473;
	b=v8CZzpFut9S/xre2OP2nKJNn3byPN22WQNJVkU0zGSvxMZJ1nOdQLbleyx2VJ8ck0wMf
	 SAVEZ2l/xWPA6drIJv8HCDTVi0i+2egBTjcSRZ2L13YdYP7uCP4rvL7vGQBEVZkRwMb5O
	 VcV2dKRvRtnEfYk7uS2RI6BXP0Vhcweeu+bOZ/YnmYTcY8Pn6MGfTzDGcbzOYybLdoukM
	 gtwfTHUdogzpKFZiXpe0Ub1C/jZTKa5JS81h89ezLEPIwhL/Wq6dJNnU1jywKcOJs8QP+
	 oVRYiy++3T85mII1FTj30XwbXihGe0TROmkK9W5JLsYimZx2k0lgy+bJwJZ1Mpd5lYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=DuZqLd0vHMeJXiMehSGkBOlcmKTFco/So2rHwAIx94g=;
	b=0Cu5vxEe3HcT3Nta0yo3O85TK70xTIZOpBG/CO5lpgRJxeLHZwEakOjKTe1cc7Cf01MY
	 GxOlvFvTwpUx4JU9LZofSFpT5CX+BoStjGvp1nFPVqpBLhmDjJ96u+K2ihpr47FsrcG2i
	 ChvYZwleyfaIlXiRLOmE8EU/kjp3iymqOhJ/MTWIC1Ot5YDWVl0nyXH+sOEJa6m52nJVB
	 yrbjm+JD94T8o0kaeBLonBJSW2fLKOl1HNM3PzzVFYLwO2QaAGOiLdHmh1JK6F1Ndia3w
	 9boOhs05tPALvpuyv598Fy9MY4sn6E6Wd86AUlIyjpyF49Bn9NW74ibCcexct8f4Ugg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QIJqMH5x;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6FA606A692
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF6FA606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QIJqMH5x
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1af203073e0so6806371c88.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645472; x=1796250272; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DuZqLd0vHMeJXiMehSGkBOlcmKTFco/So2rHwAIx94g=;
        b=QIJqMH5xn2m9F964j+/sF5Rzh74YHqxc/Eh3Tof73i7QvWrkECDCIMSlnhoKlMJAHR
         ho0MLJpyFn7ku4Kppj5UGdDpSnznnKaYf37w2KPx00Dsv1WK9XHoFT9EYGGEmcuEb8Gn
         T/HjZriM3tK36rFqY0Oblu7AsJ1ewqtx6sv1M7w4+FNIy889tfntpOslgx2yXm4faEkA
         dfeFgEvmN4AVXQlVv1zTm8bgYNujpPoIRsh/eJ24F1LuQfg/FnmqNzn9rtfJfCAStH76
         xOwiTULP2Ns0fgkweOdQDa+NcEDdj6f4uEhv5K4w1+vMUyk3G8qTPSYtS3V41Rjl4tu7
         H6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645472; x=1796250272;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DuZqLd0vHMeJXiMehSGkBOlcmKTFco/So2rHwAIx94g=;
        b=gdBa5hVOReFTzBO4Mpw+yERBqzLW7vT8YgvLx3pIuuykR/fHNl9nLnLoeZFugdIM9E
         NtRlwmj/lQD0okljBvaQl2fbAkh5BCDUHpZCBrrItrh2iT4Nnw0RTgnFKaw8XHFcb3qI
         4yJkH9PLj4h9sNOjAJbN2Rnmfc4axsPlykWyBbavogBSDx9mXcawfnHVBf1KTP/xhe+X
         Qb0UeKP0sdE8aNBiXFgJoFdFBVesz7H1QyxJ1ie5nSiH7ex9NAXVJEAbs6N0RjxDwMex
         mtIJ2kfVAHlJafFdEQp3Fvafh8UKL5X6VGkLOciQjNPIS3OLPvCuvjf+v+m/BzoSxvat
         r4+g==
X-Forwarded-Encrypted: i=1; AL+hErEnbawz3catg2rE549maJPAQgw+GXp+jj2BppcMaDow5WDiq5j4HR1jiUvi+/pOmcv9ql8NMaQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8u4I/z+JqeF6hififOVYGDlcuc9LbcCWnwac1XbjIoY2CHdxbS
	fW47JSMR4pcvxPaFQqFZQuOdLPKPvhNX4fDNLG/BEhiV+cMsoWyIWBQtiSOvdoh5VQ1lPxoW7Oc
	bwQ==
X-Received: from dycuf5.prod.google.com ([2002:a05:7300:105:b0:386:9be5:2d95])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:de44:b0:375:c5e1:931d
 with SMTP id 5a478bee46e88-3857073ebabmr19368154eec.25.1795645471570; Wed, 25
 Nov 2026 14:24:31 -0800 (PST)
Date: Wed, 25 Nov 2026 22:22:58 +0000
In-Reply-To: <20261125222300.1438398-1-elkin@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125222300.1438398-1-elkin@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222300.1438398-4-elkin@google.com>
Subject: [PATCH net 3/4] nfc: st95hf: validate async tag response frame lengths
From: Elkin Cruz <elkin@google.com>
To: David Heidelberg <david@ixit.cz>, Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, oe-linux-nfc@lists.linux.dev, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, irogers@google.com, 
	Elkin Cruz <elkin@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

st95hf_irq_thread_handler(), st95hf_error_handling(), and
st95hf_response_handler() index into skb_resp->data and subtract CRC
lengths in skb_trim() without verifying that the received frame is long
enough. Short responses from a tag or controller can underflow offsets
or read past the received frame.

Run st95hf_error_handling() before checking WTX_REQ_FROM_TAG, require
res_len >= 4 for WTX handling, and validate minimum frame lengths before
indexing CRC/RATS fields or trimming skb_resp.

This issue was found while trying out new Clang static analysis checks for
kernel bug classes. The finding was triaged and fixed, and this commit
description was drafted with the help of AI, then verified by code
inspection and compile-tested against linux-next (not reproduced and not
runtime-tested on hardware).

Fixes: cab47333f0f7 ("NFC: Add STMicroelectronics ST95HF driver")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---
 drivers/nfc/st95hf/core.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index d7ac7ede1259..ead0c342996c 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -667,6 +667,8 @@ static int st95hf_error_handling(struct st95hf_context *stcontext,
 	switch (stcontext->current_rf_tech) {
 	case NFC_DIGITAL_RF_TECH_106A:
 		if (stcontext->sendrcv_trflag == TRFLAG_NFCA_STD_FRAME_CRC) {
+			if (res_len < 3)
+				return -EIO;
 			error_byte = skb_resp->data[res_len - 3];
 			if (error_byte & ST95HF_NFCA_CRC_ERR_MASK) {
 				/* CRC error occurred */
@@ -678,6 +680,8 @@ static int st95hf_error_handling(struct st95hf_context *stcontext,
 		break;
 	case NFC_DIGITAL_RF_TECH_106B:
 	case NFC_DIGITAL_RF_TECH_ISO15693:
+		if (res_len < 1)
+			return -EIO;
 		error_byte = skb_resp->data[res_len - 1];
 		if (error_byte & ST95HF_NFCB_CRC_ERR_MASK) {
 			/* CRC error occurred */
@@ -714,7 +718,7 @@ static int st95hf_response_handler(struct st95hf_context *stcontext,
 
 	/* check if it is case of RATS request reply & FWI is present */
 	if (nfcddev->curr_protocol == NFC_PROTO_ISO14443 && cb_arg->rats &&
-	    (skb_resp->data[1] & RATS_TB1_PRESENT_MASK)) {
+	    skb_len >= 4 && (skb_resp->data[1] & RATS_TB1_PRESENT_MASK)) {
 		if (skb_resp->data[1] & RATS_TA1_PRESENT_MASK)
 			stcontext->fwi =
 				(skb_resp->data[3] & TB1_FWI_MASK) >> 4;
@@ -736,13 +740,20 @@ static int st95hf_response_handler(struct st95hf_context *stcontext,
 	/* Remove CRC bytes only if received frames data has an eod (CRC) */
 	switch (stcontext->current_rf_tech) {
 	case NFC_DIGITAL_RF_TECH_106A:
-		if (stcontext->sendrcv_trflag == TRFLAG_NFCA_STD_FRAME_CRC)
+		if (stcontext->sendrcv_trflag == TRFLAG_NFCA_STD_FRAME_CRC) {
+			if (skb_len < 5)
+				return -EIO;
 			skb_trim(skb_resp, (skb_len - 5));
-		else
+		} else {
+			if (skb_len < 3)
+				return -EIO;
 			skb_trim(skb_resp, (skb_len - 3));
+		}
 		break;
 	case NFC_DIGITAL_RF_TECH_106B:
 	case NFC_DIGITAL_RF_TECH_ISO15693:
+		if (skb_len < 3)
+			return -EIO;
 		skb_trim(skb_resp, (skb_len - 3));
 		break;
 	}
@@ -815,7 +826,11 @@ static irqreturn_t st95hf_irq_thread_handler(int irq, void  *st95hfcontext)
 		goto end;
 	}
 
-	if (skb_resp->data[2] == WTX_REQ_FROM_TAG) {
+	result = st95hf_error_handling(stcontext, skb_resp, res_len);
+	if (result)
+		goto end;
+
+	if (res_len >= 4 && skb_resp->data[2] == WTX_REQ_FROM_TAG) {
 		/* Request for new FWT from tag */
 		result = st95hf_handle_wtx(stcontext, true, skb_resp->data[3]);
 		if (result)
@@ -826,10 +841,6 @@ static irqreturn_t st95hf_irq_thread_handler(int irq, void  *st95hfcontext)
 		return IRQ_HANDLED;
 	}
 
-	result = st95hf_error_handling(stcontext, skb_resp, res_len);
-	if (result)
-		goto end;
-
 	result = st95hf_response_handler(stcontext, skb_resp, res_len);
 	if (result)
 		goto end;
-- 
2.56.1.839.g22a8290db9-goog

