Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013024.outbound.protection.outlook.com [40.93.196.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C4022689C;
	Thu,  6 Aug 2026 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027362; cv=fail; b=MJZWtOOTrgQ+MI4/TIGjuGPaad2sMHaQMAtrYEM6RD3WlE9uoGMcFoeKH8lPebdO/r899KV5FyfG35bNLXD37t07X9LyqhUn/usdQntu6srtVpDBV+7VVaUD2A3Gk5YJm9ktYXEFu79gBli9tkq7IQ1DMKICnAQ8at4VRmLRFMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027362; c=relaxed/simple;
	bh=L6OlYV9eBMJTx6EGwyGKDGG3ycFzokacADpfQoWUA1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hwdbt6SXm/HHZNPcsUC0iYeQOk15/BuWS0+GQBCyACKOAFBN+kcSul79Le5JEmty/UggPBcTJ22ozixBm7FFp4C20JjPZG30onQW7VEXeSBDZYAYSfBJDiGvIE3JBsosf6qtCH4rUDSEUgYFlYN/aoBcy0VbLxdPqI4yyRW1c6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cSnyKOjb; arc=fail smtp.client-ip=40.93.196.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cSnyKOjb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWRPBT58d7xe5uQlo4zfV5UrxcAVCV/+Bnq8FP/p7W4qAmGVX7ENIc1XPRBn29z4rbgeAHQwa254vgAHXOXkD08IJpBc24hI53ufEour14dILj+5ImbP6PyKxUdDxOwOCgEe7YXvtd1l/x3SJEg1dwFgCKOLR+3PwRPAH0ryME01NbIE2BkqbqCWMI7F/0eUIOn7oeGm7/754lGEm9HAdM7uWm2sZ8rvJrtdT9YJskw2PtbcYYJFlqj5jSCCFBSBBlRW0IvPfaKihUd2K7XeoltMQ+O+QUcdRwpWRtXM9buXt8hqaE4f08KDeD8LIXPevzhCuMj1NoB2JMJQICQ6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Sl9BQMXNGoAvVE/FIiKHIyypHZDF701muGUxSaI1ec=;
 b=XOLfqCHPDwjDuVYxKCwXNRb5smUrrwGfSCR600vxkVRzPtRkBSPlGDiXl3Z8RECN50TKb9kl4S4/AZdsENSyi3V6g5DLXkUL2Kcf1LMzvRktnwvWokhgmXLW+KQZqRUaePoI438rCeeYbZSjMyCbQDVjo/T6vR8ZxAx+OzXCaRAqiBIhGkJCn5iyEj1z7DLoo06uqOFLcBIzFYIfWkSiytM+3LsVTLJIMRu7fGCfUdkxh7howVn/QDC9Lu8LaY4yQ9/09P3hIUUX6GSqmuB0KOHvPPINUpWfuv0RPVG8GMm3gsPt7TSL3501BqwsdI6KVMXnrTVobAZnDmVC9q9kHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Sl9BQMXNGoAvVE/FIiKHIyypHZDF701muGUxSaI1ec=;
 b=cSnyKOjbn4KVTgP3O8U1SOGqSO0wzXKGb3Ll1GubkbbZNLgPnRqpSw6X+Svmf2nbFuwr/TG4TGakVFKc4uLqZZaLX98T3ukHAKu/FZLaTyyQaz0Gnh4sUyXYON12NTvfLluheisfPXedgtdL1Q24TTWWWNMtEX2tMBI/mBLvs/s2YPWjasNa/74YeoLNvVPi5OpBoOLdf7G6tBy/zIfJG5WUEaMCF2zVAWQpo0A9aKz4HiokewH0s8llRTj2Vra3ce3r04qXD8HIEdThYBTKIqlAtarJP84JjegaOKKDo/uSZ1JoJY2zQKeBSQm8kouxKsCVfpvgsSRyzkRq/9RueA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 14:42:37 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 14:42:36 +0000
Date: Thu, 6 Aug 2026 17:42:25 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] ipv4: fix use-after-free in fib_nhc_update_mtu()
Message-ID: <20260806144225.GA1940054@shredder>
References: <20260806133309.731709-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806133309.731709-1-nicoyip.dev@gmail.com>
X-ClientProxiedBy: FR0P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c99633-0c99-4cce-efff-08def3c8f4c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|11063799006|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	a2Qe4riOoyKIH2kAM8uRcP4JGJgsdoc47IXqV1O1n6b4/0mZt6kMaQDdZ+brPfRTYP+bOHLwB6as+v9lXBPnIjD3K1jjsOZwVa5dLOshKPlz68TXtw+60Z/emtTtnxpGNSfnwxaOLd83CL8DXdOVu3kKMymt02kQnXiA14rivoAOxjEI9iyx+co+kL/cSQ5HJhHo4j5wiAzVPAzoxQ2uZ4vFvWpMAx4ceoGZA67jagIh3xHJKQvoqrTv0oe2+hF4lL0OIOkTIR6MGHcNZV3NKC1n8aA1tZPSLmqSsQVT9CHIcLRhqKyl3G85JIemPTUDuk7xXTZEQPgIDsf9B6dIUvaRXUG2209+UJLHK8ir0ZS7kjc6v6iQYps8MPM2LJz1McGMfaM/ae4UY6Wuc03jolcgIRF+zZOJv17Rr/uq2X01WbQwwyA4+GhBAwyxva7PoWfW9sanflDrMt2/vuohh0qEtTMn3GgVplRYgRQskjl5cqwKN9fdqyFK11OXwU5gJjHNIsNQHzshmIIoMJpOALgCqKUR6OoxmPZ6/ND2+qcFJXt+Qyv1fPVcgHGUcfTL4IqhILuoiFfgRHKbkXeohOG7NUxEanQb4GzpGrw7HPIL1vvaM5lFVZ32w8GtdJqecoaCalDRbJWy/Srz9NplClpbi7nxFQDRVO6/EI+rl48=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FMI3GF4eLuhAVvWnSlwGY6vPuKU73/++kR1wNufY+/foANinjXxVZpNeTKOw?=
 =?us-ascii?Q?v0MdbCH/0S+ZHKtkFSezMhWCCIS6s09omU75iz3xe6WKQNfnvBT50/ADuYgg?=
 =?us-ascii?Q?L88gljffHg37Z5LYs7329Jl46/Tm+yFnC8/FVd2wzw0VIZE7qIHS4pQDNKgH?=
 =?us-ascii?Q?wPfqDFTJ6Smc2xBnkAqvrKnaEB1xG0A39EtHENORp0IWplHUK18Y7S/suhbr?=
 =?us-ascii?Q?bloj5irpfDHUvGppjnTwnVUwHJCN6udqwPqB4z8DDJ6w6QtbtjMKNdAiFrky?=
 =?us-ascii?Q?rFreuQFnrNoDaP78umarm0+9tNX/qYwDAcxV1RVI8ZbZ+pgtzS0aqfDZfWN8?=
 =?us-ascii?Q?N8meKKKIvVKgnG1YjXbDNtCtWZoOXqbhmwN5TqVmeI5eP1d/R4pNLJcmdAH5?=
 =?us-ascii?Q?4Wt9OosrbBrWzDDHLpkTCv3NEArCfSz1gNWbPrBXeaQMQqgT10azGwdxEq1P?=
 =?us-ascii?Q?hbQACuvAyukzs+uST7u8KQz9f/cHXj3iZDUbCGGh+Z5A8JSpUkhOVPghvPet?=
 =?us-ascii?Q?bxcd3GIT25Lapy24lXkn7Tfzk4uqp4/vUIavjhmIra765q/Z4QK+jyvF21y1?=
 =?us-ascii?Q?KFyvi2flV5pfPJFvk4zpC83yLiddp7U2QPDhKgbi40QhszJysow4T3cU9X6K?=
 =?us-ascii?Q?8Fg3HXznLayLyICvSjpjfgt7/8Pn10Pnl9xmzKSogT4gdPzbWsFVjqKeGvTV?=
 =?us-ascii?Q?eNUflDfb4oEwtojyIaAHada5m5aCSDVcnIk+QAgx0Gy5UdsFfppU7wQ4eksg?=
 =?us-ascii?Q?WLZyYMG6DrVj36ccRU1zFtFw0rR/QN7wHNQilQ5FYtrBIU3vRZ+C53KyvZzh?=
 =?us-ascii?Q?RTG0nZ3TGkW4aLdqmtLSw6dYFq7ZUChP9n6l253JSI7r/LpBbfvq4pHnOHsI?=
 =?us-ascii?Q?EAcQb0ubZJMKw3+oLN7sDVf3OzLWWScD9e/rMch2fw5WSKMOt2tUIqlwz8zQ?=
 =?us-ascii?Q?xdGuXNmIINGHXqbBTgAZksyEQVlU06/FUDfGzMnBDXaHUJOn85h8lR0puc2W?=
 =?us-ascii?Q?7VTeddJARvJupvWMhZDvP7/xD94MpPAIkUKSsfc4MusRcATbD+QrH9LziD1L?=
 =?us-ascii?Q?cgC4VLuzMAwszGy8A58LVC0M+taTxEYOl6lOguJ31hD9gEMS/8gqAkrDWEpO?=
 =?us-ascii?Q?XHuoyGgpz9LZx6oCimOVwPGNDvw7q4t3z8B4fI16aC2vdigd36hHGyHhrQPY?=
 =?us-ascii?Q?K2kO79ujDzHcBaasg3lsazxg24speQ7JMev8Dht9KrH06Hs3uu+XcOjNdB84?=
 =?us-ascii?Q?KJMcL8eQEd+mMkqCsIdDzPVG4VYn2bANCidQEJEh+DMxFC53dRHToDzuUt+H?=
 =?us-ascii?Q?hefOPccj/bOP3eQ2Nn91jGDhDnAatlj9D/Ua5xaVX3oCtK3PQloKUwR+8lpE?=
 =?us-ascii?Q?91vGK/FUiDRZtqsv6ROZSsVq1ahZfHDi2+iWznx+eMsD66DJ+2AkeEWm3kaM?=
 =?us-ascii?Q?A+Cq2BJN3C6pR24hoO45FHv2ZmPWa4yk49/+is6/Zy6IKJB/XyQIiJb3wh1L?=
 =?us-ascii?Q?cPqCsvIxjlMsfR9eFukOCH2K03WIBoH6+/3GbLSZaUaBzYHT/42q58Rmhtex?=
 =?us-ascii?Q?ij0aETtDDuCmrLdNjfII7fJgA/6i8VxIUduZ5Qq9zOmnQ9feCadGSwe3gemg?=
 =?us-ascii?Q?tGsIdkMWPnZshxmPlYNwbPIKuifja0yD6nUZmCzeMBBU4s4qvcTeB2siHifL?=
 =?us-ascii?Q?6lfLZZlDk2qGbTVhkyuzH68nLYV4bcAaF/ZqeY2fASublw3pLPevJWyvQmD3?=
 =?us-ascii?Q?0hlDI4zBKA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c99633-0c99-4cce-efff-08def3c8f4c7
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 14:42:36.0904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+BVYluFeeQBXdc/TJ+/FqwzJituoE+rZdvc6bvyvJLM3/e4zStJLM0KsQ7stO6rB6Zu7k6OcmiclUcv9QcEEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469

On Thu, Aug 06, 2026 at 09:33:09PM +0800, Chengfeng Ye wrote:
> fib_nhc_update_mtu() walks the nexthop exception table under RTNL, but
> RTNL does not serialize this walk with PMTU exception updates. The walk
> uses rcu_dereference_protected() with a constant true condition without
> holding fnhe_lock.
> 
> The following interleaving can therefore occur:
> 
>   CPU 0                              CPU 1
>   fib_nhc_update_mtu()               update_or_create_fnhe()
>     load fnhe                          spin_lock_bh(&fnhe_lock)
>                                        fnhe_remove_oldest()
>                                          unlink fnhe
>                                          kfree_rcu(fnhe, rcu)
>     <quiescent state>
>     access fnhe after grace period

[...]

> The same walk updates fnhe_pmtu and fnhe_mtu_locked. These fields form a
> pair and other writers serialize them with fnhe_lock. RCU alone would
> prevent reclamation, but would still allow concurrent writers to leave a
> mixed pair.
> 
> Expose fnhe_lock to fib_semantics.c and hold it across the exception-table
> walk. This prevents entries from being unlinked while they are visited and
> serializes the paired PMTU state updates with all other writers.

Looks correct, but can't we use RCU for the traversal and only acquire
the global lock when updating an entry? Otherwise, whenever a device MTU
changes, we acquire the global lock (and disable softIRQs) across a scan
of 2048 buckets and we do that for each nexthop using this device.

How about something like [1] (vibe coded, compile-tested only)?

It also avoids exporting the global lock.

Please wait at least 24h before posting v3.

Thanks

[1]
diff --git a/include/net/route.h b/include/net/route.h
index f90106f383c5..45290177a33c 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -276,6 +276,8 @@ int fib_dump_info_fnhe(struct sk_buff *skb, struct netlink_callback *cb,
 		       u32 table_id, struct fib_info *fi,
 		       int *fa_index, int fa_start, unsigned int flags);
 
+void fnhe_update_pmtu(struct fib_nh_exception *fnhe, u32 new, u32 orig);
+
 static inline void ip_rt_put(struct rtable *rt)
 {
 	/* dst_release() accepts a NULL parameter.
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 4f3c0740dde9..61286948c5d9 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1864,42 +1864,30 @@ static int call_fib_nh_notifiers(struct fib_nh *nh,
 	return NOTIFY_DONE;
 }
 
-/* Update the PMTU of exceptions when:
- * - the new MTU of the first hop becomes smaller than the PMTU
- * - the old MTU was the same as the PMTU, and it limited discovery of
- *   larger MTUs on the path. With that limit raised, we can now
- *   discover larger MTUs
- * A special case is locked exceptions, for which the PMTU is smaller
- * than the minimal accepted PMTU:
- * - if the new MTU is greater than the PMTU, don't make any change
- * - otherwise, unlock and set PMTU
+/* Walk the exceptions of a nexthop after its first hop MTU changed.  The
+ * chain is only RCU protected here, fnhe_update_pmtu() takes fnhe_lock for
+ * the update of each entry.
  */
 void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig)
 {
 	struct fnhe_hash_bucket *bucket;
 	int i;
 
-	bucket = rcu_dereference_protected(nhc->nhc_exceptions, 1);
+	rcu_read_lock();
+	bucket = rcu_dereference(nhc->nhc_exceptions);
 	if (!bucket)
-		return;
+		goto out;
 
 	for (i = 0; i < FNHE_HASH_SIZE; i++) {
 		struct fib_nh_exception *fnhe;
 
-		for (fnhe = rcu_dereference_protected(bucket[i].chain, 1);
+		for (fnhe = rcu_dereference(bucket[i].chain);
 		     fnhe;
-		     fnhe = rcu_dereference_protected(fnhe->fnhe_next, 1)) {
-			if (fnhe->fnhe_mtu_locked) {
-				if (new <= fnhe->fnhe_pmtu) {
-					fnhe->fnhe_pmtu = new;
-					fnhe->fnhe_mtu_locked = false;
-				}
-			} else if (new < fnhe->fnhe_pmtu ||
-				   orig == fnhe->fnhe_pmtu) {
-				fnhe->fnhe_pmtu = new;
-			}
-		}
+		     fnhe = rcu_dereference(fnhe->fnhe_next))
+			fnhe_update_pmtu(fnhe, new, orig);
 	}
+out:
+	rcu_read_unlock();
 }
 
 void fib_sync_mtu(struct net_device *dev, u32 orig_mtu)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index fd688e1f879f..604cc51dfd9b 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -741,6 +741,35 @@ static void update_or_create_fnhe(struct fib_nh_common *nhc, __be32 daddr,
 	spin_unlock_bh(&fnhe_lock);
 }
 
+/* Update the PMTU of an exception when:
+ * - the new MTU of the first hop becomes smaller than the PMTU
+ * - the old MTU was the same as the PMTU, and it limited discovery of
+ *   larger MTUs on the path. With that limit raised, we can now
+ *   discover larger MTUs
+ * A special case is locked exceptions, for which the PMTU is smaller
+ * than the minimal accepted PMTU:
+ * - if the new MTU is greater than the PMTU, don't make any change
+ * - otherwise, unlock and set PMTU
+ *
+ * fnhe_lock keeps fnhe_pmtu and fnhe_mtu_locked consistent against
+ * update_or_create_fnhe(), which sets both under the same lock.
+ */
+void fnhe_update_pmtu(struct fib_nh_exception *fnhe, u32 new, u32 orig)
+{
+	spin_lock_bh(&fnhe_lock);
+
+	if (fnhe->fnhe_mtu_locked) {
+		if (new <= fnhe->fnhe_pmtu) {
+			fnhe->fnhe_pmtu = new;
+			fnhe->fnhe_mtu_locked = false;
+		}
+	} else if (new < fnhe->fnhe_pmtu || orig == fnhe->fnhe_pmtu) {
+		fnhe->fnhe_pmtu = new;
+	}
+
+	spin_unlock_bh(&fnhe_lock);
+}
+
 static void __ip_do_redirect(struct rtable *rt, struct sk_buff *skb, struct flowi4 *fl4,
 			     bool kill_route)
 {
