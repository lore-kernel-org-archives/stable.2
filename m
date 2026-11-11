Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417806;
	b=QTkX2XWVsexkKieaoRxX05hd6zj/XcCAUldD8Yn7UhgqZv6+qOt5w1HIcPNZidpNcr+4
	 AEBhUnkviNh/mJplvZLjUuFaEaVbXVrepyi2oCKif3o+sUP3eaJIujXGFd0z5dwHmbWqU
	 Q5TgoyNTA90yGERWdGknu+VW1BPg8lDg4jhwt/DBHMmtK7xsmRuIdkotL3xB6c1sTpbG0
	 oY+Ueh5qI28PD8X7PXTOncl+ZI4xK1d4NdQ5Wd2M+gfnZ3Bo3jvQBvi/PdRD9nx6dldmU
	 CRT2JaPhczN/Bw4VAjGevU/kISsR9SVF+q9QZfBII5YkZFDprHojqVFgEYeTbcRPEvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=KoX5MehGX3/HTOl06b+T8IaxlQjMvOZwpuFJnlEfgOU=;
	b=IHGVgiqpASosJQdyQlUrYh3dYKdRFx/vHwE/WDdrbJ7/rCRmmkvOBC19hFor+Uv3NPce
	 hEVGDLpHmpuII4iVfQu5MysbYrfiYcLvTE5ENGo+u8pWLG7FrgziHvuTfA1oA/Hxeq/ir
	 lL4BObvGsHnsOKzDqB92QD6AEuH0DRb7LGNj6rcPFHOR9kKL3E3Am1dcTNytDoyHb311k
	 EGIgXPkIMY+dZL2TtWPPcW44n7g8EI/SszsSRI5YsJcy69GWB7pnU3xguernJWccAY2Sf
	 eDqPTVI9DnpuJyKMYrfeWN2WSjHK4Gb6AEQEV4geXwYA8SBrGwSpX7KRIg6i7ctiqZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JCpGGmgv;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D20606A882
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50D20606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JCpGGmgv
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3763bd79663so1576373eec.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794417805; x=1795022605; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KoX5MehGX3/HTOl06b+T8IaxlQjMvOZwpuFJnlEfgOU=;
        b=JCpGGmgv01ROa2XJ8BaG9Ez8onxmqlSmz/hlN57D7CMPd+ZlGWwNttQ/82wcpvSSN1
         cqrjYhSMCjTe7esaGebFkfKoUYA2ZuhAqOioj1Ev3D+mWPFvhT1bJIRCb31z8wQWUQJo
         8WiNLUMSLkid5JCa8f/gi+SPo5zafc3y20vvjDnntaFM36wCfwV9wlLEyJb2cIXcbGrb
         rPOGLyuiBLx4MaXBzMtmx1ssrrHHvMEYcuX/bijygoyfBvKidh8ACptYlAjdGq5n25/L
         gFFEP1Dh87f/i9Yciy/SUZlOKWuLe9Huo0u0/dIv9ojBmBF5KHPYVmpocvARpw9k23+k
         6bKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794417805; x=1795022605;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KoX5MehGX3/HTOl06b+T8IaxlQjMvOZwpuFJnlEfgOU=;
        b=bn3U/oVt2eSxElnZ4gi8GIpJpJzD+ho0qNzwOGVV3x934hTSr1+1ditiBPW5hBKuwn
         hWAulAQ30GZOA12v7q1chZSZRea3OpkJu5fGZPjBjaRkXlDUp6KVdobPsyVDO8S+InN9
         ZFdn+zs0i25XES10onqGw3qkEY2XTZZU45ddBU1xumYsvYF7JjIWqfW/It/lZTsi33oE
         0OlUJrNhT52/NTT3pYi54r6KgsiatIasUEbzai5PO4ThGNup3IOUuUWeG4iLFPsRbybD
         EpP+Llzdjib4eCJqSLAF6fyEsmyf57S7eJNiabbTMqOH28ZrlRzkmhWI3EN9VmbMzg7D
         gM0Q==
X-Forwarded-Encrypted: i=1; AL+hErEi+amdn7ZCI9gjzZt/JGjJi00679Uj2Ui9viAoGte59xbl1b67/ThDxDnp6oo6Xfbq8dK5Y0A=@vger.kernel.org
X-Gm-Message-State: APuU4Z81LHNalzY24pQufOyLhD5LbcV51MhG44iFptrSlp/wY+Y+Mwdk
	Pe2eMMRUMvBlHFdbg6evKPNKmM35xwuNQUfGfFH8ulMf6GcnSVFawjw0G34uvdz0bW+zbE16Uom
	hEMkpoiwSe031tL23jv0kVUaEFuQJQQ==
X-Received: from dycam1.prod.google.com ([2002:a05:7300:fc01:b0:36a:209:32b])
 (user=chriswiseman job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:62dc:b0:33b:c24c:d31c with SMTP id 5a478bee46e88-37685c7aa0amr3301877eec.7.1794417804955;
 Wed, 11 Nov 2026 09:23:24 -0800 (PST)
Date: Wed, 11 Nov 2026 17:23:24 GMT
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Message-ID: <18e70d7c82c722e3.3137322e32332e3235332e313736.191fb9.0000sendgmr@google.com>
Subject: [PATCH v3 1/2] rust_binder: reject sync transaction with pending sync work
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
v2 -> v3:
  - No changes.

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

