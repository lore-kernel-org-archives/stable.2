Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012020.outbound.protection.outlook.com [40.107.200.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AFD440635;
	Fri, 16 Oct 2026 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136866; cv=fail; b=AJ5lLQmmlgTmvkVibtdIcYhCDbnPiIaqKGdIsAiE5Wk2ZnezuyvmzmdEvMbVlz2V247sFdDxGkOZNGACZ+uzDXaQGEFBstmqPNIRELT4++ZV7Hw8wyIsiVpG51Gzzmo0q5EakOuq4n/8Vhj+AyZq4VtZU9gx34s82UQI0AR5eP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136866; c=relaxed/simple;
	bh=12dIDy8xsuHN3xknkBO1pE6OULuDhpqRImrdeLftf3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LsFvytdleadct4U29RE2KUK3HHvL/vbQzABOiz2pLUKmaYqje2QFjWH30JXvywiQtYtl/cTwz7yRLyCmnMCOeNGDQ0ObMF7AN3nMN1LmhzNTsPcX2G6bG3ftlnQpjC5N0wqfKwfk69/NsP1jBZcsvK/p9vBS8iqKij+Vah6VLAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DWlF6Qxi; arc=fail smtp.client-ip=40.107.200.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DWlF6Qxi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TiXhpSpCkmAPv/aa+nM0P6t/72nXbPdB3CFgVUlRKL00fO4whfblfNWG8BEe/0O8HBS4+hDkBCClHGH0MLrnZTclxZi15m0S6/3QOix7rWMRIkVrV7J6rw+ZrHjqswBvIZO2kH66G0u4Ryq5KZjQqbmPYTIfmFb0jtrexxtdRY0tYMwe/pNFRkle7VdD6Akz/54i3yU7FhEpOgktPRV3t26FiwHu2Da+2GIQSPZ4vK+qYbl/EqMpZ6BmQ7JAXjtcTBvql3qfFRlLjs3Wka/jugecO9o3q7ulyio01EdfYxexgXNdymgJwTIfaZPhFfzzCe4x6IEML9BK4wmOA8pB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnS51xfv611FiSeSanxBc+HpVUB02Nbhvl9kC/yvau4=;
 b=EWSemyNZ1dUk44t2PX81yMFVWWNolj/6XBhqVE3FKLgc2w2I3zJLoFZd2bDGCXx3Ch/JjGytsOmmyM1bSaa3rzPIrKpnJasE1uK2WiKTRXYcCIenfCmJw/V/CBpuy49VNDo+QNdOyyXrTO2CsfsIfw4khd1GsXoMzmRsJliyKGhBEuLdHiKIFq/k1Ji9dNJ0MLUZvqIGMLO8ceNBSHaRuS0yvrcHf+ICK8nkUITEdWX07ZFh7/ba/rk5psiCOUuvGeoTMdtB9ho9MMYAuzB3s/tpsjM1BnKYsPhz2rYgq353pxml3Q6Tg72G4ThEMfn/lAlBMVC/nEfc2lNhLTZNIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnS51xfv611FiSeSanxBc+HpVUB02Nbhvl9kC/yvau4=;
 b=DWlF6QxiNyrpbrvFPD5coQijZPxdr4kZm8ejXz8mMznkQpCVjxj7bfi0XVXCfhCFfn3b3mB8eEUOu8v3yzpFs8ROl6B0EI+jEzieBGbdfXMeeygWnyPrF1aeGlZCdz9hczGaIoXSx3ryo2wTcZSRJLIzQLrrCiu2LUBfghJhmST7OQXX8jjReCDI3M9Po2EOrYuKeUSJITZnNCcaPmEq5e65AGV2LvwSLLYAI/jO/fdRbZE4bFqMApX28FEGPLLOL3n7qP+JiVozb07zzWykizCWYhQkGI9MxSNra2/ZIgouAwx59OjAzyIsnv6RMQ9jsY2pdkbU9oUOxAEFIP44lg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 07:47:39 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 07:47:39 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6/6] gpiolib: let the character device free its IRQs first on chip removal
Date: Fri, 16 Oct 2026 10:46:54 +0300
Message-ID: <20261016074704.1860749-7-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <as5WuQ2G62ThE2ds@ashevche-desk.local>
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com> <20261012-gpiolib-chip-removal-v1-6-aambrozewicz@nvidia.com> <as5WuQ2G62ThE2ds@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb86414-f945-418f-7741-08df2b59c0c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|10067099003|22082099003|18002099003|5023799004|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	CajkICV8/frI+c5VYSqM8IMjUq1eDF+4OuqNB7Bnc2BZHRjhMLZvITiqnx6uBGgyU40VSJg8ucR+AFqeowyyQri9/TZpWJsLQ2sh0WIO7E6usLQRXjatCj570dUzBlJb4tnpzmghgmwrMbefy1BLzXg1r+d41T1XqVaI0TgaA1+Wd9sAT3zUy40MeF9fShd4To/uSCNFpZX4KHPg63OSXcRPmm6LH0vjAjBqzIX5oi9yMsXkzVCqEdy2Zois6WZT7XxS8phxwGbZQRe4mknUqHAF0y1XlfTIFQbe5/3CMmj/QzC01SrtzcErTuHPPzHz1zAGR29yhMQqRGtvJvHzo85mrRYC7GL8ndeNyu3FQNuPnD+40hCOMv1KF/W8ivq/tAfteHypTffitG9DZrTch3BgEy7rqRlyCP3VYHlfLngTfDiJtoArXyKlRXZD7jcoIkDPcKpuGRBU81HuVueCmxaLDp2Urh6Qf3dRGwVMiH7hHD5VUxw+Au+yfkIaVqhUUsN3bYIMjuml+1THD93lSQAtmOAXXa+xrde3lJ9eRf0ClNxQPlKhI3U/1L5SsvPYrgxEh2KmzpIbuYek0L9lG3UnxtxicxT87ydZGHYWveQ4Dx+x4IJAHDXMK1jWwh1TOtSb6WwQlSUEsl7lLihidPSO2uzb7Z9Be9ZW/IfqOOQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(5023799004)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e5etqULNR1wCPi9EhYu2lf89/juxDlCZfHTfBtv6qC09Y+x+UpLyBsC2D9BW?=
 =?us-ascii?Q?out3ilKJ/4lbZIQaOAfAjJJTXGcwKM7t3vTHBFci6qshlaz+0XzY8lvXBQFV?=
 =?us-ascii?Q?fkxS3S+Lnbb3TEvCJdQ/OUIw4O6rlbsZ9NhAH8QmClqdsysLVF6oFo12e3qK?=
 =?us-ascii?Q?j+pF4KpUybYySKc1rRGRHmuQt4VfRIm/ZYC5dYVk4vinhrmVEudlepcAoqHs?=
 =?us-ascii?Q?142ihSsM3ZrC0785nPHTqq37NHX70Z5QGhOx7VrD6xQInRVnv5mqsYj3u6TR?=
 =?us-ascii?Q?kGieYeHWI270DdDHz0vPl3lG4FFFiVJHzr2kWXORakm8kwX01WJfbQZ9Bfkc?=
 =?us-ascii?Q?CcmVFdq89gJyl3/2rsYYpZ2xqUPvoZ6B37cTEo1Cr0RjMWgS5PySYIA6bdQL?=
 =?us-ascii?Q?nmUcgdbUov+EcIQKmaFS4arB/iSuqRw989qFxh0u2XLDBtAjZ2HO2A324kkZ?=
 =?us-ascii?Q?E+3mk8phGraog9BUrSoK3F6FU1FIUdR6/ykV+mcuaeoPMOfO59dURKnlDZ3Z?=
 =?us-ascii?Q?dy7O04AJ071Cnk1OBnL/IfcPLccP7MNPMDg+VyAsuwQF+OXLM7Fn2A3te/Wi?=
 =?us-ascii?Q?XSWmPub4F/0h2ByGB8fsvF/2zhuwX+9hbSWhxqsnjNIW2UPPKS1UijsfFf70?=
 =?us-ascii?Q?e7iBqV2jZFDuhQe/C9Y6qgwavKSmGsQxxEHVvecEd37wyV2BnkVbL02qa21i?=
 =?us-ascii?Q?13oRmNnELbQ6tD4jMquYjsWvDxf31R2l2mfv5ueuYGmuZIql+U0eI8zpWXRt?=
 =?us-ascii?Q?nP0AomS8rJrI06YTDMoeBbYmRL0ZSxssldIbahjZYf6opkIfGyI5XBMeRM97?=
 =?us-ascii?Q?gJpmGulruoT5tUrllVV9ZCXfP5iq7cNGBpWi/CdxHwh00FjKscBkcYVaE+Vt?=
 =?us-ascii?Q?ddEcDO5WSsa+abdIGc3KPoH7+rZUSbCEytbpdcJljQPmGDo3KsTLNgJ/j2YD?=
 =?us-ascii?Q?P+HBDg4p9CeJBPtTai2pVV2cdY9ISs7XTUMJR+kMzN0kNUEPwv/5hE48fkl8?=
 =?us-ascii?Q?ZnJuPok85po/5L2oZL0s7tHmH+pqSfmDjlVceNkAVt5VQaXqfIz0+sbuIt/B?=
 =?us-ascii?Q?JuHX7xGTovbtm6x2nfRpoJb45yryFEGEDczqr1Ku6QgtfgGKfU/JHWJ4SjHt?=
 =?us-ascii?Q?vMr7sP74/XWrUsijvWe1d6BYPI99gNPDnNW8MmSdrNiLlZRvBAaFU0cdeLQu?=
 =?us-ascii?Q?DDuEbgNo40TwaMGnb+3bGNW3MeDaUdqRa/3uab6MPZINJ+aKTKT3p73Zf5Qg?=
 =?us-ascii?Q?MdDylHcjoPmxpluRkDcaHJnypSu6ZIWvZUsod1DXO0ijW6ARV9dZNqUQ1yAI?=
 =?us-ascii?Q?gRKI/9SoHw8FZQ0Bs991Rswrl1hdIi+nRUTD/3Po7Cf7f0IjGXcB0Zic8Uhk?=
 =?us-ascii?Q?XYka8Y4y9kL/GvELdiSYl1p4YTHHD5680KJkFsRT50gyXcf51OMKFz4AtoVf?=
 =?us-ascii?Q?CeRCf5MVbC0SXFsEyet6NLZE3ZNKQRA8kFi5Rp5eA4XwJqLadFbYLBTiyhJH?=
 =?us-ascii?Q?g1wwEO1HohPUU02qnkKQQHrCq8bVVqs417liKY8cFbhKT0qQCEzBGbp9Su3q?=
 =?us-ascii?Q?AEbHWt21V3seGPWVJbDYqcnMAhRHaRr8V3sZW+kNUal6GsZuY3QM9hhuI8XE?=
 =?us-ascii?Q?Cx7RFqxotmSfxn/EcrVWGNmFtj7ktuRBT7ZJ62N1Qe0+td3dnkT44BqguDbD?=
 =?us-ascii?Q?gGq1pWpdEdoWPNHQyfqlIkAx7WPo8SF9Q7WOm4ybXwz19UlImQtPTnukm5zl?=
 =?us-ascii?Q?vMDeL9eb/A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb86414-f945-418f-7741-08df2b59c0c1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:47:39.8565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/vORnZoKmjDa/pOBCrf8MnQu2zYhizMFnT794wCAVUwTTdvieUQ6M4DqSY7WxjIBnqcN7nIEYsHEgWCGFSPCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320

On Tue, Oct 13, 2026 at 07:05:13PM +0300, Andy Shevchenko wrote:
> > +	mutex_init(&lr->config_mutex);
>
> You might also want to add the respective mutex_destroy() calls.

Will add both.

> > +	irq = gc->to_irq(gc, gpiod_hwgpio(desc));
> > +	if (irq <= 0)
>
> Are you sure about 0?

Yes. 0 is no IRQ: gpiod_to_irq() turns a 0 from ->to_irq() into
-ENXIO ("Zero means NO_IRQ"), and the code this replaces went through
gpiod_to_irq(), so it never got past a 0 either. With "irq < 0" a 0
would reach irq_to_desc(0), and on some architectures that finds a
descriptor that has nothing to do with this chip.

> This can be combined with the above, right?
>
> 	if (gc->to_irq)
> 		irq = gc->to_irq(gc, gpiod_hwgpio(desc));
> 	else
> 		irq = -ENOENT;
> 	if (irq < 0)
> 		return;

Yes, v2 combines them that way, with 0 for the missing callback and
the check kept at "irq <= 0".

Adrian
