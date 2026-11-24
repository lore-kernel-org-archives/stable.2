Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532828;
	b=hByToE5IhI5yQFXpLL+SijQPxRCeBsgikiR0zTOBRnyCCYJB5bFOmopAtIDo7wPvNiJr
	 yYe0fRxwKUO0vXr4i+wNET4GglR9uhUf1+vf7Dio0x0yAc84LL9dMByA6l28gMqq9d/IW
	 K3YPDTboGIQO6CVWSKENsRbDfriryrl+SxxxfHocArTWEPnjdzB8TL3iZMmbzAEddEG8X
	 0YfCRWiHMSq++1k7C2pRlHffaGNgpSyyWyanUR464Lcgmv+YlS2k7HGHZpXCJ3qKGt8Uy
	 HLok9MXHP588/egF6g+a7GPGdZd3vIyYKySeWzDg8icFBhzWJgV0pSCMcNzmj8WU4rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532828;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2MTKom1YcdMxbw6hMM463DJmBReBNMrsBMlMlgw2ZRI=;
	b=eI+RfJDyriytFrJdA3EWNeRcADSMcru1d7Wg+UV7YlBxjRZ6EsXpjR3baGf4iBR0gnZO
	 c0RBpqpm6BO3ozcsrOt5pOLoa/AMvSudZPUYReFQoY1gX0XO7lrT8giKRs/oTnbdZU4Gc
	 q0LN25Yd9FXsseDXS+XbuA5MIWUNWhPNpokgmTPjnQ6lwUEyLco8aPJw7p50GGYmOz7Qs
	 DRxiiKOs6TBG7bsLmHinY5xmaSzCj5PVPjTujCr/S36UXERjBWRvpteCEnTJ+3InJctvf
	 8ws+1lYNkOjrsHEF/tiVPozMqL0t+sMsMB9pmF1GdlfpejDYvRCHTaXjPe9XrNh8Cmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=itFcaWQu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FED7606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=itFcaWQu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F641F000C4;
	Tue, 24 Nov 2026 15:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795532828;
	bh=2MTKom1YcdMxbw6hMM463DJmBReBNMrsBMlMlgw2ZRI=;
	h=Subject:To:Cc:From:Date;
	b=itFcaWQum/d+vFuI/tY6MyZoCbq0gNiqjPR+ECqxhVZoSxbXbK2hi95Ri3XObOrd+
	 AT6gwNrX9knfT8r+A6bR+o6T4BNDMkAhQjkJrTrt96m8zFk3zbPdD5sRuz90U7boAa
	 bde7i2SN4r7n7hgm/nhU4+/mCQ/jNp/On57giyTc=
Subject: FAILED: patch "[PATCH] ALSA: hda: Fix [codec] ID matching in patch files for IDs" failed to apply to 6.1-stable tree
To: andy@dvsn.net,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:07:21 +0100
Message-ID: <2026112421-manliness-rearrange-1a66@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fda103c1432f344e1cd548f346d157b1e67ee7c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112421-manliness-rearrange-1a66@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fda103c1432f344e1cd548f346d157b1e67ee7c5 Mon Sep 17 00:00:00 2001
From: Andrew Davison <andy@dvsn.net>
Date: Fri, 6 Nov 2026 17:55:18 +0000
Subject: [PATCH] ALSA: hda: Fix [codec] ID matching in patch files for IDs
 with bit 31 set

parse_codec_mode() reads the vendor and subsystem IDs of a patch file's
[codec] line into an int, and skips the check when the value is zero or
negative, as documented. An ID with bit 31 set, such as SigmaTel's
0x8384xxxx or Intel's 0x8086xxxx, comes out negative, so it is taken as
a wildcard and the section is applied to every codec instead of the one
it names.

This was seen on an OpenPeak OpenFrame 2 with an IDT 92HD75B2X5
(0x111d7608). A patch file written for the STAC9202 (0x83847632) in the
related OpenFrame 1 was applied to it, swapping the headphone and
speaker pin configurations, so auto-mute never muted the speaker.

Read the IDs as long long, so real IDs are compared exactly. Values
written as negative numbers (e.g. -1) still act as wildcards, as
documented; a hex value such as 0xffffffff is now compared as written.

Tested on 6.18.60 on an OpenFrame 2, with a rebuilt snd-hda-codec and
the STAC9202 patch file: user_pin_configs stays empty for the IDT codec,
and the headphone and line-out pins are assigned as the BIOS sets them.
Not tested on a STAC9202 itself.

The bug was tracked down and this fix written with an AI coding
assistant (Claude Code, Claude Opus 5.5), which also ran the tests
above. I have reviewed the change and the tests.

Fixes: ef940b0403d4 ("ALSA: hda - Allow patching with any vendor/subsystem ids")
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Davison <andy@dvsn.net>
Link: https://patch.msgid.link/20261106175518.18629-1-andy@dvsn.net
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/hda/common/sysfs.c b/sound/hda/common/sysfs.c
index bf65223fde10..b354cbbc3dc9 100644
--- a/sound/hda/common/sysfs.c
+++ b/sound/hda/common/sysfs.c
@@ -512,11 +512,12 @@ static inline int strmatch(const char *a, const char *b)
 static void parse_codec_mode(char *buf, struct hda_bus *bus,
 			     struct hda_codec **codecp)
 {
-	int vendorid, subid, caddr;
+	long long vendorid, subid;
+	int caddr;
 	struct hda_codec *codec;
 
 	*codecp = NULL;
-	if (sscanf(buf, "%i %i %i", &vendorid, &subid, &caddr) == 3) {
+	if (sscanf(buf, "%lli %lli %i", &vendorid, &subid, &caddr) == 3) {
 		list_for_each_codec(codec, bus) {
 			if ((vendorid <= 0 || codec->core.vendor_id == vendorid) &&
 			    (subid <= 0 || codec->core.subsystem_id == subid) &&

