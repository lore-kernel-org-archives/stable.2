Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350983;
	b=sLWFMS8vYJrokKfENMcUs2PPbSnKwPOQmJ0d7TAN3YBpJOMjnYNVMIMnu17xA6a6Xsx9
	 w+D2IsieTa0yLaZhfxLf7LkmIJ2HqG8BTGeyjrkNvRqFNo0fXZk5S2TaM9bSbNTKavZbx
	 7mDKzwAbtG4ajPkRSDIfofnwUAvmI11WTrjpa3mihf4BHB+WDM0F9JO/4BvEBbRW/GYDF
	 uylEmYlf1jFmPtqN9YNsvn9kGRg4LYD6lmfcOmVEPandOnJikN99Iw7Cbc5dNmmDNU4Xm
	 xDC972pnjPhATbN0srQBYIZFDIRlRnnxBDv+FKHtM6zzmLAW7h2BVyT1iTa6/QWsUbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Zb5GE7voOWxwh8UbV4qumyj78WA5sPTQl21oSAR4TuY=;
	b=sRFj2s3oKTiqAQtl67/zAtB1nJFEnIMlaXGXo7Dq9Xtmlj957GkgrrUdzcRLzwFrSShr
	 Ej14bh5KLsBb87M039OS17oPNf28fu1gighjWcv3XFxvypnrrwsPHT/MGi6yPJXaYFWaq
	 uWXCxVhVopWAlZ3tNtS5xF45Ol6IPFnwQet+43mgu4w8uHnm+iPp7/437hS7E384KHU/m
	 wVUH8ljdszGOVKJD8Ct4g09OJbfkFHsTt5axHT+BG2GvUH4A3J2HBW1Hywxu2W3XZv2j9
	 u/ImC/1tDrr1K4Vjk0hQdKF/w/Jax08pgbfgPiHYu1Y6oLCzJEqqDsoWG+OFSoyi4hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=q6wsO1oT;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB94606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBB94606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=q6wsO1oT
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-930c0f9c1b1so261590385a.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794350982; x=1794955782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zb5GE7voOWxwh8UbV4qumyj78WA5sPTQl21oSAR4TuY=;
        b=q6wsO1oTqdGikupBZB0pAkfYl8nLQNYg2IW1q2B4ZhBGHY6PT5ozHH3XZ5pkwQ1qXN
         QY8MLEglOGyRWF+Ab9VavTiAfZnnHryJ/VU5+k+ZxCPDX3ySe3JA8V3TU5razLymCST9
         BKWvX++hciMqb4NRiXYcrQssLabmACzVmlJlMwI3+5VW9iXTJFCQd0Qeac/tl7NhfOq8
         VxtDmwKx0CmCwUcqfiZ6W07fHrJpaHfW+9VvYucycnEfsdPGmBg4SmlUTu1ohw2OOTMt
         dvKKageeSbyuPekO3ReSnE6nYPorGpatcyjYf654TwUKchrGGL3QJ9FgcCXRIOjTKlKB
         oEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794350982; x=1794955782;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zb5GE7voOWxwh8UbV4qumyj78WA5sPTQl21oSAR4TuY=;
        b=FEIovQBF7lpr4Y6+jjt6mLzqsDq2EeU10XVSdx9/KRU95dPbeclUjy4/Ngt7qAxu48
         w99FLvD2d+BydQrgLMX4ouzyyg0CcgC31tYO2mWhBz4ncGXDqzZgKul/Auu5UH1moe0p
         bcNA07hssi2zNI8qTQtP6q59CEZO9M42FVkjY+9i9XrnrkYCEGeDfKx3YTcyH3UZVfuA
         jYsbzkxzjXEXqx2MbYe2etNW8BfkTeE/BXUFYiQm927lZ7wln4r4yCFIQXZMfw64l+nk
         x+WssxwczHW8MZvFlHyjAHU0i+QmjeltGB0yThQG90opb9s3xpPRycrwENr9xxW6jjH2
         n/uQ==
X-Forwarded-Encrypted: i=1; AL+hErFFMO9dqAheOmfDBDVU1+xhiHANF1mjx9C+AOF32bFrvOOhESi6K7wQpky/XzLkp6kPHJLY/0w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6hNMNR+S8iqJZ7WZcH64rCuXNQ4wHQfNyN/YptmtiTOFXv+tx
	31kp4nHUYVWZjOFnn+4jNB2BEqnfzoKVCRcbM3Vd+F+EeuSUmV69qLAk8WziN+3edg==
X-Gm-Gg: AYBFou2slHZecPhP7Drg+xrFSmqprt9LyHefkSjlR7K23vU362uSP6KnZEPZAJw1iKg
	f6MCbslDmQjvkAIOF8TOATvc6f41H5HISLb72RWlL/KYK4DogAjZqr4rrHm+M3uOYBpx6MTuZQn
	2l8tTLnV0YF+sWPw67QgNpZXTNc70DRIFwongx8D9PD0vyGP1ZvES6IFvbKP2vCSdb4jdgW0qiH
	NyVTFad0JoaS/QZpRN8ax43HmwFjBazPnXa7DQ2hoVcYCNn6otCJiYD3YQfi1IO4Czbs6WyrDVB
	OZU5C+axG+RUMrziIh4Kt1XLCMUszv4WEKi2hJjnKh6n7RzDiLx9iNqxYFP3NpUgMXEtzQroODX
	jHbdXn5IisND4LSlQC8Upz9FKG3zS4kUbrOjZP+whUt0ezCYlRIwrhaW/AvjqLxWf0DbpUh/O8h
	5NGZKK6rUB1ttB4UWML8wommH6fFu9RVIttvswYWa3F858CVilBhjw40Ps7EiHa72PsoBGLVnld
	k16uy0PTipmCphHoEc9Bfi/loGe+JxYVJ7JH97zBnq6V0Tb4YApz2oz6ZJxSzA6R3W8oGK4C1ZE
	l1xi3mK+ZdEPSnTiN2iZL8iWA7o36KNW5zKK2F57PymKpWo/E0w=
X-Received: by 2002:a05:620a:3710:b0:93e:e531:b78d with SMTP id af79cd13be357-947afcd2ef5mr91279985a.7.1794350981531;
        Tue, 10 Nov 2026 14:49:41 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::d355])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e3c34sm335467185a.36.2026.11.10.14.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:49:41 -0800 (PST)
Date: Tue, 10 Nov 2026 17:49:38 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: kayano050408@gmail.com
Cc: Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v8 0/4] usb: gadget: gadgetfs: fix ep0 request lifetime
 and event counter
Message-ID: <a63177cc-ab89-411a-a6f0-a8a71925aa43@rowland.harvard.edu>
References: <20261110-gadgetfs-ep0-v8-v8-0-8f90434574fe@gmail.com>
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
In-Reply-To: <20261110-gadgetfs-ep0-v8-v8-0-8f90434574fe@gmail.com>

On Tue, Nov 10, 2026 at 12:13:21PM +0800, Jing Lin via B4 Relay wrote:
> This series fixes the ep0 request lifetime and shared request buffer
> races in gadgetfs, and the pre-existing event counter underflow.
> 
> The first patch covers request lifetime and buffer ownership, the second
> the ep0 setup abort and unbind state races, the third the event counter
> underflow, and the fourth removes the const cast in gadgetfs_setup().
> 
> The setup() callback runs in interrupt context and may not sleep, so a
> mutex cannot be used to serialize it against ep0_read() and ep0_write().
> The shared request state remains protected by dev->lock and the control
> payloads are handed off through private buffers.
> 
> The series was tested with the syzbot reproducer and with targeted
> lifecycle, request-reuse, abort, unbind, stale-setup, and event-counter
> tests on arm64 QEMU with dummy_hcd, KASAN, and lockdep.  The syzbot
> reproducer still exits 137 on the fixed kernel without a BUG, WARNING,
> KASAN report, or lockdep splat.
> 
> Signed-off-by: Jing Lin <kayano050408@gmail.com>
> ---

I'm going to need some time to refresh my memory on how all this stuff 
works in the current driver before I can review these patches properly.  
And since I'm going to be very busy during the next few days with other 
matters, it will be a while before I can reply.

But first, one thought about coordinating setup packets and their 
replies.  It seems that there's an unavoidable race between a gadget 
driver queuing a request in response to an old setup packet and the UDC 
driver invoking the gadget driver's ->setup() callback for a newly 
arrived setup packet:

	UDC driver		Gadget driver
	----------		-------------
	Setup packet arrives
	  Call ->setup()
				->setup() returns DELAYED_STATUS
				Prepare proper reply to IN request
				  or carry out actions needed for
				  OUT request
	New setup packet arrives
	  Call ->setup		Call usb_ep_queue() with reply to
				  or status for first setup

At this point there's no way for the UDC driver to know whether the 
request it was just asked to queue is a response to the old setup packet 
or the new one.  This is a real flaw in the gadget API.

I've often thought that UDC drivers should assign a sequential ID number 
to each setup packet and pass this number to the ->setup() callback, and 
gadget drivers should include the number in their response so that the 
UDC driver can tell whether the response is obsolete.  Too late to 
change the API now, unfortunately.

Alan Stern
