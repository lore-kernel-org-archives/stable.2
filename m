Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164069;
	b=NEvG872gVEFkmzQo0m/qxKLMdumGyZE3vjjuPBDhi2ZxxVyDW1K3y8Q2KAIjI8FY6x2p
	 +8u9OTxfmFTzooETjzIYtd8b0R2ZM1KDiKAKp2bmRAbgOirgmgERXvEmcUwRga+4pPytE
	 GuSdFTwGAKq5F7QmdaF6EOuiTchrPEdoXgcsIk/Np/bx2Cc3jNOcCorQPp8uCRwMwC0ji
	 iSnAOCE8A/Q7Bs9mYToWatHxgsSHZrxto8hCc111GY4LneJXWN70y9sZAI7U7ZyoKhYbY
	 AXDg6FTFt5ffzYlLMJILiwL4tpeWpavUbAAPcXAh2A/aPIZzj/7lo2JHGMI7LBNCaqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vkzLSGS2/EtfF3lDjWx5RTNsXPS6BLA3nJkka+odvM8=;
	b=KA7CsLrTR0O3OuDgjSaPCf3HrHKLAoKfDW9r8K6juYhuyRPBaaMoh8jyBvQrTH4BiLcI
	 A1daxSRjPYdipSRKRGZeN4vJHE5sxLNc7IdD0ap9C47/JoiaCZmz+TTIQbz7eVN/QUlWl
	 wwHXqEQ1Dyimg2QdrFf9bd9huWABrm7dc4ZJOqJqcWrlcGlU+5SX4OZRop+CgL1/1Z1or
	 F9Gg3eT7DkSny+KLWE57L6i/dWFc/nhcrI8bfiUBhrh8H92VPuibU9sZl6vayTh8VK7pi
	 s9mepcAfLWOPMI/Y23KVfvx71wYLjfsIlg0f75j6210y5fbdxPvvioYi44Qv804/+gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HDbf0pDW;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C49C60A5BC3
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C49C60A5BC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HDbf0pDW
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-372bdb942dbso825140eec.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164068; x=1795768868; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vkzLSGS2/EtfF3lDjWx5RTNsXPS6BLA3nJkka+odvM8=;
        b=HDbf0pDW6HRvSYER+4Zy6Bhgv8bbnW5DHw3wmlOWnnSjh28UrnreoWPPR3KIK3CTp+
         tOFtoFVqPoG7g5v481mOcCqC/RJwSYvrTzR0kO9ANWnLqXpe9wo5cAAxq3l00SER5FGf
         ApeFM2fuPH4cBLyU6pMq15YCCweyfo0fN7u+tjGMNu3tO+8tyJaCHKHbLsnEv0S9NHm1
         oqWvmQ73wt04VjtGP1Y7659yFGbSdOeauRpgPGQ2Niazh1k5rv3cuijUtexEEaiHTC/i
         o8LKwNde3yrv7D9Lved+AP5Bj2sb6UZdpTjmGMK85y8GOnQBsU55IpLos075iVRbyNIl
         JC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164068; x=1795768868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vkzLSGS2/EtfF3lDjWx5RTNsXPS6BLA3nJkka+odvM8=;
        b=z0Asuq1rYEkzwrEoHQC4DUnxmlURO5rZ+8VpTrkm4IPNHenQtw6YIRD0y/r+knKbyl
         hTvZFXHDeLjbY5zzgzeqaHgNzfgm08h+3rZdcA7FHOUWiDTZVRQzikTloySffyLQLri5
         dQrdX4bnmZNcPgo2mUK0bTpAvcBL3TjxUQj2TcF7g361jcV5r+kGuEVQbbC+h6iK1pqv
         Km2YrunFyy8f3bQy6QFvKs8E5TTtyqZyBLDU9kNEFXZosimaROyXrZT6bTIZXF7VMeP7
         uvCI/2vof1kDfEffVpVNcGc40PCubvk3zmzBuEvx5Ge8jhtRjRcj+yZ64/Cz6Lzl3X73
         KkhA==
X-Forwarded-Encrypted: i=1; AL+hErF724ZRlnFLenqvkKB6SIJ5/rCJiYKqzuIER2lqRQRNkfR6zzOU5cxZccgZ4+4EHhMDG1nCXZ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yvw9wpNyXjiMjOZ0sLoC6ZUGhhSmrzy4Xdh1Ubbe+VroHmUpv
	WCOBVC/M7JAg44WksjRAUNK+WYn9A9W8MEvzuyr5ibYxPxUhSB2DuyBW
X-Gm-Gg: AZFdTZfpbwpBX0XF74V6aeh0+9aAavOc+TXwqDA2YIlDZ9WiA2+z4mrDUmdKVgKxBba
	CmIruuZVZa7sorw0jm9OFJ77w7jNDFIpf2ONK86O/CuDgOaPIGzG75fUJ0t925p0+YDPOOvyNaO
	2Dpku8OOIfZ2MMtOW1i7Q85+8bKpLMltV6M7/jro3EU4O00TDAeZyKO08AzYgJYGqy0psrBUXcV
	W5aPg2vYoz1z+0gKh8a4RFQ5PVOX1qOx9hNqZR7yPMdQPnINCaz1dhnyab1xeShtkHM6mjA8N1E
	etNj/X0hsAZ/Pp06z8dTkl2fUHdmGVi6OW4pbmdpJTgzl6a8k4aE1yX/6FdkX7jceQseq1Xx0IL
	Sud+RoAhXsphkcPTa7bUI/C9t6Iqti8Y3AbLc1hQ7vLecEhBckxy7C1734XH8rUwYMcnwhuDvua
	k+DkLqHFDI7nMv+H/Vnz8dUKdSJpnBLJeXbnw/q/VWa7f9FmaJaB45/nYRobJLzLGbkEYiz7f0T
	XJo0tFR1T6nEZMPrR1RJ9g3Z3TRUBbhDsOyAAk2IgFufLNEHBmcPRv2utyONwYvLajcpBxlgIUw
	MHNLsLSG9eNPFhexHvLEB3UHvMuaIv9Plp1j44fPan2EKTflrDB5Td0ej88ulXv/KJccyMgDxlu
	/MFsWfBoZTLM7qHF/Fg==
X-Received: by 2002:a05:7301:18aa:b0:384:eec:aba0 with SMTP id 5a478bee46e88-3857073eebamr1937266eec.36.1795164068086;
        Fri, 20 Nov 2026 00:41:08 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:07 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:55 -0800
Subject: [PATCH v3 07/14] HID: logitech-hidpp: fix off-by-one in G920
 force-feedback slot tracking
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-hid-logitech-hidpp-v3-7-cfe2caa1d0eb@gmail.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Logitech G920 firmware reports 64 total 1-based hardware effect slots,
reserving one slot for the built-in autocenter spring while allocating
the remaining 63 user effects across 1-based slots 2 through 64. Because
the driver subtracts the reserved slot count upfront before sizing and
bounds-checking its slot mapping table, the 63rd concurrent user effect
is assigned hardware slot 64 and exceeds the stored limit, so its slot
mapping is never recorded or released and remains leaked in wheel memory
across device close and reopen.

Keep the full hardware slot count for table sizing, lookups, and slot
bounds checks, and withhold the reserved slot count only when creating
the input force-feedback device.

Fixes: ff21a635dd1a ("HID: logitech-hidpp: Force feedback support for the Logitech G920")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 53c171dfcf96..0264e4541edf 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2872,7 +2872,7 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 		for (j = 0; hidpp_ff_effects_v2[j] >= 0; j++)
 			set_bit(hidpp_ff_effects_v2[j], dev->ffbit);
 
-	error = input_ff_create(dev, num_slots);
+	error = input_ff_create(dev, num_slots - HIDPP_FF_RESERVED_SLOTS);
 
 	if (error) {
 		hid_err(dev, "Failed to create FF device!\n");
@@ -3486,7 +3486,7 @@ static int g920_get_config(struct hidpp_device *hidpp,
 		return -EPROTO;
 	}
 
-	data->num_effects = response.fap.params[0] - HIDPP_FF_RESERVED_SLOTS;
+	data->num_effects = response.fap.params[0];
 
 	/* reset all forces */
 	ret = hidpp_send_fap_command_sync(hidpp, data->feature_index,

-- 
2.56.1.750.gf70dc682cf-goog

