Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.91
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795745163;
	b=jnKItat9UZbIMV4u3P2SfOFC/9EQUXHrMKAC0mul++w9I0srfb0ffnzPGMNVrORZ+mhn
	 77YxjsoaWGT3TiaIBt94pWJFZR41dtxrNmClLfCYW5W06TLxPNEYrzCPVSDRpHqe0NZUA
	 PHRZ4r+fCQ2Qp9XVahlQq6CpJr68pt/mMWmlTo+1D7FuePrX4rFE/EHFJqt4X/hGH970h
	 GGmrufZQdYU17jkpk1+wWczH5XscL4GMne/7FNO4S4IgCAMq/gkoynxq2Vx/CouAl6lk+
	 b1B9MBYEaVIMubb64ogSBBnaaubntRu1bpB8Ce1uEcY1ymHfo8QI4lmKPlrdFLx9/PQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745163;
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
	bh=NrjIwa/17OAzpyz5Wh4De8t+oJV9Ia1FSvJgBkmoScs=;
	b=cc+nTibzX3F6WKaQjsAnYtiLW28VTMepm7ootCZEl6Mgt/nn+MjkDJURw8NvJipWs8E5
	 ClFA03aG93RCu+d0/C7hijIRbKLIbK5UeBa0Y0NXSQ283t7eSvOi24GGnPFL4KKLSIESk
	 8pF1vcI2ZwqlrnYm3pJZT/iw2dVIVCsnTL7l76WUeQKK3ENeLUN77TgJmDx7HaKWOg/6C
	 YKsZgQIuAhS8zaJ/Iq1+XyCAvCHfVMCw46aHuqAdP7MIhI0wE9fTwWqH4NIc0G8ivC1Qv
	 f2bnZpCI5QuV8d/v2P0GPkbPk4aAHY107GSK9cSmFG1BRQ8GTX4CK1ILIsL2C++hKuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ezAyXx1A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.91
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020091.outbound.protection.outlook.com [52.101.228.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F9D60A260D;
	Fri, 27 Nov 2026 02:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2F9D60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ezAyXx1A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsOAW3djMaV9lXTNL5nAKQA3f3zv2TB3JN1jiXJWKGKpV/NxhRw4TvkH1fOYiGKZy8wSRtZtDRYjtDLczeNptHY5cp5Z8Ljc5o+qt9n3JeyZzvECGg8GMY+nUhgbYs7s0HETf5rcLAeb4bUckh2U+myKrstcbRieR3jjtjl4xbAbwOX82rLSL254CpWb1d5JGIB02o4xg7Mw422Yhs5YIIGdkAn4i+NjcforA3tBQWmWagSYouWvcfU89rVlhg8jXMZfr0KNI3k2VPocm8YAHtgsaT4jLCOc8tBlKFoAqtI21aB+av+e+OjRHjOGRitHnOGHYykEv+IdjCRkQRGcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrjIwa/17OAzpyz5Wh4De8t+oJV9Ia1FSvJgBkmoScs=;
 b=Uh1Vq19UJLGHSfJxe8NSxdZkV54Rl12dJtv+t9ZbrFZVuh54lUkc2q0koFk3oj0vHZ199h2UvFYh7p8pbL7VAK0kmEu5G/7reV7fwot4R7q3oMZaN7OGcijHERFM2FIiM9CeRNO01Ap4yKzx1kBpLy9HoAS9MYs3/BxqY0cDfzjYCi3zLK3T6yVOpCjmmAtvlC+x4NhTCCebeJUkOCSrS8lk7B6xVbb65OR7A+uOYzZ8xpDzn74LwnZaqM1OfJC2KmMBfte+dzXdP81o4NngZudQlRjyNYNKg1GeQPFG/Z77x+sMpNBQd3177NRyyvQ42HF+BWe/r52xtsOiCM6/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrjIwa/17OAzpyz5Wh4De8t+oJV9Ia1FSvJgBkmoScs=;
 b=ezAyXx1AfmPK8bI9uxwmnjRZtetG9W2DjbdilexYgCEMtaASMjV9ZH4VKapcCioUVrRKs3NAR0Mug/f5ECVcpGKprdGiU94aJbn+UHgJRFFdFY5cF23EpktMJxKXv/EzQnml+CJurUhlOc6BJPtoA9lXb3V4kFrx7o56tz22knQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSBP286MB5984.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 02:06:00 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 02:06:00 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Frank Li <Frank.Li@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: fuyuanli <fuyuanli0722@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Joey Zhang <joey.zhang@microchip.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 14/15] NTB: ntb_transport: Abort link setup on QP MW allocation failure
Date: Fri, 27 Nov 2026 11:05:32 +0900
Message-ID: <20261127020533.2481725-15-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127020533.2481725-1-den@valinux.co.jp>
References: <20261127020533.2481725-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0177.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSBP286MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a27700d-570e-45df-d714-08df4c2afbb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|10070799003|376014|7416014|56012099006|10067099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3dM7Jz51ZvjW3eSimioz/VqOXFEI7a4wOREnyLozOB3CcW5m1iPZaAwd5XTEWt/qtPJmoZVWQIJ0c/+BfPlSnYaukrKy8fsg7D3qTIBxpHyqc6puPcNTJKoWEannMniCJH2qW/hepsKehRdUVzedffhbfmRtUmDUyBZLGx+DpPZoMJ3icSa2KnnSQ98f+okRVZU5aTt3kE8nyQIb84CVoAnMUn4Jw3FEfuzVA9L3d2auz3+BK4J0Va9C0br5qqqKbdfgkQbOrSvl6JNDwWW0Be73qCszeMn3tCaMT2rPA20u+Hkm0L2XlaEkg0RnfpyABHgkK2fHM/jqeP9TU3LqWw8BmIVrrDfGGrbtE4mvqUa9TB5aDETaj1Qv2RRDKl7X2hcJWc0pyoB7dVhpHaVAZBxK3pGET6ejf2we22Vw+vu0gDpDApWKDMBR2G8PIBAJM8JuDikPrWOCvRXzTtlHpN8Ua/w6VgVoTJm/g1xdAvRnRcdnhiBXDdaUtAyll9tkCVjSdIhD0Ptyh/qQD5QfPhruMzog2nNuw/RGfAbQiRUdjN2TepBiccdRQ4HpNP1ECYjYOYzIOKlAWcT/6RB6DldYWjpX2yzfuzqf30xTmdDaPYYl2kLTzXn0TPzvkP3tQGP2/glPH2ryoyacJJqNKjAPG9kBsOlQcIFMPkeopyM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(10070799003)(376014)(7416014)(56012099006)(10067099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O0wgtchunXac8Yjh4nwaqBUZzec6H+mLTIti6KiwbxAR5Me1kxIPxSjzWvkM?=
 =?us-ascii?Q?fIFduHjUmZiiZ6x05zkE6YusGDarukhiJpMT6kMgrO3a+zx7t1jJ+Rk/5c+z?=
 =?us-ascii?Q?0TYAW3l9KSTnn/jNc1HSX1J3y3DQJdejV2YUWXoL+zSNxQM0sRLgnd9/AwL/?=
 =?us-ascii?Q?kWWNWTNY8VmEQ9ieB9I1BjmO70hev7F6ePbX/lSycVVqf1BB1KQbQSR/LGpe?=
 =?us-ascii?Q?Iv344ejxsS+aFXVoVloDnqwRsnpxCRuM4+aJVIaH8mr2M36GjY72ZLuLNwjf?=
 =?us-ascii?Q?NE3hovvMVVvdz9vzRRwRdmOttzB6ZXnaWS5TbbqNaz/bTC7eS9v1PNYCzXj3?=
 =?us-ascii?Q?UVdoqEkWuN5npX8p+GKmflnjReuNzzPtRa71VnCYKd2D6TdQcQqsqH/fm1jI?=
 =?us-ascii?Q?fYivilHT4b+CCusZNU4aS0XuHp9mPUklLqYSereOtRAULO5Ea7VstLpMC7Y1?=
 =?us-ascii?Q?N0C3+nQsfzIKDOTbuLyz2A1eWWyueAwmZ5uTztn+LRtUOKLlk4dgEtQ9XWKs?=
 =?us-ascii?Q?xXy64qXre7t7vDRAJYYfSBHFdfrBZ5NQ9E9i1471gWLJx5cnkOgHPyUfk8Q7?=
 =?us-ascii?Q?CDxyTukCC5fUhCAIQ30ryh+UT1d2mAAKxcVZAiMROlNXWr4eH54TmrWdyLq2?=
 =?us-ascii?Q?YU0bmWZqGSF9VmfjGWG3YTmF1eC2JSktim0IbP8yp43++enCTxPJ2lLji6/b?=
 =?us-ascii?Q?BmgMalP6w9XQKbrgjRAMmxhCKo98MrUhBezdKbFYLdSNjEf5zzpudqwWTSyv?=
 =?us-ascii?Q?sB0wEpPmr5LYTFR7JClOTpT+HyC3Bn7bveR1VtEtLAHfVlqNTDWUeJRmD9/1?=
 =?us-ascii?Q?nj9iGIas8U9Svv+PKsgkgnRE8QNBtF1Zpzr+rIRfYXhwhbCQyx0LNWJV0sj1?=
 =?us-ascii?Q?qZtaVKZLkuQTkYlQm3rE/1n1A2KBorbl0CaPwurY4qsSW6yRRwM1bmX0a1M3?=
 =?us-ascii?Q?+/rxgDnm1pt71jaRr42fp6cWKtLDC0Mkk0BS4INh94xfvMKwL4g/c8r2mRo5?=
 =?us-ascii?Q?JLMCggw+aYq/VleI6p7HH8aJNnR5rS0j2XFsvr8KJRea9F8Q55Wh39Zi8tlV?=
 =?us-ascii?Q?glPQ9dPPmE47xzzCgxTKRb/JKygM2e6f98N1jLZHMDT1VuD1432bTv4r5li+?=
 =?us-ascii?Q?T/M8qbQskTZMdZZdRxu9I4pbV9in5W4KuqVu251uCC1K/au6kfMnqJNqRUX0?=
 =?us-ascii?Q?Kbq+yHCXu8H0BHM2c20Kq+wi1DISEfZSsPqhG1C0vOfDvFWbEK1IRmr6ejoc?=
 =?us-ascii?Q?A5cFqk3mm/n/w+v8Q76DoQpiN2/jyivPCNzmaQw6wtmxFVPptNpZw7MYJgCI?=
 =?us-ascii?Q?Ph+XL4Fl4UeGFFXk11RepMOOGZKnw/iFHTQZcaaq4Laiv/yQqrcSVJOPojqS?=
 =?us-ascii?Q?lPUbYWfqu9YLqvcDwjZQyl3SaPDwifjJZcjda0Pgq1J9QYzn81dEWU5XFa+r?=
 =?us-ascii?Q?LkPHvqxnTYbJN8HxqTaOeyZEuNMK1WvTzr9GlrXmrq5YxjpEXUlqB4Ikflz/?=
 =?us-ascii?Q?FFOEqsMFWEfY/Z9jXKwqWXqH1RERO8gHPr9K1KHre3SvOFT/IWleNAtZ7z+/?=
 =?us-ascii?Q?6u3CyDn8QfEgynqqAbig7+ahJruknxxkvvkLJcQTDRp1pY6dZErn/SbpfxYp?=
 =?us-ascii?Q?xMpVECFv9w9eO8eANfShrsjnC0uhN2uSE7rWQsRHUMeuDak0kd5wJJ2SQaXJ?=
 =?us-ascii?Q?qMQC++1KUFLAFBK46yUz2KINP75ArOOeY1EB6kHIv1r0e5QV0UL0YYb9LuqA?=
 =?us-ascii?Q?j1yhXgiaYjfdRGdUxm8LQG6+2OA+b9ci9m00xLkam2jjubmwIhUk?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a27700d-570e-45df-d714-08df4c2afbb8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 02:06:00.6575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGXyi2f00xwgSbzKJQJvsgSKFexdYzzU4dEwq0T3gwMsW9lyvf/sokhBZvomuVRwLozUaUwlbeEeRCgVobutMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBP286MB5984

ntb_transport_setup_qp_mw() can fail while growing a QP's RX entry pool,
but the link worker ignores that error. The worker can consequently
publish a QP whose memory-window state is only partly initialized.

Abort on the first QP setup error and release the MWs through the
existing error path instead of publishing the transport link.

Fixes: a754a8fcaf38 ("NTB: allocate number transport entries depending on size of ring size")
Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - None.

 drivers/ntb/ntb_transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index be1ae3789da1..3293fc4b0009 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1149,7 +1149,9 @@ static void ntb_transport_link_work(struct work_struct *work)
 	}
 
 	for (i = 0; i < nt->qp_count; i++) {
-		ntb_transport_setup_qp_mw(nt, i);
+		rc = ntb_transport_setup_qp_mw(nt, i);
+		if (rc)
+			goto out1;
 		ntb_transport_setup_qp_peer_msi(nt, i);
 	}
 
-- 
2.54.0

