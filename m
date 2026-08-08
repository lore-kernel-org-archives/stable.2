Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8930D3246ED;
	Sat,  8 Aug 2026 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786215326; cv=none; b=I4NlLC799lbbzjpadJSeu9ZfhWtHtgF9rlT3gKnt/QJh+X6Iaaqt2Z2aKeHOvZ2AzJXEWgiW22r6AFCQQmVDvdU+VeNKnexBsE5CEj/atCZjnr/c/n+ChUZCmEZ4Xv8VjF75SvYNJAmI5+ntPU4fcrcYjhujb06VtH6rKMGcRMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786215326; c=relaxed/simple;
	bh=ziW5rMn85IEv2yz9pv/ydk6MjMxZmwsSl92B9Rdb8fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/Wkl1pwq77IT98crHbxY1vAD1BYvHeVxonNkMgcjXng/qkVu4gXrQksMVzdTBvpFuYYJ20x295ISH7+47jhn9aCHKhXfaexSXTQKtSIZf9w42Tghq1r186ik20MsF762sgIEoz5Mrl4F8GwqGU0lu0A2YsQ5K6APoDRQLBxnw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from ajratkogda.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	(Authenticated sender: ajratma)
	by air.basealt.ru (Postfix) with ESMTPSA id 8882E2333A;
	Sat,  8 Aug 2026 21:55:19 +0300 (MSK)
From: Ajrat Makhmutov <rauty@altlinux.org>
To: tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ajrat Makhmutov <rauty@altlinux.org>
Subject: [PATCH] ALSA: hda/realtek: Enable headset mic on F+ FLAPTOP r
Date: Sat,  8 Aug 2026 21:55:00 +0300
Message-ID: <20260808185500.2564948-1-rauty@altlinux.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 sound/hda/codecs/realtek/alc662.c | 1 +
 1 file changed, 1 insertion(+)

--- a/sound/hda/codecs/realtek/alc662.c
+++ b/sound/hda/codecs/realtek/alc662.c
@@ -852,6 +852,7 @@
 	SND_PCI_QUIRK(0x1b35, 0x1234, "CZC ET26", ALC662_FIXUP_CZC_ET26),
 	SND_PCI_QUIRK(0x1b35, 0x2206, "CZC P10T", ALC662_FIXUP_CZC_P10T),
 	SND_PCI_QUIRK(0x1c6c, 0x1239, "Compaq N14JP6-V2", ALC897_FIXUP_HP_HSMIC_VERB),
+	SND_PCI_QUIRK(0x1e63, 0x6d9a, "F+ FLAPTOP r", ALC897_FIXUP_HP_HSMIC_VERB),
 
 #if 0
 	/* Below is a quirk table taken from the old code.
