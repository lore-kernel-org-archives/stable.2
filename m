Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816574;
	b=eT2jFw5mUjuDUmfJWowTeOLjfyHqULHVwYKAyPq+5mxsXQmVFvQDVgzoLUbFmFA4VupP
	 uAuzULyx4EHWaNxlcvNtRe6LmUA+yTgI92tVepePwYAIXC1bsqAZ8GB7/l7AfeOfSNT9H
	 ujOkTGSZ8sZe0iMIPDD4fUa0QR0jT1DZ7HB6/NiZpg0F4q6ruTiK5/fa2uHEWrqr28+IN
	 vYNTwSjYZJD0WNNSdOk8SF9ge0KJmBEJaNbzhqgL8VHJoAEK5qokHyV0RTK0MoDI9e5MW
	 1Rbu8z6RpXp1Lw13/o1iwlp3VWZtqKwoEzFpXPlzqfYAStqK8V7EPnx3IyhOeZYD4bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816574;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jP1jFEmW2aDsf4+xHGpPsvP6TocZZfQ32bStrI+tP/g=;
	b=C3+FX5ZWjHhtU7G+DwF0gUSEoYlNJv3VYsfuMR7wqoAMzcRx9VP+3iyM5AjZavoaktr1
	 IpfXMnH+xgN2QCmQOtjRhn6J7bh+QEWAH9qThPgTrwhv8XQd2gIex2ZQI4vkbtoLVwYab
	 6SXitW06KJ8R3k4VU/fxjlX9qDG4j2Te4Tym1f1ZD7yrT2Wg3UXxQjj3v5lJYIpj/roZ/
	 tYXi61om3Mk7ZnoFD7cPPmX+sZE2t+xItVRZHnZcGT9z7Fl5clH4lPAwqf8OBWniv+4h6
	 5Gxq94xIdcm8TxfXh1/ZOUfd99SY1cjV21dY/L0skR/FzstlLSNryOXTwui08iNE7jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l9uvSM0g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C93C606D2EF;
	Wed,  4 Nov 2026 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l9uvSM0g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4771F000C1;
	Wed,  4 Nov 2026 18:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793816573;
	bh=jP1jFEmW2aDsf4+xHGpPsvP6TocZZfQ32bStrI+tP/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l9uvSM0gpiiPrmTzkB5bbPaDneweWTcKSeQDSOGVhMzgbdfL+/BagVp8mBz3K1ghZ
	 kc4ciUMjFAr0EP2mTzBm5Adq2b8+GW6gbF13v92BN7AXX59lDwOdQ6HwqbCTczCM9v
	 hFrPvmeu9uYOweYcHyphVxp/+l4L877n+F7DD35EUW5fxOeCviiO6P25IYL8PI1mUt
	 sfHeDV0BYwyQ8bmdFjLPWjoPvwxnl2kZ6ewG11FaR2uuW11+JYUkrvEJBrjo7NF/U0
	 GmXRhv4UmaikORJRAvjNVyMRnlMIPpbBGx6iKefRzakGwE0o8VaPjn17y4WTmePdfc
	 NsiDUNV2AJ8KA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Gyungoh Yoo <jack.yoo@maxim-ic.com>,
	Graeme Gregory <gg@slimlogic.co.uk>,
	Eduardo Candelaria <jedu@slimlogic.co.uk>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Stephen Warren <swarren@nvidia.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 09/10] regulator: max8907: Avoid NULL idata dereference in max8907_regulator_probe()
Date: Wed,  4 Nov 2026 18:20:59 +0000
Message-ID: <20261104182148.1176116-10-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261104182148.1176116-1-lee@kernel.org>
References: <20261104182148.1176116-1-lee@kernel.org>
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

When a board does not provide platform data or a Device Tree node for
BBAT, SDBY, or VRTC, idata is NULL in max8907_regulator_probe().  Unlike
the MAX8907_MBATT case above it, the BBAT/SDBY/VRTC case unconditionally
dereferences idata to assign idata->supply_regulator, causing a NULL
pointer dereference during probe.

Check that idata is non-NULL before dereferencing it.

Fixes: ffee19091a4e ("regulator: add MAX8907 driver")
Fixes: 5fc72f57e62e ("regulator: max8907: fix use of possibly NULL idata")
Closes: https://sashiko.dev/#/bug/linux-372cd4b4-65df-47bd-8b31-5a7b416b2f91
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/max8907-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/max8907-regulator.c b/drivers/regulator/max8907-regulator.c
index e59aa7a3ee54..ee7d9b7ef7fc 100644
--- a/drivers/regulator/max8907-regulator.c
+++ b/drivers/regulator/max8907-regulator.c
@@ -331,7 +331,8 @@ static int max8907_regulator_probe(struct platform_device *pdev)
 		case MAX8907_BBAT:
 		case MAX8907_SDBY:
 		case MAX8907_VRTC:
-			idata->supply_regulator = mbatt_rail_name;
+			if (idata)
+				idata->supply_regulator = mbatt_rail_name;
 			break;
 		}
 
-- 
2.56.0.385.gac671c819a-goog

