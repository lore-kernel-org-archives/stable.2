Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050275;
	b=YDssHRwaEzlESHVsiZG0d/ArHDXvgMRT/YTeiF3IyqwlZ+p5y+CioUKCuLyFhbNW4WD/
	 AoXzosKWe2lB2s5YEx1RHrMszc7qWq1uL4xuyjKgQznqDjQ/1sgyoiIMHpiKUyE3h7U5V
	 mZGWKbLTTQr6Cm1ATgY7HSMm7woHMqeeNd/1YEB00jZrNxvsooN23DbTgopmn8xczB6He
	 VW27gflqt4ZY+vitCMtovJ3OsTSVR4Q+IhSvrsUeTTukGV31EPXSeQUsizFy3M7O+NN8J
	 54yPjFftiC0SpJNM+APedDMn5whu9B8VFUYjTCZHgYto32QHQjM0TB3foQaLo4vpl0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050275;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9D8BsgQUBWWyoN9zxNrKK+3CXzgoziJ6uYubx2pCihg=;
	b=I2F/YCqW1DhLxPtq4SQZJA8KXKzjv2hMdbI5hUdFymI/gMT8J5uOIhqROjTr9FQcG4a4
	 kQax2v1kKtzypeTfsSlJsgSuhotm3GulLs261z2hZZ4aVFsNNUVNS+3aD5oAIB0IGUaJT
	 Ve25tMNLkV7imwhYPyjTQsLgnRvo5LpM6oHMRigY9xu/7KH5mrK5T+EghyJpfmv9Y3P+9
	 /8f5+Mp+zTXmwxenrIbtSNDoq30Sn/HxLbZFBjLpPKywO5ifohRnbuoHzQEF1aeKMzXdI
	 TW0cks0LqIGmPJKef1f8VCB+N38GqyK8e5SML6iVpb+Q5FHOicVZcep7X6X6DQH64oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOkg99pU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB7C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOkg99pU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22361F0089F;
	Sat,  7 Nov 2026 11:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050275;
	bh=9D8BsgQUBWWyoN9zxNrKK+3CXzgoziJ6uYubx2pCihg=;
	h=From:To:Cc:Subject:Date;
	b=GOkg99pUXbGyZQyZ1+eErEZkSttHHWvB8MXT3H+QcYdEVB7zrtQ/SORo5Bg07ZvLm
	 b8GESx8SCKvl+W7zi1CW3GHzzeJ1hViMW1xLEOQ+BvJdboW+3/IUs/JtO1EoFWJKnW
	 iI4IM2MsE10c8GtdQx2G/4EIyaoOVivAkidHuxj8p6bKTa0Cz1WgZorIZX0ZMNxzDj
	 7YmyUvTtrWoSOXE8840H3FgE61WW/AWl8/i89f+34pY1Vg3RJx6QKSF6L4559JydkX
	 Fi85UOc5V3n1hFJQE2lmVICGbYbCo9yN/mlBycP9dr8FmqKLxOFhtZ+9OVF2Ek2VQu
	 veFunuskN7oxw==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	leon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] IB/hfi1: Shutdown self-rearming timers before freeing" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:17:53 -0500
Message-ID: <20261107061753-failed-5.10-9d3259e41ccd@kernel.org>
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
git cherry-pick -x 9d3259e41ccd5016cd2c6d013232b89df6d73011
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061753-failed-5.10-9d3259e41ccd@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




