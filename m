Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672391;
	b=SMBkhYDBngsycT0e+trcgt4uaVATHtmqMZY3pJ5fT1Yf7f1SGY3tFKRirlfQMiFgYp1V
	 RBShND98sj+jThaDTv+sZ6ZPc+ZeSztlSq0yahHSByIpdcwZS7kqfz8DcV4RDQZ79duhj
	 EppQPBvmxnbqtO0rKEEhjnqlHCprTQgyQzsxtc1NTXr9sYBIayvybK+j9DxtlS+b42kQd
	 gh/nAVXq60WuShHaTrMisxs02DN+1MNVVHGYpc+JDEzokcuL3rhq9DOvdFKpXwsNHjZ6J
	 mHryz4KrvAkA00FJyDBYVMiDB5b0cMwD78b6dEav4SNR3T/EyVRnVkSmkO4G4iACMHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672391;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kqw9WlbZT/kZem3h7hLiB2TK8H4u+LSwhfYFZZ4FIFc=;
	b=DH/wJcHV1P3Vllnfnf5KLOTieX/qqiHDBxQK9zI2IGUg1xt9j3zhBA7tPhzkd91MXAH9
	 hJXQ5BNf/CXXKzdK38R9u6dOPmDqsZX/F3uJdA/FbgPBkWSRzMfS78gDLGuBaF4mPfiQG
	 TNpZ6OVDAHaa3vciQs8V9BomcXQSXgkR/lguHygaBf3vl0SNEbvRimWroka0zyHTIENGL
	 QMxp9gyivQrZeECzBRp8i5dcTyITyC4GtFSFNDCyyV5eLUdX83D1JQ9jAYwqfAkTau2o9
	 LwZ4DYiQ8PwKlOdsd/jX6UFogRWcQ5aLdgVn3+8OOFrMBcoW5OEY0ZLzOM+mXLi2QCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QkpwhChy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40957606A881
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QkpwhChy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EB01F000C6;
	Sat, 14 Nov 2026 16:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794672391;
	bh=kqw9WlbZT/kZem3h7hLiB2TK8H4u+LSwhfYFZZ4FIFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QkpwhChyj9cspfIJD5pds01c9ugteZDIGb4f2v8c6Q6zUcsO9cS++KoXAPJepI+cs
	 rmDbQ9qggEmQW4bpoNIxahlA+WuxFVkCyU5A7m10/dEHcE86QpvGeOYzVIgKKhl+NQ
	 Ik+Mo0XyDn74hzVGRTU/mmfwER6lua2vA0rxinwl+tUvPprO6Gn46yc1risXmffJUX
	 Xy1jkWu6DTyqRR7wi7L5Q2wdh4cF198+keuCrIaJny55Cuz7IZPb+jIL22/G2ozlga
	 zFvRFpFTfBYsZ+2eNtjiVONOng8Zl9ZwyqGXQCFjYRN0q74t3RdYlbXSBqApoXhWQZ
	 eupVmgo4GGXUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhe Liu <liuzhe1@kylinos.cn>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] blk-iocost: account flush sequence latency only once
Date: Sat, 14 Nov 2026 11:06:28 -0500
Message-ID: <20261114160621.3951063-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114160621.3951063-1-sashal@kernel.org>
References: <20261109202727-failed-5.10-e9804489e27d@kernel.org>
 <20261114160621.3951063-1-sashal@kernel.org>
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

From: Zhe Liu <liuzhe1@kylinos.cn>

[ Upstream commit e9804489e27dd6e33aec5511fe3780ff3009f57f ]

A flush sequence with a DATA phase can complete its original request
twice. Both completions invoke ioc_rqos_done(), causing the request to
contribute two latency samples and adding the same queue wait time
twice. This gives such requests disproportionate weight compared to
ordinary writes, distorting the device-wide latency and queue wait
feedback used to adjust iocost's virtual time rate.

Skip requests marked RQF_FLUSH_SEQ in ioc_rqos_done(). The flag is set
when the request enters the flush machinery and is still set when the
data phase completes; blk_flush_restore_request() clears it before the
final completion, so accounting happens only once, after the whole
sequence finishes. The remaining sample covers the request's lifetime
through any postflush, and its queue wait time is accumulated only
once.

Fixes: 7caa47151ab2e ("blkcg: implement blk-iocost")
Cc: stable@vger.kernel.org
Signed-off-by: Zhe Liu <liuzhe1@kylinos.cn>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://patch.msgid.link/20261102061802.408173-1-liuzhe1@kylinos.cn
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iocost.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index f7e6590d66d9b..e5f7f1edc3b6f 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2786,6 +2786,9 @@ static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
 	if (!ioc->enabled || !rq->alloc_time_ns || !rq->start_time_ns)
 		return;
 
+	if (unlikely(rq->rq_flags & RQF_FLUSH_SEQ))
+		return;
+
 	switch (req_op(rq)) {
 	case REQ_OP_READ:
 		pidx = QOS_RLAT;
-- 
2.53.0

