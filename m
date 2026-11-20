Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795178184;
	b=ts67HpDBQNjqE5v8rROCRsTMnEP/yfwq44w6CilYpWH9ozqSfnDU0pa1bETWF47VkOAU
	 ljA03hVWvMC4o9pG1uaKvOb+NNsAVntEB46d4Rv5liIBbCaMzdWOnJBVnNznzGnXWsLdw
	 vdzu6mv5eIHBTf2zV4wHxYUWZAQ21W2z9tODbIEK5c4Lt9CR8ocZDk08bW8wfb8px4yfW
	 6vhJ8OHVhPsKselY5BrQafTQR851nxQI1wo/bCo97i0UJDt0r2o3CsLqr0Qw3ntf+8afO
	 5Glja4pOCs+onqI3yyM8Q/Oep05LgOgPcxkguF0OXZ7T+39wTuKMhDjFP5OL25bINnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178184;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=LycH2+Tn5mDaIiMeeApYUhljCmL4BHppnbzsR/mLmCo=;
	b=PA0dKtdDMqqu0uNaUO5eePCGyKlD7WzZV6AYUoeHuIWHh11Sdq7sZxiZNNMlDlqyF95h
	 15XyhHXEnWS2k0uqJ8ZCvTl6XCB6FpY3WbTqJZBvWa7REfNZKY81xplRh3LjV9cCXrbb2
	 lMhvrmF4ajA0Wxrj9zGbpkx5qEypBWUwuaUO2bS+mkEdWiCQk/0K6nnFF+bA+VnUJWFMQ
	 cm2P6JSNoiMiYbtm6c6k8EvlCfO3wlJTk01Uj/O8mYKK2Dk20b4lCWYCrY94JuUfhQ/i6
	 w5qXHBel3oVR+6+ByeJNsSIz2Qfm0aNzIoTvSc+dWACXnRRnbW28Fka1lA/pE3Tp+1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jMqP8DqZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.21
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFAA606A320;
	Fri, 20 Nov 2026 12:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAFAA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jMqP8DqZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utGRjtoGGJjEgylmAa3cH5JoUH4rqPeEr6WjLLX+efuhRbuxg+3b+FkPrKlgm1u2ajC1xaWxTQycGksH324QySGMtkwHmK29tCBZXQADGzNUi2DzWzeOahCGERbf3humrYcl/TmLPYLRjcNP+ybocvXOG7hHFpRwRGxRRPRgk+gVOH9Q9sO79GvHrfKDK8TY13Z78ViH8RcYByDg1JN+JpSjz7lbTS1zYLrVtYFmtF5ZXlom2whrLp0OjJ9XJydKzDlNLHZQ7R5bWb8UMiW0zeg4O/mcrWZ2YWpzs95Rh1FpLxT7wO9AB1dqlawokKFpyut1FY8GMYp4hYFn49dWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LycH2+Tn5mDaIiMeeApYUhljCmL4BHppnbzsR/mLmCo=;
 b=HTOqfAEMDzfbqewk1NcoDiAx8dFx1nhmw+2dRpfoXTpRqKbRPY313VQ1DKls4l/1utNUGzAK1jrKGDYhSnwT86WsqMyDMyUQMIMznU3UyaXKYaFRrIseC4OGBKYqgZwFnx74LO/f28Nfv/mUxpBl7RN67EjWyiiYyXzyis58PGFXKj06cA8gNfuu5apq5v55z6UzdqFPX9nauLBUouvfHEgsp6ko0/VNvOhna6k8oRGB21H8N3QBJBcTRsya/4Nm7L/AS6858B75+zrI5JsFGmmLctRULJaYHF0erDaTqm7EdavcHvYPq76sEiFkoHgg42QiwlOX8Zl4qB1zA5lDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LycH2+Tn5mDaIiMeeApYUhljCmL4BHppnbzsR/mLmCo=;
 b=jMqP8DqZcurvamZIMzth9IDeu6lnWdGTsQhBL/M53CrB2pNRt3f2xVcqDnb5Qgvi47mKO/bYtS9S4aHzNY/Gpn8MvxqlpPRHIISqAaY5LcmkBfYc4fUzsUyNE65H5FxuFBTn7znZiupDVXgKqJSbsvJ9SiNH4Pxmk0AJxnZjpAw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 12:36:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 12:36:18 +0000
Message-ID: <9a434a22-249b-4121-a390-95eaedb5ba6a@amd.com>
Date: Fri, 20 Nov 2026 13:36:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dma-buf/dma-fence: Prevent misordering for error
 checks
To: Philipp Stanner <phasta@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Chris Wilson <chris@chris-wilson.co.uk>, Danilo Krummrich <dakr@kernel.org>,
 Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261120111615.2940647-2-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261120111615.2940647-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:208:120::44) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e71af12-0794-4d53-9cf6-08df4702e001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|7416014|1800799024|921020|10067099003|11063799006|56012099006|261009223027099003|261021123027099003|261022105027099003|261021121427099003|261102123227099003|261026140227099003|261028144727099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LIab8UMrn9XCD91LzEZB1jhiNZL3pxzvbueVmtsU1mAOvll3alaLL1GlRwnQK5F+gnPJkY/VSaLJ5eawgTRKksFORhGCmmG0E6K5BB9Fvqu0J/xCBBEbwsSFbq6ALWwLw8vu6QAi6SEBFzsK7ZKa5jU0EWAlgBmPTGSzPdR8frecCQjs8cis22uen7ua99ZDoWmrXo3ZaWUARvXoF1AMOS3RERZcNoWr4xepUVFoEdixwa1T5xcGVHrrOLTFl0DMbx0aLf16JDVHMje2ibYNDNtmq2+uQFemV5G/pOaImhtaGB32I6SctCsDumdm1eFBeTzgew1+ovnvo22WCm7WxFE9PMV4YuXPjxUem8maxC84OxF2We4ZPp5L7xHtYpVrIn5eqkgUIRtJGprV0BbTxbJQj8ZMVQqKu3H5mzNmJobfLls0J/pU7IgOcqIn3Tp4H91xwxO3v+4aIH6e9ENMgv+GzTMne5QQXQdhsJRQ7WGP1d8NrBaxl82vRKsnRreTc+F0QWblsuHDopqGj1mDD3hK1QhZA51bBPZvp65iac8tjTiQAFqYkdsTsPzuvcWxwroa4mlxYr485gA+VzUXb9q+J93PQHoawJtB/YUN/tv+1NPBL7xEokj2px65g0Xa+b+/+ZNTqW/uOB0Ql18Lt4UShpwJPRZ0NevQ8HzCkB1GwGbQI4niwRGvnjo5iXMMxuJYjvvd5Rwt+bLni6YKog==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(7416014)(1800799024)(921020)(10067099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjMxN0tiRHg2RU53QWFsUzFjTDcvTDJhK2lhVG9hdXZlM1FlN01mQXc0ekhJ?=
 =?utf-8?B?dDZRelEzVjY3OU5kV1JZeWtPdzBIVm4wNkJaUFI2UzB0Qm0zUm9paVRBY1BZ?=
 =?utf-8?B?Ym5hdUtXUTE1TUtabjdhd21kMk1xSnlMUmZQV0FBSk1DaHQ5RldnUU4zSjNN?=
 =?utf-8?B?SlkzbnUwWFZtZkNBUXAzdEc5dk05Y3ZUcXQ2Wk9ocHFXdXRuMnpkZjJnUHll?=
 =?utf-8?B?WjRqSm01ZktTMkdaZ1EzL2p3TXlJZ1o4UkYzZnJ1RlhMZzFlaFpaYjQ0cEov?=
 =?utf-8?B?K3psNHI2Qi96ZC82RXhCT3B1eXkxOXhxZnRUQnRYdng3aWlJdk10R2h4cTdB?=
 =?utf-8?B?M3lPZGhjS1ZzMTRqVVhIRzFIYjFybmgxUmQrdlF6TzdaWVc0NlFQZjBqc3NF?=
 =?utf-8?B?Rno1bkZ5bUlTZXpaaEZJT1Fpd3pLTWx0aVlucEh4cEN0dlhkVEtJNjRBenJK?=
 =?utf-8?B?YjlqQUsvMEZ3Q3ZRMGNZbGY4SU4yRHFHWXJuL2RRRzdPMnRjWWdPVWovZThU?=
 =?utf-8?B?MDJOTEdjOXJnaXEwSGhWM3oyalJaeDdVNkdMa1lWdlEvV2cyK3AwbU96aHRz?=
 =?utf-8?B?QnZQeUIwNmhCaFRUTFNGNktMTWY4SERYTUpzN3RFUGl4cjFpaHdrclVHcHIx?=
 =?utf-8?B?WG1uV2luUlBGUzU2dktWeTZjcnVkM253UHdZYVlrYUJ1Y0xVY0xaamxhb2ZY?=
 =?utf-8?B?czV3RDZOYk5ZK1puZkl0RUt6SkgzQzNoVnFMalpYMGpmOHh0cmJpYWlrSURB?=
 =?utf-8?B?ZEpaOEdTdG9Rem1Ia1dKUlMzZE1acE1VbksrY2plUGFqR09MQmk2bVkrTUVL?=
 =?utf-8?B?Ui9XTUZVRVVEWVFjRXdGWS9sNUcySFA0VW42ZUZtaER0cTQ1K1NITWx1b3J6?=
 =?utf-8?B?YlFPM1JHLzZrU2ZNbDBlb1VNUmlvQWQwUUsvZVNsK0lMUFJpTjFjOENrTUU4?=
 =?utf-8?B?bTFoRitHblBJMVdKMExicHUxWE1FcFJnZ1hIS01BMXhpS2NDWjQzc3BTNTM0?=
 =?utf-8?B?TUVDOG1CN3BhdEI0eWRpT054SUc0T2dXNVJPTTBrY1NGdy9TQTUxOUM0bmhJ?=
 =?utf-8?B?NS91V0pldzdSWkpsc2xEdEtXS05LbHRiTnNLNVNnOHhiZG5WQ2t1UWIwdzlm?=
 =?utf-8?B?Q3h6ZFZTbE5wNWZBZis4bXlQSDhGUnZMVElPNnh4NTFqZXowSDdGYm9VMHZQ?=
 =?utf-8?B?dk9iNWswYzkwZTNwSDgreEgvY0R6ZGRaMGV5Q3doYkFMWlkySGIrUWROVWx3?=
 =?utf-8?B?YlgvbFV2RmhoQkd2ai96OTB5QU0vdlM2OU54VEFaQkd0M21SUGFEblpzT1hY?=
 =?utf-8?B?ZERjNjY4TG8xaVhEaUx1NU5aYXIzMVkwNElmeGJvZkdvblhJNjgxTVRzd2VX?=
 =?utf-8?B?KzFVZFNwekZBengxbFJPbnQyWjhJK3NWdWlCakoyNjRLUHB0ZW1Fd08yUmhs?=
 =?utf-8?B?b3hwT3JHQUhCb2V4UlFsd3I3aWcrcWJnZmNXa1VnZGFqQzlOOWprd0Fzay9V?=
 =?utf-8?B?NWtUSFlqOFNKWmxUbWhiRkczNXBEZzBOT25UZ1FsVGNjR0FrMWNtNytSL0xL?=
 =?utf-8?B?YU5vZU1GNWpEd0Y5YkVLUWJieFBuL2h6OVNpYUpoVGRCc1RXUkZKZEJZdE1T?=
 =?utf-8?B?NnpGdFdidDBKUGs4R054TC81QWh3SEpSY002S1k4L3IxS2p1ZTN3cENqS1Q2?=
 =?utf-8?B?cGJteVk1MXZrenE1WStKMnFtYU5hWkp1M01ZZ0Rvb1VlZjRrUDkxRkJyaVZh?=
 =?utf-8?B?T1dTR1E5c2gxcnJjbTZOeVNSZnRiMkkxeTB1dEdHV1lpbUZvOVRzcDZEeTAr?=
 =?utf-8?B?TzJwSDBnM29IRmxIQXhHWU5QWjl0NUtCMjYzYUx6TENCTmRtUlV6U0FLRVVB?=
 =?utf-8?B?c1lYOXZ0U1lTWlR3MmM1aThPR0JvVmJxWERnZ1JOVkFLT3pTMXg0Uk1WMmtB?=
 =?utf-8?B?Qm9qNnp5dy9pRUt0cW5jNE9QVnp3L1NKK0MvVFhXbWIwN0o2NDFJSWpSZ0VH?=
 =?utf-8?B?YTFiZ2FnNlRoeVgwWEpES2c4TFNEeENwYzg3SktpRGVxVnN2ZVRMM0M2blpj?=
 =?utf-8?B?U2Y2VnFSOW14d1RQZTNEbFF5R3ZXVnZLRGMyNVRGb1dCdi9PNDdWcHJxQkpu?=
 =?utf-8?B?Skd1OW5TNWJ3OEdPU0x5dHhWM3lxQ3dpM1AwWXBkUlRnTi9jWkl5ZE5NRUNs?=
 =?utf-8?B?RU0xM01tT0xhWXNBcXZkYVFaU2NndlpPa2U0WWI3ei9hRXlob2prTE5wYyt2?=
 =?utf-8?B?aEJiTUpUV3E5aUpJVWd4cG1HV3NSb1BvOG5CSzRROU5WZWNUMVZrY3N4TWZz?=
 =?utf-8?Q?xLXrWhRHg4MNhAzncY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e71af12-0794-4d53-9cf6-08df4702e001
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 12:36:18.5121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nw/e0CgBU4qYEzoguQSw4SwYiuenA8pzMZrpsKIYwJaq8y1E55CWKgY7QEh+nsFy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602

On 11/20/26 12:16, Philipp Stanner wrote:
> Many users of dma_fence do things like:
> 
> // Thread A
> dma_fence_set_error(f, -EINVAL);
> dma_fence_signal(f); // <- test_and_set_bit() orders against the above.
> 
> // Thread B
> if (dma_fence_is_signaled(f)) // <- Does test_bit(), no ordering.
> 	pr_info("err: %i\n", f->error); // <- Can be loaded first.
> 
> There is no memory ordering between reading of the signaled-bit and
> reading of the error code. This can result in outdated, wrong error
> codes being evaluated by the user. That's a significant bug when we
> consider that fences' purpose is to propagate the state of jobs running
> on hardware.
> 
> dma_fence_get_status() does take the fence lock, presumably to ensure
> ordering, but it is broken, too, because the read misordering can simply
> happen within the critical section.
> 
> It's not entirely clear since when this bug exists, but at least since
> dma_fence_get_status() was added, which is why its birth commit is
> marked as the Fixes commit here.
> 
> Ensure ordering for everyone evaluating the error code centrally by
> using test_bit_acquire() in dma_fence_test_signaled_flag().
> 
> Cc: stable@vger.kernel.org
> Fixes: d6c99f4bf093 ("dma-fence: Wrap querying the fence->status")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> Changes in v4:
>   - Keep the hint at the function being opportunistic. (Christian)
> 
> Changes in v3:
>   - Be more precise in code comments and commit message about how the
>     ordering works. (Gary)
>   - Update the function's documentation to inform about ordering
>     semantics.
> ---
>  include/linux/dma-fence.h | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index dd07d128adc3..64330bf52561 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -487,16 +487,23 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence);
>   * with the fence in any way. The user must, therefore, ensure through other
>   * means that fences get signaled eventually.
>   *
> - * This function uses test_bit(), which is thread-safe. Naturally, this function
> - * should be used opportunistically; a fence could get signaled at any moment
> - * after the check is done.
> + * Naturally, this function should be used opportunistically; a fence could get
> + * signaled at any moment after the check is done.
> + *
> + * This function provides acquire ordering. This means that all stores
> + * preceding the signaling of a fence are visible in correct order to users of
> + * this function.
>   *
>   * Return: true if signaled, false otherwise.
>   */
>  static inline bool
>  dma_fence_test_signaled_flag(struct dma_fence *fence)
>  {
> -	return test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
> +	/*
> +	 * The release counterpart is the test_and_set_bit() in
> +	 * dma_fence_signal_timestamp_locked().
> +	 */
> +	return test_bit_acquire(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
>  }
>  
>  /**

