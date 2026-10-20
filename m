Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505634;
	b=Rc6DGp1rKEf1ALktGzgu16Yv6FnQcIm8iYPW2FC2zhWbtzEA7b45B28pZpZTKy2OkcY7
	 6MOiqqJ85AdkzNBssFmRWKDQfaswkztVEkfO/1Kkc/Yf2mbR52foEVBHqkWvxKdxy3lJA
	 7XlgHbMsKb8fPA98QOTrLl6asfIEOmT09cyhLXorCb/XV6bcB8XUtYE/JDlbEphSY6gam
	 b+gkqpGTn50gu38ppvZOWnm+S9arNRnfEYU7zg1CIXJ5iQgajdAX8tQvYGCFrk6JpaLrG
	 g0Oq6Ciuut0Zf8V0PgS7nRsxH2d8JcBKGQWoaJRvGVYFuKA3TRczm08LQYa6ZKORAqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0v3Ik65mA2myeZ8UQbSdAK5cmAWsfMkci64Pp6vYgMs=;
	b=tLYey1yiYN7FCikcjz82rOMlxTL7z/CijIiEXotPSAq74j5FNrSQp7bDkcmf8awz67Uj
	 7OqT1zhCpAUkAUcEJKM8LwZSDUbHHyyW31wIdd5gk5Xm7H4IBLn0K7em3U7BoV+TyX2G9
	 TQ8V0OrCEqnJlDk/k7w/xD4xWtHxxyCFZq4W4iqZEFVQoPOxx6arN1C7vvdHrIx1zfDj0
	 IHeghF3zfwq+kFON8Iu/4HZ7B0zY428DKkJ+bhnjwISuE3xkMgOZDcZZyTZzHMS798j4N
	 5ivyxbMYW/EP4C31y/6lYhN0i3Td493Z+xVnxmjzw6S/53hkSl/0j5TrGsDmyiTUSkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=nk8NITfE;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002F9606AA05;
	Tue, 20 Oct 2026 14:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 002F9606AA05
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=nk8NITfE
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j8Dt86cHHz1XM4Tl;
	Tue, 20 Oct 2026 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1792505630; x=1795097631; bh=0v3Ik65mA2myeZ8UQbSdAK5c
	mAWsfMkci64Pp6vYgMs=; b=nk8NITfE8WWUIozey+Tnrek+jTviIvMCH3qZYNB4
	rGf+ihwicZOHjxz8SMwDqTeu5Bk5+BzYbl5f1jYR64M+ZXv2NaECsz5V/7Ay9lrR
	HzDvJvmso6Y1Bs6+sae1CBWPt1mCBkhKeqiuG4pbCMB5UKDNM7iAQHIgocAC4zo6
	HtijzH7VJmzJgc8+i6wfljKv1cQsnad0EIEEX+rPmySP0sEdkWA0SZX2vUVJHGLx
	R2dRiRVezDX+UkzMxPW7jUoOVrPmDrBa5JFA6s0gkqEFQM+mKmOAUl3UkwM7sjYz
	aCVmr4YaukSvQyZa8uFS/bQJmQvfmg1ZRDOLW+BUMVIyVw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id W0JCPRt0UIGD; Tue, 20 Oct 2026 14:13:50 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j8Dt52nhCz1XM4Tn;
	Tue, 20 Oct 2026 14:13:49 +0000 (UTC)
Message-ID: <ff516ed8-d4b0-463d-952b-14cf110ec8da@acm.org>
Date: Tue, 20 Oct 2026 07:13:46 -0700
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
Subject: Re: [PATCH] blk-mq: clear stale inactive flag on hctx reuse
To: Nirmoy Das <nirmoyd@nvidia.com>, axboe@kernel.dk
Cc: ming.lei@redhat.com, hare@suse.de, dwagner@suse.de,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261020125129.430600-1-nirmoyd@nvidia.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261020125129.430600-1-nirmoyd@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/26 5:51 AM, Nirmoy Das wrote:
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 025a799f35b924d..00b75eb95dd943a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4002,6 +4002,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
>   		goto fail;
>   
>   	hctx->queue_num = hctx_idx;
> +	clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
>   
>   	hctx->tags = set->tags[hctx_idx];

Why clear_bit() instead of __clear_bit()?

Thanks,

Bart.


