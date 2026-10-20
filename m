Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792503329;
	b=LgOPZMq5WEKGs9wDFv0TFhlx5t1oRNCC4mV4TMJIOmxF+YmlqoZejNu0TCW73DZP4X5e
	 Iz8vC81lSAGRfmowjrMxlDAwtsuBQlBBNbDkXosoJDzVTfuCC6yM3xlWBkBCPR3EsK0om
	 ewjnjcM8Tt8xIOT/kE6qiQ3dP1voghSp0wnNDQq7IKb2CvZ56rot5d4ro4Z0aPnaS5nQa
	 aTI6Ga7EcgWUG6QH67gIKtQyJH4faUn+kEOXLgJ4t9r+y0TXwXfg0wfuZQ90sMPxhKtwX
	 k/s+0zMRr9El2T2HftzkmJi5W3eWqtc+EAtMn5fP2rXP82nq+hM/xnDZ2X/fFNFhneg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503329;
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
	bh=UHGdbUD/lHcyYpyMbotJSsWs5bcm+zb1Uilo2eGSsfk=;
	b=wnWHbpZYG4SKbFGh7Iz2YbJ/pluTeWiMGQ7eWGnWzYukyRLOnt9EvOuD7Yls+k8BnIuO
	 9+ph3P0zty1jM/wf9hHuf06J1VLp29QFkVM5WcF757KNZOpCTcQ2C6SrTOKBcLkZZEF8T
	 XxpiAgW0LoV3OVL4tbBNtE0iTIg+gZyJBchKOmRW1IWgtg2k8qBTnp/Xlk2LBlDTPo+wA
	 MBr6doj55xDsnSyhVlT5yam9Wmu4kMzM1Bmjr3GP6SZ2FsGvPuMOdIOmKPEDtd6wPM1oS
	 BJ5myKUQ2dpM6a+z+XXCH6Vm/ckZ78/Pw3+Emt/E4d5HcGqrtwjvK3sUKkuLOgAwiqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OiWYGIPP;
	arc=fail smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31B4606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D31B4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OiWYGIPP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792503328; x=1824039328;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=7Z5zjQXBg1XZjUogjFZ8kxLdCJIWJncT+DOnYdOOhAY=;
  b=OiWYGIPPb+Ri61aSL05VGztl2/qgqeYYEo8d40bg0/GuO4J2tAsMs/WR
   XJ4DZ6w24LGEceM83l03h9roJkS9B8MKzySUc/cPqjroqa0i7JOPx/Ti9
   bAK5//Pm/dD3iJgbk+5RSx1XOTFpr7cFZEEOFS3BAessHOZYhLJPjmoJ+
   O673zhnimVOHvO0Ern8b9R2ixuaVZI8jk4ty1LyCPDJVQuKhHOorIwGuP
   8CzKNbjTSCcArbNTJvjaJdZEOH4xPcF7l+s/jIAT9GJGS+XR6NCfVOk8n
   V07JwIZlLFe9p/V3nmXjnknv90bYRLaSNHRT3aRempBkqNQv35ruHKP1H
   w==;
X-CSE-ConnectionGUID: ZmVch1XSS3+IJMKmjTcF+A==
X-CSE-MsgGUID: z1Bz0TBXQeyNZkRfLw2sRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1214938"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1214938"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 06:35:28 -0700
X-CSE-ConnectionGUID: yVyahATDQWK+5UJuRf2syA==
X-CSE-MsgGUID: yHC8YOqYSOGMw2dPYhzFuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2780649"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 06:35:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 06:35:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 06:35:26 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.19) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 06:35:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5u5XlsroRgzRWFoZpR8ZfqqsURLhBc/PHiHM5xY49H9NgRps0zJwMHztBlcksVV5vRaZ5o2TRHNeXizbq0Lf/1P2nUVrDJHLxcNHKAoyXHD2O2KKXDskoVFxQxC8zZCesS0Sc9Ux4DlrQvsvJaB36Me6Dnhwc/lbRezvyF2zJbexk4kr3sM7VZaeJRSwbL1z4z5dY5RxA5LLBdHNLoXWLJDmUoZ7J3i6r3udeFUJ5tq6nRdBubw2fGQOfh9TQoRrMjhe/fw8gWrzQCUwUZPm40zszb7v1xrLOzpJIty2UU1GRH4c+z0qFv0SZIU5KCRa2lEqelVm16tToAGi+KVew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvZ61RKfxpWM68Pg2UHkSTxOVQ9f/TWYQNsPNFtPKgY=;
 b=j/s5W5xf4W3vRdvkaw20h3+gr7F7JXTFXfQ76qC9vnTN5N/XTYzomNMDeZLeI4UaJi0klQTgAtowQGw13fXqLdzvdGmW2o3m4Zs2jqSftCa86oU8MKvZNShVgF/Z6OkgHwATv9/ahuZs7Z/iNnNR0nUJrOnG1idXpHzxy2mfsUxKYv1kd+jAQT4LUa8zqx4LNDoqNzL5MaPIwOwFDAU/wOZIr4oZM05rFS2Jo89E4bIzYSBUEbdAShrUWhDd4OKT+q122smwD2U9Xmg6/EPAIfC7btBaUuNF02UnMWMthoaAYrnNACybp2FiCoTuSM0Tuo4mqMlWIJF39RL+u083Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5)
 by SA3PR11MB445477.namprd11.prod.outlook.com (2603:10b6:806:533::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 13:35:24 +0000
Received: from CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8]) by CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8%7]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 13:35:23 +0000
Date: Tue, 20 Oct 2026 09:35:20 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Matthew Brost <matthew.brost@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Don't fail runtime suspend permanently on VRAM
 eviction -ENOMEM
Message-ID: <atduGDrVk7kc-PPe@intel.com>
References: <20261020100545.46715-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261020100545.46715-1-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: BY3PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::11) To CH3PR11MB7180.namprd11.prod.outlook.com
 (2603:10b6:610:148::5)
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
X-MS-TrafficTypeDiagnostic: CH3PR11MB7180:EE_|SA3PR11MB445477:EE_
X-MS-Office365-Filtering-Correlation-Id: b8fc6ed2-fa96-4d47-0c29-08df2eaefe3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xg73H2JLa/mRJXGfv02Tl/O3v4n5zTNC5iuVjZC1W4Y05S434K5JRbKEA1miJrO3KyCcvkrYT4LpZqVfE8ov8tA3/yDN4IPBo265cYjfg6lJ1OCkhfRvO22QYcW++Fog0OjxSViQep1F/W6eUA0epfaxMQnod6jEVON/cQH3vlMSKtWuMeaCKB63a4pYDwCSXVonDB1yL3D/9Aik0kvoU7rdZpIpz/ZBZwQ2IMaxFJbFR3mlHOkaeNzork8DQ+rHMkjKLMO2UNSpOXKylRzbU2H4b89BXf7KGj0PqG9mGdoRSx5JR1pMq2fY46OtKUZdHNnsTlsr61vwv2keuRgNE8MrE5OmIRRom3tgapQx+Va8VwWAdNVFJlwDilqjBy9tW9XsOQtrfOjeqr8EIXpY32FB/LxDXR23DJOxqIsT67h2Ff8JHOQNyankefQDKAOXW34SPVAfuEQWcxGGI+UuZ5uBmOP1Ud3lmb7G4fG/EiMYNhb8jhvgr0tJaomX0Y1CjII0T+TgiSr8fQw+mefY2oKIEjM05y1sxP54lgdZAFqRy7mciFR3TKYDj0aFS8tcz9+/WAmf+R34s0iguDAwdOPbgOhB7jvRyradF20UCQqLqvK4xPHsqxdxiCBdwsoo1VlvRaBdM1VZdXAZn59MX5hTfX0drvMBcj33zEyL8Lc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AYggYTf0kJBFrEeonBXwb0Jdef2n+AJ3mM1touPGeioM1GMmm4GyRKB08/?=
 =?iso-8859-1?Q?vJhDzTZWhnbckDM/EH1mZFcgpBZ/Ao2KOTNe3Ts6s3ofp3KvIfgkLgDcuw?=
 =?iso-8859-1?Q?Kwr90FyoaE1aCaEbv8n74PL7WENT/j1TVCz7jJzNwm8HV8yM9BYaS4cv67?=
 =?iso-8859-1?Q?GAO66lHihA3PF2DHOjUndBJgYWZuMDyDvpNPg3xVJN+xByGLL/a2o2tQvo?=
 =?iso-8859-1?Q?t4o57DRDPIcumcDvQdwOoTL7N0vTlEwyujYghtMGU1N9chw0ScsDwPVKDz?=
 =?iso-8859-1?Q?bjfSbPz/Ao1pQQfQvzAVE+Wz60Cd3GX2j3ykN2ThKijoCP3Fbmyo4FDScy?=
 =?iso-8859-1?Q?MiUCm5cLK5iLS7GKaE4MG8uYn2QQ8tnFygLt3j37X/c4mcl42QdYho2XAm?=
 =?iso-8859-1?Q?XStYGK2ht/+jC5SBIDTr5hrpcxGuc8CwzD+S55izAUs8xyqInDGYFQA4fC?=
 =?iso-8859-1?Q?+zOIY/ZqB3v/671nrIcmczUswTJU+sUh/kxwe3GrzoTwy9qNZLPA/y3w92?=
 =?iso-8859-1?Q?QPrHiz+BgWOsnatKS00chlB/uMevGjMNS+WVupwVTCXjdxiOeeZrNTJr7C?=
 =?iso-8859-1?Q?lCoiNB7jKBC9cKm/sUmZ/6WqXAnDinZ4C+nDmbdCkpGICjjOH2nzhcyKeO?=
 =?iso-8859-1?Q?JzpO5sHUQv4gIrdkSuD1Y2zb2K3PR2eSrr59/WS9b/0hLvXLRxyWI8gDnc?=
 =?iso-8859-1?Q?HurVgrDezSQrG6NpwKdVPcEXVq0dvJwoSuN3MndBbJVqyHqI4eH/Q+4ISq?=
 =?iso-8859-1?Q?UKvb8JJo/30SpUa9zpRmJZ//kmjM9sLQ9m/vxrEazqUxCmEnST6mrgV/9v?=
 =?iso-8859-1?Q?VEp1u8hTKJOyrdTux/mjXuUUbynHDzTuPcsGnMJyPnb0ti3NG5lhfGnzv4?=
 =?iso-8859-1?Q?3UcECPivgUF9Sqq27X9vFdHqVc2TO1AsZ0xdh2RG9xx4lzxd05fDHq/VsC?=
 =?iso-8859-1?Q?qXmxLh1H2UWpkTWt9keKXEOclicACZyHhLfEv6U6Dl0JnqOK7M6sNzIZyL?=
 =?iso-8859-1?Q?XttH0ckXitrkpZOgDqkKVkKGJrxpwrWb22HG4Yml03vczZiCKn4VhYq0eo?=
 =?iso-8859-1?Q?GkVWKqqiNi46ifn7Os0mAnlVs5L4181a92SII6ioYGh4FS+xWl2DykSd4J?=
 =?iso-8859-1?Q?k/PKrhyQWmjVYOWe72vhrbm1YKAmg9eZi0TSPINxH6/1yo2KYrQxcHTEqz?=
 =?iso-8859-1?Q?4wHM9Vol0TupTr2KLMDnBl/zGcOBGR+aJ1IM23h2euE3lw7iYOtrXJRIKn?=
 =?iso-8859-1?Q?yN7bGt2YoEpKfzftQVlfwbZ68E9tdsvqgKLkYfEoAM8sddFz8KMrZ4FZ2+?=
 =?iso-8859-1?Q?A4NMuP7CvJ6EfH4/xbnuhpNcSMT6pytmpYKQSZtJKWrcMBrCv2Og5dR4J/?=
 =?iso-8859-1?Q?LQr+cX06iWCF7l7aL7mSya9rtB+nrT/OKiHppCGWP8og8Afq9rTepZpuCA?=
 =?iso-8859-1?Q?9nDQf8OGYn2l3LebA8JjKrOTQ5TgCRQDKPiFzEOczfzJQtixC02UvVyWxr?=
 =?iso-8859-1?Q?3aaK/1dgNBc2NtQycTP7xs+gwO1AklAyNpJPNGe6DFa7KGhr0UTHB7T/cA?=
 =?iso-8859-1?Q?+91eu3E3P5whrNvw4jXJoFOAEl/PBoh/3yX+TH2wfZy1SN3oMABwTAEOFn?=
 =?iso-8859-1?Q?bYeiH+XJFn7hjSWloC1frZsuHjB7E6zLH8LXpgsnXCuqw84t7LpBehFf4K?=
 =?iso-8859-1?Q?ZlS1FIv3aZ2Apt5KIU+ctI9rJcvaQ3AseFId/HObqQKNItF/UfCMOfTQdP?=
 =?iso-8859-1?Q?8oGYdLYzYeJwrbSoFD0Zvfxktpng60olPPfGm/8PFm3Z6BWL/PXjdLGnIC?=
 =?iso-8859-1?Q?TDDM6c37ug=3D=3D?=
X-Exchange-RoutingPolicyChecked: Zmqyq25SkzHjcjo9KqdNLRS7HLi3jpTTMDJ2mTYXMRYQjljAmFndAMiNuTWcr2FELo82lD4ooVQtMCfea4HtPE1zgnv5ZNZqSgCM+t5sago8Sm70H4lPTqGjg/fHhth7thXOqaUQCgaAMSz8YmTL3IA2sdRL8ztkT2bkaoG65bqlB2pYW7mQlc8Q6iOgkUIz4Trl6Dy1Z49FB4oMN+4fb+H60fuLU1tpgCEFRl3aPAyxqWg5ULkR+c4/BOvdRvnjYvmIXc7jTfG0wmo8FFfz4VwLnTep237dJPg1Usm4MJ33sHxobsju6f93wH49prvnCWZfXVmLc68+0BjDgEDbDA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b8fc6ed2-fa96-4d47-0c29-08df2eaefe3f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:35:23.7807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRXSO1649MkM0vNqWGH+XDHoC4/GWUMmYSbPKezPUqU37lmcXebrNICWBtsVXG8uhvZ9WHC2/V5iJbYP3UoGmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB445477
X-OriginatorOrg: intel.com

On Tue, Oct 20, 2026 at 12:05:45PM +0200, Thomas Hellström wrote:
> If evicting VRAM to system memory fails with -ENOMEM during runtime
> suspend to D3cold, the error is returned to the runtime PM core.
> Runtime PM treats any error other than -EAGAIN or -EBUSY from the
> ->runtime_suspend() callback as fatal, records it in
> dev->power.runtime_error, and refuses further runtime PM operations
> on the device until the error is cleared.

oh!

> 
> Memory shortage is a transient condition, and with eviction now using
> __GFP_RETRY_MAYFAIL it is also more likely to occur. Convert -ENOMEM
> from the eviction to -EAGAIN so that the device stays active and
> runtime suspend is retried at a later idle transition.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: intel-xe@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.8+
> Assisted-by: LLM
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/xe/xe_pm.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index daa7ba2df317..9bf57ed1ea59 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -649,8 +649,16 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
>  
>  	if (xe->d3cold.allowed) {
>  		err = xe_bo_evict_all(xe);
> -		if (err)
> +		if (err) {
> +			/*
> +			 * Runtime PM treats errors other than -EAGAIN and
> +			 * -EBUSY as fatal, so report memory shortage as
> +			 * transient to allow a later retry.
> +			 */
> +			if (err == -ENOMEM)
> +				err = -EAGAIN;

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

>  			goto out_resume;
> +		}
>  	}
>  
>  	for_each_gt(gt, xe, id) {
> -- 
> 2.56.0
> 
