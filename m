Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280286;
	b=KxMp5XXtjA1W2wRnLBqMthJoPGPXRTqPGXiCI0q2gfsQwwh51QmFGEFV4Q/i7naTQT6H
	 WOjZwWQ2u3DhYPIUVzs4VHqNnsg038mcpvHltCeF1bAO8smSQvg4Qk6Qsd7brUXH319St
	 wOgrINpAGM0rq9HB2k/G3CJb01inSnStYYbkWAnZ76VLN5ltszTYk1yMpt2A9FXNxLh08
	 wNr9uOzwAs0jm6zsKUKB4HLG1EQYonltJDOgNO9SzpMHVm89VljqVY4Wb+vnOE/1tNGLk
	 s2WjdUnp9wFixk09M7K1qPilkb5o+pI4KqwJyivpRUDOowVTohTodp0yTvftuFzUT4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280286;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CeWtNCF1qRN8PVkO0IhCYPzr6OObHHWIz9AdckJk8Eg=;
	b=m3jP5FMrJbOOqtdu7PyCdsc6f80zip/rU0Vx/R8OXFaIfEZK2hibA2r4TW2mE9xjz5qq
	 LkKxZv/7BGRiOYRsCzr8axdR1GQeZDc/50+eAE2HLukSmy/uSLp/cr1TlmjEUZhVpyjuK
	 T7FegQgc63TMcHVBLj1r5vStSvWQeDut11fcw3zwFt3mqDhLCjhjNEoD9ukX/3t7oHZ0H
	 5zZYs4dquH7A5lYnUkJHGROJj7LzJNIFWc/YEKHcLurA4gAOR13ruqNOe4Hdw7mRahU0X
	 36HveaE779rOrJVN2XuaL2u4YXbw+0oOEtvSjRRtomccSnj4l1nLYoOMV1YH0or71Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=chkvOaAU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F75606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=chkvOaAU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6F31F008A2;
	Tue, 10 Nov 2026 03:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280285;
	bh=CeWtNCF1qRN8PVkO0IhCYPzr6OObHHWIz9AdckJk8Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=chkvOaAUuW0aiHNZDtrQxiOME13x/NSlzZFzl65qtJ0AeMOQQ4sHkixgNc7lErE1H
	 3gUIz/071Mca5EPgK+rZWpzwT9m6duh3eKt1sd+mGWBROwMAnuQk64jqD44LkrZxFB
	 pYeZoHaI/UwjE1kW6ONOWPHh4ybxkIbspyClDFK4l77Pk1LOlm7CVcCQhEC807Wn3u
	 GD7h8Utw60B2uaixpMNg+k00LCGjjti55LappfCNJD6ndC82jRQluTZYjsLybKZ6QW
	 HTnxZQFvTai+msdvxj8lFHQOvKc2la26tlkYcGaFG+bRP1dNHAFVCo426o/L9ibHSA
	 KTeakGv7/oXew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cheng Ming Lin <chengminglin@mxic.com.tw>,
	Michael Walle <mwalle@kernel.org>,
	Russell Senior <russell@personaltelco.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] mtd: spi-nor: macronix: Restore fallback parameters for MX25L12805D
Date: Mon,  9 Nov 2026 22:11:24 -0500
Message-ID: <20261110031102.5377-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050255-failed-7.3-01739ccea21b@kernel.org>
References: <20261107050255-failed-7.3-01739ccea21b@kernel.org>
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

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

[ Upstream commit 01739ccea21b69818dc071096a249e6f84a6b13d ]

In a previous effort to drop flash_info fields and rely on SFDP, the
static size and no_sfdp_flags were removed from the MX25L12805D entry
(JEDEC ID 0xc22018).

At that time, the legacy MX25L12805D was already EOL and unavailable
for physical testing. Verification was inadvertently performed using
the newer MX25L12833F, which shares the same JEDEC ID but supports
SFDP. As a result, the probe succeeded during testing, leading to
the mistaken removal of the fallback parameters.

Since the actual MX25L12805D lacks SFDP support entirely, it strictly
requires these static parameters.

Restore .size = SZ_16M and .no_sfdp_flags = SECT_4K to this entry
to fix the probe failure for the legacy part.

Fixes: 947c86e481a0 ("mtd: spi-nor: macronix: Drop the redundant flash info fields")
Cc: stable@vger.kernel.org
Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
Reviewed-by: Michael Walle <mwalle@kernel.org>
Tested-by: Russell Senior <russell@personaltelco.net>
Signed-off-by: Michael Walle <mwalle@kernel.org>
[ sashal: Adjusted patch context to account for the absent mx25l12805d_4pp3b_fixups hook. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/macronix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index e97f5cbd9aad2..c854a1163a475 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -132,7 +132,9 @@ static const struct flash_info macronix_nor_parts[] = {
 	}, {
 		/* MX25L12805D */
 		.id = SNOR_ID(0xc2, 0x20, 0x18),
+		.size = SZ_16M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP,
+		.no_sfdp_flags = SECT_4K,
 	}, {
 		/* MX25L25635E, MX25L25645G */
 		.id = SNOR_ID(0xc2, 0x20, 0x19),
-- 
2.53.0

