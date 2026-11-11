Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493320;
	b=ylc3Eiik8ES8ESNXAZznOhI9Vgv360nf4WD4Y330salFL4ZhIgxc0OOK48m6ABgbxr4U
	 h65qleGp8eY+Vg72aLk+25x94xBAagxFLtqajaOSfTruMTaIVFIh3XvG4aof037k0OEHT
	 AX7R4Ubt9kGHAac0+6Kq0E3sFzQulI0xw8QhTcJJFJmQZ2gcLFlHAkJkE8Q97WMDbERH3
	 m+m0kAUYXOUYbBM+OIb6JNH2UtNX/7Gn5gNJyCNnIUD1NnIZb4rnRLZFfYGW8ctCohx0j
	 9euU3DHK6CCN/LhHQIQUrQNWcAndyDNUJNzPbYaXL97ZwIQZyRwbp6gC+isTqXU43Gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493320;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=QwRcz3RDzDXc3OiXt9CrRd6PibNzeZ6JA+L+L6SOF6E=;
	b=EDGjo1ofgJD5WSypEjW4f69bupeO7K72c8rvaiyHnT3o3xSSoFnclfjWHqic6IkKEeei
	 9wV4CJSsTagP96yqXbbIJ19PdOyFDwPk+viU3igsJrjd9UU7NfC5bfAE0pjffSua8+CSX
	 K2aliVLOum4YUAQ2/b82UIkFVfup8c5WOpvfRegX5OGG7xqP2kogXDc80sQ9UlyxWI/dj
	 C1gPMIoDG2EtqSCieJTSYwktFJvNr4+EM3pHVWuR4cy0JXJFJZexO8xMsgTnAkXTvBouK
	 jlu4Tu2agQS5aiXfPNWlxOZaae0hndX8vi3DSZiqt5LqcD12d3hVH1qy3FL34IKwMwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ERGQZ5DY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.19
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012019.outbound.protection.outlook.com [40.93.195.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF609606B832;
	Thu, 12 Nov 2026 14:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF609606B832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ERGQZ5DY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpwNSDTm7MHOafL23t4ba5snLa+hGzvSlVH5o6vmGE+paB291WhVu2dBjjPPhoAYUaRUkaMPtcr6TGLj6tneJEOjk8Vehb76N47RxjNkXcUAHxa41CQv6YMBtWD9cNOUXH+Ar+mZLgweFDyyHXL/iMQiREaN5GuujOTQFI18zVmTqxKVdZK21kvhXusqfQB93b21KOTnfHor5KUKcjmTQRbqUcjKUa8CRuG7SnUV5VCbCVkees9oWy9sUXxWvFU2zuPuvTBg2LEywo9Kvjmu0URSr0Wr8x7I9psiqVb3RmWhHEm+L9P+lpDG5fIXMlaz2gubns8BqjCVqMT+CvZC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwRcz3RDzDXc3OiXt9CrRd6PibNzeZ6JA+L+L6SOF6E=;
 b=SB4WwzvhoCRYx+tODMNQJqVvjPfyMsnGVrpEghxRbRY9+oysT1RXUIn8KixmbuXkG3aylyZN1sgOVpDlXfQdfGR3R+NBW596/QRnG5Y/P7sGgJQYPhOSI/ZB+T6d7PsEHMckdrRZnhtnPLKSFhJ7GDR3afVx5uC94h1FzP5TFw6XxxX3x3XG9zZd5/J1j9gMn9bMANk3dwzpKlY8FtmdU9m+jpQcn5sUG/VRs8WCLspFUbzloUSRgXvlePji1l5ns57cK6XD0T5TQFwc1W4df336V4jxno+jpVMmNY1E7nFn8OyyjTZ+bTK2wl/H8tGhdLS1Y6fduMURDadCWOiXTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwRcz3RDzDXc3OiXt9CrRd6PibNzeZ6JA+L+L6SOF6E=;
 b=ERGQZ5DYDrNY5iWQ0jBP1AnaQqmPRg+YAEqm0pLRY+HpN9QYYy0d0p6YMtHOpF+O9proiwYLuV1t43LO5sSSeimwKHimxpnIs+LTsCgtDhZDzqN/RImTSVXQGWit/aHOLLI/yQ4gXPiGRdds9Yg8Yqas2zuXv8FY+LVFnUP7OozoJuVmGe2mngfG9SNS0ewpfzTa/vUeb3bU3OxmXbODI3+/1NKYQEUxBU7TARAjRHJcV7BT0+P2IJmhP5C4XKf2dlEvi7CQy6z8I2bfqaWuALOPgCaZNmXJX6O3n95RKzS2LHqMoybvHmJcc7dxjTawwKfXe0CfpPT0DHjjSFNSrQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by PH9PR12MB731475.namprd12.prod.outlook.com
 (2603:10b6:510:414::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 14:21:57 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 14:21:57 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: jgg@ziepe.ca, kevin.tian@intel.com, 
 Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: joro@8bytes.org, will@kernel.org, stable@vger.kernel.org, 
 robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <CD846EC67F4302A7+20261106115252.87749-1-peiyang_he@smail.nju.edu.cn>
References: <CD846EC67F4302A7+20261106115252.87749-1-peiyang_he@smail.nju.edu.cn>
Subject: Re: [PATCH] iommufd/selftest: Fix leaked PASIDs on device teardown
Message-Id: <179435794163.1896047.406220761264833070.b4-ty@b4>
Date: Tue, 10 Nov 2026 20:45:41 -0400
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4P288CA0087.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::24) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|PH9PR12MB731475:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fda554-a3b1-4900-6c4e-08df40c84ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|56012099006|261026121527099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7mxVM0+EdV/6w/nkuPpFjTpSj7QdrOcJ78TlMzkHnvH5Vp9RE8rpD3e7Vdw2EAaYrFvT4Hq8HT7YKE2phcRo7L0cQ0twNp9dJI5h6WkgcIvVITBaAcUAKS1xD1lkjiDWoCFO1YOtgWUqwjF1N3Pf166nCyKaDIZB64bJJv7UIJm3wCB3nEBdDFAACxsOkafz5c7jtbZKOAkuXkcj93T+/+wyizz0wRHLYWqizbRUMPUM6g4ZjO+7zkf4eyLo2Bnm7IfeRQqbn2pTSTHHUp1n/2MCymyAsbPS9OplRk+TxYEVF5p9fdYzhAVrMkjuQBCz3mbwQL/naZiYZdujDhLT7Mri97X3RFs+BMyOSkvOA4zDnmcY+ewNIzNls9CkMVu6oM4cSur3qgp/FYqOyAKPsF2lY23jyAI4VCgrykaohyLhoBs207Z1S4hoRZxv7FzmdCiH5/kUFqTrJOENDkTDTbU6TWX2zoHLOa3iNCPZucKt2UghP8oH8a+zpF668w3p/85h9Le2svZgGtb9gmJbaaIdpRQixmN8SDtCE1iCPdcWrpA1vSOgpYQvRTqhB5nkVOoAGYIn9I+nLRReQD7yGD1qwBnOtNmCO7nXZS72JiKpPqPvsMZilPjphpuo0S7BSBwZIwOEMEAqlyQuR/AYPexqZmrdq1tzcZe7DrA5knY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(261026121527099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEhweGtWcDlWZ3FyUGRCR2VZS1M5b1dpZ091bndMeEZTTWg2dzU1SHorcElv?=
 =?utf-8?B?V2dlMlM1akFmaWxWTUJ6YVJkQURmMklUYXNxczFKS1hPRnFNdTUxUDd1QWVn?=
 =?utf-8?B?TGFXQU5TQ1d6dzhKYUU3Nm9XaytVVXV4RjR3bXgxQzFHYmR1a2l0Q1hMckp5?=
 =?utf-8?B?bW5SOGs3QUViNlRmREwxZzRzZVEwdm9PMlF5S0JDZ3pZSzNOeExnN2JIVy8w?=
 =?utf-8?B?Mzk1dmZieituK3dpNHI2WVFxY3VaVnQzYlpDRjZhTElvMkI5MkdGL01YRVRL?=
 =?utf-8?B?TWJ4b0h2NG9wY2g4dnVMU28zRXcyRE5xMmhnUkhZdC9CWkVMMmdGc1BxcG5X?=
 =?utf-8?B?clFZUk5WeTRNc21MbFp4NXhTNWlJTGt2TEJabmtuSzlRaHY0SzVjZGwvbTN2?=
 =?utf-8?B?V0kwWlVKdElKTW5qdzI4MTNWbVZoVTZVeU5zRWd0VkdSQitPSHE2aGFrcTV0?=
 =?utf-8?B?V3VDaENPd29sazlCTTl6VVRBaytOekxlTmhPZTB5bWo5WmZXK0JqN2tzNHow?=
 =?utf-8?B?MXVuTzNEVG5XMUxnZGg5VjVrRlJtdkh4ZFdnMTBpLy81dHI2bVBKS25FSHQ5?=
 =?utf-8?B?UW1ObVBMeWV1d0NScXVMeENXSy8vY2lIaHdKZkp2UDJEZTlERTNtMjVRWllH?=
 =?utf-8?B?bzhhRTl3SkdSbyttWTcwZ29UYnB6Y05uS2tlSVRueEpibDhUUEt1c1laSm5H?=
 =?utf-8?B?bm9PNzRvQmpFS21yZHpnODZKQ21PZzZHZ0VVbjNUTUV4WU1WV0tlVUNyVzVk?=
 =?utf-8?B?NkVqc1lIN0NPeVhDZm1GZEt0SmZKOENrSVk5c3JlSEtHaStVM3pOVXdXQTVj?=
 =?utf-8?B?OVlCUU5yWWwwbHptb1E5M0RSQXZFZkRjcGZMTStKcll3YWtueTlkZHdvbml1?=
 =?utf-8?B?cUk5U3UvUnpjYW5kVWkvaWJpdTE5cEgxTDUzd2orWS9SemFTRStzK0FMYUpq?=
 =?utf-8?B?NnZmaXZINUhHRTJFaFpLQ1BVM21MVGJqeWF1enV2cGQrQVZvQ2ZnblF0Kzhi?=
 =?utf-8?B?NnFyZks2UmRPOHNtaUVwVWMwZlE2SkNrc21JWlppZDlTTHp6YW1FbHA5b0tT?=
 =?utf-8?B?TlFrNDF2ZS9xVlFmbW4yWUpJcS9IblpFTUFWeTBLMXFSdlFFaWxVZmFvU2lL?=
 =?utf-8?B?Z2lFUWp5Ni9zUFRZdHJwV01lN3dzdFFPc3Fhck91bElpUFdUVmEvOTgyUjVY?=
 =?utf-8?B?N2tCaHZvZ3RuWXNnSG9mVUtqN1NldnBBZWZwcG9IeWx3eCtKV2cvRXpCdTlx?=
 =?utf-8?B?NWFTWHZGaExxc3B6NkRTa09hWS9qVDhHN1lJYXBCeitvb2JTTld2KzVIQWpU?=
 =?utf-8?B?TUJYUXM1YTlVU3FQeEUzbUVWbm9MVWZjNG1oODFSWmo0T2VZZkQ5UmZtSHNM?=
 =?utf-8?B?TGc5M3NEMVZiKzV0cGlKbWNVTXA1eUc5bDNxSmpaSXBYZUdmY0hUZ1N2c3NW?=
 =?utf-8?B?OWRUbDlzRjVMOVhZQmFlVjNla0JUaEIyeFJvbWNFS2VQNjhVSlJzQlJGcXd2?=
 =?utf-8?B?Zm0xaDRWTXVQT09QSTdadnJXNDVuQmV5azRwRWxiamhMVkhYalpCdmVHK1Vu?=
 =?utf-8?B?NVJzWkEzV1RzM2VKdUJDbDVuRjdiczgyTFQrVjBHMEJQSXd6K1FRME5nSE1I?=
 =?utf-8?B?UHdSTGNmSXZWL2xMamdFUTR3MzNmL2tlbjJFLzkrZlRINWp1ank5ZjBISzdS?=
 =?utf-8?B?UTYwSnpPZnB6dlhxVnRXektuTzN5MWJVQTNHVGdZWGIzS1pzM3Z3bUlhSGFJ?=
 =?utf-8?B?bTFZYmd6ejkydWo4aVluMmc4RnJLRTVObVE2NkRHUEVhK0ZwMnJLbFFYUjhP?=
 =?utf-8?B?bFp5bG1hdEVCdURhWDdiNU1xSGNESDFRbWlvMHAzc00xWGovOWFWSXY0N1pN?=
 =?utf-8?B?eTR6NzR0Mlkxcy8xZEQrS01Na0pmczE3d0ZjZHlwK3hUK1JVMEtBNFBsY2Ux?=
 =?utf-8?B?UEZ4QlJQQ3k0aWJuRFlZNVBkdDluTUFuM010ajFNa1FSd0k5cU9uKzVMNVRW?=
 =?utf-8?B?RTNwckNHN3FkR1JHaUZSdzd3SWhyb0hJckRHUzl4WlREZEJlTGZkL0k0R2NG?=
 =?utf-8?B?NDZiRVIweXJhTFJOK3hyN01STDFhbEhrbi9tU1NMMDJTVXRVeU0yNGluQkxa?=
 =?utf-8?B?bGRPWVRLWWlYM1Z4dGxsUXFIcmVESGxZaUJqNm4wSjdQUEl1MnY0d0tJTEh1?=
 =?utf-8?B?VE9qaFFEQXIrRW9WWU9wdzNxaVczK2d1ZFdKaTZrWlJCUVhLQ2FhYjI4RDV3?=
 =?utf-8?B?b0lPQXRzUmhFSEloTFNZa1VvNU03Tkg4Zmx4ZTAxQkZZVHNTYTdDUm5aRVFH?=
 =?utf-8?Q?F7aI/5rFwhMKP9kebn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fda554-a3b1-4900-6c4e-08df40c84ec8
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:21:57.0269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAEtT9aN8wNfGRurP0724taGHuXsx4+5WKNm3sYbbxH6ijnHGtzBDgLClcrgAmv7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB731475


On Fri, 06 Nov 2026 19:52:52 +0800, Peiyang He wrote:
> iommufd/selftest: Fix leaked PASIDs on device teardown

Applied, thanks!

[1/1] iommufd/selftest: Fix leaked PASIDs on device teardown
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=a12337013fcaf6eea29dce8409b84bd4588f7801

I changed it to use a scoped_guard instead of the goto spaghetti though

Best regards,
-- 
Jason

