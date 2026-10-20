Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507173;
	b=iH1AZu5xe85iaXGUvxBT1lqpfKKOk9lxK7ekM99pstJW/nzraYA0GL5IkBcLmi9Mg5Qs
	 1XYCAsLaEbhUK6vZ+9jfldQ1EKli5d+2t3xqAqIGwYU07leXhPFSwuHHoFNA/yunQl7eK
	 jB7m6lZJ8GwTxy6H1y1VIRSiP6EOew347kGx0RcwPwdL11GKkaRTHDtW6N/ZE4BScNZHW
	 cg5C3pe8G6pG5NYrq0/g3hWrdV6HNBBFWuxOziklziXD2JrdRCPDXWQqzlp6/36+VimSF
	 A58zLRmaRZMfjQ322XYabuhEyL6Obu7MRrrqlWzm3Qqkq1GJ/qN+hJGHEPDaJSv5kyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=TAz5HUAuhl+iZRwwDUFp7THQQfvQJd0tH/rHV2w2wmo=;
	b=MQfrR/FMbh6fYN4L0UEV+lHbflV+J2SzvEbXtytRenGFHtBRoDChkF3QX6CMQ0iNnzVl
	 na6YsMJ4oy/hLjiaKyEfQJ6al7OyWUtX3tTykrfj3ZAY1hiH94+/FkFgd6YoPgHefLP7v
	 NTvjTnbf6FQ1mDJCUbdFHOT3BpZcBYjt9hwSQMcdXT3XgYx/RhTzCn9ZNOXFZ5oAxQ4Sw
	 KnruAY6MnFQPS77TGJqo6qIJacbauh7k+mVxHNs5mg0pk9+C3zfRmKD9NAZUZj6LAXXK9
	 kAyAraxi//gjzIT2aUZLJ4nQNzt48bz4az+TZUiqribXgdy+zjvoCvsbp1zMr10mD3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=XAka60kG;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ADD606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 14:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87ADD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=XAka60kG
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1226082eec.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792507172; x=1793111972; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TAz5HUAuhl+iZRwwDUFp7THQQfvQJd0tH/rHV2w2wmo=;
        b=XAka60kGQCDYzLBujwoDyaziGz/wxKWOk9JDjUEnThjZQh0kSEDckkjNWPh9Sqfpag
         LjzanvOrEw+E5z8IW3l5Uij/VNEMTl8Oxtavoq8ZxtdZ6K65LpHEmQ+RQwTytiMyYBsd
         7nGU54F7hUmRkBU0Re08WpfTDdq0TkBpVxtqpRj7PcDaavTG9VJ6ty5APHoux1eEakQQ
         i4iF3EOD205Zs09120H/IUAIdn3b412qgqSIo1wM7RYLLWWQoSJrV2QVY7MZNYQgPxuP
         Yvp6LB/O5EykjqN/bjAB6qysZ/rr79RYznvopS8Gkg4NF/tkSqgoOHWjFhFme6g4b8RF
         dknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792507172; x=1793111972;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TAz5HUAuhl+iZRwwDUFp7THQQfvQJd0tH/rHV2w2wmo=;
        b=p7BiBWrhoqYG6eMEKhvVW5yCIjZgpLcKJFycgLLoSlQc15IaZ8pQ0bFvK6ywcwBXxC
         lPfKukdCerVtPTaxj+LLp+bGJ4aFTunQUB4RG7FRRAAyYjH2CXVWlCZLZF3sx+leVlsH
         aIGJmKrjMjn5F+O1gnWiuzPtJjYbrQnjm6psPVSpkkT5UffhDfvdpJr7Vk7j0h72dZaY
         Ct7s+0Kt13Q1RRP+Lwj3a4Xs0vV2IrdyefpkotjaNJfIE1ig9GXzrJMtVfnYAmlfWyrL
         hpvNUSGJBGQVg3EKzrWsdVGWbLBk2jUK5HhQrsScG8TrbOl6YJD1cgfY2qqeb4C0QILK
         1xnQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZ3kM0iGU6/NxSM5rlYgtzfLExt5HU8LGlXHKxmHb08ftBIJpO4KVE/W4p4V0nRlygqLCjL/g=@vger.kernel.org
X-Gm-Message-State: AFq9FYKY2nV/MFytCrHQCx0QQVG6V1dib6/fyz2x6cvb3ZaZKLMmhkWm
	Qzl4l26UMCHnSXtt36aPPVKvrV+aQfEJXUwrZigFyij+Ewv7bLIiSv1Iz8WluVa/zMQ=
X-Gm-Gg: AYBFou3yNVt5edi08OY8e3edm4iPC3TqMg2PZEixRdXfWafmPKzm9gGQxVw2sX322/e
	U+RVsD521i0DWOSiBylOnduowykEhZQTc6pwrVmC65xgBSfoktTWz5WTRWhaProRl0CEQfJom3s
	sYqrnWIGHJX49Wpip0ST/mffc2AilIV+GHVCdd286B3+LEjVrJoAIRC4Un9onIIAxVNUje4EJeT
	xYIRVkyd9xqHZiJw9FhqSZjDfbuRC878NEXjwts8hiZmPUGv6ZXAXmIGnXE3ttWxjapokSFswD2
	XA1dipXjWVlx0a2RaqZKUHdvQgBa7xY1yf9CnscMgbIUDP1gPUkakNpPO1/k9tYbbYhJmwcLf1t
	nfIm/OoNrJSpYzqy4RB6lcueR5/d76/tU2yEiE6v7xeVpILhYnIpBqjKL47CYKhQRUkdSrQlhx2
	tpALDrcSjFy51jJCUzDd3FGqjhbU030D0RbxGtOFAbgCulYK5qRePvWzH6V9HvLqPbUCP9liyTI
	uk86ffVvfxbRdAtTVYwRg0vYpuU9VhBmQc0nKRWJD5ROlsefu/RGSFKy3ngNmNA0dB+/abCRDsc
	xxB+wxp5Lpw=
X-Received: by 2002:a05:693c:860a:10b0:351:727d:b9c2 with SMTP id 5a478bee46e88-361a18634bcmr18267849eec.17.1792507171481;
        Tue, 20 Oct 2026 07:39:31 -0700 (PDT)
Received: from [10.61.8.29] ([155.98.132.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360819bc569sm40225365eec.11.2026.10.20.07.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 07:39:30 -0700 (PDT)
Message-ID: <29692751-e80e-4f29-a07a-ea0221f1116e@kernel.dk>
Date: Tue, 20 Oct 2026 08:39:29 -0600
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
To: Bart Van Assche <bvanassche@acm.org>, Nirmoy Das <nirmoyd@nvidia.com>
Cc: ming.lei@redhat.com, hare@suse.de, dwagner@suse.de,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261020125129.430600-1-nirmoyd@nvidia.com>
 <ff516ed8-d4b0-463d-952b-14cf110ec8da@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ff516ed8-d4b0-463d-952b-14cf110ec8da@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/20/26 8:13 AM, Bart Van Assche wrote:
> On 10/20/26 5:51 AM, Nirmoy Das wrote:
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 025a799f35b924d..00b75eb95dd943a 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -4002,6 +4002,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
>>           goto fail;
>>         hctx->queue_num = hctx_idx;
>> +    clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
>>         hctx->tags = set->tags[hctx_idx];
> 
> Why clear_bit() instead of __clear_bit()?

Since this isn't a hot path at all, going into details like
that does more harm than good. clear_bit() is totally fine
and honestly preferred.

-- 
Jens Axboe

