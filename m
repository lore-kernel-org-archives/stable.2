Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013076.outbound.protection.outlook.com [52.103.35.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449F732E141;
	Mon,  7 Sep 2026 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788752782; cv=fail; b=X0Z5eD+S2JWS2/GJPsGWvpdre7AkOYSvICmSZyqmYDxDyLob0+HKbLrWcDC3HBUXQ5Jyton/32k3A8YoozAyG54xSYw4pvfDQDN4mOhGSz0Ts68YSUYWYNhZ7ziFygShmJnXuKdsQshDc3pUT6LWT6Myr1uVEVbLBX2mXG12qmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788752782; c=relaxed/simple;
	bh=ObXD/8Br2kdzNunTf+JOsFxTm05s/IK5uOGVFCX7ocQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ehgl1RK9ky0fS1uYmT0huCLKFDvspZr+JvanGXJcxoCgfg+V6GTPt6YrOxtlywi5Jqonjar3UcLEfbF/h5nxKTBJN4ZKUVT7iaY4ARcCJKHXJW7sMHazIxCMfI8Npzsc8lQGnl1ejU/zY8umkbp+Xj6S9lYsZJIb1yqGdEvA8WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=cb/gEIri; arc=fail smtp.client-ip=52.103.35.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="cb/gEIri"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ku3WCSzMHUivm1NS7l0U57BXOk0N+FzDCSRYqJT6ALM36LCEMZ5poRh/UrhVqSYXmq7NUmktcDyuQLFjSDkLc04ydc4xUZ49WBE6l1udH1nlM2osRol/np4TcOR3v9F5Vqsfvb/ihOOoGqARk5TBSMb+tdb8yQQltHHMxgKk5BNmNrF567gpQJyRV0fQz/qJWjQek8jYka9WKkYOs+1qBBPmpsAgLsrNVa6X8quNpw6tgIIJHSDtWxpMISa7LzufW3q+g1KG6suPpK1OsyIS+a/vQ4m+cRV5OxEKuvdvJxOuE5ALRI0fA8ent2bdV7ej4h9AD8CurNyFR0Xo30gECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34a2/qTrYYIlorcZIcMR/N4crlVwDt3d1CGSV92Ec3c=;
 b=IyTIV4W7ZcQGmzF9C8kdvxXBVBHRtBCzzUeUt2PMpU6bhRyfy0ML7yPtVPrfK+gd8JuTG0qnP0J6hAxYwAiDBgdniuFAyOfKrJ+mfKGY2lTcDm3zG5KVC9dYPD+USOs+gmIcV1/uR3Jmo+fK/55kiFm9Syt419VgZ37+TL1OVGOcujmZvG2aCjwAitoi/tkW5TS5piWqbCicoS/KVheKtk112RFQfrmRE6CigoYt4ijpqAR9YNZ172rr4GWZbbY1iA0GQGI/fO0hdvmd4FFU0bT6AiKilFbLbmpX8Z+jJpgWHoUBLksOXZ8SvaZI7qnftpzDJ3lN0+7BLSYDAqsR2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34a2/qTrYYIlorcZIcMR/N4crlVwDt3d1CGSV92Ec3c=;
 b=cb/gEIri4FlBB/uKtndqNMGyWypJe0Xcb7bbFHs+btzCi1eNRMwOXqLFbZAzOdn9gtT+i86Yn1DqtW8IzWSVIapKLIOgFm99ISEZy153ys806rWAl2XqRTOK0dTUdx0YcBQ04j1np3FdjMuCVKCbH5up0ZsVgfsc+gqBSOqtnp+GcW1fwX2USOZpv4wd8jzb4a6Ea19jxu4Ua6rRF7zLNhRMBtmZo54AQC6sgI6q2PiHJplEsp/CEznaImGzsVUmn9IbSth3QUdLxKjSxpGkXIDJP5bKq4StVZS5UKWFSSlXzLC1A6y5/LqW1D/jY4r1KxX7OvBAjIq0hRDZd1atVQ==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by AS4P251MB0846.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:515::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 03:46:18 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 03:46:18 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: loic.poulain@oss.qualcomm.com,
	wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	jeff.johnson@oss.qualcomm.com,
	Aamir Ahmed <elb12345@hotmail.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: wcn36xx: fix heap overread in PTT message response processing
Date: Mon,  7 Sep 2026 03:46:13 +0000
Message-ID:
 <AS8P251MB0001F9300CEC70A883F313DAC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0686.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::18) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260907034613.523101-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|AS4P251MB0846:EE_
X-MS-Office365-Filtering-Correlation-Id: b6698dcc-b0a8-4b57-a2ae-08df0c9292ab
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|55001999006|24021099003|5062599005|5072599009|4140399003|25010399006|19110799012|51005399006|15080799012|12121999013|8060799015|2604032031799003|23021999003|25031999004|37011999003|26104999009|3412199025|440099028|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NCo8sYSfzqka6fdM9tKhuwbI+DHlSHscY3Fx1TAGA6t9ijFLT6S381j/Jev2?=
 =?us-ascii?Q?VycZK7bMh/fbcaYpwxM8WeS4tHrRHNmK/brZ+jb2SIFq2gJ9s0B0IFpNW5Mn?=
 =?us-ascii?Q?pgqRpba7fKCtVpxo6zFn1bdNGc43tFi4OnPe34jZ7FnIYZRZ9ZiABUHEBJUB?=
 =?us-ascii?Q?Z2yJZZrLcDyPgEs7A3N6ms5nTRE+O0v4vlfTgB+2wfu8MZ6pO1nhMUY+ktzV?=
 =?us-ascii?Q?MUDGQ5OGUJ3hXLlsbExl6h8m99+pSc+1CJ8WaF0TdxgoYUv+PnAE0C2hO17x?=
 =?us-ascii?Q?zJ9mj+c7kTLAbUKF4lxYQbDPL8+6ebR7bTpwCRrWyC/7qAJ+wQWe3I44Gl1Q?=
 =?us-ascii?Q?RxZ0h0TfHJCQ3TVjZqhicpkIMKpJHfynDod2/5Z2vXutc9U48ozPo+AD1wkL?=
 =?us-ascii?Q?HHrHtFWt2XjRujXIy5fx9AzjiGWlvofoiIIVwpGy2HlSVEjArZeTfDMfMBDF?=
 =?us-ascii?Q?9Z1H1lMe2GUSsrrvGvjiQFZvXLl9EPh9hzl/921lg9S6bp4Ut/Vs8ShaGwm+?=
 =?us-ascii?Q?Uun4i280TspmhCTUZJZIXkx9IlLaZCVF/bBvWZ6hqWJ0S+XW9h3iOZu2yzdD?=
 =?us-ascii?Q?pH4LmwV9pXVExwOrPJAUej2j5C59+ugvLdlq20QAw+I8FwwMOIM6EmiW/2fe?=
 =?us-ascii?Q?e5NJCqe1EoXyGhnoxf/K7yXTgRVlVLbOYN+SRq2ypLH36tETjxOxP2phGpoY?=
 =?us-ascii?Q?7ngpKqEiPK/2inRkQAREu++Quy5jNOf1dUJOyjgn1QVy4MjcYJ+FbS/aaVwM?=
 =?us-ascii?Q?SM9ttnK2taKvpEMMwjiFJKhaNdcVlkRy3hYsCT+zfIB52toV3lnO7kiHvt/I?=
 =?us-ascii?Q?bbUoN0TdAApbiQogTUV6w0wqIoQ+UfUvWSUci6XgaeTMsomD+mkbBGNKAV4A?=
 =?us-ascii?Q?MUSRZsQzTZ2uleTV/6p8sBfKyMoyfCp1JNLomv/mmx9giAt1FkLEn0ZpJoAI?=
 =?us-ascii?Q?YLxkEuJ8gUJlSf/7nxnEgc7slF7PPF5Cu94zyRhrHxvetMN559irN+6WUDce?=
 =?us-ascii?Q?CmEpaCO1fQzXIRetNj+Zcup32S/ABoKzARMR1gCbVbEcb7yuuE3PUYZETw2l?=
 =?us-ascii?Q?a23cVW1M3cECX2w7vECw6eUxRpAU+mflJrx7z16qDHDfChjm3NYChgR4cGdp?=
 =?us-ascii?Q?/vDpIuwC5gSi/ep4wFRzl/V/rVV4OEqs81u8IGQsDjmVoAt7Ydq8GkzNtJvt?=
 =?us-ascii?Q?PR/dWgP1ArZEvyPZAonN7HJI+G/P1j9GNeTCaw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HezosgKv0LDbz/9IHP18Zb4BF30MD3vn+Mo8kIaNLh0rRMjXzb982ItuSpKq?=
 =?us-ascii?Q?QkhJzTM2vvMaMlELsAM2mWhwkvaGaQkjhVHmw7rVXWnDYtbbbjzdy2E4ri/e?=
 =?us-ascii?Q?+5blBe+ysmzfhttI1bjvVxjsumUOGfWsozG8XnleEpZVko8/6SDYLybkwI3K?=
 =?us-ascii?Q?YmDqWMCUUJ0jkcR5t5P+6KpRGz+UnPVaUnjcNAHI3iz+C4BAya/bj6R13Srg?=
 =?us-ascii?Q?vSRNj5XMV0VIAR4zvvGlNypLceTsQ9T7hpELh7uXyn7KYwU4tBeXdszNJxMv?=
 =?us-ascii?Q?sd6VgJsYGIzsIUgLRSl8lhVQsPxiJQ5nG6BPq/RtTMamH9MXQxEzAb5QYFBb?=
 =?us-ascii?Q?pvQGIs2c1hf4OEUzajqz3R86kXAK1ag9HzxfPJGnGYPbYqnwoZtOxR0d6ZQJ?=
 =?us-ascii?Q?JIMCVbnT8Z1CUdFL4EXmZS8YugaJh3U6l5kDyKtwSx5OV5kKQbuT5GRfwG4i?=
 =?us-ascii?Q?8qXxNvQWgn9dCzduJJuQl95G8dtOu17KnAc6/sIkDge6PL6+gsUzSQri16cr?=
 =?us-ascii?Q?2yQQ3wk1MNiMZCAX6BUIzqxPgBIJOerN66pUgA+bxPyXFZCyD+BHTucqd5X9?=
 =?us-ascii?Q?w9Ao/KybHKr5d+8zij9JFdZqtc0leGGJ/uMxEVUBZoiEBZGx/6jScssO8whI?=
 =?us-ascii?Q?akM8vDj9Q3LmSD+pjJJhYdvpUh7fvwSrbowvzA5EfsnsBpHdE2wn/uJd8fZr?=
 =?us-ascii?Q?01S3CTSiC8PqrllvqWNoC+I7+EnbfZAjSFnxZE06eS60hRNCSZholPTkpJgU?=
 =?us-ascii?Q?tZMIfbhBvQ5GiF/HhfD8ldXQPACnIzckN4IU8mVXk6eLFsjhj2Hb/UtdWT59?=
 =?us-ascii?Q?FLScJAKpvbOZbVhK9csguZpI5L4Gx0WUcltRUhphusW0tvxDBGWwpYG74NFV?=
 =?us-ascii?Q?EtaIRyR8GasMgnK0aBX39ONohvHqjSB5yuKrbd1oextvDxofRVk1vKGe14F/?=
 =?us-ascii?Q?5LcsQC9jrb40vUtuECfsMsNyQ0enFkrBz62uVK9+zwaFZeVSMXUvbfj5xTff?=
 =?us-ascii?Q?BfChoimGZLDWgaU3sygCyQZ0BGiPzkoK9jBqN+DIvl1SBgANLyv8lhZlPVnt?=
 =?us-ascii?Q?1gQPL6Nr2yxyUK0Z4aSwWygPbK4suqAhPLHl/3OC42KbcgIHnihCAIaNq0UE?=
 =?us-ascii?Q?8e4ReSlNV4PgZ6IfBaMhSvRAT53WK3UYXhGxNUA1yJruFq1z+5PeMEiRROwQ?=
 =?us-ascii?Q?zymkMvINJVZfj1m+SDqT0rWuOp6mTRV9HjT1Pmoc2yJ6sFFhh/VF02pPzWWe?=
 =?us-ascii?Q?TqCTeHwLb+N6M/15244AApW8NDHmG3F3X96ZYiKGQXPhk0Rgz2JyUgYIhSG9?=
 =?us-ascii?Q?HXIBkJlXTuqF2XZVkBbFnDUAuACnpMmxOoerNfgyjlBIIqdmKfZiJU+CoLTY?=
 =?us-ascii?Q?90oJd1jNdTw9OwOogoqwPI48e5aS2fgDImWP9M3SYwA8Ni1BI2tC+fCkL62p?=
 =?us-ascii?Q?gQcMxTYLv1RK978cyPRzbFgs7q9YGNZZ?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b6698dcc-b0a8-4b57-a2ae-08df0c9292ab
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 03:46:18.0372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P251MB0846

wcn36xx_smd_process_ptt_msg_rsp() uses rsp->header.len (firmware-reported
total message length including the header) as the kmemdup size when
copying the PTT message payload.  Since the copy starts at rsp->ptt_msg,
which is at offset sizeof(*rsp) (12 bytes) within the response buffer,
this reads 12 bytes beyond the actual message data.

The debug dump has a similar issue: it uses rsp->header.len minus only
sizeof(ptt_msg_resp_status) (4 bytes), reading 8 bytes past the data.

Both cases read stale data from the hal_buf (a 4096-byte heap buffer),
and kmemdup returns it to the testmode caller which passes it to
userspace via netlink, constituting an information leak.

Fix by computing the PTT payload length from the verified buffer length
rather than trusting the firmware-reported header.len field, and add an
explicit check that the buffer is large enough for the response header.

Fixes: 87f825e6e246 ("wcn36xx: Add support for Factory Test Mode (FTM)")
Cc: stable@vger.kernel.org
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index c0b477345832..d8597bc112f0 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1066,21 +1066,26 @@ static int wcn36xx_smd_process_ptt_msg_rsp(void *buf, size_t len,
 					   void **p_ptt_rsp_msg)
 {
 	struct wcn36xx_hal_process_ptt_msg_rsp_msg *rsp;
+	size_t ptt_msg_len;
 	int ret;
 
 	ret = wcn36xx_smd_rsp_status_check(buf, len);
 	if (ret)
 		return ret;
 
+	if (len < sizeof(*rsp))
+		return -EIO;
+
 	rsp = buf;
+	ptt_msg_len = len - sizeof(*rsp);
 
-	wcn36xx_dbg(WCN36XX_DBG_HAL, "process ptt msg responded with length %d\n",
-		    rsp->header.len);
+	wcn36xx_dbg(WCN36XX_DBG_HAL, "process ptt msg responded with length %zu\n",
+		    ptt_msg_len);
 	wcn36xx_dbg_dump(WCN36XX_DBG_HAL_DUMP, "HAL_PTT_MSG_RSP:", rsp->ptt_msg,
-			 rsp->header.len - sizeof(rsp->ptt_msg_resp_status));
+			 ptt_msg_len);
 
-	if (rsp->header.len > 0) {
-		*p_ptt_rsp_msg = kmemdup(rsp->ptt_msg, rsp->header.len,
+	if (ptt_msg_len > 0) {
+		*p_ptt_rsp_msg = kmemdup(rsp->ptt_msg, ptt_msg_len,
 					 GFP_ATOMIC);
 		if (!*p_ptt_rsp_msg)
 			return -ENOMEM;
-- 
2.43.0

