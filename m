Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4228247DF87;
	Wed,  2 Sep 2026 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354720; cv=fail; b=ZKy4hxeqfGpDAPyayif+hy61jznv0P9gy7nhis0/aTYx+Krfc8dv1aOFc9RuLV5xd+4PJLeFbEW5FixRwcxezOksl2aNXz+J+iHI5QgyB4mGbHS9vXkKk8c9Njgs9tXCax+RcLGFE2OgrVqx4ViQp/81oHd5rqtIwT5W7yTKA8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354720; c=relaxed/simple;
	bh=PB7jm3+XXkGTO2S4P6Mc2HX2mcIbfehDj/YBGsWZrb0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eZAhq7CNJzXDAu4XPwfiJkZVzLAP2KwJwPYrKf+94bhwyz2lq7UphGAMvtyPilykNA1sY49bszyM1BxKUHgan5obOuJvZ3OJtQ+1EuKzBImK2cLPWfW1ca1qy0DdDOlXxu5+BTzVu7heES3qv7uZvSIS8kHa2+cqWcJf2fUT5fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbrqpQFf; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbrqpQFf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788354718; x=1819890718;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PB7jm3+XXkGTO2S4P6Mc2HX2mcIbfehDj/YBGsWZrb0=;
  b=nbrqpQFfKQwtIDxJE6DrYISFaDZINiBzOzPpxuXzWKUyKqnYK09rzjDs
   tSzZeBNmsGk/CHTRG8D7rJD00iWE/yC37ob7/2d59xbsRRGhpvAKW7xPL
   ZtuEfnHRHAS9rIbnfKAjugJIqZu13dhHGlcbdf7pXPeGN9b1yCPFcdkwb
   AhnhOounPi966GJThGQKeSq7eEUR2mFzDtllLiMM78tnPQr7+QLLOko1y
   dBIn5A7gBIKT935kiAnER580CA6IKxuVx14fhglpXwYp9eCpKnAUBpl3b
   15vhYtY81KEviprIPo3GXl3ZAIbo/mXtM428nsBKnRPAJvysSNd8qyzNV
   Q==;
X-CSE-ConnectionGUID: ecAQ0NA9R+2RyCz8sCzHSw==
X-CSE-MsgGUID: QVtxZje8Qciy0ELPkXir9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="76362243"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="76362243"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 06:11:57 -0700
X-CSE-ConnectionGUID: 225vupTXRoyv4yXEDZ2+Ng==
X-CSE-MsgGUID: 8IucRSMWS8u9oyzArwoiMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="274675674"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 06:11:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 06:11:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 06:11:56 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.27) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 06:11:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brYMuIKUjB6525o+gyGZXZ1fLxaq2P5jco0NN+SAdfbbZpRxtLbju5R0JjfpOSGkZpZIkFn8JSRkWAuMWy2GZ9EK73O2rcN6yxggrhY0oPgCFXTLLRRY7M6LMpOi27VZ7DQpGqgHJZF9VYYTNhxzpG5pA/pVQUt39HIlRN02XSfLf9KIHFJZJhBj6t5G9jF+L9wPkCAt1Rnbu/MvD1unUDz3OAoMEVP2m9WWIpSn5BBaoDALO4UiBy2h1SZaCh6QT+BdpLkkBRKhcJmvNaPH/x1KJbp+HHRzINOEA8WJ/XgumuOXLqH0ljrDZJ+dXul/JE1EnPvqeXW2rD6G4IkYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b95cyBSxaPkah5m4FFfetGuyEvqzR+zS7cZIoke7TbU=;
 b=h/UTEu6hwoX+Sh6QwiXT0eoEm+arNfF6adGbahkvRVBNMYJxfdm9HYLVSxOY6gf7Zoiy0C2gUvMd29II9TaEclK5Y4dTACrm8WrG0zf/Yw8Zlkfx5ed/1EBAuVrPeQgAF1zOXQaJahrKJymNkXNgbVBkvDvjQ8iBWh6GxgKBXX9RlU2Xe+v4sltyJa0ACmNBf9SazhzxZHECRIPhA8yZYiohhTH+O7K6MvKNRklQL9Enp8I9UyHJsZmuaJI4gxuV549ldJdFy+L8T+fF0BTdrsOeRrLRuN+WQSL5nVZqTTsB4Gw/76l4dBfzVlNhekkzW9TGiy9zBKQYDogNuwwusQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SA1PR11MB6870.namprd11.prod.outlook.com (2603:10b6:806:2b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:11:47 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 13:11:47 +0000
Message-ID: <d035139c-6b37-46f3-baff-a27d0f1a082e@intel.com>
Date: Wed, 2 Sep 2026 06:11:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] x86/microcode/intel: Reject problematic loading on
 GNR systems
Content-Language: en-US
To: "Chang S. Bae" <chang.seok.bae@intel.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <andrew.cooper3@citrix.com>,
	<arjan.van.de.ven@intel.com>, <stable@vger.kernel.org>
References: <20260901231634.714144-1-chang.seok.bae@intel.com>
 <20260901231634.714144-2-chang.seok.bae@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260901231634.714144-2-chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::21) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SA1PR11MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: bd478984-b0b9-45e0-6816-08df08f3be40
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: WxWZj8Sk2oTS1Wqvp7LTfK869r7W/tv1oKpQzVKWqzmFP+DpN0Lmkm0LVDhzwdAvEYIuuxkFaQbK157bCww9XL4R2x/J3dcc7srDelMr+hIoPHFWSLVdf4ANwUH9K905dP5eTfUTtplSQvxrWc1ynhBJ66L5BLIyvCY7FZZ+oE3qMALIBWHWEuQt22DrIazJ3QonLr50qv8Y8mjAqNY7blXcT+91qN1UbqEKUBx4zw6BE8RkexDFeP+mweA/jLQmsxuV4ZtIhmOu2sHalw91L8160ZpM9CVLsfuRbnuuCW/0qXNZ5HK4qm5M1MjV6fo4mf2pjMG9JklGn30ae0QRvRYwr6Lmh2kHzwmR8IQXZaj39+oY5fkmWZlhobzgq/1o5sEL0/rcsoky5Otkn+rnrDLukg1kk/pStpS58JDtIxfVGTruVwTK5Xxj6oh//Kasb2stFkC2yoCDS1BzdG5YYXWPpVUf6pBqlIDtu/SBc3UwzG0dPbLcvn78z9ov/gV22LCONaH2cnKZUPAMxZX/CXF64ZJa+uQBX6S44IeX9tP6fpH9GEITmDodiiscAbBjLt8oJCUKR7UYHvZ8sdkubtsNBhprYp7D1VJjF5icCs/pGyQeTKpI/lt8IO6mfX8QsK8yWZnF//vxkAgEQ2k1e5uEfNtqdDfArq4Ru+Bm590=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHhTQnpBQ0tsZXFnamJoQ09SNG10c3owMDM5emRPanZpejhWQW5adFpZbTRL?=
 =?utf-8?B?ZTZxSlNOczBpaUlhbXlxb3BvcklxU0c5Si9CMDFVMy9zcUFFODRac3dtdDZ6?=
 =?utf-8?B?TnNmbHVBV2N3ejJrbnYwNHBTY0ZTbWZvSUw3TDlvb1RsbkZjNWJuRU5RaVU4?=
 =?utf-8?B?VGVvM0lJYVl5NEhoajEwTkw3c0dXclNvbjE3UnpnUFBwQk9uaDk2djFTcEpq?=
 =?utf-8?B?ZGYxYXE2bUpucUp5TXE3c1NHanF5cWVsYjRObXZjald6RkpBS3RwUGJ1OEUz?=
 =?utf-8?B?RFBUN2I2Znp4Z05zTEdURGlTR1FocTR4NG9ncU1WaThaZjBjV0s2T2lqR3Z1?=
 =?utf-8?B?TncwRDhkcjBUNG1BL2ZkSzg5U1prTUJ0MXlPcXhpSXlWekt6QTlvZ3JLM2dZ?=
 =?utf-8?B?WE96WWVHMWN5bE9CN1RTZUhsaEN3blRKaXVKYk9NRGpLakpiYklDR0cwWEl0?=
 =?utf-8?B?TFFQcGc3UHBVUGxvdlZ4OGxaMkdXUjJQbkJKMGdJSk40dTc0TG50dnpkMkVK?=
 =?utf-8?B?SjhVUk9QZHI3YUI1QXlZTmwxbTZya2V2QWVkOUlSSisvMXlWUGprT0oxMzQ4?=
 =?utf-8?B?bWZlZjF4cnB2dGZRT0tkNUxVdGNxRDBqcjZUL2tVMmVxR2VheEgrUFk1NUQy?=
 =?utf-8?B?OVRpVjBJU1cxOXd4RXkvOGp1ZzgrQ3BHNGlWZFhidGtqSWtQN2lOcTRhcVh5?=
 =?utf-8?B?UnpkdFBqQy9HVy9mR0ZrMUhabkJUdGdMYityaWcvZUpveFFoTWVIL1luampp?=
 =?utf-8?B?R2VmU1l1QUlVM1B3OWtWRjQvUDNXb29melh5cktVbjZqbWNqd2l6T2pKMFI5?=
 =?utf-8?B?MHhtS0tLZ1RsRDNkNWtwa0ZGQnVJMGNEVFMwRW1aYVRuMVFsVG13aGY4V0xQ?=
 =?utf-8?B?ZVAzQzZ6YnFWZ0J6N2xmQVJaeHk5REZldUs4ckVoSlV4dGl3YkoxUnZYN254?=
 =?utf-8?B?dU15TjNNUWRCSDVtZ3Q2NFVJOHdJUHhSOVZHUDNZUTYwL2JWTDNhUm5laXZG?=
 =?utf-8?B?cWxaQWIvZFg1elV1cWFjTlBuVzdqN2ttNTVDdGpFVzAvL01KNWtKbDlwczRP?=
 =?utf-8?B?QXRuNVJFdDUrRjRBTE9pVWN0WEpWVkhTY3FOZ0o3bkd1a3YydGh6Z0kvSno3?=
 =?utf-8?B?Q1MxTWdYdnpJUGFWRzkxR0F1M29PV29kV21yYzV2NEZlWVA3NUZoTEQzUUY2?=
 =?utf-8?B?TWdXSGZKWU1Oc0R6bWxBSTI0MXZJVGJROEVQOGV1ZWljL3BKMWppVStOODFK?=
 =?utf-8?B?Q3FrUWo1WkphZTNacnhSZDZVS1pYVEZYNEpQMzZxZ1VxOEFGVTJLUnEySVZx?=
 =?utf-8?B?MitjVHUrME9od1NEa3h1VGdCU3JscDNTWERGSnVKVWZBTDNvYWhCOThZQkM0?=
 =?utf-8?B?QSs0Z1RQcmx5RkxremRidk93M1NqSkMwVkF4Ylk4cVgxTXpiN1VPSDd0ZXdm?=
 =?utf-8?B?NjJzc1pYOXNqdVdnOTZBdjRqZUFEQWdPK3lzMW1rM3U5VWhaWEJhRDNZRmMy?=
 =?utf-8?B?L29hYWp3ZWh5TFRvOHFRZ1FZeVQ0Ymhhc0h4UU0ydnM0M1dkUUsyb052VEsy?=
 =?utf-8?B?RFJxYXExN2xFK1ZoVjFHYnpqZG9LQTlhZVBOZUhubG5GMnhjMXRrT2ozL3lM?=
 =?utf-8?B?Ym9wTXNmMjlETWRHaFQrWTN3M0VmRnc0R0c3SjFaQlpnSVFIRDAzR2FWa3pt?=
 =?utf-8?B?N1lJUnBDQkh0VzJpNWN1NnN6WGxHMGdpV2tWaHRsWDVaN1NDa2Y4WVprQVFC?=
 =?utf-8?B?bFU0VTMwSWtkbnBsOFN0bHlrTnBNYUNhMEFSWGlJMXJhL3JsRGNyYmJBdFBG?=
 =?utf-8?B?SWo1VHZibGVqeFQ0bTZLdkY3L2dsT210SmQ5NmdFN0oxSDB4OXAwaHBmcG0v?=
 =?utf-8?B?UFNva0RlNFIxSjRIVC9IYzdaT0YzTzkyNVNkYmtUYjAyUXdEKzdJQ3lYR3BR?=
 =?utf-8?B?TElXamwxb0JqMDBaMTBrSThoWjJMQlB4d3VVelZNZmRTVEJkOThSOGhnVXpI?=
 =?utf-8?B?Z29UQmJmdFFXNlBIVndSSThCSmc0eEJFWFp1cWlhcTNHS2RIdE9rNGllcUZC?=
 =?utf-8?B?ZlVmNjR0b0xUajdMcGpXTTU2bTBVajhNR0NqaWpTdTcvVDd5YXRZa3grTTVT?=
 =?utf-8?B?R1g1dC9xOEt5dzdYR3BtWnBhK2p0d0N2UzdIazBJTVU5ZVNsc1ZCck5aVWZU?=
 =?utf-8?B?anRVaThNdE1vREhza1AwenpPRGFsbmxYT3NucEk2VDVHdUF0SlFmSjJWd1pF?=
 =?utf-8?B?eTErVm91OWVnbDFJRWtVeXpjeFkrNm82aUgvSHBxNTVGVjdTY29Sdm9XNUc3?=
 =?utf-8?B?STkxNERFcnBZVWhZdFd3Z3luK3JzYkxka1pVM1ZEc0t5T3hXeEhFQT09?=
X-Exchange-RoutingPolicyChecked: UCMwuagXgN7q3XMiFYvHepyZJxhLW96x+H7l1WUg4o545/nlBm8SBZPlyXZpfThF+eNx6f/y2g1/5a3mhWYUjDfh3wam/OK8oc15x6d6wfCoZuP//y9rZRSfxH+tr6XQNz6/PEW4e8M5f+QuO+iyn8oayjAKvjMQiVLa9umTvkK4W+5mjK0k1D9xI5XKf0IjCR8xUBMPF5IzsMEFYK1naiei6VTh+m7uyxvtefviggD0vsFnwq7pxPVuJnRsyehOhnatiipf04tuQWxbGRZlimmMIVfNrTJ7OL1IV8sLsVTgw7aPLu2dY98IbFCmx3uvVN9Pl6/6ds0ioahOYb7bPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: bd478984-b0b9-45e0-6816-08df08f3be40
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:11:47.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bkq8RhNLLv20gaOT+VjujZJ1KD/llUWDKVKOrj08fuFNxaWUyjjIF0MkXCHsnBY+ltzNGFihCvq9vNhIW82y5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6870
X-OriginatorOrg: intel.com

On 9/1/2026 4:16 PM, Chang S. Bae wrote:
> Revision 0x1000405 contains internal microcode changes that are required
> by subsequent revisions to avoid #MC during loading. 

Before going to the solution space, can we add some more
context/background here?

For example:

GNR revision 0x1000405 introduces a breaking change that causes a #MC
when the OS updates the microcode from any version older than 0x1000405
to a newer version. This is applicable to late load as well as early
loading during boot.

A BIOS or firmware update is required to update the revision to
0x1000405 or newer before any OS updates can be safely loaded.
This dependency ...

> This dependency logically fits the minimum revision requirement.
> 
> The minimum revision check, however, currently applies only to the late
> loading path, since the dependency was primarily intended for OS-visible
> changes. The early loading path is therefore still vulnerable to this
> issue.
> 
> Furthermore, one of the subsequent revisions does not correctly specify
> the minimum revision, so unfortunately the late loading cannot rely on
> that check either in this case.
> 
> Prevent loading 0x1000405 or later when the system has not yet been
> updated to 0x1000405 or later. 

This is a bit confusing. Should it say jumping from any anything older
than 0x1000405 to anything newer?

> Apply this blocking to both early- and late-loading paths.
> 

> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 1142183c950c..c502138fd8e9 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -309,6 +309,38 @@ static void save_microcode_patch(struct microcode_intel *patch)
>  		pr_err("Unable to allocate microcode memory size: %u\n", size);
>  }
>  
> +static bool is_loading_denied(struct cpu_signature *sig, u32 rev)
> +{
> +	u32 vfm = IFM(x86_family(sig->sig), x86_model(sig->sig));
> +
> +	/*
> +	 * Revision 0x1000405 contains prerequisite changes for subsequent
> +	 * microcode updates on Granite Rapids systems. Updates directly from
> +	 * an older revision to this or a newer one can result in #MC (GNR98).
> +	 *
> +	 * This dependency can be indicated from the minimum revision field.
> +	 * However, revision 0x1000423 has an incorrect minimum revision in its
> +	 * header (GNR101).
> +	 *
> +	 * Prevent loading 0x1000405 or later unless the CPU has already been
> +	 * updated to 0x1000405 or later.
> +	 */
> +	if (vfm == INTEL_GRANITERAPIDS_X &&
> +	    x86_stepping(sig->sig) == 1 &&
> +	    sig->pf & 0x95 &&
> +	    sig->rev < 0x1000405 &&
> +	    rev >= 0x1000405) {

I don't think we have a helper that can be used here directly. Also,
this is tagged for stable so adding a new one probably doesn't make sense.

But, 0x1000405 is repeated way too many times in this function :)
At a minimum, can we add something like this?

#define GNR98_UCODE_MIN_REV 	0x1000405

Maybe add defines for the PF as well?


> +		if (rev == 0x1000405)
> +			pr_err_once("Erratum GNR98: 0x1000405 is not loadable.\n");

						   ^ revision

With early load, his is probably one of the first messages that folks
will see but it will only be displayed on platforms that have the issue
until they update their microcode. Should we be more verbose here?


> +		else
> +			pr_err_once("Erratum GNR98: 0x1000405 is required before 0x%x.\n", rev);

"Erratum GNR98: revision 0x1000405 is required before revision 0x%x can
be loaded. \n"

Should this be 0x1000405 *or later* ? We don't want common users to
specifically try to find the revision 0x1000405 and load it, right?

I am wondering what is the use of the if-else? Is that intended to guide
the late loading users? I think for other users the second message would
be confusing.


> +		pr_err_once("Please update the system BIOS or firmware.\n");
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
