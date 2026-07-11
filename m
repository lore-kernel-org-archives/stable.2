Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2A635E1CB
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783755020; cv=none; b=ZHXIUwnerBVxnLijBJokwHrtKNDyRpINnPh5RTLeJF18+OckCsfiCrts6MEnPWV6acEhdliLK4WacJls7zAuUbNc/ifm73nDEGA/Yucae/9NuWLI8vuFH5cRKVLMY/LHtfk48P3hNsoBlXlmlypCuWzkKe9KkxppmUyVcLZR/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783755020; c=relaxed/simple;
	bh=GXjcU39QWcSzGAd3hgO5Q4UtPpQ/TQXwXEGgMc1w11M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Omm2ucnYpLahhORyVHcdbv5knJkQKZ1dmbn8IOtNC2vNmbUNkOCpd7aFAnAkTmxQXPaJNLIYLbQ4/RJqA0FNek36x21TPAekRXgFbFz9bhpUXVyGJnByecbFIPyPqabIf3JxWDf97mdx2ZZGiQXX0yzxXSteNtZKw32h+k4I/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=wuOoxcAl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="wuOoxcAl"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so1500151f8f.1
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 00:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783755015; x=1784359815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0XIBIITeNYjqyCVK5ZSVvlqGN7ycrHDwBqsn43mkLj4=;
        b=wuOoxcAl09quC24LTzY/PtdNcxDi7SW9yHX4Wn0HBtpyiU0mz9wVhLqpEADZfVioY+
         2dgUiGXm5uqoXJnUEo5MQ1/2Il9u9u3jBlPWFr4fpWFi1rCr4P4NOw2LX3RUJ8F7LPAl
         vDoqDAUBkDhsL0I7hE/ksXkqIUYEapd/MsRmvhye62g10SZ/MfqYIppkf7LccfiF1DRL
         eq02kvOa0Ta6wu4V8wjYmevZ8Zryi5uUx7KJkStyytCXAkujUTb38/FxVtwVkY77fY/d
         8fYk1Wo9yM+02xnV9EIAexhtA98jg3k8dDbf/Vch5WDgdQkwJRdy6I22UTEYRgbtmRB0
         RCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783755015; x=1784359815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0XIBIITeNYjqyCVK5ZSVvlqGN7ycrHDwBqsn43mkLj4=;
        b=jNL4xlSkYAxOIv9u2fPMQqmNzQ31pMCpAsJu3l8qPBAYx63U39zCBrrE1GCY57wQcM
         qYDXjN2IzPynFxOQnyMsVeJIuTEj3V67Wr4FHVxqzR9enD0EzhulFjGgEKDTDtdltsFI
         I+IUL8Q8xAoy37Zouo6EgFbk6WGZeC1ZXwb1LVWwby/9FexZrNlywexrxLWRTkYO8qbp
         yzPwsPX0RjLvCNpnS6FOFDUaJWali/O88TfSmO8xRQqcSjzUClfg4JctJjMnw0z7s61w
         lKyGEgqY+k1n/7l8wxgJdyzBmfFFwKezzYVrUAjULENuxKBE/gD7hWZZDl1zpYOBUsWz
         pyww==
X-Forwarded-Encrypted: i=1; AHgh+Ro3xSq2fsFsGCth3nYU47bCkHqxXev0U/GUyF9qxniPgw9k80dfFAiS7kSjrN2IcodLjv2csCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfyEttQOEwjUZv24Om1X32mcCfR0a61dI9uXmETaZz73N7KoBG
	3KuZSDFy6fOcZny3Ey94fKOMAvWwK6ccC5PDSyuUzk9h8+fePmiiuYnUJ9tLDNiDcFjJ
X-Gm-Gg: AfdE7ck5NrGlbZQUilatkjUDbYaPHilx0N70MMSYKPbiCrpjnubdKol1rnCLaLRnmvl
	jz74G/ghjFJfC1Ud+kqwJG6Rpql+c0h+FmHEA3OW3s6wxE8CrLlmFSDjPZE3GvxeaS0E3yq2Vex
	iSQzixnLLw4MXKTFTGjk4A/G73OVPHgsO5+RORRqz5ne0ZbzTSmXyKx6/B7+pd0HToFPVUwkl5v
	Qiklnx6UiPusfy/SCJQYs6GE7pC3vTP43m3Hj31UuWshApCCTtZFl4QNyrTs+6qMYHLjJOqOA/L
	EzGhACfGfFNL+ddThEDdMjYmSbetEmyVd7ecKBQxtdNPa2S859qxjHec3Z5rYY8U1PawdTu+PMU
	7l7lgps5qZFDlUbWwZ58vlRX4xnPvdQl4HKqZeAgUsJX8ydAINMJelJnlwnKjo1sk4YqZ1l+roA
	RG6kmf56TZJtW4NfIOaKDHUyUjxHumCcVoiMEKd2nCy3n2IdPln2pbmcvJmQ76xTfAK63Xty9I3
	Zur6cyffzVKs3OWz2JAD51TAHLQe9Hin1A=
X-Received: by 2002:a05:6000:1885:b0:474:13ac:a91b with SMTP id ffacd0b85a97d-47f2dce7c33mr1900118f8f.32.1783755014528;
        Sat, 11 Jul 2026 00:30:14 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ad69519c2sm71148700f8f.37.2026.07.11.00.30.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 00:30:14 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH net] nfc: llcp: guard against short PDUs in nfc_llcp_rx_skb()
Date: Sat, 11 Jul 2026 09:30:12 +0200
Message-ID: <20260711073012.71066-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llcp_recv_connect() and nfc_llcp_recv_cc() pass
skb->len - LLCP_HEADER_SIZE to nfc_llcp_parse_connection_tlv() as a
size_t. When skb->len < LLCP_HEADER_SIZE the subtraction wraps around
to a huge value and the TLV walk runs past the skb.

nfc_llcp_rx_skb() applied no minimum-length check before dispatching,
so a PDU shorter than the 2-byte LLCP header reached these call sites.
Drop such PDUs up front; every LLCP PDU carries the header, so no valid
frame is shorter (a SYMM PDU is exactly LLCP_HEADER_SIZE bytes).

Found by 0sec (https://0sec.ai) using automated source analysis.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/nfc/llcp_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index aed5fe1afef0..e3b3077e0e83 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1481,6 +1481,9 @@ static void nfc_llcp_rx_skb(struct nfc_llcp_local *local, struct sk_buff *skb)
 {
 	u8 dsap, ssap, ptype;
 
+	if (skb->len < LLCP_HEADER_SIZE)
+		return;
+
 	ptype = nfc_llcp_ptype(skb);
 	dsap = nfc_llcp_dsap(skb);
 	ssap = nfc_llcp_ssap(skb);
-- 
2.43.0

