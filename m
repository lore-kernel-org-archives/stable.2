Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA55B30675F;
	Mon,  5 Oct 2026 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791229583; cv=fail; b=JClCaZNkxGZLL1iL189oOMtrlp69m/Ldkle6uu1VzhWqaCMXu3YtDyI5e/NcTy2vJnOADfFzZ108WK15awCtxXnWq1FdZdi7ODoi/Ni63PP52BRVaaSmBNeWY6FGVaarwlI6Evm6H1Zn9sHZqbpE/x33o/FEf305UM0X1830Bo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791229583; c=relaxed/simple;
	bh=rf9dFHeQ6/ZFCvdWHx5o6EgZalSlr1hcOXIr+OrlO6c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WCXHxMrYQea0ebhXpu4XTgYD5WLgFXo+nSrFUNgdAiCuNQVR8+VwGQIJ2YOg+hwf0quMAZmPRN45XMUdDAszKsBKUyJSDLV1Q/+JH6T/TctLeRwjb133KgwVfaOeQX7cbTRV4aGYRbLrwf6F/BvSuat9peEmSMBMO26x0COWhxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqv/s5pN; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqv/s5pN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791229582; x=1822765582;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rf9dFHeQ6/ZFCvdWHx5o6EgZalSlr1hcOXIr+OrlO6c=;
  b=eqv/s5pN7bGhlxzmxhs9IV5kzwAtnpg1yRWnw7Fcwqjo0p79ki0Rqtz2
   5hL60x1ev3K47pM/EUXL0RZHOuPHHc+7Y4np/UMggnKZKk+7FKovKiA2D
   j3T3wnowrE1WdAzF8xMMAzzyb8qJzGimxzuwJOHsuUZHbqcpMQ4cYuwCp
   uNbGexW2xoTWYtCXizeocGc/s/JwXn0+5i0+v4VTMM1b0hEH3j3yJA4bE
   +eYZYTZ+G9FIyFIx3Q+pBjDUeMNnMQJ71rb1o1zuy1926T8Te1mXESWnd
   zBGaFQV42PVWEfnfrKstBvoSdCRKjL4xBu59oV47kWQJbzo0fp8FmLd1Z
   Q==;
X-CSE-ConnectionGUID: cC4g78U3Tha5tgjo75dCCA==
X-CSE-MsgGUID: pvXshxDuRWKm+Ka8XeHuNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102427750"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="102427750"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 12:46:21 -0700
X-CSE-ConnectionGUID: 7GvCgfEdTIuldYZ27baTuA==
X-CSE-MsgGUID: KVkrl6wcQfat0LlC5PRtFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="304848532"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 12:46:21 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 12:46:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 12:46:20 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.9) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 12:46:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWlVZM7+h6mnrF083gTwEr3vhyzBRgZOZPPeBzjkoR3cQfbH3ZalwZ4tpSHeLZ9fDRV8XCQEOSCgbAJVSYYLsfN4F4WAdrtaWEwIfUxm2q6F+kFJzcgxVbu9szeA204CmZU4Rfhvg1RZOG1/GDDZ4GxDRTbL8/EK2ANyQ2jOIgUaaNxwrBW1EefFYPygsm8whbcIoAdAZ0lpzukJqbQ3N+di5a3yZudtI/iAgXhgqsrytD46h6F/qA3QsGsiiTYryjqqWO+osjOIeS17ncOr4EufjNwnmumoWowywqTl/bn8FlEDrmURUb1/MftA/4soHWqc2bUEJP+FZDNzURqB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v51DvNo1gBI79DGePW2+ZaIiby2/yyPKVXtVHUCsBMI=;
 b=W5+fDeo6+a0vDYjsfd/9iyxXyK880l4KWO8dWD6ZOGRsw01Qx7QTaQhyShPjRh0/x3UpfL01/H2Ixm48hnj8+acj8rEUwf/bcs48q5WYgkqSqsTF9jOeoN1BB7FBeLjgrGTVmNah0OeT2l+dR/pHr3AU1+IyDJe0aQMYSZDPgkzWdwFxAma03M5BijeXHSWSXqR+77BHpMn0IpSGCaRzGU9/f9CZogRn4XgqgDfpGTEyHTQTy+/Lufg9u9TP9fQFj3RRJagQ51n/ez/6+zTHS+d0cehcNf+Kpc3a3UX4ztO3JsTaaWMBnAVsRKTanYEUHn9aZfsqbEjC6nS6xpDB6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB4645.namprd11.prod.outlook.com (2603:10b6:208:269::20)
 by LV8PR11MB8486.namprd11.prod.outlook.com (2603:10b6:408:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Mon, 5 Oct
 2026 19:46:16 +0000
Received: from MN2PR11MB4645.namprd11.prod.outlook.com
 ([fe80::5cb4:804e:bfb4:dad0]) by MN2PR11MB4645.namprd11.prod.outlook.com
 ([fe80::5cb4:804e:bfb4:dad0%2]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 19:46:16 +0000
Message-ID: <03bb7fa6-beec-446d-989d-9067e83dd926@intel.com>
Date: Mon, 5 Oct 2026 22:46:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 2/2] e1000e: fix ps_pages DMA map error
 sentinel
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, Matt Vollrath
	<tactii@gmail.com>, <intel-wired-lan@lists.osuosl.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260913171555.89537-1-tactii@gmail.com>
 <20260913171555.89537-3-tactii@gmail.com>
 <86add723-6e77-433b-83db-d186d98140ce@intel.com>
Content-Language: en-US
From: "Kadosh, MoriyaX" <moriyax.kadosh@intel.com>
Organization: Intel Israel (74) Limited
In-Reply-To: <86add723-6e77-433b-83db-d186d98140ce@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To MN2PR11MB4645.namprd11.prod.outlook.com
 (2603:10b6:208:269::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB4645:EE_|LV8PR11MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: b28cec01-1e2e-435d-81ff-08df231951a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|10067099003|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: ubJZPoISR1XH2D1a57P5OD/J/v0aCH3fJ6xKucJyI+Ut9rU/iM7G4pGKhwc2TBIbykAu87o70zv/Yd3eKq4TiiFEw7VJneYQlF61h7pjqXVNfPxvA9KgSUbtkj2QamkoqPkq8VJTmtHfBrHlLwPyc1ffpG0oNSj/8q/093dpn5JLhKgCJZS4mwImK636Sakvn/2Fc27saTH0zZXSlU+TVHEMBaTfAZGAxPUiehvOgab4VGBZ26gpHwtiHZ3Ggi2K8deND/KmvlqjxGE/HFfQHPLESqWvAsDPGKUJqLOcZo6Zfp2S50z5GtGYtltPE7AEz4mxltnB6tqC4qUWU+KCr6BHk+BZeS+cYUHJLLvcKYBpnrTmu9h5A2zBV4F1Lr140lDTWSdn/CKXUf7sdKk5ABgGnJybDAn0LphK3McjaC6w8ESfaq8y8kR4NNUw3LLyelb/c0VMWQCdLlrhPyuLOXaRQzttfX8ia8+0oABuWpZg6Z5gFixtxaYWikHlXNpitSgaNWXYPdElAPOK/rzqWUhv7i79+7ID3GZGBlT45Ob4Q8mLhzhrSd5HcNI/Tg0Ce2SbQOCjGHi7cLGVwRIJsILejFyMnG5N3QhOfNMV6zHeE8TSXGmzKzibnG/uMXFojDN97f9rQx7DA92W9iuMEIrV0t0XYeYM9iDqa4Q57v4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFhoYm15Qm9uK0VPcFIzdmdsLy85bHorWDdrY09uR211cmlqWVBEVDcrVC9Z?=
 =?utf-8?B?MWRDYjFSTnludm83Q0pvVnBBdHZLSjlVWE95UmwweG1jNlFWK2ZNNjg2ZFNT?=
 =?utf-8?B?TnZsVVZMeW5JV2pES0ZPV3NIWTFjNUYxclB2MnNvakU0ZFZMMzFJNmxCWmo1?=
 =?utf-8?B?a3R3TDVVRDRXWWsva3Rva0MxUTEweDRkS0dVRHdZRWFaTFkwNHJRNzYyM2M3?=
 =?utf-8?B?VzdBZTgrYUYzc1pGQm5BM2EveEkxM2pRNUVaVG9FVWF5bFovRXM5SVVDSCsy?=
 =?utf-8?B?RmE3UWs3NjR4TDY5QVp4UmNiR2VZZkZoU1NRdkNQR1YyT1hFNFpFbGQxZDRn?=
 =?utf-8?B?S2JQT1NnSCs2WXVqck8wWVh6azhOSWZia285aGQwMStUQVd4M01JOVpIMUlZ?=
 =?utf-8?B?SFFvTDlRSk0xL05ZcHRMWTdDZ01XNFBpMUVhVlp1UG43UTFGUmlGVk4wK2FJ?=
 =?utf-8?B?bHQ1UnhMamo2WEZnTHgvU0haTTluL1VlL2ZWdS9pRlY3NjljNXFPMG92NEhD?=
 =?utf-8?B?My8zTVhrY2tZWDNVUFdiR1RVMFRKQW01ODUwK0Zrek4zOFFjbWtoYXlkTkIw?=
 =?utf-8?B?eVZMajNTb0tkWWlLNkJ4WTU0dWxBM0VYMmpPVnhlVE0xR0FuTUcySXc5eDVj?=
 =?utf-8?B?YWRMQzUrcmZTTDZKVmd3d2FBOGFjZlNTZFRhVytmRzN3UDFEWXkxUGcweUtT?=
 =?utf-8?B?bWxKUVRyY05mNzJtbjVHTFM5ZDdhVWpZUGhCeFVrREZSdmJXQ1Vmd3FaOVFG?=
 =?utf-8?B?Zk85Vm12RVA3bmdZVktrVGpDSlVQWkhzY2JDTkRzVi9jMyt6cFpJWjgyVUpH?=
 =?utf-8?B?amZ5N0Z6VnZSWldhR283OG4xWWVjbkZsMk5JNkZTQStqaVhkcSsyck5Jekth?=
 =?utf-8?B?dm9CNnhZZmloc1lLa25OM2hVK05TOExiTFdLOEdLYkhmWm1keXc2Z0RQL0U0?=
 =?utf-8?B?dW5oa05ReGRHbzd4NGxhYjUzS1AvK2ZNMzV6cW53SVNhUis2Q2JwUnc4V3Y5?=
 =?utf-8?B?ZzRER3dwalpoVERGaVZidnc5dlAzblZQM2tJd2tOSGJMQi9GU3IxV2tsOHNP?=
 =?utf-8?B?WlZnemxEb2ZCRFhuMFhRYlBKVGtXYlVpeWlDUy9VK3l1WExBd2xPZWtCV3VV?=
 =?utf-8?B?amtDeWR6K3AzcmJaNnlEWU8wRWw0MFptOEZNdzh1c0N4WjMzOUVaK1lxYzZt?=
 =?utf-8?B?ZU12OFBHNFJNYy9zYllEcktKcFFqbXZNbW40b3FXRDlvR3RFNjBTMTRiWFRL?=
 =?utf-8?B?Z2tHMWNHekNCVTFFL2FVN1hwN3k5R0IrUEc4VUtXV0dEa2xhTzRRTm1nc0Qy?=
 =?utf-8?B?UnlpT0RBd1huRGdLSzFuL3c3TDVxaTVUTStYRkYyVnZRakNQMzJmcXFKeXo4?=
 =?utf-8?B?OFZyVmZPNjJHVDhBd1VGUUNPbkxyeWxGbVJFWmhHZHZVaTZMNU5JSjUrL2NI?=
 =?utf-8?B?ajlqZGo0eXQwL01zL3ZqS1Q3R1V0VytnTzRsQVBTbFZPY2x3Q0lVQWltRDE5?=
 =?utf-8?B?b1pxNGhrcHM3dmtnWUs0c3Z1SFQ4QmlIMVpBQVI1M3JCZWJkUDgrczVmOGNR?=
 =?utf-8?B?OWJsdEwwUzZyeDJ6OU5kRjNoUmx2elVjSnBlakF6dTUyTjFKVW1ISmlXUjZQ?=
 =?utf-8?B?Rkcxb01QQm9IM2hGMVphcjk0b21FRnk2Wmtta0NMeTJVRGs3UlBjaDJ0Tjgz?=
 =?utf-8?B?ZEVGTVVWTDZoMU1sRjQ1bTdpZExGR29oSThXRVJYQnBFUy9iVkpwUHN1WFdF?=
 =?utf-8?B?OVRuRHRqVmE4VEdzTklTdEIreVp1OS82MUo3KzN6MzU3RFlLc3J6dHg3dUpZ?=
 =?utf-8?B?QVJQVlpXL2NYY3RlYmxOclpqbWkvWU5lSE0xVDBzNzQwQm4yOFhYamFLblNV?=
 =?utf-8?B?bVlVSEFRZHgzZVJvK1pBcGRoRHEyWWxZV2hvOGNhM3pHV0w3VUtlV2sweHI2?=
 =?utf-8?B?V3E4UWU3MTJZVktJUnRzVmdUUjM2U0hOc3RLNExGWnpBRkVhUTJCcTg3SmUr?=
 =?utf-8?B?anJzWHp2NHJJejVxc0MxQnBrMSt2MUFLVnhjZVlFWTE5NXRyV0ZpV3QrekZ2?=
 =?utf-8?B?TDNTZDJOSjZKV0NKbGxKUjQ1SHpkNGZQcmg1bm5PVWhxdnJTeUlnb01LeWdG?=
 =?utf-8?B?NFJzVlI0ZlVRY3pNRHpkdHlZaFRwYVg0bFhZbXdOdDRiU1ZvNnBIT1dWUU5t?=
 =?utf-8?B?WHpIN1JpL1VLUHF3U0V3WXVDMURYaERYQlpqSWh3dUFWSkxDUi9SKy9CRDlV?=
 =?utf-8?B?SUhJWEtzck1yYlZxMmpSOFNLNWJYL040d1JQU1BhOXZFRXJ5WUx5YXpMcGEz?=
 =?utf-8?B?a2Q4aUdVenVwT2J4aFhCVWpCYTNVMk9pL3NibVBpcEF3UWlOUEd1dz09?=
X-Exchange-RoutingPolicyChecked: RbyokN8vZTyGF9gFsD2x3TtJZ0dMx4tbyOT1rBPwAVc3QRtlxwgzFsM/Z3SVf/qgQm5Y+7Tp3SCzadsnzcu1r5qA+TgYuJ+2gHqNUW659XpCx6gcFKnu0iU7755XFyT0ESEJBwXzU0txEFD/InM41b5rR2AfNXGq0ziuDQvvj7BENw/uXMDYCmU0lO1r4XefalEnf9rMGc9uI0nK7edzIldQtopCxnCzESJcclTIvIUSM1e20JT28/9vH+56kHqAkTcYNj60IhhLHl2+fJQzI+HZ8eDgtqFALqjQMz5ShGT9kU+RlGg+zZi6/OLk+vyICwMy8FBvSyeP0sQiRXE4Cw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b28cec01-1e2e-435d-81ff-08df231951a2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:46:16.2815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFak/gZ5KbCKTSXuQUFjwiln3NBvF0pe7euEB5lfaOALqd1uTF+gCSG52H67cB4v+Mrs0xuYF+AcZAMao6rmN4xf1DqqnH2YFSqO/EY3a7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8486
X-OriginatorOrg: intel.com



On 05/10/2026 21:11, Ruinskiy, Dima wrote:
> On 13/09/2026 20:15, Matt Vollrath wrote:
>> While allocating packet-split buffer pages, a failed DMA mapping would
>> leave DMA_MAPPING_ERROR in the ps_page->dma field.
>>
>> This would have two consequences:
>> * The next attempt to allocate that buffer would write DMA_MAPPING_ERROR
>>    to h/w if all pages are allocated. If the h/w uses that buffer and is
>>    handling a frame large enough to touch the affected page, it would
>>    cause a DMA fault and be dropped. The driver would then call
>>    dma_unmap_page() on DMA_MAPPING_ERROR and unknowingly send the
>>    uninitialized page up the stack as part of the frame payload.
>> * On ring teardown, dma_unmap_page() would be called on
>>    DMA_MAPPING_ERROR.
>>
>> This condition is only reachable when MTU > 1500 and PAGE_SIZE <= 16K.
>>
>> Fix this by setting ps_page->dma = 0 upon mapping failure and separately
>> testing ->page and ->dma during allocation and teardown.
>>
>> The rewrite of the ps_pages section of e1000_clean_rx_ring was necessary
>> to recognize the case of an allocated page without a valid DMA mapping.
>> It also fixes a separate bug which would potentially leak pages on ring
>> teardown. The cleaner stops cleaning pages when h/w reported that it did
>> not write to a page in the sequence, leaving the following pages
>> allocated and mapped. The teardown would then break early and leak the
>> unused mapped pages. If the ring is re-constructed by down/up with
>> similar configuration, it would reclaim those lost pages. This would
>> only affect configurations with rx_ps_pages >= 2 (MTU > PAGE_SIZE) and
>> the same condition of MTU > 1500 and PAGE_SIZE <= 16K.
>>
>> Signed-off-by: Matt Vollrath <tactii@gmail.com>
>> Assisted-by: Claude:claude-5-fable
>> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver 
>> (currently for ICH9 devices only)")
>> Cc: stable@vger.kernel.org
>> ---
>> v2:
>> * Reword last paragraph of description.
>> ---
>>   drivers/net/ethernet/intel/e1000e/netdev.c | 19 ++++++++++++-------
>>   1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ 
>> ethernet/intel/e1000e/netdev.c
>> index 26f45ee8c7e7..063fc8cd2673 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -759,12 +759,15 @@ static void e1000_alloc_rx_buffers_ps(struct 
>> e1000_ring *rx_ring,
>>                       adapter->alloc_rx_buff_failed++;
>>                       goto no_buffers;
>>                   }
>> +            }
>> +            if (!ps_page->dma) {
>>                   ps_page->dma = dma_map_page(&pdev->dev,
>>                                   ps_page->page,
>>                                   0, PAGE_SIZE,
>>                                   DMA_FROM_DEVICE);
>>                   if (dma_mapping_error(&pdev->dev,
>>                                 ps_page->dma)) {
>> +                    ps_page->dma = 0;
>>                       dev_err(&adapter->pdev->dev,
>>                           "Rx DMA page map failed\n");
>>                       adapter->rx_dma_failed++;
>> @@ -1722,13 +1725,15 @@ static void e1000_clean_rx_ring(struct 
>> e1000_ring *rx_ring)
>>           for (j = 0; j < PS_PAGE_BUFFERS; j++) {
>>               ps_page = &buffer_info->ps_pages[j];
>> -            if (!ps_page->page)
>> -                break;
>> -            dma_unmap_page(&pdev->dev, ps_page->dma, PAGE_SIZE,
>> -                       DMA_FROM_DEVICE);
>> -            ps_page->dma = 0;
>> -            put_page(ps_page->page);
>> -            ps_page->page = NULL;
>> +            if (ps_page->dma) {
>> +                dma_unmap_page(&pdev->dev, ps_page->dma,
>> +                           PAGE_SIZE, DMA_FROM_DEVICE);
>> +                ps_page->dma = 0;
>> +            }
>> +            if (ps_page->page) {
>> +                put_page(ps_page->page);
>> +                ps_page->page = NULL;
>> +            }
>>           }
>>       }
> Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>
