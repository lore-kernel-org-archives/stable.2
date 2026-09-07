Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471B449B12
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773266; cv=none; b=XUNjYFbjLVd1K+LPMUCyCU5CJIv7Q/0PgbpXo98Sdv6iaMCUAJk7d0xEXbXwSRCfQmi5K28ktvl70Vckf6sl+UkXc4f8Hxva9c65xlBfQ/AVT2gdkvJXkMwb8fsEf2lku4AehbqF3RllYflKQqrjPscjFd1IGlmrtIylgW9af3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773266; c=relaxed/simple;
	bh=OQGHhOimMWJiT+56v9fDBHZ7O7Z5PCry/WZoftnzeTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zl2E0SUjL5ZJ+HCb6kX4VOwlAXkjLLqnNK/JxIHWPGLma2yqcUY7zD0+loNiwKkERyGJIrswDJ8J8LX6VSvyZHfIWfZXE3C1l59kX0r4Vo5KEGL4I9nVeGlZ/V5HyouRjL2zVqSs9U7VctTGM7DD0O/VgiYTLuqHymFRzk4WUOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qaBWb9qt; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaBWb9qt"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b6188a2c0eso2472351e87.1
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 02:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788773261; x=1789378061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aLmXdIvC7otFcdSv6+vMZu4fSoyu9UDgG1ucZ5dWmZ4=;
        b=qaBWb9qtCZs2/DMPthBp75TCI0UJ1mlTuburAxLjLj8P7Q0AhGDrNMqLuT294jsjr+
         EIKKA/Hy1fd18V6IYnLyfGoNQ13c7GBcFLnp/0IyZCmhi6B8B5/4lkWLzotrx0Fmbm6q
         EdKjPoVjOD99fS1E+d42ZnxYKBj7A4WvwK4IVEKCy4dzZqxnqqjJhZCxM7FDL9KPsekb
         HiQ+joXzb4orDKXP7iWDtzRtUkB5gAGWtx8Xul3hkNVAms0LqYGVbzpPSYzZrMP2BHOx
         wh903Wx7yV3zaLLfgfClqgWBlpnGcLMGllIDQpYY61PKLXI7HeYnhR9eT2KAetVn/V0c
         RTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788773261; x=1789378061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aLmXdIvC7otFcdSv6+vMZu4fSoyu9UDgG1ucZ5dWmZ4=;
        b=MmZNtrctndPN7aQQfFw+/6UIatsCyKSdidz/iJZDrufC441R5w1k3E/6GBWbhDeX7S
         BDVTJsAcNYKYY0JbP3EWhzy2enl3IJI/eJlSrwOFea8JEMQDPqSDDEbM4Rj1IDj9HNEy
         B2DwocS9D8C92fJQFRZNGGna5jLoEEC/FCxGMN17/t2FUEYPzgiTR2mgtC5DfE5rWlJx
         drM0btp7B2hlcr7T+uqwHi6NadAdLFYSF8vpYlY8jAUJiYz/oNjTdPERvDSuV4oftCij
         +MR7nlvtAgpgbmbYRaumq/XokiJ9twC3zj3iVU6jelE/2znQ7alO0fCP0MJw2IJ7NQHb
         kIQg==
X-Gm-Message-State: AFuF++mTiBDmgT6jgzDjqvNr4CMTSr75jeoheo/0IElydKeuYPkDJr8F
	NXmgJ3jsclhBwPTZXbvg7zZnjqe5yRw1M2uvKQqGCgfyHk7h+rHAzCHzJXAqkUN+iug=
X-Gm-Gg: AYBFou0y1SuK/7t4XRCWrCOqVv0gzomLUKYtPOTk906gjkJq8jE2rFob6vHf2on17VP
	UmC3UyDLw6TRNbhs33TpkIEhhX6JZJrv67VkCW7pm3/w5vknkNhH3kowdxPA7iTzyQ9eCCVfpHW
	zQIj25HxYl3xLZpjCvsN7062i1bHd8TV5FX6tLTWlz/3m01eeL49PIiX9MTeNl4l3IrIDx+YENB
	DrZ87YY3EGlnSq2kh1W4acn663bK/aiMg0zPUWhpio/H0GlxGjfm+x7DnyUCSZ518DZjRiXjB6P
	MUieP81hVJqOwy7hjU4dALNEIsELJZnNH9eCo5ISYzcJX2jgQVuLLjTTdEV2sMSsO/JkK9TqDg9
	bTj1FEvghOOoEiEfkbu7cKDYbkgQV2DDNAz8hr4ayD0S30lM0wxOu9yaAX2iyQZ7YH4g+qqwYvA
	281c4tnt9pg47zdlS4bet/7iVnP4JYmJY42JvDK3b2MkDJmUpn+0Uh3Hc1hkoJvD8=
X-Received: by 2002:a05:6512:3b0f:b0:5b6:1a7c:fd7e with SMTP id 2adb3069b0e04-5b61a7cfe44mr3612949e87.36.1788773260768;
        Mon, 07 Sep 2026 02:27:40 -0700 (PDT)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b61670a6afsm2196077e87.77.2026.09.07.02.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:27:40 -0700 (PDT)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org
Cc: Petr Vaganov <p.vaganov@ideco.ru>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Petr Vaganov <petrvaganoff@gmail.com>
Subject: [PATCH 5.10.y] scsi: core: Fill in DMA padding bytes in scsi_alloc_sgtables()
Date: Mon,  7 Sep 2026 16:27:07 +0700
Message-ID: <20260907092707.274040-1-petrvaganoff@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090347-slacks-jogger-bca8@gregkh>
References: <2026090347-slacks-jogger-bca8@gregkh>
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
index e69d1c0ea450..aafb3ae0e860 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1050,8 +1050,10 @@ blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd)
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

