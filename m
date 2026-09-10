Received: from mta1.migadu.com (out-141.mta1.migadu.com [95.215.58.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE153B059F
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029196; cv=none; b=UDo11btAbdE6rqfIcILCagxN0b2lqrWSAOYOS0TUe0b/UQaJSjbhhsNdoHREf4OUCn33N2EWXqMABccuafMHhf+b3ysfpTZyqd2D7SLWnFCJ/YZEOHiANC+yGiV+sp41Fh40NxVFAxAgyvxz7u3kdE1J9G1ARHK6QDYPOHMXaVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029196; c=relaxed/simple;
	bh=3Q0TgDX5uuy2JzuGxiyBfj3XV6sc+FicZjZ2PsgT9iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gd6HJthzV2bdhu/d3hcDWeWQNA91y85/e9m1GXZXkowXOeyXSZ48y/vNlq12WM6rGAe5QorEgK8y/yFxMK4dHDvWTO8aqwWsbGdukcXirhCsoUWfd9HAZBYTApwdoK0AEp/UTasqeuAVh3TmUznDB2XlmFnFdw6l9ce9vqM3ihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=THkswX8z; arc=none smtp.client-ip=95.215.58.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="THkswX8z"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3Q0TgDX5uuy2JzuGxiyBfj3XV6sc+FicZjZ2PsgT9iA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789029190; v=1; x=1789633990;
 b=THkswX8z6Oj7KnJ6FLOMBAqlYPi/J8Wf9v85JOGAcQb+yPv/YPVxKkmAv2c4PrKih1WDLEre
 ROyrzB2U2i+kakBo+b4FEJoYcqF+ylLGTuJUXi4H7wxCKeC5waL0WWHVZG8Fm1xVBjMtM38ByJr
 BxhQX5OVNpNiIzxJ5iuA2dtc=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d2b225be2d1f5814;
	Thu, 10 Sep 2026 08:33:10 +0000
X-Mizu-Trace-ID: d2b225be2d1f5814
X-Migadu-Flow: FLOW_OUT
Message-ID: <db978d02-2d5d-4d9c-994a-8791de7afa30@linux.dev>
Date: Thu, 10 Sep 2026 16:33:06 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] mm/vmalloc: Use dedicated unbound workqueues for
 vmap drain
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, Dev Jain <dev.jain@arm.com>,
 lirongqing <lirongqing@baidu.com>
References: <20260905152717.11711-1-urezki@gmail.com>
Content-Language: en-US
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <20260905152717.11711-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/5 23:27, Uladzislau Rezki (Sony) 写道:
> drain_vmap_area_work() function can take >10ms to complete
> when there are many accumulated vmap areas in a system with
> high CPU count, causing workqueue watchdog warnings when run
> via schedule_work():
> 
>   workqueue: drain_vmap_area_work hogged CPU for >10000us
> 
> Move the top-level drain work to a dedicated WQ_UNBOUND
> workqueue so the scheduler can run this background work
> on any available CPU, improving responsiveness. Use the
> WQ_MEM_RECLAIM to ensure forward progress under memory
> pressure.
> 
> Move purge helpers to separate WQ_UNBOUND | WQ_MEM_RECLAIM
> workqueue. This allows drain_vmap_work to wait for helpers
> completion without creating dependency on the same rescuer
> thread and avoid a potential parent/child deadlock.
> 
> Simplify purge helper scheduling by removing cpumask-based
> iteration to iterating directly over vmap nodes checking
> work_queued state.
> 
> Cc: stable@vger.kernel.org
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Ye Liu <ye.liu@linux.dev>
> Cc: lirongqing <lirongqing@baidu.com>
> Fixes: 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
> Link: https://lore.kernel.org/all/20260319074307.2325-1-lirongqing@baidu.com/
> Reviewed-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Reviewed-by: Ye Liu <liuye@kylinos.cn>

-- 
Thanks,
Ye Liu

