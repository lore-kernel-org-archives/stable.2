Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204383264CF;
	Tue, 11 Aug 2026 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786434199; cv=fail; b=PM0XcfSW+0Ivn2toeEVprIBb0f78jWdFXDk7NQqtl02ikaYR+ghmz0auGj1aqvL0Y3LXOG3acEu/SIN+k7eCbFi8dNLbbiSYbVEgJ0wLm7MU/+M4G8gvfXFlndJloTohEgXNBi/iNuvjPJjKTH9jUuPBnpPC4pDw6mDbZFS3XWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786434199; c=relaxed/simple;
	bh=WCKh1AX8+pvflJ/o+QzBkQqMla4qQw7QY3OiZXN3T2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EvMtZEboG5QnFUrC+r67A15cG8MHyL3nXieMCnPefhXchGfMrwtvp5KeYS+Lm85BJrzSQCIXUo88GH4q/MI4miLsF8IIDLbeE12boC4FRS1JbYG0IQj29BYUdwC98Fm/kxRDf8eRMcMqXxFL6uFwMJMC0daFV5NHQZSOaBAPn9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Me6g63zZ; arc=fail smtp.client-ip=40.93.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Me6g63zZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0YstWMGlZaMe5ib/2qX6Cpi1PEWi5yXYn7pe7UEEfk7Z8lnSCE91lkgCOZHwZEQ9not9IMQYwgzn6IKt/TmKy6NpprfVcAHp234PJKfyrvnGXZh8dCZyeEdvBLUdxqSP7IJ3yrqwj7NyXztigrnCPmv2z45B8h12dQMzopI0FvmSitink6umET8NfCvSQm278BxKdmnIrB593PlMZCVfgnasIBkaIvOGwl8OjOx6aQAAk5vPSVqvfV88G9+nfrTz6eScFYHWKE0IowDKOBvA8GYduadP9BVI854phcEdjjCb0ujHTFY+VhAZzn5fsWMO8SXbm3AFbaaes7a25kgRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9fMxt0of9kci7kUSKdEiBkE9stpyefo0kuJ2RBAKYI=;
 b=d/5iB+MJ87c8IGl817cjR36iV2Cr6SToLQCrLST24B2rml7R/IHSgklVeYj2N2NNLWiHJO1QT/YDR2WxTq4HJBQBd6TQ5S33S+gxMm0qaxgrzAnPMl0+yDaiKLDt7951jKLdVUoqkswHYWfoeFuefdxJSx0uDMYQhkYZHgEWW7RZ+7Jh47rL4VOUNw+J28Fnk99fMDnXpcgs64keyblBX48+V9npkomOJawR4prOKuXfx12ba7Zp+ynsopyRvz+Q6NXk1/qZnHTiL3brfnaCfNoZlHq6R4uRJHRV+oVac63PdB1qwnGqi64axVEZ2QfWkTqH3PqBY9r7tLUB/Crqug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9fMxt0of9kci7kUSKdEiBkE9stpyefo0kuJ2RBAKYI=;
 b=Me6g63zZeuGlvU4mpTiGkquOC3zPg/O1HX5Ove0iFCtgFRbKD36EX18lzdI4uIUfkun2hQVd5jrfHhLyXjQrx++jV8jYKArBeiQ984CnousUA7cDvLRqWQpvoVZy1ONIRItA/JbwSLVCtptRmILeNfRRpApx6eeLgt1pOxqCRi0M/rlaSLU4josee49VmNEtFuB8aUBRZsH+BH5EGjYaVjy5DZZ3NeM84Qio84iBKLxaz1t+oex+GtnnQtqrbtIH+TXxmmiAlxmKfjyn1sGAjXQe39GxzORocLE2KBZG0EaVDSS+q04xKhUTtEoTVzcPYHfbv3a3LB1wpLn1OhJoeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA1PR12MB6750.namprd12.prod.outlook.com (2603:10b6:806:257::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 07:43:14 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 07:43:14 +0000
Date: Tue, 11 Aug 2026 09:43:05 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	Peter Zijlstra <peterz@infradead.org>, ElXreno <elxreno@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/6] sched_ext: Replace SCX_RQ_BAL_KEEP with a dispatch
 verdict return
Message-ID: <anrSiZkg167gQvgR@gpd4>
References: <20260807210221.232543-1-tj@kernel.org>
 <20260807210221.232543-4-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807210221.232543-4-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF00007542.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4d0) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA1PR12MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 693a3b88-01f1-40aa-3ac2-08def77c335e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	p0FXOE/3yG7b+NNXNfC5JznbjtKUO6dKbXotsOacgJoo62bmgcIawAkrKVFdCY464kHCqR/9tsJ+iz21kqRE7Au1Weftt7XGuUfGOVp4jhGbl9KnQKoHmS6FwfvXH7eTlkugwVwtdFRa+f7szWuOoQrdbq1S9KOa1zbRG89GFW5dLxvH5kAFS9w+lgd699XqUnerWev2BLFG07bC8zYwdE7DgFEcrYKQ8NJ/mFZDHGJOOQeYGwtY2vFm9qkyKTH90QbEs7cV6T3qZkTHg61Yq1aDpRGtu09eFOy17EF50j+e4eR7VPVUnS24VCUoxgnT197sJbio+COy8vcqFL2NOc9JuhQesgKQ6ZT5sA9eqeqsmpMY2vMnART8bzw7wiL/+6huoBqKFjmaYGZaq/gGibOHuxrDBBsdSnUZb9HHyXK3u/oPTFR0zWHLRmpSEImFYBPud9uM42xujwVltuGUOPKIlhSHsXU820OV4Uoja/TTJzjc1NUxAk+t3sle0OmMftTWSxCo/q6girEyAFb7MMI4TINnutnsSDZGqW4L8YtOwwpbdYYFy0HzdIwZu5T59J78cJdSD7LUitsAkKLGvDKHu/F+xxrMb5E6etQ1uY49y46MYbSIN87zToEM6pQX3gPfCWTHcYc+QLFWBu5kgvnU8iul3/YS1goXFNPYGC4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sX1M9+tpZbbtYu/i3EkrPfqv6Fvdh/RscBTM8bX+ZVKVvQtjnFqYLnxm1TSx?=
 =?us-ascii?Q?kzbOsfxAbvG8PJyMK9iVrFkxCSPDk+7YHfxabuk+3Gg38wX9okCDXxsKA+pe?=
 =?us-ascii?Q?t47JApk+lIDJ0xzHl1IYEw6MQbdLHOmgEbee8CWg5W+eO9BOl8dO/LRxEFVl?=
 =?us-ascii?Q?9tGTkR/bjb7Zc2ufeKxFa05GTfh2jDema2KUib2uDHVw1BXLsHY1CncP6qqt?=
 =?us-ascii?Q?57VzW0ZEx2UgA9jmrBxFSpL11N7G9jqod2/8afAYOj2KGbnjRl49+YhzCK9s?=
 =?us-ascii?Q?93thlrGEFKQAyNmZ+BmHl0EobXa482DdiclPSt5sOQ00JtM5F8VHZg3ouAoQ?=
 =?us-ascii?Q?JOE7y8goQJNGR8iysEmI2KO5yN8pBE6RDuyvLACrO9mm96jo3OUhXrTaYepw?=
 =?us-ascii?Q?F7raVvtI9uIjk+q3TcDR2vlHSNGurz25mXWqk/sD/8E69fP5V67f7KZdftfW?=
 =?us-ascii?Q?mQut8BMjCyHFSWflgUWoy2eOlb1QlZI3UBSJFmm8elmD01uGPob2JyaLkwmj?=
 =?us-ascii?Q?FpD6qHydcuQwlR2louoEKLX24gIOqZZkmYntmy1MXFChrutjCAo8QQtQ+vA8?=
 =?us-ascii?Q?5XN2jTa5RC5y+e5UJgCuh2vQO54EH6FP5vgECFMG9DDaH6doMePcmcXgCnN3?=
 =?us-ascii?Q?8IgaBIvB8YbqJbg8ylFcipbPlcSXRvRJA3ySvdJMA5NiCwREsHAsy4oyPcSX?=
 =?us-ascii?Q?LcBTxRlirE+wC0xBNzyXMLcse2J5Xnk8aABruW95qDJnwcrxhSosvk7P/7t+?=
 =?us-ascii?Q?KrLw9rfg8H0+pJWy7QhLH66Rt1mfluulJSjZcFTpOTP3pYa/p6H/NOBfb+vQ?=
 =?us-ascii?Q?ma8WRYwq2z5pZ+RPogZGiUFGh4O5uzzXINYCUoapmMr05SvBinnpbICnJMcB?=
 =?us-ascii?Q?L/Lb0ksjFV87KDUifEg7TjW739/VpkK/8EXDHBIECaB6/u3kd6YewnYNTjqN?=
 =?us-ascii?Q?wi2qAL6Sw2EukLVsBRFnZSM4JEUkQx9SqdhXKGxf1y2aTPPi3lZMJhcKc0/p?=
 =?us-ascii?Q?OdQs6zZTZxGy6nLmUaVECZoBJc653uF6/VvZep7gabEJ2W8GGCrEwr1vmfW9?=
 =?us-ascii?Q?dZBdBfdPsouV4sKlKp2lme6eYO7y5axrVwO9MAWpT27rmTYtMpQNKft4dbSy?=
 =?us-ascii?Q?BHOTFM12a90GUV+hBuAm00FjbbHJ/skpDSILK7+IT2GqDzSIDP6BFzUWBBcG?=
 =?us-ascii?Q?QJOtTJa8cd1Rn6iEra1ygEwaBm1B1m+2CEF6S9hh8wJBX4OQtPruBZCPejX9?=
 =?us-ascii?Q?F0lhLZOXD6IFjcqCAycVsFOt677UoSfn/Ngk8xp9tk070d4d74F24vtjbanb?=
 =?us-ascii?Q?IAsfRv8Ecr+eO63/C4zJHcSQZev89nQY2TH1dbvEWk3IK881waF+WtG/vigW?=
 =?us-ascii?Q?ED3GlhnYsz5YWPUn/HKUfFpBsMPBWcWJM9XIObHe2WdBmNNMKZwu21f8IW5r?=
 =?us-ascii?Q?cKWCLYKUEajiwZicOOyjHFKFKBrpZs3T8Hsmn2kfhC3dZjJbjWagudcIYLIn?=
 =?us-ascii?Q?Jv9IIYcymY+goRSBmat+er4qF4CJj/r+eyZ8s2k6S5UT02CScJIO2tl22eIf?=
 =?us-ascii?Q?4+qXTDQdikyY5D12Tuu6DiV1zUVdHscVmbJ+9xlp+fbEcq3QX9JChN0bZFOQ?=
 =?us-ascii?Q?g3tdfJXGhI5eMfli5P/n89m3PWCQPX0q/F4RAbx1leO9GB9idHEVItVXvvqh?=
 =?us-ascii?Q?szxvMudFYlU01tbLpgE147bcfh8BR7JtkdPMlxYhybW0AmxfV9dTUUAxKJZB?=
 =?us-ascii?Q?XUFmji2Xkw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693a3b88-01f1-40aa-3ac2-08def77c335e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 07:43:14.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIxM7OyuoopbsVm89xJyKoPwfcrEp40K2anupwV5bJIFZ+eQx5gIoRB6xAIOwUuXs7CKG003me60WPVDeaXpZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6750

Hi Tejun,

On Fri, Aug 07, 2026 at 11:02:18AM -1000, Tejun Heo wrote:
> SCX_RQ_BAL_KEEP tells the pick to keep running the previous task, a leftover
> from when balancing and picking were separate operations. An rq-level flag
> only works while dispatches and picks pair up one to one, which core
> scheduling breaks: selections interleave through dispatch's lock drops and a
> pick can consume a stale flag, keeping a task that has since been dequeued.
> Fixing core scheduling support requires the decision to travel with the
> dispatch that made it. Make scx_dispatch_sched() and balance_one() return an
> explicit verdict instead.
> 
> Also factor the pick-side invocation, its follow-up queueing and the
> post-dispatch checks out of do_pick_task_scx() into dispatch_pick(). No
> functional changes intended.
> 
> Fixes: 4c95380701f5 ("sched/ext: Fold balance_scx() into pick_task_scx()")
> Cc: stable@vger.kernel.org # v6.19+
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

...

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 450b6a04669f..14c2df6fd9af 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -784,7 +784,6 @@ enum scx_rq_flags {
>  	 */
>  	SCX_RQ_ONLINE		= 1 << 0,
>  	SCX_RQ_CAN_STOP_TICK	= 1 << 1,
> -	SCX_RQ_BAL_KEEP		= 1 << 3, /* balance decided to keep current */
>  	SCX_RQ_CLK_VALID	= 1 << 5, /* RQ clock is fresh and valid */
>  	SCX_RQ_BAL_CB_PENDING	= 1 << 6, /* must queue a cb after dispatching */

Should we update also tools/sched_ext/include/scx/*.h to remove SCX_RQ_BAL_KEEP?

Thanks,
-Andrea
