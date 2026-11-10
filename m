Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339423;
	b=HEk9mtpBt+4zqQe+m+maFG3f3T28ezXe8k6ewjSoSyYxqqRyOzx/VAwBP30cATqCWLQL
	 akydGGH/gs9XSxnM56iAiCjwll2JtfA/AKI/7pl+ySW1yHumlX1n9Z3qJ3xusi102lhxa
	 rDkLfZ483PgC+P3qGugBHmL2XINmbAEkpifNDZxBPbhEsLUSS09FqGpCoy0FQu+qgnfRh
	 TVAHy/uQhytShSGjJoJZU85NPriZCQPUFgoa088UtHE1tzr9uHGuxku/DwSDzebD7ooKI
	 wusMKlbYkcC1Re8OkryEo50ZcQlYb/AUnLwiCfXvi83hVCxmeJAgfkHWjur2uz/uoIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339423;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FHZb6FOB1JdmeSWuwGDui+mmapxERiMD7x3PMl/e15k=;
	b=lq0xAUBGtgXJyagyppSl6ESUQ7Pgth0/D94G60rGuJ1tz65gR5Q3RNteu7Osxcuh+AlC
	 0z6DTP4MVi8I+LmDBAwb81g6bX772flJlTEKzzp54O2BcluWZDkOoJIrzoNEONAdBzsh4
	 caCHqYBI2aHHR5LDGdTSXh4+H4wyp9oyNfc7G6Ca4T4dz2Yfz6Lbsu7ypXNAI7Yxv077C
	 jhFuRIYV+ePAbkFAJ3pJ29pmksf9i2jHpTcrX73fXCr5CgtOFEt5yCwyAjo70LKnBl3f9
	 yK4Dc36Ns173dqpzwUR3Zfr7PkJa9rY936YmHX8vUz3JpW4TGg0ljrLsAVGeBX4L3Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyUZbKsf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE7606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyUZbKsf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A9C1F008A1;
	Tue, 10 Nov 2026 19:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339423;
	bh=FHZb6FOB1JdmeSWuwGDui+mmapxERiMD7x3PMl/e15k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EyUZbKsfOXh56+Q3obYADzYRGSAiBEU+eVeNQqaVbYvbu1v9B59edIiYUOIYYPiZp
	 MvqUMtcAD0V1ovmmpS4UHhDknQqYSkQbFEScEP5U4slk/4nktiN2ImHN1iX3lpT+rw
	 IFjO6kX5A8xxlSZ5jiukvTMCfJbo1NryHe3/bA4GD3uqsKQ88PpZLlCWyz8t+X9m8z
	 Q8ajcIN9l2ToiWjNv34FEsb/X3boV4tTn5K2g3GoUDrd1wfpFQFlDHmUpKZJBZgXxR
	 ja/emZ66MPpyckUHIxhSsIP5I32fIOZtZTGzIdRAJTWPjBKwq6p0qGWRe7i/2/bsoP
	 ij9A8Lbm3rvWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] IB/hfi1: Shutdown self-rearming timers before freeing
Date: Tue, 10 Nov 2026 14:37:00 -0500
Message-ID: <20261110193629.3617821-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053055-failed-6.6-9d3259e41ccd@kernel.org>
References: <20261107053055-failed-6.6-9d3259e41ccd@kernel.org>
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

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit 9d3259e41ccd5016cd2c6d013232b89df6d73011 ]

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
[ sashal: adjusted context for existing del_timer_sync() calls instead of timer_delete_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 00a054007822f..c40ae27e9a94b 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -5576,7 +5576,7 @@ static int init_rcverr(struct hfi1_devdata *dd)
 static void free_rcverr(struct hfi1_devdata *dd)
 {
 	if (dd->rcverr_timer.function)
-		del_timer_sync(&dd->rcverr_timer);
+		timer_shutdown_sync(&dd->rcverr_timer);
 }
 
 static void handle_rxe_err(struct hfi1_devdata *dd, u32 unused, u64 reg)
@@ -12308,7 +12308,7 @@ static void free_cntrs(struct hfi1_devdata *dd)
 	int i;
 
 	if (dd->synth_stats_timer.function)
-		del_timer_sync(&dd->synth_stats_timer);
+		timer_shutdown_sync(&dd->synth_stats_timer);
 	cancel_work_sync(&dd->update_cntr_work);
 	ppd = (struct hfi1_pportdata *)(dd + 1);
 	for (i = 0; i < dd->num_pports; i++, ppd++) {
-- 
2.53.0

