Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795110100;
	b=BgxAZK6bdSN0cffeRsmVTzpUm3DXM/vYmxH1gGusM7mhdAUHYhk18wVl32USI1/8TVbR
	 k19Kj07Du5VfyBTvseVgpPfQMInAlCQAzk1zUngP3zSJMblNzp2N0kZ65me77ZufF+XCN
	 59kZM7TM5fz22LI/Dy+ddZ9ytOG5QZ+l2Kvcm1J37m4ZPCUb0GAFD7WjOMqbaLc79r+up
	 7OJL+n/DiI7EweGaN/7EiwRfrL5ZWWgwRsHcnyswYxJJcPl2TsUhG0TKCWYiWx+oqWQuL
	 pNyzDmlylxZn+e4FtBpdA6nMJZNRr9rY4T+xEjZCPXvps4K73TgtDLL2qALkZUv3DWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110100;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Lm5JQMjzuO0hIIfkHzDD9A0KAs3kZlXQffpKYCHYZvI=;
	b=5aBBFMbuWunmc7+BQzix8VSrnuWxIZJpZcgFYeqFwq7rIcZ5tWJTa70k9vWqr/FfaTcc
	 C0sS17uNzPPdduwCpuhlakNyMR9s5HpmKW1Juce8W5ntuZr61m5zKZ1A80WFl+InHPvOX
	 cu0jgPBtPGSqaD9vuEPSGexfmKS5clpBlw5tDZboX1RfvlRIP3OTGt6wHOIDowKsafm4Z
	 U8I3ugK8QuSx+h5iISMAW8mntwc2DW9wJJUVu7tPhSReMep5FZcTFQfwIljluoIZjtANI
	 vQrlvMJbTZZ5+GvnGDgY0Q93rWsSqsRgH8uWRlIHGlqGoqixNKf6Am2VvfHZSlDJ0tA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=k6kv18hQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AAB606A326;
	Thu, 19 Nov 2026 17:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51AAB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=k6kv18hQ
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJF90bL2219779;
	Thu, 19 Nov 2026 17:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Lm5JQMjzuO0hIIfkHzDD9A0KAs3kZlXQffpKYCHYZvI=; b=
	k6kv18hQKdjAV98gvpdS6ZkdM65KS+CufT/JYnAKKmcNRQwxoTQpqSKitsEBgktq
	Awo5SZ2HPnBraMUkecl0nxceyuxVBolXZgVc6uGYEUb/FlKDvPj1MXvSlL5u+ti8
	msgAO2FEZ3Ly2NGVX5a+ZI1SNa2yJTMAmkklCNQ0HWzQvcb1U9VUTZ3H3f55YeLn
	floMhL7L7J6V2y5V5ryGIn32ZgJTw+jbYxqS6P+MBQmlfWZX4n1yPRTo1/Ild7jn
	CIJfAb6PHFwWrcD4sTHYOvJnT//5QaJRv+AunLIx/VTpbNMiae7C0Gw8/qwpu7cg
	n4noM70SnyYywhID6nq3Pw==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020125.outbound.protection.outlook.com [52.101.56.125])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j0yvkenhb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 17:41:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qi48E+yRRZuJG3DDCL71TMnKsVxh6UV//wUcYDm/Kt5iVUArjgDyfwEf2ybIiXmP43KQ388INz8Duf1iOl6Ab+/JkVddjLH525h+MzKrQ6ye6WrH7O78nYej6yvJei406TJkxFSg3J40g+U5lAUKDfv7SOyEKWzmy95zoIuYTMAijHGtkL3ZUPY8wPMS9jTHDbz3zL7/txDXQ3jbDuLbcp3HJYT558PrrWWYd2DnvLr4uvsrp582v4Xwx3rkIFNoamU0BRrbzZZ1SWGcU7TRu69yGeebhHwP5hKefxDXJjwdRU407/ad8mNzJFNEnvPDNy5xBDBX2FxX8CSnyCN6UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lm5JQMjzuO0hIIfkHzDD9A0KAs3kZlXQffpKYCHYZvI=;
 b=bCvf4prkUyAh3Ii91UkBlSLHTCJPKELZS158IJ+BBLJEPCoSzZxVDznUAWoQUTjlO9xQBvLtoQpNQ1OPQMcWwokfkntsb6XUFhsYCSV+5+LreNobbxFgJbNRRO8Lk/B0rSs/gT2j8UppVbZ0G8uPGjHNukXNC5JUqEkmdVbcU9PNPFCHF7rJu9KJ1G6PDismxD5LSR82lBIl4Ef62kVrb1kmECpRtezg6/4XkpbhhTab0qOflTq+HZaOiwdbODrOkmNwAJV3lrssEgtnpxh1VeNz2pwyvn5BR3PefIvcELuuNo6XUAedjzkiNenwHYMDEwqUyvVBsUqujTBqLd4vog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA1PR11MB9825.namprd11.prod.outlook.com (2603:10b6:806:4d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 17:41:06 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 17:41:06 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org
Cc: bigeasy@linutronix.de, bvanassche@acm.org, clrkwllms@kernel.org,
        rostedt@goodmis.org, ming.lei@redhat.com, muchun.song@linux.dev,
        mkhalfella@purestorage.com, chris.friesen@windriver.com,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-rt-users@vger.kernel.org, stable@vger.kernel.org,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v9 1/1] block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention on RT
Date: Thu, 19 Nov 2026 19:40:20 +0200
Message-ID: <20261119174020.54399-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119174020.54399-1-ionut.nechita@windriver.com>
References: <20261119174020.54399-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0276.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::42) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SA1PR11MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ed2332-80a1-4b24-3271-08df466446b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|52116014|366016|1800799024|38350700014|10067099003|261028144727099003|11063799006|56012099006|5023799004|261102130727099003|261026140227099003|261022075727099003|261026121527099003|261021121427099003|261022105027099003|261021123027099003|261102123227099003|22082099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6RFvL5pvduodhfa+0goFtvH7fQVaBSibR4BYSWE6CRIv31q9TkCAFKi66RaoK1fZ3kfduC6X7t6Rj/HZliaYitm2pVLCbMszCZDkTzBFbtfLBvqNbGflugX4uRsYCLOgCSo7A5DJz/pJaAk+ZuJjsTgZcTqbZ+M3qRBEEBhfQ+QzMUw7IEtHr+khwgC2CBWDxWYdG+BVjNXipKEkjKR5zz2FsLD3hxmav0x77t9RrSAA8PbrUgTdCQIuz1snQm41Q+8atA2SUrE/pLu9uca8T9jvWumFoxXS3C77bPtBhDfSTxqzz6TBgSjpRZGlQZfisIaJ5Ppw1uGPpfx5hu3O63pWIlGcpayZ8fLEeOoIRG6hI+hx8s6ngWk+vVq5MkIFuZPeV6evMnpbBUpvf4303aZPqNeTk7a1BeRreLeTP2kHYuvKQoc5Raujk76wZw7RqL1QN6Var9w/ZARDE7/rnw3eR0WLU0a+M/tP/mZX1yAI3/ceUNCFmx7yKzr8oiuu2WCDEFWG5l5IWRoJyVDf9fFKjKujG3ahMjFaNMec562kSBhz6jr7/jdL6kKSbvH4+abCiikvFZwK97bQOjqlV9GFhgZnKEN5UNhBdzuA47lgVvPpwnh4f3FLmWdDCDq/9q4I8Ib3+PeM/ZZo6uyT7pd281fYQ0Di0CRkD2MuywoXDQCTtbAv/8AVw2Enn9y8WAev3lKk2libqhf6L5XQKeONqj3dvC53N79xSspPSyo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(10067099003)(261028144727099003)(11063799006)(56012099006)(5023799004)(261102130727099003)(261026140227099003)(261022075727099003)(261026121527099003)(261021121427099003)(261022105027099003)(261021123027099003)(261102123227099003)(22082099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4zKCOTLI6wjJNzQn+yVkEyHPBpQrgcYPGw/3Q69MiOvsqXeFroKqzzGw/jJT?=
 =?us-ascii?Q?kWwjFaYdV300f5Fage2HtyPJm3oOJPR8dcXKYviPbVHMYX4zNSDeqZuDVsx5?=
 =?us-ascii?Q?w28xQA1RdmVBd8lMe25FD9pEXMrARcEf4RGcBiknsq11OHpqCQuQntAUhKpg?=
 =?us-ascii?Q?3T9LxRAMuOpxgOcGcZzuITpnC3OIKuXq53udBoduhMICENEwAMuLmKoiFxv+?=
 =?us-ascii?Q?O1wOxGi1yAkZnAw3+YwuvM3XSb0MbRLkYbyzYrIpKLLzWpohjiBpDNEAyRPG?=
 =?us-ascii?Q?F2aNTvKEzj5F9R7RuLYD0+vSDiitobO75OtwyNiCwH+amI5ChioAcRDo8gN1?=
 =?us-ascii?Q?IDSr0b+QCVkCq3Cfr717V/gOlEeIFHXY9HBFghSUNT3HTg18NNmyia4s7aqW?=
 =?us-ascii?Q?kvByv2dFmmlxI7XutbVdOZht2LV8C7eWIJm+N6wsxuNaZaO040QLkhlLxx5j?=
 =?us-ascii?Q?jnIF3dAFa0I3n4/Ml9t6Ok5BuHYMcpPhVhc7bRHzWPmgY/P0l9pYpJkA8TT6?=
 =?us-ascii?Q?kWRgN1d34wiOroxtvzyzKERv2/LqNfa/ns4792+lL1F76UjxZWmYP+zc6UnJ?=
 =?us-ascii?Q?X8rqlH2hfTfY6nJnLeRRkS3+aIu1/EE+QUl+uRfxUrFTXGjcJvcvI/fND6wF?=
 =?us-ascii?Q?bHfInWTD6+Gom87ZmIBsetzacasAzlA7F5lBCeIzJIs3S0DEgrrmu3Vtdl8P?=
 =?us-ascii?Q?Sln/awTgrsbG1cGfOeBAC9TVdp2BF+XSVik3O2wvwEsuRrCgQo+xmasUuBhR?=
 =?us-ascii?Q?YGbVzJKkao41cOgNeaGOlZu2dpb1EHNlhWagIh9Sngip+rW8gZ5YxABdPB1M?=
 =?us-ascii?Q?rXpfh+1+J8WBkYG5QPxkNqukADKJTKwRLAQBxZwo04J5W1ZQVtsZYKIBEAWn?=
 =?us-ascii?Q?s3ha3G623ITZgCwzLQoZDPc/ZGViZ0BwA99Drr84o9DgBa7EtmWyjb/KTySr?=
 =?us-ascii?Q?0jH/UllMwcbahmmhAOQXgjz54hV4eDg8nrpqP2I/IXiiGD5Swtg3omA1HdIh?=
 =?us-ascii?Q?h7ZuoImMmiYojBckYpKylkjKDYGdiN6ac9xBwQj/KC2j8nwRoDHxxY3yLbsc?=
 =?us-ascii?Q?vEoQqvE6W/cORyI7mxsOBqpKIn0FFvS/Mcj7gKUq3MCF2SxpJ8eyD7Yd8fys?=
 =?us-ascii?Q?Jdwj+0YbDgzIk4tzEOEnmsmF8GaNtjuAw5us42gciplbRjBHD3oROMV0gT1A?=
 =?us-ascii?Q?ECRiuzc0FXl50fVlQy4V1tMJiZsFDB1yGE7z9kZNvEIwW0pRYOh3KW/Jv8+4?=
 =?us-ascii?Q?pBqSnGgCbp2MzO2OYbOaifXVOtkPxEjRvKElBOrArx+483wmEftB4Avf+S7U?=
 =?us-ascii?Q?TcL8XnBb4b5zReGgTW9tY9m0npmKNXpaVAiymc4CvdSopGAOxtjpf5t9kQmC?=
 =?us-ascii?Q?CUKeqWRl61EP7WK7UstIR+dHSUUrvdZ01E13tYGcsY9QP7kkI6B7n763Gi7N?=
 =?us-ascii?Q?vSDQvuDVrmL3tN7JQatBEfE0ZJui19bQhem4vEpHrepimQ6yT301c19t862e?=
 =?us-ascii?Q?Xm48axtBYDnTAZJ5yJEKwanWdhJskzsiLDHkq9wMCgIWQ8f0VjXsmApi5Lm+?=
 =?us-ascii?Q?YHOEYeBpjbfun7InQ/EKhb0NNGR6we51XTezpKIgvK1eRpGki/WNA2jN8QY0?=
 =?us-ascii?Q?4bBLrKU6P5Sleo7/K/SDR/I86QVb1AKaexOYS83NQzMuLdULz0jDkxeGYXoI?=
 =?us-ascii?Q?5OoktoO9XY9qWwx6mEjmJLlzLkthKIPAiUsDk1qGSnfZOUtJmacgNY9bOIzv?=
 =?us-ascii?Q?Z5KwhuK0Oktbi+MgsDqio/qfw75qBr0=3D?=
X-Exchange-RoutingPolicyChecked:
	yrHIDv0XFd9hvtNIq0jhGFAx71pMJao+BrOYG6Z+uNwSStmfMO8MxX2Q2nrWR81uMGPttcLCBTdz1nDl5EloiKBvYBN4zRSHqIyhkJvgVADsMpItH6UyfOO+hUCv/wpsM48fncZZsEQDx9yv3oYv07uQWAIIp2I7EEtzC7najmRGJzcMerp1KpXBGx71UBucUSgx2WyyQ1RLICTNJ3W2xR+e+Um0QopS1cRYbK6vSy/JN4AzP3pCFNd+HA2jayk5PG7zTzdCPOEnTtB5FA3LyI+f5XQ54YRNwoGClNxuvxZ8vmplEqaKXRvMw3p4DHELTxR7/7PIcY8HmxOSCFHWhw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ed2332-80a1-4b24-3271-08df466446b8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:41:06.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXqBfGLMnkOKnVHQjPd37eqRCKXCAGG5JW/y2cij/SpgiiOX0Qc7oZ5DqsCfTjGwti77dQgeWlCoRqpJzTcqio+YY5FBwj2XTuVO/gqpSTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9825
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA3MCBTYWx0ZWRfX8Cv8dor2jBlK
 BnUYgo9TbV3jfoge6GMn3ApsKf9mGN+ADP/QcyQRgb0Qo1wO59P7rHpOo2ywbdgWNJ17KG4uerl
 nKkA/C5qtysWEOgYbNsMGboff0s09EouKSyNY5aveiBPF1pW0mDw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA3MCBTYWx0ZWRfX97skHm3s+nV7
 xaxbQX4rF0dI411s5haHBaNHFWUDfigbCGBqtssHC90RGukT2rdchmhKbISEsZWQVUIHSgteV1n
 I96ywecIXgvgSyZybf43FxM32cBGcwcd+ka5b5atnfTA120Y2BXKDLs6msDwHW03Jq+4p5ftVxp
 JLYP3wTJVAW53wKbEoZj0059TqyJ53m0emHJE37vMZeuCElBADw2nlINJr/CPGjEvu8dds3S4Tc
 tGN7mOWeH6TLOxkYsV+UF+/88bHXStJ+5cgG/Dn6CNlDIT0gTWaeoFL0WlI5Ch1eeaNuQu9zNy/
 K6aATI10PofabJ95e3fIkbluy3DwpZLxHI57iIJ6fKKkESE/1LRz82aFAjv8OV9PrZRE5Cz5HLG
 Ysl01YzWFOLFGFDvfr8tYGim8WVNxrGO4LHjKn1jSQqKOb2QMqCJX6nMwSybgMCSdaXJh1ZL9Jo
 /B2NARye32GFf/3KISg==
X-Authority-Analysis: v=2.4 cv=OdYNnRTY c=1 sm=1 tr=0 ts=6aff34b4 cx=c_pps
 a=qoAvcrxUHY3FHMzwJxUv3w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=N54-gffFAAAA:8 a=VwQbUJbxAAAA:8 a=ibdQesH5_2KD__BatQ0A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: p9c1moG5Pa8WSIrFGAKklqwdAwuRNpuD
X-Proofpoint-GUID: p9c1moG5Pa8WSIrFGAKklqwdAwuRNpuD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190070

From: Ionut Nechita <ionut.nechita@windriver.com>

On PREEMPT_RT kernels, commit 6bda857bcbb86 ("block: fix ordering
between checking QUEUE_FLAG_QUIESCED request adding") causes a severe
throughput regression on systems with many MSI-X interrupt vectors.

That commit closed a store/load race between blk_mq_run_hw_queue() and
blk_mq_unquiesce_queue() by taking q->queue_lock around the requiesce
re-check in blk_mq_run_hw_queue().  Its changelog noted two ways to fix
the race -- (1) a pair of memory barriers, or (2) the queue_lock -- and
picked (2) because barriers are harder to maintain.

On RT, spinlock_t becomes a sleeping rt_mutex.  blk_mq_run_hw_queue() is
called from every IRQ thread, and the re-check path is hit on the very
common "nothing pending" case, so all IRQ threads end up serialising on
the single q->queue_lock and block in D-state.  On a Broadcom/LSI
MegaRAID 12GSAS/PCIe Secure SAS39xx (megaraid_sas, 128 MSI-X vectors,
120 hw queues) throughput drops from 640 MB/s to 153 MB/s.

Take approach (1) instead, and while at it turn quiesce_depth into the
single source of truth for the quiesce state:

 - quiesce_depth becomes atomic_t and QUEUE_FLAG_QUIESCED is removed;
   blk_queue_quiesced() is now "atomic_read(&q->quiesce_depth) > 0".
   This also makes blk_queue_quiesced(), which is read locklessly from
   the dispatch path, a clean atomic load instead of a plain-int read
   racing with a spin_lock-protected int update.

 - blk_mq_quiesce_queue_nowait() does an atomic_inc() followed by
   smp_mb__after_atomic().  The spin_lock() it used to take only served
   to publish the state change; every caller still follows the quiesce
   with blk_mq_wait_quiesce_done() (synchronize_srcu()/synchronize_rcu()),
   which is what actually drains in-flight dispatchers and makes the new
   state globally visible.  The barrier here just keeps the helper
   self-contained for the few callers that defer that wait.

 - blk_mq_unquiesce_queue() uses atomic_dec_if_positive() (so the
   WARN-on-underflow check and the decrement are one atomic op) followed
   by smp_mb__after_atomic() before blk_mq_run_hw_queues().  This is the
   write side of the race fixed above: a full barrier between the
   quiesce_depth store and the blk_mq_hctx_has_pending() load.

 - blk_mq_run_hw_queue() drops the q->queue_lock around the requiesce
   re-check and uses smp_mb() instead.  This is the read side: a full
   barrier between the just-inserted request (the store that makes
   blk_mq_hctx_has_pending() true) and the quiesce-state load.  A full
   barrier is required on both sides -- this is a classic store-buffer
   pattern -- so smp_mb()/smp_mb__after_atomic() rather than a read
   barrier; with that, at least one of the two racing CPUs observes the
   other's store and the hw queue is not left both un-quiesced and not
   rerun.

No locking remains on the dispatch hot path.

Performance on the RT kernel and the hardware above:
 - Before: 153 MB/s, IRQ threads in D-state on q->queue_lock
 - After:  640 MB/s, no IRQ threads blocked

The non-RT path replaces a queue_lock acquire/release on the re-check
with an smp_mb(), so it should be no worse, and it also stops taking
q->queue_lock from blk_mq_run_hw_queue() entirely.

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Fixes: 6bda857bcbb86 ("block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8 checkpatch
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 block/blk-core.c       |  1 +
 block/blk-mq-debugfs.c |  1 -
 block/blk-mq.c         | 69 ++++++++++++++++++++++++++----------------
 include/linux/blkdev.h |  9 ++++--
 4 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 8836c7028..40877468f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -478,6 +478,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 	mutex_init(&q->limits_lock);
 	mutex_init(&q->rq_qos_mutex);
 	spin_lock_init(&q->queue_lock);
+	atomic_set(&q->quiesce_depth, 0);
 
 	init_waitqueue_head(&q->mq_freeze_wq);
 	mutex_init(&q->mq_freeze_lock);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 6754d8f94..567eedbbf 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -93,7 +93,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(INIT_DONE),
 	QUEUE_FLAG_NAME(STATS),
 	QUEUE_FLAG_NAME(REGISTERED),
-	QUEUE_FLAG_NAME(QUIESCED),
 	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
 	QUEUE_FLAG_NAME(HCTX_ACTIVE),
 	QUEUE_FLAG_NAME(SQ_SCHED),
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ae22d556..3ff5a1ef2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -260,12 +260,16 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue_non_owner);
  */
 void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&q->queue_lock, flags);
-	if (!q->quiesce_depth++)
-		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
-	spin_unlock_irqrestore(&q->queue_lock, flags);
+	atomic_inc(&q->quiesce_depth);
+	/*
+	 * Publish the quiesce_depth increment.  Callers must follow this
+	 * with blk_mq_wait_quiesce_done() (synchronize_srcu()/
+	 * synchronize_rcu()), which is what actually guarantees that any
+	 * in-flight dispatcher has finished and that later dispatchers see
+	 * the queue as quiesced; the barrier here only keeps this helper
+	 * self-contained for the few callers that defer the wait.
+	 */
+	smp_mb__after_atomic();
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
@@ -314,21 +318,30 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
  */
 void blk_mq_unquiesce_queue(struct request_queue *q)
 {
-	unsigned long flags;
-	bool run_queue = false;
+	int depth;
 
-	spin_lock_irqsave(&q->queue_lock, flags);
-	if (WARN_ON_ONCE(q->quiesce_depth <= 0)) {
-		;
-	} else if (!--q->quiesce_depth) {
-		blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
-		run_queue = true;
-	}
-	spin_unlock_irqrestore(&q->queue_lock, flags);
+	depth = atomic_dec_if_positive(&q->quiesce_depth);
+	if (WARN_ON_ONCE(depth < 0))
+		return;
 
-	/* dispatch requests which are inserted during quiescing */
-	if (run_queue)
+	if (depth == 0) {
+		/*
+		 * Full barrier between the quiesce_depth store above and the
+		 * blk_mq_hctx_has_pending() load done from blk_mq_run_hw_queues()
+		 * below.  This pairs with the smp_mb() before the requiesce
+		 * re-check in blk_mq_run_hw_queue(): of the two racing CPUs
+		 * (one inserting a request and then re-checking quiesce state,
+		 * the other unquiescing here and then checking for pending
+		 * work) at least one sees the other's store, so the hw queue
+		 * is not left with a request stranded on a now-running queue.
+		 *
+		 * atomic_dec_if_positive() already orders the decrement on
+		 * success, but spell the barrier out so the pairing is obvious.
+		 */
+		smp_mb__after_atomic();
+		/* dispatch requests which are inserted during quiescing */
 		blk_mq_run_hw_queues(q, true);
+	}
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
@@ -2355,17 +2368,21 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 
 	need_run = blk_mq_hw_queue_need_run(hctx);
 	if (!need_run) {
-		unsigned long flags;
-
 		/*
-		 * Synchronize with blk_mq_unquiesce_queue(), because we check
-		 * if hw queue is quiesced locklessly above, we need the use
-		 * ->queue_lock to make sure we see the up-to-date status to
-		 * not miss rerunning the hw queue.
+		 * Re-check after a full barrier.  A request may have been
+		 * inserted before this call, while a concurrent
+		 * blk_mq_unquiesce_queue() drops quiesce_depth to zero and
+		 * then runs the hw queues.  This smp_mb() orders the request
+		 * insert (the store that makes blk_mq_hctx_has_pending() true)
+		 * before the requiesce-state load below, and pairs with the
+		 * smp_mb__after_atomic() between the quiesce_depth store and
+		 * the blk_mq_hctx_has_pending() load in blk_mq_unquiesce_queue()
+		 * (and in blk_mq_quiesce_queue_nowait()).  With a full barrier
+		 * on both sides, at least one CPU observes the other's store,
+		 * so the queue is not left both un-quiesced and not rerun.
 		 */
-		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
+		smp_mb();
 		need_run = blk_mq_hw_queue_need_run(hctx);
-		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
 
 		if (!need_run)
 			return;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2d92b2b57..d3a5246fa 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -528,7 +528,8 @@ struct request_queue {
 
 	spinlock_t		queue_lock;
 
-	int			quiesce_depth;
+	/* Atomic quiesce depth - also serves as quiesced indicator (depth > 0) */
+	atomic_t		quiesce_depth;
 
 	struct gendisk		*disk;
 
@@ -673,7 +674,6 @@ enum {
 	QUEUE_FLAG_INIT_DONE,		/* queue is initialized */
 	QUEUE_FLAG_STATS,		/* track IO start and completion times */
 	QUEUE_FLAG_REGISTERED,		/* queue has been registered to a disk */
-	QUEUE_FLAG_QUIESCED,		/* queue has been quiesced */
 	QUEUE_FLAG_RQ_ALLOC_TIME,	/* record rq->alloc_time_ns */
 	QUEUE_FLAG_HCTX_ACTIVE,		/* at least one blk-mq hctx is active */
 	QUEUE_FLAG_SQ_SCHED,		/* single queue style io dispatch */
@@ -711,7 +711,10 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
 			     REQ_FAILFAST_DRIVER))
-#define blk_queue_quiesced(q)	test_bit(QUEUE_FLAG_QUIESCED, &(q)->queue_flags)
+static inline bool blk_queue_quiesced(struct request_queue *q)
+{
+	return atomic_read(&q->quiesce_depth) > 0;
+}
 #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)

base-commit: e8017d29067fd1310a65c3494ce1a1b492adbac6
-- 
2.55.0

