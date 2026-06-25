Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7E430276A
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410958; cv=none; b=J61r7CbM+IJBcrTNoAfFzfMKgHkC5SIXFQTvRomzfNWZ8P6S5yYHciSdu/iB3Vq63DtE8W+t/Uerk0N6T81OQIAxxnQnZnTy8I5f+P5aWDvdBHx8wYXlY2QatrG7LCzF/iERsHfKdvij78YsT115mrgaTulu7i5cMwnHTGExuOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410958; c=relaxed/simple;
	bh=FTFiOqBlT0sIzYmkYqEPBA2R84rNSgB0Dx8qxDEtBxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAg/eTs1oc6ORaTR80RvsejcyNT6lyu89KAx+9Gm+G0w/85PryFM5eATOcmZ3sVbkQT8fos3Olc28pazxU11FDBuHdhv4Xtat25gH85+ZifoaXo4nS9PN+EVU9Jy/BE9lheareJZOENWFTSQCP2I5/rfMyjMBe291MuDvnD/tbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJBonsXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJBonsXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891A21F00A3D;
	Thu, 25 Jun 2026 18:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782410957;
	bh=qR3CFq7Pjaq88DA9IS9ZZFb8ROdroN1XlCCZeEvvk3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UJBonsXof7lMlsUWiEv1pnBqwC1MUdjnl/sBX107Munw8BYACzGd6A0jnmzeEkHJw
	 L+1e7+I3FxjDCL/ek5ptjR2sbsv0wwFTudgIrpm8wvoi8PUkULa22Vh+cSCdmR84LH
	 8d7OE9VthS1okl0RvcWk4QYy8wcvxMlGV5cTxv/NVbXxVB2WweX2E8mESoPZqp4ydz
	 Jlr+wAc0TEN1G3AN3OUHRzpPbrcOoyw0bqApQ5rcf5QSLc54QUb5hYBOBEvAWEYht8
	 nwPfq5XdqGgvpR7Xa9oGb3lLguZag36UuRSpfjPgJxtTHlfUXByBooYw5eXM7w82yD
	 x7VLx6TR/eqww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] Input: rmi4 - refactor register descriptor parsing
Date: Thu, 25 Jun 2026 14:09:14 -0400
Message-ID: <20260625180914.2561861-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062530-docile-justly-faed@gregkh>
References: <2026062530-docile-justly-faed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 0adb483fbf2dc43c875cd7550a58b41e92efc52d ]

Factor out parsing a register descriptor item from
rmi_read_register_desc() and ensure there are no out-of-bounds accesses.

Use get_unaligned_le16() and get_unaligned_le32() for reading multi-byte
values.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Link: https://patch.msgid.link/20260505045952.1570713-2-dmitry.torokhov@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[ changed the new `#include <linux/unaligned.h>` to `<asm/unaligned.h>` and dropped the absent `export.h` context line ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/rmi4/rmi_driver.c | 124 +++++++++++++++++++-------------
 1 file changed, 76 insertions(+), 48 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index ef9ea295f9e035..6c5a42d1b00225 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -21,6 +21,7 @@
 #include <linux/irqdomain.h>
 #include <uapi/linux/input.h>
 #include <linux/rmi.h>
+#include <asm/unaligned.h>
 #include "rmi_bus.h"
 #include "rmi_driver.h"
 
@@ -557,30 +558,74 @@ int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
 	return retval < 0 ? retval : 0;
 }
 
+static int rmi_parse_register_desc_item(struct rmi_register_desc_item *item,
+					const u8 *buf, size_t size)
+{
+	unsigned int offset = 0;
+	unsigned int map_offset = 0;
+	int b;
+
+	if (offset >= size)
+		return -EIO;
+
+	item->reg_size = buf[offset++];
+	if (item->reg_size == 0) {
+		if (size - offset < 2)
+			return -EIO;
+		item->reg_size = get_unaligned_le16(&buf[offset]);
+		offset += 2;
+	}
+
+	if (item->reg_size == 0) {
+		if (size - offset < 4)
+			return -EIO;
+		item->reg_size = get_unaligned_le32(&buf[offset]);
+		offset += 4;
+	}
+
+	do {
+		if (offset >= size)
+			return -EIO;
+
+		for (b = 0; b < 7; b++) {
+			if (buf[offset] & BIT(b)) {
+				if (map_offset >= RMI_REG_DESC_SUBPACKET_BITS)
+					return -EIO;
+				__set_bit(map_offset, item->subpacket_map);
+			}
+			++map_offset;
+		}
+	} while (buf[offset++] & BIT(7));
+
+	item->num_subpackets = bitmap_weight(item->subpacket_map,
+					     RMI_REG_DESC_SUBPACKET_BITS);
+
+	return offset;
+}
+
 int rmi_read_register_desc(struct rmi_device *d, u16 addr,
-				struct rmi_register_descriptor *rdesc)
+			   struct rmi_register_descriptor *rdesc)
 {
 	int ret;
 	u8 size_presence_reg;
 	u8 buf[35];
-	int presense_offset = 1;
-	u8 *struct_buf;
-	int reg;
-	int offset = 0;
-	int map_offset = 0;
+	unsigned int presence_offset;
+	unsigned int map_offset;
+	unsigned int offset;
+	unsigned int reg;
 	int i;
 	int b;
 
 	/*
 	 * The first register of the register descriptor is the size of
-	 * the register descriptor's presense register.
+	 * the register descriptor's presence register.
 	 */
 	ret = rmi_read(d, addr, &size_presence_reg);
 	if (ret)
 		return ret;
 	++addr;
 
-	if (size_presence_reg < 0 || size_presence_reg > 35)
+	if (size_presence_reg < 1 || size_presence_reg > 35)
 		return -EIO;
 
 	memset(buf, 0, sizeof(buf));
@@ -596,16 +641,23 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	++addr;
 
 	if (buf[0] == 0) {
-		presense_offset = 3;
-		rdesc->struct_size = buf[1] | (buf[2] << 8);
+		if (size_presence_reg < 3)
+			return -EIO;
+		presence_offset = 3;
+		rdesc->struct_size = get_unaligned_le16(&buf[1]);
 	} else {
+		presence_offset = 1;
 		rdesc->struct_size = buf[0];
 	}
 
-	for (i = presense_offset; i < size_presence_reg; i++) {
+	map_offset = 0;
+	for (i = presence_offset; i < size_presence_reg; i++) {
 		for (b = 0; b < 8; b++) {
-			if (buf[i] & (0x1 << b))
+			if (buf[i] & BIT(b)) {
+				if (map_offset >= RMI_REG_DESC_PRESENSE_BITS)
+					return -EIO;
 				bitmap_set(rdesc->presense_map, map_offset, 1);
+			}
 			++map_offset;
 		}
 	}
@@ -625,7 +677,7 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	 * I'm not using devm_kzalloc here since it will not be retained
 	 * after exiting this function
 	 */
-	struct_buf = kzalloc(rdesc->struct_size, GFP_KERNEL);
+	u8 *struct_buf __free(kfree) = kzalloc(rdesc->struct_size, GFP_KERNEL);
 	if (!struct_buf)
 		return -ENOMEM;
 
@@ -637,56 +689,32 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	 */
 	ret = rmi_read_block(d, addr, struct_buf, rdesc->struct_size);
 	if (ret)
-		goto free_struct_buff;
+		return ret;
 
 	reg = find_first_bit(rdesc->presense_map, RMI_REG_DESC_PRESENSE_BITS);
+	offset = 0;
 	for (i = 0; i < rdesc->num_registers; i++) {
 		struct rmi_register_desc_item *item = &rdesc->registers[i];
-		int reg_size = struct_buf[offset];
-
-		++offset;
-		if (reg_size == 0) {
-			reg_size = struct_buf[offset] |
-					(struct_buf[offset + 1] << 8);
-			offset += 2;
-		}
+		int item_size;
 
-		if (reg_size == 0) {
-			reg_size = struct_buf[offset] |
-					(struct_buf[offset + 1] << 8) |
-					(struct_buf[offset + 2] << 16) |
-					(struct_buf[offset + 3] << 24);
-			offset += 4;
-		}
+		item_size = rmi_parse_register_desc_item(item,
+							 &struct_buf[offset],
+							 rdesc->struct_size - offset);
+		if (item_size < 0)
+			return item_size;
 
 		item->reg = reg;
-		item->reg_size = reg_size;
-
-		map_offset = 0;
-
-		do {
-			for (b = 0; b < 7; b++) {
-				if (struct_buf[offset] & (0x1 << b))
-					bitmap_set(item->subpacket_map,
-						map_offset, 1);
-				++map_offset;
-			}
-		} while (struct_buf[offset++] & 0x80);
-
-		item->num_subpackets = bitmap_weight(item->subpacket_map,
-						RMI_REG_DESC_SUBPACKET_BITS);
+		offset += item_size;
 
 		rmi_dbg(RMI_DEBUG_CORE, &d->dev,
 			"%s: reg: %d reg size: %ld subpackets: %d\n", __func__,
 			item->reg, item->reg_size, item->num_subpackets);
 
 		reg = find_next_bit(rdesc->presense_map,
-				RMI_REG_DESC_PRESENSE_BITS, reg + 1);
+				    RMI_REG_DESC_PRESENSE_BITS, reg + 1);
 	}
 
-free_struct_buff:
-	kfree(struct_buf);
-	return ret;
+	return 0;
 }
 
 const struct rmi_register_desc_item *rmi_get_register_desc_item(
-- 
2.53.0

