Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E3C30BB8A
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975234; cv=fail; b=CzxoJN6cbFsMxscdoGBSAEsYAmxp64vwWkifTbuw8Ap8dwqjiYl4Z7EIxOXg7FcnD5bKys45qASNRmZqIgCDVZGNc22rBeIn0Ni5I+LkFxi8bs/DAcbWwolDJTd3Mr7C9mI16uRK/Z85H2SJM21C2IISNbawPxl9JKcnAXMZcA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975234; c=relaxed/simple;
	bh=vfxBi0MFWMPHnkd9mmQzXM8OQAJ4Lj+fmwX32VPlbts=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TjUJcB9P0TXkXsbWmb/invkxQ6t4lIGJvHfyUjxb/N4CGw6VKEfT9VunhLKiB05zeLDx2y7D8cQtFsKiG5JbPfX+I8YpXhIqm1KnMRF21QELDEJZZWBTo3EgVzw3TPBRuX3GrwLP08K04z00uxV7rizXYXUQ6gfQ4x7lt4JYti8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CXy20p+h; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXy20p+h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791975233; x=1823511233;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vfxBi0MFWMPHnkd9mmQzXM8OQAJ4Lj+fmwX32VPlbts=;
  b=CXy20p+htYLonTFCZ8II34Pzh6fOyfF34LQ0NNZ6xFoubgAXe2Zb09m0
   EB/giMeYLIt32a/kjgP0O7xKdueYJHzToAPNW2pKry4MObj4mBtEA8VsG
   3p9NVRItFhAIJxyueDY7MsCBKwVfnHPlgnxf2YMiICawjsGdxdFm54Cd8
   rHmrjEsH1FNvKRYKwUdvk/beeLXixmxsKix0Ty32mPSMql/a3YaP66O5E
   P1fSOIbLrS8BsNvBuBoUkMAgguAGR4lX9GM+z4hhDJFdKkbrlyqxtq+Kg
   f2XEwq07BOdzp2wIhXILDtLel2018rnazhVxTTYjN4x/6OLAPdZ8EQYJB
   w==;
X-CSE-ConnectionGUID: JLwOxynZQzOEC/yD4pzcYQ==
X-CSE-MsgGUID: oHI4DLk1StC8IUzpxny5+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="596896"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="596896"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 03:53:43 -0700
X-CSE-ConnectionGUID: mxji++78R6KkTOX07X47hA==
X-CSE-MsgGUID: Cn7NphbVQa6440uX/4cuKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1417040"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 03:53:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 03:53:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 03:53:42 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 03:53:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDulEYgntYwkOYoPpa40TE2T2hQfypINzFcKXGm4S/q/qsuR1wccthGc1BJMwC0T/cCOZ+byPbuDPnhNNBVTOpckU7VQqIlp18mSnIBD/92UXrOHVrqSLLXIcb6KMwhymqmi6R6ALHnP3mz6WoiKfa3WUfUsBNm2XyG1zHKIMIFyBm0/VRoqJw7U2ukctpVoW4iDxhwAwotyOLCvNjkkCHaVMVUUVWG836fYindH7c7pQDUCT7/0oSVQ0bS/oZM953T/3fKmUV/RFwBLk1HRZbnVl2qzPfFNHc5CwLMbLWcC0Ir2u/O09l6LIoMy6NTNKYuEPJJxUXNSxtBq2oqt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLcVi4EHKMfo5DpkoafOYoiwe5ei76hx+8FZ3Y7OYYk=;
 b=albNro9dOTMCaHyj3giHUauRur2UVfrJbdDBrZ/6alOJjZ9ev+9Hp2HpmO2vGh922IrogXELu4jPkITxTMJZrr3W4+VEQ01/+whlokiMesqLX5L7do4+KEkepiE5qGMVcoojUTNt5B7So0szkEQo2uPJ6hTyG8x+9kYOyNneGussL/hUWdqVAqadt0TS+o9xJbpzixOA707asVkNxIaCKkdzOWg7EBleWHZ5z7a1ygMXXMkiFtft+Hd3YnlO1zUeD1Yw+vPeAI7CrhB/ewW3n2CBsHItu4wnbg9t1+okY5e9NMd1GIIMb0TM916j1nY7zWe3t8vfqyP7lfJnua1J7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by BL3PR11MB6460.namprd11.prod.outlook.com (2603:10b6:208:3bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 10:53:34 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 10:53:34 +0000
Date: Wed, 14 Oct 2026 10:53:24 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	"Andi Shyti" <andi.shyti@linux.intel.com>, =?utf-8?Q?Micha=C5=82?= Grzelak
	<michal.grzelak@intel.com>, Sebastian Brzezinka
	<sebastian.brzezinka@intel.com>, Krzysztof Niemiec
	<krzysztof.niemiec@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v7 2/6] drm/i915/gem: Count mapped pages in a folio
Message-ID: <b5s5bc22hv7j2snqjhl5m57y6ktbf4zp5xunztbxwxxcybc773@uworjjfhhyhd>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20261006095845.451212-1-krzysztof.karas@intel.com>
 <20261006095845.451212-3-krzysztof.karas@intel.com>
 <2360da488842dcc9dc4fcbf5f3d1d8bc3b57c20e.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <2360da488842dcc9dc4fcbf5f3d1d8bc3b57c20e.camel@linux.intel.com>
X-ClientProxiedBy: DU2PR04CA0065.eurprd04.prod.outlook.com
 (2603:10a6:10:232::10) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|BL3PR11MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: 5edc460d-db70-4dbc-26ec-08df29e164b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|22082099003|18002099003|11063799006|4143699003|261009223027099003|56012099006|27256017;
X-Microsoft-Antispam-Message-Info: xnUvpwPrEvPFTmrVOckF2nQFSZjefzI2XCxpISwe++abiz06EaAeJA/kmG+u9XTqXYjb0VgrIwPtJOMvWhmm+TqIZid1ABlcEJ4J5iBUytafHueDkhdsyZ7LS15DQo7EYKftXs2zaomGst3k+e8MozMMVq9Qkq2ZxQst+OhDjflvo69gbB1I7weJXaBTIbBkZkDBqNlDoLav7JwFRKmF1rgZzcsWgK63D5e2rFr2tE0OzZWn4JE6nEBTxYvSocRMt/IF+WeGbMMra7zN13/Sp3HvWyD4nlbfNdU1dVR2fefnybt2rjHiT3poFhRaMYqjeS/xqk0BKO53bB84+G6zZNeEFe3tnSS/AjYll9i+kJkNfjfH1X7N8w2zYphop618TvC9/7B5ME9PFnP1zsqfdmR5tcsU2R2N4qK8WD/Yt0S1Xz4oV1x9sKS57WKTMGUwX9glZ9CCH+tawCPAmqtXAgsek2ah+rqtIvD9XjM70Vyi8MqyCMXi7sUE1mIhfTF/Tjdg/FtxBbYchiAUzOdZT22L9dEcOtSZs3wjyTjZifZfhGkgN4PMQJn+H6DaUp/w1ZKcMS+HFrmVWIdZQxjGUvJMM1q3gTLCSMeRV2/+R8IQkQXkIsxxcWpjp+4zLcI2cYpRcl/XE/C12CEU4936Z6Di0PnzZAMGROT9rzueTwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(56012099006)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjBKTVFYcVp4WmhwQytTTkkxL2V1K09MV014WmU0VXFyWmVScG5UcGhjdWZ6?=
 =?utf-8?B?Y0MvZ0lwQWppMTJtNjZ1VGpvOTZNMzZOQW5BeHFZZ2E3WmRxNUtrdXZBblpR?=
 =?utf-8?B?MDAyaHUvTENoZ2lpcDBXREl0MXV4akJHZ3U5ZDByMmRSRzI2bHZqWXRVVSsw?=
 =?utf-8?B?eUJUYlZQOVZsbGNSU056a0crV3QxaVhSa0lQck84dG9IbHVsdTRmMVJRVStl?=
 =?utf-8?B?V3hQdFZTczkzc3dJcDN0YjhobTJxWHozZXB4SWxzeU11aFFhVWNLTnozL1dP?=
 =?utf-8?B?Y3ptOVErZkVxeUhGZ1Jvc0FEaWc4TGlEQThza2dybFVSQ2RqWnIwSUJwWDN6?=
 =?utf-8?B?SEJHbWZFN09aYkZIZkJOVGpiY0F6a2JKMm5acjd3TG5WVW1PN0h5N0hkdjg3?=
 =?utf-8?B?OU5NT1YvMy9OclpINCtOelFJQzB1QWJXWjhJQWMySVRaUi9GYXltVW9rQnlU?=
 =?utf-8?B?ckRFSlFjS0Z5ZXNEMndmUTJ5a0p6WVRCdGhIaVhoK0I4WUNxZnBteS9GVEhB?=
 =?utf-8?B?UHNtcEZEZUYweDJxeDUvTWxhbVZkY1dLRTY4a0JWR3dWZzdYTytMMDNJdGRL?=
 =?utf-8?B?dnRSdS9yZy9FblEybzd6Tkt3Rm5TNWNMQWdjTUZxNFl4aWdteTNGb3RhY2RJ?=
 =?utf-8?B?Vm9DcS8zbGpNMzlFTlBHR09BbFluL2ppZWt0M0twN3NMd2src1JhT0dMYyt4?=
 =?utf-8?B?R2gvdzhlRmp4U01YN2JZMEdNVlhYOG5jeUQ0Q0MwNWs4M0JRTk9XaXpuYVFi?=
 =?utf-8?B?UHdiWUZ6UkNSWXY5MktpQldSVjVYN1lBSmlhdHFoUjNFMmt0Wm1xT1pZNGlS?=
 =?utf-8?B?dHQwNE4rN3RhY0lsS0tSNzh6cUY1QlgrK0I1ZUlweTBqR3R5Wis1U3VmVHp1?=
 =?utf-8?B?Z0RLZ3ZJK2p2MWMrN29CeWcyMmN6RXVGejdzYmZSc2JvS01FeG1iRzZRNUNI?=
 =?utf-8?B?THNsb2N3RlUyMTFGYUVLQkVWTktnYW9QdktrUmxjcEpOTFhKckJWZXVGdnBY?=
 =?utf-8?B?TllSZ3BsU3IycU9YeXBCOGt1eEN1cWxVYmtERFZyRUlYQ1E1aGphVWFsd1JS?=
 =?utf-8?B?WFhFbXhDTSszSFQ2SGpRdFBqSTdoRENBYjNqZHArWHNKR1l4SkRaTkREYlJW?=
 =?utf-8?B?VTRvRzZqQ3VIdXVTb0tTcjE5STlMUkc2K0luM0lITWdYSlFkQ3Mzb2lIUFp6?=
 =?utf-8?B?aFkwNmNpNDNZWi9HYlkyRkpvaW1hOVdUd3oyS1QvWHcydVVGM2t0ck9BclBE?=
 =?utf-8?B?dEVBUlg5WWxXV29ETmVnWUlhTTltRXZESDhDN0VrK29OZjcyMWV4QURaeUQz?=
 =?utf-8?B?cnBQeXhMSW1mUGVXbUdidUtSNk1oNFQwRS9XdFUxSFNpS0JrMDl4bTJnM01G?=
 =?utf-8?B?OGxzcTUyRktoYjhJbENxdVR4bE5xbElwV01tU3FnczFjYTJlaFM5Z28zYlJ1?=
 =?utf-8?B?MnNmZmROWVRjSzVuUkI1VkFJWkYxd2NNUS9ubzVrSTJDT3AxWTJCUldjV0R1?=
 =?utf-8?B?aG5DMEsvK1NqQTJyd3loZEZHUlNVMXp2ZUl2WVZtOStMN2Rod2UrWGUxbXpF?=
 =?utf-8?B?dWpyQWhPOG00bFFubTdETnZLenpFaE9SaVFIRFdldmhWTUhRSTBtWi9CdHg0?=
 =?utf-8?B?YWpiMDNQMUtYUDJQWDZZZmQ2eGxkTGNuTGhJZVlQS3lEVHI1N0hTeUxwMFZH?=
 =?utf-8?B?RnJCR2xadmZyOWxNdVdHV2MzaklUcHljN25JL0pieGE0N3hPZDNwYjAzTmpF?=
 =?utf-8?B?dzRLcUMwcTB6bHN6OUJ5clJqZm1zVDZCd1FIR3VIREtHV2M4OTFCWFYxckl1?=
 =?utf-8?B?NWd4K1RiTmhNSXdOcnl5c1dZYWZzMTViM3BzNCtpMWN4QmpaekUrUmQ2U29t?=
 =?utf-8?B?MVZZZ3VvQXFRa2YvZ01LNnczdVN6YmRtMS9Md08zK2dzZDhuOW91OWNMckFO?=
 =?utf-8?B?U0lmNkN5OFFVNjNLaTdFYjN3cjFBcmZKTmpUcVpBd3k3a0wvYkJsYkdlUTQz?=
 =?utf-8?B?TVZQcFd1emNOVDZZU2ttZXBsTW5aRU9XWFlnMjEvd3ZSVmNySjZGV1ZwOVE5?=
 =?utf-8?B?RHp5MzI2MW42NERLd3dGNU5NdVE0VGl3dGFqWnVVWEdKUm1Ua2YzaElPanBR?=
 =?utf-8?B?U0g0dnF0NVJpbllLVGsyd1BvaXhhWncxbTVOMm1KQXhPQ2ViaU1nMG5TMDNR?=
 =?utf-8?B?RzdkRy80YzlocUxrVFp4WlJzRU9QKzJOSXZzeWxtMGc0UjVOd01pc0tCbzVP?=
 =?utf-8?B?WGdaK0plcUwySDFmV0xieFdzREoyVlFHdHBRVHBKQ08xZ2w5bFowcW5ZbWtw?=
 =?utf-8?B?dDQ3TW9Bc0RWejNUYXlweHlXSU4xQm1CWHgvUTBoUDZiNlNqM1M4K2xlRGlU?=
 =?utf-8?Q?+WtDpS4PT9bB99os=3D?=
X-Exchange-RoutingPolicyChecked: XphnY+oh7TxkBW/wHgVYegWHCS+NODx/RuuOBYRSgz3Cts2QZAVri+o0YS+GD7w4uYS9SpCETwAJVND7PTO3jvAUmDNAdb8/FO1vhkVd+3s/zdIUbyS8x6c4izfd5n0EfDVievX3IgLN3HwAnX3qgPv78eN8kZPgBp6RdDxwdLGKXcCXoyJnF+XoMoud5Pro/EBg/gGWO5qJqb7NO5T/ZGA4e7YtZJ46MrcAVyb2nxQj0OnErrZXOIz8JQufFnzNtAsfKFJOpKzSAWk9Iw8hlkHOJRjM7ROwDvMhnns75eVEmUOW6lSq8zUYOPFBPRhgn9vfwNx6ZJJ6Ytuk4oHt2w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edc460d-db70-4dbc-26ec-08df29e164b0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:53:34.5037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 798vkwlLZoejbTM6sZtaU8Ob8y5BveQ9kHKEfCxdDq8X8HifPFRI5Zb4w4sbwvUkCwRE0XiZCdr6ZKkGc/V7TqmBd7xMNNFUkx7CPwLVKHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6460
X-OriginatorOrg: intel.com

Hi Janusz,

On 2026-10-12 at 20:48:10 +0200, Janusz Krzysztofik wrote:
> Hi Krzysztof,
> 
> This version finally looks good to me, however ...
> 
> On Tue, 2026-10-06 at 09:58 +0000, Krzysztof Karas wrote:
> > Before addition of commit 029ae067431a
> > ("drm/i915: Fix potential overflow of shmem scatterlist length")
> > and after folios were introduced complete folios were always
> > allocated, possibly overloading the scatterlist capacity which
> > was never truly limited to PAGE_SIZE when requested via
> > max_segment. The above commit addressed scatterlist overloading,
> > but unintentionally disabled PAGE_SIZE as a valid max_segment
> > value and failed to take care of remaining pages from folios
> > above max_segment boundary.
> > This created a state, where multitude of scatterlists were used
> > for the same folio, but never counting enough of its pages to
> > jump to the next folio.
> > 
> > Furthermore, current do-while loop goes over the same folio
> > multiple times, increasing the refcount each time, and breaks
> > get/put symmetry: many shmem_read_folio_gfp() gets and only one
> > put in i915_gem_object_put_pages_shmem() per folio.
> > 
> > Track how many pages have already been counted in a folio and
> > use that number as an offset on consecutive allocations from the
> > same folio to ensure it is fully covered before reading next
> > folio.
> > 
> > Fixes: 029ae067431a ("drm/i915: Fix potential overflow of shmem scatterlist length")
> > Cc: stable@vger.kernel.org
> > Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15816
> > Assisted-by: LLM
> > Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> > ---
> > v7:
> >  * Derive the page offset within the current folio from
> >    next_pfn. (Janusz)
> >  * Update next_pfn using that offset and clarify its role in
> >    merging contiguous physical pages. (Andi)
> > 
> >  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 108 +++++++++++++---------
> >  1 file changed, 63 insertions(+), 45 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > index e35ee4bd456f..645da248e25d 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > @@ -70,7 +70,9 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
> >  	unsigned int page_count; /* restricted by sg_alloc_table */
> >  	unsigned long i;
> >  	struct scatterlist *sg;
> > -	unsigned long next_pfn = 0;	/* suppress gcc warning */
> > +	/* suppress gcc warnings */
> > +	unsigned long next_pfn = 0;
> 
> Why plural?  Why moved to a separate line?  Do we really need such
> comments?  I'm not asking for dropping it, only not touching as not
> related, unless no longer applicable after your changes.
Nah, this is on me, I had more variables declared there in
previous versions and forgot to remove this change.
> 
> > +	struct folio *folio;
> 
> However, if initialization of next_pfn is needed because its lack can still
> trigger a gcc warning, shouldn't we now also initialize folio before first
> use?
I'll check that.

> 
> Thanks,  
> Janusz
> 
> >  	gfp_t noreclaim;
> >  	int ret;
> >  
> > @@ -104,7 +106,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
> >  	sg = st->sgl;
> >  	st->nents = 0;
> >  	for (i = 0; i < page_count; i++) {
> > -		struct folio *folio;
> > +		unsigned long folio_page_index;
> >  		unsigned long nr_pages;
> >  		const unsigned int shrink[] = {
> >  			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
> > @@ -112,51 +114,61 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
> >  		}, *s = shrink;
> >  		gfp_t gfp = noreclaim;
> >  
> > -		do {
> > -			cond_resched();
> > -			folio = shmem_read_folio_gfp(mapping, i, gfp);
> > -			if (!IS_ERR(folio))
> > -				break;
> > -
> > -			if (!*s) {
> > -				ret = PTR_ERR(folio);
> > -				goto err_sg;
> > -			}
> > -
> > -			i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
> > -
> > -			/*
> > -			 * We've tried hard to allocate the memory by reaping
> > -			 * our own buffer, now let the real VM do its job and
> > -			 * go down in flames if truly OOM.
> > -			 *
> > -			 * However, since graphics tend to be disposable,
> > -			 * defer the oom here by reporting the ENOMEM back
> > -			 * to userspace.
> > -			 */
> > -			if (!*s) {
> > -				/* reclaim and warn, but no oom */
> > -				gfp = mapping_gfp_mask(mapping);
> > +		if (!i || (next_pfn >= folio_pfn(folio) + folio_nr_pages(folio))) {
> > +			/* Grab the next folio if we exhausted the current one. */
> > +			do {
> > +				cond_resched();
> > +				folio = shmem_read_folio_gfp(mapping, i, gfp);
> > +				folio_page_index = 0;
> > +				if (!IS_ERR(folio))
> > +					break;
> > +
> > +				if (!*s) {
> > +					ret = PTR_ERR(folio);
> > +					goto err_sg;
> > +				}
> > +
> > +				i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
> >  
> >  				/*
> > -				 * Our bo are always dirty and so we require
> > -				 * kswapd to reclaim our pages (direct reclaim
> > -				 * does not effectively begin pageout of our
> > -				 * buffers on its own). However, direct reclaim
> > -				 * only waits for kswapd when under allocation
> > -				 * congestion. So as a result __GFP_RECLAIM is
> > -				 * unreliable and fails to actually reclaim our
> > -				 * dirty pages -- unless you try over and over
> > -				 * again with !__GFP_NORETRY. However, we still
> > -				 * want to fail this allocation rather than
> > -				 * trigger the out-of-memory killer and for
> > -				 * this we want __GFP_RETRY_MAYFAIL.
> > +				 * We've tried hard to allocate the memory by reaping
> > +				 * our own buffer, now let the real VM do its job and
> > +				 * go down in flames if truly OOM.
> > +				 *
> > +				 * However, since graphics tend to be disposable,
> > +				 * defer the oom here by reporting the ENOMEM back
> > +				 * to userspace.
> >  				 */
> > -				gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> > -			}
> > -		} while (1);
> > +				if (!*s) {
> > +					/* reclaim and warn, but no oom */
> > +					gfp = mapping_gfp_mask(mapping);
> > +
> > +					/*
> > +					 * Our bo are always dirty and so we require
> > +					 * kswapd to reclaim our pages (direct reclaim
> > +					 * does not effectively begin pageout of our
> > +					 * buffers on its own). However, direct reclaim
> > +					 * only waits for kswapd when under allocation
> > +					 * congestion. So as a result __GFP_RECLAIM is
> > +					 * unreliable and fails to actually reclaim our
> > +					 * dirty pages -- unless you try over and over
> > +					 * again with !__GFP_NORETRY. However, we still
> > +					 * want to fail this allocation rather than
> > +					 * trigger the out-of-memory killer and for
> > +					 * this we want __GFP_RETRY_MAYFAIL.
> > +					 */
> > +					gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> > +				}
> > +			} while (1);
> > +		} else {
> > +			/*
> > +			 * Otherwise, we are still inside the same folio,
> > +			 * so just update its page index.
> > +			 */
> > +			folio_page_index = next_pfn - folio_pfn(folio);
> > +		}
> >  
> > -		nr_pages = min3(folio_nr_pages(folio),
> > +		nr_pages = min3(folio_nr_pages(folio) - folio_page_index,
> >  				page_count - i, max_segment / PAGE_SIZE);
> >  
> >  		if (!i ||
> > @@ -166,13 +178,19 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
> >  				sg = sg_next(sg);
> >  
> >  			st->nents++;
> > -			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);
> > +			sg_set_page(sg, folio_page(folio, folio_page_index),
> > +				    nr_pages * PAGE_SIZE, 0);
> >  		} else {
> >  			nr_pages = min(nr_pages, (max_segment - sg->length) / PAGE_SIZE);
> >  
> >  			sg->length += nr_pages * PAGE_SIZE;
> >  		}
> > -		next_pfn = folio_pfn(folio) + nr_pages;
> > +
> > +		/*
> > +		 * Store the next PFN, so contiguous physical pages
> > +		 * can be merged into the same SG entry.
> > +		 */
> > +		next_pfn = folio_pfn(folio) + folio_page_index + nr_pages;
> >  		i += nr_pages - 1;
> >  
> >  		/* Check that the i965g/gm workaround works. */

-- 
Best Regards,
Krzysztof
