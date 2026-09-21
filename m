Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7579F4E06C5;
	Mon, 21 Sep 2026 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.180.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009859; cv=fail; b=MpYiZnA/9Ot3niD3tzRF3foH2Eo5EeVaWlzviWv8HkP4DN1b3uvtSWvFfaMOh3qGzJd4PAE1IlPSThMoj0ytiy54dZu2V8hVvlkbhY84CSwVRpRyysxZUWNJqZgR3Od9l34sYsl3+uCRfewF3XwGnABXm2nSMBjv+qe9wrHgO7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009859; c=relaxed/simple;
	bh=MfopGBm5QUUEI+qOLArvcBEKnmyi+yRDNzZ0Gypk2i8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=enCSo5EVYwGATTIoHE4ehKYLyPgGfUDMBOMXVkQqTobU3qVnE/0VQ5Z1goaM8tp93TQduIqfQOp7cRvUcNOmw5+x/LZlummbjStL4Vu/wN9UTP8Q0mAapYqPJEooa3wCFg1O27SkvJiYkGGCARA9X6xatE7uNHn2YdmsoAixRlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=Nubr7BqD; dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b=BUEhcfiu; arc=fail smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="Nubr7BqD";
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="BUEhcfiu"
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LGP93E1696953;
	Mon, 21 Sep 2026 17:57:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	dk201812; bh=MfopGBm5QUUEI+qOLArvcBEKnmyi+yRDNzZ0Gypk2i8=; b=Nub
	r7BqD8aFUMaqdhFGPi3bl4ola62i0ZvZQ/C2ATAKUjtoAV9bvaV4lZ4AUUUVl4bO
	79X2pqF/jM9gqW4TIJ22o99l18fwPvYocglctZMXNNVyjOSmOZttLYZiqUl7OT8X
	y4WRl3GPZv2Dd9q/0HiVhMgkJxbZUqa5C3+6WK8BeuNW+w/CYTI+11JNAfI6dtC2
	ZaFXNKun0Mr+jPHAdT8uGm09DsUtuw3iD8Kg/9ItL1A+Cn/GXvrmRzZE0C8CIaWQ
	zppU5onpEe9t1pE7WuJ8mmlMnaP9PFhTK9TpVeV7i51SHbbdEvktgVi38+H7o5ld
	chlsavXRzNcRl3/LPIA==
Received: from cwxp265cu008.outbound.protection.outlook.com (mail-ukwestazon11020077.outbound.protection.outlook.com [52.101.195.77])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gsjfthw32-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 17:57:07 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjDwgaRsLiNRZPybpafFnqw+6ikrtv28TgB3pSfyKpe3yjx+impIIMw5fSjjXaVkLF/eSZi1eQ1vFqNfqCzoFjN6wTCnfw8hGhIjxhx8+FluPrtHdj9GlvzUuN6LfuDwtHM1Ifzv1kzh6/W2Hs+PfFp3tODixMQBHLriOEdhLkfCK5k7E/+mR21R+hOvsU38a+muxnYEfmB5NsU3oaTRFE4wWlVciGl3cC56bNTqpwyPu1oJFyjDjO7pPvFO+/AujqmnkesWdHemb3XLgNPIJIW6tdmYZnWd5WjSkcy3b0oEiu3MbTU3oP1GfT9B++MiZyUzogL8zdrmZTzb+4YH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfopGBm5QUUEI+qOLArvcBEKnmyi+yRDNzZ0Gypk2i8=;
 b=tD6iz/a+uLD8QsaFcpeZFwydHKaZSQzfzU9v+efLQWm3WDyojCusxcEfiIOchkOlRMDPkWjahlaEyBqd1vkCd+ceN4/79e0XFK3p+2jnzUp+19TyyfJNdrNpRnrolLDlhVSl/6zfR18nHotwImL/Pf71Ft4XcstMY9Guv6CsYxoaY5FTpwRrIZnYVWHESUyofrvWZLZLr6IxuK7CMvX6yi0xExWsSLr+doApXBTHaLhBFhCf7N/BpCgZhQboiceAheCiRQAJKmZpy/iJANnknReNIZb+N96SlBolLwUBbni73q4lZT4I1qwWCfv38qWfpxinLhg0ePro1f9RGmn+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfopGBm5QUUEI+qOLArvcBEKnmyi+yRDNzZ0Gypk2i8=;
 b=BUEhcfiuP/kLyLzGiy0ycMONDJtCmIwjZZ636N+A2NoJzRYxZuU+BJeINKDpXCeBAajHMfYcKatI5a68Y8/mKNzIoXATlGmMO+G5bXgNk08hqtRVpyyPDzS69TD2xujRlCDSmsN2HW4IKiWKFDB/j5Lm4dwlohNzPnjEG+RePo0=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LOZP265MB8536.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 16:57:04 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 16:57:04 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>,
        "airlied@gmail.com"
	<airlied@gmail.com>,
        "imagination@lists.freedesktop.org"
	<imagination@lists.freedesktop.org>,
        "tzimmermann@suse.de"
	<tzimmermann@suse.de>,
        "simona@ffwll.ch" <simona@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Binns
	<Frank.Binns@imgtec.com>,
        "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
        "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH v3 2/2] drm/imagination: Fix page count for page table for
 map() interface
Thread-Topic: [PATCH v3 2/2] drm/imagination: Fix page count for page table
 for map() interface
Thread-Index: AQHdR1pJ7Ro0nWOi/kyKrdU5Q1Rb3LbZRb0A
Date: Mon, 21 Sep 2026 16:57:03 +0000
Message-ID: <36110382e4a492c285901c79a6c4f26c7cd9bd4c.camel@imgtec.com>
References: <20260918-mmu_fix-v3-0-7b3d73aef041@imgtec.com>
	 <20260918-mmu_fix-v3-2-7b3d73aef041@imgtec.com>
In-Reply-To: <20260918-mmu_fix-v3-2-7b3d73aef041@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LOZP265MB8536:EE_
x-ms-office365-filtering-correlation-id: e0d96ec1-d641-4a6f-9133-08df18015cbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|38070700021|9063799003|56012099006|4143699003|10067099003;
x-microsoft-antispam-message-info:
 6eWQTOptMZyZ7ThpPuiBt2Ej7uQjH7ci/x+vmI/sWocQVndkuVj5e1af6PnMYZTci2vWSpByRkcvNwudryWw+ueLJno8+so66tacDOvpc29+t14MD30nQT/ayzk+Cop51TC23SUVWmo4K0w+70VWi5QG8pUPCZmWIjB/dOppMgYFqIL1E1othuzockyfMOBZhShFpe2KFnacz8H8i1UbY6veW687ILwYtaj5QUhC+yQxtj40C1aE6xW6uTlN9FeU3PnaUjgVwTo/Oc0Pc7m1ZNOR4hchEtglpQnwY729uFKfaxySBOHXOpBZ2t1wEEvWFKt2ewvQJX+WPSJyrP1RNtX6aMd8m0ZdwclUR5s25lL+IBnPuUmXH4hOmN9psBdwnPePB9emcCJ2ToAaSWKOYLA1cYaJe1Sy9vVOHchHg2LYeZuSIBTuX9+3xlfmgCyJf9m9VNkPYr74zelb2qSFSSQ5Nw6h1R1jHqI7gluaQ4pCbW8PyHM/NHU3UnM7Aobf76+BU6LmdckJ2F6nDkXiEUEBZXZra+YhuDJu2kDU9ySaN8Ew0QUHFvq8TwFssycBgo3B3QPMJOa4eKTCIIGRzmJZ8Hj2AWP8zxxMMLtRpfycbsU1FtdIv9o2Y+Q2IDSGq+OKelU6CwytbC7eNLYd/e5h3Jt7nvfhxF9sN4nC84WsuLD5E2Wl3FNhRqrcgabVXQpo/t7hV8x11TAPMKOVZeb5ab0Qu5air9vD4+xvruk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(38070700021)(9063799003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WlhvVGYzMFk0blArWm5vM09FenJnaXFDWVRjdEJUaGt3NEsyQ2x6ZTFOQm5w?=
 =?utf-8?B?ZmVLK01hVjRDeTIvVDhDd1l3N3JsUmt2bmtqT3RqNHl3OE9uQ29tcUFEcUQz?=
 =?utf-8?B?cTVJM281R1RwRTYwTGcya09YWWVZYkx6TEsrYUNmZWY1Q3V3d0Q3bXZhNUs4?=
 =?utf-8?B?SWQvR0oyREpmTUpObFlVc2NFNGF6MlN0NmxnaWJVMHNyRndlenQvUDlZMGdy?=
 =?utf-8?B?WGdrNlJqUkpNNmM4OFRXZUhxZkorZmljRWN2UlZZQmkxdFFVQXEzRFFvRXgx?=
 =?utf-8?B?YXVRSk1rNDI1VzhZNW4xaFYxeHpYQXRGRUlWMlVkL2JjdTE3S3dJTVdtaTdo?=
 =?utf-8?B?QzZBamFSQmR3M2dPNm11UDVlOCtBTnZKKzBMVDRBWXUvengwTE9KaDRRWWxJ?=
 =?utf-8?B?Vk5nRTYvY1pSUUJza1I0NG16VUc2dHUwckRsZnZsemtjVFBqK1FCekRKMjZD?=
 =?utf-8?B?NGpIK3o4cTdSVU1RYjNLc2xkMm9GR3hsY20wcXphRGw1MERHcUZiSWxTOGdG?=
 =?utf-8?B?SEVtNEN2VUFDTEFuVnRoeVJUQWE2MmFPdThici8xc252TEYycXhveXppVGti?=
 =?utf-8?B?ZTAraVRNcTlqbStsdVBXc1JncmdaSXRSZXNyTjBreG11SXE0TUZtUytTcjhm?=
 =?utf-8?B?azU2TVlCT1VLTXJmc3l2SEZzQjF0Qm5JNGpVSGxBMEdNNUN4WUpPWFRtZUda?=
 =?utf-8?B?b1pjZ21rTnA1RjZGUmdmTndnUW1BN0JvL292Zko3ckNNWFkwbjkwU0x1T0My?=
 =?utf-8?B?Rmc1dXRzdjI5b05UY3h1NVBCTEVtQjl3ck9ETmZlL0RReEMyN05rZTBab2hZ?=
 =?utf-8?B?TEg5VWp2a1ZHeDhSRUJiUzVmeThSQlRobEtnaFVsYnlHUCtzSnU2bGM4L3Vu?=
 =?utf-8?B?QmRjUFZiRUVvMEFMSmFWcERFWE1HZ3BROGVZelJHM1pLM0ZZc2dvQkNPejlW?=
 =?utf-8?B?VnVKOVkveHdDaThoK2dUN3hwVDdQVnN3UkFJUm9jYjFBb0NyY3VxZDhCQmVM?=
 =?utf-8?B?VndOcnhsSmtZNElZNlpxOG9PSnJZUlFtaHRpMWZXUm14KzFXOEd2eUJlck5h?=
 =?utf-8?B?cldRT1E0eTBzU2tBek1SOC9tRWcvOCt4TlNGalFzVTFYZ2E4Q3Fha3ZsbjVS?=
 =?utf-8?B?ZXl3eUhIeU5QSjhzc0toNnpjSHZmak5iaEtaWE5jS04rbWtENG9aVEROVnRS?=
 =?utf-8?B?OEc0WlAvRjBkM3QrOUhEazJOMzN6Yll2eEVwUG9BRU5taE1uK1FGRHVEOWpo?=
 =?utf-8?B?ZVlpc2x2WTZZZ2lCZk5wM1ZwM1A2cEd4SXNRR3g5K0czZmdIbmtQcHZNMW5p?=
 =?utf-8?B?OVBxS0NRQVZ6dWtqbHhvYWdzclhoMEZQRm16WEY4NU5sQjBjY051cmlyRU80?=
 =?utf-8?B?RFhjSTUrRXZGUW9kSVhBWG1GR1VjamZ6b3FxY3diR1RrQ2w4RVZZZVd1SFJJ?=
 =?utf-8?B?SXA1cngxQjFBcXZFWGRmeXVsek9nSUsrUkVxOXJHSkpKOEJHek1qZkxwMk1r?=
 =?utf-8?B?azBSc1FJVkNaYXBPcFV5cW1QYWR6Y3FZcDU3L0hRd3JoNUR4UW5pR3dPbjVU?=
 =?utf-8?B?RFhMTmExcE1KVEN1enpaWVNLMjFYb3ZqcGZpanFvcmkyWnhzUkgxYTY0VXZL?=
 =?utf-8?B?Skl4cjk4TUxJNytMeGpUVmlXZFRLQ2pKNjlvZTZXS1pwVWFucTFzNnBUazVh?=
 =?utf-8?B?eVZQUlgvNEdjbDlWb2MwaHpyelBndHNlL0pIbjU4SDkyYWtDOVlJbWxRNTRP?=
 =?utf-8?B?NDJncnQwZ29sT1RWVjNLYVh4bHZ2ZllqWFRmQmNXMXB1QjNjRXlUOFp2MmJM?=
 =?utf-8?B?aUdUQXJlMCtRL1IxdklsY2RPMHhUR1dOdU5nelRsUGdEcDBURFdNL05scHVO?=
 =?utf-8?B?WVJsZWx5NkQ0Y2VNanh4M3M5SzBWMDhqNVhUK2hDSlpiczJrd3JodnNwUEYy?=
 =?utf-8?B?Q1lqcVdhZHprL25ybHBNeFgyb29XaE5VUU5pNXpaTUliaWpsSElEWWdtS1oy?=
 =?utf-8?B?V2lYeHg1aGJwRGhRVUxIYnQ1bjlidDhIZi8yaGhyVDFyTk9Gbm9UTWt2YmNm?=
 =?utf-8?B?cU1KeXMyOTlKSXR5aXhKeWJUNGlwUVdaSUNreURURndLNmNQTG0wclhBejVG?=
 =?utf-8?B?cjJtWmkxLzJVaVFaY1ZnaWUyWWFQWWE3dmE3U1dTTGdoOWplZmNzMlluT2Fm?=
 =?utf-8?B?dzBZR2h2T0RlMnpsU3BYRXM1T1Z5ZVlpaEsvY2lUUmtTTXB3d3ZQTnFjU1dm?=
 =?utf-8?B?TzFlRUgyUmxRTUZYeVNpbVlOYXR2aVlQK1pTQzdXQXJyWENMbUtOSHFOZjNR?=
 =?utf-8?B?dUlzaWRqRDhTYjh0eUFQZHhlSXlicmt3aTZMZnBnNVBZMzRiZzZyVXhiYjRY?=
 =?utf-8?Q?3UWkU94tnbncuHhg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C322C4D1EE631140B14883D0711B4032@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	oVQgBbWsivF2tCQZHiN8qxYyA7iYvjnlOwDnh6YQ/rjW1VUnT4t8FyEl0lQQEK5KH4HLeLpSs1xJ8qNUWoBh7Lq1fF5OAZWypNg3tPSIrRS1o7lZ8HfdXBUxJDD/U2JHceuSiE/6VjN75UApaC53cxkoj0NThPzl5btO3gcboPoKnvuDDJI+o/SNPoCvbpkvi+2MwuP7g8NIJAwszo+NUXsLgIja1xrG7L7XG8vTfA0uewY8Y7MqkqVKAdKcMxU+sNg+p6rcpZVCkt2792RP3M+dzxF+fAUvrV+f/VacVJLXFVL1lfXn3NMwum/SRw5DGrwDUswEf9BVRQ85HjyaGw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d96ec1-d641-4a6f-9133-08df18015cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 16:57:03.9351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OeM2kzzfDUtf99FlMa2Sl+k4zAMfQg6TAzbNUbJEl/Yr1bXEbQz5hToFHtd5KR/qkcxwDIOjUu/HHeW+bYCYaBxWrC/ewXO6JEKOybF0XTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOZP265MB8536
X-Authority-Analysis: v=2.4 cv=GPKdgeNK c=1 sm=1 tr=0 ts=6ab161e3 cx=c_pps
 a=xplXfkBxTarkcGwL3xP+rQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=TqixafNNIbL9eEGyzUkA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI0NyBTYWx0ZWRfX7gqRhoRtk8GP
 j8U86GGnUvszbGwBgXiAJfzPOwxyaL+qlXIZCVKg5Cgi3+jxK/f0UjTelJTrd+2fx7dXKnAer95
 qXp+7oOqsQBEL2Kf9xf8U0QRUI1m9TP0Szh6+5dG5FSmRYCy/q2tTtZJyxNRhZMaeJNT2CDfVBs
 BKeeXsTB1vwy8Yh6s3fqOvgz0HlYvdIXZvXXt1WcAmScimjTCNuLEVOmeSAl9MqnENrYziegWW4
 n0EiICC//ebe3LdAjL+lsiMPOINWVU/BDybo9j4n/ucG6P8ilMKYx8xf45GUURJZDnAPVrIlnwz
 nGIUe7gAqkqkF0/TF7m4vNM9wUaEzVUo5ojAh28R2loerVXXe0COM3ge1D/BIYsiJR1vxFfovNW
 v3J93K7wiM9LRiMteZX2GbbX6iEIN0V/AWkuInKznGaOShTojvQHJwbAviDUKGGbRaDD0J1IESD
 epM6/6gPoWREc4lcnrQ==
X-Proofpoint-ORIG-GUID: XZZ46RYhANwSHcart2PN_X0_3QFn1yy3
X-Proofpoint-GUID: XZZ46RYhANwSHcart2PN_X0_3QFn1yy3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI0NyBTYWx0ZWRfX22FlY37ZlOeT
 1iq2KuQoGDHSqXskfIgTS+n/KTtFs8O39gEN8k+hjyKk9+3z24I/xAHASbs/LJnggBIwN3RyNb+
 H1Ui4n36Sh4M7VzN7deGRd/UAkmrpxI=

SGkgQnJhamVzaCwNCg0KT24gRnJpLCAyMDI2LTA5LTE4IGF0IDE2OjExICswNTMwLCBCcmFqZXNo
IEd1cHRhIHdyb3RlOg0KPiBUaGUgR1BVIHZpcnR1YWwgc3RhcnQgYWRkcmVzcyB3YXNuJ3QgaW5j
bHVkZWQgaW4gdGhlIGNhbGN1bGF0aW9uIGZvciB0aGUNCj4gYW1vdW50IG9mIHBhZ2UgdGFibGVz
IHJlcXVpcmVkIGZvciBtYXBwaW5nIGEgQk8gb2JqZWN0IGluIG1hcCgpIGludGVyZmFjZS4NCj4g
SXQgcmVzdWx0ZWQgaW4gbWFwIGZhaWx1cmUgbGF0ZXIgZHVlIHRvIG5vdCBlbm91Z2ggcGFnZXMg
YXQgTDAvTDEgbGV2ZWwuDQo+IFVwZGF0ZSBwdnJfbW11X29wX2NvbnRleHRfY3JlYXRlKCkgaW50
ZXJmYWNlIHRvIHBhc3MgZGV2aWNlIGFkZHJlc3MgYXMgd2VsbA0KPiB0byBhbGxvdyBjb3JyZWN0
IGNhbGN1bGF0aW9uIGZvciBwYWdlIHRhYmxlIG1lbW9yeS4NCj4gDQo+IE1pc2NhbGN1bGF0aW9u
IG9mIHBhZ2UgdGFibGUgcGFnZXMgZm9yIG1hcHBpbmcgYSBCTyBzdGFydGluZyBhdCBhIGRldmlj
ZQ0KPiBhZGRyZXNzIDB4ODAwMWI0NTAwMCBvZiBzaXplIDB4OGNhMDAwOg0KPiAgICAgICAgICAg
ICAgICBvbGQgICAgICAgbmV3DQo+IEwwIGNvdW50ICAgICAgIDUgICAgICAgICAgNg0KPiBMMSBj
b3VudCAgICAgICAxICAgICAgICAgIDENCg0KU3VnZ2VzdGlvbiBmb3IgYSBzaW1wbGVyIGV4YW1w
bGUsIHRha2VuIGZyb20gdGhlICh3cm9uZykgZXhhbXBsZSBmcm9tIFNhc2hpa28NCmFuZCB0aGF0
IG1pZ2h0IGhlbHAgY2FsbSBpdCBkb3duOiBpZiBMMCB0YWJsZXMgY292ZXIgMk1CICgweDIwMDAw
MCksIHRoZSByYW5nZQ0KZGVmaW5lZCBieSBkZXZpY2UgYWRkcmVzcyAweDgwMDAxZmYwMDAgKGdl
bmVyYWwgaGVhcCBhdCAyTUIgLSA0S0IpIGFuZCBzaXplDQoweDIwMDAgKHR3byA0S0IgcGFnZXMp
IHJlcXVpcmVzIHR3byBMMCBwYWdlcyB0byBiZSBtYXBwZWQsIGJ1dCB3aXRob3V0IHRoZSBiYXNl
DQphZGRyZXNzIGEgcmFuZ2Ugb2YgMHgyMDAwIGNvbXB1dGVzIHRvIGEgc2luZ2xlIEwwIHBhZ2Ug
d2hpY2ggaXMgbm90IGVub3VnaC4NCg0KPiANCj4gRml4ZXM6IGZmNWY2NDNkZTBiZiAoImRybS9p
bWFnaW5hdGlvbjogQWRkIEdFTSBhbmQgVk0gcmVsYXRlZCBjb2RlIikNCj4gU2lnbmVkLW9mZi1i
eTogQnJhamVzaCBHdXB0YSA8YnJhamVzaC5ndXB0YUBpbWd0ZWMuY29tPg0KPiANCg0Kbml0OiBU
cmFpbGVycyBzaG91bGQgYmUgYSBzaW5nbGUgYmxvY2sgd2l0aG91dCBlbXB0eSBsaW5lcyBhbmQg
eW91ciBzaWduZWQgb2ZmDQpsaW5lIHNob3VsZCBjb21lIGFmdGVyIGV2ZXJ5dGhpbmcgZWxzZS4N
Cg0KVGhhbmtzLA0KQWxlc3Npbw0KDQo+IFJldmlld2VkLWJ5OiBBbGV4YW5kcnUgRGFkdSA8YWxl
eGFuZHJ1LmRhZHVAaW1ndGVjLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFsZXNzaW8gQmVsbGUgPGFs
ZXNzaW8uYmVsbGVAaW1ndGVjLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2lu
YXRpb24vcHZyX21tdS5jIHwgMTQgKysrKysrKystLS0tLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9p
bWFnaW5hdGlvbi9wdnJfbW11LmggfCAgMiArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0
aW9uL3B2cl92bS5jICB8ICA0ICsrLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9u
cygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
aW1hZ2luYXRpb24vcHZyX21tdS5jIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9t
bXUuYw0KPiBpbmRleCAyMzI2MWQ5YWQzZmQuLjYyZWFlN2ZjZDVhMiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vaW1hZ2luYXRpb24vcHZyX21tdS5jDQo+IEBAIC0yMzM2LDYgKzIzMzYsNyBAQCB2b2lk
IHB2cl9tbXVfb3BfY29udGV4dF9kZXN0cm95KHN0cnVjdCBwdnJfbW11X29wX2NvbnRleHQgKm9w
X2N0eCkNCj4gICAqIHB2cl9tbXVfb3BfY29udGV4dF9jcmVhdGUoKSAtIENyZWF0ZSBhbiBNTVUg
b3AgY29udGV4dC4NCj4gICAqIEBjdHg6IE1NVSBjb250ZXh0IGFzc29jaWF0ZWQgd2l0aCBvd25p
bmcgVk0gY29udGV4dC4NCj4gICAqIEBzZ3Q6IFNjYXR0ZXIgZ2F0aGVyIHRhYmxlIGNvbnRhaW5p
bmcgcGFnZXMgcGlubmVkIGZvciB1c2UgYnkgdGhpcyBjb250ZXh0Lg0KPiArICogQGRldmljZV9h
ZGRyOiBWaXJ0dWFsIGRldmljZSBhZGRyZXNzIGF0IHRoZSBzdGFydCBvZiB0aGUgcmVxdWVzdGVk
IG1hcHBpbmcuDQo+ICAgKiBAc2d0X29mZnNldDogU3RhcnQgb2Zmc2V0IG9mIHRoZSByZXF1ZXN0
ZWQgZGV2aWNlLXZpcnR1YWwgbWVtb3J5IG1hcHBpbmcuDQo+ICAgKiBAc2l6ZTogU2l6ZSBpbiBi
eXRlcyBvZiB0aGUgcmVxdWVzdGVkIGRldmljZS12aXJ0dWFsIG1lbW9yeSBtYXBwaW5nLiBGb3Ig
YW4NCj4gICAqIHVubWFwcGluZywgdGhpcyBzaG91bGQgYmUgemVybyBzbyB0aGF0IG5vIHBhZ2Ug
dGFibGVzIGFyZSBhbGxvY2F0ZWQuDQo+IEBAIC0yMzQ3LDggKzIzNDgsOSBAQCB2b2lkIHB2cl9t
bXVfb3BfY29udGV4dF9kZXN0cm95KHN0cnVjdCBwdnJfbW11X29wX2NvbnRleHQgKm9wX2N0eCkN
Cj4gICAqLw0KPiAgc3RydWN0IHB2cl9tbXVfb3BfY29udGV4dCAqDQo+ICBwdnJfbW11X29wX2Nv
bnRleHRfY3JlYXRlKHN0cnVjdCBwdnJfbW11X2NvbnRleHQgKmN0eCwgc3RydWN0IHNnX3RhYmxl
ICpzZ3QsDQo+IC0JCQkgIHU2NCBzZ3Rfb2Zmc2V0LCB1NjQgc2l6ZSkNCj4gKwkJCSAgdTY0IGRl
dmljZV9hZGRyLCB1NjQgc2d0X29mZnNldCwgdTY0IHNpemUpDQo+ICB7DQo+ICsJdTY0IHN0YXJ0
X2FkZHIgPSBkZXZpY2VfYWRkciArIHNndF9vZmZzZXQ7DQo+ICAJaW50IGVycjsNCj4gIA0KPiAg
CXN0cnVjdCBwdnJfbW11X29wX2NvbnRleHQgKm9wX2N0eCA9IGt6YWxsb2Nfb2JqKCpvcF9jdHgp
Ow0KPiBAQCAtMjM2NCwxNiArMjM2NiwxNiBAQCBwdnJfbW11X29wX2NvbnRleHRfY3JlYXRlKHN0
cnVjdCBwdnJfbW11X2NvbnRleHQgKmN0eCwgc3RydWN0IHNnX3RhYmxlICpzZ3QsDQo+ICAJaWYg
KHNpemUpIHsNCj4gIAkJLyoNCj4gIAkJICogVGhlIG51bWJlciBvZiBwYWdlIHRhYmxlIG9iamVj
dHMgd2UgbmVlZCB0byBwcmVhbGxvYyBpcw0KPiAtCQkgKiBpbmRpY2F0ZWQgYnkgdGhlIG1hcHBp
bmcgc2l6ZSwgc3RhcnQgb2Zmc2V0IGFuZCB0aGUgc2l6ZXMNCj4gKwkJICogaW5kaWNhdGVkIGJ5
IHRoZSBtYXBwaW5nIHNpemUsIHN0YXJ0IGFkZHJlc3MgYW5kIHRoZSBzaXplcw0KPiAgCQkgKiBv
ZiB0aGUgYXJlYXMgbWFwcGVkIHBlciBQVCBvciBQRC4gVGhlIHJhbmdlIGNhbGN1bGF0aW9uIGlz
DQo+ICAJCSAqIGlkZW50aWNhbCB0byB0aGF0IGZvciB0aGUgaW5kZXggaW50byBhIHRhYmxlIGZv
ciBhIGRldmljZQ0KPiAgCQkgKiBhZGRyZXNzLCBzbyB3ZSByZXVzZSB0aG9zZSBmdW5jdGlvbnMg
aGVyZS4NCj4gIAkJICovDQo+IC0JCWNvbnN0IHUzMiBsMV9zdGFydF9pZHggPSBwdnJfcGFnZV90
YWJsZV9sMl9pZHgoc2d0X29mZnNldCk7DQo+IC0JCWNvbnN0IHUzMiBsMV9lbmRfaWR4ID0gcHZy
X3BhZ2VfdGFibGVfbDJfaWR4KHNndF9vZmZzZXQgKyBzaXplKTsNCj4gKwkJY29uc3QgdTMyIGwx
X3N0YXJ0X2lkeCA9IHB2cl9wYWdlX3RhYmxlX2wyX2lkeChzdGFydF9hZGRyKTsNCj4gKwkJY29u
c3QgdTMyIGwxX2VuZF9pZHggPSBwdnJfcGFnZV90YWJsZV9sMl9pZHgoc3RhcnRfYWRkciArIHNp
emUpOw0KPiAgCQljb25zdCB1MzIgbDFfY291bnQgPSBsMV9lbmRfaWR4IC0gbDFfc3RhcnRfaWR4
ICsgMTsNCj4gLQkJY29uc3QgdTMyIGwwX3N0YXJ0X2lkeCA9IHB2cl9wYWdlX3RhYmxlX2wxX2lk
eChzZ3Rfb2Zmc2V0KTsNCj4gLQkJY29uc3QgdTMyIGwwX2VuZF9pZHggPSBwdnJfcGFnZV90YWJs
ZV9sMV9pZHgoc2d0X29mZnNldCArIHNpemUpOw0KPiArCQljb25zdCB1MzIgbDBfc3RhcnRfaWR4
ID0gcHZyX3BhZ2VfdGFibGVfbDFfaWR4KHN0YXJ0X2FkZHIpOw0KPiArCQljb25zdCB1MzIgbDBf
ZW5kX2lkeCA9IHB2cl9wYWdlX3RhYmxlX2wxX2lkeChzdGFydF9hZGRyICsgc2l6ZSk7DQo+ICAJ
CWNvbnN0IHUzMiBsMF9jb3VudCA9IGwwX2VuZF9pZHggLSBsMF9zdGFydF9pZHggKyAxOw0KPiAg
DQo+ICAJCS8qDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZy
X21tdS5oIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuaA0KPiBpbmRleCBh
OGVjZDQ2MDE2OGQuLjJjMDJkNjFiYTBhMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2ltYWdpbmF0aW9uL3B2cl9tbXUuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRp
b24vcHZyX21tdS5oDQo+IEBAIC05OSw3ICs5OSw3IEBAIGRtYV9hZGRyX3QgcHZyX21tdV9nZXRf
cm9vdF90YWJsZV9kbWFfYWRkcihzdHJ1Y3QgcHZyX21tdV9jb250ZXh0ICpjdHgpOw0KPiAgdm9p
ZCBwdnJfbW11X29wX2NvbnRleHRfZGVzdHJveShzdHJ1Y3QgcHZyX21tdV9vcF9jb250ZXh0ICpv
cF9jdHgpOw0KPiAgc3RydWN0IHB2cl9tbXVfb3BfY29udGV4dCAqDQo+ICBwdnJfbW11X29wX2Nv
bnRleHRfY3JlYXRlKHN0cnVjdCBwdnJfbW11X2NvbnRleHQgKmN0eCwNCj4gLQkJCSAgc3RydWN0
IHNnX3RhYmxlICpzZ3QsIHU2NCBzZ3Rfb2Zmc2V0LCB1NjQgc2l6ZSk7DQo+ICsJCQkgIHN0cnVj
dCBzZ190YWJsZSAqc2d0LCB1NjQgZGV2aWNlX2FkZHIsIHU2NCBzZ3Rfb2Zmc2V0LCB1NjQgc2l6
ZSk7DQo+ICANCj4gIGludCBwdnJfbW11X21hcChzdHJ1Y3QgcHZyX21tdV9vcF9jb250ZXh0ICpv
cF9jdHgsIHU2NCBzaXplLCB1NjQgZmxhZ3MsDQo+ICAJCXU2NCBkZXZpY2VfYWRkcik7DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3ZtLmMgYi9kcml2ZXJz
L2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3ZtLmMNCj4gaW5kZXggMzk2ZDM0OWZiNmNlLi44Njdh
NGE0NDk1OGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJf
dm0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3ZtLmMNCj4gQEAg
LTI3Niw3ICsyNzYsNyBAQCBwdnJfdm1fYmluZF9vcF9tYXBfaW5pdChzdHJ1Y3QgcHZyX3ZtX2Jp
bmRfb3AgKmJpbmRfb3AsDQo+ICAJCWdvdG8gZXJyX2JpbmRfb3BfZmluaTsNCj4gIA0KPiAgCWJp
bmRfb3AtPm1tdV9vcF9jdHggPQ0KPiAtCQlwdnJfbW11X29wX2NvbnRleHRfY3JlYXRlKHZtX2N0
eC0+bW11X2N0eCwgc2d0LCBvZmZzZXQsIHNpemUpOw0KPiArCQlwdnJfbW11X29wX2NvbnRleHRf
Y3JlYXRlKHZtX2N0eC0+bW11X2N0eCwgc2d0LCBkZXZpY2VfYWRkciwgb2Zmc2V0LCBzaXplKTsN
Cj4gIAllcnIgPSBQVFJfRVJSX09SX1pFUk8oYmluZF9vcC0+bW11X29wX2N0eCk7DQo+ICAJaWYg
KGVycikgew0KPiAgCQliaW5kX29wLT5tbXVfb3BfY3R4ID0gTlVMTDsNCj4gQEAgLTMxOCw3ICsz
MTgsNyBAQCBwdnJfdm1fYmluZF9vcF91bm1hcF9pbml0KHN0cnVjdCBwdnJfdm1fYmluZF9vcCAq
YmluZF9vcCwNCj4gIAl9DQo+ICANCj4gIAliaW5kX29wLT5tbXVfb3BfY3R4ID0NCj4gLQkJcHZy
X21tdV9vcF9jb250ZXh0X2NyZWF0ZSh2bV9jdHgtPm1tdV9jdHgsIE5VTEwsIDAsIDApOw0KPiAr
CQlwdnJfbW11X29wX2NvbnRleHRfY3JlYXRlKHZtX2N0eC0+bW11X2N0eCwgTlVMTCwgZGV2aWNl
X2FkZHIsIDAsIDApOw0KPiAgCWVyciA9IFBUUl9FUlJfT1JfWkVSTyhiaW5kX29wLT5tbXVfb3Bf
Y3R4KTsNCj4gIAlpZiAoZXJyKSB7DQo+ICAJCWJpbmRfb3AtPm1tdV9vcF9jdHggPSBOVUxMOw0K
PiANCg0K
