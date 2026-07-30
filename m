Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE7238D6AD
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785449959; cv=fail; b=WgAkWu8uo3k8g+DucIlXMf11/76jXWnd700DmdiNoxR4M6OSmQNTlY5IosLRArtFWB3MO3oaOuv5TES8+8j6YcNsz4Mv64MQfFCxY3w4Nz1UwYHvWHFcHYmx1fF0VnpU2T4nArCEOD4yxbA3jESbWAMTK1wsmUFNBpFrwRbBbQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785449959; c=relaxed/simple;
	bh=Lce/KpJOhNEtr2ff0nilwzJJlaCEX4uhLAtgR7Z6bm0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gbkmxwcWZFv0nEcatjcA8DWl1tvA9HnBHfRpV8AQjKYtd7GCwo4jk7rJXac1Fg98UEzp75HI1tdT4n3RDpbsq9dAVbZb4UKHpkNeRf5Qh31v8uBVKsfs02lQ+h4UkZzZN3O096yB6gtCLdz1I0XPuvJTEkZtI0B1oUGHldm0Q4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nECvbL6d; arc=fail smtp.client-ip=40.107.209.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nECvbL6d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyWhb+/wXCB1H1ngkCRnVgCpkDrkH4jq3kJYZf8xxH9RyWTsKMcZ1/AN7SJjQsUqxcfMkb4/ECNWiTkMB3RUP52x9NSJCzEeoMdKnFpv/ITDiJYikcbspW7/osGekqJFvqMZaWVmg11PlIhBpzR+80b8QbOI18K3Rf0DZHtyk0e0TMplJt9aLD61DraMKqxZpWK7rd9CgTJtj3/RTPl0YDfu30BJF+i9x2XqYYB7AxALbyc+HeK48rYx4ePlrnaWClbtV7AwFzF7TvG+UcENmMgcAwSwPq2g1tZuHqIYNJJjajCFFn26xIRHqmNIaxCC9GEJEugrrYTXGlnNX6dV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5Te6r20gStcxg8Iy0aQ4sx7pXiARIIcwag06MDUhjU=;
 b=n2XA71mgDWO59F9gCx1o8sVhoFPOdVFh9BZkKcC5XbNAP0C/y8h+gHfCVgX8Qdx6fJWtBphV4PBXDofAs6+AuQsOGzQex1X3cq1+QZ+Lz2adKBZZ7I6jtoijCh1Zk/Bi6v9p3A4/0s21MgvOvsKY6oNDtsJTKM9LEgOas6xnrt5/nXgGQYWo1SfmOPZuVQUWZCpJoYXkXh+1+aQv2h3toCEBD+WddnEHIc7EvU1cIbA2cflWlwC8xwwJdpn1bQ+6sRkgr6T5W2GPPe5WeAGt+3wwbw9QOf1Vywrv0uCpEObxoiq8qnE4xhSlksd9k9LdNQo5BtLKQHvp7Uym/De7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5Te6r20gStcxg8Iy0aQ4sx7pXiARIIcwag06MDUhjU=;
 b=nECvbL6d6pSo/SR2QgLb9m9klnHTfEG5M/XkDPRc1Mwn5wb7WRwEJUDmsP9vJ5qLoUhUQ5D0HEA3p6mOz55yIT9LtyZkqswQMPI2wjnP1IgdgV5PgBp4Bw1v/zGN7OuEyRARSzbX3+Hg/5gM9JmzQrO8jeeW2R6a6f8iOATRqZY=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 22:19:11 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 22:19:11 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Subject: drm/amdgpu: validate CP_GFX_SHADOW chunk size in CS pass1
Thread-Topic: drm/amdgpu: validate CP_GFX_SHADOW chunk size in CS pass1
Thread-Index: Ad0gcSLzKOXSCMEYSXqwSh24qdpzzw==
Date: Thu, 30 Jul 2026 22:19:11 +0000
Message-ID:
 <BN9PR12MB5146DD3D2AA3DFEF175A7948F7C92@BN9PR12MB5146.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-30T22:14:29.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|CH3PR12MB7523:EE_
x-ms-office365-filtering-correlation-id: d5506c97-ab59-4471-c879-08deee8894e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|10067099003|11063799006|56012099006|18002099003;
x-microsoft-antispam-message-info:
 s9fh4iUOW8ImVQwSP3kTAom1akYuRa5fvQi02D0ykcNTD6CycNgTtpLwjc/RXjx+1qWhskQGf8dOTqqscN/fo1P7q+ME1FS1FLQDmamqXqZzgVEM+MPCnf6JFYhjMaOxwLep3AjhYKGF58nyinh+6/RRxQv+1sNQWIf3AzwYu3oVuGLWjEHMhrYuL8CwJxtA3wL9D8oggtnku8uMIQTcxaMqkXm1y6HoDHVT8ZmOaoshhg0kKk20iHIaH6nteHNtbSSSDY8UmGkswdJg4SowkATNEnx7bZgGcLgAcZU6al+Ejqkf6oIkpgXB7ht1lKVgqd8z+pUmXVFx+WnGCuNCRYuA045hHYgeWpj4kbehmdRNOKQMtSMJiRL4Knf1TNW1AV8iT8VypucUNhS2YC5VPggTQOQC7j72X8RGxP1N8rpHQdfumZ9wJ0EpQLouQusQmNzHZo2va84YLYXve2wfRSFxo9eAPTtO4ITyaywVm4aDuV5tU0ZI/5g0zhT2Xi3BGEsMo2WrbHc2XNRwaLlO4h3BW3tPb3umI7uYJnlCczGjbBufPLUzWXShITY6/8WjnVVJA8lw3vn0ekKWOPNWDbdxSTsbbwhZ4ii2oNZZTYLXbPY9TVd4PcmI15POn7QwdzFbotzsvEarX00h3M0gpykh83v7TWFquvEk5nCZE7PTHatJ2qjB6fJWdzdtAYV/e5Zrn/1xuuw9+iRAYNArQg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yYAKhEvPZU8KfL8JVpI3hqsDeGclVw7Of3BDk78i9vvJDmmI3eFjSz8lXcGM?=
 =?us-ascii?Q?m0DVRzNvpqKodXiqnKAhAUvnIqiTIi8LzyTVaOciKNdQ6A9dPexhzuh33m6g?=
 =?us-ascii?Q?3uX3G9InJPfsqi2dop/i9QxvTdTu4T1fA5ECeFnv0tXg+WVM5Sg9nxYi+UNp?=
 =?us-ascii?Q?+NgmCjkEVcigk9nMSqyfJ0ob2jN/41GsEGrguNLVTZZfW2vL79GUY362lOF3?=
 =?us-ascii?Q?RNp9arwy2J88pbcAQ80Qrx2tVwVfrUY0G2q08FbCsVmraW559Qb4Oa0nGnkN?=
 =?us-ascii?Q?j2zAoTH6MwUeyqeWdyr3J8SWy2Pr8cQquO4odArv6H8fjZwxy8RueFfMokII?=
 =?us-ascii?Q?hBV4dkt/Q/RR7/ThL5g6ExBnzvBM4OB0Jr+okKFSLu62PPIUA424CmF9U0mS?=
 =?us-ascii?Q?uum2ieI8FIFSGOPuxd0mGi+BnZja7md/dSHjJYXUwqfgIWBTNX60XnSLlg3h?=
 =?us-ascii?Q?QpJZSA66E+aC/fV2BqIiWqZuwvGcjJVjkZTqo6cpPVd08MfgOLZrDTtyl8zp?=
 =?us-ascii?Q?s+XckF+YLVIhuEofbnMhNgUQ40WaJZ2qPx8r1EfR6vCcWgysn6o9Z+Mololw?=
 =?us-ascii?Q?J54pPH+XPIAeYoRJ070u+sSKN6phbxIvfO2r2W/LQFCPry6lxwVeOQYsfAtk?=
 =?us-ascii?Q?5flIYeME07kAl3gtJLPRlkvg/RM5OSPmZ6xMdB0tl0JaiHJzRxOj2UvnA1rx?=
 =?us-ascii?Q?WMq6OKGc17XWDt6Pfx7aSof3rHDdYq9yRcIxZVNh3P7etFvvalyeIKN3RKOC?=
 =?us-ascii?Q?2m1QYsx11wV65mWZjUQUt3MjQT5adny+IY3EbCpgQKrOER17OJX8YGeGIKlR?=
 =?us-ascii?Q?J4ynssRgw6GhwRvvqQlH+LYUb5wc9Ev4rYkqmj2ayMJRE10ZD9n83i0AH8w4?=
 =?us-ascii?Q?yRRAltsIuTZ7/L0ln2yH1DnVn1eavS4haU+Q2n3CPoz4NPd5mpAIAZjoQUAj?=
 =?us-ascii?Q?MfFkc5BpnZ/qLtdOgH22KZVoCq8kZM92NtgvsWiB6vq84C7rDtdIrcWmUW0p?=
 =?us-ascii?Q?t9CdcbaJp6odOkyMzeCIeaNA1qsbh0t8T2XF0lukWJKtqW6iPD+Lv8xaN69M?=
 =?us-ascii?Q?NGB54QP9tClWxMxL8cyHyQyUzLVit/QPXjdwnWOwr3ioXMSlAr4SmklvsN/X?=
 =?us-ascii?Q?KZlebIcnrp12gKISN3bv+7h9LGqqZSQLgSNGzg5WmrEuaenwhL2tXgo9c9X+?=
 =?us-ascii?Q?7fA45MAPoX90tb7aHpz7NvogNAXxYF4tpTpCl+Roidwjr7krht14fRaNcTm9?=
 =?us-ascii?Q?I99CyaR1+0uoLPq5J8sXjb2X7RF4f+nhq+ImbMHtA8321oo0hCSI5DpN/i/L?=
 =?us-ascii?Q?1shUIen9oZvhDaLG5WMQJSupvewEOGyuZIKkPK4HbWC3pj3a5oL8MWB36GXK?=
 =?us-ascii?Q?KvPM1e9QJt7CivGBgKTvXg3rSGUkdYfoWCOkO/j0f1MrsHZgJhVw+CxOHSGE?=
 =?us-ascii?Q?N2nKu3u1gWk6tWYlwsZQ1oJDYYofE5y/7frpWHyPRqpKr0HgOJ6mxJwZS3VR?=
 =?us-ascii?Q?GQGNhgKtSx1lEhtwb0WY8jzgcPyYZCDC/wCuQX7LSSA8VTJxYZbZeXmqJ+gu?=
 =?us-ascii?Q?76EJKutyirgfjXlqvMqTKncEUQCP4AJAO6sJDzftjZHnL8cRISnxa+CxR9tH?=
 =?us-ascii?Q?zeMotdUYAnhKfYNBvlrCfouRJU5uPkj464W1DEEW23DiKJCqSeRAfqyF+LqY?=
 =?us-ascii?Q?Sw/+ycABw+mKmF0U6qAO0Tr3FbK55z0RraNwIFDyZxZgXjtX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5506c97-ab59-4471-c879-08deee8894e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 22:19:11.3580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YjsqH1KEt23xvAoomgwAgP398mbsb2pZc/T5wSI7PWh5V0UsKtWvd6dtUQ3qbwd5L+WJijED+9n3fmVfTfgXwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523

AMD General

Please cherry-pick commit 84c4c36acd5c ("drm/amdgpu: validate CP_GFX_SHADOW=
 chunk size in CS pass1").  The commit had a cc for stable, but it has not =
landed in the stable trees yet.

Thanks!

Alex

