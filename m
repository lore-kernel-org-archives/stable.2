Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020091.outbound.protection.outlook.com [52.101.46.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC9495041;
	Tue,  1 Sep 2026 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788286319; cv=fail; b=hZ5okXG00WUUCDHI1yrpvOD7utkujdO+RbeiZjC6aiNT1Gnj9eueRR7pSgEhmWCv1/wEANwZfH8+IbVx+U1OShlG9g7H9qybKw7VwcYzNvQU5sv+q2PLlcwmO7pKWckvCqJpCFMW6C4sKBImENZYYDHnk/htGPSGCMf5HIrrhhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788286319; c=relaxed/simple;
	bh=3ydEXbr9x8ZuTafLx+erZr0fdeJMO4d4mx6PvdAZ4/I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XbIKihIkMnqOjm0fQ5S+hHN6G82DY5TMNcxzt0StQwIQiTCELoyHhcxG4mC3hwUaEDHe14JZTIzls9WUOcPvPMLz315U6yBHTICuVR6CCdK9G0VP6dsY7yaTM3/R3bQBtAnYQQaHYdjnDLrxVGYBMpypbeyT5wj8hPFqoTlR4qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=RQU4y+ye; arc=fail smtp.client-ip=52.101.46.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RQU4y+ye"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+d8EuC8bN6DGZoUAwDVpl4s0IuPmL+X9k1qOx8Rsjh5NdsXvuuC+Vvqhd3sYQqtabWSaTn2tXU98AOy83maMtO/WKSCS2vLX3P6lmPkGt9ZJgytNGiUpw59BpYvYmBjTQbqP2Fj2a8MHZVIx/yvwMieknxyEW0fDtXsrZGV8clmWXfzQJFHDFPe9wfjb2bRf0Sp8R1TdsaqbGCHMcbFOjGV95+Ga+E49y8X8LMt6FtuWSqffHjhV2IkvgyE5FAqiO2CHRYT8bldLCW1nt/IDKxa/kql3vSWFin/VpTNPIu9M5NQNj8LIRK5UziWsEgs4JBpqCW9Vto0R1iGH+Ho/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ydEXbr9x8ZuTafLx+erZr0fdeJMO4d4mx6PvdAZ4/I=;
 b=SqO2RhB9qmThqki0Gi/i4CbORtL8jkweqTJZ3v3ON2nfCM8NateTVFR2F82jS2TtXf73M0unT189u8aMeysDircjhEKRuF//Z4mIs8W0Gc21t1+KQmfkmPspa9shpeifcXo/Zc/OjXDlBgjWPJrRjwU76IrwYQUh/zL1FnKWFJiAyebLE8a0LBsvgixafv/VnVjsDdHsQ4sLcDygMFzdIIalbpvYjozSzUQ9v7QVXm68a5+usFcfl79ynn+GHA5jTQpCQHdV1Xpxm7iH9zVrp55eYUuLrdQGLNHK/8dibGkPY07kLAACLRm6sJCanIcSQ0HGbrmAnZulQmZWYlrIaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ydEXbr9x8ZuTafLx+erZr0fdeJMO4d4mx6PvdAZ4/I=;
 b=RQU4y+yeAg7DjVQLFWSxDjFMHZtFIUTyMwaMMfMPjXzrIyXK5Tyx84OPz5uUuEZ6BHxMkRxjmJjRiIfPtsFYQpwcDyX5aBFwoeRuVDDNx25xEVo+uG+4tcusk8jbT1N0BmsbOI0+eWtqo8B1fZRA3N/f4J7lm4o5JwUSQssKG00=
Received: from LV5PR21MB4704.namprd21.prod.outlook.com (2603:10b6:408:307::7)
 by LV8PR21MB4339.namprd21.prod.outlook.com (2603:10b6:408:22f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.10; Tue, 1 Sep
 2026 18:11:54 +0000
Received: from LV5PR21MB4704.namprd21.prod.outlook.com
 ([fe80::144b:98da:1262:2ebb]) by LV5PR21MB4704.namprd21.prod.outlook.com
 ([fe80::144b:98da:1262:2ebb%3]) with mapi id 15.21.0406.000; Tue, 1 Sep 2026
 18:11:54 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Sahil Chandna <sahilchandna@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, Long Li <longli@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "ernis@linux.microsoft.com"
	<ernis@linux.microsoft.com>, "gargaditya@linux.microsoft.com"
	<gargaditya@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] net: mana: Reserve extra CQ slot for the fence completion
 CQE
Thread-Topic: [PATCH] net: mana: Reserve extra CQ slot for the fence
 completion CQE
Thread-Index: AQHdOgwNoo3Nb39+g02lJY1d6cZF4ba6BOKw
Date: Tue, 1 Sep 2026 18:11:54 +0000
Message-ID:
 <LV5PR21MB47045DFA54503C4517F65E74CAA82@LV5PR21MB4704.namprd21.prod.outlook.com>
References: <20260901121837.3503240-1-sahilchandna@linux.microsoft.com>
In-Reply-To: <20260901121837.3503240-1-sahilchandna@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=19898cca-d0e2-408e-a812-05231ea9925e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-01T18:05:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV5PR21MB4704:EE_|LV8PR21MB4339:EE_
x-ms-office365-filtering-correlation-id: 1fa0ba97-7f85-4b86-a43b-08df08548125
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|11063799006|10067099003|7146999003|56012099006|18002099003|22082099003|7053199004|38070700021|921020;
x-microsoft-antispam-message-info:
 5RCUxBEH6iiKzxlcgoZHjggntv3esa/PzivNYdXnza1oVcAnMSwnuhTOzGbEsfUo6Q8wLRxVH3iK6MFFvsknSdpPQ+mQkPnIKNcRkclWjBNSdVPVbABD4RaipMlVEf4RCIKjaJ6dax92j3nzJMe6zT+kurTMdrUuFUxtiMuFKjUPA73NiJaKbDslBKaVXeoSHmkNIcXhYK8w0Q9jM+M8ljewFbI8SJtTo7qLQfi5Fq0anqfWC5vm6K3DD4nIK9QfeYPvwa7fGI28kHJsf9niGS0UmN9e4RBtpqui4g/sQm8Y6vXMD4XeaI9iLVhKJ1Ot/ZbtWO72BPE/RxceNul1mc2cFfCGj35e5B04l+lkAS4RHpvvUKuE5NOYa/bgKANjk9khtXmYsmWrxYUECh8K/LfW20Xg5U45Tt6cXMQ0bVjm/GoJLkTlQISlkOCNLQFkwp2bu+OI0YngtZc0cTyXNT6mlbf62b7YGRUp8k50MKSWoYT8c7D9XQdY92vxqLtWoSFlHOSGS2l1xidAmbYyMI/q4wlvSqjViOEGUDy1+6OiBaDumjQKobs7GK06MNM5aTvh7+WPaPLy+gBnSg1ypOjC1GXCnChi7t162HhNsu44LzXp7VJNcxUS1aNwS52VzQOyT5mzyUQkBUz6/fKDUSzoVkSYF1Dt6lzETgXayDfFPvp4OfFXG/NpBRuyqe+ld8ZnqbxzH/xFow0JPB8NGNndLz1sdtjta3bZPOf6otR3JbCMg7iuADYGBIBbDJuG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR21MB4704.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(11063799006)(10067099003)(7146999003)(56012099006)(18002099003)(22082099003)(7053199004)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6lbw8b44FqE803wbU1GT10v1TII1Tt4AUBGExwQ3h5zqfePqhvqcFhhypX+W?=
 =?us-ascii?Q?SL0VSBouGKVHKNUPS1Y8k7qp6iHcWYWWX6GQVnLI/uutVxm2AllnYwQPNlsf?=
 =?us-ascii?Q?xEt/3AiU1rJX+WvLv97EZc0538udkbOINrvDfMnhKYD9Go3K0Og7NzaMbwq6?=
 =?us-ascii?Q?pagzeLrmlIoMcSSCNslklYkbjUWqyVnbNYZqAzYtKEMmA8WPDbOqjQEhdVbj?=
 =?us-ascii?Q?xud9sStpjZPtYBkTjuohE4B8pzrtojNu7Iaq10Z45L0SE8V3r3dDNkhICua9?=
 =?us-ascii?Q?yfhxCbp7LQpEVAzhDmr3dXdkXsN3XUEsD0j54gS6aaX28Pp94Eo6XmFJdrA5?=
 =?us-ascii?Q?iB/iojQftSIOwzW9m8ANzxcCG7HzROO46NB6EYT1tpXlkad98MdtxyAnAzVB?=
 =?us-ascii?Q?ATDxZif06xTvXGiyFuxGc0cvKhNYqJylJQ4hkDy5J57WBq1sqCTCBkhHyhrW?=
 =?us-ascii?Q?loz2yMnX5356iBOZAi3G0wE3SJDTA7JbDhHPmV23z449FM3Nv3ERw7rfNngo?=
 =?us-ascii?Q?DTjNIRo6e059G48Rk7JcaPLSkN4nP7C2QvvVNLWNvMUhwNbommuWH2vWUkAY?=
 =?us-ascii?Q?bAMcc6W9cssorO3iimT0OKSGjJHe5jhzA1dJkQXaj5UMbdYR8QS7xj9PCRN4?=
 =?us-ascii?Q?aZuCoKHcV8qxqWXVThJ2chHah2fR7o40GgLijjz44K4/seOZSwDBnsl/U/0i?=
 =?us-ascii?Q?Tn6IURYPN85Se7hWDT2IC8s8TGrGEw2zI/IbyhQSZo46o/1v2rmsoYM5nxJm?=
 =?us-ascii?Q?MELrHncVo75UkxWjQGG9Ijsv8N+mDr5UxysR+2cbiHIYDwOlwUrrfBRrxESd?=
 =?us-ascii?Q?IJNBGNRb2vG8E9SwTybvqMUh3O3IALzk1E0EdN+pnuk3hcIo1oKlAs3H5bAL?=
 =?us-ascii?Q?A8JRdPqMi7Fr1xMXOT7AC+24QPW3FEWfxrOaRo8Twa3RITsfW9/gDRRmsFHZ?=
 =?us-ascii?Q?pm2gIW0tIGfddhd1CMP0K8SiXu/Q1bUKmOuCQq7Zqe/tjFMN79GKLIDtROsT?=
 =?us-ascii?Q?PDrNtUm10tS+3dTSwgTHe4nwBz7dimWt672ITm8EYr5IcT1pPOjPnz1XN0qi?=
 =?us-ascii?Q?SjwT5aWdAel2VDofSirs0My6aTlQqzQKHz8kDYM2OxOWJCgyN6d+HMoiRU8W?=
 =?us-ascii?Q?pE2s5odQeGpDTfdud/NqHUpymSK6XjidSf0jRqOaz068g5i8nPDabrOfjzje?=
 =?us-ascii?Q?FJEfKUUAMGvnhpOhmUHANfh204NHuVzi7H421ZW1CfBRe8Vg/ae30UMsVspU?=
 =?us-ascii?Q?3WQFdd9NfzatmEBUG7GoXx9/g9h48H6fgdm7tKSR4z4Z9s3SBy+hRnt8bhbN?=
 =?us-ascii?Q?d9YNVRp87i2SCwrenFOIBJJYKPFmnZWQS3ONia/q7gEBjILRi7f7wPjahghK?=
 =?us-ascii?Q?yX0r05Dm6kvyfo41DibQq8pHesWyX6lQrptmpPK6ooL5dnAG1+m8BQz733Hu?=
 =?us-ascii?Q?q21UbuCkifojzshaHvHYvNla2e4WuxLM0+9ZQP67ogqycsSQu14EdvS5Mc1Y?=
 =?us-ascii?Q?fNFnkDd9GgryLrbhSs5ktZPE4as+gltNfequZ+0iRlPjjrlAbFjCfuTMz5YE?=
 =?us-ascii?Q?xi8erA7EapZoEEumYtFpYrWzZVaWT634aIaY3ElOattTsrNez8LAYi/MdSti?=
 =?us-ascii?Q?jK0Ikkh3AxV2RMH3Pl2yz2gM10lSkeCdC5oMhceLFmiADWJCStIU6Af3kybC?=
 =?us-ascii?Q?6G6g2NIcFHjb3RoAUzaJl74ZOf3+sunGnSf6lDV5WNKGpR4GJ0jPE7DgT3yg?=
 =?us-ascii?Q?9KfXC9yDJA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV5PR21MB4704.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa0ba97-7f85-4b86-a43b-08df08548125
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 18:11:54.6405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lTKeZVVN1SwAc+6ANagPtn0jCFFj+AzPdsG43W2b3/0SMEUMzdrldSViUMzLuj20j7lt4S2ZuiwUYaLpYxzO/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR21MB4339



> -----Original Message-----
> From: Sahil Chandna <sahilchandna@linux.microsoft.com>
> Sent: Tuesday, September 1, 2026 8:18 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <DECUI@microsoft.com>; Long Li <longli@microsoft.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; horms@kernel.org;
> ernis@linux.microsoft.com; gargaditya@linux.microsoft.com; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] net: mana: Reserve extra CQ slot for the fence completio=
n
> CQE
>=20
> The RX completion queue is sized to hold exactly one CQE per posted RX
> WQE.
> MANA_FENCE_RQ makes hardware post an additional CQE_RX_OBJECT_FENCE after
> the packet CQEs. The current sizing reserves no extra slot for it and in
> rare cases, CQ has no guaranteed slot for the fence CQE when it is full o=
f
> packet CQEs. This can lead to dropping the fence completion while the
> driver waits holding RTNL lock throughout the timeout duration.
> Reserve one extra CQE slot for CQE_RX_OBJECT_FENCE. mana_gd_alloc_memory(=
)
> requires queue_size to be a power-of-two and at least MANA_PAGE_SIZE;
> the reservation pushes cq_size past a power-of-two, so round up the CQ
> size
> in mana_create_rxq().
>=20
> Fixes: 6cc74443a773 ("net: mana: Add RX fencing")
> Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>

The code change looks good.
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

For bug fixes, please indicate "net" branch in the Subject, and add=20
Cc: stable@vger.kernel.org

Thanks,
- Haiyang

