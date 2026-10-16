Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012020.outbound.protection.outlook.com [40.107.200.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD1E43CED9;
	Fri, 16 Oct 2026 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136870; cv=fail; b=mbdhI9R7Tb2jd63FY9SwD6Cjc6mocrVXYaY7WO+EBRkCyZQqykde3vOe+nDmkCugCd2diHrsWGXmxp03sNZZsMmXMAP54+R8K+fo3lXH91zwAQIOMh6KULxSbS4AOshWfJyDT+fDX/CO8mPHUVDNp0F9vJ3h/E/TtBn5gW4BZ1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136870; c=relaxed/simple;
	bh=47UzgiR9LJHSQ2lWh1JHiER7zZvqMOyY7jkhGzaLlRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gyqDk74w/NnW0JMgUBKyk+qOXdIxOUvzbqQfgdbWyvodjvD+RgvOqPtyt5peEys2M+G4SZ+JkTBE67xjMNMB1HVMSpGKHxYvO967bFnS/BTBUv34TePYHNP6EXQDQhXPr4mtVsZQm7kzv8gUg3krCXd8KbPT5iMGZsyQULDEkg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zf8zxGEL; arc=fail smtp.client-ip=40.107.200.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zf8zxGEL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDTP0Oub2GNSuAv1Phs3ASKpZN+VO2lEnBRHykAQFR0KwyCtywgz/skhXpBOMmK0nRIZ08bDm0vLcRxCm7tKvksCMKJs20JvnKA0GfcJPl3xL+gzQzHAgZuHg8XrU/Szc3Z00qDs496Q2IZ1lWDsUeDnepqjx8Xxg1BPxIXKoAAvRFfd9TxpHrBPHoyyW5Ufq5e8YFJle3fbwSP+i9smA+uupIKhcyTU62AmY0o8Avl3JfdFvRuceS8b4vEkKl6nJXUW4PUemHPO1e5udO5f4If2i3UlaCh7bfQuBekpPruGHJQYi4SIlSqnZJxrYt7STYxu1RkExb+EMoBsftCX9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47UzgiR9LJHSQ2lWh1JHiER7zZvqMOyY7jkhGzaLlRg=;
 b=azK8EhgkvLaDv8e96+hNyjQWVPmy/gzzGbRJCrNbulKx3oYkPVCyoGA024KDtcMnDCa2e3vhRc4nn8KbCGtm8b5s4EhjWrKn05uSPrT4T9GbnvM5VBe9iAHbuziqTTwH854HG55C1EdKjH9hRgEBfPsr8dUzh6orRQmQKoff9XnT/rJHyfCDJ8xGb7ENK49B5XGTNkXxqfxyeZo0/kOh9PSWHRyThvejkBXwpD8Xixd6CTjgJwp6aRTkr9pEUwgWGoc0nUVbDAqH28bQ4ce/iF/iNQLyvdMzznqNSJNhQF70q4Ot5Nbk+fAJ2CI8Ydpi8MWMDSmyoJZXWAc/Me74xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47UzgiR9LJHSQ2lWh1JHiER7zZvqMOyY7jkhGzaLlRg=;
 b=Zf8zxGEL9rV7m6rTRmBzRjvX/Dbo0NuMFtHrZmAfjJtmXkhXJGgN7/R16D98L0STELOaV3cdlriPOWcDtkiT4Dk27iUtIY5xJOaNGT6varJcwrnTAGcmuwwWPTxlYe/+bV6Oz9x404VkQ3Q+xrhcbrgQDzboDzWFwCckjvorLeiHxyOeFZCIaY8xYxRHVeHNxCPE8nEjY0KlkiOL1fPZbvK65dDujHQXVVo+tTdNORP7L/gex4ZA829lfzMd/zb8A1kOVbTUaxGvWREdtVL8layIlrGMlszfqQNvyYXpYwWg2WJ6Y0l7cxtEyMdVc9P40hX/WkL3yY3pWkGH6T6nGw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 07:47:44 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 07:47:44 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] gpiolib: cdev: don't record a line direction the driver refused
Date: Fri, 16 Oct 2026 10:46:55 +0300
Message-ID: <20261016074704.1860749-8-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014045624.GB13991@rigel>
References: <20261012-gpiolib-cdev-direction-v1-1-aambrozewicz@nvidia.com> <20261014045624.GB13991@rigel>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::17) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: a836c90f-18d6-45ee-786b-08df2b59c37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	z0Ff/psJdwavZMfdH9B3LlcR6evAlCYGcM9vYWv2olEBeR9tTuHOPY4HfG1PJICGasIn0+Juvlq7rsYzilECvnbJPDQ28X4bJb0rg34KAm0WCh/lG43e/bwTVqDIO+PksYyOYLkmci5H0+lSA8g2R5WDU3pCel6uwqcziV9xGSpd1arzFzYi9QcnGWN/W43TCmEeDbJOc4XngTzrrl6X0KFVJjmmMl0TnT+h5RDZ3clN3CRvoSpJbMI4pMOFRBNr/9oGUaJqQYzg194KyZQHaPWb6wqjIuMutgrZbuSXjH5mCcwJigQGILGj4MoDIBFL9ktuXDK0AwrHJPG9fR1LNuUj/972h5fIGUX3NkClpsI2THWiYx/aFEvXhgdxZdCv2sdnCKcVKMUVBZCeY4p/0v/TjUio5DBXD8khPufQnTlRoMrq+wNuhvTW3B5lbHij8EgnmgpY1j/dwVSI+VX6XkSqSo2djV9vv8VIw4ZW3k6od25bXrr4whjYI5aDwGXH/HPJRHxX+ixSjteiHZIgaet6xH7fPog7N4ego44mBkluHhWhXY1zAfr4ic9K9L+HvAeuK8sa+3Rr+CVU4Z0sqj4wUNb/bw4tI0nHCpspyq1gz7sge2rjLgYrsDHq/oqnxsPjGy/vl7rkUUnUQeCnnp3cyHmiEgaVsdM2Z0WMLdI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OKz232RFZMgj2ajct1hD95gUARI1CsX9KyH7RUSN7tbq5ea8wFC2zaypyF13?=
 =?us-ascii?Q?lTe7GiaZFAD6EoZek7I5djJ+G38dltG7JaMtusO2Wv2hgstwAG+bFP+KqnT3?=
 =?us-ascii?Q?Ik2CJCFKqNULvEdH+Tqne4luFC2PY4IZPE6PR8X3vvxmMduMco2w7MrHlKGr?=
 =?us-ascii?Q?XXmBKdn1hmqLyqpKk95GfFIiPXfth76dT2ljvB1R66Z9hh6ubW2M+wbf++QM?=
 =?us-ascii?Q?V0+CVZqRpDBvXuPs8V/y8NLgbtcUBZIdc/dNHKqRi2q/SSu6qnjvM7Sg86TG?=
 =?us-ascii?Q?yWJw7ZFyy/3791Dy23xJTQEGoRKRF8CX+/BdjmS+92Ew5mm9HRpvNdoV6BTJ?=
 =?us-ascii?Q?uin1dpMpkYemsfZ499dvopojHESW0lSt2tYQIvu/sc8UBLBV86iHFnx67TxN?=
 =?us-ascii?Q?wpC5lMIYGNYTYFeWZO4B5NjX0O5W2EbIcczLzgV0PjEed8VNk6YdWTKtzI/f?=
 =?us-ascii?Q?RraJco++hQLo80zQ8ZjyavrsQB7DMUVuOctOuDcM/3VTqti25/vjVZfou+zc?=
 =?us-ascii?Q?orPe6DUyvWvEVyeXeUFSWQvOkNIyQv/uT1MQ8gjqbF439Tg42ZnDgNpoi69V?=
 =?us-ascii?Q?EzhXKM99/IJMpt2ts6KdRFYy6piloIzR5SXucv/wNlIDgko9Eyu+YERlhUv2?=
 =?us-ascii?Q?6sP8hCNGi7BMX5rbb9tgDDcnE7m3BnzPOgVrqXbJ2eacyGRuPiOs0uveI/Tr?=
 =?us-ascii?Q?AGO3TdVnNCnHAvR44nwtemTZLf67/xXJjzZ3pLNRrEXcAtITVa0CUD6PlKto?=
 =?us-ascii?Q?H9JCC971QexQjMcZPdJeSuqXvNaR+PXeKEgFxAlyXo85O7hewe9bFQ/3v+yw?=
 =?us-ascii?Q?hWkqA4iRhtARqVfyLNhvCfLRV+GdXGB/KpLAfTWC9VNO6SKb7knlbCGeaeMR?=
 =?us-ascii?Q?qDrRpXd6DQ7yurWySGmuc1tAxMZ8ODNu7Zu5rVMBps87ybpp084FNSlvFMFZ?=
 =?us-ascii?Q?e6eX9QxM3JiTzF0ZXUhK0gl5qaAGPZ7XvCqKDr2gULk/853cUoOBoJbbdtlZ?=
 =?us-ascii?Q?rgtsIjDywx4f3C0+dZvc14sZVdMZneubx3Es3MhJOkqrQwfcfCnKbb2u/GJH?=
 =?us-ascii?Q?xeE+NAmTm2TfK+7r3uK3OZNx5vCeaaYm23ESM6kowibDWrVTabJ3Sg0DvMYs?=
 =?us-ascii?Q?vBZxnGAC9FAnrJaWJWO/zW/uBt8vM91OXgPTy3S1bFcxCjVbnEgoV7z6QwV9?=
 =?us-ascii?Q?+Hu+7+NkvWGdqNDrTCshDZCZMpHE3vOQ/2Wv1uOeBN0mmblTQlSWk7ZV/OL7?=
 =?us-ascii?Q?p7sD+9f6R3hwl85SK4rbtvRVKzADf/6i0VzaJZ64XaQf538/jEdzcGNXK9KS?=
 =?us-ascii?Q?fRDuVFkf5gPdm02uer8AziFPTuvfexXC2EQ+HPmwkQMWAm524Yujz4kIjNoW?=
 =?us-ascii?Q?QG7dOU7Ap8AosTopI3IJG0NWIhHbfIUtvaacw5LZE/SxcJUexYNMuNZU/REN?=
 =?us-ascii?Q?R91z8fkb+SAS3FOD/tS20cK49hbuVcFUeXHGvqSosxINBEcyb7SYYBqaiG4F?=
 =?us-ascii?Q?cKRLeD/DBtdqXnbPpoFnui3YeFQPvWMj0K9hJ2eqnueoWcJtDN6fcoaF0EGI?=
 =?us-ascii?Q?zP6toG1bnnvoBFb96wdjWX8FgQFXbnQH9pCeV4woX3gyuVjNVvGWfN9393o/?=
 =?us-ascii?Q?Ka2bx/ASZ1FIG324J1X6GsS+679g0TX2G1tEOI4A+2DYw3QzHICekSzI/NeA?=
 =?us-ascii?Q?/OGrLIb9bcRxVsTLnXE+7quG7MyAd7EyejE3WlzS8itv0F/bYQTRcdNhVrTG?=
 =?us-ascii?Q?sY4I62ktAA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a836c90f-18d6-45ee-786b-08df2b59c37d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:47:44.2795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4P60AMdQepuFDHiwaEgMuKgDz7AKBzfb64blaE/1F1KZI/Wjzv4DmDPHxqQ4ExUAvn8r0e8PXpkr9pO7gF1h6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320

On Wed, Oct 14, 2026 at 12:56:24PM +0800, Kent Gibson wrote:
> I would change the subject to "don't set GPIOD_FLAG_IS_OUT" as cdev
> doesn't interact directly with the driver - gpiolib does, and the change
> here is unconditional.

Agreed, v2 will be "gpiolib: cdev: don't set GPIOD_FLAG_IS_OUT".

> Not a fan of comments describing why code that should not be here is not
> here.

Fair, I'll drop it.

> Having gpiolib manage GPIOD_FLAG_IS_OUT to keep it consistent with the
> driver state makes sense, so no problem with the code change itself.

Thanks for the review. v2 follows with those two changes.

Adrian
