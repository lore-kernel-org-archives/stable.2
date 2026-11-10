Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340316;
	b=WbLifOAO83wWau1qzpoOQomuTYvfvMAqMvQ3FZjhzXQd5zdUU6paI5GurOmNCvskRwVb
	 ddf26p7IXpuI5r/Z22z1ekTr5IUbjSBfv/07saWwhQ7JPZ8ZwmunJOrAFQTAXGT+5/01V
	 f31G5E4iICadFviGifwylyR2fCoEB74ONRS07c5y5vWlSmA4lrMe0kKY2ySo5KxcHeznE
	 g6/1A+PQieAEo/dFZTC9giudp0/3roB32DKUXsewfLQg8txKd5cgobwmf8NU6nkT7DQAu
	 r0xtTXit4B1tKTz7UYxr6Z7kOF9O1nAm8Mgqfq5s5snfcdjcEQkqgNLAYruAjWUyrlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340316;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=f9gi6EoqGL5iaNSNJ2T4f07POdhNaW+ZMt/0/WO+j1A=;
	b=4al2584SyYZ5b/q5tvjI6crzCc01Ou9MLcMAHNf16+ooNHpoHnZLADGZ/T7L7Yqg/jST
	 OE9Q4zJlyHlzvTPZSrcxGNcg8Ep4cMtAHJ/LHzg+lJ4WqOWQgGjsJfXfVKqFczGg+F/fK
	 YWT/FpIfTAvBQ4nbJn5L0S2ecsUVXz56LJziHaUUQ4qC5D46lI9JNrF5vwxuhePCDJYes
	 CPYVNnN7CgS7eprop9Py7F6gPw4XWx39FVVF1Py+j+ayZhetSNCgUcptmKK4pAOIgk+MF
	 Bp2BDxDfevEBaVBtcfHQWJ+AX0wpBi1ZiKF3pkoxqiCVfDhwy9evY8yPmAVI5P9gGnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9U5eQ1w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43BB606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9U5eQ1w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0671F0089F;
	Tue, 10 Nov 2026 19:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794340315;
	bh=f9gi6EoqGL5iaNSNJ2T4f07POdhNaW+ZMt/0/WO+j1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W9U5eQ1wz94LFMH4VX7hQ+RwqkYCYP0Rkek7mtfhPD5K5TEmP2NF7LZIXqfhZfl0A
	 4MefEsADCuPr02fAR2daz1kBarZ7Spas7631VV5YuUmLeBlHo4h/k+1EhvwdGxzPaq
	 lEUVTJuR73H5ZBh2bi0ffoFQWZ6J6WnsM3nf6nmsh8cphWIlG7FdgilaWkteIfM4qT
	 pSUXKyetoiV2vcEUkjcdtXVJx3Kt+5t6BEMpUXP1r10wEGIHBmyuTXLONSiw4+tacj
	 ohGTTreJxmaM/xsm6ee35MKXwStnTI3Rn5ymQk1iSWRJTn/ARZw6sK+o64mopjQsgX
	 jGA7JTENFVrEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] IB/hfi1: Shutdown self-rearming timers before freeing
Date: Tue, 10 Nov 2026 14:51:52 -0500
Message-ID: <20261110194842.3650641-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060108-failed-5.15-9d3259e41ccd@kernel.org>
References: <20261107060108-failed-5.15-9d3259e41ccd@kernel.org>
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
[ sashal: adjusted context for del_timer_sync() instead of timer_delete_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 6bdc2152cb41e..c1bf19ad0bab0 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -5574,7 +5574,7 @@ static int init_rcverr(struct hfi1_devdata *dd)
 static void free_rcverr(struct hfi1_devdata *dd)
 {
 	if (dd->rcverr_timer.function)
-		del_timer_sync(&dd->rcverr_timer);
+		timer_shutdown_sync(&dd->rcverr_timer);
 }
 
 static void handle_rxe_err(struct hfi1_devdata *dd, u32 unused, u64 reg)
@@ -12305,7 +12305,7 @@ static void free_cntrs(struct hfi1_devdata *dd)
 	int i;
 
 	if (dd->synth_stats_timer.function)
-		del_timer_sync(&dd->synth_stats_timer);
+		timer_shutdown_sync(&dd->synth_stats_timer);
 	cancel_work_sync(&dd->update_cntr_work);
 	ppd = (struct hfi1_pportdata *)(dd + 1);
 	for (i = 0; i < dd->num_pports; i++, ppd++) {
-- 
2.53.0

