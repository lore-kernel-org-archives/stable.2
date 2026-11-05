Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793916053;
	b=fHWQBrtx89C2qAf3nTVXM30W1InAXcaHJKTlnBPU8ND09Ak/QFP+EDW9XpHsSlliVI6g
	 h0oXMSGGZqA50gdFs0SxRw2HwmKoVZLI/2QoBN0M37y/e0MBgrdQyd3mapsYzkdy8w8YH
	 jEe0PwsmrVgqeBpcaMAETWdDr2Nk8Y9ABWKRM1T/Nkuq7OFmWCp35L6Y6yxpC+oZCqGyn
	 r5KdrPdy+aP7ggsn5vTocUgUDtNF0l98OzQbdzCg/JxlPFRWz2TD7NtZk/zHTfrr7AnkU
	 DEOmOZ23HF7JAgOkdZ85nYycgbB2Q6qtd2l0QsDec5dUu338oij8u7JbWcRWvCRybOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793916053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EfUxS4j8KiqdcDZ0OsuVJwqrTRdeU5cL78NKs2afAZ0=;
	b=hoFSM0tepu3gMhMbxWq+9KK4sYNSQFaWruXLHedLcT2zpGhTA7YcsOCZNgQXvnqujmFc
	 Z1TPKjbph/6/CTfQr/hc8c5pTAM2E1LDaPKT/4du9iyhPf+gcVxWKttSYN8rv9plHupSg
	 zIxDaAt4hwzLey8cOSuX/nhIeBawlQxRtfX5e2fPv1FHkkI4vkBidS0MszoJPg2IcRYdt
	 ucEWCb7gTqW+E/21FdDPXaSf8m535poO0HHQpRc94f7NIimVqq08myYbzeeheSxUkDWTt
	 D0tIKj7Rv23vqBqUUmSqv7gEoCfV6jDRN26fllo3Glc77acWRLFXTYmBkc91nhDU+5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ci0DxVVh;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49C3606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 22:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E49C3606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ci0DxVVh
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-490f38e9688so16416f8f.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 14:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793916051; x=1794520851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EfUxS4j8KiqdcDZ0OsuVJwqrTRdeU5cL78NKs2afAZ0=;
        b=Ci0DxVVhIjk0x1XyRoJcwvBseRlqz1xvafs6sCvRiPLpQARiLsJFPHkI3EDBdodKz/
         DjzQLHV3CN8suhVV9m4KRHqcS01fppqIql32A6Ng5k1c4EsNLHTycykHsDkN86gIJ75J
         nE2QDGuYYoEqVepJ90qiemWmoJw4vYrhNC4pAyVnm6n6c55G9398ilZKFWO0bvT1PMCk
         MC3y1gqkGALUrvae3c71/KJ/x5Ra7XozlWhh9h+jvSjfYaqYnZ+gdW4LDmBwOOmce883
         GLqRaOTpN1tYjDpIodENv/evo22s30xxwQSJYNXJN9zRMTXVZKr0xYOGz2Wa3DD/qA3n
         2YyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793916051; x=1794520851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EfUxS4j8KiqdcDZ0OsuVJwqrTRdeU5cL78NKs2afAZ0=;
        b=O2gvUVXsHIMBhp1XQy+0cU6HwCeYFN2tLn4wtqUJjjrm5nf4YBEs7iEy7WLsxGXUA5
         VYk2kOGM99Jz3MjHlOeJZ93ZFDrtfftDsZ7FiRhX56D7mCUcAqkexW0c2SnMpvc0KHo7
         nirLKjvmTS06NwlqYaXafE1d4SbhY8u+1n2D767zc+yaesn1LeUE3uU5tVHV+0+RodVI
         9ghYtSrZ6Be0+Vph52OI5fmuFiFmJnmI1wr6ra8gCVoKKw8m1rjOzNVVUmbDDBlHlllA
         VWgoWk8i6XRlcwYunyoomDP2jWKtE/N2WHA1eFQ7wY0AGJku9/tlNJ4tGDhoIMvP80IX
         20ew==
X-Forwarded-Encrypted: i=1; AKwUvBwYCkNW50V6kJrjgjxAFouSRPgL4fCqLdzT/0j6PRsvbXKI2eckm54TsyyqlZ13MuNVMsdCCLM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zaHvOGQFDGFOdCdv9SQodln/5lGaXmeGbWfomHaydp2ktmSgG
	BK5ZvrYT2oTe9nwTkGeMYhOhjo6sviB2kUovRKjUt9qQZwct9pqiQ3VX
X-Gm-Gg: AYBFou32co+pau7g8UOdzBMJ1TRs9DWwnCI9jskZ9o5U5pwWz8zc3LSWYV+JPni7xOX
	zj4BdBGoEsDXc6d940ec4auhnYOf1CaJbCvywVtu6jxIyE6Djn2hC6PuaWx+ExTffCiwLPa0DMF
	GfuDJPwXfonXBWcUN3M823La8Oexmsb0X79PbZYypK8TnaWd7nAKF1hiDDR0ErZ/4QvVV1eGylG
	EHEpXXIPhDAS2m6JRf5EQcGsIkYaqhIKvLKJpZzviDUQMF15UNxuq/N8Bpegbc59pV8g16wN0Xb
	y62wGCOcSJSsIj6fDSNX2gHswccU5ONjVRT7IwmSsPxibAxioXtKuBguj0CleVrV77MlBxHofRy
	hIEqFYBE9pCVNnFiDk9EQ95vL1aR/jg0zP1wIvkH3zpEXtFikrcehQA5gLoJ5FA2BNvaE82fzTP
	qwyzBDBnRaWdKw9WLpY9RAtz+s+HN3fUsmiirX83eyaT4MTgmjNkCz7x/2Uo1qY4mQUL9gv+WuQ
	50K06MKh71rHxSI//fwItcGaCVpIuD9eKh60uUsagsbJEoy7JiQTYHsV7tINbcFGgFxOPArid+H
	baD53an7pndKanJs55q83pds+Y7BXKP5WhglGGti/JqivODo7g0DCNzEOAlqUgrEHCDNFfH6SlL
	bnbQ/W9Dm
X-Received: by 2002:a05:6000:40de:b0:491:1468:a504 with SMTP id ffacd0b85a97d-4927997a35emr1710921f8f.21.1793916051004;
        Thu, 05 Nov 2026 14:00:51 -0800 (PST)
Received: from soeren-MS-7A32.tail37253f.ts.net ([2001:a61:13ae:e301:329c:23ff:fea4:379])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda203b6sm11922212f8f.48.2026.11.05.14.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:00:50 -0800 (PST)
From: Soeren Coremans <sorencoremans@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: arend.vanspriel@broadcom.com,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	Soeren Coremans <sorencoremans@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless-next 1/3] wifi: brcmfmac: pcie: stop console read on invalid write index
Date: Thu,  5 Nov 2026 22:59:52 +0100
Message-ID: <20261105215954.184290-2-sorencoremans@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105215954.184290-1-sorencoremans@gmail.com>
References: <20261105215954.184290-1-sorencoremans@gmail.com>
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

When the device drops off the bus, MMIO reads return all ones. The
console write index then never matches read_idx, which wraps at
bufsize, so brcmf_pcie_bus_console_read() loops forever and floods the
kernel log with 0xff characters at several thousand lines per second.

Seen on a BCM4366 after a firmware trap followed by a fatal PCIe error
(FCP): the reset path and the failed dongle setup both entered the loop
and never reached device_release_driver().

Return early when the write index lies outside the console buffer.

Found and written with the help of an AI coding assistant (Claude Opus
5.5); the cover letter describes how.

Fixes: 9e37f045d5e7 ("brcmfmac: Adding PCIe bus layer support.")
Cc: stable@vger.kernel.org
Signed-off-by: Soeren Coremans <sorencoremans@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index eca5f5f63bce..02c58de67b82 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -992,6 +992,14 @@ static void brcmf_pcie_bus_console_read(struct brcmf_pciedev_info *devinfo,
 		return;
 	addr = console->base_addr + BRCMF_CONSOLE_WRITEIDX_OFFSET;
 	newidx = brcmf_pcie_read_tcm32(devinfo, addr);
+	/* A dead device reads back as all ones, an index read_idx never
+	 * reaches; without this check the loop below never terminates.
+	 */
+	if (newidx >= console->bufsize) {
+		brcmf_dbg(PCIE, "invalid console write index %u (bufsize %u)\n",
+			  newidx, console->bufsize);
+		return;
+	}
 	while (newidx != console->read_idx) {
 		addr = console->buf_addr + console->read_idx;
 		ch = brcmf_pcie_read_tcm8(devinfo, addr);
-- 
2.53.0

