Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B303C109E
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770883; cv=none; b=JJdPBg40J8KuBGQvkPEEVLCuxScZb8FcFJsJuSb2yCsggL4zTW6I+AO/NyeqqSbIYBT/7lV3HhZjD1dVEYQzD92d34tFwo1tS1BJRNMYD+TxxE3IIQyPnl2KkOXruXB6jbQF7TVNQGUnTcPdDM69U2+QVg338j157WYPlYK964E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770883; c=relaxed/simple;
	bh=iYllAYpYLjNYVzLXFFNLX/0LIc+g4q/kxBDArGrOOz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wh7/tVYqddmzTW4pWwGnd5iXFczyepbo4eaAr86SWOFafiE74KuWsF0pHrsH6FwY/B9i3pd3ht4zRlERZIsigAixxRfm3BzfbAz0oQ3WW/ThuKYqyVtGDw1csnh8G2JTrLKV8nqTtppMrPkne0zusDPhR1ROejeOanYK9QHt454=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw4vbcLd; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw4vbcLd"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39f20d19895so22949391fa.2
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 01:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788770880; x=1789375680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eCysfBdSaswXCoCnyfT/qF6SoSQk8nC4YJJgNomp5wA=;
        b=bw4vbcLdQP4Jn2kXmmOqiCyYtV9UDlTQNJNwxjpsmmP7b6RiccaSs9KK6k/AaQZKim
         3azk63/ucVe0vNvsxBbMOqntHYqCFXJt/+DS/cTFGizxWxWYjhhydyy0yRBt7h0oFsyz
         7CWq9YHa9ozuvvdbjetoKQJStkk8einEYRAIBEtYVbYR4As4igCW3C1DGG61uL/vOuTD
         g+IK6phq1alymf8Gk2kvyNl/afRh7eV0eI1si62a4ZKAMtKkMDVqwqYhcymRgyQ9JJs9
         fpCOJzTJV1pbUSk6bEkzv8jqQIIqAxyaDflUag8LTgELf1BiZsuxIUxFRwH4J/N7iclR
         7/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788770880; x=1789375680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eCysfBdSaswXCoCnyfT/qF6SoSQk8nC4YJJgNomp5wA=;
        b=tMq+1swQ1E52pjX9PNA5s9RlV0t7yRbVMJov11TWzJMoHNaxS2hP780MQgJNRrEX80
         QUQPLQvFcDbCwAenDkwjCooa+KliOozTN6cjlQ2ZceyurpFcLps5tcqvhsmY3dwr8I4Z
         RnXzLGg+6FrZMEW3+pYvEwCjFEivN7GAoCru1s5OREzri69HSQoENJSIsZCve9/+J44P
         3UdEKsCriS64Z2QtSLk6nfxH2ULy2ZcDHtrhF6DZWpJl3ECAl4wnFWUCwk1MksTRRm/w
         roSIep4dbhcL+qg9iQ1SUR9rNBA54zzS9v7ctd5o8XXMzM1rKmzH6nsKqeW7CuEMGN2z
         XJeQ==
X-Gm-Message-State: AFuF++n+1e2NITKuiUoqeR9PVAgcqInW3IW/uvuMJ5+Y0a39+wwSwtAW
	qk+VG/lm3/4em8j3VEw5ak1lHI1ootxBkUgqEP/h+NP34urixbCpBsBdQwpQIMcFKWkS8Q==
X-Gm-Gg: AYBFou2vgmynoo+j7IG3Uvni8MZPDN+96jK3GKfpq5j46uFBgTHt1vDwYPGzSEUNT2q
	Y9a1OTYl+Zc4WdC8BfgZiMd+a/nSAKIjBK1APq+q+uJX+Q4QTHF1s5RwbOiHHRHicIPxQ9F93kw
	N9KLbBntgJaW2JQxzRmncGSeI9pFWGkJH05XUquEgLiqLViKpnFrnNGaeHsUfwgYH1CH4NWnh97
	ig77N+fjw7kHCSoLcj4ibySd7RZHPlvWhzKct4cmyAcW90BQbyCcGIhaJLvjnLRe6BEnyGajXOn
	JGDziJOCEl9tMjYpXAp8ioQoKNmzYOYYb8cf+f5GHz7tT4qm0rCimYh3wWdlN2VVy8MdHCRXcpQ
	j2/AFLt38ByJzmwpB5Ti0lGiVkMhSyCLnwtQBsVxHjruffgLdxsmDpXB4AQgFjXwGuGoWLh2MYi
	22Z+A7q7/QCWKR0vWbM45q/6KUa/BVO06wf5MV1V0/mBoT+mLJKD6Q
X-Received: by 2002:a2e:a7cf:0:b0:3a1:a1f6:3af9 with SMTP id 38308e7fff4ca-3a371ae82a2mr23211451fa.5.1788770879804;
        Mon, 07 Sep 2026 01:47:59 -0700 (PDT)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a3c2925448sm21293701fa.7.2026.09.07.01.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 01:47:59 -0700 (PDT)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org
Cc: Petr Vaganov <p.vaganov@ideco.ru>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Petr Vaganov <petrvaganoff@gmail.com>
Subject: [PATCH 6.6.y] scsi: core: Fill in DMA padding bytes in scsi_alloc_sgtables()
Date: Mon,  7 Sep 2026 15:47:47 +0700
Message-ID: <20260907084747.100011-1-petrvaganoff@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090345-morale-uncharted-466e@gregkh>
References: <2026090345-morale-uncharted-466e@gregkh>
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
index 2268e540f28a..f3514b45ef30 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1087,8 +1087,10 @@ blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd)
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

