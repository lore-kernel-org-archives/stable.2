Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852A0388893
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783077925; cv=none; b=fBrSjUn+ZhEFedt+88TdfijVjWVGaZ8sQpRoUr/FUpUrOCzWilvIvr8Y0mVarWsL8jYp2dvECDgcXFZp93lZcSldpW4Y4vhDID8x8BYgvw1GQkYOvk9b6NfoOjE73ehOV7wFfTAWOVW/g3AOVxAQNOiRg94brggklaQBHYVXEh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783077925; c=relaxed/simple;
	bh=sfxXRBCjYtWmQWoIrPpXmCIm6bSqjkrDfV1GfKq6d/M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=muDChbb1CyLbTeW1Y1h5Z8YCZ38QWsZKVrWmGuZ7I9kR+dMP/yyJWeyFfGsk/K61XdEAcr7+J02sXPTpi9p6utmhvkb2ObucOK7SzecvEFAR2e5Vb82g4an+s/e2xylQB2WgrytOnEXqusqeEE+kE6grmh22krhBKRGkraGTcyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ddSrRZOw; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ddSrRZOw"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-493b786d550so4802825e9.0
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 04:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783077919; x=1783682719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SCqXp9VH3iBuz5exRugWLU1vY3GeeIWYYL2H+UtC82c=;
        b=ddSrRZOwbdRbmEWiEp0/ioNogBWY4YtzH5HG8sqJie/RDSl9/Qm8NzZa/zKWN7Hzo7
         jLpIzpHgKmWyzBPSD6GBf3KNaArn8akPKDDKalFLo/Pq2Y2q9XWifYpGjKUDJlmK09Kv
         b7lBOIvxJ6o7kShYQ9A5VsBLJfhe4tOMk2w6TzS60uMkKAI5ygs2EGRwcQLLncxfzf5J
         vuEddDyZDvT82zhviMMhwelsbficndHKY+gqDxMenk+2qxFQxyja7yXaeLVtA8JTyPQ2
         JeKDtsuUPo2nME+yxTUui5FqfkCS58k94FbenbRoFQe71pIGTtq2E9k2emLWgov84Pvg
         LDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783077919; x=1783682719;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SCqXp9VH3iBuz5exRugWLU1vY3GeeIWYYL2H+UtC82c=;
        b=d2zOIx2Bh3FtO0VjnHuYoENXacdkVjW7+dl/VziMO6JA2rGQb2IIoAwMBIC/tBPxOf
         d+ICTCzAKxJH6NqGugHQCTUhsIA9wONvT/X9xicsXj3srIXBpqDZgvDRPRWWP2qdnd2q
         5XnVfPbKFA0dGDnfUXe0SdiKCznEQ89GTcHT0uxLiyEQkoknQVCchGzjo/uMN4aAkP6M
         vPTX4+Oj9V27dS3aFhGjpVQsEOmNex3FYk8gEjhCiHjXW4gDTZIOvtR2d+19zXZRb5b3
         jK9K90KtT4j8/L2dZXpo0nSOor1TOYqseB6jKCws8gm2AZeNSEZVVYnuRJIyDKG4xMD5
         55rA==
X-Forwarded-Encrypted: i=1; AFNElJ/yDjyFG7mKXx3FQ/iBXUo3ThmaliMu4ayAgKiSGHZaZkNEwwxV80YXTqmjjvBM6yOhGjHz25k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy7F8K6uyGVxfAPD6Od+iqcLLeyWYTutNfGBdhXSUVbKqWF7cv
	XX5WQtctG2Ain5YsRYqCMl5xtyw0TjWYEBbusxqD0UIKXPK2//wB/btz+yWjOamnFNEBUhLhoxp
	DcHNC7I/j0xie8XLRJw==
X-Received: from wmim5.prod.google.com ([2002:a7b:cb85:0:b0:48a:5334:11e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5307:b0:493:c3e0:c4 with SMTP id 5b1f17b1804b1-493c3e00358mr124550875e9.22.1783077918954;
 Fri, 03 Jul 2026 04:25:18 -0700 (PDT)
Date: Fri, 03 Jul 2026 11:25:12 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABecR2oC/42OQW7CMBRErxJ5zY9iG2zCqvdAXcRhHCyRmNrBa
 otyd4yjSu2qLN9o9GbuLCI4RHao7iwguej8lEFuKtafu2kAuVNmJhqhGtW0FDD6BLIB+Ab56Se
 Y/AkkG2hhrTJbBZYV1wDrPov++L5ywMctr8xryEwXQb0fRzcfqqRrQaHn7Nk9uzj78FWeJV7Kr 51InDhZpa00rbEw+7fB++GCOs8UcxK/bHz3j01kWyuN5Fop6O6vbVmWByWBcVVDAQAA
X-Change-Id: 20260609-remove-freeze-on-remove-node-30e72ff6b46e
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5488; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=sfxXRBCjYtWmQWoIrPpXmCIm6bSqjkrDfV1GfKq6d/M=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqR5wZHnyMu1qcxkCkPNHv2pA4tDN4jrzslXoIQ
 NcMeKXEhueJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCakecGQAKCRAEWL7uWMY5
 RkhYD/9A47eYXut4U2kxrBjIgODE/wd73gFaO9Q7AHtsfpft2jQpE/EjXqK9hjQdZW881TEh1Bs
 Q1TbhBdBWYOFT1eNZTxaldlYVYuZ558DXn+jDf5B4n/IP92xZnbjXorz4sFLFs19CQTbOsxsF82
 JNLCxY1IiFv3TDPEx9kR7NplkdIaTQXyfE+aEDvEA1bV0+Hamdep/6aejHEQDL3r520TYLg/MVW
 /MUELppxuDNzWaIu6jYT/bR3IgEZuea371v9bh8/dGOWx82CEEihl/W3/gWP8wJMfwOXOr2JDtF
 pUSL9akKdKIyEZwzSkkYkTNzQqMjF94r2F0VQ3ZWblkM/BkxklsBc1GWMtFULXD1zDHlFiCCZUr
 zTM6kPNEJ1vtIIYuDLJILaxG4bxMpH4pa4pJMMrh4FVJWGqbd8Ph2cjfdV1ctNb/wKR4hMiLK/c
 zw2kmL8ZJONqRZaxHaQq2O3gzOfRcGDAYHfQC8y7+Z57z3droF3PddzPX0YcuxLTE+LqVKvZIlD
 28uIcJKC8Bf3sS8Ymm1wHI55PDvIqW3HwOVw39VaXCCgW+KvtBnB7GbmYVzM1jzDCfr4bQ+GM2F
 93i7Te1fO8eTYvAPMB4hBG75YSkqKkszm1DtqxjyhjLzfQ6ioPYn+pI4a2tq2D7KtWBf4dg/tMa XkrBwxelV2+lKuw==
X-Mailer: b4 0.14.3
Message-ID: <20260703-remove-freeze-on-remove-node-v3-1-6e0c4547af46@google.com>
Subject: [PATCH v3] rust_binder: clear freeze listener on node removal
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
Changes in v3:
- Get rid of dependency.
- Rebase.
- Link to v2: https://lore.kernel.org/r/20260615-remove-freeze-on-remove-node-v2-1-93b31766e7a8@google.com

Changes in v2:
- Rebase on v3 of parent series.
- Link to v1: https://lore.kernel.org/r/20260609-remove-freeze-on-remove-node-v1-1-f67f3b9bfeb8@google.com
---
 drivers/android/binder/freeze.rs  | 11 +++++++++--
 drivers/android/binder/node.rs    | 10 ++++++----
 drivers/android/binder/process.rs | 12 +++++++++++-
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/android/binder/freeze.rs b/drivers/android/binder/freeze.rs
index 53b60035639a..f4df14568b25 100644
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
index 69f757ff7461..c10148e9069f 100644
--- a/drivers/android/binder/node.rs
+++ b/drivers/android/binder/node.rs
@@ -682,12 +682,13 @@ pub(crate) fn add_freeze_listener(
         }
     }
 
-    pub(crate) fn remove_freeze_listener(&self, p: &Arc<Process>) {
-        let _unused_capacity;
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
@@ -695,8 +696,9 @@ pub(crate) fn remove_freeze_listener(&self, p: &Arc<Process>) {
             );
         }
         if inner.freeze_list.is_empty() {
-            _unused_capacity = mem::take(&mut inner.freeze_list);
+            return mem::take(&mut inner.freeze_list);
         }
+        KVVec::new()
     }
 
     pub(crate) fn freeze_list<'a>(&'a self, guard: &'a ProcessInner) -> &'a [Arc<Process>] {
diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index ca664fda8e81..cdd1a9079726 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -946,6 +946,8 @@ pub(crate) fn update_ref(
 
         // To preserve original binder behaviour, we only fail requests where the manager tries to
         // increment references on itself.
+        let _to_free_freeze_listener;
+        let _to_free_freeze_listener_cleanup;
         let mut refs = self.node_refs.lock();
         if let Some(info) = refs.by_handle.get_mut(&handle) {
             if info.node_ref().update(inc, strong) {
@@ -961,6 +963,14 @@ pub(crate) fn update_ref(
                 unsafe { info.node_ref2().node.remove_node_info(info) };
 
                 let id = info.node_ref().node.global_id();
+
+                if let Some(freeze) = *info.freeze() {
+                    if let Some(fl) = refs.freeze_listeners.remove(&freeze) {
+                        _to_free_freeze_listener_cleanup = fl.on_process_cleanup(&self);
+                        _to_free_freeze_listener = fl;
+                    }
+                }
+
                 refs.by_handle.remove(&handle);
                 refs.by_node.remove(&id);
                 refs.handle_is_present.release_id(handle as usize);
@@ -1384,7 +1394,7 @@ fn deferred_release(self: Arc<Self>) {
         // Clean up freeze listeners.
         let freeze_listeners = take(&mut self.node_refs.lock().freeze_listeners);
         for listener in freeze_listeners.values() {
-            listener.on_process_exit(&self);
+            listener.on_process_cleanup(&self);
         }
         drop(freeze_listeners);
 

---
base-commit: 728e68a889bcf257b1e67298b12c360e5c3a13e0
change-id: 20260609-remove-freeze-on-remove-node-30e72ff6b46e

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

