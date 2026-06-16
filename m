Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012046.outbound.protection.outlook.com [52.101.66.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC3A314D18;
	Tue, 16 Jun 2026 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594684; cv=fail; b=IaYP08yNISuTuWfrCTTFB5EIJFrES21pHhvpfVLYZ6AHiJkfr9O+S1m9dn68tTS9WvqISDWfE4XezqPDYC+zonABxK4AokxoFMh1nFsYh6ZeGXIUIpd4XTEG5Hz3euKhgWWXV2+XJEyAuKk2gn7R6mvJCokJ5QqcSv7EzSX88To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594684; c=relaxed/simple;
	bh=dwOWiC765CTzven4anywY66iqRv0mDw7IG5KynJgibA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M9wk+A/2JhRwuNbPWZLEanjuidMQvzRxHUFU5V0cibxuEujApiOnNIg+JR6ZoQRbeHrTj2EToZTz3GD4Qz0NtZ3EHFwXATuvfC5+oh+43okof8YrgIXDMc0dpwDV25V80ovb1sECggJOu3TQjcyh+iBQxh2yJbMO6MDH00zdArs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=0bSLdUZz; arc=fail smtp.client-ip=52.101.66.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="0bSLdUZz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+MpSB9GfcjARxoqQ9n9hsqcfqKz3I14XpELgpCCGjSC6OxovduYLxnI+EMKhwLy8cazlwl9IFCF7lVHakGgZy7MyY2q6cCtibyV/gpijJTK8Kiaxs/iu1dAAfcOSO8Br7Rd2oecmRy2Rh8az8pl7mSLyuyzFChDlrKJYum4Q4DPaca1hJimFd5g/rs1vTIHzvgrR9Xsx8FjNogPH98G/uZ7i49yGIevWsIpSQ58jG4sCZjkNQihnSnjGTsR9MLAMOdBuK3djMT5NS/ASAyih1z4d3GXm9n05sK5PlDPxDUw/rOC6TLO2Zm8WVICe2JdySma9P239HbQaZdcFOk+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yy5KA33UxKXm04+6kmPinXQOunlrDNzPY3jBL+Qf7T8=;
 b=wjR/NTKg0xVXCCh5lU8SbIFBYmGyqhuKv7VsSKMPUtC50SpqUtc3FKjGhuS6ntLyJJkbnmxkgGlNlemsHisnA4GhfIJLVNPr6Sxjt9uaPDtFuyXfoRrCskCAH7YYHN33QjzGUOPOtgQH0RN/SRSCiuAptnqHT6wRqP/8OTHCalpyc3Pyp2pbQEHZ8r2gYhEnQE976eHmh+LlhjrywbsC07Wc/KxoALHYMUNhg+xIR14zd/YmVNdt9Ft48bwxS7EdmvdboNL2ntIhx+5mklbGYCDqb8aKmq8Ra9dRICeLT8ORMaXRrcSAUkR3RRTFDdM5qb/CJdfHpGxLL5gOVHPFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy5KA33UxKXm04+6kmPinXQOunlrDNzPY3jBL+Qf7T8=;
 b=0bSLdUZzrsQGrpbTDjiKeTjeRS5o+S879Lzp5QJFgE4Fekc/vbRWx4dAP/JWGjmpOKP12/i71T+ciqqYncwFo3nUor1v+D7mtNzeYYUJ5BuYDnKEWQ6yA/IhfeQAIP71d01GlV9opL2zptAcq7QuGU2lJi8qPtbTz1dbvJcqwayz50dwEF09S79dbicVYKh/jKNYA2ccLijFEFfbE2aqGTTczEAWAoHRu2g1APgFQBZj5gY0gcbk/ee8TaFNd41UJKE1HU/9O23OUr2BuUuzE1PnNNXs+mCfpwtvv9sd+ptXKjIKtmECYroa0tR3cq+72vFZzpK8r5eQYjft9ftuxg==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 GV2P189MB2887.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:265::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Tue, 16 Jun 2026 07:24:36 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 07:24:36 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Doruk Tan Ozturk <doruk@0sec.ai>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "aleksander.lobakin@intel.com"
	<aleksander.lobakin@intel.com>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "jmaloy@redhat.com" <jmaloy@redhat.com>
Subject: RE: [PATCH net v3] tipc: fix slab-use-after-free Read in
 tipc_aead_decrypt_done
Thread-Topic: [PATCH net v3] tipc: fix slab-use-after-free Read in
 tipc_aead_decrypt_done
Thread-Index: AQHc/Ly7cJEs8zp3ikSAff4HL4pmFLZAyJfA
Date: Tue, 16 Jun 2026 07:24:36 +0000
Message-ID:
 <GV1P189MB1988976BF420AA4A8650CF07C6E52@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260615114618.71249-1-doruk@0sec.ai>
In-Reply-To: <20260615114618.71249-1-doruk@0sec.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|GV2P189MB2887:EE_
x-ms-office365-filtering-correlation-id: 75035d3f-dc9f-4d4b-c178-08decb7851fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|56012099006|11063799006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 zw1imTzD9XY1vQjpC7ZhE8gUZvxZT07qN1Zfluf1y1ac1EPdkvu6DSdfBHE0TZMNjvbtndsjG2xkBirQ0i89MpY4yX0X6h6BIMxcEQvzjhntKiee0LsaHEA6L0dciVa1BAwB8wej4qbvuskTgFTt+gMwMkXp2R2xDpsnobOO/4lRFm2nzJAf2iSx5yL9zDcPoiqjN2zVYMz6kimB+rFc17vw+NeMPAzihXgS9WGz72m+fWYbfk27t8wPQG30XljEDUH91Rkoj6/O72J4/RRNGXLcSrumimzF64pvyQleKrk65ZtfCRVzfY8wOQtEYuPntQllOLLnrSuJxIvgZZaJS/ra/wL5ZRgOv/mNEiMWkT80JNwKLrSxysZwftST++ptEbVlY47cS+Y4zDMbVFkPqqfa6lUbESs1stJ7/LYjLgC4CXY8imd7MzMoAVC6dBM9ny+nGuluqhR1uL6KjGI7DpnsVQ2ogrQe41brxjOjLGjw4iwxoOjjEXpUdSCMXXysW3OZtfIW2YhycL39YdkDg05y9TAAxJTVRG6XLvaL16ji5WF6QlAxrEUKae3bQStSIbk52XWiBvq2jA5P50+r9I5c9z9Bvp8GQVg1ZGFzKYJNJtNbdlqyA/6Uu2YKvb0GBvqL4ulnuXjcdf0Iw39VhqEzi8Xso4wuYWdTU7XHSkax5ftWVKY2VXUYWpEGObqh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(11063799006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VFuKwOcxLHm+8kRMgs55d5HnFeV2htfMV3fpkUFzOo0dNOQH5F1c6gxDtKc1?=
 =?us-ascii?Q?LKZdUiLn+X3tIEe9UbAxIDr2WNMgC2v251MSYBu4hOmpehQ1TKD03jf9cJB/?=
 =?us-ascii?Q?ElFI6IwLMB5Aech5nolqV5UqyuUNZSfS3SiYqy7QW9ZK6dT6o9TM9TR7CbNQ?=
 =?us-ascii?Q?yA4oNAOWLB6W2KGzzdaw/36p6X0bERnhty0YOPmhWlqPaivk3wNEfUxGg0GS?=
 =?us-ascii?Q?z9T2avqt85esdDkZNXvQ+1mfXN+VuaEhZuZMvS+ToQNNyhdwGcXHtHHGuqjC?=
 =?us-ascii?Q?9OWvudsTBcLvfdle2wO5VApmvKKe45ilq1TMVvm6R5o2untuVN6PktBIGXmy?=
 =?us-ascii?Q?VYK82mTnMq0ixFt0alRuqHSZSwbq91T21w0zeFhP+o5NwlX6tKwfnZKxY3no?=
 =?us-ascii?Q?GYVd2svNJQiKUAy+SxvwNK1sJJ2dbFE+rTffqgLftDcxvXcM6jO2ZZHMu+zb?=
 =?us-ascii?Q?UH+7F0EoMgLLQI2BXgpGSgJaQ+CifJHKwdZGN2Sl4LBrwcqW4rlUrAk1OSM5?=
 =?us-ascii?Q?J3sSv8gHja1QY/QOwLlVnJObH+8SPtDedUwJHnXTEQpp2U2EGHLpf/OrSsPp?=
 =?us-ascii?Q?YuBlKAaJqFAyze+xb0x6v8Eu4wvCSO9SNgn9jq4j7zxY8gfC1oQyzOov15cZ?=
 =?us-ascii?Q?D0Ac1LlZqA7PTL8NfiXz1h85Vh2hstXyL1bWL+dAKJek510fyFyozA6qkQ2x?=
 =?us-ascii?Q?+Jzf2SOizvhQwDl7muUSAI/pL3nLtR22lpvNVKaP24nzA42rTTHpuQ1BWLFf?=
 =?us-ascii?Q?dB/yWJAAwJTxo2vfDDVvwC5VpltTiei8YDjTtO5lkTqI1OhC/6mMhV0FZGjq?=
 =?us-ascii?Q?MbWLEJW+3QuYGa8a1TiAuDrRla4ECX0JDvvlM8P1WmGhX9v2+pzzHkJgrJyG?=
 =?us-ascii?Q?0u+TwSm1OugNOF9/Z+OSP8IvJA2ES1rzJNh8vjbMyqNgBM1Bxke+TVPGh5Rt?=
 =?us-ascii?Q?fKyBU2bCNv4ZSDErW5DrAUmGXaVoGY5MuALycHQm1G470UsoV7CZeN3xUYII?=
 =?us-ascii?Q?2wWorr6CplcpXf+wtFLOTVYkvlKZN+4ek2ULeCPhdAuA65ubpjYYnPoxj71V?=
 =?us-ascii?Q?b6hfmy0YWLjS8kYplKEVa5qd3x1zeKdg/+iqDOeF2FpI7idjl3ntm+6j6UUS?=
 =?us-ascii?Q?bQvd2Nuc68S6jI3WuLsGDXg0ZSJscokdG+gHFeOs/0lmxdxBQyC6F4ufuVQp?=
 =?us-ascii?Q?yY1zwtbVGInszi0hQNFBRaj1ZrG8+GcskTjqk4ppxbrGMFjJI8CQ7RxhHX0Q?=
 =?us-ascii?Q?68rt74TqcWcrHTcrw3pQP03j3oaHSAZJbgDHlSmNjGOta2q4xG/a5ZZUnzcy?=
 =?us-ascii?Q?nt6LSsDYdOlzrOTwDtDSDt7EYki2lPmyroKF/XjF02VPMD6XPxPdD5HfYfz/?=
 =?us-ascii?Q?Be0/BAbEmQahdDCMeQh6Iv/wLER9jIf0cxHH6t3fXwyhq0nyLiCWGGyHg41/?=
 =?us-ascii?Q?7JQ59dqZd6mJb7k/ktUpSC7N/02gn45/WLKFBRK2veIZiKhyuZ1HGVeGLct3?=
 =?us-ascii?Q?bzk9qQo70m3CLtDhi8Y9RobayfbE7O9K/YVViWb0QNVo8k1H5JyBQRPc9Mvk?=
 =?us-ascii?Q?Jq1DJtZnkU6kjMlNC1v2LkWT7f4X7cRjdXtfpXzpSuqQrwjYMwh2ILWev5bh?=
 =?us-ascii?Q?PePXPO//Ipv5yKev9QURHsNaGY5Bbx2aSqquRmpk6PZT3gfKck20P6586/rk?=
 =?us-ascii?Q?SoizmfAtFf8dwYoAYycfKMoLXB+I4r49EmmEQa3rJoOp1yG3xceaTsaW7+EE?=
 =?us-ascii?Q?N4ISN2qKkA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 75035d3f-dc9f-4d4b-c178-08decb7851fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 07:24:36.4768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7OfbBP7n/6tFTAzxS0K9hHfFzE6K8FTBrM+CHLxp1qjZRVT6YRogdwdLLfcjVCteb9k/6n9gDXHfMB2cG3JwHYzwINND7npgt5SEJW12y+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P189MB2887

>Subject: [PATCH net v3] tipc: fix slab-use-after-free Read in
>tipc_aead_decrypt_done
>
>tipc_aead_decrypt() goes straight from tipc_bearer_hold(b) to
>crypto_aead_decrypt(req) without taking a reference on the netns, unlike t=
he
>encrypt path. When crypto_aead_decrypt() is offloaded asynchronously (e.g.
>the SIMD aead wrapper queuing to cryptd), the cryptd worker runs
>tipc_aead_decrypt_done() later. If the bearer's netns is torn down in the
>meantime, cleanup_net() -> tipc_exit_net() -> tipc_crypto_stop() frees the=
 per-
>netns tipc_crypto, and the completion then reads it:
>tipc_aead_decrypt_done() dereferences aead->crypto->stats and
>aead->crypto->net, and tipc_crypto_rcv_complete() dereferences aead[]
>aead->crypto->and the node table -- reading freed memory.
>
>Decoded KASAN splat (v7.1-rc7, CONFIG_KASAN_INLINE + TIPC +
>TIPC_CRYPTO):
>
>  BUG: KASAN: slab-use-after-free in tipc_aead_decrypt_done
>(net/tipc/crypto.c:999)
>  Read of size 8 at addr ffff8881056258a8 by task kworker/u16:2/51
>  Workqueue: events_unbound
>  Call Trace:
>   tipc_aead_decrypt_done (net/tipc/crypto.c:999)
>   process_one_work (kernel/workqueue.c:3314)
>   worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
>   kthread (kernel/kthread.c:436)
>   ret_from_fork (arch/x86/kernel/process.c:158)
>   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>
>  Allocated by task 169:
>   __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
>   tipc_crypto_start (net/tipc/crypto.c:1502)
>   tipc_init_net (net/tipc/core.c:72)
>   ops_init (net/core/net_namespace.c:137)
>   setup_net (net/core/net_namespace.c:446)
>   copy_net_ns (net/core/net_namespace.c:579)
>   create_new_namespaces (kernel/nsproxy.c:132)
>   __x64_sys_unshare (kernel/fork.c:3316)
>   do_syscall_64 (arch/x86/entry/syscall_64.c:63)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>
>  Freed by task 8:
>   kfree (mm/slub.c:6566)
>   tipc_exit_net (net/tipc/core.c:119)
>   cleanup_net (net/core/net_namespace.c:704)
>   process_one_work (kernel/workqueue.c:3314)
>   kthread (kernel/kthread.c:436)
>
>This is the same class of bug that commit e279024617134 ("net/tipc: fix sl=
ab-
>use-after-free Read in tipc_aead_encrypt_done") fixed for the encrypt side=
.
>The encrypt path takes maybe_get_net(aead->crypto->net) before
>crypto_aead_encrypt() and drops it with put_net() on the synchronous retur=
n
>paths and in tipc_aead_encrypt_done(); the -EINPROGRESS/-EBUSY return
>keeps the reference for the async callback to release. The decrypt path wa=
s left
>without the equivalent guard.
>
>Mirror the encrypt-side fix on the decrypt path: take a net reference befo=
re
>crypto_aead_decrypt() (failing with -ENODEV and the matching bearer put if=
 it
>cannot be acquired), keep it across the -EINPROGRESS/-EBUSY async return,
>and drop it with put_net() on the synchronous success/error return and at =
the
>end of tipc_aead_decrypt_done().
>
>Reproduced under KASAN on v7.1-rc7: a UDP bearer with a cluster key is
>flooded with crafted encrypted frames from an unknown peer (driving the
>cluster-key decrypt path) while the bearer's netns is repeatedly torn down=
. The
>completion must run asynchronously to outlive tipc_crypto_stop(); on x86 t=
he
>stock aesni gcm(aes) now decrypts synchronously, so the async path was
>exercised via cryptd offload. The unguarded aead->crypto dereference in
>tipc_aead_decrypt_done() is the unpatched upstream path;
>tipc_aead_decrypt() still lacks maybe_get_net(aead->crypto->net), so the
>completion can outlive the free on any config where crypto_aead_decrypt()
>goes async.
>
>Found by 0sec automated security-research tooling (https://0sec.ai).
>
>Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
>Cc: stable@vger.kernel.org
>Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
>Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>---
>v3:
> - Rewrite the changelog with the decoded stack trace and frame the
>   reproduction on the current tree (v7.1-rc7); drop the v6.12.92
>   references (Tung Quang Nguyen).
>v2:
> - Add Cc: stable@vger.kernel.org and Alexander Lobakin's Reviewed-by.
>   No functional change.
> net/tipc/crypto.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c index
>6d3b6b89b1d1..84a6489da036 100644
>--- a/net/tipc/crypto.c
>+++ b/net/tipc/crypto.c
>@@ -941,12 +941,20 @@ static int tipc_aead_decrypt(struct net *net, struct
>tipc_aead *aead,
> 		goto exit;
> 	}
>
>+	/* Get net to avoid freed tipc_crypto when delete namespace */
>+	if (!maybe_get_net(aead->crypto->net)) {
>+		tipc_bearer_put(b);
>+		rc =3D -ENODEV;
>+		goto exit;
>+	}
>+
> 	/* Now, do decrypt */
> 	rc =3D crypto_aead_decrypt(req);
> 	if (rc =3D=3D -EINPROGRESS || rc =3D=3D -EBUSY)
> 		return rc;
>
> 	tipc_bearer_put(b);
>+	put_net(aead->crypto->net);
>
> exit:
> 	kfree(ctx);
>@@ -984,6 +992,7 @@ static void tipc_aead_decrypt_done(void *data, int err=
)
> 	}
>
> 	tipc_bearer_put(b);
>+	put_net(net);
> }
>
> static inline int tipc_ehdr_size(struct tipc_ehdr *ehdr)
>--
>2.43.0
>

Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
