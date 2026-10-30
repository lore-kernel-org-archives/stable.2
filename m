Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.88
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324988;
	b=XWPrkGUjtYbOm2hrAOQk8sO5bu/hwkh6lRSozSHJEgm6yLjN9EpPQ2q9TmK/t8+1zgCF
	 jVrrzSebyF0bkISWXnbNuLXZozxSnYYGmAKz+jiIo33bLDCoUlXRHiOU10dUVyEGbKIjW
	 M/Z3yvgnpsCaZ2S2UpgPJyXji+9/SLtY/vrHpwvA5tcH+7JPsZl336nSNdg9/Yqea1RwA
	 MEt7rzzoQC7YpK16Fa5DpDyzduSI19eQOwtfuRUJF13kVq/uMiPiAIQ03Kz0Z4cbBy0VW
	 1p/I/l/Qw0U1qDHRujQdnqk+9fFIE7sGmqSqqWSj4cal8GWMMzgcYaW0xRATz969Rsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324988;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ks/als92P7W6dfkbUwU45ITyxrQRBrooZjsUBw6Ieik=;
	b=GwLTLCctIgQOr8YiTS1sL7PwV2nfvvsCUvmD6X6G/nIK6vYB7Ie/3+sJqPPmkYrl8VXp
	 jLnWc6AQ0D2tijWx21KdViow38QpfoPBlXtoespBoiyn0dmOoxeMW0FDYTN/4CP0639EZ
	 Sx9N1Dwa/aMLf/LWrejJx8wVhuHQyIqfjWevau/eeHoIpTzm1qXz1keLjWgOYTRalJXT8
	 MKWON34T3GfyON6tVRLTMkfwcSz/1kr3/nR/YoBpp9uv6U/pEXdq4s4RDKGmaA2VkHbSh
	 1XDwXJyGXkofkz2in5CaSujs73syJxrl6SgU7zTlCjEphpRtwfnMeBMm8FjxeYXhy6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eTJtC7kt;
	arc=none smtp.remote-ip=95.215.58.88
Received: from mta1.migadu.com (out-88.mta1.migadu.com [95.215.58.88])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DEC606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 01:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08DEC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eTJtC7kt
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pbxzV7BQ52dy3p13iURJvjvoZreCLEfbqYQbK2sAiaE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793324980; v=1; x=1793929780;
 b=eTJtC7ktAUuY5L3W1UQViTQr636MoaYCSkTcBs3zlLGNHAdgLHRQM49MILEFsqaJSsKk6ITG
 H5gYKHx/Rroy/cbcecspGxlzA0x5auvaiITnh2f2yYChSJmECHIDr1vyThBJdiS71U3sxrVXj5a
 6X66Gg3oqhCjVilqNwc+yEfU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eb3448e0ccbbf1c7;
	Fri, 30 Oct 2026 01:49:39 +0000
X-Mizu-Trace-ID: eb3448e0ccbbf1c7
X-Migadu-Flow: FLOW_OUT
Message-ID: <8f8d1c9e-da88-45a9-bbe0-c1b1403e949c@linux.dev>
Date: Fri, 30 Oct 2026 09:49:32 +0800
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
Cc: cui.tao@linux.dev, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] blk-iocost: account flush sequence latency only once
To: Zhe Liu <liuzhe1@kylinos.cn>, tj@kernel.org, josef@toxicpanda.com,
 axboe@kernel.dk
References: <20261029092424.764545-1-liuzhe1@kylinos.cn>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20261029092424.764545-1-liuzhe1@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Zhe

在 2026/10/29 17:24, Zhe Liu 写道:
> A flush sequence with a DATA phase can complete its original request
> twice. Both completions invoke ioc_rqos_done(), causing the request to
> contribute two latency samples and adding the same queue wait time
> twice. This gives such requests disproportionate weight compared to
> ordinary writes, distorting the device-wide latency and queue wait
> feedback used to adjust iocost's virtual time rate.
> 
> Skip requests marked RQF_FLUSH_SEQ in ioc_rqos_done(). The flag is set
> when the request enters the flush machinery and is still set when the
> data phase completes; blk_flush_restore_request() clears it before the
> final completion, so accounting happens only once, after the whole
> sequence finishes. The remaining sample covers the request's lifetime
> through any postflush, and its queue wait time is accumulated only
> once.
> 
> Fixes: 7caa47151ab2e ("blkcg: implement blk-iocost")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhe Liu <liuzhe1@kylinos.cn>
> ---
>  block/blk-iocost.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 2ae40138e041..601029221e6f 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2868,6 +2868,9 @@ static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
>  	if (!ioc->enabled || !rq->alloc_time_ns || !rq->start_time_ns)
>  		return;
>  
> +	if (rq->rq_flags & RQF_FLUSH_SEQ)
> +		return;
> +
>  	switch (req_op(rq)) {
>  	case REQ_OP_READ:
>  		pidx = QOS_RLAT;

Reviewed-by: Tao Cui <cuitao@kylinos.cn>


