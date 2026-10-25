Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792912748;
	b=Pu3HFBANNZjdreCiJYCZBH3BeOZGPfeFrEyMT+s7tB16FYPfGQckd1TKRCGltbwJejTQ
	 VmYai83jFqLgl1vtvnWOwRaadPhP3NELfeccXc9PcQymbUe8Rtr6pUsQMj95BIjUzkvZl
	 mAyDZjr6b6YtQwKHc0lDUl/cyMyxN9dUjAeDqP3sc3KemHr7uJe7wa5d+hjjDwoQXuHTY
	 dksreHdramNOmfqmW9mZXYzhn0XzGFgEX3lnxtQXo9aM47gKaNdqd2hDw1hE8d7phhz4T
	 CT3jJKfiKnyFl6sJPjwyFgzzvVOqrZ+q8qQeKMZXYgPMPF1DV4XifodBdZgVS67Xtkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792912748;
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
	bh=yXYMFenRqQ5A0W3AMOhFZDuyKZt+5IkNJFqeP7d6ZvM=;
	b=J89UO675R5yNJ2TlvkkDd1Wh/O5tQg6RdUilDjxt+bHVYJgcA1KCNNQa4MKuBBzy1V4m
	 fms3B1V9gXN2FIlfRYd+ieBbsO2VMB5NNGhVuTYrnJGo+v/mdHU7ZYsP7HW4+4/A/UTSe
	 sg0eSZX8bDLutLgEB0JmiLKC/ecxfL24L17XA6j/gCDKyLq4FedyCKieqFtosSYtL4+XU
	 NmUjnvSrAikgI5bVd7gUH7P6G1h9sRk6koLwIpboQ4MylmDCfYUDUDOc0bG+FHpQ7GkCr
	 B3fR5g+dhkXJD5XymMLMlIecnMh7aDAUyJvU0Ob8T3hNsNE1YuyA7qxIwMK4xZZ+hBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BYvYLdf4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.29
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BEF606A31A;
	Sun, 25 Oct 2026 07:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9BEF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BYvYLdf4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwdSro5w7kD/07lGUM3wlaVccL5TQduHx8Fv4DEicJeEVnFuSSUv5I+1FtWtxKMUTjxCwArYvWg4iZFjBNL8UG5KlBIgrNiltD9RYkuUBN4Hmx95FfvKtI7ZRpwnPQRNdJkkI4tR4VEwgAwZ3cvm+TDA5Zn8risu1O7azKZt9feYpcz/V+vwultNlSpyIEsNit7r8inceiPE8hHqCpdMmDljy+v/vPzTw0aeS1tA2WtAj95cI+IAzPN0jQYeQ8mYlGjZ97aHjIBhJ4VSRlWZOh01ucwVfa4e+61YBUnGg9+OAJdMregqj/6lqfmoq9AQyvyMnT4Y/Z8hwrg93cLcAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXYMFenRqQ5A0W3AMOhFZDuyKZt+5IkNJFqeP7d6ZvM=;
 b=l7CTgK62P08CHwEHQBa6rv4OHp5h2ReOgILhr922VdmGv734co6lUla4X0JPQoXHo+Lg25VIx7fd3CA/fqn/FESAMNJyY9MoZz5p7R1Vw1ScCMWr9R8e5d9uuWSWCEiq2MIttXyTIMnmFeVaQHDMLvIt+KR4H7FbKhFYQErwKKEvuiJNMPXxfgSLK6/Fb4bi0CjDlpdC3owWhZcdNH40ExngHj1KOVLIXywKYEDTUB/AH5ecjSiLi7pkpQyaJIqldM+HuVKUW7H3PIhlcDkV5V/P+ehjE4S2/Gcl2Cp8ziQ8faIF5p5ohDuEiemZPJ/QX0i4gHhBLzgFNXNHS6rj7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXYMFenRqQ5A0W3AMOhFZDuyKZt+5IkNJFqeP7d6ZvM=;
 b=BYvYLdf4++u47Ca/ov6Wl2CCAjf/B7ZUyPWvupoUhdVIW68qqQ/r0wXniXIQDiDnvW5NFfS4DYEfvqaMzbJNfOHryaOGp4L8ix8f+3hccIWFJxAPldcz2nrAaLcc7taiBoTRaNY5AnetW0rn4BiqMPdGIcUE8sPQdxxqjyxD+r/Lbf1gauP7z2bhnjYqSsr3hRHn3ZdPRG7lv1VwXwt3z1mw9JyKonklfBlUE+pLkcyfpS2Rd3jdCzLKp795ul/jYYmOCzgphAFLjQ9xEjdtjgJENN4LCr1kwXch81tq7EH4uRRQokkQsyduuf+Xgc5qQ4XADsSfd9b/09lbb7TpVQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Sun, 25 Oct
 2026 07:18:32 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 07:18:32 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	dsahern@kernel.org,
	horms@kernel.org,
	yoshfuji@linux-ipv6.org,
	Ido Schimmel <idosch@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] ipmr: fully initialize the synthetic IP header in ipmr_get_route()
Date: Sun, 25 Oct 2026 09:17:28 +0200
Message-ID: <20261025071729.34967-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025071729.34967-1-idosch@nvidia.com>
References: <20261025071729.34967-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0397.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::13) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c0a02b-9f09-49c2-59d2-08df32682d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|10067099003|56012099006|11063799006|261009223027099003|261021121427099003|261022105027099003|260925021911599003|260925021311599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	B+KRyYJ3ttkbctuU71Q2sl/tQUDLH1lMkCwXwYaTgt2H6AjhlNHAzmGX1CBhAamlNwL4f5E9I6g6LcWRuSEr3qEQMp6GEiNZDa72Yg/A0TwXlgGk+VVRYlIFA/3Us7UAL7c6gYf25UXDBbVAsWKy4MbvlMzUJA8rcw3m1tQlEsN3Kv7XPptC7Dq6Wmad0PjrKxsldNj2IpwcAh1LW9s2C+IBgqIo4nf4dt8PNtkqpDyyVRs105573MlWtQwJHHePDFOVmwdopA47g2MjFU+AgINOuZgTVNsVWeWieKsQEFczmJNQOR0PqBOcX+MYPKBEsYT7bhqSKakinLMfY1appip6QHvncetAMua0TYMVyL3EaGksmi+SZtMYEypMcEn1IvpDoLDFTisY5pbDM9ODNw65eihVSyf0tL+oD5hpmD5W9Y1pcwPV3+LSCS02L75Lnb2NeCD9stuBjnpH6E5bqPyb02d23bA5mlZdt5DsNgcID98rM10wUIi0UT332IwCQisdHWqH1UI/0u1O8O2+z1xQBb1XmEstPMzaZX/2oFHPjL9u4IowHpiaRBrYYWW8tOz1ao70hd6/ZtqOU8tvv8aQalVzK3dxx9Fhx27WZrUlArXRLipHAJIYcVN6pyKvbeD7Byijbp/tWVWRlNSZVwkZ2q8DiTSgxCj8gI5g1zk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(261022105027099003)(260925021911599003)(260925021311599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DxVc+W0ffAvMUjAa3u7XygBrIevVWJctoRGOAliNuWciHQ1zUm8JDzoTbt58?=
 =?us-ascii?Q?5UF2SinUAC4XSyv05qoBf9BZd9gYr7tYyXtReZpb3CBotg3cCuKr6Nuxqd1U?=
 =?us-ascii?Q?OvZj9LkH2CIg2tx8Bjf5fJSDykM9uptqg1aYWlO+k1GDxLBpmIdDuwoMJuH0?=
 =?us-ascii?Q?hJrGSzP8ZpqP8JUDKUmiqswSQJpljQ5uhMyUyVcrxwgnxQXBrlnR1iZ+Lxha?=
 =?us-ascii?Q?75qFo9YMUhg4X7vTP4qtCYi5Amv4tbfwob2UmhgcgACUJSpgVWZVp6w0Tqqh?=
 =?us-ascii?Q?TUQb5NytHJ61PJ9J9WswjfyTipyMT4YpKPCrn/FrukvocvF5dYjb0C/vYUhk?=
 =?us-ascii?Q?XRa9xXw9HwgKxTm9spUHiG0juvXN1whclaz7XmJcBmfhvVmMABHYmbei39oo?=
 =?us-ascii?Q?LS2anYfieh85wZ6V17rYnKovYH9tZYcloG4mC4/Lm6cZ5AC3sTrX48XZ6XzI?=
 =?us-ascii?Q?3cg6q/dWyND16k7Dq1fF3HLOUOzgv9sUuOhZA/sTuGVL3uGHsgk2VKmlDwgc?=
 =?us-ascii?Q?hta2nDaB7F4iAOVLzaCq1cxcvacmCX9nnYVcd3ZhUwVOz1pnZtAWmwSda9nA?=
 =?us-ascii?Q?MJgzpyrUnSOFW4qavwUbwLAgCXICsA45yQSWE2haG9QcM0bP+KqiiYgUeC2C?=
 =?us-ascii?Q?luUJlyE5+2JfWNEfco0x/Wo9rw5J0vQK9hE7XC46NSV0eOZUT7LYPcWuDUBx?=
 =?us-ascii?Q?wKJFH7VtPxiT2BvF8tVlXxf/u2L4lLjTA89Ax2v0pYP6M5y0zfXgmhZyrru0?=
 =?us-ascii?Q?BdpHjX5B1aYcpoP4F5kcjyKN+X5bPaFE9ChD03WPh9y9GHBgSE622SZW3egA?=
 =?us-ascii?Q?IidCMc0UkXexJ3mYPq7dsoOm6MuvRDJmffgY1PVO/929WGDCGuTUF2AJvOkK?=
 =?us-ascii?Q?85Lh4TYJ/09EI7hWRqrYtcz0jNBPudIHAoZlePPk4K7cKCgGkBx5qlejHagY?=
 =?us-ascii?Q?sSvUyJBERBgvLrgSa0D8fYWm8mV6NzDV0IQO3tROaqkXz7HnlX5L2ATbflbZ?=
 =?us-ascii?Q?rnhbgg4VJCF8dhxv5NnhdSXSz0MdwooxtRyMh5BZHOpWg//O27e2MV40GN2G?=
 =?us-ascii?Q?mK9wnwSB3ugtqZkkMe2mUZe5bP4eEwoWeoCqVjBk+UgwFUD9EMrtXEfj/lV1?=
 =?us-ascii?Q?hBs/T5Z3oFFPBNSFzMZpN9QOJFy3FVJmrZjfcGRxlkMMovOu8XknLfoAmfcP?=
 =?us-ascii?Q?axC6bcnVgUxjAgtHiJfNeCJagzEkRxAndogu5esGAAan8u/5HvkfEonSHjeL?=
 =?us-ascii?Q?BklK24y8NBcK4z/PcKAqm6jNQWWqRFMwZxEcfWVJu1OmpwSDW1Uf5zDmkhRz?=
 =?us-ascii?Q?XuVGbzKam2OUHmJR5S2xOCNILkVeUiy47Hs6hwv0V6ADosjqOrzffgMzsBpp?=
 =?us-ascii?Q?fVWrOH/f6H8wXMTD8UkQJtGSq8hBwmDjRxfpkI9I5Z9o+HQ6w0v757XadPoa?=
 =?us-ascii?Q?7tc/O8nAjmnaInj0vkmNxfsuK5LhPL2M03AnO4j26xOoRFIzhaikKG/Pm823?=
 =?us-ascii?Q?oLk2PVnXM8hJ9e4sYhWAOtoWL0XFuFYK6XygJQwRX6Z36vlbUpgq1AUeqyBA?=
 =?us-ascii?Q?ZviLmn4SN2w+rFeFd2N7Y3xi/0CWABZiPKaxaBV4DeTC+46tcY0csq6YdeKx?=
 =?us-ascii?Q?TPm2aUdSpo1X7IKQf4Y91pz8YXCTnCrzwhRdM7QGZtu3m54pwG3LA2hvNmYK?=
 =?us-ascii?Q?NlKFeymqpzx4t4K5FCbJUq7E401hxGqWU7dbq2ckpMAdVDF0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c0a02b-9f09-49c2-59d2-08df32682d52
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 07:18:32.9181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAj6+/QJJg8F6Y4aH68IvuW3D8Yjbth6ARKQ5tdfDYp5dLXUq1qg5m0QfEL4hbMUgx2ro9tQ8wdbjHK9BUHnGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684

For an unresolved multicast route query, ipmr_get_route() builds a
synthetic IP header in the headroom obtained from
skb_realloc_headroom(), which does not zero the memory it allocates.
Only a few fields are initialized, leaving others as stale heap
contents.

ipmr_cache_report() copies this header into the IGMPMSG_NOCACHE report
that is queued to the mroute socket, so a recvmsg() on that socket leaks
the uninitialized bytes to user space: the 'tos' field [1] and the 'id'
and 'frag_off' fields [2].

Fix by zeroing the IP header before filling in the few fields that are
used, so that the entire header is initialized, as in ip6mr_get_route().

[1]
BUG: KMSAN: kernel-infoleak in _copy_to_iter
 raw_recvmsg

Uninit was stored to memory at:
 ipmr_cache_report
 ipmr_cache_unresolved
 ipmr_get_route

Uninit was created at:
 pskb_expand_head
 skb_realloc_headroom
 ipmr_get_route

Byte 1 of 28 is uninitialized

[2]
BUG: KMSAN: kernel-infoleak in _copy_to_iter
 raw_recvmsg

Uninit was stored to memory at:
 ipmr_cache_report
 ipmr_cache_unresolved
 ipmr_get_route

Uninit was created at:
 pskb_expand_head
 skb_realloc_headroom
 ipmr_get_route

Bytes 4-7 of 28 are uninitialized

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0545f0c83f5ee2f6696210f87268e811ef655715.1792476357.git.zhilinz%40nebusec.ai
Assisted-by: LLM
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/ipmr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index acacaae05cc4..eac23f251bfd 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2506,6 +2506,7 @@ int ipmr_get_route(struct net *net, struct sk_buff *skb,
 		skb_push(skb2, sizeof(struct iphdr));
 		skb_reset_network_header(skb2);
 		iph = ip_hdr(skb2);
+		memset(iph, 0, sizeof(*iph));
 		iph->ihl = sizeof(struct iphdr) >> 2;
 		iph->saddr = saddr;
 		iph->daddr = daddr;
-- 
2.56.0

