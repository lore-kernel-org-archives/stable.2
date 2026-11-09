Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794251741;
	b=wdJws9I0Vd/J4byNutcIlL9aAvNeNdtw+L1GPR9g95NQDpgEb7MtEocQB+FmlFUKdPml
	 mqAF3A5LKEZXyCLVCmusQeICO3McVUNcA3nPewk0bY81HUukIVkyXpIQd3E+zCbhMt9bZ
	 KKlH2ibnQrgxcdU38Q3HzaxRorSrkr2hWXI+WsAlFmysCWDqFpSEDCwhps5bISyx/XyI/
	 VrBpgAg02yRWyh6hPuS9tuXSw8uArO8Y3ioPmanuAWxmtAsHu4cxwQ4SDiWmPIbGmp6rp
	 WwUKcrGCiJ0GoFIdsQNlz2+HiBuMoXMdYMEms0vCgUwVS3XALL619k+lqDXKrqKA2Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=GrUZJVeF5sY/cVx8v9rGUseT6GRoFxsf2dttb4YQUgo=;
	b=gZC1AEcrj82U/o+UjSS0RNWIRBL256VmjREtQYdfxmHVE7whnUNNjPokMX7VVD/Giwf8
	 naNe+Yf9M9T/QJbkOjWz/v605OQmi0SEhOuAlsKHZhjnM1edGaIaMp/EWEkY5s7U6qke5
	 CFdiQexdLBh7M+aUxMad7v9yEpxpLTNoxkmk1mw+B68VDRkbCJbzhkb1RCKImblQTs3ic
	 /cCitC1K1vv7x33HouiAxMpH3ErRCCQtGMKyisrAoVyI0ILB+vBI/FKuwRysjDLTr/nNu
	 IgBiI2+l9yK3wfOtBseiqti7uYDnMZth0UfLoa5gnDuIM8TIYQhpACNhbgkGFSjNy6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b62pqDy1;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42B606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE42B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b62pqDy1
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ed3f563739so7135ad.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 11:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794251740; x=1794856540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GrUZJVeF5sY/cVx8v9rGUseT6GRoFxsf2dttb4YQUgo=;
        b=b62pqDy14TCopaQGk/31fAvQW+KtHpoxHJYVFGmy4VkgmFW22BQfHeqxcaHnOvTP/7
         DLyXJKDQNu9FZTmJz37+rIhB6QrbnmmWWvlWmKCl8coLZ3G1pTDu7OArewcQn8E5msyp
         8HAKr3kzn0sLvBxZXiDcp8hevGxqyLPW5Qe9ckWIc8RG4mVwhWl5eA7oYqF3lBy3Z01Z
         NLTxAnu0DdgAjHzNxkt9MuFiIx1e6TvsIZJgRHvCp1aPyOQAsBpLdZh1yPt7IwejWOFA
         Z/dxDOda403RAJA7zfZKVKKtOqtLkwC7ZRyrWEvEP4Vquu0j2qwb9qBYjYflyF+Q8KCP
         7vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794251740; x=1794856540;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GrUZJVeF5sY/cVx8v9rGUseT6GRoFxsf2dttb4YQUgo=;
        b=eRYf2vlUNYehCpEvUhSpuDgL+oLtECofjMnazjFMu3Z/VAbhbHVWFi9OFvaSJ4OVe5
         inZ/TgxsL8n7iV/2tP3fOE1/TuDJnB3fa1GFrEWnBCEDESZ1K8L+DpN/u//nU34vvtiw
         UNyrutcMhUf35mKQL1P3TGlBcJtuD1Bplp6ocCOAQtWH9DXPAcEs/QsANxEOplgi2BS1
         M+WvlbaDizXjGfRMRRRTGF/YIhOtFzU1GqIRv+a9mJD6yNhF2cVqYcRW1S8JZ92MERVo
         Vyc/yjYG5OLcKHQKkiuFa2e82eWOMHGr21wSHgkSbNOXSc81KMxN7UhJTeWvD6DJ3cri
         rptA==
X-Forwarded-Encrypted: i=1; AL+hErGqJiiwxVrfa6VP4mPvvtkXGxWxFhtwZF43ART+K8pqAO+RpgSArLSdnk9XkCzbRE9bAX2G8K8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OSk7g7DFASbN53k0exrkbnLpKZEm7Koqy3rPzwCKWdk4VX+2c
	wSNsrvvfET1DlqMvOg3mq/EOOm0dLlFGrVz0C8QgnteibpLRGlrTQqfQA3a/hF3UvQ==
X-Gm-Gg: AYBFou1jyx7oSwh7IfuplWf6bQotHLrlX+Tc1cinXWBaZPyoJeKxW7TIbGu9m/Q0pA3
	bi4cgcna2LFkkUibI77LBF5FZN3+3fPWAgX4Xfm1CeHkdRVYvElSzcL3+J9Kv0N9L9QG0w72vCr
	MlOMpMMK4NH7Vz4XrQkOa62e/OLmXQhHcwIQidKDM4uBqAgkvL01eetMa+P9JFAPGqR2m0NiDVY
	MMvb30Fj3BBCo5iEPi4eLZJ2yQNY6WxoSZdvdTn9DJGuTBmGHXGH3sAOOol5LLjx2S5bdkW4eh6
	DVWsrubaeoGSEfapRoIjXCHr90ADWSzQE6I/+yBcJO/N6ZcLCOAeZv1dbfXzibdmc8mKsa9iMYN
	12T1xPIQ+bHmPzB1cxoWV19nqnVL0bLf1p2ZTwm0PYYynb3XxlGrrfyr9pwTKYBROgBW7xt9V3g
	RGpxymjRRZCTb6FpzKxUBzbk/8o2ub8KDFICynsJfmCtO8HBh7td5p6jYki0Vsc8663IeYomrCf
	SxhW38n+xp0PpM4Glc7xVBdtdWM1p0EbUl2YwKQtGeR10iAbs+zitnPTqgD6cHPg8m1PsU6xPJM
	2UQa8J0RTFzdims9pm64Mvby272DOMbYjN9BICP2yPRSscrkZiT2MqxEKQ+gKFIkG2aWp1OqgEd
	tBJX/DubM++vrQfkER6ORX+xnwaiGUhxlnjLe0cpYfMRI3yCZQ0DY4/hUEeZK5sptEelQPEYh9L
	SVcXEXn0hakFWh0gqAotKNpeWCGIX/a2ciVsFWO0DKFu+P3OLJYEPYKrnmL6yzfTHU
X-Received: by 2002:a17:902:e80d:b0:2d5:db38:8013 with SMTP id d9443c01a7336-2edb70335bemr923045ad.18.1794251739421;
        Mon, 09 Nov 2026 11:15:39 -0800 (PST)
Received: from google.com (25.229.125.34.bc.googleusercontent.com. [34.125.229.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaae3e9dasm35868b3a.34.2026.11.09.11.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:15:38 -0800 (PST)
Date: Mon, 9 Nov 2026 19:15:34 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Chris Wiseman <chriswiseman@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] rust_binder: reject sync transaction with pending
 sync work
Message-ID: <avIb1n3zk7KKdFfj@google.com>
References: <18e61a85b0d13e9c.3137322e32332e3235332e313736.9c152.0000sendgmr@google.com>
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
In-Reply-To: <18e61a85b0d13e9c.3137322e32332e3235332e313736.9c152.0000sendgmr@google.com>

On Sun, Nov 08, 2026 at 03:11:01PM +0000, Chris Wiseman wrote:
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
> synchronous transactions with EINVAL when inner.work_list contains any
> item where DeliverToRead::should_sync_wakeup() is true. Checking
> should_sync_wakeup() matches C Binder's BINDER_WORK_TRANSACTION check
> and ignores Node or NodeWrapper BR_INCREFS/BR_ACQUIRE items pushed
> onto inner.work_list when Transaction::new translates flat binder
> objects.
> 
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Fixes: 8eb05e8e47f1 ("rust_binder: add TF_DEFER_COMPLETE flag for avoiding userspace roundtrip")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Wiseman <chriswiseman@google.com>
> ---
>  drivers/android/binder/thread.rs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
> index f5965e838a96..3ca5c95695e4 100644
> --- a/drivers/android/binder/thread.rs
> +++ b/drivers/android/binder/thread.rs
> @@ -1393,8 +1393,6 @@ fn transaction_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResu
>          info.to_pid = node_ref.node.owner.task.pid();
>          info.to_node_debug_id = node_ref.node.debug_id;
>          security::binder_transaction(&self.process.cred, &node_ref.node.owner.cred)?;
> -        // TODO: We need to ensure that there isn't a pending transaction in the work queue. How
> -        // could this happen?
>          let top = self.top_of_transaction_stack()?;
>          let list_completion = DTRWrap::arc_try_new(DeliverCode::new(
>              BR_TRANSACTION_COMPLETE,
> @@ -1407,7 +1405,9 @@ fn transaction_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResu
>          // it with the new transaction.
>          {
>              let mut inner = self.inner.lock();
> -            if !transaction.is_stacked_on(&inner.current_transaction) {
> +            if inner.work_list.iter().any(|w| w.should_sync_wakeup())
> +                || !transaction.is_stacked_on(&inner.current_transaction)
> +            {
>                  binder_debug!(UserError, "got new transaction with bad transaction stack");
>                  return Err(EINVAL.into());
>              }
> -- 
> 2.56.0.317.g454f8302e1-goog
> 

If the issue happens when there is already a pending transaction, would
it be better to relocate the new check to top_of_transaction_stack(),
before we execute Transaction::new()? If possible, we can skip all the
unwinding associated with this. If not....

Reviewed-by: Carlos Llamas <cmllamas@google.com>

Thanks
--
Carlos Llamas
