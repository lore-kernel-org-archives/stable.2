Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629985;
	b=QSxmc+qpQPyC389x5T7/+29BSddLZRwC0B3e2+R9PT6Sm+EFRyfONcMb1hvAdfhUIZtO
	 yTkMEGpmeMaCWfC6Bt22KVkLd1RwksXkmkgAd+9VpJDIxzEQ/SQ6SI5Y96OYt00CNIb0n
	 1gZhi6ciaxpiLqE7lh0udJln6FlR0Bg4RtOA/wr417zdPEjXsab9s+na3h2FAzhkefraT
	 ZuC3SgrJ861MhnLzLR5q9Rm/xvQPdBT4SGRlPMuXS7dDNPycqLd8QTlrgRXTmSGWdfkJ/
	 RNPAZ2K3lDDG8vQ1Cpt2s4MSqZusW6zNHO+jnpWVrwAWMLS2uHaktH4WF7WShQKg8BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=QkD+eZIHJfUEIHt3Rv60+XCCF/qf4U4iMuNtx7S9uEs=;
	b=snaYJnmio6VQ3OKJ8xUUrfosHT+s3BLpRBXhoRqukt4jrb/02zWJLqJU7DwjmWEnRz3M
	 nltKW4AWSzBH3xrtBYLhIwUK1IbNoq07eDjGSjMKS1VuWLgUDXzNMYgMm6cxd/jngdDbf
	 zmAaNpELjXjyea8Rg4UsvHh1AuBjjI1/aHgKaHMEfQ37n/G4B4G88WYYpnUA7FdFDTjNL
	 yTD00iwb3pXDmDzA7wa+BEIbSLiWiwyWs3+knN4SuxJq+MJC0QiAwCzBbRMQUdG74WTog
	 WMZNlARQMGJWi8n6A3+JalQMYcFW3iAMUiAX2W5/geQpbS90OWYeEp2HOhzhKYBrCKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Lnyk9cfi;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBE0606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DBE0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Lnyk9cfi
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49953abe51fso43392335e9.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795629983; x=1796234783; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QkD+eZIHJfUEIHt3Rv60+XCCF/qf4U4iMuNtx7S9uEs=;
        b=Lnyk9cfi7E6GcY2dGDffEA0Nk9arsn5xaeJbWus9f3IgCRIFsCCt5nAAekzebKniUF
         QuPrWIiEwSDKujkbwCErdVITkJTm43PAvxVuS6SPy/bxA/CjTB0VQSOZa2U/f8OYwcdj
         ExyJ/WBH9WnLNWVKqmOYU8wIbnIyxkb4DRK4kzq5nzD1A3MpVgpWtB23dQuBgDXdv9ds
         I9RaDVV7+5EZihGx5axSRVSd20qo4KDRsTcvLwssot5t7rSku85GZyPanScNV+R12IdC
         F9qYZ+atUTiKVheIl7AjwDmwzPR7OkPA5ujayWjljpuDZ0N9DaVciQxvWs3wmX8h/uwJ
         AGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795629983; x=1796234783;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QkD+eZIHJfUEIHt3Rv60+XCCF/qf4U4iMuNtx7S9uEs=;
        b=PF2QpmiSFSeXMMt5ZsziVFVW3kvqO2lhFm2R+AMBLteiqt0JD2waItpedzz+/eBN7T
         q5y6RtN4NL0HuJVvflMSf6HLpdRHZFe/GLDmtK8D9rj2LiR67b/lrLsdlEaK6XgyU3yR
         wztbQM3ScJo5Tknhnm/DgY2J0U4qckrWZtI+Du0pR1WpTQkFmy4Qe2zDg8tQhpyX4q28
         ZXLjwKwoS+HhDkSgKDpcmrDCcM7eOSCvGXh0zBOM58kJ+8ljqw2SJC9Wcn+3hzOerqSF
         QUmlufOdg4TGqmoKf6/osI9qEdceXfnjObDn9Q+MX4D8oOlUwht2bvCZtQHQQPYu0Knv
         ABSA==
X-Gm-Message-State: APuU4Z/1UZB5jA1M0Gj8TZk3dKI5jtsOrUQV8UJPhRa7NMBmwJDkjtxB
	mRekB4RdmPy/GfAjHWGgXoYtnH9Twa8ki+EktvSDd1iok7JnkbZNKWo0BSdLz8Ad/5q7v6ju9Az
	LvxSBCKU98F9doRRa4M7TfQbOKADLnk9HVFeIXTaCip7hZiJdlk44aj8GK3Tz7d5BrvATNq5SnP
	JUusrI4POgymsjzUy8SQqWPujEaOxy3xiYI6XpbFbFaRjjGpQwxXEb
X-Received: from wmco9.prod.google.com ([2002:a05:600c:a309:b0:4a3:9bdc:d7e4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:82e4:b0:4bb:6847:7927 with SMTP id 5b1f17b1804b1-4bb8882677cmr397206275e9.7.1795629983167;
 Wed, 25 Nov 2026 10:06:23 -0800 (PST)
Date: Wed, 25 Nov 2026 18:06:22 +0000
In-Reply-To: <2026112553-margin-rope-d6e2@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <2026112553-margin-rope-d6e2@gregkh>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125180622.2012095-1-aliceryhl@google.com>
Subject: [PATCH 6.18.y] rust_binder: push BR_TRANSACTION_COMPLETE before BR_FAILED_REPLY
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
Backport note for 6.18.y:
Resolved conflicts in Thread::transaction() and Thread::reply_inner()
because 6.18.y lacks later mainline changes (error-line tracking,
Option<Error> in TransactionInfo, consolidated failure logging, netlink
reporting, and DeliverCode PID/notify_poll updates). error.rs applied
with minor context adjustment (core::fmt).

 drivers/android/binder/error.rs  |  1 -
 drivers/android/binder/thread.rs | 46 +++++++++++++++-----------------
 2 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/android/binder/error.rs b/drivers/android/binder/error.rs
index fd9e9d9e5658..4b5689cdb2b8 100644
--- a/drivers/android/binder/error.rs
+++ b/drivers/android/binder/error.rs
@@ -78,7 +78,6 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
             BR_DEAD_REPLY => f.pad("BR_DEAD_REPLY"),
             BR_FROZEN_REPLY => f.pad("BR_FROZEN_REPLY"),
             BR_TRANSACTION_PENDING_FROZEN => f.pad("BR_TRANSACTION_PENDING_FROZEN"),
-            BR_TRANSACTION_COMPLETE => f.pad("BR_TRANSACTION_COMPLETE"),
             _ => match self.source.as_ref() {
                 Some(source) => source.fmt(f),
                 None => self.reply.fmt(f),
diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index e2320704c722..5ae26faaf13b 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -1262,26 +1262,25 @@ fn transaction(self: &Arc<Self>, cmd: u32, reader: &mut UserSliceReader) -> Resu
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
-                    pr_warn!(
-                        "{}:{} transaction to {} failed: {err:?}",
-                        info.from_pid,
-                        info.from_tid,
-                        info.to_pid
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
+                pr_warn!(
+                    "{}:{} transaction to {} failed: {err:?}",
+                    info.from_pid,
+                    info.from_tid,
+                    info.to_pid
+                );
             }
         }
 
@@ -1336,7 +1335,7 @@ fn reply_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
         info.to_pid = orig.from.process.task.pid();
 
         // We need to complete the transaction even if we cannot complete building the reply.
-        let out = (|| -> BinderResult<_> {
+        if let Err(err) = (|| -> BinderResult<_> {
             let completion = DTRWrap::arc_try_new(DeliverCode::new(BR_TRANSACTION_COMPLETE))?;
             let process = orig.from.process.clone();
             let allow_fds = orig.flags & TF_ACCEPT_FDS != 0;
@@ -1344,11 +1343,10 @@ fn reply_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
             self.inner.lock().push_work(completion);
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
@@ -1360,11 +1358,9 @@ fn reply_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
             let ee = ExtendedError::new(info.debug_id as u32, err.reply, param);
             orig.from
                 .deliver_reply(Err(BR_FAILED_REPLY), &orig, Some(ee));
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

