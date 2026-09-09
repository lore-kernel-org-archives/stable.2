Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA9054EEC6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955098; cv=none; b=AKC+Rjgk5/Gtht5Ud+jGQwnP+nolKBGw6WcS9aigswNhWvhq0Q2QaDSYkLikYdqOHrtImIBrSx5QdkBc5p3PCrNbR1tppyvCadt6gcuCV+a4tIjdqAnMpor489XyZjasXg1YJ2dxJj/ZgTXEL01kKw8tfOnkmtmd45mIDF06224=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955098; c=relaxed/simple;
	bh=vtzJfxoVd2j0QHRBO3/CH2SG0NCJnTGAS0yR6sGcO5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozIplvS7Zj8NZmaPmAiptLBhLWD8fbkXrgPNovV9IJ/4j5MhDa26MslaLwe2r40cfhPbF3kifY7ShQEgcadFD/ImskMeIHgQZuL0Ns5ugTTcylnyElMkYphhZ4ixxyDJcSxIhvR41/0P9oZmLlYppBlNzwUuCUEgHWBirxfaW0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaFptSiy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaFptSiy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F701F00A3E;
	Wed,  9 Sep 2026 11:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788955096;
	bh=HPgd0ZKbdw9n5I72Rp2IgogNln8lcPG+ou5lJ8S3qCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SaFptSiyh1Qzx84MC5gB70CuoCeTy0wsjAiOWDY5ts7h25ylmrAzf5wkXsXDTnGyk
	 dZH3UOlvO5R/aXzqizZ3t2OAXS7tMSf4RRCJ0w4JQyAMzNy7pWvyP/tMuiOO/7bDr8
	 m/p8JY+1P90P4omuv7Mcng4ouaM6nZxnvwn0Nm+0VtrzLR/g2abq7xeeI9g8DVzl56
	 RKBmhzsAFsZ8tkl4VAr7x5ClQcMYv4O63yetaorvuK3LGOhY3+3XMQKqKAfyNL0Yot
	 i7leA1tV3OhNdR1stNIcqMH/gBb1sjR1lvRcinrXVq+HxkcG5J+MNHokEvyLxOD/XQ
	 IpmSVq9kqypmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] power: supply: max17040: extend help/description
Date: Wed,  9 Sep 2026 07:58:11 -0400
Message-ID: <20260909115813.2181976-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909115813.2181976-1-sashal@kernel.org>
References: <2026090352-handyman-delegate-c138@gregkh>
 <20260909115813.2181976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

[ Upstream commit 82ab575eb89e4d8c07ab8e693e0b31603a0d202d ]

Reorganize the Kconfig driver description and mention all supported
models.  This helps when choosing drivers for given system.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 659cc3d8d5ef ("power: supply: max17040: propagate register read errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/Kconfig | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 0aa46b4510177..dea1f0c32a0f7 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -366,18 +366,20 @@ config AXP288_FUEL_GAUGE
 	  over/under temperature.
 
 config BATTERY_MAX17040
-	tristate "Maxim MAX17040 Fuel Gauge"
+	tristate "Maxim MAX17040/17041/17043 family Fuel Gauge"
 	depends on I2C
 	select REGMAP_I2C
 	help
-	  Maxim models with ModelGauge are fuel-gauge systems for lithium-ion
-	  (Li+) batteries in handheld and portable equipment, including
-	  max17040, max17041, max17043, max17044, max17048, max17049, max17058,
-	  max17059. It is also included in some batteries like max77836.
+	  Driver supports Maxim fuel-gauge systems for lithium-ion (Li+)
+	  batteries used mainly in handheld and portable equipment.
+	  Supported devices: max17040, max17041, max17043, max17044, max17048,
+	  max17049, max17058, max17059, max77836.
 
 	  Driver supports reporting SOC (State of Charge, i.e capacity),
 	  voltage and configurable low-SOC wakeup interrupt.
 
+	  Driver can be build as a module (max17040_battery).
+
 config BATTERY_MAX17042
 	tristate "Maxim MAX17042/17047/17050/8997/8966 Fuel Gauge"
 	depends on I2C
-- 
2.53.0

