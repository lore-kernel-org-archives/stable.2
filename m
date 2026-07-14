Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6281A377574
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 06:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011577; cv=none; b=AmBGrQAOjj2cbTPkHsP/eGhMq0IFhQfswbK7DNSsj/VRCXZ9xsRowMHv67Q51W/YKQAGckm3TLHn73oA9Xr1eOGvwY0t2cPODSNIBZAYCSIDagvjo6W4P6YiKIygJWPS1Djtfl1+9SRUAMiKOjG5ezGkwSqPE9whd26oaXW8Nsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011577; c=relaxed/simple;
	bh=yZaZM/cloVOGB7NsffHR7t97rhUwy/4LVIahWWLrlCs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jQhBGpvC7bPEhk+SbxZaEN4chfs8TldLUfQvuTlT4kmkWk1hdynmAUljiuEsYDUj8EvkCq+I7ipB1hxO4Q3Eaz3YSGLV6kSuCortPENkEP6FNf3pi0tphZiWRLnTMRruDch7MY89BfOHXAIYrSZyiqYPDpUqki/BtR125VbhJ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FkVSnnAe; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FkVSnnAe"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-490a767b782so4798055e9.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 23:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784011573; x=1784616373; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EfjWLaMcc4WpbJ4ewY6ECXbOkwbyVT6L42tW36hbE3M=;
        b=FkVSnnAe2D40QL0ng9Xeqmq5NdFCTi+BX14krmp8VS96vs6ZapKwRmPEHvVuXxJspA
         frl11RISMCELvlIQcq3SOuVmemDjL2bd84rl4aiOV7RA/bwzCck/N9ILYp4KG7Cej4Ko
         m3u+TXoo3ER5r88hC5YLAgtlWbJaBnm0qXeBt9EIohAkEqqKu/rYQDTwpfpX0VMW/ro4
         TVS2nnt0SMI45OjD0w+rvgM4SPjVn4x8WAvO+9/i3xk3EN+uUtqMm5Wko39RmPFSHpiO
         KgAYlD7L+FeGWiwQ2kzitqxl1i3++YG3gbqvod5Tkt17kJAMMGDZa0Pd8fnfpIcOEKJo
         W/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784011573; x=1784616373;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EfjWLaMcc4WpbJ4ewY6ECXbOkwbyVT6L42tW36hbE3M=;
        b=QmmtWwc81D6EKwI3F989T/qIfJW4YdJ+C47a7+HN7Wh867U9IK1jMpmcIJDHH6itJX
         TNBED/z6GmMw+ec1xPaX5DPl5/PC8YJ4XjcjDxuVtDW1+H6WzT8wXUEJujLGzMgWGC+Q
         CZUBPxcLhfG4mE2z5Xa0r+WrovdXalkpvOwPToMnavTcJ6aG3uY/b2Rvd75cxS9fNCJG
         eS/cFOmo5V7sYX8ZI3lTjepmMep89l5WGtCghVbYwiq3Z9OOval5txQfg789DXWrVS4K
         JqpIeO9UabYLR5NjQOA8K8caKXsNv1eFaQW2zUCcZ34AuMZj19lDAziwmP5EWO9WvTX0
         58Fw==
X-Gm-Message-State: AOJu0Yz/Rme49NAVBaxStrs/WwHdvSuYBi+d9REdak+EhQ0DY5B7BsX6
	xQ8h/iB3/PfsaiZZ8M4Xrlp4HRxROx/KOyTt6SKx0qj8t+wOkbmhz/3P5FPKyjSqxVmZySOWdFv
	dJgINnL/DMeUaA3UlsnFV6NCvt/f9n5tnOPollDf1qO4FtREpGgmVZf9sXrRogXaBzcpa8FwrBy
	v6K/TIXg+3T3JEt5qqK8KxSh0pLaUJaruEkTATK5XGHMiJUcXqagWG
X-Received: from wmbjt9.prod.google.com ([2002:a05:600c:5689:b0:493:b69e:5b1c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3acf:b0:492:3754:15f2 with SMTP id 5b1f17b1804b1-493f8829917mr115586105e9.32.1784011572421;
 Mon, 13 Jul 2026 23:46:12 -0700 (PDT)
Date: Tue, 14 Jul 2026 06:45:53 +0000
In-Reply-To: <2026071331-obstruct-sprig-4ee1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026071331-obstruct-sprig-4ee1@gregkh>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=27708; i=aliceryhl@google.com;
 h=from:subject; bh=yZaZM/cloVOGB7NsffHR7t97rhUwy/4LVIahWWLrlCs=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqVdsG5ZgOaz00i2UadXJf2nKsV4TfKCaLJd8AH
 Z+2z+p/UXyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCalXbBgAKCRAEWL7uWMY5
 RhSID/9vPAso881Ibpw70nP/OlnRzlTRsneT1OQDxBWR0GzJpQP3WOpvJiAUOry+4USfXTN+sEG
 b4yyIGH+OyqKec2lt60rGykaKLdSD168Rw7Qmr6YrJfsBaqkvgZFLRvyWIICkZ/BFRzWwurDh13
 UXfRiJBiuG3k6dLyFwifh4C0GXFj+SGBjImUl/jk7KfZdO34sSLRizdqqz9CxmubClHdVbIepy2
 EG7ZmqRbGe5m3YUUnEoAw1q+lme0MxkPvktYuqW7L7FzLcpaBEL891kXkPXmxVTRpU0F4dgkOpd
 zGHwC3eZgUKdTIUyE+IJrMlLXBK79PYQUYHk7xrGN7LUqi65BM4XKHdQ2NVNmeiIhI58/JC1cAB
 wUJFkxJS8TjD9n2KvxN7EtuXX4XATpn8jpo4pqdLQSe8q35ennSzbnyXq2eNMujjOqsoJ+pdB86
 8WMiI4lE0gE9ZbTvKKGVVVD6OgItnWCCtc68dA06CTabzxvW20vJQs/O9SdwK45xauJU0NtW4jd
 xS4yfktdwVWNIY08osdgx+CEwc5x1Tog1QuflabYs/SH+fYtBdMmzFpX260LyfSnqQgtMT2ZgIr
 R5qn/vb+WnJeEAo0LH5GJMzqEHllFgNFEiV4mnMiKlCuhoRuEsRli5+0/awPER2HAgdDHN1l3Vi QK1fl/CxJML3bgw==
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714064554.2090610-1-aliceryhl@google.com>
Subject: [PATCH 6.18.y 1/2] rust_binder: introduce TransactionInfo
From: Alice Ryhl <aliceryhl@google.com>
To: stable@vger.kernel.org
Cc: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Rust Binder exposes information about transactions that are sent in
various ways: printing to the kernel log, tracepoints, files in
binderfs, and the upcoming netlink support. Currently all these
mechanisms use disparate ways of obtaining the same information, so
let's introduce a single Info struct that collects all the required
information in a single place, so that all of these different mechanisms
can operate in a more uniform way.

For now, the new info struct is only used to replace a few things:
* The BinderTransactionDataSg struct that is passed as an argument to
  several methods is removed as the information is moved into the new
  info struct and passed down that way.
* The oneway spam detection fields on Transaction and Allocation can be
  removed, as the information can be returned to the caller via the
  mutable info struct instead.
But several other uses of the info struct are planned in follow-up
patches.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Link: https://patch.msgid.link/20260306-transaction-info-v1-1-fda58fca558b@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 5326a18e3e640061ca4b65c1b732feaeace61c39)
[aliceryhl: explicitly impl Zeroable for UserPtr instead of using derive]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/allocation.rs  |   3 -
 drivers/android/binder/error.rs       |  10 +-
 drivers/android/binder/process.rs     |  15 +-
 drivers/android/binder/thread.rs      | 190 +++++++++++++++-----------
 drivers/android/binder/transaction.rs |  83 ++++++-----
 rust/kernel/uaccess.rs                |   3 +
 6 files changed, 170 insertions(+), 134 deletions(-)

diff --git a/drivers/android/binder/allocation.rs b/drivers/android/binder/allocation.rs
index d9113e9b98b2..4b08119576fb 100644
--- a/drivers/android/binder/allocation.rs
+++ b/drivers/android/binder/allocation.rs
@@ -56,7 +56,6 @@ pub(crate) struct Allocation {
     pub(crate) process: Arc<Process>,
     allocation_info: Option<AllocationInfo>,
     free_on_drop: bool,
-    pub(crate) oneway_spam_detected: bool,
     #[allow(dead_code)]
     pub(crate) debug_id: usize,
 }
@@ -68,7 +67,6 @@ pub(crate) fn new(
         offset: usize,
         size: usize,
         ptr: usize,
-        oneway_spam_detected: bool,
     ) -> Self {
         Self {
             process,
@@ -76,7 +74,6 @@ pub(crate) fn new(
             size,
             ptr,
             debug_id,
-            oneway_spam_detected,
             allocation_info: None,
             free_on_drop: true,
         }
diff --git a/drivers/android/binder/error.rs b/drivers/android/binder/error.rs
index 9921827267d0..c6a834071f8c 100644
--- a/drivers/android/binder/error.rs
+++ b/drivers/android/binder/error.rs
@@ -12,7 +12,7 @@
 /// errno.
 pub(crate) struct BinderError {
     pub(crate) reply: u32,
-    source: Option<Error>,
+    pub(crate) source: Option<Error>,
 }
 
 impl BinderError {
@@ -40,14 +40,6 @@ pub(crate) fn new_frozen_oneway() -> Self {
     pub(crate) fn is_dead(&self) -> bool {
         self.reply == BR_DEAD_REPLY
     }
-
-    pub(crate) fn as_errno(&self) -> kernel::ffi::c_int {
-        self.source.unwrap_or(EINVAL).to_errno()
-    }
-
-    pub(crate) fn should_pr_warn(&self) -> bool {
-        self.source.is_some()
-    }
 }
 
 /// Convert an errno into a `BinderError` and store the errno used to construct it. The errno
diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index 5e95aee95347..01ca05d083cf 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -47,6 +47,7 @@
     range_alloc::{RangeAllocator, ReserveNew, ReserveNewArgs},
     stats::BinderStats,
     thread::{PushWorkRes, Thread},
+    transaction::TransactionInfo,
     BinderfsProcFile, DArc, DLArc, DTRWrap, DeliverToRead,
 };
 
@@ -967,16 +968,15 @@ pub(crate) fn buffer_alloc(
         self: &Arc<Self>,
         debug_id: usize,
         size: usize,
-        is_oneway: bool,
-        from_pid: i32,
+        info: &mut TransactionInfo,
     ) -> BinderResult<NewAllocation> {
         use kernel::page::PAGE_SIZE;
 
         let mut reserve_new_args = ReserveNewArgs {
             debug_id,
             size,
-            is_oneway,
-            pid: from_pid,
+            is_oneway: info.is_oneway(),
+            pid: info.from_pid,
             ..ReserveNewArgs::default()
         };
 
@@ -992,13 +992,13 @@ pub(crate) fn buffer_alloc(
             reserve_new_args = alloc_request.make_alloc()?;
         };
 
+        info.oneway_spam_suspect = new_alloc.oneway_spam_detected;
         let res = Allocation::new(
             self.clone(),
             debug_id,
             new_alloc.offset,
             size,
             addr + new_alloc.offset,
-            new_alloc.oneway_spam_detected,
         );
 
         // This allocation will be marked as in use until the `Allocation` is used to free it.
@@ -1030,7 +1030,7 @@ pub(crate) fn buffer_get(self: &Arc<Self>, ptr: usize) -> Option<Allocation> {
         let mapping = inner.mapping.as_mut()?;
         let offset = ptr.checked_sub(mapping.address)?;
         let (size, debug_id, odata) = mapping.alloc.reserve_existing(offset).ok()?;
-        let mut alloc = Allocation::new(self.clone(), debug_id, offset, size, ptr, false);
+        let mut alloc = Allocation::new(self.clone(), debug_id, offset, size, ptr);
         if let Some(data) = odata {
             alloc.set_info(data);
         }
@@ -1383,8 +1383,7 @@ fn deferred_release(self: Arc<Self>) {
                 .alloc
                 .take_for_each(|offset, size, debug_id, odata| {
                     let ptr = offset + address;
-                    let mut alloc =
-                        Allocation::new(self.clone(), debug_id, offset, size, ptr, false);
+                    let mut alloc = Allocation::new(self.clone(), debug_id, offset, size, ptr);
                     if let Some(data) = odata {
                         alloc.set_info(data);
                     }
diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index 6a2ddf0039c1..93aa98c2a173 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -19,7 +19,7 @@
     sync::{Arc, SpinLock},
     task::Task,
     types::ARef,
-    uaccess::UserSlice,
+    uaccess::{UserPtr, UserSlice, UserSliceReader},
     uapi,
 };
 
@@ -30,7 +30,7 @@
     process::{GetWorkOrRegister, Process},
     ptr_align,
     stats::GLOBAL_STATS,
-    transaction::Transaction,
+    transaction::{Transaction, TransactionInfo},
     BinderReturnWriter, DArc, DLArc, DTRWrap, DeliverCode, DeliverToRead,
 };
 
@@ -948,13 +948,11 @@ fn apply_sg(&self, alloc: &mut Allocation, sg_state: &mut ScatterGatherState) ->
     pub(crate) fn copy_transaction_data(
         &self,
         to_process: Arc<Process>,
-        tr: &BinderTransactionDataSg,
+        info: &mut TransactionInfo,
         debug_id: usize,
         allow_fds: bool,
         txn_security_ctx_offset: Option<&mut usize>,
     ) -> BinderResult<NewAllocation> {
-        let trd = &tr.transaction_data;
-        let is_oneway = trd.flags & TF_ONE_WAY != 0;
         let mut secctx = if let Some(offset) = txn_security_ctx_offset {
             let secid = self.process.cred.get_secid();
             let ctx = match security::SecurityCtx::from_secid(secid) {
@@ -969,10 +967,10 @@ pub(crate) fn copy_transaction_data(
             None
         };
 
-        let data_size = trd.data_size.try_into().map_err(|_| EINVAL)?;
+        let data_size = info.data_size;
         let aligned_data_size = ptr_align(data_size).ok_or(EINVAL)?;
-        let offsets_size: usize = trd.offsets_size.try_into().map_err(|_| EINVAL)?;
-        let buffers_size: usize = tr.buffers_size.try_into().map_err(|_| EINVAL)?;
+        let offsets_size = info.offsets_size;
+        let buffers_size = info.buffers_size;
         let aligned_secctx_size = match secctx.as_ref() {
             Some((_offset, ctx)) => ptr_align(ctx.len()).ok_or(EINVAL)?,
             None => 0,
@@ -995,32 +993,25 @@ pub(crate) fn copy_transaction_data(
             size_of::<u64>(),
         );
         let secctx_off = aligned_data_size + offsets_size + buffers_size;
-        let mut alloc =
-            match to_process.buffer_alloc(debug_id, len, is_oneway, self.process.task.pid()) {
-                Ok(alloc) => alloc,
-                Err(err) => {
-                    pr_warn!(
-                        "Failed to allocate buffer. len:{}, is_oneway:{}",
-                        len,
-                        is_oneway
-                    );
-                    return Err(err);
-                }
-            };
+        let mut alloc = match to_process.buffer_alloc(debug_id, len, info) {
+            Ok(alloc) => alloc,
+            Err(err) => {
+                pr_warn!(
+                    "Failed to allocate buffer. len:{}, is_oneway:{}",
+                    len,
+                    info.is_oneway(),
+                );
+                return Err(err);
+            }
+        };
 
-        // SAFETY: This accesses a union field, but it's okay because the field's type is valid for
-        // all bit-patterns.
-        let trd_data_ptr = unsafe { &trd.data.ptr };
-        let mut buffer_reader =
-            UserSlice::new(UserPtr::from_addr(trd_data_ptr.buffer as _), data_size).reader();
+        let mut buffer_reader = UserSlice::new(info.data_ptr, data_size).reader();
         let mut end_of_previous_object = 0;
         let mut sg_state = None;
 
         // Copy offsets if there are any.
         if offsets_size > 0 {
-            let mut offsets_reader =
-                UserSlice::new(UserPtr::from_addr(trd_data_ptr.offsets as _), offsets_size)
-                    .reader();
+            let mut offsets_reader = UserSlice::new(info.offsets_ptr, offsets_size).reader();
 
             let offsets_start = aligned_data_size;
             let offsets_end = aligned_data_size + offsets_size;
@@ -1194,37 +1185,92 @@ fn top_of_transaction_stack(&self) -> Result<Option<DArc<Transaction>>> {
         }
     }
 
-    fn transaction<T>(self: &Arc<Self>, tr: &BinderTransactionDataSg, inner: T)
-    where
-        T: FnOnce(&Arc<Self>, &BinderTransactionDataSg) -> BinderResult,
-    {
-        if let Err(err) = inner(self, tr) {
-            if err.should_pr_warn() {
-                let mut ee = self.inner.lock().extended_error;
-                ee.command = err.reply;
-                ee.param = err.as_errno();
-                pr_warn!(
-                    "Transaction failed: {:?} my_pid:{}",
-                    err,
-                    self.process.pid_in_current_ns()
-                );
+    // No inlining avoids allocating stack space for `BinderTransactionData` for the entire
+    // duration of `transaction()`.
+    #[inline(never)]
+    fn read_transaction_info(
+        &self,
+        cmd: u32,
+        reader: &mut UserSliceReader,
+        info: &mut TransactionInfo,
+    ) -> Result<()> {
+        let td = match cmd {
+            BC_TRANSACTION | BC_REPLY => {
+                reader.read::<BinderTransactionData>()?.with_buffers_size(0)
+            }
+            BC_TRANSACTION_SG | BC_REPLY_SG => reader.read::<BinderTransactionDataSg>()?,
+            _ => return Err(EINVAL),
+        };
+
+        // SAFETY: Above `read` call initializes all bytes, so this union read is ok.
+        let trd_data_ptr = unsafe { &td.transaction_data.data.ptr };
+
+        info.is_reply = matches!(cmd, BC_REPLY | BC_REPLY_SG);
+        info.from_pid = self.process.task.pid();
+        info.from_tid = self.id;
+        info.code = td.transaction_data.code;
+        info.flags = td.transaction_data.flags;
+        info.data_ptr = UserPtr::from_addr(trd_data_ptr.buffer as usize);
+        info.data_size = td.transaction_data.data_size as usize;
+        info.offsets_ptr = UserPtr::from_addr(trd_data_ptr.offsets as usize);
+        info.offsets_size = td.transaction_data.offsets_size as usize;
+        info.buffers_size = td.buffers_size as usize;
+        // SAFETY: Above `read` call initializes all bytes, so this union read is ok.
+        info.target_handle = unsafe { td.transaction_data.target.handle };
+        Ok(())
+    }
+
+    #[inline(never)]
+    fn transaction(self: &Arc<Self>, cmd: u32, reader: &mut UserSliceReader) -> Result<()> {
+        let mut info = TransactionInfo::zeroed();
+        self.read_transaction_info(cmd, reader, &mut info)?;
+
+        let ret = if info.is_reply {
+            self.reply_inner(&mut info)
+        } else if info.is_oneway() {
+            self.oneway_transaction_inner(&mut info)
+        } else {
+            self.transaction_inner(&mut info)
+        };
+
+        if let Err(err) = ret {
+            if err.reply != BR_TRANSACTION_COMPLETE {
+                info.reply = err.reply;
             }
 
             self.push_return_work(err.reply);
+            if let Some(source) = &err.source {
+                info.errno = source.to_errno();
+                info.reply = err.reply;
+
+                {
+                    let mut ee = self.inner.lock().extended_error;
+                    ee.command = err.reply;
+                    ee.param = source.to_errno();
+                }
+
+                pr_warn!(
+                    "{}:{} transaction to {} failed: {source:?}",
+                    info.from_pid,
+                    info.from_tid,
+                    info.to_pid
+                );
+            }
         }
+
+        Ok(())
     }
 
-    fn transaction_inner(self: &Arc<Self>, tr: &BinderTransactionDataSg) -> BinderResult {
-        // SAFETY: Handle's type has no invalid bit patterns.
-        let handle = unsafe { tr.transaction_data.target.handle };
-        let node_ref = self.process.get_transaction_node(handle)?;
+    fn transaction_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
+        let node_ref = self.process.get_transaction_node(info.target_handle)?;
+        info.to_pid = node_ref.node.owner.task.pid();
         security::binder_transaction(&self.process.cred, &node_ref.node.owner.cred)?;
         // TODO: We need to ensure that there isn't a pending transaction in the work queue. How
         // could this happen?
         let top = self.top_of_transaction_stack()?;
         let list_completion = DTRWrap::arc_try_new(DeliverCode::new(BR_TRANSACTION_COMPLETE))?;
         let completion = list_completion.clone_arc();
-        let transaction = Transaction::new(node_ref, top, self, tr)?;
+        let transaction = Transaction::new(node_ref, top, self, info)?;
 
         // Check that the transaction stack hasn't changed while the lock was released, then update
         // it with the new transaction.
@@ -1240,7 +1286,7 @@ fn transaction_inner(self: &Arc<Self>, tr: &BinderTransactionDataSg) -> BinderRe
             inner.push_work_deferred(list_completion);
         }
 
-        if let Err(e) = transaction.submit() {
+        if let Err(e) = transaction.submit(info) {
             completion.skip();
             // Define `transaction` first to drop it after `inner`.
             let transaction;
@@ -1253,18 +1299,21 @@ fn transaction_inner(self: &Arc<Self>, tr: &BinderTransactionDataSg) -> BinderRe
         }
     }
 
-    fn reply_inner(self: &Arc<Self>, tr: &BinderTransactionDataSg) -> BinderResult {
+    fn reply_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
         let orig = self.inner.lock().pop_transaction_to_reply(self)?;
         if !orig.from.is_current_transaction(&orig) {
             return Err(EINVAL.into());
         }
 
+        info.to_tid = orig.from.id;
+        info.to_pid = orig.from.process.task.pid();
+
         // We need to complete the transaction even if we cannot complete building the reply.
         let out = (|| -> BinderResult<_> {
             let completion = DTRWrap::arc_try_new(DeliverCode::new(BR_TRANSACTION_COMPLETE))?;
             let process = orig.from.process.clone();
             let allow_fds = orig.flags & TF_ACCEPT_FDS != 0;
-            let reply = Transaction::new_reply(self, process, tr, allow_fds)?;
+            let reply = Transaction::new_reply(self, process, info, allow_fds)?;
             self.inner.lock().push_work(completion);
             orig.from.deliver_reply(Ok(reply), &orig);
             Ok(())
@@ -1285,16 +1334,12 @@ fn reply_inner(self: &Arc<Self>, tr: &BinderTransactionDataSg) -> BinderResult {
         out
     }
 
-    fn oneway_transaction_inner(self: &Arc<Self>, tr: &BinderTransactionDataSg) -> BinderResult {
-        // SAFETY: The `handle` field is valid for all possible byte values, so reading from the
-        // union is okay.
-        let handle = unsafe { tr.transaction_data.target.handle };
-        let node_ref = self.process.get_transaction_node(handle)?;
+    fn oneway_transaction_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
+        let node_ref = self.process.get_transaction_node(info.target_handle)?;
+        info.to_pid = node_ref.node.owner.task.pid();
         security::binder_transaction(&self.process.cred, &node_ref.node.owner.cred)?;
-        let transaction = Transaction::new(node_ref, None, self, tr)?;
-        let code = if self.process.is_oneway_spam_detection_enabled()
-            && transaction.oneway_spam_detected
-        {
+        let transaction = Transaction::new(node_ref, None, self, info)?;
+        let code = if self.process.is_oneway_spam_detection_enabled() && info.oneway_spam_suspect {
             BR_ONEWAY_SPAM_SUSPECT
         } else {
             BR_TRANSACTION_COMPLETE
@@ -1302,7 +1347,7 @@ fn oneway_transaction_inner(self: &Arc<Self>, tr: &BinderTransactionDataSg) -> B
         let list_completion = DTRWrap::arc_try_new(DeliverCode::new(code))?;
         let completion = list_completion.clone_arc();
         self.inner.lock().push_work(list_completion);
-        match transaction.submit() {
+        match transaction.submit(info) {
             Ok(()) => Ok(()),
             Err(err) => {
                 completion.skip();
@@ -1323,29 +1368,8 @@ fn write(self: &Arc<Self>, req: &mut BinderWriteRead) -> Result {
             GLOBAL_STATS.inc_bc(cmd);
             self.process.stats.inc_bc(cmd);
             match cmd {
-                BC_TRANSACTION => {
-                    let tr = reader.read::<BinderTransactionData>()?.with_buffers_size(0);
-                    if tr.transaction_data.flags & TF_ONE_WAY != 0 {
-                        self.transaction(&tr, Self::oneway_transaction_inner);
-                    } else {
-                        self.transaction(&tr, Self::transaction_inner);
-                    }
-                }
-                BC_TRANSACTION_SG => {
-                    let tr = reader.read::<BinderTransactionDataSg>()?;
-                    if tr.transaction_data.flags & TF_ONE_WAY != 0 {
-                        self.transaction(&tr, Self::oneway_transaction_inner);
-                    } else {
-                        self.transaction(&tr, Self::transaction_inner);
-                    }
-                }
-                BC_REPLY => {
-                    let tr = reader.read::<BinderTransactionData>()?.with_buffers_size(0);
-                    self.transaction(&tr, Self::reply_inner)
-                }
-                BC_REPLY_SG => {
-                    let tr = reader.read::<BinderTransactionDataSg>()?;
-                    self.transaction(&tr, Self::reply_inner)
+                BC_TRANSACTION | BC_TRANSACTION_SG | BC_REPLY | BC_REPLY_SG => {
+                    self.transaction(cmd, &mut reader)?;
                 }
                 BC_FREE_BUFFER => {
                     let buffer = self.process.buffer_get(reader.read()?);
diff --git a/drivers/android/binder/transaction.rs b/drivers/android/binder/transaction.rs
index 50bd1cee0f1a..733f452d8f49 100644
--- a/drivers/android/binder/transaction.rs
+++ b/drivers/android/binder/transaction.rs
@@ -8,7 +8,7 @@
     seq_file::SeqFile,
     seq_print,
     sync::{Arc, SpinLock},
-    task::Kuid,
+    task::{Kuid, Pid},
     time::{Instant, Monotonic},
     types::ScopeGuard,
 };
@@ -24,6 +24,33 @@
     BinderReturnWriter, DArc, DLArc, DTRWrap, DeliverToRead,
 };
 
+#[derive(Zeroable)]
+pub(crate) struct TransactionInfo {
+    pub(crate) from_pid: Pid,
+    pub(crate) from_tid: Pid,
+    pub(crate) to_pid: Pid,
+    pub(crate) to_tid: Pid,
+    pub(crate) code: u32,
+    pub(crate) flags: u32,
+    pub(crate) data_ptr: UserPtr,
+    pub(crate) data_size: usize,
+    pub(crate) offsets_ptr: UserPtr,
+    pub(crate) offsets_size: usize,
+    pub(crate) buffers_size: usize,
+    pub(crate) target_handle: u32,
+    pub(crate) errno: i32,
+    pub(crate) reply: u32,
+    pub(crate) oneway_spam_suspect: bool,
+    pub(crate) is_reply: bool,
+}
+
+impl TransactionInfo {
+    #[inline]
+    pub(crate) fn is_oneway(&self) -> bool {
+        self.flags & TF_ONE_WAY != 0
+    }
+}
+
 #[pin_data(PinnedDrop)]
 pub(crate) struct Transaction {
     pub(crate) debug_id: usize,
@@ -41,7 +68,6 @@ pub(crate) struct Transaction {
     data_address: usize,
     sender_euid: Kuid,
     txn_security_ctx_off: Option<usize>,
-    pub(crate) oneway_spam_detected: bool,
     start_time: Instant<Monotonic>,
 }
 
@@ -54,17 +80,16 @@ pub(crate) fn new(
         node_ref: NodeRef,
         from_parent: Option<DArc<Transaction>>,
         from: &Arc<Thread>,
-        tr: &BinderTransactionDataSg,
+        info: &mut TransactionInfo,
     ) -> BinderResult<DLArc<Self>> {
         let debug_id = super::next_debug_id();
-        let trd = &tr.transaction_data;
         let allow_fds = node_ref.node.flags & FLAT_BINDER_FLAG_ACCEPTS_FDS != 0;
         let txn_security_ctx = node_ref.node.flags & FLAT_BINDER_FLAG_TXN_SECURITY_CTX != 0;
         let mut txn_security_ctx_off = if txn_security_ctx { Some(0) } else { None };
         let to = node_ref.node.owner.clone();
         let mut alloc = match from.copy_transaction_data(
             to.clone(),
-            tr,
+            info,
             debug_id,
             allow_fds,
             txn_security_ctx_off.as_mut(),
@@ -77,15 +102,14 @@ pub(crate) fn new(
                 return Err(err);
             }
         };
-        let oneway_spam_detected = alloc.oneway_spam_detected;
-        if trd.flags & TF_ONE_WAY != 0 {
+        if info.is_oneway() {
             if from_parent.is_some() {
                 pr_warn!("Oneway transaction should not be in a transaction stack.");
                 return Err(EINVAL.into());
             }
             alloc.set_info_oneway_node(node_ref.node.clone());
         }
-        if trd.flags & TF_CLEAR_BUF != 0 {
+        if info.flags & TF_CLEAR_BUF != 0 {
             alloc.set_info_clear_on_drop();
         }
         let target_node = node_ref.node.clone();
@@ -99,15 +123,14 @@ pub(crate) fn new(
             sender_euid: from.process.task.euid(),
             from: from.clone(),
             to,
-            code: trd.code,
-            flags: trd.flags,
-            data_size: trd.data_size as _,
-            offsets_size: trd.offsets_size as _,
+            code: info.code,
+            flags: info.flags,
+            data_size: info.data_size,
+            offsets_size: info.offsets_size,
             data_address,
             allocation <- kernel::new_spinlock!(Some(alloc.success()), "Transaction::new"),
             is_outstanding: AtomicBool::new(false),
             txn_security_ctx_off,
-            oneway_spam_detected,
             start_time: Instant::now(),
         }))?)
     }
@@ -115,21 +138,19 @@ pub(crate) fn new(
     pub(crate) fn new_reply(
         from: &Arc<Thread>,
         to: Arc<Process>,
-        tr: &BinderTransactionDataSg,
+        info: &mut TransactionInfo,
         allow_fds: bool,
     ) -> BinderResult<DLArc<Self>> {
         let debug_id = super::next_debug_id();
-        let trd = &tr.transaction_data;
-        let mut alloc = match from.copy_transaction_data(to.clone(), tr, debug_id, allow_fds, None)
-        {
-            Ok(alloc) => alloc,
-            Err(err) => {
-                pr_warn!("Failure in copy_transaction_data: {:?}", err);
-                return Err(err);
-            }
-        };
-        let oneway_spam_detected = alloc.oneway_spam_detected;
-        if trd.flags & TF_CLEAR_BUF != 0 {
+        let mut alloc =
+            match from.copy_transaction_data(to.clone(), info, debug_id, allow_fds, None) {
+                Ok(alloc) => alloc,
+                Err(err) => {
+                    pr_warn!("Failure in copy_transaction_data: {:?}", err);
+                    return Err(err);
+                }
+            };
+        if info.flags & TF_CLEAR_BUF != 0 {
             alloc.set_info_clear_on_drop();
         }
         Ok(DTRWrap::arc_pin_init(pin_init!(Transaction {
@@ -139,15 +160,14 @@ pub(crate) fn new_reply(
             sender_euid: from.process.task.euid(),
             from: from.clone(),
             to,
-            code: trd.code,
-            flags: trd.flags,
-            data_size: trd.data_size as _,
-            offsets_size: trd.offsets_size as _,
+            code: info.code,
+            flags: info.flags,
+            data_size: info.data_size,
+            offsets_size: info.offsets_size,
             data_address: alloc.ptr,
             allocation <- kernel::new_spinlock!(Some(alloc.success()), "Transaction::new"),
             is_outstanding: AtomicBool::new(false),
             txn_security_ctx_off: None,
-            oneway_spam_detected,
             start_time: Instant::now(),
         }))?)
     }
@@ -237,7 +257,7 @@ fn drop_outstanding_txn(&self) {
     /// stack, otherwise uses the destination process.
     ///
     /// Not used for replies.
-    pub(crate) fn submit(self: DLArc<Self>) -> BinderResult {
+    pub(crate) fn submit(self: DLArc<Self>, info: &mut TransactionInfo) -> BinderResult {
         // Defined before `process_inner` so that the destructor runs after releasing the lock.
         let _t_outdated;
         let _oneway_node;
@@ -295,6 +315,7 @@ pub(crate) fn submit(self: DLArc<Self>) -> BinderResult {
         }
 
         let res = if let Some(thread) = self.find_target_thread() {
+            info.to_tid = thread.id;
             match thread.push_work(self) {
                 PushWorkRes::Ok => Ok(()),
                 PushWorkRes::FailedDead(me) => Err((BinderError::new_dead(), me)),
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index a8fb4764185a..2035c2877a2b 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -21,6 +21,9 @@
 #[derive(Copy, Clone)]
 pub struct UserPtr(*mut c_void);
 
+// SAFETY: Null pointer is a valid value.
+unsafe impl Zeroable for UserPtr {}
+
 impl UserPtr {
     /// Create a `UserPtr` from an integer representing the userspace address.
     #[inline]
-- 
2.55.0.795.g602f6c329a-goog

