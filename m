Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E3B33CEA8;
	Wed, 19 Aug 2026 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787148423; cv=fail; b=McNpYzCpyXVyyA8UsmejUN/+XzbL83YLBYS0+dKEvQyTJWTJeysdTED3Sw0lHpBIuiy+oZwpCBbwFMdSmBbg6HOCwBpX5Ddkz1TqHp72YcW5TW+6fCI+CFPagBvcHtgd4YjttBMWnChPSd/iZWTGRx/aSOMvEstqkIXzEG47Tm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787148423; c=relaxed/simple;
	bh=nnQ+mzUI79D8wUjeFOOALAn5vYA7IPymC6KQzyjNyOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U2I86zr/wO6IMr5URtvdhIa7HIpjKqKdCFRKcffDcRlVCalUl2y9uwrqUJkiGjRqswFjOnifs6pIqQkjK0cnsNqfPTrFlhIdB5+1XWjlLz9uHBqO4qFQwFlOGB71efqyLA0zAh8d1wVCk9k6OFl2fd3QwelLI8GFHRyIW54YiWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hh67fBl/; arc=fail smtp.client-ip=52.101.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hh67fBl/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWOf1i72mgSafCxfmMejrqup05xL4DRY15ffpH/soqUwskejXOUa00iZzRKs064MTnnCc4nI72NZFC1yahvwtRIXA0my2U+7n/e6woPZNKe64gqZDIYe8aU5lxeiNR1G56M+NsrFjCIbWnTrNvtMhpLpQl0JWi9qRkRMNfZq73N/6tSsRJWJ6vsnsFcJr0/HqNPNtpKHEvX1rk1I96IuPLhKGSTR87mtrLeQljW/KWUB29kSFe5NEwETA6QZzGhQP1+0efUq/p3FBW/P2SCaj6Nn200IhNu6KdTOLTaMW/bpiHQDX626QmbI2qn+FrRJV37FTCDiY8b+HLAPPhYQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxkMgbsbJeiZ+qn6j/mm+Y8jgj0Mo8o0gCHs7KiOpik=;
 b=naStti/GDztxQ5dGuGSZNHqtckB/K02GKD+cQDEBGt2sfl1DeZ0OkHOAkTW9jbDVOYvwlfi8PZUe1ylvZQS/ecE74EzwujQ5h4M2BG6AXRMmVM5j1lkXMonEhyz1cX4PRRS+Pmgp91BRlfv1cBlh3wJC4X37axo7tR4CIMnG9vPGClx2JcTOe1pUzub03ZY0jdbikQgxnL/vQ9HMniIcaM3L/Lr+OH39UPka1+VE5RM371syRhUyZefOotkgVjD8wKpcFiiyASvrC05vyJn7m9xgT63tnJ1YgdIL+NAZ3IEeHwm5tuQmDdh0O0I4QxxWL7NC2dBtLB9SwkGOA5Q4eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxkMgbsbJeiZ+qn6j/mm+Y8jgj0Mo8o0gCHs7KiOpik=;
 b=Hh67fBl/jGuaJdgjZgTZMJxp9aboW8IqN0O373zev7nUVeR8W6YSHiQ9EOPVRTWC1j4JaqXCzo4XXVvQfHwtVut0i9U8LioXhP81VUwp8oPYhqSWt6fOEEARVxWYfb2+w/4aWsICLpSFTqqXjoBBlCrCYJkGezGRDEASr0LjuXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 DS0PR12MB9728.namprd12.prod.outlook.com (2603:10b6:8:226::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.8; Wed, 19 Aug 2026 14:06:58 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 14:06:58 +0000
Date: Wed, 19 Aug 2026 10:06:47 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Jasjeet Rangi <jrangi@purestorage.com>
Cc: bp@alien8.de, Smita.KoralahalliChannabasappa@amd.com,
	dave.hansen@linux.intel.com, dgiani@purestorage.com, hpa@zytor.com,
	linux-edac@vger.kernel.org, mingo@redhat.com,
	msaggi@purestorage.com, rhan@purestorage.com,
	rjethwani@purestorage.com, stable@vger.kernel.org, tglx@kernel.org,
	tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH v2 1/2] x86/mce/amd: Fix inverted interrupt enablement
 during storm handling
Message-ID: <20260819140647.GA2416@yaz-khff2.amd.com>
References: <20260818190250.GAaoSsWiKOuj4gRYsl@fat_crate.local>
 <20260819064601.1972932-1-jrangi@purestorage.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260819064601.1972932-1-jrangi@purestorage.com>
X-ClientProxiedBy: BL0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:208:91::27) To DM4PR12MB6374.namprd12.prod.outlook.com
 (2603:10b6:8:a3::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|DS0PR12MB9728:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac2adc5-b84d-4797-1d0e-08defdfb21ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|56012099006|3023799007|6133799003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uFJLBVPq0ojs8eUPUTmeNhFX3lUgZqjXdwJBHHLhBIcDSkuSpdtPgOK3hULZjXBVyCb9YQWP0tkk7iPPorGzGUWHObu2ec+TZuciJLxoJFpWZt91y7QAAlHG0C67KTeKIBENQR0OnFQ7Bm2OUBt3o57Ubg8OkGjaM/GZ7megU7jPPvlTXUp0ipb4SGsYNN/800prcrGPoMc1mJYuUbKkshDW3vpcTgKYOhH7+ClAaiQXtYALpJYVbNsF2rmvrycH829YhTb34eAzyOV3KaVF2sOf/CFfo2KDuCSzirNdpLN+gBcC40KIpZz3EHt4l3xFj7UQW/4h3a+fo7xx85W95PcbL2eJ+HNjHl5/9uLtbhmNAqcqcfjVamyGg6ZOdWQ60+yff+Drbf13nG9FasLuGhm4Saf7NhTBZkcicylB+3b2aQOPLA2C3R6MWBrKgxQzDSWsS3TlXQ/9oLGfzvZM5eBrnWMY9MK8cA4fSkzqkgrHrLMcFULY3BHGtlM/ZBbseBRmkmvCO3ggcyESVKQ4pvSqKIHowQwAUPXgCqCk5GDwluhUtZBuuAUUUdriKrRDfBrqEVi4P9pqaCm8k4wLJ64PHUfUnvC0MihurXo0syJ3vgUHXsw04Jv9ip2/wcuBpOToZdNJtIraXzZM39ykUFozwh94gXomdaJEjDuptGc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzkwMXJ0OTJDcDZUNDB5UkRNNDNQbTdHbmdiTi9DeDNvdnlYY05SdkNEc1J2?=
 =?utf-8?B?bUFrVllWeWRzeExQVndMTGJDTDMwdHBHRGJLVDlRRDhVWm9hcUxBMW5ONk9U?=
 =?utf-8?B?dGJCM0t5M1ErdmVVOTZYYmw2N24zN3c0MjM4eTV2SG5rcmlRcWlhT01BSmY3?=
 =?utf-8?B?R2hwcld6dW1UTjB0OXllOW5MVUs3WU1yd1lNcDBBa3VOUS94ZHUyL1FONjVO?=
 =?utf-8?B?WW1yMWZiNFh2ZnFET29MRmJSOHRNeGJFVWUwaFowZXd2ekVpYnJVd0dTME1k?=
 =?utf-8?B?c3pGbXgxQytxZVJ6Vit4bit2OEFMVi9rVTVaK0VyejlxM2c4RHlkQUY5NE83?=
 =?utf-8?B?UzdUSGJqak91eENNa2hvdVoySWhMamkvMzBKK1BVZ1ExNU0zNUdUcFF0NlBT?=
 =?utf-8?B?ajFrVWpZL3Q5bnUrSStDYnd5MHMvNlBlRlhIYXhwZXFFS25OQm51ZUdaYkJa?=
 =?utf-8?B?azgvOVlxZEsrdXlZclBVWVE3dDJSTWpPR3NndStXWlAyNEhVOW9LQkhBSTR3?=
 =?utf-8?B?N2xwcGREYVUzVis5QWZscDAxRXV5cmhkdTNycHVTZzVUZkhnZHpWZEhjSEg0?=
 =?utf-8?B?aHMxbjRPUHNjYU1ORE9YQk8vWXFFN1lKQkMrd0U2UUVBM3hnaU9iaXU4bFhm?=
 =?utf-8?B?eGJaL0gwZVlxcFBlY0hRU1FVOWtPdTJwQ0VZQllSL3NBVm9vN2ZYSnU0eDBz?=
 =?utf-8?B?NFUxdTJXZW43MkFtb3duNDhZSE9jZkFPekNKSmIwSFlRcmZ5Q09zUVhTRmxu?=
 =?utf-8?B?TTdQZGRwSEFCTGRLT1g1VmxsZUloMGgzZmltN2NLb2hsQTRoWTB0MEl5NnFN?=
 =?utf-8?B?cnE1dVpOSVpUUVppYU9CKzRHdDEra2FyVmVyWUhCRTlSbkdEV1NORDltZStQ?=
 =?utf-8?B?UXpjOTVFM1g1T1JFb0h2clVqSzE1S25Zc1VERE5XZnZBK0VEMEZFS1Exd0V5?=
 =?utf-8?B?aENISW5ON3dCVElVaWx3VEc4UnFDOVdaT2pOclR3cTRpekRvdEZ5b0RmOGk1?=
 =?utf-8?B?aGpHZk9tL1QwYWpRVlMzRW5Qb09jV3NuQ1VvaENqbUtON2prdzk3UTdCSjll?=
 =?utf-8?B?VnUzRHZKSm1JeGhSUEl2RThXQ3ZReE04VEZCelBMQndha01oWEt1RC9KV0ZN?=
 =?utf-8?B?bzBhMW1sTEtoZzhENXU5LzNqZnZhUWJvUVBjZHBzaHZjUGNiTFhXQ2xDSFFO?=
 =?utf-8?B?d1RwTTRzNXpsc2tVUEJEWGw1Z0s5bHpWL3VhbkdRVkk0M0VzeURLSmx1S0lL?=
 =?utf-8?B?Nm45QTZzQXpJNHgxa1FhOGloWS9GbUxZWTZQSG5seDRDTnJEbVlRb3ArU0pG?=
 =?utf-8?B?NURjK3RPTWZIaUcyVVpPemwvZktpalNicDNKMmR0OW1UWmRSc0MvbUozWjAz?=
 =?utf-8?B?OTE1NHhEK3J5L1FDWnBKckQzV1R1elZZbmdRZ3dGMkcraFlLa1lPQVdQK3ZR?=
 =?utf-8?B?M0N3MTdQdGdrT3kvNjlzUnMyV2ZqTW1HeDd1WU5wOVFzWkF5MXh6VUxtWUtq?=
 =?utf-8?B?OENZS1NHcU9kbmVXNjFvajI5ZDVSOEJwZDE5ZlgzS3hJbWZ6QUVpc3grOHU3?=
 =?utf-8?B?Zk1DVEtGRzAyK1lCeDdtMmlpQnY2ZHNUcG1wQnoxSlJzQSsya2Myc3dWM0x4?=
 =?utf-8?B?NHMxM25hYnlXc0dCNkFSRk04djB6M09GMVhqNHhkS3NVV3NkdGZ5dDhxdjNE?=
 =?utf-8?B?eVNOMzlQVDBSMFlrM3Q3bXh5dDF2WGxDc0JzNjNBanBpSXJJMDAySHlyUTVr?=
 =?utf-8?B?cXFEa3oyYnhPbnhCTWdPVllDdXVpMGlBUXhjM1haR0owM1ZrQkJYZ3MxVG9K?=
 =?utf-8?B?Qm1RV2ZjOHZWZ0ZRb2lWb0g0OTl5TG9tZDVia28vMDE5cjVFZkpMVS92Q1RE?=
 =?utf-8?B?cDdrL0JmQ29qZGRNcENTMHRpYkdsMU5UNzBXU3NFd3dNMlcrWnE3dzF1Y01q?=
 =?utf-8?B?RXFocWZBOHgrRURDRnl1a3hRZVlGYm5Rdmg2NThQWUgxMWJyMzkvSXFSQVJr?=
 =?utf-8?B?T3dHendGWFFRU0IvcDluaDNOcjJ6c2RyZ2NHVnVqNUZPQ1lnYkQ0UjN6VGg4?=
 =?utf-8?B?cnAyU1FSSjc1M0lMcmtzOW9aS2o0UkxobjFzYU0zNWZRN1JRWHU4SmRrYnBW?=
 =?utf-8?B?VkIxOEpjMVBKSkJqWXpjOCtERFlPZU4xdnBpQVI4bHFVcDJremZzVTYwV1gy?=
 =?utf-8?B?SVJpZnA4bVNHeDlCWHp0bm51dDFYeGpneCttYVhrSW0zUHZWUTlXdUx1WXFa?=
 =?utf-8?B?NTdwME04OWI5MmhscmNSY2JTR2FJamhwL1gybnNwcEJ2VVBORGg2NGxLN21s?=
 =?utf-8?Q?HYMwSjThCfZC1g7o3i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac2adc5-b84d-4797-1d0e-08defdfb21ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 14:06:58.3529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEj1ibxy9HyyXPsEugZZ9wifYm85ns0zNhgCKFXTZS1eGH+JDNqkyUNKezwGNhYMKjFjVNs0JP4UJzacQBjPMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9728

On Wed, Aug 19, 2026 at 12:46:00AM -0600, Jasjeet Rangi wrote:
> I'm ok with the queued patch because it still fixes an important bug
> (disabling interrupts on storm end is not correct). The rest of this
> reply is talking about the concern that storms are not handled
> properly in the AMD driver. I can make that a new patch thread if we
> agree to make the behavior more Intel like.
> 
> On Tue, Aug 18, 2026 at 12:03 PM Borislav Petkov <bp@alien8.de> wrote:
> > On Mon, Aug 17, 2026 at 12:51:08PM -0600, Jasjeet Rangi wrote:
> > > Inverting `on` in mce_amd_handle_storm() alone is not enough because
> > > clear_bank() will immediately and unconditionally enable the interrupt
> > > again.
> >
> > And?
> >
> > What would happen then?
> >
> > Did you read my previous reply?
> 
> On AMD a machine_check_poll() call will not necessarily set ErrCnt to 0.
> In fact, it will not reset ErrCnt at all unless the overflow bit is
> set. And the overflow bit gets set when it's time to generate an
> interrupt. (Yazen and Smita please correct me if I'm wrong)

Right, that's in threshold_restart_block().

> 
> The threshold is not always high on AMD either. Since eeb3f76d73ba
> (x86/mce: Save and use APEI corrected threshold limit)
> it gets the value from the BIOS. The default on an AMD system I was
> using was only 10. So ErrCnt will get reset to 4085 on that system
> when the overflow bit is set. That is enough to not meaningfully
> reduce the interrupt rate during an interrupt storm.
> 
> Unlike Intel, the AMD driver doesn't set the threshold to an extremely
> large value when storm mode is turned on. It keeps it set to the same
> configured value (default from BIOS).
> 
> So if interrupts are left enabled during storm mode like they would be
> even with the queued patch, the AMD driver doesn't really reduce the
> interrupt rate during a storm like the Intel driver does.
> 
> If we don't want to diverge from Intel, then the correct thing to do is
> to update the AMD driver to do what the Intel driver does. I.e. don't
> disable interrupts, but set the threshold_limit to a large value like
> THRESHOLD_MAX during storm on, and restore it to what it was before upon
> storm off.

IMO, disabling the interrupt is the best way to manage the storm. The
reason for Intel to set a high limit is to keep the interrupt enabled.
The reason to keep the interrupt enabled is because the same interrupt
line is used for reporting "uncorrectable,no action" errors. This isn't
necessary on AMD because there's a separate interrupt line for those
errors: Deferred error interrupt.

> 
> > Yeah, we don't protect users from themselves, you know :)
> 
> I don't think having threshold=1 on AMD is too crazy. On the Intel
> driver for example it defaults to 1 if not overridden by the BIOS.
> ```
> /* Linux non-storm CMCI threshold (may be overridden by BIOS) */
> #define CMCI_THRESHOLD		1
> ```
> 
> > We do clear MCi_MISC[ErrCnt] to 0 so that's the "highest' value we can do
> > before we raise an interrupt there :)
> And on AMD it does not get set to 0 after an interrupt. It gets set to
> THRESHOLD_MAX - threshold_limit. So if your limit is 10, the ErrCnt will
> get reset to 4085. This is the behavior since eeb3f76d73ba
> (x86/mce: Save and use APEI corrected threshold limit). Prior to that
> ErrCnt would get reset to 0 by default on AMD.
> 

It's fair to set a low threshold limit. Some users want to see corrected
errors without needing to poll. And they'd like to see them ASAP.

The threshold limit isn't much of a contributor to interrupt storms. A
stuck bit/failing device will likely trigger a storm whether the limit
is '1' or '4095'.

Thanks,
Yazen
