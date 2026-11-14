Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672075;
	b=Txmek3DvCu8qcfpFPVzAblZRE3SI31wZWe9tWlUfXIkcl35t5RFKRZ/kVQAeVE3qYBvo
	 Cg+jIkUsF8Ukl/ev45jrNIEYqMY8OclswB10/6Ync+s7k84Gh4b0ZJqyjMosUrZ/DNdpE
	 sX8S19FpGNOW0nbdZUMTQIMyiWKJHZojXMS3wyvHHYRdfQWf+UyZJZrA0NHQla4iowLes
	 Y0y4XsVBlIueBxPVE7huevYfCwB6Y5oVKFK+FZlRUce2lVKkjUYNDXtUfCzVTlO2ceUBD
	 RIrRXeflbBUXmeoBUHzAKcZXKxb8e3W2DSYJ90VN7QV6wWMfLKbl6N0TCgaj5RPNiQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672075;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T0msHvgWsP1vhn1q0HB4qRit7l16jXCR3LUZjmqSxrY=;
	b=ANLoIHZCL0CCmaWVc5EcFAByAKyia9SkmBXgXbtSNmXLEjHXlBm/++GcSLXHQieehhot
	 SWyp0V2Ra/+hGCVUq823Zy4q7eGmqkcJ9AkmluSFJ7fQAATht7tOForWGkLtGwqxGbM2P
	 2zUM3NqT0IouHqK1yuDhe/fC/8YehgRh21f5kmowxRq614KxfZ9ztZV6qM6YGD/CDyNbQ
	 nsJ1Exf5HKvGsvUBxz94jbG75J870DKOsLNQm3m93YXdFcvEPuy/bTBLiCjRxjVgjoR51
	 gActdTUy9V3/2swdcnGIxKYIHa72u+VfhKWrlSDEX6YTpGlRMlBmgS8OgIeFFgGnQqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCH0UDmL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A569606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCH0UDmL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566721F000C4;
	Sat, 14 Nov 2026 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794672075;
	bh=T0msHvgWsP1vhn1q0HB4qRit7l16jXCR3LUZjmqSxrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HCH0UDmLzIDr9eTln1o87gHBrBkFTI1zJ3mOC0yYtgVPRYbuVcv3AewfrOd8msTuU
	 nonOCG0KhQt9DdfAOS2O9xm+NIiCp4+h0u+y+Y/ZX5Muarup6y8V3Wfd/JYY98nDHo
	 DeLXAnSxjJLSd6MGQOBfgjbVFoNmuvJRdCHxqyVNoAynwWoVmIFe/wHNsrrIhLhkrw
	 1jhOO47AH8hpL9VObEK8kdE/z3oBPXAFqEiZKmet29aKHHOMWqnI/YWztL33Jl3HgU
	 G3IOKTJoSWOAXifML5q+5w4CskpcJsYkTvgg70z9u9BYeTLNsqm1gF84wfGps2mePE
	 mqd09jUenqszA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] blk-iocost: Simplify ioc_rqos_done()
Date: Sat, 14 Nov 2026 11:01:12 -0500
Message-ID: <20261114160106.3688025-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202255-failed-5.15-e9804489e27d@kernel.org>
References: <20261109202255-failed-5.15-e9804489e27d@kernel.org>
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

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 62c159a03da92121b1b909fd8039028de97885fc ]

Leave out the superfluous "& REQ_OP_MASK" code. The definition of req_op()
shows that that code is superfluous:

 #define req_op(req) ((req)->cmd_flags & REQ_OP_MASK)

Compile-tested only.

Cc: Tejun Heo <tj@kernel.org>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20220615225549.1054905-2-bvanassche@acm.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: e9804489e27d ("blk-iocost: account flush sequence latency only once")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iocost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 496aa2d4c435a..2c3047d2c80e1 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2808,7 +2808,7 @@ static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
 	if (!ioc->enabled || !rq->alloc_time_ns || !rq->start_time_ns)
 		return;
 
-	switch (req_op(rq) & REQ_OP_MASK) {
+	switch (req_op(rq)) {
 	case REQ_OP_READ:
 		pidx = QOS_RLAT;
 		rw = READ;
-- 
2.53.0

