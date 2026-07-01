Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663001F4631
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 06:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885831; cv=none; b=M6OdicSYilZ0J02VLUWq4RRPWXMSpqTFOiCxWEKDLRI07VyJ48pT1PsXagGeAQMgP34kCT6lXDrGt8lKrKQ5xkvrlMCNwq7L1su7MhDxlRGuc+FDnbWQn1qkW5f9UvCF2+g55d83DOjamx/2itkqyp9UPVgterg2Ydy/ugrxfWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885831; c=relaxed/simple;
	bh=AqLYykDuF6z6eZiwyiw9/ylCp2SxYugA6SqbDLz+8Co=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sFIS9xTD+JzuNBNSEDtoPimmy+xLpARicBtSAEmtXWZn1TxD3ANi9FpbtyBR1a3z+rK/8Qdi9cLKZpEoExBvRgbbZKnlv4UfEtLZr29ToXI4LAnnBqTqASkd2LZ5n/EF4lh9YBVcAf+JhzpaNnnicyIqzAUQCgrezdX+8YnAzY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MmteVcgX; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MmteVcgX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=id
	v7SnmH117tBk1FPQnu3pilVQq3aJscQvIsNJZl7ok=; b=MmteVcgXCajngO1/Sg
	FZGGfeuGSSq/3WBEkAMMuD7i+lP/hAcEtuVjyUYgMjhwC4A+AFRGjrGanLA+QVCA
	3Hto4dyCav8Qo96FZnSVAMTqfNbFzBwEOq4VBmB0+HRsat5l2zAXMimVf0wYkhuh
	UtgYbPCYMZLk8IhGuojaUoygY=
Received: from QD202103290168A.neusoft.internal (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgB3dJu8rURqwlqDFQ--.8129S2;
	Wed, 01 Jul 2026 14:03:42 +0800 (CST)
From: Jianing Li <m13940358460@163.com>
To: m13940358460@163.com
Cc: stable@vger.kernel.org
Subject: [PATCH v2] power: supply: max17040: handle missing status supplier
Date: Wed,  1 Jul 2026 14:03:38 +0800
Message-Id: <20260701060338.957-1-m13940358460@163.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgB3dJu8rURqwlqDFQ--.8129S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF48JFy8Gw45uw43XrWkWFg_yoW8AF1xpa
	98Crn8Gw4UtFyUC34DJa1aka45Ga1jyrWUCrsrC39Iv3W3Xr4vkw1Utr1aqrykJryfZF4x
	KrZaga1fGr43Gr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRSD7xUUUUU=
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbC4B5GgGpErb7XfgAA3s

MAX17040 does not report charger state itself, so the driver forwards
POWER_SUPPLY_PROP_STATUS to a supplier power supply. If no supplier is
registered, power_supply_get_property_from_supplier() returns -ENODEV and
leaves the output value untouched.

max17040_get_property() currently ignores that error and returns success,
so userspace can read an uninitialized status value from the battery power
supply. This happens on systems that use the fuel gauge without a charger
supplier relationship in firmware.

Return POWER_SUPPLY_STATUS_UNKNOWN when no supplier provides STATUS, and
propagate other supplier lookup errors.

Fixes: f4b782af61ae ("power: max17040: pass status property from supplier")
Cc: stable@vger.kernel.org # 6.7+
Signed-off-by: Jianing Li <m13940358460@163.com>
---
Changes in v2:
- Use real name in From and Signed-off-by.
- No code changes.

 drivers/power/supply/max17040_battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 60c38e822b52..bba6d91c9b9b 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -405,7 +405,11 @@ static int max17040_get_property(struct power_supply *psy,
 		val->intval = chip->low_soc_alert;
 		break;
 	case POWER_SUPPLY_PROP_STATUS:
-		power_supply_get_property_from_supplier(psy, psp, val);
+		ret = power_supply_get_property_from_supplier(psy, psp, val);
+		if (ret == -ENODEV)
+			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+		else if (ret)
+			return ret;
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
 		if (!chip->channel_temp)
-- 
2.39.0

