Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1369037F74C
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573048; cv=none; b=byFp5MO32hhp89CZSWG1KlCUjbSPNRNO2bjvZ7hh9Yg3nOliWz+t/i2i6UGXF63a83A8Zw0cXLGKiq4mBRDBy06GYtlmZc5nZAvUxIvqGiVH4+R8kEPKnKXBTtesuadjyatsc7BCJZQz9Oa636TdL5shR1j0xASOtsvzMHnaSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573048; c=relaxed/simple;
	bh=irE7P0EvhrLM851/VIzMflx+0DT1rrsQqwBqQK69O38=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jzSIniwZ6ijehzbqI2TaMEuUta3a5B+Ibawlk9l/0iXtf5yxdtmz+HnwzY0GCJ48HjIGeWFziywN3wzNVmwZzXwnVCWyJqJGEOtp3p80MW6Nttlgoynzn89umvy3/qho87AwKuViMpRUhHNZbsFwYa0aVlArNcdX1LswqSdgMsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H19jR1hV; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H19jR1hV"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-45ef2bd566bso364219f8f.0
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 04:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780573042; x=1781177842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z4SYEfldQ6Lx1qsEjeHpP7N2ec+VzKxXBxUTO3EAbW4=;
        b=H19jR1hVBgnfS8U7ENcu2kEoqWLhGHYVUALWw1BVnjUHqP21r3alPXmLT7s4aLrgfO
         kYFDjRT7CBrZD8v9tu4yxDcwa2OSDWlLVxg2hLOhweqc3l0CP4pyYYot/OOMPqsvZDCc
         XAtsTOJNCGL4ah6WEwXihq/uO3cV5CXF9BOAeFWp7ol3daMxba2Z5S1YxayQcOQ/UFML
         57CR81AFznwgxFwM1Cvfh+/mZoyTDaJ6sDcsLjKagbrIuhvrP9nwp3LAFBrKF1hBmfLP
         m+ZxgchlADkZjvY4MRC8J0I85MnZHhShzPgNYgAxPP3yXyWqm4AKMhsiJj0QmrkcHp15
         v1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780573042; x=1781177842;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4SYEfldQ6Lx1qsEjeHpP7N2ec+VzKxXBxUTO3EAbW4=;
        b=EKo2STuS+IHaNey1fWkLxk130Kjd5+xZeV2rlD8aULy9+nOCo1GHzyWmowsh2FBfWS
         ydfpcN3YkbArIuMKqOCkQ8n8DSniCB+tmb9NqMsxF1yyPhfA3gIW/67yc4hjp4/jelho
         QvqerdkTZczm85QF3hR7zEYLvAW8P2aLokel/E2Ig8z1asTDVw1KapR7UZEmbESIVjlh
         7khaMLYkU8g63qBGI8xii8dGxdyyUGsD0exHuXlpb+4xwAzKuT6V7WTzNLdBDu5Y0S+D
         5gNP+ZcjWbJEYKwAoRBgGAZj8AmGanMcPPUxPNiCQbSiSkC9rPb9+7IrlI3hGYC0yDNY
         uL9g==
X-Forwarded-Encrypted: i=1; AFNElJ9S6ZALaH4v5URlMI9KxXKcxfhDJZhkAZCp4dHAOPNWmc26BZfJsCGI2VtVN1rXuR3+sUPmkhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlapdpl2vXZmN8xWVG/9uaNGqz0Veg+HWENKnxSVyYLiG/f+xj
	kNWEVrgfwpsYKcQZusPxNMy07oh6C5Z7BC7a/MgXEE6nPEDhj9Cb6zclEiu6YJ6OshCY61oUNwu
	/rWT405KQjupQFYedWg==
X-Received: from wmbjp4.prod.google.com ([2002:a05:600c:5584:b0:490:1aca:caa3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a09:b0:490:4e3e:b483 with SMTP id 5b1f17b1804b1-490b5fe66ebmr124526735e9.22.1780573042354;
 Thu, 04 Jun 2026 04:37:22 -0700 (PDT)
Date: Thu, 04 Jun 2026 11:37:07 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGNjIWoC/32NQQ6CMBBFr0Jm7ZhSoI2uvIdhAfRbmig1U0Iwh
 LtbOYDL95L//kYJEpDoWmwkWEIKccqgTwUNYzd5cHCZSSttVKMtJ8yMdcbk4BgiURh66CoLZS7 GUR6+BY+wHtF7m3kMaY7yOT6W8mf/5paSS66V7eu+NkZVzc3H6J84D/FF7b7vXx2JN4W1AAAA
X-Change-Id: 20260527-set-extended-error-e2ca37e0696d
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=11686; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=irE7P0EvhrLM851/VIzMflx+0DT1rrsQqwBqQK69O38=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqIWNsve9gZtqM5uUt+N2Q4G+IS0EkDsd0v69LJ
 exoO2F4XEuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaiFjbAAKCRAEWL7uWMY5
 RrwJEACbeiugrl1gmmmcNTUBljKpzv3lyXSJmZ1maRBav1Jz+c24KkqZ7QqJA1pm0bR0ALf2QjQ
 BV00PXXtAcn3sStLE6jcUX5CVPntHGn6dgC5w8FuSoAGS1jEI/jGyvAXS0zl1/PIXEZHbYEsmkd
 iUkQIznp342qWzsNuDeTwlT5cVadnbuNZDeZd1KAZe9nPsOZLhqs0wltWd/CxNvJIXNIMR5ZSpv
 088JvsKUV06wnTYQfgYshZ/nrOjVrZeUrgFEWzcdJm7AF1/wxtW7GwtFBT0ekDpei1Qz9WBZAv9
 RbCo82gV14r6hbh+dH7t+VcSSpboV0lXePcm8rTOZfVyeM2owMmBUHeARlew6oQtY5tJBuGnRns
 NNACEqkKC+bkGce4doRtXT9ppaoldcfjKXXvJXNjLoyCY9XjoOhp+LiRuAuxX6bMGyj1URDIbBE
 p0Ex1UMoSmxbIW8ikOVv/YOAgGwDL1METWuCOeq3bDPA/jX4/rdmKLw4XdHfANQYN5yM2goVezO
 ffNgWCXmcb3CZWhpyHJdQ8Aa1o1XhVe9WWeMy3Ly0lySpivvr/4AnwihdaRXYHaTSsBxgjAl4GV
 4yHJSRZTb8N/M2+l5JIMmVCIwLXtPUxhMDmon45xb9g0FgQtsXwz2Av+Ud1sWEGf3RXtO92V5Wv gxXL5PeBndwXJyw==
X-Mailer: b4 0.14.3
Message-ID: <20260604-set-extended-error-v2-1-fb0753e7ab53@google.com>
Subject: [PATCH v2] rust_binder: fix BINDER_GET_EXTENDED_ERROR
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
Changes in v2:
- Also handle extended error for replies.
- Link to v1: https://lore.kernel.org/r/20260527-set-extended-error-v1-1-407b4b466035@google.com
---
 drivers/android/binder/error.rs       | 13 +++----
 drivers/android/binder/thread.rs      | 65 +++++++++++++++++++++++++----------
 drivers/android/binder/transaction.rs | 15 ++++----
 3 files changed, 58 insertions(+), 35 deletions(-)

diff --git a/drivers/android/binder/error.rs b/drivers/android/binder/error.rs
index 45d85d4c2815..63c8d90c409a 100644
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
+                None => f.pad("OTHER_ERROR"),
+            },
         }
     }
 }
diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index 97d5f31e8fe3..334f4b49511d 100644
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
+            let ee = ExtendedError::new(orig.debug_id as u32, err.reply, param);
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

