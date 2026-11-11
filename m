Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415214;
	b=MU1AeuV/UhPm3WCDWHdElM939NIXjejPrB/5fjbFcKfj20XhHvkVbjimItq32Z4axAce
	 K64BprZI7czB1MiG2heiyn5VukBUio5uL8tdyWGO3rtRZaojp9BE1DIacLja7l1iaM8F4
	 nv6iyiKLl3ht1TXK3tofqMEDsGqkhxTXIuMXarSR0Pyc6iN/Yx/tFfJR4uv773g6znVeT
	 WqfNeu6l5K0IQq81Nf2d7cwNaL7c6aB2OWd2xB7ID4uDtFu9fiKT/waQ4/IInbdSAPqKO
	 UUDRQqtMp6gxbB9oEzs0pXIAeEh+A+I1WwC+JFFxS6kUI6C26ejxUPAE9xbPm5hhIGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415214;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uuHX2wOJ0cA5DPtyug7aK1FJSizLcEghg6bPyiMXoUQ=;
	b=foMXpj4Rg/oLBwGTcfClZP731nMQUmGZlnCrFpeI4zInTQehUHgK29ztsy8TgKq7jboR
	 nZZEME/emzXJLYO3ixOHYYnU0LG/rrkYHFVXWBI0a1NbGn/uy3Y+bRVdzsiBJ9zSQDaZE
	 5mkP61CKKhBnUzJkso1ZzuDJQwFb7lYNul7xlcuDN3wj9nhJ6zwJFUewFSfumK38k2Q7z
	 NFIWZbc8l3YmF5fGvxrMhlRAid5P4O2zf9y01vKV7TREL5ZpYfZibBF5iShZaH3RyMeSY
	 xqfFZ97p2raOh2QMdRzxPjgUyVeZqqbSu1xfzWp/jvjgcQ7dbIB/Fyht+3gvSSAZ69w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ddlz/EJI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88B606A33E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddlz/EJI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CCA1F00A06;
	Wed, 11 Nov 2026 16:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415214;
	bh=uuHX2wOJ0cA5DPtyug7aK1FJSizLcEghg6bPyiMXoUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ddlz/EJIbcZXRItx/NC6QcwVmjLYXLoCu+rma7vA19nXWw+VXiLv+6pGYY76H/oFA
	 Hhv0mLXwVXTCttJTLTZcLF5OV/0RIXKjZVpF4OYrphZqPUgpP6Zq63L98nakSdYMyY
	 uoCmxWkpGBrIG/4vPUGYfVknwZzUMSxAKbw8sfsPnFCkKvkUV42a9befy6srVF17vf
	 SyA17ve7S3obooDiJITuhsSw4x75hCfSXAtZLO3kx4IA672b2a0m4J2yKCycs3qyUD
	 z/2xDg8N0r30rCvpmIHWwARihALXocUjgh/cFLqplM85jK1gdH9ElJDKkNfqT10v0h
	 FlJ5/T6XBxeGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] spi: cadence-xspi: Use FIELD_MODIFY()
Date: Wed, 11 Nov 2026 11:40:09 -0500
Message-ID: <20261111163924.3264424-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111163924.3264424-1-sashal@kernel.org>
References: <20261107051125-failed-6.18-ea9854a169e9@kernel.org>
 <20261111163924.3264424-1-sashal@kernel.org>
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

From: Hans Zhang <18255117159@163.com>

[ Upstream commit 6fa473f4c5dcc20db9799f90da48b977730e05f1 ]

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
Link: https://patch.msgid.link/20260430155456.36998-4-18255117159@163.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: ea9854a169e9 ("spi: cadence-xspi: reject SDMA transfers larger than the requested length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-xspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index b6b42daae1bce..90c6d9fa4dbb9 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -453,8 +453,7 @@ static bool cdns_mrvl_xspi_setup_clock(struct cdns_xspi_dev *cdns_xspi,
 		writel(clk_reg,
 		       cdns_xspi->auxbase + MRVL_XSPI_CLK_CTRL_AUX_REG);
 		clk_reg = FIELD_PREP(MRVL_XSPI_CLK_DIV, i);
-		clk_reg &= ~MRVL_XSPI_CLK_DIV;
-		clk_reg |= FIELD_PREP(MRVL_XSPI_CLK_DIV, i);
+		FIELD_MODIFY(MRVL_XSPI_CLK_DIV, &clk_reg, i);
 		clk_reg |= MRVL_XSPI_CLK_ENABLE;
 		clk_reg |= MRVL_XSPI_IRQ_ENABLE;
 		update_clk = true;
-- 
2.53.0

