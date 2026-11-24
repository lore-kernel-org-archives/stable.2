Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795550045;
	b=l1qGT/Im3RVFt+85cfxEUfE5uDAqZ4nKI0ohYvha0KBg3ak0107JvzLqOmfUO1olOk6/
	 N+8g7F3svyLSfNbEAzkLb/HaMO9WBTYe6KMggt2KLyJtw/DjXPD6oiQHmS3B23l4wb7dz
	 BOMXLn+VEzLvaDgejRV4zhoP+4nrapZYDpRtgRSAHYonNRZUxZ1Fz8ZKH0j2/U6oF8XDv
	 RkK1TTsQHsdEkCr4OV75NrZ+AABpqd8b1ng9ewNl1xba62nI4Nxs4Boi9pNtptEWTetTc
	 PiUg6XwxWKpTFQH3PwpMqRyT3T+TswZU+FXbvSWO6KSzc/Kfv2yv3D2cBMqbs1dkjXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550045;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=tccYbFpZjCmmf3pmEf41HOVvOO2Z3NAmXorWsvTXQ8k=;
	b=Wj5PA0IrLpJgpwOkaNQI7MEryaxe97DcTfWQjPBKlqYNOX1z4v8YVHpmZ0zDnEKAbJ9W
	 tOufLIeD0C4LKXK96y7mnXTBTLUKzFc6xoS0s3mSMImbd/DbHYcyhh5dTKByaGKzRutEY
	 8Agdw8PcWOkTZkXlDPSnLyCXVA5HQXGKKswn1IR6EOhLWbbHfxGwVQAXBCgsyslG88Y1h
	 0IsW0AIZHXaZU+qmnm/0teQ31mS6p17TvJnYav4nT0yj77UMC3vrAPLPTqwmoz1Oe0Gl3
	 0HRhRt308+S5baPqxsO98MkmHzr/AYmtOQruM4KxVoNZaNAHPMhIUXZnDCQplQF+57w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TO8Hod0o;
	dkim=fail reason="signature verification failed" header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=mvnRdQp3;
	arc=fail smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF42606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 19:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAF42606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TO8Hod0o;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=mvnRdQp3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795550044; x=1827086044;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Kwik0w0eXMSfYIZIoH1KgnXl+Ksuj58cWAIg2/zwN3U=;
  b=TO8Hod0oVBsgI2UZWgfa3a2sEh1UJ4B7jDJV07nTw/a9gBYQDKkCfwAD
   WhnosNdkvwvpjNG+Iyo32ZP0RIw0QQNjz87e6tIVLfAZ7gsUryCTmRNCQ
   9/DPVDl+2l/CkhrS4Bpqy7ee2gwXHs9bf4Hm6+K43bmCz1FT3MRlYrDRL
   2pO11VaBxPYTXdzTtLqySY8jLkoLP5LEbR4q2uTsFtcmUJ3lB8CSKp1i2
   tj9vxChK4SbC4svGgenurFBn6YBbDJArsuql4nXQ0LyNux3Hhb9/J6s8I
   jTg7A4hKSsyVPrajQSf2ZtJrZUu5kp43OglrE/YitdeNv7qhbnFEa1KvY
   Q==;
X-CSE-ConnectionGUID: LXSSIBr3R5WCAaaFYEfgYw==
X-CSE-MsgGUID: 7m5UlxmHQvKl/Ajp8/pUgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4292538"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4292538"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 11:54:03 -0800
X-CSE-ConnectionGUID: Rye4YY/YSY2Lrk2xrTJ+ew==
X-CSE-MsgGUID: ufonSIkCRfSHguEv86IRTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11998141"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 11:54:03 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 11:54:02 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 11:54:02 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 11:54:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJBGU4eFThkeoIQKaBjOAiu+5Ob9Y4DaZ6Q1eLRk67Yj5v0DzOlX38GOlyqeOQDR1LQsUs2y9i2qTq0DCzpNewwj89OaJJcCHkMd0juN2DlcQpYIyb7K5opjPwEd2d/V6gcQA+7r7wZssAJIBW0CW+6zUsQsV28PPIrX8Z6t3K5CE22xTuysckdKMcvdeDjsiAXpXbmeL4pCYW/oXNcRHes2o2sIkGZcFnOaFlU4GPDiaW8Dkw46PVQ0PIb0yW2mAoiKlifmAxXLNFVUiFJ/CYwky5TWlKNn7dxKx9kLzpYtqW/TjOzhrgzO7kOtjlswe5O4awj3SLfPIJCXnTETZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+cIPJSUB5F4Kstwt+e9jnlQ2A7vRsKRCNLYPj2HF4k=;
 b=tbwod+627L7ugS2J2Nvva4i3B2HOwvHib2Srwxg1bl1cLBPEK+YEKWIQCZFFjYM7VE5YdBBwUnu3NdeVkP9sjFXnXTFmkqemSKN0KdVflEfV8Y1egZWhK1AaUUq6XuEGM5QLurJSBQUtodrqfIo7w58WVlC1/9QeacVD7FKo1/EGFDFeYC+73J7sexblqSeuOJ/6Yl7vAyPfPxgHsHuI/ZgttNg6njAnp2gt+3JrkNdFRDHqRlsDICJ+yp736tH2WrrMH51KMI5d6GpsM0kQ3ONJ65u5u0pa1YggRcr0ZUO0z8C9U3MckuNiWYeHvGXTZ7tdachk7rJ01crBpnbA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+cIPJSUB5F4Kstwt+e9jnlQ2A7vRsKRCNLYPj2HF4k=;
 b=mvnRdQp3W1npp+Pxp0FTRPuE1H6B/QdB/RbCzHspQsJgL9IdetBNvpWwqryuI/sCc6LRDRPbZxyTOcmVgUh35V6ji7I4BJG/JthvPP4cVZtVK0X6LPjye6CjTVIAofN9zt/sMG/rzWR1QAlRGHfzi2zuuuYH4BaFWTTDYHTOXIo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS6PR11MB989080.namprd11.prod.outlook.com (2603:10b6:8:46b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 19:54:00 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 19:53:59 +0000
Date: Tue, 24 Nov 2026 11:53:57 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Natalie Vock <nat@pixelcluster.dev>,
	Arun Pravin <arunpravin.paneerselvam@amd.com>, Matthew Auld
	<matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/ttm: Destroy the ttm_tt in ttm_bo_move_null() when
 it's no longer needed
Message-ID: <awXrVdQKNToiLtmE@gsse-cloud1.jf.intel.com>
References: <20261124190954.47690-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261124190954.47690-1-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: SJ0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::23) To CO1PR11MB4787.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS6PR11MB989080:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dab9e37-72ae-40f3-ddb1-08df4a64aeb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|11063799006|56012099006|261021130227099003|261026130827099003|261022105027099003|261022115727099003|261022113327099003|261028144727099003|261022075727099003|261026121527099003|261026140227099003|261026135527099003|261021123027099003|261009221227099003|261021121427099003|261021135927099003|261009223027099003|261021133027099003|261102130727099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: epUloJUqnh6FJBMed3Xd0OdeAoVvs8PRJYJAnEuiZLrb/gZiSPEl7oJXnlp7BziUViBmpFEX9H2thW56nLGkSQ2swmqmzCydN2cSfgM2HrEVkkSiHDBqfS7ZTye4WiZ3hDidGAgD5XPgFFXldZ1loYBkL9467AWk5K2tSsZRxYc6iv2ANZgElJPlxfQt4OgWEZnqBr51sK6eYCi1FGfvWf9X4VCWerb7jO0fC3jPaqC2UqlMztSPfESG3fMITePa6n3HhEQwicw3NyX6k8QOj5vhzoegv4edWoemncawFV35PQVjscds4afhxILViHSTRUOj9mI8Bl7k/oMfHY2i9gUkOQ9F68WzWe+oITIJ7pA/tipNcJXhqryOnQ4NH+bAo0gClUjKrzrpqOB6kvbnXn1Zscnl8JVOY87I+AjKSxO1Zg1WVgo1xN0g9XXvMSycq88KgrEF9RnG7Jk9gNXnGtc548I+brVdMLi2Cm8mkBlLrXc7dh1ZbG86WYsw+2KWG9hOZdo25wN1gSei073cZ/+heGB8G66rW73xDYprEkFM5nnCAQz1FlhFKpu7NZyiZm5DoaXH1bns0BbbEnXp8eSqf0SA2qrwF3BGqpQDGunUtgKY+uABoFAKlJk3h0A030tu7bHur2MUoFH/+B9KzMCpu03pYqyh57KJMxVCsRA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(261021130227099003)(261026130827099003)(261022105027099003)(261022115727099003)(261022113327099003)(261028144727099003)(261022075727099003)(261026121527099003)(261026140227099003)(261026135527099003)(261021123027099003)(261009221227099003)(261021121427099003)(261021135927099003)(261009223027099003)(261021133027099003)(261102130727099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+FvSkRb9n/bVdC3URF5G2e0DCOu6kKJkZJZsOgTe81v6TnLFBLPH857VJg?=
 =?iso-8859-1?Q?N3fEx2dEjV401iuJuOv6acURA2eMhXZtbYVQ8vPP5rHmNRr8jOGELGW7ne?=
 =?iso-8859-1?Q?sU91N4O2PR1BelUNnM59/CUayc+Gee+g7l3VWp+4JvvcM+tp7xzY3ieV/1?=
 =?iso-8859-1?Q?2+KyLS6dZ6k4ih0dkYPIL5ChkWSVlOt7Hn6BtTNJvZQc4Aa/zP15s7jmPm?=
 =?iso-8859-1?Q?pz4aM+38RaoU0F2fZPLxe1MUous7R/IRDUedjCOPh250XVlUWUWQc5Zp+c?=
 =?iso-8859-1?Q?V4Q1eQ9TQeOhRXiDsOmRoxcPvIUXuq1tNcDeVGv6iRZFwhMOG2yZ8sxwDq?=
 =?iso-8859-1?Q?eg/aYorjiFu/IvQ5VAsqThS8aQZmL2ha5Pty2syuPOSx4FzZbM/WqwuC1/?=
 =?iso-8859-1?Q?lbPlrMOvI9cuu30Us4WSErTAUJn7s3kbvOlI9WQy2NeV98mTs/b95ueRqg?=
 =?iso-8859-1?Q?RIEzpABSvUU8LcMmiIGs6akxKewlmzsQduHxJdFFNCcsyTI8iOXvYeK72X?=
 =?iso-8859-1?Q?rSFZ3HPQM41csxfK5nyo0jW76C2Vt7i8o6aleO/Tq92WKIQqFRgzXqaYTj?=
 =?iso-8859-1?Q?/fe/ywKdGE8AcF9mLZqmnpKmuq/sDkkLJr8v3moP160gro+cp95eq/vNI6?=
 =?iso-8859-1?Q?3m7wLz8GPSBngqFEJv0Cda3nvi0LS0RFnzzauld53Mq8h9reGhRmQLolh7?=
 =?iso-8859-1?Q?6g5kBV72ZqBLGOeqhiIpWeCf8GPwY8B24P4Xok/haznifa4HAZClWANDNZ?=
 =?iso-8859-1?Q?BNKwT9qRA60L0AXOcInN3Pou8Iz6uVnX37N/8WImhKAcxHyGnXv9O2jytB?=
 =?iso-8859-1?Q?dTFxR6owbYk4WBCpbOdVzrhp2dfQ0/lPrYKdBWa9BiDKhiaaJ1xQ2GPPag?=
 =?iso-8859-1?Q?p/2PzMZ+7iArdw2Zskxd/Tf2c3ERX3OEMl8sln5n7Qyk6cordWFxOdZ283?=
 =?iso-8859-1?Q?0jcRmrcE+01EYvz7U2fHZ1a+C92xvd8d9jYHvAJTqAiGrCohU0MAa+Lruf?=
 =?iso-8859-1?Q?hDiQN+cpOdudTv1myQsDgduZHx3cxF20rgiB3o41fOR6Y3AzQSU0f1za9w?=
 =?iso-8859-1?Q?hxM1Ac8kQ304mSoMHTI8E4yXJ/81D/SvihNlevS2IL9fkK5AIaetaO/wz4?=
 =?iso-8859-1?Q?YTYPgYutWnzkFSHYQlpDTgIHLaajvSFUFS17KBelstB4fYZr9TI5j/jcsH?=
 =?iso-8859-1?Q?YjbuIdkNLLT5eDoFcGCeHPBkBM/+jET0PTqYx92LzMr2Xq7/wHTCCv8Inc?=
 =?iso-8859-1?Q?60vQ+tLZLF33MnTvWADP5UayX0H06c9UbjO5SFTL+qL3LPUxYfpVUNlAjq?=
 =?iso-8859-1?Q?j3uFf7ZuQQdW4IuvWBu6ZJYb8kIUyq1BDHeoELHSKy3I/i1eZctqiMEVHW?=
 =?iso-8859-1?Q?ACeNqEt6o7AL6KtiXexnCQ5RUU5D6XXZcEyP98ExXNi9BHMVGJndV2pp9s?=
 =?iso-8859-1?Q?VK2K1uf6E7mJ9VhvojG5Ja54yQ9x2xF8U4A2kM2/m+yM/H5Jo8gxrvExFu?=
 =?iso-8859-1?Q?dhNHQ+GUHoRz15hgBk5koQvjla91NV1tmTeLbmBI9/EG0nmlVau7do39mB?=
 =?iso-8859-1?Q?WitU694M+QEKJY5J+IxSsomfL3m5nyGAKgkWM6gHNmmQJuWvErmCqurHq6?=
 =?iso-8859-1?Q?8k1CxioQVusTfOo50B1kOSdSu+vjowWii5LM2nLh/X548azRoIggxVopu5?=
 =?iso-8859-1?Q?ciurHgId4LyH+m9PSAdptg7wt7VBpaU4GDPwlNlYgvUttslcJiJQ3bVmsU?=
 =?iso-8859-1?Q?JSydE/E7pGEkD52cltE2V5e5fJDHRltuHb3+F6G4CNFWG/F+QDug3OmzDh?=
 =?iso-8859-1?Q?dKCgnk1plw=3D=3D?=
X-Exchange-RoutingPolicyChecked: T0lV5eXwExcON0CQ6h4xxFplybpt4mIcy9LKsorssWrY7xGiszspV7lLo7x/ET9oMKwD0F0nd/8jBdn/nhRksneMlxiJPirot/O88kaDHM9fR13GlaLsqtHaateQOLT1DILNeD+N8uBZgnU7ShVJHHi8X8oyGEaEINwGf7j+zn94bkhOEzSOk1ue9QpeQmjYjshadRR7WFYjFZ2RHKvqOHCCeA0rlSczWU3P9kKz7IgRJ7nN5DT2ODauOMvYHHtCrzL3mF6GH6ybg8urGkr6mTn8wztiKRHHv4teq4PLPFU7xcyNKIxOJf7HIOLAryjpiwhZo4becqkxMPr25TC9LQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dab9e37-72ae-40f3-ddb1-08df4a64aeb0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 19:53:59.8945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocN4+yl1AU9ZuJerSkn+k3nzO8NoaiRJtb8Y8fGRfxvztaX/zwniRhBtVmBAOGAmNSsUipVVccdiHObaERIvUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB989080
X-OriginatorOrg: intel.com

On Tue, Nov 24, 2026 at 08:09:54PM +0100, Thomas Hellström wrote:
> The xe kmd uses ttm_bo_move_null() when moving an unpopulated bo to
> VRAM. In that case the bo may still carry a ttm_tt that was created

I'm wondering if other drivers which use TTM + support VRAM (amdgpu,
Nouveau) have a similar problem or this really just an issue in Xe.

Either way I think this is safe and correct for any driver.

> for its deferred placement, and it is left dangling on a bo whose new
> resource doesn't use a ttm_tt.
> 
> Make ttm_bo_move_null() destroy the bo's ttm_tt when @new_mem is NULL
> or its memory type manager doesn't use a ttm_tt.
> 
> ttm_bo_tt_destroy() is internal to TTM and not exported. Rather than
> exporting it, move ttm_bo_move_null() out to ttm_bo_util.c and
> export that instead.
> 
> Patch and commit message was drafted using an LLM.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Cc: Natalie Vock <nat@pixelcluster.dev>
> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/ttm/ttm_bo_util.c | 20 ++++++++++++++++++++
>  include/drm/ttm/ttm_bo.h          | 15 ++-------------
>  2 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index f9458a4d5a09..7f3459db596a 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -202,6 +202,26 @@ int ttm_bo_move_memcpy(struct ttm_buffer_object *bo,
>  }
>  EXPORT_SYMBOL(ttm_bo_move_memcpy);
>  
> +/**
> + * ttm_bo_move_null() - assign memory for a buffer object.
> + * @bo: The bo to assign the memory to.
> + * @new_mem: The memory to be assigned, or NULL.
> + *
> + * Free the current resource of @bo and assign @new_mem to it. If @new_mem is
> + * NULL or its memory type manager doesn't use a &struct ttm_tt, the bo's
> + * &struct ttm_tt, if any, is unpopulated and destroyed.
> + */
> +void ttm_bo_move_null(struct ttm_buffer_object *bo,
> +		      struct ttm_resource *new_mem)
> +{
> +	if (!new_mem || !ttm_manager_type(bo->bdev, new_mem->mem_type)->use_tt)
> +		ttm_bo_tt_destroy(bo);
> +
> +	ttm_resource_free(bo, &bo->resource);
> +	ttm_bo_assign_mem(bo, new_mem);
> +}
> +EXPORT_SYMBOL(ttm_bo_move_null);
> +
>  static void ttm_transfered_destroy(struct ttm_buffer_object *bo)
>  {
>  	struct ttm_transfer_obj *fbo;
> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> index 32791c4db2a9..d525e04893ed 100644
> --- a/include/drm/ttm/ttm_bo.h
> +++ b/include/drm/ttm/ttm_bo.h
> @@ -356,19 +356,8 @@ static inline void ttm_bo_assign_mem(struct ttm_buffer_object *bo,
>  	bo->resource = new_mem;
>  }
>  
> -/**
> - * ttm_bo_move_null - assign memory for a buffer object.
> - * @bo: The bo to assign the memory to
> - * @new_mem: The memory to be assigned.
> - *
> - * Assign the memory from new_mem to the memory of the buffer object bo.
> - */
> -static inline void ttm_bo_move_null(struct ttm_buffer_object *bo,
> -				    struct ttm_resource *new_mem)
> -{
> -	ttm_resource_free(bo, &bo->resource);
> -	ttm_bo_assign_mem(bo, new_mem);
> -}
> +void ttm_bo_move_null(struct ttm_buffer_object *bo,
> +		      struct ttm_resource *new_mem);
>  
>  /**
>   * ttm_bo_unreserve
> -- 
> 2.56.1
> 
