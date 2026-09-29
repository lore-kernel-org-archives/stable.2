Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F066511196;
	Tue, 29 Sep 2026 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790680070; cv=fail; b=V700PR4ZRR8YId1tKpm7meUYZOta3MMb5Upwe6W46IxBc7ySSJFA9i3254dEvLSHfukOmd5pRd2AQ6yJW99SCTF6XDhe+Orw37qv5XcFH5SwsvB+lvmI78UMa8+/s7YBxOVUON7EYGNvGX9eEEw60MPReKORpw02+X+KRHr1G7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790680070; c=relaxed/simple;
	bh=yBNj51Fczefw3zf5TiGMiEfBPAuipC33h2fgrVwU4rU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GEAyJg6XqBYMwUJ1yV7yR8PQzYWKRsYADFZ/MbBae3vWpito5+oeLdmFa+lLVZQIz4MiSpLv315IpdLv2ewmvB78qn22+zwGZCqtLOUOniebi0cma6bAv/ESS6F+2kCS3DEkPJx9xzt73Yes5Ke/XyxGvKpO0d1URa8MSLDz7hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=yhjBP9L/; arc=fail smtp.client-ip=52.101.65.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="yhjBP9L/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiMyKwQzwnxv+3o9tt9Mk0hflk60IjncjsgnvXy2EnDxaK3wPHuTWp/89TJJDzLUWkAoL/hCKuXuq4NhKWc4167rgtNFrJ4iNz7J/JICSKfFOy2pDMQI8AO0HE6o4cExQY5hSaGJ+GsCMpJs2sMMl/67cCgcvQQZggvJFj0JNA9GCxQHvLH1VtXZXsAolRRS9Ne6hb8+9MTZlivp/0eJBYDjNKhx6V3QlPz8QgubDEwQ64zVt8UWltQsvvnwU2nfqpgrjRkiTsZ4WlW8vDZrVlVR+6iuUVP73HiU4Ih8b4KWabXt5lO3UYMmi6CjWuu4TaHZNQka695sje4Dbg8UMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kS+NhYpHiqrkTUi9ljLzzmDqss2MLQguKup2tWJoUY=;
 b=SuA7iBeCXtfb5JiUHGFn4+C5MxaX8c9S41MiBQlvlBwTBw2xt0I2e/Amnk4Rq1sQfk8xf36XC6CUAeA6GSqGLwXU0AK7ouyVW7z/0SDZOmuiZVPHYp+QEyz6XRNqIqXkgK5N33CTTY9GDerxJjtKizPBwQDcvgnIOz9hvRy/Pz9T37of9F7xcqbFQBNgZlF+2G/AeHk3TzTiVIqnN85stuLqdTcjoSw2307U0gw++znMBGjlxtzHTTYq7Wod7+RESa+HE1B5g6KbAlUmFAbsBhK1yWIa4mARusOoZ1DLkprsLWgYOHfgurK48M7TRJ72GHTIXUq8jMlQ43J8ipgrwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kS+NhYpHiqrkTUi9ljLzzmDqss2MLQguKup2tWJoUY=;
 b=yhjBP9L/QDzmON7GZhP2W5TWEnd+3t0Rf/rn+N2BlUFMzdl7YrPG7pF+wMumTonpz5HvG3cJA41xsFg3TsK6IUO/vI6NqTCs/xcZn5y0WKo5sb2WPalv8kLX1r49DV/jGFGskKByixOqNT+p7E7B6Fi1XVODdJ2fqFlFXhbk+0mV7y+FAGraWU9F+qSrbEKADLGy28iGfDNqYRJrqGOeMvBzEcqKokX8t7zZXRRYkEKD5MtxbXztomq2Y9TkHfMPArQ2x2j0oUxv45t7AfecmTANtJ8kW1ZA0Z+kfxMCE6JdDvzXjIZ9YiwnNGDzQ9uBN/rrLaNgMld3ddFP8iE9Og==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by DB5P189MB2552.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:4aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 11:07:44 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 11:07:44 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Jun Yang <juny24602@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@kernel.org"
	<edumazet@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>, Jun Yang <junvyyang@tencent.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, TencentOS Corvus AI
	<corvus@tencent.com>
Subject: RE: [PATCH net v2] tipc: reject name table updates with invalid
 origin node
Thread-Topic: [PATCH net v2] tipc: reject name table updates with invalid
 origin node
Thread-Index: AQHdTu+tMno0ctwlhkWgOedhKqzCq7blZt7Q
Date: Tue, 29 Sep 2026 11:07:43 +0000
Message-ID:
 <DU4P189MB375068F2321EB0762FD88906C68C2@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20260928021807.7945-1-juny24602@gmail.com>
In-Reply-To: <20260928021807.7945-1-juny24602@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|DB5P189MB2552:EE_
x-ms-office365-filtering-correlation-id: 7795ac59-f7e8-4de0-96b3-08df1e19e2f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|4022899009|1800799024|7416014|376014|22082099003|18002099003|38070700021|3023799007|6133799003|260925021311599003|260925022911599003|260925021911599003|10067099003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 nx6EaBUnHPwUPMTJqR8ke7BJLt5QPxI0OB4hEpzehTD78RNnM4VMo0EMjC+SxcOf/rJ2hhqb9og35OS8WccmoR/5cUDrScNECVr00HQtpHnnTpWlrpilzSmyj8lxQ+jy3TeHUQ85jpt/pie/HvpG66lt1SMzogFXhZLHzXDwn14tC2uvAUApU1HS04tosQWGDBNTeyPz6exNr+v+M/qyNbN30WrsCcNtBxr5qB+lHeW2cKFOVVa8GnVgJBU7yo7wJYfQk3ARcEn5YS1Op/CkkdqOboFczQmtc0Nudo08C1ic7tJepgVUewMqrmX9laVRIj51ooqeGZGwSkRVTn6vVpYXW75nVv6jfZcaYB5UF+BVKSWMutYNFlDZDt5oPBdg4yAf47RLvKy+fOsGwO/ZC0Dx/Jhd9fbcaeXEtjVEWLB8iVEsB/Lajs0Ms4NRidDL7gV0ZVetsBj7meQ3bsXByNseNawR+lUC9Iym5WzocrrJpuSKWmgmk/nqN+SlkimLulNP4MLSTKH61KJQ1V/woWJ7I8WC6YVmJPstSjKABOHlY/+w3C+GXM8FhM4ikjpmOrhZX7nJ1zgC5coJuGWvQxRtyVRdXfzgbW9bUvBdriKsFoNVGxyQJdUwrQuhpxSQofOsH2zdOsJKqa2M1MNzG78rtFtfa/EkpR0cNUSwpL8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(4022899009)(1800799024)(7416014)(376014)(22082099003)(18002099003)(38070700021)(3023799007)(6133799003)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?s28woIiHKc4Htpq0Fq4ZOUk2HO9/dfIU5/YliSmrS4MYMPM6WwPKXLQ2wIq4?=
 =?us-ascii?Q?dd1yMG3SarSeUUbr+TSnfYsq4cg6plp0u1tER6Zxoou///YA0sVoRMKFBZbN?=
 =?us-ascii?Q?pHkfkWRKhneoK7qqTn3cvazfYDMZeanSImbowubuQ4y9yDJ2+EwfJQshM+H8?=
 =?us-ascii?Q?DmBKgalMfDxIk0hVJL9DCT0gpK+BxFBa18ypubblM++l7UP9zOtDZ77N7oUL?=
 =?us-ascii?Q?LvmpWOpYTEr6ltq8/0M/CAT7mpQMTFre4Sx2IUNkKbJBVBhjPSbUpWq6zF+N?=
 =?us-ascii?Q?XSqGVRVjSdjr2nKZi1+MQSYcihvyoi/7eYgH3ou/svklk4dITV5BdYgyarFV?=
 =?us-ascii?Q?RGsXFKkoxs2pmXwVLNptkUjve0xJN1b09t0Izr5RLGIXWaZtuEBwqH3W2xdJ?=
 =?us-ascii?Q?RdFu2sKVHcvkLOdFllgBb0ZnP+ADUPDULYKPc8+EXIS2lrH9grSnqbTVKu/Z?=
 =?us-ascii?Q?0gftfgw+Y6+3lT5s4ALnIZNEaxE1HQuai2TUg+4Z9qH/cDl7oWC4xfZVZ/a8?=
 =?us-ascii?Q?821axjGXJjJtim8UEmR8jjDI4nEWwJJrwgiiVsPYm90Ce44IlYD+z1moNRuW?=
 =?us-ascii?Q?QcbJlewBk2gvwb0SR6ZecfDZ66q4rK4A76HAniICaRzhHRzfEJ6OS4Yy3mVr?=
 =?us-ascii?Q?djlIBzvCJAPD3WUt8AqDxIGOVoMCMRuVfp3HBfkfuAeLiBXx2irAVufxto1p?=
 =?us-ascii?Q?/JnFAB6Wj8Kt/dC6VMSlSuZF/kxg+/R79HZq/ENozviYiqXEpDSsjHwCh8UU?=
 =?us-ascii?Q?UdhEOy0LZqcmLU1OFqQxL5l5VbB3Va/zpvmCnZflGgGT5Q0cl5eyR2NY1my+?=
 =?us-ascii?Q?sojHN/JbjFo/EgA2jzSQKeCaKtZCJCXlxNdJwoWgw1XbTluc7wR0s3ouHFGu?=
 =?us-ascii?Q?K3VcxtYU5GJ+lYuZ+d7LIgXkNU9eiAemB1EcAMPqwlO29WAVxkFp+bAZWYJv?=
 =?us-ascii?Q?3aFR6Dl7s/ejADTgkOiRb0LEYpjcfvEdbBD6O2VVXHR7yPNwvDhOpehw3NcL?=
 =?us-ascii?Q?QJ6qBOO8VU/A8jRvRaD7ssjnjFuk8iZ/8l9kIP0XSgmai4XuTRZjUeOqNYK+?=
 =?us-ascii?Q?T+6G2nJyZFX3q9FFTAO9ot7lIYsrmL4tNz719RYscP6g5po2UL4E8P21IseN?=
 =?us-ascii?Q?UMhRnB9PnOB6w0FA2Le/K7oi+818konQreFS2yjcsMu7WVfzkkMSU4K0f1oO?=
 =?us-ascii?Q?kdipSGb9mtPI/tQ9LNP8APonC1m48IUsCPqHFlumw3k+jK5iM5X/AnJSRE/S?=
 =?us-ascii?Q?JOzIom9ZWqGAUsbu56Yy3Tk4749MfPctjYk96OISYOzRIuvAO9JbRS4egqm1?=
 =?us-ascii?Q?FPyg+GetJ21Suloa8P4enNZDB1Q3cCf0x7geR0Q7nmY/Mc90FLAsvB+3pqp6?=
 =?us-ascii?Q?eS339gJe4PxuxMduTbaUahBQMURNFaeasSasOZUCCfcXvCp9jMYQmTfEUxZw?=
 =?us-ascii?Q?Ha8us4JkuaRPE8Cx+labtOCExxfcR5EJ4KzYZmOCjwwM9GMzozz6OTvrl6RF?=
 =?us-ascii?Q?jzQ8n7z05hgVeuqwAegUg0DpRTlq98T9tpnLDLiR+rgZDUP22Xn17dsjOhbc?=
 =?us-ascii?Q?1Vc0gLbWz/BdcA5PBKV3e6Mwr1+n+YiffqYj7KW8trCc2tPxmtWzfhlmbZ20?=
 =?us-ascii?Q?itzGfmaopeqb+fiEMMyX7Xr25yP3M4Hyg2zcA0gOJOu4pOSUw2QFh2Z98lgL?=
 =?us-ascii?Q?ss7dQm2eL0rZTPlQL26JJpyrFoyWYhreRqSbMLOsPVziEn9S2XugIATsuhHi?=
 =?us-ascii?Q?w2T+OlM8HQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7795ac59-f7e8-4de0-96b3-08df1e19e2f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 11:07:43.9914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0m/0sw8zxa2gvqHvfmc3pwjjpe9xDF/wb4nf5ZkHu9ALTQaPcVavPFSYW5c8C7Z2w4tn8pOe39LfWmkTD+tONyGE8tS2BKbXlRVY36QKUPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5P189MB2552

>Subject: [PATCH net v2] tipc: reject name table updates with invalid origi=
n node
>
>From: Jun Yang <junvyyang@tencent.com>
>
>tipc_rcv() locates the sending peer using msg_prevnode(), while
>tipc_named_rcv() takes the node address for NAME_DISTRIBUTOR updates
>from msg_orignode(). These are separate fields in the message header, so
>finding a valid peer does not validate the origin node.
>
>For a WITHDRAWAL with origin node 0, tipc_nametbl_remove_publ() treats
>the node as a wildcard and can remove a matching peer publication from the
>name table. tipc_node_unsubscribe() then returns without unlinking
>binding_node because in_own_node() treats node 0 as local.
>tipc_update_nametbl() subsequently calls kfree_rcu(), leaving its binding_=
node
>linked on the peer's publ_list.
>
>Once the publication has been freed, withdrawing an adjacent publication
>from the same peer can access the stale list entry in list_del_init().
>The following KASAN report shows this access in the list validation code:
>
>  BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report
>  Read of size 8 at addr ffff8880249c7120 by task a.out/9456
>
>  CPU: 0 UID: 0 PID: 9456 Comm: a.out Not tainted
>  7.3.0-rc4-00385-ga7bfaba4823e #81 PREEMPT(full)
>
>  Call Trace:
>   <IRQ>
>   dump_stack_lvl lib/dump_stack.c:122
>   print_address_description mm/kasan/report.c:379 [inline]
>   print_report mm/kasan/report.c:482
>   kasan_report mm/kasan/report.c:597
>   __list_del_entry_valid_or_report lib/list_debug.c:62
>   __list_del_entry include/linux/list.h:261 [inline]
>   list_del_init include/linux/list.h:333 [inline]
>   tipc_node_unsubscribe net/tipc/node.c:687
>   tipc_update_nametbl net/tipc/name_distr.c:311 [inline]
>   tipc_named_rcv net/tipc/name_distr.c:389
>   tipc_rcv net/tipc/node.c:2202
>   tipc_udp_recv net/tipc/udp_media.c:390
>   udp_queue_rcv_one_skb net/ipv4/udp.c:2433
>   udp_queue_rcv_skb net/ipv4/udp.c:2472
>   udp_unicast_rcv_skb net/ipv4/udp.c:2625
>   udp_rcv net/ipv4/udp.c:2697
>
>Reject zero and own-node origin addresses at the start of
>tipc_update_nametbl(), before inserting or removing any publication.
>Neither value is a valid origin for a peer name-table update, and
>in_own_node() covers both cases.
>
>Fixes: 218527fe27ad ("tipc: replace name table service range array with rb
>tree")
>Cc: stable@vger.kernel.org
>Reported-by: TencentOS Corvus AI <corvus@tencent.com>
>Assisted-by: tencentos-corvus-ai:hy4-preview
>Signed-off-by: Jun Yang <junvyyang@tencent.com>
>---
>v2:
>- Explain the distinction between the sending peer and the origin node.
>- Correct the Fixes tag to the commit introducing the node-zero wildcard.
>- Link to v1: https://lore.kernel.org/netdev/20260731101657.29119-1-
>juny24602@gmail.com/
>- Review:
>https://lore.kernel.org/netdev/GV1P189MB19887144315DA4A6AF16FE02C6D5
>2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM/
>
> net/tipc/name_distr.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c index
>ba4f4906e13b..a496e2e9ef62 100644
>--- a/net/tipc/name_distr.c
>+++ b/net/tipc/name_distr.c
>@@ -286,6 +286,9 @@ static bool tipc_update_nametbl(struct net *net, struc=
t
>distr_item *i,
> 	u32 key =3D ntohl(i->key);
> 	struct tipc_uaddr ua;
>
>+	if (in_own_node(net, node))

This cannot happen as I explained already.
Please drop this patch.

pw-bot: rejected
