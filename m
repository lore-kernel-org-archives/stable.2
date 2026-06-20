Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D0F1F5437;
	Sat, 20 Jun 2026 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781981382; cv=none; b=RxgkN2OqtFDiifwVEEEXJm07kD5H4G9vRfuhA8f8rXjQkLMz6ptee3OJSQD1aZg/MTOxyQnynmP102LfqZEMM7Q+GHqmhkKTykSYXxFpYB0XYPqdCEFeVCWQRZOYOA6BdTIId0RZq2Sei89ynGwVkJP5wxGmH8wC7n84YlrG06E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781981382; c=relaxed/simple;
	bh=ibXkMIKOsyV797iFqkffGBq+FnDC+my/+3cwPht8Gg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8TahQZS2CS3u0myhNAVDm1QXTX3nnt9Dlm9YJa/wcfcdBi3nnZ4JyBl9uupEhms+cSDT1P0/9TjWr3nBseWyl1Zb/HWhARp19rkEh7yp6VDD4ON7UMCtIJeBW/7WEswKh5Nb2sqQaT1V7ZnCoM4TqnkmhKq9tBo9lz9Rpu1uxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCypBl2r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCypBl2r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2383D1F00A3A;
	Sat, 20 Jun 2026 18:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781981380;
	bh=CaM1+SVTD+InAXDdfA+jIamxSOfh/RY/jyvis0pChEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gCypBl2rDgXQNtLQAes0M4Huor84MXlc4eSOa6gSNd9U3aGzWqo8putoNaSTYYSyx
	 E1cOxWnEEZOjU3f9BzN40i9RqfT+brdaPYDw4EnUHF+O2nZAC3QjEcKQNXuxCbB4Vu
	 QliPybpkIpNiGK0Lt2amamhCrnk8ZBeAShYcvh8zyu33HLNLb3SSUR7hqlzXfuM2rA
	 nG6XlOfhEFT59CguvXvc4FLlAd0Pv5YAD2+ztGkOm5lKTmpf+9SgdGUfZqNc9c1nSS
	 DB0DGsQGyJv49xR5QxeVi8JEfPvctw8xJtmhWyOuzy+jcuK4pxitJpoUSryn2iD9Jx
	 f8nH0z7oWAieA==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org,
	aliceryhl@google.com,
	daniel.almeida@collabora.com,
	acourbot@nvidia.com,
	ecourtney@nvidia.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	deborah.brouwer@collabora.com,
	boris.brezillon@collabora.com,
	lyude@redhat.com
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH v4 01/16] rust: drm: ioctl: fix unbounded lifetimes in ioctl handler arguments
Date: Sat, 20 Jun 2026 20:47:54 +0200
Message-ID: <20260620184924.2247517-2-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620184924.2247517-1-dakr@kernel.org>
References: <20260620184924.2247517-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

References to dev, data, and file in the declare_drm_ioctls! macro are
created via unsafe pointer dereferences, producing unbounded lifetimes.
If an ioctl handler explicitly annotates its parameters with 'static,
the compiler accepts this, allowing the handler to stash references that
outlive the ioctl call.

Fix this by routing all references through a helper function whose
lifetime parameter 'a is tied to a local anchor variable. Since 'a is
bounded by the anchor's stack lifetime, handlers can no longer demand
'static on any parameter.

Cc: stable@vger.kernel.org
Fixes: 9a69570682b1 ("rust: drm: ioctl: Add DRM ioctl abstraction")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260620011346.A47D01F000E9@smtp.kernel.org/
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/ioctl.rs | 59 +++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index cf328101dde4..023e6da5c1e4 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -70,6 +70,39 @@ pub mod internal {
     pub use bindings::drm_device;
     pub use bindings::drm_file;
     pub use bindings::drm_ioctl_desc;
+
+    /// Call an ioctl handler with lifetime-bounded references.
+    ///
+    /// The lifetime `'a` is tied to the `_anchor` parameter. This prevents handlers from
+    /// declaring `'static` on `dev`, `data`, or `file`.
+    ///
+    /// # Safety
+    ///
+    /// - `raw_data` must point to a valid, exclusively-owned instance of `Data` for the duration
+    ///   of the call.
+    /// - `raw_file` must be a valid pointer to a `struct drm_file`.
+    #[doc(hidden)]
+    #[inline(always)]
+    pub unsafe fn __call_ioctl<
+        'a,
+        Dev: 'a,
+        Data: 'a,
+        F: super::super::file::DriverFile + 'a,
+        Ret,
+    >(
+        _anchor: &'a (),
+        dev: &'a Dev,
+        raw_data: *mut ::core::ffi::c_void,
+        raw_file: *mut drm_file,
+        f: impl FnOnce(&'a Dev, &'a mut Data, &'a super::super::File<F>) -> Ret,
+    ) -> Ret {
+        // SAFETY: Caller guarantees raw_data points to a valid instance of Data with the correct
+        // size and alignment, exclusively owned for the duration of the ioctl call.
+        let data = unsafe { &mut *(raw_data.cast::<Data>()) };
+        // SAFETY: Caller guarantees raw_file is a valid pointer to a `struct drm_file`.
+        let file = unsafe { super::super::File::<F>::from_raw(raw_file) };
+        f(dev, data, file)
+    }
 }
 
 /// Declare the DRM ioctls for a driver.
@@ -135,19 +168,19 @@ macro_rules! declare_drm_ioctls {
                             // dev/file match the current driver these ioctls are being declared
                             // for, and it's not clear how to enforce this within the type system.
                             let dev = $crate::drm::device::Device::from_raw(raw_dev);
-                            // SAFETY: The ioctl argument has size `_IOC_SIZE(cmd)`, which we
-                            // asserted above matches the size of this type, and all bit patterns of
-                            // UAPI structs must be valid.
-                            // The `ioctl` argument is exclusively owned by the handler
-                            // and guaranteed by the C implementation (`drm_ioctl()`) to remain
-                            // valid for the entire lifetime of the reference taken here.
-                            // There is no concurrent access or aliasing; no other references
-                            // to this object exist during this call.
-                            let data = unsafe { &mut *(raw_data.cast::<$crate::uapi::$struct>()) };
-                            // SAFETY: This is just the DRM file structure
-                            let file = unsafe { $crate::drm::File::from_raw(raw_file) };
-
-                            match $func(dev, data, file) {
+                            let __anchor = ();
+
+                            // SAFETY:
+                            // - The ioctl argument has size `_IOC_SIZE(cmd)`, which we asserted
+                            //   above matches the size of this type, and all bit patterns of UAPI
+                            //   structs must be valid. The argument is exclusively owned by this
+                            //   handler, guaranteed by `drm_ioctl()` to remain valid for the
+                            //   duration of the call.
+                            // - `raw_file` is a valid `struct drm_file` pointer provided by the
+                            //   DRM core.
+                            match unsafe { $crate::drm::ioctl::internal::__call_ioctl(
+                                &__anchor, dev, raw_data, raw_file, $func,
+                            ) } {
                                 Err(e) => e.to_errno(),
                                 Ok(i) => i.try_into()
                                             .unwrap_or($crate::error::code::ERANGE.to_errno()),
-- 
2.54.0

