Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.122
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794458266;
	b=B4V72Kac8w9q1xkZPpUCzgJNH8dxHoMHH7o/SYra9bjG+AM4aNXTO+210II2/K55/AAP
	 yJ6chOtMsFZuDArJZyGYvFeK3HsH+Swvn6korntOml7/f3w2vM0rWkParKKxzNEBHmtCN
	 mpffeRLkwdB3uMA0bc02gAImu9b9Hkn3ahJVyFdYRXGAnoqZPlLZRf9IIO5YPn+nrH6u0
	 iahMPMP3Aa+Sl++dGinNgLzeBVVVmFzu2jwUuu9rrRrkeRfEciVjckeGWkdQ3zhZesOjh
	 qaUgSvgEG8lRhJ4YFpjinf8EUy84XHn9g+8d75/WJSXY5p/bs7CcWwi2NAEwQQ0bLmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458266;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	bh=/RHgIEVnexdMmgUFVs3hGzCq5OiCe1gfTtcVfGCkQ1Q=;
	b=d1OpsN5wrQ8Xk1K3DCPxVFYNqU0XwmMMO7rsLyn70SLNKl42M2e/thaNXQd/ylHlwLbg
	 uQvbKRa4tJUpZhWNf8tgug8pz+JT0+ujSVjJn2am25dmnkGier/f3UZ8eW4ulCi16JiNu
	 SgpjKxkFhbR6nT8AK+OJZalc+pf7d4IFBqR01T/Md8xR5LzyFTsHzNnAW36D9kSzImlcW
	 ozWTTLjtwBoV7TvQpa2I80UB5BRUS8u42qJBn606Nfv73TapC+HjEIsFv57jwraYIvcSy
	 32xJgoAbtDQPzWb88iUoTT9sw4B//yMk7uwsyidx+6WJk/oJ41UeSi1yYFQaZK8LOuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=cC4DqvmP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.122
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022122.outbound.protection.outlook.com [52.101.66.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCECF60A5BC1;
	Thu, 12 Nov 2026 04:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCECF60A5BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=cC4DqvmP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4B+X+nO3bPczFeYUlA4hMOmHlVBfjv0YojZRMCRwCJxJhTTCaOwVdNlf7xZN7akzSSFlrUErf6vrfDNkF6bk34Sp+tvV9dFZWUG0eFCu8x5Qzjh+vILdVvEmMSLotGMZcCvCnI+Nn2Yp9zxMyxF47H5/z/CtYulcWecz//fobKeALs4IlOf5BJWP0VCsaNAfBrTx5wkdmBPoWuBfrwvYPIomLWIbcqVxoWs9EXEis0rcYkgj46q6Yfv+Rhun0fVY0sJBGjBbCVKpr8lNY6uo87Vf8HuFIs1MmMiXnxCGTlOkbIaum/w5iBHBMkMzE067VdId7A6o0oVMW1IoZ5D9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RHgIEVnexdMmgUFVs3hGzCq5OiCe1gfTtcVfGCkQ1Q=;
 b=AGKIcinqZHyWnhLwzTvjwDsYeozqNB6GKCC/aYAyQrb9zx2CzL3hzvs2n0vvlShaTf89lcI2ntMSoIh7nPOArTpKKvw1pVlJsnHlne7p5XEefQDrnyxApygiCTouMq9uIh6Va4s7yV5RH2+MFDmFDwahmjGXYcwPSg1c8AA7JF5U50T973VOrUzH5hwrgp4L4aoKc9Wmv4QNd6aU+gg3D1es+PJ/z0z/AROjKG4M3PMrQD4p9BrNJWoFNN9JdcQacPhFzgJw7ca8wnLfDzrDvs54P3A94SQ9zG657OS3Mo6hLlz+Ui4XBHyd66DfIGsNj7pFlklqxsLBXeDm/w2sLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RHgIEVnexdMmgUFVs3hGzCq5OiCe1gfTtcVfGCkQ1Q=;
 b=cC4DqvmPtzJRts2fsguao9yOHbMmkkKUzxrVyfN8l6lSPqA8C6fbCRYSasZS0OikUJPr73oAhnyWoA3wCweYw9JtAwwAhVx+yDJmO6i1myfz02LnP0KBDiu/sAQ7KyTT9Y2qL32jIWzSK00bSgANLxScxTm1x1UEDf3PxHyjt/skuW9Q788Y1kFRre17uF3/a2aJvwsb6yJPvJOxi1OJXWWVswE9Lzy/PUwuTxLpRS1V4Oa0w8EZV6YiMSQc40CtMH1YCrqHPExbKoCZ5FkllC8Y/bBwfzmLz/yQkNtIEJIYxjwhDfiZvdoReo2ChoP8v/ak16Ief4zF64uooTXjEg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by VI2PR06MB10826.eurprd06.prod.outlook.com (2603:10a6:800:327::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 04:37:36 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 04:37:36 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Thu, 12 Nov 2026 04:37:28 +0000
Subject: [PATCH v2 2/2] serial: core: do not touch the port after dropping
 the last reference
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-serial-core-remove-deadlock-v2-2-d3ee4ccec37a@vaisala.com>
References: <20261112-serial-core-remove-deadlock-v2-0-d3ee4ccec37a@vaisala.com>
In-Reply-To: <20261112-serial-core-remove-deadlock-v2-0-d3ee4ccec37a@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, stable@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794458254; l=1874;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=kJEkUSfZLjoIn+j8iSkev9B3RYIJG+yXr0FfMVmAEKo=;
 b=s72aTr4aIbJvv6ImmLQ6JB5BiYzKh1IR4LaOGfYXd+3TCUzXF0Rbj6RunS1851RXfhuHNKEY4
 +n2eskgNwKUBanOf7rGxWnkxWH88rNtRdM4sgcdl4+bQWcKKWYuqcgj
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVZP280CA0094.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::17) To PA2PR06MB9176.eurprd06.prod.outlook.com
 (2603:10a6:102:407::17)
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|VI2PR06MB10826:EE_
X-MS-Office365-Filtering-Correlation-Id: 4465d9ef-f25d-4cae-d449-08df4076acd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|376014|366016|1800799024|261026140227099003|38350700014|10067099003|261021123027099003|261021121427099003|56012099006|261009221227099003|11063799006|261009223027099003|261022075727099003|261028144727099003|261022105027099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fVmxMoY52Ja1IeIplhUm6Yu8U8LInqiReJ7RJfIREv5AslXeSNaJyEUw+PpOLiuOXhqVVvqDma3t0MCbF5bN/445mShTIuGQXE0dAQxh3PLKbFDxF4MU27AL64EunaZBK3Yn7VtWl1GI72Tsr30Lh4zBIP7x0xketrbYux7Op+hNnuvAbIMdqRcpNqe8QfvDLOw01zFHwWcnj0yaYjh9c5MAjaSAZCklESTsDGOV43WLoqQbUfsy96Yxfij2twBFYT1LkD/JsOVnvlXdcWO1STkJnVtbFD4pa+l5lg2ywJAvtjBGDsN5CRA112Wyr/fBcRdKEZr2vAhDxyPRSARsEVOPdH4TUfW8QryHKnXX0ElR/7dekbeaLg3xcQvPSZzM6uiWav0VI/qNLos7Zx+pDEdWJrX5Uz2kdyYuVsQCk5xLX8P+j9ZrR0NYX3/yj2grHFEXron3oGoy6VVEXbQY8KXLrCEfv9vyWL3HMYk3zlDr6LiHaYwSTEDY0UtMbgapWIUlWir0HvtlaYIBTQOhJmbAwovAaquYivThqrFKW5Fou+sdJsIUvsCLMeGwcJ+YMi7r8kv0gJZfWBQ34lfD0axiN4+t9GYjfZEy4oMTgNhm+5fAC531ey7T9pj7Nug1riR/cOTmzP+im4Y9sQdO2jJ145XHZYQdz9qkcvosJ8u7CswxAjPJQ+sUdhGB3dTrLtttbTpmqdLmCaEavqi4U1csVQK5WefGWRTtIz7vh+A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(376014)(366016)(1800799024)(261026140227099003)(38350700014)(10067099003)(261021123027099003)(261021121427099003)(56012099006)(261009221227099003)(11063799006)(261009223027099003)(261022075727099003)(261028144727099003)(261022105027099003)(261102123227099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVhVTi9jVWZvR0ZFRnM4ckkxL1NWcmtoVmd6dldyMk15WWlpWnpnanUxMmRT?=
 =?utf-8?B?OGFkRmVIYURUd1RWRTRkb091YVhNNWdQRCtuTHNtRHNqb2FEbERpT2UxZkg2?=
 =?utf-8?B?dTFzRTVobVBZZDUrVURGMnBnb1hOekliZG12d2RlRm1zb0hZUWFQYnBIaFBZ?=
 =?utf-8?B?QnF4cTY0M25DN1F0UmhKU3dMdHhzTW9xSmJEb0ZlcG5LdzlkRUhTb20wUFI0?=
 =?utf-8?B?RW84L0dnMzV4WWFvd1ZsbFVMS3hUUDd6dEtKc0JFWjRUbmkrNFBSeGRndGg2?=
 =?utf-8?B?MkVvakUyNWRWTGlZMjlBZmJhM0V2NUdtQkk0a2YrS3RWY1pydHQ1czhoN253?=
 =?utf-8?B?WXR4dHVvTFlpaWswYTEvV1ZMS05MM2dvSmZtcVZ0MlkyNG9NYlFkdUgvUnJv?=
 =?utf-8?B?bWVDdUlGQXpFc0NVU3lDWURZTmxtUDdDSzdsR0NteDNSWXRxWTRVaFJuWFh5?=
 =?utf-8?B?dy81YTV5NllobWgyeExXQU9wQjUwZnRZL2tQeWhTK3VwSnY0NGdXeGFKdE9O?=
 =?utf-8?B?aUs5OHc3V0NydXNWSzIzNmQzT04zdkpxRUtwajV6bHBtZlNwUmZBTzU5Nmdo?=
 =?utf-8?B?dUYvRjk4VVBuVmY4bFRBRHl0bUh4RXRHbDVVeWhDZ1VNVWY2Nit3elVEck5Y?=
 =?utf-8?B?c2ZCNDQwM1oyRlozNmxWOHUyNkdaWk52SHZ1RkJScHdDQ3BhR004azc5OXdx?=
 =?utf-8?B?QnYrT1RoRmM5MlVRWXhBM3pJcHdVUC9SMHRubmZPZ3JGS2xCRmZTampVQWpq?=
 =?utf-8?B?YUNkeGpxZkNnTzllV3NPeUVwUDUwYnJwMk5URElEOXR0eEEySG5OZC83NHFW?=
 =?utf-8?B?TlNmQ3FpQXNaMlJPZkt2a2t0R1o2Nm1veGU2Tm9aWExFRzJid0ZJQWFqQzVt?=
 =?utf-8?B?MnJ1dkJqeGFrUk1iZXpjMHVBWGh5MUVLaGhPRzREeWFHbGx2aFBGdXQyUFV0?=
 =?utf-8?B?TDNEdGZZL0Ryb2MxSzVpMnFuc0luUlMwSklXNTRYb1Y3UGt0UFpQQ1lNc2N5?=
 =?utf-8?B?d3VMUjhVTlVGcVN6bmZMUVFGdW4xZVh2R1F3YmdLdFBITXMyQ3NzRXROVExL?=
 =?utf-8?B?MDAwV0dFV1ZuQjBUS2d0Z3RoeGxEVXhibFdYdXZoM1YvU0pPMFZnNzk2UmV3?=
 =?utf-8?B?cVhOZGNpdUNoNWNldXMxRnB5TDZPNlpjb0pndzIzTUtIUkhlTHY5Rm9lNnNN?=
 =?utf-8?B?RnpkZlJHeUtMWS93bHllYklXRHdBQ09OZkYyT0duUXRhcE0xNjRCY2F2U2tI?=
 =?utf-8?B?Wm1CdHVxNTJPdHdzZnNidE1tQ2F5SXVwcTVVWTZiUXIwM08reUlCcHBoVWt1?=
 =?utf-8?B?VWQ2ME9DamJnR1VuRmRvZGxHOU1iUFVJcUxPWE9ENjFOOVlUYW1SZTNGVzZz?=
 =?utf-8?B?Vlg2bFlmVGJxY2RFWm5oR1FDczNJVGcxTUFhRXI1dG9ZS2U1SHBNL08vRkNa?=
 =?utf-8?B?bk5jU1N3cjlmZ2dlbVJ4MTRwZjFyejlOMmFrU1ZNZ3BkRm00VmxiOVFpdGZT?=
 =?utf-8?B?ZWNKWHVLQnZtTS96L21WU0k0Rjc2bjlzRG9xRXRRRWsyeDlUT2lSakpHYzBs?=
 =?utf-8?B?T1dTeGxhOFN5SHJ3cFBDaWVHVGRMVXZIWGNHVGdZSHd2QXhweDVUdnVtYlcz?=
 =?utf-8?B?Ty9zd0szbTBiNWtaRm5vUVRrSGJIeVFaNGpVLzErYmQ2TjlVU1dLYlZyTjZR?=
 =?utf-8?B?YlM1UEZjWkVHaWxuZ2dmYXJ2VThEMGV5d3AxSzh3SzFHNXEydEtRb3ZaSnVx?=
 =?utf-8?B?dXh5aGEzTGUzeHVKczJGS041Y25mU1BydjN5VGFFNG5VdkZiNUlnOTVlVU5Z?=
 =?utf-8?B?T09sM0p3NnpvWTBaSVd2L2RoWjVrMUp2aXFrS2I3ZXFIRjhwZkVYdEF5eUxr?=
 =?utf-8?B?NzY4V2VNSU15dXZoZzFKeTdyK0k2bTRqaTdFeUpMcGxYNldwVmZuZk9XM1JK?=
 =?utf-8?B?a1VkVS9DS2FYNFF6T0tMd1lYelJmWUF6eTdGL1VpQUJVTGdUTTBqdTZqMXpN?=
 =?utf-8?B?V2M1Y1JrR2JoVnE4REdMeVV0VTdKdm55cEo3NGpqNVNUUjRLY01MdUdRaWsv?=
 =?utf-8?B?aERkamZ6SGx6Rkd3cWhQRmF3bFVqS1ZVYzE2ZWJKc0Q4MGlGdmljMitPRkNk?=
 =?utf-8?B?KzQ5RFlaVU85Sys2RjRzTlVmMEdNcUNVS1lSZC9QbmRWSGxOZXhLNHpQc1ZR?=
 =?utf-8?B?TGZuUElVNHVsbk1NZkRWMW9zODczUmZQVWlId0dFR2ZYWnFIbmpBdktSWXpm?=
 =?utf-8?B?cWpwYm54QjRPbUtpdVdzQU94dzlmalB4YXZqbVBTcnVHL25udFZ2S2svL2Mw?=
 =?utf-8?B?ZEhLVGJqS2xjL25UOEwwRzlPbm9RSzJ4ZXZDTitqUkY0M25sckxLVm9NWVdX?=
 =?utf-8?Q?Y6rXHuhaJecf9/3M=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4465d9ef-f25d-4cae-d449-08df4076acd6
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 04:37:36.1012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEL7quVqMKmxlNFQs5YoQmtTnGLx37NoUKhGsIOmgG2BPiLFMt19OyaQZ9MTRWedeRrAv7xos3UwnpreoqHCUxlYkjxEAlYZzvcpG1BPgk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR06MB10826

uart_port_deref() decrements the reference count through uport->state
and then reads uport->state again for the wake_up(). The last
decrement is what lets serial_core_remove_one_port() return, and the
driver may free its struct uart_port right after that. A reference
holder that drops the last reference can therefore read the freed port
on its way to the wake_up().

Read the state pointer once, before the decrement. The uart_state
belongs to the uart_driver and lives until uart_unregister_driver(),
so the wake_up() target outlives the port. Drivers that unregister the
uart_driver in the same remove() are a separate matter and not changed
here.

Found by review of the removal path while fixing the deadlock between
port removal and a blocked tcdrain(); not reproduced.

Fixes: 9ed19428a51d ("serial: core: Prevent unsafe uart port access, part 2")
Cc: stable@vger.kernel.org
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/serial_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2e53d194ecfe853ade1ac6f33e047eb8ff11e283..c3d21acbd606eb3ea2909736a01a66f204141be1 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -72,8 +72,10 @@ static inline struct uart_port *uart_port_ref(struct uart_state *state)
 
 static inline void uart_port_deref(struct uart_port *uport)
 {
-	if (atomic_dec_and_test(&uport->state->refcount))
-		wake_up(&uport->state->remove_wait);
+	struct uart_state *state = uport->state;
+
+	if (atomic_dec_and_test(&state->refcount))
+		wake_up(&state->remove_wait);
 }
 
 static inline struct uart_port *uart_port_ref_lock(struct uart_state *state, unsigned long *flags)

-- 
2.47.3

