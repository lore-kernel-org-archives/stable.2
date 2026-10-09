Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCCC4D4885
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546517; cv=none; b=eRd/iI5kfhlLKPlcMnlHXax0Te1d6ZNmEClkkx/RsgMe3G05pFmFTYePM85UX8nCGV61eYg3W6gr3++iJpATFv7/JVxdRnXZ/WKzIcrW6t+I321w4BSZUcnMN58Ty6Z1v9NJWLIX8tg3cSx4iwr6H7ZZGUGLzNRfAdO58sQ7Yts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546517; c=relaxed/simple;
	bh=L9Mu6TVdRZKeFQK7WH9Q7loQktaaTwQONlQN9eWWY/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWWEQTHwxpgfaN6ZOJQ+ODyVvntzQLX7FU7CGWzdgJs32s7BA92CEiUwrkzuIR9nG/fU/cFiuNkxzv9GylmWdqo1lVc3+ZwXVkDS5IWbC6ADv7tvgbo903pgUFLcQ914kALkUuqbQDrTswBhb5vsD0h1jAwRDQcMkMsag8Hb14w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmiVd6Q/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmiVd6Q/"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a02667ccebso31301765e9.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 04:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791546508; x=1792151308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZCCGgGZDQeI7my+YCg9m6LCCcgGyvTNAraqlhrrWfdo=;
        b=jmiVd6Q/pGd9ExvpB7Y527Mdro2HSD2UetYFVdqiNXyvEdzjxYYfx6a0/TEhu2OZ26
         bLGShUFLppW8HvXwJ64oU6nOqVMCHJPQvWqZgwnxqpgjXgoQ88cOI4EHbInwwZWuY8LM
         5C3c5bMYI1FxoGUxacCzZ0ZlTDtp51C+iRp6hqYKzZf70p6y9Hh4B2CtSGuswUHQ71Go
         w3aN9BuGbqY2OWKTCQlcEag6TRQuqtdPSv84WsgZdKzgswIM5j472uzn9gg+/NG9vp1v
         EroVq4Bi27fXhGh4yquNPw2Qh0PzifvEbdhctRyWPdkCl1gTI7l5uCqTzyqy4VtTDlPA
         YW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791546508; x=1792151308;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZCCGgGZDQeI7my+YCg9m6LCCcgGyvTNAraqlhrrWfdo=;
        b=chFLKSYWnvQGve+lgpcPQbcwvhDBygvmQiJ/1bx5GSz+L1ho43Hfe4qVVGqHNPDs6L
         2y9GB0nf0ucwmyI+24AIS0BMGd9qoP2394q+BpxWw00oVxHL8PvDKV0/kwAXp29f5D8C
         qHiO4KK/B4E8JikIzbD97tSrQqd4xdJUs3YOs3/5L2i+et2oopyRrS66sb4cW4qt9ysB
         ePFOe4GGRayE7c7wdk6ntK3IpCei9i81StGbCMrEYS9ix3BvakohgtM38Rfnz15SgchB
         u8cCAb8HZpDBj+rk5WbOMBqk7aHgVMgLz3D/NAEFaD1sy1L2HEOEWM8umcIEkR0laYa9
         O3rA==
X-Forwarded-Encrypted: i=1; AKwUvByC2thqeXx99iK7mr4yD7cBiADAtmcCq9mSM7/6OQ5y5FIeN/gwvVI8wHMz8P5ohE7qK9hAtgE=@vger.kernel.org
X-Gm-Message-State: AFuF++mMLoZaZeR7pFnToQjbkCDGGdheaHo76HjdRatjODvBC21gZidt
	wMLaOoUTRZBr+I5WNEk7GzYfg0YxhcBMQy5c7MRz2yn/0Ayprczn/nQt
X-Gm-Gg: AYBFou3qyUMmwQAVh4u+nBabG0AhddpEWD03jAEttKqw42lgwzuqk3Xd3GMj8TsH9SM
	tYVyCVjAEGhXqzkZgbATzUsdzxH/q1Z86rqO31cSEJDlpZdEbNb3toqWQbbcLsKwtPOsBXM6ELi
	QullJAdOmTcpfiZU9Vzc6J8UC82DyMhln1icLtV5m5CzhtxNLK3R45eu5XY85hLnX9St63Z8XWJ
	mNMe5jxqbiuGd9FC9x3SWOf+tO4Akw5NAJNR+L7O2LTZ7paLO3Se09LSqUdjRj3/BOPs2eLPyHw
	/iAt5iIwyia41V/+GTrLAcArmzAK3eI6+St5N2WDw/1qB6SL0Y9or74Q2buexeUZwZWCGgh60bi
	a811WEQJgtanRV9fD/DCy/yckWRZJ1rppiEKSYo50N6T8W4b7HIjI3wgO7AJml8ZbOuvPWpn74+
	jO3on2uVWibUqqtEVbct0hFsKQb2dYFUJEIq4+d28gqzxt0bUh+Swwyack1Wgv37bVoH0PBEyg8
	UrnWsV0HfNmKypgcQLtiDvu7KgYlixtPYujky+pEYXtVTJ4Ql0doqjkoMgf0zwpCAryEpY/+zxQ
	h5pf7VJ956tPp/StAyiv01QrLWQtT3cV1GC0HPGGEPtf39+i
X-Received: by 2002:a05:600c:3f06:b0:49f:bc43:9e96 with SMTP id 5b1f17b1804b1-4a18e4a3bfbmr34261435e9.8.1791546508147;
        Fri, 09 Oct 2026 04:48:28 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be96549sm77399465e9.6.2026.10.09.04.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 04:48:27 -0700 (PDT)
Message-ID: <803bf4ba-78d8-4896-affc-7d4df5c9d50b@gmail.com>
Date: Fri, 9 Oct 2026 12:48:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/cmd_net: prevent infinite retry loop on
 unextractable timestamp skb
To: Bui Viet Dung <dungvn2345@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Willem de Bruijn <willemb@google.com>, lollipopkit <a@lolli.tech>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20b406ac-94ec-4b0f-a307-08082092ae08@gmail.com>
 <6ac7afc4.cf15ae49.1a8a2a.2a55@mx.google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <6ac7afc4.cf15ae49.1a8a2a.2a55@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/26 15:59, Bui Viet Dung wrote:
> On Thu, Oct 8, 2026 at 3:43 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>> Sounds fine since there are only timestamp skbs in this list, do
>> you have a test case?
> 
> Hi Pavel,
> 
> Thanks for the review.
> 
> The issue was spotted during code inspection of the error handling path
> in io_uring_cmd_timestamp(): specifically when skb_get_tx_timestamp() returns
> a negative error (e.g. -ENOENT due to missing PHC bindings with
> SOF_TIMESTAMPING_BIND_PHC or unavailable timestamp data). Since the
> multishot apoll remains armed on EPOLLERR and the unhandled skb is spliced
> back onto the head of sk_error_queue, it immediately re-triggers the command
> in a tight busy-loop.

Thanks, I can take a look tomorrow.

> Below is a standalone test program demonstrating the TX_TIMESTAMP command
> setup and execution with CQE32:
...> If desired, I can format this into a test case for liburing under
> test/timestamp.c.

That's always appreciated!

-- 
Pavel Begunkov

