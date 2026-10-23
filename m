Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792762195;
	b=HRLNotKo8Y8C1XTJtsjh5oQOH1Dobk5KnqX8pMx6hVf8KaLxt3X/URKiSTMARIwxkKC6
	 v86fnT1nt8DIClwlHqoOQ7qAe4guekrdo2gbNhvT4HT1KrbtEdsa+sMwgXshIwP71dX+1
	 PRRIUrae2X1Re888n2RtIwuZlQk1byV8Zz6UpJVhxq+/urjv0bb8KvHeMHsZohZymSjAh
	 HWnz0AKnD6N36MlniaZY4nKoOATZNH9sZyRn8SZzxWJzb1kQjWCZ042xOCnPqMOj+JNO0
	 strElDXcPLFLKpnCttybRQ1LrbCKSkVfom5ctborWMhaRg7DNx2M2OMgqcsZG2QIDzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762195;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:From:To:
	 CC:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=F6UhD+lqhOdScR+oX6NK8Vvlu1bGBQxeaRBXydGuJMs=;
	b=W3jGMkbxMnit4UYikNipfzbOsXLG0ppsRfonnwUWhhzA/dmlVcH1XBNvqF8AvFH0yGiB
	 HdawLsgn/dKYcPxgn6B7Qgo3frVfoJvaLJ14Ph5d+D8LKL7A5UuDagS2s/HFk8gFpT0mH
	 JpNcVgSg8gxJJTbQTKu9EE3LaQ3vokQu6DHGwrbI++26mOZ6ef8C9mbj6BnWC7OZAG6qP
	 dDe2xGuWChRygKbHnbcVVLfJsHZpMUHFxPty+iiC0e9aMrZ0SMpJeHPsLuS06Sy9ld9Y6
	 I+J+YkpvF/ufcVMchDLg2WFZP/t0oV4yLn2AUjjdcp3MhS4I3DObYS8geIfGWXW61Sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cpQU5bOk;
	arc=fail smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1D606A31A;
	Fri, 23 Oct 2026 13:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1F1D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cpQU5bOk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792762194; x=1824298194;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sh9zd0jfBUidkrPdbdvaSWvnc1Qm0M6nDl2eu9CypYM=;
  b=cpQU5bOkKR1UqGZ7nei/RswMDzzQq3DDWyCnAN6I0+mYWO+f/eFywXvd
   YUJkKxdG1iHvBarsF6fwf6kdq361OugYFcrMdXBcP+CoW55hb5Llubowf
   7QQyFKbo8R1a5mop87hEnp8B9zNoOmhiem9IH+GajkHicy/gn+ooaT6OM
   gy4/wokegGb0d6Wtrz3+Q0KNua1Ci2SqwXG8odceQiRJcNK8UYkcqJdLj
   U+U7okCjDyCxZTKpDMgQVFuGa3LEYKytIvOOzGwBeVTCX0ESfgfl/RWq6
   Tym9GV2rSsQZKbzj0MYUiwtCBkwujDEb7awC4yBPt9WYTmsvNndccnp7Q
   g==;
X-CSE-ConnectionGUID: e8dhAk1FTbqCn/zkteo2mg==
X-CSE-MsgGUID: iEIE68+fQRWHO0haQFSUaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1422983"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1422983"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 06:29:53 -0700
X-CSE-ConnectionGUID: NUcGnrSiQh6qBTqgBiiQyw==
X-CSE-MsgGUID: TVrmg0wwQLyaWA7gvIdxZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="5408826"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 06:29:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 06:29:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 06:29:52 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.34) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 06:29:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeUHox+urfpGsi2GYVHcTAT/CZgdfP2OZkh9YJPg4bj1h4lo9WZSvmTtI+HVQ3U7OcHEvZ3jb4qijC0uLqZ8YTiybMePRRWfeTu58pmnJLdTDGNRiiRXaUNgyxBDA0p3IYsu4dz4tNft+yeIqAGb+N25VjADJtWqfo1DCKML4D/JHEBtF5ls9FkHH9EMzlLoNIZrRZs8itRkye6FA+teL7KJnhtZcvnWSyu4ac74eiCj2oWmVlvF48e1Pe0S/FYQPjWSz5TcNAYTRdIOiizlVRIoaUU89e3XqIWyQpPtouV8ktoHc35SeP3TrcHmVUTKbuh5SJRjPHz/AXmFdLLAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6UhD+lqhOdScR+oX6NK8Vvlu1bGBQxeaRBXydGuJMs=;
 b=EzFYKeHwfN/iTcICPEprRRXVJ/d2s+myBwxB/MbsKxzvuBJB1Raw3LsZN9D9QUeySXRBhzz7qOc4Amd/l/NmRIo+A26DFYAFcOkBX/yoWbqbuIi9GAISbXKliMeWiPT0c7nZgt2tXVm1x5ONq5Laz2nD3l/vsV4DYfQ9+OHqmaoYihsoV+q81wySo7YtySvvxpFi9W7yHfV2GyigGTGZ++P5wLKaSu9hGZhuEiLHkkyHEJIo+EjmeeybtbvS+qDvOKRq5HRq9g3FIBiHdH+Kv4G4O7w21Q/udoTGxIA9vxYzVzKpTYQzhWsqcM8JL8Ph2Zu8m2VtVvwwHm2bTf9Opw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB6445.namprd11.prod.outlook.com (2603:10b6:8:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 13:29:49 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0496.021; Fri, 23 Oct 2026
 13:29:49 +0000
Message-ID: <c89225b8-15ed-4a60-a14b-8f5e5ffd77ef@intel.com>
Date: Fri, 23 Oct 2026 15:29:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "ice: drop page splitting and recycling" has been added to
 the 6.18-stable tree
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: <gregkh@linuxfoundation.org>
CC: <stable-commits@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, <alexander.nowlin@intel.com>,
	<anthony.l.nguyen@intel.com>, <jacob.e.keller@intel.com>
References: <2026102335-ruby-freewill-98a9@gregkh>
 <1144c19e-3b3d-4688-a594-7e0e3aa7b33f@intel.com>
Content-Language: en-US
In-Reply-To: <1144c19e-3b3d-4688-a594-7e0e3aa7b33f@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0039.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f1f0621-faf5-4991-2ae7-08df3109b625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|261009223027099003|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: ZSlQY572pKvjY0HEiWIyfvvAh/kUz75FlAo39RRl5EaBeNyW7riVe1qNJapEGW/yz7O2j2b5GBxdB30pi6VRWhsUvPX1L22+Be1eUaPGGDQY0DlbAkFk7dzJ/FUIir7c6CaALQgRWYkkK74JPyRiMcRUiD7HVjuv1mIJmzO2b3cW71DINTBGsdpRscGkGckx32oPrtE/AnEIv8oCDH+9N3IOFbsfQ8QroHAOWVgD1QbeK7FJrjuSAhbH8GOKxod0RR8ry5BEU6/pz+tTE3Azh3e2vr8TkFobNqDSM5BytWUWlIgKNPuXqO4rk7PCGCT824LM9D1/KQpMClHmlO4isDoQmUfX5uLqAmvtmgJSAh9bfZ3rINw+5rYxPCJXyfk9DaUswgRznFlUOfvSdQNzsHnOFU+aQKMMf1XBRLu9iEp/addu7q1dzwBUIDKlQqPxe349sAgx6jmEIxaPlLNyOTXUW3XqmuZMm/d0MrvHdqotBRz00duBiqgfNtrFCvJRovVNtM/cunKGnKO5ha9VowmMgQZ/sy+6Kg/IHIODtDVpNb8jBo1LaEilc4Mnzjc7mnAiw1ebpanGG9Ygtb1ejMA2uf2lxdYm4E3yd8m8tis=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261009223027099003)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnpjTjlkZ0xqdisvTTFMMWprMTI0MGlzY085SFNEM2ZZUlZTcW9oTzVlVkJR?=
 =?utf-8?B?OW96TUhYdzlLQUxKV2k3UGtGY2wwa04yODdCR3pHcGd6N0t4WHJKS045MWYw?=
 =?utf-8?B?MzdDRVBueVNCVlJkZEUwUDlHVm9OYWttc0lqbE42TWdEN3V2dndGblR5UjJt?=
 =?utf-8?B?eG5XZU5zQTJkQVRGNXRMbFNaTUhkd0xvb05pd0VvUlZISXAzT2c4dzViT0wz?=
 =?utf-8?B?dldwSi9Nb05KNThKUVBXanJtNVo4TEkrVld2RW1NQ2oyOWV0cDZ4bmwzY2x2?=
 =?utf-8?B?MkVjckZyN0FOa0ZxbE04NGJaRENBVHFUZWJybXp1d3g0N2RBL2UxakNTN0Qy?=
 =?utf-8?B?OE1HOTdzRXR2NHF3R0YwVXN5Uit6YkVIbUVxRHJkMFJHdVkwTXVuRGl0WWR0?=
 =?utf-8?B?TS9vY1hIVUpNTldkU3BFNVV0VUtnYVFkYThwZEZpQ2NKQnpKWUxQM1lEbE1h?=
 =?utf-8?B?czFYNWN2N3l5NTF2TzArczNYZ1lhRWgxcWRabmh6OUFIRyt1K1oveFdJb09l?=
 =?utf-8?B?b0ZwcklrSCtSdHp1T3RLemJDb2JXZDVwb1Robkg3allKWVhNRmZiajRERmJZ?=
 =?utf-8?B?UUFBLy9lemx5N09Sc0NsOTFzMkI4WDFNb0JBZGpjd2F2ak56UnQyT3VyVlM5?=
 =?utf-8?B?NUxnM2lWNVRpbUtTTmovZTk3RFdqRUpUVU4vaUVOQnpJd3l5b3MxemdmU0d1?=
 =?utf-8?B?dlF4eW9rNEtZbkt0dE9GMGdYNmI2QzZpTHJHYlN1SjBzcjJFTENJeGswVzVz?=
 =?utf-8?B?aHJ0azJYSWwvSExtQmJ1bFV0SDExVlJJN2NDVGtQVk1ldWRhWncrLzNmc05K?=
 =?utf-8?B?VVVCdjVrSk1hVk9NZHZRL0txL3hPS0VOemFYODB3MjlMTmtTd2tmVGVaS2NE?=
 =?utf-8?B?QksrSmFFRUFsNEZYNmJ2dUw4ZEFMSHNWQzRVV0tVWHFsOHBCS0JhL0d6dFZO?=
 =?utf-8?B?azFoRmhKbDJobXA4bEt4djlrYW9nWVJKdWJBQzl3QlRRVjI3Y0xoUnQrVmVa?=
 =?utf-8?B?dTdYRXJ3bnFGSFhNbE8rdHNrbTJrWmcyNGx4dWVVK250bSszbHhmdlM2eGxK?=
 =?utf-8?B?Q29XVnBVdFk3MEhENlZMbGRrOUMvREFYRU1mK21oeGJFMER0WUZoTk5PeW1w?=
 =?utf-8?B?Y0JXUkRKZldpSENlQ3pHOVN4TmVpYUVmSVRiS1ZJUFU0U3BVbFNwMHVmaWEv?=
 =?utf-8?B?Z3FxRUhoYkhFdzBDNUZ5eEwyT0pTMllsNmhrVjl3TGtyYXBqcHdZOHlrUGYz?=
 =?utf-8?B?ejRQYnF3TGlraUtpQ0pjVFlCWC9XbVJjRkJrWitrWHE4ZEVFWFBGVnI2ODRE?=
 =?utf-8?B?S3BGd3VEejB2RzNRcTdFeTN3Y3RKYURaSTJ5M1hEWmt3Vnh6MnlNOFR1WEE1?=
 =?utf-8?B?Q0dZM2Z1bHFzRWg2M2lBZVhYcllnb2s0ZHVMdmE0R1Vva2VLWENlNHFsblFm?=
 =?utf-8?B?U2dRV2g4QkMzZUdMSldMaGR6SDBPUm1NeFpUU0RPMUk2ekJhd1VpWG5zdjhq?=
 =?utf-8?B?QXRySkdLQXZxSFcxMy9uWkVNbDVDS3UzMWF1eHArV09Fb1RNWWFkOTRNOVkr?=
 =?utf-8?B?MExhL3p0bnJtMXA4QUl2U0h5ZGhjK0ZDVUloWFI0Ylp2SEZ5V2ZDamNaeENo?=
 =?utf-8?B?TTFZSVRvSC9xUGY3ekNvcTB5VEd3Y0cxOElPV2xxekJmWDA5WGF3QlovK1ZD?=
 =?utf-8?B?MDYyQlNsS3ZSdDVYK0RIWUl0b0hkT0dSTWxrNXJtQStxUXJzc1l2MlhqZVhT?=
 =?utf-8?B?MWxDcUs4L2ZBbGwxTnZuRjlZUExNczRJNThKeURrUXMrVjF3RkF1K1NlQjYx?=
 =?utf-8?B?Y0U5TjlxY3RibDlHNzkxNUp3SlhxNjM2a1RmM011VVQrS1RsRTlzeVdLYzRJ?=
 =?utf-8?B?SUQ1SlhlSVd4VEdlMkV4WEMvWHJSVXFoVWF4SnNzd2hKblA4RWhmSk5CVWZr?=
 =?utf-8?B?Z2JWb2w2TWJUdEJUY3lRbzVHN2NMTmMzU2Uza2pPcFVQeUp3Zm1rZFhRM2cz?=
 =?utf-8?B?MEg0RHp2ZWhneWRmZVAxdTVvaVZOaFE1ZjVEV2FiaytJQitWM04xa1Bmckxu?=
 =?utf-8?B?NEVSUFVvbC8yTW1QVWl0eFNvMmxkcUZzbTFDMTdLT1NoRlBTYXRkS09rUWxZ?=
 =?utf-8?B?Mk52Y2xYcTdUcGhuL1dLUDZmbHM5SVFPZkpXK2N1NVRTTVZEdmNVMWcyK3hw?=
 =?utf-8?B?TmVTTDBDOWtyY0J5OTNyUERobHdKMWxqR04zbU1mZGoyTExTWHBTK3N0MlRz?=
 =?utf-8?B?OWhwS3ZZNTdmU2hkK2xEY1ZDVUljeG9XY0xPc2FEUHcvOGJUVVN1SzhJb1Zw?=
 =?utf-8?B?NllEQk9CcWprbzZLODQybVJkT1dEbFVWTktDRHhMeXhwYmJuTXVoeXVlZHRC?=
 =?utf-8?Q?TOTXokuJZCrj5qxk=3D?=
X-Exchange-RoutingPolicyChecked: wGnPMC9bwE99JRVZKSxryWerIV0i+/TWaVsc8yPoUPa0oNsjjI7BWdgy8SLIPtB6IMyhapju+a31dLBqQGKy88WvI0COh7cy4qtdcYfnD9zsHq5lKOhpFXdQcSSZCkaFTpGdk/RPcHtvf9G5TB57W1uXvULCoCsTU5684QYeBREp6rq9kGYEJ6Grau/61DJtD/qwQGPE9nNgKsIUK1w+oVgzN/PvWn92oP7HBITfQoezdAg2ZgMTQqPHVlzLInFEMvsJBFSw3mcL0ajgNsM3pk9Fb3jcgY/EAFdi8i6nLQDUdTyLzwfdHfKtOuWjgN1YwDIBD2l4GcVNZL/N3RZqNA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1f0621-faf5-4991-2ae7-08df3109b625
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 13:29:49.2572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EH6U1RHKgM0GLeQ9a5U5EnY7M3QSMtehoel3UffFQ1pHTG9brg7Xz0WL8xG+96lGY+y8yeFWka/BScuf0Kpr+EIbF63Z0UPQLJ2hFBcbedA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6445
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Fri, 23 Oct 2026 15:25:58 +0200

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date: Fri, 23 Oct 2026 14:56:35 +0200
> 
>>
>> This is a note to let you know that I've just added the patch titled
>>
>>     ice: drop page splitting and recycling
>>
>> to the 6.18-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      ice-drop-page-splitting-and-recycling.patch
>> and it can be found in the queue-6.18 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
> 
> Please drop, along with the predecing patches ("drop legacy Rx" and all
> that). This will cause huge performance regression on LTSes.
> "ice: fix broken Rx on VFs" is applicable only when the commit "ice:
> convert to Page Pool" is present, otherwise everything works.
> Another option would be to take PP conversion to LTSes, but I don't
> think it belongs to stable.

Sorry, pls ignore, I didn't notice you took the PP conversion as well.
I did read the adjacent thread a couple minutes ago, if it works, let it
be then, shouldn't harm.

Thanks,
Olek
