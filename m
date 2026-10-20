Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792512535;
	b=3pxQAhE1lRCy0qcV9FXcPRtS/R0Et5TXlw3R7pyHqFjbPfxSoAvKWxdUL7AzJgCeYwz4
	 HbW37o4lm16wiy8j/RTnTqyn3afbaZB2q8mNc1h8/QzXh1D+HbpAuMOUAj01I5aS0bo9W
	 GH9bbAKnC9Kz75c/ZMxP3bXlJzmPCeyJvM2zMM2PVEn+wvXDmPiRErd55ug8B2h9Be2B9
	 MUWLTl1+PyTfOMxbElhbcnKRQ8XeNyYJOLVFPHoGrMHqt7pZ8JzD/m/t1Hs7Ek+CIc7EC
	 8RTEwtVnfG0B3Z7NiROKP8934fygkUwUhLKn4mZzPpFwnIC5z1FIi4n7xC6VSSUhGZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512535;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=TOBdch3KcTiFVy6Sr9h4lalCWpLQYLmhW0grplj0TVk=;
	b=YaSsywSQHjN+BP8a04MZDsbZMms5CAqBfnNjxGl5oSvd5qLOYX+f/dO+q3r2K+Vuq+Lm
	 vj1RCTVWi0XjpBSFHzeInX7cUICUJAQuyiJJmHo9yECgE7ccxikMYVgBLUg/FDPUOaGIu
	 a6M58GXJGkzVjHBg0IZ77FJfbyWdClNxN/GqLovRpCyaJ6g4com7LGN/XUxyYQ1CKY0aw
	 IcXZYfxPPWre4cliilNDTddEHi0pRDpvFzrrfIuKjrI2QgP+N21hMFQB9i5z2FTq2Zi4d
	 VdTwekE2eG787c3Shbcqd/MCLf8EL2LxFwqe3Uz9yCP75J4FMYuI4U6UBmkyHAfOytg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z4DVi9l+;
	arc=fail smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943A1606A320
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 16:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 943A1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z4DVi9l+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792512533; x=1824048533;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=aWU1mEOqv26OBoUm+Q+WJ8Yr05LJbj+6ZfX5ncM8ojQ=;
  b=Z4DVi9l+/SdbrpqdwbDarpz/6jfbSEzVBBGSxZULH3cThe8FVWxOZsAO
   vwT2mbhyCd0S29OV5LxoHUqYTIRnHXZVia2u2jwait8HLu19bWEbdZtyy
   8ARlg1/GCNVMHbOjU/FA6RjI1glOYM9EPNj5OJ/CNYIDjDe25zAQt31TX
   7a/+ogb7TkPWFi619jkC+NrrNcq8pVr35gS3KTACktja9eX6OP43wiCDP
   uH3A0kPRKJBjQzdf9E/DLCAZhdNYzzXaGwPbs4FgzsfohsVhtRLj7iFgs
   DgALUDA3X1eL8G8MILwiCtd+Lc0515ukg4Oov0MPKhWqaVekNaeP6o5CE
   g==;
X-CSE-ConnectionGUID: njKXpSToSPaJllPMHK0kUA==
X-CSE-MsgGUID: V6rAZ9yNQVCr3fee2v/wSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1110187"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1110187"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 09:08:47 -0700
X-CSE-ConnectionGUID: NqNpb1x3Qu+aOtz1+IVW7A==
X-CSE-MsgGUID: BS/g7d5ATU6mJZUjXy5/QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2797371"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 09:08:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 09:08:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 09:08:47 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 09:08:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhHPK8n5ztU4SI75D74+zg2LZvr0x/c1StOLQwtvp8ZCCO7C3qU10sH/DSn0aib7AfhpW3UsyYfacizdzqsRhUEoHXkz7lYLJIhXNia0QN9RaSSvbXQDKOmhS+emB+Wi4ln6Ka5/3mSB9l/4MAbw7umzW5M3uWU9AHeYh3VB7VKkRGiz1zPW6N33ddicluEr0KmizW2EF7vmn0oSxw9C0u9aDuX0FCQN2JNGj2tNUeXUYTqnYWFenidwNMh+GwhpSqglf4Q5M3FgEH8WCJRTkB4htN6gUsVL0chQfqJqyadKfrx+1OWfSoif8CsPqH+cC8ya3RDkrcZL1uHS6OS0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Bp3IxdP7aqhgoUy2Vh+xG5xcNUKhAaKQZsNBUA+NnY=;
 b=qu3AlbXYQlz/AJpgePx+13Hx+kUNGuB1LdmYD8xJNomFenaihUIXM15F2KYVddXvM0yzRxggYwzi5GqLbu2xOknTZp4VVD/n7QOO9HcmNf7soDfo1BcChOQp15UXvb3D9xlZSpBH7xBL0uhqMF4VZRjeUVYfgvfldjQDAs2eT9b3kWHtcyOjrearJPNwT6Wd13EntZaWW19t+XqSO/sNCB4coxM1ELecTbBMPqXueK4xpKlE1E+ckdp9pqZXrWM5rY8jPZ/e6lGgbJ7DDNKl23MH9rn2CETTIe31cDGPWNGUtJIJyGn8iIgynyT1OqxT/IeAPGPkJgCRgyP2XpaDsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS6PR11MB454219.namprd11.prod.outlook.com (2603:10b6:8:4c8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 16:08:45 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 16:08:45 +0000
Date: Tue, 20 Oct 2026 09:08:43 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	<intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Don't fail runtime suspend permanently on VRAM
 eviction -ENOMEM
Message-ID: <ateSC6dTa0M3Qc8n@gsse-cloud1.jf.intel.com>
References: <20261020100545.46715-1-thomas.hellstrom@linux.intel.com>
 <atduGDrVk7kc-PPe@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atduGDrVk7kc-PPe@intel.com>
X-ClientProxiedBy: MW4PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:303:6a::24) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS6PR11MB454219:EE_
X-MS-Office365-Filtering-Correlation-Id: 921f9fea-9e67-4feb-5bb1-08df2ec46ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: X6P7h4J1IfWfUlEP6IDX7Xpz+KTx4daRfl2Fxnu+bBRb3Gnut1sR1cY9QgNZxtjidRpyFN3qNk51knQwyYrvS6d5jJyxZTfVHQX6F073aFxJ2GWYVKKjkshdK0Wu1MKaNByxxZwK3j8fNkFWGFYq//Zgc3c6xHORvtQmd5ogSwc8BseMKRQWq+mL1e6w3r/KPgwAIGHIOCBhudA76Rl375b9+hp3sFmTEq/AgQsYP72KYSmNxEWXvMPnaEw3Ica10htwzJ3ErraZl56qNWxFhuCxqrzulSGcxUnY6faxQKRt6MQU30piSi1xOymR1a7vqFs+9oFRGo+ZPkNCOAvFyO4QeNbGH2IR93Ykf5Q8V9QDl8JLkOM+Jq4TD5TovE19mtx/Eos82WdsX6bBVqJ1Rog9u0q0MMlQTtGvmV+BBtzrgDZepoQnNaEPkQu66iTtFbIbt6MRzFfxuPZ8eICHVDnYFOM6Z75c9T5Fdu+m+sZ2DCxMBh9e0sdidTConuwvPNZ3QUoN+Dl531uFyC5EAbRsMy0HchVKageDqGtxO/JnkzRRIRAT1mtVzXcQhIAdCAHiDN96JpaVovbNbGlLJi3G+byOVCfQkraA9Xt8Hfp3SMH7K6vmSFYFzWalSxM07DZI7HKynbeqtogFwU2RfynKT1W2ITA5oTlN0r9jnhY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QyKh5rWoSaDBoo2UM0GdYxVcZV0kZHEkgTRPIlZLltTRBcd3c976iQA/un?=
 =?iso-8859-1?Q?N7MkGQOvYQ0cjGoyBDLqzkPsaCBUQ1itWfH59BX8tbJSZB2CKXTwOE/+Ir?=
 =?iso-8859-1?Q?NwsDa0IIpXWjaHSIJZa/Ow9LfFxSGm7l4DDSX2AspoOVWM3Lr8g2jLAxSu?=
 =?iso-8859-1?Q?wI9dRVE/7uDwYjq7srZddyzDv/uq86sqUh4h04nTrYE/0uZYxBhPC2PLc3?=
 =?iso-8859-1?Q?J9eBIJ0Iixkzfw1da9uSRyAozpQtjEa+LCp1j77QlsgTnyMLTqoBRqyhy1?=
 =?iso-8859-1?Q?szN/fGDyTDOCJdE/vO1u+dCMevgaYkabwQZGhqjnfdX+X+IX1TKnCAwNuW?=
 =?iso-8859-1?Q?Sbd30RvMogIxNXDH+o9hDmOJb3FvhOM3hDNmr9Y0C3wd/4qUxwWT4hhxDO?=
 =?iso-8859-1?Q?uJTqRiWSL2u03vtEgYW208siVsJY+QVeWnw95ItPwroCI7g5cNc/w8r2KU?=
 =?iso-8859-1?Q?DyxHrMroTWlapjqHczJFkk5+BTdMls6BMH6+sIIq484UOHMn7NJ+FqrJg+?=
 =?iso-8859-1?Q?cWXmYrIXAtSc1i9om6iZJN8aC2QMjqgDuEsLdHIhlE6OdvAS2UtgxOJe/Y?=
 =?iso-8859-1?Q?ZMHbDQwM8gtD9YqHSgx5r2AQ92+kvSFKm6J+dZI1MUBUO/PXWS24qnhDl8?=
 =?iso-8859-1?Q?vjXSKpVvGuKvqtdx+qb8BkbxcdW2ZUuAXYCe0BeN9eNyBbRzMpPUAToAvJ?=
 =?iso-8859-1?Q?pRmtomoncyRMU5uafmkfYVkLnYlbHlRi0SAzIpaVdsDttp6b8g5rxPVzkZ?=
 =?iso-8859-1?Q?NZXYGf+/5PkdZH6N+DnEfwbniuutm/RhnR+5QoxJ03vUGK9TWL2dTWd05V?=
 =?iso-8859-1?Q?pg+5enrp1EBUoF3E8JwGx9vBXpePHlwd1tqBYk17wnMCgJgG1ADTX84RLS?=
 =?iso-8859-1?Q?tVZngsTlnflJqwPcoQn3+DjCgdwByij4LXD0IfSVI+7BfDLe92PywNEEpl?=
 =?iso-8859-1?Q?Pk8k1yWMOC2O8vFZVmokWD3LUdoe6qBHIm6i0rQ5dLyjqZ8a06djJHGI7y?=
 =?iso-8859-1?Q?Y5TntVnVp2EI71JblJ3zpqLQE35JwPUvW7g7Mbmclxdw1AzihhwQPiHThX?=
 =?iso-8859-1?Q?bAkJQB/U5qOV24DJQ7EphHPWfbcdFih3LNx7xte87wI9G8tDdIVyA9+ocE?=
 =?iso-8859-1?Q?8X2EMQhSbf2bqTUxDbSXShFS67DndhFI/0h2t4kmzTQkGpf/RZoOIIVX2v?=
 =?iso-8859-1?Q?QGm1GDg06APLgG9Re/RR5l9RDKAkkG5P1iIzNT8MxlaD+kojNYqHVNsz4H?=
 =?iso-8859-1?Q?1DfYZuXGrQEFrBIqCqPzJiDd7nenf1mtcQu+hfBUh/MZqgpJYsZK5TaLc3?=
 =?iso-8859-1?Q?6NKI5bhEybrYZ6AoDitep5pMIaqYRacaV1x2J6SFt6Y4JxDJGEjy3u2gPV?=
 =?iso-8859-1?Q?pyifaCiVCoGL07gCbwRCbD2QOXQX6TskCZsWk2e9YyB0dvHC4Cvo4gMOaD?=
 =?iso-8859-1?Q?f4jsygkDudBK/jk8dJeLfENBOgpq9FdXYZikfCCF1KiAZhymVSt76F0Q9z?=
 =?iso-8859-1?Q?blA2nyEexhjWWPVTu63gbDnJZ+PfyEEiPA83nTCs39/8cyeVAJDsKdPMEz?=
 =?iso-8859-1?Q?vpMUCCvv42W4ET/xSgtpZomCxDD41RqFRF+0xr5RpxGM2zh+UKDT4BCPrc?=
 =?iso-8859-1?Q?Ip3yegTURxSG7+GThuNF23uwL3r/c8iCGqIFh7nCblMaqIL5cc1BIPKJah?=
 =?iso-8859-1?Q?NrJbsSBteWyW8cac/iAg2q5tIHFBJpZNEvGM2PAlAhBOmyZypLuu3bEfHK?=
 =?iso-8859-1?Q?tnFsFNqnAMlyDISJydHEGgjd41R+aH3i96SyL+lSu7i/Hoik6VBhoC3pjw?=
 =?iso-8859-1?Q?99vSaq/zew=3D=3D?=
X-Exchange-RoutingPolicyChecked: CmbMJCvnb0EDhKpWbJVyK47drGv8IY3vayRKu9YFa6sImtyh89C8FFwWhhZ29RsOuEft1iLwof/tAp2A1IuwS720eR+B+MU4tZesuyfiOraGBS4ctFIRrOloaUk+jPj+oMF9NNf9l8cWYCujzQu98em4vIRwK0ZLrjuRQYkecBHNIu30COPv+nSrlpEb9Jv1MM/qj6Pqhnq0VvDi/P+ZCL6LZrnCga3dX5EgUFWBIN6jxHGCY631dTz8hYxtBNOkh6S+Pj+5GGmKI2jj4Z7Ysqf/ptaikfJ7XKawWzNaGPDr4V/NHaSePUQEHZNwRCUjyrh1GXwqYfwfT8qDuIszaQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 921f9fea-9e67-4feb-5bb1-08df2ec46ac0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:08:45.0998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3XU5oH/CJClQODKpGeOw1gF+Wpmzm2d0sNNs9pwfM6BGzsmG0bm2t6723K8r92gxozSGz9KjHrvZC5sweqJJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB454219
X-OriginatorOrg: intel.com

On Tue, Oct 20, 2026 at 09:35:20AM -0400, Rodrigo Vivi wrote:
> On Tue, Oct 20, 2026 at 12:05:45PM +0200, Thomas Hellström wrote:
> > If evicting VRAM to system memory fails with -ENOMEM during runtime
> > suspend to D3cold, the error is returned to the runtime PM core.
> > Runtime PM treats any error other than -EAGAIN or -EBUSY from the
> > ->runtime_suspend() callback as fatal, records it in
> > dev->power.runtime_error, and refuses further runtime PM operations
> > on the device until the error is cleared.
> 
> oh!
> 

I'm poked around core PM code but had a hard time verifying the above
claim is correct.

Any code references to help me verify this is correct?

Matt

> > 
> > Memory shortage is a transient condition, and with eviction now using
> > __GFP_RETRY_MAYFAIL it is also more likely to occur. Convert -ENOMEM
> > from the eviction to -EAGAIN so that the device stays active and
> > runtime suspend is retried at a later idle transition.
> > 
> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: intel-xe@lists.freedesktop.org
> > Cc: <stable@vger.kernel.org> # v6.8+
> > Assisted-by: LLM
> > Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > ---
> >  drivers/gpu/drm/xe/xe_pm.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> > index daa7ba2df317..9bf57ed1ea59 100644
> > --- a/drivers/gpu/drm/xe/xe_pm.c
> > +++ b/drivers/gpu/drm/xe/xe_pm.c
> > @@ -649,8 +649,16 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
> >  
> >  	if (xe->d3cold.allowed) {
> >  		err = xe_bo_evict_all(xe);
> > -		if (err)
> > +		if (err) {
> > +			/*
> > +			 * Runtime PM treats errors other than -EAGAIN and
> > +			 * -EBUSY as fatal, so report memory shortage as
> > +			 * transient to allow a later retry.
> > +			 */
> > +			if (err == -ENOMEM)
> > +				err = -EAGAIN;
> 
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> 
> >  			goto out_resume;
> > +		}
> >  	}
> >  
> >  	for_each_gt(gt, xe, id) {
> > -- 
> > 2.56.0
> > 
