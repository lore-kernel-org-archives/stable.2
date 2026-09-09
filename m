Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6957F51D509
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949759; cv=pass; b=XRfFHFg3wQkx7ibgMG59lfO7eCohh8KarXj8zsFAcntOAUQ3RajcNclyvq2eiuJvN8TUMr4riuLsK1IFi06YjQ7Z7eIn4SOXNsVkMk1hU4KTHEcOc/rhrhke0DLScCMY9x1fEtzG06AwofnLNG5U3xVLsc1yZ904JWryuDKZCuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949759; c=relaxed/simple;
	bh=J47IYNdod02F1g3+6k0lLJqlTKfvKgWjoiv7iAB14FM=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlfbTMPhVOpcY9oSx6f9+eMyzLTApLmth5mGcvuqaUlin66YOkEXrkjtOFvW/PVEJwndf/jhvsyEc2KBVqcEJhrtuYcr3Lj+707rn9vvTDKdMisQkIPJANrfj8iSPx5MgbbrUSESLLyNuodvzghdP7F4ZDMhdnwVaL6MepHXssY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITjnVSwy; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITjnVSwy"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0d31069so559030e87.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 03:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788949755; cv=none;
        d=google.com; s=arc-20260327;
        b=Eh4t0ObNn05efne2ea3TFKGx1gFZktosUfmhOjW6lfyi8tBwYpPvWRi8HyzhY1ZRw8
         LHgIEZMH0yNoVY0BAYfcUd3ySHD1r7Tn5ZSVSlq7Be3Ynq/tdnX2/nbP/av4QqYypzDh
         4vWDvBop42c1AhgGw8aDcebebalulwCtEqwsOvqFRemVFGr/AqjIrj4DTFw7uDrtIgQ7
         cWaiP75YvjutBL18MwuHCPaxI5+SnNQGug+boWWYmNZ9o+OZnUJuIRsDYVRhQEQxa8TW
         nqFv/sJ+N1kxk0Hs3FklEXUgf69A5N0ykE/y6EGBd1HMPm7o4YajUvHrfxWeKiNZKGxD
         P9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=iQJPNUSAFJ7E51M7cx5Rfc6me1C9+bNgv9Pw72X8t8U=;
        fh=zZt7Qhxv/ZUN7d2Thb+LSN4n/Hsc4WSxi9JjmuI+cCc=;
        b=X1vJNykU3B/fDkGKMzSu/Vx1NN04/uu8TOnEiFttOJZf/OoX9OiuH7d9uHBXAZBYsj
         pg5foR3Z/cEUnuxOnn0zZHQKk39LnEntFcngGItRsPuHMtv3UimRmJFvLRHRoqfpcYkB
         jZihojaLqyuVsH/OpZ7OWcyZOEEGXYNvDMBi/0gXZcOdxsJPb6qokQbCWQRKiFebYVVM
         +ETq5+hCjZYVv76RcVzjZeqiG99gbd4j7XH7T082KtmaQbt1+33gx1kLV4veEuq0JKkH
         nO3jr8coOjKtbY3tgg72AhZj5RYE61aOcpI1psQHc9GhP5iiyfvNxbzuGThq0W2RZbLu
         CnNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788949755; x=1789554555; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iQJPNUSAFJ7E51M7cx5Rfc6me1C9+bNgv9Pw72X8t8U=;
        b=ITjnVSwyLX+koaMbfacdPUYeMT86TVB6KnRaAnuXc9LxcstfdcY7zF5pELZAx8Pq1y
         wCSt0nnLEp/PJeeGZBGHfXY9+7VjpSlqRxvQ3RgeLjQP+LK7ifwDS3gq6xbtwEbUvOga
         TsAQWzWu2b2QjJvlm4D8nMZ6CvsRqdNGJ7DZ5dBpN43O611gcjTtPWOeTTColbM5QmfA
         UJJ5PMffpFW9GyEFx+CZmmw903cGxNFJun0Spgtn/k4sSxEofcYtmLT9Thbs9gLgEBvg
         LHUoTpGB734C1QQXfXPmAPL2ygKiZ+lYErDixiBGdbgwudT7alnBhlqtoxv+GsB7oI1f
         EMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788949755; x=1789554555;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iQJPNUSAFJ7E51M7cx5Rfc6me1C9+bNgv9Pw72X8t8U=;
        b=Gp9ix8R2cR90TtfGgbuGXtGGrlUbyY71m73ylhfnAXM33quNudJxo0LdbnCDD6yp0v
         gq5U+m2Bag0bmGWtB63sEGjIWw4KRLszS2Ks9dBGJF8R0CCeqc96VEzups563UmRBhGt
         8wQPT6apUpJw5Dbq3LxRx+L5Gj+gkvQ8hOA4iTjeGFn8I9eQ8SHCHA8/pYrxA1s6Lo0w
         vDSiBTtpl6Hcbjm/2F9Bk5J6nThzJGgsDKFRMm9tpod4uc4gwPJd/BGMqh3BX6/HTanC
         xBNQskE30DjN2h6YbVkxixxYKauvzr/mjsy+kkU5Vppzxw0koZ27Txy3ZApfRUkUY3e0
         5xxw==
X-Gm-Message-State: AFuF++mgPCPmMKojqa1pKBrTNrER63W78BePrAaN+qyU+1ZnNN0/isoV
	tYPRBWJEI5FI1QUgFO1PBVl8WfDMwnDgNdD1p5H3R0sFWb4bwOYa8AvAEVTTeUlw4u8thTfaySN
	L4TyXMaO1jshsnCwYZrK1zpUUYwO+ZK5uL8RR
X-Gm-Gg: AYBFou2/cNWxV7r+zKsMp1MSI8a4ey8CTQqhzWG+WCdjbs1Ltz5GkIUl8tUjnOCplOg
	Uc/nyr4Vhdck8tECYe429xB784AcusBbuIt6pdenUKHsk/YW4AU6UDaBAKjkyoqtCe/fUbxIJ1S
	Nb4RWpEI69agEWZ7bu3ZCCGvOzsFa4N83ZGPsTfc2wW++37h3ZCUqrMWPgIoCgQXB/8OGzirB5x
	wsdxeP9SCDMsqR8G2zOMuh6k4GkUh9AOsFdy5l0mSPYRUspz9gEMZKek9G4t2o3kg1zDgAQsuB3
	CAiD5IMozDfzGF4ZGez40lEYW2qoM2YJQTGRlel4U7PozbCIj41FmVYbv2aaguso8WkS1zKavqM
	vO1UM9cQKEzTyd/HdfCfIx86nNU69CZ1PawfpivMWvMcBeN7jCig=
X-Received: by 2002:a05:6512:33d3:b0:5b1:5b49:9463 with SMTP id
 2adb3069b0e04-5b61705a661mr5719374e87.4.1788949755153; Wed, 09 Sep 2026
 03:29:15 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 05:29:12 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 05:29:12 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABKbRoKwKz+01bBMU_tq55aUQd5ao613v5n=M4zRjcc+j6=HkA@mail.gmail.com>
References: <20260907185001.1567957-1-miguelgarciaroman8@gmail.com>
 <2026090833-mutt-whiny-242e@gregkh> <CABKbRoKwKz+01bBMU_tq55aUQd5ao613v5n=M4zRjcc+j6=HkA@mail.gmail.com>
From: =?UTF-8?B?TWlndWVsIEdhcmPDrWEgUm9tw6Fu?= <miguelgarciaroman8@gmail.com>
Date: Wed, 9 Sep 2026 05:29:12 -0500
X-Gm-Features: AcwNN1U3c5d0ZRbND99B9WQAjVzD5VEcqFI4ZUv6legwqveMel1HfygidncW3Qs
Message-ID: <CABKbRo+qUMG8=+-MnY34KkscgZdPASieN7CgWce9BTCggNSvcg@mail.gmail.com>
Subject: [PATCH 6.12.y] Input: aiptek - validate raw macro indices before
 updating state
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, 
	pengpeng@iscas.ac.cn, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

commit 95dffe32a66cbed07fbfa7afed39d56d5014e04f upstream.

aiptek_irq() derives macro key indices directly from tablet reports and
then uses them to index macroKeyEvents[]. Report types 4 and 5 also save
the derived value in aiptek->lastMacro and later use that state to
release the previous key.

Validate the raw macro index once before it enters that state machine, so
lastMacro only ever stores an in-range macro key. Keep direct bounds
checks for report type 6, which reads the macro number from the packet
body and uses it immediately.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Link: https://patch.msgid.link/20260329001711.88076-1-pengpeng@iscas.ac.cn
[dtor: fix macro fallback in report 5s to use -1]
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Miguel Garcia <miguelgarciaroman8@gmail.com>
---
 drivers/input/tablet/aiptek.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 2b3fbb0455d5c..9e78105bace77 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -658,6 +658,8 @@ static void aiptek_irq(struct urb *urb)
 		pck = (data[1] & aiptek->curSetting.stylusButtonUpper) != 0 ? 1 : 0;

 		macro = dv && p && tip && !(data[3] & 1) ? (data[3] >> 1) : -1;
+		if (macro >= ARRAY_SIZE(macroKeyEvents))
+			macro = -1;
 		z = get_unaligned_le16(data + 4);

 		if (dv) {
@@ -699,7 +701,9 @@ static void aiptek_irq(struct urb *urb)
 		left = (data[1]& aiptek->curSetting.mouseButtonLeft) != 0 ? 1 : 0;
 		right = (data[1] & aiptek->curSetting.mouseButtonRight) != 0 ? 1 : 0;
 		middle = (data[1] & aiptek->curSetting.mouseButtonMiddle) != 0 ? 1 : 0;
-		macro = dv && p && left && !(data[3] & 1) ? (data[3] >> 1) : 0;
+		macro = dv && p && left && !(data[3] & 1) ? (data[3] >> 1) : -1;
+		if (macro >= ARRAY_SIZE(macroKeyEvents))
+			macro = -1;

 		if (dv) {
 		        /* If the selected tool changed, reset the old
@@ -737,11 +741,11 @@ static void aiptek_irq(struct urb *urb)
 	 */
 	else if (data[0] == 6) {
 		macro = get_unaligned_le16(data + 1);
-		if (macro > 0) {
+		if (macro > 0 && macro - 1 < ARRAY_SIZE(macroKeyEvents)) {
 			input_report_key(inputdev, macroKeyEvents[macro - 1],
 					 0);
 		}
-		if (macro < 25) {
+		if (macro + 1 < ARRAY_SIZE(macroKeyEvents)) {
 			input_report_key(inputdev, macroKeyEvents[macro + 1],
 					 0);
 		}
@@ -760,7 +764,8 @@ static void aiptek_irq(struct urb *urb)
 				aiptek->curSetting.toolMode;
 		}

-		input_report_key(inputdev, macroKeyEvents[macro], 1);
+		if (macro < ARRAY_SIZE(macroKeyEvents))
+			input_report_key(inputdev, macroKeyEvents[macro], 1);
 		input_report_abs(inputdev, ABS_MISC,
 				 1 | AIPTEK_REPORT_TOOL_UNKNOWN);
 		input_sync(inputdev);
-- 
2.43.0
