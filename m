Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9806D335091
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023875; cv=none; b=Hy50rQ2rcyWD11nGZHZ6AVV5oBjfU9l4JzFxrrFvm9+qnt4j9JLoK5hRnK19uJgp6FisUyjYMkWiPBJ/yY8rfiGR2ELQWPejgcCtRtLktsNPLzJq+kX+8MxwnL3LLtc1l9iPeu0QidHWa/C6b4tSMq/t/kvpUEqHTKx0P1hzUW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023875; c=relaxed/simple;
	bh=F2/HjtEQ2MmdBJqo4vwJo1yFko+HgRCVn/DHIruxqRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsUh53BqtynI9+SyEtPEa6mNpFLmPhyI1iNqOhD4A/VTubhYtjm00nOyb380sZjvaC+OmR8PfbRSHP6azjeh3DqIQPQdgfqlFgOinguML774izUZmOuwxx8mYXcEV72v+tOe3UEDe3XVujwik0Zht85eKCOaLrInkHG7dtYCGDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2ibuTPk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2ibuTPk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E641F000E9;
	Thu,  6 Aug 2026 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786023874;
	bh=tl3sGptXFJycGXheeUvBackJpTuxsn5Dm8LP1QXfBlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O2ibuTPkTvntEp1GrTYCSBMApOfw2ZeTqBAccw4R+cno6Ux6DU11Gf3ZaS0Lg5uKN
	 FJzmW6WxAAxqkeozNIx81CJxL/tPpdn9JeKh0F9DiObdhBn19byEXplHf1O0+8ntns
	 RkyLDQh5PNwfL0Obu7V7heamPJeYwgxlPTp6xgbPexznsP1o5sRrM4NzEA+Dr6/gAT
	 7tkPSwBLbXvzVY5DhxmmxGBH0xd8HQtv8SmVwKP6hUfHCIcEFWJSV0i1L4tRMT62yV
	 5y+1OlloAKTjKpA/JhtRJSB4RgJHXlaxPQITB8O2lGrBvxFl99G2Z/WqIxL3Nw7Y1Y
	 VTksoZRui6MVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Hodges <git@danielhodges.dev>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] wifi: ath6kl: fix use-after-free in aggr_reset_state()
Date: Thu,  6 Aug 2026 09:44:31 -0400
Message-ID: <20260806134431.555434-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072941-coaster-vista-f26a@gregkh>
References: <2026072941-coaster-vista-f26a@gregkh>
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
index a39c8150587ee..24fbb4bb68759 100644
--- a/drivers/net/wireless/ath/ath6kl/txrx.c
+++ b/drivers/net/wireless/ath/ath6kl/txrx.c
@@ -1829,7 +1829,7 @@ void aggr_reset_state(struct aggr_info_conn *aggr_conn)
 		return;
 
 	if (aggr_conn->timer_scheduled) {
-		del_timer(&aggr_conn->timer);
+		timer_delete_sync(&aggr_conn->timer);
 		aggr_conn->timer_scheduled = false;
 	}
 
-- 
2.53.0

