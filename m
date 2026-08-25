Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2654A23EA84;
	Tue, 25 Aug 2026 06:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787639019; cv=fail; b=TkajDzpu9FNN+sbrAE2uTp7UPZHl2x37UVuiAEiNhAND9OfM0pF6HgpbJGMn90+SZ8hPWNpKfT2XFZr3O59UE30raLy36ruvUmgArnHuS7OIYhWgB1xcwPveEfAsjy+VO3mWJKuyfIJpOjvrgiOGIY27lsFpBj6ui6zkI3bXhqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787639019; c=relaxed/simple;
	bh=und0bvYe5JhwxLelzNmVgwoba2XEDB7tFQyaO419pZ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gX70WLo9L/qJ8LUSkname6MAldz/Uwwx1DRGXSoucf65MXgsdvJBduIno4/pr7lHgaiSHTVVD9BfNJiwNgC4f25sGM2poljvngjcT4ASTs/G46wAhAS8c+obXrgVx3pU7SiRmQ/ldKO2lFgFRwWAp1PSc0OxHXE4wQMxU9Mlk/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UextFHUz; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ctdzoQtV; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UextFHUz";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ctdzoQtV"
X-UUID: 7d2373baa04d11f18dc8c9802ae25ab1-20260825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=und0bvYe5JhwxLelzNmVgwoba2XEDB7tFQyaO419pZ4=;
	b=UextFHUzde1llN3zpdxteavsqCZDI3Pr6//oCdeN1iATlrBEDm45O/Kg5ZVFQa8D+ZfH96AbtYHtA5Qbojscb/kjMpIMyY3urbwyp9CGy8eA5NR7SikILZOKuhqEkzyhVAmrinUmRC7ll6JoW1dlY/C1bUgMfBroAJ2/Zw5GFcg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ce1420f0-2c55-4191-846d-bcd294786566,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:54afd5e2-71f1-405e-92eb-6802d6af74fd,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
	1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7d2373baa04d11f18dc8c9802ae25ab1-20260825
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1658101726; Tue, 25 Aug 2026 14:23:29 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Aug 2026 14:23:28 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 25 Aug 2026 14:23:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0KAussUrpI+uWUODTGPLCl1aDiWEK35W4t7BbckoVajS2W/4W7EsP7idUR48NaeGfnuNtnzJHbrM2Q/Q172MEzdeLh9kIlcvyJgeXvaXJMJhMVy3aUzhuUOlELUtHgPoLrap4GMIzrRiCoPXBqbiKs4Jk+mhgWFI0MQqWPDHfNRunD4OAPUAcfAL8x9qHpvNqNDQJOHZAsQ24hRf+aCOFlWiBfPNg7tkzuBs16vnDkChqIuAMWuCdl8FViAjQfr/p5CtY27mQdyP/5EzGBwGmVCaNX8Xt9aasRgn5jlCL3GKMW5sPS3sOw2nvhUNzhqo9djAVL3ERwRPYc+bd4UiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=und0bvYe5JhwxLelzNmVgwoba2XEDB7tFQyaO419pZ4=;
 b=cV/I/StGIPE3OtEsI7+hL7SnW+Jp19/Lg/SYcpjqqIMIF4QsvnL6L1gr/HeIZYngdIKNWH+IjsiP1QDFzdz2/eQDyKtxvlku39mkdMo9NHq3TE4k2IV0KZ5XA+DcdADSiuEJUHZnRBgQ9n/8DkkHkr+4m7rnkZGy6mb+p/M7+IJPMozeP8+cNh928hV3dvPYCb7zulLY3iihqt5MwSDPm1cBljQblPPG552a0xt4kq+EfVWkiXaO1l+ZDKcmDvZOvWsUexbCJcuQcqlwuipjfSnt7gP52AtFeHmWakuOzT+ltXU6VFMAHAeqPW0xtSjF+OkqWPxJvtfcV3ZuacFIVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=und0bvYe5JhwxLelzNmVgwoba2XEDB7tFQyaO419pZ4=;
 b=ctdzoQtVGiYWBIjvi1AxbBwYQzhsZvvlSXJYfisUGbxjwOnASbJOKWzncs3n15tzAYAkSeLyA4s+300Fu3YgkDu3WPjhghmMJ4G0z5W6S7lE7F4j6imK1vEqT8kKcjH+CaloDXTaa6XMxEngMn9+Chyguhs84MVM4B8zXRnQdxw=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB8234.apcprd03.prod.outlook.com (2603:1096:990:45::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 06:23:26 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 06:23:26 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "lihaojie@kylinos.cn"
	<lihaojie@kylinos.cn>, "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/mediatek: Add missing IS_ERR check for ovl_adaptor
 platform device
Thread-Topic: [PATCH] drm/mediatek: Add missing IS_ERR check for ovl_adaptor
 platform device
Thread-Index: AQHdL6gJRf8cmMG2AkW5T6cT7073HrauVSiA
Date: Tue, 25 Aug 2026 06:23:26 +0000
Message-ID: <7a3cbf55bf6a97835ee426eb38c34b2c153437eb.camel@mediatek.com>
References: <20260819065642.136222-1-lihaojie@kylinos.cn>
In-Reply-To: <20260819065642.136222-1-lihaojie@kylinos.cn>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB8234:EE_
x-ms-office365-filtering-correlation-id: 037a7057-c234-42ac-9c66-08df02715f36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|42112799006|376014|366016|1800799024|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: VFPurN9lx4s77MKVmHCTgWwzMUEPiN7MTZW9B8VGGpX2DLyExBlHWQgK/GiUYMCeIneAi/VcBD5T21IWQq+1XFPwcEVJKMDXg31GHaDBovI2jcJmxSjG8h89gUEk5TuAe2pFeLv3p9hW8rM5Q/S6BQY3Axpcljcu8SG7f5e9L/KWxg6REyIM0oHk4kz8aCtZhhoB4SY9J+FsnN2zejVk8yrCTmiu6+PleXvKn1OcUTFDs/11eIVcum5Ix0trv13SrQqTLaJ5edZQKxdWVY11PDhhnxo2CQfLFpetqRSH+uN4jN6EsJa+7kp6F+MjhX/7CL81sUR7EVGaI3Rp7HL2ha1NYdLm+vNcBTIXQujOpviweWCp5Yehay8BHEsRKzM8kboGIb6v/C2QDia4WxBWx0gZpE+4PiqX+UMHOq4xDJaIrnUOfV2Y1CF3ZbOeRbAs+xOLu1dnzCX1hQ2X2n9hPnjylbtFUiUSQbmpmNtm4bY7KN2ll4lxSdNebd0tBC3E4SE29TCLW+NtvFoNiSFVw+b+fKC1hlgNmx1wSxw3gSTigOwQQq3ETE0UGV0P+0cUacDFcZgMvj029NSFTiNZZ1dc52VycVzMV3tkGO7o++hHgXmlm1Qu4T0FdFt6+iQQOuF7BMrSbY3Azicb5n2jFhu1nOMVrcIexWgt/+zNN7KSR02hsso/LAKEHntiIUxrvLdfhjqI0RKNIEScylFvfgto6AVfAnL5dP3ehK0GUy8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(42112799006)(376014)(366016)(1800799024)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkJXK3RBSlFpaTZOMTZWQUd3K3B6NFNGUUJHaEJnTVFIU3lKSU4yNGUvdm1k?=
 =?utf-8?B?ckt5TElPNmIya0FvNXJ6WjUxTU80K1hZL0N2RWlYTE13SDg3WWZycm9kZDRY?=
 =?utf-8?B?ZCtqRmIxaGFRWHkxa0E4VFZKVEJsS1c3b0tvVFplYVhZNkVxakxBVHBMc2Zn?=
 =?utf-8?B?eGxCVXJoSlZMTTZJWjIySXVtc1F0QmxzQWZFUWdPRlA5OHdWdSs3N1FPN1Iw?=
 =?utf-8?B?LzBqZVZRV3NVTjZUSEVudFpKSThqNnE4RXYwVGNzeklFRnRvUFlkRXF6NVly?=
 =?utf-8?B?dDV0UWI1UjVQV1FDbXo0OStIVzdvbWZRZi8zbDBrakNpaExOMUwwdng4bWtu?=
 =?utf-8?B?Rmdhb2h3N0Zobmlnc3c2NTdtdjY0MWp2N1J4VVBmem80eDVFemVYaytTNC9I?=
 =?utf-8?B?KzVXMEpCRlJna25FcGczM01qNVBmdHIrRkswRGhGSkdiZ1NBWm85TGxaaGtM?=
 =?utf-8?B?YlZsUVZDNXRaSGRxdkF1SnFYNVNHcFF3WmFDcHppMlRuZVFWdnNnSG9vanAy?=
 =?utf-8?B?Wlo1TkxMUm1MT1ZmSytNMHUyRnBuRzYrKzlhZDAwbFZ0bHExR3pNVG1qWjNW?=
 =?utf-8?B?TkRPcmRMY0NRYk1KaW5DS1hHQ2JtcTE5elNWbndJMElUOHhkSnBRVGRCR3A2?=
 =?utf-8?B?eHhpVFB0b2k2OGVoUVNsL2JvdExUMXc0ME5ZS1dGNVFCVnFjQU9jM0d4d3h6?=
 =?utf-8?B?L0lsY1lXZUpETWI3NlBtbW9halJQaDBWTEMyLzBySmpZMGNXcml4OHpxMVY5?=
 =?utf-8?B?aHo3dmt2YXV0WXIwSUh0eEZoR2hhWnVONEFvbTI4dnNsbzJ6US9tY3EweFNH?=
 =?utf-8?B?eGhjaE8ySTh1QXM3Y0RLQmFjVEZJclM2Vk5rdzZWYzAvUklhc2tyWjEvRnBJ?=
 =?utf-8?B?MllvaFJTWEMrc0lDaTBlZGx6aVlLK3ZjYXdkRENEeVJMeWRXZ2p6WDZWc1Zz?=
 =?utf-8?B?aWdVeHdzekplQTdEUDltaEN3LytlNzVEM0NIa2NJdUJQU0RNZUhzRkIrVjdL?=
 =?utf-8?B?Z3BPbnNtOHQ0OW5NMXBFa2dVMFhXMk9RbWs2Y0VlRUZ3THQ1ZTZlSnlTbTBM?=
 =?utf-8?B?Uzl5Y0poZHZHM0RJQkRHQTBOQ3JWQ2owR0U4TDNUcFdxN2cwdFVxemFaQVJT?=
 =?utf-8?B?MmpKU1Z2OXpCNVd2VUFVdCtTb3ZoTGZCN1V0N0laaE1ucjkvQXNKS0hnbElO?=
 =?utf-8?B?UnFkMWlUelUvMnNpcmtGTytDR3NwMHFsbWN5d2tIU01FRXg1aEFIa09HaU02?=
 =?utf-8?B?NW4wUHpidENIaWZwNkFVdHNZVUZZRlBNWFJvSUdYNjNQSStFNFBSQmNLOElk?=
 =?utf-8?B?OTJLRlQyb2FGaFVQdGpXRHBoRWJ2NWtUU2s1YUlrcHIzMmdTZlJER3FXdXBr?=
 =?utf-8?B?eEpqT2NUK2ZBbXN2TzMzTkhjdkJrRVhSTVpRTHB5dHRjQkowM0l0dTJJVDlI?=
 =?utf-8?B?cXE4SkxkU2pKeFY5a09pRVBaZU8zelc2MDVKeDhlaFgxWGdmempFU2Fqampo?=
 =?utf-8?B?TzF4alBoV3dHZ1ZXUlAvUmJNUUljcUc1UTBpZ0tCOEVNdDdjV2thVkl4SmU3?=
 =?utf-8?B?TGtzQW9DN2tBMjR5dW5tYjRWNjlBRkdmbXBZUDZtUk9sMkIvUlMrWWJNR1VU?=
 =?utf-8?B?RVI1T2NhRVd0Q1ZsNzBWUWVzTlU4OXlTVG00Qmo1L3d5a0hRaTYvd09SZVJ6?=
 =?utf-8?B?V3c0eld5SVFHVElFaHkzQzhsc3dvRURSczZuS2xYaU1RclplUkpmcW96MHdC?=
 =?utf-8?B?MHczWENPc1lnSUc3b3VpcEFmT0dXY2NGWklrOUZCSUZzVE5YN2V1Q2NIdm1Z?=
 =?utf-8?B?blBIT2ViRDQ3NVZvNFlwV2xEMU04V0ZzVW1YcWdrSmR1UVU2NG1BandFZ0VH?=
 =?utf-8?B?MkFoeVczWnJFc2ZBdi9tT0NSUTlrU1ZkT2pLa1FqajNrNEF2N2tMWXdDblJF?=
 =?utf-8?B?T3dqTG1zajUveVpOVm42dEtab2Q2UStuVEgxaUVwd3lxS1drWk4vRDhuK3ph?=
 =?utf-8?B?Q2lnOFh0THVtRWV4WFJDd2JOZkhjYkk0N2JkZDdUMllWaUlWMi82RHZibG9X?=
 =?utf-8?B?MzkyTUN6SWt6SEVqcjlDSUFrY1hkWFJ1SENnSU8wbG5vZUNKKzlzaUxMOVVq?=
 =?utf-8?B?V1d5T29HR0M3ZFh3bUtzRlVBUkxFQ2YvdzV6Tjk0QnNMa1F1QXpINzBPWXZN?=
 =?utf-8?B?aXZWb3FHOHZTM3FkUWJ6Mktha3hQZzhiTkZLN0VPQTZZMEZYcnJKd1dhWU05?=
 =?utf-8?B?dE9TWEJYYmtkOURGZVgrU0oyMHF5OFFiZXNzckEzSlhGVWFjd29qQnp3NUZY?=
 =?utf-8?B?MlRLS0t0MUgxaGRNQzZVbXl1eDU3dHArRzBZVkFmNDgzOFFLd2o1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <674710B835E9004E9D8D1FDEEE3F44C2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: djVrljv28szV7C1h+PV1+NbtPcuBG0rNV1McExqhuzgWhDs2WwdeCzunBrc4uJbWilCMZEruXiYYcjAjbs+XcVrYrLR/Djtlpfe6G5HFEqOaVri8xZzmfgoYos08axqZhzj9ndDhyg4Rt2V3XUp/YeT0zKGjXsjOcoSwJ+cRt39yt0ef3q+w2XWuPl5GSM8PL7eLhCMR4Yq4bH8inPYI0B5tYKfXbN0DqjCXWoewXhWB56uGVBeCpTosTyfN19AfDSjM8MCvUBEla4aZ1UiJ7WsW6ApH56xYLqoj9MY9N3lBxd5x425TUTDyy4yNSbw0X5oVb5Oh5uXHkzPf3MArFw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037a7057-c234-42ac-9c66-08df02715f36
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 06:23:26.1519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9wHxXwKixiZcAIknZNt4XF3q/tpEaQDyY5PaC9No0rmOT0oXtR4QVlGxqZF5B1JWF3LP4uovP4j6A4zt/WBEsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8234
X-MTK: N

SGksIEhhb2ppZToNCg0KT24gV2VkLCAyMDI2LTA4LTE5IGF0IDE0OjU2ICswODAwLCBIYW9qaWUg
TGkgd3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+IA0KPiANCj4gcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyX2RhdGEoKSBj
YW4gZmFpbCBhbmQgcmV0dXJuIGFuIEVSUl9QVFIsIGJ1dCB0aGUNCj4gcmV0dXJuIHZhbHVlIGlz
IHVzZWQgd2l0aG91dCBjaGVja2luZywgbGVhZGluZyB0byBhbiBpbnZhbGlkIHBvaW50ZXINCj4g
YmVpbmcgc3RvcmVkIGluIGRkcF9jb21wW10uZGV2IGFuZCBwYXNzZWQgdG8gY29tcG9uZW50X21h
dGNoX2FkZCgpIGFuZA0KPiBtdGtfZGRwX2NvbXBfaW5pdCgpLCB3aGljaCBjb3VsZCByZXN1bHQg
aW4gYSBrZXJuZWwgY3Jhc2guDQo+IA0KPiBBZGQgYW4gSVNfRVJSKCkgY2hlY2sgdG8ganVtcCB0
byB0aGUgZXJyb3IgaGFuZGxpbmcgcGF0aCBvbiBmYWlsdXJlLg0KPiANCj4gRml4ZXM6IDBkOWVl
ZTkxMThiNyAoImRybS9tZWRpYXRlazogQWRkIGRybSBvdmxfYWRhcHRvciBzdWIgZHJpdmVyIGZv
ciBNVDgxOTUiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5
OiBIYW9qaWUgTGkgPGxpaGFvamllQGt5bGlub3MuY24+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMgfCA0ICsrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9kcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5j
DQo+IGluZGV4IGM4NmEzZjU0ZjM1Yi4uNjY3ZDdmZGJmYmFjIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiBAQCAtMTExMiw2ICsxMTEyLDEwIEBAIHN0YXRp
YyBpbnQgbXRrX2RybV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQ
TEFURk9STV9ERVZJRF9BVVRPLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAodm9pZCAqKXByaXZhdGUtPm1tc3lzX2RldiwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc2l6ZW9mKCpwcml2YXRlLT5tbXN5c19kZXYpKTsNCj4gKyAgICAgICAgICAgICAgIGlmIChJ
U19FUlIob3ZsX2FkYXB0b3IpKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IFBU
Ul9FUlIob3ZsX2FkYXB0b3IpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9u
b2RlOw0KDQpyZXR1cm4gUFRSX0VSUihvdmxfYWRhcHRvcik7DQoNClJlZ2FyZHMsDQpDSw0KDQo+
ICsgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAgICBwcml2YXRlLT5kZHBfY29tcFtE
RFBfQ09NUE9ORU5UX0RSTV9PVkxfQURBUFRPUl0uZGV2ID0gJm92bF9hZGFwdG9yLT5kZXY7DQo+
ICAgICAgICAgICAgICAgICBtdGtfZGRwX2NvbXBfaW5pdChkZXYsIE5VTEwsICZwcml2YXRlLT5k
ZHBfY29tcFtERFBfQ09NUE9ORU5UX0RSTV9PVkxfQURBUFRPUl0sDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBERFBfQ09NUE9ORU5UX0RSTV9PVkxfQURBUFRPUik7DQo+IC0t
DQo+IDIuMjUuMQ0KPiANCj4gDQoNCg==
