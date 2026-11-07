Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047457;
	b=x1CxEMEDtYQ0rZO6ysbXH+S6ww0Uz3Ky8xZzfOZZhZWM8wYedeLtVQBT/T5iM9BK08Aw
	 zW0/BfvbqO60EeP7KG/xJamA4XEt5Fjaopq+6SkXIHFcW3357Yyy/7iUD8f0AScArUY32
	 mkLMAAKE2i/hwZUyFog1IbL1V1DxiVxoGeMPL7VW3IQmnOOpr2/zWIX7exYUQezl6/Zq0
	 sSgIRX1E2h7KhK2AHy+01CBRLXAuI5lipPF2enU87y2ILoYonvZcJGIMQCR7KFlXQj5Xa
	 vxAzcrDctzHBjz7j2KnfO21PJBc4t2AbDz52w5OxA/tM8mQ60OXJ0eqSyYAbEl+xq2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047457;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PVMFNmuABl811UwUbn7cf2iBtBW7u9eQRLhcD1wrpJc=;
	b=V8fX47Rqe2nrE16u6qMVU9a2ejLlUVMplK+ZX+xR6u1Dyl+0b9L726qXCPAc0tQJ5rx+
	 9V1+pFZao/24xjiYikMnUX5PtoYEEEIaFIMxRgw8rOfWczimWQWxKgeH3o0Ftu7IkthO2
	 gi/5Ofu2QuQ3wGUUWaIuAqvzwbBPqSNg1rTIVGNDq5HOxmqdKqOw8FEphFwOMawXvHtlU
	 j1Jrdaxh0Z4jGK0E9LuK3uYDYkM+j9eMimqlNhnKL6Z30pra5CNLWkNXEf7QuelXNinNw
	 KXlrGkoquYfNSb42fJno58QPcixmMZ+uz5ymOegH4DhWnakeJBvCwQGcUU98yG5lQJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfbtgJjN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5C0606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfbtgJjN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1BA1F0089F;
	Sat,  7 Nov 2026 10:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047457;
	bh=PVMFNmuABl811UwUbn7cf2iBtBW7u9eQRLhcD1wrpJc=;
	h=From:To:Cc:Subject:Date;
	b=gfbtgJjNIbjO1K2zYoOtY+1dnFmCZQu+L8EgdvAmpMyPfwJipRyT+VDalUhk85N51
	 AOp8NXeNiuxmv1s8+hbPwHwZngECodIMRGPIuOa/HexfyPPOysK4ULbTJMx+5/fxMn
	 xz3J2J1PILeh57iUSZuMwcdyKVc0ICI03A+fibHCOsM5A3uxmTiwQRMKPt05pnZijh
	 EmfTavBg52gZkBt+oPruiUMUyojV7ueJ9p9rkSNm/TnLc0BbT4dso0wymeUWVXuYhG
	 ocO9QuK/26uY+jIrWRCDvk9Y5bUe7OFP8ueA0YZWxfZ8ryWFxn40cf6SEi5++Gv6NA
	 5Yqx4sKNjQLkQ==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	leon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] IB/hfi1: Shutdown self-rearming timers before freeing" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:30:55 -0500
Message-ID: <20261107053055-failed-6.6-9d3259e41ccd@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9d3259e41ccd5016cd2c6d013232b89df6d73011
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053055-failed-6.6-9d3259e41ccd@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




