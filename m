Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022117.outbound.protection.outlook.com [52.101.101.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ADB28D831
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 00:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786839614; cv=fail; b=n3r+lkW3fxXo3KbOJSDIWuDUTPbEH0WKoAC++b8LTVwvYgrUEmYrZq6oBBxwMZH8R75MYdJYmX7RdQUtow37V8fArD4LEu2KFmybos2Q5M7JhUpqHFV1TTlbJjw6jdWc+bwx5j7uOeZ78Pic5VWOKm5PIbnlvuPdpifZT+FZwZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786839614; c=relaxed/simple;
	bh=YUIZW9Ot/nrNfYkumBhfRgtSt/jvGNZ2y5f4gVb0C0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KQF+99vyd/pASuH6ff0ucDxa4koVlZ7U4WEHk2tlKekLW1MQyp3af8veohyEE2VhkBFQl8eZQeAxNwWINDblgwVT+JevG6iefkZCBQ+t5ew3VKYnl7D0u6yLuS2c30thwnkYp7A8d2qWzaaFG/2WK4yDQk2HlMzFRHJ2dj0DlOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpH1rkut2dPpt5dpfTfz9JzgZzCKnxcqbohN/n7n/fWlMPKLWTgopi7uJDaMs23yZjg0nUOpbrbh2gabKJtU/lWdA55QoZrGslXiXmxeYlwKjZVXMgCKiEC+IGDkp4wWgz9n8/bs2bOn3dQG7etWMDoKM8kOOgek3Cv1t+mkazG+Wo1Ta1jMdNGq7J1oMqekXoMquGSNIC0YO6LWy3wD6QKLdat5fCvv19kkQtj+2FgK5Xkot76x+qbVU5LN1nWeuq/YnjZ9p5mYeeaIxK47Hn+v+oIuv76RyWaMxUFYTl/GfsANHWBTW5mR36Y7zeMAh9QNBeRkTMxh2GE2nT9zDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=/oWP/mN+YbwMpPX2h/8ZD4ThYxJa0UlRkoo2lQrCc3Y=;
 b=tgbuE2PVWMpN17h4/8xlhQNM9NaMvu9l97gTLDL2LUp9VnCH3KoZwRUL/xiq5VS+hG+pVLQWqLurcbNuGE9v61LpXF7Y+qH69Rr3hs9ph/ZtY6LEQanIF625DmiGYJtkIdPQmNsSgEzJZNEJB4XhhbI5vmUfQnIjRLi8bnqIYH/XdR/kfU4lmxFh9VtcZGHGX0NFbqib85ya7X894qNw9QT/0y6GzWA5ep/qxHaRz2lN7+o70K2TE0cOS6eplepTsZe64qAkqaAS/uzPFWBEbIinL5KjgwJTWdrXutMD9KFkGi/WtY2mKufsxRzb93LdRndKCyvdwDiJi8pg4qs0Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8648.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:279::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 00:20:09 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 00:20:08 +0000
Date: Sat, 15 Aug 2026 20:20:05 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y] mips: sched: Fix CPUMASK_OFFSTACK memory
 corruption
Message-ID: <r762h45xpp37buhq652fie7el4uw3l6hzrxlqti6ivhsw5o2vb@5jaid5doqohi>
References: <20260723181719.540786-1-atomlin@atomlin.com>
 <20260725192000.stable-0016@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260725192000.stable-0016@kernel.org>
X-ClientProxiedBy: BN9PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:408:fd::27) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: 571f3ae5-49c8-4c37-2037-08defb2c2116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	u0VtdNmgAv7Leik1Jff3N7UN0b5PehTPALm4Gzpi3EwTOM3mzKz2Q4gQkrIWmjwKbUjKMj2AWuoYZDyg8N1jMCqtSbfLcCwkp0KhuD9g4tlp2QCIYDkJ+w8WF8byRQNm1AQSjiOz9pun1doc3tMzBOgwXosgJEg4Yj+JQOchNsAmrf/ekL9MDlbXSf5WfTxWGE+U/d2QaRbj0huT6NV0R1hcBvBhNfNM9K3+t0eowApAUuxHsH75jhHw3rqy3dxT/WTah/ttKHomljhfVEfkrwkBtYoAXjP3NE3Y8E+QEgJP/dg2Zx9VK0eDI6HBmETUP53gFUqj3B8E0nUgm1GLCj3426oFNCJc7j8pMbzGwW/iuo+MXzRFCjfDu1L68qxs2tItb1zwi579u1cpFXx4CXU4q4i+/jYuuFJuIEtNxaOzP7rwyj9qpDRzKgSK1HYSEmi/m1VTIO3qGBTgLMmtap1UK7+fYVte772zuLBF/ETPDvuloZszueoM11zd8uq2FykigG/9I9sSfO4skIw1ptQYx8ltmK/lUbTykSWhrITVqzZe+nPQcx+wPwQc3HSkYpZx4RL8kbMLVM/ziznoo7P1X8jSe34+Y0RWkk7Lc26zoLYyqEjcetE2CQlIPYkqTW+gGmg9zofaxfTxUIUYgSnefmyhQy80w0JbG9rMDCg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NW9wSXl3aDZNSi9lK2ZGSldmcGtxUXQxbXNqTkEzb1RPS1B4ZWJwV3UxaGdY?=
 =?utf-8?B?Y2UzLzJ6ZitJQmJjTC91Vm5RSDZkV1RDc1paeUNaNUFYRWw0SU5iNWU0UzE1?=
 =?utf-8?B?VHRzQy9yUXZSMFVnTHoyMDJRMTFxblEyUzNvRXhNdVdpYjZxQllNMnNPbjdv?=
 =?utf-8?B?NXJhaWVtaW4yVHF6anNXTG5OUzJINmtvNEVwQTZubFdLTjJYalBUQTVQTVFw?=
 =?utf-8?B?eEZoQTdUR2VpUzM4Vlo2WkszSUpRNGRHa1JYOEZkWTNNeENXK1hPYnFITER0?=
 =?utf-8?B?TWg4UlpzT0pMY0xvQjN2ak9rcFVpbW10bGdCYzg0QkV5ck9POTc3RnRUbERL?=
 =?utf-8?B?MnlqMCt1K1JDQldISkNuQXhnUXRpQnVRT0FHYnRLVURFQml2ekc1NHNtTlhs?=
 =?utf-8?B?TEUvRC9qVFlaSW1uSk1Fblp5Y05qWE5MUUs5Yjc1aHhZN3JCc1doSkVyY1Fl?=
 =?utf-8?B?akQ0K243clpwbFlVUDFqdFNXbVQvNEtqdzVBL0hOR0tQRHJadVNSWk1mSjV3?=
 =?utf-8?B?ZDF0WjMzck9xVzhNS1A2TUFuWWZmYWl6VXFOSHBycnpGMjhSUnd4SnhPOGpt?=
 =?utf-8?B?dDIzcjlncFpLdm9DalZJTXBvY014TmVMUlRBcFFiUEk2c2E1VFV2eitsNXZY?=
 =?utf-8?B?TkdJWkhGc1VuWHRlV3RCcHFERWYxZHJzd1J5K2NvZ3Vza3lnV0tlZWx4dXBG?=
 =?utf-8?B?eko4MEIzSlJQZnNoYmJkRUxIWmlFMU40V2V3S2RIeFV1ZG83MXFaRmkxbTRj?=
 =?utf-8?B?d2FVY2xaZndXTVI2Y2xUMXV6L1hQRC9TNW1mV1dJc0RqcVM4ZERCTlhPNGUy?=
 =?utf-8?B?NE5RbVVTSzNnWHBYNldZeUJLWUtFQnY3aVBoUXFNQ3dNZ2kreVkvNWNFbm92?=
 =?utf-8?B?M1BnNmZ3MVNKMjk3RmRDSVFvZnF4dkwrQklwVlhqVGlRZlBtZ2pqaXZ6bGJC?=
 =?utf-8?B?L3dZOWNVOFZzemFpS2ZIM0lnZGNkdUVqMkZ6ditSd3NCSGJBZUZQTTBTMk0x?=
 =?utf-8?B?aDEyQXl6aExwVjlIQnowVHBMWTVnclBROHpuYTRHWGlyTzFCdGdwem9JRXBD?=
 =?utf-8?B?M2Rodk9WSjMwbFJ5bVcvem8rTDM5bVVoQTgzUXBFeGkrcXNxNnc3Z0xxTHJU?=
 =?utf-8?B?b2NxNHl1VGJScXZnOVVNdVlLM0pHeTZUN3lxcEpxNHdmbXRISmRPYzZXcDFM?=
 =?utf-8?B?NGU4TEdMWnYrU1dIdmw5TVJTUE9EM3Racy9XQjNXY2ZvZ3NVN3RIYXdDaWZz?=
 =?utf-8?B?bTN5cDFadkRBdlQ4TDRhY0Z5dkJ6MjBjTzNyZU9sWmMzemMrL2lJaTRkQStP?=
 =?utf-8?B?bSt6T3RINThNRzR5L3dQelV0OXZobXdTSDJKSE4xVmsyTFM2TUVLeUJOZDZk?=
 =?utf-8?B?clE4ZmIxanlTa2dkcDZBMmphM1lPZjVpNFgwS3M2V3JjWVhJeUZud05QNDRX?=
 =?utf-8?B?TkRURFI5R3MxM1FvREw0TzlmVmI4bXk3ZG5ZNVhyUHNNZUZXL0lwTDAyQnJE?=
 =?utf-8?B?VXB3QVc1Wk53Y2UxTVRLVENML1pLNXQ0eTBDOC93ZkIvdTFETHhyL0Y5a3lS?=
 =?utf-8?B?L1o4M0FscU5ZMTMra1d6dm1MRGdNekErYUphMGNWeU9CQWFwd3FmcHVwak11?=
 =?utf-8?B?cW43bkdVQ1R3NjlFbDQ3dlI5aTBJZHpzQ0hESDVHYzg1ejYwa3llNUpTYkND?=
 =?utf-8?B?T0JUMTZnVmY0dmxva2RubTVsRnZybmx0WjAzT1N0L3owNGoyWkppMTZGQUZC?=
 =?utf-8?B?SWJjUEtXaFlPNUFTR3ZYNklyb1hRQ083czhub1BCSzR2Y3AzOGViZnZuZnRZ?=
 =?utf-8?B?U3ZuUFV5Ym5SRXdZb3lsVzAxeXhIM2pCV1JLK3lJOGxWeitIa2x4bk12THQ4?=
 =?utf-8?B?MWR5czBvcDA2cUJPeHZnR3Fub2h4cWw1TVFydjFQSWU2dXo2TzhycGh4Qi83?=
 =?utf-8?B?Y1hzZzRuMzBDS3hFMjduQVMyOUFUQWxPc3B1TnFWUW9aVjhEQ0lBbDJ1Wk03?=
 =?utf-8?B?SmhmaHprTmIzK2pRQUdWVDRXa05nQVd0a1VNTGp5Q3krMXN0ODhkTGpWTVln?=
 =?utf-8?B?eEk4ZzcvYXlzb0l0VG0rTElOWFh0T3pJZmJRTTBWc2FaQlIzU28vWDRTMHB2?=
 =?utf-8?B?WDVOZk1jTitWT2ZGRU5wOFZVVms2RlNLeXg5VHZDRUhVNGtBcDZzaWxHZGd6?=
 =?utf-8?B?NnhBWi9uMmZnRG9naDdZZ1RDZUh0RU1SVVViTTEzZk80cjlmZFpNekNWSmE2?=
 =?utf-8?B?cFlGRzBJbVVHbVNkTk5iMmxVbW5EQytpM1lDOTFnZ1lRdjI4NGV0dEVXSUNR?=
 =?utf-8?B?OW5YQmwzMWIrb3BEeEpsSkl3L3I1dVNGcWNuOXRINndaOEo4OG1aZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571f3ae5-49c8-4c37-2037-08defb2c2116
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 00:20:08.7389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6L1DQIaB+Cxy50C9aX9G6jGND0vR1BBR2kixZtyLDePP39lejZXG6d0s3wiw0zjyNL9NS+lGE+03wPhUFtdROA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8648

On Sun, Jul 26, 2026 at 08:04:55AM -0400, Sasha Levin wrote:
> > Fix this by allocating new_mask first. To handle variable-sized user
> > masks correctly, use cpumask_size() to truncate overly large user masks
> > or pad undersized masks with zeros before copying the data directly into
> > the allocated buffer.
> 
> The allocation move looks right, but the '!p' error path is off: it
> keeps "return -ESRCH;" and appends an unreachable "goto out_free_new_mask;"
> after it. Since new_mask is now allocated at the top of the function,
> that path leaks new_mask, and the trailing goto is dead code. Upstream
> (and the already-queued 5.15 backport) convert it to
> "retval = -ESRCH; goto out_free_new_mask;" instead. Could you fix that
> and resend a v2? Thanks.
> 
> -- 
> Thanks,
> Sasha

Hi Sasha,

Apologies for the delay.

I will resolve this shortly.

Kind regards,
-- 
Aaron Tomlin
