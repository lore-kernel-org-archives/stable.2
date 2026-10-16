Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013031.outbound.protection.outlook.com [40.93.196.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CD73E16A9;
	Fri, 16 Oct 2026 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136853; cv=fail; b=rNC483RLg3XXDkElkrJQ6EVsmdqQ/wcv3UuTY33736BojbSb/ArLscW5zs+92fF0yUIbp6aVThmqBbP0aICFNHWzvFOdIRsvZrjRcVbuoEMkqdb6w5EyhVmOpQU+fvDrh60NZf74Q7PfHPQVg8PPvE6amY419YtDoOoFKtAhN+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136853; c=relaxed/simple;
	bh=BNc+F046LS/CNrgU1xd7l8GWt7/Iq9wMzMHluoZ8Ogw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EUW1qDmUciSdA4ZSD/fbzBMqPfF/VDMGRPlMmNnlhTNJeLpy5KwOTQWCth+X90VoFSow22/0koBSQVHBSxCVbCVW8jXjJn2adG17MG/STX9e1AMwsTlfGS7mkaGWTHhOQFqsIMq+AkWXIDQzMcNsPLDjHzKg+FY5PhTyHmkEnTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t0JJcY47; arc=fail smtp.client-ip=40.93.196.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t0JJcY47"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymZAzdPKOp3Op+G4M1h8jmTN62wxDu0RDrP5m0aE32vQrlb391Z6B6hB2qKeRyqr1fnrF+9OWbu+Pk8BxhBFAnVk1OUHGuw2jFLk3sN+ZcFDiHQ7E0GbXUV2gckrxSWrfWS3uoesJPPLvVl10hON+h0jQt3C99mfKQV3GJfvQ6alMdllaugWUQZFwcLwdE78syMVrqqYN6aoYODCk4cv4Ki7iaYf7a09awZby3RdlS5w4OvxF4Ut/sKOdoP4sddFvW2zHydUafvlJ2vssmDPcUPzQuS+3cdIg7zMzH4z/3am6sKmBFdlSGINtpScZkyjphHlzRvwyQHeVTTaX9Irhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDXokGnlEo9CW7WSVSwm9olbkVA2zGzj29e6c2qOCgw=;
 b=cJrdgDxXw9nVj/GHPcNnufWF07u9LH2Uv88FEnC/cGUJ+c5xR1R3AJzhZehOON1kcRYssuSliJCwOWbj9rNYO6SZAtyjV8/BP3lFSXGI2wqCKRtLo7awrMq8G74G9fBxunLpc7/5qU6OAlkibaQvljLgChvdjY63FpCe4QeZykMPZJ/qSEm92Of7pBYE5Wnplmr6GYLXiR615AbJGlhok1rkVp3/wna7Roy4fapFl1VG52JEbo/HsO3gNt+kZfTex9K4/Mr1yQ9Dl39XbYevqX4cEGfsUdC77X7V6b+KdXFyX9dYNMUkUMWOXKOjYVEiGceaURIortkiGBUy/tPHig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDXokGnlEo9CW7WSVSwm9olbkVA2zGzj29e6c2qOCgw=;
 b=t0JJcY47QLdQFQ1BZOR108OZTtreEdjybQwtXSGto/Caxtwogs9RoxN3VvZdXB+zzoZVelzUtORQ4qKLYQWQuA6O+ug6uYcILCDn6iTolWTGJ9oxXDbd+W7vwFrxDqc+E6fPoxd1UnRxjThBM2o7DwL3p3LcpMdjbJsy9XKLUIO93/zFhSYHkZXZtSOZ2HzOZNYb3GafkT86QeFfN/eV6FrQAzhK0MVz8IhShBI5vqlCnPduFcOQMdyIPXNUGEkJ+KINGobPzaEGirS8VAxMQxp4uCeNxtCuRIT+RHwPM+Vw1ATyrrmWfBFbTi96TqXcCvUw2zCpatG9SbUftYFS8A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 07:47:29 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 07:47:29 +0000
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
Subject: Re: [PATCH 3/6] gpiolib: cdev: do not free line IRQs again after the chip is removed
Date: Fri, 16 Oct 2026 10:46:51 +0300
Message-ID: <20261016074704.1860749-4-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <as5R4WDqXfMXkD2L@ashevche-desk.local>
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com> <20261012-gpiolib-chip-removal-v1-3-aambrozewicz@nvidia.com> <as5R4WDqXfMXkD2L@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc9ffd0-7306-4094-7ee2-08df2b59ba7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|10067099003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	mZJc6TWCa2B3wGp1HusWmUqK3CPjwuQ7OMEuMiGavgxGW85fGhLmgakVzxv1ulSPWaAxZ22mP8TBZfO8501+w+AOKRO2dcx4sH9C40yTQnyJD5Zva3V+n1AWTsIz08rDlRDMD0+Ss3+1ETiw+8fcDkQmwTflLed7/BtYHp/Ij5/08S4azQ87bRCBzetS59LabO3dcIjCvych79D0gxbwStN4J6OqdCUhRBYqSMUI9MnoAe6qKphjCbdUpMM4ccI2bCWBtIL372Z8afB94I3cmXrOeifHx0MSY1l9qTOcBbU6Wm3uWUJOT27lb+RiQql2OY9WsjlsN//JpLPgG7LdoJN7yQjwGm+AlM3W7vz1PxgxL2cM6PNwiN2Rh9NEd7djMjbnERUmYER54L6gHyNUd+HoYlox+hh/KAjB7oWxW8g3P0R1x3Ccha13C45UdCx7PATTCj+J6uUkTGSWxH0LwXhvclVCBTqU1Vg94jCHVkFNE4dt5RpREtcB3DSGxe5DAPVsAHEMY/Bkw+m8UFSzAsFbq45Qib/PsWmXgbqh/ToYXxP/GKO7tAofQWkNvLo5ZsEdE1O1XjIE4TzniRUjFyWfsKUlmkgPgofnAh9UXQd4bgYG6T+NJ0sZyh6RD+9i/4734+wEMaW+EBQoTJ+IiMhLQLIhsGAe3F9+XnBjN4E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xz8rAXZjszwdbZwlVFuTRECj03Vdru5B+ATNuM9YO4UD3DxCYUjW4KJzvyCH?=
 =?us-ascii?Q?Jn1OIHdEw0a5bC56ZDzv42SidS5C34I+nkQbnupZuK0wg9KaOi2zP3nkKpgj?=
 =?us-ascii?Q?Jf0ztCQD6b1g9d3ScMqH471OAF7tUp1GIxVGijQS4zMM09CP4HGqml0jTazH?=
 =?us-ascii?Q?fJrejqJkFizs+xbw4XMk1VMy3MKSkbpPAB1w9TeH2hJ1tlrLmQV4GeRDok9H?=
 =?us-ascii?Q?IYtokH8d45b0H8+WM2utRYY5waBtjgen0azjZMWNIwj+hPyKrbXAAXU0T3x7?=
 =?us-ascii?Q?NS2QlGH6xHczeoJ1oCZT8yZ7rHKEwZfA1R7+/LnyFx7a11y1hD8KX1hPNFTz?=
 =?us-ascii?Q?QbYTLeXotwtlauPdT0g1WRlabaqldmUQa7t/PV+ALIoVmaxTRObgXybSVLay?=
 =?us-ascii?Q?32rMlMFTy2yeGLtf5290hJS84gw1YihvDGdLpYvrP2rjQXHDb+PeV6fZ8Z8T?=
 =?us-ascii?Q?hXUEINfk2juSxgmxbft/f955FAOPg3KfdJIsyjogRNPep+4732MSJXa4qrcq?=
 =?us-ascii?Q?c6OAYRKo9Fs3232JDKap379dzM6KTSRFq4HKLjdw6vywBH4TeslLXTOL8AVR?=
 =?us-ascii?Q?ZdpzG8AmRXDJCVCd1hrgLZ7e1ZoagMoTB/l4iPSX3dB3yDivMEOEYHjHD0gG?=
 =?us-ascii?Q?M5NnrR2yTcXgfUZR+tzLrePGtLIc6ln0e148kz3wEiXVtMYI2hPCGMUp3E51?=
 =?us-ascii?Q?zJLc+IINvNBXDqaE/peFX/M+KYTiabfhFm2LrkTM63jHsWAJMlZd8xGYICn2?=
 =?us-ascii?Q?/iPK/Mfo32gPanpsD4GQ6UrH/3mo6QaXHYP9iLa9Z7QbMhAw979Pbe3CH62/?=
 =?us-ascii?Q?xwmwGmr9lHMoKnjcmMA3D6QPyFMTu4YqUP/18R4HI530PxqmwCLuUv1nAF6i?=
 =?us-ascii?Q?2y2/DR/Lx1sQiwupRkoAuFTVOIUluKUmRxv06GGhO8mIzw46B36v8/elmHyj?=
 =?us-ascii?Q?IHL+lvBLPCtxbqTtyiS5Tbm2f6xxLZXcaVuYaMDDVWm4t2i/4WM23N1nJigv?=
 =?us-ascii?Q?OQgcKUp1eguU8qYgBddS2PRB0fw5VNZ1pxGCuNcb7rPCOt5Mse4FGGsFWuAE?=
 =?us-ascii?Q?Qb/M7ZFaZpVCsLojQ1d79vHslgt+l7CIcTWIk3SvmhEGmP/6+Eefe7JtIJ+x?=
 =?us-ascii?Q?NwD7SrNvdt9l0NijJqtrH4LnBXE7dcMwyV47HAFih5m4or9aEJ9UwPlpCC9g?=
 =?us-ascii?Q?xhQrNN0fuooWb2peQ0c608hFH57DFHL2PIueSO8oId4YlkM7WB2mo8vuFNZb?=
 =?us-ascii?Q?BIxPVaGphqI1fswSR+sHtjYUDnjfjCBC43IEOs5GKbCsPEhGXS8Nv0PSBKGt?=
 =?us-ascii?Q?hN8/mSCZCcTXplktIl9bbc50BU2U8HBgvOzoT6gp3MsN0qXJnHIkzZIMrFO7?=
 =?us-ascii?Q?VJchxmvS27LGGxyImD3TOCY36JlQmbgN7pA3r0rKQTg1/NJdUVEIuJBKW1C1?=
 =?us-ascii?Q?hojIeDPy1E2FPJx5a0t1klJRH+ovKoQKCdeilqgTl8u3Q+RYBJC2Yu4UbioX?=
 =?us-ascii?Q?JKXJ0SzLvdrMOZBneNV5j+eu8n0wkhFXqr9D9akyJPV89f+h3u0jDDR0FoSk?=
 =?us-ascii?Q?PDo90TCEO/MfQAiQKHOR/ayn0jiH693d4i+Y1MObCAzHrRdW9ScqMd8c0iMJ?=
 =?us-ascii?Q?IMBCZdOKknMjLjqsYP14LONj/1EAmli3fW+ZsAbEBy5Bb89n34xABJot/InY?=
 =?us-ascii?Q?NFOFORb0MX11uBFlcth2rJyw5Bx2lepRvDOt1Qlvwg6xq1OEcV4vlqySyeoe?=
 =?us-ascii?Q?4X8D4WTwCQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc9ffd0-7306-4094-7ee2-08df2b59ba7a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:47:29.1548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlDEtSM1Mg+1JY/ArZpvpiA4rl3m8eTs9ZhxDKS1WRwkdhXv7CZ2+peLboOisXoTlNYWH8Xp/6cMf839LDfFoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320

On Tue, Oct 13, 2026 at 06:44:33PM +0300, Andy Shevchenko wrote:
> In all cases it also checks for irq to be valid, so embed it here and drop
> those checks below.
>
> 	if (irq && irq_has_action(irq))

Agreed, and with the name handled the way you suggest on patch 5.

> Slightly better to have it
>
> 	struct linereq *lr = container_of(nb, struct linereq, device_unregistered_nb);

> 		for (unsigned int i = 0; i < lr->num_lines; i++)

Both will be in v2.

Adrian
