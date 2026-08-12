Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF62335555
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528775; cv=none; b=ZpI8WjLARHJORnIdpwdrrQvxHNeDMqU0jefuUQzqTyz+heiOTg+ecOB2G1ARj1jqg9LcTdTHRb1+lS3ieVtppdOS+g0I+BG+QXuq/PMlVCredRy0PLXLMIOlmbqi6r392kjJb2R6Is5v8cu+jcfbiXBb/svK5sKPex/TrBCLX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528775; c=relaxed/simple;
	bh=4j+kmLzBItA06LQRUNhXLg7aumJGeBtGrU1iNvMvqxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=de5GoYRIaX49Q+iS2YVjSKduXgkm+YxzFpBReN2deJbpo/w0T7rSjkC4vI5mAbrymn0G4Zk/KwkEOyrh8LIEonGutexESzlODNvqgGEdtH0SR3hfooo7LTVhYDeEKFxL6o3an5ZTAR7REBN/tAEOxGgAlrxeBH1rdgzw3fMaZe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYqdx0Fp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYqdx0Fp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911B31F000E9;
	Wed, 12 Aug 2026 09:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786528774;
	bh=NvQ/Pfz2Z0rvWaTPMjFgpZrhHavUK+UBoYJGnWr7D/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CYqdx0FpnkvEDTIYX5ThF3WjCuQTxfgDeJ2gyHrXn6nhgnDBHvVZRg6p/KJ7ox4VK
	 Z0OLs4jKiIMLzXUC4btZwA7NYMdXgIPEAlynqj+mfzdcMLlphWF4oLz4FltT9jXN+r
	 mx5vGF+hJE1NyyhSlsL/mY0hybsXk4qi8MYP3HN855AlI8UKGg/gLJDrV1tu7sAb5H
	 pl0AHZ77nfWxomjS+F175Bp2dEquj1ZHf/7R5BsiYelBlq+4/srbwfeBUbxsp5M9o7
	 MNEEXRedFgKxR8Ox/LNf3Wsbxg+u5/x/1pUlRlSQKS510WYXB5UmnjmvdqwQedEhDg
	 OvKYs5o3GzctA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] i2c: bcm-iproc: remove printout on handled timeouts
Date: Wed, 12 Aug 2026 05:59:30 -0400
Message-ID: <20260812095932.1597082-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080559-bonehead-marsupial-c9b2@gregkh>
References: <2026080559-bonehead-marsupial-c9b2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 796e2c260187e32530cf343546ba1cdf2e2f5491 ]

I2C and SMBus timeouts are not something the user needs to be informed
about on controller level. The client driver may know if that really is
a problem and give more detailed information to the user. The controller
should just pass this information upwards. Remove the printout.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Stable-dep-of: 98f2e9e6d6f9 ("i2c: iproc: reset bus after timeout if START_BUSY is stuck")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 86a080f24d8a2..56203eadb319a 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -811,8 +811,6 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2c_dev *iproc_i2c,
 	}
 
 	if (!time_left && !iproc_i2c->xfer_is_done) {
-		dev_err(iproc_i2c->device, "transaction timed out\n");
-
 		/* flush both TX/RX FIFOs */
 		val = BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT);
 		iproc_i2c_wr_reg(iproc_i2c, M_FIFO_CTRL_OFFSET, val);
-- 
2.53.0

