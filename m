Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793224746;
	b=N9qO0cvoUs9qOafkROP4ePT0RG1+yR8tKXL8fnSDFvGKP8P4E5Mvwq3ZbZ6amQ6so2Xf
	 Iop3jbUXWMOg8PcvH2PRBKIsrkxQjQX6KSAhDq0v6TZVxdH+rHoLQNtBFgvQjHvBN08j6
	 92g6CixxOmW1aNYZ15nF3PQGZfiT06Ik6SrmFOW6lAxJdSPlR4zi0E8CGNJ3vv+hkFHT6
	 awSYibDdr5IN4YEkiPrLCA2huey5WNKp+gOQ6LaLLdWGxDvTPhoTzCRBvgyCOPQb6kLrL
	 iZ/M1qi51uKrkQy4ZkBTpKWsazh3sNnjWLfEvp/mHf0oFArFW5u9LV2NvK/QSShqTSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224746;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-traffictypediagnostic:
	 x-ms-publictraffictype:client-request-id:request-id:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis;
	bh=UMsFRvnTFo6XSj2vKGTTh3Wcs/t/qTnV57gsSi8WxGA=;
	b=1+MCr9/ecBgK0OiOCgfZZEBkkhIkPBG31v2PwNFIBgq5e57NLmrUXJVlhC51++7aVYXI
	 B9DJozDCiqJJdp9/XQlD73HcEDodiq61oE3LXbXXnZkTvqJ7iqbk104B7A5zsi5O3Vj3W
	 uVBhOMB1705H6/AX6Aui0kk7l/APCSPY363KtrhbsQc8SDI3LP20wN/ogL5sPBBebVpBp
	 fZZp1vtjZK+AoIJo3c4UX2xC83EPPcifPPgUl4a0spcyFm6n2s7Vj52K9PdIYonAbw8c6
	 ZvuZZoOea43oY58tHAQXHfk+yPr8rRqemItUf8wu4M3bUpNoy612JF6SZqb0miWAXVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=sgLVo3+Q;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=ULMszdVI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A4C606A31D;
	Wed, 28 Oct 2026 21:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76A4C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=sgLVo3+Q;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=ULMszdVI
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SLBlV81902735;
	Wed, 28 Oct 2026 21:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=UMsFRvnTFo6XSj2v
	KGTTh3Wcs/t/qTnV57gsSi8WxGA=; b=sgLVo3+QwzPvXPUMn+S0ihyGD1jmxATF
	mIC0KCRWZSBJCqbI4j/kUyEM6FIBlSYzR5tN5yMQxsRXnxTuqVXSurOq2puBXVzL
	eSA1b4NbzXPLrQtzunGqz0dwtFZC5rM77VwEDy3sRVv4tcF/sH4COK5+7QH2DZC7
	qUHE02CD1dA1e85xNseIM9WNZCrKO+Ou24ckx5klrDBQu4sH1T25sTlXg0vqRLz9
	vqSUt9Zm1g3nyF6ttq2/uZqwYyS4OUsYjpD/uXKsKW9mUVa4dTYkPECcj11w0mwT
	qwwr+u2b69Bl6+qr114gyNbtpB/TGZWYyPuqVJPWwWmZpCYofvb98A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hgk8y6n5c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 21:58:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 69SKAwjI2077211;
	Wed, 28 Oct 2026 21:58:30 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hkqv2bdmn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Wed, 28 Oct 2026 21:58:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMWy7y9jaw6rc5fSGKZdQjg2n2Hx1l2qyCofA53LeiUAs1tgaCcdv6d7wxpK1bep5DzHkciubQwExFylZ15SMp8Ge9tgsCv1Y5pJfaicLatZw/EfLUb2aV4GHIfN68F3X7WvlmRDShfdp++VnCEnGnuReEZ2QQZ8CwYdc5lfYAUIZty3ORteNHqCYuLmxKJp85xnUostqBUWVqDX8QzPdkJdwzMuvNcVIAao6IyhqPUgm+nLLfQuXGeY71QjGJbU+3RPwh12s509Ixyae5kWDsinEkp+GO2sa5egO6rssOQG8DZDD36j76VBgXyvzXVqgUkI0IfTrcDCh3iRSa3LhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMsFRvnTFo6XSj2vKGTTh3Wcs/t/qTnV57gsSi8WxGA=;
 b=WRC2lXl5iESSgl7xBsazrK17lm9bwOpP2qF0PG4CYbrfSKdMzVioatDgW7T7yY7eLmL3GecfuIe/mxqW74ljQHh5VRtuEflLkNOtZoG5Kv1MKHs29waXxlJ0bnSi6dSximTWg/TEeBjESNk9SUZPiK3uO0jW2m4fx46mMTeHDlbSURoFbsMgiOMtCppWXfTMxvPlEGijulv7dn6eDS7ILcAx7tRyiZanXimzDv2nAbAJpSyXykimEP1eW4uxm3Di2Kq0VkOKbZN1WIFj7MXTDL64xufkYj+g8JszfPU9BE1qKKwsR35DYz73QvxoiRhyu4kRlygF6TM2PmKTSlnDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMsFRvnTFo6XSj2vKGTTh3Wcs/t/qTnV57gsSi8WxGA=;
 b=ULMszdVID7sJ3YtXTe4+wuoCxsOre79vnrpwydQCKbtidBv3k/AQTWJkFhQWKzvZSTIONQYAtFEwdvbUCJhzsy78onzbGbO5V0mGXk4yjGopgMlIcqoUgM8PEh0bA8whqdS9dVdG7f45M2QKf4buBBde0OUMR2oGMB/+QBsouiE=
Received: from CY8PR10MB6660.namprd10.prod.outlook.com (2603:10b6:930:52::10)
 by PH0PR10MB4662.namprd10.prod.outlook.com with HTTP via P2P; Wed, 28 Oct
 2026 21:58:24 +0000
Received: from CY8PR10MB6660.namprd10.prod.outlook.com
 ([fe80::c6bd:8750:27f3:6e63]) by CY8PR10MB6660.namprd10.prod.outlook.com
 ([fe80::c6bd:8750:27f3:6e63%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 21:58:24 +0000
From: Manjunath Patil <manjunath.b.patil@oracle.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Eric Dumazet <edumazet@kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Willem de Bruijn
	<willemb@google.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Manjunath
 Patil <manjunath.b.patil@oracle.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH net] tcp: restrict SO_ATTACH_BPF to privileged users
Thread-Topic: [PATCH net] tcp: restrict SO_ATTACH_BPF to privileged users
Thread-Index: AQHdZydzySCd3ZjM+kmgWLaUPwncxA==
Date: Wed, 28 Oct 2026 21:58:23 +0000
Message-ID:
 <CY8PR10MB66609715D3216D1B10CC186ACF6F2@CY8PR10MB6660.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
x-ms-traffictypediagnostic: CY8PR10MB6660:EE_|PH0PR10MB4662:EE_
x-ms-publictraffictype: Email
client-request-id: eed2fe74-9a26-4479-a926-098f8ed8ff24
request-id: 2897b688-75ad-4fe2-629d-08df353e96aa
x-ms-office365-filtering-correlation-id: 2897b688-75ad-4fe2-629d-08df353e96aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|38070700021|5023799004|56012099006|261009223027099003|261026121527099003|261021123027099003|261022075727099003|261021121427099003|10067099003|18002099003;
x-microsoft-antispam-message-info:
 ETju84UxlzDsB5hqbvR5EWf7Tz9d3pXUiv2vZ72gYik4P6B1Rk3K6BGiXUgfE4djeeVgOauBWDlNHIrHZGITEv99QwlyPlZkfxKuS9FiCJkM7ivsNWYgzKpWBIYAlRtCVYlIY+WfloX1bxSdkAuDuJwi6gOkK8k7spRcxo6BoqRNp2yUnPP1gEJeInTXy7CfISHma63KNgFrdp65orj9QVrfiXD4qxohAOxE7ViiZHHNVppS5FjZFo3hQH27Lf0oWZM3Fv+cewFnxRxK+cp9epJGMWDWwKjytIvmNNZVaFHyzAj1sDnBHEEKesfdw/TU+ZCpnqJ+fRve8tNPjJMe2RPwemYGSEjN8YsB+pBjrPAq0I2y7GKW9JTzcRcC0ie1iMlZiUXVHsyHEOEBClEJavtG6LIVZSRP+xyycXWv91PDSzOpuBq8gyFEzNFKc7RR7qbmC9890ReAgHPv8Ax+7IWr38CfSRhb+Sc0dwHubNaWlwPLZ1rwf0VhjD6v6twj4ICTQfNBk6yuIeVG+VcZcw/ImNs8Ob8SJXogefBrgVX/EKnw6bASH7DpAAv6U54ijMb+xIszQb5vg+uBiWTDqy1MgkKd+znNoVC/8J/JINO6h1qWiGKfGkBv8tJwYvCqLTHyBMzKnrFpChmRRn2tw62EBz37OdijJbGi4W0Kpr6BoqNtIIeVp95uSoZKtrdrizpeMeetXQ2NxbnCz/cpX8Jn2VlC3RjktHp6F1lsp4g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(38070700021)(5023799004)(56012099006)(261009223027099003)(261026121527099003)(261021123027099003)(261022075727099003)(261021121427099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TZXcQEU7k4olCDeqZcxGlFmZM7IQ66bnLIpjc3UgKt24A3hfmA3fcVlc4ccm?=
 =?us-ascii?Q?/aHgoFGfiPmyf6KgPf6thYZU7V2HMJTywmJ+S4HfMCh5YPLR6i6lSZjADHaR?=
 =?us-ascii?Q?S6Ludrlidj9LRDwVFsXVJu7ihEtkz23c7TJmeAYfYq6ysNKOphcwsrnYhTeQ?=
 =?us-ascii?Q?jBhGHJX64hRz84MMU8EBLFlH41o0u1Xtwd2PMWZD+tMpFcHlLkwKgKbDJwTj?=
 =?us-ascii?Q?fy2R3fNo5dRZPaRp/TLL/3nO76g2roHi1J+IGVnZ2Xnfu4owBplAfgBLbRqN?=
 =?us-ascii?Q?Mo7KH2SY7ss6FtG6uXnNipndH07vW7Rt8fP2BjODaOWDNwpWIe3zNrKs18R8?=
 =?us-ascii?Q?NzCoWnm0yHpKui7WJFIBW9hfvahkD0NiDyxSq2KhjxF1q1U7Saa7VFMka8Ff?=
 =?us-ascii?Q?55VCM6qY5ImyW7jGKbUcRcgWPkKWVCRfdGCujYKA3yEQ8c7JjkWT6yEiLoPu?=
 =?us-ascii?Q?9oATiDZQSkW2xmBcy/Uuzx5BBS56dtXMW6Lrv/vbz5HYd3Wof1JBXDau3MPg?=
 =?us-ascii?Q?T6NNjnZEDYnG9/IPbaaeyfKQ7HQDvZ8fZG12c3n4hY/XOqVst56kDXnX45Pl?=
 =?us-ascii?Q?xZWqvwmWHyGnctNOcynq6Mjd6Hv3+GUpzpVx5p2CDXoVaIsxxw3Aa3tcdrwK?=
 =?us-ascii?Q?XTC3924NyknnaBN0Hbx3PnpXgJxi7r/uKvUxnDiA9cuq7ODt6P2Erc4IxFgv?=
 =?us-ascii?Q?jjVIjg+VN7OAJqfmiu3uM6n6LyPbO6eXHBae4FCSpUwmOHLaoFbwnFjfjiI7?=
 =?us-ascii?Q?NfLuqy3Xsd9rUjhxsHt7tYDSdwEZZaRsn+HzkxjTJOMEqJH171P4L2I3XKfA?=
 =?us-ascii?Q?ki/oDSaU+Yd6smkCrcKeKm9P88t8HE6L0YLJ2DuHkmdcpxFpBsoLZN5wUhSu?=
 =?us-ascii?Q?VAdaCpRyDN50gMvyAJPiXH7t/Z8+SqkGe7ORMEu+knHwVxXxfTdCK28bJI2C?=
 =?us-ascii?Q?KeOQa/FUDHMnGR7Sgm7MiWBaz4P69+Egt0qzRPpt14ZO+ON1tKRm1sbLcN78?=
 =?us-ascii?Q?3tgA8qVCs0nzg4Rkqn8R/QYG3jpPWTs1KY6sFAIE6iyUeNWHXNgudjgCNmdm?=
 =?us-ascii?Q?S+VcE9K51bis/pjQgVcw2SFmJzxlxcOaNll3RtNOl39eWQZLo36Ckg0MjelB?=
 =?us-ascii?Q?GocIJRAKdLkNd+4xboOmWvnz4PXqpW6S+2lNOqmIFaFRFZEwZrKpuBOTDJL8?=
 =?us-ascii?Q?S/824gErN1SvC7yTJHs275a5N8ST8+0A2LY9TaL0GY44VW384G77i+eCJMf4?=
 =?us-ascii?Q?CzUiStzmUiMQdslLk6K+9SZBQgEDeeJ8UZ9AT6BFBGPloCKlHNofXPJMk1HD?=
 =?us-ascii?Q?hU2S52zQxAZi5lPBlCGdWtjaUx2CyhrB0k/Ms4yblcNrqNAKSW4pKhzC0D3+?=
 =?us-ascii?Q?u6FJn4KjvxWsxSXR/HOMareUzSKII9AvZDmjvQ86JLNxFXsPEc1DT9kvd/2T?=
 =?us-ascii?Q?Dm/QhjZX2E3BSxI5QGVH+nmOLe/AcUeXrSbHvV1+664T5tmz9+ohbc4hz2AN?=
 =?us-ascii?Q?q/9shAwnTvzErXpRZmBMGF9AgaxNzVzd9d4vjia8aNjSdt/0KjIhBvtam/k1?=
 =?us-ascii?Q?R/Y820le1/uT8QdF7zYG90eUFzDSJ5MrO72Y1+4j1fUMCO8fhMVt3AfXRo5a?=
 =?us-ascii?Q?7TV7/zA/RQ4Ig+NNKYwyZV4rOhNoIhDO/5ryFyXDgd0G0PhiKM9lO3J92pzP?=
 =?us-ascii?Q?B/BS7dpyPqhZTkj0ky/HCFFjxcSinUpMuxczH6KNeNqUBcxEcg+yU5CVQyXR?=
 =?us-ascii?Q?Co03MTY9tA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Mjd/FmTOprosPV/TR4eDnyu72Jj9rkvtkw5vPHjZh1qUZZsYB3ofX7L1nEjNXyDQj0ksAQb+jBaI+XmlsMm3wH69JmZhOjtzjjaK9QkT5m6XSnq7Wk/xqvYwA7Z36OwlXJltB1H+lCNiwdxvyYZdxkFaxdb1e2+YwK0qK7tNzh6NcuqDVwY+Kuf95moN+iN/diDBFqy+VIib25IUmzGB7pPWzJilgsJPX9Jmy/ODa/9x6MfqQHU8HMf47o5iG6KKFfl+ahZR8Yss61jm8SizYxEjr1A7fQ+dRB1Hq3BR55tF9rFXlcQxYSG4u9nAF8GhZKSbOw4oBkmbDnIpkL/QqA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bRDC6Y9dDjf48I918YsGeSUIkzXmrmeKi8mdhiZ0cUIAEuOUFspekvsgbnJ5fYbC3rMEYCSBsyCYzz7KKZhePztpZwAOgVtu9syNCgUP2ZCjQZhJW4cQ75VHl4r30U8C51mYxqahINr7ewLsGNQbs81nySy9tFwjorghvYLWhbSXjwnCQLb0PmvYsDaQr+iTRUr1aBs/ZHOO3qwgJ039xXKtjGhwXoZjglAUaLFTlsv0o1kYyC77LzNcX5plyZ+7VmM94hYzt0nxqR++iVpRmgEp/xiAHa4d8ETeVNJuUc4NRglHbbuYNsEVl6Vpg8p78t3oOa2tXozUrsGGoyi4QR58WCPRqCoh47AePOfYY/x6b77aAgfo8lf9uDTN02sOUy//FPEaTSnS6GTckdYeGLE/ltfQxCOGkqDWqVj+XXYAjbnSUzlwp68LK+q63i240HWiDJCumW7UL0/5aHkbGYle4aNJ4/euh8GCNdJPlH1OG9jlIM/5PWvV8ACYBHpn/lgAiDwKTLtZIlkfC3db0q/w1OX89CTgUu8FON7gKT9Ly1sLquBdO+/bXHccgMC7KfepBPO7osXR0OxVF3lsLoHBbECiHejI5oxG70Dyt+4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2897b688-75ad-4fe2-629d-08df353e96aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 21:58:23.7753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J5iarFq+j9W59Tea378qXYqO96Y0ae4saqoaUGyF8CMklEslD1yc+0rnynkAG6KatMIIpHy9aaJ5YetHSjkR3i9jLt77iDBpqYG+PBhR76M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280087
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4NyBTYWx0ZWRfX9OR878zMtl3O
 WxRuIrcOr8WJ13omo8CQ8pFPeSJkthk24GezwzwhZUKnRVLz5QeKz60/AD7brzzT63XSL3YAqIv
 JcUZBxcAO2cL+/k5L3IgE9ZRGZ0DF9t3vtAY6vyC7kyDTFUnLVqj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4NyBTYWx0ZWRfXx2bSboyH2G6J
 mwQBxhsSEka/qBQay8R1QlSfxxX29WdYoD5t0+gKKIZg8tJhENU/GqQH+pxcmSliyV+VVj8xIlC
 o+e897HxRGILrHGuoWouM2qYRBeuBY/KUaJ5ftNRMzvm5OlGWgXkAheSVfgLZ7cy0MLklmxivlu
 dCN7FrX3waEQf7lHweWQRJuEVWn1rArHLqGXMMsvZj8tdWjY90ooomxJPAEqmbMj9iyMvwwggZr
 YgIQJgrjADEoxU8hSxVIBZQsDdLqDdiWTNe30z/tfwtjVGZz7tKA742mn2ou2FOQvpNOxBLLYBa
 fXbzUbI7h9YeNGzYjOLqf9LVmcElqJ9hkK4HsFGipDox5M+7Wb3cZN4O3qBkV6qzCPW6VoIRZ7b
 g/VbL/vNJ+zD/YxD2d/SBnWJPDZlBtCQKJMava1/Ji/OSKFw8pX32fdjDzsWHX9P1cznVP+iOJ2
 rud/JOZSVuO8Z7DlUQA==
X-Proofpoint-ORIG-GUID: b_I2WSHS7vDK2a5g01xUpO4HPUF3ptb5
X-Proofpoint-GUID: b_I2WSHS7vDK2a5g01xUpO4HPUF3ptb5
X-Authority-Analysis: v=2.4 cv=cr4OAF4i c=1 sm=1 tr=0 ts=6ae27007 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22
 a=yPCof4ZbAAAA:8 a=xENjfqM6Qb5kcKYy9Q0A:9 a=CjuIK1q_8ugA:10

Commit 5d39580f68e6 ("tcp: restrict SO_ATTACH_FILTER to priv users")=0A=
requires CAP_NET_ADMIN to attach a classic BPF filter to a TCP socket.=0A=
However, a caller can still attach an eBPF socket filter through=0A=
SO_ATTACH_BPF without this capability. Both options install a filter=0A=
that runs on incoming TCP packets.=0A=
=0A=
Disabling unprivileged BPF loading does not close this gap: a caller=0A=
that already holds a socket-filter program file descriptor can still=0A=
use SO_ATTACH_BPF.=0A=
=0A=
Use one CAP_NET_ADMIN check for both attachment options before taking=0A=
the socket lock. Use the same namespace-aware capability helper already=0A=
used by SO_ATTACH_FILTER. Leave other socket types unchanged.=0A=
=0A=
Fixes: 5d39580f68e6 ("tcp: restrict SO_ATTACH_FILTER to priv users")=0A=
Assisted-by: Codex:gpt-6=0A=
Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>=0A=
---=0A=
 net/core/sock.c | 11 ++++++-----=0A=
 1 file changed, 6 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/net/core/sock.c b/net/core/sock.c=0A=
index e7405be8941f..5f6d8b9ff4f6 100644=0A=
--- a/net/core/sock.c=0A=
+++ b/net/core/sock.c=0A=
@@ -1310,6 +1310,12 @@ int sk_setsockopt(struct sock *sk, int level, int op=
tname,=0A=
 					optlen, optname =3D=3D SO_RCVTIMEO_OLD);=0A=
 	}=0A=
 =0A=
+	/* Restrict TCP socket filters to prevent sequence/ack-number probing. */=
=0A=
+	if ((optname =3D=3D SO_ATTACH_FILTER || optname =3D=3D SO_ATTACH_BPF) &&=
=0A=
+	    sk_is_tcp(sk) &&=0A=
+	    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))=0A=
+		return -EPERM;=0A=
+=0A=
 	sockopt_lock_sock(sk);=0A=
 =0A=
 	switch (optname) {=0A=
@@ -1466,11 +1472,6 @@ int sk_setsockopt(struct sock *sk, int level, int op=
tname,=0A=
 	case SO_ATTACH_FILTER: {=0A=
 		struct sock_fprog fprog;=0A=
 =0A=
-		if (sk_is_tcp(sk) &&=0A=
-		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {=0A=
-			ret =3D -EPERM;=0A=
-			break;=0A=
-		}=0A=
 		ret =3D copy_bpf_fprog_from_user(&fprog, optval, optlen);=0A=
 		if (!ret)=0A=
 			ret =3D sk_attach_filter(&fprog, sk);=0A=
=0A=
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d=0A=
-- =0A=
2.52.0=0A=
