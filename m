Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436696;
	b=oc6xifp4hEOmxqBMvYa5oyEheG4G+0qBxmhQlFRBuPdrhZg5SuqVpNV3UF8HQ+2GyHJi
	 znuL5nz4SGjgOyfdhYPyDbbtti7KpTCUz/h4VDZ4ym3ScOET1Tn5OhphRY1/YhbSnLXqT
	 HmV5g8aG42OldDwpgqvWDP2jYjdU/aFVjsjfzZnYKvgCCFPASNpzQ4EjZbnXmBzVSaoMI
	 XzWWxxZW9R7XYLxpe2Y0+BQHvrjNSXgbnmqwhtxgr0cogCGqUkv1oKhbPgaMjCHY60GCB
	 VsV1T0WxQ1J6KLTI0qJUK2GUxty4Z7uZX35wcAc0XZNg5w2rAj5p/DoBMUYvVCbZEcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436696;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TzjA7FEJ6AK4VsXgmMrNAnjURDe60nFgREEtKzKcqlo=;
	b=clExGa9RTDvQ1ePl+8hraZB8DalBO7n/etnyVR4J1MYHXVQfJxAt2n1gs0RoqH1IhPp6
	 Rj4gJUsCVO95DQ7zpw9nk4lA++8/UgBvkaqCJYtNBgkv5sQOJxulbKHEeeZKb/apYWO1A
	 DchT2bPCkRSHGC5zIoWls9SE2qOuWM+hG+TzDTV2qcOc9h/BP9dYD8qe7m4UX1Mbawkdg
	 IJWv4n5Yzd85numipPMfpAEgb6A2b2JpVYbO+8q6F4md0xe4FdEwJW8BJ1XrebRJJpfZx
	 L2ote2ifJmTDVfGayXacYCdoLm3rkZ1jor7KPkOMAoFxpTwoO697SJkg8PEow/JRMXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cb7dwXUW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B1A606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cb7dwXUW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0F31F00A05;
	Wed, 11 Nov 2026 22:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436696;
	bh=TzjA7FEJ6AK4VsXgmMrNAnjURDe60nFgREEtKzKcqlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cb7dwXUWkMafd8uhpuXts+cgtqYDNwX0BfUlVvRB9vl8yLIvknTrp6EAWQGnzduKV
	 XXX9e5GcHtL5vihSa9XUovZPMCetOJWgyVfBiJZQEX1Cm6sKZsQ0Wc+nPjd2WPCaIq
	 p8s7b/5o1SAmerv7jHtFJK8Y0jf+lhhvoeWJEFAwp7HXXJABgA+in8e9oVfGLbcca8
	 YzTJdTZhQrVFIDFTuTKcPHd9zRZ5hi0wiG3TrgBPPP9O6FJVOm2OMNiSfKhpqE8uqg
	 tbhJ+SvUNWSbJIjtn3/D9yirST3qTSApq3E4UEnAdRIcJlVl74mn+1rcS9AjTtxtjR
	 lGL+Wwg7CIQYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cheng Yongkang <teel4res@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] io_uring/timeout: count cancelled timeouts in cq_timeouts
Date: Wed, 11 Nov 2026 17:38:14 -0500
Message-ID: <20261111223722.4155435-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107063043-failed-5.10-1c8b49851543@kernel.org>
References: <20261107063043-failed-5.10-1c8b49851543@kernel.org>
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
[ sashal: placed the cq_timeouts increment after the existing IS_ERR(req) early return in io_timeout_cancel() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index e2e04a381315f..4926dd03e3fd8 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -6117,6 +6117,8 @@ static int io_timeout_cancel(struct io_ring_ctx *ctx, __u64 user_data)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
+	atomic_set(&ctx->cq_timeouts,
+		   atomic_read(&ctx->cq_timeouts) + 1);
 	req_set_fail(req);
 	io_fill_cqe_req(req, -ECANCELED, 0);
 	io_put_req_deferred(req);
-- 
2.53.0

