Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CDD2931E5;
	Thu, 16 Jul 2026 01:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784166097; cv=fail; b=JrcSkwfX3ff+l+schFeyjFspkx/9I8VWFcbDEmvomIY0UM4tjAj8KziSVY6DnrWClf8upgQUI2gm4xG5lY2GIpzFO9T+OCkDCnTZFssnfcB14GdqoRnKjEtrBNPD8I4EsdP3w1Q4DdrjMuy8y6CDmM9HC5cVK6utxECWqkhNzz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784166097; c=relaxed/simple;
	bh=7UNjUHE/j8n6PrtgWvZsWGeXaj9PGwPOJA2CZcCsLe8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X6fLK/O3XsoTSEsTrZ8sAkKLujowwdMsSvEHTVje/hsvTJpR94YiQ+aiw4Q5A9tgFZio1BpFH720IkF+amObSmGw/MNExsgYwPGidUe62CrWa7nBFG0CS6w1DJAROzd+Co5xYBhSrQpopzDCewgI9PPo79FnpPJRrV5bDzC4E/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ttyDfKsL; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=uu0bIBHh; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ttyDfKsL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="uu0bIBHh"
X-UUID: 6ff6884080b711f18dc8c9802ae25ab1-20260716
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7UNjUHE/j8n6PrtgWvZsWGeXaj9PGwPOJA2CZcCsLe8=;
	b=ttyDfKsLpBEbecj6eUR3ykbMkGijYv8OR/IQb2+VTQc0d5JIrBtIz70IUA1OdMzn6UU4KL2VdCLJMAya13t5kLo+m4DgbDH7K7XShmSjgsuEBewoSqZjgsWpBO1lMhEFDIjmI+xVt4Wtz6UHXEZqUBfb8qti5MwoQQ+vGqlu0co=;
X-CID-CACHE: Type:Local,Time:202607160941+08,HitQuantity:3
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:284f44bb-f716-4ab5-9740-8ebd45c46115,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:8d052d19-ab14-4403-9336-76696324c5a8,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
	1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6ff6884080b711f18dc8c9802ae25ab1-20260716
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 911749909; Thu, 16 Jul 2026 09:41:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 16 Jul 2026 09:41:16 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 16 Jul 2026 09:41:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGj38DVOHn3llMQ6sZO8Cj9PxAo/YBP0X+G2dg38Qy0C3gjsMSqHzWDLIbCJLwVDKqsEaH0kfQUiKzBXo8lvwg4cAuJVwd83JBkT11t6I3V/Ty/qSHNHq7fBrm3kytK5mRANqCj9oWJmxwm36nw+rU9DGjN7dcv1mUr/FC/7aSySPRq2HSAP68VszDzo6aL6V+lGIZw42hgyKtQrmxGAB4rbHCJ6ImExqNnBDN1CCoHVua+UQnLRzIT7ZTqygw8fj/SYhU8FOL+5ksD9MSnwUigve83Bd5Sfc35Na/LcsdbU9oY/oBplZz38WsCWA8qS5bJX0HSoMX/+5C26FxMSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UNjUHE/j8n6PrtgWvZsWGeXaj9PGwPOJA2CZcCsLe8=;
 b=t1S3NmU6Wpl0EeGciWrNG79/3ak/iUEFPbgKT825IhlKw7h1hI1EqfA/Tnx5lFoYs0QpU0kOiP83Bqyc+STMYqC223xaBjfWWfwZyrsSyLggzqfh9UczdQdi9H3B4xFTY+MjHsEIm4jLlKAwKxQ5mwEDQXh9SlGKSRi2INQ0LLpS2Mcp5Fdn/3oCNF1ElS/RaUM/PG9fkaafr+SVYgrKRk/JFZCUqFjoD5yk+ndwggJopp50HAegc4mGjFA+mAQo30nqDuxtDsuRYk/tZjp/fFzyV7TKn5wSkrNJnTWMzl85esfDXBdPxLDwyw4uGriExhqhZTCpbOKnYXP5dhao9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UNjUHE/j8n6PrtgWvZsWGeXaj9PGwPOJA2CZcCsLe8=;
 b=uu0bIBHh9HdaB8ducX5talM3F8HMMJqcfDghcj859axo7pjFqEUUo8cjm9L9w7qXd1AgCeSjNHnF4F6L1c9k4nOocSbDhJE3De8QQYjl+cHsHf11nkAtzPo3vB95qHtz+79kfw0KdKuVltQ/tCzU9KOVVo158CIisRQ95VTq5co=
Received: from PSAPR03MB5622.apcprd03.prod.outlook.com (2603:1096:301:62::11)
 by SG2PR03MB6802.apcprd03.prod.outlook.com (2603:1096:4:1bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 01:41:12 +0000
Received: from PSAPR03MB5622.apcprd03.prod.outlook.com
 ([fe80::b639:3572:f154:28d0]) by PSAPR03MB5622.apcprd03.prod.outlook.com
 ([fe80::b639:3572:f154:28d0%4]) with mapi id 15.21.0202.018; Thu, 16 Jul 2026
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
Subject: Re: [PATCH v7] net: gro: fix double aggregation of flush-marked skbs
Thread-Topic: [PATCH v7] net: gro: fix double aggregation of flush-marked skbs
Thread-Index: AQHdD0TntH9WuC0S/UGU0iIvT5fURbZkcMuAgAr5BgA=
Date: Thu, 16 Jul 2026 01:41:12 +0000
Message-ID: <99ce187af1495ffac592bfcf7ef97fc61a7f780b.camel@mediatek.com>
References: <20260709014704.3625-1-shiming.cheng@mediatek.com>
	 <willemdebruijn.kernel.2801a1401793d@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2801a1401793d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5622:EE_|SG2PR03MB6802:EE_
x-ms-office365-filtering-correlation-id: 6034bf08-703a-458f-96eb-08dee2db5167
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|11063799006|4143699003|6133799003|56012099006|18002099003|22082099003|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: GuaQGzatyb44/yQ4lFQ8cKiM942362L+57WPsZ5fcHSSCDwSDH0dOzLbJ3ZZKlYg6Y661bgoxc+XQG5Mvh9CGIN4p+jTmTNIJCwlIbIml+d/NClATk5gJxStAYaZH8FLHu8rnMSWBY9EzWz+sESMzTdos7NLg0R49fUx80PPueAwU2YDV8DsJ+WnxPzNYJAagmLSERBmtGJcR+jki3/86Z//jrHq5ZNQcIOErO+kfNABL6gJGlkiAoDKk3tOH2NPhhMkt5vb7vlRNqsAI4XXf+MQ1MrEAp7GpaTSQPgGYjHIQxvMu2UOhoe10WuqoEaS/nlTNAqTKfiQqXHycf7VTx1BRj4m94to9j8dxXz2wibBSl34aknhHBRWaWCarcMTzqN0WRbKWvAKJkxfjBcQ+TqtZ5DKYl4CO9uXzLtmdwH/3MKNUOAOq4lc29sVnMkgDxxqmcRy7lbxmgZpKPvTVWl5Spd1EjqflffICpKY+8rIvDaOIrI1NuRH3FZUqslbc7qRV8PypwzEWHz7Wt2U7juvm2nYt+hQoVOAzRKlEBhBJ2t0W0SQd7CDbBBwkY1pvmqxZxDCj8h//c8eGgeKCjnCQ5HPzVjcyCWTQpxi822vziBkXoPlHGf99jBc3EpD7u4uLQZMJnC61hZtPC5ee6c/zNByQPuKwJCdDNOBSwtC5weFuyW4RVHiUqcPF4iw6OOQsEALd11k0E5BjmgkBMK4q0Jl7cW504Oqhnv5k8Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5622.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(11063799006)(4143699003)(6133799003)(56012099006)(18002099003)(22082099003)(38070700021)(10067099003)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTJVOEdSSG9CVnNrSGMzb2RIOEpPVWRDUmc5dHcrVjZJajFsT1lGTlpqcExZ?=
 =?utf-8?B?WGgzR2MrMVdtdU5Qc044QUxzdzFkamVKaDlleTBQL213QTgvNXpYU0loYmdz?=
 =?utf-8?B?bGVKNlU2dkVQNmdYaElYZ3VzVmNyZkREbUlJVkxTeUhyWUxQbHhNdmIxRFJr?=
 =?utf-8?B?cVBPb3ZQWS9tMTZCWFdTcVpEZjFiS3V6bGdRY1hjMUhwRklsN2J3QnZiZzlG?=
 =?utf-8?B?MGU3dTh4N2Vpd2JkV2ZLVHEyTjZzM1pBeGkybzhXb09rOTFGRFZVU0ZsUXMz?=
 =?utf-8?B?emJaV2w2bVQybXpoU3puNWZyTmU0OVowZlFBWEd2L0JOa0FOZGhGSUJqcTdC?=
 =?utf-8?B?dTJHdE8yZHNUaUtuaEIyY1p6RkRzdlQwTzd0bDVxd205UWxKaUZNY2pzSERv?=
 =?utf-8?B?Tk45SjNFWmYvS3pzQk40Qyt1eHoxZ3UwZXFHeWNldDcxZWlaNk4yYkVZU0d3?=
 =?utf-8?B?ajI2VlBSRWFCb1p2aUx5dVRsQWtPNHIwZ3loRVBvTkxEaVZRalpETDF0NDE1?=
 =?utf-8?B?WnN5MWFXa3Rtbk9zMnpOZ3JLOWVKbU44VDZPbmE0amhaa01YclY3Skl2NTVK?=
 =?utf-8?B?NU5aZnprUU1YUzlLWDRWVHBlTDdYYkFMR0JyNnBwNU1sQW5NYkxCd2N6RFYv?=
 =?utf-8?B?WDZWRGU1R3JpZkdLc3NUWjZjR0UwUGgxdXFtUERnOWtLR0xDYlBGT1Q2QXQ3?=
 =?utf-8?B?T2E5K3dBZVR1aGxXNzF0V3VzN01jY3lKN1BTUnhBUWxHcVdEZW15d2d5c3BQ?=
 =?utf-8?B?M2RnOUlqVnhBUVJFYkpGa2VQT2FtRG5YVmQvM3BCK2FPMFR6cjJGaS9VMkpK?=
 =?utf-8?B?RzJpSmg2YTVVSkpYUitYZVl6ME5OM2FmeGxpMFkvV0xRNUtVOWN3NzNQeXA2?=
 =?utf-8?B?TExFUThRT0I2SXBOYlNFTWpMVW9PQXdMcmtZdG1sOVdyKzA5TnU4eSs2SDdy?=
 =?utf-8?B?T2ErQ3FSMVE1VlNIbGMwK000SG52d1FESzhtbDNIaUxmbmk4aUV2a3NvZlBY?=
 =?utf-8?B?WUZERVdJMlNsc0NGbFdaMG0rdi84eW0rQ2RwSFY0K3BLdWZ3YWZFWXg0SDNN?=
 =?utf-8?B?dVcwYWdraGVYU0xNdmQ4dHd1MHFrZzBwVzJxTzd1b3BjMUZnTVZGaEpKZ005?=
 =?utf-8?B?OGQvbVFraVAyZUg5L3VxM0FKMGYrMXJNNzVQK0tPYkJHOTZTaURnN1pPNUdT?=
 =?utf-8?B?QWtzMmc2bmhRdUtaenlSRGxScXdheVY3MGNobFphc3VOb2ZoNTVPb3h2WHlB?=
 =?utf-8?B?Wm1neHlRdXpiS0g1aXBhaVNhV2QxSm8xR0RicW5JMEVmWVp4QWtJN1VHQXp3?=
 =?utf-8?B?OVNkVXpDVjYxeGNsVGZNeUQzRlRZZ3BScXpFaWdYNjRoVmxlVjdoWWl4REp1?=
 =?utf-8?B?UEpQZVkzLzIzd2pycERhR3Byd2JsK1NUS2o3R3JXRmlEM0szOGtNTVA2T3li?=
 =?utf-8?B?LzNsenZVYm5MeXBJK0pPV0NUSUpIRk1OQVFWWGdCdDdwaHl6RWpMTk96cHY2?=
 =?utf-8?B?TEkrNVZEUTQyL2NWZWkrMnZoSmFGeFUrd01FNFBMVkF3OW1qMWRPeUpRQndR?=
 =?utf-8?B?T1FlYXl0enpRQjFOY1V5cTRRN0ZiYmpnYkpUbW9pTkludE05d25Id2lUUGo5?=
 =?utf-8?B?a1lFSmNCTlFqZ0oyYzlZSVc5SldnT0RoMFBtdnhaNGZKS1dkejVJVy9Qa0NX?=
 =?utf-8?B?QllVZTBoWkoyTldMVll2a1RSRDJyMVZKK2txRzZNU1J0SEpjY3k2SFNTODBz?=
 =?utf-8?B?eXpuTUlJU0FXdDN4ZGMvZzk4bldTRFdCRmhIcEUzSng0UWJSdThCSi95ZnQz?=
 =?utf-8?B?d0xGNDJzQUd0aEcwYWdVVHJZZExua0J4eHNpeFV3RmR0UlJxS0xxYWEzYk11?=
 =?utf-8?B?Y2pDbXBBcVhDTk5CRGFBbkxEMDJPdWFmYkV2ZTZXUThzT3ZLdnh6VUFYV1lU?=
 =?utf-8?B?ZjUzcXkvMllJNnRBTTBNdEcxbHV5STN2UzhaVU9BbDNNSWkvUHgxd0ZycHdj?=
 =?utf-8?B?cm9sSGZhZi9wdGJxRXM1cEppRkU0UnpybVMzNlJNZ0JudTZuZkx5YVg0SWtX?=
 =?utf-8?B?V3gvVFYzZWRxUndKelU3cFJQS0VuaEFBTEIvTDVqZ1Qwc2ZtTDFJS2xEV241?=
 =?utf-8?B?RXVrVmVzSTZZYzBjUk1RaU1scE5WMDQvcFJVVkk3NS90ODdjQzg0MjduSDRx?=
 =?utf-8?B?ajhxSEVwTlpoVDRudG5VTTA3V0lmMmIwUzJwT0FKMzVPVDVXVG9aQ3hBWFZR?=
 =?utf-8?B?dmJ2OE9TNHFBa1BVVnRVU0VGUVNkaUNHVjVkd3IzYlFXOG4vTzhSelk1dHhT?=
 =?utf-8?B?eXAyeUtzYzRXaXpodHNlWnFXYmdtY1hPQTJJUlRzR3VHUGt0Z1hMZ21qM2t6?=
 =?utf-8?Q?BlwpkCEwrUfLSboo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E7D0DE8F2F69F4F9DE9BB50AE0180E7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QQCgJO341eimU9PynRDc+GeLAEYaMw6JDIb1/Qe+cVCatceR7HflzfPjIvqtzhz5H9leP3gO+shtSoOLZqqBBsxsHGWTPMzFePdjTfV9YHyVavk8XessXPQfcXmj3pqy7P/oB4lfPXGMY9BNt4uR3+UklGJKQKWaHyKO0wXxXGcYeZzdZiAo3pDZe2E66hzSIop8g6oQLIb95Gjm6T8LqmpceLL1tIQcAKwJtlYITy8TGQbrKFjHhTrOwP2lcwztGlzGBjSrgK4ym+l+Dkjg2G7dbpf8yMf8L5k6hLVl45HQKnC7FPoNIQjYTbF5D18gNlWuzIL/F3VmkES2kf/Tpg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5622.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6034bf08-703a-458f-96eb-08dee2db5167
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 01:41:12.4321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQfxEDwfNQUF+Cu4X/xPk2Z3ibFe1md8Ee28Y/jxyx9NsKNYe/uxSqUegBDN0ctAH6AwOOLZ0f86Vs/itTm4D3hE1gXSipoi0VGZcJx2fi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6802
X-MTK: N

SGVsbG8gZXZlcnlvbmUsIA0KDQppdCBsb29rcyBsaWtlIHRoaXMgaGFzIGJlZW4gcGVlZGluZyBm
b3IgYSB3aGlsZS4NCklzIHRoZXJlIGFueXRoaW5nIGVsc2UgSSBuZWVkIHRvIGRvIG9yIGZvbGxv
dyB1cCBvbiA/DQoNClRoYW5rcw0KDQoNCg0KT24gV2VkLCAyMDI2LTA3LTA4IGF0IDIyOjA3IC0w
NDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBk
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2
ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiANCj4gDQo+IFJlbWluZGVyIHRv
IG1hcmsgcGF0Y2hlcyBbUEFUQ0ggbmV0IHY3XQ0KPiANCj4gKG9yIFBBVENIIG5ldC1uZXh0IHdo
ZW4gdGFyZ2V0aW5nIHRoYXQgdHJlZSkNCj4gDQo+IFNoaW1pbmcgQ2hlbmcgd3JvdGU6DQo+ID4g
Q29tbWl0IDBhYjAzZjM1M2QzNiAoIm5ldC1ncm86IEZpeCBHUk8gZmx1c2ggd2hlbiByZWNlaXZp
bmcgYSBHU08NCj4gPiBwYWNrZXQuIikgYWRkZWQgYSBmbHVzaCBjaGVjayB0byBza2JfZ3JvX3Jl
Y2VpdmUoKSwgYnV0DQo+ID4gc2tiX2dyb19yZWNlaXZlX2xpc3QoKSBsYWNrcyB0aGUgc2FtZSB2
YWxpZGF0aW9uLg0KPiA+IA0KPiA+IEFzIGEgcmVzdWx0LCBwYWNrZXRzIG1hcmtlZCB3aXRoIE5B
UElfR1JPX0NCKHNrYiktPmZsdXNoIG1heSBzdGlsbA0KPiA+IGJlDQo+ID4gcmUtYWdncmVnYXRl
ZC4NCj4gPiANCj4gPiBUaGlzIGFsbG93cyBhbHJlYWR5LUdSTydkIHBhY2tldHMgd2l0aCBleGlz
dGluZyBmcmFnX2xpc3QgdG8gYmUNCj4gPiByZS1hZ2dyZWdhdGVkIGludG8gYSBuZXcgR1JPIHNl
c3Npb24sIGNvcnJ1cHRpbmcgdGhlIGZyYWdfbGlzdA0KPiA+IGNoYWluDQo+ID4gc3RydWN0dXJl
LiBXaGVuIHNrYl9zZWdtZW50KCkgYXR0ZW1wdHMgdG8gdW5wYWNrIHRoZXNlIG1hbGZvcm1lZA0K
PiA+IHBhY2tldHMsDQo+ID4gaXQgZW5jb3VudGVycyBpbnZhbGlkIHN0YXRlIGFuZCB0cmlnZ2Vy
cyBhIGtlcm5lbCBwYW5pYy4NCj4gPiANCj4gPiBTY2VuYXJpbyAoVGV0aGVyaW5nL0RldmljZSBm
b3J3YXJkaW5nKToNCj4gPiAgIDEuIERyaXZlcjogR2VuZXJhdGVkIGFnZ3JlZ2F0ZWQgcGFja2V0
IFAxIHZpYSBMUk8gd2l0aCBmcmFnX2xpc3QNCj4gPiAgIDIuIERldiBBOiBSZWNlaXZlcyBhZ2dy
ZWdhdGVkIGZyYWdsaXN0IHBhY2tldCBhbmQgZmx1c2ggZmxhZyBzZXQNCj4gPiAgIDMuIERldiBB
OiBSZS1lbnRlcnMgR1JPLCBza2JfZ3JvX3JlY2VpdmVfbGlzdCgpIGlzIGNhbGxlZA0KPiA+ICAg
NC4gTWlzc2luZyBmbHVzaCBjaGVjayBhbGxvd3MgcmUtYWdncmVnYXRpb24gZGVzcGl0ZSBmbHVz
aCBmbGFnDQo+ID4gICA1LiBGcmFnX2xpc3QgY2hhaW4gYmVjb21lcyBjb3JydXB0ZWQgKGxvb3Bz
IG9yIGRhbmdsaW5nIHJlZnMpDQo+ID4gICA2LiBEZXYgQjogVFggcGF0aCBjYWxscyBza2Jfc2Vn
bWVudCgpLCBjcmFzaGVzIG9uIGNvcnJ1cHRlZA0KPiA+IGZyYWdfbGlzdA0KPiA+IA0KPiA+IFJv
b3QgY2F1c2UgaW4gc2tiX3NlZ21lbnQoKToNCj4gPiAgIFRoZSBjaGVjayBhdCBsaW5lIH40ODkx
Og0KPiA+ICAgICBpZiAoaHNpemUgPD0gMCAmJiBpID49IG5mcmFncyAmJiBza2JfaGVhZGxlbihs
aXN0X3NrYikgJiYNCj4gPiAgICAgICAgIChza2JfaGVhZGxlbihsaXN0X3NrYikgPT0gbGVuIHx8
IHNnKSkgew0KPiA+IA0KPiA+ICAgV2hlbiBmcmFnX2xpc3QgaXMgY29ycnVwdGVkIGJ5IGRvdWJs
ZSBhZ2dyZWdhdGlvbiwgd2hlbiBsaXN0X3NrYg0KPiA+IGlzDQo+ID4gICBhIE5VTEwgcG9pbnRl
ciBmcm9tIHNrYi0+bmV4dCwgc2tiX2hlYWRsZW4obGlzdF9za2IpIGRlcmVmZXJlbmNlDQo+ID4g
ICBOVUxML2NvcnJ1cHRlZCBwb2ludGVycyBvY2N1cnMuDQo+ID4gDQo+ID4gQ2FsbCBUcmFjZToN
Cj4gPiAgc2tiX2hlYWRsZW4oTlVMTCBza2IpDQo+ID4gIHNrYl9zZWdtZW50DQo+ID4gIHRjcF9n
c29fc2VnbWVudA0KPiA+ICB0Y3A0X2dzb19zZWdtZW50DQo+ID4gIGluZXRfZ3NvX3NlZ21lbnQN
Cj4gPiAgc2tiX21hY19nc29fc2VnbWVudA0KPiA+ICBfX3NrYl9nc29fc2VnbWVudA0KPiA+ICBz
a2JfZ3NvX3NlZ21lbnQNCj4gPiAgdmFsaWRhdGVfeG1pdF9za2INCj4gPiAgdmFsaWRhdGVfeG1p
dF9za2JfbGlzdA0KPiA+ICBzY2hfZGlyZWN0X3htaXQNCj4gPiAgcWRpc2NfcmVzdGFydA0KPiA+
ICBfX3FkaXNjX3J1bg0KPiA+ICBxZGlzY19ydW4NCj4gPiAgbmV0X3R4X2FjdGlvbg0KPiA+IA0K
PiA+IEZpeDogQWRkIE5BUElfR1JPX0NCKHNrYiktPmZsdXNoIHZhbGlkYXRpb24gdG8gdGhlIGVh
cmx5LXJldHVybg0KPiA+IGNoZWNrIGluDQo+ID4gc2tiX2dyb19yZWNlaXZlX2xpc3QoKSwgbWF0
Y2hpbmcgdGhlIGRlZmVuc2l2ZSBwcm9ncmFtbWluZyBwYXR0ZXJuDQo+ID4gb2YNCj4gPiBza2Jf
Z3JvX3JlY2VpdmUoKS4NCj4gPiANCj4gPiBGaXhlczogM2ExMjk2YTM4ZDBjICgibmV0OiBTdXBw
b3J0IEdSTy9HU08gZnJhZ2xpc3QgY2hhaW5pbmcuIikNCj4gPiBDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZw0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoaW1pbmcgQ2hlbmcgPHNoaW1pbmcuY2hlbmdA
bWVkaWF0ZWsuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IFdpbGxlbSBkZSBCcnVpam4gPHdpbGxl
bWJAZ29vZ2xlLmNvbT4NCg==
