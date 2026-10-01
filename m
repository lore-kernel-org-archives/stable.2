Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184751F8691;
	Thu,  1 Oct 2026 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866410; cv=fail; b=l12dTB68C514Hf0CeAPRM2RBGHBxdG8B2+mQgE6HtMXhrT5iDojRATLEFVs3wfQpiOAzS+RuHSjQ0HNjjBPb4sMI8509CO/x6sty/1ypkjAGKI7XviEaj8tLDMHrKW7xu7Ba6hp88DdqUPZro5t0Zdf4szClBdxFll5hFrJu38I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866410; c=relaxed/simple;
	bh=TYcSN5L2I0z031dsPJqYpx09TbeZsdA+QNfihtqDybs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fC9YkCkq6T+u9yjNCdOmR8pDg0gD9mbyMQFemyG8fHZPgqTltheT63OQz6TlgjUCMscuruagiXdJ7uEWGL2Y0QIBbMGfcFqyUyLXuauBqKNkgmYS+xFmWaQrjPM+26fWGZverHtISXlxuiSZLw79E+LhmK5/+ROeolHo6d5sI/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mVa7ukww; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ww6Tzfjh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mVa7ukww";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ww6Tzfjh"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMk713077965;
	Thu, 1 Oct 2026 14:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FjzJyrAc+L2v3cekUBG7b/K0eoBAA8gnGDNXdZ3VSY8=; b=
	mVa7ukwwt8yDZLWHKUQIZ0x25hILOIOeqNERUg+SvtZp+LTScLIBP6wJSHo4xIjR
	lfZWhkADjWMeCVfrKEtIJgdv/9utZK9OFwaFxql1Gm5qoqNUOLRmIgwWYXSkU49z
	uZC9UkPlOtTbpGYNW6WAU8en1QX+X2jPtXBvRcMRXUVC/8kiZH3fzwmMMHujCN0V
	9rTiNJuKcypp4PgO2fdUYPFUj3AWXcYUf6dcDcE6A0xz/9t/FyZUhDBSQLozdcJ/
	zFbUbdnWA8Goi0UE946elkj2pj1WlV0FNbe7LHmpLZMtd53jPbMIGZ6/3G37KHJ/
	6wnAzG9YVzgcZ6ewxPG0+w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4myh7v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:53:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EnriP017380;
	Thu, 1 Oct 2026 14:53:22 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gey1cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:53:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLGouflUTK+XZYfvnVB8FNh8AHpLzha9ITRonUDCuX8t5vIiKcQwwt4XPDtKTuQFG3i/j4vSQkXi+RcVJV8am6DYP1vs1GNtJ7qIzx2Rqy80DIx+BCF0V8pBxxNwUgdE/gugg/VVAzWV7CzkMJ8A446B+QLjlGdZgQ/yT4J2ou9vJT8c689ErO2S7HoUn6GI7RZauBaS5y9o1bOBLNBHGQUpE5Tb0CKdLOuRM+P1qDKU1pmtM35SmJHtwTwmeiE3wVySmqsgXiUNI3smCH+e/FG5IizXzbOHxCkDiCPsuFKZf8xOfNa1GXWIbq+zXOMKycCZftOaC5tnH05GmIZjMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjzJyrAc+L2v3cekUBG7b/K0eoBAA8gnGDNXdZ3VSY8=;
 b=KdiHrY6CmIiLMsOXfMokwHi5jnPs4Ww4BNEYllb/IRRyVeMex58PBwLxwmc2PHo3oEK2Y8rp7s66I6GFZWM8gOZcLerYE7OoFH6K+bylIHXOtzfuesR9mNwa9T0WbA8wu9kmmY/X6oWV89nCm9SOAe38bCojSQTOzRNe0mreg0bMXQfhKZsu7XddYIFMOg4m9HQyn5//Jzbz7dJDsmnFnTcMALrsualIYm48cwcZ/USSR/x9SN5B/jYSIC9HAvA5WYG5zl1HqMLsW1n0eaoLuktqHje9XJr9yPQWp+JjyVXMLv0dB0B2xAvVLVJ+bNIkl4sLksX+jJHefHfN7txYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjzJyrAc+L2v3cekUBG7b/K0eoBAA8gnGDNXdZ3VSY8=;
 b=Ww6TzfjhGEZfShvbpS4KFJk3LoLQSQvC91qwHPiVuupoIXBXFv+wzxPR3o/z264M3U2nFTMuc8K2iTK6PsnM90jHReDfYpc6cOhBPRM+iywOtcy/j99Hp7qzzYPSPBvv1Q05ztgnE9h0tgQG/Qn0z5inv4uCvXGjTVcGlDJgERs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH7PR10MB6556.namprd10.prod.outlook.com (2603:10b6:510:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Thu, 1 Oct
 2026 14:53:19 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:53:19 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 15/21] xfs: buffer pins need to hold a buffer reference
Date: Thu,  1 Oct 2026 20:21:28 +0530
Message-ID: <53dc9536dbc4ce3be8243da8cce9e1a58a3c2183.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::8) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|PH7PR10MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cfc6dc7-5f20-404b-c0ce-08df1fcbbb26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|18002099003|22082099003|10067099003|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	2TRB5WocZwVN/zT/i3H7b++SxK6ZyZ7Ob/G7FPgjIbXLMQGIg2iaMkKSQVg81YIgvxwnWbTFehIgQP9Szr9qUK1y1K+k7h3RcVKFrqW64tCfP3QUxcvZ7sLPwNTQhxaxrisNr6GATIfKXHF49piwwz1Abp/vjTpJyNuP3EUmvmLo/tcLyyOIAjVJpFzxba1XUOTfuswoKLkj1kxtKjcs4nJp9/U5JHbSzMiPjEh3NwIrsUKoX7Rt4jTCZrMy1XkyYWOpV4YXMnXuUTDQ8/NzKAiVqY7IJwUAZGpwCa87omE4dIz2RgK4Ypemv3ciPyzFKaqpgnUC4FvqY4+ADIIMSXVfec+elPZyWGjWKVVKntBuOLAYHD5e9vBZjFIqDLaZck62GnrkZeXtoefQcI1k1Bl+8eOwfr2JLuFvg86s4qf1s5izNDTq80pGoyZ+jCs/cu0wqQkzCcipQMdmrhh2SHfrky+nAQ1lMOOVjXJIvmi07esjB1T4j3D0838o/JGBTXF854ro4LZott3SwNHvsjC0f1+GknahYoSd0hnz2VJjpJdUVMCjWwlzVDo/qj905hjjVYEcZyLNaLd6JfHod+7gJnthR+dMFh3BScVWKmGNoWOZ25FTNco9xYEBkKCTIQBsHV03xVvSCuMpVy2mO8LZ/L8/b6cYE5a4vGe+YRg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(18002099003)(22082099003)(10067099003)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p893R0eji4Nmm/mTQENqVN05Pdh7RmgTDzs026GLLXc2mvuaIQ4DjJz9h5Uy?=
 =?us-ascii?Q?1uTxrrhKb36o6vr5wvhjiA71HKhvPJq1hNNh/s20HzS16i9OlTPq/1KsjBKG?=
 =?us-ascii?Q?YHOzZSbwEuzPjzGUnUxq8hc7uyyoH7nrkfZIpfVWVXjp7Ka4Q7F1pRKyrM6n?=
 =?us-ascii?Q?mbpCgxiDsaM+J3Qxur3XsHr+EzltrEkvnsfZNhjQZZfdR1WUbDmp7nUnfTli?=
 =?us-ascii?Q?eXKXg4SJRzGdrPxMstLhbYlcs59wvgGZXDog3UwTJwtjme0vznIhdb9pLozn?=
 =?us-ascii?Q?d/2Qi3cyfuWO0Sjd1XdXK8iPGRr6lJ2yf7TlWKBSYzpittMDdDpI22qB5leq?=
 =?us-ascii?Q?BkzMSV20KEslbs/J99uAoU6V5NPaJUAyiZBR97AXSvG1xBnqkezbSwUO8SY5?=
 =?us-ascii?Q?37lRUMvyBc07JP+Fkk9x/mMQgrNNWv9sOeHA+pWEsoJOXtKIWNSZEaOP9iZ/?=
 =?us-ascii?Q?bArDWx+tJL21U9TT82vzMfYV00wfaRdhjcWWDfuPdfwM06t9nbquBtiwLBYd?=
 =?us-ascii?Q?Tnkzl/YKAXwONhZMiZKZ/K8cSyUzOBXWTz0sh8p0W09WoDyQkanr9EQ0Q5Fi?=
 =?us-ascii?Q?X7B/dv6hkF0v0vOjfP5UVK1emTWv78ZsxwaXZDwHAJhVYun/45X/doHaNZWO?=
 =?us-ascii?Q?grhAtX1amWbO4RNJJbTcETsun0omiR3qEXxMSVBmSMMfb+5i8RhR88jaNOxm?=
 =?us-ascii?Q?ba5HzuFsernSeG+qyirCxafRBppg7bpo+yMrl0quhlkIt3GO7PPfbD2t7cpc?=
 =?us-ascii?Q?hoTZEYiXaDrXByqfrCE3KE/RloWgbs5UcWe89mkj4116EmvwYMBVM+byzo2l?=
 =?us-ascii?Q?rU6GCRxBpz57wSfCSFFhEvj/ihNCIQj84Qfg8is8rKZ8GQ8b6DjK0QuP6Ry1?=
 =?us-ascii?Q?oGCwixnYelSjGFErisrg9zZgm5euB+URI6fS9CqVI9zYZClUBda0zWhgeUKb?=
 =?us-ascii?Q?GIZPykz06KEuNqGR/UTqjZ55K9BzTYHb4FF50r12qyjjbUszwMpjPIllZ+9L?=
 =?us-ascii?Q?mIViOHpqJzY0XrkHrg93uG0L+ZkqgFMuUlOiluU1RVJGFne6HQGdVuCqLWMj?=
 =?us-ascii?Q?hPr8pnje2CPn/MJYEm1iS0Q07YLI57tR1VWyxzgkDWeCwG+iXjHKp8ylEwIh?=
 =?us-ascii?Q?VZi813DI/w1x55Y9dtpug4md23NCKEdVwWyq1ioFOXy09oCqZS6Mrl6E3MoR?=
 =?us-ascii?Q?8DoadI28iwBxoo/Y2p2GfnbxpvTeRnXf4uQx8+Xt0Aucg3blzwmozZ/hf4wD?=
 =?us-ascii?Q?C+VVKnXZo9CWpOds64lvQ6C1IsPLmWVhZfAhzv9xqJfggnq0hJDLIFGClIgq?=
 =?us-ascii?Q?Z0y1zlpK/uqprvrich5jEyttfeQjDjNAzfDJnx3LFsXBFFmK5zvrD46531P8?=
 =?us-ascii?Q?ud6jz9Ml13A+3M2gqDI1DT5Yy/8f0wgvLiFvRrmimbSdxfyg8k60RmxP12A8?=
 =?us-ascii?Q?3XwPBfkEoDWxo6aTcikUp4VTzw7iLQhQcO58xBgVYvIWIisKV7oSe0e6MLFc?=
 =?us-ascii?Q?uD5iyVpzBlKAZuIK7Hyb17PVXz3tBQXMaiORFXwHOqDhydkX3YeD2YEf6Q6F?=
 =?us-ascii?Q?+7S1NCkAghTJYoo+m9PlxhFS8+DRew3lyd66K/S2gmHD3KLy5PgoHa6s36O1?=
 =?us-ascii?Q?/MQ2k60CUhX3TQmIec2fcUq1H5rEqm+yxwn8bVuEUnK1wwqGw3RE8pcomGe7?=
 =?us-ascii?Q?HAtqWaI7/8XeRvrdW6FtJNSTzFSkiBirxrPTX8LVN1aIHotODgmwyhmW4DqU?=
 =?us-ascii?Q?/R0d7TB/lBzCKYtcVJSOuaEL64THqyq1lMGTQQKpr7yhB2jB1IbzWMp+jHR0?=
X-MS-Exchange-AntiSpam-MessageData-1: uFGsGmYY4U9kc6zDb28PR/4eSOoJZOh/Eww=
X-Exchange-RoutingPolicyChecked:
	NL5WwvRg87jsmSIAqOg9ZV2dIo0Ri6Brov6EtWUYnH4BRrDJtV3GqNS+GjpyhK10VMbtI3i4cNxZDRQdVOZhyEgGRch0njvblf+i7h/vbXzWg69p/WUIFdSGuIx7Smn/1xVV/40DXkxf2+aNQ8WNkdZFkTYfs8baGPAGzKsLAGA89o8bhM2y01BKwmyvRaSs5/1eew4iyXebP4UpjH1WvTd4tykDS3uSZo8gWMViJpRRB0jxI2qRMGI7lE9pZ5bSxPdJnlteR4W5UdSuuDspXF9dEjk84pqTM8jRGYQIxfPUIilfCSmmR2CyEanoUybrQ9EBbzJiyOO5hk/VOT9ltg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oiZQ3GHkOOW+oJ3Gy7jtwTI2tgX8j/BcvBklGg1Gg6WYBl2XhmB9ysyin8XWPXc/KbemXwYHTkIXNIENlfPomyuVuD922H/s5Ig0I8CMYybCfgqrqZVKNLbprOeg+pHqdTAV3umrJTGtSQQwVsYJfA7hjsINp0+pNHV3toXk+3kYeq5Qmp3/6usp/89zv7xgZscet67LXRMynrV9hvlIvQyPXGpNHAIJX+aQSEnbQTzrmNNiq3bsvz5sMLGtYn8X3phvOpoIb7AW6RYP8n0fUetgVryK3d59y9NicEAWFQ7AIwgdoVQMlpdnm+otSkty/uAKBBRgHTr68QyHQUyHA+T5g/f68Dvw1xATOn/8ZX6Id3ICYcCgsPJDo0UkCbmJO0DvwN4XvyKKY/+8hWJ9Mj9uYMTpNN/id+FCWTYU1suIs4JgkZTcezgdatg5qqxob2eaA46ABK9B9uweNzrdTJlPwKcR05jjEHjssh3r31Y/Ug0FUuW8+EWf223qQ0JpsuXBPfygdqAMHpnFr0KmCT9h2n2HoKPNbLkPKcEkAHq06P+SI6MT8/pwqDs1ByDMDMLv4swDkdc4ZKkLHEAZBFjMcczqlR4Jya5alZ6V/4U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfc6dc7-5f20-404b-c0ce-08df1fcbbb26
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:53:19.0666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aw9A4V8FqK2UHBitFQhbr/nolHD/CQMzEuwQbshPIQLiGpk0Tkxd7rPsGuK+WR/M1JqTP8hCEN50DVUmr156AB1hV/expCTdEs5lOO8R5Lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX1kv9hZRzgaAs
 OPVdp4NMapkzvNfCPxaHpO5yFiClC49d6Z+kJLWSnTM5nCd/NenIdzd0eYvHfNCDsJEYZ09fpgv
 lRamX51lkkX+jRpCTl6km3pK4E66zd2nizKHSKlxAvU6CfHL2+2C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX+asvOg9wRf6w
 CTWG/gTNOsDXDY2mBuDOTsEnmWO5+2Wntx4+AruzXPUgQbRdYmtZqDVbah0PcgeqP1yF+qenlez
 Ua4lHzhvFDprA3KPnHvuUYayvGbICrr06ezucgCzg7rRra937CdkAANpHxTjkzoWXr7wy2xE9Rw
 3VVHgi0acIH1nIi3SSrPTgd2ixAgYkL9Zulp8uNC5PAIlnxBXjRuoHRRn4M4NbJpcLho/Y1I+zm
 oVuttpZhz86x1wlUxBkNqR2vZilqX6EPW9IwiE5HLu5PlKJUbth3cjSICG94TDauBuTOk6lslOc
 wVdJbHZDWpAsVb/1d5H4vN50sQEo3mEhdfFwY13h21C2IfBVjfuJo9s5bQFrqVurq+yP84cr3Wn
 NPHNQwbtHVdwR+eb0pAztsUjrphuWLAcYLgRng9EXBJfE5PO1jexg4mI+CYETJHsqcUQc9oSoZV
 lkA87SShZuBHn1FN6DQ==
X-Proofpoint-GUID: QYKbWcg_7pQ1V7B27DP1G2-3RSZaX2dr
X-Authority-Analysis: v=2.4 cv=DZmCOftW c=1 sm=1 tr=0 ts=6abe73e3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=20KFwNOVAAAA:8 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8
 a=7-415B0cAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8
 a=t0Y7tUnTQisWX057riYA:9 a=biEYGPWJfzWAr4FL6Ov7:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: QYKbWcg_7pQ1V7B27DP1G2-3RSZaX2dr

From: Dave Chinner <dchinner@redhat.com>

[ Upstream commit 89a4bf0dc3857569a77061d3d5ea2ac85f7e13c6 ]

When a buffer is unpinned by xfs_buf_item_unpin(), we need to access
the buffer after we've dropped the buffer log item reference count.
This opens a window where we can have two racing unpins for the
buffer item (e.g. shutdown checkpoint context callback processing
racing with journal IO iclog completion processing) and both attempt
to access the buffer after dropping the BLI reference count.  If we
are unlucky, the "BLI freed" context wins the race and frees the
buffer before the "BLI still active" case checks the buffer pin
count.

This results in a use after free that can only be triggered
in active filesystem shutdown situations.

To fix this, we need to ensure that buffer existence extends beyond
the BLI reference count checks and until the unpin processing is
complete. This implies that a buffer pin operation must also take a
buffer reference to ensure that the buffer cannot be freed until the
buffer unpin processing is complete.

Reported-by: yangerkun <yangerkun@huawei.com>
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 81274891036602355e72eabbb5184490f354b506)
Stable-dep-of: 816c330b605c ("xfs: factor out stale buffer item completion")
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_buf_item.c | 88 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 23 deletions(-)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 73c548d5b593..f864e0b8a805 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -371,10 +371,18 @@ xfs_buf_item_format(
  * This is called to pin the buffer associated with the buf log item in memory
  * so it cannot be written out.
  *
- * We also always take a reference to the buffer log item here so that the bli
- * is held while the item is pinned in memory. This means that we can
- * unconditionally drop the reference count a transaction holds when the
- * transaction is completed.
+ * We take a reference to the buffer log item here so that the BLI life cycle
+ * extends at least until the buffer is unpinned via xfs_buf_item_unpin() and
+ * inserted into the AIL.
+ *
+ * We also need to take a reference to the buffer itself as the BLI unpin
+ * processing requires accessing the buffer after the BLI has dropped the final
+ * BLI reference. See xfs_buf_item_unpin() for an explanation.
+ * If unpins race to drop the final BLI reference and only the
+ * BLI owns a reference to the buffer, then the loser of the race can have the
+ * buffer fgreed from under it (e.g. on shutdown). Taking a buffer reference per
+ * pin count ensures the life cycle of the buffer extends for as
+ * long as we hold the buffer pin reference in xfs_buf_item_unpin().
  */
 STATIC void
 xfs_buf_item_pin(
@@ -389,13 +397,30 @@ xfs_buf_item_pin(
 
 	trace_xfs_buf_item_pin(bip);
 
+	xfs_buf_hold(bip->bli_buf);
 	atomic_inc(&bip->bli_refcount);
 	atomic_inc(&bip->bli_buf->b_pin_count);
 }
 
 /*
- * This is called to unpin the buffer associated with the buf log item which
- * was previously pinned with a call to xfs_buf_item_pin().
+ * This is called to unpin the buffer associated with the buf log item which was
+ * previously pinned with a call to xfs_buf_item_pin().  We enter this function
+ * with a buffer pin count, a buffer reference and a BLI reference.
+ *
+ * We must drop the BLI reference before we unpin the buffer because the AIL
+ * doesn't acquire a BLI reference whenever it accesses it. Therefore if the
+ * refcount drops to zero, the bli could still be AIL resident and the buffer
+ * submitted for I/O at any point before we return. This can result in IO
+ * completion freeing the buffer while we are still trying to access it here.
+ * This race condition can also occur in shutdown situations where we abort and
+ * unpin buffers from contexts other that journal IO completion.
+ *
+ * Hence we have to hold a buffer reference per pin count to ensure that the
+ * buffer cannot be freed until we have finished processing the unpin operation.
+ * The reference is taken in xfs_buf_item_pin(), and we must hold it until we
+ * are done processing the buffer state. In the case of an abort (remove =
+ * true) then we re-use the current pin reference as the IO reference we hand
+ * off to IO failure handling.
  */
 STATIC void
 xfs_buf_item_unpin(
@@ -412,24 +437,18 @@ xfs_buf_item_unpin(
 
 	trace_xfs_buf_item_unpin(bip);
 
-	/*
-	 * Drop the bli ref associated with the pin and grab the hold required
-	 * for the I/O simulation failure in the abort case. We have to do this
-	 * before the pin count drops because the AIL doesn't acquire a bli
-	 * reference. Therefore if the refcount drops to zero, the bli could
-	 * still be AIL resident and the buffer submitted for I/O (and freed on
-	 * completion) at any point before we return. This can be removed once
-	 * the AIL properly holds a reference on the bli.
-	 */
 	freed = atomic_dec_and_test(&bip->bli_refcount);
-	if (freed && !stale && remove)
-		xfs_buf_hold(bp);
 	if (atomic_dec_and_test(&bp->b_pin_count))
 		wake_up_all(&bp->b_waiters);
 
-	 /* nothing to do but drop the pin count if the bli is active */
-	if (!freed)
+	/*
+	 * Nothing to do but drop the buffer pin reference if the BLI is
+	 * still active.
+	 */
+	if (!freed) {
+		xfs_buf_rele(bp);
 		return;
+	}
 
 	if (stale) {
 		ASSERT(bip->bli_flags & XFS_BLI_STALE);
@@ -441,6 +460,15 @@ xfs_buf_item_unpin(
 
 		trace_xfs_buf_item_unpin_stale(bip);
 
+		/*
+		 * The buffer has been locked and referenced since it was marked
+		 * stale so we own both lock and reference exclusively here. We
+		 * do not need the pin reference any more, so drop it now so
+		 * that we only have one reference to drop once item completion
+		 * processing is complete.
+		 */
+		xfs_buf_rele(bp);
+
 		/*
 		 * If we get called here because of an IO error, we may or may
 		 * not have the item on the AIL. xfs_trans_ail_delete() will
@@ -457,16 +485,30 @@ xfs_buf_item_unpin(
 			ASSERT(bp->b_log_item == NULL);
 		}
 		xfs_buf_relse(bp);
-	} else if (remove) {
+		return;
+	}
+
+	if (remove) {
 		/*
-		 * The buffer must be locked and held by the caller to simulate
-		 * an async I/O failure. We acquired the hold for this case
-		 * before the buffer was unpinned.
+		 * We need to simulate an async IO failures here to ensure that
+		 * the correct error completion is run on this buffer. This
+		 * requires a reference to the buffer and for the buffer to be
+		 * locked. We can safely pass ownership of the pin reference to
+		 * the IO to ensure that nothing can free the buffer while we
+		 * wait for the lock and then run the IO failure completion.
 		 */
 		xfs_buf_lock(bp);
 		bp->b_flags |= XBF_ASYNC;
 		xfs_buf_ioend_fail(bp);
+		return;
 	}
+
+	/*
+	 * BLI has no more active references - it will be moved to the AIL to
+	 * manage the remaining BLI/buffer life cycle. There is nothing left for
+	 * us to do here so drop the pin reference to the buffer.
+	 */
+	xfs_buf_rele(bp);
 }
 
 STATIC uint
-- 
2.53.0

