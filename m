Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19011077.outbound.protection.outlook.com [52.103.32.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777423BED38;
	Sun,  6 Sep 2026 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788737831; cv=fail; b=bxnEH9N5pnoQsxl0jevMCwCG8gkl5ox5dEVjcn+kQ7v/htTxsUIA3bUsPqxILOgeoBhtfhFnWwr1CxnfZvWpO1LwHKyoRBCoDn3PmOA3mMOzQq2DffAvIDAI2NHx/gmmuZEAlUbU9qBkNvfW0ENMrX+O4yjW13PaP2G8xM43psk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788737831; c=relaxed/simple;
	bh=lnMsMGRtYKVBdbXE8Mjg0FTfezZl/KnLsttGc/0Hw0c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Gs0GdQEy4Sr54KAvfrfv9UaDKo2vixrTzh0l5dWpuXu+WL/Ir0mHgihV8xODBwLal0B48wAaz8TR/dz356k7ZcOOo+8ijCTk4LA4DcalfFOUQm27nG1YjnidaA4X7P0xybVv/LrUY1nrhLtsi9hTetA8AoPKgLKlxG9uKLLTPQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=uTivi8MZ; arc=fail smtp.client-ip=52.103.32.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="uTivi8MZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Am8tQ1IPXk6D+nbfPC4GclkgHocEBNjkJFF3Kpo8c2ivcRYDPBNOYmO977EnXQr6O8UdCD/8R+XJ9Tk2bQEy5ZOyzKSqugfY9GR+nzPSeTt+YHrrgEuDSq6gPaHydmL8wirj34iDkyhPEkX6YYOkZksPJ+RhsX+Zn/Mx/VpJZxe/JUdhIk/QT+5oA91hOsgBvRJH1mfJvnyHeyO3A78erbMxpZUFsiC8THsW3E2811Rq1aoVIkPhg88ISt5fPP3k20AGchFJp66vsjFtpfJ247O0vfprUI9GR6lqiwFrmKxXH4fYqVOZddWEBKbTP0tg6MqGo2hqC7WBZNXP7ZoFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoLpxzJXBBhezON1aJ0acIdpRsL5fIciqN4C7oojW4I=;
 b=TuTHPFgpXRiMN0S+UO/useB/riL2mmbufSCpH78yBc6xYlZRsP7jw+n3eA0hiGsIFnVf0tuz6pLvg4rHpoN6BaaRWWJuczuNsjiDIFXTnU8nFKRT2QBHTPcxPpHVaQjeSa0316zwYDVrfO5de4V9/XiGsRO6ya38QkidMkmNVUcpFcoRAw2iE93cV7aeedPGOdErjvhgfucR09eFqrOmIeSfMgfn2NuAtdnd4qF4RfCLs+Z4cwX9afpBNoCxhP8uFiGNl85RrWhq5D8pEoJ8wlylIjwOmOnQSkrfgCnGIiVFQWKriVNMT1coPZFQMnkmIcyydQ7QeDv0MjvOT4Rznw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoLpxzJXBBhezON1aJ0acIdpRsL5fIciqN4C7oojW4I=;
 b=uTivi8MZaRm6wdplH7li2nUWLjfRa45PfNxajH+fRSNL9pRWohtoRYghy0Gtl3h8r9s6yFru6FvPSFY3+Cq1W2CdRCT/4eM5JoNRAeRmu/nvJpx6mDAEPhdXkodgglPgm53aHfqacLUeg3ryFpdlKTiA4h2sznBOrmyddX4r/bnJ1qW8pjIcIaDuDDr8OQX8MU82vWIJMmqHaGaK4x/jIzMDlVawr4t6vmt48EODxPyluNjEgoDSfK5cfanU4+jMkiSEA9vWcnWET9tWKi10TSMa7mxHF87S6I9Fmkk7YdpRx3V79HpIKvSejDZ3iWbb8mxuXKTTfnxVjwWRTaOdgQ==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PAXP251MB0113.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 23:37:07 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 23:37:07 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: validate scan response TLV lengths
Date: Mon,  7 Sep 2026 00:37:03 +0100
Message-ID:
 <AS8P251MB0001DD15CC44F76B4BBD2853C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0188.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::13) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260906233703.87706-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PAXP251MB0113:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e7bdcd-cdb1-4f4a-2948-08df0c6fc39e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|5062599005|5072599009|4140399003|15080799012|25010399006|23021999003|25031999004|37011999003|19110799012|8060799015|12121999013|440099028|3412199025|26104999009|52005399003|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d3W7XkMyygFTrferilSzR3SZYZ75AMFYsxAFl46+mAuAAmboQp/eDtA9yxhw?=
 =?us-ascii?Q?dowth8w4MxJP2BiLL4TAFcxuUrup3vz1o/igcyWW0qPZriRYUf+KxcLY/5sY?=
 =?us-ascii?Q?RilFwprGs6yuBCUMZARFCeauATc8Vc66LywMCGuXFNsEOhyqz3Gbuzr97jzd?=
 =?us-ascii?Q?/0v3ykoNQn/htEaEEM82Xeadwq1N6KUzTViHr3nqTX9xYJS3UA9thvGBW2cJ?=
 =?us-ascii?Q?JgtZq9xiXlTr/ZZBrWOWOF3QbCnj49/29xTRAnuBRi5zup1yvOMR/wDixvZR?=
 =?us-ascii?Q?5FDdsnB/hFh6PJohhd9dBbfi03Va0C3wEEPyfHR3MzHp6dxmvXak4IgsurS3?=
 =?us-ascii?Q?75vKgZataIGoWg6dcEysSNTe24+m7BDyUPQulXCrfcsB1Ln5OWO5JV9FLXgP?=
 =?us-ascii?Q?LLI0vzf0HCrREUZDj+K/8x6VCV96d6b3P7K/L8kHdnQEEJUu7mV6vuyJ3eVw?=
 =?us-ascii?Q?mOWwbqFGPe7b0r009LmGNZXHG2k+/fe8PzP+Mc3H3jT5n0N1irQ/eZH98dyV?=
 =?us-ascii?Q?AW690IZSC3roL3ZhfA/f1FmncUWijZs1JLzHUHplt4FDgRHALKri2n61reoi?=
 =?us-ascii?Q?Nv7aMxLbQq1y3jqBM/0yMiW5Du/GtjC9UsJaixPPzfLaFBZL+12c1HkluFv8?=
 =?us-ascii?Q?XuIGEKe4rrFF/GboDlKYuNsWfU/2vSJjvDRJrkhpU8ICfQYezEB/NSlh66dr?=
 =?us-ascii?Q?J8l5vd/ehd7VHGHUWd2fenv1slxHzoRi5whyTXhVaIDPFfUfQOxoTWfN7cJP?=
 =?us-ascii?Q?1LIEwRtM/T8NkYAfk6FwIoxmUbx4iRqogI/CihVEfnwGnpYV6yzpm5fv/spu?=
 =?us-ascii?Q?94YVuO375mQyUv8ept9TUVHJkX143Sr8pe1gRL+rE1twURHSEggt2RppzCBv?=
 =?us-ascii?Q?eY3YUeVI48XEeLC31unrwIDutfMKIbjG4iBkHBe+R3Je2Qmq+weOMimRRLat?=
 =?us-ascii?Q?2GUTybpcPnOWO1rsGlky5zZcSKUmTzEJncIZ3Vwj9KnjZ5KQta+g/ZvIZsi9?=
 =?us-ascii?Q?W5UgJzgCzkiyNQ9GbW1sXoKu8hTp1iO4c5p+tlePDpHKtWpWQObtYvSZfsYi?=
 =?us-ascii?Q?OK81IOPs6fdylpR8XZkOrRbj/kK6eoYqMtkqlCnEJ6Rt/GUYSxo=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WHtpqP52I+ekIz3pCUo0ALqi2fkvtzvxaCLGaHNeoYTuhEi7Mq/xdPUBI4FW?=
 =?us-ascii?Q?inSoZY9x3Czt0GHpfCnA89NVykbKMQzoNPBEogTDf+hYVmDDxFjXnXlvKKu+?=
 =?us-ascii?Q?hvn9wXuyl7rE7Mh6YaVGUkFvVONeLexuFNqfPSkZRKKsTRb3sA07J27pl4qr?=
 =?us-ascii?Q?lmpr6b7WtPr8D3Iq8b3jkaBDW4QQ7regycupaovHZmPuW55qOvBvZT85J+lq?=
 =?us-ascii?Q?pacYdcHLldHTM+u9vv4Ntcnt6DZ9X+UGHeZVhcWkzVm+Fp8gpe79GzABjYFv?=
 =?us-ascii?Q?0kVdf3bl5FY7+fJCxWQ8Wn7iQDE7LaunUAlIrKeZKlwcp80NpVQHjKo/iXFT?=
 =?us-ascii?Q?WPjh8qD0/gvPky6bNrOAcdcAgvIzJgqZnqlU5tdVT2qlvQLVGXrkEiOZR4a6?=
 =?us-ascii?Q?K4VTgSloLqyNA4T/3B8XyW3gJf2QP8xieBuFuR3JXQV2oBnL3lFq9zrEZXWJ?=
 =?us-ascii?Q?G+yBwNPKcBK84Af/iOilJpbkVJb5PYXj7HRCMRFsdWX85ZbJuvreJQlxxZpw?=
 =?us-ascii?Q?GL8FbNqBK2NMj1ZXaxk+kUc+SjhHcPIcBpu/tcOIJiFSZ/sWZ4mI2RDAGKqZ?=
 =?us-ascii?Q?UEYh1RCL4VJM6s1/IuKTdHMv1l/cpnG1Fv55Vw/ro+pP7qKGXJqMlPQrRoc2?=
 =?us-ascii?Q?+o3GtPb/RLo63Ys/l/6RnC+rd6v9imd8trwd1MjfdwATBGy9tYep9myMFaG9?=
 =?us-ascii?Q?Nc6ScotlTJbyrCDYZoDFW7tIpWY0cWMqeP/KErQMsqYpEYZ8jr6pcyDonSfn?=
 =?us-ascii?Q?h3WYCKI8WVFrNE4zsH1FVHL+1E7DRQ/3H0dwTTnS6eyDskQRKVrAW8MeMzbo?=
 =?us-ascii?Q?65R8FHpJkEK1FtmdmrMvJiSmwBjui2HMG5X7Npb4AKBQfx8PBqxFEoX95iBz?=
 =?us-ascii?Q?D7FHn5UwC3o3A/s52uyx/QNxbnHy76I7JL0fiWZaI5hqYtc9I7XgsYUlKY5p?=
 =?us-ascii?Q?jBmgn5+Td8x0rrnvmM01pUYiHYz9GiZX7/SFqWS+EFgOQiWTD/LNveOPpxf+?=
 =?us-ascii?Q?grSGCeoZ54aCkRkMcnaDaY+IBV/RuuAajK7pDMsKpLR7Jr2mkruchpUeTemG?=
 =?us-ascii?Q?AvnduPaMFNhtay1LccVJPf0VlaD7RfMnGUQi0QBt4jvWhILalC6QE62TX1cy?=
 =?us-ascii?Q?1gQDOvkZM/FcKOP5rzmm9syEPJOAXrJEdJRlPJEWMpFAGq8R76fHv/4b2GFi?=
 =?us-ascii?Q?4uMpP36f4SvXDyKlOvpvw+khSI4PU7fuXILpn4i+xTWoW9XNSjFmfkZoPi8C?=
 =?us-ascii?Q?F18cIBlFckRgv3xGbMt+o+s6j4TfchGhJJMcS6ghqu6WCrZbdE4LGYidTJtz?=
 =?us-ascii?Q?BS4pXDl4bExP9WN4B9zAN8+HXvWh7PIg6pr/R8yrHdJTM3mETNMLCpGJtKn5?=
 =?us-ascii?Q?C9ZoOyX8oRXOrIC7x7wfX2Ba+vNIux1I0yDQf/v544xpCtHfXiNfbJUKnE17?=
 =?us-ascii?Q?mrjltm9ujWX4eMLSzWjHfPwjIX76VBuv?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e7bdcd-cdb1-4f4a-2948-08df0c6fc39e
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 23:37:07.5193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0113

The scan response handler mwifiex_ret_802_11_scan() has three issues
when processing firmware responses:

1) bss_descript_size is not validated against resp->size before being
   used to compute tlv_buf_size.  If the firmware sends a
   bss_descript_size larger than the response, the subtraction wraps
   to a huge u32 value, causing the TLV search to read past the
   response buffer.

2) The TSF timestamp TLV data is indexed by number_of_sets * TSF_DATA_SIZE
   without checking that the TLV header.len is large enough.  A firmware
   response with number_of_sets=64 but a TSF TLV with only a few bytes
   causes an out-of-bounds heap read.

3) The channel-band TLV is indexed by number_of_sets without checking
   that the TLV has enough chan_band_param entries.  Same OOB read as
   above.

Add validation for all three: reject responses where bss_descript_size
exceeds the response, and invalidate TSF/chan-band TLVs whose reported
lengths are too short for the number of BSS entries.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Cc: stable@vger.kernel.org
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
 drivers/net/wireless/marvell/mwifiex/scan.c | 27 ++++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 97c0ec3b822e..4d0f3c412a90 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2137,11 +2137,18 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 	bss_info = scan_rsp->bss_desc_and_tlv_buffer;
 
 	/*
-	 * The size of the TLV buffer is equal to the entire command response
-	 *   size (scan_resp_size) minus the fixed fields (sizeof()'s), the
-	 *   BSS Descriptions (bss_descript_size as bytesLef) and the command
-	 *   response header (S_DS_GEN)
+	 * Validate that bss_descript_size fits within the response to
+	 * prevent an underflow in the TLV buffer size computation below.
 	 */
+	if (bytes_left + sizeof(scan_rsp->bss_descript_size) +
+	    sizeof(scan_rsp->number_of_sets) + S_DS_GEN > scan_resp_size) {
+		mwifiex_dbg(adapter, ERROR,
+			    "SCAN_RESP: bss_descript_size %u exceeds resp size %u\n",
+			    bytes_left, scan_resp_size);
+		ret = -1;
+		goto check_next_scan;
+	}
+
 	tlv_buf_size = scan_resp_size - (bytes_left
 					 + sizeof(scan_rsp->bss_descript_size)
 					 + sizeof(scan_rsp->number_of_sets)
@@ -2158,6 +2165,12 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 					     (struct mwifiex_ie_types_data **)
 					     &tsf_tlv);
 
+	/* Validate TSF TLV has enough data for all reported BSS entries */
+	if (tsf_tlv &&
+	    le16_to_cpu(tsf_tlv->header.len) <
+	    scan_rsp->number_of_sets * TSF_DATA_SIZE)
+		tsf_tlv = NULL;
+
 	/* Search the TLV buffer space in the scan response for any valid
 	   TLVs */
 	mwifiex_ret_802_11_scan_get_tlv_ptrs(adapter, tlv_data, tlv_buf_size,
@@ -2165,6 +2178,12 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 					     (struct mwifiex_ie_types_data **)
 					     &chan_band_tlv);
 
+	/* Validate chan-band TLV has enough entries for all reported BSS */
+	if (chan_band_tlv &&
+	    le16_to_cpu(chan_band_tlv->header.len) <
+	    scan_rsp->number_of_sets * sizeof(struct chan_band_param_set))
+		chan_band_tlv = NULL;
+
 #ifdef CONFIG_PM
 	if (priv->wdev.wiphy->wowlan_config)
 		nd_config = priv->wdev.wiphy->wowlan_config->nd_config;
-- 
2.43.0

