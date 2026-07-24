Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D742E8DEB;
	Fri, 24 Jul 2026 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784874243; cv=fail; b=HCXwkE75VW2jlrJo+Efpz2cVghJAjwwjtuhlMUdLxJ4yktMa5Wi3BBhGR8mhj6EId/q+w6bwrs2NpCT5zv9NBElIs2HGyK4HOMqpHuaFEAyYF+MJg7ezgE2wJcHw2f3RIebdvNl0L3+HlBbRVfyMVQnhcfpHey1qpx/NyK1zfRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784874243; c=relaxed/simple;
	bh=ClUuDwhdqMARQbduglsuiheOZSddmm7RKVMP3TaQGhc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pShToPZaJZHpcG2Fl62BoC+e5mt5g7qNYjPb4HzT+D9Yy6OJY73SzqIc3DBFsQiMpdEB2S8Ci9IARjRcSJy3VBCgsbwRNPmYMFsIvp4I6fGBIe6mquMBi08fIcRK6QirsKsHgJVIk4B534OrgREkO2/xH0kEPbXZgcbBNOS2kYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=mF5m9yfG; arc=fail smtp.client-ip=52.101.66.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="mF5m9yfG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKw3V4uWnraj2w7+BDtVL2u5uJuGuPI1roDAoQvjT2SI40MH6nzGjKbMQ/Hd2jZbdCGB2ySjUG9L94YuoLfu/pfdXc+EbB49o0HFgWIkXSDKkbFQn38lNqEhh6gPwCp0dB/L7JL7ElUr2JSguYmizEMJ8/Nq8TBQ6etgNxgTX/vlqe53y1DUiD++df7FD1mUOsBNdPSG4GPQKNzA23I9yYG2fcxwWWvAifW7KWFXHUv+1gE5f6kgDgCYpHinZ12RbIz/GTd8xvwVnZdqYOl31rvUPcbL0KVr69kwTtfogX5NHWXaVclHsiGkO8RNG5LDvMoPOG6O7xY/qJRto4RtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLsSBXw30N4OQ4DZ8t9t5oN+wABTBQbTrdjJOnUrs20=;
 b=rWakXzj7/Lv7crkKyZ1oPnupnC1FkIJXSrfhNomvuR90FsA5OmmbhrDyhZis1j+9LQX3QCXvK8KYacANfSVgYJq9EECejp5XXFnlh+ARwmf6Br7qCNZ8LV68ezPlxLRgQQ2URQBdgQu6Rrr9Th4lQMSDNgDX4wxaxs9Vf11scEnqzz8rCWabYSemLqut9y4wkGhk1VaiSTdOH+WQ8Bwz0Nw3OAneGw2kVjpMwb4Qgr0MowQEQ4cblCQHgH8ExUvnQry4hqdtKVSIJE3MVsL3sj5BoM/eSS7RwF50fwnpw5DmXc/Z4njLEy0QFnXW6GEknFucII8Rg627cAY3WfReHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLsSBXw30N4OQ4DZ8t9t5oN+wABTBQbTrdjJOnUrs20=;
 b=mF5m9yfG4IrsSro5YwbHaXFuzfsLgIwbNgRlxWH6jbk6kOYPi+n40yaPhBycJCkmzfDvLcrMSEDUtXWiTWW5XVl1dOjBw74w0UfXDzzOV29mJ44H1CUVHqLSccifMO2ECaeMe2oT2Nv1K6NRn+Zm7hwvU3JjjEwTWjaVBW+NvW2UMXQoDESzL1IMU/X4/7ii4Lfz1Cba8OM3T40FzzSmp8BBMCwvgwNNQkx5dxO6U0yOH9ImusTgfCdeMC74ZHvoy8+9DfeQG5NUPX6iS8NHGwC0VAX9qdua7l15c8YhOpY/mGHCDjoFBn4dBlB7XxCvCVrJHiqrGnthzH9j8d2cIg==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PAVP189MB2409.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:30d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.6; Fri, 24 Jul 2026 06:23:57 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0270.005; Fri, 24 Jul 2026
 06:23:57 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Sangho Lee <kudo3228@gmail.com>
CC: "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] tipc: validate Gap ACK blocks header before parsing
Thread-Topic: [PATCH net] tipc: validate Gap ACK blocks header before parsing
Thread-Index: AQHdGktH1R6vX2wPbE2MkTyEKJj9m7Z8MFuQ
Date: Fri, 24 Jul 2026 06:23:57 +0000
Message-ID:
 <GV1P189MB19884B48694E06A42BBF26CBC6CF2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260723022947.1569915-1-kudo3228@gmail.com>
In-Reply-To: <20260723022947.1569915-1-kudo3228@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PAVP189MB2409:EE_
x-ms-office365-filtering-correlation-id: bdc60b1c-fc08-44c5-9169-08dee94c2492
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|11063799006|56012099006|5023799004|10067099003|22082099003|18002099003|3023799007|38070700021;
x-microsoft-antispam-message-info:
 hQhHapRJVAcTlQrIh19HKGLk35TzEZrU+0ZIUy15cS93cT+irJemoD5fj7hVdwWFCAsG/PURSR2X/WySL6ckSQrlGluuHp8SLIWOGCkG9WylKz3t7ueB8fmhS+z/Bxwd9mKjL3KVyMsYVYUlkMYrqAYzX6gAWvFlzfdSHqTRtdx9oMUvsPVXpLw1/ZPl4TCheTYy5yUn+3K7d9RJM1D1OyrH8Gry1RZX0fOYIbHMBe5tOTSNZCMVGWq05tHj2Kdv7WOUwB8zgoBPIqdaIBBRrHOcYh/boHXwvTOKX8Yv2bTj6GLc9yBzhR3wwSwJueKUiH1xviRZDb2t4j+StwpBHq+gW0GEO2sCYgl7LMD0+t2KPkXt0zl6MvqR64m8Ye+obXxEl5ikZXkZmqkFQH0CyguKbQ4v6aW/8Cy7W5KdxIo76bBOPDGH1YlKWGh9fLc6e09YiBOO2E+JLoqxwIUNNjxfDfDsrPMJArJ08GV0BhXrsDd9pDUyjACtAo+jwEyK2bWPyYQODiQd6Jm57M6T9lyhZpT1h5c6uFnwpax96/xgoOZGdotrpoBlLTGcXdFPfKhGBypdoABcNyD8NP8Oh691wylv4gJSunIeTwTQI7eUb5iHBhL9HR9QagN8DuHfp+E1L6QsUEl5LAY7kYN4zH3x/ctP42UpYiQeX5ni+qHBZC3qfP/QpIQZhv4x8Csjklcd0Q0LBe2zfFDCUUp/Qe/3op4GjRJELZ/N60gwloE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(11063799006)(56012099006)(5023799004)(10067099003)(22082099003)(18002099003)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ntGAiKBo7Of7uno1NQ3yinCVKGAaqRvUfSICgDyw7N77ULgZnwirUN1d5VVm?=
 =?us-ascii?Q?aHMzmFlazjrAxbXx8LLM/eb4xPWehV3wrVLMtGiIT6Xen/M6jCWJPRnvkDvM?=
 =?us-ascii?Q?xW1Xuhr2HZ5v3gIexpd9Uh+gG8UbSZznG1ntySrWVsN0mL9qohGOMaSYWyIH?=
 =?us-ascii?Q?QAhzdBtthKvnWJNf01RFS0NICJxbP6TSbCnQvA9wzsTbydO5O7OVw0pRDdht?=
 =?us-ascii?Q?s01umgjeo/iUuCo4IA7VrYlFaG9BpTQaucDiNXCJ0vseI5fVk1l+y2OJe/pM?=
 =?us-ascii?Q?1SbfY6iUcoRRBdcvfi07KQj0gvrLMO+fAfuU9hgiSzfrN4N9oGLrrnxmoinp?=
 =?us-ascii?Q?GElVu7nopU0NJa2pqHerVFXtg0Lgr931AUzvdRR00MYudUae/cKDBjeVqjCs?=
 =?us-ascii?Q?W+MuNz/qoXbyhGOPq4yUGug+ajOsQYP7RYPOF+zyjBZFswDGQF6q22dzz8vn?=
 =?us-ascii?Q?VCE26KsBEwo+RF4pOLKsV9KaOSdvoutcupkhnRqwEosDH2nwCbT9VQjqYz4k?=
 =?us-ascii?Q?LXYnbkttPQBgJGdq4Ye5ThMmEKIaQ3HO/nN8e5f/kBakj1L2UVlcClORcs1B?=
 =?us-ascii?Q?W7R63I1u5zvSS/HbPMjg7GAIKZDhvrwCrGuvSM/p97DbxwOcZpkha3w2wu6Z?=
 =?us-ascii?Q?J3MNbgAPgOR8E63E6jFmO71cH472GacKgrWicwXIGNJW8ZHeSsydmh81pGub?=
 =?us-ascii?Q?yaB3Rj1W2ZnEbbYGPDlm1cZHB+DtG7STxs8jUDVYWt16mnPooGjBILKCu6S2?=
 =?us-ascii?Q?UxosHDqJ3Q4C3IVwNzETHKVgov2Kg2qMGNr72rvqDUrcKH4ctHHw8Onc37p2?=
 =?us-ascii?Q?PxoxurYzV5Mnd7eEmpoNLvZcms/6xzpxTwYxA443xMxO21HCrxHzJX+t2JnR?=
 =?us-ascii?Q?vVC/9C/xf+UMLoxhP2LZ4B7wljL0CLPhU9VUU9DotKR6BIqhVVY01k8R58xe?=
 =?us-ascii?Q?eror9br9LAuPgxDz4f+KHkiR1SHyTnrpMLQYFX82kcwmNvbzSwmcxLfFGUYK?=
 =?us-ascii?Q?+Aiu8h9Zctqd1jg54KI1mBRmRrSYh4ubw+51FR3pFx7gWUNR3ubVSJj162zx?=
 =?us-ascii?Q?JY2Eb/c1Qmo7inuN/qCiY51e24Va10fyLUd9eHAOMxMPZifaQGm36XXF/2xb?=
 =?us-ascii?Q?uLWaSDAX7oOa+CffNj0p3ydJ4/jV8rXpJVpGCkT6UO+RSuUdPo8beRpGGB8W?=
 =?us-ascii?Q?b38q9Tkr6hMyIiuRg62Vowen9C9bubS/QNxOgB1J3ZaklPvJMWNR3BreAqij?=
 =?us-ascii?Q?SBrWMHi674XdStWmxO5ULXXR0q7jUGm5afaF7pgmQg15TyZCvJNoKnLhhMnb?=
 =?us-ascii?Q?ddfUw1VA55m2wdULh1p/HJoFrPc8YUNtWQDtnFLBmhlDgk4AumfR0GKLdfSv?=
 =?us-ascii?Q?qu0ZtERZHjy8BEmkUBNC4GgCwY5iqJyUpLCpOFVtCzHsDxEH87ukR7Qr5mmo?=
 =?us-ascii?Q?OMbeXTdO1+6urJh0ShIarZ5VItv4noze4JEz6vjZQXvwt4pqdcpbv4Hc6ReW?=
 =?us-ascii?Q?Xx5AEO/CM3JQShMkg5AVMqYvPrw8m2KvnOX/U3zWi3L62l0JKkTUJ79ahAH7?=
 =?us-ascii?Q?iZv9BA2JZ4nE6OTB2jlhF5JgPGG3sYdEdGS7lC6A77foMBuZn4A0JjBvDHvX?=
 =?us-ascii?Q?jWMqLgvUW/LGm6pza8jrkQPJMPWRJ7jeGa0bzUOD3hgjpA2ykvhd6e53iHWY?=
 =?us-ascii?Q?61dLIahWj3ZpLmArZPUkhT3E+FpAPHZQReijFFrAqWtNpOhlGM+JwuG+8aJG?=
 =?us-ascii?Q?+eDsNWVwng=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc60b1c-fc08-44c5-9169-08dee94c2492
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 06:23:57.2332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0pY5YLE7ukdvLfKjXL/4m8Ivu8PXlezgu9Y9Ok6NSduc9ohat1WpPAXO4S2DRZ1Iob4lzJErqmPyrBvW0sYaSv1VhC2fPcGZLNoxQ0qwW2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP189MB2409

>Subject: [PATCH net] tipc: validate Gap ACK blocks header before parsing
>
>An established TIPC peer that negotiated TIPC_GAP_ACK_BLOCK can send a
>STATE_MSG with fewer than the four bytes required for struct
>tipc_gap_ack_blks. Basic TIPC message validation accepts such a message,
>including one with an empty data area, because its declared size still con=
tains a
>complete protocol header.
>
>tipc_get_gap_ack_blks() then dereferences the record to read len, ugack_cn=
t,
>and bgack_cnt. Both callers compare the returned record size with the decl=
ared
>message data length, but only after these fields have already been read. T=
he
>late checks therefore cannot protect the fixed record header access.
>
>This was reproduced on current net-next with two live TIPC nodes over a ve=
th
>bearer. Replaying an established peer's STATE_MSG with its message size
>reduced from 44 to 40 bytes produced:

It is not recommended to use TIPC in insecure environment and create fake p=
rotocol messages because TIPC cannot handle this.
You need to use IPSec (UDP bearer) or Encryption (Ethernet bearer) in insec=
ure environment. See the requirement below:
https://datatracker.ietf.org/doc/html/draft-maloy-tipc-01.txt#section-6

>
>  BUG: KMSAN: uninit-value in tipc_get_gap_ack_blks
>   tipc_get_gap_ack_blks
>   tipc_bcast_sync_rcv
>   tipc_node_bc_sync_rcv
>   tipc_rcv
>   tipc_l2_rcv_msg
>
>  Uninit was created at:
>   __alloc_skb
>   alloc_skb_with_frags
>   sock_alloc_send_pskb
>   packet_sendmsg
>
>The uninitialized record length then reached tipc_bcast_sync_rcv(), where =
it
>was used to decide whether the STATE_MSG should be dropped. Supplying
>four initialized bytes after the declared end of otherwise identical messa=
ges
>also changed that decision: a trailing len of zero continued processing, w=
hile a
>trailing len of four dropped the message. Protocol processing therefore
>depends on bytes that are not part of the declared TIPC message.
>
>The KMSAN finding was reproduced for declared data lengths zero through
>three. After adding the minimum-length check, none of those four inputs
>reported an uninitialized value in tipc_get_gap_ack_blks() or its caller, =
and
>bytes after the declared message no longer affected the decision.
>
>Check that the fixed record header is present before parsing it. The calle=
rs'
>existing size checks continue to validate the complete variable-length rec=
ord.
>
>Fixes: d7626b5acff9 ("tipc: introduce Gap ACK blocks for broadcast link")
>Cc: stable@vger.kernel.org
>Signed-off-by: Sangho Lee <kudo3228@gmail.com>
>---
> net/tipc/link.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/tipc/link.c b/net/tipc/link.c index 49dfc098d89b..8cc30eb=
df575
>100644
>--- a/net/tipc/link.c
>+++ b/net/tipc/link.c
>@@ -1418,7 +1418,8 @@ u16 tipc_get_gap_ack_blks(struct tipc_gap_ack_blks
>**ga, struct tipc_link *l,
> 	u16 sz =3D 0;
>
> 	/* Does peer support the Gap ACK blocks feature? */
>-	if (l->peer_caps & TIPC_GAP_ACK_BLOCK) {
>+	if ((l->peer_caps & TIPC_GAP_ACK_BLOCK) &&
>+	    msg_data_sz(hdr) >=3D sizeof(*p)) {

It does not make sense to have this check because when data size can be mod=
ified, there is no guarantee that fields in struct tipc_gap_ack_blks are co=
rrect.

> 		p =3D (struct tipc_gap_ack_blks *)msg_data(hdr);
> 		sz =3D ntohs(p->len);
> 		/* Sanity check */
>--
>2.43.0
>

