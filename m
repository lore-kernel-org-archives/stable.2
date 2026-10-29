Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283043;
	b=1rRssIdm3gr5SgZ+05/PnobP/txma6RYBN7J4wYZ2ADsipFboKFxVDOqlolgKizOQQZX
	 t4RHmFEvkG9n5cs8N4tC1B8buPARHlrSUcw+Azu6WTGVxDSB4Z64zSwQPeHBRcQtZR1jr
	 77NaWq8YPgQ8/cpyuJqYZoLog4Y0IcWxsDOvlBQJQORBUHpfhyC84yZ4zTzw4pRfdKIPT
	 2nMIE1Gj6wCIHoNFSeQsltAWJJDmkFolucgcBu3FucXCQ2dndaLdGcWkmuPz1y78pws1J
	 HJYdmQXEj2e+cxIIO/PeFjKc2zSUlWrzvlHWgKcjXpiG6haIcYSDl7LJWcd2jUoqDWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Vk2sd/A1AobcphO8+KnNKKLDJrQBIKgn8PW5ptXB6YA=;
	b=TeLojqlJJe09JeHA2EtH6X0w4JH4YhLArEcpXma+3/eppqHhBlQ9KU/r44JnV1rb94uA
	 ufdB6ew6pbf7+Ie5uoUq/LU3tXvku/LooetVrVnpGCZpEAmHBd9hJGZNTwrY4KRfWv164
	 OvgOK5+1G7WbzBdgZPFUg1aT7EkgemTjuyEvEwn2p4+YJQGsbxkiNFwM+V9lr1GTx3ziC
	 AuY7gH2ltHp4b3veGxu9O2cZbOQePAT1Dz8bT422VE5RDE+mR5BEzucDXHLE0GwUyomz0
	 3E5Rf5xhB1ozgvZygRfrzXmrO7BAJc+VmFpHgESFFiTkkH3qXRoSVMbgMH1QLcPTCOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PVmDSdDR;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C982F606A323
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C982F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PVmDSdDR
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso1651514f8f.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283041; x=1793887841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vk2sd/A1AobcphO8+KnNKKLDJrQBIKgn8PW5ptXB6YA=;
        b=PVmDSdDRXDTJMhF/yDyQs7a8ZNmHsFaWItmCnxiD8TtlH/UeqznCwWb+sIiNvlc+bq
         auwQhDlyM12d5facgs/mOfwdB80tyI1JFh+QxwKT0HQV9Gyd0ihTEAf7yd/bVnxxGaeI
         6Pmunp25tyWItK9zbeMMAJ1uaEDJTMvJVer4txZ18oKVlGosSNJPiCy2t5g3tbeu6u4v
         vW1EcGiPahyEECKQ5FL594OjitwWsNTX+WjweX/NTs3hXodqwBuy0CYT+IXMtvckd7Kk
         9nMvE2L+zqfAYHIP0lSPm7WzfcR/iz2vESjoEr1gxdwziFoGga6US1ds5n49aTP3kHR7
         VNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283041; x=1793887841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vk2sd/A1AobcphO8+KnNKKLDJrQBIKgn8PW5ptXB6YA=;
        b=Vi/y0XCy4lZr9xnSX8twiE3DhRNwi5J6NKJU7x7gX4uzK9ACXn7AeRQUlZ1JjA30vR
         +1e0uRWSxFGZmPAtVbA1QCzKOWptt2lhWms8NEIARtvi0GwPFCzLJOTurLUpXqciw7jt
         GyCqOTDnl+D1IQcRbDcBIBiKG8MN17/HkcusQiXXUABUDlQ196ZZI8y6LbtG4ZsMnRrf
         sFNzKu9FX/oyYWNRtt0ZMK77o18luXKjpmlL1szsI+jJeHMKXB+w65jC0E6+Sfz9CWpo
         rHJndXFWr2WFyGmP39YEAwEN+VlrkhncUOASeQl1bI8ng+TewuFxSXDaor7aHx5BOvQO
         X+Gw==
X-Forwarded-Encrypted: i=1; AKwUvBz1MPVvUKaEj70j45L0u8nV/hB6Mf4V4U8scEWpOcUhK75Hwg7jvXGf4PTJ0AhmC4y8OYCMhm4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKObP1W8tvze6r3KVtMKCj39b2Zy3zEs8kCwZfAC3zxDtbXafCF
	VPeAo2WcrkVZ1WivV2FhqV2cqGqwlAZZh7+asVLG2xCVs4Wj0T+Phuw=
X-Gm-Gg: AYBFou1DUPZcctEkOKFRC39suzDXK97GGaQC/sMY+WXN7J5NVYqb12P4pe0R/xG6qIm
	cbVVeTrpl2ZgX96oZjUgnhveFRDlM52C53SqRi9xK/SuQ0vVUBCKtirznSEdqWAM4ARfReQMzca
	S1q8mYfjdS35BtQ/mGU48q8SAT7eyL4uFFB5ZYGAB1Tai0A1fWJtxuExNDFsq8ZFBpryF2kXQ/P
	nzLf7zvG3O/quiqxHJwUn+nub5QONPz0fL93Gjo74MXboU8nzzCS0sNMVZYxVYY/NlDYLpO525V
	+x5l+ujdc+qFUoaO39N0RFeMxWWMh6/b9JK8bBTxbe6PbZplrnI4IIk6YhcMbMSqhz9o4Zbqy/8
	NmJGGcKV5/XqXiJG56mq/QmET8BD/dNjE6gZhbTk/h5kqp/JBJsN60Ygz6QgUU+4Ruyaf//K4Jo
	0LDagY7ggUi/pMLNkSa/PMUByyQtpSM3OC0/4eZNFXHoSb5b6NoR/J4vaTJBjr4agl7wRkoAo4m
	NMnCguudffEamkENcvpu+Ub4aq4raduFhCAKsUivD2C2G3mNlrbyHSbnO4MfnwJy/X7EGXtdOLd
	QnaJhy+dvDwLCZeELpY=
X-Received: by 2002:a05:6000:29d7:b0:48e:e2a:4093 with SMTP id ffacd0b85a97d-48e5d5c277cmr9225789f8f.19.1793283040946;
        Thu, 29 Oct 2026 07:10:40 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3932sm35906848f8f.18.2026.10.29.07.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:10:39 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	linux-input@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 1/2] HID: intel-thc-hid: quickspi: validate ACPI buffer length before memcpy
Date: Thu, 29 Oct 2026 14:10:35 +0000
Message-ID: <20261029141037.2655603-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029141037.2655603-1-tristmd@gmail.com>
References: <20261029141037.2655603-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

thc_acpi_get_property() copies firmware-returned ACPI buffers into
caller-provided structures without verifying the buffer length.
Malformed or short ACPI tables could cause an out-of-bounds read from
the firmware buffer, and oversized responses could overflow the
destination struct.

Add a buf_size parameter and reject responses larger than the
destination buffer. Accept shorter responses to handle firmware that
returns buffers without struct tail padding (e.g. 1 byte for a 4-byte
SPI opcode field). Zero-initialize caller stack structures so fields
beyond the firmware response length are deterministic.

Fixes: 7cb06f08ef13 ("HID: intel-thc-hid: intel-quickspi: Add THC QuickSPI ACPI interfaces")
Cc: stable@vger.kernel.org
Reviewed-by: Even Xu <even.xu@intel.com>
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 .../intel-quickspi/pci-quickspi.c             | 37 ++++++++++++-------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index ad676fde211b6..deca020a46497 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -75,13 +75,15 @@ static const struct acpi_gpio_mapping quickspi_gpios[] = {
  * @func: ACPI method's function number
  * @type: ACPI parameter's data type
  * @prop_buf: point to return buffer
+ * @buf_size: size of @prop_buf in bytes (0 to skip length check)
  *
  * This is a helper function for device to query its ACPI parameters.
  *
  * Return: 0 if successful or ENODEV on failed.
  */
 static int thc_acpi_get_property(struct acpi_device *adev, const guid_t *guid,
-				 u64 rev, u64 func, acpi_object_type type, void *prop_buf)
+				 u64 rev, u64 func, acpi_object_type type,
+				 void *prop_buf, size_t buf_size)
 {
 	acpi_handle handle = acpi_device_handle(adev);
 	union acpi_object *obj;
@@ -94,10 +96,15 @@ static int thc_acpi_get_property(struct acpi_device *adev, const guid_t *guid,
 		return -ENODEV;
 	}
 
-	if (type == ACPI_TYPE_INTEGER)
+	if (type == ACPI_TYPE_INTEGER) {
 		*(u32 *)prop_buf = (u32)obj->integer.value;
-	else if (type == ACPI_TYPE_BUFFER)
+	} else if (type == ACPI_TYPE_BUFFER) {
+		if (buf_size > 0 && obj->buffer.length > buf_size) {
+			ACPI_FREE(obj);
+			return -ENOSPC;
+		}
 		memcpy(prop_buf, obj->buffer.pointer, obj->buffer.length);
+	}
 
 	ACPI_FREE(obj);
 
@@ -129,7 +136,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_INPUT_REP_HDR_ADDR,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->input_report_hdr_addr);
+				    &qsdev->input_report_hdr_addr, 0);
 	if (ret)
 		return ret;
 
@@ -137,7 +144,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_INPUT_REP_BDY_ADDR,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->input_report_bdy_addr);
+				    &qsdev->input_report_bdy_addr, 0);
 	if (ret)
 		return ret;
 
@@ -145,7 +152,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_OUTPUT_REP_ADDR,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->output_report_addr);
+				    &qsdev->output_report_addr, 0);
 	if (ret)
 		return ret;
 
@@ -153,7 +160,8 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_READ_OPCODE,
 				    ACPI_TYPE_BUFFER,
-				    &qsdev->spi_read_opcode);
+				    &qsdev->spi_read_opcode,
+				    sizeof(qsdev->spi_read_opcode));
 	if (ret)
 		return ret;
 
@@ -161,7 +169,8 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_WRITE_OPCODE,
 				    ACPI_TYPE_BUFFER,
-				    &qsdev->spi_write_opcode);
+				    &qsdev->spi_write_opcode,
+				    sizeof(qsdev->spi_write_opcode));
 	if (ret)
 		return ret;
 
@@ -169,7 +178,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_IO_MODE,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->spi_read_io_mode);
+				    &qsdev->spi_read_io_mode, 0);
 	if (ret)
 		return ret;
 
@@ -184,7 +193,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_CONNECTION_SPEED,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->spi_freq_val);
+				    &qsdev->spi_freq_val, 0);
 	if (ret)
 		return ret;
 
@@ -192,7 +201,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_LIMIT_PACKET_SIZE,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->limit_packet_size);
+				    &qsdev->limit_packet_size, 0);
 	if (ret)
 		return ret;
 
@@ -205,7 +214,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_PERFORMANCE_LIMIT,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->performance_limit);
+				    &qsdev->performance_limit, 0);
 	if (ret)
 		return ret;
 
@@ -215,7 +224,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_ACTIVE_LTR,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->active_ltr_val);
+				    &qsdev->active_ltr_val, 0);
 	if (ret)
 		return ret;
 
@@ -223,7 +232,7 @@ static int quickspi_get_acpi_resources(struct quickspi_device *qsdev)
 				    ACPI_QUICKSPI_REVISION_NUM,
 				    ACPI_QUICKSPI_FUNC_NUM_LP_LTR,
 				    ACPI_TYPE_INTEGER,
-				    &qsdev->low_power_ltr_val);
+				    &qsdev->low_power_ltr_val, 0);
 	if (ret)
 		return ret;
 
-- 
2.47.3

