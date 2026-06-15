Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0183ECBEA
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529232; cv=none; b=Y1G4+ekoCBpipqfNv0WtAa+mTgUXrdzi4IFdc/f00H3Ve44rc62GjEobYNMllQ61rhmLt1GuXahe1zd11hzz31LjDghtmfbLRgBxeg65Q0Gzi8XS8l2X01gOGryHEIFj5gETk0j3hNwVHyhHrVwWNCaamvFD2YPDOMS3hDoKoXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529232; c=relaxed/simple;
	bh=Flr0nvbGu2rzscCAqult96hCd87d8QCR9s4fxBiX2Dc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eHEDniJG2gNgHFndQPesfRD0wAPyE0FmEQhbeVzKx+CJE8NQL2wSCh65okF9ekLnfevdhRCYNXa4OuyDX/zipRef6IO/1VDrgeO1hr91ZkGFEfiZ3up/xw20febG5e5NN9IiCbO87+s2+GLrYcmBvKHbeIwUjYAVcsvDshHKcJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uHaNjGPa; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uHaNjGPa"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-691a67a7b58so2506256a12.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 06:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781529230; x=1782134030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XleLdtW/J5DXsvoJgFXvims7MfxdiMmejRDtQ3BfezY=;
        b=uHaNjGPavuSQhBIRcAn0QqXdlupL/CYKUqEumZRaJCWb26OpMO/U2vgZMIBE5QIdqc
         F/SQlAppWBTJRqe7GnOta99jljH2oWns+bopkvets17kYPD96axQsgWg6FSM4tVC/sqU
         lP36fGqEusTs9reYvxs7cdkcKzJAqtmYSp8mnXFdjb7cUsikLbiWr91Z025ir5KHw6Qm
         9qzpEC0cOlSiEI49bSwQGDnSe05K1312nY9EGccS2SxfjJYKc/kVXsnas2ZW/P3w8sNU
         grZ5z3dQ9hzAjhwuWnWWnj+DFhDDDIFur/QMbu4UD/bnoptaBux6945I1OKNIYP53BHe
         A2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781529230; x=1782134030;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XleLdtW/J5DXsvoJgFXvims7MfxdiMmejRDtQ3BfezY=;
        b=YqRk7m+okfeSDkKiZtc3ioHoP+03+iPjUjsheV2A023l794IbJsj4nLf305+zHbkZz
         GGdMwrXiZwB7RqyhBp+3E2tRtpBuj8JQT/TanogGl9C+rk6taY+p6jDA9rhKvhsg+j8o
         TOj/U7J6dnRzRTSaoIcuf9v7j7/RKyT7s4kAZoCEK4Y039aN4drsH1WwYYinodmhrqhB
         DmwBSz/17gkeQy2ZTApJd1KK5ODpxO/uWl3KAjwz1rh52ufcQpGutSGssvVEfmRryf6S
         RORbcT3pLhJrv1SA00Ld7SZwFxCRYQ/SckvaF9x+rlbZzNFznNpuH/fWk6qz7X95ZGI2
         LLqA==
X-Forwarded-Encrypted: i=1; AFNElJ/D9KTeGipHE0Ea9Bf9x5Ufu9XohFUjW+6Om7J245L/DLnswKF59n0f18c0l/rmuP3pL6HvKFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5aXTIwtKkPW6wKy4cYIGfnccuhz/tj0h/spAsnUDCmllrc7XC
	88rzUi4+S0qgpXVvKGMDg3hsS3j9hDSC+CPOrIQfnou2y0s1QQ/UrSfAUEtGlmSpGivwyPhRMkA
	s3xao0YbR/ha8Gen8zQ==
X-Received: from ejc6-n1.prod.google.com ([2002:a05:6938:a006:10b0:bec:48f5:cfdf])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:cc17:b0:bec:4b96:5fb4 with SMTP id a640c23a62f3a-bfe288ff5a2mr417289566b.11.1781529229357;
 Mon, 15 Jun 2026 06:13:49 -0700 (PDT)
Date: Mon, 15 Jun 2026 13:13:16 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGv6L2oC/42Py27DIBREf8W6694ImxQ/Vv2PKgtjDw5SDSm4K
 A/530OdROqyy5nFOTM3iggWkbriRgHJRutdDtVbQcOxdxPYjjlTJSollGg5YPYJbAJwBXv3Kpw
 fwVKgroxReq9AGXEKMPa84T8Pjxzw/ZMty6Mk3Ufw4OfZLl2R6l3JYVD019491Q1r60aEzZS5k
 ePJOpa9wCDem1bsZZck/WqONi4+XLZTqdw8/9ufSi7ZqNpI3WoD3XxM3k9f2OWFdFjX9Q4BGnM nMAEAAA==
X-Change-Id: 20260609-remove-freeze-on-remove-node-30e72ff6b46e
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5585; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Flr0nvbGu2rzscCAqult96hCd87d8QCR9s4fxBiX2Dc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqL/qHfvv3TIc1xFw6L3GGmJxAiV3UEEZxCM304
 SMicUPpPQOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCai/6hwAKCRAEWL7uWMY5
 RkbkEACN1796SqJ0mJiGrmx0GZ6CCzIb0Oq42Yj3VLI7JSVTO9m/qN3LTLxsmVcuRWBXgQpDZrT
 3+jKQm8gGJb1JOHviVF/R8WdGt+LfyhsQr66BXn6ZwcxuONetdxfCIuSVIZvrJ/NCypfIV3Yo2o
 DrOvnr5T5XWKDYoOTufbeZRvxos6YqJbTZNEqghRhVJj2d6v55AwWw5aVhdosHJrL+daOzarLzA
 PtL/sFK3pFnNoCtTyUOWnnXnLsvBuQ+1R7EKGOP8IdbC8KIzdI0/AFtcbsThsuNiotaU27+SXlG
 TEers3ju1EmUdpF41V8JIr/FKxCI72fgWSmXkEUyjyVH+8FdN10mXDjFATJWa6xMfVVVMgNOWX1
 ow4tZ9NSAsVjbLzqSR8Vrys3HpHX3Auz0e/1rFhJcwRKlrZrUwslRGP+8f3bfcAfS8grDP00Nz5
 bT3LCN+Jnj9z3k0NYhjl5JI4EzQcElsmAH7Xd9poKTzb070hpGuliDScuf1NhVyhkXRBS0nDHRi
 58sDxKIMQQ1FN4M5zf37QIC09M3v9Mtnjb66MWtZBs/6Y3V8LmoLnFs4JFOM0sskq2V/CxoQ4Ln
 Ez34/YKZvRQUmxQ6ftEr+C+JZNWXR8UrkGdPN/h0o8IYfmss2I3Jfs7kWREpv5iLcBijOWlj1vi Q1APMFG+COPPNnA==
X-Mailer: b4 0.14.3
Message-ID: <20260615-remove-freeze-on-remove-node-v2-1-93b31766e7a8@google.com>
Subject: [PATCH v2] rust_binder: clear freeze listener on node removal
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

Generally userspace is supposed to explicitly clear freeze listeners
before they drop the refcount on the node ref to zero, but there's
nothing forcing that. Currently, in this scenario the freeze listener
remains in the freeze_listeners rbtree and in the remote node's freeze
listener list, even though the ref for which the listener is registered
is gone. This could potentially lead to a memory leak due to a refcount
cycle. Thus, remove the freeze listener in this scenario.

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
This series is based on top of:
https://lore.kernel.org/all/20260615-binder-noderefs-spin-v3-0-3235f5a3e0a0@google.com/
---
Changes in v2:
- Rebase on v3 of parent series.
- Link to v1: https://lore.kernel.org/r/20260609-remove-freeze-on-remove-node-v1-1-f67f3b9bfeb8@google.com
---
 drivers/android/binder/freeze.rs  | 11 +++++++++--
 drivers/android/binder/node.rs    |  6 ++++--
 drivers/android/binder/process.rs | 13 +++++++++++--
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/android/binder/freeze.rs b/drivers/android/binder/freeze.rs
index 2aef4f62cd11..5256f305e456 100644
--- a/drivers/android/binder/freeze.rs
+++ b/drivers/android/binder/freeze.rs
@@ -154,10 +154,17 @@ fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Result<()> {
 }
 
 impl FreezeListener {
-    pub(crate) fn on_process_exit(&self, proc: &Arc<Process>) {
+    /// Called when this freeze listener is cleared abnormally.
+    ///
+    /// This occurs either because the process exited or because the process dropped its last
+    /// refcount on the node ref without explicitly removing the freeze listener first.
+    ///
+    /// The returned `KVVec` is just a value that should be dropped outside of the lock.
+    pub(crate) fn on_process_cleanup(&self, proc: &Process) -> KVVec<Arc<Process>> {
         if !self.is_clearing {
-            self.node.remove_freeze_listener(proc);
+            return self.node.remove_freeze_listener(proc);
         }
+        KVVec::new()
     }
 }
 
diff --git a/drivers/android/binder/node.rs b/drivers/android/binder/node.rs
index 53fc8ba42e86..abcc979dceed 100644
--- a/drivers/android/binder/node.rs
+++ b/drivers/android/binder/node.rs
@@ -679,11 +679,13 @@ pub(crate) fn add_freeze_listener(
         Ok(Ok(()))
     }
 
-    pub(crate) fn remove_freeze_listener(&self, p: &Arc<Process>) -> KVVec<Arc<Process>> {
+    pub(crate) fn remove_freeze_listener(&self, p: &Process) -> KVVec<Arc<Process>> {
         let mut guard = self.owner.inner.lock();
         let inner = self.inner.access_mut(&mut guard);
         let len = inner.freeze_list.len();
-        inner.freeze_list.retain(|proc| !Arc::ptr_eq(proc, p));
+        inner
+            .freeze_list
+            .retain(|proc| !core::ptr::eq::<Process>(&**proc, p));
         if len == inner.freeze_list.len() {
             pr_warn!(
                 "Could not remove freeze listener for {}\n",
diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index 82c34a93660e..5802fbbaacd3 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -950,6 +950,8 @@ pub(crate) fn update_ref(
         // increment references on itself.
         let _to_free_by_handle;
         let _to_free_by_node;
+        let _to_free_freeze_listener;
+        let _to_free_freeze_listener_cleanup;
         let mut refs = self.node_refs.lock();
         if let Some(info) = refs.by_handle.get_mut(&handle) {
             if info.node_ref().update(inc, strong) {
@@ -965,8 +967,15 @@ pub(crate) fn update_ref(
 
                 // SAFETY: We are removing the `NodeRefInfo` from the right node.
                 unsafe { info.node_ref2().node.remove_node_info(info) };
-
                 let id = info.node_ref().node.global_id();
+
+                if let Some(freeze) = *info.freeze() {
+                    if let Some(fl) = refs.freeze_listeners.remove(&freeze) {
+                        _to_free_freeze_listener_cleanup = fl.on_process_cleanup(&self);
+                        _to_free_freeze_listener = fl;
+                    }
+                }
+
                 _to_free_by_handle = refs.by_handle.remove_node(&handle);
                 _to_free_by_node = refs.by_node.remove_node(&id);
                 refs.handle_is_present.release_id(handle as usize);
@@ -1391,7 +1400,7 @@ fn deferred_release(self: Arc<Self>) {
         // Clean up freeze listeners.
         let freeze_listeners = take(&mut self.node_refs.lock().freeze_listeners);
         for listener in freeze_listeners.values() {
-            listener.on_process_exit(&self);
+            listener.on_process_cleanup(&self);
         }
         drop(freeze_listeners);
 

---
base-commit: 3bc831df9ee16fceee851872315161377ca1417d
change-id: 20260609-remove-freeze-on-remove-node-30e72ff6b46e
prerequisite-change-id:20260608-binder-noderefs-spin-3a0ec0589043:v3
prerequisite-patch-id: 4984d542e1da65da603c302f0bccb423867f71c2
prerequisite-patch-id: e1ae5f73b329080c0fcea1d2509c085e105f67c3
prerequisite-patch-id: 63f2092c6fd9dd54b7adf93be8d5670d8490f401
prerequisite-patch-id: 5811aeb4ca435a1d4d0bb347d4de9f3b2d91f814
prerequisite-patch-id: 556e45c697f9888c8446245bbcf478422991fddf
prerequisite-patch-id: f567ba2263108b12871013309ae7c482d500eeae

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

