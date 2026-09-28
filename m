Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC4C502573
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632904; cv=fail; b=DCU/wdBv64FFgUUKkrK1/L7XHirZgIYG7q5czjgFr4OsG7yqRJU3VCaC/hX3sY05KJ8trZN+Qi+ADoyncUrTiRTzBs4n4p1mQ7pJBz3zyLNIO+Ne9jI/Q1CQOZN8EmKV6PhUqC7MuOvwEeuhGk/kn6o22ROjInG5xdxYQv7sOv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632904; c=relaxed/simple;
	bh=yhdH9cbNxEdrkn2DoorPvpP7lI5ILu3tiHhN3HRqW20=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dLNTQeleeVVonafD+2Hch1LoqR/uSfF5ZhHXoJ3QlaUjVBklgktMLF/tWcODEOnpAi4GK4j9SzDH0S6/BXB7SbQBgxSIk/dyzzt/kwTAaBPKugwWvQ/FnIeFev/tFO7MIDQaeEZfFI+u6OJ/JEVR7q/1yLHBjWRcdGPqBf+Zcjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OCUMeO+C; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCUMeO+C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790632900; x=1822168900;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=yhdH9cbNxEdrkn2DoorPvpP7lI5ILu3tiHhN3HRqW20=;
  b=OCUMeO+CElnO31KTjoEsqNnF8SbbMiA/vRnGETE0Kc0YT3QlwWDlX+0J
   7i1Xlnt4n2KNHNABi/B117N4n7S3e+S2VDDpNEIFV+P8pm5lIYvmMFMM/
   1F8Sauyb8TecLBFs77gjHf52lhsvRJcK04pwy2Y4WWszAJKjWFnw+SQAq
   cttF11TMC5BCb7w6QN2e1NvnCiHCzIh6Y7QmbRfKED2yS56Rvq0S/SQ2O
   i3aXoCiIAOJ5AkloAz9P+rMX8C7JE9f9BjXs6aQ4xrkTXkAzrWirzynaX
   ePkjTFvzWX1W62SJct5hDz3cScq4Js6w+4d45zIB/TNtmH0DuSgaRIUNB
   Q==;
X-CSE-ConnectionGUID: eqU9X7SQSsqk44lt2HilBw==
X-CSE-MsgGUID: rKcDMjsURl6Tk2uvJLZ+bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90296921"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="90296921"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 15:01:40 -0700
X-CSE-ConnectionGUID: ubTpCmc5RIC1098rZ+WpeA==
X-CSE-MsgGUID: 8I6nmkd2Qwe+tF92WA2PdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="274281687"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 15:01:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 15:01:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 15:01:38 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 15:01:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFoMoG++dALjcAm+evbZTxEnrZFqxazekRcAviP4HSkNHtKWk/TlOQN2c/44vkSjxj/h/cxXSEy9X/nc/PKFBHGj53VVkyOSHce6pZPEcDJWZLETAX4VC/nDGfdwPH+lU92Bykv/HjAbCZsbfbDD77lS3N8pWRFVRwLDYhmOkI6FfNO9uSGW2vLrh/2RZD5FOSTt+skozi+B/T5r0CPRKTC3dUNyaAf5RlTFUwjAlIhAmTCnYzTWoc2a/3xuUQt/O90ltETIq4OG5hZhnuZWYFgHFMFQhbFjtSSNmfK8UA0xSkzgE4MMtVDPb/EkywA4n3WjfX3lctn1+LvQXF3zsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDJ2v/2vgxMCH2AWPsKzQn34csqqjicd/drySkF8CWo=;
 b=wkPBwRTiQWoARiry1LA5wzA5sIW/J/DciUn8r7n++T6Eko1Qovt6+4VqpPsKpRy/h4L4tX3zC7Yg2kd/jcFkFJ4lpO275h7tUUPrRxAJSNgjFOqwg8bLsKEHluxqakDoqPklMAjdQYHWvKef2ktEW6N4L324sxzQZHBErPrjMh9BeNGDLxLU2cd7VB05vGaC+2hO4bYyvA+KrbWqgVBXpfUGucJYQZTbDfDTaiREMFlTamPSjYjdeHvEqUEO3BE+R+MEdnHgh+4R1D48uH5NoGfquPlgUgEzkO6qA9iEyIhec2tiCxejqLbHEmA+qDPI7zSVZpKG45V1uoHQMf2bhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SJ0PR11MB5005.namprd11.prod.outlook.com (2603:10b6:a03:2d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 22:01:33 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 22:01:33 +0000
Date: Mon, 28 Sep 2026 15:01:30 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 1/2] drm/xe/dma-buf: keep non-p2p imported buffers in
 system memory
Message-ID: <arrjupxa6R+ehYK5@gsse-cloud1.jf.intel.com>
References: <20260928164820.1237049-4-matthew.auld@intel.com>
 <20260928164820.1237049-5-matthew.auld@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260928164820.1237049-5-matthew.auld@intel.com>
X-ClientProxiedBy: BY3PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::32) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SJ0PR11MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: 752729f2-479d-425a-0f53-08df1dac0f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|260925021311599003|3023799007|260925022911599003|260925021911599003|56012099006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: NpKGBnRhAUTO8LqrtA8V1VLqpggsTNHXJSjP6Vk5+uGYQ29Iq4W6LDn6FPlwPcryhZ1odqAVAu8HV+qKgefHaQMEmSoUF0cnYY8GWrNKCJ0S8rtNJ6akIWbU47mcqnc7f0QPX9UNqvygzQTwyoXNOQrteKnG97qhln/BqxDBT/Vt5radjfnn2NYyw7XX1amYKhjGWwgjuF0WI9i354BHDpajTzPi/nVGuEISA3CGSY3nVel0bnGVdWzom3SiURbfDPojUw4ZK8KL8c+ghiyF5dgvoDnLb3P/YUU6Ztnf4ruoF+tGJD+/3C9AUFcBuZ46yon4JuB7CM2AMtf5nCpuAGz/MbLd1AHfpe6I6s58MPbxdA7QhF7/sP0a36zImgvsqiuyGVLzX3TJNAMEeWd+SDK26eC7v/GhR+cpTn4DSQLbRNa3+Jg2tSAB/jU5Z06D2Fdu7N44spu5PUha9YEHML7s/6V7gStMPw8RATRJe3064VzyJYoJhyHyWW6bfJo7knRoXhNMoRKv/PcR/HnFX6j8Sf7CC0cwV7Bnb8OW0DQUR7Vd/KP/45MNhm8q9f0Uvu44S7aw0/UruIasYtF+4S4DY0CDvjwJF73ASY9XD1+WswY48DET5V26W/btGM0I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(260925021311599003)(3023799007)(260925022911599003)(260925021911599003)(56012099006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?P1NpUAouNNqm9t2qX4bJOEkJ0iP3eTMPtQDMHO0DNR3nim2RH1+WpQNOEF?=
 =?iso-8859-1?Q?oiABuBKfjpC8VDqoq0FDtDJlVDvpH3bon8xyDICFyLc7Ey2wpl2mAczKR2?=
 =?iso-8859-1?Q?fy1GQIw1B9aYxYHnpgDaVdCslpasCcEGPxz2bN5AG0qTVjNMJ3QICPNelq?=
 =?iso-8859-1?Q?9dVIT8mw5g6XUEql1t0DlIiJo5BrLQmuUU1Kd9rQkvG83/IlfIexlQQdUw?=
 =?iso-8859-1?Q?il4k8rVZRdSl5EuhBZ25SsXVfzvk4dFLusPMeaDcqUF1jFYA4y54wxKM46?=
 =?iso-8859-1?Q?eqtc0PDqLVPzQKfAoHdQvlP+k6urFK0KNGrN/dIavaEQvH9x7n3duNzA1l?=
 =?iso-8859-1?Q?wl4zlspWHBIjU7qbwKDVD2Fl5SfEeC9vX3F/P5VtY5t4lF5V366ynmGfXK?=
 =?iso-8859-1?Q?/i73/Q2fMG511Wv+KED+OZF3kRD3kemQudkcKKEz+dBcBVQc08oVIFCrxP?=
 =?iso-8859-1?Q?nVaqeDBJzD1ESeN3Maq2PKCUA0fiGhJfpvxOkgHJzFVHYNJVZ9Z4fA0QP3?=
 =?iso-8859-1?Q?k76CGhfpWD1KFL4VEVdJQ1O2bP9o5goKkFHTwmScQAsQfzLaiRiv5SSORT?=
 =?iso-8859-1?Q?BHrtmg4k84fJzYKrpx7aQ4Xkj6Lhf1GW30KrcjUCGmKUBuOo8HxqDyyMvy?=
 =?iso-8859-1?Q?7xuV4jbXqNXosaEl++7LhLRd+jhTmLpe6PP+KxZOLpUugzM3UhyiZeDKvt?=
 =?iso-8859-1?Q?cOGJUzM/WOW1AY3gCPrvPRNfhyCaG7KwJU28Me+4jun0+YfNFqRajmqh1S?=
 =?iso-8859-1?Q?3Us+RvlvTm9UpQ7NCUTfKftCnvd7k5FN3MF6zyQ0ys0a+RiUqH8owUHA9h?=
 =?iso-8859-1?Q?QVoYJmx4qKL71EMLKHEMmuL0KN2IT0An+B79kmdq9HFHsXdVfHIXNtxGTb?=
 =?iso-8859-1?Q?aFyZ0T1NHeyD+KbrSL+tiWN+uhMvmShaNHvbjxN7TaKYp71V1HzkHEJ+nY?=
 =?iso-8859-1?Q?uGXnoPfszCJ/oDUuDL8wkCff9weUyQuTr9KRmltvj/bL2IwjRm2spH0CJi?=
 =?iso-8859-1?Q?qIdachg18hxT45u7LjZ0Ju95jg+c5MiV8ybowAqG1aTJaP+2Ikxw+WJn98?=
 =?iso-8859-1?Q?Ml02TwHY+9bqPW/tzeBGzo3PQnPPPBGR0qeJvB6SCf5UgrpZQjGUobgv8/?=
 =?iso-8859-1?Q?S54vtzLY0izCAOpFoitOXelFY1lXQY0GjRb4nF69jmXr7MgvCx2QXfkmvl?=
 =?iso-8859-1?Q?m0nOvv2n3Vbb1sKxUvUzeomV22YDAuCOSi/xq93af3rmCDw1JBA5RbUldB?=
 =?iso-8859-1?Q?ELooULqwbmE0z/+5PqYDlu+b0faMD6c39p3K2YK3WDA4qn8uhuG85VIpfI?=
 =?iso-8859-1?Q?gRnCNZnGh01Ell6LkUoMILpujFPwSH2nUaT4kKYXUYNbaDjITzBdKAzd78?=
 =?iso-8859-1?Q?7PZs3XG2KaLC24PUbS4/xMQ6JfFb7ZV6sLsGdVcON5x4xcS686yR5/EcAJ?=
 =?iso-8859-1?Q?GIMJAROMCnlff5O3un4aAknDyYdLGmMmwSWk67Ufs+n3rpeG1gR+0jUmp/?=
 =?iso-8859-1?Q?ae7kyjDCG2Tu/1y/+qMnKG/nKLgcxHtwrSpMuXZvIU+IWFOnb+Co8vK+b8?=
 =?iso-8859-1?Q?bm+s0uBOZsh8VoLujZNLAda7yVt+RlleddhStu9KpnKAuhcz8/PWLiNBfx?=
 =?iso-8859-1?Q?OUCCqUoO6Cm8gi2pGwoaXnxYCsS9ySFw9kgRFqfp3ec7Uf06ICR0TX+6qG?=
 =?iso-8859-1?Q?/HIuzT9YqPJPXxh+sLC3A3gDl5+saHAEJ7J5M6HviDp1uF6pbVpcm2gS8c?=
 =?iso-8859-1?Q?QOVTR5hv5Kvxa6zsQc87YNQxDdGRxBTclcxEbKgUKosv/SQWEQxl1FkIUd?=
 =?iso-8859-1?Q?ozjqeYLobWat8g+dmUNMmXNrsaBC5xg=3D?=
X-Exchange-RoutingPolicyChecked: 3SReAcTYUWLzCDBa0MXeaP/JOBJh1Hb41FMGaoBVFaCx7ZjxwwjAvtAWafzrOFGhhavM9MeTWMMQGNTGkPro6/4fJHOu+aMT2kEww8fGqQuubVmuPrMpZUOWlzHk/IpM7wrxnhQ21KJrUIizTTa30+pd1sVKNwNeIqz7pTu9SsqrFRfWlN2NYgUD6tlRXAaDePTWh3xfNMngnokKdtwuiVbYHfGB4ImdRqJ+VxKvY4p+M5Zh9TYpuvYNr5R+pP01rn62BfJ07wP7Cdvfe4PmUj3iAk+h4aMjYj2MmRCTHGmlOOb9EEpgoB4SOlojO70RpIjJOEan6PRxRiQna+pNWw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 752729f2-479d-425a-0f53-08df1dac0f02
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 22:01:33.4745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRt0GsHkc1dwfeSeY3zSOiS6vGAO6b6KdGXC3r9jAmOEabdbTX2xMVeJllzyjowJePktKRphCuGyt2MeK1Vjkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5005
X-OriginatorOrg: intel.com

On Mon, Sep 28, 2026 at 05:48:22PM +0100, Matthew Auld wrote:
> When an exported buffer is mapped by a foreign device lacking peer-to-peer
> DMA support (such as an integrated GPU for display offload),
> xe_dma_buf_map() migrates the buffer to XE_PL_TT so that system memory
> pages can be accessed by the importer.
> 
> However, since commit 5c87fee3c96c ("drm/xe: Attempt to bring bos back to
> VRAM after eviction"), XE_PL_TT is marked with TTM_PL_FLAG_FALLBACK in
> the buffer's placement. When DMABUF_MOVE_NOTIFY was enabled by default
> (meaning dynamic attachments are no longer pinned on map), the next
> xe_bo_validate() during render submission sees TT as a fallback placement
> and attempts to migrate the buffer back to VRAM.
> 
> On the next frame, the foreign importer accesses the buffer, requiring
> another migration to TT, resulting in a continuous ping-pong between
> VRAM and system memory every frame and causing severe rendering performance
> degradations.
> 
> To fix this, introduce xe_bo_migrate_tt_sticky() which records a
> temporary sticky placement in XE_PL_TT on successful migration. Subsequent
> validations use this sticky placement to keep the buffer in system memory
> until the non-p2p attachment is detached or memory pressure forces a
> fallback to the default placement.
> 
> User is reporting what looks to be exactly this, with horrible
> performance when DMABUF_MOVE_NOTIFY was enabled by default.
> 

The patch looks functionally correct but couldn't we just clear
TTM_PL_FLAG_FALLBACK in xe_bo_migrate for certain callers? Then restore
it in other places?

Matt

> Assisted-by: LLM
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9415
> Fixes: 5c87fee3c96c ("drm/xe: Attempt to bring bos back to VRAM after eviction")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_bo.c       | 59 ++++++++++++++++++++++++++++++--
>  drivers/gpu/drm/xe/xe_bo.h       |  3 ++
>  drivers/gpu/drm/xe/xe_bo_types.h |  4 +++
>  drivers/gpu/drm/xe/xe_dma_buf.c  | 16 ++++++++-
>  4 files changed, 79 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 6921b6967330..1c1eab0a7434 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -3324,6 +3324,9 @@ int xe_bo_validate(struct xe_bo *bo, struct xe_vm *vm, bool allow_res_evict,
>  		.no_wait_gpu = false,
>  		.gfp_retry_mayfail = true,
>  	};
> +	struct ttm_placement *placement = bo->sticky_placement.num_placement ?
> +					  &bo->sticky_placement :
> +					  &bo->placement;
>  	int ret;
>  
>  	if (xe_bo_is_pinned(bo))
> @@ -3340,7 +3343,12 @@ int xe_bo_validate(struct xe_bo *bo, struct xe_vm *vm, bool allow_res_evict,
>  	xe_vm_set_validating(vm, allow_res_evict);
>  	trace_xe_bo_validate(bo);
>  	xe_validation_assert_exec(xe_bo_device(bo), exec, &bo->ttm.base);
> -	ret = ttm_bo_validate(&bo->ttm, &bo->placement, &ctx);
> +	ret = ttm_bo_validate(&bo->ttm, placement, &ctx);
> +	if (ret && ret != -EINTR && ret != -ERESTARTSYS &&
> +	    bo->sticky_placement.num_placement) {
> +		xe_bo_reset_sticky_placement(bo);
> +		ret = ttm_bo_validate(&bo->ttm, &bo->placement, &ctx);
> +	}
>  	xe_vm_clear_validating(vm, allow_res_evict);
>  
>  	return ret;
> @@ -3891,6 +3899,7 @@ int xe_bo_migrate(struct xe_bo *bo, u32 mem_type, struct ttm_operation_ctx *tctx
>  	};
>  	struct ttm_placement placement;
>  	struct ttm_place requested;
> +	int ret;
>  
>  	xe_bo_assert_held(bo);
>  	tctx = tctx ? tctx : &ctx;
> @@ -3922,7 +3931,53 @@ int xe_bo_migrate(struct xe_bo *bo, u32 mem_type, struct ttm_operation_ctx *tctx
>  
>  	if (!tctx->no_wait_gpu)
>  		xe_validation_assert_exec(xe_bo_device(bo), exec, &bo->ttm.base);
> -	return ttm_bo_validate(&bo->ttm, &placement, tctx);
> +	ret = ttm_bo_validate(&bo->ttm, &placement, tctx);
> +	if (!ret)
> +		xe_bo_reset_sticky_placement(bo);
> +	return ret;
> +}
> +
> +/**
> + * xe_bo_migrate_tt_sticky - Migrate an object to TT and record its placement as sticky
> + * @bo: The buffer object to migrate.
> + * @tctx: The ttm_operation_ctx to use for migration, or NULL for default.
> + * @exec: The drm_exec transaction to use for exhaustive eviction.
> + *
> + * Like xe_bo_migrate() to XE_PL_TT, but on success records the resulting placement
> + * so that subsequent validations try to keep the object in TT instead of falling
> + * back to the default placement. The stickiness is removed if validation falls
> + * back to the default placement (e.g. under memory pressure), on any non-sticky
> + * migration, or via an explicit call to xe_bo_reset_sticky_placement().
> + *
> + * Return: 0 on success. Negative error code on failure.
> + */
> +int xe_bo_migrate_tt_sticky(struct xe_bo *bo,
> +			    struct ttm_operation_ctx *tctx,
> +			    struct drm_exec *exec)
> +{
> +	int ret;
> +
> +	ret = xe_bo_migrate(bo, XE_PL_TT, tctx, exec);
> +	if (!ret) {
> +		xe_place_from_ttm_type(XE_PL_TT, &bo->sticky_place);
> +		bo->sticky_placement = (struct ttm_placement){
> +			.num_placement = 1,
> +			.placement = &bo->sticky_place,
> +		};
> +	}
> +	return ret;
> +}
> +
> +/**
> + * xe_bo_reset_sticky_placement - Reset sticky placement for an object
> + * @bo: The buffer object whose sticky placement should be cleared.
> + *
> + * Clear any sticky placement recorded by xe_bo_migrate_tt_sticky(),
> + * returning subsequent validations to the default placement.
> + */
> +void xe_bo_reset_sticky_placement(struct xe_bo *bo)
> +{
> +	bo->sticky_placement.num_placement = 0;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
> index 861b1be231de..7327628070f2 100644
> --- a/drivers/gpu/drm/xe/xe_bo.h
> +++ b/drivers/gpu/drm/xe/xe_bo.h
> @@ -434,6 +434,9 @@ bool xe_bo_can_migrate(struct xe_bo *bo, u32 mem_type);
>  
>  int xe_bo_migrate(struct xe_bo *bo, u32 mem_type, struct ttm_operation_ctx *ctc,
>  		  struct drm_exec *exec);
> +int xe_bo_migrate_tt_sticky(struct xe_bo *bo, struct ttm_operation_ctx *ctc,
> +			    struct drm_exec *exec);
> +void xe_bo_reset_sticky_placement(struct xe_bo *bo);
>  int xe_bo_evict(struct xe_bo *bo, struct drm_exec *exec);
>  
>  int xe_bo_evict_pinned(struct xe_bo *bo);
> diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
> index 8ec4a01a0092..253a1dba55a7 100644
> --- a/drivers/gpu/drm/xe/xe_bo_types.h
> +++ b/drivers/gpu/drm/xe/xe_bo_types.h
> @@ -56,6 +56,10 @@ struct xe_bo {
>  	struct ttm_place placements[XE_BO_MAX_PLACEMENTS];
>  	/** @placement: current placement for this BO */
>  	struct ttm_placement placement;
> +	/** @sticky_placement: target placement from forced migration */
> +	struct ttm_placement sticky_placement;
> +	/** @sticky_place: place for sticky_placement */
> +	struct ttm_place sticky_place;
>  	/** @ggtt_node: Array of GGTT nodes if this BO is mapped in the GGTTs */
>  	struct xe_ggtt_node *ggtt_node[XE_MAX_TILES_PER_DEVICE];
>  	/** @vmap: iosys map of this buffer */
> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
> index 6a85b292dee7..b973579a69b8 100644
> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> @@ -59,6 +59,20 @@ static void xe_dma_buf_detach(struct dma_buf *dmabuf,
>  			      struct dma_buf_attachment *attach)
>  {
>  	struct drm_gem_object *obj = attach->dmabuf->priv;
> +	struct xe_bo *bo = gem_to_xe_bo(obj);
> +	bool has_non_p2p = false;
> +	struct dma_buf_attachment *a;
> +
> +	dma_resv_lock(dmabuf->resv, NULL);
> +	list_for_each_entry(a, &dmabuf->attachments, node) {
> +		if (!a->peer2peer) {
> +			has_non_p2p = true;
> +			break;
> +		}
> +	}
> +	if (!has_non_p2p)
> +		xe_bo_reset_sticky_placement(bo);
> +	dma_resv_unlock(dmabuf->resv);
>  
>  	xe_pm_runtime_put(to_xe_device(obj->dev));
>  }
> @@ -129,7 +143,7 @@ static struct sg_table *xe_dma_buf_map(struct dma_buf_attachment *attach,
>  
>  	if (!xe_bo_is_pinned(bo)) {
>  		if (!attach->peer2peer)
> -			r = xe_bo_migrate(bo, XE_PL_TT, NULL, exec);
> +			r = xe_bo_migrate_tt_sticky(bo, NULL, exec);
>  		else
>  			r = xe_bo_validate(bo, NULL, false, exec);
>  		if (r)
> -- 
> 2.55.0
> 
