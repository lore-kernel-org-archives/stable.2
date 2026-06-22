Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302172741A0;
	Mon, 22 Jun 2026 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782128347; cv=fail; b=RuLULZMq7xSN+rYLR7iCtIW1FwuZkTXN8d8qz7krbmwSGDurfI8YKpA7KLvaSHTSk0GMg613jIx7dY/L0cSc3ix4uMaTsAXkfzYZ0Im12dWAp0O4DUN515iIVgg10sR8i0/CD3616+Ncq1kchfjflgbvU7eBfQqeNE4nKejVfr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782128347; c=relaxed/simple;
	bh=WokoNI27lhUv0gUd7N6JT+GbZ2lPy1whq1G9Ds+m8Xk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SN2Nwz3BumtU3x4LEBTXUsbKJkcsPjU+TWjWX+kwJDqMrTDdjwpRZtVlH6spvIw6BG+O37midwFuKaQbNzBVZ6F5fEldM2uB5hIOJs3JmgRdRCM7caj8kPDrF1eMmZWmNZXfRRoVeP31B3vBheD9cgNfMJiefLav2LT9oiW75xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCQRLfbB; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCQRLfbB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782128346; x=1813664346;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WokoNI27lhUv0gUd7N6JT+GbZ2lPy1whq1G9Ds+m8Xk=;
  b=eCQRLfbBulsCpCZDeYL+Kqq/JJ1IvbiZe0lY7+4/NDZJOdtxLUriJFJn
   Te9/KZyiqEIK8e352I/pGwxgQbWSADeuzq/ylz6lBvld7KVNG1rJh7UM8
   D2GNPRMCET0grpGpL7VoWjWaVXVFnBnNMXjqjjdPT4D/BqAA40BncchI9
   Zo4/qRpsHyO2iv9yid8nhLFF1g9mlK5vDNPwdm+oiBVtrJQ/k9jYwabB6
   4oJv2Yh4uthe32Bsdx7Y8Yi8KFqkCr1m0seWYvr+jE+p+NFAaGM6kcu+B
   SyK3lev/xZgLtBZh3LohHGTgnUyIxiHWVsduwG4LyLZvWmZVZKKpCXuFR
   A==;
X-CSE-ConnectionGUID: hnBslVryQY2tjLJMf+wM2A==
X-CSE-MsgGUID: huPWoEPKT1eBodulkaxi1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="93509578"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="93509578"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 04:39:06 -0700
X-CSE-ConnectionGUID: /6WHYKP5R9KDNqnNpFAjJA==
X-CSE-MsgGUID: ETF6ReMeSI2LQ8diopB0Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="272908489"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 04:39:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 04:39:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 04:39:04 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.14) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 04:39:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDSG88aOV2rJU7ghaiDpog1G2AY+SZHCDC/tfPvPY4K0rL7tIVuixO/I/wR3CjN/35jFvQhJVoCQnLmEYcfB8zPBfei9wngzwcb83x5MpOYUwyxBon586Hr2QpFHREQ855BqQPblucPcM8wt4BNH2vZ+bQE9dQMgxOuWCk9zibC31Xn0YQIZ5fkxIxMeEM+aomUhvxjfGOfCi6Q/JORuZYtYg5psnfbt3pI4vnqw6I7TTHdCr02g10g16wEwbaLPGT3aGVCga2+FSBvOGOINMcX4W4FedP4PacnjfjmL9XdqDCOZO28IzzDY3UERFtsLsRAY1VnXrpA4eNe5jjhmBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+j+fYOHhg3J5xY+SIbtppqTBczt15vfEMmy09UuCNiU=;
 b=dWHGodfcDri7obua3RUlFiImgWuee6BLwo+6CyZJnnuOyC7NfK5nEvgqUPS4D5nR9bw1RxrLnhTBwsrJIHZGetsI1JUIPhOvuwSVhfO8NARrTDCY1epMzBzX8sP1lXnrQXWY6+RnlWGD3eYHCJKSHmYj1N58ZA2CKGaCCdA+dGk4zTrnOSBy1j+M7XZKwWBMwWJjJ/2ue+r8hYIthqiJWNhZ25l10bhhWs8mLmMfUcNGZqwre+jzOuuqW6UtjA98zgINGtVpVyFShDO2YEwU3oHsev7EyLvEmo1W40TuH0Pu/VZTc2Aw4BPPeLr1j6jIduGVleQY3s9OuHj5w3R9ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by PH8PR11MB8039.namprd11.prod.outlook.com (2603:10b6:510:25f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 11:38:57 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 11:38:56 +0000
Message-ID: <55f9e2af-54fb-4257-af25-dc9c0fbeb72c@intel.com>
Date: Mon, 22 Jun 2026 13:38:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6 3/4] iavf: send MAC change request synchronously
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	<netdev@vger.kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <aleksandr.loktionov@intel.com>,
	<jacob.e.keller@intel.com>, <horms@kernel.org>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <stable@vger.kernel.org>
References: <20260619061321.8554-1-jtornosm@redhat.com>
 <20260619061321.8554-4-jtornosm@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260619061321.8554-4-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P251CA0030.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::30) To CH3PR11MB8496.namprd11.prod.outlook.com
 (2603:10b6:610:1ba::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|PH8PR11MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aced944-b4fe-41ee-69d1-08ded052d6f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: LcqaF2Da4zOHfmBI5fad//mqzLhWD31/dwZnZtN/J4QFKTazmro5QxjzJjys9lLvGipvZ8VQwRjABKMrI2NVqjdm8dxoRRl/5613Ns6BQi8T4S/irGsIgJsdH+MD8W69xdQmejCcN97tcAI7F/lDNLDIFXFy51k+MQfwTCMJ1aghEeZg3YBfqQ1VNf7XLZLUG3eYNPFmy+vlVsb/mQN1nFk3u32iTUa8SSB4SO+Lyq8ItR3hxlnSqwoZzLfjIzUrkI0RFQcZG0gEK9n82KFdVgBWC43tAGdiMtU/Zta4TH2esPIvfD6OHRxD4T23tSQlA4FcXglbm6+QxcxUSM16Wyc8+hErc76ykHqVrMXJW0PL11sbb8GApGR+utj0+9b1AHxWqpHV2sqItqWKZgHQYg4Hvbg+yBZe0/rbSpcK2w6wWGjQ0u8FHadHV04vwI//WuV5B3pr0r47tlLLtl/x28AehQ60CPG6vs+GDDak4II08seqWg5qhHK38Xyu4w6+HEzPVGl6X0QBKRUJyQiYEL/WM0k/fCtQbgYk+y0oAffW8PkSEmvnSBIww66IJXI9KO8KP02gpBWdjrRjkSE0+Nny0I6o3sQzEjvsPboSXpErxlieRrqm6pzZtklGONK9v60fzjmZq/fvmFEASr4xNiieem9tV46l8OHT4J/nzVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1dDR2tieElQa2JlMzBMMHQyNVNBMlMrTEZwckNTbTI2Ym5obDNucGNtcng2?=
 =?utf-8?B?T3ZwdHZkQkpsMXNaYXJvUkxjRVJKUWxVRHpsWk9NOEVkUVdDVzVja1dIREtE?=
 =?utf-8?B?NGZCbWpKZUg3TzhNQTRnUDNhN2p3SllDLzV5R0N3L3VkRE95K0VqUG12ZlZH?=
 =?utf-8?B?d09aV1ZkLzdiTDBoblRibWdNNXBGUXlnazc2ajZkVU9RUmRFWm9TYWdnUXQ0?=
 =?utf-8?B?UzlGNUJHOHl2bVM2Uk1aV2JpVEV2emJIRHN6YmZPNmVJelhoRVdpcUJxNGNL?=
 =?utf-8?B?U1Q3dEFQZW80NXVBNG1YQ1pVNU41VnNwYVNpUUlMZlpkQTVaSWRsQnBmYlcr?=
 =?utf-8?B?Kzc0U3hlbzdCUXgrTEJ4K0RrVTh2Q3JCblF3MFNRZ1p3OXZKbGd2MEdXNjRY?=
 =?utf-8?B?Mm1HZXVYdGlBRks0dnQwemVVSTZUdFJPeFBtVnBBLzVXVVFwdUlJM25CMHV4?=
 =?utf-8?B?YzR4M0FEQ2FCUmxJOXZTSzZJRTFuV3hXU2hWMGFCNE9jK1lMaWxTbXBQelZG?=
 =?utf-8?B?SDJvRlljWk9QYzhXdlFWakNUREN3U1g5NkNvSnB6RUQxVGRGZVJZUmJnc0N4?=
 =?utf-8?B?N2hUN0x3QWQ5cVN0eTc1b0gzRm9qTERIMWczZTRLVDN3ZjBLMGkrai9wRVJp?=
 =?utf-8?B?cTNWRmRPT0ZpaU85dm1tUCtZRVdHem9aSDc4N3NEajFKd21XTU5zRVI5YlF2?=
 =?utf-8?B?OXBlWjNTbzd2RmFjcjloNU9xMTdLaUNQby9BWU51cytHS1pSblpMTmpMamMv?=
 =?utf-8?B?bzV0L2x3ejRFUUtxODBjd25IV01NOHlTOXFIV0xEc0tmRFhXMVYwaGNneVRS?=
 =?utf-8?B?TUFzUHlnNjJyQXpZU0Zuenc3Vnl4S1hkWFdiQWptaVB4aUsvbFlYZVZOa21z?=
 =?utf-8?B?SnorU0k1QTQ0UWRRL21QWlhvTk1jczNoVkpwWmZpODg2eEZCY1l0c2hEa2tx?=
 =?utf-8?B?UjArUnBqSjZsL2hGT3FNWTQvMm1ZNVdVOUxtaHpMQ0FoaXdNaHBXWEkzVnpw?=
 =?utf-8?B?cUp5RTNRUU5oQXdRTXNaODlGbXlYQXd0Y3k1blZlVU1QbkozVUJ0a0NwR2Iy?=
 =?utf-8?B?T0N3Z0FjTXE4V1VGVEpYOFBIUm1OL1JCVlovTVdKK2lJMHRpeXVQRVdEV3Aw?=
 =?utf-8?B?Znlpd0k2MGUvU3pKZGRQZzRtLzI3eHlPcXpMOVMwSHZOR3VBc3o3NER6c2Js?=
 =?utf-8?B?TDVRazlBZFBCcndzMlJhbVU2NGUvejk2Q202SHd3bDJCUmh4M2JxZ2lmOVZC?=
 =?utf-8?B?TWplR3dmclhmYkwvaFdzK0xlUUdRSHJlbHNLSDhqVS8yZ0wyNjZ6Z09aSGxO?=
 =?utf-8?B?SmM3U1M0N2d4OUt2MC9xSWJOcyt4bG42NGpLK3pNUHFtUVZYdzExMlE3aEJs?=
 =?utf-8?B?V1BndGlhblNRVWtvZDFVemF6dlVMUkZnWWtXTFlsWml5dkxXYTh5YU1oUVlt?=
 =?utf-8?B?YUF4YW9hSTZtQmppVGp1L1hqL1lSMDlGVGVkTitJR2VtUHgwSmQyUGIvM210?=
 =?utf-8?B?U1ExVGNXblJNaldKZDF0amdsVlJHUk84QWZLdkl3bWkzN1krVUczWTdzdzhS?=
 =?utf-8?B?ZTRQdXBvM0daeDFFOHd5WDlibU8yMnptbU94a1NwYUpWbHhzZHYwL3hOL0Jr?=
 =?utf-8?B?NW83c29DRW1XNjRNK0lUR1AyRHM1dnhmU2NsdVh4UmFVUnRzUVJlYXhHTkVr?=
 =?utf-8?B?d2Y0VWYvcVZCclMxREkzcDd4RlgzeXVCWVBUM21laTJtTHNWbG9QZ1FoYkUr?=
 =?utf-8?B?Qk9zMk5qNU9KK1ZyZUNUVlVseTdYNjZaSXNWS0R5QnhRd0hKRFpSenhmR2tw?=
 =?utf-8?B?OVRUYzFxQWIxRUdMdUtaRFBhSFowdS9SRTJBdVlEek5XeHRCenRGUjB4Rlg4?=
 =?utf-8?B?RzkvZ254ZGRhTXBVSEdyTnFGaEI1RVgzM2N5eHBQb1EyeXV5TnM0Q201OVBM?=
 =?utf-8?B?V3E2L0tQemgwbDlZbUljWmwrZlRyblJ5S01HVURERTJteC9hdC9zb0VMZXVh?=
 =?utf-8?B?U2NKb05zdk9oUUYvWnBjeGRWQkVTaTc1MmxzcFdTbjc5N1owUVZXSU9LQjBS?=
 =?utf-8?B?WDcrM1VBcTVoc0hDSVFnUlB6YTVKcCtzRjRJKy9TODdkYlBBS3QybFh4bU5K?=
 =?utf-8?B?ZW5PS2VUNDdTRUs5c0VQV1IxMGZMWXRmOC85UHVsMTRBSGo5VnlEemU4M0w4?=
 =?utf-8?B?ZzdTOGkzZ3FQNlBtcEN0enk5RUlxZExrM245QjBCc1dqTkI4M0h2cXBpV0lr?=
 =?utf-8?B?cEx1Q3IrQ1ROZzR4dGtkaHlxT0hMM3dQc2tFTnF1Qlk2b1BNR3JUQVZjdWtN?=
 =?utf-8?B?cmNWYzUxdG00Q212STk4VTVMSEY5b1pObTFuYUpIRUIvZG01S3o5TU1lYkJX?=
 =?utf-8?Q?tuyqulACFLmczE3s=3D?=
X-Exchange-RoutingPolicyChecked: fhmWDPnijw09E8A18D4xvv+nRP0ddU/uOepSGqI0mhH5fgw+6T3z06GVaYIL6IvgEG3+ZZ2KinQ/yaXsQkStlJlriNtqL3EOMe737zLGYvPLFRYL2PNo+JxTVj3N3xeE1Fc1t0aVI6FqznRqL9iE45QulipOAxhtsIkWIuYzGtEeCeIMfZqBvSlBOVdR6bXH+dRBecrETAtfCRZtgov93DZVJBLja1nDWAaJ1bAAd6j+++AK/zanAGp6FVQglDs34iU2AZ2j2XJz6K5E5rGlyWEsCR5kzvu457ifapE0E9OqocHvTyTqPsaxmwba7C7TTLBrft+ZVOQgb8xI7BzqVw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aced944-b4fe-41ee-69d1-08ded052d6f5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8496.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 11:38:56.5456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUecltkOJ0cWeJR0x1S9ugGHTzeHBj94GFcfbDXrsYQ6BYY5qbRgcnYsM6Vn+kK8jUO+OkEQIoUqbFm6EzeTsyqGWJdw1YBCpd8ARt6uYbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8039
X-OriginatorOrg: intel.com

[-Jesse, he moved to another company a while ago]

> v6: Address edge cases found by AI review (Jakub Kicinski):
>      Although unlikely in practice, v6 adds robustness for corner cases:
>      - Allocation failure after message sent: allocate event buffer BEFORE
>        sending to PF (theoretical - allocation rarely fails for small buffers)
>      - Multi-batch scenario: add loop to send all batches when >200 MACs pending
>        (rare - most configurations have far fewer MACs)
>      - Timeout rollback: only rollback on send failure (ret != -EAGAIN), not on
>        timeout where PF response handler will sync state (transient inconsistency
>        during timeout is acceptable and will be resolved by response)
> v5: https://lore.kernel.org/all/20260429102426.210750-4-jtornosm@redhat.com/
> 
>   drivers/net/ethernet/intel/iavf/iavf.h        | 11 ++-
>   drivers/net/ethernet/intel/iavf/iavf_main.c   | 91 +++++++++++++----
>   .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 99 +++++++++++++++++--
>   3 files changed, 171 insertions(+), 30 deletions(-)
> 

[...]

> +static bool iavf_mac_change_done(struct iavf_adapter *adapter,
> +				 const void *data, enum virtchnl_ops v_op)
> +{
> +	const u8 *addr = data;
> +
> +	return iavf_is_mac_set_handled(adapter->netdev, addr);
> +}

[...]

> +static int iavf_set_mac_sync(struct iavf_adapter *adapter, const u8 *addr)
> +{
> +	struct iavf_arq_event_info event;
> +	int ret;
> +
> +	netdev_assert_locked(adapter->netdev);
> +
> +	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
> +	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
> +	if (!event.msg_buf)
> +		return -ENOMEM;
> +
> +	while (adapter->aq_required & IAVF_FLAG_AQ_ADD_MAC_FILTER) {
> +		ret = iavf_add_ether_addrs(adapter);

I believe that this change (made in v6) is wrong.
(just an observation: AI review made this series worse vs v5).

the second step onward would fail a check:
"if (adapter->current_op != VIRTCHNL_OP_UNKNOWN)" and thus return
-EBUSY

watchdog would not kick the VC/AQ queue since we hold the netdev lock
here, there is need to manually ensure forward progress by calling
iavf_poll_virtchnl_response() within the loop

I think it should be fine to stop when the "iavf_mac_change_done"
condition is met, this will simply leave the rest of the changes
for watchdog (as we do now).

> +		if (ret)
> +			goto out;
> +	}
> +
> +	ret = iavf_poll_virtchnl_response(adapter, &event,
> +					  iavf_mac_change_done, addr, 2500);
> +
> +out:
> +	kfree(event.msg_buf);
> +	return ret;
> +}

