Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766D51D435F
	for <stable@vger.kernel.org>; Sat, 30 May 2026 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151211; cv=none; b=XqB19F8LpMNi0jKaORO/lbF4t/8fmgRYvG8vPfXkf1ma3zcE5CH/0HRN6QE6Yb9mlU5AlBv2uItm3Ew5kDbeXQ9pvwtt/KohqUjor+TzwtgZLD5Kcb98vwh5kakWKPMfdEzY671g5la7/YuyS0+QiZY6n4Qzk6gWAnNHbd2MusI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151211; c=relaxed/simple;
	bh=T4ZXHWlN5ixDAc2gSY30sW4vUzuv1hguEf9dhUdqZYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1EmgsHAY2is8vnXmqmd1rcjOAGZUoOz7rB8GtzyIExsMrr009xc6iQkTicIlb2wGYxoR2xkWpu6GY3Yt9twroU0Zct/oVuVA24Lh0H7Q4ZDuA8A2iJDTl/iJQ7QdOqA8As5Q8/CsltzZbwQOslDAtNFVHV6rKctsaI+les2Hcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fB57PKGF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB57PKGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0836B1F00898;
	Sat, 30 May 2026 14:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780151210;
	bh=g6jM+6HHWFmT61jww6Lb0rmxC80swuzhCVN9is//yKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fB57PKGFOUmKt5JouAVBLdlEasjiEXdCFQTGn0HVSwbKq2kaAtXYAk4W/iCIy0olX
	 y/FDS1m2lMu3gLRD4KMgJ5DoiSZKa8GFPLAXfoVOwGg+nwL1O274DdPjPrG9ImWadg
	 iV0OirW+P1TRVZtffRnVlcRnUZaDQznyKJSEgqG0hO89G+8A5ynrCnOb7r4uVoYdOU
	 Lx2J2FxSY/N4QmBCroeanVuipld4VNLrsKoTdZQvkkXm0RJ3ueZJJbzOFLXu3P2bWs
	 lwvzqMnLiFPXh+12lW4NWZygd2GWbTU1LVKUm25QKLpLXBE1+2EWuJirzxrRGJ9oE+
	 hVobTrt9Y9KZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sam Daly <sam@samdaly.ie>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] octeontx2-af: CGX: add bounds check to cgx_speed_mbps index
Date: Sat, 30 May 2026 10:26:46 -0400
Message-ID: <20260530142646.2429080-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530142646.2429080-1-sashal@kernel.org>
References: <2026052830-proofread-ludicrous-154a@gregkh>
 <20260530142646.2429080-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sam Daly <sam@samdaly.ie>

[ Upstream commit c0bf0a4f3f1f5f57aa83e1400ba4f56f0abfd542 ]

cgx_speed_mbps has 13 elements but RESP_LINKSTAT_SPEED can yield values
0-15. If it returns a value >= 13, this causes an out-of-bounds array
access. Add a bounds check and default to speed 0 if the index is out of
range.

Fixes: 61071a871ea6 ("octeontx2-af: Forward CGX link notifications to PFs")
Cc: Sunil Goutham <sgoutham@marvell.com>
Cc: Linu Cherian <lcherian@marvell.com>
Cc: Geetha sowjanya <gakula@marvell.com>
Cc: hariprasad <hkelam@marvell.com>
Cc: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: stable <stable@kernel.org>
Signed-off-by: Sam Daly <sam@samdaly.ie>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026051352-refined-demise-e88d@gregkh
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 394061a3d38c7..d415d5dbc1104 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1286,13 +1286,18 @@ static inline void link_status_user_format(u64 lstat,
 					   struct cgx_link_user_info *linfo,
 					   struct cgx *cgx, u8 lmac_id)
 {
+	unsigned int speed;
+
 	linfo->link_up = FIELD_GET(RESP_LINKSTAT_UP, lstat);
 	linfo->full_duplex = FIELD_GET(RESP_LINKSTAT_FDUPLEX, lstat);
-	linfo->speed = cgx_speed_mbps[FIELD_GET(RESP_LINKSTAT_SPEED, lstat)];
 	linfo->an = FIELD_GET(RESP_LINKSTAT_AN, lstat);
 	linfo->fec = FIELD_GET(RESP_LINKSTAT_FEC, lstat);
 	linfo->lmac_type_id = FIELD_GET(RESP_LINKSTAT_LMAC_TYPE, lstat);
 
+	speed = FIELD_GET(RESP_LINKSTAT_SPEED, lstat);
+	linfo->speed = speed < ARRAY_SIZE(cgx_speed_mbps) ?
+		       cgx_speed_mbps[speed] : 0;
+
 	if (linfo->lmac_type_id >= LMAC_MODE_MAX) {
 		dev_err(&cgx->pdev->dev, "Unknown lmac_type_id %d reported by firmware on cgx port%d:%d",
 			linfo->lmac_type_id, cgx->cgx_id, lmac_id);
-- 
2.53.0

