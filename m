Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696339;
	b=jv4NZ5BR7adoEqDXSO6jx6/yaBLnYZ8LRvXWVDEI+oLYBKVb132aPkqcVgqMJftsU2OZ
	 KptH1SVZ5HEBAtSeUFy9EzN58lGaTw373F94Ac2naJAgnQYAmvOkozSVAStBMZ/4uZK1i
	 uMML5IkvHIZ45FxnJoLCmrmE8HQppiC7r1TvggEdmL5GKODb8TAWDNWQo/Q4B0SsJg851
	 GrZyE2mlhJH/sRnn5WPNagI0mOZ4D7/AeJbuC9u+HG4//oAYlh3ywpc6qiVMxr80kXrdl
	 oNN50mr/2PoRPxQ3L5d5c/GcaSnv7Dl+91mg9dsiafKt++hZVGxFTLWRSGI6MruUGaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-B4-Tracking:X-Change-Id:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=fHCx7zIpHYpLkOgKlg2Z3g8RSF2ncCGsbCBAjvwZT28=;
	b=ZGRketiwTiazDQnhsHqox2qelCRNNGSvYOXYLFUno5PMjvarOb9bWzHfRSrQLI3mGoxr
	 P221zma3lSDWZs+UR4ycMqu7gYNB8PaHGfppWaQyMx2zN6DtPDgZArXSk6WG5CETBHbMa
	 Jun/jaJQ3TC7raxZisf4pC/XzMW90dICEnv/lrjhNV0K8A9qg0yiz6hIhS1O+1JrHnyul
	 PRLg/8PmJOKgMUUWKfUPt6e/7zSJl94R0pdg6GGiE9JbOzu7BcWrgy2Lzb0ALbjCngZXH
	 e92lPgoXKFldX5E4k+rYyhCJ0fXAykJPRpQExQ6Qpy9P4MA46qfLLkOrSVD2iMd6Imw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EBtZJa8W;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F64606A326
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56F64606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EBtZJa8W
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4bb680f0ac4so48734125e9.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795696337; x=1796301137; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fHCx7zIpHYpLkOgKlg2Z3g8RSF2ncCGsbCBAjvwZT28=;
        b=EBtZJa8WsE0MD3ONXzlsFf5vMK2zog0Nb8lDbqkYhNbm05uQeTB/qAJgtP7QFLQEjR
         7OkBZcl+1FCsJibDTaQr9BAuB7ax2HahyysfFAYc91eiZmCfATf27+CZw0rPpx6N4EA5
         c6IO4cSO9zgJ5QuTW9xFInew5UQqxNnqpm7eGlA9Lhot8cUSGvxBbtLimAqDVOvihEGT
         rhIZl4x6UPUuhDKKBmtI4G7UJWBUciWYDonrwnX9DroUK6MOlEryfO9KgjZQwpGfMk4x
         R6Jj5YmNQJKJVxiRTEb2kU4RsEs/v3wwlnTuVMlF4hFinPv1rqtUylxwxnGWL6/TZNcM
         EAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795696337; x=1796301137;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fHCx7zIpHYpLkOgKlg2Z3g8RSF2ncCGsbCBAjvwZT28=;
        b=XaDpyB1gMBjMR5pqZsRTS9U31gX6JQBw200ubkAIAkhvvJT3R12VhwdH2eIJsf9pCQ
         mBLfozd1PRrFzCR9cYsKYrv4YD1Pg2P9A+YBo6MufN7HrWf2BVL5nShKdFWuWoDxWA/A
         0itrmA0nV1N1byv7Em3MuNHZBiZQE3ssjzukNMDMU89UNMj6hhq53khGNmCL7rcegMKZ
         S7jB42O4eQCA41+oqp611m4M+J/rnCie2d0Uq4pYfzAECQtn8phOImxymhC3Tkuyl7Pg
         9Q5ge89NlZ4Zylz2dqxXUC5tA5AGV+B3wthFsBQVUYkxPWOxVS8gKLoVu5aYBAYRE/Fd
         TFng==
X-Forwarded-Encrypted: i=1; AL+hErEggqrGXG0DyZBpiX7sn37AESPrXhGHIGtgi2dXNbywY5AWgPJYvTYNpFQMWml9KdXqi8A5siE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9P2oY19hljqj5dpUg3FOpj7JcyvMAAAZo93RRKZti3pt3fw7i1
	bj1AJcxflHOKdKY89B2Ez9mDflmoJ7j8GKlHRwnhHKAewrvp1spfrWl/ZKMsn91JjZxYSRMOlEf
	muK5UeyQYQKvaV3wOcQ==
X-Received: from wmpr22.prod.google.com ([2002:a05:600c:3216:b0:4a1:e780:89af])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1384:b0:4a2:1612:6367 with SMTP id 5b1f17b1804b1-4bb88816c44mr429916695e9.15.1795696336153;
 Thu, 26 Nov 2026 04:32:16 -0800 (PST)
Date: Thu, 26 Nov 2026 12:32:00 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMAmCGsC/x3MQQqAIBBA0avErBtQy4KuEi0mnWo2FhoVSHdPW
 r7F/xkSR+EEQ5Uh8iVJ9lCg6wrcRmFlFF8MRplOa2PR7cFfFHGRIGnDm+TE1jZu9tT2yhOU8oi 8yPNfx+l9P787sARlAAAA
X-Change-Id: 20261125-condvar-finish-wait-453cbda470da
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6230; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=PgjTJyn3+DIyu9bLn4l6pPnMUa4wWkOWUbLI08zk1iE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBrCCbEvvgTXcf8PQxlLLeQUwaZJCWEBOFPBLO5C
 iPj3CvW1deJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCawgmxAAKCRAEWL7uWMY5
 RgtxD/9uFNLvthXike/gPVN4HE8fZGW3e4dJJCjg95vyTo2+DsMy06lVvjXXtQ1nhiPppPzYOQt
 9ew9Hyzce63WxiqcK7Rs+IJWZagnZzVHgxyhNVR/U8A7JtAz+jEpY4al0OYZZ9NrRYyGxpbcFzD
 vXV6rkGphi7dFknZXBwA0hJLH8+2ltJSVlrOsyKjGyx7oGGcb7Jzo1VvevR7X2O+ab/1Ymw10eO
 VXv1x+uk59v32lO12CexL3JKcIa8SsBjAQZ09snquz+ZTDs+IfCtgDb7U45xv2U2DKisJA8Gqsy
 t0Xyz1+CuE5CydXCXpYu6Y2kKzemXTOLMlw4bRi0sjiHbC0kMkHvB9f16NoJ2JXTxNf0vKOPupa
 o42Z9b5lY3ozxANchoA/w2v04M/D0el04D3VBOrsH1bjNp+gyuokkmBHNES5gppGDXrPe9sgful
 r7QsDBFVyN8WL0jdKdP8N8ST5Mj+bdxVkhG82Ixr8Sn7CIqbaUtQAqhwIs7l1+z4dYYXG15qeop
 Hj2/AWpcHy0g2kBrsyLv/A5dK6GKlhW430QcIkOQYk935aWcRfP7gWi0GsMKVN2/PR24UEIdvZt
 +pjZDFCgtQmwCrM12w2yolB8iVOiUmbLf8Ew0UknwqdY+tMabhgSPEOaUsPWQPJveVJosFRScpe IdD8J25L4lwrMVA==
X-Mailer: b4 0.14.3
Message-ID: <20261126-condvar-finish-wait-v1-1-296b5a05045b@google.com>
Subject: [PATCH] rust: sync: condvar: call finish_wait() before relocking
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, Lyude Paul <lyude@redhat.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, 
	"=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, Miguel Ojeda <ojeda@kernel.org>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Wedson Almeida Filho <walmeida@microsoft.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	stable@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

When schedule_timeout() returns due to a signal or timeout, you must
invoke finish_wait() right away, before invoking any potentially
sleeping operations.

However, the CondVar will currently relock the lock before invoking
finish_wait(), which may sleep in mutex_lock() while the wait queue
entry is still queued. For exclusive waiters, a concurrent notify_one()
or notify_sync() can then match the task in TASK_UNINTERRUPTIBLE and
lose the wakeup for other waiters.

For non-exclusive waiters or notify_all(), keeping the wait entry queued
across relock does not lose wakeups, but it can still cause a spurious
wakeup inside mutex_lock() and nests wq_head->lock under the guard's
lock.

Thus, have the callback invoke finish_wait() at an appropriate time
instead of letting WaitQueue::wait_once*() do it. A token is used to
enforce that this method is called.

Cc: stable@vger.kernel.org
Fixes: 19096bce8157 ("rust: sync: introduce `CondVar`")
Fixes: 4afe54ecfe50 ("rust: sync: convert CondVar and PollCondVar to use WaitQueue")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/condvar.rs | 19 ++++++++++++-------
 rust/kernel/sync/wait.rs    | 44 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 89f1a31afb89..d1f9b8d78680 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -109,8 +109,11 @@ fn wait_internal<T: ?Sized, B: Backend>(
         guard: &mut Guard<'_, T, B>,
         timeout: Delta<Jiffy>,
     ) -> Delta<Jiffy> {
-        self.wq.wait_once_exclusive(wait_state, || {
-            guard.do_unlocked(|| task::schedule_timeout(timeout))
+        self.wq.wait_once_exclusive(wait_state, |finish| {
+            guard.do_unlocked(|| {
+                let ret = task::schedule_timeout(timeout);
+                (ret, finish.finish_wait())
+            })
         })
     }
 
@@ -180,11 +183,13 @@ pub fn wait_interruptible_freezable_nonexclusive<T: ?Sized, B: Backend>(
         &self,
         guard: &mut Guard<'_, T, B>,
     ) -> bool {
-        self.wq.wait_once(TASK_INTERRUPTIBLE | TASK_FREEZABLE, || {
-            guard.do_unlocked(|| {
-                task::schedule_timeout(Delta::from_jiffies(task::MAX_SCHEDULE_TIMEOUT))
-            })
-        });
+        self.wq
+            .wait_once(TASK_INTERRUPTIBLE | TASK_FREEZABLE, |finish| {
+                guard.do_unlocked(|| {
+                    task::schedule_timeout(Delta::from_jiffies(task::MAX_SCHEDULE_TIMEOUT));
+                    ((), finish.finish_wait())
+                })
+            });
         crate::current!().signal_pending()
     }
 
diff --git a/rust/kernel/sync/wait.rs b/rust/kernel/sync/wait.rs
index 399760e475cc..f378f0b0f110 100644
--- a/rust/kernel/sync/wait.rs
+++ b/rust/kernel/sync/wait.rs
@@ -18,6 +18,7 @@
 };
 
 use core::{
+    marker::PhantomData,
     pin::Pin,
     ptr, //
 };
@@ -228,27 +229,33 @@ fn wait_event_timeout_internal<F: FnMut() -> bool>(
 
     /// Performs a single non-exclusive prepare-to-wait / finish-wait cycle, calling `schedule_fn`
     /// in between. Non-exclusive waiters are all woken by [`wake_up()`](Self::wake_up).
+    ///
+    /// `schedule_fn` receives a [`WaitFinish`] token and must call [`WaitFinish::finish_wait`]
+    /// before returning (e.g. before reacquiring a lock).
     #[inline]
     pub(super) fn wait_once<F, R>(&self, wait_state: c_int, schedule_fn: F) -> R
     where
-        F: FnOnce() -> R,
+        F: for<'a> FnOnce(WaitFinish<'a>) -> (R, WaitFinishCalled<'a>),
     {
         self.wait_once_internal(wait_state, false, schedule_fn)
     }
 
     /// Performs a single exclusive prepare-to-wait / finish-wait cycle, calling `schedule_fn`
     /// in between.
+    ///
+    /// `schedule_fn` receives a [`WaitFinish`] token and must call [`WaitFinish::finish_wait`]
+    /// before returning (e.g. before reacquiring a lock).
     #[inline]
     pub(super) fn wait_once_exclusive<F, R>(&self, wait_state: c_int, schedule_fn: F) -> R
     where
-        F: FnOnce() -> R,
+        F: for<'a> FnOnce(WaitFinish<'a>) -> (R, WaitFinishCalled<'a>),
     {
         self.wait_once_internal(wait_state, true, schedule_fn)
     }
 
     fn wait_once_internal<F, R>(&self, wait_state: c_int, exclusive: bool, schedule_fn: F) -> R
     where
-        F: FnOnce() -> R,
+        F: for<'a> FnOnce(WaitFinish<'a>) -> (R, WaitFinishCalled<'a>),
     {
         let wait = Opaque::<bindings::wait_queue_entry>::uninit();
 
@@ -268,10 +275,11 @@ fn wait_once_internal<F, R>(&self, wait_state: c_int, exclusive: bool, schedule_
             }
         };
 
-        let ret = schedule_fn();
-
-        // SAFETY: Both `wait` and `wait_queue_head` point to valid memory.
-        unsafe { bindings::finish_wait(self.wait_queue_head.get(), wait.get()) };
+        let (ret, _finished) = schedule_fn(WaitFinish {
+            wq: self,
+            wait: &wait,
+            _invariant: PhantomData,
+        });
 
         ret
     }
@@ -328,6 +336,28 @@ pub(super) fn wake_up_pollfree(&self) {
     }
 }
 
+#[must_use]
+pub(super) struct WaitFinish<'a> {
+    wq: &'a WaitQueue,
+    wait: &'a Opaque<bindings::wait_queue_entry>,
+    _invariant: PhantomData<fn(&'a ()) -> &'a ()>,
+}
+
+impl<'a> WaitFinish<'a> {
+    #[inline]
+    pub(super) fn finish_wait(self) -> WaitFinishCalled<'a> {
+        // SAFETY: Both `wait` and `wait_queue_head` point to valid memory.
+        unsafe { bindings::finish_wait(self.wq.wait_queue_head.get(), self.wait.get()) };
+        WaitFinishCalled {
+            _invariant: PhantomData,
+        }
+    }
+}
+
+pub(super) struct WaitFinishCalled<'a> {
+    _invariant: PhantomData<fn(&'a ()) -> &'a ()>,
+}
+
 /// A wait was interrupted by a signal.
 #[derive(Clone, Copy, Debug, Eq, PartialEq)]
 pub struct Interrupted;

---
base-commit: 7402dd230f4497954b465145a22cff7a5a488629
change-id: 20261125-condvar-finish-wait-453cbda470da

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

