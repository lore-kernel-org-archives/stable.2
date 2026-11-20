Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795134365;
	b=m1RrYZDTxAEBIZXdw4Eq+WipKPTEZAG3kjLumcnMI50XMQ+kVr5jMzBosntxTCN+ymxK
	 oWtjV0006FS/iSQc2igUsHnKWgdiKlza9Uvuto3XStV4qWUQyV+OsoDk/JPomgjMckn9z
	 0LLsRzO+8ALnkgezCFW/zYATYfAimt/7wpph4+YARESPquKlJhO+CQn87l/6FL0i+uavN
	 IbcaOcBZ0FG5udDDAR/MaG+Ur3wOhmVaXF3gRD0fKQ5XKWdkXFCcBFMNpleSS2h4+K9j4
	 kpQucMINb6ouVHJlwPRJ2maVxwZL1ptdW7KuKvyFcu+CS4yQ3C5M5PMT6jowmXQooWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795134365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mPt8ckgxbndwPDdtomIJwXpg4ESCKJ7Dvn/Ga7ANGV4=;
	b=B/JdoJTs8UWFDV0+u95oNkGwp5f07k52s58A1t8k2cElz+OzqPjRoWNo80PWG9alZRNN
	 hP8wMaI/NEoFdgx37GxE8AUoIFWfvELBas8qk32vlTXuJaOjlKi+XbWcXV/dglfa/ohkD
	 a33bV9+uFYJmsN3tesy1smimQ++uBNRsAOKfYxAv4iY7z4tEhIPo4lrRL65tHI0KBPw82
	 OzrcE82bIvbfjUrSRaz+ZbSSR6JgU3mBm9Cp/7QfseT59YFTRebmlZ5/UTfL+ET0coI0l
	 XAijJJ8ye6N0DFRvb9hAsBeRavqMgI+szV/DrPeNbq3+4r8pCL4hAOs4k8WmnmYWu6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kvRmUPCV;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA4B60A3831
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BA4B60A3831
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kvRmUPCV
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so3148335e9.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795134364; x=1795739164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mPt8ckgxbndwPDdtomIJwXpg4ESCKJ7Dvn/Ga7ANGV4=;
        b=kvRmUPCVFdVm9Tvu0USFo59ybVuNY+lv/i/sbUinEHjjSz1u1oTC6qMNXiMNCd9z3X
         RsOZkXuiy3FFIHSSKoBPOY8IZuMSl0+tBrtyTxfJxC59ZHgy7RtCosCY5mP21342VOfb
         oVdxG82rBoRF/tpBq+mqaaqYUXgvGs9ZvSC+u6M7IEVel7kf94mhPdu5TS8WyKTc28bq
         QvfPdfTJAyOBjQhlsoSztQ/HIp2YMUCtt32uIw4U6ZaL76wRNBPgtXohSwXj00E+w5ew
         Y1SaCK55hGUTNGaon0Da9mR0I/64EwzQf75PqOFz2xdv0/7DhusBGU9vfAoIARLFoHJf
         Wq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795134364; x=1795739164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mPt8ckgxbndwPDdtomIJwXpg4ESCKJ7Dvn/Ga7ANGV4=;
        b=2bgISiX4vbQS0jgT1snQWxxtpS+aOfhJpV5s1RFSshb8KFz0kw2GwAsIC5v/YhucWK
         61zSnKv4F78FTVR+EzCmIN/krgyWHIDp8tlqCsHO1xXYs1fOIzBt79I7LUXnrh0yqm4m
         RCx5GOP7SBbzJzo9031Mxe4OKdwXMXYrYKqJQ5qMDNmAt8jr/wCOBev9W3BcRtqnQ/4e
         xjG/sLzIkC49G1K6oG6Tn6T93sLSuBwz3B9Nno5GAiFt4pyde2iGohjWPuiZhTaBZXdy
         NuCD3wwRYyFkVsF5AK8XVBZgwjbQYQaKkA0RbCcKkyaxCMGQBNsyCADSwfloo5dt11Yz
         KSxQ==
X-Forwarded-Encrypted: i=1; AL+hErErasDiPffBwQ8CFob+WjmmbsrD0RDtXkiAhjPJXrgg0uCQTr6XKNB/GD8FIfPnOTGKncpJ0AE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CrCaUoHoFoWMK+IomnW09Yzh2bY3/9/9pmwDuK1nClgqdxsSc
	XvFKjQcJKQWtCcMKqbChPi6S++tprBMkAx+hofLa4EILEnvWXhEuxcEo
X-Gm-Gg: AZFdTZfm1OKrJpe5ElUtC7J/igfyF11iQYMI6FyPdt6NprAUuG3i5hFObliNA4mFtYr
	zoIJI2yyh6OMhLTH0WW4NaQKk3AZ2S2hhqVES4hXssLs7uOsavtXo8SXOgZptadWDx8JFYMaivH
	ohPwatgQEju3Nj8NI3NhgTR1U5U5tw0+Oq9KLDCqGqFj9AWFweXFWaOr3Y8P4TQ7NbkNo7DLLzt
	NwoTrqEMMTB2Ekfl405TLKqsZhzMGdhstBf8ExbrljC3NlpE/0d42ztq71RkMcKDk62eEvv0b3n
	mu5QakYNZ414dQUfToYapdJAR2/zj80WmOX1hv08vTnEoXzk+bsj3YKVzFP7daSaUOmAYj5W53o
	u3i4oZbSwtOcQ1pGcfEuMF691tdqFNpzNHjzROVOo5/tDumFWJh5mdnXbQAgmR2LEN+PfkF5EAs
	GNzOE1dB82dZlE8DuUNINlgpQUPqhfR/IbrvNt3CxXVtQlSmSYAto/hZWSWQsXTtzNdBLoBQe1Y
	5ZZkiRbT2XKRwHEjrWWOxLB+U3vwVmjmTzUNvjKhGmoxzhqX6OjIpIHKS0I5MhHpytcDiyf2+cR
	ojyFfqb5mhET2cl7TLr3NfVKAh6vEtCaseoWb5QA3XjM5mBV1h4pAthsvjfruYlonjl2HVB+Heq
	IQ5bn4gPuEEewFx5aYOjOjZZYSsa+dfgOJ4sZMGo8OZBFbl12pj/zDyBZ55q6X5S7675pegYW
X-Received: by 2002:a05:6000:4a15:b0:49f:eb4b:faa3 with SMTP id ffacd0b85a97d-4abb2168f46mr1969744f8f.9.1795134363733;
        Thu, 19 Nov 2026 16:26:03 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:c5c5:590b:f4b8:3e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c340df4sm2629998f8f.55.2026.11.19.16.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 16:26:03 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Ralph Siemsen <ralph.siemsen@linaro.org>,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH net-next v5 10/24] net: dsa: rzn1-a5psw: Fix MDIO clock divider calculation
Date: Fri, 20 Nov 2026 00:25:20 +0000
Message-ID: <20261120002549.1908299-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120002549.1908299-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261120002549.1908299-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

The MDC frequency is hclk / (2 * CLKDIV + 1) on RZ/N1 as well as
RZ/T2H and RZ/N2H. The existing calculation uses the wrong divisor
formula and can set MDC above the requested clock-frequency.

Calculate the smallest CLKDIV that keeps MDC at or below the requested
frequency.

Fixes: 888cdb892b61 ("net: dsa: rzn1-a5psw: add Renesas RZ/N1 advanced 5 port switch driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v4->v5:
- New patch
---
 drivers/net/dsa/rzn1_a5psw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index 7fd2652813ac..df3b3f75b489 100644
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
@@ -1104,7 +1105,7 @@ static int a5psw_mdio_config(struct a5psw *a5psw, u32 mdio_freq)
 	u32 cfgstatus;
 
 	rate = clk_get_rate(a5psw->hclk);
-	div = ((rate / mdio_freq) / 2);
+	div = DIV_ROUND_UP(DIV_ROUND_UP(rate, mdio_freq) - 1, 2);
 	if (div > FIELD_MAX(A5PSW_MDIO_CFG_STATUS_CLKDIV) ||
 	    div < A5PSW_MDIO_CLK_DIV_MIN) {
 		dev_err(a5psw->dev, "MDIO clock div %ld out of range\n", div);
-- 
2.56.1

