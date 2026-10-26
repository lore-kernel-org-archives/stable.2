Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793057115;
	b=hYm/w2sjmn0nd0wibe6F48rLrY8GHmJev9tzM+odHqfZkojmuQeCeV04xV5fPBVEIz45
	 MnQnR3fNwY7brUQnNM8/HatLMgj9FhBElprbpwl1d2YxItlL091Oq4zooX1R+Y7jmVzaa
	 Djl8KLpOVZF5X2qs1msPOkmx+cvbGrJSU1VnnTY6mt7AgxGvsYTi0+YBxjDN2pQWmFpgr
	 J+TbsWyiRwioFupJE39+aEt2AEcsOZ9ULoAgM1IwrQ8zEm/2QAKsWj1f+f82NsHhhZjP8
	 1bXrYC5cQL5jhIN+n3DRGssmRJ+0VwRW9YnLVVN4RrurWI21UrhenmrUDsqMpQ6tPbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057115;
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
	bh=JKu42Gq0F2cuholGR+kFuVVKpQuKZgF9Hyn7L+99cAM=;
	b=W04ypp+zR5Gru2raQkUEFfOi4BLdbyPN5FwGu3wL5IK0q/Rbcla2afHqqDvJuOFZOTx4
	 AKfhzq1uqQ+24Z6N1CszvoaAFMQivWau8cghX6FrCT4QQ2MnklB67XPQrFSPsxw5+WKy8
	 ZTdJv/sNugSR2BH9skRYGzK98cteE7UQOaWC6SxxQimGO2K/i+SNYGxV5a823A/o9j3D3
	 MuaXA3Bk2Vhg8QGhQC553+DpJmMu1VWQ8BxgPCbtc8/yjWIYAyvkEuSrscM3pUTfwx5/J
	 UYzcD0BZNX0yA5pgs4GOngI8stwp9dbpmVxWW08blKNMOL/7Hh+XgVKqL3sZZEFGYUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MLpaAZxf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.61
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013061.outbound.protection.outlook.com [40.93.196.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C4D606A31F;
	Mon, 26 Oct 2026 23:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10C4D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MLpaAZxf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqzVnMUd/u7GlZQoZxdGRBhMAjzBTBUEFu+kha4ZvrBgPjwrOQ9rRHi5b/hkGINl1SoOH9Oukguji4UYuMbFJEnM9YYOOSaKaFEVvJopanmR4h3ELw4zKaqXix9JZv1YOcfx5yb6ULLoheLgZeC7/kJdmTGhkmjP9TRdAEWBaIWLKqc28p3DvieKYAZW7qlJI6hwUlRcpUye8odWEfR0R0iDPhJx98Su8JhNT7cR+CnnOwWnRTpIiaQNuZl+G6VuMBD+5/h9i6eOMqT7g3a/wbMDVtBPsasS13wnysch+ftP9b9e+i3Kv/fdI0JMs3tqXnxna12CPOaP6heG3BKBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKu42Gq0F2cuholGR+kFuVVKpQuKZgF9Hyn7L+99cAM=;
 b=HvPZwOe/oycgb6eUgTcJrf9LY/3XcWrtuq5Yyo9nFx2veMH6q6jMe01+JW3LNpYkzZRrkipTkAFA+xRM3QfoLX6vsja4QXIYZzo9njhzJ8yoc/luj6/cSf1pBzQ+smJNr2PoENtMeKnb/ekNfclfsdZqLEtcmUYG3j4vUyWT53DCBOb06n3iWpFADOv6RZCRrfxLyYw6LUt53Mf646Sb3uA+SQbDaxEIj52ong8Y53mbwd6+KB9bfu5UCa5o0jbVtRIvXGhp1+2slKkIckBnyL6SpBeBbOdAP8zRhyXBufn4VJEvWUBQ1refokr57u/UL0nKNZHf2plADMnOz0XwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKu42Gq0F2cuholGR+kFuVVKpQuKZgF9Hyn7L+99cAM=;
 b=MLpaAZxfYenjTsSOYX8lFE8buSHchcre00ijcESbruY0s7QEh2WZQtK9URyASg63gT3QzhDG+AsCSiJiLjCBJ4abiSSlHSMLxgKVUuWLxAlVjGC7fw1Ha1ZgrPaRs4iaS2gCjNt2A+o+93Pk6CH+57FoOCyBtSX5v/XDijwYB1z0ZJ+G7lMPHq+J8enHDWXvifIjdNkMpCN8MTnP5UyUx7usiXAFmpEn2lVTTMDrFs8Eq1R/wgQbDIXgtHn4OnDNH8F+Vc556+TExO37H4aCUrgmyUC5VLJeFVvt3PQRC+9p9QntCmgVsrhWM7vbnQ1bykHG0QPEmbC5Yr6s/9r5dw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 23:25:12 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 23:25:12 +0000
Date: Mon, 26 Oct 2026 19:25:05 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rcu@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: Tinyconfig build failures in v6.6.y and v6.12.y due to "srcu:
 Use irq_work to start GP in tiny SRCU"
Message-ID: <20261026232505.GA1044084@joelbox>
References: <49da816c-8082-46f1-bb12-f0d6187bb06a@roeck-us.net>
 <2026-10-26-1-daily-reply-0001-srcu-tiny-irq-work-revert@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026-10-26-1-daily-reply-0001-srcu-tiny-irq-work-revert@kernel.org>
X-ClientProxiedBy: CP6P284CA0053.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:1ab::19) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b717cf-e827-439a-19b0-08df33b861f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|261026140227099003|11063799006|4143699003|56012099006|261022105027099003|10067099003|18002099003|22082099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	pBbzROVWPSf3JyzSPoNNEGqSuIcthg49x1XxSIDAc2WDzfwPWunJXX2YJIHT6pN5YZp7s41+ww3QwwhlYp2W+0Vq3Ml+XU67bcppDqsQbizKeaPPXcb7RYpnUO+dHM777kxg4vc3sUiyPvrau+lf7LUN7ClHIyRKmqpjwHgckmZMtNqakZRZozsFTjBgu2dagtiEeOJoVR6jtF2G0/sYrSgcmnvd3i0/gUPvOhPP2xYZ2cDE+ttuitKQbWl0ASMMl0/Ms8lJd1IwsvBNwlfyeHnhcAWfk3lljpICmUFEN1VGaeVlpD0ewEl5bxX73Mj5tXL7xX+fRaQLfPN5O4U9Udh6Mzh54ISe8IFkkAKM2jTkUOuEPQIsan2OB/lwoK9RRRJCMdcYAzKRZ7zEXTw1SgG+M7ulv6Rbg61kNUKWaeIUeU6ewigg0/sKzp88JbyE/LO0bRvupu1dpXsvG8NP0r9mfGBDwJV3bVEWB+2fUGuVOB3lqxX5bJwfSkU1Wn9Eguh6xGN6mopaOL0GhPoZyLT+h/bVnsVSP2b/K1mZiqjNiy3vc1zLZAZITqIjnts2n9o0HwGmtpWjnhSjADKzoAxXq41NMoYDWZf4T1K2pncNURJ+BZinyC+S8DZ5Lrrd1J+aRPGWkK/Av07z2jMun1zBp92jBQRBveHv+Psl2b0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261026140227099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(10067099003)(18002099003)(22082099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nw+vMoXk4UTtJgnidz6xZ6s+/HHiDDn2j93ijJZrq+0muVsm1RW8X60RKe49?=
 =?us-ascii?Q?obffQ04+amLiAxLRAtAMfkGqK1S35+QgZRZw3mSZGMunor+aGGn0dgVY5Apw?=
 =?us-ascii?Q?xEZ6q2aWEIqOfnmWKCxMQcWHkuhFLx18xui4tR5GLWC++Q/JLwYEISv0WQN0?=
 =?us-ascii?Q?1l7jkR2bWM/p9sTXh+Mnm6XbBN6HyXCy6Li46xRksVqaUvzH9HTeZMUTVZCY?=
 =?us-ascii?Q?e53Vz5K0l8lnT6JlR1UzJozlMsCJQCMorWSO3lfg7kd1vnbSGdLAjVWf3bH4?=
 =?us-ascii?Q?Owo2mALVFTy/jv5PF71uhKbbIQTG1aptmKo+s8dEbBvchBWB7DpNRADOJ+0I?=
 =?us-ascii?Q?cq6vwnvpK6b9mYecxZZLqvPACUQpitR494h5QYnlytsThcXBml5qxHpURk8t?=
 =?us-ascii?Q?ZqE+xCYa7J/J1UNDCQOy/Sunfj/w0jGS/vDHf9P5GJ9eEvYrZL9LcVAOLAZe?=
 =?us-ascii?Q?ZIvcloJBjJiU2m0BNg5qIjtvPuhiSAO+Gm2d1BczW5DOKsQJ9RbCmzS0C+yZ?=
 =?us-ascii?Q?q/AdBcXHUYMxrOXT6byVT/dcAXyP63Zxf63bYcs9i4xjKM0Up4wEK93PZ0GJ?=
 =?us-ascii?Q?Ojiv3FfkTTZigicHh/r8hhr3IXtnJzVmRMkJGBmHmmzZssQ13WXZj2lHm1mN?=
 =?us-ascii?Q?6saZ1DroQ7CqurOXLe1GSZXaj+eGzhQ+oi4zOM2nH8b9o2UTzYFV6SVDY7DM?=
 =?us-ascii?Q?DTmPF/iSTwnAuWIw32v5d54YgNOyUZv3OM5peLHLRZ7oXYdr1txcbc6SjlJl?=
 =?us-ascii?Q?s71TToGNhdtHwQcoookHL0dG80F0X+CHRsqVN+9q3DNLoI19MSXkGSqHgWxE?=
 =?us-ascii?Q?XjK8ucvAsGV0TqwBIw8RbyQuL3UzX/xDOgRBch2HPcGP6Admviqop/+qkkP/?=
 =?us-ascii?Q?bOZ8jbIx6hSRaavVDXv47IKJHpdk36ybU1xnLa2zY+dlS+FBYIV/bMFtHuSQ?=
 =?us-ascii?Q?tfO/pvRl7dWPUNEH/aZCujxsKWu00MhSOlfpvCFIGoVzw4IF9n0L/5YNLJEt?=
 =?us-ascii?Q?5zySMymwCTqX2NwmJnoHa7GyuTx7m7/QrCqODi+2GGDuqgEuIaLEr8Y8/mIL?=
 =?us-ascii?Q?CaReBcCFvEeieFdhsRDLrzSgIZL+0NR/vJ0B6z551Eo8gPP62rO8tnbWJ1/b?=
 =?us-ascii?Q?4M28zp7b5tI5RoVjw6o9xAQ1xxgwlJwfHjOgPaGOvVrbiliJRKKObzqBRqOs?=
 =?us-ascii?Q?aczsxiqjnKtLAppMC7CsAwGqpstzO12lJX5YelQ/Pfv0JSt+QPipL0WRHmTz?=
 =?us-ascii?Q?FDOzYv7MBK/FbJ1Msf5BvmeObn5jpe7qOI7Zbb9K5R43bNpIzvv3Mye8wsNg?=
 =?us-ascii?Q?FjTx1w2OUktDLnCI4DkLXThAEs+MKj7I6kjV0lv2kR8KINVh1JrI68uYplSy?=
 =?us-ascii?Q?0AIWePZx6togwSFN2d+bDTsvV3nSEDF01TZCkOY+1aSeRxtNW2qABEiiZUfC?=
 =?us-ascii?Q?hJ6675G0bjPjGEzXDi3ODtOyekcwFKE7B70RuPFIkiCPhlQ+1HkcEEmE6R/7?=
 =?us-ascii?Q?VWJtj4THKkehQQWpqVfvDTOyrQg/8eiX9+V2KK9kzP4Vc6rLrz3oAd6GbxEG?=
 =?us-ascii?Q?BQrGkqESva7YdI/tG4wfi2gc5tHJfizHLqD692D8X54cHwra3to+DiAON7FZ?=
 =?us-ascii?Q?+3eAf8Axy1UcXwaCu4Ji4Jze/skZl9FkzkfmIwl3I1tIwWtleMIacBZH4nGA?=
 =?us-ascii?Q?hWEeo9EZOEuwQgoM/5PAYkwnMvFDpMYBQCyRlG0PhPPlm95FoNGqDOrJaAw5?=
 =?us-ascii?Q?dqLKkgfoQQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b717cf-e827-439a-19b0-08df33b861f3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 23:25:12.1290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlP4I3IeiIy3YLPhLqBOOvFYXFLLWtpHzoGLzee+8oQf8NtWZg4yzVPCYy0HilTo5z+BkSQLo9L6NIJsGASZiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907

On Mon, Oct 26, 2026 at 06:55:52PM -0400, Sasha Levin wrote:
> > Bisect points to commit 58dd6e92725f ("srcu: Use irq_work to start GP in tiny SRCU")
> > in v6.12.y. Reverting this commit fixes the problem.
> 
> Queued the revert for 6.12 and 6.6, thanks.
> 
> > Adding "select IRQ_WORK" to "config TINY_SRCU" also fixes the build
> > problem, but I don't know if that is an acceptable / desirable solution.
> > If so, it should probably be added to the mainline kernel since the code
> > only builds there accidentally.
> 
> That one is for Joel and the RCU maintainers to take up in mainline.

Thank you for the suggestion, I will add it for 7.5.

thanks,

Joel Fernandes

