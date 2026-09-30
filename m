Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA06E3BBFBF;
	Wed, 30 Sep 2026 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763212; cv=none; b=L6e6Xuct35w34BZgJ37fyYTu/4XP8I04RSrlT8IDlXZg5vzA/AVJJixBBFz5+cM4krtj8g6bSN/JkcjtcN0Sy/KBo2NyELOM28pJjk6HGtXx0k2naBIvWVAR2MTOayqYQkOm9ZKZV094wxpfGCUEVUCyhaRdy3steYCcYMLL6YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763212; c=relaxed/simple;
	bh=FcdLUdFXlI6wsmRPpBcbBKr2+7aKuX4f72+AMDNJAWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F22ULMH6i4IcckoW0UJY0BXLZh2g9pWRjIFTY5N4X1evKqaI3Ns1AsC5vgxG68Q5RXTP1FO5vo4/Vy8UEVyGt2ZbaBTwGv4ZgY5qzTVZbPz5jCAXkRL1gR1e3T6X9BLluuHwbnvP7yp8mCzprYmyWJJs1hT2ISUfFUeKY5PHWOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=jFk21V0M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QyQEMPnf; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="jFk21V0M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QyQEMPnf"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 428637A07E6;
	Wed, 30 Sep 2026 06:13:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 30 Sep 2026 06:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1790763209; x=1790849609; bh=RdQ15fTBCIw3BB41JZuI9
	9EUXVLEbdksxycbVeaWNH0=; b=jFk21V0MQVL4zhaW5/EGnzaQl8DEJXLvV7V7T
	vwp6MrD3sF1Bce4RvdIdlKlV/IIHU93Uar6Ry0VWgz1hZqn9p2kcc6Y1jZWOUIBZ
	5IHIbMVMIFYr/X0CUkk1nDgTdPL2SiQ/AuqBBVql2csJuYltVnoCMq9HpICewPoK
	oO221JTqUjD8ohu8aa0/eRZdkiQdJbAt4TJHPJPTkx7qObk50vDvR3ptN0+xQdJz
	cb4gt81JfbgQuMI0ojB3TkfGywpnQlFckb/He7ewa2DzxtaOvohsDEcx0m8SoBek
	+PawTIJfNJGkeYpq3CPqOXVPWIeDAUtGpFJ7E2NR65cIY64VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790763209; x=1790849609; bh=RdQ15fTBCIw3BB41JZuI99EUXVLEbdksxyc
	bVeaWNH0=; b=QyQEMPnfYtxWpCZupuTYOgFymsMOhrbHGPBnGQHqOyXlAsZ12ag
	H+KnTQgLFkoCroiDU44nwDCueo9slFqrE1sM/65bMepf0sYhI39uqkMV8/9j4E/q
	Fj4kwv2JQSdyPpTStQnmkg2bxMaru/LEOzjZUkoZ6jUja41ww8/RxKODbgQYOYAD
	0JG3NlW01eOEhurQsoIPkdkuzno9rgvD6kYjRXilxcQZS8bZWs+5nhz4PO82ZWKa
	zYhCt7UtWavD2jy/jOHi2z3rn2qsW6pPtjffYb64EPf5rBUwjGqSOdznnuJHI9LG
	An1AHsE/ylUOA8uS5DVFywXIg8hP5zy/QBQ==
X-ME-Sender: <xms:yOC8anyR-xQYr82mAXqrxHF0-E-7TBwc7DfRAYnzlSaXHCScnhGVMQ>
    <xme:yOC8ajj2HGgpAfyxRht2qaQLwtb3b6Ehu4zHm0yD6JyumRPFQMfiT8iChQQpr6i_G
    BXzQp9BCGh46FxUqkVYn2kpAUQt0gQjAyVKVHmN3sy0_OXiVtK7fLID>
X-ME-Received: <xmr:yOC8ak4ZfOcZdJY1cdAgwun4dsegEGjZWdWeHlIEKG8tXhLfeN2sC0YV39FCmw4qoIBqSP9SLWHiA5DE5y8>
X-ME-Proxy-Cause: dmFkZTESPWaCPYjmflZ1CcqzfJY11iazwxpTYyd8FMAAJ1pSz45fUT14YP0CGfQApUd+xQ
    evvDbn3MUe/syiRRDlOh+pLkd9dn5h5EJbaP4IK/j4yTvCjWGH/EuemWgTpQ2cmmGN/wbG
    p8MkLVhpv74KRkfTSiwWef9ChM7F8D5Q0YdjqbNNrcba23BibYxhJZW6HGwRuKnGJBXlMK
    QwSORU1B2oNxg77Y7k/gmt6o1KW3vOYpbLVwvKBeeCgdqeV3LJvK+1HP3jiZL7rcuca2SD
    5yuDFwyREMbO80JRz7xzzWU1BKKURBz54dTdeK39XRQv6YR9VUTfyQeTsp7M/qiJ4WUgB9
    i6VHFeDSBlptfd4xYUrLAnR+A5VnXaH8xNhjFxiA2wldSmc7JRFQ8RwKgUJcT5sVrejE+d
    uWqdHy0+FPsOeUoXJLXaBOLlu4r92VwhYDmkVPNEyGGdIeUzowbcxE6WhA+m/O/AaI/206
    zp/EwCq+YGJbVr21UnLVQHOlYE22yhkoaWnSsz+Cv8d/eT1dIG6q3K6Tptgx6yQ5tj2c5r
    IKD7nMfh0nbcQi4dWfBeHOHLvqz4s546aOLiKOUHn4t+Ra3bd7yXuw3ozbrJzIZB3k86l7
    QYlc/gjS8G6H9WIW1EguXPEPdTEMapKEGQFC0lQMSCO17tUIqdeJXRGgwtwQ
X-ME-Proxy: <xmx:yOC8agrrpl71rHUMk39HfsQFFb_ugO97aHpkoFV2TPQWR5j1eeGs9w>
    <xmx:yOC8aiXfF6q1VvSkMxGpruB4teIGKVx_4qhkmzqaxMmZUk4Nt-unlA>
    <xmx:yOC8av6ZCUfKFh64ZJ4a_H7U4_kqtrocH4VFURcZCAQ5AHzgIEQvTg>
    <xmx:yOC8ao0Mw-ffQFk7J8095GLsUU86CQyiblAbwf1WhAjgIHKCJY2DOw>
    <xmx:yeC8ahkXKtpO_iyXmZRtpeLdzMTjevsil4vph5jhcD0z9fBB3n6Jds9g>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 06:13:23 -0400 (EDT)
From: FUJITA Tomonori <tomo@flapping.org>
To: fustini@kernel.org,
	guoren@kernel.org,
	ukleinek@kernel.org,
	wefu@redhat.com
Cc: a.hindborg@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun@kernel.org,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	gary@garyguo.net,
	linux-riscv@lists.infradead.org,
	lossin@kernel.org,
	m.wilczynski@samsung.com,
	ojeda@kernel.org,
	tamird@kernel.org,
	tmgross@umich.edu,
	work@onurozkan.dev,
	linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] pwm: th1520: Fix 32-bit build with COMPILE_TEST
Date: Wed, 30 Sep 2026 19:12:57 +0900
Message-ID: <20260930101257.1649945-1-tomo@flapping.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

Fix the following build error on 32-bit ARM with COMPILE_TEST:

  ERROR: modpost: drivers/pwm/pwm_th1520.ko: symbol '__aeabi_uldivmod' undefined!

The driver divides u64 values when it converts between nanoseconds and
clock cycles. On 32-bit ARM, these divisions are compiled to calls to
__aeabi_uldivmod, which the kernel does not provide.

The TH1520 is a 64-bit RISC-V SoC, so the driver is only used on
64-bit kernels. There is no point in compile testing it on 32-bit.
Limit COMPILE_TEST to 64BIT instead of changing the arithmetic to use
the div64 helpers.

Fixes: 3c180003dffb ("pwm: th1520: Fix missing Kconfig dependencies")
Cc: stable@vger.kernel.org
Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/topic/64bit.20division.20in.20.60pwm_th1520.2Ers.60/near/626825599
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
v2:
- Fix a typo in the commit message
- Add Cc: stable, Reported-by and Closes tags
- Add Reviewed-by tags from Andreas and Gary
- Rebase on v7.3-rc5

v1: https://lore.kernel.org/all/20260929095612.1072417-1-tomo@flapping.org/
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 729776086879..abecd95b0c3c 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -772,7 +772,7 @@ config PWM_TEGRA
 
 config PWM_TH1520
 	tristate "TH1520 PWM support"
-	depends on ARCH_THEAD || COMPILE_TEST
+	depends on ARCH_THEAD || (COMPILE_TEST && 64BIT)
 	depends on RUST
 	depends on HAS_IOMEM && COMMON_CLK
 	select RUST_PWM_ABSTRACTIONS

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.43.0

