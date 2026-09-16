Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E123C345C;
	Wed, 16 Sep 2026 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580837; cv=fail; b=PuEwd5n81kGsKIH6gn2PjipC5cZhv9jk8iUap6eQ6CK/x8TPaSQP/BuGMgxeuNpl7a9kFxB4sdr/p9SdGMm2g71FYWT84Y13tCkHrKXnJMjzl9FbofI23t4RkcrnFfBlI8yYXiVX7C2V0dm4ojV4IY1Nnx1QbTFw4NBd2onBwJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580837; c=relaxed/simple;
	bh=iEWzy24/muQwPXERS6ZtRuP9G9/UM58sHP01KznZ4rE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j+uGWjnQGy9/KQeuvDWAMHJkrU8luDAFholMm06sZJZlLigC2sk/O9m09e0i8JPuw/CUspDRZ+tbF9OsSdjjfS8rYK9XIqYWKU/0qHzspiX7SEYUAjUjV9e2OW9PygIM/ZICFbwGdSReqwCDQGBzacWl0xnPp2fa3jdQNgYbrbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=naMmQGec; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="naMmQGec"
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG2P4E2309574;
	Wed, 16 Sep 2026 17:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=iE
	Wzy24/muQwPXERS6ZtRuP9G9/UM58sHP01KznZ4rE=; b=naMmQGecBqm5XTOkX+
	U1TEaNKu5rVZYmrTb1azgEmB0uXO9XycLQ5lk2hzCFuT7smyEz3WJ2Ir0+s/wQsf
	dlUff3v1Oopj+aEARmx0bzsQe06LJMUF38FuAnbRWBS5P1GoqTdSvCWj7m1GDrd5
	sj05/cs8dMjcCoBII9PUYzU+1Nmh93bIgJMRblbWJoOYj2ah80G92l15UASrU6Yk
	2AafymuQ36tw6o5caNgfjl7R/o5YX4yjk/DG8Zey8+j3RAzFIPRmsUzAntLlFBsv
	BrMXr23/FGSm2qc3MQUN/cxh4EmWARNxsE0x3Uv+NXj7zvwyB7xexLw+0jYmisco
	O+oQ==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4gqx9j9d85-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 17:46:29 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id E633612EB9;
	Wed, 16 Sep 2026 17:46:28 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 16 Sep 2026 05:46:28 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 16 Sep 2026 05:46:28 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 16 Sep 2026 05:46:28 -1200
Received: from BL0PR07CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 05:46:27 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEjERwyiOCh+DgnvdOmEcpjJftA1bM6EK+hLLA/1yKj6bYatZqW3y4D/I7Y7cwAM47VluWAC0knlXvAw4m/pY1+GYI6LUClQfeNjnsEtjtYg2Cz4G6HgdMLZAn9u3XwdO0GTD3n+lN1AMyipnosCOwllT4JXuqrIbe8W6uMxIpAB+Yf2CV59N7Bu0r7uOeBKifdrfmEzTxKzEpOzgq1auKTdixlt6rB5O1hT/Gr7e+peFc/uAPylLTrMxHrLAokFS/PKbaWWyUKihKqoWxqe50kf348sBpfiXla3Zjd5PEsxZ8CP0YB8GXN0l56upiI2YV2XHgMqysPUJrJ3E+Mx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEWzy24/muQwPXERS6ZtRuP9G9/UM58sHP01KznZ4rE=;
 b=o5ggAjBwUFlKKv0Gezm729W5Uij3NSWfgNJn4lFIuUGy/4EZGmVpnIr7LH5FMux5K9oS4V5bdGkJFK6hzxbm+Zpsczp+38uyckj2OD3o4kIBeH96NUuKrNE4NUQzdIyIRncRkxgqfXZ0qew9x0OcH59luv/qCF7mDGye9yYM6H7qEDEdT3QJlLPYKeEvMzqx8R/1tDbOQB99mcleUBlxnq66Huk7v7+1BR15WkCc2KmRk51ENoL9hM1tT2u+tIa5Sf0JON8zr8Soqgi9GgWE9LWWYdLKRW1grkJ4v9gaEtncU6gCUky7oBr/aMCUsOmv/8nFqoybBUBYV1ixGio0jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by MW5PR84MB2107.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Wed, 16 Sep
 2026 17:46:20 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%5]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 17:46:20 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Sanman Pradhan <psanman@juniper.net>
Subject: Re: [PATCH v2 1/3] hwmon: (pmbus/tps53679) Fix TPS53676 phase page
 decoding
Thread-Topic: [PATCH v2 1/3] hwmon: (pmbus/tps53679) Fix TPS53676 phase page
 decoding
Thread-Index: AQHdRTIMBtc9dKXtJ0KuZ/216AGGBrbRTLKAgAAvWwA=
Date: Wed, 16 Sep 2026 17:46:19 +0000
Message-ID: <20260916174553.643587-1-sanman.pradhan@hpe.com>
References: <c0a3c877-eeab-4cff-ab2a-bb567f0dc3d1@roeck-us.net>
In-Reply-To: <c0a3c877-eeab-4cff-ab2a-bb567f0dc3d1@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|MW5PR84MB2107:EE_
x-ms-office365-filtering-correlation-id: 1c6b418c-2013-4ab1-bb24-08df141a6a9c
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|56012099006|38070700021|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: WyS5mY7bLzQSedAVM8mwUH4dixDCBl7eknfHNMYopuSOqgh1s+l92EZqLFC4Duuzy79QcsScDhG1Ytph8cioDqnyVc/8wAOZzblnpLCkJLvsglELK5R5+vlsJ116n/r96YbIEpad3HX+1OpvY/ABv/Bl8kFefSXX1/35MLVParEu98g1qdj2TS55WN1XiZinbHA8yKUikQDXlo6MDFcYb//HMk47LRzpDoa9yBiu7lbhRJZPlif5cLx8rGRnNRwcvaSMofc6ATB4lvYmQ83v2iI4raev3LYOBOaJqAKd07DaD57tEotWSNbsKeKfgl9LwNEUU3PpVaW3kHxvyP6JI4tOU4sfdOD0JX8f7nkgilsZo/9WjM5qWWcp9PcKADmJ610nfSKVcOyJy0jeED7mtYnaq3p1KE5/lqV8QYZcKCn4cojVJmyEM0QevlVw0/jZ0ITH/d4x1oMDMOiT3vCocgs5YxRPs18e8lQ5eG/Ai6Ok2Rl6Eimu74vRlOWULH6w2iwH8vZgEcuOgNj7lJfrEr3gf1//ypKl7RaxprcdNjlnVlSSHM0O6XZKGKrEH/z164Ud0r/bp2BrJmevDq0sXwfSp2CLyjxe4SJ1pjvW3sldEiGLSHL1TGf7mFigH9VjkN2lh1gRXE3Dwb9sr9zc/YPXlKnJCfAJFqI+K8fQrVG4Kg85XEs/23vNDYczm6gj6iVeLMKpPVNAUBeXQFebQ9VcrYtVT9xGWpYbKr9iAnE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(56012099006)(38070700021)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1MrbnNQd2gvMm1pSlRQa0xoRkNoN0V2ZEJEbG11d2tQcStrekFLeUVZdllp?=
 =?utf-8?B?K0d5c1pSakI4THp5cDhNNENuRTBZaEgwYWZ5emdTTXFoUjFJaFdCamVVVlZD?=
 =?utf-8?B?Qmw0b052UG5IdEdXSUphZGpVY1ZQVXJNRGlYR2tSVEFpSVlOb0VyOVBxUlZD?=
 =?utf-8?B?ajJ2L1pOck1lMnQ1OFRmRTh4WEgxbDk4b3hkQmNzblZKRk84alNrWEVXaHNv?=
 =?utf-8?B?TjFCRFcwZ3NuSG1Cd0JST2hMZEFWSUxOMWFnQTFJL2RYZXdCbFU5YUlDM2VB?=
 =?utf-8?B?eEFZMmtzaXMrNzhTMHpYdVc3bDVVMXNpU0JsK1FoT2dBTnduVVpWd1FRbG5G?=
 =?utf-8?B?SWJlTlVvTmxEbGdweFltQVI0aDg1ZExiYUU1K1VFWkMvRm9oSFlGTWJJOURY?=
 =?utf-8?B?aDR2R3VYY3VSNkJwcFphRWtTajdlaHBiaDVOZzJZcDFJSGJCZW9SK0lEQi9T?=
 =?utf-8?B?SVVQYTJUMnhNWktscFpVbW5tN1ZwS0xMVlpNRm41d1ZhOWNpWTRzbENCcTg3?=
 =?utf-8?B?aFYvTU1FRnZ5Q3dqYmx0L2kzamdORmVxZmt5clBTY1FFZkJLVDM5QXdxV1FG?=
 =?utf-8?B?eFBEZitVT1FpME1xQ2IwUDFSZ3lVUVhMYlFPcjRTUko4T2FBR0VLMHVCSys2?=
 =?utf-8?B?VXRjaC95eGhEZkppdTliSldwYXljbkFWNG1scEd1Z2ZMQWFpcDE3Nyt5d3U1?=
 =?utf-8?B?UkNad0Zwck9hNmU2eUlEWi80UTRZVXM2dVNwR0VTQ1dmYW0rR2RjRXZEMEsx?=
 =?utf-8?B?VkJEd3NGaDgxN0Q2QVVvanFVbENPQklieG4yb0ZET0Vsdm1wYU1SM3BwcEhG?=
 =?utf-8?B?cFFvVG9Sdzl5Q3pnZFJJelFhaUhmODlzVWlQUmdXNS9ScStnZFZ2QXRCeGVj?=
 =?utf-8?B?M01aZGhaUEszSHlHTnVBL2htdUNoQkE1dmpZWXI4Sml0SUlKenVtT0pZcUxl?=
 =?utf-8?B?LzRUUkg5a0tLcHBuY0tFbWVnQmV5a0ZITTNVU0E3WE1rU2RZRFNGWjVYcG5t?=
 =?utf-8?B?M1kwSnlwcS9vNEpIQ2c1c1FLUWNiejZVbW5nblNKZmJPTzlIcGdFRXVFSWFK?=
 =?utf-8?B?bXFpMnZXQUdZRHVsZlFJcFFzWWpKUEFkU2lQZzlEYTV1enIyamtxS29mdlcy?=
 =?utf-8?B?SXR4YWtxVHRVaHlON1VzZGJvd0d2R2xCWmdDVUlqNW1wSWJMNkEwZFF1bWQ2?=
 =?utf-8?B?eWhuQlNwdXV1SzVnOGYvUDZLdmk5SERDdnM4aDhIK0Evc1BxUnJ5UGFEeEhF?=
 =?utf-8?B?VUZnYlJNMGlCZmlnQy9mVER6ZjI4eXlhdDNGR09aUzdPNUtEaEpPOHpyam1R?=
 =?utf-8?B?a1hnVWVFYnpIMDAvQXhsdngzU1NGaUxNRVFCWUNSZ1pxZjBjQ1VETjNUVVdt?=
 =?utf-8?B?emdLcVJaMGw5bFVxYXp3SWtIaFg5RFhlTFNVdnphbjRwQ3NQYUdOYkZ3cHBk?=
 =?utf-8?B?c1A4TTV1ZkdBdEZIYTRrQmtOeHozbUNxa2dZV2ZiZjRRV2dsNnN2dWJMVXVX?=
 =?utf-8?B?cXpMZXAreEdQbmczdHZIZENXemlBa091Yml0M3BnTjRhcFdTbThLY0d3K1Ix?=
 =?utf-8?B?elAzUFFRd0xNV1JyMTM0enM4aW1zbU1TZTRLTXJTWVdtNWc0T0dDT1l4VDVo?=
 =?utf-8?B?UW96KzRRY1pRbWszbzZuUS81c21idnFMK2REc3FuMUZGYkg3bTJRYlFXdnpz?=
 =?utf-8?B?ZDl4cC9FT3pkUVh6RlNzbkhaYU5FVXRtZlpBME8xd0FSVmZpRXRxWlJCazk0?=
 =?utf-8?B?UTRBSU1hdHpNUXROaE1lbDlpbzc2STdqVzFrQzdYWW5INlExK3gxbWJnNWlq?=
 =?utf-8?B?MGNYa2MvRUF5cEdtTHNMZjZ0a3haS0lnM3M2Yk1ROHAwUUtSNW9UazFYaXFX?=
 =?utf-8?B?Znd3WmdBeE9pK1hPYnhTWmpMN1hma3k5VlVhM1ExNkV1S001T1VCTDBUeVpO?=
 =?utf-8?B?QkhKTkRneURXNnlqdHk3M29PZVRoazdYeldySHJZcDlaZFN3amZOM0dENk4v?=
 =?utf-8?B?NkFHYUR1djBWWi9FWkxYbnFIVEVSZzRiRXdva2J0aHFvenNhYWJEQkJxUzlF?=
 =?utf-8?B?SWJHS1lVZG4xWW1JZFdlRFQwUVNNdCt5OHlaTE4yOWlReGNZUk5JYjREYnFk?=
 =?utf-8?B?c1lHdXpCRmorWDRqTVdZdW9FcmtzbXBpQVZSVWlXR3FWMWdlTWJvNHpscThv?=
 =?utf-8?B?TERBKzFNUThYOVpMVFI3RDhMeXJNVUIxbzhaTWt6M0ZadHZaRy93MFMyOXlx?=
 =?utf-8?B?WWdDZ1BRVVp2aW5XNkhmUUxoQTd3SzhyL0tkaHltQzBTK2FhUGU3RlZKMUxY?=
 =?utf-8?B?MjVOS3JiMjNqdnlENzZoYlNpd2VNbUZ0NVpwMU1reDR3Y0pkYlU1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UpuLrduLjoOUunRvskORWhXAhFFvieLiB/cC6GSYpYpHck0MTfNEar9xcY+41PIDsS4sagKsr3gK6ALPFAwpJu2ysHCeJ+E1N+gJO+gc1vV+sxwQKiVTn6joqnPbPX9E8dW71n1QvnqtSGHmR13+bri6BmzRkDSL1bCy0WyMjWF/BxdwOmBEmmSfXHzNbSDCoUf2C34RJegqawe0Hf2s4/ms5ANUDhWaOuZmh/Pf0B4d2YZLoIygl8QnPBPU8Enqq4CX5FVRHpu6JX+jXzir/nwJZcuIP+jw65mxGLBf1ndEvKxqu08/ogFT+i+XdBTgDxmwAMmJKI04eJzApqb4cQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6b418c-2013-4ab1-bb24-08df141a6a9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 17:46:19.9818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQc082zH/yO1gXj0haVlE5BQJ95KNjWx1fEWn31YSkF46qofQ0n2vqWfchydxtut/3htKxd3R8FoqaE4IeKHqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB2107
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI0NCBTYWx0ZWRfX2SWs7m3kG2py
 ZIkeUDb7oZfPiZGOUuAl0toOS2ou3ddIDy/JGG/oRsT3JbO+f9eDraFaBWnAVdd6+VWHeAY775t
 QyeksxDSpz1iyvHgJ4KCVP9HkuEd0X8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI0NCBTYWx0ZWRfXw94wzBb/n449
 21BLLh+bWwPMEiJSMeb/AcTzj4YZWZ7RqQj9Bj+LuYSygGfNEBIJc2LXVjL91YGQFmfLONwydqa
 YvfbNJ9btXg0i//nlcKYrL3meum87qPrGj/LwchXDs0Stgfn4RBXyUTUUB+LgV0VgDNeeRzc5J3
 epdBWc0G6tgoxOMEopoSwaYrLwjaRN82OntQ1G53SJJsZUwX6xZghF38npItg0D7s27uNf/ynR6
 5cZvoPDijer8S+5/JWqTbAW+IEtePip1uNxnTzdt8pezuJ0qNGVlKiToh5MqdQlNX1pMQj5XKyp
 9WL/imG5C8bIvZXpFe7dPOJ7Zr3AGaF2rrTRnFx31qpaAHWOJ40tfAFJIwU76VsPOdhMOmMK8dB
 eVLwDGHE/Z+DJ7lYBApD7kE1PkgfCa8uZM5hRz6kqYtPfE+JC4mMKRTCwDzprtkjsNP5p6XAKcS
 ddCHS6al5UwYqyrCEwQ==
X-Proofpoint-GUID: BAaxRBvseAlNKBjA_tOr1WWD1Dr6LcD9
X-Proofpoint-ORIG-GUID: tOFYWW1-yZrrs7JV13gNeOvkd-_Pmni1
X-Authority-Analysis: v=2.4 cv=C+N8WgP+ c=1 sm=1 tr=0 ts=6aaad5f5 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=J0OTuHAx6l5K1fCpvPfz:22
 a=OUXY8nFuAAAA:8 a=ShcDvvPr6miOGOihsvwA:9 a=QEXdDO2ut3YA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160244

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+CgpUaGFuayB5b3UgZm9y
IHJldmlld2luZyBhbmQgYXBwbHlpbmcgdGhlIHBhdGNoZXMuCgpJIHRoaW5rIHRwczUzNmM3X2lk
ZW50aWZ5KCkgaGFzIHRoZSBzYW1lIHNpbmdsZS1wYWdlIFBBR0UKaXNzdWUgeW91IHBvaW50ZWQg
b3V0IGZvciB0cHM1MzY3Ni4KCkkgYWxyZWFkeSBoYXZlIGEgQzcgcGF0Y2ggdGhhdCBzZWxlY3Rz
IHBhZ2UgMCBmb3Igc2luZ2xlLXBhZ2UgcGFydHMuIEkKY2FuIHNlbmQgaXQgb24gdG9wIG9mIHlv
dXIgdHBzNTM2NzYgZml4IHNvIHRoZSB0d28gc3RheSBjb25zaXN0ZW50LCBvcgpmb2xkIGl0IGlu
dG8gdGhhdCBmaXggaWYgeW91IHByZWZlci4KClRoYW5rIHlvdS4KClJlZ2FyZHMsClNhbm1hbiBQ
cmFkaGFuCg==
