Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6144248A1
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414037; cv=none; b=qAbxObmsqrPFwF4pImzu9f4eNkIoylDGHcOxSoU9FRXREiya1S1cmRQzYptSHIRzmRP4vT2M3VTUlhn2hgPmUDQWdy6AN0uQSAja/zt8tvoRzEcley1T9PqP9ibUBiRAAUoWtT23npkNq/gEw8CBydrD75JEEwQvzbwulQE4Cdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414037; c=relaxed/simple;
	bh=gRGySUQgCN6HTBJuP6J5a+XBQJj7MDX6z+ieHVbFzTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bmp8DlyR7AiYwLH6YGFaEkwQcc/X82kIXDj5t9/oxfZxPzOTNIwa/OML5Sjod3DsAM4/hcl/uFSdZHFm9qIi8MWr1PlMsBU5u9T5MtRjXnu5+FrTK7PX0YLXnkpmtfeGZhZmP/ZS4J8+4MFoiIJaYewHEJHsDx3Iu76p7MsGX/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O11NHvGj; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O11NHvGj"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c998fd549a8so1406383a12.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 05:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785414035; x=1786018835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+mFQjefOe6oMqkkHRip9h5eiVqU+Xd9obx5gLjx4osg=;
        b=O11NHvGjs4dKQBx7d2Y/YUHEQqG7mYFTMUPqz5h7HRKhxq61lGmHzzeBqwKipuJi5w
         H52Jxr+EUOflNK4Ek1iUBul6df07ICeffTfYFSjNS/qCOXMkbTYH2rSodTd+jixRQlUU
         iWIyUN3g4+Gsd2yBx0AtXNljga6Hc2jzuGCbdr1wcfI6heHCFqADdaPEUFu90G7jiPXc
         WUcStnnenONCPyybcjen9GJclY/GYw/OSnxN6LuY8MVujWgaIGpZUCiX/6GJHoK1qW/l
         zkI72REDvu7qvkz1ZS3yLP/FhIP+VQ5ZzqB7i+CE6oPE7YGDLajxyr1yNxkCQbm0/54l
         Rsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785414035; x=1786018835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+mFQjefOe6oMqkkHRip9h5eiVqU+Xd9obx5gLjx4osg=;
        b=d47lRbK4lGgaMbPCPgUdODYKuMNvJ/GyFPDodE6LrIHYz9rwWXOhYW3t8+GWctUNJy
         kISL8yoBlK67fyQCGV/rXwsclEwh7E7C+PXMDeW+7v5/vp3Q9i+TnTNXruYZtfL+LFxH
         v3uMUlg0HRpg9rueCUSVa4TT3NQLQXZ6xQAubhgDK8l/EfA+2BY4pYjnirMJqKvpGROR
         j4M9/N3565OdvQV/PlU4eqb47RHwc7GkitWGJWISTRl5aVlE+1Ah4i1k/Bd0JNRsRtXJ
         BtOjpJEXV4NoX0o8P33PMh6ZjCGp3oSkardcbcUxIrjkAS2Ic50SnAmU9yV/GHQmoyqi
         iRTg==
X-Forwarded-Encrypted: i=1; AHgh+RrYsg+OJUqzIbpI3k4uDg+UFFVLP4gALYWLrZqR/e/z2HvkPAW5ZLu+tpHRKdzGoNRx/1WZAxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu7K7B/kI94Q2l7MMWDNRYb/TyEbP1SHmqi9mOnG/TNqiYeUut
	qexqhhMP2spuGc3zUJyil/PbHekuRYElCu2K1Nufguh+v1+LKoZHmm7A
X-Gm-Gg: AR+sD10rGBQAj+hi7HgUFPmj8RnAcd8sfjHSqq40Pjs7eXWh2+2HJv+0ktSN65PqXyM
	oSoMEu9KmbCsjfJB4gkbEFT4J5MW6Dz7+SER40o58ItvUVnyZtpSlj211lqIUw0V317Fphgu/b4
	hkrpC0HetwwGbe//yj9rauWxbfQw+Bl5I5Z+KMfPWY5XrKEakTL7L4lnA4e1g0EtLA00VTEQzp3
	sx3coYywXYPDdN0MMyrXgw1cJHkkitkpQiRi2t+MmvC+N1umMnFYlZGF4ct3BO/WMWvHgeI0qG7
	5QDn7OCacAfD9Iuo/xwEQotr5le6JHiEXNVFYejJAcQj+jaK/9xUtg3jheH4EMf7FVGvY6iUOL/
	ZU/s1fcQ+2JyM6WwMwn4MxIC0Sk+ItsbqOoqBKUZPJixgswAO3O4nfXSXHr1L3gGD/hpHbP7jE5
	PpSw4z0JvYDaa14SR+2YWOcq+V7i8SBiIOGhU+TkR7TPkqdsEeQ/Y26AwZRoWxmTwoUZPPgYz5C
	/xphE8MOG8K4bVX5zAEz1wVlufW1jzvw42pUCFnShLE+mIjn/mdMCocX3CfWackEQJk1P+AFPDm
	MQ9WWjk=
X-Received: by 2002:a05:6300:4045:b0:3bf:49c8:f7b with SMTP id adf61e73a8af0-3c900465733mr2543213637.13.1785414034864;
        Thu, 30 Jul 2026 05:20:34 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504dd42a9sm24944127eec.30.2026.07.30.05.20.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 05:20:34 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: yang.li@amlogic.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_aml: validate firmware segment lengths
Date: Thu, 30 Jul 2026 18:05:28 +0545
Message-ID: <20260730122028.98159-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aml_download_firmware() reads two lengths from the firmware header and
uses them to build pointers before checking that the header and segment
data are present. A truncated or inconsistent firmware image can make
the driver read past firmware->data while constructing TCI commands.

Reject images shorter than the header and ensure that the ICCM and DCCM
ranges fit within the loaded firmware before downloading either segment.

Fixes: 37bac77e4649 ("Bluetooth: hci_uart: Add support for Amlogic HCI UART")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/bluetooth/hci_aml.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_aml.c b/drivers/bluetooth/hci_aml.c
index 959d9e67b..067fbf278 100644
--- a/drivers/bluetooth/hci_aml.c
+++ b/drivers/bluetooth/hci_aml.c
@@ -247,7 +247,7 @@ static int aml_download_firmware(struct hci_dev *hdev, const char *fw_name)
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
 	const struct firmware *firmware = NULL;
-	struct aml_fw_len *fw_len = NULL;
+	const struct aml_fw_len *fw_len = NULL;
 	u8 *iccm_start = NULL, *dccm_start = NULL;
 	u32 iccm_len, dccm_len;
 	u32 value = 0;
@@ -281,7 +281,21 @@ static int aml_download_firmware(struct hci_dev *hdev, const char *fw_name)
 		goto exit;
 	}
 
-	fw_len = (struct aml_fw_len *)firmware->data;
+	if (firmware->size < sizeof(*fw_len)) {
+		bt_dev_err(hdev, "Firmware is too small for its header");
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	fw_len = (const struct aml_fw_len *)firmware->data;
+	if (fw_len->iccm_len < amldev->aml_dev_data->iccm_offset ||
+	    fw_len->iccm_len > firmware->size - sizeof(*fw_len) ||
+	    fw_len->dccm_len > firmware->size - sizeof(*fw_len) -
+			fw_len->iccm_len) {
+		bt_dev_err(hdev, "Invalid firmware segment lengths");
+		ret = -EINVAL;
+		goto exit;
+	}
 
 	/* Download ICCM */
 	iccm_start = (u8 *)(firmware->data) + sizeof(struct aml_fw_len)
-- 
2.51.2

