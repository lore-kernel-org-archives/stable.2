Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511C4224FA
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 01:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782867998; cv=none; b=gMaLuqC7CXl+6zITPeyHpy+F2LVrchXnsRQUbK3ZZbv02nhqwwYKiJSEbRDvrKN0gkK1e1zFigaf2iOySJTL4S2qqAIfg0Zc/SLrPsh1O5Z09UxLI5/91Xdp3VoVTfqTvFZsHq9MTPf6DJKe12ibi6xI+MyJ9Fn4T3MSH1iesY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782867998; c=relaxed/simple;
	bh=B0OtGF3UG7WFeZojiKUIfi8tdhYzvdLj2aPV+B86UtU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Iv8GZG3s54L1EYb6/J5ER5Ymhg6YeAUYS/tXpD9EZBjDVtU5RPDGjwMUTdCgz1x8XgcQOjZb13EF1zT6f+7vRUd+ggMI+d+9G911efJMuhZUVhtX2iXtrlbaenhedn/EUiep15ydkFGFtLN2X26AYj8U5V6tTfgaRKOupOggZSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HYi8LUAk; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HYi8LUAk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782867988; bh=oWUC5SjRt3QR7F6zWqGGKKRWr47hvrPsFO+LiqcJkP4=;
	h=From:To:Cc:Subject:Date;
	b=HYi8LUAkzURMQzlZ5s+qtUU6V69Jzs2wc6Ghc++dEEA+DFBbLjH1KbIEp6NVyESsq
	 3Ec8UjQuwTPf2oapg0ezC5+x7KUXIsWxAPyf6ugzH7T7qsxc/lVp79/iLFo+Yo7nYF
	 z/JaDXqksw/s2oS1T3YP0k+nk9ok7dNdqnBF6dFw=
Received: from QD202103290168A.neusoft.internal ([218.25.32.210])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 19993892; Wed, 01 Jul 2026 09:06:25 +0800
X-QQ-mid: xmsmtpt1782867985tnslkniuz
Message-ID: <tencent_F13EB0C3525FFC6E0AC25A46636D912FA609@qq.com>
X-QQ-XMAILINFO: N7qqMxIPUfzlnlcTcRU3uhxAAEke8qOBsCQp5CKH3K7xXaDiPrZ15Gk1xjdALt
	 /TvbaZ10lkLj0JZIATXwwfm5osi8uv+U1JYBFXT8Z/j6zHmJVccLRpPCpwqNs7DmBq0ltVS76K4G
	 ZhO/6nf+OpaFQZVAjoqO5fUm4uE9o0buPDsXG+4gon/w8a1vY3FktoLshgJ465rm6Rbk/5wAfX6S
	 iRa2WpgRL5qUxKzkQAI5uBrym1OTtNXrdYdibDMdZn54UWCES/YFnK7OA+XWREbFnxOqJHIOdsWV
	 Tj2XEiTUBwr7sdlvuyDz62m36aMeAvKW2hCHo+RgfjPPlwgK31p7zVN/QhQz2pPsF28TTLtnkbnf
	 OQG6Vv99ZjejsBIu0q3hgFjt/Ld5Hsqcv1tPzl0CR//pmiy0Hn3d7efHI7nQfnEe4pJ6oDGcgfoU
	 MUER/kdpSOHwjaSOWrTtYF+7O9CwQPkwySgT6CCeSlyElkaLj49slSuxK9iIC+crxs0dE7tVKnIy
	 bjuemiRgSX4TdkDTgopoIB5hfK803+Etb4xxuPFk4sB07JoefuLIMNCm13a7poQXoZnnjhQIZjdB
	 oqiHzdF1KrzO1IDOovZMi+fOSqZMhfGPLaVSKk9PvWqxa6KaooMvnc25In1sqK7VDZ8d6xUeXfCJ
	 /LivHhuLMikn/S9XRpogIqeYW/TY11ar8JLL2jPsF1MLAgrpUdhsHvAQ1vqCeOBV3VUkERrw6Ih2
	 x0xvMTfsDuH5IRWrboZY7YI5dqA8tcM27Ey80QM5EISq0mLVz55SYu/Swg4DC188IlVQtDf32+cd
	 G0xeqN/IuZ2GblY15f4eXUpHWPy/5afeEcy5LkllsfkFO+eGjYlSqiBC49/CB3pAlbSe6E4nbfIK
	 R0H/In7ojxiOrBMlCbtlh3q1ogXqFKXFMpksSRLlh0YwXd/n2Sq4PT9O+3CVpjucM4TXkZtsjmkO
	 UypEqPgFJrvNN4IdT5YfOP9KNy153mKhAglpD1R+2jIrc93hbsM4OzVyekotocxYCPDEDawjttGn
	 mgPV0pRHmfOZMEMOO/Qh18aQuDqUGGLmWwg0l4+oW0bYm0xfcLy1gTLOoacVKIt5+JCcnUYFsim1
	 9j9tzOMGmUHxmpVYCMRcqJeGAoQ9D2ZnB+z2lu+2HnO9cu51I=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: mysteryli <929916200@qq.com>
To: 929916200@qq.com
Cc: stable@vger.kernel.org
Subject: [PATCH] power: supply: max17040: handle missing status supplier
Date: Wed,  1 Jul 2026 09:06:22 +0800
X-OQ-MSGID: <20260701010622.571-1-929916200@qq.com>
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

