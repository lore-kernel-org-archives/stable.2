Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FA4230264;
	Tue, 28 Jul 2026 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246278; cv=none; b=elyDNOJ1B9ba5AvAFPeLOiEHfCV+zAPH2WIMOBas7O+TzOj8x/7ugbWEYaG7nkfn6gqZid35xXMertxIKcRIoVfXwvRM8/Wq0MKD8xuy9gBw6two957k1B9hYMno+xRJPN5a625EhAaleB1F02qE422Zeo1onpw2yj3qRK++fyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246278; c=relaxed/simple;
	bh=7grSyy01LYwEHxMJ6KwCO2SXAjkGgOkzGaheLTd2H78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhjywavXmF2E/Jp0nVdwZPXDlOZtNtsB7xzZ+VnlDAdTelKuUdSy/nC6erwS0mdycz8Hu5GROie4WIcQBK2R6Z4bdbwDRy7jOLls4vXeX+AGALFvXNwF6tG6//XlfMarHuVdXlPzvlpMaJ7pWKAr7HsVgBR3t4SoREU2wpp+vC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=UTfsJxeb; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="UTfsJxeb"
Received: from kero.packetmixer.de (p200300c59717EaD808F168C97e5563a8.dip0.t-ipconnect.de [IPv6:2003:c5:9717:ead8:8f1:68c9:7e55:63a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id B3ADAFA03C;
	Tue, 28 Jul 2026 15:39:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785245960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ej5s2OSRHvIZjLqvBiyT+YuhTjdxsPjo3tAk5Fud2lw=;
	b=UTfsJxebQ2IK86DRs+eGMNdjQQ3beetuBKBJjEMKfmK/FmS1Oxjlrm200KS/HHlxMPloSn
	5GBVwbky6iplqQn2M0l+FKB5/H7SRc2Ub5/l3CGNng9dP1nwuBoh2p25aO4QXGJ1Q37HZU
	/5ScNNkpJox4WnY+edBqMjWv/+0TGoN9AAffWGI8f3QeCeFpMtUw3TpeI763jiDCCteI2Y
	aDfs6NmkFF+vgHWWrG2r8E5tW3wGfkgTxb0Q8SwF9y8K4RsysoktyuwA2kfx/E0uyA0wMh
	k/qG2pp6SGpbIJEuzrDRnBaNjI7qFb4kk6Xq42vQ/N1BkTENBKX+3V3tkBi0HQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 02/15] batman-adv: bla: prevent CRC corruptions after claim flush
Date: Tue, 28 Jul 2026 15:39:05 +0200
Message-ID: <20260728133918.643267-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728133918.643267-1-sw@simonwunderlich.de>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

When batadv_bla_del_backbone_claims() tried to remove all claims of a
backbone, it sets the CRC to 0. It assumes that the it had the last
reference of the claims because batadv_claim_release() (which runs after
the last reference was released), is XORing the crc16 of the claim address
with the backbone CRC.

If there would be a parallel holder of any of these references, it could
happen that the backbone CRC is (0 ^ crc16(delayed_released_claim)). Which
is the wrong starting point for the new claims it may receive when the
remote answers the claim request from batadv_bla_send_request().

This reinitializations can be completely dropped to avoid this problem.
batadv_claim_release() will take care of fixing the backbone CRC.

Cc: stable@vger.kernel.org
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 79c482d24d9e3..8ee3ec5eb2c5e 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -324,11 +324,6 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 		}
 		spin_unlock_bh(list_lock);
 	}
-
-	/* all claims gone, initialize CRC */
-	spin_lock_bh(&backbone_gw->crc_lock);
-	backbone_gw->crc = BATADV_BLA_CRC_INIT;
-	spin_unlock_bh(&backbone_gw->crc_lock);
 }
 
 /**
-- 
2.47.3

