Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079926;
	b=rALb50x/2QWoqqy8mdepAaknZZdJKHqdDRRcXXm34gHwlJxxB16LgS1m4rd5kkNR5IIe
	 HBkVZ/jqIeyFXflRvPAVi8Na8xCYtkWvpQz7iQy5fLR2RToVk9wHWSXQYyG4+9LTJYjGy
	 sEB4Uwg+o+5Fek+XGcrS3DiQkWNAyNGuwOxxtv635ZlSqPmaUMfpRI9BRQtpEXWpy5Njg
	 UpNaojMnjKz/edxZ7E85dPd6LPu4NWp0cdDpLo8Im1F+I/w8ZFRoincGGKBKPsDcKP6uZ
	 kRghKdh4yCiG8Q5/ADENnXatK/ITEGNsR6ND+fqbJaAFKRCoh2m9jNuCDFjSgXLV6+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079926;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/DENCrR/L1T7ZlM9C+uOCcC+e5dFUci3R3nG6lEaHdc=;
	b=cG300OT+n1KNXD0FN7PUVMhacPdh8GMxyayxh9Ia/UAMSzNrlpB7S7p+g1Q5d/5T6uQW
	 un39H5YBQIDg3VOE0GlV2+d0TzJK98WLK9tf9pPUO5tZCcUGKMF4TD2WXfm52yXaXUjK8
	 gAtdqhPbIsD8+ryo7qcMVeNr1CNMtj+oOxh8ZUdtcZ8TfGFx0uwkMnIQX1VTv8PBZP2+I
	 aK7eIVRY3/QaC9aLf33qOEJrihl3UT0Nkte18XO2R8PUxLyycHXT+SDcxZXhjsuE6sDu/
	 nMmoDDxbMFSVay320peBVTZ3n4KLZI8TPXqJHSm4SYl0+GpgTAUzBkfRMDICCcU+QFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Es2yI89q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1BF606A325;
	Thu, 19 Nov 2026 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Es2yI89q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD47C1F000CC;
	Thu, 19 Nov 2026 09:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079926;
	bh=/DENCrR/L1T7ZlM9C+uOCcC+e5dFUci3R3nG6lEaHdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Es2yI89qnA62ElI4PsP1UNp+BbNspXl951BDfKhuL202xBtJnQ58nCXgzYGR49Nwp
	 IS5atXCiipxoWMhIXAFDfthqpNzFEE4xbwPJBws17vZBZjM3yThPG9hK/jvAZx6WlQ
	 rwkSD+Ug5M0DrzBoD0rJ5NUZOj2OIXT8UJN+CFAD7Tn1lmjiKVh00JVQgt2cpbJclW
	 OuYuNPukSIVO4lsCa75yw1YfSm5sjR0ku2iQGS4XvaDraPYrHuJroCoLYMzw3pz9hq
	 /1na/RDfbgw6oSfbP3j7ldYHPY0IGykrpyplQpqoik/inR41VJp36m2gHKR4e716n0
	 quv8uzxgbeG2g==
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
Subject: [PATCH 04/10] spi: sprd-adi: Do not copy uninitialised data to rx_buf on read failure
Date: Thu, 19 Nov 2026 09:17:16 +0000
Message-ID: <20261119091810.3440619-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261119091810.3440619-1-lee@kernel.org>
References: <20261119091810.3440619-1-lee@kernel.org>
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
 drivers/spi/spi-sprd-adi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index a6baaf02b3c8..3586fc1aac7b 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -341,7 +341,8 @@ static int sprd_adi_transfer_one(struct spi_controller *ctlr,
 	if (t->rx_buf) {
 		reg = *(u32 *)t->rx_buf;
 		ret = sprd_adi_read(sadi, reg, &val);
-		*(u32 *)t->rx_buf = val;
+		if (!ret)
+			*(u32 *)t->rx_buf = val;
 	} else if (t->tx_buf) {
 		u32 *p = (u32 *)t->tx_buf;
 		reg = *p++;
-- 
2.56.1.708.g77570a6a1d-goog

