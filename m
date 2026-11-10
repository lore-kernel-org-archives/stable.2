Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273778;
	b=wkZPJyJK7R0XeBq6eolIdurnlvrxtbkozFzO/fXCOcMGIZyIDjbbSGkPtqNBSXvi4xXr
	 zG8eYmgaGhsL18X3tXekYifaKGW4IU9mz9IqLtkUn0M3jE6+B4C3sLmfWe583vHV2Zg3x
	 nu3q9UXcXPB3Wx4Vss3GEt5OJo6wE3t2Rz902FJtdK8mJn5H7TWth06QCIotwA6BCJMEg
	 g8tbxKvlfwNtozquwRuGyC7BQzn3bazS7YfNb8k9QGOoe0LWCHWOLxObT3ny72I2RrlM3
	 hf88nS4+cUshyYLUgn7wzh8w9qfxsnnKTiaH0VSWNKHuBTZj+1HMdKQnuc7lMfd3B7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273778;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zCzEXikqWrT2XTqi0Z7LakHfTFpvGbCaAQPfNTJstFM=;
	b=UmWdYo/xIYYn6xxxeY0bqq9g942tWJyQbUD3qyeluUKD8Qq2Q/bBXN1GpnU0/g5URM04
	 Mz5ghMvSMZBFTS+5WKLd0edsGH+RoKtQ6O6ix+5qAbOArCkoeQTuEe2PGAQISIdbH0dqH
	 HR1Tr2vn94m5Pjt373XDZEKlPH/6hpRed9ec50Fdw2F1DScLeS22Gmta7hIXCeHcB7zxa
	 QyTOjXHr42GFLRsZ/f9z5mTnAiRDgu81uxh4piPJwNjZRdxocWZo3kHbfU+VS2A8ct+qW
	 eUuFBNqOElyTvIY7SzGiCMy/0T00JanyvZtKD7HvzXFm73pcoJl/NjPamQb3EjwCwnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dICix+24;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CEE60A3820
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dICix+24
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1951F008A7;
	Tue, 10 Nov 2026 01:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273777;
	bh=zCzEXikqWrT2XTqi0Z7LakHfTFpvGbCaAQPfNTJstFM=;
	h=From:To:Cc:Subject:Date;
	b=dICix+24XnBBQmP9Ami2njqpBRuogFLjfau+NzghK93Tzgep8N3VhUD5Sisc+xwmD
	 QHNWSJkLyvewzuRYdeuLEPJgGBE8jjYBWvmlSVoEU4hRZqPCGVMKbTXaYznLw2xPLe
	 Vi47AkX0a8nSLDOEYqBekezulPbWy8+ehLgDiypGhLsMtBBMGz4/SZCTF5aA/c484T
	 fLgdcHTy3eSaCVekcYiA8Ju1q3WWc7VCZ3wdhZpYLyXOuKq/n7hKcEd6Xj86WZuGRo
	 Oxc9RXjr2gC953AInEyIihLqYmh1AFfI8H6sr00z2cmeTRgDzlguaWhzpNWl1pju5K
	 r0wWAhW8Mvqwg==
From: Sasha Levin <sashal@kernel.org>
To: liuzhe1@kylinos.cn,
	tj@kernel.org,
	axboe@kernel.dk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] blk-iocost: account flush sequence latency only once" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:22:55 -0500
Message-ID: <20261109202255-failed-5.15-e9804489e27d@kernel.org>
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
git cherry-pick -x e9804489e27dd6e33aec5511fe3780ff3009f57f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202255-failed-5.15-e9804489e27d@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e9804489e27dd6e33aec5511fe3780ff3009f57f Mon Sep 17 00:00:00 2001
From: Zhe Liu <liuzhe1@kylinos.cn>
Date: Mon, 2 Nov 2026 14:18:02 +0800
Subject: [PATCH] blk-iocost: account flush sequence latency only once

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
---
 block/blk-iocost.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 1c1fe07a96eaf..1c1025157d8e4 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2936,6 +2936,9 @@ static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
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




