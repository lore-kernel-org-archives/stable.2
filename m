Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794439678;
	b=JDG7lSYDo0lBHSp2QKiajEFRPbGr+wKHnPJp5caNYg+qvU5jJ1ec2xVwsrgML+/0rNFT
	 868S/bLvAyEWhHoCmpk5NoU67tDsNmocDf2fVKWZ6x0LWy8JwUguR0nTxmBHU5LEEzgCB
	 1CkZPljCr04CEXqVxjNL2FmT9874zUCcKGAj63MCkCFro8UJI5l3s9jF+Off3gAqVsX2Y
	 HU+pugN5IIyNBsgE24ZK1y7D869yjc9de1IWTZrdLK1MtsrnFxhwK9kxltSqGQV+2SSJa
	 XNwzo5jxIiLIrKKOArgWMX7TGgASxr5i9M6tg/XdkrkPlDQv5+hpF9115tBp588Ci3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439678;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Bh+ZnxraQ3G3T+vVM5JLplE4LMUzQtSBUeMRT7CU/2U=;
	b=qOW1H6pCngsQrsD9jadTsY47b4qa4e6vicPibwTszRLaGbwdT87xTcpQLr659UcWb280
	 sPPbgi/IPyyneBHHdX55G0Cvcn1L68qVG2cIkPGIps0leg2iUigt0UESxXfMsv5FRZo1d
	 /+tqxTMUex1A/+LP+euZZR+SjR7Cn6MmeBsWF9VIT3j2rO8mBZ407kzyw+RG3QhxiZ4wX
	 wfyz2/FFxdLTwZtlTe9dDXZGBMM2E6Ajq+Lv7ZggdCvSBQ6RgXNP+3NJ5e9iN3oXjwGoX
	 r6uuq5oQjYl8eJw3Re7dcFYmcegc2j3eVRY9Hy0IBQ9fz5xrYgBDBOH16FmB8Zp3GXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=knTk4bLX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.26
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013026.outbound.protection.outlook.com [40.93.196.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833CA606A32A;
	Wed, 11 Nov 2026 23:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 833CA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=knTk4bLX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neAici6RYKK6+DVuPl9V8fvdejLifujN+4fnZGXrnB+/zp4Ix2tNCZVpa1MnojNlJJBtDcamG7sJ4SDGK3B4rZA3t3RUuXuQMb33vLWAqhxmCUZcHIw2cz/mXfNw4wgGZXmzqJT8w9kCcc4oo5/zaAvHvMzlDRUhOGW+2NMR/EX6V+x6ywJ3+4G7AP5/3NZGd4kBbAYwfxnC/OJGBs7wC6CN52R3M3oIjWe/rw+RUjWsa7Ofw3iluo9VHfLspTj9oyfXnsKnewsSaz0PQpClG/z66V1caDF/4NyqIJQE8X2DMz+oe/IZTL712nRpThLbzOLXdkdMxQANvFN+yHTmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bh+ZnxraQ3G3T+vVM5JLplE4LMUzQtSBUeMRT7CU/2U=;
 b=npk2n8wgbuwxEK5QPqsUtoE3GOYukjo9R3DGSms7SoHSTsP+7km7lERqWu5v7hsmbNVPTaUHkMO2qC8pCY5mOCsBtXQDZNxVBPnfuoo9ghNWCBUAcv8JV+h84ys9krOEPRlhxRvA1X3QVx0aL+k+GaD9JLZUxQxTU0BP81FQRfHtUVjCFgkJB/FTVxHVQquu4+0v8IK4ePcZSpAjN9RoHV1XuarQkDRmh51h0Be6jfi9wBHrErMCCHILlzkjSzQ7pgH/D+xtj1XdMFoFsCmcnZMsjaRTmQqGEtkEBrG/2uiimiWOmIpJqmX/c6mk8yZ0g9nhRiPRq1ogkOPdaMBsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bh+ZnxraQ3G3T+vVM5JLplE4LMUzQtSBUeMRT7CU/2U=;
 b=knTk4bLXMzvjqV6lF2yn6MWyiHXlrTOu+JeAnlfXXEKWctNGxb/1PpBO2uxLJPxrl6YuwTD06z9058y63dyxOj5kxGsu/Sod7UlUlg8KoYqkzCAM4TnjhLyqHU/Z7uVh7e2qcoQjkR/l0g8Hi6BD4zqCKRyrFbUcmHLbdAlBbZV/GpHk9Ma4Ps3ccoyg+tjrwREhhaDH265oGT2UQi/vxr9HXi2cXRpWfLWs1ikOEF2koljayyWcODLnzwfktRZ63t2PFRufFKhctI9G7kMsavO1MvbHC4KY6aXVkuR6A+LdNTAPdk0qZqjH9iX8O/yK0n9BlB02ifUYg4s2WDuVDA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 by SN7PR12MB6929.namprd12.prod.outlook.com (2603:10b6:806:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 23:27:52 +0000
Received: from CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128]) by CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 23:27:52 +0000
Date: Thu, 12 Nov 2026 10:27:47 +1100
From: Balbir Singh <balbirs@nvidia.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 08/13] mm/migrate_device: fix ksmd oops on a migrated KSM
 page
Message-ID: <avT4x2Su8vUp68E9@parvat>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-8-3d2454362e8d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-8-3d2454362e8d@kernel.org>
X-ClientProxiedBy: MEVP282CA0024.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:200::7) To CH3PR12MB9730.namprd12.prod.outlook.com
 (2603:10b6:610:253::9)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9730:EE_|SN7PR12MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce8285c-e060-47ee-4cd9-08df404b67d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|18002099003|22082099003|4143699003|11063799006|261026121527099003|261009223027099003|56012099006|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	1VKF0kAVlcLJv/Bcsvb2X5+G3DKXSiTJkQ/EfO17TsQUWGrtmskqfPNZCHScEN/bhfuTKiqW4UlrnGyn2YbybNAXxPwGEYrTtMOgPuscElAFvTsVg92oy2WL+cPPCLLbDmDNMCkWXfqSD9po8xRh90WE9dAL1lXuLZ8Dy5A1Y4EalAQZgE8Td5u9BfTqQW0bMbZ/UfZk60b6pXZZCqFpvcTDeLC1sogRFzJ3iynGBv2ezVow/EfUZrOuBo807dvtfyLKwE4BD5CLt/vLBm6O9iT5pqlqRX5DEDwVhjSuY3keaDRIVeJyfMRkr/L9qdurMLF7VkLPuay14zK2rZ8bgnRSVBpuZOr5MGNcCHQyDKlQMCnu1PkXZZYQxiUZo4ZxPZd9sLv5fhaNtM2YNvQSMcEfpYmPmbLWjUD9CNQ0JOtbFbUAuLj7olxVApfgXKDiBUT2zgGvLIALe1f6Cxq9h/Qjzd+IUMO9Dq3P1Id5XHLeHLuThZNSpsoLGj4nfimT+9pitOENgM2AzVspri6NYXiY8Wj8/yn38S8X2qKkFPCWmfL7i0QuHYCxMreyAug5/igOeVJPIebNdl4pxWt78Aqp/NcASYghWfBrVbXA0V+g68nVl4NQVFjX7Uhb3p9eB251hAIw5+gcLR2c/fDQqQNBxnBQtiXRD5NnYe7FQ2k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(261026121527099003)(261009223027099003)(56012099006)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fJmrZxY+7v2cKX4TowLnux3V8SsYeO5SuXMrlWLQZpNWn1x+wyRSN212xuNg?=
 =?us-ascii?Q?KXi1deJTK1o8nZDLkCC8dkpQULTU5t44jVQc2RnB7EjoX4LORMcG/wjJK8R3?=
 =?us-ascii?Q?ksQW+iMJroQK7m2EVY1jSOnYL8MEco8SmwS7SJ36bPWFJi/l7pL07Vs1uG6n?=
 =?us-ascii?Q?ZcH3dsebjD2N71a5mgJy3VDnMLdvRGicWDRuYv4Bwcf0Y9uqM18vTpw/HkvW?=
 =?us-ascii?Q?EzFEDATs76FdbrCi/Z+DLogKMpllg5w0FVlpY1T7qNQ8FEPt8SdF7/dufC7z?=
 =?us-ascii?Q?dw3bs94nyA86+TqTL3wemB09jTAvBlhABQt1i1FKWGSXG8kH7iePBgfVXzQ4?=
 =?us-ascii?Q?U1rm160yKCPyk89eJsUP/CglMXMJ0+ZLbWqAF2j49g78bRRWSyYeznK/Co1V?=
 =?us-ascii?Q?/a5TZMdA1QX3Si8O0D/fmDFB069zkDm1Y98p4iJh+RqHuqrzxZrXFtY+o/GF?=
 =?us-ascii?Q?oQLutlsP21ih/oBq2jtNnSfNAGFmNuIFGCgec8uu0kPtJ2109YP1wIJy36TU?=
 =?us-ascii?Q?LaHVh8o1xISiDYfSTMeO8xylzP+wNKXMgXi34CfmkGrbDucBD4NS3tlAcyTs?=
 =?us-ascii?Q?uqxErufU+qOSnRzs+J11eT58Gj4rLQ+fc2LCu4GXvQ+6BlPjPwlncrIgMUoI?=
 =?us-ascii?Q?JmsLuRJJsTqjXPJOCnCB6gAnA+5CwBqMjIDWI+5MiqzksqJ6ItT/glQkHfLj?=
 =?us-ascii?Q?ixuk0sVWXC4X+i0veynT7w8fRZr8mz3aHmGKnQ99Mfw/9/sKx3iR9+gLQfvT?=
 =?us-ascii?Q?24w7MdfJ5NEnoY4ALgsNF0+zaCN1qqSXe/AadWKiDRsVJ1XdgXHHBUuQgQhD?=
 =?us-ascii?Q?1jN++T7HVmkf1pacjucvtFG9Cql6D34TmOYH9u/D1VPZOWPmAJaCAi3pzQDJ?=
 =?us-ascii?Q?QK6J8n86y1tDXy4ZhUtD4ToRMEwyeRuxSoSLNzBmsnKYu/m3GgFI+5S2ar8I?=
 =?us-ascii?Q?kQ0JiV0NHajveA1cn0NvP7vwKSM4wVW1l3ShBs4hGLG3q1iT62DxXk/umM+y?=
 =?us-ascii?Q?B49o3ollUm1zpGgR3Dx16r3cDpDCGmZX8D5xkq7AHBMRl9LS0wgOKA7EF8g0?=
 =?us-ascii?Q?G1W/2lk70mW88JaNNa58qLxEyq4I6RuqShP+MwxXSG7qr1MLRQ0faa9DhTgs?=
 =?us-ascii?Q?XXBzISVgI4/md/ZghXaR3AdQ1cXgml7EmwtdS4wtunvv93HWqAPwnWy4wnp6?=
 =?us-ascii?Q?DKenP5hm6oruJYLD6p3FIvpKN5/kUFlECmlyY3FcVIZchibOaDHmOC5kx55J?=
 =?us-ascii?Q?kufA+2i9RgVB7wDZS5+QbyYhJO32wlqR0Kl8f2Pxa+L1FUBOOMm1WNhFcKXj?=
 =?us-ascii?Q?k9G+VNDyGtWcyS//5KC+1d+N/7MZV2UAdqTzL/hpfxVSDEcQJISyO5PB+ro+?=
 =?us-ascii?Q?XeXpdPyCbTHWnpVHS0HwKlryXYeX3nCj7jPwo/HhxAoR4FRuD9NGGLvsDpP7?=
 =?us-ascii?Q?LzyPKAZbq/BZGU/aOG6Py+P6p9og0TubSpuwdRITtb2FGx65ZXWAF8J5kmLa?=
 =?us-ascii?Q?5ireYXkssNRjqmzyQATqTYsIgdoYgdt3s0WKO4UAS09Tru6nARJ0yJEF/rvS?=
 =?us-ascii?Q?WHLhK2TkeGp0x2HRKE97iyjP869xEY5AThduqq0AUwmHEU3a26GRpD4exUYn?=
 =?us-ascii?Q?0Xmgp1ErRg1PCqmlOAMbTjh61j2puC52aUZixYTSzGVbPNQBIW4kUwIetlKj?=
 =?us-ascii?Q?9Nvhyi9bzTeJCAKKItSXDgjben2rOntWYa7d0jnEmWW9CVTQMaE7KTCuBU7a?=
 =?us-ascii?Q?KBUTDDyF4w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce8285c-e060-47ee-4cd9-08df404b67d7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 23:27:52.1773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHN9sGAvqYLtpFd6rSrn12I4PWSPdDzDc9E81VTIH5cGmj4WPUCaBzVty0s2CrlLR24NtgVuwQUn0wLcDLFnUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6929

On Wed, Nov 11, 2026 at 06:13:22PM +0000, Lorenzo Stoakes (ARM) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> After a KSM page is migrated to device private memory, ksmd can oops,
> and KSM then stops until reboot. A process that maps the page can also
> loop in page faults when it next accesses the page.
> 
> The problem arises because KSM doesn't know not to try to look at device
> private memory that does not exist in the direct map.
> 
> Disallow this from happening by explicitly testing for this scenario in
> __migrate_device_pages().
> 
> Fixes: a5430dda8a3a ("mm/migrate: support un-addressable ZONE_DEVICE page in migration")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: tweak commit message, comment ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/migrate_device.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 45e571dbfb4c..7ebd02ec303b 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -1205,6 +1205,15 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>  		}
>  
>  
> +		/*
> +		 * KSM doesn't know not to try to read device private pages, so
> +		 * disallow the combination.
> +		 */
> +		if (folio_is_device_private(newfolio) && folio_test_ksm(folio)) {
> +			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> +			goto next;
> +		}
> +
>  		if (folio_is_device_private(newfolio) ||
>  		    folio_is_device_coherent(newfolio)) {
>  			if (mapping) {
>

Given that we don't move device private ksm folios, I guess the check in
pin_anon_rmap() now applies only to device coherent folios.

I agree with the comment earlier about detecting this condition earlier.

Acked-by: Balbir Singh <balbirs@nvidia.com>
