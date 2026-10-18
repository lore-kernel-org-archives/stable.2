Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A3943B4BF;
	Sun, 18 Oct 2026 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792362889; cv=fail; b=Aok/ugcGtqdqMkvT7Y5A3fcaXr6cFSjFi+lD3aCJ2vRQz4dw1/pbzr5poBPMaDTpY6uQIvQv4AEEKQ6EDd/gqJ14kgnlRlzHEe5OeGGbwZ5XZOeX/Ktg0UJKXpEKuwns7P266boRSPu3cBMV9fhlI3EuGCHbvJLl8rqdzObM27g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792362889; c=relaxed/simple;
	bh=3hpIDkD8DoO4ulR9InHd+sRHEqFqM67YDMlnoLRO9MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CyzN2KIEMFTSMHXP5jA0wZnewcZeCqUYGZx9LZCK8o7SnvheOQ3oUTpk15efzVn5tEq+i4c9o02DrtPALQvWPKFsaek6LAHMGc7qEIOhZbAmiTk4GrNyCBn9vWROIEOEgAVbUKeaZxgBKBC4Js+xlIDDmkKd421KtpDuWciJ32c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fS1qLaAg; arc=fail smtp.client-ip=52.101.53.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fS1qLaAg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdzRz/IBhsFn4oy1QFowaVJFrBxd/3ll92mvzAMLFTw5Oowd8W9sU651H4taYsmKSZs1mFXKEiI3ecREkNRXa9NcJZkX4SlqDPG6ZISjp6OTB6yKWB2FdRQBn4QReyKCSODtcw8OLnbOPELw5VpBmXfoZhPmI1CCf310xFDzGQUP4NHIiFYRQOvQwyPlhqWq5nIXpFKY0nK7m5k/1ADeCCPBAQZz8Dtt+OrI5nbyGzWPNLX14fTVK4yGg0Tpht19pqkl0s9MW0A+OORH1yXLRYRBEJnsDylSqSv8K+H3tD4dF17F4e+i8zbWXelrqipIp9OzcdH6QfGpxTTdODk+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4a4j2pNPnSXRX9dHxZuvvNjzRnRppdlNSC1SH42xuI8=;
 b=prrnKY0zDitWerHTVqwW786rm4oZ/1ZSPRbqw8FGrBjYCE7nQcg4Gn4Qo4tUdKv61ah7f8N75DxHZvt1zzs4OY8BxYR/p0x+0kjY2tlWDbrCDEN3OXp8RBUystCr5kVXpdR8IZsW92mHiwvrQuMNVXagKs1K7G0b7Nf0SmTcRlWUngd4wdj00JPuaR9DN5SaIIuW2jN1o4Z2vcwgRe3Apl6FFMoThsz2W7zEq5/raTogFqzOncWbWgLMRMVBYmvCj9sBSfq4P1vwOQB5X1kwYccpBYSrwjTp3romKIhKdX6lavjKdA/YycNfhUAPl/PT4Ov0spmLu6SryohC+Gl93Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4a4j2pNPnSXRX9dHxZuvvNjzRnRppdlNSC1SH42xuI8=;
 b=fS1qLaAgR7DE3gzU+NcnDFMRK34Zr3Bn2w8CEhYkkOwOGkzLJqRfV1FgHUOxEynCUgW+7m+iSXG1t/YfO8ITkcYRi5oppSSSMkmgmsr+UFtxZeF7aGAxqyVXrWTOQugw70NnEpEkO2/pnX02ZNMOgUoTBYEYnCVLVjV6rbiFX2M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 PH0PR12MB8776.namprd12.prod.outlook.com (2603:10b6:510:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 22:34:43 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%5]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 22:34:43 +0000
Date: Sun, 18 Oct 2026 18:34:31 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Guixiong Wei <weiguixiong@bytedance.com>,
	Tony Luck <tony.luck@intel.com>,
	Muralidhara M K <muralidhara.mk@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] EDAC/mce_amd: Add missing long names for SMCA bank types
Message-ID: <20261018223431.GA3236@yaz-khff2.amd.com>
References: <20261009020447.90758-2-weiguixiong@bytedance.com>
 <20261012140330.GC15198@yaz-khff2.amd.com>
 <20261017195145.GAatPR0dQVZGEMHglh@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017195145.GAatPR0dQVZGEMHglh@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0760.namprd03.prod.outlook.com
 (2603:10b6:408:13a::15) To DM4PR12MB6374.namprd12.prod.outlook.com
 (2603:10b6:8:a3::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|PH0PR12MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: ad943df3-7b20-4c69-4916-08df2d680114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	N4bE2rM0OL+Q9JhzrGg+9LJcFUp7BKS0QYSNKXvywQsmu2LGOJyC/LnB35IG2luEpb731RZQL0RrOpfGFC+WLdYqBdWj+onLvpKDVUhjVAHUcCvsu1Zvm0CjoJP01nZ4Bh4F8yltx9JGUDj2SJMHTzhL66YUrf+kOq7QVvG9uWDu0QsjGhEiYVpqZtQqIxE5F1E45BZIX5c+esrPPPhDC+6PPV6jriV6LIY44O9UMkcTStk34TfE+6Z/ANBBqBwmlTzv0D50Jyj/kkt8iILi3bWImRXVSEUlY0AbzixFYiXd77UDPaSBS5uQdDRWcFoOJ7IOD/h4FxRZHXoX2YBlBYtme9EDt7oN/5naLmKZ4P1dc6FJyHifEFG0HMK5OBdxWGHF28PCPCDlcidM8f9HfcJdrvthHUnm9K93AsQQDkUswC4vS2OIK7B9cM5LenQ3AR2n7jxQ73CZi8lro9Ti3yjYNBvTBVC+zGeeSkwonqEI9a/zj/1CPsXshRJ8S7AxZzp5/1CnwpZbYLLmdG+IMSanUvD9BeEI5UzEcykIhINPmsJc1lrdfvRQxJ5ra5mxHQpYa3L16FNZgrUVAGWVqKbAFuZBIV+umcxE4vxbHP97yxDzT5g70YnFKBgWKuG30iIvQ0JIcbvMUEmhhn8U25Mk8ZcywmnU7roiS/Z6jn4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4uePBsuLb9TkB9DsuRg7KVAPGwsKKyybLwCoL+ONXESA/3HXD8tEFZnGH1/V?=
 =?us-ascii?Q?+dFp3WrPzgIxoGIvb2rEbg+70c58NEW9ugMyzPQi8UdaY2Tc8dsco7C2zYpW?=
 =?us-ascii?Q?DzZ8ZNikwCRn1ihvIOb0uSrcUwo5Gtrf4XFEINEYW/pyxT5puI9PIQdzdBuq?=
 =?us-ascii?Q?Wuu5YcfMe/os9xTtSB1auknlOt/q+cSX4+j+s3STjK4MvJ0alfLXZP+sTEU3?=
 =?us-ascii?Q?YbCGTQRiZXJNa/HPmX49hMGz8kz2TPKiMhf2LGfN+Xdz6sybcchwv9Ro8Njx?=
 =?us-ascii?Q?CmVEka2WUHwVcR/zWcxQUAXjv9kY0JLUr+RO530MrGpk+/H5hO2fbXmeh8eY?=
 =?us-ascii?Q?rq3QMnii9lm9mmQEawmScURcL6K3QHqs64ZB2kG+/gBn7jQ/iYRDl0+QPHxP?=
 =?us-ascii?Q?QqBBkotzXm+pdzzOszD5pZmj5fKkYA+/xpE6zGXl9zof1/Pj1sidWu/Yp7eJ?=
 =?us-ascii?Q?TlsXdrY7FDCJXT8ncILxlC2zQO9ok7Tld7JI1hdsv8B0ELLkuKSHmjHPjbyN?=
 =?us-ascii?Q?6NF3KkPT3WKbTZi1BTA+qVfOwrMRzU0z+fMCzdigPonWE/dSc5DrH7becACq?=
 =?us-ascii?Q?A0Fde0/nYGfAINgwlgaxU1oA6+AMUkSxRLKBFS/CfBM5HWEJsfsDkkfH/WpX?=
 =?us-ascii?Q?mhaGaw7l27+CG9JSYL0TksCbnul+He1R8nohc59A2KULoB1drGCrEyi49jnx?=
 =?us-ascii?Q?owYqloKxEUr3P9dBhiGLOGuTMZRmw3nSpESSBJTHX/NKBlwjIF4R5G7PbXfy?=
 =?us-ascii?Q?bT2IffWY3NGmACSNcLgOFY/6zu//KD9bWPeOvnLjhypay6lZ9orILpQTIogq?=
 =?us-ascii?Q?Oxq3e2y1H6uAJ+V5paZVsXM5fzzSoDGE1wdXSGGMIikZId7gF7DkJ5lkTFYj?=
 =?us-ascii?Q?dXDax3+HlHJ/nC0NpXmXGx84drlBL0QgPn9kvyiy1eZOGBIHfqPe5MAknbuZ?=
 =?us-ascii?Q?mXMHUA7KOHru/zpAx5k9LcHrwGhCU+v9KOAJByzxv99Cjdo75Q1BMmtaMlU1?=
 =?us-ascii?Q?S3rnUnG/5F/veu46dBNxgKJV8kpQDBsLiKtoIsbTk/lacAXbuV91jYecI89H?=
 =?us-ascii?Q?Hig0AHbgsYLUw3+TgSvxLklIyQ+OOsm13AzrUJdK79wxnhISUYy7v48TeYsJ?=
 =?us-ascii?Q?X/ZGP71cXMXjUGUFrF1SNzbb031JP7hTsHxR0SBmFFgTuFbOPw2KktcS4M/l?=
 =?us-ascii?Q?GANXzXzWulZrQyw8VT2QgAdyd9YISLLtqBFmWQTFurHSCVOONX4wgGIKrwgh?=
 =?us-ascii?Q?Cy5hnTw+HkjjD7cVaC1nXFyhCezMZWtfuNnEh3xor7Ftsf2MsmuaXVC8LiIh?=
 =?us-ascii?Q?K0XgcoXfOHznoDLUXmXB9GpNEjxRxRUMLtAdUkB/Od0glSFwTP6KS7xkl4p/?=
 =?us-ascii?Q?ghiNjznxM/aCEUuwuhxs/qweQ55XTB2qbbOcoRxVbJZYSsF6Yo3nRD3zKefT?=
 =?us-ascii?Q?NcGpgizXHblg7mCsqy7uPfXqmcM2JvUljD6QYeBxEoknzB4PUqiIj43uYnyI?=
 =?us-ascii?Q?0iFroTuVY4wfYce+XZgZyTpaRyJmXkoZ/CN3mAzD8/GNeRlgyR3ZhBcbC7Dd?=
 =?us-ascii?Q?keDmPKXugCbdbpDkeFL6h1R2KUB9GRnx+SzhitWUJ1hmQKDZgTVmm3cMndBG?=
 =?us-ascii?Q?pvrzZAAA9H0pGjemCKF/lFXon3THfPjkmoKRTBLnyfWyKxO3x2+piEeV26+y?=
 =?us-ascii?Q?ShPYflfWBwFlscSEyha9t97W2wkjPtK8YcbQuxvf9yYmUIXJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad943df3-7b20-4c69-4916-08df2d680114
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 22:34:43.0061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivJ2nItBCGsA0zw4j9KBVvmB+3CSZJ/W79NaM2vzbPBLZbHLGv/DOCxE1fIBTe0w9CVbQ07QRyWf0e+XHY4OWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8776

On Sat, Oct 17, 2026 at 12:51:45PM -0700, Borislav Petkov wrote:
> On Mon, Oct 12, 2026 at 10:03:30AM -0400, Yazen Ghannam wrote:
> > These were intentionaly left out as it as it seems users have been
> > moving to user space decode tools.
> 
> You're making the old mistake:
> 
> a. a naked MCE record in dmesg, you have to open the PPRs and actually decode
> it by hand. Or use a tool but most of the time, that tool is not updated with
> the latest error definitions, and you need the exact machine info in order for
> the tool to decode properly, yadda yadda...
> 
> b. Get a fully decoded error string in dmesg.
> 
> What is better: a) or b) ?
> 

"a" is better.

The same "is not updated with the latest error definitions" applies to
the kernel.

And it's usually easier to update tools than patch the kernel (and also
deal with backporting, etc.).

In any case, this patch isn't about error descriptions. It's only about
adding the names for some bank types.

The bank types were added three years ago. AFAIK, the missing names
haven't been an issue. So I'm curious if this patch is actually fixing a
problem. If so, then that's fine.

Thanks,
Yazen


