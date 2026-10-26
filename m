Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792994086;
	b=5XmSZTdQKgOTR0wo/prY9X2sGH8p+tsbc5u6YO5hqYmfTUNB2oUzVvxQfmiO4uIffas2
	 BnQrmjRnaa2XnrQHRizDQyR0wp8Ja1tVFVPitPg0HoyQxKabS6ueRRVBiJPquiWKrNp1V
	 NQdqc9REeN54RNH5MmlA7OH4WdceTl9uNHZ3mYDwSsti4SMaJ09T3M19jp2wl/eL6Mgmi
	 Erlh7XhoG08yuXZzjqoPy7Ljt8QVnKjaJiR5cG6kYJexqUUWD1gDxDJegoM7ARLb7GqEw
	 90AAiBj7kOIwdO0ZLe5zS/r1KggV2MKPYjFhYhqQ1WDsbYOQ6GN/9+6kunqgzoHpQzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792994086;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XvlIgy8HAuD18Pu9SXVycEWxWyGIpi2gLi2fcEDWRe8=;
	b=yrCFQN2+VrIRyi0+Y/zvo6M00sb5ACHSEmyV/NzWj2XR6+B5UznjMTr2pdo3bMtS5iqL
	 ZV8FpV8bcqgjHUwWNwzO5D0MkABFZSt4Rg1S4VZi6A8pp8UjfW2SzZukOFMEccU52bPVw
	 etdBN3595PZo8w/xreLqaRqzeT7ocw+IxqhLHZ0bmkBY56ZSRTG+M+/37aNNB1PwMSrqb
	 HHv0q97uje2zLEsA/dc+FGpqiEiFo+oonTQhf/4dWqgbDXNGkAkrELXj1Gu0kGKdooWpB
	 TkiyV1SKkgmz2mr2WF+C91sVbrDrviXpgioIy728ZWei+v1gVfs6M+7poufe6WxXO9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=sTnlanKy;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C07606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0C07606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=sTnlanKy
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-369f33df08eso2139739eec.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792994085; x=1793598885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XvlIgy8HAuD18Pu9SXVycEWxWyGIpi2gLi2fcEDWRe8=;
        b=sTnlanKyZybmkGhjprBeqXmDv17Y5hhdng5w9Fvq/8EJiKAze7gEZW/hBEGZFpO2J2
         ikfcsGKvaMIFOgoKLy3Eyk6YFqGHnNCxrLRPVHfpCf00hOHg/tirVgq1Gr7uFrHPn9IG
         gHztIbyMiGCXNrdqBDHhKSUvs43KIOUxL36SBjIdi29vzAPsgEIslHUYID6PTU2U8MGT
         3veUzge4C5YtX2vDRMW1YmVr8TBNh+3IKA/nbZzDMyUIcEg2t7OVLJH9gmcektZs2+Z0
         O61mT5ii1YEu2XSvZvtuBaIGYU829DhcAHu93NSouV03uJ4FyiZB5XBS6rVXDafVwdeE
         oT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792994085; x=1793598885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XvlIgy8HAuD18Pu9SXVycEWxWyGIpi2gLi2fcEDWRe8=;
        b=VO5x0qkcTKDff+CL1xxf1142XFYkw4tduQjzfrn1BBC7F52Dej/fWBnCvVO2tf/9Nh
         TzpO/TWiNMqfR9KYZKzFGlvFNtp+Ncay2/8+8TdpBK6S38b+50axpSPz98p3MOiDZo9c
         7IhklmeNL7Ser6iAzCamL+mwyMfGQKb8UZbcdyxYa20eoy2XWXMXtQboXt/FIkwnZz43
         FnVbpdXU4PL0xr3n+mnqiL8u4ShgaQ+1BGVwWi8sY2PYf3JkWMiyVWI2lqN3iVuJMa7y
         qTj1qpi6cYAZXWSarAQZQAIiCLJUn4CJXmhUL4e8WmKJGr1Tt9d3+4h9xUX3Kz8aC23E
         HLAg==
X-Forwarded-Encrypted: i=1; AKwUvByRSdpK7uLYR57tkqGfh07SmI30zJR3GlN3yzaBt1dbRfUahea6xebzFbxutw4z9hBxIE8u9ig=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+kwBoVS8wlv+msR5P95fETta7dOD7RCwrzHKZb8WY+xIK96ia
	H/epao/J8DSKlC8mlwQPvW1tRdq51ePV92mC3lZ1R+/6OiuQhZ1xM0zn9XX7M1Z4UoU=
X-Gm-Gg: AYBFou2nnO6mRjZ/TSIMmLqXTpNU/uowl1wR9HtS1uAcpT2ZrfVKuvQMi2q69xSstvQ
	IBvuEG8a5vPfK8KEvVWicD53AqaU2VqGO4MkXCV0R1isKnGCzcxp1MTbqwjHFw+nhN+5bv+/34w
	PRA8eAVsLpMHTAhCKW81keznlFL6bWRS4aZQxqY64MulU+/FAdkVskmbuP4RLCtwU3QJkoXlixk
	Y9+KiqAHVXlfzAjyGB7abxGNGa9uEpuB6Ab24nQ1QWIB9MYgqQ53VXsdOq1M3yQ/rX0Xr6vl0ez
	erWkJVjL3gItPuElwK3ix2vnHm/IQzKM9olkoN2JD0pcdEdygHLDBWHW5tq9uQswj9fpRhhiZhq
	Ye1CvRYO0DzVstLOBk4sLwTlCUw6RsUv9S76doBiH5I/6cHvU1O7fQgtKaX4TLVFEfmRYxPKo2A
	e17n1Gb6wmlSBWEYYe3BlQIWi1UhDYoeTN1cheDQHFlEryphQljPOjvs2JGFkQUjVu28nqjgyjz
	NV4igEQh84MMqMcuU/qkCNwA+mqrT+j+L+3CBYcU42loXyVfUNP9rxAzTjCO8J3gYrX5i0cf449
	188XgvUaOknqQpyc5XVUOmTKOlF46lsYjHgYnavjPZvFlW92jA==
X-Received: by 2002:a05:693c:4015:b0:369:d992:e3 with SMTP id 5a478bee46e88-369e8660a6bmr8584496eec.32.1792994084594;
        Sun, 25 Oct 2026 22:54:44 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d845ddsm22290613eec.11.2026.10.25.22.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 22:54:44 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v2 RESEND 1/2] RDMA/srp: refuse a target that cannot receive an SRP_RSP
Date: Mon, 26 Oct 2026 14:54:29 +0900
Message-ID: <20261026055430.406487-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026055430.406487-1-yhlee@isslab.korea.ac.kr>
References: <20261026055430.406487-1-yhlee@isslab.korea.ac.kr>
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
