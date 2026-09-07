Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A547448CE9
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788772374; cv=none; b=oD7YCRybL4cFfx/8ycK+rd7BIL30DxaZNDXqjOWX9c3iaZ+yF9Eq1IGe0L1/Y2H1OSe/HKhbYUpLxWDsOBN5oqMA78QmksX30jUqlYDzhLLg4JGiDXZbs1aT3UnUD5Svz0ojiKv2FFkEwiwbfA2kM33JmWCUv8apat042Ul+2J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788772374; c=relaxed/simple;
	bh=4J6WZCG/YG/QcuK3aBtsn0fuos2tfFPEbIVqDbAVhdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbD8RUXKoHRvyl91iprFdIMR+Qcpfi682mtZNDD20pFTcrE27CPIMjrOuhw5RV+dzq8Ky699Y7QKMrpEWEt83DGWSQ+O8ZbH+LNWscFDemJXhDmALPPbwWeGLZUPBJlws7PnKrFASzlIH6VX+Gc41p3Wzpc2UB1gm8u9662QxFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=otxZQngK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otxZQngK"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4957eefd361so25609945e9.1
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 02:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788772368; x=1789377168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wap/fOZDqhUteZnk8Ja2Ne9RxPlryraWqyX+TCsk+IU=;
        b=otxZQngKb0HUkYe4eiQ5v7ST1dM2lY/IJGkqmMLMkk0kHCRTIlMOTWqpBItH0u68+6
         zA/lrXhrxu7b3aq1ibiYMk6jDPD94XeSnH/eSOOj77eGvABDYOgox+bftN0ex6UOJccq
         ufXuFVtXXyEGRxi/xPtBhOh2MbkKTCN86uWZoyQdJeKgkXTrVX3O8HR6/iwdHYqIL7Qj
         PEQBrzSLmGgi5E3/iG/ikP/AYqKOTpQzkXCrjdSN/Qu9bO2yDP8NVljpBX4eht7iMpNw
         GfyPWxc8UhszCR2VRHNGqm39mtgjhaQeqFmgmG7d6lON80A5Fl4Gex3lXuMSnT5iUJaT
         MSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788772368; x=1789377168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wap/fOZDqhUteZnk8Ja2Ne9RxPlryraWqyX+TCsk+IU=;
        b=c/O9E0p5anxfhzl52L/m946YS2cu5DSNXOGR5LxAAO9gXIfhMDLDqneJoafWmZ76t8
         Cs50PB8qyzzvuInueg1qU1HHOZKvu6a583ModxWZwv1FEr0GJzg9WhR6xFGd45ddX9BT
         QkWm0zGYzprICHis96erstK0vws5mwSbzAWm8XvU2fHwXRBC7GsdfWRGOtKFNlvd+38Q
         hE7/+ArLsF6FW6SukSWAlO2Lo1DWry6FnNmaUcRkampOnPHhgAV4PebLynZYhrG3rfj5
         e2sfuiNTNBtiAlP93oBfZd32Dsp9L0FMbDHiTte+noIDLv5kGbPZ24x9gX+G2gOj8As9
         /r4A==
X-Gm-Message-State: AFuF++lHnVhi3Sy/tHlFDP3+ev5RzsNkeX06KWtSqu6QrgHjqWcdzQXF
	Sk4zgHwmjA1fYv1qFnljywyiKoEQy6y3cHY1dow2IGNJiHfcvQjW6/xgn3JFBi5RCeQ=
X-Gm-Gg: AYBFou0SATS4gpKMcB0PzeEyIXbuqcfyul/GXaSNr7p19C6YDgJtcqkgEOWhE9bfjqh
	FUiVcNdm6Z4YXKUmmh9c9gbD/OqIPXwWFyScSZ1OJbsqxdWJ1946CPROBaQ/WGZ919VFGEXv+ec
	q5apByKXYhJyXiPfqnEIUTyURtZROuv2BsJiYdTC2n6RWmmT7DDLTg9XlElaj0jPCZd7rIERqvx
	oS4op4lOpqgJz6J/m2xm+E1exwc/X3VUM7RanaHZiaP0xaPDb+/znbhhGmmj82SesTcAVUtn7qe
	5yCzOivpV712+WEalUIHdmnbJifhEvdY99+D7BhhUHgvf2td8ZmujkTGZueeD24+wCNm1yuUQkQ
	nRVU7K1FMHwviZ3wjgqfRPzqHnYCZEo38Ao7+vQ6cJ6WiIX2bUz+qNQLYqY7igOmSEhnILpeXHk
	3S5aBj5iQKOz/3JnrpbN/Q3PdmL0xWGUs/QH03svl51B8rMy8E+ilO
X-Received: by 2002:a05:600c:3ba3:b0:49d:e79:612f with SMTP id 5b1f17b1804b1-49d0e79635amr61910295e9.26.1788772367096;
        Mon, 07 Sep 2026 02:12:47 -0700 (PDT)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d03543064sm203883405e9.13.2026.09.07.02.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:12:46 -0700 (PDT)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org
Cc: Petr Vaganov <p.vaganov@ideco.ru>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Petr Vaganov <petrvaganoff@gmail.com>
Subject: [PATCH 5.15.y] scsi: core: Fill in DMA padding bytes in scsi_alloc_sgtables()
Date: Mon,  7 Sep 2026 16:12:34 +0700
Message-ID: <20260907091234.218309-1-petrvaganoff@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090346-baking-kinetic-a739@gregkh>
References: <2026090346-baking-kinetic-a739@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petr Vaganov <p.vaganov@ideco.ru>

During fuzz testing, the following issue was discovered:

BUG: KMSAN: uninit-value in __dma_map_sg_attrs+0x217/0x310
 __dma_map_sg_attrs+0x217/0x310
 dma_map_sg_attrs+0x4a/0x70
 ata_qc_issue+0x9f8/0x1420
 __ata_scsi_queuecmd+0x1657/0x1740
 ata_scsi_queuecmd+0x79a/0x920
 scsi_queue_rq+0x4472/0x4f40
 blk_mq_dispatch_rq_list+0x1cca/0x3ee0
 __blk_mq_sched_dispatch_requests+0x458/0x630
 blk_mq_sched_dispatch_requests+0x15b/0x340
 __blk_mq_run_hw_queue+0xe5/0x250
 __blk_mq_delay_run_hw_queue+0x138/0x780
 blk_mq_run_hw_queue+0x4bb/0x7e0
 blk_mq_sched_insert_request+0x2a7/0x4c0
 blk_execute_rq+0x497/0x8a0
 sg_io+0xbe0/0xe20
 scsi_ioctl+0x2b36/0x3c60
 sr_block_ioctl+0x319/0x440
 blkdev_ioctl+0x80f/0xd70
 __se_sys_ioctl+0x219/0x420
 __x64_sys_ioctl+0x93/0xe0
 x64_sys_call+0x1d6c/0x3ad0
 do_syscall_64+0x4c/0xa0
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Uninit was created at:
 __alloc_pages+0x5c0/0xc80
 alloc_pages+0xe0e/0x1050
 blk_rq_map_user_iov+0x2b77/0x6100
 blk_rq_map_user_io+0x2fa/0x4d0
 sg_io+0xad6/0xe20
 scsi_ioctl+0x2b36/0x3c60
 sr_block_ioctl+0x319/0x440
 blkdev_ioctl+0x80f/0xd70
 __se_sys_ioctl+0x219/0x420
 __x64_sys_ioctl+0x93/0xe0
 x64_sys_call+0x1d6c/0x3ad0
 do_syscall_64+0x4c/0xa0
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Bytes 14-15 of 16 are uninitialized
Memory access of size 16 starts at ffff88800cbdb000

When processing the last unaligned element of the scatterlist, it is
supplemented with missing bytes in the amount of pad_len.  These bytes
remain uninitialized, which leads to a problem.

Extend last_sg->length by pad_len first, then use sg_zero_buffer() to
zero those pad_len bytes.  sg_zero_buffer() uses sg_miter internally,
which correctly handles sg entries spanning multiple pages and padding
that crosses a page boundary.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 40b01b9bbdf5 ("block: update bio according to DMA alignment padding")
Cc: stable@vger.kernel.org
Signed-off-by: Petr Vaganov <p.vaganov@ideco.ru>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20260628185229.37957-1-p.vaganov@ideco.ru
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
(cherry picked from commit 626147717bea776b61ed3631d2c26283760c4cc4)
Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>
---
 drivers/scsi/scsi_lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index c8be41d8eb24..535c6033a71f 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1015,8 +1015,10 @@ blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd)
 	if (blk_rq_bytes(rq) & rq->q->dma_pad_mask) {
 		unsigned int pad_len =
 			(rq->q->dma_pad_mask & ~blk_rq_bytes(rq)) + 1;
+		unsigned int data_len = last_sg->length;
 
 		last_sg->length += pad_len;
+		sg_zero_buffer(last_sg, 1, pad_len, data_len);
 		cmd->extra_len += pad_len;
 	}
 
-- 
2.55.0

