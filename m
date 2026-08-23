Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762573D3008;
	Sun, 23 Aug 2026 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787488047; cv=fail; b=YCFuOHazVWkRKyf8lp/J0OxGyQOw7ATtrUHRaJWgB17Tkr47AH5bR+uDw2l5e9jzbr+u0jZlnsBq81NfZmXahrtrVPEdY9cLGCr48zmAvIF5L9Uos3jh0fTWKmequHu80C/pCEYmVJoJDDnyvQ7o2WE9gp8wQxSQjKtcEivW6tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787488047; c=relaxed/simple;
	bh=sKoqwNnBI7e3gom9LMqXPBk14iflS2fqNUD9nnxaIbA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G4dmQCjja5ITyEcZGV/P3mxd2oaH+qanc942aY07EDC1QDEs5b6sRu3c6NQfccGh4NAI7ZZvRDgWs74fyuwZxF9AIJqLHfXwsLoOJT29gV9c6YBaiynBr5t5g5qY5Va/hdkScEY7109yVoxSyTVwRFc5+W9LGohqp4KyVBNJhhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jexJWrO9; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jexJWrO9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787488045; x=1819024045;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=sKoqwNnBI7e3gom9LMqXPBk14iflS2fqNUD9nnxaIbA=;
  b=jexJWrO9rRmqNWxpdbupcCzZ5zgeVqQmxT+KOuKzGSpWCns3O0yems6q
   LvqvaeaGegLgsLms4m+WMd02uChf0on6W4gZmr+P4GBOObad81O0RVV81
   dmVDqQCUc/ZwwpcDFHI4kgs4M025JwN24z4xVsx1T1OrsFHxsnDBcVID4
   Gn9uY+mxW4VrdC0ymNAVErK+2Tz6cPPrQ0gwCJal0X398vcih0NR5Yk76
   qKFet3hcQvOGCS2x75gTsBbi69yEMOWAhJnTtK06fn8i2pODSP9RBeo5x
   ZppPRSjGPv9eYa9kA1dpweDZOqiqfa+KxDXVcsjN18s+5VsCGycpojdRh
   Q==;
X-CSE-ConnectionGUID: 1Rddb4YBS/epadISkoXZ4A==
X-CSE-MsgGUID: Fcsj2FLdR86wbcsEoI3L3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="87981824"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="87981824"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 05:27:25 -0700
X-CSE-ConnectionGUID: B1V1D/ZcT2y+hd3qrjYmEQ==
X-CSE-MsgGUID: w0LrHkzCTpu+nDK1rQ+24g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="304954696"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 05:27:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 05:27:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 23 Aug 2026 05:27:24 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 05:27:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dr0JAnZ3FufUJ6VpZOA6gBn7+OmJ5r3kR+Z3mlgvGEBtSvj6pqvhnE2Zrg/0m/UCwtV+KPQDNijxyvSzgnOsFor2CkLLFr+mmuRvqMabGwwH4IAgvWof7R4jOyF1MtsFONpR7M7D11H3fAVn8d7iOmbuS7lFNxEvR78t1CboCIaediGyLI3zcsAXo7E1BI3AhjXjd0MGTXdfoXseyqYZATvLMiO8+KOwzLFMVlxWugbfUUYvK6CPMOi24J4+hWMbIqkCZp8yLAqzOoaMm81g+U2XlvzkEk7Y7wIyYQ50N+CIagw9mPF8nikhcGNwo3CJCSM/pMNUviC3GFC87sXK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxayC9lWTZxkpYnEVLweFg/VUFDjexa3cX2KjAeLGRg=;
 b=I8FTOM28E9c6yuMcbR0LpsDrAbaEr3NYpwfiH2A6Tf40mGHQ3aK8dJPO+qdpr65bVy0j7jZdJuyXJtVizaosT+l9rRhrJHV9N91149FcA3f9/Pwjq8oFxCyI1Hs1G3gq3cof8rLYnGDf3TcZuWyMUmnx/UYMlmHnAXUF5h9OvXJQVCVlOzj3M3PhbY3bPZQH+7rbaVulVlfYsCtrvt3YbrTg9nUg3nVEvg6uDiS2E+KjR65PxCx5WdXxFSZ9BYuGdcvoehOljKP2acu0UhVNB8Az+ybsNeosepjEk4mTN+idA/ptaeI11UNaKJfANh6VYiPdTSOEvqTjvAntZU3rYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by IA4PR11MB9324.namprd11.prod.outlook.com (2603:10b6:208:569::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sun, 23 Aug
 2026 12:27:21 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 12:27:21 +0000
Date: Sun, 23 Aug 2026 20:27:12 +0800
From: kernel test robot <lkp@intel.com>
To: Fan Wu <fanwu01@zju.edu.cn>, <gregkh@linuxfoundation.org>, <tj@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <chenridong@huawei.com>,
	<driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Fan Wu
	<fanwu01@zju.edu.cn>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] kernfs: recheck of->released after acquiring the
 active reference
Message-ID: <202608230052.ZXfVhNjk-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821050720.14848-1-fanwu01@zju.edu.cn>
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5214:EE_|IA4PR11MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: c9dfdd12-b457-494a-ca03-08df0111e146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: I5qDTnWvyBzTJPqJ3DxexxBLxMydohMVRgwy2286+D73ISm4OI0NfLVgjbUDfGT576R36bdRVuWAVAIQlQ6u6kVZGJMe5RoTiHJOrCwrJSIv9b8rA1ij+FfoItVku/beXmhnTfzxzfLLSRL2VzUDuaX/cspSPk4N0ZBq2WjHFHK77vRzmKMZqw3a5sakBJ4oZX5r3mHu8ZqUq7eGdLjyjhCmASvlmAtxTCYkC7BPvRRhmYgY+ZkPzNVLPalwjKljTYqMJ8fOLH2JSF/lrfCAUWdE1oOLHq1lUWm8rGfJZrRCiFEhas+KyW5ig581MqVwn9IHaEqCpaIVgD3qKX9RHCDj7qEDxqhylB7HWdz2WKzn4a29clv5f8/VpfFZNbX5DRElzxtF+2qM9Ww+VaaQF9CuYuneY0m5kCtWf4RuMVW/cIlkfmY46VPU21wb3cEjdx99zrmtRvDcL9N2G7MfmAMpDS3d3yZuUqcqpqxM4liVhKK8luePntXF4MqWQ5sAiFiaZvTML1IeCFESrb3td3r/yQFQ7ie6kKwwb5W0HN6GfaIBCBdvbF75yYx5ACRWnZAtHrMLRrPgd0VmgfrS7zcX2TC0fcPq4lGrZE726R6zZEIwIfAFUP6S4tPAd7Ue
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5214.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ElG1iV6UGMPAy0UsuohlhXT2x/UReppWCk9kLwH79SO0PjD1RfLrFEsKW/uK?=
 =?us-ascii?Q?PRD5QrnA9/1mf3kU4dwMM2/qQnfEO55U+0enrgOeoM7xM8js7kSEoKZqUWld?=
 =?us-ascii?Q?cS83+wgjQXkw7RQ6Wz9gQCjvoW/K3uoX42Tdz0FKRgb9VXYkE2vb8J/aPEoO?=
 =?us-ascii?Q?EDiawteD7XPlCHaC6JEU1xKC4SugaT473c5cEcI2W3tZiFIdENznucnWEIsH?=
 =?us-ascii?Q?SQaIm2NxR17mxYEgEXdFRkAPvf/aT+Q12JcCa0fQ5OklW1QKOauUYILZBEku?=
 =?us-ascii?Q?lA33A3xRDev8JiE+YPl2IsxJ2d3osm7xaTmyHSqBC5JyGGVxs7GkQmxJnNZl?=
 =?us-ascii?Q?rsv3vKtH3AFSF1zhWPyV6ceZlCWIy9rMd/rdROTLqRYfHPqCiNNj+jiOZlnp?=
 =?us-ascii?Q?wFnMfvXRZvsATrbCLUt2megw6CYNePZM0XgMNW5fNyLkX64PLM9kzlrQCwdw?=
 =?us-ascii?Q?t+a09oUT0zL+juOKfjfKrEirrLP0Z2Pj/lE5j2xAyHAJxs4x/cJjDQiy22Yv?=
 =?us-ascii?Q?M4mPPkSZH8XeNhml1eTrP8fR5yECSg1tgIeC2Or1af7gtHMJU+xqm9dTxez1?=
 =?us-ascii?Q?VPnELPuIxWSFZIYS1qh1MsD6Fk8c0v5sC91GPSrnmyHYXN/njXADweIQ+Ims?=
 =?us-ascii?Q?bsUnjQ9FZdek8U5PUeFHgmehZ8KXGeR7iZnY+ydCJN2UV6Vut8elbbcIvpKW?=
 =?us-ascii?Q?Bo5J63Ug/K+M6F/7t9lVnzB9NV91rtsEpOlVvrnxy6wuB6I31jooJousLDYF?=
 =?us-ascii?Q?EdQwcsdD0DkepygRK3ygq4WanlBvLB9rz7NaAnpxCjLP6eNz/UqwzcKLYLkS?=
 =?us-ascii?Q?yYQwP+t1J7RYQChDTm6ST3pVp0mspfE4Ma4syzmH5azgq3gqnubkmYkxd7zk?=
 =?us-ascii?Q?IDD7YhtbdToh6Mgz21IMT1HLp8MYAoe9tEYfl4qRw/FCrG8W8F17xfAjHs7x?=
 =?us-ascii?Q?W+5KSSiKQJDWfIW8MPt9ddvR5TP0fmhNBtYx3IP3/r1PbN5bpYgEHWnHKiDK?=
 =?us-ascii?Q?yo6M60ui5iZcwcfjtltN9ZrB8aQn3G0eXOUh/hyH3Gs8stxA/MY+p4J9U6hd?=
 =?us-ascii?Q?6p5EF+7ZCPzPpvkNNN9U67BKwa8u+uHicvlt0O3V1d1Pr+On8F+bTN8pmat8?=
 =?us-ascii?Q?1NiMTPfCDETM/Ulbd+81LfP8I4a5mi+5AtvwwMqrplD0VidwZ9lUv4De8IL4?=
 =?us-ascii?Q?GqRDGeM/dHUtR/4u9LtNraCZmc7RldSyMzGPmYHnnfE8M/fc6mPkJGmYHl7A?=
 =?us-ascii?Q?RfXVOpFlx0zLomGkBjHvz8ge++UuLCWsOHgdSh+BHtt7lCt/40F9NvVkOFSS?=
 =?us-ascii?Q?7tfuLR5GHNytHV+Va6Y+cLr/U+uoyQKiQfmYTnLXH6QdYtBXvpO3MpIqlN/7?=
 =?us-ascii?Q?qQIa8omPE9isoU0nVNMzD9SO/pp8QlPBV/BG+qn68J73RIbfUY2hA+7nH/h2?=
 =?us-ascii?Q?Zk0XpZJaYivrQYK7XswIvyrmf8XJaBBwpQnr9VrERm9wZrfVZ1P58jxTcfps?=
 =?us-ascii?Q?uw9XpEG0IeRt69ZGPAKYgldl4vzFlGNQW9ybeflI02AJOi7t2BgZTtKfZCbA?=
 =?us-ascii?Q?VTYLvAj7wOWg5gF4jVyF9zr86KuJAOGnXS8r+ifJPv+89sb/+N3BWY4MSkri?=
 =?us-ascii?Q?LKfl0jzufNuNXFVQcuPPSnQHT0eGosjWJ9n6HNxyvwg0m0hK0VwE2xKSXDGU?=
 =?us-ascii?Q?TqhGw4ogWXY0M9MgkDgtk6jO9DqS/QfibO0EqR7GU981Ogk+0sHMGTNoTOfM?=
 =?us-ascii?Q?cAQY+nm0XQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: ZMwB44vZSvlp0gd3p+41zdqQ1wwrpSHaM7npR3pGihCjN8vKRFkX7AUvXgpBp7tNExdwxZQX33BCb/FLZ5dwOLA1x5r0D4OD6FPNzuzjjS+WyFojKzPOx017TdQvhRhBR7GLubvWv6SL0n0o3TZ7lS9sOcav3vBgXXoK8Nvtfb6gakkpU54klxrG9njCHMMmvkMWoLOIroF8Xl7XKgQFIUcjFRUyy72B+Xl18Y6JxSgkWtzW047yzz4fUaJSCck1ykXISkfdSbd7G7+9tQPoTTUB+PV8/WZNed916o3r4549Dhsn3g7ubU9ZnECrza0YUo1Qe3cXbJ9HO/QutFVdHQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dfdd12-b457-494a-ca03-08df0111e146
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 12:27:21.8113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvM8l/FcsvNpYWVfCSs/cCXrShqeIpPaGcaA9BA4ltEdFicF/MXyjUPcnGy/k/KyQxt5HmnNb7/Bhv4Bqjm9DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9324
X-OriginatorOrg: intel.com

Hi Fan,

kernel test robot noticed the following build errors:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on driver-core/driver-core-next driver-core/driver-core-linus linus/master v7.2 next-20260821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fan-Wu/kernfs-recheck-of-released-after-acquiring-the-active-reference/20260821-050720
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20260821050720.14848-1-fanwu01%40zju.edu.cn
patch subject: [PATCH v2] kernfs: recheck of->released after acquiring the active reference
config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/20260823/202608230052.ZXfVhNjk-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260823/202608230052.ZXfVhNjk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608230052.ZXfVhNjk-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/div64.h:27,
                    from ./arch/nios2/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/fs_dirent.h:5,
                    from include/linux/fs/super_types.h:5,
                    from include/linux/fs/super.h:5,
                    from include/linux/fs.h:5,
                    from fs/kernfs/file.c:10:
   fs/kernfs/file.c: In function 'kernfs_get_active_of':
>> include/linux/compiler_types.h:663:16: error: 'sizeof' applied to a bit-field
     663 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/compiler_types.h:690:9: note: in expansion of macro '__compiletime_assert'
     690 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/kernfs/file.c:76:22: note: in expansion of macro 'READ_ONCE'
      76 |         if (unlikely(READ_ONCE(of->released))) {
         |                      ^~~~~~~~~
   include/linux/compiler_types.h:663:45: error: 'sizeof' applied to a bit-field
     663 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                                             ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/compiler_types.h:690:9: note: in expansion of macro '__compiletime_assert'
     690 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/kernfs/file.c:76:22: note: in expansion of macro 'READ_ONCE'
      76 |         if (unlikely(READ_ONCE(of->released))) {
         |                      ^~~~~~~~~
   include/linux/compiler_types.h:664:16: error: 'sizeof' applied to a bit-field
     664 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/compiler_types.h:690:9: note: in expansion of macro '__compiletime_assert'
     690 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/kernfs/file.c:76:22: note: in expansion of macro 'READ_ONCE'
      76 |         if (unlikely(READ_ONCE(of->released))) {
         |                      ^~~~~~~~~
   include/linux/compiler_types.h:664:44: error: 'sizeof' applied to a bit-field
     664 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                                            ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/compiler_types.h:690:9: note: in expansion of macro '__compiletime_assert'
     690 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/kernfs/file.c:76:22: note: in expansion of macro 'READ_ONCE'
      76 |         if (unlikely(READ_ONCE(of->released))) {
         |                      ^~~~~~~~~
>> include/asm-generic/rwonce.h:36:54: error: 'sizeof' applied to a bit-field
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                                      ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/compiler_types.h:690:9: note: in expansion of macro '__compiletime_assert'
     690 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/kernfs/file.c:76:22: note: in expansion of macro 'READ_ONCE'
      76 |         if (unlikely(READ_ONCE(of->released))) {
         |                      ^~~~~~~~~
>> include/linux/compiler_types.h:626:17: error: 'typeof' applied to a bit-field
     626 |                 _Generic((x),                                           \
         |                 ^~~~~~~~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/asm-generic/rwonce.h:44:43: note: in expansion of macro '__unqual_scalar_typeof'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   fs/kernfs/file.c:76:22: note: in expansion of macro 'READ_ONCE'
      76 |         if (unlikely(READ_ONCE(of->released))) {
         |                      ^~~~~~~~~
>> include/asm-generic/rwonce.h:44:71: error: cannot take address of bit-field 'released'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                       ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   fs/kernfs/file.c:76:22: note: in expansion of macro 'READ_ONCE'
      76 |         if (unlikely(READ_ONCE(of->released))) {
         |                      ^~~~~~~~~


vim +/sizeof +663 include/linux/compiler_types.h

d15155824c5014 Will Deacon      2017-10-24  611  
dee081bf8f824c Will Deacon      2019-12-19  612  /*
dee081bf8f824c Will Deacon      2019-12-19  613   * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
dee081bf8f824c Will Deacon      2019-12-19  614   *			       non-scalar types unchanged.
1fd76043ecb04b Marco Elver      2020-05-27  615   */
fd69b2f7d5f4e1 Peter Zijlstra   2026-01-16  616  #ifndef USE_TYPEOF_UNQUAL
1fd76043ecb04b Marco Elver      2020-05-27  617  /*
6ec4476ac82512 Linus Torvalds   2020-07-08  618   * Prefer C11 _Generic for better compile-times and simpler code. Note: 'char'
1fd76043ecb04b Marco Elver      2020-05-27  619   * is not type-compatible with 'signed char', and we define a separate case.
1fd76043ecb04b Marco Elver      2020-05-27  620   */
1fd76043ecb04b Marco Elver      2020-05-27  621  #define __scalar_type_to_expr_cases(type)				\
1fd76043ecb04b Marco Elver      2020-05-27  622  		unsigned type:	(unsigned type)0,			\
1fd76043ecb04b Marco Elver      2020-05-27  623  		signed type:	(signed type)0
1fd76043ecb04b Marco Elver      2020-05-27  624  
1fd76043ecb04b Marco Elver      2020-05-27  625  #define __unqual_scalar_typeof(x) typeof(				\
1fd76043ecb04b Marco Elver      2020-05-27 @626  		_Generic((x),						\
1fd76043ecb04b Marco Elver      2020-05-27  627  			 char:	(char)0,				\
1fd76043ecb04b Marco Elver      2020-05-27  628  			 __scalar_type_to_expr_cases(char),		\
1fd76043ecb04b Marco Elver      2020-05-27  629  			 __scalar_type_to_expr_cases(short),		\
1fd76043ecb04b Marco Elver      2020-05-27  630  			 __scalar_type_to_expr_cases(int),		\
1fd76043ecb04b Marco Elver      2020-05-27  631  			 __scalar_type_to_expr_cases(long),		\
1fd76043ecb04b Marco Elver      2020-05-27  632  			 __scalar_type_to_expr_cases(long long),	\
1fd76043ecb04b Marco Elver      2020-05-27  633  			 default: (x)))
fd69b2f7d5f4e1 Peter Zijlstra   2026-01-16  634  #else
fd69b2f7d5f4e1 Peter Zijlstra   2026-01-16  635  #define __unqual_scalar_typeof(x) __typeof_unqual__(x)
fd69b2f7d5f4e1 Peter Zijlstra   2026-01-16  636  #endif
c06cd66387da92 Thomas Gleixner  2026-06-02  637  
c06cd66387da92 Thomas Gleixner  2026-06-02  638  #include <asm/percpu_types.h>
c06cd66387da92 Thomas Gleixner  2026-06-02  639  
fd69b2f7d5f4e1 Peter Zijlstra   2026-01-16  640  #endif /* !__ASSEMBLY__ */
dee081bf8f824c Will Deacon      2019-12-19  641  
38a68b982dd0b1 Peter Zijlstra   2025-11-27  642  /*
38a68b982dd0b1 Peter Zijlstra   2025-11-27  643   * __signed_scalar_typeof(x) - Declare a signed scalar type, leaving
38a68b982dd0b1 Peter Zijlstra   2025-11-27  644   *			       non-scalar types unchanged.
38a68b982dd0b1 Peter Zijlstra   2025-11-27  645   */
38a68b982dd0b1 Peter Zijlstra   2025-11-27  646  
38a68b982dd0b1 Peter Zijlstra   2025-11-27  647  #define __scalar_type_to_signed_cases(type)				\
38a68b982dd0b1 Peter Zijlstra   2025-11-27  648  		unsigned type:	(signed type)0,				\
38a68b982dd0b1 Peter Zijlstra   2025-11-27  649  		signed type:	(signed type)0
38a68b982dd0b1 Peter Zijlstra   2025-11-27  650  
38a68b982dd0b1 Peter Zijlstra   2025-11-27  651  #define __signed_scalar_typeof(x) typeof(				\
38a68b982dd0b1 Peter Zijlstra   2025-11-27  652  		_Generic((x),						\
38a68b982dd0b1 Peter Zijlstra   2025-11-27  653  			 char:	(signed char)0,				\
38a68b982dd0b1 Peter Zijlstra   2025-11-27  654  			 __scalar_type_to_signed_cases(char),		\
38a68b982dd0b1 Peter Zijlstra   2025-11-27  655  			 __scalar_type_to_signed_cases(short),		\
38a68b982dd0b1 Peter Zijlstra   2025-11-27  656  			 __scalar_type_to_signed_cases(int),		\
38a68b982dd0b1 Peter Zijlstra   2025-11-27  657  			 __scalar_type_to_signed_cases(long),		\
38a68b982dd0b1 Peter Zijlstra   2025-11-27  658  			 __scalar_type_to_signed_cases(long long),	\
38a68b982dd0b1 Peter Zijlstra   2025-11-27  659  			 default: (x)))
38a68b982dd0b1 Peter Zijlstra   2025-11-27  660  
d15155824c5014 Will Deacon      2017-10-24  661  /* Is this type a native word size -- useful for atomic operations */
815f0ddb346c19 Nick Desaulniers 2018-08-22  662  #define __native_word(t) \
815f0ddb346c19 Nick Desaulniers 2018-08-22 @663  	(sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
815f0ddb346c19 Nick Desaulniers 2018-08-22  664  	 sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
815f0ddb346c19 Nick Desaulniers 2018-08-22  665  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
