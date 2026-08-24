Received: from mo-csw-fb.securemx.jp (mo-csw-fb1121.securemx.jp [210.130.202.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B51A6816
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 03:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787541435; cv=none; b=KgPD7iTdHluvXqJIO70dwcglsxpzrKbVZ9R5vt/ApfcB9c8aAxgRhAPTSdClRzgm++XfFin3qEfHjaAb6uWGkj9ijFBt33mHgj6Qy9YGEi9w3os8nZK9eXWlrY2GcgqqfWyZh62q9J1ajLr1oy1rBM/yUy8tjm4+dt84B78SguI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787541435; c=relaxed/simple;
	bh=zqnCQn344WfwtokSIXyMv68bMIpjpNh0njUxYbLW2Zw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=K9XER3F4FUJuPcSaWH9h+H5ucQwPojZ6JjjY4q2k61ubOdEDLkugJ1/lwQUeGAUPOiVUGJvUHq3+qNST6Ef1OQnNzjYv+gL+TLX4bYxAGYcghhfn9nj49GmfA4rnKBcZTgN4dVkaRjui4t/cbvJlQ53DYQpD0tE1qRgpqL+QQ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba; spf=pass smtp.mailfrom=mail.toshiba; dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b=TYw66tiG; arc=none smtp.client-ip=210.130.202.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b="TYw66tiG"
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1121) id 67O1pALO3161512; Mon, 24 Aug 2026 10:51:10 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1787536250;x=1788745850;bh=zqnCQn344WfwtokSIXyMv68bMIpjpNh0njUxYbLW2Zw=;b=TYw
	66tiGXGDTUtVmhlQYP+rQVhsbqnjGcIWrcDGXQGGuu+t0SVIWyxj/jZHSUU9qR5S9GXVDJyE4wTXH
	F4Gjh6ayfl76UrPJ+89L/Jsm0brbRiB0YQCHEYXW9z5Z/qwBKCmYGK+pZe+Ic4tdTkantfgemhhm7
	ywnQn+nbwbQMiEm33MJjWAcEEa9puR8iExQpcEhwSrz0OfIqgJg/oYVwpZqfEAkIwXPRPfBryPPcO
	kdX4IphKcLV5dsdnIO4BOg9wvK+fMv208hr/bi0u8D7ZmxVsr9pg0oNFsRkoYHSwDfI6znQiYAMaJ
	w4jZXQlvsy2EHnDlYbiknP7qVYtzvIA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 67O1ooB23045017; Mon, 24 Aug 2026 10:50:50 +0900
X-Iguazu-Qid: 2rWhc6LorqQ2onLLnc
X-Iguazu-QSIG: v=2; s=1; t=1787536250; q=2rWhc6LorqQ2onLLnc; m=8D8CNx2YSoJkLn/yrmkZFCZxMgwR/4oq3/3Ld62lGF8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hSv55691Nz4vyw; Mon, 24 Aug 2026 10:50:49 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.12.y] hwmon: (ltc4286) Fix symbol namespace of MODULE_IMPORT_NS()
Date: Mon, 24 Aug 2026 10:50:22 +0900
X-TSB-HOP2: ON
Message-Id: <1787536222-11803-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

In 6.12.y, the namespace specified in MODULE_IMPORT_NS() does not require
a string. This removes the quotes from the namespace name.

Fixes: 7fd4a5682c78 ("hwmon: (ltc4286) Add missing MODULE_IMPORT_NS("PMBUS")")
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/hwmon/pmbus/ltc4286.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/ltc4286.c b/drivers/hwmon/pmbus/ltc4286.c
index 8715d380784a0..98831a927ffa7 100644
--- a/drivers/hwmon/pmbus/ltc4286.c
+++ b/drivers/hwmon/pmbus/ltc4286.c
@@ -173,4 +173,4 @@ module_i2c_driver(ltc4286_driver);
 MODULE_AUTHOR("Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>");
 MODULE_DESCRIPTION("PMBUS driver for LTC4286 and compatibles");
 MODULE_LICENSE("GPL");
-MODULE_IMPORT_NS("PMBUS");
+MODULE_IMPORT_NS(PMBUS);
-- 
2.51.0


