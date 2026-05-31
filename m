Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7614D1FBEBC
	for <stable@vger.kernel.org>; Sun, 31 May 2026 00:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780187047; cv=none; b=BfNMWE+3F2Rfd7j5vOs2Lrrcacf/iFYyuWAyb1P+tw34gqES0MhxtX3o6ztgJN69tsQ+ACUlwD9EKvkrI14RHqjEV6oFoWH2ohLXvegVRjgJBnTWD2tggYydEAwS2Eyo0+2bnpI6nsWz3QiHYP9zO+w+06jEuxb66IWDdRjXwmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780187047; c=relaxed/simple;
	bh=V2wMmY+ziECuo+ZVMX0Is0ehvCTFt8rBs2JRt3NQRI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbwr9BatZPNn0bWK0BYEFQ/ojQXGgteQ+1k5Rnq108rA05DcCpRvJEwrh2jIPpIOGfLgsalUZc/hb38PYb7BAigxA/y5m5qz504/o+LYLE9KcLfHNWnX7AxJUKIafMzV24ibuPaTABhIHk0jYJX6JG+tqQLa2Bt4JjYGA05+3zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/Q+UEjr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/Q+UEjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2471F0089A;
	Sun, 31 May 2026 00:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780187046;
	bh=ZWxW+FuiWo7R5oKyWP/wXYVyY3RuDeHwFIJM5xWkiNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q/Q+UEjryswS1WsT9IOqLIWOscmKPm2SjW2gGzPQ2DtklWCqDKiYh9efD/wbS2LAh
	 en2Xc+dsfCEwnREaPg+FuOmmaTOwaechNaSW6wooJU4ai914VNxhAu3wcIhVneHb3B
	 CxNh2B6e4/QDYx9JTSyFjcLqDDfe8Ou7/S5kly9B5pNXN6tp1f8OQZH8qzDHLxWxSq
	 UAJ/IoYJilOm4O5j08dOsBu9EY7yHy3EzmXVBi/bNHyUBZ70uwWgFuGm4ApFlvFGOL
	 9ne6I+7MNaLKdefSgjobPZzbj2yUjgJYmjNRscIVnHq51OJr+OqghqKAjjsYqZd4lI
	 u51lWpB42C7EA==
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
Subject: [PATCH 5.10.y 3/3] octeontx2-af: CGX: add bounds check to cgx_speed_mbps index
Date: Sat, 30 May 2026 20:24:01 -0400
Message-ID: <20260531002401.3659638-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531002401.3659638-1-sashal@kernel.org>
References: <2026052833-reuse-denial-9a59@gregkh>
 <20260531002401.3659638-1-sashal@kernel.org>
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
index a0ba4e00226db..7511745d65d82 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -669,13 +669,18 @@ static inline void link_status_user_format(u64 lstat,
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

