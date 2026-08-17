Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012051.outbound.protection.outlook.com [40.107.200.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440B742643C;
	Mon, 17 Aug 2026 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985144; cv=fail; b=XJe3nl7Ung46FQd+DCEv+8CneQ4odnmMUoa6pqjAGZgpl9w4Ui9N0q78rlNLZ8+OPqZuwqoRbE8+G5i/bG84CKxtCdP5di3cTbpc/NXofVEB1JqYUuBMPslzVTs6LOT9mYO0ce7x3tJHxZNvAUMQZQaa8Wul5Zrl33J7SpmfWiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985144; c=relaxed/simple;
	bh=ftsSD3XUqR8K5ifb2ti5TOvOBdSldofNalAK6F5+r+I=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aRDmSK3dhNaI2i36/RQthK1UA0SI4E6McmRY5mFYnU3qXWltNemG+1uAJN52CHC3gfQ1g59I2EYgZdoKpPP8JjvRtjtXqPQv9vIUc5NqQUQeNKZ5CFQzpZce/1iO5M332kVImC/QIaYc5xewE2dJiWsDqcSs/1Fq1bcRvzOS3Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5UDd4T00; arc=fail smtp.client-ip=40.107.200.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5UDd4T00"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecsv21WmfmaPtj6krnVlEBJDVn412C2vL7ZrK9byTp6+RWdlJcBBgjpDDf3fnplqvu6STqqiBiqPNWs1QJiyB42h5N5C26VJWFdb0Fb97XtvLjpiEu6p0vXR/OQ0Aa9MOhYK5AfSyKxHLvMdyvWHp14a/1Sc86RC3P2YRJVjGIi0buNGPlGGXiE8P7eF01GnY4A72JUc7oyTr5WdXksSq0W+qF1sstH3B5GUi49+20GNbw6Qs1qXnfacox6aTDFsdibYscbXOAXGCbIOR0Y4t7+wCCqMfUUTUVRiiMo4OU190LwoM+EFIkENStR/SbqWCbEsvO0PlwKwHB9R9jmB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAkd7IUZSuDUxRUNAHACGaPV1VxzlhB2lsYps2B4Mm0=;
 b=rL45JwJhgwSdQU5FJ9m/zsYMyaPmM7LAxhGnhu9Kxexcnvv4ZEPtL/J5rokGDzXAOzd2r1GhYCcI4gjWzV+QoBWHjPzo1+Oj27UzMh11cwYUIJ2o2LaSqmgYzrN+ifl6kKXiW+uph9BzMrZNxpW0SNuijkI7FRVo2IGsvTXyreY6OSRETRHTykIuXg3kNAMrW/sRKVvQabMZmfYhK5U2GbyfsEu52263atvSm3ZiZZKFUjVkmuqcYOtXgV0DYHT4rujLdPrmKDaaXc3qsCcaXIJ0gnuy1Z6m1HTCWiaEuOVdCqIPm2fPvbA3QwIttbGUVtFqJub+dMmN7+A6BJkDBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAkd7IUZSuDUxRUNAHACGaPV1VxzlhB2lsYps2B4Mm0=;
 b=5UDd4T00jivw/Ca9HjimSDJyLwq6yMN7t2cEfK9cEO6hxYB5ExZLpCSvEQ3Llwh49RXbqBzLr5g84Suz5cmyHO6NwhIc3ghbzpGTD2lySy+MW+KUZB7nWylj+NQM/RN1i4N4BqaqjkzC4b5mJU1HRYvxHPKhU7ywhEoubMPRkPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5389.namprd12.prod.outlook.com (2603:10b6:5:39e::8) by
 SA1PR12MB9471.namprd12.prod.outlook.com (2603:10b6:806:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Mon, 17 Aug
 2026 16:45:32 +0000
Received: from DM4PR12MB5389.namprd12.prod.outlook.com
 ([fe80::1f4e:98f9:2c94:8e4e]) by DM4PR12MB5389.namprd12.prod.outlook.com
 ([fe80::1f4e:98f9:2c94:8e4e%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 16:45:32 +0000
Message-ID: <a2054afb-31a9-41c5-b27a-7c70d382a10d@amd.com>
Date: Mon, 17 Aug 2026 09:45:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net/ionic: avoid OOB TX partner lookup for
 hwstamp RXQ
To: Anand Khoje <anand.a.khoje@oracle.com>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Abhijit Gangurde
 <abhijit.gangurde@amd.com>, Shannon Nelson <sln@onemain.com>,
 Leon Romanovsky <leon@kernel.org>, Eric Joyner <eric.joyner@amd.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Kees Cook <kees@kernel.org>,
 Mohammad Heib <mheib@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260813083705.454897-1-anand.a.khoje@oracle.com>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <20260813083705.454897-1-anand.a.khoje@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::19) To DM4PR12MB5389.namprd12.prod.outlook.com
 (2603:10b6:5:39e::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5389:EE_|SA1PR12MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: 872ecab3-d5aa-495c-4c9e-08defc7ef3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|56012099006|10067099003|921020|11063799006;
X-Microsoft-Antispam-Message-Info:
	YlYArZHqaJhAx1HiS6+1LoTdR+ixTj+tcu+HA7aeM2CbueHPrC6AmxukXSl31qfkSv51Axj3Qd8XqGZLUixAuZsZOznPJiyO2xzyGquR6XN2J1KnUI5PgCfWwbw2SRkwBN4Qm3PzKAtq6nlZKi+VtUDmFoyBQrgWN0+7yTpK5BH6z/vjJX/1yY6qTmgwJYleEjftLzzfyYJlqIueRnzOA3JXQM4YdJqekUO4hvjMKMXpRVqT7plEdd0xEFfsYntS/HW0u6PFWkEys1gkqCj+8lVbpFn8jLWx8DKHb+Pgql53kAe1OLkhlcKNISKgOvBkFW9rotK7uGi/BFlsiij29qPqcvINa+LuA0CxUEyjTWLKUP5QyObiOhGY9L920pj+mPEiyJdUv+lBohWWqJHAKeI9gdI2S0pnRO+AFiKnzB+hQ0bliFxqM5k88LVJiRL7DhOPTgPxxFiH9vBI/utNw2gtjOwkVfyIi+1sXwQCnwy5Dij5SjP8c5tWMzkvvKYraRQcqWIoGSypQRmhnosMzFyiq6sy2KlbCd2SMxLRwkyyGUKZHMUe/W8rAStw/dJBDZjWjLgXErCjvH2vv4HGVHUmz3jAAlh+S2qLnDS2w9VMZW7uUVkOgd3rGiNKv9xavIZLZaVteM+PLbEUJ+FnoU5CtTtWm0Y6YLv/vgnPEYVhwXSbHV0R8CqEZ5aw2bhePRrOpAPvQNMtzPOjvjaP6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5389.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(921020)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnkxdXI5UmNjN1FTZFo3MTRqT0dNUVlLZ1phVm9zQndmZ1diQW4rZW9reFRD?=
 =?utf-8?B?dEQwd0hZTUdaQUxnRk1JM3JCbFhwVnlqZFNabmRJN3U1T1J3bGVMTC8zTDU0?=
 =?utf-8?B?V1FYTXQyRjRVcHl0SVNnMDNpZFNTNTllUWZXTWNMOGphSm96RjM2RnljY09W?=
 =?utf-8?B?S2prS01jbnliYURPT0tTK2hmVzNvVFlBK3RGTDFSRU9NYXEwLzhPbDBsLzhS?=
 =?utf-8?B?OXJ5QnZ3cjlzU09JRzNHYWQzNWtzRFlEYXB4cmM3UWlaTjlLMlh1SnVJMCtm?=
 =?utf-8?B?WUpnS0VmVFRhYkx1VTJJZzM0aHdCc0F3eVBDWng0ODRndEZNSWN3SnlXZGIv?=
 =?utf-8?B?VXBrL1M1ZHVmS1FDVFhDV1E1SUNmOEZVTktwM09GMTJSbXhzbkl3OHoxcllu?=
 =?utf-8?B?MGo2YU9GREhScFVXZ1JvOHNmQVhWb3l1N0daRUROV05qVHZ3UFVleUdCT29o?=
 =?utf-8?B?dFhwbXMxR3BFdDhiZ1dyUEcyT2JIR09wOG91RXpEU2VrakxuSTVCRlhGQkxU?=
 =?utf-8?B?a0ZOSTNKdlBZckNyNEM1ZDdhZTY4dWhLVzhPcnNRZkFLYk4rQU1oM05VVWdQ?=
 =?utf-8?B?d0RWS0VISSt0dTRQVGhIU25tWFJ5TytUTnE4RXhmQ08xVTUxS2IrbnhHeEdw?=
 =?utf-8?B?QTZTNnpGeXFKdmVhcjNtdmpVL2R1dmUyL040Y1ZaS2dYdTRpNGZLYlJZUXVu?=
 =?utf-8?B?VU90eHVLcS95Q3FiUVRsV21pR3BSb2FCQzduOG4vRmFhSEJjdzJHWUc1OWQ3?=
 =?utf-8?B?VWE3c0JMOGlsdG40a2h2SHZaMFJEaFpFcGdzL0lzMlpYYmVSUXJNZjlrVHZa?=
 =?utf-8?B?U01IcEhleWE1NzRMQW1WcVpXM3BPcnpKbGRKUGRDdXFGVmxUSEg2dmNBUUpo?=
 =?utf-8?B?RUU0TjVTcXcvdnM0cituWktHQzNwTkZUWEloK1VQeXR2cXE2Yi90Z2g0V1Y1?=
 =?utf-8?B?VlM3aFQ3Z1NBYjFWMG12NFJFL1FOQUJBbUk1R1ViQXl0aFU1eWl1c3dZZTB5?=
 =?utf-8?B?dFpOVE16Sm8yU1FmKzhyRk1jR3M3VlVJTzJjTEVwU1M1T3VhWDI4SFlVbUts?=
 =?utf-8?B?ZVF4eVFzamw1d1lBRDNmM0JkSFh3UkRNWEtWZnlNQTlMakxpOW9Zd1plMVNG?=
 =?utf-8?B?MkRnQlBNdVJYWVErRGdMWWV5SFkwbmtHTDQvcWlQaHZhMEowTXVRWEp5dENU?=
 =?utf-8?B?TlJYc1V0blhTODlUWUthNlpSQndheEQ5K2E2M09zZ3VsWG5NVjVJK2ZRek5t?=
 =?utf-8?B?b3BlVUpVeU9LMlZPdytnZStQK29VYzZVTlBxRm9EenpXaEVRQURqa0RWSmQx?=
 =?utf-8?B?aE9RTGxRQ1pmWVdHeUtSOVpnMXNlL21YWFE3cDB6dlFHYUowYStiWnUydzJn?=
 =?utf-8?B?d2ZoblhuWkE5YkdWc01qTWI0cFdxMnlUUGtrQng4eGxKV1ZuT0FNTjdQUlFr?=
 =?utf-8?B?TlVYZnd2VEFhcUpQZW5lZG80bUxqNmc3Zzd6eEpzU0c4SnJ4bENnNVFwK0Fm?=
 =?utf-8?B?U24wS3c3bHF1RTVGZDVQbERxaURSSytxZXppSE5LMzEwWnBOUGpEdXdJMGpF?=
 =?utf-8?B?eFlKS2hZWTVvazMzaG5QTm1hWTNaMDZGODBoUlFOcS8yWFhBK2NOYVE1YUFR?=
 =?utf-8?B?YklUSXNNMUVNNEM0emdaVTMvWXI0U29zWnIwOGxaUWhuTUEwMlY0aXZkQmh3?=
 =?utf-8?B?MFFmR0NhTk4vWWRnTHdVQUUrd0xUU0NqY24xSFJHQThEWkl6d3UyVmNQVG5I?=
 =?utf-8?B?VnRpcHRFK3V1VHBqUmdmR2x5R3hHelkxYlpySDFGMXVSSFBjRTJJWlJMUVNK?=
 =?utf-8?B?L3Zlc3FLekwvN0N5ZDM0d0dMVHA5dFhka1NxamphVm1DRm4vb2RQc0k1MWFB?=
 =?utf-8?B?RDlRZDh1N2hXTnJCbmF4MWk4Y21OSG4zd3NTejNSRWd6bWV4aTVYTEN5UkFX?=
 =?utf-8?B?MGgwVDJYaHV6bStjZ3hhdEFDNjlhNFR3VXFWNm9xS0kvWmpuS1BoQ2dPMUZz?=
 =?utf-8?B?ZjZtckg3clhkdjFIcndmV2cvZFBKbXN2WDFncTlQWEVMN2hEY29OeHo1MWtB?=
 =?utf-8?B?MEpLM2VFcHF0dWtCOEdhRDNubHJaUHA0OXBoekpnTlVma1ZwajJ6Z242NnFE?=
 =?utf-8?B?Wnhrd3AydjVXS3UwV0JXZW83OE9zYldsNHJyNjJOd29ETFJLdmxLM2U1Rko3?=
 =?utf-8?B?TmlvNnF6eGhmWUlKT1A3dUpaNkIxV3J4dUdUa1RleU5yN2lrNVJQMWxjNDha?=
 =?utf-8?B?TVdMQ2Jpd0hhNVpVc2pWajRmUlBPVHI3U3Eyd3FhYUN6dkllZFFJM0I2Znha?=
 =?utf-8?B?Ty91WkNwNmlLdVM0OFZyRGsrbjBoMDNIUEhMcW9KK2VNcjFtR2RtUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872ecab3-d5aa-495c-4c9e-08defc7ef3e8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5389.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 16:45:32.3932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3w9yb/5aOD7tscrlKwRfIkke9dpoZAhwFROX7WaG2p3/gsQRmFohicD2ydh1GGWKYiRQ6TtQx7djy1uD9btcvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9471



On 8/13/2026 1:37 AM, Anand Khoje wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> The dedicated hardware timestamp RX queue is allocated with q->index
> equal to lif->ionic->nrxqs_per_lif. The normal txqcqs array only
> contains the regular queue pairs, so using that index to set rxq->partner
> can read one entry past txqcqs[] and then write through the derived
> pointer.
> Only link RX/TX partners for normal queue-pair indexes. Leave the hwstamp
> RX queue unpaired, and make the XDP_TX path abort cleanly if an RX queue
> has no TX partner.
>
> Fixes: 8eeed8373e1c ("ionic: Add XDP_TX support")
> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Reviewed-by: Shannon Nelson <sln@onemain.com>
> Cc: stable@vger.kernel.org
> ---
> v3:
>   Use dev_err() and return -ENXIO for a missing normal TX partner.
>
> v2:
>   Correct the Fixes tag.
>
>   drivers/net/ethernet/pensando/ionic/ionic_lif.c | 17 +++++++++++++++--
>   .../net/ethernet/pensando/ionic/ionic_txrx.c    |  7 ++++++-
>   2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index fd3ee98..abc8e35 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -920,8 +920,21 @@ static int ionic_lif_rxq_init(struct ionic_lif *lif, struct ionic_qcq *qcq)
>          };
>          int err;
>
> -       q->partner = &lif->txqcqs[q->index]->q;
> -       q->partner->partner = q;
> +       q->partner = NULL;
> +
> +       /* Only normal RX queues have matching TX queue partners. */
> +       if (q->index < lif->nxqs) {
> +               if (!lif->txqcqs ||
> +                   q->index >= lif->ionic->ntxqs_per_lif ||
> +                   !lif->txqcqs[q->index]) {
> +                       dev_err(dev, "missing TX queue partner for RX queue %u\n",
> +                               q->index);
> +                       return -ENXIO;
> +               }
> +
> +               q->partner = &lif->txqcqs[q->index]->q;
> +               q->partner->partner = q;
> +       }
>
>          if (!lif->xdp_prog ||
>              (lif->xdp_prog->aux && lif->xdp_prog->aux->xdp_has_frags))
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> index 301ebee..73998d6 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -545,13 +545,18 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>                  break;
>
>          case XDP_TX:
> +               txq = rxq->partner;
> +               if (unlikely(!txq)) {
> +                       err = -EIO;
> +                       break;
> +               }
> +
>                  xdpf = xdp_convert_buff_to_frame(&xdp_buf);
>                  if (!xdpf) {
>                          err = -ENOSPC;
>                          break;
>                  }
>
> -               txq = rxq->partner;
>                  nq = netdev_get_tx_queue(netdev, txq->index);
>                  __netif_tx_lock(nq, smp_processor_id());
>                  txq_trans_cond_update(nq);

LGTM. Thanks for the fix.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> --
> 2.52.0

