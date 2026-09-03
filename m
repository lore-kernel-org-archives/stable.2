Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9EF45518E
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435381; cv=none; b=FOh7J6p7p9TVwZBGoNbETUj4Lv1dUpKsxWvcB/iC1LRZvGfZFyp280UqZ6hIAlMt0oit5YLzVs1gQ7Zu7FFMRJ0TahgAosBEjxZX051DaMF5hzn+pLcnJ9cZmjjL94Wzny2H1OKnXKPfJ7YBmfqZ9jytQaD0dLYs5ZkdJYBL7wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435381; c=relaxed/simple;
	bh=UFsZXVipqlvfpx450PhI4oHqd1cKHwae0vZq/h7tgvg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=D/b5lFHZcTCA77RbWqeQQkDEVDcB+ZKLy/RJ8b96LMkSxTjMp6En30ssRrv54iFViZ5pudami9TG6IafSjIquFZnhMWDZwelovrB4Hj1GC/mydrpcadk21soUQUGP0ZF4fwS2CoZsNMWL5RU8xuyAimkhOE2nQt7GDFN1A20H9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQgRczGI; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQgRczGI"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49cf4cc2125so1371775e9.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 04:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788435373; x=1789040173; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tZ4bhp8LPRdPf3uVYkffJK0IPibPFHXYOnRk0Sytprk=;
        b=XQgRczGIwNPAwsso9w8BMMnffq4kRt3V5+TFKRdaE3AYw1o7Wu9HU6Mbmq1bEDe2EZ
         rkMPLGHy08wlCB+HUndOOMw3USyFxgEcqT8gKOlbLLcHHgV+r0BbaXtHtGfl9cuWGAO9
         cnSrV8gxdK/slx5bCWYFaezmAs3cwlhSH83VC1QjDAG1RcVqGzAQvlCHKIT+Gyq3hTUt
         AzWEhR0UkKkOngy1hbn7k/7PPZ8Ht/1CcrRvMhcR/lPGlUSdCGynYMsjgA5/XnYuQqjr
         kMmu01SC9Ue7myOfGCRduLDygvsa7nTbWipnhdYn27cMC+bYTegl5wKlfiwBDkrbJb27
         IZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788435373; x=1789040173;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tZ4bhp8LPRdPf3uVYkffJK0IPibPFHXYOnRk0Sytprk=;
        b=IEOh6rP5381U11mDgaOmwLCYxJtVflLpbpyoCLXQqw9GGcN1QjW4t+gINSMJJO8//+
         +oUrdjRqkMBOnU+r5L5x+tPna7gLLchIBhdCf/imSDkY8CS9H4C9byfEtI96iSn5/3iE
         p17tQxBJTylV/OPHKkoIJP7yVt9QCJG648kjM4PCL2mV3hJkfseL8JOCIXjXMx85VG2Y
         nb+RqUQL39tk5L0SSVTjjzb9Z9JUCBMa+gZXSxAiQVheASYU8Y9OLIkKmEk+hL7sI7Xd
         3b9K+OwSIeGHbMqMLmhpO5nat5LLD927KUSHKJTEvohwR9sX+a4OQGz1/6vxFQdtlXfj
         rlVw==
X-Forwarded-Encrypted: i=1; AKwUvByCqaCItysNZjeddCMj7VVsOwvzu+OUY6j+w2dWbCSSFvlVYNRubTl/nybrNmiDT1nn2LYgVbU=@vger.kernel.org
X-Gm-Message-State: AFuF++k4a4nb7b8NpMzyNRONcy2WqKHubBKdNKVapKAAfewQr+vm1/31
	Tde7TwziDgVm9yLtuoOdFy7frjbVKFc1q8PV0IOuyxdYH0XX/+dkhsvqiC2QWZl0uQVh3kGRkIm
	1DeIAP8DlghQGxGq82Q==
X-Received: from wmoo1.prod.google.com ([2002:a05:600d:101:b0:499:dd7e:7848])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e0a:b0:49c:f518:252d with SMTP id 5b1f17b1804b1-49cf5182689mr18521135e9.14.1788435372573;
 Thu, 03 Sep 2026 04:36:12 -0700 (PDT)
Date: Thu, 03 Sep 2026 11:36:03 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKJbmWoC/x3MQQqDQAxG4atI1gamExTaq5QuRvOr2YwlIyKId
 3dw+S3eO6nADYU+zUmO3YqtueLVNjQuKc9g02qKIfbhHYQHywrnbXEkZRy2cV4VrNKJ6ChDiol q/XdMdjzn7++6btxVjC5pAAAA
X-Change-Id: 20260903-binder-thread-exit-node-d3533dc3ba2a
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4861; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=UFsZXVipqlvfpx450PhI4oHqd1cKHwae0vZq/h7tgvg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqmVumOdC5zbeu0NqQvVL+RXhOyXWae9RJ43i6/
 Iqk9k938RaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaplbpgAKCRAEWL7uWMY5
 RiQVD/9ofPBPixot/tPTNbLyXvza5QF9N/ks8lPVTsS141zvuZXnBPa5Q8XL7WQDVyy76fRneGh
 7laXZr21OuKXg8dF3SvGwpVYNZ5TWXdvOizYBF9rkyWSkOzN/nC8qZW8YFrVfaf2H4hiG3kZE7S
 4LlJKky7m+hw1kfnkmT4ibTioYXkzHbW5lvnchiRmDt5/QnM0Mgu7Im1K+QqMGcnOqxToCcaMr5
 CheJH9PfqUcKVz/sv/mH2WzOXJLKGHXWpTHGf3ehlN95JNm5HATFhx7IAbdLmuAAgqMQxLMOfTq
 WKCEkQ1N+4ZDrVKPvRx9fmAi85LDzsnBtMwg69Y6UpxEKQECv8RWQxVB7iaR7EWmAICixiJ2AM2
 d08PRX1DoNFy8VwGOxm7202wUsgDUdj8CuZiUiLoPdx2coszmIXwgiqYP2IHbx5UtJXWfc95E4I
 GzySEli/OsbZPlhmf7vquHVD9mRcdSv5/Eek44brrq/RFIpjt8iPAXQ2gFLp88Kil3qxg6HlagT
 4yH1En69qGeBF6flhkVKEXMadjBuJGc7OPbPXLqQuyP3RqLAOioj3CyH2Gq3YVNABBgT6ZMQZBN
 roRb1id4HE8VCDjY7KN15FZCPZ9Ft/XR52AhJRgPAfjIfz6JVObLxWLoYi1HlmFp747BPG4GOjU BZYxjlQX2HKvEbg==
X-Mailer: b4 0.14.3
Message-ID: <20260903-binder-thread-exit-node-v1-1-be09ff14f6a4@google.com>
Subject: [PATCH] rust_binder: reschedule node refcount update on thread exit
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

When a thread exits via BINDER_THREAD_EXIT, its pending work items are
cancelled. If a thread exits while holding a pending node refcount
increment (e.g. pushed as deferred work to that thread), the refcount
increment was previously dropped because Node::cancel() and
NodeWrapper::cancel() were no-ops.

Dropping the refcount update leaves the node's delivery state and count
state desynchronized, and userspace will not receive the notification,
which can cause the node to never be freed from the process's nodes tree
when all external references are dropped.

Fix this by implementing DeliverToRead::cancel() for Node and NodeWrapper
to move the pending refcount update to the process's work queue on thread
exit so another thread can deliver it to userspace.

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/node.rs         | 20 +++++++++++++++++---
 drivers/android/binder/node/wrapper.rs | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder/node.rs b/drivers/android/binder/node.rs
index 0a82af14cda3..8dc3e3f2b834 100644
--- a/drivers/android/binder/node.rs
+++ b/drivers/android/binder/node.rs
@@ -51,9 +51,9 @@
 ///   about to drop the weak reference, then the strong increment could be processed after the
 ///   other thread has already exited, which would be too late.
 ///
-/// Note that trying to create a `ListArc` to the node can succeed even if `has_normal_push` is
+/// Note that trying to create a `ListArc` to the node can succeed even if `has_pushed_node` is
 /// set. This is because another thread might just have popped the node from a todo list, but not
-/// yet called `do_work`. However, if `has_normal_push` is false, then creating a `ListArc` should
+/// yet called `do_work`. However, if `has_pushed_node` is false, then creating a `ListArc` should
 /// always succeed.
 ///
 /// Like the other fields in `NodeInner`, the delivery state is protected by the process lock.
@@ -738,7 +738,21 @@ fn do_work(
         self.do_work_locked(writer, owner_inner)
     }
 
-    fn cancel(self: DArc<Self>) {}
+    fn cancel(self: DArc<Self>) {
+        let _drop_outside_lock;
+        let mut owner_inner = self.owner.inner.lock();
+
+        // We only do something on BINDER_THREAD_EXIT, not process exit.
+        if owner_inner.is_dead {
+            return;
+        }
+
+        // If BINDER_THREAD_EXIT is invoked on a thread with a pending node refcount update, we
+        // should move ourselves to ensure the refcount update is still delivered.
+        if let Some(node) = ListArc::try_from_arc_borrow(self.as_arc_borrow()) {
+            _drop_outside_lock = owner_inner.push_work(&self.owner, node);
+        }
+    }
 
     fn should_sync_wakeup(&self) -> bool {
         false
diff --git a/drivers/android/binder/node/wrapper.rs b/drivers/android/binder/node/wrapper.rs
index 6e4ca01c941a..886626ca0d42 100644
--- a/drivers/android/binder/node/wrapper.rs
+++ b/drivers/android/binder/node/wrapper.rs
@@ -57,7 +57,39 @@ fn do_work(
         node.do_work_locked(writer, owner_inner)
     }
 
-    fn cancel(self: DArc<Self>) {}
+    fn cancel(self: DArc<Self>) {
+        let _drop_outside_lock;
+        let node = &self.node;
+        let mut owner_inner = node.owner.inner.lock();
+
+        // We only do something on BINDER_THREAD_EXIT, not process exit.
+        if owner_inner.is_dead {
+            return;
+        }
+
+        // We transfer the responsibility of the node refcount update to the scheduled Node because
+        // NodeWrapper has no way to re-create the ListArc.
+        let inner = node.inner.access_mut(&mut owner_inner);
+
+        let ds = &mut inner.delivery_state;
+        assert!(ds.has_pushed_wrapper);
+        assert!(ds.has_strong_zero2one);
+        ds.has_pushed_wrapper = false;
+
+        // We are changing the state to one where the Node is the strong zero2one update instead of
+        // the wrapper.
+        ds.has_weak_zero2one = false;
+
+        if !ds.has_pushed_node {
+            if let Some(node2) = ListArc::try_from_arc_borrow(node.as_arc_borrow()) {
+                ds.has_pushed_node = true;
+                _drop_outside_lock = owner_inner.push_work(&node.owner, node2);
+            } else {
+                // This can't actually happen.
+                ds.has_strong_zero2one = false;
+            }
+        }
+    }
 
     fn should_sync_wakeup(&self) -> bool {
         false

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260903-binder-thread-exit-node-d3533dc3ba2a

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

