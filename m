Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874776;
	b=jqZ0Djkhusb/LCy6ohz3oEIrw1nKPFKHrmoYlbsNEPteL1ftmWmttMEhoQ5mszMxx1GN
	 eViBtyj9cjTDUyzwZ0gc4AXW6mJoxRCHByPNLk65OY92Cr4rfofxGtjUCpVux36gENBke
	 AQkFvHOexY+0jd82JTBS5TuEzzJ/ioXnNynCV+SzwCX0K0a5x7ZZeQ7NRLRiTK5KhL9uM
	 tMYObBvEynTI7XLbuzNXTvMHU8RY//BLYaAOrAY39XSoDf+rDqibNg2HNMowgHA6B8RT1
	 WI3vjsTv7/RdsiYfE6y5rb0NKX+O0BMCbMo+ysOFM8rQwgilZWogFZcYUpydv5oPAgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874776;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lR+NEFZOClI/Q7syF7pUxOZkq4s0tLc9i8788RwMvYM=;
	b=WVNFYrZ4gs4smZsdxZop+ErYdRQzSa/RrMEa9XCu1693iWcsNZgDepTGZafZJTIT5wN8
	 LjA0rN9VV2jE2WXH2edgGINZ0h+fG30V5PYR17KC2YTGPLTLPPrFJed6Tc8nRT25cqGO5
	 rY7eKLDywQazdRrQj9B+R5uN+d7zwsivImgq9haoEL6ijoqCt6ZRczkXXfdwzPooX4pYQ
	 7Plzh4oVL3iHRKo94843JQ+4lqQe00mmppUofwEG4CGqxK3otlkLcQLC9TmMXncdeDsyY
	 uJ/8ki4LbdED4QkmRJLD499HvBEIJXVuXEDkeKRTlOFTlhBjaV6rNJUoSxTx/+4oaxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15FC606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 10:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C15FC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b32daac9d7so3426257b3.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 02:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793874775; x=1794479575;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lR+NEFZOClI/Q7syF7pUxOZkq4s0tLc9i8788RwMvYM=;
        b=mSEd3Vg/M/xgJzGHS45DkdXamZ/z4kxl2AGRyLHRIx520V+9P1ETveeaJllm6JsDX1
         EtVWbJbBDT3Hb7pRyqToJWKJmonEkfSUIJARP6TAgx4kUIwWBnOldy62QGfQyVU6Ye7V
         rz5tNcwn7oD790P53pOBBd62K7Gh94StxIXzClo1zaPRIwOBG4EJTBWPCIo3OFLS1IrH
         Z0tAmKJUaOeP+As5s3yzuyqZaZgATM8QKztiy59ocYkfAtdJuwg9UI7xhaw4SEPjJU8P
         2b/yhR1W7PNeZoNsDWgFZJManvBZ2EyuH95fgRwJU4yZfBa3DCk3XnhhBamNbyy+fX8s
         W6/A==
X-Forwarded-Encrypted: i=1; AKwUvBxNVcuk9PCBYQEYb99DSA5rxuyOcLfpqBR4aTcHETfyXMnGaAp/PsCUF2uAmcDq6GK3WaocED8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OPbdHYJhWcFykYN6WgH3/afUOTCnFP6lg9K+3uyh9dAQSNJba
	aFzvkrZqrKH1HwrEpmysUlSUPpXcpLSA49qtBRWJ7RlCaXLh7X7xtM0R
X-Gm-Gg: AYBFou3JYlM218zf2BFdzH1adgRjkkJtdGw4keT9hHptRpRIt4v92K3cJgZpWAWM5Bf
	gP+fPEIo6DWtkbc2g2xDk0ruDHbKzbDMQdz3mChGQYy301j0YrLWjrM6iwqVCSoX+Nl5bCZiKPc
	63dRrn6hk04ts1IajyzbgpfmMt+fe6qg78LrXKhHDpN/soteomO8IP+xE+rTlWnmbVAhrIwbB/0
	2f4fi9RodnPou5bIJULaC2yHWCa6zIocWBv/64JcPHrf5fGOmSOCq/+W+DfZcdb8Z+eB5tk5HTI
	JUyBmmypls92UQEvfrB5jUZo5J4Y/PYVDAMf5P5m8mWctHcJJkD5wfvhua26VAWYqGvPfxsw8Ov
	hb78YIgT6uddxtWLx9EhGeJ0y4xaKt8MVOFSzqjH3VqVNmiOh4XUb8HmhL9JU5uOnUlvGiXGreX
	A5A+KdOqsK0p1jg+WVSQRB5hfUQtrTp0mpV1AHmG6G6Tdu0XWdWc1VvB8XAQSi3NH4x8viM8sDC
	accmVZCbHjiFOj1OYbQ7bSvm5OVXDyCL8o1KRAwHtS824ZEIPkzPzzyB1YeKPVWB608mbT6rwX1
	0Fk49+/YkWfQ8mjv0xQ=
X-Received: by 2002:a05:690c:3183:b0:8b3:310:244a with SMTP id 00721157ae682-8b328db924dmr11659227b3.9.1793874774842;
        Thu, 05 Nov 2026 02:32:54 -0800 (PST)
Received: from gmail.com ([2a03:2880:24ff:59::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309712e25sm37003777b3.2.2026.11.05.02.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:32:54 -0800 (PST)
Date: Thu, 5 Nov 2026 02:32:51 -0800
From: Breno Leitao <leitao@debian.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <srostedt@redhat.com>, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Handle a reader taking the new head in
 rb_handle_head_page()
Message-ID: <auxXYbBvbupetclu@gmail.com>
References: <20261102-ring-buffer-head-moved-v1-1-165973790be4@debian.org>
 <auxJP5fkEQOkvicE@google.com>
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
In-Reply-To: <auxJP5fkEQOkvicE@google.com>

On Thu, Nov 05, 2026 at 09:15:43AM +0000, Vincent Donnefort wrote:
> On Mon, Nov 02, 2026 at 06:30:11AM -0800, Breno Leitao wrote:
> > I am occasionally seeing the following  KASAN warning when running
> 
> a KASAN warning?

Sorry. It is a regular WARN from RB_WARN_ON(), on a kernel that happened
to have KASAN enabled. I will fix the wording.

> > I've understood that rb_handle_head_page() moves the head page forward
> 
> Drop "I've understood". 

Ack!

> Besides, I am not sure about returning 1. If the nested writer interrupts
> between rb_head_page_set_head() and rb_head_page_set_normal(), it can also get
> RB_PAGE_MOVED and skipping rb_tail_page_update() means the retry will observe
> the old tail.
> 
> All in all, I wonder if it shouldn't simply be: 
> 
>   case RB_PAGE_MOVED:
>      break;
> 

Good point, that handles both writers. The outer one falls through to
the existing UPDATE clear, and rb_tail_page_update() finds the tail
already moved by the interrupt, as when the cmpxchg returns HEAD. The
nested one moves the tail to next_page, which is right because the outer
writer already did the accounting for that page. And the duplication
goes away.

> Additionally, the comment with "Valid returns" must be amended.

Will do.

My reproducer used a two-page buffer, where this retry is harmless, so
I will re-test v2 with a bigger buffer before sending it.

Thanks for the review,
--breno
