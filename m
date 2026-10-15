Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C430CD89
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792025870; cv=none; b=AwbuqWRrXagCTT4Ynqt+cjuUxMgMQ6+oDwpQgy2nt+gS2UTLBp3zJTc7AqhUinVz4zC9AdxF8+xYzkOMxLGbooxJJD2bqNwoJVbaY1aNdb3/vUeeVt1s3Sh/me2ihdT2C14+p0UUOiOVpfmIIP3Gyy7rQ416PLrJHliJBISt7Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792025870; c=relaxed/simple;
	bh=FPOviuaRIEKt1su3XsnsLtDvOASljQ8Fw7iaG9FZ3P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oa+GCqqyQMzE4bKoyAlD5shwuTj8r05Sw8uU8It6JQPtVuQQY4FDvN3eTbyt5kbR0WyzVfNTrPwTV5wGZIW2FBBQrZAetUG7HSAqscwIPhJWj1UV+rvh88HKLfCoPRJ2qhl19aHvnOO8bxyWBo8LFpHO+tNMtp+HcGLkg31eN88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=iRBvV5bV; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="iRBvV5bV"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3a8adb68d8bso3386526a91.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792025867; x=1792630667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7LfkD0gzGjUSgCK8PD95pNcbHAnZDGY828SkVDUj6lY=;
        b=iRBvV5bVhfAcx0wPp8k7GBbkk0ZAfBA9hb2FC3mx7krcC7gp3DuilAI5+c8CIkn5Sc
         UB3vrYV8OWOWTcaw4+XkLLCBWiXtsus3VT07uBvQWSZTiNJFyRdEbfnUDj71FtZZ6BrH
         s9PfHTuy63AJB8UFMdHFVYSzfq9WN4dl5YCAd4YHdVENsXtmpPPqt7/o1RgZcTsrn+Ai
         uW6OyuTXsSJf8B/2joM4U6vlnPkEhfLYot6oh1An7A/GpGW/Z2gBpU7bGq90GCjGOWtZ
         C0GcfYNxMZViBslCg8gNAz3jM0uZ52wrty4x0iSPuXi/vleDEZCwgvA8GlUxgffejjLq
         dL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792025867; x=1792630667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7LfkD0gzGjUSgCK8PD95pNcbHAnZDGY828SkVDUj6lY=;
        b=cAe4u/NPGmnittzTfOLMJ+XNfmP5bVwvzttXUiL9CuudzMYT9QRHQk1ektQUiL2m3M
         pTDL0j4z6owI8mzPTVk3GsKjdtlel98wlDO2uhQECti5/glTqyp9ek7L69FBbg6zrLUw
         PYa26d5vjENAvRLU1+6OGmKxp5iQoNm66IlFhGMRMmEMtQjWc5FbtwTqoTxTrb5dmNbS
         KFYMmferyq9KyHkmLSXso43nIU2OGd9G3LuNl74QmEvDpCjrIgwCZ8xcgyIcFOOztM07
         RyKyggsXHWG+h7hJ7/OSo+WTsLgNnJ40wYobmoE0Knqo09WVqOtDiBRQqiOvoQPaXbMP
         0xOg==
X-Forwarded-Encrypted: i=1; AKwUvBwud9EyDYBWx8pNTjI9/H/dSxXXbtoKRpVNDr5PMQSSz6y4frEjq+kahnw32ApGvEHuvyUm6Sw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4gafTHMj0Lo/aj+ld4/xBjaBiKDV8dHXw6e3TkbtRjql8J83H
	+L8wt2SmKJh1hpA5uQt5qCdrLhuWBKLmxdFmrNlE8s3Df7LqfYmU/J1FTUUqLCsCQ/k=
X-Gm-Gg: AYBFou3SEQBs3iNxnIENoJc1fK/bXKdN1YWfjXT20LnTkHKu99yIvuRwr7JOzTF2kcz
	YT+M6uZ72goj9W5gc1O4nw4WiOV5qsdk10ir4hzQn2JhphZg5eLyBTfcvyonyT5Ve7rXDSbZefC
	W7RK7KH8bxeScINDxqfFlgwdCXB4tSnHw/I/2MrCzeF04IbHMQnDgoo1YBATPO/bOZwcT+CmGp7
	e4vUSyiFLe9NuPxP6uEm7JB9FyAzzVNfof8V8ffmCzZNTATmM7kZW37qetMwmJvMgMWP9wmhdiS
	8M5DiLs3laZSoP/PDw43oXZW1NCoYTEkNQKey1ugYkMx9V3qaZif6woI9BfEaPTQmlueYR5S6WK
	Kc379oDa8Ic5lM1ewXMHS60ALUbRV3Wbq4cHOowY2Cw+5M27VlNKQu7WUmroX0f/ozlmxYa82xa
	3UB5ZkQKuk3JUNgJSHf0GFgiSLzvHaAWr2BQ7LPO7esfXQHemxpn/+OO96a5dec0TpuAwIwLlPr
	6H0PlDj6gxTgwo3
X-Received: by 2002:a17:90b:3b82:b0:3ab:4f1:4f76 with SMTP id 98e67ed59e1d1-3ab3a94f426mr16228983a91.24.1792025867019;
        Wed, 14 Oct 2026 17:57:47 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac92a43d98sm999198a91.0.2026.10.14.17.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 17:57:46 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v7 5/7] scsi: mvumi: reject handshake sizes that overflow the list allocations
Date: Thu, 15 Oct 2026 09:57:15 +0900
Message-ID: <20261015005717.3719956-6-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015005717.3719956-1-yhlee@isslab.korea.ac.kr>
References: <20261015005717.3719956-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mvumi_hs_process_page() takes max_io, the two command entry sizes and the
list depth from the firmware handshake page.  The entry sizes are u8 fields
used as shift counts, and 1 is an int, so a count of 29 or more makes the
<< 2 applied to the shift overflow an int; a count of 32 or more is
undefined outright.  max_io is a u16, and the sizes derived from the shifts
are multiplied by it in mvumi_init_data() to size three unsigned int
allocations, so a large entry size wraps the product and the loops that
follow then walk and write past the short allocation.  The list depth is
used as a shift count too, but only when the firmware sets
HS_CAPABILITY_NEW_PAGE_IO_DEPTH_DEF; a count of 32 or more is undefined
there as well.  Nothing bounds the entry sizes from below either, and an
entry has to hold what the driver puts in it: a command frame and at least
one scatter-gather element going in, a response frame and sense data coming
back.  An entry size of 32 bytes or less makes mvumi_internal_cmd_sgl()
write its element past an inbound entry, since it writes one whatever
host->sg_tablesize says, and makes mvumi_complete_cmd() read sense data
past an outbound one; it also makes the max_sg subtraction in
mvumi_io_attach() wrap, which hands mvumi_build_frame() and
mvumi_send_command() a table size no entry can hold.  The depth also sets
how many entries the inbound and outbound rings hold, and the per-command
slot index wraps on that count while the rings are allocated for max_io
entries, so a depth yielding more entries than max_io -- or none -- walks
the index past them.  max_devices_support sizes the target_map bitmap in
the same allocation, and it is a u16 while mvumi_build_frame() packs the
target id into the low byte of device_id and the LUN into the high byte, so
a target of 256 or more aliases another device's LUN; it is also what makes
the unsigned char loop counter in mvumi_flush_cache() wrap before it
reaches the bound, which never ends that loop.  A host reset runs the
handshake again, but mvumi_init_data() returns early once MVUMI_FW_ALLOC is
set, so the buffers keep the sizes they were allocated with while the newly
reported values drive the indexing: mvumi_flush_cache() then reads
target_map past its end and mvumi_sdev_configure() sets a bit past it.  The
handshake is retried as well, because mvumi_handshake_event() discards the
error, so a page that was already rejected can be presented again.

Reject an entry size above 29, which keeps 1U << n and the shift that
follows it inside an unsigned int, and reject one too small to hold those
frames.  Reject a device count the frame layout cannot address, which also
keeps mvumi_flush_cache() terminating.  Then compute the worst-case
allocation size in u64 at the top of mvumi_init_data() and reject it if it
does not fit an unsigned int.  That total bounds all three allocations: the
inbound list total, the outbound data pool and the tag arrays, whose sizes
are the same products plus smaller terms.  Reject a list depth of 32 or
more on the shifted path so the shift stays defined, and reject a resulting
entry count that is zero or above max_io so the slot index cannot walk past
the rings.  The shifts also use 1U now so that a legal count cannot
overflow an int.  Take every field the page carries into a local with
READ_ONCE(), and run every check and every assignment on those.  The page
is coherent DMA memory, so a second fetch of a field is not the value that
was checked: a second fetch of an entry size could turn a count of 29 into
one of 31, a second fetch of the list depth could turn 31 into 32, which is
the undefined shift the check exists to stop, and a second fetch of the
device count could put a value above 255 into mhba->max_target_id after the
bound above has passed.  Once MVUMI_FW_ALLOC is set the buffers already
exist, so only check that no reported size, max_devices_support included,
is larger than the one its buffer was allocated for, and leave the size
fields alone: they already hold the sizes those buffers have.  Only the
first handshake, whose values size the allocations, assigns them.

No realistic controller is rejected: one reporting 4096 commands with 64
KiB entries and a depth of 12 needs 512 MiB and passes unchanged.  The
device count is the one new bound that could turn a controller away, and a
controller reporting more than 255 devices is already one this driver
cannot address.

Fixes: f0c568a478f0 ("[SCSI] mvumi: Add Marvell UMI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/mvumi.c | 124 ++++++++++++++++++++++++++++++++++++++-----
 drivers/scsi/mvumi.h |   6 +++
 2 files changed, 117 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 18964e860ac8e..8b8e5545747e8 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -912,10 +912,23 @@ static int mvumi_init_data(struct mvumi_hba *mhba)
 	unsigned int tmp_size, offset, i;
 	void *virmem, *v;
 	dma_addr_t p;
+	u64 total;
 
 	if (mhba->fw_flag & MVUMI_FW_ALLOC)
 		return 0;
 
+	/* These are firmware-supplied and size the allocations below. */
+	total = (u64)mhba->ib_max_size * mhba->max_io +
+		(u64)mhba->ob_max_size * mhba->max_io +
+		sizeof(struct mvumi_dyn_list_entry) * (u64)mhba->max_io +
+		160;
+	if (total > UINT_MAX) {
+		dev_err(&mhba->pdev->dev,
+			"handshake sizes too large: io %u, in %u, out %u\n",
+			mhba->max_io, mhba->ib_max_size, mhba->ob_max_size);
+		return -1;
+	}
+
 	tmp_size = mhba->ib_max_size * mhba->max_io;
 	if (mhba->hba_capability & HS_CAPABILITY_SUPPORT_DYN_SRC)
 		tmp_size += sizeof(struct mvumi_dyn_list_entry) * mhba->max_io;
@@ -1054,30 +1067,115 @@ static int mvumi_hs_process_page(struct mvumi_hba *mhba,
 	}
 
 	switch (hs_header->page_code) {
-	case HS_PAGE_FIRM_CAP:
+	case HS_PAGE_FIRM_CAP: {
+		unsigned int new_max_io, new_ib_max_size, new_ob_max_size;
+		unsigned int new_list_num_io;
+		unsigned short new_max_target_id, new_capability;
+		unsigned int new_max_transfer_size;
+		u8 in_sz, out_sz, list_depth;
+
 		hs_page1 = (struct mvumi_hs_page1 *) hs_header;
 
-		mhba->max_io = hs_page1->max_io_support;
-		mhba->list_num_io = hs_page1->cl_inout_list_depth;
-		mhba->max_transfer_size = hs_page1->max_transfer_size;
-		mhba->max_target_id = hs_page1->max_devices_support;
-		mhba->hba_capability = hs_page1->capability;
-		mhba->ib_max_size_setting = hs_page1->cl_in_max_entry_size;
-		mhba->ib_max_size = (1 << hs_page1->cl_in_max_entry_size) << 2;
+		/*
+		 * The page is in coherent DMA memory, so take every field
+		 * out of it once: a second fetch of a value that has already
+		 * been checked would not be the value that was checked.
+		 */
+		in_sz = READ_ONCE(hs_page1->cl_in_max_entry_size);
+		out_sz = READ_ONCE(hs_page1->cl_out_max_entry_size);
+		list_depth = READ_ONCE(hs_page1->cl_inout_list_depth);
+		new_max_io = READ_ONCE(hs_page1->max_io_support);
+		new_max_target_id = READ_ONCE(hs_page1->max_devices_support);
+		new_capability = READ_ONCE(hs_page1->capability);
+		new_max_transfer_size = READ_ONCE(hs_page1->max_transfer_size);
+
+		/* Firmware-supplied shift counts: (1U << n) << 2 must fit. */
+		if (in_sz > 29 || out_sz > 29) {
+			dev_err(&mhba->pdev->dev,
+				"invalid handshake entry size\n");
+			return -1;
+		}
+
+		new_ib_max_size = (1U << in_sz) << 2;
+		new_ob_max_size = (1U << out_sz) << 2;
+
+		/*
+		 * A target above MVUMI_MAX_TARGET_ID cannot be addressed: its
+		 * id would land in the LUN byte of device_id and alias another
+		 * device.  It is also what makes the loop counter in
+		 * mvumi_flush_cache() wrap before it reaches the bound.
+		 */
+		if (new_max_target_id > MVUMI_MAX_TARGET_ID) {
+			dev_err(&mhba->pdev->dev,
+				"too many devices reported: %u\n",
+				new_max_target_id);
+			return -1;
+		}
 
-		mhba->ob_max_size_setting = hs_page1->cl_out_max_entry_size;
-		mhba->ob_max_size = (1 << hs_page1->cl_out_max_entry_size) << 2;
+		/* An entry has to hold the frame the driver puts in it. */
+		if (new_ib_max_size < sizeof(struct mvumi_msg_frame) +
+					sizeof(struct mvumi_sgl) ||
+		    new_ob_max_size < sizeof(struct mvumi_rsp_frame) +
+					sizeof(struct mvumi_sense_data)) {
+			dev_err(&mhba->pdev->dev,
+				"handshake entry size too small: in %u, out %u\n",
+				new_ib_max_size, new_ob_max_size);
+			return -1;
+		}
+
+		new_list_num_io = list_depth;
+		if (new_capability & HS_CAPABILITY_NEW_PAGE_IO_DEPTH_DEF) {
+			if (list_depth >= 32) {
+				dev_err(&mhba->pdev->dev,
+					"invalid handshake list depth\n");
+				return -1;
+			}
+			new_list_num_io = 1U << list_depth;
+		}
+		/* The rings hold max_io entries but the index wraps on list_num_io. */
+		if (new_list_num_io == 0 || new_list_num_io > new_max_io) {
+			dev_err(&mhba->pdev->dev,
+				"invalid handshake list depth: %u entries for %u commands\n",
+				new_list_num_io, new_max_io);
+			return -1;
+		}
 
 		dev_dbg(&mhba->pdev->dev, "FW version:%d\n",
-						hs_page1->fw_ver.ver_build);
+				READ_ONCE(hs_page1->fw_ver.ver_build));
+
+		/* A host reset does not reallocate, so the sizes have to stay
+		 * the ones the buffers were allocated with.  Only check that
+		 * the firmware is not asking for more than they hold.
+		 */
+		if (mhba->fw_flag & MVUMI_FW_ALLOC) {
+			if (new_max_io > mhba->max_io ||
+			    new_ib_max_size > mhba->ib_max_size ||
+			    new_ob_max_size > mhba->ob_max_size ||
+			    new_list_num_io > mhba->list_num_io ||
+			    new_max_target_id > mhba->max_target_id) {
+				dev_err(&mhba->pdev->dev,
+					"handshake sizes grew across reset\n");
+				return -1;
+			}
+			break;
+		}
+
+		mhba->max_io = new_max_io;
+		mhba->list_num_io = new_list_num_io;
+		mhba->max_transfer_size = new_max_transfer_size;
+		mhba->max_target_id = new_max_target_id;
+		mhba->hba_capability = new_capability;
+		mhba->ib_max_size_setting = in_sz;
+		mhba->ib_max_size = new_ib_max_size;
+		mhba->ob_max_size_setting = out_sz;
+		mhba->ob_max_size = new_ob_max_size;
 
 		if (mhba->hba_capability & HS_CAPABILITY_SUPPORT_COMPACT_SG)
 			mhba->eot_flag = 22;
 		else
 			mhba->eot_flag = 27;
-		if (mhba->hba_capability & HS_CAPABILITY_NEW_PAGE_IO_DEPTH_DEF)
-			mhba->list_num_io = 1 << hs_page1->cl_inout_list_depth;
 		break;
+	}
 	default:
 		dev_err(&mhba->pdev->dev, "handshake: page code error\n");
 		return -1;
diff --git a/drivers/scsi/mvumi.h b/drivers/scsi/mvumi.h
index 5d45f0d99e639..d20eea2b61a31 100644
--- a/drivers/scsi/mvumi.h
+++ b/drivers/scsi/mvumi.h
@@ -127,6 +127,12 @@ enum {
 /* size of the buffer the driver hands the firmware for event replies */
 #define MVUMI_EVENT_BUF_SIZE		512
 
+/*
+ * mvumi_build_frame() packs the target id into the low byte of device_id
+ * and the LUN into the high byte, so only these ids can be addressed.
+ */
+#define MVUMI_MAX_TARGET_ID		255
+
 #define DEVICE_OFFLINE	0
 #define DEVICE_ONLINE	1
 
-- 
2.43.0

