Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543262D23A6
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 06:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791958100; cv=fail; b=X0TmL/jDSzYxM/XogDfRIgTTgM75mbiP080R1kXE24NV4GktzU37SC2nQCDx48QVWp2l/smj4Z6YVT9d+47d8kPkAfqMXz3hjIsqwlmM+M/dUBx3fagi+Cen/U3n+Wn49tlQweycPPGA9fw4X5jsO8FssOFksCqJxk5YCWUADFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791958100; c=relaxed/simple;
	bh=sxspLnORwtC79jjWI93R3h0L0lmvFAuPlPQxO/svHvw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qV9mweIFd6plcLbeaBVZ8Gnp+LpN5UMN8t9tdrM8aiUd4wtULeFP0mQRksfnGlQQYDmh5JnV7HNS/lxpMfbMfgCqqTzZaSYzSIPL/Z1qAoYUCeqGUPzpOY56bp5zTIzD86jZK9n5f+uztAc3KG3RI4+Z0IVOwBHUPii70R+jC/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HTckmHwx; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=hN2C3wio; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HTckmHwx";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="hN2C3wio"
X-UUID: a2b94e6ec79511f18dc8c9802ae25ab1-20261014
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=sxspLnORwtC79jjWI93R3h0L0lmvFAuPlPQxO/svHvw=;
	b=HTckmHwx/UueKP7j+tUSsYd7at61vZ1h0je2UEFmHPaKDB4CeJXGxZz8P2Io3bw0wtXpEwXdYu2Hc/pKfzdXU1QDbVhse7mjLOmbBixLMnlqLj0nkBwFZeKvAPmdoQoTH284Sj/tJkDiGq/vzcqatD011ZEga8SNW+SOICkX3PA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:b5a430e5-fd42-498a-9d13-442522456484,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:291e20b,CLOUDID:0c395395-3103-4fdb-b79c-08de0e281a5d,B
	ulkID:nil,BulkQuantity:0,SF:80|83|102|110|111|836|865|888|898,TC:-5,Conten
	t:0|15|50|99,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a2b94e6ec79511f18dc8c9802ae25ab1-20261014
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2033759951; Wed, 14 Oct 2026 14:08:11 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Oct 2026 14:08:07 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 14 Oct 2026 14:08:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t43+qmf5JFsoU+csqadYdONGCLDX3yHIf6R7qM3uRIRdbTyBV/Ut+Y8Lns6r48p1ZIDQ7F16KzN/ajnpSRxKoAwnkPhXBjfdRaGlbTiCMWXC4nO84rXIOX6skWkr+Q/ATGxbgzuteD94TlQoDtS/RLyO0OZCInVyfj37pF669lVzqm8yPPPKmMKv5ahOJ3NWfn2ichzm+AIkgXJJ9De338/1SlwR3tRqpA32zZ7//iSgNIeSfK1JGroFomC2PhdcW8qX98QXXIGzPQnQFDH2806rYnlucPIemIiIP6uCAu8ZgVIHhA4CmGw2GTdgg1GUhsWROMBjcdgAFc/N+wWvtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxspLnORwtC79jjWI93R3h0L0lmvFAuPlPQxO/svHvw=;
 b=eB0gpNW2D7+p/t5MgeEpjuty8Z/VQ6aBd7FGSJ6amBh67SVjBreRQ7nbGuM95506qttk96t7enKzUe34iq5RWcjGZdezbaZ9xgVEd4K1sMLVGiOsf/E3PpBhDhidA0udpARwjONUwfnQOXu38QDSI5RBNr416FTanMM1IS2rYkV4YLGGSAOMsnK5lHMigADDy1GpzFKn80icb47l76k2si9sYpCQ8mdpfWnHVQLIv0Xt1Q4bxso/ycX1GIm28DRVyTkIexOeriivKWuNb1LoTo0Z62w1okbOypGqJhPBxJx41AaSATGemcxY0JgrH66COdJrMjgGPl6ASIaoaA6rzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxspLnORwtC79jjWI93R3h0L0lmvFAuPlPQxO/svHvw=;
 b=hN2C3wioFbZh+Hqqb/Sv0VFb4I7XdILW2DPLwoTgA8EA2EpKweXP1D1yAZhzAHz+n4NKq/c70XsSx5oEJy6nO/5QOOinC/827g1suY7czFJkTU/Mqr1uUaaV6p0cMR5u8IrLhM3KdhkPiXwRLownSF5OmYY2U6qAl8iH8Peid7k=
Received: from SEZPR03MB7297.apcprd03.prod.outlook.com (2603:1096:101:12e::13)
 by SEYPR03MB6577.apcprd03.prod.outlook.com (2603:1096:101:88::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 06:08:02 +0000
Received: from SEZPR03MB7297.apcprd03.prod.outlook.com
 ([fe80::2b09:706f:a978:eefc]) by SEZPR03MB7297.apcprd03.prod.outlook.com
 ([fe80::2b09:706f:a978:eefc%6]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 06:08:01 +0000
From: =?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] net: gro: mark frag_list GRO packets as SKB_GSO_DODGY
 when a list element exceeds gso_size
Thread-Topic: [PATCH] net: gro: mark frag_list GRO packets as SKB_GSO_DODGY
 when a list element exceeds gso_size
Thread-Index: AQHdW6JeFSucny2XekWJx13PvyLe/Q==
Date: Wed, 14 Oct 2026 06:08:01 +0000
Message-ID: 65d07d7d92f1b6cda01f303928e0ae83391427ec.camel@mediatek.com
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7297:EE_|SEYPR03MB6577:EE_
x-ms-office365-filtering-correlation-id: a44c78e6-d2b3-4a8d-db60-08df29b980cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|38070700021|921020|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003;
x-microsoft-antispam-message-info: cxKxC20UgMaavqEegJjdfvYd0R+5P5yyTepOomVieXjokQDoNFm/BRFGPv+oowUcWkPZCc9I1cjyqZN/pb2Qc9JKnEIbW9tSYmta0XhiwIyMnnm4Gd18lRdnZkHqRyrveMHKc77eBiAFlOingN0cc1YM4EHPFGYQuEI8M4PUM+W3kydSLDba6zBL8kAWd56Y+FDwfrFr5dqYM9bPQHKABRg7o35xKYZRr06wxFr7/fan9do7lKzkePaycWo2c/S4nflDr+Jcezk1nGvHGw5BiVG1h6Wy0EklqXWy56xMvc9a7/RdOAYgNrtAddQKGj72Eh30flC6ZHd39hrIVWWpxvyzZaOqfu++lYzhzN/MzZgStA/7oRXsJ1JAsSEPcresUKyDsjAt2jFqdkqL5caY9P/pmb6Go4+TZrbUWom12VYmtVmWdtLeeamxlvQlma7huo9xgWtAz4bJIUxDsdc22ejq5HYSEwARURy8BkVhgKw644Q8xmjDOewycM6da+HyDytWLIBaPV3GHFwK3Nb30gIt4ZOwuByPShwQXtRFA6OFWt+94dSVOJWASHOCCvzUFmnnUqDh+6jWpixXxFeufgaQvCBpTLzOqBLjIDcshLhQSMeVmZuCByhbS8aOgrRjAm81DEO+/Jk/RaKXN2i/Ta1zoQpRERgFzFKHZkK3mu3Ka5vEcZRZaIm36SEBXxZC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7297.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmdKK0d5MWNTNGVxL29VRncwR0Nidnc0Ym4ya1BGc09BZi9iWWI0WXZmWEF3?=
 =?utf-8?B?aklxMlZqK1NvUzR4NmlnNldOa0NxWlV6K21renIxVk1HalhsVGlCNUdMcTho?=
 =?utf-8?B?TUZuaXkwdzJvYy9ZcS9TYUNsaW53YWdRa2d2ZlEvc0J3SlZGLzJtRitqcEJo?=
 =?utf-8?B?UFc4a0E3RktZTng0VmhiRTRMd0c2b0hwZ0VwRFRCV1hud1AxRzc4YjJPRXR1?=
 =?utf-8?B?aHc0SXAzc1hRRUFCaGc2Vm5LQ0RDR2syeDlldVIxc3k5SUsvY3hVdm1DM0cv?=
 =?utf-8?B?cTB2WjU5WVhQbHRBNGh6dDd2cWh6K3FwSUNBN2x6eXVYcHpjUTk1VmdGYkta?=
 =?utf-8?B?K1I4Yk1wYStET3QyN1FVQmxYNEhxZEdwZXFFWmM3KzdITzNOYlRwSlg5ZmtD?=
 =?utf-8?B?WVp6ZjBIYlNZUjREblc5ZkczMFA0VGRScXAvZ28zdTBsNWg4ZEJEYVNORmdS?=
 =?utf-8?B?L2hmQkY2YStVSWs4WXBHMkJSYnRxeVlxaUNGWWJlWUFxNmEwdFEvNWZCQ0E3?=
 =?utf-8?B?MjN2cWVjYmlxeGxPcVdadUdyK2JNQytYNW14L0Ntak9MaGtkV01YRW1kVFQy?=
 =?utf-8?B?cWkxWVNieTR2c1NJMU9WRVhOMVZiRTMyalNMS0xHQ1JXYlRWeXl1YnpBeGVp?=
 =?utf-8?B?QW1HcmQ3dkdJZUo3RUMxcTZLdTNKUW1zQWVCZjhCTlZVUSt4cGR5UWFMQW5j?=
 =?utf-8?B?bGhPeFp3Uk1XSjVMdGIxTkRpMzhIaFN0blBpZEt4Tm52Njc2ZzlldldDUkxQ?=
 =?utf-8?B?UUxkbFhsSmcrZ2Nsc1UvMlUya0ZsMWN1S0dCejhXb21SZ2lLOUtWY0syYWw0?=
 =?utf-8?B?K2dPRXd4UUZDVU9tOVBveGFhTnJ1Q3RmckFCSFJheE4zQjIxVXFURmlwRlRM?=
 =?utf-8?B?K3NYSWVFdElMdjNjU1BUTGFzd3lJMEhZcGN4SFcrWWFqM0ZNRUJ4MjRPV3FX?=
 =?utf-8?B?MlJDcFJuZzBMa0ZmUzM4UEtvQmdEandlQ0k4V3NaQWNVT2NLVGN3ZmVFTWdq?=
 =?utf-8?B?QWxqMXpia1ZmYTd5MUN3YXFLQmo3S2xXU1ZGWVprTWtIVUxoZENYWjR0UHFi?=
 =?utf-8?B?aThBVlovS1ErNWNFRmdHUHoxZzBoZll4emIxT3lVMElJNWNYUXBUcFpYb1Z2?=
 =?utf-8?B?Z3p4cXhrMG10SDBsZEJHUXpyVVcyRU82RXNYQm00TE5GMGJuNEY3T0wxdnJ4?=
 =?utf-8?B?RmNuTmFrYWZXTDc0Z1ZNb0ZVOXJnQm1GemZtb3V1emZGQktGRkVLTEtmak9z?=
 =?utf-8?B?U0MwQVdaYm5HN01vdzgzZlA3SlI2c3pBMFA0ekdiTlhSVHk1S1A0RzRwZG5Y?=
 =?utf-8?B?KzBOMWUzMEphQ3Y0SnFsRjVIWXFwbmU5d2piRWw2ajBMTzhlTUxHNFNXMnBO?=
 =?utf-8?B?ZHlBSjdja3ZqVi9zTmRZQ0gzaXVkbFUzOUNCMlNaeExrVmFKYlh3eW0vOHZ6?=
 =?utf-8?B?Z0xoZW5TVjZpVWh6Y2F2VmRYMUNUQldIUkdSS21rSUxVZTN4UWgyL3hTbDRK?=
 =?utf-8?B?cWU0Sys0VnVyZDE2OWpsVmlPREFObEpBMWtnKzFjS3o0akxKOU1WN3ZzdkRq?=
 =?utf-8?B?L0VlWlM1Vmx4cTg0a2poZ3htTmtIVkZneUhueU5BcVlaVW44K0JobmZ6N1dy?=
 =?utf-8?B?QVYxT0pPWERldmNmTFZiREU3NnN5OHlUSEhST1hVQ1dSaFE1akdlZkFJMmRR?=
 =?utf-8?B?c25mY2M2QnNLNmFqbHJkYjR5U3hzLzZ5MGo4UW52ZHp0VG5xR0V3dk90clMw?=
 =?utf-8?B?V2czbzBEZllJUWQvSnNGRVVCaVlxQWNkVndqZnkzRVUvT1ZwQmlhdnFOWVow?=
 =?utf-8?B?YmNiTTN3UmFsK1Uya1FxVi9ITDlOcWFtUmV0b2VDVGd4NzJUaS9LMHJmaldH?=
 =?utf-8?B?V09sNnhnMkhwZnl0SXpPTmRFTStsK01oWTFDWElOQlJvNWxDRktoa0hZbysw?=
 =?utf-8?B?d0dLelpraTdJc2JDTXJiU01tcE1hSmlwMjRqbTNiK2piSE9SOGcwNzFacnNu?=
 =?utf-8?B?Zi81ZlNoQXp0VlpnU2xrQ3VaMjVpSDJqVi9rb0VaNTVWQnJxY1JTKzFVVEYw?=
 =?utf-8?B?NTY2ZGc3alYySmRZeU94UlNTQzFBZzcyZUlCVE5Vb3N0SmowUGRzbHdScUVO?=
 =?utf-8?B?WkJrbmxxRXZudGdpbXFDbjhUTFBNRXVxSVNJRVh3ckptK1Y2aitHVXVxTXJQ?=
 =?utf-8?B?blZBMVo1WVhtdjNtbDhuN2FWSmI3UEF1cTUxbnpmL0lqMWRLNFVka2VGTXhx?=
 =?utf-8?B?Uzk2RW9naVh1KzZyNzJNWjUrM1lodUxJcHpHSGpGLzhyQ2hrQUNIemczTVBZ?=
 =?utf-8?B?UExocHMrUU1vVnJSRWlDcEhYOW1SdVcvVUdUZkQxSWU0S3hEaVlFQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gemxSyX3V9kWc+ULH1n67YnsetrAFsUm4qWjp4iuJ94LlLi1HBW0iXinoN022abrXTHFmzJexjb358zOIyZOdzXP+GpvXDP4/OXVs8t4RzhmgLdeEvTszXXqQtsvDaMOhmKFtEP4tnNSs9f+FK/UpCewCWb/z8IEOs3OZG5aJXYhooepBM2unoHeJITr//BUWB+Lq7uEL2PYvMXIXtUMxAMTaYcmZiEOIAYhzSwYXtZsu6grD2zZSPIuCGdY7vr+Dszxb5oQmB/JgOYhTTZ1zK7rlj2hJmyco80AA9DO7Q4R/uOlQx6ZulXT7Lp5q1PXmEU0usSVZoK2JK240H6M7A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7297.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44c78e6-d2b3-4a8d-db60-08df29b980cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 06:08:01.5435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NBW0VzUNOHpyqAtjfgF6g3/BmXy1FfZHM4KpvwIvmWK/inZ5uEMgNNluHkMewRqRX62yVbk4o4+Hvv1ujifRWbGYr8VUjMIIe/3cAPd2/rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6577
X-MTK: N

RGVhciBXaWxsZW0KCldlIGZvdW5kIHRoZSBzYW1lIGlzc3VlIGluIHRoZSBjb21tdW5pdHksIGFu
ZCBpdCBoYXMgYWxyZWFkeSBiZWVuCmFjY2VwdGVkIGFuZCBtZXJnZWQuIFRoZSBzb2x1dGlvbiBh
ZG9wdGVkIHRoZXJlIGlzIGRpZmZlcmVudDoKdGhlIGFwcHJvYWNoIGRlc2NyaWJlZCBpbiB0aGUg
bGluayBiZWxvdyBwcmV2ZW50cyBHUk8gcGFja2V0cyBmcm9tCmJlaW5nIG1lcmdlZCBpbnRvIHRo
ZSBmcmFnbGlzdCBwYXRoIGFuZCBpbnN0ZWFkIGZhbGxzIGJhY2sgdG8gdGhlCnRyYWRpdGlvbmFs
IG1lcmdlIHBhdGguClRoZXJlZm9yZSwgdGhpcyBwYXRjaCBjYW4gYmUgd2l0aGRyYXduLgoKaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4
LmdpdC9jb21taXQvbmV0L2lwdjQvdGNwX29mZmxvYWQuYz9pZD0yYzJiMjI5ZDQzOWEwM2E1MTY3
ZjYxNDliYTk0MmJiYjY5Zjc5ZmY4CgpUaGFua3MKCgoKT24gVHVlLCAyMDI2LTA5LTI5IGF0IDEx
OjI4IC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+IAo+IEV4dGVybmFsIGVtYWlsIDog
UGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsCj4geW91
IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4KPiAKPiAKPiBTaGltaW5n
IENoZW5nIHdyb3RlOgo+ID4gV2hlbiBSWCBMUk8gKG9yIHNpbWlsYXIgb2ZmbG9hZCkgaXMgZW5h
YmxlZCwgdGhlIFRDUC9JUHY0IEdSTyBwYXRoCj4gPiBtYXkKPiA+IGFnZ3JlZ2F0ZSB0cmFmZmlj
IHVzaW5nIGZyYWdfbGlzdC4gVGhlIHJlc3VsdGluZyBza2IgaXMgbGF0ZXIKPiA+IHNlZ21lbnRl
ZAo+ID4gdmlhIHRoZSBmcmFnX2xpc3Qgc2VnbWVudGF0aW9uIHBhdGggKHNrYl9zZWdtZW50X2xp
c3QoKSkuCj4gPiAKPiA+IEhvd2V2ZXIsIHNvbWUgZHJpdmVycyBjYW4gaGFuZCBHUk8vTFJPLWFn
Z3JlZ2F0ZWQgZnJhbWVzIHRvIHRoZQo+ID4gc3RhY2sKPiA+IHdoZXJlIGluZGl2aWR1YWwgZnJh
Z19saXN0IGVsZW1lbnRzIGFyZSBhbHJlYWR5IGxhcmdlciB0aGFuCj4gPiBza2Jfc2hpbmZvKHAp
Cj4gPiAtPmdzb19zaXplIChpLmUuLCBhbiBlbGVtZW50IGl0c2VsZiBjb250YWlucyBtdWx0aXBs
ZSBNU1Mgd29ydGggb2YKPiA+IHBheWxvYWQpIGFuZCBtYXkgYmUgbm9uLWxpbmVhciAobnJfZnJh
Z3MgPiAwKS4gVGhpcyBzaGFwZSBpcyBub3QKPiA+IG5hdHVyYWxseSBwcm9kdWNlZCBieSB0aGUg
c29mdHdhcmUgR1JPIGFnZ3JlZ2F0aW9uIGxvZ2ljIGZvcgo+ID4gZGV2aWNlcwo+ID4gd2l0aG91
dCBMUk8sIGFuZCBjYW4gbGVhZCB0byB1bmV4cGVjdGVkIGJlaGF2aW9yIGluIHRoZSBmcmFnX2xp
c3QKPiA+IHNlZ21lbnRhdGlvbiBwYXRoLgo+IAo+IERpZCB5b3Ugb2JzZXJ2ZSB0aGlzIHdpdGgg
YSBzcGVjaWZpYyBkcml2ZXI/Cj4gCj4gV2UgZG9uJ3Qgd2FudCB0byBoYXZlIHRvIHN1cHBvcnQg
ZXZlcnkgY3JhenkgZHJpdmVyIHNjaGVtZS4gVGhlIHJpZ2h0Cj4gYXBwcm9hY2ggbWF5IGJlIHRv
IGZpeCB0aGUgZHJpdmVyLgo+IAo+IFRvIHVuZGVyc3RhbmQgdGhlIGdlb21ldHJ5OiB0aGUgZHJp
dmVyIHBhc3NlcyBhIEdTTyBza2Igd2l0aAo+IGZyYWdfbGlzdCwKPiB3aGVyZSBmcmFnX2xpc3Qg
bWVtYmVycyBtYXkgYmUgYW55IHNpemUsIG5vdCBqdXN0IGdzb19zaXplPyBJLmUuLAo+IHRoZXNl
Cj4gZG8gbm90IGNvbmZvcm0gdG8gU0tCX0dTT19GUkFHTElTVCBydWxlcz8KPiAKPiBJIGRvbid0
IHJlY2FsbCBpbW1lZGlhdGVseSB3aGF0IHRoZSBhY2NlcHRhYmxlIGJlaGF2aW9yIGZvciByZWd1
bGFyCj4gR1NPIHNrYnMgd2l0aCBmcmFnX2xpc3QgaXMuIEJ1dCBmb3Igc3RhcnRlcnMgc3VjaCBh
IGRyaXZlciBzaG91bGQgbm90Cj4gYWR2ZXJ0aXNlcnIgU0tCX0dTT19GUkFHTElTVC4KPiAKPiA+
IAo+ID4gRGV0ZWN0IHRoaXMgY29uZGl0aW9uIGR1cmluZyBmcmFnX2xpc3QgYWdncmVnYXRpb24g
YW5kIG1hcmsgdGhlCj4gPiBhZ2dyZWdhdGVkIHBhY2tldCBhcyBTS0JfR1NPX0RPREdZIHdoZW4g
YSBsaXN0IGVsZW1lbnTigJlzIGxlbmd0aAo+ID4gZXhjZWVkcwo+ID4gZ3NvX3NpemUuIFRoaXMg
Zm9yY2VzIGEgbW9yZSBjb25zZXJ2YXRpdmUKPiA+IHNlZ21lbnRhdGlvbi9saW5lYXJpemF0aW9u
Cj4gPiBiZWhhdmlvciBkb3duc3RyZWFtIGFuZCBhdm9pZHMgcmVseWluZyBvbiBhc3N1bXB0aW9u
cyB0aGF0IGRvIG5vdAo+ID4gaG9sZAo+ID4gZm9yIExSTy1wcm9kdWNlZCBhZ2dyZWdhdGVzLgo+
ID4gCj4gPiBObyBjaGFuZ2UgZm9yIG5vcm1hbCBzb2Z0d2FyZSBHUk8gYWdncmVnYXRpb246IHRo
ZSBuZXcgY2hlY2sgb25seQo+ID4gdHJpZ2dlcnMgd2hlbiBza2Jfc2hpbmZvKHApLT5nc29fc2l6
ZSBpcyBzZXQgYW5kIGEgZnJhZ19saXN0Cj4gPiBlbGVtZW50Cj4gPiBsZW5ndGggZXhjZWVkcyB0
aGF0IHNpemUuCj4gPiAKPiA+IEZpeGVzOiAzYTEyOTZhMzhkMGMgKCJuZXQ6IFN1cHBvcnQgR1JP
L0dTTyBmcmFnbGlzdCBjaGFpbmluZy4iKQo+ID4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3Jn
Pgo+ID4gU2lnbmVkLW9mZi1ieTogU2hpbWluZyBDaGVuZyA8c2hpbWluZy5jaGVuZ0BtZWRpYXRl
ay5jb20+Cj4gPiAtLS0KPiA+IMKgbmV0L2NvcmUvZ3JvLmMgfCAzICsrKwo+ID4gwqAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9uZXQvY29yZS9n
cm8uYyBiL25ldC9jb3JlL2dyby5jCj4gPiBpbmRleCAyOWI0ZDAyYmY1MTkuLmU3MGVjZjE5YjBh
NyAxMDA2NDQKPiA+IC0tLSBhL25ldC9jb3JlL2dyby5jCj4gPiArKysgYi9uZXQvY29yZS9ncm8u
Ywo+ID4gQEAgLTI1OSw2ICsyNTksOSBAQCBpbnQgc2tiX2dyb19yZWNlaXZlX2xpc3Qoc3RydWN0
IHNrX2J1ZmYgKnAsCj4gPiBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQo+ID4gwqDCoMKgwqDCoCBza2Jf
c2hpbmZvKHApLT5mbGFncyB8PSBza2Jfc2hpbmZvKHNrYiktPmZsYWdzICYKPiA+IFNLQkZMX1NI
QVJFRF9GUkFHOwo+ID4gCj4gPiDCoMKgwqDCoMKgIE5BUElfR1JPX0NCKHNrYiktPnNhbWVfZmxv
dyA9IDE7Cj4gPiArwqDCoMKgwqAgLyogZnJhZ19saXN0IGVsZW1lbnQgbGFyZ2VyIHRoYW4gZ3Nv
X3NpemUgKGFscmVhZHkgY29hbGVzY2VkCj4gPiBiZWZvcmUgbGlzdC1hcHBlbmQpICovCj4gPiAr
wqDCoMKgwqAgaWYgKHNrYl9zaGluZm8ocCktPmdzb19zaXplICYmIHNrYi0+bGVuID4gc2tiX3No
aW5mbyhwKS0KPiA+ID5nc29fc2l6ZSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2ti
X3NoaW5mbyhwKS0+Z3NvX3R5cGUgfD0gU0tCX0dTT19ET0RHWTsKPiA+IAo+ID4gwqDCoMKgwqDC
oCByZXR1cm4gMDsKPiA+IMKgfQo+ID4gLS0KPiA+IDIuNDUuMgo+ID4gCj4gCj4gCgo=
