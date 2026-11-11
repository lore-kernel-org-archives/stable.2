Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=89.221.237.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794422064;
	b=tPrDpkOswrID1hS1K/2MOija2AGuOZQFq1YoO2BPBl8VWNPiWbJHkoV0wOOuoEp7o4us
	 RZhhvVhL2N8Z44RiDyWK245EZVI31UWz6h/GKJwRpT+QZG6hLKpniTjPvh5Swxi7cSIrC
	 oLTWs3EuOmOwoHYwL159BXStmAGSEb/l3LzlC39okyOSgQkx/Xz/Z8rdxjlCBsIXp+007
	 1pzjWrKeZFXGD9uRrxt7bCYqRJoQEy2/RA5nmtHPmMu/mDh0xtOsPnbRKvqr4IIZGTSlH
	 lo+m4C89BsmwmL709vnfQrR7/JRv9nxqb0SvaVmA8Yv8MQ9OmVvfC6//DRJ1LxpahIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794422064;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailru-Src:X-7564579A:X-77F55803:
	 X-7FA49CB5:X-87b9d050:X-C1DE0DAB:X-C8649E89:X-D57D3AED:
	 X-Mailru-Sender:X-Mras;
	bh=zROY1OxPx58ui6PhueOqn83vz6Qf0YqYHGeAbHB9OOc=;
	b=II7hk6WczUq9hNbX9QLXdOktAsQkhcM4Sf4hpTsDytKHsyzIXGPyx6fLBmOtBFqyD3i9
	 HqztW82i4Ca7/F4yTAtrtJ7O4EbUiE7YOgKof7J2XE4536VmYNIlHMuxHoeqlvlbpNXcU
	 xh2V95EtiG3/V/vKopynmwfENwwTaXfu5PnzjaGqZYsGoR0gZzVsBHwE+AOyyhOAdJu4h
	 0IC1rDbgotcCBMUmngjVCGIushLE5NyCh8vCV8QYsfAF+6c77Twar5Do7A35w18FM3fuX
	 rUDFyckBGFpjRY0NFuItMC9EbaWvSFj1A0AYZhvXu8ZnI/uZ3IKs6Glt8Y1SZVjbbUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ru;
	spf=pass smtp.mailfrom=mail.ru;
	dkim=pass header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=GXtPzE5C;
	arc=none smtp.remote-ip=89.221.237.223
Received: from send128.i.mail.ru (send128.i.mail.ru [89.221.237.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DF1606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38DF1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=GXtPzE5C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=zROY1OxPx58ui6PhueOqn83vz6Qf0YqYHGeAbHB9OOc=; t=1794422063; x=1794512063; 
	b=GXtPzE5CmfexIoupZtL+QspYKuJLU/u8utqO7oLUjOQao8qCtAz7P7UXRIiysxJiRu+aXO5MQ+J
	2A1smbMOWa5pIRvRBmlPuQ+V29yn+AxgWiqfE4eHqluKdOzzjUmDwGiVCHwER7LX4Rl+RP1pm9mJC
	XVmKm9ZB6HMrzFnUJUxpWZkjxH1AhOFVd+gY+M8fS/8vD+DCJXTJFklL7xcjJQesT7SpoeqspNTEc
	VERROuFyqllgeOKFoT3ATvos9A8ecsMQfV0dhXngsHfTI3uR4H95rBwwsKIoNdybk/pPTqkc7eXIj
	KarbYql+3Ijz2RS93X1ALSQNJ07xrpG3MIJg==;
Received: by exim-smtp-bccb94844-d9wvd with esmtpa (envelope-from <youdoit@mail.ru>)
	id 1xRD96-00000000EVj-0PAJ; Wed, 11 Nov 2026 21:34:08 +0300
From: Alexandr <youdoit@mail.ru>
To: stable@vger.kernel.org
Cc: Jaeho Cho <jaeho2025@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Alexandr <youdoit@mail.ru>
Subject: [PATCH 6.12.y 1/2] ALSA: hda/realtek: Enable mute LEDs on HP OmniBook 7 17-dc0xxx
Date: Thu, 12 Nov 2026 01:34:03 +0700
Message-ID: <20261111183404.505834-1-youdoit@mail.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109201008-failed-6.12-cf79cc4996bf@kernel.org>
References: <20261109201008-failed-6.12-cf79cc4996bf@kernel.org>
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
X-77F55803: 4F1203BC0FB41BD9CC39C64ECE24C2D724F75A7580EDDE80564B6050E4208C6E182A05F538085040D47FAFEEF5EFC8AB3DE06ABAFEAF6705D0BB12016ADBA737321DE9BADEFBF3F1B242013FB95F71DC
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7E9C30BC00893CB9AEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F88016AB904663428638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B2F68945FA7D2A98BC2E070BE324C7D3C402A562475F681A99BB0A4F435E46E6718B35066C979671628AA50765F7900637F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C058C1844A7A85E7B68941B15DA834481F9449624AB7ADAF372E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C398B0EFDACA283D7B35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A54E63F890E4D47B245002B1117B3ED696C332E975B208071272305013E4AE841E823CB91A9FED034534781492E4B8EEAD6A17C1D737525568C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659EE7BE0D2F0669B21C1348657C3F3C2D1405DAFF6ECA5116F093328EA24D7BA8FADFCCD644A285A55B8341EE9D5BE9A0AE56EE41D9169FF9C882F067DE84F05EF6830B4F13395DF9AC7CEAA0681F5848F4C41F94D744909CE4591FCB8D00C8C84080F08AC505DDD05964550E41902C4E4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWLFnmFzSJ9ygAP+qXqN/L60=
X-Mailru-Sender: 689FA8AB762F73937C9FA53A4753B313DFF4551143718EC1660D31C753B0C4B70A4B8013A93C36924F253F9D88F061EE46F9BC90A97DB1381F772815743FA20293D2455D34AB5A3F417D46434317A4F1EB5304D247585729B4A721A3011E896F
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
[ Alexandr: the driver lives in sound/pci/hda/patch_realtek.c in 6.12.y ]
Signed-off-by: Alexandr <youdoit@mail.ru>
---
 sound/pci/hda/patch_realtek.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0b370a9eb..edda7cb34 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8212,6 +8212,7 @@ enum {
 	ALC287_FIXUP_LEGION_16ACHG6,
 	ALC287_FIXUP_CS35L41_I2C_2,
 	ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED,
+	ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS,
 	ALC287_FIXUP_CS35L41_I2C_4,
 	ALC245_FIXUP_CS35L41_SPI_1,
 	ALC245_FIXUP_CS35L41_SPI_2,
@@ -10414,6 +10415,12 @@ static const struct hda_fixup alc269_fixups[] = {
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
@@ -11215,7 +11222,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8d91, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d9b, "HP 17 Turbine OmniBook 7 UMA", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8d9c, "HP 17 Turbine OmniBook 7 DIS", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8d9c, "HP 17 Turbine OmniBook 7 DIS", ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8d9d, "HP 17 Turbine OmniBook X UMA", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8d9e, "HP 17 Turbine OmniBook X DIS", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8d9f, "HP 14 Cadet (x360)", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.56.0

