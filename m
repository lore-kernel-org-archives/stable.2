Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250CC31194C
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323778; cv=none; b=RgRTVoRAz5FIOk1/znd0gj/fDwH61XEqRJDLZ8xJXQQDueCco7KNRVwd7eylAvxEnwL3kk2NiN0zBjPZkXm2C17PPiv4j4RnFWhRdga9IkncASsL1SKCXESQn3rViOkCagGGH/9M91G3nWLsfqDV3NMEWnjt5zte7zup2NX+2iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323778; c=relaxed/simple;
	bh=U4RN1KxNCP1TbIm79RgJNQVFDWefazjS0aSqFGdM24Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpP1KS1yAGOCYfOVBwuRBW8H7V6O4Phm/KFKvuqXWnfoZ5X+x1CZYK4ecnt8p0qrk6K7se040TUwo05TOnrSNt8JwtgZR1+1w7bAbIjCcJ4DNpIYZpT01h5tLBEAsLMaGomdxlq4T5cZyhW2evAaVPZ2lSh01qayqANXJzLSpek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRImmBTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRImmBTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3201F000E9;
	Fri, 21 Aug 2026 14:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787323776;
	bh=+2OJsg4l0PkUH6Nwc3/E/YHvJIrpkNOHikCDMDxDNnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IRImmBTW952iO/oSBXWUF3OMs2vKV94AqvGOswnpzyZL3a2BYw6FzX22J8LNSNlDu
	 Aill++xci3TzNwp9hfriDjdXddDYtZ+inznI/MfX3shqRtmP5mCHUuFLj9QsvxN2lH
	 9P8xb+45RFip1UCtXIfS4noWrpPATompZSdFrhtcidjc+e00DnY/fz2QZyN37tQnRz
	 sIkYye8VGx2C4pa1W3yfnylVHOdgkCcKxw1+2DDqmSfisXzr2TbPTUUlGH8II7po3h
	 mDzXhCKxiBCNtHUfH48eiOwKG0Qaq58RP/Ji15as0cz8K0eKHR/Nzix7b6fhHtgEAM
	 6NTBMFcxlzmrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lech Perczak <lech.perczak@camlingroup.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] serial: sc16is7xx: fix copy-paste errors in EFR_SWFLOWx_BIT constants
Date: Fri, 21 Aug 2026 10:49:30 -0400
Message-ID: <20260821144934.3428649-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081755-unbaked-recycled-24ab@gregkh>
References: <2026081755-unbaked-recycled-24ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lech Perczak <lech.perczak@camlingroup.com>

[ Upstream commit eccdb0fd1c340155666533f5c60c5229d370baab ]

Comments attached to bits 0 and 1 incorrectly referenced bits 2 and 3,
which don't match the datasheet - fix them.
At the same time remove comments for individual constants, as they add
nothing to the definitions themselves.

Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Link: https://lore.kernel.org/r/2986a485-935d-4ab2-9a16-4a85288aa15a@camlingroup.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 246ac114f485 ("serial: sc16is7xx: enable THRI before filling TX FIFO")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 34abce41f92d2..d2469eb026f25 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -263,9 +263,9 @@
 						  * and writing to IER[7:4],
 						  * FCR[5:4], MCR[7:5]
 						  */
-#define SC16IS7XX_EFR_SWFLOW3_BIT	(1 << 3) /* SWFLOW bit 3 */
-#define SC16IS7XX_EFR_SWFLOW2_BIT	(1 << 2) /* SWFLOW bit 2
-						  *
+#define SC16IS7XX_EFR_SWFLOW3_BIT	(1 << 3)
+#define SC16IS7XX_EFR_SWFLOW2_BIT	(1 << 2)
+						 /*
 						  * SWFLOW bits 3 & 2 table:
 						  * 00 -> no transmitter flow
 						  *       control
@@ -277,10 +277,10 @@
 						  *       XON1, XON2, XOFF1 and
 						  *       XOFF2
 						  */
-#define SC16IS7XX_EFR_SWFLOW1_BIT	(1 << 1) /* SWFLOW bit 2 */
-#define SC16IS7XX_EFR_SWFLOW0_BIT	(1 << 0) /* SWFLOW bit 3
-						  *
-						  * SWFLOW bits 3 & 2 table:
+#define SC16IS7XX_EFR_SWFLOW1_BIT	(1 << 1)
+#define SC16IS7XX_EFR_SWFLOW0_BIT	(1 << 0)
+						 /*
+						  * SWFLOW bits 1 & 0 table:
 						  * 00 -> no received flow
 						  *       control
 						  * 01 -> receiver compares
-- 
2.53.0

