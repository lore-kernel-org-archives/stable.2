Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608767;
	b=zgGBDjc4qVHomh/K6GL+Y0cFLLb1nmZr4zS6x7cOjbSjNGfcetIKyJ42pl8DWOgdyzCD
	 qV+/2I08/vBqBEnnl+ZtZ1JU+WRqy3ZTRbH55/MiEWibf6AO51ISEuFmS+3rFYvS6FMl9
	 +ROcnv9YlVpBdH7ACZRa685ycIxcgw1gVnzV2i4l6qHFLWgVYtQ2Ti9FPgU2IJFCAYw5Z
	 sIAHRTIW9WVp3l5EY7vWP7kRtGex9qBexwoVh8ivXx6wYDqc9/7cNhDHpnRRpBLjcSvXP
	 xvQZci3oAtZRycvCAhdeqEbkJgzUCbHvJFJOGExxfxVlMJ9ErajYwCcJNihXJuxx+tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bjI8AHQ7m4jgA91fm4jtF1Tcxlfx0iArocDzt6XuoC4=;
	b=IcZ+U/ZgVU5A/N98+4q3Ms6QCPxE9bTDYHh76dR+OVHj7FaTIKzI986L93lAGbp2Iy2D
	 jBLplMNTx4eFJNhOwnO1IJHur0lnWagYgAj1DCFAOUx0ev/gqeC1tVgl4eu/egD+aSOgg
	 vkKc5XbJBXbSVgSZ5H1hI6b9w1Bf26/Cr7xjLew1tORe5RLCbjkXFJq2Ehq6FZDhIZo3d
	 PnvqR2l7SFUoEZahKlsOFcFN7ASwblN+fcuWZG/Tkq5zFRhD1BwUn43e5P1nVpykap3XH
	 wR0l0KXXK2Zj0v9v0M69itmsCrladRlSh0B7fnjdxSE7LLtfOzIoIQOxcXNbtvGTOeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CA8BQPpk;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A98606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72A98606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CA8BQPpk
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15ea896ddc8so9453199c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795608766; x=1796213566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bjI8AHQ7m4jgA91fm4jtF1Tcxlfx0iArocDzt6XuoC4=;
        b=CA8BQPpkFGYJETP5Jmxax83ihH2w9AshAsRfUGuV/3QgrKGAC5C5wnBt6nhmQ5xF5h
         UdBwgt2cLLvl9g1wmfKzAvy548AzBvAwiOroS+AF8SbeL4YNhkyV+jO8AWxACNx9HVZr
         stIYazRKRTAuG+p46Y5Zm3ln3Qh4KvJnXrMlOk9CXLsdFXnL37Ja4Zx9AgeiNTsyu8ay
         dGA963GfIVwmoVccY5nNlKHWIFN9gN9lvZsnwevkFii3gVs3EpmnysUDoyNbrGWWIdta
         9EPMFN/TGjUAsb9egIKWXC1y0QI0fzAN0nQgdJCsRxtBbRIPanIZy12lnHepe7W+Cesd
         qnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795608766; x=1796213566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bjI8AHQ7m4jgA91fm4jtF1Tcxlfx0iArocDzt6XuoC4=;
        b=taK7gU3wsAl89lPNReaydSiDdMYXH3SRrGo/+z/gasxd7EN6FNoTTosy8QfpZNADjQ
         nQKeqq9C9fDqVBBC9CEQD9uRsD5RMtPlg7lWcmxjXMEeVufLu8TUScXha0msbtqqvmUb
         YKAPS0A/SJPJJcZKAky2tZsdNdaKQDIrTZTTqY8gSLS63eg0fNPYZi4JYRpa84Fqk3a6
         NxxGr2jqOEDqUIz7u1bANYA6T8U4NmQLQ99MThdGRcr27pjlxKjjaxXqh5NaP1CR2Aha
         GbQP0mFst1GyDZNoR3tPqVMNUGFV+EN4426qzCNXaoiX5YxYbeHIA0Bv7nAtBxF+RTi5
         2XxA==
X-Forwarded-Encrypted: i=1; AL+hErFcJ7TIEC/FIqhJq/g4i0q9gIcVYMJrks7KFvdbevZ555+mJOfnQNVr3SrhpQnGjB8tffpfKAw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wGoXgRoGJ6m3B68TaRI7hI/bAtKMhev9WD1zXNK9K1joBw150
	0osvnHLA5ggNIPyaQ6sff70ppPACaQIhrrx+158ZU0mSCOSDliyQio1v
X-Gm-Gg: AZFdTZeNNfVHD9KTk4eOCUpQQp42kg1qrI6p+CDrB7FPVCM3tn3sJgtHBPKX4LmbCCe
	y3i2Y2jYGhHAMgKAQ8087WEbrtNE2Iz8s4YA8lW3l1NyWImYjjM0Oawbx3p3SkDB4NMnkqWlj8j
	D+RD/jUeBM21Z2ziPeR/yKAfX98tY24N1DEkDazmm399hjHmYCzz09j96OuI6qmvtrCgPOygoHM
	OmYYVpNs9zuimSecqRUkAB/muG3DbqAILAzU/wOqUUkrEsrZsTVEUtbnMOt9BSxFFVlC7uOajwx
	R06atZD2ZaoIwwGHM45nsaNjcS9C/19SqsVzfOxhrlSHSoORyVNolZgFgwc1IoZejGsjWJuDORY
	lALqyDsWgi2CxdEEP87WrsC7sP3bAW97omcqUEt7GeZtGGKHzHfmZQN/QNwM1xfRHXT3kN8NtqT
	gAiwIxd0Ra20lTFEC5/Fo/5v/HrgGCeThBwvHncTaZBL5NVUIMUC9bE2L2X8P3Y8blhuxGYG/FR
	Go1xHJFHkDU70ZTzkr21mOEkP3ZofO8NuiYL1t8RIPCccGZgZgEKfIh2UwONA0a+waga0Zx0t6p
	jvfP428Gpj24XNfCvWDXfkQW7ZjQNKr6X6nSvk/l1iunVBkMttTXW4Q=
X-Received: by 2002:a05:693c:6390:10b0:386:ac97:f670 with SMTP id 5a478bee46e88-386ac97f867mr9397200eec.12.1795608766468;
        Wed, 25 Nov 2026 04:12:46 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm12234336eec.17.2026.11.25.04.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:12:46 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Clemens Ladisch <clemens@ladisch.de>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] ALSA: bebob: bound the channel position walk to the response length
Date: Wed, 25 Nov 2026 20:12:36 +0800
Message-Id: <20261125121238.1602172-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125121238.1602172-1-maoyixie.tju@gmail.com>
References: <20261125121238.1602172-1-maoyixie.tju@gmail.com>
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

map_data_channels() walks the channel position response by the section
and channel counts in that response. Nothing checks the counts against
the length of the response. A section of 128 channels can read past the
256-byte buffer.

Take the length of the data from avc_bridgeco_get_plug_ch_pos(). Return
-EIO for a section that does not fit.

Found with a CodeQL-based static analysis tool. Reproduced in a
userspace harness under AddressSanitizer. Not tested on hardware.

Fixes: eb7b3a056cd8 ("ALSA: bebob: Add commands and connections/streams management")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

 sound/firewire/bebob/bebob.h         |  2 +-
 sound/firewire/bebob/bebob_command.c |  5 +++--
 sound/firewire/bebob/bebob_stream.c  | 11 +++++++++--
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 41e019b9e24e..7891a5802f1a 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -194,7 +194,7 @@ avc_bridgeco_fill_msu_addr(u8 buf[AVC_BRIDGECO_ADDR_BYTES],
 }
 int avc_bridgeco_get_plug_ch_pos(struct fw_unit *unit,
 				 u8 addr[AVC_BRIDGECO_ADDR_BYTES],
-				 u8 *buf, unsigned int len);
+				 u8 *buf, unsigned int *len);
 int avc_bridgeco_get_plug_type(struct fw_unit *unit,
 			       u8 addr[AVC_BRIDGECO_ADDR_BYTES],
 			       enum avc_bridgeco_plug_type *type);
diff --git a/sound/firewire/bebob/bebob_command.c b/sound/firewire/bebob/bebob_command.c
index 022df09c68ff..2e5a43e24615 100644
--- a/sound/firewire/bebob/bebob_command.c
+++ b/sound/firewire/bebob/bebob_command.c
@@ -181,14 +181,14 @@ end:
 
 int avc_bridgeco_get_plug_ch_pos(struct fw_unit *unit,
 				 u8 addr[AVC_BRIDGECO_ADDR_BYTES],
-				 u8 *buf, unsigned int len)
+				 u8 *buf, unsigned int *len)
 {
 	int err;
 
 	/* Info type is 'channel position'. */
 	avc_bridgeco_fill_plug_info_extension_command(buf, addr, 0x03);
 
-	err = fcp_avc_transaction(unit, buf, 12, buf, 256,
+	err = fcp_avc_transaction(unit, buf, 12, buf, *len,
 				  BIT(1) | BIT(2) | BIT(3) | BIT(4) |
 				  BIT(5) | BIT(6) | BIT(7) | BIT(9));
 	if (err < 0)
@@ -206,6 +206,7 @@ int avc_bridgeco_get_plug_ch_pos(struct fw_unit *unit,
 
 	/* Pick up specific data. */
 	memmove(buf, buf + 10, err - 10);
+	*len = err - 10;
 	err = 0;
 end:
 	return err;
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 449cb17717f0..5850357cb3da 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -255,7 +255,7 @@ static int map_data_channels(struct snd_bebob *bebob, struct amdtp_stream *s)
 {
 	unsigned int sec, sections, ch, channels;
 	unsigned int pcm, midi, location;
-	unsigned int stm_pos, sec_loc, pos;
+	unsigned int stm_pos, sec_loc, pos, len;
 	u8 *buf, addr[AVC_BRIDGECO_ADDR_BYTES], type;
 	enum avc_bridgeco_plug_dir dir;
 	int err;
@@ -274,7 +274,8 @@ static int map_data_channels(struct snd_bebob *bebob, struct amdtp_stream *s)
 		dir = AVC_BRIDGECO_PLUG_DIR_IN;
 
 	avc_bridgeco_fill_unit_addr(addr, dir, AVC_BRIDGECO_PLUG_UNIT_ISOC, 0);
-	err = avc_bridgeco_get_plug_ch_pos(bebob->unit, addr, buf, 256);
+	len = 256;
+	err = avc_bridgeco_get_plug_ch_pos(bebob->unit, addr, buf, &len);
 	if (err < 0) {
 		dev_err(&bebob->unit->device,
 			"fail to get channel position for isoc %s plug 0: %d\n",
@@ -311,6 +312,12 @@ static int map_data_channels(struct snd_bebob *bebob, struct amdtp_stream *s)
 			goto end;
 		}
 
+		/* this section should be within the response */
+		if (pos >= len || pos + 1 + buf[pos] * 2 > len) {
+			err = -EIO;
+			goto end;
+		}
+
 		/* the number of channels in this section */
 		channels = buf[pos++];
 
-- 
2.34.1

