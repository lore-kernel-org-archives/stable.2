Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EA83F9F5C
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002398; cv=none; b=dvb80o24f8PwaAD79Bsco9TUUCvcYAT2DKsadFp6k0B2Jz0gWd0lKA//Ec6+VuJIa4tNMmb8OIY+RxZidQt31XaRnaIF3g3GjzlwdxUEDX2VAmoh0B/xAm10eSU0HxyRTcKwC4m7eRH4ALzC2l4fucMFefBcwfVrcupa47UGDus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002398; c=relaxed/simple;
	bh=z8/bjZsp3am85zxrUEQLRTItYorQtqnU2+9GLSyWZZE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ocq0vW0FsQ1GMErjzlWZzKd4rnz+UfdAxEO8gr5KaJdTKZOIJDpINeDoUc+ea4La62Ai55TLAba4wkkrsOdWSJAOBGk/6d+cSX/ek6NvAHmPgEcTOhM9lhV1tSDRmCthA/Hn8X9NV42YLLe1A4qQY2qhGdjOVltGYCnUzBcxxYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cgrpAIId; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgrpAIId"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso43274195e9.2
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 03:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781002395; x=1781607195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QPFU6x+RKCIxPBY9TzbtGFpklCJgi8N62FETGtUCWJQ=;
        b=cgrpAIIdXcd9Y2VKUFXr8VVIy5yO2leSCVVpSwrDJIcV2DGaZOW373sOh7IJdUCYKZ
         peXMVsU8/luJOf9kIYIn/jk0M6uIbj9TCUeFZs9kOOYPN1c/DYoxECDX600NrI8iTvSa
         fE48sW8/DZynLp5RFX/QLP5LpWX70jptOg6/NnhQCLbAwsI+Z0J0WeBeENG+5AkVkA0e
         pHwj9vI39nar/swqx9HEPbOLMEjskbfnBZ7pSF57GqhwL7+7iuHaY8EuWBl4AQO5dVG0
         Ij2B1sXXL2nLUjr+TgqahVkC+REHE57Z3uAddpb77DvotMAYK+SThY9RU15qrSifL1VR
         oZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002395; x=1781607195;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPFU6x+RKCIxPBY9TzbtGFpklCJgi8N62FETGtUCWJQ=;
        b=kc8EmJXtBeh1HPuB6H239L3C43Cd7ai+JvSrIbz5eTq04w5NG4v2atOX/uO9oHAI9i
         6tHFNGLeEPtei6b4klUFs21mMOYyoIlPmtv8dmd6ikPTT5RWMpsPnMfKbcv7Ig28Acf9
         dNSX+5CKunQ9Jrv8+zwJkmfsdPpo52QewbhQr+M06a59bpAlrSYt4ndibIK0eU/eaUQp
         v1orMWbLhSCxiTi5KBu8fPnhZ+/i4EJfOoGMjwYWijOZ+XK8qIO/H2G+yosMsOsRHhOD
         aLYr3PXmUnPC0gLIxRsmv6BesvKiRSyT3DI6PZ4giXT2Q3vEEk+ABWoMfd09DksWkqGf
         qhPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yTHSgVbH1i9oQMgA8wgN+4D6vCdeoGNBEY3+11ge66n8Ll8WYeWtt8yrpDBbh5h3tT0UPn8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxqHONkJRQPAPk9NyAiDejFSm0s9Hxw35AX02GaXxqtXcLenmo
	h6Gl88C8JQprik/9X/J11SPwAd8m1gdwSO7aubuZv6uoUW0tpwajY5rQUxsMDPOFpEh8QyUiIkJ
	R7AWpT1L5Rv/1GhwXXw==
X-Received: from wmbgv3.prod.google.com ([2002:a05:600c:80c3:b0:490:ad90:c234])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e83:b0:490:af90:f9c2 with SMTP id 5b1f17b1804b1-490c25b224dmr319816185e9.12.1781002395222;
 Tue, 09 Jun 2026 03:53:15 -0700 (PDT)
Date: Tue, 09 Jun 2026 10:53:03 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAI7wJ2oC/02Nyw6CMBQFf4XctdeUh+XxK4YFlFPtghZbJEbCv
 9uAJi5nFjMrBXiDQE2yksdignE2QnpKSN07ewObITJlIpNCipo9RreAtQfeYGd/wroBnAuUmda
 yLyQoJiYPbV57/toe7PF4xst8SOq7AFZuHM3cJEt5TtkrSf/35ruuuDd2gN9PsRs4TMZy3gkoc alqUeTNklG7bR/vuWnd1QAAAA==
X-Change-Id: 20260609-remove-freeze-on-remove-node-30e72ff6b46e
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5429; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=z8/bjZsp3am85zxrUEQLRTItYorQtqnU2+9GLSyWZZE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqJ/CVAmZoDnNNbp9NJ3e4+K8fwkBtEpzbyvdWc
 MZ9RCCtkW2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaifwlQAKCRAEWL7uWMY5
 RpdtD/46XB+90vkSBbCyQNJL9JF7qujkTCaCNzUmrjOSc+XAunFZ06tUZ1n3cZaixhKNTjD7sxu
 gEO7STLx7O+znwTgXKj+KjdLVYp2largjG0vsmIGRH6Mg+Ow+Iv3io5Bc2i6FHs8yhAKIKh2H9L
 ibXQGjqc3xaoeHQ8t1LxH1Z36w3R03lXVJi1hGz9Qiqb/PtoJmRiy3lH2vbS94hKBfwJYWOZLSo
 vZ5Odu+SobNSwc7cep+2AfgVfosLKoVrlOE8qjIjLDxUJfxbl4a55YWnBG7yyDU+cngAi2gRMA6
 FVps8PRh7LWHXsoAu4dUcjHec/XGuoyp0vtIfz+MyrydXACf14whmdE7vH48+3fgOrX45vTDGnn
 b3bD3OlS3FpG+A1BfHh+Xj2i2OyqJPwYqHhbrWHGaX1nk9zCFQ2JbvtKxqi5sUGLR16nfCNcN/A
 qzFfCBmplD+mbnKYtP8uVPV0aqBZdfbLuAFnhVPE3YZPZfVCoS5jVOR+qPidpc+2jyBrXVMwmud
 0DRCpXJKXLIrBYI2yoWeybpV4q0LdzDChUmR3OIEViXaAGeJ67vPBeAH3eCMGMTLF4JmZwOLKbS
 eJy0ysvwm7he/ufLK7VKI+glXVMS0clSZ8zcrthPzf3HLWX8l40ayhdLhwBSwL1GT0QFUzeNEBd KCYWZ5aTKfzPEPg==
X-Mailer: b4 0.14.3
Message-ID: <20260609-remove-freeze-on-remove-node-v1-1-f67f3b9bfeb8@google.com>
Subject: [PATCH] rust_binder: clear freeze listener on node removal
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
https://lore.kernel.org/all/20260609-binder-noderefs-spin-v2-0-eafde2ff376c@google.com/
---
 drivers/android/binder/freeze.rs  | 11 +++++++++--
 drivers/android/binder/node.rs    |  6 ++++--
 drivers/android/binder/process.rs | 13 +++++++++++--
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/android/binder/freeze.rs b/drivers/android/binder/freeze.rs
index 20041689e98d..1b49e63723b5 100644
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
index fb27674a8c94..79f660071bd6 100644
--- a/drivers/android/binder/node.rs
+++ b/drivers/android/binder/node.rs
@@ -687,11 +687,13 @@ pub(crate) fn resize_for_add_freeze_listener(
         Ok(())
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
prerequisite-change-id:20260608-binder-noderefs-spin-3a0ec0589043:v2
prerequisite-patch-id: 3a1c4f545b2281e2e91ea0af7fe6c71f5ae0c08e
prerequisite-patch-id: e1ae5f73b329080c0fcea1d2509c085e105f67c3
prerequisite-patch-id: 63f2092c6fd9dd54b7adf93be8d5670d8490f401
prerequisite-patch-id: 5811aeb4ca435a1d4d0bb347d4de9f3b2d91f814
prerequisite-patch-id: 556e45c697f9888c8446245bbcf478422991fddf
prerequisite-patch-id: f567ba2263108b12871013309ae7c482d500eeae

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

