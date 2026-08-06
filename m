Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4241A3B6356
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024785; cv=none; b=hGOKMS6GXyPH+19KroO2HMUCvDhQg/EK9zwBaQYST/Kv5pIgJUZWcsYN5RT1L+MDav3ixztFw53TpxPFFMVm74Y8fM6q24srZCRk80hxDvSsK5WjnRIH90E8ISv7RBffMHQaFqO9BwoyZLmqktm75UTqbu+XOlh9Fry/IohtGZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024785; c=relaxed/simple;
	bh=dok8VgDorIodn2CZWVYR8l5jNuK4DfK0Mbv9Eb6fbKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyiYmX7jnB1T7b2S+2ZFhM4j5cLSGK3te6J7d/l9LCyTvj2k8V6B81CM9ajOvyBbhPJOSWQ03ZKEjrBYbqQRWMsCXHxCgAUnzxDc7UNxouTPiZPkDOzyppB+F2vRLkWS5C/Q/W6q7sOnJSQXvk1KOl9wwi+Te90pA/rpGHvR6Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKzxcQrs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKzxcQrs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440411F00A3D;
	Thu,  6 Aug 2026 13:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024780;
	bh=Eyu5vDJn22YRJoSb4oPz4JJthDu7Sbi+IBHKi/sJc1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZKzxcQrsgqQNO2C8HsFUL46PNDcH2LZxH6bXyr2B3N7LJ0v2ai8NKNJjgKC2Z7od9
	 zyYoHZ7l7bZalH3Hjj809Gb4fLX8HcLhuenTnTtk0Swr7EsnSdcLb0uUuCc+BeYHJy
	 A01xMBRAh1U4DDmIxC1pHBqpiuh3eiNPnL70FqPKc15emWzB9Om0878DoW5cXdM++V
	 uIf4UEeqqUQd1UzN9IEZzzy3pNhcZLCnpBH9/g4KcM/xEZzwt53tjkw1/ZGyuKbKCI
	 BzYWuvXmvZIDts8HBjgLAfxNMYeMy7F7jrLvMRjheViM9azyPKIxvJ+dcK9jsbWL6+
	 jz6peCutqWGsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Hodges <git@danielhodges.dev>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] wifi: ath6kl: fix use-after-free in aggr_reset_state()
Date: Thu,  6 Aug 2026 09:59:38 -0400
Message-ID: <20260806135938.632590-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072942-curator-autopilot-b92d@gregkh>
References: <2026072942-curator-autopilot-b92d@gregkh>
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
index a56fab6232a9b..e13deea0ce830 100644
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

