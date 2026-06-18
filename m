Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19BA1DA23
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742715; cv=none; b=LwfXYtVUSK6m2bz1msz28MREkpwURGZnY5yknPs3E7bOYCtHb9+ewqUXi/Y7Vtw0bfY0bBQVcyKf1B0GI3XpC9SegW9c9bQSLUHAYpMRdEv3x0d0t8cHXGHGHEabbT83EVSs2NLAjNGjipRD8Sf5QLCkeZYm4NmaelOoGp1q/8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742715; c=relaxed/simple;
	bh=D1NW5YmPPQMfzcVzV4vCYw0ETpZl9XPtI/MzmVevqDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVD3UE9dmCO+SQuOWx8QOQ8k4d91AdPulWBbcxkbjWXQck4rc1c2i7l8sB+WPm8YAUkZIRhGsYfcEyQ35ztQ1JyockaS0ADFmsqmSsYxhybHWiDvmNU5vXPeucepwfVkKGCK7k5zZ/hS0ezh6XbeNA1DNvGl0oeNV0F2zuy0SI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=C1T2k5en; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="C1T2k5en"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30bd7f4fdffso384067eec.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1781742714; x=1782347514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZO3MqnP/wjIzuZ8p05fEhcMYE2JWwRRB/MCxVfRYXG0=;
        b=C1T2k5enBKxLL76PZ42rvRG+lNRxKL/jMYxkeJxC4E0Zy0zjB9AHyOFmYrShqNCy6R
         IFCLhLc0nq/wGq8IvuiehXNnvuvRgcJ6fTlWkdy49/rhKJwP8wTSEu+wJ9/eY8zG1ctZ
         5L6VBFSbt7XzStdYepIWlxTGUnvMNjto/IIhqB//c2JnIhZv0U3R04tU2K/t7B4WbFH/
         YwsiHmHIfYYJSdYzmIQvncT/jXc2ufBUvKsauLHqLRZlKbz2SMVTlEyUYsZOu75TQGsQ
         SBu1fEu9cNlze1YaLFOuu16zrWZuk8+48Nnx7J0r/58sZmazLLiB/eWA+8zhwQ02KCld
         nY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781742714; x=1782347514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZO3MqnP/wjIzuZ8p05fEhcMYE2JWwRRB/MCxVfRYXG0=;
        b=poZrCk/Zlblbvu5VLSH7MyISkPatYTAKZb/SfuANlFSwT8qSUB1Ekk752QrD08e31p
         2r3dapq5HGOOGWHqb4JY2pZrOv8Ukhk8xaaP1PZEh+0RKraSEcVPBeNOLTzzdk30WHZx
         YHdX7m2anKUURR7jSa77jR/HGPTYuy5LcEjocgIPpktOq+FqdCRF+u0NXGqrqHIbVqb5
         bHPX7YYGEvCrcc0SiXI5pPM0kBfsJzeKRsyUiIT0qkSV9A6e7vCvoRN3GQ4DK7aGWq4a
         h5UkxLHSsU4GgDQx/9swSgB4ArQa1w8hBRAqCrDQkSpaM1GGbWW+F5zYelXvER6pqPhO
         5V1A==
X-Gm-Message-State: AOJu0YyrayonBragvizJjEn9nXxT62+jnWHvK6cMJcilg+wMgxmW+gPx
	JbA+XP4+zP6h3K+hLEM+CcntEyOgJ/cuMt6ZVy6yaYnU7uYd5q2TKj0ae232P2j31AE=
X-Gm-Gg: AfdE7cnHSORAsoukwPAsztsHpiA96xyxn+YaL1UZyhKjJsJMaGHiY7aW4+nr/k9gubs
	ktnqpwsToUQMN/0Zh6RJdeCN4eKwCF25ROudbCL1ec4PZLZJ1hqK2UEmzkSI0QtjCPxVoq2q0Ki
	j4kEDE1WTw5EKwwMmhS/TP3tbyLV1IqFeARRAXK90sblXKtS+SFjbBjbeDOIpMyhpZwvEDaQqao
	DbDst4aE7SNorfS2H4Etq+5srPVNtg7XZvxDclzlyuCDjaDJDL3UZGB9PMWhUWXnOWnTqR3yl8Y
	+XlDmHauWdTO+W+Fm7/gQf4VUu+uLh0uG0UFEbdSFP1dYZSjOGQuzJOO0pBkzBS1FAXAxBWERQ3
	RHa1ri1XVOXIH9QtYwjy6nZbY7CUtpCBljLfzSNuzqE7C8OxrsKVpUVScgUteJAGbHEWiStvFug
	LENxAlDI0UVGBS/76I2sOt7CiffO4we5sEpQ==
X-Received: by 2002:a05:7301:1298:b0:304:cefc:5fd7 with SMTP id 5a478bee46e88-30bca0edb63mr3126816eec.32.1781742713845;
        Wed, 17 Jun 2026 17:31:53 -0700 (PDT)
Received: from cave.us-west-1.nexthop.ai ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm27482611eec.7.2026.06.17.17.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 17:31:53 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: abdurrahman@nexthop.ai
Cc: stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 21/38] hwmon: (pmbus/adm1266) seed timestamp from the real-time clock
Date: Wed, 17 Jun 2026 17:31:11 -0700
Message-ID: <20260618003128.3112824-21-abdurrahman@nexthop.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618003128.3112824-1-abdurrahman@nexthop.ai>
References: <20260618003128.3112824-1-abdurrahman@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit b86095e3d7dcf2bf80c747349a35912a87a85098 upstream.

adm1266_set_rtc() seeds the chip's SET_RTC register from
ktime_get_seconds(), which returns CLOCK_MONOTONIC -- i.e. seconds
since the host last booted, not seconds since the Unix epoch.

The chip stamps that value into every blackbox record it captures.
Userspace reading those timestamps back expects wall-clock seconds:
that's what the SET_RTC frame layout documents (datasheet Rev. D,
Table 84) and what every other consumer of "seconds since epoch"
assumes.  Seeding from CLOCK_MONOTONIC gives blackbox records a
timestamp that is only meaningful within a single boot of the host
and silently resets to small values on every reboot.

Switch to ktime_get_real_seconds() so the seed matches what the
register is documented to hold.

Fixes: 15609d189302 ("hwmon: (pmbus/adm1266) read blackbox")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://lore.kernel.org/r/20260515-adm1266-fixes-v1-1-1c1ea1349cfe@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index a03066f26595..31adbe65e3dd 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -432,7 +432,7 @@ static int adm1266_set_rtc(struct adm1266_data *data)
 	char write_buf[6];
 	int i;
 
-	kt = ktime_get_seconds();
+	kt = ktime_get_real_seconds();
 
 	memset(write_buf, 0, sizeof(write_buf));
 
-- 
2.54.0

