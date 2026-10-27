Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069873;
	b=NBHqFaobF9MaaFNxwwQTQ+wBmSZw/ZvLdQRZkqdgr1SNa9Jc4QHTQBeIjwznCT+fAKj1
	 KniJ3wIhaaZv1HcGbJI6EP6yaeFBtr3CbJuf2RKeVvtCdqiURmCF7D10HhFA1ZRBN6Srr
	 N2Jm11jC6KCT77TUJIPnD596gUF3ZyX/aYmNGjB+RQWLjfloDj6DVIhpRHIu9n78ANHkn
	 ilLC+pIC4NVs3ljFO6BZ5gNgD8YqLCyORv+pTHIR+49e2F/dkQJjfV+WSnqhDAY7aqgsC
	 l5Fp4swBDZ2ppBbWjWgGYX1boQC/M9UfTESjuAr5KpucTp6qzb4V9kwBoDe6idTHyQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069873;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TTwekm/Gt9bndSKmUoo4bfoXvp6BtM9Qta1TmXnMuEY=;
	b=2O03/HMOJMospmjuX0ranOa7hzl1D+cW1YAsM/YYU/Flc+IGFcEURhGjm5aOBb6iN5IF
	 CoZnoM3drkSfJ9ZoU7GqyHazjVvqWKHsn/8XEK/hpnBtyeFQWaM5usaCynKHB09j5ml3y
	 8mXWHlIjfU20L/sN09POQEn8rGY+WjQpGP+X51TjxMlCUotFPtpz9Zu8SvA6yzy/PMVfM
	 I5dH3mFFGw0ablkC6Fq412X+zARhFhZI7Nfyq4Rm0b+SeSrLQX/2/CAbRPJyZZ5kY2dvy
	 nhaxYnEqtXEjIRnB+iDhpjvMFuT2Ozapl5vwSsGU9GK3WtiPI5KfgI0YSaIQ5GgGo9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H2AERsOY;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B842606A31A;
	Tue, 27 Oct 2026 02:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B842606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H2AERsOY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793069871; x=1824605871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SchimnEHsM3qHihA0tcHF9PFqJCA9ILjKcim1aKJcUc=;
  b=H2AERsOYJ82c4RuR7oPfuvWM0uRxXNPMatqRtuzGQRWmCpOiW85oK6UY
   NZdowN2XKoXu7/msKmGdIT9gdEIpRAuB1FuVT2nfEMaNVTPj+D8IOdQe3
   1NTWc/kozY/6gjueg2PR7Z0aeGwMaTlJHN/6Xuo/7lLHdjzhroOV1a+rU
   O38xJK85eSu++5GhIG3VkFuBJcQhLL7atwrGT/nldIH7xi5Uq6qHW6GU4
   D404QG9AM0371tafDMEdaBViGkKvVSujE797iw4/opK1WaFJU7a/iqa5O
   P9sFMJcPJsNE+QKd/tmlNLIGugtu6Dm7uamehVZgehM4T8vzuOn6uShel
   A==;
X-CSE-ConnectionGUID: vNf7IGvRTZ+V+hJWsINxrQ==
X-CSE-MsgGUID: w46RGhDYRoOy3yIs+uF0ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1761129"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1761129"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 19:57:51 -0700
X-CSE-ConnectionGUID: faI6S+BMTEa9liU7ZOXU7Q==
X-CSE-MsgGUID: 01uCM4FQQ4+NTTAzLBsaEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4537589"
Received: from shsensorbuild.sh.intel.com ([10.239.132.194])
  by fmviesa002.fm.intel.com with ESMTP; 26 Oct 2026 19:57:48 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org,
	sammiee5311@gmail.com
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Even Xu <even.xu@intel.com>,
	Rui Zhang <rui1.zhang@intel.com>
Subject: [PATCH v2] HID: intel-thc-hid: intel-quickspi: validate GET REPORT response size
Date: Tue, 27 Oct 2026 10:58:20 +0800
Message-ID: <20261027025820.3085067-1-even.xu@intel.com>
X-Mailer: git-send-email 2.43.0
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

From: HyeongJun An <sammiee5311@gmail.com>

quickspi_handle_input_data() copies GET_FEATURE and
GET_INPUT_REPORT responses into qsdev->report_buf. The response length
is derived from data supplied by the controller, but was not checked
against the destination buffer size.

Adjust qsdev->report_buf_size to store the data length of report buffer,
reject responses that exceed it before copying. This prevents an
oversized response from overflowing report_buf. The rejected response
does not complete the GET REPORT request, so quickspi_get_report()
follows its existing timeout path.

Fixes: 9d8d51735a3a ("HID: intel-thc-hid: intel-quickspi: Add HIDSPI protocol implementation")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
Signed-off-by: Even Xu <even.xu@intel.com>
Tested-by: Rui Zhang <rui1.zhang@intel.com>
---
Change log:
V2:
 - Rebased on top of latest mainline kernel
 - Adjust qsdev->report_buf_size to store the data length of report buffer

---
 .../intel-thc-hid/intel-quickspi/pci-quickspi.c  | 16 ++++++++--------
 .../intel-thc-hid/intel-quickspi/quickspi-dev.h  |  1 +
 .../intel-quickspi/quickspi-protocol.c           | 12 ++++++++++--
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index 53023e30cf8d..d0aa66a8a4b4 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -562,17 +562,17 @@ static int quickspi_alloc_report_buf(struct quickspi_device *qsdev)
 	max_report_len = max(le16_to_cpu(qsdev->dev_desc.max_output_len),
 			     le16_to_cpu(qsdev->dev_desc.max_input_len));
 
-	/*
-	 * write_cmd_to_txdma() writes the output report header ahead of the
-	 * content in this buffer, so it has to hold both.
-	 */
-	qsdev->report_buf_size = HIDSPI_OUTPUT_REPORT_SIZE(max_report_len);
-
-	qsdev->report_buf = devm_kzalloc(qsdev->dev, qsdev->report_buf_size,
-					 GFP_KERNEL);
+	qsdev->report_buf = devm_kzalloc(qsdev->dev,
+					 HIDSPI_OUTPUT_REPORT_SIZE(max_report_len), GFP_KERNEL);
 	if (!qsdev->report_buf)
 		return -ENOMEM;
 
+	/*
+	 * Store the max data length of this report buffer, then compare it with output/input
+	 * packet content when write or read into this report buffer to avoid buffer overflow.
+	 */
+	qsdev->report_buf_size = max_report_len;
+
 	return 0;
 }
 
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
index fe51ff51d8c0..4362ac568bda 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
@@ -115,6 +115,7 @@ struct acpi_device;
  * @input_buf: store a copy of latest input report data
  * @input_len: the data size of the input report buffer
  * @report_buf: store a copy of latest input/output report packet from set/get feature
+ * @report_buf_size: the data size of input/output buffer
  * @report_len: the length of input/output report packet
  * @reset_ack_wq: workqueue for waiting reset response from device
  * @reset_ack: indicate reset response received or not
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
index 0df33c44fbff..5de25c36a1e4 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
@@ -30,7 +30,7 @@ static int write_cmd_to_txdma(struct quickspi_device *qsdev,
 
 	write_buf = (struct output_report *)qsdev->report_buf;
 
-	if (HIDSPI_OUTPUT_REPORT_SIZE(report_buf_len) > qsdev->report_buf_size)
+	if (report_buf_len > qsdev->report_buf_size)
 		return -EINVAL;
 
 	write_buf->output_hdr.report_type = report_type;
@@ -161,6 +161,7 @@ void quickspi_handle_input_data(struct quickspi_device *qsdev, u32 buf_len)
 	struct input_report_body *input_body;
 	u8 *input_report;
 	u32 input_len;
+	u32 report_len;
 	int ret = 0;
 
 	input_body = (struct input_report_body *)qsdev->input_buf;
@@ -210,7 +211,14 @@ void quickspi_handle_input_data(struct quickspi_device *qsdev, u32 buf_len)
 
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
 
 		memcpy(qsdev->report_buf, input_report, qsdev->report_len);
-- 
2.43.0

