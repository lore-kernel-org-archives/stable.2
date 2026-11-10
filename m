Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315368;
	b=oTHzIDTMsZUYY7o3mFGf02G1C4AMM/l59QBd9wlLeKla+ZVTmGNSmvMUEFBbqHTachRf
	 aI7GAnqehy57NpECHv02L+Q2IDSsBKNXATLJaGQzHRSciOAWSfIRK49tJK8ZQ1dPLcJ9x
	 4LO76hhXYAGK19GyvIWaqoW5VDxIDu450XDue0f6NY5ly6pUZ7qEJEm4j35Ps9QHTo7Uw
	 8BvVhhOilGmAi1zzzVb2J+4h2KymlVuEC/79LAPGWz/IeSkAqUtXKcKwn9BuKC/+6kxEx
	 93uWKULN7dbneBEEESiaA/vtL/KnKz8TVE8Z1njkyquw2OQFcWI/GBJ0gOvCE3IL+MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=NWlwxuFj+DQX3jMl+7FGPd5G00EQVE6Za7TLRksZ6fQ=;
	b=0LzbBl3FUfhnbBG588fIcrYz5ya4gQSV4WwIQMDdxdrMskzLaPIb0WSReB0GYK+KkntA
	 wI0NxEo8a/doN44ow6T1XR5itquA4DrrL4/CB329p28Z/DG2p4CjCxjmzywMfLSDY/SpJ
	 jPkUbFzqHv2dzBjsLf7tT0zT6oPRAix1SSo+e2i1+5FLGfhE7Cp6bqAqMwOPFrFFhkiPs
	 K+v9w23ZNtebnpAbuctbA/4pJBfnGZSTu0zgxqfl6hYg9sYT9IiekHYdVLvPD3RqVg1jR
	 TvpbmZJGB0Hg1x5A2mGJAsutoR1LyuRK5GjHJsvotxYLExetUmfNP4TOtMbzfMdba0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=E5XnrMV6;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C936606A7F3
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C936606A7F3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=E5XnrMV6
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36fa5673fccso4492143eec.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794315367; x=1794920167; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NWlwxuFj+DQX3jMl+7FGPd5G00EQVE6Za7TLRksZ6fQ=;
        b=E5XnrMV6qRqj4WSBWswjDUsob+bQpt338bcDwJQXGwj7YER2eAEM3l1L23DO28n20q
         GCOGtOFl+FiwnYpivzr2pWwtqIajjBiQyCU5mjGJlnWVyyyvPOPluZCGPOel/PLHlUtE
         5zULMeoNk5aYg6Fu6b4qnC+f761IfhzKXmoJZcJ49F+rzuOcpN9c860JfCcApA4IsWa9
         iPM+3m7asjtAV1nkgwCZBAoXBtfcOSpEKlkdUo7DhgNqHcE6wmGbzNz/kMKzHBuO1Hae
         w8Af6oeeqDNZk5DkXY96fw2S21GWfT5Q7GuWEM9VeQLbsDp5oqrwPnAHiY0qspywg278
         sMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794315367; x=1794920167;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NWlwxuFj+DQX3jMl+7FGPd5G00EQVE6Za7TLRksZ6fQ=;
        b=zHaiz98pIhaVX7cb7soKi3C7aQ3al01i+Yqm5ttXCOvwY+m6NyqLtpV8Bf/Y9u+0e0
         zDY08EhF3/HLfrP4V7xCP9CKyNRHP/3Z2AEFSlsxxDW10++jWdsBbi5F8EO/tKvENdll
         /BTliiultiL3pu7cgXiDiU4f9e8MdtFUVt4hFUFzTm1sUO1RlPHQmxk0GciMqK15Zt8Q
         L6yoQmwHVKgdkyEfqP6NwFGk7aq3ET6WgBKJkY6lVhKVBaoIZt2EeKAFY9n6LIFFbWSV
         mpcw8LrciwqQ4BJIWrlMOar3JU1O99m0c4lg5rVjqmbwYiuqNliMTQ8biPdJ61P2eu8a
         JjhQ==
X-Forwarded-Encrypted: i=1; AL+hErH9jpt5kAplvXQL9HxTSC2i35PmC3sbPN0fpDmmHgDazhpTLdFJ2Q2QAA6ib9M4KhmbdwLJ/wc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hwi/5MoodjkTtQgMK97tSdl1AlOWYyDPbIPkNSaMRcJY4gyuK
	coQGA0xHV1bvAQe0GoYy2tObi0gilUZINqI8U0u/f79udBolm2rlWQ7QeTtnyxo8qHDkTyo5pcx
	kiMMeYfF1Y6+d0tCw0SRQy8K+AJ6oNQ==
X-Received: from dybcn3.prod.google.com ([2002:a05:7300:a903:b0:36f:9364:dc98])
 (user=chriswiseman job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:f503:b0:1ac:91b6:8dfd with SMTP id a92af1059eb24-1b3b6180311mr3139893c88.31.1794315366987;
 Tue, 10 Nov 2026 04:56:06 -0800 (PST)
Date: Tue, 10 Nov 2026 12:56:05 GMT
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Message-ID: <18e6b051cffc7079.3137322e32332e3235332e313736.3fae83.0000sendgmr@google.com>
Subject: [PATCH v2 1/2] rust_binder: reject sync transaction with pending sync work
From: Chris Wiseman <chriswiseman@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Carlos Llamas <cmllamas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Chris Wiseman <chriswiseman@google.com>
Content-Type: text/plain; charset="UTF-8"

When a thread replies to a transaction with TF_DEFER_COMPLETE, its
BR_TRANSACTION_COMPLETE work item stays in inner.work_list while the
next blocking read waits in Process.ready_threads. A new incoming
synchronous transaction can then be queued behind that deferred
completion in inner.work_list. If the thread's read buffer only has
room for the deferred completion, the ioctl returns to userspace with
inner.current_transaction cleared while the incoming synchronous
transaction remains queued in inner.work_list.

If that thread sends an outgoing synchronous BC_TRANSACTION before
draining its work queue, Thread::transaction_inner sets
inner.current_transaction to Some(t_out), and the read phase of the
same BINDER_WRITE_READ ioctl pops the pending incoming transaction and
overwrites inner.current_transaction with Some(t_in). This orphans
t_out from the sender's transaction stack so
Thread::unwind_transaction_stack aborts on exit, leaving a permanent
Arc<Thread> <-> DArc<Transaction> reference cycle that pins both
Arc<Process> instances and their mapped ShrinkablePageRange pages
after the processes exit.

Resolve the TODO in Thread::transaction_inner by rejecting outgoing
synchronous transactions with EINVAL in Thread::top_of_transaction_stack
when inner.work_list contains any item where
DeliverToRead::should_sync_wakeup() is true. Checking
should_sync_wakeup() in top_of_transaction_stack() fails fast before
Transaction::new() allocates the target buffer or translates flat
binder objects, and ignores non-transaction work items in
inner.work_list.

Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Fixes: 8eb05e8e47f1 ("rust_binder: add TF_DEFER_COMPLETE flag for avoiding userspace roundtrip")
Cc: stable@vger.kernel.org
Reviewed-by: Carlos Llamas <cmllamas@google.com>
Signed-off-by: Chris Wiseman <chriswiseman@google.com>
---
v1 -> v2:
  - Move the inner.work_list should_sync_wakeup() check into
    Thread::top_of_transaction_stack() so it fails before
    Transaction::new() runs (Carlos Llamas).

 drivers/android/binder/thread.rs | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index f5965e838a96..763f0646a1e9 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -1268,6 +1268,10 @@ fn is_current_transaction(&self, transaction: &DArc<Transaction>) -> bool {
     /// [`None`] if the thread is not currently participating in a transaction stack.
     fn top_of_transaction_stack(&self) -> Result<Option<DArc<Transaction>>> {
         let inner = self.inner.lock();
+        if inner.work_list.iter().any(|w| w.should_sync_wakeup()) {
+            pr_warn_ratelimited!("got new transaction with bad transaction stack\n");
+            return Err(EINVAL);
+        }
         if let Some(cur) = &inner.current_transaction {
             if core::ptr::eq(self, cur.from.as_ref()) {
                 pr_warn_ratelimited!("got new transaction with bad transaction stack\n");
@@ -1393,8 +1397,6 @@ fn transaction_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResu
         info.to_pid = node_ref.node.owner.task.pid();
         info.to_node_debug_id = node_ref.node.debug_id;
         security::binder_transaction(&self.process.cred, &node_ref.node.owner.cred)?;
-        // TODO: We need to ensure that there isn't a pending transaction in the work queue. How
-        // could this happen?
         let top = self.top_of_transaction_stack()?;
         let list_completion = DTRWrap::arc_try_new(DeliverCode::new(
             BR_TRANSACTION_COMPLETE,
-- 
2.47.0

