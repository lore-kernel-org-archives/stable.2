Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795425724;
	b=U5F91Rg1SvJppCEQsNwQ1eyX1s+qJbBINinDXH3QDz2mNgj5f2LY8/8lc96QDr3oEiD/
	 F1i8BQYmyN6SyDnsJOIK1Wn/GHI0OF6l2NwX5Axx144ZGCcLTLorrs6OWiD7Mw7Rr6NCh
	 7YArqntToOsYHfOZTVQHnkybK/K4BL4neABcDEMZVvc6bdIiAQEuND8ihKtqpEYmsw3tt
	 +axPOxoYCvE06LT7utFVlX9ZhuWf2gBfDjY0fTfhZfUcqcCq7FNwo9dME2ZW8c9bJ4dRE
	 rJDAgN7MbjOQuA0YPPy9qrKiK2UywCdOMFFVwPalhbCg5p8ti9QIIX249mzOclIBR/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425724;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=iS3QCFguGjkTFIwErDHucjGu31A6GDtLusBktCJQBTY=;
	b=YdxB1oCrBz9Lk/LvrDGXpT2x72g+OWav2x3DI47QSo3gpIqjQcslzTcg6GOGx/5uaVeT
	 HylKTBdx/CTohPVYsJpH2T8LwyuB1iKzs1eHjBd2/yMbbkRBzHs8KIAkA3ONyIrLdJKDg
	 1eHcLON3HX9K94ffiVtYX2HtPQdwdF7L40DstQC3vl42cCv8dMyk030BEWqgjumqd060+
	 My1rU+faDTOOdfmaDj7d+WucpJ2RefJgZtEgoVrLrVh8m7RqMaX0PaT0AVEKj6ejwRbtf
	 /CaAVG3IHNZUqk++9UtpciUNkol9r+7aTfTKa+E+P7yfG38y5uiDqc98SIwA5qKFjFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eOvlVJ9j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.9
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011009.outbound.protection.outlook.com [40.93.194.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35812606A339;
	Mon, 23 Nov 2026 09:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35812606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eOvlVJ9j
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxVGfe1i4xgiVtDzB1zu7o/Focb6IBkJ38jFpzCx0ytkmoYewV9M2puzfHjkUMCwss6rT75eWHKbqh3GQMn4RkOXPKEstrHQFAb8NxlS5Jkb7+WWCmGlAto2U5MQ8SGfD7VXPuRX0m7k/IYaT16D5DbsRw8tSGRx/BKWDG4spqOL3YO+gK3uApfSqEuxPV2OAzTYE+tfHIeEXVUC76tB6GneSlqRYFkQW3uUj4S/Zhu5mUSBDJ2nxjPEfABx+dXI2+bX7Rlk/MURO1CAoBSI+fKZ0oKvZzI8JlwSzWlzYoo/KI2L8j6FUirmHfMaxWdrB1MyzyE89MSlpVU80H8+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iS3QCFguGjkTFIwErDHucjGu31A6GDtLusBktCJQBTY=;
 b=lxzNwc5VVWE+FJ7GUXyokLRLpVYCUAq4y0lsa+CHfJASwATD47iB95WLpvCLqy8nz1LBZs6PX/Mqd27/d06+IW3nm4rX7bSlyaFNfz4iXQJP0r5DpKTN/wwzceYp916tG7TUJo5llKXSjVSYNZgtVYi51VaHzRfZdVz1/A4OT+gGk+R5/yomW6+Agg6Yrip5srlUL9mv/sTfxsAyBxXraJ7g/S9D5NfzqE8YAankf8uvwiiz4GDs9/+rdQd4sKLR9WHqasDgighUhZTAXt7646ZZnT/QanyTvoP6etgQBvlEwS+c7+fxwctkBPO73HLaCTzWubdC7OyYQ3CFRTrHNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iS3QCFguGjkTFIwErDHucjGu31A6GDtLusBktCJQBTY=;
 b=eOvlVJ9jmGaHYLN3ubnadxsocSoD7tTgFoRtwo4g9yBFEbmgveilvkrobrounMCEKlPW1DApw23um4lteySETxyu1zuNy78nhjthGomRopbrpaAD6x0N3tgHFUFYbYuYwnfop/T7FXNY9xfY8P59yhLfCAz+HzOCdiXmCE9AUQs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS2PR12MB9797.namprd12.prod.outlook.com (2603:10b6:8:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 09:22:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 09:22:00 +0000
Message-ID: <7e2d1eb5-ebd3-466b-b516-7b4b8bc32809@amd.com>
Date: Mon, 23 Nov 2026 10:21:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: check permissions and bounds for
 vm_ops->access
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>,
 Matthew Auld <matthew.auld@intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Rik van Riel <riel@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 Felix Kuehling <Felix.Kuehling@amd.com>, Chris Mason <mason@kernel.org>
References: <20261122-access_shite-v2-0-808d8d2aa700@kernel.org>
 <20261122-access_shite-v2-4-808d8d2aa700@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261122-access_shite-v2-4-808d8d2aa700@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS2PR12MB9797:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a41ea29-8bbf-4b04-b252-08df49433a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|10067099003|4143699003|11063799006|56012099006|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261102130727099003|261026121527099003|261026140227099003|261028144727099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	4NV9gDoJP0AHf4nbvfEbHNGdjCVHbn/WGKB/yxCGmFdEhi8VKbIRlie9OcK3vtk+4ceJwGfmZlRCLjJhCZFhqqyUsgwNRJ/EOkIGDF9mC9D9F836mPEEUVCEBtq/QvE9kDuMWR7GDtwwgMvBoBASJicQtBJxVhu59uLSPwpYPLPO9t7tE3MDdzZaw37YZE6cUat/p22N7fACG5X5kjgqJLpQ+iFhDn18LFj1Hxn258PHw4zyLrVUX7JMGe14Tvg0tWNeO2xMDAvuYIp9kxq+SfW91j0EEQwvbny5Rww5xEiVeyCx+eOcTp0STF36sTr4tG1TBdDFS+VJntBX1qlE9SKwx0UNr6p1rw0HFwWlGaF1cCg8Pct26KEUMMQwwA4sicKGgx7Jj7ntHra1lAJ0gURx5fNczod7CTvJIUB3sB0tjSKt58leVpaWfdhm1Dyr9LqfQb7WM+Yyqwk+kWpDc7YV1dmXpDawa0aWuKTBG6eqh7WvYcQ7enHKukQ4Ra4/Ut+sXR91Eo3+AYm/Q6SU4iz4zB5uBeI10EvSo6a31fqQP9EctAvwUJuQ6vI/OHKZCWaV4woaa0PCiH71uit5JEDXVh76WtzlIz7bOImuUe8yqN3Jk28Y+HfXDHlCtC5KspkDPdx7AwDsxsDAjOncVZebDDF1/yp6Uyx+YMYLJ23xPzLX+zRY7nY8XfT7bYcDJCMSEvpVFk6HYxqJ3L9W8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(10067099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261102130727099003)(261026121527099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDJzVXBPOGEydVQ4S3VEeTIrbklNZkxoZXdBQWY2c0toV250RENZSjgwVVRq?=
 =?utf-8?B?UHhBUjNQaFQ0TmNmSjRpaUpuZFRMb24rbCtmSndYQ3hVN2pLcXhhMFhRWUlD?=
 =?utf-8?B?UmdkbHY3KzRnK2FJVzNaY05FY0tNeHJLVVo0VjBGaGxxRHlsSVdKUXZMbG1q?=
 =?utf-8?B?OVkzYWJ2bDFMKzRkMnJPRWt3cWQybUNVV3E1VjZnTUR6ZUkvdzBLUHZmMjJ2?=
 =?utf-8?B?cXMxQlB3TkJhc1Flbm1XaXg1NU5FZXJuME0xUUZ2bHlMQXcySG00MlZxRm9h?=
 =?utf-8?B?QndKSk9OUk5hMjZOU1RkeWhkbG90MlRocHIremltYnJCMXczUjlVaUlWK1hB?=
 =?utf-8?B?Q3JSZFB6M2NybHZaZmVlcUZ6cTNPS25ScTlqK1I1ZTUvSXA4M1Rudkd2NzNo?=
 =?utf-8?B?QkhCNmdHVXltZjZnbEc4NTdLWlpRVm9UaW1HaXZJdTFKZzFJYXNXcFJoOEhn?=
 =?utf-8?B?dmExWkJYbThlaUF5Y3ZobzNPb1F1Ry9OUVFlNTZHallHbmNlWUdYeHcyTGQw?=
 =?utf-8?B?V3lnNkxITUFKWkU4T3NVckcwVy9MTW5GelpJNUxLN3F0SFZjdWdQVXk1LzB0?=
 =?utf-8?B?UTl0SWFmRHR4eW9Vb0FFM1Y0UlJVcWVsU25USkZ3c3ZVT0hrU3duOHZZd002?=
 =?utf-8?B?TmFucmZRRnFqRE1WK3l2bTZvZTFFN2tiU1RDWmNTcU9SajZoUW9YZURxOGpo?=
 =?utf-8?B?SENrL1gwdUdDNElwK0hPTGEvYmlvaGpvejJmQUVHdUJOeDk0S1JlR3hLVlVU?=
 =?utf-8?B?T0krVTEwQ2FQVXcrWDhIL3l4b1c3OXg3UHJYOWRYdms3dElOTWJ0dHd3YVFN?=
 =?utf-8?B?TVA1eVVOd0I4YzBhTlFiNC85K3hXTEZKRFhBZWt5RmRKWFBTZlhzYTZNWUph?=
 =?utf-8?B?TUNra3loRDNxbXlEa1EvWWxHNEJUZDZSeEEwd2pnaGpFLzlHbzlDMUdJVW9o?=
 =?utf-8?B?MGYyeFJyQUpGUUkyUVZVU1ZmRm5DQ242MWFra1ErRVV2RzJ4RjNIMzNibGV0?=
 =?utf-8?B?VnBUN2dqRUNSQjlkODhCVnNjbTFzaW9qSDJUNGVTMVlYdlBiajJVVTBadWhS?=
 =?utf-8?B?cVVDV1NiWWNlOUdpUkFIN2VwbVJ0VjhCa0xXK2xySmpIZGN3T21LRERoWk41?=
 =?utf-8?B?Sy8rZXp6WHZRR29BYzZlQzdkMXpJcEYwekk4TWNxRW9ZM096TnpJNjRwY2tR?=
 =?utf-8?B?YXlwek9rY3FoUUNzcTR4VUpHZTNQaG1ySHlyZXMyMmdhbm1xbTdLL1JFQnpp?=
 =?utf-8?B?U0FveFI1VkEvZkRRd05jSTNGc1VOUkEyeENxT1p4Zm5pa1pGcmhzNHV6aGdI?=
 =?utf-8?B?NXZOaks2TE9jaHJWUmdVT1hkVkVsaE1MWU9tRkpWemk2MThSNGlWTEs3QWpT?=
 =?utf-8?B?WXRCSTZsQzRxMnV2RnZ3SC9GMUhtN1oydnBPbTk0dnZHN2VKa2dmSjhHaTJq?=
 =?utf-8?B?NGNvQ2hFaHRyMDNDVHQ1OUxhV3NKc1RkTVc4ZC9GeFJ1dkdiMjQxK2plQ2FM?=
 =?utf-8?B?YlJiYXY3MGFXUzdUdXBpWWRjL1lTRWNPK252RTVTYnJwMzdzTlNOb2h6V2pn?=
 =?utf-8?B?aUJoenZ6dmdiaC8wR1dVOFcxcmxHVHdHZmtCSzM2L0NVbURVNEN6clFvcGpF?=
 =?utf-8?B?Z1FjLzJFWWtuNlEwL1Q4a3lyODRxaEd3b0Z0Y1FmQTQxMlNmT1FXR01SbXR1?=
 =?utf-8?B?U2t6QmE1aHBSY1RiNm0wN3lVWDlldGVuWDNQT3Zic3ZUZm8wQnlXM3FhUTZ6?=
 =?utf-8?B?bHpMMG5PNVdCTHo4U1lzN3EwSnlPdklIaWNVeGZNWDI2RDZ1d2JmSzU5OEhj?=
 =?utf-8?B?d0VhemYzUDAya29NWDRkdjJoYzl2Qy9VOUNza3hiSGRraVdXVjY3MElqRjU3?=
 =?utf-8?B?QmxBY2dwd25pVmphS0J5Tmh6ajBiMGpra3dNem9qMzhkZ0U4dUp1aHRDZHVC?=
 =?utf-8?B?aEc0WWhnZGVIMXBpL0RCSXdwOFQ5RzRyNHlISVBUUUVueFY3Z2NXME9JMzlQ?=
 =?utf-8?B?b3BNYzA1dlg2THdvUHljVkk5OTdMNFd5SnJLTTJWR1JoVkJEdHdyRXBqd0oy?=
 =?utf-8?B?dzc0dkVKN3lTYjUxeWYycnZSWGJVT1ZHNXRsdkNNQmNpVk1UY2JMNUxmU3N0?=
 =?utf-8?B?R1NXTWt6TzJNMGpJLzFvQ2VEU3JDQkR4d2ZQa1VycHpBSC95MzNtZlExdnBS?=
 =?utf-8?B?QXVkcEF0SEJkTk9QeFZvM0ZYNXVvUWZsWmlyR2l4dWk2Sk41ckplZzhLS1RZ?=
 =?utf-8?B?T2VFU1c1MGZDdW9MQUlZNUJEb2doZWpuZlNhTkZQRTgvZ3g4REhIS2M2aUx1?=
 =?utf-8?Q?/bkwLMr8rFb4Q9PD2s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a41ea29-8bbf-4b04-b252-08df49433a65
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:22:00.2951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +E6cpV/B7zWZvYKTg9JB9xcQeIMFhEQEsA5S5YoNy6hMUml3q59v9GVAJJDqDp/F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9797

On 11/22/26 18:55, David Hildenbrand (Arm) wrote:
> GUP rejects VM_IO and VM_PFNMAP mappings early. __access_remote_vm() then
> falls back to vm_ops->access without checking VMA permissions and without
> limiting the request to the VMA size.
> 
> Consequently, /proc/<pid>/mem can bypass protections even without
> FOLL_FORCE, or cross into another mapping without checking its
> permissions.
> 
> Check VMA permissions before calling ->access and limit each request to
> the current VMA. Implement access permission checks similar to GUP,
> however:
> 
>  (1) Reject writes to CoW mappings because the callbacks access backing
>      memory directly and cannot handle CoW.
>  (2) Allow forced writes to non-CoW mappings with VM_MAYWRITE.
>  (3) Allow reads of write-only mappings, as we historically did. Most
>      architectures cannot express write-only mappings in page tables
>      anyway, and i915 selftests rely on it.
> 
> This intentionally breaks forced writes through legacy amdgpu PROT_NONE,
> MAP_PRIVATE debugger mappings. The workaround in commit fa5239f2af98
> ("drm/amdgpu: workaround failed COW checks for Thunk VMAs") cleared
> VM_MAYWRITE to avoid CoW, but debugger writes still succeeded by
> exploiting the missing access-permission checks fixed here. Reads remain
> supported. Userspace must use MAP_SHARED instead; ROCm 5.5.0, released
> in May 2023, already does so.
> 
> Similarly, forced writes to MAP_SHARED mappings of files opened read-only
> (e.g., read-only DMA-bufs) no longer succeed, as VM_MAYWRITE is not set.
> Writing to read-only files through ptrace was never intended to work,
> and would usually be a security bug.
> 
> If this turns out to break real users that cannot easily satisfy their
> debugging needs differently, we can figure out how to handle that.
> 
> Link: https://github.com/ROCm/ROCT-Thunk-Interface/commit/fea44fab6e84eda52fcf6b419b35600c18f4c022
> Fixes: 272ddc8b3735 ("proc: don't use FOLL_FORCE for reading cmdline and environment")
> Cc: stable@vger.kernel.org
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Reported-by: Chris Mason <mason@kernel.org>
> Acked-by: Felix Kuehling <felix.kuehling@amd.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  mm/memory.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 5d0d58aeff3cb..d43837623a063 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -7412,6 +7412,7 @@ EXPORT_SYMBOL_GPL(generic_access_phys);
>  static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
>  			      void *buf, int len, unsigned int gup_flags)
>  {
> +	const bool force = gup_flags & FOLL_FORCE;
>  	void *old_buf = buf;
>  	int write = gup_flags & FOLL_WRITE;
>  
> @@ -7451,15 +7452,36 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
>  			if (gup_flags & FOLL_ANON)
>  				break;
>  
> +			/*
> +			 * In contrast to GUP, we historically allowed
> +			 * FOLL_FORCE write access to non-CoW mappings and
> +			 * read access to write-only mappings. However, we
> +			 * must always reject writes to CoW mappings as we
> +			 * cannot CoW here.
> +			 */
> +			if (write) {
> +				if (!vma_test(vma, VMA_MAYWRITE_BIT))
> +					break;
> +				if (!vma_test(vma, VMA_WRITE_BIT) && !force)
> +					break;
> +				if (vma_is_cow_mapping(vma))
> +					break;
> +			} else if (!vma_test_any(vma, VMA_READ_BIT, VMA_WRITE_BIT)) {
> +				if (!force || !vma_test(vma, VMA_MAYREAD_BIT))
> +					break;
> +			}
> +
>  			/*
>  			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
>  			 * we can access using slightly different code.
>  			 */
>  			bytes = 0;
>  #ifdef CONFIG_HAVE_IOREMAP_PROT
> -			if (vma->vm_ops && vma->vm_ops->access)
> +			if (vma->vm_ops && vma->vm_ops->access) {
> +				bytes = min_t(unsigned long, len, vma->vm_end - addr);
>  				bytes = vma->vm_ops->access(vma, addr, buf,
> -							    len, write);
> +							    bytes, write);
> +			}
>  #endif
>  			if (bytes <= 0)
>  				break;
> 

