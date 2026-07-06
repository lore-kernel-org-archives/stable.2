Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023106.outbound.protection.outlook.com [40.107.44.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742683BBA09
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327945; cv=fail; b=OTP6jh5S89HadYbyye7aNXjEpe8O07DHg8zYNBNJLQAnirD4nmyMv3t6OdHt5+bEM4HXpFN0lYZfUj7F9XstkLnmwF/RiukgZ1g6uOaEO3JZylOalY3BfIOqUY8XL9tJ2MNxr9ksu9WR2kY2TTipBXm1fsFRWfb7P7P4YN8g7Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327945; c=relaxed/simple;
	bh=jS9oa363OhdyCrFKsrSDsS39B5oGOhaj3582+a71OK0=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=POyHD6PQhp43pFml3miAnSEEcoCRXwV8saKz4NR39kZIKAi8Jctk1X2ahjCTyeJSN81KLdtJooxCiuSNRAKG3NBtlTU8j2O/V03YmFv6+AlvKAq/tDtee8kWZzkeXTnlRf8MMySsuujpj+iPACnxdr1WU5ds9Qz5CUxasTem84k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=bPRCiqeG; arc=fail smtp.client-ip=40.107.44.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="bPRCiqeG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Je8njXNQn4k+CpFcQ4D3Ra8Ar2uItB969lJaOLCGAgtIw1EHfH2nRLh4i2xqlF1Kz0XToxAeeZAqW3zfuWOMoQPfsQK1jEKkSyjiNboiFTNlwS2squp7pM3IPWBidpc5eUaQJYGn3JrmdKP7+kcf1fG6ErHYdi8xQtrAk5aN5qod3f4aog0OTyroMqqzgVrxWqQ2x1058pwCfpw/9i8S1KlVGEc3buDPUhtpV0t8FrGs1yjzam1WvZsKRQrTfCSCe2b83J5w3R5kqBYFC5APMeQl4iZecwNtn7orrqqkbWs80YaNTOtjmN4sHYOsXC5OF3WNhBt3xk85oYbqU2TrKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2v32qR5IbOodZB5VEQCIga7d/ZkYOx1oH3M2xhIBaKw=;
 b=jf19dZgCkBlr4DdwKjNdY8bCOAxotxYdVa4nlgJUTBehVcMHJDCkf+sZS3t1K5WczU2EcJSFPdSrycPAYhSp2GDj0hzc6btlQ57FzDZtwgKhIuP2PQbTCD5Y1ryOBvxNAsp+tNqizw7VGWtWBgkLWaW6Rn2dTRI3Nng1XYRUeEWMMZYlPgqVa8f96rZGU6sCKT4Cd936HRbKwOOyuJ9dIFL5qUi/XfIR6zUmXoaQSe7lhdE0khIPhUe5yVVWaDIqm2d4PE9X4LhutGFrDsJJJ1Im3Z+z7lLMljBL24DKqsUcppJnueB3cp7QVrzeRi/oj1CI45POmLf7ZNK/jzIY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2v32qR5IbOodZB5VEQCIga7d/ZkYOx1oH3M2xhIBaKw=;
 b=bPRCiqeGaMlqOM9vHvfVO8eejVSPDta1QBLpWJmf2UuMDLQH5CcyGBB1IgFtr+3aomgNtKLyI3n8u0Urt5MjnVHRPr0boaY8Y2qH7nqdr5SMUuoV8rP2PI70oPPmYoV2tOaFP02svay4MA3UOlIQxk4b+7ck5QRnZT1lZF7XI77a6c6TxilP7/QVX/9T1umjUyYSL+yl2v+A/W4fZFAFAy8Yn2+giCWcxPdWco0qx9oi4z0LKr0E+ApR+oAVj/cvQ3gDTqqoHoabqoz0qEcDvi2c5YKzIg7K6/LdtlMF3PWusEtph537M6DQVc1l27RRRCiG4Xdg6i+1ud9petkdyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com (2603:1096:400:354::5)
 by TYNPR03MB9822.apcprd03.prod.outlook.com (2603:1096:405:3b2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 08:52:15 +0000
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::525d:fa76:296a:a64f]) by TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::525d:fa76:296a:a64f%3]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 08:52:15 +0000
Message-ID: <e6003504-96f1-4dc8-9e6b-e17c8f809d75@amlogic.com>
Date: Mon, 6 Jul 2026 16:52:12 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: Jiucheng Xu <jiucheng.xu@amlogic.com>
Subject: f2fs: fix UAF issue in f2fs_merge_page_bio()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0014.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::20) To TYUPR03MB7232.apcprd03.prod.outlook.com
 (2603:1096:400:354::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYUPR03MB7232:EE_|TYNPR03MB9822:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f33044-7d27-4a37-c839-08dedb3be062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	wjespU8odccaRDm/4rnOn3bEM3494D+BB4j+Q6JI9mFrfcAHH1RF2OlgYZHl5yJIbLl7SIvRt8vR4RxhJDSR12Ml262HqcY+XDrSZqOJcd1J9Cd2UK3mg7gmWSutodR9s4i1/SEOD0IQ05rKj4p8wNKKXlefQltegdxwv70NHcYYydTYGMct5I5EO5/uVgGRY/nl+svNE3lyLIzYRtZprZCu+cRePyvovJnwDemdw8+n9wysDTJuUXlG4jD0yLawK+O0lLs6PNEYAfxL6qM+tnandlktxTml1l30hjMxpvTWAlTqYt/5cqA4+Z7EwkYB9E35SVDqmextFlo+buqq021/rsqqI9MF1teeX0efuICrQCqhhEoC4ggsbVS9cWiVgntPYNviyLCYNM2uH2U1a/z9/R5YLDC5VLLOvi/LAoo5J+E/JKj+ewnxHATuy0IROofGkyXeTo3KwXgKe8jNkEQE69vEXjVADZTAWH1XD0E98Y9nf7FWafr3DEOSsU4nSrP+w1BzF972NF3HNG6WWKHXs38dRf6drJQycmLdao0OvK2/ODafWIdZa55EF/iL/oIollqPCFjG9+lGccrRC63TLzy7YSwHibH65OTb1VvhRqHqlULHE1QN1jAL/6ZIkQt8o+9W4Q/2kw9Z4jwljmCNqgjki64684LWOFjys/8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR03MB7232.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXZwNHJrRmYvazBGSm1wcmFpVFMxRTJUZkpHblJ0cUlscSt5RjNMek9mV09h?=
 =?utf-8?B?dENxTmh2NnB1aEVZMzNkUmtIckUrTGsycEtLRFdOMVpHK1IvL0VodkxFOUZu?=
 =?utf-8?B?OFQ4UUtTamFDMTRCRVlTV2VEdHdXV3Nhb1pFTUtZejl0TDY4UjdnZldJY1ZU?=
 =?utf-8?B?R2c4SmhhM2pjUXlLTEJJWlB2LzBYK0dhVko0U2kxU1p3S01qTVMwam5GQVdo?=
 =?utf-8?B?R25neVBUcENhVDR4L1pvMGR1NDIwUkI3MUR4ODdtMlpndWt2aDBQdUtwZUtx?=
 =?utf-8?B?dkdBTllkVHVSU0EyY0FrTkVrd1JYZUt5SWQ2STNqMkU5WU40aDNBWGZ6cEt6?=
 =?utf-8?B?eTdFeDFqcXZlWWxIb1RyZjNWL2lDeTQwVkVQM25nTHBIVmJBTGUzQlNNQTJ4?=
 =?utf-8?B?dnNwZFA0Ry9PYjhENEI2aVM4RWVhTDFxUk5rbFE3dFpGczlNNzB3NGQ0OElV?=
 =?utf-8?B?dTh0RWlLYUJEQ2RJYlhCNXdIUFl0Tk9JNGZlYXRCV0ZTLzNFSzl5N0pzVE0z?=
 =?utf-8?B?d0hqbnpDMmNoVHhRSURmYkxkK3pBQjhINnkxdS94Y2VSYjdIOGVWY21lQ0Nu?=
 =?utf-8?B?YndUQUJmOEI5cjJZdjhURnRNRkVONTQxdFRweHYxZHF1V0FUTlNxNU9WUjdK?=
 =?utf-8?B?dGxHdlA1OGZSTlZsZXAwY2M2QVVKWm4rZzFCWnd3WXoxU2FVelNJYWV4ZzJV?=
 =?utf-8?B?SERxMExCQjQ1QzZWdG1GTm9zdksxeGlEdittZ1F0akd2WEplQkFIZlFpOGw4?=
 =?utf-8?B?TUxVb2t0TnJnVCtwbW81dHJjcG40L2hNRTlBZkVPWVNMQ0xOS3drbTJSQVNj?=
 =?utf-8?B?aEdNN3VuUmZmYysvVTMxZ1lVZ1dMNVNrQWVaQTIwWFRvWE9VN3ZhbzVnMUI2?=
 =?utf-8?B?VjVXbTRWZ2hjODVSTWVNYzhPVnBsLytwU2tVV3NSajRIdTFxamUybHg1eE1J?=
 =?utf-8?B?MVViWFRBRVpYYk8xMWxJdmxjTGNZVjlnZjRqbTRpbmNjZWhETnl5TlV6elB3?=
 =?utf-8?B?UVJYcXdiSlVhVngzd09NazZUWjJYYjcxSC9iWUppVitjL0hQcERybmdkSE0v?=
 =?utf-8?B?alN1aVBEcTd3WXg1MG93VzYxZ3lLRURQZjA4ZitMdkdxWEgvcHBCb09SS2Fk?=
 =?utf-8?B?ZVNkMmxGSTNMQXU5VlJKUnZrUFFDZndramt1d0gvTVRQVm9LTFJEVTJYSUpJ?=
 =?utf-8?B?eTh5MkpDMEVBTWNwSmw0anJZdlYyUlFYUWtMdEdtRFJ1TldFaWpoSE1ZM2tr?=
 =?utf-8?B?RTNPWUhEWWxxMjVwdXRoK1JHaDZQdnFLVU9RUVUxb2NBVlowd0wzZlhKZUJr?=
 =?utf-8?B?RmF0TnF6VmZ6YWtSK29YRlphU2QyWlFsWGdaUEs0dXp1bjFNWllIZnhxR0Z0?=
 =?utf-8?B?SzRHQlhaSWxzVnBkdmhvYjZSVDBjTEpzM3I2VVQvZDZPN0NJOXIyYW5adklI?=
 =?utf-8?B?MERBd1JMSGxxZWVpVDJPK0p1VzFvR0haR3NNV2JTNHBMTTdEYkFTKzl3UTls?=
 =?utf-8?B?TFFIQjlNVmZuVThMQStrTnVjSm4zZGFaaE5Wd2ltRVZYOVNXZ1B6eDBnRTlz?=
 =?utf-8?B?dEQ1bXg1S3pPUXlId3JzOVBUSHlrL01PWmttL05nWEZsMVY2bDBRemlXRFBG?=
 =?utf-8?B?b213RUg5UmVjdUhBSlp4cDJOai9rNkZKS2hxRGNBb0tSQS9PSXhBNDZicjhP?=
 =?utf-8?B?R25lMkJvUXB5STJyZlpqNEkxVnlRY3Nvek9XYTRDZCsxSHk3ZkNEQUZvQys2?=
 =?utf-8?B?RWJ1TWJMUk16c0w1NTI5SjhuaWF4aFE5ak8yeXJGMG54TFBhS25wcW9oWDdZ?=
 =?utf-8?B?SXc0ZUxqc3dUSDZzRkk4TGpHSmFlS1RhVVVvTXRHWWVzYzNteE5HaE5Ebndn?=
 =?utf-8?B?SE1CUnloU2M4T2ppVmJNa2tBZFJzM2FhRzRreGpMQ05QT2FTUHZWV21tWVpq?=
 =?utf-8?B?ZTdYVmV0eHZCc3lWN1dFU2krUHZqc1k1clBsdUJOTk1MTTVLQXFyQkJSaXNh?=
 =?utf-8?B?aHl2ZHMzOXp1MEdGQWluaXNGaHlVMis2MHFOeDdKLzdhUFJOajBMZzlJcE5C?=
 =?utf-8?B?bzhmWjRkTG1GTFdjWWlYVlc4anovTVNwU0J5a2FMTVRFaWV5UUJCYkVXOTFv?=
 =?utf-8?B?THJUTis4YkZmKzl6c1gzM25XTUw3SUUrbzdHdFpPa3kxd01MdUwxczBpRm1Z?=
 =?utf-8?B?R1dHMnBqRmdEOW1ockQ4UTM2eUFMQWgycG83eDNjS1dCRDdZL0plMlpqLzU4?=
 =?utf-8?B?NFZFNG1sUlE5SlJNUE5UbXl5QXEvTmROWFFpU05lV3dySDNWb0hOQ3ExdTd1?=
 =?utf-8?B?bVFZZys3SDJ0RVRMM3VUVXdqT0ZLQ0dzaW1acEpIcHFOUzBuaElHQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f33044-7d27-4a37-c839-08dedb3be062
X-MS-Exchange-CrossTenant-AuthSource: TYUPR03MB7232.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:52:15.0196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgpLM3yA9ifTPP7DzJeZjIp4+h813sNPASMPA+hAXqlg19GQZ2JtzItceJTY0crJNxeI/jwrCByVhPls+/HCuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR03MB9822

Dear maintainers,

A f2fs patch should be backported from upstream mainline to the stable
5.15.y branches. The patch's information is shown as below:

[Subject]
f2fs: fix UAF issue in f2fs_merge_page_bio()

[Upstream commit ID]
edf7e9040fc52c922db947f9c6c36f07377c52ea

[Kernel version]
5.15.y

[Why]
We encountered the same issue on the 5.15 kernel version. After 
referring to the modifications in the upstream, the issue was solved.




Thanks,
Jiucheng
