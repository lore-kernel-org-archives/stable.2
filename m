Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA14231355B;
	Wed,  5 Aug 2026 04:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785904647; cv=fail; b=rNnAdSk3I0PUnaP5EetafEzgRPQ4ExK4cD4qOiLPqB5kP1lbbnLCnVtCANFdSO9HqfJDDhWYWREjOYIu0DjC25ppzI9gRnx1LvIIHvTkuhUUAqn3XHNU8KMpOsxM6BmNHYj2VhSCMxn2EcLQNHXMvS0z43ZCg+PMTptTcakCKYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785904647; c=relaxed/simple;
	bh=fJifSqLgEKTpZ4P/DFV1hKjwgmxV0/ZmTD3rzrPBhZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ttyIWIMh72QOc897EY2lUEulQ3UWv0g1rfCrFvj4zQbDqtkh5VFxNxW+Vsji1/EVTlnrP6B6dTxUK9A3fAbog4X8aUx7U6hj9MhveDewMMK89xRBRISi1bq6lq/JcAEUKE9hkTbveHon70rjEcn2I8nUv67MurMpbVCNO8QMzok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=W2GWqo0N; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="W2GWqo0N"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6752cTWM3238051;
	Tue, 4 Aug 2026 21:37:05 -0700
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022086.outbound.protection.outlook.com [40.107.209.86])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fukbu2duw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 21:37:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fALPNw1Iy1wTJiXxuMJR0SQ9946lhZN7ac7wSX8Z7vXOrnoawrMBD8Q4x0d6iwUf7UO0uqqT1hBRR7IAEGht0htpXFdoQlO4EhUB1WRjUSdF40L+lmVxJ+IJXGBbHIfzCwSvgB1vFO17gMLbAV9lHAChUVWVbsdloxQKO74wDwleCIeacVM7RXNqtxfsxqb+CqJmUofjE6jF8rf4Jip6nAaYeOXnVRSqC969B5wVIC/3Jbj7Nv1iBzAaPQ7Cj9EnWjML5xCzhOEUXkM/Bx+EYRxaDaqIqFhuseP2azDEWbwpxacYLKTBzdClVtePN0GWZ5Zm3lrLM8b4bCGOL4BRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJifSqLgEKTpZ4P/DFV1hKjwgmxV0/ZmTD3rzrPBhZk=;
 b=NJmBUnkm2jzjQTwHbkJ3VkPvi/5qOtUmDcDWtPBND82JdexKSoXeEEkuUt6bOHtJ44DxwZtd730RJymREXeKJWN0JAcGDaK1NakeTWdkILo2RQK621ZrikGNdy599AbPg4E+EtiOuYKxOrstyNFqKWDzsOv0hj0nrOMbiq9IhWg6k2FcIw2L4GVGD3AeXLx7GAcVb4G4+rEYoYxUVV3BJoZa/IP0r8uu/DHWMI9fHEKWe6rRifaRR7qKYMiAlVldiHKKgXqzMlMuS/u6zBf8PoGWrDGkHabH2dgPke3OsmdWn/21SKfgxO8xru/w27st0cW2tsGT9k1M7nIRDSdsxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJifSqLgEKTpZ4P/DFV1hKjwgmxV0/ZmTD3rzrPBhZk=;
 b=W2GWqo0NdTMiSPrkDYp9pFgnziTZQvVR5MudoyAdts+o8RrIaBy3UCAdcKEwre7ZAMJFbsucUNXF3eCaMhEGh33rJk9RbHn7wut8Es70KgDzvqaGqkh3Z5pcYrLo3Kzc4d9FMPDsApNwOuP32ojHkXkBfAUCfdCu2cTCDZTUArk=
Received: from CH3PR18MB6027.namprd18.prod.outlook.com (2603:10b6:610:1e4::7)
 by SJ0PR18MB4394.namprd18.prod.outlook.com (2603:10b6:a03:2e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 04:37:02 +0000
Received: from CH3PR18MB6027.namprd18.prod.outlook.com
 ([fe80::9f76:9304:624e:fb0f]) by CH3PR18MB6027.namprd18.prod.outlook.com
 ([fe80::9f76:9304:624e:fb0f%7]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 04:37:02 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: "Sergey.V.Frolov@kaspersky.com" <Sergey.V.Frolov@kaspersky.com>
CC: Geethasowjanya Akula <gakula@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Naveen
 Mamindlapalli <naveenm@marvell.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE:[PATCH net v2] net: octeontx2-pf: Fix UB in shift operation
Thread-Topic: [PATCH net v2] net: octeontx2-pf: Fix UB in shift operation
Thread-Index: AQHdJJQPjHJBYs6y806UeLR65UokHA==
Date: Wed, 5 Aug 2026 04:37:02 +0000
Message-ID:
 <CH3PR18MB6027EE89FA778B95B8194131C6D32@CH3PR18MB6027.namprd18.prod.outlook.com>
References: <20260804120446.1955448-1-Sergey.V.Frolov@kaspersky.com>
In-Reply-To: <20260804120446.1955448-1-Sergey.V.Frolov@kaspersky.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR18MB6027:EE_|SJ0PR18MB4394:EE_
x-ms-office365-filtering-correlation-id: 9bf8c5cd-30ad-41c0-74df-08def2ab31ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|23010399003|6133799003|56012099006|11063799006|22082099003|18002099003|10067099003|38070700021;
x-microsoft-antispam-message-info:
 2Rw5zAKSXmPJvS8BaYxq/bRcNAfllCzBJkEyszxE6KJJacW+Fejm7+QTh+qQIq98Rx0+xkCpcinsH5bMrmheFN8B58AepQc+qB/5KD7rlANnLRZHhmgmPoTxLZ2KoWOv+lkMNDoFDNqs25o+dx0lTT/GUlWV053YnDjJ4+iGeKHegjkb6Nj66T32um5H0iS7b2KdRzV0MbKXMNutNp6l5YSih6qnRbDXpk7Gl2ZYl8YhtHKMIjpfo96j05bi/6olsoSlDsHmwcmlrweaXvy46Wk60kS1K6qgags7N1NMRb784O6GZWKwz57Tq4jVLEPq5QCDgD+m3uv6oEPlVGEyPRMZctIRbI7ShXbmS7V0XWeKnBczE3DSvvcGd2RDiw6m5u4FTW/Hko4khYVGOSADZ8CP4mpuXDh6cXPnT4LOm54zuXnkzvU4YvGsHjNA+JBUTEggnh2OBsvHTjSpAQmvGVuRvF37a/RWcDxt+9JRKVP6AP6llLQRkI/lH/7Z1vm2luuCBOW07Gfo4TcixKJFZpupadWM/BHOY5GhkqzmQEVBrHeSQXpR+Ezl/1uOczgoKTr/E8pB/gR9+Vui9RC8ysAwBobymG3veoue+S8GpEUSiFJn2PSJf+3rZYbP1RK83FCp4R1MMECnOldosG9RR3aOGKpzHrF90SlbSiiYw+I+n4yYiZux1SVXS1U3hS14ncw16SyP6l0x20l8E9fV1SVQXMHNudUQFLpRwTqQ/2w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR18MB6027.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STJsdzAxd3QyV2lQM2Z3WHhCeDBxZmZxU0lwZm90ZkY2UTgxSjVvZkxXeEty?=
 =?utf-8?B?bDBmMEpla2xVaTI1dXA3ZEs1VzhRVDhnLzFXVjh2TW1ueGtBNE1yRWY5cDhL?=
 =?utf-8?B?enRBV0daa0FhQkVnVnBhWjVYZHlCWEJuUHZVNHVqazhBbHdhV0w5K1E4eGFR?=
 =?utf-8?B?MjJsUkNDRmV4bE5DYTVjUS9uNWZaOU5yRmZUMDRaTVlCa2VVakd3c0lGczFM?=
 =?utf-8?B?cjk5bWEzVXcxUWVGQmx6V2NocVpTTDJoeXAvSXNUNXNkT3VxcnZsUHQwRHBM?=
 =?utf-8?B?bDlnOGNKdGxzQ1ovNWhmTVcrb1Q1MmlrN1R6SlRCcjNCWHY3c0hPSzlzbnFS?=
 =?utf-8?B?MFVPdUVINXU4Ym1NK0lBYjQxSE1BSC9ndkFqdnR3bXpJZzI4alNES1ExOGZB?=
 =?utf-8?B?T05mN3hnTVRpN1lTYWt6SkszeGdQbDBxTitmS05HUUNVLzhvUXk5R3V0UnVY?=
 =?utf-8?B?dDdGWlpNbCtuRS80UWwyZ0xKbDc4V3dFb1BocU56VTl3T05oaDlERjhNUmhT?=
 =?utf-8?B?SFVsVmVJNy9EQ3BIQVUwRDBVM0E0NVZBQnI0YlRZQmtPWWFHTFF5RmhnWHB0?=
 =?utf-8?B?OVBndm9GM0dNalB3WVlSeTdvN1RkVUxKT09FcGhpNTFYejA4bytNQzA4QjFY?=
 =?utf-8?B?VjVrTzNQZFlrQ1VLcVJYN3hKUTdzYktlTmRKU0dRODRMNUhSSkdZQTg4VTlp?=
 =?utf-8?B?VXd2MENQa0Nyb2Z0ZUl5cHBxSTFLT2trVHJyaUJ3WlRhTGtHWWh0SzY1bEc2?=
 =?utf-8?B?TzByUm9DWnhhMmQ5Vk5WMTFyY0U3ZERwZ091YWRhdVJRMzNFV3g4ZHljMVdp?=
 =?utf-8?B?OFZvd0NNamU0V0JTYnhOb1JQd3NTc2M3SkJKWWFIbVU1ZGIzd1VuOS83RG02?=
 =?utf-8?B?NXJYY1pwQXBWZnFpNG5BbWJRRDdBK0J2YWtLa2xwUzJhT3JRY1dsUVd4T0dL?=
 =?utf-8?B?RmZneG5qU3p1Tlk1ZDk1aXRqS2gxWTVyQ0tVRVl2UHYvRjZVeHZ4azhyemNC?=
 =?utf-8?B?Um9ETXlxMjVDYWtlSmExMmRwRFBwbXp0OEVlZU5YUDN3bmJxMGFxYjdVYUkx?=
 =?utf-8?B?MWNyL2xURm1Nck9lemNmc3lFSTFVNWlqaDN0VEd4QUFSUzB1TDZ5SERSMVJI?=
 =?utf-8?B?Wm1BNjcxUEdUcVFLOGpUNEhweWdCZHg1QUpyU0dJT2J6QU4vNVNOc2diSldl?=
 =?utf-8?B?VXFIUHJRblVqa0VEci9QdVZNRGN5YmpYQTJXZG1IQ1ZqUXdZNDVpWDFoeFNL?=
 =?utf-8?B?SlZVT29TYlJOemthamM0RklHRFpWeXl2TkdNdlRQWHhkN3lvWlh1MGF5WkRT?=
 =?utf-8?B?TE11QzIzbVdPTWUzRE5WY1JXVHVBKzluRVNtWVhpZVNSb1NSWGVvV3JZMVZv?=
 =?utf-8?B?OXZEcVY0blZEMk03bzNPcWE4S0g3VnlmbUsxNXpFNVdmRnFqNi84WlpKTmdh?=
 =?utf-8?B?VEc0bzI2NFVsbW1laEdXc0lBZk5uWDNXWmJLaGU0anZLRzBJRjRUbXV3VlBS?=
 =?utf-8?B?NXh0ak96ajE3S1F2Mm5YN2dyaXVFd3NZckJxN29GeUszV09tbnNGaTJ2Mjdm?=
 =?utf-8?B?MHNrcGszcWJreVZwMU56V2VDTW5odi8vb0xCRkU4OHVNY0QyNktGSjJXQ3Iz?=
 =?utf-8?B?S3VSM0JrczB4MVlCNnJVVTFJOUZRbGs0NXlJUUljS1k1VitHeFhnY3k3NGUy?=
 =?utf-8?B?MGZnYVVLbHViYUxtMlBxMFFUZzNKWVF0b2tPNHVYTytnSU04MUNvQy9DN3Jj?=
 =?utf-8?B?Y1lvU2NDTmZ1STlRcEJTdVRTZVIrVENxL2hwOVNGU2ZRSm13dkhhdE1zbGZN?=
 =?utf-8?B?NE9kWk4wRlIzNURPaGp2SVl0b1gxdnhGQm13ZkxCZEphb0QwOUVqelRUQWJt?=
 =?utf-8?B?dTQrQTlIcmthbnFrNElhZndEV2JFMnE0S2J6MDJqVnpiRTNVdmtDbk9HcDNT?=
 =?utf-8?B?QmRWSFNnazZrNHZKZ285NGdhbXFSL3VmZ3c2RFRod0M5TGZDaVh4RVhRZ3Br?=
 =?utf-8?B?V2tramRhT1RZbkd2K1hKN1ptRXhQTkNENjc4UGpydDZZQTRtWXc3eGJLdzRw?=
 =?utf-8?B?S2FWR1RJdjljR3pHN0FDcVlEVnlxTjFYUjVzcm5CWVRkN3hZNVBtMlVkUXo1?=
 =?utf-8?B?cUdMY2FSdW9Ya0lrcGZ4cWVRRXFlUHNGaWpRRHNueWtzdlM4Mm9MVjdWdnpD?=
 =?utf-8?B?RFFuSllnTGRCLzA5eEV1ZGExY2RxVHRhRFFSK2t6aHFJNFh6SFRMT2FpWm5E?=
 =?utf-8?B?VnBRczhpNkVmSHVsMGZKNDN2RXBCQ3FVdEY0c0Vtc0c1eU9Fb0hGTWQ1Mnh5?=
 =?utf-8?Q?4eV8tml/2yjLoMvMwy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	o5E7JtqjlJwZShYGocliZsZDWTuLTcxCr3YBMaYGCtMXZSVnm9+2yADtlQSAutodFmpFA5+Wlp7+mDHQvLire+9MXpDPQ8llBrazzSNO+Xe3nnrS35vmkl6HRhRVT5O22NmeSsLS9cXMCMnmaSMC6OUPMjQ3LSqTzkXPfTiSeinZKwZiucJMD/NOZKU2KDeDsm+LGZUjSdWdc3lw8IxllUcqMWvh7hU308Eofx/bcg6M/i63oZIdfGwiHBVvPzaursqSSM3geCGCW1pXMm4pelVX+PHBwcmEBKKcISTpv11XjysD8Y642YYKln3urIJjCBVl4qfb/gEAcKXBoWHzzw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR18MB6027.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf8c5cd-30ad-41c0-74df-08def2ab31ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 04:37:02.3856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Wuc07RL9sp5ZVEn0dfqWU7AaHjj0wG+2mXEW6K5zDTdvblAaANc/XeYliQp3r82yiHKxCgoSUpCelT4ATQb8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4394
X-Proofpoint-GUID: VKM4spNaC3NWkxvlNuzUzeXtRPDKeP31
X-Authority-Analysis: v=2.4 cv=AbKB2XXG c=1 sm=1 tr=0 ts=6a72bdf1 cx=c_pps
 a=P2PW7aKoITpMSqf9AZp3uw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=ACEZY41XAAAA:8
 a=HH5vDtPzAAAA:8 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=qC55iCGO2BuqdzBSWJMA:9
 a=QEXdDO2ut3YA:10 a=QM_-zKB-Ew0MsOlNKMB5:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDAzMiBTYWx0ZWRfX/gVlXf4/QNAq
 Cw+1KbjCWxyslCpfR1plke9wA3RaS+T4jd56seHryH0uYB7jHTcrAMGh6Osu9AmnxHVv9B5YdvE
 fQN3X4Bjv0Zw4338UTh0mbvF6ej315jAG8sAEa9VLoq8BFSwDZ74qS5OpTZ0Xp4T43k4k+cyNX2
 7mFFoWA4z32weqs0UQvQXYSGNox+KBJdOTg/Stv2u1qkZzyDCcJSFwJ0nTlx9oTq/TAeyYt0T4V
 vYqthC3hFAlSTjUnKc7PuMl3sZyLy/1UWY8TbWHWTuvAkCEb6q4fbIMqWwlbO+y+suPWxEkXIr+
 yTDH1URHKTyaJMYoy1YfiShLS1rK4hpPn9sK361zWtFw8fSzeERA0xs5HTdInKXZtNVZgomqTBf
 tIqGeVTiYZv6krLTE70BG+Csp9fTRFzT5XFEX5sSO9a7eIAvVxhL4AtBXg5Bd6TqD+UZ2uGIyaR
 mk/OVBqQpqRcLzTqDKA==
X-Proofpoint-ORIG-GUID: VKM4spNaC3NWkxvlNuzUzeXtRPDKeP31
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDAzMiBTYWx0ZWRfX8Cgq1fnrrnfo
 94X38LbUhNhzVfODjggLmZP10LV8Rz0JHqAsUoJbJF1YhD+CJrm+78VvfJfMkJuoIrA1s3iAJV+
 pFqCPEtkCvE8s0FI6cEckG9BB0Yo/0I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_01,2026-08-04_02,2025-10-01_01

PkZyb206ICJTZXJnZXkgVi4gRnJvbG92IiA8U2VyZ2V5LlYuRnJvbG92QGthc3BlcnNreS5jb20+
DQo+DQo+SW4gZnVuY3Rpb24gb3R4Ml9nZXRfZWdyZXNzX2J1cnN0X2NmZywgd2hlbiB0aGUgcGFy
YW1ldGVyIGBidXJzdGAgaXMNCj4yNTUgYW5kIHRoZSBtYXggbWFudGlzc2EgaXMgMjU1ICgweEZG
VUxMKSwgYGJ1cnN0X2V4cGAgaXMgc2V0IHRvDQo+YGlsb2cyKDI1NSkgLSAxYCwgd2hpY2ggZXF1
YWxzIDYuDQo+DQo+VGhpcyByZXN1bHRzIGluIGFuIHVuc2lnbmVkIHdyYXAtYXJvdW5kIHdoZW4g
Y2FsY3VsYXRpbmcgYCgxVUxMIDw8ICgqYnVyc3RfZXhwIC0NCj43KSlgLCBzaW5jZSBgKmJ1cnN0
X2V4cCAtIDdgIGJlY29tZXMgLTEsIHdoaWNoIG1ha2VzIHRoZSBzaGlmdCBvcGVyYW5kIDB4RkZG
RkZGRkYuDQo+VGhpcyB2YWx1ZSBpcyBncmVhdGVyIHRoYW4gdGhlIHdpZHRoIG9mIHRoZSBsZWZ0
IG9wZXJhbmQuDQo+DQo+QWNjb3JkaW5nIHRvIHN0YW5kYXJkIDYuNS43IHAuMzoNCj4iVGhlIHR5
cGUgb2YgdGhlIHJlc3VsdCBpcyB0aGF0IG9mIHRoZSBwcm9tb3RlZCBsZWZ0IG9wZXJhbmQuDQo+
SWYgdGhlIHZhbHVlIG9mIHRoZSByaWdodCBvcGVyYW5kIGlzIG5lZ2F0aXZlIG9yIGlzIGdyZWF0
ZXIgdGhhbiBvciBlcXVhbCB0byB0aGUgd2lkdGgNCj5vZiB0aGUgcHJvbW90ZWQgbGVmdCBvcGVy
YW5kLCB0aGUgYmVoYXZpb3IgaXMgdW5kZWZpbmVkLiINCj4NCj5GaXggdGhlIG9mZi1ieS1vbmUg
Ym91bmRhcnkgY29uZGl0aW9uLg0KPg0KPkFkZCBhIFdBUk5fT04oKmJ1cnN0X2V4cCA8IDcpIGJl
Zm9yZSB0aGUgZWxzZSBicmFuY2ggYXMgYW4gZXhwbGljaXQgc2FmZWd1YXJkLg0KPlRoaXMgZW5z
dXJlcyB0aGF0IGlmIG1heF9tYW50aXNzYSBldmVyIGNoYW5nZXMgaW4gYSB3YXkgdGhhdCByZWlu
dHJvZHVjZXMgdGhpcw0KPmNvbmRpdGlvbiwgaXQgd2lsbCBiZSBpbW1lZGlhdGVseSBjYXVnaHQg
YXQgcnVudGltZSByYXRoZXIgdGhhbiBzaWxlbnRseSB0cmlnZ2VyaW5nIFVCLg0KPg0KPkZvdW5k
IGJ5IExpbnV4IFZlcmlmaWNhdGlvbiBDZW50ZXIgKGxpbnV4dGVzdGluZy5vcmcpIHdpdGggU1ZB
Q0UuDQo+DQo+Rml4ZXM6IGU2MzhhODNmMTY3ZSAoIm9jdGVvbnR4Mi1wZjogVENfTUFUQ0hBTEwg
ZWdyZXNzIHJhdGVsaW1pdGluZyBvZmZsb2FkIikNCj5TaWduZWQtb2ZmLWJ5OiBTZXJnZXkgVi4g
RnJvbG92IDxTZXJnZXkuVi5Gcm9sb3ZAa2FzcGVyc2t5LmNvbT4NCj5DYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZw0KPi0tLQ0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4
Mi9uaWMvb3R4Ml90Yy5jIHwgNiArKysrLS0NCj4gMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdGMuYw0KPmIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdGMuYw0KPmluZGV4IDQwMTYyYjA4MDE0ZC4u
NjUyMjc2Y2IzMTRjIDEwMDY0NA0KPi0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwv
b2N0ZW9udHgyL25pYy9vdHgyX3RjLmMNCj4rKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2
ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml90Yy5jDQo+QEAgLTUzLDEwICs1MywxMiBAQCBzdGF0aWMg
dm9pZCBvdHgyX2dldF9lZ3Jlc3NfYnVyc3RfY2ZnKHN0cnVjdCBvdHgyX25pYyAqbmljLA0KPnUz
MiBidXJzdCwNCj4gCWlmIChidXJzdCkgew0KPiAJCSpidXJzdF9leHAgPSBpbG9nMihidXJzdCkg
PyBpbG9nMihidXJzdCkgLSAxIDogMDsNCj4gCQl0bXAgPSBidXJzdCAtIHJvdW5kZG93bl9wb3df
b2ZfdHdvKGJ1cnN0KTsNCj4tCQlpZiAoYnVyc3QgPCBtYXhfbWFudGlzc2EpDQo+KwkJaWYgKGJ1
cnN0IDw9IG1heF9tYW50aXNzYSkgew0KPiAJCQkqYnVyc3RfbWFudGlzc2EgPSB0bXAgKiAyOw0K
Pi0JCWVsc2UNCj4rCQl9IGVsc2Ugew0KPisJCQlXQVJOX09OKCpidXJzdF9leHAgPCA3KTsNCj4g
CQkJKmJ1cnN0X21hbnRpc3NhID0gdG1wIC8gKDFVTEwgPDwgKCpidXJzdF9leHAgLSA3KSk7DQo+
KwkJfQ0KPiAJfSBlbHNlIHsNCj4gCQkqYnVyc3RfZXhwID0gTUFYX0JVUlNUX0VYUE9ORU5UOw0K
PiAJCSpidXJzdF9tYW50aXNzYSA9IG1heF9tYW50aXNzYTsNCj4tLQ0KPjIuMzQuMQ0KDQoNClRo
YW5rcyBmb3IgdGhlIHBhdGNoLg0KDQpSZXZpZXdlZC1ieTogU3VuaWwgR291dGhhbSA8c2dvdXRo
YW1AbWFydmVsbC5jb20+IA0K
