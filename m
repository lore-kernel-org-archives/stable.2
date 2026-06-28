Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396DD1531E8;
	Sun, 28 Jun 2026 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782668715; cv=none; b=VzYSYZwlp4FGLj/LXIjH9qZG72ynUDAbFD7lR/swKQwW83EjKU+JjkFaNVEJHuSvHBnd7Ks7ygSIfUyAVW2XWEa2t9aYw5K/2G5J7mpWEJXCIc3nmCCYrEhioTzwA5iq1NzVptNNYXBZiyEtwdcymlWqhoRvw0zqeJ6RapyYRwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782668715; c=relaxed/simple;
	bh=k+F/+3LgpveYbZ7cPWi4gj6oKSTw1m+Vdzon0wGmV/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U9tGbsgiegMq6f+pIHkVIeFGyFuc1WQyka/eCCIUfcFe8jaj7CFpoWplRFieTW39GWoBaoIwNYo4AcVwsGOdfJSrTin820QkhC3OM1ANyz9DiMc7MZr3idaWuo8DirMu0nSx1Ie9wdCyEZErcdkQBxqn13oXzDDsw6kkS8AKMeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDA41F000E9;
	Sun, 28 Jun 2026 17:45:09 +0000 (UTC)
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	lyude@redhat.com
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] rust: devres: fix race between concurrent revokers
Date: Sun, 28 Jun 2026 19:44:38 +0200
Message-ID: <20260628174451.2275679-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a potential race condition when two paths try to revoke a
Devres concurrently.

The driver core's devres_release_all() calls Revocable::revoke() via the
release callback, while Devres::drop() calls revoke_nosync() on another
CPU.

The revoker that does not claim the is_available swap returns
immediately, but the revoker that did may still be executing
drop_in_place() on the inner data. This can cause a use-after-free when
the other revoker's caller proceeds to drop adjacent resources that
drop_in_place() still references (e.g., Devres<DmaMappedSgt> racing with
SGTable freeing the backing sg_table and pages).

Fix this by adding a Completion. The release callback signals the
Completion after revoke() finishes, and Devres::drop() waits for it when
it loses the is_available swap. This ensures the wrapped object is fully
torn down before Devres::drop() returns.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/dri-devel/20260612202841.2577C1F000E9@smtp.kernel.org/
Fixes: 05aa6fb1c21d ("rust: scatterlist: Add abstraction for sg_table")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 11ce500e9b76..11d862f1e6de 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -21,7 +21,8 @@
     sync::{
         aref::ARef,
         rcu,
-        Arc, //
+        Arc,
+        Completion, //
     },
     types::{
         ForeignOwnable,
@@ -37,6 +38,8 @@ struct Inner<T> {
     node: Opaque<bindings::devres_node>,
     #[pin]
     data: Revocable<T>,
+    #[pin]
+    revocation: Completion,
 }
 
 /// This abstraction is meant to be used by subsystems to containerize [`Device`] bound resources to
@@ -53,6 +56,10 @@ struct Inner<T> {
 /// After the [`Devres`] has been unbound it is not possible to access the encapsulated resource
 /// anymore.
 ///
+/// When a [`Devres`] is dropped, it is guaranteed that `T` has been fully dropped by the time
+/// [`Devres::drop`] returns, even if a concurrent revocation through the release callback is in
+/// progress.
+///
 /// [`Devres`] users should make sure to simply free the corresponding backing resource in `T`'s
 /// [`Drop`] implementation.
 ///
@@ -217,6 +224,7 @@ pub fn new<E>(dev: &Device<Bound>, data: impl PinInit<T, E>) -> Result<Self>
                     };
                 }),
                 data <- Revocable::new(data),
+                revocation <- Completion::new(),
             }),
             GFP_KERNEL,
         )?;
@@ -254,7 +262,9 @@ fn data(&self) -> &Revocable<T> {
         // SAFETY: `inner` is a valid `Inner<T>` pointer.
         let inner = unsafe { &*inner };
 
-        inner.data.revoke();
+        if inner.data.revoke() {
+            inner.revocation.complete_all();
+        }
     }
 
     #[allow(clippy::missing_safety_doc)]
@@ -361,6 +371,10 @@ fn drop(&mut self) {
                 // this additional reference count.
                 drop(unsafe { Arc::from_raw(Arc::as_ptr(&self.inner)) });
             }
+        } else {
+            // The release callback is concurrently revoking; wait for it to finish
+            // `drop_in_place()` of the wrapped object before returning.
+            self.inner.revocation.wait_for_completion();
         }
     }
 }

base-commit: 0716f9b9338a86dd27796e00ed0fd560c653323a
-- 
2.54.0

