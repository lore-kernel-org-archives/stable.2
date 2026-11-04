Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793807208;
	b=2hjyqXrZ/Uc13fn7gcapsSnM49ulaA+qyBYmiXF7Pnu1Os0lef0BN8Ooyi7HIug06VxJ
	 5lHyBPQ4f0hqFbA6wckwPJJ9KyqawIMhYnOLXxrh+kIK22FdvOJa4EZ+rxLsrXM+iv7J1
	 m97wB547xtSEGy+8KqK8PZYqX5b9KXcYGnaeNzEzkOAX85sEjpEacjVz242lhYdPDsyoQ
	 jhQjqxI3OSkkrzVJ1AuPB/6JxKcc4uvKygFVwcOqVGYc0zPWSI/YT3789k4DyIUjVRRd3
	 708ub6qVXj8mSFCry+hSl+2M/ERm2UNq8iXxqQEbXbfQUWWVNoqN4TJiSYEKVGMJh5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807208;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	bh=ZJ2/rVNtURlV7ldn17YCCZdp3As7pNSpHGRrsfh6lx4=;
	b=oTPCOj72VXXnO3srUqTL+2LyNWy2OtPeSics5duJ7KFDVPN/hLxn5xeC2GW8ryek4rEz
	 1HawfiUSD+eTVyoI1LVYsImOdaBUhaAutXSsYyRE+p2H4T++pAW/3D+M+uforAeSVUQuP
	 Xy7Tz+HLT+AtocfbUYfN1MwFeQeJVYFbh+V7nyLYF1rOPHL9qRKZJJEl6hg//LnwrRgCL
	 yVn8MRNsn+G31cYTfImSeDajIyzpFFAEGU+oX/UlvTikiZMwIUvNBt9KUVVpJO/hdLGZd
	 QXwOSXiyfbf9E8VMgDHoTjwwElUvx5eokCQoYQskix5USfIsNEuB/WKT5ecLbrLJ56g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="b/5rD0qp";
	arc=fail smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB046606A326;
	Wed,  4 Nov 2026 15:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB046606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b/5rD0qp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793807207; x=1825343207;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tFvVod+OeE37fMp+WTbQgNpCsb8E5m7TN/J9+gjJepk=;
  b=b/5rD0qpiygq8uMF7+6RanpZRnqQVeeEiqrhtc2lu7CKSofvLuwt0m0d
   7U0PN3tv/9S+r/xSNNUTQK/0YI/Ffo6Imp0INHzQG/x0K+Km8F15T8l+/
   jL7vzvqdrK121xh1KJNw5fg/Y+T/EiXXl5ONSX2sH+GIUVRP+nDaE5xYu
   MxpPVGFPFsrqbFej7ZaxPxNfZGn4LWSUjBYigdP0pbY8hPg8lsmEyC2lr
   iIm2lt19tGv/h/cw/Djo+yC9CtS/oU/NEbECKtgNzM5iKc1lXbNsELge8
   5ylZDeYuk593XzG7gwcWEiwWI2/LIWplvLszv5omE/fOtdNGQiFqUspQQ
   g==;
X-CSE-ConnectionGUID: /erzkgi1Qqa4+hsf8BUYKQ==
X-CSE-MsgGUID: S0BrUTlhQ4imKL+fYhlZ1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2562657"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2562657"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 07:46:46 -0800
X-CSE-ConnectionGUID: JMcADKXoS2+SmVBNUxy8Dw==
X-CSE-MsgGUID: AE3geQuaRt+Ubd9HAFxSZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6851483"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 07:46:45 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 07:46:42 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 07:46:42 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 07:46:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOBmQe6AtXFnSO6t9e3z7LmLaPAMrfWsA4aQ3DMGid1kSchf2jHnCvY9DSXh1Y0Z4lVRj5uDakzgQnKCDx4nM3yLkorB8n+W/pKjN6joJ+jrRXSF2U8MLB8fk7kAzA8JE/9aWkqHOXCF9Wwm13lidT3MAP8/FD7duy+x27BW0LVV6REb1ylEx+vxP9YY29ASPS6KbalgKIShWp1z55sosN3IWuZ1SSYDNbRsRmSGGd+jFU7SSdcokXNDox3Jo7wuTf2AaFHmwGGCcYPcmrtdAdDWcd/EcTqXmcR/nfYUs/Fm5/zbrpTuuFUB1X1YefV1vJbTd/CceRKst8eKaLWIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJ2/rVNtURlV7ldn17YCCZdp3As7pNSpHGRrsfh6lx4=;
 b=HgCuZKAmrqAP7yQS6EvWgK8d9ou7EhjOmWACt5h96K6a5FyxFNg1QCQ3vvfIt2wdNfSj4Le0bJPi6+fONW4bizkB8eqSLrSQA4zYZaEG0fxkrlE/SKrkpKi4YCmA3QFmsydxHm7N4rYekUY9usm37YHrAri/qo+uaFXiix1lzid8KVwzRRVt1LwEZxn7lkJNMlkF/Xja4FWphuf8rWIfFru3ls7VEiro7aGsMYPXMHEyKbL7aCtHSsgtk69BSbFwtxBEzkS1kXWZV/twUrFTCqQX51E9sSZxPVj8hBUnp+csc0GvMMtAkwUQorXU9H6Y2BZR3XgInjMMk61oCIn0Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by MW4PR11MB6619.namprd11.prod.outlook.com
 (2603:10b6:303:1eb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:46:36 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 15:46:35 +0000
Date: Wed, 4 Nov 2026 16:46:23 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Amaan Cheval <amaan.cheval@gmail.com>
CC: <netdev@vger.kernel.org>, <joshwash@google.com>, <hramamurthy@google.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bcf@google.com>,
	<jordanrhee@google.com>, <przemyslaw.kitszel@intel.com>,
	<pkaligineedi@google.com>, <maolson@google.com>, <csully@google.com>,
	<willemb@google.com>, <yangchun@google.com>, <npl@google.com>,
	<awogbemila@google.com>, <shailend@google.com>, <nktgrg@google.com>,
	<maxyuan@google.com>, <bpf@vger.kernel.org>, <john.fastabend@gmail.com>,
	<hawk@kernel.org>, <sdf@fomichev.me>, <daniel@iogearbox.net>,
	<ast@kernel.org>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v3] gve: leave refcount headroom in the RX page bias
Message-ID: <autTTxuRQFF00PCy@boxer>
References: <20261103090651.35399-1-amaan.cheval@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261103090651.35399-1-amaan.cheval@gmail.com>
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|MW4PR11MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 876e6556-cc83-4b37-d42a-08df3a8aceac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|10067099003|22082099003|18002099003|261022105027099003|56012099006|261021133027099003|11063799006|5023799004|261022113327099003|261021130227099003|261021121427099003|261021135927099003|261028144727099003|261102123227099003|261022115727099003|261026121527099003|261026130827099003|261026135527099003|261026140227099003|261021123027099003|261009223027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: fTGTytTVtkUdrQ8TvOeGN3tIuQOjMjpmH/iHNkOpFpt5dsmbhbyc6xeo4L8otvR1c+yO1KgmbdGV1DE4MO4LxXHAhbPMyp1RrHNwXZzvOVzqrpdHj8j9f7ljaYp8UaBkJhzC0NA4MjsIgvfL3Pu+de3uOFIVfq0nXzTgwGNr6CEmyQ1otTyo/+UM6GSmMcIMTtRD5aSUhEFyCwfObucyz6ZfX+ib14+vWiqFKroZv86ekFlAna0wfjNqfl3S+SX15bbLP5PnK1LlpydDc4zLosRkXKfJRN2Q8wc2mE7e9Puhnzi7pTfN8jdSora5sr2M8VCNrn7F8+RRQeUoaPoTfOEHSznp+wJTST3enFmt64Ae6DdH+IoAjado2yzUCmrGShtK3Bal+TGnjEi7rUOhrmX2hCvKPMXua8ag5C0hfzPvJY2x70vgGhHbesJru6muoGshQgkpX0ujE+iNDpNxcqH3zSuyWlwmRz7Ql2LnaoQNyQL36zO9+gCxlDRTEDnOCGfNU39fvrb6t6PruCAgmQ6cHnLIRV3kSvzYAA3r0sWzzJKU1CDzhkNx/2reMF+9ODT6lJfGInzMMiM3B4V7wXgfigekvGkbzrpT5OcxJXqeDA+YEhNk00UuKMTAcWOC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(261022105027099003)(56012099006)(261021133027099003)(11063799006)(5023799004)(261022113327099003)(261021130227099003)(261021121427099003)(261021135927099003)(261028144727099003)(261102123227099003)(261022115727099003)(261026121527099003)(261026130827099003)(261026135527099003)(261026140227099003)(261021123027099003)(261009223027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?73EHhllHN0OPTbvno0iLZP1sM6mi2R03QrBvkoHY7YqEK064Z05T3AnQ+CKR?=
 =?us-ascii?Q?l9idbRxPQQk2XQDMvNwLE8adYzBt1DgW8uB/PY6J6/uUgTy5founJcDC6CwQ?=
 =?us-ascii?Q?v6+lgifYblBEck5wlN1IMtIx2tGN1DpJaBrvDVokKmSI+Oyg82gBAnu5+RT5?=
 =?us-ascii?Q?czqZ5lirkbM6DZods2YP/5eMLgy9lCh1pSmfB9Vi3MR84BtTBygZfREc63sb?=
 =?us-ascii?Q?ShjS3ZR4BPpxd6BpxfnuacLHqGHT9/up8vGqO6ZK9xCPjSzDPC8hkTw0YV32?=
 =?us-ascii?Q?4sBuGxKpYLeISPTmrrYAwUTek0b2dfMmS8stU/dctZG16rD+9l0cB2ZZlZcr?=
 =?us-ascii?Q?4mSr091ThiANBhF6sMw9XDzzSHyc/BfnPPLecFuNsxJt9p1UqBA+4m0C4Xpe?=
 =?us-ascii?Q?47bLLHm42U+hKxC65ujZeyUWw5QR0UyF08ei6GBEWeMn8U9BEZLwoa6tnNgu?=
 =?us-ascii?Q?bF+5uRXnqz6jtJmiKEALMHPOVehNG/wBWw0jdDYFRmc2xZClm+5fdVJhAAYP?=
 =?us-ascii?Q?jIN5l/Gs1m7rrvYswT4FfPojH4GR78suE7trbv3fb2AXBfTi8BLcWGEICP5W?=
 =?us-ascii?Q?J6lhPxfyDUA+uEESBQKiTACFnAmY+r3QlX2zEj7akgCkHruZoqBh/jVMh49K?=
 =?us-ascii?Q?oeeJGmHF4+BW6oI8HlaHvuV6r3cN8iu/8cjli/0ylanApc6MdPjgPdIQt9os?=
 =?us-ascii?Q?d7KQUynbplBFQsUoVxT2SqxTfcELzsMws7hcuHsphklO0AAmev4nOWLKGIqd?=
 =?us-ascii?Q?Ivi1D2r6HwH+gDcIKkUG8343UhwRP2D2E0vYBzy5E5zlTp2qRgqMQE3j8+4m?=
 =?us-ascii?Q?Wh9RkfNSfedU9K+qK8ysfMHeCsCOMO7L1AX34c9zgxsKzxClkjCzGjvcpssi?=
 =?us-ascii?Q?oLEMpPI6tR2bsCqqHhqaI0g2BLkdfW9mcCLFKdfcE5C9SxmKTBxJYwq9m3Lw?=
 =?us-ascii?Q?oa7sqMmC1L9G4U0y6xX2n5YkQxKzp6Xa8GJKQxXFYOV8AgK0DbZV5L0TCvsY?=
 =?us-ascii?Q?R9cDUWdD8Nacjc3reaBwJxzS5xzufnfnmIXcZ59BXHBKJuknOUaejYQsHixD?=
 =?us-ascii?Q?+Jmdcd7gTxKxQdPmKI0+FVHp3kl3UenVdz3A/AAy3p7grwszwVrsxx1KwYuB?=
 =?us-ascii?Q?jODxX+QtYSpe+oF1LikLcvV6329LuZ5gxNuN2KV22+ZgZBE19Mc1zKIAx9Hr?=
 =?us-ascii?Q?KTWCp2oqxKOjQpxLj/KNai+ULKZxSpE/KD+F3+xvc9rZ+28qQmi5zXN5y25D?=
 =?us-ascii?Q?Z1IlwMmBeZ/hu6mK96ygZDPmDgS1TwnY5Ib3o2wgEmp5X2pZhYLY9v5hEmEf?=
 =?us-ascii?Q?xJTrpD9/rsenYMJ3GSan/RhJz/GKTbXUYyhxpGASsIaGvdt+tPL4GENtQNOh?=
 =?us-ascii?Q?yx1eHIF1W+X3QiIumXrLYl3arh0sUZ1b4EsAAEHEACutXtwpw1FJANzT/XS5?=
 =?us-ascii?Q?H8JDaumd8UedDk4SnGgrBuSBueP0jZcMtSLpZTe3MpUTSlr4R4dRUAWvLC9w?=
 =?us-ascii?Q?ug+M/9+mm6uFYSwkO2PSpy+ywVnZvaqQpXMIl+WgBiAI8PycxPXXZmFzOyJL?=
 =?us-ascii?Q?Xs2zBQJDvDZl2eUSP4vkwp8YKE6aJTgSQ2dhcO5GKjD7+YecI0T1T3bYSeyB?=
 =?us-ascii?Q?YDMV9vftZiUuIcwzXqo5NtySbj9rMYAchVI/XgCXYrZfFtA41O2lhTgCN7ZY?=
 =?us-ascii?Q?aOB4BEOvNbliUXhpdejGQTusHktQCggfPFiGCy73ZlOqB0MYGUuh4r4A4uUq?=
 =?us-ascii?Q?1lUh3YEeLqIjdPVVR9JWeRVQ2+xlqSg=3D?=
X-Exchange-RoutingPolicyChecked: RTAqwb7YaRzrMPnCmgiWtij9m0zGWdIUdHtW5pxVmVXqIjzfluGng78nkOELi0TPaWmKVjzv1eTPAPphodn6nDQdtJHAs7blbt/4j3LaUiXhZ1z/13g0JVuX+dhDfXK8rrJqP39I7chDI5YJL/B0rThANkgUKTDtb80VRfrtST7tp39jPXVZoAgwZLsHCiB5l3h2HGwtHrf8Kg0xQqeEq/JBCuhFaleQgOq2FCCTZI4RB1c/d+57MM4hIya0cIAnSH+TaqisbzcpPy8TSN+FmI0OWD7HCDcuOoVW+A0stqUw3ritNbG6uBXoALj6ilExJGq8HCKO+X7NJi2HMIW8GA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 876e6556-cc83-4b37-d42a-08df3a8aceac
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:46:35.8052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFSUCKmfAQoznR/Z1yrDEolahq4DY+bLYvzJQg0VXwmo0lK5bIO3I6eIfmWufBavweihpWNJqSZo4jYd45ztIcraITuOXKEAPLGj0YaURa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6619
X-OriginatorOrg: intel.com

On Tue, Nov 03, 2026 at 02:36:48PM +0530, Amaan Cheval wrote:
> gve's GQI and DQO-QPL RX paths set every RX page's refcount to INT_MAX and
> hand references to the stack by decrementing page_info->pagecnt_bias, to
> avoid an atomic op per packet. This leaves the page no headroom: while a
> fresh page's buffer sits in an skb its refcount is already INT_MAX, so a
> single get_page() from the stack wraps it negative.

Hi Amaan,

by headroom you mean here the space for additional refcount bumps? A bit
confusing as my head tends to correlate 'headroom' with packet layout ;)

one minor comment below.

> 
> splice() of received TCP data into a pipe takes such a reference, and the
> onward splice into a socket then fails: skb_splice_from_iter() sees
> page_count() < 1, sendpage_ok() fails and the send returns -EIO (since
> commit 2e910b95329c ("net: Add a function to splice pages into an
> skbuff for MSG_SPLICE_PAGES")). tee() of the pipe fails with -EFAULT via
> try_get_page(). On GQI the reuse check gve_rx_can_recycle_buffer() also
> sees page_count() < pagecnt_bias, WARNs and calls gve_schedule_reset(),
> so a task that merely pins a fresh RX page (e.g. holds spliced data in
> an undrained tee() pipe) can reset the NIC.
> 
> Use USHRT_MAX in a u16, as igb, igc, ixgbe, i40e and hns3 do: the bias
> only has to make the per-packet atomic rare, so a small value leaves
> page_count() ample headroom below INT_MAX for the stack's references.
> Refill by adding a fixed batch and setting the bias to it, which keeps
> the rule `references = page_count() - bias` intact.
> 
> Reproduced on gVNIC in GQI-QPL mode (GCE n2-standard-8, 6.12) and in
> DQO-RDA mode (GCE c3-standard-8, 6.12, where DQO-RDA still uses the
> bias) with the help of relay.py -- a small splice(2) TCP proxy --
> relaying a download while the RX ring is refilled with fresh pages:
> 
>   ethtool -G eth0 rx 512 && ethtool -G eth0 rx 1024   # fresh RX pages
>   ./relay.py $HOST 8080 &                             # splice()s both ways
>   for i in $(seq 200); do curl -so /dev/null \
>       --connect-to $HOST:80:127.0.0.1:8080 http://$HOST/file; done
> 
> Most downloads failed with EIO before the fix (tee() with EFAULT) and
> all completed after it. relay.py is at the Link below.
> 
> This bug was found and fixed with the help of an AI coding assistant
> (Claude Code) over an interactive session; it read the driver and
> splice/pipe code and ran the tests above.
> 
> Link: https://github.com/amaanc/kernel-bias
> Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
> Fixes: 58401b2a46e7 ("gve: Add rx buffer pagecnt bias")
> Fixes: 82fd151d38d9 ("gve: Reduce alloc and copy costs in the GQ rx path")
> Cc: stable@vger.kernel.org
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Tested-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
> ---
> v3:
>  - Refill when the bias reaches 0 again, as in v1. DQO-QPL is not
>    supposed to support XDP at all, and it will be blocked explicitly in
>    a separate patch, so the v2 refill-at-1 change is not needed.
>  - Added Reviewed-by and Tested-by from Harshitha Ramamurthy.
> v2: https://lore.kernel.org/netdev/20261102112613.18334-1-amaan.cheval@gmail.com/
>  - Refill when the bias reaches 1 instead of 0 so the driver keeps a
>    reference of its own across every handoff. At bias 0 a consumer that
>    returns its reference synchronously, such as an AF_XDP socket in copy
>    mode on an XDP_REDIRECT from DQO-QPL, freed a page still registered in
>    the QPL.
>  - Commit message: explain the refill point, drop the build notes.
>  - Re-tested on 6.12.113 (c3-standard-8, DQO-RDA, which still uses the
>    bias on 6.12): no EIO/EFAULT from splice/tee and no NIC reset after
>    applying the patch. DQO-QPL is untested; I have no access to that
>    hardware.
> v1: https://lore.kernel.org/netdev/20261031173449.2439047-1-amaan.cheval@gmail.com/
> 
> Built allmodconfig W=1, no new warnings.
> 
>  drivers/net/ethernet/google/gve/gve.h                |  2 +-
>  .../net/ethernet/google/gve/gve_buffer_mgmt_dqo.c    |  4 ++--
>  drivers/net/ethernet/google/gve/gve_rx.c             |  8 ++++----
>  drivers/net/ethernet/google/gve/gve_utils.c          | 12 +++---------
>  drivers/net/ethernet/google/gve/gve_utils.h          |  8 +++++++-
>  5 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index b7ce6e8632db..18d7edbf4b3b 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -119,7 +119,7 @@ struct gve_rx_slot_page_info {
>  	void *page_address;
>  	u32 page_offset; /* offset to write to in page */
>  	unsigned int buf_size;
> -	int pagecnt_bias; /* expected pagecnt if only the driver has a ref */
> +	u16 pagecnt_bias; /* expected pagecnt if only the driver has a ref */
>  	u16 pad; /* adjustment for rx padding */
>  	u8 can_flip; /* tracks if the networking stack is using the page */
>  };
> diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> index 6880d1531ba5..571f851d6dcd 100644
> --- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> @@ -149,8 +149,8 @@ int gve_alloc_qpl_page_dqo(struct gve_rx_ring *rx,
>  	buf_state->last_single_ref_offset = 0;
>  
>  	/* The page already has 1 ref. */
> -	page_ref_add(buf_state->page_info.page, INT_MAX - 1);
> -	buf_state->page_info.pagecnt_bias = INT_MAX;
> +	page_ref_add(buf_state->page_info.page, GVE_PAGECNT_BIAS - 1);
> +	buf_state->page_info.pagecnt_bias = GVE_PAGECNT_BIAS;
>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
> index 81ea800e66e9..6533fff06155 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx.c
> @@ -152,8 +152,8 @@ static void gve_setup_rx_buffer(struct gve_rx_ring *rx,
>  	page_info->buf_size = rx->packet_buffer_size;
>  	*slot_addr = cpu_to_be64(addr);
>  	/* The page already has 1 ref */
> -	page_ref_add(page, INT_MAX - 1);
> -	page_info->pagecnt_bias = INT_MAX;
> +	page_ref_add(page, GVE_PAGECNT_BIAS - 1);
> +	page_info->pagecnt_bias = GVE_PAGECNT_BIAS;
>  }
>  
>  static int gve_rx_alloc_buffer(struct gve_priv *priv, struct device *dev,
> @@ -230,8 +230,8 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
>  			rx->qpl_copy_pool[j].buf_size = rx->packet_buffer_size;
>  
>  			/* The page already has 1 ref. */
> -			page_ref_add(page, INT_MAX - 1);
> -			rx->qpl_copy_pool[j].pagecnt_bias = INT_MAX;
> +			page_ref_add(page, GVE_PAGECNT_BIAS - 1);
> +			rx->qpl_copy_pool[j].pagecnt_bias = GVE_PAGECNT_BIAS;
>  		}
>  	}
>  
> diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
> index caed38cd5f2b..cb6fba3122d5 100644
> --- a/drivers/net/ethernet/google/gve/gve_utils.c
> +++ b/drivers/net/ethernet/google/gve/gve_utils.c
> @@ -93,15 +93,9 @@ void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info)
>  {
>  	page_info->pagecnt_bias--;
>  	if (page_info->pagecnt_bias == 0) {
> -		int pagecount = page_count(page_info->page);
> -
> -		/* If we have run out of bias - set it back up to INT_MAX
> -		 * minus the existing refs.
> -		 */
> -		page_info->pagecnt_bias = INT_MAX - pagecount;
> -
> -		/* Set pagecount back up to max. */
> -		page_ref_add(page_info->page, INT_MAX - pagecount);
> +		/* Out of bias: take another batch of references. */
> +		page_info->pagecnt_bias = GVE_PAGECNT_BIAS;
> +		page_ref_add(page_info->page, GVE_PAGECNT_BIAS);
>  	}
>  }
>  
> diff --git a/drivers/net/ethernet/google/gve/gve_utils.h b/drivers/net/ethernet/google/gve/gve_utils.h
> index bf2e9a0adb36..316f97607351 100644
> --- a/drivers/net/ethernet/google/gve/gve_utils.h
> +++ b/drivers/net/ethernet/google/gve/gve_utils.h
> @@ -25,7 +25,13 @@ struct sk_buff *gve_rx_copy_data(struct net_device *dev, struct napi_struct *nap
>  struct sk_buff *gve_rx_copy(struct net_device *dev, struct napi_struct *napi,
>  			    struct gve_rx_slot_page_info *page_info, u16 len);
>  
> -/* Decrement pagecnt_bias. Set it back to INT_MAX if it reached zero. */
> +/* Up-front references gve holds on an RX page, so handing a buffer to the
> + * stack is a pagecnt_bias decrement, not a get_page(). Keep it in a u16 so
> + * the 32-bit page refcount keeps the headroom every page needs below INT_MAX.
> + */
> +#define GVE_PAGECNT_BIAS USHRT_MAX

IMHO code would be more readable with plain USHRT_MAX usage then you know
immediately what value is being used. Other drivers do so at least.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> +
> +/* Decrement pagecnt_bias. Top it up by GVE_PAGECNT_BIAS if it reached zero. */
>  void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info);
>  
>  void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
> 
> base-commit: 21f57ec673a1917547c808cfa81890485fffa03b
> -- 
> 2.47.3
> 
> 
