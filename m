Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.209.128.109
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793762177;
	b=T1RjvqLMIN9aXehZbJgIimFdMCbSjUt0ZBxSu+ZqpUWkfpkRmfhmaglDpfrQJzd45M24
	 mwSph/uss9or3EQgUcs0Y/GS02DLym0JIrEQi29R15hjdERhKTw1T9zxogvhZjlY+gpR7
	 0MJ2AHnSvA/xpBoOSYzOrr4Z5JnGNNluZBZgvdSiViJ1O50+9L88JY34XsKTkZVnRD91H
	 KDz4ltttUKXYeyAGEbRveSrlR9P5iTmKtu7tkM5bt1yUJnk5+JOUiULuyJiEgRhtpQ0le
	 4kp1e1x1EpKfrFRIJAT3GlhH6erhlIP9K7ycr4y4METUMn1G2V94jhE8M5GiykZbTiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793762177;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=bZOFxd9mHaFfL8wjnfFrAMTZNT6Jpt+AaPWoyOrDSf8=;
	b=QTuOnE764UMOSSOfc94QnjrrsIljJ9WnesAJQnsho9osXZk6BBgYHyLD1cbcNu/Yy+kF
	 YDHtb/27HdrsTTARMo3Pg3Bf+pX0oxUbdq4YiROz+FeuQUF7JdtUZ9l4lYlU/PTIyut0u
	 csqpMxKkXe8a5lCxVLz8ff6Bn/odhLkgiF3XuH0vzSjns0H3bUxJuZLFjuJt6yQ9oSdO4
	 YBvcIvCYQ8LExN/2eH24prGtuvN9cO4pht8O7O72OwnjBrOPuaAQiXdKX7ufrsxLf4Xcj
	 0RzaQcczrmNcLds6YsrZ6PawXBuRHLQFu5tVAGuFlZKsgcEGTw3w43NVux306ZQA38A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=WbLV4EH+;
	arc=none smtp.remote-ip=103.209.128.109
Received: from mail-m128109.netease.com (mail-m128109.netease.com [103.209.128.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26AB606A31B;
	Wed,  4 Nov 2026 03:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F26AB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=WbLV4EH+
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 536a124e9;
	Wed, 4 Nov 2026 11:16:04 +0800 (GMT+08:00)
Message-ID: <6a3702b7-c15c-406c-8ec8-021a1f68a060@rock-chips.com>
Date: Wed, 4 Nov 2026 11:16:03 +0800
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
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mmc: core: clear MQRQ_XFER_SINGLE_BLOCK for new requests
To: Fexiven <kernel@picomail.one>, Ulf Hansson <ulfh@kernel.org>
References: <20261103192345.647483-1-kernel@picomail.one>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261103192345.647483-1-kernel@picomail.one>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1a48e7e6703a4kunm13ad672c7408e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGk9MVk0fHhgYSh8fGRkZTlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=WbLV4EH+9KBUtwX0dcm8dfrAK4q6t/YE5Xhp73rE7TPz4wBgyIwFIh64j0dCIxtfu/jHbgUK42exeZafDee4slHYLJVk8lkALnWc5jKtaNluUEt/ssrXSTI4hdcImeKZHC8o6SLwEn1w1qmG5LqzD33sgwAjRlBvM5SlRzPh5q8=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=bZOFxd9mHaFfL8wjnfFrAMTZNT6Jpt+AaPWoyOrDSf8=;
	h=date:mime-version:subject:message-id:from;

Hi Fexiven

在 2026/11/04 星期三 3:23, Fexiven 写道:
> mmc_blk_mq_complete_rq() and mmc_blk_cqe_complete_rq() set
> MQRQ_XFER_SINGLE_BLOCK in the request PDU when a transfer fails, so the
> retry is done one block at a time. Nothing ever clears the flag again.
> 
> The PDU belongs to the blk-mq tag and is reused for later requests, while
> mmc_mq_queue_rq() only resets ->retries for a new request. Every tag that
> has seen a single transfer error therefore keeps issuing single-block
> transfers (CMD17/CMD24) for the rest of the uptime.
> 
> On an RK3576 board (HS400ES eMMC) with occasional data CRC errors, which
> are recovered correctly, sequential direct reads dropped from ~200 MB/s
> after boot to 3-10 MB/s within minutes and never recovered. The host
> registers showed only CMD17 with a 512 byte block size. With this change
> the read throughput stays at ~200 MB/s and writes at 60-90 MB/s while the
> data CRC errors continue to be retried.
> 
> Reset the flags together with the retry counter when a request is
> prepared for the first time. Requeued requests keep RQF_DONTPREP, so the
> single-block retry of the failing request itself is unchanged.
> 

Sorry for not catching this in the first place. I was preparing a patch
to fix it but forgot to send out immediately :(

Except for your DCO name , the change itself looks good.
With that improved, feel free to add,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>


> Fixes: d34124edffdb ("mmc: block: Use MQRQ_XFER_SINGLE_BLOCK for both read and write recovery")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fexiven <kernel@picomail.one>
> ---
>   drivers/mmc/core/queue.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -301,6 +301,8 @@
> 
>   	if (!(req->rq_flags & RQF_DONTPREP)) {
>   		req_to_mmc_queue_req(req)->retries = 0;
> +		/* the request PDU is reused: don't inherit single-block recovery */
> +		req_to_mmc_queue_req(req)->flags = 0;
>   		req->rq_flags |= RQF_DONTPREP;
>   	}
> 
> 
> 

