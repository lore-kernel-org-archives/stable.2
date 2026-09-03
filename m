Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952404B2CC6
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444499; cv=none; b=UZwhfyo+W/bJO3JnbyqMRMwOoCKuRl35ubPZ8dvlAwkrIUPnm/EhKMBACJWEWlGwLfuk33bpBA3e6jr8R+AIQ6i0++xcikc0SauwiRBIdVHYcQPqrDGgr3rtnKYOIS/sfy9b/NNi9k+Fk4veH8reLVsjsiMpS1aLFf6vrmtFv1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444499; c=relaxed/simple;
	bh=A1aLYCfpVU5UmDBhMBSYmupbV3hhM1g9xkmIEo4r0x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuFJ2xMn8PM7WCctBB8RL/lxdX6MfMmW9CC74dLh0eYXhwXFzSptNHXuw0FfrQZmNYygOLWLZWrnJ4Tggpa1D1SM94+b05DhfxKMR1qbcugh2aOZqqHxGfat+Y4xpEl5V4ueTrXrIbm9LTTpkKHUegvQy6Hm2uWxsvK0hV8Dtyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVGKvCTq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVGKvCTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721971F00ACA;
	Thu,  3 Sep 2026 14:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788444490;
	bh=KWt8V/W7scnalKvcS2EtTAD1oAm/j49Dyij2hFzr/9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lVGKvCTqFnuB9/Rl4CMt4poIhIce4vh/HtzhOjMqZDsQBBmW01nTNkKMisadcTAAN
	 SQzJy1pZPc20gf1cHPzHYFtMAlpoTGEUiuCfJ/oQnG5cKf5pqHbkthWJj0IGdTrfK4
	 bKiveUV8RhdhCt8T+7N2mUCddkopOCWXrq0cFo8Y8pY6r9mmha+vA49wGw59/AoUd/
	 ULHKms3FZLU3qz//Fkol55obD41gZX6PSSQd+fdQzx1X+B5NzuhNdzghC25kJQDKno
	 lF79pHtLUMkJw5WQ9q+FW7vdeUB82gvvTWN6+kOLq56MD5AWtwUJkFHheO9CAbobIb
	 C660sWjePeocQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] rust: devres: fix race between concurrent revokers
Date: Thu,  3 Sep 2026 10:08:06 -0400
Message-ID: <20260903140806.792338-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903140806.792338-1-sashal@kernel.org>
References: <2026090315-banker-thank-0f7d@gregkh>
 <20260903140806.792338-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Danilo Krummrich <dakr@kernel.org>

[ Upstream commit acc516dfa1972d31836b50abc0115216cd0fccc5 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/kernel/devres.rs | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 08c1f73144209..67471946f2b58 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -19,7 +19,8 @@
     sync::{
         aref::ARef,
         rcu,
-        Arc, //
+        Arc,
+        Completion, //
     },
     types::ForeignOwnable,
 };
@@ -28,6 +29,8 @@
 struct Inner<T: Send> {
     #[pin]
     data: Revocable<T>,
+    #[pin]
+    revocation: Completion,
 }
 
 /// This abstraction is meant to be used by subsystems to containerize [`Device`] bound resources to
@@ -44,6 +47,10 @@ struct Inner<T: Send> {
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
@@ -133,6 +140,7 @@ pub fn new<E>(dev: &Device<Bound>, data: impl PinInit<T, E>) -> Result<Self>
         let inner = Arc::pin_init(
             try_pin_init!(Inner {
                 data <- Revocable::new(data),
+                revocation <- Completion::new(),
             }),
             GFP_KERNEL,
         )?;
@@ -171,7 +179,9 @@ fn data(&self) -> &Revocable<T> {
         // `devm_add_action()`, hence `ptr` must be a valid pointer to `Inner<T>`.
         let inner = unsafe { Arc::from_raw(ptr.cast::<Inner<T>>()) };
 
-        inner.data.revoke();
+        if inner.data.revoke() {
+            inner.revocation.complete_all();
+        }
     }
 
     fn remove_action(&self) -> bool {
@@ -266,6 +276,10 @@ fn drop(&mut self) {
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
-- 
2.53.0

