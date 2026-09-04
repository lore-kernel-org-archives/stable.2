Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8AB3C3F70
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538637; cv=fail; b=XZ0UfHmR3KjyeV/6fQWknqw26opDY6AtNA8cf5PXa/vEHdneYbiFJ/uZxSsyLollETacDXAkrql7qfHoixFb9VlHGTegXUmDqJTFjnEQVNBqhZXViEhHwWptWKsWsE5tDqP2GMBRMnS/X3t18bSUYD27ow5xKdWW/kowTtOXZsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538637; c=relaxed/simple;
	bh=nbwM82iZAR2Gj/0teW1QmQ/3mnGTLU42jLH0vUtxK34=;
	h=Message-ID:Date:From:Subject:References:To:In-Reply-To:
	 Content-Type:MIME-Version; b=Rj/k0PmG6RNBKLuThwWQBH213MFPji0w+WE2hHyn3dlvT6xNL8/qQhLpUZ2ukz+wDD2CKsTzJrgX1n7TCs6Fy/bURE95Ko01N2hgeXIC8DFHLQQyxN457RIFWEHS1uEVMT0FPcmzos9eAzmvUR02EbtFzfYD4RXoQ5PIH5T+mUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IXHdLVGO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hSkk1f48; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IXHdLVGO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hSkk1f48"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Bg5e52687928
	for <stable@vger.kernel.org>; Fri, 4 Sep 2026 16:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	corp-2025-04-25; bh=PAjpKphz6gWAyn3nMvMiLCVlWOhMR4sFaYHDtv8JFyM=; b=
	IXHdLVGOnlnqh8QovNM7uBgfiCn6KpgkI+L+71foIv/sdNgW0xP5+EirJsz6ggtw
	u2sqRscXsqV+l4+GCOGfiqBfWbR6oLNBz83w/j6ZTtJoOTjTP6+3/9sCyqBoGGvW
	rkZZFHn2ovYLxJQoOnm9oO+r/Qt6lbAa6ePQduFYbmlD98keJPYAINubhpXplVZJ
	Xwp6IS3LpMOLzX6Ly13sO/8UUHSkIUfdweDT+9UzQIva4ANPAYrFvQCnXYaDtD86
	z5Z1/y694WeB9zXaACqSpMpXvaR0VZQn7UzCgF4KrTebxpxt8Vsx2zb3ncLdCWJQ
	Qmet+G9iTCkTdGP4hPCzrg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbq1su1bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Fri, 04 Sep 2026 16:17:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 684GFWq1026460
	for <stable@vger.kernel.org>; Fri, 4 Sep 2026 16:17:13 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvj98u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <stable@vger.kernel.org>; Fri, 04 Sep 2026 16:17:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyU8SrDld2CK/CmHLIk39MzGS2uliEOLXD44iTG1IqksumpLfrAjjStLnoc4jfad5EJqgsGaebJqXDDBcdqxTxLXhue5M1JEs1MwQ5qN0FGRbhrh6iiM1yBpdyJLKrqSj0AvwIzUi785aTD6OpjMpT5pW4ch9UlQy7zS8l26B0+gKK9fjM9BiaOtxUkbfN48hG2M6UQ9ZyN6RBK+ANzCXZJP7ZfsbKYlbPZd8AaJwiJd6q6biDpo+/OKL5+dnmOZ8P4hL9E9KyUcsq5mIu3r5ufaQ4mi5ZFRoQ72pt4ldaj/BswbIA+FQ1yiBKV9QAcIDUg2YPVf0tlckUwWV2VWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAjpKphz6gWAyn3nMvMiLCVlWOhMR4sFaYHDtv8JFyM=;
 b=TPw/xn54+oKMUavbQrsML0/Wquk7+gZaFvuWDDYs7jc4qTqJro7u/428OC1Oa2HM1EIBV6l1cZbH/IomNVZyxJQIQRYNvE+0iEGMA9VqBQaENI8UamRU1KN9szcJhttslxPh9v+bLsnPvENpynz9wM2TKGD3QVIPQAQLNnu2PcPHGukr+0jopaxs9mmy/GjyXK8vg5ez0bqPmQlms8EKxUzFgrkfC4hjrLXLmaRLNkFkf19+78vJOFgASnfBAVqRl0850bQbyVlqbh8W1r5QN4QkYedOxgqoum0087/rU3AmbriidlfI9irGzfnjAstxPMmSXKAvlG6h5ATwkQrxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAjpKphz6gWAyn3nMvMiLCVlWOhMR4sFaYHDtv8JFyM=;
 b=hSkk1f48zud44R7dfWyOsToykqYntKh8G/Fzqp631J3z+gZt+p6MAyRy0SphJCCOqseaiHAb+qCBqJj990yRcmt7v0/5rp51Su8DYtkctH1EtrEDx4CQSKlaLyWeWnH2U43ldSH867ZQsffHE1d+JBGWKOX63jFQ4Lq/Hp5NrxM=
Received: from BY5PR10MB4337.namprd10.prod.outlook.com (2603:10b6:a03:201::17)
 by SA3PR10MB6997.namprd10.prod.outlook.com (2603:10b6:806:31a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 16:17:10 +0000
Received: from BY5PR10MB4337.namprd10.prod.outlook.com
 ([fe80::587:3850:b94b:3577]) by BY5PR10MB4337.namprd10.prod.outlook.com
 ([fe80::587:3850:b94b:3577%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 16:17:10 +0000
Message-ID: <c3f0e48b-a5a6-40e0-af19-e1aabc9abbd2@oracle.com>
Date: Fri, 4 Sep 2026 11:17:08 -0500
User-Agent: Mozilla Thunderbird
From: Mark Tinguely <mark.tinguely@oracle.com>
Subject: [v5.15 PATCH 2/3] xfs: factor out stale buffer item completion
References: <20260904161002.51054-3-mark.tinguely@oracle.com>
Reply-To: Mark Tinguely <mark.tinguely@oracle.com>
Content-Language: en-US
To: stable@vger.kernel.org
In-Reply-To: <20260904161002.51054-3-mark.tinguely@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::7) To BY5PR10MB4337.namprd10.prod.outlook.com
 (2603:10b6:a03:201::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4337:EE_|SA3PR10MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: eb728d0f-b741-497e-d16d-08df0a9ff933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/xjD2uO8ygn2E281+6HHDntQApLcKQl7GXcvfIRH8B+wGQXnQ/DLU8P1E46EaxZEfwEtBQZIOIs/I5Zaqj1yFMXkIEkHzp8hsoRiUb/LHsIbnDcoij/n/f8LqbOeLiPmg+54qUcP+25fGbTeYVGCP0jobTxN1zjaLsDlFxWIYZC0do1KG6/bTfO/CMDdVfdE/ZjJ+RXzuutFYYqoKh056gHR3525303f82qX1ryI9FPpak4yXtxmoX339f0Ef6IGCfxRzgGCEpZc1Sv2GVFZSLxXFbzJ7Hw+y7Np6gL17Z3pwoWIzDVHxUyCCPKBqrjXsAF7d3O47n/ZfXZLV/b6rNgf4cjxe9wHX7PMvcvPzTHCBYQNN9HFciRx+jdA6fh7vqkvuZFumu6fj/rJipPs7No9z3ZGHvEocTXlR3BQgoGhlg8HX/A81Qe6a9eBLzkYXflHgFKWmGhi9AybR/V/3FsC3ED8lDinEaC05z7sL3Yfp2/TjYD9zDB13uOnfKxp7wIz/7+0/Y9IukCODnpuVhVqG/8gez0clh3OQj6IzAJaKlGCasTmU/eLrNx3w4EaFSDO0pmzv331lAqW0gjJOTOaWo5bOat8PxgNvqrxILfFEyzigOzhwppEWNm6HAAVtWLBAHDDvreczIPhez7slDUuFClSECDhudlsAmCo7PY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4337.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUFlbHhoM0h1TUY3RlRHL0ZIU1VNd2drUDBINEpNRkwveXdHK21xazZRZlZ0?=
 =?utf-8?B?czdPNHdHRHBnc2JaUXk0bU1obHB0aWN3bVBRenJZM2tMK3FmZWdEYWxlUitz?=
 =?utf-8?B?dHdJam1GSTl6WTFEV2pEb0oxbFM4S0grb3RxNm5YcXZ4VlR0em5wSlJqSXR3?=
 =?utf-8?B?RW1Odk9WVzVxd05VeVpNdU94UGkyT0gveU1iUy9uSTZ4eERPUlgzWFVsWGQ2?=
 =?utf-8?B?cFZFcVlCU2RKNlI5bEZSYmRPZ1gxNysvYitjR1NabHBGME9iNXA5b1VzcWlX?=
 =?utf-8?B?dlRBWjFMQ3lOeElSY3MxNEtuUmFOUXZpcWpid0p2VDVOZmhzdHRuSFdIRyt4?=
 =?utf-8?B?SmZZVDZ0cVRTb2pvNHNVVm1VUUdOczlWWGF1ZGtZczR2OWNEZkowRkZSdUVI?=
 =?utf-8?B?L1RROFN1ZExOeTRCRGF2VGVnQ2dqZnNhQW5TdlNQcU05RS84KzY4RWFyZjhH?=
 =?utf-8?B?dFJ2c05KTy9Xd2JscDk3UU14d2V3TWU5SFRHSHRuM0Q5bDl5VmJGaUI3REFY?=
 =?utf-8?B?bkZabXM0dGpLSU1iNisvcGl2Z0FGR1dDUjEyMTVpM1psaVNkVFFpNm5Selhr?=
 =?utf-8?B?N3JxUzR1blQzQ0QzbnZzbHVzK0RuL21RUWtWMytydWxxaHE5OGtKTS9qL1JJ?=
 =?utf-8?B?am96UmpNVmU3aXFkL3hvclFUWGRPN0hpeVlsQW12Z1lOL3NTdDk1SlhQdzVi?=
 =?utf-8?B?MGJGcjFXZWNramJQMzBnUGptYi9jMDQ5RTMxYm9uWCsxemRQUFF0V2RYaTZz?=
 =?utf-8?B?blE5eW1lTGlEdDFSWGVKb2pzZG5oZlFkNitEQVJLb0NNKysxQUUxSFFUL2Ux?=
 =?utf-8?B?UjZlSlNpeFhXd05KbGtreFNteXBmUnZPMTFqTHJEOUVEd1g2dmpjazJUMFMx?=
 =?utf-8?B?TjBjSTJWWWl4V1Z3RGFyTERNd3BzNzltNHgzLzRjQ2R0KzBTRGhaWTVBT2ZC?=
 =?utf-8?B?QWRaSDJxRXpPSklpOGl0WEt6RkNUblVPdEhXVUI2blZVY25sRm00cW1KaVFO?=
 =?utf-8?B?U3EzSTBGSlovYW5KQmovVmFsR1h2ZXZxNFk4YnJDc0ovcnNFWFFiQXU4aUwz?=
 =?utf-8?B?Y0xqbkZlMFdDT1BQNzhWQ3cyNEY0NWtYVURuSExFcExxdWhEOUdmOXdEU0l3?=
 =?utf-8?B?TEp1WkViaEFTaTlYWmZZbUFLUjR0elFtT3Buc3lJWEZJVTZ5RXkzTzE0MmF2?=
 =?utf-8?B?SXR3dmwzNSs3ak53bXZMQ0dyZ0hCL1AzVEhIL3V2TlcvK3hqNjFGcEhlN21T?=
 =?utf-8?B?VStXM0UvZ2hvZjhGZDlMK1VNQUZOK3MyT09maHBlcVNFTDJWYTBhMVpoT25h?=
 =?utf-8?B?OG8vNGtoS3NzaTM1L2RkdkNuTjBSbkNoelFWSy9ybGZqVWVPanpDMFZLRUc5?=
 =?utf-8?B?b2lqTThYMk4wMlJGQXpTNlBSRWZ0T0pmSmxnaldGT0Uzc2tkekdpcm5HU2RU?=
 =?utf-8?B?ZlRXSFBEZkJQY1FqVVBLRHBkK3NxSHhUQjhhTXVIbWE0ZDlDYS96bjd1MFZY?=
 =?utf-8?B?Uk91WWR5dFpVNytEWXJRWVN4MzY1OUZkRXhpMlI3c1ZZV1gxU3IwcXFzMlJT?=
 =?utf-8?B?R0tGNmN5ajNjVWdRWmVNRThDWEZGTDFta0hKQ245NHNEMUxJZEVZZmJPY3Zl?=
 =?utf-8?B?cnZjTGVSTWltcXg4YlREWGFMa24vblVLTDRjYlUySVpvZ1R5S0FDOFhXOFFS?=
 =?utf-8?B?RnNQbFNqQkFaN3lPb1cxTm1pQjB4NUlHSGlCZW9VYUNkSmYrNnk4eFBDU3dm?=
 =?utf-8?B?MzRiMS9zamlTRUhvSWNiNjdtVXJjS2pWWFlVVnN4NjlRc1RDQnRkUHh0OFJl?=
 =?utf-8?B?YnROTE44TlJBTThZQzdVSkoyZUdWNklydlVlUTR4aEI3ZTI5NkZkL1hZdy9n?=
 =?utf-8?B?dlBLWi8zQVZ3d1J6WEJkZC9rRkhla3M1aUkxOWhoTCtxNllZNzBxaU9tRDNO?=
 =?utf-8?B?QXNzL2VFRm04Z3RsUEozTTRzL1Z3MGdhNFU0S0x6OERzMDFkU0VKT0t3RjlQ?=
 =?utf-8?B?Y0ROY3FVUS9HWmRiVlh3WEtWUXBmcDdIUU1iTUFEQlU4Ry9JNWM1QTF5M3dS?=
 =?utf-8?B?aVUwMmVtRkYzcWJSdmtoSmNYU1daN0xNbE82dklxa0txV0J6OWE5aDFtRTlz?=
 =?utf-8?B?SjF2empsN0ozK3hxTTN2TzlpYmorMVdRWmFYMzlLZmdYck1ITlgrMnl4RHBz?=
 =?utf-8?B?SWxhNXRvNnNSWmxhUTc4cVYzRHQrcklyYnhLd3JVNUdseks0OHJWQzBDR3N6?=
 =?utf-8?B?ZmliN25QVUFZS3NzS1JlQzFicVFLR0VQR2FTTGVMTFFpUWFwOUh2dkh4cC9z?=
 =?utf-8?B?Vlk3YnhWRW02N2ZPUUNDSE1EdjZrV0haY1Fwc3BnQjEyL245WUtmZE42ZDNF?=
 =?utf-8?Q?Uicp+iGy9TEXNwzU=3D?=
X-Exchange-RoutingPolicyChecked:
	ekRvSnoQLoG+rJrINlKAIT2iO34KmtEfgMHT/HxzQeMwCj4DHMfcKhjcmr9CaamFrb/89MHnjeEQBuNXnMTaxdGfNf4Vm1AAE8F7njkxfYumQSkr+ozXxxVRuYo5w1xlN//l4qu4fYocFNIOICF0lC5pGyFwsTGwMZwv8oaQf9aT5PMWPXeg1SMN60CN4NLnGafsM06NBOxGLcUZe4eymp0RA7cwjqV4+wac394oefSDTnB8aucWMSS4faXEiTTPVVo7xFahgIDYDXFLli96/m1hZt9ZfZigsxESsBirGAaX+UDfgZXdQMWLIZxaVXEJsqufkqLHPOjPecJ1BnYVcg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g60meXIIR6SnAvDehwpvdXfqm8PZ7FBwD9UTk6Y/YjlOSKLesaEaycYvyDl6ZMcNfHa6lPa47yd6vxISm09XK5gzWMD3bLHZzpwpBvWwwJrCJUAcOTZoA8D5U861M+p7q4tDBvc6uec3C033loBzec0P8911ktHA5R9Q++O5wylymweTI5MiAmMjbGtkIhO04tLxKjjUKMdmxs+Xosay0FCMPtNtjDyhtUhmTjOSDIXS3msspBOKZ2N5oLvcJn5k7OKUmpbNRCOoLUxwdhq5r/EBDNEM06p9CiUDQOPph46CbDW08aZuAfojqrDOvbrg3BTQo0hcRz0pFP1OZaUytyjdfDls+ZJUvxnbsZrxB66IvAccfYm5xsuzuHpeP0J30uwXj8PfhU3WwW3KQJdb68bvGMuAHQRw5i9WjoBDchKpgCdP3VBdVrm8NX48grQikImj2IFP5QAa1ERWFwSYOuvJ5hQyl+MUO39n24/YPeDyIZc0NxsgL+W9Kpr20C7+a1sr9pBxUMbZUMxBpoEmurCo/QWaL52jZLyUCMAzgaxnuN6N+T1Ug9NKAk71G0HkhbykVUt54dRwA6iUUCMzLtQSx0oYBb6st8Ve6fxHowM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb728d0f-b741-497e-d16d-08df0a9ff933
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4337.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:17:10.7601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aeIl/nlY3k6zVSMQltttJz+pnl8ZRYwZiEQpJs4u6uonH7FOBS+bbzIDwqfSiQItV9XAu+R2HceqELYXJfMqVxyVYLl5MbYWAYXkTi1qKVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609040148
X-Authority-Analysis: v=2.4 cv=Vp0Txe2n c=1 sm=1 tr=0 ts=6a9aef0a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=20KFwNOVAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=HRhzHcoIBzGTXiVGymcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0OCBTYWx0ZWRfXyv3Ta4sIdhJ3
 +sRAwSehlmIbGhPKuKwoRqrdCOrL/P1/+sZNUy/276LEUULwQ9IJZVzi93PPLHvvwWRuX5KgQZ8
 VocxM48XLWD65XpnfvSzH/a/MXSzyARmXyv2Z+SXUnuEUs1ITIsjhDSJURilqbGYl2gRJ+cNgay
 AyE0Y+20z+kyYsP8bjhi0qjU/fPpug118o/NxeD+UmaK39/LkEAru3C1oZHxsvNgkvASnbjxV2G
 m1FHvKXXEZex06OqcYJBTHFdH/TuMeHQus86QFP59IyHxR2O1Ze+LiATDgRRyjsMnS23RysN92d
 y6HeNASVXm0rI3RAq4KTG6z4UcahCeL2fBjnru08gdo+v06Q4XXBeg9IoOvvK3BmOckgi3c6aSR
 9VmTwNxZ6lLXANQmMEVWa602yHL04PwMp4u8I+3iIGiqKdSeiHMZWsE7uMTGb4Iw7eaO96k9/cV
 3R9G5fjABbBMBWSw1Fg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0OCBTYWx0ZWRfX+/RzNqKj5mlA
 no7c8w1o8DyUs+2CcGB+FalwF0lSsqOvncsm+q71MrlQUmjwiTeHfOf323NW+lWYEEtf+CS9Q2V
 8In3QTYDjHDYvTeWs0DqJ2FOZdkHyU4S8HqKMGo0D96bX6P+Dy0k
X-Proofpoint-ORIG-GUID: F7uwYRKXOX9No0IoPhcuIYW69tO_Fg2s
X-Proofpoint-GUID: F7uwYRKXOX9No0IoPhcuIYW69tO_Fg2s


From: Dave Chinner <dchinner@redhat.com>

The stale buffer item completion handling is currently only done
from BLI unpinning. We need to perform this function from where-ever
the last reference to the BLI is dropped, so first we need to
factor this code out into a helper.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit 816c330b605c3f4813c0dc0ab5af5cce17ff06b3)
Signed-off-by: Mark Tinguely <mark.tinguely@oracle.com>
---
  fs/xfs/xfs_buf_item.c | 60 ++++++++++++++++++++++++++-----------------
  1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 3e2b0346562c..677c564cfd1d 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -441,6 +441,42 @@ xfs_buf_item_format_segment(
  	}
  }
  
+/*
+ * For a stale BLI, process all the necessary completions that must be
+ * performed when the final BLI reference goes away. The buffer will be
+ * referenced and locked here - we return to the caller with the buffer still
+ * referenced and locked for them to finalise processing of the buffer.
+ */
+static void
+xfs_buf_item_finish_stale(
+	struct xfs_buf_log_item	*bip)
+{
+	struct xfs_buf		*bp = bip->bli_buf;
+	struct xfs_log_item	*lip = &bip->bli_item;
+
+	ASSERT(bip->bli_flags & XFS_BLI_STALE);
+	ASSERT(xfs_buf_islocked(bp));
+	ASSERT(bp->b_flags & XBF_STALE);
+	ASSERT(bip->__bli_format.blf_flags & XFS_BLF_CANCEL);
+	ASSERT(list_empty(&lip->li_trans));
+	ASSERT(!bp->b_transp);
+
+	if (bip->bli_flags & XFS_BLI_STALE_INODE) {
+		xfs_buf_item_done(bp);
+		xfs_buf_inode_iodone(bp);
+		ASSERT(list_empty(&bp->b_li_list));
+		return;
+	}
+
+	/*
+	 * We may or may not be on the AIL here, xfs_trans_ail_delete() will do
+	 * the right thing regardless of the situation in which we are called.
+	 */
+	xfs_trans_ail_delete(lip, SHUTDOWN_LOG_IO_ERROR);
+	xfs_buf_item_relse(bip);
+	ASSERT(bp->b_log_item == NULL);
+}
+
  /*
   * This is called to fill in the vector of log iovecs for the
   * given log buf item.  It fills the first entry with a buf log
@@ -567,30 +603,8 @@ xfs_buf_item_unpin(
  		return;
  
  	if (stale) {
-		ASSERT(bip->bli_flags & XFS_BLI_STALE);
-		ASSERT(xfs_buf_islocked(bp));
-		ASSERT(bp->b_flags & XBF_STALE);
-		ASSERT(bip->__bli_format.blf_flags & XFS_BLF_CANCEL);
-		ASSERT(list_empty(&lip->li_trans));
-		ASSERT(!bp->b_transp);
-
  		trace_xfs_buf_item_unpin_stale(bip);
-
-		/*
-		 * If we get called here because of an IO error, we may or may
-		 * not have the item on the AIL. xfs_trans_ail_delete() will
-		 * take care of that situation. xfs_trans_ail_delete() drops
-		 * the AIL lock.
-		 */
-		if (bip->bli_flags & XFS_BLI_STALE_INODE) {
-			xfs_buf_item_done(bp);
-			xfs_buf_inode_iodone(bp);
-			ASSERT(list_empty(&bp->b_li_list));
-		} else {
-			xfs_trans_ail_delete(lip, SHUTDOWN_LOG_IO_ERROR);
-			xfs_buf_item_relse(bip);
-			ASSERT(bp->b_log_item == NULL);
-		}
+		xfs_buf_item_finish_stale(bip);
  		xfs_buf_relse(bp);
  	} else if (remove) {
  		/*
-- 
2.50.1 (Apple Git-155)

