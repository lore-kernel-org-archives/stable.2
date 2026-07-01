Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471A3A0EA5;
	Wed,  1 Jul 2026 06:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782886310; cv=none; b=HlVPAM+P+LqWiAzOR0YQWp23OYWLGjVpOt1iyidrplAEMtf6vMsosjjwERnmKb/TsBUKNxD1fjfnL21TkLitRczcIi3XhgaIx/An449B4gOQUWwA0W6uMdsrFHySqxJGu1qzs/0dkHuaelqejtSIENkV2yCY8MvEkUxxPKu/fVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782886310; c=relaxed/simple;
	bh=AqLYykDuF6z6eZiwyiw9/ylCp2SxYugA6SqbDLz+8Co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HMoCKtdeMfyFTdOVN0bQp6zl4gqx6xiCn0CemBlBFMCHJxxXjUBTB4O97nd5J+yCacObsAT2Id1gntEOpXLEJWgFJ3xJkqaErnrP8BGfVbHDB0euyPqjyM4l7TnhoCiSVouAMDap/iEr1Iv2H32IFFHK8+PwAuqXoel5vkDCQN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qR3vAHS+; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qR3vAHS+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=id
	v7SnmH117tBk1FPQnu3pilVQq3aJscQvIsNJZl7ok=; b=qR3vAHS+tan+e4+5Xg
	K3Daowil8mtqWzQbFqoti34cPrLhQNF42HBzmCpIGfxPAcqT2uMkUzq3l8fYaBgo
	q7SQdpSrIZGO6XLvf2U4AyiO8EADKhZyaHtHCAQEp71lhA+UFzC3LvYFa1X3LUaI
	qhGbgig5sWvfeF/c8Cv8s+gvI=
Received: from QD202103290168A.neusoft.internal (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXBvVur0RqLNZ4Eg--.58121S2;
	Wed, 01 Jul 2026 14:10:56 +0800 (CST)
From: Jianing Li <m13940358460@163.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Iskren Chernev <me@iskren.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matheus Castello <matheus@castello.eng.br>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianing Li <m13940358460@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] power: supply: max17040: handle missing status supplier
Date: Wed,  1 Jul 2026 14:10:42 +0800
Message-Id: <20260701061042.1008-1-m13940358460@163.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <2026070115-equate-shimmy-5f19@gregkh>
References: <2026070115-equate-shimmy-5f19@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDXBvVur0RqLNZ4Eg--.58121S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF48JFy8Gw45uw43XrWkWFg_yoW8AF1xpa
	98Crn8Gw4UtFyUC34DJa1aka45Ga1jyrWUCrsrC39Iv3W3Xr4vkw1Utr1aqrykJryfZF4x
	KrZaga1fGr43Gr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEDUUUUUUUU=
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbC+xCz7WpEr3A3MwAA3A

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

