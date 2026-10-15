Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E766E3815F8;
	Thu, 15 Oct 2026 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080031; cv=fail; b=tVWyxXfAWVBvDJunCkVTq+vFL+k1EU2BIT/5AppAn1tWWx323fbw/MAbm3EeVjHNmsCjwbF6AM7TaNc5h7vP2EWd2ro8SR7UJy1HfQsVu460qITQwbmbClrKXs3UPm+fldc/c06YXy8IuTfiO6JIsHdF2iNxm9dKsEzyh3TI1Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080031; c=relaxed/simple;
	bh=CUuZDIxTYRUlchHwkoXF/rf5djckI6O9RLX6wUtA740=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ks14DZ5dckbiWPpiw9lib+gvIKxu5Bgg1KK2rVOy2NrzLBBCpOzUCQMrpmAUWy6A+8RX7X6X/PptUFmP38m3apbeAaHH6xeDughc1c8cTQNqXLPvxvvkHTrocZbKXEENA394j7YxGtWI2ii2PSrZA6fKR5E3crdEV9+CsxpUdWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KKAmpubM; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KKAmpubM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJG7KYTqutUxm7uas7WISaGvJTDB+BWDzzBUj+5bJEvwracdp/vxUndRlwVQQUQRUycGP3Q4lvr/1CXvyytmZbg4+QNacLBpY6u2j6vBr2sZkMSAg9/m5ZVqk+faJLconBd7Oh2oXIH1V/9VlrI0BanZNFYwVhY4A7HoXRoPkUg4QW+5/ydc3ygaY6nzANt4aVeQJSvP9bcfDZ4sxrlMrQKTudHy0sVSuOEH/g2Bnju0st+F/bKg3WTUI7jI5c3REGksHEnTBqHctKnyWcUIOmMqdgDGR35kYxBw65Dq2UFcC7cldN8q4fjZ6PxENxbuGorKRgIF/t75/F7S6pOqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXbdLa99DISoe3NXdtPRdZXRJKviVWyhpHR257HzLGE=;
 b=BxKde8XQgztpsFqzobF8L3OmWg1tMyh3KunPIALbE/Wg4LUAmpQM/zqgq/hIHOOAGSKTZmEarzD1EskVkOU6dtdM4F+hhKICxf2YlKJlTEeFosYapeYzLnGaYJT2bCrYT1lortSsDR7lKEQP6ZF2X1w0OiTTXXqAtoQPJpQSQt3nqHkagHFA8IxZmOlYBJRiFeyn0quTdIG/cZ8H+cAadRRuumx2r1j0rS+h8CQpiJAGrjYgXy9wlnM0872DV8uZqsMpp7GkUxJzDbeEtHXd675D27/768XshCu+KKp9jXHxK9ozXXHxOCJh3WH8qhqMA4uN/rMhe35uNur5rndJNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXbdLa99DISoe3NXdtPRdZXRJKviVWyhpHR257HzLGE=;
 b=KKAmpubMfeG3TM2anyU5CzydyR/qViIAwpufOcA7rXymK3tqr+Oteeihol7chxuxsWxbc6Pa3Ot9MMuP5A75ise/TpRYC32GrGSOSVYAmBdzLGb/W3COltLT7evQSWnM6tSaGklY7oK9W0pzDx7PpOwUW148Cxtc31VeEHOIRKAkmObS81OMmRsxe5bOeIX0AZul1LHCVyWUsQ25WmxezZewY7/jzpuVtC3F6p5woL5C6jXC7CQb/MbWsdKeLrIrFNeanJ2fudTjeC2WElsgjudsrBBCe01xKiw2UkkgF9Pf9AF3IgvZLYz53yhWkUfdAl/l199jnxkRVeXz4hF/bg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH0PR12MB8799.namprd12.prod.outlook.com (2603:10b6:510:28e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 16:00:16 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 16:00:16 +0000
Date: Thu, 15 Oct 2026 19:00:07 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Til Kaiser <mail@tk154.de>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vadim Pasternak <vadimp@mellanox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] mlxsw: Initialize register query payloads
Message-ID: <20261015160007.GB1836432@shredder>
References: <20261014173117.26305-1-mail@tk154.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014173117.26305-1-mail@tk154.de>
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH0PR12MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 86789ad2-0d62-4b15-158d-08df2ad567b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|6133799003|10067099003|18002099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	0Jtzb4vAM4jLUoAAc2riYShm/lFV+MkSV+UaB3tHnvzGQtyvugNlzOL8mAGwEfm1s/wTdMXXjBWC0RLy3qh2KAdp1fasqNFukndyVIdAewH7qshcPbyjWjMM5ez4FqD45RllmSBEdZuBWwNvSNtAsRo04nuaILXHc6CKFK3iwbMsZ/Se74ETk6OirxXjF1rb4VtcTskRwRue3yhPkdH9M1yLopI7ocFzsU3joE0M48qHz0FGYTuevH13gAZrHVDXkEIp99rRIjafeQ6vMXyuoU48OlZPmbl7xMM7+4mHzzFRnEcfIgLRmUgtAnzdf53JIu0bFfSgptSMGKpVo4FC0nh2F+jENUslulfRZZmOG9iyBh2/YKwgtF8w07iDDCkHAJQ//9OFsnSX8LlidWJNvk02nH4r6kwLJ5r7Ry0VND4zTE1rLllfMjP23i0HjdKi5LjXZni4Bq51R8u5e0FNZ35gS/bSFR1dopzI/aJZ8umpLEVKbCYOG6X6xKeeY+cuEGQIlLA5WasB+aeLy7iXC135Fer+7UDsksiNWlZ0KsjTwC3hf7gCvtnMSS4B6EkVCc8VKS3wZ7pVA3RqreWEoYr1aGHvy71skEPqml1cBaxUDSmoeGHsja6FPk5SEjS91UVjlcLGO28dKGGcGXqGom8wj5AsXYsbgFQ/9+04Vvs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JCp9xfMgRhpO0obhuaNCloEmPTnys6yfpprGYXV0CqwxDPDC844dE/nUCygl?=
 =?us-ascii?Q?MwjPmoV8t6JTSk2IyzkHpvVf9tD6LPaiEzhKkJevyNCZu4H0uzqUXXYZK5QS?=
 =?us-ascii?Q?Rw2V9R5MJ+1kdIhjVS5UDXXMnb7dJJhABLQdbfObRbp4h0tsAEClUJFLWLWG?=
 =?us-ascii?Q?x/V/IJIeqRve+DBTQAzhS8uFuoG+lYaNHlu7sbdXbHFSpFhdYLeSCqwwGbMP?=
 =?us-ascii?Q?wBjKGd+osdXdsUJtE9x87E1yTdlB2El5NwGdxih0qbdHsoOjT/4IGc4Gf/Qg?=
 =?us-ascii?Q?yQT8duFX/LmWx5sytEcrW1K0D+de4oirFCWIn9I84dq2wjwcShoF9BAVnTNt?=
 =?us-ascii?Q?vO4m5BEiIF41L8Vkikzb/Vfa9u75/6ovJendbVzJS2hQaLSdui39Xt8EZvXF?=
 =?us-ascii?Q?y33OUblP8zNG6jZTdMbFa6uaQHHALULn1RSa4GtsrbqSSh6XN7GcSBMJJnwA?=
 =?us-ascii?Q?07QfIVcST5cCCiiXbVHiBctw6b3Ss9yI8EHDC4r7coynirzR3VI/uLzeelHe?=
 =?us-ascii?Q?5r2m+rkjkhNWAj9qcnFw4TL4N2alsZ7onZoLGFS9op9rnc8Zk4kRTcj4V9fw?=
 =?us-ascii?Q?q1s1Z78eEscU82HtObDlzvbizt/mGOe6E0tbAN75VAeBNel+oPSNZX2dDnQK?=
 =?us-ascii?Q?vTdvc/5B+tnZoJX5WTOYjWvgRn8IleYGk6wOULK4GGDV6QpeY/c5qTPbAAWh?=
 =?us-ascii?Q?f/8KgkG7zZRZ2aEyvFAE1WvZ/hyYXZbBRHEzGwsfVrUyrN5LwHPh/4zNa0ap?=
 =?us-ascii?Q?rWHugXlQyzw5GVqvgeNXcVW5f+FUtluphkGQuqlsd25EOWzcfkiFQksHYSUt?=
 =?us-ascii?Q?8WzA+sJSMBG8DyTH4jVn2Hr5f5meBdjGQAm37BHSA/0INiezf6Lc1i3rlDdI?=
 =?us-ascii?Q?fekKq2T8yzTYgQE4agP4JGdARNyz4fmy+W4ndS/U7NGXd7hpK5nAmw9ZtnYb?=
 =?us-ascii?Q?KMqH4gJlZ289i/PUAY6yEuTjny0VDgZyvpqsBE+iNC2Q//Z+uvkvIEogtUOc?=
 =?us-ascii?Q?s6FzEymsOGsjMJEtzmdSsS9z9Ud2Q3R0o9HCquxM9vRIEdB16G11IIXPQTHL?=
 =?us-ascii?Q?SFQZLmFT6wnEK4PVsbc5ythUjWYl4viu79aKVsoDg/QRbvO0o66WCNruliP3?=
 =?us-ascii?Q?0GRXavdPRb/G1a74kEVelPVVEPOoi5Vl9WFJ5RVc5uK4+o0oVNTi8Mn4CNk+?=
 =?us-ascii?Q?gQLiiHwM3VAbPpsHTTWOJeQ+91Bp4MTBYxG+EiZweIWRNW8uiAKara1F8E6D?=
 =?us-ascii?Q?NE66lEzsFICS1AjYJzB5PTaOT+p9RzKoaqt+ZxN/KVBW7xf09n4O4yGzgIz/?=
 =?us-ascii?Q?HI8x2T7dr62Ki9jfJLTApSxQn5buWhi5hfhsOGtCOQuiuhb3oT5M3gY+ipiY?=
 =?us-ascii?Q?FycjaGFY4zMR17da/g47oj3jIyItlfyuFioS2crp6/+qgBEl76ll3CDXKQAe?=
 =?us-ascii?Q?mfvPFGY4Yy4Gd2//qkxPzCyV9pu96fuEzKndGkwJy2p3kjvME+DSyJ4yrhq1?=
 =?us-ascii?Q?gJBFuG1fp6wwQHJhSD1zKeW2Z4GRExqCozviAkA5YM3UFNDfV5XFHc356oSu?=
 =?us-ascii?Q?RiKNLSxQH3N2YcMxrsMtooltDOEOQk+P1Kedz5ylvUwxKakf+2W1tsJOTou9?=
 =?us-ascii?Q?ggkb/lT59VYT8J5JZNHZSJb3bmTU3i76swmdsG5emilYW5QjOlUM3tMvfuHQ?=
 =?us-ascii?Q?jB01LCdAaTu6ulitN/sy+R2+MfvmnJ7KrZ+auAK3kd98LBHuwCK0LVNovS+/?=
 =?us-ascii?Q?GKNQepjwdw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86789ad2-0d62-4b15-158d-08df2ad567b6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 16:00:16.7276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IU9FEhRTfHF1MJhGCXfiPXXFx0qxPT4x7kSCC2g0fPyqnMf89HQD3mypvV/jhjflgbhmoWeXkbsxYQh9RGK6Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8799

On Wed, Oct 14, 2026 at 07:31:17PM +0200, Til Kaiser wrote:
> MFGD register queries can exhaust EMAD retries and leave Mellanox
> Spectrum switches stuck during boot or shutdown when running OpenWrt
> built with GCC 15.

I assume that you don't have CONFIG_INIT_STACK_ALL_ZERO enabled?

> 
> An example failure is shown below with the second line wrapped:
> 
>   EMAD retries (5/5) (tid=9b544fc100001f35)
>   EMAD reg access failed (tid=9b544fc100001f35,reg_id=90f0(mfgd),
>                           type=query,status=0(operation performed))
> 
> On an SN2100, the failure occurs during driver teardown on reboot.
> On an SN3420, it occurs while probing mlxsw_spectrum during boot.

Can you share the firmware versions?

> 
> The register query API transmits the supplied payload to the device
> before replacing it with the response. Both MFGD callers pass an
> uninitialized stack buffer, so the request contains arbitrary register
> field values and reserved bits. This makes the request depend on stack
> contents and compiler code generation.
> 
> Initialize both MFGD query buffers in the firmware fatal event
> configuration and reporter test paths. The initialization has been
> confirmed to eliminate the boot and shutdown hangs on both switches.
> The subsequent read-modify-write still preserves the other fields
> returned by the device.
> 
> Also initialize the FORE fan fault query and the MOGCR mirroring policer
> base query, which pass entirely uninitialized payloads. Restore the MTMP
> query initialization in the temperature history reset path, where only
> the slot and sensor index fields are set before querying the register.
> 
> This follows commit 5b0907407e7f ("mlxsw: core: Zero payload buffers for
> couple of registers"), which initialized other query payloads after a
> firmware field length bug caused firmware to consume uninitialized data.
> 
> Fixes: 7d83ee111008 ("mlxsw: core: Introduce fw_fatal health reporter")
> Fixes: 2c6a33cd334b ("mlxsw: core: Extend hwmon interface with fan fault attribute")
> Fixes: 4039504e6a0c ("mlxsw: spectrum_span: Allow setting policer on a SPAN agent")
> Fixes: b890ad418e1f ("mlxsw: core_hwmon: Extend internal structures to support multi hwmon objects")
> Cc: stable@vger.kernel.org
> Signed-off-by: Til Kaiser <mail@tk154.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
