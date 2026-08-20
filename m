Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D7A41D13A
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224579; cv=none; b=HZ/e+Cw78b1+992xQewjobkqCz4AUJq6J5zCWugYwT6MOgA8syZMAf7ucGhCp6EKll15nubMTZUNEvnBSiboFhsAM5VkSzlFhvdVZbyrUhCAdnCuUQWCfa21VQ0H4UfrLnuiOyn94tSTdPr8Kufhnac2kYPHnh82Wv6b78YBbsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224579; c=relaxed/simple;
	bh=vO0izHD2f1ofrT6G0UqWkyQBcgoDbMLoEZdWgvw592E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAGpIhBkat664KWJTVm7rTc+R+emfArijBNUHQOHjPyHv7hThQTtyQiHQcq9o/oSold7z+FO4E/jIx5oMBrHBTdpMUx7taWYZGHYzIP1cDC1O4NU1Mzfag+C0SO8vpEr0H0gHFcyvOuP8gPBC7iUs4+VaVeLsmloXLKlVDn7KYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdwBoTS+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdwBoTS+"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84a2c90e383so553341b3a.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787224578; x=1787829378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xmFjaomKOSQJ0x9BcEAzGij2qfGuvuK5f2g46VdQqOU=;
        b=RdwBoTS+PBqktKaMXyAE0n7knUQGLTqRAbZJrSyvMR1n01dqwiWdJ/lyDXMQKyMwj3
         SdtETFoCpeqLKNCDoc+TC4sdQRzevmwYi98T1wjOA1DFCXrG7ArmBioHfZStTj9OT2Kb
         r6IR9NRorpuThsnJvkDocdqtYp9zhm6qHzMIyHdAZgJ6ZQGePlnBLIy4xJM7ji+2MnDq
         ZMruzVRDRkpOhKmvzKXEGfsB5tZYm56Mo5n5TYmG+cNeKIeiYRwpChg611UiyFI2h3PP
         fkNXCll3Ut7WttNd4pCIeqqt+LjGR9fgLClBlPmA9/eLCgFPx4lH/zQFVmbXz7OYHXUO
         lXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224578; x=1787829378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xmFjaomKOSQJ0x9BcEAzGij2qfGuvuK5f2g46VdQqOU=;
        b=jBaHGbDlrlwXYQDxZ+qLqga+m6df6tfmttg+MW/5ssxcxRUaFhVy1XSaAZMDsyuxtm
         gM01onGSR39XguRETERSYtNf+OzjH735JmbnLrIZzwbcdHIefw9Dc1Ij9fBq+LLfu0gp
         4EL29J+7w49gP2sZUGZEJ+1OxochaJamM4L/j9UbQhaVxyo+lgOCrij50Y5ELROsNnfr
         eEO87VUnhrPiHijhs5rcYuwjpF5n4+h1us3z8w7xwH6XJOQ9Yx41PMwGDEqTVTcqA8gD
         luuPd0i9x3NJP2CDuLgTC7RiatvYxgsFMMG/Kcyu0r3sTSJ/IPOxyTFNrvoQaTjP+v4D
         MqBw==
X-Forwarded-Encrypted: i=1; AHgh+RoeZ+veKEgpae5UOfctbrC3Zq0JKCKzE0rNKdFNek3F/5zaTKhgv1Xh02VfVijuSYVBtwrluqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL9KYhONh22AIMHRyjCoeRken/aCvdkyCIl9WYMYk8KGwF1fyw
	Yzc3nIQmFlu/4DYjF5CkIh3uDAOwJRqmLq4BeV/RcMYBJphv8OI/c+JI
X-Gm-Gg: AR+sD10E9CwxxtTn8+bHzE1G14maO9OEShGaePcvw1keMTHV8iIn9A+zIFnjWc7trcE
	dd8uMRzbJz6ejQI7dRQwpPbcOInLZnHlpSJPR7jO1GulkTNexgnyTrjThhI8sVXaIjRxwZbna+C
	f8i0W9OG5oci5ObDb8TKgRYmqXIQYvqLOgeNIK40S3wWOiO29g99FTz/INXk4ICJ1bAPyWCmllx
	nZbUv8wzEM6nSj0Ot6+Vly6BcJ4uZk7ZEChcb7RikD54Qv3N5+9223/wNuPFyV6s82nauWXYwex
	Nm98gXjPHKtA0DAuXWzhtbd2mcp78+YQoHZndo67Prtx9nIpheT+X+wVdGr4vV5lQREETL4AmJ4
	TPME/ijRPdajITq9SB1Ctfp+iV71O85CicqTuhwMFz4AHnrTFi4DXefTs2vIdP66SKLod0R+qhD
	9U+kc1+6mkiAwNtwoYb4/SslwoLHsqkXUobyV9bIq936Uli3cBsSJO4xd9+kToP39thd+ZI8sOO
	zFW1bSsxJ+a92pdVa/8PeF8BS33OLA/7Wz6lU+j2Amw+9ISfD4+8Bvvowuo9hKA
X-Received: by 2002:a05:6372:a70f:b0:3cb:b6b0:1b83 with SMTP id adf61e73a8af0-3cd14f251acmr5785817637.9.1787224577549;
        Thu, 20 Aug 2026 04:16:17 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15cada6fesm1236455a12.27.2026.08.20.04.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 04:16:16 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH 2/2] HID: intel-thc-hid: intel-quickspi: bound the GET REPORT response to report_buf
Date: Thu, 20 Aug 2026 20:15:58 +0900
Message-ID: <20260820111558.475304-3-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820111558.475304-1-sammiee5311@gmail.com>
References: <20260820111558.475304-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

quickspi_handle_input_data() copies a GET_FEATURE or GET_INPUT_REPORT
response into qsdev->report_buf using a length the controller supplied.
The only check it passes is against buf_len, the number of bytes the DMA
delivered, which says nothing about the destination.  report_buf holds
HIDSPI_OUTPUT_REPORT_SIZE(max(max_output_len, max_input_len)), 68 bytes
for a controller reporting 64 for both, while the copy is bounded only by
the 4K DMA packet.

The REPORT_DESCRIPTOR_RESPONSE case a few lines up validates against the
size of its own destination.  Do the same here and let the waiter in
quickspi_get_report() time out, as the other malformed-frame checks do.

Fixes: 9d8d51735a3a ("HID: intel-thc-hid: intel-quickspi: Add HIDSPI protocol implementation")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
This needs commit a59cf84441f9 ("HID: intel-thc-hid: intel-quickspi:
validate report size before copy") for qsdev->report_buf_size, which is in
hid.git for-next but not mainline yet.  Same Fixes: tag, so a stable
backport wants the two in that order.

 .../intel-thc-hid/intel-quickspi/quickspi-protocol.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
index 847c5ec55569..7d34cc22a11a 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
@@ -161,6 +161,7 @@ void quickspi_handle_input_data(struct quickspi_device *qsdev, u32 buf_len)
 	struct input_report_body *input_body;
 	u8 *input_report;
 	u32 input_len;
+	u32 report_len;
 	int ret = 0;
 
 	input_body = (struct input_report_body *)qsdev->input_buf;
@@ -210,10 +211,17 @@ void quickspi_handle_input_data(struct quickspi_device *qsdev, u32 buf_len)
 
 	case GET_FEATURE_RESPONSE:
 	case GET_INPUT_REPORT_RESPONSE:
-		qsdev->report_len = sizeof(body_hdr->content_id) + input_len;
+		report_len = sizeof(body_hdr->content_id) + input_len;
+		if (report_len > qsdev->report_buf_size) {
+			dev_err_once(qsdev->dev, "Get report response too big: %u\n",
+				     report_len);
+			return;
+		}
+
+		qsdev->report_len = report_len;
 		input_report = input_body->content - sizeof(body_hdr->content_id);
 
-		memcpy(qsdev->report_buf, input_report, qsdev->report_len);
+		memcpy(qsdev->report_buf, input_report, report_len);
 
 		qsdev->get_report_cmpl = true;
 		wake_up_interruptible(&qsdev->get_report_cmpl_wq);
-- 
2.43.0

