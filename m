Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B936B35202B
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939989; cv=fail; b=kjrBrhW7/OSApOYGLpyJwfiXOCZENp+Wy1A+EEuE8AeTG2MyBLfTzHo6L+H3NJMAc1eI5UHmkN9IxQJLd3e0h2ZcMxFEMZUMldpFQFEc64Tn8B+9OH5XGH/0UNuKjQOFv6V+czjZY7nV7DWncCeZTDp/y21XhGr3NEDPqSy2nmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939989; c=relaxed/simple;
	bh=nWgiXepSDZ/2MobXJbvUsMZuZz8tfkTVa7tcZ+IwFlM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aDYOTDXi5AsHJKk6cK3nzSr0BhnjJTRwFr6PbPXgplH83QSH7jdHs0LlIiWy5R7N6dt0pRjSr05LSx7X2HmZ5HqUUGjU1gO9GZ9xW+EPabAhIvLjdsRgI0CP2woa1zlL3ZZtvUu+YO9/MQQHs3pfnTlIp09/zJX2tW4fJrVJa20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGj0Qu12; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGj0Qu12"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780939986; x=1812475986;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nWgiXepSDZ/2MobXJbvUsMZuZz8tfkTVa7tcZ+IwFlM=;
  b=hGj0Qu12RKliclpn8EdrSMv+e8KOtcU1sbsuXanDJ8Xrl5RNoTlV2xR1
   nZmlXIDX+tkUmjkaCBYSKgFzmdFV4rczrov78ls/+eizN+pdmwb/kCZiM
   IQIVNRdhYcVRoaKAbRLzZ8PII+WPzylS+sTwGD6xW+7szxYXUoDvnOyeO
   6slUWpJo3aOg8b8LbfrMNPldbV1bV6lH3MGYNOhMYQWi04SJ3SbfIzFFN
   9UzlXWEMuXWnQcsjm8cXzRA3RSH+IcHcZm/HkHfB9sm8wCH26HTWfiGlv
   K84p+ntdWyNCU4zjzAAOzcc+cfPZB3sB3sdSRw2sNJK/L+ljZ7PL9AWMe
   Q==;
X-CSE-ConnectionGUID: EZIaHO4OSeSoo3BzyJSeWA==
X-CSE-MsgGUID: xotkd2ofRL+I9xNRGC91tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="92252993"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="92252993"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 10:33:05 -0700
X-CSE-ConnectionGUID: zAWh2Vp4Tlik4yRYypg1XA==
X-CSE-MsgGUID: 2UtJX4aJSfuex5BKS0jYaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="244765890"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 10:31:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 10:31:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 10:31:27 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 10:31:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijRw2+uKiam6BzjjQRmxZD1SvIg1I+Kt7/92jnmN0mzQUHkBXPEllrABwnFud0dob/5Q+9JNiJRTFOOQAu6IBYGZjisVgd6L0gPDkl5qJv3BHgsntl++FdwUz0Wm9H4kAjyKTtN0o970Q/s7yZA1IWdXrWa6HlKQFsUOtBHpQYOwk/WBpn4jDYh5sPMSiSdjd6XADKyh6N7brKRpiSiThLidE2LJDVJdvFYbkaqbfHoEjU6OhIOzaabbT2CykFKAS987DYuwAYuEQn4nw3EuShjwwdfmPp4NJP9W8JodVbeIRzUtAM0lEqOT9QpDtsywR0k4QzsMDAcn8uGKAajd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47Vnx4balmnQlrx6GbmfIJCMp8L6a1zvDZLrttbyAG8=;
 b=XnmMycqm0odsldbEVG2W724WERJZ1Euo9VOoRQXpMwgpgf6JveeuHzFOFt1fxLA/GY8hz08JnWLzEe8CMP5cE69DXwozcIoQL6A1CrhnqkB9mwGb5kZMcaDqj/kfDgv/qFkHrGoZRzGlrWd+/iCYzblVkM/2lchYu0hXt/BLnsC0ONOIpG/CZ2fioipAsXmDffLpNpgbSXkK7ufyGfPWhgDmXi+Yrl81FsNXokdDVAD9SZoo+YypgoxV3NPP9g18W0QSxi4hP3nWJLuPIdS0H2IhO+WlVTQ6mOnHmRhA7ZO5+rQvq+2DcBTGx2XOFgy+4+hIbrhCo702G1Ygw7M4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF46B98A11D.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::23) by PH0PR11MB4951.namprd11.prod.outlook.com
 (2603:10b6:510:43::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 17:31:23 +0000
Received: from DS4PPF46B98A11D.namprd11.prod.outlook.com
 ([fe80::5a0d:e357:ce45:3963]) by DS4PPF46B98A11D.namprd11.prod.outlook.com
 ([fe80::5a0d:e357:ce45:3963%8]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 17:31:23 +0000
Message-ID: <3d818c09-0da1-4f0a-b43f-5e61cc604bf4@intel.com>
Date: Mon, 8 Jun 2026 10:31:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/xe: Add compact-PT and addr mask handling for page
 reclaim
To: Brian Nguyen <brian3.nguyen@intel.com>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>, Matthew Auld <matthew.auld@intel.com>
References: <20260605224257.2194194-2-brian3.nguyen@intel.com>
Content-Language: en-US
From: "Bai, Zongyao" <zongyao.bai@intel.com>
In-Reply-To: <20260605224257.2194194-2-brian3.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:a03:333::25) To DS4PPF46B98A11D.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF46B98A11D:EE_|PH0PR11MB4951:EE_
X-MS-Office365-Filtering-Correlation-Id: 35591c94-efdd-4188-9597-08dec583c2ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: a6VDDF/0Mykt1vk7IKFUHfurUOyFNXTb67yg+YGU5d7imelPOyh+IlLzRbRP8jf7hbpViOeEk7cXQtHi4SLMBJ2GceLYrhWwdm7DLlhzDCiQfuGxBpwasfxvpX9yDx5D8th1HVFgzMKjCxg4/DFm4QqIc0agK8Ri8LLM5+CnZGwIC28BTjcbwyBJfudJdAzCiVGUaN16I3qZycdN1TRagSo69sBawXUZfxJa/CX798fGkl0b82dsl4TtLupw108ncxhe/rPIAAt1Gy9dDWwRmxUHo1oHs18wkwqyQpP/WHsqrLuTFL74A4s0PmBpKYRXjc7muwqDdijSS6//Z71B0I6GH3exx9RoSDYBVK3pN/nADHavQCLCKHGzLa+ETkmPb2TvAvI6uOWFJ1X1t7kTCw6ph5Ca8Jq4H1jEhIYmmtjgoCtbOLbljIPBzhHzEkw3LZ+DvMbVrpOdIWAHfi3hoox31ut3bpq13QIEQyicDrEkWRceQivLnRaUwgCTWUGvMvj3HicP9Ilv1ur/83qK8tX0W+DNHT2b1PiUEL46ZoGWL51/ZnV0bdMfg3iG/8Pz4lhEOremCOrUWOb1vabao2Ak0hnX92zrnrPHHyFI/ImFMX9tyoWD3XnJ3E+V5VP4PUv0dRhxPyTK+22vCiSA/qCbXtx/Klol0nRDZq1eqxlfe8KRNChMah02o/hPrZr+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF46B98A11D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzVzREpOMDY2U3VSR2NDUGhJbEhXNytMbUZYVGRLVXoyYWFKd01KQXF1aVFW?=
 =?utf-8?B?UndpL1FRQ3hKMkVCcDNvN0lzdHAxZXZ3MnBvQTFCSXFrOWZWT2tZRk9Vb3Nq?=
 =?utf-8?B?R2ttOGxpT1Ixbzc3VVJGUGdyRU5sM0hNTGQ2Q0VZZHNabW1UWE5NRHU4cUZH?=
 =?utf-8?B?WGVRMnQ3RkNNYjNPeUVlb1E4dlJtR2NEdXl2WEl2eXBLM0lQVVVyMWtzTGVu?=
 =?utf-8?B?b2ZGa0hMZVMvSlJjWkMrenBEZGc0SUtMUndYTDZoY1Z1S0R5N0pQM3lySG10?=
 =?utf-8?B?bXBibjAwdXlTK1dsRnlmOFBydFErNjFaK1hNQzlyN0dPRE5paTQyOSsxRHV2?=
 =?utf-8?B?SjJERDYwbk8zd1NjNDJzWnVjYVJNMlg2YU55ZmlZWjQwZlBqMm04NytUekpu?=
 =?utf-8?B?NGVVRjlrQnJnZWNZY3hhcmZONFFiQWxzbk1ZUHNEbTZvNHZCdENlSUNVZmY5?=
 =?utf-8?B?WlRuQlRTaHd1SzNJWVMrNU5KQ2JGYjc2ejhldVdGZ2FwTGdCMHlqYUY5aklQ?=
 =?utf-8?B?aUh0ZW9NdHprVWU2OUdmWHVwMmRzSTh0cmh5ZG01NWpFTzlUTDRXelI0SHc1?=
 =?utf-8?B?ZXdYT1FyQjhPVmlNY0FwYjRraGtmOTdMOWdSTnBBZ3pSODVzRDNaRUY5U1V3?=
 =?utf-8?B?NEdYeHhWYjZnQXQ0M1orb01KanZLMWRjQVBnY1JCLzU4VUVSaFNuUC9yb3o5?=
 =?utf-8?B?Rk5naDl6TlpPUE54NVgyRjF1NUZ2T0E3RkRmeDRTazFtWkw1cFV0cUQvZ3VY?=
 =?utf-8?B?UnVHTnkxWUswUE82cVVCT1lramJBdUVpRHdiODJNUWxpT3NadzlNTXdRRGdr?=
 =?utf-8?B?c2FvT3VINm5qNTRsNTQ2bkVwekVNQ1dkQzQ3cFhRZWRSblNBME5nZVRxdmdL?=
 =?utf-8?B?cHVkUTlDVnFMZjdQRlN3UCtpQ0ZJZjJ2UEVySGF5RVp4WE9WVXRaNDBKVGpU?=
 =?utf-8?B?Z09VTTZQWVhGU1h4S3F2djYrc3JiV2xUV1ZrQ2RYT04zNUwwK0pIMURDeFUw?=
 =?utf-8?B?cnZKcXpMT0JqdXh1Sm55dkNDbXIrRWRsUWxuYmFCSXJLQlo3d21DVmY4UHF4?=
 =?utf-8?B?NWpxU3crS2lUZUpTa3Z4NC80TTN6d1p3OVYyai93RkloUFNYMThYMmtpby9y?=
 =?utf-8?B?Z0hFemo0WTFDOUZqM2VLR0lyb3B6bXpVdE1FZTdDM1g2ZXZwMzhFTmZvTGpj?=
 =?utf-8?B?a2l6UUVSV29yK3BBMElpSlhjdXMxVXNpN3RIMkpmUitpeDIwQ0FsamswYlI2?=
 =?utf-8?B?MFA0alp5LzhOcURBTHlLcmVmM3M1ZmkwNTZFdlBWeWlEUk5UMXRJMmd0RFhs?=
 =?utf-8?B?MlppYTl0a2t0eEZhV0FBUDI1SzFHYTliZUYxQ3VnaWpWS2x0NkdnYnY0dTRs?=
 =?utf-8?B?OHNJSWtwOVR4cm5OcVBpclNlYlQvWlBMa0pWcklPc3R4TVlPQm16aURxYk51?=
 =?utf-8?B?VlFETTJYU1Y4OUlkeW5nNzM5U2VEd2RSc3hyTjU2OGxnR1djSWN3eGVoeHJx?=
 =?utf-8?B?Nm5OSGJHY1RjWXRqRUxHNEZmM2htOEVJOXVMYVZyUjhyT3NQN2QrWFdDcnNE?=
 =?utf-8?B?Ump0SEhOVWZvbk9zUEZ0TFN5UGlwZFJ6cEg2U1ZXTmM5UVM2THZNT2tpU2tp?=
 =?utf-8?B?eE11L3g3KytQM1c1aXlBenltWTZXbzFsbG1VQzFVSFZYVTNrTHRFa1hmaWhX?=
 =?utf-8?B?WHJpRWF5TWJxL0t4UkFDTWdQK1FqN3MyZjBYSHhkakVaNllLNlBHUGR4Z2hF?=
 =?utf-8?B?V2RUcGo1TkhqRGtNcVFyQVRtQUhGLzFmNlRCa2RQQVhhWEwzVVZRVnRQWElD?=
 =?utf-8?B?TmxjVXZEaXdmTGFBUGZZTUVIMXV0UDBzYjdPZWZqcVVKNDg2U1ZEVXZJeC9V?=
 =?utf-8?B?K0VyMWVCQk96clBxZFVvK2tSQklaZzdYbjBUek9LVFNJYThqOFVydzZRSmJR?=
 =?utf-8?B?cGM3Nit3Q0d3SGJobVpzZ3hWSXN3akhiVnY0ZktpeURyYnkvSkkydDFMdXk1?=
 =?utf-8?B?TFNpVUZJcm5uTG9FTzJUcDA4OFdBb0k0ajg2TDgxNHg1dDZvUHF1emJXSzJE?=
 =?utf-8?B?OFBNcnBJZ0pOM29NdVlrVGozeWhxcVBUc2tqNTFadzRZNzdQWm91d2FVVlNy?=
 =?utf-8?B?YnV0RERFTFhoMzROd2pKVmsyQVBFR2hRL09FM08yaUJMVHExa01VVjNLSEhK?=
 =?utf-8?B?N1VBVDhRQ2d4eHJ6SmgwVXI3VzIwSGl1Q1pncFdxZGJUMFBpSVpydG8zb1ZT?=
 =?utf-8?B?Z0ZwZFdGbHdsYytNUFJJV3l2U3JXZS91Yk5BOGVZWnFhQzh4cTRzb2crdUdV?=
 =?utf-8?B?d2VSNk11OXVGbUZsZ0RtWm94RVRMM3NPWS9UUmFjYzJaMGhlNndtdz09?=
X-Exchange-RoutingPolicyChecked: odJLHXsYMFfHd7kkFYBtKgXsIsy+Mkp8YDbg1kloxojmiKQgeOdZ7txvXOrVEW8GOGnlehHtLHv2frsexi59C4pTFAhYSEO7XncT8djvntLRSn83Nd3er8n9vFbFm1twAwdKj2j/X4XUn3lAyv+e23zDldpsfZigE5SyeSM9MQjcweDUot2kRA1AqVhpaQ3A5Dn3KFiPetibyzyh7rTHRr8ax5ywIBgQbb6PMach9boUzz29RuBxjSy22cLq7kp/4bMqsP6L39aVLGPERZvRw0PwkOAtyQW1NDnj7iEHHCfAxuCC7bs8RO9JNHPGBGpddcxzbHPvJgZwKwEaj6tSTA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 35591c94-efdd-4188-9597-08dec583c2ce
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF46B98A11D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 17:31:23.4666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krSpQKM4KabjBMDy1Lu9Qiv3anxrrJ5ni7VuLBjc7g/pbK6Md5Gd1XQiYuaSNaZeZH2TcYR75/YOHIdF0e6RYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4951
X-OriginatorOrg: intel.com

Hi Brain,

LGTM

Reviewed-by: Zongyao Bai <zongyao.bai@intel.com>


On 6/5/2026 3:42 PM, Brian Nguyen wrote:
> Current implementation of generate_reclaim_entry() overlooks some
> differences between the different page implementations: address masking
> and compact 64K page handling.
>
> Address masking of each leaf varies depending on the leaf entry size.
> generate_reclaim_entry() is using XE_PTE_ADDR_MASK [51:12] for all leaf
> entries. For 2MB PTEs, bit 12 (PAT) is part of the flags so the old mask
> corrupts the physical address extraction.
>
> 64K pages can be represented as PS64 and a compact PT, which the latter
> was not handled. Compact pages aren't walked by the unbind walker, so we
> separately walk through the compact PT to ensure none of the leaf 64K
> PTEs are dropped. Previously, compact PT were causing an abort since it
> was considered covered and not descended into.
>
> v2:
>   - Update 64K entry/unbind walker for 64K compact PT handling. (Matthew)
>   - Rework calculations of reclamation and address mask size.
>   - Add new func abstracting the error handling before generating the
>     reclaim entry.
>
> v3:
>   - Report finer addr granularity in abort debug print for compact.
>     (Zongyao)
>   - Add comments for ADDR_MASK usage. (Zongyao)
>   - Drop existing phys_addr asserts, the new XE_PAGE_ADDR_MASK clears
>     bits checked, so redundant asserts. (Sashiko)
>   - WARN_ON to verify compact pt and edge pt won't be possible.
>
> Fixes: b912138df299 ("drm/xe: Create page reclaim list on unbind")
> Assisted-by: Sashiko-Review:gemini-3.1-pro-preview
> Cc: stable@vger.kernel.org
> Cc: Matthew Auld <matthew.auld@intel.com>
> Suggested-by: Zongyao Bai <zongyao.bai@intel.com>
> Signed-off-by: Brian Nguyen <brian3.nguyen@intel.com>
> ---
>   drivers/gpu/drm/xe/regs/xe_gtt_defs.h |   6 +-
>   drivers/gpu/drm/xe/xe_pt.c            | 131 +++++++++++++++-----------
>   2 files changed, 82 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/regs/xe_gtt_defs.h b/drivers/gpu/drm/xe/regs/xe_gtt_defs.h
> index 4d83461e538b..d6bc19ef277b 100644
> --- a/drivers/gpu/drm/xe/regs/xe_gtt_defs.h
> +++ b/drivers/gpu/drm/xe/regs/xe_gtt_defs.h
> @@ -9,7 +9,11 @@
>   #define XELPG_GGTT_PTE_PAT0	BIT_ULL(52)
>   #define XELPG_GGTT_PTE_PAT1	BIT_ULL(53)
>   
> -#define XE_PTE_ADDR_MASK	GENMASK_ULL(51, 12)
> +/*
> + * Mask for PTE address bits [51:shift].
> + * shift is the lower address boundary of page.
> + */
> +#define XE_PAGE_ADDR_MASK(shift)	GENMASK_ULL(51, (shift))
>   #define GGTT_PTE_VFID		GENMASK_ULL(11, 2)
>   
>   #define GUC_GGTT_TOP		0xFEE00000
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 2669ff5ee747..18a98667c0e6 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -1602,23 +1602,21 @@ static bool xe_pt_check_kill(u64 addr, u64 next, unsigned int level,
>   	return false;
>   }
>   
> -/* page_size = 2^(reclamation_size + XE_PTE_SHIFT) */
> -#define COMPUTE_RECLAIM_ADDRESS_MASK(page_size)				\
> -({									\
> -	BUILD_BUG_ON(!__builtin_constant_p(page_size));			\
> -	ilog2(page_size) - XE_PTE_SHIFT;				\
> -})
> -
>   static int generate_reclaim_entry(struct xe_tile *tile,
>   				  struct xe_page_reclaim_list *prl,
>   				  u64 pte, struct xe_pt *xe_child)
>   {
>   	struct xe_gt *gt = tile->primary_gt;
>   	struct xe_guc_page_reclaim_entry *reclaim_entries = prl->entries;
> -	u64 phys_addr = pte & XE_PTE_ADDR_MASK;
> +	bool is_2m = xe_child->level == 1 && (pte & XE_PDE_PS_2M);
> +	bool is_64k = xe_child->level == 0 && ((pte & XE_PTE_PS64) || xe_child->is_compact);
> +	u32 page_shift = is_2m ? ilog2(SZ_2M) : is_64k ? ilog2(SZ_64K) : ilog2(SZ_4K);
> +	/* Physical address bits start at page shift: 2M->[51:21], 64K->[51:16], 4K->[51:12] */
> +	u64 phys_addr = pte & XE_PAGE_ADDR_MASK(page_shift);
> +	/* Page address is relative to 4K page regardless of entry level */
>   	u64 phys_page = phys_addr >> XE_PTE_SHIFT;
>   	int num_entries = prl->num_entries;
> -	u32 reclamation_size;
> +	u32 reclamation_size = page_shift - XE_PTE_SHIFT;
>   
>   	xe_tile_assert(tile, xe_child->level <= MAX_HUGEPTE_LEVEL);
>   	xe_tile_assert(tile, reclaim_entries);
> @@ -1633,18 +1631,12 @@ static int generate_reclaim_entry(struct xe_tile *tile,
>   	 * Page size is computed as 2^(reclamation_size + XE_PTE_SHIFT) bytes.
>   	 * Only 4K, 64K (level 0), and 2M pages are supported by hardware for page reclaim
>   	 */
> -	if (xe_child->level == 0 && !(pte & XE_PTE_PS64)) {
> -		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_4K_ENTRY_COUNT, 1);
> -		reclamation_size = COMPUTE_RECLAIM_ADDRESS_MASK(SZ_4K);  /* reclamation_size = 0 */
> -		xe_tile_assert(tile, phys_addr % SZ_4K == 0);
> -	} else if (xe_child->level == 0) {
> -		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_64K_ENTRY_COUNT, 1);
> -		reclamation_size = COMPUTE_RECLAIM_ADDRESS_MASK(SZ_64K); /* reclamation_size = 4 */
> -		xe_tile_assert(tile, phys_addr % SZ_64K == 0);
> -	} else if (xe_child->level == 1 && pte & XE_PDE_PS_2M) {
> +	if (is_2m) {
>   		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_2M_ENTRY_COUNT, 1);
> -		reclamation_size = COMPUTE_RECLAIM_ADDRESS_MASK(SZ_2M);  /* reclamation_size = 9 */
> -		xe_tile_assert(tile, phys_addr % SZ_2M == 0);
> +	} else if (is_64k) {
> +		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_64K_ENTRY_COUNT, 1);
> +	} else if (xe_child->level == 0) {
> +		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_4K_ENTRY_COUNT, 1);
>   	} else {
>   		xe_page_reclaim_list_abort(tile->primary_gt, prl,
>   					   "unsupported PTE level=%u pte=%#llx",
> @@ -1665,6 +1657,48 @@ static int generate_reclaim_entry(struct xe_tile *tile,
>   	return 0;
>   }
>   
> +static int add_pte_to_prl(struct xe_tile *tile, struct xe_page_reclaim_list *prl,
> +			  struct xe_pt *xe_child, u64 pte, u64 addr)
> +{
> +	/*
> +	 * In rare scenarios, pte may not be written yet due to racy conditions.
> +	 * In such cases, invalidate the PRL and fallback to full PPC invalidation.
> +	 */
> +	if (!pte) {
> +		xe_page_reclaim_list_abort(tile->primary_gt, prl,
> +					   "found zero pte at addr=%#llx", addr);
> +		return -EINVAL;
> +	}
> +
> +	/* Ensure it is a defined page */
> +	xe_tile_assert(tile, xe_child->level == 0 ||
> +		       (pte & (XE_PDE_PS_2M | XE_PDPE_PS_1G)));
> +
> +	/* Account for NULL terminated entry on end (-1) */
> +	if (prl->num_entries >= XE_PAGE_RECLAIM_MAX_ENTRIES - 1) {
> +		xe_page_reclaim_list_abort(tile->primary_gt, prl,
> +					   "overflow while adding pte=%#llx", pte);
> +		return -ENOSPC;
> +	}
> +
> +	return generate_reclaim_entry(tile, prl, pte, xe_child);
> +}
> +
> +static bool add_compact_pt_prl(struct xe_tile *tile, struct xe_page_reclaim_list *prl,
> +			       struct xe_device *xe, struct xe_pt *compact_pt, u64 addr)
> +{
> +	struct iosys_map *map = &compact_pt->bo->vmap;
> +
> +	for (pgoff_t i = 0; i < SZ_2M / SZ_64K && xe_page_reclaim_list_valid(prl); i++) {
> +		u64 pte = xe_map_rd(xe, map, i * sizeof(u64), u64);
> +
> +		if (add_pte_to_prl(tile, prl, compact_pt, pte, addr + i * SZ_64K))
> +			break;
> +	}
> +
> +	return xe_page_reclaim_list_valid(prl);
> +}
> +
>   static int xe_pt_stage_unbind_entry(struct xe_ptw *parent, pgoff_t offset,
>   				    unsigned int level, u64 addr, u64 next,
>   				    struct xe_ptw **child,
> @@ -1674,21 +1708,22 @@ static int xe_pt_stage_unbind_entry(struct xe_ptw *parent, pgoff_t offset,
>   	struct xe_pt *xe_child = container_of(*child, typeof(*xe_child), base);
>   	struct xe_pt_stage_unbind_walk *xe_walk =
>   		container_of(walk, typeof(*xe_walk), base);
> -	struct xe_device *xe = tile_to_xe(xe_walk->tile);
> +	struct xe_page_reclaim_list *prl = xe_walk->prl;
> +	struct xe_tile *tile = xe_walk->tile;
> +	struct xe_device *xe = tile_to_xe(tile);
>   	pgoff_t first = xe_pt_offset(addr, xe_child->level, walk);
>   	bool killed;
>   
>   	XE_WARN_ON(!*child);
>   	XE_WARN_ON(!level);
>   	/* Check for leaf node */
> -	if (xe_walk->prl && xe_page_reclaim_list_valid(xe_walk->prl) &&
> +	if (prl && xe_page_reclaim_list_valid(prl) &&
>   	    xe_child->level <= MAX_HUGEPTE_LEVEL) {
>   		struct iosys_map *leaf_map = &xe_child->bo->vmap;
>   		pgoff_t count = xe_pt_num_entries(addr, next, xe_child->level, walk);
>   
>   		for (pgoff_t i = 0; i < count; i++) {
>   			u64 pte;
> -			int ret;
>   
>   			/*
>   			 * If not a leaf pt, skip unless non-leaf pt is interleaved between
> @@ -1698,10 +1733,23 @@ static int xe_pt_stage_unbind_entry(struct xe_ptw *parent, pgoff_t offset,
>   				u64 pt_size = 1ULL << walk->shifts[xe_child->level];
>   				bool edge_pt = (i == 0 && !IS_ALIGNED(addr, pt_size)) ||
>   					       (i == count - 1 && !IS_ALIGNED(next, pt_size));
> +				struct xe_pt *child_pt =
> +					container_of(xe_child->base.children[first + i],
> +						     struct xe_pt, base);
>   
> -				if (!edge_pt) {
> -					xe_page_reclaim_list_abort(xe_walk->tile->primary_gt,
> -								   xe_walk->prl,
> +				/* Compact PTs always fill a full 2M-aligned slot, never an edge. */
> +				XE_WARN_ON(child_pt->is_compact && edge_pt);
> +				if (edge_pt)
> +					continue;
> +
> +				/* Walker never descends into compact PTs, descend now */
> +				if (child_pt->is_compact) {
> +					if (!add_compact_pt_prl(tile, prl, xe, child_pt,
> +								addr + (u64)i * pt_size))
> +						break;
> +				} else {
> +					xe_page_reclaim_list_abort(tile->primary_gt,
> +								   prl,
>   								   "PT is skipped by walk at level=%u offset=%lu",
>   								   xe_child->level, first + i);
>   					break;
> @@ -1711,37 +1759,12 @@ static int xe_pt_stage_unbind_entry(struct xe_ptw *parent, pgoff_t offset,
>   
>   			pte = xe_map_rd(xe, leaf_map, (first + i) * sizeof(u64), u64);
>   
> -			/*
> -			 * In rare scenarios, pte may not be written yet due to racy conditions.
> -			 * In such cases, invalidate the PRL and fallback to full PPC invalidation.
> -			 */
> -			if (!pte) {
> -				xe_page_reclaim_list_abort(xe_walk->tile->primary_gt, xe_walk->prl,
> -							   "found zero pte at addr=%#llx", addr);
> +			if (add_pte_to_prl(tile, prl, xe_child, pte, addr))
>   				break;
> -			}
> -
> -			/* Ensure it is a defined page */
> -			xe_tile_assert(xe_walk->tile, xe_child->level == 0 ||
> -				       (pte & (XE_PDE_PS_2M | XE_PDPE_PS_1G)));
>   
>   			/* An entry should be added for 64KB but contigious 4K have XE_PTE_PS64 */
>   			if (pte & XE_PTE_PS64)
>   				i += 15; /* Skip other 15 consecutive 4K pages in the 64K page */
> -
> -			/* Account for NULL terminated entry on end (-1) */
> -			if (xe_walk->prl->num_entries < XE_PAGE_RECLAIM_MAX_ENTRIES - 1) {
> -				ret = generate_reclaim_entry(xe_walk->tile, xe_walk->prl,
> -							     pte, xe_child);
> -				if (ret)
> -					break;
> -			} else {
> -				/* overflow, mark as invalid */
> -				xe_page_reclaim_list_abort(xe_walk->tile->primary_gt, xe_walk->prl,
> -							   "overflow while adding pte=%#llx",
> -							   pte);
> -				break;
> -			}
>   		}
>   	}
>   
> @@ -1751,7 +1774,7 @@ static int xe_pt_stage_unbind_entry(struct xe_ptw *parent, pgoff_t offset,
>   	 * Verify if any PTE are potentially dropped at non-leaf levels, either from being
>   	 * killed or the page walk covers the region.
>   	 */
> -	if (xe_walk->prl && xe_page_reclaim_list_valid(xe_walk->prl) &&
> +	if (prl && xe_page_reclaim_list_valid(prl) &&
>   	    xe_child->level > MAX_HUGEPTE_LEVEL && xe_child->num_live) {
>   		bool covered = xe_pt_covers(addr, next, xe_child->level, &xe_walk->base);
>   
> @@ -1760,7 +1783,7 @@ static int xe_pt_stage_unbind_entry(struct xe_ptw *parent, pgoff_t offset,
>   		 * we need to invalidate the PRL.
>   		 */
>   		if (killed || covered)
> -			xe_page_reclaim_list_abort(xe_walk->tile->primary_gt, xe_walk->prl,
> +			xe_page_reclaim_list_abort(tile->primary_gt, prl,
>   						   "kill at level=%u addr=%#llx next=%#llx num_live=%u",
>   						   level, addr, next, xe_child->num_live);
>   	}
