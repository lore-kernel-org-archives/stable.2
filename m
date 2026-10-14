Received: from mta1.migadu.com (out-39.mta1.migadu.com [95.215.58.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE79A361DBF
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946114; cv=none; b=e/aUZ8XkFbuTaFlA7TbPvhf5D5o500aCQfxIYuQFxWCGm/vmvCZ5CG9ByL4GA29L/05l5BtnxVIgHiwa7x5AJyHsXqvZk5A1yU9vFkdpZ8cUHR37ENwjrM++H9LM2/pVve+3dhz9U2qiUvGrplTAjJwLDoEEnDJJsdwxAnhQRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946114; c=relaxed/simple;
	bh=2kHoms2QSSahMaMVeqUufPLoRe85ZbbkTBqAyiaowT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xv6/FPTZ4FkhbSAAoDanHcOyt1n70ayuq6m99rSzky6/otOoRLEJp5CAG3noGyMtoq1prkueajqmywqAd+nZLhzIPTdl1uSbqmVxNM9TkdoiIojEhSMYNVZUKyQIZtHC7xg37hTr3xu/TZ7Rg0C6Iu8ppMqIiox149LeDF1dSts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kk02qkMV; arc=none smtp.client-ip=95.215.58.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kk02qkMV"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2kHoms2QSSahMaMVeqUufPLoRe85ZbbkTBqAyiaowT8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791946109; v=1; x=1792550909;
 b=Kk02qkMV1wnrYkoj8hoDrlMuw8WCNtXDUrHdEpkGmbHIkqWbFf4lOt7+YT2Z2U/xiEFZxaco
 Szv5SlUvGoU/TgfbXb77JE9WqN1LAWpUwpm01sGDtvHp4qmbOyQhrmIkFcP32mgL1VDBypSK8rF
 IXSbv//6P6ONuIu0/0/IqgtA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e25af03395e5a192;
	Wed, 14 Oct 2026 02:48:29 +0000
X-Mizu-Trace-ID: e25af03395e5a192
X-Migadu-Flow: FLOW_OUT
Message-ID: <c9799efb-a002-4925-959f-c9a2b883d85b@linux.dev>
Date: Wed, 14 Oct 2026 10:48:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: vmscan: don't count per-node proactive reclaim as
 memory pressure
To: Vernon Yang <vernon2gm@gmail.com>, akpm@linux-foundation.org,
 david@kernel.org, kasong@tencent.com, qi.zheng@linux.dev,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
 hannes@cmpxchg.org, mhocko@kernel.org, ljs@kernel.org,
 roman.gushchin@linux.dev, dave@stgolabs.net
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Vernon Yang <yanglincheng@kylinos.cn>, stable@vger.kernel.org
References: <20261012022917.1102467-1-vernon2gm@gmail.com>
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20261012022917.1102467-1-vernon2gm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/12/2026 10:29 AM, Vernon Yang wrote:
> From: Vernon Yang <yanglincheng@kylinos.cn>
> 
> When the cgroup has no memory pressure at all, writing to
> /sys/devices/system/nodeX/reclaim triggers proactive reclaim on
> NUMA node, causing increase in the writer cgroup's memory PSI.
> 
> Due to this reclaim is performed in the context of the write(),
> accounted as memory pressure on the writer, like
> commit e22c6ed90aa9 ("mm: memcontrol: don't count limit-setting reclaim
> as memory pressure"). This is unexpected, the similar scenarios (e.g.
> senpai) will continue to occur, only this time it is for the
> /sys/devices/system/nodeX/reclaim knob.
> 
> The Documentation/ABI/stable/sysfs-devices-node documentation also
> notes that "This interface is equivalent to the memcg variant."
> 
> This patch unifies the semantics of the memcg and node interfaces:
> per-node proactive reclaim is no longer counted as memory pressure,
> and the per-node proactive reclaim interface no longer produces
> phantom pressure.
> 
> I ran demo[1] that performs per-node proactive reclaim 10000 times
> in qemu, writer cgroup memory.pressure as follows:
> 
> without patch:
> 
> some avg10=31.53 avg60=13.42 avg300=3.31 total=10602985
> full avg10=31.53 avg60=13.42 avg300=3.31 total=10602985
> 
> with patch:
> 
> some avg10=9.59 avg60=3.41 avg300=0.81 total=2686221
> full avg10=9.59 avg60=3.41 avg300=0.81 total=2686221
> 
> [1] https://github.com/vernon2gh/app_and_module/tree/main/reclaim_node_psi
> 
> Fixes: b980077899ea ("mm: introduce per-node proactive reclaim interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> ---
> V1 -> V2:
> - Check `sc->proactive` to differentiate between proactive reclaim or
>    page allocation. (Thanks Barry)
> 
> V1 : https://lore.kernel.org/linux-mm/20261005062236.564210-1-vernon2gm@gmail.com/
> ---
>   mm/vmscan.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 91295070ca33..2e9ca5e4c741 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -7994,7 +7994,8 @@ static unsigned long __node_reclaim(struct pglist_data *pgdat,
>   					   sc->gfp_mask);
>   
>   	cond_resched();
> -	psi_memstall_enter(&pflags);
> +	if (!sc->proactive)
> +		psi_memstall_enter(&pflags);
>   	delayacct_freepages_start();
>   	fs_reclaim_acquire(sc->gfp_mask);
>   	/*
> @@ -8011,7 +8012,8 @@ static unsigned long __node_reclaim(struct pglist_data *pgdat,
>   	memalloc_noreclaim_restore(noreclaim_flag);
>   	fs_reclaim_release(sc->gfp_mask);
>   	delayacct_freepages_end();
> -	psi_memstall_leave(&pflags);
> +	if (!sc->proactive)
> +		psi_memstall_leave(&pflags);
>   
>   	trace_mm_vmscan_node_reclaim_end(sc->nr_reclaimed, NULL);
>   

LGTM.

Reviewed-by: Ridong Chen <ridong.chen@linux.dev>
Thanks.

-- 
Best regards
Ridong

