Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792892290;
	b=IuZbmPNCq5KDnwhImSu6RbB43nFN1GNAUgju4+i+pzPJLrTmtiNGq5td5eyfEPpnvAAo
	 jygoWfpJh8TTmkq/W+r5Mk+nK01Go2i87pExAS3F36U9fsUGhM5+C9LIGbjNe7lpnZyWO
	 9+sPV8FohCS+WfThVx4YxgOe5P4tiWoSv8Bb9xeaqawBmyIaK+bq6zDR/jH6s5zkh6zeT
	 sF4Mno2gZCjsKJG2yCbPSDyH/5D6nz1/XoRRzhEPKBVtdXte6Ur0GmH2re4tLCainnV+a
	 ASZOoaLvFNj1fcl9QbUm/drqeY4nLlK8UjRFgS/MnmapMrpfIdM3Rr98Zm68J6fuChA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792892290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OwT87TkRyG6fAEd7ylK/rWIM/7AqJXyhM7Ww/r4lOq4=;
	b=XWgTlGT932CBdBItD/5QS4cXHhX5InZZezUNrHqXSAvxkg4ys/NPJZ3aEWNw1Z79egNw
	 1GSsfwoWi52brU8bbs3gWJscrLmKWTVwTDumnk2d0UE/a2H4Hfnb3Wab7t7vynrKFVX28
	 5AxS+DXH+E6l67h/T6m2GG9l6ARjRvMy0c2XuJ48U8DJPO+44ANPsFnvj71W6zib2wtR8
	 0ucA1tRP8Eb4Fg38yGU05Zq7fhJUQNoS08t1Eyzw27r5Uq5hoJFEw7B1TlmN8eQS7XUke
	 Gg3xvDMiw1bPChGGxRKR3BNdo4wkOFkOVHXY4ubXDDyPxuSUkI9L2d/E1Ha5ReDHhug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=VTbCxHGY;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC3D606A321
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 01:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AC3D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=VTbCxHGY
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3550c917fd3so2998677eec.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 18:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792892289; x=1793497089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OwT87TkRyG6fAEd7ylK/rWIM/7AqJXyhM7Ww/r4lOq4=;
        b=VTbCxHGYQUc2nGwdMnpE0v024Jod606tsp6LU65Hynq3jQKnV7TiQmEXMJYfDNkDY9
         xTgdOUIEin3x2q7DbzoaHhqH4GiRpvaItmTr4zAzDyD74IVu1Gk2mpdWfhnTF8RZQUTQ
         1ZfnhgsS8eZZttjcd/Okk30Fu1SdD+Yd7T3DF+VQsY9AUjGR606dgv+Ayb/w9F+Lsy49
         KmqVo5mPv6iKQjPULSwRslixWagA//sSHuvgJV5KAQ1v3YEb9bpEoH+iOCeAhBkIbCC/
         uwB9lPkKtT1gB9e20e4ry0YROnMmC/uAsDGq1eBXFZ2UzDDQXjrTHnYhEdIzMeGrzUHh
         7qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792892289; x=1793497089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OwT87TkRyG6fAEd7ylK/rWIM/7AqJXyhM7Ww/r4lOq4=;
        b=v0Syd6uWY488E0UDil7mph1erldeuT/1bIXFvXUH1kXnBxqy6IGsaxnMKXRmGcKZcU
         72a6mN6hCw09kW8OthU5cnEFviKkGoBouTbgQK5kmFl+Cwk8uoM8mMzlyej2lb+RZP2j
         0sZzSfQjx4m0EEDUtok+AODjd0yXk6d+ftEPtvCapbvYKXSGE/bRzUXk3zG07r6SsOi+
         6aNPiMPRwpFOJTt2b5s+WoLKJ2NNKMT2t9nJjDsEXoOERWnKQexY/Zq6vJ5uo0IMa3xL
         UuYWq4EUSaKv0gMAUvzS1q2V0qC4PZccWRF9ZiU8crjDL77uLwZms58rKTIPKTnLVLSU
         OWQw==
X-Forwarded-Encrypted: i=1; AKwUvBz5r4b7tYzDF4uxtez3+IbKdXrw6CAqSHW8u57EVhwIxXd0NNyaSCtsAAgOdKLOuPKGrdGWwkQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWGp9XmM6FDz6eW7fEwlAvMIvMBEVlhwve8n24UBRUq3I5PZLK
	PfoashK6hVnv7TZiuSKigpc0t45ve91BpmRSj2DW5Yg2ZTX11EzGFYsNbdCBdA65D1A=
X-Gm-Gg: AYBFou2xhshA96bonx6WyHzfYGeoMBM9T76Jy8/+6vIZ05+CEMa/jacAFS74APTVi1t
	O7syCKQDKy/ei4cvHQFRVmZPjYLxwTa/+1b9WwC9c4XVqjMInGc20BzO25ykyJ3eN6KL4vtnEy6
	ExIb2KNw6IkQlVkUhujxU0HuraCNuYZg3HFvBjfTF7eEiEDTADPjo2tvax01lUhFmar0V6firfw
	qvfXdH0r/0/ZPplQrnALmZFKl6TofhWKDLjGBPqEsPOM1kuKS06R//dqpvgefrJb2Xq2JoeMhOI
	cNlsMapgpKwYhQ0LLXOYExtukwHK2JXX1OYHoXGfhm2VCkPObVZ4rs02iDCZzThPBFwZEdbER43
	B/k3wB//t26H3ywoIPS/MaItod49G43ArZY93bWhsRAfeV7UMynVVa4QRmq4dt0LjKi54IcRHKw
	mj+2wNkw9rRRn2dDut26Az+PYOZm4COjc5+gzXJWhXpS7G7LLiF7nPUwBGiu02T//v1LN49tsV7
	ObhgQYKV+b/8Ye+immLlMP4qHUZcEOO1u5iMZxdnjZuC+y9jYmun0ktbfECAydvY3GhWq9HxcbH
	oHPUCXT/hdZYdTCMbMPwf0taGpQmkbti5GNE8O4bKHfpEOBbHYQXYR8p1PFvMgwM
X-Received: by 2002:a05:693c:65d5:b0:359:8492:20ff with SMTP id 5a478bee46e88-369e842bda4mr4860522eec.12.1792892289422;
        Sat, 24 Oct 2026 18:38:09 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:dba3:be57:a674:a67f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8dbaa42sm13724329eec.21.2026.10.24.18.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 18:38:09 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v5 2/3] RDMA/srpt: reject zero-length buffer descriptors
Date: Sun, 25 Oct 2026 10:37:47 +0900
Message-ID: <20261025013748.3755639-3-yhlee@isslab.korea.ac.kr>
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

srpt_alloc_rw_ctxs() takes each buffer descriptor length straight from the
wire and hands it to target_alloc_sgl(), which has no length check of its
own.

For the single descriptor of a DIRECT request, and for the last descriptor
of an INDIRECT table, chainable is false, so a zero length makes
sgl_alloc_order() compute nalloc zero. kmalloc_objs() answers that with
ZERO_SIZE_PTR, which is not NULL, so the allocation looks like it
succeeded and sg_init_table(sgl, 0) runs. That reaches sg_init_marker(),
which does sg_mark_end(&sgl[nents - 1]) with nents unsigned, so the index
is 4294967295 rather than minus one and the read modify write of page_link
lands far outside any allocation.

  Oops: general protection fault, probably for non-canonical address 0xdffffc03fffffffe: 0000 [#1] KASAN PTI
  KASAN: probably user-memory-access in range [0x0000001ffffffff0-0x0000001ffffffff7]
  CPU: 0 UID: 0 PID: 43 Comm: kunit_try_catch Tainted: G                 N   7.3.0-12378-g6fba331225f5-dirty #1 PREEMPT(lazy)
  Tainted: [N]=TEST
  RIP: 0010:sgl_alloc_order+0xb6/0x370
  Code: ef 01 4c 89 e2 49 89 c4 31 f6 49 c1 e7 05 48 89 c7 e8 ae e0 cb ff 4d 01 e7 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 6b 02 00 00 49 bc 00 00 00 00 00 fc ff df 49 8b
  RSP: 0000:ffff888002d4fa38 EFLAGS: 00010202
  RAX: dffffc0000000000 RBX: 0000000000001000 RCX: 0000000000000000
  RDX: 00000003fffffffe RSI: 0000000000000000 RDI: 0000000000000010
  RBP: 0000000000000000 R08: ffff888002b158a0 R09: 0000000000000000
  R10: 0000000000000010 R11: 0000000000000037 R12: 0000000000000010
  R13: ffff888002d6803c R14: 0000000000000000 R15: 0000001ffffffff0
  FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffff88802f1c8000 CR3: 000000002e458000 CR4: 00000000000006f0
  Call Trace:
   <TASK>
   target_alloc_sgl+0x2b/0x70
   srpt_alloc_rw_ctxs+0x2ef/0x870
   srpt_test_parse+0x114/0x580
   ? __pfx_srpt_test_parse+0x10/0x10
   ? srpt_test_ctx_init_direct+0x17d/0x280
   srpt_direct_len0_test+0xa4/0x280
   ? __pfx_srpt_direct_len0_test+0x10/0x10
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

The KUnit harness that forces this is not part of this patch.

A zero length descriptor elsewhere in a table is chainable, so one entry
is allocated and that write does not happen, but the entry count comes
back zero and the mapping in rdma_rw_ctx_init() then refuses it.

The target core never hands the same allocator a zero length. Its own call
in transport_generic_new_cmd() sits behind a cmd->data_length test.

Reject a descriptor whose length is zero. The existing unwind label covers
the first iteration, where its loop body does not run because nothing has
been allocated yet.

Fixes: b99f8e4d7bcd ("IB/srpt: convert to the generic RDMA READ/WRITE API")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 40d796840befc..dfcecbe3a47c7 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -979,6 +979,12 @@ static int srpt_alloc_rw_ctxs(struct srpt_send_ioctx *ioctx,
 		u32 size = be32_to_cpu(db->len);
 		u32 rkey = be32_to_cpu(db->key);
 
+		if (size == 0) {
+			pr_err("received SRP_CMD buffer descriptor with zero length\n");
+			ret = -EINVAL;
+			goto unwind;
+		}
+
 		ret = target_alloc_sgl(&ctx->sg, &ctx->nents, size, false,
 				i < nbufs - 1);
 		if (ret)
-- 
2.43.0

