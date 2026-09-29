Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38103AF660
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670894; cv=none; b=qIAP0BRyZD50ONFTAKGGkhJI9AvwgHOOPkalCtGKSI/ZB/2Tb2I6sHlLLE+dx9gf719g2LEiFeKY/cOGeCouEyVwsh63iryVzUnKTjspmwnGOO7ETR5GpZzCaJ9Y//N9c6OJNEMl1m9HGF0h7hhIMuvjJqjs6T4akB2PtDoBNic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670894; c=relaxed/simple;
	bh=t9NO8RLGfg/L6imVOchQWaM9RYI0Kykf/KtwK1c3Mmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zl0OEuAelH2mpaKIcFM/15B+iTPeB+COzcBY96K0gRc+Nh2NaDnSxpELU+87lBKcEUk9uEolqT1VXK6nC0Gnz5E0suMriJxuzycNr4w0bYklE2OYV3bfrSyP/zbukYYkMVWjOhekLpKMyltdSdEdQAKmjSd+RaqGSQwLQAdzSWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=itad8p9b; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="itad8p9b"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-882833a9f61so1851274b3a.2
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1790670890; x=1791275690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5cwydG5wsQtN0cZkN780gx8GmDGw8aCnNB0UYeCsBrQ=;
        b=itad8p9bN7jGgpAetd+Tf0QkhjlP7LRVjtcfO8BZrtiTZfuvNNZcgFsTOjT2uPb0kE
         6LKEyGcByMA6Onq+YQc5RBIWJ+4m991tHHcNQA5DahQdhRcGEBIMvs9d3rw5IsKLL5sX
         Dw36+x28LT0vAcU/PurXtr87HYM9H9S/kwm8qusc4L1knYa2mG01MNy6h6RoZXw3WGOK
         LRMSMjYDirUQ7tTveQgBRUUpiS6f2p3uwJ2l1B/muASFjpqdnQGcgbS6lbewsxSA5zmC
         Gq5e2hkIgq9G7WLfAJ/MjAB0B3Px2fjMyWtNGSB8SJXwzFuQadn5MV66/NKNUmTM3el/
         eMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790670890; x=1791275690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5cwydG5wsQtN0cZkN780gx8GmDGw8aCnNB0UYeCsBrQ=;
        b=hkfzwqqsCkbJlEst/R2APiVt432gA0BgRuBgEZIKBSoFeQFTRZ7+trPdRNpgmvokA4
         0oC4Nt/OomBjmmA3bHjVY+vRTD9cFzztWgjSNE0N7PeS0kosA9aMUoqifSaU2O4o8bBR
         qmpx5I6Rb1xPW0Zr+6rMcosHb2DujKwzKmCTPIOVp5g872YGDkfeqWj2yWAkPRBkx6uJ
         JwtEp6ltRsMyjzTzhNxHvJ8qGWdiE9a0PXX/AUeerl1VM4lQu6Fxo8JdKCj4MLB34tUy
         U4m3/Y+wipLqBI1IZza2d6eFc22zqixK0wqyWOEEROt35anHFUyLAZbczfFWODEOMpLp
         eQVg==
X-Forwarded-Encrypted: i=1; AKwUvBznQcS6S8ct0pSVvfk0R7eiGJO+fSxQVqpHjGUZukzZTv3lR71xSul7FIJemgAN/5Pw2dGpst0=@vger.kernel.org
X-Gm-Message-State: AFuF++lpRpma7ImcPEkpWYlr2R3FohXrvEceRpOW3g9eow4zfm0jNVHJ
	otCFA9Xz7AhKcQcdyzafl61G7fdTQ7+cC4oBW7RT95jz6DSTwIyjKL1TrKNzDJurKYETvZ/npw4
	gbRalIvc=
X-Gm-Gg: AYBFou1Kg5le17DBjV7O3L4qH+bcuCnQ5dGdPcBaMovpImksOB0xpJw4sj6XjNa2XFA
	gzYro7DSJVRDKWvS4SNJoHI84cTzndaZ5cSwDX8SBnKgJdfNAnudAdi4+eIrmfhhafxEVYi6sH1
	miYAsMraxV8LocCKgtl3/uE9aWozn/x/XA7U2qS4GJA//1gyeRpmofwH9FKSSeY6wLRF4AyM7rU
	ABiGp0RkZwbEt5EEzpkjYaNHC46QL1SXc985Ungtuvb0zyY3cnKzaajemi72mTAlHrFhvuf8Abp
	xzfqIUVrmKxJiVwJUOQ+viVHCF5w9jY/OyP27et13NsBt7XdyFXMpyP+r+V3CgV9V6UjvXJ8zOo
	Vn47zcU3Z9Pdd47yYstRKd803TEP9dDtwf3+m1n6/xTWOYNYB7WV9D3jHjp7v90iFasTGshkaZE
	hBEXaGc5XgnC/pzy9dERve/pfcs9PcJ8k9NZK1RuAPlMGgLnxWHoW6SYDQITLmNEYb/n1bf3EAT
	jtj8Q==
X-Received: by 2002:aa7:914c:0:b0:881:77d6:8d91 with SMTP id d2e1a72fcca58-88177d69009mr6653281b3a.7.1790670889773;
        Tue, 29 Sep 2026 01:34:49 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-885e23e9947sm420275b3a.47.2026.09.29.01.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 01:34:49 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-rdma: reject a second completion for a command already answered
Date: Tue, 29 Sep 2026 17:34:32 +0900
Message-ID: <20260929083432.1601397-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme_rdma_process_nvme_rsp() does not always complete the request it just
looked up.  When the request owns a memory region and the response arrived
without a remote invalidation, it posts a local invalidation and returns,
leaving nvme_rdma_inv_rkey_done() to drop the reference later.  Until that
completion runs the request is still live and its generation counter has
not advanced, so a controller that sends a second completion for the same
command_id passes nvme_find_rq() and reaches nvme_rdma_end_request() a
second time.

req->ref is initialised to 2, for the send and the recv completion.  A
duplicate answer produces three decrements -- the send completion, the
duplicate itself, and the deferred local invalidation -- and the last of
them takes the reference count below zero.

The generation counter added by commit e7006de6c238 ("nvme: code
command_id with a genctr for use-after-free validation") does not help
here: it is incremented in nvme_try_complete_req(), so it catches a
completion that arrives after the command has completed, not a second
completion that arrives before the first one has finished.

Both outcomes are a denial of service.  A duplicate that lands inside the
window trips the refcount_t saturation warning, which taints the kernel
and panics it when panic_on_warn is set; one that arrives after the window
instead trips "got bad command_id" and resets the controller.  In the runs
below every stray decrement landed on a request that had completed but had
not yet been reissued, and no KASAN report accompanied any of them, so
this is not a use-after-free with attacker-controlled reuse.

Mark a request once its completion has been consumed and refuse a second
one before it can touch status, result or the reference count.  The flag
is cleared per submission, beside the refcount it protects, so a reused
tag always starts clean.  A command whose duplicate is refused still
terminates normally through the local invalidation that the first response
posted.

Reproduced against a modified nvmet-rdma that answers one command twice,
first with a plain SEND and then with SEND_WITH_INV:

  refcount_t: underflow; use-after-free.
  WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xad/0xe0,
    CPU#0: kworker/u8:0/12
  Modules linked in:
  CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted
    7.3.0-rc5-nvmerdma-atk-g72d3fcf802c4-dirty #27 PREEMPT(lazy)
  Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix,
    1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  Workqueue: rxe_wq do_work
  RIP: 0010:refcount_warn_saturate+0xad/0xe0
  Call Trace:
   <IRQ>
   __ib_process_cq+0xe1/0x390
   ? __pfx__raw_spin_lock_irq+0x10/0x10
   ib_poll_handler+0x6e/0x200
   irq_poll_softirq+0x1df/0x480
   ? __pfx_irq_poll_softirq+0x10/0x10
   ? __pfx__raw_spin_lock+0x10/0x10
   handle_softirqs+0x182/0x5a0
   ? __pfx_handle_softirqs+0x10/0x10
   do_softirq+0x3d/0x60
   </IRQ>
   <TASK>
   __local_bh_enable_ip+0x6a/0x70
   __alloc_skb+0x5f5/0x890
   ? enqueue_timer+0xe6/0x3f0
   ? __pfx___alloc_skb+0x10/0x10
   ? _raw_read_unlock_irqrestore+0x16/0x50
   rxe_init_packet+0x16b/0x4f0
   rxe_requester+0xeab/0x51f0
   ? rxe_completer+0x29e5/0x38c0
   ? wakeup_preempt_fair+0x5dd/0xdd0
   ? __pfx_rxe_completer+0x10/0x10
   ? __pfx_rxe_requester+0x10/0x10
   ? wakeup_preempt+0x1d5/0x330
   ? ttwu_do_activate+0x124/0x590
   ? _raw_spin_lock_irqsave+0x86/0xe0
   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
   ? pwq_dec_nr_in_flight+0x2b2/0xc60
   ? __pfx_rxe_sender+0x10/0x10
   rxe_sender+0xe/0x30
   do_work+0x144/0x470
   process_one_work+0x6b4/0x10e0
   ? __pfx___schedule+0x10/0x10
   ? __pfx_process_one_work+0x10/0x10
   ? _raw_spin_lock_irq+0x81/0xe0
   ? __pfx_do_work+0x10/0x10
   ? assign_work+0x11d/0x370
   worker_thread+0x45b/0xd10
   ? __pfx_worker_thread+0x10/0x10
   kthread+0x2c8/0x3b0
   ? recalc_sigpending+0x15c/0x1e0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x36e/0x5a0
   ? __pfx_ret_from_fork+0x10/0x10
   ? __switch_to+0x572/0xdd0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>
  ---[ end trace 0000000000000000 ]---

The window is narrow and load dependent.  With an idle completion queue
the local invalidation completes in about 85 us and the second answer
arrives too late to matter; under concurrent I/O the invalidation
completion is delayed to milliseconds and the duplicate lands inside it.
Counting the warning is misleading because REFCOUNT_WARN is WARN_ONCE, so
the stray decrements were counted directly:

  unpatched: 18 duplicates accepted inside the window, 18 stray
             decrements on a zero reference count, 1 warning
  patched:   5 duplicates landed inside the window, all refused,
             0 stray decrements, 0 warnings

Every refused command still completed, and an unmodified target is
unaffected with register_always set either way.

Fixes: 2f122e4f5107 ("nvme-rdma: wait for local invalidation before completing a request")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/nvme/host/rdma.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9cb811a2ce1f7..f96d421518293 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -82,6 +82,7 @@ struct nvme_rdma_request {
 	struct nvme_rdma_sgl	data_sgl;
 	struct nvme_rdma_sgl	*metadata_sgl;
 	bool			use_sig_mr;
+	bool			rsp_seen;
 };
 
 enum nvme_rdma_queue_flags {
@@ -1568,6 +1569,7 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 
 	req->num_sge = 1;
 	refcount_set(&req->ref, 2); /* send and recv completions */
+	req->rsp_seen = false;
 
 	c->common.flags |= NVME_CMD_SGL_METABUF;
 
@@ -1738,6 +1740,15 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 	}
 	req = blk_mq_rq_to_pdu(rq);
 
+	if (unlikely(req->rsp_seen)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"Duplicate completion for command_id %#x on QP %#x\n",
+			cqe->command_id, queue->qp->qp_num);
+		nvme_rdma_error_recovery(queue->ctrl);
+		return;
+	}
+	req->rsp_seen = true;
+
 	req->status = cqe->status;
 	req->result = cqe->result;
 
-- 
2.43.0

