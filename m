Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B632E3D3CF7
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404980; cv=fail; b=g4ocGWHf6SUsyzI51Hn+bbgfmZ/w8KE0MTLzI2sX/syKNDzaLr0KzP6c9aZOf4gC1zZAXEpRcT9GysY6cGwXQbyamBU3GT8S+4r12GcKUiqytxFvpNWdeqRHYUsdDi/0wG5rUyROXdx6EgKedINMuuVGFs59V36ZWkvEkAOCdm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404980; c=relaxed/simple;
	bh=nxDbk0i2F468aef0d0CDuFcnX+MCsAnIFSve1QgnOz4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RrQShc+hpzSPejdJKJ/4w0HdG/WBBvyvX7lfRVkOl/X/LaT+IVIc/vkoRbZ1dghrF6GWk4FWCiLFXlyBtnLp4phSBXYaJcgMcvXzk//On9kZgbQZy/3vU3KcBZ0gdUcPat+ikmAqONutANwMHr3OspDcYNDxIZbkgRsjEyo5Yxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GzPnKnkd; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GzPnKnkd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785404978; x=1816940978;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nxDbk0i2F468aef0d0CDuFcnX+MCsAnIFSve1QgnOz4=;
  b=GzPnKnkdL8PoQhBnvcujUb+A2PsdFz1GzHOPji6TGQv5idaux7wezhR6
   LOP6xISJIUZzq4f3l5T0y1vIxAbIki7hgyjI0tJjWVrX6lqBpWl29ZDzD
   kfJzLUe8Dkp99wHqlS2NXpUNwvAorFMpSL8kxZmhwAJIBM/A/z4eklmur
   vZeqQWdcIatuABLO+sOdPy6SdPF5wu1xVxGyJ4ZMNmW/Yy/kdiHFFbj+b
   dMMoW6Sube/6jSb5kZfeuxDItrU+lo15kdY4OIIySvFsoRlEop6hj+3de
   ZHtDX4DrO/OhkB473XYA3N6sLjzAvxFg0PDASS7wTxgN1tv+MJYmY/5iF
   Q==;
X-CSE-ConnectionGUID: K7NecAODTteTOBjhUPZrUw==
X-CSE-MsgGUID: mocLdRe6SK6KbCDbDT4r3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86035493"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="86035493"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 02:49:38 -0700
X-CSE-ConnectionGUID: VKYNExkFT6y5sLNlCRX/xw==
X-CSE-MsgGUID: xzkpe63ETvW77S/1Aaj/DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="259677222"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 02:49:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 02:49:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 02:49:36 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 02:49:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OENa33KHXHy4y+D2H2Zx+mM5+2CTR2LNzTpzb01GvLV21PcsPobtVFFWlGcyEjl7vyo2sQ6/hYjYQzxuvYsrELU6w8NHDpVhezIn4UuZfVs831Pm+OG94C0SA3XlaC/HfCAp1lX8QojTJ60jxXo3S0MTwiX2ni8O0LNcvDCycl8AnjzmvWkMsCo0qYRQXkyceAXqMYoitFticgXSDr3Oc+OUE+W6WknFSfPBGZSwSl+nyugEHoWZC4NvmlEsRqkwTsL5t+WkEF6UW2QKZTtk4JfD2XkDarTdX/Fza5tN3eNMOlvBNhwElSxeGOe8n+j5CarI2SwBesbBJG+CAIi+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd4bMOi2qW5FgGDq4qQZbwf7XcGyBwY8WmyMiLxktfc=;
 b=aB65gkVa4SQkv56NpoFe4+3htHeMsOEpPzFM4Cs48ZDtohQJRRsCO+q3m061UO5/mQJU5rj0KZZLtF2c7ggFwuNiRzwZsHFzW5jQa/mjMiyRynK21pExapTT+EjhPKcwkNufhN6qmwiUdzvs9PenzyZh/dh9yzwE8Zwla2qi794+mjadNVSo/X4n5XHHx/b/7aq3ByRNThcFqhkuMKSD0AcGgcaKosT2PhvOvmGp8KMFeinpilWJNwLZ48NPDXws9cOhEr/9sinl2fLpeeTrh6QIe0oNGEt66H7TuEb2CPCpf3pPjYxOBSxTJGly9qbvJNGKE1lKxkRr3J5epETz3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6)
 by DS4PPF4B1ECA5EA.namprd11.prod.outlook.com (2603:10b6:f:fc02::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 09:49:34 +0000
Received: from MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811]) by MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 09:49:34 +0000
Message-ID: <54ffd2c7-4901-48c3-bfd8-00cff5852c2d@intel.com>
Date: Thu, 30 Jul 2026 11:49:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drm/xe/guc_ads: use uncached mapping for UM queue
 BO
To: Jia Yao <jia.yao@intel.com>, <intel-xe@lists.freedesktop.org>
CC: <matthew.auld@intel.com>, <gwan-gyeong.mun@intel.com>,
	<stable@vger.kernel.org>
References: <20260722053410.2767369-1-jia.yao@intel.com>
 <20260730004735.344627-1-jia.yao@intel.com>
 <20260730004735.344627-4-jia.yao@intel.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <20260730004735.344627-4-jia.yao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0094.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::35) To LV2PR11MB6024.namprd11.prod.outlook.com
 (2603:10b6:408:17a::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6011:EE_|DS4PPF4B1ECA5EA:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7164d2-7923-4dc8-de85-08deee1fdc86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|10067099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: vs/hAJ1Hj5o5RHYuadaTT+/CZgWF5Mnw7CcIpvXJCe8kiwMiXRkE8P2O+iii+5BCuhiK7OFPs5YPVH6g0ZfPBOrItx6z/mvMnNO3ySNi3vTA9ZdjDCfN9bBS3BVzLDvXvlzGAFSSjVCWvGJ/PqKohhnVjy7+bVBAQSCEX3/l0lZECAGbcDIsAE2vP2Elgl+WgXl33hfSaOnmk4ycUFificHvmZ2/M10GOz5IWMW2o5JhBMS3tyx1Kw9A48ljQQ6J0tPar0pdsYl6zOej4pGnFL0FMByP/HbGLcX2WrNMz3e0nq9K0tr/WwTkmrEc76AzxAcla2TX5h09WNv/QXI3253XUcA62Rd+2rG1iSnhF1+7dtoaMSpXLO14sE48Fx9jrm16eQtVTQSHh6KOeEtpPfHk1IgrJVMDVgePdlDmpn6QNhSF45wf7NjCFGK83s34WCsOUPjiLLj7dk849KjViL5gGKGOThkHTPQ0QbrylhE4acSkrjCrKQTMKM3w2idiJGlCViXP9QRPb9QRpMeKYYp1g8DjF5GSZEuNfPVuhr8JvCZBxXs4bSkR5GE3bF3UFxKleM2ADm87QrBP0EHzIn8Tjl2CZyQAc8FsuvEBpHybJubG9EfNHgksKwAtHdiFkpEH6HNSB47jQywVMRj4WumVjjTif80Dp2KrawuErCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6011.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXRaZ3IwaWhpRDhYOGxsdzZiS3k3b0JuVGhtY3ZGS21lUzByWFd4b2FGbkhW?=
 =?utf-8?B?ZThYaWtaS2RFUjMvdGk2N2hSdjV1ekMyVXNReEpqZEpZR1N0cGhlcjFuSC9x?=
 =?utf-8?B?cVJMNTRvbSt3VUxaRTVqWkNKOUNzUmFmd1h5Y2l5alpLRkJEait4bUpPOHI1?=
 =?utf-8?B?cHltNGY0NW1ZZFJVZjhIVUJvY1loUVFWRnhyNVNJQTducHNqbksyWTRaeU9n?=
 =?utf-8?B?ci80cDRmTzJRbFhjUHN4a1R5U0tubjNiRTRNVG5SMDZnZXljMjJLVEUxMWxQ?=
 =?utf-8?B?MUVqTjZ4akNCQzhMUGN0VTVpOFRxM0gyOG11QjdoZHI4VElJenJnNTlkZnk5?=
 =?utf-8?B?U215Q2FsM1BQVmNTNDRqM0xrc3lVZHFGc0t3ZDhBaXVvdTd0bWtMdEcwdTJY?=
 =?utf-8?B?S1cySDNjVk8zQ2JicnMyeXJMdmpHQjBqWG0yNlhibEZvSlJaV3J5K2ZKc3NI?=
 =?utf-8?B?WW5PVXFEWjZHQ0ZROHQ5SjNJVnY3TVNFUlZBMTNXVDdERWZienlKTnJ2cERm?=
 =?utf-8?B?NDY5TjlhMlpROHRrNFJlN0N6cGEwN1lNdTZSMFNSdTNtQ0RKaHU0ZW03RUcw?=
 =?utf-8?B?cm5LNWtFcjFVNWVOcjZ5SFEzUHZnZFRwRGhIcUh5STRFU1Y4dTRYS1grMEZu?=
 =?utf-8?B?TGdZRytIV3lpRmRuaU5tS0w5VkZ0M0NUTUw4VFFXU1hCb3ZnU2lGbXJEaXRP?=
 =?utf-8?B?SHJBNVhrQzh2K3pkUzRlNW1JODU2MVMxQ0dxOEtmWFNEM2FPWGJJcTJrYTh6?=
 =?utf-8?B?UnRkVFBYN01COHVjYkp0WlhuZUhBTUUxenFEUTd3NnhZQjNLNTFTTHZGY25I?=
 =?utf-8?B?MDZ2ZkNUaEtRRWtPeUc5K3F6K293bzVrVlpDMFZ5am83UnljR2lWeFJMaGFI?=
 =?utf-8?B?S28rQXdDWnVpdjNvZ1cxYVhrVU9jQkRUNHpkblB3UnFDL2pCbU5QRWhFTHZ1?=
 =?utf-8?B?NXBXbXJiWUt1ZG5SV0pnWUxzbEsvK0tLenZObE9TRUtvampCSjk0c1UzeWps?=
 =?utf-8?B?aUhodjg1OWV5Tmd2YzcwUkRDVW9tV0wvSmNraWFOd3IyZEJ1TVlqMHdxbmRj?=
 =?utf-8?B?RjhnVGtPMm5oY1MyVi9DQ2c2SXlNUzlNcGZPbDJlRDFLMUhEeXQvcTN4cm45?=
 =?utf-8?B?NzhTRTR1UVgzcWNjTGJKRHBobzVVNWlzWFVQS2FYaWs5QnBTeVh3TGd2UDNK?=
 =?utf-8?B?S2FiWmRKWGJxb2JQU09YV2llU0pZMGJnWFBCTitjM042ekp3WmNpUVhMWGpt?=
 =?utf-8?B?UUpVUnFKRlZ3dnVhNit5S0I2MDlTY21TVzdHcEo3eUFWdHRxVjVydS9iYnQy?=
 =?utf-8?B?VVBnaTBJY3EwKy9aZDhSa0p3a2FMbDNpRlNiNVBOZXZVRENqK3piTjUxSUh5?=
 =?utf-8?B?WE5ZN2NIQUxvb2YrYkRpc2UzcDY1YTJYdzdmeEhuVllFUmMzOTdaMExiVTk2?=
 =?utf-8?B?OHlVVWpneGYzZFdiaVM2MnRvQTJpNUs0eHUwY0FTYUs3RjFTWUJFcmNzdHZU?=
 =?utf-8?B?Q3Y4UFpadElDZmVjWDRybm9RWkZOQmpYNVQrOHg2RkFicDVSUXNpQ0h3cEl2?=
 =?utf-8?B?QmhwbVJ4bmoxUE1sU0libTFFODNSeWxoNVlOdTF2WlY5VlFMcU1KVnhORnZx?=
 =?utf-8?B?Ny9UWjFKdkovbDk3c09ySXZLTXhEeXpoN3N2aTgzVXozWDRYZHl3cUR2M3dO?=
 =?utf-8?B?Smx4S0FaNVpnMFZ5dU5lZXI1SFZOWHp0OEdxL0lRMmtpTTNxQkFzcFJiN2J6?=
 =?utf-8?B?V2RMZXQvOXp3YUxKYTBqbmMvY0NpZSt5b1dTZE05KzVXeE9VL2RHeGM3NzJ0?=
 =?utf-8?B?cDdVRWF2SEVzeGV2Z0ROYnpSdkxHU2hncHRySmpWRXBUMEZnMHZMYldGeUZl?=
 =?utf-8?B?N1JNUWxXTllrQ1VsOGZZNjArbnBOVk9PWEV3MG5HeVpZNVp1bW0rSzMxSEt4?=
 =?utf-8?B?c1VmWWVQazBFejdBbEgzRUo2cThxcmtNTHpqVHIwZWJGejRmYy9xWTBmcjZD?=
 =?utf-8?B?cVVBVjZEa3pPTTNrZXNSQjdJZFBrZnZVZk5FZWNzNnJabmk2eGlFd21Jb1JT?=
 =?utf-8?B?S3kwYStMSFZSeHlhVVFtUEVoeDlpRnZGbzdYeGRNVW80ZWFBWVRSd0JNTnBk?=
 =?utf-8?B?UlFjaHFGMVdGbW5vSDBCMENZY2U2K1dPWnJYMWZSVTNGWTZhTHVJTUkxcExs?=
 =?utf-8?B?ckVHK0c1cEVnSFVSVS96S3JnRkVyVEtmV3pCSEpPTW5LVVQ4Y1BzOFVNaGVX?=
 =?utf-8?B?UjhtMzJNblRvZGsvRzdwR0xyRTZFUWZhQXhxczR1ZUhLcHdoRXkzK1ZFZCtT?=
 =?utf-8?B?VmN2a0xsNVoxTFVReERqN1VqZmxvRXF4YXBYd252OE41VGQxMHdxaUQ3SDN3?=
 =?utf-8?Q?XgphYiVE9kRXUBIk=3D?=
X-Exchange-RoutingPolicyChecked: U2u8eYYfhcD+Pa6fnRdXxqPtKRxnjGxHtMXK/qntD1ZmO24YhKaj7n8XTwkaLbAHkwsr7cNX+MIbcGQmsFxvSenRIV7GFrRT3YNX4z5lQKne+VFVJ95MEsDQ+9kQF2uaww6LfVycYHpAyV1WHIG/Lgg4yI9VD22YjabAmtcEoI2cZsxW2800pBUiZqdmcyAtuZN2nPQl/AsvJLIrgMaexslslZMxgMAUUgwd0/03zHl0NOKr7TSL5/Uol16qaxtnL4z7gWNiU7qe8s1UUcYAbsZrNthb5rgtWPKFdlhGdZQQOsJN0bGoHXI8Pw4oiPvODfuX3JXUokR8Q6OilZBVRQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7164d2-7923-4dc8-de85-08deee1fdc86
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 09:49:34.7259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuPmMhLdAp6IHrK5SSNnR3VtQz1Mk1rhm4UecOcNJGQiVXA0KCFggR3D4cY4HgoVttQTdqwfBxQsgDVD+Tpny4XNGeSTLcjHoyUZ9oIe61g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF4B1ECA5EA
X-OriginatorOrg: intel.com



On 7/30/2026 2:47 AM, Jia Yao wrote:
> The HW unit that writes fault descriptors into the UM queue ring buffer
> may not be coherent with the CPU cache.  If a descriptor write is still
> sitting in a GPU L3 cache line when GuC reads the slot, GuC sees the
> stale (all-zero) content from DRAM and forwards an invalid descriptor to
> the driver (Faulted Address = 0, ASID = 0).
> 
> Mark the UM queue BO as uncached (XE_BO_FLAG_NEEDS_UC) so that writes
> bypass the cache and are immediately visible to GuC.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")

note that XE_BO_FLAG_NEEDS_UC flag is not available at this point

it was initially added as XE_BO_NEEDS_UC flag in a commit f15de1936f8d
and then renamed to XE_BO_FLAG_NEEDS_UC in commit 62742d126631451

> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jia Yao <jia.yao@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_guc_ads.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
> index 53636333fb45..76029575aa45 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> @@ -412,7 +412,8 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
>  		u32 um_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) |
>  			       XE_BO_FLAG_GGTT |
>  			       XE_BO_FLAG_GGTT_INVALIDATE |
> -			       XE_BO_FLAG_PINNED_NORESTORE;
> +			       XE_BO_FLAG_PINNED_NORESTORE |
> +			       XE_BO_FLAG_NEEDS_UC;
>  
>  		bo = xe_managed_bo_create_pin_map(xe, tile, um_size, um_flags);
>  		if (IS_ERR(bo))

