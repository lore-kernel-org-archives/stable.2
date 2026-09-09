Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022089.outbound.protection.outlook.com [40.107.200.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCAB3A9611;
	Wed,  9 Sep 2026 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979368; cv=fail; b=bhwE05h30jz1tXJ62UaMRM8jgZtZtZgjwMrpAXJ1CIanrwBf1N+MtPaSjRWM/Q1v9JphfjCyo9JT9phiCWLKB4ftTrTv+UP4a4I8gJSbyoogL6RMNz1blSgPya/VbEGSXCyfQ3q087lYM3RyiFQ7CnEf7S7rJkxA9dG9CDgXvzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979368; c=relaxed/simple;
	bh=4IVpSV8qhLKCMkUMJqv9yp7Z8ydT2jEqiC7hyxwjeJE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BTeXu6JGKIGfR6T1BaU3cPh8nHWhCo+3P9zADer4sqAOTKS1mFhU+TeI1PZuNEM4FEHG/ol5xU2Iq+pF+mT6QGulv/9r/uX7dSfUvMEpZN+jyCYsJchXIsNDT11eP3K39UWpZ97anEBc6OZJ9pMlzoU9iuAclz3xmJl5NrRVzS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=bJvSuD25; arc=fail smtp.client-ip=40.107.200.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bJvSuD25"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVLvA9tRBUOTJdOuH7cF5WTySkwpk4On/XF3ZI+PNLr/oI7JxhR2MwMGY7HkGi4LlUOqISU9bhd2XOTsw4+AdT+lckxjdFSpzL+W1FFpAFXhr5qOdOS4mrUkCSTkAjlM/9eunfxJe32eBSBT7Mn3mnzV6RGX/6NjYfSdkcJUP6y0NeP3kkA/AW+3fP/L7cV6CVrpgmGy58nPnbDyHhHSTEk8thOtAxHEOzkLFzLV2Yvw50tBtzv3KEOGrzgZ1tLNGt2RuYmTtz/oOHKRRajDIPMp8pT+ZobOrck70EdrKhvnYEn8dl6y4P8LHCQV+H7Xq8+F6jDcGi6j5w4UP74jIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IVpSV8qhLKCMkUMJqv9yp7Z8ydT2jEqiC7hyxwjeJE=;
 b=E1766I2L8q4w8cg7Iachtzah29cGQMSitqyN+A2lENJT+ZjO6AWMb2wKSfbUNE0rnbYh9OSSTd7cMYsob+4YTv7pBZkqJcLUX6n0yamKC+9Hr9QryTrYE15PymO+OmeoQRJlCoDIKBgxXZ85MMKPJQ6W11m0a5ONALD/mlFXYj7Njlbp4CmkiLYMDynrRWWHZOWJOQw1k67/jCZmsJLtOSfom72rTZXRrA5Z+TA+lo1ZedPn/DZ+XZ/hdz9vRw4YKb98A+kkX/sDjtYhxFdeD/ZQvqdtez/HeMSfPaiGboVCSQPskcnLMc0Rd/YTCJkSjZtlyQo8dqr1zk6Bkei/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IVpSV8qhLKCMkUMJqv9yp7Z8ydT2jEqiC7hyxwjeJE=;
 b=bJvSuD25hUQBfN8lyVlQROFXhsnbOrimKDVbKYebrPjrxBvlTx4y2xipXbWe1X0MmtI2yZpsVtiypSwVnnOe6Ppd80qChjfyhLm38VCD80Hq7z4HWuOw+q/03uRnF0ssCJKwevLNeyIOU0cRrGSBi7YUFlpllgYKijkQJaOY8U0=
Received: from DS4PR21MB5419.namprd21.prod.outlook.com (2603:10b6:8:2ab::17)
 by DS4PR21MB5296.namprd21.prod.outlook.com (2603:10b6:8:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.0; Wed, 9 Sep 2026
 18:42:43 +0000
Received: from DS4PR21MB5419.namprd21.prod.outlook.com
 ([fe80::213e:684c:c119:ded3]) by DS4PR21MB5419.namprd21.prod.outlook.com
 ([fe80::213e:684c:c119:ded3%7]) with mapi id 15.21.0428.004; Wed, 9 Sep 2026
 18:42:43 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "yunhong.jiang@linux.intel.com"
	<yunhong.jiang@linux.intel.com>, "ricardo.neri-calderon@linux.intel.com"
	<ricardo.neri-calderon@linux.intel.com>, "rahul.tanwar@linux.intel.com"
	<rahul.tanwar@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] x86/init: Initialize wall clock in get_rtc_noop()
Thread-Topic: [PATCH] x86/init: Initialize wall clock in get_rtc_noop()
Thread-Index: AQHdOSJVimovIGX+OEyUsVmDoaGEBLbGo2Ng
Date: Wed, 9 Sep 2026 18:42:43 +0000
Message-ID:
 <DS4PR21MB54193C373A52D57B1BD1AC8DBFB02@DS4PR21MB5419.namprd21.prod.outlook.com>
References: <20260831082528.1623843-1-namjain@linux.microsoft.com>
In-Reply-To: <20260831082528.1623843-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7f15ccd7-41be-41e3-ac98-5d33b8414353;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-09T18:41:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR21MB5419:EE_|DS4PR21MB5296:EE_
x-ms-office365-filtering-correlation-id: 0fb7e2fd-002a-49ff-51f0-08df0ea22260
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|38070700021|7146999003|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 XDK2UljbFV01qBWc3ocbJ3hK42fWYVkh8TeahD4ayNWiCuYxTBjcoD6DUw5Y2A5zlc5hVA+5WyPCc2YD19WHnDtdiHPXspzmSfaZmGP5KlZqocJoRICHeqyR053VkOKcB2f33f4IH71DrN52b++MO0d1wURIDFp26WyMQmZRdHdQSAN3YW9NGP5u6RLxJeJtzX+YxliqGEquEiSJhzms/L/EbISxiDS0/H819R7uMa++Qi0NG3Q4G+h7o12bwLuL+TCBJXuC958fCFua4lBnFYCeozZTEG+rbWRWR2O+V3MdGJuNzsn3Bdrs37v8yMf7+cxmsHbAMJ4akXBd3BzDyfbZxBWPwBZKP6cOquhbAlJjjNU6gfKpvrmFUAdr8vA2p64RqPVF4FhN+Z46FAYYbwDQELv6OhXh0tCTjpbvDWuao8AVDAoOhzD+dOUN7XEFOduwMRgMWwYjv9ssw0yK/uT4c8LxoSQwhCAJprZq4IZyjFMD6BV4li/n5I/IgnvL0zMFNdUcBuiqVKFe5QIdFf2OsvoKbZNwMflGa0/5AFRoChzhOEfS4sZFooAlmgdY/ko3G1fJ1DAD7yLpNWMJ9GbolYZdZrTw13AlYaSykbbGzR+/nJBNESYRbPJkEBeyZ8Q9dUnIYCmyU5p801LU+Q4vaPHYezkVaZjLt601S1KEffXEj1HgwHUwNfixbVCRfA4cMoGT1sbPiq4QxA/eF0xFfxi1L7XOf1onbl3Cn8A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR21MB5419.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(38070700021)(7146999003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?t4w3aAW3HIK9Rwm+IeGfmroKCHqLgNDk8dIfA9Ag3WWLDVP6aKVU7fGW8Xsl?=
 =?us-ascii?Q?cfThp9r+N7418oQ8wBotX/Zex5i2TX2ALKg09lkAr+3YbyvJIRmnV9F3CBHn?=
 =?us-ascii?Q?Fj3uplLsc7mMqlwaPhsc1p+UkK6bJgzqpx5iexX/sCPC3ATqeT0vpEisNvtB?=
 =?us-ascii?Q?9nvV8CnSdDLDZR6zVvzIAisCikn1nEGuZcqenjdKDzeKbldoHzBww8ha4ROl?=
 =?us-ascii?Q?O/VsIKsKnFIgsVZRz+1Q/ee5C7b+TkFvIKv4zm4vriTQM1QVQYDtJ/jMyVry?=
 =?us-ascii?Q?MjC1IHqRfPvIVF0xSdsY3B6/Nr+hJu7N5JaoqkbAIRIcGQUxptIfRoDtFhDp?=
 =?us-ascii?Q?w4w5rEXSW7HhiqjGW+7vGYd5lm90HtYKQkrKr7KhzRBWXnrLAKpiOqcKBbKe?=
 =?us-ascii?Q?9h9+JcQkuDMU62LJuC97Vvfthzr9cxn2GuEbNvGfXYWvTRa+mUAwfnruZwsR?=
 =?us-ascii?Q?ZY2GNF/ik5QTk7qvsorKEh9a6+Hgym39GZatGnMFIAUU79DZP7bHayWsE5pd?=
 =?us-ascii?Q?wjyCNKZ0f9yCyOyM/piyYsJf/DmtvcLMsIcpBcuY/8XTesNl6y+OP+eAMONl?=
 =?us-ascii?Q?MNuUSvGxnIAVDQnd5cksxRjdcnrJSZadw8fxmOsCSnYFbYdrEE6D6an9dX4l?=
 =?us-ascii?Q?40Vu15sNdHcGHObM4AtJjoF1Td0LPfqWzpyNUwKWNDttmEsOxGnUOSz0gCKf?=
 =?us-ascii?Q?L0uZGBT/1ZJ39k7IzJgGFMpMwAUKpDG9Rc30WLIS/Zftj0MgOJixV2tN/NN/?=
 =?us-ascii?Q?YMm2/YRu3FwyL0Cfw0+jDYp71fpRmV2XABVFs9CCEFOOZsejXK4fwTIEAWWh?=
 =?us-ascii?Q?xvPNnPq29VrsrFl/BSGP31qJ+Uopvwr3nMgh9NUitTEYlV4P1w8lFi/+vWW+?=
 =?us-ascii?Q?TAU6TqUFoCg09uqC3FGPd2DfVHV+ppUHlb0uFXccFzDDNNPITXfszgNFR+Gd?=
 =?us-ascii?Q?2VpMGZ70pXTDZMM8alqfHbHHuUuzXUphXPcSbTR1KPdNDSdydMiSLY23NxzH?=
 =?us-ascii?Q?9/qW2OaYu4d7A7kgFTyL6F60+9rIZj4at2ZcIOghJDRlSgQLV3MxacYbpTDV?=
 =?us-ascii?Q?4BD108BrEmUxtHqhYeXmIQTEsar694vIiGIiAyP3OKGyb/gTotqmSyb2uWlR?=
 =?us-ascii?Q?uyFk/ky6ljT2iw+s7ELqqA218Fo/F6YV+kQKlex5vgV4HTahnnAQI52DSobe?=
 =?us-ascii?Q?+x273rUzVw/7lMGW1UfXANIW65+CBLv+Eovaqi6TqdpuyPfAzAy6M8b2qRZb?=
 =?us-ascii?Q?PPOj/44I5GYSlj4ZGxqom2FXZB4v4veDsRb7ou4fC/f/pB0FIK1K+HvkrfWx?=
 =?us-ascii?Q?0XB2MwpX2yL0NodBOyMh4Ed9EnQDmB3AhLR5/oyl0u7o34F6gIpixVlaBTiW?=
 =?us-ascii?Q?vwq5+ySUcHEOx+u7brIylYxMtoKgkbuohj2dLDDDMPmdtcVuhm8ycnT5Xpdi?=
 =?us-ascii?Q?wP1o8VjQuwgCKcyAiOR4uOP7XV5E51Mro35vIP8bD0oz7/vuM1W4D+Okuoxz?=
 =?us-ascii?Q?DtVq1N82Ofmrozw2xIMwYSQ9866F52yx770IMb6QHt7MrDNk7wyez/+DIcvI?=
 =?us-ascii?Q?7e1DvOz0jchML92WJVibQE0JpGS+R8VnmiDws1o0JsCxY0/DXK+UCugJ6dDF?=
 =?us-ascii?Q?hsKxxzsRiuPupwAHHtKOOcb+kisnkLTvCNFCG+yyHRjczWXD17fRxmWaTpF9?=
 =?us-ascii?Q?iHoBf7jYZ0JIkpvOyVl4vMz7thfuIDDdlvjhZLr0ng8HuQnJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PR21MB5419.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb7e2fd-002a-49ff-51f0-08df0ea22260
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 18:42:43.3934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2fgZ0yDDGqU3X5JiRgraCdAgB2gLkuUWAxzcE366RSaW6pNGRzkwejVR7A5mfCKFuHxOxkwoiTcMLMyYGbFp7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB5296

> From: Naman Jain <namjain@linux.microsoft.com>
> Sent: Monday, August 31, 2026 1:25 AM

LGTM.

Reviewed-by: Dexuan Cui <decui@microsoft.com>
