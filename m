Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012070.outbound.protection.outlook.com [40.93.195.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776D8400969;
	Mon, 28 Sep 2026 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628398; cv=fail; b=tWaPtZhBj0lcYMhPE0rstzyM32HDFKez3ICn7ZKOCt13ac1U5KUmoj39V7mEhKFAXjDYaeWKg3ucOlRvC2wFMHlkXuwIyWwG9XzJYDaBpw37yKLKE+VZ0YRXr3AYB1o9U2RnoOXk59cJJaiQU3vJeyZK56NCLDdZw3Fru9b+lEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628398; c=relaxed/simple;
	bh=hySiF3cUOfEC2eDggKwp125Jz6QO0F9zXjKwQAMv91Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Iw3fzq85hwW8Kgkbv5AL+Do3pfKGytgjB7ti3ptfumDYK2mOg/I6VYGY3ID8cPi25Qygswbd4vvGc+lu9PwCE6J/y0c4R58dQnIEGzDyFkty+zXDvVntvsxyi+0rutZ9wCkxTGaikOYilT4cMK5LZrDCwf/qBcj5sv9qLsGEr9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WZGNMejd; arc=fail smtp.client-ip=40.93.195.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WZGNMejd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBi90x3cNZWQ2tAcV4CVceRliboHNbxE9F/JqQxrgmmu92faWSwkfqAsbD0aP/g6nYBCc0iyHntX4SUiazeFSSDgO2ECQTZYO6YtcLtICIHjMiRtJ63UrtGSDBrObY6IoYPbPRUmrnIctulQVoBQ0yVOmFisVrFxaSxB/JwbeBy/aff5kk8DSAck2XVr+Tg/wF7gAGUlAq/OxotAsH2a33dhmli1ehRTJMgO3outjxCp/IXy1/Z1iz39uQPPqckDgpDrxtpz0S5OMZdvPpnc1SWhDKEC5I8n9Y3q0nYpHAMEKkTHD8Er74/KgpxmIp17YljL2mQBdBgABlJOwzGfAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZr910n+5PZS63a3wrHhpk3W5icCUEN1A3iMhrYlzu0=;
 b=SfVVJFne9IaUVRc+ci8e32voVWFZYSwWt1/FQF/VdoGddbC/2og5GvPIKbJmxeH8ajsNifGXFTASYyzS94zgq0on51HEcU9+EYWemg3gRxy5qKaZ2fUI1v5sVswv6mOaWLt738GhQaNU68zrQJSELx6iLhRmZc//fppruRhradZ1nUzKPiOWX34pBjGP5ZXdqPznUvLCQFPCN3uiB0y5dEdtka2kVK/OCvLIeH+ln0H7nlQtTFxfhRiwYvwr4/xfXbhHLPot5UFDCtBlatIex+J4KvBliCEVpEiS+ZzSHqB1AHfymM5w//IZ3sZvCXg9TCApg09V7vHNfdVmjWv6PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZr910n+5PZS63a3wrHhpk3W5icCUEN1A3iMhrYlzu0=;
 b=WZGNMejdEMDh/wLH4X0mp6KH2ySgzd3difDjS1COoT116y0bQ8/9gQ9AVVdsxhfpzBQek0Lkhpb9l0AcU9Pg0sdbTRmcgp8cgRrdVzteJTltODjRfYDQxiNIP8R/fEuJzTvxQO9WRQ0PzVXLeQehfdD46Q9GT3pU6zo7v8yz3xk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 IA0PR12MB8929.namprd12.prod.outlook.com (2603:10b6:208:484::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.23; Mon, 28 Sep 2026 20:46:30 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 20:46:29 +0000
Date: Mon, 28 Sep 2026 16:46:20 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Vishal Badole <Vishal.Badole@amd.com>
Cc: bp@alien8.de, tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] EDAC/amd64: Mask UMC chip select to the four
 implemented selects
Message-ID: <20260928204620.GE2289128@yaz-khff2.amd.com>
References: <20260928180935.472319-1-Vishal.Badole@amd.com>
 <20260928180935.472319-2-Vishal.Badole@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928180935.472319-2-Vishal.Badole@amd.com>
X-ClientProxiedBy: BN9P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::7) To DM4PR12MB6374.namprd12.prod.outlook.com
 (2603:10b6:8:a3::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|IA0PR12MB8929:EE_
X-MS-Office365-Filtering-Correlation-Id: f36dd8cd-6c73-4154-9e57-08df1da1928d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|4143699003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tibWAfsTNqkB5B8M5y1UEdl09K98CS3ZiydGYaUjqMCfiPfLhZSfwtQYpHarpF4A+qtAzd+RSYXhVaXTPHnQCVDxEtAsS5U/OG7pQMlIth6DkB4ATgW2yaDNXbQW1M0+NAlihgSPjB2659os7z418RLaYs/cVdcKE+fGMx+gdnvhLoE7JI5xzaufpitff8cgJ7AAea/1kdc7vb9duAMz9YiuOBG3/KEhCkIrWUCOLcbTYXRDPjMhms/9mVrWn1bEXUWVRsuutHoE3qau0YoQZ6qEvrpbAkKOK2dJg+UDCqzZcnAEMrIcamBtPiuhOf3QMCYLyZrmJLgwWtILnYw/cgV5i083fCkY/k6plIOk3KS/trfvqxGf8jM+ObsK57Om9kewrHSoE419pC3BlCCSgmykvLHb1DxLwe5vG1PD5o2auC3h8MVeki2+2VG1qa8w5IfHkWUe9ySXZn2drlW+S1wHv4RbC0cfJHQosXQY+ZTg243+inYGcNmXAk/7GGDMTlgGf11bfr7w+LCCGeKFoZPsO8alMvhw5S169B6WglPJq8TUPsCrrkNFZvk55c7COVUx63JeKJc9Aic4TfdE69rodudZ3bezFDGDiUqDK7vAksvGcWJ9fz5xCyLIu4ETOEWHQw6bGGGEvo4L9zHT5H7ZN+HNUz77ojtux4TVHIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(4143699003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?86l4TikYjnkU2RZeb1g87XQTVefG2mGZBKkUtJ56u/sTh78NMYEIE3jxGLex?=
 =?us-ascii?Q?qTz734V3RXi0b4Z/doiFiG/i3KVhhMC2oZXtsLpdDCOnK8CVBtXW4X363P8u?=
 =?us-ascii?Q?9KwLSzQXMIe7mP4Xi3TBT2/UDfdL+7OtzUJEVo0fQ0HZlvApLpXSFLX8XWMo?=
 =?us-ascii?Q?3DntEtLAuLLUMl287Teu3crxmqyGvQmHNWrRORRJ/UHWPGrzVzd2iMdx63eX?=
 =?us-ascii?Q?rPG3mGt46oWhlrN21p1C9fnOPp+D7++oPONjZiY5wNQeXgtkJnnOdT/9xxJ5?=
 =?us-ascii?Q?gE+aTlFac48Y8GNHj2XjkGh/1T62/CaW2b41hX1VUp2SBHic4N5cfkOZLt41?=
 =?us-ascii?Q?oWr2y4Ie6OY4/9je27A6vBYVUKdcpvctZF1nZeSEjJgNSk++BXXerEpH10Z5?=
 =?us-ascii?Q?MWxHyogWYxmaUozYfuhdeFaAOpgJ//aXC3+233giy5RlMGQLrJ4jwPFVYKcu?=
 =?us-ascii?Q?Kn3cfFrDZjAvC1VSVvxs+dEzutShYDPxh1GEGevCIcYO9c87Jseeg9R57G2u?=
 =?us-ascii?Q?YeYki7Dc4H7uAoPY4ckTIwZq/uhLqzXJahxgu9wldMrjjn8ueeiunPno25jS?=
 =?us-ascii?Q?sXlim6YMi/GUWQMQbNjT7oh719NWbFylNgZX5vQM69iBWI1MMhSZF66NCsy/?=
 =?us-ascii?Q?MmlNan8nIBllkaXCCw1g/RxILBueUQO/3fLcZbJ2Nncx0yv/9h2DQuMyVy+1?=
 =?us-ascii?Q?6zFGVt3QrlUvFMWbTx/wKlVWK8glP1BVL0+DSeC6rIrv1eHHUS2G3COSQWCC?=
 =?us-ascii?Q?wYeKPXGmC94x3yBmv5gUt3/COFI+t61rT0VtCuum+lv6Q+FI5BPGh7lVqCkT?=
 =?us-ascii?Q?uD9US+RKCuOtMyoebzZcZySwuGE9wxtUAPyPq7TJsz5foHrY9l0BLX8CcWmv?=
 =?us-ascii?Q?Qg7SmEmzNMom+Hx0R03LJeoJ4uunkKzjiREFVUgRfq4opgmNhdXlFECVWlVm?=
 =?us-ascii?Q?q1ZIbu/ejI2SvU+0SY4EQjNP/Cw4N0tei8gI1mGc+jNGX37drm9/ZyQbtue0?=
 =?us-ascii?Q?onWX+hlFmJqybSZzpc3T+hbxqFGB7GsUZqAaiF6F7tk+/LB3M0b+9nvHnYRk?=
 =?us-ascii?Q?VRDHaxXfyIVGv4pL31Ej7aRRMHACRULxEfH2voaH3dw6dNRIJp8ALwnxcC+b?=
 =?us-ascii?Q?oVkofrRSycJeiYozFCJEBz4yqXqJCd3U3/iw+8OufaJ1lVkQdeC/O+6aDCob?=
 =?us-ascii?Q?H6WZ6UKSuFZcwfvvOgFfHQ8cak+h4wZ1k/I/1uvv+3EMcZhzpgXHfc105GGO?=
 =?us-ascii?Q?dLsl+BQfsAlXK7l1K2BCFVCUKdYsjrlxBT0G0l4lH7mk7QGF7/u0TabUYwt0?=
 =?us-ascii?Q?Txx2oZhV3zjGw5hX2JBMuc5ZAR33JOLMqUQgNd7wQT//Sy6DkRS9AjH8d4Q1?=
 =?us-ascii?Q?Ekup+lTDE2JwiZvuEfAfTz/T9+uqJLD8X7ntTWjJIa+6PGfJ0RaQJAIyLlxk?=
 =?us-ascii?Q?YMW5CPYu7i1qvOsd2ha4dFNdxWo/cYEmT/oOqg5/cNpG2hGCnE3Xi98JXHKD?=
 =?us-ascii?Q?AHiS7aMSWcsc+7ZrzM81JfDmOYT6C0p9od248StH5HdafJZ1T12byGCkqtMl?=
 =?us-ascii?Q?vp2u+d4apspAq/zu8n1ujPOc8mdbAYPA6Yy++fDVMvOQvzNEXU9rIS/oOvkj?=
 =?us-ascii?Q?0nQtar/AIG8eMxhOvDR1wvzWYPJ0Q31e0ZA/oTGC5ySNhlTH5exQaEAwvyzq?=
 =?us-ascii?Q?+ZVU9I78h5MSLtKbRPWPCmYww/w5FR2tq+KyJ/LkxhAKDm42?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36dd8cd-6c73-4154-9e57-08df1da1928d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 20:46:29.7297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/6/fz3G5e5VpiTlQjg1dbKOnfpF+QIl654KWvnAAjnfDbJapeQHnnA4fkQe2Wwf0FPw7Rp8rDxJGb6Ky92vCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8929

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

Here's an alternate commit message. Hopefully, this clears up some of
the points from Boris in the other thread.

Thanks,
Yazen

=======================================

For DRAM ECC errors, the chip select value can be found in the
MCA_SYND[ErrorInformation] field.

ErrorInformation[2:0] was first documented in Zen1. The 3 bit field
implied that up to 8 chip selects may be used.

However, all Zen-based systems have only ever had up to 4 chip selects.
So only bits [1:0] would contain a valid chip select value.

Future systems are redefining the field to ErrorInformation[1:0]. This
matches the existing 'up to 4 chip selects' implementations. And it
frees up the extra bit for other decoding.

Change the current chip select mask from 0x7 to 0x3 to prepare for the
decode change.

