Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19011030.outbound.protection.outlook.com [52.103.32.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CC2331EB0;
	Sun,  6 Sep 2026 23:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788738160; cv=fail; b=EJAR3AxsbWmqq/vI237HZ87rX4G5pyCzpayG+CG8mgZ3TerxgIxRE/KsPTZc8D0L1UlsoVgAc0C+k2CkNyFTFVCJdtDsDtAHaHM1G1ybHN/fqOCT5EVlaDzR8WWYKQq7Emhu5H3XZ03j95pKBataHFI8Es5uY4S9pPkrJkzc0V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788738160; c=relaxed/simple;
	bh=66OXOUPU4lFZJnugzfM3gOQ14Xp+3HXIqQ3pZb2OuCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Guj8OgXPmzAxPSjuXy4MkotYOiM7PgZhL+NWnEx+Eif5AYtC2mU79bhOsuR0fK/Y2ZMy+rKeBp+NDN2U4Q7fwMIs99k5m9FNh40Yu42j81UgThtmj8tfCWzuYvjzyGx1DsoBBuRuK6in3vXMBBBhGa2vR0no1om5zbJ7T0eSlLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=s45Fsg0A; arc=fail smtp.client-ip=52.103.32.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="s45Fsg0A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPQDY33Rx6dki+4YpfM2hsQ4pfv4luifLg0aH8FqELRL4KhFL0AG2jLFheb20LWqi4f/dK8froy+cx/H3RIkyrZdIhF8/l14LJ2FVe1mtFkgSXkgzAN/QiF7bFOcZPyxzIRlwLTZXkkfJK4Ftxr52edv+15zvJC/neiamUdn2KY+K6MR97kyOcbIk8HA8zpHml5/RnlfN7Z9HbnWMn915vm68fkT2YNLsnE0jiOlEvie4tddz1Qm7rTZ00oj/EOizjkW2NgPwILFscH72S+zT4yI0ftET136ZFNFk09P2TM+4fuRts+I5APsxH5M1rP4MCutydjkJBuJ3OobynKoXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpwjOm7cOOYQQ/rlKmqGw0OIQL6HxXm59Ycs0PNkh/o=;
 b=pt0JsA61ROKLx83XF8r5W8d3K73TM+ITs6bLWw3236AnsfGqRte/ed9k+FckyUK115nK/l2+tN3b2RrXE0q/CYy48no5UZ0whWwU7Je7s+CdGTn8yx6tUTKNbvUNeglSCqJFc6XXLmic1uWiGvUQY5KVUmTS/I45AGsNZDfky6M9XRHYier/F1TyWCFJWVCQHyZRniEVZEiuYFfSDUhZFIUO8DuGC23HWTmNw61BK3hPtUcXDuqSb8Aqt8UKWxjn+HjPiXSB0M9of+FNNqZLvVlSEms4iLjZBaw6yxEgXgNX8itKfYXrwJwynmhr5R0+NtIbZqXd+Iy9jXrI90u1vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpwjOm7cOOYQQ/rlKmqGw0OIQL6HxXm59Ycs0PNkh/o=;
 b=s45Fsg0A9YoKELOOImDRonzdWSV/qfl3m/muAn4aX5p2mPXf2+puQ69LxXTrY/cpMOhbqSu/TKzc1h+Xav1vce/OhWzgRj14x3Z/FGygEsGxnCDLHeRVFIBKetlyB4xMRNGVWIPzsCm+ELwmsZWnGSWBLN0AJteumjAB9FkNjn6D5YX93O+BiLV+9VXKe5b15F7N+Dtiw/cjXjCZ0OEMTFvteUB3102+QxIMkaqP/TPk3PUOaSuSlw1/YSpnxeVLgpqlswHTSwLQAXJwHvWdYyX3iI4SH/J8K6B38l9fWoqBPkCdCpR3Wiy8/JVqOnrzUMPZL1AZ/dDJpCaHLNxYIA==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PAXP251MB0113.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 23:42:36 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 23:42:36 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: Arien Judge <arien.judge@morsemicro.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mm81x: bound response memcpy by actual skb length
Date: Mon,  7 Sep 2026 00:42:32 +0100
Message-ID:
 <AS8P251MB0001B37B237975CAE6092B80C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0090.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::11) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260906234232.87912-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PAXP251MB0113:EE_
X-MS-Office365-Filtering-Correlation-Id: b30a5345-6569-4a67-b847-08df0c708790
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|16051099003|5062599005|5072599009|15080799012|25010399006|51005399006|23021999003|25031999004|37011999003|19110799012|8060799015|440099028|3412199025|26104999009|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6gtj8mfbriaktOg7m7/XJuSvTwjSAmnOJcZqRrzbmYQvA9h7hVRu95dfLWif?=
 =?us-ascii?Q?MgN1pJi6Eulb2IVQqZDW6wFjH3UscNwuPXduQeQx9y6GoIGQcZoLCKEpDRRU?=
 =?us-ascii?Q?TW6ReUhJP/kZqGbBggRHiq0Zh1oOhFh5HlJhUorfZ8He+ApIWL8jmAWVo2zI?=
 =?us-ascii?Q?7HzVZlF4pVEvEhIOG1xOflydNjkoqK91LoCIH8VirbdD+F2Wkzaf6HNTEGnI?=
 =?us-ascii?Q?aLXbj5CezKQ63IKSuLKCn4JNxABOXFtvM9ciDyNQ//qdRrCiCk0WQZqJlsH0?=
 =?us-ascii?Q?vMYr2nt3F5cX+23aLDuPhqPH82oimLSlS0iuLRwJsM4Mf2Om1FADy3BXIfws?=
 =?us-ascii?Q?T4YzOlmRYdHCMv01oQTI6tVmryRubgm9StVqeP8zz6x0KWBFGDBxZJTIh+5B?=
 =?us-ascii?Q?JE3MUWXhJusTogDiAI3egOY2cGgH4ybnlseC7fhcnRKe8DjX3kEnNkS9TCzB?=
 =?us-ascii?Q?mzxQAN5wpXS+v4Hucw8E/SozeqcEBgewQwHav73E8gHZbCZRLGbnahEp/k2k?=
 =?us-ascii?Q?9n4wIaOPoVar5i94nFORAuOF00lDkOLq//Ki0TzjcgtC7Uo77t+pJbgNZ8fq?=
 =?us-ascii?Q?RqAqaiYF1O+jLmaTX7YhJ3p2iFGOGf89X4pCfynZ3NBDpj9G01Tf073MA8wh?=
 =?us-ascii?Q?Ozl201nsOF8ExFFDxVVgpl5+8LEu3wFpfwVcnetwj1VaFIpygaBQvT/dpR2A?=
 =?us-ascii?Q?9+Khk2mUt2X/jH1UvD3Poevn/OlB3zwEUMiK1elUlYuBDv2IuItGorsRVpMF?=
 =?us-ascii?Q?XK9NCVIAdVeCVDhpF/gxCXmNqEv2llmRTs6NtOlvfLqxlbDh4V5lsPu1FyRS?=
 =?us-ascii?Q?Rz5/yyAWWgJsWaXHmzNMUMc//vPdPiWA7RB4SSHtE3z3/oZvlyW76l6r2uNp?=
 =?us-ascii?Q?NfEI7xqnDda4K1mc4er1XUFh3XkybK8JrWZBZ8uTzUJ6An9AzAnfGIQW7i1B?=
 =?us-ascii?Q?HLsedQ2rRKeAOfz5SqynIIrfXQ9jbY1FuAVaXr76qiWl/clSy0oxzjzudVO1?=
 =?us-ascii?Q?zdMdBg5O1FXR15Pl3uj3hss/YcXqDEP2OLDWO6qtNYC6aS4kw9ONKR8G2LUF?=
 =?us-ascii?Q?PifCEl2+dyw7+iegmwPmjCuJZDloRXntV8Dlr/08za9ODWjrjXc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QBMGp7KqZhPkeCIKk4WZWwtH4U8N6aRXrXURtPbd9SheyavWHzfIc4aBml2r?=
 =?us-ascii?Q?S5jYl1V0ldC4U4yA08JcUO3gBtk6Z4rhk3ijI0y1UjSXdt9Zg7+Q3GyN4ORJ?=
 =?us-ascii?Q?lPFKyQ0etj1dsEo3HCrEYyQWFD4tV0ar3sKkyp31qh7nHOfjtC0EyrIHW+EZ?=
 =?us-ascii?Q?oHFxBEfr8i7zf9WjTENVsXC2kd0EOmMpQUjN3UZMYrjSWLj3BW5bcYtgGaLz?=
 =?us-ascii?Q?6be7KhmSUXVplAGoc+0f42+IQt6FOUIVVgmHt5pqAlsGe4Dq6IpuVLAIm8um?=
 =?us-ascii?Q?IhCOzri6t3hhUnE4L4OGdVK5+6NtD6yhWVozwKjomyPjXhglI9rh9rhK5va7?=
 =?us-ascii?Q?l+i+6z9pNFJWT1SLIHjhkGDiMp5VXGIeplg5KTq8wGhQsHsGnLvjj0LIqKDE?=
 =?us-ascii?Q?sQ8DzBEj60U6slL+zcdnoq+a2cip1KpEny6C37UEshU3/60xXPE7Ucjt4tsm?=
 =?us-ascii?Q?fVMq8Pz6oHwZCFAO4a59GpBPxB95Da9yDY1mDrPGWOJ9xJWu+Ei+8SMIrpl9?=
 =?us-ascii?Q?ujH38Mqxv/P8Rtx6XoggFz4IVpYTj2UTRsmv9yUv/c+aQUfLYA0kC0XomoNX?=
 =?us-ascii?Q?nr2VQZRsMyaXSg5kDd6sp4vBgcbBs4zbYiObphmOSc5Qmw0O6yIr21POVz7Y?=
 =?us-ascii?Q?2CmUyF4DU1x9soGPh4yOR0gZT/qrSGzGYToqu92ycR4wLXNCd/7jg8li1Xdc?=
 =?us-ascii?Q?VLefPs+rOLX1XjCa8xIONHlAzkKsWrJTEUXkgmCJGCIAClx0c5C6ASezUCt4?=
 =?us-ascii?Q?YscD9vwq6sUL3faiKqEBx1XR8DN9XPliy18lGolSwAEZQ+xipLnmC0eMf1ee?=
 =?us-ascii?Q?3R41nQ/mB2vWnVCYgDGx/zLKRYJly/fyuEwF0w2fMI0N5+S+jrOHcxAdXTaW?=
 =?us-ascii?Q?UtCfgmZdpJiYtsEAv1ic4aDy1rzHHzfBnuPCf/XTsQ+3qQ2ZU6VNTbqvOw5R?=
 =?us-ascii?Q?daVIwZ9HQWejUH7Q7USXnD58vc9FveifPt7+XV80p6cspL7eOsjtW1Ma7sYt?=
 =?us-ascii?Q?EKgiTet2qjvSUOjHh88+5tDIyVSYuUnbHIjvD/BrfdUWBdsGLHvAlrDASxJ7?=
 =?us-ascii?Q?gGlylhBjDCtdfkOvbC+EcfffOT2sFfr+Zlo5h3PcSf3BahtULItV+nsQpVBd?=
 =?us-ascii?Q?lAUCcj689SfYdo8mdRgERg/WNqrGbvZ7s0MrCB5Y9rBJk35RcYa7rMDJ2LQ+?=
 =?us-ascii?Q?/XFbQoYRSESqIiUHnXEmaHNEJXHuK4FaxugurCNfah4ofljqqGEBsemKBXaX?=
 =?us-ascii?Q?HFq6DqGjo2yih7V5WiAhUmznC489NwDxoSGng4Sv0d0VDV2CCwA8Ah3CavXa?=
 =?us-ascii?Q?zViaZwBhlHmPrE2/TIWSraN3ZqZ9gCZQ1K35Rs42Jq3BcG7QDyLrk493X2kR?=
 =?us-ascii?Q?1xGtQfeRO1iZr6THAT0+1UsIoa/WeENBQ1YciNqVAn1kAWq7T5XnHaPwoZ1r?=
 =?us-ascii?Q?8eKxgsxrSS+zXAAe25VPh0p1Jp+zLm8u?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b30a5345-6569-4a67-b847-08df0c708790
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 23:42:36.2651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0113

In mm81x_cmd_resp_process(), the memcpy length is bounded by the
caller's expected length and the firmware-reported response length,
but not by the actual data available in the skb.  A malformed device
response where the inner header's len field exceeds the YAPS payload
would cause the memcpy to read past valid skb data.

Add a min_t() bound against skb->len so the copy never exceeds the
data actually present in the buffer.

Fixes: b1906cea00b0 ("wifi: mm81x: add mm81x Wi-Fi HaLow driver")
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
 drivers/net/wireless/morsemicro/mm81x/command.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/morsemicro/mm81x/command.c b/drivers/net/wireless/morsemicro/mm81x/command.c
index afb7ee9bb236..591e5ba10753 100644
--- a/drivers/net/wireless/morsemicro/mm81x/command.c
+++ b/drivers/net/wireless/morsemicro/mm81x/command.c
@@ -209,6 +209,7 @@ int mm81x_cmd_resp_process(struct mm81x *mors, struct sk_buff *skb)
 		length = min_t(int, length,
 			       le16_to_cpu(src_resp->hdr.len) +
 				       sizeof(struct host_cmd_header));
+		length = min_t(int, length, skb->len);
 		memcpy(dest_resp, src_resp, length);
 	} else {
 		ret = le32_to_cpu(src_resp->status);
-- 
2.43.0

