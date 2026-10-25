Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792964454;
	b=HRh8TjjS7VV/M3zvU5PWI2QzWLhgKeBD9Gghlh08bIRnLuMUfGbiAu+u3S83ThoQvv/C
	 1rWQzbRpGG09ld9b/6Bn9H4f+NawSsn3X3vYh1apNUL5fKCHkxiXT173HcN24D40aC00G
	 YXber5uyyyV/F2XCcAygJWZvzDGetfap91RAM+AoEc52Jl/83TKu3qsOfkMiMIPtwq6gJ
	 B3o9bwn1Be+sHtOVmdn1UOxdRSCQpAbWw7GhIohlVH1CqFSqm4Xj/L+TFeJkcJSTzsdlj
	 qsWoVlLY9ZuelmYeZaR+QL4G6qE1ohxn1HhYKb8HjMYx3bjLhHherR/j+fNL3bTzt1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792964454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Bey6djtXaClvBf7svzpGUE2le4QW4YwIFNTrV6lB9vA=;
	b=a9UjTOazktSuG+jXiCXx/529zaPvnKfhmthRhVjX5MYrOM0oAY6947Z+cvPcT4/sHq+w
	 rkU2951u/nXnZQMMBUHmcHI7f8HpmUZdkZai6VzIFo2E9nExGaiNFiKWQ7mziYBuDlQRz
	 wA8+78Lb3CxsVB0aFzEtoldgNfG/YKRbfY/mcbT8Jk+KQpcsshrJtAC5Y430LzKwtaKgh
	 VT3i3JkjLqgCZILGQsEfpqAGNJdZiKabnOOLRjuHQxC8yftaxudN+Tob4H5LSpufzm8HA
	 1u6gTxE9kK2P0B8BK1d0qAog6lP0NyuXXFblVhjJucc8FAk6cKoLvaq5y9qe+whqXcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dw7TGTWV;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D35606A31A
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 21:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2D35606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dw7TGTWV
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so13504015e9.3
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792964452; x=1793569252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bey6djtXaClvBf7svzpGUE2le4QW4YwIFNTrV6lB9vA=;
        b=Dw7TGTWV4KUsbBwGc9/qy/lMLb4YXbjqi58karSBfxeSYC9CsuzZi6VGAxYsBoaJZM
         QnUagw3gcmpipuDtVG1IKLY96PHwE3KrswG7+T7V3QkOuCy2l5FaXhgTevJLPKzB4GEf
         ZuSsosA2UCv1hvVxRbB+H0n1JBMQyC3/Iry3C9Y3Qdim7XAFzG2x/p079qTT6eCr+B3E
         KvTtOhG246fYvyxTFQVf4n95hcWDVo4O01gOhOhGXdx1c8HqYi7MgLj9a5zYhlNAx887
         sMENcIb5x6Jj1eJRtJoM7lw2Xut971lswNJczMYGjrJuWIUFFL/hci9jEP1ME2ASBeZL
         Btmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792964452; x=1793569252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bey6djtXaClvBf7svzpGUE2le4QW4YwIFNTrV6lB9vA=;
        b=yNUSCaq/Tr0D7jiJCqhwcjyLArf/nLZSJHzNZYH0AgHmIJRkCWI95xlzxWVBRVl3Kx
         RFhernOWnrPelEENq7QocGM6CiqIcM0Brt1RGIw2GQY/QsMKPckQ5N+wh5RQnOq9EDlT
         mwFqhe/GBBE9vNTy+4hJQCtHspQJxi2XxhCw+ROD5NfDMFL3gu2aIUtVDFPZpDS3I7r0
         LBsAaJ0Gc54XD/0w9qMAWBN+xgtoK9udyC8cuxNWuNN1gjgagOf6uKuX0n+meZY+cACG
         KHe0vadT6Fkfl781bhY0yiavXJJP3Vf0vYD8DXUfYjdHf8tf0R22LT52jdsg356SMxhL
         Cz7A==
X-Forwarded-Encrypted: i=1; AKwUvBwsVa17kFMRl1r3HkIqyqE91dlMCMEM5+mde1yh6CW88QjHoAcrWrE9STZ1Vv66z1q9iwpjZlU=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2veWTL3oSt4jTbP7NwxuD4dZ7awrfsMxxkW8ZMjGDLljI+iO2
	XEZ+eQgYfXu7FsZIR/bUnEQfawoKXema4CO0awNiHs/xCEWzStOoVZo=
X-Gm-Gg: AYBFou0F43EiC30zgy+qOc19GiPfy3EWDRMU3BcRtoqnmNAO9pDkHWvwRJyTGBHJiBp
	zYh+efnhZ6oajZu+oJFFdt/AwkXdh4lvGwyOJf4GYeZ5w7t3AXeWVH7jySnurksvS/cQw2dScTX
	juO5/SPqBx5NpQvQf/c+UuRqbinJj3fAHlOxPiT6FNJjy/LaY51q+F0Ycf98GCxyd/qU4EvHIoA
	OZrtd/wAUsJrBOa74hRvdOuWQKZIz2y2JSO4xkj9n6jocFAVeSgWGKcumR5x7xuEObjl0A4esMG
	t7z5SIHBNV3LAjmKoaCC8q3DtHnP5S1mKIuy0QC5c4lMc3TarnQFBTXCJIAnJb98ueds8Ghbg9E
	f4HcSYBG6jjVyb6qHJJ14h5ky4hXwUmgiW8qFzMZRHDiBSVZ1qoI6a+8G5EBtbpbXc5sKLaibGb
	mT526HYKc+Z0sRy567zA7XA0JlfoMQ1vClXKrQAK9u8qJo2bJG50dHvv/y6Jz1Zbd593Osc2d0m
	vX/O0RSWaP4PUbDFJJIrkMVu/y6bVHwVENFUA==
X-Received: by 2002:a05:600c:8b78:b0:4a5:dc5d:20f7 with SMTP id 5b1f17b1804b1-4a5dc5d2382mr30369105e9.14.1792964451903;
        Sun, 25 Oct 2026 14:40:51 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359fbb725sm145762685e9.0.2026.10.25.14.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 14:40:51 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org
Cc: even.xu@intel.com,
	xinpeng.sun@intel.com,
	stable@vger.kernel.org
Subject: [PATCH v3] HID: intel-thc-hid: validate ACPI buffer length before memcpy
Date: Sun, 25 Oct 2026 21:40:50 +0000
Message-ID: <20261025214050.839232-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261024205850.4051206-1-tristmd@gmail.com>
References: <20261024205850.4051206-1-tristmd@gmail.com>
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

The QuickI2C and QuickSPI ACPI helper functions copy firmware-returned
buffers into caller-provided structures without verifying the buffer
length. Malformed or short ACPI tables could cause an out-of-bounds
read from the firmware buffer, and oversized responses could overflow
the destination struct.

Additionally, quicki2c_acpi_get_dsd_property() does not validate the
returned ACPI object type before accessing buffer fields, and does not
free the allocated ACPI buffer on the success path, leaking memory on
every call.

Add a buf_size parameter to the ACPI helper functions and reject
responses larger than the destination buffer. Accept shorter responses
to handle firmware that returns buffers without struct tail padding
(e.g. ISUB tables returning 177 or 145 bytes for a 184-byte struct).
Zero-initialize caller stack structures so fields beyond the firmware
response length are deterministic. Add the missing type check and
kfree to the DSD helper.

Fixes: 5282e45ccbfa ("HID: intel-thc-hid: intel-quicki2c: Add THC QuickI2C ACPI interfaces")
Fixes: 7cb06f08ef13 ("HID: intel-thc-hid: intel-quickspi: Add THC QuickSPI ACPI interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
- Add missing @buf_size kernel-doc for all three ACPI helper functions
  (quicki2c_acpi_get_dsm_property, quicki2c_acpi_get_dsd_property,
  thc_acpi_get_property) to fix W=1 and scripts/kernel-doc warnings

Changes in v2:
- Use overflow-only check (>) instead of exact-match (!=) so firmware
  returning shorter buffers (e.g. 177 or 145 bytes for 184-byte ISUB
  struct, or 1 byte for 4-byte SPI opcode) is accepted
- Zero-initialize caller stack structures for deterministic behavior
  with short firmware responses
- Add missing type validation and kfree in DSD helper
- Add braces per coding style
 .../intel-quicki2c/pci-quicki2c.c             | 42 ++++++++++++++-----
 .../intel-quickspi/pci-quickspi.c             | 37 +++++++++-------
 2 files changed, 54 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 7a913f717efaad..b2246c6eaa98de 100644
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
 
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index 53023e30cf8d47..9b369d289fa81f 100644
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

