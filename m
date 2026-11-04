Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823160;
	b=yr2717giCPH3wQxKkrlCn0ALeWblHHaabK5OWi8NxaViSdJoOsotU28jlSoMcX8Anw2Q
	 fDI5Y8UUrhcAKaUNWeySIThs0LioO6df4Vj7YD/IFD+ZyyyeRfMqLXORegcwOmMF/NaN0
	 Fzt+tfip5v9FT/HPb3+4RurhOXWKxaPrMGpJaTe25CQcmRGxtLu73VZLbfalguNnnXU8Y
	 Kg/YkbeTGfDVAPbAAUDjfd2jMc5DCMWmKef6qFqgBoVOkqirhBli4ffTanTrEYF/B5f/6
	 kLh7rWyPRGdBEuEuZqvr63PUFE4btbIcAdg07Bi5julYfB4d4q1MbQxJtp4r3iUJ2Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823160;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PBwpP/cO9H/vvJng9gxC2fGVBaG4d32dILLs8aXqHd0=;
	b=pxtWW8tql4ev9kymDhREqooxuk5ThDoicl4yFztLKkTrml3xDvWwAhsRLUFPgny8Ujpz
	 gc0dPrLAzHhdlTgmKB0w0Yaf4T1VVfPkzn1qpAmkxX0Vt2efIF8/zBcGRDWvusDcC8g3I
	 y8X9aR1MHcarYQY7GxGGzzH8H9EWDwDNIesusx6iMy0R37fZLKSt7+3UIgER0h4EsNY+E
	 G69lQFuqM0vZFMLgWwrIF23QqO65+rOxsyMJVuTyMFxueSN29sUCdqfi+HA+0aVlLEX2z
	 EvbMxcJzo7Hmr/HTbZyeYEUZN2/cqMUWvg1icmAfMS8tPT0wezt5UgD5+l+iGOaqDUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQH1CV6n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCD46080791
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 20:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQH1CV6n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8013F1F000C1;
	Wed,  4 Nov 2026 20:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793823160;
	bh=PBwpP/cO9H/vvJng9gxC2fGVBaG4d32dILLs8aXqHd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YQH1CV6nxUZMBOJd7n/0EVxe9pI9ZfmM/xp5Vhoj5gK/OusMa1A2I9JQI8n8tnLL/
	 z/Qn6Us9vnpf5SIZR5NueeM/PUTwaYcwz28ENUm71G/7Qkb9u9LJ0+N4aH7Qe4Qegu
	 07/aGzZjD83GXk2SR8RKi2M6ecI28G3FDGtqh5NULFWeQdGROhhHehoSZd/LxiwcYU
	 Esw9Mq+6XjFRYn81jD8xwyhlN2GQvSL8murWYkmLlqXhlXNNhs7Hp0U/aldb6awfkC
	 UuJ5eMBFlp86XbGmhemi4vwWTFNqJXJV07Pu9fsF9wxLxgpV/4LlEbaic7j4dmaSSS
	 UE/CcE9HpmkpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alice Ryhl <aliceryhl@google.com>,
	stable@kernel.org,
	Poil Zero <poilandgginchi@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] rust_binder: wake epoll on self-work queued to poll thread
Date: Wed,  4 Nov 2026 15:12:38 -0500
Message-ID: <20261104201229.343904-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110457-captive-licking-323f@gregkh>
References: <2026110457-captive-licking-323f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Ryhl <aliceryhl@google.com>

[ Upstream commit 985955d8e6b2b15cfd65b7ac6893e3a5a90c5870 ]

When a thread pushes work to its own todo list, InnerThread::push_work()
returns PushWorkRes::OkNotifyPoll if the thread uses epoll, but four
call sites in thread.rs discard this return value. As a result, a
non-blocking BC_* write that enqueues work onto the calling thread's
todo list without also reading will not wake epoll. Check the return
value and call self.process.notify_poll(false) when
PushWorkRes::OkNotifyPoll is returned.

This is similar to commit 97830f3c3088 ("binder: signal epoll threads of
self-work"), but in C Binder pending thread work also prevented
subsequent process work from waking epoll, causing a permanent hang,
which is not the case in Rust Binder. This means that in practice, it
merely delays notifications rather than completely failing to send them.

Cc: stable@kernel.org
Fixes: dbb17c9ea756 ("rust_binder: move (e)poll wait queue to Process")
Reported-by: Poil Zero <poilandgginchi@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Link: https://patch.msgid.link/20261016-binder-poll-self-work-v1-1-c29c87d99abb@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: adapted reply_inner() to unconditional immediate completion because TransactionFlag::DeferComplete is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/android/binder/thread.rs | 38 +++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index 24f7b5be1b0ec..a1bef151c2c59 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -344,13 +344,13 @@ fn push_reply_work(&mut self, code: u32) -> PushWorkRes {
         }
     }
 
-    fn push_return_work(&mut self, reply: u32) {
+    fn push_return_work(&mut self, reply: u32) -> PushWorkRes {
         if let Ok(work) = ListArc::try_from_arc(self.return_work.clone()) {
             work.set_error_code(reply);
-            // Not notifying: Reply to current thread.
-            let _ = self.push_work(work);
+            self.push_work(work)
         } else {
             pr_warn!("Thread return work is already in use.");
+            PushWorkRes::Ok
         }
     }
 
@@ -669,8 +669,12 @@ pub(crate) fn push_work_inner(
     pub(crate) fn push_work_if_looper(&self, work: DLArc<dyn DeliverToRead>) -> BinderResult {
         let mut inner = self.inner.lock();
         if inner.is_looper() && !inner.is_dead {
-            // Not notifying: Reply to current thread.
-            let _ = inner.push_work(work);
+            // Not notifying work_condvar: Reply to current thread.
+            let res = inner.push_work(work);
+            drop(inner);
+            if matches!(res, PushWorkRes::OkNotifyPoll) {
+                self.process.notify_poll(false);
+            }
             Ok(())
         } else {
             drop(inner);
@@ -683,7 +687,11 @@ pub(crate) fn push_work_deferred(&self, work: DLArc<dyn DeliverToRead>) {
     }
 
     pub(crate) fn push_return_work(&self, reply: u32) {
-        self.inner.lock().push_return_work(reply);
+        // Not notifying work_condvar: Reply to current thread.
+        let res = self.inner.lock().push_return_work(reply);
+        if matches!(res, PushWorkRes::OkNotifyPoll) {
+            self.process.notify_poll(false);
+        }
     }
 
     pub(crate) fn pop_work_even_if_deferred(&self) -> Option<DLArc<dyn DeliverToRead>> {
@@ -1416,8 +1424,11 @@ fn reply_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
             let process = orig.from.process.clone();
             let allow_fds = orig.flags.contains(TransactionFlag::AcceptFds);
             let reply = Transaction::new_reply(self, process, info, allow_fds)?;
-            // Not notifying: Reply to current thread.
-            let _ = self.inner.lock().push_work(completion);
+            // Not notifying work_condvar: Reply to current thread.
+            let res = self.inner.lock().push_work(completion);
+            if matches!(res, PushWorkRes::OkNotifyPoll) {
+                self.process.notify_poll(false);
+            }
             orig.from.deliver_reply(Ok(reply), &orig, None);
             Ok(())
         })()
@@ -1456,10 +1467,15 @@ fn oneway_transaction_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> Bin
         let list_completion =
             DTRWrap::arc_try_new(DeliverCode::new(code, self.process.task.pid()))?;
         let completion = list_completion.clone_arc();
-        // Not notifying: Reply to current thread.
-        let _ = self.inner.lock().push_work(list_completion);
+        // Not notifying work_condvar: Reply to current thread.
+        let res = self.inner.lock().push_work(list_completion);
         match transaction.submit(info) {
-            Ok(()) => Ok(()),
+            Ok(()) => {
+                if matches!(res, PushWorkRes::OkNotifyPoll) {
+                    self.process.notify_poll(false);
+                }
+                Ok(())
+            }
             Err(err) => {
                 completion.skip();
                 Err(err)
-- 
2.53.0

