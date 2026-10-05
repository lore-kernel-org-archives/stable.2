Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39494D2EC5;
	Mon,  5 Oct 2026 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791223892; cv=fail; b=cCX7kMYQoulqtZQWGEnMFt2TOOKHmhlZCgRjMYJB0ALgFCYI6bHuTGnosq3jEZrFp11Tkr5dIOXSYrp6HJUd19V6ZOAyVtUfGcwxY1JoxPbjz2qojtqLomgs/HmzTKwkXAHQzG2rriB6IuRWF7V0QXIWNwNdOFGT0Vkq33ejCww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791223892; c=relaxed/simple;
	bh=L+krGhJ6Q29rX65eQQjY+F6UjpWFOiZPln8VTR+s7dU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bnsLPowj9Bx3dft4hR0U68xSSSUbKkUv8t1polkCYdNOkvnzCBHLffglGTWrGjABAvPafZtayG/aacKzuXNDWpTPI3pkzd//GpGG0WBrVkDkJ2QKVA2Mdeao572efuWyAcYXy+D6isOYkwm0qOz6bRkkdmRDfS53a3JKymHN9k8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAlL0+uw; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAlL0+uw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791223890; x=1822759890;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L+krGhJ6Q29rX65eQQjY+F6UjpWFOiZPln8VTR+s7dU=;
  b=SAlL0+uwaGvELFkVASKt9G19iTagVFnlObVPkWZHjJI7K4F6JcMVpq4/
   SWC6vDB6hWPwZaZPx9zOB4gQIqmIwbK0fuHktmxjcRE7nHX5/KZ5UYpDh
   UM11tw0rITmG4I1hBgEbHQcn45DcasvdKIhTrnpBDOQJjTdPvw88J+bqO
   0uHdMaIruy+urg7API2qprQbiCLFgAEmgqbJGZrIbyI2/adsfBvx03wDS
   EPFkdraa8391q+RSXS5B5GZwqjcaX1Ek2vl1txH2is16lRm+Bly6Xz5nR
   bu8MjRGeP4R5dDqZhiIUSAXFVsKqv5/Mfh3U5x0T/tfluYmzdbkVIFtV8
   A==;
X-CSE-ConnectionGUID: t/UGH2ptQMCZX8xD6Gbfmg==
X-CSE-MsgGUID: yQGEEOGjRYq8sik6ZtWy/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="95718534"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="95718534"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 11:11:28 -0700
X-CSE-ConnectionGUID: UabgeuPBTGakUcK6l33DFQ==
X-CSE-MsgGUID: ZgwKgLvHSWCXHtnWhG/Rhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="284981448"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 11:11:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 11:11:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 11:11:28 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 11:11:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2GjNBQuGFL11pE/Whiey6yqvKmjZ1LrPF3hlrHMDpQl0TTHzYvMqFE3ru6G8X/L9F6PkfBlxlHyAEZNmkit6sSjLMiGHp2gKzpxXbtDQOM3sePDlbNljpzIVmuo1ZheA9CnWrZsbP4jZSw3CBJJD6kf38jnygA9TbWUm56z8Ofegk3a2mLGE7UIv5NNmYG90ANyma5+q543eTRqLcYNeTnNN8uOiQo7MyBsBFfvspwaH1tMs4uwdDOjVye4sp3pW2TUJgenK1atzFWsRfaLKXsvEkZs4HQvII+oPCFKv0/J/+eRXTU537jCwq1At24hT1h5IgXPo0W0/i1Uz1LI5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6b47d3X8ltzmL6/twMwWjaPu92DE93CaH+xS+Z3abM=;
 b=xtV/6bKAC5W/K5NYz5kWMPAirv2ZWblhVScT3GAIRYX5fnRmD8t1ZaQjpMtWwa2+xnswHGNgN79o5T1vHPFYOBuQrIn+0TpNolFhpAPBwVKf5CK8OrJPr0ERfJr6jPL/fWXteeHY7hPyCd/g8VRY/ajio4qJvnOZI//Eqc0zyBJmnig83m+fvN7gLZSU2JeHjPdSp6H4VwnHTylUbgGdRUSblEf+M9sHNzkmgIrW0iWBCxT035AeDV0eGqIIexKQiQKxgiVT8inhjROQ4Lfe2KPQ0VIdf5QLOQCRFwgoqpxuNCNx3LnwPXGPMbFm4ABg5Nbdr/5P+PHtaBBYcMXctA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PR11MB872716.namprd11.prod.outlook.com (2603:10b6:8:509::16)
 by SJ5PPF20F246184.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::819) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 18:11:05 +0000
Received: from DS4PR11MB872716.namprd11.prod.outlook.com
 ([fe80::ae5f:9b62:3239:2e85]) by DS4PR11MB872716.namprd11.prod.outlook.com
 ([fe80::ae5f:9b62:3239:2e85%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 18:11:05 +0000
Message-ID: <c217a3a9-12c4-4c10-bf74-a21bf27df08b@intel.com>
Date: Mon, 5 Oct 2026 21:11:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 1/2] e1000e: fix Rx skb DMA map error sentinel
To: Matt Vollrath <tactii@gmail.com>, <intel-wired-lan@lists.osuosl.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260913171555.89537-1-tactii@gmail.com>
 <20260913171555.89537-2-tactii@gmail.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <20260913171555.89537-2-tactii@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To DS4PR11MB872716.namprd11.prod.outlook.com
 (2603:10b6:8:509::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR11MB872716:EE_|SJ5PPF20F246184:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b49b15-9d1f-4f85-f436-08df230c05da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: ItPIrMqIcx6UcG5Fm4MS9mFxY0hfHLVMjBc9smU50m2B8atQFMTwdw9GTY0tQWy8Ivrk2xrYJgpc8e1SH8utVLTau12UF1FlY/gllU6n8uABK/ze+1A3Tne5dEeOOWqQkHqgOUU86tR4SvYQSJnAVZ42TADi++l3otwCNnCZ1Gwklc/G/jZ77jivabE6RUhGaG3f+Nm++oMxsaHMdhDUfBSWKir+bFN62siT8A4P+3UKmOXKqiB3FTylNLd9CzNU52S0pwTnDNVfDMcxwBkCHN3X3nFkrslpqdRZ5f6sJHcywdqD+3trxRlilw+HZT3J810fQyp2BxJ7UE8tg4u0PPE41+aWBa5mafFTBAQ84dyB++OMuXkA2L2he5Nlt8STxOH26WlGOz3b6C/HWZ+CGz6xAyvoJtEdDI6tuDwxiUPbVqB7yBuwCO26kw96APaBswnc1Zme8wXsbpTHsbz1NwGkq96k/1c4Lolkb81/JHC0g6wQ1I8bmXKAN6rZiLf+fFsZy6lfIAMPP25q9phCpVzrQr2im5vcO/Z+hacZj6DXTG33iGgXqmwcRiY4HjCXAbTIUa5EocNBs9EZ2vhw+lBlzElX3Gs29jn76B00cvNf4ofMOEHKGruwzQ0cNj5+TULvGjWveSxA/wm/lovP40dePyM3IGhtOReFYy92jjg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR11MB872716.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmZsQ2c0OHlVL0xGTzVQTUdDNGQ1MjFCRVlWNzBBd1lnbllMWTlhSldrSUx2?=
 =?utf-8?B?Nis1ckdSdVNpTE9aNGlsSXpjT3gxNVJMRFk3VGxYUkRFR2V4UlpLSzVVVW1W?=
 =?utf-8?B?RVdudmNVbU9qMlFYdVlieHVmYWpYa3NNcU9FdnZDclBVdHdwQU03eVR1Rmc2?=
 =?utf-8?B?TEd1dXhHV3Jqdk9SbHR1WDlQU1Z4R3k5Y1NFZkJhRzhaOHpIeEhHRW8zempD?=
 =?utf-8?B?M0JsSTk4YktueEx3MXRuU095NnozbzcvbGhQNnk4Y1RaWXdKQkJ5VER0TGlU?=
 =?utf-8?B?YkZ1MWlVSGZoSHdhTWU4R3ZsWnNYNEJpM2VhSlgxQmpoMmtSWEo3V1dDa0h3?=
 =?utf-8?B?Nzl1aHhLMEdhUXArQVlhc3Z3SVZyYVZWUVRoR2JNNVVsNGkzZWVQdUN6Uktp?=
 =?utf-8?B?NzdiR0F6MTRQUTZWZzRTTEt2Ym1tblJ5M3RLM3dZT3o0bGxjN0RkUzZ2T2tJ?=
 =?utf-8?B?NWppUEVrWHVKbFZKOVd6a2swSGU4RGwyRzExUVBWeDZVSW1VOGZHMDd1TE5L?=
 =?utf-8?B?cmsxQ1dGdEtUOWhMbmVrdmNpUmZxSmRyZkNrR2lheGJwWmFnc2QxZjJ3NTlp?=
 =?utf-8?B?WlNSRlE1QXFUcU1DZTVKSFlheE1qeS83RTVKNkRVQVBQU1FrQnlweEwwQWpZ?=
 =?utf-8?B?K0tVeCtCNm5lTVZHcERWN2JCVkp5ZHIzcmwzYzJmS3FqUDhPL3l0VXlLS0pa?=
 =?utf-8?B?S2FPdHhUSVo1c1hXb0VvUEJFRWI0QWZ2RTlMUW9ld3E5QmtHRnpicHpadUcz?=
 =?utf-8?B?cnIxL3NwcldRa0UyMEhkSC93NENTN1VYUXpCQ0J3RjBLUFZVRE9Ha1pkWlpa?=
 =?utf-8?B?UmNDTGdiTkkwSkYrMzExSUJtaGRROUViWTdGSlFjQ2pDc1ZMVmVmRVAyL24x?=
 =?utf-8?B?d3lRTlJuc1k2YTYzditaQmJyak92blpzSjlubWk1RGNOVXV2eHZib3pYaTZN?=
 =?utf-8?B?bDZoeTlJMGdLSVdwV1dTSXlFSm9mdEZmSHBSOFFXOXZhSEgwUjArN3QzWSs4?=
 =?utf-8?B?dTY1OVlqaWRDK3dCVnRYNk1WRGFRK1J1WUc1bFdJRVp2Tzg4MGhMRXFSd2tq?=
 =?utf-8?B?VVA0NWE3QWRZRnJRZHB6VkhCY1JITnRBNEdSNEh1MU9yZ2h1NGFMcHdXcnBI?=
 =?utf-8?B?R3Q4M2FqQlJ1RzkyTkw1NmhFUUJHN2N6S2kvNnZCSjUyN2hhNHRVM1k3em9j?=
 =?utf-8?B?WmREam5BZU1zblNBOXZPWlNFcGhGeTRKM0ZLbkJ6V0tGdWJQL0ZWR3ArUUVO?=
 =?utf-8?B?VVFHWUkxUmVzdkhIZUFGVkdrNTRmWlR5b04xdmgxWHBsdWc4L0JuNXFYNjhU?=
 =?utf-8?B?M1QvRmtYWGdvbnRCMVJLbHdTVlNzdFRjSktiaXpTS1FWeXZwNEIyMEdjRHFu?=
 =?utf-8?B?aDRRbXFzVUNxVSs4MkZwTVE5SnJZV05FY25yOGpMN0tWTEQvdjduV0tuQnNi?=
 =?utf-8?B?QXFtNjh6aWdUUXRCN3poSGF3UE94Tm5oSElpcjQ3YTZpL1V4Nk1xSkNQMmpj?=
 =?utf-8?B?MzRUQUNnZVdMWmZ5WCtBemthRkpBdWYwMm1KWnBvY2dUVE1EZk9aSEh4NG5P?=
 =?utf-8?B?R3dDMjB6ZFZMdkQ0ZXB5dTJYa1BIQ0RkN2diWVltd0F2TXUzNGxtWU5tYnRy?=
 =?utf-8?B?M2xmb2Jra0JIaURiVmhJSU9sYWhwQURUdTVpUEVNSjU4aCswbndNWGEyRUl1?=
 =?utf-8?B?RUxWemRqL0FHZkdNRFMrSDA2OHk1VHBGTUMwaXNBbW5jM0xFdVBLOWZiT2JO?=
 =?utf-8?B?WldMN2E2Ry94QXRJV3crY3VwQnNPTzZPTGl5YWUybGhUMUNVc2hhczFLVGUv?=
 =?utf-8?B?bEx3RkQySk0rUWlQaU5uWDRHOS9OczhQYUF6MEVBM2pHZGpIUVNFb1lobmd1?=
 =?utf-8?B?YTd1cmlsa043ME5UdFF6bTJYQ1JtSGJOc0VJSlExNXFXLzVKbFkwekNCQk9T?=
 =?utf-8?B?UHdIL3VhVGRlcGFLUzVab3NDYUdtQisvMkttalhNM2ZzblVFK1d6NlhuT2NL?=
 =?utf-8?B?MTZrdk8xa3ZlTXc3R2ZyK0JwWW5hM3d2SjZhWW8yMDFuTmozSnZlRmN5OWNR?=
 =?utf-8?B?V1d5TWpNMmowYlhKUVNVdkw4VlA4YW5zczZRWmk3VUYvVWkvOS9KTFFSRDdZ?=
 =?utf-8?B?V3VjUm1aZEg2Tnp6WjlUc3o1UUkyNFBDdm9jSnpCZDZtSCswZGFaSlNKRWJM?=
 =?utf-8?B?UDVyZEZQczhGcjAwMFpwUU8vR1hOZ2hHR1FNdDlkUkxlMU5NUzhROGcxcGdD?=
 =?utf-8?B?bjdSMG1BeTMvN1VxN2hzY2lId2hMTFB1UmxScGp1cHVGY1N1L3RKK015REpy?=
 =?utf-8?B?cTdtYzhaeEcvcUx2SmUrTnY5QTVjSG0xS2FvWmVuVHNZak9pZWJpUT09?=
X-Exchange-RoutingPolicyChecked: cfu5hh//P4CnCIKMp/xPdlsheDUy6i+T2uDmhbH1/9PFa2k+tdBDoVsIGcDwUWeDhJdfI5wwhZOPIZUG1YCVXwvnYqhYIA0RHPS7qgb0B5OwvzF9MhociAHoy/qaEtKgorztoXgaJsAsPlfn/ldAG/fTSCHYU+k+x7zc4JhAZ2i9dRVOq+t9PsCBJwxPvcCfjbAT/8QFqkxtHF8Rm4mox4xiOqS8vnKqCWpxn19fIl/S/sQwhcZ5ONwauyrEUl0E8RiXXIz1KLrnNrpxYnhw6MD7KVy3tRsbbjHWem4LKn4JqWHrktDtD2ZlfvRajaVHz9RWMl1cIyiKgVg553aijg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b49b15-9d1f-4f85-f436-08df230c05da
X-MS-Exchange-CrossTenant-AuthSource: DS4PR11MB872716.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 18:11:05.5703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFBGzdA2iY7ODOxJFU8E0chjwC+He/y2M3x2zMDTLCi5B/8BUx6cAHwIov8g9HTx17oqI65FijG8JZ66jWOp1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF20F246184
X-OriginatorOrg: intel.com

On 13/09/2026 20:15, Matt Vollrath wrote:
> Upon encountering a DMA_MAPPING_ERROR during skb allocation and mapping,
> the driver would leave DMA_MAPPING_ERROR in the buffer_info->dma field.
> This would lead several buffer_info->dma == 0 conditions down unwanted
> paths:
> 
> * In e1000_alloc_jumbo_rx_buffers(), it would not re-attempt the failed
>    mapping and instead write DMA_MAPPING_ERROR to the h/w descriptor on
>    the next allocation call. On cleaning or teardown it would attempt to
>    dma_unmap_page() DMA_MAPPING_ERROR. This case would only be
>    reachable at MTU > 1518 and page size > 16K.
> * In e1000_clean_rx_ring(), it would attempt to dma_unmap_page/single()
>    DMA_MAPPING_ERROR (unless cleaned by the jumbo path first). This case
>    would be reachable at any combination of MTU and page size.
> 
> Use buffer_info->dma = 0 as the sentinel for "DMA is not mapped." Set it
> immediately upon detecting the failure.
> 
> The map error value was 0 on some platforms (including most common x86)
> until error values were unified to DMA_MAPPING_ERROR in v4.20/v5.0.
> Since then the error handling in this driver has been incorrect on all
> platforms.
> 
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
> Cc: stable@vger.kernel.org
> ---
> v2:
> * Add history blurb to description.
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 844f31ab37ad..26f45ee8c7e7 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -691,6 +691,7 @@ static void e1000_alloc_rx_buffers(struct e1000_ring *rx_ring,
>   						  adapter->rx_buffer_len,
>   						  DMA_FROM_DEVICE);
>   		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
> +			buffer_info->dma = 0;
>   			dev_err(&pdev->dev, "Rx DMA map failed\n");
>   			adapter->rx_dma_failed++;
>   			break;
> @@ -791,6 +792,7 @@ static void e1000_alloc_rx_buffers_ps(struct e1000_ring *rx_ring,
>   						  adapter->rx_ps_bsize0,
>   						  DMA_FROM_DEVICE);
>   		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
> +			buffer_info->dma = 0;
>   			dev_err(&pdev->dev, "Rx DMA map failed\n");
>   			adapter->rx_dma_failed++;
>   			/* cleanup skb */
> @@ -877,6 +879,7 @@ static void e1000_alloc_jumbo_rx_buffers(struct e1000_ring *rx_ring,
>   							PAGE_SIZE,
>   							DMA_FROM_DEVICE);
>   			if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
> +				buffer_info->dma = 0;
>   				adapter->alloc_rx_buff_failed++;
>   				break;
>   			}
> 
> base-commit: 78445023439506ebd83b86d40b1e428a3b309d4a
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
