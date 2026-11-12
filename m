Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514919;
	b=1RYM+NuJa7ZXehvNPsYGi704vHe8ieMAt9/W5YusgigMApobP9wtkj3XuXSm7DWzCky0
	 KR2KRC/nm9kOTrvO/H+SlS+lOQ8j2SVoTAejT+ywTMauRYNOcE5lbJPYptwEF0HXZv8g4
	 O91T40M0PQl94wmzZ7viT/jwB4NBJz6DSX0a80ThMrn/PzqCbw7ntZVpee8OEF/yegF0m
	 VaXr9O/0kV7zlN03ahhR8MfDuw20y6Jekd8EAJ4dHA89j+I+rlXjsq/kfZK50e8YsF7MC
	 QA5v9zBZF8AUbGpPnh7F3wlWe05bzEdCuWvobt7taA1V/p6iA2pmeRN+wurYwP4fK6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=HLVKQ5q/RC7N1G6VFkxAy6YbPfLl1hH8SPJjv+91rpU=;
	b=P8hHXeXhTnfK1SmNNTSpRwCDR/pI2MtX9r2uEr1JLQUzXEPw9/HOeVzhQqHvjHLWypEw
	 Cfje3iiHH3C85f5Fg/6v5PlfR9/MNVeexAIo761qIYgE0SkA4loz8g2aho09BMEPGz3U0
	 FOmZAZ9PVnRH5E8qpy3N1XehFNelABzuGWkPrvmOIIqz6K53n7Z71muf1DKoraZ0biD0b
	 rYA1El6Zd+9yZw6Pd+Uk4bd6qji2JKF5w2QT7I+eVwC75kq3dIMuiQoz2Uvz88IyKv70X
	 LJSUgfLEPs8Wd5rroA3SdUUHrMxuDJcDJh1dvpZVEqEHSnKE5AlevH7Ew/IKCDxm6WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QHu2CNIq;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D1F606A332
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5D1F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QHu2CNIq
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9f6a16afcso22425ad.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794514917; x=1795119717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HLVKQ5q/RC7N1G6VFkxAy6YbPfLl1hH8SPJjv+91rpU=;
        b=QHu2CNIqST2nEYggP6ih40MK9P1PuDGS206mM+0PL3apX84hoqBNgLDi3Jw6FO3Rgd
         kZqoY35q0bwhxdt+Yw6Su0gbjn6teoE+Fc/8EjRRbF/qouzl/EZDYc/ipqz9ISA5R37k
         RpdfzbrE+4sEGl8p90XD754lUx7ohx3J5QCi7Y2OdU3F1qgyQe254//j2I/TxmYFYHjH
         8cOEDXY7yz2kJHa5+w9LBgkqpNj7Zg1evC3KHU/ntsm646f3SbPYO/tiol92QXWoNUm7
         Bkz1IEd6Zt66EjtSwvvsG+R1R0LjMgTzBSJFUKLtUr5LKR3fI0B1GdZYiuccBCivZZw0
         qltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794514917; x=1795119717;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HLVKQ5q/RC7N1G6VFkxAy6YbPfLl1hH8SPJjv+91rpU=;
        b=ShtM36ZpTE1Ovrb/SNL0/p3XVPLtYybhQCboUiCJIBQEy+VnWEhhCJAYuVPCYtQwWO
         54Km7VdpsUieSxJ4bDGEs9bVKhRl6GOaEpkXrxB06xJJLD2dw/uS8yXurz9jY1uYD3rj
         i/bSXjIRXT0PCc1WdNJqmysmqCfVBpQb85fkZpSrp/IJpXxdQuMpYiSYUo/iN94Dx6Lm
         xJPBH5ukmM1FI1WB6xz1xctirmMzOFsQsjS09edczhtiWUpQ0DgdoYhRphdhLfuq8+Uq
         cSIsqOzn+1n0FrdRAFbok+aAgSXiqLPfDfqMcMvE3UyvONnGrUnR9Y/QrZ0ysh8AAxXc
         zMMA==
X-Forwarded-Encrypted: i=1; AL+hErF+34eqsMKrNumSWYlgJwTy+GrgV9x/bZ7Axlx71fkJ7BlLcegl9o16Wi+pk1AJO+zHxReslB4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Juzz+Fu3MCzy8hguHvRDI5IRnwn7NSKfqx0j8vb6QS0Ox3QcD
	9EWgVxTohfH6w/pE+FJ7ocY/UKqE2G5XFS+isE3W/uqLZ6hGJ2GmuvbmgxAIvBQVEw==
X-Gm-Gg: AYBFou1DLAnDHrRa+qoHX3pWnfK9gQsNzLMVx8I4sY00Ny3H+iEgikerWZiv1z//B5Z
	4Mu+5Ll8Cv/J1vyrBSReSEG3COqa10fJ60GNlFIgbWFv8nF/H/gaBn9q25uM04cHfbUarYM+6Sg
	ZFDrZ3WngU6TMhW3/NyUSBMUgeBSUMsgrNaL0DtScV1ZnWEgxznsggAv2F/xSKIWlk6Fk/xfQdo
	ysLqQL+xHNNeXYdat4SVVuN4inSnjLnoTmXDiHgaivTIAAwcVT7W8hNm6/i5oeUifBA0tPZKU+t
	0409NvDPXDp/86a87X7/aMwOmSRcm1x6IUn7JjvZFn6NF9DEIR3RXuMxNalpdRInqwE35vM2K8E
	JGXErjuHlTLHK0Edn9522XnJSfyJH1K+XSUiaGmBMriwU4yL5NVoRwBDU7jc25299pk2aA6rhi8
	rKpqrEpRh0DqFVtAT/GQHvMwEapCPv+9vLHNQC03ody6BguX5dU+oBKNxK4ai83nycroonJzJr6
	WxC1X4gG01dWEvCWbihxPTcWdilNTfFghJg6VYUfUaKgDVgACQl1RZjW1kFrSVwHJaJfOaeUTRD
	6q4bQ25M3aNSFuP312CchtRHnIQfOZhMXbt3IRnh1O4PXk1lg/m5TVsnQHoAiFmI0CddeVjhaVn
	/QKBVCj+RxE9qrhvOL8wmtyxpFNcodfcqm49NSVXyDgGhnyZGzUrSH5YP7O8UtfnrzYHZiOwPUR
	mL3Y/5T+y8GLVBMcxR1aLCCIzMegSJ8+gUJ6iN4inozZb4qrW9wqrBW5slQgabQtI8f191
X-Received: by 2002:a17:903:2f91:b0:2d5:db38:8010 with SMTP id d9443c01a7336-2edf6d2417cmr6462905ad.15.1794514916908;
        Thu, 12 Nov 2026 12:21:56 -0800 (PST)
Received: from google.com (130.155.125.34.bc.googleusercontent.com. [34.125.155.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc1889960sm227016a12.15.2026.11.12.12.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:21:55 -0800 (PST)
Date: Thu, 12 Nov 2026 20:21:51 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Chris Wiseman <chriswiseman@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rust_binder: reject sync transaction with pending
 sync work
Message-ID: <avYf351-Z3Q2Cd9-@google.com>
References: <18e70d7c82c722e3.3137322e32332e3235332e313736.191fb9.0000sendgmr@google.com>
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
In-Reply-To: <18e70d7c82c722e3.3137322e32332e3235332e313736.191fb9.0000sendgmr@google.com>

On Wed, Nov 11, 2026 at 05:23:24PM +0000, Chris Wiseman wrote:
> When a thread replies to a transaction with TF_DEFER_COMPLETE, its
> BR_TRANSACTION_COMPLETE work item stays in inner.work_list while the
> next blocking read waits in Process.ready_threads. A new incoming
> synchronous transaction can then be queued behind that deferred
> completion in inner.work_list. If the thread's read buffer only has
> room for the deferred completion, the ioctl returns to userspace with
> inner.current_transaction cleared while the incoming synchronous
> transaction remains queued in inner.work_list.
> 
> If that thread sends an outgoing synchronous BC_TRANSACTION before
> draining its work queue, Thread::transaction_inner sets
> inner.current_transaction to Some(t_out), and the read phase of the
> same BINDER_WRITE_READ ioctl pops the pending incoming transaction and
> overwrites inner.current_transaction with Some(t_in). This orphans
> t_out from the sender's transaction stack so
> Thread::unwind_transaction_stack aborts on exit, leaving a permanent
> Arc<Thread> <-> DArc<Transaction> reference cycle that pins both
> Arc<Process> instances and their mapped ShrinkablePageRange pages
> after the processes exit.
> 
> Resolve the TODO in Thread::transaction_inner by rejecting outgoing
> synchronous transactions with EINVAL in Thread::top_of_transaction_stack
> when inner.work_list contains any item where
> DeliverToRead::should_sync_wakeup() is true. Checking
> should_sync_wakeup() in top_of_transaction_stack() fails fast before
> Transaction::new() allocates the target buffer or translates flat
> binder objects, and ignores non-transaction work items in
> inner.work_list.
> 
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Fixes: 8eb05e8e47f1 ("rust_binder: add TF_DEFER_COMPLETE flag for avoiding userspace roundtrip")
> Cc: stable@vger.kernel.org
> Reviewed-by: Carlos Llamas <cmllamas@google.com>
> Signed-off-by: Chris Wiseman <chriswiseman@google.com>
> ---

Aside from the "patch threading" issue, this LGTM. Thanks!

Acked-by: Carlos Llamas <cmllamas@google.com>
