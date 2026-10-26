Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792992045;
	b=ZApFgfmGhxbnmOKxZtxB7f2mPcBk5XnMuJ5PEE91YWYYc8frCJr21dx0cvO6H7utYcB/
	 VXlv6P8j8MwZ/EGkObT9rUneRq0K0hBxgF+glJV34AL26sMMsEqnD+2NlVxG3H+cJ6ZXZ
	 94h+UYAA/W0naOWsCRKMnktiXQ2Mhu8O3iKPPmcUqU/rkUM9YFndsGnlGUxpqu8DNDyUX
	 4P4SarNC89Fz7QyIJ54k+VlI3YLIUgM0hvusnTdDlMSYepmH6nmHuYd7E6aZ2LBa8y4K4
	 CV/Gy48MJpc/aq/64nOpLoV1GolpvG4OUfwEmWwT3XvQLIDeGQ3GYRcoG5sn/T3iEIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792992045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XvlIgy8HAuD18Pu9SXVycEWxWyGIpi2gLi2fcEDWRe8=;
	b=mSLcYJN+CzFG5EloDEG8txmbEZfYN+6w1zXqrAfPJmthbikATytZLz/5gibVpwJSRV2w
	 LW6aEo883GZMIhGqNdAzt5kuJF2f/HKgimMCTX9/QedF709otYSqoxxq4sg6/SpjE1J09
	 QWpbvN4+ZSHaSh/Q8GCmfNvNjd5u6OHOlESCAFdBqy9XKIqy+UYeJEihs5TiWd0pjC9iX
	 kBD7SIycaSiePLyiXWH+8dA1r/2nm3m325TA6UjCJR+cbz4CHdZ4r8qi/4sM4TSdV+P6o
	 HJM7sCKzgsF8KkSIDtDRKhQy7f9xCsGjb+kkonaV2MpDgrCbTjp1aAdSNW66jVCeQ9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Cdr4P81v;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D65606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51D65606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Cdr4P81v
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-157fe9d771bso3094283c88.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792992044; x=1793596844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XvlIgy8HAuD18Pu9SXVycEWxWyGIpi2gLi2fcEDWRe8=;
        b=Cdr4P81vE2Fl0scL/6optiq2L6r4udH2U3nQi0SdgL7UdUZsuzbeWvrJ6jjzdk7tKD
         XYO9r8WCjaeTf9LnYOIKcP5LdO6EzuqYuBK82Je2HBRGM1wcSTLf/a+ZkfGto02++wvc
         Ntbi5hm8DyqIAD3EBzIcJzHLP2oF2uACm3zEO0XGLp0Sx9tMpng1bDvChbRfWScYrndq
         8HTPy7ytBoeT1XKYOOmsvg1wtlCpQtCk/6+FWYnaDU2F3zSk3c+2eEIcK+xhb0+0bROD
         mNJSvNMlZbwOaOWR6qs6I1E7Ca8JkCzPcPCpeBXRoUcLJL5fFTYsxErpVUPuvaJWWAEg
         Xsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792992044; x=1793596844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XvlIgy8HAuD18Pu9SXVycEWxWyGIpi2gLi2fcEDWRe8=;
        b=zX/RA9V4BjI3YZZAckr3AAV3OaZI2t4u0AJr3u7hgTQZz66byvUOIU1V8a7SnKTOcG
         j1gHJPajQRkvCKfGkNG8dGpXazTRG2FvB/Y3C3gWQ5VfdeUxgxMz3cPtJOuviPOnCpmi
         AP7+LfutjsSv0vN5DjQcgEYq7cj11t2ooLGFxO75FtEX8teb+c5zMP7GzjC+UlkHv64s
         0EoDFbC1Qk4Q+niYbHSNXOnFK/4b9kHPd9JBwD07KFwVeYtfjh07ln4JRLdFR0u4TttW
         1IKiXrLkZPd511FFMmr0PxMwieH40VokZP2WRlvufYPUP7imskgpy8bJmBtqseOR+Vcm
         Ax6g==
X-Forwarded-Encrypted: i=1; AKwUvBwHBo6WD20kycVcOw2zZRjfCIfflDq220nAvgbon+0Cpl3+ek8IDDoVentKH+UcCKaBfxJzxck=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQSuMfz6Glr7acoIx+xcwFtS6mX6iXgaMH97N8LKWYmZj/QMlg
	6DzCnFo1CiEqKgingr6HPO98EK+eM1bPE+13uDuuI/tYbuq45ZPcAqaGPWXHhYCFGUM=
X-Gm-Gg: AYBFou0qe9S1rfg8o3cSUn2pUpeQl4u9F3vBVAzYPZ4bGMxWXuyD/ogYnbw3OOpYjJ9
	yaODqqtEdGwACxgksUcH4LlauGBb1WUPtCHB4NKAIDZ4fDluseXyO+IORxj5JFhx8edI2WNNaZm
	xKpWS5Ne5iddpJBCLF6KN2A3hf7TmJK5M+yNh3rIZbtL5c85MH/KSp2Ev1IaWlCHBPVfhwU16U6
	AYbEu6NgwT8bxgCxueH3BKBuAXpM3OlQtPZdBt+Myl9gPjRDTc9IUz6kZgjxntR3bGA+kNEXgAw
	wKjqwKrTO+tKa+nQ+cS8iDwyYp9MQIsmqkog8nmsZtVvsJ3ldfHYP6BRFQqPDmvrkiRkWKPOUly
	7furZsCi4L7K1Gx3Msg8YGyxFd3pLfE8DQZAKlZ+bmwQLb1EJ0ZcCHT2ZEZAeDS+ILuIX/QeT5k
	EP8/X3y6QWGplKc8fuFs/JBwGXyt3yA4fpWuhS+vzayfVkwXuTs67pZg83MvwyiV/+fYwqtqARt
	iBsZmF9yO/KcmsvVN5NVeMjJH4HUrY84MCaNt20jioV/QU0NC2VEgOZcB3BfSxZ4fU5vH/txJYn
	SQWwkdthHU/HkqfhanWVIbPqAPdB44C47Rt5UoDlu8NZCbvMRNMPDgsC/JZYynpe1Jfo6Q==
X-Received: by 2002:a05:701b:2311:b0:16a:8ffd:4977 with SMTP id a92af1059eb24-199363a356emr7729321c88.17.1792992044011;
        Sun, 25 Oct 2026 22:20:44 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0f83cedsm26765774c88.13.2026.10.25.22.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 22:20:43 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v2 1/2] RDMA/srp: refuse a target that cannot receive an SRP_RSP
Date: Mon, 26 Oct 2026 14:20:28 +0900
Message-ID: <20261026052030.296361-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026052030.296361-1-yhlee@isslab.korea.ac.kr>
References: <20261025114155.4007867-1-yhlee@isslab.korea.ac.kr>
 <20261026052030.296361-1-yhlee@isslab.korea.ac.kr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

srp_cm_rep_handler() takes max_ti_iu_len straight from the target's
SRP_LOGIN_RSP and srp_alloc_iu_bufs() then sizes every receive IU with it,
so the target alone decides how large the initiator's receive buffers are.
Nothing enforces a lower bound.

The initiator parses a 36 byte header out of those buffers. A target that
reports a smaller max_ti_iu_len gets undersized buffers, and the header
reads in srp_process_rsp() then run past the allocation. A report of zero
is worse, because kzalloc() answers it with ZERO_SIZE_PTR, and on a
transport that maps addresses virtually ib_dma_map_single() returns that
pointer without looking at the length and ib_dma_mapping_error() reports
success, so the buffer reaches srp_recv_done() and the read of the opcode
is already out of bounds.

  BUG: KASAN: slab-out-of-bounds in srp_process_rsp+0x757/0xbe0
  Read of size 4 at addr ffff88800243f120 by task kunit_try_catch/42

  CPU: 0 UID: 0 PID: 42 Comm: kunit_try_catch Tainted: G                 N   7.3.0-13249-gcea86339412a-dirty #2 PREEMPT(lazy)
  Tainted: [N]=TEST
  Call Trace:
   <TASK>
   dump_stack_lvl+0x3f/0x50
   print_report+0xcd/0x620
   ? vprintk_emit+0x21d/0x380
   ? srp_process_rsp+0x757/0xbe0
   kasan_report+0xde/0x110
   ? srp_process_rsp+0x757/0xbe0
   srp_process_rsp+0x757/0xbe0
   srp_oob33_test+0x305/0x700
   ? __pfx_srp_oob33_test+0x10/0x10
   ? __set_cpus_allowed_ptr+0x181/0x240
   ? __pfx_read_tsc+0x10/0x10
   ? ktime_get_ts64+0x192/0x250
   kunit_try_run_case+0x1ca/0x4b0
   ? __pfx_kunit_try_run_case+0x10/0x10
   ? kthread_affine_node+0x24b/0x370
   ? __pfx_kthread_affine_node+0x10/0x10
   ? __pfx_kunit_try_run_case+0x10/0x10
   ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
   kunit_generic_run_threadfn_adapter+0x7b/0xe0
   kthread+0x36e/0x500
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x34d/0x620
   ? __pfx_ret_from_fork+0x10/0x10
   ? __switch_to+0x22/0xdd0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x19/0x30
   </TASK>

  Allocated by task 42:
   kasan_save_stack+0x33/0x60
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0x8f/0xa0
   __kmalloc_noprof+0x179/0x3b0
   srp_alloc_iu.constprop.0+0x69/0x5c0
   srp_cm_rep_handler+0xc2e/0x1bb0
   srp_test_login+0xc8/0x630
   srp_oob33_test+0xaa/0x700
   kunit_try_run_case+0x1ca/0x4b0
   kunit_generic_run_threadfn_adapter+0x7b/0xe0
   kthread+0x36e/0x500
   ret_from_fork+0x34d/0x620
   ret_from_fork_asm+0x19/0x30

  The buggy address belongs to the object at ffff88800243f100
   which belongs to the cache kmalloc-64 of size 64
  The buggy address is located 32 bytes inside of
   allocated 33-byte region [ffff88800243f100, ffff88800243f121)

The KUnit harness that forces this is not part of this patch.

Refuse the login instead. Both the largest messages the initiator parses,
SRP_RSP and SRP_AER_REQ, are 36 bytes, and a target that cannot send one
cannot speak the protocol, so nothing that works today is turned away.

Fixes: aef9ec39c47f ("IB: Add SCSI RDMA Protocol (SRP) initiator")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 5811f02df9805..a85d28b95306a 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2379,6 +2379,13 @@ static void srp_cm_rep_handler(struct ib_cm_id *cm_id,
 
 	if (lrsp->opcode == SRP_LOGIN_RSP) {
 		ch->max_ti_iu_len = be32_to_cpu(lrsp->max_ti_iu_len);
+		if (ch->max_ti_iu_len < sizeof(struct srp_rsp)) {
+			shost_printk(KERN_ERR, target->scsi_host, PFX
+				     "Target reported max_ti_iu_len %u, too small for a %zu byte SRP_RSP\n",
+				     ch->max_ti_iu_len, sizeof(struct srp_rsp));
+			ret = -ECONNRESET;
+			goto error;
+		}
 		ch->req_lim       = be32_to_cpu(lrsp->req_lim_delta);
 		ch->use_imm_data  = srp_use_imm_data &&
 			(lrsp->rsp_flags & SRP_LOGIN_RSP_IMMED_SUPP);
