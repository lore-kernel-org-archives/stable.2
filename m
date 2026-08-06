Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAF03B95E7
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026156; cv=none; b=J8iT9KUIqZ1qToXf4Wod4Iz6ZqwY082epejS+8NHkotuWkb6ArQOGjFoYFOEWADz8/1d/8EuhOALtUaVf/HwxLzis4HtEpMb6Q8Lpoj6dWqK7CBuUwDXyKqX+oPEzOcDqKqybMVYz8BTWXDzDmpaFLhAevyZrjSJsdn6g7y+dRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026156; c=relaxed/simple;
	bh=aigJtJc75UvAtq68ZJU/9R8bGqP3IhIsZxBjcboNEb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ew8ksWRL6qqUg3rNeU4BfAETTPQMnnsH6Vo9iiCEPL0xoI5CxNX+uZBFCFaaCgFcrIhtG4rovRknKEQ6fpcdtaFT1P8MS0PMEb244aNMnJ+pW7qkVZxStkWPpz2mzocq4f8VWQMpSLnmZ7wm1RPQK6CBVm8gWexqfF0ahDVDpZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6LYb8xZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6LYb8xZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEDC1F00A3A;
	Thu,  6 Aug 2026 14:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786026155;
	bh=EUmekD8S7ErxFqYzC9qSPXxCjsnBukl/Ux2UzjOEj6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R6LYb8xZGFEf1iphYOljaDCRVMfz5wlt/94yPz3EtN7w+jiCiqV5QRrU7s3E5Tdsx
	 IxpE563KTbrNdQyQDeqFGywld/bs2f3KAsvfkA1O/r7gjFsOs/iIopOcXCIeP8naGt
	 Kqjo5YBoBKPDFNg80mu128oUqu3w9J3dZvL+hNjjCIAKj5LqmUBL7hzUTWTs0We5Eu
	 y9dRMh1dPnRoogumtkMu7GkC+B4Q/1TtXi8mtijrMWQ/vyMopJVd9lBcyDDQyzr6TZ
	 3SfFKOaETKzFfmzV5xzzBITx8Htmecq/grdCoU4Q0Qmn8gIH8oxFSvHIJCPdA4nj05
	 6Y584amYFGpuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Hodges <git@danielhodges.dev>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] wifi: ath6kl: fix use-after-free in aggr_reset_state()
Date: Thu,  6 Aug 2026 10:22:32 -0400
Message-ID: <20260806142233.786349-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072942-sternness-murkiness-adc1@gregkh>
References: <2026072942-sternness-murkiness-adc1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Hodges <git@danielhodges.dev>

[ Upstream commit ba7debb4dd6427386862220e8335a53a4bfc235d ]

The aggr_reset_state() function uses timer_delete() (non-synchronous)
for the aggregation timer before proceeding to delete TID state and
before the structure is freed by callers like aggr_module_destroy().

If the timer callback (aggr_timeout) is executing when aggr_reset_state()
is called, the callback will continue to access aggr_conn fields like
rx_tid[] and stat[] which may be freed immediately after by
kfree(aggr_info->aggr_conn) in aggr_module_destroy().

Additionally, the timer callback can re-arm itself via mod_timer() while
aggr_reset_state() is running, creating a more complex race condition.

Use timer_delete_sync() instead to ensure any running timer callback
has completed before returning.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Hodges <git@danielhodges.dev>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20260206185207.30098-1-git@danielhodges.dev
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath6kl/txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
index b22ed499f7ba7..deb24a5f3bef9 100644
--- a/drivers/net/wireless/ath/ath6kl/txrx.c
+++ b/drivers/net/wireless/ath/ath6kl/txrx.c
@@ -1827,7 +1827,7 @@ void aggr_reset_state(struct aggr_info_conn *aggr_conn)
 		return;
 
 	if (aggr_conn->timer_scheduled) {
-		del_timer(&aggr_conn->timer);
+		timer_delete_sync(&aggr_conn->timer);
 		aggr_conn->timer_scheduled = false;
 	}
 
-- 
2.53.0

