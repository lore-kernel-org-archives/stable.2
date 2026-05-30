Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAE22BE033
	for <stable@vger.kernel.org>; Sat, 30 May 2026 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151863; cv=none; b=tEYJEYH5G5NYzq6VgS1s1x7+Q0WEIyP24fh11rzpLEEtgkX6qVPv29xU02zBjrupVMg63DwN8e6UfwIY4m+TGlZqJVHF2RkFWncJYePt1x6R8XJKUwc8DwSCQoyLbyvkNdo1L8V8tsPR8F3B+EQQc721CGCLoCceYZmoSHYts/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151863; c=relaxed/simple;
	bh=0lM+e6q7Hz5EV2pwOFqLr0f2BqYgWv9TEM0tFJ5rbok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/kEUiCsnKCjqZhkv0h7sl+qTxRFVUZYCqbHAa28B7idUAGIjlDgaCayyBdJCKJ0UjsfJYRuQ39EVsWzwI16Gy0q9NH/HMMZwl8HGu3svYPg0/MUo9z0Co5HN1h+/pgc5uxSMNLIMfrD4TI2dpg3jBl/lLosZNl866NxZb9FmAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2WCsxRL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2WCsxRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5041F00893;
	Sat, 30 May 2026 14:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780151862;
	bh=0Tnt3iD46f+f6WWpqRtTGA8Pb6XAzGuEBXGVBrM4MeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X2WCsxRLTCOVe9nwO+H9lsNZUYYYR5pe03sN8mhUtvjntRQpVSTU01Ncg1kfOpWZH
	 2FV7QqxJfrFUa1OKDVvsX6JMpbKVJw6xAs1GRDtcMU3hEnkPtrVMuNU0ADZCbhdCLI
	 wqXFtcoYy/UAR4MibFucw+QU4ltmako08YY3Z3OnVGJpCgd0t/t+L/gVnWG7scTjlQ
	 8f9elkG60B12VaZfConU/p0XItzUgq1GEGtzhPNgv7egtbtMXSovX0Zb0b0YxxqOWu
	 bcHU0+eHkZhG0o551YtkcHH3TVC54T/ZRAbaJ6MvN3QEblOkLR+Na3ursNPlvyYWIL
	 ADUsv1v7gKAvQ==
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
Subject: [PATCH 6.1.y 2/2] octeontx2-af: CGX: add bounds check to cgx_speed_mbps index
Date: Sat, 30 May 2026 10:37:38 -0400
Message-ID: <20260530143738.2474980-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530143738.2474980-1-sashal@kernel.org>
References: <2026052831-chair-shed-69f0@gregkh>
 <20260530143738.2474980-1-sashal@kernel.org>
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
index 0d8954f934b42..d28dfe11227b9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1228,13 +1228,18 @@ static inline void link_status_user_format(u64 lstat,
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
 	linfo->lmac_type_id = cgx_get_lmac_type(cgx, lmac_id);
 
+	speed = FIELD_GET(RESP_LINKSTAT_SPEED, lstat);
+	linfo->speed = speed < ARRAY_SIZE(cgx_speed_mbps) ?
+		       cgx_speed_mbps[speed] : 0;
+
 	if (linfo->lmac_type_id >= LMAC_MODE_MAX) {
 		dev_err(&cgx->pdev->dev, "Unknown lmac_type_id %d reported by firmware on cgx port%d:%d",
 			linfo->lmac_type_id, cgx->cgx_id, lmac_id);
-- 
2.53.0

