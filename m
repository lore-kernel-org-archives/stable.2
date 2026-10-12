Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572134B1D08
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819875; cv=none; b=RSNvJSsEKB28VnWd88u2V234mYEokgZZHAjlBYBDArU8ZAInluRlyduCOHBEMw2f7uyw9VpK8xsIYXxzfFIurKRfq8bjSUwA79MBcUO6c+dxG5nuAUYXVh132UjzuTFStI6JBrKaXAf9E3aNRbq6bRlD8EFfJ/3zXKICKYWHm78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819875; c=relaxed/simple;
	bh=vMCqB0hD0d33CKDMPrXXNYCt+AWzsNFqf9zV1oFDLmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pif7RLPqESi4LVWZGGIsGX8iRv8fErag5F8QFob25T0JSN3wbA8ujYJeJ0FQn4MTinWhQTOF5T0fAtiVnSYLKakDy3hLWbkr8NL1E0aLx2Vxk2guleiFmzh8cP7Gd9aM/jIWkld5KRZoqMer5yjP79MgLNMlldzl5uvd9vGI3Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=W8aoxX8g; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="W8aoxX8g"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3a4b9732d5aso1483691a91.3
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 08:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791819873; x=1792424673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wKZ8udCmDcJ4nEacljHli9T2DKZNy0YCKclfYROWFCw=;
        b=W8aoxX8g9fRHdJ4a/WMixaF7GLZkEVMsM6veY5wo7vQl/3Psw6Hdi4mDMkrdOfpDh7
         NBkHEvmVLRw052jr58vpvVynbhMmIinuSvY6jlgrLGwRnTBXC+lABIFKW7bj7Lc02ydI
         o1IU/d/RPx/6OwJRwgoScp3tflxeQfCKDwbLeZQTz3bQZCThKh6WWaoskBiGBOxizmIc
         zNX1cGp/ZCWLNxP4GsAqtvYvktaOpiHAQYbxEl1wbK+upDf8Jp26SFxi6CuhSDb3QBLS
         irbaTprMrY0h2hcJZjFNucpEETI3BunME5rbfusJk4YJMJ6M1TCVmzz7HNmQbO5VSqBb
         Fhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791819873; x=1792424673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wKZ8udCmDcJ4nEacljHli9T2DKZNy0YCKclfYROWFCw=;
        b=H8GrF1XOcsnH8tYqjCRH8s6wOzoOAM3udU+0X4mQ1uNZj/ADHM0xqKevp4MM1hJguA
         LCj4t9nQqFT6+miJNtQ1C5AAnxMr0aZFYLVDw0g9Yr/tuHo8AAearxRPtoSZZeGSLeHN
         fOL0SJaEXKqQdlHiWFriEhzqjLxpR/oL+kNRqlijXdYR0FATj3LjNmn81/U0Q4xPbr5J
         /rE7Y31oyyYKQmymIcjkRAabnSlz2hbMIkG8bAW+ZctjTolH43E0HPMkvibF3gd0gVA2
         9Ke+87liwUMkovA7uZR0f1UlVybEFJp0FbhRcMx/wjl+dKtAOWIG/v2LXqcIHSnyBJui
         pD1w==
X-Forwarded-Encrypted: i=1; AKwUvBwUQnsJhIAGU+bpLUtMLZpQ3A06+tQZ4QeLr7QuZr6RclKfeEFr485zK5tpEuKdbtT5gmJJdbA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7CODotE+3Sv5uCM94azH1jeT0aRogeDDNoEEm19nHG3aOjj91
	9TfFF7W/84/xjzKmoKSha8jai5QoPGqSdbKtHbe5hoZk4kYdUFQ7IqK487tzT6PhYhpJAI+YMXW
	TDJyjP3U=
X-Gm-Gg: AYBFou2m3aoBfc1sRklLwRrjDwwu9TY4rfm1P9kEZ0BZZACUxSKWduLV3qfI8HhPemw
	pBuVv+byzYbHJZ4gERqx1GnQXbiC4HX6BPAdiff4Ut4bA+4Z6hJyKn2fIbhsIdpTPhljJGlZbW6
	1hQ3OdrHMZWcAIL8VvZfEFKEIdRmOK2a7Y7SuG2Q5x9fzsG9jteb7JK+zJha9XUX7gG4PIJhZ7/
	FfeDLf5Pxrcvb2XDrBSimRJ3QpZ9Kv+n59b8ooRo05zrnzRuuhceGBbkMEvRgTGM7vLtloqIGef
	nnC7q06bDQj+qr0w05SsbQJFM7K/baeroMrAvB6kcz4ClgdNMp1J/v4KWcyYRjURXSEDkr09dOO
	E5YgnIR6kDKMbgwaC9WbbybQ3pgYORd33QNxv0zNLylEoFg1SmF7MCiaMXPGYE/mSaY8SuAhdzi
	vKtFIUqpOUa75UUBNatnQ3k9tGjn3uLxsgDh912orm8HK4hOI3UQszjrfFf7aUuSbKNYW06txjF
	HWe9rBD5GsBmmtZZX99w+nYDzwp8veL
X-Received: by 2002:a17:90b:3b82:b0:3ab:4f1:4f76 with SMTP id 98e67ed59e1d1-3ab3a94f426mr8967011a91.24.1791819872684;
        Mon, 12 Oct 2026 08:44:32 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:7bd2:1202:246d:44ce])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38dd5864sm16692102a91.8.2026.10.12.08.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:44:32 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: f_tcm: reject a short write data-out transfer
Date: Tue, 13 Oct 2026 00:44:22 +0900
Message-ID: <20261012154422.2436134-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usbg_data_write_cmpl() commits the WRITE buffer to the backend as soon as
the OUT request completes successfully, looking only at req->status and
never at req->actual.  A host that declares an 8192-byte WRITE but ends the
data-out after 4096 bytes still reaches target_execute_cmd() with the full
length.

The buffer is not zeroed (transport_generic_new_cmd() leaves zero_flag
clear for a data CDB), so the bytes that never arrived keep the previous
page contents, which the backend writes to the device for the host to read
back. The target core refuses a WRITE whose declared length is wrong, but
it does not see a data phase that simply falls short.

Fail the command when the data-out is short, using the transfer-failed path
that is already there, the way f_mass_storage treats a short bulk-out.  A
conforming host always sends the full length, so only a truncated transfer
is rejected.  There is no oops; poisoning the buffer and ending an
8192-byte write at 4096 bytes leaves 4096 stale bytes committed before the
change, and after it the command is aborted with nothing committed.

Fixes: c52661d60f63 ("usb-gadget: Initial merge of target module for UASP + BOT")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/usb/gadget/function/f_tcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 9e6d4f39900a2..54e45d3c79563 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1090,7 +1090,8 @@ static void usbg_data_write_cmpl(struct usb_ep *ep, struct usb_request *req)
 		return;
 	}
 
-	if (req->status) {
+	/* a short data-out left the buffer unwritten; don't commit stale data */
+	if (req->status || req->actual != req->length) {
 		pr_err("%s() state %d transfer failed\n", __func__, cmd->state);
 		goto cleanup;
 	}
-- 
2.43.0

