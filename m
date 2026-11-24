Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=147.229.8.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795555165;
	b=4JsVnJd0YhtfT2ELnFVi54ysWI+wLQHBMm5xwUG6dIJqs5aGxoN6ePWZCe9/rkqginvT
	 3LPkAEOpDqT0t9BIMJskreJNVuxkpUWaXDiuthmj+8fX/tFx06Hbat48e20kDaq+A98SN
	 l1tXPziYcn25LKEnz4AVBqwUERcKFKRs/agc6F1vl8yL0yrI76OTgp2dMcdP4iO4ZJri8
	 RXQrK96QPnsp9Oe5R2LIDUdB92ioaPITMo50aSUjDOMXYKY+sP/sh0fXfhO/ACOvyhO07
	 S8Xw33o85tZLNzmN7NpGd3Od1t2kiH1Wrp95fVj00hDLu4Ey5O35mKs//qg7rV9BbwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795555165;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-Spam-Status:X-Spam-Checker-Version;
	bh=D6ZHYEI070EvMU4ryionbOt3ndI7Wv+kJj983byjX+M=;
	b=23WLc880Mavp79tGfzVihUiLYk0GZFiQ7YCFNupZ3u/sTsUXw7V+WzvCfQ0agpivwMOr
	 YgAxysaEsRGK9dFI3IGrCFWSpeVHbQYiewdf8nxLAQ7uL+G2+WS7xoVFYRZUC1qZWVd/x
	 Fo5ZK1347YKChB7hgx4dffcc5yNb3ejDw8+z2Ihvl7n9uc9QVuuEIkesE/YRjUomQIQt0
	 AOB80KubBjyF5/yE/eXMj5fn8VnweWpV8TQIpo0CT8i/DqyeEWSOvgRb/gij8vOI98Jge
	 g1ikirJ2+x/vnEzYTiEElIGg2jqqkukeRzGT17VbxHufa/3izKFhxREyMjZGIjGEtDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fit.vut.cz;
	spf=pass smtp.mailfrom=fit.vut.cz;
	dkim=pass header.d=fit.vut.cz header.i=@fit.vut.cz header.a=rsa-sha256 header.s=a2025 header.b=gvmdE4hi;
	arc=none smtp.remote-ip=147.229.8.13
Received: from adela.fit.vutbr.cz (adela.fit.vutbr.cz [147.229.8.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5EA606A331;
	Tue, 24 Nov 2026 21:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE5EA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fit.vut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fit.vut.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fit.vut.cz header.i=@fit.vut.cz header.a=rsa-sha256 header.s=a2025 header.b=gvmdE4hi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fit.vut.cz; s=a2025;
	t=1795555151; bh=ryF2cRoqhRQLhwKI7awrvQor3e+pqAG0UR4cvEwkDwQ=;
	h=From:To:Cc:Subject:Date:From;
	b=gvmdE4hiccdHUep/rpfCfJm5vzu7yYTOBV/TDRmcrWGOpjUYxPrI7rgT4Z9Gp4r3p
	 NV+7MudJiYfpJDfFCWT67tKnQ6IWGE5ag7C4A5SG1ryMCcvvAJqqHLpixrTJ0qW/E4
	 7nPgXC/XoeQVbvsFKDlj0ND6F9MNvXZKmCmd4+AMqLOw5zetWeim7v7IdCLL1Wy1AI
	 MQZkrAEXiha/urzvXkJZftY4bJjY/YCWj58Meq9C1OnDP/uuL9XI5jCe6eaLsaIOOD
	 RfvHrDqCqvAVs5pjI3mNYX0BJV4ejKRPHtFnCd/bt+p12AgQobpus3DvwJRP+JDAZT
	 NL0S7OnZMnWBg==
Received: from tomoka (unknown [100.72.76.61])
	(Authenticated sender: inguyen)
	by adela.fit.vutbr.cz (Postfix) with ESMTPSA id 4F90B260127;
	Tue, 24 Nov 2026 22:19:11 +0100 (CET)
From: Nguyen Le Duy <inguyen@fit.vut.cz>
To: gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	brauner@kernel.org,
	cmllamas@google.com,
	aliceryhl@google.com
Cc: ojeda@kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Nguyen Le Duy <inguyen@fit.vut.cz>,
	stable@vger.kernel.org
Subject: [PATCH v2] rust_binder: make work items of a deleted node a no-op
Date: Tue, 24 Nov 2026 22:18:09 +0100
Message-ID: <20261124211809.3692554-1-inguyen@fit.vut.cz>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.6 at adela
X-Virus-Status: Clean

When a node has no references left, do_work_locked() removes it from
the owner's nodes tree. However, a Node work item may still be queued
at that point. This happens when a strong zero2one increment is
scheduled through a NodeWrapper while the Node is already queued, all
references are dropped again, and the wrapper runs first and deletes
the node.

When the stale work item runs later, do_work_locked() calls
remove_node(self.ptr) again. If userspace has created a new node with
the same ptr in the meantime, this removes the new node from the tree.
The owner can then no longer look it up, so BR_RELEASE and BR_DECREFS
are never sent for it, and the next BINDER_TYPE_BINDER with that ptr
creates yet another node. Since update_node() looks nodes up by ptr,
freeing a buffer that refers to the hidden node decrements the other
one, and a later NodeRef::absorb() hits:

  rust_kernel: panicked at drivers/android/binder/node.rs:822:17:
  assertion `left != right` failed
    left: 0
   right: 0
  kernel BUG at rust/helpers/bug.c:7!
  Call Trace:
   NodeRef::absorb
   Process::insert_or_update_handle
   AllocationView::transfer_binder_object
   Thread::copy_transaction_data
   Transaction::new
   Thread::transaction

No race is needed, and with CONFIG_USER_NS=y an unprivileged user can
trigger this with a binderfs mount in its own user namespace.

Fix this by tracking in NodeInner whether the node has been deleted,
and making Node::do_work() and Node::cancel() only clear the delivery
state of a deleted node. A node is only deleted once it has no
references, so any BR_RELEASE and BR_DECREFS were already sent, and no
new reference can be taken on it. NodeWrapper::do_work() does not need
the check, since the node is never deleted while the wrapper is queued.

The delivery state is cleared by a new DeliveryState::node_done(), which
also replaces the open-coded reset that Node::do_work() already had.

Found with the Kani model checker. Tested with a reproducer on v7.4-rc3
in QEMU, x86_64 only.

Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Cc: stable@vger.kernel.org
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Nguyen Le Duy <inguyen@fit.vut.cz>
---
Changes in v2:
- Make the work items of a deleted node a no-op instead of checking the
  tree entry in remove_node(), as suggested by Alice
- Add DeliveryState::node_done() to clear the Node's delivery state
- Link to v1: https://lore.kernel.org/r/20261122191322.929005-1-inguyen@fit.vut.cz

The reproducer was sent to the maintainers separately. The Kani
harnesses that found the bug pass with this patch.

I used an AI assistant (Claude) for the analysis, the reproducer, the
code and the changelog. The fix follows Alice's suggestion.

 drivers/android/binder/node.rs | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder/node.rs b/drivers/android/binder/node.rs
index efdafc2..1f2bab6 100644
--- a/drivers/android/binder/node.rs
+++ b/drivers/android/binder/node.rs
@@ -124,6 +124,13 @@ impl DeliveryState {
         self.has_pushed_wrapper = true;
         self.has_strong_zero2one = true;
     }
+
+    /// The `Node` was delivered or dropped, and the wrapper is not scheduled.
+    fn node_done(&mut self) {
+        self.has_pushed_node = false;
+        self.has_weak_zero2one = false;
+        self.has_strong_zero2one = false;
+    }
 }
 
 struct CountState {
@@ -178,6 +185,8 @@ struct NodeInner {
     active_inc_refs: u8,
     /// List of `NodeRefInfo` objects that reference this node.
     refs: List<NodeRefInfo, { NodeRefInfo::LIST_NODE }>,
+    /// Set when `do_work_locked` removes the node from the owner's `nodes` tree.
+    is_deleted: bool,
 }
 
 use kernel::bindings::rb_node_layout;
@@ -238,6 +247,7 @@ impl Node {
                     has_oneway_transaction: false,
                     active_inc_refs: 0,
                     refs: List::new(),
+                    is_deleted: false,
                 },
             ),
             debug_id: super::next_debug_id(),
@@ -636,6 +646,7 @@ impl Node {
         }
         if no_active_inc_refs && !weak {
             // Remove the node if there are no references to it.
+            inner.is_deleted = true;
             guard.remove_node(self.ptr);
         }
         drop(guard);
@@ -727,9 +738,13 @@ impl DeliverToRead for Node {
             return Ok(true);
         }
 
-        inner.delivery_state.has_pushed_node = false;
-        inner.delivery_state.has_weak_zero2one = false;
-        inner.delivery_state.has_strong_zero2one = false;
+        inner.delivery_state.node_done();
+
+        if inner.is_deleted {
+            // Nothing is pending for a deleted node, and userspace may already have reused its
+            // address for a new node, so leave the tree alone.
+            return Ok(true);
+        }
 
         self.do_work_locked(writer, owner_inner)
     }
@@ -743,6 +758,13 @@ impl DeliverToRead for Node {
             return;
         }
 
+        let inner = self.inner.access_mut(&mut owner_inner);
+        if inner.is_deleted {
+            // A deleted node has nothing to deliver, so don't requeue it.
+            inner.delivery_state.node_done();
+            return;
+        }
+
         // If BINDER_THREAD_EXIT is invoked on a thread with a pending node refcount update, we
         // should move ourselves to ensure the refcount update is still delivered.
         if let Some(node) = ListArc::try_from_arc_borrow(self.as_arc_borrow()) {

base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
-- 
2.56.1

