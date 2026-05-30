Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C47313E34
	for <stable@vger.kernel.org>; Sat, 30 May 2026 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780171665; cv=none; b=DzA0JKxYFQKBiDaWyXDLRoB+d6CZq/TXuhWXN0h6zP653qruBbweQ/4TbfTOF7ZXouzfFap6KeG6zS68Vp/ojy71cYwCnk1TweBhTgDO488wZP0Pfl4pHSh4huvM30gK1j4d/yGpeWNZ6+9+nFFqLC+EAHBxcO5KS5cBxgBKEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780171665; c=relaxed/simple;
	bh=LFot29Qw6CRWP8SGoS7eQ4rjaq/Uwo2oU9EYJY1uaBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyelTSIPfbyAPRIkQ8axqnrGdYGyDJXSl1U1wVvMZRDzEOWbIxihqFsjqG1wFaQLhBuNKBaY+UJlV+tF5PdPEeb3IlJAmSx0RUFaHiWksXCIMvxRuQ4wZ/xxfU57lgBIXGdW5oLFiiRUXPsC64xi1++zAQ6d0oRrV6DYAklJt3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W66M3aZs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W66M3aZs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D52F1F00893;
	Sat, 30 May 2026 20:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780171662;
	bh=ZoDutvNpSkZHU5p2AGcxtX0W1/mJFeSkqhEBm8eDRjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W66M3aZsdqPn6sqe+/g/I1ngYy1Sxos0wdNxnIt7UkzsNfgzQDO8F9mZ5lPxjSMl2
	 5Lx5ptike8O2O6xJgNyvF+on3Iczj4wOgaBbkz0H7kGLqn4EqybvZZvf969KDz+Bzd
	 jPuMz4M93F5g4WG2i1EVMRt436RRp7Kro99WVWZ4hM51vbnvE1vz2zF2u6XyIWv060
	 Rh0tTbmQuAmeuSssH3occ30LSBBPh+sObljZsnMBEdF4nhApHZJ3VzRX63Jk2bnXaq
	 e5uaS4EmHTdq35bHtxAk4/lOi2wszEXWG7TPBFQpx1M86Pkecce1TvTR6Fw8BSGp1U
	 CF6AQclniT56A==
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
Subject: [PATCH 5.15.y] octeontx2-af: CGX: add bounds check to cgx_speed_mbps index
Date: Sat, 30 May 2026 16:07:39 -0400
Message-ID: <20260530200739.3283536-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052832-gigahertz-crumb-cbe0@gregkh>
References: <2026052832-gigahertz-crumb-cbe0@gregkh>
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
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index d97a4123438f0..d926577615869 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1096,10 +1096,13 @@ static inline void link_status_user_format(u64 lstat,
 					   struct cgx *cgx, u8 lmac_id)
 {
 	const char *lmac_string;
+	unsigned int speed;
 
 	linfo->link_up = FIELD_GET(RESP_LINKSTAT_UP, lstat);
 	linfo->full_duplex = FIELD_GET(RESP_LINKSTAT_FDUPLEX, lstat);
-	linfo->speed = cgx_speed_mbps[FIELD_GET(RESP_LINKSTAT_SPEED, lstat)];
+	speed = FIELD_GET(RESP_LINKSTAT_SPEED, lstat);
+	linfo->speed = speed < ARRAY_SIZE(cgx_speed_mbps) ?
+		       cgx_speed_mbps[speed] : 0;
 	linfo->an = FIELD_GET(RESP_LINKSTAT_AN, lstat);
 	linfo->fec = FIELD_GET(RESP_LINKSTAT_FEC, lstat);
 	linfo->lmac_type_id = cgx_get_lmac_type(cgx, lmac_id);
-- 
2.53.0

