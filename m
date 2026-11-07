Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045986;
	b=kz8Gj9T90A0FYkKtjcD9EyPz+EfmAjnGNsBk4a0NKUj4t4dJHYY4KoV+jYA/3850ZE38
	 zK+uCxJCRwZ+Lf3ym0x2/rKeZiygZBNuNN6OAco+r6qujKvlt5jolBVG+LPoz2G59uKoT
	 S7+F8V576FyCV6izqxZtOKYZxj/JxajsWU/XZSR1VztMsm9WD4z3jgLk1XIOhcCEdx/ef
	 fXgDHg10yY0VkYfB7YH9bJz4e9UEpS/e3Ps03heBv2g9bWmivCh6Q1VrgidI6NdvK8nsO
	 q6smq8IIEdXa9gBgIm3jnKDyFIQA8l50pQPRpjHAEcCkLKsKSC4AKnx2eH3no4ukx7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045986;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1ZbQ6ubOndzMDBg6Pa3XEuui+dzpsM1i1PlchpLoZ4s=;
	b=pLwnxY+EaaAgAER2V5EWLMH4ZysO0d8LWs33jE4v2RdRg3gr35iHEZjYBFfqNlswhQRF
	 UbOH3eEmDzh1A8//qfJMJCz9aMkUZRPa293r4yGKx7Bi3VrUGXFkeJYQblO7P5UgN5ppr
	 7wNsSYbMiLyGtW/rZ5GNolTW08m0j4tsO5syR7Z+83j45LwRuN0nEiqOpf1qX1TweObt4
	 Byq3TK+93GQ7HDSOF+v4k7vAHtqs2i7rgw+M/AClrRM3SCzixE9CrXbYyt1oPmsQ/pkbV
	 34uCV6QDeyOcuXCtrrj4rJC6RjErVyoqb6GF3ELHP/RvDRgVAbA73br7P4t57r3+0Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtFfnXnU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45330606A332
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtFfnXnU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED421F008A1;
	Sat,  7 Nov 2026 10:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045986;
	bh=1ZbQ6ubOndzMDBg6Pa3XEuui+dzpsM1i1PlchpLoZ4s=;
	h=From:To:Cc:Subject:Date;
	b=GtFfnXnU88PDN7qPDXvmbzYdWVuqOuVy2qH3CjAHGGbY0LjdVxWUP1m569JsCuG9D
	 svZjdphAED8UVlC79ZMEcCsdjGuYHpx0TM+ZdWiHtMubcK9/Pa3xdeET69fVjGRykm
	 0dGBiDPMXKiIqfz/C8hT7pjndVKLZHo+k0osgS/mTg/hoSUfGTWUnI1QbBtt9/TSOg
	 UXBgNWPsjg9DG3lUCKYj9Yt8UV5v5pWog4vjnLBdC8Lf2oHGnFpYDsVzs2F2Jz/qSu
	 q8BXxupf2qlwCvotv38hQvDLx2gdN9BxAJZdq7G0rKZIRszEx0+FXuaY4/qozV3Ek6
	 2zlzE0tifn/4Q==
From: Sasha Levin <sashal@kernel.org>
To: chengminglin@mxic.com.tw,
	mwalle@kernel.org,
	russell@personaltelco.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mtd: spi-nor: macronix: Restore fallback parameters for MX25L12805D" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:06:24 -0500
Message-ID: <20261107050624-failed-6.18-01739ccea21b@kernel.org>
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
git cherry-pick -x 01739ccea21b69818dc071096a249e6f84a6b13d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050624-failed-6.18-01739ccea21b@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




