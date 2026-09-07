Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05D84457A6
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788771812; cv=none; b=qcLdakubD64RW07i1f+kvwKqXxmNQh6xV2gbbLNS9EPT9iK1UuR8bBlIbjJHIOeZBNna4McA2/YSfEzg180Mgz80ZJQk1N5mRNuG0fbwXkXVpFaHyjascGCR6BDN7bY0smIobwauroZiqbjdQ70sJqVnvFhHA5T8RzoxvUqpIQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788771812; c=relaxed/simple;
	bh=IBat2F4HpVH7S2tpsW6urqs0aMIjKe3j2kdUcWTNFN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=me/yQzqddo81+7TA65vjXfUcolAWI+14Fb2pESyAZCuRkl+Vx6ZaaB9hSK1HY1fE20ceIZfbqGCojwFR15zOZKQNQ4pEeIT77K1/itz7Aj+pJLxGQJUos1HFNmmCMAsRg7751X+66UuVcUog7rRsLsvs858Q3a6UdUbs4jn8fZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9FPkgGw; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9FPkgGw"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3a1eb6fa0f4so31720591fa.2
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 02:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788771809; x=1789376609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=db03j2FqvfgimHR6SIVLbrBbnT7H5eUuyGmnk1wbMBc=;
        b=o9FPkgGwmX9em9vexM9tD+SFmbhVX+7w++XpIyn3uSXg+O9aBwi1GVUFWWMjvH30y8
         Hcwlvy0zntikgyb65g8UDPKSddFCKI8iPWdMbkbww4ySSzZz+lfLUu1l4hh7gkpDfjl+
         0HXC1E04ovwB5drtx9AVK4ahwdtGrgO2k7wnx91oD3NalYZgPGbSYYXRMTblsQRN57Np
         b5i5MQ8wi5ZZ6hlTi2TDEGVTTB7sx9h+wcz92XWEbuIQTNDQ08IfNFfKslJBQycKZq1L
         PnTPX2KaWlA5To9QMAG0UaaiPGs/cpcq0btxX89e1jyAJQRtmLEvBXDaaIapr4fq7tst
         53TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788771809; x=1789376609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=db03j2FqvfgimHR6SIVLbrBbnT7H5eUuyGmnk1wbMBc=;
        b=MdPWs6XODJ9z6rcQ/Ea2g61pzo4qHYdRLu7DQ/au6wpixE7lgi6yLY0nGObsl2yFp2
         9PtnUw4kTUY/CuqBcLsdpOF+YUauPLZWP1JSGisVSfJE8DeyH28MbY8oPAfJjcljtJH9
         IURv/NTcsYWBEWLJrIt75otTR6M6QsuCeV+xeiP94kisoFgd+gNmLOv1J2TQnNr7lipv
         tdFVRj5e5jKa4H2DWQp4qDZpXhoznJzPs79/kpJGmsNOhJA3IVwAh/gs19ybEQG6GnSO
         iEHXoH44gWxPXnmYAa04nPTvFl/XwqNGfhZUa66DSepBuyUOAkM34Yxy83wL4Na+jx0h
         Sl3A==
X-Gm-Message-State: AFuF++km5FnJhRr8raH8wB5M1DFBDJf3pDk7zlaI41Ic04RLwLlS3abP
	ooB1RtCa3csr7xJZBbays7grNskESprExIkcDwsrt0jT6jVFDjda6BndLTx/IXNHYYo=
X-Gm-Gg: AYBFou31/R8ycBxnFsQjSNckxUf/FjweVwljUGBYhK+sHvGFM3tn8AY64skwQtnoF+l
	Sc4TXQkQrhv8pyidgs99wvwUbRhQBdoD4GYcaD2AsQUaVCRJyjLQlO89iFdOg3FkKJ6zVVCwhtm
	4Nvt6ey42Ca9nk4URhjaYrLz9W1o3kfdGuxVT3wG1JkqLB2VARX+/vPdwm6wBAk0TlGd+I6GF8u
	j4uKJoOSNthTjcwVCKMMVGs3FAfv7VZWEM/WJgTmlhD+/WayEFZ6G/EYLkavNENrIyP+UL2RJ3q
	SMR/VsBNwcpODa2B/da39BcCsIl8cXAEa4hFrZG55D8RnavdwHBZiJVHkS5wOFKb4P5effyqppU
	MYw33lRtacchqVieLDJsSpTeD5uhZUb6ee3b6my2OopOHnttevNCa6flDLqps9iUbYKJlgtSBw7
	54ydMp2bI5bZZ5vCHxcdI6Rr+51AID8+yZh99vXjV1dbk0EqRlIR5A
X-Received: by 2002:a2e:bc13:0:b0:39c:624d:82b9 with SMTP id 38308e7fff4ca-3a371b5785bmr49752601fa.4.1788771808109;
        Mon, 07 Sep 2026 02:03:28 -0700 (PDT)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a3705cd8d5sm26008791fa.37.2026.09.07.02.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:03:27 -0700 (PDT)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org
Cc: Petr Vaganov <p.vaganov@ideco.ru>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>
Subject: [PATCH 6.1.y] scsi: core: Fill in DMA padding bytes in scsi_alloc_sgtables()
Date: Mon,  7 Sep 2026 16:02:53 +0700
Message-ID: <20260907090253.167962-1-petrvaganoff@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090346-overboard-amplify-cbc7@gregkh>
References: <2026090346-overboard-amplify-cbc7@gregkh>
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
Signed-off-by: Petr Vaganov <p.vaganov@ideco.ru>
---
 drivers/scsi/scsi_lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index ddc986ff5161..5c56e942758e 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1070,8 +1070,10 @@ blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd)
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

