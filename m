Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6604A3F1A
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399002; cv=none; b=svIsHRJ/dUo6ki4fDQhZKy9AOMyMz+mRrWhIicN6a820cjCsR4Ij7Gbq+xzFX4JjEtyHMJNfOJS0YqBUsmce0wQ32vqW+TWzM1VQ3MrpEtxMEmZAb8ClAlTlx5MpfUnrSktEbSCmkSwteONuDqOko76/KE+JHyw02xC+FSjQC10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399002; c=relaxed/simple;
	bh=wopnKdIWquQ/19iqJ+7yuXZ+uNue8zlPP3xAl38VlP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZixbygwRprJurd6pVugCHpQ+9m7RI0pud/8/ce7q5k1LgZ/UMwnfr0jbLuxaZglGB93qHnaj3wnXlMFmTDdStvHz9PPhnr7W9+AvR/7XuTL4/S48piySU96FA0D1df/zGeNnYPtLEmwOBHfa0onEKxMKKY8IomXQGSuZoT16yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=cbMwav/M; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="cbMwav/M"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e5fb79ce82so8940305ad.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 01:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792398998; x=1793003798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XHO8V/wDfiBEINRArRhvsbbx6Jsua2LG1hGVoz5r0fs=;
        b=cbMwav/MduEe4QE+8peVSBdNdzulLpla3wI2ZY4h/2+ET8qgncd8zbm9wMcuiPKy15
         CMCjqDYi47hyd8wsvbxDtEcSL23Iv7WXQpaIYhNLPNMJ7MF5MXZEqB/OcKvgUhZjc9Gy
         Va311ZGojuT4Z0Aq0Wvt2Xd0rodzNhlJCj/WbKq0vVu5e0T25dn3rW0iZDGMvmXORSQf
         9AeVc5NMosU9NpgwPpWvDmvOLTxfKqWWYWB1Obd5Tw3tw59f40vbVLhGimVMyhdlZ2AP
         STI+bhxkpcLBtnAsxVZk0ZM1WhMU69BHjI/WCqAN2cP+B8lURw8cQgjHrt4CDllDrC/a
         QuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792398998; x=1793003798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XHO8V/wDfiBEINRArRhvsbbx6Jsua2LG1hGVoz5r0fs=;
        b=PwG4hyNOEKS/giwAUAixRCwJrNMCk1fpJoCLygd1IwzgxM4lT3t6ZqOArFD2J6k3G6
         4lOHJ9lH90rQqT0Q6Lz0iCXkI8Vx9tnaLGsQcRMrV70BkGCPHxrprzQpZvD83nd93mco
         ls5VluamQBKk6AoQuJmmOkR+/4+aFgPfAmaLQtH+bBhoTDqVdESoQHCpKl2x0HJG5ICu
         Sfk68RU14Rw3XeKaAkH/RV49zcSwpWoWvkg4TxYV1wEbnHYP77lliTAhJ7jUPvTpzblv
         F68DJwyJ1TG7ko64YZVGM5/YNA3XtyCT3aegHzlmGZzW8YMN9KiNDTSe9CdTq0S35zBe
         mfYA==
X-Forwarded-Encrypted: i=1; AKwUvBwOuFbizdLeXL+my++hXDj72o9tI/mmK24aerONMCKJiAB8tSeUgxP+5v3BaBwCWyi4kCYPekc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLupa4jpVulUdheHfYQ1CsBRibkGxv+jOVJ0NaQH4pVTBF0TEqB
	wXCHw1CHUq3jnJ9fI1D1TNcyG5AJ2I/MxvrKQvdJEI7N124E2+XwDv3S0wNL0tD1pqk=
X-Gm-Gg: AYBFou3N0Z51XCYT1MgR94S/kI6eiQ/NJzY1omJpcNI0z8LJiHlyCvLx7xVgEW4e0zv
	mV0cmenQ1gk/1aJZDOiA3YsujWV3H7xJutT+wXXHgxQyYihXueVM1t0U4ZRQ7aE/T/P2iKULlHz
	4+ExYJcj65G3tOtJ6+wru/uwTq7wC1tbQdGg3n/crd1iaPcpPTfcENX4JS/Pmk+Y8ud624bZ4J2
	kYhlsNaW8N4yWDntbvmOFKlmSRI5m2qB/gbvcQh0MD/TFqv6tv4SAnOOzyVnVxkFrFjCVI7nq2g
	WRmrNf4RG56fSaKiR824fEOuJ/HMfHgdz0HtzPsE4pWiCBsE+f6mv6s0KTSmMhUfSj8php/TqCh
	Xu7UQa/tzFxMvcnTMVNLUc70DgP2PiE58qU/T+YHv/P3f/o+5hSLF7Jz4nTeb6bdG1GMk2t2W0L
	BfyvZq3p9mkoJydPhGKKc2upI9dcmD5wadGApuKd1fhgzY32ZzUoCqbhJQakH/MpSVpZULA5scO
	QLg4ieV/E8SKQxS
X-Received: by 2002:a17:902:e84c:b0:2e9:6b5b:3db6 with SMTP id d9443c01a7336-2e9a69e93d4mr64066135ad.30.1792398998323;
        Mon, 19 Oct 2026 01:36:38 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804c11sm35469425ad.22.2026.10.19.01.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:36:37 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: skashyap@marvell.com,
	jhasan@marvell.com,
	mkp@kernel.org,
	James.Bottomley@HansenPartnership.com
Cc: GR-QLogic-Storage-Upstream@marvell.com,
	mrangankar@marvell.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH] scsi: qedf: bound the unsolicited frame length the firmware reports
Date: Mon, 19 Oct 2026 17:36:22 +0900
Message-ID: <20261019083622.718838-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qedf_process_unsol_compl() takes the length of an unsolicited FCoE frame
out of the completion queue entry and copies that many bytes out of the BDQ
buffer the firmware put the frame in:

	uint16_t pktlen = cqe->cqe_info.unsolic_info.pkt_len;
	...
	bdq_addr = qedf->bdq[bdq_idx].buf_addr;
	if (!bdq_addr) {
	...
	memcpy(fh, (void *)bdq_addr, pktlen);

The BDQ index and a NULL buffer are both checked; the length is not.  A BDQ
buffer is a QEDF_BDQ_BUF_SIZE coherent DMA allocation and pkt_len is a
__le16, so a frame the firmware reports as longer than 2072 bytes reads up
to 63 KiB past the end of one.  The print_hex_dump() under qedf_dump_frames
a few lines earlier reads the same length out of the same buffer.

The destination is not where this goes wrong.  fc_frame_alloc() is handed
pktlen - sizeof(struct fc_frame_header) and sets the frame length to that
plus the header again, so there is room for exactly pktlen bytes from
fc_frame_header_get() onwards.  Only the source runs off the end.

How much room there is was the driver's decision in the first place: it
advertises QEDF_BDQ_BUF_SIZE to the firmware as rq_buffer_size while
setting up its PF parameters, and allocates every BDQ buffer at exactly
that size. A pkt_len above it contradicts the size the driver itself handed
over, so there is nothing to be gained by trying to honour it.

A lower bound belongs with the upper one, and not merely for tidiness.
payload_len underflows for any length below an FC header, and
fc_frame_alloc() then takes the fc_frame_alloc_fill() path whenever the
result is not a multiple of four.  That passes payload_len + fill on to
_fc_frame_alloc(), where alloc_skb_fclone() and skb_put() both take an
unsigned int and quietly truncate it, so the allocation succeeds at a few
dozen bytes while payload_len stays at 0xffffffff.  The

	memset((char *) fr_hdr(fp) + payload_len, 0, fill);

that follows then writes a byte roughly 4 GiB past the frame.

Drop such a frame rather than clamping it.  A truncated FC frame is not
something libfc can do anything useful with, and the out-of-range cases
this handler already has take the increment_prod exit so that the producer
index still advances and the BDQ entry goes back to the firmware.

Driving the handler with a reported length one byte past a BDQ buffer shows
the copy running off the source.  The harness is a KUnit test that is not
part of this patch; it calls the real handler with the BDQ buffer swapped
for kmalloc() of the same size, because coherent DMA allocations are page
granular and KASAN does not track them:

  BUG: KASAN: slab-out-of-bounds in qedf_process_unsol_compl+0x336/0x10b0
  Read of size 2073 at addr 00000000627ca000 by task kunit_try_catch/25
  
  CPU: 0 UID: 0 PID: 25 Comm: kunit_try_catch Tainted: G                 N  7.3.0-rc7-g58161ead29e5-dirty #3 VOLUNTARY
  Tainted: [N]=TEST
  Stack:
   6133bca2 00000000 00000000 00000000
   ffffff00 6133bca2 61343506 627ca000
   613d1680 600c3c61 62893d00 6004301e
  Call Trace:
   [<600c3c61>] ? dump_stack_lvl+0x5e/0x7a
   [<6004301e>] ? _printk+0x0/0xd7
   [<6004fc1a>] ? print_report+0x14b/0x517
   [<603b68e4>] ? __kmalloc_node_track_caller_noprof+0x1a4/0x3c0
   [<60ada41d>] ? __alloc_skb+0x1bd/0x9c0
   [<603b6740>] ? __kmalloc_node_track_caller_noprof+0x0/0x3c0
   [<6004301e>] ? _printk+0x0/0xd7
   [<609437f6>] ? qedf_process_unsol_compl+0x336/0x10b0
   [<603e0d0b>] ? kasan_report+0x11b/0x160
   [<609437f6>] ? qedf_process_unsol_compl+0x336/0x10b0
   [<60932a10>] ? qedf_test_pool_alloc+0x0/0x30
   [<603e1cc0>] ? kasan_check_range+0x0/0x1c0
   [<603e1e0e>] ? kasan_check_range+0x14e/0x1c0
   [<603e2891>] ? __asan_memcpy+0x31/0x80
   [<609437f6>] ? qedf_process_unsol_compl+0x336/0x10b0
   [<600e147d>] ? os_nsecs+0x2d/0x40
   [<60944ec1>] ? qedf_unsol_oob_2073+0xc1/0x260
   [<602453a0>] ? ktime_get_ts64+0x0/0x2c0
   [<6071e2ac>] ? kunit_try_run_case+0x1bc/0x310
   [<6071e0f0>] ? kunit_try_run_case+0x0/0x310
   [<601d9b30>] ? sched_setscheduler_nocheck+0x180/0x220
   [<600e0e70>] ? um_set_signals+0x0/0x60
   [<600e0e70>] ? um_set_signals+0x0/0x60
   [<6016021d>] ? __kthread_parkme+0xdd/0x1c0
   [<6071e0f0>] ? kunit_try_run_case+0x0/0x310
   [<60724370>] ? kunit_generic_run_threadfn_adapter+0x0/0x100
   [<607243ec>] ? kunit_generic_run_threadfn_adapter+0x7c/0x100
   [<6016649e>] ? kthread+0x36e/0x560
   [<60166130>] ? kthread+0x0/0x560
   [<600c80de>] ? new_thread_handler+0xce/0x130
  
  The buggy address belongs to the object at 00000000627ca000
   which belongs to the cache kmalloc-4k of size 4096
  The buggy address is located 0 bytes inside of
   allocated 2072-byte region [00000000627ca000, 00000000627ca818)
  
  The buggy address belongs to the physical page:
  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27c8
  head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
  flags: 0x40(head|zone=0)
  page_type: f5(slab)
  raw: 0000000000000040 0000000061802140 0000000000000122 0000000000000000
  raw: 0000000000000000 0000000000040004 00000000f5000000
  head: 0000000000000040 0000000061802140 0000000000000122 0000000000000000
  head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000003
  head: 000000009f28b3c1 00000000ffffffff 00000000ffffffff 0000000000000000
  head: 0000000000000000 00000000ffffffff
  page dumped because: kasan: bad access detected
  
  Memory state around the buggy address:
   00000000627ca700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00000000627ca780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  >00000000627ca800: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
                              ^
   00000000627ca880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   00000000627ca900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ==================================================================

Reported lengths of 4097 and 65535 report the same way at their own sizes.
A reported length of 23 takes the kernel down instead, with
fc_frame_alloc_fill() and qedf_process_unsol_compl() the two frames above
memset_orig in the trace and payload_len still in RBX:

  RIP: 0033:memset_orig+0x81/0xaf
  RSP: 00000000628c3d68  EFLAGS: 00010246
  RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000161a2439f
  RBP: 00000000628a2c00 R08: 0000000000000001 R09: 0000000000000007
  R10: 0000000161a2439f R11: 00000000609128c0 R12: 0000000000000001
  R13: 0000000062740608 R14: 00000000611f1d40 R15: 00000000628c8000
  Kernel panic - not syncing: Segfault with no mm

With the length checked, the three over-reads and the panic all go away,
while a frame that fills a BDQ buffer exactly and an ordinary small one are
both still handed to libfc.

Fixes: 61d8658b4a43 ("scsi: qedf: Add QLogic FastLinQ offload FCoE driver framework.")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
diff --git a/drivers/scsi/qedf/qedf_io.c b/drivers/scsi/qedf/qedf_io.c
index a120f0e37a644..807202f575499 100644
--- a/drivers/scsi/qedf/qedf_io.c
+++ b/drivers/scsi/qedf/qedf_io.c
@@ -2504,6 +2504,15 @@ void qedf_process_unsol_compl(struct qedf_ctx *qedf, uint16_t que_idx,
 		  le32_to_cpu(p_bd_info->opaque.fcoe_opaque.lo),
 		  qedf->bdq_prod_idx, pktlen);
 
+	/* The firmware can only have filled the buffer it was given. */
+	if (pktlen < sizeof(struct fc_frame_header) ||
+	    pktlen > QEDF_BDQ_BUF_SIZE) {
+		QEDF_ERR(&qedf->dbg_ctx,
+			 "pkt_len %u out of range, dropping unsolicited frame.\n",
+			 pktlen);
+		goto increment_prod;
+	}
+
 	bdq_idx = le32_to_cpu(p_bd_info->opaque.fcoe_opaque.lo);
 	if (bdq_idx >= QEDF_BDQ_SIZE) {
 		QEDF_ERR(&(qedf->dbg_ctx), "bdq_idx is out of range %d.\n",
