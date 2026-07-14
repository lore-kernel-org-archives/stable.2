Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C003E1680
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011579; cv=none; b=JP9mGZZZGgciynuz+AFOxdhBu52G3/h0FijMYXh/jZRCF2f3q8bVU0ET+3cWX9YDWCwcbC7SGlFNtSej+g4wrZsaBRlE9zdYSd2fKs5qyuayBj+/lJP7KCE1VByJrkxZ35Ljn6U+9uHd0mfvZxXzfd37TuhRBQzATSlu0d9JgM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011579; c=relaxed/simple;
	bh=bA0Azk8cDVIKmrAn7jnbNBP9bBYZnQMw0gaZrZjS5J0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VEiEIY4WwIDggw6KYyphkic5MAabFNS7M76sXMMaUlP6pTTg9xcexZ6UGSS/6W4rw+bJUvb1Kpie26J8Mh2ovgWTsrJDUuBtpVo55Foh/U7le0sWu+j8AejmPzmn/9gzw13rc1606iXl1Quxy2yyaCbrmdb6A7FHLrVRZOGTp5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PlVlvNTh; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PlVlvNTh"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c160129f06fso318592666b.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 23:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784011576; x=1784616376; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xyTLzjGeyAljeIoSMcZwMrQP1YgNSg4pCu/ByAFtR+Y=;
        b=PlVlvNThUM+kA5t4sQfFm6SbmfvYKIBcjPMNY4OZlCjRcakpCAFn2PhfMRA66CzZyk
         tUquixKyb15LWMoiQKeQ5O92Ue1DkLVfKMyQbakMSj8+ZcfHWEBe5cpa6m0GxROzCfUw
         3S0sZHF311wlmvGmdo8sY3DBE/j/Y2aHj//yfnKTSO3ehdfOtWYP06/qKNxlVCBsrUbG
         FI+eVIuINF4U0y937QZ7gBAEqVYPh6cav7TgXBKFBgBlaZ9mbD2XMsClBj5zNPVuG7K8
         BQUecga2dvcrbcgH6WFz1Yf4+8i4CwDEkZw3OQyr/k7p0dw92CMQhDxm8/8geTxTM4Vb
         lLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784011576; x=1784616376;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xyTLzjGeyAljeIoSMcZwMrQP1YgNSg4pCu/ByAFtR+Y=;
        b=nNTT1rQJ4exXkDsmZkNfsiiqb4SnhlJum4PVD3BRow1cC5ng385+Ssg0j4CVpIEZ4s
         CHfT3kwdp+ST8Erl4x587qhrxW0h0/RgXxwjOhhr8fmyChIQy3E3sg2adOcoS137919B
         QYCbvjYMb6NOAlf02tQJf8/UGUNhNep1HlBR+CUwraRDCXFO1zTkuCsal/pE4VEdNq9o
         LOY1GvqPocRZsbugZNQkP6tSJJdZEHboz/sfpunZlc2fCgvFyYii2XPqPeyz9YzaL7+J
         FemQWSjkYEuRBjIL98LqLr4N6OdxlSDsshObVT6Z+VEDsPScN5dvmS6FBglWs/BKSp6U
         aFaA==
X-Gm-Message-State: AOJu0YwpzX7MN+eLSzlVj2h7tjmG7P6IAyTK/n9QDq7LaTZ2BPVjAATn
	AeN+BSTqBicdEyYjnY3NQguRgilvYFBTY+w9f2ngGqVBp2Pz4BuRxSWkpOGxbrmANTUphs2bYnT
	CmJT6xkS8jry3ux/xTKq4HIkFmRM14Gz2wfNyTQf4UtyCkG0edKXZp4fBr0h3l9rO7JcgIeNLtL
	ba1Aup97opJAlKbtMtaZvK4GuhgTcwf7zh0z2A+vXXgFC6l2Gowf0J
X-Received: from ejcpo28.prod.google.com ([2002:a17:907:7e5c:b0:c15:ba98:cd1b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1ca0:b0:c16:66a:71c8 with SMTP id a640c23a62f3a-c161ea56736mr569835666b.43.1784011575196;
 Mon, 13 Jul 2026 23:46:15 -0700 (PDT)
Date: Tue, 14 Jul 2026 06:45:54 +0000
In-Reply-To: <20260714064554.2090610-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026071331-obstruct-sprig-4ee1@gregkh> <20260714064554.2090610-1-aliceryhl@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=11712; i=aliceryhl@google.com;
 h=from:subject; bh=bA0Azk8cDVIKmrAn7jnbNBP9bBYZnQMw0gaZrZjS5J0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqVdsKQmnrtVdNcbMiESN+JLrsvcFCd1M8FcBVn
 q5f8Np9ZbyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCalXbCgAKCRAEWL7uWMY5
 Rgf+D/46iZDY43UP4nYWAuSsSMTnCYzeZDXYZHpoJb0JvYS1nVpfLADgsUtdTNcIYLbSmLbuT/S
 dDc09QOLAO7KEuqd3KPtCpJ653QPwCmu50tJcdVzB2W+2/GDwl7qMm5aITas4fM6D6N0ZScaME+
 dkBt5jXs59L3SKdp27WjspV8lPB2f4OzymeEBrsKVlbteMeZ4gtbo/x7umVAJ0l9MOn5a5atTVp
 Safay6XQs56BnuAHs+boeCQQROvPJ7KMKVnHU3NL/oPkxJ8ou9NRLpD4JJupzf1J5A6M2KMWzmL
 9hofaRtzTf5QyD0ZEH8bDbUCqK9pUdeVS+TjQfJFaveOeNaBAvwBMs/yrzWgJN9aSxWgcW6Qh/0
 kDH+ySb8WN7XgpuYLQYIfZ20C4WgTO9zyCe36L8Cv5ro/p9B15PJAzJgUUQiCjluL2bwXzCCiQn
 RyQLA7SPN/4GLdiRsrol5GNBabtR+HwSdQpJlPMhgg0/IkhKgCNndQm9a9vBQ4kfuccAlGFr8Ny
 lPPeWlexRCtv9rXBhAVoiAdAi8xAVbeLByAh9udAnmSRSV7HL/5CG7SvwZ0ECMaB/hqBGjNILBS
 dG4acaC6SU/j/OVsORkFjxbXcC2CIHdg87vFTvad+nQecvp0O3fJSZ25DHJ6knfA2hIblrHSAHZ WdeRIi5uRDNevXQ==
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714064554.2090610-2-aliceryhl@google.com>
Subject: [PATCH 6.18.y 2/2] rust_binder: fix BINDER_GET_EXTENDED_ERROR
From: Alice Ryhl <aliceryhl@google.com>
To: stable@vger.kernel.org
Cc: Alice Ryhl <aliceryhl@google.com>, stable <stable@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

This code currently copies the ExtendedError struct to the stack,
modifies the copy, and then doesn't modify the original. Thus, fix it.

Furthermore, errors when replying must be delivered directly to the
remote thread, so update deliver_reply() to take an extended error
argument.

Cc: stable <stable@kernel.org>
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Carlos Llamas <cmllamas@google.com>
Link: https://patch.msgid.link/20260605-set-extended-error-v3-1-d60b69a75f97@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 77bfebf110773f5a0d6b5ff8110896adb2c9c335)
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/error.rs       | 13 +++---
 drivers/android/binder/thread.rs      | 65 +++++++++++++++++++--------
 drivers/android/binder/transaction.rs | 15 +++----
 3 files changed, 58 insertions(+), 35 deletions(-)

diff --git a/drivers/android/binder/error.rs b/drivers/android/binder/error.rs
index c6a834071f8c..fd9e9d9e5658 100644
--- a/drivers/android/binder/error.rs
+++ b/drivers/android/binder/error.rs
@@ -72,20 +72,17 @@ impl core::fmt::Debug for BinderError {
     fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
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
index 93aa98c2a173..ad8bdf762ddc 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -498,9 +498,16 @@ pub(crate) fn debug_print(self: &Arc<Self>, m: &SeqFile, print_all: bool) -> Res
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
@@ -1105,7 +1112,10 @@ fn unwind_transaction_stack(self: &Arc<Self>) {
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
 
@@ -1117,8 +1127,9 @@ pub(crate) fn deliver_reply(
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
@@ -1132,6 +1143,7 @@ fn deliver_single_reply(
         &self,
         reply: Result<DLArc<Transaction>, u32>,
         transaction: &DArc<Transaction>,
+        extended_error: Option<ExtendedError>,
     ) -> bool {
         if let Ok(transaction) = &reply {
             transaction.set_outstanding(&mut self.process.inner.lock());
@@ -1147,6 +1159,12 @@ fn deliver_single_reply(
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
@@ -1217,6 +1235,9 @@ fn read_transaction_info(
         info.buffers_size = td.buffers_size as usize;
         // SAFETY: Above `read` call initializes all bytes, so this union read is ok.
         info.target_handle = unsafe { td.transaction_data.target.handle };
+
+        info.debug_id = super::next_debug_id();
+
         Ok(())
     }
 
@@ -1225,6 +1246,8 @@ fn transaction(self: &Arc<Self>, cmd: u32, reader: &mut UserSliceReader) -> Resu
         let mut info = TransactionInfo::zeroed();
         self.read_transaction_info(cmd, reader, &mut info)?;
 
+        self.clear_extended_error(info.debug_id);
+
         let ret = if info.is_reply {
             self.reply_inner(&mut info)
         } else if info.is_oneway() {
@@ -1234,23 +1257,21 @@ fn transaction(self: &Arc<Self>, cmd: u32, reader: &mut UserSliceReader) -> Resu
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
@@ -1315,18 +1336,24 @@ fn reply_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
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
index 733f452d8f49..b5434a2ae819 100644
--- a/drivers/android/binder/transaction.rs
+++ b/drivers/android/binder/transaction.rs
@@ -42,6 +42,7 @@ pub(crate) struct TransactionInfo {
     pub(crate) reply: u32,
     pub(crate) oneway_spam_suspect: bool,
     pub(crate) is_reply: bool,
+    pub(crate) debug_id: usize,
 }
 
 impl TransactionInfo {
@@ -82,7 +83,6 @@ pub(crate) fn new(
         from: &Arc<Thread>,
         info: &mut TransactionInfo,
     ) -> BinderResult<DLArc<Self>> {
-        let debug_id = super::next_debug_id();
         let allow_fds = node_ref.node.flags & FLAT_BINDER_FLAG_ACCEPTS_FDS != 0;
         let txn_security_ctx = node_ref.node.flags & FLAT_BINDER_FLAG_TXN_SECURITY_CTX != 0;
         let mut txn_security_ctx_off = if txn_security_ctx { Some(0) } else { None };
@@ -90,7 +90,7 @@ pub(crate) fn new(
         let mut alloc = match from.copy_transaction_data(
             to.clone(),
             info,
-            debug_id,
+            info.debug_id,
             allow_fds,
             txn_security_ctx_off.as_mut(),
         ) {
@@ -117,7 +117,7 @@ pub(crate) fn new(
         let data_address = alloc.ptr;
 
         Ok(DTRWrap::arc_pin_init(pin_init!(Transaction {
-            debug_id,
+            debug_id: info.debug_id,
             target_node: Some(target_node),
             from_parent,
             sender_euid: from.process.task.euid(),
@@ -141,9 +141,8 @@ pub(crate) fn new_reply(
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
@@ -154,7 +153,7 @@ pub(crate) fn new_reply(
             alloc.set_info_clear_on_drop();
         }
         Ok(DTRWrap::arc_pin_init(pin_init!(Transaction {
-            debug_id,
+            debug_id: info.debug_id,
             target_node: None,
             from_parent: None,
             sender_euid: from.process.task.euid(),
@@ -380,7 +379,7 @@ fn do_work(
         let send_failed_reply = ScopeGuard::new(|| {
             if self.target_node.is_some() && self.flags & TF_ONE_WAY == 0 {
                 let reply = Err(BR_FAILED_REPLY);
-                self.from.deliver_reply(reply, &self);
+                self.from.deliver_reply(reply, &self, None);
             }
             self.drop_outstanding_txn();
         });
@@ -462,7 +461,7 @@ fn cancel(self: DArc<Self>) {
         // If this is not a reply or oneway transaction, then send a dead reply.
         if self.target_node.is_some() && self.flags & TF_ONE_WAY == 0 {
             let reply = Err(BR_DEAD_REPLY);
-            self.from.deliver_reply(reply, &self);
+            self.from.deliver_reply(reply, &self, None);
         }
 
         self.drop_outstanding_txn();
-- 
2.55.0.795.g602f6c329a-goog

