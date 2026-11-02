Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617167;
	b=gm8uyKxjrD1y8hki8x+LycLzAQJRMtzGELR9qLcgB60Y8bRCYgTGdymv4si/6J0l7ty3
	 f4Wvzr93g1KmGoMlrCYULU0ybfCnhsfHZ4wC65UjhOcuVzvZ5b3ctJPb8eE7HlIdKFD/o
	 mqt80AQkrrxWzLYlj1l2e4ILSMONWddtYJ0e33LWtg8koI0SBDuunCFKfmsTz7Y7HTxOE
	 QwRDMKJ7bZ0keoTQe1Vzevw7ZEuj0HcQibD1yfPJBcxWZyUeEX0IlIP5M6gyyuZuA4sFz
	 hTrk1JPqVVxILdoNRRJ07vSYKlzhqJJzJm/zdi58CuQ8Lm8TCUrQVW3EY4J5HNdoEQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617167;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=aB//5RvIjc+u0E9iZDUmK4trDxxGUPJEyf5+Tgpg0v4=;
	b=ShgU7WYFbn07ydK2fJJx+77lZLFUP7kv21csTcbMb2F4tsGkf6SwCMXBsMOQSFe5W5Uu
	 CY1wTVTKXj5uf6Uz+cLNegaAbI1i7W2yevV8CJ3znBjVzmyc6KhtrPaW9OHkqBegvRLRH
	 WRdLZL5p0+BvKJBMUC0vh5HP99pE9GEQ8bHoUhiGC3gAKl/SllFzv1rG42bS9SaSPUUU6
	 1O6atDm0+Nc3SgMYTSbYJCcmE7Gk6zMdOEdV3iotjwXHIwt9BDD4qSWJwHwMUCW1lTO3+
	 lJTzsDs/gXuja2LSsis94f9u6lNfGFGx95RCaqEp7lAe33FFhYWSL2FbbI/yukHwzdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=SLkCay5M;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAA1606A324;
	Mon,  2 Nov 2026 10:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CAA1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=SLkCay5M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aB//5RvIjc+u0E9iZDUmK4trDxxGUPJEyf5+Tgpg0v4=; b=SLkCay5MwVPuzASJO8eMRJvpyI
	q2ESxc9sC5Dsvi+la7s/5Z1viCcU/b+qawdcO1G1mxu5iFO1tmaOfPJHE15fAl4cjokwEpBKHOx16
	oEfwYAEcO8fFKHk6+sjfiTz1Wc2CSbVGw6frlE7A225FP3gcsiF/GObxJx8633zPb32SZ/txTUMPa
	/GGwfY9949kwkXtcCVHf2/7hau20NTJVdWVW6ZI3DJjEEOmHWWUtO6krH4vELjoAYymXewJgZDuQU
	NHz9vaybY41xcIPb32wNJw3FTAjizDbxWZQMivDijlPBI0ZM2OLvNDlpXJMazo2d3wUgH6Gi7LSjp
	aqz1/4ag==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xNpkz-0066ms-1D;
	Mon, 02 Nov 2026 10:59:17 +0000
Date: Mon, 2 Nov 2026 02:59:13 -0800
From: Breno Leitao <leitao@debian.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH wq/for-7.4-fixes] workqueue: Fix drain_workqueue()
 missing work items chained across pwqs
Message-ID: <auhlROvLdDKg7-x6@gmail.com>
References: <20261030164210.3735018-1-tj@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030164210.3735018-1-tj@kernel.org>
X-Debian-User: leitao

On Fri, Oct 30, 2026 at 06:42:10AM -1000, Tejun Heo wrote:
> drain_workqueue() flushes the workqueue, then checks each pwq under its
> pool's lock and returns once a pass finds every pwq empty. Only chained
> queueing is allowed meanwhile, and a chained work item can land on a pwq
> other than the one the queueing work item is executing on. The pass misses
> it when:
> 
> 1. The pass finds pwq A empty.
> 2. A work item executing on pwq B queues a work item on pwq A.
> 3. The work item on pwq B finishes.
> 4. The pass finds pwq B empty.
> 
> drain_workqueue() returns with the work item on pwq A pending, and
> destroy_workqueue() can then trip WARN_ON(pwq_busy()) and leak the
> workqueue.

Very nice finding, basically drain_workqueue() could return while the
tail of a chain was still pending.

> Add wq->drain_seq, which counts chained queueings while the workqueue is
> draining. drain_workqueue() reads it before each flush and retries if it
> changed by the end of the check pass. Flushing once more after an empty pass
> is not enough, as a longer chain is missed the same way.


I am curious about a work function that keeps re-queueing itself
forever. That is a bug in the caller for sure, but the current code can
escape it by luck through this race (and then leak the workqueue), while
with this patch drain_workqueue() will loop forever. Is my reading
correct here?

> Verified with reproducers of both shapes: self-requeueing work items on an
> unbound workqueue and chained queue_work_on() of another work item on a
> per-cpu workqueue.
> 
> Fixes: c8efcc258946 ("workqueue: allow chained queueing during destruction")
> Cc: stable@vger.kernel.org # v2.6.38+
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>
