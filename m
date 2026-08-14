Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023115.outbound.protection.outlook.com [52.101.83.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C2E476065;
	Fri, 14 Aug 2026 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722031; cv=fail; b=WfSpIBuK05x2c+H0zstXF1rHHRaoNljjWtXkCKvCX7BBLpdfcO3wJBG60A926zJnzGgeoNGSmyBtsQ6bM9mYcejxqXsuBEbM/doNbbzmr/DhWdUX9AfR44HqnOpPNf272qL15elvcGjCvFp2ceeFTn0PrUX0/mXsZRYfCTbWb9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722031; c=relaxed/simple;
	bh=JpOrdQCPr3GW0YGWHgnMosjtNuZ11iIa9x2BdA7YWxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jlyC48qIQjIDJJsJVme6i2W47yO4bGVzdH7V/QCX75+u0GYB9GrOjw++eQq0m4yzRuj3g/GQWRewXyJMvrON/KNLp4DsKV4t0tJRC05hvoAwWsNnIPt9vXSBrKJmLPF8FHWRkVbM0ndp29PcmfNXunxqfY5mBQ6ZVPggIwYkWy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nebius.com; spf=pass smtp.mailfrom=nebius.com; dkim=pass (2048-bit key) header.d=nebius.com header.i=@nebius.com header.b=SNaLLUv1; arc=fail smtp.client-ip=52.101.83.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nebius.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebius.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebius.com header.i=@nebius.com header.b="SNaLLUv1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItLLJmLAQN2RFhZxyflavewLa2wpptChVtTP4RYPpRPE/21qR5wlkrbOzvD7I+qqEY/iEPmcMu/+EBF7fT4zNyFhkg9VH7jYS84F67BSOxzkI/RfKYmAxt4FwIqZbg67VzSQoNZoiHr2xlR/xR+rZQeNbLP4CZBgQp+lWc3R9vxJFxQafVKfB3UeA0XnM0sFpRK6RVVJ/Ay2YIzxinS6zzD8TQczeOqi9R8flC836Kpflq+QPckD212K99jR81NtoC0588A+fudrQLEDYFbm/o/w9DBnw4gKrMGYYQLGuXM0uL0dGjw3Rj9QfHykJqawspsk/NAfcXjwMnTaRLJ3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEv+mk7AnsUPbqC+Y27BLHQk0KzNySzJR5QRi2cE2+4=;
 b=Jd1SJjZi5w/mkWzdRsVHvI6hc6gHzRrye7Zfp7keVjKzpxsQy/101pmhpYwEhpyqZ0aO/gJ/ecfGHVwLT5RpWcN9sMqmbkvNVMgPazyY3pgTw2gjNCWRRSxlIcAmXO2We0fT2Y82XojCNQtVHlOe/mPyzcmj6FElaKM8ZLgos/YHjLsUR/m2q4S5+IaNyQPNLjSWvn+HpqGDYIRgc/uEMljoSd/BcX2Hh38JHHaYiPfwN8fogXZ5Tf2hrTwTUZGyTaaoVgBK4U6NakCKCVpVynEU3nhp8p1HzDMBaZqdCZeRNJxQ5M14znk+IHaPUnichFQ/n8AlQ7RPfq8o8BKK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEv+mk7AnsUPbqC+Y27BLHQk0KzNySzJR5QRi2cE2+4=;
 b=SNaLLUv12EYcfHjLDSikQJFuiSInWvoO37SesmT2KQk58MdIh0xUX/NO/JumqmHHvlF1fUo+dKlBi1mEcRvnpw6DmQNz52jyfEyjxldQGP4WXs6OyEEfI8rSOzUbkDYcVTDG7i3AbPJpOvP2bpmcBNPpV9S3hoPO1xqQ2H7QcJFL3tpgSjph+jyuJwVKpqbbWm9cTL6Dp98kiGeifjZsHejXGHLIEqSuCJWZZYoRiFoGoSjJmb5u0AEvTrMrILSHXyygnwsaWGO24G51VErbNyI4UrzGIveLHixOQYWjdTE7lP8A5XISzqSv4zRqda7GLI1ZAXr79UXHDDRBxn0S6w==
Received: from PA1P190MB2557.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:4fb::18)
 by GVXP190MB2664.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:322::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 15:40:24 +0000
Received: from PA1P190MB2557.EURP190.PROD.OUTLOOK.COM
 ([fe80::d0eb:eb62:7779:c6f0]) by PA1P190MB2557.EURP190.PROD.OUTLOOK.COM
 ([fe80::d0eb:eb62:7779:c6f0%5]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 15:40:24 +0000
From: Dmitry Malkin <dma@nebius.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg
 Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, NB-Core Team <NB-CoreTeam@nebius.com>
Subject: Re: [RFC PATCH] iommu/arm-smmu-v3: Allow nested attach for PCI
 bridges without vDEVICE
Thread-Topic: [RFC PATCH] iommu/arm-smmu-v3: Allow nested attach for PCI
 bridges without vDEVICE
Thread-Index: AQHdK9Pu+fg3Gt/XVU6V74nnaDIiLLadlyOAgAAWewc=
Date: Fri, 14 Aug 2026 15:40:23 +0000
Message-ID:
 <PA1P190MB2557C62960471C0FD212D2F1DBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
References:
 <PA1P190MB25578C482C8A3B06A4DCC6FDDBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <an8jEbT9pAUYfsvR@google.com>
In-Reply-To: <an8jEbT9pAUYfsvR@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nebius.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA1P190MB2557:EE_|GVXP190MB2664:EE_
x-ms-office365-filtering-correlation-id: d2c4a5d7-b1ea-4e1f-de59-08defa1a5b42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10070799003|38070700021|10067099003|5023799004|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 qe9iAdmuFd5wqCjIDNZkjiXUc9w9mc6Fr+Jf/2tAXW2GqSIQYygZw2QHQWPWCmq71/473j9rRzkKrtsEci+YaY1Cc3w1cuTetIucjZA0Iohll5iCGRRzRT1/qas66VHyfg7Oh3wRJaaM6Fu1PV42fWysbZlp4ujVgZOoYQ0cK2VuHdVsA5iAOgxkqiDey0ASPj02q4rUtXzAcs0/vsaF33Pmut576J481CGsW9aQPTVJFUjXZahYNwLk5Pr0vSybZRGYz1BbPV80NmyVXH9AP7Qi+IxlRoHp8ro/PA60tZzd4a9ZMEQ3oyVyOeA3JhRe7HdMDfHyE5MxmWWBn9ypvITwH05l51XH84ZNZbRggqn3xmw1HVD511VREOAL8JaJe1l529G/3y9jpUjre7Xvj1RLy5Wnme8VyHMe2cxmcpTMvlYFibULiKQKMaytErCvK9f7NLZEYtUBzqW0tqqK8t6KARMYsUCwOQQ+Qz26asnS3KlinBvref9d2ms+iN6ejXB3T7t1TZSrJhkaXNQkPADJ1CKuCY6ctBp26GOwyKp3CVlO3IT/BcyN0VO5a/MHSYEaVyfjRIfyL0f549vwDGVllMsfq2s9CoGA1sAjEQeQ3G2nVu0muSAwuTg5C/ZnqnWjBzliX/ZTLnmROoF9fdgtpB7Bb19a3g8sG7877Ag+d8YL+rJTCEm3DTXlv63ZGwEZDPegugF5WnERSaLJ72ZPxG4gF9C46ghepKnGMA4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1P190MB2557.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10070799003)(38070700021)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8gaYLlz4ZGYiSIz3ieaPGviFqp1IgWhDGbhYzlEXO2lXWx9Gs6EszU+Rvf?=
 =?iso-8859-1?Q?NloAht+GUu4Ww3CBZZjxA1LwbwxRvLMyZ/GqaO8yBbDhZEQsAGymdOPlXV?=
 =?iso-8859-1?Q?CTPoYyerOF+M0RtPvqD8oMUKKjrQ+KHnYFXWJfhb87AWrWIsJrdIJrFK2r?=
 =?iso-8859-1?Q?BQM+aHswHxw3kzxxuX7+Gs7wImwGEEdIZ0cCGd1bvQf7boAQQuF07e1buT?=
 =?iso-8859-1?Q?cd+itaG0UdyXXyZgfepnwv8Ql9WSmbaGTCM/E5oKtS4gsqENyDIYicX3xz?=
 =?iso-8859-1?Q?dFydNMHssipoSfmfLlLdyfXqwwyzCeWn8lWOCYQamv81ZVM50cS+NqenCu?=
 =?iso-8859-1?Q?cNl86gSXqIm4w1HxvhSDXjWXa+WV8SMvd/Vwnppuad8+LQBetAJNxou+iq?=
 =?iso-8859-1?Q?aqhplsa/VMVkojrlM+OiCQP40Kr8nwu0s7QG97FfjeOIjGwtz+vBqe/J0N?=
 =?iso-8859-1?Q?IOzjkXlAADMIoS8uIaEpbNNwqggWD0GvHd7iTXiHPWN5yUseeVU6d8IOl2?=
 =?iso-8859-1?Q?CsnNChz3HOhYTdvsyf2fbiVbi9voaQ63ZqNqjxIjr5SLHukxIe8CiglGRT?=
 =?iso-8859-1?Q?i8Nzrcnn8EMtNN23VydFWsYjPurBcNjcBg/foQs/bbzQQw9STlszpXvc1w?=
 =?iso-8859-1?Q?Cp9HGDBlTY/S9yAczTUysd1bBenVFG3sUV6Cymeye84/FVSJrDcOEjO5tj?=
 =?iso-8859-1?Q?GVtBFPSXCEvNXdJUGGLiS7zkR7MLOL27Hbb5o3yMVIl4CGr0ksiszteXxf?=
 =?iso-8859-1?Q?wjOkpHsIs0/LirwxoKpke9c4EuZ/0yvGvIYyUZWzyhp3dYuBBL7XLdP/Yj?=
 =?iso-8859-1?Q?sbOIwAbfhAyhnh4Es7sZUSwp/UvaHJy7CknTrLIdbQU0xWq1g3v3J4xXc4?=
 =?iso-8859-1?Q?xXZF6iyTSMKlHjM+Bo91npqX00nPUv18xGJ54jEatuVm0W1Bi84VZ1rqvu?=
 =?iso-8859-1?Q?iBdmKqX+DU51U3ICx7YkDiV8HL83O4jYhDX7bZhpwLU8Iboro/MG7rZalZ?=
 =?iso-8859-1?Q?ckah8aeCTUMvMQ5R3LyrWR+kcqtQxYoDqFBs34vNhZJMlJ2RIEexhwNylq?=
 =?iso-8859-1?Q?ydtgOw+vIhdcqmmkNNnGyWX1+TBTNKgrlAYVB0BE8MMQJaonz/xNwiUFLT?=
 =?iso-8859-1?Q?9cr8pLZ4xIILetHoV/Lb+6tQTqNo6XuXPw0SDKz2HJBfGrYiwK6W8dX2i1?=
 =?iso-8859-1?Q?SSoD+Kk7Se0zco6Jbnz3MFwjx9i/l1N+SZzPoK7+IbC/ru/bfYDgYkdne9?=
 =?iso-8859-1?Q?PDFJXfCs3aj8V61ftYosSOKVn7gW92l+PyKtT34KWkh6hzeWdcalH3FWm/?=
 =?iso-8859-1?Q?QR67ulaySGHSnjsIes8VAV32famPqYAVr1Im5QLnTblQTRYKnnIy0dYMSV?=
 =?iso-8859-1?Q?SsQg+IgrYoHhD2yeVCrk6EptonKsSVfRsR1mG0/WnWenTo34XWOOrSvZr0?=
 =?iso-8859-1?Q?HiYlZ9SMT+0fN+tDWrzi/RWGD0HnvEanFO37rvOm6afPwXI9tIVhuQTJ8u?=
 =?iso-8859-1?Q?ThMuAeTUqNBbvUU/t8ipMIWLYz4IqO/VYHU6YNDjOImPz+dDUnt3n2yclX?=
 =?iso-8859-1?Q?WhZjxNBOtvZrw+VloxdRllPP4WxCXotvZQKGZAlRxdBah2iFDh19Lls5er?=
 =?iso-8859-1?Q?ShgAo0SPZ/TDF6XSCAGJq7yLSEx2yYrPFLX8x94fX0689eoCVCvIX6LPG2?=
 =?iso-8859-1?Q?TxYSj5V3Vf4wY/4A8yP1wybQWHxiTS4KHRhF/GF46O1PsYzRIeecfy4ItD?=
 =?iso-8859-1?Q?chKdtHi48Rdg8G92KZ/mo7ah0uMKHyMpTiBJwsjH9y7TgmvtK507egmDim?=
 =?iso-8859-1?Q?vombWcsiZC01P39XVpH1J8OLAaSAKYaYdnHU8j2M9uGwmvbeQT1B?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA1P190MB2557.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c4a5d7-b1ea-4e1f-de59-08defa1a5b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 15:40:23.9807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+vQgrASQu6qoWoyA7rbVrmzhl5V69JZgIGMo2BLFzl9u7x1N36pZG/SdY8HbYtq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB2664

Hi Praan,=0A=
=0A=
> I agree that this is needed for old bridges. However, should this check=
=0A=
> actually live higher up in IOMMUFD? Instead of the SMMU driver deciding=
=0A=
> to bypass the error, what if iommufd itself intercepts the vDEVICE=0A=
> mapping failure during the group iteration? If IOMMUFD sees that the=0A=
> device lacking a vDEVICE is an IOMMU group alias/bridge, it could=0A=
> explicitly tell the underlying driver to proceed with a NULL vmaster?=0A=
>=0A=
> Also, regarding RID aliasing: while it's true the host bridge doesn't=0A=
> need a vDEVICE for its own host-consumed DMAs (like AER/PME), are we=0A=
> confident this won't break guest-injected events if the bridge aliases=0A=
> the downstream endpoint's traffic? For e.g. if the "real" endpoint's=0A=
> traffic is aliased to the bridge's RID and the bridge has no vmaster,=0A=
> won't we lose the ability to inject IO Page faults into the guest?=0A=
=0A=
Thanks, both points make sense.=0A=
=0A=
IOMMUFD currently cannot handle this alone. It calls=0A=
iommu_replace_group_handle(), while the generic IOMMU core performs the=0A=
per-device iteration. IOMMUFD receives only the final error and cannot=0A=
tell attach_dev() to proceed with a NULL driver-private vmaster for a=0A=
specific device without a generic API change.=0A=
=0A=
For the bridge case, I suggest limiting the exception to PCIe port types=0A=
that pci_for_each_dma_alias() explicitly skips, avoiding bridges that may=
=0A=
alias a downstream RID:=0A=
=0A=
static bool arm_smmu_is_nonaliasing_pcie_port(struct device *dev)=0A=
{=0A=
	struct pci_dev *pdev;=0A=
=0A=
	if (!dev_is_pci(dev))=0A=
		return false;=0A=
=0A=
	pdev =3D to_pci_dev(dev);=0A=
	if (!pci_is_bridge(pdev) || !pci_is_pcie(pdev))=0A=
		return false;=0A=
=0A=
	switch (pci_pcie_type(pdev)) {=0A=
	case PCI_EXP_TYPE_ROOT_PORT:=0A=
	case PCI_EXP_TYPE_UPSTREAM:=0A=
	case PCI_EXP_TYPE_DOWNSTREAM:=0A=
		return true;=0A=
	default:=0A=
		return false;=0A=
	}=0A=
}=0A=
=0A=
Thanks,=0A=
Dmitry=
