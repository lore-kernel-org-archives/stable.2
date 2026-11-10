Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315401;
	b=Ad3ZIA74xrfsG0qHWLuq2QraeWL5EcoZgvzxVPZ9+pERiRU27Bw8TFHVAGE4OlHI1Cvm
	 3p6TM82iMLAFaoQuPzenWBGILBBtFbcTJ4epom19t5Gii61TJxP3AjhQp5lp+l8VR5RKA
	 8VpUZYwfQK9QGcpVpks0mb0Cbr9+/7KKqSJB3FwyMhmTRr5tRirwpqwhZ4bxQ9L1lp/1Z
	 opC5MXTz3whLX55Hp25sTZCkivXW9rbu+wUcpyCTJYh3/MtoiYmoPc59AxG6lvNSfooFB
	 kh4yE2FYmuNxhfifGaAegh5YtfFZ/A+okVpfISigK3iOf+1utps98BINEsVj0V43CpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=mbB3e7982UkOSbYBnDoSPTQDsHK093/mCqRMEDJYaDU=;
	b=FU/6rdjcd6TpKhsFh2A/DVH1wB2wyG7WPAlC3FQ1/HbUkuS50dSUCvC3FuCuuTbcALL+
	 CjrVF1l+BkjcPriD27OuD5X5vKwvEI7yez+7ax2NH8+/1zXPp6dAbEK3HrKewdBu6pDgH
	 q3g2I+lL06jH1yVl9yuQRggorWw6Zo7lyNWXVZ0lp4fDltf5dvq6Ev+iPDGmjaRE/zxyl
	 +Chv2OuBBnJgpWeuj60PsTZtuPAsi2yHvY16KEje4vt4rcpoEnCmfjzca/vnf5VNIQohs
	 VZ92S9ROsX0jzqDk828bHvXZN6nW3fUui1vIfnUlSO3OpCnhvZOtb4txMusrhotVHSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K5phAcJm;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156F260A2619
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 156F260A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K5phAcJm
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36a3451ea93so3056695eec.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794315399; x=1794920199; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mbB3e7982UkOSbYBnDoSPTQDsHK093/mCqRMEDJYaDU=;
        b=K5phAcJm1B3Qq7C5Yx4WZNv6uAmsrnxHCLSvhPo12QQ6f+wGCfo68y8SG2M1WjTBnr
         briX/5JN7mdqOyHRi8v2SKVDrrlLIo2qAXR5uMbLbSMop8ncR+1VeXv2vrX7aRR6sgkE
         TUg2Nwq+2uMQYUKxeEL2mmYBbBsLYEg5uDUjhNEmq9TG99tbCQhjHgAJSL1A2NSXIbND
         YLIT3t44H9jKw9eQNrPWcjdKe7Is9I75BCFpzg+y136Fw4ZN55r07waCo24Ux+9rQuE2
         OSrrwlSjRuemm2Li/XjVHeQmjYfsAWtMyFZPFvmMHwLUSFHkBLj+Ppr3gsCBGpCSbYVR
         bXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794315399; x=1794920199;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mbB3e7982UkOSbYBnDoSPTQDsHK093/mCqRMEDJYaDU=;
        b=O7YYiAUcRf/NvD4/oWCSX4gZgHBIQ+ruHAPyAOV9Waj6eR85O4g0LHVsHZvlcoMMQW
         kvbVAdbj5aca1AYeShDhdVqQLCarC6iMimkCfWRJJGNbwehiHty1OLr2psGmLsqxgLOg
         q3qmXqRM4+RY4yDahEtXav+d5+QWBrd0UUWNHcrgyLstb7eGoo1CNEmKqCL9Z5anS1VV
         Q/IcWtWV9heJarseDR6DmU5wqYSQpmYcwwWqgafINTVerfv/GT2GR7mPuwATRcc3uTVy
         BDvoHltfFbuslgbXMi77U516V85vJ0905bFGoUG5O3tbRlS9mBEnYrApvCoTwTtOfIe3
         MrYA==
X-Forwarded-Encrypted: i=1; AL+hErEftVYCCceQ3SlheqQsRS3IZXmkrBnBnEC0YBxfpPnGbxD36Ku6dT3DO3noIfllebuv9A59T0Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sy2gWJO2g01T/3/dFNBK7Y3xer5M34tavJTcNUEOKBj0M/OY+
	qVLQL8PzppK+YJStMzjY0X25S5QMtinltzRwaS83BleL9TGOUxeOK/DWQ6GBELIh1vsb4Q+e206
	b03bJOzI7PoSqyaZfU+jKnoYDqL110A==
X-Received: from dyr7.prod.google.com ([2002:a05:693c:4007:b0:36a:1148:43f8])
 (user=chriswiseman job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:d588:b0:372:3bad:c861 with SMTP id 5a478bee46e88-37521ab4025mr3558729eec.41.1794315398676;
 Tue, 10 Nov 2026 04:56:38 -0800 (PST)
Date: Tue, 10 Nov 2026 12:56:37 GMT
In-Reply-To: <18e6b051cffc7079.3137322e32332e3235332e313736.3fae83.0000sendgmr@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <18e6b051cffc7079.3137322e32332e3235332e313736.3fae83.0000sendgmr@google.com>
Message-ID: <18e6b059306ac3f8.3137322e32332e3235332e313736.3fbfda.0000sendgmr@google.com>
Subject: [PATCH v2 2/2] rust_binder: account for deferred work size in Thread::read()
From: Chris Wiseman <chriswiseman@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Carlos Llamas <cmllamas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Chris Wiseman <chriswiseman@google.com>
Content-Type: text/plain; charset="UTF-8"

When a looper thread replies with TF_DEFER_COMPLETE, its 4-byte
BR_TRANSACTION_COMPLETE work item is queued via push_work_deferred() in
inner.work_list without setting inner.process_work_list. On the next
blocking BINDER_WRITE_READ ioctl, inner.should_use_process_work_queue()
returns true and Thread::read() checks only whether the remaining output
buffer can fit a single transaction (4-byte command code plus
size_of::<uapi::binder_transaction_data_secctx>()).

If userspace provides a read buffer with 76 bytes remaining after the
initial 4-byte BR_NOOP placeholder (read_size = 80), Thread::read()
calls Self::get_work(), sleeps in Process.ready_threads, and receives an
incoming synchronous transaction queued behind the deferred
BR_TRANSACTION_COMPLETE in inner.work_list. Iteration 1 of the loop
writes the 4-byte BR_TRANSACTION_COMPLETE, reducing writer.len() to 72
bytes, and iteration 2 exits the loop without delivering the incoming
transaction, leaving it stranded in the thread-local work_list.

Add a size(&self) -> usize method to DeliverToRead returning the maximum
number of bytes that do_work() may write to the user read buffer, and
reserve the initial BR_NOOP placeholder before checking the work queue
in Thread::read(). When inner.should_use_process_work_queue() is true
and writer.len() lacks room for both the queued deferred items and an
incoming transaction, set inner.process_work_list when inner.work_list
is non-empty so Thread::read() falls back to Self::get_work_local and
drains the thread's deferred work items without waiting for global
process work.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Fixes: 8eb05e8e47f1 ("rust_binder: add TF_DEFER_COMPLETE flag for avoiding userspace roundtrip")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Wiseman <chriswiseman@google.com>
---
v1 -> v2:
  - Reserve BR_NOOP before checking the work queue and set
    inner.process_work_list when writer.len() < 76 + deferred_size so
    Thread::read() drains deferred items via Self::get_work_local
    instead of skipping the read loop and returning only BR_NOOP,
    and avoid the per-iteration work.size() dynamic call inside the
    read loop when deferred_size is zero (Alice Ryhl, Sashiko,
    Carlos Llamas).

 drivers/android/binder/freeze.rs           |  4 +++
 drivers/android/binder/node.rs             |  8 +++++
 drivers/android/binder/node/wrapper.rs     |  4 +++
 drivers/android/binder/rust_binder_main.rs |  8 +++++
 drivers/android/binder/thread.rs           | 36 ++++++++++++++--------
 drivers/android/binder/transaction.rs      |  4 +++
 6 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/drivers/android/binder/freeze.rs b/drivers/android/binder/freeze.rs
index 69e058e6d818..5103bfac781f 100644
--- a/drivers/android/binder/freeze.rs
+++ b/drivers/android/binder/freeze.rs
@@ -152,6 +152,10 @@ fn should_sync_wakeup(&self) -> bool {
         false
     }
 
+    fn size(&self) -> usize {
+        size_of::<u32>() + size_of::<BinderFrozenStateInfo>()
+    }
+
     #[inline(never)]
     fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result {
         seq_print!(m, "{}has frozen binder\n", prefix);
diff --git a/drivers/android/binder/node.rs b/drivers/android/binder/node.rs
index efdafc202e27..4f4c892cba58 100644
--- a/drivers/android/binder/node.rs
+++ b/drivers/android/binder/node.rs
@@ -754,6 +754,10 @@ fn should_sync_wakeup(&self) -> bool {
         false
     }
 
+    fn size(&self) -> usize {
+        2 * (size_of::<u32>() + 2 * size_of::<u64>())
+    }
+
     #[inline(never)]
     fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result {
         seq_print!(
@@ -1149,6 +1153,10 @@ fn should_sync_wakeup(&self) -> bool {
         false
     }
 
+    fn size(&self) -> usize {
+        size_of::<u32>() + size_of::<u64>()
+    }
+
     #[inline(never)]
     fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result {
         let inner = self.inner.lock();
diff --git a/drivers/android/binder/node/wrapper.rs b/drivers/android/binder/node/wrapper.rs
index edfbccf6e6da..37826349eafb 100644
--- a/drivers/android/binder/node/wrapper.rs
+++ b/drivers/android/binder/node/wrapper.rs
@@ -93,6 +93,10 @@ fn should_sync_wakeup(&self) -> bool {
         false
     }
 
+    fn size(&self) -> usize {
+        2 * (size_of::<u32>() + 2 * size_of::<u64>())
+    }
+
     #[inline(never)]
     fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result {
         seq_print!(
diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
index 56c786475237..361f3a987235 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -163,6 +163,10 @@ fn do_work(
     /// Generally only set to true for non-oneway transactions.
     fn should_sync_wakeup(&self) -> bool;
 
+    /// Returns the maximum size in bytes that [`DeliverToRead::do_work`] may write to the read
+    /// buffer.
+    fn size(&self) -> usize;
+
     fn debug_print(&self, m: &SeqFile, prefix: &str, transaction_prefix: &str) -> Result;
 }
 
@@ -279,6 +283,10 @@ fn should_sync_wakeup(&self) -> bool {
         false
     }
 
+    fn size(&self) -> usize {
+        size_of::<u32>()
+    }
+
     fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result {
         seq_print!(m, "{}", prefix);
         if self.skip.load(Relaxed) {
diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index 763f0646a1e9..ded50a1c964e 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -1601,8 +1601,27 @@ fn read(self: &Arc<Self>, req: &mut BinderWriteRead, wait: bool) -> Result {
             UserSlice::new(UserPtr::from_addr(read_start as usize), read_len as usize).writer(),
             self,
         );
+        // Reserve some room at the beginning of the read buffer so that we can send a
+        // BR_SPAWN_LOOPER if we need to.
+        let mut has_noop_placeholder = false;
+        if req.read_consumed == 0 {
+            if let Err(err) = writer.write_code(BR_NOOP) {
+                pr_warn_ratelimited!("Failure when writing BR_NOOP at beginning of buffer.\n");
+                return Err(err);
+            }
+            has_noop_placeholder = true;
+        }
+
         let (in_pool, has_transaction, thread_todo, use_proc_queue) = {
-            let inner = self.inner.lock();
+            let mut inner = self.inner.lock();
+            if inner.should_use_process_work_queue() {
+                let deferred_size: usize = inner.work_list.iter().map(|w| w.size()).sum();
+                if writer.len()
+                    < size_of::<uapi::binder_transaction_data_secctx>() + 4 + deferred_size
+                {
+                    inner.process_work_list = !inner.work_list.is_empty();
+                }
+            }
             (
                 inner.is_looper(),
                 inner.current_transaction.is_some(),
@@ -1619,17 +1638,6 @@ fn read(self: &Arc<Self>, req: &mut BinderWriteRead, wait: bool) -> Result {
             Self::get_work_local
         };
 
-        // Reserve some room at the beginning of the read buffer so that we can send a
-        // BR_SPAWN_LOOPER if we need to.
-        let mut has_noop_placeholder = false;
-        if req.read_consumed == 0 {
-            if let Err(err) = writer.write_code(BR_NOOP) {
-                pr_warn_ratelimited!("Failure when writing BR_NOOP at beginning of buffer.\n");
-                return Err(err);
-            }
-            has_noop_placeholder = true;
-        }
-
         // Loop doing work while there is room in the buffer.
         let initial_len = writer.len();
         while writer.len() >= size_of::<uapi::binder_transaction_data_secctx>() + 4 {
@@ -1800,6 +1808,10 @@ fn should_sync_wakeup(&self) -> bool {
         false
     }
 
+    fn size(&self) -> usize {
+        size_of::<u32>()
+    }
+
     fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result {
         seq_print!(
             m,
diff --git a/drivers/android/binder/transaction.rs b/drivers/android/binder/transaction.rs
index 48ac942bb75a..6909d7a8a219 100644
--- a/drivers/android/binder/transaction.rs
+++ b/drivers/android/binder/transaction.rs
@@ -762,6 +762,10 @@ fn should_sync_wakeup(&self) -> bool {
         !self.flags.is_oneway()
     }
 
+    fn size(&self) -> usize {
+        size_of::<u32>() + size_of::<BinderTransactionDataSecctx>()
+    }
+
     fn debug_print(&self, m: &SeqFile, _prefix: &str, tprefix: &str) -> Result {
         self.debug_print_inner(m, tprefix);
         Ok(())
-- 
2.47.0

