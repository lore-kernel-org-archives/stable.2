Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792501175;
	b=Hdq2czWUfezCkMByNJ8N8VeTm5CHxhz3MxgmVSHn/FSdsgjwDK/dSAN1QaMT1WviqiXn
	 9rT1jOB6GoT9mpeXbvhOXVSOVQEs8B69PKUHatgA+hABQgtQyDmg50Iqlk7nwNqR69EdC
	 En2FVHGUOlmgiV21thrAKAYFxGGoIUnpGcW60qhBZi1263MRz9vxj2w5nZyHcqvxvFjow
	 MqQPFkqz4jalQ84qeY/67Rr/S/ZmAjzBtRLiTN8i64yXCxXXMEvuN6vaYCrQoNFeAh4Xf
	 QD8zKcoB2e+RJbhBRQa6O2BNBJyUgX2Pjdd5MZtN47AqsNsHl/7PTrYgH674XC1Wfng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501175;
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
	bh=5whQ6zJ4BgYah9BQG9sNtA8yn0/jzJ37ZyVpy/8feOY=;
	b=dvVS1NvCdp3a/pThLi3S8V9wsQz/FpGBuOWSSN9nxV9rb0oMKZi/kV6JAX1vpthUFg0I
	 dR4aOq/lQPkC70fJem2i74tblywHfHZ9SnQG+mfE0d+UgIzvbrfTzqUWMZwK5xWz+HZqA
	 Sa3apP20BG4eYhtBtkB+Ig0bFV7l42qpssoUhZwVqKG1GVcUvmmZcjAtTfikhedn07TH5
	 fbmu4igUjPgQqZa6ZY3aztSaRIvQUeRagiKz2QWvzQFFEnonEDdOxw0xzPl3kap5PdaBl
	 CfQzzgWXaGYK56s+WqkgSheiL2pMB/IpLro2jAOxMuOQcsNb6NT7u/pDejshtXIbkaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="p+/CDdMY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.64
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA233606A31D;
	Tue, 20 Oct 2026 12:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA233606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=p+/CDdMY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQ3kylQYO5UKCFKJ936MgRqFpnnUGDkj/gItEAdVRoXRCJK/UZ7eVzB+ZVmujz/IMLG7FGLzNUbo+TRoxpQK2IMuC63lAKedAG8izxuAZGxlo8bzAbDbC4Eq67cFiBJN2J0B5kbxWND7VnroslF6JWY+23uIdC5hzRiRtWEo+bn191R0Vti6+1+04a/6I7HeuGdklyrQn19yJTr63vuEXMhi9ELhvP0bYrhouuceAOV8q1xmEKG2DCQT1cuYOe6E3Y1mbouHqXrnRyyXuj6ZxjNw7/nEJaYd0wXuFnvEQPcwu3ry0v7Lvtx2/sP9hcpW+GRxLf5ND6YgYi0RZiwRxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5whQ6zJ4BgYah9BQG9sNtA8yn0/jzJ37ZyVpy/8feOY=;
 b=y6kpU7lk8/8FXG0EUztTwErsCIL3PMCPBoh0L/uRP0byBaUHoMy8QvzQ8qKYEKYgyk8dPCUS1mVcJvMeFxKrwzpzH0CAm17nSuanwau7mxVAi2NM2EeRn31sQ6xnhfWWp72fn7lIVo1jgDPdlo9MioOnZ0hr5cWqQnRoYhaItz/Z5ZmtZvq3jD9nsLnXhwa9O9ersJqoTi0TwIf0Av97hk7/wpvk9IfIlWmkDnClqklHOLQ9MCK1r5ZE12g2Chg7OI4BmySekfbR0pdgpdEBlzRCikXZxdaLH8vPkzjIxFEanac3w4/mHWX945OjzBMrN85a7NTqCUF/jm/6iYxnMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5whQ6zJ4BgYah9BQG9sNtA8yn0/jzJ37ZyVpy/8feOY=;
 b=p+/CDdMYbIsJqg+S/K7TKfAXHrnN3+C8YvgBm4Q5k1+ehN93CM2kQoWB3DzMiDNgFOtxAhwPbNDcRMpHiB0np0BXmXdtLfDqLxNBTd8+XdwzIxBzXlR64n9jDLBM30Fvya43U7hQOakMRp38MPyNAwYgwsWCtxI++YumG6/sQ/0p7RoyG6VYaMAkQsSippWFiXlPgu7JkR11P6TLp56UUgBm/QBp15OTkn2bgsNGrnv35bXp2/NKwGHui9yiHnAk97PUxcA4CfRv5ETe1bjdXqGk+MdvCI/G6f4l/ME63tMrhCwv7ZNk4JIyus9tHPmWIfqPlVNxk0ajx3ZR+zjtaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 12:59:25 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 12:59:25 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] gpiolib: cdev: don't set GPIOD_FLAG_IS_OUT
Date: Tue, 20 Oct 2026 15:59:22 +0300
Message-ID: <20261020125921.2896041-5-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAMRc=MeDpODJCEst-T1wgOu=MA5v5zVL1WXJUjOYW=sLdc2usA@mail.gmail.com>
References: <20261016-gpiolib-cdev-direction-v2-1-aambrozewicz@nvidia.com> <20261016115009.GA111978@rigel> <CAMRc=MeDpODJCEst-T1wgOu=MA5v5zVL1WXJUjOYW=sLdc2usA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 15a0c818-70c7-4519-f546-08df2ea9f7f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	smEoiVsuuJGgYHHNxKKAkOc+OnmHr/FTqO1U4fe31C3LsvO4Uchz/VI6w3U9iTMMi15KpQ4UUeuj5qexLESedySybwXCCSazj725AN8Dbz6KY6XpAhjeOOFpjNze10McsfQhEtNRgtWGZbpYqfWatQHbt3GmsQ8keDeRfLuJxXef3NTv3RgJLxSAaew2Yxc0nQUz94GspaIh/2IY4S60Tyq53AtWQgZFFUUZm3kxgsO5B0/P0LMylFRuScebiAPL15I3UsaOCR0Ko28sB0AOEO+Nm8kt/3z08tzREFvcaZTq0x3qvB7NJTzMFUuC0Q6YFJbUalzUFsdRzf8mvTJFt/XjIdpWrjWLCEJALMJZ89HPPRakxctcoE6vXA548+jEITJ8DcZvv32CXUkzPxyatJ6+FFPwk3deEnAbJTylHZXLDoAM1b+X2Aaxe08JIVzhQiSsxIDAACrzzl4JoTHa6F2ZkShynu/2IkKc1Pwe9zw89pTcC3GpJ1EUbGX52kkhxbrT3S7Xgrb5EwOo4o+1sHACG/TJABW49nq6E10jsg9nR8IuUemSJupR2CdxOivBO+xSfwDVbDQo5mTAgLMCbyYTz7Q1iDO3HCRrBuDOCU9YOIzKTUfMd/desD/IBN9RJ6h9CLRNPQsWNwUnkKYlQE8KCkxZ5IqWqRDsPhkvo3E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tl8YAoG3FEcigWpi24oC50QhCN3mcjewjt2T49dS8v/Dpm0zq6NMQZNNf0mx?=
 =?us-ascii?Q?SRCcqi19A3vZcADN721Q7L7Tv8SeqzRJm7hyx3oxba0ogmOJv/oFHwnfWG1e?=
 =?us-ascii?Q?P1WLAiBQw2qoOCxz/nDZXcJU9V76HpYjBQVOgMopE96MBLTlK6siHJuZcDIT?=
 =?us-ascii?Q?mIM2PVDreVDIrjoNhw0Ci22rYBTkpKS8n+2/4Am3N9sARBi1myEG1R+R/5V1?=
 =?us-ascii?Q?nuFlovgmA51QyrQIY6Nfl8MaoNSvBxHWQ7Ky+U+vfovVV6dGQ+0eVXs6wnqS?=
 =?us-ascii?Q?k3uNK9Bmt2YR9NPWisKG2/WAnxZJfkSMkkQJMuwEv8azlV8ZAqCJLF+/zW+8?=
 =?us-ascii?Q?GfvOVweUsKQZiEVxbDA3BpgW2DZo21bgqqXFDF+f8FymrlZ5C9JEV6M+NsOp?=
 =?us-ascii?Q?XMd2eP6f9gZCQiHmULJ5wIZubNs7GCeVW0lDVONAfWEx4Bfwbc4VGkPr9M2G?=
 =?us-ascii?Q?3HDSxvUOy2z1l403/4f8nh1g/Io3X3FthrW2aDRoqp4BwRgTJorXdOognHCH?=
 =?us-ascii?Q?Ap6RxVjpypU7m68+l0K+9B7a12JovpCgjKNVayjto9Gn3C+WleMXOs6IzIwX?=
 =?us-ascii?Q?Y7lcY9pNsBS0tOkcxvp/PTkn6udZA0XWuaS8LyAUaT13AtrBtJum/JgH9EOL?=
 =?us-ascii?Q?MdynPdoH5F7yr76esMf+84Fe7j/CtOTwhWioc+ikz0t8IOQYCYvblpOkjEsJ?=
 =?us-ascii?Q?hdFWLndHSmCtvug8FDMgqgOb5gSTP5HYn8rCB2b7lpZ12w7tDSDdXye9gFzX?=
 =?us-ascii?Q?ZVpVKiVKMYWYFa0SiaSs+PRPB1dc81LV7b2GEGimshddRa2+vmqtAR0RyKkr?=
 =?us-ascii?Q?c6iliV1y/JtSmGkBukPjyNkb7bZna7FIvxJGUxwl7Oo73uVqXUzBBPv6Jz7v?=
 =?us-ascii?Q?e3MdYnCJVKjYKx2wh8iBbUQaqVrHU6gnnHXbCkhkFpiTUpoSVWDnjwiN5Oo+?=
 =?us-ascii?Q?g0nJxe6cflDqGwqX3krzGUW5BgODT7qvvijFPoRQhKkGMAKqww/VPYz7rARI?=
 =?us-ascii?Q?YfOutGAVIKCS1M8XbPlovY1dPTPMHVQwyEXqDSucI1b7pa0gXjJVPt3GJqDX?=
 =?us-ascii?Q?HNkbD2BDgQIL/aLkkD7ayDcXucV/pYtcTF7WNNFPnh3bzNSX9FzcgK8+oUzs?=
 =?us-ascii?Q?y8NrmEyCiZcxZDdQ3Ku8RxMnsIjp1LSuqQFi981Y7vRIhaPBo3nBMNfyqQGP?=
 =?us-ascii?Q?Xu8EgupEAVW8lgGBzA7NIP7YxX21GJdjc1TvJiVtuXCnwn4SZzUmmSCVM1Oj?=
 =?us-ascii?Q?HmEq2rzpI1Eb0MJgRPe3OhJG7etg15m0J8G6AqdVgQGZq25K1Ybw4QZMcSN1?=
 =?us-ascii?Q?hrqVdi1K3engfos4b3TRFsoRUp4mWZjV59wvccP9Q4V1wJQ9jM1F7bcbOpYz?=
 =?us-ascii?Q?40vDlKX1maY1C7D4+rFOVxZZeNn5ipFbdl3Zcfko+hIxIwXs99rNTcOqA22W?=
 =?us-ascii?Q?pzOfzQ1mZtIzyNWX1N8NDNACZmZxpBDhTro5v9OV14CdmePuanIx0TWg6VNr?=
 =?us-ascii?Q?G+Gvllfsu+nTWs+Tczz4YBx8+FHk5ZaSLamfy9cmixVVG+x87Bc+l9opnbPB?=
 =?us-ascii?Q?LAOh6abzu0kubW1FNU6ye4e6Y39TyONN3ujrB7GkWT3/mQXNi/8KwXThVN11?=
 =?us-ascii?Q?GQbOxDDZkvB01wSoy80HbroMQxDw0WDy9N+FNHxo6sTBtxt/t/OibgqixPuv?=
 =?us-ascii?Q?oxpjeUGEw94Juvmv1ovtWuSCyLym6KVOUrQLjqbIWEsZk4fhduBX7ex5uwXL?=
 =?us-ascii?Q?b/ef+auhoA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a0c818-70c7-4519-f546-08df2ea9f7f9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:59:25.5685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0lUNBx+3EK0y42i7lNqcrBQU53zqyvxQlYcdLKtxcwtSnQJGaMKFrlBdS4f3tlMglXPYx44eex0RvGN6ZTOOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414

On Mon, Oct 19, 2026 at 04:03:51AM -0400, Bartosz Golaszewski wrote:
> Yeah, I would have loved it to be a bit shorter too. Is this an LLM that
> generated it? Anyway, I'll queue this for now but please try to make it more
> brief and to the point next time.

Yes, an LLM helped with the analysis and the drafting, hence the
Assisted-by tag, and I didn't cut the result down enough. Kent made the
same point. I'll keep the messages short from now on, starting with v3
of the chip removal series.

Thanks for picking up this one and the event clock fix.

Adrian
