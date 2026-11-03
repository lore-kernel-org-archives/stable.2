Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793690250;
	b=wgMDE90dlKOhNk/gVTgt07LlFSvgMSYf7PjN4PS+OUVuvr/3s+zPZ/zoce1Ul8fN4Bpd
	 Arf/01YwFz0vDf0uPgd6l2CPPIDM0fg0Pg5wYOjDW1xgBTMa2FJlo+IIT2/rqozYK5057
	 wV+Rw3lqJ/vCop37wASgG6i/ozVJHw9VAwunS/+sbFTw1NJ8tL3sb1r9XsULYuIw9lLoR
	 HCXKA3+uU1zUBq52swk4ujErpdbqHCrT+2HGPL6yRiLHuI/lZaRZCaQKaCrQEyyJxHo1J
	 KyUzgdca2uLFY2Zm6RE+nS+EZSCNH0EHt9OEXK4dSNKpBLvpAMDMvWxHxjPzTJNm9VA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690250;
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
	bh=trAI6vJUUf0qRpN0TIfwanKcnc4rGli/9pJu9vTFNMY=;
	b=GTJg7Mat8HEMwjePPnAGHH70+uagzlGnpOR2VUzWYvuRkea12zpgaLy4/+2/Z+8sl8z3
	 F2oYiVVT4LHctALJ+b9resnm7BmkDVFg3dVG2Yrj10VnkaIUV4K2GpFgHJDBNLJFP06Nb
	 sDUpru8sRE3sFEqjnko78/sBB9e9f/kLu8C9O0V02jhBkXRCq+wcZFy0qU8qI2VtmmIgN
	 RgYOrtX/1ozdEbwCLBvgjmS/BAo3e0qVSwyw6u9TBt/jpBU2xoF7qxw7TgbpuV8t6bfZY
	 O1u4tIhPJ0iYbMjJKZv2YY8nIl0AjtJFwCF2d9WTzT9fu+Le9w5hRJEhQ8ya32ZHDmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BYSKdE3W;
	arc=fail smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611D8606A32C;
	Tue,  3 Nov 2026 07:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 611D8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BYSKdE3W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793690249; x=1825226249;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t+pTFUMhjE7rAEZf+fmE0PSJ0fLvKEisxsCLI5MvQrc=;
  b=BYSKdE3WVqBZAhfgmJBAjr71j2pLtaoFvZ8P3KOnnqP3q/J4cyB0mF9E
   ietP5oAEgTCFw6Co6+KWO9n7Jt51OgZwmMqDxQFIwwRa3oz14/kAB0YA7
   +u9upDbOSsso+4HmgxnX5yOaepkfVdK0UfCEXTOx7emooa05C4eBTZn49
   DVQT2XWt8dSYSUXK5VLvFQh0vt86CDq0+o+Qj42zv/s+Y3rtJ+HuwifqT
   u/tHye6X6tSTzHHMI+YYWsANjL3VCSaCkIIFegna2bqDVw8Y/1JMaEVbG
   s9L2FkcqSeqvJAv+07UxU8b12TBFzONYgPo/6qqzHztzGPKEC9FB0V40S
   g==;
X-CSE-ConnectionGUID: LoiOvNWbSwSs9RGXlHlEeA==
X-CSE-MsgGUID: Apwum+UgQw2LyElH/bYZjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2493544"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2493544"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 23:17:28 -0800
X-CSE-ConnectionGUID: KNqOH9+1Q5qUiim/XWVDAA==
X-CSE-MsgGUID: ibK2bYC0T5mbjJm8/nUIqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6461307"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 23:17:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 23:17:26 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 23:17:26 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 23:17:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsNKiK27uYrN5OBf8N0qdR8JJ6iuFo/rjAJi2tZABF8J0TdvgqkpQ9ljKNYoohwzWTX52w3mHv0axDT+OdM/6hIxkYUlDTH4TAeQxhJYe+H5Jqx5BOAWbFSAK1xsrvW8BBTxO40NN5W8jU68pE69SaPgQZ4R9LaTCuaEPdmVeKt3J/VPhFKyNvfqGwRaLkLsSpGPhrwouSWMdWiU8LK3SmPLlUiMsT2Uh4X7vFjO6yGxIb3epHfGmqbpZjlDHlNetLizaC7af1P1eE2JBXejubW1QHGDe9CEJTf15mDplMHqWbX1zDX+r98sTpTiSrXFQi366VCB6TNsex3ZV74UvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trAI6vJUUf0qRpN0TIfwanKcnc4rGli/9pJu9vTFNMY=;
 b=ix/4tFDxXei+2Sa0Y350nocF/RdO+QmTFW4BH5BYLj59CyRLymUzPttHlTud4bMAkgDUPEYuf6hcjpXKqALf7IBJMAk3Xnz4dfuCW9Y23bbrCDfryOCjUNUuBogLSvCwUjrnDL8GRq5vcybxJw/sfG1hukrDE7QMrmB987IVN9LBMfVah14Ux/ABrOiMnPZZZEIBRsibhNwm/s/sTGL5cxnxKyI3q/Flrbsj71CSE21hT7P4HjESZghirVCW9aSmH++oPtvJYS7sCyl4c/Os0imCX/8tiktVakrur4/lcnH6T/7ypwuHt4rAph43RfyoA2S1QzMSqDRle0bVNxv35A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA0PR11MB4621.namprd11.prod.outlook.com (2603:10b6:806:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 07:17:19 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 07:17:18 +0000
Message-ID: <84054d1a-9e89-42ff-ba85-f2d04b821415@intel.com>
Date: Mon, 2 Nov 2026 23:17:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/5] e1000e: do not cache the hwtstamp config before
 it is applied
To: Linkui Xiao <xiaolinkui@126.com>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Linkui Xiao <xiaolinkui@kylinos.cn>,
	<stable@vger.kernel.org>
References: <20261028090455.2291659-1-xiaolinkui@126.com>
 <c4c4833b-b0e9-4d79-9e7b-7db9eee67535@intel.com>
 <7f3b08fb-8eec-4ff1-a696-f8a1b3df7b45@126.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <7f3b08fb-8eec-4ff1-a696-f8a1b3df7b45@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0174.namprd04.prod.outlook.com
 (2603:10b6:303:85::29) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA0PR11MB4621:EE_
X-MS-Office365-Filtering-Correlation-Id: c606c90e-1394-4198-f343-08df397a7ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|10067099003|18002099003|261102123227099003|22082099003|56012099006|4143699003|261026121527099003|11063799006|261022075727099003|261022105027099003|261021121427099003|261022113327099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: JONxv+TAheceY9vXrrs3lf/fkIxQ5Uwt5rZlWCGR/O9725XZ16exAouYpgO4gRKDgJ2FGJP0IgbVlO0H2VdQMN8P8H+L7QTD0VMoA/QWJZFZtd88aDE8bnV6BfD9EdsdVITwrk8Cu7C5kWTs2IDMX8ZeG+m1GGGVoXVS/OIImq4sWnBZscgbY5ZwXiSFebH9nqjVqxF/2YZFtJD9K1okCR+oNAxNgPsuCOYif4EWPGtJrW0GHzTdC/XIL/C+fwi//6OxVweYwov/5GzyaDgwjE5NUgn88FB6YeZnaCb3vnduEDm1e0ye/kWt6IHawyH/+mW9V6oAPMTWgtSH9pWV609AG+s2YZGxNsuCMgWkgj59VlBkXq+u5hboZiDX8GkyPbSL32z9VStBWWueJEUE2FVlOMCCu6jDVs8g1AsVY+0V2xdo5s9ulbL/ML99wWuD0obXX6MFn2LeYfjJVzHGvjVcrtVLU/0pXhqcCKYl35KOnJn0BfYMhCp6NhMN3iB1xHc3TNb4bf16uhabxe9Nafst9gEXxkDmdMl0oDndLhicME5hboJZ3XaKdMDyEhJiOfIZzYpO0jkYjDkJ4wkcrs1jvkkfdVckjYyqmJbcm5UWpTRVggJft1IFJwg4ba+Led6zzSbqrjfCD/Ugnsj5B2yMcX7QtOWIdTftd26MjhY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(261102123227099003)(22082099003)(56012099006)(4143699003)(261026121527099003)(11063799006)(261022075727099003)(261022105027099003)(261021121427099003)(261022113327099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2lrRWE5bWN2ZUZrQjFjbFF2TzZFOVIwMFQ1a1FzTHpaN3U0MkNCQWZUbDJO?=
 =?utf-8?B?anJBWXhUb1RjY0dzSFNva2FNcEJlc3BQQ2RESk9KQnRPSVFCREk2OWFMR0Nk?=
 =?utf-8?B?SDcxR3lSUFU4YXZPYWhsMUpkWTc5djFwKzBmTkZuWE84d016RVhYdVVJZjNi?=
 =?utf-8?B?TmxUT2VEMU1IK05BUEJoc1BJVzZUd2k2K0Z2Q1V4OFBBekVyRTJZNXNSSWt1?=
 =?utf-8?B?UUgwS0xhZVFvdkp5amVRT3dFOFRDaS9Na296SHF4WXVESEVmT2pQQWlvdUZM?=
 =?utf-8?B?MnBBcmNmTjU0eHdnNFRtRHQyc1lab1ZWbVVCc1NnVG4rY1ZkN3hqNHZuMXZI?=
 =?utf-8?B?N24yWktHT1BiNWFVNi8zTnh3U0EzdkJQSk1ETHhqSUkvaVdKTnBpMWxBOWJn?=
 =?utf-8?B?bFY4TEV2RHRqbXJtbThhZVE0M2szMEZEaXlWdHVGNUFSZTJkbHA4c1JuejlR?=
 =?utf-8?B?ZVZlc1dFYVcvVG8xamcwMWNLUEptWWwwL0VZaXlVVjNmM0VkenNxalJRQmxj?=
 =?utf-8?B?MEVjc2lkYzNTeTI5RG1xVWorUlBCQm9KNEE0OWdnbUFlb0NFRWVuekVLVHN0?=
 =?utf-8?B?UTdWUTBuWjFDSEVFaXU0N1RDMlhMSWJuOEZwZ1FRR0NzQ25OOTROSzloMHFH?=
 =?utf-8?B?T0ZzSlQweFBOZVNGWW14VUhtczlHMnNKY1I2T1RhdFZnbEVPRmtTSFVBSWNH?=
 =?utf-8?B?T0NGNWZieldnM2ZzSW9XTE5xQXlLb0ZhV0pTQWVxN1lZWkVJT1RjbTZ6cC9Z?=
 =?utf-8?B?SWhBR0I5dHI5bWNhcXRYYnQyZ0xSOVpsUDVVYjJHQVBQb2NGZ1MxSjlVMFVp?=
 =?utf-8?B?Tzg3Skd5ZlYzc010a2FlWW9PU1hZbUt3NU01UWVpVlJlTnZJUHNnS1lHcGlM?=
 =?utf-8?B?SXZjVnNMMmx3UGVDMWZIYzgwN1hWZDhmNnhQS1VMdStSbklSeEZ1aWYrS2dl?=
 =?utf-8?B?bFZIRnR3eVBvNTY5NEtiN1BrQXJiYlMrczl4RmpZUUhMVS9RZzRkRlVVNE9B?=
 =?utf-8?B?UG1SRy9HNTdJT040SDJjMHVkWHJUU3lHSlNQRnI5ek9lNHUreldiRlVGZHR3?=
 =?utf-8?B?WVN5RmZ5WjhRUHY4WTNvT2lWb09BZVlTaWxvRHVTUVdvNGZwdEhaWWNnZVhB?=
 =?utf-8?B?Y0ZxY0Z0V3VXekNzL1p1cEtuRkozY2pBWXpJNXU2Y2I5Uy85MzM5Tk5FeWVt?=
 =?utf-8?B?UEVoZzdndkpsVHYzOExQM2l6aUViZmRDbXcrRlZyMDFkbDYyOGlrZUppRElu?=
 =?utf-8?B?RXlvbWF2dUU1OVBLZmw2SGcwUURmMnhpa2FmQTFuYlVlSW9UNUl6QVlxUjNz?=
 =?utf-8?B?eHEyOFJ0MEpBYkg4TWNZMFFuRmh4RXhkVTlBYUFFSkpPSGVaZHF6czNDekZS?=
 =?utf-8?B?RitlS2cza3YrQ29aU1ZiYVZoeEM5TkxMTE5VZDRJbGpqU3B2eXFvUzl1MmRH?=
 =?utf-8?B?QU90TEV0ak1JVTR1L253U21WVC91eWNrd2JJMVJnMXFaMXo5YUhXU0tUU2Z2?=
 =?utf-8?B?RVJsLzc3enNKUHJyc011Z3ZzQ2NmNG1QTW5ZSnBUUFBOdFMwWm0zR0FDa0Iv?=
 =?utf-8?B?bVB1NS9RaEdBY0FRWk4vTkpvbGJrUjF2UFhJbEZ6Q3FGdTBFUzhJTERXSzVV?=
 =?utf-8?B?dVd2MllXVE5qa24vbDRzdFVmaFBlblV0bnlPa3I1OWxISzRuN2tjaGh6cHQz?=
 =?utf-8?B?dkJpa2M3VnQ1SkE1emVUcEhOaUs5ak9wamRGMHMzSXBMaVJ0eTRTUGprUVVJ?=
 =?utf-8?B?cHY1RDRZRjZMVE5VN1I0WUVuSFJBRDlrYXBFejdOb3NmWFYzWDI5MllrOXRk?=
 =?utf-8?B?S0p6cVVXSERkaFoxK2Jvbnp4V2w4K0JjbU5SZVF3a2IyZnZZU2EzU25DZjA3?=
 =?utf-8?B?N0hDaWUxZWdPdjFXSnEvelo0RFFSL1ZsMS9ldmVuQ0RlcWlkSzBjWXo2WGFj?=
 =?utf-8?B?NlF5eXlWNWNNK0hnN2RjY3VtMCtXMjM0UUZMZUtWV1hkcWpvZTZnTzZQNFpm?=
 =?utf-8?B?L3pteVJjUzJYQmlRMnBBSHlzemtqcnhGaEMzWHo0dDBOMGVRanZsOWhsZCtO?=
 =?utf-8?B?U1k5M3ZiR2lXbGFSSWFIa1JqN1pTNFR3YWdTd1lOYm1tWCt1bmpIT3QyZ1No?=
 =?utf-8?B?OXhrSUhqM1NGMXdiNEVpOFo5c1pFUDBiV2VvK2t3NTBSOGE4SWZSbFBxcDNz?=
 =?utf-8?B?cEVEY2NQT0xHTEloMGhGK25TWi9IOUdGSDJmN2hPc3lmcWVRd2NJWlhiNVV4?=
 =?utf-8?B?SzhkeVhaZGlUOEkycHhLdW9nQ0N3WGRwRzdCQXhxMUNOK245cGxYSVk3S3RZ?=
 =?utf-8?B?UkJIQTdLWXdxajlOWGxpa3ZLK3FqZVNqRzQ4ZWFETmo1T3JjaWNJUT09?=
X-Exchange-RoutingPolicyChecked: XAatw2UM6AUQxPFCvNzPLrHnZfo57If9mTNC+V+WQ0OWE4/59LLGCZ3x/22K++LpTrfkVgrE/9KkcStJOwJKOkr3JYsUljAbawVFk7gxTWGMX4+B8vOh0yIjnU8VoOxClCJXrek1SA8uEfzdtgLPHgEaVuXEmwqE96LihYwOP9e/enHytMkX3GFVk+G7ShEKAPo8vDKtF6+clZ7Tv9BgLjB3FLtxY72n3+UBtvkPVpdnXt8BIpHj8A8NQBgg3hjHq70zzmcpWpGomndweRBFpVvj8munMprFtKCtGenwraTAW5kh86/NcifnOyJ8fsPzeQ1kaCRRorrX6KxBjm87SQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c606c90e-1394-4198-f343-08df397a7ea8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 07:17:18.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aP7At7YegapxmoayTFp1SH02655nT7VXTqXuQObF18jD/mbk2IWafZ0rd0tXXQwiEzhjaRmPCIYyG1nLuRpIV3vZMdVB+dZHajcs2lh5Vmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4621
X-OriginatorOrg: intel.com

On 11/2/2026 5:04 PM, Linkui Xiao wrote:
> Hi Jake,
> 
> Thank you for applying the patch and for the review.
> 
> On 2026/11/3 06:15, Jacob Keller wrote:
>> On 10/28/2026 2:04 AM, Linkui Xiao wrote:
>>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>>
>>> e1000e_config_hwtstamp() stores the requested configuration in
>>> adapter->hwtstamp_config right after the rx filter has been
>>> translated, but the two register writes that follow are verified by
>>> reading the registers back and each of them can fail with -EAGAIN.
>>>
>>> When one of them does, the driver is left holding a configuration the
>>> hardware never accepted:
>>>
>>>   - e1000e_hwtstamp_get() hands it back to user space, so an
>>>     application that reads the configuration back is told that
>>>     hardware time stamping is in effect while it is not;
>>>
>>>   - e1000e_systim_reset() re-applies it after every reset, including
>>>     the ones the watchdog triggers, and keeps failing;
>>>
>>>   - e1000_watchdog() starts polling TSYNCRXCTL_VALID for the cached rx
>>>     filter, and e1000_xmit_frame() still parks skbs that ask for a Tx
>>>     time stamp because it only looks at FLAG_HAS_HW_TIMESTAMP, so they
>>>     are eventually dropped by e1000e_tx_hwtstamp_work() with a
>>>     "clearing Tx timestamp hang" warning.
>>>
>>> Cache the configuration only once both registers have been verified,
>>> so that adapter->hwtstamp_config always describes what the hardware
>>> is programmed with.
>>>
>>
>> Any idea why this got marked as patch 2 out of 5? This doesn't appear on
>> either netdev or iwl with any other patches.
> Regarding your question about the "2/5" marking: it was an oversight on
> my end. I generated this fix from a local branch that contained other
> commits, and `git format-patch` automatically added the series
> numbering. The patch is indeed a standalone fix and was not intended to
> be part of a series posted elsewhere.
> 
> I'll make sure to use a proper invocation for single patches going forward.
> 
> Thanks again for your time and for taking this fix into the Intel Wired
> LAN tree.
> 
> Best regards,
> Linkui

Thanks for clarifying! I mostly wanted to make sure it wasn't some issue
with mails not hitting the list (spam or other issues), and potential
fixes being missed.

The numbering will get fixed and merged with other patches once our
review process completes and Tony finds space for submission to netdev.
That may take a bit.

Thanks,
Jake

