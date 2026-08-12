Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D3E21D591
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529622; cv=none; b=hv5MqJJ1bcskSW6LRD2IpvVGxSB/6vOcyxR8OqOvMCtiRyg2fT3KkCZZjknFVzRZ9g+E+e13F3fh7nE7tRsJXlLEnmU2CHB43xCysw3W585NPKfM/Bwu4CNDDx40F/Rf1Fzp1jNKkG7Vj8nm+pW+fnGJZ0ei4ujRV2MynBEChwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529622; c=relaxed/simple;
	bh=afPa1QbCpcBDkY4Mmt473vM/ODGNC3hsmVb5vHAgPAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2DGULyv1oLOn62q7kpA9iZ3yVYgCH8kPoGx2t3LrAtksaENp0axNEKRtQdu54WeRW0ExhVOv4JeaPDlzee8BmzwzSqEPzlGxOGZ/nFE+B1prgXURzlvz7ojRsmoRasUo+Q3rDIT4KrgSMGRz/Pu3Kn8lejZ3GflFiKOeVS6AN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKki2MeL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKki2MeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28E81F000E9;
	Wed, 12 Aug 2026 10:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786529621;
	bh=m5Yj0e6+IvgIgmPCG+3NCGWFy9oh53GxZDwoF8Eskhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AKki2MeLvDHPqZDczsjTh9YpwkCrap6uV6HqAxSyDZkaOR8wRLAw+6E4CeJD75qT1
	 lUHjp60+RZS4ja2/ajK+Ocos8z1elt9zIfqEOA5h6g+yNXOR36UeVafm+HXj+5NZBJ
	 rSHZ/o1HyGS7W8s/qgUS1hdXscAmukPV9HDNFxG03yvXumATBNFpVUa9eU7r1maY60
	 dlCn2pEU2/lRRY/vHu7G/5DhxRHR4JVITN5SyAqiuWQh0aPBvjZpWTkDgaPsSv7Fkd
	 NTBLDFNA9BUSOcDYCaOgUhl7w0LeK9wKf289oRblhzl4YhBCRP+yBl0J4+8hMe2N11
	 2IGpkJuyyjHOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] i2c: bcm-iproc: remove printout on handled timeouts
Date: Wed, 12 Aug 2026 06:13:38 -0400
Message-ID: <20260812101339.1638345-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080559-rendition-presoak-a347@gregkh>
References: <2026080559-rendition-presoak-a347@gregkh>
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
index 299dbcd4c8292..33a57f362282a 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -821,8 +821,6 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2c_dev *iproc_i2c,
 	}
 
 	if (!time_left && !iproc_i2c->xfer_is_done) {
-		dev_err(iproc_i2c->device, "transaction timed out\n");
-
 		/* flush both TX/RX FIFOs */
 		val = BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT);
 		iproc_i2c_wr_reg(iproc_i2c, M_FIFO_CTRL_OFFSET, val);
-- 
2.53.0

