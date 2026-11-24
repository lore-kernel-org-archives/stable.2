Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536608;
	b=aLAvr1NllIJ3tcaeEHyVy2X7UpTqyikBSCz0kmjULlfZ41ZTGLRhw43la5uftB6+88xW
	 VeuwvTIPp2jtdqUEEFz3jRgdSJzvIpOQ9dClC2PMesRRCwb++2W4WL/lUdLn/boi+6P08
	 PvMf+l81VDlB4TaskxzqYtyuqQh69CQevLhMOPp/86OzFtdWUFHZck9LMXKGKtqIu5S5s
	 /hOHmLqkrfcCxaNhkO/tQYmpT0mBxqWW79Z23lm575s6zu1DPnh8jmbEDrw6fJG6wzVTo
	 5GT/dz9yCjaYZL3SViKXZMaTTrzKaYzQpFqUj8OiTiwMPyNP3Iq8J7CKm8Eq4zAzskA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536608;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aQkeTZmH8XpsI1Oreh3/KpwYWaBoDdXydZ5E4OkTTLg=;
	b=Qtt/+ZrPCGeFxUxkN2F5YEuiawDh6h7arwDkVeB5Y6Q0pSV3JEtDGiUhGX6GUFbl28HB
	 gyIagJ2IEGp5lHS4cE9j0EvS5ZLo2rkQWOunWs4eM0U5Yr6sSFE99QbbkJUDFfdfbrPGl
	 6Qk26kcU/s0vJfRzH0b6CZxqkGnnGHPrKzKQX29C1w9FnzQYwt2bUxRzM4l8OwFbYEMUg
	 eBKnXH6/KCWk9w8bAzzi+Vn/Czjt7VjEhBc/Mb5obsRyieNwfwyyZFxyY4Jf/g5GGHZHZ
	 nABiOV6ebdndFrAidbb5mDV+t5FoMgehRnj5MRANyhs/4O/Dlb6BxjBtrT4+lNzpffQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AqjXipBv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CEE606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AqjXipBv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640AE1F000D3;
	Tue, 24 Nov 2026 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795536607;
	bh=aQkeTZmH8XpsI1Oreh3/KpwYWaBoDdXydZ5E4OkTTLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AqjXipBvnC9lkakohqqBgBeFRfCsUL88/02M7bqvGMSa+7Ow9aqniz3ReqG5JM/Ae
	 lJYWNMJFJbTTUVtCvDac7T56XDm2Qy0D34AgJxAeJ4vD7YLaXnoiALbRc7CjR0KPL7
	 TznuJOppCM/bF5J2CXVAroifyNt4j055vcFBKU1IVj1ElqQ2iCRklRxeVnjR2O+gNn
	 u/0pgFnN5Qq2gJ2ujc41Lh25oiOk1wX4sNumNsdwiaxabhtYEE+F1I4i4YQoT0kHmU
	 Lx4aPQN3pPB7TbCB11mL25BCxcfE6w1pOomQ8tvcuEY242vLYalHLsXawdxh95KKru
	 mFWlJxKdAX0Wg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrew Davison <andy@dvsn.net>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: hda: Fix [codec] ID matching in patch files for IDs with bit 31 set
Date: Tue, 24 Nov 2026 11:10:06 -0500
Message-ID: <20261124160953.902289-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112422-autism-skimpily-3a64@gregkh>
References: <2026112422-autism-skimpily-3a64@gregkh>
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

