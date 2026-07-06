Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E78380FFD;
	Mon,  6 Jul 2026 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347793; cv=fail; b=cxFTkhuUOOSIH+Ppeo2DXz/IeW4wuQL2u8Skfh3/Iywev/yiUrLV0ioTqDB5qWsCdLs9wC7IonY/RWe6b+/gvGUnF7pQbwbrdEGcWmObpBfdBFkm1GMz+6HovtxPDlY/b3Jm77IXb43rVM3tQMzrwfpAeB5O70P400qIuCNB4yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347793; c=relaxed/simple;
	bh=tawvcXZqNK6tOTCC9++COqkrQAsGl7uNaFO6YPFN1ME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YJLfwdkSZVJ7DuuHKjckE/SVpvVWdGjugZiFXGBkl0eruEdpp9rBjUoiRxulqlqXlRuLOcSAjWZKIVrVaYqi1+zyWIyjtJmvjTVOYAb8Lp5RXOH+TP0NmNDhqtX8mhreHrFtOolA/C+2RPnHKVrBM2BokxEDt8D2mfEEzYyZEVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=tPA8aYW6; dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b=o5W9aAlI; arc=fail smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="tPA8aYW6";
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="o5W9aAlI"
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666EGfkk478493;
	Mon, 6 Jul 2026 15:22:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	dk201812; bh=tawvcXZqNK6tOTCC9++COqkrQAsGl7uNaFO6YPFN1ME=; b=tPA
	8aYW6luReFFCrgZpxMu3HwDUnc5n2Fv3AabESBJP1kz1cpUMKBkL137NbAeezyN9
	LuYK2u0x8FnoD5RCmdi8q5mcgyiskjSoPAmqptjDA/R1jlJJLnA1VKXwwKLrXoca
	IVBibes8uXf1PJoDKR0EyJf7s/5LckYTlbFAAIcZs86pITzJVhF1pz1jgLuQ5zHV
	7N0z/nQA60hNCvq8IyTqDg+o4kn1rP8KRhzGYEgCW6lbgwb/vuxqXuD6g8KLbzr2
	Dbz4MlQo6vbj+CWuGtIhjSqx2nEgRha6BjAamyfOkjuENmwVfpMfb3u6PtAb1njT
	7XmEvKaPCmEKUNVO/bQ==
Received: from cwxp265cu010.outbound.protection.outlook.com (mail-ukwestazon11022143.outbound.protection.outlook.com [52.101.101.143])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4f6rephn0j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 15:22:39 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbmalyPKjuaQD7mqGcHagfDGS1q9Yz49xzRlSXa1pCgT2flN9SZRZU/9M0+lEyt90XGOurgz4xPlZkKDEYpdcOV1wUmvAPUuYAbYmHpIEgn0FOLMLVDxnPnyXesxEhynQPYT3Xdh2OfbBMd6SFqxHXb4Pj97CMOIuGNmYp0hRYXMcwFlKvqlj9ymfTVV6Oms9BywQRvGyoNszD5nxqwn4thuiXLtzOeVIwzSmpdZ7+poJbh4Yh6NqKV9EnATsYbPy9adtjnPCoK/xDP8IkfJ1SQIPzs310yMFTmQVgKu4HdOBn0ZdztcjixksnaDeOKet888HVr15a5qnx+94o9AFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tawvcXZqNK6tOTCC9++COqkrQAsGl7uNaFO6YPFN1ME=;
 b=PAiNVkhrf6Ooj4/YnG69hYNFIQFTLlsT/fJPm5Vay+51ZZiU7sEDglNbCazw6hOIjTM45J6dShe8wtbgsO40qJiVG55Gp4ACWXMX7/RQ6RFR01gQM64gp+bY9Hm+b35yZpakRJxep61Lqfw8QaHwoww+XwNRPgRv1hLzmQQFKn5E9hn3JdGUhZbq3eESGGeKItwUYww3Z/P3Q4qs0PkF5kKRC6m/7tZLbgsxnEp1qyDLDSgFkh6DD78nHaVhUHTwykjlQqZ4xlYTVIiVtXFjOoNTvFK15Fu594bNf8K987Kfv73FeC5Ho32AbzqpAHswGb68TXdYnxpPl9WLvd5idg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tawvcXZqNK6tOTCC9++COqkrQAsGl7uNaFO6YPFN1ME=;
 b=o5W9aAlIrpX2DWeYx65JbUPedFBRrQKSfeRXi+/zzVtXHUTopG5wGMF/+C6NgGzUcAOufFoGRLJKR2UlYoo6aTgOXMKonVnwKJiEW0zZhf8tKRbhGTpeWQldS1wmaq+Eldyric3kzQLv0jtpG9cPtBMvrUtS39dD4fN2iCT1u+c=
Received: from CW1P265MB8667.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27e::15)
 by CWXP265MB5442.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 14:22:30 +0000
Received: from CW1P265MB8667.GBRP265.PROD.OUTLOOK.COM
 ([fe80::d42c:82bf:d426:2147]) by CW1P265MB8667.GBRP265.PROD.OUTLOOK.COM
 ([fe80::d42c:82bf:d426:2147%4]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 14:22:30 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "simona@ffwll.ch"
	<simona@ffwll.ch>,
        "zhengxingda@iscas.ac.cn" <zhengxingda@iscas.ac.cn>,
        Frank
 Binns <Frank.Binns@imgtec.com>,
        Alessio Belle <Alessio.Belle@imgtec.com>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "airlied@gmail.com"
	<airlied@gmail.com>
CC: Brendan King <Brendan.King@imgtec.com>,
        "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>,
        "uwu@icenowy.me" <uwu@icenowy.me>, "dakr@kernel.org" <dakr@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] drm/imagination: acquire vm_ctx->lock before mapping
 memory to GPU VM
Thread-Topic: [PATCH v2] drm/imagination: acquire vm_ctx->lock before mapping
 memory to GPU VM
Thread-Index: AQHdDVLg7lLZL4kcakCRkMPniVS9eQ==
Importance: high
X-Priority: 1
Date: Mon, 6 Jul 2026 14:22:30 +0000
Message-ID: <ce1f923e4bd29fff4d52d9ccab4aeeb349aedd82.camel@imgtec.com>
References: <20260421175748.1989002-1-zhengxingda@iscas.ac.cn>
In-Reply-To: <20260421175748.1989002-1-zhengxingda@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CW1P265MB8667:EE_|CWXP265MB5442:EE_
x-ms-office365-filtering-correlation-id: e0140db2-96aa-41d2-0236-08dedb6a037b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|10070799003|366016|1800799024|7416014|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 mPd61hhLA6TlSo4JSaPIIer8qpI6Ci2Y3VCauN1rIIPEMxbewC4/AKoV/bn50GnTJx0uDC5oJnPLqEEsSigIxZl+S8J7YSqhuzi1c+jo7TXnmRaceJZ1DxOyVIoLfm3lVMY+D+wPJZY5vYKzuwNq9qk3+q9Hqq53W65jc1Ox2WMiYhYhixRhDSh6y1Ivjkh4kImAcOpPKw3gIr5Ei+3wn+Uga2pa5fml7L/U9P2hdX1nksDAL7Y7Q2Vby+1miieOZLOwL3tLz+mxxexJnNok370AX+udNml7sAdgEGmht/Inwl1yKXUIkilLb0No8SdpxdFteRWso/Zy9y6ZEnYHsB+wI92gOlTDRUsaX/ZLdV6TiJS4NqcMhBDyD30n4GnU5QG6hen9ee/35/ztyH16MJtuoMp33SmINX2ViMwjuWXhjnCgXz1cEoswUBEOHyQfX0V1ITSw5yzPSQIt9f3YGWDdDBavIDjLBqlNXvOBS7IJoRmhz8VZ/gJkOacdwPOkC6vPDs7zL9JIN/AseJQ7xdWqaxM/hDcJYfETv2qHlfghOijkW6Pf/QAgM7RQwNywvQkOJ+bcUY+bQdLTGot8pRaZxngRvTUPe2UpxfnRdEMoDUDJa87eARQnGOTMAvtKoQpXNYsRLtP+Izlb0S5V6tvYLqwZZsTrfbHJVDm+YF4+oFQ68IujIelB8esTaRQ4IeSJUIS8nA2pkINxb3kvB2/3TOKZP4zMKwoLgQqAelo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8667.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(7416014)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2I0M1E5dnJQQUFYN0NxNlpaejV0Mmc3dmpPRnE0OTY3SXpXbHNMbzRNWjlM?=
 =?utf-8?B?WFEwU055UjdqYnEzeFM3d1ozU2E2T2hPZWE2a3c5S3lXZkJzMytpckI2RW1z?=
 =?utf-8?B?RUNJSW15WDBoMWk4KzFoNW5Lc3JyQlhnMFF1L0ZqSmorZjlZV1BIZG43TEVp?=
 =?utf-8?B?N29IcnA3dkYrVUh0SzhTTDRQMk1tNnYvRFdPTk1iODFJZXZ0cFdaeXNReUY1?=
 =?utf-8?B?L1gvSmx0dUdndllocDhXYVpGZ1lCYzd4UHgrTmpqWE5QSTJaREJTZGkwQlNE?=
 =?utf-8?B?YWVUWWx3NkZzTHdJQ01ra1hlRWFpeWo1MDJJb0l0ZGh3VTB5RlEveVV2RzY4?=
 =?utf-8?B?bDRibHcvZjl0MjBvN2JDSkRpVm1JcTlnVDlMck43QnBZWll6Y05zSzJDQnc3?=
 =?utf-8?B?bzJnQUZaUUlkNC9LaGxTditHUE81emxYc0dFbUxjcW5nTnp4VjF0ZEl2RUkv?=
 =?utf-8?B?bG1RM05ZeGY1S05ObElaMXFIS250OThlM1NDcTdZYklieFArRjBxZDVvS2wz?=
 =?utf-8?B?SGZZbnBwdnFObVBvMTlFZXhRdERTRy9NOHRTU0lETTM2b1RNUm9lOXZNL1ZJ?=
 =?utf-8?B?b3JIMlNaamtxQ3FTTHNxWFdaM2JmbEJ0YlFLSysyV2dhRXA0SHh5cGRvVW5x?=
 =?utf-8?B?dEJjL2wrSjNMRmViSmFseTVZTlBFQzkrTVRId1IzaG43Y2NWWFdmY1FrODFL?=
 =?utf-8?B?ZzJJRzJ4TzAzMlZ3OUlGMTdETG04WmI3MExsM1QzaWQzZld6TGEyOE12V0ln?=
 =?utf-8?B?MkNPY0F6SGFiZWx1L1JqUjgvZm9YNHN2NWZGWFBFazROOWFmN2xYaUNZeE9z?=
 =?utf-8?B?TklKWnlwRjh6bXdBVzZGYzgvY1grVmZ6S2RCUEtIQzFieDZISnVNYmFweXMv?=
 =?utf-8?B?aUFmSEh0K2VhNWd2dGJtK3dXRWdNK3M2cHdDdjFhZlAvV25aU204WDRycTNF?=
 =?utf-8?B?L1NhQ3B0QUcrVWlOT0RQelhnQndvYnFveEFpbVRDVWRTeHdSeElBU2VBRUhC?=
 =?utf-8?B?T3JkQ2FYQWRLNUlQcHliSGZ4dEpqZUE2N3h4UWpIaHZIbTNWcXFYNEI2SEdv?=
 =?utf-8?B?Sk1OSkJFTTZqSE9FVUwrYlNZTE9iNlI5MVhncFF3SkoxaVVDNjZlSFFLY0dQ?=
 =?utf-8?B?RDlXbk01Nmx6VGlmRFlLRFA0aTR6V3hGWDNiR0UvSEJ4bFl6V3NTOUlZZ3Fz?=
 =?utf-8?B?cUE0VFpnMFBZdTBFM0JFRWVBQTJ2SnJWSzNTcVNGdUZhUkZNNkgyOHFySVNM?=
 =?utf-8?B?cVphVmNjcnViQ1NvYlJ3UiszRmt4WkEreWs5N1kyQUxyTlZhMk11Wkk4dzRV?=
 =?utf-8?B?SjlRVHpZcmhWTFlBOWIrVkVXbnQ1b0JJYk5GaGtNQlNQYW9hMFZkZEtFbWly?=
 =?utf-8?B?MU9hck5EWkJLK0dhOGJCTHkxZEdVQ2tPcFhWWThQb21IMURiTitJdjZnR2du?=
 =?utf-8?B?eFpiWU9BMy9JZDNoSmVrekJ1OUlWWHdlTElBUmYzZVJTMjNnUURHeGxGVE9S?=
 =?utf-8?B?WVBIYjBqRXNCYTd6Z0VnZHpzWUZjbm92enJBUmdmZWZ1cmpVOWR0c2ZLaVdm?=
 =?utf-8?B?YjRzVnhiYVJFWEdGWCs1VlcvTGY1dFcyWm5JTXZEcTVScnFyUlo5a0xQZCto?=
 =?utf-8?B?UVNjeUVEeXpTamk3S0c4SEd4U3FTT3UvWW5UZXN0a1VUYm8wbDlxMDBnbDMw?=
 =?utf-8?B?dVpRaGx3MDBVTENlcmxjc2s0ZHY4dTNCd0ppU2p0b0JEUFZyVnlpV0p6MmNv?=
 =?utf-8?B?bDFIdzRIT0FuaTRFZTZDejByVVFrQ0lQNUd1eSs2cjJSYkVkOEJqYk1XY2pW?=
 =?utf-8?B?QmVuQi9FQlVtZC9aUCs1bHNhQkw5dmZZWkRoTXhrWVV6YzhBUWM1TFJpNmhE?=
 =?utf-8?B?Qm9lbXFOamR0dUlUazVkT0dEWVdpWVhTRXJJaTNaYWdYVDJpUnR4T0pRUlhH?=
 =?utf-8?B?QmJqeTA3cFRGbW4zaFk3VTQyUktTdXEvcml4cEVyTWZoWkh4V3orUE0zMGNq?=
 =?utf-8?B?VnZIYUhRRnJoQ0dSdERya2ZsaUtoMFQ5clAvRTJseWxaWE54RU5Ia1grcjla?=
 =?utf-8?B?Vm1GYkFxUW13aGg1N3V5c0F1MXBLL2w4cHdxR1IzUmRYZ3BUN2JLcEVOU2xY?=
 =?utf-8?B?MmdJd2hGMGk5RXJPU3p0Z2xKcFhNSVNBMVZnd0YwajArK09PR2d3dkpmbE5y?=
 =?utf-8?B?SWZ2cmtEMDNKN29sMjVqK003cFQ5azBJVHk0UTd5WmxhaHNNNGJ3MzQybjdh?=
 =?utf-8?B?VGhGT25xYmc1QVVDOU9SeVcrOTNjZkcxQ1ZzUDNqaWFzK2lhMUMxbk9uTW1a?=
 =?utf-8?B?K2dVdHlVMkJ6eGZaSkRVZkYzeDJHZ0NLcnc5cXZvRzJqYTZJYkg0YTF0WjM0?=
 =?utf-8?Q?LsIQNpqQN10aEI4BwUDnX2ZxpDD4pNvMX31xgXGGyvZ8M?=
x-ms-exchange-antispam-messagedata-1: bd6z4YAGhrbL+oOs2gY7eSR210fGDWEDr1I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7181B43B5DB82A43B3C349D70E05C600@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	XlHjBVq3cJrejT9YIMGDdqH9UJ5xUTRoceHEwj8DZKfWLKEyZacQlTJRlWINOAT1EnJlThHAOamr/iWZsHY8YruIQnRx/hKmh+DsA43a0/sp5u/tl/eHB2yhpX9T4o3irasu8TzpDSIorO+cZEE8JPtxOWE84//YlJJgWk1APRFcrYWse1DKjXIMbh/PMefT9HR4JR+4LhhEDoEMRrUYCct9b2VzpXM9X5R6K/j7zDMpROUzL1oF4OOPRE+GSbxXls6TI0u2350TMOmE9R87W3HZXqWMqKKPBc89sisM3mi1xlV7NwayZCZkLaUd2WcVXc01FkSKeJnQaseHj4Q3Iw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8667.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e0140db2-96aa-41d2-0236-08dedb6a037b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 14:22:30.4468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HCuUCIbjEza4Fm1dTD0mqKC5dxr8GEPNMfEmYunXOPKNpz/2NAtqycH7OSFVch+3z9LVWVj1vkY9cDMjeyglfR8mwHnpLxEYtpxVrM4x614=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5442
X-Authority-Analysis: v=2.4 cv=Fos1OWrq c=1 sm=1 tr=0 ts=6a4bba2f cx=c_pps
 a=Ia3yFmEgMALB7L705kXDeg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=VwQbUJbxAAAA:8
 a=7gw_yVoXuIN3Wcr2kYAA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: -c80Vl2LU8npf_swb0-Jyb2PXTVN8RY9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0NiBTYWx0ZWRfX6bkxjY73/Qic
 J7Wtveiv7o61ZhsN0kENahjDvUFbV3RdOyS/Oz2hGclKz3Rh+SuL1oTm1BdiiTB+zcfAw3IEpjT
 etjJPIkAhuT0h4ITrvG0Jyg6dK18Ad6u2tlc0nYMSKWhecOhlqn3DXKe3AGMKAcEFOM29DJpUbJ
 nHWvZTEr83T4wMSztvaabsFu9d5geM/rnwhUOYnW5MndTeBw6YwQg5plT0u98W9I0THGSqngqCA
 fZLH9iKyCyyhvXHnYEE3wnlP4Tsi+rGcze2JAFv6T6eqbeI9kI2NwOAx02mGu5WGLXVi/ko22XF
 4UtN39EBILQ9EbuOsivlnZmmet+j21hy/uiOWXyCNH9sdtF7moQPQqbUMUe5vbJJ0fPypcIuaqq
 L0rBbBEQOyhdB4zAu+BWOl7p+McirEX5UM7mGlUI4olXPUg6DxxZn3vJsDDep7qahkl3637FfyB
 KWdc+dGIfDnHIsViDTg==
X-Proofpoint-GUID: -c80Vl2LU8npf_swb0-Jyb2PXTVN8RY9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0NiBTYWx0ZWRfXx/pB4W6uaW6G
 EF1Cwasuh56I7tE8TIBz1cbD9Z2Ppc40msDD4a57Jgb5uO5TANtoag1YM7iXuaAQlWhwpkGfw5t
 5H7sBEU0tgKKZH2EiEDooEG7JQ9yOYg=

T24gV2VkLCAyMDI2LTA0LTIyIGF0IDAxOjU3ICswODAwLCBJY2Vub3d5IFpoZW5nIHdyb3RlOg0K
SGkgSWNlbm93eSwNCj4gVGhlIGRybSBncHV2bSBjb2RlIGRvZXNuJ3QgcHJvdGVjdCBmaW5kIG9w
ZXJhdGlvbiBhZ2FpbnN0IG1hcCBvcGVyYXRpb24sDQo+IGFuZCB0aGUgZHJpdmVyIG5lZWRzIHRv
IGVuc3VyZSBhIG1hcCBvcGVyYXRpb24gc2hvdWxkbid0IGhhcHBlbiB3aGVuIGENCj4gZmluZCBv
cGVyYXRpb24gaXMgaW4gcHJvZ3Jlc3MuDQo+IA0KPiBBcyBhbGwgb2NjdXJlbmNlcyBvZiBkcm1f
Z3B1dmFfZmluZCooKSBpcyBhbHJlYWR5IGd1YXJkZWQgYnkNCj4gdm1fY3R4LT5sb2NrLCBtYWtl
IHB2cl92bV9tYXAoKSB0byBhY3F1aXJlIHRoaXMgbG9jayB0byBwcmV2ZW50DQo+IGRpc3R1cmJp
bmcgYW55IGZpbmQgb3BlcmF0aW9uLg0KPiANCj4gVGhpcyBmaXhlcyBvY2Nhc2lvbmFsIE5VTEwg
ZGVmZXJlbmNlIGluIGRybV9ncHV2YV9maW5kKigpLg0KPiANCj4gQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcNCj4gRml4ZXM6IDRiYzczNmY4OTBjZSAoImRybS9pbWFnaW5hdGlvbjogdm06IG1h
a2UgdXNlIG9mIEdQVVZNJ3MgZHJtX2V4ZWMgaGVscGVyIikNCj4gU2lnbmVkLW9mZi1ieTogSWNl
bm93eSBaaGVuZyA8emhlbmd4aW5nZGFAaXNjYXMuYWMuY24+DQo+IC0tLQ0KPiBDaGFuZ2VzIGlu
IHYyOg0KPiAtIEZpeGVkIHdyb25nIGNvbW1pdCBwcmVmaXguDQo+IA0KPiAgZHJpdmVycy9ncHUv
ZHJtL2ltYWdpbmF0aW9uL3B2cl92bS5jIHwgMyArKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRp
b24vcHZyX3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3ZtLmMNCj4gaW5k
ZXggZTFlYzYwZjM0YjZlNi4uZWVhODhlN2FkMDNjMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2ltYWdpbmF0aW9uL3B2cl92bS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFn
aW5hdGlvbi9wdnJfdm0uYw0KPiBAQCAtNzQ3LDYgKzc0Nyw3IEBAIHB2cl92bV9tYXAoc3RydWN0
IHB2cl92bV9jb250ZXh0ICp2bV9jdHgsIHN0cnVjdCBwdnJfZ2VtX29iamVjdCAqcHZyX29iaiwN
Cj4gIA0KPiAgCXB2cl9nZW1fb2JqZWN0X2dldChwdnJfb2JqKTsNCj4gIA0KPiArCW11dGV4X2xv
Y2soJnZtX2N0eC0+bG9jayk7DQo+ICAJZXJyID0gZHJtX2dwdXZtX2V4ZWNfbG9jaygmdm1fZXhl
Yyk7DQo+ICAJaWYgKGVycikNCj4gIAkJZ290byBlcnJfY2xlYW51cDsNCj4gQEAgLTc1NCw5ICs3
NTUsMTEgQEAgcHZyX3ZtX21hcChzdHJ1Y3QgcHZyX3ZtX2NvbnRleHQgKnZtX2N0eCwgc3RydWN0
IHB2cl9nZW1fb2JqZWN0ICpwdnJfb2JqLA0KPiAgCWVyciA9IHB2cl92bV9iaW5kX29wX2V4ZWMo
JmJpbmRfb3ApOw0KPiAgDQo+ICAJZHJtX2dwdXZtX2V4ZWNfdW5sb2NrKCZ2bV9leGVjKTsNCj4g
KwltdXRleF91bmxvY2soJnZtX2N0eC0+bG9jayk7DQpDYW4geW91IGRyb3AgZXh0cmEgbXV0ZXhf
dW5sb2NrKCkgZnJvbSBoZXJlPw0KPiAgDQo+ICBlcnJfY2xlYW51cDoNCj4gIAlwdnJfdm1fYmlu
ZF9vcF9maW5pKCZiaW5kX29wKTsNCj4gKwltdXRleF91bmxvY2soJnZtX2N0eC0+bG9jayk7DQpB
bmQgbW92ZSB0aGlzIHVubG9jayBjYWxsIGJlZm9yZSBwdnJfdm1fYmluZF9vcF9maW5pKCkgY2Fs
bC4NCg0KVGhhbmtzLA0KQnJhamVzaA0KPiAgDQo+ICAJcmV0dXJuIGVycjsNCj4gIH0NCg0K
