Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629987;
	b=K9mJVckRl4Bk9wra+N5xMeZKiGhhJpzlagGMzZ2m9OGULGyVjwVWOOH6YuZYXGQsPzcM
	 ejB93eaKARCvIMhyVStwLH2zVb4dXgp3MLwgmNcvWEMUOYhikWAqLeGENhwWDX2X6I4Cn
	 tE6n5mCzuuVCG812FtmCmBoAY1jANI3f/molvyFf7jNLbGcK339d7fNVWRtTve/DLXxuL
	 8MkdKULo1pivDBN3cZOPVO5q0X2MrcEztmk1/8d9Oojmu5DiGikwIvhBcihEuvlioIchN
	 eh2j3RE42khTnqAeuHC5xOclNSMmj1M6Kz1sdaCt7SdpV8T2TNZ/WXNX9GwZ8qzp+1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=06flE/Y8EFfsdgnJBqMh4P7xJ68qrlDiE7mHSecvF4Y=;
	b=ycf/yiRXFDKLtu2kQk/zLwCAJ6ipT50FpfmKf4m9d3eQhp8NbHJyfm36ofSB2MCv0QN+
	 yXiU1BlJrWTAIAHPxXVJWYFaekgpeu4whnPVdA1SYoRxUnQGLmzqxkH9r4SOwgct0l6Xb
	 d8ggS0Sbmm14XuN6JA+crdDwh8zBczpZxJeiDSwQ5ba6VbI6nodfHVA3q1BFvnWhx1I+1
	 9AXZsbk3Icp/anrY9i1U4lexawT8BrEHoS2wUYFPyqU0UjsWzp7/maYvlbXrMYZZYlXb0
	 0H+ZuCd6mzWzRBqxeOM/SwvN7mpFp0ggJDSODY/IinV7xQG9Y+bHfMXkErDIN8TOi4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MxhjKGi9;
	arc=none smtp.remote-ip=209.85.221.71
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E4606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 943E4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MxhjKGi9
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4a68703d177so2954334f8f.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795629985; x=1796234785; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=06flE/Y8EFfsdgnJBqMh4P7xJ68qrlDiE7mHSecvF4Y=;
        b=MxhjKGi9gK0URGVxEte+uqSpEp3XtWRLCuGMUfdLn8xU46Y3jSRl+SxU7nuReqqO9n
         /Uc76ZChF2yrsngEWXbWAweZwX15T1YfjFeJOFuGfJ57Ybnd6laMNujYF5B0FXCcT5vB
         hBuJa5dr1u5To85+CHe3HQIg9bh/GG7eCD7rf99j499CYtYqjkiunrvfGk4J7sAWZUsx
         YizGVQl9y2MWjYyxeiyd+lgwp5jwj135Sm+Gix54tEeICUrDOofCcbmWNNXkwZxlgCgV
         pnSUz3BD+ibrUWRfIpsgFGrC2HMkHg9/J9tmWZtbZSnOTFITM1gkg1hn+ggGgvxHcWB3
         xtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795629985; x=1796234785;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=06flE/Y8EFfsdgnJBqMh4P7xJ68qrlDiE7mHSecvF4Y=;
        b=oP5otzj9aJmyxpQQlVZ0wbiPAbPWCVadIYYku2bnnCiSIPdkcsM6YtkTEmL/+h2eoz
         aJoEKIVaDQAVaau6gS3KcbdL9kXYJ6AFDgohqTNgMLQk7FdyUm/4eeyM/fc4+j8y1c1z
         k4Mk6s2B9A5H3p3YGgSv5KLslYgH3cVU0WNCj9AdK+lAlO5+hi4J/Ty8VWUCDkldIWvy
         p9cTXGb4EHoA5KYpedTSGq8jDxPSpKDhYl/A1qd4vzStq/pUvZ5U/yx5/JPyi4fwWNZc
         WP33EkAXkwji97XpbUAuYfRhgqVpBgCSFfM6ffnojzxmTjCMm4TEsyjqXl78uv8rp5S4
         lF3A==
X-Gm-Message-State: APuU4Z9P93knkPno4nMeJsugzfaLnSA+j57AhRr4k0tmaGrU1C+sYVxx
	kGAA5mrfYTqqI6DMfHpH54AbL6AFOd9gSH5CmxGhM8nkWmu5D+pXscMExlkISOqX6UzHnpzwYN6
	M9cTuoYhZrNpF8aYekDPPliShZxoshUoxMyK7DlnXLY0053uPtUqJhdUVRfqBykACq/LhTzMhMA
	Hyob5AuM/KCeAgAPod3dJWK1wGjcaFTjlYCMuzC57eSo3d3AphGUTF
X-Received: from wmdd24.prod.google.com ([2002:a05:600c:a218:b0:4a2:9cdb:2bfe])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d0a:b0:4a2:59:f568 with SMTP id 5b1f17b1804b1-4bb8880ef6amr405609135e9.14.1795629984733;
 Wed, 25 Nov 2026 10:06:24 -0800 (PST)
Date: Wed, 25 Nov 2026 18:06:23 +0000
In-Reply-To: <2026112553-washbasin-jingling-2217@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <2026112553-washbasin-jingling-2217@gregkh>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125180623.2012238-1-aliceryhl@google.com>
Subject: [PATCH 7.3.y] rust_binder: push BR_TRANSACTION_COMPLETE before BR_FAILED_REPLY
From: Alice Ryhl <aliceryhl@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

commit ff9de8571f05e8f62f9cbe29f38e0aedda9389cf upstream.

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

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Link: https://patch.msgid.link/20261028-binder-reply-fail-v1-1-8b71d4daaf1d@google.com
[aliceryhl: resolve conflicts in Thread::transaction() and reply_inner()]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Backport note for 7.3.y:
Resolved conflicts in Thread::transaction() and Thread::reply_inner()
because 7.3.y lacks later mainline changes (error-line tracking,
Option<Error> in TransactionInfo, and consolidated failure logging).
Retained info.reply = BR_FAILED_REPLY in reply_inner() for
report_netlink().

 drivers/android/binder/error.rs  |  1 -
 drivers/android/binder/thread.rs | 68 +++++++++++++++-----------------
 2 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/drivers/android/binder/error.rs b/drivers/android/binder/error.rs
index 1296072c35d9..b9faf0956610 100644
--- a/drivers/android/binder/error.rs
+++ b/drivers/android/binder/error.rs
@@ -79,7 +79,6 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
             BR_DEAD_REPLY => f.pad("BR_DEAD_REPLY"),
             BR_FROZEN_REPLY => f.pad("BR_FROZEN_REPLY"),
             BR_TRANSACTION_PENDING_FROZEN => f.pad("BR_TRANSACTION_PENDING_FROZEN"),
-            BR_TRANSACTION_COMPLETE => f.pad("BR_TRANSACTION_COMPLETE"),
             _ => match self.source.as_ref() {
                 Some(source) => source.fmt(f),
                 None => self.reply.fmt(f),
diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index a1bef151c2c5..e1929f5739df 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -1309,37 +1309,36 @@ fn transaction(self: &Arc<Self>, cmd: u32, reader: &mut UserSliceReader) -> Resu
             self.transaction_inner(&mut info)
         };
 
+        // This runs when a transaction fails with an error returned to the caller.
         if let Err(err) = ret {
             self.push_return_work(err.reply);
-            if err.reply != BR_TRANSACTION_COMPLETE {
-                info.reply = err.reply;
-                if let Some(source) = &err.source {
-                    info.errno = source.to_errno();
-
-                    {
-                        let mut inner = self.inner.lock();
-                        inner.extended_error =
-                            ExtendedError::new(info.debug_id as u32, err.reply, source.to_errno());
-                    }
-
-                    binder_debug!(
-                        FailedTransaction,
-                        "transaction {} to {}:{} failed {:?}, code {} size {}-{}",
-                        if info.is_reply {
-                            "reply"
-                        } else if info.is_oneway() {
-                            "async"
-                        } else {
-                            "call"
-                        },
-                        info.to_pid,
-                        info.to_tid,
-                        err,
-                        info.code,
-                        info.data_size,
-                        info.offsets_size
-                    );
+            info.reply = err.reply;
+            if let Some(source) = &err.source {
+                info.errno = source.to_errno();
+
+                {
+                    let mut inner = self.inner.lock();
+                    inner.extended_error =
+                        ExtendedError::new(info.debug_id as u32, err.reply, source.to_errno());
                 }
+
+                binder_debug!(
+                    FailedTransaction,
+                    "transaction {} to {}:{} failed {:?}, code {} size {}-{}",
+                    if info.is_reply {
+                        "reply"
+                    } else if info.is_oneway() {
+                        "async"
+                    } else {
+                        "call"
+                    },
+                    info.to_pid,
+                    info.to_tid,
+                    err,
+                    info.code,
+                    info.data_size,
+                    info.offsets_size
+                );
             }
         }
 
@@ -1416,7 +1415,7 @@ fn reply_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
         info.to_pid = orig.from.process.task.pid();
 
         // We need to complete the transaction even if we cannot complete building the reply.
-        let out = (|| -> BinderResult<_> {
+        if let Err(err) = (|| -> BinderResult<_> {
             let completion = DTRWrap::arc_try_new(DeliverCode::new(
                 BR_TRANSACTION_COMPLETE,
                 self.process.task.pid(),
@@ -1431,11 +1430,10 @@ fn reply_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
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
             pr_warn!(
                 "{}:{} reply to {} failed: {err:?}",
                 info.from_pid,
@@ -1447,11 +1445,9 @@ fn reply_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
             orig.from
                 .deliver_reply(Err(BR_FAILED_REPLY), &orig, Some(ee));
             info.reply = BR_FAILED_REPLY;
-            err.reply = BR_TRANSACTION_COMPLETE;
-            err
-        });
+        }
 
-        out
+        Ok(())
     }
 
     fn oneway_transaction_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
-- 
2.56.1.839.g22a8290db9-goog

