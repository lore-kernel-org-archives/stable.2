Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C416741A56B
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530341; cv=none; b=aa6U9RGQklorLTi4YrFRqyE7hPKmDpLY//YIaDBO70mLrqC1e77xRz+frxMpryrdCtnNFNdVUT2/3/MVRp+CDaMWUzXqrG3ckKuUYe0qVmSfT2dMjSGBE38dBc4fYHAnSJ14muEgEraT4ip280aDcOyy3ja5KJdCUu7jCj4Px/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530341; c=relaxed/simple;
	bh=c2UJx0+mmkJX0i51xzZDFFd5bnM658TN6jJpSv/LsZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dscy7ewFytt3TMFHjK6jT3U3j8gh2JHdDUkDArkJRqKmoN0Dx5gew+pMBH5AJMDpVFPrzl43FypfM7MKZNJVfKLha7hi7CFnzqAQBcH5tRrN5JphZ2IDY/IdAkl8amWXImlFwE04Q4YCA8R7gcqQp7MmHLxS3dBqHmv9pfKPlHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARhBbtJv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARhBbtJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16971F000E9;
	Wed, 12 Aug 2026 10:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786530340;
	bh=R8sDTb+J1/h7OOdMCR16pvNEjaIHmKNKE07ee6YGbw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ARhBbtJvcy72vqAi1m1YPOTbvBUsYJ+XqZlSeFjPNGdgDgssWf/wW2aO0AWntZdmW
	 M0MrioYboED2ghBb4ptJHp0uW+lr144hWwoGYUUunF+U3QI5gCR+Tey5gTAd5iOKw1
	 e83nrydfkkYtYKyyOu2VvWYNKwPZ4btCzt/yvWgD7q6OEOSdIzVWuczT8By1+A/FlH
	 kSDmnr2guX7Z2LpByedsD0/DkjIVreqVMjmOKjgzhIzP7IRNnCF7X6eJzDBnbS5DX9
	 OOC8MTclcxBmNwRk2XnbwtSZJXjUu6xE8twOrsRZtqbtgCo4NTOiY+f5LuyiNr6FIh
	 A28ZT8fS2exiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] i2c: bcm-iproc: remove printout on handled timeouts
Date: Wed, 12 Aug 2026 06:25:36 -0400
Message-ID: <20260812102537.1684998-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080500-deafening-paramedic-2676@gregkh>
References: <2026080500-deafening-paramedic-2676@gregkh>
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
index a524d2cd11421..f74299b897df7 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -789,8 +789,6 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2c_dev *iproc_i2c,
 	}
 
 	if (!time_left && !iproc_i2c->xfer_is_done) {
-		dev_err(iproc_i2c->device, "transaction timed out\n");
-
 		/* flush both TX/RX FIFOs */
 		val = BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT);
 		iproc_i2c_wr_reg(iproc_i2c, M_FIFO_CTRL_OFFSET, val);
-- 
2.53.0

