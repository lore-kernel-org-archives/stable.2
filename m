Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.159.15
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793359236;
	b=48IWOqUFBZjO7uVnHeuHcK7+1TWr6xSWeQfk239dvolzXUk6Ddd+fdPnvfYqDfSwc4di
	 2GN4gwD1EMmlDybq9LeyNN3+onS+xnDmX6T2By+CS2WccPmdjO4TEQx+q0ccsfSd+3weB
	 OWFh/oBlaiJ1o9htQrKUVnbAp+ZjLGUt8+xGVYn/cnE/aap2ni9tEf600dhfOESER03ai
	 UVK6raUjvLLsLz3R7JnuIvG/UEjHF489pEFImMLfaUeZkwGUWtn7qCnDZbekmuESGm1/m
	 U/C9E1phFBrqsqskvPLEDEWSQBFemrE7LIiuNmehoJUb3JNjJDq2YoUfh7YTjzk9AEg==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359236;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:Cc:Subject:To:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
	 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=y7wpYHLjKGx3KpabGWR5i3f71A7xPmnL8SoBAvXiK0w=;
	b=PBj6w/nSfnSbof8EEimesIpMoZZazCDMzYnaneCBi9ZEajTVzFqLie6H31iSjk/jpXhN
	 Ch7qlX+GjIgkux5dKYaeF6cd3Ow00auHkI06CMBB9EN2Yq4ZP6XSIO9tV9BzHPYPxqu9a
	 1Gn0F1dphD8nhS5Y/4fi3MLQNlM9qKghAgmAEfg4msnnl05D3tlAcEJOAwuWYwL66Ye09
	 wViWZHgxoLKQQFkdVPBb6zC1iElZIrJWw9EaaZt3sICpLzrzg/2Vdx6dph6pHGQ+fPs3Q
	 jbUnjZY95yRDfS6wgHt9xMCF4N8t4hcoiTeZvCdU0i8x/lZ3WMjZRnpf4341xoFGVJA==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=S5z6yRAu;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=S5z6yRAu;
	arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.159.15
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE16606A31C;
	Fri, 30 Oct 2026 11:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADE16606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=S5z6yRAu;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=S5z6yRAu
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Lzn575LYHWkLD4o2IeKrKLB0QCkDBW5LGtV5s0Ig3lUhz1wr2u/2WDz8kbOjJfOhkZ35H+FTHh96vXdEIoa62Xv60OFMXKjFnR+SY7L0XI1fkW2WIHUnCfV7H7Jq5ksdmO5SBHDVMgm2ovHMszUV08uoS8T0bbFBL2BDPFar9Tn5bW468TNyoWkc65NOdipmSmXnTmtNeWGvDsitkfcmSxTtfrz46AjZVkwxI4GDOv8MbQ0+VzCey9vH5L7b3V1AIvHZBolTpQQQ37SVuxpCcEepOiRIh8Lmew8oa4F07enAsFjT/shRcVIyTHSB4hIYdvySuoHgUDkkTFuDBwZKag==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7wpYHLjKGx3KpabGWR5i3f71A7xPmnL8SoBAvXiK0w=;
 b=S+3cqrKLrHuuR2V9yYaBqu5SeE9QxxHFYbcCq7C5XbICUsWPKjUfqIdeCNEmfGpDTCuzQefT91Mi8l+oJHzdNNhKqhbh+LPEfvgynj+U6ohCiqVnhapVEbQxW0TJmzc1DUVKJwrVWCRVl32JXsbLb4ayBHKm3W3Fuk0frHe9XIUQ02W4EX5W909Xz/q+cvgBaiL2Ucg5+uMKmoHuCvvbuTpnoz6IAnW346ojdUAmGvlxJsD0/Igb3wUF3hPutKhDwkExK5lpBqAIwXYymtsz1lnNdWfTrcZe/HxAVqsm/LrvxR7E0fUILFjqi0pGjQ3otRUT2Hegd3eOzYptAi/1Tg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7wpYHLjKGx3KpabGWR5i3f71A7xPmnL8SoBAvXiK0w=;
 b=S5z6yRAuzjDeI/agn8nD9ioogUh95dXJtZHzlEvnXdi2liFXCrwKRIO+9Jp6MiL5qCmHxtYqrjIXdBzdKnPQIRc6p1w/x5ImkSWRDFkc7lAxV0K2kOfUEDTRYda6asilDKeIZzBfTn0cPKd/+9YyDr9fTnmrEM7i30OpLNlhQ9w=
Received: from DU2PR04CA0251.eurprd04.prod.outlook.com (2603:10a6:10:28e::16)
 by GV1PR08MB8132.eurprd08.prod.outlook.com (2603:10a6:150:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 11:20:25 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::92) by DU2PR04CA0251.outlook.office365.com
 (2603:10a6:10:28e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 11:20:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Fri, 30 Oct 2026 11:20:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auXPFaoA5w4CY8/I8oUMzbgkeFZpOF5N5e+3+97CcWATOuc+ZkV/3qYlfrPSq46wCbLOHDGrs0EnJU6EAIrNMPEzO7VGMPoSPFm1x8uBsjRFx76t3HC4NXuJadsk0M8NKyZV4qWkBNk9GHEgEYyaqQmWrC5RFPxbT9t+af82yMgR4nqMHSmf3N5x9k5+yQxlzJxNk9Vx5Zl6If4P9aRpTrGm+cYF7u76T661zQineyz3sc2CQXaRJJmNhG44La6OTvJEv+neyDD4EiGMVyjt7Xve4ac8bdynwUJqRyLTj5h8sKWbPSuZMsoD67I42C4QkOF7nyK0wUQkZTzT2DaX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7wpYHLjKGx3KpabGWR5i3f71A7xPmnL8SoBAvXiK0w=;
 b=Bc1NbZvPRDBlxIwWoIpYXstqH9WmXDYyxccENBlXhnsu/IbBJwuOMTTbX/lY5tpYwbjEaRqah8YL20LxT0oWw6DagaS+2nJD9sxFeyB/OOi/mo/d8LLMR4SdsFSfGRIHmNhiIgnWY7kQmCMZgahysEqMTaG6PdBXuHIHCoTPsFnfMUXUIIAtolLtWkoFXwebbv8yqRnw5bchY5d3s6Mg9Ce+LBgn9W/f2I5zTMsffPypvc06B+2LiOILXA2R5e1YcecUK+5U6mdAQTFZmUlCNWcKd2wss+rUIDDp+NNMZoGKHma2jMxfLjfpF4v094e24WEgF7bkLsz6bdm720sdGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7wpYHLjKGx3KpabGWR5i3f71A7xPmnL8SoBAvXiK0w=;
 b=S5z6yRAuzjDeI/agn8nD9ioogUh95dXJtZHzlEvnXdi2liFXCrwKRIO+9Jp6MiL5qCmHxtYqrjIXdBzdKnPQIRc6p1w/x5ImkSWRDFkc7lAxV0K2kOfUEDTRYda6asilDKeIZzBfTn0cPKd/+9YyDr9fTnmrEM7i30OpLNlhQ9w=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV2PR08MB9229.eurprd08.prod.outlook.com (2603:10a6:150:d5::21)
 by DBBPR08MB5963.eurprd08.prod.outlook.com (2603:10a6:10:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 11:19:48 +0000
Received: from GV2PR08MB9229.eurprd08.prod.outlook.com
 ([fe80::4dea:4c1:9d33:db7f]) by GV2PR08MB9229.eurprd08.prod.outlook.com
 ([fe80::4dea:4c1:9d33:db7f%7]) with mapi id 15.21.0546.019; Fri, 30 Oct 2026
 11:19:46 +0000
Message-ID: <2f23dafc-43a5-47c9-a819-e696cda6fd44@arm.com>
Date: Fri, 30 Oct 2026 11:19:41 +0000
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Mani Tofigh <mt4022@columbia.edu>, Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v2 00/47] mm: various (urgent?) fixes
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>,
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0350.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::13) To GV2PR08MB9229.eurprd08.prod.outlook.com
 (2603:10a6:150:d5::21)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV2PR08MB9229:EE_|DBBPR08MB5963:EE_|DB1PEPF00050A01:EE_|GV1PR08MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e1b60a-0805-4783-302b-08df3677cb58
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|3023799007|22082099003|18002099003|921020|56012099006|11063799006|261026121527099003|261028144727099003|261022105027099003|10067099003|261026140227099003|261021121427099003|261009221727099003|261009221227099003|261009223027099003|261009223327099003|261009220027099003;
X-Microsoft-Antispam-Message-Info-Original:
 QoUcTrohFicWHpyiA5usRXSzY6BxmbD/H3W4YIGTj9+JhUj7iF7Iq5ZvE/iE3dcyT0fl2bnDW9HQm9PJuKyNLdLoQ6GvZNl6HHieCGEBHff8rNwXw1dzPp9YfUoSEYt9NOu4kYVHZcmSjEpKh3W3auv/bLuiOxOPvtkCaBvVtz0OiEYjmux8M3PK5zW57JLaAbkLo1AG1JyyWpJlnR7ba+vlv4WRc3UetoClFoE5SCaiJWv3FO7F8MIeqghjs4LsNzIz2xovhDcnwRufmdIb8ASoEjuMv7QPOprmbFlGfHMKVYvR4xohoYapdgOqw6A45fQxUX9ML9zbkQZrZB1q7+SZUCb4ttee1b6x0JV2cERD6g6AI7u21NGAIm7Q3jKw8YmolhAGm56DYF/xx1D3PneV7cA0mnCFA3dAoUKdZ6kJwe8mXc7nkqxBYKxhrqMaRuhwoiU7lEltS4y5Z/ND9brlNa6Navxm7Z/vri0pDR6TxkbC8t6IKYMhD5YWqOBv6/wYfQ2lk/J4lLrHm4asLK011W01iwg8ts7G8sZUdwSLzF67YkpCcsDnQzRqCZM+agSVIUje7ZYOmPWH2f6CRo981ZgjQWZ+SkeXK5fYBJUICiw5Fyd37W5+BsHu9ZS8QA45bkTDuSq86k/uvAn9oQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB9229.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(3023799007)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(261026121527099003)(261028144727099003)(261022105027099003)(10067099003)(261026140227099003)(261021121427099003)(261009221727099003)(261009221227099003)(261009223027099003)(261009223327099003)(261009220027099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 AGhJ3epbXsgGM2FqWeMWu1V8EWzcK4bv21qoVtMUuW+/T12vE+NZ+LxR2RoNgTu4IqbCafzJqC8TNzhv6ujhaLU2L6vUFCdDr/6bl/AXbTh8eTGj5B2ShPAoboDAUoyifqDKVStbkRi80pB+f+1FDGceS0EUeYXTQ6KFKMJU791RVK2hGf71oarhlAVQwD8FbjGGacP5GYhpNlKUW4XLIqChqCjL6X9re2QRHnthbz0Pj4N9H5BdciIaj9y0r4dXduzZrCIAiCdd5uaRy4Ytb8MjuOH/q3HnyhAE09lATmJmtbHrhTxD94RcTpeOI7Bon4jDvAqrUdeEvyFcd52LLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5963
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	67fce938-df83-4724-b503-08df3677b3d5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700016|82310400026|35042699022|7416014|376014|23010399003|1800799024|22082099003|18002099003|3023799007|921020|56012099006|11063799006|261009221227099003|10067099003|261028144727099003|261021121427099003|261022105027099003|261009220027099003|261009221727099003|261009223027099003|261009223327099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	UflBotsE1KK7Rm4t/L+WY9hSkEV/gZDE15kvKlL/BiuxyPzGtH8Rv8Z2Akgno8GM6pGyBpVoFKGKDASDsaxXzZBlSwJtTDVxSuVF3OIzvx3KbgQRZNmYS2m+9G50aDVIVXt4eFacbWfkyXc8A577Z2ZeguDL/qCH1uwKZ/MziUwouCIDu1RMONe4m9IbRBvy+KWpOLUMe0tV122JTXSB4QkLMqUb+Bl/Gaexg/OAFfb1RDkRdcCHjKnraQIbcfij1oOE/ab5hVVRmRqt31sTmWvKmi+JOxD5gkShoqMW4Ft7SOEZNQ0EuNc0ioaRpiPvcWBi2JHhK5wHkM+i8dOzwuaKdncmoaVD3EKffbwlQ12rYT0Yniq547ybMZeRYnpB4/pfy0+eszdZYBkvPrVL3Y3ctQTH1uF0NX9Fm6b+nz1OhewKnGpvwoIiAeII8/mzud85hEyKwhMBnHKO6alYBlHvJsstKOFViGvMFJJDwVmgpQEs76Halg7kWmjAJQexFQDI4wfLIlNPF0xpuEbwLufRya50qDfAA60u1Gt0H1OOlFbv8cV1gmpiLiNHdypzKWivOVMWaOdzzvIONbXghJqhxytuZzoOI+tldoeCuUk5W/JaYC43+Jt5ffYq45HiZk8+Sh1TxhnwQg8LVDQ3aoNelheVij4S2tpAyeM3EOFbN0vL25BlbJnlHTwX2tZi
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700016)(82310400026)(35042699022)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(3023799007)(921020)(56012099006)(11063799006)(261009221227099003)(10067099003)(261028144727099003)(261021121427099003)(261022105027099003)(261009220027099003)(261009221727099003)(261009223027099003)(261009223327099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HbAT+uR/nJDLIINW/q3Emp0FHkxHMi8/Ke7LAsnu37WHklixJdFcPtdFH2gKyh9z4joJU//ERPXj8KAfHXbfljA+ImoNuNs55jlpr4PBUGwhr35lycFK+xNOpDg10+0u3ANL+fNWx7WpeUKyA1wc6aEHYNaL6v65twy+KyUEWP5O90K7DAXijmE3P2e+Ieq3WwvHGLJxIV84Hz+64HU7JTH2nVBdV5QoSisYv0O6F6Y8ydRyDFSDYVr7X/QqSeaJ3by2G6B+4JhKxNR+aPIJZBCZY6yGfyZaG3V01+NO4kFSGACLh4zOEsW92tpUK+TSkwWpx6CGEgGPlZWPTDnw9Qw21mFMoRbBmSTbqgGbCzFOIumgYlhttVcQj60ZWMp/JXS98qQ/nqwOxGB2jnZUpfBgtDjEKZvjGxPdAITL14OksvVGp54t4NNnrIIrtI3w
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 11:20:24.9651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e1b60a-0805-4783-302b-08df3677cb58
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8132

On 29/10/2026 8:32 pm, David Hildenbrand (Arm) wrote:
> See v1 on details. TL;DR various fixes :)
> 
> Thanks to everyone for the review! Hoping I can get some more? :)
> 
> I am planning on picking these myself, moving them to linux-next fairly
> soon through mm/core.git.
> 
> ---
> Changes in v2:
> - "mm/memfd: check for real shmem inodes before accessing shmem state"
>  - Call it inode_is_shmem
> - "mm/truncate: look again if a folio left the mapping"
>  - Different fix for truncate_inode_pages_range
>  - Adjust description
> - "mm/huge_memory: fix zapping migration entries for device-private THPs"
>  - Move handling in zap_deposited_table
> - "mm/mmu_gather: fix flushing ranges with 4 GiB or larger"
>  - Adjust description"
> - "mm/huge_memory: split huge PUDs when adjusting VMA boundaries"
>  - Drop split_pud check
> - Link to v1: https://patch.msgid.link/20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org
I ran Fastpath, a Linux kernel performance benchmarking framework, on
this series against mm-stable on aws-m7g.metal. (I) and (R) indicate
statistically significant improvements and regressions, respectively.
The results show 10 improvements and 1 regression. Other, unmarked
percentage changes can be ignored as statistically insignificant. Hence:

Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Results for SUT Class aws-m7g.metal (arm64):
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| Benchmark                       | Result Class                                             |      mm-stable |  this patch |
+=================================+==========================================================+================+=============+
| lmbench/lat-mem-rd              | size:4MB P:1 stride:128B rnd_read_lat (ns)               |          24.95 |      -2.64% |
|                                 | size:4MB P:1 stride:128B seq_read_lat (ns)               |           2.95 |      -1.76% |
|                                 | size:16MB P:1 stride:128B rnd_read_lat (ns)              |          27.89 |      -2.70% |
|                                 | size:16MB P:1 stride:128B seq_read_lat (ns)              |           2.88 |      -1.19% |
|                                 | size:64MB P:1 stride:128B rnd_read_lat (ns)              |         101.59 |      -0.32% |
|                                 | size:64MB P:1 stride:128B seq_read_lat (ns)              |           5.43 |      -0.82% |
|                                 | size:256MB P:1 stride:128B rnd_read_lat (ns)             |         113.17 |      -0.29% |
|                                 | size:256MB P:1 stride:128B seq_read_lat (ns)             |           5.57 |      -0.30% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| micromm/fork                    | fork: p:1, d:10 (seconds)                                |         0.0074 |      -3.29% |
|                                 | fork: p:16, d:10 (seconds)                               |         0.0061 |       0.25% |
|                                 | fork: p:512, d:10 (seconds)                              |         0.0055 |       0.36% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| micromm/munmap                  | munmap: p:1, d:10 (seconds)                              |          0.043 |      -0.51% |
|                                 | munmap: p:16, d:10 (seconds)                             |         0.0081 |      -0.50% |
|                                 | munmap: p:512, d:10 (seconds)                            |         0.0042 |       0.70% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| micromm/vmalloc                 | fix_align_alloc_test: p:1, h:0, l:500000 (usec)          |      582591.50 |       0.65% |
|                                 | fix_size_alloc_test: p:1, h:0, l:500000 (usec)           |      361468.33 |       1.46% |
|                                 | fix_size_alloc_test: p:4, h:0, l:500000 (usec)           |      419288.33 |       0.73% |
|                                 | fix_size_alloc_test: p:16, h:0, l:500000 (usec)          |      733574.83 |       0.61% |
|                                 | fix_size_alloc_test: p:16, h:1, l:500000 (usec)          |      699803.67 |       0.39% |
|                                 | fix_size_alloc_test: p:64, h:0, l:100000 (usec)          |      394392.00 |       0.07% |
|                                 | fix_size_alloc_test: p:64, h:1, l:100000 (usec)          |      378722.67 |       0.07% |
|                                 | fix_size_alloc_test: p:256, h:0, l:100000 (usec)         |     1399837.00 |      -0.24% |
|                                 | fix_size_alloc_test: p:256, h:1, l:100000 (usec)         |     1355183.33 |      -0.76% |
|                                 | fix_size_alloc_test: p:512, h:0, l:100000 (usec)         |     2724934.00 |      -0.37% |
|                                 | fix_size_alloc_test: p:512, h:1, l:100000 (usec)         |     1915856.17 |      -0.19% |
|                                 | full_fit_alloc_test: p:1, h:0, l:500000 (usec)           |      563338.00 |       1.51% |
|                                 | kvfree_rcu_1_arg_vmalloc_test: p:1, h:0, l:500000 (usec) |      370179.17 |       0.12% |
|                                 | kvfree_rcu_2_arg_vmalloc_test: p:1, h:0, l:500000 (usec) |      367558.00 |      -0.50% |
|                                 | long_busy_list_alloc_test: p:1, h:0, l:500000 (usec)     |     3532591.00 |      -0.06% |
|                                 | pcpu_alloc_test: p:1, h:0, l:500000 (usec)               |      192186.33 |      -0.87% |
|                                 | random_size_align_alloc_test: p:1, h:0, l:500000 (usec)  |      691912.83 |      -0.66% |
|                                 | random_size_alloc_test: p:1, h:0, l:500000 (usec)        |     1856151.83 |      -0.08% |
|                                 | vm_map_ram_test: p:1, h:0, l:500000 (usec)               |       80702.00 |      -0.20% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| mmtests/hackbench               | hackbench-process-pipes-1 (seconds)                      |           0.14 |      -1.25% |
|                                 | hackbench-process-pipes-4 (seconds)                      |           0.39 |       1.72% |
|                                 | hackbench-process-pipes-7 (seconds)                      |           0.67 |       1.34% |
|                                 | hackbench-process-pipes-12 (seconds)                     |           1.11 |       1.06% |
|                                 | hackbench-process-pipes-21 (seconds)                     |           1.46 |       0.84% |
|                                 | hackbench-process-pipes-30 (seconds)                     |           1.84 |       0.71% |
|                                 | hackbench-process-pipes-48 (seconds)                     |           2.52 |       0.82% |
|                                 | hackbench-process-pipes-79 (seconds)                     |           3.56 |       1.30% |
|                                 | hackbench-process-pipes-110 (seconds)                    |           4.60 |       0.76% |
|                                 | hackbench-process-pipes-141 (seconds)                    |           5.68 |       1.21% |
|                                 | hackbench-process-pipes-172 (seconds)                    |           6.81 |       0.64% |
|                                 | hackbench-process-pipes-203 (seconds)                    |           7.94 |       0.62% |
|                                 | hackbench-process-pipes-234 (seconds)                    |           9.10 |       0.74% |
|                                 | hackbench-process-pipes-256 (seconds)                    |           9.90 |       0.65% |
|                                 | hackbench-process-sockets-1 (seconds)                    |           0.26 |      -0.57% |
|                                 | hackbench-process-sockets-4 (seconds)                    |           0.61 |       0.08% |
|                                 | hackbench-process-sockets-7 (seconds)                    |           0.98 |       0.19% |
|                                 | hackbench-process-sockets-12 (seconds)                   |           1.59 |       0.35% |
|                                 | hackbench-process-sockets-21 (seconds)                   |           2.73 |       0.18% |
|                                 | hackbench-process-sockets-30 (seconds)                   |           3.89 |       0.17% |
|                                 | hackbench-process-sockets-48 (seconds)                   |           6.23 |       0.24% |
|                                 | hackbench-process-sockets-79 (seconds)                   |           9.67 |       0.36% |
|                                 | hackbench-process-sockets-110 (seconds)                  |          13.47 |       0.58% |
|                                 | hackbench-process-sockets-141 (seconds)                  |          17.36 |       0.48% |
|                                 | hackbench-process-sockets-172 (seconds)                  |          21.52 |       0.60% |
|                                 | hackbench-process-sockets-203 (seconds)                  |          25.68 |       0.39% |
|                                 | hackbench-process-sockets-234 (seconds)                  |          30.06 |       0.57% |
|                                 | hackbench-process-sockets-256 (seconds)                  |          33.10 |       0.42% |
|                                 | hackbench-thread-pipes-1 (seconds)                       |           0.18 |       0.95% |
|                                 | hackbench-thread-pipes-4 (seconds)                       |           0.40 |       0.25% |
|                                 | hackbench-thread-pipes-7 (seconds)                       |           0.67 |      -1.28% |
|                                 | hackbench-thread-pipes-12 (seconds)                      |           1.13 |      -0.76% |
|                                 | hackbench-thread-pipes-21 (seconds)                      |           1.50 |       0.07% |
|                                 | hackbench-thread-pipes-30 (seconds)                      |           1.91 |       0.11% |
|                                 | hackbench-thread-pipes-48 (seconds)                      |           2.64 |      -0.09% |
|                                 | hackbench-thread-pipes-79 (seconds)                      |           3.63 |      -0.28% |
|                                 | hackbench-thread-pipes-110 (seconds)                     |           4.75 |      -0.30% |
|                                 | hackbench-thread-pipes-141 (seconds)                     |           5.89 |      -0.25% |
|                                 | hackbench-thread-pipes-172 (seconds)                     |           7.10 |      -0.31% |
|                                 | hackbench-thread-pipes-203 (seconds)                     |           8.31 |      -0.15% |
|                                 | hackbench-thread-pipes-234 (seconds)                     |           9.54 |      -0.23% |
|                                 | hackbench-thread-pipes-256 (seconds)                     |          10.39 |      -0.31% |
|                                 | hackbench-thread-sockets-1 (seconds)                     |           0.28 |       0.84% |
|                                 | hackbench-thread-sockets-4 (seconds)                     |           0.63 |      -0.05% |
|                                 | hackbench-thread-sockets-7 (seconds)                     |           0.99 |      -0.15% |
|                                 | hackbench-thread-sockets-12 (seconds)                    |           1.58 |       0.25% |
|                                 | hackbench-thread-sockets-21 (seconds)                    |           2.70 |       0.07% |
|                                 | hackbench-thread-sockets-30 (seconds)                    |           3.83 |       0.24% |
|                                 | hackbench-thread-sockets-48 (seconds)                    |           6.08 |       0.26% |
|                                 | hackbench-thread-sockets-79 (seconds)                    |           9.44 |       0.45% |
|                                 | hackbench-thread-sockets-110 (seconds)                   |          13.13 |       0.53% |
|                                 | hackbench-thread-sockets-141 (seconds)                   |          16.94 |       0.75% |
|                                 | hackbench-thread-sockets-172 (seconds)                   |          21.07 |       0.93% |
|                                 | hackbench-thread-sockets-203 (seconds)                   |          25.18 |       0.82% |
|                                 | hackbench-thread-sockets-234 (seconds)                   |          29.40 |       0.65% |
|                                 | hackbench-thread-sockets-256 (seconds)                   |          32.39 |       0.64% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| mmtests/kernbench               | kernbench-elsp-64 (seconds)                              |         359.59 |       0.05% |
|                                 | kernbench-syst-64 (seconds)                              |        1084.06 |       1.31% |
|                                 | kernbench-user-64 (seconds)                              |       19753.52 |       0.07% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| mmtests/sysbench-cpu            | sysbenchcpu-1 (ops/second)                               |         835.59 |      -0.01% |
|                                 | sysbenchcpu-4 (ops/second)                               |        3342.07 |       0.00% |
|                                 | sysbenchcpu-7 (ops/second)                               |        5848.46 |       0.00% |
|                                 | sysbenchcpu-12 (ops/second)                              |       10025.89 |      -0.00% |
|                                 | sysbenchcpu-21 (ops/second)                              |       17544.27 |      -0.00% |
|                                 | sysbenchcpu-30 (ops/second)                              |       25061.51 |      -0.00% |
|                                 | sysbenchcpu-48 (ops/second)                              |       40094.33 |      -0.01% |
|                                 | sysbenchcpu-79 (ops/second)                              |       53449.56 |      -0.00% |
|                                 | sysbenchcpu-110 (ops/second)                             |       53441.85 |      -0.00% |
|                                 | sysbenchcpu-128 (ops/second)                             |       53438.27 |      -0.00% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| mmtests/sysbench-mutex          | sysbenchmutex-1 (usec)                                   |         194.35 |       0.04% |
|                                 | sysbenchmutex-4 (usec)                                   |         200.54 |      -0.12% |
|                                 | sysbenchmutex-7 (usec)                                   |         200.98 |       0.04% |
|                                 | sysbenchmutex-12 (usec)                                  |         201.34 |      -0.14% |
|                                 | sysbenchmutex-21 (usec)                                  |         202.08 |      -0.17% |
|                                 | sysbenchmutex-30 (usec)                                  |         202.87 |      -0.34% |
|                                 | sysbenchmutex-48 (usec)                                  |         235.24 |       0.58% |
|                                 | sysbenchmutex-79 (usec)                                  |         362.89 |       0.03% |
|                                 | sysbenchmutex-110 (usec)                                 |         495.17 |      -4.54% |
|                                 | sysbenchmutex-128 (usec)                                 |         599.52 |       3.37% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| mmtests/sysbench-thread         | sysbenchthread-1 (usec)                                  |           0.36 |      -0.62% |
|                                 | sysbenchthread-4 (usec)                                  |           0.52 |      -0.77% |
|                                 | sysbenchthread-7 (usec)                                  |           2.85 |       4.31% |
|                                 | sysbenchthread-12 (usec)                                 |           6.42 |      -0.19% |
|                                 | sysbenchthread-21 (usec)                                 |          13.52 |      -5.83% |
|                                 | sysbenchthread-30 (usec)                                 |          17.14 |       6.86% |
|                                 | sysbenchthread-48 (usec)                                 |          30.64 |       2.04% |
|                                 | sysbenchthread-79 (usec)                                 |          62.83 |       3.59% |
|                                 | sysbenchthread-110 (usec)                                |          95.75 |       0.87% |
|                                 | sysbenchthread-128 (usec)                                |         112.12 |      -0.27% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| perf/futex                      | hash (ops/sec)                                           |     2661114.13 |      -1.22% |
|                                 | lock-pi (ops/sec)                                        |         281.00 |       0.00% |
|                                 | requeue (ms)                                             |          0.028 |       6.37% |
|                                 | wake (ms)                                                |          0.079 |       6.65% |
|                                 | wake-parallel (ms)                                       |         0.0044 |       2.47% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| perf/mem                        | memset -k 1GB -f default -s 16GB (bytes/sec)             | 65384265194.20 |      -1.20% |
|                                 | mmap -p 1GB -f demand -s 32GB -l 5 (bytes/sec)           | 63873483711.66 |      -0.51% |
|                                 | mmap -p 4KB -f demand -s 32GB -l 5 (bytes/sec)           | 50086884685.75 |       0.33% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| perf/sched                      | messaging -l 10000 (sec)                                 |           1.32 |       1.11% |
|                                 | pipe (ops/sec)                                           |      746693.53 |  (I) 10.81% |
|                                 | seccomp-notify (ops/sec)                                 |      239242.23 |       0.99% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| perf/syscall                    | basic (ops/sec)                                          |     5120478.20 |   (I) 3.58% |
|                                 | execve (ops/sec)                                         |        2361.40 |   (I) 3.32% |
|                                 | fork (ops/sec)                                           |        4036.27 |   (I) 5.89% |
|                                 | getpgid (ops/sec)                                        |     5263958.43 |      -0.51% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| pts/memtier-benchmark           | Protocol: Redis Clients: 50 Ratio: 1:1 (Ops/sec)         |     1881192.47 |       1.76% |
|                                 | Protocol: Redis Clients: 50 Ratio: 1:5 (Ops/sec)         |     2029301.38 |       1.10% |
|                                 | Protocol: Redis Clients: 50 Ratio: 5:1 (Ops/sec)         |     1676141.91 |       1.81% |
|                                 | Protocol: Redis Clients: 100 Ratio: 1:1 (Ops/sec)        |     1887013.22 |       1.44% |
|                                 | Protocol: Redis Clients: 100 Ratio: 1:5 (Ops/sec)        |     1992665.04 |   (I) 5.00% |
|                                 | Protocol: Redis Clients: 100 Ratio: 5:1 (Ops/sec)        |     1796984.06 |      -1.13% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| pts/nginx                       | Connections: 200 (Requests Per Second)                   |      265772.36 |       0.15% |
|                                 | Connections: 1000 (Requests Per Second)                  |      256136.45 |       0.23% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| pts/perl-benchmark              | Test: Interpreter (Seconds)                              |         0.0011 |  (I) 12.50% |
|                                 | Test: Pod2html (Seconds)                                 |           0.12 |       0.71% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| pts/pybench                     | Total For Average Test Times (Milliseconds)              |        1005.50 |      -0.02% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| pts/redis                       | Test: GET Connections: 50 (Requests Per Second)          |     2265966.17 |       1.63% |
|                                 | Test: GET Connections: 1000 (Requests Per Second)        |     2219967.42 |       1.40% |
|                                 | Test: LPOP Connections: 50 (Requests Per Second)         |     1569488.21 |       2.28% |
|                                 | Test: LPOP Connections: 1000 (Requests Per Second)       |     1551803.58 |       2.42% |
|                                 | Test: LPUSH Connections: 50 (Requests Per Second)        |     1525781.50 |       2.68% |
|                                 | Test: LPUSH Connections: 1000 (Requests Per Second)      |     1428476.58 |       2.60% |
|                                 | Test: SADD Connections: 50 (Requests Per Second)         |     2030311.52 |       1.26% |
|                                 | Test: SADD Connections: 1000 (Requests Per Second)       |     2004562.54 |       1.64% |
|                                 | Test: SET Connections: 50 (Requests Per Second)          |     1839073.31 |       0.64% |
|                                 | Test: SET Connections: 1000 (Requests Per Second)        |     1806245.08 |       1.11% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| pts/sqlite-speedtest            | Timed Time - Size 1,000 (Seconds)                        |          75.65 |       1.63% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| repro-collection/mysql-workload | db transaction rate (transactions/min)                   |      236380.17 |       0.65% |
|                                 | new order rate (orders/min)                              |       77978.33 |       0.69% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| schbench/thread-contention      | -m 16 -t 1 -r 10 -s 1000, avg_rps (req/sec)              |        1360.03 |       1.79% |
|                                 | -m 16 -t 1 -r 10 -s 1000, req_latency_p99 (usec)         |       15084.80 |      -0.06% |
|                                 | -m 16 -t 1 -r 10 -s 1000, wakeup_latency_p99 (usec)      |           3.00 |       0.00% |
|                                 | -m 16 -t 4 -r 10 -s 1000, avg_rps (req/sec)              |        4367.47 |  (I) 20.95% |
|                                 | -m 16 -t 4 -r 10 -s 1000, req_latency_p99 (usec)         |       15141.60 |       0.02% |
|                                 | -m 16 -t 4 -r 10 -s 1000, wakeup_latency_p99 (usec)      |           4.15 | (R) -13.99% |
|                                 | -m 16 -t 16 -r 10 -s 1000, avg_rps (req/sec)             |        1331.22 |       3.94% |
|                                 | -m 16 -t 16 -r 10 -s 1000, req_latency_p99 (usec)        |      950041.60 |       1.54% |
|                                 | -m 16 -t 16 -r 10 -s 1000, wakeup_latency_p99 (usec)     |       15538.40 |      -1.25% |
|                                 | -m 16 -t 64 -r 10 -s 1000, avg_rps (req/sec)             |         433.65 |      -0.14% |
|                                 | -m 16 -t 64 -r 10 -s 1000, req_latency_p99 (usec)        |    11090329.60 |      -0.18% |
|                                 | -m 16 -t 64 -r 10 -s 1000, wakeup_latency_p99 (usec)     |       64028.80 |      -0.15% |
|                                 | -m 32 -t 1 -r 10 -s 1000, avg_rps (req/sec)              |        2962.10 |       4.76% |
|                                 | -m 32 -t 1 -r 10 -s 1000, req_latency_p99 (usec)         |       15096.80 |      -0.03% |
|                                 | -m 32 -t 1 -r 10 -s 1000, wakeup_latency_p99 (usec)      |           3.00 |       0.00% |
|                                 | -m 32 -t 4 -r 10 -s 1000, avg_rps (req/sec)              |        2365.75 |  (I) 10.92% |
|                                 | -m 32 -t 4 -r 10 -s 1000, req_latency_p99 (usec)         |       56864.00 |      -0.45% |
|                                 | -m 32 -t 4 -r 10 -s 1000, wakeup_latency_p99 (usec)      |        6064.00 |      -0.07% |
|                                 | -m 32 -t 16 -r 10 -s 1000, avg_rps (req/sec)             |         709.63 |       1.97% |
|                                 | -m 32 -t 16 -r 10 -s 1000, req_latency_p99 (usec)        |     3780096.00 |      -1.87% |
|                                 | -m 32 -t 16 -r 10 -s 1000, wakeup_latency_p99 (usec)     |       31720.00 |       0.57% |
|                                 | -m 32 -t 64 -r 10 -s 1000, avg_rps (req/sec)             |         387.14 |       0.21% |
|                                 | -m 32 -t 64 -r 10 -s 1000, req_latency_p99 (usec)        |    16696524.80 |       0.00% |
|                                 | -m 32 -t 64 -r 10 -s 1000, wakeup_latency_p99 (usec)     |      126131.20 |      -0.15% |
|                                 | -m 64 -t 1 -r 10 -s 1000, avg_rps (req/sec)              |        6545.98 |       1.53% |
|                                 | -m 64 -t 1 -r 10 -s 1000, req_latency_p99 (usec)         |       15108.00 |      -0.05% |
|                                 | -m 64 -t 1 -r 10 -s 1000, wakeup_latency_p99 (usec)      |           4.00 |       0.00% |
|                                 | -m 64 -t 4 -r 10 -s 1000, avg_rps (req/sec)              |        1243.98 |       0.56% |
|                                 | -m 64 -t 4 -r 10 -s 1000, req_latency_p99 (usec)         |      910310.40 |      -0.17% |
|                                 | -m 64 -t 4 -r 10 -s 1000, wakeup_latency_p99 (usec)      |       13161.60 |      -0.07% |
|                                 | -m 64 -t 16 -r 10 -s 1000, avg_rps (req/sec)             |         456.27 |       0.02% |
|                                 | -m 64 -t 16 -r 10 -s 1000, req_latency_p99 (usec)        |    11055104.00 |      -0.20% |
|                                 | -m 64 -t 16 -r 10 -s 1000, wakeup_latency_p99 (usec)     |       61657.60 |      -1.58% |
|                                 | -m 64 -t 64 -r 10 -s 1000, avg_rps (req/sec)             |         535.45 |       0.14% |
|                                 | -m 64 -t 64 -r 10 -s 1000, req_latency_p99 (usec)        |    36939366.40 |      -0.02% |
|                                 | -m 64 -t 64 -r 10 -s 1000, wakeup_latency_p99 (usec)     |      241779.20 |      -0.33% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| specjbb/composite               | critical-jOPS (jOPS)                                     |       95699.00 |   (I) 2.13% |
|                                 | max-jOPS (jOPS)                                          |      116191.00 |       1.27% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| speedometer/v2.0                | score (runs/min)                                         |         154.50 |       1.51% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+
| speedometer/v2.1                | score (runs/min)                                         |         161.67 |   (I) 2.78% |
+---------------------------------+----------------------------------------------------------+----------------+-------------+

-- 
Thanks,
Usama
