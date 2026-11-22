Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795353529;
	b=ECDlpeNMuHF82pbq5ouInH/U6WjOvAGolCAmjrNi6BtluQmZniAyO0hGQtBqlTpja6fP
	 G4mmV9iq8XfDZ1C0/056vHtNbjBW4a944n7r0NbSGYLGeqJORXTCPwLs3mDLzwwg+Majs
	 EA+yeCN5T8vwgfUJD8Xgz86dRqpgHb7IoTsqKtgakx/p8hG8+KRtdG4bzC6y4A12ZoUtP
	 gV3URCmfnmC/dtotXkishCQRyWbXPaFialDkP3LW+YBSVoEFpRS1oNw+jY+2bXSPnISr8
	 OoU5l9d1ZS66CQ/Mdzz2IzZyMqyI0dHSa/6zNAOtGqzL53rYTn6b9OimueHken8QANw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795353529;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RtffMgOxZLQ/JTkvXGecUIpw1wwHGGuG/3tZCv9f51I=;
	b=5gPgjC191j3ljWyJSBIGzutHw5DDqGboq/IYJ7QjlOi4apDV1WueIANJfq9xxdJk9P5W
	 ryFZGlOGy7aWWPZdpZN7vhTdItLQEDcD88rn9OZtecRKsK/iG5j719n69FfbL6ibtc6WV
	 byhLD7/bcrdEOcXysGSiv9y1vFlnN8jvfr9B8+VkdJi2nqMR0HgCiy5ZA4gIQXhLIP+aF
	 QInyj8mr1wtMjk5cSa4AJ8YYsuqC2VnK2NKTSAfR/F8f/QJx9pNoNeaBH4fWwY6nnTepf
	 sphERjBWPnLbSIIqczI08Ur14KsuVAyJSwCGaZRXCrtB83vLKlchSRs8Y8Am/kGQVpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NAq/q/R6";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A2F606A320;
	Sun, 22 Nov 2026 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAq/q/R6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795353528;
	b=xqU4gK+xLjvRYgpH3S8AN/F40tQaizlXODlZUFqe3DlF2pgKleBlkgDUaQWsWJSGse++
	 MWVhHbxFpcgmKdHyaWGr+b+6h3gjxPazQE34DfOU1kZu3FVeRH0wif7nAYEaAZGBcF7eB
	 D9ToPGf1/UBlxTTi30bd8Kihtw37HpKkCPLr+OgE0p/E6SiStBlmwbuvFg4WbYSXy/yPS
	 ZxuEqPvPWvtwaz80psRJQx+OZCSK0nHngDLnNsRCMzW+1VCffKdVowlFPz/4xxJEd4mmM
	 IR9znfwrVNP9yMpNedalA3gvTZwP0z8vvW8aE/aheqUhIkfbTeXYhMxkWBokBUNKEog==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795353528;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RtffMgOxZLQ/JTkvXGecUIpw1wwHGGuG/3tZCv9f51I=;
	b=BArQ1hQCVsZhEQFfVbtPkEdNGOsb5aw6TL32pikYgxoSeFWOmlXJr89kMWLYIoox5HSb
	 DjI7E5Yi/Ans5oL2JfCiZi594xtJFN4pWUznIZ2SuRr/O92T6xI4cQxDR7hSgc8dRueOL
	 hCW09qhd4/+XQT2A83txyRsJgoJbrLJ8mBoWafYRi6CRZgepbdq1AHHgKMFO9GLFfWpPS
	 sYEUL0F0sqe44sZxrkWQl3GZZPck9nd6jsQhsIXfWP/5ShsAAKz/rWNhYZ2ZiJNC8Sby1
	 5hnExVFlYVfcD35X3gDv9KCsaXemg9MkdDRZRJ559IoJDhUGPGhclVYMS+fYdSXFnCA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E3C0C1F000D1;
	Sun, 22 Nov 2026 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795353528;
	bh=RtffMgOxZLQ/JTkvXGecUIpw1wwHGGuG/3tZCv9f51I=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=NAq/q/R6twa+VpxvCUP64dd3tAz10Mffa9v1UtUirw0hkrbqLkkzRatXVuAExFdsu
	 7Jj+c0giSQsjEnnjVSfHPvDOdSuNUIRB20tF3VgO4jR41TzM9CpNqRsUDVhaE/HYiE
	 F8ahP5MpTsLlGrtCVYU0VL+9jgHrx/maPWK/c63H1+/Lk2pPC5zfPYqxOKqSz8ELZv
	 qdOZ0QIBGfGBabb6w915ROX7ucp4uP4rq9V6mv0/+n6aHk7Fh7+vRN5hzsqaS5QOuN
	 FvH9oMEHFsD620rqogtqm1TgPDMI4RECxowmlHQdbuKq+m7+u14GjqE3GeYSKO2oU+
	 7T++UZ3yOFL7w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 46C894C063;
	Sun, 22 Nov 2026 13:18:38 +0000 (UTC)
From: Oleg Antonyan via B4 Relay <devnull+oleg.b.antonyan.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 14:18:37 +0100
Subject: [PATCH] ALSA: hda/realtek: Fix headset mic on ASUS Zenbook S 13
 UX5304MA
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
Message-Id: <20261122-ux5304ma-headset-mic-v1-1-80589ae749a8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKzrAmsC/yXMQQ6CMBBG4auQWTtJO2KDXsWwqOVHxgQ0HTAkh
 Ltbdfkt3tvIkBVGl2qjjLeaPqcCf6goDXG6g7UrJnESvBfhZT0dXT1GHhA7w8yjJoYATQh1484
 9lfSV0ev6217bv225PZDm74v2/QPbQQspeAAAAA==
X-Change-ID: 20261122-ux5304ma-headset-mic-e2ee8664809f
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Oleg Antonyan <oleg.b.antonyan@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795353517; l=1835;
 i=oleg.b.antonyan@gmail.com; s=20261122; h=from:subject:message-id;
 bh=tTuD5gMzmbpXEeh4kAfA/ft27GJCym2dy3cdc5+lNNU=;
 b=4TrP/nP+pzlrxDU+GUMC/J/I3G+a3TzxaR7aweX53XAOAUEl3sgzRbSnzwe7cltGJu2X5FKw4
 CZxl6NTm/ZkDTdOUevh9EWvfhWv+T9HBSPAe+JwPj4PsWnEHc6Ks0my
X-Developer-Key: i=oleg.b.antonyan@gmail.com; a=ed25519;
 pk=AA4/X8a4Pvsu+cn8cLNZ3XDbM6VmZZJ57ZuDUycpXD0=
X-Endpoint-Received: by B4 Relay for oleg.b.antonyan@gmail.com/20261122
 with auth_id=1603
X-Original-From: Oleg Antonyan <oleg.b.antonyan@gmail.com>
Reply-To: oleg.b.antonyan@gmail.com
Content-Transfer-Encoding: 7bit

From: Oleg Antonyan <oleg.b.antonyan@gmail.com>

The ASUS Zenbook S 13 UX5304MA (1043:1c33) uses an ALC294 codec with
CS35L41 amplifiers over SPI. Its BIOS leaves pin 0x19 unconfigured, so
the headset mic on the combo jack does not work.

Use ALC294_FIXUP_ASUS_SPI_HEADSET_MIC like the UX3405MA and UX3402VA.
It configures the headset mic pin and chains to
ALC245_FIXUP_CS35L41_SPI_2 to keep the speakers working.

Tested on a UX5304MA: headset mic, internal mic and speakers work.

Fixes: 61cbc08fdb04 ("ALSA: hda/realtek: Add quirks for ASUS 2024 Zenbooks")
Cc: stable@vger.kernel.org
Signed-off-by: Oleg Antonyan <oleg.b.antonyan@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index a6b5e8987294..50bbb5b4529c 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -8213,7 +8213,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1bbd, "ASUS Z550MA", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1c03, "ASUS UM3406HA", ALC294_FIXUP_ASUS_I2C_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-	SND_PCI_QUIRK(0x1043, 0x1c33, "ASUS UX5304MA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x1c33, "ASUS UX5304MA", ALC294_FIXUP_ASUS_SPI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1c43, "ASUS UX8406MA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1c62, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1c63, "ASUS GU605M", ALC285_FIXUP_ASUS_GU605_SPI_SPEAKER2_TO_DAC1),

---
base-commit: 0dfd513a15573ffa21710f77c2926c3cbb81a7ed
change-id: 20261122-ux5304ma-headset-mic-e2ee8664809f

Best regards,
--  
Oleg Antonyan <oleg.b.antonyan@gmail.com>


