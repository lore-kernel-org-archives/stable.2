Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010051.outbound.protection.outlook.com [52.101.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B020137D135;
	Mon, 13 Jul 2026 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949665; cv=fail; b=LRD9/9zAjrlPNpxzPUgEzdIWCFtuuQojK1QqmW6DC2TeXCdDqyWrKoxpHNDR0dEpx6vXrEF/OWAoiL4habQOiXa84DpKrJyzu3NSoICxL+T7qdixUkjSRNTa6RwtAsPXiCsiQoA7QtUU8RJNASly0+p0ke5Z38jvU2WDytSSCyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949665; c=relaxed/simple;
	bh=X+39UdEMPmsL86kqreyooI/czr3VLTySJmPtRdK5jwA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WIkQJyfYFCNUV0ZlDe2b36AMY2ep7Z3a+kMF5g+njUmHp0Foh3hChu1HY8j5/VZMlorUv8C/fWveLYgsf4bEItZhym+9rxQtzRy4lMas3hVdVaVpxD9qrKsoKfdWWCFVrDyY7vyFcDvf3glnvKmtR13r4d3dKbYXbjL3V3v8TQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=vcwn+9Wc; arc=fail smtp.client-ip=52.101.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="vcwn+9Wc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1nhnttm0hdkyg24eewGSmOchc6c5RJeOuxOryfYToOp/W7i6S/smP+VtoxHGyc8XbNFPPsYlPW8W3I0+Z3xRBTlmIKB8xc1m9/VyaQ5bT/KHk4btW5biQDE95TVMsgqT0Hm2WMx/eW7s91QJ8iaWkQbBjTen/XRvRk3jqjVpwa7m1d2mpAw8gaEPf+QST5u1SRd1lsKvaidHD/ZLuCUXrpY5yt9ds4bfHTBSF7BQPox1zk0971LmZBlXL19wtPkau4tGcxsjcitnLu1btsq5WZJYo5ecfL5Ozf4IGYRpocqlUiqSnj2+mSlexiC+Sa9ISc6ksjhqtipypaVXkWW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6JSkRs2Y4Wc55B6z124ksWO1rAN7blzUQv3RfgULyk=;
 b=CLoEFY5dn/O8o8nX6Bn7L6ELNOdK4KaPGL5xqzbPxeUpcjyqhMefoxqyH7hUBbeew7x0zhdzOrDGWPp3pTfkCYdTRMCa+RPb4S6koLBjxIncciGe6U/tLC3IlqAzs22gfWb//QbQNNqeCheq86/pfWDShBV4uGtfveCj2CVB+0u+OaaSy5sL3op0u4lQWXzUP3c/XPMdL+Lz+k5V234lpgCLJYlrCGwNVrmoexnyZOsD5p4st7LX2Xi47BTYAoXU4EGO+eAW7jGLZMDpXl3KzFPpVT0lM6TpAS5OhIw/o27g3TAaLMZd1PrOcT2W+t7P2cDhY1yhegCa8FOnpzdCgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6JSkRs2Y4Wc55B6z124ksWO1rAN7blzUQv3RfgULyk=;
 b=vcwn+9WcIajhyDxJyuk2LIaBlLEuFBDpYQ/Y+GbPmjlWTJCtfbpMC331ILQ7X+NKj2vKSDPQt/fANcd9YKwuElSdxzvkrZpppViBZugJDQ8z+bS+oqKHPAdqDnSDuyOYjySGvjPhEmtP4XnJBgBV143uH9CQmc8UiIKFYKfNX5r2LmdX09ONKH2FrZOMBgZqte0Akjz9c1O8jIsmvInYcNMN39hdZ334dXktXxUoom8b02ad88AFTCEZrqTUMh7WiCF7I+qcaH6kqKecUgLSXyHs+Teb+8lYVJzBTU/osHobdeWkfUXccWAn/kse3h1PdKYbWJpXvEM97QjYfRX/LA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AS8P189MB2510.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:635::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.16; Mon, 13 Jul 2026 13:34:20 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0223.008; Mon, 13 Jul 2026
 13:34:20 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Ibrahim Hashimov <security@auditcode.ai>
CC: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH net] tipc: cap number of nodes per net namespace
Thread-Topic: [PATCH net] tipc: cap number of nodes per net namespace
Thread-Index: AQHdEH7vOeMZZOLUIkGeczXfiK58CrZrdiiQ
Date: Mon, 13 Jul 2026 13:34:19 +0000
Message-ID:
 <GV1P189MB19881AB5829FF8B0B00EF158C6FA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260710150324.32134-1-security@auditcode.ai>
In-Reply-To: <20260710150324.32134-1-security@auditcode.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AS8P189MB2510:EE_
x-ms-office365-filtering-correlation-id: 5925372b-1806-4f7a-31f4-08dee0e37162
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|11063799006|5023799004|38070700021|6133799003|56012099006;
x-microsoft-antispam-message-info:
 pG/u0mhQvpXcbDgRiyZ0lT5+2z1INDMvL/nsHz59mMY6wHGiwe8v2RiqsO8S1ShawkN5lxUnUxEgsXUYPVEir6u/1pM3zO4lPbjflNQEjeYOTS2KHS9aO6V4ySM0r1vuqtABL8cqbMH2xf1e4WFRjWMhLOcYSFilRvrLGisRmqHW8zo+RKD6GnDi2h7s9SR7rTzaA3zFvbpHmpAwCD/Xx/KNNGPkQGTpPs+R9UAG0pIXzLLwLKmAJuTlPHAbBXNspi98W3imYn6xDxVo6wSGTl8SWINDsdzUJ/LHNr9s2Li67krlRafwCWfwRUjDgroqLgtyUfjfHQRObG9wcWfZBsysTNze3Q+ikbvgbzh8SiNZjeGQpu9D0AicQD1xEQcs75q2fmuwwsaJLTXTtZkCjjyv5InUhMDigwg2gTbs+ScyLbnQLwl+hUb2ZKNUpr7RPZTDDavzu/AaNwDyzaus2EhpxmrLbz1XbCjmjKt72ozd2dThO+t3k0yMebKYZ6qxsE/kUGz4OMB6DHBL4DRbAo9QIy0u+ldbmvJ4Lx9kbgiR5kTs5lrRPwaXRsO3vx9EhNkxHWo1zqYGXuavwW4EN/VygWrwlkcLhj8Ls6WRVY6l5Cnz7mU8XOSnT4xwXtKX5f/ZgBPe5NwbsPDGEfdIBVB0CfZxuIyuv9HQUvHCWgzcohaQSC+F1SOvfIomnTqFLImPLmzpseKztUM0PuJXpN1TTSFlmY4Nt+LCtl4v6PI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(5023799004)(38070700021)(6133799003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QDvweVpdeYXFhxxelBakhfw2OKNjPizFRQe0WnR0sw0r1kJmNrY5I+NsY5Bv?=
 =?us-ascii?Q?/LsgT5GUt+E/e29iVgDz2wd6l0uXne54CUNUn0aAE4fYiuXjcTXiy0P/sp9D?=
 =?us-ascii?Q?OCXhzdYZ+Uw5FelOcarH+PV7Cva+ikLymikepAdKYCmszvC4+I7P6D7T8xzw?=
 =?us-ascii?Q?b1uwV5s4898yGvrIFztQ2h+2n699+BXKuTrkWDEU0UqPmQSp7QMnLYonyoUW?=
 =?us-ascii?Q?/vjukgyI3rdHKOD/SvLhvhPMH3Qm290i1W0KBvWguhgvRP9Kr+c8VkV+L8W0?=
 =?us-ascii?Q?NkhWVbSN/b834JtY2dpQTxF/YDdkojWZofREXHoLNqmjzc6V+u02rsDG8m+a?=
 =?us-ascii?Q?I4XY1eXvkwbkvPs6Acyly11VqYyQ3H99B83nWElzflBWpOs8pQeU5Ku+jj7E?=
 =?us-ascii?Q?ztkoeWltqkC2+FhnhPyK69CfNVT4XmcnDAScRku4pSeXDlvrnMhjitq4YzDx?=
 =?us-ascii?Q?ZZ8dExJP9XFEg0FZ+khQ1x2gPWRaSHBah6oc0nsp0490HRZ7A2h+gvLX1qG9?=
 =?us-ascii?Q?Bn9dYC93cTKwQ9b55dKHMwJv26ZEekWox0b3cmc+ijsiGBNcvRj1jbVBB71t?=
 =?us-ascii?Q?rFsXlxrfisOaRz+EdVXxOF84881xaabVhnc8veoRsKR2XsR8rEaqgxPXfKFj?=
 =?us-ascii?Q?DQOZ/7hK/tTLBajwph186rn0u4bzv6qR8amaMCNthu2E/hZ5KyS3MXJjP1hg?=
 =?us-ascii?Q?ToOmCUZnie5DlAJJJcv+F7XblfhXFEMZeF7OPXDHsfvfYDGdkdRBFYnISnH+?=
 =?us-ascii?Q?LaIroeYMKOrIRGRWWBgD1Jv+FRMgQF2ZZt2j0tgcOEmiibeMdLOnevvZ6XE4?=
 =?us-ascii?Q?E6i38hw6M1gRuRkFkcULI5XX1ffp/0/fi+LEuK9+ht+T7albq2mH0/uNXTdH?=
 =?us-ascii?Q?BgKSaI+jy6ZTcbPCoZhdPFdgdihBBJovzQWChdAahbNA9YJMAAP9r8voy3x0?=
 =?us-ascii?Q?Ums65+b3XMUsWlO7sF2WFzPyS1BiESr4oLjzydAlE4QFUinU/4u+6QaKpeor?=
 =?us-ascii?Q?eJZOA5BtTBqwAraEH+Dhb4N4MPVym4+ognSVIJjWxBXT6pxW1HwXHTuY2N2J?=
 =?us-ascii?Q?Vi/kVUK+GlJ7KlyWJhUCAuaZfQ/vDBJNVTM2wontXdvvjKcNrw5usEkxxjqB?=
 =?us-ascii?Q?4dKonFkhVB8fxqiH0j79XlE7mqbuzWN5ksPlZU/5WGGOknuN/dg3I8OXye5E?=
 =?us-ascii?Q?QZF2TxiMJiKNjQGYaRHYd1hNQM+jInmZ/siKeOrUBJCcXpDWE3Cm9VDNnMlP?=
 =?us-ascii?Q?gbe4uBvbBrejxtnNB78FXtBQ7m4NxzsL1WouZw7fCgDliNznybn1nQYNs93Z?=
 =?us-ascii?Q?LFdL+0as0FB9M0lMSiEF+XNrsb00j/UJkK6a1lIg72YI6hseA2L4ci6E9rcF?=
 =?us-ascii?Q?EqtD3vof0yoohhLIrQHrasxG/uoIXH2WClMNDTRjUg7mSVcwtlQjHaMAPOOs?=
 =?us-ascii?Q?JjzzwNc79EkOn0629jScF+a8ner8Vo1MH96kAtKluj7lq6PyVZlvHStGK+Pk?=
 =?us-ascii?Q?xekKTK6/fsL/C8/PcQEeklOBMndxBlRqK6R9Qtj+Y8QogwyB5ODD6D+sD62+?=
 =?us-ascii?Q?OfnSnKskmrksg11k1F51P4hog7bppIWcYrCpJ/qsmzrozlkom9Y/sFe5yijT?=
 =?us-ascii?Q?A6kuPI96IB0ut0z4d/7qo0m+opI52+i0sUcqes93Ck/aLM4M3VSULYe76fIn?=
 =?us-ascii?Q?lY4oLl7CCT6SO/OXIicYfVLXJxuRll3wq5PoOoihjZvaVOFUGqebbCrmRfWD?=
 =?us-ascii?Q?mU76otdqYw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5925372b-1806-4f7a-31f4-08dee0e37162
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 13:34:19.7404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 59oTjO48a5pTCvb+hVBYn1kUPaNfnU+M7kPFH9UfvoRe0LAH5KJn+d+Qry04ASnMlHe763I/a4kgGRH286MliZ+qRuhAJJZON9xip0Ra4sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2510

>Subject: [PATCH net] tipc: cap number of nodes per net namespace
>
>tipc_node_create() allocates a new struct tipc_node (plus a broadcast rece=
ive
>link, a unicast link slot and a keepalive timer) for every previously unse=
en
>(addr, node_id) pair carried in an inbound TIPC LINK_CONFIG discovery fram=
e:
>
>	n =3D tipc_node_find(net, addr) ?:
>		tipc_node_find_by_id(net, peer_id);
>	if (n) {
>		...
>	}
>	n =3D kzalloc_obj(*n, GFP_ATOMIC);
>	...
>	n->delete_at =3D jiffies + msecs_to_jiffies(NODE_CLEANUP_AFTER);
>
>Both addr (msg_prevnode) and peer_id (msg_node_id) come straight out of
>the discovery frame and are fully attacker controlled, and the dedup key a=
bove
>is keyed on exactly those two values. There is no cap on how many distinct
>nodes a net namespace may hold and no rate limit on the create path, so an
>unauthenticated peer on an enabled TIPC bearer (L2 or UDP) can flood
>LINK_CONFIG frames with a fresh (addr,
>node_id) in each one and force the kernel to keep minting new, distinct st=
ruct
>tipc_node objects without bound. A link-less spoofed node is only reclaime=
d
>after NODE_CLEANUP_AFTER (300 s), so at typical discovery rates the live n=
ode
>table, and the memory pinned by it, grows roughly linearly with attacker-
>supplied identities for the duration of the flood. This is (uncontrolled r=
esource
>consumption), reachable by any unauthenticated network-adjacent host once
>tipc.ko is loaded and a bearer is enabled.
>
>Bound this the same way net/core/neighbour.c bounds the ARP/ND neighbour
>table against unauthenticated on-link input: reject new entries once a har=
d
>ceiling is hit instead of letting the table grow without limit. struct tip=
c_net
>already carries a num_nodes counter that is declared but never read or
>written anywhere in net/tipc/; wire it up on the create and delete paths a=
nd
>add a single bounds check on it in tipc_node_create(), guarded by the same=
 tn-
>>node_list_lock spinlock that already serializes every call site of
>tipc_node_create(), tipc_node_delete_from_list(), tipc_node_delete() and
>tipc_node_stop(). No new locking, no new data structures, and no change to
>the node table's data layout or lookup semantics; legitimate peers are sti=
ll
>admitted exactly as before, up to the cap.
>
>TIPC_MAX_NODES is set to 8192, well above any realistic TIPC cluster size,
>bounding worst-case pinned memory to a fixed multiple of one node's
>footprint instead of unbounded growth. It is intentionally not tuned tight=
;
>exposing it as a sysctl (mirroring
>net.ipv4.neigh.default.gc_thresh3) would be a reasonable follow-up but is =
left
>out to keep this fix minimal.

I do not see any issue with current code that requires this patch.

>
>Verified on a v6.19 KASAN build: flooding spoofed (addr, node_id) peers pa=
st
>the cap makes the patched kernel log "Too many TIPC nodes (8192)" and drop
>further peers, where the same flood grew the live node table without bound
>before this patch.

Can you provide your C reproducer and the stack trace you observed (on late=
st net-tree) ?

>
>Cc: stable@vger.kernel.org
>Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
>Assisted-by: AuditCode-AI:2026.07
>---
> net/tipc/node.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
>
>diff --git a/net/tipc/node.c b/net/tipc/node.c index
>8e4ef2630ae4..bb41f3231ce1 100644
>--- a/net/tipc/node.c
>+++ b/net/tipc/node.c
>@@ -49,6 +49,16 @@
> #define INVALID_NODE_SIG	0x10000
> #define NODE_CLEANUP_AFTER	300000
>
>+/* Hard cap on the number of live struct tipc_node entries a single net
>+ * namespace will hold. Every entry (preliminary or not) also pins a
>+ * broadcast-receive link, a unicast link slot and a keepalive timer,
>+so
>+ * this bounds worst-case memory from unauthenticated LINK_CONFIG
>+discovery
>+ * traffic the same way neigh_alloc()'s gc_thresh3 bounds the ARP/ND
>+table
>+ * (see net/core/neighbour.c). 8192 is far above any realistic TIPC
>+cluster
>+ * size and is not meant to be tight -- it only stops unbounded growth.
>+ */
>+#define TIPC_MAX_NODES		8192
>+
> /* Flags used to take different actions according to flag type
>  * TIPC_NOTIFY_NODE_DOWN: notify node is down
>  * TIPC_NOTIFY_NODE_UP: notify node is up @@ -535,6 +545,11 @@ struct
>tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
>
> 		goto exit;
> 	}
>+	if (tn->num_nodes >=3D TIPC_MAX_NODES) {
>+		pr_warn_ratelimited("Too many TIPC nodes (%u), dropping
>new peer %x\n",
>+				    tn->num_nodes, addr);
>+		goto exit;
>+	}
> 	n =3D kzalloc_obj(*n, GFP_ATOMIC);
> 	if (!n) {
> 		pr_warn("Node creation failed, no memory\n"); @@ -598,6
>+613,7 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8
>*peer_id,
> 			break;
> 	}
> 	list_add_tail_rcu(&n->list, &temp_node->list);
>+	tn->num_nodes++;
> 	/* Calculate cluster capabilities */
> 	tn->capabilities =3D TIPC_NODE_CAPABILITIES;
> 	list_for_each_entry_rcu(temp_node, &tn->node_list, list) { @@ -630,6
>+646,7 @@ static void tipc_node_delete_from_list(struct tipc_node *node)
>#endif
> 	list_del_rcu(&node->list);
> 	hlist_del_rcu(&node->hash);
>+	tipc_net(node->net)->num_nodes--;
> 	tipc_node_put(node);
> }
>
>--
>2.50.1 (Apple Git-155)
>

