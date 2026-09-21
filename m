Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7413D8902
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026009; cv=none; b=lF63m342OJDz/i35RBcRwzvY2SAf8BKpnrX9IxmjJ1eCGD1lf90r4FOsr3ddW827CUaaApCX3hjQXFn/8mtWsA7KK1yPmFue/t1AD2WTQZJ/dRjYRTMvBjPiGj5kd5KFmzzWFWIJ2J0raPwTotqYrAI5HLBlvsWuxija69At9/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026009; c=relaxed/simple;
	bh=E2UnhwWUr86vvlerZRoiXd6Z2CE3q05PX6HoBxgj/0M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MJ+KrwhiKmzWjPFGxW71AmdJp8Eg2zk1F8k6hgHr221kigtmWi4gC1AwHNa6039yiQxpmonNz/HN1CrujAm9EbdL2QxBh+5Xv5QgcB4Cb3qfFbi+RFoTT96qEwfh1olWg/hTk5huNvprOgYz1kP4Fn50kS9AtQ+n1Sv5Co8slXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=braoesk/; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="braoesk/"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LKfAOD1551280
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:26:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=mo+EzH/c1
	Ee/cD5mChapw0UJJ7KnqCzomO17w+xEUs8=; b=braoesk/lnAoEO1jvxu4eBj7r
	xegLP0311fpz11ejKf3tAp8d6ULqL8FZwaPh94aXD4OUZhOtzrnLG7dcdIvQNize
	hcb5/ixnq8GIM0yWK8gw1U3TW2l/PC5rxor1zfjOYWOCp0cxFSkMnCcx8ORHL+z0
	1Y7ic9KU9jmjSgSxwPeqynp59lpb6uPxwuAKgKIvIHT3LgULcC+GNR4On24XYAxk
	uKVcBzKto3lSFYA7iq+jTTclm8uTyKtTibjBHeucLkx8tOZMP/0jWKYbIpr8aekR
	pgAu7jxEoJeFc1iNWuicj3eBpiF61Z3lxQLdSTNeyDwNnjcekG6mX4B7T4xfg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gsr4c7h3x-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:26:46 -0700 (PDT)
Received: from twshared103475.15.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Mon, 21 Sep 2026 21:26:44 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 66FD32C33717A; Mon, 21 Sep 2026 14:26:32 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: Keith Busch <kbusch@kernel.org>, <stable@vger.kernel.org>,
        Henry Hu
	<huhai@kylinos.cn>
Subject: [PATCH] blk-mq: set RQF_USE_SCHED when the operation is known
Date: Mon, 21 Sep 2026 14:26:24 -0700
Message-ID: <20260921212624.1942234-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dPVoThbDdq5iyt8WAzqIt31GP9E1rJVO
X-Authority-Analysis: v=2.4 cv=SKnXx+vH c=1 sm=1 tr=0 ts=6ab1a116 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=VwQbUJbxAAAA:8 a=pVJO5A81n4mMywtpseEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDMxMyBTYWx0ZWRfXznBIGJa7QPCP
 TY5WkedapeFTE+HuYIp1hGKJUd3M4Fs8aQMis9i505C/+3GeJhjuwQfcMn/k2yNuhm5pRopt+A4
 /7dj48udyb5qdtww5Zb9bhmxxfURTUI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDMxMyBTYWx0ZWRfX0a69FfAnmWt8
 7FAXU/5bbSvInblaZ759IphMsirt9XYCa4UyYh2rnpdNAH5A0IOPl97l6vhVqK6rt1BSGNml+al
 g1VSC2W42u36tppE4+Gz99hUAEUfhNu1mSqycpmSB7QAyBi7vbLwnSQLPCvSUocHsRZUSXAuirD
 ST234pwQGqAEeY0bl8rjV7wFqi+VsRiymROV90ez4NQpQ442KSQE72DaXnGXYcD3vHp6QO3A/It
 idOIMtOfN2a5pgdWdTeCjjRhLv8pdgzy69OWkTd2E5DaZJsXUnhpyScYiXWBDoGxR/LEp5ueZ9W
 DiAyDf3D02VBF79zZQerssnSxebUtGSjz+fotI14iOrjggcWee55zUMfJr8OZEU71g3Gsi7oJZV
 WwRJFibytTb5g1cxtxmDHtDH/VsRTRvQiy78T6T2/Ox7ZRBbdKy4a7Ng6HOlnUm9P3XrZGy5n80
 qq/zaDO+THHNrwEhpTw==
X-Proofpoint-GUID: dPVoThbDdq5iyt8WAzqIt31GP9E1rJVO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_06,2026-09-21_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

The cached requests are allocated for one operation but can be handed
out for another. A passthrough command has RQF_USE_SCHED cleared, so
using those flags for a subsequent read/write bio will insert it into
the scheduler without ->prepare_request() and frees it without
->finish_request(). For kyber, this leaks the domain token acquired at
dispatch and stalls the queue.

Don't set RQF_USE_SCHED based on the first operation the batch happened
to be allocated for. Instead, set it after the request is claimed by an
operation.

Fixes: 4b6a5d9cea91 ("block: enable batched allocation for blk_mq_alloc_r=
equest()")
Cc: stable@vger.kernel.org
Reported-by: Henry Hu <huhai@kylinos.cn>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c | 51 +++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a26a11c73ee3e..b1e1b9dea3c0f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -447,16 +447,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk=
_mq_alloc_data *data,
 	WRITE_ONCE(rq->deadline, 0);
 	req_ref_set(rq, 1);
=20
-	if (rq->rq_flags & RQF_USE_SCHED) {
-		struct elevator_queue *e =3D data->q->elevator;
-
-		INIT_HLIST_NODE(&rq->hash);
-		RB_CLEAR_NODE(&rq->rb_node);
-
-		if (e->type->ops.prepare_request)
-			e->type->ops.prepare_request(rq);
-	}
-
 	return rq;
 }
=20
@@ -498,6 +488,12 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_da=
ta *data)
 	return rq_list_pop(data->cached_rqs);
 }
=20
+static bool blk_op_bypass_sched(blk_opf_t opf)
+{
+	return (opf & REQ_OP_MASK) =3D=3D REQ_OP_FLUSH ||
+	       blk_op_is_passthrough(opf);
+}
+
 static void blk_mq_limit_depth(struct blk_mq_alloc_data *data)
 {
 	struct elevator_mq_ops *ops;
@@ -518,12 +514,10 @@ static void blk_mq_limit_depth(struct blk_mq_alloc_=
data *data)
 	 * Flush/passthrough requests are special and go directly to the
 	 * dispatch list, they are not subject to the async_depth limit.
 	 */
-	if ((data->cmd_flags & REQ_OP_MASK) =3D=3D REQ_OP_FLUSH ||
-	    blk_op_is_passthrough(data->cmd_flags))
+	if (blk_op_bypass_sched(data->cmd_flags))
 		return;
=20
 	WARN_ON_ONCE(data->flags & BLK_MQ_REQ_RESERVED);
-	data->rq_flags |=3D RQF_USE_SCHED;
=20
 	/*
 	 * By default, sync requests have no limit, and async requests are
@@ -534,6 +528,23 @@ static void blk_mq_limit_depth(struct blk_mq_alloc_d=
ata *data)
 		ops->limit_depth(data->cmd_flags, data);
 }
=20
+static void blk_mq_set_rq_sched(struct request *rq)
+{
+	struct elevator_queue *e;
+
+	if (!(rq->rq_flags & RQF_SCHED_TAGS) ||
+	    blk_op_bypass_sched(rq->cmd_flags))
+		return;
+
+	rq->rq_flags |=3D RQF_USE_SCHED;
+	INIT_HLIST_NODE(&rq->hash);
+	RB_CLEAR_NODE(&rq->rb_node);
+
+	e =3D rq->q->elevator;
+	if (e->type->ops.prepare_request)
+		e->type->ops.prepare_request(rq);
+}
+
 static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data =
*data)
 {
 	struct request_queue *q =3D data->q;
@@ -563,6 +574,7 @@ static struct request *__blk_mq_alloc_requests(struct=
 blk_mq_alloc_data *data)
 		rq =3D __blk_mq_alloc_requests_batch(data);
 		if (rq) {
 			blk_mq_rq_time_init(rq, alloc_time_ns);
+			blk_mq_set_rq_sched(rq);
 			return rq;
 		}
 		data->nr_tags =3D 1;
@@ -591,6 +603,7 @@ static struct request *__blk_mq_alloc_requests(struct=
 blk_mq_alloc_data *data)
 		blk_mq_inc_active_requests(data->hctx);
 	rq =3D blk_mq_rq_ctx_init(data, blk_mq_tags_from_data(data), tag);
 	blk_mq_rq_time_init(rq, alloc_time_ns);
+	blk_mq_set_rq_sched(rq);
 	return rq;
 }
=20
@@ -637,8 +650,6 @@ static struct request *blk_mq_alloc_cached_request(st=
ruct request_queue *q,
 		if (plug->nr_ios =3D=3D 1)
 			return NULL;
 		rq =3D blk_mq_rq_cache_fill(q, plug, opf, flags);
-		if (!rq)
-			return NULL;
 	} else {
 		rq =3D rq_list_peek(&plug->cached_rqs);
 		if (!rq || rq->q !=3D q)
@@ -646,15 +657,14 @@ static struct request *blk_mq_alloc_cached_request(=
struct request_queue *q,
=20
 		if (blk_mq_get_hctx_type(opf) !=3D rq->mq_hctx->type)
 			return NULL;
-		if (op_is_flush(rq->cmd_flags) !=3D op_is_flush(opf))
-			return NULL;
=20
 		rq_list_pop(&plug->cached_rqs);
 		blk_mq_rq_time_init(rq, blk_time_get_ns());
+		rq->cmd_flags =3D opf;
+		INIT_LIST_HEAD(&rq->queuelist);
+		blk_mq_set_rq_sched(rq);
 	}
=20
-	rq->cmd_flags =3D opf;
-	INIT_LIST_HEAD(&rq->queuelist);
 	return rq;
 }
=20
@@ -3060,8 +3070,6 @@ static struct request *blk_mq_get_cached_request(st=
ruct blk_plug *plug,
 	if (type !=3D rq->mq_hctx->type &&
 	    (type !=3D HCTX_TYPE_READ || rq->mq_hctx->type !=3D HCTX_TYPE_DEFAU=
LT))
 		return NULL;
-	if (op_is_flush(rq->cmd_flags) !=3D op_is_flush(opf))
-		return NULL;
 	rq_list_pop(&plug->cached_rqs);
 	return rq;
 }
@@ -3166,6 +3174,7 @@ void blk_mq_submit_bio(struct bio *bio)
 		blk_mq_rq_time_init(rq, blk_time_get_ns());
 		rq->cmd_flags =3D bio->bi_opf;
 		INIT_LIST_HEAD(&rq->queuelist);
+		blk_mq_set_rq_sched(rq);
 	} else {
 		rq =3D blk_mq_get_new_requests(q, plug, bio);
 		if (unlikely(!rq)) {
--=20
2.52.0

