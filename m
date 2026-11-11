Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=89.221.237.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794422066;
	b=cw6FeOThy255IfoDuFP6JNMYdgaHL6B8ojsbKMcIFPmQZunXUwOhdWVvNYvhVnpoVhIT
	 ARyRqa2aJtr2ZKfzzPNekZ8QPrN9bqGrP8qeVlK8+UrMqnhWy9kOUYpST2U+MkqA5GnUM
	 ugMsbBNIlmtd9HxzukwsoL/LWtCEo3CElS2MwFeece05CsrysTFufZ3k7G0wX3tQE8G9r
	 +IFMD5ccsVvn2ee0pfkISryI+LBaK8p/mxvqb4cu2pIlWlBzz2EL6yT/ik4AzYzsUAcL4
	 u834F6tsIaKTnbcEJLlRkVW2AAJNXb1r8aUil7Xk10Achwx0xoeWxXEPfR0shTpd3Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794422066;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailru-Src:X-7564579A:X-77F55803:
	 X-7FA49CB5:X-87b9d050:X-C1DE0DAB:X-C8649E89:X-D57D3AED:
	 X-Mailru-Sender:X-Mras;
	bh=S0F9ZIvyMyU9dQO0D1GoKw4EGfFJ42cjmlm9MA19jN0=;
	b=gTwRMPJoEn30QNzt3N1LRDCYOidXYOgAZUxGJqeLacfSVG9/z608DhZYbbOfULa9Wyw7
	 l5/X2PYXhLtL1f3ecZuh+OuvHFdNtoEX5XhQHlAF8cGwTSMYmjyvwx9FU7FE/GRmJa6go
	 ODP8lXbJaTfKSMdTWeXMoj8WtFUcIoJmJ3b+Y9gbv6U8OEt1fD8ijlD034hPZ/jA4AJL3
	 m9NjAAEBzpgX5YlHDyd3MiuYqVl00gF0bzDltLM+t5Ym1q8FP/InWHyOivR+RwUvs1LBe
	 aT7Lrd2E4p5PvZ5SLC8Qg8lZ3OteY50/FE//2IdjhjV44FEfGomxKNh/JwBiLObsevA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ru;
	spf=pass smtp.mailfrom=mail.ru;
	dkim=pass header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=hPVOAIA9;
	arc=none smtp.remote-ip=89.221.237.198
Received: from send103.i.mail.ru (send103.i.mail.ru [89.221.237.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E420606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E420606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=hPVOAIA9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=S0F9ZIvyMyU9dQO0D1GoKw4EGfFJ42cjmlm9MA19jN0=; t=1794422065; x=1794512065; 
	b=hPVOAIA9n8Cy3iOM8wKf0eeJ9dGqcvDzUqj98F8Hnr2Alv3CZyclBXqRylMXlhiMDwH73BeeiSI
	RhYgKVOa/X8oaUbdOXFav/4sKr87yKHVe6O8n3szfSLA43SGvcJAjhYVDrKhYJ+zjM3/lgnuh9n0D
	a+VAgirL/5Am6R6FhqL+Z/gdv2Zm/lrUX2xA3XIiEgIqnDSCrlyat5Nm3SikrPVViTlf6v4ryCQi0
	t4X6QXhh9Gd7oZaSArpCLc29OlKWbtT4P1GrJ4xX12F1+YVXNVQRolM2WPrjymLz2VsPfJeT9ApWD
	/aCeRNBR1pEGnqXHgGWqa1fhCn0qvgGpOY5w==;
Received: by exim-smtp-bccb94844-d9wvd with esmtpa (envelope-from <youdoit@mail.ru>)
	id 1xRD9D-00000000EVj-1PMU; Wed, 11 Nov 2026 21:34:16 +0300
From: Alexandr <youdoit@mail.ru>
To: stable@vger.kernel.org
Cc: Alexandr <youdoit@mail.ru>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.12.y 2/2] ALSA: hda/realtek: Enable mute and mic-mute LEDs on HP ENVY 17-cr0xxx
Date: Thu, 12 Nov 2026 01:34:04 +0700
Message-ID: <20261111183404.505834-2-youdoit@mail.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111183404.505834-1-youdoit@mail.ru>
References: <20261109201008-failed-6.12-cf79cc4996bf@kernel.org>
 <20261111183404.505834-1-youdoit@mail.ru>
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
Authentication-Results: exim-smtp-bccb94844-d9wvd; auth=pass smtp.auth=youdoit@mail.ru smtp.mailfrom=youdoit@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9CC39C64ECE24C2D724F75A7580EDDE80564B6050E4208C6E182A05F5380850402EA610D416774F083DE06ABAFEAF6705D5EBE0FB3C1F089B321DE9BADEFBF3F170001EC1C84847AC
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE781307CBDB76B677BEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375661F398E59D6539FAA6B0999E8C515627C7556AE82F2329521D299DDD54E958A0E8EEF46B7454FC60B9742502CCDD46D0DD2DCF9CF1F528DBCF6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C02CC0D3CB04F14752D2E47CDBA5A96583BA9C0B312567BB231DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B639F586CD7F3602AE089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A58C2107F7660982215002B1117B3ED69661AAA02824D0D53692212597CCBD6D77823CB91A9FED034534781492E4B8EEADB0A1B66E9F5C9ED4C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659A0C2BC9AF1744EAEA2662F454DA89CFF3A3B2F9CE5199EB3E234751CCF2EB3CD75AFF0E0AF4B97D8B8341EE9D5BE9A0A7F6184C264490C68882F067DE84F05EF85DDEA57C9B3942E6536EB022892E5344C41F94D744909CE4591FCB8D00C8C84080F08AC505DDD05964550E41902C4E4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWNIxu5loXKZtl/VZul3y37o=
X-Mailru-Sender: 689FA8AB762F73937C9FA53A4753B313346DA11443579FA3660D31C753B0C4B7FC6B6E44D42F67724F253F9D88F061EE46F9BC90A97DB1381F772815743FA20293D2455D34AB5A3F417D46434317A4F1EB5304D247585729B4A721A3011E896F
X-Mras: Ok

commit cf79cc4996bf936fe159af2a600519b3ebd4ccb7 upstream.

The HP ENVY Laptop 17-cr0xxx (subsystem ID 103c:8a2e) has mute and
mic-mute LEDs on the F8 and F5 keys that never light up on Linux: the
existing quirk entry only sets up the CS35L41 amplifiers.

The board uses the same LED wiring as the HP ENVY x360 15-ey0xxx
(103c:8a31): the mute LED is driven by COEF 0x0b bits 3:2 and the
mic-mute LED by GPIO2 with inverted polarity. Both were verified with
hda-verb on the actual hardware. Switch the entry to
ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS, which chains the amplifier
setup with ALC245_FIXUP_HP_X360_MUTE_LEDS, and use the DMI product name
of the board.

Fixes: aa8e3ef4fe53 ("ALSA: hda/realtek: Add quirks for various HP ENVY models")
Cc: <stable@vger.kernel.org>
Signed-off-by: Alexandr <youdoit@mail.ru>
Link: https://patch.msgid.link/20261103142121.74032-1-youdoit@mail.ru
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ Alexandr: the driver lives in sound/pci/hda/patch_realtek.c in 6.12.y; the 0x8a31 context line differs ]
Signed-off-by: Alexandr <youdoit@mail.ru>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index edda7cb34..dea1bd899 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11088,7 +11088,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a2b, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a2c, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a2d, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8a2e, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8a2e, "HP ENVY Laptop 17-cr0xxx", ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8a30, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a31, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a4f, "HP Victus 15-fa0xxx (MB 8A4F)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
-- 
2.56.0

