Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801519;
	b=3zdebMrKvIeaR4e+SGVYy9/Ee8r/grvR4zjHqXCs+M3gQt2LQpkrAFTqG2oU3EzRv69k
	 y69wizbLurs4XnRFm5PdBPbztvZubxxGCFFGr4dCFEy8lF9Dvbd7hApZeQYEzEjMeSYE0
	 mnFT+av70nV9OMFhD2Pphve4fJhumXrtquZV6Jei+aqT82q/QDYg0ylnv/MUli3c638yD
	 bA9b4HdcxYmFUS0zwliRH6AwiuHJY2QPsWIKPATk3aRVUUUz1Nk0GM1QYxoG2/IIiISi0
	 k1xYVa42Vy925s9ipJtQuV+rAwRQ+EJ7Q2iBcmAV6Aa/Q5vKQQsNcg3IUK2gS/iwM2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801519;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=WRK8jHvllaNp6Ir29lnuG1zuvxsKZpygoUfR0J0GLW4=;
	b=xBHsBYcMpaJo1zANLZ0gWQJWZ04vwYHUkY8T3J5+FojbniN2m9MInvlam0jPkEvPqJGy
	 SfpmMjZKCJQ7yJm8kt3k8NvJy1mocIrI8kD1dsuy/RWmkdTd+fvUjY5vPKO5950a96t+n
	 /WKWQ14e9l1x9+yKndQoEIv4DSCouEtcDlPqF+Vk+KjZ8R76RQoMGVzlqgeIPWf00RgfR
	 vhG9Wq9HsMkSdC8qAbO2y6DhQBUcqAdaNVmDEdt0qoEFStq0TQsa+U94d9ekbU3pGlwMe
	 xs9fXUAO0Rqpr0Nvo419hE+3hjo6eJxn9omAZs9drSBVQrWYBGNGKk/DdwPqBSZbjAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bDfGRTQR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2E0606A337
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bDfGRTQR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EEA1F000C1;
	Wed,  4 Nov 2026 14:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801518;
	bh=WRK8jHvllaNp6Ir29lnuG1zuvxsKZpygoUfR0J0GLW4=;
	h=Subject:To:Cc:From:Date;
	b=bDfGRTQRqhlsdVDltTEU/u1r3lgqQltUwh8rxmOsYaWgo+NQY4lMMZBBREjJtDSdi
	 +TRwk6DIl7wscGOwZHca6sKsxZ5mssH6I3BVNa15zo1RwfDo4Vw5xGdEvRrQ4f0GJj
	 34QxRm+ZdC0R6tQoLMOAry88gS+RdequL6GqTIuI=
Subject: FAILED: patch "[PATCH] rust_binder: wake epoll on self-work queued to poll thread" failed to apply to 7.3-stable tree
To: aliceryhl@google.com,gregkh@linuxfoundation.org,poilandgginchi@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:11:57 +0100
Message-ID: <2026110457-captive-licking-323f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 985955d8e6b2b15cfd65b7ac6893e3a5a90c5870
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110457-captive-licking-323f@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 985955d8e6b2b15cfd65b7ac6893e3a5a90c5870 Mon Sep 17 00:00:00 2001
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 16 Oct 2026 14:11:04 +0000
Subject: [PATCH] rust_binder: wake epoll on self-work queued to poll thread

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

diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index bcb2038b7550..177e90a1e5a3 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -345,13 +345,13 @@ fn push_reply_work(&mut self, code: u32) -> PushWorkRes {
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
 
@@ -694,8 +694,12 @@ pub(crate) fn push_work_inner(
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
@@ -708,7 +712,11 @@ pub(crate) fn push_work_deferred(&self, work: DLArc<dyn DeliverToRead>) {
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
@@ -1444,14 +1452,15 @@ fn reply_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
             let process = orig.from.process.clone();
             let allow_fds = orig.flags.contains(TransactionFlag::AcceptFds);
             let reply = Transaction::new_reply(self, process, info, allow_fds)?;
-            {
-                let mut inner = self.inner.lock();
-                if info.flags.contains(TransactionFlag::DeferComplete) {
-                    // The flag is set. Perform a deferred push so that `read` can wait for the
-                    // next incoming transaction without a userspace roundtrip.
-                    inner.push_work_deferred(completion);
-                } else {
-                    let _ = inner.push_work(completion);
+            if info.flags.contains(TransactionFlag::DeferComplete) {
+                // The flag is set. Perform a deferred push so that `read` can wait for the
+                // next incoming transaction without a userspace roundtrip.
+                self.inner.lock().push_work_deferred(completion);
+            } else {
+                // Not notifying work_condvar: Reply to current thread.
+                let res = self.inner.lock().push_work(completion);
+                if matches!(res, PushWorkRes::OkNotifyPoll) {
+                    self.process.notify_poll(false);
                 }
             }
             orig.from.deliver_reply(Ok(reply), &orig, None);
@@ -1489,10 +1498,15 @@ fn oneway_transaction_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> Bin
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

