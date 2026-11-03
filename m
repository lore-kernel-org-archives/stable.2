Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793698035;
	b=rznZS1+wGxVE4UwvpVrY4exIYmZZ62sJQO1M/OjlT9lxl/v4dWl5wCsf832g/GAYImA5
	 HUIyMn41d4rwGoB40uCPFk7eUwfgBoqBoHybuzG72SR6omelKJh3V75zfEDtxE8B2/v99
	 7TS7e1RD/pMP9cPX6PsaqnKMtx1IC9thDYl7piBfK7TsPRkf1MLt/thm4ABhObFDr/0pX
	 WitAgIy/eEoqugFP3ND1j9HZ+hHD6ICSGAtt/LwuBR+9gfamIezDo21yxNtgjWjDpuR1p
	 8Sj2Tr7OiwaiBLeO4j9FjTT2uazmWekb7IH06wAg9ly1T3GkmZ2Z3SB6StPPNb2cmew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698035;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wOrq6+f3nxtWdT5oOXG5uqpLCZ4DOyK+a6T74j8bTiM=;
	b=p5dFkcuoQF8IBFs+RU+miqrRKL+lG40Y4jmzmUT3iIC5xiltAe8bjqY6Jpnew/WBuRRe
	 jQCvT7+KkouCEVMoXzCEw7hs79avhyqaWh6yAFmyYNDBi1G6h1gJBkt4Zj4jQMSbki+o6
	 KLjG21tu292j0EOJDsufMK2mVmEuM3MOBBs7I6zX0ZgksJvtam2V3qbO8krEY+YXp8PQp
	 rCRVGgCamKyjsTghwWYwkgLeVILDI0vpAc/eOxW/xwsStGCDuQrFco9SYq6oxJDlxg9ei
	 lsLXGl/itxGOgZAiLMzE4cfxShWHMFkTKkYUYGzwzyLgTgF8smvKSnc4vcRxWP7wYJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a/KZ5mZ+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E77C606A324;
	Tue,  3 Nov 2026 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a/KZ5mZ+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793698034;
	b=1dWpOTW1u2rkin/onU0UozSiMmjo2ROXtxfg3gS2b3MTdXqs9LNae5hbpndyC8smgJmx
	 XavkX9jmhYCEDsP3kY4xiCFDzosyoAT9Q9y1fFvhYMHBVD3wW8D3D4prsCMEr+V/8U0xU
	 Rk8yZfLRvUavPQX9rI+HsQ33ql496Duiz7wNe7zRNyt4a62Zkl4xoWOKi/m1anlW5FrxC
	 gDM7M18pThIVIPWHZo/BJr6e7gFdXZIWZEwhdUrH/hg7kJjnSQClp7Pcky7ZyL/S4lDcU
	 ALqWkR46cJ/3Xbx1T/BFaROA/WuCjgDk9Vf45DLCyCjwZdYkDmC5hvozlKwj2dhClQQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793698034;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wOrq6+f3nxtWdT5oOXG5uqpLCZ4DOyK+a6T74j8bTiM=;
	b=OOQvSZ2XqefWZ3NpDbCI2VRZoZVZfxuBRDy1Hp++wKfxHGJ04Kl1TSi1BmEKq1lfhamE
	 0EKJz19XCsMFV32I5yc6Vcp13CK25+y7sg4Pf30L2nxru8vS/bQzSTuXHwpZ45fRlYRHc
	 d4LoJhc7GbTJH9IK0ivGKPl2JFrsomffcOyIpW61fc5PZ4jm7HzEEHSzDMislvOSs0okm
	 Klhy84pSphTILaePzeXU6Wc92t2/dLX7E3y6TKxdjYDPTSNeX/XrHK/MCOKFMh975zY36
	 32QGUJu4CgM/X+CCTJXNHa6ZJm6puiXMHa+J670BibJuIk+C0LXOrUQhXccSFtKxXYA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3B0D71F000C1;
	Tue,  3 Nov 2026 09:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698034;
	bh=wOrq6+f3nxtWdT5oOXG5uqpLCZ4DOyK+a6T74j8bTiM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=a/KZ5mZ+XlWDYSEseVKREeTESPObYpQ421LigSXu75rNVAoWn6Hr0ZkbZsuFjmclm
	 vWPqocHZvygVeXzWCUjtpHtS8jghLxCotazy1XP+ICM0Pf4Pb9vRO3YAHIBzWJBCcb
	 0fsjtO+st8XkgrgJCZz/18AzTD1c6rPMjIdJKms8E8ot7TWwtSQKpvcHmJnEuzISao
	 vjv/7bEuOwxHOAnMCnn1iDJxOd97ArjLBQebIqEGQ9yA+m88rNGaFnTjNmJYuRY7cZ
	 sIi1qiycTt3822JG6RGYZmhpTt4zt+ARUNJSEsAvVSfrTKIirzPbhAtR6S4mG2AI5h
	 IcKaFW/XUcEGQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BA48546682;
	Tue,  3 Nov 2026 09:27:13 +0000 (UTC)
From: Mohamed Yassine Jebabli via B4 Relay <devnull+med.jebabli.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 10:27:12 +0100
Subject: [PATCH] ALSA: hda/tas2781: Only accept CRC-less V1 data if all
 entries are valid
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-tas2781-v1-nocrc-fix-v1-1-a769c27f21ce@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAMAzAviI9W7Ab6PAr4mF2VXuZsokIsr87P
 CaQvJAlqWQYmxeS3Jr1iBWobYB3HzdBDZXBdKYn6ixePpvBEd6E8eDEuOqDLLxYG0S8W6GmZ5K
 q/+00l/IB3FbO/2YAAAA=
X-Change-ID: 20261103-tas2781-v1-nocrc-fix-cecb33deea8f
To: regressions@lists.linux.dev
Cc: Cristian Castellano <cristian.castellano@icloud.com>, 
 stable@vger.kernel.org, Mohamed Yassine Jebabli <med.jebabli@gmail.com>, 
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thorsten Leemhuis <regressions@leemhuis.info>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793698033; l=3393;
 i=med.jebabli@gmail.com; s=20261001; h=from:subject:message-id;
 bh=hTyxP5z+2ryyUf7OXKh4MV/62ueN7NmrvIPpkkLjUsk=;
 b=iqDefFOg+eZPbjNKMezCK9hU3xHZ+lZ5tA03/M4+zN2zOYt9hQ4xHeg563in2/UVpA/9/cm9a
 0pN7usuwo9uCnar8LD+9UrnBw3lGPrWP1yA5S3hirRbu0GzxMHMPhQZ
X-Developer-Key: i=med.jebabli@gmail.com; a=ed25519;
 pk=DrcY8DXRRRL44W1NDZ4mXZmW9PRCASf9qYo1sm0KFYE=
X-Endpoint-Received: by B4 Relay for med.jebabli@gmail.com/20261001 with
 auth_id=1095
X-Original-From: Mohamed Yassine Jebabli <med.jebabli@gmail.com>
Reply-To: med.jebabli@gmail.com
Content-Transfer-Encoding: 7bit

From: Mohamed Yassine Jebabli <med.jebabli@gmail.com>

Commit 408249089c48 ("ALSA: hda/tas2781: Accept V1 calibration data
without CRC") only checked the first device entry. On machines where
the BIOS populates fewer entries than p->ndev, the remaining all-zero
entries are applied and tas2781_cali_preproc() divides by zero on
playback open.

Accept CRC-less V1 data only if every expected entry is non-zero and
self-consistent (R0 * 1/R0 close to 1.0), otherwise reject it as
before.

Fixes: 408249089c48 ("ALSA: hda/tas2781: Accept V1 calibration data without CRC")
Reported-by: Cristian Castellano <cristian.castellano@icloud.com>
Closes: https://lore.kernel.org/all/4e500063-d985-46b6-a0a1-3feaa77c4b2f@leemhuis.info/
Cc: stable@vger.kernel.org
Signed-off-by: Mohamed Yassine Jebabli <med.jebabli@gmail.com>
---
Cristian, could you test this on the Yoga Pro 9 16IRP8? With the fix,
the driver should log "V1 CRC error" again and fall back to default
parameters, as it did before 408249089c48. If it still logs
"accepting", p->ndev is 2 on your machine and the root cause is
elsewhere, so please send the full "dmesg | grep -i tas2781".

Takashi's re_cal check in tas2781_cali_preproc() is complementary
and still worth applying as a safeguard.

To: Takashi Iwai <tiwai@suse.com>
To: Jaroslav Kysela <perex@perex.cz>
Cc: regressions@lists.linux.dev
Cc: linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Cristian Castellano <cristian.castellano@icloud.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Shenghao Ding <shenghao-ding@ti.com>
Cc: Kevin Lu <kevin-lu@ti.com>
Cc: Baojun Xu <baojun.xu@ti.com>
Cc: Sen Wang <sen@ti.com> 
---
 sound/hda/codecs/side-codecs/tas2781_hda.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda.c b/sound/hda/codecs/side-codecs/tas2781_hda.c
index e0da299df780..9162173ccb10 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda.c
@@ -50,6 +50,31 @@ static void cali_cnv(unsigned char *data, unsigned int base, int offset)
 		(u32 *)&reg_data, TASDEV_CALIB_N);
 }
 
+/*
+ * V1 data without CRC is only trusted if every expected device has a
+ * populated, self-consistent entry: R0 (Q27) * 1/R0 (Q31) must be
+ * close to 1.0 in Q58.
+ */
+static bool tas2781_v1_nocrc_valid(const unsigned int *v, int ndev)
+{
+	const u64 one = 1ULL << 58;
+	int i;
+
+	if (ndev <= 0 || ndev > 4)
+		return false;
+
+	for (i = 0; i < ndev; i++) {
+		const unsigned int *e = &v[i * 5];
+		u64 prod = (u64)e[0] * e[1];
+
+		if (!e[0] || !e[1] ||
+		    prod < one - one / 10 || prod > one + one / 10)
+			return false;
+	}
+
+	return true;
+}
+
 static void tas2781_apply_calib(struct tasdevice_priv *p)
 {
 	struct calidata *cali_data = &p->cali_data;
@@ -145,7 +170,7 @@ static void tas2781_apply_calib(struct tasdevice_priv *p)
 			 * but leave TimeStamp and CRC zeroed.
 			 */
 			if (!tmp_val[20] && !tmp_val[21] &&
-			    tmp_val[0] && tmp_val[1]) {
+			    tas2781_v1_nocrc_valid(tmp_val, p->ndev)) {
 				dev_warn(p->dev,
 					 "%s: V1 data without CRC, accepting\n",
 					 __func__);

---
base-commit: d73cab4a427f924efd5b5d8769c80e0ca5bdcadf
change-id: 20261103-tas2781-v1-nocrc-fix-cecb33deea8f

Best regards,
-- 
Mohamed Yassine Jebabli <med.jebabli@gmail.com>


