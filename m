Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B14189B84
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026521; cv=none; b=V/EDhxW52G1XddK9CutpzpSRkvDcFZbNfD+hQNbNhujKAINmfvjdMUwake6pef2Zg4ZYlc7nmqFzNcWbMdX2Rmm/NTF3l+TDMPUJitgdW/4Ec7eVAUH/xBnno6rybNS4Dby81qLlyhq6NGcyCH9kDMPEbWz3B87TUQPcf0a+9TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026521; c=relaxed/simple;
	bh=aigJtJc75UvAtq68ZJU/9R8bGqP3IhIsZxBjcboNEb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSDAzwSdND4H+3I4zQN4NwdHhjwKB1oDzK9sfBQ1RjB8rKZYrDe5kVskzia+ynjdq8cKpFo5HXxC1fcUeTWH+5Za+0sxieQzoUeCEOCMenRSrdvxb1Nv9b5VYMXs/oucAmwXyoFodN9apy33gi7kdszSrpgmiBFf/+jQHuBdl5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iixo7ZrN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iixo7ZrN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576EB1F000E9;
	Thu,  6 Aug 2026 14:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786026519;
	bh=EUmekD8S7ErxFqYzC9qSPXxCjsnBukl/Ux2UzjOEj6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iixo7ZrN6E32MoygCmIfiqGuOcb5WHm3/4kidPnFck16KYa/om0t91fPpjAGCOwRu
	 iBuy01uOOOENXOIUQ4Gl2a0aWcLP59Uiu65ZAw6fj0CwOkDwBcS+QvNn1KRzMp108w
	 KrMpFx1sZubf3+IHVm/4Aw3DEaHUZJCznid6JHOJu/FNEOntvb/P5OiimvNNFKbPbE
	 Dnef/uRNxsBMPZ8Lnug4xXprWoLT2ZY+YliW9Cuk/k5kxExPSy2DfskDmNAbvS9Sh1
	 D9AudDvcJUwMzxFeCmKe62PrejgBkd7ZbgdTuD3YYEGNQouiPoO3HN7XnNBP/t3r9h
	 hFoZurLXtmQVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Hodges <git@danielhodges.dev>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] wifi: ath6kl: fix use-after-free in aggr_reset_state()
Date: Thu,  6 Aug 2026 10:28:37 -0400
Message-ID: <20260806142837.789504-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072942-backwater-librarian-a9cc@gregkh>
References: <2026072942-backwater-librarian-a9cc@gregkh>
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

