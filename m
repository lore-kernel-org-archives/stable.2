Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1553AE198;
	Wed,  8 Jul 2026 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474891; cv=fail; b=P82iIxHe7GahXVdm0U6VX038xP2zhb60Zhf8r4fyP/xIeZVhU+jeLbtD8l+nHoThkkb8oJXynp0AsA7xHo/lbgHbS8E+8Miz42l6W8pCl/x/OxJVWySRxUtAOG29hfgqgBtjHYYlOZRLfSgwMZD0pZGjE8kSSeYefaVtoAAbuSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474891; c=relaxed/simple;
	bh=Loux14GI6e3N0Yi0K/eLeh7GB8ScAuzLl/ZZdFfzrdM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gl3bUuUtvehQ79xx/OW8D6rwqFmhCcBe/IHCKxYFcSZFZscIKznZUj3mrEm66WCJgVctxX5npd2tBiSAvV+aZ+Cx1SRmq2qbjaiYtLUVrn3Dwrvu5Bnrnlgq+0xEkr4++Qbobyhnws0oyIPqjzIJAXKo9ZILuSySX0JGMo7EGRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JKqOix/P; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=LXR1W4kd; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JKqOix/P";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="LXR1W4kd"
X-UUID: 1d1228047a6e11f1b1788b6acf885367-20260708
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Loux14GI6e3N0Yi0K/eLeh7GB8ScAuzLl/ZZdFfzrdM=;
	b=JKqOix/Pew/NQh4mR81f1tK9UHBRtbOD+7Pw69DAbwbRyopTbTBXUgs1JKveOIgSFSY/BSOmZEzsAWUX+sPiU4UhSm0YzYl2zm3h6NcOfvsTLgcOwKrt8c8yWXwCY0GVqjpxe9/nZdCuKKnQCvr6+1dZuLCBBKidRrPznt5d4qE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:01e9e8ee-7aeb-4f8e-b5cd-3fa4f39cd6b5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:ecdcf6d6-4504-45e1-b7e4-0b9331be048a,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
	1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1d1228047a6e11f1b1788b6acf885367-20260708
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1363356509; Wed, 08 Jul 2026 09:41:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 8 Jul 2026 09:41:17 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 8 Jul 2026 09:41:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlemTkNelAri5OGTgo4m5vzwhCEdD9NJRQQFvpSsq4tg4aeABo3en5Tm2tPopY3yxHnRlyN0IZFGhXa72JUKxgJhJMdZ9v5y7NpOlSsrwYS7RADrYjXtm2DC/X9eA5XbFH2PmFA7hnKoN4RgjsUj8JUur0fmzpta1w8+1gvHHDcnhpb8av77eOcUE8tm5D5LNsgfhNeLwL8AwLSopO5Oo2shdmQvkFRzjW4vxlAHj2jJuQ7giVmdZ3jjfYEE+Oh4UZ7IrNneZ/QfX4chfHxcDrlSH6eWP3EhsfGmzV08/bLD/7XdYmcjeouHF/2HZtEHlzrpSA3ZzEXnca7glwioWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Loux14GI6e3N0Yi0K/eLeh7GB8ScAuzLl/ZZdFfzrdM=;
 b=xDWFCPhcoGWF8vQ5sSRy8i3o8jbftdhJNq6VjRjYgKKyjgVuGdUiJTJ0GJ/jBNBVCwYz5QoKxVHF99AW/vYk3NJVF1iAixx2dndl3Vl+9MKgOvdUX2zlLgtBsUvzvLtdKXi3UPM2xAoSoPG8e3mAbDSDVnEccZKCiJd430y7DiR8Z7nQFixU69OaTuzZFrdwXqmBYnReXabRW++kwLIeaP8j9qBGP9ar7jlTtn9mCX9FyFERKti70xuHRtT+Hpq/1Arbjs1/fORpsmE+VXXE9td2eiB3pCBYSNdwpEZlp3rXyfJaULIlQWdGfoeKGE75qj8tpak7hVrC///JWAmp3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Loux14GI6e3N0Yi0K/eLeh7GB8ScAuzLl/ZZdFfzrdM=;
 b=LXR1W4kd9iczDaxQ06MdGfr35QW/PqtgaHEXrClmxRwIAjWezSE0giTheKJxnRsJsTm5MXwwh9OM4Dxu/u0302lrLExXDIaJ2lXQHji89X03ZFMuGMwNSevmx+JXf4Rao1SiimWjSGkLj7m6cRjO+xABg/6PmPatiAHk/IvX3Ro=
Received: from PSAPR03MB5622.apcprd03.prod.outlook.com (2603:1096:301:62::11)
 by PUZPR03MB6886.apcprd03.prod.outlook.com (2603:1096:301:102::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 01:41:12 +0000
Received: from PSAPR03MB5622.apcprd03.prod.outlook.com
 ([fe80::b639:3572:f154:28d0]) by PSAPR03MB5622.apcprd03.prod.outlook.com
 ([fe80::b639:3572:f154:28d0%4]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 01:41:12 +0000
From: =?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "imv4bel@gmail.com"
	<imv4bel@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "alice@isovalent.com"
	<alice@isovalent.com>, "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
	"eilaimemedsnaimel@gmail.com" <eilaimemedsnaimel@gmail.com>, "nbd@nbd.name"
	<nbd@nbd.name>, "horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"willemb@google.com" <willemb@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"sd@queasysnail.net" <sd@queasysnail.net>
CC: "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	=?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
Subject: Re: [PATCH v6] net: gro: fix double aggregation of flush-marked skbs
Thread-Topic: [PATCH v6] net: gro: fix double aggregation of flush-marked skbs
Thread-Index: AQHdDbZdue4QSGQcCEqMAlYchslag7ZiK+CAgACuZwA=
Date: Wed, 8 Jul 2026 01:41:12 +0000
Message-ID: <2d71af40897d73dbd9e243ce5e25bbd3f99acc5d.camel@mediatek.com>
References: <20260707021425.483-1-shiming.cheng@mediatek.com>
	 <willemdebruijn.kernel.39a3b0237ed2@gmail.com>
In-Reply-To: <willemdebruijn.kernel.39a3b0237ed2@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5622:EE_|PUZPR03MB6886:EE_
x-ms-office365-filtering-correlation-id: 7ca651a5-d5ca-4555-1079-08dedc91fde0
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|11063799006|56012099006|4143699003|22082099003|6133799003|18002099003|921020|38070700021;
x-microsoft-antispam-message-info: 7Pn/V8hjn91eLBVCEm1cRBsDz8PLXtHhcJjN5q77MmPzRDbFz5P2+399OcNxT8kgkjgDZQSTH6MUi3Sg+nMRtNMZm2/doKq3V0eKgZ3N0LaOwrCTrfQpmZ/A3Sf8sMmM5VbNOUmORzdhWACs/28PiSpt28kIHCgcuUGOins0MAp2b1IxsrZ50VBiK6ldBORTN+dqNxfBwzazauMN6CxhqdTBMbAJVd+bIPIYwG/Tk0wBGOfE4xLYV6GNst5cugm6cvJcaUm0dgKqM+4wvAIeCNQm9zpg0HkgP7rDJ8uAJUTyRzxCZejvOzodW0wSP+XHVzoSy+1Y+ZFVqwERwlNNl24Kc+W4JBU4r+4w2NMLAO/P9ckD7cp/AtstEV9OwOaOr6k5f+v52GZoEOzVeDO1kpR4TNNR7akERC0/EWwsWTdkRO+hjSI21TJJQWCjMJUqIOtC3yBw/E0lZ7Vh83I47pjpXEtwO43HZwdExUwDIGkQFUy6U+d7UjoGerciVSqXcdX2/KAuYMNeFuhj4tMYnOW+TCruFbFp/StAMRRbtTDoPoxOp6VTI2jEiB/Z9f1IXegjN+YPuHkXF2H6xgWXFMy5G7+RQFCAJx4BxBaX1nhhmt56qNG45xRbivdxYDoi3SN9Gc+MB5rFHYSgtM1bOncYRCtBKF5N5Qu6FJaDc3mCjWF1MuFCetTnnhUJDdHuSEokM4tT5YePE+yT9Tnpp/+UVU/5Rgn0xsfdrpqksikUmVoAHlUS24B+oeOr7eMf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5622.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(22082099003)(6133799003)(18002099003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUFCMHNTcGFTclRJTkRWNDdGdkZJd3VrdElFaGkwTVhMQlUxeXFzVWlKUEJX?=
 =?utf-8?B?aFNnYWk5TXg4cGVlbmc3M0hOaEoyRUd6cUJXZUVjMWFLVFdXTVJ2VXk2aEMv?=
 =?utf-8?B?RzdRL2VRUW54ZlF4UCtsU05oTmd4VTNnaUZ2RzQzWHNTTGlDK0tJTmxRRXVL?=
 =?utf-8?B?bzBNVDFxRGtja0FrUFliOWJqNkRzd1F6WjViN2VITVlCMnhhM1J1UURBNmhu?=
 =?utf-8?B?UjhJem9uckxjZXhCTWpHK2ExQ3dyTndham1jUVgza0JXNGQ3cHQrMEY3U2dn?=
 =?utf-8?B?Y1ZqNkhxZlI3cDRDSFNKL01KQ0t4Tktlb3NVNnM4Q01tOC92bzhjSFhRL3JG?=
 =?utf-8?B?OXpkM0xmbVNuN2xSc3hsMGkxRHNaVGNHN2FCQTJTTU8vWWI2SU83THl6TnJy?=
 =?utf-8?B?UDV3NnI1bUJIOFVRb3VxTzZoUjdrblIxaXEzRXFkQXlmYlprWWdVTEQ0L25j?=
 =?utf-8?B?SHBGWGlsNG5HTndGVzVXYnB4YXJpa2V5cFNIeFdOQzNQOGgvY1VNTkJxWTho?=
 =?utf-8?B?dDRSUXdoMEt3ckwxdmprOU9hWXE4MVNtSDZXbWZ1TTl0SHhuRUVtclRQVmQz?=
 =?utf-8?B?ODN1WXJBR0JkazVxWHBPVU1odmYvc3l5Tk0wTE1JVEdzKzM1VHpvSm4raXlI?=
 =?utf-8?B?bnlKK0ZTMENhalFpU3dpTmpkeHRraVBpS3dDQXIxbEJxNlVmR1Q1b3MyaFFh?=
 =?utf-8?B?T3BPTktkMVU0WElyVnhnUGo0bEpMVThQcGczczlEWS9GdzRHL1RiWjA1YnFB?=
 =?utf-8?B?cDI1SGxrRlN5STR5S3BXQUNSWllUWXlOajdveFBQM0ozKzR5MHBTYVpTcmFl?=
 =?utf-8?B?aWRlSTVMancrMTlXbHIyejhudC9qR1FhalBtWFE2SnJFZGNtcVQ4bkVKeksv?=
 =?utf-8?B?NVlxT2xqallvVnlIVUJOVFBCVTFBNzRlUkF2V281UFEvTStHOFphVGVxWFFz?=
 =?utf-8?B?RG00dnQyWGRMMnFra2pTby92ZG1TZ29pdGtGSERqc0JIWmpDcC9Odzc2cE9I?=
 =?utf-8?B?Q093ZktGS1RhazAvM0N5ZGhXYmFhTXlObHYxaDBSSWVTZkRvV1VjdUpZTEFF?=
 =?utf-8?B?YktUMzJkb0FlcG9PNm9ZR3ZuSjhMQms5L2haWGlkOVhlem5JNXRWbW5XdW44?=
 =?utf-8?B?b3piR1hCeXJTMyt6d0I0Unk3Mm4rVXRzcmxmNmdUQjZFaFY3QWV0eHZGOWdl?=
 =?utf-8?B?L0JtSU0ra0QyUFhSdFFXMHlGMHNpT3JVYzFmYkZQOUhZQ1VaM21nQlBvR2gy?=
 =?utf-8?B?VjhJekR0WlI0M1h2V2JubXZEVW56NHJnYlkrK3g3TTliWUl1d2NOdlNqUVQ0?=
 =?utf-8?B?L2JFTit2UGNyc0gxazhFNHlyakNzZTRBUVdwL0VTRWF2ZkVhNkMvb2l6aDVz?=
 =?utf-8?B?Uk5QTm1RVWJTZ25ad2RqM0p0emcwdXNwVkNIc1B6eEdVNlV5OVVPVkRzU3or?=
 =?utf-8?B?THk2dWFYMWY5ckgzbVJGa3lIOGdzZldsK0ZyeE1CWXdDK2JnOU55Ym41cEFj?=
 =?utf-8?B?U1ZkU2VCdWJWWVZvbWVoVE1JVEx5Z0J3SHlzOEJlWUw0TitNdmJHbnF6dFRE?=
 =?utf-8?B?b3JLQTBiM29yQVUyZU00QXNnVlQ5YmdSNjJBckRidm4vaHl1WlhsYVJzb1pB?=
 =?utf-8?B?R0tGQXVVbWU0d2FrdzZJOG5SdDNpVWdKcXh5OWdiV2dGcllhb2M4THcrcXBJ?=
 =?utf-8?B?LzhjbmVJTFkvR2RyYkJ1WWFBMWpaYmFOUGtBTUlQc0FOQWVaQU0rREVhOVVa?=
 =?utf-8?B?aFFSeTEvY3NlR2swQzNzOG9BbzJCemxuZjdnelFuaG42RU14RTRnUDNBcTZR?=
 =?utf-8?B?NEVTeS9sYmx2eVgvb2JTdit6YUdyK01JWWRvaWdieDNhUVMwSTZvUURUTW5M?=
 =?utf-8?B?YytHQ1VScWtJdWViUE05NXkwS2EwVkRyQjFYbGd4Nmk3bVlpS1VCZXlua1lE?=
 =?utf-8?B?aU9MZ1ZYaVRrNW9LMy92Q1ZvRy9vYkRlcXFMS3VBZjNna09malBxNDdnc1E4?=
 =?utf-8?B?U1FuOFZRVHV5ODlLTk44dkxiZnhhb2cwYndMa1pwaTl2ZmpRVXRwK0hTQ2Mw?=
 =?utf-8?B?aERxaHRQcVVjVGZEQVpQNjJhUVM5enJhQXAra09WR2lxK3E5S2RJNnpJdXVp?=
 =?utf-8?B?Y2V4S01mdG8rOThqM2hRZjNyT3BjSGZac1Q2a3lrclYwbnk1RDZhWUdLZmhk?=
 =?utf-8?B?bmFiWnFKKzRnR0oydzBpbThFK0k2OTN2ZGsvdTZjRThVa2QzZG9qRm1HL3Rv?=
 =?utf-8?B?V29VTkFQVjhFelNwNDZYTlcrY203eFFTcUh4ZHJhYis2b2tsTHgzaWpuQU5a?=
 =?utf-8?B?UXBkTk5QVHRxNlZ4V0lIYnArZXNMZXVvRGV5ZmxXV1VqSkM4OTA1TWFaRTZm?=
 =?utf-8?Q?kBLc1PgghGFz14mw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46B7B93368209E4EB22678C3DB37EFDF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sRm+XHkSmuL2xsIDs1aOl+YTP0QnI/Ati1tea7vk5LantBo7kcEIMKPw4o8Unc8kewCtyS6DITwez6+tJHbeGriTufO666YHoDfWACsx2fwcQqilS3TsWbZmiM7LsixcjzY/+PqgQfCQoakI7upTkZYAEyGeg4bgKNS49g/coQ64aAz2n/wx84RYFTyAnkBLUEMcPV7VMNLeYEQOF3RSeHiw2dEq90wXJJYgJKAGptnstj6uezcwQuH/dY2FNwwbfk30SmNJkvp4HYdecJfCy2mwCwiG6d1eZkui4XkC43vuZxFoheHJhccJcseP9O4R2AdvaTb5pPypDSAcoYVMcg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5622.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca651a5-d5ca-4555-1079-08dedc91fde0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 01:41:12.0395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vD/XcRWsfRqVwI/nhxOaMDATbpvg1gJpLSBhEjeu8dxGrjbeVN6f/y5dtqrabjJq/FT3GZVEfPJ3Li7IxGDp+ObsTmAw3nRWqywM0EHUbJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6886
X-MTK: N

T24gVHVlLCAyMDI2LTA3LTA3IGF0IDExOjE2IC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3Rl
Og0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiANCj4gDQo+IFNoaW1pbmcgQ2hlbmcgd3JvdGU6DQo+ID4gVGhlIHNrYl9ncm9f
cmVjZWl2ZV9saXN0KCkgZnVuY3Rpb24gaXMgbWlzc2luZyBhIGNyaXRpY2FsIHNhZmV0eQ0KPiA+
IGNoZWNrDQo+ID4gdGhhdCBleGlzdHMgaW4gdGhlIHNrYl9ncm9fcmVjZWl2ZSgpIGltcGxlbWVu
dGF0aW9uLiBTcGVjaWZpY2FsbHksDQo+ID4gaXQNCj4gPiBkb2VzIG5vdCB2YWxpZGF0ZSBOQVBJ
X0dST19DQihza2IpLT5mbHVzaCBiZWZvcmUgYWxsb3dpbmcgcGFja2V0DQo+ID4gYWdncmVnYXRp
b24sIGFzIG9mIGNvbW1pdCAwYWIwM2YzNTNkMzYgKCJuZXQtZ3JvOiBGaXggR1JPIGZsdXNoDQo+
ID4gd2hlbiByZWNlaXZpbmcgYSBHU08gcGFja2V0LiIpLg0KPiANCj4gSXQgZG9lcyBub3QgY2hl
Y2sgLi4gYXMgb2YgY29tbWl0IC4uID8NCj4gDQo+IE5vLCBza2JfZ3JvX3JlY2VpdmUgY2hlY2tv
cyBOQVBfR1JPX0NCKHNrYiktPmZsdXNoIGFzIG9mIHRoYXQgY29tbWl0Lg0KPiANCg0KSXMgdGhp
cyB3b3JkaW5nIG9rYXk/DQoNCkNvbW1pdCAwYWIwM2YzNTNkMzYgKCJuZXQtZ3JvOiBGaXggR1JP
IGZsdXNoIHdoZW4gcmVjZWl2aW5nIGEgR1NPDQpwYWNrZXQuIikgYWRkZWQgYSBmbHVzaCBjaGVj
ayB0byBza2JfZ3JvX3JlY2VpdmUoKSwgYnV0DQpza2JfZ3JvX3JlY2VpdmVfbGlzdCgpIGxhY2tz
IHRoZSBzYW1lIHZhbGlkYXRpb24uDQoNCkFzIGEgcmVzdWx0LCBwYWNrZXRzIG1hcmtlZCB3aXRo
IE5BUElfR1JPX0NCKHNrYiktPmZsdXNoIG1heSBzdGlsbCBiZQ0KcmUtYWdncmVnYXRlZC4NCg0K
PiA+IFRoaXMgYWxsb3dzIGFscmVhZHktR1JPJ2QgcGFja2V0cyB3aXRoIGV4aXN0aW5nIGZyYWdf
bGlzdCB0byBiZQ0KPiA+IHJlLWFnZ3JlZ2F0ZWQgaW50byBhIG5ldyBHUk8gc2Vzc2lvbiwgY29y
cnVwdGluZyB0aGUgZnJhZ19saXN0DQo+ID4gY2hhaW4NCj4gPiBzdHJ1Y3R1cmUuIFdoZW4gc2ti
X3NlZ21lbnQoKSBhdHRlbXB0cyB0byB1bnBhY2sgdGhlc2UgbWFsZm9ybWVkDQo+ID4gcGFja2V0
cywNCj4gPiBpdCBlbmNvdW50ZXJzIGludmFsaWQgc3RhdGUgYW5kIHRyaWdnZXJzIGEga2VybmVs
IHBhbmljLg0KPiA+IA0KPiA+IFNjZW5hcmlvIChUZXRoZXJpbmcvRGV2aWNlIGZvcndhcmRpbmcp
Og0KPiA+ICAgMS4gRHJpdmVyOiBHZW5lcmF0ZWQgYWdncmVnYXRlZCBwYWNrZXQgUDEgdmlhIExS
TyB3aXRoIGZyYWdfbGlzdA0KPiA+ICAgMi4gRGV2IEE6IFJlY2VpdmVzIGFnZ3JlZ2F0ZWQgZnJh
Z2xpc3QgcGFja2V0IGFuZCBmbHVzaCBmbGFnIHNldA0KPiA+ICAgMy4gRGV2IEE6IFJlLWVudGVy
cyBHUk8sIHNrYl9ncm9fcmVjZWl2ZV9saXN0KCkgaXMgY2FsbGVkDQo+ID4gICA0LiBNaXNzaW5n
IGZsdXNoIGNoZWNrIGFsbG93cyByZS1hZ2dyZWdhdGlvbiBkZXNwaXRlIGZsdXNoIGZsYWcNCj4g
PiAgIDUuIEZyYWdfbGlzdCBjaGFpbiBiZWNvbWVzIGNvcnJ1cHRlZCAobG9vcHMgb3IgZGFuZ2xp
bmcgcmVmcykNCj4gPiAgIDYuIERldiBCOiBUWCBwYXRoIGNhbGxzIHNrYl9zZWdtZW50KCksIGNy
YXNoZXMgb24gY29ycnVwdGVkDQo+ID4gZnJhZ19saXN0DQo+ID4gDQo+ID4gUm9vdCBjYXVzZSBp
biBza2Jfc2VnbWVudCgpOg0KPiA+ICAgVGhlIGNoZWNrIGF0IGxpbmUgfjQ4OTE6DQo+ID4gICAg
IGlmIChoc2l6ZSA8PSAwICYmIGkgPj0gbmZyYWdzICYmIHNrYl9oZWFkbGVuKGxpc3Rfc2tiKSAm
Jg0KPiA+ICAgICAgICAgKHNrYl9oZWFkbGVuKGxpc3Rfc2tiKSA9PSBsZW4gfHwgc2cpKSB7DQo+
ID4gDQo+ID4gICBXaGVuIGZyYWdfbGlzdCBpcyBjb3JydXB0ZWQgYnkgZG91YmxlIGFnZ3JlZ2F0
aW9uLCB3aGVuIGxpc3Rfc2tiDQo+ID4gaXMNCj4gPiAgIGEgTlVMTCBwb2ludGVyIGZyb20gc2ti
LT5uZXh0LCBza2JfaGVhZGxlbihsaXN0X3NrYikgZGVyZWZlcmVuY2UNCj4gPiAgIE5VTEwvY29y
cnVwdGVkIHBvaW50ZXJzIG9jY3Vycy4NCj4gPiANCj4gPiBDYWxsIFRyYWNlOg0KPiA+ICBza2Jf
aGVhZGxlbihOVUxMIHNrYikNCj4gPiAgc2tiX3NlZ21lbnQNCj4gPiAgdGNwX2dzb19zZWdtZW50
DQo+ID4gIHRjcDRfZ3NvX3NlZ21lbnQNCj4gPiAgaW5ldF9nc29fc2VnbWVudA0KPiA+ICBza2Jf
bWFjX2dzb19zZWdtZW50DQo+ID4gIF9fc2tiX2dzb19zZWdtZW50DQo+ID4gIHNrYl9nc29fc2Vn
bWVudA0KPiA+ICB2YWxpZGF0ZV94bWl0X3NrYg0KPiA+ICB2YWxpZGF0ZV94bWl0X3NrYl9saXN0
DQo+ID4gIHNjaF9kaXJlY3RfeG1pdA0KPiA+ICBxZGlzY19yZXN0YXJ0DQo+ID4gIF9fcWRpc2Nf
cnVuDQo+ID4gIHFkaXNjX3J1bg0KPiA+ICBuZXRfdHhfYWN0aW9uDQo+ID4gDQo+ID4gRml4OiBB
ZGQgTkFQSV9HUk9fQ0Ioc2tiKS0+Zmx1c2ggdmFsaWRhdGlvbiB0byB0aGUgZWFybHktcmV0dXJu
DQo+ID4gY2hlY2sgaW4NCj4gPiBza2JfZ3JvX3JlY2VpdmVfbGlzdCgpLCBtYXRjaGluZyB0aGUg
ZGVmZW5zaXZlIHByb2dyYW1taW5nIHBhdHRlcm4NCj4gPiBvZg0KPiA+IHNrYl9ncm9fcmVjZWl2
ZSgpLg0KPiA+IA0KPiA+IEZpeGVzOiAzYTEyOTZhMzhkMGMgKCJuZXQ6IFN1cHBvcnQgR1JPL0dT
TyBmcmFnbGlzdCBjaGFpbmluZy4iKQ0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+
ID4gU2lnbmVkLW9mZi1ieTogU2hpbWluZyBDaGVuZyA8c2hpbWluZy5jaGVuZ0BtZWRpYXRlay5j
b20+DQo+ID4gLS0tDQo+ID4gIG5ldC9jb3JlL2dyby5jIHwgNCArKystDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0IGEvbmV0L2NvcmUvZ3JvLmMgYi9uZXQvY29yZS9ncm8uYw0KPiA+IGluZGV4IDM1ZjJmNzA4
ZjAxMC4uYjQxM2Y0YTY0NjJiIDEwMDY0NA0KPiA+IC0tLSBhL25ldC9jb3JlL2dyby5jDQo+ID4g
KysrIGIvbmV0L2NvcmUvZ3JvLmMNCj4gPiBAQCAtMjI5LDcgKzIyOSw5IEBAIGludCBza2JfZ3Jv
X3JlY2VpdmUoc3RydWN0IHNrX2J1ZmYgKnAsIHN0cnVjdA0KPiA+IHNrX2J1ZmYgKnNrYikNCj4g
PiANCj4gPiAgaW50IHNrYl9ncm9fcmVjZWl2ZV9saXN0KHN0cnVjdCBza19idWZmICpwLCBzdHJ1
Y3Qgc2tfYnVmZiAqc2tiKQ0KPiA+ICB7DQo+ID4gLSAgICAgaWYgKHVubGlrZWx5KHAtPmxlbiAr
IHNrYi0+bGVuID49IDY1NTM2KSkNCj4gPiArICAgICAvKiBtYWtlIHN1cmUgdG8gY2hlY2sgZmx1
c2ggZmxhZyBhbmQgdG8gbm90IG1lcmdlICovDQo+ID4gKyAgICAgaWYgKHVubGlrZWx5KHAtPmxl
biArIHNrYi0+bGVuID49IDY1NTM2IHx8DQo+ID4gKyAgICAgICAgICAgICAgICAgIE5BUElfR1JP
X0NCKHNrYiktPmZsdXNoKSkNCj4gPiAgICAgICAgICAgICAgIHJldHVybiAtRTJCSUc7DQo+ID4g
DQo+ID4gICAgICAgaWYgKCFwc2tiX21heV9wdWxsKHNrYiwgc2tiX2dyb19vZmZzZXQoc2tiKSkp
IHsNCj4gPiAtLQ0KPiA+IDIuNDUuMg0KPiA+IA0KPiANCj4gDQo=
