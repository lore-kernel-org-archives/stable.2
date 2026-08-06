Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4093539D3C0
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024230; cv=none; b=bQ+GeTT59xRt5of9WysVEYtlS80WvzwVnFIUJoVbG+E4A0WUVSPyxAfevJyHqXngo1194pwjJQTMafrB4+R8qoLFccpyW8YcZce+UXeu1qjQJB++DhpHJaeNZkI3cfUtaNeACeq06ykGOMJZxSfuOaAro6Y7T4irxYlHVqVmSY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024230; c=relaxed/simple;
	bh=/j9/u1cCV0art8Bj11m3lzvJauQitg5f9TPyiIsnWBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qx1JYMj2JzdZ77cPiGwSCvQO780ayKa9xXPtBsq09pYN7nat4qLXpiiyYFyJctvWwoSrLMqA00jiII1PJSAvnS+Bso8NOVkx7ywFI/o//qodb8sBSn/0g07BTKNINMS/pT+YuoxnXysSdgO5Nbd3u7al9WY+/qEDdyJRs8qK12Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpudD3wG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpudD3wG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA5A1F000E9;
	Thu,  6 Aug 2026 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024229;
	bh=3tAC68oKf/bmWRvNuNw6ZOpLiLY64ML4pJj51ecvJNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dpudD3wGtS4jnlqW0ov0ULrcoFK7VO4gD0ITJUQYqG7KSRobKHJ9DPoUB+e4nGZK/
	 7UpBLe6tIMS45AGpZPzS+VKRFU+Qa9uoqeckBw4GQCdYV5G3oTktp5wxpDjTjz7G1k
	 /x++KNpEkLj9/U/r5hjQW8LS91zDej/KCPDFmarvPd13h5el7CK5oHHhtVsEIEO8oo
	 Nt0UwCb3WJh2vQVp6A9r88RHHKUh5ofYNw225hlcQ8ehEA7PK5sLQsfDWlTBCElIRC
	 pK0UfOLRRMxyShdfwr3EEv7RGGtW9Z3KjZgmUQolJZ6cQUcwo+sHtChHRQWiUg6u2z
	 Ey3gUg5UtEZTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Hodges <git@danielhodges.dev>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] wifi: ath6kl: fix use-after-free in aggr_reset_state()
Date: Thu,  6 Aug 2026 09:50:25 -0400
Message-ID: <20260806135025.603479-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072941-unstable-worsening-62f2@gregkh>
References: <2026072941-unstable-worsening-62f2@gregkh>
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
index 159ec376baff8..0075992ad3d15 100644
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

