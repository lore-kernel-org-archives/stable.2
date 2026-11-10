Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794339608;
	b=CVBpyT1xSBSSzV91wb/y1d047NGkp9xUYOGPy9+vksG1viXADGD8uERXz9TYYVOxYllb
	 oh51sGA2W0eFf4AsKqjzLI802/sHyI2LYYsGfq52U0ZngZLXnOlp6SALKKgrkvf0lk9VI
	 HGUz3+dRPxSNpP0Pj+ZEMb4p5yms3/80jEf/NjR4Gm4T5DhLe3IIg38FRAYOUV5DLzsz4
	 rIy+Xy594nCHOqjpLS+AYaCX/T6jASMYTeDYSYdgMgAdzVj30M6iG2tqspwgnLX5IbjTZ
	 UFA/XMyrR3EXC/0Rd32ndeG0bQaam4I2xRW8kwoiwNQZRXJwLLe11//KaVPMC9y7NyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339608;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=B4cacyDtESQUP31McQx/3bN3CkZMh68G+hoRdl5LTLs=;
	b=sA2Nxzngnm3/+9ujEtsryvCAflsQUCllR9ZwyQTR5SH6lqEbN02t45soKAXUdKa+ruIO
	 RW0EIAVtJG/jh1U7IcWlETC0UhM1TVuYsT8+CyNbZIDtLVq4wotfndySf/3t7plwLTLHM
	 sW0z2cuCYKRhLLJoPHtqIBsoeZqXZ6tRwNCPuSfq5i4YO7xtDKUbzwtoFEEKUb2QJF36q
	 x1hAOcQJqDgUhrIt3iOIZwOjGumcJDbRikOU92Wbe4JS/70pQDLVDjYRvnV+UhNi0RC4g
	 SSQ6w8Ffaul8UAtCf0ClEjd4oafYGydbUtk6LWljpX3qgbrb/5PPw/Q9RYuiifS6CXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fTMexmft;
	arc=fail smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A0606A31C;
	Tue, 10 Nov 2026 19:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 704A0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fTMexmft
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794339607; x=1825875607;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B4cacyDtESQUP31McQx/3bN3CkZMh68G+hoRdl5LTLs=;
  b=fTMexmft9eYenerBmQEhPXY/KoMDNV9ubexM9j66O918i/Uoh26UiyjQ
   Hw3vPlgOx9Sjq9m5G6Gdwe9ayyu/eC+faZboZJ8kYrgE4Ck2cSASk/38b
   dT3mkauYx8qNu83WGYOM8kOdF+XuMKDgeMHHM5UBabM/wrF4BKCl+nYod
   yAlhYcUffqysPHAuYz3cP4ZjmZA3Fl4ZEtijElagYH6vcbJNJyS85gsRY
   Fjpad20x95lMU6W4+f2MAYwHEWAtRfO0URiyQnaZymV8UV5uR/HPKUYJK
   pDExhkR5vR0LFwgkD1K/SEniNxN8tvSac5VBBkRnOrdyKj2RGKx2xowlw
   w==;
X-CSE-ConnectionGUID: MN0CmpmoQpGcpU6Z3FQ7Dg==
X-CSE-MsgGUID: iIiwmXjgSqu5CavKNNPidQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3016938"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3016938"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 11:40:06 -0800
X-CSE-ConnectionGUID: jVoukwsrSuqQiDwHCTUXPQ==
X-CSE-MsgGUID: /g1s2oqwRmG32WSO9J2ymw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8671061"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 11:40:07 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 11:39:45 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 11:39:45 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 11:39:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLJl1twh99WqM8O/tcTN07FCNBPa/jHtDAboeD3aw7uLcPDu/oy98MRxxXIQm4y1WRMz+h2kbTF7NHI0nk1Wwrh8lC2WmKIzfHTUJCwynsbsN2m9RYBiHVKCOzJcfcTCE3Nuz2phO5ansipG1buXJrzl3lFGvq7KR13DD8kyi9Xl01b/yFzLVIjqpvcVE6HGpcyNHQVhN+5Kbh8ERA7DR6+Tc0Jz91de3SlfkwxMLHaVSgPp2QOh5/9Y7nKqlC1N2ROQRUz6DAY2SaDeCKR4xqsXqR6Z9URfcwPwEL5QknKy2ctbD4jaOcIVpFxO0eDe/iXnjDdnNE4PDdleLA/UCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4cacyDtESQUP31McQx/3bN3CkZMh68G+hoRdl5LTLs=;
 b=Hj+ZR5UXxm9sa1NnPdnA4nBjrAGFO0HhT+/anp6plJ6ZdPB6Nl6h3DU6gtc9TZnGIzse6w41Rb2Lo3dUfPvaQN1KTG+AtnCDPVcAs2I0/0tJg0VZGK+7o5pVtSFyv/1drjbMrDHL2sQ2Iw9CnpWfWV0neuCbyMpStvKfEWothQAz5lQWCtP8TEEGTlnj0Bd7UcTZLvm0ts6oXvEkzCtksBxvl63rNeoK4jgI4tIhttsnHt81EUV8oN9vPzQxbnoyRzFm6lw+W9pO+rqC4jlERgvExvTPXH9fZpNcz5cKeLUPLZljvx4SNiDfsJrK5kWqyrHt8ufX3tSeCok+MZEi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6469.namprd11.prod.outlook.com (2603:10b6:8:c3::19) by
 SJ0PR11MB8295.namprd11.prod.outlook.com (2603:10b6:a03:479::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 19:38:57 +0000
Received: from DS0PR11MB6469.namprd11.prod.outlook.com
 ([fe80::ee3c:8422:6754:29b0]) by DS0PR11MB6469.namprd11.prod.outlook.com
 ([fe80::ee3c:8422:6754:29b0%3]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 19:38:56 +0000
Message-ID: <cdc9ded1-c765-49bf-99bf-a36341af8a7d@intel.com>
Date: Tue, 10 Nov 2026 11:38:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] igb: do not let a VF set other VMOLR bits through its
 frame size
To: Paolo Abeni <pabeni@redhat.com>, <tkusters@aweta.nl>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Alexander Duyck <alexander.h.duyck@intel.com>, "Eric
 Dumazet" <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	"Jakub Kicinski" <kuba@kernel.org>
References: <20261104-igb-vf-rlpml-v1-1-729621b60eee@aweta.nl>
 <984a9f14-d8d3-41d4-a846-6750f710c741@redhat.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <984a9f14-d8d3-41d4-a846-6750f710c741@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:303:83::9) To DS0PR11MB6469.namprd11.prod.outlook.com
 (2603:10b6:8:c3::19)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB6469:EE_|SJ0PR11MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6f2226-f412-4ddc-bdf8-08df3f624268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|11063799006|4143699003|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: FNRxo4KU6yvFH8KeGC1zxm/TTmzzIddVYiy4xr3wbEGzuNzS0A7CHvey3RntB14jXl5FIND5Yp+xtaXy4l7cVHTE9vs/zUG1KgNypcv7KxVLxO+WIyb+BzzeBR7KxGvkiWfzWeC8U/2R5b9YhAPwA26aw3N23wV8wGUhln1SdpCwodNIs9EDiD2RAXL9e1+cthsE8VxMhtCpaH/K1tetFO/coTseqaqKjF7C+ETId5XqwqIN2sk2zk5F627n9RFMRwxs1BxfOghm5AunvA97ZlyjOKSSjBMXZ82ddoEijtWmD+9fUOVQNYlsewcBDXYfFCVV/7RTY2Ys6UpT4E24Geq+dNMnXBggwH+FoA7ZxEor1KqC4lotsKK0HrajOtknKr0RIv5h5GS1b+9aKpmVcdqlgzURXQZ9T2zSs4OXYjglfnfSD1r0l6OOCGAu8AebJyBv+UdJHeObgQgyKCOYOxpYDXDoiwWLy1w5kNp5EbId79mcJa6oeUKQp0QyNJFRcXju9by2pmgmJKAzc9IJH90yjoScvYTm4jtkXso+BmPBvr7PzTs3CM+htmFHQLxxBGa4YmCTlzpgeoINcVqymunug7LdXmjOzvaX2ITVHXuv1oz0yKydNcZiw+c1+mEMrCWHrzfTGlo9yUmmkDxN0cRdVv8c+ZLLhov47YAooCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFhoSDlybnc2MnFoVTRrR2x2bmlxaHhTUk95TExpcm8yNVp2NWRKMlI1dC9j?=
 =?utf-8?B?YnRlaDZNNTRTQlZpMTNFSUI1ZzVpYnByREh1dnpUWDBWZjA1SEVtcGtZekQr?=
 =?utf-8?B?L2wxNzRWRWtTYWhBc1FzbndROHRwYW9IRUJNdFA4aElqTUw1T0ROc1AvVWI3?=
 =?utf-8?B?M0tmcDVNM1kzeXR2eGt5bDBVVDEwanJBKzJvNi9XdjR4NmJEMWlVQ2xER2FJ?=
 =?utf-8?B?eHZST0JMY3IzOXZHY2FFMERldkJkS0NneDI2L2xicXNKL2dPZEY3Y2c0d2xK?=
 =?utf-8?B?Y2JRUGQyRnViRHdKR3Z6cUpFNHRHSXNpd29hQnByVEFPaE9BcUVHTlV5YW1i?=
 =?utf-8?B?djN3VHo3RXJtMWRFcnJFdlBwZDZIY203Q3lnU1FneHNORHNvTHpQbllNeTVa?=
 =?utf-8?B?bVJkaEY1RjFvTlhBZVBlV0ZLNFVFb0czZys0QnNMMHVlcFBCRGhCT3J2bU9m?=
 =?utf-8?B?NTliWHZOTGY3d1ZBYnNySmNzQm41Rlh0V3c3Vm9ZTTZEMk5YcTY5M1BJYTNQ?=
 =?utf-8?B?TUZFc0hNRENaZVU2aWdlMWQva2lxSVpvZi9TR3hyVm5HdHJJcUMvRitNS0lm?=
 =?utf-8?B?bnFyb0Jjc0kyNWZrUWwyYVl6NjY3WGU2MHk4ampnZEdtS1kxL3I0a29jVTNC?=
 =?utf-8?B?NVc2VldHcEEzb00rK0Z0M3JOcU5vc2xtYnZSVXRrRUtuSndZQ2w4QkJLYTRt?=
 =?utf-8?B?RXBkZDczRWczVHhvOVlqOHNTZ0M2YU9oUENPWDV0R0V5VnJ6ZFpaRWtNa1ln?=
 =?utf-8?B?ZUExY0lYS1RzdXRJTFdPZGNYT0tWc2JiN2lsUDVBRE5FemhuRXh0QUJEa0Qw?=
 =?utf-8?B?UlNLV29NdUExSWhBZzE3S3ZoT1dMZUR1WFpyK21RRFRCRXlYNWZFMDVhWHhJ?=
 =?utf-8?B?c3FzVXNjdlE2TnpvMmMrKzBkOU8wMWJocjlZUkhlNmtjcmNmYTBLK2pBMWFK?=
 =?utf-8?B?cVp3MFUvaXErTURja1FPN0xBRWpwbll4aSs0UWh3elhQQllkU3dhM0s4QVdO?=
 =?utf-8?B?dlM1VkFQYTg4c0VXSkRlMURKd2huMFd0SjJGcEVPa3drUTQyS0tza0hROXZo?=
 =?utf-8?B?azBlbjRINWxPSkYvZ1EyRGxxVVQ4VFh4b3krK1AxNDdnUlM4dndVQ1VVdEx4?=
 =?utf-8?B?UVdvTkN4a1Q0dElpTUw1NmdpdWF3VGdMUEpvc3dydmFlN2ZWRkZBZm0zeVdF?=
 =?utf-8?B?enFkL3J2QzNBNmdBbXg0L1VzaDBaLzk0NnYxVWdrKzhKZkJ4RHYxS3NpVyty?=
 =?utf-8?B?OWN4M28vZndqR0F1U1B1T2hUV3MzSjA5UDBDZnVFcDF5VklndlN2UVh6dXRi?=
 =?utf-8?B?eVhCdmVoOENEVk1Hc1pUblR2RWozWGlCdGVBQitmWWRGT3o2aUxPajlRZEFX?=
 =?utf-8?B?ZVozVzlBbkhydDhRdmRybE1pUUtlcUtyeVNrZVJHV25tZWx4S2xsL1VFM1ZF?=
 =?utf-8?B?UHh5Tnd4dStzN2RXc2pkZis2dmFrV1hLS1VYVFhRNXBWeHdwbWJ6cjJMMnhp?=
 =?utf-8?B?bGxsajIwNmNZVVhIM1dyZUJsVUxiTFhMSUp3RFN4ODlMMEQ2OTY5NkpXZkNj?=
 =?utf-8?B?T2d6SVh6WWw0dzlPTXFVOXZQUHdEZjNhVkg3c1R1Um8zNkFVV1NDT1MwY2tN?=
 =?utf-8?B?bVplY0kyanZZcGVzUzFzWC9ONEh6K1o4bmdDV2NTbmFLUDR6cXpIalgySEVn?=
 =?utf-8?B?OGxIazNLc3hINUVjZG9SdXJQV2svTndFRmVNNkJOcGVETXNwMm16VGdRUUxv?=
 =?utf-8?B?aVBKK0JRV0FBQVpuaW5lZGp6UlhERmJScktVdlM1aFpkT29DVXh6R0kra2hY?=
 =?utf-8?B?L0ZPN0p5bGcyWmVQWXBLMjc1UHZSMFByanovWXYwQlgyTTFKOWpPL2VWc0xT?=
 =?utf-8?B?blkxV2NLZUFSMFRZNVFucHN4VHl2U2hXdEFRVVNGSUk4NmpuZUpVL2c2QTYx?=
 =?utf-8?B?N2lQZXFMU1krYVhQZGpiSFNscjRNeEk2Y3EzdFRrZTJZQVNqL05UdXIyUVJG?=
 =?utf-8?B?WUZncjF5VTJQbUxvTlFmZEJURkpVTWJFZ3VhSnFsT0pFUEhMN01wWXRvVUV0?=
 =?utf-8?B?b1ErNUFodDVzTThjaE5VWWlQRW5RQ292djlDL3lNbzZzMzl4WEVwZ2ZYTzNR?=
 =?utf-8?B?YU0xYmg4ZlJUTjF4OGxVK0xUM25QRytkMzVVUVF4LzNDNkhKd09xMTRONUx5?=
 =?utf-8?B?SXhPOU9LSCtBdmtzVStTcDBGd2xBUVdOaDl4dmcxSVVuVXRjeDhkTGFuNU1S?=
 =?utf-8?B?bEE4VTA4ZDJzdEtyWS9tQ1lqeUpsL05uKzJZOEMrczB1MFptVUxBc0gxYW5h?=
 =?utf-8?B?RHRYUDFLMFJTRzAxMWo2QjNKQk5UUGEvbVBFazZMMEU1RU5GOEdmVmFmWklY?=
 =?utf-8?Q?wBWe1vC1fXm9BzGU=3D?=
X-Exchange-RoutingPolicyChecked: NW0w9b/Gu9G9wsiwTXVJN9Iwcqcs1PhHx/yPrm1ZX8dJxidZ/1jQyHIE6WDkvU8aUNd29jYcPvUDc941chTmHu31evLWwf0VzT5SZy4XCO4Yillve4tx8Z6S5F8y8uWouKauiaOzmIJL0T4+UE20niJbM72Va5vsNlwt1oMoe0EvYaM0QzavXcqur3FqOVzo0pym/k/e/d5h24DCrdmNFNu+zFqzlm3NkEO/pZey6oqnwRecDaDb7DlGVPlTrMUG+QgibamEtB8pJKraYZHMFbgizmX5pg3aLOoz1B57ux15Tke6BGagxRnxaNZZZAaACv02MSgHHgUtuHTm/Cbcyw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6f2226-f412-4ddc-bdf8-08df3f624268
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 19:38:56.7884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jl+GQLQQsJk0BhQyX9n9/ezCsIzxv9OCuEfiXY7C6KH4EE3VY/ecl5LmAL75M3sR9lzlQjIGC213clUjtf7SFlB2ZbEs2PqaxDDJ4AZPVR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8295
X-OriginatorOrg: intel.com



On 11/10/2026 6:48 AM, Paolo Abeni wrote:

...

> I still assume this one will go via the intel tree first. Please LMK
> if I should apply it directly, thanks!

Hi Paolo,

Yea, I'll take it through IWL.

Thanks,
Tony

> Paolo

