Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5830D43C7AB;
	Tue,  7 Jul 2026 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449724; cv=fail; b=rdn+bN/h+NtD3vgPsvL6nKW+VYiAtVgDeGqT2JKDR5f6eIVVVjrUFs0bI6C1HQwcnMjV/DN0HzNBf68NlhsDc97ggFCDvqksYaLVYi323ZmzS8l9wWLeVjh0MY7ektCarrSmfzmLhIhFQ3Ivg5QXLvDWtQs3gfQM3LC9EbBzYoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449724; c=relaxed/simple;
	bh=H7ZZfpb/wnzCkMTnVa+BvwKLdoBY9EoRHic2wdGQGLs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MEvE7NQTZjO0GTYy3lEyS754oRdsFG5X3Fe9lX+ntM+LlmT3kejSYdzybnwqB/AFAnl79degEwaIVCp06kOrOPOHdUOntDZszcQVU8vx3SCDD5GB4ncZn4jXDyGVF7EMz+G+s4QmgE/9TvMK4ls1ylr71NZlHTqM8CokVgRijjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXAqm9gz; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXAqm9gz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783449723; x=1814985723;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=H7ZZfpb/wnzCkMTnVa+BvwKLdoBY9EoRHic2wdGQGLs=;
  b=jXAqm9gzjEYlsh51nrKgrst/pV7HD0nwrud+xPsGhrMhfWnHJVDfY17c
   v+U6P4DFxw1Eh+yv7caaj1+ky7iYnUJX1VLH5qzK+Iypgo9QhhJroK6Y7
   okg/BDOCr7OmPEFHupSwXD12z6dpYC2l8POyHQfKghfohnDuJRHojZzmw
   Za5Pw0hDgUFcWxTvplbcpPthr2Ldemqc/tHLdtLAgJw0dO+UM0YmGpLe/
   3Yl8iA97TrqJIQXJMSYHka5sVkA3GIo4OcR3yECUaezFbXuYU5/le2NIM
   ayrt4+OHMd7+iD2/eUDqEMQyWqck5pdwVafCD7w1S6cX9Df0aaHgeYXyi
   g==;
X-CSE-ConnectionGUID: MoXeA/q1S3SWc34Q5kP5zw==
X-CSE-MsgGUID: geLzE6lyQNKO/SXSB5sA6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="101654611"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="101654611"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:42:01 -0700
X-CSE-ConnectionGUID: vjAcC9cQQ4+hEHLqd8g0PA==
X-CSE-MsgGUID: CINqpys8QP6vhIyW8ZD1gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="292252455"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:42:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 11:42:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 11:42:00 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.32)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 11:42:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qa8GmNK4BF9TKQ7ss16Qf/6OlQjsDgvQ4rUsYwxnia/xGkT/mD5F9B/imp4MtlrELSKJZnGPhVlQojwARAGfNS4jPaXKI/7erbAbTG41fOvNHEOKvj1tyfhAKryYF7qIViVB+U7/V2xc/vwIAkTZKsMLs6qywgPjvnwud8SXh6jhme4nLimYE8nFuUCfUuVYa6/5Ih+30JNWzh8tyqNy3JI1wRsWUHkq8CWD7qPXkt5rw9O8w8vXRYzSd5I2mNWMTjS22rJWyfu23jW9mOatdXUw9bFCWbiIyycTxqAnuYYf2lkj6rl2oDnsdlcUZRNJjyiYofGfdO2uq/oFE7lPng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQLuqi3sCuFiJ8caKdjyM+ktNbHFFu2g5GLgQInk+80=;
 b=aA5qkOh7EVc6fJviSGBVQgh9IWS1mJ3Cz8cHgJk1v93N83jg7N0p2lflAqzAxJ++1fiv+y9zL9nrND5S02lJBmR4AjmUWK8Gu2RQE18zAE5bdya2xVpU3FSb5/B87PRZokurh0/Ss4P43NonawudghvG/vqsBqz0XbBQxIvDu/x9RqCJEs4O+5Z0GkmloH8Ml83xik9o5oP6sx55nAP1dcAFIVYH+ZDPYdzXl8YRa8m/vWx1YGYlPWDYiYBvxMA2zHcHTnoHsvYQGZDNTyMR2142zlsH/UEsdWL5LWTjzqBOuVoUkKyWc2sgC2Cg4BeobApIx2y1/p5uzR4gneW4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 SJ0PR11MB6789.namprd11.prod.outlook.com (2603:10b6:a03:47f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 18:41:49 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 18:41:49 +0000
Date: Tue, 7 Jul 2026 20:41:35 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Eddie Phillips <eddiephillips@google.com>
CC: Harshitha Ramamurthy <hramamurthy@google.com>, <netdev@vger.kernel.org>,
	<joshwash@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <bpf@vger.kernel.org>, <sdf@fomichev.me>,
	<willemb@google.com>, <jordanrhee@google.com>, <nktgrg@google.com>,
	<maolson@google.com>, <jacob.e.keller@intel.com>, <thostet@google.com>,
	<csully@google.com>, <bcf@google.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH net] gve: fix Rx queue stall on alloc failure
Message-ID: <ak1H+kopuzebpnun@boxer>
References: <20260701005341.3699161-1-hramamurthy@google.com>
 <akUUXT6UwTTD2yOs@boxer>
 <CAPBb8HmE6q0VPa5PooFP3VFF27GU3B4622Xww6MHRT-9i4zTxA@mail.gmail.com>
 <akfd5abdGbxFl5o9@boxer>
 <CAPBb8HnXL-G692yRZYatA2m=X_YpNWG2eDhQzzM+Enq1apyC8Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPBb8HnXL-G692yRZYatA2m=X_YpNWG2eDhQzzM+Enq1apyC8Q@mail.gmail.com>
X-ClientProxiedBy: VIVP296CA0060.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35a::14) To DM4SPRMB0045.namprd11.prod.outlook.com
 (2603:10b6:8:6e::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|SJ0PR11MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 946a7afe-2fb6-4944-b89b-08dedc576761
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|4143699003|6133799003|11063799006|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: aqeWukpHs0F2n1KQ7TW57/4UDmHGefcUhlvHWEB58jbuSBXcOH8ej9zxVOE7nZ1hc52se7855e/Jakmd+kXgU9rmoRNmsmQJuNLD/QFinRHWDP+r9F7BpIMYktFnOHG3AjnoNuED/cynlA14unQYru8Yhsa3Z1WLkIz/uRIjjcffa5dmwhd66r8P8vA6zIFsF8PVVi/Q8QKV81L5lsucGBzuHeoIVBNdhmTJG977iz62irq3S+nIPDKXnLihwFkfAQe3HMYoIl7fA/mDwMZoA5NY0vdMbyA8+rZLk7HNnW3ZB7km7g4AOSXms9nZHXzRC86AUGII/crYKaM9fqfMP3w/Mm7EiysJd9WzNU+9fy/ntKFdJZUIjiWuPkPXc2qO5TimilcC6pkBQ6wofyq7zH40nEp7b8ErDagZtKdWpxR87K4JzgXiTwpIDNtli6CWpem69p+WixN3hcKxYLm8Jv/4LMfgpYfKysRG7XlDLoOfx8SuPcnVbrlKbe9JbyfkHgMZUbIvVwCSMWnTzB6qCorsUNL8U3u/DePJ8KCAN2IdEx0yhlqQwRvKslI+j8R7X6ggm+JOWPXuvPIW3Otd6nfrFK6SwYy6uxO9tJd5bFH/VbtP653wXqUme8ytuHTqmBG9c71iOmcMEN3ROa0Eu8ipPnxFH87eyG7Qkia8/1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(4143699003)(6133799003)(11063799006)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWgwZmVia05jbWFIWVVCdHI2aUZYRU9qR1FDME1FK1NHN0dFMk9yVmJpR2pj?=
 =?utf-8?B?Q2JBVjFxcnoyNFY2bGVkeFFCV3JDVlM2TXpXUDRMVmN6TGtTOGo2MzZJdjBP?=
 =?utf-8?B?QTdaUDhHZEJCY2RrQ1JKOGJ2eDlhNTVkblY1cDN4VE55a2xKTjBXbU9wTit1?=
 =?utf-8?B?ZHY4SEtKMUI3WE8ybmE5NFFrM20xR2REREltUHUyZmRvSnZBbUF6NzJBZmJY?=
 =?utf-8?B?cGoxNFRtVk9BaHJZSHcvdSsxMVl4cHBhMGZsU21mZFZ5STgwZVhFMUZ4OW1N?=
 =?utf-8?B?dDQzNVF3a09LNkpHdkVVaGF0SXhodE5WOGNvNkhxYkgxK2NUeFNGZ3pjTmJI?=
 =?utf-8?B?bDFTaHo3ZC9lWTJ0ZzlTaEVsWkUvaGxLUk9vZm0zakZLakIzcXQxVDV5RWpI?=
 =?utf-8?B?WGN0cDIreS9pWTAyRm9RUjB4bVRqcSs1NVFlNWFGWFNVcENVRGJJbTFzWHlJ?=
 =?utf-8?B?ZXltOUNTOWpCblNLNCtqVHk3bFJpN3l4YzBNWHR3eGVjdWVvVVpDTldYN29R?=
 =?utf-8?B?M2VCVklDSEt6VllvQkZyTWVpVzR5ZTdGT1JtSXdxZjRvc0J2TjdQWFRseTJ5?=
 =?utf-8?B?MWw2Qzc0Vm9COVhpSks3d0VsbllvaFdSV2dOTFJxMGYwQjJSWGZ2Q2o0bGRL?=
 =?utf-8?B?WTJLa1dDNDQ3cmxRQzRCZFkvZjkwbklXS25BWjdTQ052cGJFUFYrTHYyRm8z?=
 =?utf-8?B?SDFSb0hKcUp5ZU0zZ3NRZzdNMUpvUXI1bm0zTEYxdWVOUXBoMG51NDQ3Z3pF?=
 =?utf-8?B?Tmc2RzlZVzJHN0EyMEpqdEloTWd5UVM1U0ZmbE9mdW54QXlQMXBpZktid2sr?=
 =?utf-8?B?YzBzaS9Rc0h1YjI0ZWdWMGRKWit0T0FDcG1meUpCS1l4eU9SY3V1T2JFR0t2?=
 =?utf-8?B?cWREMEcxN3l5OVY5Uzlqb003U2Fab0JiQmJ3ajBkeFVKWkd6QTNaWHh6VHJm?=
 =?utf-8?B?U3Yvb01jSyt1UXJYUko2dnV5VWN5dVZmbzQwQ2xUMGx4QU1BMXBJS0w5WnU0?=
 =?utf-8?B?S09TUDdxNWJYQ2k2S2R2cmh1WWZxakJDRWtGNVhucFZidlJtTW9ibEtZa0Y0?=
 =?utf-8?B?QWR1SkdrYzZHS09scWVTN2V5cDFoc1FtQTd0OVdRY0ZkNFFRekFPaTlVTEtq?=
 =?utf-8?B?SHB2R2I1YS9RSGoydUNhZ255dFhzdHFlK1I3eXhHbXNGV1VSWVVlTlN0UUto?=
 =?utf-8?B?YytjbGtIUU1ndlYyU0JqWHBhdTN4cTRUTVdWSFZIb0U0WDRYTE1YdVhPbC80?=
 =?utf-8?B?NjN6UENqR2owQTRucEhQSWhGRFFWc21zTGk2ZmhrdjJDS3o0SlhKRGxiUWo1?=
 =?utf-8?B?Rld2T1dHTGJ3VVo3QURSSERvd2I0bkFkODYrb0dBb2FEVVVtTkJvcEVHUXkw?=
 =?utf-8?B?Z0JBM3p6dEZIRDhaaHAwdmlRZ2NYeGcvMzlwNVhzeS94MW1PMFIwbitQWDVl?=
 =?utf-8?B?Z1gwdnFnSlhNMzBPSEc3Mmk3dk1nVUM2cHp0TUIwMXROWlZ1eGgyMmxudTNx?=
 =?utf-8?B?MEJ0S0hzY1cxek1NSitHbUs0NVBlR0wvNWlqMjY4eFpCdTFLS2lHWVFMMUJu?=
 =?utf-8?B?cGZ6MFJLdTl5NWRnemxCdnJFdEdEODFOMzFYMWhzcm8rMXZRWEpUZkV0Vllx?=
 =?utf-8?B?VUlBNTlNcVVEOFFlaHdldWNtZ0RLU3hBNHU5VkFjTDgrQXV6WXhmQkNaMEtS?=
 =?utf-8?B?YlV4WFpmbG1Cc3luM0JBMWhtbjFIaGRyUlhmdDY5akpKUmNjQmI1WTZ4L0pF?=
 =?utf-8?B?OXpIOUdkVWdqZk1YVDlVMEJzUWtWa2VsMVBDanZJUkgvNjZZc25MNFhYZXlL?=
 =?utf-8?B?c1M4eUtSYmRCdSt0ck5JWW5zMG5ndTV0cjVFcjVNSHdDYWFMZ3hBVkF4NmtF?=
 =?utf-8?B?cC9MR2tpZi9SMWtTVDJmdE9aNU5XTWVOZzV3c0lqU3Jhd0pmL2s3dG9xSXBu?=
 =?utf-8?B?b2pjMXp1dWQ4SFFBdk5ET1htSWpvcEhNOE1uektTcUp2eGpEeHlKYS82alRh?=
 =?utf-8?B?Ync3aVpOMTQ4SkkvV05qeDVBYTVFemMrNW5NSlFmTzQ4YllCSURGN1k5UU1M?=
 =?utf-8?B?SCtVL2oyeDFmdnc3STNZS2NyakgzVUFxK0d2V0orVitHbWdzY2dWeHJINXlx?=
 =?utf-8?B?bUthQmM1cUNSbHdJRExqMUk0WGlDUXEzaGxSbU1tUTRROXZRQUdBb01LTnh2?=
 =?utf-8?B?c2xBYVYzN0x4OEhhM01DUnQrTmR3ei9sQ2JYamJYTE01K3dIM0NYVTVrQTNj?=
 =?utf-8?B?K0NwMDZ0QklSUi8vd0RrOXNidE9rWGJQU1lvNHJ4L01HOG5vWXNvUm9PMzQ1?=
 =?utf-8?B?MHZibllmdXdKaVdxazllSHF1d082aUhqeCtzTEc3MWFqNnZpcVBrT3IxSmNW?=
 =?utf-8?Q?F8HuopWQFgJ9NjCY=3D?=
X-Exchange-RoutingPolicyChecked: b5ZCoXCQtuzB/FH8VKJVXUXQc7pg1wLi1XMu2xMkRs7uLFVHNJsOxijhcwBYpLTAVud2165L2M7hoc1I0Sr73wDklJlquIw0EACcXmDUCd4uYEREPN0KZ9blEJtGRG/5ufxRyhaUd+ukSHjKYSCqL4zzZdnvdR/qau5cWQuwEc2PtHj7dEQZvTu+4svScMNeaav+78WKEP/dQ8V2GlCb2HCCZBeZDuC3HE8VV9ISaZVAeYe1QI5v8tnAujzs3s83lceAbkzbMKMh+48s6681Not7faJ/HJAg2rboc23YcjJz4bFKfHLoYbSaejjIymZ4atF80VQ8BIHzD1n2ZQ3vag==
X-MS-Exchange-CrossTenant-Network-Message-Id: 946a7afe-2fb6-4944-b89b-08dedc576761
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 18:41:49.0039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8chXePo6Oy0rBVVLtGyM2DbRczf4trO3Gm/nqx7mu00oiFt7MTXBEWUI1b/K8sR+QXKeSMxLuS4Smr9qprExhabkJ14b96dDoode407Lgts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6789
X-OriginatorOrg: intel.com

On Tue, Jul 07, 2026 at 10:28:59AM -0700, Eddie Phillips wrote:
> On Fri, Jul 3, 2026 at 9:06 AM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Fri, Jul 03, 2026 at 01:03:20AM -0700, Eddie Phillips wrote:
> > > > I think this deserves to be pulled out of the timer logic?
> > >
> > > If by this you mean pull the stats into a separate patch, I agree.
> >
> > Hi Eddie,
> >
> > instead of forming a response at the top of the mail, please have your
> > answers inlined; it is preferred way of communication on mailing lists.
> >
> > >
> > > > - couldn't you detect this case within napi poll loop?
> > >
> > > It can only be detected after attempting to refill the queue and finding
> > > that we are still below the critical threshold.
> > >
> > > > - if not, does it have to be per-q timer? wouldn't one global per pf timer
> > > >   satisfy your needs?
> > >
> > > There are a few ways a global timer could be implemented,
> > >  - The global timer could queue napi for *all* queues, which would
> > > result in a lot of unnecessary work.
> > >  - The global timer could iterate over each queue and try to detect
> > > the critical low buffer condition, however this would require
> > > introducing synchronization between the timer and the napis, which
> > > would introduce expensive locking into the hot path.
> > >  - The global timer could be paired with a bitmap that stores which
> > > queues need to be serviced.
> >
> > bitmap would probably do the job but i won't insist here tho.
> >
> > One more question/idea:
> > Before arming the starvation timer, could we first try to make a smaller batch
> > of already-posted buffers visible to HW?
> 
> The maximum number of descriptors that a single RSC packet can consume
> is 19, so 8 descriptors isn't enough to receive a maximum-sized RSC
> packet. If the hardware runs out of buffers, it is supposed to close

standard MAX_SKB_FRAGS is not enough either. are you actually receiving
that maxed out packets on your setup? What I suggested would probably help
at standard mtu traffic, but I think it's enough of discussing.

> the RSC window and flush the descriptors, but operating this close to
> the hardware's limits could be risky in case there are HW bugs or edge
> cases we're unaware of. I think building in a safety margin would be more
> robust.
> 
> > It seems the HW can accept RX buffer tail doorbell updates at a granularity
> > lower than the normal `GVE_RX_BUF_THRESH_DQO` batching threshold, apparently as
> > low as 8 descriptors. If that is the case, could we first use this as an
> > emergency low-watermark path: when refill posts at least 8 descriptors but does
> > not reach the normal 32-descriptor threshold, ring the doorbell immediately and
> > only arm the starvation timer if even that lower threshold cannot be reached?
> >
> > >
> > > A `struct timer_list` is only 40 bytes, so the current implemention is
> > > not expensive. Though a global timer is valid, it's not strictly better.
> > >
> > > That said, I agree that we can clean up the structure—I will move the
> > > timer state from the individual RX rings to the `gve_priv` structure.
> > >
> > > On Wed, Jul 1, 2026 at 6:22 AM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > On Wed, Jul 01, 2026 at 12:53:41AM +0000, Harshitha Ramamurthy wrote:
> > > > > From: Eddie Phillips <eddiephillips@google.com>
> > > > >
> > > > > When the system is under extreme memory pressure, page allocations can
> > > > > fail during the Rx buffer refill loop. If the number of buffers posted
> > > > > to hardware falls below a critical low threshold and the refill loop
> > > > > exits due to allocation failures, the queue can stall:
> > > > >
> > > > > 1. The device drops incoming packets because there are no descriptors.
> > > > > 2. Since no packets are processed, no Rx completions are generated.
> > > > > 3. Because no completions occur, NAPI is never scheduled, preventing
> > > > >    the refill loop from running again even after memory is freed.
> > > > >
> > > > > This results in a permanent queue stall.
> > > > >
> > > > > Resolve this by introducing a starvation recovery timer for each Rx queue.
> > > > > If the number of buffers posted to hardware falls below a critical low
> > > > > threshold, start a timer to periodically reschedule NAPI. Once NAPI runs
> > > > > and successfully refills the queue above the threshold, the timer is
> > > > > not rescheduled.
> > > > >
> > > > > Also add a new ethtool statistic "rx_critical_low_bufs" to track the
> > > > > number of times the starvation recovery timer is triggered.
> > > >
> > > > I think this deserves to be pulled out of the timer logic?
> > > >
> > > > Two questions tho:
> > > > - couldn't you detect this case within napi poll loop?
> > > > - if not, does it have to be per-q timer? wouldn't one global per pf timer
> > > >   satisfy your needs?
> > > >
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
> > > > > Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> > > > > Signed-off-by: Eddie Phillips <eddiephillips@google.com>
> > > > > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > > > > ---
> > > > >  drivers/net/ethernet/google/gve/gve.h         |  4 ++++
> > > > >  drivers/net/ethernet/google/gve/gve_ethtool.c | 14 +++++++++++++-
> > > > >  drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 32 ++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 49 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> > > > > index 2f7bd330..8378bef2 100644
> > > > > --- a/drivers/net/ethernet/google/gve/gve.h
> > > > > +++ b/drivers/net/ethernet/google/gve/gve.h
> > > > > @@ -13,6 +13,7 @@
> > > > >  #include <linux/netdevice.h>
> > > > >  #include <linux/net_tstamp.h>
> > > > >  #include <linux/pci.h>
> > > > > +#include <linux/timer.h>
> > > > >  #include <linux/ptp_clock_kernel.h>
> > > > >  #include <linux/u64_stats_sync.h>
> > > > >  #include <net/page_pool/helpers.h>
> > > > > @@ -41,6 +42,7 @@
> > > > >
> > > > >  /* Interval to schedule a stats report update, 20000ms. */
> > > > >  #define GVE_STATS_REPORT_TIMER_PERIOD        20000
> > > > > +#define GVE_RX_NAPI_RESCHED_MS 20 /* msecs */
> > > > >
> > > > >  /* Numbers of NIC tx/rx stats in stats report. */
> > > > >  #define NIC_TX_STATS_REPORT_NUM      0
> > > > > @@ -318,6 +320,7 @@ struct gve_rx_ring {
> > > > >       u64 rx_copied_pkt; /* free-running total number of copied packets */
> > > > >       u64 rx_skb_alloc_fail; /* free-running count of skb alloc fails */
> > > > >       u64 rx_buf_alloc_fail; /* free-running count of buffer alloc fails */
> > > > > +     u64 rx_critical_low_bufs; /* count of critical low buffer events */
> > > > >       u64 rx_desc_err_dropped_pkt; /* free-running count of packets dropped by descriptor error */
> > > > >       /* free-running count of unsplit packets due to header buffer overflow or hdr_len is 0 */
> > > > >       u64 rx_hsplit_unsplit_pkt;
> > > > > @@ -334,6 +337,7 @@ struct gve_rx_ring {
> > > > >       struct gve_queue_resources *q_resources; /* head and tail pointer idx */
> > > > >       dma_addr_t q_resources_bus; /* dma address for the queue resources */
> > > > >       struct u64_stats_sync statss; /* sync stats for 32bit archs */
> > > > > +     struct timer_list starvation_timer; /* for queue starvation recovery */
> > > > >
> > > > >       struct gve_rx_ctx ctx; /* Info for packet currently being processed in this ring. */
> > > > >
> > > > > diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
> > > > > index a0e0472b..71b6efbf 100644
> > > > > --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> > > > > +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> > > > > @@ -46,6 +46,7 @@ static const char gve_gstrings_main_stats[][ETH_GSTRING_LEN] = {
> > > > >       "rx_hsplit_unsplit_pkt",
> > > > >       "interface_up_cnt", "interface_down_cnt", "reset_cnt",
> > > > >       "page_alloc_fail", "dma_mapping_error", "stats_report_trigger_cnt",
> > > > > +     "rx_critical_low_bufs",
> > > > >  };
> > > > >
> > > > >  static const char gve_gstrings_rx_stats[][ETH_GSTRING_LEN] = {
> > > > > @@ -58,6 +59,7 @@ static const char gve_gstrings_rx_stats[][ETH_GSTRING_LEN] = {
> > > > >       "rx_xdp_aborted[%u]", "rx_xdp_drop[%u]", "rx_xdp_pass[%u]",
> > > > >       "rx_xdp_tx[%u]", "rx_xdp_redirect[%u]",
> > > > >       "rx_xdp_tx_errors[%u]", "rx_xdp_redirect_errors[%u]", "rx_xdp_alloc_fails[%u]",
> > > > > +     "rx_critical_low_bufs[%u]",
> > > > >  };
> > > > >
> > > > >  static const char gve_gstrings_tx_stats[][ETH_GSTRING_LEN] = {
> > > > > @@ -151,12 +153,14 @@ gve_get_ethtool_stats(struct net_device *netdev,
> > > > >  {
> > > > >       u64 tmp_rx_pkts, tmp_rx_hsplit_pkt, tmp_rx_bytes, tmp_rx_hsplit_bytes,
> > > > >               tmp_rx_skb_alloc_fail, tmp_rx_buf_alloc_fail,
> > > > > +             tmp_rx_critical_low_bufs,
> > > > >               tmp_rx_desc_err_dropped_pkt, tmp_rx_hsplit_unsplit_pkt,
> > > > >               tmp_tx_pkts, tmp_tx_bytes,
> > > > >               tmp_xdp_tx_errors, tmp_xdp_redirect_errors;
> > > > >       u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_hsplit_unsplit_pkt,
> > > > >               rx_pkts, rx_hsplit_pkt, rx_skb_alloc_fail, rx_bytes, tx_pkts, tx_bytes,
> > > > > -             tx_dropped, xdp_tx_errors, xdp_redirect_errors;
> > > > > +             rx_critical_low_bufs, tx_dropped, xdp_tx_errors,
> > > > > +             xdp_redirect_errors;
> > > > >       int rx_base_stats_idx, max_rx_stats_idx, max_tx_stats_idx;
> > > > >       int stats_idx, stats_region_len, nic_stats_len;
> > > > >       struct stats *report_stats;
> > > > > @@ -197,6 +201,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
> > > > >
> > > > >       for (rx_pkts = 0, rx_bytes = 0, rx_hsplit_pkt = 0,
> > > > >            rx_skb_alloc_fail = 0, rx_buf_alloc_fail = 0,
> > > > > +          rx_critical_low_bufs = 0,
> > > > >            rx_desc_err_dropped_pkt = 0, rx_hsplit_unsplit_pkt = 0,
> > > > >            xdp_tx_errors = 0, xdp_redirect_errors = 0,
> > > > >            ring = 0;
> > > > > @@ -212,6 +217,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
> > > > >                               tmp_rx_bytes = rx->rbytes;
> > > > >                               tmp_rx_skb_alloc_fail = rx->rx_skb_alloc_fail;
> > > > >                               tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
> > > > > +                             tmp_rx_critical_low_bufs =
> > > > > +                                     rx->rx_critical_low_bufs;
> > > > >                               tmp_rx_desc_err_dropped_pkt =
> > > > >                                       rx->rx_desc_err_dropped_pkt;
> > > > >                               tmp_rx_hsplit_unsplit_pkt =
> > > > > @@ -226,6 +233,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
> > > > >                       rx_bytes += tmp_rx_bytes;
> > > > >                       rx_skb_alloc_fail += tmp_rx_skb_alloc_fail;
> > > > >                       rx_buf_alloc_fail += tmp_rx_buf_alloc_fail;
> > > > > +                     rx_critical_low_bufs += tmp_rx_critical_low_bufs;
> > > > >                       rx_desc_err_dropped_pkt += tmp_rx_desc_err_dropped_pkt;
> > > > >                       rx_hsplit_unsplit_pkt += tmp_rx_hsplit_unsplit_pkt;
> > > > >                       xdp_tx_errors += tmp_xdp_tx_errors;
> > > > > @@ -269,6 +277,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
> > > > >       data[i++] = priv->page_alloc_fail;
> > > > >       data[i++] = priv->dma_mapping_error;
> > > > >       data[i++] = priv->stats_report_trigger_cnt;
> > > > > +     data[i++] = rx_critical_low_bufs;
> > > > >       i = GVE_MAIN_STATS_LEN;
> > > > >
> > > > >       rx_base_stats_idx = 0;
> > > > > @@ -337,6 +346,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
> > > > >                               tmp_rx_hsplit_bytes = rx->rx_hsplit_bytes;
> > > > >                               tmp_rx_skb_alloc_fail = rx->rx_skb_alloc_fail;
> > > > >                               tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
> > > > > +                             tmp_rx_critical_low_bufs =
> > > > > +                                     rx->rx_critical_low_bufs;
> > > > >                               tmp_rx_desc_err_dropped_pkt =
> > > > >                                       rx->rx_desc_err_dropped_pkt;
> > > > >                               tmp_xdp_tx_errors = rx->xdp_tx_errors;
> > > > > @@ -381,6 +392,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
> > > > >                       } while (u64_stats_fetch_retry(&priv->rx[ring].statss,
> > > > >                                                      start));
> > > > >                       i += GVE_XDP_ACTIONS + 3; /* XDP rx counters */
> > > > > +                     data[i++] = tmp_rx_critical_low_bufs;
> > > > >               }
> > > > >       } else {
> > > > >               i += priv->rx_cfg.num_queues * NUM_GVE_RX_CNTS;
> > > > > diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > > > > index 02cba280..303db4fa 100644
> > > > > --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > > > > +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > > > > @@ -18,6 +18,16 @@
> > > > >  #include <net/tcp.h>
> > > > >  #include <net/xdp_sock_drv.h>
> > > > >
> > > > > +static void gve_rx_starvation_timer(struct timer_list *t)
> > > > > +{
> > > > > +     struct gve_rx_ring *rx = timer_container_of(rx, t, starvation_timer);
> > > > > +     struct gve_priv *priv = rx->gve;
> > > > > +     struct gve_notify_block *block;
> > > > > +
> > > > > +     block = &priv->ntfy_blocks[rx->ntfy_id];
> > > > > +     napi_schedule(&block->napi);
> > > > > +}
> > > > > +
> > > > >  static void gve_rx_free_hdr_bufs(struct gve_priv *priv, struct gve_rx_ring *rx)
> > > > >  {
> > > > >       struct device *hdev = &priv->pdev->dev;
> > > > > @@ -120,6 +130,7 @@ void gve_rx_stop_ring_dqo(struct gve_priv *priv, int idx)
> > > > >
> > > > >       if (rx->dqo.page_pool)
> > > > >               page_pool_disable_direct_recycling(rx->dqo.page_pool);
> > > > > +     timer_delete_sync(&rx->starvation_timer);
> > > > >       gve_remove_napi(priv, ntfy_idx);
> > > > >       gve_rx_remove_from_block(priv, idx);
> > > > >       gve_rx_reset_ring_dqo(priv, idx);
> > > > > @@ -136,6 +147,8 @@ void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
> > > > >       u32 qpl_id;
> > > > >       int i;
> > > > >
> > > > > +     timer_shutdown_sync(&rx->starvation_timer);
> > > > > +
> > > > >       completion_queue_slots = rx->dqo.complq.mask + 1;
> > > > >       buffer_queue_slots = rx->dqo.bufq.mask + 1;
> > > > >
> > > > > @@ -232,6 +245,7 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
> > > > >       rx->gve = priv;
> > > > >       rx->q_num = idx;
> > > > >       rx->packet_buffer_size = cfg->packet_buffer_size;
> > > > > +     timer_setup(&rx->starvation_timer, gve_rx_starvation_timer, 0);
> > > > >
> > > > >       if (cfg->xdp) {
> > > > >               rx->packet_buffer_truesize = GVE_XDP_RX_BUFFER_SIZE_DQO;
> > > > > @@ -365,6 +379,7 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
> > > > >       struct gve_rx_compl_queue_dqo *complq = &rx->dqo.complq;
> > > > >       struct gve_rx_buf_queue_dqo *bufq = &rx->dqo.bufq;
> > > > >       struct gve_priv *priv = rx->gve;
> > > > > +     u32 num_bufs_avail_to_hw;
> > > > >       u32 num_avail_slots;
> > > > >       u32 num_full_slots;
> > > > >       u32 num_posted = 0;
> > > > > @@ -400,6 +415,23 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
> > > > >       }
> > > > >
> > > > >       rx->fill_cnt += num_posted;
> > > > > +
> > > > > +     /* If the queue has fewer than GVE_RX_BUF_THRESH_DQO descriptors
> > > > > +      * visible to the hardware, and no doorbell was written, the hardware
> > > > > +      * is in danger of starving and cannot trigger interrupts. Start the
> > > > > +      * timer to periodically reschedule NAPI and recover from starvation.
> > > > > +      */
> > > > > +     num_bufs_avail_to_hw =
> > > > > +             ((bufq->tail & ~(GVE_RX_BUF_THRESH_DQO - 1)) -
> > > > > +              bufq->head) & bufq->mask;
> > > > > +
> > > > > +     if (num_bufs_avail_to_hw < GVE_RX_BUF_THRESH_DQO) {
> > > > > +             u64_stats_update_begin(&rx->statss);
> > > > > +             rx->rx_critical_low_bufs++;
> > > > > +             u64_stats_update_end(&rx->statss);
> > > > > +             mod_timer(&rx->starvation_timer,
> > > > > +                       jiffies + msecs_to_jiffies(GVE_RX_NAPI_RESCHED_MS));
> > > > > +     }
> > > > >  }
> > > > >
> > > > >  static void gve_rx_skb_csum(struct sk_buff *skb,
> > > > > --
> > > > > 2.55.0.rc2.803.g1fd1e6609c-goog
> > > > >
> > > > >
