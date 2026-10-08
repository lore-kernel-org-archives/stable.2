Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9E32E151
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469113; cv=none; b=oYTeob6V1lrSj/UUJd/laqYzYoS1A4V+gVYAYh2MEr7ngzQoklz5Xboyw6xOymbxZ+nwna4JHIorkSOFciTqxJJiBfu2gxjAKG4LjCSByAitw79jtMlGS/fIjP7IITeWmjT9YzkOboQxc4JkTsfWstDxioGhvFMGvGqPoN/KMe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469113; c=relaxed/simple;
	bh=/gfEAsx/aV+BRpyOElitNrvIT+IG7kM7JPJmm2sUWaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fyf4XbNputCpOvSSK9IRKnACeSzO0FBiWxxVPzN4hBfjveFTdfoMpWOWaWJOl+DRCuWxxTshKQl7cMElNQH55AlO1aDnuvOLeYHSLNm8+Oukpl4Duq4opCn+VGEdudWDp0SHzgQzDigeR9Vt095uYGZ/tEL1Nf246PGQPCItzSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=GfLA2RB+; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="GfLA2RB+"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-88d48da248eso2415324b3a.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 07:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791469111; x=1792073911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TU0SO4g5tDv/VF6Elax/PFIxpq1suhcXGP/z8OAP+qg=;
        b=GfLA2RB+EKTgAhmGdEpc/zCWGrHuHgjV9v8snzdK+Cbeceu/C1NQduVV91jeV2EAfr
         d3OrEtOtCZAIrudGrQhl2JfyKKQfNxReoatA7Z2msiuNGtEl3QEwuHLPBi4rHOey/rVD
         XN1mJEnKFWFFgThgXxgZI6apiGrwP6LKpJkO5WzXank2Rkck5QhutCkoay8to/jWk396
         Pm29NrdnScDtdprn6zMjDLDjiUQyqRni7b7NciMfnFklf+k7kaBMpvwqTb/7c75Sk1r5
         GnifwUfB/S8n7fFsm21+HzSm3oMz35mlfyBdKbGOqk1OloMpaBiyayVQw1rzULT3tAOd
         /6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469111; x=1792073911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TU0SO4g5tDv/VF6Elax/PFIxpq1suhcXGP/z8OAP+qg=;
        b=Kd4mFXH3RA18MA9SEzstIMphPBK05r4wiMbpYd86FFLdjaC8QDqSV2qV5/YzPwX3Uj
         l/fvIEoDM1G8j+BGMcO5faXICoh61Xxn5BJqFl36KSP5QbRqM/05XT8Q5JSh/x50xFG7
         KybyZUv60JN6vV5CdXM7Vz/phJFXII8g+jY3XQU9B0t4JTPeXi+fHaxri/0pJOR8d/at
         lTkh5Nol77364lhiKakXgJpxPbIGTejg+is/dOiE6mH0PSaI3LjxvZL3CfHH79+cb2mT
         e/T7Hmxz35o2cWjAREeRNFJgOfifMmixxqyLHitvNvC8V2U/c2MQ28EvyUXZSHnsUHHW
         /bQg==
X-Forwarded-Encrypted: i=1; AKwUvBwbelnHLT886MB7N7OfeP3IZOuOmQX/q3aUXtRJblrdkxCoJRlo+eFUQVLhOoa1fw8VeMgUcA4=@vger.kernel.org
X-Gm-Message-State: AFuF++l8pds8SMmBzU6murUyouE7+toEJ8oRuFMr+CquhGxnVghZfxtX
	pIknU2sz/kEODaa9bA7ftODqIrP/gYDgm3BjZRvA0NJjNBeJ9O7UaQJOkADc2fuuJMU=
X-Gm-Gg: AYBFou19mq5dC0LzPh8iyGo6d9q2Y4RKoMMl4zG38Jrch02rz8UTiTWNgz69L5V2Ibj
	XkSj5q6i/0zH3QHqflCa3jiWHFO1vYa/HgBJ7SaPVGWa73cPZytwNpBwXcfqwA/DpXSeSPlrspb
	WWbwsWiGcRV1HhddxPm91ym1MCV8GtrA36YmutA+dGpxeYk2bKL2E4S6Pw7DTAMRIo8fa+5VIR6
	DfUcgScXmDNBIVBkZUUoFY6WZYvvs/9iNLUEQjNSA4je1fNSkYKcfBxZy4lOTfUHMo+xIT5L7mT
	lYSfEQQ83LhPO6lOSiMbH6QuIG43DvDq/ChRUYc6bd/1RRXZ1E3wp7WmCuWYcAFnpTWnH8IbZ1w
	7G4/U2CJYEHSoOMyQj+y4PTFtwQHMXj5No3+D0VJbZIDTr9ptUrnYF9K6IJJK49m0vaSl5qmPbj
	W8Ztd5mN0aCOKQd+dt0ntWTctuieQbV4Hx+trKALuqXRkdnDKsiyZL57Ny9mGcWMVknAePQSWvH
	/k+ni+D5Y79Rr0ml9W+
X-Received: by 2002:a05:6a00:3313:b0:882:d8c4:17c9 with SMTP id d2e1a72fcca58-891b0f8f99dmr5329742b3a.23.1791469111022;
        Thu, 08 Oct 2026 07:18:31 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:af47:f737:9040:a59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-892bb2a5ba8sm1751275b3a.30.2026.10.08.07.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:18:30 -0700 (PDT)
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
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v2] nvme: bound FDP config log reads to the received buffer
Date: Thu,  8 Oct 2026 23:18:16 +0900
Message-ID: <20261008141816.1174578-1-yhlee@isslab.korea.ac.kr>
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

Reject a log smaller than its header, zero the buffer so a short transfer
leaves no uninitialized tail to parse, and check that a descriptor fits
the buffer before each access.

Fixes: 30b5f20bb2dda ("nvme: register fdp parameters with the block layer")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v2: allocate the log buffer with kvzalloc() so that if the controller
 completes the Get Log Page with a short transfer, the uninitialized
 tail reads as zero and is rejected by the existing dsze check instead
 of being parsed (hardening).
v1: https://lore.kernel.org/linux-nvme/20261008132604.1168105-1-yhlee@isslab.korea.ac.kr/

 drivers/nvme/host/core.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9bcab3dc4c118..30e7b1d93447a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2272,13 +2272,17 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 	}
 
 	size = le32_to_cpu(hdr.sze);
+	if (size < sizeof(*h)) {
+		dev_warn(ctrl->device, "FDP config log too small\n");
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
 
@@ -2304,8 +2308,12 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 	desc = log;
 	end = log + size - sizeof(*h);
 	for (i = 0; i < fdp_idx; i++) {
-		u16 dsze = le16_to_cpu(desc->dsze);
+		u16 dsze;
 
+		if ((u8 *)desc + sizeof(*desc) > (u8 *)h + size)
+			goto short_desc;
+
+		dsze = le16_to_cpu(desc->dsze);
 		if (!dsze || log + dsze > end) {
 			dev_warn(ctrl->device,
 				 "FDP invalid config descriptor at index %d\n", i);
@@ -2316,6 +2324,9 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 		desc = log;
 	}
 
+	if ((u8 *)desc + sizeof(*desc) > (u8 *)h + size)
+		goto short_desc;
+
 	if (le32_to_cpu(desc->nrg) > 1) {
 		dev_warn(ctrl->device, "FDP NRG > 1 not supported\n");
 		ret = 0;
@@ -2326,6 +2337,11 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 out:
 	kvfree(h);
 	return ret;
+
+short_desc:
+	dev_warn(ctrl->device, "FDP config descriptor runs past the log\n");
+	kvfree(h);
+	return 0;
 }
 
 static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
-- 
2.43.0

