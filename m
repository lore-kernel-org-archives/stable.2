Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA9E3F6C29
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780658042; cv=none; b=Hbk0fvViM16slhUVJZQnEZlMescM/mIWe7hH30wU8+HXCnRWXLrxor+aTVbDUdGeMmpoO6w7ZKL5iQxKTyih77YEobPi1qnb7pJLvOp9lluW4//KZZagScSVwj+eDHIqxCuJiWT3JBHn+c0jcoAyfx/ne74dFsLqWKTYFlgBOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780658042; c=relaxed/simple;
	bh=pE3Md5fXo59d3VmXaqKfkEFBwkt/gMYRvtNwlnkDoGw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ImzLt6TYb30FS7DREMmlAIlTuxk6xC525Ff8ttIYoPjYYaTts3sDVxunK0kwDxDee4KNr11FJuE7/9bC27ej1OdHSR2/+XybI5vS/ZZer+paGHuMNgqR+S5Sty+2z1K8O1RS2HpAX1kJaD0qCDPXnZnPg433PKyY/EJHt373YIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TJcOiDBi; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJcOiDBi"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-45efa2f7009so1111240f8f.3
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 04:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780658038; x=1781262838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ae0B3L9J3p8ch5V1iNM9m91ribQPpzMSLrk2/8ZfsoU=;
        b=TJcOiDBiI7pc4ZXvq3Vxwn0YaBYUcfYybdl6AiTwaWTUrgdmtAgZB0tB4fK1um3CCB
         nePEMJDIppnFooZ9qL6zKujDlA5E+fI5VXRtFqV9wlzTgiq8us+qnlfIByGN+5G5guGZ
         eXJpN4fx5uRkkZlQbXK47QU4Up/GmYJQIwK87jvdRYY0g1vmrkNm8xqj4KgTGZkdejgU
         fSUb1y4xaiHJaZt2SvFA+WNopya6LJIgIVYDwaaL2EcPQ2pYE9d+osK4TOKmcxolmD/R
         CRJAnM1+DsCAwk3LuzZHrR7Cj0i/lf9Jiiwr2D+7/3tpXzOSl+BAuSaFdlNGIedZ1BUn
         7X+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780658038; x=1781262838;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ae0B3L9J3p8ch5V1iNM9m91ribQPpzMSLrk2/8ZfsoU=;
        b=TZTzK1YmjhAN0CHbQh1uG/ywWB3wejIpHTkJAunz3XRFWOno6qOSoeIlyd3lZCjdv5
         R2k/bt6etFQnpzbRTQQbAAuhqa1OWsAZvcWesljsCdQOkVBGwy7rix53muHXGoB2eUfb
         bxZs9O5WEO8XNDFtJ4+OZb84rTmLPSCacjc4ZKEKYUm5xOTWi/sfitCa80nsHzQHsr9k
         7JYsn/0gDB1l7e3V7dF7QeBL5w7hLTkxZXeKekhr2ZQSRH8zbNK/iI4MAfUOT9hmoGkb
         OxN5hb368NEuhEthRj9Kkf7HbZUSseVp6PDRKIkudwXMk9Uy/0Jg4IeHJK7JfY1CTO93
         QVQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9/vb+dw/e/8E61G3KSjKPMQf4E+EbsqAUh1G0FV25vl/8/I9S80WpyCSAkGG2lecQGyDcQlWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxRGJ1f2i+b3L7XFQJNLvDLlLEdgUaMNswDR0Lm6qIgEcRFgpE
	95DXPb1zTttvPsXG36nT+5EELn5QR7LDyO8+aAF0VLCiWjmWHQPQfYWeSwCx8dwTOxPvq89dF+g
	lDd45zfaahI4XkIAJhA==
X-Received: from wmok21.prod.google.com ([2002:a05:600c:4795:b0:490:bae0:2975])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f83:b0:490:b724:5085 with SMTP id 5b1f17b1804b1-490c2621a5cmr47158285e9.33.1780658037867;
 Fri, 05 Jun 2026 04:13:57 -0700 (PDT)
Date: Fri, 05 Jun 2026 11:13:50 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAG6vImoC/33NTQrCMBCG4auUrI1M84uuvIe4aJppG9BGJiVUS
 u9u2o0I4vL9YJ5ZWEIKmNi5WhhhDinEsYQ8VKwdmrFHHnxpJkAY0MLyhBPHecLRo+dIFImjaBt
 pEczJeFYOn4RdmHf0eis9hDRFeu0/cr2tf7lc85orsE45ZQxIfelj7O94bOODbV4WH8OA+mmIY nQOrJZoG6fll7Gu6xuXk4Qp+QAAAA==
X-Change-Id: 20260527-set-extended-error-e2ca37e0696d
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=11911; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=pE3Md5fXo59d3VmXaqKfkEFBwkt/gMYRvtNwlnkDoGw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqIq9wU6XpkHkwl3E14lJQ7fDDs3KlybRbe9UYK
 o9fdlp5/RWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaiKvcAAKCRAEWL7uWMY5
 RoW2D/93a9/E36XsCLJvlujc9bRkSuTj10LyqNY5CJj6OEe/nRF0x+Rf+46BavmlqvTzTOC7hfZ
 tqW/VAyp0vuPaRd7NkK3CDsx0zCCh6w2YSPlolFbUSjUKgt8x5whb3TKo6tpxvEeji6ctosMHE1
 CmI0DwveK44+Nu4t67OiSvleRceTaENQAY0zP28uRHAkAGx3RhYiJnOk0JePCaGP5Fz95Dwkvd6
 Bj1QgAYD5Rj2UrAckiwKYZss46mxhNuDWmf3tI4kZKzmZ2aSlxH1ZNL96L/BYhRE8/ZfrNqbbCY
 NjC98shSHP+BpCq1RR3IxHy7idMfdzK3IzaiEkrBw02wyCJt0T3RQ8Gch2PZe8yFlK6ZRcPPwQ7
 /cXS8uQf2I07yXA8GrZSyq+Vcdck/i0oqqAry4J6a3Z9JwHP8QW6fBs6AlUCP7J9cyimQ49vm9b
 /0NfSFCfF+Zvd9FyRUW3c0HHyn7XlbVM1shkljfl82s0bFZebEWGSiAr0JCXyO8qFbotQbzwn4f
 I9YZOGhFrAAM85hr+oLkAAF8erxZfz4TQYS4J4xGIl/9IdnUJIXCfUCVtw7qt/ya+2+9CLp2nf6
 WoE/OWRatEoc9LbxT88h2MuvH/L3qxL3HJa4D4JjruWfWnNLic8sV04gjYVvJi2dESq1GvTqJRO 6HvZ8MUY5ZRvbbw==
X-Mailer: b4 0.14.3
Message-ID: <20260605-set-extended-error-v3-1-d60b69a75f97@google.com>
Subject: [PATCH v3] rust_binder: fix BINDER_GET_EXTENDED_ERROR
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

This code currently copies the ExtendedError struct to the stack,
modifies the copy, and then doesn't modify the original. Thus, fix it.

Furthermore, errors when replying must be delivered directly to the
remote thread, so update deliver_reply() to take an extended error
argument.

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v3:
- Replace 'orig.debug_id' with 'info.debug_id' for reply EE.
- Print the integer error code on unknown error.
- Link to v2: https://lore.kernel.org/r/20260604-set-extended-error-v2-1-fb0753e7ab53@google.com

Changes in v2:
- Also handle extended error for replies.
- Link to v1: https://lore.kernel.org/r/20260527-set-extended-error-v1-1-407b4b466035@google.com
---
 drivers/android/binder/error.rs       | 13 +++----
 drivers/android/binder/thread.rs      | 65 +++++++++++++++++++++++++----------
 drivers/android/binder/transaction.rs | 15 ++++----
 3 files changed, 58 insertions(+), 35 deletions(-)

diff --git a/drivers/android/binder/error.rs b/drivers/android/binder/error.rs
index 45d85d4c2815..1296072c35d9 100644
--- a/drivers/android/binder/error.rs
+++ b/drivers/android/binder/error.rs
@@ -73,20 +73,17 @@ impl fmt::Debug for BinderError {
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         match self.reply {
             BR_FAILED_REPLY => match self.source.as_ref() {
-                Some(source) => f
-                    .debug_struct("BR_FAILED_REPLY")
-                    .field("source", source)
-                    .finish(),
+                Some(source) => source.fmt(f),
                 None => f.pad("BR_FAILED_REPLY"),
             },
             BR_DEAD_REPLY => f.pad("BR_DEAD_REPLY"),
             BR_FROZEN_REPLY => f.pad("BR_FROZEN_REPLY"),
             BR_TRANSACTION_PENDING_FROZEN => f.pad("BR_TRANSACTION_PENDING_FROZEN"),
             BR_TRANSACTION_COMPLETE => f.pad("BR_TRANSACTION_COMPLETE"),
-            _ => f
-                .debug_struct("BinderError")
-                .field("reply", &self.reply)
-                .finish(),
+            _ => match self.source.as_ref() {
+                Some(source) => source.fmt(f),
+                None => self.reply.fmt(f),
+            },
         }
     }
 }
diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index 97d5f31e8fe3..3b8520813941 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -495,9 +495,16 @@ pub(crate) fn debug_print(self: &Arc<Self>, m: &SeqFile, print_all: bool) -> Res
         Ok(())
     }
 
+    pub(crate) fn clear_extended_error(&self, debug_id: usize) {
+        self.inner.lock().extended_error = ExtendedError::new(debug_id as u32, BR_OK, 0);
+    }
+
     pub(crate) fn get_extended_error(&self, data: UserSlice) -> Result {
         let mut writer = data.writer();
-        let ee = self.inner.lock().extended_error;
+        let mut inner = self.inner.lock();
+        let ee = inner.extended_error;
+        inner.extended_error = ExtendedError::new(0, BR_OK, 0);
+        drop(inner);
         writer.write(&ee)?;
         Ok(())
     }
@@ -1109,7 +1116,10 @@ fn unwind_transaction_stack(self: &Arc<Self>) {
             inner.pop_transaction_to_reply(thread.as_ref())
         } {
             let reply = Err(BR_DEAD_REPLY);
-            if !transaction.from.deliver_single_reply(reply, &transaction) {
+            if !transaction
+                .from
+                .deliver_single_reply(reply, &transaction, None)
+            {
                 break;
             }
 
@@ -1121,8 +1131,9 @@ pub(crate) fn deliver_reply(
         &self,
         reply: Result<DLArc<Transaction>, u32>,
         transaction: &DArc<Transaction>,
+        extended_error: Option<ExtendedError>,
     ) {
-        if self.deliver_single_reply(reply, transaction) {
+        if self.deliver_single_reply(reply, transaction, extended_error) {
             transaction.from.unwind_transaction_stack();
         }
     }
@@ -1136,6 +1147,7 @@ fn deliver_single_reply(
         &self,
         reply: Result<DLArc<Transaction>, u32>,
         transaction: &DArc<Transaction>,
+        extended_error: Option<ExtendedError>,
     ) -> bool {
         if let Ok(transaction) = &reply {
             crate::trace::trace_transaction(true, transaction, Some(&self.task));
@@ -1152,6 +1164,12 @@ fn deliver_single_reply(
                 return true;
             }
 
+            if let Some(ee) = extended_error {
+                if inner.extended_error.command == BR_OK {
+                    inner.extended_error = ee;
+                }
+            }
+
             match reply {
                 Ok(work) => {
                     inner.push_work(work);
@@ -1222,6 +1240,9 @@ fn read_transaction_info(
         info.buffers_size = td.buffers_size as usize;
         // SAFETY: Above `read` call initializes all bytes, so this union read is ok.
         info.target_handle = unsafe { td.transaction_data.target.handle };
+
+        info.debug_id = super::next_debug_id();
+
         Ok(())
     }
 
@@ -1230,6 +1251,8 @@ fn transaction(self: &Arc<Self>, cmd: u32, reader: &mut UserSliceReader) -> Resu
         let mut info = TransactionInfo::zeroed();
         self.read_transaction_info(cmd, reader, &mut info)?;
 
+        self.clear_extended_error(info.debug_id);
+
         let ret = if info.is_reply {
             self.reply_inner(&mut info)
         } else if info.is_oneway() {
@@ -1239,23 +1262,21 @@ fn transaction(self: &Arc<Self>, cmd: u32, reader: &mut UserSliceReader) -> Resu
         };
 
         if let Err(err) = ret {
-            if err.reply != BR_TRANSACTION_COMPLETE {
-                info.reply = err.reply;
-            }
-
             self.push_return_work(err.reply);
-            if let Some(source) = &err.source {
-                info.errno = source.to_errno();
+            if err.reply != BR_TRANSACTION_COMPLETE {
                 info.reply = err.reply;
+                if let Some(source) = &err.source {
+                    info.errno = source.to_errno();
 
-                {
-                    let mut ee = self.inner.lock().extended_error;
-                    ee.command = err.reply;
-                    ee.param = source.to_errno();
+                    {
+                        let mut inner = self.inner.lock();
+                        inner.extended_error =
+                            ExtendedError::new(info.debug_id as u32, err.reply, source.to_errno());
+                    }
                 }
 
                 pr_warn!(
-                    "{}:{} transaction to {} failed: {source:?}",
+                    "{}:{} transaction to {} failed: {err:?}",
                     info.from_pid,
                     info.from_tid,
                     info.to_pid
@@ -1320,18 +1341,24 @@ fn reply_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
             let allow_fds = orig.flags & TF_ACCEPT_FDS != 0;
             let reply = Transaction::new_reply(self, process, info, allow_fds)?;
             self.inner.lock().push_work(completion);
-            orig.from.deliver_reply(Ok(reply), &orig);
+            orig.from.deliver_reply(Ok(reply), &orig, None);
             Ok(())
         })()
         .map_err(|mut err| {
             // At this point we only return `BR_TRANSACTION_COMPLETE` to the caller, and we must let
             // the sender know that the transaction has completed (with an error in this case).
+
             pr_warn!(
-                "Failure {:?} during reply - delivering BR_FAILED_REPLY to sender.",
-                err
+                "{}:{} reply to {} failed: {err:?}",
+                info.from_pid,
+                info.from_tid,
+                info.to_pid
             );
-            let reply = Err(BR_FAILED_REPLY);
-            orig.from.deliver_reply(reply, &orig);
+
+            let param = err.source.as_ref().map_or(0, |e| e.to_errno());
+            let ee = ExtendedError::new(info.debug_id as u32, err.reply, param);
+            orig.from
+                .deliver_reply(Err(BR_FAILED_REPLY), &orig, Some(ee));
             err.reply = BR_TRANSACTION_COMPLETE;
             err
         });
diff --git a/drivers/android/binder/transaction.rs b/drivers/android/binder/transaction.rs
index 1d9b66920a21..0e5d07b7e6f0 100644
--- a/drivers/android/binder/transaction.rs
+++ b/drivers/android/binder/transaction.rs
@@ -42,6 +42,7 @@ pub(crate) struct TransactionInfo {
     pub(crate) reply: u32,
     pub(crate) oneway_spam_suspect: bool,
     pub(crate) is_reply: bool,
+    pub(crate) debug_id: usize,
 }
 
 impl TransactionInfo {
@@ -93,7 +94,6 @@ pub(crate) fn new(
         from: &Arc<Thread>,
         info: &mut TransactionInfo,
     ) -> BinderResult<DLArc<Self>> {
-        let debug_id = super::next_debug_id();
         let allow_fds = node_ref.node.flags & FLAT_BINDER_FLAG_ACCEPTS_FDS != 0;
         let txn_security_ctx = node_ref.node.flags & FLAT_BINDER_FLAG_TXN_SECURITY_CTX != 0;
         let mut txn_security_ctx_off = if txn_security_ctx { Some(0) } else { None };
@@ -101,7 +101,7 @@ pub(crate) fn new(
         let mut alloc = match from.copy_transaction_data(
             to.clone(),
             info,
-            debug_id,
+            info.debug_id,
             allow_fds,
             txn_security_ctx_off.as_mut(),
         ) {
@@ -128,7 +128,7 @@ pub(crate) fn new(
         let data_address = alloc.ptr;
 
         Ok(DTRWrap::arc_pin_init(pin_init!(Transaction {
-            debug_id,
+            debug_id: info.debug_id,
             target_node: Some(target_node),
             from_parent,
             sender_euid: Kuid::current_euid(),
@@ -152,9 +152,8 @@ pub(crate) fn new_reply(
         info: &mut TransactionInfo,
         allow_fds: bool,
     ) -> BinderResult<DLArc<Self>> {
-        let debug_id = super::next_debug_id();
         let mut alloc =
-            match from.copy_transaction_data(to.clone(), info, debug_id, allow_fds, None) {
+            match from.copy_transaction_data(to.clone(), info, info.debug_id, allow_fds, None) {
                 Ok(alloc) => alloc,
                 Err(err) => {
                     pr_warn!("Failure in copy_transaction_data: {:?}", err);
@@ -165,7 +164,7 @@ pub(crate) fn new_reply(
             alloc.set_info_clear_on_drop();
         }
         Ok(DTRWrap::arc_pin_init(pin_init!(Transaction {
-            debug_id,
+            debug_id: info.debug_id,
             target_node: None,
             from_parent: None,
             sender_euid: Kuid::current_euid(),
@@ -394,7 +393,7 @@ fn do_work(
         let send_failed_reply = ScopeGuard::new(|| {
             if self.target_node.is_some() && self.flags & TF_ONE_WAY == 0 {
                 let reply = Err(BR_FAILED_REPLY);
-                self.from.deliver_reply(reply, &self);
+                self.from.deliver_reply(reply, &self, None);
             }
             self.drop_outstanding_txn();
         });
@@ -478,7 +477,7 @@ fn cancel(self: DArc<Self>) {
         // If this is not a reply or oneway transaction, then send a dead reply.
         if self.target_node.is_some() && self.flags & TF_ONE_WAY == 0 {
             let reply = Err(BR_DEAD_REPLY);
-            self.from.deliver_reply(reply, &self);
+            self.from.deliver_reply(reply, &self, None);
         }
 
         self.drop_outstanding_txn();

---
base-commit: da61573f783897ae5a96c8f1c71aad6242344feb
change-id: 20260527-set-extended-error-e2ca37e0696d

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

