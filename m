Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792541950;
	b=ohKMyXTIE0hPZuHxrBkaZAydfTpjB2sfLIsr5coCg1KGgYnfdwK6cx4bxZWDGZ7wd6oN
	 V3WwZNFjaNFxySEPRHE0mygYJcXYwB2fmncfOR2wOYREJTLPVaNAleaaF+ueKDcyIF4x9
	 onbzpFAfdaA2/WQQSmUDIAKK93J0lYX+5IoPzw5M8jZfb7XIZppDIRiP81fono8I+oJ9J
	 i39RIOHLaXz6wMgXISIOrqw+BBuJj37iO7lZHnwkGmAtO8EfoWLlAZBcbjuEYqyq2c5xq
	 gQQnU4P8tjNLdI1vm5t7Dfg9Y2eaPV2fOseW1GrTdFxtk/3Zv+ROkBsHDYio+0CxvDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pGpt2LwanaD/GvAPAwxQMXFrIwRoaq29ij9OLsypfIA=;
	b=XNY7nGRdFQ03W+uO2kK9FglsVKqZdmpQ2Bg8rjd3aP2C7RHZu1CzyByj7xbiO+4w/9XJ
	 X34srgBFf8YrJsG8ZeLjROOwNV71BvfDW+qEFCiiI+l0fLmE8WA3MIRhk2pMmt4laeRM5
	 9WhdfvtLho86/PIN0iivKqoOh7mPHcIUVJXtFXk5AkMwzz2TNWOdSvhRWkkv3FODXFRRL
	 pIxscTBUEQqgJRStDQuYp5sed6HVhTCNUQWtylhw2MpfrE5tutQYAcphSPWi509BZ4poh
	 jtrfvh8A9+J5+LwnD1P49aIvSO5OOoxXwo0oJX6vnZMUDb4HGEpNiSfzC9goqYAEpBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=rwm4RFYp;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC16A606A31C
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 00:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC16A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=rwm4RFYp
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2db80fcdf8bso1073895ad.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 17:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792541949; x=1793146749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pGpt2LwanaD/GvAPAwxQMXFrIwRoaq29ij9OLsypfIA=;
        b=rwm4RFYpNrxxNFadM20VP9dugTFB/pKWcqFPDJ6jKpxvXplFBEBgL7YdROhayPDA30
         oUm5oYuQbU+pm7FaqUP3PS3y2Hl/oHLsgd534f8rmWt6eZpNVqpR2liacwWck4icdyV5
         n4P+Q+k7KNXXph61Be/vH0lVEtHdLnakdQSwtfW+zFtv2TUnlzDX7kc5X207Y9I/uRq3
         yBNzIdoPk6m+dfbXYev74NWO2D4ftmwc34B3ebXekzX7SR2fbURuZJEEnj2midQW/gXG
         j/I92ZUpjEefAMGLjZC8McSN41sY70B8HxdC6KD9mIf8ZWJDXoFVPVTs7stqJnPul5Ye
         LAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792541949; x=1793146749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pGpt2LwanaD/GvAPAwxQMXFrIwRoaq29ij9OLsypfIA=;
        b=wYXPfnZhAqLYJMc+opMdsK1wxztJBbwuLuKcaTApa/2bUEbCXqh9i7uHFqQpDn3hc5
         qqkeTDVK/uGMU9U91vOfV0gKCn3vNF0WzQhdZtYZ+YmF8yvDVATvglN4e089SVpqtnIB
         q3amlXCxaMXQKLVPRL2La5VsYAu1pzskVCVL40i1J9fGqmJnA9HywsiYNu21g0zH1tE7
         CLMI+wGQKx1pf1YznzgraPc7aTJSxaVV9tZojHWY2xHZM+VIrlDGeKsB7xcv/fngDBwO
         woNu38uJFcr0WcM/0WuOhF47kAWYI920oc2nureGa2Ch/fzsrs5XRSH4XRmG5j8RXLrq
         CJHA==
X-Forwarded-Encrypted: i=1; AKwUvBxiSgAfm4f2uERuggXCKOpoLJZIYwacCe1H+wm6dRFBlJScgtCq4TJrJhCMMRT0F6wdSwDtwLw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaIjdR8LejkwW3+Hf0hqqal7uavmxNlT8v+b0L0IJEH48xOvi5
	Z+Nd1bGJOPTJ5QN7Jk3jrpxPHAdjLUCQ4zqxFBknD89oG+eyD+Q2TvcRxiKhk75ibfQ=
X-Gm-Gg: AYBFou2lmTZPDj3hRItkr9JH8CR+eDFihJ9GredDi6O7SFFYfE+He2HR9IL7ZPycEFI
	fCVDdxe/Dy1bEuCRFo9v1wyjOjbwgncMKkiFjabJMyNKy6H9Mv3RYExeEX/GujnF7+bUD3u+BD9
	OhuNsJ2y7xmiS3YZJqM/pJ9BSEGfTXakwKwGYAwFTGCfywGRyYaMx0TU/yPwPAtDYfxiPGaEQs0
	NcO3+qK6aZ2zYmqtXlpuoIZ2+9dMc+UN2dhwus9yGvHLag4BGQQEOp3a8Rx45mWsPvbJYbRe/IT
	zyAyTBxxGoY6IjJbRQI2HpwkvxLac81TLa3rRtmZzDCkh5YUYh4zucpMP1JBCvtWQDYBBYRAJ/9
	zzOd7Z+ypAG4g3wyNYFuAiOZcvJSM3PXLLwaqWzADpZzsdCw+pW3SFAFy0XxZB9/WJoXFQoTdXV
	ujrtCo6RGtAlHUFuuJMyD3rbap8NidVxL4n0vI8lajNSb3jUxQsYV5MkZvhs2TbCJRYt3Tf64uw
	Ea8UoqyNum8zVEJ5uYV
X-Received: by 2002:a17:902:d2c1:b0:2e9:ca71:45f4 with SMTP id d9443c01a7336-2ea43c5ff3amr2928735ad.33.1792541948589;
        Tue, 20 Oct 2026 17:19:08 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:e416:85ef:f22:6c5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4729b2sm3952655ad.53.2026.10.20.17.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 17:19:07 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v2] RDMA/srpt: bound the indirect descriptor table and widen the counters
Date: Wed, 21 Oct 2026 09:18:53 +0900
Message-ID: <20261021001854.2343027-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
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

srpt_get_desc_tbl() bounds the number of indirect data buffer descriptors
by the two counts the initiator put in the SRP_CMD, and both are u8, so it
admits an nbufs of up to 510:

	if (nbufs >
	    (srp_cmd->data_out_desc_cnt + srp_cmd->data_in_desc_cnt)) {
		...
		return -EINVAL;
	}

Nothing checks that the header and those nbufs entries are inside the
information unit that was received.  srpt_alloc_rw_ctxs() walks
idb->desc_list for nbufs entries ending at

	sizeof(struct srp_cmd) + (srp_cmd->add_cdb_len & ~3) +
	sizeof(struct srp_indirect_buf) +
	nbufs * sizeof(struct srp_direct_buf)

which is 8480 bytes for an add_cdb_len of 252 and an nbufs of 510, past
recv_ioctx->byte_len and, at the default srp_max_req_size of 8276, past
the req_buf_cache object.  An add_cdb_len of 52 already suffices.  The
immediate data branch of this same function bounds its length against
srp_max_req_size and against recv_ioctx->byte_len, so bring the indirect
branch in line.

The count also outruns the counters that track the contexts, which are u8,
so at 256 descriptors n_rw_ctx wraps to zero and srpt_release_cmd() skips
the free:

	if (ioctx->n_rw_ctx) {
		srpt_free_rw_ctxs(ch, ioctx);
		ioctx->n_rw_ctx = 0;
	}

Such a command leaks every scatterlist target_alloc_sgl() allocated, every
registration rdma_rw_ctx_init() set up, and the rw_ctxs array, whose
kfree() sits inside srpt_free_rw_ctxs().  ioctx is a ring entry the next
command on the same tag overwrites, so the array pointer is lost too.  A
count between 257 and 510 leaks 256 contexts and frees the remainder.

Both changes are needed: a 510 entry table fits a default 8276 byte IU
when add_cdb_len is zero, so the new bound accepts it and the counters
still have to hold it, and widening the counters does nothing about a
table reaching past the IU.

Check the header against byte_len before reading the table length, and the
table after the existing count guard has bounded nbufs at 510.  The bound
is the number of descriptors the remaining bytes hold, so there is no
multiplication to overflow and a negative byte_len is refused.  Widen both
counters to int, which suits every user: the loops that walk the contexts
backwards use an int index and stop at -1, the sq_wr_avail accounting
passes the value to atomic_add() and atomic_sub_return(), and the three
places that print it use %d.

The KUnit harness below is not part of this patch.  It calls
srpt_get_desc_tbl() with a fabricated SRP_CMD in a buffer from a
kmem_cache shaped like req_buf_cache, and stubs only rdma_rw_ctx_init()
and rdma_rw_ctx_destroy(), the two helpers that need a live QP.  An
add_cdb_len of 252 with an nbufs of 510 gives

  BUG: KASAN: slab-out-of-bounds in srpt_alloc_rw_ctxs+0x6ee/0x950
  Read of size 4 at addr 000000006318205c by task kunit_try_catch/33

  CPU: 0 UID: 0 PID: 33 Comm: kunit_try_catch Tainted: G                 N  7.3.0-dirty #7 VOLUNTARY
  Tainted: [N]=TEST
  Call Trace:
   [<600a43cf>] ? dump_stack_lvl+0x5e/0x7a
   [<600450d2>] ? _printk+0x0/0xd7
   [<60051cce>] ? print_report+0x14b/0x517
   [<6039355e>] ? alloc_pages_node_noprof+0xae/0x120
   [<600450d2>] ? _printk+0x0/0xd7
   [<60a5d70e>] ? srpt_alloc_rw_ctxs+0x6ee/0x950
   [<603c78eb>] ? kasan_report+0x11b/0x160
   [<60a5d70e>] ? srpt_alloc_rw_ctxs+0x6ee/0x950
   [<60a5d70e>] ? srpt_alloc_rw_ctxs+0x6ee/0x950
   [<6008fdc9>] ? srpt_test_run.constprop.0.cold+0x177/0xd8f
   [<60a5fd30>] ? srpt_test_run.constprop.0+0x0/0xea0
    [ ... ]
   [<6072718c>] ? kunit_try_run_case+0x1bc/0x310
   [<60726fd0>] ? kunit_try_run_case+0x0/0x310
   [<6072d250>] ? kunit_generic_run_threadfn_adapter+0x0/0x100
   [<6072d2cc>] ? kunit_generic_run_threadfn_adapter+0x7c/0x100
   [<6014750e>] ? kthread+0x36e/0x560
   [<601471a0>] ? kthread+0x0/0x560
   [<600a90de>] ? new_thread_handler+0xce/0x130
  The buggy address belongs to the object at 0000000063180000
   which belongs to the cache srpt-kunit-iu of size 8276
  The buggy address is located 8 bytes to the right of
   allocated 8276-byte region [0000000063180000, 0000000063182054)

  Memory state around the buggy address:
   0000000063181f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   0000000063181f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  >0000000063182000: 00 00 00 00 00 00 00 00 00 00 04 fc fc fc fc fc
                                                      ^
   0000000063182080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

With 256 descriptors inside the IU there is no splat, because that case is
a leak rather than an access past an object: the harness counts 256
rdma_rw_ctx_init() calls and no rdma_rw_ctx_destroy() call.  After this
patch both shapes are refused, and 1, 128, 255, 256 and 510 descriptors
that fit the IU are accepted with every context freed again.

Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v2: also bound the indirect descriptor walk against recv_ioctx->byte_len,
as raised in review; widen the counters as in v1.
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 21 +++++++++++++++++++--
 drivers/infiniband/ulp/srpt/ib_srpt.h |  4 ++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 7197d95f2216b..5a12581286194 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -959,7 +959,7 @@ static int srpt_alloc_rw_ctxs(struct srpt_send_ioctx *ioctx,
 	struct srpt_rdma_ch *ch = ioctx->ch;
 	struct scatterlist *prev = NULL;
 	unsigned prev_nents;
-	u8 n_rdma, n_rw_ctx;
+	int n_rdma, n_rw_ctx;
 	int ret, i;
 
 	if (nbufs == 1) {
@@ -1115,7 +1115,16 @@ static int srpt_get_desc_tbl(struct srpt_recv_ioctx *recv_ioctx,
 	} else if (((srp_cmd->buf_fmt & 0xf) == SRP_DATA_DESC_INDIRECT) ||
 		   ((srp_cmd->buf_fmt >> 4) == SRP_DATA_DESC_INDIRECT)) {
 		struct srp_indirect_buf *idb = srpt_get_desc_buf(srp_cmd);
-		int nbufs = be32_to_cpu(idb->table_desc.len) /
+		int desc_off = (u8 *)idb - (u8 *)srp_cmd;
+		int nbufs, room;
+
+		if (desc_off > recv_ioctx->byte_len - (int)sizeof(*idb)) {
+			pr_err("received SRP_CMD with a truncated indirect descriptor header (%d + %zu > %d)\n",
+			       desc_off, sizeof(*idb), recv_ioctx->byte_len);
+			return -EINVAL;
+		}
+
+		nbufs = be32_to_cpu(idb->table_desc.len) /
 				sizeof(struct srp_direct_buf);
 
 		if (nbufs >
@@ -1128,6 +1137,14 @@ static int srpt_get_desc_tbl(struct srpt_recv_ioctx *recv_ioctx,
 			return -EINVAL;
 		}
 
+		room = (recv_ioctx->byte_len - desc_off - (int)sizeof(*idb)) /
+			(int)sizeof(struct srp_direct_buf);
+		if (nbufs > room) {
+			pr_err("received SRP_CMD with %d descriptors but room for %d in the IU\n",
+			       nbufs, room);
+			return -EINVAL;
+		}
+
 		*data_len = be32_to_cpu(idb->len);
 		return srpt_alloc_rw_ctxs(ioctx, idb->desc_list, nbufs,
 				sg, sg_cnt);
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
index 4c46b301eea18..1dce9bcb490f0 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -223,8 +223,8 @@ struct srpt_send_ioctx {
 	struct ib_cqe		rdma_cqe;
 	enum srpt_command_state	state;
 	struct se_cmd		cmd;
-	u8			n_rdma;
-	u8			n_rw_ctx;
+	int			n_rdma;
+	int			n_rw_ctx;
 	bool			queue_status_only;
 	u8			sense_data[TRANSPORT_SENSE_BUFFER];
 };

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.43.0

