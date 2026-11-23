Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439452;
	b=aa/yZiiQisF5ydZKuAhmgOupU2hm50dztVUw4F/NCyXWj9//v63wf0ke7vrvbdtfclHS
	 ak/Bgyr9U2K3FEBoyJiaiTM66VEqlU8++bWhYxNfGH78pDpuj4u9bAqJeYc5oDTAgdfdm
	 YY3zu2ZL5KvfaqMjjZd9zTj/mCUxbZFcWEy+0Aka7E8h2qxNUvLfwwKiAR8B3GfMPnmLV
	 1rMvxJRM8gZU6h5TuUBE18Jf140xwqzVCk0QQQBOXHHJxGUL+qic4XyOaKku4vISGyBmE
	 xMDpkP0nz80irCDv7SAM4kRW294QnAZO1RAk+CVPsmyV91Gz6G7O7xBQhi4zCHey+uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jUp72NYV7Q0ADhk/tYOKR65YjvvA0NSY2G1zPBbXRx8=;
	b=3BG9YtAt4cNZeMmc5hlMiaRLJImJ2codHSU8VawYQ5cqvc3MMo+Yzg014n6IYubovFaV
	 g84r01b2r7bBPQjc2xyI9zVPNnd+KYB0Z/RkzXEqOo4ZjJpq7BumbR/BonXDbwqYkd71p
	 KRKqKMscTty+6kMZMh2ylE9GseVbxAv2DjcJoH0dpSfNvAsKfxKbITd6iaslVfmA1D0oQ
	 JW/gPCC3osb/a33M1ATq8xFisI5co8ycVkjJr8O3/MVV3sdSzBbUVkUPu9vNd42OuZJvZ
	 96qVIiYuY3kMCaICuTuNPw5aVDqOP+yOl+YIhZYDvWxxAa6LzP4PEw20+EyO7Aeqq4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tneHtAfD;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC7F606A68C
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAC7F606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tneHtAfD
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso25523245e9.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795439450; x=1796044250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jUp72NYV7Q0ADhk/tYOKR65YjvvA0NSY2G1zPBbXRx8=;
        b=tneHtAfDCBDR5o/j/eojOO0BbMdCpa/FhNiwqbUfae0KUYFL47VIs+tTHGqh3TGSav
         ci5XtM7JoabAeTa/h5zOXa6gT6ych1EcMkcA5BvbwkWEM9fyFfLCNqCvtr5ruGi0vHLh
         +90XBrHxJkVzON3xk/laL29zItoOqgwzxi3gs3+MidhymHXFYHjJS2KrfnwRRrpWIAnz
         8zsQSRZk5TazapCv5n6exeh66fTXL3p1ALkI9wib2eUhEGspV5tRmjkugW8FwVtU/jrc
         aygNj/fn6UChnQ+q8nth2PVyStoKzja+qBSfUhyDJtSAEsWD9cxMQ2DcSYvMa0VwLE/Z
         qSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795439450; x=1796044250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jUp72NYV7Q0ADhk/tYOKR65YjvvA0NSY2G1zPBbXRx8=;
        b=pAPEsYbvKjFpo6oN+Jqn0w0CDVI/mRY2aWkrCofoNifSJJuseFRjDDM1iHGaDIqNTi
         D00FyR+z4zkCYuKjqKREwB8xk5dstrlMi9a5/ta69qDlEJU6IvPE3BEJ7h5T1TEgfGFI
         I/Zd0WrCXHlA1C0nvIDD0Du1w3Ki02DGouvtbfUHnV3vmLHo4XYWLVDCqLH+vcEKPztJ
         u0gwqmsVQdL+k1pcgbz57PTJYbbC3Kvcq9mBrXrCOXEb94khD61IOl9fYStpZ019/pXF
         Kd69aKsNeQE6rxeInoBNND0zb1AalxHydRLRSJzOjUe6Jf8GQ+3p14KUwOIsrehW8rVY
         Sgrw==
X-Forwarded-Encrypted: i=1; AL+hErEHyUWB/LH59EzO2DvyTSbYurb2bq2+amTAeQpdbOazF0miDcOFlTghgzNO8xWIMc1vq9qKaJU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oNaK1iHi+IZgbVo2C1fXnuz6kUhz0zS2fWNgb/9wLFTui4vje
	kTa2oJgvs+JKTz2n4bMG7tB55gQhRNHb0brIGGrUZV4ggqrLAtJiyDHO
X-Gm-Gg: AZFdTZfGQ2GDY797r9GGpAsSTvQGoDkfBTHNWLicztNeR4Y0gVbrTTxnHI/UK3IWkcN
	3ZJXKSJBHcK3XQJnRVYzoOQrtJ1HX75dipArMEMMVLkk3YuVfZm9fUgImScMr2wvxEQbAuo71eH
	AWmTmnAwBJyIhRC7BdOGuKaTizBxFv2RuVnWYFa8QmK13x1N+5bgCpofNPvNVqs+tYNmzhTKBgn
	zsd8w1qOVfhdmGCu7aoenW68V2m1UcN/GIjBKSiLsx+qWziZ7q9VEEdU7HKdQjsov+YifyE5NOd
	g3ezFsqnOvaM+x/lvMYMQdBqh/8dhu4aHcCMEbiay7aoPC75kXtxlULi+y3vDKoETRRGKFBydYg
	ZXn/4QNiYRKzY/x/hHRiUKwZNLXUJ0vNAjDDyFIy55EHOcPo4TI1RwFfQt6AKFX9wDLrSYBThjD
	fDDtzjUkY0nZ6rpixd+Ahqx3waY1yVcidwFklDfo4xEQbt3UnfPQQKq6w6s5+suR7qwXwyuZI2u
	FPfWP7+qRqXCO61oTSEqtELGPoT8fD28NsLdw5EBFIUObD+23ugcX6xl0457I4uxlyHdUHNQe0m
	4A6Hv4lo6UdCbR6jFpoeKrVSgpze8ti8CrMGGmkFQ/NiSqmtLxKyhjgEFQsPbNj7MDvG3I0ojuL
	kM/G/6V99jMxvxc3PCD4nbJfwR8yvRuEPT02U/ml2FOkjl3QAHyjk8R/oSuRlUNVZhJX2fAo57A
	==
X-Received: by 2002:a05:600c:820d:b0:4bb:5de1:e912 with SMTP id 5b1f17b1804b1-4bb887c3ae7mr224591505e9.1.1795439450439;
        Mon, 23 Nov 2026 05:10:50 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:f273:2c28:9387:7d5c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399e2esm400714065e9.7.2026.11.23.05.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:10:50 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Ralph Siemsen <ralph.siemsen@linaro.org>,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH net v6 2/4] net: dsa: rzn1-a5psw: Fix VLANTransmitted counter offset
Date: Mon, 23 Nov 2026 13:08:50 +0000
Message-ID: <20261123130852.3420491-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123130852.3420491-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261123130852.3420491-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The RZ/N1 hardware manual places the VLANTransmittedOK counter at
offset 0x8f4, not 0x8ec. Correct the register offset so the driver
reads the counter from the right location.

Fixes: c7243fd4a62f ("net: dsa: rzn1-a5psw: add statistics support")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v6:
  - No changes from v5
v5: https://lore.kernel.org/all/20261120002549.1908299-10-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 drivers/net/dsa/rzn1_a5psw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.h b/drivers/net/dsa/rzn1_a5psw.h
index d54acedac194..9693f8503b0b 100644
--- a/drivers/net/dsa/rzn1_a5psw.h
+++ b/drivers/net/dsa/rzn1_a5psw.h
@@ -185,7 +185,7 @@
 #define A5PSW_etherStatsFragments		0x8E0
 
 #define A5PSW_VLANReceived			0x8E8
-#define A5PSW_VLANTransmitted			0x8EC
+#define A5PSW_VLANTransmitted			0x8F4
 
 #define A5PSW_aDeferred				0x910
 #define A5PSW_aMultipleCollisions		0x914
-- 
2.56.1

