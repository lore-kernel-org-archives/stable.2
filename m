Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB0C3D3D09
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887303; cv=none; b=GftsxRM2aDwqjqO3gaoRNbXha0jOKBjTf2S/XAHpCOtIFEC7M4cIPJYloUOD4wN80Te7KdTDjq0Wq2zEGVpMCV0SwL1DEmbhzeFWQxPXHUD1rSZUq4iuTrX2MZRi1p5FqExLhHPNPIcSf4frl156VAXjpkxn+0/Ru5M72/kr1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887303; c=relaxed/simple;
	bh=Bs6NkZanZ3FzlfIXwwsrOu7fzbqyxxdgm9w+P9u7jwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5QTEy1DryRavueCFij1N2Z6/HDxVNHfR8aqz1wIPszZvjvjn9pXxAVsW4ejtGzc1SQqfCUygXq+E3TBC0i5V6nBou6uzjYGCs5+HmgUapAeVpz0hnhEAvrUEJdR+1ZUTNVosYAf7PgjLVmigXr1czvnTZslB3JI5B7wGiPOj+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=qMC90L0s; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="qMC90L0s"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-398b3c37877so1300209a91.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 03:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791887300; x=1792492100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AFB74tPON6fMev98Hd7HE9xGO0Iu+BsnVCNgiYERqag=;
        b=qMC90L0s4zOAFtlzZ2gxqaRlsNxTiFFf6+qQLFLElg/dt/hBalnd4IevCs8Bs+TkxT
         FNjLMs3WoDPWq4UgWn1rzVOXPPoTXyJ8LUU4yj5lNJZD+sL5lw1DGwALBPXMu2AdKzxz
         PeDZiPkvdRu8s5IQgiaYdKpHElThHY3QkLh1jLJiVCJa+r0avm986tYxU5uEfMJ2KpwN
         wHZePw2dbYU1RLQAxKVS+3mjPoCiIw3Se3rm6FGwcR5qtko0Tf48ZpUuUzHWzVtSt23I
         OiTkhznw6t5MObJNgHgwatPHOBeXe31JoaHtaJyuDMt4RTsGDG4WcU3I2zdsZSa4v4/m
         OqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887300; x=1792492100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AFB74tPON6fMev98Hd7HE9xGO0Iu+BsnVCNgiYERqag=;
        b=p8Qh0AE8FJGSq8DT+TJBKbrjczD/TOn6HYlLjjIcIqpiqsih4WRYXc/5ElrG1PrNfL
         WR6g1IXeXiVbTe6ika6CKuoMKBAaYYtQ8tDPOaXFY0iusrKy56Nez+DiVgZF9trlyKC6
         W54Bv1QdcqeGzLFxyGCH0AyUbKco3G687iFtakK8VP8jJTs3avYDa+64JsI4Y12e2E9U
         07HQeicINZPo34lft4Jo+vMbBayikgtNSHdMQjVYfBa+/dwGbRVoP0TX0ocmH+vY5haI
         28XDB3+x+1eWjpWyf895sy4rUjZ6+sEVfSXZVpxU5+hw0nxPhHFM9ekVqML712fjzhvx
         AJHA==
X-Forwarded-Encrypted: i=1; AKwUvBz0GQf/kVe7bY6ueTZOeIIj1C/n2IskY8RE15syM+jyTq/sq+bFcnrkwjghVZin4daVAODBdX8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqxckfke6u6Ke7UZYtineK2D5LRRAK9BWeAxAE8LeePqrG5Pdf
	uNo9lW7MohxuGRsxPnHm57/j76vIRKxp+D7sL5yUOIWX8vONu3Nd1CX4U4ULMKb+Rg06gG3fOFz
	7XrxLFDGj0A==
X-Gm-Gg: AYBFou1pdE8wHGMF7esRu/wZ9IP0gVi3i++ZvJmukq+8q3iT9CC3WdouJIVCIibCbHL
	noEg43iCxRBWwVJUHH4wY3DAe3oEsOwYGwoz1URMvrLDFVG8PmrPqoupcb7WKMN9hdaBhrzV0Lj
	hBSgdR8WVVmEwi1QUT6/D6wLebasU6rrw0sHkuahSOlXR1OU6hpZBYM+v3ebeHvSrEy35uGhl0W
	r/uhSAxIwqJbPHYVd1mZT7n4PMhjjIoUrmmnEr9tVbIaSYep8pQfzyPGKLpNyu3HWS9VU7vxRL8
	GfmgGH9RMbttzYG/XpyH4PE8KUe5vDtvIOcQpxXpFcBkQjlG39rybUYtKkN7ghVlj9iHyuEftwJ
	HwPrhnZL0ydRdK+sMVe5h2xijPiHy1CyD/XZpxg6WVtP0xbQoTtlDUi73O9BjHzyq4JtHoo57tW
	PO8kdO4+lJPGm1R4K1BLVQUnsb3oZoAgEvU4Dg74Ew58cXLEvCZTZr74GpKqoGdiqS6ryfdLwiN
	ZIRiQ==
X-Received: by 2002:a17:90a:b90:b0:3a0:e4ce:31fd with SMTP id 98e67ed59e1d1-3ab3ac578d2mr6950807a91.10.1791887299793;
        Tue, 13 Oct 2026 03:28:19 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ca1e04sm21494095a91.1.2026.10.13.03.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:28:19 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Nitesh Shetty <nj.shetty@samsung.com>,
	Hannes Reinecke <hare@suse.de>,
	Kanchan Joshi <joshi.k@samsung.com>,
	gliuxen@gmail.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] nvme: bound FDP config log reads to the received buffer
Date: Tue, 13 Oct 2026 19:28:12 +0900
Message-ID: <20261013102812.3020500-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme_query_fdp_granularity() parses the FDP Configurations log using
sizes the controller returns, without checking that they fit the buffer
it was given.  The log size is only bounded from above before
kvmalloc(), so a size below the log header makes
le16_to_cpu(h->numfdpc) read past the allocation, and a size of zero
yields ZERO_SIZE_PTR and faults.  Each configuration descriptor is then
dereferenced (dsze while walking, and nrg and runs on the selected one)
without checking that the whole descriptor lies within the buffer, so a
descriptor at or past the end is read out of bounds.  The out-of-bounds
runs value is then exposed to userspace through
/sys/block/nvmeXnY/queue/write_stream_granularity.

A device-supplied dsze that is not a multiple of eight also leaves the
following descriptors unaligned, and the structure is not packed, so
reading nrg and runs from one can fault on architectures without
efficient unaligned access.

A malicious or buggy controller triggers this during namespace scan with a
short FDP Configurations log:

[    1.104828] BUG: KASAN: slab-out-of-bounds in nvme_alloc_ns+0x39a6/0x4480
[    1.104848] Read of size 8 at addr ffff888009fd8fe0 by task kworker/u8:3/52
[    1.104852]
[    1.104857] CPU: 1 UID: 0 PID: 52 Comm: kworker/u8:3 Not tainted 7.3.0-rc6-00063-g0c2669a9f4a1 #1 PREEMPT(lazy)
[    1.104862] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[    1.104866] Workqueue: async async_run_entry_fn
[    1.104873] Call Trace:
[    1.104876]  <TASK>
[    1.104878]  dump_stack_lvl+0x66/0xa0
[    1.104886]  print_report+0xd0/0x630
[    1.104893]  ? nvme_alloc_ns+0x39a6/0x4480
[    1.104897]  ? __virt_addr_valid+0x209/0x3f0
[    1.104903]  ? nvme_alloc_ns+0x39a6/0x4480
[    1.104907]  kasan_report+0xe4/0x120
[    1.104913]  ? nvme_alloc_ns+0x39a6/0x4480
[    1.104919]  nvme_alloc_ns+0x39a6/0x4480
[    1.104926]  ? __pfx_nvme_alloc_ns+0x10/0x10
[    1.104931]  ? check_prev_add+0xfd/0xe80
[    1.104942]  ? lock_acquire+0x18d/0x300
[    1.104948]  ? nvme_find_get_ns+0xbb/0x2e0
[    1.104952]  ? find_held_lock+0x2b/0x80
[    1.104956]  ? nvme_find_get_ns+0x221/0x2e0
[    1.104962]  ? nvme_find_get_ns+0x231/0x2e0
[    1.104967]  ? nvme_scan_ns+0x2e1/0x8d0
[    1.104971]  ? kfree+0x2e5/0x510
[    1.104976]  ? __lock_acquire+0x570/0x1b00
[    1.104982]  nvme_scan_ns+0x56a/0x8d0
[    1.104987]  ? __pfx_nvme_scan_ns+0x10/0x10
[    1.104994]  ? lockdep_hardirqs_on_prepare+0xdc/0x190
[    1.104999]  ? trace_hardirqs_on+0x18/0x160
[    1.105005]  ? kvm_clock_get_cycles+0x19/0x40
[    1.105011]  ? __pfx_nvme_scan_ns_async+0x10/0x10
[    1.105015]  async_run_entry_fn+0x8d/0x290
[    1.105020]  process_one_work+0x8ac/0x1b00
[    1.105029]  ? __pfx_process_one_work+0x10/0x10
[    1.105034]  ? lock_acquire+0x18d/0x300
[    1.105040]  ? lock_is_held_type+0x8f/0x100
[    1.105046]  ? __pfx_async_run_entry_fn+0x10/0x10
[    1.105050]  worker_thread+0x4ee/0xe70
[    1.105056]  ? lockdep_hardirqs_on_prepare+0xdc/0x190
[    1.105061]  ? trace_hardirqs_on+0x18/0x160
[    1.105066]  ? __pfx_worker_thread+0x10/0x10
[    1.105071]  ? __pfx_worker_thread+0x10/0x10
[    1.105076]  kthread+0x2ce/0x3b0
[    1.105080]  ? __pfx_kthread+0x10/0x10
[    1.105085]  ret_from_fork+0x52e/0x780
[    1.105090]  ? __pfx_ret_from_fork+0x10/0x10
[    1.105094]  ? __switch_to+0x572/0xde0
[    1.105101]  ? __pfx_kthread+0x10/0x10
[    1.105105]  ret_from_fork_asm+0x1a/0x30
[    1.105114]  </TASK>
[    1.105116]
[    1.105117] Allocated by task 52:
[    1.105119]  kasan_save_stack+0x33/0x60
[    1.105123]  kasan_save_track+0x14/0x30
[    1.105126]  __kasan_kmalloc+0x8f/0xa0
[    1.105129]  __kvmalloc_node_noprof+0x2e1/0x820
[    1.105134]  nvme_alloc_ns+0x1097/0x4480
[    1.105138]  nvme_scan_ns+0x56a/0x8d0
[    1.105142]  async_run_entry_fn+0x8d/0x290
[    1.105145]  process_one_work+0x8ac/0x1b00
[    1.105148]  worker_thread+0x4ee/0xe70
[    1.105152]  kthread+0x2ce/0x3b0
[    1.105155]  ret_from_fork+0x52e/0x780
[    1.105159]  ret_from_fork_asm+0x1a/0x30
[    1.105163]
[    1.105164] The buggy address belongs to the object at ffff888009fd8fc0
[    1.105164]  which belongs to the cache kmalloc-32 of size 32
[    1.105167] The buggy address is located 8 bytes to the right of
[    1.105167]  allocated 24-byte region [ffff888009fd8fc0, ffff888009fd8fd8)
[    1.105171]
[    1.105172] The buggy address belongs to the physical page:
[    1.105175] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9fd8
[    1.105179] flags: 0x100000000000000(node=0|zone=1)
[    1.105183] page_type: f5(slab)
[    1.105188] raw: 0100000000000000 ffff888008c41780 dead000000000100 dead000000000122
[    1.105192] raw: 0000000000000000 0000000000400040 00000000f5000000 0000000000000000
[    1.105194] page dumped because: kasan: bad access detected
[    1.105195]
[    1.105196] Memory state around the buggy address:
[    1.105198]  ffff888009fd8e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    1.105201]  ffff888009fd8f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    1.105203] >ffff888009fd8f80: fc fc fc fc fc fc fc fc 00 00 00 fc fc fc fc fc
[    1.105205]                                                        ^
[    1.105207]  ffff888009fd9000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
[    1.105210]  ffff888009fd9080: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
[    1.105212] ==================================================================

Reject a log smaller than its header plus one configuration descriptor,
zero the buffer so a short transfer leaves no uninitialized tail to parse,
require each descriptor's declared size to be at least a descriptor and to
leave room for the next one before walking it, and read the descriptor
fields with the unaligned accessors.

Fixes: 30b5f20bb2dda ("nvme: register fdp parameters with the block layer")
Cc: stable@vger.kernel.org
Suggested-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v4: per Kanchan's review - require header plus one descriptor, fold the
    per-descriptor bounds check into the walk (reject dsze < sizeof(desc),
    covering the 1..63 values the old !dsze test allowed, and require the
    next descriptor to fit).
v3: read the descriptor fields with get_unaligned_le() (strict-align
    hardening; verified via codegen, not on strict-align HW).
v2: allocate the log buffer with kvzalloc() so a short Get Log Page
    transfer leaves a zeroed, rejected tail.
v1: https://lore.kernel.org/linux-nvme/20261008132604.1168105-1-yhlee@isslab.korea.ac.kr/

 drivers/nvme/host/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9bcab3dc4c118..389ef1ae53f17 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2272,13 +2272,18 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 	}
 
 	size = le32_to_cpu(hdr.sze);
+	if (size < sizeof(*h) + sizeof(*desc)) {
+		dev_warn(ctrl->device, "FDP config size too small:%zu\n",
+			 size);
+		return 0;
+	}
 	if (size > PAGE_SIZE * MAX_ORDER_NR_PAGES) {
 		dev_warn(ctrl->device, "FDP config size too large:%zu\n",
 			 size);
 		return 0;
 	}
 
-	h = kvmalloc(size, GFP_KERNEL);
+	h = kvzalloc(size, GFP_KERNEL);
 	if (!h)
 		return -ENOMEM;
 
@@ -2304,9 +2309,9 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 	desc = log;
 	end = log + size - sizeof(*h);
 	for (i = 0; i < fdp_idx; i++) {
-		u16 dsze = le16_to_cpu(desc->dsze);
+		u16 dsze = get_unaligned_le16(&desc->dsze);
 
-		if (!dsze || log + dsze > end) {
+		if (dsze < sizeof(*desc) || log + dsze + sizeof(*desc) > end) {
 			dev_warn(ctrl->device,
 				 "FDP invalid config descriptor at index %d\n", i);
 			ret = 0;
@@ -2316,13 +2321,13 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 		desc = log;
 	}
 
-	if (le32_to_cpu(desc->nrg) > 1) {
+	if (get_unaligned_le32(&desc->nrg) > 1) {
 		dev_warn(ctrl->device, "FDP NRG > 1 not supported\n");
 		ret = 0;
 		goto out;
 	}
 
-	info->runs = le64_to_cpu(desc->runs);
+	info->runs = get_unaligned_le64(&desc->runs);
 out:
 	kvfree(h);
 	return ret;

base-commit: 0c2669a9f4a1d607e7591ae50ccf3c432a0aff08
-- 
2.43.0

