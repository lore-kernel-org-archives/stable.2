Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794280991;
	b=fYdCflzPe9Bez3pfWznxTuYAzWtpNvdjacnDQhoGa30fWbMDmfJpfpFc0TRW4iTo8P2o
	 sk/7RzGcmdeUD5SA1ZpxFVbmxqFUfxMsxiqD38qsyyv7tcLddj180/B6kTbKnQhJQgR78
	 d2SVc77BRxHZFUvhUfAV+DWSaM5RdffJ1STka9FWli8IsG/3gn9vgOYldzcY/1BFLn32s
	 RdAK5TdMcPvolLCJwwJAK0qGybXcIqtPushKDg8kIvXeZtRUwa5EnxvGT6OpIImRWOuYd
	 oth7NDhmBKZVLqw7n/gKfPw9kxWmMu2hnodNN51PiU2I9ws7YBFTHPU1D+vvCRuQD6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280991;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=xTuKFjOL9MLyUlSMODi8Yn1X8Zb1+J3mhD6YlkzKV8A=;
	b=uzskKy8cvLnED9mXD7shX6kiaclGE+3GKRtaRfjwYPG4WxoimsPvenAfnFjIsPsMO6pc
	 N6PyjjeRedsarVwYXOIsxDRDFktK8znAKKFLM5DIM2hBkAbv2S6yOutiyRniwcduXjEo5
	 bCOdure6mehZna9KDyUtCX5lCuJadJgxOBxOkpjaVj/g9pVOLspH+yyEYNl8bMLtV1q0T
	 4RhT/Mm8Ov+8P6wyjdgdzjjm8RW1KE5ahwZceJ8Sc9iCqsdsP1ZUNJpeZABWRJvHUQf95
	 MXJt9k8cnI/riII/4DQK2IPjQuBKbDj3QWxYMfccsuPWECF49XMPpz42RLs5cFsCbKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ryg05WLm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3502A60A2639;
	Tue, 10 Nov 2026 03:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ryg05WLm
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794280990;
	b=Q/5jBBc1olXGDe24M9axKgSeU8VwZxxw0U2QiVnKAipfDv92lMp5+ki5GK7paaJDwkmX
	 YalwOZsta/oWGkj/YUFZj934/ymSRC9X6/C0IhAPJwuSaK/m3RyvH6LFYudJtSxg6q2Be
	 D1UBAltJxkYxHlIMLJbOmU3+P2mhmjGRsuvyQxIRKYbputVscE+2hnSHiI6eRUzD8t1A+
	 wNful94rFCiePIWGY/WTA5JaArWuEJSYJ2ktJwa/hMNfy5ms8VsFAA4js2A8ZMMyQQCtX
	 o3JnJ7fQLFEJb4abLeslf7TWiZg73NX7rpT8IT08JG9Ez+96kWYsyQtjCvKNuXroF9w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794280990;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=xTuKFjOL9MLyUlSMODi8Yn1X8Zb1+J3mhD6YlkzKV8A=;
	b=3esVU2aSf0IhVsv4L+aIrmdWjUpUgZl0lNW7GGlm6IyKuONdG1Ep/Vs74uQ8DmUG9ZQo
	 I4B1MUKu15Hkhaf57lUOUmP0TI043ufZ52VvH1PSGWs46HloZ0QpvDTssCHZsEDhFYELq
	 7e5RHSrm3JJjg8MA7SmHUmyRDeWD2I4P68IAEC48M75xVXfUC+RNoeE0KvRdKeW/8fvqz
	 1SnhlpYPWpp9wMlI5gmJVIxMA62ojv7lmFOEEYjmX/n4mAqCgE8sgFzXWmRErgET/EPJI
	 ANEXQs5m91b4C0z0Af1LCUtKA+POkreTHKdGYe2a9/3hVrRcNF5xVtDPZVpj+HhAQoQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7460C1F00904;
	Tue, 10 Nov 2026 03:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280990;
	bh=xTuKFjOL9MLyUlSMODi8Yn1X8Zb1+J3mhD6YlkzKV8A=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Ryg05WLmpQX+r8e+OX0Qaiw31e+/MMoeF8SSpMkHJe1qAG4QsOJtC84qtbnuHKAcC
	 68WrYyiYzcSr5UHJzXYHfY9h7QduPfQioalVzKJ8BPgSvAnLYgDp+MzqF7IpF8r3SS
	 C1gJqA6J2fRyUDud3qSkkXqW4uCSIUlXvKGjFwIiVnKKtE68XCFKHHqNWOA4wOKrpF
	 gXE2nwQq1dPupEOT+WDMdVHvEdZKUlb5Oy51LUVBz5cgSDIGS67JTbtHInJFjBk4cK
	 IHSMJVNtJOl4X27N+wU5IWO1yFJ0/n48C8POyM76UK/Dxv7PdhQStRl+J2tCek2vjl
	 kQ/7611KM2LqQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0AD86487A2;
	Tue, 10 Nov 2026 03:23:08 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 03:23:08 +0000
Subject: [PATCH RESEND v2] nfc: s3fwrn5: validate firmware header pointers
 against file size
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
Message-Id: <20261110-s3fwrn5-v2-v2-1-e8f154a5613e@gmail.com>
To: joasantonio108@gmail.com, david@ixit.cz, krzk@kernel.org
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794280987; l=4877;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=dxYNaHNtIiX2P2fjyRdVjd+WIyE9HNkEJiNNzya94jE=;
 b=J/wuNCjog6Vx3vtgf987hnzfOkLQu2fNFol5fIMuQrETBU6OQNPiTF+y6UbESV7JDU42on+in
 GFl2A7NttqNAuKi7SnnmkARJp/PscAnrnzy0z88t7SWKEbkY2EHPlr2
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
index 9145deec7f6c..e2b1c932e039 100644
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


