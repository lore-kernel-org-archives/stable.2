Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59440569F1B
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171467; cv=none; b=VDxCnFz/4cch4i5/mAPeyOy+jZvair3S3BzulI/mvw6XJtMQvaz9tgFzHe1JAmpAmtad/jWx/BPNjN4F/u3747fGvKRRtsMYlpN95ioj4909AlVuu7+JWMdXqgig5srZBxB4Q139eAPabpJZmSMpekGQPT4QoZcCtpxZ0X/NXhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171467; c=relaxed/simple;
	bh=Nrb0au/cpQJY6hlXB1C8M5JJRsWD087gxaDaIp/3bIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eTbdjvlmyn7+OundLDayFIEtD58aw2M8YYowXm1jhfI7Yj+H8grPQGsqMz1PSNzyHw5wrK1Z5b5bw3I8J3fkRW0bS49ya7ubRTO9uEOahFhBIh1ix4K4NlZBZ564y5UDGAo/OG/zRlKUgqzvw4UGhVY3hQYRaTHcZN9J33l8oi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZAUogdE; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZAUogdE"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3535a54bed9so139908eec.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 10:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792171465; x=1792776265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sn5pUeRtWfPOpCuFfuoGwkYCHpgCjYDIi8W/OVQtl1E=;
        b=UZAUogdEIgN2V9Q4K4A5zHKaxm1o7XNp6lh3kjXiQww+Ub5WiDy2HLVJtFP83Erj4M
         FgShHYu5g+Rnhf3iU+Tpm0B+ZZ0lnpVkrSHHQFsvG7ISr9ABjjQ/QjbZLk1Tz7CMdWl1
         yev3Q8VTLE6G3Y91gI/tlNBad19bhp6+daCi52BZokUeVzw9+hc8tpHmw7yKOiOB8mdP
         0Q6OvZhT8iedV/byC2/DNY9HlTMgq1Zvb8ohACMTTJ6fVpJqsKDYFPtzp9ZYPI8cjxII
         PcYmYeHZ6xFJWRTNtjDNeG+tgZwonHujuCBJEGd3Z1uyMy2+06TGz7VQPbhIdgaZ7w5B
         pw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171465; x=1792776265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sn5pUeRtWfPOpCuFfuoGwkYCHpgCjYDIi8W/OVQtl1E=;
        b=UBpVqE6eXU5sePb0ujU6R+/A0c+MQieMffTszFKewjH1FxDzaCflyowlcBDYsf1nJU
         eUaM9K5yy8cSFdmoMycdSYYAtlxuimYgl5MtWNtqy9op/VOlRevVVpE9oDsudh6T2pma
         k8WBmC7uJ8xSGMgoTWfRmbWIl8/AeIGP4N1Uo/uZQ9tz7TvSE1iBQqUAKwCSW1bnFpzu
         UKB2Fx40XfTotuPhGrNTq9FIypZKjVKTULeP2PnKyWZEjk+EA5d2uc1movKlcfd15hpx
         +fccH6YpwsSfHZWCTJXX8fKteWyX4Zsrgk2hV9ObAJaWmgCUN+VE342dr/wsP9G7aCFT
         VQQA==
X-Forwarded-Encrypted: i=1; AKwUvBw5hyOOwf4XsgZ/sFPsmuRb7gAKa7vHKU46hppptc5JkSbqz1+2Dqnd4jcy/Om448fqelBmcLw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9uqqOmAiLQYVV7DDLraV3xg7ciL4H1b/di20Uv0gK2nM2vx7q
	5Y4wx6Jm+srQESmmhH4Cc5FnNaYSAEMaogMSTNHADMUE9ape+GJfYgXFDy3M0lNopIQ=
X-Gm-Gg: AYBFou0a1qM+nc4fVudI2oQfC1bqwFsERKNHaM512mGxndpIcZiz3NbWOdAiNU/gEGK
	fHjYzN9w7gNCGA6IDQJuN64/QbcRwjo2hrFkDwJzR3mHqKVY6Q9gjy2X2Fc3O0vVYwLDMVqSHfH
	r2XhijhdjhwE3LgZiuD2/taTn/5FiIawZaJG2Ag0JyaxZBvXtS7/H3znPP4WIiYqRMWZoaqJ372
	GC3OlunkA4t2RUazVeICoyhIAixA1JNDF+muLqGj3NvsYMQUYVN/B9QeBMonarJYeEyHsojjJml
	6aF6hPzs65vsktxaJ+NHqlpjilQqUN/Hjn7mBr4c5BdWrqoR5ftL33rSO1sXGsuEOywG+CpneUo
	B6ZuYSJJVkiKGCfiyO7f21Y3MDmnL5cM1FdZFiD8SKvQnJil3X+ygt6v2v4GTzSY6oTFhX4JIUl
	TjzYCk27vZR9YcJMQL4ZXuFz7+Ef/KHkSUKka3Bpj2DoZtuHKC2SKmk8fuDIFRIgdDdOa4hSTFN
	pwExSFvNLSg+roDkd1CZjSXgN31mA35IRzFaMGN9ZZOio8=
X-Received: by 2002:a05:693c:20cc:20b0:35e:f1a5:9ba6 with SMTP id 5a478bee46e88-3619ed0f886mr566943eec.5.1792171465044;
        Fri, 16 Oct 2026 10:24:25 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6e33sm8675575eec.7.2026.10.16.10.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:24:23 -0700 (PDT)
From: bestswngs@gmail.com
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org,
	co+e015e82956da641b@bugs.sh
Subject: [PATCH nvme] nvmet-rdma: reject short connection requests
Date: Fri, 16 Oct 2026 10:23:38 -0700
Message-ID: <20261016172336.286341-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

nvmet_rdma_parse_cm_connect_req() treats RDMA-CM private data as a
struct nvme_rdma_cm_req but accepts any nonzero private_data_len.  The
iWARP path allocates exactly the peer-provided length, so a six-byte MPA
request reaches the parser and the hsqsize load reads two bytes past the
allocation.

Require the complete request structure before reading any of its fields.
The decoded KASAN report is:

  BUG: KASAN: slab-out-of-bounds in nvmet_rdma_cm_handler
    (drivers/nvme/target/rdma.c:1427 drivers/nvme/target/rdma.c:1475
     drivers/nvme/target/rdma.c:1614 drivers/nvme/target/rdma.c:1814)
  Read of size 2 at addr ff1100010459d366 by task kworker/u16:1/41
  Workqueue: iw_cm_wq cm_work_handler
  Call Trace:
   <TASK>
   dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
   print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
   kasan_report (mm/kasan/report.c:595)
   nvmet_rdma_cm_handler
    (drivers/nvme/target/rdma.c:1427 drivers/nvme/target/rdma.c:1475
     drivers/nvme/target/rdma.c:1614 drivers/nvme/target/rdma.c:1814)
   cma_cm_event_handler (drivers/infiniband/core/cma.c:2181)
   iw_conn_req_handler (drivers/infiniband/core/cma.c:2640)
   cm_work_handler
    (drivers/infiniband/core/cm.c:2502
     drivers/infiniband/core/cm.c:3858)
   process_one_work (kernel/workqueue.c:3396)
   worker_thread (kernel/workqueue.c:3479 kernel/workqueue.c:3560)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
   </TASK>

  Allocated by task 12:
   __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
   __kmalloc_node_track_caller_noprof
    (mm/slub.c:5414 mm/slub.c:5545)
   kmemdup_noprof (mm/util.c:138)
   cm_event_handler
    (drivers/infiniband/core/iwcm.c:194
     drivers/infiniband/core/iwcm.c:1076)
   siw_cm_upcall (drivers/infiniband/sw/siw/siw_cm.c:408)
   siw_proc_mpareq (drivers/infiniband/sw/siw/siw_cm.c:750)
   siw_cm_work_handler (drivers/infiniband/sw/siw/siw_cm.c:1086)

  The buggy address is located 0 bytes to the right of
  allocated 6-byte region [ff1100010459d360, ff1100010459d366)

Cc: stable@vger.kernel.org
Fixes: 8f000cac6e7a ("nvmet-rdma: add a NVMe over Fabrics RDMA target driver")
Reported-by: <co+e015e82956da641b@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/nvme/target/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index ffa1e172c..075ab58d8 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1412,7 +1412,7 @@ nvmet_rdma_parse_cm_connect_req(struct rdma_conn_param *conn,
 	struct nvme_rdma_cm_req *req;
 
 	req = (struct nvme_rdma_cm_req *)conn->private_data;
-	if (!req || conn->private_data_len == 0)
+	if (!req || conn->private_data_len < sizeof(*req))
 		return NVME_RDMA_CM_INVALID_LEN;
 
 	if (le16_to_cpu(req->recfmt) != NVME_RDMA_CM_FMT_1_0)
-- 
2.55.0

