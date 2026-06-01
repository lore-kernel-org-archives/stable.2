Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE630ACE3;
	Mon,  1 Jun 2026 04:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780289512; cv=fail; b=jmiEUHAC6KvXA1u+oSIzZSAaJRZ/zRX1quYeE8tRQpkzg1iIJuJtD0ioV/lmjj3YpaA1DnMGtw5aNEQW/i5T1lnQF9w4mmS58yL65VCk/f+LnZq2wSlJBaGpH8biIGZENEgAAoUTF1F3tcdF80Kljk7MJdZWukSnZnMRpAJkTbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780289512; c=relaxed/simple;
	bh=NdbeBnMwwO/06NIIct1pzqpW88FKJgeNEmSZbXX3QFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WlV7XA0rOFElPA2KR+rlta8WMic7js12tld1SlvUqVujjYp8sleXvz1Jkb42mrgUPtE7Ks3EEecSDVAmkVaRJMspzkPGbN9q5pnMaiPjUPYNk6kneH277/5j3h3sGKUqMLtJvHZTdRaVTQ4jkjZkqP9yFut5lzaTzR/O9pzTIW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=K1YojWO+; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="K1YojWO+"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VLqXLJ1009679;
	Sun, 31 May 2026 21:51:35 -0700
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023109.outbound.protection.outlook.com [40.93.201.109])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4efw8hvs48-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 21:51:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sb0uUjZzZmM2JbFR+MhINVqPnSfBxDJ8OK/ws+a62dwX6JkkPhl+NNJ/AE1oJRBR1gQq4ARpMuMCJkzELpOxdv4NsU90eqxmwQqhF1wZWL9N7XSFnjRRjP0u6K66j5fppcpR1XdUOCQEcbKv593GUTdjGEdNtMRzkIDfw3AfpNp0+EwuX14H6dhK1Gosj5nAwOnTmqoesGTtuNbzBaZCI3aS52LhBwVOA2q9AetWZyDCMr+6nCF8/1O7JRLuhZbQ73ngTiQ59VvLFRBNNCln4g9q2S4kuE4VTOlPEflF/rQhfGwZZ+1EBkcXMu+9/VYjfvzQV4g+oHIiUnLY9VcsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdbeBnMwwO/06NIIct1pzqpW88FKJgeNEmSZbXX3QFI=;
 b=LGgHNPzOqcHeLnn4tSrzIUCASDnB/E7KKeLD8/lfeUMAjFUG+FrPZ++oJvuwK08Ucde6xev1uwya97u90lnN2wllA3Lu3LsiHgH0cyxcVg0306do2kd5BRE+cqPd/6YMUARvixPHRzDW6UR09zLbljNAu6Ym69Mpr6EtGvhTGDZHLpk5MBzBAyhmeg80eQ7aL/ZcgIGxoEgniDsxtlp7gYnAe/oaplHtHem3Su7ZJf+GDqo+FjrvjT2ANFddGZpli1I9Xc+5RBzzxZfAV9O+bcdSE6IxHNmhcEuWs20RWDQ4KnYxpr0CifG9TQbpXyC9bz6e3QeUraTElecGHd9mpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdbeBnMwwO/06NIIct1pzqpW88FKJgeNEmSZbXX3QFI=;
 b=K1YojWO+LVGejkd47NwCw4hVle1eHcvAgwMSF1pAA3Jsjp43FRjROqKrQl6Tv5ZinViPq5HXBWWLq2H9lwXvQXnZkFN8dZZk+tkMiKS6V1SpOgbGU4mazSAPvfFwurch6Pjv1XC98FeutqDBs/xwu8hBqRXTg2rRKiA6m8gmwjo=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by BY5PR18MB3762.namprd18.prod.outlook.com (2603:10b6:a03:252::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 04:51:31 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540%2]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 04:51:31 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Junrui Luo <moonafterrain@outlook.com>
CC: Jakub Kicinski <kuba@kernel.org>, Yuhao Jiang <danisjiang@gmail.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Linu Cherian
	<lcherian@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya
 Sundeep Bhatta <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net] octeontx2-af: cn10k: restrict LMTLINE
 sharing to same PF
Thread-Topic: [EXTERNAL] [PATCH net] octeontx2-af: cn10k: restrict LMTLINE
 sharing to same PF
Thread-Index: AQHc7r7t5kiG/ngRIUCELBtlsYxPQbYpJG4g
Date: Mon, 1 Jun 2026 04:51:31 +0000
Message-ID:
 <CH0PR18MB4339A4A4D801F3D9E67317D0CD152@CH0PR18MB4339.namprd18.prod.outlook.com>
References:
 <SYBPR01MB7881F8D11D2930BB84215253AF0D2@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <20260526180233.4323832d@kernel.org>
 <CAHYQsXQ4qQa9nLc6re=Oobyojv3FVG9Pc+3KVEq4qKXEq3kXYg@mail.gmail.com>
 <20260526185224.0c65e38a@kernel.org>
 <BL1PR18MB4342FD927BAF986D33299F74CD082@BL1PR18MB4342.namprd18.prod.outlook.com>
 <E32D37DE-5401-4CC8-98F0-8EA944C331D1@outlook.com>
In-Reply-To: <E32D37DE-5401-4CC8-98F0-8EA944C331D1@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|BY5PR18MB3762:EE_
x-ms-office365-filtering-correlation-id: 72f12ff4-0e56-482c-b2b5-08debf9972fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|22082099003|18002099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 aGmf5jgd/4hftSqgASy7R5Xj3GVyMqJcFXs3J8nxtK+wOZ2Yx/fJK8Is3zyU9fS6hyl6TkN9dBjYSOsKL/jOn+3AGa9RfOZHqNYhdEPT5Gy//IYx7/22AJePR83nNy7cKCZuiwBL4hY+4go/60SHFfPNn5CX9QqXD5RM00M3H83jy0x3reRFgJDDtyrY9bAzTSflchDH6ZiROGV0XfuyTZxsQFvzeaJzhC9byMbA7KIzW/CovptilvEw5ZTZmuSzKniI6Fnrm9kQf/HbAg6lV8GTCCfEIlSeBw2siPTD4yMudi50bsu9CN2WNvViAenrFQK3zhY/lfoUfci0Q8SqYATjxupT9Lay5sML70OBnJTsCIWG7j+BFmd6vvyuhQw2B3/g3+9JMpgSzQxQfz88kXwZfGcP1QX/gPQtjHPdueyJfPsPuyDxTiVP/DN3Nrk4SUkFvVsofGvy3KGZT7UF/rU6czTo+DoYUFJ3IdatVaILE04Cp1lbcvu6SpO7zkGgwvClX6TFg24CBPeNhMz2el+EP830FTDcdWEsgh3GoZntXRz32l08TxKuMYOPQSze7W6q6UyNjKwprF6AntiacrwjsqCk1qduckhxPxegIufW+gso6BfOc0NeTHnNAQmlxrAMmJKHhlpaJSimn3VhjLCTP/yPu67DtCoVyBPalHgh5nINDsBjbwdl3gC+uZPFbDJZ1HXq+Fa49XecrV44s7sVCdl6FTSzHGeFjKiFC1bKqJrRX5akt5SVOlXtdB1N
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUF0ZjRaZTNhMVNudklvQmJEZ3NFd1pHUVFtTWYwUWNUS0drZGNMUXV5NU5C?=
 =?utf-8?B?a0ZDcWFwYlVDeFFxQkNOZEY5RUxneE56UEI5YmpJMml0R1pjaGRxZFpEQlQ4?=
 =?utf-8?B?RUVwb1NhUWNNdGluTEFrczgyUEpsUE5aSUlkT0lSNEQ3bHBaVGFlVE1nRVBZ?=
 =?utf-8?B?VlBHQ05IQVdYZ2orUHpScm1nazQ2L2hiajRvMmRQV1JWdEhHeENsYkFvTmpQ?=
 =?utf-8?B?NlJjcW5idlgyUG0vSTRqZWY0NGRTQTNabFRhSWFPNjMxdWZjNUNFbnl3cWlu?=
 =?utf-8?B?THRCS2wwOUVpbkF6UEczQk1FTi96c0IzMGxBN21UTVQwVnZLRkpsWHFlRHNU?=
 =?utf-8?B?V2RPSnZLdU9wQnFoUklVc1F4dlYxVEMrRG8rR1V3V2c1azFzOWtud1IyUFVY?=
 =?utf-8?B?dC9jbEYzTE5FYjkyd2dBV1dEUjFrcG5EQ1NvRkNDQ3FkeDVqYVloVnRPOE1p?=
 =?utf-8?B?anpQZ2hYMWV1U05PWkYwa016WnQvdWpDK0Nxa2VrU1lkb2h1MmxWaEwrdThq?=
 =?utf-8?B?TlVoOXJvcGJCb0lzemg0dER0SHU4T3N6WmEra3lNUDZpcm95VE5xTXF1czNX?=
 =?utf-8?B?VUlaUjUwejI3RmcyOXFXc3VYV01yZzBXeFl1Ty9tU09TME16UUd3SGRCWlBU?=
 =?utf-8?B?TG55aS8vbC9LNmJQSmdha1k4RU44ckJlNWs2ZTFtcXpNZmxlNXFzdU93djNP?=
 =?utf-8?B?SEg3ZWk5VmowbGNua29SbHhFYnN4SFVCZzV3RlRaWTN6K0xTb1BoMWVudDhY?=
 =?utf-8?B?RXhuWlBaM0liMmZtaFJHamlOSFRrd1hMVWpaTGlCcytzWkRDZldSQ0o3cjJs?=
 =?utf-8?B?NVJVUWp4cHB4ajFRZENTN2JoS3NHQ2RNMFpzSG9qczFaWmczaU1RcFFSNjZ3?=
 =?utf-8?B?OHpwd21wVlBwSlRYL2VXZ2RuN0V2WS9VWUd2NlBPNmVxUlFZbmZ0dVcrU0kx?=
 =?utf-8?B?bE9mME5UVUsyaFdOZjNhVHBaOGp5djRseUV0TWdBNXdpMkhhMGV0djZKV0xG?=
 =?utf-8?B?VlkzRElQVFNXb2NXMFJZZk0vTC9pdWNJcS96eTluV2dmVkpJV3R6d0NCRWlO?=
 =?utf-8?B?aWlOSzNLR3lLYTBwa1ExSE9WU2t1eTRoZGgwZzVKYk52ZDN0N0lqaGJRMkpI?=
 =?utf-8?B?bVRCWE9WbDdzZTJ5VGVieERpbmVtNnJGTnZ1UzVRSERZd09hK01Ba1drbGdo?=
 =?utf-8?B?ZTNWbEdkSnJ0c3pmWXpaR0Jhem5hakJSVGd3U3huZTdZL0RCWGZVZmp0eE83?=
 =?utf-8?B?cGdTZDhkNkJJOElPWWFZaGsxT2k2bW9IMGc0UjdtT3A0TUhGSE1raGttN3lJ?=
 =?utf-8?B?YkNSQVlhNEdKUjdzOVl0My91ckdTOVVoM25vbzZXM3VlUEh3dDBLc0NhTUUr?=
 =?utf-8?B?b3hVdVJsRzlvTmE0bUVhSXdPcHdDUUpWRFN5bmMxSXFnZTN2QzR1VUdhQUdk?=
 =?utf-8?B?anp6QVQ5SGljQlBFNkQ0TGFydFgyRGt5eDJ6QmZSTFltR09ES1VVZzJBNWNL?=
 =?utf-8?B?a2cvWnVxZ0lvVUZHaGs4T3ZCamh3SWZWS1FzM3NTRTZud0FQY0Q4TlVOV3ZF?=
 =?utf-8?B?OWc0NmNrSkpqbWFkNS9mNHoxT2NVK3Nac1Rxa1RUNkZwcTN5TVp1cjNROHJG?=
 =?utf-8?B?UFk3azVtTUFuaFc2U1hNYlNIY2EwbjQ0SU1pQWVjRXhmbTBBMG9KOW9neW9D?=
 =?utf-8?B?ZUdmSVZ6Uy9rdkwvcXBSelZkTitNQk9BWUZJV2dOanI4WEkzOTRjOWpUVVVx?=
 =?utf-8?B?aVN2c3R1eGJMa3VXOEhWbkFmMFRYV3NjeWdKd0NWdDlRZ3pVVDNXeTNlWXF5?=
 =?utf-8?B?NjNCVlIzY2xFd3A5a1VTcC8ycXovTGFYM3AyMy8rVENPc2NCam9SVmx3RlhS?=
 =?utf-8?B?ZFpKbTVDYTBHcFhxY1ZseU5zTy9VcTFMVjF0V0g5UGZabHhXVW0zbDY5Zms1?=
 =?utf-8?B?eHVmOWZ6OXNGOXdyb01jYkgwb005ai9zQWJBTERYVzd4R1IyOVFKVmUrR09H?=
 =?utf-8?B?U2JpL2lJL3F3ODNNS29RazJIdmFxcFhidjY3eVVyR1lWK1NFUktPTk5pWnZ4?=
 =?utf-8?B?ZjdxeGppRnoxWnhDdVEyRkFUODNZMjUrR09DclRRMG9KRjl1MGsxaEREL0lT?=
 =?utf-8?B?M1owRVlCMWFhNjU3M0grQkx0V3M5Y2ZVbkhLTkhrQnZ0WWhxQ3FFNWFCVjE2?=
 =?utf-8?B?ZWtNOGZqaW9pYm5taXdhY0VWRElrRUFpbitGaUhIODZ6QmFnMnEvS3pJNXFP?=
 =?utf-8?B?Q3ZFMDFndkw1eXE0OVNLQ3dzNExTcWpRSWM4am1nZHh3SUVGTHB6cTBJeWZ0?=
 =?utf-8?Q?eMKR2tvqQKQdYO9KUg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	NAuSN8607pMn/hk2tLPYB/1u8Pm9Z4QeNb4GG7jXc5GxbC4dNfaXOtUH2ARqKRTRFdUrUM773+Vp6k6rMgocU0590L6mwaPLi5aiuKhL5moiRh11rG7GZ/rPDshP3AXp8kyavU645fI8PS89j93EHCAYEPxbscQQP0+xxYN2AzEysS0i2z+1zHhg9wlc70MVmR2yO3BaGXShbmz7c0/zSfBvQHuooth3ceCbKV7/cSei25mSzgXj6ErpYrdyAuPD0+ybFAVCMS77bFISUonQjl64/lt0ndR7f4Jq8ouCPi0dOMVUEAvtjB9AhzpMjDMOT5uicinUlqz5mwJzXHLHAA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f12ff4-0e56-482c-b2b5-08debf9972fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 04:51:31.2958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hH59oqBRSbJe4WwXWFA2y4jBX5ZJGYKYwOR09GxsayU+FL0/emtuLlIx9T+oHsPrXVfe5VfKHuLXAgm/f6ecyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3762
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA0NiBTYWx0ZWRfX7FbeiLBJgn0P
 oiGAKX7eI0fIPzKcEk6tXBlpYVBUnqg/ELTtvKErmA9FOcHeG/5IfSS9aajjt2enN+DIV62g6tD
 yqUFImYVuKYbuZ/e2xluwuqaTmAZ15ix43kzC2yBqxkCUSktK97f4KznmYupOU0oKIayUfCaYmW
 C/S37gPxJ1mS7g67XQ5xwXbn58zXFvUWFGRkIhBFPbvdDAGDmDehsY9xetJqjUrTttjzmLESAjy
 IWNSjpu75jVm6Ohz8vP8bdQ6uX/kqLJ3vxrGcy684Fky/no0uBinaGRY578HQEKtUcIbNhC9ozu
 oxDsFMU+ekY4Waf9t7sC5MaACfSdo6VIroEupxgGwastjDXW+FH0Iwyz72eJPda7N7T5Tk9BBsC
 6E33UE7B2UcsvsjALjQsP+cZRybyapBijG7yLQOQKmeSkffcrEj0VQZwX22WsTmJ+f75H5QDzog
 ucpwo+HitJrGk2yRZXw==
X-Proofpoint-GUID: N8hDWr2e4eM3i3HrqaJKReIvpvkA1KF5
X-Proofpoint-ORIG-GUID: N8hDWr2e4eM3i3HrqaJKReIvpvkA1KF5
X-Authority-Analysis: v=2.4 cv=F99nsKhN c=1 sm=1 tr=0 ts=6a1d0fd6 cx=c_pps
 a=IQCifphjnLIoq2Ofwddevw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=UqCG9HQmAAAA:8
 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8
 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=KRyKgfzNg5pyhqTwMSUA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEp1bnJ1aSBMdW8gPG1vb25h
ZnRlcnJhaW5Ab3V0bG9vay5jb20+DQo+U2VudDogVGh1cnNkYXksIE1heSAyOCwgMjAyNiA5OjU4
IFBNDQo+VG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+DQo+Q2M6
IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBZdWhhbyBKaWFuZyA8ZGFuaXNqaWFu
Z0BnbWFpbC5jb20+Ow0KPlN1bmlsIEtvdnZ1cmkgR291dGhhbSA8c2dvdXRoYW1AbWFydmVsbC5j
b20+OyBMaW51IENoZXJpYW4NCj48bGNoZXJpYW5AbWFydmVsbC5jb20+OyBIYXJpcHJhc2FkIEtl
bGFtIDxoa2VsYW1AbWFydmVsbC5jb20+Ow0KPlN1YmJhcmF5YSBTdW5kZWVwIEJoYXR0YSA8c2Jo
YXR0YUBtYXJ2ZWxsLmNvbT47IEFuZHJldyBMdW5uDQo+PGFuZHJldytuZXRkZXZAbHVubi5jaD47
IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMNCj5EdW1hemV0IDxl
ZHVtYXpldEBnb29nbGUuY29tPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsNCj5u
ZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzdGFi
bGVAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IFtFWFRFUk5BTF0gW1BBVENIIG5ldF0g
b2N0ZW9udHgyLWFmOiBjbjEwazogcmVzdHJpY3QgTE1UTElORQ0KPnNoYXJpbmcgdG8gc2FtZSBQ
Rg0KPk9uIFdlZCwgTWF5IDI3LCAyMDI2IGF0IDA1OjIwOjEyQU0gKzAwMDAsIEdlZXRoYXNvd2ph
bnlhIEFrdWxhIHdyb3RlOg0KPj4gSGkgSnVucnVpIGFuZCBKYWt1YiwNCj4+DQo+PiBUaGlzIHBh
dGNoIGVuZm9yY2VzIHRoYXQgdGhlIHJlcXVlc3RlcuKAmXMgcGNpZnVuYyBhbmQgcmVxLT5iYXNl
X3BjaWZ1bmMNCj5iZWxvbmcgdG8gdGhlIHNhbWUgUEYuDQo+PiBIb3dldmVyLCB0aGlzIGFzc3Vt
cHRpb24gaXMgbm90IGFsd2F5cyB2YWxpZC4NCj4+IFdlIGhhdmUgdmFsaWQgdXNlIGNhc2VzIHdo
ZXJlIExNVFNUIGxpbmVzIGFyZSBpbnRlbnRpb25hbGx5IHNoYXJlZA0KPj4gYWNyb3NzIG11bHRp
cGxlIFBGcy4gSW4gc3VjaCBzY2VuYXJpb3MsIHRoZSBiYXNlX3BjaWZ1bmMgbWF5DQo+PiBsZWdp
dGltYXRlbHkgYmVsb25nIHRvIGEgZGlmZmVyZW50IFBGLCBhbmQgcmVzdHJpY3RpbmcgYWNjZXNz
IHRvIHRoZSBzYW1lIFBGDQo+d291bGQgYnJlYWsgdGhlc2UgZXhpc3RpbmcgdXNlIGNhc2VzLg0K
Pg0KPlRoYW5rcyBmb3IgdGhlIHJldmlldy4gVG8gcHJlc2VydmUgY3Jvc3MtUEYgc2hhcmluZyB3
aGlsZSBzdGlsbCByZXN0cmljdGluZyBWRg0KPmNhbGxlcnMsIHdvdWxkIHRoZSBjaGVjayBiZWxv
dyBtYXRjaCB5b3VyIGV4cGVjdGF0aW9uPw0KPg0KPglpZiAoaXNfdmYocmVxLT5oZHIucGNpZnVu
YykgJiYNCj4JICAgIHJ2dV9nZXRfcGYocnZ1LT5wZGV2LCByZXEtPmhkci5wY2lmdW5jKSAhPQ0K
PgkgICAgcnZ1X2dldF9wZihydnUtPnBkZXYsIHJlcS0+YmFzZV9wY2lmdW5jKSkNCj4JICAgICAg
ICByZXR1cm4gLUVQRVJNOw0KDQpIaSBKdW5ydWksDQoNClRoYW5rcyBmb3IgdGhlIHVwZGF0ZSwN
ClJlc3RyaWN0aW5nIG9ubHkgVkYgY2FsbGVycyBmcm9tIGFjY2Vzc2luZyBMTVRMSU5FcyBhY3Jv
c3MgUEYgYm91bmRhcmllcyBtYWtlcyBzZW5zZSBmcm9tIGEgc2VjdXJpdHkgc3RhbmRwb2ludC4N
ClRoZSBjaGFuZ2VzICBhbGlnbnMgd2l0aCBvdXIgZXhwZWN0YXRpb25zLg0KTEdUTS4NCg0KR2Vl
dGhhLg0KPg0KPlRoYW5rcywNCj5KdW5ydWkgTHVvDQoNCg==
