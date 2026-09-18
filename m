Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C5F353A8B;
	Fri, 18 Sep 2026 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789733277; cv=fail; b=LDyYm7/H1ErVWQ5JWZ2ogrQbtAPM5Zj6H1mr76dl2Xk/cmp6dDLrB/RCpBa4xQ1oCuimUnNdxm6/kZ5VcpuFF9+1iOqjFQcHZ0nc5C6PmWqVf948IEgKcXmhpmGQZY2ECE8N3sSQXydaKdJlTfMy/WBTkiNpB1tCAlVSr4DSyaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789733277; c=relaxed/simple;
	bh=7chfr3iNFfyRKknvXTTb5Tc6Vtm5Ih9p3RwrZQeDGEg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ujODf8WS8UfWwGy3zBV8Ol8/QArugI1ju3rWXt/2AnRQUbRvTsxo9mYxLqbTF5k0odeo4zIXVZCE1by2SN/oKY4zr/AtaJUfsigpAgQzzhbYBbz37nPeMniNKG5J+njbk4oKljPmvqW25PwwSP3V01Y7WPKUOwF24tXY4oU20pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A8vs+Tw8; arc=fail smtp.client-ip=40.93.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A8vs+Tw8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHCrmcKCdbF+/6Uk5RF25c94taQLw6Z4wio1pUyj1mz7Eg0McekOv6Dv0prAinmJSnVnwi5ms85mkdOnzXDuAg2iyg47JnHtNFtEaUR6WCpIWvtGiuQz8M8t8KPANCcz+UJg2sWj7HHmrqIK8xDZdpTnuu9R4OeOA5gIldhs1/Zsmr7PIoVRud6BQ2T5uhDs8pcYj8V2pCBYHWUWDf7gzSSV7qec0rbt1YQKfQZKSg1HIVQ1WOJjqqHOkym6tXWwOG75DA9ENNQvZRfZ/OY7cyI3aitCDsnEnGFajgDd7ktQoGqb4ot+6Okomu6qDGOJM2ZbJfMSVNbDezt8MAC4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzuaddYhzBxiSyV3dHTuFDuC2XTMukp1JP9Nskl44h8=;
 b=egcwwXTAINHLU+pciKOFjUwUlk9Xw7BAfl+bSIFSJImdkJKGB8dfKlbP+Dxd7zwBqTUuRNbkZljEJGu0PcGSYuEOUG6yauv1lvldi6y+FKi6KyX1yxe7eSXkADhzvl/L8RpvBmmSYqJDsQRLmCxcjnO7YqSt4XBxoT2BVpPQZxxkTQkUehG9Ng3wfNaUxCWQY/n+z+iU6OKVu7VVcEHFfy1UGZ3J8H/WKReo+nzf+ROP7X+murMGUlrTiLIzFacUDcEMRJIbNV53JaSUQrzF3aDGJb8kBiaK8VNlAsGwV/ODLzhEjXv+w9qP5xbr0Lri1gVy3zXm5RjZ6WT6RM1yfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzuaddYhzBxiSyV3dHTuFDuC2XTMukp1JP9Nskl44h8=;
 b=A8vs+Tw8zsyFx08KdQH3QJ8mEorYvoZsn0EPb5HDch16ZeiRRMv510Z2HuhOjcW1kahX7nr1qfyZbQ3aGCX3mJlVJIYyyNaY7xHHk9MYWNzpwYWgsBty5BPwQFw4W82NXiJ0OUt9xlFLED36E8NVu3Os+nJiqeDKBsnuZ02ADx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS6PR12MB765562.namprd12.prod.outlook.com (2603:10b6:8:4c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 12:07:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 12:07:50 +0000
Message-ID: <20021a25-3800-4eb1-9dcd-a2c9fd8eedbc@amd.com>
Date: Fri, 18 Sep 2026 14:07:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Accept AtomicOps already enabled by the
 hypervisor
To: Nikola Prica <nikprica@amd.com>, bhelgaas@google.com,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, jerry.jiang@amd.com, haijun.chang@amd.com,
 andy.zhang@amd.com, jim.chow@broadcom.com, matthew.mcclure@broadcom.com,
 gbayer@linux.ibm.com, Nikola Prica <nikola.prica@amd.com>
References: <97aa96e8-b553-47a2-aeea-e5d830ab0184@amd.com>
 <20260918092857.648810-1-nikprica@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260918092857.648810-1-nikprica@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS6PR12MB765562:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0a16d2-dbed-4e53-3500-08df157d7618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|4143699003|10067099003|5023799004|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	XemuFxq6Lp4FTtJNzA2yzX0GglV3ZNP3RLpPfgU6RrcxWBNCBSmiegGSkVi36nKgiJjhw/boy7yP6U6YJobAPmpD07xAyAZUOR5VTV2ilYn9k5oO2L1Bw9kHfKy2998fW1C1wg1+ANcCevEwMlHSts99NsvEHldz4oaWFR8D0/bPZ7jdWNXrYF6TsqvMi/VDSoANHGj+JvxuI//QlKCWtJr4Qv6m9Pw+C6e2LNORRShsx07SEqMasSRMHRDRlRAcXx6i6q03+USB0/ngLwOC5IEr/TC0aLF+N1RE7jj9xgoZCZWIwexuSfL5tsch4lt8uaRSDi3JCmMKGWfP6hGqKPwLPrxLtslM7GjRtoU3aSMhvKiVRT2COx7NwN/HlXTdOVgZ8QvBOef8LU74AIdSgiRGseO7bqdiPHL7AuQOlJNiqO0zIo9o4LUcLht9xxHf2cbJOw+TTrf5GcHxtETMVeYP13kHWEF6p2BHDNPvhZlRWj8RVlG/CH0CM123mQ2aPcCyMx0AY57yZmGsL/CmFGUcwgBvsSBpZObQLiWb/pLg++9FIuu8NyU1YRss3YlOs7hCVPNIk6Mgff0tA7GCzkt+Jy/Vw/bUFRKS4S9YgrIMMYfARO53SgHYH48h+ayyzML/286qjj5e9umMIdWEFK2ycZw07YbCvF07v8S/PXQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(5023799004)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a096dHJobENuRnpydlZkWFUyRXU0SnRtOEU4R3U5M1JJZWVZZ1dKT0R0M1lB?=
 =?utf-8?B?dG1Cak92aEkwSGdFSlIwbktVNXJDTE9wVmtkT0dCMld4T3NERUs5RmRLbkdF?=
 =?utf-8?B?c3VaZEc4LzhGU2FmeldEUzVaNzJSeEdOcWtVOUV0K3pSeHpOTHVwaGowU2NY?=
 =?utf-8?B?dWtjNmQyOTVqVkhmU0xiKzV3Z1RVbGZGcXJyNEtWeitPc2xld3BZZXJqK2F4?=
 =?utf-8?B?bUswRjFhMStWNHBXSy9YRFNuNXZXa2lQTjhxRGM3SDRPTkJkS1JEYTNBVXZm?=
 =?utf-8?B?VXd6NmF3NDB6bGZkZjFzcFhKNDRpUUNIUEt0eThNOTdjdlllVGt6S05CVG42?=
 =?utf-8?B?N2txZzFEdU80bEtnbWI4Vjcwb1JYeVppOFh0bTlyQTlkNGdwTmx4SE5TY3Fx?=
 =?utf-8?B?WkVjbDBEUEVSNG12Qno3Qk1wRGhUdVU5Y0FlMFR6WEM2TkQ2K2xYRlQ2QmNQ?=
 =?utf-8?B?N0lXRkdpU0dXbklkdndtNFFMelhBVU5XV1VzbUZXcGJldFFxOWNMVGo2RXhj?=
 =?utf-8?B?TnNhOTdSU093WC9LQkE3bnMyc0hLOHRuR2l6SzlEUnZJT0pSTm9yM1ROUmcw?=
 =?utf-8?B?SjVyUlZIVVZ6WlJiYnBVa3RGNmNHd3BjcXNOQTdENlFoNW9CTG9NODJBTUNJ?=
 =?utf-8?B?Uzd3QjJneU44YzNCc2tqaDRkNFc2Qk9nTFR1aHNDbFNsamNGbHo1cGd0YWxY?=
 =?utf-8?B?UEt1TTNRKzFwc014N3pXaVdUNFJBTHkvTnl3a3krOTkrSW1HUlNLdXJqbDJB?=
 =?utf-8?B?eXU3NTBnWDJ4aWc4a2U3blpNSE82L1ROMWRCZGY1cVY5YUNwb1RjWCswY3VK?=
 =?utf-8?B?Y0VGaW83MXhWL2ptMlRQc2lZenRQQlRKSVFkalpyWDdlZ01rSDVQVVA2eFFq?=
 =?utf-8?B?UFdyNTlnNUNGOU9nUE1MMkpiRTZ6MWFVR051d2E1M25IdnNjdlM4NldzSEdl?=
 =?utf-8?B?TnJvcFpoUUcxSlBlYWZ5aE1WbmpIWTVSQWRVaUNRWjZCN2JNQVQ1akpYY080?=
 =?utf-8?B?TkxMS3R2VEtVLzBjN3FhWi9sNHZJSmRKeS8vbWpsc0RRQ3d1V0wyd3pZcE1j?=
 =?utf-8?B?TDlzcDg0aUUyMTI3SUY4OEVzSWxVdUh1RU9YNm4wMXNhWWNoRFFtdXIxWktI?=
 =?utf-8?B?SzZaSFM4YzJWbXNJMVVoSUFZWEx6TThjTytIdkkya3NEemxsa2dMSHNkMjEv?=
 =?utf-8?B?M1FVbDdySm80OGlmaVl6SE1ndThVTEFhZ3FHeGg4OGJjRU84ZHZrMGFyUUxx?=
 =?utf-8?B?V0wvSDFRRjBjd3M4dm5RZWpnbWVkSlhwWFVSaEFyL3VXSDdHVFVibmhtK0RL?=
 =?utf-8?B?cmxiMkxKenA0dnIvOUFZQStWUmJHOFJJY1lEVlFreWdjaGlzNGlUdU1kTGt0?=
 =?utf-8?B?SEVQODNVVnovVzBqYTNqYzJJNUVXcXZFNVNjSFAzbUQ3Smc0NFZSdm1HSnJt?=
 =?utf-8?B?bEJWNzZSZThjQmxwaWtiSVlKbndLWGxScmpNeURqOWhrYld0QWRWQzRoM280?=
 =?utf-8?B?UUh3a2V3L0pDdjhsc0UvNlQ2c280V2w0M1JNcjRnQlp5aWwxL1VTV0pVbFhx?=
 =?utf-8?B?bzVsUEJnbFFWRituRmJDUUs3QUVCemtGOFRKbHR3VHRvQmFmYjBPb0hjcTlS?=
 =?utf-8?B?TTh5QW5vZ3pRZWw1LzFoNTZpYnlrMWYxWU1BTnR6dXIzd0FWVTNRSU1kdndY?=
 =?utf-8?B?VTF2c3Zhd09lMW5pb3hrNmJ1bTZjZllmdXNha0xuK3ZmT1hqTzc2a25aVlRq?=
 =?utf-8?B?UnFiSEFMc0hkUjJVcERSRFo3eFhMZjhQWlN3Y3JLU3ArUkJCYXFweXRDUVlK?=
 =?utf-8?B?cEFNdGpFazhRQ3RBRUMvMi9BTk9YRituSVN1dlNHazZZSzhJektCVklNMTBQ?=
 =?utf-8?B?dmZwSGNmV1JIK09KeHFnQ2czS0o5OGhYKzMyaTZKNzFUa05OTVhMZnZOdFlu?=
 =?utf-8?B?SlE2aTRGazMwamZZSVA5dG52elpQeWxSaVprQWlaUzJkY2crRDgycnNwVUpZ?=
 =?utf-8?B?bTM4SWNCdkwvMnlET29vLzVqVjZyZEpyWHdQSXpmVWduV2gvYVlhU0lZbHYx?=
 =?utf-8?B?bkhoRmZoazhGUkMxQWpLL1pISk9ycms2ajY4S3RWY0ZUN09DNnZZS25PaXBu?=
 =?utf-8?B?djVobEM1OS9RVHhzOFR1bzMxY3I1aUszeFNYRDNuN3g0VGtHdEkydEN2SUt4?=
 =?utf-8?B?VFFDUUg2dWRUQmF6UndEaUg1R2wrNlpYVUFvYldMODNpWXZHeHJ4V25rc0Jk?=
 =?utf-8?B?dllTbzRzazhBK2lWa2tlRDRJaExRc3dxdEk5MzRIaFIzT3BKakhIYWxWMW4x?=
 =?utf-8?Q?Vok7BT6D7KKl2eqAYg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0a16d2-dbed-4e53-3500-08df157d7618
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 12:07:50.7655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdry7E+2qAnhlV/bw8HqPjKO9n8FBFdTEOtMD8AgcST++An5zh03+wfCn7Kr29Fu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB765562

On 9/18/26 11:28, Nikola Prica wrote:
> From: Nikola Prica <nikola.prica@amd.com>
> 
> pci_enable_atomic_ops_to_root() currently fails when no Root Port is
> visible. That is common in passthrough guests (ESXi, Hyper-V): the
> endpoint is assigned to the VM, but the guest topology has no Root
> Port above it.
> 
> In those setups the hypervisor may already have enabled AtomicOp
> Requester Enable on the device. If PCI_EXP_DEVCTL2_ATOMIC_REQ is set,
> treat AtomicOps as already enabled and return success instead of
> failing the Root Port walk.
> 
> Fixes: 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port supports them")
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> Tested-by: Gerd Bayer <gbayer@linux.ibm.com>
> Signed-off-by: Nikola Prica <nikola.prica@amd.com>

CC: stable@vger.kernel.org # 7.1+

Bjorn do you want to pick that up? Alternative I can push it through drm-misc-fixes.

Initially I thought that this is a new feature, but it turned out to be an regression and we need to get it fixed ASAP.

Thanks,
Christian.

> ---
> v3: Add Fixes tag
> v2: Be more strict and only apply logic in headless device case.
> ---
>  drivers/pci/pci.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..62729ade496f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3769,8 +3769,18 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>  	}
>  
>  	root = pcie_find_root_port(dev);
> -	if (!root)
> +	if (!root) {
> +		/*
> +		 * A hypervisor may expose a headless topology with no
> +		 * visible root port.  If it has already set AtomicOp
> +		 * Requester Enable, there is nothing more to do.
> +		 */
> +		pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
> +		if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
> +			return 0;
> +
>  		return -EINVAL;
> +	}
>  
>  	pcie_capability_read_dword(root, PCI_EXP_DEVCAP2, &cap);
>  	if ((cap & cap_mask) != cap_mask)

