Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050020;
	b=pDVb7W3ePdJ5gPmPZ+8hsxu6UdtwY9lDxRbgdZermCBi6ZGKlDa2AZZo5hU4KZn+giLz
	 5+oeFbyYM+Y+cbaHsgso0XdeQiCdg7DqF+6sHlIWuqLwklnxeB36GHRlMfZOdckisjpko
	 HZqVeUFSDfQAZ9dKzd0+Qu8vqYydV1IxWaAiHcvw0+T3CBkTHKO0GP3j/1NDncx1DKmwD
	 6SlTLyF6KSadS5a6mDJSQZEyCU9uq4YyLY4AMHk2cMRioHo9DBCE4FpW7EF7t3VHlMRy2
	 mLd0lqMHxlNX6CeJnLduftElRgvg5nrdRZMsIVIqbhOvABofP7Bl7oSvrbbZiAogZCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050020;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pS5hoadL2tQl2pY8TXBIn4CFyNpEIa7sIOUI3JpMov4=;
	b=ia3xPcUI9V1dDXqqlrQg0Oo9grIROOJCfPPC2TO8hwonQqYVXaOcmMPnWf4/DbzpeI+d
	 WtmdH2SCJm0vSgPrW8XONzoJTpHZkdmk1BPFYTgaJlGASUBn0TJfDT8fYpcfEj8irYtjz
	 wdv3Wdx0/A1m9+nJX/M/q6Mk8Dh2GJd3s9WsCGfgGtE29m0wf5DeQQxa+gdZgdYn6S3qh
	 kWspWt+PicbEPBZdeQJW0CPVwVLrfveSAvSssOJoZr43SOLJQwjSgPXdzrv8X5WvJh7WC
	 gKL7hYsoilRUbYWe13vkxB/wYK/+sk8HsMxmG4KrBZB/9jTkor4kzW2nUhUEXkoGGjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtnVEvRx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0043B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtnVEvRx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705601F0089F;
	Sat,  7 Nov 2026 11:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050019;
	bh=pS5hoadL2tQl2pY8TXBIn4CFyNpEIa7sIOUI3JpMov4=;
	h=From:To:Cc:Subject:Date;
	b=LtnVEvRxNPx+1CTHgkM89UtIu5y3hwj2Jj7O1h4rvzROQdhL8E54bQgkVw+PXaDnP
	 IdAKkOD+kzEn5hxXSTlPGDwIW3m4t33Nhnk6PTX3oX8JOavzxuJDjVkwaE3HtZDQ2e
	 9dFp0LWmIcecdYGuy6PDYwisEtvEaOX+oarSQJHkFPv01/ZappsvE/Q8cUgn3tDxSX
	 oBFgYMlF34Iy/ITkBEMHRtbaaWEhrVgCBujDBGhyX1M6RJS1BKztql4Ogyxm3T+2qd
	 8TCXiss2c+fSGiDDlFKHhHcZWkfQbA9KDeZpyitJyaDnhBKztDTuGcpi9K8F+Diqn8
	 zstephzq/ZAPQ==
From: Sasha Levin <sashal@kernel.org>
To: teel4res@gmail.com,
	axboe@kernel.dk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] io_uring/timeout: count cancelled timeouts in cq_timeouts" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:13:38 -0500
Message-ID: <20261107061338-failed-5.15-1c8b49851543@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1c8b49851543f41fc8bb18bcd1f15cc93d14b530
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061338-failed-5.15-1c8b49851543@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1c8b49851543f41fc8bb18bcd1f15cc93d14b530 Mon Sep 17 00:00:00 2001
From: Cheng Yongkang <teel4res@gmail.com>
Date: Thu, 29 Oct 2026 07:12:20 -0700
Subject: [PATCH] io_uring/timeout: count cancelled timeouts in cq_timeouts

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
---
 io_uring/timeout.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index 8a2108aa14ae7..fa7b0d9a81d69 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -370,6 +370,9 @@ int io_timeout_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd)
 
 	raw_spin_lock_irq(&ctx->timeout_lock);
 	req = io_timeout_extract(ctx, cd);
+	if (!IS_ERR(req))
+		atomic_set(&ctx->cq_timeouts,
+			   atomic_read(&ctx->cq_timeouts) + 1);
 	raw_spin_unlock_irq(&ctx->timeout_lock);
 
 	if (IS_ERR(req))
-- 
2.53.0




