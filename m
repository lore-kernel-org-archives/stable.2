Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A68350A0F;
	Wed,  5 Aug 2026 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935830; cv=fail; b=YzyClWuC85/r8ufd8TMO9BGnm8FBA+I74JwtLMUAxOYXV+DpXmYDujYbMvxNyBqylZ7mSWE8w1jzeAsEKqgwoMSFCi6knOOCwyrN+HdUd1pxasNZTAHxaul1qEU5mkAZ8rC+vnk44wxwAUb+S8sdr2d/y8bJdMJbqdVQOG3LiRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935830; c=relaxed/simple;
	bh=VBhEd/H1JPLsRojqcA9mL01K4VwulzuI0ZycQ/wlm1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JMnCygXGX3dlo1qAFnaXgEWFigF/CKvWBboEXTaH1V6LBBuWciK00xMRdTXEd+hkWEAayLe9TzBbmXGdLB4FliD3xgP+o9LBQakdsXnCmnzHo2lyDkg+y/5lr2es7tz6MsaktOawFEwAXNKbv/jS7ceoLOm8/NDFdC9ANDfNtck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=avxu+1Gw; arc=fail smtp.client-ip=52.101.56.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="avxu+1Gw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBsWEEPuiIoD2urv8cxMANTzlsBHgqflnv+b1PwUedgHol5ObHcRf1USlEwMPFlIbYLHpCCaRgdClQc51FR1jjhniTI72EfVTvmkfGcU50TIIiBzH7SyQn5pw+d/IIX2ibzqNJVQlrYGJDhYW3+jfluekCuvxW8XmGOCKAxdCIYL6Qex5naY/mkCXw3q9uK3rbHVkTbVw433VEK4AjJmcbL4eLaMm7cRgLwzzUE8PIJVxGOnfvMx8NtCuhIALcZKfj5cTobxmWI/kSnJx6N2IHCYnSX8pvnihH40+6yo61KR9/cuHjn3idJSvURtqJCfq+a49GolN1uLm0KXx2y//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRuPR/icjDA4o2JD/uphhLzqlAzZ8xh7YgCnEye3Az8=;
 b=N3rUAS2NYon9EPT2QjIoOWz5jPK7a6RcVao2RwbiBEHw2ReBkJB2+CHWTxCLNPVLITBgmKQgWQlldpNCVXwWqClMcqy2rBSsfY1G63vmtGiSKC0jRI5yYHCREnOrI5kOH9fT6Uuf9VqRZfm9+7yi0npJcMPIaWMLQAmRRtTwbyhnHzSJBGlng1f58at2RBAzIZwzUBz5Lj1AMit0WLFlmyPfZDSo4kItpvfzVzC30ZPpIwfGFq/twzbUk7Ek+4jOs+Mg3zNCrl3n+MpEzTlJtMZhqUZ2c6znj5eZZBoQNI08qVxPa39cMZtAp9e5b++zI92nYVotmaKBtQppdTi2Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRuPR/icjDA4o2JD/uphhLzqlAzZ8xh7YgCnEye3Az8=;
 b=avxu+1GwuG0ZqQB18UuMuND9Nj8OlfvzVG7hgk5Kfq8TPiDVeJ3tf1tQOBu0d5+L/uvjm4abgozmLu4zHerJG4pJNy4ulXWrsbt1pfhqgOesShHoE1PdJHAl7+CrfgznaeNGajwYBydw+Wn6J6Xa7SkauQebSWdhzwzziwfICyZJpWVOZeCVSandjLzUVBz6ry5BBnH8eSe0n+qPTDO+KMe2dvMlBBezrwP0IrQa0sIrR2MWfeEPTWgMxhUhWSHVO3XVGIaZesHQabhDGl1D+RJqxgOSezj4DK2RQZ1nmkTTI6yuCONwDSkGWa4krMBLAJd25dKoOD+ApvlDsLuOPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV5PR12MB9753.namprd12.prod.outlook.com (2603:10b6:408:2b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 13:17:04 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 13:17:04 +0000
Date: Wed, 5 Aug 2026 16:16:54 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: David Lee <david.lee@trailofbits.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	Sven Eckelmann <sven@narfation.org>,
	Petr Machata <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] vxlan: keep the last remote linked during FDB
 flush
Message-ID: <20260805131654.GA1489442@shredder>
References: <20260804060958.711335-1-david.lee@trailofbits.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804060958.711335-1-david.lee@trailofbits.com>
X-ClientProxiedBy: FR3P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV5PR12MB9753:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf50b97-cd34-4a6f-c60e-08def2f3d7a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Ecp5x7Avv2vmUJBzulxE67WcpKGi/kkEL48oGfuAdpNqf0Q+6GMA9s44zTbYOpHBOIjROS07S6CIuo7cfLqMl1na1qV3p4Ywu4vnxFYKaB8lKcOL5QFx84dPKj8XaPhLrRiJZf5iaePL4j1IQ5cy3Bp18KKlGhEsZ8r50qvN1xVnifYiKEE1ZsDD7HMDlb/qs45zPv16jLje2wucT5Yj5wdYRlt0ar2+sMz4dSVvaYgwI46aizSnVUqOgKadKuAHu5I0n6PiUtNrEzFSsDKBv/Xxu67nGOQNKP+DgkEFfF4gugiA/366CAW9yVcvFvjANsKOc8JWYqRtJVsrP/exP5jkWTZY2H7VKMJiNjKHN0axnmnTQfHs1DUYcQwHZ3ZbmQiyInlhCYmlNZ24v6UulY+mbsjitqCJzzKIZys536RRKEzo8f1tbd2duuAJMCvLZiGK6EhmdTENeoicTdDzbwxC4e++8/NZ7nHR62a+fdD4JFvffoPWLkMVqE9vM8DwGpZ7I5c6JGqFgfeF56Nib9LsDZ+qY4z7iOolE9mSm5DEi6Ri676CIC5FL1lxaapdUYzutWL4feeo7f465LV4NjG3jh6qBNb9lchqvhrtLp72YMvzmvV5/XsaBy4CorfGSGUbZEwSB0/KavWU9VQGcnNdhDbUq5rhnIX8fGZi7wQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kDkpeqbCWG0NK2aOZcLFsZz4e1vhcfRHQ5aUKiVyf2mFhtn1MovmZRU7uDoX?=
 =?us-ascii?Q?nrPhnSPxmhY2q5g8Vcu9Z+EtQE8tkKnODKQCJH7dUn/3igZJVU2HqxB+x5Pd?=
 =?us-ascii?Q?TyomPdiSaXFailXcZIOgrTY7iF5NI4mSg/R2Xc3R+3NSVzgez6b/du8hGgLu?=
 =?us-ascii?Q?EePS/CatlbOP8u/v1jBau2QCI+o/23SQhhmRwTKPc4NcX/qa8hZe+tOcS1gL?=
 =?us-ascii?Q?7R+sWYTzR6/AVOyf/foidnsCVPvLjIq4MT0ci1PHEe2dhg1PzpVl49y87gIz?=
 =?us-ascii?Q?mWeX955VhERWR+gkwnYbSOMziMtZD4osDzV03glMKh0VcnhnSmtIJl53S6Qx?=
 =?us-ascii?Q?dzBo4RNe4EoXc5J3Fw1bUymGyG8FhZ78+foc12oT4CY/+3Y0ja8NoFvhaVn1?=
 =?us-ascii?Q?488tO1Ucs6svTD+aQIt88NC07DJ5V3L8NG46ScJ4AGN80d4y7RdRX548xW2U?=
 =?us-ascii?Q?juM/yqy4SKIfY/Pw02xv2Oe5pP0W9/qRNv5qrSJPaiJGF2kKPJZhBZnJsqwp?=
 =?us-ascii?Q?v++ffLvuieyf/363zf8DTJS0oEY5+LxL1Br3gTDt/B+kT9oFvaxNckAUuMIt?=
 =?us-ascii?Q?yuH60hTgu7D/E0PL0xFjR6M2y+yQlNfPvB8HH+UoA20PSmKWmIXZv7fIf+E1?=
 =?us-ascii?Q?UixnAXdlz8LGk5hIQHwnZc9MxKCA+Od6C1zUFRkXeVR0wpvFjyj9RcMmraUo?=
 =?us-ascii?Q?Fsfdt9GQdQ0dWdYG6ypjFFKvFrMhX+GOjUC6PqUQs17d//I9LE6EL8F038PQ?=
 =?us-ascii?Q?uli19OtLUWzLfKuxy8hfHhmRt17PtYIan029DKngjAoQSVS6GGSfpknn1OEx?=
 =?us-ascii?Q?15FNZ45Q2zNb+XHeKwbtNkV9lCr8y6PERxxcirFACC1sTSt6/DQUlwDO/Wj1?=
 =?us-ascii?Q?+KbuWMLMOtGL96zgH9QX2SvabVv369XL2MenPPsu3BgNDUyJYcHfd3+onyta?=
 =?us-ascii?Q?8DUWbn4MFXybh/RtobHHbkUG9xFMwtd893vAZpaXqV5gFC0bcrHiUWg/ANqm?=
 =?us-ascii?Q?Ca06bl0Kp8cCMgr0FJEwJwpqdSL8IhcYnS9K9rcO7TwWHYL0P6Qi8afhf/G3?=
 =?us-ascii?Q?EvqI1B2Hoe7PtP0hrgTc2d9ZjwKiDYwwquUUTyHmuHnI4d7MyRlb8Kpmnt95?=
 =?us-ascii?Q?i2ozmI8u405AvF4uP8XoY4NMG8k+HTFX5z06IZ7KF6T6UWOWDiFpxWO3c5m5?=
 =?us-ascii?Q?Td2yK+jcLshdKexqoYh/uACVVXYTcmzLSV4QTr5w5rxJFMkVzZ0ulzMeFopt?=
 =?us-ascii?Q?T5fygBKLgpk+mJGX33hiGHlJDoEkjlR9DpYlw6LO8fDMlGDUMpp4CmvQ4/NQ?=
 =?us-ascii?Q?D/mQB8Dyfntyu8K9lE0sAvYi/AsvogcgtvXy6PRsMg7C9vzbKa1oTE+q2EJW?=
 =?us-ascii?Q?CxNjrpkOu8cQCszTgG3XK/4o3RHkLkONEjopEWPV7rtZsRXGN7Nxta2npGn4?=
 =?us-ascii?Q?Px5UoYPILyHQ1jfLu7qcej2WIDGnpl7QW+UhvWuQbw1d4IF3Yw5h4wjbUWz8?=
 =?us-ascii?Q?BfbSHH21RGZMcsuddVTM4av4W8HrNnQudef2j7zwDDwI8TAoAHLegJQIay/Y?=
 =?us-ascii?Q?sndJd80rPc789BXifnntNOUGwnjEtO4Uk21Z39Zf92K5T6spSdJDSnvA65i0?=
 =?us-ascii?Q?6gHRmMs4Fag4X+5223Tht/qrOuQSXyX0lEFE7zAduDdPzkDpBHgw3G8qYA6F?=
 =?us-ascii?Q?RNYPQHREOGYTDoh3HbdAtdl4ehnaNb1nv2Qm9qsVAuVw4crZLrd0Z7Z7tv0w?=
 =?us-ascii?Q?USPI2DTl9A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf50b97-cd34-4a6f-c60e-08def2f3d7a3
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 13:17:04.4612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z90GvH90n+ARobj9e30U19hhoAT9Gm4WJmk9EGfiWJUBvxSGG0FioYfY3pztJCdX+588B2nwzKYlU9FM7g/HgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9753

On Tue, Aug 04, 2026 at 06:09:58AM +0000, David Lee wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> A non-nexthop FDB entry is expected to have at least one remote while it
> remains reachable through the FDB hash table. A filtered bulk flush
> violates this invariant when every remote matches: It unlinks the last
> remote in vxlan_fdb_dst_destroy() and only afterwards tells vxlan_flush()
> to destroy the parent FDB entry.
> 
> An RCU reader can find the parent during this interval.
> first_remote_rcu() then applies list_entry_rcu() to the empty list head,
> producing an invalid remote pointer that the receive learning path can
> read from and write to.
> 
> When a matching remote is the sole remaining remote, leave it linked and
> ask the caller to destroy the entire FDB entry. vxlan_fdb_destroy() keeps
> the remote attached while sending the deletion notification and removing
> the parent from the lookup structures.
> 
> Fixes: c499fccb71cb ("vxlan: vxlan_core: Support FDB flushing by destination VNI")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Co-developed-by: David Lee <david.lee@trailofbits.com>
> Signed-off-by: David Lee <david.lee@trailofbits.com>
> ---
> Changes in v2:
> - Add the net tree prefix to the subject.
> - Restore Kyle Zeng as the patch author and correct the sign-off chain.
> - Move the research credit below the commit-message separator.
> - Add the recipients reported by netdev CI.
> 
> v1: https://lore.kernel.org/all/20260731141311.570187-1-david.lee@trailofbits.com/
> 
> Bug found and triaged by OpenAI Security Research and
> validated by Trail of Bits.
> 
> Trail of Bits has a reproducer for this bug that triggers a
> KASAN slab-out-of-bounds read in vxlan_snoop() and can share if needed.
> 
>  drivers/net/vxlan/vxlan_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index d834a4865..a00df127d 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -3058,6 +3058,11 @@ vxlan_fdb_flush_match_remotes(struct vxlan_fdb *f, struct vxlan_dev *vxlan,
>  		if (!vxlan_fdb_flush_remote_matches(desc, rd))
>  			continue;
>  
> +		if (list_is_singular(&f->remotes)) {
> +			*p_destroy_fdb = true;
> +			return;
> +		}
> +
>  		vxlan_fdb_dst_destroy(vxlan, f, rd, true);
>  		remotes_flushed = true;
>  	}

Can you squash the below into v3?

'*p_destroy_fdb' at the end is always false and it's initialized as such
by the caller, so we can remove this line and 'remotes_flushed'.

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 117fae9c05a4..0f686bcc5a20 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3058,7 +3058,6 @@ vxlan_fdb_flush_match_remotes(struct vxlan_fdb *f, struct vxlan_dev *vxlan,
 			      const struct vxlan_fdb_flush_desc *desc,
 			      bool *p_destroy_fdb)
 {
-	bool remotes_flushed = false;
 	struct vxlan_rdst *rd, *tmp;
 
 	list_for_each_entry_safe(rd, tmp, &f->remotes, list) {
@@ -3071,10 +3070,7 @@ vxlan_fdb_flush_match_remotes(struct vxlan_fdb *f, struct vxlan_dev *vxlan,
 		}
 
 		vxlan_fdb_dst_destroy(vxlan, f, rd, true);
-		remotes_flushed = true;
 	}
-
-	*p_destroy_fdb = remotes_flushed && list_empty(&f->remotes);
 }
 
 /* Purge the forwarding table */
