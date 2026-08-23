Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CA03D3D0C;
	Sun, 23 Aug 2026 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787488064; cv=fail; b=KzBc8MxEEybecrNNRxoAsSsgp2UOZYSe3qPoiFCQI0webgHR+7BT5rgp62fKC2rRNJ1WvhCbDEjDCay1PsHjbQK1wncbCy/c6qxDFDjPe37Eg7OOwXBmcE6QbSXFWYbqDCDQn44JwuzghpVxPinl+Ql1epcQY4ig8oQZm0jvlfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787488064; c=relaxed/simple;
	bh=Zb7CTgSYiljlEOBzggqDYlVn647wPNC/c/qshQep85c=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h362G52Wg3SHdZekXy8OMh3fxmNZZm4sanTn8mDFZrOIUENe+5vVlRtTyb+/J21jl6OORA+JXBJk6wymPeCvVVWP6CfwJ9DFW+yy44oTsDZw2y4l6D1vFPiV/TikVeKzkElYXy4QcrSVVM1BtQwRQGKM0ZFYqtIs+TYAy1jwEJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZhweAtkR; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZhweAtkR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787488062; x=1819024062;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Zb7CTgSYiljlEOBzggqDYlVn647wPNC/c/qshQep85c=;
  b=ZhweAtkRH84PurnaZPoinVBzqef1SvJT39J8fatSxbwAGwJPh+g+8Ges
   potIMnO4TiGG2f8f9+fvTdMwQ7gPfWTDcGXlmKZ0pm7O0hiRbwQWuR4BK
   XND9KP3W3nkK5POfSe0TknPyxOnDzLkgbCXGHufz3iFrfbR5JrPOiN+bE
   eH8JQLaDRmBpdaEetjiriMZN/Fcm0N29LdCQSKv6KvPgvsAN1OFVIP6E6
   1Y/4Kg0Wmi/chjkcIV+qzno22keh8+lmZhqEVmioCb1i9MvCoKXRKpfyd
   a8KXQuzY0P8ZNzFWwBwFO5MGwRE1YqtGqqi39sCHx18NUjkgQkSmcj7PF
   w==;
X-CSE-ConnectionGUID: PVZGzeIFQnuoPwd6WKrcTQ==
X-CSE-MsgGUID: OXRJercdRL+PXljzfdaeJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="87076759"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="87076759"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 05:27:42 -0700
X-CSE-ConnectionGUID: zR7gb4WGRCa3DtTMU1k6Bg==
X-CSE-MsgGUID: LjVmN12ATPann/hAEAVYOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="296670740"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 05:27:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 05:27:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 23 Aug 2026 05:27:41 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 05:27:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqBzoy50J9nIWLIPLQ/rlXVmcQ4s6XZRc9ePH0Fu29wdpvjoxkugfcA8whmbu8GczG3bUO/nafr9UE+sazb5Zvm4j2o9zP+hNQAeazjJYCfrj/fBIUDTlqekyBb6nLIll/FYKk0hMjAiahadnOFuXiy1Fq5hfoZlGQ/ZhKk6QQ8WL02QBuSzrflD8TGUswga/dG08IL0/z5QpO1su3dwQsLwlyruNG5UxEMZssbvTOjOHIzdz6O89m3nORRFmASVrTTBaqDBR8GNTK4zeoLQ3f5S/zNfhRiWqmU3IB1/KhSQ/qZPL+cI459TKmS/0BQ8ZeQJmGraJ9PDdL+I16zvzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zu8XOYyPvhlmgCadNKz7nadEIyXTQKLr6ux3RL+Xv2o=;
 b=f/cA9CSmhclykzDlaPGV83Y/3wI9pxWjq6U0lI1bQfrSOboVcaUI/FiXpptEQ0a54EYvht5YPp4LI6ojkpoOJTFVeQpVJ30vDCuGQ9Me714qIRHo50RIr+bpXDQKIkJgGVWJ3OnKlj84MAtjuef0rxkqJxqyO9/zx5ZzmyEY/OgZshHhpliLgwen25P4rl0K22DG2izuypxvQhr2Ye5e3f9vxODPRdDIPt9U/A3umXUpuxdCyTavfkmsZEjExZR+cY7uJltdrGD5hbeCmCckzDWzxhQNIBGX0SEzXwCoI+mOVS4Z2+9Zc1V34nZOyHtzZCIV++xi8VnU5MxqCJ7UsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by IA4PR11MB9324.namprd11.prod.outlook.com (2603:10b6:208:569::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sun, 23 Aug
 2026 12:27:38 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 12:27:38 +0000
Date: Sun, 23 Aug 2026 20:27:29 +0800
From: kernel test robot <lkp@intel.com>
To: Fan Wu <fanwu01@zju.edu.cn>, <gregkh@linuxfoundation.org>, <tj@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <chenridong@huawei.com>,
	<driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Fan Wu
	<fanwu01@zju.edu.cn>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] kernfs: recheck of->released after acquiring the
 active reference
Message-ID: <202608230046.Ixvo8Av6-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821050720.14848-1-fanwu01@zju.edu.cn>
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To SJ0PR11MB5214.namprd11.prod.outlook.com
 (2603:10b6:a03:2df::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5214:EE_|IA4PR11MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b54583-06a2-4923-3ea5-08df0111eb1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: Da/+t+rwVcsIf8ruhO5OQdO99VNsfuGdc/XLz3H7scqZUh9prXN2sx23OFNxagLxwfeLGB8SF+BoLZe/s/Gvhfs/2TLS21vra03ZDZnGbu5gIwkctXFMAZBDZ7MSNqBk/b2cl4PFjEUF16B/4c1rM3TNIJiFh2DhiyStICU9N5pd3mNU8hrVcAM9IrMB5QMAQTnkbix1RYlNOsOQBc3kYHm4k1+Otb1H6VQ4VDfk+XDtC4b4ClLcNGrqMkHVC2fSt2aUSID5vTQ/wib3xDURmEQsxDrDLfRdxVErjsPzS5BeoUAQnNPsHa46Hn1+i9aphZPOro35W7GbD5DnB3NpocHpgeQ5ydmnEFFgGqVhfofgRr7LPQbiGOJl1EqDZIA4ckEx1ajBSTJ5h9yrfSDezSWKCeXre1g6DFE8FTUWTYykhrANwhOeCeQm33JYQfVatxEf6seAc3QMY+nE5GePiiTQ+cFaq7/rISlQNZPBSzPJ8t1FD6OJKjzJpm6wDrnLXfQa2VoYpfE81st3tQ7p+At/gc6CJlhpAxPLvvFSgbxxYH6V/iv3T2XCXFA99zjje+VrxTZViUBBCE+dvwTTDroH1XeFUkbJIWpftgdTKoKEdjR8s08uk6VzBhrjKGkm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5214.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pbzQDxHtgA+IkjlDu7fsY+464E3Cyn8Qkv/qNyQU1JuX8cDbb44zLxXdCOCM?=
 =?us-ascii?Q?c/iHBv2Ukttxv57IXoMOVnlRoRAf/zv8dIyKAUGlqJ4eV7zxmJjr9xlEpVie?=
 =?us-ascii?Q?lI0YVQX3wCt6xUsjAAsOUrZmnuookc4KFUq4zhKI6p5GbXtl/wCWcL/cCxn5?=
 =?us-ascii?Q?JYY45NUJHO9YzCcwfIBT1+sC8kfd+HDiENcZIxg99SGmllO5jjbGUaH1wnkN?=
 =?us-ascii?Q?FO/OkhwWEDWNuM1V6+d9O9jaV1wgI9GIzGRn939yXbCIq2aLU4pWAjzvU1Pt?=
 =?us-ascii?Q?YnLxpMvivSiBYAk+WTpgD2ZqrZ/VgzrEYBwrf8Pi2OmG+bMvuSQgM9bd+sFj?=
 =?us-ascii?Q?Dbq8gmpXIw7Q7M1zkv/8uBQajEjWMZWErieHfYMPuWNFFE1Qxb2oKlJ3cOye?=
 =?us-ascii?Q?329r8TA7D9c5qYFJpDNOFacNsHtgRjmLvtZpt9gyJWgFRpbm+7Op5S3v6Sm5?=
 =?us-ascii?Q?nU4m5+8D1F3LBqgsELRp6gTFrADUdTPQOoLMTrChV7UFZsJSnnBVped9KRiA?=
 =?us-ascii?Q?iGSg5hbeYondY/oqeskwnJceAzbhAS35o/ry6482z2fMSx11Sl9C2ev/qP8u?=
 =?us-ascii?Q?lgJIvntLdpiY2MHkKnZ5O2BogjTygZi77ky+WAEiiIh37huB47cPaYd0Tql0?=
 =?us-ascii?Q?UD6xkFiXMTGYcPx5LlYsJtnF2+m2eRc+KM0UAak29Ts9Esb5nVNLCYcc21fZ?=
 =?us-ascii?Q?PkOne3JUKY4hRqqR3mCl9pIf0F3C9H6/nN6ReqQv7qOCQ47O82F3DsTOhTtc?=
 =?us-ascii?Q?oAbhzksYdYFUoaXT/cMff/XN6YpAV4w4RM8ValCVnXCoNZBJdAYuu1vcRcCK?=
 =?us-ascii?Q?faCVFy8f2i6Uthu7A8xO8TckORdAYVviyPJSs256IgrEXCo/ENIWTsVT8rQO?=
 =?us-ascii?Q?vnVa4Cqe9Q2n696GzDGjU5vj1wYDy4s1xiabx4C9Mpi8jxPMNXCXJ3o8Xb62?=
 =?us-ascii?Q?d/zett4G0oD9L66zd7GB8Ff3VpbzC8gfjzLWNRBhKO5pvCbYB6FQbvmUzfAs?=
 =?us-ascii?Q?jlHKJ02RrR79kkH5yoD3+5XxPo6peGRIgSpMh1o7ov+U4JT4UN5PMTVQgI9V?=
 =?us-ascii?Q?x8w6yeDPNQfDnqDmEBDVK54/BV9Bj04JreiB+0yX0lhDZZscU2v8Ix2l2q2B?=
 =?us-ascii?Q?xdWcI/yhk7DUuOmNG+/Iult87sggWqxnTulzwZ9VE889TXfT0htQBvNEPo7G?=
 =?us-ascii?Q?npoj+b5GfRX2+3abJbnaa9uhUlDhLg+B9xDX/5wU10uUTuGYHOxs4sAfaH25?=
 =?us-ascii?Q?otvz/MZiQ7ltPHrgBsKkzxXpuClLx47YezC+rnxxsEsrOM55ZuuhLjUV5MlR?=
 =?us-ascii?Q?A913td6zdb0L+XxdJgbN7+9dZpTlEsrkkECmOSbwZY8xGba7dqSaX026HxEe?=
 =?us-ascii?Q?Dlx0kXgxbJQxzKX/hzilEnrEk1+Xn8nHvTBRH9K2PpL6d+c4Pfpn6cx6pZqd?=
 =?us-ascii?Q?pReLPubu2nmSNBVbxR5+nrc2mQTWHgdXYDMzeGDqz8F0dtODGyQRHS6Jmuo8?=
 =?us-ascii?Q?ErYAbITN7gPU//vAmHydGt6va0osQiDX1tRV1YwWejlbQHFyj7nYkbXFNq5i?=
 =?us-ascii?Q?EJgVy92WnubcRyUrHZg78fN0DyEP8RB6cfXtvkjxB9CMWTKVXzlkmfT9Zx08?=
 =?us-ascii?Q?ewhe5iIVZ0/GnJTK5sKS6pv3k8c/g/XeE43C4MM2KGa1vCpUXqnSwTN4R+qU?=
 =?us-ascii?Q?jaPAit9CDjXRf0AlLDp3DE2lG1Em+RUmFNlqDQL/ugKyKo55nyzN5/6ajnkn?=
 =?us-ascii?Q?deAF3uauCg=3D=3D?=
X-Exchange-RoutingPolicyChecked: JDmaF94GbPW01C6u4LM+Ol3bYa0yo1P1Oor+64f7ZF/gQnE97zU31j/fgIz+ldsKgrWaPNNrK/bUzx6tGHs8zrptuKHSH24HaEo4xO04fmNivgbe2brxofwF4o0KaNZ0hjOMDF1DE3gIggN1WTrJ5i7k4iLJ7YI26VtioNdLZwGs98d9P/ocltznoAU/NEF+XXQeCW9cV0Ze6w+4SOdf36eH9m9L49g2kNzq/h5wdtlBb8M/tYooWSrl7pIhBYCTX/5XS5Uy5cpqecU72t6yLGn5a02iQwJWOFRzJ6TYzw26watZ/OAQytEugf9LNdURAEHeeD8tDU5DC8GZb6j0IQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b54583-06a2-4923-3ea5-08df0111eb1e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 12:27:38.3029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QODcGbKbpSXAuBJaH108MmdWQbTbibWUzO+DQEkI2yGFRkW/CJLfCCG7sYb95TqCA30PtdhBfX2CX65yAI9L6A==
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
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20260823/202608230046.Ixvo8Av6-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260823/202608230046.Ixvo8Av6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608230046.Ixvo8Av6-lkp@intel.com/

All errors (new ones prefixed by >>):

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
   include/asm-generic/rwonce.h:36:54: error: 'sizeof' applied to a bit-field
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
>> fs/kernfs/file.c:76:32: error: 'typeof' applied to a bit-field
      76 |         if (unlikely(READ_ONCE(of->released))) {
         |                                ^~
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
   include/asm-generic/rwonce.h:44:71: error: cannot take address of bit-field 'released'
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


vim +/typeof +76 fs/kernfs/file.c

    65	
    66	/* Get active reference to kernfs node for an open file */
    67	static struct kernfs_open_file *kernfs_get_active_of(struct kernfs_open_file *of)
    68	{
    69		if (!kernfs_get_active(of->kn))
    70			return NULL;
    71	
    72		/*
    73		 * A successful active reference prevents a new drain and orders this
    74		 * check after an earlier reactivation.
    75		 */
  > 76		if (unlikely(READ_ONCE(of->released))) {
    77			kernfs_put_active(of->kn);
    78			return NULL;
    79		}
    80	
    81		return of;
    82	}
    83	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
