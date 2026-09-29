Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013045.outbound.protection.outlook.com [40.107.159.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654D833EB01;
	Tue, 29 Sep 2026 01:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790646204; cv=fail; b=RSmRR7eWUSbizcbno1+EuJyezvWz2aHAr+v1TVMQNt0+ihodok+vVR6oUl5xhJvKZSMdaZe08i4GH1rb20U4uyb03mHMYhvCQGJOfjhKVTPulFT8X4CDf5AJgG3g88cb/BwWIlGJU8csDPHHlEPrq35nR8EUe6M1LbgMwUWVDkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790646204; c=relaxed/simple;
	bh=Rk252cLddjqu9PJ5O4kVOn9dhX9gsEEgsCEz1EMgDMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=atU47g8WyCdI8l1fewqXvpWUJZKdRaqI1wqlBt5mFPF1+o/uFNUvSndFxz5W3ZUiqFt6n0F/np+OKGzLAow+W7JrZRTI9HO+McnA+zBZ4dbD17Hx67YmIK1LekwO3waBh5+JNePTZ5dAa8B1AlCxiuueEM2u6011Eg42TuPo+TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DoHozmpQ; arc=fail smtp.client-ip=40.107.159.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DoHozmpQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vo0bLyMDmcsWfMo3rFexcRIOHnXgTiPOveQ7gRCSjw1/XU7xKYPf6oGqY/gGB5UZGciNGSZNU8euIflZMHOgpKa13d0cOoNLMQE7/fjoShsuABelmu+SKLITQVQ3is3HRUt+XR0KsSOzJrNJE3cfPwO5EqM4lF2YRnDm9JyRLs6hCgikvMYKCWKR+eNUFcG4LgquClPZcfllNMcxN1dDOXdZgnsLHaGhERNMonmBkXvudbWhwNLD80p7+4f8SwLNP2s6MYy5VHrAymsaFALrlOGhfeB7b2IzTBIGztDdTP6JlSEu5Ef33ne3FlDo8C0NWED5YqnRdaybxE3WmiQPPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDumGtNlxVezepwRXgjrcjZAsAOmuecRXHXfvCius64=;
 b=l4El9jG+gChKpa9vBtdr6vYOPWbV4KtTJakH+qNZS2q2mLVD/THenatcjAAnnUWqAuyR+3kT/hnbeLvWgd6wsHmDEgImXs2d9f2X3q5mGQcXD3rzT2VaCKthCw8yYAUA40qr89AK5+MG8qM3R/xsO1kCxj3SYfOHMd0GWWdzQn0YKE722nKrIQibF9OWI87fX/qGlmY8WPNEfZxqjvPZfiBCMBaO8wotWS8kw2DbGiGtYlNB71rOIc7Q3UN4NXJbI63MvbK/UmnGhUVmcljWef7KagfPSMJGVqarkhRa8r50qWpbmQh035p6lS8aAVnsyQbxFJdKZJ+zPQ6GEur/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDumGtNlxVezepwRXgjrcjZAsAOmuecRXHXfvCius64=;
 b=DoHozmpQ/vbEhzaVRQ0tfYVCN723FCQ7JITCpVutv+cF7L0jvoqR75EIxeuoWbrrbRyVxgq4mk/RphtHzNNwPO+l6G9AjYjbSyFfqFG10YpjG2EDZeOKZk6LD7Cu5mXRK5pLpnT6bzJ3uYdWxMPrCunYBvV2c3u33vqgeoFaFbIoa4JviuZC0BXrCg1HSnNTUz4f1iMICzV1uiYwb9dFJ2sxKpMLYTmyRj3L4P/L7yjggtsxf++xNtZJIkX6GKVi+EIPAT9nzVA5dVoE3UxrOuOjs/9Mh2s3Pv6GFUPYfYJvY3q604XeOa/czau4Sj+nPWbePNAxblH9tGTda/A+gw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI0PR04MB11671.eurprd04.prod.outlook.com (2603:10a6:800:302::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 01:43:17 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 01:43:17 +0000
Date: Tue, 29 Sep 2026 09:47:42 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: hand off fwnode ownership when shared
 fwnode owner is rejected
Message-ID: <arsYvrYaQIr1lwbT@shlinux89>
References: <20260928-driver-core-v1-1-0846bb8e0f32@nxp.com>
 <20260928-conscious-spectral-manul-19bc10@sudeepholla>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260928-conscious-spectral-manul-19bc10@sudeepholla>
X-ClientProxiedBy: MA5PR01CA0293.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21b::17) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI0PR04MB11671:EE_
X-MS-Office365-Filtering-Correlation-Id: e7299794-980a-486e-d49e-08df1dcb0897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|19092799006|23010399003|366016|10067099003|56012099006|11063799006|3023799007|6133799003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jaNah2j3exzWwJYvCWyglOx66/3UNsnWfOvRAtDIlTbrO+LUlMJrVVqHSKfOE0QtgULQTQRNpvuhno6+giPmPoHaI80zaiDQ1JVbLOnb4eELF9BzEzEO7Owc2m2j8b22f/uKvMtWWzp+aCiev/FuH5TplB8hyuRdL7WFdoHrHsBrG2P/Uw7+J5EQLPG2UhIFA9Cw0D21/73Nb3vg0KJZT75d2goUbBnpyPDwuVYU8FxGWsqobq7cbGkeadxR9ElJpXA24DgEH5ohqrklb1RQhBXvntLOSYErrolwEwSpE9R5kBv8GQULNEYQhoisF7E+kO9qxcsb5zPnUovPfu0QsggdWfIR7mLXckCfwi3wjAOuqSBfsEzTQdvs2gLCTFDkmB6sRgj43XXjaXi5xOSrtA5yUnS5YGExktL6gpop0EoT//RT50AuTfsZveZRTHvucJ3glMgifaMBsOxs5mcsxxgcPQ3EWGT87t569trN9ZGerEmfaOkHCrso8/p2eCWecaOi3EYTKusHj7AnQvrEFszH+LRi38Dg7amkCRQcZvSChmVuw1vZbwSlpiqiEFPEvRQuMezXxAjWwLD9ijk5r7xiwuMMy746kgkP3kD4foDNBrWuIFg08/5J0IQQExZ0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(3023799007)(6133799003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzhpUHAxSWFRRkFGd28zU0FZZndvWEhmTDdhM0dVakkvNnFIY0d1VEdSVEgy?=
 =?utf-8?B?aHBnekZ6eVFtT3pYNExQUVE1VklUOUJWZ3AxNFFUVGJKaWFnNGF2VituTzQ0?=
 =?utf-8?B?TGtGdmN5cGdiZmdtblVjdmdwQ2VqWm5kWkFlUGtPcHZNOS9lWFN2RU5mN2x3?=
 =?utf-8?B?UHpZR1pqMW9zYXEyMVZudU41YUYwazYxVkdxTnQwOUVic1ZhQUxPbmF5N09R?=
 =?utf-8?B?NFQyMnVxWFVIWVdkZ0RjN3VudUxzc1pBL0RpRFlITUxydDZNdmZHdzdGMVNG?=
 =?utf-8?B?elc5WSs4dFdNbytQRGVrRm9vV1BlTVpnbjRvRzhwMi84TXk1Mlp5SW9FMTFB?=
 =?utf-8?B?cmZoMGE5NEY4VTlQa2xjelhiU2J1VmZ5T2NCZlo1RkI5UzRmUEtySWlGRkNF?=
 =?utf-8?B?WjRRSzY4SFNtaHRqSi91ZUlMMmFNSHhBdzZCeUYreDAzLy9LZkVMejA1QmNO?=
 =?utf-8?B?dXFTbC9DbWUrRG4xWnB3aFJDWHhRTVhNTnFMZnZQMndYbEtDWG52MXV5b29Z?=
 =?utf-8?B?bVB3aE5UOTRkVkNGekZQU0k0U2NndW12KzZPaEVVNmo3VFJUWVRSZHpmdXlU?=
 =?utf-8?B?NHlweHRwYUtzSTJIaG93dUtzMld4ZTRkZWxhS29idHFQSHphQURPeTJiVzVU?=
 =?utf-8?B?amJEeTdCc2dCWjZ6OVJVWkowd1FQVUxGNWVWZjRRZXZtem42ZU9MVi9mbGxE?=
 =?utf-8?B?NWxrT1JDcEZSMTh0V1RYemJ4ZXl6VTl2ajh4ajJtNFpZRERVS3FlKzJGalVm?=
 =?utf-8?B?eGZ2MWluMWc3VUFqbVYweFlyNHd1Z0pYMEpqanBzNUI3cTVzMmZPN0VjWWg3?=
 =?utf-8?B?UWIwdXplYmhCb1IzeENuRnI0YUZZTmxBT0h0SDBzaWdxRTdhRjVQR1B1OFRi?=
 =?utf-8?B?aVg5Y2cvNUZkRlJMdmpWY29hVkhSYVVEZnJPcHpCU2dFWUVwOXB3ekhCNExS?=
 =?utf-8?B?RFlWakE2bnlFc2FlTzRjek9CMG50a2ZYaXhtbVFkM2NvTi9ucEJhSU5ONVNx?=
 =?utf-8?B?WDFyaHliV0JJaVhaM0NGTDh3ZXRVeDZ1ZmZDbXUweTZBQzczNlpoTE5zZkZU?=
 =?utf-8?B?Y0wrVW4zdzNPZ001STFXMytqdXpqYmpIZXkvRHhSUE85dlMzVldVSms2TGpV?=
 =?utf-8?B?NkIxbXpxdVJzMjc3TUxZZExyS2NsaG9FQ0ZmNndHVXYveCtzTytBTWxHMHdh?=
 =?utf-8?B?SWIxVUR2eXE3dHJ6QWxWRFgzc3RveTcrM1NScEt6WDdQR2I3Und5TVVQaEZO?=
 =?utf-8?B?Y2tKbS8wSkJFR3pHazR2V2dGOGU1clRVdktyQ2F2Z1VUVjh6bjB5VDUvOHFC?=
 =?utf-8?B?Uzl4ejBobDhCRWFYdzVTb3hXZTE4WCt5R3Y5emxxWms2UUdhT1h5MStuN001?=
 =?utf-8?B?czhmRVhQSllxbFNnNzBDTWcyMDZtV3VTMytYVVJLb0orb3VVZEJjL0EzUk84?=
 =?utf-8?B?ZjcyeFZOWDZ1MTgwSG1HaXluRDF1bElWc1VoRUNXeDVRdmw0dWNJTmtKTWxs?=
 =?utf-8?B?OWhiTU11THlIankzM3FQR3JnZzdtcGhISGpSS1BCZ1U5RHlZR0VLTitWUTFQ?=
 =?utf-8?B?SUhqUUx3NkxhYVBmTTR0WjJYTmZwT3l5Z2RkNXI4QUhxM0R5R3FJUytlUGhw?=
 =?utf-8?B?cVdaUEFVSWtGWUx0WjJyazUvQjNBeWVtZC9yZHFvYmNOdFI5VFluaWJOaCtu?=
 =?utf-8?B?SEhuZXBvS2ZNWlU0MDJ0d3hKU2ZLVURYY20xeDFRVTg4Y2hRUVBvYjAydFRI?=
 =?utf-8?B?dTdVNzlPblRkTFU2RHpiVFpqSENMYWxCVkhUb3Q0M1lqRWExREc2NVMwNHNL?=
 =?utf-8?B?aHBtSER3ZmZhY0YyNVpYV2F0V2tNQ3djKzI1VjE3L2wzNUdZTFVNOW9La01v?=
 =?utf-8?B?S0FpS3EvZXRDZTBGY0RJV1RwdFdVYkE3WVVQYm9oNUxFSjRpYkxQV0xUem13?=
 =?utf-8?B?TDcwNTV2NXlleFRWN21JQ21PYmRHSFVKazJQV005dlhUb3FvdkxacG4yeExX?=
 =?utf-8?B?WStTeHlaYmg3TzZvcHo4elpQZU4vakJodVJJSTdHWlo3eWpPbTBKUk44a0hK?=
 =?utf-8?B?RkpqbGZuR0Mwa3duSjJmUmlGMDM2bmJMZjFSL3VUQjBOUjMveEFnSnVrT0RL?=
 =?utf-8?B?UTVFU3lqZDdMNEVnNUg5QUVsUWdBWHlrVHhnK1dBTncvTnUyb1FiczVTRXVl?=
 =?utf-8?B?K0srRHllMVdBek5ENUVrTkFzOGdMd0lOc2NnaFo4RWdHbjMzRWxvSEdrN0ZL?=
 =?utf-8?B?c2ZyS3VGZC9wK1RaL3A1a2piUmdjNVFnazUzMHhkUGtURWRUUUZmSUl5c1dr?=
 =?utf-8?B?YzkvdnV6SlQ3K0JHVEhoM3Zleng5R3NNRHJXcDNxYUxrMWtTaXBmaURFYldD?=
 =?utf-8?Q?hna/FN+neUukgLcGFEu8KyDPY1FTUh70LBhth?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7299794-980a-486e-d49e-08df1dcb0897
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 01:43:17.1866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9930mOTI5u2XCfOzJmXFfAzo79C8AH5AAmM4jxIpA24v8iT+/NHjS2UkjwzTj8q1UJhb/s8vmW8Isg4sS+szFSjPy1zEj7EcjaICXgTeMFCLX4lJlgOKnLMJjpzYmXw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11671

Hi Sudeep,

On Mon, Sep 28, 2026 at 01:09:08PM +0100, Sudeep Holla wrote:
>On Mon, Sep 28, 2026 at 07:49:01PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> When multiple devices share the same fwnode (e.g. the SCMI bus creates
>> both "pinctrl" and "pinctrl-imx" devices for SCMI_PROTOCOL_PINCTRL), only
>> the first device registered becomes the fwnode owner (fwnode->dev, set in
>
>This has been rejected in the past. Apart from the trigger in -next,
>anything else has changed ?

When both pinctrl-scmi.c and pinctrl-imx-scmi.c are built into the
kernel Image, both drivers call module_scmi_driver() at init time, which
goes through:
  scmi_driver_register()
    → scmi_protocol_table_register(id_table)
      → scmi_protocol_device_request()
        → scmi_device_request_notifier()
          → scmi_create_protocol_devices(fwnode, ..., "pinctrl-imx")
So the on-demand path already creates both "pinctrl" and "pinctrl-imx"
devices for protocol@19, sharing the same fwnode, regardless of
scmi_std_id_table. aac4e67d6eb9 just added a second path that does
the same thing earlier - the fundamental problem existed before it.

This issue has been here for 2 years.
I proposed a patch in scmi side [1][2], but never made into mainline. 
[1] https://lore.kernel.org/all/CAGETcx87Stfkru9gJrc1sf=PtFGLY7=jrfFaCzK5Z4hq+2TCzg@mail.gmail.com/
[2] https://lore.kernel.org/arm-scmi/ZryUgTOVr_haiHuh@pluto/

The issue is not specific to pinctrl w/o imx.

The problem is that two devices share one fwnode, the first one registered
claims fwnode->dev, and if it never binds, driver_bound() of the second
device skips the dangling consumer pickup because fwnode->dev != dev.

>
>> device_add()). If that owner never binds -- for example its driver returns
>> -ENODEV because it is blocklisted on this SoC, or because its driver is
>> not compiled in at all -- then driver_bound() is never called for it, so
>> fwnode_links_purge_suppliers() and fw_devlink_pickup_dangling_consumers()
>> are never run for the fwnode. The child fwnode supplier links (pin group
>> nodes such as lpi2c3grp, uart5grp, ...) stay unsatisfied and every
>> consumer of those child nodes defers probe forever.
>> 
>> On i.MX95 this manifests as a complete boot failure: the generic "pinctrl"
>> SCMI device claims fwnode ownership but its driver returns -ENODEV, while
>> the vendor "pinctrl-imx" device binds successfully. Because
>> dev->fwnode->dev still points at the rejected "pinctrl" device,
>> driver_bound() of "pinctrl-imx" skips the supplier purge and dangling
>> consumer pickup, so all I2C buses, SPI, UART, MMC, USB and PCIe
>> controllers wait forever for their pinctrl suppliers.
>> 
>> Fix this in two places:
>> 
>> 1. In really_probe() failure path: when the driver definitively rejects
>>    a device (-ENODEV / -ENXIO), fw_devlink_release_shared_fwnode() is
>>    called. If the rejected device is the fwnode owner, it either
>>    transfers ownership to an already-bound sibling (and runs the
>>    purge/pickup on its behalf) or clears ownership so the next sibling
>>    to bind can re-acquire it.
>> 
>> 2. In device_links_driver_bound(): re-acquire the fwnode when it is
>>    unowned (!fwnode->dev) or when the current owner has no driver at
>>    all (!fwnode->dev->driver, meaning the driver was never compiled in
>>    or loaded as a module). This covers the case where probe rejection
>>    never happens because no driver ever matches.
>> 
>> fwnode->dev is not serialized by a lock; instead every writer only ever
>> touches a fwnode->dev it already owns (== dev, as device_del() does when
>> it clears ownership) or one that is currently unowned (== NULL, as
>> device_add() does when it claims ownership). This patch follows the same
>> discipline: fw_devlink_release_shared_fwnode() only writes fwnode->dev
>> when this device is the current owner; device_links_driver_bound() only
>> claims fwnode->dev when it is NULL or when the current owner has no
>> driver (and therefore cannot be in the process of binding).
>> 
>> Fixes: f9aa460672c9 ("driver core: Refactor fw_devlink feature")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>> This issue is triggered by 
>> aac4e67d6eb9 ("firmware: arm_scmi: Always create devices for standard protocols")
>> in linux-next next-20260925.
>> 
>> But I think this is a fix to
>> f9aa460672c9 ("driver core: Refactor fw_devlink feature")
>> 
>
>Does dropping i.MX specials from list of devices solves the problem ?

No - dropping "pinctrl-imx" from scmi_std_id_table would not fix it
when both drivers are built-in, because scmi_protocol_device_request()
from the driver registration path still creates both devices.

>I am more than happy to drop i.MX special in the code and let you
>sort the pinmux mess you guys have created.

I understand the concern about platform-specific code in the standard
table. But the issue is not specific to pinctrl-imx - it is a generic
fw_devlink gap that affects any bus creating multiple devices per fwnode.
The same structural pattern exists for SCMI_PROTOCOL_PERF ("perf" +
"cpufreq") and SCMI_PROTOCOL_SENSOR ("hwmon" + "iiodev").

Cristian also shared his insights before, in [3].

"
....while other drivers exists that share the usage of the same protocol
(HWMON/IIO GENPD/CPUFREQ), they use the same protocol to achieve different
things in different subsytems...and they are anyway impacted (even to a less
degree) by this fw_devlink issue AFAIU so the problem indeed exist also
out of pinctrl-imx
"

[3] https://lore.kernel.org/all/Z65U2SMwSiOFYC0v@pluto/

>
>And also I remember you creating situation disabling cpufreq in the cmdline.
>Will that be ever used on those i.MX platforms ?

For the PERF pair, both drivers bind successfully today so there is no
issue in practice. But if "perf" (the fwnode owner) fails probe while
"cpufreq" binds, the same fwnode ownership deadlock occurs. This is not
about disabling cpufreq - it is about the owner device failing to bind
for any reason.

>
>I am not against the patch if others are OK.

Thanks. The patch fixes a generic fw_devlink gap in driver_bound()
where a device binding successfully on a shared fwnode cannot resolve
dangling consumers of child fwnodes because it is not the fwnode owner.
The fix follows the existing fwnode->dev ownership discipline (only
writing fwnode->dev when it is NULL, owned by self, or owned by a
driverless device) and handles all three scenarios:
1. Owner probe rejected (-ENODEV/-ENXIO) - owner hands off in
really_probe() failure path
2. Owner rejected earlier, fwnode now unowned - sibling re-acquires
in driver_bound()
3. Owner's driver never compiled/loaded - sibling takes over from
driverless owner in driver_bound()


If driver core maintainers have better solution for the case that
multiple devices share one fwnode, I would appreciate.

Thanks
Peng

>
>-- 
>Regards,
>Sudeep
>
>
