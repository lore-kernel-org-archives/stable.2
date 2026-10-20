Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792501186;
	b=oEGL1sWX1R7nLxXDSb/lFyfgoEQ0+GMF7a4yc30vIgYCDOFzgU3uFdJpqQvG95/ylL22
	 MAHKA9YR1OO13oxpIp024pIrI3eHAcG0iv4FOb7AphQbhAUHMi08E6+c783HjNM3Z8itN
	 X44Qhc5UkMlTzN1MXr11mqJw2jSTXW6NFg+lhuSgyFqDnCZJNNuIhbB7DIGHgJyqPJZ4g
	 I33zuD64hoeQ60sPHFQ6X6RcmIFLPFf1MqT9ZqcK2fsnMhUBKkZDIIi3rPRxgy7z23INl
	 ZvDIsi8PfwfzKSNXP7/UGCiavl7QDB5cNtq7dqLMe54fus6oPcpp/7wsXR/jco09faQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501186;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
	bh=id7jIwB19LdMVoHDpx9TH+hSZVUZj9h3QiMmI1aQF5s=;
	b=4Skc383j4c0clHnFyWk+iMtxn62CqebH1YBUk4gzKaWSAii/mczCzQEE4TomCfSpA45r
	 UpAVLjPFpru2R0E6nXYkKKIyyndkCmNY4D75h5WPLHDsLJp35lW8g0GUd6KWII1lC3QLV
	 ZhDK2xNqrou2Ph41duD7xpL/I/AaQ76DifWqsbDv67CGi8KCtKr9ZusRBewBBHiLgawgO
	 2ysIcQPQr5Yvtdld3OkgU+47gfCdhc7xqFXmyvG0osr5JHrU7Gi1faOBFPUdDkM8GKpPJ
	 ubPNpUXBcSiGkLXtgGYVyS6ZHegowFTrApKp1rpE4K31DKEyEitfMHBz1lnuxb+fwNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NRwtdsWH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.64
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012064.outbound.protection.outlook.com [40.107.200.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5D0606A323;
	Tue, 20 Oct 2026 12:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA5D0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NRwtdsWH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Apc1qXCO5ZZXLuHmHyjL7PBwgjeGlMmiHLMaVJZp3qt+vMbM+3+ZzR3dDZjl3DxWG+7aVxokM6nvkYqsoo+rm1JzJyvyQEUx5229w2jYosXZfOXJLFHa2wpr25ZWrml4LIuRwLdhPzsK6XMVXqEoaxVi12LqYcDuyFITfg6aXAULmBKRQGCtW7ZqfAKA9sRkyovbpByWo/1wXDViJbfPQQ4+ykjMXbJeEiv0fD5CYwYVPfOo1IxjDnkaa0nPNKAGGL35i6XTVOo8ob47FWJXixL22ytaKd4Y7HYiTmE0mJnmbUvK878f0fgaD8hWZo4gCoLDDQfBax48EcxSNAECKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=id7jIwB19LdMVoHDpx9TH+hSZVUZj9h3QiMmI1aQF5s=;
 b=mMhv9WTXvJAUw7zOtGN8oUld0C6eMyXbd3fD1VGl4ja20I/Cn1HKOPXHOqYARE7P5CBcRVQHOb066hN9wfU40FMSkbXE6gGh74D9c4aWpRjnH1HJ01x6OU3AinTp03ZudCvz0P7ijIlFzDKYiXLAVTmInBYgykE1JhwXkXYTZkIiHSJkUlqBAPo/mt04cp156hLUliBcE+IydxUehxU+8+uf8oEc3RaX9Ru/MdZephQ7ha7ajPe3zRn3XjJFNcBZu2UqiG8OOeRS3pfyZDjpGX5YsfXInfSUNd314r1zPgNuJfxOxMKQwhvGnQNKkCkdj367+basvtN2Lxz8qgqnjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=id7jIwB19LdMVoHDpx9TH+hSZVUZj9h3QiMmI1aQF5s=;
 b=NRwtdsWH0h1TfWgfqvpxSCMWMaPIi4Zooc+WzDyImVKTnMu1kWZldxxv6o08kyAc9XWJSX8GlffcwhWsh728ahqUQ7hWp0tvaApnTO84pdZ1Y6/+PugQKfNQU2AuXLYGwvPzG5BbiUEI9nNjZ66p+fEVGOytbjl5LSiuZurXYFwNAqJF6IA7MSGvL6/jft90PDIur/7SKl11T4Y70V5YaJCL2CBfuiImm+byZe+ewYxtulmsVDHDbpL5aijtRkQgU0H51f09e2HIpxTTz5401UGYM+YfZ7whsAz9u1cABzlPIhNGpHPxnohRyhPYkmKg8xXweVycJ3hviTome/dTug==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 12:59:39 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 12:59:39 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Kent Gibson <warthog618@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 6/6] gpiolib: let the character device free its IRQs first on chip removal
Date: Tue, 20 Oct 2026 15:59:25 +0300
Message-ID: <20261020125921.2896041-8-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019090013.GA29798@rigel>
References: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com> <20261016-gpiolib-chip-removal-v2-6-aambrozewicz@nvidia.com> <20261016134003.GA155960@rigel> <atXXi_EA6iROhK0C@ashevche-desk.local> <20261019090013.GA29798@rigel>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be54482-79a0-401f-c2e4-08df2eaa0036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/KNUM4iPVq5tYa+F4drac3jhk8W3Yz1b6bbSPNmPkRJlImYN0LrYYbUBfE9TetlEBjFhMff+9Dp4+du+NLycXofFuS4il2uN0eknrExNy4EiSIr2ULHWGYn8TrH73z6TVdVsVq1EWa6d3FThaEJwfPQWAyuMuQcSsskYWv/ba6Hy14rZpQuV3jil9tScvhucfhgpS8RXQ+VFfiyKxhVPmOVjOlybBS3Ucavvr5xLoCa5IO84NPFf3syELe17XfyP7GwTQjMHcNG1K9bTaRxrZ74b+Xp9m9UtfoeSPZ7KzGMzBfcgJwCLTo+f4li630AcK2kVrMPBp5/CankgzZXIaO5xQMhewkt3Ph9yCehLled6cqNR9tTScPL3AJ/DeTC1/lqDJxlSS+nK29RiQWf6NkdTab7lVdLPBNgkZ0q0xZvLR0fjChv9NFkAsjqmDLq1QkRT2cggR6OhLcEzc58yiDxMXFIoCou+J0+LcjguCi3bvf0L+eB++aM4Hxf3Y9+8CcMrgSFaUMG5UEl1FYuUHqNa8jRA9jC2a24Vh3Mt59FpzfCwVf1NFFCUWoouqSMqR+DWVW45vwwIDrmAp6dFQ4gLtKqUHIZ9xXO8lz4+DSrm0PfxnNrcTvAlR//pt1Dcyf3DOpZ8boUPd4XpQNwTfRe3ck3GaDE2wz/gvVmGHOI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IdI4syc/6rrTFZD5jiXnT5pyRtCMZIn2QVhBFbzc/Mjn4LJ0ycX/kL7UXF/s?=
 =?us-ascii?Q?bE93Tb974KAdYzoCf6fcU3kNYbLVSOLrNnXgmfK2al2vEMd3QN0Nah1aC43d?=
 =?us-ascii?Q?zUj/+R13Lhi0wvuqLupe3IzUiZXRWqBvL9oEvfbJcrl2sMqgAWvhcPxrgXDS?=
 =?us-ascii?Q?TmXxWec928+QJgSH6Fcuy1esmQEctrr4wuBPsN4F4AE88NWQHjh/CQ/bZ0UG?=
 =?us-ascii?Q?pyi6w+ESFFGdX4klkCuWZXTRLDvwOxwleMbbjqHFUwS7k07PqlpSqaZek2EA?=
 =?us-ascii?Q?RYBvOuW2u7DJP5Vmd0MpIs28isis394YjFYAcnIAkHJOpZUUCjG3Ul7xLCTb?=
 =?us-ascii?Q?tYQVM09znRrv+gEGHE4BfczS0cQ5eyPCvfuC08CaLBG09OmKwTPSoMO/DLP6?=
 =?us-ascii?Q?7uw4Fsc0cJfon10lWJaMOYKqKuD44CyWUSZ0KikS2Q9Pq1zAb5LneuF0UuDR?=
 =?us-ascii?Q?GcI+JMASBv+pHRhuGH9HUw+3WivQa9X54fsO/p+z6rKk/VFndYAdE115briO?=
 =?us-ascii?Q?LZm5jlSsxQyy2P8s/+J+wwu31rf4AV+RneHjhJeSGrad5jtw2iJJpqYyEDoe?=
 =?us-ascii?Q?PjvK20PajlU7AZwCx03CZ3mHezGh6EaIkBaqaS79mIFN6cawX3pqVmJFvPuu?=
 =?us-ascii?Q?6EhrLHCw5dht3QqbDXqtrTBmgtLnuB+Bt5RVsFgGNRXXWzboehT3KzkX/xl+?=
 =?us-ascii?Q?nL06sMTK/dc+xSXcpgCMbMB+A85HwtzueuQF94dMdRSTDlY+dg0VnbzVq/eK?=
 =?us-ascii?Q?HYLXy1RHIxZk2tkzanIutOzLGfu+Gi17wP8YLc0z7vo3qhHbdyqHwhrIwJPS?=
 =?us-ascii?Q?ZUiwzXmaae3lOVllPZM0+ukCXC4Ck3zX8hFxwK/ElJK2KJEOQ7UAAFULn/NV?=
 =?us-ascii?Q?L4pUeseRwgAIJfd7rMdgYTexPIxCDx6AxXyw562f/kc5u0000HobJKrfZln+?=
 =?us-ascii?Q?Ek1ZNDuukLes19semdY1jikFO1TzwDPSDk2pIRzAmLKW1EPdJbAhFrNuMLtm?=
 =?us-ascii?Q?xQ66b3aGFTeGtUK6OVoCg075n/dnrGDn7Ndlp3RsHu73FlchiGdTWQFk7rR/?=
 =?us-ascii?Q?ZKQpTkDqJggU3tJVgky11GZwb/x96Pr80ZwfGdWpTECzGxct/gYcuPpVzqOj?=
 =?us-ascii?Q?OpBIf5Ut4qV2fXTYvzyMGHHASqBpXM/wRrM1eAbFmqEtTfFGQMRss4MAytL/?=
 =?us-ascii?Q?dyPE4pZFjKmphaMekUeBodyc2WVHwg+wwGLCq9wCKNHvsF4AhmMeXtVOtDBQ?=
 =?us-ascii?Q?LdkBTK3y83cZgH+asPOEnS+7P4cSWKPmyD6DWL6GU7rVrwx0arEjeV+hOsKs?=
 =?us-ascii?Q?k8sQV+OTwvvd5v19Np78x5p5iTAeBpjUbioVdwatYK/80n5izYkZnClLlT9W?=
 =?us-ascii?Q?fcU4HWPs4uiwgGvdWNcuABT8D+DjXWOD6PogAJFifUdr7WzZQi4pMxbsuXuc?=
 =?us-ascii?Q?7HmWOJw8da+mADvZlAUTCNvVTjyAiRx4o405EAl99QoYzu4rrqJvxv3FWBgq?=
 =?us-ascii?Q?2p1YwV7SV3PE1k57MAIEIkrcl9fX0ceGtZBTELsjJXEnOaqQJRSNkD/v/x1G?=
 =?us-ascii?Q?43JnNJCCFFjI+Q8CJ/PpJ/YLlB4UfKplU2vWknYfJPZ4Sfq2uZjAcTzyIq6R?=
 =?us-ascii?Q?xY5cexzzVgx25UqnJdMxtjPNa0V+eC6lv6vc01iCtfSq5xb+pxjiNG71LxpF?=
 =?us-ascii?Q?0ckp1kDWzqCEoqaFtEPwvmVRIfhKHoCYylJyKqk9lrhix1QzM92cnfxgV5R4?=
 =?us-ascii?Q?d+BQ3YOfCQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be54482-79a0-401f-c2e4-08df2eaa0036
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:59:39.3557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/Yuz2LwpwLL1aVownHRkPEKwFdJjwYqccOj33UmH+WqV0opFv1yW+TkY/AVFN7+4RL/TKd49aWLZrzqyIXcRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414

On Mon, Oct 19, 2026 at 05:00:13PM +0800, Kent Gibson wrote:
> This way is clearer given gc->to_irq() can return 0 - the <= condition
> there is purely because of its possible return values.
> Setting irq to either 0 or an negative error code, rather than just returning
> on the spot, are both more confusing and pointless.

Agreed. For v3 I plan to go back to that form (return when there is no
->to_irq(), then return on irq <= 0) and to drop the comment in
lineevent_free(), as you suggested.

Andy, shout if you still prefer the merged check.

Thanks for the review.

Adrian
