Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795728268;
	b=YlB+8n7W1mtzLM0vEqu3+mcXTJ2x5/f21wQhPXARjnEhfEcAVftuCT4G6NI7PpzIBPqq
	 /z73aPw+D+de73t32C477Rgn3SAn5Kjp/zqW+PSg+xx0fkl0mTcmfx6hd5KX34ToLrWDs
	 O5eszsFYWbYOhnlLnfuahviszObrFJDTEbSRCteL+APRuU+1fXnq736lLuw2WRttreee4
	 WC/1iUXCFmgiRywNgcXQFZqHLYPK8BCTmMeafKZIE0ERApUU12nSJFrEIW0l7qpElWbAI
	 ma2B1yrixNgtSx1dyYdn5eUWdo4x3vTnUrqGcSKtLxwzwZ2OOYpgAiD3XyZY8ffO4nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795728268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NdR/Ydz/Y2I2j1/kAa1A/J/L0/r1xq3ZJbNsLr+3loM=;
	b=IHOHWT6+5OwJZxIBGbRBvOvFGrhpIPajmqItV2hn9bt6gBf0XoFpEWfUZtzJKefBXnHv
	 2hgI5beYnuee8U9mLTNvjDFs5ayhSj+eomVeixRS4cAbVovOQHjoVH+EtWIEbohiBZK0u
	 q5wqsahKzabXcIDloz0bPNLOciHn5EewwnO78+9uYe2vyWBYHinxX8elEe4Jqnm5l4G4r
	 DdhTsRlGJJdPYFco4bmxC9F/R4468NOt9dDuT9zjAqkFz2ISUuS0eQK32WBAySC9XDoLO
	 jXDwyGe5NFeHG8GG9mxylSUaLoiEi79G9sA1KyxbNqZc6BUZnnDAHwcJtgSfRPxlZHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LM7c3oAQ;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627E6606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 21:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 627E6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LM7c3oAQ
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so5035047f8f.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 13:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795728266; x=1796333066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NdR/Ydz/Y2I2j1/kAa1A/J/L0/r1xq3ZJbNsLr+3loM=;
        b=LM7c3oAQZ01gabD7Gm8C8Afdd3EEMosgzw90KWsk7y4vHp2L2CePldAe9Tll+d/n4J
         5/GI02ux61JBPLMBQmvY0oFuUkJyUqq0FDn5W7BtmevI9t+OZYDCqWSHoHtWAu0+7D3w
         RgmJMCqLXmmzsiUU/aGSjX2KQPr62b3LVXvODnlUbhQnU8VTjarJ/0P0VY11R2Z8Vjuu
         80WhyjbRh8/8ymwFIaAVnHJ2EHfK1u3yPVEla1s2zz2zO9vxK0ImatP2POMRxDTILKrO
         dwPJ7bG+hyOcFVIpZdqYcJ1aREZxHzgqCXCbWU0t6c1uFzoqVZoRG2SiCuUUVXkFkxEd
         r+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795728266; x=1796333066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdR/Ydz/Y2I2j1/kAa1A/J/L0/r1xq3ZJbNsLr+3loM=;
        b=bAiCRovzZyfQyml6geElvgjO+zbDUPBApNFZakT/ZaFi5vU/GjfYuoIQXuy4KLU0Ny
         vC/7WxSqob5NG3FQ1TQEhw3d1nd60OYGfm0ter0FI+z0Da1eTVTY7yTlUbzGWH2k/pys
         Y4kmYEUObWrAVX6OQUg2fRxYAST4QPvuldw1XRiTop9Qbd0mk/cTOLv1yw73pkL7DN2n
         HaGD6if3GU/FhLggO6TQXCmkjJMl9STyNSF6C22cR8+5eDVfawDItBuGtajrEn93DiBF
         iAH9b0qk0yZIiYG4Y5knXP5Emm79SoVY9nqAhI/QeKLhz5yovizEA14VBLb/IwJUiC7O
         dZQQ==
X-Forwarded-Encrypted: i=1; AL+hErHQnXhvYAZr8s0atsCPIBav75YH+6BCanhuYDsPahgbsgsJ7thRdHpRGueUfxS70nF8g4/G4Ks=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kvzIH0T6kaSl9oyid/A0TBN+rjUh3M5pvgEov6Dn50ci2VXTF
	GKE0Wt8U4Z+GZOT82PAteUD4ZwUH7NE/GcD9qdyT026RFE4QYtEkJDs=
X-Gm-Gg: AZFdTZeHXknKLtAffeAEnAIAtuvY8XMCW4LWrc3T3WQeTS7D7HXx6BMfOjVE+7yao0W
	clgsB3l34AYTtQTGpGPfuf4ovfYhLOiKQ820V1IeTQPb29p3YJBE4eBznMwmszOs+HuWlFN0OFe
	MgsXFrcwsZtg9CWnmeRqDtgpXlzVDNlVOtzyTfqHz4ZcCZApQRaax79fesDiWJl8TvuUgEkW7BD
	Wi8abwj85UL9Kjri/r/uKjBlAlnwHu89bfWyEXbxnUkA7IUGWgW1GbdSFkB/IakC3VM4VpjGApV
	fJTDdzktIptKSM16JgG21KvEuiH9fiJ/T3nyUhCh4321jV7OVmsIfpH2CkQY8tmG7PyNi6/4p5i
	CveFptAeL9WLhMXO/f9PSvsrC+ve0WufEBf7ZTetJG2QJHd14lJn3izio7Ymx4D9/6hYE+jWiCf
	SfXCXNGNUiAVmdrYO5YSP8ha724M464EgoxTz5r9pb+c0Xkb7owtLdEY1A7CX07rtcmgheSoGkF
	m1yIWXQtFLvj3CxdUggaJVKU6YM7+oe6zZ6ANMun3/VXZIEzQOsDZ/W522mhGiCtEPHuwxvDfBy
	vEjMzSbye5YsuMjK
X-Received: by 2002:a05:600d:6510:10b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4bb8881de57mr309135775e9.26.1795728265576;
        Thu, 26 Nov 2026 13:24:25 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm612522675e9.15.2026.11.26.13.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:24:25 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Franky Lin <frankyl@broadcom.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless v3] wifi: brcmfmac: zero-pad SDIO write buffer to 4-byte boundary
Date: Thu, 26 Nov 2026 21:24:16 +0000
Message-ID: <20261126212416.1397643-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

brcmf_sdiod_skbuff_write() rounds skb->len up to the next 4-byte
boundary and passes the larger size to sdio_memcpy_toio().  The 1-3
padding bytes beyond skb->data + skb->len are sent to the wireless
device uninitialized.

The SDPCM header carries the original (unpadded) frame length, so the
device discards the padding.  The window is therefore limited to the
local SDIO bus.

Ensure sufficient tailroom exists for the alignment padding before
zeroing it.  If the skb tailroom is too short, expand the head to
make room.

Fixes: 78b3f1c5be8f ("brcmfmac: replace brcmf_sdioh_request_buffer with brcmf_sdio_buffrw")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
- Check skb_tailroom() before zeroing the padding; if the skb
  tailroom is too short, call pskb_expand_head() to make room
  (Arend van Spriel)
- Use the correct Fixes tag: the 4-byte rounding was introduced
  by 78b3f1c5be8f, not by the later function split (Arend van Spriel)
- Add impact note: SDPCM header carries unpadded length, so device
  discards the extra bytes and the window is local SDIO bus only
  (Arend van Spriel)

Supersedes: f935e48bd9a6 ("wifi: brcmfmac: zero-pad SDIO write to
4-byte boundary")

Changes in v2:
- Original submission as part of [PATCH wireless 1/2] series
 .../net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 71c2f99cdb711..e5068da9672cc 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -317,12 +317,23 @@ static int brcmf_sdiod_skbuff_write(struct brcmf_sdio_dev *sdiodev,
 				    struct sk_buff *skb)
 {
 	unsigned int req_sz;
+	unsigned int pad;
 	int err;
 
 	/* Single skb use the standard mmc interface */
 	req_sz = skb->len + 3;
 	req_sz &= (uint)~3;
 
+	pad = req_sz - skb->len;
+	if (pad > 0) {
+		if (skb_tailroom(skb) < pad) {
+			err = pskb_expand_head(skb, 0, pad, GFP_ATOMIC);
+			if (err)
+				return err;
+		}
+		memset(skb->data + skb->len, 0, pad);
+	}
+
 	err = sdio_memcpy_toio(func, addr, ((u8 *)(skb->data)), req_sz);
 
 	if (err == -ENOMEDIUM)
-- 
2.47.3

