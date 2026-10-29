Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.122
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793277176;
	b=BRxQlPOsI0jGD173Ki1J69gCOPzTY33jymIUjsl7kItrBFa50E5ZJ/asHMS4W7oio/m2
	 DVSzNMYIVoX24GlCZU5rqRuRZ6VMMDf/5wYpWmk0vhQzdQeWrtj2QO+OKltoh916GwXh7
	 ARskJkFQl7kqD9h7J8qgr5aIzKXOTpSfNO6X8/b/rdBSVL3rd9zQQmD+v0KwVgRDrf80i
	 9een3V97We1t/haNfY5o+EdStRhvtkr9hCORAQ1bjX1xoCvg59e95sy/4bCSulPXlhrQI
	 rntfQhP5SQaE3Z5V7KLCPyIsiWlEQ9cTmPTw+OlCpRsFQAlYeh2coEgkkERJmgAAk1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277176;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=uJtlpvLt0Tin6RhMAtEIFnFksIM6njAD2qBgrMRcfKc=;
	b=vXjU372F77b6e1/S8g6mV0EE8mipAhQWwrhuGlhvh9xuYO3mZYqAUKsciXtNKuKo1ahP
	 GDFTV/SrSv8PXCF7TMmPeW0+c3brWW7KCLvzjutHNVu/NSUtN2TjQoLwCeg5HzLRxklje
	 EsUYo/X4jpEhjOsJDBXq3PL29uKe6/vhyWaQcCrh2gPilRrL4XuHeZUCNTi0jJEJAdwiY
	 IYpVJRrWobWwvZzJPFl2oEB0yAwwFVgvcxGKL9s2gVWkK2gU1Fs9P2OTmnSlsEWnW4BSM
	 NjV82X8jzDKHNsY5Sf4VvXl2tNk4Y2pUgcy01yu7LD2Ab/CXKZRPYcvZzF7o3yOfxMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smu.edu.sg;
	spf=pass smtp.mailfrom=smu.edu.sg;
	dkim=pass header.d=smu.edu.sg header.i=@smu.edu.sg header.a=rsa-sha256 header.s=selector1 header.b=jIqffBpZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.122
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022122.outbound.protection.outlook.com [52.101.126.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B890E606A32F;
	Thu, 29 Oct 2026 12:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B890E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=smu.edu.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smu.edu.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=smu.edu.sg header.i=@smu.edu.sg header.a=rsa-sha256 header.s=selector1 header.b=jIqffBpZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qggyidMnYVuGea92w+HqFtjlC0F+eVxC0baMcKVeoeOEcGD5xQ83p9xLkGhRLBh8O9SoLl7uOx0W3OEtEnf/+BjUlKZ1KfLgUQIfmJGuxKjnE2M5dD6ipnHVWAUeNUb+0Bc80GFZW92N6tAPAiZhTUHOZ+9igotcadgya+gEoQYjZtBpIxruN2zmpEKwAPgjWzBS40WtUrntFVkNViSmxHCyEuO0zohLKlEqtmyWfNqY5Uf3Yr2VUfndLMGYWkWTrdxpLr8O+vPgGH11WCFUwceaLsAcYk3qmzeQLYSxX2hR2JunpJAN9yU+cdSjVX+Ru0hYA9zj5vtzwpDeM9i27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJtlpvLt0Tin6RhMAtEIFnFksIM6njAD2qBgrMRcfKc=;
 b=wElheXChOLD03ucK6tsoFW8yNLJ2I+tTucDtDsqF18HlzKT9Nql7d9Y37U5zt5scPWWjBfyAcw9T1HRnKl4xYHJGr9IR/Ja18McjoRac1Qtaqjm85XEgG8C2wBbnrAjsYnpEYsgK4fk9gHFV1WY/yBlMg8AUOnKyyut85Ms5AD7AX30srsGwJB7GBTsnWqcCJC7VeMwQL0w9Rf9UgYCiP3yOCmQGkeX3WuR21CVS0a/gBS9sPID1+EaGbcXH9lrbReCSMvvijtMF39E24XS4jpDBeyt4kI8b80KUKElya8oyOXZAgIAo3OAd0me90jU8hwUIazEG+Fey6wfLmFH/3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=smu.edu.sg; dmarc=pass action=none header.from=smu.edu.sg;
 dkim=pass header.d=smu.edu.sg; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smu.edu.sg;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJtlpvLt0Tin6RhMAtEIFnFksIM6njAD2qBgrMRcfKc=;
 b=jIqffBpZn1C7CSEjRmI3nhRbPqQ1kEj9H/FhKJfUQzLfA9MW6/FyAG5qt8VdzNQUjHKnN2slFTP2e7171UWYMncjDeolkbnIN6kic79wGwV+zfexVtTrQYvqfbgFtepjoyPilITobJJ7zUqXTlKeVI3/UUhmw853W1jrHe2f2LweaF8adiL70wNRm8P3Dbmt8S5+21UdMfe1zDf0CEf7UpmIpSEmJV9dqnDDqcPN5UZPaUwr4Y8KvKLFeSBar/CX5vWz+i/Jx7H+at4J6A2bSMT5+rccjURLRTc4w4WjJqRb6L6rPG+WMJeMcSDCZMjHLt3JX5KsV9di12j6L61j2Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=smu.edu.sg;
Received: from TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b3::11) by SE3PR01MB7868.apcprd01.prod.exchangelabs.com
 (2603:1096:101:2e3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 12:32:51 +0000
Received: from TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
 ([fe80::9272:a3a2:eb34:7382]) by
 TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
 ([fe80::9272:a3a2:eb34:7382%5]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 12:32:50 +0000
From: Huihui Huang <hhhuang@smu.edu.sg>
To: linux-wireless@vger.kernel.org
Cc: Huihui Huang <hhhuang@smu.edu.sg>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: mwifiex: fix OOB read on short multi-channel event
Date: Thu, 29 Oct 2026 20:30:48 +0800
Message-ID: <20261029123048.323270-1-hhhuang@smu.edu.sg>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b3::11)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR0101MB4264:EE_|SE3PR01MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e5e446-a255-4667-5b2c-08df35b8bee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|786006|366016|1800799024|376014|52116014|23010399003|18002099003|3023799007|38350700014|11063799006|10067099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6nRN611lGXAujaQU8ejceWZW2K3+vyjRCSRj/Alix8OBDGVNl8gGAAmBBAgR037tbHa5eFNJxhiM5++oC5m4Vcd7PznvmA7WrK1jHC8eWK+lKO9AEHAqvKn9DDEuxCXrO10xzL0Ozq6U1idLIYC4X7O8K6SeIwD1f1iwBJUjoBHHo5aSboP1ve/7mRAhq8mYt4L+QGE4bzdyvA97YIXgsGE7HPfwl1gPx0KuPQ3LPkSiRc8+ynN56AsC3dBYWq6qgmc8cumy64oS0SYaziNoaE5aUurOFm+podTe1ucqOLbLpxUhbXGDSucpBTzOcGLRkn6xGHt3NVSH/fpKQRRxPCFdZYQTgw7bfv0ld/uIEi55MTlANpZfkZJ/g2ar0l0NF8zzi2tAkocGdpbTFCZKq/p7bZNbB/WDIruXrl+BNi1R+yelsjdPqL6SQg17BXAGwhNi+EOcNGP3dg8I33H4lb+ZOJrnksIvk97KwfMLiDooe6mhcutPpJY6hjXMYCdT0lNELnBGOl+IIc0o+kmKIjNwjMnmDWQ8BqUNOcK8vvpmGxi/WnH3skCg7TPp1mwY4r3TSa4wOak/92WFAqIJBlFsiLJSfx8Lu83w4UKmw8CdT/RsFdiuLMM79knXtqUXwS8GA18B67qf3TzCD9/2Xe1WsacFzhgtec1zSE/LFpXY+g8BkXR4nD38G3YSlWk0TLyDW/2HbrToYvwXOcUT0kRGhPskgaoBWi7SVdK4qbA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR0101MB4264.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(366016)(1800799024)(376014)(52116014)(23010399003)(18002099003)(3023799007)(38350700014)(11063799006)(10067099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZRAk6DabrXbjNbfJZt+oqD3QP1FNLoAwbzd1avYCtvJPqlFYpajI01m6VOBG?=
 =?us-ascii?Q?JsALEOQMsDm0JAK9SumU0Yn6RLpKZrhplKZrlIDUabnWlEUyhhmjHI8A+Rw2?=
 =?us-ascii?Q?AuXlwdQr2h62Y7nglWfx2Jyz2Lg+F+QPuRWHQIfYIhZ66RUdK2kRhbHOC1a/?=
 =?us-ascii?Q?WupdLAC/CQz7B6r+ytvfn+FJqlltytAvFNt8wgTED3E+4D6oBsLeNp+yHnu4?=
 =?us-ascii?Q?+/MIqqdept3o08tvJM3Lf07/GmQH5xHoiOGDxEXVIewdpmz3wx8PnrS3LbzK?=
 =?us-ascii?Q?14onjfO8I6s3D1Yz6weGA4ecD28t0bZ2WPPccFs1UWhfXi5a1I0JyJDLTvRr?=
 =?us-ascii?Q?VQDVX6UNzO84M0ZrPSEhEAjZ2cFsGZX7OvL8OBzG4Lx/Nqrj7xzASGOd/8VS?=
 =?us-ascii?Q?ClZ8DePH9nobaiw0mgxepynenkRFU3UfDJbDDGtL7LwzFKSNcg04jpiVmjV9?=
 =?us-ascii?Q?b6UEzRQTZS5D3aAWXwUOPFKmQnzWS4owoH3kH1HId2OrxVWLy743kZdGjGFd?=
 =?us-ascii?Q?gsIOc/TFPktWDy50hBamj1snTOwvGbNk5R1I4Nr3K0J6LHG5pwOxEpjjed8/?=
 =?us-ascii?Q?78BGnMU8W13Quz08rZMSynNRMC8L9JxGFFBe4gy6BGYb3KTpcxIkPV84vton?=
 =?us-ascii?Q?zIGDb6IhCSkonYz3d9sxoim4kVeaTyx0Y7Cua1NfddtSqjxEkrtRWkGdkDXR?=
 =?us-ascii?Q?+1EWbx7YB4ftXFVf133yypgkgtwhceCPMZFIRYEWsneBw/cmA6g9ZUFXAsFG?=
 =?us-ascii?Q?7WvE2CpwTZU3N9k41hSKngtrD95su3irAbEmLyCfZpn7tR1ohVgTvp64e94M?=
 =?us-ascii?Q?ocl4dHtQ0fUZ4vSSQmymCv0d4hMajuIw+pgIHwC2v5gH6ZJI+A/tQra0mKJC?=
 =?us-ascii?Q?jVToGz5beaDzq6OktR2Z0xsdKU79V1ZykCncd7bLEpwMSS/DBHoVNyInBNoo?=
 =?us-ascii?Q?8LpmLF21xPHPJycJeXkUU1+QfB226qsoRwCc1aAlxfkVSHcfpdGJP1bA6q1U?=
 =?us-ascii?Q?p169ETNMXkwxfXTT5Xcyo8IVKKuuoyUmr5dpST1tk9XavHDAZ+QCmVvCJtq+?=
 =?us-ascii?Q?o5GChmqvg8BFs+cbzC66oXwg8N9SrVYbyIdMS+oCVrSt54bzomBX5nyt7b3j?=
 =?us-ascii?Q?TD+KsqwcunxZ0XF2xnf1uV7AxFg3enyfDheTec+nZ6lm0t3Eb7W1iNSNsk06?=
 =?us-ascii?Q?UJdXmDk8aZ47WWcFhh2EjFwzwJLxPIlkZ1FBEjsk/pmUnz47WdLhbQo8pAMK?=
 =?us-ascii?Q?nu/yHymk9VniPiBCf+d4Ih6LxLYQR73GOK0p/QHSnROq292025v9PH5ii145?=
 =?us-ascii?Q?Mco+iPI1ldcB7Q1JSaPaSyW+VOFmOsHmInjUazi2EUK2CPVpbk3KJldJVdd0?=
 =?us-ascii?Q?99KR+94LR1oMZzofycKZ4q+A9P7R8NGt8dK2YXsJNR3uZwLwXwv8f2i1qMP7?=
 =?us-ascii?Q?gdAXVuruAUj9sMCQX2+5YYJEH2v+k6MCyhLn8j1kflGLvR1o/ncZfPQu0Znj?=
 =?us-ascii?Q?aZue5piJL1dmbgKZ/r1MKlivLFS+gN3o5rqWreH+txWZkSOaqcbGRoBXmyYO?=
 =?us-ascii?Q?0r5fGDwX+ldwbmrM8Okoe8ed5sD0TMpScB+42BODnEmaJrklapEs9N4U8AMi?=
 =?us-ascii?Q?zvBZfpYdLs1/7f/rAaEjCXhkVL3i98e16rCpIOZe7RX2klxlkhp3n11e+4AF?=
 =?us-ascii?Q?W4A7NxM1Al266fHs+lpSpqh4uDFc+305Z/g1YhkpHdu7OSkCRQAr2N4GTF+m?=
 =?us-ascii?Q?UiQOEQiAzQ=3D=3D?=
X-OriginatorOrg: smu.edu.sg
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e5e446-a255-4667-5b2c-08df35b8bee5
X-MS-Exchange-CrossTenant-AuthSource: TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 12:32:50.4760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c98a79ca-5a9a-4791-a243-f06afd67464d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kB4CsBkgoDFiaUqtELRkDMb2JCIYkz65dnUp5XwgD4MsgFWQc/o3Aum+Kh31FL5fPIcZE3rMfH6zimEXUjd5UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR01MB7868

mwifiex_process_multi_chan_event() reads chan_info->header.type at
event_skb->data + 4 before checking that the event is long enough to
hold it, and computes the remaining TLV space as

	tlv_buf_left = event_skb->len - sizeof(u32);

where tlv_buf_left is a u16. When event_skb->len is smaller than 4,
tlv_buf_left wraps to a large value, so the subsequent minimum-length
check fails to reject the event. If the TLV type matches, parsing
continues beyond the valid event data.

The EVENT_MULTI_CHAN_INFO cases in sta_event.c and uap_event.c call this
handler without checking event_skb->len.

Check event_skb->len against the fixed part of the event before
touching chan_info.

Fixes: 8d6b538a5eac ("mwifiex: handle multichannel event")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Huihui Huang <hhhuang@smu.edu.sg>
---
 drivers/net/wireless/marvell/mwifiex/sta_event.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Tested on Linux v7.3-rc7 (wireless.git main) with a temporary
handler-level KUnit regression test (UML). The test allocates a 64-byte
skb, writes a 4-byte event cause followed by a multi-channel TLV (type
TLV_TYPE_MULTI_CHAN_INFO, status 1), but skb_put()s only 2 bytes, so the
handler is called with skb->len == 2. Verbatim KUnit output:

  before this change:
    # mwifiex_multi_chan_short_event_test: skb->len=2 usb_mc_status=1 (want 0)
    not ok 1 mwifiex_multi_chan_short_event_test
  after this change:
    # mwifiex_multi_chan_short_event_test: skb->len=2 usb_mc_status=0 (want 0)
    ok 1 mwifiex_multi_chan_short_event_test

Before this change the handler parses bytes beyond skb->len and sets
adapter->usb_mc_status from them; after it the event is rejected.


base-commit: 25e73f1d6868c759c8eb56cad4e411692c5341b4

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index fecd88967ceb..a9e74f589e4c 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -419,8 +419,9 @@ void mwifiex_process_multi_chan_event(struct mwifiex_private *priv,
 	tlv_buf_left = event_skb->len - sizeof(u32);
 	chan_info = (void *)event_skb->data + sizeof(u32);
 
-	if (le16_to_cpu(chan_info->header.type) != TLV_TYPE_MULTI_CHAN_INFO ||
-	    tlv_buf_left < sizeof(struct mwifiex_ie_types_multi_chan_info)) {
+	if (event_skb->len < sizeof(u32) +
+			     sizeof(struct mwifiex_ie_types_multi_chan_info) ||
+	    le16_to_cpu(chan_info->header.type) != TLV_TYPE_MULTI_CHAN_INFO) {
 		mwifiex_dbg(adapter, ERROR,
 			    "unknown TLV in chan_info event\n");
 		return;

-- 
2.43.0

