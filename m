Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1F8DDA9;
	Sun,  6 Sep 2026 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788679935; cv=none; b=PuQf1W5CtnOFazQaIpZU+EGqrou5pfYUg6SWAbfHRtAEw5ltVgV5aDtLUZLPTzMcnMQIXxXFs3BxuYZ92KpkMyDpQp5t54xjILrZd8tle66u5fSWt+QfcR3DTdhINEajAL7S+PTBU3XRieK+5A+N0ewxUeRax6dSLe6ApFfFlKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788679935; c=relaxed/simple;
	bh=FJm9ug6DcPpsf2j0pB9cJtm0cOiu4ANli+jKLEGZ/Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hQRE1ZFLHOR1W54DGgqCqlZwA/Bz1JT1fePXdQVzzWypQxniW3W//Jws9F5UF2ZXofM4sWbo3NfTcBEFGtx/FuWO75+2rHqbxBTZqmgraXV6coBAI5PxzwClNwskOQ0KlnjOVAjXD/26MYu8lHrmPcB7ervbF0zpI0Aivdnkors=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=ngmncIvD; arc=none smtp.client-ip=115.124.28.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="ngmncIvD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1788679929; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fJgXmYmYFY1zWOGbn8dl+uPiJS+iQ9OGlxFKsVIxnGQ=;
	b=ngmncIvD95h6GjMAuHRr6mtEskHtTWNQYxVt1xyEv3vxTexKVA8BSxPqlz1MmQ71LWJvMCkggFhNFQXHGncdaxDd64Gze6zG2c/7wyGBF85+tgy04reEBWYlYs3qXMEvWrCJbRAplvSA8dmLJ2kWvrYyl/szp48xeNJTLUtDftg=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00480246-5.28004e-05-0.995145;FP=13762072585042488439|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.j6qG566_1788679927;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.j6qG566_1788679927 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 06 Sep 2026 15:32:08 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Chao <liuc63@xiaopeng.com>,
	stable@vger.kernel.org
Subject: [PATCH] partitions: ldm: add input-side bounds to ldm_get_vstr
Date: Sun,  6 Sep 2026 15:31:14 +0800
Message-ID: <20260906073114.3296121-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ldm_get_vstr() copies a length-prefixed string out of a VBLK record:

	length = block[0];
	if (length >= buflen) {
		length = buflen - 1;
	}
	memcpy(buffer, block + 1, length);

length is clamped to the output buffer, but not to the remaining
input.  block points into the VBLK at an offset returned by
ldm_relative(), which can place it at the last byte of the buffer.
The memcpy then reads up to 127 bytes past the allocation
(disk->alt_name is 128 bytes).

On the fragmented-VBLK path the buffer comes from
kmalloc(sizeof(struct frag) + size * num) and the overread walks
straight into the slab redzone.  The reproducer below exercises
the 64-byte vb->name path in ldm_parse_vblk():

  BUG: KASAN: slab-out-of-bounds in ldm_get_vstr.isra.0+0x43/0x90
  Read of size 63 at addr ffff8881003e3f17 by task swapper/0/1

The partition scan runs automatically when a block device with an
MBR type-0x42 partition appears.

Add a blocklen parameter and clamp the string length to the
remaining input at each call site.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 block/partitions/ldm.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index c0bdcae58..5468e038a 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -673,6 +673,7 @@ static u64 ldm_get_vnum (const u8 *block)
 /**
  * ldm_get_vstr - Read a length-prefixed string into a buffer
  * @block:   Pointer to the length marker
+ * @blocklen: Number of bytes available at @block
  * @buffer:  Location to copy string to
  * @buflen:  Size of the output buffer
  *
@@ -680,20 +681,27 @@ static u64 ldm_get_vnum (const u8 *block)
  * they are prefixed by a one byte length marker.  This function copies one of
  * these strings into a buffer.
  *
- * N.B.  This function DOES NOT perform any range checking on the input.
- *       If the buffer is too small, the output will be truncated.
+ * N.B.  The string is clamped to both @blocklen and @buflen; if either
+ *       is too small the output will be truncated.
  *
  * Return:  0, Error and @buffer contents are undefined
  *          n, String length in characters (excluding NULL)
  *          buflen-1, String was truncated.
  */
-static int ldm_get_vstr (const u8 *block, u8 *buffer, int buflen)
+static int ldm_get_vstr(const u8 *block, int blocklen, u8 *buffer, int buflen)
 {
 	int length;
 
 	BUG_ON (!block || !buffer);
 
+	if (blocklen < 1) {
+		buffer[0] = '\0';
+		return 0;
+	}
+
 	length = block[0];
+	if (length > blocklen - 1)
+		length = blocklen - 1;
 	if (length >= buflen) {
 		ldm_error ("Truncating string %d -> %d.", length, buflen);
 		length = buflen - 1;
@@ -744,8 +752,8 @@ static bool ldm_parse_cmp3 (const u8 *buffer, int buflen, struct vblk *vb)
 		return false;
 
 	comp = &vb->vblk.comp;
-	ldm_get_vstr (buffer + 0x18 + r_name, comp->state,
-		sizeof (comp->state));
+	ldm_get_vstr(buffer + 0x18 + r_name, buflen - (0x18 + r_name),
+		comp->state, sizeof(comp->state));
 	comp->type      = buffer[0x18 + r_vstate];
 	comp->children  = ldm_get_vnum (buffer + 0x1D + r_vstate);
 	comp->parent_id = ldm_get_vnum (buffer + 0x2D + r_child);
@@ -790,8 +798,8 @@ static int ldm_parse_dgr3 (const u8 *buffer, int buflen, struct vblk *vb)
 		return false;
 
 	dgrp = &vb->vblk.dgrp;
-	ldm_get_vstr (buffer + 0x18 + r_name, dgrp->disk_id,
-		sizeof (dgrp->disk_id));
+	ldm_get_vstr(buffer + 0x18 + r_name, buflen - (0x18 + r_name),
+		dgrp->disk_id, sizeof(dgrp->disk_id));
 	return true;
 }
 
@@ -829,7 +837,8 @@ static bool ldm_parse_dgr4 (const u8 *buffer, int buflen, struct vblk *vb)
 	if (len != get_unaligned_be32(buffer + 0x14))
 		return false;
 
-	ldm_get_vstr (buffer + 0x18 + r_objid, buf, sizeof (buf));
+	ldm_get_vstr(buffer + 0x18 + r_objid, buflen - (0x18 + r_objid),
+		buf, sizeof(buf));
 	return true;
 }
 
@@ -864,8 +873,8 @@ static bool ldm_parse_dsk3 (const u8 *buffer, int buflen, struct vblk *vb)
 		return false;
 
 	disk = &vb->vblk.disk;
-	ldm_get_vstr (buffer + 0x18 + r_diskid, disk->alt_name,
-		sizeof (disk->alt_name));
+	ldm_get_vstr(buffer + 0x18 + r_diskid, buflen - (0x18 + r_diskid),
+		disk->alt_name, sizeof(disk->alt_name));
 	if (uuid_parse(buffer + 0x19 + r_name, &disk->disk_id))
 		return false;
 
@@ -1072,16 +1081,16 @@ static bool ldm_parse_vol5(const u8 *buffer, int buflen, struct vblk *vb)
 		return false;
 	}
 	volu = &vb->vblk.volu;
-	ldm_get_vstr(buffer + 0x18 + r_name, volu->volume_type,
-			sizeof(volu->volume_type));
+	ldm_get_vstr(buffer + 0x18 + r_name, buflen - (0x18 + r_name),
+			volu->volume_type, sizeof(volu->volume_type));
 	memcpy(volu->volume_state, buffer + 0x18 + r_disable_drive_letter,
 			sizeof(volu->volume_state));
 	volu->size = ldm_get_vnum(buffer + 0x3D + r_child);
 	volu->partition_type = buffer[0x41 + r_size];
 	memcpy(volu->guid, buffer + 0x42 + r_size, sizeof(volu->guid));
 	if (buffer[0x12] & VBLK_FLAG_VOLU_DRIVE) {
-		ldm_get_vstr(buffer + 0x52 + r_size, volu->drive_hint,
-				sizeof(volu->drive_hint));
+		ldm_get_vstr(buffer + 0x52 + r_size, buflen - (0x52 + r_size),
+				volu->drive_hint, sizeof(volu->drive_hint));
 	}
 	return true;
 }
@@ -1115,7 +1124,8 @@ static bool ldm_parse_vblk (const u8 *buf, int len, struct vblk *vb)
 	vb->flags  = buf[0x12];
 	vb->type   = buf[0x13];
 	vb->obj_id = ldm_get_vnum (buf + 0x18);
-	ldm_get_vstr (buf+0x18+r_objid, vb->name, sizeof (vb->name));
+	ldm_get_vstr(buf + 0x18 + r_objid, len - (0x18 + r_objid),
+		vb->name, sizeof(vb->name));
 
 	switch (vb->type) {
 		case VBLK_CMP3:  result = ldm_parse_cmp3 (buf, len, vb); break;
-- 
2.50.1

