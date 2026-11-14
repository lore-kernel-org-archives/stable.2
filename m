Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672076;
	b=3c+D2JjqjAZ5zsciAoDBz/Ekp3UGrW6zD40F9lv/qkaFp0PfLwZDHbSb6vQzLsT7vtom
	 V/g/dB9p14L5yXs5takP1LvkIm45JYmRU9mn0SHJD8huayrMEUVWj0mTQVSWPeYIIpPxd
	 cLyYfqCAqfVjKprCwTH2pe27NeSE0sX6Rf7up1uuEFZtvroWSs6KccEqBj6jRZxV/szOn
	 zxE0MzSe6OwDreDGqKlLpXIlsboVo+JmcaCpnVBjKaql4kgGdRLccH/773Qqim+Okalck
	 aic0/ys3B/ov0Ghq4Q91tGMkTd1fFxkLsWLhkOCQIWSXfJTCk1vLXHCA3FJ7SKooASQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672076;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=duAlRsjjXx0lR1tSM/FF0S/nv4vTi1hLuTLABcQsp5Y=;
	b=wCvSALqu4hGgovYvd0Q7yvyhLjizphWLHtWI9Eq3FuOqSYW82OEFC9bnrV+5TyuxLLpS
	 hF6O2lLO2ZnO5L/Kw/jt0VJhXdRMxtqmuZN48QeTFP+idROxWR3O7OS6VyQYN6jqQdEsy
	 +NJhcc12k58ysTkbQfAmWg/bNUBAJyEN9Q5sQCLVt0CCHcChhq2PegAalToA+OH8Y+qWd
	 wHycPBT/hbyDcga2RDhHFMz3Lg3GliQfmChAvhI85ZoQFkV8ulgwQ1YUJhNDlqADb+f94
	 CX8gpzWLG+to7omkkvwidmJTpQaq/a/MC7aKDYq6jxjhVWHlzZ0VOFm8FIV5M+GnJCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZDeSaFe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5110F606A330
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZDeSaFe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A14C1F000C6;
	Sat, 14 Nov 2026 16:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794672075;
	bh=duAlRsjjXx0lR1tSM/FF0S/nv4vTi1hLuTLABcQsp5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GZDeSaFer0sAyJKwaLgUWCsb30fRyMDKYClx6MJhDcOqH/V/r15WbnR6ZNJ507PbT
	 /No7aw8WzFdBo/tHJHzkwsVK7fI6uTyU2ooVD91u+dSvyWLtij+UrbOXS1ncZ71w5I
	 e5Hp7+/BM+v3+UI8qFQ8KbcwTOLHqGZ+HgiylNBp+3bNjA340boobIH6usd3yPde/C
	 p80o8AQW4DNOo3RmZLumpI57BDQBmdIPUFAQXV1oB7DpEhvIaWZaADzhMEjgPcy7SW
	 o2yG9eAN79ixe0ZcTg04kvxJRYzliBb9x0vjIMCil4yW9bEh3unQVxDps1CWHP6nUL
	 4ixmvBrlYBChQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhe Liu <liuzhe1@kylinos.cn>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] blk-iocost: account flush sequence latency only once
Date: Sat, 14 Nov 2026 11:01:13 -0500
Message-ID: <20261114160106.3688025-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114160106.3688025-1-sashal@kernel.org>
References: <20261109202255-failed-5.15-e9804489e27d@kernel.org>
 <20261114160106.3688025-1-sashal@kernel.org>
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
index 2c3047d2c80e1..eb19e92e8e5bc 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2808,6 +2808,9 @@ static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
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

