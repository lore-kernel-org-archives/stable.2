Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.163.59.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794422037;
	b=CPup5jGk3YpWcftWB4BUvnV3fzgFfHsTnpMfhu0XNnBcXt4w+w1e19HFXj7dEUWdIdxf
	 FQXkWtujlXWYRVSmwOJeQn5zjyr7/zc3W7QTG0DU4zXuAIkSRSfA11iftHZ6fVQtKOsPo
	 XBIngg5aWIGOTwKQgsdwTKPym62FGtbmr7vURvml0Z5CMFiXAdASSvF6x+FxcqeWsBNVT
	 m4UqV44GHPm8MLGyIowI1rSCwy+T0XcWowhqBnHO0qXjq5jrYuYLhCe901cOGzUWPu10p
	 GEylK+U0aBsv063c0btPCbpRv1mUQLDDNybJEgeBupfK61yRgYfO/eQUjsJdfzJ2ULQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794422037;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailru-Src:X-7564579A:X-77F55803:
	 X-7FA49CB5:X-87b9d050:X-C1DE0DAB:X-C8649E89:X-D57D3AED:
	 X-Mailru-Sender:X-Mras;
	bh=EuYOlPRF34XyZN6JyQzLBo5JyxiC6Eeh+vzBhofsAxg=;
	b=hqER8+H0IxUsCpNpL+7o1kXp/SKfBECwKSIljkyIH3YpsTamG8yX1mMEUdmIQHkuPX/u
	 F3XzQyaUsfJKAPDgmDNbGZIU8mQm06vjZQQZiIiMrpcH7pdtFxt3K/h2TQB8rYNxtryBS
	 wzOTlzi8+7MIcPwtjJBN44+2AJj6IdPj/8sXsohdmSuHXxF4gMUptU1WpyMZCZTMS/DYi
	 853M+QMrwr15EoAWN6RUGDfA76PTCvgBBIdKQmKwRb2bCItgWY/TkhY2jnXGvLbC8jBOt
	 gwWy/PpyVr+zqYo+vcKDfdITt8sVd7Taa1s+HVeZh39fuyW5TiLBr0xq7uo+yB3dJbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ru;
	spf=pass smtp.mailfrom=mail.ru;
	dkim=pass header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=XHaQ1AHQ;
	arc=none smtp.remote-ip=95.163.59.56
Received: from send217.i.mail.ru (send217.i.mail.ru [95.163.59.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EDC606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3EDC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=XHaQ1AHQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=EuYOlPRF34XyZN6JyQzLBo5JyxiC6Eeh+vzBhofsAxg=; t=1794422036; x=1794512036; 
	b=XHaQ1AHQRvHRGWPjuD7Q3Bv5aDjHro+bhK/XYK/ABlU0fgfBCV2nQ4NCIhGF9uiI/rHoWaWDkUf
	zZbgnE5NTWQSTfm/GW5AlHY4+fDj7V2jeJpgjLhpa21BuLEV5HaOoPjQbnw3JxHFS0LVi0yL6+Kwz
	+N0CMW2bZ+PYiT6xiz7WkAJT+XGv4LQC5W/9mEmncWzs6lZW1iOHEjlJ7zePfyuCwsvdWuW5mZUZu
	xC2ZUK6Gt0TXP0lAikI6sROnTBiUUeeXb/qto8szujYH43ccQ9gRvyXNiV3ScPm3Y0obkjQ4Ow+ah
	A+fTI/4p+FoUUleLpq9EIqRwduYJbpObyybw==;
Received: by exim-smtp-canary-10-56f4b486d4-fvfns with esmtpa (envelope-from <youdoit@mail.ru>)
	id 1xRD8l-00000000OVz-1Okn; Wed, 11 Nov 2026 21:33:48 +0300
From: Alexandr <youdoit@mail.ru>
To: stable@vger.kernel.org
Cc: Alexandr <youdoit@mail.ru>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.18.y 2/2] ALSA: hda/realtek: Enable mute and mic-mute LEDs on HP ENVY 17-cr0xxx
Date: Thu, 12 Nov 2026 01:33:41 +0700
Message-ID: <20261111183341.505519-2-youdoit@mail.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111183341.505519-1-youdoit@mail.ru>
References: <20261109200552-failed-6.18-cf79cc4996bf@kernel.org>
 <20261111183341.505519-1-youdoit@mail.ru>
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
Authentication-Results: exim-smtp-canary-10-56f4b486d4-fvfns; auth=pass smtp.auth=youdoit@mail.ru smtp.mailfrom=youdoit@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9CC39C64ECE24C2D7142C69BBFDA6F654EA84A054FDCD7DE1182A05F538085040349D9310E931F0603DE06ABAFEAF6705FC1256E0E09D51E5321DE9BADEFBF3F1C8A878373477942C
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7023D31FF4FEF767AEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375661F398E59D6539FAAE4D436C28D2C41AAF1308C2A8CC1036985715F7AE97297458EEF46B7454FC60B9742502CCDD46D0D1D471462564A2E19F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C02CC0D3CB04F14752D2E47CDBA5A96583BA9C0B312567BB231DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6C27FC099294B873A089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A5D7B6F8B23FEFC6015002B1117B3ED6964BCCE04E4A67CAF954BB1175C6E7DD94823CB91A9FED034534781492E4B8EEADF12279BA039A6965C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659180A4E6370B243167DEC06EFE8173B9D9A5893CC3CBCFFECEB97F95CD251DC85845E968461C24F69B8341EE9D5BE9A0AF26C2ED0A6A9BB9B476169A593DFD19FD756225FCB246CF86536EB022892E5344C41F94D744909CE4591FCB8D00C8C84080F08AC505DDD05964550E41902C4E4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWPVoAUpXDIwuAP+qXqN/L60=
X-Mailru-Sender: 689FA8AB762F73937C9FA53A4753B313B406E70BAFA6F11D1E52DBA4A99873453336CC635A53B2694F253F9D88F061EE46F9BC90A97DB1381F772815743FA20293D2455D34AB5A3F417D46434317A4F1EB5304D247585729B4A721A3011E896F
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
[ Alexandr: context adjustment, the 0x8a31 entry differs in 6.18.y ]
Signed-off-by: Alexandr <youdoit@mail.ru>
---
 sound/hda/codecs/realtek/alc269.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 2015be192..8938865b6 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6970,7 +6970,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a2b, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a2c, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a2d, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8a2e, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8a2e, "HP ENVY Laptop 17-cr0xxx", ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8a30, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a31, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a34, "HP Pavilion x360 2-in-1 Laptop 14-ek0xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
-- 
2.56.0

