Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793198493;
	b=4PFzcrNc5+2B/yWNDRNjJHVarYzBOJoUHDmbKJaIuFRDnTA7piBET+f2ETBewUnW4IFc
	 0CCgFWsp3USN70OgnSPzpA3Gnfp4+ggP2obvcjmweC+64pcvR5I/1xnITf2QXZ1lWDTIa
	 a8SpAoWqsBGdlE+fh65PXhT1cDR8Wqc5rBCNMvgmeffBfvHsUGxL+xsLupzFc88ANjYDL
	 cVBoVPp8A9SajS3fetVRfGCTIAL1AXpbepy4f2qBK8xooKjb1BvHDtAQPbOkV+p3cPAaF
	 xcbfDUMskYhRjkgUe8DxDl5OtSB0RubIOZxOrfqM7UXbyyrjm4W54KX/lCSRrW//lcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198493;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=KnViDZO+W7JL/TAntmxN9l2ez9WUYbOiuW9lHtkdn1w=;
	b=tj1xnOIWm39Q8OlvK/eiPAQe0ngBG2Z/PH5Eax2sxMW98DqPitkClzSzKrA8ybDv/YRy
	 BAizUZobk0o96S88aYWr0d0lB/EnXxtwzrY+sdj7eN4eT3EvjhISHPVd2mIu+cxWzvsci
	 wAUKlUTRP2QOStV+oJcfgMAyYqUszRlWQeMx4hIRXGcXKW9qSh9O5j6eQx8WNZWBCILoG
	 JaU8uKhE3klhJ0gikv9A/0KbZWfYhT8t3vo9AEQ9tUm3VAqOsxdqm9AEDzvEyLOusfqfE
	 HaJ7C4dwSOgNCAXairgznRxoCx6P8wuuGy+IEJWxidM6s1V1Cz//1yBrRE5gAPv5uTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WBmHb9vn;
	arc=fail smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90746606A31C;
	Wed, 28 Oct 2026 14:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90746606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WBmHb9vn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793198492; x=1824734492;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pE8x3z6+CQKccN1KJb9xlW8plgIjsNf/fFpXrjUpGl8=;
  b=WBmHb9vnU+SB2PzIcOFcZ1bnkiV/ipKI/d1RED5HJS7g8O3vT1kcwLMl
   Y5WHPKfoxRhdK6vrkKgagCv5TDYb0Y3ya9SdICYIYBaikJKDtEIGzxKLO
   Iz6lnAdIlmK4H97x/YYfBNyVnl02CDSeeKJ7E51dAXIY0Fn48h7NYEGHh
   IIjd9rXnUAEdfegrdBf1tMNYmhD4vTD3Cd3mn4yr6Jxqb0CzPa7R/0c+e
   kUoh9W3jegHNU1pTxKOwHvIJ/heMKrny0jw9RLYMaV0Wpp5Yk0zQSYLIu
   pq8T3CEYsbS8nrJqW3kSE2KS0mobAZdA9Ch2MnbrCXCczc5tCoUrb5VFk
   w==;
X-CSE-ConnectionGUID: r6tqCmxjQpuG2jPUKgoaqQ==
X-CSE-MsgGUID: seLJ4LEKQwizhkdsFjIbqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1945757"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1945757"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 07:41:32 -0700
X-CSE-ConnectionGUID: 127v2mYcS6CD8Wku8jSr0g==
X-CSE-MsgGUID: +LuPUcrlS5aqV+NcgOtfCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4717413"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 07:41:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 07:41:30 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 07:41:30 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.23) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 07:41:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cT9hCKwrAzef5AIlUb3Lll1uLyzPB2GOuv0ip11BXG7DQuRYMBEtuMnz9BD5LGsHNzyW86VRp9fqOQ6v2qLRvXQZWrymErIhXEc3nlXUm9IUVZfzdqgyOD78wSoKFSwagofnmwAczflafgF2LCZnnNAliKsmDHyoReNFq2DdiNyjIxFhSgLgzc1asMao5xY0x+yZdFPPNhF6cxZU7Ff07bDv8AtltvVi5I6rozvZXCQJAjwIp+sl15KYwk0Y1xXks/SD+Op+Y6pSr8sKClt0O4xyu/fWqxePaTNr4FOSibvb8zv83T4fCTatIBTfR9xBMfhSZggYRK+sV86ijAmKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnViDZO+W7JL/TAntmxN9l2ez9WUYbOiuW9lHtkdn1w=;
 b=ZwzhSM4psOO9E1IDu827xFIpe0+eeXOiGdTD7ek+CcqZIe5M3ru4Tk8wgc8z1q/5EHECaDhbtz9zR9S3L0GUe5/Wjvx9W4SWq6OvWuTWzoCY6d1ysa3QXKmfzzqGJXma4oQCXFDgqg4SfJuM0zHQFO0cCWHW7tz1kRwYid7s20Wx4d5WSOlNdgHt9k9E11WzsSC3wSFFjQ99YHwtkSpfJwXGia/aHpOScvcwzSgTv9Xbd4fqN1M6hzlQzOQq2lhK6g1DuS+WRTpCrYFfgWAtBcO5MnmyDn0T/jm1aYTGMSOyKw5zvqrNh1ETa/t7/g3MVi36WE76zPV/LDXXGaICFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SA1PR11MB6782.namprd11.prod.outlook.com (2603:10b6:806:25e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 14:41:21 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 14:41:21 +0000
Message-ID: <1950d325-384c-46dd-aa24-3d3ee561b2dd@intel.com>
Date: Wed, 28 Oct 2026 15:41:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ice: fix Tx hang dump using stale tx_buf[0].skb
To: <choiniere.vincent@hydroquebec.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <intel-wired-lan@lists.osuosl.org>
CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261026-ice-tx-hang-dump-v2-1-e2136ef2c5dc@hydroquebec.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261026-ice-tx-hang-dump-v2-1-e2136ef2c5dc@hydroquebec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::7) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
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
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SA1PR11MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d507a2a-8e8a-4471-7a72-08df3501883f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|261022105027099003|261009223027099003|261021135927099003|261021121427099003|261022113327099003|261021130227099003|261022075727099003|261022115727099003|260925022911599003|261021123027099003|260925021311599003|10067099003|260925021911599003|261021133027099003|56012099006|261026135527099003|261026140227099003|6133799003|261026130827099003|22082099003|18002099003|261026121527099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: 8crUgMvxRTGIxOV2jja7AbfM7S/8oQYB5Czn8F4ZgRjKKb/yfKvYoplpNsVjC+wXnBLjidNMw3+mEntDbMvowDI/PlNIyqv1J75eRMadSuX8/Xs6+zfsdrqDk1/DKMnJ1QJWEbn/svO/Si0jfeiUULIUJryWyk0vKJNXUQ0oWYbPX/tzP4deGPTNA650nybwS9ca4TZtWsDr6NzhQ0qvRLdpuB5KrMv2srMVOWotgv3Klvh6F0r3D2pL6D8Z/IEhNvpYFycPIA4cS0r0YaREoo1K/o8bE5PLuml4v4cD7lm10qfIeYTy6rqbtAMZseMv3DP8M9BM7D53nZLuQoK0WHgs9w6wOPurJzk8FD3epMew9UiI9ieDjd4W9kpQP900x7H12tRj5NjPNHy0aaTVzznZF+BuvwV5pE3RYDByD2vNwKxBytlIZbaUzt9WUn9PouMp+Fk66YvImzXhzcJw130Bh/Ys/61rwN1JN/EYbJueHhfb+226FAQIZ4uI/MROKlEejfimFqIsyR/gu9ogKnLpkuXyN20Qs2RwFsiKYt5vvLajv/qYKP3bocZm8nIVCBbgHihAsEMMH6FaTyOv/itvWLRhmd+cG9cJqnnYXDVi3/60ZMMqcpOHeNTuOfLa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(261022105027099003)(261009223027099003)(261021135927099003)(261021121427099003)(261022113327099003)(261021130227099003)(261022075727099003)(261022115727099003)(260925022911599003)(261021123027099003)(260925021311599003)(10067099003)(260925021911599003)(261021133027099003)(56012099006)(261026135527099003)(261026140227099003)(6133799003)(261026130827099003)(22082099003)(18002099003)(261026121527099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTc0SUVPRFp2RTBraThQSit3ZFZ4dE80cTRpOFRSeHZxdkFlVklGYStuSVNi?=
 =?utf-8?B?bnB5TUVob3N6bWRSTE5wR21iMGU4SWYra0sxbTdaQjQzVk1xMUNlMWlxYmI3?=
 =?utf-8?B?d2dSaWYzdlpkTGl0Rk5lK1pQd2Vub1g3OXFKK1hGeUxRRG1xWGxsNWlIZHZj?=
 =?utf-8?B?SkREbCtSNGxUaGNHOXcraG9mNGxCcXl4Q1JVTllmNWpIaGtjcjU4bXFJblpI?=
 =?utf-8?B?b21vU0RjU1RNWVdiTXgvYXA0MS9wNUdXWXQ3VEFGNTN5WGlqY1U1elppVFhQ?=
 =?utf-8?B?c2NJR0FrQ2h4TVltaXREZWIzMFBaN0gzOGNYeDFGMTVBZ3pXUjZ5OUZWKzlm?=
 =?utf-8?B?dWdKS3M0SDd4K1FpOUs5bFdwK0dnSlZlcmVWbDRKcFVydEVoQlptZ2dhc0tw?=
 =?utf-8?B?UnQ1OUpQN1J1NUkzRTdoUE1yUG00Z3ZiMUFmZWp0NjNvL0JSMnVSUDVLNnhC?=
 =?utf-8?B?eVpwK2hvb0Vhbm1HczBEMnV4N1hkZGZ1YnJYYmlhWEM5amRRTk5lNWZjUHBD?=
 =?utf-8?B?RExUTHFPbE5paHdEL3hxQktpSS83dFdJQzVZOXl5eGQyUldRa2plVlZWSmVy?=
 =?utf-8?B?Mk1SSUxHRmc0WVlOc2c2SjZ2YUJXZTlTZ0UyU1lqdkw4Y1UrbjhtbVNoQ1RT?=
 =?utf-8?B?eUZjNGttY0VDNnlTc3BSSzJxY1E5UmlseUttcmw1ZmxSNEloTHQxemszSHhT?=
 =?utf-8?B?Q1ZUUkpvblh5TkxVMHg3cWdlMGhtZUpxUWhkeWlMMVpsUHVYTldCeVY2YXVY?=
 =?utf-8?B?NjBNQjV5RzlQR3ZhNlljd2NKbm1lR3ozWW8wL200eUVYVEltWUdHT1Zqdk04?=
 =?utf-8?B?bXI5dEdEdjBIdTNISURvS3JPcE93aFgzUzYxN0RyemtMK3RJOVFRMHlCaXBK?=
 =?utf-8?B?NExCc1dlS2lEQkRWbk5hVGtPRSswU1ZoUHgvQ0xRREZUaGZvK3RrZ0hzYmtt?=
 =?utf-8?B?Y1o3QlU0RVJERUMrVWloSitvR0xBaGd5UVY1ZFlJUjR6Sjd5SC9jSXMvdEVp?=
 =?utf-8?B?bkNuMDNOeTI3dmVjUVJpVXVtejRpdUlONEVTUWE0OHBPaDhkenJ6Y1JoaEtj?=
 =?utf-8?B?V05JdEpRWjRHVFJxUzZVY3JyZFNia05jSDdpeGxmVnNSRU9DeEV0bnpFSzBa?=
 =?utf-8?B?eWY1N1dQc2ZwZ0FmSEx1cVArcUdSM2NFNmFPbGJkUDd3TS94dHQ0RG1oaFl4?=
 =?utf-8?B?U1A4WklCc242aVdRWGN4ZDhNTHlzaUExNktVVFBXaXBweWNUazA0RllYRlN2?=
 =?utf-8?B?UkJpc2xYQnBQVy9aS3lTbVgrTjJaclVMOFVaVHZOeGxhTDhqK2JFdnI1YVZR?=
 =?utf-8?B?UUlBcEZUQi93bzJzZGZNWmRNaDJVM1l5SHhZK2VET1lXaVUzNjBpc3pOMVdG?=
 =?utf-8?B?Qjc2SlVLaCtQbjZvckdjNFpQNjFZTGZ4MGoyWmtwWVlHdmZwU0VkTldpbWFN?=
 =?utf-8?B?M25scmlYem1JSy9sV1M4eVRDeDlQQVhicTNxVVNLUVRIWVhSSjhGcmhKSlBM?=
 =?utf-8?B?QWU5UlVDd1lPUVJkZHFHc0Nmd1VxZHE1MjlUYTV3T01OemtycDhyV3poK0Z1?=
 =?utf-8?B?Wmd1dUo5UmI0aVE5MGluNSt6djdNRGtpaHVMby9EeWFaN3dzNEhhYzZxWGND?=
 =?utf-8?B?TzN4WS9aSWxtcER4Z2cwbUloSmh0dGhGdGtxdnArbGEvTko1MGFRZGtBZDFE?=
 =?utf-8?B?OFhXYkt6dzVDL0k2VkdGMGlwbmJqc2hsc1N2aURzdVBaUjhGOXlLTFRwRGZv?=
 =?utf-8?B?MlorSExTL29lRUZMQk10QVUxZkJiUEZTS3k3YjQ2elNRL1RGM2JKWTBEOEE3?=
 =?utf-8?B?bDZPT25JRVcvN1gwcDROOTdoWVA4MkhGcG5rYzJud3JPM1ZRTi9EYU1jbExX?=
 =?utf-8?B?WWhlbkZlMmZGbmxpRXFhM3dBREh4Zmo4ekFiSjA1MmI0QWRraHhFVmNOWUxW?=
 =?utf-8?B?WUlXQWpvc0xXZE55eU9IWDVCUXdmMjBkbG9uVS9sU3kwSHFLd285b1dHd3dB?=
 =?utf-8?B?TVhLYkp1Unp1TlY3ZGpxTWVTN2poU0haRHQydGwzbWRMRTdzM05NOTVZNk5r?=
 =?utf-8?B?K1JqRW1oME1kdDBIRGJMWUVSVzEwUU50ZElvWXhrMEdmSldtVEN4UnlMM2Vo?=
 =?utf-8?B?UStWUTBtYlZnNWVsYnJZWnBGdStVTDBTbUdDZDhaT091L3hvL2w4am5CRzRE?=
 =?utf-8?B?ajlHTStCWTB3cytjcDFLaXBJWloyTnQ0c0VJSHQySzU5L2F5Um5hajRjb0hs?=
 =?utf-8?B?d3paUitJNDFRZVIyMXBZWFJTQmdyMVlxdDM1ZTREU2JFVnFpMkVBT1M1YlNU?=
 =?utf-8?B?eUtIQTZQbW9ZcDF5SzY3NldpTm1RbTFmWWZ5OTJkOWRkNmlsVXdvbStmallh?=
 =?utf-8?Q?6Y7OEYqzrAx+DJIA=3D?=
X-Exchange-RoutingPolicyChecked: KlFcl0kP81kae4PUok0bl7lDr0N3YbMC78dbbxJJ4XRhbHJZ7LW9W/CZIiNYhxrDKDm3mrBKkDkEoGqpZ+vr4Bf99edaLV6WppqAMAMNg6h7Li1MOwmb0k8OiyuRUTsxV9p3TmBgLNXQjRy0Kw+p1hjRSJh6t0m/dM+iVHt3sQI3csbHjy+ZOgH7UdnRaoa0NDYXMHGFXH8k+htgaL4YOZ+pXt9tqPYtS7ZmMTXN6f10E9MHm8rZkfWPbgW0GOTGZ4r0Yx6bmsFlR6nLq/V+UYj9nXKgtFh5PVYpG1eZvaSuqbno+HphL+u9vBK/ruDa85PlGf7yIL/uMhXepNVuDA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d507a2a-8e8a-4471-7a72-08df3501883f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 14:41:20.9331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AWYhMq9SA3IzNHp6Ss6cAELBQ3qkWbzZMh7NfhMbSmEplb+lC13UCco31TpPN1jo5ni5sSMyDUbmx7qWhM2TFik5bSDTyQl0CQkVdaS+s8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6782
X-OriginatorOrg: intel.com

On 10/26/26 2:30 PM, Vincent Choiniere via B4 Relay wrote:
> From: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
> 
> ice_tx_hang_reporter_dump() always reads tx_ring->tx_buf[0].skb,
> regardless of next_to_clean. The Tx cleanup path frees the skb and
> marks the buffer empty without clearing the skb pointer, so slot 0 can
> hold a stale pointer. A NULL check alone does not cover this, and
> devlink_fmsg_dump_skb() can fault on the freed skb.
> 
> Using tx_buf[next_to_clean] alone does not fix the lifetime issues.
> The dump runs from the service task without synchronization with Tx
> cleanup or ring replacement:
> 
> - ice_clean_tx_irq() can free the skb at next_to_clean while the
>    report is being prepared. It calls napi_consume_skb() before
>    marking the buffer empty.
> - The ring saved by ice_tx_timeout() can be replaced or freed before
>    the service task runs. ethtool -G replaces the ring contents and
>    frees tx_buf and desc, while ethtool -L can free whole rings.
> 
> Record the queue index, next_to_clean and next_to_use at timeout time.
> Before reporting, take RTNL and check that the saved ring is still
> one of the PF VSI Tx rings and that the VSI is up. Copy the
> descriptors and IRQ name while the ring storage is protected against
> replacement. If the ring cannot be used or the copy cannot be made,
> report only the values recorded at timeout time.
> 
> Tx cleanup can still run while the ring state is copied, so do not
> dereference the skb. Retain only its pointer value in the dump and
> remove the skb contents.
> 
> Release RTNL before calling devlink_health_report(), which takes the
> devlink instance lock. Build the dump from the copied data and free
> the descriptor copy after reporting.
> 
> Observed on an E810 PF passed through to a KVM guest with Ubuntu
> kernel 7.0.0-14 (PREEMPT_RT and a local scheduler patch): a delayed
> queue IRQ led to a Tx timeout and a page fault in
> devlink_fmsg_dump_skb():
> 
>   BUG: unable to handle page fault for address: 0000000004cd0c11
>   Workqueue: ice ice_service_task [ice]
>   RIP: devlink_fmsg_dump_skb+0x2d8/0x5d0
>   Call Trace:
>    ice_tx_hang_reporter_dump+0x1ce/0x210 [ice]
>    devlink_health_do_dump+0xcc/0x190
>    devlink_health_report+0x1d7/0x260
>    ice_report_tx_hang+0x7d/0xa0 [ice]
> 
> Fixes: 2a82874a3b7b ("ice: add Tx hang devlink health reporter")
> Link: https://lore.kernel.org/all/20260327072332.130320-1-aleksandr.loktionov@intel.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
> ---
> Changes in v2:
> - Validate the saved ring under RTNL before dereferencing it from
>    the service task, and restrict snapshots to the PF VSI while it
>    is up (Sashiko).
> - Check next_to_clean against count before indexing tx_buf, and
>    copy the descriptors and IRQ name while ring replacement is
>    excluded (Sashiko).
> - Stop dereferencing the skb and remove its contents from the dump.
>    Keep only its pointer value (Sashiko).
> - Release RTNL before reporting to preserve the devlink instance
>    lock ordering.
> - Record the queue index and ring indices at timeout time as a
>    fallback when a snapshot cannot be made.
> - Drop Paul's Reviewed-by because the patch changed substantially.

lot's of changes and code, but rather nothing controversial, I'm
generally happy with it, one nitpick from me inline, and otherwise:

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> +static void ice_tx_hang_snapshot(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
> +				 struct ice_tx_hang_event *ev)
> +{
> +	struct ice_vsi *vsi = ice_get_main_vsi(pf);
> +	struct ice_q_vector *q_vector;
> +	struct ice_tx_buf *tx_buf;
> +	unsigned int i;
> +	u16 ntc, ntu;
> +	void *desc;
> +	u32 size;
> +
> +	ASSERT_RTNL();
> +
> +	if (!tx_ring || !vsi || !vsi->tx_rings ||
> +	    test_bit(ICE_VSI_DOWN, vsi->state))
> +		return;
> +
> +	ice_for_each_txq(vsi, i)
> +		if (vsi->tx_rings[i] == tx_ring)
> +			break;
> +	if (i == vsi->num_txq)
> +		return;
> +
> +	q_vector = tx_ring->q_vector;
> +	if (!q_vector || !tx_ring->desc || !tx_ring->tx_buf || !tx_ring->count)
> +		return;
> +
> +	size = tx_ring->count * sizeof(struct ice_tx_desc);
> +	desc = kvmalloc(size, GFP_KERNEL);
> +	if (!desc)
> +		return;
> +
> +	ntc = READ_ONCE(tx_ring->next_to_clean);
> +	ntu = READ_ONCE(tx_ring->next_to_use);
> +
> +	if (ntc < tx_ring->count) {
> +		tx_buf = &tx_ring->tx_buf[ntc];
> +		if (tx_buf->type == ICE_TX_BUF_SKB)
> +			ev->skb_ptr = READ_ONCE(tx_buf->skb);
> +
> +		memcpy(desc, tx_ring->desc, size);
> +		ev->next_to_clean = ntc;
> +		ev->next_to_use = ntu;
> +		strscpy(ev->irq_name, q_vector->name);
> +		ev->desc_ptr = tx_ring->desc;
> +		ev->dma = tx_ring->dma;
> +		ev->desc_size = size;
> +		ev->desc = desc;
> +	}
> +
> +	if (!ev->desc)

this is abuse of ev and bad style, instead just glue an else to the
previous if, basically:
      if (ntc < tx_ring->count) { .... } else { kvfree(desc); }

> +		kvfree(desc);
>   }

