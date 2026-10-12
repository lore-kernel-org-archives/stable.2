Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E3E37FF56
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810979; cv=none; b=uQt+kLEdqKMfP5nVoHuhTvJGJX+Jt/2YLAWFZchmWHa11k4tk0cByzielv4HluwqecTybLc/HdKIF02sczdumFOTw2leYQjrmMlv8IB6/NUeCIh55S493uowovW6sDOsnKAEqQWgOv6p6V1JihL6MJidJbSGuvA6W+sRZkZPhvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810979; c=relaxed/simple;
	bh=IAbi1b3rGFaG/NkwtSAuTqsR7WjX7zY1WTqXahF2uIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZeuXuoiFlot0R2u4KokddFjl+ZFrEoOnwA9oJFTxPLqJSd0kdm3Tg2o8vxXUETydf2T8j913+EML/18zsXNYHLe8dMaBw3HC4gMpVz2TSp4OdxOsxWJCziiOLlayjv1mkqNIgSg2osUS6L/vDzJnGq7EG+sv+zwSTjF0Mqnn4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9ghqJ8M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9ghqJ8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137491F0089C;
	Mon, 12 Oct 2026 13:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791810978;
	bh=2RPJKJxA3bjMx6MxsZnjEuwJQVnyUkzGs2J48xh5Imk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M9ghqJ8M6XAcwFKcPokDnTZegaIs0OLBw2OmYoyEkLdKjIeQIUJX71X21WXji9zTl
	 nnzlWGn00EXxGELo4EmaHtt1VJaNny8hZ+OyEWa7WRkaThR+Wm1CnMvHzukvVceeLB
	 bi3792JsbnJY6wqUxoTpufizU4M4J3DY+29V/w2BDFqg73LTQdC+/z3bzFgV+4POpR
	 jj8BsIpM/o0RNApgD3lmOb4RC3Qb2/oIB73oXAw4ndQ86idFVYqVuFgKgdOwyOCp9r
	 SAZ0VvvAG41brH86QlV90jVngHUjvP8tRCj1CxPqC6Vqvky9QkT2mqaRcmOGRE0Lvt
	 pEWOPJ8KTOTTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mohamed Yassine Jebabli <med.jebabli@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ALSA: hda/tas2781: Accept V1 calibration data without CRC
Date: Mon, 12 Oct 2026 09:16:16 -0400
Message-ID: <20261012131541.4072020-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101237-bridged-landed-b387@gregkh>
References: <2026101237-bridged-landed-b387@gregkh>
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
[ sashal: adapted the shared-library CRC check to the existing tas2781_save_calibration() function ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/tas2781_hda_i2c.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 370d847517f9a..5acd06ad9dd86 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -585,7 +585,17 @@ static int tas2781_save_calibration(struct tasdevice_priv *tas_priv)
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

