Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050685;
	b=SP79OtZu0obG4t60wzxsT3+0TJJohwso+bHhbmp1eeySdS2wCyLXo5hTahaKgiBQewiS
	 hw9j3BaP+f/mppvvNhYb9nTFMtCRwvHApCiMRKFxWaNUckJTf8Uh/Hv+4rgxWyO42IYEt
	 RJgkAqXdt+0F6t112pmwvE5EbHy8pYKWx2C7LdT0aM1+c6WJ7Kq+PEYl44Szu7/ojqrPi
	 2/hAm+qQT2AeE7FzYvjoVqlnyDvkaxsf6rmiAj/sk2UcsRTF2R5LeixeeoNM1xDayVCoQ
	 V1i33aYDf7h2gGwlN4P/6x9J8IJOJdGPv0l5Q/iiSEwPjs4CiW+iDL3sQtBQiTERxHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050685;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UZ08/xvD0nma9e/oLJMkX+O1io2AjS8qBsoEGLnmJlY=;
	b=EHNszXkg+M72FqdU164eCH06/c1zFTmyOn5miq0NHhYV06kpHbJ+iSIyh10AFLO43xyz
	 SHsWzMWG1oV/wlxx5014MYoAepgAdHQNDrnBxFLmeZwEHE/wKYZk+qfIpHnA7RSrpkBBc
	 QKduNjcCBBV4+56fGEIXB5xCW5RteHKBUvZm4UOSmKs+sB1rFKNWXzaFljNjFoZ99Zi/C
	 9hnC+Nb+oQpL4knlCFObkX7Ajhsqs6HiA6vWKmqjLpRS/Pqc3c+VHBUYd1wBhuWIppBvZ
	 +sE6F87pjXBzHqbGmH6fXGimgfnP5ozkH6uaTDOZQHH4Hsb9QhU7SeUe7C3K1nBi73A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asXBfeOh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE104606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asXBfeOh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A3D1F0089F;
	Sat,  7 Nov 2026 11:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050684;
	bh=UZ08/xvD0nma9e/oLJMkX+O1io2AjS8qBsoEGLnmJlY=;
	h=From:To:Cc:Subject:Date;
	b=asXBfeOhMoqBUxJsCzaWa70fNNwZHlhV/MVkUoRDwvta6APW/yvqsPcRv02IEXtRM
	 ZR3jw/e5S5nJxiwt5mmii/f0VbvOYN1o0xc5S8YGVzyBkjw28WnjZdrkvO7SeEiMre
	 8SRD8PFLPq9C5tLXitu+Z5GgDpoJEH4AQw9pyncBe4odZcmSfz/Pbei6ChC/ojTDhn
	 Fwp+Pu2ILeRV2wTsqQKYjedlUtqyRZF0ZT9klzWDfFXOkh8m2mdt29aztJh8e8QP4X
	 VVZk5DPU9QXDFeF1RPbTa52NCdEHkBSxmvLi4WvLSmiH5KgFLkVhXLryPvd+r1MtZs
	 yH/BmKRPubx9w==
From: Sasha Levin <sashal@kernel.org>
To: gamaerry@gmail.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Fix internal speakers on Acer Aspire AL16-31P" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:24:43 -0500
Message-ID: <20261107062442-failed-5.10-d933955c456e@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d933955c456e0573b40eae4f72a3af37ab1c15c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062442-failed-5.10-d933955c456e@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d933955c456e0573b40eae4f72a3af37ab1c15c3 Mon Sep 17 00:00:00 2001
From: Luis Gerardo Lopez Hernandez <gamaerry@gmail.com>
Date: Fri, 16 Oct 2026 18:50:39 -0600
Subject: [PATCH] ALSA: hda/realtek: Fix internal speakers on Acer Aspire
 AL16-31P

The Acer Aspire AL16-31P (Intel Alder Lake-N, Realtek ALC269VC,
PCI/codec SSID 2782:1718) has its internal speakers wired to pin 0x1b,
but the BIOS marks that pin as not connected (0x411111f0) and only
exposes pin 0x14 as the speaker. As a result the internal speakers are
silent while headphones, HDMI and Bluetooth work.

This is the same layout as the Infinix Y4 Max and MEDION E15433, which
share the 0x2782 subsystem vendor. Reuse their fixup, which configures
pin 0x1b as an internal speaker and limits the internal mic boost.

Tested by booting with snd-hda-intel model=2782:1705: the fixup is
picked, pin 0x1b is used as a speaker output, the internal speakers
work, and they are muted when headphones are plugged in.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Luis Gerardo Lopez Hernandez <gamaerry@gmail.com>
Link: https://patch.msgid.link/20261017005039.9139-1-gamaerry@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index c33a385982f2b..af43e7fb99b71 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -8671,6 +8671,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x2782, 0x1701, "Infinix Y4 Max", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x1705, "MEDION E15433", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
+	SND_PCI_QUIRK(0x2782, 0x1718, "Acer Aspire AL16-31P", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x4900, "MEDION E15443", ALC233_FIXUP_MEDION_MTL_SPK),
 	SND_PCI_QUIRK(0x2782, 0xa128, "Positivo N15RPE-S", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0xa212, "Lunnen Ground 14", ALC269VC_FIXUP_LUNNEN_GROUND_14),
-- 
2.53.0




