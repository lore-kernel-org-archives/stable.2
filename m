Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8863793BB;
	Thu, 20 Aug 2026 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216408; cv=none; b=PUkyo+k0vDoYReMhWBCLVPrd4HG6EdlPyFPm8qnD1pW9VBwLJvwpxmZI1GqM+Nbbe1y7F2iRk283eKm2YG9vHK4zOlghrrsa36UC1TndmxDoykxLIEdTYh1ZIj5qQ2irldtgbuJMDTSoCTX+1xAaiJXfvF4jzjb9BoXIC9S7f88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216408; c=relaxed/simple;
	bh=q0p/aoA2Q3omxotC6cxorK1FZYf1x6enap+5hxyszp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DR1LUKpr36uG/S0ckm3isHfqt2/LsA/+iew3JHnqAc+3r2dc/EsCkv65wPjvJ4EK1Ax+jJknHJndVeptp30OshDwE3BVLC6NAKMszmIeMoa+DTKyCp4aPTza0uG8t2MqyqhwGNGDzsWxeznW43DExUVc7yTpirlBuApDDMThM+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from ajratkogda.ipa.basealt.ru (unknown [193.43.11.2])
	(Authenticated sender: ajratma)
	by air.basealt.ru (Postfix) with ESMTPSA id CC3F520003;
	Thu, 20 Aug 2026 11:52:23 +0300 (MSK)
From: Ajrat Makhmutov <rauty@altlinux.org>
To: stable@vger.kernel.org
Cc: linux-sound@vger.kernel.org,
	Ajrat Makhmutov <rauty@altlinux.org>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.12.y] ALSA: hda/realtek: Enable headset mic on F+ FLAPTOP r
Date: Thu, 20 Aug 2026 11:52:12 +0300
Message-ID: <20260820085212.52991-1-rauty@altlinux.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 7097666b993b37f4e47982026b703b2379a364f8 upstream.

The BIOS of the F+ FLAPTOP r laptop (Realtek ALC897, SSID 1e63:6d9a)
declares only pin 0x1b, the headphone output of the 3.5 mm combo jack.
Every other external pin is left at 0x411111f0, so the headset mic pin
0x19 is never parsed and no headset mic input exists. The pin is wired
on this board - retasking it makes the headset mic record.

Reuse ALC897_FIXUP_HP_HSMIC_VERB, which already sets the pin config this
machine needs: 0x19 as a headset mic without its own presence detect.
Only 0x1b reports jack presence here, so a mic pin with presence detect
would leave the driver in auto-mic mode waiting for an event that never
arrives.

Without the quirk the generic parser retasks the lone headphone pin as
an input instead. That surfaces as a "Headphone Mic" input which records
only the internal mic bleed, so the headset mic appears present but dead.

Tested on ALT Linux, kernel 6.12, by recording a CTIA headset mic on the
combo jack with the internal mic as a reference.

ALSA info before the patch:
https://alsa-project.org/db/?f=18363eddea933baee100c9bf461d0e5cf74c8de2

ALSA info after the patch:
https://alsa-project.org/db/?f=48ae2cd7aaf1eb0f24639ce83cd38cfd93b25f76

Cc: stable@vger.kernel.org # 6.12.x
Signed-off-by: Ajrat Makhmutov <rauty@altlinux.org>
Link: https://patch.msgid.link/20260808185500.2564948-1-rauty@altlinux.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ Ajrat: adjust for the pre-6.17 layout -- the Realtek codec code was
  split into sound/hda/codecs/realtek/ in 6.17; in 6.12 it still lives
  in sound/pci/hda/patch_realtek.c ]
Signed-off-by: Ajrat Makhmutov <rauty@altlinux.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -13642,6 +13642,7 @@
 	SND_PCI_QUIRK(0x1b35, 0x1234, "CZC ET26", ALC662_FIXUP_CZC_ET26),
 	SND_PCI_QUIRK(0x1b35, 0x2206, "CZC P10T", ALC662_FIXUP_CZC_P10T),
 	SND_PCI_QUIRK(0x1c6c, 0x1239, "Compaq N14JP6-V2", ALC897_FIXUP_HP_HSMIC_VERB),
+	SND_PCI_QUIRK(0x1e63, 0x6d9a, "F+ FLAPTOP r", ALC897_FIXUP_HP_HSMIC_VERB),
 
 #if 0
 	/* Below is a quirk table taken from the old code.
