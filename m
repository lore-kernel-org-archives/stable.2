Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536173;
	b=qdUj5axnRm0Kc96fx5jACQOIYpu2dKKNWLBDzGbWjLdZIqAUIl4Xqubi0zUnzTwOFngV
	 tyH7HcAoUyhhZ3vdeTFvLo3ikKL+3tKgdDurrd1+QWHseM3xVAhlIaH7srUyF5jByoyRC
	 gYMIMjmUBQ4EB05O8lHC6pdEzpg5E3WkJuFU/F5nmHA9ZvscWbck3FPGF4HirmqBW6vWF
	 nz3eMrR7hLBsQndy8hRi0xeWq1c+YYq7kSltk7YETJ9j1jV11MgNMlOt/8E7fJD0H/+7a
	 bhCQwVxLLo4txFdVo1FlfnqO74GBCnnyBkhBiVUG7dy/RY6+SX3kg6Geb1hEeT3i0dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536173;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aQkeTZmH8XpsI1Oreh3/KpwYWaBoDdXydZ5E4OkTTLg=;
	b=Nqx5iNmzY8k7ZHwsY/V+Er3wRxLwA1RyZUhWpeOJ1t3A1Dn23pE96TLJWV8mzG1qLfmR
	 X/kcozMyRhxLMgKjHvXc7cNk6wKQKfX8lkYJzQPBppzL+7KjOs5Rr8ndXlURH4ruLiNke
	 XdBenO0QXi1TuC9L/N6pozgWRYzqymjS/gGi9aZv2dLBYV7jaIyTr4fiO/gFKGLoy3w+K
	 xWCiM9c/4e+lHc1QqO91l9eqg3wzIhIxIQ2efsqXfpFJwYvNH0iHi0/CwYjBH5si6/JDX
	 YesYlLHmN4E50aKOmT8WJo1yR6LquAN57iQUBNRDLUcVJafelnXGlyCMj5N81R8Ie7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTA2yGmL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8041E606A335
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTA2yGmL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFA01F000F2;
	Tue, 24 Nov 2026 16:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795536173;
	bh=aQkeTZmH8XpsI1Oreh3/KpwYWaBoDdXydZ5E4OkTTLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jTA2yGmLA4+xz8Lf+Yj/+UYSBInpk8bojgxDI3OPSzN4YCbwhWLW61r778nCmNJ0I
	 SoTxXOkckhpjMNLLadyhl2rNEewh4BOEFF5xkxMb3oxdrXyoU0OiaRsnfwCsGyLXJD
	 kBAqBDh25ex89I0MROZND/5vN+T1poWGB+R4BQqPxHtIwrVmljH9aa3jH7GLsvh/lT
	 9+ERewYS4SWDxn3cj1P6GhYC0RhrgQ5CxIQLok7Ii6sniwWWm0C+SLFFYbUQBs+4A7
	 4iFCX+Q6QGTzJ2vN7YpJEZVDb05CPLW+Z5cNEzgpkxi1Kk/JKkQQQqU8Ph1eexOLEl
	 m2ufUEcl+w5Nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrew Davison <andy@dvsn.net>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: hda: Fix [codec] ID matching in patch files for IDs with bit 31 set
Date: Tue, 24 Nov 2026 11:02:51 -0500
Message-ID: <20261124160239.864810-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112422-engorge-chief-3b0f@gregkh>
References: <2026112422-engorge-chief-3b0f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Davison <andy@dvsn.net>

[ Upstream commit fda103c1432f344e1cd548f346d157b1e67ee7c5 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_sysfs.c b/sound/pci/hda/hda_sysfs.c
index 4d8410216c3e5..7c9eb4662b2dd 100644
--- a/sound/pci/hda/hda_sysfs.c
+++ b/sound/pci/hda/hda_sysfs.c
@@ -544,11 +544,12 @@ static inline int strmatch(const char *a, const char *b)
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
-- 
2.53.0

