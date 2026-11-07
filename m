Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047791;
	b=oFwklyHSAiz056buqbbpwcUy3hy9XCxcZwYl024uJyNJXIUXR4nTrcI/+66y1TguUmKA
	 G3n3wN+qn3F2MeNwTGF4Yz9cCBHFbUr6jqx9G5MJO2qhj4Yfu7fsykxsqxiTCC0hda+q1
	 Fkrv02PtdsiLLapdokMgsIyz9vJSKmjyEccfY3Lc33vNvLCrTJvcx9koia+hN190rnHJy
	 Dqls/Wb3w4OnKyzZKI66z4HaW9k/YZY4AloeimDNJ/5dMkJUSRP9ixhrGgQdgwM97Xt92
	 Nu9WCflKcj/9B1HY13BidfZXG7+rQi+f55B5gB6328lBLTbISrQ738P7p97ViEPhsLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047791;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+/vf6ztkgdC0WD/X+SOK8aLmCUG+FN09NEifEuCCmUU=;
	b=ri1QOm0A2inS37w4bIMg/b5x462yEDmPwdJSoIGjkT7K6eNg/+7Nwdd+05nR3WqRfDbs
	 Eg8c78jVY0VzuoDbVlITx6TETFiIKUBHpGWvSynRz9PNLWJorYyrjeUBUqZxsGDEB8XC5
	 PtrhTovjvOUMQtWdC0IOcoCj+TExQlpKsLG4cRYGgT23VjYlv/evrzCO5Es5XnXEOQuXw
	 c8k5EM9YHYZ/rzj+7J7XLB084T8+HSNWz3SvDo6FvbTiZmH9lCpGlyRg1v9OdHF0d8wIa
	 I3cRe7pPErOUlOfdGQ43ELR0swK27StwXQxUr/fbp4OUzIDtoJGbv6v9tbHE7/lE7sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsTALO6t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE19606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsTALO6t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9591F0089F;
	Sat,  7 Nov 2026 10:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047790;
	bh=+/vf6ztkgdC0WD/X+SOK8aLmCUG+FN09NEifEuCCmUU=;
	h=From:To:Cc:Subject:Date;
	b=MsTALO6tHiIlyA8XJRE4gIN589DWzsLXksPbFbEtzVYm/EnbS9rgj5ksqcAdi7+XM
	 9MmfQAqaawJ3GEPxKHi9insrlS/m4Vb9wRm2vgdnzIdWP6K2T78Gg9fZCaMRuXuJ05
	 hEY+CJG0Xl059i7HSNj7oiLajcdYQhPyKKdjXkuykAM/+nz/5N4MJm5C6m5VpeSnZc
	 pSCgVV4OakdHX9LEYdMLmeLKjiL8SMdTtyNxhw7eaBrVkknQQXL1UmIgj8Ju/kieMi
	 hGYUMKlayfcLcmOj68Txn5HBLgo5dzWp9VmDfkBvH7CiwczwKOHLG4N7lRjUfq8cYq
	 N6PkfP2LFMHjA==
From: Sasha Levin <sashal@kernel.org>
To: gxristidis@gmail.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Fix headset mic on ASUS Zenbook 14 UX3402VA" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:36:29 -0500
Message-ID: <20261107053629-failed-6.6-40409fa23d32@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 40409fa23d32c8ed51e832031daa6decd9d6fd11
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053629-failed-6.6-40409fa23d32@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




