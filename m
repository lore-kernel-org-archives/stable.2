Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284098;
	b=5ibFTQdBNfUK7KxnQ9kppwwRewrYXsZpuWwOI6r34WBXG64TrfRNbznrKmEfTY60pVOF
	 nEfU+inu5V1Zu6X2Z/MkG9ngsWYk76AcfOC4X69PtVKf+kUkKYfqyTJPcotjLzWC+6K+F
	 cxgO3h4b4ZwlicbNO5hg1mksed87O0dzb5X62W2KLwhcLLexjF7Q2yQ15fdoGk2HateHa
	 fvuDWWRaNZ+Bj7ttWxbiLBXbeJMBuXKmtE09h64u/aw1+/4I80VGuQxlbwTvUFIj/5L8Z
	 yAJfBei59A/fg9T5KVS48dlcn+NBcILnNfzeDgW6e8aFnZhg+qdioJVgBbiZ6IRyLXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=bpV5gcaWSkWHUEBL8Okr5cQ7G/7G2sdwutpL6bB3z4g=;
	b=w1pEZCLeJTIyPYKuQ41nhTKgKacdiSQaGBi+XQtrkWmFEW49ckCs6YOMFAS39Opv9qq8
	 yef+bo3sNv047/pgWkATbZ5EugZc+C572fW86cSBNX+rs6hf8gQzTPTnoCsQ2sdjnQeQ1
	 EH5igwm2n8B7TKC7AeGs8n1mqmfyhEB/WW08q5HVMbyANEjKU3UTZy5OXov7EyGutLvxx
	 j1mD5+Zsa2onBO8amgWxwbHGTJ64ewX8qyTQ3c65ihTknQ57zKgmZ8rH6RLjHVcVIsb4p
	 F7FEzafG8uFTwc9By3cIY9SoXVyDhl/q1bvE4ZJwnD2DrUBPTj5r2MDKAhwpoN7YYCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YTQt+RsK;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CED5606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CED5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YTQt+RsK
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso4077806eec.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793284096; x=1793888896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bpV5gcaWSkWHUEBL8Okr5cQ7G/7G2sdwutpL6bB3z4g=;
        b=YTQt+RsKeGeqRm58rExDSoJf1LlAzH2oCnoB6dsZh2p3RdPDyv9eA+0gM0Q85L5gGY
         ASaci6PrkVxZ3D/x7UoZwLVV28Ezj2rrRKeMUzCK0JLVJEyzFG6MowICYMIDIVMf9V7n
         ga+WGghQpE4yEid7EUHieMjIWXqyp9DoCi9XVTo6S8/ztLQoEiYRbcvjC1rEATl/+4PS
         C7cdu01VIPpXC/ii8r5aGm1fQfw4TP452dLvUx8P74DYmM0ELrjlITCYY6OL90tSKQEB
         Lji+omTSPYgsxilVbQb/RXl/wWRGfMoW+KASWpqnxwyrcKJxhvG+bquhbw0KgCuR5KZN
         B8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793284096; x=1793888896;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bpV5gcaWSkWHUEBL8Okr5cQ7G/7G2sdwutpL6bB3z4g=;
        b=NipfhtgQ1+ShQJ6CVNvN1FdR7+/q3SNCfbha4mzdM2a3HoIkCKC4pFwnjCjuUHJ3Ms
         OaTwL7dVNI/cXmlWDCJLw97NCEraW/SXQ7/xJ+6ZuBBoqYmpXOKrQjpom83tiUbMXMhc
         4DKZjjWz9vuxRYV2XHBnqt5eTklWaf6kmxBMidywAnM31qLq5BPpfwggN7VCLgkCBoc9
         Vqm9b7HD6Tw3xUVmqNR6kekLbXBQJSgfta7NWXF8Jmmh2sVMAB+Q69BQGYWuCwzlm20V
         5xqjvzo9qdoCjemyDTVOAdzWQuuIVlXARD6IHP6r6B3sNvJlCfAJ1pI2l2PtLBeiDscE
         pLTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwlYMYRvC8Hz/gu9kAD1JzR6icC8Xa2trF8ZtCC/htBnoM/CcFuq6WmyvoGrArpxvLxxTgoeDI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJe4ZV38DhjZCHQrAkh88dz4XuyCJxCbJUcbAyOwV2kbbhQZmD/
	7yfsoaUjMyU4Ny11Y6QC68iuTH1fwDBYQb9R4bm9bIXBVt9OA5oHKAoZ+GdM2j5VGn4=
X-Gm-Gg: AYBFou2UFolixSOSUKyGdgbdJKRklhdyJbT3I8YnjT+cBudz88GfNvqy/QTe8E66e4Q
	VZ0ZKbdvI2OasEEwqvYIbArKnhPr7CsdyXIZzQ7uQ5KUddUxOKsw6OTvyNUX8DNQr7xsOmygMvI
	5Pvd3QKRbLH+K/xxzAP7rdsimGNTbmHKen+LvI6GpoFm1SclRgddShsZhFSjeNpqMq8RWa/t8pg
	Cxwmy/9W9YVg3dJq+ChorZK8PnIuJSIltZFDXlZDIj1ukdcWHzGcbg6bNCPsRwdMh6dnWB1u5Jb
	maZ8JAryrvbx/IbYPnxE5jWe0CEeKXMxIG5Cg/5AQFCoXipa6z35DNVbyGUqNVRjjDT6Fh2n9zu
	OEN21cRX0qxan8rddBJ6fQZFm3ujweUw7zDUN0HmET3IDX5VOCu7W9l6XFo3r6U7ppTdb3DiSSW
	7yluad8Adgrq9IPIwgbVXeGIzNxxrOlg+nNbaN6QrLH36zyhV53oq6c8AtYtWewkNYaNtXG0aCn
	At5g35eQokaEtsSlHt43ILakmjRDirENZOSgZCn4pj6BFb3iZKAMmEDU/5J3ghLLBH+1waKNDrQ
	w11CYnph+Tog/OZJd6Ce6S38y923/tMAxKyiwZjPg0SSRRn5MuvBAbZg9CCnvwuH/yJs6EwNFSC
	Yde8YJArM0P6j
X-Received: by 2002:a05:693c:62d2:b0:368:40c6:3a01 with SMTP id 5a478bee46e88-36a1ffc5574mr8656318eec.2.1793284096076;
        Thu, 29 Oct 2026 07:28:16 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23951e00sm22271573eec.20.2026.10.29.07.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 07:28:14 -0700 (PDT)
Message-ID: <3fa26fac-5317-4c09-a181-c9c15e124972@kernel.dk>
Date: Thu, 29 Oct 2026 08:28:13 -0600
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
Subject: Re: [PATCH] io_uring/napi: fix list use-after-free on PREEMPT_RT
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Anvik Loitongbam <permissiontogallop@gmail.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Olivier Langlois <olivier@trillion01.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 stable@vger.kernel.org
References: <20261029102244.141621-1-permissiontogallop@gmail.com>
 <502f31ed-dd70-469c-b433-577ccee36c3f@kernel.dk>
 <20261029094842.58dc252d@gandalf.local.home>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261029094842.58dc252d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/26 7:48 AM, Steven Rostedt wrote:
> On Thu, 29 Oct 2026 07:42:09 -0600
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> I don't think your analysis is fully correct. On PREEMPT_RT, spin_lock()
>> should still be an RCU read side critical section. __rt_spin_lock()
>> calls rcu_read_lock() after taking the rtmutex, and then
>> rt_spin_unlock() drops it at the end. There's even a comment on
>> kfree_rcu() callbacks in there too, it should not be able to run until
>> napi_lock is released, which is post the loop.
> 
> Good point.

If even the preempt rt people can't get this right, that's a little
worrying :)

>> IOW, I think this patch is unnecessary - there's no bug there. The list
>> safe change could be done as a cleanup, but it's not a fix.
> 
> I agree, it should still be applied, but as a clean up and not a fix.

Sure, like I said, as a cleanup. But would need a resend as the
analysis in the commit message is entirely wrong.

-- 
Jens Axboe

