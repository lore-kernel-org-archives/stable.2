Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439453;
	b=EmH0AvzBScl9xrxvc2nTXFo9Q3zVh5L5ofB7hgL//MPh9GYgD3E0x0GnxNhX0GlArMsf
	 g71+hbDZsDJPTfsiBkmVXr4Iwl3Lb1Cmlh75n5fxj4sJThSP5ANAtdlnuM97f/nN8UfSY
	 Dq5CHJMoGFTQRHiYEN+QjzgMU0/fPlpV1Jrr6vKt7KBilKTpaRI1JJ82NA2mqNGy7pM2N
	 0ql1Xg+ngo+z1wji6HfPXtY4n+6gQM0FmtGMkCdG3DYIvAZpryhlTLMsdQbrW60f1hL5K
	 xtfty63h4F80MTyqTjKjKRFJi7/DlT5KIIjON0UbZZM42nmkQ8HmU5fjjIAcytKKUiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EwieZqtgauufTvTK5llynH/xO/39KPDUAQ86grulatw=;
	b=Xai0pVytytuTkPj5GDGrnqXpGkjsBvPWeT6HHlz75woDs3znwxgbOETQ8R1jFdY/9a4d
	 T1fs7+hNs8lwF4C5A8h++YQPrLBckpqeuH7Hs/K/9dnO2WTZ6cQTiMVt8qCviBW5o+3+N
	 y583TYOWFeR+hoWPQpDIHvygCsbdn9j+3AOu+9GH+NgpshT8SQi2lNGaxMZpImkHBwHq2
	 zDiNNhFKbaTqVPEzaBAVMUr4SEUKapvYKEj4V+242p0MeoEWM17bK8j5tzCISXLGs+U+U
	 wKkTdy/N9jbrheg+z8wV80WfgezVAndClLga0i3O9m8e3SCBFu2+k2/fAYY23sz+30Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RKQ3jHRE;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE5B606A69A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEE5B606A69A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RKQ3jHRE
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so27159625e9.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795439451; x=1796044251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EwieZqtgauufTvTK5llynH/xO/39KPDUAQ86grulatw=;
        b=RKQ3jHREKKn3ZJjIHrgF7TjaMwmiNKzcTWiVLRPjq3pLIGwkGf6KtWB6by698I94jQ
         XCsMnQjUe1LaaTUfbs8ozGg5OaoeG9ugFN6f5/8AvWqixSem3Fa1Q6ocP2FMUO4o2/sI
         Okju4V8yF2HkARROWjNxTgZmDoe4lBm5qU9rSRX1XHxJsbQZPJ/aNPfADmUDJ+ICo5QK
         Zs249JKgCGlN2r3ka1THqd0kZykkJdfOktSblnB2dSskiIH0kBVRVEzIwL8N7CyBFVYz
         BPP76bo9aKT4Y0fmz3dWvxiNaG+a/J8+oplyiCljZIbzurVOlGTTsGbG09b2ZY213O8c
         J69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795439451; x=1796044251;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EwieZqtgauufTvTK5llynH/xO/39KPDUAQ86grulatw=;
        b=tHWn7dZTHqKpxd0xHoED0BcUqRQktghS3X49BEGP/poGSmM+jxjHAeVxtA77CT1+un
         z+cMKV1jVofkZC4X4qdlSEJXYys6R4UC5J91vWSz8brTWcr96v2bZIi4LyNCyE8MejcF
         Gc1vNGY43dL5EcwomxRg8hwCJ0ZvHr5r6eO3w9+JRizY2eVaArhNtqV+tcU5RVr0nagP
         hiAlE9N1TKd0U4PhXklJsAwqrVQb+v/NJGwZZacrzv5uFjHIFduKsRsAXMeLh8T+8HfS
         EN9MWQiXxwoWQ8i0BhQ7RyfrEh63QLPslGLzPb53qH1KuISSIUQGzn4zytgJMNlsCxyp
         ObLQ==
X-Forwarded-Encrypted: i=1; AL+hErHMRCGKfEghh4f40CFjFCxAA3CuoUsXGCwpeHIs5CKawJXenBVPRt7qFGpgZFjERdQfElWfuTE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HdhSTR3n9NyJ6uoh9eeLgxXAht/WA6BtZ9O7F5yjS1dKC4Og3
	PeDy+qbS3W9ywWGcC9gD2RWXkeiG+Mqzws69Zmg5J+WaCBo2O/1rap8z
X-Gm-Gg: AZFdTZc5tcwr+0dGmKvdWRB+7eokusZiuEhzv4NmFkHZEC+J2uUX9O0CLLE/05TbmN1
	fsLPXClIUxl1FD3f/Dq4TcKWOYqhXGE/fJKLD66wZgpmYc1Ed0ni6QeKca/pKsf+CkJ5Ut7hOar
	DAgKq67zSjeGNfpgNG+gQ4jIVGMVtbVVhOcn6x09D0MGvMTDxvpDnQgYAFeJsC+IgQkCjOhzVJR
	Esm894MGZABgHi4Zfu0301wFLanFngQz+E6K+CelOUdcKUjkLqX/PMJDnrvUGFzXOPiVOzPntje
	cdk1IFp87BzrQ6p1lZaHzoqY+afCkk+nnsCg5iQughpYEtDx3DAgixQG2zXXrZOIoii4WMc/xf2
	uwNHUsnCZvepv/Z3REKv6oZJnMbFggTEY5dHr/5zGQlrIXTe3BCOPEuWGIfCodoOSsifZo6YTIF
	1eET7glOOi6i0LpUF2WmvKwsZdMYyzEanWejW4jbzkjeaSLFYvsux6OAYkW+vWZatwwmnmnHs3E
	juG4qEtYeuZjfkmEmk3U7AwCE2zhPcNSL2Ydc5j/LfacF9ubznNeaTdft+LrW+Aeiul8qNby4wR
	QaapdPrXcGe9P8mP7a0g6oU0hwVr9OQ5NlMYDLJXjDOQV/1nLAXL6AiuccBftUXWaTeUZUPs+OE
	yH4lmty1y7bYK/yhGnZ45fx4PoVJAweATc3plcg/A8iLQzmvCc/u4Ru1HEVWOuaUaBGwtQiPEwZ
	Mdp8TedqzgSNh2zQhh8/M=
X-Received: by 2002:a05:600d:18:b0:4bb:9001:1aa with SMTP id 5b1f17b1804b1-4bb900102b8mr139194055e9.10.1795439451189;
        Mon, 23 Nov 2026 05:10:51 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:f273:2c28:9387:7d5c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399e2esm400714065e9.7.2026.11.23.05.10.50
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
Subject: [PATCH net v6 3/4] net: dsa: rzn1-a5psw: Fix MDIO clock divider calculation
Date: Mon, 23 Nov 2026 13:08:51 +0000
Message-ID: <20261123130852.3420491-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The MDC frequency is hclk / (2 * CLKDIV + 1) on RZ/N1 as well as
RZ/T2H and RZ/N2H. The existing calculation uses the wrong divisor
formula and can set MDC above the requested clock-frequency.

Calculate the smallest CLKDIV that keeps MDC at or below the requested
frequency.

Fixes: 888cdb892b61 ("net: dsa: rzn1-a5psw: add Renesas RZ/N1 advanced 5 port switch driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Clément Léger <clement.leger@linux.dev>
---
v6:
  - Added reviewed-by tag
v5: https://lore.kernel.org/all/20261120002549.1908299-11-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 drivers/net/dsa/rzn1_a5psw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index 4c32e06a3cd2..7fc62956c5d0 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -11,6 +11,7 @@
 #include <linux/if_bridge.h>
 #include <linux/if_ether.h>
 #include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_mdio.h>
@@ -1102,7 +1103,7 @@ static int a5psw_mdio_config(struct a5psw *a5psw, u32 mdio_freq)
 	u32 cfgstatus;
 
 	rate = clk_get_rate(a5psw->hclk);
-	div = ((rate / mdio_freq) / 2);
+	div = DIV_ROUND_UP(DIV_ROUND_UP(rate, mdio_freq) - 1, 2);
 	if (div > FIELD_MAX(A5PSW_MDIO_CFG_STATUS_CLKDIV) ||
 	    div < A5PSW_MDIO_CLK_DIV_MIN) {
 		dev_err(a5psw->dev, "MDIO clock div %ld out of range\n", div);
-- 
2.56.1

