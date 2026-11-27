Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795777667;
	b=rxj2TPJ4V18P8E6MQaifru5JGu7aRYWaPX5R1D6Q+pVa8yzamAycVgJznhsFdrA6IzQl
	 /nSJMoTVhfOHhM24rcpAqvW3PDPVjG0+ZFOxpdunhaojyZLcluSrJ0ih0eTF/r4SgGIpM
	 TCOlbf89cF+TRecjDvwFv+lwDU3R84NylqAX47ecXULz/RSESadHcCy8uZes6sNvAXrJM
	 dKwWf5l3aVR8YCb4z/M/eQtEyO+PbJ+QK24MR9NS4EuJ9jENDoPXPxP7PhbtUW4A0dzYY
	 7DwhLd+a2FsEGGE77DyROTMmyJ5RLc/Cg/sMOrhLj8ohiw7/kWSlYwECPpbmLah8kQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795777667;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SharedMailbox-RoutingAgent-Processed:
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
	bh=4wWF4FyvaptKVhKFbMJRvuGahmeExT72/GRYEhTfjGY=;
	b=GZVYPkFJ3v/nTsaainfYFnlLCwerCgcRlZEBZThsdYSoDHmMAeuXdQZBA2AWuHfAcFzK
	 LnLt01x/W9jpCasquzIYkrWQzN5KiD7ROr0erroQDranNTpfjaSJBkCedbDAl4Y6V8H0v
	 PlN3EIFBUyHhbeRX7PLO3esuFLoKjOKdVL4I40QeoxxKu0Th9KhuvCBLZuKqX2l2opiwp
	 Iu9eUUGZ7RJGIzO47CGwAF9/HgHOED7QM8/Rz3Tz23fkgRYv8F9h9et58eNi7s3Hbh1OA
	 7HThlXu11ijwmanTMjvOIGTsbMtk93AoeayfJjt4rNOI3Fo20w+Di8WcTOdx4NIFcAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oYdgGUls;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.17
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013017.outbound.protection.outlook.com [52.101.83.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEAA606A31E;
	Fri, 27 Nov 2026 11:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BEAA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oYdgGUls
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPUQfyN8Tbas3kAyf//DLosxIrsdYkq2VS4UZ1wMi6lONOOyRrWbzeBpGX4nonSgp60w+BTvI7I6ROhr0sxzo2HKArfiZDerygQqMwUNiQYZOOS7e6UW4E2Yp98OWRTIh+Ak4TfBsTYSqrxRYHKIpRItKv1iT6BP6v0CNUDOOPzi6bZrJNN9e6uLKOR1Ji0y3991dAtKDTA193yiOWOj4L+7oR0wu3MR4nsMmbhL5EynHVR0/Vpgr/D+VJkXsOfpgaRh9JNxBnwWL9t7COji36jx1MnDr2WPb2aKDGhdeEfxa3+XZssMlBMN14OQjdRodqFXYMEgUVGiEnF1bRGWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wWF4FyvaptKVhKFbMJRvuGahmeExT72/GRYEhTfjGY=;
 b=BjXZ5J+TYLXx3xX8tfazkxujVTBnzf4FUGgzqEDNzmwZADPOFBUg1mNynEjUZ9PKkVZ6Brg7Zx8+tM5Sgl0+mJP8y1SPf3TW1MXAFVZs0lZGa2iwY19eBEn/bJQsRqGO0BXOOLlnkix+CK/cfkZV7zaCkGmnwi45fgZ5Lxkp9/Ne116rwe0TCwkqvT4W5fDncA+n0Il5HESgG7IjB2zPhjKw4PIs2Tg5K8K68B9N9cYyK7HAWFaSudjSrgbU0L6ZpkmFj0F29o34mgJkWWpLRkD3MyvTm5uFUFFFYoU2zy2A7W2itCFXuP/wLDokOoFanT87uojPeFeM6M+j6Iocmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wWF4FyvaptKVhKFbMJRvuGahmeExT72/GRYEhTfjGY=;
 b=oYdgGUlsQ/h5v4RPeX9q/3Cp9KbfLLIiLGpN8/eEEAaiUdpAh2KUO3J9n/rF26VR4RvBjxDByboo65ZGgTuMiD9GJToqurL5VnikccjOeXzf/4m3myhp9HtAywKEno6VLrqBjTrHBu51wdOOZkK5rcbbTpqfQoK39u98Lp4+Sr78j9qnN3bF+Amayx3AJI91ti7K3b/OpveW+VUCGxcNq+rAqRK8oBIea11AFg/fpJRC7j5XMZ6n4o7YtSGRaFJr0j1qbSDOwYG4LO6H9kMtQ/WkP+iy5D4CoWnPDfdBWmnGCW5MuH+rugPxTqwf1+r9lmdNQ2KHZXFLAR+v3/nySg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by MA9PR04MB056375.eurprd04.prod.outlook.com (2603:10a6:250:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 11:07:43 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 11:07:43 +0000
Message-ID: <38a63ce1-be42-4445-b3d4-17bc9b559119@oss.nxp.com>
Date: Fri, 27 Nov 2026 13:11:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx93-11x11-frdm: fix ethernet PHY reset
 GPIOs
To: Joseph Guo <qijian.guo@oss.nxp.com>, Frank Li <Frank.li@oss.nxp.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
Cc: Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, lei.xu@nxp.com, haidong.zheng@nxp.com,
 francesco@valla.it, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
 Steven Yang <steven.yang@nxp.com>
References: <20261126160835.1811145-1-daniel.baluta@nxp.com>
 <awhiRigXGZ50RoDo@SMW015318>
 <7652e6ad-a34c-453b-a461-6105d9c86813@oss.nxp.com>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <7652e6ad-a34c-453b-a461-6105d9c86813@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P193CA0020.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::25) To GVXPR04MB12316.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::8)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|MA9PR04MB056375:EE_
X-MS-Office365-Filtering-Correlation-Id: 19669887-6f4c-4141-7458-08df4c76a887
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|19092799006|7416014|10067099003|56012099006|11063799006|22082099003|18002099003|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3Rqj7oIXfLxXNZscK6SD1xUONm1TxwZmfOM38hMfWZYgIW0zZ0CnduviFJYKg5IkNBBNIP36eWUVJUim+GPcENMuBEvMDFSaeLP3FNEdjgG84jW6zAmWGctGXXUkw2pjbpTCsY0pDfI/Yq9NGmfQobrYc0Npf/fEWovCvclGZVWaR1PhsA5f3Ymp3WkbDEYu0MaR6Ly4+PHM8ix8SVZmfr8WmwxIWVO4r1WWCxhA+eI5evuDM55ooYbvlgVPlmO5YeqxZNSsWvNCYy9uGiBY0B17z3/F0JO1DjaAxMYn/G/q3J0p5vyIq9QxJtLTV6relAx6+0XwTCue1SjLcD08Z5iB2qc3XqjekqtHs03pa02FHEDiJAO375SNfP01zxBNawCPoN9zTDceL5HseTUHrd0WD+xL6WVVK1klt+sM0mXKvynEkCSyeRbsCN4pEugymV6V9EBvxdp7Kml/0ciJX1GifYczQjBcPfUPiKuXnc5pn5PJ4o3Byb648HR2Bkm9p8g8vd7ggetrM60XOGgnkUXrgXW59rMVhxLMqFARGv/MmYtlHsLeNZMPqoMtF3zPZ1V+YFPgCk6gk0lyqW1N0wumWtXmVo7vk7jIv2L/F3+RPkktvQPBsAtnUafUEW2MCAicQxtNOqum6x2TcU+zt/4Wft0iLRNCO+L4PAT/qbE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12316.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(19092799006)(7416014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1NtZ0xSUE5ONG9JakZPekVyMFRKdEo4R0dwd1VkNHZEVTczcFdMbVo2bHZF?=
 =?utf-8?B?UHROcXpzbHJSRUVtYVlIQzF1NHUyNUQ3WEs2dU1EbUc5aEF6S0FHb1lOb2xO?=
 =?utf-8?B?dW01b0RtR242MmdqVGFtTU9wV3Fxb3RKZmhHTjZJL0RHRWkvZWUzck1CK2V6?=
 =?utf-8?B?cFFSeU93c0hjcjBHZjUvUUoyTEhpWXkvbzFOZzc3WmFwbVg4OXdyM1JIbmh6?=
 =?utf-8?B?VU5zMGRkSDJCbEd4a1pjeHovUVJIdDdxSDh2L1czbVJVeXczZ2o0dFB3MFgx?=
 =?utf-8?B?c1JWdFpVb2hQQStvZzVpcmxicFY0anJmbUgxV1Z5NXdJZnpKL3Z3UW5ia2RI?=
 =?utf-8?B?bzBzKzcrZTZ4Y1FHb3dEazBKOXc5NXZMamo0aUpuTXg3SWxhc3pyYmQyQ2di?=
 =?utf-8?B?YTF6RTlCS2lva1RuUjdHL3kwdFVHUGluSjhNTE9wcllMMElSdk9hVjgzOUJ5?=
 =?utf-8?B?QjFhcWJ6bDBZVXhUVTF2NG9UVGYrZFR5dy9FcS9WdmFIcWJqdnZtZW96U0k0?=
 =?utf-8?B?VEtXREY0NHFtTHlSMjNuY0JvcTIvREwrOHZWZDNkY2l6THN5ckE4MUZxOVVi?=
 =?utf-8?B?MUxhNkliWUlsbjh1bEs3TmxOb3lFblVOVU54ckgydHRpdG5lZGF1R2Vna1Zh?=
 =?utf-8?B?R0Nwb3NFaEhnK0Z1UHgrTmxYZi84QkpZU20ycWJ6RnZqRW93WENZbThzL1Ax?=
 =?utf-8?B?K3JlR1JreE9iRXZzamhIc29DNXJVdGp1RlZNVlNYaEp4MzhlTmg2d05JYTdp?=
 =?utf-8?B?Z254dGp3OHRlaHhNYWVQeEpBQS9zbE8wQjZXcDVsU1ZpNm51eUVxSEtmSTJu?=
 =?utf-8?B?WWxFc0lqeHNnV2NwUk44VWxDZy9Ua3dSRTRnRURkczdwbncweXZ5UzE3VDBW?=
 =?utf-8?B?MXRRVXVNUVNvUjg1d3orMGlHT21jbk9acjVpWmpMUUR1TW9CRE9rbEUvazBt?=
 =?utf-8?B?TUNnZVA2ejFWdGY3b09XSGNCT0xLczdRc0ptRDlZZHprNnU2KzVCa1JyQjFN?=
 =?utf-8?B?RkphMm5NeGc5VTI2c0ptMWc5ODVtVGlNVml0bHZzWjRJek5VNzRrNThQNm1p?=
 =?utf-8?B?dFFRaWZscGR3cVk2MndQQVJaVTF2UUN6eTNHNW0yZDZ5VkYrRGtHV2VXMktC?=
 =?utf-8?B?b3VjazliSHdFdjhyM1pjTWNJOXJ0V3I4ZGdsK0lVQWVaZUJaUjNaYTYrSDhy?=
 =?utf-8?B?WkVkalptTDBNdWZjVjRHZDVDZXJEWkxOZ0VGNG8yUHN1VWFyblVYUkx1ZnRq?=
 =?utf-8?B?bXZsTDRCalRHMFQ1SE1jMlcyLytBTlBJbUl2aW1vdnpKZUUrcEhOeGw3UFhW?=
 =?utf-8?B?RVZXcW1nRVNBa1k3NDhEWVhOSlVVRXVsb0NldUkxeWtWajgybitldm55YVRI?=
 =?utf-8?B?Q09lOHFhaFhtcHpCdUV0Q0NXMGthRzR0TXFTNE5leksweWFPUXYwTlRMbE9I?=
 =?utf-8?B?elRTMVoweHhmU2Q1eFRnZFMyRHo4Rk9QQnlLMjMwNEFwVjI1cSsyYTFLQnJO?=
 =?utf-8?B?ZS81UWs0bHRhR09nb3UwbDZ2cHhFOUtGL2NBOG9hdms1dEl6aVZBbGtGMGR6?=
 =?utf-8?B?R2c2cVlCT0I1VGRBckQ4UFhsUXlBcEJLMFdmRGZCQU10NnJ4YzNmd3JSQ0RQ?=
 =?utf-8?B?bEpLSEwwTXJhcFNzUkpDcVdBT2VFYjNTc0MvcUVmK2Y1N0M4eDVBMzAxd3RZ?=
 =?utf-8?B?MkE1SXN4Um4yWEtzeldDb1B2ZHRGSVcvTnJvUnUxZXA3aE0zUlRxUGFML3U4?=
 =?utf-8?B?YnJHazllc1cwdGRNLzVQdGVIZGgvbWJBZ1BxOGw1STlaNGVJUTBsODFCOHl2?=
 =?utf-8?B?RFhhaEFSTmhwUjBkbXc4NE1vakhNUWVSa1ZLZnhEVCtNVEtaT2FxTHo2VXhO?=
 =?utf-8?B?UWxxN1l0bUVpWHlTOUVRSktqSGtQR3Z1Sm1nbG5XTG5kd0ZwL1RKUEU5YVBI?=
 =?utf-8?B?b2dDWCtuS0plSkpXNXlnaDIvTURlbE94MzRvM05UekNCUmJidG43aFlsK1BT?=
 =?utf-8?B?dUlvVXppRVZQSCtuNWFNOWFXUjY5d2loZm5UTlNJUXlaQTFtZGZDVFFCekRR?=
 =?utf-8?B?U3hLTEhRNTR3dExrdDVvblRna0RDRVFHSldzclhjYjlSQUo3ZlVVSFI2a3Vn?=
 =?utf-8?B?bnBnTTBJTHVrRmhzR0FrbnVia0Y4NUlGbGQ2ZmxQSGpOVGwwWXliM3FvWEor?=
 =?utf-8?B?dnpRbE1QK094WlNtQVFyLy9VVHlOMGZKemEvYks4YkU4ZjhMMnlJOE5VM0s4?=
 =?utf-8?B?cU9VMzdQN0Z1VWJxVEpyWjhCNXdxcFgyYVoreElZUXZzWEVzUlp6VVVlRFBQ?=
 =?utf-8?B?WHVtUTIyRXd6a29kS0I2eXYwSkdjTWxjY1VDMkpURWptU1gwV09SUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19669887-6f4c-4141-7458-08df4c76a887
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:07:43.0608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /C6vtB3CUZLfUbdHIpoWbP26Krt3LEtXA9MB9Fbc7QDsbDyboqwn1lLuT0TRPel8yAJvOMJ2RTxAJ3dNWTFp+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR04MB056375

On 11/27/26 04:43, Joseph Guo wrote:
> 
> 
> On 11/27/2026 12:45 AM, Frank Li wrote:
>> On Thu, Nov 26, 2026 at 06:08:34PM +0200, Daniel Baluta wrote:
>>> From: Steven Yang <steven.yang@nxp.com>
>>>
>>> The reset-gpios of both ethernet PHYs point to the PHY interrupt lines
>>> instead of the PHY reset lines.
>>>
>>> On the FRDM-IMX93 board (schematic SPF-94611 rev B2), the PCAL6524 GPIO
>>> expander lines going to each PHY are labelled:
>>>
>>>    P0_4 (line 4)  ENET1_nINT
>>>    P1_1 (line 9)  ENET2_nINT
>>>    P1_7 (line 15) ENET1_nRST
>>>    P2_0 (line 16) ENET2_nRST
>>
>> schematic error? Should fix schematic also?
>>
>> Frank
>>
> 
> The rev B3 schematic already fix it.

Thanks Frank and Joseph for review.
Indeed looking at B3 schematic, the ENETx_nRST/ENETx_nINT net names are now swapped
and much intuitive but the wiring is the same as B2, 
so lines 4 and 9 are the PHY resets on all board revisions so the fix still applies.

Will send v2 with a proper explanation. 
