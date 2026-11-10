Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331275;
	b=gGVap9llVoXH1kVPtDEnfkgcLTwb/rTwsD0OvEsWyiwr5K/Xx2IX+OkETrYp96mWye1p
	 OekavY+WQFqiqhApS810C5WHWwsAWBNONJknkjof7jGvqjYQZIDfqkSJ2NGxxLDHCX5dA
	 0Tnf3ok5/TUkczmZdQOuLN6TBNJxNLfCmZvoSNdNKccJKOO5DvOTllW7PY0H8ffvg0Jzq
	 2/WbeCLhScx31jXPL4hQKmDBMMX7x9z0gwIIkFXpA8hMAdczxApLc5l1e99C07uDWeTlY
	 0CaFcyUCWf8L9Ls+PZuPpGDhdHnfUqKoG8gkEwd1OWRuC3aaZlWUBpzvihbruQx6jDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331275;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=njQZGFdRoYvTrafRgWKeXjjvHXLzmD4TVeFb/Ci9zSc=;
	b=UxRr2Vw58nifkTT5me4WoNMJ4VLexgQMo0smLBE1QQMBEisXaNbRNI5vktJmMipEZT5f
	 yY/83xcz8J/Nh3JVo0gk7v2fvyonLNb9p313GKaBk29ZW/u+3L3dVfvrVkhiQTMLtFyFK
	 IG4MGx2APaSmuqDF3HCBvE1n6Su29YecN/lq4oWsYolwq0fJnhzBRO74A9on1/4y9i7fs
	 s08QPdRyUxXPAWS4wwnPUr9dCHUZ7ncEg8B+m/ckZBfjhyiFb1o/YeTjeGwWUL0HKRKe3
	 puN0gwaUb7nzYN+IBcUDdihLFOAurcP4I3GFxaAerRRUfJ43mfuP9U1umDPR9JGSsyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FZNifP0t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1B2606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FZNifP0t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619571F008BE;
	Tue, 10 Nov 2026 17:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331274;
	bh=njQZGFdRoYvTrafRgWKeXjjvHXLzmD4TVeFb/Ci9zSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FZNifP0tiV0SiXHYv6URXYK0u3HdfOkNIsKsQEsujDJa+lkvMuvjOIropHspn5CNv
	 E/IEk2L+xpPbtL1cIfEcWbBFykR60CXMfH6Aya5GaYby0sZ+vVRcA1Q/nvlyWURUwd
	 veTc/IYyuua9+qKqy2TJkFRfTYGLI0wqsdXUzGjgdmgI4b93dxNqnXTJBaxi99btgN
	 89JYcmJ1pyKKcWHErQ1RRYSHTXeYOxV8LsTLeBKzShrI3UGp8+pkqF3LM2ZvpOAjVz
	 mr56+1ppKzcjiCqM5j5QQD0Zuadp76YbOP7PpJuuVgkh1PPbaI9fXHHyt/wjytlc4d
	 luwQeCOzQnSsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/7] power: supply: core: remove opencoded string_lower()
Date: Tue, 10 Nov 2026 12:21:07 -0500
Message-ID: <20261110172014.2622013-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053127-failed-6.6-6bd80f22c764@kernel.org>
References: <20261107053127-failed-6.6-6bd80f22c764@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 0ce51459c8353b2b18ad3a430dbebf29af8b579c ]

string_lower from string_helpers.h can be used to modify the string
in-place. Use it to get rid of the custom str_to_lower().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/r/20230929-power_supply-string_lower-v1-1-3141a2634d53@weissschuh.net
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 6bd80f22c764 ("power: supply: core: Honor supplied-from with CONFIG_OF=y")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/power_supply_sysfs.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index d483a81560ab0..977611e163739 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -15,6 +15,7 @@
 #include <linux/power_supply.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
+#include <linux/string_helpers.h>
 
 #include "power_supply.h"
 
@@ -398,14 +399,6 @@ static const struct attribute_group *power_supply_attr_groups[] = {
 	NULL,
 };
 
-static void str_to_lower(char *str)
-{
-	while (*str) {
-		*str = tolower(*str);
-		str++;
-	}
-}
-
 void power_supply_init_attrs(struct device_type *dev_type)
 {
 	int i;
@@ -420,7 +413,8 @@ void power_supply_init_attrs(struct device_type *dev_type)
 				__func__, i);
 			sprintf(power_supply_attrs[i].attr_name, "_err_%d", i);
 		} else {
-			str_to_lower(power_supply_attrs[i].attr_name);
+			string_lower(power_supply_attrs[i].attr_name,
+				     power_supply_attrs[i].attr_name);
 		}
 
 		attr = &power_supply_attrs[i].dev_attr;
-- 
2.53.0

