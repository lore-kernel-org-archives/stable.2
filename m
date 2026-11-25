Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626453;
	b=l/WvqHhwJtTylvExjFmKmoGiD1Yln1nkm9120NZwXy5wVa+Da3e3V8UxbEHCkiJX0z04
	 lHiyyG5+FVwHaO1KzQCuKJ2i09yc/bPXueT2J7zkcUr9AnNydNa6fAWnki2rTiw/9OK6p
	 Mdf8IvyR0EtbHGKJWztTk+UlUxz0sMhafb7sAn0qo/IhuKyVIYyNA5cr+EwQCocDVN+md
	 D/mRcEGsO5xsvZc+P36VRUl6T2W7sqzvE+M1dx5vaRVa9YVMU1Cmqjl6GTrUXOG4vVpFF
	 hOLgGoeUDewdYUqB8WNbdzjHElm0ZW3iL6C6n9jeN9kNdeaiK14AyupYE15sGpVrYBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626453;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yEqniRpAI1nZOd1Ys3re+PYSYYXFi3BsPN9fy54suto=;
	b=cymreGk6+QzSlOPtIv9JbFO0fh/WAYmfgXRDHr2ARUPajNfofKPAIPlhlUtD3XKgNRSI
	 dd0u2GbYaEIIS0amguM3NXu1yJxznSGTZe1/0xGYtVJnk5yg9OSJydYuaYkYgKal2vmJ4
	 k7QoozaHYQdySg/YKxHYpXtIYtcXE24VsZwPhLeL22eQWObCWIG5D47JLrjURKjJcTFpv
	 9rLLduiI8uBzKGjMoRZulMUZZl2A8C+M8ryHa1f4GzU57zDFXBpEgVpC7JDuLyCPnk/1e
	 z3cIsvT6fNdJTaOjFpS6ZsofgA07q2SSA9P/JarsjwNqmb1JudPyrMZf0OeFIBGJbEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhZNlFu6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B19E606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhZNlFu6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C38A1F000C6;
	Wed, 25 Nov 2026 17:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626452;
	bh=yEqniRpAI1nZOd1Ys3re+PYSYYXFi3BsPN9fy54suto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mhZNlFu6O5qLwx1UCFXb3pEKWf8sPx3zrXydK/aJSzsN3uzz00Com11aHV05Zel4Z
	 zH2gomkXLzUjbdnT0sUd1EQazbxiFWHViz7VKCJN474oBtnAmaa/DzwReLY/INwE8d
	 Fw2MjJ4poQ5InKhS1mLHXocnoJAREz/Jt2L8Y1Al9jmW+2PAVufK5egumXD3gyl29q
	 Rv89ijnQ3sNPyzdC6dHGedLTRk0Jg49O/WYZtidIWivU8nAXBlB1hu9jKeB7gUK3sy
	 EZZ5Yp5DM/bjS9A0uc9a48lhugrNgFjdp2j47ktsR+a/BjNzE/QQchFYdMlHuR9QFY
	 4vOV9tlQ7k3Lw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] watchdog: rz: Discard pm_runtime_put() return values
Date: Wed, 25 Nov 2026 12:07:29 -0500
Message-ID: <20261125170724.923268-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112533-carton-removal-6b77@gregkh>
References: <2026112533-carton-removal-6b77@gregkh>
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
index 1c9aa366d0a0e..509f9dffdacde 100644
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
index a1698dc50acd6..83540dd9a37b6 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -174,9 +174,7 @@ static int rzv2h_wdt_stop(struct watchdog_device *wdev)
 	if (priv->of_data->wdtdcr)
 		rzt2h_wdt_wdtdcr_count_stop(priv);
 
-	ret = pm_runtime_put(wdev->parent);
-	if (ret < 0)
-		return ret;
+	pm_runtime_put(wdev->parent);
 
 	return 0;
 }
-- 
2.53.0

