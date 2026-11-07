Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049271;
	b=YFC502W57zMRO0qDtHcyGgTruPgOYudzTPDfVw7MZdAg4Mm5vFodS8A2Tlln17HIb87D
	 dPKhXVGMrqBn1eJv9ZUwLRAeKQorqmuZcfwCzjY2/tienWWUS4srdN5HM+gBsdXys4P9N
	 RtKz3rWUjUmpvLIXWPn0sYSOTpihCf/avDYUraXqVq4kP8jrY1sysanh/K4BpXxfz/zc1
	 yVF2gqsHAY6pZ17MdWaVHslIhXfOQfqzFF7xY083gAtYV9HioCsZqEgIpBJivBjL29wSN
	 CAhsVASbwXaevjlFfpHgPUzD3c6dIGXSPKGC6Ne5sD9eBlCltX+PUy8OZ8YS84qklzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049271;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Hx5pisGFACxQW/T/HxO3IJo5n+xmBLrn0HPHB8g+yz0=;
	b=aSKU451XLGMwJ6/f8RhbUH57ALMWzmrnI4THQaDKHtSXk3C8maFlFNgf7opyvq1dwSLF
	 s8edBm/aQm/bjfgBhIavjZr7NGgKPDYPGVUwkHwApbifJDvz3dztYPfXLnQOr6ndVt+28
	 cNUULl6H1iV6fwwno2kmXpxeDWMf12zAcFt0J04OoCab8jG3zfjleYx95ZZTgeB/ZBZIL
	 frlDg2dgD2z1TsVNVE5vVwGF0uS5/ov66GNDKMtLqO6LXxDuE4207PUIXpvWP8ymP2hsf
	 UpQ53H1mhAHEx/ITcVVnfao114veJ3C1PgP2+LQ6ZBuhUzg8oMkWbR1yioHOujAVJ0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRDR2bTC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED13E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRDR2bTC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657FA1F0089F;
	Sat,  7 Nov 2026 11:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049270;
	bh=Hx5pisGFACxQW/T/HxO3IJo5n+xmBLrn0HPHB8g+yz0=;
	h=From:To:Cc:Subject:Date;
	b=mRDR2bTCRf0M6/L1NM5I7F/YwbJlHnA/R7jWwYxrUqKXSGyhYY6/oiJwRRXeY58Ae
	 xpRCg1qbyN+Hhtki529sE3bv04uBq3n4JPf0NlcVSN/2mRNUj1yvOCunf9+1Q7ms3e
	 AgxD9YVysGL3wdbdshU90Tj9JC33xMqmkF0P0HN81dow2ARSzSgq5GrFPEse5bQu+t
	 VHSpTH4YgypIllKwT/uTDPV2BFbZR7o5+mLR+ZS1UegVX8vzXk0EEZhRLzgXjN9eGI
	 q1VDI/zyR4pNBQpFa5/mFbdDRdFckgwqe49p4SLtjdVMUnOdcoBWTtWpAeqPL3+lui
	 gyrigD/0dyMsg==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	leon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] IB/hfi1: Shutdown self-rearming timers before freeing" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:01:09 -0500
Message-ID: <20261107060108-failed-5.15-9d3259e41ccd@kernel.org>
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
git cherry-pick -x 9d3259e41ccd5016cd2c6d013232b89df6d73011
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060108-failed-5.15-9d3259e41ccd@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




