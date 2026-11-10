Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347153;
	b=c5oCPmSZaHNaBptKgCBlbmbD/I8pKAaT7ShLasgpUvR4E7iJ5fzt7JQKYQopHRJmgowN
	 LWHGFRBHcm3Y5IeeWT0kYE1ovKclfALdoOBEf7L04/m8eyv87hWi89kayKER9+J+Y8FkZ
	 V7bwsDheKFjPDuIyhnAUboKPtexE69LOMt5nW4mpNq45C5se0nnbPVwro4ykoPtqCMkxH
	 ZlGEjWePw7vjNJZPCMOhr0Vh95BGjRbkCRTwVdtRls0gqrtW8YGtMby+yNHYAhiMEEh+i
	 iEI0NXhdn6ggiPtFjenkDuJW5LAr+k7sVacIOdouDKSS0uVBWYNP/UOuCDrDEfUS6Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347153;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IubW3Vzlg32JG5B/zU026CYy9jqdTCB8yxM6yTEAnmI=;
	b=hlxDGwCXqoRn0bKR/aKjT+Jv3HkwT0hshkzw5XCrVD7vjfabUB+DxYTjcbH9f0n5e9lL
	 VgFhFlQo381CROOh1TvgCQgbhqVUOD1+AsWtL7M2MCaRtWEtvsBHHMFLCZ+8Uugoa4yf3
	 ZRjHElki4JmRppIXqJkVB6HeAmwkDrbBRxvk196svuBYGitAdVRo9H9YgUdThPFcRAvMs
	 z+7oRy2IAZRIc0FbeDjXvOMe621bcJTkGPOTv+nGhmiu508AkKMuMML/FL7zU8+J0xWWc
	 O9zJvhbKlnyn4j0qCxvkdf4kxnsyt/l6bsN3F/gGLXznTJDcojW3FMQqA7CY3rfVMuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6i1ZKrr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0E606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6i1ZKrr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798FF1F008A5;
	Tue, 10 Nov 2026 21:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794347153;
	bh=IubW3Vzlg32JG5B/zU026CYy9jqdTCB8yxM6yTEAnmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H6i1ZKrrc7cKRvwcPk+BL2fG8eSd8dnHFI156FBWfYQ9zGKV2azoi1txyM68v6hXr
	 Rel22xk/1C/dLTlAoyAdCrFqIInmAzJ4moFcdSifZNHOmsNSZWXZ/Va/JAMM/arEqO
	 6ahYfVPosLogBfQsrFC7q0MucyucQcTwuaZA+cL0QQDHgk7UYu9nn1p7GQPC3O2Z3Y
	 Eiv4tN5qTiApsDkGXyXdcxUZGkykPC0U1SQd3ekBcHb/n8MNpxv7wYEU31C3PETPt5
	 y0dIz94y8WgyqoVR2E+nsrASeXianUGdeeWJ0hakuSz2OqhDOEgqlSLCDoe+MeEg0V
	 PH3d6K6liyTlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>,
	Nick Morrow <morrownr@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] wifi: mt76: mt7921: assert sniffer on chanctx change
Date: Tue, 10 Nov 2026 16:45:50 -0500
Message-ID: <20261110213540.3913326-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050919-failed-6.18-68342a7bd7e5@kernel.org>
References: <20261107050919-failed-6.18-68342a7bd7e5@kernel.org>
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

From: Devin Wittmayer <lucid_duck@justthetip.ca>

[ Upstream commit a7d35545c2ce11849de4b4397abaf664d79acd28 ]

mt7921_change_chanctx() configures the channel for monitor vifs but
does not re-assert sniffer mode. mt7925_change_chanctx() does. Match
mt7925 by adding the missing mt7921_mcu_set_sniffer(true) call,
completing the architectural pattern from commit 914189af23b8 ("wifi:
mt76: mt7921: fix channel switch fail in monitor mode").

The user-visible regression this asymmetry produced on v6.17 and v6.18
was addressed by commit cdb2941a516c ("Revert "wifi: mt76: mt792x:
improve monitor interface handling"") in v6.19 and backported to the
6.17.y and 6.18.y stable trees. This patch is defense in depth in
case the NO_VIRTUAL_MONITOR change is reintroduced in a future series.

Tested-by: Nick Morrow <morrownr@gmail.com>
Tested-on: RasPi4B, RasPiOS 64 bit, Alfa AWUS036AXML mt7921u
Tested-on: RasPi4B, RasPiOS 64 bit, Netgear A9000 mt7925u
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Link: https://patch.msgid.link/20260515183921.23484-1-lucid_duck@justthetip.ca
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Stable-dep-of: 68342a7bd7e5 ("wifi: mt76: move the channel survey when the channel changes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 35ece0f617337..1e9070a010345 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1405,10 +1405,12 @@ mt7921_change_chanctx(struct ieee80211_hw *hw,
 	vif = container_of((void *)mvif, struct ieee80211_vif, drv_priv);
 
 	mt792x_mutex_acquire(phy->dev);
-	if (vif->type == NL80211_IFTYPE_MONITOR)
+	if (vif->type == NL80211_IFTYPE_MONITOR) {
+		mt7921_mcu_set_sniffer(mvif->phy->dev, vif, true);
 		mt7921_mcu_config_sniffer(mvif, ctx);
-	else
+	} else {
 		mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->bss_conf.mt76, ctx);
+	}
 	mt792x_mutex_release(phy->dev);
 }
 
-- 
2.53.0

