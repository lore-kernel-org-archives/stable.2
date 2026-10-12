Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055C62E8DEF
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811941; cv=none; b=igBIS+59RA1Sem2Q77V/gyNX7mFN7LcP2OCEvZ0M/RYRi16nHp1K2VszAu+NSJ14JE963pxy8L2R+e5fAfwnmaDnP6c+alEfs2JxoZ7/Bw2+DJ4nOSNLWo4rKF3eYMofvC1TNwijBT+UfTXhEG/ug9IfWg4/yyaw0fV6lBIK6jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811941; c=relaxed/simple;
	bh=M+7BOMAz3xgu8Dz08Fj2P8WTKOk5kjfAtNkagreBsnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHP/NjkQgF+/gKDl/C7njDQef2m6ka/OkvWkZk4jZ4N6cH55KhyI8mAIxTc8zjxA0NoCoOt+rQWSxQYfn3YhealQ1G51XHHotpnO6urxDlHYiguIohSE8vXQ7kF3DC6hjRHIg5WINTJ5TUOJ8WI+V94f4gSWaWMTNvoqlpxiAdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIpKqikD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIpKqikD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C264C1F0089E;
	Mon, 12 Oct 2026 13:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791811939;
	bh=jepTEXwSC/lNNIgxw5eX01lPneldpI657xNuer1rrV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HIpKqikDCEOMG0tTLtf2Lgw1lY3jUGNP03I9SZ9UjehWh4pIOY2Q726OvApkZIlZ8
	 IXleJrcB5uPLimdQyvH8p8Raap7vgFUX2CAXfChp65rtpKhbCQ/hb+uxd4e7VfpxEb
	 eIIbMQGNboRKFFCGhZIx3Iv5wFy5WAvmoYh5yTuMSKWj1mhd3crIv6PqTa4JLA7xdM
	 WIAdpy0DIcLSj6zOQS8kT3WlMNcSQbpI79oUR961h6Ju7lkOpyvF5drQzBWIeOslv/
	 1GTaTCpY6oksXApa3fILLxuohZHHC3WM147pL/95Yktl+sMAmsg/EAfajyKuJPGdD5
	 6fNfIffZJZPSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mohamed Yassine Jebabli <med.jebabli@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ALSA: hda/tas2781: Accept V1 calibration data without CRC
Date: Mon, 12 Oct 2026 09:32:17 -0400
Message-ID: <20261012133147.187215-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101238-chrome-recount-a048@gregkh>
References: <2026101238-chrome-recount-a048@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohamed Yassine Jebabli <med.jebabli@gmail.com>

[ Upstream commit 408249089c48df1a4d23f60b831be3f3c311e6d1 ]

Some Lenovo BIOSes (e.g. Legion Pro 7 16IRX9H, SSID 17aa:38cd) store
valid V1 calibration data in the CALI_DATA EFI variable but leave the
TimeStamp and CRC fields zeroed. The driver rejects such data, so the
amplifiers always run with default parameters on these machines.

The rejection was silent until
commit 4fe238513407 ("ALSA: hda/tas2781: Move and unified the
calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
turned it into "V1 CRC error".

The stored values are consistent (R0 = 3.82/3.83 ohm, 1/R0 matching
within 1e-4), so accept V1 data when both TimeStamp and CRC are zero
and the first device entry is non-zero, and emit a warning.

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Cc: stable@vger.kernel.org
Signed-off-by: Mohamed Yassine Jebabli <med.jebabli@gmail.com>
Link: https://patch.msgid.link/20261001-tas2781-v1-nocrc-v1-1-ff0c1032ce76@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ sashal: adapted the CRC error-path change to the existing success branch in tas2781_save_calibration() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/tas2781_hda_i2c.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 980e6104c2f3f..01765a6a00f2c 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -479,7 +479,17 @@ static int tas2781_save_calibration(struct tasdevice_priv *tas_priv)
 	dev_dbg(tas_priv->dev, "cali crc 0x%08x PK tmp_val 0x%08x\n",
 		crc, tmp_val[21]);
 
-	if (crc == tmp_val[21]) {
+	/*
+	 * Some Lenovo BIOSes (e.g. Legion Pro 7 16IRX9H,
+	 * SSID 17aa:38cd) store valid V1 calibration data
+	 * but leave TimeStamp and CRC zeroed.
+	 */
+	if (crc == tmp_val[21] ||
+	    (!tmp_val[20] && !tmp_val[21] && tmp_val[0] && tmp_val[1])) {
+		if (crc != tmp_val[21])
+			dev_warn(tas_priv->dev,
+				 "%s: V1 data without CRC, accepting\n",
+				 __func__);
 		time64_to_tm(tmp_val[20], 0, tm);
 		dev_dbg(tas_priv->dev, "%4ld-%2d-%2d, %2d:%2d:%2d\n",
 			tm->tm_year, tm->tm_mon, tm->tm_mday,
-- 
2.53.0

