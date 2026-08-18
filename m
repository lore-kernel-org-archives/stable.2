Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555A8378D88;
	Tue, 18 Aug 2026 02:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787018534; cv=none; b=s/K4YGVBJipYfDO6IV3NASJjPENuGvRROcM4oBcSjfCUNJ8KMhl2SVhD9kmyekp4RlnfklnPnTk72SannICWkJVNXuRzxzhvqeaGGJNzj2YI+Vqqz47rsq6uBeNVvFDzy2nEEBuG5kYFAbG7V8yDDn9jDQIJpg3cdN07+dOw/Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787018534; c=relaxed/simple;
	bh=R2CpwLH3MOsz/89+daXlOOtJLTuU4AfW7o5Ustx7Chc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOHlZ/1yCT/5lUNTrgzJzAcCp2i/NehISXk1rjbKftRDi1EyreJFOmCFE2wncbHV9sSF8toQlj/GXPhEyCftdVj/k7ZRIwreEBcfFxLi4pmNB2Pa21+O6ekOGavpl61gcxN5kqrr5uTBiJmjlHQM6K1jPrwCoY0k9cHglvP6ZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cbf28c4c9aa811f19a56ed5b684f684d-20260818
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2e756e8e-868e-4abe-97ed-fd5c509f500a,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:d53577bf6258bb2744bc6d4e3c308ab3,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:2,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cbf28c4c9aa811f19a56ed5b684f684d-20260818
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1052384791; Tue, 18 Aug 2026 10:01:59 +0800
From: longlong yan <yanlonglong@kylinos.cn>
To: linux-usb@vger.kernel.org,
	valentina.manea.m@gmail.com,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org,
	i@zenithal.me
Cc: longlong yan <yanlonglong@kylinos.cn>
Subject: [PATCH] usbip: tools: fix wrong variable and double le16toh in list_gadget_devices
Date: Tue, 18 Aug 2026 10:01:40 +0800
Message-ID: <20260818020140.1863-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In list_gadget_devices(), the sprintf() call for idProduct_buf incorrectly
uses idVendor instead of idProduct due to a copy-paste mistake. This causes
the displayed product ID of vudc gadget devices to always show the vendor
ID instead.

Additionally, usbip_names_get_product() is called with le16toh() on
idVendor and idProduct values that were already converted from
little-endian to host byte order on the preceding lines. This double
conversion produces incorrect vendor/product IDs on big-endian
architectures, leading to wrong product name lookups.

Fixes: e0546fd8b748 ("usbip: tools: Start using VUDC backend in usbip tools")
Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
---
 tools/usb/usbip/src/usbip_list.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/usb/usbip/src/usbip_list.c b/tools/usb/usbip/src/usbip_list.c
index 3d810bcca02f..85e6a8a1fc36 100644
--- a/tools/usb/usbip/src/usbip_list.c
+++ b/tools/usb/usbip/src/usbip_list.c
@@ -298,13 +298,12 @@ static int list_gadget_devices(bool parsable)
 		idVendor = le16toh(d_desc->idVendor);
 		sprintf(idVendor_buf, "0x%4x", idVendor);
 		idProduct = le16toh(d_desc->idProduct);
-		sprintf(idProduct_buf, "0x%4x", idVendor);
+		sprintf(idProduct_buf, "0x%4x", idProduct);
 		busid = udev_device_get_sysname(dev);
 
 		/* Get product name. */
 		usbip_names_get_product(product_name, sizeof(product_name),
-					le16toh(idVendor),
-					le16toh(idProduct));
+					idVendor, idProduct);
 
 		/* Print information. */
 		print_device(busid, idVendor_buf, idProduct_buf, parsable);
-- 
2.43.0

