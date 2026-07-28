Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69D175A8B
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 00:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200285; cv=none; b=Z7INgegE4ZRUtDJsIySVqbVZHWm8nYf4nUkzc0UjctZRuAY0THHsvPxFh2GBDhdX3ZEzLYj9bN/8Vgi+zL0CKKXs32yA2BgN4dTgoj//KF/SWGsraEfn3nWdAdtYqqCnoVFeyo2wCpnm2mSryPb7TuwDfaC1Xcv11vbG9999/eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200285; c=relaxed/simple;
	bh=PXDuKzSlHp2GNM2ULmfnPG37M6RYWTFtC1OKLAxOwVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYX6+b+cAlWELmA9UaBAvHZFTeMVsg8AUFW9i3qqCsg25qZymO8aztGD5za8EvRKOdbtzzgb9Tq9fGtk4qlFqhqgoVk0cRbY54wGL9lZX1ZqsVX48L7qK5z6uELPHaC8UU2XLEdabiyqZoS5zrHb89Y2nsigUCwm7Uy6JacHNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyOG61XY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyOG61XY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D561F00A3A;
	Tue, 28 Jul 2026 00:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785200281;
	bh=u3tObDZ3JBvH7+HOaZzopLKqTCGjz2Qn+yXg+aU8kD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GyOG61XYG6x9NiIvizwKsVs3CbktDOJbWp8QcP0VNf5YBiEVr7lCXImGQhzSc4b/H
	 DXbmQXjEuAYqIWhUdPVyqn5BwfhZBOdNQ+lJPp1c6mnmS1pwvXykUw2q+8QmMDhWxi
	 MBLwj91Z4rPrCOH4VpNK1rdUIobe8KEK4o3jNn3wQbaAyiWIHq2OwRcf1IxlciRte+
	 wI5RPmSeWWHJ5AJb6KYBvQfF70Lq7ADKo6dpBm/oGFM5aMt4kozOIO2Jv+BVqbRtpW
	 Y6vYj8IbLn1unR8JmtfqelD1k2TV7f6wR60d4W72YaWXtkGYqiDW3SH+P+Mj5S2ywv
	 w327lXc1qzJbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sashiko bot <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] Input: ims-pcu - fix firmware leak in async update
Date: Mon, 27 Jul 2026 20:57:57 -0400
Message-ID: <20260728005757.2692793-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728005757.2692793-1-sashal@kernel.org>
References: <2026072051-anymore-flashily-03a1@gregkh>
 <20260728005757.2692793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit d48795b5cd6828d36b707e8d62fc9e5c90e004ab ]

The firmware object was not being released if validation failed.
Use __free(firmware) to ensure the firmware is always released.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/ims-pcu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 2bac9d9c7b0c9c..4496378e31cda4 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -944,9 +944,10 @@ static int ims_pcu_handle_firmware_update(struct ims_pcu *pcu,
 	return retval;
 }
 
-static void ims_pcu_process_async_firmware(const struct firmware *fw,
+static void ims_pcu_process_async_firmware(const struct firmware *_fw,
 					   void *context)
 {
+	const struct firmware *fw __free(firmware) = _fw;
 	struct ims_pcu *pcu = context;
 	int error;
 
@@ -967,8 +968,6 @@ static void ims_pcu_process_async_firmware(const struct firmware *fw,
 	ims_pcu_handle_firmware_update(pcu, fw);
 	mutex_unlock(&pcu->cmd_mutex);
 
-	release_firmware(fw);
-
 out:
 	complete(&pcu->async_firmware_done);
 }
-- 
2.53.0

