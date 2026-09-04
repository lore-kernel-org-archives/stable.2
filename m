Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EDB3CD8BF
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538429; cv=fail; b=G9GkDHdMXqN7Ti6LVGxuG5WBgXsSJMySxstpGXchCMCIXxlAP2iVZcwhwwQFuqNpb4UiHXLOJyUmFK+R9gLHv2ibj8gbWCnnDqEZapJR6TNENYrQq/eoiQm1mMtqiWgpGds80A2OO43XYZR/rLdUFPeAIMtCa/+/y1zuVI4kmCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538429; c=relaxed/simple;
	bh=U4fQOTWGMLqYGhEeiZsLj2wGW6b8LGvcQUxIwH8GhHE=;
	h=Message-ID:Date:From:Subject:References:To:In-Reply-To:
	 Content-Type:MIME-Version; b=k4TBfYlu+8Pa8lW00WdnEyBJOlXqLIWXVGBaIOeOXMKw8ULphSl2auYkX0w8yYoCupZkR/7ZrPfnqCA2cUlsIcdy9QVl0oKbRQgdm/ZM+Pjp5sHLK4OqVoLwXdv9xE/Bs4fG7oZQGTLVE7h/g151vWPQyc2DeyyMbJc4uAYR7zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ArO8Bbb2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YRZ/WaRb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ArO8Bbb2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YRZ/WaRb"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Bgvh32607824
	for <stable@vger.kernel.org>; Fri, 4 Sep 2026 16:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	corp-2025-04-25; bh=6OevXK14rAxajvCIxd5IRqpc2w4BZbWnY3VxmIiX07Q=; b=
	ArO8Bbb2zMDyOIMYwVOExRJTW8BR54mNJRZgr+WMjEiansIe+EBTHrirc4rlCM2J
	7wzNgn81p2BUX6WybdvfTmsEgUbS9aXoeEWQ7x50MZsZRmjg9v7KoRpm/85gfdrT
	qmseP+G3ibVdWry/ClTvtHPGC91YJbgCpZlmR6RCKecTU4SjxB7iE4JutnRb5K0y
	gkgjuEukTDuIzYDu+3IYZ/mVhTdDGOts7/AcqSzbIKyd0DRVMorZj0ncpz2NKXsc
	BK9TrZHYAi0Hs8weR/THa5lpBBDYWLIMflHoUdGH+1ilzdQ0ZA773xuqn9DXGjUi
	579EWFmpg6wKEIqWPoFrLQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqys32be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Fri, 04 Sep 2026 16:13:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 684GAWei011473
	for <stable@vger.kernel.org>; Fri, 4 Sep 2026 16:13:39 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvj95ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <stable@vger.kernel.org>; Fri, 04 Sep 2026 16:13:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inecDdqgS7zIclUlPqImNThCdl11LBHCswnLwiw2eXfNRTdKRQHJRGIFZeu7azL05XtqfwPJ+OFGVbAmYqNA6NbnkxfP33e64Ivf5vw6TGNi/H/9QnYT9IOaIADqVprqSDo7IG23xkFjIvhn0g++TQbOSex72hX6ApJg6BnJS2T78ZKH8Rlg5E/vGGPtcjPAoOVyvwktoPr8XXcVUMa5fKRU5nHO3YN1xX5FfeFny5SVNJtObW7jFTXtu5xa0UoyraEtsTpKIo1D3JCh6d62agsK6MTddC82d5If2k8hS7davRuKD4a1QJ1W9v1kGLJo0czZFoyHz+2Bq7FQpP4HDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OevXK14rAxajvCIxd5IRqpc2w4BZbWnY3VxmIiX07Q=;
 b=GAOsHRESWv0b0uG/X0fNDS8vYH54dIZ9KKeJPXYeB5G0zcQMod/XvXeB8Fn+yTLzAuEuvqSY8jRWPudQ1xFVCl5O7oDAb5vateIZKwSmNGpHmqfApA37wTyRNvgWjzh0uZySzBO2kmHKCuzk0XzD3JH/uBCwWWh250FNZ9eW5I6hsRQObLm3yWO6cuL+SGRZFeDzVHVjYftbfEKeCTClC1wrV0ibIYQ40vK1HnBfqPvkKvIfoU3J0gJp7pS6Rlk58/0bzixT2tOHeCwxXnsfLYuhLFz8mxovBSKIqqdh8ZhYzxC6j6GxME4DX7q9UmIQyALnaqRuuPbA/jwnxzmmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OevXK14rAxajvCIxd5IRqpc2w4BZbWnY3VxmIiX07Q=;
 b=YRZ/WaRb55YS5gEqEC75I4b2oZDThLT6R5UHuI8NnuigRNpcyrTjg7emAOs+nA1nHPcnM8URjrdeq1PNg0tubYa5ZX27SWDeThKod5co0rq/9qqVLnTI9NdP1QBokjKtIrMK3vL86V3YOqZslIeMMWnzSDTKcvA9RZv0gYWls/A=
Received: from BY5PR10MB4337.namprd10.prod.outlook.com (2603:10b6:a03:201::17)
 by IA0PR10MB7205.namprd10.prod.outlook.com (2603:10b6:208:406::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.4; Fri, 4 Sep 2026
 16:13:35 +0000
Received: from BY5PR10MB4337.namprd10.prod.outlook.com
 ([fe80::587:3850:b94b:3577]) by BY5PR10MB4337.namprd10.prod.outlook.com
 ([fe80::587:3850:b94b:3577%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 16:13:35 +0000
Message-ID: <ff3c3a3a-2992-4607-aecd-0821ce3c8638@oracle.com>
Date: Fri, 4 Sep 2026 11:13:33 -0500
User-Agent: Mozilla Thunderbird
From: Mark Tinguely <mark.tinguely@oracle.com>
Subject: [v5.15 PATCH 0/3] xfs: port fix unmount hang with unflushable inodes
 stuck in the AIL to v5.15
Reply-To: Mark Tinguely <mark.tinguely@oracle.com>
References: <20260904161002.51054-1-mark.tinguely@oracle.com>
Content-Language: en-US
To: stable@vger.kernel.org, Siddh Raman Pant <siddh.raman.pant@oracle.com>
In-Reply-To: <20260904161002.51054-1-mark.tinguely@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:610:b0::6) To BY5PR10MB4337.namprd10.prod.outlook.com
 (2603:10b6:a03:201::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4337:EE_|IA0PR10MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8284c2-9630-4bfb-6ba3-08df0a9f78d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|10067099003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	PZ7Xo0+vTxG6XHKwYFFvxsWzdQqQu6wCpdkO/sn0FWgzv/D/GLH9kF5olk0zQZ/dy4bnGc219WwtJ4xQXd7kE8FkDHCNY7H3IbH1fYko38rq7pfyOuJiZ3pcCAH7uKVez/SkaPaiIs6aKCIRlExdSUc/weylnS7OxKDvs06Q8SNXyDIMJYh52ssUYGTZeSwMPug0nZHFyKJtz/SUVTVl/MBWulEtDhem88DMjpDjMydPb5D9IkwfBHw/xTZ2mckuOF/9hXuRZgmkXbztzQjF2OG34SAEv4AHtckS7oYdqguDKM6q1t4zMH1fnKvnXUCVGOiJiTHPopH1B1bu9D74W9vS5O5b7+ViU7NUdizbs4UCxW3EYTykXATr91DJ35xh5PlzSO3y/t4oQtrI/L/RwX3qY5R4KZ+p64FKb8alj57BWBEjGfeGl+wqiJBiYkW8csZQfji0/OOLXBdFu3pWRYulTie8tDUro/st5Ty//ypctQq/CjAfsx6JbZLIjv4/cPRiL1vVlH1xHZiZ7LVXzH9Me1HivQkLyLxoW91Ljs0zWXfqnyArkj6fclfZEbIbDTLsqNpugcywlgv1vS7oTM0khmbbZ0GAd+0WUSHJQzml+vAt+TJdBR0AFt8/BxUwF/jj/X1O3IY2sIUBUuQyL8Q0APX7KpBHa5toDSdyLjY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4337.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFp4MFk2Yk9GOHlkKzB4dHhPT2VVUEZySkVSU1dzV1VyUVFJYnN5VTl5ZUpW?=
 =?utf-8?B?OGJnTUdEZDIyVTlleVp3d0w1alM1MXlOL3k5UHgwK0xWTG9hYXhEcEZpVnBG?=
 =?utf-8?B?eHdza0NBUWJhYXhNajZ4Y1BWUUt6VnhNcVlDY1BRc0hHMFFXcitVcnBjVkh2?=
 =?utf-8?B?czNKZ25UemNoUHMxTjllNjc2NXRnMDF5ZUE2MnZITi9iaU9qc25iNEtWWUEv?=
 =?utf-8?B?ZUZaeXF6Y25idmRlM0Vqd2o5Kyt1Y1FaS2M2Ym51anduaGlvREJoRUJGZ2pC?=
 =?utf-8?B?RnNqeUI0ZmVHWVo0aDhqdHJ1VjFXeklwM3JqRG9FdVFQS0hqR1pvWjVOTWp6?=
 =?utf-8?B?NkVVWmpud1ZiSUw4bHNkbm5tWmk2Ynp0V0NJVkViMWlXUXVQQXZmcVQ3TmR3?=
 =?utf-8?B?eUd5bW1YMmpLU0tyRm9YMVhGbjZIQmlrNGZaeXAxNEZqRktYZy9LMlp6eDBN?=
 =?utf-8?B?ZExRME9lbGtyRnhTUTRZVzVTR1VRUy94NUF1b2VWK25LclFEYXFKMzdhUnkx?=
 =?utf-8?B?YUVmWUVpQTBZRFBmSEt5M3dIU1FXMmNRekd3UEdUZmRvMEtwWWtlbSs1TmxT?=
 =?utf-8?B?cVZEbjVMMnl5WkkzY2VBRjhuTWJ5QTBPN3JOQmdSU0ZPeTUxeE5aZ1FhQVNR?=
 =?utf-8?B?aG9RWk91UW1lQjJoVW4wZ25NUWV4RXYrSDVneUI2ZUtHQ3p3SWZKMUd4bTVZ?=
 =?utf-8?B?MGZNamRhMUk1UXhRUzVSRkhicHhYc0V6YVVScVptVERiUkRuKzBSdnE5d1pI?=
 =?utf-8?B?RllCd1N4VHlvQVNKTlVUZkxjSnNsazdPbk1zdmpOU21FQ0xpSG5zRUlMdG9k?=
 =?utf-8?B?MWQxcU1rSE4wdDRkdUV3bGxqOU85UW1HOUJubE9XNWg5NEprUFdaM1pQNTFj?=
 =?utf-8?B?TFRoaFJKYzNqUEVYYkpYS2hkcWg3Zkx5d2hGNkJ3TmVOYVJnOTNkejdBb1Zn?=
 =?utf-8?B?UHRWeGFsc2QrcWpTTFZ5eTZSNXZVN3hmNkFMZWx0blN4T2lCSWkvNEhMeHdW?=
 =?utf-8?B?ZVgycWNSYlR3dVVqbjVnRFB1TTNsOGZHNWRGZWE4THMxTmljbE1kUlFGbGJ3?=
 =?utf-8?B?WUV0TSs1V0RVQlN1cnFLY293emtRcU5GSlFaOHEzaER6NGNmY0RqMGxlaWdQ?=
 =?utf-8?B?aG9tdENrZ2xwUHgyc2FGRlhCRGcycXUwNm5taVVNbUJXc0YwOHVOSTczNlBQ?=
 =?utf-8?B?NWVjZlB2NVQrYUFISUswV2lzdERRQ1BOd1F3RWFjK1Y0WnlPYUdmVGNHZmo5?=
 =?utf-8?B?d3hPaG1xUXpCc1lzNVlrS3EveW81eElUL3RvR0NkUWVUQ2lxZk5SYm1DVTZq?=
 =?utf-8?B?dk44NzBSR1FSRFppSExsbUtHTDN6OXRwZjNLQ1NmRHNkTTNPVkh4S3VjQVZT?=
 =?utf-8?B?amVleFE3N08wRzVKZXRXMHZYMzg5MXBlR3hGSmJNd1pEMU9jVGRwRGhSVkEr?=
 =?utf-8?B?V0pZd1ltcDB6ai9qOWoxQ1hIaWNMeEcxNVVURlFuZnUwVU5ka3BUOTRUbHd2?=
 =?utf-8?B?bTJGWXVvV2pDWEVGcGg5UDZtVUwvUWIyZnVxRm9pZzBqazR1VkltUDNlZjRV?=
 =?utf-8?B?NkFNcGFQTk1KN04wNHQ3anc5RUdKUDhlVnFyV0VIOW05TXY2WGZSVWRsRUkz?=
 =?utf-8?B?dTkrakZYVWVJeDNsQkJ4dS9mSktyLytGUlJoNUttK1J5QTllaFdpUlp6eGxM?=
 =?utf-8?B?M2orWWxVNjJlOXRBSGtlS0FQc25xK095Q09GK3dqTWZHVXdCbzBpYjhRQUxn?=
 =?utf-8?B?cnN6YXJYZC9OYi9BeTVYVXlBN0xRZ1FvazRLNlVjdVplNWRaK29tQi9MajNN?=
 =?utf-8?B?NHE4TjRNbDFkNkQydFR2ZCtlZzlucGJDbElXQ1N1QklBelE0Wks0bS9MUXFZ?=
 =?utf-8?B?Q2N6eVFLdGpSUjlxSFNWSmg4Y3BxeWc0UGlMWFdrMXAwS0xKQXFQdHY2Qzh3?=
 =?utf-8?B?ckt5bjhlT1NmOFVIMHZsWDZubXdVelg4Z0UzbnZWUWpKSlVBRUVzdjgramJG?=
 =?utf-8?B?bmxnS3RMTzNKR21MT0ZnelgzUlBlcW9LYVZwTW1sbkJPWWc1aGhLTU5xOWpH?=
 =?utf-8?B?MlZVaEplT2VmZEsxSUpPaDN6TnlwRFFDVDliMVhxQWp5VFZkTVBhbFdUeXpk?=
 =?utf-8?B?c25MZExqMXlRT21WcnNXUkQ4YmlpakpnbjMxWE4yV25mNitzOFk0WGVXRCtx?=
 =?utf-8?B?SzJtWEwvd2FzektUWGtWc0h1UU1NYlNTZmxBUkliZy9OaXgzamZuWHhoZFdX?=
 =?utf-8?B?MXQ5Q2N6dzJoN0J1NDVNUHJucE1Id0h0U0p1RXhSWjR2MEM0Q2YraGQvZGRS?=
 =?utf-8?B?VWxHOG1RczdhL1BvV2M2NXRQNmlwQzBXazhsaU1HcWhEQXVVU0J1bmh3Q2Zv?=
 =?utf-8?Q?lgfMK8KlyAdybVXc=3D?=
X-Exchange-RoutingPolicyChecked:
	GSMFpfPxzOMYzUGHHJIrEF/Ywm8312OTuwvmjS0xuTeakAFc2128v5oKJRADoPgKa8J7nzGYUwiib+ytMZVNhdeT4zPAL5UY3eF+CdJ3gKneH5gyAZ8mIAP4fju+S6JEzVcLA8Mb+YTF1j8XwTVPC5Bbnam14h5aP3mPON7nBFqG5n0cTZ1uWQEpc7+gWbDlorp+9JlSQYkT4MhkoIw8xpfYXsi744U8e2zUikxax49ME7ttGWrUWVBs5f6MQ3SVHzuPMLrm7w5zmQvu8QPAb+u8wNnICos+aTGVI3uVmhwnf4KhTkBNWwKUxJUBwXXrxWtNTQhiW2C0guC0/wO0Lg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	69Z244J4KDqWEohalrxiJoOVxqNdzkN9iiz/orbgjDITKsO2F6pyfO7cHXCue3bPFilvCmQLAfFgPfmWtKd+yvN86B1khEj6tkKh/Fm1h8YcbCi1TXtyZ7StG0SY0PTMA/isc6DGcOvgUoTlezu3gIqDdPXXwhYnzQoeCUHv62Epr0XzYImNXOMRf/LrwfTeVeVj4PBEAd/xXka8H75EnxKYCrG7ZXXgpKPdGXKsBdWS0E1xJ1OEUgW+bHDQixFs0Hs+T9LWjHWxxoklgjIo1y2mD6iv+DncZGD8UGG8MN9Xg4fPNh4VBcCOhH1CeydFyMtVsepr0Mdkyc4lLbgKVUy87URQAXFbH1vF8nyR3av8QbtrUtpB1quariKEATmiVXbed2r0FW9BPbJ1mCosoidpZreu4dbLVQTuLYvVrlKdovGH7a5NAaJElbFCPHekugSPr07u0ukDJLiOAQdhAHQTJZqtiZd5HXqxMUM9pDUT7yxzQOIK97L0pv7+G+vPmU7fItiy4IoRmIniGLzxkqYRR7jp+jzrDO1ztRVL4QrEWxZpQay/S+IraUI+y9HOqiZC7BPEJelt/wehPO4B7E17AzpuQweyWNi0B9EhO9s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8284c2-9630-4bfb-6ba3-08df0a9f78d1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4337.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:13:35.3905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5M7dJv+BhodGXBSTn0rc4AWrLy2w9M+poylRpPYd7Txqa/09uET3YRGL7eYsjrHhWZ4bel9FSjokXxcToDXThys+D7VPMaevmEPyCBC5/e8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=971
 mlxscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609040147
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0NyBTYWx0ZWRfX0ODxPJySLzfU
 wxxR2+eqMMkLYoy517J9YbQr7C/q6IlGpW/oxFhdeV2HI58juXeMjQQxWZ4Tidlrplx6Hrxeyi3
 MU3imN2a+bMkLlDqTPPt9ezHTrL4qFuV0w8vEtVWmlS/WxyrZjVOzlMUCQDuYw0Fi+MHdLCKTld
 nIdfU/VLpDPUBZBe80Fb/M2Yu2DgsjNgC0zooTclckG+WrCCXjXwBdJEKMhkeoXvxfzXvjUSoe+
 uE6ZoWKJXqIYBN3rW91cCxRzaWH/sIOvMGbFqZSsBsSik5icGyatrSQ3qmXQNqCeJioTgkSA7BJ
 Ci/lbQ89v2QTDu+Tcr2nvRyjvL22gcheQljUGfg3c3onhQADWseVGT/H3iJVIJeVHYhDSTwrSuZ
 KNw7VOx8wxqum8dsi+q7jFk6FUs41FW05/h7/JcDwYkLDSyYoa9wUWZ17N9CB7zPJKPwCDBcoc2
 RZrO+27e+/rk+QyMERg==
X-Proofpoint-ORIG-GUID: KIAGTO0NE0ZahGL28XyduepMwftdGrVX
X-Authority-Analysis: v=2.4 cv=fbCdDUQF c=1 sm=1 tr=0 ts=6a9aee34 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=Tl4HHq30RWSlvUKr:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22
 a=ClL1opBuni4ZFPfddscA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KIAGTO0NE0ZahGL28XyduepMwftdGrVX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0NyBTYWx0ZWRfX84dXVRfuGcYX
 hXzkrAOIZQdKjqjbQf1Vz99FdZ4M8HRECddndAUMgD8ECkLt4RwzWgrkA2ISoW+4kBFyAvmXFVM
 LUL0vHKEpbAZxN3ixjPvw3m0m2oFn+8ZUxVVmhUjQeU/M2ScmIf7


LLM flagged the need the patch

  xfs: fix unmount hang with unflushable inodes stuck in the AIL

for v5.15.

The patch has the following prerequisites:

  xfs: rearrange code in xfs_buf_item.c
  xfs: factor out stale buffer item completion

The conflicts for v5.15 were minimal.

Mark Tinguely
