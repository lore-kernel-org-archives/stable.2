Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E852C37F302
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528257; cv=none; b=Q1LpPcgBouMVvXHFndzFZsJjQoRMGV5hq/sZAyWCkJfqU69AZy8PPOnTcNQvBrIllVuBXy5BRLeIKFqurTCxHBCTeA//Nqbjw64+EBlRqQ/rboTEXo7SwZytmwsrqDxl4jjLSuwZjYx0znxxC/+hvg0kzu9z7hMTsnKuvrORjjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528257; c=relaxed/simple;
	bh=IhSMzna/Qy44ApsOlu0WdAauAmcU/nM09jNwOPd1cnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuAiFvUlOTaZ3cPoKOEDA6sgp2Cdtw7cKAiJAxHcF7R5xowsm3TnP87arp/R0rirGTwyGKDJsmt6NAqKPo/mDLnvS4/yrp3V0UXt+WyEuvrMGPpchMYe7TJJFTwxO6Ai61PqGWGSsqmTylvAMCu0kBnue5zDsO1zY4I3TM6Ej3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yq9XZpBG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq9XZpBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4451F000E9;
	Wed, 12 Aug 2026 09:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786528255;
	bh=788j2qn1rqyd65JHeOtpyslTWORs3/qKqTbOvKCIydM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yq9XZpBGASH1/bbr0VSYlp5mNMwGNDytiWW6oGDuwgXYT58vEqS6Pc4dhyd+js+LH
	 anCRloyNwVRXPjPKGLOvSsZCcXx3lk1SIYljlSotJq195VHvitpeQXLitVEQiEk7i1
	 uHVsOFFs30UzIcu0tuwjN9C5p2HJOk8svZap2myBrdWXZ61qB4ivXKfS0LZEJxjEQT
	 PMGcULPocc/+Wn4dqo9gIX2BLqOqMwbaqOHLyQgHyRj0GufqraywBAvOYjIEv7EpvP
	 fLf7+HZ51IAj3NEfW/gjrn6Ecq1Ln5DKQeVItY79CKC/VjOh2d6SqM46h+GzILnVkF
	 Scj9RVrXHQMFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] i2c: bcm-iproc: remove printout on handled timeouts
Date: Wed, 12 Aug 2026 05:50:52 -0400
Message-ID: <20260812095053.1573236-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080559-pope-hardcopy-9445@gregkh>
References: <2026080559-pope-hardcopy-9445@gregkh>
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
index e905734c26a04..133d02899c6bd 100644
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

