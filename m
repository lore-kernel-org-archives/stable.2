Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362C337B012
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783773406; cv=none; b=nvCCt4bTrSPO3BOhD8xFewjNyqVRshVhOWFCiHZu1fpjOiN8/5t1AMxR9dL3PANaOLkHtt3ZyoEPfPtGcR9SWJajMYIIFe05Qt9F+O9XK6k6hRSZDwuLSzST7jtctU/7NUc7XeRAwE0S+5J1qFq4C7faagt4fvFMRjPQrUTWOQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783773406; c=relaxed/simple;
	bh=PhVyj9qD5Z/KlbzjKtoN1G0Qg0OHJkNtCd/AmCW/7Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uOhOxIaxh0Vxyha6YZlcb+P4+inVBBkSZ5o3mZXQTApaMuaWYm94IWZ2otKtzwW/9qO4epobCAg2Nso4ZHoJlZJYd5k2S96aNvwEpMVxWA+t3DdKycGh7gYfjn4F+mZOgRv5WfLbL7HiK3XGaoDPrRQK1zaJUGA/5wkDyE87ouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=q3h/pdWS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="q3h/pdWS"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-472326ca506so1359024f8f.2
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 05:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783773403; x=1784378203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iEZdacI12rwF3rcHsuyG8xQf3FKIyTovs73PN6g2MOE=;
        b=q3h/pdWSeTe1k9K9MDviB3sBXlTBIgAjFetV8Dcydd4ZgT0Uk2freX/hQLdj9JXswk
         sm1sMHNs1i1h1hoqxICHlVlgAsxKNFHIRH6OcNfpfVbBF/vQ7xtt8+XB+8oG0K6sg4Fh
         FMp0s7PUqkXbBqzXJNlkWwhuITo35gcMZhFRoMolbZlPAnlDwjLjhpWIkTmHzyizuhR9
         8O1bdNLE6Dl/WfxYn30drMzppzBAfnAi2Pwrwz0hYMfOkpPJ2WYN7eOCClKPff0fb4Vr
         oXLWO5ju1x8AGdUWzIbsQB4Rf18SHiflb5JtwcvvITlLckjyTcjCX1MEJ4GRXLZXvIRQ
         4HnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783773403; x=1784378203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iEZdacI12rwF3rcHsuyG8xQf3FKIyTovs73PN6g2MOE=;
        b=AgJkcPXFmBxFFjbK8+SzOt2EhqADGQTtEYLRJ5C858yNy8ariA0KvT5MXWS1L+usL5
         w/jD9TzX/vunwSG1B+H0y+5KRqA3odjxy73ku031j8ZOWM+cP3JWeHA85ZxM2zSnIOmW
         bH48w3HVnOjQnz1KfUNDGYML+E+gkaaJHIr5gd8TZ2UQh4vW+NUagngNK6uLWR0jX0tm
         16xQ8tjQzXVpk0T2BmKJsv9Wb+rTsU/PKHUfMSObhQBtghnnS0q3jfeLUQOr6VFDDkyF
         lXM2goUPk1Zrm1PHoThX4BaHUL9WnH64gGM0dBB03FxKwffd2U5CiwLjoNil2N965R2b
         AknA==
X-Forwarded-Encrypted: i=1; AHgh+RrMUxOia5NZ9aO9pPET9mWBPB30GCkbfpLa7KQNaaXpW8P8FSRw4NzxUPBiGACvJMuVrDl7gBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqn+jHy9aIaDIei+fyHE9fpBhfvq4FfvHun8Nb/4OZ8rMSUpL6
	H7dG4OSTmqvck0gBVhIcC346iqG4Ch9v6bvVsB0qydYpuQtpx8XTPeuHBmJ6v53xFW3T
X-Gm-Gg: AfdE7clphuOPUiC3eI0MXp3eiwrSTrQDwI32FLz4tw3iByqCQ9xoWCjh/HYT72H1+N0
	ot2Lvbn8uMKz0U9YkSNhiQxPaZ/+G1fYSBtXIo2ORBrqY1cnusP+9hPz3gk0fGZuWUY5qOD3M9R
	2/tJOYUnCIiI3hUVngPpQtcQwWzZHvB1SbX5/+2pLMIAO6daOlNRnW135neaC0z/TKTU6+HS+39
	oZvNn4MKGNCdHyA4SUW8cZ4hPTVZuUFr+xybYnZx+Q19brzDGdrAdOW9xzpbcwNn0ggmAvIldPU
	olfSmAQ9fA/giTaS4Uvy/zuo8VezzEdYVNEdbyHy8rynm7/xOfbPcvbG1NSy1nQmcT2M2ktGYlg
	9Cws+DKpLeuhh3A3h44PE6ljIcGoylYVARKfwU8MpPn/bRudxO7GWOqxi2QwhYIRoEvYBnlcUIL
	wIV1xKIJ3xMeknCEYpJUlC3LsYiy2YXqSx313iY4JkE5VubjXjyQyHHYdCsx2gt74cS6VfUgfK7
	VO/K3Vgk8g9/+zwqqmZ9F2gxlk9AgdxnSM=
X-Received: by 2002:a5d:5849:0:b0:46d:d5db:98 with SMTP id ffacd0b85a97d-47f2dd02487mr2501924f8f.44.1783773403587;
        Sat, 11 Jul 2026 05:36:43 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960816sm66169851f8f.29.2026.07.11.05.36.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 05:36:43 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: david@ixit.cz
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] nfc: fdp: bound the device-supplied read size in fdp_nci_i2c_read()
Date: Sat, 11 Jul 2026 14:36:41 +0200
Message-ID: <20260711123641.32502-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fdp_nci_i2c_read() reads a "length packet" from the FDP I2C controller and
computes the size of the next I2C transfer from two device-supplied bytes:

	phy->next_read_size = (tmp[2] << 8) + tmp[3] + 3;

next_read_size is a u16 (up to 65535) and is never bounded. On the next
loop iteration it is used directly as the length passed to

	i2c_master_recv(client, tmp, len);

which reads into the fixed 261-byte stack buffer
tmp[FDP_NCI_I2C_MAX_PAYLOAD]. A malicious or malfunctioning controller
that reports a large length thus overflows the stack buffer -- the
r != len check runs only after the read has already happened.

Reject a next-read size larger than the buffer and resynchronize.

Found by 0sec (https://0sec.ai) using automated source analysis; the
missing bound is evident from source. Compile-tested.

Fixes: a06347c04c13 ("NFC: Add Intel Fields Peak NFC solution driver")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/nfc/fdp/i2c.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index c1896a1d978c..581f85f0dfa8 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -128,7 +128,7 @@ static const struct nfc_phy_ops i2c_phy_ops = {
 
 static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
 {
-	int r, len;
+	int r = -EREMOTEIO, len;
 	u8 tmp[FDP_NCI_I2C_MAX_PAYLOAD], lrc, k;
 	u16 i;
 	struct i2c_client *client = phy->i2c_dev;
@@ -140,6 +140,13 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
 
 		len = phy->next_read_size;
 
+		if (len > FDP_NCI_I2C_MAX_PAYLOAD) {
+			dev_dbg(&client->dev, "%s: read size %d too large\n",
+				__func__, len);
+			phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
+			goto flush;
+		}
+
 		r = i2c_master_recv(client, tmp, len);
 		if (r != len) {
 			dev_dbg(&client->dev, "%s: i2c recv err: %d\n",
-- 
2.43.0

