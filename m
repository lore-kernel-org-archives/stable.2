Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793156322;
	b=01vCk2l9CvPum4QRkqnFOZx3TNtvf3pZEv+0OS0cJxuG1v1NUylbLBe7SVQS8VgyIXDV
	 sNRh/uZtZh6rFwellA0P/zmVWv68eAaRfQsdWcYEEVQSHqeozqzWk3jLyYf9A0RTAMV1H
	 OsSs7Ji0sALcBkaQ97ud53SFAtb/fZv6v36Vf8mhKOmjTC478G/0B+/VqTxFHBXfISHaf
	 duEiY4LtD9qE66Wk+KwoDl+pn4mWK7BUIAXsArv+vOfilV2iAULl760xdj+aflBlUsekz
	 DRpWGDhrXTlnK0WdGTC8nkfCxqCLuzOyQ0U9avKwhaWW3wH0Zw0tT4c5o9CvFfVENtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156322;
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
	bh=70+ae3ZTqtj1+07muayYl3ANIB+dyOWYDBZ5+RJCHYs=;
	b=OED74frYz+KjVh0h0h6jBqIHJY9yXn+mo5a9Som3dMbYhKin6AQl4VwyVOuML2A5FJjE
	 KbeQvQJo9xIf9VdKG/+gClZhMfcUs3uZ4r663uuywlHD+vzfV+dCZEw50+zF1Riy2gfPO
	 OOjBaFkW1zMhizMFCh14oeZN4mFO2GWYo9NnmZbQ4XUPs3klwxsq3JkRkA7t8W1z/9UCg
	 8HapUDFBWUvWh9oBMkhdRoA3pSDYXVOL8XypHEPgmEQciyiDOWMglYDAKZyo7PAY15GK8
	 +v2nGSrtGZakJ6YgLTybk2vuQbw38z14qCfU7/jUmkOi4YsfKxdCaUfdPzr2/V23nJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HZUJT375;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.70
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010070.outbound.protection.outlook.com [40.93.198.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C6606A31A;
	Wed, 28 Oct 2026 02:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D83C6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HZUJT375
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxkpL9B2OJrBuU388imPmmPuuXNOqaciLWhgvSkeDv3iNPSeTaDwKTXLYYTbchoQZfIFjaXnJL17JT9+tyRzyM1WBmHv5swwyidIUWtPuvu4P2cJkhqcfNHvKNlGT/DNQZbKfaj/SQMP+DDriUh0Nid4fP3Rthn8ccoqUIq+bbD6IBgQJaO/evVbe1HZgPu6I1dZofSrkJqCo+JFD97uEyjSzSdsatAhelh4Qqe6TZwWaGy/ECJxwqG9oNd5K995HJ5YGvhG/EKngGH7P4OY8HKWW5virxa0UMQwiCFs8n/KCZc/k5ku6sxV0k0ZChHfAT0hcit/0ZbEh58DKJ2+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70+ae3ZTqtj1+07muayYl3ANIB+dyOWYDBZ5+RJCHYs=;
 b=NwFAtlQ1KDLnYi/zSlcDXnvGiVhKnp8KwAHvV/QGayYFh102vSmQWqQ5V8Les5u0L90hJqhNHgCUGYwAwSPyIKV0xwWmZyI0jxRMbBr0qcjMy8o85B5EDdjXA9Phsb9Ipw5YIpg8V4UIeM4QeteQMqVNjLUXJkDODXLTkPg2zlPPvstr9bqwL64XDT2orEa8hOWco7op7ASdzvFFY/OgvPcMncJmOAnWH6lOacWYSIcq3hvZ7SrtGBQdBpuSSDxPji5PunB18b3WRzUL/QaWJ2+WjkUhmprED7QrGlJ6O5KZkhFEY5w59F2xdMzyHJ7j9tO10Ny7gtnPK2jdSujGUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70+ae3ZTqtj1+07muayYl3ANIB+dyOWYDBZ5+RJCHYs=;
 b=HZUJT375SpdVAF7Sp9FPnfiCDV9dEWNoMq3y8My/RrO/kwzjh2ji0fwylBheC/blH4oLA+2wqy+58cOL4nIsJVR9UEyFQq5vf6qozzyO2BoA8WtX21lNXE+4GYMTULUlw+NEUFliTdIMqY2cAQQ1DsdQLaZoYvAKBX4ya9ZE7hsCLv43lUXOIbbJaC8+rG3/uurvPM7gwnwxu1O4qtUK6hxAuJnFvO9l0WwCGywcP9h/0VIdK5mXoPl0f5qvkNNXW0Qi3ea+Mt6Lm/aqVC0IamDWgd4K1gmnyB4z5XkCxiP5gcBSG8ORfvaPAT0Aue2tJ6clppftcFmEkAMGrdzH7Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 02:58:32 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 02:58:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 22:58:30 -0400
Message-Id: <DMG4V0W8WUGW.31QWJYW2A4Q1X@nvidia.com>
Subject: Re: [PATCH 14/46] mm/huge_memory: fix zapping migration entries for
 device-private THPs
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-arch@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Chris Mason"
 <mason@kernel.org>, <stable@vger.kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Michal Hocko" <mhocko@kernel.org>, "Qi Zheng" <qi.zheng@linux.dev>,
 "Shakeel Butt" <shakeel.butt@linux.dev>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Kairui Song" <kasong@tencent.com>, "Barry Song"
 <baohua@kernel.org>, "Axel Rasmussen" <axelrasmussen@google.com>, "Yuanchu
 Xie" <yuanchu@google.com>, "Wei Xu" <weixugc@google.com>, "Baoquan He"
 <baoquan.he@linux.dev>, "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Kees
 Cook" <kees@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Jann
 Horn" <jannh@google.com>, "Pedro Falcato" <pfalcato@suse.de>, "Hugh
 Dickins" <hughd@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>,
 "Pratyush Yadav" <pratyush@kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, "Jan Kara" <jack@suse.cz>, "Lance Yang"
 <lance.yang@linux.dev>, "Rik van Riel" <riel@surriel.com>, "Harry Yoo"
 <harry@kernel.org>, "Alistair Popple" <apopple@nvidia.com>, "Nico Pache"
 <nico.pache@linux.dev>, "Ryan Roberts" <ryan.roberts@arm.com>, "Dev Jain"
 <dev.jain@arm.com>, "Usama Arif" <usama.arif@linux.dev>, "Kiryl Shutsemau"
 <kas@kernel.org>, "Matthew Brost" <matthew.brost@intel.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Peter Xu" <peterx@redhat.com>, "Will Deacon"
 <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Nick
 Piggin" <npiggin@gmail.com>, "Oscar Salvador" <osalvador@suse.de>, "Minchan
 Kim" <minchan@kernel.org>, "Muchun Song" <muchun.song@linux.dev>, "Xu Xin"
 <xu.xin@linux.dev>, "Chengming Zhou" <chengming.zhou@linux.dev>, "Chris Li"
 <chrisl@kernel.org>, "Kemeng Shi" <shikemeng@huaweicloud.com>, "Nhat Pham"
 <nphamcs@gmail.com>, "Youngjun Park" <youngjun.park@lge.com>, "Gregory
 Price" <gourry@gourry.net>, "Joshua Hahn" <joshua.hahnjy@gmail.com>, "Rakie
 Kim" <rakie.kim@sk.com>, "Ying Huang" <ying.huang@linux.alibaba.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-14-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-14-6f74bec9a5bb@kernel.org>
X-ClientProxiedBy: MN0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:208:52f::22) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: c6663443-d9fc-4b67-c97e-08df349f59d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|921020|4143699003|11063799006|10067099003|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	xESxOB2XQxZz/eM+nB9DvC/xPJefH+YtO7mibdKFnWCiTzc2jXvn/RrXUhWKk7YkvKBv06z8gHfovoel6XKsmpWOEdEwb0UrROjujvQ/36I4FeWcSBcsqj0KAjhvQ3mrRim8tWT9ZzzyZc7Dc+bwq/2w9VN4gItpSFCq5YYeDrTxZ37LnFO6ZATeXSzdVTn47DGRPK5MY7/Y14uyHIXMzzotLdd5Lxf67JnBDZL/eMAMoQ5Nfv9jZnaW8SK6lhSBvSluPzHuub5AqwrzduXrLfbqE1oLCGlK9wKeKSfIdxcfczfxGA+2z1Et1e+iZmPR5Y0/q2cYl9yU7iDBLoxdYb/eUHCTU3DnqVbm9vBbgGBz+cr5fH+It4TojB0UbDQtXBdXEyrTbVPVim2HllR+YIgRbwCa0pnn3mBBGwzx7E0qscciqKpubpmMpTOqd7dpUCeFq/2NMIPBRLmzhtbPWFu8vMajN+Q1yso0HPbGhp4gTd5GeYFrbzdgBGBst5ohR5G2TQ7eGy8qKU0/9KMwYFW9oP3hb+PrY7yxdC2vrO0gC7jBxMVmnnkdGlwpKBQLY9f4Lbx623EQJTG3I+Ft1ux5soCVirMsgTIB/UIIGg6qLragBMN+vXi1Ma5S0WwhgX5EheX1VEJ52R2cveEC+Bv6nLpGX/ZpJdYdMYfYIqAJWMCsk80I5dJFyOL5sovxMIYe3IO6Mt/xmAKamJAFSA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(921020)(4143699003)(11063799006)(10067099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHp3NHVXOEJvNVFaemhtQjgybDFNdVFPbVRNNytmTGE3MHJaQzgwbzBnY2Jy?=
 =?utf-8?B?NllmZmU5NFIzV0xhZEdZSm9Ibi9aeTM4OFMrMC9FVHJXVnE2NWsrMTJoeERX?=
 =?utf-8?B?MTdJNW1qRzdnVXhER3lOd05LcW1ydEllKzUxSzVWcnlSdzVidEdhYm9nMEFR?=
 =?utf-8?B?OWx0NVArYWY3alE0SCtMYlRROTRiTEZJM3Y5RUF2b2ZtVkVQL092UWtzNHA3?=
 =?utf-8?B?Vm9GY2RHZUtweFpMMXNjMWtmczNrZzllMXExSlVBUjFXODRLTlNpVy9EMnlH?=
 =?utf-8?B?bXJOSUgxR25mb24zaVBIenF6TzYvZzlIdDlPVHhZTkQvWTdQMm1xSFF0Q2Ex?=
 =?utf-8?B?K0ZjODE0Qnk2MjlJOVdTMk5wcUhLNStWenNUL3hscnNSekdXeksxTVlmSmxu?=
 =?utf-8?B?WGZsUTQ1MjJDQVNieHY0cENkWk5ZaXB5amZNMGh4OEFPS3FscWMrcStWdjdZ?=
 =?utf-8?B?OXltdTZtVm9BQThWV21CL2crY2JydUptN21XMUdkckp3Zld6eWc0eVNLUnlx?=
 =?utf-8?B?L3JpT3hTTmJjYmdkWURhNEQ4cDYxZE1nMWhYdnpYK0EzbGJxdkdNeHNUcDhm?=
 =?utf-8?B?Zk5xVVFUVFFFbjdQV01OdVhUU2xRbzNTY3IwdVlFZE1HVjBROUxiWXdqVWpp?=
 =?utf-8?B?WWlxWEIrSXZvU2dSZnlFWTNlR1g3OUtNdUZ5ZVByV21iWXpqVnlLc3hOWkRM?=
 =?utf-8?B?Q0JvWDU1cUZIMTVZNXduME5SYkNEUXdiY25EVmFMZk5wOEVUMFpoaWQvVDBi?=
 =?utf-8?B?eWxzWmF2RytoZ1NVbTBVUHBCWHI0THdKVmFCb2Zkdy9Ic0laZXdVdVBxK3hF?=
 =?utf-8?B?aFdEVTloMXcrM3EvYUgxbDNlU0RIaDZZT3lndWR2Y25DQnVweWpEczRpbW1R?=
 =?utf-8?B?YVVlckZkcTJLdmtnbnJlWklSdVZ6bFNULzhPdEdYaWhlaWxOZ3daMXpSWEJD?=
 =?utf-8?B?ZW54UUdPVExPK0w3Q3FpTGF4UmV3cW9wUWVxckFaRTFXYkU0TzhXWkx3akR3?=
 =?utf-8?B?OWlTVytINFMwTlZld3ZiT3hMT0F0UHN0bHlkQS9PVWViTGNDR1NPeVVVMlJ1?=
 =?utf-8?B?RjB0SUNMMTVMK2lRNS9BajRDQlEvcm93djBkZ3VicUM1QnJZV2ZBTU42TUZ1?=
 =?utf-8?B?aW1DS1d2dlR6RGhidEIzdzFlVnlWaXhncDJZczFzTlE4RVZRN3hPQ1hia1Ro?=
 =?utf-8?B?RFBwNm5jcSthdFk1bVZTWmxtMFlLR0lkU0FXZytROVN0Y0toTysyUEtGOHJm?=
 =?utf-8?B?eEM0MUF5TU5ub2RwVUF6SHRFS2VoaWhPc093QnViRTVpS0pOdFBLcHRWSmlC?=
 =?utf-8?B?L3JFYmJ1Q1ArRkpZUDY1V21XMkQwMm9vZVNibW1TMnBhaXN1LzJXWjRnTjds?=
 =?utf-8?B?YzFoSlAvWjFnMnlvbmxPa2lGWEtOVlp3S1lKVGtYbEZhMDZvT0xJNi9DTTRE?=
 =?utf-8?B?UlB6K1hnSDJuNUc5bC90UExCMDRDT3hORTFJMG9IMnViSldLTm85dmNCdWFs?=
 =?utf-8?B?WmkyZWt2cGp4WUZQL0NUOUNqR015Rk05TkhQZ2ZvdDkzemY4UFNGNzhXd0tu?=
 =?utf-8?B?ZzA4V3gzem1TMmhxY2U1cDVvbGc5R002QzZrWnJsYkVZUjV3QWkyU3RIc1pq?=
 =?utf-8?B?Z3FVWlNrd1E1WmRtUzE0L2toUXFiam52Zy9YOU1HeEU2OFhtVDlSK0hMSWEr?=
 =?utf-8?B?UDB1bHlZcTR4SVRENjVTMHorNXhNanNjWDd4OE1UckFSeFJ0QnFYWFdWOXUw?=
 =?utf-8?B?Unl2RHJ3a3p3cncwOXRMejNFQ1k5bHl0dGZ0T2lvUExjQUY0Ny9iRUJCU21a?=
 =?utf-8?B?ZUgzL2NOUWRzYzVLYk5uZHhxa1VkOGJIUVc5WWtncFBES0ZrKzZORngzOUJB?=
 =?utf-8?B?T3I2M3d2d2lGSEs1SmhYVkwzV2dJSSsxekFRcGNhSWp0WWZLSmpSdWN3VVFp?=
 =?utf-8?B?RjhDei9EbG9FQ3AvVnFoQXRYOHRJTFFyeWl4c3UvRTk4dm9CTEJHOTN0b3lq?=
 =?utf-8?B?a0d5SE5sNkVrNjVFYzA3bm14c1ZQd3dGeFlLcmNZaUs5ZDZCNkR5UlVZdXJi?=
 =?utf-8?B?enhZd3huZVo4b0JUaFVBcGMySmw2eldzZnpFOGQvMmpyNmxSMk1jaC9MVXB2?=
 =?utf-8?B?UVBibW04OTNwSnRRSVpVSkIzRTdFcVAzZk9rNXVuOUdKVFpOOWIrdWhhODhr?=
 =?utf-8?B?ZXZMRlJ1TE1nZnU4azJocFM1cHZYeDdYTlFINW8yKy9TK2ZsRkJqcUZBeG5N?=
 =?utf-8?B?UkZRc0hONlJDRDFlN3RHZEFXS1NhWW83NmxXamhDL1BDRGk4Ym55VkFucmFP?=
 =?utf-8?Q?K2a7+abisiieuFtvEq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6663443-d9fc-4b67-c97e-08df349f59d5
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 02:58:32.2679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wk1su8W9IPs55MRRIgbk0V82MMl9tHWF7iAM3t5q1yKThc1ixgS5czsHLTkO5VY5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155

On Mon Oct 26, 2026 at 7:17 PM EDT, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
>
> A PMD migration entry can refer to a device-private folio.

Right, set_pmd_migration_entry() does that when a device private folio
is migrated back to system memory.

> zap_huge_pmd_folio() checks the folio type instead of the entry type,
> so it treats such a migration entry as a device-private entry.
>
> Installing the migration entry already removed the reverse mapping and
> dropped the mapping reference. Zapping it must not repeat those
> operations. Concurrent MADV_DONTNEED during migration back to system
> memory can trigger this.
>
> Check the PMD entry type using pmd_is_device_private_entry().
>
> Fix generated by an LLM and sent by Chris Mason in private.
>
> Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to P=
MD operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

