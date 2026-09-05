Received: from mta0.migadu.com (out-111.mta0.migadu.com [91.218.175.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FFB32B133
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 06:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788588165; cv=none; b=iGBZt0IWyhQFSL6MHaLmYGLumovuRTHHnOOcN8HK8vwrP5yPWF4a8q/WkqHi3z+c9SY0eji4/Rhs93Zwg0U4nJn/H/wbw0ojGezpUalanLqAKmaYM5uhsmPc8tK/jtxRVcgQwc5laLl46MquS339gWu0MSXvCYjifsl3GQ3upnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788588165; c=relaxed/simple;
	bh=g00xPURkl0HXiJrLznFEGazxWq25zrYenZGCIwbXv6A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pE3NiCkxX7j9jKedtUmHPbihKrLzK5Ow5PLqS+lEXhZDM8rYHpINE89EqK+pTasx03c+YgYgv5EdR1Vebw7s+olUPuFPVBelMBQWAemEVqU5yxGUT+Vx2V8da5nZ45vMmwe8+LtFI1aT0GRLpSFBD4UUPAP8uyfunh+tKnIxC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FF9XnLYt; arc=none smtp.client-ip=91.218.175.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FF9XnLYt"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=g00xPURkl0HXiJrLznFEGazxWq25zrYenZGCIwbXv6A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788588159; v=1; x=1789192959;
 b=FF9XnLYtnnKA3CbecClejPl6smZUyKMqoTdRM9OHiXgXuDrlU2KAMpPZwJLfirxhMEK8l6Yk
 0yez7C2010Z5f3FThLU5nm94Lqnw430zMb3UwI8vGf/rG8hPSWwMCQ6vX/XWS8Y8urReUY5shEV
 NDa6Phdy424hhXIQPQmRzoyo=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6927321ae16174ca;
	Sat, 05 Sep 2026 06:02:39 +0000
X-Mizu-Trace-ID: 6927321ae16174ca
X-Migadu-Flow: FLOW_OUT
Message-ID: <0bda54a1-7cdc-42c9-89f3-408067b2f8a3@linux.dev>
Date: Sat, 5 Sep 2026 14:02:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Subject: Re: [PATCH net v2 0/2] mac802154: fix queued RX descriptor lifetime
To: linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex.aring@gmail.com, stefan@datenfreihafen.org, david.girault@qorvo.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260903123202.60152-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260903123202.60152-1-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/9/3 20:32, Xuanqiang Luo 写道:
> From: Xuanqiang Luo<luoxuanqiang@kylinos.cn>
>
> mac802154 queues one descriptor per received beacon or MAC command, but
> each worker invocation dequeues only one. Since queue_work() coalesces
> attempts to queue the same pending work item, a burst can add more
> descriptors than scheduled invocations. A later frame may schedule another
> invocation, but also adds a descriptor, so it does not necessarily reduce
> the backlog. Descriptors can therefore remain queued indefinitely once
> reception stops. The RX path, workers, and scan cleanup also access the
> descriptor lists without common synchronization.
>
> A queued descriptor carries its receiving interface beyond the RCU
> read-side critical section without holding a netdev reference. If the
> interface is removed first, the worker can dereference freed memory.
>
> Protect the descriptor lists with a spinlock and keep the workers running
> until the queues are empty. Then hold the netdev for the lifetime of each
> queued descriptor to prevent it from being freed too early.
>
> This ordering is required. Without the queue-draining fix, a descriptor
> stranded by queue_work() coalescing would also strand its netdev reference,
> as netdev_put() runs only when the descriptor is released, leaving the
> netdev pinned indefinitely.
>
> ---
> Changes:
> v2:
>    Patch 1 (new):
>    - Serialize descriptor list access and requeue each worker while another
>      descriptor remains.
>    - Detach queued beacons under the same lock before scan cleanup frees
>      them.
>
>    Patch 2:
>    - Replace the v1 drain_workqueue() approach, which does not cover work
>      queued after the drain or the DEL_INTERFACE path, with a netdev
>      reference held by each queued descriptor. (Sashiko.)
>
> v1:https://lore.kernel.org/all/20260828101905.26865-1-xuanqiang.luo@linux.dev/
>
> Xuanqiang Luo (2):
>    mac802154: serialize and drain queued RX descriptors
>    mac802154: pin netdevs for queued RX descriptors
>
>   include/net/cfg802154.h      |  2 ++
>   net/mac802154/ieee802154_i.h |  2 ++
>   net/mac802154/main.c         |  1 +
>   net/mac802154/rx.c           | 36 ++++++++++++++++++++++++++++++------
>   net/mac802154/scan.c         |  8 +++++++-
>   5 files changed, 42 insertions(+), 7 deletions(-)
>
>
> base-commit: dc4b95b8fee95113587e93ca116356032d271371

I realized that the issues addressed by this series appear to have
already been fixed by:

https://lore.kernel.org/all/20260725135154.99876-1-security@auditcode.ai/

I missed that, so please disregard this one.

Thanks,

pw-bot: rejected

