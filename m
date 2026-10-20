Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511927;
	b=Tjr7BmRN9iBx99YgXjo+pO2VgE29fjNwTAM+ULQP73Zy2IANQ1aM4g4CPL0woMq+aMsj
	 xAD7pZFK+r7xo/MInUsSpI/HqZ9N2GaOf1aXS7Zz0z79xtpZ+ma3c7qQx8m6Rl5mdPghy
	 J5MNqiwbUggpswrRE7xTqqFzu3ymnEjApqxxSfQEyJ7AUSeOoJk++iLcl2MJL3ZAJGAeQ
	 CMltJG8dnjXCbox9sSDhly78lZgR7bTkkrihKOGvsu98ajntdxbVTF9MdYteijUrqAnlw
	 EKzP8D7eiqBdgh8FavVGEqkjPyK8TciITVewB/hhNkPcrm5HIhZ191VkasBMXeb8lsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jwwf/y9hgPD/4iYQyhF41CmYL12LaotsH+U0E6c+Hyg=;
	b=YYB6NQgyEnt7PnYO4uJlVpwQzYJhEyTVMYK9wwoO0FlBFqU8DOGUke6IM5Ep/BZswhol
	 VmMaNFKdxgFyyLiTcNcKINqNMGUca9e77uORTspb/HI75PWxpYvGXQRIV2+8iCtd1mwUW
	 +jcENvjDXfKmtfnUPeFq5iZwBSmZCgbQZqQU4lOdQUt7z2CBdOJISNKmmpdZWbQOZTIvI
	 RM6JM25lEj9135h/MUrHsWfq3jtrgFrNU7tRslqKfZx7PWWlvoNAbJaKQSF8w3qUWHcVH
	 g6JZPkGlnf+39tcljvu+6zm6abHMdxfFGzoqIBBWESVOsK5ow5SHT51gzRbbxBUJ5DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="dWs4F/yp";
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3FD606A328
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 15:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB3FD606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=dWs4F/yp
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso2520817a91.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792511926; x=1793116726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jwwf/y9hgPD/4iYQyhF41CmYL12LaotsH+U0E6c+Hyg=;
        b=dWs4F/ypBs2AZ1xwmLiUvBHFlCmf8R90S+EjX+Fr8o++IFJHNgJROWISLM+2DVcbyS
         dpw+SVWSiqE9luRzM2CY+51yYYTnOTpHKt1WkTfQwJQfk3ulZyMsLGsU1y65jdjmEEJT
         fFBz8ibm7omXvqc9BsEdrFc+NpgTa/qI2L2fNG6JY+arBT2Lql13qc47GGK8SBEdqi5j
         m0op8io6miOsGhjy8jODfAQU07B7lBEqsNA75zzXBKy1EDbsL+ApqSgc2d7gaED3+anY
         FGwTGl2lxO2y2TcR9qnmFabtUR6T1FCoGNkLBvH/QH1p2JEYVJcTp5aMUJup9u5Big2m
         mK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792511926; x=1793116726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jwwf/y9hgPD/4iYQyhF41CmYL12LaotsH+U0E6c+Hyg=;
        b=Cm1X0YV/y2q8WOmCpDMczji/TWNAQV5emCn9QAoldI5C7nSkozEekhIdrbuUtMc9eU
         BhH6j/VapGfpZk8hGvvzUlsZyDTsKxUOKZLXAX1uBMZhylq15mOV9PGzkO1Zx03iApMT
         6JmODVI4cZ/AnpnWx63dT2J/MD4aNYFBx333idMDG/AjlXy2Mc2/O7pkpnaY507tok8j
         n1aaYSxZjthg0Z9o3Fw9/GfT9+YpKsbTEHNBv7b02WHYHdZq0ILNHxVqfOXZapGlPlyg
         LTsWtwa4vfk/g8RFdMfRpCNHjXU0PjNn+vq68uV+r7JTV7c+BeVMm80NcNbFg7YxCpcb
         yxnQ==
X-Forwarded-Encrypted: i=1; AKwUvBydktgekhEUlNeGI2ufJMGXphQGSqQik+rNkP3C8uafDkfJoUeBzUFXdeie3uqGJP470MQ23eg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrcrw28U0rgF+vYDTyMuOyRRqs/AR7XmC1gBR1eqSUwgoQgzW+
	J5gN1TEM4S7DYt1zXKpuAtqL8b3SH5TlGt51mWfQ5OdPMpVLqqFLE4+S/gqoUpXTJUQ=
X-Gm-Gg: AYBFou2/P/J67AgoT+UvoHsFavw1uUYsX4XPDd2oMmRP2tG/9KJY1u6gZp1bgq4yu9l
	MQAdtPCAKbjuK+XsU1UMeOWNYMmy4wOqHFkixefZunDBqzaLIoa6ESW2fVLgrZDGLolGSI15H5P
	y+0chMEAHttPa64W1lGS4Bov5pUNoB2HqeKwFWo5LITnI5X4ZDnLrUMfIO4mFHFV5NpqqJJQ48h
	tk2cWvtC3DMnLZfyQF89S6SJXcyebenHDGrYNOH4TAMKxBTJhtdnaKJUiopUVacPQ/GTPNkc0Wa
	GAXeW/MkH7i0fL5TmUOMuHLa75begrPC36j1i7wyIvIPxft6/XyXQzISM3vMzre6u33fDIbwCrj
	kzenp8I29NbZJ8yQAdtjO5XLw4YFvJeIoWvEsbpkYAUcEyEh9TYUH6iyG4iEwY3vZxPSAAj1QgB
	WU3/6cdzHKWFxGv+3scVMR+u/uLzOGbKdLIlALKYffUQzJkkM6Hl1Sugbfn43ufoat4Y9rfAMyZ
	0xb1fhFaO3E/+l5tjdm
X-Received: by 2002:a17:90b:5743:b0:3a8:cc4f:3475 with SMTP id 98e67ed59e1d1-3acef60db08mr10119028a91.60.1792511925477;
        Tue, 20 Oct 2026 08:58:45 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:e416:85ef:f22:6c5d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813de463sm41188a91.13.2026.10.20.08.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:58:45 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH] RDMA/srpt: widen the RDMA context counters
Date: Wed, 21 Oct 2026 00:57:25 +0900
Message-ID: <20261020155725.2251969-1-yhlee@isslab.korea.ac.kr>
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

srpt_alloc_rw_ctxs() then builds that many contexts but counts them in
ioctx->n_rw_ctx and ioctx->n_rdma, which are u8.  At 256 descriptors
n_rw_ctx wraps to zero, and srpt_release_cmd() frees the contexts only
when it is nonzero:

	if (ioctx->n_rw_ctx) {
		srpt_free_rw_ctxs(ch, ioctx);
		ioctx->n_rw_ctx = 0;
	}

A command carrying 256 descriptors therefore leaks every scatterlist
target_alloc_sgl() allocated, every registration rdma_rw_ctx_init() set
up, and the rw_ctxs array as well, since the kfree() for it sits inside
srpt_free_rw_ctxs().  ioctx is a ring entry that the next command on the
same tag overwrites, so the array pointer is lost too.  The descriptor
payload sizes are the initiator's to choose and the command can be
repeated, so this grows without bound.  A count between 257 and 510 leaks
256 contexts and frees the remainder.

Widen both counters so they hold what the guard already admits, rather
than refusing counts the guard accepts.  int suits every existing user:
the two loops that walk the contexts backwards use an int index and stop
at -1, the sq_wr_avail accounting passes the value to atomic_add() and
atomic_sub_return(), which take an int, and the three places that print it
use %d.  The WARN_ON(ioctx->n_rdma <= 0) in srpt_rdma_read_done() becomes
a real signed test instead of a test for zero.  The error unwind path
walks by index and restores both counters, so it was never affected.

There is no splat to quote, because the result is a leak rather than an
access past an object.  A KUnit harness that is not part of this patch
calls srpt_get_desc_tbl() with a fabricated SRP_CMD and counts the
rdma_rw_ctx_init() and rdma_rw_ctx_destroy() calls.  With u8 counters, 256
descriptors build 256 contexts and destroy none, and 510 build 510 and
destroy 254.  With int counters, 1, 128, 255, 256 and 510 descriptors all
build and destroy the same number.

Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 7197d95f2216b..b174d58ca98a3 100644
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

