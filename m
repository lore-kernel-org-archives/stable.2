Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B3F1A6822;
	Tue,  6 Oct 2026 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791321932; cv=fail; b=F0/cB0C5hoW1B/exO07qxgkYoKMhQg/d1EKXcMeMSy0MwtsuaLjUEsidll+9Uz34sDsrxCc5RGxD0gp37ykyKnvwo6qSdBtkX/oZ3tYctRTOO7HNClA5+GitOQV8b2iBO++MGyo5HtEOk+nlNUyrsA1fvaapa+vpyu8rbKq13EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791321932; c=relaxed/simple;
	bh=YoBER7VmNVwiIrTh5EfG8w7fjDqg40fCCz/4zOtrMHA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PAyhIBhvsEt3a1qG/kxxhHytfnVn6W2OTs31t9D58DPoYNj+mmeish6MM4AChfAFYWFnCmWDnRyp+bwCneFjebe7E5+/tElGF7jmMEafTnZbTq0tZhuGeirQY3a1WeZBL5waDb0fNtdOLJyXp29YtKBQLaxl+zknMRaQ4I+sTcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hdfrvcwT; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hdfrvcwT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791321931; x=1822857931;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YoBER7VmNVwiIrTh5EfG8w7fjDqg40fCCz/4zOtrMHA=;
  b=hdfrvcwThZSwseZPS1KJe4qGxsQtywb2XzwaBC66tjb03Vxy/WLjZBxY
   cfMIgcmK23wtFgrrB9GBWY2hf3xs9X8882KkbcKtFHmKg4N7lZp5ZU5Oe
   RFDKK3a/tYkMsB87abBviH5fKQqHwULAufVlAjR+98Qvonojal/4BCBpu
   cwtU29CBFmKJ++2Gxex4wdtUpZ/yy1mSqcWEOTOTaxIAWzH5aYyx3LpEw
   K36CJYeTQlGs5rvW37JBlWVYZHH9NOX9WFZdbOfOrCGMvdLejcuB8SYqW
   nQn6TKzRrwt7Z/USYvIU0WPG2JCXd4I3WAv7CbRHHIm6fb6zesHV/Hva2
   w==;
X-CSE-ConnectionGUID: 6xmYvOqgSO2du1+Vu5sqJg==
X-CSE-MsgGUID: TANC7KPlTpaxRF2LUHU1fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="65596"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="65596"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 14:25:30 -0700
X-CSE-ConnectionGUID: EmXbi+YLQDm1fmtq5bfFbg==
X-CSE-MsgGUID: 2QEDU6B1R8GHJo8vS7I+FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="306727875"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 14:25:30 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 14:25:29 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 14:25:29 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 14:25:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dxz1y8Tsl1PswJsJNraYFOj+Pm6PK2or1A0tfn/LAGyifDJYvWbnrbJ6ZLfTEgDFHABrSoMhib7KOBmsXm2vqvlDafLN8jqPTSpgeeL9ZwJjv15+JHlymN9ZrWB6U+UPlQ0d6BissJMaM2WnLfdskKMqJbGIlr2cUGa24B42M8w+6i3GtHJLXn4avId626qvj0jdpHj8DCt5yW77Re9phLmyMtTjeQTEfHB+DmHVmJJR6Jv3zjOfXCiw8B8TEVBrSf2Zt7kvI7RTFJYiC+MVkaaEsbYBiLaZM40iucCMb/b++7lw3Pb2pTVvXq/Do8c0j4aDUgUnxChfj5Jj1XnNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNjIMzPIX9pDQSiGJfPRG7rhCa/vAV2bU3jh3hRcD/E=;
 b=qpVF9onBeYdqZvhY25eBQMpEPu7JUDqayR+fBfs1e/o4Hm6PmKqgK2XG9qZPLWgg7n6ra1/CeTIHxdSl9l82dwx8OytxNlDnSYmAy5z1m9l8w7lwEFX5cL07n2UMReewu9GlNczNFNREHptF37jqLFw0dB/5dxxoifHOAVxaQicbWsFsgKtZeVUSro+evKnwBSr9Sc+hdA6Rgq1BGghoLuH2fE6p8PcOKwd4SlX8TKI98Q0PZj6oA3X7kP8XtF0c9fz3+4AzKtBRpEN5k4zX0rIco3P8cZNb/SUuCzD13AfuNtL0wCRjBx0MYuxtP8IRUba87L9ltUOr+x8u3i8csQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA3PR11MB737119.namprd11.prod.outlook.com (2603:10b6:806:594::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 21:25:26 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0451.022; Tue, 6 Oct 2026
 21:25:26 +0000
Message-ID: <e56f2a1a-d2d6-4327-85cf-c1e4ba3f6a26@intel.com>
Date: Tue, 6 Oct 2026 14:25:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/1] net: macb: rate limit netdev error info print
 in the data path
To: <taozj888@163.com>, <theo.lebrun@bootlin.com>
CC: <stable@vger.kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, "Jeff
 Garzik" <jeff@garzik.org>, "open list:NETWORKING DRIVERS"
	<netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20261004133916.559956-1-taozj888@163.com>
 <20261004133916.559956-2-taozj888@163.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20261004133916.559956-2-taozj888@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::26) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA3PR11MB737119:EE_
X-MS-Office365-Filtering-Correlation-Id: ad880d4b-f887-4aa1-036c-08df23f05666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|22082099003|18002099003|3023799007|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 9sjfljf21h2/MfIMqK2wnbJqsthBCTuDe3YVHadoKlx0AkGMVWcbB/iUbIbDkqPERe5yak+KGldgnk0mcGcHrmMDh1rfrVzooLn456XyEUV/TytJPwVHuE1hYFNOivMgG3AjPYZjB9M5kdt+y0+PcXedKQx1e2ZOzJNl+Cu5L+ha2H9UxI/C6PbnkGOOHzs/ovAAiawbZ2GBlUkmkjP9GdXTDWX5JUNEGDOIXV2DOM6T4gZvYMHA5dD+P6zqEO+5ZbjsUP79t/O2pEMpZpNd/ysW2SRAQWCqs3KVNeAvhm2MVwrmCLSAJMl/YW3+IgkwtoYI72yzNf3gxidngxUvryAiaamlhKGAaI2hAUYDtQUJcCqBzH9mIg2oHgDy6rBioX8tvTJxnv8LdKGcp5x+24CFGqtT/+n75V0THt0A1s5SFBN3RCqdFrnqO50hfi8S/S5k0DiBVCKq8fFT3EAWX8EFI7PjSb33Wo8FRGDPF3j2dHx7Vhs287MF4xA43cnMbvPPjHdHpyXGhdAxIpbSe5xoAqsSHwwpM2knJWXPeB98inqQc62+7TlIISJpMMkoimyvVGKmOvswUfLKk3wnJ9pIz6I/p4S6uuiwMWbMj9OXwbRgUKCVHRp+s64V3859f2//frC3yf6F3A50a9ttaOr/TfsWFX8dAZUiGoVnOao=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3BHSW8rbUNhQVViaGJ5WVJud1hZb2VEMmgwQXlMT1NzWTRKS0JEMkE1TDYx?=
 =?utf-8?B?Sk9RaFdjOGxuZ0F6cFNZSXBVL281MTMwVHZ6aVVzRmRRcHVURmoxUkhSenVD?=
 =?utf-8?B?ZGN5anhHOWRxNm5rVitNWWN5aWZvRUk0UmN3MDRzMEd5RGR3Uk41dStUd25M?=
 =?utf-8?B?bTJYSUFQZnhSYTRwajREZ200dDRRcnFEU29IT2JWVm1KTUlGVFhKY1RmdGxV?=
 =?utf-8?B?dlVCeXcrQlA3QlNGcWFacmVSRmF2TWFLYmRpR2VsNndQa2ZiNGJiRU9Tcjgx?=
 =?utf-8?B?UktEOWpiS0RaU000d013cWtuMS9nOXJ1MTNvbjRvL0Flb2pSTGx6WHJqWDk4?=
 =?utf-8?B?TU1qb0t5OExMRWZJT1hNYmZNT2hSZUV2b3pTaUNuT296Z0FpNjdndjBnWW9T?=
 =?utf-8?B?SUMvRG1QTjQrdVNLc0hOTjNEMnpsKzlWVzIvQTlVNGdmVCtqaXpIMmZaZnZu?=
 =?utf-8?B?a3l6cmY1MkphK1hDS1ZnZDUvaHA1Zk5CN3VVcEJIZTVJYVVpN0Z3S0Z4VjYy?=
 =?utf-8?B?YVNydDc4NUpyNEYxN2VLbE1VMG4wTE1UR3FpTWY1Wi8wZGVtZllFSkxZUlB3?=
 =?utf-8?B?SitUeTJhdmliM2RFL0cxczRyNXlHNmMwSDJhdGhqT3lsVWlHZG8zQ1NNWTZZ?=
 =?utf-8?B?MXJQYWVRNmpQa0tSOEZZbm1zOVRKYkZRbWdId1JjUWczZHYzVng5Q1RQbkM2?=
 =?utf-8?B?Qy9NVUlnZ3ZnUDlWN1hCK0l0N2o2ZUN2eG54WjY1UE94VnllQ2huVmNEenFU?=
 =?utf-8?B?RVF5ek1ZTml0cm9kTnVva2RvU2RJMkdCNnUyakx2bW15bXltSmNvTW9ERkdx?=
 =?utf-8?B?NUxodVJzQlZOVmt3UUZoVHRZWVBUWGMydTFtYU0zMVRBQlZPN2FpV3B1OXNq?=
 =?utf-8?B?aHdCdzBLZHpLdjIzeU53UmFjK3dJdGNJNlMyN3hiNkRnOHUrVkFWRUNrbHNP?=
 =?utf-8?B?YW9WZzEzQXRvdWp0Y1pMVnI5Ny9LMlFuTTg2RFFXVkRvc1JkNHd6ekpMUDgv?=
 =?utf-8?B?WHJuUlllWnFhanAvc0lTZEMxU29kRGxpeCtGZ3JYNGh4Z0Q1WUhxd3dtYkF3?=
 =?utf-8?B?dlJkZVZXL1Y2SHNVb1lmNzNIZEtadElXdWRqWWhRR001bXZINHFuamRaT1l0?=
 =?utf-8?B?TWQxcjl1ai9GSVpTVDR2bW45QXVsNEZsdHhwcFVNb0h4dnVHMzcvNkJCQXBV?=
 =?utf-8?B?TS8xVWNXUXRhS0trS1NKWmU3UUN5R0UxRS9QLzRTOFh1dHFDTWhhN0I2S1JJ?=
 =?utf-8?B?MDRlc2ZoTEJxU2xDcEhuNlgzcFYrWkxYckE2Tm1VTFVJNlZEK1ZwNFVySURJ?=
 =?utf-8?B?K2E1K0ZQRURnT0NrSXozU2pNWFJyR09FdVpuZ0p1OVd6dlJtczhCSG13d0FU?=
 =?utf-8?B?UkF3Q1pKV3RiYXJVRHhVbk1EWU0xTS9KWERVU0hFUncwOXY3dFdYWXpDd1pO?=
 =?utf-8?B?NjJLMmlvTklwcldGYVl3SklCMDlXbit3Y3lOWWxVdFZMSjBTS0N1TnIra1F3?=
 =?utf-8?B?bTRCbFZ4bHlkYm9JL3FxMDRvSmpSYlg0cnpoQ3pnQUtCTDBmaWJrTHJleklC?=
 =?utf-8?B?aDdVaTVaN0ZnQmVrbEI1STJacUUxN0FzbUR2cThpZXJ4UVQvM0kwOEFMZnU2?=
 =?utf-8?B?MlNadk5JcHVheDlERVA0d0lyemtJdkhFOG9TRW1NSjlmeUtjd2habFZhSzNS?=
 =?utf-8?B?NUxkanFIYjhZTEUzeDM4Z1FJaEw4YVo1eXY3SVNLcmZJVU40QmNsVENuL3Ru?=
 =?utf-8?B?cWhHQkZBRDYzZ0ptY2luRGZXeS96bjJabHRhMy95WVdITFpxWEFaTnZ3bHph?=
 =?utf-8?B?VlJESlJaZ3NlTHNJMEYwQUZUcHgxZi9IZjZTUlpqQTVJcy9NTXVvb3NOcDQz?=
 =?utf-8?B?cVhqYXoyZnJhZWF0SkhBQmpZa3hUTTRwYXdIRGZzYkE3RXo2UDJEZ2Y3YW81?=
 =?utf-8?B?dFVFZmdBTjlTRFhCL05mQmRhUUFRMzNnZmZ2M00ydU40OTI2MTQreDFiZHJq?=
 =?utf-8?B?M0RTTkx5QUY1b2VnRDR1U3o0Y3I0M0ZiN0lwLzA1bGc4YnBtZ2ZLUEg2ZEhT?=
 =?utf-8?B?N1JPUVZTT2k2VGxGa05XWi9kekdZNzhRNkcva0hsMmJieG1waUloTGRxSHk5?=
 =?utf-8?B?VUg2M2lZMGg2Vms5T2pNODMzQ0VlZGdWc1FaaFl2U1o5ZU9QRk9nZkRFT2FR?=
 =?utf-8?B?NmVLZjhJeDdqWGhwQWJnb1ZZV2VGMHZvSEhsYUx2SVMwd0JVNDRrZlYwcVAv?=
 =?utf-8?B?aEovemIzZHpKSENBOWQ3ajdNUlQrVU5zRnlQSmlBZEZIc3JxUTMwdlJBWlds?=
 =?utf-8?B?Vis4ZmZhQzNjZ3UyemdhU2NJVHgzSEZUeUsxVFZSRHhINFBjMHBVYzU1eU9v?=
 =?utf-8?Q?bhZadrAkKXDccfl0=3D?=
X-Exchange-RoutingPolicyChecked: utNPnkI1ufXzcrYUFA5ZpEmz+BBCEPZgn3kLFL2yIS23Wvh3lbPcNWh7hSVsmAWFfltjBn3oXLi7KWXz/pim7gRyQh04gZl04w7JYOEKTWpdXG8lpEuVMPO9cJgjK13iRVbZTgFNocDo4ouFpts7DiimbT3HRFCcThAqhG7pQ4XzNX9dPnnV0tuniyWS6Df+s3oIy9CIpdF+S9r0kwIGcLW8kmY/loZftdq2Ss18wsy2aEyY3+GGqwZDyZki4uAuYiF8VLbLBgmW7oWBkxyyr+9nwYChzf2xjihURVFLxhF/HfVg+oJ88l/3Il6SUVDpOqBEtCzcdr73FJaHCJ3Hxg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad880d4b-f887-4aa1-036c-08df23f05666
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 21:25:26.0469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZN3xwCiUC4uiH2AUOlUq5MJOerXiwkz43LFnAk82JfN8dyPgivHTE7EUpqXIKimms5JmVKh4PFh55Saeu7ECfeYc2h4Vdd6LCp13kz2mRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB737119
X-OriginatorOrg: intel.com

On 10/4/2026 6:39 AM, taozj888@163.com wrote:
> From: taozijin <taozj888@163.com>
> 
> Now the MACB ethernet driver print the netdev error information
> directly by netdev_err(), which would lead to a large number of
> error information print if there was a significant number of
> error or just jumbo packets exceeding the MTU received when booting.
> For example, it would print a large number of:
> 
> macb PHYT0036:00 eth0: not whole frame pointed by descriptor
> macb PHYT0036:00 eth0: not whole frame pointed by descriptor
> ...
> 
> in gem_rx() by having received a large number of packets without
> RX_EOF flag set, especially with unknown packet
> type that would penetrate the hardware offload for the IP packets.
> 
> The unlimited prints here would greatly bother and delay
> the system booting process unless the source stop sending
> packets since they occupy the console output bandwidth and
> other processes have to wait for the completion of printing those
> messages.
> 
> So rate limit the netdev error information print in the receive
> and transmit data path.
> 
> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijin Tao <taozj888@163.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 8e5c034dc3a4..ca60960bec36 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1617,16 +1617,16 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
>  		count++;
>  
>  		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
> -			netdev_err(bp->netdev,
> -				   "not whole frame pointed by descriptor\n");
> +			if (net_ratelimit())
> +				netdev_err(bp->netdev, "not whole frame pointed by descriptor\n");

I am surprised that there is no equivalent of netdev_err_ratelimited
like there is for dev_err_ratelimited.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
