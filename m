Received: from smtp-mibc-fr-09-azure-outgoing-2-3.mailinblack.com (smtp-mibc-fr-09-azure-outgoing-2-3.mailinblack.com [185.209.208.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0043B71BD
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.209.208.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926655; cv=fail; b=c3EZ3awHgzJbbnFcLQ9wEeHKXybWIYBEu68/aYJA0CrWdIlzvikVTH9Rqei9T6MD1HEYzgUNsrP3/PD6Nfdbg31+95ElsESZjJJhyl2YPqK5M4ZxmvjOK3mrVCU7fgrrmux0dSu0c4473Redvx1mUq/wv2pCu8KlL0i1txoBO90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926655; c=relaxed/simple;
	bh=/hjwVq3SCH5gWhYwWTpQJPbkHBYM6T5vp5XrAWZW6wg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N4VAlk8EepVB6Ss0lKDm96DfjTalYUcbwy/52kj81XkqDcw8n3JL3Zdzf/1Ms6OY2eARIpAwlkq6pkHy5di3JMsx/XBWIvaY4AzSoGeqcfOu45H/bnIcTRVG4kHdGsuxA14mJqAR2X4mGHWyJAli6k1KSBq9pDj7108yXYP8kF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leroy-agon.com; spf=pass smtp.mailfrom=leroy-agon.com; dkim=pass (2048-bit key) header.d=leroy-agon.com header.i=@leroy-agon.com header.b=YYTmg8sh; arc=fail smtp.client-ip=185.209.208.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leroy-agon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leroy-agon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leroy-agon.com header.i=@leroy-agon.com header.b="YYTmg8sh"
Received: from MRZP264CU002.outbound.protection.outlook.com (mail-francesouthazon11020138.outbound.protection.outlook.com [52.101.165.138])
	by mx-1-mibc-fr-09.mailinblack.com (Postfix) with ESMTPS id D61E6D80041;
	Mon, 08 Jun 2026 15:35:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8Kp7Oun7sxplLq9Sfn+1+Agcis08PbhGgpHnIE+0TaCP47IEhNL/b4uosP3O/ueLNrwd4ZYO5zlbuJ1VuiAvgUliyp/7BottYrcPjVjYEUql9PbIvSfg68YtzyMhGPlLlKxbPsVh5r5vHuJad7D8iqzMwI1x/sSq4EK619cJknmfeab6pItY1YLRVmbaDGkjeEIE1piTBXY0Uy9bBsd3Bfs+g7YdJlQU+R1yAH6BsdZszorzirskpZjrfOdYSvb8N7WXVESapDNzt03Ht0ZGujwIrmhtFctB0rniesDqUqdvmJi7o7tXQ/+KZ6AwgGRppUkrmQ/fo0x6ssxw+bWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfUjI3J3E2knt+sfUfVZ7sk+y2fg9Iu66IQWQol72lQ=;
 b=Q2PKspdpBLyMxFxlQgiRL1KG40PWr2LqptGpj9PQ0ks9GMFOLfxwt0FQ7hNCSpzO0NrSI2wlf7CH755jioEHcxMNo/9qucqTRt9NZdiQHnqrBbj4BglwyoD3+XlN7ctb/Lm541vRvtnp1Km33/ljEYoFitjPFYk+L2vAJvkUGNgeBfvR+oGE6Uc/9jWHSYKAM6g+VKDbIYEXWSuT4G2TlM9xMTnCKbyLlwWIN75JY5VeisrBHFj3tn1BUfCt1OONCQ9k3xiSHTrYNmjK81rMFacYknxHUOG3Y9Xx0C/0Hlq9HRFwYLoLdzqMJeF5q0m2BpVJd9Jn/GENkNjd9ku+3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leroy-agon.com; dmarc=pass action=none
 header.from=leroy-agon.com; dkim=pass header.d=leroy-agon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leroy-agon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfUjI3J3E2knt+sfUfVZ7sk+y2fg9Iu66IQWQol72lQ=;
 b=YYTmg8sh7IOmUskDelWBnqmFxxGa8aW4nrWycDQykk79CDYQC73Xvy1GMBXvSYkTXfwf0ZNjE2LEs6NsBZvXRmZbbEDVCztYgo9+jj5Mr5dMMURe2vNOzv8AYo7gtEIsBgwoezvNgLmXGR90yZrLrcuG6Co7DZ9vLQg8xk4cYNpLoWniDh2oc7K7o5ZsI8Hi0hinZU4cdrTD9tvoOdukmrq558XDPD2jLDdD2wmckorIS9qHVuLljcfoYWd9CgywVIW9ugLq/vNlje7mCad6FgqC+CUm7ySd7Z1a4CzYYf83NV8GqZVhc59Ye2UXw5WliYHxTToAjwuDvKwa1qxJCQ==
Received: from PAZP264MB2688.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e4::24)
 by MR0P264MB7639.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 13:35:17 +0000
Received: from PAZP264MB2688.FRAP264.PROD.OUTLOOK.COM
 ([fe80::d3d1:c80f:9bbf:c5d4]) by PAZP264MB2688.FRAP264.PROD.OUTLOOK.COM
 ([fe80::d3d1:c80f:9bbf:c5d4%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 13:35:17 +0000
From: =?utf-8?B?Sm/Dq2wgRVNQT05ERQ==?= <joel.esponde@leroy-agon.com>
To: Sasha Levin <sashal@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Robert Marko
	<robert.marko@sartura.hr>, Jakub Kicinski <kuba@kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: Re: [PATCH 6.12.y] net: phy: micrel: fix LAN8814 QSGMII soft reset
Thread-Topic: [PATCH 6.12.y] net: phy: micrel: fix LAN8814 QSGMII soft reset
Thread-Index: AQHc70+Wp1K41CMp+ka10OJNNdD4ubYs+JEAgAErZICAAkLSAIAEUeEA
Date: Mon, 8 Jun 2026 13:35:16 +0000
Message-ID: <e03a6f5d-1f90-44ba-b000-925c43faa9a8@leroy-agon.com>
References: <7b95f12f-aac6-47bb-ab9f-eab98b3911fd@leroy-agon.com>
 <20260603105137.lan8814-qsgmii@kernel.org>
 <f27cff89-b439-42b4-b29d-2a54e4efd3b6@leroy-agon.com>
 <20260605-stable-reply-0003@kernel.org>
In-Reply-To: <20260605-stable-reply-0003@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leroy-agon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAZP264MB2688:EE_|MR0P264MB7639:EE_
x-ms-office365-filtering-correlation-id: 9357b42b-211a-4b42-4b5b-08dec562c71d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|6049299003|1800799024|376014|366016|38070700021|4053099003|22082099003|18002099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 8XRbMg4NxF1k7Mx1GjL55uzJUB4CqgNukZ67jsF1nMER1QnJYbVy5ZikiOLS7pYbsiNTfMk2FTGYsZWn8YibqDbG5bCt23T8VxJF0y1C+EIniOfeTJwuPxH7fhMjHszsejNPfqZEuMdtG2adPT7CeOajwSc7JvLag7GLdZqpJOXqI5Q5kDyip/GiAj8bPN8eGJ0C6mA+nuF1YnI5hi2lFR8nbhZ4+k8c9j5NVTne784QmV/yoMDXhzKbhrgK1dF8GE/oOEF9NC2LT055YkywYiUktijvw9A2DN5DZ9bggIYgSzEnDgX0+c4GJaLHcmuC5e3qqU8ZNHDTj2PnrbkZwp/GMu1a2+/HgukmxdrNr6q75ZphlFQ2wgHOVBajPOVzxNiCB/AK9FupntJZK2I0BlMEnN47haBdVnt/5T+0TeccMUgZKbMu3lTKuG5P/4ZUwKZP0FPfeZZZoY8qJUKf4mD9mbZY8qtkUampT90Idom70P4wdoAJ2Z0KWL1N3y3i4MYKPJJziwh11pokzz3Qb6mOeyVCoutRxjNrYAZwk3NVXHyO8+/Q/WGbnBtsKKmoAHGCHQVnA8j/GEGC7Jy6U1jYQQpfjLDtWsFB1tA9MNwhzye/NcdGew7UqPrYrNm3i6MUtlN7y4ojEmk5JIUd2/pp0N4SDJvNd6dC5pKCkJPg0Sd/7kDnN7LVIV76tFaEi4vjdSF+cKFkD3oac90ptg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAZP264MB2688.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(1800799024)(376014)(366016)(38070700021)(4053099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEQ3alJpUzRlekoxOGR3ZlI5Vm5oaHRNUVdkdHoyWUwzRXRnYW9CVE5CREQy?=
 =?utf-8?B?SldyR2FlVnk0Y0tHdDdPeDdlUGhiL0NQUHRKMTRhK2VjZUxmajlabmlGcXRl?=
 =?utf-8?B?WHBsMWhSMm1jSGRucWMwSWZiVW5tNlRpNGM5aGZDSnFPQmVJYVpKbHc1VHhv?=
 =?utf-8?B?enVDcjhyZk1kTWdsTi9MUzJKWnluT3R4QzVuRnN4c3RVak9WRXV2Zk5UZ3Vn?=
 =?utf-8?B?djY0bGV6d0dvUVBWdk9Iek9EaHBrLzc1ZG9OdlFkeHdkeTRPSTV4SUozekgv?=
 =?utf-8?B?cWtpT0NZVDJ5U3p1RUp1L3lYaGJ0bWtjcGEzRldtczFIUExyV0JvUXl4RDV2?=
 =?utf-8?B?RlQvQnZOZWo1NWYxeDRocExYOVRXa09xc2szVW5JYTRFMEFsWDVRYXNoeGxu?=
 =?utf-8?B?UGl5WHBZcHBkU2pDNXh0RTl0d29QYTJhL1g3a3dUeU5MWHJ4ZjdFdFVVZWVB?=
 =?utf-8?B?aVpZK0xsNTRvaFJaMlhHUWNFS0tjajYrYTNUWE82d1ovcjQzTVBsRmFPd2h2?=
 =?utf-8?B?Nng5WjdrdC9WTVFhNUUrQlg2RWhGU0s1OU9GWFRMNWRkRDVUSktlUHFjRExN?=
 =?utf-8?B?MnBZcU1lOGdaa3BWeUE5MmMvL0ZzenVwM2R0aWtZTlVidUcxSG5mMFM3dUlz?=
 =?utf-8?B?NTBzaFBJYTkwbitscnlFMGpzK0gweG1ZYjJqZVFTRURrSUZ2VXVyaEZkK0xy?=
 =?utf-8?B?Z2oyaXZTN3dqY2xidkFwQWE5OGdYSTlSQk4yVnlweWlUWElXTlFBakZnRUpS?=
 =?utf-8?B?a05zeHJIQjN4VWxOcVlVZnVuUlJZbW0xUG1hLzRTV3cza1RubDNyM3QxWXVY?=
 =?utf-8?B?Z1luNUNNOHJiWmxjMVB0Ym9nVldGTFJSeEdZeWFSR1NkamIwUGVGNHVObXVT?=
 =?utf-8?B?Q0FjVFJiU241OXRoaERmc3Z2RUpPUENMTGNyTHNhL2wxZThOOXlrN2RrQXph?=
 =?utf-8?B?UnFvUkYxZmlQUzkvZk1yRkkxeDhkcEdTMjh6bnI0bGlVeVk5OTRONWplY2ll?=
 =?utf-8?B?bUJHQkJRYnJpVVlrQi9UUWhSQVlnWDYycDVMcC8vN3U0RmJ4TmRXVFlIVnky?=
 =?utf-8?B?b2hHSEs5M3FWNVdWN0hQTjkxUWZwRTlDQVl3R2pwdFdNTGhhV0hMSmlmZnpx?=
 =?utf-8?B?ZmZHelpqY1laM1Vac3dIcTJWZ2Evc1o4UEhLMXNSTndzaG92SXRuZG5ncDk1?=
 =?utf-8?B?RUJSS1JrdUFlWG5OR1lhc2QzcnRQamxzcklaemFPNWVvZVJXQ2hzdkJBcXpD?=
 =?utf-8?B?MDVqSjAzbjNabWZFdUYwUlEzQTR6TFlGVWxzQ2lVZzZZMHpGcWJqN1AvYm5r?=
 =?utf-8?B?bEhHYkR5c1RmdzdDWG5uMHFXT0lzVnJ4OEFEZ2g5Y21QVkk2WGttQTUzTUlT?=
 =?utf-8?B?bmprMUdoQ2NhbTI4WEpGMzdTUnpyRFR5RFkxQzk2RzZmZWlZZnJNcU9pUitv?=
 =?utf-8?B?QkhId2lmMFIzWERFY1Zlb3V3WmNiQ1NGWVNSalVhM3RoQW1RK3g5RVFyWkor?=
 =?utf-8?B?R0k5MzFjOGVqMllGQkY2TWZSQ2VNTU1vVm8yaW5IOFRNTXBPU25sU3hlSGZS?=
 =?utf-8?B?bUtxalZMOU0wZXd1dUM4aHdUU01TZ3liNXpjZThvYS9jM2dhVFNNVHhCdTVy?=
 =?utf-8?B?bnlPdGdSTW1WVng0SVhrWC9IbFhOM3ZMdjNtWGlTdDVobzZvY2l5T3U4RDJE?=
 =?utf-8?B?UGlwRzZYeVNiYnlvN3ZxQUlPdEswU0xFRURBQko5WnpPSy96ZUFvY1pBSSth?=
 =?utf-8?B?cmdOcFowZGF0Q3l6U0JhTWM5Uzc5Q2d1SHM0dnlQeXBRYUxNNkxjZTUwendD?=
 =?utf-8?B?R1ROK2RueXJTcTdOcXFrWUl1TTVqeEVEanhiYzBXWWVTSjdGV0hZeGRKK29q?=
 =?utf-8?B?VFhTWFpjM09nQm5rek9RcmxVQ3lLaWVRZ2F5bjdwOThvYXhTc2J0eTcxUkJt?=
 =?utf-8?B?bGxOZWpQWVI2aXFtZDB5OTRpenZ4Ti9LM0dtYzcxVzMzNWdjNmFaQytjQWp1?=
 =?utf-8?B?UkxQbnljdC9PWlZVNXYrNGpTV0RiMGNvS0JYbmN5U2V6emhnZjZRc25ibmlu?=
 =?utf-8?B?dHV1bXVhZ2JyNzJLMU5BZitjYzIwNmg3bmh3dG1LTGR6S3kvVjcrV0IvWENp?=
 =?utf-8?B?YlR2anp4NkdCR0o5b2xRc0dJYWlTUk1aV2hVUnFOTlc4R0dWR21Mck4rTlE3?=
 =?utf-8?B?ZWk2WXQ1dUthVmJyTGs4QWxjUlROZlB3MmlYTFoxU0lSTnd6OFE4d1ZpUzFT?=
 =?utf-8?B?dEFHUHpHTWdLeGdBVmQrcmpacFZDSzlZTzROR2phRFhWWHRFL0NOOXZBbkJC?=
 =?utf-8?B?OWVtRzlEcnhhTTBWODRzNk41bE5Bc1ZsRVM4eENBRWd5emViRTg4Y2g1WGl6?=
 =?utf-8?Q?8iUcCfPjj612ullw=3D?=
Content-Type: multipart/mixed;
	boundary="_002_e03a6f5d1f9044bab000925c43faa9a8leroyagoncom_"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	HyoSHpx2kMyEdU5Ur+Bsqhr0FwMWqO9BiZ0CoiDH2/sAqFuPwXRF43zBF3wzO78A/4liugKU1epo3QanEgoYJ1lPEWaQRG3wH3Q9mIVYFOCim6DYk+vZU8Rzwjy1qmr+RV6iiYLR0+HzPcQ+cGkeySd1Tb/R1qIRhn/QHYOVPiKOiXW1lTOAW31dtALfiE0KcL2jxjvK294/BSypXFsL6WK65MA15WW+Q/d/xajH/Dq+I2ybRr99BDlBp6p4oHH3EpwQHLuM4j39fKDVVxZ5vnuVVZHzSul2SxVnW24mw06WvHjan8BP/kBksn2cjhhZC316Yrljqile9uLCsL5hSw==
X-OriginatorOrg: leroy-agon.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB2688.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9357b42b-211a-4b42-4b5b-08dec562c71d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 13:35:17.0853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b97cad2-240b-425a-b0cb-987a43def8d0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dOBm42n3qQ49L1+C8weeJkZ+pQQrsnZwdoLj5GuEw2sMIGsfInpWST9FdH6O/D78MfmbO4DaJo6MPgDcB4uZ+RhnAtG1Y0aqhaPOyKw1zeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB7639

--_002_e03a6f5d1f9044bab000925c43faa9a8leroyagoncom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F167EA3827DA3468B4CF74C79414806@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64

Pj4gW1BBVENIIDYuMTIueV0gbmV0OiBwaHk6IG1pY3JlbDogZml4IExBTjg4MTQgUVNHTUlJIHNv
ZnQgcmVzZXQNCj4gSSd2ZSBxdWV1ZWQgdGhlIHVwc3RyZWFtIGZpeCBmb3IgNy4wLnkgYW5kIDYu
MTgueS4NCj4NCj4gRm9yIDYuMTIueSBJJ2QgbGlrZSB0byB1c2UgeW91ciBoYW5kLWFkYXB0ZWQg
YmFja3BvcnQsIGJ1dCB0aGUgY29weSBvbg0KPiB0aGUgbGlzdCBpcyB3aGl0ZXNwYWNlLW1hbmds
ZWQgKHRoZSBodW5rIGhlYWRlciBnb3QgbGluZS13cmFwcGVkKSBhbmQNCj4gZ2l0IGFtIHJlamVj
dHMgaXQgYXMgYSBjb3JydXB0IHBhdGNoLiBDb3VsZCB5b3UgcmVzZW5kIGl0IHdpdGgNCj4gZ2l0
IHNlbmQtZW1haWwgKG9yIGF0dGFjaCB0aGUgcmF3IHBhdGNoKT8gSXQgbG9va3MgY29ycmVjdCBv
dGhlcndpc2UsDQo+IGFuZCBJJ2xsIHF1ZXVlIGl0IGZvciA2LjEyLnkgb25jZSBpdCBhcHBsaWVz
IGNsZWFubHkuDQoNCg0KSGkgU2FzaGEsDQoNCkhlcmUgaXMgdGhlIHJhdyBwYXRjaCBhdHRhY2hl
ZCB0byB0aGUgZW1haWwgKHNlbnQgd2l0aCBUaHVuZGVyYmlyZCkuDQpJIGhvcGUgaXQgd2lsbCBi
ZSBmaW5lIGZvciB5b3UhDQoNCkpvw6tsDQoNCkNlIG1lc3NhZ2Ugw6lsZWN0cm9uaXF1ZSBldCBz
ZXMgcGnDqGNlcyBqb2ludGVzIHNvbnQgY29uZmlkZW50aWVscy4gSWxzIHNvbnQgZGVzdGluw6lz
IGV4Y2x1c2l2ZW1lbnQgw6AgbGEgcGVyc29ubmUgb3Ugw6AgbCdlbnRpdMOpIMOgIHF1aSBpbHMg
c29udCBhZHJlc3PDqXMuDQpTaSB2b3VzIGF2ZXogcmXDp3UgY2UgbWVzc2FnZSBwYXIgZXJyZXVy
LCB2ZXVpbGxleiBlbiBpbmZvcm1lciBpbW3DqWRpYXRlbWVudCBsJ2V4cMOpZGl0ZXVyIGV0IGxl
IHN1cHByaW1lciBkZSB2b3RyZSBzeXN0w6htZS4NClRvdXRlIGRpdnVsZ2F0aW9uLCBkaXN0cmli
dXRpb24gb3UgY29waWUgbm9uIGF1dG9yaXPDqWUgZGUgY2UgbWVzc2FnZSBvdSBkZSBzb24gY29u
dGVudSBlc3QgaW50ZXJkaXRlLg0KTCdlbnRyZXByaXNlIGTDqWNsaW5lIHRvdXRlIHJlc3BvbnNh
YmlsaXTDqSBlbiBjYXMgZGUgdHJhbnNtaXNzaW9uIGRlIHZpcnVzIG91IGRlIHRvdXRlIGF1dHJl
IGNvbnRhbWluYXRpb24gbGnDqWUgw6AgY2V0IGVtYWlsLg0K

--_002_e03a6f5d1f9044bab000925c43faa9a8leroyagoncom_
Content-Type: text/x-patch;
	name="0001-net-phy-micrel-fix-LAN8814-QSGMII-soft-reset.patch"
Content-Description: 0001-net-phy-micrel-fix-LAN8814-QSGMII-soft-reset.patch
Content-Disposition: attachment;
	filename="0001-net-phy-micrel-fix-LAN8814-QSGMII-soft-reset.patch";
	size=2607; creation-date="Mon, 08 Jun 2026 13:35:16 GMT";
	modification-date="Mon, 08 Jun 2026 13:35:16 GMT"
Content-ID: <1CDCC849C2119148A9613F51D5F720E9@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64

RnJvbTogUm9iZXJ0IE1hcmtvIDxyb2JlcnQubWFya29Ac2FydHVyYS5ocj4KRGF0ZTogVHVlLCAy
OCBBcHIgMjAyNiAxNTo0MTowMSArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIG5ldDogcGh5OiBtaWNy
ZWw6IGZpeCBMQU44ODE0IFFTR01JSSBzb2Z0IHJlc2V0Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRl
bnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29k
aW5nOiA4Yml0CgpbIFVwc3RyZWFtIGNvbW1pdCBlMDI3YzIxOGM0ODJjNmEwYWUxOTQ4MTI5Y2Nk
YTNiMGEyMDMzMzY4IF0KCkxBTjg4MTQgUVNHTUlJIHNvZnQgcmVzZXQgd2FzIG1vdmVkIGludG8g
dGhlIHByb2JlIGZ1bmN0aW9uIHRvIGF2b2lkCnRyaWdnZXJpbmcgaXQgZm9yIGVhY2ggb2YgNCBQ
SFktcyBpbiB0aGUgcGFja2FnZS4KCkhvd2V2ZXIsIHRoYXQgYnJva2UgUVNHTUlJIGxpbmsgYmV0
d2VlbiB0aGUgTUFDIGFuZCBQSFkgb24gbW9zdCBMQU44ODE0ClBIWS1zLCBzcGVjaWZpY2FseSBm
b3IgdXMgb24gdGhlIE1pY3JvY2hpcCBMQU45Njl4IHN3aXRjaC4KUmVhZGluZyB0aGUgUVNHTUlJ
IHN0YXR1cyByZWdpc3RlcnMgaXQgd2FzIHZpc2libGUgdGhhdCBsYW5lcyB3ZXJlIG9ubHkKcGFy
dGlhbGx5IHN5bmNlZC4KCkl0IGxvb2tzIGxpa2UgdGhlIHJlc2V0IHRpbWluZyBpcyBjcnVjaWFs
LCBzbyBsZXRzIG1vdmUgdGhlIHJlc2V0IGJhY2sKaW50byB0aGUgLmNvbmZpZ19pbml0IGZ1bmN0
aW9uIGJ1dCBndWFyZCBpdCB3aXRoIHBoeV9wYWNrYWdlX2luaXRfb25jZSgpCnRvIGF2b2lkIGl0
IGJlaW5nIHRyaWdnZXJlZCBvbiBlYWNoIG9mIDQgUEhZLXMgaW4gdGhlIHBhY2thZ2UuCkNoYW5n
ZSB0aGUgcHJvYmUgZnVuY3Rpb24gdG8gdXNlIHBoeV9wYWNrYWdlX3Byb2JlX29uY2UoKSBmb3Ig
Y29tYSBhbmQgUHRQCnNldHVwLgoKRml4ZXM6IDM0N2JmNjM4ZDM5ZiAoIm5ldDogcGh5OiBtaWNy
ZWw6IGxhbjg4MTQgZml4IHJlc2V0IG9mIHRoZSBRU0dNSUkgaW50ZXJmYWNlIikKU2lnbmVkLW9m
Zi1ieTogUm9iZXJ0IE1hcmtvIDxyb2JlcnQubWFya29Ac2FydHVyYS5ocj4KTGluazogaHR0cHM6
Ly9wYXRjaC5tc2dpZC5saW5rLzIwMjYwNDI4MTM0MTM4LjE3NDEyNTMtMS1yb2JlcnQubWFya29A
c2FydHVyYS5ocgpTaWduZWQtb2ZmLWJ5OiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3Jn
PgpTaWduZWQtb2ZmLWJ5OiBKb8OrbCBFc3BvbmRlIDxqb2VsLmVzcG9uZGVAbGVyb3ktYWdvbi5j
b20+Ci0tLQogZHJpdmVycy9uZXQvcGh5L21pY3JlbC5jIHwgMTUgKysrKysrKystLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3BoeS9taWNyZWwuYyBiL2RyaXZlcnMvbmV0L3BoeS9taWNyZWwuYwpp
bmRleCBmMGMwNjgwNzUzMjIuLjJkY2E2ZThhNWZjZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQv
cGh5L21pY3JlbC5jCisrKyBiL2RyaXZlcnMvbmV0L3BoeS9taWNyZWwuYwpAQCAtNDA5Myw2ICs0
MDkzLDEzIEBAIHN0YXRpYyBpbnQgbGFuODgxNF9jb25maWdfaW5pdChzdHJ1Y3QgcGh5X2Rldmlj
ZSAqcGh5ZGV2KQogewogCXN0cnVjdCBrc3pwaHlfcHJpdiAqbGFuODgxNCA9IHBoeWRldi0+cHJp
djsKCisJaWYgKHBoeV9wYWNrYWdlX2luaXRfb25jZShwaHlkZXYpKQorCQkvKiBSZXNldCB0aGUg
UEhZICovCisJCWxhbnBoeV9tb2RpZnlfcGFnZV9yZWcocGh5ZGV2LCBMQU44ODE0X1BBR0VfQ09N
TU9OX1JFR1MsCisJCQkJICAgICAgIExBTjg4MTRfUVNHTUlJX1NPRlRfUkVTRVQsCisJCQkJICAg
ICAgIExBTjg4MTRfUVNHTUlJX1NPRlRfUkVTRVRfQklULAorCQkJCSAgICAgICBMQU44ODE0X1FT
R01JSV9TT0ZUX1JFU0VUX0JJVCk7CisKIAkvKiBEaXNhYmxlIEFORUcgd2l0aCBRU0dNSUkgUENT
IEhvc3Qgc2lkZSAqLwogCWxhbnBoeV9tb2RpZnlfcGFnZV9yZWcocGh5ZGV2LCBMQU44ODE0X1BB
R0VfUE9SVF9SRUdTLAogCQkJICAgICAgIExBTjg4MTRfUVNHTUlJX1BDUzFHX0FORUdfQ09ORklH
LApAQCAtNDE3NywxMyArNDE4NCw3IEBAIHN0YXRpYyBpbnQgbGFuODgxNF9wcm9iZShzdHJ1Y3Qg
cGh5X2RldmljZSAqcGh5ZGV2KQogCWRldm1fcGh5X3BhY2thZ2Vfam9pbigmcGh5ZGV2LT5tZGlv
LmRldiwgcGh5ZGV2LAogCQkJICAgICAgYWRkciwgc2l6ZW9mKHN0cnVjdCBsYW44ODE0X3NoYXJl
ZF9wcml2KSk7CgotCWlmIChwaHlfcGFja2FnZV9pbml0X29uY2UocGh5ZGV2KSkgewotCQkvKiBS
ZXNldCB0aGUgUEhZICovCi0JCWxhbnBoeV9tb2RpZnlfcGFnZV9yZWcocGh5ZGV2LCBMQU44ODE0
X1BBR0VfQ09NTU9OX1JFR1MsCi0JCQkJICAgICAgIExBTjg4MTRfUVNHTUlJX1NPRlRfUkVTRVQs
Ci0JCQkJICAgICAgIExBTjg4MTRfUVNHTUlJX1NPRlRfUkVTRVRfQklULAotCQkJCSAgICAgICBM
QU44ODE0X1FTR01JSV9TT0ZUX1JFU0VUX0JJVCk7Ci0KKwlpZiAocGh5X3BhY2thZ2VfcHJvYmVf
b25jZShwaHlkZXYpKSB7CiAJCWVyciA9IGxhbjg4MTRfcmVsZWFzZV9jb21hX21vZGUocGh5ZGV2
KTsKIAkJaWYgKGVycikKIAkJCXJldHVybiBlcnI7Ci0tCjIuMzQuMQoK

--_002_e03a6f5d1f9044bab000925c43faa9a8leroyagoncom_--

