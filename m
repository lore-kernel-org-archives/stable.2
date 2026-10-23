Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792761968;
	b=uAAZgVaOlcIbxnxBrt3LIjt0JpRl1QE0+VUaVOXhzxd3SdbdfiF+Th/CrlqSf2ku5qgf
	 FBeNT8ftMqPR+87Al+9dXvdwmvSCwBUynJANIUsVDRgU4HYcBAfqJH2wkWveEhmXgSMc9
	 mJ7pwH2o+mMCFfTYmZQ0ZnC9w3g3BTeKjN5cO2F2r1zqkPomIDehPt/dmjKB1Bsvvr4fP
	 MLbzDfffMSk4Twma9kZBpzqmJV3YvVX8PwCS5V9FyZqSMKj2zpAwjbIRlvZanhjIkAtKO
	 LrjmAQalHhpfnn+DCoZl295p3yIIS8rg6J1BU2CAVgqP2pkKtVrMXx52giQaRFKSXog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761968;
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
	bh=oBn6y2HhSYs+C9r505sje5jN6aHXmlprd+r3HT0pI/E=;
	b=RDs8rjauJhoeFPvt1FC4wtkeqxZswwHLK6U4H+IT5RCVXb1Vtieikk0U6xX5kujK8eBk
	 Qj17TBUf4tAmc/tV3vbQQaCrZKzJBMtv5ZjSV2kNVLHcHJuMfTpApeA1dpH5rCJ7e9ziz
	 cpsWPawGDJa7SbOr58UKmsIlZP10s+7Q19o/D4GKWLNSTfI/RNsAWqbwXwqdFAhi/9Mvb
	 xqgOYZQbkqCXxj8dgKxLfFmwGgvvsbhSscIKv3WlajdN/mJIqTdW/Vg+bMC+yRv+OPKWE
	 Rh4VMyOV0vMlueheDVKVma7c59PMYVRiC0PYsskEKzwCmS7LLW8h0wd+KraQ1S8i7zw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BuTg6TNg;
	arc=fail smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23384606A322;
	Fri, 23 Oct 2026 13:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23384606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BuTg6TNg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792761968; x=1824297968;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sPYZyafdGCwrt6HbjDcYjErHx9GK90hWujApX7ALPTI=;
  b=BuTg6TNgVspJF1yzK/U04syXa6KZlWmuawj2U4SP7/Srj6U4CadFu4oq
   2xiIttzmSjgRAWcOyW9/zR23gkB2tUW4lXIAb1yfusdbKe33hTmHw8BWq
   ZJaohogyztjq7vfl5YnTjfAi2ROgS3K8f1FT+v1t8Y81ZHChKwql3GBJn
   xIRpsd3Jt4VKugOOgLH8mXwVMnHKPuzU1osZPqyIn5nIAUMRvI5pJKRkZ
   uFeVhJK5XBqtfJIB4kBES5eDFrWLziqs5rocI+BsZx19isa0cisz/ED5I
   uSpiacMG3LCBj8E4M06GAt48OLC4ufMV+6J5Uhhn2/9O2I7Mxqoge0piC
   w==;
X-CSE-ConnectionGUID: ByKng9NAT5aIR/vdB02Irw==
X-CSE-MsgGUID: YOi7KWJHQMGyVyENmP7U1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1406327"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1406327"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 06:26:07 -0700
X-CSE-ConnectionGUID: +aQ3jtQ7Qa6SSVOR9rhhPg==
X-CSE-MsgGUID: eeeN+w3JQGahugPR0u76DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="4132554"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 06:26:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 06:26:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 06:26:06 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 06:26:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8km9VTc/RHFpOZsRwRwOE0ayGB7eMW/tqFk1pINrpsnTzhog8LgMjft/BjJhcFNRd/te+YtY/z3h+nQbs2a1ph3gjwRy6bp/Knn0KAhFuYrVotXXHmftPaF3UWX4AinATGV46JjetnFJG/RrHxXczOQaCfKzVpeWZmxYRwz+zHPprIUX1eknIW+tl4bGMEWFTxh97g8Ci2qUiFSGMrvJxIszK9sH7ImSNUSVYHxNBxh9+YffQHLdAcw9k49q1etp5dljjHkJCGJsECkpxSWsWT+7Nm0//HoP8J+ASAdSllikwyZd+ECyXPDpov2MLst2vecWksoRysz2l+wyB/r7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBn6y2HhSYs+C9r505sje5jN6aHXmlprd+r3HT0pI/E=;
 b=TDk4FrwfyRalh8t8jke97ocjztkn4YOrYnbscaAJ7M9GLGInZQcNv3eoGCeErTsIXyyM9RdmlQl8GXRHwbmkaD3HISygUoLc0N2i9ncRO76fKSUHqQxmeNeNylkrhWUoXJTSlZVU+nXAlpKS58Vc/0kgOAaQXvEtg7kt8Tvbj4F1B5f4dWdl1810rdnSYzZheawidA4X3NJ1UrcXktPOYPc9JI4NSFIpZDoOVsLqUnz1aa9tjDa9Vd4RUOHjEMjwNazKxpRt7rnFOCpJYVWFCwT6MFrR/Bwhb1o9+bdV6IvJfeKJjigeCaR8fJ9BKACVqKjKxIEYIgoby99hmjt7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM6PR11MB4643.namprd11.prod.outlook.com (2603:10b6:5:2a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 13:26:03 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0496.021; Fri, 23 Oct 2026
 13:26:03 +0000
Message-ID: <1144c19e-3b3d-4688-a594-7e0e3aa7b33f@intel.com>
Date: Fri, 23 Oct 2026 15:25:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "ice: drop page splitting and recycling" has been added to
 the 6.18-stable tree
To: <gregkh@linuxfoundation.org>
CC: <stable-commits@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, <alexander.nowlin@intel.com>,
	<anthony.l.nguyen@intel.com>, <jacob.e.keller@intel.com>
References: <2026102335-ruby-freewill-98a9@gregkh>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <2026102335-ruby-freewill-98a9@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM6PR11MB4643:EE_
X-MS-Office365-Filtering-Correlation-Id: 629bc3be-d4b7-4047-1f8e-08df31092f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|10067099003|11063799006|56012099006|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 5qlVn/AOgBIwoCBDdpRNWTTm5tfObkODijHiJWCYlasSr1LyMVXOnn/wdG4791qKx2EIaRnH23x6b1oQpRBEOh7wUVGN3vLaEOOPVteMpYixVT1sZnbjWhZ2CXLY/fmGj8H0nTScvCF/dUObP7frjBoDBOBT5HkjTjjGuATQJODwaN8trSJc1UgB0FyYlf60JlqE6E4bAoGnyaerIPxiOLOAkCdTVlwp66qIANaUc6v/9odExpUQxpaBYF15nWSbMS60piHzc5Ey4ng6k/ZP/1GU2UJGJijzUaVHoSolqPNcHtoaqBjkq9zpThzSBXDHisPIymGpXl5z6xcB7lQSodMYV2QhXexnBq4dBC6QNNyKnoclV0HeUpVg3EvwR3N1hB/LDY7LVBzugZ8mfVpniKo0DcIwiIvnqFb5m3fFyS+/VS0ZcO+H0o8Dr9O0p4pD6GwL8bd2Y8lv9xc7NhPRQPyJRQj631v1TCl1EsQXHS8pMD7ASGrw0XVLwOO5zB9RNjFMN/o8/xNe7gTonynQvhimwUVkmT/vkhoyAD1Dxf6JyBWoNtD40ZRzSjXhPgdT36eNP3vSWPoBX/M8kiMrHj8k8O4cJHiW5/8nRXIrhuTU/Q+6CLF1RtIhWgMjZ6+j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3ZycG1Wcnd3VURXZkNhaG9BRlh2MHI4bE90VkpuK3M1bTNjSUdCUWNEN0Mv?=
 =?utf-8?B?cXI4ZkYyTWdXSmNYVW4rWjMzUzg3TW1IVHl5M2ExQVNsZThWUkdLVEt3TEdv?=
 =?utf-8?B?b0xGY2o1YmI0dkY4MmtlYzZmekZlS3EvYlJMV3dmS2Qxcjh4MnU3VEU1cHg5?=
 =?utf-8?B?SmlHa3RSU3NvQXkyK0ppRVpybWYrcEVyUkpNYmIwQTBLeXVJVlE4Q25US1lP?=
 =?utf-8?B?OFdxekIxRmtFZ2FNb1ZIYzJvUkQ0d3ErV3NUOEJVTk9WUm5YeXEvblFDK3l2?=
 =?utf-8?B?QVc2THBnWDRZTE9kekpObC9jQlJZUUl6bE5aRnpwb3BOK29mS09lMmNZTUNN?=
 =?utf-8?B?TzZPVGE5TmVWMjNQSXBaZDhzTXBlcHR4bzM3c0lYcFRxWFdVODhoNUtMekVh?=
 =?utf-8?B?dHhRa0d3SDdsRExpb0xTcTBFZyt0L0IwL1BaTjlqeWYrbXlONHYzeVdhMy9J?=
 =?utf-8?B?SXVTRVJMZzlSZ2lxcEhqVldyb3NhTzVlZDRFVFlGemh2bWM3d0hGYlozeTRE?=
 =?utf-8?B?WUgzMk44Mk8vYTlqL0l4UkR0UUF4ZG5KZ05UZW9xL3F6YmtrSlNVRHp6ZGlP?=
 =?utf-8?B?V3orbzQvZXc0OXpOcForVWRsZlcyT0J1dmZrNVRlTjdISmZpbkFhWHZVWE96?=
 =?utf-8?B?eVpYTHNJMTNValdEdXVPUzUwVy9PZGlJdTBqaWlPb09mNFlDQ0wzeHptR2Qw?=
 =?utf-8?B?R2NxL0tEa1lNRDJNRzQwV1N5SzdUR0wvRDBnNnI1QTRWbHBMZGlOSEI5SU1q?=
 =?utf-8?B?c0NLbCtoMU94NmFoN2JmUHkrREkwbVZBTHBURE54MDhiWEZ3QWRkUzVMQUZN?=
 =?utf-8?B?N2NOV0pCYWgxNXVBdjk3aHRoc1Q5OFlLb1R0YkF3OThSYktXcWViNUZGWnE2?=
 =?utf-8?B?MFREQjVSK3ZSZFBRelNPU0piaCtabVZYN1drQXVpeHV2Y3htcmxTZ0wyMWdV?=
 =?utf-8?B?M3ZuYTA0WUVwRXhvVHVISU8vQjRnRmNCeTZXSGVHY3dSdVRZM0xobVFSVThs?=
 =?utf-8?B?RXljYU5jdll5QThEVDFrQlBleUR4aVFHUGlLb0tVcmJ4T0syZ2NuSFdrVkFp?=
 =?utf-8?B?V0xjN0ZQTFk0azY2b3dTTDhZRVRqZjZjV0FCbTZKeGVPK2lqYVNreEdjTUZ6?=
 =?utf-8?B?bmdjZUFpVW9oUG0rN0RNVmZUMGRJR3ZZcE5KK1NWQlJUUkN2bzdxY0xiSTBL?=
 =?utf-8?B?TjZPNWVsRjk0SkFhakRFVzk4SVVuQTY2Z2o4UHgwU3EzNndPNFd6SHVKRXM5?=
 =?utf-8?B?MzNPaHVlQzdEWWhjQXRrWTdpN1M0YXprd1JCYjRrWTd6R3lpSUo5aWg4VlY5?=
 =?utf-8?B?WFBhN3hGZ0lCM0pNVVNyR28wK0xaVlVqK0hlRGtGbEVWWFpuTmVwNWhBa2Yx?=
 =?utf-8?B?ajROZXJuNDRxNXJDcnVwemxTcVQ3WjBOOVIvdmVqMzlXRG5ZYVR0Wjl1R2hP?=
 =?utf-8?B?bWJxOStZMzcxZktGSjk3bTh3bXB1RlRwUEpSWGZhOFA3OXlNRnJjTVNmeUxa?=
 =?utf-8?B?UDMvOUNZVlBYZkJzbFNqUDJBS28xZHhLSjB4NTNGbFNFWHQ0MFFXQ0RkZWt5?=
 =?utf-8?B?ZzFFMHd1Y0MzUEYxUURROUt5bWs2TlRka0JZZURXVzg3V3grTGI4VUF4YXpr?=
 =?utf-8?B?R1owaitLMTFyNys1ZDlOWi83YTBYSWdiVTlBTTVmMFphSk5vWEJxZ0VISDBV?=
 =?utf-8?B?Q0ZWQ0x2Mk9xYTU0YUQvV1cwL0cyb2RINUFub2RwNHJKS1ZnRWVaeE5wTTNv?=
 =?utf-8?B?NWR0WkswbTIxZXdwcjQyWnRiemQ1bC9sUXBPdGhrMGpuN2E2OERFS3I2UjdX?=
 =?utf-8?B?UVBwM2xLNklHTXYyM2hGYTlXeStZcnU5bnBFOGZvNVRHOEJYZEJ3VTg3bmhW?=
 =?utf-8?B?czFsOHVjU1hkdHpZUTVOdGNXNHhKOHN3QkVYeW9wbURQTlRtSFU0a3plMnkx?=
 =?utf-8?B?NGZBZEkxNU5LR1NEV3RkN1pMeXRYMFFsNnlYSXdZbVpVMFhmcksrdTNOdmtK?=
 =?utf-8?B?QytDc0habytFQ054cit3SU9XVTJqR0hSSEQwZkZzenkwVkR3OVhSSjk0ajB0?=
 =?utf-8?B?cDBNWnR4a1lidWdLSVZuVW90aXVvQnIrc3RUcG11TnloeW5JUGJlNVByM0l4?=
 =?utf-8?B?cXhuRnI2NGtDUTlaWXMxakcrWU5XQnRuME9mTFY0ampWWWIyUDdNUUtnTHg0?=
 =?utf-8?B?Y0lxTjc5RWhDTjlVRnhhVi9oMFpXdzNYNE43Q2xMejdscXlJdWhTRUs4RFRZ?=
 =?utf-8?B?L0hKQ3plcDlCMFF0NHY5b1NRd3hoSWVnV0tBR1grVUo2Zjd4MG14aDBUdUxV?=
 =?utf-8?B?WXkrQng2K3dsZGlQYWlXa2tUc2g3eFh0Wm00U2hRdUlqb29BVTR3aml2K1dY?=
 =?utf-8?Q?3NwfuIrn7Mv/7v8Q=3D?=
X-Exchange-RoutingPolicyChecked: 1snqg+Swjqz6aRwU3U+qBGsdkiWCR80umFnZIRxX41vj5rdsRDZaxv3GoGooKKaGKUhRka2vd0OEiQ98h1N/iv1XQptRp7WKQnZPt6+G6sXgHeC62n513P9yql8pjdsBAJe696bdPOz3UKrgA42Fe6ANNQLeJc2hUwyrnkqu2Xc531ASdSQnLH6BMf6n9WE7X8wDVbZncSnywKZ7t2+kLla+eAnAIARte4/R8Ak6eTPW94EAHPfG0S2x+bfHHJm7LUWC09GTjTleHIGupTAqkZGV14PeUFW51qcD2vXOco9yzgxGn1NadnGoawBug7/s6j6zPP3EgvdGv1QCBcYg1g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 629bc3be-d4b7-4047-1f8e-08df31092f80
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 13:26:03.3946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hr/+GkSfvDSyTtr0eIVU7e1e0t4bRTFSHeKsujJ32nEUURUbaSoTIP/vBfcVsGr8UTSYE0/lnBlTnK/NWfayWUaPh89kPosVWpglqNh1T9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4643
X-OriginatorOrg: intel.com

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 23 Oct 2026 14:56:35 +0200

> 
> This is a note to let you know that I've just added the patch titled
> 
>     ice: drop page splitting and recycling
> 
> to the 6.18-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      ice-drop-page-splitting-and-recycling.patch
> and it can be found in the queue-6.18 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please drop, along with the predecing patches ("drop legacy Rx" and all
that). This will cause huge performance regression on LTSes.
"ice: fix broken Rx on VFs" is applicable only when the commit "ice:
convert to Page Pool" is present, otherwise everything works.
Another option would be to take PP conversion to LTSes, but I don't
think it belongs to stable.

> 
> 
> From 3a4f419f750946181e3d6a339a1ef1942c5b5685 Mon Sep 17 00:00:00 2001
> From: Michal Kubiak <michal.kubiak@intel.com>
> Date: Thu, 25 Sep 2025 11:22:52 +0200
> Subject: ice: drop page splitting and recycling
> 
> From: Michal Kubiak <michal.kubiak@intel.com>
> 
> commit 3a4f419f750946181e3d6a339a1ef1942c5b5685 upstream.
> 
> As part of the transition toward Page Pool integration, remove the
> legacy page splitting and recycling logic from the ice driver. This
> mirrors the approach taken in commit 920d86f3c552 ("iavf: drop page
> splitting and recycling").
Thanks,
Olek
