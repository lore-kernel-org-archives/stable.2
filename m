Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706A326ED3E;
	Mon, 10 Aug 2026 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369187; cv=fail; b=ZHilnfrByuO3hza3aW1/v0dRbmmnIAR5sQBIaT4XTaRyBRcXQXklD+C/meTVxAmRxgWbIcxBbGPrT660nSv1bQ/upO+krCoK5yNKWTRvbVheDwf1mOOyJmyAxQMY8SVfO4Gfk4YPO9BxtDNrrpEQGqo9twe9Ysj+mdXxCr5lRIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369187; c=relaxed/simple;
	bh=miPfhBD6fCzVyx0t7W+fsCvjY9SYCE1oBzoe+COn+ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UCa5ben2Z83cKCpTVWvQ9c8QOS6hHqekWOIXtJ159wkY3OgViQVPs0bakZOZycV4BFfIoBTWq1b46x/NALCIDVM1HMH7Jr3nBDrLCourXz5vJIIDCLfgtvtmAIDxjfgXdazRzSRKWV3F6rBlzZNKAi8z/OhDksFR+Wx2EHv71j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pyI7RiVi; arc=fail smtp.client-ip=52.101.46.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pyI7RiVi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hY+a5Bv1UsXdzLCVyBZ5u5iyzcD7rchIukJrBSDYAdNJ/V1yhcnL103aDJGQED/EIx1IDbjhaYnSQijJIdMvahCPycfrLEzmPMOJLJzzec2Vh8ilc08WIkQa584ryaO+KYvZ4NEgDcngz5oEIA2SgOKOjOLXQm+vxqJR6GP1JJPpd0N97GOl/2q/wASDA4vfTvd4TdTVINnsVrS9PYdHa3snbYwMvbg2Z1j1oAQNDL9bG3wrkniXhe0EIerlXUvABBZ9OcEfwilD0wbzY38RAP3oYBFyEiixpT75gwttwXZs6VNtqOUZhcNyMhx84u9l3T85roXCjpcQmq/h5PAgDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ryxt0d1TzGCWaHlS+HQF3FUNp8XG4VqmOKqKigIVQ0I=;
 b=tncXtpEJrFmplfPRv+NC16kjsPGAgp/stCCakmkcwQYVoudKlhb1V81uawvEhKzDxgm0jurePZll5PTkdFIAGDHO1dyTvgBQrU5qPcj0ldJ5b+WUZV9yzH3jetj7vre/ysKlRgLq9nFfiQQT4QIHkoRza1jCV20Zd/Q7R2be3oEWtiZzCQUuNfxtxuhs+9XCE+n5ll9LC+8HAmTO956Pjv/N+02uCZjqV8n/wbABYH/PDr8bAAYRRfPsvohi5GCNjuSCe2FWu2MUmFNKjQJVx3I108N3M9+UNnWLZmR8tIZgzGCs2wNenpIvSwIOcyz3TI/ET5PopMMGI0t8uSvizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ryxt0d1TzGCWaHlS+HQF3FUNp8XG4VqmOKqKigIVQ0I=;
 b=pyI7RiVisULhQhF+ozvC+Xz8F02kvq9ODPFPB1cCyQNtVY3H/10nMhkAYUZ962AXDmLWzK8r2m1jUeh5vjlwl1Wd+X5mI2aLzKcWMeU6pwvHyV1PZavy7ZhBfg9Tw6FY5998n2wmlKzJznkewHPBvab3+vss+zIbbuE9OvJOULA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Mon, 10 Aug 2026 13:39:43 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:39:43 +0000
Date: Mon, 10 Aug 2026 09:39:33 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Jasjeet Rangi <jrangi@purestorage.com>, x86@kernel.org,
	tony.luck@intel.com, tglx@kernel.org, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-edac@vger.kernel.org, stable@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com, avadhut.naik@amd.com,
	msaggi@purestorage.com, rjethwani@purestorage.com,
	rhan@purestorage.com
Subject: Re: [PATCH] x86/mce/amd: Fix inverted interrupt enablement during
 storm handling
Message-ID: <20260810133933.GA57095@yaz-khff2.amd.com>
References: <20260807222721.2795123-1-jrangi@purestorage.com>
 <20260807225241.GAanZhufwGMzonqHUZ@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807225241.GAanZhufwGMzonqHUZ@fat_crate.local>
X-ClientProxiedBy: CH2PR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:610:5a::36) To DM4PR12MB6374.namprd12.prod.outlook.com
 (2603:10b6:8:a3::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 34eef6b7-697f-4afd-9907-08def6e4d588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iIMEk1QfNp6wa70an0O21QR1c3qiVIEQlZL8U3IqDWZam7Ir63TIDcaH9YS1lXk4Mnu58UwBcQ833/w73OkyRJNghASmnbF76oxSbKfYa8Rmg29H4tzvYrkgUZLrsENieh0Ufk/t8/lOzpEJWBm+PDGFjwDtcbVk3utnSN8pDjpXB0FsmsBYibeAxIxDrBk7RdyYbr2Y5cZp7nOiTbHsBbbehMNWMEmpWy0+UwE8gzW3m+NOgethcKna9+fnZO5Dgr8Q3IJnqokKcf8YIUobIX+Gv+4XraYFOHbY5Dv57INZr0fR5bizO7gHxwTCKvBICjcyC+mNDiczx9EOU2vOdxDUBzIdjtuxP+/x+JRE9x8n7qqvJuwbO0WXy8adlXwxe9ImcJ6y9gTt1jdcZfxiFKsmrPPfdYcR+UMcjenyU9S3pv2rtVGGpj1hrPn8hPVEn3/mQynn5vkZ8cTZUTOImw4waKaf0Dv1ed/o7AeSrxFUdiOFpkMzrOWZRa00RG66K6ZWkC97GeLIulDIbaHXTze3dE8bQC37DYehEmkqUfCk3y+0QhQnDVXlW0gX0u6wXhTaqBPZ9WiTYTtZb9GDaXCePYdz8MPRNw0HRKKqM4NiQl/JU4ycexZnwg51H5AVRnP1Cs97QwH4DlfnTxSl5LIkf6A1JnHRxop3slw+yxE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OKrM1MbpThv+wcLFYyLIJehFqJtk83m/Pp7he9S3ljjXEg9kcWNgSVMMXw6s?=
 =?us-ascii?Q?ilTX6C7UrZuNb8I7FbEIXlGFO30aes3hAgW0DqVE1aZDBqvvOfJi7ek+msur?=
 =?us-ascii?Q?/7gv+VED+aXT81FTu+ahoX+1dImTSuIPVfVDaQIpFtJpYeiV0NIcLi29JodW?=
 =?us-ascii?Q?UCjQKDoZYXnF9SaYzngKuPI+gBgU+ly727zdgzCkiDjjzgDdEdTrzoOl65FK?=
 =?us-ascii?Q?HGBTwqq1vCkktaaq7ZYQtigxade0o4L20hIge2ECBi/sqbTcwsII7lmY4IXq?=
 =?us-ascii?Q?XBs3DBGm7/6Dyy9EztIeirxtko2bNFH6HJeKUy2Fsl+wydeH1+/3+SQDq9j3?=
 =?us-ascii?Q?qM22eX0GeJvOkYlssgSfRVAROLe1LQLBfzoV/quZeaR/vJE2jxriyQVQw1DH?=
 =?us-ascii?Q?vADzFBJUj5qXuyYldhR8EBdXPniLD2a4kCjZZNJ8GrLqJE6/Sw09QpjJlWA4?=
 =?us-ascii?Q?VrIcoRI6yU2sk9njYWytHVuxA3KM9IdFstoO/3YN8KWKx2O4TtVdg1DqcbiB?=
 =?us-ascii?Q?sEC35MZeAZr4mj5UFqfEVCrbM0OcSLaZqvrCcDpccmsnYx7BRAksS1eBHT2y?=
 =?us-ascii?Q?m+/lDgHo/7/jB0IRphdBioiLuRpY6p67WkF3xEJhgQPoBipLdxxONkJtn7CK?=
 =?us-ascii?Q?KC+95JDxknnleJTNunhotCmhd4agKF/d+e9T2ZGn5Sj+chW6SrsJg5OV4XPd?=
 =?us-ascii?Q?4vfZTBPnFNv7mirZZ7Iyp5sokmHiw2l52B0ve5E8h8b7DKaYI1duMKnu/DOT?=
 =?us-ascii?Q?YNgFY/jtq1BUjqDdovi95NiDWaWwFZokaw5e+b8n26iC6UqxRFx6n3AkKfy2?=
 =?us-ascii?Q?seiASbRhT8j8RTKCTI94yw4HWmp8fjPbWHtjETdo3cWRBEyu1GwSekP11Pp2?=
 =?us-ascii?Q?70ZKIsqR7QIZi1C0an9AgkLx17t9pKnrMtXq9iFCAepS22TDF7TLPkMVxpHC?=
 =?us-ascii?Q?pNzVB9sFwZUbyekz2N9UcwvvrkxDiQ+HFTe8Jv25GVQcsdwuPMPUSE/Pc5g1?=
 =?us-ascii?Q?R0PqBMuMVIBloT/fdPpZDIa96m8sl//fmfkchYkEnkK8+/ScOqu3F/Kgabtb?=
 =?us-ascii?Q?w0mrbon9V8kPzg8tGl9R5BfpVOewcMMOjmFghoUaZBYRT0WTVxNQmuLnkYRl?=
 =?us-ascii?Q?wqgZwW38e1M1ICsHCChJDJoqwM0PR4HAn/vwo30FvVK8x7c5gu3hbcJcO2YB?=
 =?us-ascii?Q?mxleV2f9UGfL7tTRiLst+5N11qScBBY5HADni1QIyKhkZDmpgq1dOAgwoPow?=
 =?us-ascii?Q?yGM6v0WmZYxIgLB+l77IRKiYKdh1EU8d6PIvMC1RJu9powbn9DKwBJl+mEvV?=
 =?us-ascii?Q?m1KXzSLUMNjOPzo2YuqlyOGBMxA2Xvt7GhfzwCx0Q0mEfjhoGn2wEY2CDMgv?=
 =?us-ascii?Q?+0R3uZY3Fvwty+dpfbT6JcQtAdv0p+ueXaKj/h51OzP9LH5YT3EbY1KOb5db?=
 =?us-ascii?Q?aYDDOBrvnXjbPw2GNsFurscJZoh506nuaDtXfiXeAjKIWTJvT9W/CRtYmyMF?=
 =?us-ascii?Q?bcJanbCKscf5NPo7MgYiwXqsxFZ0BqjzLo85DCVJdcB+yCVunf7dGwwZlNSy?=
 =?us-ascii?Q?W/9RV6T3K0VH5smfM3AxBnNqVVAd1RbC7XHpk3QOWU57fiOAvQcKpflosaC/?=
 =?us-ascii?Q?VQeWqeyaa2DLvKPP8en4thOFPcfD7C4/OnkYLjYEjjGmfJydYNr3Gw5yTx+A?=
 =?us-ascii?Q?7epfwlW76GZJJIdkjco74M8iLGa2ozvnEtAm81YbHRNTY2/0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34eef6b7-697f-4afd-9907-08def6e4d588
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:39:43.0910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwnZkJ7xknn0KlzgT1yPeXuKcBV3meimtjX6ou0RMg/z3PGCx3YkdvjW5lnv3ncf5wLYJEW3XLoANqmP3rnhbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166

On Fri, Aug 07, 2026 at 03:52:41PM -0700, Borislav Petkov wrote:
> On Fri, Aug 07, 2026 at 04:26:59PM -0600, Jasjeet Rangi wrote:
> > mce_amd_handle_storm() currently does the opposite of what storm
> > handling needs: it enables threshold interrupts when a storm is detected
> > and disables them when the storm subsides.
> 
> the subside path:
> 
> printk_deferred(KERN_NOTICE "CPU%d BANK%d CMCI storm subsided\n", smp_processor_id(), mce->bank);
> mce_handle_storm(mce->bank, false);
> |->mce_amd_handle_storm(bank, on)
> |-> threshold_restart_bank(bank, on);
> |-> tr.b->interrupt_enable = false;
> 
> while that commit Fixes: 5c4663ed1eac ("x86/mce: Handle AMD threshold
> interrupt storms") says:
> 
>     Rather, disable the interrupt on the corresponding CPU and bank.
>     Re-enable back the interrupts if enough consecutive polls of the bank show no
>     corrected errors (30, as programmed by Intel).
> 
> Yap, I see it.
> 
> I'm not sure about your approach to change the bool meaning - "on" is fine at
> a first glance and this fix should be minimal so that it is more easily
> backportable to stable - but yap, looks like we're doing it wrong.
> 

I agree the fix should be minimal, but I like having more explicit
variable names for clarity. Maybe split this patch in two? First is the
minimal fix to backport, and second is the variable renaming.

In any case, this looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
