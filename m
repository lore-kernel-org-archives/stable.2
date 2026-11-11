Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417808;
	b=v6U79KUPX1rV1+6082UXQt5Dvo9Fy0MV7mU7kaxpcMRpL9XYm9zXhqaqEmPpOr0L/xu/
	 SWIFSFtlSsyPkJTBqy2G3WvABT8Q724nBDTL6unvliabu2VvyhTLjq/LoFI5Tv4oPtg3U
	 ydMc8a/hjt77yNpCrUw+2pQHh4V/oH9YY6xckkhhRJyTkEC9x6cOojkhe6Hfu05HY0Syt
	 Z6rskJm7OgMfkMMsYMWXheKDPu9GXHgE1dknjgo3zlTblhhV019O0TkpWbpdHNaDLz4dG
	 8k6+2JnWmi8yZnWCgVUz8AZ8xdSeeynFsk44w8vU25xD8Er/NGe6LMDg5T00t8mIR5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=mNxsse4bfiCdfhVUp0bFSnRTdLzHTdzeDYz8TXmmhJU=;
	b=HkwzTi2c6goRDQemO1wybJWwCCZEFkY8Qq/1STY060tlrNicuspFGnKBmmxpzZay2unB
	 ixpmHZkuRchm8MkWb+19XbmUplGLR0ZvGKgVObWXeo44XZEV5Zj0BryPO2JOhk/rYjsfj
	 z3qsZ2fPM9WQ5xhAUVjup9ETv2geJpmsGeJqG68VJK9iL7tEcjJeQuM+Jy4XphWnvg+ug
	 Uru43JrFGHsDTZWCwR5esBGrKIfaqQQ0NVl7RlGKeZH4R6m+WeVz385lvROMm5bclmmA1
	 xfSYCrC61qygDuZk29oIb9PvnG+tzWybSAoFuxNnoYq3SJrR7J2411HL7Odlpyty7eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XCGxseVY;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204C6606A88C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 204C6606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XCGxseVY
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-370230d93efso2018195eec.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794417806; x=1795022606; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mNxsse4bfiCdfhVUp0bFSnRTdLzHTdzeDYz8TXmmhJU=;
        b=XCGxseVYCgbeUYTVWsJLUbMkJSp48CG9x2RJTDfO81GN4yaAIc6+f80/LF39zLrr7v
         1kMf2rohJOpeVXoGTSBA1ASaQXier2gE4xCtkqzqo7q+qYaccHzGqCT6UDHcPMGV/5pX
         q3WDP6acxOQifgDq8nOulKWjxXJnnmWTC5lFmzVf6AqafsIXLNm/iD76XCbmf/EHvj6d
         tlnFG7kC27C033CUyYJ8iEQDuorJ0xXd0sBBVK6obAwMzJX1CIP+nNpY7mgMUP7+7pKJ
         H6QgcBKfkSYK2xjNiRu/syw50CvnUUPShJjI8673qQCcmH8dgWIAXBP7TFrsQpw91x+s
         VIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794417806; x=1795022606;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mNxsse4bfiCdfhVUp0bFSnRTdLzHTdzeDYz8TXmmhJU=;
        b=f+cb5J/TTOo9d8aafNpRKRdsYKLgoqMdthEASMtbvnIdn9V8Gp7claw1eaf2vuEy/e
         SwIegyufjEiqqYxr54T98ghoxMzs+KWvS55jrL2mRt+ePZwUyeNcXgRTjZSnPeGRbr2I
         4P9Zvn1LEqeSGp5AqzOWQ4cLAm+xZTcQ9Rzg6RvL2qQvMnnx6JU5NLWZ/qNQ6Rz3pDLL
         rjECAE6Lz9MFFTNZa7onJEaV8vgo4Y7BR0SeIXqhg6c7no+ZW7j4j6Pf1vyMncev5osu
         PPDIpcGdImtiL/YDcGFtifMmcEYRPOXJy8iIcRStpsUY8gf+AIJ2WqLVmZzs4qXL7jfR
         Vx5g==
X-Forwarded-Encrypted: i=1; AL+hErFZJZfuF63K+lw2uUUezqwtaadCpniaFgxaTwi7J9LMALvwklwfkuSjxofWmAIZzk3WylFLcyk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8E8EKijuROzvvHWB+XDd/IVkLUocg2h/d/UZQsulJs6Kq4znuQ
	ByaNKOaCyCr4Ui6pw1PIEAr6t8Z3HAl4iGP8yKG5L9SJYvN/h0sYIYPX0YXDNs4oGVKOeZMUast
	IDayoYrSysoLRPZV5YylU1qec2cBgUA==
X-Received: from dlbej1.prod.google.com ([2002:a05:7022:c41:b0:1a0:100d:fd6])
 (user=chriswiseman job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:7f1b:b0:149:50cb:2175 with SMTP id a92af1059eb24-1b3c034a4f1mr2618122c88.33.1794417805919;
 Wed, 11 Nov 2026 09:23:25 -0800 (PST)
Date: Wed, 11 Nov 2026 17:23:24 GMT
In-Reply-To: <>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <>
Message-ID: <18e70d7cbc2831c0.3137322e32332e3235332e313736.1920de.0000sendgmr@google.com>
Subject: [PATCH v3 2/2] rust_binder: account for deferred work size in Thread::read()
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
add InnerThread::pop_deferred_work() and Thread::pop_deferred_work() to
drain deferred items from inner.work_list before entering the main work
loop in Thread::read() when the remaining buffer is at least 76 bytes
but cannot fit both the queued deferred items and an incoming
transaction. If any deferred item writes bytes to the buffer, skip the
main work loop and return the drained deferred items immediately without
mutating inner.process_work_list or waiting for new work.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Fixes: 8eb05e8e47f1 ("rust_binder: add TF_DEFER_COMPLETE flag for avoiding userspace roundtrip")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Wiseman <chriswiseman@google.com>
---
v2 -> v3:
  - Add InnerThread::pop_deferred_work() and Thread::pop_deferred_work()
    to drain deferred items in Thread::read() without mutating
    inner.process_work_list or gating on
    inner.should_use_process_work_queue(), avoiding looper hangs in
    get_work_local() on zero-byte deferred work, handling local work
    queue paths, avoiding setting process_work_list when the buffer is
    under 76 bytes, and draining all deferred items that fit in the
    remaining buffer (Sashiko).

v1 -> v2:
  - Reserve BR_NOOP before checking the work queue and drain deferred
    items when writer.len() < 76 + deferred_size instead of skipping the
    read loop and returning only BR_NOOP, and avoid the per-iteration
    work.size() dynamic call inside the read loop when deferred_size is
    zero (Alice Ryhl, Sashiko, Carlos Llamas).

 drivers/android/binder/freeze.rs           |  4 +
 drivers/android/binder/node.rs             |  8 ++
 drivers/android/binder/node/wrapper.rs     |  4 +
 drivers/android/binder/rust_binder_main.rs |  8 ++
 drivers/android/binder/thread.rs           | 91 +++++++++++++++++-----
 drivers/android/binder/transaction.rs      |  4 +
 6 files changed, 99 insertions(+), 20 deletions(-)

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
index 763f0646a1e9..90569477e502 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -322,6 +322,31 @@ fn pop_work(&mut self) -> Option<DLArc<dyn DeliverToRead>> {
         ret
     }
 
+    fn pop_deferred_work(
+        &mut self,
+        rem_space: usize,
+        has_written: bool,
+    ) -> Option<DLArc<dyn DeliverToRead>> {
+        if self.process_work_list {
+            return None;
+        }
+        if !has_written {
+            let min_txn_space = size_of::<uapi::binder_transaction_data_secctx>() + 4;
+            if rem_space < min_txn_space {
+                return None;
+            }
+            let deferred_size: usize = self.work_list.iter().map(|w| w.size()).sum();
+            if rem_space >= min_txn_space + deferred_size {
+                return None;
+            }
+        }
+        let front_size = self.work_list.iter().next()?.size();
+        if rem_space < front_size {
+            return None;
+        }
+        self.work_list.pop_front()
+    }
+
     fn push_work(&mut self, work: DLArc<dyn DeliverToRead>) -> PushWorkRes {
         if self.is_dead {
             return PushWorkRes::FailedDead(work);
@@ -725,6 +750,14 @@ pub(crate) fn pop_work_even_if_deferred(&self) -> Option<DLArc<dyn DeliverToRead
         thread_inner.pop_work()
     }
 
+    fn pop_deferred_work(
+        &self,
+        rem_space: usize,
+        has_written: bool,
+    ) -> Option<DLArc<dyn DeliverToRead>> {
+        self.inner.lock().pop_deferred_work(rem_space, has_written)
+    }
+
     fn translate_object(
         &self,
         obj_index: usize,
@@ -1630,30 +1663,44 @@ fn read(self: &Arc<Self>, req: &mut BinderWriteRead, wait: bool) -> Result {
             has_noop_placeholder = true;
         }
 
-        // Loop doing work while there is room in the buffer.
+        // Drain deferred work if the buffer cannot fit both the queued deferred items and a
+        // transaction.
         let initial_len = writer.len();
-        while writer.len() >= size_of::<uapi::binder_transaction_data_secctx>() + 4 {
-            match getter(self, wait && initial_len == writer.len()) {
-                Ok(Some(work)) => match work.into_arc().do_work(self, &mut writer) {
-                    Ok(true) => {}
-                    Ok(false) => break,
-                    Err(err) => {
-                        return Err(err);
-                    }
-                },
-                Ok(None) => {
-                    break;
-                }
+        while let Some(work) = self.pop_deferred_work(writer.len(), writer.len() < initial_len) {
+            match work.into_arc().do_work(self, &mut writer) {
+                Ok(true) => {}
+                Ok(false) => break,
                 Err(err) => {
-                    // Propagate the error if we haven't written anything else.
-                    if err != EINTR && err != EAGAIN {
-                        pr_warn_ratelimited!("Failure in work getter: {:?}\n", err);
-                    }
-                    if initial_len == writer.len() {
-                        return Err(err);
-                    } else {
+                    return Err(err);
+                }
+            }
+        }
+
+        // Loop doing work while there is room in the buffer.
+        if initial_len == writer.len() {
+            while writer.len() >= size_of::<uapi::binder_transaction_data_secctx>() + 4 {
+                match getter(self, wait && initial_len == writer.len()) {
+                    Ok(Some(work)) => match work.into_arc().do_work(self, &mut writer) {
+                        Ok(true) => {}
+                        Ok(false) => break,
+                        Err(err) => {
+                            return Err(err);
+                        }
+                    },
+                    Ok(None) => {
                         break;
                     }
+                    Err(err) => {
+                        // Propagate the error if we haven't written anything else.
+                        if err != EINTR && err != EAGAIN {
+                            pr_warn_ratelimited!("Failure in work getter: {:?}\n", err);
+                        }
+                        if initial_len == writer.len() {
+                            return Err(err);
+                        } else {
+                            break;
+                        }
+                    }
                 }
             }
         }
@@ -1800,6 +1847,10 @@ fn should_sync_wakeup(&self) -> bool {
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

