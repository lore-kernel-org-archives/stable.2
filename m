Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2191825B091;
	Fri, 16 Oct 2026 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139772; cv=fail; b=aGefNQDkL32qsjcErZrGTlS+MgaHsSb8duDIsD2VGDrnjIcmMOEs9V8AMC++AwWPzAFvJz8cQYBJ/T4JGn7izvGSNtda3B16sWL3x0UvYx4wAcFV80Tu7hZALacdVDT5XdLVZDO9FIeQsIJPo2Cjrh1nhzmZWIZ+LiVL9qW2T30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139772; c=relaxed/simple;
	bh=iUP2I64dIJ7ZdihImWDt4VRidqcUYIsMsVVF8BMGm7w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Af+t1HmEMVpEF5qtiz79xqc7xFgedPudBxLFtooEGHKp5yPJzh+88XtHbfHR2H3A+gQtrWQP+G43eZl/xro6h83LTceimGI0oKAJxitmPeqTdxxI3K+c9rgg6SsrWjSB4AVdDRXq+qq7vKk0cl6cukNgMaSAbDh8s+LRLwLNo1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rko8M5nM; arc=fail smtp.client-ip=52.101.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rko8M5nM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnKm4LEC5oKeudXrjXUPtVJeUW7cwh8l7EjCcy+vi1XLwuKVHTpK5og0GB1kAwB/eT7Y8ICdZw0AniE1OSeGbCpJ/IDcWmGZuDWQCEiVArH8HeZxktF50etGMqycQZ0PQSs9/RUNHcVI3UMT/hyTSqZ0ohfgGQzmjFys7MOqcBCLzgryGpdPRwGylLPkmfFC/1Iu8UlcCAYxRByOcQTTduJKY6XIvAEuScgEgKlKJAfj8DyskZxVWdVVAHLBniW0Wfa5xntNfJ3t+ihIZAeqpLp/TbfCNuyLxPvwIkblEf0cr7zBRHqEHeGIGbL2lAhiNLYSxmPSovG9HlWyflDr/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUP2I64dIJ7ZdihImWDt4VRidqcUYIsMsVVF8BMGm7w=;
 b=tGnq4qedo5yardJn6J1KAmChuR/6EEO+aZJLEptGKmGRHK0sVRn9oTExtA33ISl7Ad9iD7m0kn6+AW2GCjI9SbiX4uy/yVA0JL4G0xj1K1KhA3+UP68lVCX79kvJ3NZAnLmI2ILOXWIDiyen3PrAJjzbcq/h4+BwT6YmxGj4gh+OQU0HExrXJqZl8577AkaIrYejJSy/nuffDjhOkSkbuCI9JbQKlTJd3eiAObDXZ5CS/CcRGx1kpDT7ugx/vcIF1ucXQeSSaX4PUvM83P5gl3yz3YQ/YwvpymCmJQktdj5LmmBzJGZNrhPPk/M983W43H6Q7CJ/lQ/fnviwlz48vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUP2I64dIJ7ZdihImWDt4VRidqcUYIsMsVVF8BMGm7w=;
 b=Rko8M5nMytWp6yhzWCzSTPMeQlQtNRH+KSUEO4RmHfqEi/R/5WVgW+YCU5Lo7Fkg3r2xtRW1dkGpeGUtNBsLNzXIV43dl5Bp2S1QvZLXaUczy3Y/kObXMtdTDjnn/Fd5rukieyoGMczhQcT4jU70c7m7PndCd3LiOHxNA72CGxMDuzSCx4T/BU+MCvxiao7DB7/a9xyV7qRTdH+MMxxj9lyyQ7PfEMzMjbr4NV/CubtDAiPbkmOZNInRbpdELJMQJQqQ/ZHFG7jWU/+mcNkvKitIqXgVsm9dmvMYclZlt2c0Dee0bEO3ICqcuvbwh3Chpi2zjSRiK5Esm+PD0qdzaw==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by DS7PR12MB8251.namprd12.prod.outlook.com
 (2603:10b6:8:e3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 08:36:05 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 08:36:05 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Andrea Parri <parri.andrea@gmail.com>, Alex Williamson <alex@shazbot.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer
 Kolothum Thodi <skolothumtho@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Jiaqi Yan <jiaqiyan@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] vfio/nvgrace-gpu: Use a core-only open_device in
 fallback mode
Thread-Topic: [PATCH v2 1/2] vfio/nvgrace-gpu: Use a core-only open_device in
 fallback mode
Thread-Index: AQHdXH4FK1EyXFmi0kOO7GnzrIArMLb/2Xsf
Date: Fri, 16 Oct 2026 08:36:04 +0000
Message-ID:
 <SAWPR12MB999267720838FDA5D7136D2DB4B09B2@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20261015081937.405320-1-parri.andrea@gmail.com>
 <20261015081937.405320-2-parri.andrea@gmail.com>
In-Reply-To: <20261015081937.405320-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|DS7PR12MB8251:EE_
x-ms-office365-filtering-correlation-id: 7d0ff0f7-fea0-41a5-4343-08df2b608483
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|56012099006|38070700021|11063799006|4143699003|22082099003|10067099003|18002099003;
x-microsoft-antispam-message-info:
 9cq+YnX8ZorNesFnfmG1yeslM1CE2wJXOyb0mlNMyw+R19ywVzL2nIjB3jaIwC+0IVniDNxB3gTyOweujfmSHMbbx5mO0I5zm/slwmzHHQxfmqnYS9kS5veFtkUpGdZ1Z98rJLmyyz/qg104nQTC4SBUkCUDnpDieEebWQxkdxs908ZoEd6YtmbyiGsXGzrmus6AU+bS9kyu2lY7sQvgqSxri4OTryRS3uhRkyvadvnToNPUF7bRQSGtDEQiIf18gTNuXiN85zqdGF6RlT1B7jnOT6gTMSnVuedHi5MN2M2V7Uoztk+42Bj6kumLW/2aSLD5EnOOUmB3nAZKkFhJMuSXJIVR6gm/eE5G0N1IAjRovO70dsmWAd991O24F6Bydnx3jxPfA5glC872JF3+AeUsWfupU8NqGLFXcJCbRpaKWl1evGjbxO4WeqAm3U7toLnWQe3fzgW/BnM8ssSqQENQhaWfInwUJg/dzBqxKIy4UeaCdnzLmSRnrc8PBzZ+rjg682S9zeFVtPBfXGZSfmPLTQx3M7f2tEGr0psPsfDd4/GupKMe8lQVkZDHAQkKvOtP6/ucEvih879xOUixC7YQTlfBj5q6u1q9gPEo6RHdbqwsoAi0hTYqVmMoUe3VN3ibZkgODePITR0HDr2ypLXluEMy3mdIk7+RPpqvPvv1j7aVfgDGUIJfBoH5TFlyh755Q2cR3fUvLyPsFzkZQeLcZRl7M1e1QrqmwW5qXp0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(38070700021)(11063799006)(4143699003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?UWwGZAJVq+J6nxkkL08mq/lMcHAxVCb5PY2GGXSV8U9lM9je1weKvIfxmi?=
 =?iso-8859-1?Q?8FM+DXWMd5WkhrbOjAxFTT9ezlpvjr9pZyJ1Tm4YJaPaXJYNtHX/bE5IGQ?=
 =?iso-8859-1?Q?72BJVw2nrxVBeTRxhu3lnLmuU2qMjrEyQ0qloXaT6bNDdpU5DEShtsD1Yy?=
 =?iso-8859-1?Q?iip66i1zQVcwzlxk9p3MPrrUhJL3j+7Cv//7OKdG8mI80l17x/0l+mwrxC?=
 =?iso-8859-1?Q?amnQKYXW+IU9X5t+8whnMmfRWy+xXdOHoZ2+xc3gsi7w9s4yY7l1jyTlJc?=
 =?iso-8859-1?Q?ZWz0bBRHsz8A/jSZ3lci303/aSfT2xlri3d2gtcklgF1pNfvBVoBa4ocft?=
 =?iso-8859-1?Q?nF8PP/aepsoqE32Od16zqU1ZdPZWu1hj75KJ4ESb1KptBo63WylJ5JeWhA?=
 =?iso-8859-1?Q?tVvPqO5SEEpo3GgNfDJP0opP2VrUDSd0CwLBzY2f+nocFERma5Vk9cvTTd?=
 =?iso-8859-1?Q?GByE4WcUP1M0+qF7XuSYeFSOaTrkhk7fwQgjG0IngW/+6kUbaKhRpKFlJj?=
 =?iso-8859-1?Q?CW3n65gkGa+zto09f0NmVpHjgafV14TcljeXgff2yg5BNdIm74ssmxc2Ib?=
 =?iso-8859-1?Q?yRC+CRCUawuBTOMxaBX2A6FZNAqskxfcqRJWsx9eqgU9GT/C3rgD+PeNpK?=
 =?iso-8859-1?Q?RWaK4YGLi0GF25kBL1iHnzD/DXxEj2sF/kzhS4JDX06u3+I2NkOyhEaWCN?=
 =?iso-8859-1?Q?/URs6IK/dibs2lKiN1aK+lmAemvgPcKaeFDkxfM7JG01f11n0+UxBcKPuU?=
 =?iso-8859-1?Q?OvyGBElMeWeZnElAcVE4cNPh0t8DNoLvzTzl7hWdoyEdkrZ7sjoFReOOuT?=
 =?iso-8859-1?Q?ljGo55F45v1fsu8kVgs+pd4gVBMgyPseIV0qEAYV4Ln9MZxB6nBXAeQk5u?=
 =?iso-8859-1?Q?RkmSuaBNT3sxh1GHq9LOQsfv3cKYYsVjOsGA91imzxZkAZ1gi5WFDxCPm1?=
 =?iso-8859-1?Q?yeEhNldJjaDKmtgrXGhCxJ9PPPrAwBLdowyY5frdszn5TuIJUkwUvruE8C?=
 =?iso-8859-1?Q?o7swfszlyjVM59d4JuXJjl/oGIHGVD4/fhbMlWNJTh9DCYy7kHYDX9nUZj?=
 =?iso-8859-1?Q?JUkYWJgroulBIM40Wv7dZIEDDP715q7vX2oQX/J9v5A4MPYescSOQOs+Z3?=
 =?iso-8859-1?Q?5rljiU5lIhuQONWTnfi7RjMF74j2aMEYz+ReB9UYKiJMt3/1GattMCWPAU?=
 =?iso-8859-1?Q?Iu9IXDDt5Kgn7ELNpZ/SO+jml/RmZPUO+PM2o0QnPyoJo+sYfTKo/Gtf2C?=
 =?iso-8859-1?Q?xmbrI39TdWST40EyRuNy2yaTiX0V0sQSRMcj1LfRhiKnqT6qKrSNmSG/px?=
 =?iso-8859-1?Q?knPruh1rvMeaTKJ6dRwfIwHDpxMGwjgjJ5BD+46ZDl5wPoo3uEGkUW+fiH?=
 =?iso-8859-1?Q?PGmgoKrs23XHeMvroGNTZifEjgTkqXggL6ACkqSF64nVVT9MsNizqxYpwS?=
 =?iso-8859-1?Q?nObLnva3tsV3ApOcMVCvA1uxk2JMVSdOfYF3bhrhI44tmJGG4RIoCIWcsO?=
 =?iso-8859-1?Q?nktEi5+Kp5jfGuXKvcuEJBNkJ9exHQhEvSmx1Fc1arWjcczMApt4rT6d6X?=
 =?iso-8859-1?Q?BmAhHyNkSH2a+vFFSUtV55QIKHKZsdhFuH7/o3/4FiDtfio0tPGbHhQ6GG?=
 =?iso-8859-1?Q?WZPTmFgGmUjV4FNSD+SHGNSo+Pp+9an0R0qQwcmP3l9VAQ2WgfK5XqBdNF?=
 =?iso-8859-1?Q?os/NgdgBE9KtlHoczW3kouamEk80hLBnGncq4YCRoj4ZU7Ys17PrAELvC2?=
 =?iso-8859-1?Q?xBWJYS1Iv3Ial077ICOt0zp/pEicEe4drLnLbNu8ZesUMr?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SAWPR12MB999267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0ff0f7-fea0-41a5-4343-08df2b608483
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 08:36:04.9492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f181EH5MiAstfhryL45BECPNE2/LjaIBPxYAgW0/1ZQ9vYwFaqzCxmu531h6Mtm8ovJLqRzuDsDqUNstrS4P0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8251

Reviewed-by: Ankit Agrawal <ankita@nvidia.com>=
