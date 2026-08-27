Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5558A47D95F;
	Thu, 27 Aug 2026 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843664; cv=fail; b=cYm1vus6kab5iXvXXTXKRpBR1KJr/XUWLwFcWVIvGIoXMnpVxaEZEt0Eg1d2czZIwBhAB0hf+uN2PGhsVoVvohuJcpD9T8DNhwowRowIi4ef2UKN4sVtO9J3Z7jY5Mbb4+YN57K5+scysvnEUJdzoxAsfUJGpWUwooR4JCoi8G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843664; c=relaxed/simple;
	bh=X7Jrms0fx84z+Hh5BXDA+vT7LxobtvzBcB/gUiQzvfY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zboj3zFaRm5cOvyMSIRTQkTAzWK1PFlc9O8uQm1/xn2Bapi2rT2KWKA7Lt9f8Y8WH472wnsxsPzg2PZgt2+sNUTdw06Drl6m0qw6GYZ77sk4bIRWsKlh9UYx9hWuIpJmI6IRU32DfyKEZwpwYYkDOT5BlMTnniErVQsh5RdhwP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKfw1OyS; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKfw1OyS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787843663; x=1819379663;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X7Jrms0fx84z+Hh5BXDA+vT7LxobtvzBcB/gUiQzvfY=;
  b=HKfw1OyS97omplpo6GwK9PBGvfusXExcfWYE4njlrClKVBnzVwJvZ3v9
   fsAqPgUHNXREjdTyXUOKtL84jGmqdHULMKem1qE6RFgYpq9Z+K9+w0dte
   4xj76PHCR3XWf2ZxmYAOV5pWBu/QJNvma8Pn8ypzFu09Xc8Zlzh+KpqZc
   ly5pLP7OrEof2fV9YXspnh0enbZH9373tJUZR1oxcB9Z89KZP2/0irAkd
   /mgxmrTpbXGPemnSc0DPohHQECT02ZtOO0/Gy41H6QBSYmiaQIbHvQ1hZ
   PvXVGhaKBxSAevTBv3h1HReGDQXG3Ob0MCt87OFv6eYtelQKETgXBeLGI
   g==;
X-CSE-ConnectionGUID: oHNOKpzzRDmcUlIhT+9U2g==
X-CSE-MsgGUID: q/Ei6miiRBqku8Ao40FqLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88399169"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88399169"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 08:14:20 -0700
X-CSE-ConnectionGUID: Uns6TJ/9RJe1dMYgndnwAg==
X-CSE-MsgGUID: lEhqpd+hS+KCic5ExYrnHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="292722917"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 08:14:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 08:14:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 08:14:19 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 08:14:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7FM0OSV2QU1Mr+UKcpCxf1YGj/3qe8QdquzBKrSzClpGseNgoGY9MdVxrdDPCoXNjx/Twzo3GHtQDJ/ktE2cISJIsCw3eoW22/d7BrVJSnbXI+b6x/Bpz6zmxQi6ZS9W/l5Sk+UJlp1LPpo90VuPez8gi9rh95BJvriVCQS1W6rnTZx2GnW5slULuSEISvqLYpeRzCZxa+DnrXdfpsfjX/HRgPU9SmE871yrc0hyx+v+cDn7JW0GuELfDbfz+xiln5if2ptorndfNSnDNqwVDg7mWNyxzdrRpprUFVtJf5H9R2CpuG7z/5DRX3Q4+mCd++D20YfRJ7cxBtS66o/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jw0rvoElgWtL288UTBC6pWG8CTFXMsvQE+1S47rJhBg=;
 b=uqaIii5gE2cBP//recUdX3cX3QIaqpfeqshtdq9ZJPrk5IGa9hGIGdpj0bfYn15lsInZNV2Y5kxr8DlBjZddlOfIJDRx0VNr5zEvF1zLc1A+NV5/0vU/x06LL5XIk8CPXg1ZsaI4o2ferFEqoStkAe0FtPNh3MRrj0BnIr0dVGtm1KLTeYHHiptQQz+Ufz9pjB5VARa/FH+es0Pe5iQqSHwmT3yEPlxwag6UnNN87FNn/3mgetpY8gTn79E7NhPrLcckZg9B0uIiItVGUNjb0bJURdJ5redp/uLOM6FsD7aCC7GUGfTJivYnkZv3ixLuAeETHYNVyycEkyhlxJ8ZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DSM1PFC06F5FBDE.namprd11.prod.outlook.com (2603:10b6:f:fc02::14d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 15:14:17 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 15:14:17 +0000
Date: Thu, 27 Aug 2026 17:14:10 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Paul Moses <p@1g4.org>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andre.guedes@intel.com>, <vedang.patel@intel.com>,
	<jithu.joseph@intel.com>, <richardcochran@gmail.com>, <tkusters@aweta.nl>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH net] igc: only strip RX timestamp header from first buffer
Message-ID: <apBUQvL0g5XiuL95@boxer>
References: <20260825235530.3278670-1-p@1g4.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260825235530.3278670-1-p@1g4.org>
X-ClientProxiedBy: AM0P190CA0003.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DSM1PFC06F5FBDE:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ad582f-1417-41fc-a365-08df044ddca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|23010399003|376014|366016|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 32C6CmYjvXvEvVbLMOOIbTRjTH8O5exBKBjxdvW+9wwPK32WiaXZ04E3Yc1QF6lwuhOvP/5ysM3wtJ7zon/NEf/NH9fj+8zVdJrtizhoAbHGo24zTNJc+tywWEFXpyp4MFRTa3A3QEbUoFWhFm7/u/RyYTv7YZK4JVWrepT6YImUSElhcplhiFN42gR29CZojTyi73W8WodlXM9KQOJC7ogFrdbGm6IPVEgrRcQm15KcT0bMTH3d6h5sjD0adeOdSTngm4nMthSlhZX39b4yL6Weso/X1ibCT6JtDi7CI/P0LxggUxlmPGt6V1lCQndOljmQmKqI1+YqfJnU0BvM4f27jXGRYJv993kZhdd48Od31yiRJLrDiUPzb4SLgeJ9vNwp/zuOl2hprV1xtPo0lGbRBn5KmBojyDKHH0rcpRDKgzufHSw39CW1Bc4bD5mFiOFJOCHD07gBGPB0rP4F5Ta69SOdBvBZfKkNSHC2uARDljn2FZPQKt7WMOZQDReanxQOkjfHwcPq8uLSgx54ZONPanWUAr84X8PY2llqHyXqRcK/29ZJW+zE7iuJ2nUznT+G6LSsx3nhVj9jSk8zN05J/HekgfRz3PQqpZKaRaZt3D/qclW9Vnf3k7b+Y3UaFGypjQnueD4NVJV6qcdhtdNYd17X3EIH9iZGWEfsOUk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(376014)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VPcxOrC+jz+RMVTv/UiP7hINArqcaZFT/BVSYBVEiAk+pJAGbhRcRcxTncJy?=
 =?us-ascii?Q?vi1fc4l5HJFZoMterhpm+WR76FoUSxZQS42MA6MWVE+XrrfJIBN5JQ1XFqUu?=
 =?us-ascii?Q?umzd9nuzAXwDArkkzRzzj1Webt6iKUPJDr6S6D7/mrxTFkXvQ3udqwflpHxv?=
 =?us-ascii?Q?H3IG7xsdv9+v0Fbtn2OH9NYGtaJ5JAUpDoI3G9FD4yLEqwyvoT7VZEYBRW4+?=
 =?us-ascii?Q?7dtj/OtYvrIH1RFGseajN6AaazEOQuBSt2IlKRhpj/WgrlZtDvOAU3JIYwXj?=
 =?us-ascii?Q?6JVB8usHRK0kHQ7m0J27SNiMKa0Mr3u1guCjGMaXUn/KNSz8IDS75IN9PlWR?=
 =?us-ascii?Q?b9AMjGlkHbGq91t9HrIi1BZ5mlmHkmlJgIanTHPOkqYs44BBvsG2O7PGxeGH?=
 =?us-ascii?Q?8rl0Gs9L/PYIle1MsI7eCWyni7Jb1eAs5DuGT7QCp7yt/lb1YJWjHK/c1EqQ?=
 =?us-ascii?Q?/XoU6AsbAyzvSoYo5+Hw38wCKTuV/KqOWKmlHnXPo61sMi2oqQRPGPkRUrD/?=
 =?us-ascii?Q?RgbfCA4g8qxj6HV+uoppr2vuWXQ8O/OJBOoOR0G1qcPkj6RRJ5Q8+VF0Ur83?=
 =?us-ascii?Q?AEi4IvZ0qcAwLzAVB0cy/hpUzl34+76ePevupjdf69IjE3T1BzFFI6LmX2EV?=
 =?us-ascii?Q?HaboYZ82zA4cFc8tyq9zZ0GPRJoWOIDSFfSlOA+slvsJbHoj3GNYCEy2IsUV?=
 =?us-ascii?Q?9U81dbZ/lPqBh0lISpiT33KgqV6EVT1/uG/hwIfI/l/huplld++qkMBmcuxs?=
 =?us-ascii?Q?00v9ZNHl3xppdRRiQh5PKMnkaOthbn8NKk0zORknqdbsyqGoW6apn+lYp3Ig?=
 =?us-ascii?Q?VaEPrvIFUNzZkPdMJIK6wkG7f8q4poO65RxgSWzxh1P1lRNGCHKdjWI21p6j?=
 =?us-ascii?Q?FemHn5fn+zFI8ZmcypEyu0KimYvAVsvC2RwB0HTJguSdbrranD4pq3UVbSje?=
 =?us-ascii?Q?W5m7WvAktVh0gRicowzLYmKGUAhiwMtJot+EHezJciQKiAx7IAzm4jxQGDP/?=
 =?us-ascii?Q?7fV/oIu4LlCha31E/npuAnIVOyCoNqb025JKE+WQ1Bv5lWucg0RTNENYh4xR?=
 =?us-ascii?Q?VvTlk5xOOPPWcdnEAsE3X/QlJZ2tVoSC4sfOJm5q/HaEIA6tJ2k/TUvqCAnz?=
 =?us-ascii?Q?Rd2tSlX1sXwDD58UpO6DwaWOdzv/tb/Qy0nfGLIknEXxLOcRhst+kS4bmaS3?=
 =?us-ascii?Q?UC2KP78CtDfN6VogiuoFGwqhbgZydsKJ1CFWCnwzXW/RLxiV9Gw0YJ3/xwmf?=
 =?us-ascii?Q?axu/fYwZI0+8EsXKhbioHQkWJ/bLt4FkZ5qfAkhXeaIEA9R/GAX/Q5lzqr7o?=
 =?us-ascii?Q?AMISoPXPtosKvFitGtPYnrZmZPcBFXqp4DMO3B8WFConqNnAVSXYBjWtaStI?=
 =?us-ascii?Q?DtLTgwOSXE/bkszLpfu4aVSeJf94XvwSse99ck7P2GoCcg3pVh3fisUtklmL?=
 =?us-ascii?Q?V/UgFOk5mWCx1Om6E1wZjw4urwNAjILZNnfDZTAeMtY1ze6xlmP4JU3U0jLW?=
 =?us-ascii?Q?V+sKWEPqsQJROv88sri62WvDm2yqIneZZs6hnKhjDE7V3zKkjia8fuuqjRdQ?=
 =?us-ascii?Q?GBDNX5vgSgtVWu6hovhHM3x+YTm7MYx24YYV6AyIOG/MX5jad5zwbPDyKZkx?=
 =?us-ascii?Q?EyYaNwMCE81HUibqDe/TRsNuz7JZOOD4CUJw4X9rqxvm4OIAiJ9Oln1X520C?=
 =?us-ascii?Q?Se6IyjVDWoeDa4o+DvvR9a0tOzh3fMdEoFfbe4dZlHwszliOJ1QHDgYCnj8N?=
 =?us-ascii?Q?LoCfZT0BLRQEQ6D1sowRbTIVhJOfVvk=3D?=
X-Exchange-RoutingPolicyChecked: NKJLoCkI8+Se2bMgDq8e51wb1mb02WihF9xeMkeXJlhSlK9oszFg1QskOpim9V6WIXYqojLEDLqzkX5UHRdRHeKOwZfMjlUnki/Ia8XDjcW/EKQRJOx/7w0Z4FqXQeRpd8yAbAxe+o3sOhMR29dnOyGxi57bI9KBKt7hVoJgqbOntZ/EdAnO4UIx94QXMg50yieg628+Amju5g0hCQkLfslm51cI83Rb/Gd0W7h6KTTbUENQoixESgum0S7Udtn2lh4UuKyki2ua5jPrf3lSbKGVst7Xd13ldRQ9VGc2IilLa9SIrAYfMdUrV6Yv4tLmsRcF384A4upgdoeuKbcJVA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ad582f-1417-41fc-a365-08df044ddca9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 15:14:17.3154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C42IGHx1NiS3rYkS/20NoNAsDulLXHOr6E38FLxrpwxrmAnH9TJ4s+exDF6Te5LgmK3OC2h6HuWtJteMgLF/ujLvhOXnWqWw+nql3RCpnnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PFC06F5FBDE
X-OriginatorOrg: intel.com

On Tue, Aug 25, 2026 at 11:55:40PM +0000, Paul Moses wrote:
> igc_clean_rx_irq() strips IGC_TS_HDR_LEN whenever a descriptor reports
> IGC_RXDADV_STAT_TSIP. For multi-buffer packets, continuation descriptors
> retain TSIP even though the inline timestamp is present only in the first
> RX buffer.
> 
> Subtracting the header length from each continuation buffer truncates
> jumbo packets by 16 bytes per continuation and leaves the packet length
> larger than the received data.
> 
> Only consume the timestamp header when skb is NULL, which identifies the
> first buffer of a new packet. An skb carried in rx_ring->skb remains
> non-NULL when packet assembly resumes in a later NAPI poll.
> 
> Link: https://lore.kernel.org/all/20260625-igb-rx-ts-fix-v3-1-99b3efa08dca@aweta.nl/
> Fixes: e1ed4f92a625 ("igc: Refactor Rx timestamp handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
> #
> # REPRO
> # 
> # Receiver: igc / enp1s0 / 10.0.5.175
> # Sender:   RTL8125B / enP4p65s0 / 10.0.5.165
> 
> # Both hosts
> sudo ip link set dev enp1s0 mtu 9000
> sudo ip link set dev enP4p65s0 mtu 9000
> 
> # Baseline: RX timestamping off
> sudo hwstamp_ctl -i enp1s0 -t 0 -r 0
> ping -n -M do -c 5 -s 8972 10.0.5.175
> # 5/5 received
> 
> # Enable RX timestamping only
> sudo hwstamp_ctl -i enp1s0 -t 0 -r 1
> 
> # Receiver
> sudo timeout 20 tcpdump -ni enp1s0 -s 0 -w /tmp/igc-jumbo.pcap \
>   'icmp and host 10.0.5.165'
> 
> # Sender
> ping -n -M do -c 5 -W 2 -s 8972 10.0.5.175
> # 0/5 received
> 
> # Receiver
> sudo tcpdump -nn -e -vvv -r /tmp/igc-jumbo.pcap
> # length 8950
> # [total length 9000 > length 8936] (invalid)
> # wrong icmp cksum
> 
> # Expected Ethernet length: 9014
> # Captured length:          8950
> # Loss:                       64 = 4 continuation buffers * 16 bytes
> 
> # Disable RX timestamping again
> sudo hwstamp_ctl -i enp1s0 -t 0 -r 0
> ping -n -M do -c 5 -s 8972 10.0.5.175
> # 5/5 received
> 
> ---
> 
>  drivers/net/ethernet/intel/igc/igc_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c..41b293dc10c3 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2639,7 +2639,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  
>  		pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
>  
> -		if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> +		if (!skb &&
> +		    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
>  			ctx.rx_ts = pktbuf;
>  			pkt_offset = IGC_TS_HDR_LEN;
>  			size -= IGC_TS_HDR_LEN;
> -- 
> 2.55.GIT
> 
> 
