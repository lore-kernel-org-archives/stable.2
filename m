Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532831;
	b=dsXfJswxKRKDPRnL4ctEhmbzZWNOaPIXYyZE9z5YR5IrygOMLrHE4CteTT35L7azm8f2
	 vEAj/Nw8451EOmK2pr2a816FHGPQxUZ3hlbOr6y/AzuPCs9D8vQz6Afs6krwr684+hEUZ
	 jPr8dKoxY5rN7fegavTjAVV3A8ubSmS/p77TamGpsBYY+YL2lJdnUcyc0oXWa2MLQFfPe
	 WcM4+EkT4TQZEmG98b43iG8CrnClA5TMdRpl9djooneVBtMThnRZ1+6dCZ6LkfVo0exAY
	 hyajVLlczWL2V/++1u8VUOyomfJ2Hap0sJZvxadAtc2FFxHRwk8jOhEIW+FTNzhrCnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532831;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=o2wKPP3X1aNtxbORTZ8YCkcd22vucVvX2rpXesY+Qpk=;
	b=GMKUnZU9IMSqqVLMTk1Dr5/n1HGmqjVjSKLupUmwwAMo6DiVmrH6l4+3kqtxGBiRrlov
	 yXAO6wPpkY67sG5VKVLeNh/joz7cuT3ZxBDT75fjj03l6z9Fjd9hfnqWhykdbV/Pl35aU
	 Bn3VnnlUBxoyUouazmtJIVil6h4gjyhZQB5njAM8gNAsKObTw/QfgVAyUaUCIkZipf6Cu
	 uWI7J/WaG+L4qlygIZpgPhvhY9+S1HbQXDWbX9MGn2x7nfIKIV1G3NTXzBzoKJmk2UG5I
	 6IEn9DEw4Yb8valOtlvgYs77eH5Xak4mE9AEB1LUrtgU71KW1I2VaK4aknYz70gg/gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1eNjlVRG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89963606A32A
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1eNjlVRG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943B81F000CF;
	Tue, 24 Nov 2026 15:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795532831;
	bh=o2wKPP3X1aNtxbORTZ8YCkcd22vucVvX2rpXesY+Qpk=;
	h=Subject:To:Cc:From:Date;
	b=1eNjlVRGHTcccBrlqrFYmWqcYTfU5ZY7oT+/rIkApVZ2vTcjoCN5XiqJw1Q/opStp
	 M/uOvbc+hdBA0C3T/w5X65kR+HUVgaUWYMcAblRpHnqfGJANSRPXBNP9mBUJHQ8YFQ
	 JL+kFT+B2q56wNJeI295IR0VXp9s2TUVrONHa14Y=
Subject: FAILED: patch "[PATCH] ALSA: hda: Fix [codec] ID matching in patch files for IDs" failed to apply to 6.6-stable tree
To: andy@dvsn.net,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:07:21 +0100
Message-ID: <2026112420-tidiness-stash-67e4@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fda103c1432f344e1cd548f346d157b1e67ee7c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112420-tidiness-stash-67e4@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

