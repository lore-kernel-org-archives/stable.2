Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794740926;
	b=BEjJtpNuhF4k0y3AKDc3PUjKWv6fdPSlgSyOmrJxSPt5qyqW1tb7P6JRyuUVhrCXrbZs
	 T6vEiIDHY/1ngPdYHIUyvojUskrLPW/DDV6KTAj9Veu5sJaCj8eyQ+N9bYYTWGPKJflgk
	 nZQ6XyTHiLJTU1yzhr8XC3sl3tLnBYUR4rt3PT183+2I8nDUw5my6x3YORhxe5w76XBAp
	 7BYVQ48Sa2E4nWVF9HZDrttbztPfKzzjKOCqtjZdDzwO6wea6kaRy12AGovCf0zBydxVU
	 hAd1KfJiB/9/DCQMDgmqFtPfuCGcLaZWmu0R2FLbsD7mmzMsXMcuD0Wq71s9M8FgORg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794740926;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p+Fjjmdi5J4B2FWifS6RftoxIK+iRHp+m6I2lL5hB/0=;
	b=L0OZGiBsscfxMWp2UTO4HMyBUlZVPNNaiCwkBmz/HjEEJEPK79Rzq9z+1lPuU3TYN0BW
	 Ur7rDiW7M/VRSeQ71E5n7rsdFRBO+ah7zz8tS1v6OFzQkkEP5MV17IfX0/CjT2krnPcSr
	 SHqkX5EWOSfifAwLchOLm6ZW6+GOf+uKx4kxXOk2iDsophsiDw9NnluRSuNRrZXa/z4c1
	 T8yZWLsgk9NA8GOAVviOUVTEbXvjJ42ijixgyx1EhqTFehA2YNFD8hVVpe7STDG3TFnb+
	 6QofeU/KKMyaIcLBnu7rvrjsXDa1qLUPvRCAWxCjx1VcI+XtmFUk1wGrRF3XUh9ndfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DmNHNRbH;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35842606A323;
	Sun, 15 Nov 2026 11:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35842606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DmNHNRbH
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC9E8143D;
	Sun, 15 Nov 2026 03:08:42 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D3EB3F632;
	Sun, 15 Nov 2026 03:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794740925; bh=2FbQWd8+1RdCTUXDBA/AQ00/PGxMHoc55uKyePXnWLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DmNHNRbHnQzt3VBNgCI+olJ6UTmkBv1ScBnqVQw+73ClKFd+0gAqE3qeKSaishPDk
	 MFuSkn4Ask6INPqGxkwLbI9sJnwTScojYATQ+D05cJ0aaAF6g4tTe33TIg9HlShEHS
	 qXDWRJ0iYFNW6B38jiPRAS4507J7ak7YkONsH+8E=
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@kernel.org,
	philip.radford@arm.com,
	Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	stable@vger.kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 1/3] powercap: arm_scmi: Fix potential stale zones after a skipped leaf
Date: Sun, 15 Nov 2026 11:05:44 +0000
Message-ID: <20261115110546.2344308-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261115110546.2344308-1-cristian.marussi@arm.com>
References: <20261115110546.2344308-1-cristian.marussi@arm.com>
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

From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>

scmi_zones_register() skips leaf zones that cannot be registered, but
returns the last leaf error when that leaf ends the traversal. Probe
then fails without unregistering the successfully registered zones,
whose private data is device-managed.

Return success after completing the traversal. Keep the existing error
return and full rollback for a failed non-leaf zone.

This issue was found by our static analysis tool under development.

Fixes: 3e767d6850f8 ("powercap: arm_scmi: Remove recursion while parsing zones")
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/powercap/arm_scmi_powercap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index 63a956cf8d2b..e2270476a98c 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -407,6 +407,7 @@ static int scmi_zones_register(struct device *dev,
 							       node);
 		}
 	}
+	ret = 0;
 
 out:
 	kfree(zones_stack);
-- 
2.54.0

