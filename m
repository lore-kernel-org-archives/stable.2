Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185426ED3A;
	Sun, 28 Jun 2026 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782677024; cv=none; b=KLz4SzecHHE83/XWq2EFSlz1XcUwmg8VBdvi8CnUbg2rMgBrwIYTmWMK/grwHFgNsuT4dCQkJk5tU74FLsLilzVBTaBztNfC6J1IXnvf1FXwYMp/Nfwro1oLWhrCRI07ZKu6LEKg1qyUYewiPUsCuZKZS5Fq8hAipcvbt+MBe7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782677024; c=relaxed/simple;
	bh=2cHFFPC0mGiShryppd4erFEhd715CSn0cr9WuI8tDwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHLztqzeL11E3asXK2yhDLTIjcJL1hwP7r9U5cDfWG62O60bLKxPYBEzQS8crofewsEoxIdc6km6RBO5X+Vb8S5w3LWZBVXQrWFd1+uCiURIUqulrNzS3pyaupr3d8tgZ0do5hWBNUicjs1CLGwOomiG6xRvDuquBB568l68dM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUefJOWn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUefJOWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45F21F000E9;
	Sun, 28 Jun 2026 20:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782677023;
	bh=frHiRHw3H3PdxqJsD/24F7Lnivb422p6BVK/wWW5Mbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZUefJOWnvAoMOrDkIhK5EMO40alzCC8qdERZwVUADNk5MnC/x8PlBBRt4Vs6GUx0A
	 WO5VuPnH7/WjWdXQf9CG9/q3tOLJNg5wBk9ilqEGhIf+LzjZXc5B2KlV8VE37YxdhS
	 uvNDNPPwimy0fknr3DrvSLIvKmh/3BTLmOXE9erjRrXODfbDvUwDYjwb8xHlQobK9u
	 5D9CqKxPWiVNZtL2BRr5aaFS2FMhenx6+6w+ujJs/zNS10+J6ByHjeVLxiI7A+LcHw
	 /BnhqRN5ZIOyMCq+6atdHqEnMYWVDyJpr24YNHBUjDYb89l5kn3aZQIWa3aUbVDDhX
	 bqEdAfiR9T13A==
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
	stable@vger.kernel.org
Subject: [PATCH] rust: devres: ensure revocation is complete before device finishes unbinding
Date: Sun, 28 Jun 2026 22:02:53 +0200
Message-ID: <20260628200304.2365598-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628174451.2275679-1-dakr@kernel.org>
References: <20260628174451.2275679-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the revocation Completion is in place, also address the
symmetric case. When Devres::drop() wins the is_available swap and the
devres callback loses, the callback returns to devres_release_all()
without waiting. This means device unbinding can complete while
Devres::drop() is still executing drop_in_place() on another CPU, which
is a problem if T's destructor accesses device state.

Make the synchronization bidirectional. Whichever side performs
drop_in_place() signals the Completion, and the other side waits.

This does not reintroduce the nested Devres deadlock fixed by commit
ba268514ea14 ("rust: devres: fix race condition due to nesting"),
because that deadlock was caused by drop waiting for the release
callback to return (the old 'devm' Completion). Here, both sides only
wait for drop_in_place() to finish, which completes within the current
call chain. The Arc<Inner<T>> keeps the Inner allocation alive
independently.

Cc: stable@vger.kernel.org
Fixes: ba268514ea14 ("rust: devres: fix race condition due to nesting")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 11d862f1e6de..f112c7e8bc3b 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -264,6 +264,11 @@ fn data(&self) -> &Revocable<T> {
 
         if inner.data.revoke() {
             inner.revocation.complete_all();
+        } else {
+            // Devres::drop() is concurrently revoking; wait for it to finish `drop_in_place()`
+            // before returning to `devres_release_all()`, ensuring `T` is fully torn down before
+            // the device finishes unbinding.
+            inner.revocation.wait_for_completion();
         }
     }
 
@@ -364,6 +369,8 @@ fn drop(&mut self) {
         // SAFETY: When `drop` runs, it is guaranteed that nobody is accessing the revocable data
         // anymore, hence it is safe not to wait for the grace period to finish.
         if unsafe { self.data().revoke_nosync() } {
+            self.inner.revocation.complete_all();
+
             // We revoked `self.data` before devres did, hence try to remove it.
             if self.remove_node() {
                 // SAFETY: In `Self::new` we have taken an additional reference count of `self.data`

base-commit: 6cb8c4e26a3684c9df382a350f06bfbe2a197e5e
-- 
2.54.0

