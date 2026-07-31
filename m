Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7343B3C06;
	Fri, 31 Jul 2026 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519450; cv=fail; b=gZIw+T/wpOBDe19O99+aOsaoSKCNMMwXYSIsqjqShXLY9kHVbg5cHq1lZOyc4QvpsWLP1KXzGR62l5EptxW3m43N0k0HwaEzrFU8Uf/CahYvagwDiRuy7jkGviSDSKGvekQTpfbbzmRojIkW2ELK7AYo08SdDnB8bCGxP675YlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519450; c=relaxed/simple;
	bh=kBYymrSD+bLlpsbUiparUbC9GxTnfAMgDoZluzsxbh0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=boMof0d5kHnYGXWRot59dVGEhzlj5djVaTm8E/aXUSZh7J7R/k59KFWoPMGIMLpWtEq6BG6mTRk9GkAWILkghU9d8W0BS1H7neOpLMmCA4+rycf1OItHM00M0HrAw2whAJnCmy0E/TthLHw4280bt/n2oka4T+sl19dXyOVOfno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YEl4VVZ9; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cFeTwzYL reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YEl4VVZ9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cFeTwzYL"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VGhlk73772224;
	Fri, 31 Jul 2026 17:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZXhcno23itq82a/OISHjeWwBwP91GxGzdq91mB7dC0s=; b=
	YEl4VVZ91uHlYyBo6x5LTXiff3QX8zCCNBhVTGVG1c73DNuZV4dVTyFswS0RGSFX
	78h3buDXXRrgvpdkOyV1TYb+9n8wBzuMSrWG5NYwq51PA2kmVD5UVqpoXzb2py12
	nd4X+eh8ZJg59x/puutMqeg9tQx1DJOKgL0EnT04Qe3/0ruGORTznw1U+Y0D+rL0
	vwCr+4FSqEnHPqVTLKCkmWvc27uAA6SLcSovNdpobth7PM6Rsv2I26uQA6TszdBp
	0cEM6cIXsuAkCkxmSroDzxrjt4UYM95HKSUJHIUFgr6yf7HgITxI9Ewj3se9le1k
	pmAsxFg6gGHyYEImusxcGQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmqyqb91h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 17:36:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66VHZ4tf014160;
	Fri, 31 Jul 2026 17:36:41 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012006.outbound.protection.outlook.com [40.107.200.6])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fqjwwr630-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 Jul 2026 17:36:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1bgxmh6jLaCFYjcP097vDyZkcxbkh0qOxMiIX2WDFyYM8Ul8Z0zRTrp2f/IkvkI85qn5YTgFCAs5Z+SF0FvepB0ptW3XUY4ueS1XwZxpaiXgk+J8X95Um3c4ljnmHJFTwff0UPspP19uecxnTdquJJ5df3S0DU+eCi2Yqd19K6CJLtGcndGoOGErSZ/qLDrj7LLMwI51ffM7KCWziBgR6czhqlRlOz07tXGkjO6/mZu//Sl6UTE99egWXJIW43HVHIyn9MTIlbVbPoNxGY5SRbnQL1rV1NISPpQ6ZIvh85CUTlZfR6JPgSPiDlE7Ker+eaoTZ6OcJiTw9yle7Qvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJcnZXzzNvCoMatCjXaYjnRRcYtS9KeunLE9vaaoPbo=;
 b=eZplxe6hBmlBMGH7hh+s5rlMtKU2mGsYxj+B8rse8bWxqj16JUhcjFjdCGcQnXzHjW3cP4AQpk0bt1YKVGPvwvVKiZwlCW/xhOW4aQi9Ua1ihpjwH251f9pOG4k2w+A7bjXm+1Gnbbm3reaQVTkT544zLpynWOwa9uZe2AZIyxQMU387JaK71hYk9t56s3GhUviXtp8BbvvD8wm60Dl9ybnBFpveJ0Ik43TmBQQDrK7yEg74rg9ooNePVob0W+xzwhNlpxFnZXWd0JH+Op8+0R1H5aTXy9nkc1pgPZO5GcMolJHSoMRUTNKkt0wXnmVd0hQxF8tdhdfiBTKn0lPl+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJcnZXzzNvCoMatCjXaYjnRRcYtS9KeunLE9vaaoPbo=;
 b=cFeTwzYL9ZV9VaKVjSvaYG8QYMCLyIUYV5soY0mzznw1t2lSxNmSWT7i9mDbx7n2Xo8YjZ8HoNW0DPpSaqfhNGlCQa+dlam0367kUvRLeUtJf7VPygVRvyR1qRzDLXdahuhbUkZ1pfBgybigf6o3ZzR1AaCcoU1/hnIqW+NqV60=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 SA1PR10MB5757.namprd10.prod.outlook.com (2603:10b6:806:23e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.15; Fri, 31 Jul 2026 17:36:35 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f%5]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 17:36:35 +0000
Message-ID: <2045eeb6-d135-4531-a746-f2500838ee8e@oracle.com>
Date: Fri, 31 Jul 2026 10:36:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/13] memory-failure: Fix hardware poison check in
 unpoison_memory() again
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Jiaqi Yan <jiaqiyan@google.com>, stable@vger.kernel.org
References: <20260728204409.3396238-1-willy@infradead.org>
 <20260728204409.3396238-2-willy@infradead.org>
 <c5b01c38-9c35-468b-9fce-ff7e1e11b03f@oracle.com>
 <amyldelTLZNeGaNQ@casper.infradead.org>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <amyldelTLZNeGaNQ@casper.infradead.org>
X-ClientProxiedBy: PH1PEPF00013304.namprd07.prod.outlook.com
 (2603:10b6:518:1::16) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|SA1PR10MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 574eecbc-e01a-4893-f91f-08deef2a4450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|4133799003|4143699003|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/gG4BGl3tFlbsHoKQLq+y8l+e3U0JgbK43PvZZSI2hEzxEWVdWZPjKAshDYdWfDBHuqUYe+sw37rCvHJXcbw0fJ4rCW9req4CnDanOGb/yriFsaeyAtbaj43Z+pi1mGhxdwHAqwTc+0ugi2pFfM1iVuGU1//BtJ+neYTWvRtQHgyS3gDnBn68KNf8HVX9DQ6lCb6DGPw//yC08F8ptAyke1qBcupIjbMYxaZSlM/GyC9aGGq+gEhH9XdOFMGWNRa9js81dYYu3mREGn2XphKFKDdoUar1fJoFinclytafhiQ+11Uh4u3gz3Ridd9KCAV2R0q+NWi7AKRQKMbZ1k8/1LY7XMawfvKytBcPQfCnqqylfE71m3MsCQMNcO01pJFmGDYNyOVHuuY4+ezFT/MWDTmstW+vML0pGWQYrSR+tGrBcYgLGhPp9lMvFP7HUej3nrKyoYnxwsIqpN8f4oKGybPQKudJA4O6/CKNnpv/cfMyIdtUD7Op7JIdQCveQm/2LCVhyOtmJTaUKC3opmLVfLLQWttW7m+AQvibJkRGSPEAceYSV7N9Kd6F4Y/jd6zdgkGM9ckUPisDyzuN9fT0Bfukw5ZBcAlM6X+dO2+7w8pme/G3UvadxW/QCU41hbAc1XOzxvOYR156oIROJCUIEveTs8e2uxqJ6KGJVyNlDc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(4133799003)(4143699003)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0dZSWRjZjJTMkFyT2F6OUphc3grMU9wTE40V1BlQ2oxZkJ1bmw1eE5KN0kx?=
 =?utf-8?B?SC9kSkFuT1VIUDJwSEhLV0h0ZjkvalpMNDZ1VzdIWVNhTmdBOFpNZFdrK0NL?=
 =?utf-8?B?UXlrN1EyQ3RiV09OLzQxSDBZSU1BNUVjVm8vMG9kd0l6S3Z1dTFrcm42dFZL?=
 =?utf-8?B?dEtleWtEdVc4RVE1WCtvVDBZRXBGZFpTNjZjcGp3bk8vZjQyeEtvQ0twU0Zx?=
 =?utf-8?B?RUJPaVJhNDE5aUVWTjVNbTkxa1h3dFdiZm9neG56bW4zcHlLQjJMTXUxaTJr?=
 =?utf-8?B?MUVlRnNSZ3I2R1E5VXNvOWFjQ3ErRGlEQThOTkdzci94N0trcThsY3dQYmcy?=
 =?utf-8?B?UEVOWkZ0aXB3bFJuVmJDTmNoVFh1WUovNkp2MGsxeGJCYXNuRlg1a2VKb1gx?=
 =?utf-8?B?MXZtbkdvUFUxUm5wdE1aenhGa1ZLOVRKUWZkTjhObWE4TU4yTTBnckgrZ1I2?=
 =?utf-8?B?c0c5UHMzTzlDaFlqYVJENEJySm5RMzczbGZmR1ZQTWJyaFhUNGE1UFBLUHVs?=
 =?utf-8?B?NmtNcVJSdmdhTXY3dXBTRWRmODVlaE16UHcwRXc2a3VobWxOVE9NRnRJVVRN?=
 =?utf-8?B?aENabnhlbkUyNDBQMFhRektrN20yYUhld25YeG5RcGF0Zmo3YXZ2R1YzYVhY?=
 =?utf-8?B?Ym5CQlZLV2xoSHNScHRJU2VsSnBreWJkcFhCYmhTQWx5UlptejNKL1lpK1dY?=
 =?utf-8?B?VUJDcTQ5NWVMTTRXaUEwMHVJVHFFaUNIckZtaGNBVjlCMENsV0w4QzlCb3FH?=
 =?utf-8?B?bHFjVXplSkJ2ckg2UlVlMFFYMnF4dDlaVGhpWGpadjh6YjBJK2REd25rVHAw?=
 =?utf-8?B?TGdHeEx0QzFoZUwrZzVxSXRxL3BTcmdNQlQ2TGNxcXVhWTFWV0U0anFlMHl0?=
 =?utf-8?B?YjV3Z3ZpLzF2S1U5dXJYWlc0cHlJOGVWcUR2REVBaEptc1ZLL2FDazJJelhQ?=
 =?utf-8?B?NTU1WEN3NE85VXhzZ1N2N2hNZ1NPRS9mQjZxTXRjZnJnSUJFN1RjQXYxbjA5?=
 =?utf-8?B?R1NFYUNmR1hSMEI1QStzeFVIeDVTRGlpbDQrY0lOdmw0blFGUkt4ZFh6NW5Y?=
 =?utf-8?B?MjkyTG5NTnlWVVJDMFZBS2JhZnhvL1M0M1UwdHYvbWp2STZ1WFNwVTFhM3Nx?=
 =?utf-8?B?VTRsZ09lREZTbUZpMmppTFlmMm5hTHl4aGZtdG9xK0c1aHByVVBXZGxOOEp6?=
 =?utf-8?B?aXA2NzJKMVVkb1Q3T1hKcHZuZ2ZYQU8vMU5mUm9iaWxwbzNqdGNFK0pvTk9q?=
 =?utf-8?B?Zkx1S0w4TDJydU1MUTVCT1BjZGkvSUZocm9GSm9RajlHNmxZRUd5VVc1WkJO?=
 =?utf-8?B?Qm1oZFB6Rm4zbVh6d3VBZlVSWm1DQWdPK2pZbjFmcjhXM0ZEbkpkbUpsYlVP?=
 =?utf-8?B?NllOK0dDMUpXSk9GRTU5d1N2Rit1MGVnU2dMcTBiTkpWQ0Y1MjZ4cXhEM0tv?=
 =?utf-8?B?RWFHSk5NcCtmcXpMU1lpTndEUFRJWVdydm5FTUZPcmFVVEVJaTg1a0p1NUY1?=
 =?utf-8?B?UklxSDZ5YmNvT2RLMlpoYW54T2UxMTB2MlVFV0dncTZha2FuWnJJME5ubUFZ?=
 =?utf-8?B?K0lxczNnbGQwUDR5cHdjQU5VMjFlUEZIdCs1UC95Q3oyUTNJWDQyeTZqNVhP?=
 =?utf-8?B?dTljT0dNa2tnVWFzbHE4bkZoTDl1ckZPcUR0U2hWdGVCYmdIWm9sL3FzK0xn?=
 =?utf-8?B?UjYxYTRRTGtGUkdFTVdZM2lqNllZOXMzZFhTUmduZGoxWDhMWVM5czk2ZkxC?=
 =?utf-8?B?VFJxc2V5eVVDSHNwL0JVTldOdkJ1dUI5RGJxOGlFWDI0SCtBenM0T1I3YTFG?=
 =?utf-8?B?Wm10aDlpVHA1MWRlL3NpM2dWZ3JmN3BWNGdCYzZiVkpyT2dzQlJxbUtYc09B?=
 =?utf-8?B?Vll2eGVjUENibjI3L3BPWDRCOGFnaHhLU0hLOGlDVExzekpBcHhxRUJJNzZT?=
 =?utf-8?B?eG9uOHhiNWZHV2laTmZlOXIybnVKZ0VSYmR1NHhVcm5zVDUxQVUrM2pwNXcx?=
 =?utf-8?B?ZmJLelU3ZEVITEpZQlhzTG9FVEZ5VHNWQi9TQjNTTmlaUThhMU5GemxBZGth?=
 =?utf-8?B?N1hJRUk2bVhsTWM2R2txdDI2ZEJjSGF4VEJ0M1pEaEd5cnEwZDlyUEQwdUJC?=
 =?utf-8?B?Zk8rT0NsOVo4SmlUSzNoejd1dVE3dFBKQkNveW00REdNS3BNamlQZG9NNm5y?=
 =?utf-8?B?QzRrcmV4RHMzcGk2Mld3YUNRQ3JDQWhyckFWcE0rTE82Um51ZURuZ1dHYWFS?=
 =?utf-8?B?L01rUUY2TWRzOTNsUEVpMXZKdjhWblZQR1VnQnZZSjVrZThFYmVlNkljbWta?=
 =?utf-8?B?dGhWckZDTHlrZWJma0dMVmdQWjQ4cjZWMmhKbWhYcnhJM1k1aXJJdz09?=
X-Exchange-RoutingPolicyChecked:
	piux7rA++WpWsIn9pgWsQLAx5MpyZfo8AtEG9/IcW1RV7C0olyPQkVw/OcKkXclKNxyB/ZHn0s0Lj50UNMfINMJHO05LuUy/L6Hu+jQKfIhf3EXHxlWXXG0Z4z/vLuv47k96CdI4/wZnoO/xx2jpu21LP2vIhXr/78q5UOE5wFBG9ONHhl/voneiFaZIyX+Rg6pGb1M7OwXSAmnjFkzWGch1tBGvqiEnh485b0tkMYfw/QuOucDjjI9yhIjEk9GJtjEywyrenD8CS6ANY7VHzSJyN+aeIkletAF1Lvdba5YYSxItVYfekkhPXxPdkCrGVQXCBRQ3FoylgJdQWAcN5Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nRWltzD6xi+nR5fuEBy3Szc1Q6aX2yWe4xQwYB24oGuRcxfNQoacFFJ1m0U06GGvuIQ4dTO35Mtz1NSpBFSy6MqVi8qjo7DYJpQ0A21VWeA3VoEv1X2lasJsJ/i9Rr1yXNiAP1gpoR0Ng/4v9Fh5NWWWzvLjn5jugxrBgEXKbrI/BU8RePzXyGGQVrmkczLToqTybj+fOuUvziilAy+BxSDOKW/RHg4GSXpsmfPjfyhq6Z2uRATV7fevBqWYtqSIXWsN7dPFtWEN5l+50zy5QcB4REJ/ss9uOzrdCzYsCvupn1xIr8uRoL6ktl3HwGjmoS6+e0fc7OGZeXnXzjZoqIWJSpoxVi4il+wbRbvnfrcg8+wwCJJc/WJjX1xyR/cBgb9CQwnNIykqwnoA2gyUpaHzteEyq8ALyEIQjBPi4gJIo1OH82riSwMokW3i8I2iyz2jK52lNofBlkbTsyLHU5pdFmdq7QUx03ScMnABA2VXWoKFg0wPmAA6oN0cY+b+bSKQr+eJN+Ln7DFSKtY9FCpC4/8sR31z4Hb935O7weY4qErU/xFIvepY7OipErEUjacqxdME/m1q5EoU0OTq0o462L/C/uv/QL3MT1vYBtU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574eecbc-e01a-4893-f91f-08deef2a4450
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 17:36:34.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5B3U/r9D61M1zDlo7QC+Hsn7wqZb9kjS01Qwh5Cqa/dxi3zX8fShDdxmx7mVsQ7dHoL2P72Y2uGsIi4vDtQYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607310135
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzNCBTYWx0ZWRfX94AU3TqCjtsL
 wOxAvuSvWcDEe8GJFxkXtZCUvmva01CremSxiH6+cAXUpiuzO7icEVbZWzaLn70vpWLXH6tHEFz
 Z+JJDAeX8T509rCzGGIzrkmo3gCTVRXFOWpFyDX2q3AjpyQrlemFH2N+UEE4XNlbBFB6tyIoG0k
 ueRV0syUfmDfWGaiMZwJbWAQWeUbn+aIaXRvi/uymkgr/qR4ZQfBj+GvjYZz1ad+LFa+E9mCD9/
 yy+7KFp1g5q0TkaFhTMrW3lebqpdVuo+d4CBFDDUGHzxmdrG5KpvgnJr55elswkMs/oDCYINfc5
 SS8tASMGQyjkensmRAp5Lrj2vfdBm3BBCyC7BcUL6dM4ASwk2NG+05Is3UMa8ACJa/yK4yfUy6h
 L0zPf9aONRdE/EWfoibfUjQFdxWe1+dd+rEUQkKldaG57tgr8uBy2skE7WIOAGKAX65jUv5xjJ1
 lDPZuoGKa/uHJ1MpVrQ==
X-Proofpoint-GUID: 0OWlKbzqRTDIKgxgBw0_dbcwCuek2l9b
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzNCBTYWx0ZWRfXw/PKZuW+AWd8
 TFL/Wq9yyCjBJDPe6gBwcDUiiv7LISuaTsFFZsnsiZPTsJtKd41LPEWGIOQzkLsQ9myHKJb01i8
 PWFxOWzE3jerMBzyAkcRBbpecFzsl7ruGbr7/3hTDDaGgG1kcyJe
X-Authority-Analysis: v=2.4 cv=X/1i7mTe c=1 sm=1 tr=0 ts=6a6cdd2b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=RpNjiQI2AAAA:8
 a=yPCof4ZbAAAA:8 a=IbWKqwsIx1YDLRePfYsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-ORIG-GUID: 0OWlKbzqRTDIKgxgBw0_dbcwCuek2l9b


On 7/31/2026 6:39 AM, Matthew Wilcox wrote:
> On Thu, Jul 30, 2026 at 10:=E2=80=8A39:=E2=80=8A57PM -0700, jane.=E2=80=
=8Achu@=E2=80=8Aoracle.=E2=80=8Acom=20
> wrote: > I think I spot another pre-existing issue in unpoison_memory():=
=20
>  > the XXX line doesn't work for non-hugetlb free large folio because=20
> it'll > just try to clear PG_hwpoison
>=20
>=20
> On Thu, Jul 30, 2026 at 10:39:57PM -0700, jane.chu@oracle.com wrote:
>> I think I spot another pre-existing issue in unpoison_memory():
>> the XXX line doesn't work for non-hugetlb free large folio because it'll
>> just try to clear PG_hwpoison in the folio->page, not the precise 'pfn'
>> page.  Something like below could do.
>>=20
>>=20
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 51508a55c405..14915718ace5 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2730,8 +2730,10 @@ int unpoison_memory(unsigned long pfn)
>>                         count =3D folio_free_raw_hwp(folio, false);
>>                         if (count =3D=3D 0)
>>                                 goto unlock_mutex;
>> +                       else
>> +                               ret =3D folio_test_clear_hwpoison(folio)=
 ? 0 :
>> -EBUSY;
>>                 }
>> -               ret =3D folio_test_clear_hwpoison(folio) ? 0 : -EBUSY; <=
---
>> XXX
>> +               ret =3D TestClearPageHWPoison(p) ? 0 : -EBUSY;
>>         } else if (ghp < 0) {
>>                 if (ghp =3D=3D -EHWPOISON) {
>>                         ret =3D put_page_back_buddy(p) ? 0 : -EBUSY;
>=20
> I think you're right, but this isn't a bug.  That is, we're calling the
> wrong function, but in this particular branch, we're guaranteed that
> 'folio' and 'p' have the same value so the same bit is cleared.
>=20
> This is the case where !ghp is true.  Here's the code we're looking at:
>=20
>          ghp =3D get_hwpoison_page(p, MF_UNPOISON);
>          if (!ghp) {
>                  if (folio_test_hugetlb(folio)) {
>                          huge =3D true;
>                          count =3D folio_free_raw_hwp(folio, false);
>                          if (count =3D=3D 0)
>                                  goto unlock_mutex;
>                  }
>                  ret =3D folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;
>=20
> It is my understanding that we take this path for hugetlb memory and
> pages which are in the buddy allocator.  Buddy pages aren't compound
> pages, so calling page_folio() on them returns the same pointer, just
> cast to a folio.

Agreed. I think the header of get_hwpoison_page() can take a bit revise -
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1484,7 +1484,7 @@ static int __get_unpoison_page(struct page *page)
   * the given page has PG_hwpoison. So it's never reused for other page
   * allocations, and __get_unpoison_page() never races with them.
   *
- * Return: 0 on failure or free buddy (hugetlb) page,
+ * Return: 0 on free buddy or hugetlb page,
   *         1 on success for in-use pages in a well-defined state,
   *         -EIO for pages on which we can not handle memory errors,
   *         -EBUSY when get_hwpoison_page() has raced with page lifecycle


>=20
> Now, I do fix this in "hugetlb: Use the has_hwpoisoned flag" (because
> nobody gets to use folio_test_clear_hwpoison() any more):
>=20
> @@ -2733,8 +2756,10 @@ int unpoison_memory(unsigned long pfn)
>                                  hugetlb_unlock_irq();
>                                  goto unlock_mutex;
>                          }
> +                       ret =3D hugetlb_clear_poison(folio);
> +               } else {
> +                       ret =3D TestClearPageHWPoison(p) ? 0 : -EBUSY;
>                  }
> -               ret =3D folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;
>                  hugetlb_unlock_irq();
>          } else if (ghp < 0) {
>                  if (ghp =3D=3D -EHWPOISON) {
>=20
> so I agree with you this should be fixed.  But I don't think it fixes
> an actual bug.  If it did, then we should do that first for easier
> backporting.  So if I've got anything wrong here, it's worth saying.
>=20

Yes, with your [PATCH v7 06/13], the patch looks fine.

Reviewed-by: Jane Chu <jane.chu@oracle.com>

thanks,
-jane
