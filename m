Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836883FFF8E
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701058; cv=none; b=oKZIBU2Gw0ebDeEI4uMFtst3oX/ksWFdLQDffWGJCUHowtJ28Jpb3wApZAY5N4s+8ffk+b20Ei9yH/QGLTFQc8RgSFqDqVSVEOoU8/H/OXykdstwyxnC5AQtWyR+Ce4EkEsum6iXhwJWWJ/bjVW6z2CTREJeFKIay2esjhq+12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701058; c=relaxed/simple;
	bh=zBkIDkwpeiX1YuZUk4Qh4XG2Dxbiy/StczdxkWlmQnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gV0hRRzBwIXIKAl2SrjWdncgrAC1HnZbJnV4ciK8FgKsQNt7DUlo0mhFOyH7La8yTOWUDM3yTIeU6kHy+FhM6pn4LOMc6dd+Bbz9Y/jVjxvG+qnIOsmsgcXZ2nuEh+WSdF1UrUcANlvpuk6w9O3lyxeZXmBugViy6jIpQKqVsbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from ajratkogda.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	(Authenticated sender: ajratma)
	by air.basealt.ru (Postfix) with ESMTPSA id BA751233A9;
	Wed, 17 Jun 2026 15:57:28 +0300 (MSK)
From: Ajrat Makhmutov <rauty@altlinux.org>
To: stable@vger.kernel.org
Cc: 'Sasha Levin ' <sashal@kernel.org>,
	Leon Yen <leon.yen@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	David Ruth <druth@chromium.org>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 1/3] wifi: mt76: mt7921: avoid undesired changes of the preset regulatory domain
Date: Wed, 17 Jun 2026 15:57:12 +0300
Message-ID: <20260617125714.1663242-1-rauty@altlinux.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260610080943.17734-1-rauty@altlinux.org>
References: <20260610080943.17734-1-rauty@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Yen <leon.yen@mediatek.com>

commit 2425dc7beaadc39c2636f97f8bdc22dc3cf88149 upstream.

Some countries have strict RF restrictions where changing the regulatory
domain dynamically based on the connected AP is not acceptable.
This patch disables Beacon country IE hinting when a valid country code
is set from usersland (e.g., by system using iw or CRDA).

Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Tested-by: David Ruth <druth@chromium.org>
Link: https://patch.msgid.link/20240412085357.13756-1-mingyen.hsieh@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
(cherry picked from commit 2425dc7beaadc39c2636f97f8bdc22dc3cf88149)
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 4bd533c4ba9a1..276dfb9c26e0d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -137,6 +137,13 @@ mt7921_regd_notifier(struct wiphy *wiphy,
 	dev->mt76.region = request->dfs_region;
 	dev->country_ie_env = request->country_ie_env;
 
+	if (request->initiator == NL80211_REGDOM_SET_BY_USER) {
+		if (dev->mt76.alpha2[0] == '0' && dev->mt76.alpha2[1] == '0')
+			wiphy->regulatory_flags &= ~REGULATORY_COUNTRY_IE_IGNORE;
+		else
+			wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE;
+	}
+
 	if (pm->suspended)
 		return;
 
-- 
2.50.1

