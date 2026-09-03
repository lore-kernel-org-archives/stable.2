Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909D4A5EBE
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439444; cv=none; b=H5sV0A8OeCHgLyp42i/fKH24XMPFhbMF5yH6hvVmd1dczOd2fUhj+/GrckYy0wBgdyjy75AU2l0HTYWn2n6MIk/C3mYCcVx0bBHq3En7tjxWIYBvDFVrNqmdVZD6rh/s+gjAETig9QrSipt1WNVGGqrjJKUQl2LlvQxI6SWVZk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439444; c=relaxed/simple;
	bh=vYsrnnE6Ix+v0x3fDiCCHWFk5YTrTC+38YBVdvenTHU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GFtXQExeUwCYH3feo9fg8Lpb6G3dHVB2kMT3kw2YbBY+I+O/K8F0B57EWsTgslJ8SXui3bjjkmIM2uk+h6eO2odocvIwsBj9zcKHM8/2FOkypgYeDSFo7Sw6VZ2Oaag4PTOz7dx42Fp/q/6j+BYTP7ZMGE5ktEktYYvZrfI8yBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ywXdGxt6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ywXdGxt6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC861F00A3A;
	Thu,  3 Sep 2026 12:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439443;
	bh=fsZRpPL7cWkuSeWu+raJ+dWCMLOGHS+iZmm6o0NhiZE=;
	h=Subject:To:Cc:From:Date;
	b=ywXdGxt6K/P72GiNLO1B5z6NVrrb+OkCPxqnhh5VN32wiB39UAVUjfMTHAyiO0diw
	 a+GsfdX42Lb0JuqMblg6sQ6Aop1MQAEtpSlVVF8x6mcQ5fkiMeNjaU961nzEfSsqPf
	 JI1+vM5KoTqr4E5r7HdOHFsZ7J7c8v1Uv473U6PQ=
Subject: FAILED: patch "[PATCH] rust: devres: fix race between concurrent revokers" failed to apply to 6.18-stable tree
To: dakr@kernel.org,aliceryhl@google.com,gary@garyguo.net,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:43:15 +0200
Message-ID: <2026090315-banker-thank-0f7d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x acc516dfa1972d31836b50abc0115216cd0fccc5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090315-banker-thank-0f7d@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From acc516dfa1972d31836b50abc0115216cd0fccc5 Mon Sep 17 00:00:00 2001
From: Danilo Krummrich <dakr@kernel.org>
Date: Sun, 28 Jun 2026 19:44:38 +0200
Subject: [PATCH] rust: devres: fix race between concurrent revokers

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
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://patch.msgid.link/20260628174451.2275679-1-dakr@kernel.org
Signed-off-by: Danilo Krummrich <dakr@kernel.org>

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 20f94030f977..4a1e5eec78ab 100644
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
         CovariantForLt,
@@ -39,6 +40,8 @@ struct Inner<T> {
     node: Opaque<bindings::devres_node>,
     #[pin]
     data: Revocable<T>,
+    #[pin]
+    revocation: Completion,
 }
 
 /// This abstraction is meant to be used by subsystems to containerize [`Device`] bound resources to
@@ -55,6 +58,10 @@ struct Inner<T> {
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
@@ -222,6 +229,7 @@ pub fn new<E>(dev: &Device<Bound>, data: impl PinInit<T, E>) -> Result<Self>
                     };
                 }),
                 data <- Revocable::new(data),
+                revocation <- Completion::new(),
             }),
             GFP_KERNEL,
         )?;
@@ -259,7 +267,9 @@ fn data(&self) -> &Revocable<T> {
         // SAFETY: `inner` is a valid `Inner<T>` pointer.
         let inner = unsafe { &*inner };
 
-        inner.data.revoke();
+        if inner.data.revoke() {
+            inner.revocation.complete_all();
+        }
     }
 
     #[allow(clippy::missing_safety_doc)]
@@ -363,6 +373,10 @@ fn drop(&mut self) {
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

