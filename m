Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271474968E0;
	Fri, 21 Aug 2026 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320234; cv=none; b=b4f14RElPyHHCd6sZ1ufvg/QlZr/TqN+JKnJqbSTMi1GDlqUbxI02+czA5TxpNPsuHgfv45heY5wayvgCm0E6/dne1HJJcW86nRv4iTdTogzm8mz7RnfECsg6LMTbEwzqMmb70kHQNv0fBZ5GxLfxY/BuuEQ2GS91NIWenwPb1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320234; c=relaxed/simple;
	bh=+OdNmU3kQtFUJCrPPsP1ZLOdt+4zemG/iTRVI9Yczzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H5mPWS+THcTz9z3kDk297sHrFHsSMjl1Eszw0kvJVXyJKLCC8/zmo8hVaXyADU69J0Vb44H2cwcIM9gS41CZLWNvZjFbAbfBL4PQrJYXmgGw+HRwcze6nuxCes2bvlgu5fN+UoIZYI7GVT3D7c4KvHVsQoL0aDuqzqZ35cacI2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSIKX+gR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSIKX+gR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8104C2BCB3;
	Fri, 21 Aug 2026 13:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787320233;
	bh=+OdNmU3kQtFUJCrPPsP1ZLOdt+4zemG/iTRVI9Yczzo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nSIKX+gRiO/5nYNaej3KWZHgi0X+dJDb9wS5J33mX39xXn03Ex7DQvgEjdEZp4z58
	 RijZElCtvVTESWx92292ngDu6iqBQV/TLE6fl+rr3c3h0PZXZ4QQxna7cSLVaB+PQU
	 c3ZnloBKWWHKfZfSss05uiDbc0L2iG7nWnabDDHYryaxA2k8cPK60XlkHb8aHWGjGx
	 30OZQE1+c40p/WGFrpfrCqcH4Awy0safJQUVqX18mUyMH4IokFNyGjna2/Izyz5TdL
	 DQCDnJn729YSyMeyRcI1dA8o+4BkSNPeeVdADzSMYb+4BZSzXnWVqyBJZF16qqx3Yo
	 MohE1K/rTebEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16D5C5DF93;
	Fri, 21 Aug 2026 13:50:33 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Fri, 21 Aug 2026 15:50:27 +0200
Subject: [PATCH 1/3] phy: apple: atc: Support DUMMY PIPEHANDLER state in
 configure_pipehandler
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-b4-atcphy-usb4-v1-1-45c0b741e0c0@kernel.org>
References: <20260821-b4-atcphy-usb4-v1-0-45c0b741e0c0@kernel.org>
In-Reply-To: <20260821-b4-atcphy-usb4-v1-0-45c0b741e0c0@kernel.org>
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sven Peter <sven@kernel.org>, Paul Cristian <p4ulcristian@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=+OdNmU3kQtFUJCrPPsP1ZLOdt+4zemG/iTRVI9Yczzo=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1ZH+NJX+Zztsv9Sudi8M7cUh0vmGn48crrmz45Vb74x1
 2s2LZ3YUcrCIMbFICumyLJ9v73pk4dvBJduuvQeZg4rE8gQBi5OAZhIlR4jQ6+hnNtj3jKviK/b
 //jsTK7o5/oRb75/7nr+U3kp6utEvBgZrmluCP1l8O6V5tWoT/J/Zh7xTiipWt2SGP/9k//kgs6
 9bAA=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

For both Thunderbolt and DisplayPort atcphy_configure_pipehandler is
reached with a request to switch to the DUMMY state (i.e. usb2 only).
With the current code this breaks USB2 when all four SS lanes are used
for DisplayPort AltMode because the -EINVAL is passed all the way back
to the phy_set_mode() call which results in tearing down xhci and dwc3
again.
Let's actually handle that case correctly and also drop the default from
the switch such that we get a compiler warning if another pipehandler
state is ever added and forgotten here.

Reported-by: Paul Cristian <p4ulcristian@gmail.com>
Closes: https://github.com/AsahiLinux/linux/pull/515
Fixes: 8e98ca1e74db ("phy: apple: Add Apple Type-C PHY")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/phy/apple/atc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/apple/atc.c b/drivers/phy/apple/atc.c
index 4156fabad742..a3162f25e6cd 100644
--- a/drivers/phy/apple/atc.c
+++ b/drivers/phy/apple/atc.c
@@ -1121,7 +1121,7 @@ static int atcphy_configure_pipehandler_dummy(struct apple_atcphy *atcphy)
 
 static int atcphy_configure_pipehandler(struct apple_atcphy *atcphy, bool host)
 {
-	int ret;
+	int ret = -EINVAL;
 
 	lockdep_assert_held(&atcphy->lock);
 
@@ -1136,8 +1136,10 @@ static int atcphy_configure_pipehandler(struct apple_atcphy *atcphy, bool host)
 		ret = atcphy_configure_pipehandler_dummy(atcphy);
 		atcphy->pipehandler_up = false;
 		break;
-	default:
-		ret = -EINVAL;
+	case ATCPHY_PIPEHANDLER_STATE_DUMMY:
+		ret = atcphy_configure_pipehandler_dummy(atcphy);
+		atcphy->pipehandler_up = false;
+		break;
 	}
 
 	return ret;

-- 
2.55.0


