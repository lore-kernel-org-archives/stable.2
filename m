Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23E41F30A9;
	Fri,  3 Jul 2026 01:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783042028; cv=fail; b=u3k97DXylE1E4CffVp2DTi/Qz6cxIUtGChduK19QGeux3/GP9LM8ktrCG3BzsWn9ZvCiODN3jdNUEmKevyX+WQU6RGs9VgYPElqUglcQqGNpoJ+ZF+XjyBySlqx/717E90hWOdepjP4jDGgXAQzKNXSf8z4PK6Vy+WNCtwAWwho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783042028; c=relaxed/simple;
	bh=8zw1viR1zpseQM8eRlr9Jvo4kRwZATcYq5dZeH8dOJc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cRszi6sjQvaPA6hxqTX2Gcjadc7z0Cul3HurPK6/xrjo2/0/cPi3Y8Pby1l2r6hD+LFUxDMuCBZ5sJCD//xdH1aq/koeOURSUkjRIbmen8UWj6aBmmi9pCNivg7pXNBXXSfEADsBjcyk71gNiykrThjek06VUFiGWrbKCdKQ8Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ELLa7uk+; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=HNsHM74m; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ELLa7uk+";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="HNsHM74m"
X-UUID: 490a78e2767e11f18dc8c9802ae25ab1-20260703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8zw1viR1zpseQM8eRlr9Jvo4kRwZATcYq5dZeH8dOJc=;
	b=ELLa7uk+dXqIdiC8PbucHTgWhuot2d//wmlbj+ebqePFBGgDZtIqbkvOSabOTKmsyvW8ucuN6zcYWZhIbiRyuDAQEsDQ1pHSoytmWke+yBhNxk4HReflrC0SGv91yvQsva65meZYCO8PWDW+p4BGi1q2mYOFb50cpP0hPRgZTuI=;
X-CID-CACHE: Type:Local,Time:202607030926+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:5cc79b98-a7fa-4e7d-aef9-eb92220a143b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:2f2bef81-6310-4e6b-a6b1-aca20d98ed8b,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
	1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 490a78e2767e11f18dc8c9802ae25ab1-20260703
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1150047710; Fri, 03 Jul 2026 09:26:58 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 3 Jul 2026 09:26:57 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 3 Jul 2026 09:26:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmZ+5owqlJimyHluR6Uv4m6E8OCEI96jlJFo1Z9lfFTsdY/0PuOTiMn7hIQGd3Xy+8mwRKO6i9Wymuy6AFZSzuCvx/Rl2JhWfRzfHSofuLYAhAYRvI34sAgTnWugj77BFhzyTfpzrkO6TtdpixvHJcjoVvIdt/HQCmVCuoYgj5GRF4GnLjrnQ6OJjssYsS4Y5INaX2DyNPfPUjKPXaxbiiuYh4mbtWL4wba3OZx0KW8P0qQlc04ni7dEu/AmgmJsh+Mc92ppDjYy2WtGgP3BwMecW1tTlHEki6LRK7cJYtRoYcBUA7qNXehbsP36zrRC0xOJFta2t35U6gSYGmAYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zw1viR1zpseQM8eRlr9Jvo4kRwZATcYq5dZeH8dOJc=;
 b=ZVdJnmK2/yEV2HkpnvtzOVviO6s23eyoVvqaSaY8EZJntuPOB1RpZMNJCEeE7ml+sem8+OXoKd3d0gSiuNayWdei3zjwTGV6Gq4+0aXh19v0WTUUvH0bfipPcq+mXFAz5MHCXkvuvXorA+KYNnIkYhrolNUT/FDsxGA3lbM7c1ZaawZ4JrlzxT6yfY83NUYtuplzCBtMz36X0MZk6TGoPVUvACVTbe0ISGplajJrgmmAZM9VPR18lJzwRzHWAt5+wTV5hKv+qU6WgzxxEaQhjOoNq1SnEaye92zsWX1yrwv/vzK+W0buVBVL0ItmlHuDf/Tnk8i/UOsNYVAuBsYPoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zw1viR1zpseQM8eRlr9Jvo4kRwZATcYq5dZeH8dOJc=;
 b=HNsHM74mD7KOKmoDdA6M7e9pGaUkElS/0sdtkACPgw7/3hIRFO1sP+88mM1kW6TN1NbdZIHq3eYhfebF1CIenKju4aob3NqBTeLC/OVtUz6iQiB/mFqf1n2naUIonM2skIpW70XwKewMktAZrMvJ/J3Cun0PEEQaCvX2KRPFnEA=
Received: from PSAPR03MB5622.apcprd03.prod.outlook.com (2603:1096:301:62::11)
 by TY0PR03MB6952.apcprd03.prod.outlook.com (2603:1096:400:274::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Fri, 3 Jul 2026
 01:26:52 +0000
Received: from PSAPR03MB5622.apcprd03.prod.outlook.com
 ([fe80::b639:3572:f154:28d0]) by PSAPR03MB5622.apcprd03.prod.outlook.com
 ([fe80::b639:3572:f154:28d0%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 01:26:51 +0000
From: =?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "imv4bel@gmail.com"
	<imv4bel@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "alice@isovalent.com"
	<alice@isovalent.com>, "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
	"eilaimemedsnaimel@gmail.com" <eilaimemedsnaimel@gmail.com>, "nbd@nbd.name"
	<nbd@nbd.name>, "horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "willemb@google.com" <willemb@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"sd@queasysnail.net" <sd@queasysnail.net>
CC: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] Subject: [PATCH] net: gro: fix double aggregation of
 flush-marked skbs
Thread-Topic: [PATCH v3] Subject: [PATCH] net: gro: fix double aggregation of
 flush-marked skbs
Thread-Index: AQHdCDkmH/+GXbyg0ES4lZRbskUecLZaAz6AgAECWYA=
Date: Fri, 3 Jul 2026 01:26:51 +0000
Message-ID: <9e1cd4da0b4780b1c02d1c99899eca8d12bdf4f3.camel@mediatek.com>
References: <20260630023512.26927-1-shiming.cheng@mediatek.com>
	 <3f540a8a-4167-4727-9516-6fb91335333f@redhat.com>
In-Reply-To: <3f540a8a-4167-4727-9516-6fb91335333f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5622:EE_|TY0PR03MB6952:EE_
x-ms-office365-filtering-correlation-id: 683b1b59-5fcd-4775-241b-08ded8a228db
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|22082099003|4143699003|56012099006|18002099003|6133799003|11063799006|921020|38070700021;
x-microsoft-antispam-message-info: kBLDI2J84SAd+hBU8h1rkakic+WgH4QeefBKOG2zoiihgJNGsU801znzsEkG5K38rK94H2KVGygqSperYw6S8P9Rhi1jQJenXEevB5odglJOyo1yFekz03Qun4ERlpRqNgNYJwPy8dvA+/dVSViftk0Z9uEgR/9z0PyyUcQEVml1gCIzfJ0P2i/NGu8nm3bPyTNAhaXnaiortO0qQjRrpc0L7sNXhMeLl0W201h5W3oV29iRD8JuIVLzpVWzdggxAFnWSutl2u1SdQs3Or2F9GO1Hpti9ymf2KA9nX2+l7h59Wea0z/52ZkOZF09M6OUdaIpbX9uGXA3Ek1RxbfroPy3qf0TZV8qxBMAmNQ25ea4yTpcp9ilJTDaalqQH6NJTrDd4EIbVHOxBvOpk4bRz0eyRESoP7DrfbrQHRh/Fw+Y+tngyOyyHUNbl07s42ojoBolgSsyr2gcxEL2w0j07bEPSxqhiAlgtrsfNva8tUDrVfZexLn+ZH1uO0s8eEBiKKBQAkM6A+n2+AU/hJ33SSw71iwsR8w1CwXfMeaIQa4w5Mcaf4yKNhQIdPs5/Lgrie5MiI9EngG9IJ4EVKeAR5pTc3bOHHj/iwBPgL1p8SYvpn4mDIF7mgoTg5GCfKjkZmCGhD3m1MBdrGmzoeJff1fzMrBUOfRjUaUYCLKWYeYNgVGpfE5Wc7LpzaR3W5pfzwuG2VNzU/9Dso+23Z8vjK7LFJ2lzYBM2/kOpOn8rMhsEcMww30c/nqd0xYUGNHm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5622.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(22082099003)(4143699003)(56012099006)(18002099003)(6133799003)(11063799006)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEVyM1NvWkErOWY3VzZOYnZhamhEQmlJRTFBWXBrZFFxbTNRN1hkelFWakRw?=
 =?utf-8?B?WFpXTXJHYzJIM2dUR3ZrRi9idkQ1MUk0aHdaUDBrZTJId21VVG1sZVN0bnF0?=
 =?utf-8?B?MWJSR252L0J3aUg1MktOVGhVSEVoVUExek1yRXpkdHZhdlVMUWNPaUFub1Mr?=
 =?utf-8?B?Q3QvcGlCRWZTMGxLUlNGYkxTYU5JWlBvbDBkMjkrdzREQXFTblRlbGdSa3cw?=
 =?utf-8?B?TnVLK2Jwb3k2NS9SZ3RXVy96R0pvVXI4a2FwMzBCcEg5MlRJUzZCc243aDB2?=
 =?utf-8?B?ak9ZbDQ3UkNMKzlOaGRDbUN5RnNNSUduMEdEMnNtZHhGMW9hZEhCcWpjUXVX?=
 =?utf-8?B?amlJcUxFakVGczVYc2dxTDBkMlF5bDBWeVVRRkJRblRKblFBdjYwOEFPOWxP?=
 =?utf-8?B?cURPSFJjNm9DbkV0RC9XUTJnYk51b0J3aG9Mek04eFFSODVIY1ZVNi9Ub25m?=
 =?utf-8?B?MEtKcnIrRWpLZTZUTGw1OVArUzg0eHp5NjVnTC9nV0p6SHdNUXM1ckp2Z0I4?=
 =?utf-8?B?VFFtRFVLNERRRzN2dk1ReDVRanQ0Vk5PSXNJOVptMElmd21oMWo3cW1VUkJl?=
 =?utf-8?B?SkNQaWx3Y1lSZ2h4bjVqUkxqK1pQNVhtSGsvRWhiemNlMFJFdkdjV3lJQzlP?=
 =?utf-8?B?YkZZOTdlSTJGTmQzUjlRc3dWdlFjbGovV0VnOE0zd3ZwTGEyOE5PeTdhdER6?=
 =?utf-8?B?T0lzRkJQWjJYenF5L05RcmhRSndGaENGN3g4ZFlTMXErOGJSeUptLzQvL05q?=
 =?utf-8?B?K245T3BMcUhlY3htSmQ4Zjk3ZDNsaTU5QXZQcDFaV3Y1UVN0dCtwQVJoVXln?=
 =?utf-8?B?NGkxV05aTDRFRjRyOWxSVGd5UDRjdmZKWVU4dSt4V1BtVks5RkZOZkMyQzM1?=
 =?utf-8?B?K05RdUN5YnBzdmRyQjlpejBnZkNVeDRYTmh1dUxzMzIrVmJ1YXNaQ0hpS016?=
 =?utf-8?B?V0U0SkoxNDJsV3JwZVBKS0NQZzV0dlFGbXFwOFBpZU5nUFpyNUFFdVBGUXJI?=
 =?utf-8?B?WG5vYWdRMkRMZXRRbWk1N3hEejM2OGFGT1NnbkNNemM5MkFVNVZ0V2RYdkRS?=
 =?utf-8?B?aVdTbTdVQnpaNjJMVndlaW9MTEN0RHorSG85bGdWQ1NYU0Y5MGZ3d0FYVU1U?=
 =?utf-8?B?K1JpSFdvR3p3NUVVK1ZycHZ6aFlseXF3WHUwRTU1bll6MnpTMnFuR21qYjdF?=
 =?utf-8?B?RFNsaGNMb29PMGRMQVRhWDBMTlRpbm0zdldDT1lLdVpreDF2MXFEWCtDT0Za?=
 =?utf-8?B?MXJacEpXcWVDMVc1V0oxcy8xOUFGMWYyTzRHK211bUhUc1ZGcWIwYThPZDRt?=
 =?utf-8?B?RDd2SzhKMHVETVBYN096NDl1UU5SUWVYT3hnZHUrVEF2SE1aK2dnUyszTzE4?=
 =?utf-8?B?NUF6NXo3K29sU2ovZzl0NUtsQ09RYlRQOEJROGM0MkYvbWJnTXQwYVJ0TWpB?=
 =?utf-8?B?YmFEMndSSjB5QnlJTEZSeWtxOGZZb0Vpdk5hdm1mUHJwZ3BkbUs0Q0U2SXoy?=
 =?utf-8?B?SGYzUmxOQU1qQ1ZwK3kzL1hWdXdRSkNqTzY0ZURqQXNXZVc2aExHQmx5d2dF?=
 =?utf-8?B?VFJyK1dUTUg4cVhMWnVnbTl4NW9JejB5dGxrUkVnUjF3YnRRdjN0dFNoOGlU?=
 =?utf-8?B?TWNZVC93dVJKbGFMTkw2YUIwLytlaHl5bk9USDFGMmFoSkpqbFJIckdVQmI4?=
 =?utf-8?B?T1JwSWc3eC8yRUErT1JoSnpDVFBTdCsydWlCU1BOK0xYZnk2ZzllTGhlVzlO?=
 =?utf-8?B?bWtsbDdoTnl1NTlPR3piS3JkNmFpSmNNQTFkazFYc3RIMHhDMlE5YlByQ0J4?=
 =?utf-8?B?YmNpT1FmdjNqS2I4SGRrUmlpM2sxR3o0Z1FHaHRBS1dsZy9xUm9LZEk0b05z?=
 =?utf-8?B?cTA2QlBEVkpsSWIyMHhCOE1KZmFYa0EzUkFqV29UaHIxQzF2RUEzM2FsTTFV?=
 =?utf-8?B?T0JYbzhQeDNnMDhRQjNFYUI5SXlKenFES1J3eUZNVGQySEIvMExYNFlVRVA4?=
 =?utf-8?B?eXpMUGsrdUwvSyttclZ0d3JndGk2THY4WGRkaFZzbHhYMkxaWGFpNmo3OFVu?=
 =?utf-8?B?TElBZXpUNkZEdFMyUFQwOERFV3Q4dldKcVEyM043eHdEL2ZINzFDVkZEaUlT?=
 =?utf-8?B?cytLN3lOZlVIQmZNNjhNcFovYXZNaFRMUm92K0lGRC9HZno5R0dvVUJWeC90?=
 =?utf-8?B?aFI3aGM1OXBmVnQ4RGJLNDF5ZTN3ZjVRb1NPbDBxd3lEQUN5TGROWmdWeitJ?=
 =?utf-8?B?c0NpeEgxNEpWL2RPeFBveE5DTXVpVXgrYlU5cHJ6aVVTcVo0dkdjV0R0RlRW?=
 =?utf-8?B?R1NqVzNLckZRSy9xWmhTL05rNyszNm05Q0VRTUErbTNKV1k5MHlsL1l2aUNJ?=
 =?utf-8?Q?5MykmWEND/RZNLXo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6D7400FBBE41A4BB207E20D78F3A948@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oj2HUwXBRRfcyZg92M2B7xVeiNJbNGBUJfwJTROzEDOkBXCMZ3/QUnKG10KcJZAQRnur19jLfBlSM2l5xKNBi351RGk9iGkGqhO0WZgUt78T8FEM8AI25iBF+zyb5gYp+mkRH9UAoLABgeXRGe74/c0d/XJuqE1kQv1IvOrMhsIJ4I0n+bBTSbFF6ItQ5SzKkpUxDYFJDpfV7YpcKuAg6AJaD9P1J41Z5eyW338UwsF9LZpwnk6eURoqCN0papYOKk9uNh44vN1rTmrM0gWBgx2PXoPhSCIuuhjPYDuLxq8hBlZYxd643nFDuIO9rHRdepOaVRT1qeHofzA4v5eDBg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5622.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683b1b59-5fcd-4775-241b-08ded8a228db
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 01:26:51.4297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tl3Dm189GI+m3EVA6ZPzEKDfAxYKyWVawjWlv8cf88CyMeS0L5ZqRUY0pV0zFP8jl1o6q8FMXNarM41G2uDSDdHUTMD34i9Amzdp32a0dI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6952
X-MTK: N

T24gVGh1LCAyMDI2LTA3LTAyIGF0IDEyOjAyICswMjAwLCBQYW9sbyBBYmVuaSB3cm90ZToNCj4g
Tm90ZTogdGhlIHBhdGNoIHN1YmplY3QgaXMgcXVpdGUgdW5jb3JyZWN0ZWQNCj4gDQo+IE9uIDYv
MzAvMjYgNDozNSBBTSwgU2hpbWluZyBDaGVuZyB3cm90ZToNCj4gPiBUaGUgbmV3IHNrYl9ncm9f
cmVjZWl2ZV9saXN0KCkgZnVuY3Rpb24gaXMgbWlzc2luZyBhIGNyaXRpY2FsDQo+ID4gc2FmZXR5
IGNoZWNrDQo+ID4gcHJlc2VudCBpbiB0aGUgbGVnYWN5IHNrYl9ncm9fcmVjZWl2ZSgpIHBhdGgu
IFNwZWNpZmljYWxseSwgaXQgZG9lcw0KPiA+IG5vdA0KPiA+IHZhbGlkYXRlIE5BUElfR1JPX0NC
KHNrYiktPmZsdXNoIGJlZm9yZSBhbGxvd2luZyBwYWNrZXQNCj4gPiBhZ2dyZWdhdGlvbi4NCj4g
DQo+IHNrYl9ncm9fcmVjZWl2ZV9saXN0KCkgaXMgbm90IHZlcnkgIm5ldyIgYW5kIGRlZmluaXRl
bHkNCj4gc2tiX2dyb19yZWNlaXZlKCkgaXMgbm90IGxlZ2FjeS4NCj4gDQoNClRoZSB3b3JkaW5n
IGhlcmUgbWF5IG5lZWQgdG8gYmUgYWRqdXN0ZWQuIEknbSByZWZlcnJpbmcgdG8gdGhlDQpjaHJv
bm9sb2dpY2FsIG9yZGVyL3doaWNoIG9uZSBjYW1lIGZpcnN0Lg0KDQpVcGRhdGVkOg0KVGhlIHNr
Yl9ncm9fcmVjZWl2ZV9saXN0KCkgZnVuY3Rpb24gaXMgbWlzc2luZyBhIGNyaXRpY2FsIHNhZmV0
eSBjaGVjaw0KdGhhdCBleGlzdHMgaW4gdGhlIHNrYl9ncm9fcmVjZWl2ZSgpIGltcGxlbWVudGF0
aW9uLiBTcGVjaWZpY2FsbHksIGl0DQpkb2VzIG5vdCB2YWxpZGF0ZSBOQVBJX0dST19DQihza2Ip
LT5mbHVzaCBiZWZvcmUgYWxsb3dpbmcgcGFja2V0DQphZ2dyZWdhdGlvbg0KDQo+ID4gVGhpcyBh
bGxvd3MgYWxyZWFkeS1HUk8nZCBwYWNrZXRzIHdpdGggZXhpc3RpbmcgZnJhZ19saXN0IHRvIGJl
DQo+ID4gcmUtYWdncmVnYXRlZCBpbnRvIGEgbmV3IEdSTyBzZXNzaW9uLCBjb3JydXB0aW5nIHRo
ZSBmcmFnX2xpc3QNCj4gPiBjaGFpbg0KPiA+IHN0cnVjdHVyZS4gV2hlbiBza2Jfc2VnbWVudCgp
IGF0dGVtcHRzIHRvIHVucGFjayB0aGVzZSBtYWxmb3JtZWQNCj4gPiBwYWNrZXRzLA0KPiA+IGl0
IGVuY291bnRlcnMgaW52YWxpZCBzdGF0ZSBhbmQgdHJpZ2dlcnMgYSBrZXJuZWwgcGFuaWMuDQo+
ID4gDQo+ID4gU2NlbmFyaW8gKFRldGhlcmluZy9EZXZpY2UgZm9yd2FyZGluZyk6DQo+ID4gICAx
LiBEcml2ZXI6IEdlbmVyYXRlZCBhZ2dyZWdhdGVkIHBhY2tldCBQMSB2aWEgTFJPIHdpdGggZnJh
Z19saXN0DQo+ID4gICAyLiBEZXYgQTogUmVjZWl2ZXMgYWdncmVnYXRlZCBmcmFnbGlzdCBwYWNr
ZXQgYW5kIGZsdXNoIGZsYWcgc2V0DQo+ID4gICAzLiBEZXYgQTogUmUtZW50ZXJzIEdSTywgc2ti
X2dyb19yZWNlaXZlX2xpc3QoKSBpcyBjYWxsZWQNCj4gPiAgIDQuIE1pc3NpbmcgZmx1c2ggY2hl
Y2sgYWxsb3dzIHJlLWFnZ3JlZ2F0aW9uIGRlc3BpdGUgZmx1c2ggZmxhZw0KPiA+ICAgNS4gRnJh
Z19saXN0IGNoYWluIGJlY29tZXMgY29ycnVwdGVkIChsb29wcyBvciBkYW5nbGluZyByZWZzKQ0K
PiA+ICAgNi4gRGV2IEI6IFRYIHBhdGggY2FsbHMgc2tiX3NlZ21lbnQoKSwgY3Jhc2hlcyBvbiBj
b3JydXB0ZWQNCj4gPiBmcmFnX2xpc3QNCj4gDQo+IEkgY2FuJ3QgcGFyc2UgdGhlIGFib3ZlLiBJ
cyB0aGlzIHNvbWV0aGluZyB0aGF0IGNhbiBoYXBwZW4gd2l0aCBpbi0NCj4gdHJlZQ0KPiBkcml2
ZXJzIG9yIGRvIHlvdSBuZWVkIE9vVCBtb2R1bGUgdG8gdHJpZ2dlciBpdD8gSW4gYW55IGNhc2Ug
cGxlYXNlDQo+IGNsYXJpZnkgdGhlIGFjdHVhbCBvcmRlciBhbmQgdGhlIGludm9sdmVkIGRyaXZl
ci4gUG9zc2libHkgYSBzdGFjaw0KPiBzdHJhY2UgbGVhZGluZyB0byB0aGUgY3JpdGljYWwgYWdn
cmVnYXRpb24gY291bGQgaGVscC4NCj4gDQoNCldlIGFyZSBoaXR0aW5nIGEgR1JPL0xSTy1yZWxh
dGVkIGZhaWx1cmUgaW4gYSB0ZXRoZXJpbmcgc2NlbmFyaW8uIA0KDQpPbiB0aGUgUlggcGF0aCwg
dGhlIGRyaXZlciBwZXJmb3JtcyBhbiBMUk8tc3R5bGUgYWdncmVnYXRpb24gYmVmb3JlDQpoYW5k
aW5nIHBhY2tldHMgdG8gdGhlIHN0YWNrLiBXaGVuIGBuZnJhZ3NgIGV4Y2VlZHMgMTcsIGFkZGl0
aW9uYWwNCnBhY2tldHMgYXJlIG5vIGxvbmdlciBhcHBlbmRlZCB0byB0aGUgZnJhZ3MgYXJyYXks
IGJ1dCBhcmUgYXR0YWNoZWQNCnRocm91Z2ggYHNrYl9zaGFyZWRfaW5mbyhza2IpLT5mcmFnX2xp
c3RgLiBBZnRlciB0aGF0LCB0aGUgZHJpdmVyIHN0aWxsDQpwYXNzZXMgdGhlIHNrYiBpbnRvIGBu
YXBpX2dyb19yZWNlaXZlKClgLCBzbyB0aGUgc2FtZSB0cmFmZmljIGdvZXMNCnRocm91Z2ggYSBz
ZWNvbmQgYWdncmVnYXRpb24gc3RhZ2UgaW4gR1JPLg0KDQpJbiBvdXIgdGV0aGVyaW5nIGNhc2Us
IGBOQVBJX0dST19DQihza2IpLT5pc19mbGlzdCA9ICFza2AsIHNvDQpgaXNfZmxpc3RgIGJlY29t
ZXMgYHRydWVgLCBhbmQgdGhlIHNrYiBmb2xsb3dzIHRoZSBgU0tCX0dTT19GUkFHTElTVGANCnBh
dGgsIGV2ZW50dWFsbHkgcmVhY2hpbmcgYHNrYl9ncm9fcmVjZWl2ZV9saXN0KClgLiBUaGUgaXNz
dWUgaXMgdGhhdA0Kc29tZSBsYXRlciBza2JzIG1heSBhbHJlYWR5IGNhcnJ5IHRoZWlyIG93biBg
ZnJhZ19saXN0YCBhcyBhIHJlc3VsdCBvZg0KdGhlIGZpcnN0IGFnZ3JlZ2F0aW9uIGRvbmUgYnkg
dGhlIGRyaXZlci4gV2hlbiBHUk8gbGlua3MgdGhvc2Ugc2ticw0KYWdhaW4gaW50byBhIG5ldyBg
ZnJhZ19saXN0YCBjaGFpbiwgdGhlIHJlc3VsdGluZyBza2IgbGF5b3V0IGJlY29tZXMNCm1vcmUg
Y29tcGxleCB0aGFuIGV4cGVjdGVkIGFuZCBldmVudHVhbGx5IHRyaWdnZXJzIHRoZSBrZXJuZWwN
CmV4Y2VwdGlvbi4NCg0KQWN0dWFsIHNrYiByZWxhdGlvbnNoaXBzIHdoZW4gdGhlIGlzc3VlIG9j
Y3VycyBpcyBhcyBmb2xsb3dzLg0KQS0+ZnJhZ19saXN0ID0gQg0KQi0+bmV4dCAgICAgID0gQw0K
Qy0+ZnJhZ19saXN0ID0gRA0KDQpJbiB0aGUgb2JzZXJ2ZWQgbGF5b3V0LCBBIGFscmVhZHkgbGlu
a3MgYEIgLT4gQ2AgdGhyb3VnaCBgZnJhZ19saXN0YCwNCndoaWxlIEMgaXRzZWxmIHN0aWxsIGNh
cnJpZXMgaXRzIG93biBgZnJhZ19saXN0IC0+IERgLiBJbiBvdGhlciB3b3JkcywNCndoZW4gR1JP
IGNvbnRpbnVlcyBjaGFpbmluZyBza2JzIGluIGBza2JfZ3JvX3JlY2VpdmVfbGlzdCgpYCwgdGhl
IGxhdGVyDQpza2IgaXMgbm8gbG9uZ2VyIGEgc2ltcGxlIHN0YW5kYWxvbmUgcGFja2V0LCBidXQg
YW4gc2tiIHRoYXQgYWxyZWFkeQ0KY2FycmllcyBgc2hhcmVkX2luZm8tPmZyYWdfbGlzdGAgZnJv
bSB0aGUgZHJpdmVyLXNpZGUgTFJPIHN0YWdlLiBUaGlzDQpjcmVhdGVzIGEgbmVzdGVkIGBmcmFn
X2xpc3RgIGxheW91dCBhbmQgZXZlbnR1YWxseSB0cmlnZ2VycyB0aGUga2VybmVsDQpleGNlcHRp
b24gaW4gb3VyIGNhc2UuDQoNCj4gPiBGaXg6IEFkZCBOQVBJX0dST19DQihza2IpLT5mbHVzaCB2
YWxpZGF0aW9uIHRvIHRoZSBlYXJseS1yZXR1cm4NCj4gPiBjaGVjayBpbg0KPiA+IHNrYl9ncm9f
cmVjZWl2ZV9saXN0KCksIG1hdGNoaW5nIHRoZSBkZWZlbnNpdmUgcHJvZ3JhbW1pbmcgcGF0dGVy
bg0KPiA+IG9mDQo+ID4gc2tiX2dyb19yZWNlaXZlKCkuDQo+ID4gDQo+ID4gRml4ZXM6IDg5Mjg3
NTZkNTNkNSAoIm5ldDogYWRkIGZyYWdsaXN0IEdSTy9HU08gc3VwcG9ydCIpDQo+IA0KPiBUaGUg
Zml4IHRhZyBpcyB3cm9uZywgc2hvdWxkIGJlOg0KPiANCj4gRml4ZXM6IDNhMTI5NmEzOGQwYyAo
J25ldDogU3VwcG9ydCBHUk8vR1NPIGZyYWdsaXN0IGNoYWluaW5nLicpDQo+IA0KDQpJIHdpbGwg
dXBkYXRlIGl0IGluIHRoZSBuZXh0IHBhdGNoLg0KPiAvUA0KPiANCg==
