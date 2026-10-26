Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793057311;
	b=LmSS5qGNcf4jH52jTp4VMXga2coGophSovMeTIpaThwyjwYxNYfsXDIAb8rcqcBuU5qx
	 HDPzpNBkYRTMZKuKgZszmELS8stIkEb3zDozlkAfCQOMzTQmFI7+ouo+Vz5Da8oz/jK20
	 mG50ZicHBvvbqKRMx7b7qyZ+TFfp3g0nJ3h4Hjagv3BKxcqHe7389HTZyES3Xrg6zO8Ot
	 yDIi+96M5Xpm0GgEvUTBq8dNUwALk6B6Rbow8tTZdYZrjPuaWMRCd6leGW02F5yC7jldL
	 /1bsOjLLbev5w9JuQajz7gOe0k3F20LNHpxvt9tZ0xfU2IDHnSVhx6TLylZMyXFFoig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057311;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:X-Mailer:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-MS-Reactions:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=0IDwwo08Ui6ELPjZti1Uf9wOJHM64ZNc05F8Hlz3zvE=;
	b=uJiQxVaSi2nZvHXa8m1jyXWAP620UPveyQRUlYcfLX2lRElqkfh7JhvI+dgj0Qsla7R3
	 LeexbLAeCSITS5MfyTeASs43WMHgYpL38bX3O8sVGe3zLbg7Pvyt+u/CqtjB5LS5OnXpE
	 AiqiHn60Njcfq/IQh2Wse+smwXvAjTsFOcBzSE2XCyejmIJX1gUaB0OzBKf97sVnkHTEV
	 8gTswK5L2sUvyRSz9s65hYoENdj3qg/VFv+qvjDTjHOUfcBosUxziWbRV3EKuZr1r7967
	 PiUQM67vHsEbcO+BasAQ1vYgFTISH2bWgLv9IG9hMXeV0taUMMzpHzLgv3u9vx6fXkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UHVEcdZa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.12
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011012.outbound.protection.outlook.com [52.101.57.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6125F606A31B;
	Mon, 26 Oct 2026 23:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6125F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UHVEcdZa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3/FD0kEgPJV7qI6E3DQp4otfhAY85YUZNHlKclgOV4h2tqYbBygrFWAZlMVlZgUX9cu8CuDLIeRA5Xcdy0blsJMBt9J1ALjm0HwQgg8v4KSciW7MTbaGjseNvZJTrs7cL8WOIv75UPDnUyM8COzNfAIc1sI1zAdNhL0i2hijfI+RNiNbuaGr9cOvSjF3uXWGzCH+j7UQES7Vus5GOjC57Q1UZ2N1wUS/D0kv/AJ1DqTzjz3wHrOnvScsbOVXQEjhvkPDspS0QOq69ff0F4g+NTtyncMPd+dOuU9kI0t+UUjlhUR6/6yr3UoWKuE7cYPz3Rte2LEnWRHzUxzK5y+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IDwwo08Ui6ELPjZti1Uf9wOJHM64ZNc05F8Hlz3zvE=;
 b=AgARSlK+GVnLTo3LrmWzNRexQ63aNi8pDfUOaAF9PPxT7tR6mnT3yD0Lt8YjO9rDIGo87ZeDUoK4PzXfj2ynl/c3du5zDAjNVgFahomzHaAYNyeCxq8SYkxj1A1mBeX3siMtGHyw8EbBLzQA+bug1yMcZIJGb/LzdXA0+tf69jLkiGd/JjIxp5H1u2V6GDiR1acEpXmKTICG5XGomz0P4Xlyg0jCAcYuP7ukAI2ASJJ21iHGFBqSMJ5ppoQXxjTJaLVYDRfLJYM8ob5UrW4WPfXfrvM4iXQ9KuZx+vftFHSftEkc1yLrUbLuObT3v9ZlXaQH+dqHgKTuGA5ZfYLlbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IDwwo08Ui6ELPjZti1Uf9wOJHM64ZNc05F8Hlz3zvE=;
 b=UHVEcdZa42iQMlFSpAE6wNBRcQkZKVjVfnsb+iNTfXcr6oUEhDmf8ggboXwrB+l/igfhPZ+orTaBNzsMqR/4QkNyGN6ReAP97neaxKRXXMqDDu5HTTMp4NjLMPwiwLEfpAdPOzJ5WCBB53iLLTNdNEJX/ipVEcgm+TimFy99+SzGxv55pET0wxg14puUPXNg5QqOmDIB2K/hBY2TU6OLjTrcexDqoY+bE3TxwrvrUzMreYF/EHzwweSmUZATrAuUBHZsQ+a9jvZ+DZUUUS2tfT61cbCik0yrcMAjIx7l9EAcOFs2k6DWtrnTZ5YkYo+SCcHfKtEoNFlc6ND9VoO4Bw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by IA4PR12MB9761.namprd12.prod.outlook.com (2603:10b6:208:550::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 23:28:28 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 23:28:28 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Zhang Yi <yi.zhang@huaweicloud.com>, Gregory Price <gourry@gourry.net>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Stevens <stevensd@chromium.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 William Kucharski <william.kucharski@oracle.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chris Mason <mason@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH 07/16] mm/shmem: avoid moving the truncation start
 backwards
Date: Mon, 26 Oct 2026 19:28:25 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <FA2807F3-66EC-4EAE-864E-BB1DE436A1A2@nvidia.com>
In-Reply-To: <f0029758-5f2e-4c26-9b25-dbc4b3f33701@kernel.org>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-7-703206d5fa0c@kernel.org>
 <2E377C76-D62C-4A2A-94E3-ABC40C6FCDD2@nvidia.com>
 <583728ed-dc63-4685-9ac5-5a980db55973@kernel.org>
 <B1241F56-8000-411D-A137-24596E599C85@nvidia.com>
 <0D22B04E-5730-4D3A-ADA6-9F1AF94F06AA@nvidia.com>
 <f0029758-5f2e-4c26-9b25-dbc4b3f33701@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MS-Reactions: disallow
X-ClientProxiedBy: BN9PR03CA0437.namprd03.prod.outlook.com
 (2603:10b6:408:113::22) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|IA4PR12MB9761:EE_
X-MS-Office365-Filtering-Correlation-Id: ed99e851-55e1-410c-1c6f-08df33b8d6db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|261026140227099003|4143699003|11063799006|56012099006|261022075727099003|261021121427099003|261022105027099003|10067099003|261009223027099003|22082099003|261026121527099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NYhO6iGEim2/VdZE/ksunZVJtcBej+awTiKBFqmShiR3kilxA+HqJceSW99e9F9MOG4YD5YSbXARjb7K+23bvJ4jwl7kKcn+mq/6NtN8lWbvaUuEzOKAi+GY7tQQ0sLtkxs25LSaBL7HTqHXdLIx3QOwIG9uGpuR5wh8f7C8q+vcnwmzn2J11jysdgDG8XHOS5A2VlK2hWEglsPGJZpxzhOJv+3AbU061pf8PT4zp9/856xxcGcKwZhEzQUiW+/rTkYcnP6IgTsotiMpYf2lPTiwR5DsPHmWHF1HbAMpSKVQWQfNnYQM+Ea6RppwUXY4hqf3ABb6U6LPY2x0Rs+CErZNWTFZS2XWODapCKU0r5F+3/JZUtXUOqXnhvP+0b6uue1aNIMslSD6anQuVu6/h9COx7aie1/yR7tb+U8TiRpojJR/24AI8zY+gkMhfjN8ZCuQ7hZ80tvFaOlnuivENhL8trWxdRwyOBttyObKMBk8h9iukAXQosKranl4erLCPYa20G1ijA6XrHU+Cnoxl9jNg6r9Gy7umV6bdaOzvrxzJEv9UHcAuXuybuvItFjbD7UUNTwRE14YBaMQp+LGHTZjFL/lrfIYnyti+6gHkmBJ/1YYBqv/4tTscX0fgPmLBY2x+8hSRYGO2kYEbaZjC+aHPXt1CJBSQdadmt7vB20=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(261026140227099003)(4143699003)(11063799006)(56012099006)(261022075727099003)(261021121427099003)(261022105027099003)(10067099003)(261009223027099003)(22082099003)(261026121527099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVZqWXkyNXptN05SR2lxc3NoTklXS1hQdUZDcHNMNXdDWFJLYWxpSTNwMmEy?=
 =?utf-8?B?RHJtZFowWW1UMVRDL2ZrVk5NYkJXaTVlM3JBcmlrYU0yQ0NYRDBsN3RHUUNz?=
 =?utf-8?B?bVRta2JEbnQ5ZTRXQkpodzBNdmlYVFJ5UUNTcHZlUGUrT05JemJOcCtJU0ww?=
 =?utf-8?B?c1pBQ2tHc2FLWFNOMXkzZkxGT1RLVFhTWU1SaGhSVEFtempYcHliV01hbW56?=
 =?utf-8?B?aSs1WDg3VThKNitHVTBmUVVBaVNJUWJZeHFRUlVnWVNUMUYyYkxuWWdGUFQ0?=
 =?utf-8?B?QW1sNzdCV2MvQkdTdUtBczdpTm45SkNaY0djNE5LOUNPbDZDVXZMZTNiL2xV?=
 =?utf-8?B?Z29saHprWnE1blMvZjVlV0k0cXRnaTFmWkwxM3o5Ni9oa01sYzFzdjU4Vnp6?=
 =?utf-8?B?YTRnRVRpQjRkM2xDVm0rOXdaV29BOVNQZGVoQTdNUWZuWjUxU1Nqb3JGZzJr?=
 =?utf-8?B?cVRCT3NZalBWclZxanUvNEhyQUJncWlieDRXM202MUhXbTNZM2swNTlxRk9E?=
 =?utf-8?B?a2J3NWM1UWUyZ2pNRDJNaFU3TEJKbUxCV0lFVUhlbnBhK0YyekhMS0NTVGZK?=
 =?utf-8?B?UGVpTTNSSnE5dXJEam53THhPZGV2NVZsYTd4N3JRdGsvT1dHenNjSktRNEd1?=
 =?utf-8?B?a0tWVldqZktLRFFrU2xBeERtL1hRb3l3TWoyU3pIQlVoTU1PcU5GY1BpSU9h?=
 =?utf-8?B?OWZIYXRZaWQzWjVkTGtzU2ZlUnVzbnpBRUhBR1kvNFM0anVJdkRVc051eEtG?=
 =?utf-8?B?ejhIa1JuMUFnQ3NUYlJLWHNKQXpaZjQ4N2hpdWtyR3U3Zi9Nd25xZFNSZDh6?=
 =?utf-8?B?bTRia2dmT1FoT0g5RHFsM0hYWFFzeG1OL2R3REMwUGhsaUdpeXFQeWh6b05j?=
 =?utf-8?B?V3htMExJMVpPejFkNVlETFRlM1E1VzlnMGoxYUdSNVhoWnRDUDJLa3cxUGtU?=
 =?utf-8?B?RHZSejdic0lCcHJnTytoaGhEQ0NYYUlQaExBL3ZJMXNZRnJHWGpOdFZMRUJr?=
 =?utf-8?B?VWFBbXNxVnE0ZmFhVzExL2NnWDZyUlZzbllGdGdRSUo5NzRmM0xBWXEyTDV0?=
 =?utf-8?B?L213WG9PNG0wcCt2amZQeXVSZDF0b3pjQnk4VzJ1VS84ejFvRTM4YlBKNzd4?=
 =?utf-8?B?SHNpRkVEMnZWL3N2UDhRYU1ZTi81eEF0N0V6K2ZoeXpiVE9yUVNaZXNEZEwz?=
 =?utf-8?B?ZWJ4cVdnUFhmWll4a2pNL1FMZ1BpS002cHUzTHh0Q0QxNFVwRVhWK0dYNzJB?=
 =?utf-8?B?eWU4MXo3cGNjb1lMNjZIZ3dzL0x2QjVkdGtMTmJ2cTF5SG41Zng1M2FueWpC?=
 =?utf-8?B?RnNtM1NLT3NMMzZYbjd3VmJ6MXgvK0pUVVkweksrR0x5WDF4SXFCQVlDeGND?=
 =?utf-8?B?eVJ1WXN0Y1VqazJYOEY1THJBR3ZLVm9sb2treFFRLzc3MnBHd0RBeFVzdjl2?=
 =?utf-8?B?aXcrV3NXR2hXMHdlTnVuZlY0WU9JdTdWd2RZdGdQL25tUVIwWEhoZkhDK1lO?=
 =?utf-8?B?NWZwVlBKQy9iUnY0L25odC9uZm9PMEZGbmZOdGVuRUs1cC9IZUM5U3doYjU2?=
 =?utf-8?B?U2lLOE9xK2MxZjlDK2txNVVrdFFPaktLMmM5NGY1eHNNNVh0WGkwV3lBMVkv?=
 =?utf-8?B?cmlYWUgzWms4VVhyaHRaNi93T3V2WEwzVDBITUhCRkRaMWR5aEdLZnRiL3ZB?=
 =?utf-8?B?bjRkUGdRZlgxWkVXUU11T09UVTdEMExSQWEvKzFQVWYwRTVxUWFaOCtsSGJx?=
 =?utf-8?B?YUlJQVJrMll5WVRmV05qTllUMVlZNHM2ZURycVZ3QXhJWFZTYWFUSkJRUmRq?=
 =?utf-8?B?U2Z4SmVqSHRhdGVrOTRhaGZqby9RU3h6ZnNQdmlrdDRTV3dvSG9EakdxSUJm?=
 =?utf-8?B?T0NHN0xDN0dkcTZyYWl1RjZtMXlhUUN3SGg0OXExbnRqWERiSGNPQzhSSkE4?=
 =?utf-8?B?QUhUWGxSK3dpNXl6d3VVanVON2N3MmtHeG1mYjUyamtodDVwT1psTXFKSEsy?=
 =?utf-8?B?clBva3l1bHF0RGtKcVgvN0FiQjdINnRna1FsbFZSY0t4WGVKd00wNmNNNEMy?=
 =?utf-8?B?bDltbTZaakxJRTdhbkdhd1o3YStnVFV1VXZCSGhkdkh5SjBncUVPM1crc1p5?=
 =?utf-8?B?L1Y4Mk0vYkdmNlBqdVgwN3E5UzU2d1gwMEloS3ZML3FMZTRucTN5WkRzaDgv?=
 =?utf-8?B?eUZhMkJIcTk0MHRTeXMvdDg4T3F1U0xQSStTaFJIMERzMFAxd0pqVFNXYW9o?=
 =?utf-8?B?cFR4UUNrUk1QRk5BMzY1UTN5RWUxL01mRGNnbzRTa0EyZlhQY29ScFRNbDlh?=
 =?utf-8?B?dUx2aGdHOWl4Q1U1Z0dnUnF5TndjdWVKYyt0RGs1b1JyRSsvQWM1QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed99e851-55e1-410c-1c6f-08df33b8d6db
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 23:28:28.2422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30dWDx4TCFwBmEjG0MIzikHl5WTAla7iBb4YOuToJc3Zu7jFkg/+FJ51hlCZaKEy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9761

On 26 Oct 2026, at 19:24, David Hildenbrand (Arm) wrote:

> On 10/27/26 00:16, Zi Yan wrote:
>> On 26 Oct 2026, at 18:39, Zi Yan wrote:
>>
>>> On 26 Oct 2026, at 17:13, David Hildenbrand (Arm) wrote:
>>>
>>>>
>>>> How confident are we that it fixes the same issue?
>>>
>>> The issue here is that folio_next_index(folio) used in the mainline
>>> code can be an index lower than lstart and the fix is use max()
>>> to prevent start going backwards. (I wrote this to make sure
>>> I understand the issue correctly)
>>>
>>> Zhang Yi’s patch passes start into truncate_inode_parital_folio(),
>>> which has a new signature, and it is updated with the folio’s index
>>> within the [lstart, lend] range at the beginning.
>>>
>>> So this patch fixes the issue at the caller and Zhang Yi’s patch
>>> fixes the issue inside truncate_inode_partial_folio().
>>>
>>>>
>>>> Does it also cover #8?
>>>
>>> No, patch 8 is still needed. I am checking it on how to rebase it
>>> on mm-stable.
>>>
>>> Patch 9, 10, 11 might need rebase on mm-stable too.
>>>
>>> Since these patches are on top of mainline instead of mm-stable,
>>> you will need to rebase them. IIRC, Zhang Yi’s patches are needed
>>> for ext4 + iomap buffered I/O conversion. Hmm, but Zhang Yi’s
>>> ext4 iomap patches has landed in mainline but its dependency
>>> is not. So we cannot drop Zhang Yi’s patches and ask for a
>>> resend. Adding Zhang Yi here.
>>
>> To clarify the dependency, without Zhang Yi’s
>> truncate_inode_partial_folio() patchset, the ext4 + iomap changes
>> would cause data loss. We probably want to get Zhang Yi’s patches
>> in first to avoid that.
>
> Ugh, what a mess.
>
>>
>> Patch 7 to 11 do not apply cleanly on top of mm-stable due to Zhang Yi’s
>> truncate fix, where
>>
>> 1. patch 7 can be dropped as I discussed above,
>> 2. patch 8 needs a folio->mapping guard for the added statement,
>> 3. patch 9-11 can be applied with fuzzy, but I need to look into
>> them about functionalities before fully trust what LLM says.
> Yeah, let me take a look tomorrow.

I will reply to these patches individually in terms of rebasing on
top of mm-stable and how they interact with Zhang Yi’s changes.
It is not too bad at first look.

>
> I cannot put into words how much this shmem + pagecache shite annoys me.
>
> What a piece of crap people created here. And looking at the massive changes to
> fix stuff, what a piece of crap people are creating.
>
> I better go to sleep now :)

Good night. :)

Best Regards,
Yan, Zi
