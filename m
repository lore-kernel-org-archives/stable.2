Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608342;
	b=vmYI+tTvwOyCpX45PkCdSRQqvIvwZEHXtVPK1m8+ZoSqdJBhV5CUWWbAha4avJr1ya5T
	 6BI2K07YfdCcYM3edvCZ1YE/H4sxSBd0Lq5DD0rl1y2mei5qrDLAiSV6pzghQZEPmsfvc
	 sUpDDcOjxrFm5OPomgwl0Yvq2iCQ6/IHvukyKPSgojX4hpJiRnCOyNf9AjO1boh+C0ECI
	 kOnQimIvxpx1aeyGifx7kdlwHxNR4aGm9rmaT+GFwaLljWFdQNNHauMUPRgWlVxNwrGRC
	 zemr9oY7vMQwLoka35MP8qjEeO8YBKRXHk9TU6Rxb4uEtxkiqSBmhhoOoRA5J3rntAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608342;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sQwUwMr9Z8mvy0qjIlGsKs7awBmgb9BTBcvjrmV1Mao=;
	b=VKY07HLsLIF8+5J68bv7RLzAB6EJP93/Yiuh6/UhJZgXs7cBZvZKCXvrisXrE3NAucef
	 Zfier2xdcKTLZT+3uFZV5LpI2vHsJzOzi1syAsGBcCXaEaZs3E9bWo4ubHtILeyM7lWXg
	 tGNqIW4Z+oOcOpiTQj1iKozTxHFUzAJN7raYL35rTT/6XujERtXtFGxxBXMwJfZ1ya++1
	 cZbhhqjokpXij3ziQDVbyIxM+YLZ++Bw2aF877kSYRDP/CzhP1BF8awz3Ji6VlJCU0FZR
	 R4af1SgJB7QjWsNT8iDnzREIVxo+lpPcVexu/cGBKlp+qLIZwU69EZP+ztetdBgc0fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="xEjs8fI/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4BD606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xEjs8fI/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474CC1F000C4;
	Wed, 25 Nov 2026 12:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608341;
	bh=sQwUwMr9Z8mvy0qjIlGsKs7awBmgb9BTBcvjrmV1Mao=;
	h=Subject:To:Cc:From:Date;
	b=xEjs8fI/cyiF0qpikxYCwH4VH8YDfech4ZSzTkSaXFWD68dg2uIo/I118pDiZ/TX6
	 iHimmt5Np1GzbJJoPGDxHjevHZiJWAfCh6baCB7SgNNNscXw0Uz8F2rIZepxs7zp4f
	 tBvQeC9ik0v6/Q52mSQ/IDgN5ZF7FtmgfDI8Mdww=
Subject: FAILED: patch "[PATCH] rust_binder: push BR_TRANSACTION_COMPLETE before" failed to apply to 7.3-stable tree
To: aliceryhl@google.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:31:53 +0100
Message-ID: <2026112553-washbasin-jingling-2217@gregkh>
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
git cherry-pick -x ff9de8571f05e8f62f9cbe29f38e0aedda9389cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112553-washbasin-jingling-2217@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ff9de8571f05e8f62f9cbe29f38e0aedda9389cf Mon Sep 17 00:00:00 2001
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 28 Oct 2026 09:46:45 +0000
Subject: [PATCH] rust_binder: push BR_TRANSACTION_COMPLETE before
 BR_FAILED_REPLY

When building a reply fails in Thread::reply_inner(), BR_FAILED_REPLY is
delivered to the caller before BR_TRANSACTION_COMPLETE is pushed to the
replying thread's work list.

In a nested transaction, the caller can wake up upon receiving
BR_FAILED_REPLY and send an outer reply to the replying thread before
BR_TRANSACTION_COMPLETE is queued. This causes the outer BR_REPLY to
arrive ahead of BR_TRANSACTION_COMPLETE, which is not legal. This leads
to userspace tripping on an assertion.

Thus, push BR_TRANSACTION_COMPLETE in Thread::reply_inner() before
delivering BR_FAILED_REPLY to the caller.

As a nice side effect, this lets us remove the now-unused
BR_TRANSACTION_COMPLETE error path in Thread::transaction().

Cc: stable <stable@kernel.org>
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Link: https://patch.msgid.link/20261028-binder-reply-fail-v1-1-8b71d4daaf1d@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/android/binder/error.rs b/drivers/android/binder/error.rs
index 89077c5baeaf..acf0aa09c555 100644
--- a/drivers/android/binder/error.rs
+++ b/drivers/android/binder/error.rs
@@ -114,7 +114,6 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
             BR_DEAD_REPLY => f.pad("BR_DEAD_REPLY"),
             BR_FROZEN_REPLY => f.pad("BR_FROZEN_REPLY"),
             BR_TRANSACTION_PENDING_FROZEN => f.pad("BR_TRANSACTION_PENDING_FROZEN"),
-            BR_TRANSACTION_COMPLETE => f.pad("BR_TRANSACTION_COMPLETE"),
             _ => match self.source.as_ref() {
                 Some(source) => source.fmt(f),
                 None => self.reply.fmt(f),
diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index f5965e838a96..4ce6fc533203 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -1332,20 +1332,16 @@ fn transaction(self: &Arc<Self>, cmd: u32, reader: &mut UserSliceReader) -> Resu
             self.transaction_inner(&mut info)
         };
 
-        // This runs when return work is passed to the caller. This is not
-        // always the same as the transaction failing, as reply errors are
-        // delivered to the remote process.
+        // This runs when a transaction fails with an error returned to the caller.
         if let Err(err) = ret {
             self.push_return_work(err.reply);
-            if err.reply != BR_TRANSACTION_COMPLETE {
-                info.reply = err.reply;
-                info.error_line = Some(err.line);
-                if let Some(source) = err.source {
-                    info.errno = Some(source);
+            info.reply = err.reply;
+            info.error_line = Some(err.line);
+            if let Some(source) = err.source {
+                info.errno = Some(source);
 
-                    self.inner.lock().extended_error =
-                        ExtendedError::new(info.debug_id as u32, err.reply, source.to_errno());
-                }
+                self.inner.lock().extended_error =
+                    ExtendedError::new(info.debug_id as u32, err.reply, source.to_errno());
             }
         }
 
@@ -1450,7 +1446,7 @@ fn reply_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
         info.to_pid = orig.from.process.task.pid();
 
         // We need to complete the transaction even if we cannot complete building the reply.
-        let out = (|| -> BinderResult<_> {
+        if let Err(err) = (|| -> BinderResult<_> {
             let completion = DTRWrap::arc_try_new(DeliverCode::new(
                 BR_TRANSACTION_COMPLETE,
                 self.process.task.pid(),
@@ -1471,11 +1467,10 @@ fn reply_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
             }
             orig.from.deliver_reply(Ok(reply), &orig, None);
             Ok(())
-        })()
-        .map_err(|mut err| {
+        })() {
             // At this point we only return `BR_TRANSACTION_COMPLETE` to the caller, and we must let
             // the sender know that the transaction has completed (with an error in this case).
-
+            self.push_return_work(BR_TRANSACTION_COMPLETE);
             let param = err.source.as_ref().map_or(0, |e| e.to_errno());
             let ee = ExtendedError::new(info.debug_id as u32, err.reply, param);
             orig.from
@@ -1483,11 +1478,9 @@ fn reply_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
             info.reply = BR_FAILED_REPLY;
             info.errno = err.source;
             info.error_line = Some(err.line);
-            err.reply = BR_TRANSACTION_COMPLETE;
-            err
-        });
+        }
 
-        out
+        Ok(())
     }
 
     fn oneway_transaction_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {

