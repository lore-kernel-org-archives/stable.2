Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010023.outbound.protection.outlook.com [52.103.33.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DF7357D0D;
	Sun,  6 Sep 2026 23:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788737908; cv=fail; b=AsxIpUtwMonZjyhH2QULVkCvWs/LLxb7vWSLHqJEzb5MdnVV/ryQ1RkQmf76Zi+3eyq932K39WuDFPN4wVJtWAwKazFuLa4eij4N06woE9aDvY8WeeQYPuLrdPrpn2n1HJSNn1NgGkWC1zsbxVqYkf/ojxGlZ4q2mIuYMOTmAcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788737908; c=relaxed/simple;
	bh=5CITPtiqpev9evaTuN6qo66T3olyzCNPiOkvfJUBZSs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CMp/C+drEcEtv7PKhybOKi1Ud+ecHrjQ5ZFXdDyGnYkfWJy3ldHME23c/CkKRLBmnhV3quisQF6ee7//owUXRZabljuaM5dtwuva1zhwjWLYH3Y/XjMr5vwxE0/oVXxKoP7nev0XwuW8B3+1LhMA5EpGdDHC7HspahcTmDFX32s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=RJcVJgKM; arc=fail smtp.client-ip=52.103.33.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="RJcVJgKM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4JJHRN3jdZoFiVtURcTD+Um/aMUcwBKe6UiDHzk6G/E/nO1HmzAbzRBDhj/8MdQ4kK3Itwy2iaXp8AP8kh59AqhfFckBwa1o1QLu0uLwiu1otchPtIVJUgJZMlq2dE1hQhYeNsmFqTxWNjooUeX9Xq9AuN6gf6wyeGXLg9AYYEvAygkRIrjGIfVtDv5UPbisQZJeYnG3rSMPVi407y/CGJY6FgLtf3do5lNdHUrUCR6MW3fcsxCJySrqoLUiBmvekFOAqWb9KaHCqBQymlZI+g+Nci+r0jlSLMBMJuIrTJeQvKh6t/5vjTKcvBDCZLuVH6igHVEMf9s8JiAR8nw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLgFGpL62jvXO8af6NQ0lju/MhqiaL7QMr7Z6F1p5aY=;
 b=XnwvIB8ZlbdxmmqAn1NuQU9nLTftRUyih0POTd0hv9pyFcwaBEBeLDnXM7vUfVw91/5a6H4Nd3DFlW0bdp5MYGp9+9XcqPpe7rwj9dOwMoQ54PWvuI6EdEavOoyGzUyCVA9/cI6jiSnjaHhXLOSaUyvhH/Dc9ihYTQz0wZv35YcO5IV7IXcWrGh7W+fwFKQ0LQsBQDBNkHirDgfs98IOiJCWqrdBR/Z8qthIEjQ9LJW9jjNOJwR47hx/fyOS8CphvQEjnUzFKhHnIeNGeWyxW+b1gGmmGW9gcwGdcbKMyF5MbInNtbj6eR/GxFNhWUCZcV6hXXC9IhI19meKcESDFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLgFGpL62jvXO8af6NQ0lju/MhqiaL7QMr7Z6F1p5aY=;
 b=RJcVJgKMXdkWgM97kz1TPod8lZUbKc7hJ5zm6linK9sfCE7XIHn15Y//uGIZU15hDgEaUeyGq4UOwhjDdlfCqHfOEgNS+JKWLFay7jNsSiSU/eA77THuDyHjpDm4iC1up3nwGWu1o5uhcbzK/Qeds2oG+sJD51CSbzH7Nyq1q4S8cdZg5zVNbj84ebOlTgsMD9ORr5mKrfaqode3u19gHA0c+D5mU2/NK00XDAAskW1Ud6KZSiTWe2QhVOWRRWOoGoEG4WSi+kEyhqgUekfut9fl21UkOQMCEC3h+5WkBYk5s5NjFMX9+7n94kD8TqX/MQrhi8bJnAuCGKAzaFVuUg==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PAXP251MB0113.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 23:38:24 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 23:38:24 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: tipc-discussion@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] tipc: validate data size before reading Gap ACK block header
Date: Mon,  7 Sep 2026 00:38:20 +0100
Message-ID:
 <AS8P251MB000136A75E6C720544CAC017C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0178.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::9) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260906233820.87800-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PAXP251MB0113:EE_
X-MS-Office365-Filtering-Correlation-Id: 712ef473-89ce-4d9f-26ac-08df0c6ff190
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|5062599005|5072599009|4140399003|15080799012|25010399006|23021999003|25031999004|37011999003|19110799012|8060799015|12121999013|440099028|3412199025|26104999009|52005399003|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X333TVDEMPotxnb1FiRPkWFB7P5MzZqileQgd0Ta464iTc28TudI0WOPD5JA?=
 =?us-ascii?Q?M0piwC8J86JOaukauODQt0MYHzUwmyZgU35+LlQIs/+4PG+UXM3wn6/iBZAM?=
 =?us-ascii?Q?VqAGu29BdcY+gjCi6TIPNc0YZU5WfysuJnJ0JiWpPlcceQIhmGFa70tQDikQ?=
 =?us-ascii?Q?CNgzPTuZgRdldMGQx2QdRseOLK1PFSGHuxkNhPlzl43gnvIdLM0w3DwMMCnm?=
 =?us-ascii?Q?+N+cJufJljEYgPNuQjGQff9258Kz4h3kfP0V1TelJ36A8bZkd+/z3gzYf8gO?=
 =?us-ascii?Q?Ovans63CIStOo0JAW2oUgK4TukBeAqnel2fVIm7EkScOSTL2fWuUBRl94Dy4?=
 =?us-ascii?Q?eRUN5zQC20Bb3qnYprCphsHlvF8YJdstFWrLCqrK/4xrjpyws0M8o8td6etg?=
 =?us-ascii?Q?BcNUeTa+l/+aqOCRnFBOwyJpp6Jfnq5RqNWOalMGsuAoOmivwSaNWCUBXrsi?=
 =?us-ascii?Q?rp3amXsnutpeN99RonDzhEJD2GaHHnwaO+6exKQU35pUxCqMcL73lUL72EaV?=
 =?us-ascii?Q?wTYSonLQYh3N9URx1msNWKcMgF135ytV5t50lGmmv5AuDdTnvh1KpM8RDjbV?=
 =?us-ascii?Q?PqPjQ9SL60SZ+KKQX5R7FPcvW78CFHD485tq3Spfjj1vDBUUNFYDUW9BVtFd?=
 =?us-ascii?Q?VnjVTA4ZLHj4BIvL2+pSzu14WiLScqPFofo2pTvnfNSv3jl8k6t8IttSuwVj?=
 =?us-ascii?Q?w1AIYzFyesJA7yY99zHaxBMG9m4L6tqBxkl5tLdJHl0N6L28S7RE4CW/tDzh?=
 =?us-ascii?Q?HpYzXMIxdJaMD6EYwr5lsDyY8hAw+tAqdxPTlXaQAHHISTyx0zKL5kwtD7W/?=
 =?us-ascii?Q?S8Dm8mX3/dCDWTgZg4WLI8nBhEKYj57xxoyUNf8hje7p4K2EYuSNSoriHK28?=
 =?us-ascii?Q?k8+cNyRIRPEf80RqpjLOFug3Xxi/5YPMmFtcRuOzEMMd/TcyuSkOQzAkXG04?=
 =?us-ascii?Q?RSe2360jugUVTslID5I/rmo21pvIbVYhcSmZGSfneMJ0HnbjkDJ5zfd00NU7?=
 =?us-ascii?Q?+xQikPsvCS8sLyAlHQ2yzC9CBc7uT0cXq291dDqAomUc3xwxKLpeqsp9FZlW?=
 =?us-ascii?Q?QXiHMEIPZbL5tAc4/Te8YuEHeufSDq49GL53GVlLQmQOH1CY9Ig=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m/LbR8ZqNzOj6+X42etvimX1B9hEe1n0DZwM6gLEv1p8MR19MUQjoIMjNvJ5?=
 =?us-ascii?Q?7clNezL+0R8xE8f2Jw0FiqbtbjrXjeATV398s7Bq3vQSfs2wl8p4+aZi1y1M?=
 =?us-ascii?Q?3UQfjKEm7EzhWrMJykvs+pNDwld3rPZV7oAV+yuWRfjqEGaP7WDfW9veJv/z?=
 =?us-ascii?Q?J5CdMefMCpH9OU1lQNTCaK34gcQnz3yImjH6J/9goNimuz/IyiTV37b8FJoe?=
 =?us-ascii?Q?fGetr7DFVQhwaGfKsEi9P+j7AmKPBKFkcAsWZX+67xIEp7LZTOfyLD9GKU+L?=
 =?us-ascii?Q?wLFaLK6192lRJbmKng6qO940zPu6S/GW1Yk9upsS7gRUT7EE2l4VGqxB8yby?=
 =?us-ascii?Q?w9LhrqBsnqQ/tFq8GjvYsVr4t2g5LiZ/OPEszMkVNziQrTPvyRuFnkeJ51KC?=
 =?us-ascii?Q?k1nHS79GNB2OCNJcxVitMC+b/QE/Gtl388Q45NMMpMWh/DaYuEtAmR5eBjn0?=
 =?us-ascii?Q?whd38ZlsmmUPj6eZrSsahib194TzEMhjZaopAWY1i4dUviOlLVKdg3HQ8zv0?=
 =?us-ascii?Q?zeoIgKtJWIXD/dZudgN5iXI+GvCvZMII2ag1yXkfsyqyFiKBtKSZJMp8n8NM?=
 =?us-ascii?Q?snEooe/9sm2w63HyXVkh5rgHzXUm07X/SYgDPJMOtTy6bhriQxrGOyEU+FOq?=
 =?us-ascii?Q?pPT5hSHmWu61LXbwRzyxEXjJZkNe8D7/Aj2nV/MRQlA9iJjORqpdQd/DHdoT?=
 =?us-ascii?Q?cUlW8iuzR2uf5adb42gCafG4qKtzWFKKpctwXA4/X9fuexblmzLHXs50xIk+?=
 =?us-ascii?Q?kG27EeGOI4FJdcBmwYlWsrnejI79AZR3ezR3jkDbmeKpstsEHBY60qXHWtBE?=
 =?us-ascii?Q?ZtI5nSoqyj4UeCi/DLuJ2XaUGpiLjO/kITj2QYqTkjBA37E0CWMCbbHZVc7C?=
 =?us-ascii?Q?U1wov42baJl88i2zOT1hBr7fD1mXwdtF58CkawTt7UJLqX8O0DtCD2JjSGED?=
 =?us-ascii?Q?l4fFpUYPujbztyRSpwA4ie0Sd3Id/hfF4v9U7p9yMk3tKuxP/zSERYj/rWRr?=
 =?us-ascii?Q?FNOM0M9qXy4kGPy38Yt9aGbbC8IzCrrLYX2ElHyRfsGSrvSeG+E9DdzGY4Xs?=
 =?us-ascii?Q?ajLdiqExtBBfWExL1U0KQwdBgy68vffKeJH9rTFMLff6I/N6xfvQ7oOKO7pk?=
 =?us-ascii?Q?/7JnEx38ulS3nHybDUfVEoIBWdDJwUP1K/4aXAmI7vnKmyDhmiKRJBSs62Rb?=
 =?us-ascii?Q?CbY20BiGBDT75ONKr8rtXqttS4q4KKeqm8eCjPLNAoHBivZ3bHR7K3lafhWk?=
 =?us-ascii?Q?ZxsJwa5Bm0gVSZBIUada/SG1ajo8Cswg6N3peimGaby+TH7MXmuoB6ALbqXh?=
 =?us-ascii?Q?asdkPgkbjm9aCl1ILQCeqKs6kVqqB7hMx072efjfOfJFfC13Yu1SIDNb7WWm?=
 =?us-ascii?Q?1Shvapw81FQfztFAD0CVMiw2SGO93R140TC8DhmDvfb7wHPIlJsI8AZmpjfk?=
 =?us-ascii?Q?s5H7Fp05+CoC36LyrjgCH3XQiBX0cfv7?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 712ef473-89ce-4d9f-26ac-08df0c6ff190
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 23:38:24.6364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0113

tipc_get_gap_ack_blks() reads the Gap ACK block header fields (len,
ugack_cnt, bgack_cnt) from msg_data(hdr) without first checking that the
message data area is large enough to hold the header struct.  A peer
that has negotiated TIPC_GAP_ACK_BLOCK capability can send a STATE_MSG
or broadcast PROTOCOL message with a data area shorter than
sizeof(struct tipc_gap_ack_blks), causing an out-of-bounds read of up
to 4 bytes past the valid skb data.

In the backward-compatible code path, a 1-byte out-of-bounds write also
occurs through "p->bgack_cnt = 0".

Both callers (tipc_link_proto_rcv and tipc_bcast_sync_rcv) validate the
returned size against msg_data_sz() after the function returns, so the
invalid data is never used further.  However, the OOB accesses inside
the function itself are undefined behavior and are detectable by KASAN.

Add a check at the start of the function that msg_data_sz(hdr) is at
least sizeof(*p) before reading any fields, jumping to the p = NULL path
when the data area is too small.

Fixes: d7626b5acff9 ("tipc: introduce Gap ACK blocks for broadcast link")
Cc: stable@vger.kernel.org
---
 net/tipc/link.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 6427c69f8929..0be86cbdc913 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1419,6 +1419,8 @@ u16 tipc_get_gap_ack_blks(struct tipc_gap_ack_blks **ga, struct tipc_link *l,
 
 	/* Does peer support the Gap ACK blocks feature? */
 	if (l->peer_caps & TIPC_GAP_ACK_BLOCK) {
+		if (msg_data_sz(hdr) < sizeof(*p))
+			goto out;
 		p = (struct tipc_gap_ack_blks *)msg_data(hdr);
 		sz = ntohs(p->len);
 		/* Sanity check */
@@ -1435,6 +1437,7 @@ u16 tipc_get_gap_ack_blks(struct tipc_gap_ack_blks **ga, struct tipc_link *l,
 		}
 	}
 	/* Other cases: ignore! */
+out:
 	p = NULL;
 
 ok:
-- 
2.43.0

