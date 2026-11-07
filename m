Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794051046;
	b=lFqixUWaVTieZdV2O7EA/P6d5yUcFe25gwCVAbX8JUg+JMDi/pVws7CCzMC/5Y0JLMkd
	 FCPVfaKkqzWQVD3qvSz7nvoINB5FxTJSt+6EB5SUHxxUmhbBrUIpZE6dq2vd2/QyGBmG9
	 17lFvY6K6FCSlFm9kwrMo2nCVwDf4z4on4yWUXR53Cf/oZljEVNdq6LBnupHPqVOxArOd
	 hOB1vVtzQatQzf9w/iYsk0A0Xg1GJbA6YyoUVZAEIIpMJYMnym8QM3K5nZHJ/SFFM59MP
	 ViI9ddtuhGYmRmKNRLaauRe8jlc5sbgwb0MrfgRXLyGetUrJbAaVYV7u7llUrdp5TAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794051046;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=J+kQw+JANQ8wW5X3GIr0Bnc+HWBonEvF42VGRpUXGoM=;
	b=4+a0BW4fR1fqR5vmfcYq48uun7K8/ljFSTkoAHk7TSfVnjSfFEQL2dd13nqivg9bRC8b
	 WcX0yh8cWG5sNLWWxIY0ywW2pPiNSRSfzbEx6xPoAQRu7XvFjxTOh98nvloHCIQx5BVri
	 DgAZPJgwStC4vPTopGl1ubuPuuJvlXXYnRl8S0V0zQRuk2SUdU+tbMtDf79a1rtiefsKP
	 F6kPwJ5nX5FDwPEJgn7mKY61MF7CTUw6IZukgXV/E9qGPVIo1J6MgCXPjIldnp5Gzo1Ad
	 7P4+sRZb1LVl5oyNdSJHRUo569L3a+MU4GIbNua7FuFpmdtbN8G0yqzb0i9f1THyBiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aNMXf0RP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A941A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aNMXf0RP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CD41F0089F;
	Sat,  7 Nov 2026 11:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794051045;
	bh=J+kQw+JANQ8wW5X3GIr0Bnc+HWBonEvF42VGRpUXGoM=;
	h=From:To:Cc:Subject:Date;
	b=aNMXf0RPrvZayD4wJR2nemCfEBdTl1wjDa6Hs+kSPWl7vdB/RN/oGa2+4Wk2lGNTW
	 ptPlv1ei/p7D/FfPqMXYTeKJF988O/zGk+JxtrTfIhW62mMrrciiXCA6FK7Km+cIxF
	 Us2ZEzqivKz+HS0bgaDa15IM/FVeFLb3CEu1R32fNzQgXVDlHBsIQ96xpWhAuHPukW
	 37QUOtCinxydqIW+8KUz5s/VT5/EyIlnbztL979pk1ReWiimcN7GYkSumyeYSQ3Uut
	 /cqeQryGTHAu9D8epWoscOXEW8Ozs4QBbHqyB7VTAwePLSbFH5V6DS1ZVfQKVOEUuy
	 fhkyH6tLwU/Vw==
From: Sasha Levin <sashal@kernel.org>
To: teel4res@gmail.com,
	axboe@kernel.dk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] io_uring/timeout: count cancelled timeouts in cq_timeouts" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:30:43 -0500
Message-ID: <20261107063043-failed-5.10-1c8b49851543@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1c8b49851543f41fc8bb18bcd1f15cc93d14b530
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107063043-failed-5.10-1c8b49851543@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




