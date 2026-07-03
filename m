Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010050.outbound.protection.outlook.com [52.101.193.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D570322B8C;
	Fri,  3 Jul 2026 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060123; cv=fail; b=TDuQdngleTV4h1VOMqKGAZ57LD6nv9hA/H9ZGo2193ONGP+HaokKqPV+uUdjoz4CPe6uYJyUGv0x0A1iFHOUlqLq6EwO/sqz8jsNzNc8EbTMptfBiu4W7WHcSXxPx4uzFTWNQPc5jgrfwzBTWvLmbR3sd6wfZDR2DGOQgSHQMc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060123; c=relaxed/simple;
	bh=G4zdL1kGHMxSqElfrMm1VCflsANZ+jUwcMw8sVSWCUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kBbrF4SmNa6XsFT6UbvrNe+tKhmY6TpaQ0IC5FZYO6qHo3iJ6Cx1bje2JpNCL0sMtmIv4GEYbjQSE6yJWkMSuuD0jIiLubxK4C8ImYhyfPVJ96om+9kUvXcqMinlbNI61uR2zrBbAHR+e32sgzZdtJUWwzS90hytvsvdWU3xIxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VRzHthTh; arc=fail smtp.client-ip=52.101.193.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VRzHthTh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYR7aXPGV7dn+LT4fHVZvAOLc6wPMHuebN2EHViEgja3rhR230l2tBcu0LgeYGlSYBwejTe0aDcjUQOZ2ZSwOmI2Mt2/Epptgf7M0evIG1aWADFKA3to6HfNKyeEfxkr9rqRuHOUzbuKc1ph/fm4HN+cu9PO45Z5laYzwrxY8jggWHA2ZXNk1JmeuHKi1vGDBDf0GtqpV4L+AzTA54qG19NtdSqcJ3X1uc73sCGfWzz/nMVkCHdFcpQ+w7XXh8Y7OfPy1a7LyQeskAi1QQ02wvJe9lU/JaKDuFIV2Z+iUi1kuPSZ1KBjOzcbABa/PPHGMK7twKh+t4BwhmNxmarpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hqv46YZMgCjKnuYU34xva0l7G75FVymwzcyZR2sAv0U=;
 b=FWwHLT2MN3c6vrwYZDJNC9JUY9UPeMVX7ohbrxfKurOGa419dOQ0v4zNCV722A6DXPXhnJlRjf4nisfXjDMnErjb7I1hDAHoOcRGoN6F7j/TYameaZGQ+VhLoPuA+LCik0+PSRWNfgZQrJ7yx8JISqr4fOTLzz6INbmWTAEMHWtXEJYdtuP634wkeO2Z+nBDYdG/LM1PgA9P0x8QQIOzmMfTRlUJrlbdYu1latQcgRM6wMwof6kYztAmQo95tWdUIz19PC0A8UkGIR8iFqZHiqxESVlKLkg5OIH8X9gW8Ch4GyIvF6H8h2B7RwjFrwW0ZZWFKn9ROiluxsE8+ydPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hqv46YZMgCjKnuYU34xva0l7G75FVymwzcyZR2sAv0U=;
 b=VRzHthTh7YKvDyX7vhchxcRyO8ylfgRSQLY5LcfFl6UU/i2d3OfrUGVFsNuoP+nBzt77ph1FHCUSuCRAsG7VeZ/D1V955vUJ1avN8oQmaW/l0s4xDWXLyxVjkQphkndHuMEAqDzpGty2SDGNIbW4VR54b0c7sdcCe04QNbRvNwpbERaKZKJEltf63m8zFedWorGEHAqaA/hbt9hPTgDqyEyxFfWxI4JR4gjI1KxGNjTGy84MmRnS5yYbwC2/QocDuHQHpMTavTjjdetAbgLkMlEIzyGTbcuS0PVZE3NkHdqvkmSZd4ug0D2LbiHX4k6zA6YJHm9E7VEb8SB2XvkLNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 06:28:35 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 06:28:35 +0000
Date: Fri, 3 Jul 2026 14:28:25 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] cxl/pmem: Format the nvdimm serial number as
 unsigned decimal
Message-ID: <akdUTK5ILvXbMW-n@MWDK4CY14F>
References: <cover.1782948930.git.alison.schofield@intel.com>
 <e124234e95069cb6512b9e1ab8a1335bf4fbed5e.1782948930.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e124234e95069cb6512b9e1ab8a1335bf4fbed5e.1782948930.git.alison.schofield@intel.com>
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CY8PR12MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: c8731350-2b90-41b7-da14-08ded8cc4e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|3023799007|6133799003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AGZBzgagT5WyzzCVeWGaY/zCprTfCGi3JndxpjH/0QFxepRsBlTraQvXfiRPhyaDI4gTiP2N2DYFmbG7alSBCf6noiugZRsVKzjAmLPgD9NsWmZ6YJvudqSlgZxvkUJXKdvpm7CvoQcG6ibyg1kIIWNjBjxVDFwkI8ZRVsqgjPsQOOYde3vWITtqSzXJ97lq59iCFi5qR5V4uj6Aj40JqU8Z+AK8XrJRwgHCM1TTLxNb00ChY58ONixPZNhD4jtFgfCGIX1UP4CXt39Xx6zw6Z4UGKRql5ripysuT0XfAqGqKRe14HM7ZGDmfSbhvlomfAsEHkDbiMSCalglLNMqzELr+OthJyUY6VgzVCm05Im2dN2UDaIgCsyanx9a7bR1GFuFCxRMY+evCZ4EQ9xPJgRpi2dizeAX3Pc3+KdyMVA33zaho/4VmtN1N3Ch0HK+5J+l3uCX2fb4PpkfiobQ8Tt9T+Pen+6F+mfIYn4Y7vjV5M86l26sNaQN8OsHwhqJQkZw9QZK49ttyfG1VBHqOLGc+LYGDvXISzGsHGBNEuvzXJmizTDIdVIyp2EZO5fH1vwJcGgpxaP6YJBNbMZZxRVHvMg3UPfXcDJgJ+5gun+0YJAIgpQ2sf4JYSDO2/Pj3a5H6nHiyqpnS2rxxMaGw21RO0LB4NwB0ry/JaSkFwg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(3023799007)(6133799003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MtGIjCDr+omVtREeu32oH0AQvxOQqKlBIOH5ly51Oi8Z7Q7dkQr0xCEFQbNi?=
 =?us-ascii?Q?Yx8YT4QR1vERSHcTH6PYn9FQE/vhOpLYb0D7RSP1qyczcSXaaUZCPHaa/uzv?=
 =?us-ascii?Q?ARX2dFXZRd+gYW3nkXKCsRpSJpMwwEOiNHa0kaCQDZP75tYHca7LiPuN3Ctt?=
 =?us-ascii?Q?mMwTMx/XwFt1s5piSYEcinMETfjU5LP6ewoVp6oG7rRWB2Vd2u6OxAs/jxBS?=
 =?us-ascii?Q?3b4Ca3hKuVc2819N57d15uku7W14oaxkdmUPrGd9yyVP95b4QVJtlZampH7i?=
 =?us-ascii?Q?kxOcCxe8a1MNwrfMIGn+dVtuD5ZNBb32XQGTj9iUsTXsx1MkO++5g6CXwrD+?=
 =?us-ascii?Q?+Ml67XHfIW0CDqBmQTWO9ddOjQCMgONqYkWOyd/I3ybSXhBvcON0nAAqA7A2?=
 =?us-ascii?Q?fN7bVvkNH074LoQV1sIMtxpTsdny+rcZJqHpScfFRhMvFC/s8XWLE620KYRQ?=
 =?us-ascii?Q?Fq2jXv2c9Wz1a+6aLAE+D31CRFl6wDXAVEZQnRQDnCwmgYlt/e0T1lvzGSGF?=
 =?us-ascii?Q?T8Aysncq2undrk69tDQ3x2gC8vD2V4oofruZgX11w5xlPwYRhL0Tts/YniGq?=
 =?us-ascii?Q?eHdC+3BTHsH342uT4Pmbm71rhiVlwwTl9WX3K5dC7EJE0WAf/1603cUOCtL6?=
 =?us-ascii?Q?ubBwVtXdRlT5QGMuGpstxYNy3zRoceVPZ27O56zUQY/zwawqjbRkilC+psbX?=
 =?us-ascii?Q?T/+hkP0gNaazhbq3DJp+wpWy71durd3VTN4UbgDrXq4vMpisDt03VGsMeGKa?=
 =?us-ascii?Q?ZKY/TKOV9Q2ekAd47VIClUuiSDvFEYfP91meYX6WnEwFwis6pXLYtqPO5Wkh?=
 =?us-ascii?Q?WR1GOxkaZ4VvjuLCe55FZHqn9AFxEMOss7vAQemgJOusR6ITmr40EQwgvar1?=
 =?us-ascii?Q?PStvrNU6tnYnj01Wyn1jYWgDXJu5Se1y12srf0wV3nT7rNW6uO9VE/zRxfcl?=
 =?us-ascii?Q?lJxs28HD/oWYEicihryDLbWKIzeGNeLIgDjQpwEkvl/PPmMXVTFLERJOI/NH?=
 =?us-ascii?Q?EKebp40xtWdQxt43GNXoAWmPuV4hFhxa7iq13CtEmeAU89LP+eNV2E/PO21D?=
 =?us-ascii?Q?+zzFM0fGqJdiFwXniDKeFRFpK2zzkpHteeBHfhR+5AvVpG6ALi4+UBy1+GD2?=
 =?us-ascii?Q?ng0dEJRsv05Wtlh8uHJ730fMq2TknF+JtXfW2dTvN0kGuPLJEWcA1TBGX6FU?=
 =?us-ascii?Q?AhBBKSbDv86k9P+HVV7KjmdWZaYVB8Sit7vTJLpVZbTnNxH/h3xvSfWODCH4?=
 =?us-ascii?Q?nuc9HTo7EASGUD8ZT8OECT+dTto338n2R0sEIPZ3pGEjNu4lvriF89rD457M?=
 =?us-ascii?Q?h4SURvLkEbXYaOt2I+uvOhOGFgGEWnXghrCGZ6kw+vpfxx4ynlhOTV2aH5MP?=
 =?us-ascii?Q?4Oqi58V/SoqMbhtrXD0AKpfPFG/bODB2ap5MYEetg02a8Ill3uP51iMNnEKd?=
 =?us-ascii?Q?d/OW1H1ACxl0+dAYyXIvRNAq5HDE4916kDA7k/hjRVel7/XRDV0vNHYhyt6P?=
 =?us-ascii?Q?zCGFF0KDBKAa8shK76o793hu+Rc9yLl7BuTkFNKZDuyc1uSP5x9HW83vztrc?=
 =?us-ascii?Q?myQi6kKjkUR0e/BHmXZBLErL5dHlWY2Es0VRskgZL47aJxZuVSYDQL2PZ5Ue?=
 =?us-ascii?Q?Tx+4NrrRah4JbZW6y2VcZZGhnnCu8tuY3XKLevyIgb38jPcmvzYaE1zC/40H?=
 =?us-ascii?Q?f03P9h5Br+fcWbcGhxyJ22XiFoTQGyML8XaW5VCtRToFMf5PY0bD9w/wQD+t?=
 =?us-ascii?Q?C6a+0Z15SQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8731350-2b90-41b7-da14-08ded8cc4e79
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 06:28:35.0926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1ql7oJB+FYUMX9u6pbUtfYB+s68LaYo/pr6VJEj/EPCu5vBdN0BsNaYO7Cj7Bxy4I5Kob5Vuzi2L+zgKVS5ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265

On Wed, Jul 01, 2026 at 05:30:44PM +0800, Alison Schofield wrote:
> The CXL NVDIMM security passphrase key description and the nvdimm 'id'
> sysfs attribute are both derived from the CXL device serial number,
> but the serial number is not formatted consistently.
> 
> The key description is formatted in hexadecimal while the 'id'
> attribute is formatted in decimal. As a result, ndctl stores the key
> using a decimal description while the kernel later looks it up using
> a hexadecimal description. For serial numbers of 10 and above, the
> descriptions no longer match, preventing automatic unlock after
> reboot.
> 
> The decimal formatting has a second problem. Both the key description
> and the 'id' attribute use the signed %lld format for a u64 PCIe
> Device Serial Number. Devices whose vendor OUI sets bit 63, such as
> Montage CXL devices, appear with negative decimal serial numbers.
> 
> Format the security key description and 'id' attribute as unsigned
> decimal, %llu, and document that the 'id' attribute is an unsigned
> decimal value.
> 
> The key lookup mismatch was exposed by CXL unit test cxl-security.sh
> when cxl_test mock serial numbers were extended to 10 and above.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: b5807c80b5bc ("cxl: add dimm_id support for __nvdimm_create()")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-nvdimm |  3 ++-
>  drivers/cxl/core/pmem.c                    | 10 ++++++----
>  drivers/cxl/cxl.h                          |  3 ++-
>  drivers/cxl/pmem.c                         |  2 +-
>  4 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-nvdimm b/Documentation/ABI/testing/sysfs-bus-nvdimm
> index 64eb8f4c6a41..46dafd8482b9 100644
> --- a/Documentation/ABI/testing/sysfs-bus-nvdimm
> +++ b/Documentation/ABI/testing/sysfs-bus-nvdimm
> @@ -48,7 +48,8 @@ What:		/sys/bus/nd/devices/nmemX/cxl/id
>  Date:		November 2022
>  KernelVersion:	6.2
>  Contact:	Dave Jiang <dave.jiang@intel.com>
> -Description:	(RO) Show the id (serial) of the device. This is CXL specific.
> +Description:	(RO) Show the id (serial) of the device, formatted as an
> +		unsigned 64-bit decimal value. This is CXL specific.
>  
>  What:		/sys/bus/nd/devices/nmemX/cxl/provider
>  Date:		November 2022
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index 68462e38a977..5a3bb7e8a1f1 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -219,12 +219,14 @@ static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_nvdimm_bridge *cxl_nvb,
>  	dev->bus = &cxl_bus_type;
>  	dev->type = &cxl_nvdimm_type;
>  	/*
> -	 * A "%llx" string is 17-bytes vs dimm_id that is max
> -	 * NVDIMM_KEY_DESC_LEN
> +	 * dev_id is the nvdimm dimm_id used for security key lookup.
> +	 * It must match id_show(), which emits the CXL serial as an
> +	 * unsigned decimal. A u64 decimal string is at most 20 digits
> +	 * plus NUL.
>  	 */
> -	BUILD_BUG_ON(sizeof(cxl_nvd->dev_id) < 17 ||
> +	BUILD_BUG_ON(sizeof(cxl_nvd->dev_id) < 21 ||
>  		     sizeof(cxl_nvd->dev_id) > NVDIMM_KEY_DESC_LEN);
> -	sprintf(cxl_nvd->dev_id, "%llx", cxlmd->cxlds->serial);
> +	sprintf(cxl_nvd->dev_id, "%llu", cxlmd->cxlds->serial);
> 

Hi Alison,

How should existing keys for high-bit serial numbers be migrated?

This patch changes both the sysfs  ID and kernel key description to unsigned
decimal. ndctl persists the old sysfs string in the key-blob filename and reloads it unchanged.

I wonder how's the old key being migrated ? I don't think the patch rename files under /etc/ndctl/keys , so ndctl may reload the existing secret
while the new kernel searches for the positive new label.

--Richard
 
>  	return cxl_nvd;
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c0e5308e4d1b..d683ae5e0f7d 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -503,7 +503,8 @@ struct cxl_nvdimm_bridge {
>  	struct nvdimm_bus_descriptor nd_desc;
>  };
>  
> -#define CXL_DEV_ID_LEN 19
> +/* Holds a u64 serial as a decimal string: up to 20 digits + NUL */
> +#define CXL_DEV_ID_LEN 21
>  
>  enum {
>  	CXL_NVD_F_INVALIDATED = 0,
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 261dff7ced9f..a9f50281875d 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -52,7 +52,7 @@ static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *
>  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>  	struct cxl_dev_state *cxlds = cxl_nvd->cxlmd->cxlds;
>  
> -	return sysfs_emit(buf, "%lld\n", cxlds->serial);
> +	return sysfs_emit(buf, "%llu\n", cxlds->serial);
>  }
>  static DEVICE_ATTR_RO(id);
>  
> -- 
> 2.37.3
> 
> 
