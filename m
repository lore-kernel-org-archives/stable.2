Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795071973;
	b=Q0GUf15X9G3yHG2HlG1xNK6gVaS1hsr/4mjrveR9zY++bLgAREQF3BjCoYd4nZ7xrU7A
	 S/XEujoAP4DU/SXz54hbDP+sS6m6lwuVq2glbwkZabluDieyKfgvPmTXFEDWvEMKFd5nF
	 xUKEOCZ31AKGmerqxPX0qP7uUmkTZLA6spdv3Q96VsfcHSl2cA97XcF2ZDdkAW0QwAHiQ
	 qH0HC4+2UDPyL8Ptej0YzfC3J1C16dGSkTpE/oMNA5PVPCmEvR7PRqEmqvZP3D5/5vIay
	 GtYTfc1syd8dfYm2n7oX9BOOYZI2aF55hrHOTj5fLREoagADx5EZVUeqXZBotsxlWJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071973;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=GwAjgPSwuFrw/DMJBF5BOwrgxI9Hr2U+TwwfMmWotMU=;
	b=JoQZVrQ97USdgR6IMpG1w5g98aRjKZPoAeJCL/8YU8ry32ajFlenTJ0n5br+JgwebQKp
	 jwMX0x8XWYPK9O5Q1GiqOnwpKvxl8QV+hCqQzrtKCaf223dfolUr3mD+SQZKMfzPlNdJs
	 s8mRGB3YH56lFguD+G9CEveb8wRyzwo8CN9BlE8apEsRDPMo+1k6EsujQR8VxAgWbRMGH
	 /BHgErpkk+xcgzDETDzvkhM66UXcUNYUSqD9QxTyNO/9uxV3WejYTTwjXF55CTYuMPtIv
	 elRVaa9M2eLLqlLINDn+bpWPHWC7z5qRXXCXkQK5u74qCXX7T2A+NDTbt1lq2VAEzuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="W/N5bt2q";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.42
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D760606A320;
	Thu, 19 Nov 2026 07:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D760606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=W/N5bt2q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZqkrQuOHiA3woJ5Ii2x3PsCFwt+hEvu7Du/BdGsVPjiO8GwuKobVkGSOG2iMS2zZC6YooNSowL+TX77AYnF//dhD/s9Yt9jdevOuRWesZnctZLQTjtG5KNc54Ze1/jyyebouFop4H9N5eAroSRcf8kV8zMwYQ8IZUsQ+5bm1T1MK7KW0Qh8Pv+eOMdPQqFSPpbiqGhzujVY15c6hPAQgwX920XE9KYBe0GRcvDMSQNxTI0e1rLNuTMiCQlBSz/Aj/S9iySUm8htEE8K45QCToL7jIyQyCrJe3LbatxUHi4MiSFTqS8JJbusdK0nntHKj8ZDcqGmMc2NndttGrVoIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwAjgPSwuFrw/DMJBF5BOwrgxI9Hr2U+TwwfMmWotMU=;
 b=P/HJFvT3CO5cb6PTGel7vkbkkV0neMQWkUhnoa4WPhqvULYkuPiZrhXBlA3L62EX70C9RSD0RAPysz+/G18CYOF/18Fj0nSCmtRsm9xcNnauCP8oFqiM7jdclpFn1tZKpSa+cv5mLIKDup/zNR56UAkCRyfyKicmCSAZGA8ygynbsInK21f9UnI5dBl+u1dBnEhI1yAtBfBTizd6YOJGW1JK1o/9wd0zMJdfIsX6F2bD/PF9RR0/SeA4jcQxcHqWU1wZ+5amHcxTgTAG71jPU8Rq+KiRv7UCu4gekP6wgI4zcPFEypXbn8kEQ6bKjBhDNS9+/5b9ljMaWNRZcbGPcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwAjgPSwuFrw/DMJBF5BOwrgxI9Hr2U+TwwfMmWotMU=;
 b=W/N5bt2qj7Qe4XXVtt1pcniAkUewNBXC7POAyLPFYuuqIBAGLlAcjEqDJdJaRt8hcEoeTmAeZIw6INtMnxpKPlD9hICArQqrcLTJSTLGRGKGmTZdp3UXrBmJJ99WhS5JJgNOUEVtGOs7/tJPxEe24zRFD7d9hgOivICwJy8alCwauCwcREI5eOK/1/31n/oYEjIVNRT7t+1nbrZO55Ehx+DXr6rP48nEeHe+g8X5B/tHQb8Fs9c02wBssLr7XYhHdY1FJD0qSoIStur85f/ariq3PGi4/j60GlXQgENjDSyWnUjFmXmeVfCH/OMwnZKcyXv2fnENQ8qIjj456RTS2w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by MW6PR12MB8999.namprd12.prod.outlook.com (2603:10b6:303:247::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 19 Nov
 2026 07:06:06 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 07:06:06 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 7/8] gpiolib: let the character device free its IRQs first on chip removal
Date: Thu, 19 Nov 2026 09:06:02 +0200
Message-ID: <20261119070601.2145930-2-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118155207.GE46152@rigel>
References: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com> <20261116-gpiolib-chip-removal-v6-7-aambrozewicz@nvidia.com> <20261118155207.GE46152@rigel>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::18) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|MW6PR12MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bea695c-7342-474c-e745-08df460b944e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|23010399003|10067099003|261028144727099003|261022105027099003|261026140227099003|261022075727099003|261102124527099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	27axi8bwHkXrUK5uc0cq76geZCRJa2bCaxKHb76o2fG+6K6yUtyV3FOP1ucB3fHecggtbFx4hWv3z9W+iCBaTRBwJkibHxif7z2E0YJwryLPBJhWtlqFLcHWCX3bvzmAkbF0/NRrmwOGX08ue7bnInItgq7ICr3aITqeMpK6SpFukjmv/8EtAhFOG5znWGlOKxkodAjcy1H4fFQByxjSQx2XL00ahHsnYYc8GwMD3RamxjkwJnXqvD0ZUs2JUHS1eHY93D1MFei1NTKAjtGqaBK+Buk6L8SQsGsvrpsZpthnUZW5l00AndfqCzl1BZT2lRR06HsOdQWxlHUyxzGiZuETyxmKr0RCgJGaHo2yDCaazEBpUWRxu3u4HGvCrZ5Wzo4pfyAaLyAE4aWx7+90JqEPHAe5GPAl1DRol2WzC3qhgU8BI9yLkh87rkhjYr/xyvs1h6oBKq84nBCmbSQkL6iS7tTubEKxGeraq8Mqg9IKhuPrmqJMzJdRCoYsrCrvctq3G6P2exORTV/FLaXJPb5rmSwGhmaVUy5I1tqLnOBO5NEIEp/EANMps10LJm8f/VBkDY1sIB80BSPbwJ0w1x6W7i2P+5rwp1BYDv+8FXNsIPNOg4HFVtZyt08riBQlf/i8dalnnovXMRKOXUocttoPbil7QGM5vOX4PxrFo/U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(10067099003)(261028144727099003)(261022105027099003)(261026140227099003)(261022075727099003)(261102124527099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lQekEy4yXYfzRMNCDS1kOSh3cuvCb0B4DCePgFFTv6u2hs4cmq64Uj4re24a?=
 =?us-ascii?Q?8rUOFr44mYNLZMxw3sq4J+91Ampa64V8OsN+K7poCdz/XFbzyBz6YgudW6ju?=
 =?us-ascii?Q?aTmj+pttKsHmAZqLFAV0owigMyvjpYLFyRc8mwCA/mjMX0oAvGXp3dn0KnEG?=
 =?us-ascii?Q?XbBadi0x9BR2sm4Cvrx5Z3Wye51kRW8LYCsMq9buaQLfLb+zM+pgHmKfU3i+?=
 =?us-ascii?Q?c+tjRCp2QxW46O9gVkgHba6wbr37kSpR8Iy9G6lgwdYn0sXf81S0/WN/Mv9G?=
 =?us-ascii?Q?uqrlImX2w5mHlGYIuyq1TIk8JFks4dJgSATt5HkUd4mIvqZ73tR3HRZE9qKG?=
 =?us-ascii?Q?Ad64OCMPtrMvKcv3FD88HfJkjRwjZS0wq+rCPlvLFpLkIEbSYHymnBgOPeaC?=
 =?us-ascii?Q?ftkPBekqrHMs5n8VmrKgI1QmZdNluRG/E3idqt0IzdxDAEu3Sa/jCFqzY4kJ?=
 =?us-ascii?Q?/3dIE8iSN94RjBCwdb/8c7QTRI19tESEi+f4tJ3RFF6qCaPBwySJuKOEQmD1?=
 =?us-ascii?Q?tvZwpwZhYPHtzXwI5sfzJ8Qk/PqLEA1q3QnuZEgKmYkSjRf3jds7biYai32X?=
 =?us-ascii?Q?9JkkSrqZW8WvSZwqP0q6f4MkKWTdekSTH3qqWR/ChMKRuJ9YO+1IifHkmoPN?=
 =?us-ascii?Q?p7L4OtKXCi0El1pwyiShSyQnbeBq1fAFL7pG0FfIlbkOT8oerMnptA36/IHS?=
 =?us-ascii?Q?KV2YOxC1Basfsreajrj7gJ+58FvtBehDeJDTezKhsnkyOwkFNIMgIFhwZUyQ?=
 =?us-ascii?Q?o28bgSwuyr3m32A4TMFeZw5DTJW/qTaUticqm6AwkDYtcO9TWdzljHoDNldL?=
 =?us-ascii?Q?JsxrU462xK7zvDV3ExFbLZW8kfR4exjrOmyHS347jhxH1ds8JV5xQkYGxgTx?=
 =?us-ascii?Q?i7vUzYf+9vU39gEaGsdsuE83HRwenP8q2RFun3go9JHYN0GpIvebtfJROtIz?=
 =?us-ascii?Q?DxJfivhaIAL4d+UHLOoGELiMijXUVlzO/YnY2XsSh5H2omlEN/jFiHh6F2m0?=
 =?us-ascii?Q?EAPtqc9IIslvDo2m4z8i/7y1zt8LdEZUMB4Sc8FNxJk1CTzHJ2ezCaEEJPTy?=
 =?us-ascii?Q?4Hz/NRgXYpcFvvWSgFf8pdNVv6DKX5aO/WZa+EDyXpmQKTPJaEc1J6JQoeEG?=
 =?us-ascii?Q?Wun26YtrQ987/aBb21MBkjd76JjjGsRVfYuSRcEJRuYS+Ers4zHUWNSKTQu2?=
 =?us-ascii?Q?yVN4fbCi/cMx8QRLYdZyo7vQXXgw7KoRKo02VFdkujtoPJzdPzS1FGAMKtO0?=
 =?us-ascii?Q?qrUYY85ufSQl0VumEVWnG9I7rI7JaYM/RnH2UIlB9iKBRXU5X8EsmxGkYEGx?=
 =?us-ascii?Q?k/IhI0kvs9Ch/E7ueRhqmSDt6W1eVPzk6URZJRRpE+uRbLRF18rrufe0oJ/h?=
 =?us-ascii?Q?i2+s/NyFu6Utl+f/woZqGQFjKZMxeIyPwlTyjc6A66OyQCLEhvO9pnugFmHC?=
 =?us-ascii?Q?VGkk6pxTNErSVfjOo5J6L7waBFtKbkPVy4kh5HrsoePar9PHzxJ4AeT6puUB?=
 =?us-ascii?Q?VceBy9sW0XX2yDCrlfq3Xr3o1CaMDeKklvkHfa2IUPHu+wuVcdZqdqMCyHR9?=
 =?us-ascii?Q?8FW5/NaBr+4rxxueZfS8NZ8rhqTb8E43HVj/INGXCzYZnnIUYrocVKJi41jN?=
 =?us-ascii?Q?BoUNb86igMLNCL+cR+bsvnRuvcVGnJIBaNY8IIu7vVCN3IiCxIT/ZrC8nioi?=
 =?us-ascii?Q?v4TQ0cQVmtYLEsftvjBBzRxpiRcw7pBiZIddiSANFTcbZ9I0XUZrEt2R5MNz?=
 =?us-ascii?Q?PgiYIBH7WQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bea695c-7342-474c-e745-08df460b944e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:06:06.0570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NS7WvakFOVXvcuouMRKn8+uir2yiVSXO4iPvIXbMVjDSCoxLXDMPedVYQc8jI1sy6/Hqgbv9tP5T1XlrpEueng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8999

On Wed, Nov 18, 2026 at 11:52:07PM +0800, Kent Gibson wrote:
> > +	scoped_guard(mutex, &lr->config_mutex) {
> > +		for (i = 0; i < lr->num_lines; i++) {
> > +			if (lr->lines[i].desc)
> > +				edge_detector_stop(&lr->lines[i]);
> > +		}
> > +	}
> > +
>
> The desc check is not strictly necessary - edge_detector_stop() handles a NULL
> desc.  The check just prevents a little pointless re-initialisation for
> failed requests so I'd be fine with removing the check.
>
> >  	for (i = 0; i < lr->num_lines; i++) {
> > -		if (lr->lines[i].desc) {
> > -			edge_detector_stop(&lr->lines[i]);
> > +		if (lr->lines[i].desc)
> >  			gpiod_free(lr->lines[i].desc);
> > -		}
>
> gpiod_free() has its own NULL check so the desc check here is redundant.
> While it was bundled with edge_detector_stop() it was a free lunch...

Thanks for the review. Agreed on both; I plan to drop the two checks in
v7.

Adrian
