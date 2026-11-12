Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794456306;
	b=MGpa84KH8vSTg9UBTmznCmrNx1l6unm+Pfft8eqrOkZsvQ7kEf89M1s9IVqPzJz9xGqb
	 4H7nsn5G8suUwLgNqAZuhN8obkWMx6w/jcmTX2ypWgZiSBWdAB4lEm6LrOVDIUNVqxzm9
	 GHMmluYA56/oymgzsv0ssVtZUOqud55dZjW9sgvqt174bdLCySz0R1tTN4l61eyonlR4D
	 2VeOtOzDEoS640vXCZTR8UG0QULoTv91GyFy8vLq2H7pHMRGNp16GjISTovJE8R8VTKB2
	 Ho4+Ju1gTwpmoVV3s+/scJvJGNm7nAIa0AJ102mUKzUHqC47L9SQPPzlkBhJqLmi5AQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794456306;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=VOG909xrB5nI6JfJ6FHZ8iy3mqrneiDcQ4SeUiHtY4I=;
	b=INy86ICLDsKWDLXA6Rc/ya/OUHAJ26bxxrYWvkaSpkUsdtec77meBBf58QhbwtBX1e+L
	 14DUylzP8OOEK3mQfFMTKZfwQdJJ5c2yhYXC2BvGgthOUNDCywdz2ZmCfK29PtC+XkaRo
	 j+z6YBakiAiKyWcmA1MSyu7czhKy46MHrY0AO4Falt3Xk90wPVWvYYuWmOLXVO9kCHC6r
	 rNtU32dxDvDxOpFhtc/0eTMddyhyhIxYYOf1BByjIfLeQYTR1NI7vWNKUOltcmm2yynjz
	 LW3/gHtJfrRNakP1SRIEKI6OTU5KjaofJwN8n5uEApiEcRrAKI7WXoH50KWPJN6uvFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PWFGvZZA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.7
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013007.outbound.protection.outlook.com [40.107.201.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF00606A323;
	Thu, 12 Nov 2026 04:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCF00606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PWFGvZZA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxYZpINhiS0P6N01IDx7POg9EG7TNWi1oYmQIeoV2eseX1L0oMW0YpGexTpP+TxhcEB1pbQ+qHZ6utF8py/0SzfvW02vY09x3GsMxwrwTOr0+h8cp+RGfB5LHX4qX27vymkrABk7kASQ6IqHTtwsSgW4nflESPSI8FZ7sBy2leKhEYn4rbUYFSFpvev/sU/eINfuHf9l9t+GM6klAtQdXPCOjxiuH41zwAobXHqZmI+Ay/boZsplc73sNOhENKk4YR/NkkXB+K0DeITWKLKyyKLMziW7KirE5MyBTIg4BjOdgTT0oMmF2aSovz34Fl1j3TX0Pr0+ERG+DB9zHQJgYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOG909xrB5nI6JfJ6FHZ8iy3mqrneiDcQ4SeUiHtY4I=;
 b=FvppzOAhARs9F+Q4j7oRvnGGfHgsHpvbqKoDAxnOXL6vmtyEfmaMAigl+EFHqDGiLBQijVIre9b7bMKMd8CX7QRAq/pHsMG7di+W5ghWlIPsqtTwlXVifB4fVWouEZoFa8OOUV15GzyoG9gYAlmZKwarKpe2Vkw3va+j8k9xAPIeTY3zrht23qYCH8XoSWR8x+44nGIggnrioQjwyFB4us+Ce2iyGzlTHQm6Tvs/lvwC7v8tZ/8xBU6TOkz7Ze1B4e7+DGdfYtrQN6lHRzfOZFXCWGUkgr3rrp8kp9OfUOW4xse53bloo9yNZEKdJK+KRecVk+UQ4+BhUf31zagbBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOG909xrB5nI6JfJ6FHZ8iy3mqrneiDcQ4SeUiHtY4I=;
 b=PWFGvZZA/JTUrITohb/IPbNo3ZMrgkDN7tku7CKbauwSQAlIZAZoV1PE1E3KuWL7kvLlMA4YICsZxX19tVxR9+wh4R3p1jPAhi/p63WfupoRK353PINC8K5bIYdukHpyR+61uHS9F7+ZlLO1zkU/cvtj2CAR5c8TiGecVKNYgJ4=
Received: from MW4PR04CA0293.namprd04.prod.outlook.com (2603:10b6:303:89::28)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 04:04:53 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:303:89:cafe::63) by MW4PR04CA0293.outlook.office365.com
 (2603:10b6:303:89::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 04:04:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 04:04:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 22:04:49 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 22:04:48 -0600
Received: from [192.168.0.152] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 11 Nov 2026 22:04:37 -0600
Message-ID: <81841052-e524-4263-b09d-9cf823ed9728@amd.com>
Date: Thu, 12 Nov 2026 09:34:36 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] mm: allow shared folios to be promoted to a fast
 tier
To: "Gregory Price (Meta)" <gourry@gourry.net>, <linux-mm@kvack.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<akpm@linux-foundation.org>, <david@kernel.org>, <ljs@kernel.org>,
	<liam@infradead.org>, <vbabka@kernel.org>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <peterz@infradead.org>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@techsingularity.net>, <mingo@kernel.org>, <vschneid@redhat.com>,
	<kprateek.nayak@amd.com>, <ziy@nvidia.com>, <baolin.wang@linux.alibaba.com>,
	<nico.pache@linux.dev>, <ryan.roberts@arm.com>, <dev.jain@arm.com>,
	<baohua@kernel.org>, <lance.yang@linux.dev>, <usama.arif@linux.dev>,
	<kas@kernel.org>, <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>,
	<ying.huang@linux.alibaba.com>, <matthew.brost@intel.com>,
	<byungchul@sk.com>, <apopple@nvidia.com>, <jannh@google.com>,
	<pfalcato@suse.de>, <hannes@cmpxchg.org>, <osalvador@suse.de>,
	<raghavendra.kt@amd.com>, <stable@vger.kernel.org>
References: <20261110150446.2452975-1-gourry@gourry.net>
 <20261110150446.2452975-3-gourry@gourry.net>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <20261110150446.2452975-3-gourry@gourry.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6889a3-869d-49ec-e088-08df40721aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|23010399003|82310400026|11063799006|4143699003|56012099006|22082099003|18002099003|6133799003|10067099003|261009223027099003|3023799007|261026140227099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|261026121527099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	qP/yDsPS6rnC3yMbaBhJ3tZI5qIdP/jGpRNPktQvfCt3sGlPnppV+b478rptSXcqAolPw+kfGhHXWqA3nIKINqFo+vMqtuTOTXvEqBCLZ9kbi1QLDmMRiqb758YaK2OctTQUAzhbeFGRc5Y9MVnJoNJHa2oB5tL59ahfP0RnPeShaji1LxEIN7ccC1nXL3xlClkMXGwFJ3kiryw6QimDS9jmIQMTmEbCQM1RSSBZ594HGcD6pQpBLkqiiC1dd0DCVlGqxluETwc+pUS9o5QgxcP5nmkCmXqmglOsGNkvoIpHQziwjOaKa6TKygPF91a1nuk8PiCexsHGaNOzDJwmdRLemkhOmWUVUY+Q/TPhWRSW7J+CPqmPPQK3eVPkitUvx6TVK/Au4+KkZsra7C1/5UJBTpauBle294K+ygyV77K3TNeQ18J7AoaiuJRksUPuO2hOaJIDXRr0vX1Vd40oYSPIG26P1AfU3t8h0f0JmxFEfnHlOfdJlTDwiV4QNolNpR0B+iifiziKGI1sQtWzJUGoEIr/u87h7rKAPUPkFRGSHbbj3aYRcKwEe11v1aBS0K1pMf2QRCqITPolE768WyH/24UzmfzVreHxCCfFtDzEUWY/OfidDHFHqUm/jM+NkFJNLiiYpmDOT0vUHSpFVpVLWkNKRNGnMfYdLnfDFWs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(23010399003)(82310400026)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(6133799003)(10067099003)(261009223027099003)(3023799007)(261026140227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026121527099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	du1QzS+6PGyEcUPBEmAw0XRqa5f/XVaB96b3YyAuJUnIrcgZGVHfzYGLaPVYwUsMiPiK5N2ZQVeCd+GUAoey/9yX23AY3zkHd8ohwljrJN4nvg5G65HNshliVq8qiaZ9C+75dlyseosH1JBePiSsoPUbqfAnyoCubohzBJWAG4ZBbL8kOATjdinI9YK5Dnv3Hd8M3wWIAGubPh3D8eiQZqiIzsRh38FlD1UfJrSRaBpQRyTrqWhkQWTx+pb7KgdmjxqwEBNPunWTPiK8cUWS80/iL33CV1PJZ2TBdPA9zM4ECnrBwUL6Azg0rsCps0HJRNVUdMjpXCvRsZkaJyXCQVrsCbZnxRpBHffwyp4xzAksntCrmXSoV35bTV6Pfpy1nn1XPWEt23artFbaATs4Cv2syIbf6YHjJlIhmeaSR/NCEEqi6s7S+xjpp0IEo+nC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 04:04:53.1193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6889a3-869d-49ec-e088-08df40721aee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375

On 10-Nov-26 8:34 PM, Gregory Price (Meta) wrote:
> NUMA balancing rejects shared copy-on-write folios and executable
> file folios mapped by multiple processes to avoid east-west
> migration bouncing. These checks break promotion from slow memory.
> 
> Allow such folios to participate when the folio being migrated is
> a low-tier folio and the destination is top-tier (south->north).
> This allows promotion, but prevents east-west or north->south
> migrations (north->south is handled by reclaim demotion).
> 
> Keep the existing restrictions for ordinary placement and for
> migrations that are not slow-to-top-tier promotions.
> 
> Rename folio_use_access_time() to folio_numab_promotable() so the name
> captures the combined memory-tiering and source-tier test. The helper
> retains its existing behavior.
> 
> Fixes: c574bbe91703 ("NUMA balancing: optimize page placement for memory tiering system")
> Cc: stable@vger.kernel.org
> Suggested-by: Zi Yan <ziy@nvidia.com>
> Link: https://lore.kernel.org/r/DLHS4KFPQ86I.1J4LN3352RI71@nvidia.com
> Assisted-by: LLM
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  include/linux/mm.h  |  5 +++--
>  kernel/sched/fair.c |  2 +-
>  mm/memory-tiers.c   |  9 ++++++---
>  mm/memory.c         |  2 +-
>  mm/mempolicy.c      | 11 ++++++++---
>  mm/migrate.c        | 13 +++++++++----
>  6 files changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 40de653041f92..55817dea7307f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2647,7 +2647,7 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
>  	}
>  }
>  
> -bool folio_use_access_time(struct folio *folio);
> +bool folio_numab_promotable(struct folio *folio);
>  #else /* !CONFIG_NUMA_BALANCING */
>  static inline int folio_xchg_last_cpupid(struct folio *folio, int cpupid)
>  {
> @@ -2701,7 +2701,8 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
>  static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
>  {
>  }
> -static inline bool folio_use_access_time(struct folio *folio)
> +
> +static inline bool folio_numab_promotable(struct folio *folio)
>  {
>  	return false;
>  }
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5d3d7b61d0257..e353d3d3012ea 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2877,7 +2877,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
>  	 * The pages in slow memory node should be migrated according
>  	 * to hot/cold instead of private/shared.
>  	 */
> -	if (folio_use_access_time(folio)) {
> +	if (folio_numab_promotable(folio)) {
>  		struct pglist_data *pgdat;
>  		unsigned long rate_limit;
>  		unsigned int latency, th, def_th;
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 7fc56a8c66518..0df54dc556f19 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -53,16 +53,19 @@ static const struct bus_type memory_tier_subsys = {
>  
>  #ifdef CONFIG_NUMA_BALANCING
>  /**
> - * folio_use_access_time - check if a folio reuses cpupid for page access time
> + * folio_numab_promotable - check if NUMA balancing can promote a folio
>   * @folio: folio to check
>   *
>   * folio's _last_cpupid field is repurposed by memory tiering. In memory
>   * tiering mode, cpupid of slow memory folio (not toptier memory) is used to
>   * record page access time.
>   *
> - * Return: the folio _last_cpupid is used to record page access time
> + * If memory tiering is disabled, then lowtier has no appreciable meaning,
> + * so we return false (the folio should not be migrated on this distinction).
> + *
> + * Return: true if memory tiering can promote the folio.
>   */
> -bool folio_use_access_time(struct folio *folio)
> +bool folio_numab_promotable(struct folio *folio)
>  {
>  	return (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
>  	       !node_is_toptier(folio_nid(folio));
> diff --git a/mm/memory.c b/mm/memory.c
> index d477a4f986bc8..e70885653475a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6262,7 +6262,7 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
>  	 * For memory tiering mode, cpupid of slow memory page is used
>  	 * to record page access time.  So use default value.
>  	 */
> -	if (folio_use_access_time(folio))
> +	if (folio_numab_promotable(folio))
>  		*last_cpupid = (-1 & LAST_CPUPID_MASK);
>  	else
>  		*last_cpupid = folio_last_cpupid(folio);
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index f0933e9b209c9..49cfeab501b4a 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -866,8 +866,13 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
>  	if (!folio || folio_is_zone_device(folio) || folio_test_ksm(folio))
>  		return false;
>  
> -	/* Also skip shared copy-on-write folios */
> -	if (vma_is_cow_mapping(vma) && folio_maybe_mapped_shared(folio))
> +	/*
> +	 * Shared copy-on-write folios are poor east-west placement candidates.
> +	 * When tiering is enabled, folio_numab_promotable() identifies a
> +	 * low-tier folio that needs a hint fault for promotion.
> +	 */
> +	if (vma_is_cow_mapping(vma) && folio_maybe_mapped_shared(folio) &&
> +	    !folio_numab_promotable(folio))
>  		return false;
>  
>  	/* Folios are pinned and can't be migrated */
> @@ -894,7 +899,7 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
>  	if (vma_is_single_threaded_private(vma) && nid == numa_node_id())
>  		return false;
>  
> -	if (folio_use_access_time(folio))
> +	if (folio_numab_promotable(folio))
>  		folio_xchg_access_time(folio, jiffies_to_msecs(jiffies));
>  
>  	return true;
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 28a8d7734735b..50a0a2e11a353 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2704,14 +2704,19 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
>  
>  	if (folio_is_file_lru(folio)) {
>  		/*
> -		 * Do not migrate file folios that are mapped in multiple
> -		 * processes with execute permissions as they are probably
> -		 * shared libraries.
> +		 * Limit east-west migration of file folios mapped in
> +		 * multiple processes with execute permissions as they
> +		 * are probably shared libraries (limits bouncing).
> +		 *
> +		 * If this is a low-tier folio, only migrate if the target
> +		 * node is toptier (this allows south->north migration while
> +		 * disallowing east-west migration between slow tiers).
>  		 *
>  		 * See folio_maybe_mapped_shared() on possible imprecision
>  		 * when we cannot easily detect if a folio is shared.
>  		 */
> -		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
> +		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio) &&
> +		    (!folio_numab_promotable(folio) || !node_is_toptier(node)))
>  			return -EACCES;
>  
>  		/*


I am carrying a patch in pghot patchset to base this shared folio check
on @vma, in the async migration case where VMA won't be available to check the
exec permission. The effect of that is to allow promotion of shared exec folios.

This patch achieves the same in more direct manner.

Reviewed-by: Bharata B Rao <bharata@amd.com>

Regards,
Bharata.

