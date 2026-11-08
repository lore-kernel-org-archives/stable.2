Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794150695;
	b=lEOMw9yhcUvSZ3cuuiyKlH4ax0UiMfPqAewqIQvGJ+qzvlzkhTIsKXky0GrBFlgZ7GVX
	 pJry0UuzwnZrkqNNs6bnjo1uTixyGxXEYvcnqz8IxyLIv0GOkZlnCBqHXQ2pQun6l+aNJ
	 I9wU/GTfU7PRp2UzTbf2NPSRoMEb/W2ZYI69FqHT/rYRsMsvFAK9PYMmJMx//uxjNfH/1
	 Ymv747+PQwYMXodJdylhIX2HT5ffVdAmeUUAVnp495p0K0HHuocvLW41Ck3iP7LBJ4+di
	 CX4X+v9qVsHfRdIFE7iLY1pXPtNTtcZbAISuXHo/WWFVDsJ4ngWcqzgd3roxZb3IS0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794150695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:MIME-Version:X-Received:Date:
	 In-Reply-To:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=i5PPzRt+yxwpbv/xozk5+L1M/Zvyd7L2ZCDx2pqWy3g=;
	b=E9llzx8XZx2548FnxN5+uBz35NwdzHHyRDS0wTZrYcuCPDSVWoDkMmT9HdKCMJFuVs3+
	 2nFkeG4vMTbsZVlp0M/UrgCyLr5aN2ldd8QtUWcpT9VcyOH8T0YMK2FsgxtZjI3M85O2/
	 kxM/Gsq18J3AHK8X2ie3xi6ox7jDBco9NfikYtH4UR3EcKzobAljUzGrnqnWQ9dq81GD0
	 juuRT7AyupAWentJlGCY13WBPRY+rvIqQ+n/mcsMfwDWSrsGgs7JGBgTGtROR51ETvNNN
	 WqhSv2tIHahRRL8s1DGg/kXXLHS4Xz0TQdyM3L63hvd2ZBsObwGgemfZvg92sSPNRtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VgEv6dDP;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7806F606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 15:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7806F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VgEv6dDP
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so343262eec.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 07:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794150694; x=1794755494; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:in-reply-to
         :date:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i5PPzRt+yxwpbv/xozk5+L1M/Zvyd7L2ZCDx2pqWy3g=;
        b=VgEv6dDPvu0Z5b+IMKhS7/k/c2BLJe1AgyQEMMUsgamTt5OUW/nH/nRYHB4v56RYpy
         7OfTZNlokFlvYSQcqWbwzraNYY1K4Xf6q3nKoMe9mM42yzYOJ1kbzWtb1ujKOlr7Kad5
         lRFjXyIt9zWu9CoM9pFX4o+OCwbb4StF6Z2z9iOBlmj6A3HfaxWHc2o6OyhATw9x7SYK
         o38rBOSjqDHyOPubLR2fW9EQ9RnBldP06Wqm4PupDGRbNdndX54LvLJbTAc9cg61YouM
         CRbxeha+Z5zIHwdOPxfBhjvUf476zOAfll4sagKS55gMwQOW9rEAdWoNmMDZwQRkNckO
         TYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794150694; x=1794755494;
        h=content-type:cc:to:from:subject:message-id:references:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i5PPzRt+yxwpbv/xozk5+L1M/Zvyd7L2ZCDx2pqWy3g=;
        b=S9Hv1c1hbjW2Ppmob/px00bLWd+183GHTeJg/u+syrVah4h7E2zr2M0eCj1tjGDgCB
         1151P64IJvG3d42T1eTyEzEKBl27KQsGnny7tL70fOue2ZvPm7IYVGrK4wOyE6vedEQi
         5gg6ArA04ocoDcogoIypcW3bM8DP27ibUntV87YtXYmHYL7Y2JEIaFZ0WH6/EbSvF53M
         nJkBlO9Dx1ayy8kxt2A0kqim5iS9du2p3tGkiqF7U53SGEVgobN82gvx2WkqvKyWrMBJ
         u/ARUliyR0E5kRaMzFAz6aP+lk/u5sAk0e+rWjDJAglBvWf6U2WolxSfU2NtFeVaaXvZ
         Xp1Q==
X-Forwarded-Encrypted: i=1; AL+hErFvMinFMDMmUadUxAdqKOm5NDrXr40fjmJoTMWaBqZhr7Fa2q9HB6jIos0ytdAULHoQqjfBgZI=@vger.kernel.org
X-Gm-Message-State: APuU4Z95drZ2HIIWEfb9av2dTlVXA5S1lqSHqGjRhMuBDqxt1wCbNPmi
	krMBnUCt7Apco4SXjznDM8OghYXIi/cDxwLF+Tuhn5d6tQdWRWqDO0W1/Ec6MY9GWW839WPhNzJ
	i+3W0wTCqj3XWYrI+kan7HFb8iVNALg==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: from dyay2.prod.google.com ([2002:a05:693c:62c2:b0:368:83bc:cb15])
 (user=chriswiseman job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:8845:b0:372:390e:1499 with SMTP id 5a478bee46e88-37256de84b0mr3157313eec.21.1794150693165;
 Sun, 08 Nov 2026 07:11:33 -0800 (PST)
Date: Sun, 08 Nov 2026 15:11:32 GMT
In-Reply-To: <18e61a85b0d13e9c.3137322e32332e3235332e313736.9c152.0000sendgmr@google.com>
References: <18e61a85b0d13e9c.3137322e32332e3235332e313736.9c152.0000sendgmr@google.com>
Message-ID: <18e61a8cb2ff887c.3137322e32332e3235332e313736.9d011.0000sendgmr@google.com>
Subject: [PATCH 2/2] rust_binder: account for deferred work size in Thread::read()
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
sum the sizes of all deferred items in inner.work_list when
use_proc_queue is true. Include deferred_size on the right-hand side of
the while condition in Thread::read() so the thread does not wait for
global events when the output buffer lacks room for both its deferred
work items and an incoming transaction, and subtract work.size() as each
item is popped so subsequent loop iterations do not double-count items
already written to writer.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Fixes: 8eb05e8e47f1 ("rust_binder: add TF_DEFER_COMPLETE flag for avoiding userspace roundtrip")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Wiseman <chriswiseman@google.com>
---
 drivers/android/binder/freeze.rs           |  4 +++
 drivers/android/binder/node.rs             |  8 +++++
 drivers/android/binder/node/wrapper.rs     |  4 +++
 drivers/android/binder/rust_binder_main.rs |  8 +++++
 drivers/android/binder/thread.rs           | 34 ++++++++++++++++------
 drivers/android/binder/transaction.rs      |  4 +++
 6 files changed, 53 insertions(+), 9 deletions(-)

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
index 3ca5c95695e4..af7a340adcb3 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -1599,13 +1599,20 @@ fn read(self: &Arc<Self>, req: &mut BinderWriteRead, wait: bool) -> Result {
             UserSlice::new(UserPtr::from_addr(read_start as usize), read_len as usize).writer(),
             self,
         );
-        let (in_pool, has_transaction, thread_todo, use_proc_queue) = {
+        let (in_pool, has_transaction, thread_todo, use_proc_queue, mut deferred_size) = {
             let inner = self.inner.lock();
+            let use_proc_queue = inner.should_use_process_work_queue();
+            let deferred_size = if use_proc_queue {
+                inner.work_list.iter().map(|w| w.size()).sum()
+            } else {
+                0
+            };
             (
                 inner.is_looper(),
                 inner.current_transaction.is_some(),
                 !inner.work_list.is_empty(),
-                inner.should_use_process_work_queue(),
+                use_proc_queue,
+                deferred_size,
             )
         };
 
@@ -1630,15 +1637,20 @@ fn read(self: &Arc<Self>, req: &mut BinderWriteRead, wait: bool) -> Result {
 
         // Loop doing work while there is room in the buffer.
         let initial_len = writer.len();
-        while writer.len() >= size_of::<uapi::binder_transaction_data_secctx>() + 4 {
+        while writer.len() >= size_of::<uapi::binder_transaction_data_secctx>() + 4 + deferred_size
+        {
             match getter(self, wait && initial_len == writer.len()) {
-                Ok(Some(work)) => match work.into_arc().do_work(self, &mut writer) {
-                    Ok(true) => {}
-                    Ok(false) => break,
-                    Err(err) => {
-                        return Err(err);
+                Ok(Some(work)) => {
+                    let work = work.into_arc();
+                    deferred_size = deferred_size.saturating_sub(work.size());
+                    match work.do_work(self, &mut writer) {
+                        Ok(true) => {}
+                        Ok(false) => break,
+                        Err(err) => {
+                            return Err(err);
+                        }
                     }
-                },
+                }
                 Ok(None) => {
                     break;
                 }
@@ -1798,6 +1810,10 @@ fn should_sync_wakeup(&self) -> bool {
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
2.56.0.317.g454f8302e1-goog

