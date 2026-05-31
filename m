Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD433803D1;
	Sun, 31 May 2026 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780217119; cv=fail; b=PdG/3EgZt7Z1he8mfDVcMNht43dqK1UP/ZDHky0UD0ANhBotByJYiiYGpaPc2EyGSdNK4Pdmb7OhD80Qro7pAtt21HhFuY7Lq1iduvrdBIPUw09RlUAyPiyZoQBruWxSt2gm997chdoZOo9DhzivYS7Cy8aW3W93PefxBPfYqoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780217119; c=relaxed/simple;
	bh=ZEp+77RrPZRsTxYhpvZDuY/0K0E2mf/zchr7lhdQtI4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=haUA68iX2+DpfRymzF3PesiWONW+kcW3kZW/8dTsUZ5/AuMbbqwF80nNKPbF3uFG0fUuGp2yVM/OFI0meIRQQVnV6jsDYZnFcShsWFkJHQxbMto+E5oJcwLGncKCRl4QkghAS4uWEEc1MuvYzPMO40EfIR+gCS8gYzDJo68y9ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YgzOFGXm; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YgzOFGXm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780217117; x=1811753117;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ZEp+77RrPZRsTxYhpvZDuY/0K0E2mf/zchr7lhdQtI4=;
  b=YgzOFGXmipAip8XmeQy3Y8JLUyjazhBMOooyO8l9uUKY3B1XnUtDIHtF
   qjyP8R22lJgvfd78iwyM22YXeOlqCkA4eUFQqDdWA8VUbFhFX2H9aNYfn
   XnxPGiZ1pr0vuWFGEz2KLFkh/w+Km4ayRlmRzshV/QQXcqaexAT5Zh8PA
   I2kUBeYxGVmiL595pRuInSwPaqLkozL2/dUaCy1Z3DSUMgVdn5rtt9gf7
   7YLiFndqimyoBsMU5Zzla3iwTpriaO8iVkZW2hpOkgXe7a0wf8hGg8YqV
   J2JYxQF+VNTheazZ/sq8R9iWVo4JqS+cLpg2Ynd2O5ycWhoaFc0obTrqL
   Q==;
X-CSE-ConnectionGUID: cfTUpvZpQfGRT8lw2Nm8VQ==
X-CSE-MsgGUID: ZSX11EwdRviBWDQCOKSJWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="68537229"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="68537229"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 01:45:15 -0700
X-CSE-ConnectionGUID: 1t9qvdeJQ2ikMsSEP1HX1A==
X-CSE-MsgGUID: ubiV9E3ST+CgmtwpxrO0uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="245101985"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 01:45:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 01:45:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 31 May 2026 01:45:14 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 01:45:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSTIJ9VJvFY/y5X+moty/ToZiseNoMwTanU1RsSP1RaG3NT0mgn+x4vH5v4Iil2LHtAVtpgxcqiyHVQz/cWVJZtQ6Yz2T2tKwajQxCRNZh1gR2G+Y0mou+tvl7Q8lDY+vUs66K4Ui6wADP9j2kDYAQoWWWy4vicNjRT5GpYcVWfhhvfxZ8IRtySJd2gRCKi5msX0LvTU5IdPPxrZaOD7AkyiepVoEvadHFtZO6jjyF4GFL0JTf8W0JdmhZ8HXKEQnO9OxD8FF65bC0C95LS2D3YWq2dHzKDyJ/rTtbZkGkgk0eB65ikFmOh3UXzU8RLjaiKdsBeJNSPw8xe20I6nNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OscKAq1gS0+dysQvodnl+CDSyI1sCzFIGtZLlNmEHOE=;
 b=dNhmg1LQX5+KL63/YYzazR/fhYN2uCh2QBF29MU9c3f8vmxRn6F4XF4NHCyWEG2rDB/TfRvSLsN6WWVlGoPZiw/Vrc0ehETSkkzsNd0YR5hO6ZFPe6Ds07qxRMpLgymWtPn2I8ndM2j/Ca97EqzWGAmQyAKVauPJSKgM8IACXXUN20BNWWK0U04MFQLgu4gCFpvXhzVQ2M79wokchrMg+tB3PiJ53jghOrmIgr4A3njimflCGfQjeMqsFE4XDtmhXvEYaItmHn3wsVL+x8TN3s3UXYH1V4yZEG1bmE/2iZwujfB/1SA0TwV+a/OuBj3O7rAEsI0q9oAZpS8b8DgfUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by IA1PR11MB6217.namprd11.prod.outlook.com (2603:10b6:208:3eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Sun, 31 May
 2026 08:45:07 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0071.015; Sun, 31 May 2026
 08:45:07 +0000
Date: Sun, 31 May 2026 16:44:59 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	<linux-kernel@vger.kernel.org>, Wentao Liang <vulab@iscas.ac.cn>,
	<stable@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH] block: blk-zoned: fix zwplug refcount leak on write
 error path
Message-ID: <202605311048.34c03950-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260526141824.2293025-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|IA1PR11MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f696dc-1013-4887-9383-08debef0ea75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|11063799006|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 64XLbm77IcD4RB4xFy8Uh78KvSXEiOlQZ4ZnfvefQnyGT/AgNNsifvt0phboHENWjBWlxpL9sdsDSWiSiMchOotetWkdYaqpa8+26N+z2wd6lJAcjNuJyNI8coWjyYd6Fry+2jcWuNCdlYk7n+i7i44zCI+UW6oHHSGm4Zt0xRg+q1VspNMfek+C60z5c+h/SSEJINRvdn4SF8A6kvYnxSytG/F/kfFEjJhW0MCWU0G02rjZol8VT3+A7OW193bL9T7xwA0sjIopIbrps5nUtwHvXMLiugqFDiKS24Jnc6GQLPYRJ56+vhjPevGQF4oFgHMswjQSBxLf6zh0tVi7RK8JEDJD8kYJKMw8L3zV4jlfB+zuvA6lZdHLdMo1veqPurSsMX5ZHSLfoPTXYI9i1nDCiaYNlv900+1GnCbyQD8/DT/Tzm4TXugBdYSqTlunUrHZ3UfjOUUmJWwwOxiJH0JzmGGG9aVGnqIhOoYGyoDDoaAQ/wFaMbwULNnS+igNVt5dV2GkugekekDQhXRVSFJf92qkf9hr/Ugl4G1mGzrHBEkE03N79HfkVNyET05VfM/Ba1W2cnuNNF+eY8RUczjgtWXMeNmzXsq5k7SQKc0Ixpnnpw/VOjMBSunnCUA1Y/cz2b8TU1Le1Pd+RptvFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FqIQ3KL8kSiu+TRmU6xtqx4rHGcysh0R4hoP58hBz/3va+A3fC9xuosT0rzl?=
 =?us-ascii?Q?79csjoSp9Fu7MHP6wnpPN1txG29SM6j8fECWiub8p03fJiDQZfKiHbGChWkr?=
 =?us-ascii?Q?sFxPga279B8zmNGcqIEUX8a9/XI/t2v9cIXAeXj0kScbKimPM2vWMUrJZbbr?=
 =?us-ascii?Q?4oHdF40DgFK0soHyP6KNFhKH6tsY4zL+pO+YqH9nccaDGQgGf+TW/CPjVIm1?=
 =?us-ascii?Q?wXSaDgonHZc19Fexe77jAgwFinLpvLeYJD7RfvUO1YQwKajYt8hnRARMKzmK?=
 =?us-ascii?Q?rEd/qVKnK/HZ3sIS/M7qWO72+tqX8udDeZ+U2cBUFX6t1pwSuWBuS6SxJAHn?=
 =?us-ascii?Q?Fd+40ZB+ATlGMz4JM3BoiO4rxT+RiJ4fmzFcFY6bgf2JQlupfH6Th/NWOBWo?=
 =?us-ascii?Q?r7i9MgG1QWpmrYAhfpnlRcrfrasw1HDHKeI1X3Qp2xXHVN20knbWvdWtnDUK?=
 =?us-ascii?Q?oroX/hENZjwfGGGYyFR8mYgfBlLONJ1N0FcSrGHC6qgVD+XKLvhP3ZDo9vNu?=
 =?us-ascii?Q?RW2ohGUSHhDqe9q2uqgDzVRXUwcw9xTrYVHUv5R2J39zt5C8Pv+PBPfZc4Df?=
 =?us-ascii?Q?apM8s0lMGea7h8yTX9OfIJJqxv8Iat4lNtEjK2CcaNZrqrqr45ebFbZ6BDI3?=
 =?us-ascii?Q?H8FAuMbhZIhUoiam2C2vSZ+An4bqgNnZ/OI4SdqhBeuQ7P/B2tCMSmob/Eg7?=
 =?us-ascii?Q?CEaNxYBeTuiRsRoEvADqBo7EKHAD1WgsapX6a/wXu7wBZ3bGzV5YbV4I/rpB?=
 =?us-ascii?Q?jDBmZyjUC2FQ4NrR6xQu535C2HErnHf9Zz5BMCkkhligyEYGb7bgJdVNGOny?=
 =?us-ascii?Q?n+ROtUr6dmFwUtQW68BMVY8jBHORh12seHQc/TCTtiPup3QDgTEraN6/AVfK?=
 =?us-ascii?Q?hFVCtLf37Jimk3V+BmefWuIirzkNePyQrzV7TYLDSO58dToLvzUKCdPcOI7X?=
 =?us-ascii?Q?plxcP/AyzA9difIDQKhLI7snmWQ1A2zVbB18oJxVCxcPE8eVRhMBZZ/RusIR?=
 =?us-ascii?Q?EXE8/OFMOLRTLvRYanx4rXzRdsr3Tf3OEw+EORNrVtQBbsQe9pFuwQ451Mx/?=
 =?us-ascii?Q?GWy6frWWZFlpaN5F3433PMJfE4QPnmgrvAi7kwwg5Ulx9RYucaoF6X8D/W//?=
 =?us-ascii?Q?RfTEnu0L6fOJ5E97IaAEeSHzoqQkms6MxfWl0BFvKQXZoQ1OWDaIMe1FZnv2?=
 =?us-ascii?Q?B4KFpOeHFSeQFbCC50wOovZWUUy8Lx12mVepfU44hRSPS/jiuhXohJd6N+4Z?=
 =?us-ascii?Q?+JL1Nr8oC7nuq+2uDXRInlzjVeJOVyZR9kkppSLASE6C121QJ+vCW5bQSNcT?=
 =?us-ascii?Q?rFHspwQIRh5+Aj6TG2ssbM8imlUXayJIuyLG8j3sj01o7oJ9tmksvWhiC+1S?=
 =?us-ascii?Q?igblp39MRpQjgt3C8SXzGaVUwjn/5PpukX8SpPdUpcdRUVfqQ3oZSsySIm6V?=
 =?us-ascii?Q?H0/mdmL1WKipg5cecySJdqj6hCLwxjFJhHPo/siUjau3rRbkKpEhaTax6Sic?=
 =?us-ascii?Q?hqIVLGo+//JwJiZ9Fs3cXx6xDWw78/a8blmL+NC+PADNxeqwDHCwAdmYxBL+?=
 =?us-ascii?Q?YH+GWZgnFEh+AdSC9gJQyLQqhfaPjKI54VlJiyJZFkmZVM3EY1d7lnzfUr2B?=
 =?us-ascii?Q?z8YQSM5qzXODmktOK/b1nxWFBPXgdRHU1gGVX/N5neiWBnssmyLYRSvdWJA/?=
 =?us-ascii?Q?S/MQzVrelHOrM/DnA3xw/8XzfmQVeBFuXZ0KYfya4HRGGkrWiKHrhi8uI1gS?=
 =?us-ascii?Q?JHSNipFkIA=3D=3D?=
X-Exchange-RoutingPolicyChecked: aJxrpSe+NunxmBkoOjMP2j0vlEbTj1tsGVud9BLIVfrlKfFgJYjuCwKvG2L7d6mvQQTsXWY10GfdWj/NMwLt+aqQEr9h+voVE904783bGRq8D6Dcuiae5+71RmwGQ06twQu7qQuhAwIuSKKpikAik4RdSUVhi5O/paWw4nGWrAih8qytjMHejt85GJaR4dWJSsicANYPBkszvycwkt2+L9+OyvmHoBOCS49onxQISmAkDYr7wL4NZIJDo9yyyx7cVSqfhSwoui8u82L8wBX6hUOdfQ68KPxlCO1vcrI870A5hgIr3EoTl2HNC8YWxhObQX0neFfozARQPooEb4P7HQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f696dc-1013-4887-9383-08debef0ea75
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 08:45:07.0174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZAwMbTXA3HJ5vAmye1K/e91GCGDcGkJgEmhurC11g8ms5HFAEFSlmQkVPdInKMnkezRg9JfW4SmtOPE8gJG+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6217
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "RIP:disk_free_zone_wplug" on:

commit: d9343256aa173471dbb7f3e02a2177801f2f2136 ("[PATCH] block: blk-zoned=
: fix zwplug refcount leak on write error path")
url: https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/block-blk-=
zoned-fix-zwplug-refcount-leak-on-write-error-path/20260526-234750
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux.git for-next
patch link: https://lore.kernel.org/all/20260526141824.2293025-1-vulab@isca=
s.ac.cn/
patch subject: [PATCH] block: blk-zoned: fix zwplug refcount leak on write =
error path

in testcase: blktests
version: blktests-x86_64-9131687-1_20260529
with following parameters:

	test: zbd-004


config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G=
 memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202605311048.34c03950-lkp@intel.co=
m



[   38.687737][  T420] INFO: lkp CACHE_DIR is /opt/rootfs/tmp
[   38.687747][  T420]
[   40.261858][ T1207] loop: module loaded
[   40.340461][ T1252] null_blk: disk nullb0 created
[   40.341026][ T1252] null_blk: module loaded
[   40.347691][ T1255] null_blk: nullb1: using native zone append
[   40.349880][ T1255] null_blk: disk nullb1 created
[   40.402539][ T1255] run blktests zbd/004 at 2026-05-30 10:54:31
[   40.445801][ T1286] ------------[ cut here ]------------
[   40.446398][ T1286] WARNING: block/blk-zoned.c:590 at disk_free_zone_wpl=
ug+0x26b/0x330, CPU#3: dd/1286
[   40.447008][ T1286] Modules linked in: null_blk loop btrfs libblake2b zs=
td_compress raid6_pq xor binfmt_misc snd_hda_codec_intelhdmi snd_hda_codec_=
hdmi snd_hda_codec_alc269 snd_hda_codec_realtek_lib snd_hda_scodec_componen=
t snd_hda_codec_generic snd_hda_intel snd_sof_pci_intel_tgl snd_sof_pci_int=
el_cnl snd_sof_intel_hda_generic soundwire_intel snd_sof_intel_hda_sdw_bpt =
snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_i=
ntel_hda soundwire_cadence intel_rapl_msr snd_sof_pci snd_sof_xtensa_dsp sn=
d_soc_sdw_utils intel_uncore_frequency intel_uncore_frequency_common x86_pk=
g_temp_thermal snd_sof snd_sof_utils snd_soc_acpi_intel_match snd_soc_acpi_=
intel_sdca_quirks soundwire_generic_allocation snd_soc_acpi crc8 soundwire_=
bus snd_soc_sdca intel_powerclamp coretemp snd_soc_avs snd_soc_hda_codec sn=
d_hda_ext_core spi_pxa2xx_platform snd_hda_codec dw_dmac kvm_intel snd_hda_=
core spi_pxa2xx_core i915 snd_intel_dspcfg snd_intel_sdw_acpi processor_the=
rmal_device_pci snd_hwdep processor_thermal_device kvm intel_gtt
[   40.447061][ T1286]  processor_thermal_wt_hint drm_buddy snd_soc_core tt=
m btusb platform_temperature_control iwlwifi btrtl snd_compress processor_t=
hermal_soc_slider drm_display_helper spi_nor btintel processor_thermal_rfim=
 snd_pcm irqbypass think_lmi cec processor_thermal_rapl btbcm rapl intel_ra=
pl_common drm_client_lib btmtk drm_kms_helper mtd intel_pmc_core snd_timer =
ahci intel_cstate intel_lpss_pci processor_thermal_wt_req cfg80211 firmware=
_attributes_class wmi_bmof bluetooth pmt_telemetry video libahci processor_=
thermal_power_floor mei_me snd spi_intel_pci i2c_i801 pmt_discovery process=
or_thermal_mbox intel_lpss intel_uncore libata pl2303 pmt_class i2c_smbus p=
cspkr idma64 spi_intel rfkill soundcore mei int340x_thermal_zone wmi intel_=
pmc_ssram_telemetry int3400_thermal acpi_thermal_rel intel_vsec pinctrl_tig=
erlake acpi_pad acpi_tad drm fuse nfnetlink
[   40.452569][ T1286] CPU: 3 UID: 0 PID: 1286 Comm: dd Tainted: G S      W=
           7.1.0-rc3+ #1 PREEMPT(lazy)
[   40.453213][ T1286] Tainted: [S]=3DCPU_OUT_OF_SPEC, [W]=3DWARN
[   40.453849][ T1286] Hardware name: LENOVO 90XW004HPL/336B, BIOS M5LKT1CA=
 01/06/2025
[   40.454439][ T1286] RIP: 0010:disk_free_zone_wplug (blk-zoned.c:592 (dis=
criminator 1))
[   40.455005][ T1286] Code: 5d 41 5e 41 5f e9 f5 fc e2 fe 83 e2 07 38 d0 7=
f 08 84 c0 0f 85 82 00 00 00 41 c6 04 24 ff e9 15 ff ff ff 0f 0b e9 2c fe f=
f ff <0f> 0b a8 01 0f 84 f8 fd ff ff 0f 0b e9 f1 fd ff ff e8 bf 7a 61 ff
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	5d                   	pop    %rbp
   1:	41 5e                	pop    %r14
   3:	41 5f                	pop    %r15
   5:	e9 f5 fc e2 fe       	jmp    0xfffffffffee2fcff
   a:	83 e2 07             	and    $0x7,%edx
   d:	38 d0                	cmp    %dl,%al
   f:	7f 08                	jg     0x19
  11:	84 c0                	test   %al,%al
  13:	0f 85 82 00 00 00    	jne    0x9b
  19:	41 c6 04 24 ff       	movb   $0xff,(%r12)
  1e:	e9 15 ff ff ff       	jmp    0xffffffffffffff38
  23:	0f 0b                	ud2
  25:	e9 2c fe ff ff       	jmp    0xfffffffffffffe56
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	a8 01                	test   $0x1,%al
  2e:	0f 84 f8 fd ff ff    	je     0xfffffffffffffe2c
  34:	0f 0b                	ud2
  36:	e9 f1 fd ff ff       	jmp    0xfffffffffffffe2c
  3b:	e8 bf 7a 61 ff       	call   0xffffffffff617aff

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	a8 01                	test   $0x1,%al
   4:	0f 84 f8 fd ff ff    	je     0xfffffffffffffe02
   a:	0f 0b                	ud2
   c:	e9 f1 fd ff ff       	jmp    0xfffffffffffffe02
  11:	e8 bf 7a 61 ff       	call   0xffffffffff617ad5
[   40.455652][ T1286] RSP: 0018:ffffc9000179f4d8 EFLAGS: 00010246
[   40.456258][ T1286] RAX: 0000000000000000 RBX: ffff888883a71800 RCX: fff=
fffff8293c99a
[   40.456863][ T1286] RDX: 1ffff1111074e30e RSI: 0000000000000004 RDI: fff=
f888883a71870
[   40.457503][ T1286] RBP: ffff8881efd97000 R08: 0000000000000001 R09: fff=
fed111074e30d
[   40.458107][ T1286] R10: ffff888883a7186f R11: ffff888200fac01c R12: fff=
f888890e92940
[   40.458785][ T1286] R13: ffff88889dac03f8 R14: 000000096a349520 R15: fff=
f8888a6d6b780
[   40.459408][ T1286] FS:  00007f265573c780(0000) GS:ffff8887cd24b000(0000=
) knlGS:0000000000000000
[   40.460016][ T1286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   40.460681][ T1286] CR2: 000055b746683f88 CR3: 000000019ef16006 CR4: 000=
0000000f72ef0
[   40.461295][ T1286] PKRU: 55555554
[   40.461905][ T1286] Call Trace:
[   40.462554][ T1286]  <TASK>
[   40.463161][ T1286]  blk_mq_finish_request (blk.h:548 blk-mq.c:786)
[   40.463864][ T1286]  __blk_mq_end_request (blk-mq.c:1164)
[   40.464518][ T1286] null_queue_rq (block/null_blk/main.c:1703 (discrimin=
ator 1)) null_blk
[   40.465132][ T1286] null_queue_rqs (block/null_blk/main.c:1717) null_blk
[   40.465828][ T1286]  ? __pfx_null_queue_rqs (block/null_blk/main.c:1326)=
 null_blk
[   40.466460][ T1286]  ? _raw_spin_lock_irqsave (linux/instrumented.h:55 l=
inux/atomic/atomic-instrumented.h:1301 asm-generic/qspinlock.h:111 linux/sp=
inlock.h:187 linux/spinlock_api_smp.h:133 locking/spinlock.c:166)
[   40.467069][ T1286]  ? __pfx__raw_spin_lock_irqsave (locking/spinlock.c:=
273)
[   40.467748][ T1286]  blk_mq_dispatch_queue_requests (blk-mq.c:2903 (disc=
riminator 1))
[   40.468362][ T1286]  blk_mq_flush_plug_list (blk-mq.c:2991)
[   40.469031][ T1286]  ? blk_account_io_start (blk-mq.c:1145 blk-mq.c:1121=
)
[   40.469695][ T1286]  ? __pfx_blk_mq_flush_plug_list (blk-mq.h:364 (discr=
iminator 1))
[   40.470310][ T1286]  ? blk_mq_submit_bio (blk-mq.c:3231)
[   40.470968][ T1286]  __blk_flush_plug (blk-core.c:1229)
[   40.471617][ T1286]  ? __pfx___blk_flush_plug (linux/list.h:46 (discrimi=
nator 2))
[   40.472224][ T1286]  ? gup_fast_fallback (gup.c:3202)
[   40.472917][ T1286]  __submit_bio (blk-core.c:1256 blk-core.c:648)
[   40.473551][ T1286]  ? get_page_from_freelist (page_alloc.c:1866 page_al=
loc.c:3946)
[   40.474215][ T1286]  ? __pfx___submit_bio (blk-core.c:1257 (discriminato=
r 1))
[   40.474900][ T1286]  submit_bio_noacct_nocheck (blk-core.c:721 blk-core.=
c:752)
[   40.475528][ T1286]  ? __pfx_submit_bio_noacct_nocheck (blk-core.c:712)
[   40.476196][ T1286]  ? submit_bio_noacct (blk-core.c:881)
[   40.476875][ T1286]  bio_await (bio.c:1499)
[   40.477495][ T1286]  ? __pfx_bio_await (bio.c:1471)
[   40.478094][ T1286]  ? bio_iov_iter_get_pages (bio.c:1266)
[   40.478753][ T1286]  submit_bio_wait (bio.c:1517)
[   40.479354][[   40.483105][ T1286]  blkdev_write_iter (fops.c:722 fops.c=
:790)
[   40.483748][ T1286]  vfs_write (read_write.c:595 read_write.c:688)
[   40.484345][ T1286]  ? __pfx_vfs_write (linux/percpu-rwsem.h:131 (discri=
minator 38))
[   40.484934][ T1286]  ? __pfx_css_rstat_updated (cgroup/rstat.c:548)
[   40.485546][ T1286]  ? do_syscall_64+[   40.570578][ T1287] ------------=
[ cut here ]------------
[   40.571274][ T1287] refcount_t: underflow; use-after-free.
[   40.571922][ T1287] WARNING: lib/refcount.c:28 at refcount_warn_saturate=
+0xa9/0xf0, CPU#12: dd/1287
[   40.572594][ T1287] Modules linked in: null_blk loop btrfs libblake2b zs=
td_compress raid6_pq xor binfmt_misc snd_hda_codec_intelhdmi snd_hda_codec_=
hdmi snd_hda_codec_alc269 snd_hda_codec_realtek_lib snd_hda_scodec_componen=
t snd_hda_codec_generic snd_hda_intel snd_sof_pci_intel_tgl snd_sof_pci_int=
el_cnl snd_sof_intel_hda_generic soundwire_intel snd_sof_intel_hda_sdw_bpt =
snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_i=
ntel_hda soundwire_cadence intel_rapl_msr snd_sof_pci snd_sof_xtensa_dsp sn=
d_soc_sdw_utils[   40.572665][ T1287]  processor_thermal_wt_hint drm_buddy =
snd_soc_core ttm btusb platform_temperature_control iwlwifi btrtl snd_compr=
ess processor_thermal_soc_slider drm_display_helper spi_nor btintel process=
or_thermal_rfim snd_pcm irqbypass think_lmi ce[   40.595153][ T1287]  ? __p=
fx__raw_spin_lock_irqsave (locking/spinlock.c:273)
[   40.595903][ T1287]  blk_mq_dispatch_queue_requests (blk-mq.c:2903 (disc=
riminator 1))
[   40.596653][ T1287]  blk_mq_flush_plug_list (blk-mq.c:2991)
[   40.597402][ T1287]  ? blk_account_io_start (blk-mq.c:1145 blk-mq.c:1121=
)
[ [   40.617272][ T1287]  ? folio_add_lru_vma (swap.c:536)
[   40.617965][ T1287]  ksys_write (read_write.c:740)
[   40.618658][ T1287]  ? __pfx_ksys_write (read_write.c:724)
[   40.619354][ T1287]  ? folio_add_new_anon_rmap (linux/instrumented.h:82 =
asm-generic/bitops/instrumented-non-atomic.h:141 linux/page-flags.h:843 lin=
ux/page-flags.h:864 linux/mm.h:1724 rmap.c:1697)
[   40.620041][ T1287]  do_syscall_[   43.443332][  T420] LKP: stdout: 365:=
  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/igk-rpl-d05/blktests-zbd-004=
-debian-13-x86_64-20250902.cgz-d9343256aa17-20260530-48630-1qqgxqy-5.yaml
[   43.443340][  T420]
[   43.445914][  T420] RESULT_ROOT=3D/result/blktests/zbd-004/igk-rpl-d05/d=
ebian-13-x86_64-20250902.cgz/x86_64-rhel-9.4-func/gcc-14/d9343256aa173471db=
b7f3e02a2177801f2f2136/5
[   43.445920][  T420]
[   43.448290][  T420] job=3D/lkp/jobs/scheduled/igk-rpl-d05/blktests-zbd-0=
04-debian-13-x86_64-20250902.cgz-d9343256aa17-20260530-48630-1qqgxqy-5.yaml
[   43.448293][  T420]
[   49.435619][  T420] result_service: raw_upload, RESULT_MNT: /internal-lk=
p-server/result, RESULT_ROOT: /internal-lkp-server/result/blktests/zbd-004/=
igk-rpl-d05/debian-13-x86_64-20250902.cgz/x86_64-rhel-9.4-func/gcc-14/d9343=
256aa173471dbb7f3e02a2177801f2f2136/5, TMP_RESULT_ROOT: /tmp/lkp/result
[   49.435628][  T420]
[   49.438631][  T420] run-job /lkp/jobs/scheduled/igk-rpl-d05/blktests-zbd=
-004-debian-13-x86_64-20250902.cgz-d9343256aa17-20260530-48630-1qqgxqy-5.ya=
ml
[   49.438634][  T420]
[   50.297903][  T420] /usr/bin/wget -q --timeout=3D3600 --tries=3D1 --loca=
l-encoding=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-a=
ppend-var?job_file=3D/lkp/jobs/scheduled/igk-rpl-d05/blktests-zbd-004-debia=
n-13-x86_64-20250902.cgz-d9343256aa17-20260530-48630-1qqgxqy-5.yaml&job_sta=
te=3Drunning -O /dev/null
[   50.297912][  T420]
[   50.300165][  T420] target ucode: 0x4129
[   50.300168][  T420]
[   50.301778][  T420] LKP: stdout: 1009: current_version: 4129, target_ver=
sion: 4129
[   50.301791][  T420]
[   50.302957][  T420] check_nr_cpu
[   50.302959][  T420]
[   50.304375][  T420] CPU(s):                                  16
[   50.304378][  T420]
[   50.305812][  T420] On-line CPU(s) list:                     0-15
[   50.305815][  T420]
[   50.307490][  T420] Model name:                              13th Gen In=
tel(R) Core(TM) i7-13620H
[   50.307494][  T420]
[   50.308972][  T420] Thread(s) per core:                      2
[   50.308974][  T420]
[   50.310450][  T420] Core(s) per socket:                      10
[   50.310453][  T420]
[   50.311846][  T420] Socket(s):                               1
[   50.311849][  T420]
[   50.313233][  T420] CPU(s) scaling MHz:                      30%
[   50.313236][  T420]
[   50.314648][  T420] NUMA node(s):                            1
[   50.314650][  T420]
[   50.316064][  T420] NUMA node0 CPU(s):                       0-15
[   50.316066][  T420]
[   50.317507][  T420] 2026-05-30 10:54:26 cd /lkp/benchmarks/blktests
[   50.317509][  T420]
[   50.319031][  T420] Defaulting to policy_version 2 because kernel suppor=
ts it.
[   50.319034][  T420]
[   50.320596][  T420] Customizing passphrase hashing difficulty for this s=
ystem...
[   50.320600][  T420]
[   50.322106][  T420] Created global config file at "/etc/fscrypt.conf".
[   50.322108][  T420]
[   50.323861][  T420] Allow users other than root to create fscrypt metada=
ta on the root filesystem?
[   50.323864][  T420]
[   50.326241][  T420] (See https://github.com/google/fscrypt#setting-up-fs=
crypt-on-a-filesystem) [y/N] Metadata directories created at "/.fscrypt", w=
ritable by root only.
[   50.326244][  T420]
[   50.327687][  T420] 2026-05-30 10:54:31 echo zbd/004
[   50.327689][  T420]
[   50.329072][  T420] 2026-05-30 10:54:31 ./check zbd/004
[   50.329074][  T420]
[   50.330721][  T420] zbd/004 =3D> nullb1 (write split across sequential z=
ones)
[   50.330724][  T420]
[   50.332420][  T420] zbd/004 =3D> nullb1 (write split across sequential z=
ones)      [failed]
[   50.332423][  T420]
[   50.333796][  T420]     runtime    ...  0.246s
[   50.333798][  T420]
[   50.335223][  T420]     something found in dmesg:
[   50.335226][  T420]
[   50.336967][  T420]
[   40.402539] [   T1255] run blktests zbd/004 at 2026-05-30 10:54:31
[   50.336970][  T420]
[   50.338633][  T420]
[   40.445801] [   T1286] ------------[ cut here ]------------
[   50.338636][  T420]
[   50.340724][  T420]
[   40.446398] [   T1286] WARNING: block/blk-zoned.c:590 at disk_free_zone_=
wplug+0x26b/0x330, CPU#3: dd/1286
[   50.340727][  T420]
[   60.489873][ T1461] EXT4-fs (nvme0n1p3): unmounting filesystem 1516f48d-=
9247-4757-9a6e-5cfcf67431a2.
[   62.359503][    T1] watchdog: watchdog0: watchdog did not stop!
[   62.393655][    T1] watchdog: watchdog0: watchdog did not stop!
[   62.479655][    T1] r8169 0000:02:00.0 eth0: Link is Down
[    0.000000][    T0] Linux version 7.1.0-rc3+ (kbuild@6767f1d4f5ea) (gcc-=
14 (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #1 SMP=
 PREEMPT_DYNAMIC Sat May 30 06:29:39 CEST 2026

The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260531/202605311048.34c03950-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

