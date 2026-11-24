Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535493;
	b=41F8+dSR6qYmTqaXIVnkiZn9/SkmbQQD6L4wvCTNRoGlqCj+EfoWdDpSdMy3QZc0E3vy
	 8JB1mFQZ99t2bCMiYJ1DsZjV+ZQApEG2vsYvVYjmRKMEVUCnZkwPW+qYsAfYBEvuVLevs
	 +PU8A/2GwGOUsdDB9sUasimIFthhWa3aAGjqfFOW05VrNgAkidEmdP7QYWN0go2PsET1g
	 xOoOrafgXUZFFHuijsUatEYU3uDrEY0k3prVSwUx35xdLv4pvnSp2NJVHrUDTjSgQhlUQ
	 zPwK1GDySPIae/c9TnB3lAL/xRDuf07th/36AAEzFPZ2/hBKbz2a3BOz8xneM5JfcmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535493;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mv0G3BzOhrhSX9tvbzsbgQp5RzNaUxj2G/XuPLqr1uk=;
	b=lEYF4JllUzPi7aISY4n194Td0wlyW9jfG7McGDX/2wg/awL30jFGuhDs9l7emiLJK+3U
	 adBz9AQW4NeVovSV7omHeBGKNEa0jmKUI68Daf2SoJ71kNdycAwflts/FmCgpYB98P8+q
	 9K4N99aEITHUT4iFnMMgDDvge/0zdnJ76qSXlZu0d5fJ7uH+rRKaTKM6LyPuen3iOA9yD
	 vxikzfxdyxnMupNZFo6A+0+98rVLEmrl1Ea8ZgpKUljAhy3GXnOG8T/iJ1Y/ES/FXLNEC
	 sVwWEPpjI9WJcPRGWcx2t/2RGm+w0xMUENEU2Du6AoqYyXcscj17EOEVWFLOi4Ah8LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9Y+LiC7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB5606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9Y+LiC7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD9F1F000D2;
	Tue, 24 Nov 2026 15:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535493;
	bh=mv0G3BzOhrhSX9tvbzsbgQp5RzNaUxj2G/XuPLqr1uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B9Y+LiC71eSB0Lbg5H435zaOvJ6pHTUeNcQOCs4JZrdlYg1D6EmGjxk0muiRA7ZYx
	 fHxmzOKx1UP7TOlNgwHSnoiKgaB8zSWsM/1+lBgDF5nezbHOAbg/qniKUxH9i5R0sk
	 bSofiH13P5ujsHJDrbsizrhoDSTxw6P63oFVR3DfZjVLvdsCC6O3S78u0G4O7r/Vme
	 jtyw53stWISm/D2SRH65f/MG3i7Rm9fOKS037mPgxN71Wd0wiliyRPiwGQoiJDg4Bo
	 b3szVKtrFtVn/DQKyZhXVazSz4jaL1TyF8V2pe7UIddteGAmdYWbACM4mloG30Of3y
	 fJV2mF1jiHo1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrew Davison <andy@dvsn.net>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ALSA: hda: Fix [codec] ID matching in patch files for IDs with bit 31 set
Date: Tue, 24 Nov 2026 10:51:31 -0500
Message-ID: <20261124155126.790316-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112420-tidiness-stash-67e4@gregkh>
References: <2026112420-tidiness-stash-67e4@gregkh>
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
index bd3686d60555e..25fe3ac2c0389 100644
--- a/sound/pci/hda/hda_sysfs.c
+++ b/sound/pci/hda/hda_sysfs.c
@@ -522,11 +522,12 @@ static inline int strmatch(const char *a, const char *b)
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

