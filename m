Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010019.outbound.protection.outlook.com [52.101.193.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACAA49620;
	Tue, 29 Sep 2026 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713979; cv=fail; b=PbN/o8L1pbnB7wRaBLUbXa2AGQVb4Vv0dYqNYFZfoNy5c0eCCzf4PbVZgUO52x0m/dv/sPdVdqf8h10xO8rosJBCnSdjIBGYsLI1znUATUwabJ4nhkJ3evvwgyu7tUdI08jBje/qtrvyDO3RqLbhTt+NdPObRU4hmUNpr76VgNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713979; c=relaxed/simple;
	bh=Mcd+ofT9GwErb+SagCTGhz+BWCxuXQetm20dzw23Sks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=haOA1lRrKDIq4WFJWM8L7S0qfgOLOmvXnjfYlYnhhlkRC3DlEXa/CuWdhPkq/ODrfBK+ZVVUX6Z99PF2oteiak2smt2SNXf9bGvr/B8hEcN1Iob12hGkIbXArsyuT1AIkLTlvaPscGNYZCA8zZexhEtwnDUAiISuut2IchSMKnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=appgate.com; spf=pass smtp.mailfrom=appgate.com; dkim=pass (1024-bit key) header.d=appgate.com header.i=@appgate.com header.b=pYML0PQu; arc=fail smtp.client-ip=52.101.193.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=appgate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=appgate.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=appgate.com header.i=@appgate.com header.b="pYML0PQu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GALHi3ApVoTPg/8MZc4dlU+coLclpG0wHAySui2WRpICQGFlKOv9Q5Jw/B7/iu1NC9TT2X2dd+4waFbkDW82l2zSlWL/fmaNY6F1AG+7c6MFgO3vMDodm/tHzNKfZ0tPsyeeBXh3KKtB/Wtxcq4XH+cq5ziEWsyZWh2WRTjj9FvByPJIE0VGGbU+Tfr4fWC4/hrxwF8NK5JkhgcrHzhR8yy2+QGGsX4HlyOSIKhhh36hjKtGeNujfpJldjOP8wi7VPp0c8UfLAGWZnybEzihDrgU16gvhmMP1BqT0sxmW3l29NT71KUlw78/WMf3LALDy7O/GMEJaxirfNY7qL6/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=0pNmNLsHD5uO6G7DqiH/wGg0jXsNRt/31ex/F/SOyfY=;
 b=YSLMkk8rwEiSnoD93Ij2n5aqeG+ca9fpJMrdcl6WqI6gWi+Co8b2Eh+K4+JBNjcuxLza/7dsGZdkwF+Y26dCl4df8wthUcQFCEdJPjbqJxGUwYvP6c2Um74ngz9l0P6NtH5q8fXlgon4vYSUJAjTJNqdc2AQZdNt4ZOA/hmX1VyrtO/FN/LJB+HItEQl6pwfeoMJURQ7JTC6weV7GFrBhsYglmYoKmN1ODiwNK1JefcWytluquNk3py+Z5qBxNZGxeBdVNytWmi1z1MHnqqgFWTl60OZf+5aVDiUUWWOntv5uwh+pPC88/Ly7v4GwLVEqQxc6QgRlJFqo/ZcEcPTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=appgate.com; dmarc=pass action=none header.from=appgate.com;
 dkim=pass header.d=appgate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=appgate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pNmNLsHD5uO6G7DqiH/wGg0jXsNRt/31ex/F/SOyfY=;
 b=pYML0PQuK2m/FaWcF1ZTAyAeV8WvN0HZe37sdkcbPJvVx6JM9TPSyXb4uyb9S7GAZu4sgBQCnTc0gXc5FSKoecIsdT/251jNNJTWdT5iIn2Mnm+70iXgjrngfL/stZ/AjGjN6lh0H6EUS/95vtgGFYlv7hnP6rzxGE4TjY/+DUY=
Received: from DS7PR05MB7320.namprd05.prod.outlook.com (2603:10b6:5:2c5::22)
 by SABPR05MB998952.namprd05.prod.outlook.com (2603:10b6:806:4f0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 20:32:53 +0000
Received: from DS7PR05MB7320.namprd05.prod.outlook.com
 ([fe80::90e8:a175:4ca1:74ec]) by DS7PR05MB7320.namprd05.prod.outlook.com
 ([fe80::90e8:a175:4ca1:74ec%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 20:32:53 +0000
From: Dave Butler <david.butler@appgate.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"emil.s.tantilov@intel.com" <emil.s.tantilov@intel.com>,
	"luoxuanqiang@kylinos.cn" <luoxuanqiang@kylinos.cn>,
	"bryan.fraschetti@canonical.com" <bryan.fraschetti@canonical.com>,
	"tristan@talencesecurity.com" <tristan@talencesecurity.com>,
	"tomasz.lichwala@linux.intel.com" <tomasz.lichwala@linux.intel.com>,
	"horms@kernel.org" <horms@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net 6/6] iavf: cap advertised max_pkt_size at the
 single-buffer HW limit
Thread-Topic: [PATCH net 6/6] iavf: cap advertised max_pkt_size at the
 single-buffer HW limit
Thread-Index: AQHdT53CBEJx2voabEC4EKwJRzbAtLblvSaAgAA9gVE=
Date: Tue, 29 Sep 2026 20:32:53 +0000
Message-ID:
 <DS7PR05MB73201A15AD9E0795156F88B18B8C2@DS7PR05MB7320.namprd05.prod.outlook.com>
References: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
 <20260928230429.495442-7-anthony.l.nguyen@intel.com>
 <ab87c498-b1c3-4d0d-b4ba-57e1826592a8@intel.com>
In-Reply-To: <ab87c498-b1c3-4d0d-b4ba-57e1826592a8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=appgate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR05MB7320:EE_|SABPR05MB998952:EE_
x-ms-office365-filtering-correlation-id: c6669282-9d35-4c3a-df05-08df1e68d65d
x-appgate-rule-whitelistdomains: triggered
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|56012099006|4143699003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 kSNAk1PfuuK3FcQL0hQXYdwoiqDlb0QfFP2ni0knNf3dWmyPwSuzezSNbNzHuFjT/Vk/fdIoktymL+uEM4aCe2JEoW358VQri4zAdNyssQ1v3qxmeHw3KK7Ni1LMwqBVkfbA2qJoHmpWV4UinLvtaxGjdo7O0/W7bQTqkv64+L7NL0ar5QLu7r3QlT206UItALAmTRomz2CSOv7wlIlPSGTTGv8kCf/u1SbdvAj4ncvlVKU5zD1XBYtdMDWASKV1PichswEWzihJWA4AkBim6O61ZYE4ZhUjAZvQuqBpsxhDKMW2k9G42aufc6GAJe90sCdsAOMEow8By9Zxwq2ijKvGfEOp04zQSa0+N/XRSf4oEw4OWFo416HvRJy+eU7LhiNnhaqAHcoL1fzSi/qadQKvTWRFmtJS7fCJhT9rQGvpqmT9LKUOOnQ5qbiZLxXv9Jl93YpaT5sJ9m3SaNasq/+HbZpk8cfHFk0RjTsdhDbkfHkNx0MhgcSVtU0I1KAu5asmyx2/s5LdHI1/9cnfIgMfLEmfYQEr5fXm289KqYBlKN48nAHdqUFIk0liI0WsZdxn18rbXMLDDBD2EUQf/fV7yfM9qFTL3IULRyfJ5Gr9LiYiBvqda+mTqgP9DliyfH0jjXcg8FK4skLo6qvmTCZ5turxi4dDqTQPYpi7T+BsyEpvb8LbaUc9pNCJ9wzJpvCia42jyymNYJqO30jneUZIVWA8effWZe29qCzxIzM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR05MB7320.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?52XdcIy/3nPAc23do2RFanXfsaZYZhXcBNefLVYFSqqHmD0IyDAk2166nr?=
 =?iso-8859-1?Q?YV4PeDxrC4hnktdjfU3HidEEDkxVc9YUCVhaYiiZDI3W5UeaPoa8Dea03Y?=
 =?iso-8859-1?Q?OajiD3MGVCEjA9n1MFrHEsSmlmMiRaY81AZDsq6A96mugD1D6mx9SX8mrp?=
 =?iso-8859-1?Q?+tN0dfTK01sMzMMHG+FS0vig0d7TTPWhVPVL5PpBvApXh/LmoN8ROC+VEA?=
 =?iso-8859-1?Q?2HH4VWBWh4gNu/VP6Qbh7mmVvP7X8zxYg1dxMuwVlW6vxNsGps5cnHzF5B?=
 =?iso-8859-1?Q?mB9Ph6vjr0esPKVKEcFPFBF4KdsiuVAx0MDu9GktBB03po5MsnjDJqbIsW?=
 =?iso-8859-1?Q?LZcjv+jJ8PXg3xCbodbp/GF8SOheL5T/nU6rTxmXarZgNB3GyZehPp0Cby?=
 =?iso-8859-1?Q?UZrD8goj4a47GV43yNbfoWHHafdGcsqbnRxuT3PBtGQhYOfFfmXILPw1Fh?=
 =?iso-8859-1?Q?0dddXOQFHot58CCDFOk3YrD3R0fqrDsmirEtlGcUVfqzhWpEZqBN3krQKN?=
 =?iso-8859-1?Q?klXO4ni8fjvAttRtXY2vuAdX2eDauBDPFDACSqisF6Vo0jGR7JnaqG2LbF?=
 =?iso-8859-1?Q?UK2mfEBn/58McRW7uTV3jbC1skTsmV5+Pgpr7cJ9LOCXIk9xsnRVnWQxFd?=
 =?iso-8859-1?Q?5ne9oIh8hgM4r7fw7qu+yBGJV2Im/WwWbg+c6FKBPirOwYJR5lH1XDBUm2?=
 =?iso-8859-1?Q?G1t2sNYKdIjqPsSle0V2rQXDEEfEkl5ovb1ZejRTURUa8fjvwXBXFTlcGm?=
 =?iso-8859-1?Q?+MP3jfQynqgWAHMvQEHUpWWaOv7mx3H7DpToKui9rVzF9j5YcKRK003t3g?=
 =?iso-8859-1?Q?JXWVR3nWMHpuwJ0XeHqkf/1uf+EOuHpDNWVxsPCbuys+OC1cVpGm1UhhwT?=
 =?iso-8859-1?Q?Ztof7a3eLOOUQRYCR3H4eL5Xak+8S1r592n/xSJgObjL1Tm7uED+aEgxBA?=
 =?iso-8859-1?Q?hFDsrToxmPgcUvUe7TQpc/RBcwdQEBxtqocgiduskCwiqF899SwJjvRjKd?=
 =?iso-8859-1?Q?tbHL92h6XLOzufwS8wwZTfKVjDn+5WKOUUJFtyHwLDJgJjTocUFe2FM6aD?=
 =?iso-8859-1?Q?SBjLUFS+g7ew2TDre+8e4MATM1CZPnPoZdm9Rqip1Ylpoz5Jvl1sv0M8Xb?=
 =?iso-8859-1?Q?NRwOOBkHU9hMO5YIsqEilnRFGuO0DzJfzYSwsBifUouTP4ElpBc6KfBDrw?=
 =?iso-8859-1?Q?jrA2PlY/hl4Q+cyL2rNnJpHIxHgE1boIQ4x7OjDuagKEhPix6b0JpBnTGq?=
 =?iso-8859-1?Q?4Pw3AWCFSeO7mb50gT3IsikpMCLdXlb40hWvjUoSGwjULbK4rI6dtlBsHp?=
 =?iso-8859-1?Q?jYfUIU2Gos40LDbKT7vDyJvfvgxwOfeFltxLeEkHneLhASY5FwP8yWWeBZ?=
 =?iso-8859-1?Q?63Xq6336NVUvhTG5eWea11I9ksK84/sqo0cg9m+cHvkcNYoGhgmR2fsaqH?=
 =?iso-8859-1?Q?R+NXz3rqDLt1epQ+7TynOMRUNfQx9GKBctymnO8C34zzRzXx2hbwqga2QE?=
 =?iso-8859-1?Q?b5i8qQuplI4v0AsmPhC1WO0F9q9sGo9MMFsggjiEFff3JEgSjok5rlrB59?=
 =?iso-8859-1?Q?XgZqMXXn7JMp3Y+RVEDvNp8m9HyVRcKhFt7JxMc2emFF+/rL7Nk5Rrpyfp?=
 =?iso-8859-1?Q?fDaj5zSxIg36UzBoRoU5Cx2/yzWi5LJX0K4ki6r6HhzLtMv9aazAMUJI3f?=
 =?iso-8859-1?Q?/MLpnNAHQruZkNeETREofeFDJiXEQla81TvASA7N1ElgvLw1z6WEoB0xAJ?=
 =?iso-8859-1?Q?z/hR9auvOtzakF6+ucQvF0Qqne0dmhXBnLZtblbwxWMZT+4IQclEZ8WjB8?=
 =?iso-8859-1?Q?WHRb6mklKA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: appgate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR05MB7320.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6669282-9d35-4c3a-df05-08df1e68d65d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 20:32:53.1288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b93e809a-49c5-4a0f-a606-82b846acc30d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NS+K8E8HwaEOks+XSHwQ/Pfk8OrhsNbMBklvGtknOuLbAR+nuKjLLOEaINEcy0+HQXBUdO1gc0+EVGIXUzd7OgdMFYpliNXz8fPPksL43qM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR05MB998952

>> +     max_frame =3D min(max_frame, LIBIE_MAX_RX_BUF_LEN);
> Shouldn't we cap it to 9728 instead?

No objection.  To be clear, LIBIE_MAX_RX_BUF_LEN is 9728, so it's
the same value.

Before 5fa4caff59f2 the cap was IAVF_MAX_RXBUFFER (9728, "largest size for
single descriptor"), and that same commit replaced it with LIBIE_MAX_RX_BUF=
_LEN
(9728U, "The largest size for a single descriptor as per HW").

That said, I'm happy to do whatever.  Just let me know your preference.

Intended recipient is public
The information contained in this electronic mail is confidential informati=
on intended only for the use of the individual(s) or entity(s) named. If th=
e reader of the message is not the addressee (or authorized to receive for =
the addressee), you are hereby notified that any dissemination, distributio=
n or copying of this communication is strictly prohibited. If you have rece=
ived this communication in error, please immediately notify the sender by r=
eply e-mail and/or by telephone and destroy the original message.
