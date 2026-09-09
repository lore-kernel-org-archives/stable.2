Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09965650F1
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962326; cv=none; b=Dab3AXmw7O5O0FXghhSnZjejCGbx4rnhfaaddgT6KUIpAP1+ZSD6fn+Di5YSpUYhlwnzkQ/xh9G0wTjTJ/SMUBoXGSMconseNm9t4MkCukETI0RcUULcP62bvW4YvNhu5hFV2RLTLJzcvzc2OLfF8jI2jLXkj7lmv6hSQnsMrXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962326; c=relaxed/simple;
	bh=jmqMHMNI4kIvkiva5qeH52u8nLKPUrEYABXD2f5/ChQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WnllYJficUPyCNd8Y2Af7eEBtSbItny986jCWXqm+37ABJpkNjOJ7pRat3nzkFqMBH/6rHZ1oEzfGRK7y7vM5sM4cb8K71fOJwAygncj/0iGBgII1gJFPwub7TKttG5LFV56Ow57eMYFLwI6zZ9OGQ4Nuv+KoSPn3XrT1dxb06k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=nR+/wmub; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="nR+/wmub"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4b2ff8ca537so4293714b6e.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 06:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1788962322; x=1789567122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=61jm5fS/qMWPqQz9qs7og23C0CzXjbMZv233Vy2zenI=;
        b=nR+/wmub1HCVmjAmCx7T4Pvug3Td64JUBeV9Lg2ZYmSee+HQeyxQNe7udJSRljShDf
         CtjpuqrgS0Aj4HRTpPD6qMGdAXCYCTNGGYfCCa4VmVxKUuZic0nVOs5KxW8vQrK9/P4u
         +zLROZZO96tkm9DSvHAjHoqapFfg2ikHgvfZdOX7cLKc7uZJIbY3jUMCO0S3ZBnTMFLy
         U+PKZ0EhbC3TrgiwMSlN9HpAqR54CwhvpdcxcsLwLUfLNKquJxqYjhQlbpNjWfYd9cjH
         s+5jyZ91FAOEVavqBqcZbVfaykjmZu5KKaopNaM6J4hZGhpv6HtwGrt88QuGLZ2eTZxq
         dt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788962322; x=1789567122;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=61jm5fS/qMWPqQz9qs7og23C0CzXjbMZv233Vy2zenI=;
        b=GxhHziipYwH7pTRZattLv2Afug1/7T48z5uEA1a/dA7e/v6IWVR4xm9f6HnKv9n49s
         qBj0Cb4kbr/Lvq4nFSWazyWzepoey7gRcs1oY8XfxlUqSPtkZKQXpEex1TySWA9JwDES
         Tl07A3cxa9Z5mtoV+aAiM6pNw2SciEpY0IXp5Ei9ezNYjhgg6d3VrJuEdpURBzE9A5sC
         a3X7PAOlzFu0M076CIvcMwix47MO7xydiXcu/Zi7pTlLLdIKxf9ZK+v3FV+UF2cK0RE7
         r4jI4kpVjtG3JfgCcFR1hG3Ucz+R4jhVMU3r6/7Vq10mCyXL3l9MOtGnKGa2u/qxVvuo
         wP5g==
X-Forwarded-Encrypted: i=1; AKwUvBxZPp3yq4nPIou0Eh0idcz/C2IUHX+IS4Faaza0qPI8ebAqad5JCXgs9jyWNrjOAaGJ0J1IEEE=@vger.kernel.org
X-Gm-Message-State: AFuF++kqvQXpqXLz7Rr5A8RGa0FgjOMOLXJwUGZmv9SMhqA1bqJZjVJJ
	fJn6VlBq5UwLVVccZwcgFaf7Ae32wMbEhe9a4j++W+L3rUVV8JLBxpttvbfZSU3IrP8=
X-Gm-Gg: AYBFou16nMrFH29G6kvyUr9bAyMYapci0rjb+WXmC5n1EjgMouwAi90iqMlEGJ9X6Xy
	hxA4rzYHuOwZWRLMZrL2NcMFlAvf1WOSHA5RDLCbm1j3zvIsCDSKf7UxVd+TsvbG18erRMRRC0w
	qlcLELRfyrbFPJ1EQhT6pkg6s/SF0q4BRipV5sHz3OV9XXR8Jc0KT5u/PmAIIENk9fPjXkECCp8
	bhkEUiCejkjpQ3irnmZ7sxHNq3+E2rad8Pm1lZf9VfmeQTNfeasAGZuzEffz1HXUbxBhNKQW5aO
	1JdwQ86jt+AfqbsJAElf+HeMM0Q38UEtozoM8PCtxzJnB4BlFjmSDL46gdiDq225MYir5OMnVxQ
	Zh1J9N1cMPREwJBRufMFpiv9v+BPbNhAfC7SHi5qeonuT7MIRhjij8dkiIchtHwiD8ieRfLgwsU
	Pdi7DmIJLFjWYOXt2zv1FlZW4Kp0f7qBWneloeFXRzL9ct2/AC7y9zZIXDSfhBmna3wA77BN+s2
	1lhEBQ7OXuv6s5eKRlon4kA0IU5bAe75x2T8xnALIj2SUjflZVi4htXnA==
X-Received: by 2002:a05:6808:ec3:b0:4c0:a03e:59f5 with SMTP id 5614622812f47-4c0a03e6380mr2114531b6e.37.1788962322440;
        Wed, 09 Sep 2026 06:58:42 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47989a71ebbsm7049860fac.17.2026.09.09.06.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 06:58:41 -0700 (PDT)
Message-ID: <01c58aa2-005c-49be-9d18-64d56d6fbb4b@kernel.dk>
Date: Wed, 9 Sep 2026 07:58:41 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] io_uring/net: don't overconsume buffers when using
 MSG_TRUNC
From: Jens Axboe <axboe@kernel.dk>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: io-uring@vger.kernel.org, stable@vger.kernel.org
References: <20260902230041.1320658-1-krisman@suse.de>
 <20260902230041.1320658-3-krisman@suse.de>
 <0f5e8693-dcba-4fa8-87d1-570ac08e2d83@kernel.dk>
Content-Language: en-US
In-Reply-To: <0f5e8693-dcba-4fa8-87d1-570ac08e2d83@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/26 7:56 AM, Jens Axboe wrote:
>> When a recv/recvmsg is issued with MSG_TRUNC and the incoming packet is
>> larger than the provided buffer, the net layer returns the full length
>> of the packet rather than the number of bytes actually copied into the
>> buffer.  As a result, io_uring advances more of the provided buffer ring
>> than was actually filled.  Use the actual filled region size to consume
>> the buffer, but still return the full size to preserve MSG_TRUNC
>> semantics.
>>
>> Take care with multishot, because that seems to already truncate the
>> consumption based on the available payload size.
>>
>> This was reported in https://github.com/axboe/liburing/issues/1619.
>>
>> Fixes: ae98dbf43d75 ("io_uring/kbuf: add support for incremental buffer consumption")
>> Cc: stable@vger.kernel.org
>> Link: https://patch.msgid.link/20260728191454.1850326-1-krisman@suse.de
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
>> ---
>>  io_uring/net.c | 38 +++++++++++++++++++++++++++++++-------
>>  1 file changed, 31 insertions(+), 7 deletions(-)
>>
>> diff --git a/io_uring/net.c b/io_uring/net.c
>> index 647156c9331a..f8110dc9f860 100644
>> --- a/io_uring/net.c
>> +++ b/io_uring/net.c
>> @@ -853,7 +853,7 @@ int io_recvmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>>  static inline bool io_recv_finish(struct io_kiocb *req,
>>                                   struct io_async_msghdr *kmsg,
>>                                   struct io_br_sel *sel, bool mshot_finished,
>> -                                 unsigned issue_flags)
>> +                                 unsigned issue_flags, size_t consumed)
>>  {
> 
> Not sure this is correct. If consumed is a size_t, then the comparison
> between ret > len is an unsigned comparison, and every error will then
> get clamped?
> 
> Will need something like this folded in.

Can you check the current io_uring-7.3 or for-next tree and see if it
still fixes the issue?

-- 
Jens Axboe

