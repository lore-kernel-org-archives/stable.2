Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339172;
	b=uw0RQ/nY5lEIHY0CQ7Lr3oNdMAM+tSRfYS8S74mMYSCA1IZJ77X9+U14+5jzNdhAr8i7
	 4eXzOSjQZaJIuAqJ5r+stpDnKjlsxicOQnY7BwEGggHP5KqoPcgL62hWlHSh/W9jzrrtt
	 ucdmI9RRnc6T2eNX/hwLtC2QK/gjJKPZJlgwMpR2+Q5d/FUE8mjPv/HoBETnJie4Ez8Ur
	 fttocd6NoUoQSfBiUga3nG9UgWsBR0YUc/owbp9JLmbmhWygTgVqBxfeNCkx6ui4sZ38H
	 CFxzdURvT4Nejf7K96l4hIyvztxvisSbkvkyMfq8cW/zpTF7RHm7wc/NkB4JliVbl7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339172;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wjTC2K64N7qmn+TNqRXG3UtxQIOgvMjWdqXqErv49g8=;
	b=N12ZQiOzwYWu0QoMKm0/O0qjsKIcP+7AHzuEX7vEc1Jp0JksRfUJZBR6XHQgjxtE/NKD
	 TrPjgcFp5ej8aB1XXLdj+hbMrKjOvUTJF90GEkIxBeC92+QnV0Dh1pPCvlTxQ+b0ytU+d
	 DYSn6AmiFVjdkqWMVZZj0Bx258sbico/CjdtP+Z7Vfnn2GEq1UWK0y5j+8XxNcns21ask
	 zFjTCD9T7p80q5xVZMj8R25kUIJCJRWTJLfR1kNlkt0/hrtyAEFxqRUmevcU/LzAOo/f2
	 q/vdaJZij0Lv4AH864PHc+fEUXDMScbry8AngyDIxpxSTpcDQ4d8y6wP2kSlwxqtGTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=huFJWdUP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A72606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=huFJWdUP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAD01F0089F;
	Tue, 10 Nov 2026 19:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339172;
	bh=wjTC2K64N7qmn+TNqRXG3UtxQIOgvMjWdqXqErv49g8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=huFJWdUP6a2oEywmN+V/YrB5ForCtWEVzUpX8WhOAL7/ZftYZAdQ8zLfn3xvwk4a9
	 cbA+HPazImXfMjfzxnsOHAvVgcY+mJekDCmlOHc9UNeKftjm5T3AoDbfNdfZjidaJj
	 BwLC2U49TmC/7wrQNgNvsTkjNwmo+RSP0UUSASUkHAut0KGsZ4OhWel2fBJtYICnh9
	 gOSKAjVYjdFQOUFZuDNr4vTmzdcNfEPC/4E9wfrLhIWVex7g1qrxO2V1t/XM4rGQMn
	 /Sz8ruezhBZJ9tgmmpCEEFJxC4ZGEc+31LpnlgX042arpcTI5QswKTHhCHM8rFz8K7
	 6ORmykDNX4YOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] IB/hfi1: Shutdown self-rearming timers before freeing
Date: Tue, 10 Nov 2026 14:32:49 -0500
Message-ID: <20261110193146.3540418-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051824-failed-6.12-9d3259e41ccd@kernel.org>
References: <20261107051824-failed-6.12-9d3259e41ccd@kernel.org>
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
[ sashal: Adapted the replacements to target del_timer_sync() instead of timer_delete_sync(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index db96a7547fb7c..721f0d367281d 100644
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

