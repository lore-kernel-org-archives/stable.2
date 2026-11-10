Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274049;
	b=IA+iMMF0fUVUdgaY4RfxH663PRoNmAtZ/FHIDdRFARhJwm4VXUJwSOjqVN6rFdi92ZtH
	 mDVo0CiCFELhwY2uPZObH2twnlMysMgc4TovvsNSl8JKlj/qyXtRiE6a/UA0VIRqDUOe6
	 89HLo2249eGsslarvmBboX5dZEkwRdVVWL7PVkk2WgbkXp8goBZBi5e4rS/HjcUdUroGR
	 hfa0KTSq9z/MfBCMxiGIkEHiNLuGMwNYTiDr10KusLXRngAu77gE6jiLrtraxIAR3Vx0n
	 iRfn2VtYUhf1fn2pbyhAqWTqJpChyRTmAmdOvCXT6F1ZrbSJ2CEiwp+job0gAcpbOwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274049;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lJGo2Zu2MkP+9bQ+GKfoEfvD8Cri4sOFUwWb3DxEqaY=;
	b=RHBpoxHOHd1EyHRZhqVHbT0ip3tCUujx5npTmRXIVZqEJTjk7VquxzImpRUjBmI90Ov5
	 /Q/TgcXLeKpfdGJ2Vj1BtAV2LdZxNVfcAK0aIOwYwgBzIRd8+3JSqF8LKQXzTafb9fv34
	 ZypJO05h4+bG/V+Y8mBkA5wZiEXN7TJ7H6SDOSknd1J6zzzqb4iNb7rxS59jZ+V4SF+PG
	 LIyEhxl6Cf2u4rv2an7KD3vTGBdDR5aCGwDU2rHt/+9WK/Wgpe5C9pQaabUDvqz56FYZR
	 1FF1jKpGCDzgzsfXgoLqj1tJpqM5nthn8EXjHRJ2Ou1Q/9wqgpFoQkl9JBzuiYvc8bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7cFxHN1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABF4606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7cFxHN1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB341F0089F;
	Tue, 10 Nov 2026 01:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274048;
	bh=lJGo2Zu2MkP+9bQ+GKfoEfvD8Cri4sOFUwWb3DxEqaY=;
	h=From:To:Cc:Subject:Date;
	b=U7cFxHN1s9nDNN6vjDiZdOMjXrVTaK8dWLkPW/Op49VJoZ8Y9v6LyJmfxftaDRhtm
	 DNGaarUAY7f/JNiZVO+EK5ArRyvk4ttaxMM0/RZjRtsW3eMUX9EPzdfVW9NzXJyisa
	 7LqksjUylOWJ+/JTXkhB9tSyx1HS1M9DAfKuJ4K7FpngQLytDKI98HhLSFLsC+LgjG
	 rqrSsrQqn2o3d8gNu7+M1RvOtCJhHLSdN4XQ2yr2ujLpAMBXKMk94w+RpZgvpmr+V3
	 XkViB4eSsqp0vmk9dQBwA2xiULjvfDBqWkioZ+vY0oE5UzAuZBR7I9f+9pogQ3smsa
	 TyMWQYMaASa3g==
From: Sasha Levin <sashal@kernel.org>
To: liuzhe1@kylinos.cn,
	tj@kernel.org,
	axboe@kernel.dk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] blk-iocost: account flush sequence latency only once" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:27:27 -0500
Message-ID: <20261109202727-failed-5.10-e9804489e27d@kernel.org>
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
git cherry-pick -x e9804489e27dd6e33aec5511fe3780ff3009f57f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202727-failed-5.10-e9804489e27d@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




