Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010003.outbound.protection.outlook.com [52.103.33.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1E13BED38;
	Sun,  6 Sep 2026 23:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788737871; cv=fail; b=eTLa5ANZWj2nCUo41OFVMJjnLzxvbhnqdZqps+/0kEYYDyL0fASMAoOZEAoehpIXDjHdV2qEHODQ1Ho5v6A3IteG8Hcr/VuS90QbkP7iDhxlpJHm9UfIBi9/UB/iddvtBqPPDQkmVUhD2UPLTRdywPnut+SyrcX91bTLNTc7Su8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788737871; c=relaxed/simple;
	bh=hE9m2QMjY55YuZlMvWIkPkd+HbTqVKppXkH+NccpJ2g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=C8PKZcrP2vtfM0fgI57wBvBBtH8BagkCKO2NqwGEM9aNSv46lx8xAwPfS5y64ansrwDrrjYuaETj8MeQDA7BbSW3PkTwYqwZaZk3BkF7GRKXS5VwdFAp9ucSCk1AjCfZbnW+uEU0rq1mnD6fCkELvldFkTh/w1lyDn0DO/EyVW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=ErI8+p5d; arc=fail smtp.client-ip=52.103.33.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="ErI8+p5d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cO6wawMP4pnylHF8Vtb+Lx+xoS9wWKatdEB0nh8sUhW03gx7Q+Nk5K1BeRKJppuY9Yir6OwuZW5YQb7JoZviSlcMSvLx537kW4LGLaHeTDh72YHb2bsIEatsN2UuRz3QWb/gL4G5TwuoR8DJi67vV1df5CANfn0xYfSDLslloKia1QMUEQJj+yi6afWo9tjLC6pF/PK3LeqlzOxWJ0PhpMrFznOLImUyoQbU7VUYuBugCj91YtKepF5Sge1TF2wjFQ9W+BfbhQFzGVr7WZx207ABfwzeoPp3PnyP+fRL8XVpgPHvcVAO5tzInSnq0DSdl+Xq2eP5vg35YVGF/VAX7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCf2zFSQIc6H5nvZZC6lURgwCMF24U9JiBKPGSnlBvM=;
 b=DOGNeMm4YtVVQI8ro4g/903kpwSchOI0ST9DZcb4pXlYs/VLJkhColEs1yXGFKkTpuVR1zlKu+NpNgxIcwh+Dbnl6OpP9t6g2/R8akl4qcIu9jlRqvRCcGLp5UyJDxSU9v8qRxwgQ7G/b3HW5b/dXVhol4SFoxrA0oKvfRpSJBSOgX1NAx/yWOYwgXYakW1s7qdskF5TbCJItOcCVFPC4DbsnMTdAcEYCselYSTugpSXyVxy6KjqZSuHWj50pPhakou08NemQozZyrO10Al/ZAynfxxynlCR5IA8AhJUYY4jAnp+iSPhX6+kSNIUMN+fVALVUWSIaPsCL83LtHz+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCf2zFSQIc6H5nvZZC6lURgwCMF24U9JiBKPGSnlBvM=;
 b=ErI8+p5dHOPIlfQAWfiav/X5hI+ng59/4bdUFDC7DArWfVyWXgjtAjPfGx+xmWGMEq7qt97pXQRQtUgQt3ocozzfYhxaMKr2UICtWojkHjfYSwELBRMKbhWxQjxiZQc1IDCOc0KTj60yOLtV15UG+aPapZpibEG4lC9mgXo22fbHC7BkhtUC5Qbb1BqVUAk5OvuzjEeZHOn1zigu4I9xLAQsiUymSFUjPjtfL8qO2pyzseBxMCKsYCFMFjJsI9EyRNT7jEGwVQSN6PBA7nDJOKs5jRodRWIieF/bzF5AHM/+twT8zV+j/8Qol326BhO5+yjHTK8DUphEPDCnf9dx4w==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PAXP251MB0113.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 23:37:47 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 23:37:47 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: eir: validate service data length before reading UUID
Date: Mon,  7 Sep 2026 00:37:43 +0100
Message-ID:
 <AS8P251MB00013029B476B1D2E05DF190C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::14) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260906233743.87762-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PAXP251MB0113:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c7d607d-cf67-48bd-f4aa-08df0c6fdb22
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|5062599005|5072599009|4140399003|15080799012|25010399006|23021999003|25031999004|37011999003|19110799012|8060799015|12121999013|440099028|3412199025|26104999009|52005399003|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/UN/orwN7KQvW3TtE69BpmIb9JJl7yaA0mzGk4f0DcDC1XvfgLX5NOoilID8?=
 =?us-ascii?Q?IRvRMCryEimf/AIajyabizb7UP5QI+IUqIldwB0ZfDzcc6CDU/j/k0XeKdXI?=
 =?us-ascii?Q?Y3+v9KHbRiDi+CnXKsm0F4zwA0pwFMOGmxQ0bszYS00ubEyabvyjmQNOIHQd?=
 =?us-ascii?Q?NCAg5svgx/fcQEs1Mm/MnTfgXj7V10vEYucghQEYAt71dFXX0yK4OtYO+eU1?=
 =?us-ascii?Q?2yaSKxjoZVdC5YaqqPrsT4Hyz6mXdRA0+dhDWUU7roNW8653aM6sUgEMwHoJ?=
 =?us-ascii?Q?1Fj3C2X3yKkHheyRH2piNAawx2ef+h1C6AmCAWwGCUk6bTDADX6SJ/PGxDLT?=
 =?us-ascii?Q?E5hT+GsDpdDM3F33MGe9KowlJK41R4CSpyKdUczlhHt6bEkN78MrzhYBy8AQ?=
 =?us-ascii?Q?gdZ/APJgyPfVpxzSy3gcbKb/jt+ScQnoEsOYYarLK6a16fLIN7FqnBMYovfz?=
 =?us-ascii?Q?ifq7/BRNfmQsyBaBWGzq2a7HhcfdJ7cZl8Hq3w7ROyI1OMRqe0u70jB15SmO?=
 =?us-ascii?Q?RwfY68gftTdfcayLJuaj3FRXk+JjzlJ0lgmB275SoNz0s69B/Nr6b2XwMC4U?=
 =?us-ascii?Q?+evnPBcTBbuZxgdDE8Tae/QEXpJOgAtPxRPG4bYdFQRv2hFElkVavGFKI5In?=
 =?us-ascii?Q?YwKtyP9cNonOK+24eFWCV/BHsEFEpybiZaS3l4DKiew901uZq85xQVzNrGiw?=
 =?us-ascii?Q?lWsa5cF50Ms/FvhMzL7szvQXqSKmB1q+36lxPvkEp1InWYdtN8g5zqhXkh2B?=
 =?us-ascii?Q?6qZDoUO8bcVpRQLZ/+lCJ0kkNSvH+5XLmWMaD8za9kT5zDKqzJzlYefMgAyw?=
 =?us-ascii?Q?Kf1/IrYKydG8HSdGjT9sQy/E8sig5gi9/kVGQHNb05pTNBEHifZoeVVAFY/F?=
 =?us-ascii?Q?OKVC3DDhdtDPJBIg9rBrddYFfLZh2OtuARGJvyIJTZniX/Nz0/j9j0InTML6?=
 =?us-ascii?Q?TVzOG4utZrSCXFNAF5H7uYOnOg2BjQ7OeqNmBfTL+Dyb8QYR+uQYLphr5hx1?=
 =?us-ascii?Q?hf3O1bgjri8MHZA2+CGs3P4E77k3MlZjlkdhrzUQhep4F737t2UyGGkpoOyz?=
 =?us-ascii?Q?TTIZ1n1P3PKkJCKYfF2a+lU0Y80UzbUXXd8CtU4h/glkOAylJxU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K7GvoohbltinpRq89pe+1op2cWnOzf1HY2HXJ/0sqfWDDGDDnhkfOvYE2yGp?=
 =?us-ascii?Q?k1jbVIypuPRgFH1UjVFGOQWGhJbTc9QQQK5u9Tr4DaG2RlnMWmekZpe1A3vj?=
 =?us-ascii?Q?nNv67j+T1gGL728CrF26KyRY65ymv+6m2LMBnD0iLXYnv74sc28PCswwgvXT?=
 =?us-ascii?Q?UuCgh1yiSZb/ZkiEjNyc6TZZ0YXOQAzx0TRc2txMOcPCDlCJvj4tFVh9MdWr?=
 =?us-ascii?Q?P5SvmO2HBCFm2QauoLvERjAt3goaSZx8AJGP8BdZASOdXWgxPDPOo6Y6zI2E?=
 =?us-ascii?Q?rNg7IK+CrcYxll42TlpTQFEnVCSkHa2mnI05rTSF5QL28x1RIIiuSyG6LVd/?=
 =?us-ascii?Q?fCvwyudXmFdFRpBtB9sn5e3gVr2RLDo3GA1lKx/eKGZU09xfx5Ivrx2cgFb3?=
 =?us-ascii?Q?10Q5KKfsQ2t1q5KkLu30+LdcA4xX5Wlvw/1ibLRV24dXMdNO2baVt3P932Yy?=
 =?us-ascii?Q?7JyF1UZG0Ddz7xSw8EeP9hBXbYNysfjDnk9rU4ZcjxOrfR/ff1BtA9zlYcZ1?=
 =?us-ascii?Q?BVE8x3Bau7DHcNysDrOT+PrlVVTGurzRY27uBWLZy5uBt+s/ex0CI6Lo9U3E?=
 =?us-ascii?Q?s9whPvPbNOko+u6XHj3l++/5qA6lM1/U8fWPRFlztUfawAyeHHNjtZDXttqi?=
 =?us-ascii?Q?dtxBDR5qvjkqdZYbQpJWp4mOn68LYqCa1vl2NMFdB0KixL3CXU9quTuWqqXf?=
 =?us-ascii?Q?dJMaapW6N/nWnpNHUuUuCkI8Zp9WbtuvoGXgIAiW0pqbkhCJseQNo8PDYgBx?=
 =?us-ascii?Q?DpKRXOMaZANwlvk+ehv2X8aN69qjr0SvollGFHB0FADGLjfwIGn/9rgJN3pR?=
 =?us-ascii?Q?oo2lEIw8vcZ5sg5lUPGq1OjgYzftslQKXtXKGrYuH9JCquIsIqxgW2KOBG+d?=
 =?us-ascii?Q?hh4TT5S0Ce3nHHJxzqHbRmGJlEqY0BvTIDDvkJFSbx20wLqYXs3xWgRBY6HX?=
 =?us-ascii?Q?iFsZ6Tx1xstMBKHdIclR7P9a+rOm2lxTok2G6Y+UJsLxk0kqza0ZeABzW0yc?=
 =?us-ascii?Q?zEIoyVX4pzUihcslx/4qpsILvX0z+s8UbR7KCKmvzXkW9TXmFetjPzBnC8iW?=
 =?us-ascii?Q?G/OCZuDMv2iaI72tenI5IWv+z0MsLwaWOJg8W6xClF4ZbVDSARRWSXSOvVNQ?=
 =?us-ascii?Q?ykzQVS7iH558kaW42IsdsY9Y2QRmpp5LuApA2f+MxtwwIQtKupM2gP41ElJ6?=
 =?us-ascii?Q?Oq7KE+Wa88+/adiW+k7Iqa3KKkEhRnbDd6Ku9T5Jtmw7gJX3O/OtrOw1S71R?=
 =?us-ascii?Q?J9OiKBxvfiGxGwvufZokNwbyrD3Y/SsIuBxeWD5Nf2eU8P9/PsrOxvH1s4LN?=
 =?us-ascii?Q?iyjBDXM+TyUx1QwPMqOsc0VWIs0ZFIe4BRqmIRMW+1tIRslocHDsQBeH+Bly?=
 =?us-ascii?Q?Kb1wfU8s9wAxS2YMMQoGfp7b0CGBOgg2N4iRVBpbdKRBbflu2M++W9RtN94Y?=
 =?us-ascii?Q?Pb3seEqn85af0O8xrXJGMUDtL2BFJsVm?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7d607d-cf67-48bd-f4aa-08df0c6fdb22
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 23:37:47.0007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0113

eir_get_service_data() reads a 16-bit UUID from the service data using
get_unaligned_le16() without first checking that the data is long enough
to hold a UUID16 (2 bytes). If a malformed EIR entry has a service data
field with only 1 byte of payload (field_len=2), eir_get_data() returns
dlen=1. The subsequent get_unaligned_le16() then reads 1 byte past the
field boundary.

Additionally, if the corrupted UUID happens to match, the length
calculation "dlen - 2" underflows to SIZE_MAX since dlen is size_t.
Current callers either pass NULL for the length parameter or bounds-check
the returned length, but future callers may not.

Add a check that dlen >= sizeof(u16) and skip fields that are too short
to contain a valid UUID16.

Fixes: 8f9ae5b3ae80 ("Bluetooth: eir: Add helpers for managing service data")
Cc: stable@vger.kernel.org
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
 net/bluetooth/eir.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index a55696820b22..ee0136bfae40 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -373,7 +373,15 @@ void *eir_get_service_data(u8 *eir, size_t eir_len, u16 uuid, size_t *len)
 	size_t dlen;
 
 	while ((eir = eir_get_data(eir, eir_len, EIR_SERVICE_DATA, &dlen))) {
-		u16 value = get_unaligned_le16(eir);
+		u16 value;
+
+		if (dlen < sizeof(value)) {
+			eir += dlen;
+			eir_len = eir_end - eir;
+			continue;
+		}
+
+		value = get_unaligned_le16(eir);
 
 		if (uuid == value) {
 			if (len)
-- 
2.43.0

