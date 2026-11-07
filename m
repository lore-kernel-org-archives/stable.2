Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046057;
	b=aWmA6Z9z9T+Xsb07OGzMACz2YF9wCuNVQHwELWPc+9VF/w0lXcSgnKA3hzLCjbiRKX4E
	 e6Cglm5DD1ZkwMpt9xrhpXeV68fmbalbQ8ZjkvlIXjlx18MY8/cKBh09dNC7DEs3LI7xA
	 SW8NksJJKnn0wNaCPgmbhGqlyEGFkMQsnU48QRka5GkSRakrxr6c0ze9/ReFZWLA4ih9U
	 oaClhw+RYqbwmBVeDjPIV2kwE3yqV86KsO0eq7oo1snEC/CcZDP/mxAsfol3WvTxaoHPq
	 pjxF8vcNs6zooh1WqsfQroXqOC4gM+k+WE/oynYdNsvhOLUZ6P2g7kWRUPgj1dr1GfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046057;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zmJYtEO2UF8UFAlA4HmXrJZOBluqa+QTjiodtKfYirY=;
	b=JX+LmscaSA3vZuJ8ek0IDKCwGVuI7/1JxELo6KyFTh/Fkqe22YFNna0fH5IDhReXQTbi
	 svJ98b6DNbOVT0srupXuFczBAZSBZ8//bIAuL9x2OVQ2vLe5QGgjzNjpv+RnT8LP0fafz
	 NcW/EO6metVlA9JzGxhsfg+O72skuWcQlz+wkj+PcKdVA3ExQsEunNMgGcJIke4XFsfWA
	 RZ+Xyhu3bpbvz6d4qgHfFb0znRe2ES0sfscCSm+P3doSDNJDk0GSbFrcVM+sWIwXZfMGP
	 vFZWT5SsJS1Fy34Z4TwHPfRUohOXTpcI30E/3bfdsUzbfeQUjqh0An9j9LR7iJSFUgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIZfrqlB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F6A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIZfrqlB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C4F1F0089F;
	Sat,  7 Nov 2026 10:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046056;
	bh=zmJYtEO2UF8UFAlA4HmXrJZOBluqa+QTjiodtKfYirY=;
	h=From:To:Cc:Subject:Date;
	b=EIZfrqlBodqeffqePTzTZ+vsbvgQggcerAdxISCGsHAkhAWEa9IWv8IHqwgexAsqL
	 Wi/i6TG6oAO5WqqAj8jjW8jTlZs5jTdHGPuolE2Dk0pjVUHqKVGoS5AOV8MoReTcyM
	 PCGlm+1TI/3BhBMeqGj/yE+T3GC/SAQ4UnE9qK1jHzmCThr1muprXnFtSdqOByk8il
	 i5pzL1b1zsqEHUIJ+PMCzEHjYUdj+28SW5FfTtp1Oex/ImQ1WSX9Xb+r1WuiCWts0S
	 VU+ydulthCWa8JM3swql31fpX9moYqiukxQzhnALbkn1OHC/lhKz5bLwmEcF8kDxRd
	 sGzHQOr9oTU5Q==
From: Sasha Levin <sashal@kernel.org>
To: zoone.rupert@gmail.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: pressure: dps310: fix CFG_REG bit definitions" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:07:35 -0500
Message-ID: <20261107050735-failed-6.18-4334dc4092c2@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 4334dc4092c271e6cd010c2ee70b7f4415c4c199
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050735-failed-6.18-4334dc4092c2@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4334dc4092c271e6cd010c2ee70b7f4415c4c199 Mon Sep 17 00:00:00 2001
From: Rupesh Majhi <zoone.rupert@gmail.com>
Date: Mon, 21 Sep 2026 21:31:23 +0300
Subject: [PATCH] iio: pressure: dps310: fix CFG_REG bit definitions

Driver defines them as BIT(4), BIT(5) and BIT(6). Per datasheet P_SHIFT
is bit 2, FIFO_EN is bit 1 and SPI_MODE is bit 0.

Only P_SHIFT has a user. dps310_set_pres_precision() sets it at
oversampling 16 or above, so with wrong bit the result register is never
shifted and stops matching the scale factor compensation divides by.
in_pressure_input returns -ERANGE at oversampling 16, 32 and 64.

FIFO_EN needed by FIFO support later in this series.

Fixes: ba6ec48e76bc ("iio: Add driver for Infineon DPS310")
Fixes: d711a3c7dc82 ("iio: dps310: Add pressure sensing capability")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/pressure/dps310.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 45bdb8c7670f0..35260b3993903 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -50,9 +50,9 @@
 #define DPS310_CFG_REG		0x09
 #define  DPS310_INT_HL		BIT(7)
 #define  DPS310_TMP_SHIFT_EN	BIT(3)
-#define  DPS310_PRS_SHIFT_EN	BIT(4)
-#define  DPS310_FIFO_EN		BIT(5)
-#define  DPS310_SPI_EN		BIT(6)
+#define  DPS310_PRS_SHIFT_EN	BIT(2)
+#define  DPS310_FIFO_EN		BIT(1)
+#define  DPS310_SPI_EN		BIT(0)
 #define DPS310_RESET		0x0c
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
-- 
2.53.0




