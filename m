Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098751;
	b=cG9ySKZa85UE8SCzWYfkN2eCKsCFjTw8M/X3KmMAR36BpUracAuUskaKh6wbHC5HYLhJ
	 gGHAn3ZdQWeqq84uB+Elorow6+s+nxjJUgFg6L3Yky8++qwVL7t/bZ9HidDe1m2wT/5EL
	 vWt5AYKDW4ADHD3HiUKuWk+WeGPD8zwpqptg3Na+ocHkwb326M+quUL+M3aU1xKs79NNT
	 2ehnr77C8fFzjcZv0xg/l5huZYnuDSmAYfK5VK/GdEfXrFuTLwxYoK2iKmrEa8fyZOY9j
	 TkIy3jT7U9fAxdbzonj47wfQBunqkHrAKNUGFHUK/smbqATOx8+sCgTu1KqLMcplZPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gDHxHqr/ibomT/hnh0MWIWapUMs27ULmVZLfvv9myQQ=;
	b=PR6MxJbUO73Lxu3mQhpAA9oyVF4j6V3zZUtRhoqPt5CIebNTkI/ATyB8foXDwBrwOeuV
	 zZ7x+2vblzIpRLnqSakt98N7xhWc1u2S8PxFq/bUjIg0KQPkftyrPrBFMb8ArOS4RG2dP
	 lOtj1dY0wjIzNaNXf8+dh7+w66Pa7t15h2GPBwA1+P5439SvWLfb02pvVjAG2x381lld9
	 AuVSWql1dqb1JZCayK4SWJjqE6E2xbDUJ7H2cqgAwvqOmV3xlnHOEGw/4viQEGTQExENd
	 y8/ICx867UyxL08hBfSU5a4OBHmySYZemwBu9Sl5/46OjhoUueJolIRKk7VjeUCztWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=JG2aRNNQ;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563AF606A32E
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 00:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 563AF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=JG2aRNNQ
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1aefd1bf74aso63559c88.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 16:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1794098749; x=1794703549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gDHxHqr/ibomT/hnh0MWIWapUMs27ULmVZLfvv9myQQ=;
        b=JG2aRNNQAV3DVSv4oozAdjJQGfKrSEm8Mjs0p7/VZVdIrmgSp5nf+N2rSa8woRgUEg
         ndOi3Adv13doRcjmE+ZDEVz0EfieK4XLL3G6ZiQBe16RsRfYs+yQtIfTQ5LKT5eCzCD7
         tqC2pXhyeCjhWIMJlE5OtXI5dutjHOP/SDsPWiTDiVadMSdywRmfrSn/eEmrolko+ZO8
         kBd8e+UrweowcN9HuPqzPOljqbnHsso2uZCwFMD+kyD5y9FOr6tbJ+0/w0HmTo/rjEtq
         1Ixdh7IwTwDehrkqx8QS4HcBZkGQkfu2hCIMCvM3N1ddCSb5XrMMxdT1XI3j4IwpyHWn
         AysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794098749; x=1794703549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gDHxHqr/ibomT/hnh0MWIWapUMs27ULmVZLfvv9myQQ=;
        b=eiYM6vPxflAEQvST5b1s05L2/Ast2++vKYy8qenpVdFy69UZ2loCJtkmaWbJfOwS82
         8vx09oj/J6984p+wu44aP3cg2G/Qd1RZxrumjVxYhpZg7fvdDHqSISwaLi1pXauLUabz
         NkohHAdg6t/LFslNMKjcI4u8eCBrEvxUJTMKMVilqGapwcL1/I51h71DwEMnx7QXepol
         Tl/acbtsozfudQYI3A8KIhtoMD9YmGsJ3txnXdySArN9q2CN0DiB9SMmDPKGmtqDyAn7
         BcRlqqaXWyNhHKslkadH3Rk5Hbj83BoxCyr7IAREvMMqBuntaIipLpeDLIQ8AN1Chcmr
         rjtQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjOTAsPfjIk1VQlSZJstJBTU3YpGU0HpQMbgq4o6eUzv7maMVQWSD3Q/rzCZnRen1/HqBdfXk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pGaL0VobpdVT3/mZWXnLGTanF4Hvc2UuQNdUy98BJ4v4K/RN4
	LXlKsfjaF/28BLmO9WX0fzBH6DTDQPTS3CXo28g6bmxpebh7ucDDbYtAcFiFpuxXDg==
X-Gm-Gg: AYBFou3+X7DMusKa15VPHgzhW33usSJLRZQg0S2UVouzhTI6413y2jVk3Ul0yqwR9Ol
	K7CJON/TaoXvXh8xLHoxr9J8TXFyIyNzvBLPi7+kOQn4fpqEC7weoFQGe8qKowOc4ZAa+dYn04P
	XfQSFCcklKrJbdmWiku448PD8TOMsFUo4OKvGNYqJZimbbm4NzVqVYnf9oUIL0vIP0Fnw9h7SrO
	i1xe7OYrxAUst7g62MfTyJcuX9Bd/0/+/jN4DB+ZOxIRPo0v9089nlQy8E+0pDG+b7IjEnJz1pQ
	wkrBnYTRCSTYmKH55DtZC7Qq6zRyRtir1Zo5qBDDXRWFmTJ7iHzyfKcupqu33s05prSpUF6W7H2
	MHqn1nD353jDaUc1LMJ/OxPMPOkSymXumZuh1nR+RnDeAaDzyA8K9DMAjXLibo1BHGFdbqlTvLd
	EEK1sy6Rpfo5lW1J5I6+nx84jmXidW7oecIIVdzISy2KhH2RoiUXAx3zHCrPSSyyXQjBKeQ++/y
	PcrZ9EyPXAqp9Ww1P2mMtJwwUaXGW9BVo+tV72hNAhntiV/7pqx86e8reI083ZBrF9BWhsEPtQL
	8BsujPCVoGr8AHTfsPngAxdIoFwiWy90n++jTGo9vZxMcIOAhfC5eywrvN1cCFR/
X-Received: by 2002:a05:7022:408b:b0:1a3:cbd7:1269 with SMTP id a92af1059eb24-1b39fedb95cmr206919c88.23.1794098749215;
        Sat, 07 Nov 2026 16:45:49 -0800 (PST)
Received: from mparker-home-xcrbr.sjc.aristanetworks.com ([74.123.28.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375604109sm2115225c88.10.2026.11.07.16.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 16:45:48 -0800 (PST)
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
Subject: [PATCH] mtd: spi-nor: issi: Add support for ISSI IS25LP512MG
Date: Sun,  8 Nov 2026 00:45:16 +0000
Message-ID: <20261108004516.896887-1-mparker@arista.com>
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

Add support for the ISSI IS25LP512MG 512Mbit (64 MiB) SPI NOR flash.

The device provides JESD216B SFDP tables which accurately describe
fast-read modes and erase geometry. Flash read, write, and erase
operations across the full 64 MiB array have been verified on hardware.

Cc: stable@vger.kernel.org # v6.1+
Co-developed-by: Adam Calabrigo <adamc@arista.com>
Signed-off-by: Adam Calabrigo <adamc@arista.com>
Signed-off-by: Matthew Parker <mparker@arista.com>
---
 drivers/mtd/spi-nor/issi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 2f057d731df2..977dc5ba8028 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -101,6 +101,12 @@ static const struct flash_info issi_nor_parts[] = {
 	}, {
 		.id = SNOR_ID(0x9d, 0x60, 0x19),
 		.name = "is25lp256",
+	}, {
+		.id = SNOR_ID(0x9d, 0x60, 0x20),
+		.name = "is25lp512mg",
+		.size = SZ_64M,
+		.flags = SPI_NOR_QUAD_PP,
+		.parse_sfdp = true,
 	}, {
 		.id = SNOR_ID(0x9d, 0x70, 0x16),
 		.name = "is25wp032",
-- 
2.51.0

