Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=89.221.237.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715709;
	b=m/WadxmwZNMLS/XkDzR8mXdwA7kG5f2nu68EJYPf3zz2N6bcDSBu0vCeigs9QsoiURN6
	 PqlVzlTm+roY909QnBVDnRUlTCiO6WbH+GDP6YawjPt6b7v8uI0S4r2We384mI8w0hDVe
	 7Qi2RNC8qrsQ/lhEURW4mAWoJFnuyb4omKeqFlUVur0+Wisra2JFCcSWDhai+sSJpysYq
	 ZS823MEBIwB56voBfT1rfm1BtwsruJaWlXEIATeL4J3lOhAmBAGa2QKCokuxbOPyL80ph
	 enPUmCgsdIYfeJrJe53ht2wAhTGDFBKZMbvX72IbHJd9Za+5lcs/HjYQOrPFTnBcdPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715709;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailru-Src:X-7564579A:X-77F55803:X-7FA49CB5:X-C1DE0DAB:X-C8649E89:
	 X-D57D3AED:X-Mailru-Sender:X-Mras;
	bh=oS+0s+D5o5gh5fqlf6eX9tNPWFHZC+/N1fRXqwkMdzU=;
	b=ve33ZSHCcCFoGEU1oVnRTPwpmyWyCV7OPPu1xfPLJk9Eob7mNsrKp5qHRFLLPt316mip
	 VFCxubO8wiQYZ9k+dHilFy+7/GmhQCe0Sqya+WRYzGxA00/JqHzM7z+lmUO0VKJbxizta
	 RU0GVYbebUpHYPlumcK1bb4wek1WBjCn2SnSayZCnSHoLs0Wi0b+eICNe816H4Y/WfuAM
	 C4xTqVBfFh3HF++vl30K7eo7D1XrCbUzl6zDPhR+KPYg9m9NS9YWrgYadVrRnVSDB6iho
	 E74+3YrSPPkDYEz75qEPTz9H9MVGOV+G49JxJSFHBv3ElPmLbA928/7sppPzqlL0K1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ru;
	spf=pass smtp.mailfrom=mail.ru;
	dkim=pass header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b="PSHzz/ut";
	arc=none smtp.remote-ip=89.221.237.221
Received: from send126.i.mail.ru (send126.i.mail.ru [89.221.237.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B90B606A328;
	Tue,  3 Nov 2026 14:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B90B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=PSHzz/ut
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=oS+0s+D5o5gh5fqlf6eX9tNPWFHZC+/N1fRXqwkMdzU=; t=1793715706; x=1793805706; 
	b=PSHzz/utS86FdFjDiQaksBuwwhj63qmLMOuDiIoKeI/3szM770EjtN2IIGQ+z0sBOIWsZqIoZi7
	vUaUQXau9IKMJ4DG7FbFHr4dr5YRtRhMtIg8Bz1Qp59GAdJcgKRjMYbwUM2gfoEY8uJg2IGsiUHS7
	8Opcbp7MlInchqp9bsTIq1U6HXjhCYgA/Tozcu3le73YQBcAtueasNNSmFDTEYed9lFVdfqYMMXrt
	LnnwZlVfEUQrIHR6iqlHPMgTtXppXID0xQcg9k76YPaUEdX4uLArM8yXGkiHwBMLXi7S5k5ucuEHY
	GDCHd9eNoFKV+nUN2oidAZS+rAT5YMGFZT6g==;
Received: by exim-smtp-675c6798c6-9rgkk with esmtpa (envelope-from <youdoit@mail.ru>)
	id 1xOFOH-00000000EA9-2YQ0; Tue, 03 Nov 2026 17:21:34 +0300
From: Alexandr <youdoit@mail.ru>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	Alexandr <youdoit@mail.ru>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Enable mute and mic-mute LEDs on HP ENVY 17-cr0xxx
Date: Tue,  3 Nov 2026 21:21:21 +0700
Message-ID: <20261103142121.74032-1-youdoit@mail.ru>
X-Mailer: git-send-email 2.56.0
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
Authentication-Results: exim-smtp-675c6798c6-9rgkk; auth=pass smtp.auth=youdoit@mail.ru smtp.mailfrom=youdoit@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD98ABDE2792B803B488C8FABB7891C58B188D521B9F194125F182A05F5380850404C228DA9ACA6FE27A66E3A204E3940AE3DE06ABAFEAF670568C2B978F72CD434EB00E591A11102E98E573506CDC45F9B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE763D33D3AF3325E31EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566509B1718B586E0857D0C5A5C13AE6085B86B9870F426ECA39FA36C4119AF9D3F8EEF46B7454FC60B9742502CCDD46D0DEDCF5861DED71B2F389733CBF5DBD5E9D5E8D9A59859A8B6AEEA5BB16A939343CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB86D1867E19FE14079C09775C1D3CA48CF17B107DEF921CE791DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C31D1C341835B94C8935872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5451DF819E4A78F785002B1117B3ED6967B9086C0CC921DFD4869453249F34FA43610D81D389A125CDE35189EBF2DEA281E618B5D5F965AFD046E41ECE48572FFB2D1C9E48B6DC60AE2A7E19323554B120D859BC32D74B8B58F0AA2D9D6B587254EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6598E66ABE9E473CCF4479D1C6C57A307BE8EF8FF86260D675D86ED021063046D25ECCBACA5EDFD44DEB8341EE9D5BE9A0A73D3F74656B98766E2365FE124A5841052E5291A5F4A49CB9350E1BD188BD56E4C41F94D744909CE4591FCB8D00C8C84080F08AC505DDD05964550E41902C4E4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWNxog0IzBJeVtEW4g7DlDWI=
X-Mailru-Sender: 689FA8AB762F73937C9FA53A4753B31355866492DCE32D58178B700B58DB7588047FE893EB4D46DE4F253F9D88F061EE46F9BC90A97DB1381F772815743FA20293D2455D34AB5A3F417D46434317A4F1EB5304D247585729B4A721A3011E896F
X-Mras: Ok

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

Cc: <stable@vger.kernel.org>
Signed-off-by: Alexandr <youdoit@mail.ru>
---
 sound/hda/codecs/realtek/alc269.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 23329d5..a789429 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7867,7 +7867,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a2b, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a2c, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a2d, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8a2e, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8a2e, "HP ENVY Laptop 17-cr0xxx", ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8a30, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a31, "HP ENVY x360 2-in-1 Laptop 15-ey0xxx", ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8a34, "HP Pavilion x360 2-in-1 Laptop 14-ek0xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
