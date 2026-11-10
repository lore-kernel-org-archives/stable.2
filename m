Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281913;
	b=nGayakI8AtkjefuEwx3kzp9KV1C3XBEePDhxoGFdhzT5J8LOdAy5PEkvp1wDVLX1+YHt
	 TCUd/p4cO9VuVbg6RecjPnRVRolZ8DZaQbQiKmWBtY+0NxiPP0bJH4SjD9GHLutbkrQ5p
	 bCumrBHQE5UOyjbKBvjnkfaF1N/A/Q+0YQhxpJGdhBN77FdzkLvy3A7KzxP3+2zjynJnd
	 5o0U7If7MxdM7+nHmr8vGtC/uEBWj+CzFhN9mBGQaay0HmwbiMFqnehD+2oZHcAyYLgAq
	 cJTeutLQGXwbSun1rimmfAP4JMSG+up2amLwpdGcd11JDd/o1Bh7BJUVCqmoC+IwRLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281913;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=chv4zSF+9YYK9eh11k5JsbF1l/rpCoLXb+7Xed5FiQE=;
	b=oOhHyxnm752D2LVHKtEDFZBim5nslJfraYwANKFkwm7DRdSth047ruYRD/SuVokuojHM
	 FTs++4Z5oz6IwTKXL2LI8NeCVksTwT+FRhFhItDL7KVbSn9SX/bK/zNpCMSRuqNXegFYz
	 hmQqIGk9VDtDscXcVFNdbxxlEnqFeqzo0cp+93nSS4VDs5eyMMPZJlhwn4J3nugq1NXp9
	 sHw0h9QmZItvLjlNFsOb4dkN06zI+2pfOPNC4G1duejmDetJ6KmTSe4NspTuy40eDziOk
	 1VY+VwKrNfG4/33WxVDoQZdGzbGwEiwPc4KNOj+2QWFfxXc9zjfEG6arJRP4qztZV3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B7Nmm6f3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FAC606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B7Nmm6f3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AC91F0089F;
	Tue, 10 Nov 2026 03:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794281912;
	bh=chv4zSF+9YYK9eh11k5JsbF1l/rpCoLXb+7Xed5FiQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B7Nmm6f3i6iR0Squ/I3YDsT8NxLMavM1mvcVW+Far68qLfDOlq0Er6TJtPXWXVUd6
	 Bxo7VirMQhawMKSb/CoFXu4iHp3kp7ctXGIRTtAO7MdY1VgDK/IpUIXv/OjSggzZ60
	 /O5Ac6edcV4NQSitlWrOnWHt5b3aYj7fK/IgVh6rZOQx6xDo5KSKp+L3r5WNSacnaG
	 HCMaNp41sX4D6ahqIYqpuHw9PayDM9kMHI8x/4QBHgoPGh5l4IZ81yRIoxMOuUH0kN
	 0w3k3EirkioYnZ0XVqXcsX027DHQEHcIfJaXM+Y4On8cQo9Lc3ClodVEM34YPMZRYK
	 8FkW/TBRlO00Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cheng Ming Lin <chengminglin@mxic.com.tw>,
	Michael Walle <mwalle@kernel.org>,
	Russell Senior <russell@personaltelco.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mtd: spi-nor: macronix: Restore fallback parameters for MX25L12805D
Date: Mon,  9 Nov 2026 22:38:31 -0500
Message-ID: <20261110033805.190196-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050624-failed-6.18-01739ccea21b@kernel.org>
References: <20261107050624-failed-6.18-01739ccea21b@kernel.org>
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
[ sashal: adjusted context for the MX25L12805D entry because the upstream fixups assignment is absent ]
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

