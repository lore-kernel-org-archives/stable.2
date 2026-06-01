Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D574938D411;
	Mon,  1 Jun 2026 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305159; cv=fail; b=BxrRua2bDElgp0/0zJ/qH/lpWLqGx+exVGcVkUdFVlmx9d6C0abBwXCNoyNgl72hnpNLfVFYPvnnJXIxhh+FywhFmCCFQOwG0R2U8xYnmKbBZZNxCY4uejsxNeqIztQLiEuUx0vjQE4ofHojEpPoDgnMBEm4wC+Mk6AS0IwM0SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305159; c=relaxed/simple;
	bh=cUgBROXURvLlyaK8wBe+sd5W5qW3Lxbwft4vknuORjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NF2RbKlvdYZyca6bEmJYAq/HBlf8DosS7OWf91YmgwnYh71B136VbKojVQ5i+ybHeb74X5CRBg08R+YM16X3dTUFiLpDfLuqV2wivgEkeTymXhh4i5ZEuUYBijjGspJ7SdJq4PyuX7AhQq1cIVu0LIzQIlNYaSlw12rBO5ig/sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=g91ME7AP; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="g91ME7AP"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VMB76p1251586;
	Mon, 1 Jun 2026 02:12:22 -0700
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023120.outbound.protection.outlook.com [40.93.201.120])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ega3b3u31-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 02:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAevg5wQ3pbAO2YDkRsrM6V/2GB9K9D0+gw4WRng2vfCYDTTC1QNm0cR2Da2iJUGsJGciolLKrWzNTrnff/0KTzOLSCelWbJyxmOLmWOvOrdXH2rCB3p+9gi8tVFfEm+TZj9Kz9jrlNRgt+99Zd9D/2HWpy7GEiWgYruTrv+axvQv4qi633ErkSGRBpn26dLwFBvsXGJavuFEnKQ7urhbSB16M56EjHKufryk65PhLvoz7SPrdMLq7fg2xQF0xNI1H0VllQQrW8PrXIvGw9KtTsu4DO1L3rF3qBUBYTmKoQQMAQuOYwNR1slLQ17bMTfuy7H6mxZQ89Lpk48o/bjiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUgBROXURvLlyaK8wBe+sd5W5qW3Lxbwft4vknuORjA=;
 b=GKk8JI8g1XaH4WhNYXj37jYTYORs96PGlJmEiQh1v7tz209bUlrGwu78On3w/B3VsVHQYQeyCMkTdJC++ZU5BiIgVam6iUFp8JRPMM0m0EqzTUYli/8K6iiLmJZloal1qJ+ht43jbnNJiC0EHrlH47OJF6WmzPXrs/urdE89X7sh7Edn9UFQKP/VK25SspMic/m56WiX8e9iL9w09TBcUwMAf3nyxxFwYUKZfBwHXR0DWRgWCFnG6P5g7BjATWmukbenilAlvlSUcDaE0sx6yPHGbpsYeL8nLNC6M/g6iEgFyxJHrxkQt0RgTgzHYshoPJAVrX+c7LhrEPJnweLvpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUgBROXURvLlyaK8wBe+sd5W5qW3Lxbwft4vknuORjA=;
 b=g91ME7AP5/9QtjH9e/KoYSuGVZi+Fwz8zWc3ZofYZzuG+74MivVZdIN2BFjLt2CPvpyLEe3ebVOBa2m2UuchnhdnEl7iYKB/BS38h9OMpTqm1yEZzVFk6XV14ZWndYN2ofUitZg4Vas6jz56QAq/SuJeRGpdxo11Jq0arwvsdek=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by MW3PR18MB3675.namprd18.prod.outlook.com (2603:10b6:303:5e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 09:12:19 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540%2]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 09:12:19 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Junrui Luo <moonafterrain@outlook.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Andrew
 Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yuhao Jiang
	<danisjiang@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net v2] octeontx2-af: cn10k: restrict VF
 LMTLINE sharing to its own PF
Thread-Topic: [EXTERNAL] [PATCH net v2] octeontx2-af: cn10k: restrict VF
 LMTLINE sharing to its own PF
Thread-Index: AQHc8Yw9tUJqYvjrh0ya6VCke6ydO7YpaZzA
Date: Mon, 1 Jun 2026 09:12:19 +0000
Message-ID:
 <CH0PR18MB43390957C39CB9108C603BCFCD152@CH0PR18MB4339.namprd18.prod.outlook.com>
References:
 <SYBPR01MB7881F8D11D2930BB84215253AF0D2@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <SYBPR01MB788101745A9E36F6FD81CD7AAF152@SYBPR01MB7881.ausprd01.prod.outlook.com>
In-Reply-To:
 <SYBPR01MB788101745A9E36F6FD81CD7AAF152@SYBPR01MB7881.ausprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|MW3PR18MB3675:EE_
x-ms-office365-filtering-correlation-id: 3c951639-96b7-41e3-5493-08debfbde1ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021|4143699003|11063799006|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info:
 cvTJJZxznU2dNYxABK9LeIXMM6Sof39dmVd6+dYugna99UleIRNpC5QzOj4Eoreldc1UhSrPu3+yuONSeWPfv3/VfwjVB9fEnd2GEGoz5JwW/8kz522Uif9j6Y/hOrFu6CBIN34+gAcWaPtoFU/yHlzLCWtsptkW7VTsFrdXFGs6NQTHh/VPspHyWHN2hEAIT/Y+a+oYvooTjrZReadXvgpoGz3+RXd/auaQRc42CmIto2s9HK2GvLElWpvSN71wrOLF6LFiDI+IeF1WqWKaNsDZCaEumQH99brBEHqorkC6aXiCuU6fjGxUgNiAYX2UcWFgVfymkM1JzSK8eJrhWF8L9VnDGfpdwS/MVlm5NLrMjQKIbtjW22NxAIQTJTnDmE8TMmsbZ2aGpyqG3zVql9L5kWbWQ6uFG+UGiIiyRFWAEq/D0Gst9gFszwfHDgMPUhjS7+4xJ020TRk5TozIchEhHSqceSuSF+pygo2RXQGQJC9xppSs1QmjExw7Eq5Yp9r3TcmB+bJvP8PvQ2ThfC7zl+vPZEH+FBZPptuEy1XnM/cVQePj6/bsETx4CLT1GLmlHOS8fNMZH1vGjMVbp5GpzHVX8N3jW8/vhAlX/ZV2Uc5zia70gYW9cwtvf/KZKkqjkpSorD6k0Ty0vIqbcSQh+J8OWtieV1X2Z83hhKnBODLfq/Kl9fcsRwFYKpuTEGuMFMAIQDgjE51HoPZjaWN+P2qrvgx4hLPBEBVYNhg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anVWUy96Mmc4eEdGMjJDc0xDQmVFRXB3dTdXZDkyZUxMNjJXNUtSVGlEaG5Y?=
 =?utf-8?B?MnNMSVFENG5VdVJFZlg3RzJHZzErekZZVmVXMVZQZ0pxdjhwQ09QMlBxaGUv?=
 =?utf-8?B?ZmVEeHFuOEtzODdSR1BuNnl3RU1oQW53eEpSV3d5WHd3MGkxdEVyZWJuRlZB?=
 =?utf-8?B?eStMUmYzYk1KeUY0YzZ1NkRBN1VlR0hFODZ4MW5PTWdHOXEzS1NudnBLemFl?=
 =?utf-8?B?SDBsaDR4bHZNdXkyYkdHREtrVDA5bEgyWVZidG9yeUJaOU5KZTJRSjhReUJv?=
 =?utf-8?B?QzlXTlEza3o3TXhqNEM4OTRsSXpsdUY4VVA3RzY3TkthOHBFdzZ0Q3pUV3g4?=
 =?utf-8?B?ck94YjQ5K0tEZlJJRzB1am9iQ3hzbEpEK1lVUFdlYU9HSVk0Uk9WNkFLbVlG?=
 =?utf-8?B?SEg4TDcxMzdXNmtVZnAxazhDaC8vRktwWjk1NUl1NEZvN0NOTElPbWREZ1lH?=
 =?utf-8?B?T01tSCtIQTByMFpRcUFmWHFhd2NVeERLZUc2TWdibmZMSUlUZTA3QnJQRDEy?=
 =?utf-8?B?US9DRG1GRnhFSkJsMVdsREtnQlVtZDRkS08ySUdiZnJrZEFMcFcwQUdMSEl5?=
 =?utf-8?B?T2tKZWZBc2d4cHZHbTJvUEFVcVg3MUQ3Qk42NXo2SzF5S2tsVEtnNU9SNEpx?=
 =?utf-8?B?ellON2pSc1REUFdnQkNqRFd1RWI4T25nWWFQcEVJcXplYzVsVVU3RXFVS05R?=
 =?utf-8?B?SURnU3piNjRXcWtKZEVqb2k2dER2Z3EzeW0wVFUwL29XNTJ0RlhZTVcyNG5V?=
 =?utf-8?B?OU1yd0h3TTlZb0prUlF3bHZPV0VlWmxTVzdSeGxmbG9ZMHh5emtBaCttVnVV?=
 =?utf-8?B?WjU2SFFkd3RSeHI2SGdJU29hSmYrek5rak55ZmtCN0dWcGg4RGhMRHVweUtM?=
 =?utf-8?B?OXYvQ1YwaXdQbXZRMVZWcmpRWlZ4MVU5RTJuOERyd3R2WjFQM2tuKzJVSVJ1?=
 =?utf-8?B?RTVkWVJoVVo1bkxUeGthWTMzYW44VUwydWxRNzV1WkQvWjJhNng2RFZ3bUpU?=
 =?utf-8?B?WDg3REtLYmY0aXRNbnRzZWdCc0pIbllMMXVCRElpT3BKT2NZTjZONE1sdG5L?=
 =?utf-8?B?aWVpQU96OUNQQVRvZVFZREozVGY4T3VYWE5MaVA1NHdPOG1qVFhxYk5WYi9W?=
 =?utf-8?B?T2U5cWpDc1ZSYlhCSTM2a2YvaGRUdDRRdjVhcVp5T1BjQzdHSXNxNktBMU8x?=
 =?utf-8?B?cmtITnNONitvQTlldWtLZi9yU3pYSzlSZ2p1V1RaZTJ4cksyTUtwYTNTTys0?=
 =?utf-8?B?RXBtMElTS0wxZjFrcjA3NTJsZzlZMTdGUHdIbEZvVFdJVWJTZnVNK2VwS0Ri?=
 =?utf-8?B?VjdiWmhJRjM0N2dOQ09TUjg4K3EwUzRlWFF6NGdZeG1iY05iNVd0Smx3aUkw?=
 =?utf-8?B?RUFOWXF2SmhERUVVZ2tYbysrOFY4WEVqRlFiWTBIYmg0TU4rQWxRc1NlQTJR?=
 =?utf-8?B?MVFSdy9PWmt5aU1udjRTWFpaQVdOQW8vRXpJYWhDRHRUV3A3TTlBcFFjU0xY?=
 =?utf-8?B?d0RmZm5La0toK0xDbEZXN1h1VWwvdk9DdStEbFQwTzhNTVUyWVR0c2VGaHZD?=
 =?utf-8?B?ZUNmRDV1R2JZd0lHMnE3NVlqdmRQcHRjM3pjQ2lFdFVYakw4ZURGODk3cktq?=
 =?utf-8?B?cVM4TnN0aHBCV3huYWRzUDJFQStJdHVNcHVIbXIzNE0yNWM1MXo2cm44SFRR?=
 =?utf-8?B?b2pJUUJFR2xjbnIyYjVHZ01TTUR0ODM0d0pKWGJsdW5DTjFtN3hsWGZPRWhP?=
 =?utf-8?B?cEVRMHdDTnR0Tk5qcUIrME9jMUpUV2pmNmZ4aE9tU1gxc2RCZHFzeHU5akVl?=
 =?utf-8?B?VlNlcXlhTUpHQk1QY09pZDJNQ29yQTE1ZVRabFVxT0phc1pxd1gxL0Rhc1FF?=
 =?utf-8?B?MW9GL2FDcXdjaVdwN2NMbVZDWjBXTk5XRWF4cEh2dUhyV295WTRub2ZMWDUv?=
 =?utf-8?B?U2IwRmkyUjg1TXlGRWxIOGRaQTMxNXZacVMvZGxLaWsySC95ZzNXSXc1Q3ZW?=
 =?utf-8?B?VlZvYjQ1NUZQbUo1ZkRrdTFuU1JlS1k1dmZ5MGI3SHpnRjN2VFgwRlNxZXNY?=
 =?utf-8?B?Z1l6aWwwZ3VlV0dSditiRjNNMTFMVW5QcTExYytsbDFxeC9VNmFiaFZxeExD?=
 =?utf-8?B?UjFEazRmdkFET3phVnFSMFlCZVRsZmRvVWtlN3JvbTR2a1lXTzM4MVE0YnRE?=
 =?utf-8?B?MWRXcHFDYytCS3BDdFV2Yy9TY2UyUkZVNFROaFBBM2xHWFBFQ20zYW1YWEtT?=
 =?utf-8?B?UFNFRjFLb0dOWTZnVjAwT3dWcklxU2VZaDJHeWVqSWJQVDBIVDMrTHphMTV2?=
 =?utf-8?Q?ucD+NB+AlKYBukAO87?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	gfVIFnyGdk/c91v87BZ9lQPqFhuzvlGmWwkq6k54fGzW5aXYQI2JfCKAry8A99GfW4bnB9whlyPJxvAJVEg14N5paLZBcIrMhNHdWr0FH2E4kRBhOp8e/rZntuUoHdPqXqlcbN5JReIMisyQk+6TbTf3Tc1KqzQ6dnKPtreIE4ZXwraXPpXIbmtnUyIvfS9uS4dEFA05fXhij5mLvpdt75pcyz0Djj2S0kASutwKDxy2cj64Jk05T6gSct5LNwyivVlPUapONrBENv52yPYJK9ILxQNAWdThFO6fRbBNS+/pXJLXujcCYjcmznGNBAmNbxsZhIl+CCoQNVNt2Yl9rA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c951639-96b7-41e3-5493-08debfbde1ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 09:12:19.2921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iCtySV9CP2YTwMfYlAAtrnaM/BzAw4D86o3AP4usjJiQDw9IuAdAQsSGCQqMNBDFS//nx73RdU5OHNP970HlFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3675
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5MSBTYWx0ZWRfX7xHCGG8SToan
 5YVw4NBtWb0rJJ0spRZgU0CQmnY/qmIESwMVoH/W8xvNZ0U5i2YTDIWo4TdRYS4ZP3nb+gQpY1L
 f+fUARs3THfJgyuon6rZgtlQQXPOMwK40fKzchWUQ/bjP5lBzAMZc/2kYod/mCtNr5CzpIcIUHB
 kfdybYzCL4Yaz0JcaR85rG4h4wuCMvujbp5l6jmUAA/ZXkzhungwCrDO8se1Il/HjPs0NAout/h
 vbzXat7nTry+/ft0WXaqDuJOAGWZhhIrD/etgkwtKlLf57qB7WRdJuJSnTPBVKWzJSf1spk9oTm
 +hPLNeX7ODcWKR+DxczA60gNW7qvjCAQpPjtDoegk/WTzUdHzuXQTAOD8zhvdt+c4tA9P1R9aU/
 Aj+XImPRsd6GnHjB+Bq2jRe6sLrseCebs2r5QT2dJnYRLOd8CPmL6E61zA9m9sDcREfmV3kCHaU
 9Cp4JTcgg3JMZloZV4A==
X-Authority-Analysis: v=2.4 cv=cLjQdFeN c=1 sm=1 tr=0 ts=6a1d4cf6 cx=c_pps
 a=KVK+BmCWKfRJB4E2nOCFpQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=RpNjiQI2AAAA:8
 a=UqCG9HQmAAAA:8 a=M5GUcnROAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=eWO4mYCY-ZPdHRYj5K0A:9
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-ORIG-GUID: n9jLw27gyFnelsziKJ8tTbMPDJCKcAoy
X-Proofpoint-GUID: n9jLw27gyFnelsziKJ8tTbMPDJCKcAoy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEp1bnJ1aSBMdW8gPG1vb25h
ZnRlcnJhaW5Ab3V0bG9vay5jb20+DQo+U2VudDogTW9uZGF5LCBKdW5lIDEsIDIwMjYgMTE6MjUg
QU0NCj5UbzogU3VuaWwgS292dnVyaSBHb3V0aGFtIDxzZ291dGhhbUBtYXJ2ZWxsLmNvbT47IExp
bnUgQ2hlcmlhbg0KPjxsY2hlcmlhbkBtYXJ2ZWxsLmNvbT47IEdlZXRoYXNvd2phbnlhIEFrdWxh
IDxnYWt1bGFAbWFydmVsbC5jb20+Ow0KPkhhcmlwcmFzYWQgS2VsYW0gPGhrZWxhbUBtYXJ2ZWxs
LmNvbT47IFN1YmJhcmF5YSBTdW5kZWVwIEJoYXR0YQ0KPjxzYmhhdHRhQG1hcnZlbGwuY29tPjsg
QW5kcmV3IEx1bm4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47IERhdmlkIFMuDQo+TWlsbGVyIDxk
YXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsg
SmFrdWINCj5LaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUBy
ZWRoYXQuY29tPg0KPkNjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBZdWhhbyBKaWFuZw0KPjxkYW5pc2ppYW5nQGdtYWlsLmNvbT47IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmc7IEp1bnJ1aSBMdW8NCj48bW9vbmFmdGVycmFpbkBvdXRsb29rLmNv
bT4NCj5TdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBuZXQgdjJdIG9jdGVvbnR4Mi1hZjogY24x
MGs6IHJlc3RyaWN0IFZGIExNVExJTkUNCj5zaGFyaW5nIHRvIGl0cyBvd24gUEYNCj5ydnVfbWJv
eF9oYW5kbGVyX2xtdHN0X3RibF9zZXR1cCgpIHVzZXMgcmVxLT5iYXNlX3BjaWZ1bmMgYXMgYSBk
aXJlY3QgaW5kZXgNCj5pbnRvIHRoZSBMTVQgbWFwIHRhYmxlIHRvIHJlYWQgYW5vdGhlciBmdW5j
dGlvbidzIExNVExJTkUgcGh5c2ljYWwgYmFzZSBhZGRyZXNzDQo+YW5kIGNvcHkgaXQgaW50byB0
aGUgY2FsbGVyJ3Mgb3duIExNVCBtYXAgdGFibGUgZW50cnkuIFRoZSBtYWlsYm94IGRpc3BhdGNo
ZXINCj5hdXRoZW50aWNhdGVzIHJlcS0+aGRyLnBjaWZ1bmMgZnJvbSB0aGUgSVJRIHNvdXJjZSwg
YnV0IHJlcS0+YmFzZV9wY2lmdW5jIGlzIGENCj5zZXBhcmF0ZSBwYXlsb2FkIGZpZWxkIGFuZCBp
cyBub3Qgc2FuaXRpemVkLg0KPg0KPlJlamVjdCB3aXRoIC1FUEVSTSB3aGVuIGEgVkYgY2FsbGVy
IGFuZCB0aGUgYmFzZSBmdW5jdGlvbiBkbyBub3Qgc2hhcmUgYSBwYXJlbnQNCj5QRi4gUEYgY2Fs
bGVycyBhcmUgdHJ1c3RlZCBhbmQgbWF5IHN0aWxsIHNoYXJlIExNVExJTkVzIGFjcm9zcyBQRnMu
DQo+DQo+Rml4ZXM6IDg5M2FlOTcyMTRjMyAoIm9jdGVvbnR4Mi1hZjogY24xMGs6IFN1cHBvcnQg
Y29uZmlndXJhYmxlIExNVFNUDQo+cmVnaW9ucyIpDQo+UmVwb3J0ZWQtYnk6IFl1aGFvIEppYW5n
IDxkYW5pc2ppYW5nQGdtYWlsLmNvbT4NCj5DYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPlNp
Z25lZC1vZmYtYnk6IEp1bnJ1aSBMdW8gPG1vb25hZnRlcnJhaW5Ab3V0bG9vay5jb20+DQo+LS0t
DQo+Q2hhbmdlcyBpbiB2MjoNCj4tIFJlc3RyaWN0IHRoZSBjaGVjayB0byBWRiBjYWxsZXJzIG9u
bHkuIFBGIGNhbGxlcnMgYXJlIHRydXN0ZWQgYW5kIG1heQ0KPiAgc3RpbGwgc2hhcmUgTE1UTElO
RXMgYWNyb3NzIFBGcy4NCj4tIExpbmsgdG8gdjE6IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBv
aW50LmNvbS92Mi91cmw/dT1odHRwcy0NCj4zQV9fbG9yZS5rZXJuZWwub3JnX3JfU1lCUFIwMU1C
Nzg4MUY4RDExRDI5MzBCQjg0MjE1MjUzQUYwRDItDQo+NDBTWUJQUjAxTUI3ODgxLmF1c3ByZDAx
LnByb2Qub3V0bG9vay5jb20mZD1Ed0lDYVEmYz1uS2pXZWMyYjZSMG0NCj5PeVBhejd4dGZRJnI9
VWlFdF9uVWVZRmN0dTdKVkxYVmxYRGhUbXFfRUFmb29hWkVZSW5mR3VFUSZtPXh1WXltVkcNCj5a
ZTFxcS1vZUJLRS1feE9FX0h1dXRBZEU0RC0NCj5sRjllenNMNUF2QjhSWUcwNllGOWd5U0J2OGZY
aHkmcz1ES0RQbEg5TTR0c0dQallQV09qUFhRVEtGUl9zcE9vZ0wNCj5DZkpXMXJJYWdJJmU9DQo+
LS0tDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9jbjEw
ay5jIHwgOCArKysrKysrKw0KPiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+DQo+
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2
dV9jbjEway5jDQo+Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9y
dnVfY24xMGsuYw0KPmluZGV4IGQyMTYzZGEyOGQxOC4uMzNmMjVlMmZjMjYyIDEwMDY0NA0KPi0t
LSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9jbjEway5j
DQo+KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1X2Nu
MTBrLmMNCj5AQCAtMTc4LDYgKzE3OCwxNCBAQCBpbnQgcnZ1X21ib3hfaGFuZGxlcl9sbXRzdF90
Ymxfc2V0dXAoc3RydWN0IHJ2dQ0KPipydnUsDQo+IAkgKiBwY2lmdW5jICh3aWxsIGJlIHRoZSBv
bmUgd2hvIGlzIGNhbGxpbmcgdGhpcyBtYWlsYm94KS4NCj4gCSAqLw0KPiAJaWYgKHJlcS0+YmFz
ZV9wY2lmdW5jKSB7DQo+KwkJLyogQSBWRiBpcyB1bnRydXN0ZWQgYW5kIG11c3Qgbm90IHJlZGly
ZWN0IGl0cyBMTVRMSU5FIHRvDQo+KwkJICogYW5vdGhlciBQRidzIHJlZ2lvbiwgc28gY29uZmlu
ZSBWRiBjYWxsZXJzIHRvIHRoZWlyIG93biBQRi4NCj4rCQkgKi8NCj4rCQlpZiAoaXNfdmYocmVx
LT5oZHIucGNpZnVuYykgJiYNCj4rCQkgICAgcnZ1X2dldF9wZihydnUtPnBkZXYsIHJlcS0+aGRy
LnBjaWZ1bmMpICE9DQo+KwkJICAgIHJ2dV9nZXRfcGYocnZ1LT5wZGV2LCByZXEtPmJhc2VfcGNp
ZnVuYykpDQo+KwkJCXJldHVybiAtRVBFUk07DQo+Kw0KPiAJCS8qIENhbGN1bGF0aW5nIHRoZSBM
TVQgdGFibGUgaW5kZXggZXF1aXZhbGVudCB0byBwcmltYXJ5DQo+IAkJICogcGNpZnVuYy4NCj4g
CQkgKi8NCj4NCj4tLS0NCj5iYXNlLWNvbW1pdDogYzM2OTI5OTg5NWE1OTFkOTY3NDVkNjQ5MmQ0
ODg4MjU5YjAwNGE5ZQ0KPmNoYW5nZS1pZDogMjAyNjA2MDEtZml4ZXMtYTA2NjIwNjMyYmFjDQo+
DQo+QmVzdCByZWdhcmRzLA0KPi0tDQo+SnVucnVpIEx1byA8bW9vbmFmdGVycmFpbkBvdXRsb29r
LmNvbT4NClJldmlld2VkLWJ5OiBHZWV0aGEgc293amFueWEgPGdha3VsYUBtYXJ2ZWxsLmNvbT4N
Cg0K
