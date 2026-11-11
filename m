Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435112;
	b=xhyLMhhQJ3Ot3SCvemw0pDQ8UTt2EN4vDMsmm308oLdMqzExTISWXD7CPXg1Z2hlyQ7Q
	 dXf10nVPTkOfqp/iIJfp0waopCKj4M5fb3KaApd9bjKOu/c1pppoklo880o8GKAuTYyQX
	 s6sBxe/XejbuAw/gw3dS/qkfd2L+vgFNUsZyclYc4Hn/tCdFQ1VOsZhIdDHuxuzoN5yr1
	 EfsKL8iesdP1Sp2IirVyttM2uoN7fgxoZ3sgFar6T0bwBo0u8J0ouHvlgxG1EC+NLL0AP
	 SVnquNL9Vy/lQIRh3GD/cq16D41qixX7/u/TINr8XgfqAagaEVoPAG7G477omwEiKZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435112;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SFLxCVPzU77PpcTj5VZDW+Jy//Iojik3YCkmaLQXxQg=;
	b=q/UJPD5GJ6t5QZfakBZhkZ9oRrioqcvGy/zGTe8CzYQf9wUgtnFy3XpSh1KEkVoQjWt7
	 5NNlOwmvROCxxDUvewfEkrWhPzBfNjqw1wRpYlNwMaF/E/uvo9wyrXaGqYCij9BTUZW0M
	 91CtLLOa4ADFRlDRu8/1Erls1+lX+ujcOim8DiJRkvPThhtjFntjMEyiSNDXvVLIzR5Ov
	 wXxFAaEYIDb3FmJCWIppSIdejGr+m21mWnCNO+xF2+juj419NOmwGqISWpDXXfUuOnD+C
	 CU9pDHBfnZZXEGkGiVrq0GX2vMvRps0HyhMlV2kODURGVGEu8Ke0xUuSNqjPNCG3c2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W/nG+Wjl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47F2606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W/nG+Wjl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE34E1F00A05;
	Wed, 11 Nov 2026 22:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794435112;
	bh=SFLxCVPzU77PpcTj5VZDW+Jy//Iojik3YCkmaLQXxQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W/nG+WjlnsNt3euFRjPjMVtq1+QXkzSV+D0fUYHEmD2ijVT5e8VvZQHcoxob+czU1
	 dRRq7IMRMa302IA6pZW5iW8BxVKz52O0jTDgGsLBpjznXjhxViiqc4nvkBSlaEQWOC
	 Q4lmZOE5kMZomsS5KECf+KiPXh6fUe2aSir0gesmIhK3EwcfuvXHvdW6NlTGrAzowZ
	 L2dRQH4ILS4+zHHgvJZFp5738ir1mNZCeibNX7xVTmg+k/LRTjdnPYuqansBKVFvSH
	 4BUrUjgv+iEkWnJq0MfHU+q2GD2QKmkFY75Ij2J+q0HMCRwTY3Xj8RPJO6XBBsYxhQ
	 KOhbRBd3EFO/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cheng Yongkang <teel4res@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] io_uring/timeout: count cancelled timeouts in cq_timeouts
Date: Wed, 11 Nov 2026 17:11:50 -0500
Message-ID: <20261111215310.4031051-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061338-failed-5.15-1c8b49851543@kernel.org>
References: <20261107061338-failed-5.15-1c8b49851543@kernel.org>
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

From: Cheng Yongkang <teel4res@gmail.com>

[ Upstream commit 1c8b49851543f41fc8bb18bcd1f15cc93d14b530 ]

io_timeout_cancel() posts the cancelled timeout's -ECANCELED CQE without
advancing ctx->cq_timeouts.  io_timeout_fn() and io_kill_timeout()
advance it for every timeout CQE they post, and io_flush_timeouts()
computes the number of non-timeout completions as

    seq = cached_cq_tail - cq_timeouts

to compare against each off timeout's target_seq.  The cancelled
timeout's CQE is therefore counted as a regular completion, so every
cancellation makes an already armed off timeout fire one completion
early.

A ring with a keep-alive timeout of off=4 completes it after two NOPs
when one off=100 victim is cancelled through IORING_OP_ASYNC_CANCEL, and
before any NOP when two victims are cancelled.  The cancel CQE should
count, but the cancelled timeouts' -ECANCELED CQEs must not: the
expected counts are three and two NOPs respectively.

Advance cq_timeouts when io_timeout_extract() succeeds, under
timeout_lock and before the -ECANCELED completion is queued, matching
io_timeout_fn() and io_kill_timeout().  The -ENOENT and -EALREADY paths
post no new timeout CQE and keep their accounting.  Both the
ASYNC_CANCEL and the TIMEOUT_REMOVE path go through io_timeout_cancel().

Fixes: bfe68a221905 ("io_uring: off timeouts based only on completions")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
Link: https://patch.msgid.link/179328314078.648427.13761781546953594668@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ sashal: Placed the cq_timeouts increment after the existing error return instead of adding an explicit success conditional. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index a87b24c77c0ee..f0b55c6e2d2fb 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -6264,6 +6264,8 @@ static int io_timeout_cancel(struct io_ring_ctx *ctx, __u64 user_data)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
+	atomic_set(&ctx->cq_timeouts,
+		   atomic_read(&ctx->cq_timeouts) + 1);
 	req_set_fail(req);
 	io_fill_cqe_req(req, -ECANCELED, 0);
 	io_put_req_deferred(req);
-- 
2.53.0

