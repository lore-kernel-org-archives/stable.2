Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046706;
	b=Y7st2FnjjP/UvTBpyIk0cjUsTBYZL9tcLEubVOUH0N5iWOvEbRtnrX3z8im5t7BgO67r
	 CZVFdAJIK4JJJ151IVWF/lA2FWfWDpAP1mkGUIF80V7bdIo3nPRR3Ix9jl/sJUetvRlRG
	 tytp7I8dFgy4c2eI8sPQDs6qVmOP5gdp0lXEDjwnCc+3FRoDPy8gDtX6CBAT7VAZ9IrET
	 5UPY4Vdw6rxou7MMcl2wrGNbWi76aCA06QgaMK8Ho6k45s+uNNG7ssLREeX6PPkFoDtrH
	 OWgAPefdg2lvLISX6PVoFHx/x81sLnh6o28ZvnOq3Tmvt2dbVlK2ZUZfpxYoagwNNTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046706;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3yFjx9UN7A57JXCEH1bWMJcc61kJLOfHIYHbb4k9q0Y=;
	b=jU4EmtdBIOBH8neeUbT9qXr3qDq0CbZY8Ttg8MzGCg6s0Vo4+HsrA0BoehdgWzmIdhEE
	 2rxC9LNNLRo/n5a1CZhYVnXraj27q/MeUsPwWsjFMtwapmg0+gsWvRGoPL2SX6eDt4z7G
	 Z0GAIWVex4qOURxtzuHU4IFl1MkDnHBCTrdy1JNODzSlK80hsJQV+KTTL05PMes7nBJ7q
	 Obn3VCkaGaZ9D1N5/2WF1yZg9mGTpKM4Qb0ejYB5VfN5n+c0T9ZLFsCO6DIH6fmQfRN4p
	 vvFBShpaHpc7oFv6PLeZApawPqjvhpboYGYpas1PIzjN8bvnVW2bISltwvfHULRfBYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jx/VaWeg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3418F606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jx/VaWeg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A778D1F008A1;
	Sat,  7 Nov 2026 10:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046706;
	bh=3yFjx9UN7A57JXCEH1bWMJcc61kJLOfHIYHbb4k9q0Y=;
	h=From:To:Cc:Subject:Date;
	b=jx/VaWegeEYVFtjFkBSzuhrh2UOKpsOw9ldbSrgeasnFuJ2snMFn9WBzw2/jDmGZ+
	 /UoRRANc5G9pTB5IxyxsS9YUCjDal+eoMq6XMSI4cZt7pcSy6+6wll7CKOl/wQb9kp
	 zKI/5vtpmWypp0JkvvMUrepbLtF2zszIsA/i0EEMMj+BOXvwpSa0eDunUcraYkbXG1
	 fZyh3XNg5p/uIcwuQFZtBTm7ltqr5oCh+p9HwMteKG0cxms6cGjXEqEa364thX9GIj
	 IcH2PNTSZsGKeLpcThXKpvYsOUCH/k5Hncsc8yP+qhtXF2QH3xGbBpskfnzZKORPda
	 SxzdsdSVSi9bw==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	leon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] IB/hfi1: Shutdown self-rearming timers before freeing" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:18:24 -0500
Message-ID: <20261107051824-failed-6.12-9d3259e41ccd@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9d3259e41ccd5016cd2c6d013232b89df6d73011
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051824-failed-6.12-9d3259e41ccd@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




