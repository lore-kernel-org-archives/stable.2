Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793064858;
	b=bNZQ0zLGLj3R2lJ/O3PMjWMNRPuMi2TkMMULwvSjpJsMYSR8cCDdt0zVLLPBMUsvXVEF
	 B0eJzutIy42gido1gvldYKhBY46GMEH0MzT/6XDFrMjqGjfaZPHGo4bWgQtnQG8Cq0tBO
	 S2K3vxnqqP104nUvmRFfKM1zeBlpFAmXQYNunRXAg/bHbW+Esxy20nklZVf9b+fgSYfxF
	 PUdCwExtWqIlu3lk5MumN5HKjBqegITLgf6UNp6RFFVLg5p+lr1aKLV+QL2oYIq/lnrP2
	 oEtZuv1NS844CQwTWsgtxxK4jUZBb/dz/hNagb93+oKpEHb5l+BZmJVh7Uo+rUjH8OA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793064858;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=GNTv7f/SFJ3nM8ABCTiKtDHYqCwKwhGkshg3TqX2LjA=;
	b=qKYKX/WsqWzZX4LAqB126JeMoohayH2Jq9zs2SUNgeuiPmJN6LRm3KSgGZtJvA7+WoO7
	 Ip7hgvGZ8rInb5lz1f4AeBc5VYuPUs9x6vaIlQSL+KzaYVrCU2N2gtlWygXlB4h1Ls9q/
	 lwsifiyOezlvZdUNJhBZ5Fe4ph8aVwYBgZUI0rQT7/pxUo8EA3nYfLVxG8sI85i4FWimu
	 grMoBEtWIOXs5MIJe0d5Xj4cE3Iimj5fz5bLe6Fu4oMp2qDZ21gtwqJAg3UczHAPSMN87
	 DtEut4SmGvRlmtf8vCQCWRWdEwXITQES4S+trDRBTgT5ARVRQ/ykl5YSD0i+MUF4QqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="strVT/L8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.6
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5BE606A31A;
	Tue, 27 Oct 2026 01:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F5BE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=strVT/L8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBUIpBP0LKTj47lc/+V1oHh1W1rqHoXm3Wy/b7Tbbjg+dcwMlPtB1gR4Wia5ZOg4VkpU73nRalFP/V1xD8hRObMIBkceK3BBDjaeCUSQ85Vxt0v19Q8FsqqyxJiLwljJxs4MbnPxUcEiNIignTxAiDXHQdrZdMLDMEmammVXx0VRYknz/BgRo3lOBgVvHFYRYUpPIYY/HOjrMl4B/C1MOTCMfBKnc/NDJkwkVyMB1he/fThJp4YTlND3C/hwDiKxwTStGOigyxCFWki1bv+5wNeYDjX3xFc+7+H688OPHvlk998aZZRylwhI2R5AaN7SEhJng4fyeXpd1EWSblJA/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNTv7f/SFJ3nM8ABCTiKtDHYqCwKwhGkshg3TqX2LjA=;
 b=jS69Fv8nJmm7q40Vd6rBYaClyVClcUiupPSRs5vmHxNDCQDePDQic3HEKaCUQX2vTwuy+vztMiMtBBndWKwa8C/Dwa95teoMkb5p+4m50ogJV4hhhOblJBHNMCo7Ta3a5mhr8MpRN1XAU11xxUNEYnvThC9YQRz3FO5WMMXzIKJYf4sVNGNCcM9FYDrEXRn5YkGUiCqpaZEWU+fRzu+81I/876I/hXTPRNOF072LqotxCG7EldKf3VR5YL4ABobgTpniWAfbxCt4yUbmO5/ZdPOhGDKVwClofFufkJ7eLHT7WHFVHy0TZaRD6+kojzTqegc0ZzzhYGtL8KM4sRJ9cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNTv7f/SFJ3nM8ABCTiKtDHYqCwKwhGkshg3TqX2LjA=;
 b=strVT/L8cEj+mK5E2mpMilf78P7HocRRDbgwhOeoV14A6C2l49kX4FWEetyMGQtw6VqRh8p1Gdv2ERKGc5RooNpwhyKGNTXbV+OzVRqFJYJYgQmxX9mH/W2CR7ryRW7G5IV6gCCYWTTnPdLpC2/nxshUqbRpjFU3zexGq3okJ1gz7PHGRBE1ODPsADwt0eKxrui9sS2frnN73DZagI2kM233IwR1Ahxu1j24C265FZARxsPz4ea6GIpWM/tu6fKlY1vypgHx7Om1PcuDD9j/sGjlOnCErkNSNDy/5D/jB+01N19hy4fvLG1BuXIS5G3NIujL8/UeZmE9Gah9uj6E9Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 01:34:10 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 01:34:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 21:34:07 -0400
Message-Id: <DMF8FVCUYJ5X.215YGBLZ7H56Y@nvidia.com>
Subject: Re: [PATCH 08/16] mm/shmem: stop retrying folios that cannot be
 split
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, "Chris Mason"
 <mason@kernel.org>, <stable@vger.kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Gregory Price" <gourry@gourry.net>, "Joshua
 Hahn" <joshua.hahnjy@gmail.com>, "Rakie Kim" <rakie.kim@sk.com>, "Ying
 Huang" <ying.huang@linux.alibaba.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Vladimir Davydov" <vdavydov.dev@gmail.com>, "Michal
 Hocko" <mhocko@suse.com>, "Hugh Dickins" <hughd@google.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Lukas Czerner" <lczerner@redhat.com>,
 "Carlos Maiolino" <cmaiolino@redhat.com>, "Christian Brauner"
 <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Daniel Verkamp"
 <dverkamp@chromium.org>, "Jeff Xu" <jeffxu@google.com>, "Muchun Song"
 <muchun.song@linux.dev>, "Oscar Salvador" <osalvador@suse.de>, "David
 Stevens" <stevensd@chromium.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, "William Kucharski" <william.kucharski@oracle.com>,
 "Chris Li" <chrisl@kernel.org>, "Kairui Song" <kasong@tencent.com>, "Nhat
 Pham" <nphamcs@gmail.com>, "Miaohe Lin" <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-8-703206d5fa0c@kernel.org>
In-Reply-To: <20261026-fixes_shmem-v1-8-703206d5fa0c@kernel.org>
X-ClientProxiedBy: YQZPR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::18) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 8543d0a6-ae0f-42c1-c472-08df33ca661d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|921020|4143699003|56012099006|11063799006|261009223027099003|261022105027099003|261021121427099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	bpv5jT9ms5hjBuLuLu6QaDG0u/3qlkrBv4Ph3C9WKMueFxbKQ/q+ftQrhwYff7mYNm2K5Eeaee9rAGH5G+pp5ONIblMioiSyiPWL9WlVgHOFOKGmRg03W7pkXp6YHsEalsUQBwcU73mCVBpBP8oPm5CLN1hMqcAM+tengxC7MvAcmed687K61+nWyoPptjUdm/Pt5DxOuJW2GOlFMdble0zY9md+YYr6z2CA86292Mhzxndg1sj5K7tELxrrTRQ/wlFFb2TJZlj8DRtHFpTTxMXTBgU1CycKpKvc/F/CGh8JJRH/8nVTcQzq/aU3ehmMheu2FNWtpeuWqd/9pf2P/CTKIZQJun3VOqdO56uY1KySFlro6cxlgcUXPgoozEpjf6RAZKbSaO2qWjBk4U06W8tU6V390J/Q/H8bkBKTxoEmTME5nEwQKVRG3tPt+iTXOZvhLdfsMy8XWAG7zFntRx9HCsF+mXrMvk2qSxh1a1sgVtsj9oDwtpBy0SJHwaNIInIJTZYHZoTDAB2od4FJjEEnx2e1w2xdLoQFy63BfrpsCLLHVGDuHvuP0PTfW5zr23z4HB3VtIR/MtNqAFJOmWmKToK9oCs5GMCOMCK73sirhS2N+O86ziDID88upQwxZTSo82EdjBZUTzbpuvLAysy7cX9EKT3gMJRhyMbxOfZFUsc/VY3qQUqW1xogGUOIGoR+o9jrHFt4EN6+sTe1ew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(921020)(4143699003)(56012099006)(11063799006)(261009223027099003)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0FDdHRYV29EQlA2RWVzcnZwQ3o2Zm1wLzl0cnJwTW42czZYU1Jxd2Z5QXBX?=
 =?utf-8?B?ZXJZYUxRcnRBT1gvNWZCdnMwTEtaa1FXZ1pGZWNqSnVPMGJWSFZKcXIxVnZq?=
 =?utf-8?B?VU5Md1lPNlQ5UkdURHdaTmp0a1gzdkk0TVN1cEltSFJaZXRnRTFNa1I2ZXM0?=
 =?utf-8?B?Z3FWM2wzYXhma1FndHZ5Mm9vaVJ4Q1ZBOEtrWDRkV3hvblg1UDdSNWJRTmJi?=
 =?utf-8?B?dUdleDlHcEJYTjBzMXozZzkzZFlhRGt5WGRQWHpjSG9ETTd6QzBuUC93ckxW?=
 =?utf-8?B?U3I0bGZHOTcxMlZHbXg1OFpCZ3pCREhwRVBNTDRuTkJlbDJ2SWViTG5SVW9V?=
 =?utf-8?B?a080T0hiSnJBQVgyZGNnQTU1QU8yellEMGx1NHRaeWFFeXRIaVNZSUk4dkpC?=
 =?utf-8?B?TU5CYjhHWnZUUmtpcVUyeG81azAxYWY2T29hZTU3VGoxMkdKTzg5VDM5U0dR?=
 =?utf-8?B?TFdPV09JOXRiZ0VsQWttRTMyVHRkWFVabXJiNHVxc09tWTBETXVCajQ5SGlz?=
 =?utf-8?B?cEZ0VkRwcG9nMlZKeEtlMEh0Mys2Ri81akZwZmNWQmtFVmRRU2RJU05uNmlp?=
 =?utf-8?B?NXZuNVlFUEtRcDQ3cXNORlU5TkFtQUxDNVJjclg1eTlxcUJ3cXd2WTNUVkxL?=
 =?utf-8?B?alJMRVpkL1ZYMENiOEp2Q0lUS1lNZmRZS215YW0wZmM0akgxK0U4d2tyWkFy?=
 =?utf-8?B?c2ZlWEJmNnpveCttVG1BUnM2VXpUZDdpaXNMS3Fwa2ZYY3RQUTl4bEVMVjNx?=
 =?utf-8?B?RzJDTE1YeWRpZFYySUFyY29UK0crTTI3bzNWejlPSExlSjJvREFEbU03Umg4?=
 =?utf-8?B?Mk9ES3VyWXdKRjV1cDFxSFpYODB0STB3ZloySHJSaXNhMWFQaHVCWDdycXZD?=
 =?utf-8?B?VmlQMWhVdzZvN2d3MWxIR09QMk9PbnBnQzNNQkdOUTFOZGUxbWdLVEdUWEVF?=
 =?utf-8?B?VDhkblRCTmdVZWhldmJxMVp4UklMUkVieUhzbkIwaTlPYjE1Y1dZZ3lDem9K?=
 =?utf-8?B?aTh0TkR4U01xbkdIa3c3dWVGZnpXWXhBNzRWSnVmZjNOWTVZTFBiQVorMkEy?=
 =?utf-8?B?N0RseThSVUZKdGQvZS8rNlgxaWFyVHRnTjNYTWR5Mnc1aTcvMlh0cUU4OXZ6?=
 =?utf-8?B?Z3AvSFMwMzlyTjZoMHI4amxLTlJaWkhKK281ZUJocnA3dDZpMml4MzJYcTlq?=
 =?utf-8?B?MU5QSEN4OGR2S3h5UGRnNXFKZmJ5RTlML3Q4bkYrNnBySEQ2Vk1ySlRieEJq?=
 =?utf-8?B?Qy9TS09QSGdPTUNVMDcwMUJmUlJsOGYvR1RybHg0WnR5N1BqUzhJamM5Tko1?=
 =?utf-8?B?Q0F2TXNLWHBZeGN2ekNQUTg1Qy9aRFlDdlhKYkhIY2NWTFRmZllCOTJoay9B?=
 =?utf-8?B?c29ORURWZjBvSE9oUjIyVHA3VVZsSWluOTNiUG9TYkd6OVRwZWVXQmttS1c3?=
 =?utf-8?B?eEMzSHJqV0dqTVJ5cGU1bHZvVktOQkFwWVd1ekVnK1VZdFBWLzRCUTJQV0V1?=
 =?utf-8?B?Z1BFYmlpTGNJdDE0OFJKdlpMc0Y1WHBxc0xyN1dac2ZEZ01HRTlWeHlERzRL?=
 =?utf-8?B?ZFVKQmJZV0V5dDJFWkQ2dGt4V21lQWlRdkk1Y2tVYU5Vd2ViV2ZOUlkzK3Az?=
 =?utf-8?B?dE84TGc5ZERDbDl3M0JoYnNocFFXVmpuZ0VCcDFXVS9SQ3YzQ1kyMmVRcWMv?=
 =?utf-8?B?ZDlJdDQ3QXJqZUdQYU42UUM1bGNwWG9GVEVSdGNHN1VDSzA0Q3kwdE1CZHFw?=
 =?utf-8?B?NXBqSFFScGJ0RlQvSFZ4bUtjL3JuaXZVbW1pZndLOUdHU3o5cUE4S2U2QnZU?=
 =?utf-8?B?VzczaVo1RzlQOHFzUW1weGdPZDZRYWVpZTlCK2pVTjZPT1dCU2JxdUM2OU5D?=
 =?utf-8?B?NDJhclg5UkdsM1U2UVpYeHVvbTRKeG5TUCtaclpqa29JSHhBS2U1NFhxMHM3?=
 =?utf-8?B?RXhadHBLTk14WHJUKzR1cW10ZGR1Y3VDSHgxTlpVQTJBRi8ybGszdWV0aWt5?=
 =?utf-8?B?OXpuamNMZ1VtQTlBcG1YS0pqMnYyclo4Y25mdzd5eWd2akF4RXBVb0hoVkJh?=
 =?utf-8?B?TG1lanJ2c29ad2RibnhDMGhodWovdGNvRERDamxrT09DSWVJN1pDckZvVXMw?=
 =?utf-8?B?S0VCVW13L0R6OWFMeFkvYXpRaklzSWVON2luejJMUEEvS2p0blo2cGpqL20r?=
 =?utf-8?B?d0diNnVNRWhkVVBoUGlpTXJ3QWJ1ZmVkcjlCTXFMNk5ZTzZ6VVN5WmJNOXFC?=
 =?utf-8?B?SUhCZzhUWGcwVmtDeWRVWkZJQ1dhYTd4djFHVVFhbWE2bVRKS1ZjQ1BEZVVE?=
 =?utf-8?Q?8Ji8P3GoOK9CTmiWmY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8543d0a6-ae0f-42c1-c472-08df33ca661d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 01:34:10.0560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrqY6FIw9a8FHheHbgebZ6Qx946Z6+lTGrvTxw/KX4zsTTq+BqFsFFXyo0ghgzKo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978

On Mon Oct 26, 2026 at 5:40 AM EDT, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
>
> A fault or collapse can insert a large folio crossing EOF after
> shmem_undo_range() has handled the boundary folios. If splitting that
> folio fails, truncate_inode_partial_folio() retains it when it is dirty.
> The final scan then repeatedly finds it because it restarts from an
> unchanged start.
>
> Truncation keeps the inode lock and ignores fatal signals while looping.
> A concurrent unlink() can then block other directory operations while
> holding the directory lock and waiting for the file's lock.
>
> Advance start past the retained folio, whose truncated part has already
> been zeroed. Do not move start backwards if the failed split has shrunk
> the folio.
>
> Fix generated by an LLM and sent by Chris Mason in private.
>
> Fixes: 55ac8bbe358b ("mm/shmem: fix race in shmem_undo_range w/THP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: split fixes, simplify descriptions, adjust comments ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/shmem.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

I rebased your patch on mm-stable, which has Zhang Yi's fix, and
1. tweaked the comment,
2. skipped the dropped folio (this is to avoid a narrow case below).

Since after Zhang Yi's patchset, truncate_inode_partial_folio() is
changed to return false when it drops the entire folio. Restetting
start for a dropped folio in the scenario below would leave zeroed
folios still in the memory, causing a waste, although it is very narrow:

folio A=3D[0, 512), B=3D[512, 1024), C=3D[1024, 1536],

1. A, B and, C are inserted after the same_folio block check, so only the
   code at whole_folios label sees all of them,
2. A is split partially and the split failed, A becomes [0, 32) and
   [32, 512) zeroed,
   truncate_inode_partial_folio() returns false, start is set to 32,
3. B is dropped entirely, false is returned, start is set to 1024,
4. C is split successfully

After 4, index is start=3D1024. The [32, 512) folio is not dropped. That
is why I added the folio->mapping check to avoid changing start in 3.



diff --git a/mm/shmem.c b/mm/shmem.c
index fadf23f9e21ed..efd54a624974c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1480,6 +1480,16 @@ static void shmem_undo_range(struct inode *inode, lo=
ff_t lstart, uoff_t lend,
 						index =3D start;
 						break;
 					}
+				} else {
+					/*
+					 * Splitting failed, but the part in the
+					 * range is already zeroed. If the folio
+					 * was not dropped, skip it when
+					 * restarting the scan to avoid retrying
+					 * it forever.
+					 */
+					if (folio->mapping)
+						start =3D max(start, folio_next_index(folio));
 				}
 			}
 			folio_unlock(folio);


--=20
Best Regards,
Yan, Zi

