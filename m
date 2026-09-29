Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AA34D2EDB
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698278; cv=fail; b=Dcnhhlob1frMV7CWcgxAGGkiP+Likk8wtEB/6OcBTYozJyu5V9tBNfkW+3EzUVVFeRrM3ySPV29LseoQmodjd8w74v+ZDm9BIceuNmLvucoAwRr4dp0+dzqWelLpcdyYZEFUazYvOsZBrmICpFl9qsqD2jiQKQWtAMth2t7WvaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698278; c=relaxed/simple;
	bh=l15FMU74J8Ze2iIX74zMhjVeVjuv3YY+9K5bPfPSl4c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n8N3pLzFgiQPdoqEkoSLvLGEGVI50vRwTU//IPU1dtrSi79JgzsXWiuvvCpG+vb3I6e2WJsDwkeeoT/mLNYUkXLRZQgQxsKjITASrSDvsejct0de9XdQ7JasAGWfOL9u7C+62mhltSGYfOX/JchF8bePgndeBDy05PDHvzBVipY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H0CRFs4g; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H0CRFs4g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790698276; x=1822234276;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=l15FMU74J8Ze2iIX74zMhjVeVjuv3YY+9K5bPfPSl4c=;
  b=H0CRFs4gcnASCNaOMDOGU26MPwsrcK5BvDZ6cWkhijnB7zD5wRNGj9w8
   4LfyHt+YBmWwM2SAOs0LQYamYivRCWRzSgTVg7CCW33Mlu9y0Hy1joLKy
   hOdG/sb/xY9Ok/8xrmb+irf+B2MRUQH5aI7PwUr2oF3ase70xTa9hAXiJ
   Fh3ruNn+R3SMZiEnMy2cWEHga9Cswaggh0J4p7xya7tvGulI78usgmsFR
   J3JSW5M13WSPlwqzVJPQrXg+oCHzSKumM4C1aYYYoxS/F3WcA5RwWC6ZD
   hXINT94mApGRA3LNf+a00TJ9oG1KyVU1d8I69PG9FtNx4hxm3HCwzmxx8
   Q==;
X-CSE-ConnectionGUID: /I7hm9uhRoeOD19yba8itA==
X-CSE-MsgGUID: j+D7JGJzSEadhL1vEDkgPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90475031"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90475031"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 09:11:15 -0700
X-CSE-ConnectionGUID: cqmFXRLLTNim3uLarIcmLQ==
X-CSE-MsgGUID: U0wy9XLhSVC/mtTKuToUSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="274021959"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 09:11:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 09:11:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 09:11:14 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 09:11:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpErx3kljIX4iccxr1A6dit+B0jLLQ3NTE/yI9hmyKe/czN7xrRdiAFJXF3UjwoRuFwThN3X+Cn2JCVTzcPbUAwx8WhwYfFBMgPLbNNBYlQyrLutuj1Iv2jecNjgyjlvuKBSzvoFcYQJRbd0AGgwmCE96JXerkMKR71BIVEibD/7trKH4ybUIfVIimTjkrS0VeGisl0Un0oGlB+vybkGfkZPi65wbU4mWCCqDDSsGEWCmcmkhzhr99ISpHnHrKMKOfPRs1MkflZrF0mBgjkW99R4Rq8B1SMo8oW7rkLSAbHSaDRfjz9P5/FJG3rJrzMgl3ga2jY9cjzH65CRemRTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFMUzL6eAhO+kA0D+yXKdea7erw5jaILnjh4mcJHKTc=;
 b=UzI3tF/c/rYWEhVR0uy7QPMWEkQV92pNlN+uOCEudH/yIEh56xfSI4STcQ8FbISNdSCfhyut2pfesY3Wlqn+Pvcc6AKs++/sRu9RWUZWizk/nXj7YNTWxwhaLJDnm3l/ocZhTHYwaZeX7l0bXYrHB0GXH2PfuJoZmtAOC0U/XUQ8EYRwIHr8PBjX0JcPaRuEWjFVzOqa+PXzKu/hohlKL3nZcVd77MRLxRMcyXNhhpOuZKw2xpAFo4vTMGvEpuvBEFlf7UU4REWbN9jrY6xNFVw9mtowNLo1m4roKlDN+CYZkTrgfEj+uA9KNU7YGNptllRThLF9qr31V3EEKkBM7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by MW4PR11MB6786.namprd11.prod.outlook.com (2603:10b6:303:20b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Tue, 29 Sep
 2026 16:11:11 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0451.026; Tue, 29 Sep 2026
 16:11:10 +0000
Date: Tue, 29 Sep 2026 09:11:08 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: Matthew Auld <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/xe/dma-buf: keep non-p2p imported buffers in
 system memory
Message-ID: <arvjHLdLi3Vk5lDe@gsse-cloud1.jf.intel.com>
References: <20260928164820.1237049-4-matthew.auld@intel.com>
 <20260928164820.1237049-5-matthew.auld@intel.com>
 <arrjupxa6R+ehYK5@gsse-cloud1.jf.intel.com>
 <70ae41bf314d518215dda1f062b609f3dfac73e4.camel@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70ae41bf314d518215dda1f062b609f3dfac73e4.camel@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:a03:338::33) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|MW4PR11MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 627739e4-06a4-43b4-0b0c-08df1e4446e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|260925021311599003|260925021911599003|260925022911599003|4143699003|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rsncsDp4nkoLL6Z31wZg/mQQpbYwfsI9fAl3aBxsZjoEgD0SzX7Uc9Px9oz8VJFZ3nuep8xeWX+LJnvCytRArqExYLECcy42mTx5aAnZ5CkkOIbSxZqP5EhDcl+HOdTaGavdwAInLbNLgfo62I84CWoWlAguuOHzw+qBZ6kmManTBAxJ1W14KJU6lp3df64fL/U2MozQ1ggAfBxZBBs4DPvhJ/fPRKJuGAlYx2tergCn5ddq486IAuxQLJe/T2y0NvWvNSFX5/OAqp5da9qdx2V54tabQq50s0GHt+CMSS7hCxdYlVjlL2pjryzUGV21Qy01Ddfe8uOOxPimQDj+4jHaijEax7VbcgUSzhsZgzlUjAWFeRaF+51GU6yd/ei31zB4K53g4FBk5/PH95EOE8R17y7YMVZ/akNueZ73lxoESfwD2hykphhHArgGRqWsZUMn93qHnanFX9IisUwYjA07okvODRruUF0sZnryRt3eJLvWx3WkuoODv9uAJszjF15ARz0MJH989CoFkg/nfizkeVIOJfq1U+Za6R19in5Kcly9kOcrXMy4Jcm1MpsvhRxAxxrRJDrVLC01Ynd36Hlz+fzHEP0gz2WG7pwHjuKhkhrk3htd/dhKYNaBClp+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(260925021311599003)(260925021911599003)(260925022911599003)(4143699003)(3023799007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Z39p5eV0Y47br8AV1tsPH5U2AlARenq5RTnfCD50DUDt2zdflpsayFnUdm?=
 =?iso-8859-1?Q?ua/iwylgO3zsoQXl/YPG800o1IBB9yE+Z2n+xakyS2efF9gPU1PJLIZu1N?=
 =?iso-8859-1?Q?h0lzOFiTD7cfs+o+dChmZ7b5JSeq4mbztbALNlKLFzn0mialWqKmWdiYoT?=
 =?iso-8859-1?Q?RqjvkwN8repxo6MkUQUMTcOw+OxyE/1R3CI+/+MqS95x0To7HVvGlLaxsv?=
 =?iso-8859-1?Q?bbtCFtBJBtvQjvFa8ywfbV291OZptW96VT92UFazdXkbZcTqKAaTvffWcj?=
 =?iso-8859-1?Q?8HRj993KMWza35hLE8MgVfpwLooybXGPL1duH1G5RMxGUroCnRN01/pmoo?=
 =?iso-8859-1?Q?SjWaTZfJ7VFJUUIogfCSGVBQhATKxZAfC0bymvx/pxPJrcIhdED29CZc8a?=
 =?iso-8859-1?Q?bTUPigyCz6J6QiGLVu28+aRfHjXrYXBYQCzB/VbcD0iAxGNLRp47y5vsCx?=
 =?iso-8859-1?Q?HMb06nlPIoxzl31sm2ah1A5QoHXllY9yOrnh281iax9pNVa2cB/sEKqhfA?=
 =?iso-8859-1?Q?UDTxS2f41EbGMtkPpaOqI08h8OYIDFiz0XAL2jibafiEU4VZcxPqRAlIIT?=
 =?iso-8859-1?Q?3fC0KYJsJJ5KDLMHtbUROevu9kYa4ef7aomtg4bSF5kBdoMTJxkz5Oj3Uw?=
 =?iso-8859-1?Q?U0SUsdIvBmWYCPo0UZbaEQYHlhY4mocwRoy9sKyatlL9EU2GZSOmw8eq2Z?=
 =?iso-8859-1?Q?bm4eVXa4bQyR5GisxRHtKQWM7QyB9iUlj+ZVv5Y3UN1FTYz61U/E7tK6iT?=
 =?iso-8859-1?Q?69lPQwLRAT7sXB+rT+HC3mAFHVAQK7byu7CtmlnwLQwrFqq52Q3EzZrCgT?=
 =?iso-8859-1?Q?9HVeMvQsd3cQXds4MlXR10hl0WKDqyHuL9wxnUT9KmnjTM0M+sXgxnWZDH?=
 =?iso-8859-1?Q?khCT2/gZy/+o49rV9KgR5gwTcZYjFcUKsFPv6n78KqR58KI91LfvjPKgML?=
 =?iso-8859-1?Q?ysTg3t3clEDhs99ua/TTxOcLuVaW0nw5gsUtS3kDMzgugGP7Gm9Ht2Aq5C?=
 =?iso-8859-1?Q?qbRjQQwIKKI6d+wdtPjcHDhvEl194LhSKennjoRg16OjfIeGpQPkDfkfkC?=
 =?iso-8859-1?Q?xypWL0+sE6epjYdSenm51+w7VCChIPMlUBl+nfAmv75c7T7TDsFVcJWK5d?=
 =?iso-8859-1?Q?Bb/RNIUOeep05ciVPKQK/oqilB9qbMhmc9JS9/i51SMpI8oRj+75A/VcAF?=
 =?iso-8859-1?Q?4l3QraTRnD7YPv1NpxbXluBpqPgzw+z44CFYwtO8xb7dvUhs726Lj/fxVO?=
 =?iso-8859-1?Q?RpFxcLZQh93tygJcOg5NHI9Fjmlvt6Uh6O/KI781/prBaEbSuDT8KrFFPQ?=
 =?iso-8859-1?Q?ySCAGmv1vZneGe+u7Gp/Hx7I7n5LO7GJ+EhvURqYyNSa+1zBbr79ixToXo?=
 =?iso-8859-1?Q?+NWwi6swpwr4R2NPT5bbI0/fS7InVsSWuNdctszdjBh15i5DHRtLOOlAkh?=
 =?iso-8859-1?Q?mUFuTYRIdpvwELirbDUTXrPiQN3FcfKxnfgE7gOjTZDN0etoBUnszrbUBV?=
 =?iso-8859-1?Q?h4g7SR7vAUYYqQVY/+Re36BEX6+u7jzzFSCiZQXtepTxWJd1NYnE8bQRW8?=
 =?iso-8859-1?Q?WjzhHTsDLHigZ2VETU2wwVV8hNyGbaehsFilhYDfIHgTull3uXMPp2v24f?=
 =?iso-8859-1?Q?oeXGnVm30ZFlAZe1CaehigfSfv69qstcN2JlCtaKcpL2OFOjNhlB0Y1chP?=
 =?iso-8859-1?Q?hJA0APbe7Z3nsBktFASim87BjAPKlMu+XfErC+IUYvQffsm2FtwJALQpOt?=
 =?iso-8859-1?Q?MeEepuRDMeuyTn3Py/wSIzgXYASCqDNthP7qOItqKQD0isAQw7lYQrqt3c?=
 =?iso-8859-1?Q?1cq/NwQoHQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: WoEFzwWtV7ma33+0IF4gCO5bzDmCCFCGhfeZFnQxhekqfOOI8OLHVuvi1SffeVD2NR8P3pXHT6Yjn/Ldd1tLse6yRmqpmmw5N/ydaKFLbtc1DISImRu2xSCLdVantGKR1hfuD46hsLSp9k9RIqCjnJJu13UrFN5PnPQ+QEKmQKQr0xHqaGEdlicsSnwsq3gA0SdOE/FGGVavyKzvDU8fgRdBE72G5TXLgSVsDSUI2g7A/W7amjIzIJVc4c8geC3cy4OAyaPmqJ8O/ugFMawjzG4xon1jNohUbNxShThwEED56kUHI4Y/3P8eCgKwMlzv3ZngB68ilb22wgB1zhJsdg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 627739e4-06a4-43b4-0b0c-08df1e4446e8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 16:11:10.8840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBzE96C84x7xaylRdzDKiN7mX88qQ7t7bWI938+/W7sRRoM7DSSuPbori9H0Iwa30RSglYE7Clw75YtbfNKIBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6786
X-OriginatorOrg: intel.com

On Tue, Sep 29, 2026 at 09:56:10AM +0200, Thomas Hellström wrote:
> On Mon, 2026-09-28 at 15:01 -0700, Matthew Brost wrote:
> > On Mon, Sep 28, 2026 at 05:48:22PM +0100, Matthew Auld wrote:
> > > When an exported buffer is mapped by a foreign device lacking peer-
> > > to-peer
> > > DMA support (such as an integrated GPU for display offload),
> > > xe_dma_buf_map() migrates the buffer to XE_PL_TT so that system
> > > memory
> > > pages can be accessed by the importer.
> > > 
> > > However, since commit 5c87fee3c96c ("drm/xe: Attempt to bring bos
> > > back to
> > > VRAM after eviction"), XE_PL_TT is marked with TTM_PL_FLAG_FALLBACK
> > > in
> > > the buffer's placement. When DMABUF_MOVE_NOTIFY was enabled by
> > > default
> > > (meaning dynamic attachments are no longer pinned on map), the next
> > > xe_bo_validate() during render submission sees TT as a fallback
> > > placement
> > > and attempts to migrate the buffer back to VRAM.
> > > 
> > > On the next frame, the foreign importer accesses the buffer,
> > > requiring
> > > another migration to TT, resulting in a continuous ping-pong
> > > between
> > > VRAM and system memory every frame and causing severe rendering
> > > performance
> > > degradations.
> > > 
> > > To fix this, introduce xe_bo_migrate_tt_sticky() which records a
> > > temporary sticky placement in XE_PL_TT on successful migration.
> > > Subsequent
> > > validations use this sticky placement to keep the buffer in system
> > > memory
> > > until the non-p2p attachment is detached or memory pressure forces
> > > a
> > > fallback to the default placement.
> > > 
> > > User is reporting what looks to be exactly this, with horrible
> > > performance when DMABUF_MOVE_NOTIFY was enabled by default.
> > > 
> > 
> > The patch looks functionally correct but couldn't we just clear
> > TTM_PL_FLAG_FALLBACK in xe_bo_migrate for certain callers? Then
> > restore
> > it in other places?
> > 
> > Matt
> 
> Hi,
> 
> I recommended Matt to use a separate placement because the TTM flags
> are hints anyway, I think, and code becomes easier to understand if we
> make this more explicit. But that was just my opinion.
> 

I don't have a strong opinion here, so separate placement works for me.

> But anyway I see there are a couple of places we migrate where we might
> need to adjust the current behaviour accordingly:
> 
> * We have migration to TT for dma-buf CPU access.
> * We have migration to TT for atomic access, and then implicit
> assumptions that it will be migrated to VRAM again for GPU access, I
> suppose.
> * We have prefetch back to VRAM.
> * In what situations do we want to make eviction to TT sticky?
> * If we remove stickyness, should we trigger a rebind?
> 
> This is some serious technical debt we have. We probably want to put
> together a design document on this, but for the time being we need to
> make sure we fix that imminent dma-buf bouncing problem.
> 

+1, as it's good to audit everything, document the design, and clean up
any technical debt.
 
I'm fine with merging the series as-is. Functionally, I believe
everything is correct and should address the problem at hand. Any
remaining cleanup can be handled in a follow-up series, unless there is
something on your list that is a hard blocker. I haven't spent much time
thinking about the technical debt items yet.

Matt

> /Thomas
> 
> 
> > 
> > > Assisted-by: LLM
> > > Link:
> > > https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9415
> > > Fixes: 5c87fee3c96c ("drm/xe: Attempt to bring bos back to VRAM
> > > after eviction")
> > > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > > Cc: <stable@vger.kernel.org> # v6.12+
> > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > ---
> > >  drivers/gpu/drm/xe/xe_bo.c       | 59
> > > ++++++++++++++++++++++++++++++--
> > >  drivers/gpu/drm/xe/xe_bo.h       |  3 ++
> > >  drivers/gpu/drm/xe/xe_bo_types.h |  4 +++
> > >  drivers/gpu/drm/xe/xe_dma_buf.c  | 16 ++++++++-
> > >  4 files changed, 79 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_bo.c
> > > b/drivers/gpu/drm/xe/xe_bo.c
> > > index 6921b6967330..1c1eab0a7434 100644
> > > --- a/drivers/gpu/drm/xe/xe_bo.c
> > > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > > @@ -3324,6 +3324,9 @@ int xe_bo_validate(struct xe_bo *bo, struct
> > > xe_vm *vm, bool allow_res_evict,
> > >  		.no_wait_gpu = false,
> > >  		.gfp_retry_mayfail = true,
> > >  	};
> > > +	struct ttm_placement *placement = bo-
> > > >sticky_placement.num_placement ?
> > > +					  &bo->sticky_placement :
> > > +					  &bo->placement;
> > >  	int ret;
> > >  
> > >  	if (xe_bo_is_pinned(bo))
> > > @@ -3340,7 +3343,12 @@ int xe_bo_validate(struct xe_bo *bo, struct
> > > xe_vm *vm, bool allow_res_evict,
> > >  	xe_vm_set_validating(vm, allow_res_evict);
> > >  	trace_xe_bo_validate(bo);
> > >  	xe_validation_assert_exec(xe_bo_device(bo), exec, &bo-
> > > >ttm.base);
> > > -	ret = ttm_bo_validate(&bo->ttm, &bo->placement, &ctx);
> > > +	ret = ttm_bo_validate(&bo->ttm, placement, &ctx);
> > > +	if (ret && ret != -EINTR && ret != -ERESTARTSYS &&
> > > +	    bo->sticky_placement.num_placement) {
> > > +		xe_bo_reset_sticky_placement(bo);
> > > +		ret = ttm_bo_validate(&bo->ttm, &bo->placement,
> > > &ctx);
> > > +	}
> > >  	xe_vm_clear_validating(vm, allow_res_evict);
> > >  
> > >  	return ret;
> > > @@ -3891,6 +3899,7 @@ int xe_bo_migrate(struct xe_bo *bo, u32
> > > mem_type, struct ttm_operation_ctx *tctx
> > >  	};
> > >  	struct ttm_placement placement;
> > >  	struct ttm_place requested;
> > > +	int ret;
> > >  
> > >  	xe_bo_assert_held(bo);
> > >  	tctx = tctx ? tctx : &ctx;
> > > @@ -3922,7 +3931,53 @@ int xe_bo_migrate(struct xe_bo *bo, u32
> > > mem_type, struct ttm_operation_ctx *tctx
> > >  
> > >  	if (!tctx->no_wait_gpu)
> > >  		xe_validation_assert_exec(xe_bo_device(bo), exec,
> > > &bo->ttm.base);
> > > -	return ttm_bo_validate(&bo->ttm, &placement, tctx);
> > > +	ret = ttm_bo_validate(&bo->ttm, &placement, tctx);
> > > +	if (!ret)
> > > +		xe_bo_reset_sticky_placement(bo);
> > > +	return ret;
> > > +}
> > > +
> > > +/**
> > > + * xe_bo_migrate_tt_sticky - Migrate an object to TT and record
> > > its placement as sticky
> > > + * @bo: The buffer object to migrate.
> > > + * @tctx: The ttm_operation_ctx to use for migration, or NULL for
> > > default.
> > > + * @exec: The drm_exec transaction to use for exhaustive eviction.
> > > + *
> > > + * Like xe_bo_migrate() to XE_PL_TT, but on success records the
> > > resulting placement
> > > + * so that subsequent validations try to keep the object in TT
> > > instead of falling
> > > + * back to the default placement. The stickiness is removed if
> > > validation falls
> > > + * back to the default placement (e.g. under memory pressure), on
> > > any non-sticky
> > > + * migration, or via an explicit call to
> > > xe_bo_reset_sticky_placement().
> > > + *
> > > + * Return: 0 on success. Negative error code on failure.
> > > + */
> > > +int xe_bo_migrate_tt_sticky(struct xe_bo *bo,
> > > +			    struct ttm_operation_ctx *tctx,
> > > +			    struct drm_exec *exec)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = xe_bo_migrate(bo, XE_PL_TT, tctx, exec);
> > > +	if (!ret) {
> > > +		xe_place_from_ttm_type(XE_PL_TT, &bo-
> > > >sticky_place);
> > > +		bo->sticky_placement = (struct ttm_placement){
> > > +			.num_placement = 1,
> > > +			.placement = &bo->sticky_place,
> > > +		};
> > > +	}
> > > +	return ret;
> > > +}
> > > +
> > > +/**
> > > + * xe_bo_reset_sticky_placement - Reset sticky placement for an
> > > object
> > > + * @bo: The buffer object whose sticky placement should be
> > > cleared.
> > > + *
> > > + * Clear any sticky placement recorded by
> > > xe_bo_migrate_tt_sticky(),
> > > + * returning subsequent validations to the default placement.
> > > + */
> > > +void xe_bo_reset_sticky_placement(struct xe_bo *bo)
> > > +{
> > > +	bo->sticky_placement.num_placement = 0;
> > >  }
> > >  
> > >  /**
> > > diff --git a/drivers/gpu/drm/xe/xe_bo.h
> > > b/drivers/gpu/drm/xe/xe_bo.h
> > > index 861b1be231de..7327628070f2 100644
> > > --- a/drivers/gpu/drm/xe/xe_bo.h
> > > +++ b/drivers/gpu/drm/xe/xe_bo.h
> > > @@ -434,6 +434,9 @@ bool xe_bo_can_migrate(struct xe_bo *bo, u32
> > > mem_type);
> > >  
> > >  int xe_bo_migrate(struct xe_bo *bo, u32 mem_type, struct
> > > ttm_operation_ctx *ctc,
> > >  		  struct drm_exec *exec);
> > > +int xe_bo_migrate_tt_sticky(struct xe_bo *bo, struct
> > > ttm_operation_ctx *ctc,
> > > +			    struct drm_exec *exec);
> > > +void xe_bo_reset_sticky_placement(struct xe_bo *bo);
> > >  int xe_bo_evict(struct xe_bo *bo, struct drm_exec *exec);
> > >  
> > >  int xe_bo_evict_pinned(struct xe_bo *bo);
> > > diff --git a/drivers/gpu/drm/xe/xe_bo_types.h
> > > b/drivers/gpu/drm/xe/xe_bo_types.h
> > > index 8ec4a01a0092..253a1dba55a7 100644
> > > --- a/drivers/gpu/drm/xe/xe_bo_types.h
> > > +++ b/drivers/gpu/drm/xe/xe_bo_types.h
> > > @@ -56,6 +56,10 @@ struct xe_bo {
> > >  	struct ttm_place placements[XE_BO_MAX_PLACEMENTS];
> > >  	/** @placement: current placement for this BO */
> > >  	struct ttm_placement placement;
> > > +	/** @sticky_placement: target placement from forced
> > > migration */
> > > +	struct ttm_placement sticky_placement;
> > > +	/** @sticky_place: place for sticky_placement */
> > > +	struct ttm_place sticky_place;
> > >  	/** @ggtt_node: Array of GGTT nodes if this BO is mapped
> > > in the GGTTs */
> > >  	struct xe_ggtt_node *ggtt_node[XE_MAX_TILES_PER_DEVICE];
> > >  	/** @vmap: iosys map of this buffer */
> > > diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
> > > b/drivers/gpu/drm/xe/xe_dma_buf.c
> > > index 6a85b292dee7..b973579a69b8 100644
> > > --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> > > +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> > > @@ -59,6 +59,20 @@ static void xe_dma_buf_detach(struct dma_buf
> > > *dmabuf,
> > >  			      struct dma_buf_attachment *attach)
> > >  {
> > >  	struct drm_gem_object *obj = attach->dmabuf->priv;
> > > +	struct xe_bo *bo = gem_to_xe_bo(obj);
> > > +	bool has_non_p2p = false;
> > > +	struct dma_buf_attachment *a;
> > > +
> > > +	dma_resv_lock(dmabuf->resv, NULL);
> > > +	list_for_each_entry(a, &dmabuf->attachments, node) {
> > > +		if (!a->peer2peer) {
> > > +			has_non_p2p = true;
> > > +			break;
> > > +		}
> > > +	}
> > > +	if (!has_non_p2p)
> > > +		xe_bo_reset_sticky_placement(bo);
> > > +	dma_resv_unlock(dmabuf->resv);
> > >  
> > >  	xe_pm_runtime_put(to_xe_device(obj->dev));
> > >  }
> > > @@ -129,7 +143,7 @@ static struct sg_table *xe_dma_buf_map(struct
> > > dma_buf_attachment *attach,
> > >  
> > >  	if (!xe_bo_is_pinned(bo)) {
> > >  		if (!attach->peer2peer)
> > > -			r = xe_bo_migrate(bo, XE_PL_TT, NULL,
> > > exec);
> > > +			r = xe_bo_migrate_tt_sticky(bo, NULL,
> > > exec);
> > >  		else
> > >  			r = xe_bo_validate(bo, NULL, false, exec);
> > >  		if (r)
> > > -- 
> > > 2.55.0
> > > 
