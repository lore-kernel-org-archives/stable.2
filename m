Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048218;
	b=inwosffD2DtBOXQ2Nd+4jJkoFXryRemWr6OQ5c+lcDHkLn9tNEbka0ulKxFxMDE3cFhd
	 HjLjhYl0GcqKVj6w6IKp+kXypI6WyJMEOuwpWOE6+aI0xrLZl5kiC/BquLubW/8OtkGXi
	 jvSYLs7tHeilqxxrbDMc05lAVc9C/pLKhcdmBpJwZodQ2euQ1LyaNUe6serHeo60TGLlW
	 2Vm38EPr11weTrAzSKL3e4PeRzt2OXdFrxSMM07wvjTmHmuHn2ey41e0SyA91POXJtYAh
	 4vuNlAqrzgDXmCZ3YumkfdpT7A8w9XqGemk98pyk2e20F51rwn029dbz6bgp/En/IdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048218;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=i+a1n4yLbr/kFhHfJdpjwm19Ge50hqV9dGkUxPQEQLE=;
	b=VhUdPz7KBBjar+FP0kOF07Rv9d8LtwXT1tuRFlqwqNfkwmNd5ANgMbVLr5bubY6E8CFR
	 yLKFZ7N4CUxircd3h1ZtcII3AonqrRkJmLFcvFpki6+cfNWMUl6+PlrornJWl16XAK32N
	 BuHUjpDQQqeSh2MasoJ2AJfcQgrBTPE4e9wMDNSg01+XH8+hAOckrreZWnABGAF+bTOkP
	 7bOzgNQt+q7GezP2nGT7IKI6lmub2+JR44IqgRWKcCEkTwAiAs+i1B5NnrD18IQj6yI91
	 WBvEjxf3/i1bHsS+kHXLfY9R9lqcNRVeT18rIsDpIHVl5PbjlskR9Qlp7KqhiGMC6YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=finyHHkK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30279606A332
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=finyHHkK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E801F0089F;
	Sat,  7 Nov 2026 10:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048218;
	bh=i+a1n4yLbr/kFhHfJdpjwm19Ge50hqV9dGkUxPQEQLE=;
	h=From:To:Cc:Subject:Date;
	b=finyHHkKCEWN5qMWTCj6EBX7hP9ht1n99kATybW3QUi8PiBXAxJxDSZkxZr2vBE+Y
	 S2JTiodoh0gTgAeDwLar2OhDoC25gyGKB6PF+eUlILhBsO5QSdN7X8Io7HouznAvsg
	 CDJQJGDcTNiMGjH5GbA6VZl+zEM+94f6pRAn7CU2S/EZkScw08vKnw1W/T9O70vOEG
	 jCT0bosXRw136NCEL80j0TZOTVTisdM0mMJscSDHgGxmd1jxiTjG4hGbWF7ftLVctp
	 Gu8EWCSjDOV4EpfbzQwbczjfkrdUmtsYcBuurjSwpBHy1jDVJmFUqbVfS/q1AWXi8Z
	 xrjJkG/KtDTBg==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	leon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] IB/hfi1: Shutdown self-rearming timers before freeing" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:43:36 -0500
Message-ID: <20261107054336-failed-6.1-9d3259e41ccd@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9d3259e41ccd5016cd2c6d013232b89df6d73011
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054336-failed-6.1-9d3259e41ccd@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9d3259e41ccd5016cd2c6d013232b89df6d73011 Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Wed, 30 Sep 2026 15:04:55 +0800
Subject: [PATCH] IB/hfi1: Shutdown self-rearming timers before freeing

The HFI1 receive error and synthetic counter timers rearm themselves from
their callbacks. Their cleanup paths use timer_delete_sync(), which only
waits for a running callback and does not prevent a concurrent or
subsequent rearm.

Use timer_shutdown_sync() when releasing these timers. This prevents a
callback from enqueueing either timer after cleanup begins, before the
containing hfi1_devdata is freed.

Preserve the existing work cancellation and workqueue destruction ordering
for synthetic counters.

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Link: https://patch.msgid.link/20260930070455.2934286-1-runyu.xiao@seu.edu.cn
Signed-off-by: Leon Romanovsky <leon@kernel.org>
---
 drivers/infiniband/hw/hfi1/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 592e330e74bf1..faa724ca33bd7 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -5567,7 +5567,7 @@ static int init_rcverr(struct hfi1_devdata *dd)
 static void free_rcverr(struct hfi1_devdata *dd)
 {
 	if (dd->rcverr_timer.function)
-		timer_delete_sync(&dd->rcverr_timer);
+		timer_shutdown_sync(&dd->rcverr_timer);
 }
 
 static void handle_rxe_err(struct hfi1_devdata *dd, u32 unused, u64 reg)
@@ -12300,7 +12300,7 @@ static void free_cntrs(struct hfi1_devdata *dd)
 	int i;
 
 	if (dd->synth_stats_timer.function)
-		timer_delete_sync(&dd->synth_stats_timer);
+		timer_shutdown_sync(&dd->synth_stats_timer);
 	cancel_work_sync(&dd->update_cntr_work);
 	ppd = (struct hfi1_pportdata *)(dd + 1);
 	for (i = 0; i < dd->num_pports; i++, ppd++) {
-- 
2.53.0




