Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672390;
	b=bWlVo/dR7eP9y7Lha+NavR43BBY1Mw+a+yyUW28PP3yx0El5xG9IpSmXFie5n0hT/qxp
	 3Zo3rezu1O/ZtTEqfqBw1BiKEkVrUC7owaHkf98wFiXYL/+pcOFvfP6EM4XL8dhppdlvs
	 Qngvz6NG4bxETI00QgQBOJWe3h2S3pIxf8VwM9tnZ61y8ym1dvaQEo9LhtAtY8syLE/kP
	 /epqCzrz/er9dVeyYXEhDQPQmp42YY/s3zwIRxaZFMXt/EwlAsxkaCf9LPxOhVgfsLEH/
	 lGbJnDywH+2zf+upIDNkPY4vQKhyOaYmuBhQ0bM0OtC5PIaUHtjk1LuOJEvZecwqiFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672390;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uYmRpK7KjdNVDD0j5IQrGsHGG2wwu4FNkYGG5KRf8Gg=;
	b=bYI7Y8/EBnIu8KhXOAV6VbTdfkWh+eGIv2nE3mIVqjQVsrbm192ok9qxOO+pKA7Lb03J
	 EdMONlxVa3XHg8Hd+gmEUUiMb8MyXMuLU/ODxVlDaSkM9yPuSmt1mdKDiqG8maC2Rmo1j
	 GEQW7n4t9gea/mfMPHhuRzxgk9V/X5u0nIDGONwFitmefPVyo16Kkvt+eBUOUyLetw7hV
	 y2xvoXr+XiYaTPtVblwl1IzkWNdPDaVgEg+JFvYWoObWJxqIyxbq6f9VEdkNWunUI0mVG
	 br8T0zXZYgf4seXwXy8JX8q3Zj4tevO+TsG16KJ1cxwI2e578XMT1X+noczIR/OGg4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOdJYpbd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A59606A337
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOdJYpbd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911311F000C7;
	Sat, 14 Nov 2026 16:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794672390;
	bh=uYmRpK7KjdNVDD0j5IQrGsHGG2wwu4FNkYGG5KRf8Gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IOdJYpbdr8LRpfEXC840LdtijV07Ew30DlPov6lQIWIiC43fAyVtBO4JQnbCTzxlt
	 OVNGrfApQMt/avdx3RsffXUuGqTy7C5cGEIRIOGLhM73GrHinRmDMNgeKlTq2dwYfL
	 duwLtSsoFWdBE4zzT4l+XjI6EhoaW62ZJSrAPLKQ5q8HLNr44uvWKQcrm2UxXxsTof
	 xJAJKtaIwYqXx6ScKnwasCAMH7KR45XVNBmIC7xg3hMsMOMTN9p1bUTJvVA5H35iJ8
	 iDKw6NUn1JU2kix55J/GCYzA1FEZUJ2NgGbld2GqwRigZrAhNq/kIhnZkNTwoeiX0W
	 aoTnyiCsGcVrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] blk-iocost: Simplify ioc_rqos_done()
Date: Sat, 14 Nov 2026 11:06:27 -0500
Message-ID: <20261114160621.3951063-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202727-failed-5.10-e9804489e27d@kernel.org>
References: <20261109202727-failed-5.10-e9804489e27d@kernel.org>
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
index 46f2b01c782a3..f7e6590d66d9b 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2786,7 +2786,7 @@ static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
 	if (!ioc->enabled || !rq->alloc_time_ns || !rq->start_time_ns)
 		return;
 
-	switch (req_op(rq) & REQ_OP_MASK) {
+	switch (req_op(rq)) {
 	case REQ_OP_READ:
 		pidx = QOS_RLAT;
 		rw = READ;
-- 
2.53.0

