Received: from sg-2-2.ptr.blmpb.com (sg-2-2.ptr.blmpb.com [71.18.227.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFDF485CD8
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779218; cv=none; b=N8I8M4Lt2N1MVhxGF+CQCUaJ5V6BjDXIvoKRIm42Zq4oG/3rKVkipX5X8PrYD0bZ7sfB4Ml/8/xfzndw3isaSdOVMyZVhIUM7JUTgRhJAawS9oGeY8TQIK4lGohQj1YElBhCmoOTE5Yu8S1D/vC2d92e1BBmJMdg4KGR1Cht5sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779218; c=relaxed/simple;
	bh=PlY/IwlxoPLKIeXOhG+KaL1+BexmzdmpRVPxFH8QRtM=;
	h=From:Subject:Mime-Version:Content-Type:To:Cc:Date:Message-Id; b=m5rGhREa7qFqEMYi8d4RC1rsVLkURYQk72REjhW0wMIKRZyfUtfAw4guHz/6Bf9+VM6u99+hvHPwrJHt/jFyKax7nEGBAABLRBV0e3+Eu2L3b5skDdkOdUYHk1o4khafBLAGnv+8eipPnu1boKm+qubymn741DldYlcUtuOSyDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=sCLIQJ6f; arc=none smtp.client-ip=71.18.227.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="sCLIQJ6f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787779196; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=r7BKRwXvzFtHb2KAPCA0wNa9kxnwbggrfjVXuEj0jRY=;
 b=sCLIQJ6fbmDBicsC7ZpTdqVtJkE6lxys2I7TuV/qMJet2sWWnSaVK24TAooNpTzUQ1a6re
 s4Q8UexI9yT/YOTb9APtRbSZ5nS8MRH7ExwKMG6itoq7vNueoGdzaVI/9lUtoB1tINSYpQ
 0+0D07C2lUt64eXpMWkM29AjZ3iCiBO7ZPLsTrwWhY41zHwqzm27R6q+wlEaXpxWKpPG0O
 7SrMQmpOTn0ycduosRucS3+TZ8P3HErgE94V0OJEN+6ccRHVu1VO9f6oxj6FJlS2oUvbTk
 ntxCE9Kjak1XE065ylP8F9P3fwVY3lu+kUQmAjcrq85jIcCb7DJwQiiw669X5g==
From: "Shengzhuo Wei" <me@cherr.cc>
X-B4-Tracking: v=1; b=H4sIAHJYj2oC/yXMQQ6CMBBA0auQWTtJaZGiVyEsSpnqGENNR4GEc HeKLN/i/xWEEpPAvVgh0cTCccwoLwX4pxsfhDxkg1a6Vo226KRUGsOMcaIU3nHGytvrcLNGNcZ B7j6JAi//Z9udll//Iv89RrBtO4Wz5V91AAAA
Subject: [PATCH] media: as102: bound firmware hex-line parsing by buffer and data sizes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a8f587b+d913b0+vger.kernel.org+me@cherr.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received: from [192.168.9.107] ([111.42.148.52]) by smtp.feishu.cn with ESMTPS; Thu, 27 Aug 2026 05:19:54 +0800
X-Mailer: b4 0.16.0
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-Change-Id: 20260827-as102-fw-overflow-4c75d973083a
To: "Mauro Carvalho Chehab" <mchehab@kernel.org>, 
	"Sylwester Nawrocki" <snjw23@gmail.com>, 
	"Piotr Chmura" <chmooreck@poczta.onet.pl>, 
	"Pierrick Hascoet" <pierrick.hascoet@abilis.com>, 
	"Devin Heitmueller" <dheitmueller@kernellabs.com>
Cc: "Kees Cook" <kees@kernel.org>, <linux-media@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Date: Thu, 27 Aug 2026 05:19:47 +0800
Message-Id: <20260827-as102-fw-overflow-v1-1-ff28890fec02@cherr.cc>

parse_hex_line() walks the Intel HEX firmware image two characters at a
time until the next '\n', writing every decoded byte past the sixth pair
into fw_pkt->raw.data[], a 58-byte array inside a 64-byte heap object.
Nothing bounds the line length: a firmware file with a hex line longer
than 64 data bytes writes past the end of the kmalloc-64 object, byte by
byte, with fully controlled contents. A file without a trailing newline
additionally makes the walk run past the end of the firmware buffer
itself. A malformed or replaced firmware file can thus corrupt adjacent
heap memory during device probe.

Bound the walk by the remaining firmware size and reject lines whose
payload does not fit in data[]. Verified with a KASAN reproducer of the
loop: the overflow disappears and the oversized line is rejected with
-EFAULT.

Fixes: 41b44e041811 ("[media] staging: as102: Initial import from Abilis")
Cc: stable@vger.kernel.org
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
Assisted-by: GLM:5.3
---
parse_hex_line() has no bound on the hex-line length it walks in the
firmware image: every decoded byte pair past the sixth is written into
fw_pkt->raw.data[], a 58-byte array in a 64-byte heap object. An
oversized line (or a firmware file with no trailing newline) writes
past the object / reads past the firmware buffer during probe.

Verified with a KASAN reproducer of the loop (write of size 1,
slab-out-of-bounds on kmalloc-64); silenced by the fix.
---
 drivers/media/usb/as102/as102_fw.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/as102/as102_fw.c b/drivers/media/usb/as102/as102_fw.c
index d2d432789f55..0cba1ac7fb05 100644
--- a/drivers/media/usb/as102/as102_fw.c
+++ b/drivers/media/usb/as102/as102_fw.c
@@ -37,20 +37,28 @@ static unsigned char atohx(unsigned char *dst, char *src)
 /*
  * Parse INTEL HEX firmware file to extract address and data.
  */
-static int parse_hex_line(unsigned char *fw_data, unsigned char *addr,
-			  unsigned char *data, int *dataLength,
-			  unsigned char *addr_has_changed) {
+static int parse_hex_line(unsigned char *fw_data, size_t fw_size,
+			  unsigned char *addr, unsigned char *data,
+			  size_t data_size, int *dataLength,
+			  unsigned char *addr_has_changed)
+{
 
 	int count = 0;
 	unsigned char *src, dst;
 
-	if (*fw_data++ != ':') {
+	if (fw_size < 1 || *fw_data++ != ':') {
 		pr_err("invalid firmware file\n");
 		return -EFAULT;
 	}
+	fw_size--;
 
 	/* locate end of line */
 	for (src = fw_data; *src != '\n'; src += 2) {
+		if (src + 1 >= fw_data + fw_size ||
+		    count >= 4 + (int)data_size) {
+			pr_err("invalid firmware file\n");
+			return -EFAULT;
+		}
 		atohx(&dst, src);
 		/* parse line to split addr / data */
 		switch (count) {
@@ -107,8 +115,9 @@ static int as102_firmware_upload(struct as10x_bus_adapter_t *bus_adap,
 		/* parse intel hex line */
 		read_bytes = parse_hex_line(
 				(u8 *) (firmware->data + total_read_bytes),
+				firmware->size - total_read_bytes,
 				fw_pkt->raw.address,
-				fw_pkt->raw.data,
+				fw_pkt->raw.data, sizeof(fw_pkt->raw.data),
 				&data_len,
 				&addr_has_changed);
 

---
base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
change-id: 20260827-as102-fw-overflow-4c75d973083a

Best regards,
--  
Shengzhuo Wei <me@cherr.cc>
