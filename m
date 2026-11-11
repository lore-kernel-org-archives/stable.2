Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=89.221.237.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794422035;
	b=vJy2RMHzy+/sq5ZgEcEjctB3cVZITP+y2eWQ1MF8P1Gie8WzXfga2BSrsSwHmdC+faBh
	 yFBUQaWo0B+ez8tjqtOZ+KP14cP4yq9Ck6VfkbXpZEPLHw7usbBJCCJHFEj8jGv19xWf7
	 DuYBH6jfzTPOCs344/dnEdH5govyvAnoe9RfykZcztZG/Acqbn2SA9hMLn01tNqSLOOc4
	 rqVxxTR9fzqhf8UIvq5z9GxeKBkJ8GZsF7zLXBELD/hw/CwaipQm1TC/w11w+95PKSGVg
	 MckushYxtUbuP30bXxSp7fa7xFy7QoaQ6PELFq8w4a/kD7RMniEuF7MfAKvflctMgqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794422035;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailru-Src:X-7564579A:X-77F55803:
	 X-7FA49CB5:X-87b9d050:X-C1DE0DAB:X-C8649E89:X-D57D3AED:
	 X-Mailru-Sender:X-Mras;
	bh=GW7ulPMGtn5x678gk+YHQjFJlLM280VXEps4MzFRsb4=;
	b=Y0zY0b3MlyIwMUA5fNhbUbhdjQXXlMJxPh5Hc08X0KO0sPssBcuNkCuR+yGn/UF8o+aW
	 miF1LtPXGjyDqpFfLmb+ytdOsJwxue6o211Cr1DudMgf16zvGA8qCoelzHLh9qeWFWt4k
	 hUbgAsuqdbwsBYqZxl60OzbnEPbN4EHxT9+5qunGUrWvg07NMO2yneHaXnjIVx2rcqenW
	 fc8/9q/oe4MYRmQmP1mywroL3WDakKWXfCVLMwvwGI40bvogYg4pZyErtoAMDrmh3d3Ol
	 Umk8oa5413MHk0dnCoigGpmjxhZOpXJiM5uUe4+YULn07L2aLD1MsctkRVAknkHxGvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ru;
	spf=pass smtp.mailfrom=mail.ru;
	dkim=pass header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=iaAU7LPM;
	arc=none smtp.remote-ip=89.221.237.153
Received: from send58.i.mail.ru (send58.i.mail.ru [89.221.237.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ABD606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02ABD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=iaAU7LPM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=GW7ulPMGtn5x678gk+YHQjFJlLM280VXEps4MzFRsb4=; t=1794422033; x=1794512033; 
	b=iaAU7LPM5AQEfvgVn0+S/WfJ7vns3yuME1rS0MC2gdCt6daq+YFiZHijmjWNOA6WJhaViTTIrFe
	edC/yER4QUMZwbj/3v9fSwJSyUl92PJt2JBf+WVpxNYFTYDTADqRHH8wXz9w2p6BozIgD8xI/g9KB
	Zic9vk2lus2yuQ5qyOnXvgh2RI8KQEFdLi5GlpICueHQlstXUGeTBgAhLqNgnnXGHIwqj5OXsM96P
	B5P3lxpe8kS1OAwif0n/pXtSQ6NTz/p4xiPuna8CgV8IKSAA9cclPylIIBIAjrgifhDuNGuvLlvEV
	5wvvmvlBwyH0kYuKqQnE5mWP4ZnGzLaOstrQ==;
Received: by exim-smtp-canary-10-56f4b486d4-fvfns with esmtpa (envelope-from <youdoit@mail.ru>)
	id 1xRD8i-00000000OVz-44cv; Wed, 11 Nov 2026 21:33:45 +0300
From: Alexandr <youdoit@mail.ru>
To: stable@vger.kernel.org
Cc: Jaeho Cho <jaeho2025@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Alexandr <youdoit@mail.ru>
Subject: [PATCH 6.18.y 1/2] ALSA: hda/realtek: Enable mute LEDs on HP OmniBook 7 17-dc0xxx
Date: Thu, 12 Nov 2026 01:33:40 +0700
Message-ID: <20261111183341.505519-1-youdoit@mail.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109200552-failed-6.18-cf79cc4996bf@kernel.org>
References: <20261109200552-failed-6.18-cf79cc4996bf@kernel.org>
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
X-77F55803: 4F1203BC0FB41BD9CC39C64ECE24C2D778A6C771311B98141231E6543E2E9AF9182A05F5380850408310A1781F5300873DE06ABAFEAF6705811FEC66979D6A2A321DE9BADEFBF3F13C5A36B8DDD67158
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE791B57183A2B7E75BEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006371D5B197C6EC5B4BE8638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B235DABB641C4355802E070BE324C7D3C48495D27A037D6828BB0A4F435E46E6718B35066C979671628AA50765F7900637D0FEED2715E18529389733CBF5DBD5E9D5E8D9A59859A8B6042F1592492B88C6CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB86D1867E19FE14079C09775C1D3CA48CF17B107DEF921CE791DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3164D43BA59B60CEC35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A5A55DB19C2F2223005002B1117B3ED6966F036440FB4DE033CA7E60A991436CA2823CB91A9FED034534781492E4B8EEADB71243024C627CEAC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6598B347705FEA9B1989C229BAF768ED9C3E63FB673B1AF67AE18137F91FC4AA9E148CF95A2D2B0600EB8341EE9D5BE9A0A41B1134C380A8B42476169A593DFD19F68C5D09FF44AA779C7CEAA0681F5848F4C41F94D744909CE4591FCB8D00C8C84080F08AC505DDD05964550E41902C4E4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4ZrlAo0bq3TDyw5v+G6YiroYwVrr3WajT5zU=
X-Mailru-Sender: 689FA8AB762F73937C9FA53A4753B313D79B5320799AF7361E52DBA4A998734561A2CD9963903FCF4F253F9D88F061EE46F9BC90A97DB1381F772815743FA20293D2455D34AB5A3F417D46434317A4F1EB5304D247585729B4A721A3011E896F
X-Mras: Ok

From: Jaeho Cho <jaeho2025@gmail.com>

commit 1c4f6202876a74e752a8cfd3696955f761671c7a upstream.

The HP OmniBook 7 Laptop 17-dc0xxx (SSID 103c:8d9c) has mute and
mic-mute LEDs on its F6 and F9 keys, but neither lights up. Its quirk
entry only sets up the two CS35L41 amplifiers, so no LED control is
registered for either key.

Writing to the ALC245 by hand with hda-verb, the mute LED responds to
COEF 0x0b bits 2-3 and the mic-mute LED to GPIO 0x04, lit when the pin
is low. That appears to match what ALC245_FIXUP_HP_X360_MUTE_LEDS
already does, so add a fixup that chains the two-amp I2C setup to it
and use it for this model.

Tested on 7.2.4 with the patched module: hda::mute and hda::micmute
are registered, and both LEDs follow the speaker and microphone mute
state, including from the F6 and F9 keys.

Signed-off-by: Jaeho Cho <jaeho2025@gmail.com>
Link: https://patch.msgid.link/20260914142445.3476212-1-jaeho2025@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: cf79cc4996bf ("ALSA: hda/realtek: Enable mute and mic-mute LEDs on HP ENVY 17-cr0xxx")
Signed-off-by: Alexandr <youdoit@mail.ru>
---
 sound/hda/codecs/realtek/alc269.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 404a93f55..2015be192 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -3951,6 +3951,7 @@ enum {
 	ALC287_FIXUP_LEGION_16ACHG6,
 	ALC287_FIXUP_CS35L41_I2C_2,
 	ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED,
+	ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS,
 	ALC287_FIXUP_CS35L41_I2C_4,
 	ALC245_FIXUP_CS35L41_SPI_1,
 	ALC245_FIXUP_CS35L41_SPI_2,
@@ -6212,6 +6213,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC285_FIXUP_HP_MUTE_LED,
 	},
+	[ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l41_fixup_i2c_two,
+		.chained = true,
+		.chain_id = ALC245_FIXUP_HP_X360_MUTE_LEDS,
+	},
 	[ALC287_FIXUP_CS35L41_I2C_4] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs35l41_fixup_i2c_four,
@@ -7108,7 +7115,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8dcd, "HP Victus 15-fa2xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8d9b, "HP 17 Turbine OmniBook 7 UMA", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8d9c, "HP 17 Turbine OmniBook 7 DIS", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8d9c, "HP 17 Turbine OmniBook 7 DIS", ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8d9d, "HP 17 Turbine OmniBook X UMA", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8d9e, "HP 17 Turbine OmniBook X DIS", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8d9f, "HP 14 Cadet (x360)", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.56.0

