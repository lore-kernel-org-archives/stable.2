Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535703;
	b=tQ28VIHuPNBEVnUIeTPGQ89jgg+dJiGJgrau5j5ZbYVf+VrGoaX97QghAolorfkPLiJq
	 4w/wFaWA1zGYaMlqvuosDLYW6tHQObZ1ao+n/hmPk+5IFcERLx83N8n6DxVHi48PWy+JT
	 powaG9fpfl8ZHTjudM5R06y3nl2ZLO2cbDwJAh4UoboQvRTEaiP2L7/x6v0kyBeLAELsw
	 OMU6kh6Kmj8n1EhKWuaaNyNcVnh3n9F1iplGpJkAxTRh7SFVBi+zAYiy+zAOWXf8EJc4b
	 ReOKitN5OTh5nTLwCCWzeyjOYMF8Gt/Y8GNr6LmbzI0kgfzrT0rCyHICver3x17q6qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535703;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mv0G3BzOhrhSX9tvbzsbgQp5RzNaUxj2G/XuPLqr1uk=;
	b=wprvPjY6w5QCBTp3cyL7NpArfWGb6yqORBVgV52kAsTC4aW75May+2GMINxT4dkgIntO
	 G8TlkqeI8Ou7D5bUqlfXUFX2g8ldxPO389yNS7AWe448lVRXBYuggY5PXH314rAmW6cNC
	 FX4lUsKiD47ogbtpuwv2LL3A3b9m1RwLMV9/0aMq4mV5cra753F66tbad0ZJVij3DEqXe
	 q9z46GzwqXOmQL8XnKpu7bKWaMdjVzR1NuebWx84RFfuArpyHY0qpmwtRnC+9ugCGUbV7
	 ti/X+uJ3QozTbbZzxezNE73O6Miu/4nSP6tbWRBNbqL0wdlIacXUl/vVVE97dvwn68Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V5b+h4/C";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79584606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V5b+h4/C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD23F1F000D4;
	Tue, 24 Nov 2026 15:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535703;
	bh=mv0G3BzOhrhSX9tvbzsbgQp5RzNaUxj2G/XuPLqr1uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V5b+h4/C33NqEypp3C/SoPyNWjY3zX1go0AMH5H9CbHELrOUdj0mILgvmby0b6qiV
	 4aLuVRtR4cUNww94ZUlahlUMBrtoGTkdqo4KqzLiVB1x+3ObDvmc4+O2Ry2tv3/94Q
	 sd123ZVAqcanE1ZX1+z42tg3TAYD0FS1VtSKX4Uxs7xxQJAr2D+wq5l6GS+eIueL4n
	 c4Wr8TwIhPJ77JrF5Ct7hF2B6XOZcMYqzRxHejHLtt4jScqQYZlprdDpT/RQfNk/u3
	 Ob/OS9B64hxjJfBg9IJAY5hbFhulMCOQKSveM7Tt7txlR5j4MhMRjUTdAh9ijGSTsm
	 6jBukR+urbu5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrew Davison <andy@dvsn.net>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: hda: Fix [codec] ID matching in patch files for IDs with bit 31 set
Date: Tue, 24 Nov 2026 10:55:01 -0500
Message-ID: <20261124155453.854769-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112421-manliness-rearrange-1a66@gregkh>
References: <2026112421-manliness-rearrange-1a66@gregkh>
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

