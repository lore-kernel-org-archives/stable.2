Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F70374190
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785613029; cv=none; b=T3pvRwGZMVQofVl7wRR/U6bBu8siu4oK09jamMRx6hMvLYYVzALTNZUlZewfMDFJ4WAPExnHWtazUqFDwROIOBhOae7r5FRV0JZYsm/U6tkHQaNMkzWYEeDHWJeKCiHjV9N9ETu7QZt/YWI9l/HsM8+vhH2RDSE7jprkzSgWGqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785613029; c=relaxed/simple;
	bh=wAj8JaFRhBUgHCCzKMI5KnjYQwsnchef6V3NCmE0v+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gp1XbukcSksDfO3t2fVmgCJBI1rZkRnzxAhB2D7/RFRFWnISD6ATvENVuxIBWOKK9le1LZw+WNkC8ywTTMz18riVumzFXvvNs65ijtmORiaODErnF5A3RC+29ordAeQjaNsZ/uvrKA5cQXxLmLTpcCECzakUeJ8vXvpmQovx3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rpzu0BDu; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rpzu0BDu"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so1839793b3a.3
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 12:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785613028; x=1786217828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J0Mm4VFPxuz6DlppF/PVGQY5b2FJs3BtOYyEAOnWBOk=;
        b=Rpzu0BDuxhw1oID6ARidXmHAnaRGMf4xOYBLtqqxJxb5mqv4FxbVqIHZW9Mx5L3N/z
         +XVDPqKYjMyxSIAifzF8bCybvT4nFOhbaHNhmu9vwyhz973WKZomcOHVlqr7xshj5LYb
         rwfP0h/1uVTKIGIdcUBYB3aap5vSxvtC2BYPv19absMdeAxi2IsTlVcdhZDsxYbMHDuJ
         6PgPMh89CtmPjd0A6/HiSoGEGc7smeEw7x7FW/w2SmJTEocQDMPEQOzqgEuykjnhWdbX
         VCrjYaJURrSeBXm+EVYYO8QFJqsjumS6kd7OwovJSemix4R3NvSYJUlwPfiNVW1qzW91
         a50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785613028; x=1786217828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J0Mm4VFPxuz6DlppF/PVGQY5b2FJs3BtOYyEAOnWBOk=;
        b=Y4OXk6bPp6SW4H24bhLc/mYxrM7tsSDj2z4nGGhXu+SwO3fAslUo8wRn1KXX3ILiqc
         JmkiXVCVCfKetZe9jtYClqjBlptS1diw7RaAVNlfcDVNQZBCls6RidFGtGR8ivicuGoJ
         PfJr++JCDFiuK/QMRKBy8yu/9/8e0+Gvlefk2qoIF8af13OFYvxzmcy593pkY3Bx/SOW
         kqMgoNyDbrGrq09qx1Di2HkUhxh+u0f42rIx+GsT7a62bgvzcr46iGfFrP6K8wA/2w1i
         thTeJ8WUazUJ+QVSgWaXuIFWyX1Pm8FCNM4slSNEHmRDn6cU07RWtXRTYOeoUPhuETYc
         bF1w==
X-Forwarded-Encrypted: i=1; AHgh+RrfNUfg7BFYxAkXKWc+ccALgR6girf3o8EwRNitLda4UGdqdeNx6Yr4QuCNmESpWuGxjltoGUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytWxB+ozj3YlM3cJgsOoOcfWEhkk4myzAS8zArz3usbO94imSx
	3FBipRPW+d0+bphTGpVgjiKorAnwzCE06tZO+zohgjpnAAHfn1FOKqbM
X-Gm-Gg: AR+sD13AJZ4TklTqWdqaV4i9wBYlNvNYVIoNQs1klsbK9XxaDEk6VROlLZh3M08A0UA
	6NkNFbl7RubF6Jz7AdUPr5lpK5XBgh2fQ/ys/x8c9OtowgQGKf/CzcjniV3juC33lZH1VjwH54F
	G7rX5tYAXVqHDZw1mcUjCvsKdnkbyGbTN1SMOS7ZfgLnNPIU5PrAKSyNTQ1CTo/f/sm7l2+Y0NO
	9/9+RCv84I78miH+qRsqtY8GiT5HnJKzHA3A+c+Q17BajietzLNDpnVrTs1l2tzFuk4T3m6rl4s
	6y2q/hZ4PiEfT4aAXEexmjDeotoEileKouEDaa+674fltK9lVxneEGNejDPlaI4IgO0sb6PYni9
	RgqEKf8R6/Bx+xpClJToEGbtUAn3kN63isGpbpolHb8yA+DVZ0rSw1ptx08qHOYFrlpWbP/NYTf
	qtFBvx9BoSqlt7+inlkZH3cq3GtG21RzB7jbCUeii9w51KUwp5UlHUadpLoQxaE7I8K29CdcWNq
	cW/TzVkqAhEJXSMRajY2ZrRPxPnjzQScAVMwCYMjaMCRs6ov0faWKFbXEC3Op/2Mn4HdyVlHauv
	STqSYLF4jLgMXTWjEo/zMSDYztuVVA==
X-Received: by 2002:a05:6a21:9cca:b0:3c6:3c5b:f2e1 with SMTP id adf61e73a8af0-3c92a857315mr4522356637.32.1785613027720;
        Sat, 01 Aug 2026 12:37:07 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:9d5b:7865:f907:f2bf:8664])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab050d8csm29842414c88.0.2026.08.01.12.37.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 01 Aug 2026 12:37:07 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	shuaijie wang <wangshuaijie@awinic.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] iio: proximity: aw96103: validate firmware data length
Date: Sun,  2 Aug 2026 01:22:00 +0545
Message-ID: <20260801193700.57457-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware parser reads a length from the binary header and then uses
it to walk six-byte register/value entries. A truncated firmware image
can make the parser read beyond the copied firmware buffer. A value
smaller than the four-byte count field also underflows, producing a very
large length.

Read the little-endian field with get_unaligned_le32(), as previously
proposed by David Lechner. Validate the header size, reject an
underflowed length, ensure the resulting payload is contained in the
firmware image, and require it to contain whole register/value entries.

Fixes: 07b241262dca ("iio: proximity: aw96103: Add support for aw96103/aw96105 proximity sensor")
Link: https://lore.kernel.org/r/20260314-iio-proximity-aw96103-fix-firmware-read-v1-1-c74fe9ccd82b@baylibre.com
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/iio/proximity/aw96103.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
index 8fbb755dc..8352d51e5 100644
--- a/drivers/iio/proximity/aw96103.c
+++ b/drivers/iio/proximity/aw96103.c
@@ -24,6 +24,7 @@
 #define AW96103_BIN_VALID_DATA_OFFSET		64
 #define AW96103_BIN_DATA_LEN_OFFSET		16
 #define AW96103_BIN_DATA_REG_NUM_SIZE		4
+#define AW96103_BIN_REG_SIZE			6
 #define AW96103_BIN_CHIP_TYPE_SIZE		8
 #define AW96103_BIN_CHIP_TYPE_OFFSET		24
 
@@ -229,14 +230,27 @@ static const struct aw_chip_info aw_chip_info_tbl[] = {
 	},
 };
 
-static void aw96103_parsing_bin_file(struct aw_bin *bin)
+static int aw96103_parsing_bin_file(struct aw_bin *bin)
 {
+	u32 data_len;
+
+	if (bin->len < AW96103_BIN_VALID_DATA_OFFSET)
+		return -EINVAL;
+
+	data_len = get_unaligned_le32(bin->data + AW96103_BIN_DATA_LEN_OFFSET);
+	if (data_len < AW96103_BIN_DATA_REG_NUM_SIZE)
+		return -EINVAL;
+
+	bin->valid_data_len = data_len - AW96103_BIN_DATA_REG_NUM_SIZE;
+	if (bin->valid_data_len > bin->len - AW96103_BIN_VALID_DATA_OFFSET ||
+	    bin->valid_data_len % AW96103_BIN_REG_SIZE)
+		return -EINVAL;
+
 	bin->valid_data_addr = AW96103_BIN_VALID_DATA_OFFSET;
-	bin->valid_data_len =
-		*(unsigned int *)(bin->data + AW96103_BIN_DATA_LEN_OFFSET) -
-		AW96103_BIN_DATA_REG_NUM_SIZE;
 	memcpy(bin->chip_type, bin->data + AW96103_BIN_CHIP_TYPE_OFFSET,
 	       AW96103_BIN_CHIP_TYPE_SIZE);
+
+	return 0;
 }
 
 static const struct regmap_config aw96103_regmap_confg = {
@@ -500,7 +514,7 @@ static int aw96103_bin_valid_loaded(struct aw96103 *aw96103,
 	int ret;
 
 	for (i = 0; i < aw_bin_data_s->valid_data_len;
-	     i += 6, start_addr += 6) {
+	     i += AW96103_BIN_REG_SIZE, start_addr += AW96103_BIN_REG_SIZE) {
 		reg_addr = get_unaligned_le16(aw_bin_data_s->data + start_addr);
 		reg_data = get_unaligned_le32(aw_bin_data_s->data +
 					      start_addr + 2);
@@ -550,6 +564,8 @@ static int aw96103_para_loaded(struct aw96103 *aw96103)
 static int aw96103_cfg_all_loaded(const struct firmware *cont,
 				  struct aw96103 *aw96103)
 {
+	int ret;
+
 	if (!cont)
 		return -EINVAL;
 
@@ -561,7 +577,9 @@ static int aw96103_cfg_all_loaded(const struct firmware *cont,
 	aw_bin->len = cont->size;
 	memcpy(aw_bin->data, cont->data, cont->size);
 	release_firmware(cont);
-	aw96103_parsing_bin_file(aw_bin);
+	ret = aw96103_parsing_bin_file(aw_bin);
+	if (ret)
+		return ret;
 
 	return aw96103_bin_valid_loaded(aw96103, aw_bin);
 }
-- 
2.51.2

