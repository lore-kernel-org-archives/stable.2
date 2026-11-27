Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793555;
	b=1a2tPi+DYwDO/rUJwKXN3Td1/7nDO4KhKbnHBgtSlJDVrmFKAk/tTugZH91DxYafn6tu
	 sYHNsnUPFF3C74mI4/5dUDgAeJ8yJhCcpNd++V2hcH4Iw8qgM10gNC4SAdA1VEzvMtXp+
	 NMma0zrYMNSUHFAF+6zA0D8pVZsA1J7zfANbEBoxDFxJnC0ThhJ45GPDLAXea2LxYiC6A
	 KvDXP+3BvKDXkbQ3P+PEKPkwyDYCa5ht2soj4jBgLxUPIJEDY2MkHqRRpE4DdMQVMe7OV
	 mQtn+C5gc9Bpu7oQSAF5oWvNVJIr/fM14ObtSjwo6Xj+R46GbuVAxYB/EJFHDSnDObA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793555;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TG90mzQ8xXrz2zGDnwX1wY/HwqICkFJLKfoFfAHtjd0=;
	b=gPILbdSIiD3H5CYtfl5yYi0wx9L09zYho68Adov8tH2Uo+Ajvj7lRlCwyybBk6tZ2keo
	 VUymufm+WtjbkY5tdeGeyDdtSjj0ZvkBildWviIDYfLH8Lu9F5IVOAeh3n+Lup/Lj7vFl
	 1bWDErjmAhwTmSOjw03QdTdtosnU++9v5RgJRFjPK/0pRdaNZxJySOQD0tfhxj66vQJk8
	 zWe6pdyLvAFcGqz4jhM/r0kvdEe48SbY1h3GrY73CiYkCnMrRXY/vMD5bi1cEGuI5W6nV
	 kjH2K4gV1kq71QO541qat8+oyxHBZgRE+JrO6dJeROb7pejqzrsMPrFzIduMnRfYDOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmUIwkgM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF68606A31E;
	Fri, 27 Nov 2026 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmUIwkgM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FFE1F00898;
	Fri, 27 Nov 2026 15:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793554;
	bh=TG90mzQ8xXrz2zGDnwX1wY/HwqICkFJLKfoFfAHtjd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gmUIwkgMFttaDODOUYyiTP+fYsZPyfyj+09dNA5B0x2OTV4Gg5I7NXkH4arg2/NzO
	 fsJMA/TUJweGvsYv2omheDdP6/f7hmYJB15GbEe68MGEP+Pc65uQDTEH7VoEtEk3f5
	 wgQ8NvBc3IHeUg5b9rVcNTlYQmBtYeLb5EpAfKpMvpDZ/utu2w2Y/xNDRrvt+/tlvq
	 tfvbLmbuoHUCWDuQWOQDhL1URZgBIJK9d66M7U9agUGMDu6O06VucEzdx3GFoC8QDJ
	 wv41xKMy3guBZ511V5HN7vK16S7Jc/AF1k2kt57nd4IGs9rG+/ZufMxHVegEHaU8xt
	 3/KPXQQeETQdg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Mark Brown <broonie@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Felix Gu <gu_0233@qq.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 04/10] spi: sprd-adi: Do not copy uninitialised data to rx_buf on read failure
Date: Fri, 27 Nov 2026 15:31:07 +0000
Message-ID: <20261127153158.2969573-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127153158.2969573-1-lee@kernel.org>
References: <20261127153158.2969573-1-lee@kernel.org>
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

sprd_adi_read() returns early without writing to *read_val if it fails
to take the hardware spinlock, if the register address is out of range,
if the read times out or if the read-back check fails.

sprd_adi_transfer_one() stores val into rx_buf regardless of the return
value, so on any of those failures the caller's buffer is filled with
uninitialised stack data.

Only update rx_buf when the read succeeded.  The error code is still
propagated as before.

Fixes: 5dc349ec131c ("spi: sprd: Pass offset instead of physical address to adi_read/_write()")
Closes: https://sashiko.dev/#/bug/linux-4e21848f-9195-4645-a277-501803f17e95
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 => v2:
 - Rebase onto spi/for-next; no functional changes.

 drivers/spi/spi-sprd-adi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 32e445cea0d3..68c8f8b808cf 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -348,7 +348,8 @@ static int sprd_adi_transfer_one(struct spi_controller *ctlr,
 		}
 		reg = *(u32 *)t->rx_buf;
 		ret = sprd_adi_read(sadi, reg, &val);
-		*(u32 *)t->rx_buf = val;
+		if (!ret)
+			*(u32 *)t->rx_buf = val;
 	} else if (t->tx_buf) {
 		/* ADI writes consume exactly two u32: reg and value. */
 		if (t->len != 2 * sizeof(u32)) {
-- 
2.56.1.839.g22a8290db9-goog

