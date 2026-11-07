Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047038;
	b=qvc9ObjlEk0Tazt8JQnHC8lxXDQsPU9LN0G6bukZz8ydvtjqk/D7trx1J5V/NKdBuorJ
	 DBEg9l5YB40epcMlwhaW77/kyOrhQisxcHhSo7JEeBdiXT0kKtuQPRAiYjuJC5ix9z52e
	 NN5s5vD0DobV1Xb2F2B8dOZp5rTIIk0q9+dm8duFiUTSG0KmomVXJPNcBo8EKn5mYIKpZ
	 HMWw2QF43IhsASMddAJCv6x42pmBXRzcsPkLclMKJq/O3PCCBryK+Bof329elLOool82v
	 ij/G+iU75iqyQcNTB1cUjIWTzccKD/zfQsqmZIB52B+4DzgGUdA/x9coHlyRF004X0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047038;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6dBT+f9C8DzEqxqIGkIgJWV30uSkpEAqcvhSUxaLErs=;
	b=UjVd0ls2UjK/YacOD7Dy9zAnfhHv/+c+OBd9PwNtB1YTi8lFFxbSaNEC/6CnA38QxLXA
	 2r856gNT9YpmQZjJ3b/jLxGw6FFqTPSoq2R7S7KzfAvIraTxtf/HNnzaYQHJJB1GYxEuM
	 h4SElTa3oAdBFSydphhEZSkdSPcQp4rgGbsNhG+DIoubm08ED4Kfq06rj1ibEE79TIE5i
	 LrpxFx/tkrTwrqkuBarbmFeFwwLuU3xMOCT68RtXVSteKh9reluUWp+KqhtMU+5YZmuKh
	 /xxIsOY5oR/dRAyAMiJi1/4eijiTnRDukqybN2GpEUnuoXQkx3eCzbWOCzsCWdA1mVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NUQnaezw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B97606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NUQnaezw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6414E1F0089F;
	Sat,  7 Nov 2026 10:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047037;
	bh=6dBT+f9C8DzEqxqIGkIgJWV30uSkpEAqcvhSUxaLErs=;
	h=From:To:Cc:Subject:Date;
	b=NUQnaezwD/sQigds4eWWPm/bl40eL1lfA/v3xkA3JvZirbl4ONdug5i6AkpzfCPuX
	 wNul6e4dg3SLZP0FpiUp7RxEII1wv/RfF8HfZvDWf0tOUrtWF/wzbEtySxkQfzUrQo
	 GgwKQAftKONMSCkLeV/jDZD79GekvjARDMlvfcysQWROLgApSuNmo1X0qlFAXsAcb0
	 ca0BOELjiLIw3vLYUZZN14ssEJKcf1kwQ5T7DhO8/lGtihK7dRjFtgo/TLf9gACWXi
	 a0xLyPl2WKKso0AbNPMOBMPTwhcsNM5jHmvhFpOx0w9t3GfOc92NUifnzQ5EM7D83o
	 7vRApdfehZjHg==
From: Sasha Levin <sashal@kernel.org>
To: gxristidis@gmail.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Fix headset mic on ASUS Zenbook 14 UX3402VA" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:23:56 -0500
Message-ID: <20261107052356-failed-6.12-40409fa23d32@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 40409fa23d32c8ed51e832031daa6decd9d6fd11
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052356-failed-6.12-40409fa23d32@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 40409fa23d32c8ed51e832031daa6decd9d6fd11 Mon Sep 17 00:00:00 2001
From: George Christidis <gxristidis@gmail.com>
Date: Sun, 18 Oct 2026 18:56:31 +0200
Subject: [PATCH] ALSA: hda/realtek: Fix headset mic on ASUS Zenbook 14
 UX3402VA

The UX3402VA (1043:16a3) BIOS leaves pin 0x19 unconfigured, so the
headset mic does not work. Use ALC294_FIXUP_ASUS_SPI_HEADSET_MIC like
the UX3405MA, it sets up the mic and keeps the CS35L41 speaker fixup.

Tested on a UX3402VA: headset mic, internal mic and speakers work.

Fixes: 07058dceb038 ("ALSA: hda/realtek: Splitting the UX3402 into two separate models")
Cc: stable@vger.kernel.org
Signed-off-by: George Christidis <gxristidis@gmail.com>
Link: https://patch.msgid.link/20261018-for-linus-v1-1-4d8e9ff27d89@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/codecs/realtek/alc269.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index de251fc464473..e3b3e88dbf8a6 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -8148,7 +8148,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1663, "ASUS GU603ZI/ZJ/ZQ/ZU/ZV", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1664, "ASUS ExpertBook PM3406CHA", ALC256_FIXUP_ASUS_PM3406CHA),
 	SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA", ALC294_FIXUP_ASUS_SPI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x16d3, "ASUS UX5304VA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
-- 
2.53.0




