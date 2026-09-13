Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010017.outbound.protection.outlook.com [52.103.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9829534A78E;
	Sun, 13 Sep 2026 20:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789331074; cv=fail; b=W443BcPfS0dsY9oviiFMKGheH92apQQKmMVykSTyLT/FBMmPmQwFXOpuBxLXzdt/9Sn8BHgKLekV38fZ40ZMTUbfv5DXZdBzUAGEHgaRjsbAtFKc6k4pfbq9fYftBDl70h9NhB8ZtRBH/B+KnZ3CiS8EZ1IIu2QWMn+kIXGYPUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789331074; c=relaxed/simple;
	bh=BzqIOKIBxu2mhAiTkUV3CodxGzU45CQ2gfP/8OkKIPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=B2aY+dG/+cYEXMX/HG9gt8pQpdU3JB6cg1dWCE177mo1R5J6rz1N6Et/gbqqaJ174E8nmq6hA4Y71WGIGGc80pi9w4vKiWYXdp5gH5otOUKG2bEeQLZUkpSEa5dtWvAtxwiViG0nxhm9UFk3hPO/H90hDve/FnXYbZZ95SoBNnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=Gu4Tp+bO; arc=fail smtp.client-ip=52.103.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="Gu4Tp+bO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjbxOPHDsAFU5HQu3ZsGsQiTxT2m4eFvpGgHBNylmzb2Kw0VzW/yO3jJqJ6k5tGr81pu6NkWmL1okx6jrjZddRJnjQ8Pbvmbd9D3V6ZUP5WnctrIfA0a9tH2szjSt3c7BOhI0SGArD9HaQYgwJVvAm4cXLyQXpeIHzp78NXIHsp4JOu2XHu3ETCjBkDJ9h0YeN2qzq5hC143iPA/GUBTYvxpoKKKdUZ/PNYVJyC5sAfF4Y6fFUzxJW2F7hosysIPv+Jai3zKpPyInExAh1eOcYPnDR4HtjuuqoZ4vCbAej4l77UiFcHANgRjkeKKPrFJpLlF/CloEoJcfvmXpjA22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aT/wDlJn1okpv2ZxQOVgtGe8MrV+MAv0tmagsCIXNP0=;
 b=podtJBB6PaPEyZ9rAXGmtCMHDC8X/TGs5XSHFHQ56MTb1DNTWskCZ3jnSc10zxpDNrdyGyeV0Jqu+W3joBZ/2vD/zz0BQPz1oP7QCiP5FSZ0wVDfLee7xFGFxRn8SuhyHFSotJqltPTnJaxAmtFEDSre9lN0L4iWiTdjyKa/jGg7DlFD6sJoZvoV/AfL7031EbKC5amqWCKYcvA9VrXlcr04Am4GTE8kbC8O6SuWjOZlyZjc3EPKtblL6FgtBmhcM1mDWU0gBBzH+vm+RgtnVrQDrFq7ZPy4D3EHdUwQAI6Wutte9J/nOs/Ccz1kutJe5y6BdkvcNo77g6XGexXsHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aT/wDlJn1okpv2ZxQOVgtGe8MrV+MAv0tmagsCIXNP0=;
 b=Gu4Tp+bOBzYFUsRIfXiiZ2nCz3DleBphNW+nVdo+UyyGW1VmHTry1Qq41iT5UgqNpohYNokz1mTfIUmDO3w0a6CZ9v9XRq9AtjBSz4fh9HUxMgQj6s09rCA5Vr/I5TedZsbeLYfx7jDl9lvLxAk8HRlvTRgfx1DZeI+XuovQkdMS6ODR+ffd9WDUj17Glx85nwVsTqhV6/2QIgg/X3kS99uEuwRu0EtEsnXGO+wxuwFhqrSqndlH/xTGZf/i7e4k6Qmz/5PK2amB0cGmNtlYI75jedEqGhZ6I3Ma1CRcLI3iZUPacutr3BSTW1wRpLetMCRZPIm2pcbNOK2WpSKI5Q==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by AS4P251MB1040.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:58b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Sun, 13 Sep
 2026 20:24:30 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0406.007; Sun, 13 Sep 2026
 20:24:30 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3] nfc: digital: check DEP_REQ length before reading DID byte
Date: Sun, 13 Sep 2026 21:24:26 +0100
Message-ID:
 <AS8P251MB00011C7777543D73542B5ADFC8BC2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0673.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::8) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260913202426.4123-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|AS4P251MB1040:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8a7ec1-7802-40c8-e5dd-08df11d5031b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|15080799012|5072599009|51005399006|25010399006|23021999003|12121999013|19110799012|8060799015|41001999006|24021099003|55001999006|25031999004|37011999003|3412199025|440099028|4302099013|26104999009|1602099012|40105399003|2607281247196008|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pydV7WvFxqJCVUnYPHsxtX50j0LAXjQ+HIbZue4ce6et8QOcHSGKPn2Ce5VO?=
 =?us-ascii?Q?JMqBtBM0Si6T1F2Y6aF7/B4i8gRNJ8TV6z9cA9QktFy4UbMAqsxIXD+4V140?=
 =?us-ascii?Q?LnAUuX6kqNIZbp/XaL04pqn6CbSbPoi8g5c6xzXdM0FgQA2c38q+q0IcpCmA?=
 =?us-ascii?Q?HVeZ7Rn8NQYeoLIVL66YtAnZ0tl+eRHOVBgJ1ZKN1/MZDc1DHSWeSWxkjpxy?=
 =?us-ascii?Q?ur1rseilbFzV5ANsb3vSnW1u6/6KL2yQJ9uOwmFdf0XVYNuAYlaDvwpVEbaw?=
 =?us-ascii?Q?2X162iBgSdo85kP107TkbVEJWLGs35BiFRZ2irJuQSccvACoO1IlnUvgAdpm?=
 =?us-ascii?Q?UIecdMkC3top+tjR4Po+Z+sSpn3v6e42vkY7Dd8ySaTHlmNo0GrFvgUiaw/4?=
 =?us-ascii?Q?rnXKL0Qaq67YHvRGPG921ieRjz+gmRcnamsRVXSg6fzOCkPHCE/qHzgVMdtb?=
 =?us-ascii?Q?MEkJEZtvistOegrf1BHBWwSHLPoqB0/2+g74hGZb3GigtAe3sc7w9eekvWjm?=
 =?us-ascii?Q?fh1KY/fX6jbD4ER9Xomonz/26dyyGGvSZ43l9hGvTeNGvAaHFSqRaoY0P2Mq?=
 =?us-ascii?Q?Sts3UKmf34oyrRAQTzPAHX5RPI6dVJIZVV9rLig4J27Kc+pDRsNXJne8Es7M?=
 =?us-ascii?Q?FSVngm80cg25nudqCJ8gQ3sayjcFbEa8v+hM9ymP744NUjWppVTslG/csElC?=
 =?us-ascii?Q?556b49Yt1kiuAWmkO1/tY/D+TwjzUiOW9nYRR9RlgtV0XU2hpIA4uTixSIwJ?=
 =?us-ascii?Q?OXDbGbXgJ1YNYiMmN3SWuD6Fy8Xg4XpVgzfkHYFgLjjbLC3qEOobemhwug33?=
 =?us-ascii?Q?aCrearmTqV2QzjV3UW9FsUdnsYckdPPoYkBBcuF339J1Ftkcp6H9QVGn9zae?=
 =?us-ascii?Q?Hw5UpucGF7LqNZTQfUcAjHkyIfIsnLU92Eeux8FlM2oOJJ6Z6GGvwU1v2D7M?=
 =?us-ascii?Q?aZlnwZVSMzXxrGwJX22CIRc8kGtPJ30pM3I5nXuMbRotFN/LG7uH0JuFuZEK?=
 =?us-ascii?Q?9m+8zd7SYV4d7fA7i0JKrrRKJHXxM4cJuL3iI/pds4/krq+cxMXmSRb2cA45?=
 =?us-ascii?Q?4pDWI+55aEx6hdzGdqV00A94+TM2+T+Rpo/Mtr4zqRz4U4H77b7U7YRZjRH7?=
 =?us-ascii?Q?eu6sJkVBK4g2jhS1vObWx0KZWXuIUc6GgB15To0dQoVpUjHexK2Tc+nA31A9?=
 =?us-ascii?Q?1hJS2d2ppEevxGxXlDYg72XM9OPHMvmC1V4dxAGtmQp1vjgU5vxVno+fkoY?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2tu2aokV+4Kt87M5OZ7CAKFNtDXIwlGU+9jCwvtk9B7BaooW6Gpm9aWnDE2H?=
 =?us-ascii?Q?5VDC0BTaHvASb7tJHQkzUzaJ5sofY389SPOH/H3ezIIdstz+q5p6bguHjuND?=
 =?us-ascii?Q?ngIGKbpxOQ4N97nlf+RIuSluaqyU6ptcB1jpq7yA2teHlB9GMXeqQu7KtAhw?=
 =?us-ascii?Q?zhvcuIGdrzGIrQIJdz4MDYS4cnRwP6vuE8e6p3a5s8J63zNnRvmO4m6ZLX/U?=
 =?us-ascii?Q?Y/OewczXQ+LTXk8BxP825ylUSAG7VkhrI+91M5Kbkss7EY7i746luEh8ztOI?=
 =?us-ascii?Q?wBrQ1TLT77WA/uiPjqLvEhoZ25WcwzRFGy6at/CtIHANVCQoL+b73rReGTvD?=
 =?us-ascii?Q?mZdKVlu8XoCEHtk+gjkYG9eYXfhQ450IBHatgeooKJgYFaRfCVcZGvRrZtwJ?=
 =?us-ascii?Q?nj0msVvkxm4dtmRdHtwrElyADjK24x964/6Yl9XtwD5G8Wihewc3TrTQ7oLg?=
 =?us-ascii?Q?YrdbOX7ldR3ayKSiXCpPQZIKQ6UuD4VqTcKe5CXoenA+B6XwDSvPqWOD1Dpl?=
 =?us-ascii?Q?9eueQiPoeksUi6NYJcUXU45delXetAqvBccQAJgpcFH+5yoLomBj6ZIGUYL/?=
 =?us-ascii?Q?0Dwhe3imEoslwE1Ag0YIX1/+MCLP5+EXrSTqx1cafLu8dMP/80pZjBkcoycM?=
 =?us-ascii?Q?wnRc5JCMlL3tRxJREyaSXBkaINF151eGoSPTrFfETK3tNiHdy0J4p/MZXMK9?=
 =?us-ascii?Q?DK+lPNlWWyLS4FvYVOkX9mWp5NiFASfiXpeJB2R5NtEZ5sn6A+iu8opsrNJd?=
 =?us-ascii?Q?mlH0zoM+18AszWrq9jfKP2UhZ5DCOVPMStBvz3gONuwP9SrB4wzSdcFjK5+1?=
 =?us-ascii?Q?Sn73hIaYTiI1ED1sC5P4Bt9svPWse1PXgVbJfux2I1+7zuWxED98ZJb2e8Q3?=
 =?us-ascii?Q?2U7A63ILluKNH7cQpBaeVWoTz0fT5eupjMgIqzpyEyyIoj3KUxWeyHxUixYQ?=
 =?us-ascii?Q?nqhUxEd6fdPVLbPGfPhrHd4xm/52Fk1sFwdKx7ey/eGEUzwefQ0L/oCuK57N?=
 =?us-ascii?Q?lTD+/gYsqo7hb1Faav8X2qQjBq1x62f8xOqwnhqbMoHoyJPeS/R3FnQO6DWO?=
 =?us-ascii?Q?URymHj+MV4/IrQ2lTQY8qZMuUBPsg9ZhG6sagufxec1FtEhfVohPNvDE9A0A?=
 =?us-ascii?Q?XO8YFK+/k+zpkdMLjposdhWjBElBoj68jc0EUWYWMm/2gwTJSN9c1DHsRoYj?=
 =?us-ascii?Q?LJk175X2uJtODfSzeF5Lp6M+/T/7HxB/FKRPNh06ZUAmL6WmgWtksEqf5Hqt?=
 =?us-ascii?Q?YP5QFxAUzAJdnQKw0KSzkJVm7tKt+QImoAiFsPb9tLJ9xgvn4TYCxxZN8wj5?=
 =?us-ascii?Q?+S9/UPQZsnQhmo0EYMkqQIKY1cs27v/u/RfDLmYQf0A3OuFOWKFgzMJa7Ku6?=
 =?us-ascii?Q?DFrlNzXU+gfAtP7KGDjfDp7SO1gvVo/8ZzZ47mkZmb7Y0Xmj/OOhObz2Ns4e?=
 =?us-ascii?Q?UeRSukge6eAqcFO0QqdipZiMHoJxvMwb?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8a7ec1-7802-40c8-e5dd-08df11d5031b
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2026 20:24:29.9870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P251MB1040

digital_tg_recv_dep_req() reads resp->data[3] when the DID bit is set
in the PFB, but only sizeof(struct digital_dep_req_res) bytes (3) are
guaranteed by the preceding length check.  A crafted DEP_REQ that is
exactly 3 bytes long with the DID bit set causes an out-of-bounds read
past the valid skb data.

This read can happen on every DEP_REQ from a malicious NFC initiator
when the target device has a non-zero DID.  The stale byte is compared
against ddev->did, so in practice the mismatch causes an -EIO return,
but the read itself is undefined behavior and accesses data past the
buffer.

Reorder the condition so that the length check (resp->len < size + 1)
comes first and short-circuits before resp->data[size] is accessed.
The later "size > resp->len" check becomes redundant and is left in
place.

Fixes: 05afedcb8918 ("NFC: digital: Add Target-mode NFC-DEP DID Support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v3:
  - correct the Fixes: tag; the bug came in with 05afedcb8918
  - reword the note on the later "size > resp->len" check, which
    returns early for NAD frames and is now redundant rather than
    preserved for that case
  No code change; Simon's Reviewed-by carried.
v2: https://lore.kernel.org/netdev/AS8P251MB0001F45C42BBD0D16D7B30ABC8BD2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/
  - add the Assisted-by: LLM tag (Simon)
  - designate the target tree in the subject
  - collect Simon's Reviewed-by
v1: https://lore.kernel.org/netdev/AS8P251MB000196084524EB27D62162B8C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/

Compile-tested only; I have no NFC hardware.

 net/nfc/digital_dep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/nfc/digital_dep.c b/net/nfc/digital_dep.c
index 3982fa084737..ae5407fca12d 100644
--- a/net/nfc/digital_dep.c
+++ b/net/nfc/digital_dep.c
@@ -1117,12 +1117,12 @@ static void digital_tg_recv_dep_req(struct nfc_digital_dev *ddev, void *arg,
 	pfb = dep_req->pfb;

 	if (DIGITAL_NFC_DEP_DID_BIT_SET(pfb)) {
-		if (ddev->did && (ddev->did == resp->data[3])) {
-			size++;
-		} else {
+		if (resp->len < size + 1 || !ddev->did ||
+		    ddev->did != resp->data[size]) {
 			rc = -EIO;
 			goto exit;
 		}
+		size++;
 	} else if (ddev->did) {
 		rc = -EIO;
 		goto exit;

base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.55.0
