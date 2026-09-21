Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8974F4B7A24;
	Mon, 21 Sep 2026 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006295; cv=fail; b=lDy3LENPu4dhiX4DWtXubsUAd2HnZKzTbI0trgl1dC1HwnGOBRnmK765ngmnNnciPCMw0yduST1di2bpLwqu1+zysjF6TO46mMkecYTTICeersCMupWqit9KU7l3o/J01AacJSZ9KjAwMpqFjG47Wj4NCnej0hKj7h13EbXb0vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006295; c=relaxed/simple;
	bh=FV52rdIh1FvzpnBP3ZyS9lrjRgVDRTP75lsCgWYM4u0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rcBf2LdXBRVcfSxTmd3GM/Oojo+YVYs8zieH1N2mZnklgCDPtrpjFkm4u1T+45oZjq+/ybwPGr23j6zk4Z9bE6XyaRXzVcxLaQC7iqkc5JWzUHq3L0pYfyoNpaHMpiJMqz7eQBp7PEfV782qKQwdOM6NJ3lZHnfPLI8M0UoiSxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=Fi30Q+9t; arc=fail smtp.client-ip=52.101.84.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="Fi30Q+9t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jA6iGOHXhpsubythuDrzBxWJXJ3FDeQ2n3g6U3i333G/x9PcJkM8bVyQgI89kxfJKWZ+ynaJLyp4ybDkb5X1kxnEvPAdzZm1jE3iREKcMNCGJHzvPtSf1AcRYulpgHAHxSO6MrIyJ8x5yzymGlW+3JP24WPkSMEqEuyeDEs9HmmT1+uwJVVjEOk3rpnUjGqdKcEO00wroB3q3eihG2a5wxXymp3mfPK8oFtI4eZE+fWDyiIItK7+BhrH4u2YR9zFzvduRpyAN8KSoXd0H4497JGEnRQE6aS4tJaYk77w9YdF3IYvfYMztK5DFA2lFOGBP2BIjcuxrodicLVCgvf8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2h3Uab3ZQF3A8K46BlqhPhnvpukrpPPYZTiekN9RIQ=;
 b=jUCM53Cp0pYZV4JXUjzHy6QBQPwWc0P09ByB+aGSqL6jE97VMABvvilLO9Nns/yAMyrr8yczgj45sAzQUNnc82xJmVf044WttRG5ef0cHqFN9xGoUj+IMrLLORSrha7qQghTFvSzy1omUJ2JNk33Muc1H76Udy/bzPMn+W3WXDX8MAIYUh46rwpjVMiiLFCK8W9JovuDu+7MjnwOvlWxI3vTFVTvFOTvXYGFzXV/Kbwq2CIVwQbp+J6uRlDZSk8g5BZYAPwkhGC2lYraIVadj3TG+75P3EYFkBDmCRUDUnvpiQPypGVDJDJ/3agUmSXti2oiKxh73KpA4tO6oaRkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2h3Uab3ZQF3A8K46BlqhPhnvpukrpPPYZTiekN9RIQ=;
 b=Fi30Q+9tURcRHo8EONOJg+hDRE06AC/ZacJGBtrt1qHMJpKDl/wsLvaXw/cfP4R6fD1aTvbAALjEmF4W1QJgBohwntoz+BuOyF8zbUvWDUkeD+wsFTDoA9142iuBX+NKRxp0eXi2uKjRPJ7JhyKgUebur/rZsILHdiJkXr7+pZp+ty3XHG+MoflVV6XG5Amrc+AjdLxplhuqdFbBZUNdPrG0kFfCvkYd2u9zBTpI9XGvg33OU5Ea54jzb0bHOuwbfjsgqfUjRm1/I7V3IstGX94DEAj6rZWU6+lE3vfQaVdkLwdCncKCrp00ZdfXzo51kWqVCcbiPkH4fonJcKMcGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by DU0P189MB2092.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:3b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 15:58:10 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 15:58:10 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Taehee Yoo <ap420073@gmail.com>,
	Yunseong Kim <yunseong.kim@est.tech>,
	stable@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] ipv4: guard inetdev_event() against a NULL from inetdev_init()
Date: Mon, 21 Sep 2026 17:55:24 +0200
Message-ID: <20260921155522.679350-3-yunseong.kim@est.tech>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0003.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::8) To AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:39b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P189MB1752:EE_|DU0P189MB2092:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a334b0d-7b81-4e6d-f4e5-08df17f9223d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	BxZE6NrHuoXMsVImr8LxmHSwSFyisK7SxCLxCscrJ3eNBBX3Ekut/MayLpkRSjadEtiQmJunA8gwO8TbDbEXjDmRbHqHpPMwG+CHTjKWvz+f1DvZyijwto5AqiDHsxB2urAWqjYbjjp3EndQIoYt9vyJLZzwvPTcvd/TsTYDtnpZGeOB5lDHJuOjLx2Sisz5VxSj/5bU3To29ebmE/A3CDC5npTlsji5/5thHP9/CBPVFdyqGr+EGv9weM4ujcPmOCpj0SUSIIx0wS113gUxBwFTGmNyP+EVm7s1oNZz/sbtsr9WCJqFikKdKLKbewnVy/CiTyO2KJVnLm2flN8mMj4xOHaaYdsQlEb8/f4EiJf0RuiPKxt7OzLsYQDaP2Ht3ZkOlCZ3Vo6UkbIcbwe9CAnvkB3c0hS5BYON1FZc+Uwc52F70j3wNUcQwUphUVlhWOvGk8ojXsLHnNP3bDo09k7tNc8swMr7V9kjHOxeZ9SN19vR2VcYHTL+YK2fFu/FVynxThmHvhTdvJxhACH44B0kBrvdEWOXU0zBq45u8wkccWD8EwaLKDZr37lE44Blky2oj0t/eyt7o1IZ3W6xD864wde01Z9Av4nyNhuxaDM14+PZaiZwJVsWOtU/X519ndtVkSOLlUibYkmP2ls0lDdmgmQZpUN0sj8HqhpQMzg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LR2Jqs2u/qrvSsnx9lyYjnarRZh6/ORN4F19czQ9WWrGG3zTiUIHUd11MEQ2?=
 =?us-ascii?Q?5p7BK68LrXd7YQodXuf0Ezy9LzKuR4sj4HDNTWBKNiWwMVV4CTkYdl6V3g1e?=
 =?us-ascii?Q?GAzllCDeBMnMCIogUja+QTxnzHUZQ5r7JM3aqGihs+gmqKfeb6l+sPPPe1xn?=
 =?us-ascii?Q?bg84GZuAou8Uyp/HE+7aIvF32QL3oAMAKXqvfzx3g8Stuh6TZteMaA/dm1v/?=
 =?us-ascii?Q?ccokH2JJEd6Z7a8c7t5hBvR7gIOwErE9JdYxqLjHYuG5jx77yfToVVAkUn37?=
 =?us-ascii?Q?0FscypSvTcIi8Udda1JhiyJMkj1P1qQdeW81x2TDUTiFT2WCuB2AOz9IutBW?=
 =?us-ascii?Q?hcrB6gKQtD2KmRBlzDrwP7U/y28OS5yhD5nft3YBTBRnnLIEahP6ZREC+yth?=
 =?us-ascii?Q?fejG7IdrALSXN517CbwZVXHEkIAbE+BAjpPn0cVEYYnDSKL+Bwg8mgrrxdwR?=
 =?us-ascii?Q?8gsaAcOGJxTEANdR/DuLtg+EceZvhwGzqWYV9oDncgWPBdxly2pFcM3Sq/P0?=
 =?us-ascii?Q?1jumxzzgYEkfw0yrMoP34BrpmvZxXYDRbEjALw2Fn6hCgdrdEmMmjWjaiyop?=
 =?us-ascii?Q?YBl57TmoJOpEEJCFlXF0AAn4UGqAUqtWku0qAoZsLtpjnmY1dI17t1doFfFF?=
 =?us-ascii?Q?7BdfFz7W+e3ksq2tHWGEoBqUc5q0efZBqiammtNZ2unKLLEaxgCeNcxHnCLH?=
 =?us-ascii?Q?Ho6BoRA2y2cpurHvGAUot2zwVpHa8XUezOhKpPskm7klYqhid8vGc7GjhHh2?=
 =?us-ascii?Q?KwVGdD4yrcVVGhz4JeU6imJQpTXdqwvucp5fm+HhxNE7HES3B+zY6YAG3mr9?=
 =?us-ascii?Q?cBCFxhm49imQYLS2zulyBUgULbotQ30mni99adLuyi/+jx7WRkury9lF1+8j?=
 =?us-ascii?Q?PNXFIokZnf9eFL8LZ18t+bg1kb84KFAHVQvuUjtRsZU6uKcPM+mPIBr4lKP0?=
 =?us-ascii?Q?oSMBnOJi9hx6PYkr2OIbZJnP1uOC+K/CqAKApNeZaX/mu6gYrvoHQujBNndI?=
 =?us-ascii?Q?hVwv0pEEh3PlUmTfEFuODupq1sMFuxb/cDE4KPZOJ2Wz8NQkBX4DgAhjMAYT?=
 =?us-ascii?Q?Q/OG7wEC8BytmwvXyR3iVlyW1ynhmp+v/QcNrfgUg7lEbw3xcUT2vGWlmPDk?=
 =?us-ascii?Q?8KnkkpvEr6eLeFKgxctugtMGbMrBqtyK0R9A1YRFpwuAmnLPUKYcDJyS4ODd?=
 =?us-ascii?Q?5ALV6dFJcgIGPiIAE9tihkPEpE1d9N1+vq2q5gMIvg/hNhYCQu9I5YfuFKVU?=
 =?us-ascii?Q?DSmdXkh3Wx+eD5tV57vzrXVl6y3MHhfWBhOHWJIQodpiIH1V4Ph5BzR2oT/0?=
 =?us-ascii?Q?iIlrmpIoZOv5LwtTIg7vcxQaDszWIwSWdH9SlIRebMGxcauZr3ZHveRMu7Xz?=
 =?us-ascii?Q?7v/n57fVN7JrJ+DVarnHeBvOzyNuKktKphZfVwboT3ywNd2FHCqjwuxAm9Np?=
 =?us-ascii?Q?nai6nGK5cAFqP/meQp85OWZ/VhFtlefvnLbRH0G/RFusjzZvL88lYt2iGkbi?=
 =?us-ascii?Q?vUt+mCKcayLrsx3iPHsTm1/EfNYgvtOmUW2Oo6+7EOoGlXUXaEFY4gCnlPrl?=
 =?us-ascii?Q?hf2yxgvW93fio8wEP1LcpIZ1mbFaM/fpm05w2Ol4JUhEF6vut+yS4d4w97xw?=
 =?us-ascii?Q?6/42C0zAsk3/FXDJDWdXjNsWpUyV9UE3ZEHzJi0fEPSbHKFr+DkvZXnjMQr9?=
 =?us-ascii?Q?n0hTeYXQnshxIL0Q6s4F5GtGKOmUlMKxMUX+UtiaG4+wzVK4bECcshJ9zUju?=
 =?us-ascii?Q?884y5AgmNQ=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a334b0d-7b81-4e6d-f4e5-08df17f9223d
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 15:58:10.0192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jjRy4szTxRIk9u7LDk0PpUunOzPwRETg+grkSEVrqBzqg8lMOKMSOR0rmBluA42lE/zVYGT7hJ05uiMjN20ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB2092

On NETDEV_REGISTER, inetdev_event() only checks the inetdev_init()
return value with IS_ERR():

    in_dev = inetdev_init(dev);
    if (IS_ERR(in_dev))
        return notifier_from_errno(PTR_ERR(in_dev));
    if (dev->flags & IFF_LOOPBACK) {
        IN_DEV_CONF_SET(in_dev, NOXFRM, 1);
    ...

Because IS_ERR(NULL) is false, a NULL return flows straight into
IN_DEV_CONF_SET() -> ipv4_devconf_set(), whose
set_bit(index, in_dev->cnf.state) dereferences NULL.

inetdev_init() is only kept from returning NULL by its trailing

    out:
        return in_dev ?: ERR_PTR(err);

which relies on every failure path that leaves in_dev NULL having also
set a non-zero err. That invariant is fragile and lives in the producer,
while the consumer's IS_ERR()-only check silently depends on it: any
future inetdev_init() failure path that returns NULL (directly, or by
leaving err == 0) becomes a NULL dereference at this call site rather
than a clean error return.

Before commit 20e61da7ffcf ("ipv4: fail early when creating netdev
named all or default") this call site used "if (!in_dev)", which caught
a NULL return; that commit converted inetdev_init() to the ERR_PTR()
convention and switched the check to IS_ERR(), dropping the NULL
handling here.

Decouple the caller from that invariant by using IS_ERR_OR_NULL() and
translating a NULL return to -ENOMEM, so a NULL can no longer be
dereferenced regardless of how inetdev_init() signals failure.

Cc: stable@vger.kernel.org
Cc: syzkaller-bugs@googlegroups.com
Signed-off-by: Yunseong Kim <yunseong.kim@est.tech>
---

Syzkaller reproducer:
# {Threaded:true Repeat:true RepeatTimes:0 Procs:8 Slowdown:1 Sandbox:none SandboxArg:0 Leak:false NetInjection:false NetDevices:true NetReset:true Cgroups:true BinfmtMisc:true CloseFDs:true KCSAN:false DevlinkP
CI:false NicVF:false USB:false VhciInjection:false Wifi:false IEEE802154:false Sysctl:true Swap:true UseTmpDir:true HandleSegv:true Trace:false CallComments:true LegacyOptions:{Collide:false Fault:false FaultCal
l:0 FaultNth:0}}
r0 = creat(&(0x7f00000000c0)='./file0\x00', 0x26)
ioctl$RNDADDTOENTCNT(r0, 0x40045201, 0x0)
r1 = socket$inet6_udplite(0xa, 0x2, 0x88)
setsockopt$sock_int(r1, 0x1, 0x1d, &(0x7f0000000380), 0x4) (async, rerun: 64)
unshare(0x42020000) (async, rerun: 64)
truncate(&(0x7f0000000040)='./file0\x00', 0x9) (rerun: 64)
ioctl$sock_SIOCBRADDBR(0xffffffffffffffff, 0x89a0, &(0x7f0000000000)='syzkaller0\x00')
socket$inet_udplite(0x2, 0x2, 0x88)
rename(&(0x7f0000000640)='./file0aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\x00', &(0x7f0000000780)='./file1\x00') (async)
ioctl$BTRFS_IOC_BALANCE_PROGRESS(0xffffffffffffffff, 0x84009422, &(0x7f00000004c0)={0x0, 0x0, {0x0, @struct, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @struct}, {}, {0x0, @struct}})

 net/ipv4/devinet.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index a90be57c63be..353d7c584463 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1588,8 +1588,9 @@ static int inetdev_event(struct notifier_block *this, unsigned long event,
 	if (!in_dev) {
 		if (event == NETDEV_REGISTER) {
 			in_dev = inetdev_init(dev);
-			if (IS_ERR(in_dev))
-				return notifier_from_errno(PTR_ERR(in_dev));
+			if (IS_ERR_OR_NULL(in_dev))
+				return notifier_from_errno(in_dev ?
+						PTR_ERR(in_dev) : -ENOMEM);
 			if (dev->flags & IFF_LOOPBACK) {
 				IN_DEV_CONF_SET(in_dev, NOXFRM, 1);
 				IN_DEV_CONF_SET(in_dev, NOPOLICY, 1);
-- 
2.55.0

