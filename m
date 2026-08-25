Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E9434A3A5;
	Tue, 25 Aug 2026 03:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787630390; cv=fail; b=bsHDXXCvB0xpUjIiRxjqw+ummVcD6w0wp8KjOHuob7sVY6KtmQS5++MOwjZA+qqaBn0Ww5mi3quXcllUeiWlkNJmSstA5y+Hed7W/Yw49aUW6mc6litSQUmxl6Tsz7yke9a6jTaTX3cYCpr0sAhy5OXestwAD1c0QoIBEpntdCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787630390; c=relaxed/simple;
	bh=WbxEprDro3kBLC3dlLDOScaI3UYd4DkOFy+/RxEidQQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ifLSMhavsJGgPAonZWvJ/EuWi9sWSemCnjt3T+xu3zFCDnEx85KR/Xjn8MheibjprfmzFc9hy0iZkEHDKDB/NNKlE8GNcFC3/PHd5mw9tGiKR0NWHyp5EB0wFK2jyNjRFkW5TdWYL4EZ6IbV7CscHWKepcgMuIBTo0Ccr00FFiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLw5MLxS; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLw5MLxS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787630387; x=1819166387;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WbxEprDro3kBLC3dlLDOScaI3UYd4DkOFy+/RxEidQQ=;
  b=PLw5MLxSeKTuTY38jgOV7H0eEl+4hTYCWYGdAPi/VXvJxTYsco/DlCtE
   Zi1/b+EpXfrjYLfTKkNFi/OFbjj0ikJfdtnb4KQou0Q57v9hrDdwplslG
   hVmDYjTVW2VY2iC4vK7te/jS1ACtkngcRRWxEfREyX00J0i3Y0v2r8Ooy
   Ndhb/BmiWnQXz//M52JNGHIFRaRjaL1vZ1hmEo4xeHAmZwp7Zb06l5mv3
   rHBlSNQiVP0WVMDIFd3IeG0MMnctJWClKfbJcqDr+3Eycatyisqii3vC7
   1Y+YE/MSq2PlHwd7U8jiC0Zkp6s1lyq/RYOQ1ZCZVNt5RuWZXn8r4JfW7
   g==;
X-CSE-ConnectionGUID: lfapwfDLQSKM1hZ1knRitA==
X-CSE-MsgGUID: 9qflGGV7TdCm46HosyVbBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="113626715"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="113626715"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 20:59:46 -0700
X-CSE-ConnectionGUID: s+HLXMDrTuOPE6A+nkdFRw==
X-CSE-MsgGUID: PY7Gad0ZTc2w9U2n/ALTtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="270979152"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 20:59:46 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 20:59:45 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 20:59:45 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 20:59:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5g/GN2lSfpSNuQAogWmClKNU6THD3yUCXesy74dl4aYvzzs0wgOlDkqJtKDe/ObuLFPMFoCePnrWwSiarHe6SjjwxbkGZwjSjHVBcHE2KBkyRn57sM+4nBEywb14KQ5sxWGAXfn0ZjHaWj+4n9cmJ4uM/1eO4rQuk3AoS59F/XwNo6HI0hgURKBZAnVnByUnNhN8xK1nG6fd7fa5xnXKDo8csp2x2Du+lBfqoMSa1Jodi36gTlSS7YuwILeNfsPc4LKZYnBdV5y4NyY2t2U6KOJC/qW0sd9pY2CmAxySw46Tpfs1/fQF79cc33HjMGfKQGonc3tYnQyfTwXgj9RgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFesFC4IVVduh5b6hSg5+ZufPtt7N0oyvqjmcVWLsIg=;
 b=Rf6JJx+fLUEbz00o2HPrBIDYOAtVMgWytZnF2au2kq9OiMPrB4WsmAD5AL8hy2BcU4ZDNC45N7Okm9VkJzm9sMdywFPW1BlWZEzQR5jNmeq+qQwVPNGfwyrEQv4R4ln1AsVoaXGIEwcLiiv7VKPQdgDC0xpTpmT85Lh3nhVLQox7j2FFP5VR0xnlddf1qogtSWMR7OwAF5v3bjSK2WvmmYM2SuZSE39KpfsEa1hWatjCjHaj1HWXV0/9IYNFffI6yA0WNES8/EjC1zK7gdIQV5JhLCPz6ByNDK+zwlZEnNrvAvuk8RubjNoUUYAKknwPlgXWSGd9B/NBeXyC1joAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7752.namprd11.prod.outlook.com (2603:10b6:208:442::20)
 by CY2PR11MB946807.namprd11.prod.outlook.com (2603:10b6:930:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 03:59:41 +0000
Received: from IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce]) by IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce%7]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 03:59:41 +0000
Date: Mon, 24 Aug 2026 23:59:36 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Matthew Brost
	<matthew.brost@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, Raag Jadav <raag.jadav@intel.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Andi Shyti
	<andi.shyti@kernel.org>, Ramesh Babu B <ramesh.babu.b@intel.com>, "Michael J.
 Ruhl" <michael.j.ruhl@intel.com>, <linux-kernel@vger.kernel.org>,
	<intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v7 1/3] i2c: designware: Global register definitions
Message-ID: <ao0TKF859v36PAn2@intel.com>
References: <20260811121008.1493015-1-heikki.krogerus@linux.intel.com>
 <20260811121008.1493015-2-heikki.krogerus@linux.intel.com>
 <aoyb0WYzCd-DEIWC@intel.com>
 <20260825034803.GJ893316@black.igk.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260825034803.GJ893316@black.igk.intel.com>
X-ClientProxiedBy: BY3PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:217::15) To IA0PR11MB7752.namprd11.prod.outlook.com
 (2603:10b6:208:442::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7752:EE_|CY2PR11MB946807:EE_
X-MS-Office365-Filtering-Correlation-Id: b258b8d5-0948-42f2-432c-08df025d4a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HFchzOTTem5Gry8YvA3+fvrx8RcZv2JQknGkr1saemGOa64mO0G6bVCG6IuOMepg0K3Hlv3v0OgDHUmi+0W1fmljdzZrJUNqWVvmvQ5is6zSnWudgDI1JIQuFXx8mD05vbgy8jSfohcUzEe4WXOUf/WDtVekRFLFSqxqmk1okn1MIKL4nUwritgKvcyQQJX2VCrAg4W3BUcPDbe+SHTguRaOPNDBLrc9HoNbB3a37o7l9shpBQoA7kVE4JUcmhFIvqfkBb6YtIjEWaHdObAvesjxBbCoV7Q1XsUQQrO4HJvOJt0oAkbCBA6CqzEglVD6lzBmBIJvqptrwyAOC3xr40B9egS/Aa9fDwozGfL5YV4fYAphCMhEaQZrKZVME40w84tyf0X/JORuFXpylzvw+/RMB0VDPXhj8pLPX9dTXV5BC0BCFEQhQWfM2EP+FT9X46b7Q8+o+oOHHZo+9439azo/P8MCg+RjLoHdAZQwER7QQomWIzqZ+dONZ69/XB1c+lBgjN4F4X1mStKbzSKWaSkOH2rUc+FxRZTjq07UHfLc6py4EWYgpOJC3TK2CK9qpkXMYOrG66mSlq/PuOrN5/opVB3jksYhTZr41Q8LaR5ljx9Im/A6+i3qpGGsbMS37obtWqAawM4/I8ScoyNBFTMH3pfqy1Vxczzq0q0sNmA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ybDzelOrZL3JK+y9PmxDTkrCSi/H6RQJv7rFprbBdH7xBM6CVMX9FvCJTqIP?=
 =?us-ascii?Q?7WL342zvrCTqYVdzPZnRjg6PehifugnYPF96RFJRT5VnnG6YbyT1l/uzrKbZ?=
 =?us-ascii?Q?w9ncZT+YcUQqDHIWxGTTbDv/2TgUbVIGC6ThhWtAwuhA7P3s0ezDADjbiKo3?=
 =?us-ascii?Q?xr93YLViVRb+XNK47UFqcHwpSGCt7fX5R89arI4Vpu+mWH/w/eNhVMckkSyW?=
 =?us-ascii?Q?zyF+0NP0lFA7mxM1FCLzg5sv6sbO8UhRl1c0Gt+m7S6xnFL3euB5jSPDXxS0?=
 =?us-ascii?Q?NnlQ7RxeoEOTXDLNLeKHiTwLHjeQXPGJwene1ut5lnosHmKIHuxWYyRGQ3fW?=
 =?us-ascii?Q?HMJV5rLOcXUKExAtDMXGs13GhzZQirZLqjdw6otC+yfG5M+VpjZg1vRzN+3d?=
 =?us-ascii?Q?PeU9O49IRufjl2ZWmLG4I4kvuZt7RHaJBOVdq5SxRe519gL7LfliosI66aIj?=
 =?us-ascii?Q?DiN9sttQAT7P5je93W/xgKDRObUFuo0znZK6RGCQiWUgRikp+wwul4aVTso0?=
 =?us-ascii?Q?gzBVbWHfVxfolI/oh+oayTWIlVkxTqd7ddGQRXg/p/zYwA7ejB0ynQsUJvqL?=
 =?us-ascii?Q?2RJUZBKGgQWJL5Fa+gXmYUq2FFCgpwRRmxe0Wf/H9mLSMXlFhLiywJxRDAnK?=
 =?us-ascii?Q?iqAh3NRQOzWBO4bVPSx0NO08XtUR9xtyq5NZJh4Q/PhvKfqZAuGTS8U0d7vJ?=
 =?us-ascii?Q?8KEaWFfGElxAPbiki1w2DtMok8CZmaY2ZoBVCZO3tzFitJuaQnqoIlLQP2qd?=
 =?us-ascii?Q?GNDAK6DmpZLlTLKyhMi8DohU5wjKwqJEsjcq90PcDdqRQYEm1kqaRe7enIxv?=
 =?us-ascii?Q?HBkQhaSfQTXR8hEUc8y/6tEsroAYVWkXvcUpia4qwcn58OyNd+tJpAiAxyqB?=
 =?us-ascii?Q?XuzOKrIA/zOiu2Fn8P2iziQkPxAPKq7it38jyqPlcsmmbE6odtrcdngdWbzx?=
 =?us-ascii?Q?kkHYw0z6xs/6uiEGV1RXREPQUIpCNJgPYySk51Y0Ou1iTDh1qEtcKz2ZWHW5?=
 =?us-ascii?Q?NS1AYpiLzXCTg2XebWhpNmmGoNzmR1snTv5jEDoIslDrLftgWbRX5x5GN9QD?=
 =?us-ascii?Q?JZ3UiDtuwkqar5iOEsiczVqetjqnr9ioQ+lKztMYY7rAtOnQTVgNSkXeaJNe?=
 =?us-ascii?Q?Mg2eVyuod9Pb9BiU4VtU/LoEzFBzoBrqTTe2KM9njca9SpUxE6Pd9a7FYB1V?=
 =?us-ascii?Q?WvAUxYEtQeQFpFVK18N+UqSOTXZPQ+EkHnEIy3axxf6u8Uyd7q/gkcxiqib4?=
 =?us-ascii?Q?dvHUNaePQ5fELOFpw2qH+4qXaeZk+xAFh3zkJxztCza7icQkSdxPuhhYuj3Y?=
 =?us-ascii?Q?eto6NX/FJX7sCbY1DnktFac+HTbdd3D/7G+S0xaaywvhvEg8TGxPHmG2R4Cb?=
 =?us-ascii?Q?Ui8AhvoJYiiJhJ3oNJulUDUswtzoerJgQCHXZXKAK5gO/FUNdjYqN4OTOEf+?=
 =?us-ascii?Q?1+JcDqg8I1i8/VTpBKOMg7t2EIjN1UY8rO8ur3zqUpk4IwXbN1RWSyjNG817?=
 =?us-ascii?Q?wGbSklqe/lCQGDJ9Tfpnbfw2ko/kt58qPf/GpvRaWuOqmlZxJtetPCkwI1c7?=
 =?us-ascii?Q?62sxaTlyIfJ2VobdGob/GoEv8Fmy3WxigjjKEUIfgxgkRp4AJBJ2Kr2wUbF/?=
 =?us-ascii?Q?204jFZgZPe/wxz6P2ItWGlYRQFp051FPs8QSffI71Qlre1h6Zpo0l/s88BDM?=
 =?us-ascii?Q?RrqYouXblTiKMzW+osvlBAu/3F1WTudoBk1rtC4ATJQJFLLnX0q+M1YLivYF?=
 =?us-ascii?Q?HZzh2dBHgQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: ED3KF88DaCf+sD94TX6cuogHUY44/EKDUy75jvcpgPYvTOlDMlmyB1tZJJYpAp5sElwd5GKs8abx1iTsBvebrbi0JakekuXd/xvjAX6Pxo8ez3ZoOQjUY8UdP/KWtJnXb7BvBI0vvGlYanf4FY/3QmNPy7Awa6xDe2cIftw8EsLTBe83t1A8v3aZRyToSSFOftquJvLMjS358EBrh/PS4hkOjnPCfPSzBRwQwuBaVyFPHHm3vGsWtRBwz33riwWCicgf70wsay3j0rnJ1snkUP7eGixh7DaXaLj6l8a5nPn1LBXPanhcpjiFjkeTzbDEsqP7r4J9Yt/IC2oLSjFxjg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b258b8d5-0948-42f2-432c-08df025d4a41
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 03:59:41.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2zhXn7rGHie5o4+FeIzFg8E7DHg5dXY6JFjVqWH+VK+nGiKtfG+J2jqmfDOekpJ9KrS+62jHlaKGfVbLEhfoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY2PR11MB946807
X-OriginatorOrg: intel.com

On Tue, Aug 25, 2026 at 05:48:03AM +0200, Mika Westerberg wrote:
> On Mon, Aug 24, 2026 at 03:30:25PM -0400, Rodrigo Vivi wrote:
> > On Tue, Aug 11, 2026 at 02:10:06PM +0200, Heikki Krogerus wrote:
> > > Moving the register definitions to a global header file
> > > include/linux/designware_i2c.h. That removes the need to
> > > duplicate them in the adaptation layers for this driver
> > > outside of drivers/i2c/busses/. There is at least one of
> > > those in drivers/gpu/drm/xe/xe_i2c.c.
> > > 
> > > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Suggested-by: Raag Jadav <raag.jadav@intel.com>
> > > Reviewed-by: Raag Jadav <raag.jadav@intel.com>
> > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Andi, Mika, are you okay to get this merged through drm-xe-next?
> 
> Sure.

Thank you. pushed to drm-xe-next
