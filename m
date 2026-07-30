Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AC834A795
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411423; cv=none; b=LDOYmVcEuT6a/aKpKe+9DHyJyEhitzB/Dg3rBe/9tX34Swys8WYH8BjN8ZaFfTzyulciE4XdU8zUwcOtAJaHoX21MfdamMx+uNjUtyXI3h3eU4ldG+QrM0Wv858JQL7gDsNKz3qR1Hzb8EdsOIszooQJsmzX/b6IkJQ9Mgxwu3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411423; c=relaxed/simple;
	bh=SlgTXtVtVi98/BMUZjfbFZsDZFdrxEjNl1RTcKKdLAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D1L/H7jN6J1JVazPmBCbrb2N5mlnuChsljdaOvNJsvYhVVAq1fpuEaSfVwWpYQPZgKbuoViijuetNdaodRQZ2Ap7GrB/FFfNcGqWLnjRdYyt+KIGPyCW1gYcQKLhSRl7NFk8OPJqXKlGAxU5LieKY+xUO7m4R8G2OFGckC16AZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=HoqFjqmf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="HoqFjqmf"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cf52d15d88so18794505ad.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 04:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785411420; x=1786016220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=voVALDzUnmupBJEHA5KagX/vzlVJlXbPxhsRhxAvPsI=;
        b=HoqFjqmfEbv7oO22nKo2J7B3pKVC0t9UFqFRpnUeXvZfZYZNRcsY1bJH+8Xi/nCDzK
         y0bb87kIdrYpd0Fs+uoGkYLcIwCM0w0bePQgD1Elf6Hdwt8ouSOZO5shodQc628IkfCU
         q+bC5m7vjZ6ZPS8WAQ8pgOPP2FpuNcwfK0/9AM+Tf5oqWPx93GrtCcIV59lVvrUYGlit
         tC/rvVB369esu3raHuV15Tq9Q5T6D9utGY4iViWCxjPPQfjVD/CXcG2HJftjep8f+uYS
         C2vRC0wSe7ghxeZjsIKWDg7nZH8bOeQ9eePytlzbA49JYwU2d41MQXbs+2f1OcqjB77R
         jv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411420; x=1786016220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=voVALDzUnmupBJEHA5KagX/vzlVJlXbPxhsRhxAvPsI=;
        b=N5g5lZlJ7SCT28dzz3mXCwZk7TW/j3K/SI9lVtuIreeyEPBIxT+Ym2+72XKf6Q/JCL
         BZJZ5cwLr9RPYA6GG4gUYVl2Wr2t24XJoY4BiUonRsY9iQTcrQF6GFihEui/n63V0hhf
         keFYYqMutazkpHNU/aBMpO+3xNjRX5qmWA0fqTpKoIQpBJKb6neFYD1xVqgNZnlf5OS3
         Xr5tt6++M6LV++d+WzOOtrXKM7yBRsznm/bV0zcb9izcI9VaG2P8+B2dWtVLgLDMB2GI
         rKWgQpC975qIb1scG7WYXiUmUriT2w31mF6UysCjiiUeI9Kfik9EsoYwvb6ibWWl1JV+
         5GQA==
X-Forwarded-Encrypted: i=1; AHgh+RpjWaC1rSxUJ5NIr6/293zSDCtV9QqcdaOy065MsLa1TeJb5Z3+cJCvdiWdHKhYlia+NryrtfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwPXVszqFPG8ThTYzSmkrVNYVr/ietLzrKGy0Xr0G5e50eaE1J
	H1XBgrq6i1oyIQ2hWmUcgVMWIoYRbrRa3h9OzwGVr5RTbvIyTZWMAGczgWkBFypzA4E=
X-Gm-Gg: AR+sD139Tpcln2trdqOcVbabT5XOIsxLwzmbp9KQSU5MYcMd/9IecTatqKDgvOWnDth
	xYoMGoJjfLEPlom9uPTGjXLdu/bcHzlYhJ4DB6fcDlZxP5DV/hqSxa8HMpVmrz2xf8vZKxKdSOj
	ow3FKWUVgeiUm3OZAuAaHbDCKF3tSsAyUHoguMbn4FGwufe9SdO2pFHn4p+aA3JXyTE5AjS/82N
	AcTTURPd4aZzMm66HRGhtx+o9dRQYGnM4YZEAurMEJFGzYwd3yughkWXZlm/NyMIrpXUomErfFV
	Hpv2aJEjCrn6+QvGQ57t4FIPi9boCMlThpFUrYQnpELLJ+viBroOBv8gOyQBYCzD4XmL4dkMcaF
	lABAM4uigVw35Pu8m32YgEXRXlTO1z3Sn+Ey5YYOzIUE9ZazxKTdFKW2WAkowlb1VEPUtOtASyE
	kmVetbM2BXX485AxtA82qti2VItC+NaJARUSFSfZ0Pox+NEAPUq/pFXo9Vppl3x4wrnH0X
X-Received: by 2002:a17:903:1745:b0:2cc:df15:91f5 with SMTP id d9443c01a7336-2d035d14d1cmr20430405ad.44.1785411419868;
        Thu, 30 Jul 2026 04:36:59 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c1b529sm25328235ad.69.2026.07.30.04.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:36:59 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: eduard@hasenleithner.at,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] nvme: zero the discard fallback page
Date: Thu, 30 Jul 2026 20:36:24 +0900
Message-ID: <20260730113624.1605213-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme_setup_discard() always maps sizeof(struct nvme_dsm_range) *
NVME_DSM_MAX_RANGES = 4096 bytes as the DSM payload however many ranges
the command declares, because some devices ignore the 'Number of Ranges'
field - the Fixes: commit records two that read past the declared ranges.
A single-range discard fills only the first 16 bytes.

Normally the buffer comes from kzalloc() and the other 4080 bytes are
zero.  When that allocation fails the code falls back to the
per-controller ctrl->discard_page, which nvme_init_ctrl() obtains with
alloc_page(GFP_KERNEL) and nothing ever zeroes, so those 4080 bytes are
whatever the page last held and are handed to the controller.  Reaching
it requires the kzalloc(GFP_ATOMIC | __GFP_NOWARN) to fail, that is
memory pressure; it is not remotely triggerable.  Failing the allocation
under KMSAN reproduces it, with the leaked tail full of vmemmap struct
page pointers.  The extent in the report is a partial transfer of the
payload, not the whole 4096 bytes; the 16-byte boundary in it is the one
declared range:

[   11.991601] BUG: KMSAN: uninit-value in dma_map_phys+0x14c8/0x1900
[   11.991969]  dma_map_phys+0x14c8/0x1900
[   11.992220]  dma_map_page_attrs+0xcf/0x130
[   11.992485]  e1000_xmit_frame+0x4099/0x6d10
[   11.992768]  dev_hard_start_xmit+0x22f/0xa80
[   11.993068]  sch_direct_xmit+0x35c/0xcb0
[   11.993315]  __dev_queue_xmit+0x1ee5/0x5eb0
[   11.993608]  ip_finish_output2+0x1903/0x1c30
[   11.993881]  ip_finish_output+0x288/0x870
[   11.994125]  ip_output+0x15e/0x400
[   11.994365]  __ip_queue_xmit+0x1e85/0x1fb0
[   11.994639]  ip_queue_xmit+0x60/0x80
[   11.994899]  __tcp_transmit_skb+0x4e71/0x5fa0
[   11.995210]  tcp_write_xmit+0x3a36/0x9160
[   11.995533]  __tcp_push_pending_frames+0xc5/0x3c0
[   11.995854]  tcp_push+0x7dc/0x840
[   11.996076]  tcp_sendmsg_locked+0x766c/0x8400
[   11.996371]  tcp_sendmsg+0x4b/0x90
[   11.996572]  inet_sendmsg+0x134/0x2a0
[   11.996823]  __sock_sendmsg+0x265/0x360
[   11.997076]  sock_sendmsg+0x100/0x1e0
[   11.997293]  nvme_tcp_try_send+0x196f/0x6370
[   11.997605]  nvme_tcp_queue_rq+0x1d54/0x20b0
[   11.997882]  blk_mq_dispatch_rq_list+0x5ee/0x2e50
[   11.998175]  __blk_mq_sched_dispatch_requests+0x16dc/0x24a0
[   11.998539]  blk_mq_sched_dispatch_requests+0x11b/0x2c0
[   11.998865]  blk_mq_run_work_fn+0x13b/0x280
[   11.999146]  process_scheduled_works+0x966/0x1ad0
[   11.999465]  worker_thread+0xe44/0x1480
[   11.999709]  kthread+0x53b/0x600
[   11.999927]  ret_from_fork+0x29f/0x7c0
[   12.000191]  ret_from_fork_asm+0x1a/0x30
[   12.000460]
[   12.000558] Uninit was created at:
[   12.000788]  __alloc_frozen_pages_noprof+0x8bf/0xd30
[   12.001096]  alloc_pages_mpol+0x1d0/0x5f0
[   12.001326]  alloc_pages_noprof+0x102/0x290
[   12.001627]  nvme_init_ctrl+0x5a3/0x9f0
[   12.001891]  nvme_tcp_create_ctrl+0xd75/0x19b0
[   12.002170]  nvmf_dev_write+0x4c68/0x4fd0
[   12.002426]  vfs_write+0x587/0x1a10
[   12.002636]  __x64_sys_write+0x207/0x4f0
[   12.002874]  x64_sys_call+0x2ff0/0x3ea0
[   12.003123]  do_syscall_64+0x147/0x3b0
[   12.003400]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   12.003680]
[   12.003777] Bytes 16-2843 of 2844 are uninitialized
[   12.004068] Memory access of size 2844 starts at ffff888109f82000
[   12.004412]
[   12.004530] CPU: 0 UID: 0 PID: 101 Comm: kworker/0:1H Not tainted 7.2.0-rc5-NVMECTL-gf5098b6bae76 #1 PREEMPT(lazy)
[   12.005127] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   12.005762] Workqueue: kblockd blk_mq_run_work_fn
[   12.006073] =====================================================

Allocate the page with __GFP_ZERO.  The single allocation site covers
every use of it: bytes no discard has written stay zero, and bytes one
did write hold that controller's own range list, which it has already
been sent.

Fixes: 530436c45ef2 ("nvme: Discard workaround for non-conformant devices")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
Measured over nvme-tcp under KMSAN, with the kzalloc failed by fault
injection and a fresh controller per cycle so that every fallback is the
first use of that controller's page:

  unpatched, injection on    40 of 40 cycles reported, 10 runs
  patched,   injection on     0 of 40 cycles reported, 10 runs
  unpatched, injection off    0 of 10 runs

The target-side dump of the 4096-byte payload showed a non-zero tail in
33 of the 40 unpatched cycles - 3526 and 258 non-zero bytes of 4080 were
the two recurring shapes - and in none of the patched ones.  The 7 zero
tails are recycled pages that happened to be zero, which KMSAN still
reports because it tracks whether a byte was initialised, not what it
holds.

Scope: a single VM over loopback.  This is not a test against a remote
target.  What the source shows is that the DSM payload is transferred to
the controller; what was measured is that the host kernel reads
uninitialised bytes and puts them on the wire.

Reproducing it: a KMSAN kernel with CONFIG_EXPERT=y and
CONFIG_CRC_OPTIMIZATIONS=n, booted with slab_nomerge; nvme-tcp connected
to a target; SLAB_FAILSLAB set on kmalloc-4k and failslab armed with
probability=100 times=1 cache-filter=1 around a BLKDISCARD ioctl.

 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..ee993dfa1e41 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5195,7 +5195,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);
-	ctrl->discard_page = alloc_page(GFP_KERNEL);
+	ctrl->discard_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 	if (!ctrl->discard_page) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.43.0

