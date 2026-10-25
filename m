Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792892287;
	b=zMHtqpccYYwvx2AezdgCMWk4FY7UktVX/zLEmuwexoEpX49H7IMMvQr5hArldGx1Tl/C
	 VIpQNdme+2nsHkmpmiD+/3MIsGuX4GgSin6lECz2ZYAphrK/LVSzH034jzqob2iKS35AE
	 WrBu7vw2WqGrJmGqshkcSYqIiHCKwd/ASIeJEvhU7hUWrSvHuYfkoi3C/qAMcGc6Lr+Pm
	 ol5vggoWcwSyXxSWhi7YBr0LFnGxSYFjbyU+0XF7fi0qnLMnjQoyDjqG2JCrANbp/d8yO
	 AXZzw0gbdF3NXQ+ET9JHM20fvy6LTEo1njOocP/7jf6Nf/Wey4WsD/Ku9QDaLeRwxog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792892287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GE7Vb8T2woD+VGnNBcKvWotC6HZWTCQNkbu5VL66Vv0=;
	b=TB0ET+2V8G4DSP6QFKQ/ePBs0b8EmhhSUUPRgdHrS9DV5TcuE92j7Y+oEanYMwlcDomz
	 xU6Oyk1/Ls7NudZftfZEVENkDQh3IjRwfu57bWuOHHNMJUeDRbsTP/XEDZHasXhLp4Vcm
	 4HC6drmCu5kBq6tfnseiveRW5IrfFOf+q3xCXTPM9EuCdC7UG7zYRJOHdFGCAYxjcRJNy
	 kaTHt8pvuGHYIZJBPXXqLvgArWycphti28Jg1/JCApFUIsBbgJFQuFEHMAOIpSACVWf+H
	 rSFvoWAUKtBh+uUVjDLqGwnjH+HuSMNjq40ygBc7IptJ1Pe/GGZv243yNgXAkt702WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=lgsgyk2I;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ED8606A323
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 01:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65ED8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=lgsgyk2I
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3514b90bb89so4673901eec.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 18:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792892287; x=1793497087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GE7Vb8T2woD+VGnNBcKvWotC6HZWTCQNkbu5VL66Vv0=;
        b=lgsgyk2IbT9HmYkF1vkL1psHiDVukRm7MKEwrZkVUM8QFdh7blIn7iMzfju7b/2w4d
         1FHlMJZ4v68W1wiNSUF3QiBh54VsVFyDEMMrZlrhjLIfXaB8u8lY+l2FRYcnmVANAFF7
         lLygdedp34vN8kGgA/Xv0bxuQVl5x+s8LpM0Fpb1oa14m+94MjZwON2yKAUNZfRA5ZTa
         7HYU4y2JGgiqlNOBVqx0KyyWF4wjv109UhBS6CAWz00iRJyydbjseO2MWJT8hCsCcmXn
         AZObaGGlD7K2qCgVtnCBo7yyhaM6S4UVex1jEqT/prqMJwQz6BUdqrnoU3Wcw9wRZ6O4
         Ds4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792892287; x=1793497087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GE7Vb8T2woD+VGnNBcKvWotC6HZWTCQNkbu5VL66Vv0=;
        b=Khgb0xc2sV0EK024UOujI9VBQT8zp38xisC3Om/9GprHiyvq2+zzF1lG27jFvrWP7J
         JVGwrL4P/cJFSeVe9QWFf1dOl28HggRGMQTMbGo6sATJB6bxx/4fIy+b0puOEgjAs5rX
         +DWRQtF3cehPemQhV/6rUH10ZIsYP7Dk5g5g3HcEdHWJVjNbj+/C6fK2VLvSfp1MIcmR
         PPd/XkHaj6WL4DFAfRgVEoJlmdStTcyXUzwZ/hcf5mogvzR8zH1gVaBQcWnrfCtp20oZ
         d0WHbCjejdakIRJCE0lI/gj9eV5tTDmatD8ZdKZBIbL3iQWvcZPjRQarxf8kWahdrycJ
         gLGQ==
X-Forwarded-Encrypted: i=1; AKwUvBx04PIQVf3oqQ6s+BIs0TDQy2hx49RP7XcqdwCUMWG/mCPoiOsGNXHrxH0YkGMslwAo1oDUo0Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDVNrbxe8VWLFcodVOgAvzvDpBXNaRxedtI0AvuVaKKKZL1gYF
	CoyJAh9LeaWR6sxxKmPJeGvN77Uq4pj/KZ15L30sVJyP9Ae4JJ6hYNVuGcv+IrqM8Mo=
X-Gm-Gg: AYBFou1k0yDH+H7r/7ukBgRcDIpoZyfP/UhXS0F5wTqI2e0uUbZYcyoGVD8Ot8y1AtX
	bKHSHZc/QpW31uqf0P8X8ugIfqVGMReXcmzyK0TTCyrOJyu9+TKTSWYQ3Az2FxqDvC9Pm0mu82e
	wimjbczqNWigySK/HIOyu/RaLDlT8wAb2WpzqnZp0CZMMRrOfh6hCT+uwZrh043OESngb9ZCqVM
	k8lXk8FUzWxDbOr2gKL8+IWfMbFrsRxoV1M/WRfaIWZCGRwcuJtmeWvfDc+8X3YCcIYmYhMLPl3
	06i//fc6m2x0K8Q86mcGsGhm+146ovNS3ENgvVjvPX5bLP9ncbQAzOoQyVmPErLo0LRA8AWjI42
	QCT+ZVYB91u9ZIIs/+HhySEJ9zp84jqZcprgTDnHGxHtqDzCqVdvPb16qWx6XPu1xCZDnjlPnV8
	68jdKNfOC+EbE0d5CCr0c1O2znAdHNg19Dy5XrAvEmzXWWSFOxe7eEEEbzWEDlfzFQJATh5Oy9R
	wsyDuuvn6bPNVyAEmRj1t/n271gVu49Nse7rWEe54Vwkvxg/PIKcCvSVjR1m9ZPvU4j20q1QHT4
	2xPCqRwt51VqHTFLhwouToRa6j0U4Db8Bhfzr5m3XbGJo2z8NZ4Y5z+SJBuLIwtl
X-Received: by 2002:a05:7300:e522:b0:351:245b:d1e7 with SMTP id 5a478bee46e88-369e81d398amr5582153eec.0.1792892286486;
        Sat, 24 Oct 2026 18:38:06 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:dba3:be57:a674:a67f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8dbaa42sm13724329eec.21.2026.10.24.18.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 18:38:06 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v5 1/3] RDMA/srpt: bound the indirect descriptor table to the IU
Date: Sun, 25 Oct 2026 10:37:46 +0900
Message-ID: <20261025013748.3755639-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261025013748.3755639-1-yhlee@isslab.korea.ac.kr>
References: <20261025013748.3755639-1-yhlee@isslab.korea.ac.kr>
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

srpt_get_desc_tbl() takes the number of INDIRECT descriptors from
idb->table_desc.len, which the initiator controls, and checks it only
against data_out_desc_cnt + data_in_desc_cnt, two more initiator fields.
Both are u8, so the pair admits up to 510 descriptors, and nothing
compares the table against the receive IU it has to live in.
srpt_alloc_rw_ctxs() then walks idb->desc_list for that many entries.

With the default srp_max_req_size of 8276 the table fits as long as the
additional CDB is short, but ADDITIONAL CDB LENGTH is an initiator field
too, and at its maximum of 252 bytes 510 descriptors end at
48 + 252 + 20 + 510 * 16 = 8480, which is past the end of the object.

  BUG: KASAN: slab-out-of-bounds in srpt_alloc_rw_ctxs+0x631/0x870
  Read of size 4 at addr ffff888002d6a05c by task kunit_try_catch/43

  CPU: 0 UID: 0 PID: 43 Comm: kunit_try_catch Tainted: G                 N   7.3.0-12378-g6fba331225f5-dirty #1 PREEMPT(lazy)
  Tainted: [N]=TEST
  Call Trace:
   <TASK>
   dump_stack_lvl+0x3f/0x50
   print_report+0xcd/0x620
   ? alloc_pages_node_noprof+0xa2/0x140
   ? srpt_alloc_rw_ctxs+0x631/0x870
   kasan_report+0xde/0x110
   ? srpt_alloc_rw_ctxs+0x631/0x870
   srpt_alloc_rw_ctxs+0x631/0x870
   srpt_test_parse+0x114/0x580
   ? __pfx_srpt_test_ctx_common.constprop.0+0x10/0x10
   ? __pfx_srpt_test_parse+0x10/0x10
   ? srpt_test_ctx_init.constprop.0+0x4cb/0x6c0
   srpt_test_run.constprop.0+0xc1/0xa60
   ? pick_task_fair+0x126/0x1950
   ? __pfx_srpt_test_run.constprop.0+0x10/0x10
   ? update_curr.constprop.0+0x4a/0x390
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

  Allocated by task 43:
   kasan_save_stack+0x33/0x60
   kasan_save_track+0x14/0x30
   __kasan_slab_alloc+0x6e/0x70
   kmem_cache_alloc_noprof+0xfc/0x2b0
   srpt_test_ctx_common.constprop.0+0x46f/0x9b0
   srpt_test_ctx_init.constprop.0+0x30/0x6c0
   srpt_test_run.constprop.0+0xb6/0xa60
   kunit_try_run_case+0x1ca/0x4b0
   kunit_generic_run_threadfn_adapter+0x7b/0xe0
   kthread+0x36e/0x500
   ret_from_fork+0x34d/0x620
   ret_from_fork_asm+0x19/0x30

  The buggy address belongs to the object at ffff888002d68000
   which belongs to the cache srpt-kunit-iu of size 8276
  The buggy address is located 8 bytes to the right of
   allocated 8276-byte region [ffff888002d68000, ffff888002d6a054)

The KUnit harness that forces this is not part of this patch.

A table_desc.len below one descriptor is the other way in. It gives nbufs
zero, which the count check admits and a span check cannot catch either,
since an empty table fits in any IU. srpt_alloc_rw_ctxs() then returns
success with n_rw_ctx zero, no scatterlist is chained, and
srpt_write_pending() reaches ib_post_send() with an empty work request
list. rvt_post_send() evaluates !wr->next before the loop that tests wr
against NULL, so an rdmavt device faults there whenever its send queue is
idle.

Reject a table that does not fit by comparing the span it occupies
against byte_len, and reject an empty one. The span is the table offset
plus struct_size(idb, desc_list, nbufs), and nbufs is at most 510 once
the existing count check has passed, so it cannot saturate.

The header always lies inside the allocated buffer, since the largest
offset srpt_get_desc_buf() can return is 48 + 252 and the header is 20
bytes, so it ends at 320 while srp_max_req_size is at least
MIN_MAX_REQ_SIZE, which is 996. It does not always lie inside the bytes
the initiator actually sent, which is why the span starts at the table
offset and covers the header as well.

Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 43c3ff1ad8e7e..40d796840befc 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -1117,6 +1117,7 @@ static int srpt_get_desc_tbl(struct srpt_recv_ioctx *recv_ioctx,
 		struct srp_indirect_buf *idb = srpt_get_desc_buf(srp_cmd);
 		int nbufs = be32_to_cpu(idb->table_desc.len) /
 				sizeof(struct srp_direct_buf);
+		size_t desc_off = (uintptr_t)idb - (uintptr_t)srp_cmd;
 
 		if (nbufs >
 		    (srp_cmd->data_out_desc_cnt + srp_cmd->data_in_desc_cnt)) {
@@ -1128,6 +1129,18 @@ static int srpt_get_desc_tbl(struct srpt_recv_ioctx *recv_ioctx,
 			return -EINVAL;
 		}
 
+		if (nbufs == 0) {
+			pr_err("received SRP_CMD with an empty indirect descriptor table\n");
+			return -EINVAL;
+		}
+
+		if (desc_off + struct_size(idb, desc_list, nbufs) >
+		    recv_ioctx->byte_len) {
+			pr_err("received SRP_CMD indirect table (%d descriptors) that does not fit the %d-byte IU\n",
+			       nbufs, recv_ioctx->byte_len);
+			return -EINVAL;
+		}
+
 		*data_len = be32_to_cpu(idb->len);
 		return srpt_alloc_rw_ctxs(ioctx, idb->desc_list, nbufs,
 				sg, sg_cnt);
-- 
2.43.0

