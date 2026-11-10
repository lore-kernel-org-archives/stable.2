Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339809;
	b=p6UrZRLd6e5Y/1Qdag5idB760GTJn6wjPpGtvuoCB41p+hqYWDUfEC6ecSA8G3CpvAc6
	 8fKTOPIc7bObnufc872aWG/LW2bUmF1mc++ffKZUZ/Wz4EVMnKzSdOsA3efJ23Yq/cr8j
	 LC669RBGqpG0IWtLMV6Ju3GKUV20oAaFakwQOAG3B7768LVyyu4jknEgs0vl9T9rNQ3l5
	 9a0iHdMfnmqlbAbId6eQeSfJFczlRBsDz+1dZmJbeuiG6EFTC7BLCua2FVSDR5rJWPAwQ
	 p0Yn70094tPYGFxBH8ImaGvQttWW4WwHYaRr4/PFdpCu9Iki1AyQC3CiqTplGPxV/Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339809;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hgTbk1yNjURPmCR9iUGjoH0moqlfJ36x4447cXBqUmM=;
	b=cd3TICrprhWkahmMhNRL1Y9PU8Zv9vLAKk58wUhOVldIvN6/Lptxq4aEKKOqRdqlq+Vs
	 OkjBo5O5ephR+4qvnFVQKoJ+qn0+77xJ3LtRGW/YhND1ZdqVgz6JOv61UlPcpez5oyeJc
	 vkbyoZOazWqo0VnT04lx7Tw+RojsCmxBOeV7TrjfWPXC8zlyl9lsA5WwIGvBM5rq5dDaj
	 mPdj7I4hfkZFV9azJMGSFgIVLOmuvQ+H/fjezNVkXcTk3a8hLgO46inBTu6T5iXTLmHnd
	 k5ZLsmGR270YANyekwwiX+qTI39IkZYvrkXmiGG6AQVvxnVAdD4ho9Z6ZfrKjcGPhrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+iwYAs7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C7F606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+iwYAs7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A881F0089F;
	Tue, 10 Nov 2026 19:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339809;
	bh=hgTbk1yNjURPmCR9iUGjoH0moqlfJ36x4447cXBqUmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R+iwYAs723joX+sKmIjF+zEP4iUyZAPZy1PqJEIOy2WK9dYS8N0f9NIN0pEfye3VU
	 HHhL3IjqLk10Le00yY+2pE2Wu8z6A7TemJpDVjNtvMsW1jxnuJ6Sd9f+s+oHlUACXV
	 UrDhYk5P11oPjflPlRmMhvRMMgYRqYdpzVlXIR1ZR5L1sUPnclqA0jFHG1HWQrUuGr
	 bBxi2m9r+hfK6CdE3KYYlwMthyhKoMkboHKJ9wm9sg8G8y4Sc8wWje/CmGASgxiwhk
	 mV4v8Jcg4nC2/NuVL1QXu1lDa7FQSAd30dQJnvscYE6aRiaegRa0VduKvMVxtLgss3
	 dGR8oylBljBzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] IB/hfi1: Shutdown self-rearming timers before freeing
Date: Tue, 10 Nov 2026 14:43:27 -0500
Message-ID: <20261110194237.3634091-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054336-failed-6.1-9d3259e41ccd@kernel.org>
References: <20261107054336-failed-6.1-9d3259e41ccd@kernel.org>
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
index 3ef47ffd3859f..8d9a64637f2cf 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -5575,7 +5575,7 @@ static int init_rcverr(struct hfi1_devdata *dd)
 static void free_rcverr(struct hfi1_devdata *dd)
 {
 	if (dd->rcverr_timer.function)
-		del_timer_sync(&dd->rcverr_timer);
+		timer_shutdown_sync(&dd->rcverr_timer);
 }
 
 static void handle_rxe_err(struct hfi1_devdata *dd, u32 unused, u64 reg)
@@ -12306,7 +12306,7 @@ static void free_cntrs(struct hfi1_devdata *dd)
 	int i;
 
 	if (dd->synth_stats_timer.function)
-		del_timer_sync(&dd->synth_stats_timer);
+		timer_shutdown_sync(&dd->synth_stats_timer);
 	cancel_work_sync(&dd->update_cntr_work);
 	ppd = (struct hfi1_pportdata *)(dd + 1);
 	for (i = 0; i < dd->num_pports; i++, ppd++) {
-- 
2.53.0

