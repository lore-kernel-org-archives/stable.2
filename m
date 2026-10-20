Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792501180;
	b=OuX+6x76wHmuaVHOY6G/qjO/TpmPUH2EnGo1mWWhBCTPOUyP8HCLBvMqM/vMvx1PmN1c
	 mdTr1vHjSFbgNkwANyvIJ/UyjZc5m+rhyAT+1eVVLN1wXg0/uHVCvdDFky1PFtbAXpcVW
	 Qns/QHQ2EufxtJjLYZjYwQKUNOYvnuiQ6C2OVjJ2OV8Bfp9Vw9KP0spPkdpNpLh4Zo62s
	 E3fGmRhHUi+nL0fgOwKPB+1sWf0W5fLKm8Ds5uRDtUcdaU7lSsecoJiJQgOo5p3NgnZ1l
	 7jRKbzUdzlAJncvWKvWlyIhc3gYrZEAIvcCXMDoUDzjs9hmWf1ucDXk9nPSlNSIVQMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501180;
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
	bh=+Kf0AwBLN0V1ISpaFUs9DIomzJA5YU/fflEt03TAFB4=;
	b=rQNJNJ7slsw73ay8lKARkw30QsGUQhlTnEOHN0JlInD5ANBb5rnzb/HEfi3qdYAMrx2O
	 j1LUt7j7rxOQ0ksRLnQ//hBlp0VDm+hZx9fsp/Z75riDkPFpP4rk91+Be6tjBnvDoAzFQ
	 pR7omGlj8T6eq3mppJEczjp3qJb1RYLZ9d8w/EQGCW7DQjPHJPWcI0RUkPwjZom0FhB75
	 Es3b38quCoJg2FKeXPFSoigNyfxVFEuF2B8fs3SzqykQR2VzK1P/09s5R+qf7FgZkwDOM
	 o0dOcoK6Ok/1zibWs2zA55QLdJaoXgSOCudB5te/JNUs56oCe/ai2GlrP7wJqdCREOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Uv0a9fZ9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.7
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D98606A319;
	Tue, 20 Oct 2026 12:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03D98606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Uv0a9fZ9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfEMcALBu1AQdr913/bFI9mWV3tt37s36STDLTyB2+018TPSNEEB4cFPChWvDdULfTn0YADAnjHR3Z727HGfZAnBnNQ22d/zDyzjGPRuxR9+w/fE+EUT0iqyvGDd+4p6QEDzB5UsDcA3kqB+TPtgJQ6FkZPB6GF4Q7sXg0oym+a22ipKoxJx2S8at4fxKQeWjg/7SWUY1KEMEOVcvEUtKM954QapWTBbNTcjiLhzykFvLkjgo+LImYvH66sI3FXqSoE+9JBrzVFiQoT8Td9jWfbADlKUFSEqXMzLCN/58psM4oCarE3/kuUkL14++9anHzzvgULIUrabGR9AnLSyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Kf0AwBLN0V1ISpaFUs9DIomzJA5YU/fflEt03TAFB4=;
 b=urmHSBRZfx2ODjkvbLk8ocxP/UwJH5h7aSLdH9ZyDUgdDOFVpkQPJbI4TZBqxLVae8DPSGvjgpFDjSy2TXF26S1/VqSgQk5v0LAtpJiIpLU/MMBUDu+jpbbpljuLog4mXjA0nrmpArfhTF7UTPpSaG+2W9w/tWBqIfHX5DAGT1tkX/7QpiCrMHGxHj8oe+Om+7l9M7uHLgo/HwjmkSuEOQZC1RSLaHV1DOz9HV0YK2tvaCtQN6DUQAlBizWtiy/TNDqrRtZzG8nqXmV5PdkUvMAEP9l0LX3s8i9VLCcWKbGChf1Az9sOuVU76jZ0C6Bdv10+BUpbE4Epj5hGZQRyQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Kf0AwBLN0V1ISpaFUs9DIomzJA5YU/fflEt03TAFB4=;
 b=Uv0a9fZ9WJaRj2mPnffgJYZsP2CbfVV+1Xd41KLTfB4AyAvjVjE+Nf6z0+NP3+PXU+ApkKolNVyS2AlzYka8lrFTiA7konsMHRjIqTGNgm5n8eHiYDTc2wzLVjk4kJ1JWPR+zW3kolU5+HVPYNpGTQw+V4ifA00TcZThfmxK6mplBk2TJPJqd828u/O6y20NB74oZSs/FzX/q4GeqfyhRJcuhKLMuVXy24lwnrD3w3DXo3APKLr01ZavSEGC32bDymswdqZvVaJ4FVqP05i6Fs2z6nywDYpo9YevvizFVGdnmcvUvc8zNOVxRslILh/qvfTnseySg6S8PxZX+FIZlg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 12:59:35 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 12:59:35 +0000
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
Subject: Re: [PATCH v2 5/6] gpiolib: cdev: don't leak the IRQ name when the chip is removed
Date: Tue, 20 Oct 2026 15:59:24 +0300
Message-ID: <20261020125921.2896041-7-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <atIpg2E8PeJ0oGNS@ashevche-desk.local>
References: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com> <20261016-gpiolib-chip-removal-v2-5-aambrozewicz@nvidia.com> <atIpg2E8PeJ0oGNS@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 51921ec8-ba12-44f5-f68b-08df2ea9fdac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	r4WcxVhnxBXg3e3E1oR6gML6jBDCgCi7iW5XFbPPRrp6FbqTWgDEAwOG1tWAiAeFNBx2CLEQagv/O4est4Ds/5lxO7/TBvBB+VxqAGE1TJ70+86lo/nMb8i/q+Aj7aH0zYnTJCP24T5N5BDBN9r90KempaDQ1ZnxgLtpeoQZEPMChneDHMVLk2HoIX49aUvx3jWCL4FnWBhzfYIanHE4X8PSEj6o9rDYgVcORJLecX/uWGj7KDxF0Lp7gJ6rexkk2wYJjwnbYd7M7h/m0Baoo8TzSMj8eH3C2OQ6Q+s+w3YeUo4iSNpzkvB9doq407ME5+AR2OJhlTW1WAWKyOMlyXQwXV2LhNmn/5xaWFq3cdVVyIyFe4UKEsE73BnQuySellItJAQHRb4lBcYEVrKrYEeaT6beVEFBfqjp7Im/13AL4z1XjOo7gTYdsKKt0gKpyeVpXNBv9sNToNudjl4sTQA5CxvdIsn8zhVV6eN05gYo/igfrc9iMNNw8376mXz8rA/hM8RbVYDLSFYNb4w/lND2OqJ2+2UND2ITTMMARTmTiSYCk72xGooX8hIeL7mqSmtSadV/z6mSKAyH2sPj2n+CWE56LkB2v830FrtJfwnhHZbDCzeEnRXFiXz7jqTQEWzubnQPptdOHSXfX2DWPPNx1WW0Ih+Z9byRZTg6m0Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wN7qk2EdQ8AAqaBOGFhlM0RAnwybfFQb771xGuMxddtglqbvMWmqUBcGP9u6?=
 =?us-ascii?Q?kYeGLHNtxK00se0ixc595MtwjW8vnzoP4gOhArhazzNKHN/WWONCvgtUW+gj?=
 =?us-ascii?Q?h3C4GDtSJCqMRFTwdsAongJNR1Bap5e5y0h+sZfosPso4otcgUdnInsyd812?=
 =?us-ascii?Q?f6wpgoUthI5GwZr3CFODJPLqFDDptBhC31zazqseTUeGQsuP5kjOLMvE0Frn?=
 =?us-ascii?Q?DR/RwsmotuatV9a9HIRS49xNSxShyU0Kya9kSJ8QGV9/viaWvzU1rCMLX5rL?=
 =?us-ascii?Q?ISRM7D5qQ+mePTMxAjLr9Jzs7Y6r6lMKVHSvcQb6AUo2tSFDWIXHWTLgynow?=
 =?us-ascii?Q?7zQiouTqw7ugaMGe7Qb9HQo1311PCd2pOyzJA7cGYWnuCxqk7OATuviKPZBM?=
 =?us-ascii?Q?I26VCCuhdpccnpMva0CCBX2pT3X3ncCIh96Gg6Lj9KnETuhXXhRrulWs3j8q?=
 =?us-ascii?Q?a7y2G1OVxjNQ6FMDK8MDp8oTu2qnWDLUqETGX3lQnThUKczswCEIqm6ohP+A?=
 =?us-ascii?Q?LIBB5j/gHRlCx9T84mgpt7B9kA/lG652z9ihLBaEj/UQx8LkYK5bOuwo79Yf?=
 =?us-ascii?Q?YqxOC3mIJjDiMmlHdtgANREWf4D3HBpqEXIFswCzRsnmZ90PHOv+ysBx8FkO?=
 =?us-ascii?Q?n+nbsveWvjNCx84sj5tMPNKzXuphCK0PWuDJ7ktniV/RwbyEPpz0vZLlUijL?=
 =?us-ascii?Q?v4J6rlTlfQNdaFSgdnfS1nBeC49WlynzPdCoNVxKaF+rrhk2UuafI8D79To8?=
 =?us-ascii?Q?Hq5zs/8tYAPbZ+79Wjf1v48o8Ko+vS7kV/551Klf1x6FUAV0Y1rI9OSq1z2I?=
 =?us-ascii?Q?nNT7G9GQv6uapLc/IlY1roSrjkImLkucGnSop+sxepRGYGVJnHwajbxCJreq?=
 =?us-ascii?Q?8TS16ASxerAEXBMtlqepbogx84+TaC2MhQE6YiFaow9MMSOymlMWaYugrqyK?=
 =?us-ascii?Q?POLPZ31YvkMXduIIA0z6XvwVhZED9/AdXICLdMFDhRNQKQlGP969qxOa+dg3?=
 =?us-ascii?Q?6AefKiopyibYPcJxW2yyhDIkFHoQJVbAY3JyjpQv0oYxBMqcKdEzlViozs+i?=
 =?us-ascii?Q?nuit/3jzTkAxG11pMNioCkGO6j7wefBrb4IHK5b0SxmJFEbZZIT8OPJIzh7j?=
 =?us-ascii?Q?xbYw3o9JVkDbhdLsWMSxWqALSZ77ow4g8HMO3eGVAq5YMU6au0LGtjKnm2ff?=
 =?us-ascii?Q?6e7Fdkmeif6Zn+237BChYkM01gfCcG3q8325nI5aomuSb67Tye3XudkN/Zwr?=
 =?us-ascii?Q?x6808/HSsRfLtgT0k6eF/072dfAnWVtcZfbXbiK/BLhNvSf4YY35TsIDPDdK?=
 =?us-ascii?Q?GtlhBRryvG/4BHKKl/EZFGAiiFL9QV2z3y+wK6QaEI+33obhWg6KHD3/Bw+I?=
 =?us-ascii?Q?LjomwLGWo7FXOsn18D7g3H5sMAKrm581sZQddv7wtnakHjEHM6PC34CUNo/v?=
 =?us-ascii?Q?ukcmp4udBaB7DsoudO3hpKWakwNHPPXrdM1+9s0F7MmCR9PUPHPAHjainhlV?=
 =?us-ascii?Q?6E4j3V5NS+ualbRJj13wjDx6If8kkhx4ObA03+okJ+WIQJ+SL0L5ZIstdBvE?=
 =?us-ascii?Q?U6vgAG8q3eSaJO7B/OdSGtRNDvP3l2LHu3D/gftAP9S8IxqhM8CREiM/tGJa?=
 =?us-ascii?Q?+cKNHYmJUOKEYxe5ARasWCTrkXpi8cLNaEPe+8YGzynS/dQ3fapWrU2mtEf3?=
 =?us-ascii?Q?oQiEFgzywjQLU1oNkqJnz8F6JUmx2HaK/Fz3nihALvnHFIzFScGVs1rsbQva?=
 =?us-ascii?Q?gMjMUmaewA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51921ec8-ba12-44f5-f68b-08df2ea9fdac
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:59:35.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sy04AgYuUTNC8A9esjbIx+nowvA6oyjkbHnkTRo0aRrCID3EmCTeU4OUt8K2NopaShjv8vY+vdXnmJCmM2PKnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414

On Fri, Oct 16, 2026 at 04:41:23PM +0300, Andy Shevchenko wrote:
> > struct line {
> 
> >  	struct linereq *req;
> >  	unsigned int irq;
> > +	char *irq_label;
> 
> Have you checked this with `pahole`? Is it good layout?

Yes, on x86_64 (with gdb's ptype /o, which reads the same debug info
as pahole). struct line already had a 4-byte hole after irq, at offset
20. irq_label goes after that hole, at offset 24, so the struct grows
by the 8 bytes of the pointer and gets no new hole.

> > struct lineevent_state {
> 
> >  	struct gpio_desc *desc;
> >  	u32 eflags;
> >  	int irq;
> > +	char *irq_label;
> 
> Ditto.

irq_label lands at offset 32, right after eflags and irq, so no hole
here either.

Adrian
