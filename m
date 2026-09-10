Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728D83DD875
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038550; cv=none; b=KwFHUJKR+bZtrJoU/wYOya0/bXJwONLEyQ94vJpoJhh+B9c/GArbwDnqZEUg+lWpVz2MRB0KDYKONRf/nJRJoz34T0haz4/IERywP+N6giyAWDlSNw+onhH9bfF2eM9B1y1zmG7HflbQaA+kMAXdONPZ30EaF/63Bxrdi3dzreg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038550; c=relaxed/simple;
	bh=K2ec5THwlhCkCQZVdxFcuLz/SGEajlrXdDRh4BeBQCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0JjUG7C2LGKzErcA09I8Ua8VOiMiXCq2fPuFbMqhM7N/I/Cq31H4ATxcWJZtSAXTtxwResasiDfiMLwIaPS/P4hhH87F04tkHFzTUAgpgn4Yl9r+ZfKyqibvNMBGbWJJc56o6WZ2JR25TVhueKCeZynMklHGrXCxBkUnAPKNAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=do0XG72i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="do0XG72i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE461F00893;
	Thu, 10 Sep 2026 11:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038549;
	bh=RM7zULERNbI5uHmHRcVyimk+4qhrIzL5Uk4M0/+hDgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=do0XG72iq8jSvWsG2jwAqj9M8XBMwgikKIiqnz04uSozmXifnm5pHwrBKA1RqBoM/
	 HKaJCdI2dYghCDGt946D99agtQoteD4JBsQ+TJXzVgn4HkRgM+EDH8rkUO9RlIf+6S
	 M3e+VAABR3smZ/eP8ghQoHKcUjo1XVNuiRK+euPebhXwXG1xQeVt97srWKK8n1sTzv
	 VOPoChhmanRYwZkCP4PdyBeqpNJ2K+D3jqTvCa2+71M36J0xTgR7Z03jYJDfPteL3z
	 FBrW/N7Kk5IWJer83suHg/7VTyKFnUD3FMqkJT3Y10gF2o2OobKiS1ge+Hh8pIduea
	 dszmX96/YQNWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Joe Perches <joe@perches.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] staging: rtl8723bs: remove commented code block
Date: Thu, 10 Sep 2026 07:09:04 -0400
Message-ID: <20260910110906.4147966-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910110906.4147966-1-sashal@kernel.org>
References: <2026090853-convent-spill-68e6@gregkh>
 <20260910110906.4147966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Aiuto <fabioaiuto83@gmail.com>

[ Upstream commit bcc84e52bcc5a9e76102b76b9d442a290a408574 ]

remove commented 5G code block in hal/hal_com_phycfg.c
which contained removed RT_TRACE log

as reported in the driver's TODO file:

    - find and remove remaining code valid only for 5 GHz.
      Most of the obvious ones have been removed,
      but things like channel > 14 still exist.

so just removed obsolete commented code.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Link: https://lore.kernel.org/r/b930cfc476c97f2ae5c5b90c1314a6270d56a539.1617640221.git.fabioaiuto83@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 99aa998dec83 ("staging: rtl8723bs: fix OOB read / stack overflow in rtw_get_wps_attr()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index a50cda70b6a79..f29f46d126525 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1784,25 +1784,6 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 		DBG_871X("No power limit table of the specified band\n");
 	}
 
-	/*  combine 5G VHT & HT rate */
-	/*  5G 20M and 40M HT and VHT can cross reference */
-	/*
-	if (band_type == BAND_ON_5G && pwr_lmt == MAX_POWER_INDEX) {
-		if (idx_bandwidth == 0 || idx_bandwidth == 1) {
-				 idx_band, idx_bandwidth,
-				 idx_rate_sctn, rf_path));
-			if (idx_rate_sctn == 2)
-				pwr_lmt = hal_data->TxPwrLimit_5G[idx_regulation][idx_bandwidth][4][idx_channel][rf_path];
-			else if (idx_rate_sctn == 4)
-				pwr_lmt = hal_data->TxPwrLimit_5G[idx_regulation][idx_bandwidth][2][idx_channel][rf_path];
-			else if (idx_rate_sctn == 3)
-				pwr_lmt = hal_data->TxPwrLimit_5G[idx_regulation][idx_bandwidth][5][idx_channel][rf_path];
-			else if (idx_rate_sctn == 5)
-				pwr_lmt = hal_data->TxPwrLimit_5G[idx_regulation][idx_bandwidth][3][idx_channel][rf_path];
-		}
-	}
-	*/
-
 	/* DBG_871X("TxPwrLmt[Regulation %d][Band %d][BW %d][RFPath %d][Rate 0x%x][Chnl %d] = %d\n", */
 	/*		idx_regulation, hal_data->CurrentBandType, bandwidth, rf_path, data_rate, channel, pwr_lmt); */
 	return pwr_lmt;
-- 
2.53.0

