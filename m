Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013019.outbound.protection.outlook.com [40.107.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B8B345EB8;
	Sat, 19 Sep 2026 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789822617; cv=fail; b=rd/bgcgHZ5FCTMyzNdXaDhs+uvHsO5yEM4tj3NOI4ga5KUPe3b8fenVKQ+XQl2Th6h4EW6QlPGRmK2Ng6YBYwr7LcnD3T4/Q8lAhjaFss1fV18eixg6JfS+Yux4+BSPCvHu27ijdCHpTCTm0J2LhnQKi3AU/ne7JVuRpJ7zXEK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789822617; c=relaxed/simple;
	bh=DUdq3+wVUWWsjFa6JlDAW3YVlZ4kHE50FuK0NSvciT0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FboKZ0EwsSzU5s7aWrUXmZKuhU5MNa0jEVErYaHJtWZrifdkmH4anj1wa2BqGzj1mu8RUqh+eeAFTVHsjFSmgTluDsqEzQ2oKqYV8fiMZqhlYiVnqyRmrOKqDrJ/fuc2puhzNdqh6jP2UHKc0UhKYeha57ZAt5VNgU5yWRgDBSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F16W2r8N; arc=fail smtp.client-ip=40.107.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F16W2r8N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3OMHuYiJVRuya8xd5f+8w/gtSMW/YKKrYsdQnRAFNVFA8LW3a0sf6NxTLR6wFdCBt9G1yQGnRyER28SS9o5oZ1UnXCp4lSFXNVvjnXw/EGZevDuUA1brFu9nyXCOPIsYfqenLJc8hD+U1kJjWaOdmrXxe4OQcKpXsxfCMhgrxKmdw+6KiO00RWrAGN/K3c0+e9NlCFQB/fHdPrqQ8x7C2zN8+Xl7Lcdj7MD7CopG36WV21bdh12YhPilkL35kOlZa3TR8bDKHsYfDzA9f210zzpPz7bu+zIb3FRV8VkAmHgOURFcAJbXIDXz1l7THFZoXnNBXXh0j+TNZeojv2w1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUdq3+wVUWWsjFa6JlDAW3YVlZ4kHE50FuK0NSvciT0=;
 b=uTxkib5aM3R2SjhHfe3ABQlKrrEcm8yU662PCkLUzEbR0WD9cQ5m77rnc0GPzkVXegIoLO4j0zYVE8/ZwYlIfXSYv0AWAo8e1AzeagicY308LlIPCwMEnfvpNv5sS94zvRW2B3baGdqBKUTmBZ/uuhyNpdcJx6g2631RC8kTdFZM4DEg4ifoLtEectWijTy/3/1zxx0YvuE0L0nkuIveh7+RP/hJnTJPqdUmQDUDpbMBJx71DhFwpAAAo85RVp4ISsZiRdrfetvMhjZJGN1gV0drdtLKApIH5QzteWsDlfp9AnMVaf7EQT1zjQ3mjjqzYpMUCXjV1W/+InB+U0Avrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUdq3+wVUWWsjFa6JlDAW3YVlZ4kHE50FuK0NSvciT0=;
 b=F16W2r8N98rvFbqHEUqBPf9Ox6l5oeC6f40GFGLsbLc8PCVmbi/6YaF1H0hEWq2zBSAWkPGRxe3tkU7hMKEwP+JMPGDBc/lBJqv6ocKd3enUpH5sQXHPEpEPnCW46YNuY+X0jEbetM4dMVQ8hLkgcWVn9Pf/8zTeyAdQkjzk44QyqKTvliPI0BKjSbiqtwG3LuYJ33aNU13E7VtofpiXwjriDVW+sSgc4R1MizWsa5bgnYzMlIrvF89mrXjhvZrUk++18PFnpEGIatWsdA2rFLjrR2bMWwxTsLBfjMn+Dt2FVc1Iak6IEOCNL3Iq9B9RQXp8oqX6PXRCDF8zsl9zrQ==
Received: from CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sat, 19 Sep
 2026 12:56:51 +0000
Received: from CY8PR12MB7290.namprd12.prod.outlook.com
 ([fe80::a8ce:7b9b:3e72:d1cc]) by CY8PR12MB7290.namprd12.prod.outlook.com
 ([fe80::a8ce:7b9b:3e72:d1cc%5]) with mapi id 15.21.0428.011; Sat, 19 Sep 2026
 12:56:51 +0000
From: "Qiuxu (Leo) Zhuo" <qzhuo@nvidia.com>
To: Borislav Petkov <bp@alien8.de>
CC: Wentao Liang <vulab@iscas.ac.cn>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "dougthompson@xmission.com"
	<dougthompson@xmission.com>, "juhlenko@akamai.com" <juhlenko@akamai.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] EDAC/i3000: Fix mci_pdev reference leak in
 i3000_init_one()
Thread-Topic: [PATCH] EDAC/i3000: Fix mci_pdev reference leak in
 i3000_init_one()
Thread-Index: AQHdRbwmloFXom/3l0GkqUM8IpurvbbRSLpAgAQdXwCAAHq/gA==
Date: Sat, 19 Sep 2026 12:56:51 +0000
Message-ID:
 <CY8PR12MB72908CC5DD1E3A1F1F82A9C4D1862@CY8PR12MB7290.namprd12.prod.outlook.com>
References: <20260916091415.1997923-1-vulab@iscas.ac.cn>
 <CY8PR12MB7290DC961329B90C7A836907D1B92@CY8PR12MB7290.namprd12.prod.outlook.com>
 <20260919053614.GFaq4fTt4vElAM_4p6@fat_crate.local>
In-Reply-To: <20260919053614.GFaq4fTt4vElAM_4p6@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7290:EE_|CY5PR12MB6226:EE_
x-ms-office365-filtering-correlation-id: f92bee53-e2fa-4306-ea0c-08df164d796f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|23010399003|1800799024|38070700021|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 isb4nOQP7Bq848FuJhy9RPZh3D5D4ermB6Me2aIF72CUNJxCz5jsTI3lCCodPtBHahc1tQ416W5xTfYTHMs1KgxFrhEtgJnNO1B0QwDEg0XZlp/ymxyZ6LeHsFKjaFAuHV1kbiHn7sJCfAGGUqNugMXWYF/zVayZCttlgkCpxCi42Ut0yXaOrKHiow2qvWxXyoRRl0s4ui5OMoaR4dQ+ZWIBKHYUVHDBIR2IVfvijCZyG1944ljn5dFyqgjs/lsuTtXSos4LnCFGkrzAqW5mEKqgvNd85YX45zk+aXO6UbMsOkGSVjqApGSWf4NBC0XY88/bMaLXRZX/JzSfbSxkqKQHuB7BQ2JnP/7ywiTrOPuh8ouF+tBxqr+h9rQHpx/koq0+VAuvS1biO9FlmJ479HpyBSHVvCzrDpIhvr9t666//1ftGRVKXV3gDtDmMQWINlIsUfbVd3Ia+V4AQADk+qnTT1Rr+rQb7dyRN/Vo5X0ek4IKMp3vx57nb89VTVboi2JYN2VcSNQ6NeMS+kv4upfMX8ES1W8UW7/C33cD7WkxL7anVtOFy/2o/qyh6p2zQa1QllDTsvSaA7bAl4TNCE/hOqexPqTm2WWuxAdfPKOnOR4S4ZsGAhFGP17GIoEz/DPl+qslaVx+XtYTTE/EBg1+P3XrV30O7Ujx77JQYlANLEJPbdX0zdWNhPhk8culjibL/aQh9ADKl0C7o9bU1VepXh+9tAPTU6aPHGUmTzk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7290.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(23010399003)(1800799024)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjFHRG9RQUdaZXpXd2tITEQ2YTA4aExiZ25vZ3pLSU53R0lyaWwxNE9mQ096?=
 =?utf-8?B?SlNQSllkZ1JkT2p6QURYQzk3YUg3Z29wdFF5RVZxenpRVEs3UE4wSi9PL3dn?=
 =?utf-8?B?NUtyRmxrV2NtMnJsS1NmTWRnUVJBSm92RXRaSmJyWS9NaHM3Qk8rSFYrMktq?=
 =?utf-8?B?M1hIQUY2dC82RENmeFM4K21JU2JkRE5FZFYvVzBvN0kzTm1GZnVEYXBwcmoy?=
 =?utf-8?B?NGl1STFFZDdvOXJnaytuS1NVRksvZnZyOWwvWnFvZ1dEZkF4N0JuNm02V0Ew?=
 =?utf-8?B?U3NVYWYyNS9ZZ3dabTVpUmlvY2R0Q2puQ1BjMHRNYzJ4MUFHSU5DUWhSOWhC?=
 =?utf-8?B?OVdoVm5uYy9MaG4rRjRidTdidTdYR3U3cHFVZUxHTWdXb0d1RFk0TVZteHR5?=
 =?utf-8?B?eEJQRU9JZGNXbDVBQjFseTk0RjBRNzZuVnppa3ZVR0FhcjQwSDR6WmVZRmw2?=
 =?utf-8?B?amx5OXZaUjJZTW1UYXdndTFNYjZjUk4vd2gwRnlkMlU4TVhZRC8rZnAxTUtq?=
 =?utf-8?B?MHZiM0hFeVg2SVZUbzJoZUU3dTJjaVFlM1N3bXR0SlM3SnRlakpVcHYwUEtQ?=
 =?utf-8?B?Y2JHZFVoRnM4VzhJRlVWejUwd25IRzY0NUdGOWY2cmpLOGlSTGxNZ3RkRlRQ?=
 =?utf-8?B?RmY4dFZUNHEzZ3Jsdi9tRDJOV2dLNkpuaHRTaTAwQ0hDVnZOVkovdk1ET2t0?=
 =?utf-8?B?UHd1a0NMUDZSVWVtbERRY2pQZVdrc2trY1NmSFBSS2VxZUJVbElUanlIODNP?=
 =?utf-8?B?ZkdnRzRBYTA1azVJNHJTekI4WE0wWldJMURWZEZOYTZzMldKaTFOUjgxTmFR?=
 =?utf-8?B?cEtMSEw3c2RYTm9JdjlIK2RkUVEzc1VtOHdUZlVVeVptMWZ2ZXhzbXZxeVd0?=
 =?utf-8?B?dWRYQ2xBLzlnb3ZrK0ZpOTMzMy95ZXJEa1Biay80SkVSblJsanZZYlVJMXU2?=
 =?utf-8?B?YkNCTmwwdTNiRmxSRWIvSGp3NWFzVUpPMFJHbVl3UVFRbUJRNm05bjdpRklU?=
 =?utf-8?B?a0YvUStvenhXMkRLSmFWZXBUVzdjbFJOaTIzZ0lhWHo0ckNYa0NxYUR6NFg4?=
 =?utf-8?B?RUVFWG1Yc3c1M1hqMWw5Yi9aNlJ4bkpwQ1ZRWGJoem40OVQyNFVtREttd2Yv?=
 =?utf-8?B?WWtJVUNDM2REOEJyMCtVS01qYjk3SWlMTW1zSHY5N3dGRFlaODFJQmRlZkUz?=
 =?utf-8?B?RW1aa21kSE9xalVNNkFBL1BFRjVZOUptR3JwOVhkdnpnemowSkFldW9wQlNP?=
 =?utf-8?B?SG9ISUVGR0dtUy8vcGUzV0xHak5zeExnN1hPSXlwMFZ5SGpVZEZBQVl2dkZM?=
 =?utf-8?B?OGdqOE5oWkhLMytacGt3cVN1bURIZi9INUJQL0xjSXJxRldtU3pSaEY3b3dj?=
 =?utf-8?B?VW1pd2dQbnZSRzkrbWxKVzNqc25Db0xZczZDb1pXdE5EdU1ncW9sYUpyelk2?=
 =?utf-8?B?MjUydzk1TERQaE9Yekk3amNUOCtSbndINzFZSmRpT2djeVdpSFgyaDVIdXkw?=
 =?utf-8?B?N0RCdlFoUGdnaDZiM1Z4aXBnaWxPL2krbm9GQ04rSnorV2RvcFVPM1l5bEUr?=
 =?utf-8?B?QXQySWJ5YVR5eGo1dVlDR0dwQzlBNi8rQ3dLNlp2anVDcTBCU0xmSm5FKzI0?=
 =?utf-8?B?NDRjWUU2UFhvUmlROEFHK2VwRThTazJONnNBZnkyUFRMcVF3R3AyWjl5VkI2?=
 =?utf-8?B?OWtyRzlhOUFPR3pnQTVEZTd2VWdabHNwcklJODY4aFBwYkQrbnlQajQ5d2hw?=
 =?utf-8?B?MXYyUmFIRXBGRWtiTU0zY0V1clBBSjJ4TXM5Q00yNDJuSmF1MHpIempna2Fj?=
 =?utf-8?B?dDJnVEw5Z0xQd1BxVUljRk1WVnh5N3VjQjNuSkZQVFpCMW9oVDRpcHJRVTc2?=
 =?utf-8?B?c2FITWNBUHNFTHhZSUxXWjlEaDVqS1ZHeVB4VlVPTWpUZFc5Ky9xVjN2ejhZ?=
 =?utf-8?B?UGhBWEVscVd5b3lRYUNMMkJZVm9OeXFtTG1OdURZaXZpclpjWmdkNllTOGdh?=
 =?utf-8?B?QVpwalhqeXdwaXZhUFo1R0w4UjlqRngwT3AvR25TQWlPazNiUHpyQlIvSm4z?=
 =?utf-8?B?VjRCUnZBQTZXMUJucGZOcXVmb3dWTzlIUFpzSTlaWnJNMHBkUTg4VTBvTXlN?=
 =?utf-8?B?VnJRVCtva2xtbmVpaDBhMTNrRDNnby9YSlVxNnBrT1BWdy9RcFJ5bFl0QWdj?=
 =?utf-8?B?VlJqVjZ2MnBnVGd2elAvYUFtUzVTNzJKMWliaG5tY3dFK3F0bzRWL1pNVTNC?=
 =?utf-8?B?alFvZmhac0Q3UlBxTnpWS3Z4cjI5SEE0SDlNZU1mZGxJUTdoeTg3MzViR1Fz?=
 =?utf-8?B?SHRuY0ZjUkVVNEJlSkFyRk9uS2xxMlFjNW5jTXE3OGcrL2JtOVBpR3dQSmhp?=
 =?utf-8?Q?Zs8GF+7xeOW3BW7fSrcpxJ+sVrGLY4Zj1nWSO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7290.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92bee53-e2fa-4306-ea0c-08df164d796f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2026 12:56:51.4588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbrpC//YFFg6gukXuzbrbGwFvt7/0rDZLdW5EV4bFkoHeF7OLGVqBWY4+Q3PvmGw74ZVgk+EBN4biH9pieG7Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226

PiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gWy4uLl0NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gRURBQy9pMzAwMDogRml4IG1jaV9wZGV2IHJlZmVyZW5jZSBsZWFrIGlu
IGkzMDAwX2luaXRfb25lKCkNCj4gWy4uLl0NCg0KPiA+DQo+ID4gIG1vZHVsZV9pbml0KGkzMjAw
X2luaXQpOw0KPiANCj4gJCAuL3NjcmlwdHMvZ2V0X21haW50YWluZXIucGwgLWYgZHJpdmVycy9l
ZGFjL2kzMDAwX2VkYWMuYyAuLi4NCj4gRURBQy1JMzAwMCBzdGF0dXM6IE9ycGhhbg0KPiANCj4g
Tm8gbmVlZCB0byBmaXggYW55dGhpbmcgaGVyZS4NCg0KT0ssIGdvdCBpdC4gVGh4Lg0KDQotUWl1
eHUNCg==
