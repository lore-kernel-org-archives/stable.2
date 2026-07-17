Received: from mx0a-00756801.pphosted.com (mx0a-00756801.pphosted.com [205.220.170.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3353DF008;
	Fri, 17 Jul 2026 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.170.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784286747; cv=fail; b=M0wjV8/THhr6WflKoFsPd8t2kJAAVxvsFa26LVfJxlhJK76HVs5QxVLrlSBNS3qgfpRzI8tj5QptYYwwKIjqINx+aA8PYFTqlKkziMYhg9DfatWTljoYjMCyURTE5WtTBj9inKrWkH/OUg7mgBA9JD7XqI7XufAsPD8781uWGko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784286747; c=relaxed/simple;
	bh=yJbrU+ySE0R9RurngZ5xX7bGkp1goRhRTXN89pYOwHg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YXefstu7sWHVkkiMHeS3u/ytf1+mSdy63Hz203XQLtWV+211EQytBH469OGrxmiIUgGoKISfTZEegk9cTLuQTzBBsna+cyVpdpysw6xnrXuBatUQOlqYoEjbiK/Ewp0hWhwiJsBzu4iq6VTi2nCjb839uCs+EnvRe8usWRifDOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nozominetworks.com; spf=pass smtp.mailfrom=nozominetworks.com; dkim=pass (1024-bit key) header.d=nozominetworks.com header.i=@nozominetworks.com header.b=lchBVufr; arc=fail smtp.client-ip=205.220.170.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nozominetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nozominetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nozominetworks.com header.i=@nozominetworks.com header.b="lchBVufr"
Received: from pps.filterd (m0297686.ppops.net [127.0.0.1])
	by mx0a-00756801.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HARgfv4048965;
	Fri, 17 Jul 2026 03:51:53 -0700
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11021119.outbound.protection.outlook.com [52.101.70.119])
	by mx0a-00756801.pphosted.com (PPS) with ESMTPS id 4febp5acpd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 03:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnFleAimMX1HOSkKKfOy+PdL2+JDM+UifoW04TSqvUgVCd4n3GYYf21fzmmq14raz7/0tL4PohRH1cRprqGXnOjV9S/Sjf8LGkPsalZ9o7Y49JAU6COjHXCYfgW2TRTiiLbS5yENEniuwpxdzIy9iTxMTGyqHYuJYpNrsfR+aZeAOHUyATlRUUfpdX3/gHsyabUFIFbVsTb0fgCG3yNuAP7g4PmN68iomvJw8QZQ617CDymOCgNLcam2vDAsgGQosix7cJfdolwZwWVIsSVezrPC7ZM7b7EXj/l7zd6Yb+bXFo3hpQafXNTyIfJLvYkGD/tZtO0qB2k5AWFbWki1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFftjpG4PXZz2N3wqm+Y/h/fc0YwFNrV7BF3KIP3Xvw=;
 b=S6HMcXAoACTkj43ZF+Ew7epG+2AkIapbzRjcPBoGUhSyUuTyAZFU9VeW3ttV3SXf091UogwlUmb7ZSGZrJj5iGdcRBgGxCBsQnBgXdjltMJKIYDjNVk6E+nreb7kxz9+cOZmPVd7iybCAzvKGlV10pxRlAk83uaX0awh3Mrq11nHbA0NVWoOH6UDSlTNZWyQqNxgNzOSQV1HSH9Wb2ifC5obN4R3a2Q25/36itEqFSBusDwcFfAXnraet6sbD06eVqIHG6XJ/RVJIFY+wfmpWyNQ0rfK1QDa7rIwyNMgbQiXJ2Bx+7RXzCTS9vMbP+WlIhELKYrd64VCedshVwqBng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nozominetworks.com; dmarc=pass action=none
 header.from=nozominetworks.com; dkim=pass header.d=nozominetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozominetworks.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFftjpG4PXZz2N3wqm+Y/h/fc0YwFNrV7BF3KIP3Xvw=;
 b=lchBVufrSbYUq/SD3Ea8B42tIbCjbL0CG66FlwltY3X1gEx/Qg8TMeRtAVOGQZ+j6tzM1t2iB0PibieWLifwSV3U6guFKS52M2x/pjsxgPny7bdKNrksyfi8zgowqeeJPWe6p2uQsGmLmk0WxOxs0H12G7opIKJFTssu0eGmdQM=
Received: from VI0PR03MB11174.eurprd03.prod.outlook.com
 (2603:10a6:800:2f8::12) by GV2PR03MB9883.eurprd03.prod.outlook.com
 (2603:10a6:150:b0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 10:51:48 +0000
Received: from VI0PR03MB11174.eurprd03.prod.outlook.com
 ([fe80::478a:c992:bbc3:ca3f]) by VI0PR03MB11174.eurprd03.prod.outlook.com
 ([fe80::478a:c992:bbc3:ca3f%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 10:51:48 +0000
From: =?iso-8859-1?Q?Alexandro_Cal=F2?= <alexandro.calo@nozominetworks.com>
To: "hyc.lee@gmail.com" <hyc.lee@gmail.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] fs/ntfs: Fix index_root heap OOB write in ntfs_ir_to_ib()
Thread-Topic: [PATCH v2] fs/ntfs: Fix index_root heap OOB write in
 ntfs_ir_to_ib()
Thread-Index: AQHdFdpEMwHKyzIdgkG2luaAOW1OTA==
Date: Fri, 17 Jul 2026 10:51:48 +0000
Message-ID: <4EAAF864-52A2-429F-A7F1-46228DDE6884@nozominetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR03MB11174:EE_|GV2PR03MB9883:EE_
x-ms-office365-filtering-correlation-id: 31a4d3be-8c96-498d-a5d8-08dee3f166e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|6133799003|56012099006|11063799006|10067099003|18002099003|4133799003;
x-microsoft-antispam-message-info:
 FUTRQ2IsK9JDeJWLcTEpBzJiPJ1X6GXzbmkxSieR2xF1vPtvpsbrqU+C8lS1+Uo0AgBNNZfzC/i9x9SmEkvZbpF5LPuNRto2V6q0aeYdjzQQYxktl2Cc6QbU42kpe5OCKigShAf5QQgKnZ6bc4Gnt61o1o/fGlXoADAKWnObN3wJIy9vhoOIABuscj0jXXI8POokXQ33xpMiALFnNXxgoiRTmFzhiWtqbz7qql4UQadykXMma6lKWlcW8E9QfHBAGgZyKRjCHgpa8dkp87b63SKfbxXFLdBekSyAB8yf8Eqb6i+JKgBB3PZzTOzh5KCJu/n54qmxDXRbwdTtHBwn2Us4cw2b6wv/SNa91m3ygLqn2HrwlfUjaT3wRIIASApGVZzKnlKU6OAST0HKp+S8zAhEb+QdUkWVmxhAQyQU+t5dBzIMu2fIZ2eXXdNs76eJo13sz8Pykwprm94pMYbGrebmfpDfAuwFhEvXNa1gfZKtG0qFbenMdCIlcr08A7qsyIy+vEoiOPmIVmTva6h/gyD0kFoDW624BK0EGuTFc9SklyFHkaT8OKKgYuvy7GFmDURwxVewXmcjxasaLKJITcw6XNikC5PIXt1CpbPK1kXC6RYRBWPXfHsjcEnsal0DGQPwIU1DjNSKq197PZspg9zAa/c0/CXSJOineOXBkubVzuIAdxrrf/B1Lhh7SKilGg6BjnbXh97HaBiLvm2SNu3quSTA/fdZSSi0IPFg2hw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR03MB11174.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(4133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?WMKVXbBBQK0dhCCcvriyHe796YSrZvq8bROoR5lytxuZ9Ztm9iWKR6fy/5?=
 =?iso-8859-1?Q?UK1w47vbUT08kRnI3chzj/+lUWXlB/naGoh8x4wmceZOHpgpscQO9s6rnk?=
 =?iso-8859-1?Q?ckC2SmM2jX3jZOEN3wkSF8vluyJoZTCvpXqxVPLvaJm09oEDOhWiFOEk06?=
 =?iso-8859-1?Q?nI2v67lVqpk7kjVpo/dQWxHzwg2VPJZh5qOKO2+MH74WQGLoApngF8hhsp?=
 =?iso-8859-1?Q?hy8MupANyDBO+O8iHnJ1wVq4KQGFDfGWF9suxIuiMEDqN1DalInVEtRkxj?=
 =?iso-8859-1?Q?pAnb5qDPEOLnMJQCX05/yRlYuRJLrEBZsbahVmH0BOE29C2KCQyb9xkzSx?=
 =?iso-8859-1?Q?unoKDDQ6VxJNllBf2SqHHqi/NFFj3ycYw7gQZqyP1n14CgSOL3q5QVXugq?=
 =?iso-8859-1?Q?n1H4UvL4qPJ4k2hKORC7JDxu9GSqPgEu6uHAgWVHRJNGBMmFNPAgq9POHW?=
 =?iso-8859-1?Q?npdFRstzgvYVDmY0agZcGp5RrRPIVyP41VYawWbGCXjKUQPre/XbvPcJNf?=
 =?iso-8859-1?Q?T1zA5z6Zh40klPioO5bmOEoTQKsuyOA+P+OtB6jPKCu5B8PQ5lvBEF+D+6?=
 =?iso-8859-1?Q?OzBvkYXCLKyW9T2CImiUL9hIaEdm22870spVb+SpM/mjBzccJaG11reHfb?=
 =?iso-8859-1?Q?i7jjmxRSmoVZpjXhN/j2GFpAsI+5IwmE/YmmwHjtc8IV1L7mY1xeXiEkGp?=
 =?iso-8859-1?Q?eVuvzqtv8LtQ9l/HQ4m1q0yFEV0+04SX/4JV+wjgHVM63AQHT3dGsqkyul?=
 =?iso-8859-1?Q?3xoM9b2IGbTdj2enLQERZhCU7ud/AVmGDn1wHT1skmxt3LWvlaMziazsmH?=
 =?iso-8859-1?Q?osgCvx7DyJNHaTAAEaJDVLdOqNItAH1KB1PeN09+sOM2zcfrBpQSOzE1zc?=
 =?iso-8859-1?Q?SW9x62FJhWD7/2/p3MqMW+inrpznlb0z79gvr0Nvrynyf9de09VRsNy2XI?=
 =?iso-8859-1?Q?2dxNj7EI/HGAUJYyBRiIkttqKxJcRp3X97nQcFlFMJMxHpXElmiKQdAx0S?=
 =?iso-8859-1?Q?E2I8C1P4viuCBk2+jgYzJ6XheSgZHdv0cNM0IC7UGoSkPGHe9e41mawSZl?=
 =?iso-8859-1?Q?xjGQTARkyhMFXWDCkEO4IEci8jrCVAiN+MLHTyV4h69q4F44G5O1TxThpn?=
 =?iso-8859-1?Q?pHmOcF8oOD7QsVHNHiI8c2d1OFh4BGqBZ/d85wgBtjZCFqMTiZ3jNsfpDB?=
 =?iso-8859-1?Q?ZjQJS2Wk9jmBlT2q0iIWECOnNtJoijH/xF/gOIX6XWPWPtqRQ0TSz7eRIK?=
 =?iso-8859-1?Q?bAIJau8LnPStEQ9gnnl5/lJOcMJSrRTG0TFjY9Qa+alZYDv3zJ3iSwLY1s?=
 =?iso-8859-1?Q?zm34zxfsE5Umqsmt4laNWZ/CUXnTPJnouq9HUOoWBGZwesvJa0GJn1q4JS?=
 =?iso-8859-1?Q?Rm+8QJIUlBozVHRosRvGtGFUwDGcLRfQzouyZu4658TfCXwoEEwRTaBdpz?=
 =?iso-8859-1?Q?ZNu77eb4rb4U2u7fQz7wcbmF2PatAN7dbYlnRWmeeh1OiUhfg3viebeAkM?=
 =?iso-8859-1?Q?oJZa6w4KIE3oPtoXGhPqBDF50ZXIxEq47lNCjF3YIyV8HqvYUd227Mme7o?=
 =?iso-8859-1?Q?0kTHvWkPrwOHTIL9umDnZ9CyxPmS0hGMv5PzV8YL9PRvWHjsv54vFnfHbc?=
 =?iso-8859-1?Q?IpLpzOSV/J1E055Et6tgVWeVQMSuDwMHDcPGk4J0UnmAyuW71RieLyUYTG?=
 =?iso-8859-1?Q?rMOFs14nJJNKxoWOY91eWXfeFSGY2PJC5ebL4crP78QSmmdPaodC3WGtBz?=
 =?iso-8859-1?Q?RUq3+zuLf87qUzTfXC52zqqp1Eg859Ni9LT7txGz3R/M43yKkQ36PV0iXP?=
 =?iso-8859-1?Q?F/kHGHxQY43yyTMRcvycNstamj9UkI8FWTPaWynnmz36W76zeQRn?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E62AC67283E44B4180A410A41A111B54@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	UT8q1J63C5+AcjXutCoCw1Cz+TLT1arSrWLeGcVAsDGa5UfyWPTYDFPxD+guQE2dT4zsCORZK82BpHxznbQIV6cqV1Cf05F9gSFe+hlhvr0Qa13Y9HLnmA8FB/C1nLOp+zSmrv60Yfn1atCsmBhzHNtVKwQedukI85YVIssYHS1Mil1h3Fhs5kyigGrRodcv0AwZFPkPewe8hozpUXvwmOKpj7dIDMRmSSTShfsPn/glxYmighokaOEt7UAyo9Xu6VfdOvcf5Rj/OzfW8b0i84RBHzBajjNzr+Bs4hAiTtQ5mBqBC9fZ5jp3ABOKyiW3fatdT5n2OMfZ8ucK+0g6PQ==
X-OriginatorOrg: nozominetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11174.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a4d3be-8c96-498d-a5d8-08dee3f166e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 10:51:48.6090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6f04d14b-0796-4b81-b7fd-779778e05341
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vEBnQ+W0K8oyV002BT5rCSIEnRuoskNqNRomaTpY6e6nL68UvMQIeXxuHa7bqJoNGLPHgOE6zUCpsCqHF1h8e4fk7zwSoxQaXpD1FKuXR4/pTFEt2SsM4PmOeBbE8U76
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9883
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEwOSBTYWx0ZWRfXzxVeY57t10ij
 h+2pQQCZr43oCunDwDzDcqiLVGWQdRbmws81BisQuokNBeZqqA8ESe0EvHwihXsx28/r2+FDVc2
 yLDUzQTdI8L9MoGxtHGkMni1YVVB+HBF/It/bx6hUIFd8zB9P+DwEzqy65DUmFfptyKnKE96eK+
 XbNQDNMBxOqmwizuIFBrjLeUSfq6K4G1v6dfEeStvu3NgmHuDipbUE37agRC6AkQqyiz1H2uhbU
 Bbz3J3VTUMi+82twQBXAQh98dzLKGP/8Os+UOrbhrKYDbEdIZtiOInIDOhiB4S860kprkWeCvu+
 V4TTVVWj6BzMlG30cH6PnX6Vh0yIngnVuql16sqJVUOiwazQzRRCGYVmd8NYixwqpVoIWkT0fkm
 gz1NcEOCv2spKgRQCs3MidaJuPIqutwPVCeyneDn/a7wrXrcrOZPonZObyU+rj+J1iULp2FK6Jy
 yrlDMCpiXZM2k3DQQDA==
X-Authority-Analysis: v=2.4 cv=dNeWXuZb c=1 sm=1 tr=0 ts=6a5a0949 cx=c_pps
 a=Pi8M9zFmmuJBWN7oFQ8J+w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=LLPZWm0_0O8A:10 a=nBHfkqHukZMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7VS2YgxpqphC4cixgVMD:22 a=iLFNfmxFs0q4OnAKpmcp:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=GqK9ZfNKAAAA:8 a=sV3JB7TLZdRITyrqHwoA:9
 a=wPNLvfGTeEIA:10 a=BFatPaWxP-aY11LYkd1a:22
X-Proofpoint-ORIG-GUID: 750t_s2rg5no9o-xQyFzS83C_kof2M27
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEwOSBTYWx0ZWRfX+xY0+g1Kdmmk
 k3anzz9hP2YR7U4QGDuXqb/OWRhx0RPJT2NAawiFEPRAXYRpivEfZYsOEwLLUqrk1f0bs0P7k7V
 nr5VOHexWMG2oGkvN56/4EhbHkm5+KThw9nsw2bV8kcythv1l6uH
X-Proofpoint-GUID: 750t_s2rg5no9o-xQyFzS83C_kof2M27

From: Alexandro Calo <alexandro.calo@nozominetworks.com>
Date: Fri, 17 Jul 2026 12:14:51 +0200
Subject: [PATCH v2] fs/ntfs: Fix index_root heap OOB write in ntfs_ir_to_ib=
()

ntfs_ir_to_ib copies all entries from index_root into a freshly allocated
index_block_size-byte buffer without verifying that the entries fit in the
available space. The entries in index_root may be larger than the usable
entry space in the index block.

This can cause OOB writes past the end of the allocation.

The validator ntfs_index_root_inconsistent() checks that entries are
self-consistent within the IR value, but never cross-checks them against
index_block_size. There is no bounds check in ntfs_ir_to_ib() before the
memcpy.

Fixing this at the sink in ntfs_ir_to_ib() since
ntfs_index_root_inconsistent() validates the logical consistency of
index_root as a structure and a root with large entries is a structurally
valid root. The bug is a size conflict of ntfs_ir_to_ib().
Also, the validator is called once per inode load in
ntfs_read_locked_inode() while ntfs_ir_to_ib() is only called during a
reparent, a check there adds no overhead to the common path.
Moreover, even a future call path that bypasses the validator would still
be protected.

With NULL as first parameter of ntfs_error(), the volume error flag is
never set by this call, so the device name will be absent from the error
message. In any case, that the caller, ntfs_ir_reparent(), prints an error
message that includes the device name on NULL returns.
I think this is the best solution available without adding
'struct super_block *sb' as a parameter to ntfs_ir_to_ib().

This heap out-of-bounds write is triggered by a crafted filesystem image,
which is not in the kernel threat model, anyway, fixing memory errors would
be nice to keep  things secure.

Signed-off-by: Alexandro Calo <alexandro.calo@nozominetworks.com>
---
Changes in v2:
- Added error message

v1: https://lore.kernel.org/linux-fsdevel/CANFS6bbAW=3DXRf=3Dd5Pb6zkyoJkAOQ=
M1H3Wu6F5T31s8j664L52A@mail.gmail.com/
---
 fs/ntfs/index.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index faa7ee920a3a..47f1f7b44bdb 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -1112,6 +1112,7 @@ static struct index_block *ntfs_ir_to_ib(struct index=
_root *ir, s64 ib_vcn)
 	struct index_entry *ie_last;
 	char *ies_start, *ies_end;
 	int i;
+	u32 ib_cap;
=20
 	ntfs_debug("Entering\n");
=20
@@ -1127,6 +1128,16 @@ static struct index_block *ntfs_ir_to_ib(struct inde=
x_root *ir, s64 ib_vcn)
 	 * as well, which can never have any data.
 	 */
 	i =3D (char *)ie_last - ies_start + le16_to_cpu(ie_last->length);
+
+	/* Entries must fit in the allocated index block */
+	ib_cap =3D le32_to_cpu(ib->index.allocated_size)
+		- le32_to_cpu(ib->index.entries_offset);
+	if ((u32)i > ib_cap) {
+		ntfs_error(NULL, "Entries (%d B) exceed IB capacity", i);
+		kvfree(ib);
+		return NULL;
+	}
+
 	memcpy(ntfs_ie_get_first(&ib->index), ies_start, i);
=20
 	ib->index.flags =3D ir->index.flags;

base-commit: fce2dfa773ced15f27dd27cd0b482a7473cdcf2a
--=20
2.47.3

