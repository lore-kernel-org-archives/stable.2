Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795134366;
	b=11V9WTyBJ2LWijnLlk9K1K4Z2bdpRpWZ6iJPfoxtYYEb3hOzUquMnWiaxImTjwwr/5YI
	 Rij4N/RO4YPsODlxYx2zetbXKkVEdFARcPQ8GN3O22HXo5LDpoMhizDQbS3n9baPeoXvm
	 Ej2IL2UvUl7yOXdm2zf1d06GYHv1+sN+nN/xxYdqSmWNVITnTNqBGDVezqai0GDJc3GLD
	 ZxVWGZQhC5ZU/CUu91D+wRyJkarWc2xKs3E9Prak/UmUlEsRCdBkREFSKxx0CEFE42D1J
	 mUZ0eU5z+CbBwop6uLrTXL/HRQ/3qc31r+2TBkWELBjKTcIXmkjfVLzo2nBr7YyOKAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795134366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=36Z92l+HC6VUB7pZKBuw1nWmeeV/t96RMwh5xwHqbkM=;
	b=XG3vNWjbdD6heHPMfwhlr/3qJoBcqny0SMDvg0VWxt3W2mwjK4NEWarcMCbClSbzrsdL
	 V7E4+nFHdGLQuFcAkF6wVZSDwOEzO9edMHFGCcQrfqPUqwx6aS2RaOb/6NXwt0iBsZrOB
	 do/nmZ5Ww6OmoZDTZXQ8Gzgr+LBGxrLo718KOHuqsZrsLy817LhHI6F4JgMsNDcpIvIOG
	 R90blaDBEQfMoCn+mkCbtmLDDRYW5WdhAZXmLVMbH+/uqnt508GA4U+H3ZG6NoADRit9K
	 4qg4nfkwKc5LeyDhauhh2dRqE8W9mI13tUvWGWUIK8pp7WE5oaH5bZKJwP/4Cwg/XUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="WEJr/Xcc";
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78660A5BC1
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E78660A5BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WEJr/Xcc
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso124257f8f.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795134365; x=1795739165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=36Z92l+HC6VUB7pZKBuw1nWmeeV/t96RMwh5xwHqbkM=;
        b=WEJr/XccmnAH4kdeHeZMrPWCd8ssbOQXMdvRUebc2cy558660ef1r2TSVgqeZ9HFVG
         zmfah62UoIvIb0aoGHg3YuxpGi3toodjBdwRazY2yCQfPJFcP0dpGMVurL4RXHBxzdBT
         FPWTO7Db6N2Q9fjFIRuumapN6TYi+OTlcR12gTbRKQ4KvgpvjtEtsNrnFqLF79jeaXrc
         XnHtwfu+eQe3PzUvgArXx78AM9KNkOucnwFyh5I58YMZnmNvmol7HOxQ9jgR+1XIY621
         460IFhRDH/SkdmoEQ0y015RGcWjLyfXukK5GieW4U0VDNGH/s9snuaBJz5CLqDo381PY
         TqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795134365; x=1795739165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=36Z92l+HC6VUB7pZKBuw1nWmeeV/t96RMwh5xwHqbkM=;
        b=Iv8nxtlAM0Lu0IGO/QPGrByD58aU3gMWB1gVV3Ep85PITGrCdizMeBsaWLS3fhtEgj
         AwAQO1kwmU8U5xXHlm3EQjjGL2XUOpdMC+2Iit245x6lyZJLOlSuCMZwHO80kdLL34Dw
         cBWJrdm+YUGgeU1+u1WI/+UokSXNHZzrBguFNvWMuXxaDplBiya5xMM/tgB7jaJyPxTT
         QQ3k+5ytxcsfJ/JkHjORvaNzv/mIyinFI4LkyuhAW8zKfG/1RUlQAXEKnI4MUFdCFYeK
         OfWWEj2zbcbITMdyJH8oxH6UEnPAzw8z8+uCSU9sLv50z71uVsmaqBdbEyA3AvynjKit
         XBnA==
X-Forwarded-Encrypted: i=1; AL+hErHy1Y9pRscMzcAhNNonjwFANSIaCYDZsI5I75LtM5efVODd8Fadah+ySjCo4wpgmpO/qMn+qNA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8R6OWdCGK+bAg80xDG22bmkrj3b+6lLl9aqObEEu0kixd6zwIt
	u130nNCMb5DcayaiXqCDbdOKuj4sOvIv9F01cdrvm7uMoai/yB0lYIWf
X-Gm-Gg: AZFdTZce7YtREQuGHtWYS7pmQq2VJyNoe+pGeVfKVo1nnZwxyK/1wIodSDRap5zKsWl
	GGYVFYyFcYkpIaEKvngygDoTbGIh+JgIC/GN7YoHrUPsWiEaMP6ig/oTVGDK0ujxwnkqiwDzd0L
	6xWg1y7/kQktcqkaTIr61SDXOMK3ZK0Aubw38ZQdWtbDvG3WgVfdXso1zgSm0kfREeiupfWFlHm
	dLh3V2O7q+s4a6jkB0IvjkNBA8xWrYYrtR+2X05lhivi0BMdyoOmEHD8uHU0oL3UWMFhJAULMcU
	2dIC/TUzi3vw4TPyU2tTHnURvnz0KmJL9u4DsEQeX551n6euBzksUNiDkHl3EJ9WQv9XApwv6Gz
	sW9NWgoFGVHcJjBW8DQNF03NWmPwLKihn9v4FUpcnGWtCKJxK7vPkIz0CFJsy/X9sI4ME71BNyG
	5w90y+tQBRCyz473prtbVN2wxFY2/zHow65OnKsnRzO39zw2YfspIbvsGq6ljqVY6856ll5uoen
	IRBRMN2J9Lhv/Cs3DyZe4wifc6FQks9/ITZeGH0z3SAY8whcokFhRYS1oK2FtW19CqVNN18XUIq
	qSWuW0oUmgm6b9L9BW44RsgvbhoBlxuIM24JwsqxTzbeAXB8vFgfzOPB4u8XyMfQfPeyuT9V9vd
	Gob5bwY4FasBkG0JG+xZ2QNVCOXnCn+qrIkMjAUA/o/eeEiIXsXuVYpBcqJy31frkmPIjmWnbIQ
	==
X-Received: by 2002:a05:6000:29ce:b0:4a7:1fca:e52d with SMTP id ffacd0b85a97d-4abb0e46a88mr1474050f8f.9.1795134364578;
        Thu, 19 Nov 2026 16:26:04 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:c5c5:590b:f4b8:3e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c340df4sm2629998f8f.55.2026.11.19.16.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 16:26:04 -0800 (PST)
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
Subject: [PATCH net-next v5 11/24] net: dsa: rzn1-a5psw: Set driver data in probe
Date: Fri, 20 Nov 2026 00:25:21 +0000
Message-ID: <20261120002549.1908299-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

a5psw_remove() and a5psw_shutdown() retrieve the driver private data
using platform_get_drvdata(), but a5psw_probe() never sets it.
Consequently, both callbacks return early without unregistering or
shutting down the DSA switch.

Set the driver data in probe to ensure the remove and shutdown
callbacks can access the private data and perform the required DSA
cleanup.

Fixes: 888cdb892b61 ("net: dsa: rzn1-a5psw: add Renesas RZ/N1 advanced 5 port switch driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v4->v5:
- New patch
---
 drivers/net/dsa/rzn1_a5psw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index df3b3f75b489..0e4bbf34ec27 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -1221,6 +1221,7 @@ static int a5psw_probe(struct platform_device *pdev)
 	if (!a5psw)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, a5psw);
 	a5psw->dev = dev;
 	mutex_init(&a5psw->lk_lock);
 	spin_lock_init(&a5psw->reg_lock);
-- 
2.56.1

