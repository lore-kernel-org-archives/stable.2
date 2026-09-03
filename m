Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33C4D8DAF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450022; cv=none; b=Isyv9NoEqSdsB9rIMcXwlS2Ep65aSa3CHI9K8gbBbaOy6PhiZ1tbNqOg7fnrTtgEiXBZ51D68amkIVnZjvBa0SEd/XD1Jw/wGEDvv0uMZVJnwlef1bjZoysmwm1MzDC0Jep7yNXHaDA6Dbh38jxLWcnQGHhS+3IBHgeCIQOHRKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450022; c=relaxed/simple;
	bh=HLy/4aLS6xtg/YJ3fRX/1YNAc/on57k3t3i5LwlV7JI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZWk1P+nWyPVCHwhAaxp9Z1+sqJAmlhYC/j0DnV6HZp4NLTzU69StSli++tOWiSyruQrRyB4NRVwlWtOVxx/5eydNHo1VwdM/rA44H4E1TvTDnAsuRZkfoz4lhO+0rurKEB/zSvNu/fpg746NoKZIs6/oWdAslVH7LLNOgDu6FTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DYOJAs9z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DYOJAs9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91831F000E9;
	Thu,  3 Sep 2026 15:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788450021;
	bh=HZ8FfkhwHIBbCV5dM5HBKaal4Pda1GbTPmJ3FTi3bQU=;
	h=Subject:To:Cc:From:Date;
	b=DYOJAs9znuJ2kzW2iCABeFRWm0NLS1cMKabj1TS15Zq8UORDSz/eA9aNJRd9AnAql
	 xPngKVjZuATY5QrWFWm0X2shi2qZrG0xBagPjl2PBp6DZKeuN3GmtZTugu20+PSALV
	 mZSkSd7yX91PA3i+toHWRE9bSCTiY+UUcIauJe2c=
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Enable headset mic on F+ FLAPTOP r" failed to apply to 6.12-stable tree
To: rauty@altlinux.org,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:14:43 +0200
Message-ID: <2026090343-excretion-chubby-36c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7097666b993b37f4e47982026b703b2379a364f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090343-excretion-chubby-36c1@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7097666b993b37f4e47982026b703b2379a364f8 Mon Sep 17 00:00:00 2001
From: Ajrat Makhmutov <rauty@altlinux.org>
Date: Sat, 8 Aug 2026 21:55:00 +0300
Subject: [PATCH] ALSA: hda/realtek: Enable headset mic on F+ FLAPTOP r

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

diff --git a/sound/hda/codecs/realtek/alc662.c b/sound/hda/codecs/realtek/alc662.c
index 2cf3664a35ff..a640292c4f10 100644
--- a/sound/hda/codecs/realtek/alc662.c
+++ b/sound/hda/codecs/realtek/alc662.c
@@ -852,6 +852,7 @@ static const struct hda_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1b35, 0x1234, "CZC ET26", ALC662_FIXUP_CZC_ET26),
 	SND_PCI_QUIRK(0x1b35, 0x2206, "CZC P10T", ALC662_FIXUP_CZC_P10T),
 	SND_PCI_QUIRK(0x1c6c, 0x1239, "Compaq N14JP6-V2", ALC897_FIXUP_HP_HSMIC_VERB),
+	SND_PCI_QUIRK(0x1e63, 0x6d9a, "F+ FLAPTOP r", ALC897_FIXUP_HP_HSMIC_VERB),
 
 #if 0
 	/* Below is a quirk table taken from the old code.

