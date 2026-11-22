Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=147.229.8.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374901;
	b=QGWjVt/x5yuFQynnQecOxIh6Lyi+Ff/JFQWEJnjwJAwJ9NwZcjZjamdTKFhbmL0Ma3H3
	 ynHz+CyLLE/FQNLLA4vaOSYZcxoNaqF34fJoAIM9C23Zg28KMb2nrVLohk5FCIzow38VA
	 KTmOD7G52VGWEymjvz4xZduXvln5HO+P8q0dz+gFVX6XK2zQy8mBQkybkdilj4teqTPyK
	 RWtWB+vNgfUIBsLvVDCihRAOgnbQXf3jMLXvUaUQ36r1gUkfzBebJKComtVUhOn39FzDo
	 5AqP76bPGxMZu0fw8L+Zi5uVPWCh7z4X0vPIEXfBf5Xc3I+BJsM1+DQSSUEvVtqCPEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374901;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-Spam-Status:X-Spam-Checker-Version;
	bh=cBPy6R3EE54hdl8lvaDg6z2GgQzhpa7VuEiHTAs2yYk=;
	b=XFCQ1qEvgALC9kpkTFZuTxerb8ELbGp1F77Or3PH1pnYmHIhqTSDN+BgpR/wFVwyDJ6w
	 8POnBdDqZqFn6Nia2sWUIyy8oCd9vlyFUZdTcYcPAiGIM0LNwjtkLBbq6x1egNNqMkUpj
	 8vNGXl00ArybEMeLgegFI4i8indeGCnI9mTUw1LTsjgmAWkIZduRqlQVUPvUucjSZvs1G
	 gWE5E/RLaAxCDEOGCdI8Y7pke5Wuo9INNQOFbH/FLHC4yh8ODwnEly576Cmj3aARxI4/c
	 E9r6AqXcRLaDJLzzLalVe85RweO+/lXhUFW+s+xSO72aeHvsLwTpdzmMhiSE+L7gm3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fit.vut.cz;
	spf=pass smtp.mailfrom=fit.vut.cz;
	dkim=pass header.d=fit.vut.cz header.i=@fit.vut.cz header.a=rsa-sha256 header.s=a2025 header.b=HNidFdx9;
	arc=none smtp.remote-ip=147.229.8.13
Received: from adela.fit.vutbr.cz (adela.fit.vutbr.cz [147.229.8.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBA1606A320;
	Sun, 22 Nov 2026 19:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FBA1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fit.vut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fit.vut.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fit.vut.cz header.i=@fit.vut.cz header.a=rsa-sha256 header.s=a2025 header.b=HNidFdx9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fit.vut.cz; s=a2025;
	t=1795374889; bh=hHjloBzlgPxOdsnc87/Th+nFyYHXGF+qPbM11kNj5TE=;
	h=From:To:Cc:Subject:Date:From;
	b=HNidFdx91xSG6VkghLwyRM86QZvA1uf+XjTM84x/ELcRya+mr8xcS9qRdJSmYbBR9
	 ghLNhh+QK09zWsut3HdKSWTxJUytfZ/Hc+YULkMd7uzHzhQCyblde2EsehMW09vOhY
	 WAA/76mA9hPf9zk+VXzWdmDSHqiGQ8u5NT2gU3EBAfS2TFBYOqf67hsYGV2vBoZB10
	 VVaHaeDug+/cw9i42prHhFsXKgDV03xb25vrdhi2ZJtIT5RhzU6hD8vHV9rWz86OyU
	 IMFvwy/wFXTDLRgEHGEQaTVaXZk0bYQe71w1aZpanzACl+REJTYufOoLRJOZ1wX+qa
	 E+c8Qpqc2BdKg==
Received: from tomoka.kn.vut.cz (unknown [100.72.76.61])
	(Authenticated sender: inguyen)
	by adela.fit.vutbr.cz (Postfix) with ESMTPSA id 7A194260229;
	Sun, 22 Nov 2026 20:14:49 +0100 (CET)
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
Subject: [PATCH] rust_binder: only remove a node from the tree if it is still there
Date: Sun, 22 Nov 2026 20:13:22 +0100
Message-ID: <20261122191322.929005-1-inguyen@fit.vut.cz>
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
X-Virus-Scanned: clamav-milter 1.4.3 at adela
X-Virus-Status: Clean

Node::do_work_locked() removes a node without references from its
owner's tree with remove_node(self.ptr), i.e. by the userspace address
of the node. That is only correct if the tree entry at that address is
this node, which is not guaranteed.

A node can be queued twice: as the Node itself and through a NodeWrapper
(a strong zero-to-one increment made while the Node is already queued).
If all references are dropped before either work item is delivered and
the wrapper is delivered first, NodeWrapper::do_work() removes the node
from the tree while the Node work item is still queued. Userspace can
then create a new node at the same address. When the stale work item is
delivered, do_work_locked() sees a node without references again and
removes whatever is at that address: the new, live node.

The owner can then no longer look up its own node. BC_INCREFS_DONE and
BC_ACQUIRE_DONE for it are ignored, so BR_RELEASE and BR_DECREFS are
never sent, and the next BINDER_TYPE_BINDER object with that address
creates a second live node with the same (ptr, cookie). Freeing a buffer
that holds a binder object for the hidden node makes update_node(), a
lookup by address, decrement the other node. Its count drops below what
the handles to it hold, and the next NodeRef::absorb() on such a handle
hits assert_ne!(inner.strong.count, 0):

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

An unprivileged user can trigger this with ten ordinary binder commands
from one process; no race is involved. All that is needed is a binder
device, and with CONFIG_USER_NS=y any user gets one by mounting binderfs
in a user namespace. The calling thread dies in BUG() with binder locks
held (the task exits with preempt_count 2).

Pass the node to remove_node() and only remove the tree entry if it
still refers to that node. Node::global_id() is the address of the node
and both nodes are alive at that point, so a node that is still in the
tree is removed exactly as before, while the stale work item of a node
that has already left the tree no longer touches another node's entry.

The problem was found on v7.4-rc3 with the Kani model checker (0.68.0):
an invariant over the node state is not preserved by Node::do_work()
and NodeWrapper::do_work(). It was then reproduced on an unmodified
v7.4-rc3 kernel (x86_64, QEMU) with a C program that runs as uid 1000,
mounts binderfs in its own user namespace and issues the ten commands.

Build-tested on x86_64 (defconfig plus CONFIG_RUST=y,
CONFIG_ANDROID_BINDER_IPC_RUST=y and CONFIG_USER_NS=y, rustc 1.100.0):
no new warnings, also with CLIPPY=1, and rustfmtcheck is clean.
Run-time tested with two test programs only: with this patch the
reproducer runs to the end and the owner receives BR_RELEASE and
BR_DECREFS again.

The analysis, the reproducer and this patch were prepared with the help
of an AI assistant (Claude).

Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Le Duy <inguyen@fit.vut.cz>
---
The reproducer was sent to the maintainers separately; following
Documentation/process/security-bugs.rst it is not posted to the list.
The patch also applies, with line offsets, to linux-next (next-20261120)
and to v6.18, 6.18.64 and 7.3.5. On those three kernels the reproducer
hits the BUG without the patch and runs to the end with it.

 drivers/android/binder/node.rs    |  2 +-
 drivers/android/binder/process.rs | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder/node.rs b/drivers/android/binder/node.rs
index efdafc2..052b0e5 100644
--- a/drivers/android/binder/node.rs
+++ b/drivers/android/binder/node.rs
@@ -636,7 +636,7 @@ impl Node {
         }
         if no_active_inc_refs && !weak {
             // Remove the node if there are no references to it.
-            guard.remove_node(self.ptr);
+            guard.remove_node(self);
         }
         drop(guard);
 
diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index 1f4cb43..e5b3992 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -221,8 +221,21 @@ impl ProcessInner {
         }
     }
 
-    pub(crate) fn remove_node(&mut self, ptr: u64) {
-        self.nodes.remove(&ptr);
+    /// Removes `node` from the `nodes` tree.
+    ///
+    /// The tree is keyed by the userspace address of the node. A node that has lost all its
+    /// references can be removed while one of its work items is still queued; userspace may then
+    /// create a new node with the same address before that work item runs. Only remove the entry
+    /// if it still refers to `node`, so that a stale work item cannot remove the newer node.
+    pub(crate) fn remove_node(&mut self, node: &Node) {
+        let (ptr, _cookie) = node.get_id();
+        if self
+            .nodes
+            .get(&ptr)
+            .is_some_and(|cur| cur.global_id() == node.global_id())
+        {
+            self.nodes.remove(&ptr);
+        }
     }
 
     /// Updates the reference count on the given node.

base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
-- 
2.56.1

