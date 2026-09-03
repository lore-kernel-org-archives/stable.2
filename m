Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B1B4B0CA1;
	Thu,  3 Sep 2026 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442217; cv=fail; b=IM81m4w8D/PDeYasgx/pCAmX5B170ThKFlJ8zVUmR03LCA1wvWilp5PzmXlzstjR49NQxqseu8XFGMDk3BxT0u7tvI+2/+l4y7yKOTsyfbjIVh4L0cKeA6KHNIwpdgj5JieKigA8XiiiytKrKIRqz8V4JzfU4xhuv9wt9u5LtkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442217; c=relaxed/simple;
	bh=uyeoUW5HaC11zfZ5RoqJLtCLnj2FB9wel9n369HU574=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=LYaTMTeRcl3KV96ibYd41EM3crgGWCvp9IXuqiWquHtxZE8GCJ/TMCUHsur+e6AxaM695S6so+KdJan5EQ6XMbKbkn/66Asc31zsJBAQXJWZOn8ctg6L1d6VreKgbX42gFgOsj/h9K1Pyd+jCQJPM28o5Vj7Klmr+KBQ/PKZmNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=Wj8GI082; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=KvUpsKH8; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="Wj8GI082";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="KvUpsKH8"
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683D6P483636248;
	Thu, 3 Sep 2026 15:29:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	270620241; bh=c6eDN1LFjJy0wJR/ov+UULOWB8oqTEKjpOQyEvHRjiw=; b=Wj
	8GI082d+PZ4+hnj/fZS+GmonOW8CCzkTr4Qzih0MOpgGqhbkTfWiF2KKOBn/jvbM
	pYp2JUL7RBMpaKAH6d1kB5TOYvhk5wzWUsY+fXGSt7HHSKU7tGoqPF/yLnm+dQu5
	eaHjuE/dcgQAmPDDFL/lDTdyPB9toDzRx6uxyRP4YWzWqp5Rne3qwCchFJ56Ml/f
	tmWIXLGBemzxWauF1qULSMNOrBbyrvY0lGvNd6Z1EUs7+gHJwFimma4I2Oin9iDK
	OGt0XvSI+y1pbZlrgRF/4HRExZM0TD0AbPuUGf50YYjwN5iJH/QnrcAgJosRgG5r
	g2uo4//K49hhbFCmsVeA==
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11023085.outbound.protection.outlook.com [40.107.162.85])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4ge5sv2b6j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 15:29:42 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJiRehKs2sv70XWFHtF/BTi+bdIc5Hx/2oAYtkyMGKedq1XADkS+wa7SrRTs/NxLw3NuCaezJk1uygzOaGQum94Bk8LHgMGPh8v7zJuTrc8wsNhvUUcBAe9zY4c4ouhC2P5mTKs565Cn/4DQQV2eSSwDSAabXJMqZHY0V/1oqys1bC2YFT3bMyadi/nC7qDA497/6AA50HCfbQzTGZpszHb4D7V9Y6r9sBxpIjEEaTqzPLnBGnSA5KNDeI5GvigcvMUigy8TEdNdv4JRZkevWRRsvs0i5NER9ZvO+tWW3wmYkE3f+30kR1IlbuctDYKSr072akz4n75H83/0POcXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6eDN1LFjJy0wJR/ov+UULOWB8oqTEKjpOQyEvHRjiw=;
 b=GTZ7VR3yXevqAMX+jCzpNiBu/GKP1yPQ5dw4MwueUmHUTRANO5vWjtuKRr9+zl+3T2WphKSepyD4UuE94gqGILCuyIL0t4jloUHNI5zRlmJhjDRiGR3TkN3fZ6SRSQEgom/ey0Pvch8bSH2/t1C5Qilv4WZmu3081RyZzd1n/6XxfsxvqVmXSj+z/VqtwOgVt1gTe9oAdT82Ol9pb0+due0wc5PY8Wem2dHqaZMaYJXo4xhJgtii8m09+R5k45EZs9VOsJXHvsANU27eu6L88eMYkyOwgw1p7cQdFXq50qWaOK3NdLKkVhkuWfjpl0HCKp8dR2pRAtfJqhge18SxWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6eDN1LFjJy0wJR/ov+UULOWB8oqTEKjpOQyEvHRjiw=;
 b=KvUpsKH8CYaWM6fl/5kz616skIZHuyOMjimRagNDk2fbj304nBeDuOSOKgZjioAzmk1Y5PtDm4dF7g59cRyHGzm1A5IcWXLgZZbcN9zic9wCTRgvzpGK0zWTW/64PVf79rhtMKWDxDeTc01ti8w6t9ey7HVkD2yIBxjPZ8oaoCA=
Received: from PA3P192MB2868.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:4d7::12)
 by AM8P192MB2824.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:32d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:29:41 +0000
Received: from PA3P192MB2868.EURP192.PROD.OUTLOOK.COM
 ([fe80::bd96:8c85:982d:19ce]) by PA3P192MB2868.EURP192.PROD.OUTLOOK.COM
 ([fe80::bd96:8c85:982d:19ce%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 13:29:41 +0000
Date: Thu, 3 Sep 2026 15:29:38 +0200
From: Michael Pfeifroth <micpf@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] wifi: ath12k: fix freq range overflow when reg rules not yet
 parsed
Message-ID: <apl2QtZu6EwGL0dD@mpf-ESPRIMO-P9012>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BE1P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::7) To PA3P192MB2868.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:4d7::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3P192MB2868:EE_|AM8P192MB2824:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fe99ef-c940-4471-ebec-08df09bf68ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|56012099006|3023799007|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	1EoQloj+4wjYvKvq/jEoVM4QFDO8mNeLsEXIGJbgWMT2Fji55nEg/YPqsmsG2Nyg7eY6hpccWrBsqUmMAJihXwRMc1fyKsG5bnxj5DrCV4vf4F6tUHFGCm+gkxYVWE5HNPEU4Y74zH+KtKG9t0XZtm+j5CijkwqJeoTtJbEExfCtk7ECSSu4jSmBwb5PmE6Kqf75Lh9wWywWjZH6vZOUdz6XdLI7NoQAWeBHeEtVBbtuIVgqnWhR430Fg/t+Gp0tUXOLCGZEpXYZKKFC2q50Ssz4K0AYyj1Usqu7JA+L4MPysVXR6uLg4K0plbnkzA/0Q9o0taGHxH20Z7jsNWLIC6C3kefqERiM8KKkJBmHi6wM08DOC4WjIOeMmmXGPzDHf7Hq9TccgEc51fd0gr1vPvRbA+bsFkQVUMRyzGr8sbRsb57FAX+aOzR1cG56GacNWhdRFyBI4rSfLgQHu3OZJI/OsXu2icNgugftzQJZtOFUkn1ZTLEhJ7pyOcX5/ogdAz6XviDH85q/L+dVCxAmRWv5pExCXIxt6O2iY9a/wDtPRD3qXvVADHWVnwH5TMc6KT1FOM8+aPvkkbXbRW2tPqsFkMR3SiaFLSxrZZJHAAe9RBvCl+rYrj4RNAGxDaykzjOkL4n/L1OIeena94O8sRSQqVYMp6+8wYd5Wfz7Mlk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3P192MB2868.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(56012099006)(3023799007)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4OskhsE3JoNksK2bkUOv4eYdXhiFPlW1z/Hhm2SPPnpCpLD4zdE3x9UsaVB+?=
 =?us-ascii?Q?PlYVpsmfIerii80ba9Mu0cvv8v5LU00sNde6ZI20dh29K3cjakb62uIYUP8V?=
 =?us-ascii?Q?qLrurOesDkeSuCaQbEiXIQiG/k7MGj09m62EvA3LCeUV7vuEATVEHTNfnyKb?=
 =?us-ascii?Q?hJdd1NJqXWIMAy1UZXg+qhrKg5pwaSSvxYSp4BY/wKOSPt+tM8o3o/GRdtb2?=
 =?us-ascii?Q?b3+AihHxo8xDFFclMFRpDKEr+bR139PH2xzw1kapb10b11KffPP0HpheG11N?=
 =?us-ascii?Q?DsfWo4fQYz0N4ZOjWozeuhvYRgesfrnE0aP2ZanOjCZCtD1bPcLlQRXLvk7S?=
 =?us-ascii?Q?gaYg4XW4QGfh9MvpR8NLjzaff8OzMb55BmeeUkCZvn/GFeRWSkXHA+l92meU?=
 =?us-ascii?Q?YWqGG8znzL5UO7rlVM9cQcQ9a83WA6qgenyg2XP5pfDQKR7MWdu2o1VzXIsY?=
 =?us-ascii?Q?+SDZAk4m+iKUfzRmgHav3yolwO+PY90u+ndNPwySBvZhYWMIK+Sq1j8RDexO?=
 =?us-ascii?Q?ohvv+TFTDPx+sBXP2LfYk9/GEnDm2K1lqcH4l1X6HavLc/+IHMTdDC95YfCq?=
 =?us-ascii?Q?2jFl23Ij9GyjLJAe9tih5AZJUZKZ53VKf97zeyDz/4pCx/Rgzg1w4kCmFhiF?=
 =?us-ascii?Q?dfX7Z1oirKxzgy5SBc2v1phyDZd8qr64biB1w16IbtNs/K2rGbv6rf+cbI36?=
 =?us-ascii?Q?hPL9V0ZIvRJ9pVYPdAccO9FFPEmMYM4yAwCA7mQFEwUH/12QdM7U5LKpjb14?=
 =?us-ascii?Q?Qh8xP+OOLvBwCqQEHDALO83cNLDFWoGVIoleKQgv/5H4hTheq7COqRWw3jyY?=
 =?us-ascii?Q?py/Y3mCE+fV2UXazJ1hPJKo7NnCrMptTajMO/SMlrEAwCo78QAKY1sdd9o5w?=
 =?us-ascii?Q?WMlg/R4DnZAc2KCGe4p1nKw4orliptJGOl5Jkk1KBES6QgayawNwZvB2sr4d?=
 =?us-ascii?Q?91QW4gOGnlWIpMU3ljN9WpoopwX/BBcGJTTQLWi5T+R202jGFGAKEmCGOaIc?=
 =?us-ascii?Q?BXHsC/uof4I/y9q2KGrqv5GEIHlAl3fGYhc1DwM8/+Q5v6bscPiPnrIG1RQ/?=
 =?us-ascii?Q?dmQnoXBPnMENSVQeW3hcsgSTlCvKuEuKh8M45+qIqWTX4oZayww7ixKiE0Rg?=
 =?us-ascii?Q?zo1+C46qurSnvV1UpD6Pgxe+lqGWNi10wPfLblvJEPIjQ1hyNNP9Ow+fysIT?=
 =?us-ascii?Q?fFNxE5d/x6ribgY5pnJvSnm+bFhU5guDNpPSz5IyKrxdZJt0rgC8wa/ft+Oz?=
 =?us-ascii?Q?/g+OvOFsLJl380vfZpbv649Pc4hMbC8BbabvJhs6b+eozmPNZCkqPBkDh/gS?=
 =?us-ascii?Q?GGNmZV2FeFVNJqlVERwrgx0NcBV7JCzRibhJwFOo25unafkCI/gm+Zc7Jysp?=
 =?us-ascii?Q?bgkm9HSebUzEk+A3H+Rel7Q+RZPo4ert3fLPcJqvroh2GpmeeY5q9s2tc201?=
 =?us-ascii?Q?64l8kT7zDlJNqitkTrV7RKqt1PQGRWHiFY55ohpVcV2+Il1O9LWqOJAJtOCc?=
 =?us-ascii?Q?XWinYRD+U89v0cNuPNPAzLLGtDhNbd7DX9mcYUm0SY9ciktS+iu5S1VWZEqi?=
 =?us-ascii?Q?4fhTDM125gk4BEGph61L7RtCmi5j7AAf8XtXw2lB9I3z9FOQJvRFxLHj89n0?=
 =?us-ascii?Q?jubuSQh6/+zK2P7thvVIUPUgQNGC0Zwuv//9yIgh6s9EFPU8T/SWT9HnnzNF?=
 =?us-ascii?Q?WBzoxdyTIlQsKYLwdWDWxaYxeXWlvcimN5T0/8pXsR4GNzLIsbDjD3KDVNDW?=
 =?us-ascii?Q?5dS6iOG/gg=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	a4Bt8seYR3KyLKdV6qaxHu0DiZDeR/7OEj5hOqU3J5UEXgoGAmCkWWTV+pP5pi4JhG/w1l8qq4q3nCDBGzQ+08OofDOLv1mmhQ+9ANNXi/QtWJsnXZm0hF0kvvEf0gyQxkQpE+F6k7SoAtXuWp042q+rL1Z5cm9/ScT3Z/qm35MBi4QFZfIGjBkHTKjmFZ/bUKgBickezuNI/sph3zxgTbeYMSkQSD6k6mMasfb5gYo/IUSD/mvlbRdVp9YgzbfP7coC1TDv1SbJ5D18TrZhJVYbptXUm/qEfsQR31Frz53CpCv2+siAqbWKs+rQhmBGnIWUfmw9W2YbGgwCUA0E9A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PJfj/874vhDCoh88zyHhiWB2tiGKIlftktD8+pUSU3M8tMTPVtGk87IIjPN+IaHiVSasdeM/dowk9Yy9AjIbsf3mL+yac9M0SAjwsXINAJD69WZeRTh3gDpaNBXZDg56fx0F22i+3AJwSSI7N7NRm6nyO2ia11Y9U74px5AQTQV1AlWUr9yWVovfQwu6+ixWgwc/Mcy4BD1vzYElCBRqQWauDLAsmXD3gjwm6l3IFvdSkOGijxfeDtii+5h+CdEl24WCb3lXbCHSA39BMGmRxQPgiRJo/El8Zn6wrCHRW4lkW27HMQIaVwlSn7qDrKS5dbQgVnIU29zNc7F09mFX5NKf6XdLeMdUyRgU9AghaPdD4e91u0XhL4lzTRuTzu8gx1Coe82XSjqcMR2gQ1G7YxgCt0BEdgqs/OG0s15+xrzTZrtqBwPNbZ3vsbH23wgbGeeJHfwAmazCT7eicYx92mXonBVN/W+wlywCNIXbSvTLyyJzEa5rMWMQDU27nxlRA9AJRMeeA4QSCOmBdGk3BTbffrB9p8oifoYYqvj6oFeudECS/sfXow508jiYYrjAMG7b5TxiXyyOI03HrwggHJibGNBwozkKMWNmruVoy+5wvL4feq1mBIVW4CzwZRww
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fe99ef-c940-4471-ebec-08df09bf68ac
X-MS-Exchange-CrossTenant-AuthSource: PA3P192MB2868.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 13:29:41.0140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NubMBk4h0eZk/fVYQaZzXpTnamkofiMRivakELU550eyQFY5Ez1BffCWS6EM6rxUDoOYJlJfGe5Fo/IIL8S9OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB2824
X-MS-Exchange-CrossPremises-AuthSource: PA3P192MB2868.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: AM8P192MB2824.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDExNyBTYWx0ZWRfXw2qXH9HcSO44
 8nZYp0aMHi9GuHy6R/rglpjco6cHcx+3uHYshKlOjO6Pa0YeDJUFwglewIFD2rR5U69GW18ScCS
 RlugNYB0BOrA04YVk65+7IfKoIyZudVgu5AkqeitIsEhReupNxMH5P1qxWow9QWjmJHHpI1Mris
 k0garcTrEcUN19Gzj29NZ/N6I4+SgDbZ9ydSx2k5jHx7afxeQPBo9Sch2GQswd7QgqNQiNCPVmJ
 xpGOmaPUlTHhh5wy+we4owt9HTUgzJrt+z4/f30jheSBQ2VexqtJoRqnXO376O6p/MU6cRQT9Ro
 zHD6jYfX2+IPBpArvjoggHJTBhlt1blamvEHD3CaGbsUm8Aq9FvYDZ0XljrumORZJjMTN17Tz+9
 LZxPgRYAH9Dpyc2Erq3ytJi6pm9feyXm2DL6Wc/J9EMJ7BUtSlBSziW1YJfHGLSkAPB6D5cV7as
 OTSMhOahvRFuRGvMkeA==
X-Proofpoint-GUID: _nWKZQe-H1SXzyRr3POpRslqkcxorq4o
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDExNyBTYWx0ZWRfX5cmNTm93sB2L
 rfgm6KtFG2IAOAoYEae/F2lW8E/rLIrh9uHp7SPazLR/ObS3e4iaWX/jX9zw8jYfHUAU86m0HTI
 MrT4Xw8ffjZP+tZnZNpFB6JdvVdpDRM=
X-Authority-Analysis: v=2.4 cv=Es3aPycA c=1 sm=1 tr=0 ts=6a997646 cx=c_pps
 a=FXahOaI4078dIhBFKIJ6+A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=8ys4xmT3Mru1TjC2zVq1:22
 a=VwQbUJbxAAAA:8 a=N9GNhs4bAAAA:8 a=-Oh_-6K6ROkFF56HLt8A:9 a=CjuIK1q_8ugA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-ORIG-GUID: _nWKZQe-H1SXzyRr3POpRslqkcxorq4o

ath12k_regd_update() resets ab->reg_freq_{2,5,6}ghz.start_freq to INT_MAX
before the per-band regulatory rules are parsed, and firmware delivers the
2 GHz rules before the 5/6 GHz ones. If it runs for a radio whose rules are
not applied yet, freq_low stays at INT_MAX, and MHZ_TO_KHZ(freq_low)
overflows u32 into an inverted, empty range. cfg80211 then rejects AP
bring-up on that band with "Failed to set beacon parameters".

Reject non-positive-width ranges; a later ath12k_regd_update() installs the
correct range once the rules exist.

Fixes: 0d777aa2ca77 ("wifi: ath12k: fix mac pdev frequency range update")
Cc: stable@vger.kernel.org
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Signed-off-by: Michael Pfeifroth <micpf@westermo.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 99bf5cf79..654c58d7c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -14125,7 +14125,7 @@ EXPORT_SYMBOL(ath12k_mac_op_set_rekey_data);
 void ath12k_mac_update_freq_range(struct ath12k *ar,
 				  u32 freq_low, u32 freq_high)
 {
-	if (!(freq_low && freq_high))
+	if (!freq_low || freq_low >= freq_high)
 		return;
 
 	if (ar->freq_range.start_freq || ar->freq_range.end_freq) {

base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
-- 
2.34.1

