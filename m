Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792658075;
	b=g+iptyinLgb4TZlIVwxo/jxldpsuH7EH3g1qDYQEDfi5rYdZf1oB106ardUBR1jcZijP
	 aJKe/WhDvGINmua0U1kJm9arzs0L+rDdEYAajXoUYcrifJmmz24sL7U02Fuv/eoP4l3bd
	 BdCbwGZciFu8ctMqmJwHX+k1n+7zTmMv/0KUUk34I3FLD75V12QZPwCgOMMnTDEf+gui/
	 04/ibfP6BHirNw3C0ZuNzvrs89wpTEX/OR8qFJyun6lE4LC9dy8FO6DQUWms79UvIvYpW
	 pgfyLuEjq1gZdE2bqMXtnpKHhdaxgL8A/j8d779iAu6isIA7b3tJTuvWbULM5hHlbyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658075;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=QRVRhh2d5xAKNgv8ZKl5xZsYEjNO5Qwg0yeTu+l0RW8=;
	b=qQ4n/OteXmFSWdlEo439ewRdXhLkQ9qOdlqB4ovglxR7nVq+6qyhbPnSOgNsYr/L5Xth
	 iN22nigiYjCQme0q3rrUcKUTzmIppw13cVQZZVFi2mHf71s46lVIdzaDzNY7I0uNVUlfx
	 VP+gY4nzf+/3v8I4eaa+mK4c6dvE5dqiId8YNLZT4LkdtznR8LqYphQPzsCTzZssvkZdB
	 qMQyevdFv3YvLbO1bf9V8ahqamMRFWS4ab4gYZIEFHqiDp/TRjnDyZqOa/dxEMxe6lCle
	 3YTtW8GLskB34m9rkWqzlWx97SkFv4xwXta2Nss0VRHEMwkndBUx9P7WmPXOyvSyq7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FnrIrkFq;
	arc=fail smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC409606A31D;
	Thu, 22 Oct 2026 08:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC409606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FnrIrkFq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792658073; x=1824194073;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GKSNm/dVWDzCOY8sNr7FyAV28X8qVH1akCGz0zLbTa8=;
  b=FnrIrkFqG50LnJaMVYjUZuctDayyrFGBqEqskvgMoxkZpEd88Xd6VhaY
   /OONCLrv0GOr8UPG93mMPXv0MCBrmXywk3Gqc8FWLC7sypv/GXnqvQ6wb
   PKSsLY8rf2Kn15uM7blT7Rh7yTdoKQ202ZxUOVVjjx+OGaOPuI2CtvurY
   SzJeLUEpiOBph4L0aUgZoPRhNRwilrlNW+yHPqxPMYtOj067Ov3nLSiBC
   4UeVMLzSBfP/3n3I1URxH8iy6Sh5eCEHZ9Ul/mMvrWnUgMDOOp6DaFcmT
   vVisvZFJBlf9M5FPW+8udPTEa+/TZ0QJhyy/J4wrUSci0Lk+ne7qLqxNz
   w==;
X-CSE-ConnectionGUID: OKUfDH9GSCS/ujR9rETUEw==
X-CSE-MsgGUID: 6XopRN6eS7O86fKC7Otb0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1301562"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1301562"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 01:34:24 -0700
X-CSE-ConnectionGUID: nVPz2PtLRnenSkSq2m5EMQ==
X-CSE-MsgGUID: x4Wt06V9RsiA9xSi7/tZmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3431397"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 01:34:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 01:34:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 01:34:23 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 01:34:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkGOje2z4JWHnW+A9lfrEPzEzUIX9X38nDKCVoHlPmgceT+CD75t8szSrxlttK3dIuI66Zl8JMvlwL02Xc1zAFabFyu/bMutpFa/drW6sfOGrGutpSgYlYeZknKp+U8FJPmmVJR7bBqcQghYPqhGDyJrcBJg8xtNZuRjHkz2d0twn7Q9LJT0fD1wXNYWJ0zK2CC+gSlPZe0vPOznf1FMxAFjkz2S0SzoZCNhemYf9Z8kgXwf69VhKVDq86H4qnd7bEG/MZSkWnmkNYRjWZtSwa0gTsXDb34TM5SGOXdOxDQ/y7HoHmQg/nF2nMnYlUZvRlESbcFL9TMdZMOGWjxHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRVRhh2d5xAKNgv8ZKl5xZsYEjNO5Qwg0yeTu+l0RW8=;
 b=QmTWLjlcdPEwHH3ySGUnlpqANBjnocsNKxQpMKf9eNj8+VvTY9Gxgx2+Vye6/y0D9yoBvennK/xeywdfRdh2uNT5LyTv4A7AR1MwVD2vXN7oJOvIVj2DWj7hWZGKc3RKCa9kUvFFO9iIktyU4zX6edClGe7dR9gcDRpI4LxOPSwxW0dVDb/A4AsPmISq0+HcoajU5FqtNwosDerhi/gKdhmpopMEGYnGMm0lzTfE+cBFCeVL/FkmCYS8b5L7LStgwUQ2RuGNaIgfAYhBbJOgYr6fVc7vbl7Hb++tmPFgwP8fMium1mggDhXFZ0WHbAnu/Rplse63G1DXX/GJs08acw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CYYPR11MB8431.namprd11.prod.outlook.com (2603:10b6:930:c7::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Thu, 22 Oct 2026 08:34:21 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 08:34:21 +0000
Date: Thu, 22 Oct 2026 10:34:07 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Paul Moses <p@1g4.org>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>, <sdf@fomichev.me>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net] xsk: restore UMEM flags after failed pool assignment
Message-ID: <atnKf5dNv0Vk1sCo@boxer>
References: <20261021224705.2078753-1-p@1g4.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261021224705.2078753-1-p@1g4.org>
X-ClientProxiedBy: VI5PEPF00000912.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::936) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
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
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CYYPR11MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 359cd654-487e-4e4e-8dec-08df301744fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|18002099003|10067099003|261021121427099003|22082099003|261021123027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: JBR6+WOtVYDmIxLz2MFeGe+5oB9UxSGG5haQoUXfEBjJVfKEawMbaZJJ1204B9DOZfnNZupJIXKgv2iRZY8e4zcKzqy1Yf3sY5qgG5SG70ZHxqbSeoHcFW7eb1gOQr73nYIM0GX3lvDHXHVG/WhrbUDIsX6+MB42ZgieK0ZO13SdXVUWvS0vIh0a77RGRAcIcHXLw4irV6s54ago+dASidJBnACYqUN+oUx/Y0DQmySdu6s/wzeWmpLens64Ju+P3nL0AuMQdeCawPP+0/BcM7cCr4txASVPM6TVPjEEF1LxWxktHigRtNoAxzwGxnmQB10kRAJHEidZNizJvvQiu5YlPmM72li1jOImUXW01JuFpUPwHDQcCYzU1Meq+J5kouGjBntN2qHBY0l7+Akr6fL6aTq5BtchhzY4Wg3tEzx0mBb3wHgbM7NufkApE9ic3VJj+oHRRaRnzOxCFED1IbNTzZkqBM4ceRilFdFNer5Fprg6lnyzDd6OxQeOsFxHDiWQR0rTO1oh++6NKYup3r2Wc/WlBtRW++N2UvO5hQEKV4xHcjU5Vl8I9QLjxGkYiIFf14l24k06cvbTjGNK5A7mSm48YvIvUcQBoHDO8uQPC03WXax9MOqOKBEs9cLm0PFphWNYestnh64kl4ZNZrreVLVte/R0R343vwF2wDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(10067099003)(261021121427099003)(22082099003)(261021123027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o76H96+81zJMCP+IjOymU0WN8WdQZ6fgkcjv1sMQ5vpapVg6jClGo+RRennA?=
 =?us-ascii?Q?lCf38bS6LutQf7UmAAv+Ku0HJ+XJEIxDAFVCMPgZsspS+Hp+6XENyveJV15S?=
 =?us-ascii?Q?I2eLLxhth1/33y5OZFSiSsPbOK7U3Tlp5wxRST9tszvlAXdgERdizURR5JRm?=
 =?us-ascii?Q?KbQ1J3IGoSXpNZm0i/qkmKqax/4Wf+NCgYWPTUTR9ZIZz6uQ2GrHp6X6tAeC?=
 =?us-ascii?Q?Dg4aH2vmpPpM1QucDj2rAwrWY6zxHA8Y1mYPuU1tAmS6uNPJfbsyDSOriYUU?=
 =?us-ascii?Q?ZvPH4FgApsb0jIjakM/2ubGzyn7s7rudMhg5Wv40Llt7jR4WGoGreihSmloi?=
 =?us-ascii?Q?7PK+JocTNuhuGupUzX+4woyfulRwNj2BUCBXBgTLKtpWc7NYmYTWU16oiLbl?=
 =?us-ascii?Q?yJ9Mpn2ae5qJN3t+e6PBnd46VQuRJl4kwVASxe/tqmKdVGxreVte9I88zrHT?=
 =?us-ascii?Q?fWc6r8qYPeGA2CFMzxTaR1YZLOfkhi04aWmnh74R7BV3eX4szJEIKptpK8O5?=
 =?us-ascii?Q?sL/+NrUJGeBJiCxIAmu/OGbIccJrk9CiRpJjqvyeWqUydlK1OglT4q57np8U?=
 =?us-ascii?Q?bQCMeJJe+uh4k5mIQ5Bb70/LZvJf2YuflvyF7bCOuuVqIlwxJSBB6Y/yHomV?=
 =?us-ascii?Q?r+mZQXJvasKYU/onDZ34FFEACZLFdRaVJXbG1vRB3pOV0NEzEQnuMBV/2K2f?=
 =?us-ascii?Q?gnvV2oDrizOY1P8nVcby7cEOrH0GacbbkzZhvn+bJad9GM4f+yfUqXQ4CtrY?=
 =?us-ascii?Q?1xOSCd2KffONiJongVawwOPB27i1g67iDOEJFEFODnb8birKI1vQiTXkRqib?=
 =?us-ascii?Q?1QiEGBuSnhOe8mckhxRIzTfz9k4FF4YDWXK8A87B0N1UVKEBf1oX9Iz9zZ7E?=
 =?us-ascii?Q?cNzaEEbXHJLIDe17Tn5m/8CBhxkBw8aPLupDppGTfI55ZJqtHTXllZJq3olE?=
 =?us-ascii?Q?mSrIN1EXKnc1xRpDlmoyTF3b6C5e3mqbFAHZrkZpEdPV9JbNRd7mOjOjBDxJ?=
 =?us-ascii?Q?OWXW3/MS28TFt2qtf9qa9D+g9U0LJknMnaOV0bG3idGEzvZ15VCrUu5ky/cN?=
 =?us-ascii?Q?6BaHvf5BmUzSuZQYmyCuG+FaWQGhu9jfbmXOMjgqDhUjkiQXQEpr7FVnYUDD?=
 =?us-ascii?Q?dhMGZuPslyHzaZENdoFLMo6oKsS3edxJOkoN260b5igBoZJ+bX29rUHXxGF7?=
 =?us-ascii?Q?No7DaloBMbFZXF8xuaVHY7BUnGqW9Qtz+V7tVwSz1V9Feh2KcfvRKWkFqOVz?=
 =?us-ascii?Q?aQOKLtcayHpNK8moipZU907saBY7UJVDXqEZ4+90DyshSkUMfh6arXf2NSb1?=
 =?us-ascii?Q?GgeRaqJ0s/qlrTG5h0XCazu6KNyp3ZJGKpugm7ydeRwhymCtxtdl7Oo2O70B?=
 =?us-ascii?Q?KAUUcFxf2lRmKi2bg1jzkPsTUf+l1nqC8QbWsrZTBNQHH1HsIZeoNcpuU7bi?=
 =?us-ascii?Q?lWLkOYOmQg0hsXat0Fo1VJv0rIJS9tLaeF9oBfo1yfQlJliEUOoy8sK26dJ9?=
 =?us-ascii?Q?nw8LoUzD1phq8kBBqdVTc/USQJcaq5IzPs3M7OcJQEsj6OBMWcSZqsLr2hJ/?=
 =?us-ascii?Q?6oFC7ED2jQKurZwY+/M+T69Bf5o7q+MqKqLEJO9UOUquFB6uxXjA004WrZtt?=
 =?us-ascii?Q?w/wzwRTrviCTqcSDrVxG4M0FgLILbea2TVFyOmfV21qpYnKkYz3t/TIZkmE0?=
 =?us-ascii?Q?A+X/69YDERBFKjm5qN+NvsECBJlufeAjV3vPqgRglVAgAIKwzt9fV0A/Vhs2?=
 =?us-ascii?Q?qtIFkXstZ/K8RBWEJvc8fL6+8zE1PHQ=3D?=
X-Exchange-RoutingPolicyChecked: bJrc34NTuEoxX1k0OOCUl7ss808a+SDM9KQU5NTm81ayNWvjDXtT5cqHuXVHv9l1fim/GlW+XLKOUA9PcX4USv5jNj3lLMgKqXcQ4Ak9XDRYGXHjxOySzsL5zLQ0e84Z0Pt9Jy+m332DIXZFE8uwTAUL58F/74huYtfYvN/21MVDP8D6e8QCf4Nr9Jn9QNZ1EEXuMguu6mbH5sh2f/pogkl+z14yhsbETKCDUmDUqkWN/CV1XKP3L2yDDkD7mNnyVwc/HAxXeZ8rWAwOAmhrKFoCbQCKKDvz2902mLbG3UrVQkqRwuxpOUe4aS6H7uQ+7hjpvMZiXQjODk4EKN/Fpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 359cd654-487e-4e4e-8dec-08df301744fd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:34:21.0718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCFjNKRBj3N/aQnypofOjofKiOSgNGoQ9GkDRMlNI8Rx0a1THCKo6xu4KGaczDDcXhJBGSzpY64GV7CTduhNps9ZXTGnBSp050Kt8SgIMMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8431
X-OriginatorOrg: intel.com

On Wed, Oct 21, 2026 at 10:47:33PM +0000, Paul Moses wrote:
> xp_assign_dev() sets XDP_UMEM_SG_FLAG before checking whether the
> device supports multibuffer zero-copy. If assignment fails, xsk_bind()
> destroys the pool but retains the registered UMEM. A subsequent bind
> without XDP_USE_SG inherits the stale flag.

so you opened a socket, tried binding with XDP_USE_SG, failed then retried
without the flag and you noticed unexpected rx frame size due to kept
XDP_UMEM_SG_FLAG - do i get this right?

socket not being closed kept the umem alive...

> 
> The flag also changes RX buffer sizing after DMA mapping. On igc, a
> failed SG bind followed by a non-SG retry with 4096-byte chunks and
> 1792 bytes of headroom passes admission with 2048 bytes, but programs
> a 1024-byte RX buffer. On I225-V hardware, an ordinary 1514-byte frame
> is truncated to 1024 bytes or 1008 with RX timestamps enabled.
> Restoring the original flags eliminates the truncation in both cases.

It should be enough to state that sg flag presence takes into account
tailroom size and therefore has influence on final rx frame size provided
to driver.

> 
> Save the UMEM flags before assignment and restore them on failure.

Regarding the patch content:
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> 
> Fixes: d609f3d228a8 ("xsk: add multi-buffer support for sockets sharing umem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>
> ---
>  net/xdp/xsk_buff_pool.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 0ebd4d46f7ab..7750d2ec4ee2 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -166,6 +166,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  {
>  	u32 needed = netdev->mtu + ETH_PAD_LEN;
>  	u32 segs = netdev->xdp_zc_max_segs;
> +	u8 umem_flags = pool->umem->flags;
>  	bool mbuf = flags & XDP_USE_SG;
>  	bool force_zc, force_copy;
>  	struct netdev_bpf bpf;
> @@ -268,6 +269,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  	if (!force_zc)
>  		err = 0; /* fallback to copy mode */
>  	if (err) {
> +		pool->umem->flags = umem_flags;
>  		xsk_clear_pool_at_qid(netdev, queue_id);
>  		hlist_del(&pool->dev_node);
>  		pool->netdev = NULL;
> 
> -- 
> 2.56.GIT
> 
> 
