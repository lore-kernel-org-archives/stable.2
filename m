Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870F224FA
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 01:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782867922; cv=none; b=Ok0EkS748dU7Tnm9SUzeU0LVv84VyspofTPUzzqA2sYb5MIjuMMhH3ZCj8ffvnU5fUZ9ukNRHMYPb8p4EGZmUK9QOPRClc6o2DTzq2gZjfyIEYonsecVHIvdzBAKq2W8p3Qio/ntDIRi4gf2t7X+HZQ286TFsEsXiuKUM2ij3l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782867922; c=relaxed/simple;
	bh=B0OtGF3UG7WFeZojiKUIfi8tdhYzvdLj2aPV+B86UtU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ari0NBQVUZin4EI6RtsqlRzn55rBBdQlavjL3As/1sh3q8RgVXmxE7nm7xwOynZ/mVptBNlHUsEkl7agTFDHMiyMmOhwG1KE33LUxggn688ac07tFOsn16qCnriLuKNRqVAL8EBjGj8mqQ+9dLNPcCXGnRTSC2CKc6PVKlx3Qbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lU/OloCj; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lU/OloCj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782867911; bh=oWUC5SjRt3QR7F6zWqGGKKRWr47hvrPsFO+LiqcJkP4=;
	h=From:To:Cc:Subject:Date;
	b=lU/OloCjLqAuPIvVHoTz9oxngPyFplqOuYJLyeGycRl5S7W98l6BrTKE1vRsK0+9Y
	 IWWdvjfocyktFeSqgIpnZB7XQG3vqViKIYz/NGrRUHULMtTMuEsmLHQKf7gI5JnYlS
	 nImI6Xt/NPBeSTjmJpjpGWu40xQc1Ba/wmOx88QM=
Received: from QD202103290168A.neusoft.internal ([218.25.32.210])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 139A847C; Wed, 01 Jul 2026 09:04:57 +0800
X-QQ-mid: xmsmtpt1782867897txsx8dpp7
Message-ID: <tencent_35D37EF305C12D33B125C8E85312D86DA908@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+Y+SJyZAcTO+RSztLRfdi5AakedT6fqDeIZO/KrZNj/mlZWcx2q
	 z/XR6HnvTz/8RSIUJdkc562ec5W5MrgmJhdvM5KLhBYkRov1Qq6Uflm33u3O+FR+Fz6iQprx7sAw
	 jlYhb2bYmf8sCfIfIBT4W0WzbDaifGwbIuCFwniZuv/02VS5TuzjBRQZcEqCAOS0CWe1wyh/bmwl
	 gj6vNEX/bg415LUERVchCMYP1+b9qa08sod10rPevfHYtj5OX1B4P2MaSlO6BruFE2qy3BOMCAVM
	 Te86Gnrkr+qRCrtI54yiXmlIDy04sOXAC/k63n7XsVnI5ULulZ0olYIVimZUsR6zFZTJQdAJeoeV
	 nPjXI4Jkad9hIQxRz0x1yWXS7QLn3lPip3lCRFnDGj0g7ARbiJRqTCG3rVuz/htKcS5Sgy52F2zN
	 J+ZPWqY0Oky+l78dQfFS6jSQa3ZUgQvIg1bE/GzbUzFcCN5zsjcjwR90LZYZZ9H8AmHrwiyuu13K
	 LCGZzavQhrAYUjCOM0VU8uDCVmA7+0hkvJXI5iqvnZq/zDg9RsrB7w71DX60iU1KMSLDcmBARr93
	 pB9XtqfWnhDM47rBUtBuf4/I8wOkvCJshW5RKgByazsHPkejDQKvaEtTFIGhgZogm0bSkNLHe6ic
	 UNAC1YpVBcCg77NoLnS88P/Dm8R4b50dIM1lsXjivbbWTuqlF81K3DQLUUvXWrmSXJ7O2jxY/fiR
	 Yuu7wRG8kknDRiDv+ROigcW0CCDb2PkWKnqIUCBhCHomMBOLIwhMEK2j5BXHksRMSgNWNGyKzvAc
	 aub6YpZV3JJZUK/3nSP4sm9MrQ8Jk7AitzApLsAofLLWiJhYzgUsnJ4gSkF524aKQflBLi1/5AA5
	 3nQVtLSm1Wp/m6eJJdi4cr/LGNOXK0kviW7fL7wgqJ9Pty9sS/vSgm94fQgD/ylc9C0P46/mxmiN
	 a74Hykou1dNs0cx0DEczNt464ABRmKC2x9CRKDabsG08pEYxJsXaIrVH6evUeUVcTLqDzlcmixGr
	 dmsAv/G9fFoCyiHm0USFK/s7akuW9JX0awdznlvBYDBASXaYa4
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: mysteryli <929916200@qq.com>
To: 929916200@qq.com
Cc: stable@vger.kernel.org
Subject: [PATCH] power: supply: max17040: handle missing status supplier
Date: Wed,  1 Jul 2026 09:04:51 +0800
X-OQ-MSGID: <20260701010451.520-1-929916200@qq.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: mysteryli <929916200@qq.com>
---
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

