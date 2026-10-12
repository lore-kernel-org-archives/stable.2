Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B79A2EEE84;
	Mon, 12 Oct 2026 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813820; cv=fail; b=BHhnF4vV+U7jnQAKYPCm4dSF4qiiKvWncAoB5mu8wrfO0VN4MgPPLRYWTOOZ24IkMKzz2K0w3tCQ4I5rlOUIB/VtNVoMHvB64NYJ4u6rJ2QIX0ZeQSF3yesO8oXU6b8gXqOKZjZy1FdiT61huZ2agCy6FvKru5/9nFsglBLZS24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813820; c=relaxed/simple;
	bh=Sf3NyC4utg+WA42v9Iu1S6/fzOLEc0OuPMISPhFehBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NOUZ0GQb3uglyqG+Pnhf06A5PTCZvDYXCBqJG6Jya/giG/KYqQ9uL/bSIblohVgmKyFFn7/0FWajfyMfUDinYMjXK9YJlv5kgVZG6f95sgM2uS4HF8g9V74EQfzdSIaXa2Cg1xeBZADoy+zDzv47iOgERJ1MGxbJyeNnaDLk234=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ycPAjL6Z; arc=fail smtp.client-ip=40.107.208.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ycPAjL6Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsEy12tOMiLc3/oFuHQ787ZAhg7QjqO/5luqYidlAvrHFugRvru1yFsk2bDCIYSdln8+32mw9oXI+Os8FjMJf51LBjr9l+hFIUVUh0AK1G6gpLaQ+TN2ZuL390hbMbYiFdnH+v5ix/3pwWb1aj4ijdQc9S1rjw3RarMmmJwCBIkSVIiMgCYS0u5IwA7alcGXuWPiJg4Zd0/wgirCmppSP8yaDEJuT38dHHkBizkRvlaP0i6c2ykoK30NKI336vpfvb0DeHaWdHgaOqqf/gDcQMG9949J87Yf0gHOA86J/08HhbiLNQ3VQlNYu/Jgmlg1y+1CPJMm3cl+IQtfOQ0VKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7UbVhy0DuBrIMMPzuccw3hDjIHxmiSxQ3h16HdHNdw=;
 b=w7ZmtzVg1XnbukvRj5ZcrFC7wkSD9UcIaEJYZhZeHUh9vQ5whsxS5YwtLJ9xN9JvG7cZhGf8SrXmfQV28SIEk/iBLRlwqxzjaT4CJHVV5jVU58NB8hD87VD97dVKR8078k13CvPxpW6U+hTm9/ru/Hqsp0pXppggck53VQq/ymtyea2zIJNEANPPjR1PI1eZRWVBHe6dueHWMcRJ0R+0Aj5/6gQ1HSh9fPiThVLpjXCEX75UDPLJi/zRHZU/WFrX64mDtmMpniPJPPJ4ZDr4T/Rpv7Fmu3T57DHu3xJl5yG2jlSnCNuNxc28oTd99P+oz65b3ELCwsZ80QrBoRA/Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7UbVhy0DuBrIMMPzuccw3hDjIHxmiSxQ3h16HdHNdw=;
 b=ycPAjL6Zoco0aavVNR+6B7wr1FjsRKMTCpXMpPUXH+AnPeECSBsW2Y+zGejp6BEQs5rbe896xEpL1CMmAkU9QcgphkC87+wpO3hjhnwFDFHeW0aEVMx0VxTOBDzvcvkXkI+kwiB0FwemJyP/f5yOqLJ6Q+AZ7fGhR8l1EB2i0jY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 DS0PR12MB9345.namprd12.prod.outlook.com (2603:10b6:8:1a9::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.17; Mon, 12 Oct 2026 14:03:35 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 14:03:35 +0000
Date: Mon, 12 Oct 2026 10:03:30 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Guixiong Wei <weiguixiong@bytedance.com>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	Muralidhara M K <muralidhara.mk@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] EDAC/mce_amd: Add missing long names for SMCA bank types
Message-ID: <20261012140330.GC15198@yaz-khff2.amd.com>
References: <20261009020447.90758-2-weiguixiong@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009020447.90758-2-weiguixiong@bytedance.com>
X-ClientProxiedBy: MN2PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:208:234::23) To DM4PR12MB6374.namprd12.prod.outlook.com
 (2603:10b6:8:a3::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|DS0PR12MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f21709-c4dc-4618-d694-08df28699b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|10067099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+gQG0OTk93ZbEcQXKLyLNT+l/xTdlupInFgao6086KrteUBGSy7CjQCGyAHnUYjfAIFNxAislUKrrbqsxLYzDUj/3Rcw4p15oMEueTbIjWsOgskFUrVMXBjjjxz/R6gbOQhITGkHcz0xejAW4PHzv9QFGUk3V3uxxb3OfZOfDqIx5fp5zCWlWF0AswcpilZ/NM4R+HxxJ+MMaEwJKJRzBYVMZZEqdt6aQMumyTmqhIv76XldeKXnss6eQKMyCiCydklAZc8DZ2povHeB8rlqlsOqDQKe/P6kaZKUe4ptrco/ReipUD0F6M9D6kEWj0Za1a9dbfzVe6kZ6xOwh/+B+4IktNkVISK2Wf+g6/qe+woohqy+osiQtkqI9pAE4Cyc1jAdViz3+dtsyQMNlEaZo31d89zD8sG6j68Ia/zSEBzWWcPXtO2lgUKCOxSQ3rTYMomGmzJl/Nm4masKSPVUyluqUnozB22yi2zj4A1nc+abqyTOjLx0vIL81Z+19BynkZp4OLJCrf4KKXXO5h8sfvU4Bpt71Jh4U4triy7utTzxH+qeKw9sLxNgaW+jTVo/YDPR7kr5qbJnwt/o1CVDJYKE7k8CbXuMVJCrxV3FuQWVmYPQCI7zV73nukuXZaU/zq3C/FCMVHiQNqTBZlGSlHE4DnMXYz8KGA7aUQYZLnU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HnC2NdorGDnNuiyBRV260lTIIu/FncUS0g06+Y8cKQGXMZlsLrBE42Sl98Ue?=
 =?us-ascii?Q?ePOw7IG0310/TmH+4Qd7jGYdIHnmOGFciJdqZmQ2ehnaCG7X5LqxMDc6nXWu?=
 =?us-ascii?Q?fuxQU3yj7IMzD4PSEHAQRjM3O4vhFBa4y7vKSLBJ20we8dg2t4NoVZqbQDRp?=
 =?us-ascii?Q?6gV0qE7zlvm2cJqAK4FSQNVMmyZC/MAgpYQmmMQzzwRV8f4lXeGZO3WjrZNF?=
 =?us-ascii?Q?aLv+vo0kabua0OFFrHkea1/BjMIxY+cnyGG+ix29ky5rOqwvM/EJMRZPRJlR?=
 =?us-ascii?Q?FD1E1fxZOlu48lSi10HSJGI0AY1N5wKgoIEtlqJC0a0qYJH2uWidxJei/Ni0?=
 =?us-ascii?Q?p3+CpmN3Ieyq6cIzk6cuuuph1yHxsL+GdXsC1igOhaXrK2cf96JAi24C64T3?=
 =?us-ascii?Q?24gcPGFdfMT3MqY5cDIxqcOPkjqSnN0rqDzyR4fJyQgq6jzY/piM0bSM2/S/?=
 =?us-ascii?Q?bI8XG+gyJuCBGA2ipkccW2VoEdoFsztPnbc6iSlnzMpE0yGbXaHev9xDdgHv?=
 =?us-ascii?Q?GQRDbxVcsGjYjysHKmhIv4lXg+HW/d/vMyuN9vUlzazh9Wy83RS2eZJKmv64?=
 =?us-ascii?Q?kcGb3lodAoz5HlNONkr/L2G297t7RdjVjMIeNQT2EX0keFaj7Pk5i2uP1EB3?=
 =?us-ascii?Q?sEaKgPYElWlZIb6EdpQaBvxknorQDBwXudngHDz25CtfDR/SG1yxrJMcGnpM?=
 =?us-ascii?Q?2GntBNnOm+WTWbErcGMILGAclagT+QMK6UCdU98BTx9Lmyez33h6c7U7SwSW?=
 =?us-ascii?Q?C8ejK1qM7+E9Xm8WUX5Nr6iFhtt+b7MI5D2fzb9y6XPgO/iasKj9zcL015eY?=
 =?us-ascii?Q?q8d/xJSlOpGALz5FiPUF6wWIUq0yad1sLk8dh1VXk9LVymUY5tVXhxxWTPDd?=
 =?us-ascii?Q?r9LWwriOG7p4kRFkMGxgdSXHC2Nio7sQeyvJiF3w4zsX+NpaBAZelUSK7bc8?=
 =?us-ascii?Q?wml2m6I09Xdq6KNQQkVkPpedt52T4zrIImMCVG8xSWQK7mcr3pgkWDnFiHt/?=
 =?us-ascii?Q?CpiqBsLfoVEoX1Cv39wxTzFT9Tk3H9l4VjGvMuMhDobXOMh+83vtApJr0szy?=
 =?us-ascii?Q?E+8sJHntndVcCu/j+9iE5kA1LSG0iJ7Fba8oetR+Ao9W5DK2MyOyNoSA9rR6?=
 =?us-ascii?Q?7buMhW2AFgpYRrf2ZncTp2NJ3EVjrPLCz0ERX1UhlFQzpB8vVPOx9N/HHWLE?=
 =?us-ascii?Q?pqzP9Im/cCmbvAeAzuGnL5CmmrMjeT9N9v2W49mFN9L4gZNNfbR7nad+gSTC?=
 =?us-ascii?Q?OuOQaT0x4v47cXnEqmBmtXcciibmK20LUF4E6WV/4Ja00WmmnHFCwPcljRL+?=
 =?us-ascii?Q?/oYotww7GIQMW7+XWC2Q7WmKdBFo2hPBAW50VWwcViN29BhpZwylUKi+ssbo?=
 =?us-ascii?Q?h1S9jsC8u6cK1GqJ8WbsV94LpTBvVEGKP0cZA7rU+/vdNfWdf9auqpdR77f9?=
 =?us-ascii?Q?8PBx4veEBP0Deqp3ZxhNVnTJbpkOvOqPbwclO9Xnk4OQl780nJfLeVe5S1Jn?=
 =?us-ascii?Q?W9KiWDm0mlOVH/NO98qXVMnvxXD880aGS9Uhq8x6LRcX5Ys7wYL7/HGUEe+/?=
 =?us-ascii?Q?4Y8pwZTl/60f53a7GoAEjUknJ+Tdmby6GEgnibRO4cZhGxZ0u30SVuiAYrFr?=
 =?us-ascii?Q?rKaHTOPMoBxKNW+ct3vxfGcxSvLxpKK/1fXpAdt37NRiwCuD5OffNItKx2pj?=
 =?us-ascii?Q?Nt0e/sfNI/ErqEOEvOi4eK4ytVkw0x0r6YQw7fVIB8paW579?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f21709-c4dc-4618-d694-08df28699b4a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 14:03:35.4022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHPVQBIfLV/pIezaLaMPRGrXEnqBpS9fWQOcwfpxz9IVcdgqNX2ofqX7IKVX8TO3xwiYiUg+jF2CY+zexPh2mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9345

On Fri, Oct 09, 2026 at 10:04:24AM +0800, Guixiong Wei wrote:
> Commit 47b744ea5e3c ("x86/MCE/AMD: Add new MA_LLC, USR_DP,
> and USR_CP bank types") added three SMCA bank types after the bank long
> names had been moved to the MCE decoder.
> 
> The new types were added to the enum, short-name table, and HWID/McaType
> mapping, but not to smca_long_names[]. As a result, an error from any of
> these banks is logged with "(null)" in place of the bank name.
> 
> Add the missing long names.
> 
> Fixes: 47b744ea5e3c ("x86/MCE/AMD: Add new MA_LLC, USR_DP, and USR_CP bank types")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>

These were intentionaly left out as it as it seems users have been
moving to user space decode tools.

Do you actually need these in the kernel?

Thanks,
Yazen
