Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D141DE0D
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791359176; cv=none; b=SuPsvyYcNZ9trXWxavPRpwVQFeqhcZkrZkUYkP/fl9PLmEA7XEWGLVqOEZ/4+cxG3YCayZ8W2WQd28/6fvZAlbYDR8ai2PtYIobyC0bzEyLUEJP4uAubxqGh+jl6vGcivzOf4leHOLu5MUroscrGsqN/A1J/8hgOWM0VUytZ7rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791359176; c=relaxed/simple;
	bh=RicMOd+9wMEm8pq7sEI1y5uVtY9IypO9dFsFxFOe4mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OxrVIE3eAbiRNxmQJkvKK78WFttztLiwP3IbybYXixMuenRTYdsuLpzNwiJWhuiOBntFlBmcwOVy7WZbJNo1uZ5VY9qkGdUb/ihkY9jGIPXRLGuD3LWk4h5JOUKBGGNfuRRNCfz3osYRz6N8A1oeKgKmpW5jXXVbbCFrAyr1q4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hG7o/mjx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG7o/mjx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1E71F0089B;
	Wed,  7 Oct 2026 07:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791359174;
	bh=TWsXo/12mu17qj53EjXooQpkm6wpbA8gIa84vqNBd0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hG7o/mjxCHiXpp09xaKKF3U8CejEb8Y2/cvPdBpqd/W58CRaOkakijViibojsikuB
	 IbSGPRZ09Pio/U7G6uvlIy/0jQPhc7D7ubsH+TwrdZyhQJuFPjK2oLEecyIAKv01hE
	 GQ0ndWX8Wj4fI6bdER5WbdQ71ISnJ2KXxtKAiIeMTWRQzSncHz7M/jp9FnT5g0emg9
	 fidHfbjcTCzoGH8qdZDG/+QqocbnHau2Xvl71+ppXE+WERzJGiD4ldu2tKiytwRb+E
	 OWMJuh9baMIzACjZ4tLmzvBbZEXbr2i7wOQ0dzAcIUw6bmSoQk5+xF4t0AoBg0IIu7
	 /imlk6vutjl7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pengpeng Hou <hppiscas@163.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: cdc: ad7150: fix OF matching and publish module aliases
Date: Wed,  7 Oct 2026 03:46:11 -0400
Message-ID: <20261007073733.1723086-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100633-unworthy-blubber-b832@gregkh>
References: <2026100633-unworthy-blubber-b832@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pengpeng Hou <hppiscas@163.com>

[ Upstream commit 52da294027f53e7084c18dd4b4f73354a40382f3 ]

The OF match entries use positional initializers, which initialize the
name field rather than compatible. Consequently the advertised AD7150,
AD7151 and AD7156 compatible strings do not describe OF compatible
matches. The table is also not exported for module alias generation.

Use designated compatible initializers and publish the OF table. Keep
the existing I2C ID table and its device-variant selection unchanged.

The issue was found by our static-analysis tool.

Fixes: 89f2d5b080bc ("staging:iio:cdc:ad7150: Add of_match_table")
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: Retained the existing `{}` table terminator formatting instead of upstream’s `{ }`. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/cdc/ad7150.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
index 4c03b9e834b88..0417dffd350a2 100644
--- a/drivers/iio/cdc/ad7150.c
+++ b/drivers/iio/cdc/ad7150.c
@@ -637,11 +637,13 @@ static const struct i2c_device_id ad7150_id[] = {
 MODULE_DEVICE_TABLE(i2c, ad7150_id);
 
 static const struct of_device_id ad7150_of_match[] = {
-	{ "adi,ad7150" },
-	{ "adi,ad7151" },
-	{ "adi,ad7156" },
+	{ .compatible = "adi,ad7150" },
+	{ .compatible = "adi,ad7151" },
+	{ .compatible = "adi,ad7156" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, ad7150_of_match);
+
 static struct i2c_driver ad7150_driver = {
 	.driver = {
 		.name = "ad7150",
-- 
2.53.0

