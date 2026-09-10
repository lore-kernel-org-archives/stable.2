Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A395F45D93D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038510; cv=none; b=u9XBW7sG7qG6bGhvMranGP0qYR5Y9wlgJfeSlcTqQgGBl0zpBo5xXSmNMKFqCPkOxWoIdwflL4+89Wzs/PoCVY5+Dx6vhH3w0oLZtuN/B6rt+lmNH+ZaB2ZbM3+3my6xUDLHm28DAMUz/iPQIa/7INSFWf+uZzqKlYtd0Fh9sHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038510; c=relaxed/simple;
	bh=l5Y6v3ywSl5qEDZA4jSERBVtKRf93AfqXTboFtzYAVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YV/x3HEv8fxxwTTbFhddvDlVxit3mwvz9IPhH6AcfWK+3SCN9U1j8tmtqqQ4DWIAEo8/M/yTMwvyUrneDUuDaOlKGWpjIIYUr3czgll9bQSzgOqM2ZOZ9513CDpZyvOxLKJlGONB57CfIUaEmagBGXOuIbcMQ8E/t+lNoxLgQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0zFm1fU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0zFm1fU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC691F000FF;
	Thu, 10 Sep 2026 11:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038509;
	bh=eUTognOpRQhN6p0Q/wSnnzTRsmkRx0jBm1182BbpR3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o0zFm1fUE+AGr01QdBeCK/Mzf+5+T1N22JeR8gb7i6amGAXdjBGwlXYTrabX1HhIF
	 Wvd8coWY50YTZyBqhWNTpMnPsk14iEF2YJMVib6YoiF+9t9YXhXBDPz1DUmkNLh+b2
	 sF+g2nDeFlSMWpqkea1Uq83yu49Wl6+99aOQL/tKY1vX1dz4mw9z5MObrzQ/T8B565
	 9Vj5CFbJNbUD/Dshp9V4CPLoUQtxifbtA3TUzzbBzkMl7X6j2gBjEJT3kfz7WlmKR/
	 znywBsrch2rPOgPdCu1ponXEHJHl4BQXY1FcDWUVN9A9Mkw38t/1vLEMlOs4SZ453g
	 FWDN5hYN/CBtg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xing Song <xing.song@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] mt76: stop the radar detector after leaving dfs channel
Date: Thu, 10 Sep 2026 07:08:25 -0400
Message-ID: <20260910110827.4144315-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090458-lion-librarian-5f33@gregkh>
References: <2026090458-lion-librarian-5f33@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xing Song <xing.song@mediatek.com>

[ Upstream commit 4e58ef4b6d727abdb071f7799aef763f8d6f2ad8 ]

The radar detctor is used for dfs channel. So it will start after switching
to dfs channel and will stop after leaving. The TX will be blocked if radar
detctor isn't stopped in non-dfs channel.

This patch resets the dfs state to indicate the radar detector needs to be
stopped.

Signed-off-by: Xing Song <xing.song@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Stable-dep-of: 44b5adfe4949 ("wifi: mt76: mt7915: bound the device EEPROM address before the EFUSE copy")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index defa207f53d6f..f71889ff49741 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -277,7 +277,8 @@ static void mt7615_init_dfs_state(struct mt7615_phy *phy)
 	if (hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
 		return;
 
-	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
+	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
+	    !(mphy->chandef.chan->flags & IEEE80211_CHAN_RADAR))
 		return;
 
 	if (mphy->chandef.chan->center_freq == chandef->chan->center_freq &&
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 6495d2edf7dc4..edab58fdc13e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -212,7 +212,8 @@ static void mt7915_init_dfs_state(struct mt7915_phy *phy)
 	if (hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
 		return;
 
-	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
+	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
+	    !(mphy->chandef.chan->flags & IEEE80211_CHAN_RADAR))
 		return;
 
 	if (mphy->chandef.chan->center_freq == chandef->chan->center_freq &&
-- 
2.53.0

