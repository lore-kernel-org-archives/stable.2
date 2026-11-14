Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794650774;
	b=agOA1+Nqv5VHXiGGtRXA9gfXSucyGAkW7A58TisnTfB2tuBqKvjoBxaFz5idA9OUb2xY
	 eNof9xBfvyUs3Dmz2iWAtXS/8mZJyYWpWF1oaTs/kulOdnpunJX6jAcnHBkCFFedJW3dX
	 oJPlOPBSnbSZpgvBYwAzsUW4Ik93m7YfFKTTlbYLdUaTomleXfT38q+kHIxxKQNIsmMc1
	 fFJ5eY6TWvKRVQOPRbacZXu/qkkUhpoXXK8olFWaRwa+xoqlEna2+me61CT7oLmfGN0/V
	 o6robyo9mDU5r42DOywkO7GvNbXdqtK7CEnz22tC5RDxdI96f/X5AzkXy7nwF/nGPxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794650774;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Pl2hOz6BzMGr9Dpq8GYJiAgRRx0ylFIRGI3z7sZaMZs=;
	b=ktttlSJs3U00eknDXPrgKn1otMCRjSLYDdvD+1B78iwwJT0z3TXEwy0Zc46pvCjQW7kz
	 1XFRMJsf5xTOKzVGWlMC4PlXLQEboIDWnywGAVj2arIOJUbmsQ8V/wYifrgfhvSDBOpGV
	 MWSjNu+M4eZv/v6wlV829SEi8ZX6fUlWrXA2+cnDNmzlm6DjPtf9vMWXCcB7YSMWheWIc
	 2nRi4AYKgVZanfVKuGs+5wXUoy0BS0Hh5k5EAhkJX0CELYCxF/jie3A72jERtXTjcWCQ4
	 eluYqNvhU0PJoOcImoaRa1ntcME4bmVzkNGQJdExbQJdnlCOqAgtrPPoawInGMCowKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=yqSHP3Np;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7FA9E606A334;
	Sat, 14 Nov 2026 10:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FA9E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=yqSHP3Np
Received: from kero.packetmixer.de (unknown [IPv6:2a02:3037:6ed:dd6c:838:344b:3152:2d5e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 578D7FA0B2;
	Sat, 14 Nov 2026 11:06:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794650771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pl2hOz6BzMGr9Dpq8GYJiAgRRx0ylFIRGI3z7sZaMZs=;
	b=yqSHP3NpQXlqj10CQ0FopwiVDN+5CY7Z2xafQRDZxF7Bc2dqQgAeBw3kNge0fSqpj4999J
	LsDUAP1nNvjpm0hLtB2c6Y1A7oI0+n6zQQGioVZ1KG0/Gr6C386KhtyxTchsVgWrAaXYzx
	t/u4OA8WDnEinmAlc4bg4X21/UiyisXRXVF6J9QDYtFJyRHTtI2QmT+0ac1AX2V+T1EnZ3
	vwc8AePElrLdBNcJ7DWuRzhHyeDXeQAKhEzgy+TOnYbPc0W/y1v78TWNjcoHvGaH1HVvHL
	bg4e0PGEB9HAcTVIZYVL1c//TNgoKPGvnaqrBwbPDeN3W9DljUkHU7NoRNoS2Q==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	John Crispin <john@phrozen.org>,
	Sebastien Decourriere <sebtx452@gmail.com>,
	Yangtao Li <frank.li@vivo.com>,
	linux-kernel@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] mtd: maps: lantiq-flash: fix NULL pointer dereference on probe
Date: Sat, 14 Nov 2026 11:06:03 +0100
Message-ID: <20261114100608.3432120-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114100608.3432120-1-sw@simonwunderlich.de>
References: <20261114100608.3432120-1-sw@simonwunderlich.de>
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

Since commit 6145e07e9c77 ("mtd: lantiq-flash: Use
devm_platform_get_and_ioremap_resource()"), ltq_mtd_probe() stores the
ioremapped address in ltq_mtd->map->virt before ltq_mtd->map is
allocated. ltq_mtd comes from devm_kzalloc(), so map is still NULL at
that point and the probe dereferences a NULL pointer on every board
with a "lantiq,nor" node.

Allocate the map before mapping the resource.

Found by code inspection while porting a lantiq-flash change from
OpenWrt, which replaces this probe function downstream.

Fixes: 6145e07e9c77 ("mtd: lantiq-flash: Use devm_platform_get_and_ioremap_resource()")
Cc: stable@vger.kernel.org
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 drivers/mtd/maps/lantiq-flash.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/maps/lantiq-flash.c b/drivers/mtd/maps/lantiq-flash.c
index 80d467eba92a..5c2ace302b50 100644
--- a/drivers/mtd/maps/lantiq-flash.c
+++ b/drivers/mtd/maps/lantiq-flash.c
@@ -118,15 +118,15 @@ ltq_mtd_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ltq_mtd);
 
-	ltq_mtd->map->virt = devm_platform_get_and_ioremap_resource(pdev, 0, &ltq_mtd->res);
-	if (IS_ERR(ltq_mtd->map->virt))
-		return PTR_ERR(ltq_mtd->map->virt);
-
 	ltq_mtd->map = devm_kzalloc(&pdev->dev, sizeof(struct map_info),
 				    GFP_KERNEL);
 	if (!ltq_mtd->map)
 		return -ENOMEM;
 
+	ltq_mtd->map->virt = devm_platform_get_and_ioremap_resource(pdev, 0, &ltq_mtd->res);
+	if (IS_ERR(ltq_mtd->map->virt))
+		return PTR_ERR(ltq_mtd->map->virt);
+
 	ltq_mtd->map->phys = ltq_mtd->res->start;
 	ltq_mtd->map->size = resource_size(ltq_mtd->res);
 
-- 
2.47.3

