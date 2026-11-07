Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045778;
	b=Z6+lIMjeaJzCSoHKcyup5b68KBRjTNCdintb45+Q6XLZzoivV2Ked9Tu6RHr7AMPA0Ti
	 C8fXTEDgUvCob3cccqWfNypQlEAaQK/bNV2VO6q44OA9rXv2pEDF4Ijs+SOvqDUnK2pQ/
	 W/PeVcAXB3TJar9yw1+yBdRNq05ugegUwlNWAJSRROLVV6u53KoDUuuFZNtAbeqfJLNYY
	 AHEQ9QRH3n1SxL9G/1Z3Kh8/oKDz7MXoUVLGQNZc7rWyQfIMimWodly7l7iBNatjPpYH9
	 zXrXQAPLBIceG1qgHygwOYHw+4jPC0ioWqESwOErSyD0Vr0Gc2by/GiKL02ufHJNb2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045778;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+O1snZGtvOPvLNN9zguKZkVtHjD0mtjb5PTThDSne5U=;
	b=wk/bWl26rZ7rqd7PdHvo2K2OyKLhRrUzupYmMuE6hrFzNaUogrQKLHIP0sw5XxAziqEs
	 S7yXLH0rtlmhtGfQUEIHXpjmpXbbUWMolSG4h09KHyV+z3Z06uQS9MCZwdXPD2VIGCUn8
	 8EqlwWpgq9spOX7YTo9mpGWEJsq2eGkG5wVxkZjbKFGDp4KioIOMh5eEvyQLHENUhl3YX
	 Kkf/Xg9bp3jWtxlurC8h8WvJnlnOnJDCWdMHyoUnrcOSFh0buet4J02WWasFTVRkKJEma
	 RQ7rV2OzYbh1k2ytEwt/LgkBezAp9PiBHwPkMvGsZfSwygnIY/0gESiNZ9S3ORUkgOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YoD1dqdj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18638606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YoD1dqdj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4041F008A2;
	Sat,  7 Nov 2026 10:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045777;
	bh=+O1snZGtvOPvLNN9zguKZkVtHjD0mtjb5PTThDSne5U=;
	h=From:To:Cc:Subject:Date;
	b=YoD1dqdjGCEPWO7vu87seGMJotsJcKGkQLGxSvXcEu+iIv8oXkHaeAzTel2P0Pq+F
	 BC9Pzk7b/UWZyExkNV6gwYC9yWg2zRBe5Gfyfp8qGEhPICf98h5MXes3cHYc+H7sJe
	 xYCztPrJZdujQ9AKUEu+9AJUZZKEaN6KlG9ACCbCfxr7WF8JabVQGsE/GVsz4optaL
	 XMQX24sBwXP7mfvR13Wh1FpM0d9SI6SzHJhPHe/TGL0bKF8A2VPap35wJeHzgYCCRM
	 NOq4Ve1bGRwxEl9HXRjk2IG203hpMhIj3332U2na1Sadz2ILoOmKzmQjA66jj3Gtxk
	 tjUTpuT4xk9Aw==
From: Sasha Levin <sashal@kernel.org>
To: chengminglin@mxic.com.tw,
	mwalle@kernel.org,
	russell@personaltelco.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mtd: spi-nor: macronix: Restore fallback parameters for MX25L12805D" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:02:55 -0500
Message-ID: <20261107050255-failed-7.3-01739ccea21b@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 01739ccea21b69818dc071096a249e6f84a6b13d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050255-failed-7.3-01739ccea21b@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 01739ccea21b69818dc071096a249e6f84a6b13d Mon Sep 17 00:00:00 2001
From: Cheng Ming Lin <chengminglin@mxic.com.tw>
Date: Fri, 5 Jun 2026 16:48:37 +0800
Subject: [PATCH] mtd: spi-nor: macronix: Restore fallback parameters for
 MX25L12805D

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
---
 drivers/mtd/spi-nor/macronix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index c3b0bf38a6506..332e09c8332c0 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -155,7 +155,9 @@ static const struct flash_info macronix_nor_parts[] = {
 	}, {
 		/* MX25L12805D, MX25L12833F, MX25L12845G */
 		.id = SNOR_ID(0xc2, 0x20, 0x18),
+		.size = SZ_16M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP,
+		.no_sfdp_flags = SECT_4K,
 		.fixups = &mx25l12805d_4pp3b_fixups,
 	}, {
 		/* MX25L25635E, MX25L25645G */
-- 
2.53.0




