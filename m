Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022073.outbound.protection.outlook.com [40.107.149.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881535AC01;
	Wed, 30 Sep 2026 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781694; cv=fail; b=eERgiQmpGQ6ZgRDABsJfp9YJyYacGlhFwdXbI0+fxle8InGikDLZXQnNveA9VUWWTWobwGLHEW3+R2chMbflDbbY6nQlyOm0xfcHFxSDRZeCVmJUdW6l6idw/GkKwrhycOTPxyi2luDhI6dt7R/HAiShNt6ntu2ZRPU7mN9G7ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781694; c=relaxed/simple;
	bh=qDE0qzmTQAKN9okg0JVXv/7ljl2EFhprvtRjcmNwCQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cBroLSZqKwqsLvXvFX02mqGU1STUW+bnnQFl1UNMjcj38ykYCzZAY0EhshIvHIrKpwatwGc3LjNg6RvE43b7EjCwD8q+yGZ572Sxt11YijO+Z+JGaY9VGbHn0RTTZxCddRcbOob8tR4GAu1Cbbk+NcfM8/ioUBhMO5vO9NYlF+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de; spf=pass smtp.mailfrom=cyberus-technology.de; dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b=CtpzKyun; arc=fail smtp.client-ip=40.107.149.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberus-technology.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b="CtpzKyun"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYf7Q56wPVQx+lmJKDLEmXTTsFiNix54B5m3h1H10wggI7haXA4RkysQeM4wUMAk5ZYbDtB1PNCd6PCivljffEr6pYpPj5SXSP4vXSaes0L7JC+fZwjFcgi8wDTWuR3IvtgULGZcwGsQzPBy1qgCay/J/WWx3halEHaVJ1zWTNmGfTSPmHby2K3EQs5dJZl1jemp45iM+o5aK8Q8MJizZUSp2N/1erBieEkh0z/9lmqVwJmWeqJIO1zvRBHe6BniRHLcqmfzH4rAoHDQtO58t6+TlQqn38sd0pr7IlgyUY56PdBmV3lov56DIwDvuwDjqkbyNPI6bnXnvQfr2bNlqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDE0qzmTQAKN9okg0JVXv/7ljl2EFhprvtRjcmNwCQ8=;
 b=QoDkNC77GRcWVKmknGObkg3JpiR1YiTEHMdwCV+RwZMe/NW+xvUoFX4wgdT4HOR6BUvyPxjr27fMYhWb7tb/QHGxdUfxi65FY3e2vNpHCNF8yL0bby3qRQrCSdehJE/j7Pm5e0VqWoQTRX5h6ooNURqFZ/Vmf5b2+7e0JJqQ/Kx/CTDu4PIDF7D2PtlCzOlWX8CP0iwIXgaK60g5NIbbqGaO2m2c5rylOASPJZy/iQ1gmi+TNpdO3AxCejEz0N4MFfVG5L5z//8r7OBe/EYUxRXbEAdNJ6jAhhPHeflzhPmstTDR7kKaLP/y07o7ffVV9o0JMKZKvljx1aG2fVsXJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cyberus-technology.de; dmarc=pass action=none
 header.from=cyberus-technology.de; dkim=pass header.d=cyberus-technology.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberus-technology.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDE0qzmTQAKN9okg0JVXv/7ljl2EFhprvtRjcmNwCQ8=;
 b=CtpzKyunLcr2VX395ucfz/poLWQPUF7KmZiBXy0wYpwkOMneIAEYyMg94wMOi/LDaja6D07/b69b+QBxQ/DEayagOXTOymOch2ajEihXZZZTtjjVdZnfLv7BRrbb7XrGIniBmRc5dHfAx3S1oWGoqL4wUovxbA8pAmdITKTAZzb+yA4CQy5tAxOHACQIKj73qUnk2zD4VWfVY9q2MjaDYRg+lWBvKuKpEq0edFGQyV6WcRpK2fmSQaRqYYBEDknsgPLrOcnyTVqY1+e/IXFysRqU6XTn4ylsIKvA6gkZSQiaA93Ov+nnHPeQr/LlsWBlKaR9SG1PWyyAsR/Jpv+5ug==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cyberus-technology.de;
Received: from BE0P281MB0148.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:11::16)
 by BEXP281MB0135.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 15:21:11 +0000
Received: from BE0P281MB0148.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3363:e0c5:e17c:912d]) by BE0P281MB0148.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3363:e0c5:e17c:912d%3]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 15:21:11 +0000
From: Philipp Schuster <philipp.schuster@cyberus-technology.de>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Philipp Schuster <philipp.schuster@cyberus-technology.de>,
	Petr Oros <poros@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	David Laight <david.laight.linux@gmail.com>,
	John Ousterhout <ouster@cs.stanford.edu>,
	stable@vger.kernel.org,
	"Anthony L . Nguyen" <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net v3] ice: fix packet corruption due to extraneous page flip
Date: Wed, 30 Sep 2026 17:21:00 +0200
Message-ID: <20260930152101.1503079-1-philipp.schuster@cyberus-technology.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <ah2qcDLxMlGYNhgf@boxer>
References: <ah2qcDLxMlGYNhgf@boxer>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::20) To BE0P281MB0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:11::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE0P281MB0148:EE_|BEXP281MB0135:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e481c1-f70f-4e86-1018-08df1f06755a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|376014|366016|10070799003|5023799004|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zlWG4N0xtwM8QvLwSTUCtWKHJPPAoqN3nSEgfGuwHx91H3tIBg/IrZbc+XKStvZegaO3q+dfTy9ZnYUp+nLhxo9RmtT/3wci8T/5rsF2YTqnY8Aa0U9IDpqT1446gmvoQ29jETtlNg24R/LSyEzWy+CEUycJs9PcblediHdbyhUzjMF/A1RI57Dc/R1YKNqgidME/Ix36u71N0NPRekhWldv0Z3HIfxkG1N9UK0caAl0I6Bk3wgl4BOQvHSBnLjkbwdRPTyJwbNQSQbk8tZ6g2+Ie0OUWHlzF8yTCvzE3pANvsHXtx/WuBcL+atlbudyfQ7ixCjD2eAX5Fo3KLEVPYC72swDBcnjeKfc2ub9jo2PicR06/C6L21APXFmPyf6SO/Hh2EKFq5DpMmKSqMOQFxB+6TesnNzxsDAGsKs1d5+tkBE0Ku2jlPGQD4V2lPCrO7pAHYTnnNNkET4Uzm3ie2jkZ1pZbHSsGVdG9aSQgTi1YxNpxh3chMnjyzwQXh4jwDl9Hkc21esZaUzH8lgIbCMC/wmz/W6COD0IkmV8PxKsMjEWk1fFVXvAIOs1U4RAemjbkePB4iwq02S7TPyMPzC5FT728ZdGVpImbeKL5L29IlF4mAkQAGPQj4B5kBncDuL4xhWksOjjitNJQABvbw4Y/XvMQfz8ZkRiT2C/JU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE0P281MB0148.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(10070799003)(5023799004)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AWqvARL6uwumf58Ni7SuoTGA2pP/KOG85RL1JiF+LTkM6Uz2+8DpedwFIJ6y?=
 =?us-ascii?Q?Biqy/yA5l6E93fQRfkz5dVSvTsRUKxJ5DOdfkP19h1VsSGjVzpstJx56kpNr?=
 =?us-ascii?Q?cBgzOX9y8OtFz9HPhe40oY0OsR76qzgpSbn404v5STflLVhiR3mzJXNGW8z2?=
 =?us-ascii?Q?y5gNkraj92WPAgnVyNXh367NPhh4WTq1V3ihkFy2yYWh7braeZ5J1H6BBaPr?=
 =?us-ascii?Q?hNGg+vTt53OEFVP/hgq2NuFbs8mJ/mw0Wv55PYsEGgN9NzLXCJeN+vc5daXO?=
 =?us-ascii?Q?/XlCgznfk3hhLbIZAGBLgRzQkYZ9Fo5IRHStQaRlPhT7XkcGRogUZhYpmITx?=
 =?us-ascii?Q?jfT7JKA0Dd4oGL6mAyaFnA2XLBxnO+4cHGUm/0e1WlEr/EshuJ47K1QYM4w+?=
 =?us-ascii?Q?/oGqcmdukaCtXJ1PQIT2zcFR8COnCMfhjdPLYFsNajqrzcvz2dbR890eq6o8?=
 =?us-ascii?Q?nuVIxMFSlqW0mBViX7E2QLOH58zd1H7rYHKElCNxqAte3ltfJdqSeNt7X/kP?=
 =?us-ascii?Q?GUruFUAT1nRDIsd4BkQAedPJ8BARybzpHOKjNCBU8jjSJ0FBmVjLywxf04Nk?=
 =?us-ascii?Q?xaxyxbEVKuaw6ChbcA47bSrMtMzIZ+w4QWjXTKYieZnOuM/rH67LljU0W8sS?=
 =?us-ascii?Q?jo/Q0LgMK59rkxLmCny3Hw1QfvJZLOKBcV7HYklYGR8pmmUNgueA4kb2NMJX?=
 =?us-ascii?Q?fDD5uo6tWeTuTUxWMNozPlJ0OaD5qQDyVE7g0ZvteeEGBeUftJGf4OfqoS68?=
 =?us-ascii?Q?GS+oyiAOfihuvXnu/ZHz6ZBgBTvlikiUwINA1PFCP/5tuFi4tO6x4oo/ET2r?=
 =?us-ascii?Q?Sdr2WioTFJtaS5TcYKXDcNenvn2Am023WfyBJMv5w/A13Fq5ni4QUfV2z+Qi?=
 =?us-ascii?Q?3Ix3HRzoeOs5zuYP1H0BSL5RKsHGRX0HeFYkokL9zZjrBvazUTn7ZO0gAE94?=
 =?us-ascii?Q?/hiVQQDt35XXFvfhk7n7br870DVLeQz1YqH1S7K8u0hek7vtw+atWpXr1fDe?=
 =?us-ascii?Q?a/856pCJShNrCzWkPrWdo5hj0UwVPTf/l+c8McJM5Js87HRjVWN2pnf5LrRn?=
 =?us-ascii?Q?bMk3NMq3o1wpF6XgSNlwgxYOo0xTwasxL1vyEeenTrstduDIgdJ2YeLEcdbH?=
 =?us-ascii?Q?17XnaNKqhuLRwYc86NfKB/Wn6A8y2hfVJ4q6vaXyqGyKNAfAnK5KN43HlwT0?=
 =?us-ascii?Q?tFW+cMxJgVH2dFMGzHrxi/cxApf9IJIsfKFMhhwElin4t0FLYmVHwESDuLug?=
 =?us-ascii?Q?5aSxNDSmFo7wFQ8BEizy/+LZnn+4Ph+Sp7nLc3aFRx8o2qVk+z48I5lBPN/n?=
 =?us-ascii?Q?XlnI0jgPXmaANIuAVRyc/pDb/PkNgzGY6yMUw7CCafhmE36ZFydDP0bT088t?=
 =?us-ascii?Q?tHt/TWw+dOinA0Y6niLVb/n4kFXOPYIkTCDbRdeJuov0P5m5f2B2OE9PwZWO?=
 =?us-ascii?Q?CAxMQvjlDHmabFWcABoFhUXAPLgKYJ5P3EylleIXHG0Pqvnc4pgWMo1BpSmQ?=
 =?us-ascii?Q?bp8FQV4BE4LOfLXAZSly3pO32vxWRR1yiNKA+aNn5HN+hfu48a7vgGiVNyUx?=
 =?us-ascii?Q?QDWHmzb7uqBTOSoIAVDGU30wFisVbdQuZRqpWEQM2LsOt4E3O9fM1tpb/LlX?=
 =?us-ascii?Q?qSrN0C6hQ3z8JLVHQb1n9lTXGDH4A48OM6qnqYVRZ8Xtnbc8/B23zWYaL+ED?=
 =?us-ascii?Q?+RfaoZbXR7Z2bvuh4cLYAMbMhQMwIF08A+nboZyKpqKXvGom46Z1I4JBHbzX?=
 =?us-ascii?Q?AsAoJRIHOtoFa0gMgA/gie3qyNFKRxMo0wkEQPiOKcWkbELpF6dGg2dfaUhs?=
X-MS-Exchange-AntiSpam-MessageData-1:
	+q7yATAoNkAyXxEVRcrTNQgKMXEaF/NjzWZC0SMdhe+ROfO8IuRtgx82
X-OriginatorOrg: cyberus-technology.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e481c1-f70f-4e86-1018-08df1f06755a
X-MS-Exchange-CrossTenant-AuthSource: BE0P281MB0148.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 15:21:11.1927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f4e0f4e0-9d68-4bd6-a95b-0cba36dbac2e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Ae87/diGGtC4XfMtgbemojioWYcaB9Pq026vTPuTHR3GzdySQHkLs5sWK95Da1p/cUXepP2pnMS7JNkCXm1mqPBOU1PP35xGZUX33+orLKa9hbr0Aldin/sWDTAHHqd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEXP281MB0135

Hi there,

We were hitting this bug pretty reliably in one of our setups and it
looks like this patch is fixing our problems. Is there any update on
that? For now, we've moved to a newer kernel (7.2.8) but it might still
be relevant to many folks out there.

I did not monitor memory growth during these tests.

A few details about my observation. Please note that I heavily used
an LLM to track down the issue and to create a reproducer. The LLM's
output and reproducer seemed valid to me:

I ran into this bug while benchmarking live migration with Cloud
Hypervisor between two hosts with Intel E810 NICs (ice, MTU 9000,
6.18.41). We migrate a VM with 120 vCPUs and 20 GiB of memory under a
write-heavy load, using TLS over 8 parallel TCP connections at about
8 GiB/s. On the receiver, up to 5 of 6 migrations failed because TLS
could not decrypt a record, and once even the plaintext record header
was broken. First I suspected our own code. But an in-process check
that decrypted 1.1 billion records again right after encryption found
no mismatch, and switching to another cipher did not help. So the data
was still correct when it left userspace. A plain-TCP test tool with
bulk traffic transferred more than 1.4 TB without any error, so the
trigger had to depend on the traffic pattern. At this point I found this
LKML thread. With the patched ice module on the receiver, my reproducer
passed all runs without a failure (432 GiB). Without the patch, 2 out of
3 runs had corrupted data.

The reproducer is a small C program (about 290 lines) that uses plain
TCP. To trigger the bug reliably, it does four things. First, it chooses
the write lengths so that frames exactly fill one or two 3 KiB Rx
buffers, and it uses TCP_NODELAY so that these frames are really sent
this way. Second, the sender is bursty and fast: 9 parallel connections,
plus 120 busy threads that simulate the vCPUs of a large VM with dirty
page tracking. Third, the receiver keeps many packets queued, because it
reads into scattered locations of a large buffer. Fourth, the stream
content is deterministic, so the receiver can check every byte. Without
the busy threads, 720 GiB went through without errors, and in single
test runs, leaving out one of the other conditions also made the
corruption disappear. Each corrupt block was at most one Rx buffer long
and contained data from the same connection, about 11 MiB later in the
stream. TCP itself reported no error.

Thanks,
Philipp
