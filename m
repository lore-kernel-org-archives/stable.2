Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEB7412C1A;
	Wed, 16 Sep 2026 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789600054; cv=fail; b=OgnefLKk2P2oScspPYvknnzq7LJ8QhKtYzBdWrRTyeLTpawrZ5b+AG3K8MNyqpsfqkOVk0+VlbsvNGUOfNsd8LxrvzPs6PtzO9zvQKEoIAxh8t4JyRbtqorV/fRzxAf14TwcQD4RRz36SC3jetJHB4unDcUgO4nXfUTs44IxBZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789600054; c=relaxed/simple;
	bh=7rj9Au84kYqLHdJTcebVh/c43QCzXzvgzDc148XX9BQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NsHoUyEBX9R0OoM+EadTKqdjXtaS1GrYtiIge4TRiSFzISXzmDMNRigaG/hOrExc5ZLWHdG6Pl0QJl5pfEf8jXP6kbQk010/3nOYd29pXPh/dfL2encwS6rXFkxKXKREkKs0MuWhEG3BN5v3tNhBvlq3/evtddSx5q0OUW2U55M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=FHEJxMcZ; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="FHEJxMcZ"
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GL8wgI2045811;
	Wed, 16 Sep 2026 23:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=7r
	j9Au84kYqLHdJTcebVh/c43QCzXzvgzDc148XX9BQ=; b=FHEJxMcZRNDLYlMcVT
	D0AMW6x7XA1jJh1cX8py52+zwLvUWA2mYhzjbo8TJpQBXadEtUlok6Kc9uKOkH32
	Q75UGEN6paSampsnGX2xjLKxd62O2Ge2IV8ZJPlGt2uD7mh4N+d7vD8XEYj5X4Yv
	+TdDXCgaefalrl1CNXxMMv3tYcJ4YbxddwzsZJvK1m8FD8EseD2odrwh6iAh0RNv
	0xpFC0qHjTd4W6feBeG6l9cy31rrBHaAjo70McPuA3f3xhtgDL2hpCT76oJZ5q5x
	g8qobWT9F1q5OQqLWSTHJGLjP3YR5DH2vm6WLhh2g9upXtWLjKLAtDcGTgJLezdO
	mAxA==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4gqw7g6jd6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 23:07:16 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id DBBB214781;
	Wed, 16 Sep 2026 23:07:15 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 16 Sep 2026 11:06:48 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 16 Sep 2026 11:06:48 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 16 Sep 2026 11:06:48 -1200
Received: from DS2PR08CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 23:06:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9lSnTyiXnHpIG7B4btDds0AHGkPdP4dWk67yS02LYK3lb7VD1TRdams5lPyxEXhTjMN8qveFLrrUan2lyOedEiWJF+ZN7wAmQZoj8SuDBu1XGaPcTXJLQlj6fT7BssUMBSzcRbmlrR3JhI9EViJZQ1p/XuYEJ3HKfx/cvyh+0n8xGoh1fy+SlpvEAVJ+xgjPPS9fAsr/IzJz/36UkRC/Kv2UFTC+VAZPyikZD0P5iK4QhwXUaxdnbhyjViCiTG8U23dlvR0p7+qKr5b5fTYut4V4OhM8gYFtNTNlIut6OpirW8xhPXJ7VmOREvIef9H4sSB4gFBYydBeenHDf3LXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rj9Au84kYqLHdJTcebVh/c43QCzXzvgzDc148XX9BQ=;
 b=mLVh1zkQi9b2I3b9YM4a9VCgo7n7b4QDF5+3RvA4O+91PpTUUP/U+qe8Ni+JJ/Lfp/tGoeBJnRdwPXNshMx6cnRgJjtLaQ8PkVF0IAejwUhJDubGgNXEGqkFETF2UmdABwAW+FpeSSLGzyMf2fUhR7IvPJm+VQcvvmk/oF24/rerjibw/1LEQqUEgZhlMFYIhM1b5qwXHzHaWoeadnoc4sOvPsvxhh6WYdaZlV19lsB1Dkjtk4l12Ry+p7e6Y/Mv4OlFfWLjDZ5CA8fBOcJBjgdVBAgMEqmugYmVIhoXpE3jq2DRlk8lSbpTr7xrVKg9hg3Nqi0zntrQ4nocogKn+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by SA1PR84MB3932.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:806:3e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 23:06:38 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%5]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 23:06:38 +0000
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
Subject: Re: [PATCH 1/2] hwmon: (pmbus/tps53679) Select page 0 for single-page
 TPS53676
Thread-Topic: [PATCH 1/2] hwmon: (pmbus/tps53679) Select page 0 for
 single-page TPS53676
Thread-Index: AQHdRhaHbswEx7nqh0iFEPfe68X9ErbRvB2AgAAXtwA=
Date: Wed, 16 Sep 2026 23:06:38 +0000
Message-ID: <20260916230628.677441-1-sanman.pradhan@hpe.com>
References: <b155cdd8-54d5-49d9-b276-c24dde766dbe@roeck-us.net>
In-Reply-To: <b155cdd8-54d5-49d9-b276-c24dde766dbe@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|SA1PR84MB3932:EE_
x-ms-office365-filtering-correlation-id: bfa268f6-388e-4f92-7f64-08df144729a7
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|18002099003|22082099003|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info: fvp5dGZ5HAUgy8x6yEz7tP1FaG/UJbgSpSp008iDrCyjRFKB3lbHsOYb8N0j1R/SKIW0nh293ppdu8hkm7sLO/Qe0XXUifBmbjzYvFTqY7lHrvhNj8j9zV0b8mc7uEaU7h0vP/p49ANBkkO9eFkBOSLbatyJO5eKx1/VO9HIM/6k0r2/WeXjfODj1K1V7mml6G+Aode0Uhhy/r/jAstKbG8v5uihcVb7GZpsQpygbnyA8LmPc2r1E8LorjvnaEfpbaSfwhzQ7bnnAMYvO73mPUIf41whTaRNdfh/VwKTnjb94KBeyqtpZNdjbgrPlpQZK4tV8fVRk6BH/5PuERHxNIdcGb1N+67R1JvDuB3/DWE+3hTbt+oOwazrZY5S2YKrUQnsWmPLXpg12/86pKPFjQzLcMus5yXZk9C/+gHJse3fhyZeW0rjc5S/6Bm+Nh7zXd9jMq6YCAaY20eRk2fguvuiXID3cd4E75fUav/jpeeA4AHpAcqMl2WONhObqjikVZTaQDeuOKaYj5IryAua2d/fIgYVEaQ4cJm0Xhocf4qeIp1hXhfRleoez4U3tnmN8XCbVvsrwaqAdOEiyE32+p/7Kqj4nwzhTNs7eqsLuCS55ZlYtg07K5zOlUn7bi9z8Ma6wrcU5eDUp/aNVqzSfEOHN9ozKfYAfNRR7a59l3SHh82pWKzGmImJcM+KRSt3BVbSJmQ28TGC98eHaUZPge0FmGbq9bzN1rsyTdb7+AA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFB2Y0d4TnFzQm1xKzhEQnQ3VzAzNWptK3FWSkhTYTNlSndRSW5zM3V1MkJv?=
 =?utf-8?B?U00rR1RyYzZSdmxldk1QazFUS3llaWxDZ2hwVzBmQlRhcmVTMm94c3JpZlpu?=
 =?utf-8?B?YStMV2IweFZsL3ZhVzIxaENUcVRoNWFZTkR6TVBNcVAySnJBa29tN0N2Q2Ex?=
 =?utf-8?B?RlVkR0F1NVNJbXNveVpydzIwZXZsQU92azl6YUpYYTY5NC83cXpERU5sR2I0?=
 =?utf-8?B?Y29SYkUwRjY2ek1ieVo2a1l6OEc3TXVNa3IrMlBuS0dldzFpOTdTU1Ivd2ll?=
 =?utf-8?B?eUZBWGtndmU2MGtzRERMR3NkUFNvVkxaaFVLNU9jbTIzMzVCZkthWnJEK0U0?=
 =?utf-8?B?WXBuRUd5Q3ViWjB5K2NEbUZoSURMaXBSdHdFK3VyRG03Mi84WGtjMjV6d3ow?=
 =?utf-8?B?cTlkeXlrSkJuVCthblg1TzkydjQ0WGxwRzBTeklqek96RXlHVlpDMjNzcUFm?=
 =?utf-8?B?QnE5cEgzM0cxTjFEUm5ncXFzWW05MW1PbzRkWjNjOXdITFJUVFpYbmg1UEg5?=
 =?utf-8?B?ZCs1em4yNkVaMm5hTyt3VHVpNTVZTHhyblRnSDNtTGgzRTVtWWpQL3Q3Umtt?=
 =?utf-8?B?dVdBYmFUb1hMZDUwSjd6eEVZL3BsQ0d2eTVGMkZ1b01tSGVXMHk5dHNYeEw2?=
 =?utf-8?B?Ujl1azhNYTA4azRBbHBlNHBKVzNsOWJ4MnhoNkxMWEdlNmpLTytsSk9ycGdj?=
 =?utf-8?B?VXljRlg2NFpRWnJ0ZTdIWmVPdE0vZ2tNK2xyQWFSbmo1OXRxcHVJVUJqYmdk?=
 =?utf-8?B?S3FVaVZCSVVNL1UwbXdWUmFnS084dzVkTk83NEdNWWN1dG5PcEpuMGRYblZj?=
 =?utf-8?B?OW1NeTY5ZTJoaHJ1ZFFNd0tOWE5NYzVQdjdhZkoxVUVSc3FwV1RBUjFtU1hP?=
 =?utf-8?B?VHpRaHhMNDRlSEhraTUyN09qeUhqKzVxY0ZXelZ0RC9Jb2xSYS9iVmROc2pL?=
 =?utf-8?B?U255YWZVZTZIbHVFcm0yZzEyZVlTOG0wT0FTbFpUUlNWOTZaME9Iemt5WWhI?=
 =?utf-8?B?RnJtNVBIZ1RQTjlkZjRQWFVhQWdwRDNYV2RrUmtGOWM1TnVYeDVRNEtIa2xJ?=
 =?utf-8?B?UU4yczVsZkJvWWdoK0NEUHdLc2xtQ0p1YlZjb2lXaGZuRVdGaEprVVJocVN3?=
 =?utf-8?B?bFZVVDNISDB6M0dGRjRmNHpGak1wK2xvZit5YlRrL21SUTd2M2F3a2sybkhl?=
 =?utf-8?B?MXFwMW1QaVQ0YkRuSzhxMjRzaFZObWhCb25ZUVZlczFzL2NTMFN1dkFDeHE2?=
 =?utf-8?B?dUdoM3pOalJ1RDRuWlBhTTdzUlcvSG5WZHJ0OWJqODI1NVBPbEdxTmpjL3hY?=
 =?utf-8?B?blVKZjdkc01xcndOMDNCODF0K2d0azdISDkvdmpSSEZ6TlZEZk5WRHZSZnBz?=
 =?utf-8?B?L3VSU3RrSGF0Q0xtZmE0em5yV1JLbTBUZE1BRVVOOWk1R0RRS3E2NFdvWStw?=
 =?utf-8?B?eW84WjBSci9RQWl6bmxRZG1ML29sQ3dqSEN6T001Tk8rNVBkMXZYcGJ6QkZC?=
 =?utf-8?B?c3RnSmc2VEY2S20vMjYrMnhrUGU0N3hUUXIyMzVOQi9KOVNHNDR6Um1jektl?=
 =?utf-8?B?WkFwMTJINEZSd1p2U0JjOUo5N2JuQmxHa1RVdTB5cTR2MGFCREQ4eGpWaGZh?=
 =?utf-8?B?cW1NODNpVjQwSERadERsTUxZMEh4eXhodjlRQWF2TkZITkRGUWs4Ymd3TGhS?=
 =?utf-8?B?cDlhdnJLYmxXbHBHUy9IT0U2V0VsUzZCaUZwQlVDL0VhckhFNFFSRlBLajRM?=
 =?utf-8?B?YVlIaThSMUFCZ2t6d2lIUVQzUGVtdi96cHEyTXVSRXo5M0l2K0h6UTE4dWhE?=
 =?utf-8?B?Ui9wMTROQmNqOGU2andhUEV3NWRjZzZ3Wmxlc0djYTd0Z0U0SHhveTdudGUv?=
 =?utf-8?B?TEZWcnd4T0JNS0JXSnhwYmp4bUNYdVhGMWo0OS9CVlJYU09Zeit5NjRwWFBN?=
 =?utf-8?B?MG94RDVpNkp6WXpvdzE4RHlSeHBXN2t2UHJzSFBObjUweE9nM1huMUxnS2J0?=
 =?utf-8?B?em5Hb3Q4TGE4WnB0VEVWbGRPSWRWVWpScW51N0sxSnVMcHYzVEJBMDhRTDBH?=
 =?utf-8?B?T05iNDd5R0w4WGtIUTRuM0cxVk1jTnhGR0djNS9OaE5hRW1sdDZlY3poVkRE?=
 =?utf-8?B?VERIcDhOMWtMZ2Q5Y0M5ZWRSemdyMGtaTEhQQnNvMG4zWldxU2lwQUlKanFn?=
 =?utf-8?B?aXcwL21FcmN1dlRtRFI4RWV4Zmx3VnZDQUdQOXBlTjAwZGRVRWtDbjZodVEv?=
 =?utf-8?B?bTJabmZFREhVeUsvTGptK08rNHZhUFBGNm1BU2IwbkJkUXJLU0Rwd1FHckk1?=
 =?utf-8?B?VjUvemtyK3lzcElUdjNtZDVvM1ZkS1dJVXJNdndaNzZTSHpSR2FCUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VkN0xtYRNzBRSKgiNxyyRaNH7GFJ6QyQo+dcxEZr8IoZWfvMY9ea7YjkHuGsklrR+RpZapbmmt42wES7coOqjYBOg5uy0vZQx6b8paLCeYoJwb3yjdomdujEQNI4p875h+eRyk/R0HXxNHWKFTtNTRHAQ7SMjIDV+p6PPyVnQwHjpdbo7HTkm99lzkYwC9euy3dmdS8aRN2Uhvk3p7v16PfZI+2owjlS/AEh55dQbJsYqKdIU0n3WlZJKosm9ZMCoJ5A886bi/MEDtmkfb7lwK2Ls0xlJFeZZNvGK42b5l21IwavJPUZEj3KTQZZIBRUoQXpRYFnxoPy/40rQXTSvQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa268f6-388e-4f92-7f64-08df144729a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 23:06:38.3794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D8vg28pR9zU4rRsdCE3zkNhHBBgq7cMRpMAC4KoQZxgzs4gWprFosA4A2rVGPmFCWuyjuLewXbUkh98EwJku/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR84MB3932
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 1_2OUpJxCB5BmMChktqK-5fmy8qTUa7d
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMyBTYWx0ZWRfX9cU4GaFGBCFr
 JuDrJWRFOAd9cHcJjNpYAw6k5KgAaVfjREyKhpzpon17Uvj2YKJ2D5khW+nzEYWuulmgyfEgui6
 WTf3kQDqAA5u4OH7bHfbGqofYgbzjb4=
X-Authority-Analysis: v=2.4 cv=RdUFmFtv c=1 sm=1 tr=0 ts=6aab2124 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=_ZmgHqWwjZUDpi_pur5s:22
 a=OUXY8nFuAAAA:8 a=c4gwNIlIdBMQgB6tUQAA:9 a=QEXdDO2ut3YA:10 a=q5mp2vxMLvQA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: 40TH8JgxKbL4XC8aOYq0hDR34sNV3yMN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMyBTYWx0ZWRfXxEzeFN+z8yWQ
 id26EFKYR1BaulpO3dFWTuHspTbzxxjHj+E0VuFogriA6+NTDSUmUEEvvQFfyj3fXY5K32FHOwm
 7mG5Mp9JBazuUW+e0dor6QLk7arUHJPEzq7IezL+5eGXToGtmUJOl558GHEncVaZTmZ4AaWFQgb
 npIL9xWnLgIfH1/AT+RccsIKONnAEcZACzyhNL31v0UuSxGzZqQncAygJFPi5w1OX8bpK/llr+m
 dilykTzBlzKq/oWRhf6AE0j0+7wW4E3AaaR2fqiXdj60MDEYzsQb+3Qg7X3KZmrYxlDLLYih4o3
 VI5pUGiS7IBnXp3ej29uS/s5v5DorGDZ8d7kiMTj3AUnAx6oMAfbPEK+SV18xdPEXWKaDKiljuw
 lOWbMhuGIrHEpnO1gOCTIOPpLIA1t19OtvEzv3ey5GOg6J9slC6xPOwsdx6vp7mvu4pn5/l5CKb
 WVYTKpdG8JGqzXQSvkA==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160323

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+CgpUaGFua3MgZm9yIHRo
ZSByZXZpZXcuCgpNeSB0aG91Z2h0IHdhcyB0aGF0IHJlYWQtYmFjayBzaG91bGQgYmUgdGhlcmUK
dG8gY2F0Y2ggYSB3cml0ZS1wcm90ZWN0ZWQgUEFHRSB3cml0ZS4KCllvdXIgYXBwcm9hY2ggbWFr
ZXMgc2Vuc2UsIEknbGwgZHJvcCB0aGUgcmVhZC1iYWNrCmFuZCBqdXN0IHdyaXRlIFBBR0UgMCBp
biB2Mi4KClRoYW5rIHlvdS4KClJlZ2FyZHMsClNhbm1hbiBQcmFkaGFuCg==
