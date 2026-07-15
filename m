Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED923AF64F;
	Wed, 15 Jul 2026 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784134358; cv=fail; b=AZKHTpQ1xTq1CWFov+zK9b56O153PJbbi0sGrGwpEggrsqxj6XD2mNd5iZfBJaKPNLAkMXXgHOQOIm/ybzBGzFQxLuBV5j3k1/ZIsW0tmJ1djw+tkazjo5mwj10DO3XUYKCgQMR1eTZ6L/2q9JLM7nl7n9yzV6yQVRPDkKylSQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784134358; c=relaxed/simple;
	bh=Rpji7XfBHgrqci+TsKzxgWzj3mSGUi/L2xEpAMt3F2o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nbtqyzV888Ri1E93xOSBAoTpF33KqZUos3wzEaoaghdSoq/XoJ68CtSeiRVUouY4Nx1puNI6n/ce2o3dc7u+oir3AAw1hD0EFU7NjwhgEah/ukFEXPJhvCngWVJZtYSqNmYnHViJIWHgRsauEJ0QTNg22G8IRHq76zWYIDoN8Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2Nn1gw+; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2Nn1gw+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784134356; x=1815670356;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rpji7XfBHgrqci+TsKzxgWzj3mSGUi/L2xEpAMt3F2o=;
  b=E2Nn1gw+6h8Q9CC2IsR5O25hV5dFUPzRtIkib5w5Y7FATNWFxJYEcLsJ
   Hdz4WLMfbUhAJ9luC3FUFMorFhX9UwMcIV96h3oIs2p17rPuYVXczHCY6
   r9gddfmLqORp42+p+GOfqnROg4NfQsb5FsM6bKtXIl/uPiOIdpoNCjqu/
   VD4dhU9Yf+T0JesVa4f20BVhDw5cMQOGjS7t0aqMlsxapyEZJhVrjgc5l
   W7SWhFcC3u4vWfFZfXscywdwqVLmceY4q6LuejmOg2ouHYY6PQhG1hufI
   ChH0HymuCiMjuFFPGzpBP0pgxKYcsvxkOPkMRSBqzjKc3mDhiNvIB1yu0
   Q==;
X-CSE-ConnectionGUID: 7RGczKndSq+lwVBgwyxBDg==
X-CSE-MsgGUID: taIDrzVVQRSdRcoZMNDKAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84893806"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84893806"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 09:52:35 -0700
X-CSE-ConnectionGUID: 3XRFvnjOQpOoMS9Vpiblaw==
X-CSE-MsgGUID: 5vP5cQ57RHODB7Bh7DPdOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="259807812"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 09:52:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 09:52:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 09:52:34 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 09:52:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gog1S8u3i8ncS0oY2NlqivPa5Ws9XeBT8WmiJ3fNGoJt4L4OWDcjTNaIBpbxCyQkJf3ugHiv7TDfHCeN6dOnz/XLS3DuHB3KJ5P6L72pNkesICffpXjXzf0K458yRsQAuOKj24a4i9pYn0QJIVO7AjM68LIIyMsAjBXeALXijwOTu2sPJ3mzqPUCyjy2VnVHHQpXSH5PIKKDO7hrVzdsTNhOt3rDef9wlQVojtCy2ag34BZIpY+5/XP7KWZ1ZciErffm/l6Wu60Rcjt3KIY0z7w2BN0/fE+ixllrHxzQaGdBd7fWVkWKkh3LqwnjmgVN10WWQGHbkhLnSEjkHOYatw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fhWdBLyAv/KrN4xYVYxAmpbmNgPFKidl3+kBQb1CrU=;
 b=mb2dcNS/AkvEOdwW78rw1hDuWhsfTPygbQN+js8oaGdJCbJCvHPN3qJP4A8IWIEvZl5d7MWU4Zd2xk25IjUkoCD8NM4Td9j48UX07N5FYxkkKxV2bQwYtSO6A3/1FP9PVuvPp/AF4OC3+WkAkd0dWS0nkb4tBcSGTr8ssvYgJQ42zpNltoTXUJdV3S+otavv6jPQTT1w+JdLLwUE5imZo3PlZsav1AU9wTMvuwXaxVLZFk7iS49LlOZ/lbUlwxBiHClgcsBjgOYQy2Fb1VLkMFukKKDfwMxwHPHSSQFbh3yaSkN9gxiDdRiWdd1FCywJ/8VCaVxq/lUtryZlGtbiVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by IA3PR11MB9351.namprd11.prod.outlook.com (2603:10b6:208:57c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 16:52:24 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 16:52:24 +0000
Message-ID: <59b22ed2-3b75-475d-a922-08bac1de6087@intel.com>
Date: Wed, 15 Jul 2026 09:52:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: hip04: fix RX buffer leak on build_skb failure
To: Fan Wu <fanwu01@zju.edu.cn>, <netdev@vger.kernel.org>
CC: <przemyslaw.kitszel@intel.com>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <salil.mehta@huawei.com>, <dingtianhong@huawei.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260712142729.2057636-1-fanwu01@zju.edu.cn>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260712142729.2057636-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:303:2b::16) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|IA3PR11MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fdb2c1-6203-48fd-db9b-08dee2917223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: l+9YyGJr91WpyjlYwP85hosU/h1bjAdheUhHSoaL1ClEiFvsfVIEXMeWbMoISJ/buE1W5FMQpeFbMLtUXwTz88yJYyN+WAZ+oNWeFhoXdX/5IRSn1PQYKh5ogFG6IdSDtsKTaOgOlD0bPyc2gKfLyrrN1EWTzVCsfe12f5QT80VzbY/WbLMJtdJldiaXuSBzbMr5+OUrG2B7zVCKyMpRwgNC0tE5Gre8e3GxdTVK22cktQbSmpN/nYCqDQ5GcudN1DwwjMY3imDhz5ZUzNmOOS19Xi8NXITIvAQQ1QDKTTZCgKBKAAIWU6zyHXKeSdt+kqYM/KqH+qhmZQ7mJMT/+LOto8xDavV6H2mbkUvUvQGzVm15DTpmAOIIJXyUzzXq8G0S3dXoqBZP/Y+ZqiKKXVuQj6FcqGkDDYKGo8GMRbx6+GaNKlvAmoAWB8IzS/xP4Jtuw5V639ChZwNgMiZKohZZp6ax/QCv5Zy87uBzTbARXc+5n14IvZZUHoIiXeURdmJYx2NXKac+Utr68BqZvPQ5CSBvEYWwYxO1hbYMtjJJk9WSuEIwtVc2JvCMaKEQV618vcVUXeiJdtGPsdJNIhYOYtf4uvbUUawdTw2s0nLCQU2l3n0CcozHWntjhwN68jshmxgsTY2tyVwWXc2wBw7uErPce1LrGQPKRPbWSy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0tiVWJUL0EzZDFVdUwvM1VnNFBlRE5LbG9leFB1TkVqVmxFeXNidmVKb1Ir?=
 =?utf-8?B?bkFpQ0U3ZjBUTjkwVzZTQUw1ejJCSUFYeEpIdDBxczVBTW9ENlJlR0RJc2dp?=
 =?utf-8?B?U1p4RVR6SXNVdjM4Qlo4TDNvaU5EbnVkNStHeFFlVlYxQVlKbmt3S3ZMSkgw?=
 =?utf-8?B?YkcxUWlVaTk1emN3NEtVQXN1NUlpeEU1OHZBZDhZUVh4UXRiOG1xREZNRG1J?=
 =?utf-8?B?VklPL1NMYStUWTZWQ0lyYU9sa05KWjdkcDR6OUZHUjFjV1d4MkVvZzljQ2xM?=
 =?utf-8?B?VkhsMFB1Zkx6RXdmZnlMMy85ZmQ1bzdHK1p6Qll4eG9saCt3NWxQK1R5UGFE?=
 =?utf-8?B?OTZDTG9TcDkzWkJpb3hmWlB1L0kvenZiNEVyV3p5NHFHa2JOc1BNVVBWa0tM?=
 =?utf-8?B?SUFYZUFnOW1qOU4yWGc3UHZpdVBuV00rR0pBcU5ja3o4cGRPejlYUEdvalky?=
 =?utf-8?B?V1FQaUwrUkpnMmNrVkhoOG04cnhCSnhYUXkweTgyNzZ1KzNSMDBWamRieldQ?=
 =?utf-8?B?LzVVNFJSTGhrQkx6WEh2bGc3a2crMmlCOVBLMmVUWVNWQ0ZJb3pGL2lYd2k3?=
 =?utf-8?B?bzJPZ01MWlRMd2FNUS91WTd3dDdpLzE0QVgxbElLTThEb3B3U2RGaUpMQXBK?=
 =?utf-8?B?N0dDby9vYmtEVWVkcWhZYTFNSURjekpuTmR2RGtMeVpOMHR1VjZPUjA2blkr?=
 =?utf-8?B?enMwME1kYnN5QXYwRlRXdnBTNDU1RHlZV2RxM3FXTWJOMTd5emo5dEJvZ2or?=
 =?utf-8?B?SW9RZFVCR1hDcVNvOXZqUlpKcnFIV0twcUF1SkU4TjdIMk9TZklZQjlwcUNS?=
 =?utf-8?B?ZTJZbmpHRUUzMW04Tmk1a29iZERSQTJkQi9ZVzl1UmdEVkZXY2JwTlFPekRv?=
 =?utf-8?B?ZUZCTDk5UHhhZ0p4TzhnbFk3aXpmdEFEY1Bva1pzT2J4Q254R2dpUnl0clgx?=
 =?utf-8?B?K3k0d1paaTFoakZySXFldGEzd3R5UkE0akgrMk9LSjlVT1AycVhnaUMrN2U4?=
 =?utf-8?B?OEtPN1ErOFMwUUxaRGlIVTBLRG8zaENDK0YvNlNUeS91VUJDTUFzemZyOTdp?=
 =?utf-8?B?Q3pmZFZFc2VaTFgzRHJqUlBDWi8zY2RBMmZ4UEdRMWo0dEpWL0ExcDlINEwr?=
 =?utf-8?B?SkFvMGhtUU4zMnlxWFRZNWJsdUJ1K2dIWFo5ZXdJaHBqNHQ1K1Z6TXNHOEV6?=
 =?utf-8?B?Kzc0UERYTWUvL3Z5M1lHRElTbzRmQ2l0RGQzUXN4WkNwSTFmSE8zTC9GNXI5?=
 =?utf-8?B?YlJsQ2JwMGhJd29UOTZ4K3IyUU4vSW50UEtONmhBeklndi9OTXF3Q1ZGdHdI?=
 =?utf-8?B?REhnbzR5eXVjNWhtbVNWeHloL1g2UXJ0cmczTGN2dlN5NGtvNTQ3bDUwcDVi?=
 =?utf-8?B?RVdWS1hDYjQvNkhoRmVmTnBEZU5KUzZ6K0xDVmFReVZ4Wkpoa0VaY0hJbnNK?=
 =?utf-8?B?SXRGRklwQzBwemNRWFdKeTJheHJNTFh6aFg3Yld1aTJWYUE4OFlJSlg1aTEv?=
 =?utf-8?B?aVNjcUx6SS9vT1cxZ0orTzV3NkV0ZGRPSkpibGF1b0hXUFlUYUJyeTY2cnRj?=
 =?utf-8?B?MXduVmV4d2lJc0pZbXgxNHQ5R2I1bGRIaWNCMXZjdFpjekpFYjN3R0ROajdD?=
 =?utf-8?B?M3VPZFNUZnc1Q3FBa0dlbWFoeVNZR0Q5Q2g2NjRiSHBOak9RdVVpTzZNVG9T?=
 =?utf-8?B?V0oyU3FsdENXV0Z0VGNHeUZpWlEvRTVZd1J1OEVvaC9IWjBzYjJ5ekl0d0w1?=
 =?utf-8?B?K2FCODRRcERWRkhLY2xxZTdMTkxTYkdLVFIxWGpqK1N0YlVkKzV4WDFvc3VT?=
 =?utf-8?B?cUQrQzlrZ2tSY1BwSWRtYjJ0aE9qTWhPVlE4dElYKzhyWm1oNFJVMWM1enJp?=
 =?utf-8?B?SjdIbDEyeHgyaUd1Ty9VSDhxcXBJRFhETVVacFNsSHNPMlZvUzN0dnQ2ZlM4?=
 =?utf-8?B?RWplZ3dncDFoYldOWXNxazJFaGxLS3hlNlNzQmIvbWdibWhWc21iTGZFV2tD?=
 =?utf-8?B?MEJsVGpwV3JaMmVrWndINU9iYndFNWMzaXVZK3NmNTVGNURVTTBDKzFncDgx?=
 =?utf-8?B?a05LNDNOMFhqRk9OZGVqMzRZN1pWVFhYbzJsNW94MXRkS2NjblNxSkJKODk1?=
 =?utf-8?B?MWhWZ3FPTHpEOHZTVjZHYkJqclJVeHZDR3gzT1lDQmdBdDdQdlRyTktZT1NC?=
 =?utf-8?B?S0FyblVSK0IrQ05mc2x0V2tsV1ZmNlVTNWxzLzlueTgwQ3lMd09JVURWM2RP?=
 =?utf-8?B?cmJuLzltN2lJUk4zR2ZSUXIvVmhxbExNZFZxcHNSS3IwdXlQSjY4Rmthdlhs?=
 =?utf-8?B?Sm5zRjZvQTRRZHZTWWNpV0NpeHZidWNNa05wVThNQTRxbS9sRks1RDhiUkhI?=
 =?utf-8?Q?SuIUlGI4d4s7GJ9Q=3D?=
X-Exchange-RoutingPolicyChecked: RPQ93+Mp+Rrd6TM+Ps63KQ7d8v7bxCoJNHzeSXkRbRj97Q4NNT8uBe9z4SMMq3y4sKcAr7bj1hdSWVFol2BO6HMyVR99dOtA04wQSP6+hL7YZlW1EwYHNFgjRvWjUs6GzxEnUO10TVtI5qY8XVKj3/ySV36s5fCzDAzz8EE6XCHRB6binWHFzakubEsVNx9uacmtwhW1oTaMcI3HwJQbijazCThA5GtYjD+Nily6Jq7q9bMIwUsB3STyHKWA9utm+N8SWp8Bq/1cFdnMvnUwPOpGqXkIXT2ECR+wNQe2WcS5qzZegpy8U1Ei82FCe9MiSGQK0es9KOAlo+gHSptbcQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fdb2c1-6203-48fd-db9b-08dee2917223
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 16:52:24.7727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UjJOR03c6ld1ITF4VylphBPKT+aVUbnd3vZ95uiJDfCtSELvQoQjjzDDuHmUcBTxdIPkX8Mx5h0ryYw+uc590isqX80SNCV4+eq6s6zBD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9351
X-OriginatorOrg: intel.com

On 7/12/2026 7:27 AM, Fan Wu wrote:
> When build_skb() fails in hip04_rx_poll(), the driver jumps to the
> refill path without releasing the current RX buffer and its DMA mapping.
> Installing a replacement buffer then overwrites the slot references and
> leaks both resources.
> 
> Keep the current slot intact and return budget so NAPI retries the same
> buffer.  Also free a newly allocated RX fragment when dma_map_single()
> fails.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 701a0fd52318 ("hip04_eth: fix missing error handle for build_skb failed")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
