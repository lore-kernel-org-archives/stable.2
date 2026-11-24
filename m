Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534929;
	b=iq3OASViE3HuuBqg/CS0YjKkMs9iwFOnynkgvhF04eUMXmflokCfue77Aga/e4azhiD3
	 +uKDniS48e4XVv7CMyOo+yOA9LDz5dAJiIy+7vkN16z+L6zZfRoQ4wMrYHdKkxMaTY0sH
	 8OGi1CTV2z3q1JF/QTSKM3cX5nspF2oRoei1OAfqlHrAyCuekTzVoRzCSQf8NuOaks7qN
	 glyCC4I0z9aaDFfp63gkyTcZspSTrz5gCZaF+cxUyxSlo41smdrNlhz/JuI7TxjJC30aP
	 EGQbP081KZk5dKvuwP3gR9VnFOeFXFd/muJlXtpq8UTUfjdBVaJVeZJhFTY2DBwZKIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534929;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rVP9wl3VunTWgKaPdNZy2OF/AnthAYjDVJYNAOWSczM=;
	b=1QgRYiEbOUUP8/yaD5LK1GPpHX8wHDVocDZ8l4bntelKcop1IGVj/c9Lg//6d2L7vbg5
	 8e0MQkPPRLfZ4s41FzQjOYcx/QNDakMh3hOvraFzSzlL/p2kLNhNhkehT2WFrScwPfrxk
	 9/IVJ/4+h20bzDsFbA4RptIuoXGu+/4Ka9Ttb8fVfp88tb33tb5lyYBuVbX1I6pmVNmnu
	 h60jwHXhDx+exF5hPkJDPS0UlQrX6ubbagHgPmYPmBhGpAqGw0eYKygbwxQKosIx6dLbp
	 84nGpzBkg/7tFqA5sBpFjFfhWVwfStjkvb+41YvYLC6WlN+GBuLh56dSsPCn1IJbGaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGkoddxY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A10606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGkoddxY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0921F000C4;
	Tue, 24 Nov 2026 15:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534929;
	bh=rVP9wl3VunTWgKaPdNZy2OF/AnthAYjDVJYNAOWSczM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XGkoddxYigV1IWUiRhdMzv2AQ0ojOJuT1HU3ovXB4Mt601oL82CZzuH+d4q06G/dv
	 DWbZljWVyS/Vn3vhKt8KOpKzTwBNfBBEZenT7SasokKDHkT8Xx8JLuwXdGBR6JpYo6
	 23wZ+JyMV8dcd2LIBzDCKDc/tgzDFIFMiMsssN16KuLR3WQAXQKRuavPaJe5+yIgMb
	 YSDGYn+Z7ADVk6/dTG+5grZ4YkjrOVbotBcFlFIAxMnfuEodE/DGkiroijQMk0/y+k
	 tDz3tC1PxjgavtW+p+aaaM14bPXpviAmnyeWm+bA3g8/J/gR18x7GGeU8uc3UNsSLj
	 kdH9EXKn29+kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrew Davison <andy@dvsn.net>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ALSA: hda: Fix [codec] ID matching in patch files for IDs with bit 31 set
Date: Tue, 24 Nov 2026 10:42:07 -0500
Message-ID: <20261124154202.24051-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112420-stunt-sharply-51f3@gregkh>
References: <2026112420-stunt-sharply-51f3@gregkh>
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
index c6081f3c1ccd8..47b29e163ac0c 100644
--- a/sound/pci/hda/hda_sysfs.c
+++ b/sound/pci/hda/hda_sysfs.c
@@ -520,11 +520,12 @@ static inline int strmatch(const char *a, const char *b)
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

