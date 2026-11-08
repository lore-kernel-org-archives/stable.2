Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794104418;
	b=rljpn4DPP3F9Z7ArAf8dfLF3loRXjFINMyBI0aNNE1uD/x80EjR8a1burXXvo+s2S45i
	 HCAtTiHM8OUYEMqlBFWvKB079+Ra3wB6HvtNITL1OF1E3E3QNA+Gb0T1lmkH7shC727Xf
	 t9vfvUjRCMqGd4ff8Dx8fb19FdryQAxv3uXXv2WDRhP5huAFpaOuE3HBr3w/SCQCOXTXB
	 4kox7mP4JFrm9UfYGr6M0LHlAXlYKTR09nJqH5BYajyBzv5XjboBv/5RRO9/Ci0h3jiW7
	 xhokeifOPv+6T6jPo6YiXC976iN52QXlA8wHwBik3CnV8EpL55krvCagy4o8NziUe/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794104418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qOV57dKgZ6M1Pug8TSXqnl7cmjzsOLs4V2weSI1QSbo=;
	b=G3unJH0fn+yhpxfR6EHuPSYQ97Jl5q8o75uqzoKGlIoxlVg4uWGw+WBlFTH2e2SOg30H
	 v9mivPv+uDnwzxuAQCXqZWTV0mg9YhlDoXltWtoINnguiqPDEh7nTcBRluSHv8fmkNfmn
	 zmHFigc+OncGDWbsr8A3WHOAdxbqMZWq2mzcEPdHQLFE8pXmB9wGAvSFC099d7ktTZZhf
	 rFBljRDqPpiu5zgi+bJ5aXysKYOfWQlCUa/xZwZJfzEI5fypt/Fdr2qqU+Omg54y5iwfP
	 FWWypnk+FyFKWNr16qssrxnBW6VCoCmGtEApox77kApIQ58gnM9OcSV3Gmh4c3vajVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b="fQbUDeX/";
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B76606A31A
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 02:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17B76606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=fQbUDeX/
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-170135e43c7so143955c88.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 18:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1794104417; x=1794709217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qOV57dKgZ6M1Pug8TSXqnl7cmjzsOLs4V2weSI1QSbo=;
        b=fQbUDeX/JuDye0jmaIkRNGPXXZTibA47MzP419dOjYHSaPpsakocteM2fJXrFjXJWS
         lwL9RntFbY+ZAzU2gt7RJAhZo14IJEniKVVNuH1qad7BbMpTLbDtc/YolP1DP6ZwhbyE
         9xyXSyXRPLvxEFCfIu5yvYLfgR3CXoWm2dcduMgxNfuL6qilt3XwhfR6XCUhutOQM5MG
         6OzVrnSFt5qBGavr7NcYCMhjMC21AhJfe2vHepxmprq4ptvsnRu/JvsILBgfX+pH83nh
         Z7D5xzQak1TLsxvnMfU30MD98GLEnBfYzvxpSwA5HpUkuai6QJFxu1K0HMqthKRM5xPq
         9nRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794104417; x=1794709217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qOV57dKgZ6M1Pug8TSXqnl7cmjzsOLs4V2weSI1QSbo=;
        b=rhb0xhh13crFwMvknq/3VitNHr6CPH99TooUw6/l8RaMsk/m3lfToIPHx5nuddrGjt
         GOR/Ah5ZvBvADWYc/Fj2oPskmpbfLwENDhjgAvsdDPHkP6ndZu1F0iy27JTWb2kxtiiO
         PFSsM8ocJ6o9qHFAExaMld4LcHZirD/s44GaT6/79mqM8oHo+21I67QQXjyVThiEhSAD
         +aab3Xus13j14LDKJVItZDL6rjpSEaFAmUYvTnA14I7nuevzG9SUpCy/AC2qkhq6RhXk
         RL70ACQQcI0oiMx7V/6pqboLL+BCkUNB37BSV21iyaV4jIZt0Kc3G2/VV+ozN33Y/b2L
         s1Bg==
X-Forwarded-Encrypted: i=1; AKwUvBzjbHDKwgNbS6JDiaWibtFdJVhEOtokYlTdh9B0kruOjMgbrk6hEjWSzV1TDAIKwDOPKO7avAQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kiK6TXqWLgH52fgt/ktVn0vuKK9bUEDY2d95fla1bLzMYhGaz
	HkwryQI0BWUC8ep+YfoJe8pG+BU9Ov3WdWHdjblGy9f0Id7iF1FczzLFv+AWhvvUVQ==
X-Gm-Gg: AYBFou1eYcryLZl5P1jBYZ7sSROYJB9co8JG46xhJh4qofxmmmnJ8BvGPuWUPwueVWB
	VkTdYeiF2AU7UQ2NB8MUAUcZioPvT0vBoMviGBVMolGQJsY5W1O+lB5cRRDI9BEebJGUgytltl/
	CEU61niazsb8z81Bi5hrfEx44PapXcDzt2zfa/4fQl+9rjDy36qbvspeF+qxOoflDcU1Ojy5fau
	HxTTzjPCiETHiEVp3xuGZRMIco4Qrt2eceN0K+PEANGGlEG8xDdl/2Fj/ubH/qXPpqymGbtMh3A
	FJrJC4dda18M8HEk3YnUJWSymYEuQW6OC9EAHf8yjNVgwmoPj0lR86s7Jp0mIORuACSs3eB740w
	ZqSC0D6PmAlyOpbGCXK9IExcNVlWiU/17ysxBzGQCBf9qp9p+yT3AxmBiS0rAmbjXisxVJ6NX6e
	xE+JHudOduVbecGUSi5fe4KckFj3LK30GJ6FJLjY+jlvlwEchVOqxhQgwzZrDb0T1zrdBrMwhq6
	qDSKJVgt80dEDW+jfYb07wmB/dhOdxb6gl/cKwcH95S/IDjVHSiwbcQRwhNm6Qf8bHKJWEmoWVr
	Z/u9hc8vnwmxpiCu/952Df+huiS9doamwytzWEyaP0M8WgA7IyGuq1P3X+VkDUzo
X-Received: by 2002:a05:7022:2606:b0:194:9e7a:3ba2 with SMTP id a92af1059eb24-1b39fe301edmr686258c88.2.1794104416954;
        Sat, 07 Nov 2026 18:20:16 -0800 (PST)
Received: from mparker-home-xcrbr.sjc.aristanetworks.com ([74.123.28.17])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755e936bsm2585693c88.6.2026.11.07.18.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 18:20:16 -0800 (PST)
From: Matthew Parker <mparker@arista.com>
To: pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Matthew Parker <mparker@arista.com>,
	Adam Calabrigo <adamc@arista.com>
Subject: [PATCH] mtd: spi-nor: gigadevice: Add support for GigaDevice GD25B512
Date: Sun,  8 Nov 2026 02:20:11 +0000
Message-ID: <20261108022011.898185-1-mparker@arista.com>
X-Mailer: git-send-email 2.51.0
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

Add support for the GigaDevice GD25B512 512Mbit (64 MiB) SPI NOR flash.

The chip exposes valid JESD216B SFDP tables including 4-byte address
instruction tables, from which geometry and opcodes are discovered.
Stateless 4-byte opcodes and status register locking are enabled. Read,
write, and erase functionality across the full memory array have been
tested on hardware.

Cc: stable@vger.kernel.org # v6.1+
Co-developed-by: Adam Calabrigo <adamc@arista.com>
Signed-off-by: Adam Calabrigo <adamc@arista.com>
Signed-off-by: Matthew Parker <mparker@arista.com>
---
 drivers/mtd/spi-nor/gigadevice.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
index 6a2e6ebda148..de96cefde516 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -64,6 +64,10 @@ static const struct flash_info gigadevice_nor_parts[] = {
 		.id = SNOR_ID(0xc8, 0x40, 0x19),
 		.name = "gd25q256",
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6,
+	}, {
+		.id = SNOR_ID(0xc8, 0x47, 0x1a),
+		.flags = SPI_NOR_HAS_LOCK,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
 	}, {
 		.id = SNOR_ID(0xc8, 0x60, 0x16),
 		.name = "gd25lq32",
-- 
2.51.0

