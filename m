Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F17D48164A;
	Wed,  7 Oct 2026 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791364008; cv=fail; b=J/E9wD94GbpftlA9Fl9QGPr5vnjiSDrb8IhKhYe5YKnpiMk960t7Q4uu7FFZvll9guJm+7Iv3ppsChvJ1/gvhqe0zmz8d+GO5wEdgq1CjdCTLLV+RfCs/ASXsBXOyqoGLvr9L8PuUKU4kGhAXlvtW5CBNHVrb4EUw5dQ8lBjo1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791364008; c=relaxed/simple;
	bh=Vl8Ekx2s64eWL7DAWcyByLEGayGhF3iXoYWG8dpIDHU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ix9AyOywLnvbeGh66oKLIjI7VKVRBWm1D9FTk+aJg8Cmr1hhgI6D2IezOxI3cYMLZQtcX14ivO3GeWBxaPZqSwlrD03wI3iWNujFv+mkZ7Y+CzuEf8N88qWCvD81nyVIWx92v0kBdrlGpnTiJ4nqy81zocLjdq3jyt7+UWORj3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9CXrBbt; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9CXrBbt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791363912; x=1822899912;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vl8Ekx2s64eWL7DAWcyByLEGayGhF3iXoYWG8dpIDHU=;
  b=R9CXrBbtKubH14XOGSUwE6xFC6KQLFvvaPDEYtHJbKE8Ww8u+k7DeK5k
   WL41XhJe1DF8r0CchYblTAO48FQsrHl2jWAotadjYMmLA0l8g9djFneAG
   Y5GHcnGJUoel7L3UCJ8aFUI6FvBBQdbcuPXC4mlHh4EQJj+990Hy8JDte
   WlRlc+h7wW7HmMWhbZWSmc+ugkzmWTf5WZIhgcJU+UzuBt6qAulg8Dvll
   CFihYt3+D858nHL82QIKXrR+jzgsQY1gQx0n8owjsTlB2ytns/1RMIqBk
   ZYuLn25Vgr/CatOeZlxnx+pA4gu7zMdLiS05b/yQikQF3Z8y2NvGWlYqn
   A==;
X-CSE-ConnectionGUID: ELwaZIwdSrao9Kw3mdfcUA==
X-CSE-MsgGUID: s08aDWd9SzK5Rpdl55p1tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="17393"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="17393"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 02:05:11 -0700
X-CSE-ConnectionGUID: A2RS7pPZQ4muDK8C6fkrDg==
X-CSE-MsgGUID: BsGoDMShQGSquadxHvm8sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="1505171"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 02:05:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 02:05:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 02:05:09 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.26)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 02:05:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4amJYIcbTFg0N8SeCEksKoKV48TtmB/yskwpjvzeAoHp738W6QfSPiMG+K2fHSOpsxPoVkwjRfoyukYDe7b/uDyJ8p6gcsFaIT6a3AIAV4sZiCAzVV/i6iz29Uk9DIPuOmnx6H6QhrLuFixWpoaq6QjCNzI3DSJ5/YsLTtUFHY2sBeoNAe9oPRVFrVw2StaFNjl9Z3b9BUnPThUKF8Pr1mXPdZ0diWNUwPaClSUyLmRfOGkLyniaSB+B2DAPG4SAbQW6Hi0H0JGKT+uSPvE4VwaSzYvZ+dtnSenkANRgnTf35V8JY49mq0bdCa2jGpKHsttMF3gu4hERy6BYV6mmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEJ8GWENdsxFH1YQlj/4kU/a5fOA79gVWTPNDSirrO8=;
 b=UQ/Nm7Bc3ISlDvM63sVC37vt4Y36U68uaozGNxcoIOETFhafQuCMNyW0F2lvw6kLoOxx6l7gY3ryBn4iSJCugXDBYFyAYd0dHag4o/Q80fX3TPKgDEG8SM+bEJvAdpD1sYiFem5rnSi9nA2EI8r5oplcXRcUVG4BB+0l2R2O4AVPJT5uvkikgomMF9/tzjLFo5cGABAfA65JjgJ2wvHbtCf7r3imSucIX+b7IiNfRotLHsGTXx7KIgT6So6VOF/fYPHZb3BfU4gkZwrJjRGs6F8WOj5psAC4KrI6apAO6BY/q9qWPWD9suWI4VyvWMniLgKk5fiRfZC2/ZAcJOJiNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by LV2PR11MB727748.namprd11.prod.outlook.com (2603:10b6:408:413::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 09:05:06 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0472.015; Wed, 7 Oct 2026
 09:05:05 +0000
Message-ID: <1b5d7223-345a-4197-97c7-9e715f0b76ea@intel.com>
Date: Wed, 7 Oct 2026 12:04:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: sdhci-esdhc-imx: map unsupported driver type to
 Type B
To: Ian Ray <ian.ray@gehealthcare.com>, Haibo Chen <haibo.chen@nxp.com>, "Ulf
 Hansson" <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>
CC: <stable@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<imx@lists.linux.dev>, <s32@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20261007070313.863-1-ian.ray@gehealthcare.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261007070313.863-1-ian.ray@gehealthcare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0283.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::17) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|LV2PR11MB727748:EE_
X-MS-Office365-Filtering-Correlation-Id: d135829c-616f-45d4-a7f2-08df24521431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: FeGNMG536DNr5Pljz1FjusgXd2oJr+IQQEJNjPu6YF75BhDmYLPrp2EK3ofsbGPr2f4RELwU0d8BfL37eER484vAq/RkI/YN/pt1qZNwjhS/v+sNIy9LMlqOMHrGSCp6PWH37sXxKgNlbUeAubCYxVZWxdGYvGnH/WzD1ktXFBUZgoyGn1B+4TOCqUaHFs4aYiqohBlJ/U4V7qtBIfJAp+qIV08nYK7OTdhqFhYykc45dSQDMw/1nBhaIP29KLC0H6/6jXUdMnWtEq/XPd40a9ycmeU9+zHiLILt9qTMhk3aU7NXpjMo5ovjUBiwsPTXD0knkXXRDjMFr8Xu7BVj60+0CQMaFep7FH1xM90+ZZ+MvD7VQsa9y+1mWftwVMjG/mNmZNshmM6B5uuEKUekFlZjl19aVxTg3Yo1Fvcqyl/Im9Jy9shW+UOBvZaAX8+NRjQNpINdVHlxvG+B0xLrmNszsD5sSGO+pbDUh/Cie1/MKyoNw/qGNe1MG9BNAvz9qu41s1RFZQbd7SFo8/t0VQE6ek2dWPFtcrVlHD0fu08bPfHhqivBvAm+bgWFCzYAIfcXF7aZB8pZ5mAhxSvn+wyjzTMThg58zQsi9xjZVWITPicga9OjBiOBJhTT5/KKW0UzNnNPpJXw7UNgvHklakey4CIiti5yf/i6c0+wE2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dndzVzBKeXFpRDBuOVhER2JZQS83NkhubDBsUnQzTHdsYnp5TFE0cWNMb0NZ?=
 =?utf-8?B?UGlES3ZjeC9UcTcrTUx0U0R5LzhaellkQ0hnOW5keVJTVUQ2NndlUUVpcFow?=
 =?utf-8?B?T01UbzljNHZpQllsTTZxNEN3dUkrZkY5NDhQQjd0K3pFNit0aXBTSk1KZm5J?=
 =?utf-8?B?N25DR2JNb09CVE5rMDVlY0lNY011MVQxaGlLQ29rQjEyb3BkQU1mZXA2N3FC?=
 =?utf-8?B?RUc2eXVXa1V0YVdoQU1ieDM2WVBGOWo3alUwRi9wbWJYbkFBclJ2V1NYdEQr?=
 =?utf-8?B?aXZHR3BGb0wxRWdDWlBuZUdYK1JZWTVvU0dZZjNCWmNVRzAvVGFtMDU2TXF3?=
 =?utf-8?B?OVBuclNqaXBpOGlWTHhIVzhaajcwaHJ5WVQ4WVgxZWJMTWtrVHhsb3dRbmRK?=
 =?utf-8?B?dUNCYmJLM0U3dnVjTi9NTEVSRTJOMVpIa01IZ0pPcklUc1JRSHY0b1laOHE5?=
 =?utf-8?B?Q256UU45MElpd1pKWVBRTUFNLzU0TlRVcXNPK3YrSThOMDVTNlUrc1N3U0Jo?=
 =?utf-8?B?UFFVaWpmQUxEWHRPTGtQcC8vQmFXWDRhc2FQNkx5SVNFSlRCSDJkNWlxNTB5?=
 =?utf-8?B?RmVkZHFIVFdSZllnNjV4VWRIN3dZenR5WWcxOGhzZmZ2VkZzN3BCOTJmWVcv?=
 =?utf-8?B?NHltYWhLKzgxUElxR0hleXZrQjJnZGN5M09IYW9ZcWRnUmxwdUl5eVRrTUpU?=
 =?utf-8?B?dFNwM3pOakFWU1MvNVMvUWJCQjVNSmYvMzRVZTJaWEJzTjJIc2hubWJYZmhv?=
 =?utf-8?B?aEN4MWRWQ2pwaER2cHp6NlQ5VlJQVmNwaDNMcHBSR00rMWZxSktneUJlL0hB?=
 =?utf-8?B?Zm1JYXQvT3lpVDlKYVBBZURwR2phQ2tJdWlMUVRLMVNVVEY0REFVQWpvNG0y?=
 =?utf-8?B?K255VEQrSlpLcDRSUUdjTVlhdW5pRFJOWk1kYmNIYjVoaFhCbnZpK25DUkNI?=
 =?utf-8?B?K1hhK1p6VWpDSTFkeENFMFM1bXZLWisxTkxNOG84OWJMeVFMcWJqMm1nRkNG?=
 =?utf-8?B?aGU3b21yOENKNXNINFhidHFFY08wV0hBTi8yUnRUY0VBekFscFdyRkp1UDdG?=
 =?utf-8?B?d3Jod3hsTWRobThXRWhlOC9RVC9SdzA2WHNCWGlPTVloZkVRY2Q0cjVEZWxp?=
 =?utf-8?B?SDF3YVRDR3hHNzFaV3lucm96QXBkQm11MDhDOEdCZWl2bmhudjYvaHVWejN2?=
 =?utf-8?B?VWx4SThQOXREV0lscVZoVUZ6OUx1TUtHVCtEM0x1OXo5RjZJYjZDRk1ISm0z?=
 =?utf-8?B?S3ZXV2tITTYzL0daZnJIVnQ0WDh5MklsSUw5VkNjSk5uZXA3NE5xOW5Xb0Rp?=
 =?utf-8?B?L1RSd0tHeXdlWG5zUGx2ajVvcXU1NW5OWVVwRjBBR0RFRmVDUEwyWDNpbUgx?=
 =?utf-8?B?L1BRM0t0aEVHd1BtUlBFeXZXSnEvaUVoOGsvc3lRVk1OMVY0ekk2ZXVaN01u?=
 =?utf-8?B?bVM0VUMxTlB6WGoyNUFpV2JVNWJ5MnJzRzBzb2c0aDdFQWplNUZYY2ZGY1gy?=
 =?utf-8?B?UEJBTzJvZXJiNGFPTlhFdVg3TGc4eElSbGlGQ1JzTG0vOFhvVGd5c1V5ZmR3?=
 =?utf-8?B?cnQvVVJORXJpcnFmcVl3U2ViVklTUmt1bG15eFkzUm9wNUFqaG1pT3U1cGxF?=
 =?utf-8?B?MDJoSGRXVmlKbXB3Qy9nSElkakpwUkk0NXpPUVRFKzRKU2Y1YlFaZ2UxMTBU?=
 =?utf-8?B?cWQrd0VWYUk0c1VjTW1UNGVjQWlkNFViekZPbUJLampoa2RUR1hnNy9vWk9W?=
 =?utf-8?B?RzZZRUJ1eVZWTTY5cmpWS3llZ1FmM2xxMUIxSUJPSktWdElaOWgraDRQTDJB?=
 =?utf-8?B?MFRGVHZQdllUR3R2SXY2cGJiUjZKZkc0am5sNkdTQ05kNklLeU01dmN1OEg5?=
 =?utf-8?B?dDh0dTNZUE1ZaG9FQXh5TXY2YVBKWjJZZXM4RFZ2Yld4alpHVk13VCtRcjlQ?=
 =?utf-8?B?WHZyQ1kwUVYrdzUyeGQ1TU1WR1dDODRXbkxaWEc0L0xpVDhNZUluQ25jVzhv?=
 =?utf-8?B?eS9wdElHYUkvWXBmM0FXS0ZtN1RDWC9tYmJuV0pCaHBxbUd2Y2RPUkhWbVVE?=
 =?utf-8?B?dHpleXNPM1hDMVFlRDBYK082SXVnVlJNNkJBektJTWVYN3ZyY3dVMmwzYkVC?=
 =?utf-8?B?dThEZmU2NnNzZ2NXMG9PRGp3djFBdnl4bnBBb0JMNHVnUnBoMytQZklPRW4x?=
 =?utf-8?B?Ym52eTQ4bkNHUFhucmxDYlNMRDNtREQxMkgwWW9jVlppTUZIRUIwR2wrekh6?=
 =?utf-8?B?M2EweGdLQVhISUFZejJmZCtmVHRIaUpFTEk4ejUwVi9wcDVqdUZ6VUJwcXlF?=
 =?utf-8?B?VDh5bDZhRkFjYkYxY2VqSFQyeERzUzZFb1FyeHE1dFlmWjdBVEczUmI5R2ZO?=
 =?utf-8?Q?SlA3cvrh9onqgs7U=3D?=
X-Exchange-RoutingPolicyChecked: AELlQhu64xpIiSVQGDX+pN8ErSESHzYzkXRdFxVtqO3Vf8HV27Dxl4TaSL2+k408AIibDaoGWBVpUdMdkoOtZH0Yh1SDdmkYEo0lFNOY+SSnweRsZ7WXDwJp0zLNAkiUzNkPK35CD00C94HDpf4tYuYvIix5M+GGTroMEWIrCORDfjVDrIbWUD4QOXUj8Hirn9PPADgTcld8+uaMlZDjpCEsmqlyAySf15oV+nXm82noCeiy/SfIzofp9a8iqS8eyA7NllThpC4FN1pEE5jR8fkvGnFZOtxrrV06hJAR1NPwjeYp0lIa7pRhdxt2LaUHSJdWP6s0qdxpQQnihlpQ7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: d135829c-616f-45d4-a7f2-08df24521431
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 09:05:05.7320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtGQLmRJ7HqMRDyuLZ71GqLWVNRDZdtC+qqPm4+Vm53WGiMUZ1hTYVabs7UvzPUSyIJNIW/I19WPgUwqWhvt2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB727748
X-OriginatorOrg: intel.com

On 07/10/2026 10:03, Ian Ray wrote:
> Since commit 5a52c5701a67 ("mmc: core: Fix host controller programming
> for fixed driver type"), the eMMC driver strength is passed directly to
> mmc_set_driver_type(), which propagates the value through ios.drv_type
> all the way to sdhci_set_ios().  For value 4, SDHCI correctly warns:
> 
>   mmc2: invalid driver type, default to driver type B
> 
> The host driver type has no effect on this controller: esdhc_writew_le()
> never programs the driver-type field of SDHCI_HOST_CONTROL2.  Hook
> set_ios() and force drv_type to the always-valid Type B, so that SDHCI
> never sees an unsupported value.
> 
> Tested on i.MX8MP (usdhc3, eMMC in HS400) with
> `fixed-emmc-driver-type = <4>`: the warning is gone and the HS_TIMING
> register contains 0x43 as expected.
> 
> Fixes: 5a52c5701a67 ("mmc: core: Fix host controller programming for fixed driver type")
> Link: https://lore.kernel.org/all/20260926122908.866-1-ian.ray@gehealthcare.com/
> Cc: stable@vger.kernel.org
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v2 -> v3: Force drv_type to Type B unconditionally;
>           hook set_ios() for all esdhc variants, not only usdhc (since
>           the driver-type field is ignored in all variants);
>           reword comments.
> 
> v1 -> v2: Move fix from mmc core to sdhci-esdhc-imx driver per review
>           (see "Link:" above); always provide a valid host driver type.
> 
>  drivers/mmc/host/sdhci-esdhc-imx.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 6ab59d3e346f..931e383748a9 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1142,6 +1142,20 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
>  	}
>  }
>  
> +static void sdhci_esdhc_imx_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	/*
> +	 * This controller has no driver-type control: esdhc_writew_le()
> +	 * discards the driver-type field when writing SDHCI_HOST_CONTROL2.
> +	 * The programmed value is therefore irrelevant, but SDHCI rejects
> +	 * non-SD values such as 4 (eMMC 40 ohm, from fixed-emmc-driver-type).
> +	 * Force an always-valid Type B.
> +	 */
> +	ios->drv_type = MMC_SET_DRIVER_TYPE_B;
> +
> +	sdhci_set_ios(mmc, ios);
> +}
> +
>  static void usdhc_init_card(struct mmc_host *mmc, struct mmc_card *card)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> @@ -1952,6 +1966,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  		host->max_timeout_count = 0xF;
>  	}
>  
> +	/* No SDHCI driver type control */
> +	host->mmc_host_ops.set_ios = sdhci_esdhc_imx_set_ios;
> +
>  	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
>  		sdhci_esdhc_ops.platform_execute_tuning =
>  					esdhc_executing_tuning;

