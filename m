Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110F42E5B02;
	Mon, 28 Sep 2026 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597859; cv=fail; b=Vr/RvxMsUSb7ofzb9CvluCIT05Xq2Nw97wIWSBmLWt+8iKxIKK7T8vF/is0PA23cZVo2k7r1XjQSdXsmd/XUwoS66jqsJskz+eMzT27wxFDf6Bl81n5VRX7/SkfDAgvN/rDXyYm3N1ytzuC1sHdaaIV9Dawbb7/VU0Xk4xD1wp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597859; c=relaxed/simple;
	bh=KyabG5EHhRavEHj+JDlqmto1fFX6Ak7CLPFXVLwlyxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=StxhVzdlyZ7GOz81+whN0jm8PQbMzJRcP8lsG+Eto1OjHynV+D1lslbobcPIDYIPqyITWfj4JdggSK1A6dC0UHJsRnDQqpL4UzIp3JqtIvremDO0WPtqEgIhqa4m+JNcVQimiLmfJ1nlhAyScp2QqBcYRqWo7vLJ5nKSRWakKCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=DRKnf8md; arc=fail smtp.client-ip=52.101.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="DRKnf8md"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKDXG4MqLhFAXGyZmehWV9x7TvZovdeetb0yJlTkUFZe4kyKrDvCBlijGUATWENkOXFmGUisZbRnB2nOmvrIlR+dIU6EKfk5mcgI1Wx+3Na5Zhwtbxg2iBe76bfK2lkJeN51VomuFuaFkoDn4Unf12XSjY3cotm15wZbVu43KBNG0IHWaKifH1NuqS9cp1Bp4hnhJDOVCcdKTbjzuKktlA22CB5q/M1c6EhlrbfZ0lpRC98orFaldKwKvtDf/qWn5QBdOKlfrlKFphxKo17PPyfPPPtFKNpy0Mjn4jYXI2xrqVEzNuBMNhCpO46yfahrRE0g7EvuTl/EmPkx7GV9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xH19pHgM5Yvtdo+eppPih1thQyJO59GLburaN4UbgM=;
 b=Qn16JYiHgB5yY76pbtCasV2YeTRqzHkfK3K8TxIDpJeqWbLgRCSgdZiKy/BxKb3asb57g9uRE2FDYACrvkYpgFGNBbuU1nYJWPHGkNOhvBQ47kYACU/Vzz+Bmt00+7KjqmwHico37cqo+DtwKrlNehDTZKFJlav2tQDb51bzyo5kyplkMw3RIdZAGPSH4iYkkT52p3t9h3wRfjaw6vbPH3/eEqro8u2YMXxN/tjVKbKXHPEHiSVd0hXUC/crBRleaWW8aTmbmRJY0kCPuVvA9FNpZ01gHM0zjM6VR9PIcQmF2qS/Jd1GqYUzip1KOutxr0pdkr3BOKuypIfggpgTUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xH19pHgM5Yvtdo+eppPih1thQyJO59GLburaN4UbgM=;
 b=DRKnf8mdtkXz/anPjn7QdRZeHLZEj2dic6dLPMDMQXOB49HH9y26gPdDyvh2m+iBSFycSd/rFF/F/xupaohsq3jF+I3e7cUb4WAdYYjidA9ihTTskO7fJQku7lt2hX4RDRRpeJo0GahGXRKDIfxZe38Cs6N8Gqf6IxHkCdWvnfF1XF1URFnLTmoGjWok8nnEWQFaXcDg1oABiEwrLhlQGhzSUeNox6tyLkzKnURhd0fS5o74CyUj2hYxgwJik+EuNQcecCq9k5b57qDFpn8zHB++IUqNsXvawZo7SbDSMw51DVD83b0StqnEPxBiLOEftndCmYWYDXjDTt6zMYl7dQ==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by DBBP189MB1162.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 12:17:34 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 12:17:34 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Subject: RE: [PATCH net] tipc: hold a reference to nodes found by link name
Thread-Topic: [PATCH net] tipc: hold a reference to nodes found by link name
Thread-Index: AQHdTkshzvPhSDtkhUupGiAOFkqNBbbj55Ag
Date: Mon, 28 Sep 2026 12:17:34 +0000
Message-ID:
 <DU4P189MB3750B9BEFE0E00F5D4A4D548C68D2@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20260927064036.3691962-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260927064036.3691962-1-nicoyip.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|DBBP189MB1162:EE_
x-ms-office365-filtering-correlation-id: 441efda5-a77a-4aca-0d41-08df1d5a7a6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|6133799003|22082099003|18002099003|38070700021|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info:
 pkUHfmSLN4k66DFD/NY+iVihffXlfMNnVPyXARacQ+G2cPKOuHJRqoYcQAGCW5QPaUFeU/2V4Vup9XIIpBAftRSONaKZVNZuMFulUHcVycqBm2i1hqhSTu8DtOzwFgnMhdfWMnaXgPdzdYg85Reuhtm1A5va52KgLwlxNdhCj39JG1I4sAd0otoAZXHLB5+FwILaojj3lesBNNjOONavedFQm6+aFwtt4I46hTzhYng0zKXBzc1KhDeZk8re37aq2HNLnPlocO/IiKjIAccq3lTW6MdT9ARy4bHmwLUxqIT0cicfFS4MpFv+eUAAoJI5uUN/6I3QsobO1sKAEDhPmB2mIEu0lWRxZ+mut+cJtbKQy3KzmuN7SPmulH8g22t6AaY1RoPoqU+78Qvm+xrKXjS49b9zHR2MV8cd4M0nsz76ORZKuX2obc78GmFmbH+9b3c6qmgnFgQ6zYJlSWcm/jTbZ7aiYwo8XUSVuQmbG7hgZS3JySHTUlFOYvaXR9i211dMG0ZtGBH4BMlXv7Je1yrxeZGtZALJwHqmRdQGjTYpaLNMgd1gYOZGoj4sydfmueDMO0gUnn1ie2PfVzH0fcj5uRAHcnaKIjW4pAsX9jG34azMM41c+DSLABCmP8FYJDnHoU/jYtSDKQu3ToUs5VhXWjA0pPWE0/5HFDYEfxteNjjcR/qK0wFMxAvT9CIkoUh02jy6nER3gy4b4lpDJ6PnszkUt5KZ8kkfGoKkKdo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nyJFza/UL3RBGV4WueAzEwDnWxDmsTpy5XTKCVRfT6ZquRZZkfQVeJcDtdUK?=
 =?us-ascii?Q?+D/62Rggt2AqVfNdPRIDD0Bekf6VT1yEroDGwkar2hzD9kr6sXkRGNEkHDt5?=
 =?us-ascii?Q?schakYQgNZh78D+4Rzxio7TAlPMSSAP8IKIWFROlyWl5AZoQY84xulg6RnlN?=
 =?us-ascii?Q?Z3GGWeg/9waGxFAaHvRhCr4bgVG5V9MQGNmrLKQpfHpMwzd7wgth9on1ng9M?=
 =?us-ascii?Q?/0PABbeaBrOPSYrFb8vHc6t1RK0Qt3IeuBJIPHBGnFTkxUtTmvUt4O1MV/id?=
 =?us-ascii?Q?wUGpjpxMSEBF4nyuY0NcgEWvZcxc+815ltix1nAAuukoKEVCktIdBSJGjdOm?=
 =?us-ascii?Q?rkJ0zofGbBypBvAFJlklRtj/AQKOncNHSCPAz+/+oQL1Z4S2wlWnGaHvGNbt?=
 =?us-ascii?Q?otxOiyFzTRzglZhAsiiwUG3V6E2B2Sn3/FRz8KjirLcbI7ZqfmOGUZRHNvli?=
 =?us-ascii?Q?g29IIIY1OvHC/ZFDSjNJxPYeiwDO2QtXG8yd+mwtm9bW3kbV56RCPWh6jOmH?=
 =?us-ascii?Q?es4voUhsgBm4Bh1Jx9MZfTG2fUne/KoxUMN55rPith1NzfQAT6WzfFB3dfag?=
 =?us-ascii?Q?t0GPoTeNSFu7d8FUyvgYX/NquX1So+oJrA4rNAbIfnzIbCEH6OtVdknmV0Yq?=
 =?us-ascii?Q?kRYAF/j2IodYkOPNBRJ+S7z8D18NObHqtZI/K7Kc9w2yiI2MaelWdLi06tPw?=
 =?us-ascii?Q?guLIKh6nPLKWsjuwowyFvDzVdiGGmoYTYNcfXnUQg5jNHuDtCYVRBcsDx+rW?=
 =?us-ascii?Q?F5LEsrG1iLUVt1fk8anIExTT3nOyur57ajHP0XCuGFdZlLTDq06awHwLfDfW?=
 =?us-ascii?Q?4PJ/Gndi3aCvJy6n7goGbKnSWqVX8LUB5vpqQg3EupzUH4VMS1XZsln4Sadi?=
 =?us-ascii?Q?u/DdczGwavtEDW+rKmTAVEuq4luKMC1+1tEvQJItRBZIEEAbBEOC9lehU49n?=
 =?us-ascii?Q?PhqfOKDivBLVn0d4iJMUlmNyYFMLnk6e6EUhtrUNJJczTBwBifr+Ef1cwMdS?=
 =?us-ascii?Q?6TsmyCPz+c5c/L9Bu6XE77jK1pTdkPQrZt/2abKnAGDDjhMyOncIUVEunjSV?=
 =?us-ascii?Q?XWBy73XcqJknuAmN8R2hVGE4DII7Wc2bBqYCU712ue7sAVpkv2+VbTK+A492?=
 =?us-ascii?Q?Woq6kcjbB8GfkMmrBtlkvMnHLlaTFa3mgcACffZuknqK7IfZ1Lc5Y/2F7VlF?=
 =?us-ascii?Q?OXtQh9MJqVbF9MmxYCXoNqj1ED2OYqh4o1uA+tikGlCfZVj+tYavbv5ql6qE?=
 =?us-ascii?Q?0qPq1ApTBzOyOpDLGOwTl+EeUH5UQKRhuAO5c9nsmmwXtFfPhE4SEfbboIvS?=
 =?us-ascii?Q?TidxXU0SGPqjT2b7pTsAyxeIrMG5Qg/94Pcq4pO7qQvry+Eub4uc/3ARAsLo?=
 =?us-ascii?Q?5YmOx694Dm2l10X6cDNgF5t9GTshYN9SDrsUOW1WstL+OHDTUQYP5V6Qu6f1?=
 =?us-ascii?Q?v25RxpFbW5a/SFKLZeewLSlmYYLdIYVI38lmCI9LWyQY+t6qS4FnKaL4MzG6?=
 =?us-ascii?Q?bliZCTzQK9V/xoGpW//CYUlgEulZprhXk7f23fUtmC0ezLLZ6+dNyOs2pO7/?=
 =?us-ascii?Q?+SSlUcpdbEpgqTVGMzADAtn2N0NKA1i9WogVm384TfV3+Tz2eL9n/Ka9MLvQ?=
 =?us-ascii?Q?2FtCoy28P9GQKx3yWCcZT6znRsOsDLi3mhl6I2oS77e6oCnn4DVlWVggPya4?=
 =?us-ascii?Q?SkOpNqBikqVtsV4hpBuKhq5SZ2HcnNz17IRumxn3HWp+zHrxF4bzarXBELnW?=
 =?us-ascii?Q?hM8+aaK5yw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 441efda5-a77a-4aca-0d41-08df1d5a7a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 12:17:34.7995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcAXnVMTwFsK+ItXAUKZdMag4qpVTH347y4eD3dZw/kxfoEF1ssQzFmb375wf0eXJyhp7gxCGrMQPSdEd2ulze8eIa5pXhCEhpWpaVFStMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBP189MB1162

>Subject: [PATCH net] tipc: hold a reference to nodes found by link name
>
>tipc_node_find_by_name() returns a node after dropping its RCU read lock
>without taking a reference. The LINK_SET, LINK_GET and LINK_RESET_STATS
>handlers then lock and access the node, racing with timer-driven cleanup o=
f a
>down peer. Generic netlink serialization does not exclude the node timer.
>
>The following interleaving can leave a handler using a freed node:
>
>  CPU 0: find the node under RCU and release the node read lock
>  CPU 1: tipc_node_timeout() clears the links and unlinks the down node
>  CPU 1: drop the list and timer references, queuing tipc_node_free()
>  CPU 0: leave the RCU read-side critical section
>  CPU 1: complete the grace period and free the node
>  CPU 0: acquire the node lock through the stale pointer
>
>LINK_SET also uses the node's media address after releasing the node lock,
>when passing queued packets to tipc_bearer_xmit().
>
>KASAN reported:
>
>  BUG: KASAN: slab-use-after-free in _raw_read_lock_bh+0x1d/0x40
>  Write of size 4 at addr ffff888112723808 by task poc/87
>  Call Trace:
>   _raw_read_lock_bh+0x1d/0x40
>   tipc_nl_node_set_link+0x30e/0x680
>   genl_family_rcv_msg_doit+0x1e0/0x2c0
>   genl_rcv_msg+0x419/0x6d0
>   netlink_rcv_skb+0x11f/0x350
>  Allocated by task 28:
>   tipc_node_create+0x9c1/0x1fa0
>   tipc_node_check_dest+0x121/0x11e0
>   tipc_disc_rcv+0xdbf/0x1430
>  Freed by task 87:
>   kfree+0x149/0x330
>   rcu_core+0x50a/0x1850
>  Last potentially related work creation:
>   __call_rcu_common.constprop.0+0x71/0xa10
>   tipc_node_timeout+0xb1b/0xe70
>

Can you update your changelog with decoded stack trace ?
With decoded stack trace, It helps me understand how your reproducer trigge=
rs the issue.

>Acquire a reference to the selected node with kref_get_unless_zero() befor=
e
>leaving RCU, returning NULL if the node has already been released.
>Release that reference on every caller exit after the last node access, in=
cluding
>transmission in LINK_SET. Keep the existing link lookup order and locking =
so
>concurrent link removal still takes the existing error paths.
>
>Fixes: 6a939f365bdb ("tipc: Auto removal of peer down node instance")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
>---
> net/tipc/node.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/net/tipc/node.c b/net/tipc/node.c index
>bd91378b7540..2726bee3bb40 100644
>--- a/net/tipc/node.c
>+++ b/net/tipc/node.c
>@@ -2424,6 +2424,8 @@ static struct tipc_node
>*tipc_node_find_by_name(struct net *net,
> 		if (found_node)
> 			break;
> 	}
>+	if (found_node && !kref_get_unless_zero(&found_node->kref))
>+		found_node =3D NULL;

This checking is not optimal.
Try this:

diff --git a/net/tipc/node.c b/net/tipc/node.c
index bd91378b7540..3e61e9106dd7 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -2421,8 +2421,11 @@ static struct tipc_node *tipc_node_find_by_name(stru=
ct net *net,
                        }
                }
                tipc_node_read_unlock(n);
-               if (found_node)
+               if (found_node) {
+                       if (!kref_get_unless_zero(&found_node->kref))
+                               found_node =3D NULL;
                        break;
+               }
        }
        rcu_read_unlock();

> 	rcu_read_unlock();
>
> 	return found_node;
>@@ -2507,6 +2509,7 @@ int tipc_nl_node_set_link(struct sk_buff *skb, struc=
t
>genl_info *info)
> 	tipc_node_read_unlock(node);
> 	tipc_bearer_xmit(net, bearer_id, &xmitq, &node-
>>links[bearer_id].maddr,
> 			 NULL);
>+	tipc_node_put(node);
> 	return res;
> }
>
>@@ -2558,12 +2561,14 @@ int tipc_nl_node_get_link(struct sk_buff *skb,
>struct genl_info *info)
> 		link =3D node->links[bearer_id].link;
> 		if (!link) {
> 			tipc_node_read_unlock(node);
>+			tipc_node_put(node);
> 			err =3D -EINVAL;
> 			goto err_free;
> 		}
>
> 		err =3D __tipc_nl_add_link(net, &msg, link, 0);
> 		tipc_node_read_unlock(node);
>+		tipc_node_put(node);
> 		if (err)
> 			goto err_free;
> 	}
>@@ -2634,11 +2639,13 @@ int tipc_nl_node_reset_link_stats(struct sk_buff
>*skb, struct genl_info *info)
> 	if (!link) {
> 		spin_unlock_bh(&le->lock);
> 		tipc_node_read_unlock(node);
>+		tipc_node_put(node);
> 		return -EINVAL;
> 	}
> 	tipc_link_reset_stats(link);
> 	spin_unlock_bh(&le->lock);
> 	tipc_node_read_unlock(node);
>+	tipc_node_put(node);
> 	return 0;
> }
>
>--
>2.43.0

