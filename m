Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EABA30D3E8
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789004220; cv=none; b=T5XRBAuPFHFzPi8KAFA9kqTjBemkfZjk4E+bPZ7hDfVJONHBUcgd/Yf/ulQkEbPcdMRDSzszdbKyaemDEyoZ0kmTkgkZCPm9XBH/pmVecZMcoWoemYzF89tZlN17zoHNM9Gd9kr3yjUvIrpKIFrEhHPKQKIG48JMGOArBvHHfVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789004220; c=relaxed/simple;
	bh=TW/azN0a4MSF7/Jiz8pnIQLf80a0QdaNKScvidvZkME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTIBnOTz6/PEhl5AHPNF9dlxzBxMoGMSN/HQWICHTenjmOee4dTCVRmuO6e7FcaT/ZsulqWC8AjW7Ig1L7zXrBBmZKHQkKhk6hq8mpwz4bO5pbsTWRUkpykkMfrEVCOqqiOKOoeDRttHPrhYxA/Vin81PKE4kooIuLXrJUOclq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 19b28c18acb811f19a56ed5b684f684d-20260910
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:779a3b93-1594-4b74-b331-f5be81dfd2d3,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:a688724f5a0f80301a98f072c61827b1,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50|99,ED
	M:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 19b28c18acb811f19a56ed5b684f684d-20260910
X-User: huangwei@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <huangwei@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 713237265; Thu, 10 Sep 2026 09:36:53 +0800
From: Huang Wei <huangwei@kylinos.cn>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	boddah8794@gmail.com,
	heikki.krogerus@linux.intel.com
Subject: [PATCH 6.6.y] usb: typec: ucsi: use UCSI_TIMEOUT_MS for sync command completion
Date: Thu, 10 Sep 2026 09:36:50 +0800
Message-Id: <20260910013650.2945842-1-huangwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2026090307-cannot-posh-1230@gregkh>
References: <2026090307-cannot-posh-1230@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit eb4573cf2fd860b20adfae050c3f6ec6ddc3abdb upstream.

The synchronous command completion path in ucsi_acpi_sync_write() hardcodes
a 5 second (5 * HZ) timeout when waiting for the PPM to signal command
completion via ACPI notification. This value matched UCSI_TIMEOUT_MS when it
was still 5000 ms, but it was not updated when that macro was later raised
to 10000 ms to fix PPM reset timeouts.

As a result, the two PPM communication paths are now inconsistent: the
polling path in ucsi_reset_ppm() respects the 10 second timeout, while the
event-driven completion path still uses 5 seconds. On machines where the
firmware is slow to respond during boot (e.g. some Lenovo ThinkPad models
such as the E14 Gen 7), commands sent after the PPM reset, such as
SET_NOTIFICATION_ENABLE and GET_CAPABILITY, can exceed 5 seconds and cause
UCSI initialization to fail with:

    ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed

Once UCSI init aborts, USB-C PD negotiation never completes, which in turn
blocks USB-C dock enumeration since the dock depends on a successful PD
contract.

Replace the hardcoded 5 * HZ with msecs_to_jiffies(UCSI_TIMEOUT_MS) so that
both communication paths share a single, consistent timeout value. Move the
UCSI_TIMEOUT_MS definition to ucsi.h so the ACPI backend can use it.

Fixes: bf4f9ae1cb08c ("usb: typec: ucsi: increase timeout for PPM reset operations")
Signed-off-by: Huang Wei <huangwei@kylinos.cn>
---
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -26,6 +26,9 @@
 #define UCSI_MESSAGE_OUT		32
 #define UCSIv2_MESSAGE_OUT		272
 
+/* PPM communication timeout in milliseconds */
+#define UCSI_TIMEOUT_MS		10000
+
 /* UCSI versions */
 #define UCSI_VERSION_1_2	0x0120
 #define UCSI_VERSION_2_0	0x0200
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -18,16 +18,6 @@
 #include "trace.h"
 
 /*
- * UCSI_TIMEOUT_MS - PPM communication timeout
- *
- * Ideally we could use MIN_TIME_TO_RESPOND_WITH_BUSY (which is defined in UCSI
- * specification) here as reference, but unfortunately we can't. It is very
- * difficult to estimate the time it takes for the system to process the command
- * before it is actually passed to the PPM.
- */
-#define UCSI_TIMEOUT_MS		10000
-
-/*
  * UCSI_SWAP_TIMEOUT_MS - Timeout for role swap requests
  *
  * 5 seconds is close to the time it takes for CapsCounter to reach 0, so even
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -88,7 +88,8 @@
 	if (ret)
 		goto out_clear_bit;
 
-	if (!wait_for_completion_timeout(&ua->complete, 5 * HZ))
+	if (!wait_for_completion_timeout(&ua->complete,
+					 msecs_to_jiffies(UCSI_TIMEOUT_MS)))
 		ret = -ETIMEDOUT;
 
 out_clear_bit:
