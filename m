Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256773;
	b=2WEmQVQ6PFLmOVn7tUTMY17U9MCfJmruvxZIaiVThdXWUXcsqoxMVecEaFDNYdpjqRGh
	 IBhwJzmL9j8V8R6XH0a/ANsGd3qP0if0M7pelQzWjKjxjBAvd8Ks8/FdaGvIafEEH39de
	 VyLX0pteNldknPbGTsFGaKvKjlw6X1qmFpUrRGynXuUODvqWXhkEpMqAgOvNkhizaU+U9
	 vj3MahgwCrpnZahz9nWfZhbICZcklfGI7L1tUNgAgj37TLSs/9VWuFSSOz1jOOKFA6OnC
	 fSy9pUyDvIzThB7W6WAZw7YOAJD+jUZAG/kNEdFgofyn0Jk1Zo7K2/7HhlB/UVkgWFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=KuRvvkTR2R4DVquqy1RATu/MBL+QfBo9KPmiMXo7Ohw=;
	b=IWntVtvXPIRp+u5CuJ4rF/5eKEJw7bGAkAXX2b1UGT4xOhDcKvV8715JKvr8qoMLH3PJ
	 J/w9zPdH9EivKDH25uwRJIIsYYecNi8W33heWErPBoxWF5ovAW+7xE3RDB10BwOb9+7Qm
	 U+6r5tSnGvNB7+mmMLO7HKfdS2v4ZNpKe6ssmPCc9nRaFTSDVk6ZsDLehlyDTy/EjlOs9
	 J09egpmbDkZsymxiDho6CD5FUh9YCAQmyS+n6iEugSSpDhmPu4hfoenoBloaRDilMV33/
	 /2uVIvNqHEjiQKwGObO439KeyMjmMR949DY4YqTmYaSI0f7zghmOUvm18zATWx2DvNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I15LjJy9;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBB0606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 20:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBBB0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I15LjJy9
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so3058917eec.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 12:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794256772; x=1794861572; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KuRvvkTR2R4DVquqy1RATu/MBL+QfBo9KPmiMXo7Ohw=;
        b=I15LjJy9mP9tULEb+W4bsL6Q5Eu9Q26SiAOKrUnwNo8slVan6k9OpIQsKkdexDAmsp
         ip6P6f2Gxqsm0rHX5ia/eH5Si1w/fG7fXzuJMVfqGDfnNx8m6W+8GB/vF0nV4MuBiz0y
         dVqr+EO6d3fe1carWLOL8NK6adH6qachw0ZdnRlz7e5k1ZNzV/iuQfnDIDdINqunUvtH
         2lEQhtMEl5QHFjohSm9aFg8o0vwOozS+TXd9IgNPU4kR/t3kwlMBUQAcytdTWDBkao3W
         0pseqssl9BlIJS8tSIKus2sCFmsRseI9rqkkCJz7ax5EmAA50+2jYGTKKgPAGgAFFMGT
         pL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794256772; x=1794861572;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KuRvvkTR2R4DVquqy1RATu/MBL+QfBo9KPmiMXo7Ohw=;
        b=wUAsQSaz5Cb8Bs8NVkgdIf1XgO9kuWfNwxBnXiajEWKwq+n8be03X5+/PxnrwIabtH
         dA153SlWhW7M5v4bDYPERwghzlwb/o/DktWdBLJMF7mHDEbTVnBEXIg6VEvwaGJkxFxN
         5QtNdQEZQEm1dWEWc9DDMzyC9Au22O0wZWSuAIHdoEfRgEUCHvvLjZUWAAhUt/3GJ5FD
         RKtMTCjbYsmETE09afgfqBKhpOBSCsjrhIw85GW4nH+LLZzUAyuuDs8yn07hRW0QHj/g
         Wfqe+De/JTsG2CJVyGL/Hn7n2+4cIFRBoTdCNHssnWrlxl92iuPXbdNivwwV+eBmMJSj
         L7hw==
X-Forwarded-Encrypted: i=1; AL+hErFG7mxH/nEVWTSebLfx52AoT/kRjtln+v0wYWhK2DhhEIk/kEJSrhCwDL9nIiIBR0qn7JNCfFw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BkWev8LvfnVtz8rSm+dHWaqQJuE+g0+2NSe7guWw+VwaIydOZ
	JvuE6HRsj3K/Vw+UsmLbzo8aAGLOkTHg0LpG+75OH4BhQGkSTD2yWCUQYuG5jUuQL8vnqm4GLhe
	UPK14yL0MwKGervG+DxjPsQ+SPN5uNw==
X-Received: from dycog13.prod.google.com ([2002:a05:7301:9a8d:b0:36e:8352:e26a])
 (user=chriswiseman job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:4146:10b0:35e:7bfd:4613 with SMTP id 5a478bee46e88-37520219af5mr543711eec.40.1794256771693;
 Mon, 09 Nov 2026 12:39:31 -0800 (PST)
Date: Mon, 09 Nov 2026 20:39:30 GMT
In-Reply-To: <avIb1n3zk7KKdFfj@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <18e61a85b0d13e9c.3137322e32332e3235332e313736.9c152.0000sendgmr@google.com>
 <avIb1n3zk7KKdFfj@google.com>
Message-ID: <18e67b07084c1b9e.3137322e32332e3235332e313736.b064c.0000sendgmr@google.com>
Subject: Re: [PATCH 1/2] rust_binder: reject sync transaction with pending
 sync work
From: Chris Wiseman <chriswiseman@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Chris Wiseman <chriswiseman@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 09, 2026 at 07:15:34PM +0000, Carlos Llamas wrote:
> If the issue happens when there is already a pending transaction, would
> it be better to relocate the new check to top_of_transaction_stack(),
> before we execute Transaction::new()? If possible, we can skip all the
> unwinding associated with this. If not....
> Reviewed-by: Carlos Llamas <cmllamas@google.com>

Good catch - moving the check into top_of_transaction_stack() is much
cleaner.

Since the thread is not in process.ready_threads during the write phase
and is at the tip of its own transaction chain, no new incoming
synchronous transaction can be queued onto inner.work_list while
self.inner.lock() is dropped across Transaction::new().  Checking
inner.work_list inside top_of_transaction_stack() (where
self.inner.lock() is already held) lets us fail fast before
Transaction::new() allocates the target buffer or translates binder
objects.

I will move the check into top_of_transaction_stack() in v2 with your
Reviewed-by.

Thanks,
Chris
