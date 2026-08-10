Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931592D1907;
	Mon, 10 Aug 2026 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376932; cv=fail; b=e+0GWlSZ4nXeqU40GbRvj9uKhO3hqovql6B+tEFd/WYrgckkxGa5KT63UfgyidVb+sc6k0t3zj1aKtr/qSPqDJgVFR2EXHq/83v0eBsdNnh2oW7JHlixTReG0E8OyD4M8i+cbAcOf+FVFGyHdHBbHdHAI8nRI1gAyGm5+MKgJwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376932; c=relaxed/simple;
	bh=hikQYiZKGBP/dUrBUnm2AapK+z6Xp+9aXTuFjt3gJg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sqxhQn+Y96D5d4xm/0+H4HNCYKG1V3FYyY0CfgKrcC/agSIevfAJGGXJT8fEwcevnWPb4jSW0+kXb9SQJSPY2RjDdSJElp+qyll+EKbJFdKli9Ej1dT1ht1C/pDFXB6GhOLRqIlpVFWPZwTh4iiFaDbWG+/dY07hTrgbFZZptmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LB/Q6swr; arc=fail smtp.client-ip=52.101.57.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LB/Q6swr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6cYHGXo1Jvbqf3O9JndKaw5DcFyQMtHY/8XHzJxF6pOcuKvqt2lywnx19a/UoCcpif0nbZ70rPlEEoiAjKOWxyGOtuVEskcjwn1oh/MwK8QJ+wAkP9+W1AHzeqGHW0teBPK9KTr4W+UQn49qfPtuh+0W5fQURTVLq4ws+9tfqqqc5EAE02IiceXWUImbey0LqY8cFERYkdb8XR+k4mIEPBhX849YVI9Ss6J0KsUnWgJfO0K8iQ3gJ/ng+t9ywxIwAguPN16kDzS2gajPGU04PjhReAI06kSBX97gFosBs2pYIt1CdOWBs4pI09MLiyFkAwAdyCb3d8BOYRlmN34/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rp/848+j9IiqdZAe1YdGGfrl4hbBcdQ0tr0avKitAUI=;
 b=OZ+T+KWqU0ArTYf4+dwu7jn6yZcCTkJFifPFJRa/nRkagUDnIxKyC92z7ok2Oz+R93DoMqc0/4FgMHg1Mx4k1nK4uPHzB9K2SWlfB7MXU1rouWHQgaWCh1uDVqmdW+91URZC9Loo/++EQoaSlAXYF9Nsm2jiKXRr5OnzD4sGSSmb1jaXLkmYZ1ZJ+6M/BPFfwI9gEylD+SvE5UpDhs2AcBdEFXA62rfHdLq76WT0MGGUo2RMqU9r0zuTBS+GUOs8PJHKrvTCeaf/eV6gC52QafQtvZoCLXbcDYzYwz489t9aN8ll76SUniafYI5IDZd4sxzFuGi8kl956QuIGdZ8Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rp/848+j9IiqdZAe1YdGGfrl4hbBcdQ0tr0avKitAUI=;
 b=LB/Q6swrhyA0cuoVvAe18JoZaqWuHcfhwDP+R8fnJg/3KhyYB61dZPsYcU34YeWqVI/+9HnY8WDzPL40zv3ThWeyyCvN+XdQhrsGbcNqHh2np667NhfNB9ySKXyx/QwIqGCZse/3qz+MtPW8Xeg+UH6b9S+Ke9ZmSGFHb7pjMNhA2G4TFeZZ0M2YmfbPvbWAs2erLwTpSRxo+xDAjDgWF+pYBKSWf7VX80RlRXioYBpD4A0cVIKuoobfrP2obaIGyg6/y8jCRL3qx6dt3endhdH8xvnK6CRYis9445u06s0oOptIzruCoStKlLPs//aJjBH/Pzl7Wptkr65N/xEHSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:48:42 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:48:42 +0000
Date: Mon, 10 Aug 2026 18:48:34 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Baul Lee <baul.lee@xbow.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, federico.kirschbaum@xbow.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net] vxlan: do not arm the ageing timer on a device that
 is down
Message-ID: <20260810154834.GB2803521@shredder>
References: <20260809111829.78834-1-baul.lee@xbow.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809111829.78834-1-baul.lee@xbow.com>
X-ClientProxiedBy: FR5P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ee1131-4507-497f-7613-08def6f6daaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Y/P4GQmXcVZ8s8LeOX2I9L4Aaln/G8O9aapWuhiK5AOIQ0Mfsu1aEMPLUMDFeOpfAvwfwFX4ipEFWjjRhMLFbOpJRtqiyb/HoqbOLeV0fWXUD6/eSA9ROxB7IAS+SDsicxq3aW+bW0X0U4tV4HPr74DeJzplcFnetWUJRpw2o6/CHA5yXDP0Rypb61JaoRR/uqwp2MnLt9Gto4DQL20e6YDV01txyvx+lbGylzvmBMY+aLY01aCIAUrTyM5w1JwxxbemUxnv4tH/wTCPmsskBFj4Hfo6rwVQZ5Oxq3sD3RNXx6r8g3Ao2RCB7e8ZdgLVVTv68ZWYFQFAazwOle8n/nT2zrI1XUFiYwYKZUgQmT6bhLDN5RnrPPIY7/TaZxTWpQ3VfIqhLMpxJgNgaepiWkSEt7FjQDgUyslH0hw7TP2PgeSgZCkKuhqQh4qKuENJ4gxLtShMUv6F2vYOXoSXMIrxsDepWKNKBUE75/XgUz+auXYuN7Ew09qtXPq2uYRIAS77Q1TIIYmChBEqSqjt7tQT8n/JE/2/3+/7rcpIJ9pXfepQxCFXePDj2xPFUzsHv9q4UgdXafRJaRZK+QxaBMlA72OeI8P/kD0qPA6nltjY6Sad/uritj0GIa+nXLZLWar21pV3NI5WCFHXc0PsSKWTDl4WyNu7sokjQRJaSbo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vl+xujnzML3ZJRN2P2h/Aa4C+hVEc1bn/nldtZkXLm3lQBYvdX3qucHIH3hq?=
 =?us-ascii?Q?r0ccpOFrfFX+zGHNDEJFaWLXzFXu5Gx1r/rlFmXJPuu4jwkO7DX3GL7xc/M4?=
 =?us-ascii?Q?5GdYTwhqbaAxLcb8fjGj9ROLSyU1FaNKgxHxJNcQ+6M5Rj5txIUGpnn66KcO?=
 =?us-ascii?Q?GjelNwLuOrW70wsZtQITW5MBKtEgh5ORumEUz//5vvjwhHpjpDXFcqpxwLCB?=
 =?us-ascii?Q?y1h2ERkigM9c+gCNm6VrHC3p1WW9GgaJdnWHrdILMsKiysnStBydCKlh7mBk?=
 =?us-ascii?Q?JTnwncd7WMS/QmeSrWbL0hEuQLJnd4KRwZ4SvNQEqrzYF1TfJJ1yrnylvHE3?=
 =?us-ascii?Q?vh/l0rvZ5L6ebmK8R2EtA6j63SLViw47csmEMUFaPMbHvqA5Lot5tXHSOIvM?=
 =?us-ascii?Q?+RmuMVlN56l9qE5aCNAdpcwCQK5EnbMUjRU2QafgxXULkpJdHx10skdnG05S?=
 =?us-ascii?Q?KEnr1hTgEkB/bz0pswv7/shKYjXo30ry+idxdWk/sxol7lxwpE5ncq4Aj/bE?=
 =?us-ascii?Q?wXqcQAhO+JMldbtHO+/26sNqdKSWgKCYSgSWZ4gQwALprByk9d2MXMvrXR6K?=
 =?us-ascii?Q?5QGre7kYIBkDPENfuZQc5HjX/1AciGqbr2F1IG+P4x18R9ArADRk1g/3ZsOP?=
 =?us-ascii?Q?aDTOI1sSSBS7kGKRVTkeT61v2L0Fo/OdEGJgx8AHzikXlFaC50D2pby5l3sP?=
 =?us-ascii?Q?VBZ+ydWPqVb3VoSE97Dsq+FJHSfUFZapGkpsNMsjBNrFvHCRyGVO6+b2YO1K?=
 =?us-ascii?Q?KYpnrenpLkJ+Q6Lq/L/0L0yPGWEAlY6fky0pL+IhEP8tcF1P8/OwFda0FZWK?=
 =?us-ascii?Q?XP53HpCoYYlGMm+k0A/jVZiROnAU3Qy9bzQzBBvgMD1RiMpk7CmEAlZScZxz?=
 =?us-ascii?Q?1zSrvK2EnNg+/Z2aFg4yI30WbnkN5sPqONNu0XALujeBGoT9wSvQBe9MIwXv?=
 =?us-ascii?Q?/iptYhTu0RU2Qno+T7tZXJF2/pl60h0xVqv/awtXJrXd4luFi+3rc2gJd5Jh?=
 =?us-ascii?Q?AL0SDYBBzRDielkOGE7gJTRQ3NhDH+ffHY7SrV2+XLMhRj9jA05qFGjINfWg?=
 =?us-ascii?Q?oAp9k+sfS32X0GczWtbOV6c81L5Oj9HAyCptuo/EfXSSAWfxFf4jcgMmTziV?=
 =?us-ascii?Q?wIKyAFPP4FF4WpnY8y+Uxf3b5Gy+dyXH7YWVC4nlNRZ5bj4ikFM763cZQ5mc?=
 =?us-ascii?Q?Td4e20EXJm2Gxqc99jaiGX1S5QRN2ZBCMfgypDxHk7TjJK+xxkBtG9KlJWWI?=
 =?us-ascii?Q?vsW3J7ePVPW2R+aeNB8VG99QMsOoyvqwEGydQouM21yI4GK/lRy7AIJSY1qi?=
 =?us-ascii?Q?BqOYPT+k4p5+IX6qEibVtcE2Qsteyf9arDagaFVdMGlimEkt5rh/QcnYDetQ?=
 =?us-ascii?Q?nvhy5NrE997j/ssTwk90AuURTt/MWU6H9GsTvFze/eyfENQrI6jNAmPhrg5m?=
 =?us-ascii?Q?jSyaoDEcd+Lc0j6rIdILhyn/M9PB4xQt076BX/bh3PxASoJ8zB5+f3wI4YS4?=
 =?us-ascii?Q?x0mpAPV1GC6QTvVFYhyOztWCCPGG066RzmGg1dy7jqQwT9oq19mkrt51AeI1?=
 =?us-ascii?Q?sPp1Zr9ekYID7GLv3qQt7YWNYb8C/eohG/xMbm/UbTqa9azvTRlXZpYwd8b+?=
 =?us-ascii?Q?Bfv7dRYwZF15nUpVFKM73+9Nl4BCmt8CkRw+I7McA+Seo95CpWvwlYb3NTz+?=
 =?us-ascii?Q?MGtaq4yBMz02AUXNCWA5jOkO72Y9VZwAcLmxj3wDu0+yhY2D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ee1131-4507-497f-7613-08def6f6daaa
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:48:42.6563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpHa7RRhAzMjecyJP32yxRP9SAW/ZRBPtk5FNoRfSkgbryjifaTvuezabx+5ZX0jgSHGqdJmZxoCBiSipfnVhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072

On Sun, Aug 09, 2026 at 08:18:29PM +0900, Baul Lee wrote:
> vxlan_changelink() arms vxlan->age_timer whenever the requested ageing
> interval differs from the configured one:
> 
> 	if (conf.age_interval != vxlan->cfg.age_interval)
> 		mod_timer(&vxlan->age_timer, jiffies);
> 
> There is no netif_running() test, so the timer is armed even on a device
> that was never brought up.  The only synchronous cancel in the driver is
> the timer_delete_sync() in vxlan_stop(), which is .ndo_stop.
> netif_close_many() drops devices without IFF_UP before
> __dev_close_many() runs, so that cancel is skipped for such a device.
> 
> vxlan_setup() sets dev->needs_free_netdev = true and age_timer is a
> member of struct vxlan_dev, so free_netdev() releases the allocation the
> timer lives in while it is still queued on a timer_base.
> expire_timers() unlinks the entry before it loads timer->function, so
> the timer core writes through the freed object's list pointers:
> 
>   BUG: KASAN: slab-use-after-free in __run_timers+0x208/0x654
>   Write of size 8 at addr ffff00001adace68 by task true/192
>    __asan_store8+0x84/0xac
>    __run_timers+0x208/0x654
>    run_timer_softirq+0x154/0x18c
>   Allocated by task 189:
>    alloc_netdev_mqs+0x64/0x720
>    rtnl_create_link+0x4ac/0x520
>    rtnl_newlink+0x758/0xd00
>   Freed by task 191:
>    netdev_release+0x40/0x58
>    netdev_run_todo+0x4a4/0x8c0
>    rtnl_dellink+0x200/0x4e8
> 
> The rtnl operations involved are netns-scoped, so an unprivileged user
> can perform them in a new user and network namespace.
> 
> Arming the timer on a down device never had an effect: vxlan_cleanup()
> returns early on !netif_running(), and vxlan_open() arms the timer for
> any non-zero interval once the device is brought up.  Add the missing
> test.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: 40051c4dcad5 ("vxlan: Allow changing ageing time")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
