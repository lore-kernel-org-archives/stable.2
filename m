Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532837;
	b=gBWrOu6Oiq6v11PCJ81Du4BVPMsB+9kqLKastZoi4R4BXIMtQ7j4dzGgWlGRclzVqLfu
	 tDrYLA7GcUAieWruP5okwYA1KKMwDrOhi9HMM3TEDuR2R7BweUZvBgIMx5JW5he1b9Kih
	 cQEcXzXid9g2mAWiubN9e1FZBu/jwlftSKNuAus1vb7waGrO9KVU664/J/0M1xil5k9os
	 AyZEe18UI84JvY0zDozjIBKj0pgzcohYbvShEWadUicLODxpcz1+gO2D/bk+5YsgKfidv
	 kQpf7YrJJOM1fAMt5SKZrk9abmiw9y4yRnwAYSnXYH2V5dPZ1SFHTQar/rs+YgS40CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532837;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fqCLHzjm6cj2tG/5nqIJnjwbE6JUX/isMRfzzCw0ZOA=;
	b=gbXyu3X084/WGEalERQUfocPJtnqUd3Hk6tKLYI7lgDwhCj3s6jXvoUGBFonEpEPNMWG
	 UlxV3vIWG2J7SIxi+DUZwy5Ik4ztk0pLTVKJb+63XyRldJIlRSfi30gc0S8dzTfQ3rjHy
	 gaYiY9txzf2+os+9Av6QMcyfqdYA+xPUqY+LwN1Znt82GYRSeWR49rhtbrV+NtM9L004c
	 /Curhs5HhXIK8OA/HaRGnmnXZXLrgAYBKfKHW12dH0MW4+tFY7xqYQzLRgjBJL3J7vhaX
	 ZQ9PlI4NyuWA+ugCwLDPh8/3F/2Ko58EU6hyH5sYF41c+M++WTHOwpCuSEdzY8FSo0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mQYHXjIe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DF2606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mQYHXjIe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752AC1F000D2;
	Tue, 24 Nov 2026 15:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795532837;
	bh=fqCLHzjm6cj2tG/5nqIJnjwbE6JUX/isMRfzzCw0ZOA=;
	h=Subject:To:Cc:From:Date;
	b=mQYHXjIeDjW+4wJG1kE33QbrAzR6g6yhU6f88PNEt22YY2ZnOvEsIm1fK5Z7pFen1
	 FR6ir9SzjKO2WD0096z90GiA5VYbC2uGOqlj0Qr8YIgFeueDqwPN+t+9X4H9cubQFD
	 UnFdHgqOVswOiKL+zoeVB/v7+IpGyP34h+jhugjw=
Subject: FAILED: patch "[PATCH] ALSA: hda: Fix [codec] ID matching in patch files for IDs" failed to apply to 5.15-stable tree
To: andy@dvsn.net,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:07:22 +0100
Message-ID: <2026112422-engorge-chief-3b0f@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fda103c1432f344e1cd548f346d157b1e67ee7c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112422-engorge-chief-3b0f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

