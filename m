Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793566692;
	b=E2s6We6fWKxttNTSc/F84N6H4K8VIEwcEZ23it6bL0hzLhNugEi3EKywYuFYDfhVg8f7
	 XUK3xL0tgRcF1j2m+V6O+XsYgI4iMUUNSQwUdcsEl9VTSemIoV5TFPmDYAaJ7GItU8cnV
	 qMtfHu13x7EOfyABvADUgIXColdkJxkodndckq+1pMFcJKu/G9rcsRrKSxowhQLHwFK/+
	 u8ZptIhkONK8fSBNuMtWH2Ua8To1jGbjHf8r+waGVfFhCQFGk+Ju8A6pDAjSaq/20dMvY
	 ciqJEkp4Pwn/8/OIlqt6RA/4esA9ny+m2BjbRo0XgYPh3HHPQyTEgSEJJRbEHENAGNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793566692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ifNTGxpmeTaSsVFFoJbLLPWJbHDhOwV+LFaaqfbijrY=;
	b=ywSkTMmQTq+5eLP850jDkThABa9kL7kta9Xv1YhCHtpd4HU+IG8vJOVjrl2yVpCo7B61
	 3veKFRf57wQ01xLIz3YePw1J0I6DR/ENyiqMvN0XUSthe/XgHvH52e+ISRNznntCO+2H0
	 QRaPtgWW1phT49d4l/VGfLZ6PD5dghx0Nxoep6FRCuKKWFNc/QUjUrqdGkOwlK/+GQYGM
	 R0pFRMk5a/on5RF0jMpICgHe7k19GAHusOMs85Y7hi3RjX84xr3THo5dy3BwH/kZ/Xd7m
	 maTTCikh2f2LsvxzDcR5uPl98YLRKkBhlWtGxUOgui7s2M068JyZGS61DzYK5gip/dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HdLiPHuW;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1787E606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 20:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1787E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HdLiPHuW
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso1601621f8f.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 12:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793566690; x=1794171490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ifNTGxpmeTaSsVFFoJbLLPWJbHDhOwV+LFaaqfbijrY=;
        b=HdLiPHuWi1Ov8HMltkd/itvsfflnPS/YznXzonVN4VNEqFOIvdu6Y4x1H79LUpYUYr
         KSel+vfaGsgLg8qKEvuULN2OekcFcQSqBPm8hBQs7xLBSKV5Y+FovTwvW6olIvat0VzK
         8S1jJWh76uR+fGSIDqLyyJnY6QmqGi9mQ0BBNgy5rTsxGfKBwyDG+IgYJGjNiYw4oi2j
         0TKux42/u8ItLzcLMC/mz4P6iMwrzTnqqrHQ0sa78712rQv94DRWcK9vEp6OFWpWXbJa
         a4VXYDD1cRBNtVPN3mBTzkHaJ3AQRNO72uBWqvUjrIbKicBivcu0uIx2yKArFb2gR904
         OrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793566690; x=1794171490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ifNTGxpmeTaSsVFFoJbLLPWJbHDhOwV+LFaaqfbijrY=;
        b=wGVrcbCtcFiIL6I196AetErpwGdl2KdOqgYKMndnQQfq9rB5G1YRCOfaOw1pQFpOVh
         6RAdx0Z2y/KEe8x5k3mbtYB0FynbxHaEOX76OfzwHkNU7Eri9sk25E154QXIJXRTyKRW
         dbEpgPaV8bkZhgLjiB8P/1Q+QiPa4l6sHJaqGuoyQp5MH7T0gWvA6sV5jqIGkGekqSa/
         lV+KU1/MHsIx9VORecVZMHC38al1SBbidv9IVKd1MmX3m6E1EviHPVynUVrNLRMKsVFI
         Vn1pAsElAeoNftlLO+oF+wRopx0Hlj6SGMCVleT0a1ZUoirj4elshh49l0PqLdcNvhue
         qLZw==
X-Forwarded-Encrypted: i=1; AKwUvBxU80dt7bUoBdoTB6lXPJ+tZmV553DuC6/ZGRC0e0wLGhi2FgsZo5DTGiiH4BQLLEruHQ2aZao=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5QKRzDYLztgG/LCpimjVQUXikV2aEGgrxl0MJ1JZ1ho/lv1LV
	S5bBL9r3Fx5jwbiRys9k635vqcutIRt01eFNQWlCfDY8auZVwawkXTA=
X-Gm-Gg: AYBFou1DT/CX7ScK54oSsB/Cng93kz1xS3nYDCzoLgpNwo1t+nAROZFZnf+n575Kogn
	AgQBQU1UEa1cIuFnibM1LhbTHFEK18Vu4ZPBarJf7EhH7zPbazk9CmALsywL/T9KMBVzXrVGli/
	cKlpBt5tINvywrRje8+UuACP0foQTZIsOg4JSJPCMlJIDbfc6arXss0WA8X01uHrO3nI0bp+Osu
	9lBrS/kDk2j6+5/FQnMvsuX6D4cUYvulvrkuSSRPfWO3uLFS1UpIekTdVdjDxHU70IAcLP6cxf5
	g1E1kqwBxnfPdWjmbJvgcdlZNJu4/56v6fOdAvdfU71fh0lSF63YrIrDFeruJF1W5KIhKLyI0OQ
	KuRJdSgMpxIzBIurzqb+mMF7nrKjBdiGNGzpDVpi3GdWQdHgi5TbdY0vbGwbCKlOuLdccHQ65l2
	V50Qwxl6+MXrysAv5XrTCciJvLtg8fl8l/S2X2QWJqi+VAih6WEVqyFhQ2Bo1cF3c8F0aLdY4xc
	vWFhr5ZIkagvVySRbfButgIAFYSn5CoFnhOGvAsrC5P3jhu/BcIyxkDZ5ioPR1b+cVJ9GYTVg==
X-Received: by 2002:a05:6000:2488:b0:487:27f9:840 with SMTP id ffacd0b85a97d-48e6e50d953mr18832639f8f.53.1793566690433;
        Sun, 01 Nov 2026 12:58:10 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9eaeesm16002280f8f.49.2026.11.01.12.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 12:58:08 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless 1/3] wifi: mwifiex: validate TID in ADDBA response handler
Date: Sun,  1 Nov 2026 20:58:00 +0000
Message-ID: <20261101205802.2909524-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101205802.2909524-1-tristmd@gmail.com>
References: <20261101205802.2909524-1-tristmd@gmail.com>
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

The TID value extracted from the Block Ack parameter set is a 4-bit
field (0-15), but aggr_prio_tbl[] has only MAX_NUM_TID (8) entries.
A value >= 8 causes an out-of-bounds array access.

Add a bounds check after extracting the TID.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/marvell/mwifiex/11n.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
index cef8a55427dd01..7d249508e1a38d 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n.c
@@ -154,6 +154,12 @@ int mwifiex_ret_11n_addba_req(struct mwifiex_private *priv,
 	tid = (block_ack_param_set & IEEE80211_ADDBA_PARAM_TID_MASK)
 	       >> BLOCKACKPARAM_TID_POS;
 
+	if (tid >= MAX_NUM_TID) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "ADDBA RSP: invalid tid %d\n", tid);
+		return -EINVAL;
+	}
+
 	tid_down = mwifiex_wmm_downgrade_tid(priv, tid);
 	ra_list = mwifiex_wmm_get_ralist_node(priv, tid_down, add_ba_rsp->
 		peer_mac_addr);
-- 
2.47.3

