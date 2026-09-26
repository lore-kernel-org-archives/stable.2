Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA2C424D59;
	Sat, 26 Sep 2026 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790426034; cv=fail; b=E3SQYykl4pEkaJtgmT6fpxP9XTNuDvVh48QE/6kINH+1M3BjMA1OJ0tCo1g+99qXkP1CfDQbgT8GcP2ODvaXj1eqJnRw6w95P2VR3OrWzppV89dvfvt+JYvQEZfPFMFriQry5c3PVNCTJsJOF3IbkEpeH7GWPzmpRaiMpZVlkms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790426034; c=relaxed/simple;
	bh=nThNKMrUkxlIn7Q23++FxyhRmxph9CmRpxyAcyUm2pU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CRE/xvzDWvubi/sJN70ykRciEuir6lkTAns0MD1CR43OPR5BUA3Hb3jYpfn+NEadLBaYc1fotanwXjNg1XV1K1lXPLzflSzzkqAd7PPfANs5zumQdwuUlXftP7hO4xtYS4WlopEdPYDrknNiwrlC7lSOMrVqxTPh7F04P5LP2is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rVPwgd0B; arc=fail smtp.client-ip=40.93.194.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rVPwgd0B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8kLxk43fiwAu8NIh0f0tEuOeaXVjq7hbkfcyrvIOzXgANVsD/l3axkyLGV2n9ieHANLe4IuT3sUBjwluiXZCWH9+nMEvOslw/B3/oyZrRJ8B23BAfmEfstf5yzd8bxtsePD60bXO57lSWe0haHmIT/cW8jcLVDTX6meao5VxDfeCZkZXID2CD0TRtr4w4R/rz2D18yYNRts9G+RHqwpFGHSegKA3VvSp4KgY4ZYrv17xiM7yO3O1N0OSzvlhP/Dh/Cs+0+KuqGIxu+rEVgtWEyX8PDCy/Emxlt6Z1fuxvUZjqzypKOuN7drtz9KSLQRQ8N3Ml40TTG/dhGO/whqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GfbvaqGw2oXwMQX1/LW4actWb1O9X6dvEgy07oKnAg=;
 b=kRJn4WjJ0AlO4FwL49cR1Lq9/cbZfGibTHUTK3wdzdqNWKNIGJvLobqeclCcr8dXyz6n+2fHWWBWB3ShfHfzQUCktGbZcAqLcWV29trGduWLx5J3dQbBC6Kl4gT17wtIPbnccCmrbOUD8yNj249wbALCa9qU9BGpwp1Ky9j0r3ueiPZk6aA+pzOTMuHL9oDAb7uL32/knGsejcAFcy/2kZUo0kBuiYywMmxyuz15xL7W5LBfWd8Rt4C1OQowUg8M1OtYf1UZ91onVD1tk+pIqPRJvE9XTiO/jYWVjZjNvCfCWfj3xXO4kXxqQhRHZhwjsT6KZKKm0HtsbHuQaHT/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GfbvaqGw2oXwMQX1/LW4actWb1O9X6dvEgy07oKnAg=;
 b=rVPwgd0BmSoXduqj7wLXG7gjNRj+apmfTuxOx9/pmgWnFArg+yXMt/lF7OKeNWBaZSbSDGmej65CbAXa84PHbOXDOVXDd0qfEBg/gzJRHUCFpKUvjHoIzd6IbII7bzJ+jXRNlS36mnO/yx+j8iCnLhBMT0OhUaHRWbEl/7Lqm7s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by DS4PR12MB9770.namprd12.prod.outlook.com (2603:10b6:8:29d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 12:33:48 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%6]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 12:33:48 +0000
Message-ID: <07655491-12e3-41fa-912c-f6ead7c54c5d@amd.com>
Date: Sat, 26 Sep 2026 18:02:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] usb: dwc3: xilinx: re-assert resets on ZynqMP init
 error paths
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, michal.simek@amd.com
Cc: linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260922182125.11067-1-radhey.shyam.pandey@amd.com>
 <20260922182125.11067-3-radhey.shyam.pandey@amd.com>
 <7bfea0211710cc1cdab9ac7235c4f283f2c6d8ad.camel@pengutronix.de>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <7bfea0211710cc1cdab9ac7235c4f283f2c6d8ad.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::6) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|DS4PR12MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ccbddb5-eebe-4e35-732d-08df1bca69a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|6133799003|10067099003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	CM8D0FhULBKvBtrpBrdDIZivzLSHgtEjIZTD4mcnhXD648b1HHcKLgJdahx67vpQd2E4esz28Ys2PpvgSp4S4ygGzfV0l6WHa5WxokFKhAVDrQuf18hF5iMRH50O2/76jjG2EJlblDSllEyknL0LJoI/NmLDkhW3Z7Ur5ja1REwKc0KSw+OMGcStSFKEm+83ycIgFQstHGsO+GAIQMsWAGjenid00O8DxoWsTyqqHEWjb2R1RjMTYPoZ1fOpyW1ejDTcyUHALjkSArwIxKlRWKiQ7v72INI2OEFGemAlcNdsLaOBYppVInsr0YAwjHBnHC3g77Aqav9nA4bIdbQQkEH+KDsIXONc5AhXngzVXlFkocLtxLWGFKSm7STPhrcLArHktFgII9yjLxYmHaCzCAkxvgbMgbUazlGgCiz2Nuxtdj17NwxuV54y53PY00IUKSer1BQClxPcJlw6EqFkr3r+wlMG3ZlieU6qTGiivemfsh19RouGn4WUKtDyo+Upc3vywTsxIgDKyBQ0VbpnpedOHQ87/XTSnDSAWevLTNa52q2rXAK+GyhDsorY+5y8dIfdzUXXq1g3A3v3XTMZZLoRUxkvYvWWNvAryem55s5pWFWNT2ZmfNo8FJraJouJMGpzW4QVPiBx89/enooWfU+SbHNGY2d/LUvxrrjqQLw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTBhY3pYbmtKZEE1Tzk4dG5EYmt2L0tLYW1JMU5QSTM0anEvdzUvTFFSYk9a?=
 =?utf-8?B?eUJEVlVPZkxzaWpBNXVUeWpFUmhoQmRPa20xb091T3BqaVh2K003dVVtL000?=
 =?utf-8?B?TGRHeFBZOFhsWitrUHBpUi9aTDhUU0tPbDNjdmFRb3pWK1hQVHdpWUd4OUNJ?=
 =?utf-8?B?Q2o5cEpIT3piZm4yWi9DNXdJZjlwZ1M5UEVEU1ExY2RubDg2UWEzeCtZbUtJ?=
 =?utf-8?B?a2VGa2lPUGhkd3cvNlRCQ25LZitRT0NMdCtOZnFtNWJiOUZwNk9Oc3dNSS9j?=
 =?utf-8?B?S1ZONElxWnpPMWhwQUJmOW9Qb0ZkSmJTUFNKTVJNYXpaWEM1Tmk1UDFSVGNF?=
 =?utf-8?B?S3hheU90cWJvSTEySUU4di9vZFRTZDFjR25kMFhHd2JXRDZZblY1ZHNUczBE?=
 =?utf-8?B?SmQxZ21wWU1rU3daaTBXOWJVVURaV0NnbUc0Y2o1Ulk0cm1MUzRYaE9SUzkx?=
 =?utf-8?B?NmlwU00zRS9SSElqT3dLTEl6aWJYa3dvOUpUSU5vWXJlVzZoR3NhTjJKQkFZ?=
 =?utf-8?B?ZTRBSm5rUlpkUTFGZ3NtMU1SWHkrWWlyVnczWnNiSk1nNjcwSThwZHdzRmZZ?=
 =?utf-8?B?ODNXU3NjZm55VTNtV1diaTVKSDNjTUZJdFQ5dXJNL2pJdzhPbGl1WnIzZUtD?=
 =?utf-8?B?UXFWUU9YcXNTZkFrNlhaSzNkU0lBQTdTOU9obGZoZlVucE1mMFh1Vm8zZkM0?=
 =?utf-8?B?a0FtcGJhb2w5OUxER3lBUWdydWdjeGNUdU0wTGdtU3RJTWtuMWI5ZGpqSlN3?=
 =?utf-8?B?QUk2bE95MmFPaUx5N25TRzJqWWExMkdacHFwdVZydGYzUmxaM0ZlU0c2d0pZ?=
 =?utf-8?B?OThha29BUGVpL0l6UHVUMFYyMlpOZkFzckFKQTNRYlYvWHBoNUlLR0VXQWw4?=
 =?utf-8?B?bUtQNU1wLzZRTE9FdlVwM1hBdCtnckNBc1pTeGIzSllCcnZacFRXamtnWHg1?=
 =?utf-8?B?aXk1d0JOa1A3bmVDUzVPVGVCNWFIc1JCQTBFNDhGek5IZW00aThPRy9tMXhk?=
 =?utf-8?B?M2lDbUp0aFFweDVWbVVhSmV1NU9lTXZkWWM3M0JoTTh1eFVmTXVVNisxOUda?=
 =?utf-8?B?T2dmeThEWW1STlppc3VocXdOa1B0UDBJRkIzM3V0OXpjU3o4VE84MWRKbVV4?=
 =?utf-8?B?eHVFUCtVM1dxMGZ4c0NhT3BjR2REM3V6UHBudnBkMTFIMDRRazhyTmlxeWVV?=
 =?utf-8?B?WHFFWERXOWpEQXdRb2xGRGdGTDVFaktYN2tRMzFmQi9pNTZ2SFFQbXg3MEI2?=
 =?utf-8?B?cWVkQm9BSVBROFlKRVREU3cvL05sRGpJYWVLWFU5R21zQ0NyQVN0aTY3NnBk?=
 =?utf-8?B?RWtCL1lxZ0FJSWJwS0xQc0s1ZlNadEQxQ2Y0MzFsK1hhZ1ozOGtISjYwWThj?=
 =?utf-8?B?MnFGWmdRYmphREtkR0FCYm9LNjVVYlRzVGhuNTB6QVFIQ2UzME5yODNNbmNE?=
 =?utf-8?B?Z1lsNzVqQTlZakhsVWcxSStjSEZwOGw4b1hQdVhTZmRzZXhQcGlTb240c1ZZ?=
 =?utf-8?B?aEJaZlI1UjZVMjFiSGtUTS9IYWdlMFBRSE5yTjF0REZzcklCdEZhSkZTcjlt?=
 =?utf-8?B?UXZzQnQzSTFUMVFXU3Fzbm43WWJOWFFKTjhtdVl6bXArdy90NWQ2ZThQai9q?=
 =?utf-8?B?QmU2cUtiYmVrc25iQWlUU3pNYU1qcmwyOFFhM2J0N2xUbitKcWNHV3o4TkZi?=
 =?utf-8?B?VlBrK2haTDVOVUZETFlQREVmZ1ozQ1lZTFVzVWQzb2h5SHphSUpyVFJHY1lT?=
 =?utf-8?B?WXFMU01KWkRYWHNqc2U0bEVubXJZYWlOZ010QlRxQjBNbTBNTlFVWDJFalJ5?=
 =?utf-8?B?Qk5yMFhFWEtVamlyTnJ0VGptSjUzOE5abW9BY2JRVVFKWk1vOStDNCs0bk9x?=
 =?utf-8?B?d2ZONjhkdkg2L3lMYUtrcElrd0R1YlVhVkN4T2REb2RQa2YwdTA4RkMvUmJC?=
 =?utf-8?B?Tkt1RjBISkgzY042YklNNTJNT0prRlZMWUJKSVAwTHhndzAwYmpHRUNtSXAw?=
 =?utf-8?B?L0x4cXM0QVQraHdpb1poQ09WWis5WE4xekNTZUUzOG1ZcHB6ckY5cCt3cjdo?=
 =?utf-8?B?RUZkQjJ2MnFPQVcybTBodExPTkp6T2ZvcXJuUXJyWVovQlVkL2N3czM1Nnp5?=
 =?utf-8?B?RHZ4MG94QWI3Q3NEWEdwajdTcVByL0IrdGZTMXFQNXRqQW1iUUx5cmRHam9h?=
 =?utf-8?B?cFFMamx0OHB3Yk5LRzFzZkUwY0ZVMi9GMDZqRGR2M0ZJanoxZDFqNW1WUkFr?=
 =?utf-8?B?ZThUWkVjL2M0ZjFpdEVTRjNublVxLzVNSzNRZDNQRU1KWFI4OWhaY3Z0Q2Qw?=
 =?utf-8?Q?laMLIsMQ6vF+AiWnSq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccbddb5-eebe-4e35-732d-08df1bca69a6
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 12:33:48.1397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7X8MzTzuHi/bjavC7Wy9rhXMt3KoYPfxjq/Fs0lMNfdUJzIH8bGw9SjzUH3bm8Nx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9770

On 9/23/2026 2:43 PM, Philipp Zabel wrote:
> On Di, 2026-09-22 at 23:51 +0530, Radhey Shyam Pandey wrote:
>> If reset deassert or PHY setup fails partway through
>> dwc3_xlnx_init_zynqmp(), re-assert any resets that were already
>> released before unwinding the PHY. Use fall-through error labels so
>> unwind matches how far init progressed, for both USB2 and USB3 paths.
>>
>> Save the ZynqMP reset handles in driver private data so later probe
>> teardown can re-assert released resets.
>>
>> Fixes: 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
>> Cc: stable@vger.kernel.org
>> Assisted-by: Claude:claude-opus-5
>> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>> ---
>> Changes in v2:
>> - Split out of the combined five patch series; see patch 1.
>> - Reordered ahead of the platform-data cleanups.
>> - Added Cc: stable.
>> - No functional change to the patch itself.
>>
>>   drivers/usb/dwc3/dwc3-xilinx.c | 49 +++++++++++++++++++++-------------
>>   1 file changed, 30 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
>> index 8c63e02575f1..d18d3e364381 100644
>> --- a/drivers/usb/dwc3/dwc3-xilinx.c
>> +++ b/drivers/usb/dwc3/dwc3-xilinx.c
>> @@ -48,6 +48,10 @@ struct dwc3_xlnx {
>>   	void __iomem			*regs;
>>   	int				(*pltfm_init)(struct dwc3_xlnx *data);
>>   	struct phy			*usb3_phy;
>> +	struct reset_control		*usb_crst;
>> +	struct reset_control		*usb_hibrst;
>> +	struct reset_control		*usb_apbrst;
>> +	bool				usb_resets_released;
>>   };
>>   
>>   static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool mask)
>> @@ -112,7 +116,6 @@ static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
>>   static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
>>   {
>>   	struct device		*dev = priv_data->dev;
>> -	struct reset_control	*crst, *hibrst, *apbrst;
>>   	struct gpio_desc	*reset_gpio;
>>   	int			ret = 0;
>>   
>> @@ -124,25 +127,25 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
>>   		goto err;
>>   	}
>>   
>> -	crst = devm_reset_control_get_exclusive(dev, "usb_crst");
>> -	if (IS_ERR(crst)) {
>> -		ret = PTR_ERR(crst);
>> +	priv_data->usb_crst = devm_reset_control_get_exclusive(dev, "usb_crst");
>> +	if (IS_ERR(priv_data->usb_crst)) {
>> +		ret = PTR_ERR(priv_data->usb_crst);
>>   		dev_err_probe(dev, ret,
>>   			      "failed to get core reset signal\n");
>>   		goto err;
>>   	}
>>   
>> -	hibrst = devm_reset_control_get_exclusive(dev, "usb_hibrst");
>> -	if (IS_ERR(hibrst)) {
>> -		ret = PTR_ERR(hibrst);
>> +	priv_data->usb_hibrst = devm_reset_control_get_exclusive(dev, "usb_hibrst");
>> +	if (IS_ERR(priv_data->usb_hibrst)) {
>> +		ret = PTR_ERR(priv_data->usb_hibrst);
>>   		dev_err_probe(dev, ret,
>>   			      "failed to get hibernation reset signal\n");
>>   		goto err;
>>   	}
>>   
>> -	apbrst = devm_reset_control_get_exclusive(dev, "usb_apbrst");
>> -	if (IS_ERR(apbrst)) {
>> -		ret = PTR_ERR(apbrst);
>> +	priv_data->usb_apbrst = devm_reset_control_get_exclusive(dev, "usb_apbrst");
>> +	if (IS_ERR(priv_data->usb_apbrst)) {
>> +		ret = PTR_ERR(priv_data->usb_apbrst);
>>   		dev_err_probe(dev, ret,
>>   			      "failed to get APB reset signal\n");
>>   		goto err;
>> @@ -156,19 +159,19 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
>>   	 * absent.
>>   	 */
>>   	if (priv_data->usb3_phy) {
>> -		ret = reset_control_assert(crst);
>> +		ret = reset_control_assert(priv_data->usb_crst);
>>   		if (ret < 0) {
>>   			dev_err(dev, "Failed to assert core reset\n");
>>   			goto err;
>>   		}
>>   
>> -		ret = reset_control_assert(hibrst);
>> +		ret = reset_control_assert(priv_data->usb_hibrst);
>>   		if (ret < 0) {
>>   			dev_err(dev, "Failed to assert hibernation reset\n");
>>   			goto err;
>>   		}
>>   
>> -		ret = reset_control_assert(apbrst);
>> +		ret = reset_control_assert(priv_data->usb_apbrst);
>>   		if (ret < 0) {
>>   			dev_err(dev, "Failed to assert APB reset\n");
>>   			goto err;
>> @@ -179,7 +182,7 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
>>   	if (ret < 0)
>>   		goto err;
>>   
>> -	ret = reset_control_deassert(apbrst);
>> +	ret = reset_control_deassert(priv_data->usb_apbrst);
>>   	if (ret < 0) {
>>   		dev_err(dev, "Failed to release APB reset\n");
>>   		goto err_phy_exit;
>> @@ -195,21 +198,21 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
>>   		writel(PIPE_CLK_DESELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
>>   	}
>>   
>> -	ret = reset_control_deassert(crst);
>> +	ret = reset_control_deassert(priv_data->usb_crst);
>>   	if (ret < 0) {
>>   		dev_err(dev, "Failed to release core reset\n");
>> -		goto err_phy_exit;
>> +		goto err_apbrst_assert;
>>   	}
>>   
>> -	ret = reset_control_deassert(hibrst);
>> +	ret = reset_control_deassert(priv_data->usb_hibrst);
>>   	if (ret < 0) {
>>   		dev_err(dev, "Failed to release hibernation reset\n");
>> -		goto err_phy_exit;
>> +		goto err_crst_assert;
>>   	}
>>   
>>   	ret = phy_power_on(priv_data->usb3_phy);
>>   	if (ret < 0)
>> -		goto err_phy_exit;
>> +		goto err_hibrst_assert;
>>   
>>   	/* ulpi reset via gpio-modepin or gpio-framework driver */
>>   	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> 
> Are the resets asserted if this fails?

YEs, if reset_gpio fails resets are asserted.

> 
> Same question about if probe fails after pltfm_init() succeeded.
Valid point. In this patch, only the init_zynqmp() error handling is 
fixed; probe failure handling is addressed in the subsequent patch.

> 
>> @@ -226,10 +229,18 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
>>   
>>   	dwc3_xlnx_set_coherency(priv_data, XLNX_USB_TRAFFIC_ROUTE_CONFIG);
>>   
>> +	priv_data->usb_resets_released = true;
>> +
>>   	return 0;
>>   
>>   err_phy_power_off:
>>   	phy_power_off(priv_data->usb3_phy);
>> +err_hibrst_assert:
>> +	reset_control_assert(priv_data->usb_hibrst);
>> +err_crst_assert:
>> +	reset_control_assert(priv_data->usb_crst);
>> +err_apbrst_assert:
>> +	reset_control_assert(priv_data->usb_apbrst);
>>   err_phy_exit:
>>   	phy_exit(priv_data->usb3_phy);
>>   err:
> 
> Rather than storing usb_resets_released state, and then having
> conditional teardown in the next patch, this could be handled via
> devm_add_action_or_reset.
I agree on it, it simplifies the error handling and will spin v3.

Thanks,
Radhey
