Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627023;
	b=bL3t2OvapnHRgOIhBWUHtZl3ETGaEx2gF9JmTmGcmoYMlEHLGUiXawnoVteoF8/aywGX
	 u/fQq861kV0tIqiekTryIr5XX7ci+q6chc164gCEz/SbVTBtqG0FlQFBVncopQRpxmmUp
	 3N1YFlVst9WwO1dqIOQkxCxHJQVDFyrMyd3DG0U2WZSim2pSHae63+1GCfnvREywkwvVc
	 NreKmQkVmO9Qbt5bPdqb3hhoE+BSjT3GaCw9gj0wgBehF69oIeQDfJVqvLdf9K+SZAjyK
	 Yj5FX0nE0GmTD3gEGLatlobvJnFGRGpuRdrJGoqxREP3tZUvoGe78gvYcQz9MQ7EgAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627023;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QciimEVXM+GUgEQggmOeTUHAxRTQOySiKJJRnVPeBoQ=;
	b=ldNR9HWnnrg2k9zvTgdPYNjOBxBoXj+bX5iijbjOvbMTfGsnsRNhugrki+tgAja1JlaW
	 g0DLQeM8dJc5eGf/ZaIHHdVHbXG2l0cmvw7wxltbQYXFP4TFYxMz/GoFKbj1EKKJwaefw
	 mosLAU/WK5xx5Z7NOO9MMbXXf0tu02SHBCldcXfTtMuy8NXRAp5AY8yHHi74odU9lJbEn
	 epeTbtdwSAc1ZP4bIVM2hzTb+63fdhz9/XC5p+Wf3B00vXlm7EBrepMEoHBaxVW5KCT/4
	 l+dZJJDSQakTAVeNJBLlWfXy9jWqnr7tlEJ48SN0ARaZ3G6N/hm6bY5asaIooQvHsYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2b7aSXS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7171B606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2b7aSXS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432371F000C0;
	Wed, 25 Nov 2026 17:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795627022;
	bh=QciimEVXM+GUgEQggmOeTUHAxRTQOySiKJJRnVPeBoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f2b7aSXSQbOc2tiW+kTP9rI4y5evloyXxWCL8McjrkbJuEZr5A4CF+Cabh9viEFf8
	 Z19I4ORg74v9e4EWxNClWzZaKaWUh763qSsIanHW/fme0ul+U1jdGy2roL9y343aJE
	 fPAevmHtbMvh07cXtc1x5711j5ZskK+ZdiNF7Mt+SL1GTh3n0WAUuIyfZzDLQu+ebk
	 0zrR/GyY2DTpZkKn7+qxSJzJVzmt6q07e0uR7QXG0XYKsDidtmSfZ5oKFCsUlqJ2hj
	 hQ+nEYOZpx71IaoMYZzfhzwzylNaY2hUxezt9RpPWtqU4Ds+dWBjwL3jKyn4rkvnny
	 k6x4HiNHFzsHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] watchdog: rz: Discard pm_runtime_put() return values
Date: Wed, 25 Nov 2026 12:16:59 -0500
Message-ID: <20261125171644.939435-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112533-wand-debit-0e45@gregkh>
References: <2026112533-wand-debit-0e45@gregkh>
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

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit f52defa7b830abbba6b26df503ca42c0b2f20abe ]

Failing a watchdog stop due to pm_runtime_put() returning a negative
value is not particularly useful.

Returning an error code from pm_runtime_put() merely means that it has
not queued up a work item to check whether or not the device can be
suspended and there are many perfectly valid situations in which that
can happen, like after writing "on" to the devices' runtime PM "control"
attribute in sysfs for one example.  It also happens when the kernel is
configured with CONFIG_PM unset.

Accordingly, update rzg2l_wdt_stop() and rzv2h_wdt_stop() to simply
discard the return value of pm_runtime_put().

This will facilitate a planned change of the pm_runtime_put() return
type to void in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://patch.msgid.link/3340071.5fSG56mABF@rafael.j.wysocki
Stable-dep-of: ca800e625d18 ("watchdog: rzv2h: Use pm_runtime_put_sync()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/rzg2l_wdt.c | 4 +---
 drivers/watchdog/rzv2h_wdt.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 11bbe48160ec9..0dfa94f48e2b6 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -132,9 +132,7 @@ static int rzg2l_wdt_stop(struct watchdog_device *wdev)
 	if (ret)
 		return ret;
 
-	ret = pm_runtime_put(wdev->parent);
-	if (ret < 0)
-		return ret;
+	pm_runtime_put(wdev->parent);
 
 	return 0;
 }
diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index c29c94f0b6295..2342e29962d23 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -140,9 +140,7 @@ static int rzv2h_wdt_stop(struct watchdog_device *wdev)
 	if (ret)
 		return ret;
 
-	ret = pm_runtime_put(wdev->parent);
-	if (ret < 0)
-		return ret;
+	pm_runtime_put(wdev->parent);
 
 	return 0;
 }
-- 
2.53.0

