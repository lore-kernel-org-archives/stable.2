Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253328;
	b=gLSQeMVXAZH6e8CvrVruNNkg8eGR1QWxAjKkWTFNW4KDH777dQy13XU1QMQiePnry/Zb
	 XBf8Ku52GyZPbhb4M33E52YRPSdQ0tcCLr3q/FNB4dvX26pUvPIKv5jktUNSWKDP47JXI
	 arR0ixJ+2rxuJbdXzTA3N5qCizZpOokBwQPVCKhe14ZI7r2V8JEJ77wlMi5frT63Gih91
	 jPkTS5OEoW6aFMnUKB27sKCl2Qt1VQ+nV8V/VQqwZjctqdIlq4UZlzy28cf353PhiBrVd
	 V3Q4pFqj+CMsNYSL8B/dOloG0dbRurFi4qGAxAIIRdQcddDShddkc/pBSV09khOUgig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1pthWRdK4ZkZ8eTK2zEDjJYumkGRyHppHsESDoMnS7Y=;
	b=drMGWLi8pbhLSBau7qOPlE+Lvbw1P1nToeHHZb4Rq13SGZ+2Ce7Bvbj0ZkIO5fi41/cD
	 C2CenDWe8Nm9aHN7PoEUNbVDRmPN/dkqz3HExHA7lKUxd7TDCnx5ozFcCwQYEa99UcODD
	 e1186tW3l3On70lBaUz4Upb7cUcmkuZ7T7RjDqVlfyJhI+a/QoQWKt6IVydGIGUtXq+xq
	 JWLEqUiYe9zzqR6O+z4iI9azY8fsgHzerH6/CU8y+1jBEtCdF0igeHEtwJ6pfTAF7+jh9
	 z0k8/QKoa0KcvvnueElSyAvhuLP8W1lggnVIDXyOa8UpQ9dCXg5K0ChXSApRI61jqTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=myk6mMl4;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E254E606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E254E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=myk6mMl4
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so9585ad.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 11:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794253327; x=1794858127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1pthWRdK4ZkZ8eTK2zEDjJYumkGRyHppHsESDoMnS7Y=;
        b=myk6mMl4KE86xxvQLPdHMiS/I4VRjPrLwDaHQ63euM4WNvXJiD//eeBQhgyfaD0Tty
         CP6lF1SrS02MDV9OR4c17Rb7y5raWXhS8BBA2OcGB6ePGOfYFn83j1hmTvv0woUWPkJQ
         6Aoh7yR9Dr7VPBfMXkekZeh4CsnuiclIvtGL9jajDiX2h78ivVYzsagcCM/HN3OI/t5a
         2xEvyD68SmAK97S0gUHOM1P6SInNOZLExv1wP7veGmJbyTY6+t59R5+puHOuft0N1R71
         h4E+BegJnBmxCSDxs5J5Xa2L1KqyOwExi685dcAzHrfkVHMeFxcgkGEwz4uJnj94Rhbq
         dv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253327; x=1794858127;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1pthWRdK4ZkZ8eTK2zEDjJYumkGRyHppHsESDoMnS7Y=;
        b=pCmXAAvmrZFxEB3D+4dbrX+B8IThGjXp2vBRFgnG5Vm/FwkMTUezuEO+Zpb0lHUHwW
         2PZMyfeCEA936VKaC/Hm8v7sKY/GqPDAKQUI6pLIYqRJ8nEwU40pOWK0KaIT0OMeWl8A
         hLmmfvIaF+XIgY8JN5ja8K8eQAWq63rp+qZXq9kfvKfml5dPRoXPjiXRE9bA359tq5Jb
         /Xuwr3kc9Pk4qvHhAu4z9vqCzwKaL+hr99XPfIMwch4NML4eicOaOcEGTRAF1kw3oAe0
         dyi0VR2T9NoCkPyy7U9aAxNKdKxwdRDoLZpJ35tqhrLF0U/KVHBphSDV/34d2fmGVrFp
         Sf6Q==
X-Forwarded-Encrypted: i=1; AL+hErGu2FG7J/itAuiZKc1UzWJcC3ekmYQljK6i1uSzp9T8uT8Z1g8+2+nSJc+qTg2vZiBgoUGmNKI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Vp2YDBAbnHhyBdybaW1qBSxY3M8WaYgDUL1hCsUX6FEYYGrRp
	h9VI9vbYrba96eHyQVQve/uQmny80EJBWJY8SU2PPOIMA9WdN7IaazG54/58hZlurg==
X-Gm-Gg: AYBFou2snU/djXQq/8YXhuSyYJuUBfZ/5L1RqmKW1QAE2LGdPmoSn17Cy0iZC7x0t2k
	SqShwlMvwTFfmKoR/b3kYyYZKcVtduIGuyNY+6KG1gWisqUmMQS4FX8gT8Z9rQj23MrPkHuRZZL
	dPCu607c3WHZaPeDwLd5uY7CDFNOClMszYCZ5jpHpTIt9t2aBB3P3Zl5alpr/auQ0u8qg5r4g/7
	rexb9/1jste+VbSfQSiGVQeL7AouKXco6cBUNYNbaTsvHTiQdLgod6ScxBjCuRNN52vpnSTmfHr
	jDPisOMf4kWNpYUwXc5hicqf64xGIUbWG24Ui2v+x//95ZBwOSxPUxxC1BP+UuQt5lbb9Q5i7Xo
	X1IeHTwwaAFLB/bJ4+qyGfubnC5OHAHtjRqnZ4fyqiaCLvfZ8SGx8Xfkm/nw8NHSoB4A2AFl1/Q
	Q5m0N30lTIJ0XfSHFuYxCkOJtRBb4YEGN2jjPq4qlcLxoxBvKXx2ZyHulIbJJjFsYO2/wz8UdJ8
	zbQjfLgJ37WKQhCDoqCoXiLNaPY57puQ15OrJmMFuGnjQZQny1oW+3zWNAcKad2JMk1Ax+2vrt5
	+qTnod7bf08jYmL1BkALHi/33CXTfrLEQuJICUa/7a2VbiP/cBUOaXX3xXs5XjUVyVpVMDGehnV
	1A7GqCFeSF60uQa2QEQxQXsSpGeGsIqAS0bal8GJT2OAiq1arcGN43e26ZADEZJuQ4KUUYNdkD8
	+/9Md7nS+8aHNZar+ZpPynag+PwQteyteIIr7401ZbnhhQIfyqDgv+1g9pxRxTJyraTAZPn0yiD
	99RlrTEA5fC6A==
X-Received: by 2002:a17:902:ce84:b0:2ea:4a1:e8a4 with SMTP id d9443c01a7336-2edb81c5bc3mr547825ad.13.1794253326553;
        Mon, 09 Nov 2026 11:42:06 -0800 (PST)
Received: from google.com (25.229.125.34.bc.googleusercontent.com. [34.125.229.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa2a6d79sm55957b3a.10.2026.11.09.11.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:42:05 -0800 (PST)
Date: Mon, 9 Nov 2026 19:42:02 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Chris Wiseman <chriswiseman@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] rust_binder: account for deferred work size in
 Thread::read()
Message-ID: <avIiCpJ3ctbQaExK@google.com>
References: <18e61a85b0d13e9c.3137322e32332e3235332e313736.9c152.0000sendgmr@google.com>
 <18e61a8cb2ff887c.3137322e32332e3235332e313736.9d011.0000sendgmr@google.com>
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
In-Reply-To: <18e61a8cb2ff887c.3137322e32332e3235332e313736.9d011.0000sendgmr@google.com>

On Sun, Nov 08, 2026 at 03:11:32PM +0000, Chris Wiseman wrote:
> When a looper thread replies with TF_DEFER_COMPLETE, its 4-byte
> BR_TRANSACTION_COMPLETE work item is queued via push_work_deferred() in
> inner.work_list without setting inner.process_work_list. On the next
> blocking BINDER_WRITE_READ ioctl, inner.should_use_process_work_queue()
> returns true and Thread::read() checks only whether the remaining output
> buffer can fit a single transaction (4-byte command code plus
> size_of::<uapi::binder_transaction_data_secctx>()).
> 
> If userspace provides a read buffer with 76 bytes remaining after the
> initial 4-byte BR_NOOP placeholder (read_size = 80), Thread::read()
> calls Self::get_work(), sleeps in Process.ready_threads, and receives an
> incoming synchronous transaction queued behind the deferred
> BR_TRANSACTION_COMPLETE in inner.work_list. Iteration 1 of the loop
> writes the 4-byte BR_TRANSACTION_COMPLETE, reducing writer.len() to 72
> bytes, and iteration 2 exits the loop without delivering the incoming
> transaction, leaving it stranded in the thread-local work_list.

ok, so if userspace is setting TF_DEFER_COMPLETE, the read buffer size
should reflect the possiblity of a BR_TRANSACTION_COMPLETE no? I'm not
sure this is a driver issue. Maybe I'm missing something?

I guess we are trying to match the behavior we have without the
TF_DEFER_COMPLETE and using a smaller read buffer e.g. 65-bytes. I
suppose this makes sense.

> 
> Add a size(&self) -> usize method to DeliverToRead returning the maximum
> number of bytes that do_work() may write to the user read buffer, and
> sum the sizes of all deferred items in inner.work_list when
> use_proc_queue is true. Include deferred_size on the right-hand side of
> the while condition in Thread::read() so the thread does not wait for
> global events when the output buffer lacks room for both its deferred
> work items and an incoming transaction, and subtract work.size() as each
> item is popped so subsequent loop iterations do not double-count items
> already written to writer.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Fixes: 8eb05e8e47f1 ("rust_binder: add TF_DEFER_COMPLETE flag for avoiding userspace roundtrip")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Wiseman <chriswiseman@google.com>
> ---
>  drivers/android/binder/freeze.rs           |  4 +++
>  drivers/android/binder/node.rs             |  8 +++++
>  drivers/android/binder/node/wrapper.rs     |  4 +++
>  drivers/android/binder/rust_binder_main.rs |  8 +++++
>  drivers/android/binder/thread.rs           | 34 ++++++++++++++++------
>  drivers/android/binder/transaction.rs      |  4 +++
>  6 files changed, 53 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/android/binder/freeze.rs b/drivers/android/binder/freeze.rs
> index 69e058e6d818..5103bfac781f 100644
> --- a/drivers/android/binder/freeze.rs
> +++ b/drivers/android/binder/freeze.rs
> @@ -152,6 +152,10 @@ fn should_sync_wakeup(&self) -> bool {
>          false
>      }
>  
> +    fn size(&self) -> usize {
> +        size_of::<u32>() + size_of::<BinderFrozenStateInfo>()
> +    }
> +
>      #[inline(never)]
>      fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result {
>          seq_print!(m, "{}has frozen binder\n", prefix);
> diff --git a/drivers/android/binder/node.rs b/drivers/android/binder/node.rs
> index efdafc202e27..4f4c892cba58 100644
> --- a/drivers/android/binder/node.rs
> +++ b/drivers/android/binder/node.rs
> @@ -754,6 +754,10 @@ fn should_sync_wakeup(&self) -> bool {
>          false
>      }
>  
> +    fn size(&self) -> usize {
> +        2 * (size_of::<u32>() + 2 * size_of::<u64>())
> +    }
> +
>      #[inline(never)]
>      fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result {
>          seq_print!(
> @@ -1149,6 +1153,10 @@ fn should_sync_wakeup(&self) -> bool {
>          false
>      }
>  
> +    fn size(&self) -> usize {
> +        size_of::<u32>() + size_of::<u64>()
> +    }
> +
>      #[inline(never)]
>      fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result {
>          let inner = self.inner.lock();
> diff --git a/drivers/android/binder/node/wrapper.rs b/drivers/android/binder/node/wrapper.rs
> index edfbccf6e6da..37826349eafb 100644
> --- a/drivers/android/binder/node/wrapper.rs
> +++ b/drivers/android/binder/node/wrapper.rs
> @@ -93,6 +93,10 @@ fn should_sync_wakeup(&self) -> bool {
>          false
>      }
>  
> +    fn size(&self) -> usize {
> +        2 * (size_of::<u32>() + 2 * size_of::<u64>())
> +    }
> +
>      #[inline(never)]
>      fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result {
>          seq_print!(
> diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
> index 56c786475237..361f3a987235 100644
> --- a/drivers/android/binder/rust_binder_main.rs
> +++ b/drivers/android/binder/rust_binder_main.rs
> @@ -163,6 +163,10 @@ fn do_work(
>      /// Generally only set to true for non-oneway transactions.
>      fn should_sync_wakeup(&self) -> bool;
>  
> +    /// Returns the maximum size in bytes that [`DeliverToRead::do_work`] may write to the read
> +    /// buffer.
> +    fn size(&self) -> usize;
> +
>      fn debug_print(&self, m: &SeqFile, prefix: &str, transaction_prefix: &str) -> Result;
>  }
>  
> @@ -279,6 +283,10 @@ fn should_sync_wakeup(&self) -> bool {
>          false
>      }
>  
> +    fn size(&self) -> usize {
> +        size_of::<u32>()
> +    }
> +
>      fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result {
>          seq_print!(m, "{}", prefix);
>          if self.skip.load(Relaxed) {
> diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
> index 3ca5c95695e4..af7a340adcb3 100644
> --- a/drivers/android/binder/thread.rs
> +++ b/drivers/android/binder/thread.rs
> @@ -1599,13 +1599,20 @@ fn read(self: &Arc<Self>, req: &mut BinderWriteRead, wait: bool) -> Result {
>              UserSlice::new(UserPtr::from_addr(read_start as usize), read_len as usize).writer(),
>              self,
>          );
> -        let (in_pool, has_transaction, thread_todo, use_proc_queue) = {
> +        let (in_pool, has_transaction, thread_todo, use_proc_queue, mut deferred_size) = {
>              let inner = self.inner.lock();
> +            let use_proc_queue = inner.should_use_process_work_queue();
> +            let deferred_size = if use_proc_queue {
> +                inner.work_list.iter().map(|w| w.size()).sum()
> +            } else {
> +                0
> +            };
>              (
>                  inner.is_looper(),
>                  inner.current_transaction.is_some(),
>                  !inner.work_list.is_empty(),
> -                inner.should_use_process_work_queue(),
> +                use_proc_queue,
> +                deferred_size,
>              )
>          };
>  
> @@ -1630,15 +1637,20 @@ fn read(self: &Arc<Self>, req: &mut BinderWriteRead, wait: bool) -> Result {
>  
>          // Loop doing work while there is room in the buffer.
>          let initial_len = writer.len();
> -        while writer.len() >= size_of::<uapi::binder_transaction_data_secctx>() + 4 {
> +        while writer.len() >= size_of::<uapi::binder_transaction_data_secctx>() + 4 + deferred_size
> +        {
>              match getter(self, wait && initial_len == writer.len()) {
> -                Ok(Some(work)) => match work.into_arc().do_work(self, &mut writer) {
> -                    Ok(true) => {}
> -                    Ok(false) => break,
> -                    Err(err) => {
> -                        return Err(err);
> +                Ok(Some(work)) => {
> +                    let work = work.into_arc();
> +                    deferred_size = deferred_size.saturating_sub(work.size());
> +                    match work.do_work(self, &mut writer) {
> +                        Ok(true) => {}
> +                        Ok(false) => break,
> +                        Err(err) => {
> +                            return Err(err);
> +                        }
>                      }
> -                },
> +                }
>                  Ok(None) => {
>                      break;
>                  }
> @@ -1798,6 +1810,10 @@ fn should_sync_wakeup(&self) -> bool {
>          false
>      }
>  
> +    fn size(&self) -> usize {
> +        size_of::<u32>()
> +    }
> +
>      fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result {
>          seq_print!(
>              m,
> diff --git a/drivers/android/binder/transaction.rs b/drivers/android/binder/transaction.rs
> index 48ac942bb75a..6909d7a8a219 100644
> --- a/drivers/android/binder/transaction.rs
> +++ b/drivers/android/binder/transaction.rs
> @@ -762,6 +762,10 @@ fn should_sync_wakeup(&self) -> bool {
>          !self.flags.is_oneway()
>      }
>  
> +    fn size(&self) -> usize {
> +        size_of::<u32>() + size_of::<BinderTransactionDataSecctx>()
> +    }
> +
>      fn debug_print(&self, m: &SeqFile, _prefix: &str, tprefix: &str) -> Result {
>          self.debug_print_inner(m, tprefix);
>          Ok(())
> -- 
> 2.56.0.317.g454f8302e1-goog
> 

It seems sashiko has found a legit issue, see:
https://sashiko.dev/#/patchset/18e61a85b0d13e9c.3137322e32332e3235332e313736.9c152.0000sendgmr%40google.com

--
Carlos Llamas
