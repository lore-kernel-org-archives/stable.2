Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794174129;
	b=YQzpoNmTHMVHas6/A+7UMlD9+jHJYlRP+TfrG+PIEJiMJidcbs/7ckkxKyZlcn/mxYB0
	 SMVUQLT6CKvn95ywtH9NiIhK4gHKQeNHA/9kE/wIQ0H2kEfvZZKaLObrZ2GKcP+mCfISU
	 7B6pbcPAYh9E+LE51ZbKPvVBMoNg0SY2uMgEokHysFn3xw4tXFIFdWvKXUazduSL/6+i0
	 bTGqSLgNO1ty7OigYcmqmQHBpVHavUd7ON9kWAgyvcgxSbW8ZMwARQWTmh4NidpsmIOuw
	 mdQ7XWnfrFsIUXwYdqW2ZoG7d5Ql8TjsUEkqdsPtnXDeeFvj6HvHemSdqZBkSLw2wIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174129;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8Kk/d7GzgC/hK3PJkv8ThG4YGgkIaZqVb9vOlY3hZog=;
	b=Wxra2wDSjOp2mYDKTc8XCEtlz8g+SUa9KVZQHu9/HuA+o9r5fFx3ogDmkgPz2+Rf7OfX
	 ZW9RczCU2aCVD7FzRttHUSjn37Z6OVC59g4OqtMWdMqIWnELR2N6EkzX0TBY2PjDyDBuU
	 +LRUSE6sq8h48FRjTIXnz2k8et2HQftG5LP3SFLrBGH27VQ4dEaWeRmA8JwOorCTvl9ce
	 MK8N0LzxQdGoBOg/Znk6mUgHaRvt4QbgHK5AJPV5OMr89gvQZdwvMY5gjDAq3BC/0Lrv5
	 BvKF8A2chczS/ISFXjttm31HjGfn59/dutuVzW+Vp5cEYrcqOi931fO0+gLYqB8gvSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZCyxE9U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06380606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZCyxE9U
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794174128;
	b=3b8QoQR977FtQzkGDFyVqCPGwlNjZBpwEPQLNTc0oLl+PReiaBETElDipibxwaPZiLrf
	 iX2Y0NOHJ9CggbQ5eMkp8M97eeqwWb0J187yH9HFoQHmT/Sb/f/ZE/xDZAqmYaS8SO4rw
	 YLvIMtjKFgQxjNOrLkBOe6WUaNrtwdIBYQqMz13JMMLWQ+TGOJS+lg50uzPpFgdNyojYG
	 m6qrGwvRjLa4Fribm2DGMYQSZS6cf5M7P521R3OBvfGa2JWm7vMkLCsbyArNY4KPKnOS2
	 zLHRX+tGWvJ5442gd3lOM0whrwckMC369IroichYgMfTqdQysd3nFHZrq3Mvh4FP7ZQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794174128;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=8Kk/d7GzgC/hK3PJkv8ThG4YGgkIaZqVb9vOlY3hZog=;
	b=j1G7/+uqF9xQepXf3MHx25Sq52r5edhqelUmJa7sjKmdPozdGlgWPy9cyzXgPh5cvTVF
	 hRZ0wNgWuXv7J/HfF2cRRV3B/dxjfZoBMoE2sxew7F65tfmAOdgtJarsa7J4yGhHtcC9N
	 mRXaD0m+HzAsemxzEqIiaROqCfbj8rt1IaNHO4RA7McBIcHBf0kxdfmeu+/U/JtJ9TFnB
	 DCu66tdIP+3IBpSwpx1Oj/0dqbUJyH5McomoW9tgupCtWNsOnZV3/tfxAtftY6OXBTXQs
	 o6VwiKopxbWEShCb0/P8mAetMBa2972zsAFLcXVdixB0C3IB3m3L1Dx2b/aCTSw8eGg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EEE701F0089F;
	Sun,  8 Nov 2026 21:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794174128;
	bh=8Kk/d7GzgC/hK3PJkv8ThG4YGgkIaZqVb9vOlY3hZog=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=AZCyxE9Uq45q0GKDR6O70b/fDXnCU/LofCK2hWcqL7jRHqFvUtBdXXET0BUleye+B
	 qI4cL7gTXyAIGNmZZDSWR+f7n3TVo1HbXelNcqDiTfXwx14h/g6mMQEclLYLoWvGKE
	 Gqq92cRLKRqbTr2Lq+Tc4CdSczmXACv2HcEghe0v4GHiQSg7p4U53LiluXZ6ovF+9X
	 2AG+sKC+jpbnOi9N4Cdm8aHdKnywsnHD9Nr1pf6Hu5JOJlteIPILxG3SdJYquLQ4xD
	 p1A72l7WeRgu6bnmNXlYmSC9nnjDiqIcfRasl3XsIvBvTfQZjbJGMOCFhwpmtNuLP/
	 R29PtFUOiZ4dg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 829E348102;
	Sun,  8 Nov 2026 21:42:07 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Sun, 08 Nov 2026 21:42:07 +0000
Subject: [PATCH v2] nfc: s3fwrn5: validate firmware header pointers against
 file size
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-s3fwrn5-v2-v2-1-03727eedd90f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAK7s8GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzNDQwML3WLjtPKiPFPdMiNdAwPDJEuLRKMks8RkJaCGgqLUtMwKsGHRsbW
 1AKOYhpZcAAAA
To: linux-nfc@lists.01.org, joasantonio108@gmail.com
Cc: stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794174126; l=4871;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=StJEC1s1ifhdlkToo02A0GCTkcM4C+mmtWmA3Ip2TVE=;
 b=5Bbrwj8Dmw+tasuC7kJBK42+2NLIGHwHlXJR8TFIzs7nQdeBVtwmNCEh6eUJ8Pj2gguvxvSl9
 a3zqnKjwt2cDmkL2if57TsS5+TOsRP2IQ7hErN2EKQZgT7CGgeUooLc
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

s3fwrn5_fw_request_firmware() reads six offsets and sizes from the
firmware file header and uses them to set pointers and lengths without
checking that they fall within the file:

  sig_off / sig_size       (0x14 / 0x18)
  image_off / image_sectors (0x1C / 0x20)
  custom_sig_off / custom_sig_size (0x24 / 0x28)

s3fwrn5_fw_enter_update_mode() then sends sig_size bytes starting at
sig_off through skb_put_data(), and s3fwrn5_fw_download() hashes and
sends sector_size * image_sectors bytes starting at image_off.  A
crafted firmware file with out-of-range offsets causes heap buffer
over-reads.

Validate that every offset + size pair fits within the firmware file
before setting the pointers, using check_add_overflow() to prevent
u32 wraparound.  Also check that the GET_BOOTINFO response is long
enough before copying boot information out of it, and that the total
image area (including the 16 * 256 bytes per sector that
s3fwrn5_fw_update_sector() sends) lies within the file.

Found by LLM-assisted source review.

Fixes: c04c674fadeb ("nfc: s3fwrn5: Add driver for Samsung S3FWRN5 NFC Chip")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
s3fwrn5_fw_request_firmware() reads six offsets and sizes from the
firmware file header and uses them to set pointers and lengths without
checking that they fall within the file.  A crafted firmware file with
out-of-range offsets causes heap buffer over-reads.

Validate that every offset + size pair fits within the firmware file
before setting the pointers, using check_add_overflow() to prevent
u32 wraparound.

    file size (sashiko); restructure request_firmware() to read all header
    fields first, then validate, then set pointers

v2: validate sig_off+sig_size and custom_sig_off+custom_sig_size against
---
 drivers/nfc/s3fwrn5/firmware.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/nfc/s3fwrn5/firmware.c b/drivers/nfc/s3fwrn5/firmware.c
index 9145deec7..e2b1c932e 100644
--- a/drivers/nfc/s3fwrn5/firmware.c
+++ b/drivers/nfc/s3fwrn5/firmware.c
@@ -12,6 +12,7 @@
 
 #include "s3fwrn5.h"
 #include "firmware.h"
+#include <linux/overflow.h>
 
 struct s3fwrn5_fw_version {
 	__u8 major;
@@ -93,7 +94,8 @@ static int s3fwrn5_fw_get_bootinfo(struct s3fwrn5_fw_info *fw_info,
 		return ret;
 
 	hdr = (struct s3fwrn5_fw_header *) rsp->data;
-	if (hdr->code != S3FWRN5_FW_RET_SUCCESS) {
+	if (hdr->code != S3FWRN5_FW_RET_SUCCESS ||
+	    rsp->len < S3FWRN5_FW_HDR_SIZE + 10) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -285,6 +287,7 @@ int s3fwrn5_fw_request_firmware(struct s3fwrn5_fw_info *fw_info)
 	u32 sig_off;
 	u32 image_off;
 	u32 custom_sig_off;
+	u32 end;
 	int ret;
 
 	ret = request_firmware(&fw->fw, fw_info->fw_name,
@@ -303,17 +306,27 @@ int s3fwrn5_fw_request_firmware(struct s3fwrn5_fw_info *fw_info)
 	memcpy(&fw->version, fw->fw->data + 0x10, 4);
 
 	memcpy(&sig_off, fw->fw->data + 0x14, 4);
-	fw->sig = fw->fw->data + sig_off;
 	memcpy(&fw->sig_size, fw->fw->data + 0x18, 4);
 
 	memcpy(&image_off, fw->fw->data + 0x1C, 4);
-	fw->image = fw->fw->data + image_off;
 	memcpy(&fw->image_sectors, fw->fw->data + 0x20, 4);
 
 	memcpy(&custom_sig_off, fw->fw->data + 0x24, 4);
-	fw->custom_sig = fw->fw->data + custom_sig_off;
 	memcpy(&fw->custom_sig_size, fw->fw->data + 0x28, 4);
 
+	if (check_add_overflow(sig_off, fw->sig_size, &end) ||
+	    end > fw->fw->size ||
+	    image_off > fw->fw->size ||
+	    check_add_overflow(custom_sig_off, fw->custom_sig_size, &end) ||
+	    end > fw->fw->size) {
+		release_firmware(fw->fw);
+		return -EINVAL;
+	}
+
+	fw->sig = fw->fw->data + sig_off;
+	fw->image = fw->fw->data + image_off;
+	fw->custom_sig = fw->fw->data + custom_sig_off;
+
 	return 0;
 }
 
@@ -409,11 +422,21 @@ int s3fwrn5_fw_download(struct s3fwrn5_fw_info *fw_info)
 {
 	struct device *dev = &fw_info->ndev->nfc_dev->dev;
 	struct s3fwrn5_fw_image *fw = &fw_info->fw;
+	size_t image_avail = fw->fw->data + fw->fw->size -
+			     (const u8 *)fw->image;
+	u64 total = (u64)fw_info->sector_size * fw->image_sectors;
 	u8 hash_data[SHA1_DIGEST_SIZE];
 	u32 image_size, off;
 	int ret;
 
-	image_size = fw_info->sector_size * fw->image_sectors;
+	if (!fw_info->sector_size || total > image_avail ||
+	    (fw->image_sectors &&
+	     total - fw_info->sector_size + 16 * 256 > image_avail)) {
+		dev_err(dev, "Invalid firmware image size\n");
+		return -EINVAL;
+	}
+
+	image_size = total;
 
 	/* Compute SHA of firmware data */
 	sha1(fw->image, image_size, hash_data);

---
base-commit: 602042bf29f6efde39cfb5fdd9289bf4854bc0c5
change-id: 20261108-s3fwrn5-v2-001b98a2b6ac

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


