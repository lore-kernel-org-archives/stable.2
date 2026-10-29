Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283044;
	b=c8n9fZw28mPTu4tBG4dlRhhiqsVN7BBBJh8Gv7kVkUhc59DKPK50lsCyQx6Tp4Bn0JpC
	 gEKQNcy7/Er/bsordNuzafmLCAhAMv0vucuoybPhztydJk5XdvuUAwiKhGQLNMkj2Ew2O
	 LzxxHRzfvE0CqT9IBakTGrb/6nDM1dtlODtdYZgAr7Xm4xcAuBhZCXohUVujrC+2QqDzf
	 vUM9Qt51F//JRsRKv2NnEiwIsd5N0GdNt5e4+1UEWzPEzJO9jVIMSRxRBw1S/Rzh9uKlN
	 6IIljoGtiwpulg6ttc2W4abzuOFTUXS/x26FukZfzA1/7EbIJISSZ5C5cCTSLZjQnuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xc6n99y9y5gEVHXt77Y/MFsVaEauHKe2nOyEzoQcsEw=;
	b=HLlk2H5q5s+vGoPSQ6jwFvZxxybfBd/frnH9IngHNbXFRvlwSf2E7azPznj9itphHCwB
	 dgOyGBRyEY8dguO7NnKQOuCyQmbv0lV8ObrmKFK1OFvsOalb6pTMaicRfwzAA3oW9jmtP
	 eN+mN0IYwgl59qYFmlv1Za8hFcYQ4ZCQlBdnFunXoiaf5O5CIAdIByziqXa2tVbNbkcv9
	 8Riw7gaZhj0alqBr0bKlmbRE0YROB76agmywT3FNUR6SdoQuBfSWLm5hMUtzGEfEemtg2
	 Y3KDZn+8YkoTxdI727Jx1PF0TkAeTpQ4cRa3vy4pWJ9NQeJmDaM225OMfx2yVWZvMPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VW8kz1H4;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1A9606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B1A9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VW8kz1H4
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e0d885929so1682170f8f.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283043; x=1793887843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xc6n99y9y5gEVHXt77Y/MFsVaEauHKe2nOyEzoQcsEw=;
        b=VW8kz1H4rosAwuqeCu3PNQEemOI5MIvP5O/vzEbA7WspgqNyjIBuVDy06znbnYFi+6
         gEZ+Un9MzabvXZoPsv/vqMz8FVbFGPL/2U3+2RHwjB9lGHcJcl7H6j8QUX6jUcDNm5nG
         O5G7QW0OnMYVIPKxRHLiA1PMSuhtY/MmG6XoeFnXceNAGXqBVMEAGe7ipuwkoxmz2dbZ
         Onaek0nMPSPeHJ/M0TX6pyQRpZSsv6lTkX1LtPmtkYl+7NUirW7j8oadFKVlcu8rJL3U
         J9CCfsCse2f8DbgJF8HUHzURel9hX2XXypOi/rlKsA5LfBbey/nAWZpkxvr+Xo/C627+
         KHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283043; x=1793887843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xc6n99y9y5gEVHXt77Y/MFsVaEauHKe2nOyEzoQcsEw=;
        b=tfrM/2l5pvP8MCQFxWyrdNSWsO19hNAEO4g9sjYoJ6HVtaD880fExLyVqdLJE76EUY
         7zZVsh3LS3I9L5v/YreDqrSmCW3PzI6TdSUTFljWypI5AGBUrj2sfQwqdurAj8ONWlfr
         Nsnhz48V0ZDNIoKuiPe6iQ9gtVaCsp/aZaFOCGjfYWMK8EE3Xh5HecUOajgagKqBZ+k8
         Uw1vVcpFBh3hq8ZN2hvwNZPHdawoiVN/tengClJI6bSjcOSwjBtUjGQQdQ0zwcGiYunI
         hUGR7pwEuU1Ptrhmx6CdmZGYxKJBuF01rk3qDosVuuSH5UYjNLe+mRr92+bZAk0rqDyO
         rbMQ==
X-Forwarded-Encrypted: i=1; AKwUvBx2+ctqEdLXlW9csieLLFI+6vpV/AU6BT65zdquQI2toljPODpx4peqCEANioTdZbGekSpg6oI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKl183HJBiST+lpkbXvA5jSyL75uiC9WqLk8BzwN79sSVzI8GRi
	Ct+a2iWZuWV3M9Sbm8BDJoqnwsJG0TlkWptzbb6O4yIMaVarMUTkSxM=
X-Gm-Gg: AYBFou04SfgfXYtcV2Ld49Jcbd/iCz0O4mS/aA7deK/wWRFqwlfCSe80n994G8STLTs
	BOaUch0ao/081VW7T7l2Rwado8ml5+4hI46CsmtaxkMbMcRNXYnwSuiRxAC0ZSfYkeHHRAStABB
	7EGcwS60/wFdVlClIf9YLVnkU2izO0yaqoFu+Z/1GcmlXvXAjhzP6v/kvDgfYUUwj8SP/wuaUIB
	8vUyDPeb7OWht2S6GLKb3fvReJrw3mIq2AxyYurykHf+jB7Opw4sxf8N/xRMZhLm8RMawAlh33G
	+WaKTwsKQT9ywbBi5k0olU2Hs92zMNA0QyyNsOlPKl4xeilIs1e3Tp20JfVuZq5vCNgRXc8F1sl
	2t/aPzykWa89Z4ApGKV2oqsJ9l6XV2ru/OlTl1GmIKpPd5FhYdq2XWU9z7e9ta0LSxcr8qHSjYH
	bmThslo257knfNQbGCoLWAWzJRy765pIeireOvplq1XOvsjZPvfKmzzhq+ZNevwcOOKkM1kMoZ6
	Eaw9+aziO+tmsWaxgw7JWBtYBcLDtR2018ThjL5mbGtlbnmoO8Fl9L8t3G6pMgmV95jc9P5vNg=
X-Received: by 2002:a05:6000:24c7:b0:487:88b:4681 with SMTP id ffacd0b85a97d-48e5d2e4a09mr13667590f8f.10.1793283042236;
        Thu, 29 Oct 2026 07:10:42 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3932sm35906848f8f.18.2026.10.29.07.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:10:41 -0700 (PDT)
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
Subject: [PATCH v3 2/2] HID: intel-thc-hid: quicki2c: validate ACPI buffer length before memcpy
Date: Thu, 29 Oct 2026 14:10:36 +0000
Message-ID: <20261029141037.2655603-3-tristmd@gmail.com>
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

quicki2c_acpi_get_dsm_property() copies firmware-returned ACPI buffers
into caller-provided structures without verifying the buffer length.
Malformed or short ACPI tables could cause an out-of-bounds read from
the firmware buffer, and oversized responses could overflow the
destination struct.

Additionally, quicki2c_acpi_get_dsd_property() does not validate the
returned ACPI object type before accessing buffer fields, and does not
free the allocated ACPI buffer on the success path, leaking memory on
every call.

Add a buf_size parameter to both ACPI helper functions and reject
responses larger than the destination buffer. Accept shorter responses
to handle firmware that returns buffers without struct tail padding
(e.g. ISUB tables returning 177 or 145 bytes for a 184-byte struct).
Zero-initialize caller stack structures so fields beyond the firmware
response length are deterministic. Add the missing type check and
kfree to the DSD helper.

Fixes: 5282e45ccbfa ("HID: intel-thc-hid: intel-quicki2c: Add THC QuickI2C ACPI interfaces")
Cc: stable@vger.kernel.org
Reviewed-by: Even Xu <even.xu@intel.com>
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 .../intel-quicki2c/pci-quicki2c.c             | 42 ++++++++++++++-----
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 2537288b50261..064195b7f4669 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -56,13 +56,15 @@ static const struct acpi_gpio_mapping quicki2c_gpios[] = {
  * @func: ACPI method's function number
  * @type: ACPI parameter's data type
  * @prop_buf: Point to return buffer
+ * @buf_size: Size of @prop_buf in bytes (0 to skip length check)
  *
  * This is a helper function for device to query its ACPI DSM parameters.
  *
  * Return: 0 if success or ENODEV on failure.
  */
 static int quicki2c_acpi_get_dsm_property(struct acpi_device *adev, const guid_t *guid,
-					  u64 rev, u64 func, acpi_object_type type, void *prop_buf)
+					  u64 rev, u64 func, acpi_object_type type,
+					  void *prop_buf, size_t buf_size)
 {
 	acpi_handle handle = acpi_device_handle(adev);
 	union acpi_object *obj;
@@ -75,10 +77,15 @@ static int quicki2c_acpi_get_dsm_property(struct acpi_device *adev, const guid_t
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
 
@@ -91,13 +98,15 @@ static int quicki2c_acpi_get_dsm_property(struct acpi_device *adev, const guid_t
  * @dsd_method_name: ACPI method's property name
  * @type: ACPI parameter's data type
  * @prop_buf: Point to return buffer
+ * @buf_size: Size of @prop_buf in bytes (0 to skip length check)
  *
  * This is a helper function for device to query its ACPI DSD parameters.
  *
  * Return: 0 if success or ENODEV on failed.
  */
 static int quicki2c_acpi_get_dsd_property(struct acpi_device *adev, acpi_string dsd_method_name,
-					  acpi_object_type type, void *prop_buf)
+					  acpi_object_type type, void *prop_buf,
+					  size_t buf_size)
 {
 	acpi_handle handle = acpi_device_handle(adev);
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -113,7 +122,16 @@ static int quicki2c_acpi_get_dsd_property(struct acpi_device *adev, acpi_string
 
 	ret_obj = buffer.pointer;
 
+	if (ret_obj->type != type) {
+		kfree(buffer.pointer);
+		return -EINVAL;
+	}
+	if (buf_size > 0 && ret_obj->buffer.length > buf_size) {
+		kfree(buffer.pointer);
+		return -ENOSPC;
+	}
 	memcpy(prop_buf, ret_obj->buffer.pointer, ret_obj->buffer.length);
+	kfree(buffer.pointer);
 
 	return 0;
 }
@@ -129,8 +147,8 @@ static int quicki2c_acpi_get_dsd_property(struct acpi_device *adev, acpi_string
 static int quicki2c_get_acpi_resources(struct quicki2c_device *qcdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(qcdev->dev);
-	struct quicki2c_subip_acpi_parameter i2c_param;
-	struct quicki2c_subip_acpi_config i2c_config;
+	struct quicki2c_subip_acpi_parameter i2c_param = {};
+	struct quicki2c_subip_acpi_config i2c_config = {};
 	u32 hid_desc_addr;
 	int ret = -EINVAL;
 
@@ -145,7 +163,7 @@ static int quicki2c_get_acpi_resources(struct quicki2c_device *qcdev)
 					     QUICKI2C_ACPI_REVISION_NUM,
 					     QUICKI2C_ACPI_FUNC_NUM_HID_DESC_ADDR,
 					     ACPI_TYPE_INTEGER,
-					     &hid_desc_addr);
+					     &hid_desc_addr, 0);
 	if (ret)
 		return ret;
 
@@ -155,7 +173,7 @@ static int quicki2c_get_acpi_resources(struct quicki2c_device *qcdev)
 					     QUICKI2C_ACPI_REVISION_NUM,
 					     QUICKI2C_ACPI_FUNC_NUM_ACTIVE_LTR_VAL,
 					     ACPI_TYPE_INTEGER,
-					     &qcdev->active_ltr_val);
+					     &qcdev->active_ltr_val, 0);
 	if (ret)
 		return ret;
 
@@ -163,12 +181,13 @@ static int quicki2c_get_acpi_resources(struct quicki2c_device *qcdev)
 					     QUICKI2C_ACPI_REVISION_NUM,
 					     QUICKI2C_ACPI_FUNC_NUM_LP_LTR_VAL,
 					     ACPI_TYPE_INTEGER,
-					     &qcdev->low_power_ltr_val);
+					     &qcdev->low_power_ltr_val, 0);
 	if (ret)
 		return ret;
 
 	ret = quicki2c_acpi_get_dsd_property(adev, QUICKI2C_ACPI_METHOD_NAME_ICRS,
-					     ACPI_TYPE_BUFFER, &i2c_param);
+					     ACPI_TYPE_BUFFER, &i2c_param,
+					     sizeof(i2c_param));
 	if (ret)
 		return ret;
 
@@ -180,7 +199,8 @@ static int quicki2c_get_acpi_resources(struct quicki2c_device *qcdev)
 	qcdev->i2c_config.target_addr = i2c_param.device_address;
 
 	ret = quicki2c_acpi_get_dsd_property(adev, QUICKI2C_ACPI_METHOD_NAME_ISUB,
-					     ACPI_TYPE_BUFFER, &i2c_config);
+					     ACPI_TYPE_BUFFER, &i2c_config,
+					     sizeof(i2c_config));
 	if (ret)
 		return ret;
 
-- 
2.47.3

