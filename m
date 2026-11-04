Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793782870;
	b=aQBLcyZj1ah03GYdlQJjdVIU6a2P51E6KWcCqWNTuE0qt3JAKyUKPPzBkrSfDCsI9gyh
	 FO13Yz9zbhpvb8b5iqFfUEk5XZzMObaCWB4Xqmdrqe/TJSElr70/Nhgxt5/VBuicMycWu
	 q02h5xXHG29BjJEl6tkLhoEDsTC2gEj+akrVs5VWuk3dCVjVrjSkzf/2PTED5//EVcDsG
	 aklXZmjNh0RvUMkbDLU2HJMpuajU0PpAZuIM7ucOnH+zsuhzTOa5L3RSvavVatwX4Y/Gt
	 vQcFq+K+UrWxqiYgAxDec7+G4weKnXR+mPMlaRgmPMY2O8rlTQbIx7IB5DRaM1k3uZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782870;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FGCg97yy95ZQI6qLmppFJ/H1F7e4GuIsRRONIaiTYdU=;
	b=UVwU5IoWAuLrAzY+x0v+7J1LVtNgFpsA57BDS1JB7LTTsBAkgQPTGlEHPwiLmBvQD8KH
	 TLvuM76TXlzOSRNRbKV901sjrdloj/fU7YglWC42a5WJVAttJXbnX0DgiJ1szZvngNIjR
	 HGFzfpDiuyBSn3EDONsTIPS5rF//ZaNcZCmMgQsT0XHWdaKojhVa9HjG5pDlczHbjrnJd
	 sZsgWgWU2QfQ8PAUPmWQf9z1SUQhXp20lm9dGWpA6iVXhpJZ+dH2Cm3wgym/C2xdZHWPF
	 IzOcelsx4RjAMnprzAv8G5LtLU2CkUqxv3ojWr+wCkbrwMJUevgZ1xw9+1J0TzUxrDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0D0606A326;
	Wed,  4 Nov 2026 09:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F0D0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 41e8cf48d82e11f19a56ed5b684f684d-20261104
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:6e7870b8-ded4-4216-8cd1-5ea337f9cd7f,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:0698f503bc8e9f34a1c55a7ee0b32ff3,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 41e8cf48d82e11f19a56ed5b684f684d-20261104
X-User: songxiebing@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <songxiebing@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1838893252; Wed, 04 Nov 2026 17:01:01 +0800
From: songxiebing <songxiebing@kylinos.cn>
To: tiwai@suse.com,
	perex@perex.cz
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	songxiebing@kylinos.cn,
	stable@vger.kernel.org
Subject: [PATCH v2] ALSA: hdsp: Validate DDS offset range and propagate errors
Date: Wed,  4 Nov 2026 17:00:57 +0800
Message-Id: <20261104090057.2067780-1-songxiebing@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261104083045.1939479-1-songxiebing@kylinos.cn>
References: <20261104083045.1939479-1-songxiebing@kylinos.cn>
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

hdsp_set_dds_offset() computes the target rate as
system_sample_rate + offset_hz without validating the result.  A user
can set the DDS offset to -system_sample_rate through the control API,
making rate zero and causing div_u64() in hdsp_set_dds_value() to
divide by zero.  Larger offsets can also overflow the rate calculation
or push the DDS value out of range.

Validate offset_hz against the [-5000, 5000] range advertised by the
control, keep the non-positive rate check as a safety net, and
propagate the error from snd_hdsp_put_dds_offset() instead of
reporting success.

Fixes: e4b6088c8cf1 ("[ALSA] hdsp - Add support for fine tuning of sample rate support to HDSP 9632")
Cc: <stable@vger.kernel.org>
Signed-off-by: Bob Song <songxiebing@kylinos.cn>
---
 sound/pci/rme9652/hdsp.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 7dce548b9f36..467121a5fb4f 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -2768,6 +2768,9 @@ static int snd_hdsp_get_adat_sync_check(struct snd_kcontrol *kcontrol, struct sn
 	return 0;
 }
 
+#define HDSP_DDS_OFFSET_MIN	-5000
+#define HDSP_DDS_OFFSET_MAX	5000
+
 #define HDSP_DDS_OFFSET(xname, xindex) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
   .name = xname, \
@@ -2801,7 +2804,15 @@ static int hdsp_dds_offset(struct hdsp *hdsp)
 
 static int hdsp_set_dds_offset(struct hdsp *hdsp, int offset_hz)
 {
-	int rate = hdsp->system_sample_rate + offset_hz;
+	int rate;
+
+	if (offset_hz < HDSP_DDS_OFFSET_MIN ||
+	    offset_hz > HDSP_DDS_OFFSET_MAX)
+		return -EINVAL;
+
+	rate = hdsp->system_sample_rate + offset_hz;
+	if (rate <= 0)
+		return -EINVAL;
 	hdsp_set_dds_value(hdsp, rate);
 	return 0;
 }
@@ -2810,8 +2821,8 @@ static int snd_hdsp_info_dds_offset(struct snd_kcontrol *kcontrol, struct snd_ct
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
-	uinfo->value.integer.min = -5000;
-	uinfo->value.integer.max = 5000;
+	uinfo->value.integer.min = HDSP_DDS_OFFSET_MIN;
+	uinfo->value.integer.max = HDSP_DDS_OFFSET_MAX;
 	return 0;
 }
 
@@ -2833,10 +2844,14 @@ static int snd_hdsp_put_dds_offset(struct snd_kcontrol *kcontrol, struct snd_ctl
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0];
 	guard(spinlock_irq)(&hdsp->lock);
-	if (val != hdsp_dds_offset(hdsp))
-		change = (hdsp_set_dds_offset(hdsp, val) == 0) ? 1 : 0;
-	else
+	if (val != hdsp_dds_offset(hdsp)) {
+		change = hdsp_set_dds_offset(hdsp, val);
+		if (change < 0)
+			return change;
+		change = 1;
+	} else {
 		change = 0;
+	}
 	return change;
 }
 
-- 
2.25.1

