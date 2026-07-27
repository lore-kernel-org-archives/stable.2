Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1AD3E8326;
	Mon, 27 Jul 2026 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142883; cv=fail; b=udLYTwgy41Io/4CWDCnPwqhoH4Tl7YAQy46gW+Zu9dilqN76tuOjiz0K/Rs4tXUUvuwqhxY1qiohJ3mDVaoJFX7ajwVzisT4i5jHsnoTk3jqk2jm+HRc/62315Dwm27mTrU24HAoqpXrc/T+xqBpZMLHoHnXdJTQ20rn3fzKuak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142883; c=relaxed/simple;
	bh=P25JjmzCQdSGCjOzAV5uDWne4ppdod+v5bWzR5DKjCs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K3iLdwqTe3ZIG+zMi9jcAoi7pIOGzgZXIKWMj0Nn0C1k+lpCJ5D0N49ccysoZrYIr4sVsjHjA8S1pereX9ejvs+U6YI4ahI8fu916Dud0ORYq94SLEK1I8ikqwGl0RVflXi2W/wegTzwaOpyG17QUYUzRH1hEidDeXkTxfJjueM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/8eSUfi; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/8eSUfi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785142882; x=1816678882;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P25JjmzCQdSGCjOzAV5uDWne4ppdod+v5bWzR5DKjCs=;
  b=A/8eSUfi9U4m6Nz8ryzq09Oylt4VJFIv443ci9iQKnW72tD6eaolnJOn
   oXrYAAg/SDa/rIg3mQmOMfzkbqQJ4lvzlMn00o9p7hmh8w08KXpVsq8qM
   hH/vRNOpYEKHLXGVFRN78Qt9/cjEFZFudCkvTqS+tpSk3i39SuH4O4GlP
   Tw8iPTi0REBcuaW/P2wuiRRcrpCW5Za9d+scVcWToFXfNtL5hOAkgIGOG
   hyZAmx9GFmUod+uZLtDMb2ajbpzm4ogQ0HXS6x8bpFrYU8bXv8C7KHnOh
   SHcP1xn7KEZHIrVlPIruIHl2Q8cbq5MG9JwH1kxbk9BkWNV0QQFEbxJcj
   Q==;
X-CSE-ConnectionGUID: tK9uQPxhSsqebQ87UF7OLA==
X-CSE-MsgGUID: CsYOGOPtQa6ZcHny+dBg4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="103247172"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="103247172"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 02:01:20 -0700
X-CSE-ConnectionGUID: T7BA+8o1RKyxyRqIvHPoQg==
X-CSE-MsgGUID: Qx5sO8VDRNW9yPdpHVUmLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="253025846"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 02:01:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 02:01:19 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 02:01:19 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 02:01:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXWg1hUlFUL3h7+paBWNUKpq2gUYq4LktgmDkRpvE+CUwzB4xbR8QKyVI23OWnr6CIKGdZ09yRyqZXrAvLsaXSBQIhGspM1sbmdI9OCqyRWbvestCsi0dOIrSp/tncJX7khiv/RVhQtcQIUnRSkQs5OFGHrfDyuHscRqBf+OOqGNScXttPafvbqxEZT676TktRnTbKTbhBiYSjjj/jbIq6cFsu/Y9UY77RTobj5ZIz5wdP5+4kd7Wt1Aw6ZYJqSpZ4S2gNdtZ+iCKHPNHRlNk6+VZh1XtPe6kpMczRCPRIEZGvNRubazTMyjDaGwZjmI7LpSLPmermqU/DiML5BQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPsGwsBb0/w4bJJpL9T3AeQNrQAOnYDxc2eLZYUH4Yw=;
 b=tWTbKOccOkknIh8JwgBXiUY5FrCEUJmfd+0Tj6ytYoA8vr3/xMGUENaAgGufy17fVju9nQfFobhiMD478rqKHck7KXZR9Iuaedl6ACrB1o0oIj0G36q64T0aErgoCV5P07uiKDaVNnVbZRrZsnjtFBLt5g8G1ombMyBcDJ4ZOK3uwqILfntZGTfy+f9ZpwAJGM+x1d05idCUjwxDJ5CftCKzzDXV7cvApaovJn6kSf4VAVOy7QxmTlkj/cl3z8JuqLVYIws6Dv7l5Di8QwSf/99RJNvxPcBrnDcV5/2zqTlFP5VOJInrTaC2aZ/VSNqHi8FErj5pK172kKpbFZ9Dig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13)
 by DS0PR11MB7998.namprd11.prod.outlook.com (2603:10b6:8:126::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 09:01:15 +0000
Received: from PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b]) by PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 09:01:15 +0000
Message-ID: <15f365d9-b5b9-4dc1-b24c-1b6f9363e9b1@intel.com>
Date: Mon, 27 Jul 2026 14:30:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION]: [PATCH mm-hotfixes v5 3/5] x86/mm/pat: acquire
 init_mm read lock on attribute change to avoid UAF
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan
	<surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka
	<vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand
	<david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko
	<mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>, Toshi Kani
	<toshi.kani@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Andy
 Lutomirski" <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Kiryl
 Shutsemau" <kas@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Dev Jain <dev.jain@arm.com>, Ryan Roberts
	<ryan.roberts@arm.com>, David Carlier <devnexen@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, "Denis V. Lunev" <den@virtuozzo.com>,
	<stable@vger.kernel.org>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
References: <20260717-series-vmap-race-fix-v5-0-606a0ac6d3e5@kernel.org>
 <20260717-series-vmap-race-fix-v5-3-606a0ac6d3e5@kernel.org>
 <80993b70-352f-4069-84c7-39a04c061e98@intel.com> <amIEC1qDW3kfeuHd@lucifer>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <amIEC1qDW3kfeuHd@lucifer>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::11) To PH0PR11MB7636.namprd11.prod.outlook.com
 (2603:10b6:510:26f::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7636:EE_|DS0PR11MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ece4ff-9433-4aae-9244-08deebbd9d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|13003099007|6133799003|5023799004|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hjYbTbm0jBXI8dYJQqDbfTV3hrsgVq/4Eqk8kEG0mNtO4nfNANLahEwMRq0xDanFyCH4/L8BNLzNMEM+fhjIBa7wlr6/qSPcseY/tbUgi2JFwAzICsByleZm5dOq03iB98Im5/LkL3G6cYQtbv6Gupuxe3CF17nD4QRQ2Gi2M8RH64yNWXPfGkq2yivKQXC9cXXIYcym0BBR2DClLEZ54p8J/GM+cMyuuPnmXuOLENxaxXE95qakV/b8LpsYW+Ev5zd9SmgR/O60ofcr1WHfVHZpthpKVEOnuhvqpVYFZB4ClJhAKi6nqBm2au1XiGUUqiPtS568S/fTtzqtnqLGUvutdkrX5RGH+bUMsCVFytHSjsHMHF/GdzGkZDCFj8RIi8F+UsB7RlnScE8p/WEL8IJsUjrTSuXWa4l6Hf2TF9OIN9P2bnD5cys6NroeaFnPKWM4fNQQhKTPEg8vGO1YTrNbjVrggqHKOP5sDrjAF4hrVDGhTzubnGdtoH5s0ZuOlFwjG7bJ1oB3ffCV1SFYUhU/XzwQ5YB4QFXVbI0mfTa6RtkmXTDKcdNMRCkqGTp9tXCXxM0AbVQX0+4JvmcKovf244aDbK/6HK+Fyg5lKtrmf8Etx4zMdNZZKNE+kL+3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(13003099007)(6133799003)(5023799004)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2Z5NmlnR2Y4Z3dCTUIzYk5GczFHWnQyZjVqYTU0d1dVUWp4eTNCdC9kSUFD?=
 =?utf-8?B?TlZMMDZVaEhINnVBNlgxdjFpcUN6MGpZcVlHNWZpc2IrTCs4KzhCL2RUc1Rj?=
 =?utf-8?B?TGFnb2VxcVJjaVg1S2ZXZGZwbHJnLzdSaVliQURsRTYrWG84dlpmL1lsSGRU?=
 =?utf-8?B?ZU1XZFF6RGF5RzQ4ellEQ1lIcGMvdEpPMDgxRGtPUGk5L2Ewald3cWNCa1o5?=
 =?utf-8?B?QVFLU2t5NkplVXBwTlBJNVhpaEQ1c3ZOSFJlWThURnBsTzN5Q0pRanlRSHh5?=
 =?utf-8?B?Tk9aS29vdjV6ekh6YSswOFN6R29ZdldxcGsrRFZYRm5XYnBwNnBKQWtKUlIw?=
 =?utf-8?B?SUVnR2V1YjRqQWZ0b0tpNW4rQ2NRYzc2UmY0SVVUcGtUdHRyT0ZhSFkxMk9R?=
 =?utf-8?B?VmdYRlRrZ256cUtSb2w5UEFLZWN6Zks5ck9RRkIzZTZ4VlNwTlc0VkltTUNZ?=
 =?utf-8?B?MDlGYjFQZDlZQXh6S2JRMjFGdWhBSnZ0RnBWRHh5RDM3Qy81bjZpenNWTXFK?=
 =?utf-8?B?ZVJ2SEVIZytNTUU3TGJaZnZxcE1NZHpDYThXSHAyRXdsRUw5c1hpU2RIdFVY?=
 =?utf-8?B?ZTR3NzBZeWZCdEM0NFBDMlhma1U0aThzMFhQNkszUTY0aFRlbnJHWDZ3VkRD?=
 =?utf-8?B?UkU2SGk5R2J6dWs2MW1Wc3JWVHZXVXNaVVROWXVpaWF6eThyNnVLMVZmNWNs?=
 =?utf-8?B?dFBpTHNQc1BqS3ZxSlNPV3VnV0RYUThhdkxJQXlqLzFBeW1YSzIxN21FOHlH?=
 =?utf-8?B?S2h1emRTLzJQeTIvSm1Sb2VuM0p6d0FiRi9WekdROWJiNmVhMnVsVlBiMnNP?=
 =?utf-8?B?UndWVFQwaFE0UURYQVdDQllDQWRTN2phQlBrWUxubWZXWldwb0JxZDJKdXJy?=
 =?utf-8?B?ZE1qY0s0djVhVXJhNHdpd1dxMlhRR2xMT3NmK3UvTFV2ZGw4ZDYyZnFTeklX?=
 =?utf-8?B?T1RPU0d6L3Z1WWd6bFBuWDlteEV0RU9kYWVZSEZYK0pOcGVPZExZS0xxVTBD?=
 =?utf-8?B?dFRRYVlHSzVZZ3NkVkZVbVBoT244RTlhQitRRlFBaTNMa0RSYnFZY2hRMUd6?=
 =?utf-8?B?cG5RTUpDdUJpSnlFalZiZWt3TWJVSmRZSlJtdDJGbWdqd2toRjcwaTdNeEJu?=
 =?utf-8?B?bmw2UnJYZFFRZU5NQUpOREJrR3Nsd2p6ZXNGN3UyS2RERTJFOGt3Rld5Z1V6?=
 =?utf-8?B?eTZ5T0FSUng1OGRrS1dVV2ZuNHJLVFEwUmwyWDlFajNqbDVqWjMyZHZ5WXRl?=
 =?utf-8?B?OGFWVFR1ak5SUytQSDVTd2dhd204SytUZDJPV2pZQUxEaGxIUk1xUVdhTkNP?=
 =?utf-8?B?d09jRDVNc0JGcnRodjdsd1FnNXpmbzhPMno3OGEydWcyR2hkN2pqcHl0YjQr?=
 =?utf-8?B?aGZNa2ZrMzd1NmZiZUtQODgyWlhMRnNJYWF0WFo1b3plU3hyS3UyWmlIRjIz?=
 =?utf-8?B?Yk5ybTd6UjY4a2NtNnI5QjlLeUNkTTdwMVNYVWJkdWp6bldxUnlRRVM3NXF6?=
 =?utf-8?B?c3FHa2UrcDJlTnh5NHZIQkQxenBjU0xDZHpCTzFPU1FPSTJ1U2xTZEtSbjZN?=
 =?utf-8?B?RnlYa0VsbjhnZCtWRnZXSWc5NXJzTmlnN2x3QU9OVDZOMmUvb3FpZEx5Q2pG?=
 =?utf-8?B?Yk94em1hZTRxUk5sZzZQemdhTGhGc3gxNkdwaDUvc3JmMHlHYzh3SEZDNHdv?=
 =?utf-8?B?K3ZRNmNYbTJWSlVzaHk5cW9qUTJxcVNySW5VZVJXRCtqTnJVRHlUYnZkRWJD?=
 =?utf-8?B?NS96eVdsaFQxc05XRk1kV2orWDdydkVxQ2UrcmplYlpYQjl0elcyRzY3VHN1?=
 =?utf-8?B?Q0ZhKzhOdDloQ0t3Ti9lNGZjc0Y0WEtwK0hPOUpBeWhqckFJeHZCeWR4V3I2?=
 =?utf-8?B?VTYzOHB0YzE3MXhWUXI2RmFCS2pSaVVGbmlKYUJ3VmF3ZHJiNFZkdjZieGpZ?=
 =?utf-8?B?TDhmY3lYK3JDTitURXNCZllRSzJBWXBNMDNFTjlGd3k0eHVkd2tWYnU0andl?=
 =?utf-8?B?dVVDWEhJV0wyZEVYUkR1R0l5MWU4U3oyS3JiVk9PUmxhb0NYVWJyeVNMclcr?=
 =?utf-8?B?dXh1bjgxQjVTeFNmT0x0bmk5NEwyNk8vbEVHZFQzN3ZKMGNjTS82TlJNNko3?=
 =?utf-8?B?SnlzeWxGZ1lFTks1Z0NlRXJrSUZXdGJVNnhHUys3VDdjb0pNVEtGK0xOajNI?=
 =?utf-8?B?VGdZbmcrWkN2L3N3Y2p6QkdjQ1FFMGF2V3hDS0pGUWlhZFFod0VTQzBPb0c0?=
 =?utf-8?B?QnRTNDdZQVczdFQvRmtNTERIUGEzODFqV0x4RG9KYzBJRENvOEZPSmE0WlFI?=
 =?utf-8?B?c0xiQzk3a3FSdllnMzNqYnBnN3N1Y3ZVOG40em5hdFFXcEFrUmhnaWtvL3kx?=
 =?utf-8?Q?QTL4iQBB47SA8Oyg=3D?=
X-Exchange-RoutingPolicyChecked: GQz1nmHQFJixZJFCmVXr4WB9ipkAUToRzazWymKL2ifEGFLf6GJguOgJtUezJDV9thLzy0zo0+MxfRzw/SEYQPz3BJRZX075ZYGbbm+vgVR7rrQxLHRa/RFeWycfS0RexSo9X89KyqbdSkvys30h12sudQYC8/7aBRrKxJp9HW6Qe9H09FrQAFz2IFB90mpot9sbClfx0hRzgAR8wxzSJXtsBNOngFteYzOczPIycHUvCU7VomDno6F+gPYL0JYJv2KTgQdDB1QSIEW5gtguOfC+bgF9w/m8aK+u3hJq0XO2jbJ01tfS2QEWkgp1UWG5d+QKEgi/XHqoVmnjVXkD2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ece4ff-9433-4aae-9244-08deebbd9d47
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 09:01:15.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yx5bK+EnzyOBHH2U3EWnB6xZMisoUCb/U5o9RREM10lhreAnDEnUEd/QwruiM/3Jdt9AqGoHlqMoMzpWR5LcBQL3ruEKetHU4576LASzlxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7998
X-OriginatorOrg: intel.com



On 7/23/2026 7:48 PM, Lorenzo Stoakes (ARM) wrote:
> On Thu, Jul 23, 2026 at 12:00:42PM +0530, Borah, Chaitanya Kumar wrote:
>> Hello Lorenzo,
>>
>> On 7/17/2026 11:00 PM, Lorenzo Stoakes (ARM) wrote:
>>> A previous commit protected us against races between ptdump and CPA
>>> collapse, however one still exists between attribute changes and collapse
>>> as reported by Denis V. Lunev (linked).
>>>
>>> When an attribute change arises, a lockless page table walker obtains a PTE
>>> entry, which is later written to via set_pte_atomic():
>>>
>>> ...
>>> -> change_page_attr_set_clr()
>>> -> __change_page_attr_set_clr()
>>> -> __change_page_attr()
>>> 	-> _lookup_address_cpa()
>>> 	-> lookup_address_in_pgd_attr()
>>> 	-> [ lockless page table walker ]
>>> -> set_pte_atomic()
>>>
>>> There is nothing preventing a concurrent CPA collapse which can free the
>>> PTE that was retrieved here, resulting in a use-after-free.
>>>
>>> With the mmap write lock taken on init_mm over CPA collapse, we can now
>>> resolve this race by acquiring an mmap read lock on init_mm over
>>> __change_page_attr_set_clr().
>>>
>>> This locks across the whole operation over which the walk and the PTE entry
>>> write occurs, solving the race.
>>>
>>> It is safe to do this here, as no spinlocks are held upon entry to
>>> __change_page_attr_set_clr().
>>>
>>> The CPA_COLLAPSE flag is only set by set_memory_rox(), which exclusively
>>> operates upon vmalloc ranges, and on x86 only within the module mapping
>>> space.
>>>
>>> This is important, because some callers directly invoke
>>> __change_page_attr_set_clr(), bypassing this lock. However, none of these
>>> operate within the module mapping space.
>>>
>>> * cpa_process_alias() - a recursive helper called by
>>>     __change_page_attr_set_clr().
>>> * __set_memory_enc_pgtable() - operates on the direct mapping and (via
>>>     __vmbus_establish_gpadl()) the vmalloc mapping space.
>>> * __set_pages_[n]p() - called by set_direct_map_[invalid, default,
>>>     valid]_noflush(), __kernel_map_pages() - operates on the direct map.
>>> * kernel_[un]map_pages_in_pgd() - operates on EFI ranges.
>>>
>>> This work is based upon Denis V. Lunev's excellent analysis of the bug with
>>> gratitude.
>>>
>>
>> This seems to be causing regression in our linux-next CI [1] on some of the
>> older machines (fi-elk-e7500, fi-ilk-650, fi-pnv-d510)
> 
> Thanks for the report!
> 
> A small note - it'd be useful for you to clearly point
> out the revision of next to make our life a bit easier :)
> 

Ack.

> I can see from below in the stack and the URI it's next-20260720. There was a
> broken merge in linux-next for a while but it's fixed by 20260720 so that's not
> it.
> 
>>
>> <4> [196.236867] ======================================================
>> <4> [196.236878] WARNING: possible circular locking dependency detected
>> <4> [196.236890] 7.2.0-rc4-next-20260720-next-20260720-g3fe08b9796f3+ #1
>> Tainted: G S   U       L
>> <4> [196.236906] ------------------------------------------------------
>> <4> [196.236916] core_hotunplug/5687 is trying to acquire lock:
>> <4> [196.236927] ffffffff839048b8 ((init_mm).mmap_lock){++++}-{4:4}, at:
>> change_page_attr_set_clr+0x10a/0x220
> 
> This is the result of my change indeed.
> 
>> <4> [196.236958]
>> but task is already holding lock:
>> <4> [196.236969] ffff88810c852238 (&vm->mutex){+.+.}-{4:4}, at:
> 
> So this is a lock dependency issue as this is obviously an entirely
> different lock.
> 
>> i915_ggtt_driver_release+0xab/0x260 [i915]
>> <4> [196.237572]
>> which lock already depends on the new lock.
>> <4> [196.237585]
>> the existing dependency chain (in reverse order) is:
>> <4> [196.237597]
>> -> #2 (&vm->mutex){+.+.}-{4:4}:
>> <4> [196.237617]        i915_gem_shrinker_taints_mutex+0x35/0x70 [i915]
>> <4> [196.238267]        i915_address_space_init+0x226/0x2a0 [i915]
>> <4> [196.238961]        i915_ggtt_init_hw+0x2c/0x140 [i915]
>> <4> [196.239638]        i915_driver_hw_probe+0x208/0x380 [i915]
>> <4> [196.240260]        i915_driver_probe+0x113/0x5b0 [i915]
>> <4> [196.240883]        i915_pci_probe+0xe0/0x1d0 [i915]
> 
> (another small note - running scripts/decode_stacktrace.sh would be hugely
> useful as these offsets aren't so useful unless I have the exact kernel
> binary you have with debug symbols :)
> 

We have not been asked for that yet but we can surely provide it if it 
becomes absolutely necessary for debugging.

>>
>> Detailed log can be seen found in [2]
>>
>> We confirmed that reverting the patch solves the issue.
>>
>> Could you please check why the patch causes this regression and provide
>> a fix if necessary?
>>
>> Regards
>> Chaitanya
>>
>> [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
>> [2] https://intel-gfx-ci.01.org/tree/linux-next/next-20260720/fi-ilk-650/igt@core_hotunplug@unbind-rebind.html
> 
> <snip>
> 
> So looking into it we have deadlock potential here:
> 
> 1. fs_reclaim -> &vm->mutex
> 
> < device init >
> -> i915_address_space_init()
> -> ...
> -> i915_gem_shrinker_taints_mutex()
> (mark the dependency in lockdep)
> 
> This is presumably because the shrinker needs to lock this mutex.
> 
> 2. init_mm -> fs_reclaim
> 
> This was introduced by my patch and there we have:
> 
> < caller needs to set memory, e.g. BPF >
> -> set_memory_rox()
> -> change_page_attr_set_clr()
> -> [acquire init_mm lock] <-- my change
> -> __change_page_attr_set_clr()
> -> __change_page_attr()
> -> split_large_page()
> -> pte_alloc_one_kernel()
> [ allocation ]
> < trigger direct reclaim >
> 
> Thus init_mm -> fs_reclaim becasue in split_large_page() there's:
> 
> 	if (!debug_pagealloc_enabled())
> 		spin_unlock(&cpa_lock);
> 	pte = pte_alloc_one_kernel(&init_mm); <-- allocate
> 	if (!debug_pagealloc_enabled())
> 		spin_lock(&cpa_lock);
> 	if (!pte)
> 		return -ENOMEM;
> 
> Note the CPA lock dance, will come back to that as that's how to solve this
> issue...
> 
> 3. &vm->mutex -> init_mm
> 
> < device remove >
> -> i915_ggtt_driver_release()
> -> ggtt_cleanup_hw()
> -> [acquire &vm->mutex lock]
> -> ggtt->vm.cleanup == gmch_ggtt_remove()
> -> intel_gmch_remove()
> -> intel_gtt_teardown_scratch_page()
> -> set_pages_wb()
> -> set_memory_wb()
> -> _set_memory_wb()
> -> change_page_attr_clear()
> -> change_page_attr_set_clr()
> -> [acquire init_mm lock] <-- my change
> 
> This &vm->mutex -> init_mm
> 
> And so there is a circular dependency:
> 
>   	&vm->mutex ---> init_mm
> 	      ^            |
>                 \           v
>                  \--- fs_reclaim
> 
> (lockdep should totally do diagrams like this :)
> 
> In reality to hit this you'd need something to be doing direct reclaim on
> allocating a split page table during a CPA operation with a simultaneous
> contended init_mm lock.
> 
> But this issue is broader than that really - we can't be holding init_mm
> over an allocation.
> 
> split_large_page() calls __split_large_page() after dropping the CPA lock,
> which opens with a revalidation:
> 
> 	spin_lock(&pgd_lock);
> 	/*
> 	 * Check for races, another CPU might have split this page
> 	 * up for us already:
> 	 */
> 	tmp = _lookup_address_cpa(cpa, address, &level, &nx, &rw);
> 	if (tmp != kpte) {
> 		spin_unlock(&pgd_lock);
> 		return 1;
> 	}
> 
> There's also revalidation in __change_page_attr() on every split:
> 
> 	err = split_large_page(cpa, kpte, address);
> 	if (!err)
> 		goto repeat;
> 
> (Where goto repeat entails a complete rewalk)
> 
> So dropping the init_mm lock here should not result in any problems with
> being raced by a collapse and was something already accounted for.
> 
> So the broad strokes of the fix is to eliminate the init_mm -> fs_reclaim
> dependency and thus break the dependency loop.
> 
> I'll send a respin with this addressed.
> 

Thank you for sending the fixes.

CI looks good now.

https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?

==
Chaitanya

> Cheers, Lorenzo

