Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E03128D7;
	Mon, 10 Aug 2026 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370884; cv=fail; b=D33m3tzpBnUz8iRZph3bAP9SmTDpRh8KBnhFj7ZxnJ6dFO0Z0Vc4ul9y2egJ9IHHi+zVqG9x233duBrhGQXznAzPU3+4uZpIScGupXH0bonlS7RvqHf5YxGL4COiZCXfSP7SnH4zOIky7Jo/WAUUA5gjqRjd406bsWoT3jWZ7eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370884; c=relaxed/simple;
	bh=OTYohZvjvEb1j9L+YidpPZgmbmmqcepjPGLyqE4J7lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ugnTjz829EUzWoOwsfNCdjz7c/kYQPJJAT64XVh25MtsPzTeX15O1SnZkX1aveZaouzJ6Gzam3c4FGPaFlr0Z2yQNjRSqiQn01NnZAlLLlTgCg/jpAlcW1kIZ9S8IJH4LvgFtmzcdppPKWyYqHJuylfh2mq9coK3s3r7RnD4fdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DlzP5ZsM; arc=fail smtp.client-ip=52.101.52.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DlzP5ZsM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smuvB41ij0aaK2M4CY4hIDDG2eX4+jBuuQoDeTMZQkBpjghRHZm08AlPtip7gS6noFDrL40VxO0gjml2PKBw7xix28pi6Bvq9fZugt6ncmbhaFTIyu3XzV60vieoEeiuQwTGm28Bu80Al5JUmOPJ/aekFpaL75cFtMf5Gcfoq0vTamB3dA3EOQJhTwnQ3LWE5Q+L2eb2hmRFNzGIFpASbezW6URE1ZAcxgrpwesV2zaU32ehJHDVaAHcu3w7Yry46LaFEYewQBlR939QZTTsLZaXdm0GrSQWT0n9thskjG0VZh/TeX5g/IaADZOSsCdGL+AWND9cgeLAjr2lOWOBQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3II1+/ymymNi4ZByfvonm7hfyvTQT1GBD50uXKCBoM=;
 b=b8bWOHNXvO1icdqrmOHOenTG84GiIJN/rQ/d4y2XqlpVMFbOgHW3O9dpUe9eaX5GZ0Gkas2V7uv330lwW9hQ4K1+tFI7zRtcGx6NzFDd/qHfMwMoTPB6na5PzRSPBGweudRI9zlUf352qisEaHC25HKO2Ax7hVOJpCB+QMzQvMBVNob4ODFn169S2NK40cXZYMzc7gANKCXV0Ry8Is286zhQZsK5zVI0J03DlU7sh8i1fziZ839faNKbOIowS3l+VzbwD1BE495wzqc57rfiOlxKVYXuD3N6FhCUjGnmOe6hzQCueBXPav+izkrnVGWCcahxbjCT5HfPm1iJx/CStg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3II1+/ymymNi4ZByfvonm7hfyvTQT1GBD50uXKCBoM=;
 b=DlzP5ZsMQXTNVKQh5RcgL1Fg5PiZVE5zLJ9CrHlbNZtromwi9VYvYVQilaEoWaBLwOS7vFIgDmj91ReccCR8F8jFdmnHbOzwYFFZjZdR3nQhKqKOEzI/Scm+QsJaIc3o/bgj+tBrrLBa9Il/WJhEbt9Ayi8RnOUEUuMQu+3LkVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Mon, 10 Aug 2026 14:07:55 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 14:07:55 +0000
Date: Mon, 10 Aug 2026 10:07:47 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Penny Zheng <penny.zheng@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/amd_node: Remove smn_exclusive
Message-ID: <20260810140747.GB57095@yaz-khff2.amd.com>
References: <20260806160159.230453-1-jason.andryuk@amd.com>
 <20260806160159.230453-2-jason.andryuk@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806160159.230453-2-jason.andryuk@amd.com>
X-ClientProxiedBy: SA0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:806:130::25) To DM4PR12MB6374.namprd12.prod.outlook.com
 (2603:10b6:8:a3::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|DS7PR12MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b7d4b5-7850-4112-e6bd-08def6e8c5f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|6133799003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	qtVVmKD08uYyGAhtb4cdKq2n03+MQk3JU6VBVnzc9h7V6OdkYiQUgpBPK2+LJHMh8rl2wLkn6qZPMU4hql6N84yTd5PWsRqZEBCMnbE21WS+tMsPJi8zpJe3o3D3hP10/cTlZlxaboK2pHMg2hkwXE/E/kSBe5JcLBUZZd1vRP0ZCvJbKOXPXBX7fR6bEfnnMMcA98KjWvPU6VhoRgIXRfiDBoUEYb87BXCafAZRAiwoaXoc8TDAt/bBW+WbvcCCRJN67qX4q8V/CSTkvnfP9Uinb8LnmWxHFGyfvfGkGqpn2m3pmV1CnR+E1VhzqRTmYZnc8r4kCx1e0/dNUXtmpHHKG8J1Elr7Peckq5n/ysQltS2ohlCDwU/UQfavm24eVbheAT/HHTL/KUsvb1u4FGMTBtfh6/y0G7DtTyt7UCl1kqIJp2nh955GQGQA5oN1Y/u0yWBoVy5kajGgYZzfXgcVDTcT0UgHUwkLpcJYfMZDwsDZV/XXq0tCny83+aQpx04PxN0CKLnUy2A+jmAmPGMhDuJ3lU4zOHIbCzFkLn4+Pifmgx3dJOKUKRNEYuZepzrAIGppdA2dQRLD3hIUGuBiyuXCd+/G2z6EfQgheaRvkkc+qL4/qHxE6tM4kGHIaDZmnGZm4QeCZWsyE1cM/DTyj+hY/TWh5Ri55QImt/U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OtZ40MC15wrs6hOBNLBBt+tVTRoG7zrGINJCb3a8PLXk7KNsVTj9DeaoklwX?=
 =?us-ascii?Q?gXrvb3Y0vwuqGKLdpr9Fg6wSxWGae+WeBAX7AXrgrDA/pitflyjz9UWS8/HE?=
 =?us-ascii?Q?axAc2CyGMvBgFjuoNySqhbZnkJT51VslDI6om2jwoYRIKWG917UNGwLUoouU?=
 =?us-ascii?Q?FObmqA6LXM4yeyMsKOaMurmyxzFrmKZVN7e6w6/XFe0wY6Vc8Oar93LbsQZC?=
 =?us-ascii?Q?Vvy5Xy8GU489hn6GvHtwjRVjitMCl9xIFXAyGlmGGTka1X7u1nwAE20gH9sT?=
 =?us-ascii?Q?GNnGP43J8SRU8ZP2IixNpuJuo/VR8DXrNu/buKrlVJenvUIpLd8F2BDIolTq?=
 =?us-ascii?Q?+WwfQzGAWjMaoNnLLXgU7sTvpdvZ1eWEBUwXyw4eWdcDsngORqNOupsUsA6W?=
 =?us-ascii?Q?QCfNX/RV2vIh6ntXaHE1UIPGpSetKcYEBT3P5TdO9bfjaUDVg2/oOorvtqAX?=
 =?us-ascii?Q?bKQFn7M/pWdji29cIlodZHKaqfNZMO/fzr9i2eid6IoANTFM4Ua0roPSujhQ?=
 =?us-ascii?Q?5rS0N4IM1YsDLDsJ+dBpQFdMib1kS5wVxN4d/tp+Y0LQlUwBybdrm46XWAsD?=
 =?us-ascii?Q?fy3ut7Uzs/B7Q5rmFyQhdgEcF4XvghZws//AmEoL0huKaFOcHYUbGk5s3XrH?=
 =?us-ascii?Q?YIJhz3LET7rZFcL3FJOdxZexIJP42btB1pKyXNVgGk6x2tGZowUnX0ro9E/p?=
 =?us-ascii?Q?0KlJwL7P/hnj3hiWMPVQs0XLdiuQep5C67dJgSpB49Pts4ha63vh3+5BB9Vu?=
 =?us-ascii?Q?Hik/V7TV333zDbGlaupPA0H0JLDVZbe942ERzmNgtZagBN6pKgmJFS2wrZd8?=
 =?us-ascii?Q?Gb+F542QVSXuzOB/NJ5HhHK4QBGb+pBo0HHLXDr8/vmLTQw56dC41JkhTgTS?=
 =?us-ascii?Q?FQCFu97vRMur4Y587us3OsCDPQsYjYnnvRzEVrMc8lEi/sdG8mEuM5S9B6SA?=
 =?us-ascii?Q?5fb70u4Xbobqv4tikamdSUx7IgB9FwfTG/NfB6+J8bz8NaF3AbvlbVUyvAfv?=
 =?us-ascii?Q?UYkWocID8+3p7IryedRBEqb6N15sAE8gCYRWgFZHppfHnejHbHYsO8pAU6Wf?=
 =?us-ascii?Q?GWl/E0qYccHLzWww01OVSmAdHIuqx33pzZq3r1C0IjEIa54DZtx6E5OTrlJN?=
 =?us-ascii?Q?Xq3OE3ueHr82DdywTSwQ+P/i0Su5q1rCzl0XY3IIpGmw1HEbuWahzT9TshQU?=
 =?us-ascii?Q?cEEAITbiT1LxCfSRuIGl+F0SKcDmbTaaF/ZRI+HdDmOuqCJcAB5fVd8fB49C?=
 =?us-ascii?Q?sPca4HSVixbgprVxb2oeTb9px/+hNhTQXDYuibk/IhSbs8ua15f7gi7IVI2x?=
 =?us-ascii?Q?UKx+ySC2xHAJextpzS49wVqTyaMOHD5TmLZfNQopfUjQj7dmEcJGiWD8g2Mv?=
 =?us-ascii?Q?7uQYk7DYuSiq+h2tK6HxiB/8jmZqrOja2zE+gOw/VaQKK7M1z7IJxum+xnOH?=
 =?us-ascii?Q?aeUOPYuVBfFgf13MvT5Jf3tiRm0BxpNVGR6V7JDHk34WI0Rktyc0dJU7yOi9?=
 =?us-ascii?Q?/4Gv86qvbAwDR05n+KsHkAIPzVuBZhG0/YtWCsdj1k9GmfKS+zT0ZutesZlL?=
 =?us-ascii?Q?hwSApxfhWy2QinxghCbveTw2DkdQ0T2mx1L4xBhLenljD+PjUTvYF3DZJqh8?=
 =?us-ascii?Q?pybbpONdMWPGrIj3yTDKrRO+lsACGfN7ScXj45PsUtOkoid/Bm9ni8eaaz6H?=
 =?us-ascii?Q?2dX5123P3mXTpcycvJBMAnVnXMSEDTm0eSH44+zY6eqSYulQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b7d4b5-7850-4112-e6bd-08def6e8c5f3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 14:07:54.9425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hw+FCS623ozMU6342pgVNqgKodNbh0iDmXvnplnA2lv0gHqGAV6eFSVBzQWZDXxYpuYqf/k+cj4n+6t6QXAyQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8202

On Thu, Aug 06, 2026 at 12:01:56PM -0400, Jason Andryuk wrote:
> amd_smn_read/write() are exported functions around __amd_smn_rw(), so
> they are always available even if amd_smn_init() fails.  smn_exclusive
> would prevent access __amd_smn_rw(), but it is placed too late.  If
> amd_smn_init() failed, amd_roots is NULL and __amd_smn_rw() will fault
> over it.  Replace smn_exclusive with directly checking amd_roots to
> avoid the NULL pointer dereference.
> 
> Fixes: 77466b798d59 ("x86/amd_node: Remove dependency on AMD_NB")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> ---
> Fixes is the introduction of amd_roots
> ---
>  arch/x86/kernel/amd_node.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
> index 0be01725a2a4..ea553267e5fa 100644
> --- a/arch/x86/kernel/amd_node.c
> +++ b/arch/x86/kernel/amd_node.c
> @@ -38,7 +38,6 @@ static struct pci_dev **amd_roots;
>  
>  /* Protect the PCI config register pairs used for SMN. */
>  static DEFINE_MUTEX(smn_mutex);
> -static bool smn_exclusive;
>  
>  #define SMN_INDEX_OFFSET	0x60
>  #define SMN_DATA_OFFSET		0x64
> @@ -91,11 +90,11 @@ static int __amd_smn_rw(u8 i_off, u8 d_off, u16 node, u32 address, u32 *value, b
>  	if (node >= amd_num_nodes())
>  		return err;
>  
> -	root = amd_roots[node];
> -	if (!root)
> +	if (!amd_roots)
>  		return err;
>  
> -	if (!smn_exclusive)
> +	root = amd_roots[node];
> +	if (!root)
>  		return err;
>  
>  	guard(mutex)(&smn_mutex);
> @@ -308,8 +307,6 @@ static int __init amd_smn_init(void)
>  		debugfs_create_file("value",	0600, debugfs_dir, NULL, &smn_value_fops);
>  	}
>  
> -	smn_exclusive = true;
> -
>  	return 0;
>  }
>  

'smn_exclusive' wasn't originally intended to be used for bounds
checking the array. But the original use is no longer needed, so it can
be removed.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
