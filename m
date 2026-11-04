Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793772803;
	b=5TTy+0Y/daroO/k/V4v7BvA/Q7r/IRt5QMkhI8BKm9ur+CxCdNtVUoZLYa8mZRXb+WmE
	 oX2fDswnslnDOEL2UeT+sekqZTP6fr/IM7DUCnsfjMO/KFSzfG6F4r40VQCxkDgGtwAYM
	 NrL3KX/SUl8fRi5IEDRXR4uArkkXnIEDZMijbnF5tdmuItrSnCh9owlvOS683neOCg6Up
	 boYWP0Wlvr+9Ex75D0d7n91LuAsqWPPY3GkFr4m8V0oTs5fuDHLg5EuNPO4RuGWaSFlTL
	 Hq4mMlEOJ0e8WtsQ2u2zKCRAsb9l82z4bpNdTDGcIM3XML388mOZWxcOgrGWlUajvVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793772803;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rWbZ8X89Medg3HQeGT3676tXWcqmogYTamKMYPyJwUs=;
	b=UP4oyCW3eMcXynD7BtqEkIZ7dZYnVeZeCrCQkOQgOqEEhxFJfPsyOGE5R6MhHE23Yq6Q
	 8DmpeRtF8BJ9v8oC+w+ieOE+WxV29gU8+63IvXloPbcM20FI/T0a/zgOxgFDEOj1rizAy
	 TSkXciRffjgVfpD/2D94Sp+dKQTOqgTH6LBp+vNLDDKQOG0FLUqFL9yW0IQfoE6+TJaSf
	 6qyC+w6tsaQINZXDr86sdyMEqHF10TPRT6yqMqiFQTOcVwoC1vWcvInrSNAN+ZScU2vTO
	 R8IVOR+1CmBh3ULh12DU1q1DiVxrASJmpNhd/TZ1EB7Mhu5OxmD2SyvBo/+P7k2GPIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB19606A326;
	Wed,  4 Nov 2026 06:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDB19606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d26aea64d81611f19a56ed5b684f684d-20261104
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:f1ebb4f9-3004-42fa-ba73-e241ace3ac4c,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:7db8b62,CLOUDID:baa2d7b74ce05ef148e86059de8592c1,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99|100|102|
	153,EDM:1|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d26aea64d81611f19a56ed5b684f684d-20261104
X-User: songxiebing@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <songxiebing@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1825802523; Wed, 04 Nov 2026 14:13:15 +0800
From: songxiebing <songxiebing@kylinos.cn>
To: tiwai@suse.com,
	perex@perex.cz
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	songxiebing@kylinos.cn,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: info: Fix maxsize underflow in snd_info_entry_write()
Date: Wed,  4 Nov 2026 14:13:11 +0800
Message-Id: <20261104061311.1345791-1-songxiebing@kylinos.cn>
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

From: Bob Song <songxiebing@kylinos.cn>

snd_info_entry_write() computes maxsize as entry->size - pos without
first checking whether pos has already reached entry->size.  If a write
is issued with an offset beyond the entry size, the subtraction
underflows and count is left unclamped, so the write callback is called
with an out-of-range offset and the original count.

The read path already handles this case by returning 0 when
pos >= entry->size.  Add the same check to the write path.

Fixes: d97e1b78239c ("ALSA: info - Check file position validity in common layer")
Cc: <stable@vger.kernel.org>
Signed-off-by: Bob Song <songxiebing@kylinos.cn>
---
 sound/core/info.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/info.c b/sound/core/info.c
index 3b8ccda04e1a..676b06e0d463 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -171,6 +171,8 @@ static ssize_t snd_info_entry_write(struct file *file, const char __user *buffer
 	pos = *offset;
 	if (!valid_pos(pos, count))
 		return -EIO;
+	if (pos >= entry->size)
+		return 0;
 	if (count > 0) {
 		size_t maxsize = entry->size - pos;
 		count = min(count, maxsize);
-- 
2.25.1

