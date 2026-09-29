Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013046.outbound.protection.outlook.com [40.93.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788DD3EC830;
	Tue, 29 Sep 2026 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790700960; cv=fail; b=PkT40OO1XOdYDLnd68DsOXRXYaFsuzxiF2wt+DhvidKUBzAXe0xsoXIneqA+d51oty5Ax8UIbyI9mZzA4EFfrY4OPM5SC9unV7OkuVi9Jzo43XWcCg82bZ9EA6X1DGkZNc5FvXbV6Y7tprTk5nHxsYriNJYFlmqaoXD5oQcYkAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790700960; c=relaxed/simple;
	bh=EBqdWD9ILGxafLnLAtN08Dpe+sg3gBkAX5NtXMstqjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dTJMRuXIU3IQYI9Eb91iO7ZkWVinUlK/TAFoCuoXM+mjSZSv4AzTE8SlPLFyssPlnJkASK8KLPOxssEgCrz7QgWMa5JwA7pTGlD7H/V52ozwPcJ8DcEVC3wZqhVxjEM3ci4o58D7QXyXQk3zbbVl8XcZAwctRfkBSTN84+v5aa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JxbFDc2k; arc=fail smtp.client-ip=40.93.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JxbFDc2k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sv0X75WsU0MpblFUUUp0blxwTuZH/285+CDFWkXEO4wFmTRslAHw2c4VN5oMKt/yt8MrPQuKRKXM3RN+IxR/YEm3nYAFb644RDzAHsWMe6w+VhGyay4zV1At6ucXw/A9k8SLRbBuxCC23CuKBNfuvEyErdYvB+HuFDLMwPSf8KKxeXGCJM4ItYooBP8buWffTCsyQlsaY1EcnJ+++nqtD/BkYnxErTPAEzTFvJ/WGjTrXKQd5tf0JInezvu4c04IT1omlehsBhTKBZPevHJY3RfTayDqVj+TRpf5c/I+aemJ8lv1jRkaFGN9mqdoRgyVH9OMjRGw0n37+EO+hp4HVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrPL7QCnpJZxNKrf9blYKSmhBEnl6uvemNSXMrKavvM=;
 b=jkPoqrMpFI9aVZvsbSUG3lQZRcjNQnXedxhOH9LgyBFmiZINJIOy3bauRkm614lDaQaXbxH8yEm8/CEYZp1W+P/aRhakCA9/jNt1eRSbWU2XbKygxy59Ng9bi8RC1yVhR7vnd9PhsWCKpvEQDuCqkBOLNKtWjQi2FoEZ2YOw37Q+SL637RJjmC2Rg441V+UyPBqgtg964C3zyXBvasEX+zrT+xuRjS0F0k6aFldABQ+DMJ0XUJzQa/UsWO+px+l2t5lkQ4Fh5Wux3MgdhALr540/CON0zGa9HmRnvL+AYw5+1aeaTu0WR62Ne3v1xJmrLZfSFUM55O5/hKNi61J7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrPL7QCnpJZxNKrf9blYKSmhBEnl6uvemNSXMrKavvM=;
 b=JxbFDc2kTjujn0O9oLBaLXuP2adQKSeB/xbiL7Cfo9J3r0UprS4ZX0f+/lArzd2sh1nfSWdtl8e7Ms0T70bVg5QefMpKEtjd/mTq3CVjxShrBtWvYGrl8INRK9jTeeY/fCYK+wOiOYowbXloUKWkOZm5D+wEZ9KZ4QX7VFIiYh4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 SJ2PR12MB9240.namprd12.prod.outlook.com (2603:10b6:a03:563::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 16:55:56 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 16:55:56 +0000
Date: Tue, 29 Sep 2026 12:55:49 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Vishal Badole <Vishal.Badole@amd.com>
Cc: bp@alien8.de, tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] EDAC/amd64: Mask UMC chip select to the four
 implemented selects
Message-ID: <20260929165549.GA3082391@yaz-khff2.amd.com>
References: <20260928180935.472319-1-Vishal.Badole@amd.com>
 <20260928180935.472319-2-Vishal.Badole@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928180935.472319-2-Vishal.Badole@amd.com>
X-ClientProxiedBy: BN1PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:408:e2::18) To DM4PR12MB6374.namprd12.prod.outlook.com
 (2603:10b6:8:a3::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|SJ2PR12MB9240:EE_
X-MS-Office365-Filtering-Correlation-Id: f1210258-883d-4ac7-2c2a-08df1e4a87dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|4143699003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uiDrh68fMcSCZxifEhXsGNOBWFv6QPiSZvqxCrjJz6DfiR93BuHzCuXx82Tw+v9DAk10G4giflsVf6qlU1z1sQbVZiQ7Y+i/82iMsgyRCpBpx6jIz7FgFmQGRV3v9V75ET3xm6WIoSjzRcQCY1LmSFMj5MRAcQ0c4J4cCXC4CBL7OMQEL/l6ZahxeOnBjt5A7YlxntK+ZIHlltgiAsMRb4KnhX40jjbAY/w3nCyMcjIcegBkxGb0HuOTHSQyEZPaNBK4bDnGXoUHMLjgpZjA3d6ZEHkA4OAWB2ZE8uB40p9hyZK4FK3Sm5O7NbTg1Rz8hBcpFtyPgTzOdglpp7xviFdO762VBNLAIjCFdxLmNGyFA1hbTtk0dFs5UJoGet66SIKRcrxpfNRzwnfaDNid/V7wHfPKUww58/GMrJCWZevIIJjyJyP97Zfwx2WikS949pQyQHBKK6EsuafVCUzMrrRcxRgzDUSGZMRWLbRGT6zTUmzV/iUMLqL4Zii/2BMz6+ap9pYMHZBrB99rKksGixBj8NVStMnBZhhu/fuC65JEwSGtZjU6HeTwGPLHIT4V9JPlmQ/GF5H4SpL5eU508KeYw3IE9kIZJ21MAfmxKKtlkIkQAj10/0NMuOqAhQ36AwdBCekg2unKMPgsF7fam5OCJxJ9xjWig0LZ5DqAeEg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0gRSIH1ATiRj6sW3OH8lq+PYQi+fyJAUq8kLE/t+hI2FS7Q2AmQifLZAeQ5B?=
 =?us-ascii?Q?BmrwGpMv9QnGB51bH3cUtZrZpb/nakwz2zLH6rRjl8zPKfrX0tr3v79AGrYs?=
 =?us-ascii?Q?aiefFiuFVhPWHt8qh1v7zvU9oxlebXGeGzQ119OryriSSdEIe5luZtVq13gr?=
 =?us-ascii?Q?0nRp++x5LJiccuzHxlDk7R/tAU1MSuZ5ip0FpJ0sKdfl3hgRgMZpSgC2hA8e?=
 =?us-ascii?Q?6buP/KLLC+4yW1uaUIgw1CMwEPYNRwkDxYWHnxNzylGn/ObjKWVveU/g9rTP?=
 =?us-ascii?Q?h9FovH4O/KpS8IuYN2yd4+AFJ5OwkyVYFGc9hWKnON/EJsC5X0uWSe2hQk/Y?=
 =?us-ascii?Q?3M3dwM5vfnNfZ9LLsgHrtyqj9li8rQxWXD0djqxaaoEYDRNIzXhSGLge/+ID?=
 =?us-ascii?Q?jFaUkSLvJdvpszGB/WcLHH6q4mkU9R59R3H3anWCIQ8H72iFN0l75erjdS6n?=
 =?us-ascii?Q?HhRxpWButVVMYzxxqaRFg+oOoMRtdK314tCOt7Yhl3N6sF/DKwn5gkyBGUlO?=
 =?us-ascii?Q?HB1BtDFnJWl81lHBOXAVHM+hbDCjfEnMv1xfA3iyFNsNkioBOKOjsLTHGegF?=
 =?us-ascii?Q?JCEAVNVp6NSwZdk9qvALBArvVKtLSAieJO+F7Fiyvl0bAErMmqnZ1w4GRqFD?=
 =?us-ascii?Q?c+neJ5yBNeuNAc1GkkB4OmKPo3Nd/68oiADJziy6LIk37FYWEuWUh+LgD32J?=
 =?us-ascii?Q?MhWWaQzen5hoJXqdn4/Nts7/TepWQ9SSIlIr7FsvwiV2YiinScIrscaoClgh?=
 =?us-ascii?Q?CSBZTb6bzFWJeD8AzzOj3EXLk2GJrpluC4oH3Gxg3Y3OnnF8zXRJ8p3IqG0D?=
 =?us-ascii?Q?xN1aFfeLA+wMk0uMFet32JCOiV+qBKroIYxy1SK2joyf9rq24S9wtkMB+OT+?=
 =?us-ascii?Q?JK0R6E1E6bpYdEqYLGGmHH/azl9EaVuFiL2bmCqBzfx3gBgQWLRcsSEN9TZe?=
 =?us-ascii?Q?6zK7bqikb9UfQVWAg7I8sCvSt44Aqret63JscErRgllx9nPPay62Q8RK1rt4?=
 =?us-ascii?Q?ndwYmaCaG+aHOlxMM9T7GdHHejpsGydwIei/pFgl/+3TZNIp3GxZVEiwFnqL?=
 =?us-ascii?Q?2zXOad4ptaJ+AbN4h2Cka6MF2F+Nn8ONqta5x/5K1mgI7Ok/cHPf79+icVYe?=
 =?us-ascii?Q?WPj8KUMljjMigSDe2kuPo7tiBPnAHKIJ8fPsPPkYj3rofwsYbWuRi0wPuzqG?=
 =?us-ascii?Q?k/tpOsurtxGZ1BSR4UGbOZnzfuEOj4YEkrnBoVNtn7/tla8xP9dkZthrZ0/L?=
 =?us-ascii?Q?Qb2WN7RkggMtgBWJCxcnOvRn29QWhsP7gFtEC6kDJMg9507I1tF1zgqt1Amz?=
 =?us-ascii?Q?+stAZS066ODhEQEw6lHMvWt2w8mepQ8L/fjQG2Ui3H8Gp+EwjUMhD4HW9GEt?=
 =?us-ascii?Q?5d55BLEkoKnwXYg2ngbzmZh1VtIWWv3UGXVXvewiuua/tEeYC/JrUsZmjuvO?=
 =?us-ascii?Q?d0Ngi1MqxODAQ/bqSadyiewBoBlqeTcnphbA7D2kHglYGzle2idFus/sggMV?=
 =?us-ascii?Q?9INI7GN0LnU2LTNDDbHCPa7nYQb2dMbjyaw8guERdMmVKXOPQTY+bsmYskeS?=
 =?us-ascii?Q?ufLsW6L1OqUP1nf6uGjSYUv1G2rKfCc0FvrGQdouBhZm8225MY0tiaquecqy?=
 =?us-ascii?Q?n471tgJlcvd+Z0DggBHlYP3KCT+BK6cdqDvThSUZLnR7yb5LQ00pAmDlJpfb?=
 =?us-ascii?Q?oG2HS1ovZzrTmPZNcW5Ai01Ss+L66FFMDOAob3/2MwPpiFil?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1210258-883d-4ac7-2c2a-08df1e4a87dd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 16:55:56.7042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ns6/UBz3dgB1MRXiJmCmGeW8fu/BqEV1FIgVVzwipq21MdOJQQLxmc7n/aBjkWYtQitmEwWksxT01tEIdkk2oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9240

On Mon, Sep 28, 2026 at 11:39:34PM +0530, Vishal Badole wrote:
> umc_get_err_info() masks the Chip Select from MCA_SYND with 0x7, a
> leftover from Zen 1 where the architecture reserved space for up to
> eight chip selects. Only four have ever been implemented, and newer
> products document this as MCA_SYND_UMC[1:0] = Chip Select.
> 
> Since only four csrows are allocated, a syndrome with bit 2 set decodes
> to an out-of-range csrow and trips:
> 
>   EDAC MC0: INTERNAL ERROR: csrow value is out of range (5 >= 4)
> 
> Mask with 0x3 to match the four implemented chip selects.
> 
> Fixes: 713ad54675fd ("EDAC, amd64: Define and register UMC error decode function")
> Cc: <stable@vger.kernel.org>
> Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 475235c402e8..ec4cc306b726 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -2802,7 +2802,7 @@ static inline void decode_bus_error(int node_id, struct mce *m)
>  static void umc_get_err_info(struct mce *m, struct err_info *err)
>  {
>  	err->channel = (m->ipid & GENMASK(31, 0)) >> 20;
> -	err->csrow = m->synd & 0x7;
> +	err->csrow = m->synd & 0x3;
>  }
>  
>  static void decode_umc_error(int node_id, struct mce *m)
> -- 

I just noticed that the code comment above this function needs an update
too.

Thanks,
Yazen
