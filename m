Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195FA2D47FF
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665217; cv=none; b=TDV55h6Rg2KhXS5e+4j0y86G2F2h6oBEyj+Bg8KfqsWl+TvfZ6iu2FFRoaKTBA1VKGiwOCB95lG2wOvXW4mYh1k93C0LzYdLLSOUoZz4690tzgvlJFxaubnFse1GITQ6dIn8uPGjlPeWqAICuvI+KiPfr0MiOdybCILYk1Wo1A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665217; c=relaxed/simple;
	bh=ReLUpbKCCfPRSlFp67b24hj0Q8lRvyhr90kcdYzXrLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXsXSfmnTb1K+GsjLumyX9PTrgMBfktq4t8l/jii2MCUKPz62ada2IaE9DvEXeIzjgWIVFjjIE2EZ5QurW+S2EB8mGHLi4DcQBM1Kh0V5I7Hyod9CHlC6/aSzC5EIyUttx1yXd3Ni5ycQ/WtbQ1Uwe7AEVjlekxHdSeY6AbGhRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFX8oNux; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFX8oNux"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493a613571eso5358125e9.3
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782665215; x=1783270015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woNdZCNc/MzUa1vCL/yO/R3w6USI7p6fKOo+IjB4YGg=;
        b=YFX8oNuxj6MJLgHvXNqzJTIUoaVaF5gQsJWzLnADv0JCd0vVoepNHGAbvMiiQ6zdXS
         ui1ZGcxpzykrPiZyinfdklRT8v2zKNbrrMekBvC8l709bz8o0scTuUNKWt3n2UAu8OXW
         s8GBb5ZYYdPdJW126NeWbyTfldHgBuO6JW/3JVaIPVaGTgpGsmjXMORC/ZbCorqi5P+N
         lp/RmB4I14PM+/GsVtFRxGBmQiMGXY7q1qw0yPLPK3dhSK+8XlI9smj2MktX0hP2BUCC
         kcipEsUJX5acK42zDwE2EUqhN/f+N2K3onrxSD5BPjVFaHm2+w1eDo0AtsmM6nh0DJbf
         8f5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782665215; x=1783270015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=woNdZCNc/MzUa1vCL/yO/R3w6USI7p6fKOo+IjB4YGg=;
        b=Bt4UfHE0bMj1/CXeQw957OOkXf2FUnlKX5P8KaiR35+Nx2AFW1bfDEJHcvqgWbPtKm
         53wvbJPJJgXUDEpkv04dJtoVdGyUOYDzjbGaUZPcvBy+FxemwKKT0fq8rHIUKfYWIX1T
         G4rRW2bAaDykY3QhcjteWF2R1191Pc6Pn9sQDksWPQeKTYRV1yCFREdpDfJ/8SXlL3wW
         YuyiMT8757KUZg7Atyuvvv1Lbf27B2a2YObIDeKEEjs7G1oxdSVqgHwSkhJhfQmBR2/B
         4CcbMNiAGt2je1H3Q7hhBxHprzzObaiS1GribhNBxDqLdXcbleWmdkpeBeoYPHnrL+iO
         VOng==
X-Forwarded-Encrypted: i=1; AFNElJ92gxhkS4UAoT3OSe8sBPmGzF6IPZijc2JZvnCmReRPNFApWeMDz9bLPTKrU/wDT2es/udn6CE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm9CCGbaDNic47WAJ6DzyaC3gp1eaPq5diu8WS6rDDCD+re5LQ
	nUNm9+WYCN2iyONyj0f30KIHLkqwqMwMkDjwd9y2uBDbkL0KoS5fP0mJ
X-Gm-Gg: AfdE7cl0Fn8zRJFRFQ2xGABYe1X0aNQLCNSi03WXJeT+udt9EMm7lkqjAa02/5nKecN
	wBiU19rw2006q4WeJPGv8vMeOt1t8WHOBKcw731kRLncX3Gk86x1DxX/8zpa3KnQ5UyoLtgQ4EW
	3woLsYcI6EfpPVe9dDi91oESpnU7p9L0jXWZZeXJzCmlzqGUjyNE3augMoz3OWnGxhvemEZFUAJ
	IE/x9D48PggxF8kOhjR3uv485DHrDgasBxd+hEDjkFdlYJkEg3shajYvbCMmAo81G9Rt5gmiu9/
	wn5XQARU7lJODdYBaVE5RLOkCtEhjvVxTw9bHwLRWltVHv8YzIfCMcmxsPoMa12DkvEwCTRHUIK
	gfRhf2wGGBnk5e9V22KMqvpItvxyLe5YWA01WuuZlcaKCxEaV5lRBehuIhDSdzctxean7Z78B/q
	/Q7/pN+bD6Nz67O0/J9CfXk32Oxw==
X-Received: by 2002:a05:600c:4e4b:b0:490:b724:5085 with SMTP id 5b1f17b1804b1-4926689ab05mr198128225e9.33.1782665214551;
        Sun, 28 Jun 2026 09:46:54 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c285fc1sm162770715e9.1.2026.06.28.09.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:46:54 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 4/6] HID: roccat-kovaplus: reject short button reports
Date: Sun, 28 Jun 2026 18:46:09 +0200
Message-ID: <20260628164611.17467-4-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628164611.17467-1-alhouseenyousef@gmail.com>
References: <20260628164611.17467-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Kovaplus raw-event helpers cast button reports to a five-byte
structure and read all payload fields without checking the received size.
A malformed USB device can therefore trigger out-of-bounds reads from a
short input report.

Require a complete button report before updating or forwarding it.

Fixes: 0e70f97f257e ("HID: roccat: Add support for Kova[+] mouse")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-roccat-kovaplus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 9ec42c218ef9..55de262e165b 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -614,6 +614,10 @@ static int kovaplus_raw_event(struct hid_device *hdev,
 	if (kovaplus == NULL)
 		return 0;
 
+	if (data[0] == KOVAPLUS_MOUSE_REPORT_NUMBER_BUTTON &&
+	    size < sizeof(struct kovaplus_mouse_report_button))
+		return 0;
+
 	kovaplus_keep_values_up_to_date(kovaplus, data);
 
 	if (kovaplus->roccat_claimed)
-- 
2.54.0

