Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792499454;
	b=vGo/IeE9OpYO2p5P9ZtpARXBPue74v0fRzQpaWwOgSQ53NUS+0F7szRDOwbLMX50QZCm
	 BP/nscK01SNkJraN00Pv5hfURyr0Pk+HjykNoxSJDC/1ZNtNhIz+V5GweSJbNd46U1G2p
	 gr09smoH7reFjwTGsuYhaZErFv1q4ed/FzqLo5U2f/iFOQUqp5BWNmGJoXnzJQ0f3vDye
	 j3RrSbRzlWH58941kjVZaQ60dL+l1s5rwbPt+TSKAmvFfn+qj3HfBgaLbUE+D4oSiXTmD
	 8sYxTEPS+nYeifOg26d6SwTLTcGOmkpmGgFXcoZO8qCFfZUaJNpTXiW4zKo3a9eFY2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r7W1rJt9IDsmCTMPs7E6cwvO7KQhC7QspT2DHRypph4=;
	b=bcBWw/7BbVcVLOJy0P5ginjsMzyWX7myASQPhMmergYuyVX3CGsVLOwGnvTfWjsOvdGN
	 LQ5vtHwzfY+xEcFYUX8J4TXLaaU2GL1iEjdhURi0S/jIRdGnhfNXKxFOkyZj0bwc57m0t
	 qGvafuOh/08IqAXgqkypCfBnsKniBUHkaNOmXA5JlXMDjxH3uuLrZ7JcVihvNpomb9cjy
	 kX0R/tYBt4+G6BSrFtga2Bcw3z8R2fwaraxXFG8aFzyVrW/EHTNtTMC9gNtYB3ADS+5iv
	 g6m8l5Uy94w3o2qtS9qXg8h8wdH22N5KiZor/Gl8KZwknWGf+MuKynjZybAYb4kvIBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MGbp4qZx;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE1F606A31C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CE1F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MGbp4qZx
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3acb1224533so600466a91.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 05:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792499453; x=1793104253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r7W1rJt9IDsmCTMPs7E6cwvO7KQhC7QspT2DHRypph4=;
        b=MGbp4qZx4EIRTCRzrgZYAtC3H9I/XO6VBPTbo8pn9LEgZOZTyksmEy7aqBTwRyBF7C
         1naFXOUIl6s6tHJ/P5/Pd6/U3k6/2qlYFbCns7qRjf3neh8me0Uc1RXxwpfXMV/rH/y9
         xVJzdQZT6kaD/L3GNZOHcutF/ozurPybsN2HF1raYKixC1t3bRxhSxrebYup30NFqgiZ
         AGuY5qA0pCf96gWY7uh+gX/F4UWA7QjaZe8fYOPs8l0iFHvdhLCRnDOyiKVeH0Dn1Dk3
         mHjV8a2Krz69nXhInbWwG27e365r7T0KwgNLud2ERPkFXBMHj0VHVrtuv1K5cRrzOtAC
         cIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792499453; x=1793104253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r7W1rJt9IDsmCTMPs7E6cwvO7KQhC7QspT2DHRypph4=;
        b=kBQ2WYW21h24GxsN0go4IAQi3PJ7EL39eauaTtMLHw1tM3yALDyWgbmUycw4yqPJnW
         2+T++z4IhBOemDD0HQXzGj1Lrxj9vwsyaLniQNLQxJKn15PYxlU+QcUzrC/gx2GRLFjW
         iA/+ZRg0ztrGodQ1Zg+rR0ylGXyRjf9cK3ijmg5AaBJK9z+4pfYDYNS554sbFgcNdFkE
         e4L7fyeBz8c0lI7ny0zWlqVu2uhDJ7KCGI7VIyRW3w+ZznM41Vpy/wg8prTAxKHO8jdG
         vEMfSuEh/RKhhmW0a2SJ3muPvdcCjckQerHoOeL9pe9qGXMppbHuife1Qtsl1sOBq8nq
         CAtQ==
X-Forwarded-Encrypted: i=1; AKwUvBzITmAWdETFx+PIPnrNtywHWu8gCEjD//YVlBPE+Su9ZFZbRIP+88NlyQCYeFuewbs8VyH9Iic=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeVuyLNS138qRTo3Cykjxs+8aIawQ3jE6O3NVObj3AZuj3pRf6
	814MwuTSKlsQeZ6ajhcddLDYDKHA60uHly6+CWRkLESpDWQ8U+DuhP2L
X-Gm-Gg: AYBFou0f/D292xSRRRNPpoJyjjjgk8/0E7hk3F8O0DKe9MNhRWNNAplqAatFwZZr8bn
	v9jQ3f50nrT6/T0VWLCFsfed4PF9UaumZVjVgua50u4kiIxXBL70ZuPcJ2GSaf8frAKG0LNFLkE
	wWKZd48ITB/b0MrErhlP6zOl3nibqL5QXQPEx/Tr9kgMO8G+oE6I+dY9a8OoKioafU5xEKPrMkL
	zhaElQF5Wee7q51FHha1FlpMsu6+lI3p83rtpbXbmK2GC6wS/wlBqIIK40eP0se+EQqOaQ/lFUP
	4nlKYYxXwx3DpOXRmkglBRFis2XzW4/IZDMZc7lVMSs6JKZxqAktpn9vllapQ6uzZ5/QREe9ny2
	DKW7VJYkDSYWALq+waQvwybXXrlo54D5I4TFKa1cVsQPohbBIurekU0R1SIoTLdVI5u+mLj/GzT
	D0cN06/CR40+VxEnMvAFShPv9aAlqdixdhVlK7NFD7ANjWVjREHxUeTiQ6Pd+NDJlmGBjF5CoAp
	/OhxAf8mUv/i+p/ryNFA4chJ6/ulvejaI4+Qr+mnZzbG0F0127y+CQ2rKS6UrRK94pVDdlhSSgg
	0rUDWg==
X-Received: by 2002:a17:90b:5111:b0:3ac:a7ee:6785 with SMTP id 98e67ed59e1d1-3acee29305emr15938113a91.1.1792499452686;
        Tue, 20 Oct 2026 05:30:52 -0700 (PDT)
Received: from mi-ThinkCentre-M760t.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd65497e28esm4783715a12.7.2026.10.20.05.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:30:46 -0700 (PDT)
From: Wenwu Hou <hwenwur@gmail.com>
To: hannes@cmpxchg.org,
	yosry@kernel.org,
	nphamcs@gmail.com
Cc: chengming.zhou@linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Wenwu Hou <hwenwur@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm: zswap: set zswap_ever_enabled when enabling zswap at runtime
Date: Tue, 20 Oct 2026 20:29:42 +0800
Message-ID: <20261020122942.3477541-1-hwenwur@gmail.com>
X-Mailer: git-send-email 2.43.0
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

zswap can end up enabled without zswap_ever_enabled being set, which
leads to data corruption. With CONFIG_ZSWAP_DEFAULT_ON=n:

1. zswap_setup() fails to create the initial pool. Setup still counts
   as successful, but zswap_has_pool stays false.
2. The user writes a compressor name to
   /sys/module/zswap/parameters/compressor.
   zswap_compressor_param_set() creates a pool and sets
   zswap_has_pool = true, but never enables the zswap_ever_enabled
   static key.
3. The user runs "echo Y > /sys/module/zswap/parameters/enabled".
4. zswap_store() now stores pages in zswap, and swap_writeout() skips
   writing them to the swap device.
5. On swap-in, zswap_load() first checks zswap_never_enabled(). It
   returns true, so zswap_load() reports that the page is not in zswap.
   The page is then read from the swap device, which holds stale data.

Fix this by enabling zswap_ever_enabled in zswap_enabled_param_set()
before zswap_enabled becomes true.

Fixes: 2d4d2b1cfb85 ("mm: zswap: add zswap_never_enabled()")
Cc: stable@vger.kernel.org
Signed-off-by: Wenwu Hou <hwenwur@gmail.com>
---
 mm/zswap.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 37f34e406c8e3..d2b4c248baa67 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -629,12 +629,29 @@ static int zswap_enabled_param_set(const char *val,
 		if (zswap_setup())
 			break;
 		fallthrough;
-	case ZSWAP_INIT_SUCCEED:
-		if (!zswap_has_pool)
+	case ZSWAP_INIT_SUCCEED: {
+		bool enable;
+
+		if (!zswap_has_pool) {
 			pr_err("can't enable, no pool configured\n");
-		else
-			ret = param_set_bool(val, kp);
+			break;
+		}
+
+		/*
+		 * The initial pool may have been created later by the
+		 * compressor param rather than by zswap_setup(), in which
+		 * case zswap_ever_enabled is still off. Flip it before
+		 * zswap_enabled becomes visible to zswap_store(), otherwise
+		 * zswap_load() would skip stored entries and read stale data
+		 * from the backing swap device. param_set_bool() treats a
+		 * NULL value as true.
+		 */
+		if (!val || (!kstrtobool(val, &enable) && enable))
+			static_branch_enable(&zswap_ever_enabled);
+
+		ret = param_set_bool(val, kp);
 		break;
+	}
 	case ZSWAP_INIT_FAILED:
 		pr_err("can't enable, initialization failed\n");
 	}
-- 
2.43.0

