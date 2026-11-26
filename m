Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795687669;
	b=DOnfwlWeZWa5HCe056lNxlCvIMGvEglXZ+ef9A4X2Oz2mlwNdDYKIdvXa9Lw6N4bKZSl
	 rJAhJK6wkP2gvoVYGWtpV89gX+rSo/DbXndZXsXAGrnM85Ec2WFzd45qlSl1c8XzTRNRF
	 AYrDGy34ATVnVOMECu73wUaM/30ajK/3iDgxjmnV8/F7lky3nVDq/gaDy+/rD1A9UGsKa
	 oTSik+53OiE6b6DrO4AE8tERbP1m24r78hJwYpaA3xrDHRmonIfNWgrSBcgY3CkrMhqD8
	 UdKlOlXGRUCMiX030WExLWnLIeegCTVSH9oEWp9HQqZrvyyrQK4ccMnhrg7kagHi0Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795687669;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sqyhnicDhpkGAm6vt+Gh5feLU6BYKVrlXMdIf5bBnuA=;
	b=GThvbQy+JrZ13MgYiekReeBNrWOd7OocEZBaPqoIxpKlgdTpF2tIDTVCMB8GSVoVXnq4
	 hoEQCVV8LCNDYR2oY6WfLeiUzgvdbJcNdakgwxrvRymJgZ152ePVeqvRcvolnulxSWU60
	 N3Yv3xiUiKQJGGqROMbCRAhub/2Pz7XOwjpofT2N45fcRiqV7ucI/AXCxB2VpAwkw4rei
	 6wfbUVJGMXGA5C7+ltGmbVFma6UA/SAHSYkU0LfsT7HyRiZkMxt5TIVUZrjtiPxHtWanf
	 MBDijK2NQNAtQ6UuuQ5mFm5LKbMv8/goN4KzZF3CIOBpPFv8y56G7TZHARMPqjd4v2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02712606A31C;
	Thu, 26 Nov 2026 10:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02712606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 359f1e9ae98111f19a56ed5b684f684d-20261126
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:7abd7bb3-f148-44ef-a6fc-5090b5df27bb,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:d88d4222f20b6b6f86b2c378f6c4f1a0,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 359f1e9ae98111f19a56ed5b684f684d-20261126
X-User: zhangheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 798453359; Thu, 26 Nov 2026 18:07:38 +0800
From: Zhang Heng <zhangheng@kylinos.cn>
To: tiwai@suse.de
Cc: perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	helamonster@gmail.com,
	regressions@lists.linux.dev,
	Zhang Heng <zhangheng@kylinos.cn>
Subject: [PATCH] ALSA: hda/realtek: Fix mute LEDs on ThinkPad X1 Carbon 6th
Date: Thu, 26 Nov 2026 18:07:31 +0800
Message-Id: <20261126100731.903504-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

ALC285_LENOVO_DAC_RENAME is not chained to ALC269_FIXUP_THINKPAD_ACPI,
so the vendor fallback that registers the mute LEDs is skipped.  Chain
it to restore the LEDs.

Fixes: 108704eecab9 ("ALSA: hda/realtek: Rename Line Out control to Headphone on ThinkPad X1 Carbon 6th")
Cc: <stable@vger.kernel.org>
Reported-by: Jeremy Bryan Smith <helamonster@gmail.com>
Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2174970
Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
---
 sound/hda/codecs/realtek/alc269.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 147e97f..a00b1b2 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7476,6 +7476,8 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC285_LENOVO_DAC_RENAME] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_lenovo_dac_rename,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
 	},
 	[ALC287_FIXUP_YOGA9_SPEAKER2_TO_DAC1] = {
 		.type = HDA_FIXUP_FUNC,
-- 
2.25.1

