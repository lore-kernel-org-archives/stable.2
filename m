Received: from mx16.kaspersky-labs.com (mx16.kaspersky-labs.com [5.79.125.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CB638DC65;
	Tue,  4 Aug 2026 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.79.125.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845191; cv=none; b=LNz8ptbAl+EdoLJfj1hZ6pLT2x/GT6Qbe2czLExHTehlV4LoSfoWG1o/wHPITVv5PGsedh8ZMi7lgxlY8ZVAqjmoAIsRPGCZq1DVslQ+fFSGk4cDID2yXGwDZA7lMkrnQLMLxpTWdcRoIbjocPxGRZLKUJ/qxJwVF6MJqcI0+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845191; c=relaxed/simple;
	bh=s/xDRImuDq2rKz0W0t51qUIXAgKj2J1FzpxgeHydw9I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XuXhDPKipwboFdiyyBqOynHMwz2tRwBJvjclAy3glTa2yifBqfhI7gOgHiXhNAOtbzOu3Cj8UxL0+dwCcRuAuTUPO8fonasiSKJieZtwWcKXsIbJAUhM62xcmVn6dU0YL5huzK+T4xYgQQuiyFs4TkwaLnQMA8qQfEfe6P8V2wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=xKLa43Sz; arc=none smtp.client-ip=5.79.125.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="xKLa43Sz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1785845168;
	bh=9+IPCJOp+lCVk8vltzg3r2dhoNSVm+XO+Q7NRrEIaNE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=xKLa43SzXdmtUThQMCxsgG0GEU/vHUeUtx3faw21kxko+mE6ddmoPmaw197TYYaFj
	 HaC2e4KxnSiJHIJ2QeD6oAiOsJd0rYXXhAW3dK8VeirMICUMAx7g1z4ypQ/FuBIFxs
	 caEZF4rh98QKoVjKqdWfwvYLMAPNobwZyVV2dt+8S1NHjZzltqMU/hhPXxMiQ522E7
	 bePqcP9QfKWuWxIbpA6wqNNboIFmGNWA8MVf3Q+10vyoLSTZPpxJTDUE1vaqgrkHoZ
	 Z3CVOQ1Am083WEXgRS7o3+tqOTd2854TlsnFOd+p5VhKp+I9ZzxfDitPR+Dva9XVPV
	 KgT+nVC2tj7fA==
Received: from relay16.kaspersky-labs.com (localhost [127.0.0.1])
	by relay16.kaspersky-labs.com (Postfix) with ESMTP id C9902C084C7;
	Tue,  4 Aug 2026 15:06:08 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub16.kaspersky-labs.com (Postfix) with ESMTPS id 06940C080B5;
	Tue,  4 Aug 2026 15:06:07 +0300 (MSK)
Received: from frolov-se.avp.ru (10.16.49.179) by HQMAILSRV1.avp.ru
 (10.64.57.51) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 4 Aug
 2026 15:05:57 +0300
From: <Sergey.V.Frolov@kaspersky.com>
To: Sunil Goutham <sgoutham@marvell.com>
CC: Geetha sowjanya <gakula@marvell.com>, Ratheesh Kannoth
	<rkannoth@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Bharat
 Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Naveen
 Mamindlapalli <naveenm@marvell.com>, <netdev@vger.kernel.org>, "Sergey V .
 Frolov" <Sergey.V.Frolov@kaspersky.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net v2] net: octeontx2-pf: Fix UB in shift operation
Date: Tue, 4 Aug 2026 15:04:48 +0300
Message-ID: <20260804120446.1955448-1-Sergey.V.Frolov@kaspersky.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV5.avp.ru (10.64.57.55) To HQMAILSRV1.avp.ru
 (10.64.57.51)
X-KSE-ServerInfo: HQMAILSRV1.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 08/04/2026 11:54:41
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 204987 [Aug 04 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.22
X-KSE-AntiSpam-Info: Envelope from: Sergey.V.Frolov@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 113 0.3.113
 b83a27b0bdff87150e3aba5d24ea90b4a220db99
X-KSE-AntiSpam-Info: {date_rfc_vio_soft_silent}
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;frolov-se.avp.ru:5.0.1,7.1.1;kaspersky.com:5.0.1,7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/04/2026 11:57:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/4/2026 11:11:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/08/04 10:25:00 #28645284
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

From: "Sergey V. Frolov" <Sergey.V.Frolov@kaspersky.com>

In function otx2_get_egress_burst_cfg, when the parameter `burst` is
255 and the max mantissa is 255 (0xFFULL), `burst_exp` is set to
`ilog2(255) - 1`, which equals 6.

This results in an unsigned wrap-around when calculating
`(1ULL << (*burst_exp - 7))`, since `*burst_exp - 7` becomes -1,
which makes the shift operand 0xFFFFFFFF. This value is greater than
the width of the left operand.

According to standard 6.5.7 p.3:
"The type of the result is that of the promoted left operand.
If the value of the right operand is negative or is greater than
or equal to the width of the promoted left operand, the behavior
is undefined."

Fix the off-by-one boundary condition.

Add a WARN_ON(*burst_exp < 7) before the else branch as an
explicit safeguard. This ensures that if max_mantissa ever changes
in a way that reintroduces this condition, it will be immediately
caught at runtime rather than silently triggering UB.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e638a83f167e ("octeontx2-pf: TC_MATCHALL egress ratelimiting offload")
Signed-off-by: Sergey V. Frolov <Sergey.V.Frolov@kaspersky.com>
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 40162b08014d..652276cb314c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -53,10 +53,12 @@ static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
 	if (burst) {
 		*burst_exp = ilog2(burst) ? ilog2(burst) - 1 : 0;
 		tmp = burst - rounddown_pow_of_two(burst);
-		if (burst < max_mantissa)
+		if (burst <= max_mantissa) {
 			*burst_mantissa = tmp * 2;
-		else
+		} else {
+			WARN_ON(*burst_exp < 7);
 			*burst_mantissa = tmp / (1ULL << (*burst_exp - 7));
+		}
 	} else {
 		*burst_exp = MAX_BURST_EXPONENT;
 		*burst_mantissa = max_mantissa;
-- 
2.34.1

