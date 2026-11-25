Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795609325;
	b=U95bYHxF1PCrL29jm/9iIH2BhsNaMqi8zOjpd82GBFWPqqhRMXVRtlqybIB6eqgb9lXW
	 QHgKCovdJlYljxbbXwFRv3vhfPcKPjrx6G4i4GJEE+PN3FFeNM7D1GBAu6Z5vqti+9MbL
	 5y3ah5BNQ9/M3+CrIp1YFX8HtuHPYK4YoKE/xUBHnZgd5lnBBwUpQkGEeKZC7ppvL+I4M
	 6UJLSD1h1/4B/yiQG1URA9mlwdNSJNoYmYu+DDkcZ/aG/xTUpLOaZJNvn0TmQ9VCNaWMG
	 ZefZBStX5exGzoy4n8M0HuH6+1K+2+PSlDnLX0pjsXrKIUMTmoWIRRpAJM1r0J2KEPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609325;
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
	bh=d7NivdIpd3tMWoY0pSI5XraZ2oLoG62ldKLJDnJbf/o=;
	b=aRvwP1odH6emvV5Vm3DEbp8PN9yTn+TDdsf5vRa/5x2pld70c239gudSC8+1RuNNXQr+
	 82CoWXe+93bRkXbOjUdYbSbqh4UzwAT009goJKkjw2l4I5i+1NiUxs6k1su6T9zFGN1TG
	 H9K+DCLm83Q90xMfHR+Y9Y2FxPD7wm59azUebaBviq3Mowru4mvliVGOaz8MGmegWcHqr
	 3zX+GHxNhxeE2dIVpjDZmHTrWu1+XeujltlPvamy7YmH5r5BXnzeJmK414DcHGSk+Qinl
	 OxLOnbKpnBNEoIGZJMFdvWyJ+IVP4YUZ/WyZT5Hf3VYLm8CAC42aYXLawHdVIEMhyuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MIdMy3Ue;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.27
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D6F606A683;
	Wed, 25 Nov 2026 12:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72D6F606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MIdMy3Ue
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRZPRXrK2xZ+2Msa7wKk4OoZ+k78aic6tWao0RJ11CGMhHKcP/6VvgYJpTCClu3dmBxZQNzPgCYnFFNzbpxqMysnRQ6YY9Ka9mGpjUmezcgm+3edqgZ4UIvK8IN7woFiMS0URJGwTA99hqHPjpBXM2c+5lZvpQXbSL1QfasKEIQF+l+fsctqbhu5M5D/Szb/DONFwLYWC7KTiojjaRTpKIP/UeYJjiKx7x0hw95aZRqMOby+/kgv7tyve021+3evCbKXVQJc+zCWMRkjgdBINZPHCeC5+6xZJ3Bp2hUJ0g+q5Esx5ZBwhsv8LUlhfyBL2PYV6a6JCfkyF0W3wR8+ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7NivdIpd3tMWoY0pSI5XraZ2oLoG62ldKLJDnJbf/o=;
 b=YfZBGTvCnxeu7gyvxHoC5fXtbkRa9GN/AzYsdBsqa4xldjUVemTNu/l/ZX6zRcm6OPENw+ksAJnKiD/da0c7tMUITm73ahQgNReudWjjXocoZ+xzQcDqFNWtyH4Mkngz3jdVfVzKRRe/UBPsS2dnQTN94prDZWW+OeWLSQO1p8ZlkP+WMvap0uN5ECERGMrQ9a+kj0WOgBwc7JQEe93CsQ10tf3Vm5Paunq39iXaf1s6lbUZfSPDyh4kOEf/IUIcX73gT8k/3VHf87fGL1aF5yFWB0s8564vnmTPgNgeikw6IPPKYYToOYd4hWfolgq6YWLC3lHH+c22AQXOl0i+xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7NivdIpd3tMWoY0pSI5XraZ2oLoG62ldKLJDnJbf/o=;
 b=MIdMy3UetFruhgDVG0e3XMtZb8mEM/FxYWp3OeY3Hl6Y6FDbMfH4miE+2GmNkqGDpHFkqSTOBhZGh/cUO9UvJflYYnyt0qXWeK50Hp33MGn4ia3PU9z+I1Wg8ARw9jondSrDp+YIvBrKXqBzcGFeuYV5NhYnLR/L0Dm+5c2rnbnxpjrw/7BAc8sRDcF8PJRliwjctyK6TgM1Dk0ma9/+RnXwmw0U78s5lJ0IUove24uj1CtwHA923Q6IgkT8HTkT8bq2PZVPn6kSXOJwhiEr93dhEHU4hcuvrdh/O5Ax5ZQbmlDDgnf0t9xc9sHRFBggnazx7fxa7aIhbXJ6k2MPIw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 by DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 12:21:59 +0000
Received: from LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96]) by LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96%4]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 12:21:59 +0000
Date: Wed, 25 Nov 2026 14:21:50 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: vjardin@free.fr
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 0/2] ipv6: fix IPv6 scope check of the source address
 in a VRF
Message-ID: <20261125122150.GA170378@shredder>
References: <20261123-for-upstream-ipv6-vrf-saddr-scope-v1-v1-0-f667ab150ade@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123-for-upstream-ipv6-vrf-saddr-scope-v1-v1-0-f667ab150ade@free.fr>
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To LV8PR12MB9407.namprd12.prod.outlook.com
 (2603:10b6:408:1f9::13)
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
X-MS-TrafficTypeDiagnostic: LV8PR12MB9407:EE_|DS7PR12MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b81005-b255-4f27-4149-08df4aeeb3ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|261026121527099003|10067099003|261102123227099003|261021121427099003|6133799003|18002099003|22082099003|56012099006|11063799006|41080700001;
X-Microsoft-Antispam-Message-Info:
	fJqk93qCXuKhzVzNCywfjaFS5deyjc29jePR6Ji2wMwixPzt+9cyRcq01i+bimuW5p8b96cioK9kvxcAzfw91/JTl3nr6WIMPUz6IQk57wH3ouCdctpIOhtO1zCLx/iO2wNHcKKtVuYP6k4EE0/lObqsOabSUGakcnUP8gY38fOC/Gt+fPmqHvwBIk1Fvv3V0ke3lBkN1DoZtOrisHldPw4YK9LiJPfgFouj/CTgVXBtSbldIstuk4yMUnhlYa2Ht/rhLx6fyR8OddMFCaG8UnhSKmEWh4TiOPEvJ2efu0QMMCFdYLdNwxUsvhvptkMMYNtUmR3fKyu2Rha+8rlFxnKO8aWAsgDXRXW2YMXux8ZeCZqlpH/HopeqXKo0Km+LF3yxuTr6b4rEpM/a5KIbhZKC6q1mnwCrg315ZtzGonMzaiczH7eMcgvP5C5Kow1V+ZkzkIx8fbePpLyQFicc2S2D7klfBL13I2b1UNGQ9ng6jbttkUeZeP66Qdv6Y46pMgLaUwIjS8xU4RIwvqS77zuQ3tscgY2eEjAZKnDFpkM6ecRJOmRHGm8G+6yC55myG2A8AMO1yyWzxfazDTXT0gIEemD2rXVS+Lv3ZAK51bTSD326S4L10aBpBD+W/toeuhNQB+FSHAAeyVKg+mTwJHmHa7W4UdxMAJ13uo9GEO6LjmA61EkW1kLQecw1uek0Iz+G5ZndILF9f/4kioJKsi4+8xebRmvea14WQcDjcmM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(261026121527099003)(10067099003)(261102123227099003)(261021121427099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S8B+9M5eoho6uv5Q9jgH8tVXAdheL4tOblykQ0KzfUXpAD3QkLQg+h3pGww+?=
 =?us-ascii?Q?2DtpBZ1f69JnTh6t/i3sTB8Dms/T8tC3nm2ijhgrCq9z49UTSY6lJqel70MQ?=
 =?us-ascii?Q?FveTTKZI5ujty21q+AFd6D2BGN4ALrYWNCDdXzV5dreJnSp3AyeVfAQS476h?=
 =?us-ascii?Q?JU7fLwt+w4onJi9g9V9iZzEzKYnO0QIHJz5BW6fDGxhIeLrSpGghE4Wq2nWP?=
 =?us-ascii?Q?fReeU/S5HRdywpXa8DaHz4Lc+2fLtor5bjbFPgwARLLZXSe0YXK3C+FtA0jP?=
 =?us-ascii?Q?cc5eFkvUfNTpXATv/vzwrRkLgRlPIXKF6g7f5aU0lw3hLSv0Dd1SROVaaQJ6?=
 =?us-ascii?Q?6Jhh7063r2EydNlPAyDAvQYOXnS2vtInEh6l8FzylHXw2ZONMCwI+pqAflWC?=
 =?us-ascii?Q?FBVAs8sBtVxUOvfavTSvLH01Y3SdH/IK3xpKhxtmjJzSWtrHtUIvFTRXeoHl?=
 =?us-ascii?Q?kM7ifmBk0auoZWQ3lPgZGQ7F2SFcYIL6etIkKGDdrTHU4Z3rC/b88894nrva?=
 =?us-ascii?Q?XnLaNbE9jA4kv7zslRZWjkGV8htoihEdCaEqXLrSBlWohKNiK3rm6edlqAKm?=
 =?us-ascii?Q?dkmTUm9KJGc0/24CTZ9Yc3QN9Vx0xpKXX2iWax3phEQpzE3PWgcsa7cBp4PF?=
 =?us-ascii?Q?X7WO/b2jejcgsd2nhSL2GmFMqR7OPgOf5vGPF3aRMPIPSPQQKzFGAsbAqqIT?=
 =?us-ascii?Q?wyt/g/nUSaMpQZ4R01i1qYJq3ko7SZgHK97PmRIzoUdWXfc807KsLJOu8yvx?=
 =?us-ascii?Q?9/RIA4XnAvKbJWcFqa98DbziIp4gpffKtSdAmGhjOuyccAn43BPRlSGGcEgY?=
 =?us-ascii?Q?zjfSftErDuyrLCCjOqXcmgaFD9YRR4ylcSiMVrUyjVwfaGg/6VjzmZlXzQSH?=
 =?us-ascii?Q?fW9kIiDHGsE1NRvypXVmJFmh+8CJ79eZQJQKjq/EPzmIFxx3rQQn+l6I3ebd?=
 =?us-ascii?Q?twvrmqmeKXQ2Msb4yBIKmuCQnH1hJ6Rm3vyrxwZSmpYkrjq/8MHGdJ0Zu0sm?=
 =?us-ascii?Q?AMh9mnQwtc3jZ7P9bNn1cGioeljxYmI42RGEr5RgTO57irR1G1JsD6Iywfzf?=
 =?us-ascii?Q?Gn5Mh6R0SB/JqS7Zye2kT976LvjrU8mXDnPorQewDsrcnp3iDfS9ZRnhi1yR?=
 =?us-ascii?Q?TGQrcVpvX0KKSv1AV/eFD8den6LygcIDAHwQmK9RoQl+a5IZxOhTdNFBLcHd?=
 =?us-ascii?Q?zE//wuJw3nffW6C7yD8C0+9uTIl4NADUxRrDtl6/RNEkgPZ7fv2m60yHGX1Q?=
 =?us-ascii?Q?uK0TZAauiObkSWwoN37Q4UyUUSBy5k5rwRTE9EPFEnP7a+VLz4tCcPpbJxeD?=
 =?us-ascii?Q?GDDZkHNwKym6oQrPXpn6vX8oGhP5T7C8afrjxMqsiNOSixkXqSQjM1f3+Fux?=
 =?us-ascii?Q?2yjwW3/0IHJc3d+V+ljGsraeeuC1TEjUbkmCDZ+GQF7Q253IQ4kU8hfFxqA0?=
 =?us-ascii?Q?7ZkXR64/rRSFcUuIY2ZxvjkZZXY3dRfbAFYvg1aPKe7EDjKUuibtRpdQTcco?=
 =?us-ascii?Q?KdazcjKDuwYd7KF9LVoYa8VQxOVDjGqswEI/ksWQOlkajtLLrcctHpTk2kTR?=
 =?us-ascii?Q?1vfXEfBmraLPZxfu1vJ0jk18z7G882dtx/44QRa6gvSYpdx9LG81PEUgHx2e?=
 =?us-ascii?Q?C64rvmT4yyYiKgI7gg0M8g/mg1jV9t3SduShtx8hDEFNxzF3PVn0CQSTDfDE?=
 =?us-ascii?Q?iNHXwmPMWmJSV0eM7kG3odaQDANnRCDDWgjWM3Zrjodh2BLj70Nrg7mf3CKc?=
 =?us-ascii?Q?yf2ve61SQQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b81005-b255-4f27-4149-08df4aeeb3ad
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 12:21:59.0354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /S3bhWIghEYPXiQcclruzA0cpzxlkb4XkxrAHPqtN8GYtxuxaXMG45Bz3heWBAAgWAhzfQLh5zOXhAEYvh6slQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007

On Mon, Nov 23, 2026 at 03:30:42PM +0100, Vincent Jardin via B4 Relay wrote:
> When a packet is sent through a device of a VRF, ipv6_dev_get_saddr()
> first checks the addresses of that device and of the VRF device,
> and stops when the best of them has a scope that fits the destination.
> 
> Since the commit abb9a68d2c64 ("ipv6: take care of scope when
> choosing the src addr"), the check reads the scopedist of the best
> candidate, which is an issue:
> 
> - with a single candidate, scopedist is not written: when the stack is
>   zero-initialized, a device that only has a link-local address sends
>   to global destinations with it, although another device of the VRF
>   has a global address
> 
> - with more candidates, scopedist is negative, whether the scope fits
>   or not: all the devices of the VRF are looked at, and one of their
>   addresses can win over the address of the VRF device
> 
> Changes:
> - patch 1 compares the scope of the best candidate with the scope
>   of the destination
> 
> - patch 2 adds test cases to fib_tests.sh

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
