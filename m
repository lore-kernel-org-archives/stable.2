Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795639183;
	b=RQP/R0B1BSIK/buev0J4aPRPy9g55almuZx5MZsV5HNLig+rNR/KXzn/KhhqgVKBWJjR
	 b0DTbVuPo2gTlSbo7fAIt21+5E8tMPEeiSFwmQsvCSwZGDIfL2J0tOeZ/fvqAv0Vy5Q/D
	 S6Ly9gRpBGwEBsGMrEzrCOgQcsgBqBjSHX+YvN/QRoDxqpIdXFpTtBW4Jjecf0f320jL7
	 LvfhxtDFLZnMT5XG4YEW/3qLnBXnYdaPVxAihXYVZfZ470fTy3NtgZueg1TyOJnH3RPru
	 3XrLMhHcX9oDpZvtSF9WQcwxx/GkJsSNEqFxiCYDv02AD9EFMBQel95dMaFVeDO1Tgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639183;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xfyG+brxXPThU8lVFwnvwuLj2F5gumMuYpNUfRT4vVY=;
	b=lSR2gxnBaLVc0Gcj59156iN4B77YMqZfLpwYIOcetzb3qi2eHridG0um9CmPdyXb1Clc
	 BEk6ipdZKsAhkvhZY0frigmfIWndB6RU8Kh/3MHAj9yxZI+Zy8pjh0YM0AMA18pL7goiy
	 H20hhZUTda01pq2uWNNPDC2ChLpAPAyQcj7nPVaAEY0AUmq3/E1ZwpXOpWtyd6SRxg+oG
	 UnjzOKnaYZcltnjvMYSmtbXntH6Sgr//dtCxTWSMDjTKHXBApwxYHy5yYiZfWPI8QCRai
	 wGAJFrw/XhYqKMXiC6J8rgdogJ2vrkUtrPuhjJnzb92xzShSdFzVJF8Q6FfDYla3h3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X2Yj3E3Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8FA606A33A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X2Yj3E3Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9E41F000C4;
	Wed, 25 Nov 2026 20:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795639182;
	bh=xfyG+brxXPThU8lVFwnvwuLj2F5gumMuYpNUfRT4vVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X2Yj3E3Ylado4wywulfog6+AqepKQa2VgF6/oNWBJrrIbvQk+VHkkkAWy3MmWXrco
	 9RNC3bDtNZzrdcjKD953+yDQ2znlivKULeBtkDvxTGvZuWndHq/jQtQyc3jXIadRiQ
	 f995PKsPREm0fXZMt9wehe5bFV2QpYpdf1YK+YJ3mrF87jt1iMOe5lkZyr/xElglkg
	 F12dpbpbI8ee43ZSIALJejgtfg5CpHv4/IFzZcDkwuzRrcY4dfJZvHBR/47odsBqin
	 HQrE2FkJvLNhQpUBtyJarD7c9O0iVVuoQQTYhZPZf3qG7CDeJgvMdIVPWKGN8NCkTn
	 0G3CU98/X2sww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] wifi: mac80211: remove SMPS from AP debugfs
Date: Wed, 25 Nov 2026 15:39:40 -0500
Message-ID: <20261125203923.1418678-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112508-leverage-contents-d7bd@gregkh>
References: <2026112508-leverage-contents-d7bd@gregkh>
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

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit 586100ad85fed0041e203d6006d45e0ec4c5a0b4 ]

The spatial multiplexing power save feature does not apply to
AP mode. Remove it from debugfs in this case.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230301115906.01b167027dd5.Iee69f2e4df98581f259ef2c76309b940b20174be@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: 745f5d04395d ("wifi: mac80211: drain link readers before stopping removed links")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/debugfs_netdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index cb82b7966d374..c3586ebf5bf54 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -708,7 +708,6 @@ static void add_sta_files(struct ieee80211_sub_if_data *sdata)
 static void add_ap_files(struct ieee80211_sub_if_data *sdata)
 {
 	DEBUGFS_ADD(num_mcast_sta);
-	DEBUGFS_ADD_MODE(smps, 0600);
 	DEBUGFS_ADD(num_sta_ps);
 	DEBUGFS_ADD(dtim_count);
 	DEBUGFS_ADD(num_buffered_multicast);
-- 
2.53.0

