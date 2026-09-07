Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010003.outbound.protection.outlook.com [52.103.32.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B813B27DC;
	Mon,  7 Sep 2026 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762547; cv=fail; b=oe4KupIPyLeAHWCjVXDyeQ6xzneusOgQbvbYQwL5GMeHiBq0Re/KlyUxJGaMlSWXItcB2nJjvSvPDhjFszmCzp2hZxJCdvKFQ4zxKR9ZTNExmZpumJSuUX0jp5zx8UcpB5lsE2F5Ip2iDMZfdICwnQClPILvV5GFr+pVybYoG0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762547; c=relaxed/simple;
	bh=Jm/vHccIZUuUDo4adkIndx9ad1ujefvo1MjDqXhObZw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=evLdqfGDpjLUjQ3/RZLnvbxkoVGKoykdH63cyWiykUaJbr20noF9/zKmJXhhDA/V3nFRSNCvj31JGnpgTNGkzn/PtycVHILf0iWk31jeCWuYjErj8OJMMt5U0KlJ5Bh2D25o1DLaHQUHLUfmrrOmDdnxnlphXTUBP6TrFAG8t7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=ZTha9Zic; arc=fail smtp.client-ip=52.103.32.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="ZTha9Zic"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GL81iLEDTUQFKGSWTqBqHblbFSJlPcEmVVKkYxmeFjS4+cUJdvjHCJQsIWhcXbYlhj6Y6I6RvuhhCMUs28ZWWH4sQUM28jrFunxYxUcwwj8KrK2omxHg/6eyozy7PhZnKcpXwB59QjGzO0PE8wY9l9kElQhuUR23h+SFCDZu+fdYco98v6OxtR9gDRVW87FmuSJi3psUfwsqwqQrNOwlmI/8Kv9IMaYHlRn9RFo88+U8fDgEIl+6Do6wLnwtjFm6vULiEV+pZ+5ofW6xRVZ7XVU3enfGCeir47iELFkg9YJwKsAU3JnWn2mkz15jospM3ClY+g7ULU2gaTkQO21frA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0zndLH3+HelM8t3nrqVosLTbNIPoQVGcRtHb1rMy/Q=;
 b=PQAicHV92bfUxHlrvyuy3+goh1jXI4KwZkVaL4mQIxNW4aH3dHAgP3TBKex1YgpLWRcGMoprx+qNzV3JUHIXPvFOvC9FTIBl1jdkwg7Y28Ogy7VgajCn8jZZ442Xfp5ddAxJ7JA+tTiqccpWJJvDsZs3zYxwz6FM4bV+9geYH3+NmJKY/d/L7QtNpsW8KaJga4aShDvzJer+5YOEW8CMDnoEnqf/t+NJiqx6X8FplhmYmpjxzJeQNg1XJnzHSOdPDWSQohDXkQ+IxgLUMvCyKQ+3Ew0BUK3fUqE5hb+EdN4+wU7xRwqXpSqyGJ1e6Vqskb53FU7NjXM/Se5B/Rmzrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0zndLH3+HelM8t3nrqVosLTbNIPoQVGcRtHb1rMy/Q=;
 b=ZTha9ZicdVkni6paNe3Ap2BgHEQl2VMvhcYrYnVt7MAtzh69BBxyGVBtudM4Jtsmvklu9rUdW6Jy9SGeBX/1r3MUi2qNQ1Ehtn59xYOwMso24TTGnZi6Oa8ivoLjpGigVj9/E/MHF0QBs7piP/zgE232xzyW4BLI/EqjrOPwWYQF5onDw8qqsWP8/HyQfQOvbbsTe/pjEy9KelmClHZxAJpwv+yAnBY85BNG2RpQs1SEtNs/+RFg/KNsLcQYFmLpleD39iKCJYZ7K7jM2DguoiTf46quai5leDat2cwrN9Wp3jsKICyLp46BEb91hGRHGqjFHuo5N/MN4QhUzmG0LQ==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PAXP251MB0028.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 06:28:59 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 06:28:59 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>
Subject: [PATCH] nfc: nci: validate CORE_CONN_CREATE response length before reading fields
Date: Mon,  7 Sep 2026 06:28:55 +0000
Message-ID:
 <AS8P251MB00015EC8F8C2D4D9B536F94DC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0403.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::12) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260907062855.572260-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PAXP251MB0028:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc02ceb-6d88-48d1-23a6-08df0ca94cf7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|23021999003|37011999003|12121999013|15080799012|2604032031799003|19110799012|8060799015|55001999006|24021099003|25010399006|5072599009|5062599005|4140399003|40105399003|2607281247196008|3412199025|440099028|26104999009|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a+4Ez0EbGACSRBO32RamcvtI7eZiYWeVqzpOhb9EvU9536po7+C39TY0JiAF?=
 =?us-ascii?Q?/CcdPFZMgG1QYfcwk8Qxb9DtSe7046Mv18sTtqrpJnptcQnaUei+x+iPhCOi?=
 =?us-ascii?Q?kx5bwo/EigssOMVNnvszPo8Hm2v6/pVxrAOF06KbEufHkMfN4EsKBvzMq3Eg?=
 =?us-ascii?Q?BhK3Betjkl8QPsntvenk/FwXLBRmf7LW3XAQOl6dw5+9ZIQK5tWgJUitUtN1?=
 =?us-ascii?Q?5RuP9d4rgzRDK/69DmkgLOnvPK6DvaFC4v8ACyHqL6+Zhfa++3Jw7MwA6mP6?=
 =?us-ascii?Q?x7vbSs3S8pGuUHXDxaFe/Y6bPWY9Ky9tSdXYgaygZwKmGttIAoXeaKoaCUnd?=
 =?us-ascii?Q?KNDQ+9tP4XwwzNtTaVB7i7CrEc2sbbr5cbJqiUAsHmkU0CfoILbDz60rxiMN?=
 =?us-ascii?Q?ppdESFYeo2WfenaPc7+0ohumnkzzZ5PDdVPqGETlCHOvgMATSO6WogXMq73t?=
 =?us-ascii?Q?4F3t9LLLYOsrN8aD/t8ilm++7rWtQyEwJouS2AL0GzS48PBLBFq+Q+1qYyIx?=
 =?us-ascii?Q?vBy2SyH14YH5V4UjhCdDQ2ooGclnSe1qBYGD5X0aofdkmqB109XDHu+4AC5M?=
 =?us-ascii?Q?BpO6Er8Lb0Y2A60PWMsd6ygNGCTby99fUTVN/DyPqdYWQmRsSL2PLJZOEW/v?=
 =?us-ascii?Q?9QPaDXJcujEketZ4B0EkeNBUTxQzdI9r/BNnpB9dYQNPcL7yLUi5nKIntJRP?=
 =?us-ascii?Q?PwNasgVHa5sb3KkCbD9S60CclR4neRalJeC4qtjB1M/I19bye9ugbSZeWd8f?=
 =?us-ascii?Q?ewML+IG0sFF2fMG/wVvp7M4wIlX1JOBvwEzDjJ45MJ7YHo7d+Ltp1sYG6DHe?=
 =?us-ascii?Q?8C54FYUnB5N96kgbfnouhRaLBpkrzu0pGMe/FyXfQsts2pmISQ05hUJUx2S4?=
 =?us-ascii?Q?3+08L7SfuIr/FSI/hvJN48MA/dDuO5Hjci4JrWhtUUoMq9mdvx8r3K9xkaE/?=
 =?us-ascii?Q?21erukTkDEYMotpZ8lzZzvcWKIlDccMykDJOq6mnRG3FtElvkpIGKsfYChq8?=
 =?us-ascii?Q?+BtPT/5/QjuVOGQPdaghvadgcbANji9VmpR5VJAxsI9YuklPYOEOMdAkrTIr?=
 =?us-ascii?Q?PwfE3oKKS7FQ4BTEJJ/UEwtjIbjyjPkORiRJhKLza+1AJ+yQTeVWTL2Tl9gD?=
 =?us-ascii?Q?xEaCmWZ7Bkr7?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P1wL2ZxVNF4VDRYDtUMJ9OZCYCWPHWYu1bYUDK4kSYXkEEU8rm17j/DCM0kK?=
 =?us-ascii?Q?ZU6xKdgLvovM9AvsANWe40j+Oc+B370iKrUja2Rw55sPxoDb2FP1xXSMRyo4?=
 =?us-ascii?Q?LSgic7YSeo6G7N/V2T0QcoEb8VzcuhS4gshNbFk7oCnCnaLw72L3W3nKNVBo?=
 =?us-ascii?Q?FMrfbOTNsBnip+SZyMOMNaqJrS5jMLfl6oxPSUAofjPH5bKdrWK6Rm2cFBKz?=
 =?us-ascii?Q?zbYy5A0j8aa+uU11rdyy0nUwPhH0XXwS1oCwqi1pKvFcymBMTDyTIPRt5z0O?=
 =?us-ascii?Q?FC/lcvKlDAK+OXtmzmUgnJCTUxVW3moirFZb6/T3qCJA+kAMwdNW5vLW2Hgh?=
 =?us-ascii?Q?DofISSNOxV3ZqBrjEcrJ4QFG3dAkfDFGADaQiPk8jeH+4SYpwQRLyp8QNjRe?=
 =?us-ascii?Q?lc02uTzxrabD3Ro+uShmkstbF8jvzevjJwtA4cAzCVk7dIcn5sRF9jfMlrpt?=
 =?us-ascii?Q?vWVZaQlSlY7yJV/KS87276XHZJrpGyVP76VE++5DLYsznQfhPMbC7PC12Ar6?=
 =?us-ascii?Q?JayCwqerO2BFHfL61iuHBEIPMEvO9Qwm+3f26MtAB6RU4jPUePUral3DuLli?=
 =?us-ascii?Q?Dz+5rrLtiTgjxxL11dNZzC2+QJZ4fxTzLhWqaUIrrninKnTmwXe0/mOSQwg1?=
 =?us-ascii?Q?uTKvTK52lscmE7U3r80q9vujHSo5+URrFEzHSxaqRfETP5gZC4bOGeOjUUWQ?=
 =?us-ascii?Q?44XrJh/YkYe3vXuUuFwfSdcqo4ZFK4yd89ORJEkgCdi3j0ubFEIp6EopRm2h?=
 =?us-ascii?Q?+I/JjZqS4NUH6IzKAp+oAdMS/LPLculMBB1oiTZ/t6xNhKj3MiYeSDL0ZrFY?=
 =?us-ascii?Q?M0qfXDUtEnZO8xphE3UPg39HlRKVztb5UbvsXzG5cQTklorHEsuZ+4uqWXot?=
 =?us-ascii?Q?+c36fgaagtPXBLW8fqypDi4LSqR3zI80PdjzFHzSeEJotwvDhCuK4ZrdQO7u?=
 =?us-ascii?Q?WlrQPOzCzvxjxh4jSgwEKVRxXu5aPNcYjhSbQoOMJ0MtLoXUXBpxIvnbfb7v?=
 =?us-ascii?Q?B9OiC6wiWlhVwuOn2YcKYcj07GSEQ2ZPworlQcsZW4KyTQtyAit6y2iV52Y+?=
 =?us-ascii?Q?AIlBOefTFmWjUiuQmln57c8JdcnrbW2TTdkgYNXojLc4BXsorO1kEHT4EETv?=
 =?us-ascii?Q?2CmqZuYIZxtvGO2vF18Qu/qQl9V99BE4rbeBW7ltjzNeIEekCZY4GjIOnFpB?=
 =?us-ascii?Q?v/0bsQBFZDM1WHer7CibKbrxM6geY41Otdsrh3S8fNmBElukFwvSw/MeDwfY?=
 =?us-ascii?Q?kEIJvKCE08Er8lGIkD6g031mzCCimgygVMNGbey3Lksq6zP7/nETjHogZfoU?=
 =?us-ascii?Q?kKYnT2pUf6Ot3jNd3e4Fg7XaGYKhZbDai7FMtJ9ybwWASW1pGOAuJcEW0que?=
 =?us-ascii?Q?faWM3q1W52vWnCf7oRxViSv6KjAVxMGVR7yIHlwUTBhdioE1D3nQgC4pY+Ay?=
 =?us-ascii?Q?SI3ToigR3bcH3bVeEzWu4NIFNRmrWkk0?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc02ceb-6d88-48d1-23a6-08df0ca94cf7
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 06:28:59.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0028

nci_core_conn_create_rsp_packet() casts skb->data to struct
nci_core_conn_create_rsp and accesses its conn_id,
max_ctrl_pkt_payload_len, and credits_cnt fields (offsets 1-3) when
the status byte is NCI_STATUS_OK.  However, the NCI transport layer
(nci_valid_size) only guarantees that the payload contains at least
one byte.  A malformed response with plen=1 and status=0 passes this
check, and the handler then reads three bytes past the valid payload,
using uninitialised slab data to populate the connection info that is
later used for NFC data exchange.

This can be triggered from userspace via the virtual_ncidev interface
by injecting a short CORE_CONN_CREATE_RSP frame.

Add a length check for the full response structure before accessing
any field beyond the status byte.

Fixes: 736bb9577407 ("NFC: nci: Support logical connections management")
Cc: stable@vger.kernel.org
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
 net/nfc/nci/rsp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index b0ab4f5acbce..72b748f0be9f 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -312,6 +312,10 @@ static void nci_core_conn_create_rsp_packet(struct nci_dev *ndev,
 	pr_debug("status 0x%x\n", status);
 
 	if (status == NCI_STATUS_OK) {
+		if (skb->len < sizeof(*rsp)) {
+			status = NCI_STATUS_SYNTAX_ERROR;
+			goto exit;
+		}
 		rsp = (struct nci_core_conn_create_rsp *)skb->data;
 
 		conn_info = devm_kzalloc(&ndev->nfc_dev->dev,
-- 
2.43.0

