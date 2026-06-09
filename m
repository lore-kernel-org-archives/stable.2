Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D373B42C4;
	Tue,  9 Jun 2026 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022186; cv=fail; b=CPsUhGUnk6q7L5ucVyE3a+H27mmTesbkUmLImdZ4uKsm4nc/EuymDIWZH7xp7MGxjbVKvNoUjYxF+2Y3MYfagUpAaS4xC5B4KC1LG50ZO6I6/GdC7ujeGGmeuPkw6LSYMZC/FkCk1sqOlMNNDGBML6g+OqQYRJzC/mqaKvFm6/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022186; c=relaxed/simple;
	bh=cspfcIykxabaa6ZmO/XQxSpW38BYogewZIz65hArSHw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F+KstjRy0dzMVP4GGDNtsrUyfL52/dL4+/pIzvoSn5VqVY/LC2xo92eYY+s9SFnwW4kfENq/Gb0aK58muG4BYcQEuBgqIuMim/MXXm1fkZF0gbBgsN2BXyyuEodvSFHXPJY0UA2q7ZB8/OIJy8eMLuT/FDhav76P0EfKvsaah7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CPlMkFeM; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CPlMkFeM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781022184; x=1812558184;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cspfcIykxabaa6ZmO/XQxSpW38BYogewZIz65hArSHw=;
  b=CPlMkFeMPOXvfrgU+WG8xwYXOrXmyvhyhnRHGhzf5RDy6xqoQhVjBXN4
   PdzFhH8JJ3zdG9ekiHqAAr++QBXZlfwL20NEM4Tg6kdB2jJmX+cjZTgP1
   IDcus0do4Y5orYShJGPEAfm3Kte0GvuCkqRESXABViMFvKfSApAiGVS/l
   NAGO9TqaYWknxGCm7+vUDI8/8hiUZPlrbjOSjaIxLvJ79UH49Q9c2/59V
   t97eyCNXekciNc9nSZSVUGYgm+00n7bJ+u+C8QeYs1M8r6itt80aC9QpI
   yZnZrPotwl2UE67an3HwIHLyI+mL2ZeCsMHCEn++D7e1gg+sfuRovR8aN
   w==;
X-CSE-ConnectionGUID: jDUjiEl7Tau5l5J4TTvpCw==
X-CSE-MsgGUID: vOPYxKW+QcWX+/RDQqp7eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81837871"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81837871"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 09:23:03 -0700
X-CSE-ConnectionGUID: QWqydRBMRsOUqKR6VyV5jw==
X-CSE-MsgGUID: WhRdP5U5TD26uEU9Zqp6QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="241763019"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 09:23:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 09:23:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 09:23:01 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 09:23:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTTHvHyw36lp0W6zajl20WV6w2inLp1y7R3AOFUQJK+GI/YoALDKPKTS2d1yBbsKBmvQFRtG7ZV0vt0YwUKMifNgE29Quw/aVKKJw4GEq5fGRzDxBoX6Ocqz4j2Lez6quoP363IHa+21LbkNHrFMnHNVH1HoHW4SyO6pVsd31dO0U/cqzlUFnTDuJaLtW+7RS1CpIe2KZcc1scn1Tw4jn7GKnVHKEg+254dPRXBGb1Pl/sHFQAeIibFdUsgh3T6ZH7G7lU01n0l7saKu15c84WPHUkuWSr9++tmHKty3S7Brt5BIsUYIFbBm0Md2mTal7ULfzPd5akv/V9vfY+JLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qukX5CrFJiV5LBWdJhbnsSU6k7mWui5S9rB0Ed2cY0o=;
 b=iu+PlpDI7O9Nc4pY2DnpN9RBqyNRLDVaUFtrAmpOB8neGu0P8IOlAsQ8A7W6lz0VNraWkTHU/jDO8EYsmwFARw8vAsmmy2On4onI1PC8uvoOb8VBMisTMKDRNH8f9uXSPHM0php2meg120ySMIk+7bpkHZmbrYSduiVE1E675RVzzFoF/kbQs3rEmd5JPZ2DwKfz8zoyM7B3WDBGTe8p5HzDpHQ6o6jReG5xp44JoIqXbTxw0Rm73zeVId+qhydR5JHDuviloCVhU5jKVrJeI/f/e8rcvssLZJ9VLjuIdM1QZ0b3utOOJCmWCPF0+lJzdTdMCVF4G0bs1v1MO4mCbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW4PR11MB6714.namprd11.prod.outlook.com (2603:10b6:303:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 16:22:58 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 16:22:58 +0000
Date: Tue, 9 Jun 2026 09:22:54 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <djb@kernel.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Fabio M . De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Shiju Jose <shiju.jose@huawei.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Li Ming
	<ming.li@zohomail.com>, Tony Luck <tony.luck@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] cxl: Fix CXL_HEADERLOG_SIZE to match RAS Capability size
Message-ID: <aig93ij4dPosd0rv@aschofie-mobl2.lan>
References: <20260605180610.2249458-1-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605180610.2249458-1-terry.bowman@amd.com>
X-ClientProxiedBy: BY3PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:254::25) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW4PR11MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 62058b97-acfb-4521-4c0b-08dec6435e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vP1xHl5E+Nx5eWJ7JAdCUKMfWFndsR837hOhUcane3MQROKEtrchYXxb1/+LNEaO6U7pz/Eob3z8exczsZnUNiaDBpTvEPq1vidHvc1sPjkZ8zEwNVZBbkk86D58nNvTvHmj1E/ZrzWkIyJ0qH8nBCFZa0JmnAKqAsbWxBw0FVrefHapbE2VFTKwrCtPx5oCuoSlJf5jAR9pke8J+ECEGqaFOjfiyXTfinSXJKOhrRPHyK/aHSHhs6v6Fi+c6vOeAaodLY6u3/zvEa0c0+chaSyl+dpuTrbLgPQyAaziqefNY8Wttr9iV77v4f0X+2szow6GxCiIWwfsAOfCPKErcWanFQAtTWFurK/7YAhncEm853PWwVnY/+UzCCXJi+2MYQVlzNGoJPCutRQWu3PHjZu+UYjpWLYYfwSYa59OCo82Uw3e5XsYsUctpYUeYom4vaPmeXXI9cgkH2EavZbsnKLbdRoHPqgG58u+rI1Yp7eMY2mbvOAdtCSasabC/6ZSuc0mR3ywj83TFRGYQ9sEXN42nspW+Buj1grT8FI98duAqlB5frCXbL4DzRwort/wM10PbSmsiBj9UkEyrMixJT6lJ2FFgjXdEAxZa/l2YEklVd6sa5sFe+V6ZQ+I1g3msFPbt+lkvPTWXBWsYviYwJYbBVHYnQpJAhqI8Kh9XueIdj9iu8tJUyQxuITO2ZMP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b1+zBCmJkCuuYKI9SuJghpj5eq039/pufbxGUZjxZCyXyrVgBBg48J5LAgit?=
 =?us-ascii?Q?ohrFOHHMeqLITP0343YuDZBUU9x3XzclydbYLazQ9mk+vT77m9NeV10TwsX6?=
 =?us-ascii?Q?a4pnEI63WHxJmfLj+/yS/5vgYboFdTufgug2Wyi+BopfYQvC9F2AO8r2+0r8?=
 =?us-ascii?Q?dPpwt5eHtoHpSuc5fGGUpjaxoXE2j+NCPkRVe2McwiuUK1BudANAea9+sNV5?=
 =?us-ascii?Q?SnUE4cdmP6yfb4+RhZuvNzjLe9Z3n7CfLMF8VqrbqQd93Aie00ozR5zPxgLZ?=
 =?us-ascii?Q?W72wQI0YvnZRWbof6u4PGM55waBMnMSBzUKVvEtEWhVW6nRtYeQO+jdBaNDo?=
 =?us-ascii?Q?Hyf8XUTIzudSFxwo11VYi370AYIeeYAF12k4/5jF4jo7ilkdQftUl2X9eyWp?=
 =?us-ascii?Q?WNwWUZBKEVzH1HKiPJEwbkPYbfoawkxbbRUXAfqHZ3IXwcsdceFfnaFjGAA0?=
 =?us-ascii?Q?ljBaopt6yq6joNupdZdPAihPdDSeZLxku//WSCjlBL3ZWIlJPtF9K5B7lkD1?=
 =?us-ascii?Q?o3WMBQXXjKLQUMuQdE8J5vFqpJVle9a7I5Z+PJFtPRC1KsX9fG6OZPAnDFqT?=
 =?us-ascii?Q?Qoje1QnPAsit348WKkfsfD5UtBn1mKaxuvTKQACKWGnSmJDdFXuaDZdkexdK?=
 =?us-ascii?Q?5/UivBepQFIKsdMcadlkFO+QQkfgvVxDI6JL078jrkai9JJdTf5gaWoZxBFU?=
 =?us-ascii?Q?Bamu+a4C/c0N+5GU8R6u6RNRcBoyZN/C8yYqFr84GzLvFB0sCbeUsFojLKbt?=
 =?us-ascii?Q?5gmbFci/gI6SSU2OcidYaG2bpRFLld2RTjyb01NP9mWBRDR6b4LCobtgmeMv?=
 =?us-ascii?Q?WaD0rUYOiyc/n9PciRqmJuueB1kfMe6d2zQ2iTwZG5QHP1iR9Hl8/hoEnmZy?=
 =?us-ascii?Q?nFC+c8uPoe8otYcv7yz9KN4zv0K4vzyp+mIhNUALbBrxt1H3QNpdWwFMBiBD?=
 =?us-ascii?Q?jCYodC6YSbsppDyEI7xtBCIa7XuQeqYrbNtW7bEmeyyOyxcvmo8j9ed2JHf8?=
 =?us-ascii?Q?EOkMqdW+fTQVWIjdJQAk6z2cPMwTBFQJLVDDIm37ZOjobNEcHA2AWYrjaP0R?=
 =?us-ascii?Q?JRc8kFZvff/wi1qQm+9EXFL+7uywpXYWcExd8QWp6l7EdpT8wYNYaOHB44VN?=
 =?us-ascii?Q?GqDQI+Dsca4L3brGUT4QVCv5vvBL+aovwA/nLb249MKTnPxi1Aa6749aKM6H?=
 =?us-ascii?Q?mHXdKMpBGG5SNmNSKocfFuO1v4KGrHHrEUufJE7EIm847qSeuVf8mPE0zMFE?=
 =?us-ascii?Q?gTmlWC8d3PTxamCfG2qaqTuwN1jZv/8PORs3DF2ODjpWnCA3ccqd0i8Wtrow?=
 =?us-ascii?Q?x6KWqJyI3t+nbLt3MLp8VZnm054JmQ6n6BA4szHphdXZ6MbzJiiLUXa+EXE/?=
 =?us-ascii?Q?UUYF5YwJcOHFHWMQF4KscmGH/jB1ZsS6juPBxjcKJ4bu8TrpVIGTs9oETKaO?=
 =?us-ascii?Q?quAhew7VMrxzdE6MyfQTuQ1irowotIJ8+3RBo6wCQVhrb563ix5/4FYokYDf?=
 =?us-ascii?Q?pGnQD3uawA5BDiM2tc2QMcHUsBe69OwEb7mkEoYB1LEcKpz86HaB2YkMAdgU?=
 =?us-ascii?Q?f0opi2lh83DUNPkRuC0OoGaqfW4r2B6K1Jj4Axyx0zAx9yIH+Wv5zXVEGPBT?=
 =?us-ascii?Q?Z53qpMFQN2T9bL62D+fZCqhCA1ni0rjSU/IoZqLb/XEd4IfZrRnQMtPuy0ZS?=
 =?us-ascii?Q?SRi+PUb9gL91R9860LPf6KMIOCsyKQKVqq9gMmfbK1sh5bWvVFXdlbMkF8Dg?=
 =?us-ascii?Q?BsVKoO3Ape5ruSobCoIQ55NmzgSMSmU=3D?=
X-Exchange-RoutingPolicyChecked: niJa67qmH49qKVFpA1x3vOBhcUSSuN7yz33Is0QBY01Ya1WXgCaacIWnUP4/onVQl+loQ26Plp1ph4vqBE48qt7pgK7eh0W+U18WgbIk1k2CLJPIoZcUk64/z7M5cyW3S5fQWCLw4fIeF0Qkoxy3OBA+bC8QxdZ6TcqthRxvwkaxqwQjXvu94vUlTUFufzGiGuBIvHEf7e56KVWKv/YCiTxqjs/JjVE5ijNnQ9wIgoY9l8SwDtLk8T+mQxhtKcX15uMTspGeae5fzNEgelShDlt39oxk4Ey3/CjYkfAvi1702XNW09xziI1F28jM0AZJiMF9BHMk0gdI74PjKJe93w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 62058b97-acfb-4521-4c0b-08dec6435e93
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 16:22:58.7144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRRoCOt3O/D8yP9W9ITuP8A6d3A0ZcZGSAm7YjFkDkecAEFVfstBSR5rCIC6vQtm+36Jg5/a5QgL+kLfpgWDckgG4aOTvja/yUhKD8tzv+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6714
X-OriginatorOrg: intel.com

On Fri, Jun 05, 2026 at 01:06:10PM -0500, Terry Bowman wrote:
> The CXL r4.0 8.2.4.17.7 RAS Capability Structure has total length 0x58
> bytes (CXL_RAS_CAPABILITY_LENGTH); the Header Log occupies the trailing
> 64 bytes at offset 0x18.  CXL_HEADERLOG_SIZE was defined as SZ_512,
> eight times the actual on-device size.
> 
> header_log_copy() reads CXL_HEADERLOG_SIZE_U32 (128) dwords from the
> RAS capability iomap, overrunning the 88-byte mapping by 448 bytes.
> The cxl_aer_uncorrectable_error trace event memcpy()s CXL_HEADERLOG_SIZE
> (512) bytes from its source.  For the CPER caller the source is
> struct cxl_ras_capability_regs::header_log[16] (64 bytes) embedded in a
> stack-local cxl_cper_prot_err_work_data, so the memcpy reads 448 bytes
> of kernel stack into the trace event ring buffer where userspace can
> read it via tracefs.
> 
> Set CXL_HEADERLOG_SIZE to 64 and derive CXL_HEADERLOG_SIZE_U32 from it,
> bringing all iomap readers into agreement on 16 dwords.  Userspace tools
> such as rasdaemon have grown a dependency on the buggy 512-byte (128 u32)
> header_log layout in the cxl_aer_uncorrectable_error trace event.  Add
> CXL_HEADERLOG_TRACE_SIZE_U32 = 128 and use it for the trace event
> __array and its memcpy to preserve that ABI.  Both callers now pass a
> zero-filled u32[CXL_HEADERLOG_TRACE_SIZE_U32] staging buffer with only
> the first CXL_HEADERLOG_SIZE_U32 (16) entries populated from hardware;
> the remaining 112 u32s are zero-padded, keeping the 512-byte trace ring
> buffer layout intact.


Reviewed-by: Alison Schofield <alison.schofield@intel.com>
