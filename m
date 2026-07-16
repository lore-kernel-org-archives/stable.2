Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FC942465A;
	Thu, 16 Jul 2026 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208212; cv=fail; b=LCqko7GKPoI5+jVnqMxyryBVNfGjoUIRaInDjlXzYmXWhmEHnuzpBUHTg+IvuQ96vlZKMSNhY7QWqWiLhGexFQRHny/hq7b0pHDhOCrjD2NNj+W47JSq3CLsnmNCcPGdQOoFF2y0KQbo4WryZ0mhSthPB4SVnnkU39TMQuNsTQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208212; c=relaxed/simple;
	bh=jDqvW+3XmDcI9/W5FCNEyMJdOAjMqW5F1Us9w0G4T8A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U5w2ASfSCD/M18U817Zq/OWnGXqN3FoqanMSEHY/W8cn9ms4rHs7FMYqbhmobQxEwGMmXGz8W6leWFDtcapw7wmXtrOagcgtvYZdM2Tyd0hx5iI7vuHY0uUc8jRNO5xfVyKjrdj4/xUrcVhc8/5xQarrK9P6TA7v8e7vtJT2FIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTKtPqvS; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTKtPqvS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784208210; x=1815744210;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jDqvW+3XmDcI9/W5FCNEyMJdOAjMqW5F1Us9w0G4T8A=;
  b=FTKtPqvS+pGe742JTWMpZ+IPk3vqGXSs8uMvHiB7sJaM/pL9+1M99K0d
   /5TsjxCwiG0OMWlnPkZ9N/L67Kw68Ekze2Dd6PbRr2QeVGKCVAzjeOZ3Y
   iPTsrk+LAjf6XkEEzhYSs1FM9uJ/WV+6dSaapvdXh0xPGOz2Ht2IKresA
   JxKT9WKp7zHjXiDys/p9w4OhgB1OpMZfkN+WrNw2Ra7vrZu7Xq80tWFV6
   i+8a3mf6H/ZyYEgvZzopxEsXHCZKJLhaiyXfS7UcmKAm1W9oU1mG6NUmW
   TreFGUkxQZ9BEXTRUqOXh82W69naPJx149B4MXnDaOAaejN+jESpBKlSJ
   g==;
X-CSE-ConnectionGUID: xiBg2G1LRfOsSU+bXKjxTg==
X-CSE-MsgGUID: NIK1qANrSaC3dnj/LsUHEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="107663100"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="107663100"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 06:23:17 -0700
X-CSE-ConnectionGUID: UtG+EFbVRUWKheYl0PGflw==
X-CSE-MsgGUID: TfnTuwTUQDGoH5ECTWOnWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="260792705"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 06:23:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 06:23:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 06:23:17 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 06:23:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPSxQjT0nx1Nbk7v9IjzA50xB7PQWXzC2EehCv3FpE82fnLdKw5i/FJqJglKz22MDqW6scsNU8x0tqcw/1E0U/GjpkVx20IrCqPxTCI///ZKPBvJR6iHmBgeaTcUpDdOYWnlmIPWfVWnFRp8iK54fYKg+l13kKOd46kM7BNxaaAk45Z9O76LqyqqseUnZGfgwrTVcB4EPjRPffmVZYuirr/ip3s9xzwAaQREQFKEjGuJ4TU2Y3mUrgg7mFEfauE4OAX7pw3EvUx4zSBr2e2nEX7Xb64DAoI2DBGZT27q13NsNAPHavPV/BXNH4dYTiL+RXJEtQusVgGurViCYZccGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgdD5LOhoVKEQjud9APKc4cTwR72Yn3PloluoBjsWvc=;
 b=qcxFCCinm366r9K97HotB+MdvBk1SM/v7bB0zNaQak9INVfwybIDsBsuVKpzLhoRM/1KqbR4m3UoNfPypgBRT4iOfPgEnJXa8fcaw+TJ1ioK00NtH77jjMnXNkcuCNM3uIHfU28amYak8NrtX3lWfLeFT2cht07S5vucO1cd+GCcXWEwm5bKOfzieWS0C255yx0h6lJppR2+lFvenxvfuxYBdpVfaAYvJItf5Hr+NipJByN7BJxixDweKA0gBCPz5ZsSeCg6JXP5AE8w3kLCvqNbtaT9a712Lv9BetsMO+V4tCfS5d8+Vhj15IQIaVP5YpGCHCWwwIyTO/8PmjNQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13)
 by SN7PR11MB6559.namprd11.prod.outlook.com (2603:10b6:806:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Thu, 16 Jul
 2026 13:23:14 +0000
Received: from PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b]) by PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b%5]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 13:23:14 +0000
Message-ID: <868cab1f-f581-4a01-a9ea-b2fa1a7a2831@intel.com>
Date: Thu, 16 Jul 2026 18:53:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: REGRESSION: [PATCH] usb: typec: ucsi: Fix race condition and
 ordering in port unregistration
To: Andrei Kuchynski <akuchynski@chromium.org>
CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jameson Thies
	<jthies@google.com>, Benson Leung <bleung@chromium.org>,
	<linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Abhishek Pandit-Subedi
	<abhishekpandit@chromium.org>, Pooja Katiyar <pooja.katiyar@intel.com>,
	"Johan Hovold" <johan@kernel.org>, Hsin-Te Yuan <yuanhsinte@chromium.org>,
	"Myrrh Periwinkle" <myrrhperiwinkle@qtmlabs.xyz>, Linyu Yuan
	<quic_linyyuan@quicinc.com>, Jack Pham <quic_jackp@quicinc.com>,
	<stable@vger.kernel.org>
References: <20260707141736.1635698-1-akuchynski@chromium.org>
 <22064276-6c56-411a-9f20-6917ceeb865f@intel.com>
 <CAMMMRMduSMniMrixGuq=m=00nUvzXQpySE86TpmvfNQtAChB=w@mail.gmail.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <CAMMMRMduSMniMrixGuq=m=00nUvzXQpySE86TpmvfNQtAChB=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0204.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::16) To PH0PR11MB7636.namprd11.prod.outlook.com
 (2603:10b6:510:26f::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7636:EE_|SN7PR11MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 952b1635-f3b4-43fe-83a1-08dee33d63ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|4143699003|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: bq5PdXRfwbWcfvUK0/qox7U8pkrpH8LBCwwnSvG90RcpQe07vvh01y0lFgYfPNfigUY1a4ZNxvhsXBFGz5zjeC/jwdeYhD2X2kpxqJgKaY086PNH6Cl9e9hi4InHMrgdy20yOpiZfqjmIP6IgVGhj7Jg2QTh3ldFux2Zeps8Nu7pfmpJHd+uv9TYDI6h+/oFz22vO7oku/HlRZoUw+9UbOLZ4fvyFP9VvAZjsaBj2ZF5llUzViIffSCq+V0VDsVm/96PUUuh8pomWCz5zKZZ6l+JuQhY6IpnqvJbquDs7G+Q5VI0U+TOmp7YU3qGWvh1AJfvtccUanZ2LuffdVLWVB5560UbEJZsmZDsheIrtuAHBzBfwoAjA30HuwLYkUnNYUmSYNL5ypWQKJNb67RBw9ETW+fD7zSIlm6vcl3mjsmPZ/wtVM2AJfW9Liw8YDfxJ3E5RuZgRJuYIUTaj3hDGTWBjW+D3q8U+3nff1/sLdq5GI+Hi324Nj+fOh8RgY9oki+gBt0LX/ZXLQAJmSnTuTWOTJ23SB0TpUMrUeDF7F388H2ly7fJKz2VuaGFzNk3v7eMCZOT/KVRpS5PyeoxGl1+sbU5q16Fyek34mKvSMJfUGSd4WO10zKmwhJx8b6s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3B3V1MyTU41Qk94OU94Um80TElDUnBlUFJ6dDdzUUVEV0pGM3JkOElNZkR0?=
 =?utf-8?B?bEdmN0s3bVREWEtuaVZLOEIwZlJFanliSURCYlRMNjVIYU4yZmdqajI4RUQ4?=
 =?utf-8?B?WkhqMWJmblNNTkRCUzZMWW9rOUlUN1NqVkpOai9uT3E5aldFbmFxQ0tvdHcz?=
 =?utf-8?B?dEU4SWRtK1EvYVlQTXI0R2c2L2VkaVdPOW1wRVlnVGp5QXR1TTY3b1d3eDFy?=
 =?utf-8?B?NzBhNzNjcXBSOTVidlpUVDh5N1ZYUjYzVlI5K2ZhQVpDQ2MrQVNKZmN5b1pq?=
 =?utf-8?B?UHcvenRmZDczR3NEV1RpeDk1UXd0VTZNSEVhL2JjejRTaHY1NU03bWREenp2?=
 =?utf-8?B?WFZldTZxMTRub2lXSG5UQTZ1VnJ4NWN5cCs0eFBMa2luMXM0V05vUWxyZ3VZ?=
 =?utf-8?B?NkgvVlVtTlQzd0pkNnRLeWtLVmIzdkl2emdYYi9YeHNCTVV6czB4NkdHWjZu?=
 =?utf-8?B?bEJ4NHpVTHdKYzVYQXV5OTZqMHlGbUVSbFZtUTNmZ01mQzkrWG94SnBkV25X?=
 =?utf-8?B?VzVMV21sNHIveGJCWk9KS1M0anBCNmt4Tk53dEhzWE5JeDRyQ0twKzZRSHJK?=
 =?utf-8?B?SmhFS1pGLzNRaWgraFpqdmVBa3l3Qll5NUl3b2JEUGZUYTExWVRNcjR2TGxq?=
 =?utf-8?B?ZndKRHlVcmZkbTVxWFVNQ1dXZ091UlZPNGErMnRYdmF6dklTYUFGWVZsbnl5?=
 =?utf-8?B?NWhnVmMzdkg3OGI2NjFwSDNxWlJjVEVONzZ4ajJzZ0xqRUhKeU5LTzZObDIy?=
 =?utf-8?B?QmQxQjNwY3g3eTJVVGJLRjFkYWFBRytGT0hHQi92UUN6K2hQR3V5SEk0MW9u?=
 =?utf-8?B?RkV3Zk1tQUJHNkpkY2orMWZTLzBNYU50ZCtTWkg0QmhoNlc4aVBMS1E0TDNr?=
 =?utf-8?B?S1ZEd0RQQXBvRElRZUlSNy9RbUFIblRMRG43dVAydGg0Z2dmazVpOVRHc3Qz?=
 =?utf-8?B?VVArYVA0dHE0Rk5iTFRUYlE0NEVQSjhCQXhNUy9QR2FVN0lnZDFMU1FhM3NT?=
 =?utf-8?B?aDVnVnF6eGhFMXlLL3dQazhMaWxwMG0xNWh2bENZT1ZrQWxpM3RicGlYVmpE?=
 =?utf-8?B?R0poNER0WjFXNTE2bU52cHl6ZFNzWnBpRU4yeWxTZDhwbk1QZVROS2kvSGhM?=
 =?utf-8?B?VGp1dG1YT2tnRlVBU1J3RnpsbkZJay95RnVYYWpKcm5PaHVQbmpOSVZLWXIr?=
 =?utf-8?B?RXhPYWFFUU44aVdCeW1VZCtRSEI5UFVJZld4Y2ZkeFRGUnpMbE5PQmVrWklU?=
 =?utf-8?B?bGY1T1JTdEFaL2k0QnQxV2pTNkJobjVBUVNlZ3E1U0xHZitZNHBHcjcrbFpX?=
 =?utf-8?B?Vk5oWmVvMzBKU2hUUmlCbkVWLzVNOFRuUUErcC8zb2dVcjNpYjN6TlZSUVBZ?=
 =?utf-8?B?aHJhVG4yb04ydk9tN0tPTk9pd0gxc2F6TmFjak1kTENRNmh4S0dkanF4cU1y?=
 =?utf-8?B?VkRzRlZBb1VYTzJ2Q3V5TzU5UUdnTzFyUzVHQk9NT1ZFZGtkZXM2LzlVUWRz?=
 =?utf-8?B?TUZIQk9LTTB3cE4xWnppVWtsb0ZIR282N3hWcms5OStuMmlFZ2FNRzNEMFpj?=
 =?utf-8?B?MGVpRU5IL1RKT0FSQytEaG4xRmROZVJuLzZBQzMyNUNmTjhzQWtXRmpRRkg1?=
 =?utf-8?B?MEhIUzM2a2ZINDJtb2dwamF6VFpLQXpZUitqOGpqR3lBbytzbUpuRVNEZU9G?=
 =?utf-8?B?UVd2UE5ENjd3SHR5S2hiRDdZVnRGN2F5dVNOVTVyN3l4TGpNRWEzd0xieDhm?=
 =?utf-8?B?bFBnVjdLVXcxMTRhVmZ5b01WVWZJT2ZLZVZ0UFUzTkllM1pJL1JhaXNCR3Rr?=
 =?utf-8?B?NVc5UGZyTGcrMGEzb3d3UTNlNHJxeHhqVWV0VWVYZzY3ZGpEc1NVUkVTc2pG?=
 =?utf-8?B?UnpRUUxnY2R6Y2hWNTBLWm5oT2Z3ZzBhclFTaWlsUk1yM3VWa3gwY2JqR2k2?=
 =?utf-8?B?TkQyci8zSVozREdnQ0xidURqNTVsOFM5bjJMQ1lQN0J1R2tPRjV4MnZnOXVU?=
 =?utf-8?B?MjNSSHRmZW9hRlM4U2crM3RUNk1YUnc4QmxvaXRBWXdzMUw5NU1NWVJXQjVV?=
 =?utf-8?B?ODNYcUhjb2NlK1kyNUhjRGhSZG9YNHpydWxvalZSdU5VdUJKeW9jNWdSamRE?=
 =?utf-8?B?M3VCazZvOHhYTjJvYVQ4UjNVUzhzNWwvOGhoRndjOUhoWEtrdDJReFdOWDBZ?=
 =?utf-8?B?MENnc3NXUTRoU2ljMXJpT2w0MEE3RVh3dE5zUUprSHZlcU5odHhnNUFIcDZP?=
 =?utf-8?B?andxdWVIQTlWQTBRU1RNRUpIZ3h0VnFlbDBwSFhOYUpyckk4Tk1qaEYrVDJ4?=
 =?utf-8?B?K0FjZGhoUW5VQXN0S1ZVYkx4UUJpeDNYSHFNNXh0WFYwci9tR3FESHQ5OUhj?=
 =?utf-8?Q?s1dgKZPEeyE0ch8k=3D?=
X-Exchange-RoutingPolicyChecked: i72XVFWm7MJ+BDQLjRXYQ0lH4RbN9SmuBlc2KdWzlc3oITavVXpo1LxoVWm2Zvf4WlIyeR0e9SzJuHHimHyNtFxi7kneTcfhEqw5pYA9lnYLi6l+QICO19uAijINYWVDczgwUgJgg51Ts4lTSBLntRfj/J+VJ8W5jHSE9zWWAfhkl/fJPjRg/tbCbE/wPD1tzeCn1PNPLELx1Uf3ZpA+Ake2WgJUK4CKdQj6UadarcoROT5j6aTbUakvPulYqu9jx3Z2it3aSEVisq4pl979XE4D7yTSA09A8Qx1CzCV07eSY2Hsv/hEayOgHcjpOds3GHbs2g60xRYqaend/ggyhw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 952b1635-f3b4-43fe-83a1-08dee33d63ba
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:23:14.2180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/BowlZjWWcNIwkpnSHSJ9vR5w4DNeMkuKvCwfrD8EhnAj4kv9RXw90/eolEpi/4wTXjiYqGO3JlhIR2PUXdGUr8koATBgqwDv1mvh0AlI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6559
X-OriginatorOrg: intel.com



On 7/16/2026 2:45 PM, Andrei Kuchynski wrote:
> On Thu, Jul 16, 2026 at 10:28 AM Borah, Chaitanya Kumar
> <chaitanya.kumar.borah@intel.com> wrote:
>>
>> Hello Andrei,
>>
>> On 7/7/2026 7:47 PM, Andrei Kuchynski wrote:
>>> A synchronization issue exists during port unregistration where pending
>>> partner work items can race against workqueue destruction, leading to
>>> use-after-free conditions:
>>>
>>>     cros_ec_ucsi cros_ec_ucsi.3.auto: error -ETIMEDOUT: PPM init failed
>>>     BUG: kernel NULL pointer dereference, address: 0000000000000000
>>>     RIP: 0010:__queue_work+0x83/0x4a0
>>>     Call Trace:
>>>       <IRQ>
>>>       __cfi_delayed_work_timer_fn+0x10/0x10
>>>       run_timer_softirq+0x3b6/0xbd0
>>>       sched_clock_cpu+0xc/0x110
>>>       irq_exit_rcu+0x18d/0x330
>>>       fred_sysvec_apic_timer_interrupt+0x5e/0x80
>>>
>>> Fix this by ensuring strict ordering and proper serialization during
>>> teardown:
>>>
>>> 1. Move ucsi_unregister_partner() to the beginning of the teardown
>>> sequence and protect it under the connector mutex lock.
>>> 2. Ensure all pending partner tasks are explicitly flushed and finished
>>> before the workqueue is destroyed.
>>> 3. Switch from mod_delayed_work() to a cancel_delayed_work() and
>>> queue_delayed_work() sequence. This guarantees that items currently marked
>>> as pending won't be scheduled an additional time, preventing a double
>>> release of resources which leads to the following crash:
>>>
>>>     Oops: general protection fault, probably for non-canonical address
>>>       0xdead000000000122: 0000 [#1] SMP NOPTI
>>>     Workqueue: cros_ec_ucsi.3.auto-con2 ucsi_poll_worker
>>>     RIP: 0010:ucsi_poll_worker+0x65/0x1e0
>>>     Call Trace:
>>>     <TASK>
>>>       process_scheduled_works+0x218/0x6d0
>>>       worker_thread+0x188/0x3f0
>>>       __cfi_worker_thread+0x10/0x10
>>>       kthread+0x226/0x2a0
>>>
>>> To ensure these rules are applied identically across both the normal
>>> teardown and the ucsi_init() error paths, consolidate the cleanup logic
>>> into a new helper, ucsi_unregister_port().
>>
>>
>> This seems to be causing regression in our linux-next CI. [1]
>>
>> <6>[   18.008557] ------------[ cut here ]------------
>> <4>[   18.013166] DEBUG_LOCKS_WARN_ON(1)
>> <4>[   18.013167] WARNING: kernel/locking/lockdep.c:238 at
>> __lock_acquire+0xa59/0x2750, CPU#1: kworker/u89:1/172
>> ...
>> <4>[   18.159950] Hardware name: Intel Corporation Meteor Lake Client
>> Platform/MTL-P DDR5 SODIMM SBS RVP, BIOS
>> MTLPFWI1.R00.3471.D89.2401091901 01/09/2024
>> <4>[   18.173125] Workqueue: events_dfl_long ucsi_init_work [typec_ucsi]
>> <4>[   18.179257] RIP: 0010:__lock_acquire+0xa60/0x2750
>> <4>[   18.183927] Code: 44 8b 5d a8 85 c0 0f 84 98 fd ff ff 44 8b 35 07
>> 0b 72 02 45 85 f6 0f 85 88 fd ff ff 48 8d 3d 27 25 73 02 48 c7 c6 1b 51
>> 27 83 <67> 48 0f b9 3a 31 c0 44 8b 5d a8 44 8b 4d b0 e9 c6 f7 ff ff 31 d2
>> ...
>> <4>[   18.263886] PKRU: 55555554
>> <4>[   18.266583] Call Trace:
>> <4>[   18.269014]  <TASK>
>> <4>[   18.271110]  ? mark_held_locks+0x46/0x90
>> <4>[   18.275007]  lock_acquire+0xd9/0x2e0
>> <4>[   18.278562]  ? ucsi_unregister_port+0x36/0x140 [typec_ucsi]
>> <4>[   18.284096]  __mutex_lock+0xb2/0x1020
>> <4>[   18.287735]  ? ucsi_unregister_port+0x36/0x140 [typec_ucsi]
>> <4>[   18.293265]  ? ucsi_unregister_port+0x36/0x140 [typec_ucsi]
>> <4>[   18.298797]  ? synchronize_rcu_expedited+0x2b2/0x300
>> <4>[   18.303724]  ? __pfx_autoremove_wake_function+0x10/0x10
>> <4>[   18.308912]  mutex_lock_nested+0x1b/0x30
>> <4>[   18.312806]  ? mutex_lock_nested+0x1b/0x30
>> <4>[   18.316878]  ucsi_unregister_port+0x36/0x140 [typec_ucsi]
>> <4>[   18.322238]  ucsi_init_work+0x66d/0xc10 [typec_ucsi]
>> <4>[   18.327167]  process_one_work+0x2ad/0x8b0
>> <4>[   18.331158]  worker_thread+0x200/0x3f0
>> <4>[   18.334886]  ? __pfx_worker_thread+0x10/0x10
>> <4>[   18.339128]  kthread+0x10d/0x150
>> <4>[   18.342339]  ? __pfx_kthread+0x10/0x10
>> <4>[   18.346067]  ret_from_fork+0x3bd/0x470
>> <4>[   18.349795]  ? __pfx_kthread+0x10/0x10
>> <4>[   18.353522]  ret_from_fork_asm+0x1a/0x30
>> <4>[   18.357420]  </TASK>
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
>> [2]
>> https://intel-gfx-ci.01.org/tree/linux-next/next-20260714/bat-mtlp-9/boot0.txt
>>
>> -- Bisect Logs --
>>
>> git bisect start
>> # status: waiting for both good and bad commits
>> # good: [5f1b513690edf51727e6928b97705b6437f9a98e] Merge remote-tracking
>> branch 'spi/for-7.3' into spi-next
>> git bisect good 5f1b513690edf51727e6928b97705b6437f9a98e
>> # status: waiting for bad commit, 1 good commit known
>> # bad: [49362394dad7df66c274c867a271394c10ca2bb8] Add linux-next
>> specific files for 20260713
>> git bisect bad 49362394dad7df66c274c867a271394c10ca2bb8
>> # bad: [dffddeb046466ed57038295bde28b42b7506a12b] Merge branch
>> 'nand/next' of https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
>> git bisect bad dffddeb046466ed57038295bde28b42b7506a12b
>> # bad: [d154d0766bf3fe830e1bf98fb2d8648294a4a8da] Merge branch
>> 'for-next' of
>> https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git
>> git bisect bad d154d0766bf3fe830e1bf98fb2d8648294a4a8da
>> # bad: [671b0fd929bec9ebf863cb376baf9b9d1226a510] Merge branch 'master'
>> of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
>> git bisect bad 671b0fd929bec9ebf863cb376baf9b9d1226a510
>> # good: [f4fb100039e96211609dfc44fb24b9e4a8a0f2f9] Merge tag
>> 's390-7.2-4' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
>> git bisect good f4fb100039e96211609dfc44fb24b9e4a8a0f2f9
>> # good: [c296d513e034df93ddb230ad1c7a118d6b58750c] Merge branch
>> 'arm/fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
>> git bisect good c296d513e034df93ddb230ad1c7a118d6b58750c
>> # good: [de53c0a584f08f31eb957f8c849a59fb33b27fa8] Merge branch 'for-rc'
>> of https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
>> git bisect good de53c0a584f08f31eb957f8c849a59fb33b27fa8
>> # bad: [a6969de5a038bc08a948ada52bd7199a8dfa6cec] Merge branch
>> 'usb-linus' of
>> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
>> git bisect bad a6969de5a038bc08a948ada52bd7199a8dfa6cec
>> # good: [15eab2dd63a97587405ab6bfaad9728d5b35b5fe] Merge tag
>> 'asoc-fix-v7.2-rc2' of
>> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus
>> git bisect good 15eab2dd63a97587405ab6bfaad9728d5b35b5fe
>> # bad: [c2e819be6a5c7f34344926b4bd7e3dfca58cf48a] usb: gadget: printer:
>> fix infinite loop in printer_read()
>> git bisect bad c2e819be6a5c7f34344926b4bd7e3dfca58cf48a
>> # good: [29a142d3e8b35ebc9e0bcc78f4bc26c9b6a9ac0b] USB: gadget:
>> snps-udc: fix device name leak on probe failure
>> git bisect good 29a142d3e8b35ebc9e0bcc78f4bc26c9b6a9ac0b
>> # good: [1febec7e47cdcd01f43fb0211094e3010474666e] usb: gadget: f_ncm:
>> validate datagram bounds in ncm_unwrap_ntb()
>> git bisect good 1febec7e47cdcd01f43fb0211094e3010474666e
>> # bad: [0583f2fbf8f86ae3a0ce054f96783dd83e65d9bb] usb: gadget: udc: bdc:
>> free IRQ and drain func_wake_notify before teardown
>> git bisect bad 0583f2fbf8f86ae3a0ce054f96783dd83e65d9bb
>> # bad: [7aa7d4bf9d3fa9a6a47b640ad103ab433b7ff261] usb: typec: ucsi: Fix
>> race condition and ordering in port unregistration
>> git bisect bad 7aa7d4bf9d3fa9a6a47b640ad103ab433b7ff261
>> # first bad commit: [7aa7d4bf9d3fa9a6a47b640ad103ab433b7ff261] usb:
>> typec: ucsi: Fix race condition and ordering in port unregistration
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partner tasks like alt mode checking")
>>> Fixes: b13abcb7ddd8 ("usb: typec: ucsi: Fix NULL pointer access")
>>> Fixes: fac4b8633fd6 ("usb: ucsi: Ensure connector delayed work items are flushed")
>>> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
>>> ---
>>>    drivers/usb/typec/ucsi/ucsi.c | 82 +++++++++++++++++------------------
>>>    1 file changed, 39 insertions(+), 43 deletions(-)
>>>
>>> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
>>> index 92166a3725b16..d9668ed7c80ea 100644
>>> --- a/drivers/usb/typec/ucsi/ucsi.c
>>> +++ b/drivers/usb/typec/ucsi/ucsi.c
>>> @@ -1845,6 +1845,42 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>>>        return ret;
>>>    }
>>>
>>> +static void ucsi_unregister_port(struct ucsi_connector *con)
>>> +{
>>> +     struct ucsi_work *uwork;
>>> +
>>> +     if (con->wq) {
>>> +             mutex_lock(&con->lock);
>>> +             ucsi_unregister_partner(con);
>>> +             /*
>>> +              * queue delayed items immediately so they can execute
>>> +              * and free themselves before the wq is destroyed
>>> +              */
>>> +             list_for_each_entry(uwork, &con->partner_tasks, node) {
>>> +                     if (cancel_delayed_work(&uwork->work))
>>> +                             queue_delayed_work(con->wq, &uwork->work, 0);
>>> +             }
>>> +             mutex_unlock(&con->lock);
>>> +
>>> +             destroy_workqueue(con->wq);
>>> +             con->wq = NULL;
>>> +     } else {
>>> +             ucsi_unregister_partner(con);
>>> +     }
>>> +
>>> +     ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
>>> +     ucsi_unregister_port_psy(con);
>>> +
>>> +     usb_power_delivery_unregister_capabilities(con->port_sink_caps);
>>> +     con->port_sink_caps = NULL;
>>> +     usb_power_delivery_unregister_capabilities(con->port_source_caps);
>>> +     con->port_source_caps = NULL;
>>> +     usb_power_delivery_unregister(con->pd);
>>> +     con->pd = NULL;
>>> +     typec_unregister_port(con->port);
>>> +     con->port = NULL;
>>> +}
>>> +
>>>    static u64 ucsi_get_supported_notifications(struct ucsi *ucsi)
>>>    {
>>>        u16 features = ucsi->cap.features;
>>> @@ -1971,22 +2007,8 @@ static int ucsi_init(struct ucsi *ucsi)
>>>        for (i = 0; i < ucsi->cap.num_connectors; i++)
>>>                lockdep_unregister_key(&connector[i].lock_key);
>>>
>>> -     for (con = connector; con->port; con++) {
>>> -             if (con->wq)
>>> -                     destroy_workqueue(con->wq);
>>> -             ucsi_unregister_partner(con);
>>> -             ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
>>> -             ucsi_unregister_port_psy(con);
>>> -
>>> -             usb_power_delivery_unregister_capabilities(con->port_sink_caps);
>>> -             con->port_sink_caps = NULL;
>>> -             usb_power_delivery_unregister_capabilities(con->port_source_caps);
>>> -             con->port_source_caps = NULL;
>>> -             usb_power_delivery_unregister(con->pd);
>>> -             con->pd = NULL;
>>> -             typec_unregister_port(con->port);
>>> -             con->port = NULL;
>>> -     }
>>> +     for (con = connector; con->port; con++)
>>> +             ucsi_unregister_port(con);
> 
> Hi Chaitanya,
> Thank you for spotting this!
> 
> Could you verify if calling lockdep_unregister_key(&connector[i].lock_key)
> after ucsi_unregister_port(con) resolves the issue?
> 
>       for (con = connector; con->port; con++)
>              ucsi_unregister_port(con);
>       for (i = 0; i < ucsi->cap.num_connectors; i++)
>                 lockdep_unregister_key(&connector[i].lock_key);
> 
> I will also try testing this on my side.

Thank you Andrei for the patch. It seems to work for us.

==
Chaitanya

> 
> Thanks,
> Andrei

