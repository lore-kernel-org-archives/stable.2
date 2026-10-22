Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.230.196.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674170;
	b=sXnSmb3RM92B8LyIkBjgPmXuzxjjn0t2F/Af6IhNr8FLcuAov4ckGMXpUI5pICU3fsLE
	 C1Hbsa+Ba5fPIakATR2Wuc7F+vV1nsgOXV7kG3qMnCnwxkXwque0Ia5NN1xEZHcbat7/2
	 CoIhEEeVXSkaUgq73S3dkfd6dGDRzGPr+4t3ANo2dpfDFlzwkisui2tweGL0tpec8K+8j
	 APnDCC2iFsHMIVJ2JHmzDP/ELt4pUYfcbwY/WR/wACLXJ236R/bDrlYEx0ahZorkpNNoF
	 T0+BL5IS1dBEr5/8nF3pP4mM47K9+gOfMsQrGsFoyqAIwAarXS8OtV0l3TGj4BW45pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674170;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=/kXGwF+5gGF+xxgZdkgZRClYdZY/AztWdeG/I065pIY=;
	b=OZwt/r62iRztiMZPQZVRZunruoaTEN3lpfCcgRlKK/vuDNUQbYxkKDSxhaB+iZmbSahZ
	 KZq6nGEJELEGOM+F7QFvuRt8QCWRjvjbvKqjzhGeHGL3RyNrRzOlP+2oZ8n08EtS83CGJ
	 t5vVvPO4dIGnKa2Mj0Ajb3Qo5H56+VuM82jrUYm3pUnPaXCfNoombSB8O12I8L9PjL8L1
	 pXi1fBT05rCreKb2PJeKLj4YEdXQW2JO71Re6gk3rgEVeXBr+lWkmjXxlKFGk6gdD1k9H
	 eILcLa20ydlp0TyUhDbbXyienooVgMvgAM3N9mBjvZSItLN86t2egVNlllvoIcPDBNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=AcRU8I4T;
	arc=none smtp.remote-ip=37.230.196.243
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56989606A33A;
	Thu, 22 Oct 2026 13:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56989606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=AcRU8I4T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1792674164;
	bh=huIlFCsZCtW9EvCMUYovDzCuBbGv+HAK18qyT9nyhnQ=;
	h=From:To:Cc:Subject:Date:From;
	b=AcRU8I4TJmhY/vg88BXHFdtyNi0ehXLBmGvHCA4BqIG+gtSmUI1rXWTTzgd3aJDoH
	 6nVdoc3GQ3lyef9biEQGrMJ0uJLDVOh8fojvoixDLcfhNauS/PfIdj6KZxTRDe1bj+
	 gzYjGf4eiEiOkTC7xyYPl3KbDt3/z7H5q1dGcxfC9kwMX/ycDIyGPNVDvR+vwdpB0o
	 VLAxUjFIaZeq/BQ7hDy4x6fyH+jz0r+gKe8aDsP61JtZPA0Sr84MiNEDWTbZ3Lniz3
	 fw658tKVj/AUunBHjjKiAJyPbPWv3IgauYtt+8c1ORgMI7xAphNxTz6JsW9GbPe8fW
	 PnHTWWd0bmTTA==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id B1BFD269A5;
	Thu, 22 Oct 2026 16:02:44 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Thu, 22 Oct 2026 16:02:43 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.49.111])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4j9RC70RFCzRM8;
	Thu, 22 Oct 2026 16:02:43 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>,
	HyeongJun An <sammiee5311@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] ASoC: codecs: hdac_hdmi: Validate written enum value
Date: Thu, 22 Oct 2026 16:02:05 +0300
Message-ID: <20261022130207.475-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
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
X-KSMG-AntiPhishing: NotDetected, bases: 2026/10/22 11:19:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 132 0.3.132 b92628ca234da971a1a6d61b32804bb3075f0fd2, {diag_burst_silent}, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;patch.msgid.link:7.1.1;new-mail.astralinux.ru:7.1.1;astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 206901 [Oct 22 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/10/22 12:20:00 #28725625
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/10/22 11:19:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: HyeongJun An <sammiee5311@gmail.com>

commit 0b08baeccdcf52fad328ad645f5b4fbee04eea34 upstream.

hdac_hdmi_set_pin_port_mux() uses the written enum value to index the
texts array before calling snd_soc_dapm_put_enum_double(), which validates
that the value is within the enum item range.

An out-of-range value can therefore make the driver read past the texts
array before the helper rejects the write. Move the lookup after the helper
has accepted the value.

Fixes: 4a3478debf36 ("ASoC: hdac_hdmi: Add jack reporting")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
Link: https://patch.msgid.link/20260609124317.38046-2-sammiee5311@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-74295
 sound/soc/codecs/hdac_hdmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 76e06c88f279..32f5b958cb80 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -906,12 +906,14 @@ static int hdac_hdmi_set_pin_port_mux(struct snd_kcontrol *kcontrol,
 	struct hdac_device *hdev = dev_to_hdac_dev(dapm->dev);
 	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	struct hdac_hdmi_pcm *pcm = NULL;
-	const char *cvt_name =  e->texts[ucontrol->value.enumerated.item[0]];
+	const char *cvt_name;
 
 	ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
 	if (ret < 0)
 		return ret;
 
+	cvt_name = e->texts[ucontrol->value.enumerated.item[0]];
+
 	if (port == NULL)
 		return -EINVAL;
 
-- 
2.43.0

