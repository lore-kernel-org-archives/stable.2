Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794952436;
	b=eGyb/S9V8OSfw+KLQwMdu4qi8hOGLhZF9q+D80UOU6WlepUPEIN32RXQbPsMINnjuwVi
	 ZKv7hIFZdtRXZAYTfu45a/tcFfOabl54Fkgj7caqQ4u7IXgQRZey4qJQqPqmLnrHPZOZL
	 +RvfNr4m41IG9PK3aMv3g3ZbtZDycGJB9qv5mq9vA1xDeEW19x+vLcn9wydTHvFx1pLJm
	 zrMbOF2ylWPKqxI1MxWbGxWCy7y9iwrbfVzDamE3bSF+Xe+lPXx8vcIGoy9Ze90OzNNjb
	 60AxhwB4q91DaZ6TQkiSZUxN9IWaoYEolBwatsZan1bJJULHy3b1UwwOYcKqfLv+wSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794952436;
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
	bh=AB8eDc/POoAylk2akoBuRgeStrYOHzfi32cnfxulv40=;
	b=id9qZ9FNDayvFJG7hc8fxXwPakFUfEL4jW90UHW4TZpbBL9JBIBXcqpbYmqnZd1H0eIU
	 TD4JKQpoqK3mdB8l57q9DLyMOoi8mJNdSgDvQVotTjDaCa0JHA68xlWk+yCfV2aSQn3ur
	 QAUSboQ0Apz6obcmMULz5j0ebxu5gzks1xJ2jMEd/rtkgMgoH0rb9iW9j+i3tILEWUIpC
	 Rnaih72xYzU8k6MVxHKz8ZQtb0vXdYW+a2F7vx4xleaHnzm6SUQLbDJFLpZMPlk4jbTlI
	 UtB0LPl0XkxNP7tZGMVwiXb3cJXIELDx5T9CrkhmEkuUsRRsPYJFyjVOEjdYG60S5ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="R8Mtn//1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.54
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013054.outbound.protection.outlook.com [40.93.196.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D2606A31C;
	Tue, 17 Nov 2026 21:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 319D2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=R8Mtn//1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wg/lMqpYGFSb6Piui/7k+6T0WsnM6F9hGCvBCHd1l22EJhojLXDhN4AG0tjF2/UNwN1FE/he69AB5yNaYEWH9RB4vIhtOkWeP4JaaeYT+AzSkBMNL00ESx5obmxrpmVC7RIN7pEKLTvJ4pkEvYYkO465tZQIXw5o0XE86tHJjboKIguqUPuCb9L/B6Naf+HMaJmmqZlyCplBaph7pILzaTquPuFPNPeVk2LdEidakdkmgvWVf56qNesCwwCFQghJ/YqzSK3v/MF+BZDxpC+n0yxGjqFqyUVoVQfhSRFI7X+n1Jf5pnrJvlM/kL+RaJGjRZTfu/Uz1P7BxqemW+Wy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AB8eDc/POoAylk2akoBuRgeStrYOHzfi32cnfxulv40=;
 b=wsGAqliI6UC4ebEp6svN0FZKAFF49KVSVcOo1Vr2+LzT/whm1mNdgkLCpvjnRZDX89Q787XqmdwFYnr3ZS791LwdLxH2b+/NrjO+e2jNZ+iDi+4/NG4Q0+8LFieOU+ejXeTSClIBcRe0c6cuZ2/laQRRG6ssyL2oNdSmwwQzuO+Z3DOttWdeQXydU8Qhj4cAGW3xyFYgnRrpJufQRGXbxo0rDOTRONuUFGHJLooA/DydvTU5UxRjg31XG67jAPsOacEBxeEplzfxOBAK2N0xXmRKPjeEvpZsMNmaGmDZiW0R3MkLCCEJd9t1tTioVbBcSM+vB5Csufhq4TIRYNRCrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB8eDc/POoAylk2akoBuRgeStrYOHzfi32cnfxulv40=;
 b=R8Mtn//1srI2ErM+uGFWzd+ww1/y/x6jCZ1qm5X9M+Vi6WrXURCngZStIl2r8oQWRhnIXp9v28s87DXlekne0USdww11qPwJh5e0zpyyvOMsgtEYfj2UTdT4nvrV9gm3rZ1Rc6wg8CGvDj3e/AsTdOCF9k07g1tAY4sDN1roi0QdDo/kfoGlZ/VUIGzN7gJF0xxzTZsEZY8Jrha4f25MRXi8lK1XEVPCeAZlNzioMpOULIrOtHHQrkrnDpmuTW2rwVWfmPt07+H6QMr8HEkwoIr9MX8rTfx1AhlbK3bYWWxWSGjrCj2kF3os83maRWG/ao0FhLO9ydt2AT4+LHC1kg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 21:53:41 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0615.009; Tue, 17 Nov 2026
 21:53:40 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>,
 Roman Kisel <romank@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Eliav Farber <farbere@amazon.com>,
 stable@vger.kernel.org, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v2 3/4] mm/memory: do not report OOM if insert_pfn() races
 a huge fault
Date: Tue, 17 Nov 2026 16:53:39 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <94A643CE-9843-45B6-B73E-218A9C5DDF69@nvidia.com>
In-Reply-To: <20261117-huge-pfnmap-fault-races-v2-3-276007e73bcb@kernel.org>
References: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org>
 <20261117-huge-pfnmap-fault-races-v2-3-276007e73bcb@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: BL1P223CA0039.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::10) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: d321e9e5-2404-43a2-5f32-08df44f53dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|5023799004|4143699003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261021123027099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	9o5BxSTan7hsQmfZL8xWN2egEzo8ZKH7P/G2qOOIUI7SvHlTXRUd8mcyjOFCpG6CpmRaeAFCN0lxdqI0HdmAVAkXhvK4gDPO7bpylJm9yXXp5bNXBHZrS6XdcAiPw/nrZK+k17o8sEY/densakkHWwEu+aQ3zJwTVjalwcBfHjyL03gJlumtHvq5PCIAUFreiBspkbueVXGt7JxDH4kDViHh3pMoLJsaYeR0hkmogqeCfzH4AhjY30e/QT09VVDukMKBTgKcsLz9EOJtFPhKe6sMHNVzDcyrR4hehrPTWULra/66FhTIzLPTVLZbyJbxnSv5DdJXBneA3QYQMCyc3vmCcjNPNT2o1FoI+yDk5fZ3tMdOSWy1AkfehqKd9f2fsk8OAK6Wfs+muQqsD5XyBEaiw8lscEH1UPaFuAov6Dqm3B06udmy4Xxv+E1695ZuylgOz7K+UbxiBtrmDSccMYEyvfUpy7tdPBsQhIrjSysA1I/xWC3is3V1hvelR6TlQuxfy9G9VG6Cq8JkpR8pCLYGPuBqYHjvtcbD6oZSXRB0gKnkU5cCmHdrQ53X/M4cCEMpRce6MmWkt2m+NBnA4u90pGEsALFlGZQDYwNpic4B5Mscu+udw9+rkhUPbqoNr6PjBBMW6dGHisCwCfLzHJMk4RrEjCob9XSFRsk6Gqg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(5023799004)(4143699003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261021123027099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DpJusPC5nrUwO8btsSOJ4wCPEHGf5fUmrskd1H1UzBLx9b7b/o6CFRVm9cs0?=
 =?us-ascii?Q?XtoewQ3lnOUVCQF63LaOYXZ+I5JvN/t+4/DwukAjt9qNix6bBHrHG9mH0fi1?=
 =?us-ascii?Q?1jnedJyvxnxR/79m6k76QttQACyuFKZIYzC4MHInXP2Q8SunORZQBVjhc9/k?=
 =?us-ascii?Q?wR89n8gR3eD6Bk/X2/UeR0SbMr5dScZfF+zxbG0x0pkwHvvFL1Cif/BXvqHI?=
 =?us-ascii?Q?xgZLbpVoX9Dil0bUg/OTT+2hVpfBIEf0TUzh3zZwqbVNbGNryU7z8Y7Srerp?=
 =?us-ascii?Q?n4Lc/MuhFiHj2L6k2xwfnBwPsUaztgD6J/6Wzr/+lT9EZKvvGXKKUcvRVKRn?=
 =?us-ascii?Q?JAeQbWMFMcfcTSAfZ1/ac8Wki3a05wgCruVfTwf/JITGGaHyhMDerfJStK1A?=
 =?us-ascii?Q?xgg/Je/ZksBo7nOdqYWg695zlAHEHhGEGw79LgRgjmsSBy7cfwWQCJH5/cQM?=
 =?us-ascii?Q?4gCeaHis24aS3OKOEnSnTdxVxLg/IHB4Ov4jK/gVVOtu3sPwHwASBW7V0dsZ?=
 =?us-ascii?Q?o9S4ZAe1MoiNYD1PP2oD4jCTQmVL9SCRJBVztRep6yWcqZgujdjkP899XET2?=
 =?us-ascii?Q?HJHzBBr1u37cKZhCc2IPelRYkylPAx0j/7K20wBdL+cBrwq8WMiPxenOD3Bw?=
 =?us-ascii?Q?kkKw/AxJHnZqWWeEX/krLfNFS5McK8TUG1ykotw7Tf4eTrNq7oU7viXN76Am?=
 =?us-ascii?Q?RBXzZDznzlnaYiCvj1aw3V2nxx8nvaj+f7lohYGU3SOcj6FztFWzu6+8KvOW?=
 =?us-ascii?Q?Mb4mbfCym9p2P8DrMVf+vw9Q5I0abCK8nPDdursAtcUcJttEJC1V/g5JW7sD?=
 =?us-ascii?Q?dO/4t7Pu1P8fH+TxW2iIXHOuJM8KqrLeRM6jxk55CfuN/Qe0eWN4zaeK89Oo?=
 =?us-ascii?Q?x1z20ZmDKWRo3lvfkpTTEkiJI3/zOGEZlTamWyXvKt2XWRUMbEJl6eT5A8hA?=
 =?us-ascii?Q?tf/zC5y7vk5fLdQ2vZ7xLC/DazpeqgXTnXBJpddlyeBTyVhhW3szcLpS1eD3?=
 =?us-ascii?Q?elhx5oetFiGxAJNmfJBFXRSG4VjVNPYTXMFXsMAA/Za74cMnOHfJ+pp+6JlB?=
 =?us-ascii?Q?2/1vom2f4HAmsLbz6dFFv4vLulp/bO2QKKmiCJAZ6JnBAk+Bf3dskQ5myScV?=
 =?us-ascii?Q?DbEoDSugsgo66KueXhJvlQralahAvhJPeqhwr4s4N3kuNmWUrymwxJBg29a4?=
 =?us-ascii?Q?D/DkS+tBv1jyK/nnnNdCOJriQqWV37JmKc2qIF0hL1ktx+XDidqGaZgVMFmR?=
 =?us-ascii?Q?03ADuI5ZuWnM2/Iua/aAKCZZ67odSxRMDpXpqozH6YFysnbeUouJGbdgskw+?=
 =?us-ascii?Q?maUwNf4Awgq662ZjNlmzdbtE2gS+k132D/GWXlr9YULl7LFHczJMHhgbU/9m?=
 =?us-ascii?Q?BgZGBlC3BY6Rphw1pFWhFxgrbzePx0wJetCDSY8TmbB+oklwcjwXJ232IHnB?=
 =?us-ascii?Q?8CfweWAgQMtDsTxhCD9ivDD1b4vXLNCDH51GPMT21vwW13AcKGx3gQBeLfiZ?=
 =?us-ascii?Q?rW1bS2LoiCNCj0mUPNTohRpfz2ycOVEtQejiG/GIYWCvUWmo4+Ni1ss3ldJd?=
 =?us-ascii?Q?zZcBBknf1i32U7a/t/s3M3PhYSFG38lfFb1b9oOGLY8WtGFgHkqKssLtdz8H?=
 =?us-ascii?Q?4FoppoY8eehuGn12CuiAYn5Qmj8bymYXF5t3eqReKHs4O1AN3uBC9ySIVuf4?=
 =?us-ascii?Q?/8+ed48H2jbXHFsAWHd8DTy5003ggEHpUwqp5JBP1hUEtzl35gH/hn4d6sWL?=
 =?us-ascii?Q?2yqz76YnRA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d321e9e5-2404-43a2-5f32-08df44f53dea
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:53:40.7688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Airf/zCTeI4L9dnbVfXoJSOuIwMHnmxo4HM3/JqinbL3mbarofIG7PSoXQdLBqzM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089

On 17 Nov 2026, at 13:31, Lorenzo Stoakes (ARM) wrote:

> A driver that implements both ->fault and ->huge_fault must anticipate
> concurrent use of both.
>
> This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)=

> concurrent with faulting, as that only holds the mmap write lock and th=
us
> does not exclude faulting threads stabilised by VMA lock.
>
> This is not currently safely handled by insert_pfn(), however, which
> obtains its PTE entry via get_locked_pte(), and treats a NULL return va=
lue
> as an allocation failure, returning VM_FAULT_OOM.
>
> The issue is that get_locked_pte() also returns NULL if the PMD entry i=
s
> not a page table which can happen if a concurrent huge fault installs a=

> huge PMD entry between __handle_mm_fault() observing the PMD entry to b=
e
> empty and insert_pfn() being invoked.
>
> This can result in VM_FAULT_OOM being reported incorrectly.
>
> Fix this by introducing and using __get_locked_pte() which returns -ENO=
MEM
> if a page table allocation fails or -EFAULT if raced.
>
> This allows insert_pfn() to return VM_FAULT_OOM only when an allocation=

> fails and VM_FAULT_NOPAGE otherwise so the fault is retried.
>
> The same change is applied to insert_page(), which only impacts DAX (wh=
ich
> has its own locking).
>
> This means that insert_page() now propagates the returned error, so -EF=
AULT
> in the case of a race. It's not possible currently, but guards against =
that
> changing in future.
>
> Similarly, update walk_to_pmd() to return -EFAULT if it encounters a hu=
ge
> PUD leaf.
>
> Target the commit introducing the first driver able to do this.
>
> Reported-by: Eliav Farber <farbere@amazon.com>
> Closes: https://lore.kernel.org/all/20261112051440.16140-3-farbere@amaz=
on.com/
> Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> Cc: stable@vger.kernel.org
> Suggested-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/memory.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 40 insertions(+), 8 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 20b818bcdfbc..04a518d6059f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2383,19 +2383,48 @@ static int walk_to_pmd(struct mm_struct *mm, un=
signed long addr, pmd_t **pmdp)
>  	pmd =3D pmd_alloc(mm, pud, addr);
>  	if (!pmd)
>  		return -ENOMEM;
> +	/* We may have raced a huge PUD fault. */
> +	if (pud_trans_unstable(pud))
> +		return -EFAULT;

Matches __handle_mm_fault().

LGTM. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>


Best Regards,
Yan, Zi
