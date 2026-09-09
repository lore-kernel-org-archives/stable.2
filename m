Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1FC4B0492
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949760; cv=pass; b=NeccbrRolCo24ITdAGtopyF4x266UC14ubLlUVNrGxf6nE6Tw/bo18kDVIWSBT9So1HI4Gl26L2boJrisNrecKT0cSPHFuN0Q59ENwhZcHxOONl4lcY3SfdvRXPbOfDmfwuZHDh/4DC/pF3iJKfCFdLDaL6P+RgGY1H/9FFnwcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949760; c=relaxed/simple;
	bh=J47IYNdod02F1g3+6k0lLJqlTKfvKgWjoiv7iAB14FM=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVBc/cRCJljkjzYvlhn2X4LIiiDuzJCrfhmunA2c0I2lQ29t4KfyZK96eXtq1hiwRlpTs2fFm0eIXlQlZMARWdJBhO09rwjzksXlMfnuVXERJ0bH+G9jS5COGL5T+9BC7SEBEmwSTzSW/9DdwV2D5aNcQBn57xkAZNg+BAqG3dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YP4f0z/E; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP4f0z/E"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0b1a4fbso427142e87.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 03:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788949757; cv=none;
        d=google.com; s=arc-20260327;
        b=LhONJLxM6KjzXfS2ml7eGDjyM3ufbFHcJzpZintBbBvUVXUR/fqQWW3V3FIbILoST2
         DqsSQm392wUf1debP1fs+evd22j40I6asrbqXbLUtmG38AWBwV2WEr0aNamO5/QeFljd
         Us7tiIApiEnJo3KEIwYQKt9kD63CuYS1S6bIhH+94m6CfvoHXhu+C70Rx0gGXqTEp4AT
         TuvDKwtEL4UC/Yq/AUzp6J22MNSst3a3VZ748ADT01Ni5jTOJavNR8DBaY1Z/UusG0sB
         +azKmV1CxwW6qM4OoSI+jzKdPgHu70NleB2d05XnV85MKxWavm4+D1dkp481tkMfXkLP
         1EyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=iQJPNUSAFJ7E51M7cx5Rfc6me1C9+bNgv9Pw72X8t8U=;
        fh=zZt7Qhxv/ZUN7d2Thb+LSN4n/Hsc4WSxi9JjmuI+cCc=;
        b=XB+xqGDNgWTtGLFc0tsVVizZ30vCUR9oWwfBaSXAOgz5oIfLbIY10VJv+tjGjkCdDG
         OTdfNm80mFOmhoCNXYltW/2dDDGPkCgV+jXf6uyuoyvVXktklYB8w9Kz0LbBp0SC2tS7
         QDmhCsvMpsWF7n6k1Up/qTMniSubjux7nv3r9kNpEVQJG//wvOHHqM8vcm5Bxe9/CXHJ
         BhbY9cNTBPZxqY0yjSjHXvOB1MoGDtonjEY45gNmTWQTWOGN+0Loovpa638gEn5UpzW6
         DqCkshs5STiX6/g5IQjKEpeTISoCWy5ZprTQ+9Ek8LGTR900L3cMPX0TXs9F2p3rOG4E
         PNEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788949757; x=1789554557; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iQJPNUSAFJ7E51M7cx5Rfc6me1C9+bNgv9Pw72X8t8U=;
        b=YP4f0z/E6eLq4kQfmp972b7VY4bTV5GtF+OLZVNVzQslxADC0zMP60hWxK1B70riyx
         beAi0Jf99TPbCQf9VUKWWQTn5ZasNphK78s4jIj0PQEH1hOOcDi3PITQp9kGO6fUOmMA
         OHaPRnbp2FoDVbjunKB0qAY8LFXow6D0Th7keMmHlhFdigmDtHmmj9wv8SMzUXdl1khG
         6z3fUrxlU8Q658QOBlxXS/e32WbMSwozywL4ByZii7pu2k1yv5Bi+bNEvd6Xgdbo0sRL
         WLEUW2NZPeGV581EC8KHeQ/5Cb4IlBqK9ZZWNXAH7pXU9dSSXBYm8rg9uHOu3+0d+XSZ
         eG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788949757; x=1789554557;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iQJPNUSAFJ7E51M7cx5Rfc6me1C9+bNgv9Pw72X8t8U=;
        b=gl0tyzJ5PsWaDNkd0lWsy9kcJccp18ku0aic4OxQvXxjokV8c024Z1Lp/n3DwPXiJM
         gWkgqnQ41DjKxlDCgy2Jb6Nl5CVjriWSf8m9dRPhEQjn7RCp4z8q4FSqZ+L1ylXASFM5
         y9/19tInaMWT1ShL6+OucbkfuVhaiTuIvhbH29J05UP5ywM6VFEDudXzwGFJlcyxLSY9
         bUuyDv0ZLWXu/LBRbWvQV6evttJ/sTKekp0mzYC9dhKln1etNslluwK3ZVvlGapvfIDm
         3ZnGX8FTLSAZWDkcxfVIK04CnJY063ZIJOXX1eDXerMsQ4srlhdqXQ9gEqvOsIoqHNtc
         mCYA==
X-Gm-Message-State: AFuF++nIscNlyNHQjiWXmfQNBiQYkGCw1Yqp0jr58rCMQ0e2aqAKn2KE
	s7dwEIqenHcZ3Omt126bB3jZua0pFSv+uzIJU9v7YwYxuhI12HDuIOdWtzham6+qhGWfd6+CMAY
	e3QRvatXuFnt+jdmkAIPBjIeZApP10Lpx0mQ8
X-Gm-Gg: AYBFou0VG8/UK51pwWjaBp5Q24SLESp3YY7G4Jnn8CWbz86SAgW0MG2k/rHtAvrO7Qa
	E09Z+rXGjtvloFi5frmbiLM2hNc2mLzuoOCt/dbouQwjukfwO09bIC77JRqXJvykSc4KPzbXJ7K
	SSITFvKjve6fEma/hDM11wShSB/m45Y4fw+nBekJPDQBEf7HYtTnTT3JA0ZJF5S6Z80XsB5KkwT
	CzsUsrx2GpLL5wKsViv2NCkndcIp3t1HNNh8UG8ezOAoK4hQ4h6YeXX2KUq7n+9plGDQXKNrHLN
	PRO2jGnbw2P5j8Jop4ryn5rXPDmLXEV5vywWDY8E28umqwS7vptvf8slBIY/NTf7a6VJ8bKHTqY
	K0hSP6bp0P4Iq+jKL9tVntOgbi0RCSIEZcxQiInlwtiEqTdKrxRs=
X-Received: by 2002:a05:6512:12d1:b0:5b5:e5ff:24e with SMTP id
 2adb3069b0e04-5b74d50c8femr4903174e87.4.1788949756789; Wed, 09 Sep 2026
 03:29:16 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 05:29:14 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 05:29:14 -0500
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
Date: Wed, 9 Sep 2026 05:29:14 -0500
X-Gm-Features: AcwNN1WKeRmXgfYzAnTcVTFj9yJFgL4osgNRmRmTnA_qDim8uPWYHEmSJpkSOfI
Message-ID: <CABKbRoJ1ON4KjuRVtCYmyLRrE6UO5XZaka-re3ByvkZVt_00eQ@mail.gmail.com>
Subject: [PATCH 6.18.y] Input: aiptek - validate raw macro indices before
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
