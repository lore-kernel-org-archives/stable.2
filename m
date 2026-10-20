Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792519791;
	b=eCevsr84QaDts9J8qkvjPa0yWOckMYPZys0D5W73b13ipj2+q+EDE6PVuicRKk3VeN7J
	 UcrAvAN6oCvS4jqgGjQ/BmfJvuJrnVL7SHMNoj1QYcbHlYw07ncoEFxvEDAahJShgO15s
	 8edCgk/rrqG+WyBSK+qDcwUR3obxT4gd3EeGgCEEWDJnexAvIzjreCZ7LSgNzdAuWW0Ib
	 fU5YNB6sVw8kJdgCiHk4Ty50jJKIMypkxuOk2hzsbLVaa5jUlgRWEQjEe53MUMAll/FT9
	 lY8Iu0bwaGbbKKa6zpolBupQrWyh8cO3O2PIl99RzrU69Ixvi9vbvxFAf9kL0UvZVvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519791;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:From:Subject:To:
	 CC:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=JVPCMmUGT/Rn7/uP0DVdR4SUkhdL/SL3me79XPE7CHk=;
	b=Rklv5vI3w5bPDDCQXHUTiAnm/Ds5lRiGWYiqis7v0GpjezhG4w6mIF1gA6Acja9PsO9P
	 z5aANb6ivZpCn0Z/eGASkg5TA0/hJtG+AgfHNsO8ly9qmw0VbcC1A0WFaRLPmfMcKSA6F
	 4YkXOdUsLbqApfYwEGGpbPrxzJLOcM0xT57wab0ugpPBecyDSoFljT118FvMMQbVi7cpV
	 YQsmhq1UfgLPG6ecxcW50Z4wKFH0GlxFlNOHSw1wZVRfQQjhrTWp+sRtgH2NPFVHtWMLo
	 IdqfXGr9jpwqW9RepT4Zfc1kvYNvQXcEcsExODASSQG0CzIAdxRbvz/UMAc23b3NaFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cV+xpQWj;
	arc=fail smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D943606A31C;
	Tue, 20 Oct 2026 18:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D943606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cV+xpQWj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792519790; x=1824055790;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UZ39NjzH0QqsYfhrh58V3UWP2rrFzg+eEzjjlB0TIsg=;
  b=cV+xpQWjcCkxfnH42urKdWRz4rB46aNmH7TD65SGLupN11Geip8cDNqf
   rltLPwmxqzO+FZfVWbLdBfOcVRLSdBn+jRASJX8ilPz0BegHGjyGAbWoY
   0Ph8oALcUF1VBd4b07QaZA57oYL31GBwTCDpc/HTd0itZFvCXzeUYhDZ3
   6LHGNxUmSl59QnzgnIXtJrS2+0+UgnY4ZKr8JadREukn3AT4OvmMMECxr
   ulnDIm1RIVOFHj1BDKVRiW8COR9pGLeYHaDS4sh9agFI0aTmWm5+WQNnb
   XcRjfigfwp6wpwW7tewAs/8OJp/PZSdsViuXb2durXEzMc0/F4tOvo58w
   Q==;
X-CSE-ConnectionGUID: OMiGN8BqQGagt066tHzj/w==
X-CSE-MsgGUID: Rx65uSzcSRiWCy7qOfI6Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1118868"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1118868"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 11:09:50 -0700
X-CSE-ConnectionGUID: gA83kFg2T9eeHj/I6dtKhg==
X-CSE-MsgGUID: qaEvlia7TFaKfqzT7bXlww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3281846"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 11:09:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 11:09:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 11:09:49 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 11:09:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJlKxSSU1jMR/MLxTGQQnwsTqgOL9cvm2FxSAWRIzAT5sC02G3cVRQIjsU39u9E6jXwdwdShqXbMPxi0nMp4nXk5V9nM+u83/BB9p86A3xkonZypd+Rau/Qe3xpZ9JcVx4sGRBLqoTZPjF3vdAwCUt8it2Z6HHHnmlPRnxLmVNMouw9Klby0Ugbo0PMX2WKKgX+kiD6GkW7vd6lWikwwuohrdnlw0G1ZhVmW07YLDtFGxgcfIGyiRe9sjlfTC13aRi8DwImSX8ocuyX1iJKbuCEQv1qtxQCIuC48OGWBHYX3Ctq/tryEu4I1mqF52yc+xpoyRzKz0LXmBWpysr3Nyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVPCMmUGT/Rn7/uP0DVdR4SUkhdL/SL3me79XPE7CHk=;
 b=ptzApEO9xdHjSm+aVIk+wNm3LkL6yl7AjxRPKQIMNnoZuUiquPgMoFRnMy30IE9ZOOAEzjDMwibnx2tw4Ekt9BzIJwAyI5tBOpn4JtAZ0Kbv6MJ0mPoOdHDAzk5sCxhmurl1REkSq5BtWBaQRbzKk0TnEspamnPD6ZSw5XflUkh4HXUuccZZQ1NXCPnZe+JeZ28bx8xuAuhApiI7Ch6KnSVqe/4l3t6DX8sae/j/0H1qvjAyV7pIOHMN+Qus0BCbIceYs5tf0rxvOJdb0OJsOvQ9eqCa6oN8VDSjdTi1avOl53Zn8RmlHaVzfM8njXpB68hfauVLkML80zNi2yJTUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 IA4PR11MB9418.namprd11.prod.outlook.com (2603:10b6:208:56f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 18:09:46 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0496.015; Tue, 20 Oct 2026
 18:09:45 +0000
Message-ID: <176cd1cd-a3e2-42a3-96f0-6878682111c3@intel.com>
Date: Tue, 20 Oct 2026 11:09:37 -0700
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v3] x86/microcode/intel: Reject problematic loading on
 Granite Rapids systems
To: <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <andrew.cooper3@citrix.com>,
	<arjan.van.de.ven@intel.com>, <sohil.mehta@intel.com>,
	<stable@vger.kernel.org>
References: <20260908223209.916758-1-chang.seok.bae@intel.com>
 <20260916225939.1144524-1-chang.seok.bae@intel.com>
Content-Language: en-US
In-Reply-To: <20260916225939.1144524-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|IA4PR11MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e2ba7c-1fc2-4136-bb81-08df2ed55274
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vS5uDV9vj3FLuPE+QsVoAUXyRh/I1GEj6K3FdjxV3G3Yb8m7SaID/ruzP7oJbB7QQwoP3C2fzmTVf22lSk2IB6gd5g6/wUicqJVqxhZ4Vn83viF5H6Dbn+6U+KqCcoTOwWoQrQJHR6OMRMN6+ngWiu57DDX8s9bAqS/PeH4T5lYAaAy1XGRe6thzKDY0DaDZHT0eSJiYoF2MCG58Q71vxu7LYZ8hGIzhnyvJoxhgVgVCGfD1LhzhCdveiCgc9I0UvqfqdcyK7S13VWCqbLhzL3u4WlHTE11jMwfzv90FWjnGpCyJARNf4l60gTWjGjs9+cNBFTECXVvWa7ZhTT3CPgwd6RqTNaXowwoCgV06hPmsieGXqbqi6lFzJbMrdP4eoQ5gy9DJXA0eFHngmBHdMGz2Qfsi94dDQpy7ewsu+njs9oJ4iie2/lK6qvOz+akO2U5lMSIsMqWHO0h6ZfvB6u9JVUdGxofrWxki/4F/D48BxT5L1bGSlhKaNQfRfKKQ425+GcTMigArUFalElaMQehW4XSkijtcSU51zekNvRN4CGhBJerMIZZIsrvKkaHG3eWZYnPUcVAn3HX2YxCNwhhnfvuBe98yWaeomgpLMPU4KcL1ShGTc66dI/IJOf2Aqj0Oo0uw5cpNi0Hp/tBzK5RPPbMcxhEBpX3IjA3XELU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmorT3JWRHhjTGhvN3ZoTkx6NlRTZHE2ZFd4M3ppNmMwdHdRWHNGTGpqMVpP?=
 =?utf-8?B?UW9wMldXN2QxZjRYa0hlYTZrbjhBeXF5eVNLYTBaSXg1NG0wMzRsWktVWUdz?=
 =?utf-8?B?ZWRXTnBwbVVQSGpoS2xZUHkxb1VNOEt5eFF5NGhwVC81R1N0ajBjU04yenVX?=
 =?utf-8?B?WFJWd0VwYUFtcEhORW1hbUNBbTJuaUZJMGF5SmYvSldDNmp5NURJUUpHMUR5?=
 =?utf-8?B?QlM2N1dnbThLRFRWQ0wwK2NPSVdNVFVFcUpkUjZCdXVHQUt5N2VOYjNOMlVZ?=
 =?utf-8?B?WmFEVFprNTRDUk91Zk10TnpoaFI2aWpPMXFjVm9YWGFZa3l4SSt3NUY5Q2Fl?=
 =?utf-8?B?MEpERndYNGpHVG9VTjE4eEJrOEN3STZVSU5XaU1yQkhWbm9hUjlqRk9jRUNk?=
 =?utf-8?B?ZWVVaTZkUHVCdkk3UnJzMmoxSkpSZ0NmR2x4Z1c1WFhOZlowR2dVUEpCSlZV?=
 =?utf-8?B?MDRuVlBXaUltbUVWU2JsL0oyekJCeW93RktnMkZ4ZXNyYkV6ZGZZalEvWTFC?=
 =?utf-8?B?aVlpczhEMnVTY2s1R0ZPanU0aHNHTFBMTmFaUmdWNXN3d2lxUkZEaDdJdkZX?=
 =?utf-8?B?SXJxUFFNanZwUTI5alpoT3ZPNDdrb1haRjNzdnVLTEM3VjNPZGg4T3RzV2JJ?=
 =?utf-8?B?NDFvRnpCV21zNnlodFNFY2hES0piTStIOVo5VXdVZW5FdXNWRWNaZkltK3R1?=
 =?utf-8?B?VzdFTGtUY3RZMmlvc3dPbDMzdWxRN21XQTA5WEZhM1I0VUpHcHlzTDVrQ1lK?=
 =?utf-8?B?QU5oQmRTUVdQZW5naGdLaE5MbkF2ZUYrQTBIcVZVdW5TcEZIMUs2MUFrekEv?=
 =?utf-8?B?NU9ORzlxMWswazhUalJSd0NmOE9lZmRnc0YzR3BETTRhc21kbjZNM2trTG9u?=
 =?utf-8?B?REZmK3AyaDFEbnZHbmkwMVpBNkJ1cXNzTEZvTW45aWttQUw0WTVTeCs4TDNh?=
 =?utf-8?B?US9rQlpSSUtPbHBJakIzMjBtR2dmK21CZzFNTytnR3pzU1JYUitvcXp0ZlY3?=
 =?utf-8?B?d28zYkhNbmhKNjdBNWtOMWhaZXVVREo5MDVlNjVPRTRTNzJXQ3NHM3NpOW9h?=
 =?utf-8?B?dUxJSmllMDV6WkNwOU91cENHQmN1RzREQWhWb3B4SkpTQ1ZmUmZvYXpJaEE2?=
 =?utf-8?B?T1B0RXJLSk5aaU5IMWRvTkdKV05lOGFoeE9JREZIeDRMRUUrYk9IRDVCTjg0?=
 =?utf-8?B?cVhobTRFaW4vMWlzbVFLTWlQNFg5OUtSUWpJZlJldUdaMklQU3VLUEdrMTh0?=
 =?utf-8?B?TUlkZXA3Nlk4czdYandTQ2tkR0J4VTc0bkZNb01ZWHhVQytWRFZnSTNkdW1X?=
 =?utf-8?B?c05lNmFKT0RMaWhKU1E0bTZIUXZlVWtQVzIrRGx6UVNpOFBqditRQUdRc3lS?=
 =?utf-8?B?OHJjT1FYTktCQWxvL0QrM3BWd0dtWTZPeVRyZGJjaHZZL1o2U1dFVytVV1E0?=
 =?utf-8?B?NzV3dnB6SzdqVGZjOUlMbXNiZlhOQ0owVlVpUWtmNENCUXhjTUZNWlRMYnV3?=
 =?utf-8?B?UUVBNkpxQnljQmxGdHlXaWRwU1orcW93WWNHcENPeGJKTWNZdGFGMW4vQnlv?=
 =?utf-8?B?bTczN3krb0dSYm9YQjk1Z25WUm12czRjb0d2azFhaTFVQWlZeTg2QjhtYXpk?=
 =?utf-8?B?VmFPTm9WS0NHZTBuRW15cFlRZ3p6WkJ2WU0vZXloeGhsNGFvMWgxUDNGZFha?=
 =?utf-8?B?ZU9xNDQvVCt4VzBqNzZUQ1doWnkza25pTmdaYlNtejJnamtyYU5UQkFVaW03?=
 =?utf-8?B?eldrUjZZMDZSMWwyd3JBOWFDcEtabUU4MWNpVDhWTFdydWtnV0ZFMVMwMVZ1?=
 =?utf-8?B?LzhjcW5ZUVJENXQ0eTdvdVBZTi9ndzZxSGI5VXJEM3ZBdS9NcG1rSUZEci9q?=
 =?utf-8?B?VUp1VUpnWE9LS29wYXZCY21CemFNZ29VYWJmb01DWUJvNGRTb2Vza3o5U2Ev?=
 =?utf-8?B?NzBJUXU3Ujd4ZFMwWVorUlNybERRZkFKeW8wS1hnb3k2bm5sSUlQeU5aYjJ5?=
 =?utf-8?B?ZlRqVjVnNmxxK0lyOXhwd1F3S29pYmxjemNmVHlIeHlpc3YrL3p0Q29zc3FR?=
 =?utf-8?B?RHdsL0UraXd0REc4VkJIcVJub3JKMVMyN05QUXpPcklVb1EzSzl6K0FXSW4z?=
 =?utf-8?B?eVB5dFB6emV4aTdGS1d3ekxoVDVzWG1MZGIvZ3ovbE9BWXhVYWhKZnBsdmJa?=
 =?utf-8?B?SXFrYkFIY1lySFRpZDdlejA4cEx3NTVMbUxtaUl4ZktMVThWRVFxYUYrMXMz?=
 =?utf-8?B?SWlMbUNWS0o4KzFUcXp3cFNhNVVxd0RJaXFsdGVWK3BNUWVMQlpuYVNSWUY5?=
 =?utf-8?B?RDFSNzRGQVpJaitGemdYREkwSHBHNFZha05tTU93MkZFNGZrVHJ5UT09?=
X-Exchange-RoutingPolicyChecked: g0yCIPqxOUL4HpbUocwtJZ/fXh1pFSB+nunppEMK7AHWTM7bn8QxzvGwplRlAnQdZiN4yVd5pd9bDSy3E48akM3NQU9/O94F4ZyqWCBR9fZiGoMpcVTlArN4Oui/dUeiwkJ3irc9ZmqaPQBdIQxa4n3Sl2HQe0v1u0jqo+M3fO+Bvy29EN+bGeORQqCjLyyaEYuwMmDfnb6DdZ6HKEexZPWUvRyJuQJ3R2nNj4uZB0rvrU3c4qbo/9tT5PNfNnB/ZEz0x7CQsGCKAilZEWHYnK4rOLxa+wvzTm1L86flwmWOyxiLCV2c8oNtYh510Zs5hcDAPLDPAupzuOJa/vlOYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e2ba7c-1fc2-4136-bb81-08df2ed55274
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 18:09:45.8205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8ISlPMWBb1pjPba6U+73W5UL2CRNZWhkxz7SBDT4zJDqBrnBDEC6x9breuhFsQRRzwC+vIEVxU2slkvb1LOaAbq2VDAIQ8Vm+MPg5i9+B8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9418
X-OriginatorOrg: intel.com

On 9/16/2026 3:59 PM, Chang S. Bae wrote:
> 
> * GNR98 currently describes loading 0x1000405 itself is unsafe, but it
>    will be updated to say okay with that. I will watch out the GNR98
>    changes.

The erratum documentation [*] appears to have been updated since last 
week. GNR98 now describes correctly:

   ... Due to this erratum, an Early OS Microcode Update from a microcode
   version earlier than 0x1000405 to a release _after_ 0x1000405 may
   result in a Machine Check Error (MCE).

[*] 
https://www.intel.com/content/www/us/en/content-details/835486/intel-xeon-6900-6700-6500-series-processors-with-p-cores-specification-update.html

Thanks,
Chang
