Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4C53DD85C;
	Thu, 17 Sep 2026 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642243; cv=fail; b=ocSkJJmS5HIQWvhprBLtEc58nlj0wEt3yNyQvcMx9fIpQ4Paw1qpn/lAR69M7AWgB/wpHQeJ7CZ49vd/NjdDDx69qjlaSC+ifvBtqln5/1TajnrJixjQQNVbrHwad8ZvD+YyHZJQGmOc4SJa/ffsIYXq4dLpVhTiGqF/TFTG5zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642243; c=relaxed/simple;
	bh=gO1eVxX2msA4fzM1QYvc/ztr/Vq4WCh43Yjrwfu/Ef0=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NU1EtLqA/q1q+xTNwkxO6gL5Cekcehvll0yuggT8HgA/vHg4zJvgRd6jfO9M+H0rSKDD1lFOpGmVL2WRG+yJV7ZtJA3hC4a/ajPQjFXOz6R5QzBkc2WH/iQAPgP61NFKXqWRDAJQ5VRspk9c0svNsiOJThRZXjGHgfYGTENi7pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=EYkhZT+i; arc=fail smtp.client-ip=52.101.57.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="EYkhZT+i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Df78VCmpK4KU8dNUP2a0cM4vR5eXvdt63rBSgjAvhvdvU5TMDkLC8PVntnMA0ZlO+OYVIrm0LRHx2V/mRMctukfbkMl2Zfo8EudRIXydn/8hUEDkpqzrSUjF3ds/aoagx7JGPVlnGShU0A7UIkMMrSi+WT20iNyUPcFuKlWNwSllKw/IY5W07AGskDUJg9Dtu6ceRCjZsxJKulclQ3ugTbey3KzMymVy14l5iqBQI8XI33QYRJ4hDy5R/EYTwh0v68UhGARxFTGiX7Z/ZYQ4u3lf70bt8pCQVYziLySGnQxnDX8pSo2u/LltUk95T3XDMlJStl8jqZ1/8FqnYuoM5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gO1eVxX2msA4fzM1QYvc/ztr/Vq4WCh43Yjrwfu/Ef0=;
 b=UIK8Aeeyl9sj1Efpl1YziFXCD9aSiQzNGkHjLZu82IU9G6XPcbZjIn344njB0LXQ/RXaldfWhRqIYud9EtNORPd45nBsjFY6FvbLvjnftGJeI25tXj/CTBThLwVezGtrXl4zpH5weYij6aqiwxXvtcUyZ/mS+a7AgJI+g1lvORsijAAjd6dfS+kWscQ63OnaHpKfjtmQuqX+cLwlxujy4alOMiDDFDlYQhaWo3JiOksASJevtxyHipTYd4xgThIluNjaLgspLmyn7aaInVJTaTN2lkCZCqIrMKFpF7C0T9xP7FSj1YEJy0fojth0AxHy7QzdwbwUWHW49kukTk2JWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gO1eVxX2msA4fzM1QYvc/ztr/Vq4WCh43Yjrwfu/Ef0=;
 b=EYkhZT+i7ud8EeKeH/u7QYrWPudsoRYMdkX0T8A3dqGaSxcFRF2mPqPo657w30wRDE6LYUTnFZFjVHQdq/GHxZzGxg6sTV6VRcUK/0K/QlLhmFhvktbqPtoh0fFA0cKsxJo03NSuWbyFpBB1rl6T6xk+LHN7KEotN4Py8UlpRGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by PH7PR03MB6864.namprd03.prod.outlook.com (2603:10b6:510:155::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 17 Sep
 2026 10:50:32 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%7]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 10:50:31 +0000
Message-ID: <68e7850e-44a8-450d-96ad-2cd4948ac5af@citrix.com>
Date: Thu, 17 Sep 2026 12:50:26 +0200
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, arjan.van.de.ven@intel.com,
 sohil.mehta@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] x86/microcode/intel: Reject problematic loading on
 Granite Rapids systems
To: David Laight <david.laight.linux@gmail.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>
References: <20260908223209.916758-1-chang.seok.bae@intel.com>
 <20260916225939.1144524-1-chang.seok.bae@intel.com>
 <20260917101455.3e1ac9a5@pumpkin>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20260917101455.3e1ac9a5@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0150.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34c::14) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|PH7PR03MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 24883235-2ede-4e37-b980-08df14a97eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|56012099006|10067099003|18002099003|11063799006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1ngXmpcuCqUR1ape5ykKl441dhY87n3wMRfhMCVhErBo9JLryfcUwsNHyHogeFYNgYMvbYwI+MBPHtJLpeEEG10g62jRSJ3gLa/rvLsV4Muo9UjYxqNDQMbOgQTa2HnSmBkHbftS0IL8kRigSOODjxVzHTZT6aWKV3ow3mUe6Zwg3W+ZrM83vs7ClkaZIVO5LYqYQ9ToplgbjIOeKS2BdSL1dHo9SI1fKWZoIGblfA6Wo0j2MGK8x7NH4vilmOFyhakiKQZkZrP1fuNGJ3Ek7IiCV69ZPdCf2pkvnaTOcW+cVFr76fYdnvRPc9ExS5wUPrHgfPEzcxEa81MPm38krcz/3PjH7J8S3ct2+FFVQodQZPGFY3Jkr4NXmEt8aqUl2kf0X0o4Iy8DqjBNU32ohe1G4mpCVX1j4IOvsdICZOWW0vIeexPPrhatS/7/WiOPHR3nRWb534pgA0YjTYsnGYS2UsraAZMhHecBfRv8orXYs+hbc/ISoVD0AMSD7CVNObIX8cThv6AxJPELFgCvAGlCJpUuCvQq0QhX0JfTpD5Ks4K7ow3kjsiAu+7L7wztCYdPFqvF1HnYGsdepXuxR6dWm391ezBzf4jFMIT+mWksvPYA+u5AmEo4t74K9mb27JWLpgX4AsdlmNJKMtHsbudmtIQjpmsPnvVJA902EAQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(56012099006)(10067099003)(18002099003)(11063799006)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d000cTZZMFdzajlPd0JoaXJ5YlYyT0RxU2R5NmRBMDZKTGRFdzhRbTV2d2t6?=
 =?utf-8?B?N2doV1pPZjBWNnYyaTZJWjYvbjhXVElzV0s3L21uYldQRTA0S042aGthY1hz?=
 =?utf-8?B?bVFtM1ZrUjNBWlVpNVQ3MnF5aTlQNkM3NENOVUxKOTdMNWlTalFpRUVqTjQ5?=
 =?utf-8?B?UDFRQnMyQ3dMbjU4d0JzZDNqeXNBaWdNeTVtNm4xbjJ5b0ZxR0thbDdNQWNK?=
 =?utf-8?B?MElReXBzVHFYbU5OY0VBRTJZM2lPNzFHTWIrZEpMSno1TThnaWFzWHBHUmVv?=
 =?utf-8?B?eUJvSCt5c0dFM2ROOFUvWjBDSllvSTQ3dU5mb2xuSUxTSnFjMXZmZnhJVWFs?=
 =?utf-8?B?NnY1ZUUvU3BrVzI0cG5ka2VYQkJpVGlnUnFmQk9SUVFvaFJpMTExazh2UDhV?=
 =?utf-8?B?Y1UzcmFURnlXMTZrUlB2YmxnQlFvQnU1OVdUNUxqWHVhQ3BMdWJ5ZndZQmVo?=
 =?utf-8?B?VGNSNWpxVHBHWXExTnpBK25RcGhrQzYzVHBOSDFsUitFOWQvUkFTbXAwcVRT?=
 =?utf-8?B?bEM5T2gvUitmTURsY0gvQ25hdjFwaGQ1clZnMXFQanRTNDF3OWh6SlZlaWdV?=
 =?utf-8?B?a3g5R0k3aWJ0YVYvRVJFNUFuYkJDNGh5ampjQlorMi9BS2JtQ0xyOXJ1Yy9S?=
 =?utf-8?B?cXI5RVh1S1c4a2VFeitaa0w0cFAxWnN3M0RuejFFQlQyVEdXL3J2YlA1K1cv?=
 =?utf-8?B?WUFjVzFxQUQ1NXNMUUZUOFJvQnJ6cm9KcjJOaHhhMjRmUEZjVEdrSnVMZ0sw?=
 =?utf-8?B?TWtoUGMvcGQzWDRsRTdoNEZQZ1ozTXZ6V0puYWxNRFRPUnJ0WmQ4NWJmKy84?=
 =?utf-8?B?UXJaVkpyR0NlbWZpT3dRNHRQaFdOUXhRVE93a1FydWd3Sm5NaVNjRnVGRTJi?=
 =?utf-8?B?UmZjSUlPTy94eFg5NHdGTmF4MVk5VXluK2RFSFRvZXRLNkhaMTNlSGN3MmZw?=
 =?utf-8?B?QUF6TXc2L1d2bzQ3VnVvZSt3Qy80UFYzR1lMSWFUbGg3NTYrTlA5WFpxRnBV?=
 =?utf-8?B?dXVtYnZqQzdnb3paNFdYTjB1Mm55dUdGT0lGZlZtRU50VGkzS0xFZU02R0Jl?=
 =?utf-8?B?WlhkcTdpK1lOU1Q4ekNQUExHOEl2M3hHbkpsZTRMU2FJQzE4Ylo4MmthaEhz?=
 =?utf-8?B?UGFKaUFzRi80dE5YR3pvb2hzZ2RwTUpmRS9RV3prZ0xvQnludWtZeWVCNUU0?=
 =?utf-8?B?SittYXdaNmgzUTYyN1hlbmV3VWNGdklNVHNPanhjSEpIVm51OFBXcExLOC9N?=
 =?utf-8?B?bTRRL3dMTFEzcmlJY25GZURSTk01cDNLT1JPNTkxenRCZDVibkJveHY2OTdj?=
 =?utf-8?B?MERSWjA1YTFZNWVuVGlUUThyNzVGM0ZsZHRUc3hhWmpERTZ1SU9YMkZVT2V4?=
 =?utf-8?B?VzNKSUhzaHBSMDVFOUErakhtNjVtNUZFZG14UExNTHE2NkI0SFVYVy9XQ3Fm?=
 =?utf-8?B?cHhPNm1OSWZuamVLNjVoZjFGa0QrVFNueGc2bkRvTWRzMGV3L1kybGZsVC9D?=
 =?utf-8?B?bUVMWldad21zODVZYjU1OFVuRUtjNndpNHVJd1ZHZ2kyZzRzNS8vZGM2UVJY?=
 =?utf-8?B?VjFWbFd6cDJ1c3lYcjFpSjZKUlJxa2w3Z3pPdG9xYzZXb25JQ2RMVlArZFBT?=
 =?utf-8?B?UUlvNHhJMWh2MzRxWFZTQStDT0g1WDNJWGhUMUxXZ2liSnpQRWZzR1M0ZjZM?=
 =?utf-8?B?dG5saFBLak5MYUR0QUZpMjNoZ3lxVFhOZ3Vxc08yNTZ6ZWVONjlNRXJGeHU0?=
 =?utf-8?B?cE9FRmd6dzc0VXBzWFhpM3pVZy9LVmJoNy9GQWJyaWNIcHRJRk9jcDhHZmZT?=
 =?utf-8?B?Z0JZQnlZR05neE9HOWlxdEdjSTNIQXhkdlZ2eWFEcmZvcmFBRWptNW43QWln?=
 =?utf-8?B?QTZqWmVnUHVkTEFTK2JlZHJEYmZZNmc1ZS8wbnJoUmNHaUVTaTRJNGRYaFZH?=
 =?utf-8?B?RXZ3dEZKa1RMVE4yVDE1eTNOU0s1emEvcEdHRGZ0aGhsZ2tHMW9MTGZMNmFt?=
 =?utf-8?B?Z3U2aDQ2Y0YvZUlndDNwWXBZVlVUVEwwdkZScW5jNFlQNmVSR3VIbEpFa1Fm?=
 =?utf-8?B?UWxyR2JEV2t4QUlVK0llRE93TTNlL0FmaEZxeU1razJFNENHS2hFR2o1QzJq?=
 =?utf-8?B?WGJmZTMyaDhwK21PSkQ4V3FDVVNrUjJGa2YzdEI1Vk5aN2NHdmxYQjFrYkRo?=
 =?utf-8?B?RzBqeWp5UE5pd3FwZWFyeFR6QWxHSXpZbFN5QmNRM2hRWFlQRWQyaW11WmM2?=
 =?utf-8?B?d2tKWkZNTHJqOTFGaXlMZDVibGN5OXo3V1kwR2dYU1JVeXRCNGp5Uy9xemRQ?=
 =?utf-8?B?cUJLWFVJYng4M2JNZ0VsNGovZlZvbW9CMjZvZFplYnBjWXFTSG44UT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24883235-2ede-4e37-b980-08df14a97eab
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:50:31.8903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zH374KoGY1ZTAbpUnwGg2e/0r1vzclnjYFV8tY1yc0Wpm3txG51bjoBoAyOFkcu6xWv+BBJP7+m03ho0QDGobXXq6m3Kch0wGaXB6I1b4Es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6864

On 17/09/2026 11:14 am, David Laight wrote:
> On Wed, 16 Sep 2026 22:59:39 +0000
> "Chang S. Bae" <chang.seok.bae@intel.com> wrote:
>
>> Microcode updates can usually jump revisions. However, there is an
>> erratum on Granite Rapids systems. If they "jump over" revision
>> 0x1000405, they result in #MC. Avoid it.
> A probably silly question.
> Is it valid to downgrade microcode?

Yes, and it does happen in practice.

Intel microcode contains a field called the Security Version Number. 
The SVN bumps as infrequently as possible, but does bump when necessary.

There is a hard block on the SVN going backwards, but as long as you're
not violating this constraint, you can upgrade or downgrade microcode as
desired.

~Andrew
