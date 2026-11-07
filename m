Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048676;
	b=o+XwkUPCVKDtgVkRIw7XJsJ8rd3yRiVr7eQ7ukPbTaneczhXAVqyGLbSPq9CSmWfQGWc
	 FAe1eBHWMzC9olpSXFDv4WpoEDuAGBid1oWTZWMeeBGlcxWB+l0iff7N1R/jpeIRUsfpP
	 sFI7bZ+ROk20GdNxT3+ZCMEYBxd8dxOyG4CKeLmAIzpXni+LNHi0WCBVZazMzoPntMSJu
	 dQ+jJ81HkPBMohQgr6gnnM91oxlB7VUaTjlhf8OyhjIUGibp7Rhb0mT6ohG2LXHOEJ65T
	 L1tOQgBpgpwjOtsv0G29Nw9FDkp5feOZNh3o+x447DLNn4eONBn3yyq1Kl4EKMTE7UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048676;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gQA/SsbVsZrAfmZL4WIGLmiU3iHsPiCxz3DVjbl8GR4=;
	b=yaR6kSNw49LjIxNkPXK9jN51uqpl7SYkGL73PqDoza8A11ilVFyCO/jxdJZSYqQNhdqN
	 zUflXWCrgbxfrfJS+EwYmsRpbhimxpj8zvQg3feaXyuUwXHS5jpRiSRH0Qxe2iVP6jSEC
	 9seiHTFNqGuMGJ0X+Uf96TuZay78N231oS6XDnh9S+ym+0/6UQ0Jatedt+jUQX95NhdR/
	 /lVyIt4LLBGbyGhsAz2fP++jw5yzfB/EIm1WNugzQIl3uIzt0cip6aW+VMCBS2yRxZvHn
	 OweDQX7KByUtVeGZjTF45S/HU7ThL0BEpVPX02X2CNvtyYso5wGiUk5LNhIfXzxIyxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NdDVh6fE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B32606A333
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NdDVh6fE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F161F0089F;
	Sat,  7 Nov 2026 10:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048676;
	bh=gQA/SsbVsZrAfmZL4WIGLmiU3iHsPiCxz3DVjbl8GR4=;
	h=From:To:Cc:Subject:Date;
	b=NdDVh6fE7wXUQkBTySUMf6uYQukzAqgXx9OzMB+acf4yGvAuVxJ5Uh7kMOalxsGHj
	 lPBEuVLyCiNqgrGbBI3B/Dq9pcsGnyvZscP1ksEfkfmCMQEJZven7ZL5rN0KmqnxQK
	 G1b4Jq/LJ9JoRdgGTq64IenE6wJEjGVsy8niLwwdMJpwNQlT0+M39a7+LwzOfluyIy
	 ELSrUor+GPuMAI8d3U7ezR/BRLN9PsPNHAh4R8V3i4Eu97N+XJDk80qEdTnH6u6Ptk
	 2q1dcLBWp4Tik3a/nCkG9Nr5mNGxveQ7Txhha6D4Vni/7D1IA0ELbCO3iIpWAC3FLL
	 rieO/XCFETl6g==
From: Sasha Levin <sashal@kernel.org>
To: gxristidis@gmail.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Fix headset mic on ASUS Zenbook 14 UX3402VA" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:51:14 -0500
Message-ID: <20261107055114-failed-6.1-40409fa23d32@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 40409fa23d32c8ed51e832031daa6decd9d6fd11
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055114-failed-6.1-40409fa23d32@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




