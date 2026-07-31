Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425CC356A12;
	Fri, 31 Jul 2026 05:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785476466; cv=fail; b=cpaaInyQ+6S02wJ6AR+CNoGDe3LjX231+A+ks8rJQFwgYbb2oNvdFH5O0lQ7JTMtvVj9OcQ7iXvakNp9gnNFZ0yKHLvATAVsYCH8CwwN2Y3nmbCjeliIXk60/0CM37MguloTpM0zQ0y1yhpG3YnxisGYySxKW4R37ezr3UDi0KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785476466; c=relaxed/simple;
	bh=fuhcxFIqRvmsoo5uk3G2Lo0+aEkfSYSwlstS1dFZJDg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=XFr7S2M/0j00y2kDodBZkxx93+Dr2VwfJG3siaFRza1abmQVANLYt19W2Kry5PTO3opOvPwEqRLlywbrXuzKOE6fkP5N5672vNVU7rMtcwwq4550hNkncwfFsd6+pEzsJbBlLBmCl533yWe+R4gTYM0W5fu7B/CwNjvA8M7BoIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gOciN304; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A4A1dMVz reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gOciN304";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A4A1dMVz"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V5Hxs71640681;
	Fri, 31 Jul 2026 05:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/tAkU4kGPQ2PwfGGJQzXRRQ9LLdsIuhSXugEbGelsoc=; b=
	gOciN304pBgwv8iZNP5QrBW9qteZzaOCJGjCgAbrLIRWla3YaVWMe6whdzxhwfJA
	5oeCIkxSbqasvPz0CJ/wSge4kpj+8J0wO1pxXDPWxodKyzDHyBkxsvsrFmwaimWB
	6+FtuhD3RlIBIjIgWwdR4O+TMTlD3E/KtRCgh1uVTnGgAL7a4B2Ro2082cKHzZyO
	FKV2/TuZJ5RrGx5wk+qD6KW9SE+EhW7JaYRuvO2BQx+Z0w8Sv5ZBN3rqbQGloGBG
	bTpcOheldu9Qm5x4/XTAqg6veVyLBX+H+S0ZyIQjpelvJNAppajMa4t+ODmucNvI
	lVNL52wPVzeTQRN1v2JlRA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr3pru02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 05:40:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66V5ZYdl021020;
	Fri, 31 Jul 2026 05:40:07 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011005.outbound.protection.outlook.com [40.93.194.5])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fnh6t222b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 Jul 2026 05:40:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjbDlXnvUtycjpfhZ+hIEep4GtQbZMZC3tkgtfaR30F2M40nmVxFle/kYW8FFQDz5tdzwrTaLzhUpgV9jKd3+rEdZv8vaijpN4wdZBqQG+sSKNgUwCurmlkO1x9z7ZUW+8ym+kbHlnUiEI/gTe/xByqo0WQkCZ45gSqfB4/jYxmR9TgK3Ye8nrVFZLBAPs9UmNjegfi5bsTM5YVwWSQPZD3SeocfZcvIEmFOxYgl1zTOfgLjtp02SmKjk5Brp4VX6A6DINJKJQB7x2XDOBWM0WkszZkUYgdTAovOjwHl+X1V/5YDKqQpI2g3JqJ1Unt72CRd09P/OjhO60ZijM4blg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z82VedXgquk5xeu40Aw/8Spsc/pHDeaokhdkkicjhoQ=;
 b=qTc4JHHhHqgcaP510VSGbniTtLrL14xnoFewwuRMNXD6gdM6xxJjtwtTAHjxeW7flVWIp1Xl8xVvUB33P0Gm5Xv6v6jDLOldN7SESR462NDhO9kgXBpcYWY+iFdrun/yQ1k5rAkKqXIS7ESfwJdzW/YVCxQ6pG3qQrBkYtx1Fn2vLvNAfczds1u/2oIL6e/ozF1Uggxc9GPojHk6erQzdv5MPwEjirgr656+ez5iKkcLeFXIw33Vqi+Z42EDYO+rEaYuMpidCJGr0dOws1YofdiAJw5UPSOUs5wf+O2MCD0o8Wl7ymIIyna9pkGLVbOSdDxVnMFzUaM96LTqkTqzAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z82VedXgquk5xeu40Aw/8Spsc/pHDeaokhdkkicjhoQ=;
 b=A4A1dMVzcIwYIeUSwYCZZy9rOlME6aYhLGzncaJLpR6S+KZm5vCxYwaj5LygKCil0/wAX0RI+DfdeBfgYoWC7FNnVq0sfw4JME85shdjlFftExHy52AIx1ZUx29FhciIbCud+FUtGXCKGFuiOG60JoZfcY+iXuUbpvRQ0uPhdhE=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 DM4PR10MB7475.namprd10.prod.outlook.com (2603:10b6:8:187::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.15; Fri, 31 Jul 2026 05:40:03 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 05:40:03 +0000
Message-ID: <c5b01c38-9c35-468b-9fce-ff7e1e11b03f@oracle.com>
Date: Thu, 30 Jul 2026 22:39:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/13] memory-failure: Fix hardware poison check in
 unpoison_memory() again
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Jiaqi Yan <jiaqiyan@google.com>, stable@vger.kernel.org
References: <20260728204409.3396238-1-willy@infradead.org>
 <20260728204409.3396238-2-willy@infradead.org>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <20260728204409.3396238-2-willy@infradead.org>
X-ClientProxiedBy: SJ0PR05CA0178.namprd05.prod.outlook.com
 (2603:10b6:a03:339::33) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|DM4PR10MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: f6615e1e-183f-4889-89a1-08deeec62b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|5023799004|4143699003|56012099006|4133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	z+5y1oaJLtUzkwgYnGXjjfL21Y0HcWvGq0o+7fK35SQsI018WsJiSt5Xd3nFIKGu42XKdM/I3zO0j9rmlUUjaXOdf1aQbVCxUMrMaoZu0GdX7D3KiWrh8IHusqy4ytWBZpKpNMV/P/strsCz9UtU8djle1zPXUxHt+tL8thvLcxnWj4w+vA4kJ8gIn4wfKslM6T5CuQPJN2OYj6TMGQcU2aXi4af0MOfBoLbvDh5IZb2WBSLqh8o2uvXnAVyMcilzeFd4I88BZjvQmMrLk6n7eM+wr6Bu7ClY2taUu7SQRcHuQbh+IjQhBAIENsNzGtN1ZvZz/l5g3cbvfyXYP5ZinQmgwQAjri5gAtJYckFHWxMSsNFm5KYjaMP2/v8LwflMRylD5nZPY6XGaieJW4nnfDw/Vb0mvgzvwI9zsm93yjjI/N///nBLTnHVUC24Ek8Sf1fSfWCK1pYqtrSnH0htzy7Xi0RTbuoo98CI3SpuaYPl3urievddq8xPaOFrDWk3PXBaylBSiVQY7KFxXFJpn/XlvUnrKuobVDtDZ1xFlGw+LhK3p/A6K1oxA4dxrB/lkqEoiZyqrNX0+eWDt3IZK7YS8P0PB888M5Od5pFGty4+bb7IEeERSUugBMW/b+r4x567gaRSpQdq2O0PbWZyynfnhMGAstNZcRI5ahVkmc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(5023799004)(4143699003)(56012099006)(4133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2h2b1lXMjFCVWZlY3JNMGwxQnpoMmsvR0taaGVaT1pSN3dmTlJIUDZMeXpN?=
 =?utf-8?B?RmtaU1pxZ20ya2RHNU11cnFoTDlCZEQyWnM5bzNlUDlxNnNub2FmZ2Z5Nkxx?=
 =?utf-8?B?c1BhUVY2WER6dkNSUjJESnBmNG81NWtkaUVRdjBSaGpVdjBmVW9SUE5UK3hy?=
 =?utf-8?B?MFFsdFBDaDVMdE9zUXBqUWh4eEh1TjFzekx3NStLZHhsN0R5NjBCNEtReWNG?=
 =?utf-8?B?b1hneUtUbFM0RjZiSnVPYm5zK2diYnNqTmpLQVpYeFNIbmdZMllsa0I5Z25S?=
 =?utf-8?B?R2VNQUlFcEo1ZStiL25vV3VjeVhuZGVRWkV3S29zSHZFeUcrRlNkMVNaaTFs?=
 =?utf-8?B?dEdQVzQzYUUySG0vTWdjQ3pQMkx0OURKamxjdGZvTzRpZ1RkVEcvcy9FWWZp?=
 =?utf-8?B?cE5tUmREeVphTWdJeWZkb1U2SEpZV0dONUFubkxoUjN1YVBrVEFFUDhkNEhl?=
 =?utf-8?B?bGU5L3BtMVBHc1o2TitSWE03WGNTWSt2VzM5SW1MUGhQcmZhLzh4cWVaQTBj?=
 =?utf-8?B?Q0JCcjhONjFsemlaTU5aNTVFQlVtUXR2ZWtKYTAwOStUM2xjWWJTM080Ylgy?=
 =?utf-8?B?b0xTYVozbkxYNGZmOGlkSHNYSGZyNFNvazZ3a2Vka0k1cE9mYm03ZkllckVN?=
 =?utf-8?B?N3JMRzFUVk0rYWVqQ0FGQTdJdnRXOGlVZlUyRVpLTU93QnVDWFU2Tk9peXE2?=
 =?utf-8?B?WkpqT2FaS2M1MStVNFV4ZmJERzV3VmlzakVJTUI4SUdaQVErdE9aSzJlQTFK?=
 =?utf-8?B?ZlpBNjJ4dW0rV2NOUng2ZWhURktjSnpxby9xUm5jWGhzR043dFplZllIZ2RJ?=
 =?utf-8?B?amNsQnAvR0oxbU9OdEhrWEhKVmlGZW5STWUzSU9EV2JybUNLUnBmYytmTUlE?=
 =?utf-8?B?T0hUcjgvbWwyZWkxdzBZTHdOOEtuOWlKV0s3U3VONnlraFdCdGFFbi9RWmR2?=
 =?utf-8?B?Z0RPbThwdzVub2NDOE1oanJnUUhwbnFDbWhNL0h1RG8xUTg2UW5leTdnYkk0?=
 =?utf-8?B?V0NvOWxZU0M3S1dGRlBMemEwY1diRjdYUTRuZVdGMHpiOVpuejRaRDQzZ21N?=
 =?utf-8?B?VU5tcDU0cVRWUllyYllvUGpMNlJRS1dLK2Q2Q1E0Q2s4NFEyU2VTZnpiQWhi?=
 =?utf-8?B?SnV6cmJqNGNpZlBJRWZ4Vkc1QVUza0FuTlR1NmZJMFU2bmFMRVVzRTV1d2JT?=
 =?utf-8?B?NzJxMllseUExWGd0bVdkY1NBUUJobnJqOWYwU2RHdkFpUnZjZnQwUjJDdjlH?=
 =?utf-8?B?Y2t5L3IxWGJqaWNuTk1aa01HRUh2ek4rc0tYU3YxK1BTTE9yOFBtUTFuYkJB?=
 =?utf-8?B?NFJuWFBaNmlGd1pmai9jK1BQNjRoSlhzc2lpR1hsbUNXbWYrNVFCQkhyU2lN?=
 =?utf-8?B?ejk2eGtQS04wUWJpY051SlkzeVRmZUxXTWdZMGdYTE92Y3lKVHV1dlg3cEJ5?=
 =?utf-8?B?My9GMnVHbmJzQ0FQT2ZUajQ5bWhzZGl0U3FyMjA4ZGl6ZXIyTkhadTMxRitD?=
 =?utf-8?B?aUVvUVIyd2VJQTZLSlVMMHZiem5IYW1CTy95WFl2Z1RsQWdhUi9UYWc3OEdZ?=
 =?utf-8?B?VnNWZkhqanZPR2o3dnpFbUVTVU9Jb3pMeTJTNk9qYzc4bzN0NTcrWjZwWW5Y?=
 =?utf-8?B?VTdGSUdwVDhLVHZMbnlVdWI0bVpqQXJJNjUxeGd4Qnc2T3VDNUdCeWp6WnFi?=
 =?utf-8?B?TDY2WFNsM1BUMXhjWFoxWmlRQWtkVWlpSHJKWGpHYURVL2NKd0ZJTTFIM3RR?=
 =?utf-8?B?ZnB3NS83REloS05WNHNyVm9HajlPVUt5dGhDdXVXdk93MjN6bDVlSWZXcnpx?=
 =?utf-8?B?Z2VrNGdxcXB5TGJaWlJMYytCQTgvdDB3U3QwYzg4UTV5cjM5R0RUSEw3a0dl?=
 =?utf-8?B?ZHVjUXk1WExCb0s3WXNNd3B6Tmg5czFkYkJ5cXZmZEZ4VExRdGpHL2Q5cDF6?=
 =?utf-8?B?dFhxWUpXS1FmRlJwT0ZweUlmOWdqWVlLcDZmQkZLRjZqTzhaVTNTaHNyNjZ5?=
 =?utf-8?B?Q2ppekcraTVpRWt5ZHF3S1JjQWRQNDZPZHRRTUtrZDg1WVlqbCs3QVZyTDRS?=
 =?utf-8?B?aG1iS1MvdlFYTGd3enJPMUlMS2RKTlluNHZ2Z2dveTNtc29TdytoeTRIYm9B?=
 =?utf-8?B?aUsxODJUOEJMK2lQUUQxTmkwaEJ5QjFsRzhFQTFpdnNaQnY5b1gwMVo3QjY3?=
 =?utf-8?B?VzRFdVJyRXBETTc0UVlJcWQyS0kzVk5zRURZSnJyOTU0YXZCUkdTQkROejVL?=
 =?utf-8?B?NmdhaUZTY1RuZGFBYm1pbklSU01WMjEzUkQzbE1TeDZPRTZJVjBVc0tVeEV4?=
 =?utf-8?B?ZXNOM082YWozdkV5RUt3L3BmZlgveUcvWHVBVzNxVzVkdEdVNGkyZz09?=
X-Exchange-RoutingPolicyChecked:
	feH2DY/MJt1fNtrL9//94U9EiUxw6C00tlDO2pwo2dhQQS4bYIPvnaQQNEfKMocuVXVScVM6vqxpSRdSiNnyjJ9V6RbGhxuvtwK5GFAcwVkU5Dgw3zGACK9LiSMSk7pgKqCnXJEOr1OV5mN9rHiAkncEU4DhvpfN6ojCpThR307wAeyDSKqNbONysU0jeAmhW2y612UvROLvnt9CXe1Xxun3B+JGn3Gnq6b6ZJN/K8uJYBo2Trsu01035lyzJ5OSv2NRnbm8Z6e/5EpO4y3pIjn2tTVRsp4nep+VYWpl3lAsicxGH4kxA4RrLLhG1rSAoTnDpNs1RKykJHWf13LlkA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oBAJRtaXzTE3BJE4F3J1doEk4ylc0P57zBfaGhxcCmxT8K/Ke7P3G9J0GLVdmnfZTjh0zQEaI5BAVaHPD0nYcL3QJn41lgRjBZUoLUKiBllbMcNPW2IC2nHteTe/RAdLWpRL9czcli9hOVgOSnR6u6EVQ4Tek74LOmKr7816Y+2MH+vTRvJXH/iRGqSOAPgf4DASXipwZSaJnowiTvPzSyhekEqPGMNk/dhs4sgm5TyjTUo5mlSJagaoNXZ3gFxTQO97p8DTRT+ySRUIDbofcd/Ht38PCPebjj8G2RgOI2oO55Em4TV+G037k3yPj+FeVoqnNeeOj0mj/qaEkdMFXUn+/6oB7NDEVsSmIq0IBRYLxWIhi1jAcsw2VQ42pHBhu6xFfJYNRV7yKy02hYaoU8YTk73mZHdz2bfXERfXB7hgz48TX3mht/9NwzhEGFvgkPuOqneTdbfwHvVCSngV7Ge1QBVja1RhWrB9TLmJa+AcP/cUUZfyvbxTxlM2Tgt+pc20L24e/Mvc3urlhOHd6CMkMQnCgp/GZFskRg1bwVDFmUVB30kGly8UZoWywY+dJ/21KCutsFY8Y6xnv/ICNwAZXSWmn/DRUKnTaQJmT4Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6615e1e-183f-4889-89a1-08deeec62b72
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 05:40:03.4868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHba6wNejbILDl2s2OIUnAylV+//caTKqbfGYTEZoIFAP4QkFgued/pJWnnKVdrketb4UxKhvvCh1AGnxWycjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7475
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607310035
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: i7eGTBp12Lpxk3PnRkkhb0NLWI2u3sDh
X-Proofpoint-ORIG-GUID: i7eGTBp12Lpxk3PnRkkhb0NLWI2u3sDh
X-Authority-Analysis: v=2.4 cv=RKWD2Yi+ c=1 sm=1 tr=0 ts=6a6c3538 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=RpNjiQI2AAAA:8
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=JfrnYn6hAAAA:8 a=5Ohp-c5rVUARNMip_Y8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAzNiBTYWx0ZWRfX0sWoUUivSoTb
 jK0dNXRE6Bh95/7yorQF0ejAf9hdILWQBweXhQnW7zdrcG6qruSb/jVKs69M4wRIqH4bjxg25sa
 d015x8+HoGdGTHNMQsMBuRap9V62knUHAvjAtY0487MLFEPdgcxXBOd4mN1alvlT3rJh7eBmQ3j
 GSmuNBMF4Ao1y6fYyPzelyMGYC5HV5JkmdYRDIkVUcifz8KN1MpomnulK2NOSTgjWsfw89kBIsV
 IegLxsV6qjFzBMHidDNYxCoMHYCxW98WWMr9MsYWOKNwOGNBq/KbhYBQ1EjBcIyutpDibdCys1l
 lxh49Us1XHGseGqM4yZlHkJbpiP6VegcZAT4XOTJqwUo4ojdq+oW2KCQq9j4Nnnu19lI7L+5cxD
 HNmteczlc9qrq8MkxZbdYsYtdJA5moBWusSDL1kU72cUEOXqNpNJI/PvZ+8b/T3nTXr6Sx3Vg5W
 hFAZdhOyl8eqSsuLIsThB9jlxnXterIx37kX0GgY=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAzNiBTYWx0ZWRfX73PiKypnAETM
 O6QxjH3oRo0hpfbluPBarL5okdUwc3DyW8yofvhUcEhdzWK5N11b9uUAkLbU8M1hiDBrS5CSupn
 Hd9IQsaeBY35nB58c/0lHONNvvywbyHhIHEV4RnODJdWw1ddynPt


On 7/28/2026 1:43 PM, Matthew Wilcox (Oracle) wrote:
> The earlier patch (6c54312f9689) that attempted to fix unpoison_memory()=
=20
> was incorrect for hugetlb folios. Before a6fddef49eef, we checked the=20
> head page for poison (which was correct for hugetlb and incorrect for=20
> THP). We are currently incapable
>=20
>=20
> The earlier patch (6c54312f9689) that attempted to fix unpoison_memory()
> was incorrect for hugetlb folios.  Before a6fddef49eef, we checked
> the head page for poison (which was correct for hugetlb and incorrect
> for THP).  We are currently incapable of unpoisoning pages (other than
> the first page) in a hugetlb folio.
>=20
> Use is_page_hwpoison() which handles hugetlb pages sufficiently well for
> this purpose.  This is racy as we don't have a reference on the folio at
> this point, but fixing that properly requires deeper surgery and this
> is a CAP_SYS_ADMIN path only so this will do for the moment and can be
> easily backported.  It's no worse than the situation before a6fddef49eef.
>=20
> The other bug in a6fddef49eef is that we currently clear the HWPoison
> flag on the precise page, which is wrong for hugetlb.  Fix that too.
>=20
> Fixes: a6fddef49eef ("mm/memory-failure: convert unpoison_memory() to fol=
ios")
> Cc: stable@vger.kernel.org
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/memory-failure.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 51508a55c405..944e6e1d4971 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2695,8 +2695,8 @@ int unpoison_memory(unsigned long pfn)
>   		goto unlock_mutex;
>   	}
>  =20
> -	if (!PageHWPoison(p)) {
> -		unpoison_pr_info("%#lx: page was already unpoisoned\n",
> +	if (!is_page_hwpoison(p)) {
> +		unpoison_pr_info("%#lx: page is not poisoned\n",
>   				 pfn, &unpoison_rs);
>   		goto unlock_mutex;
>   	}
> @@ -2748,6 +2748,7 @@ int unpoison_memory(unsigned long pfn)
>   				folio_put(folio);
>   				goto unlock_mutex;
>   			}
> +			p =3D &folio->page;
>   		}
>  =20
>   		folio_put(folio);
> --=20
> 2.47.3
>=20

I think I spot another pre-existing issue in unpoison_memory():
the XXX line doesn't work for non-hugetlb free large folio because it'll
just try to clear PG_hwpoison in the folio->page, not the precise 'pfn'=20
page.  Something like below could do.


diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 51508a55c405..14915718ace5 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2730,8 +2730,10 @@ int unpoison_memory(unsigned long pfn)
                         count =3D folio_free_raw_hwp(folio, false);
                         if (count =3D=3D 0)
                                 goto unlock_mutex;
+                       else
+                               ret =3D folio_test_clear_hwpoison(folio) ?=
=20
0 : -EBUSY;
                 }
-               ret =3D folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;=20
<--- XXX
+               ret =3D TestClearPageHWPoison(p) ? 0 : -EBUSY;
         } else if (ghp < 0) {
                 if (ghp =3D=3D -EHWPOISON) {
                         ret =3D put_page_back_buddy(p) ? 0 : -EBUSY;

thanks,
-jane
