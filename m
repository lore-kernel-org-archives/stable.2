Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F72335B632;
	Sun, 28 Jun 2026 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782658458; cv=none; b=VTarVWh5EG0gNstpVF1ZzEperEKzmj/uS/KpYV29BHB0YJRYj2mI58bE1k5kuow05lCwjRNo3+7BoqqL65B5jJuV4GMWwtMoNEFiXyYLN99mnP4kPxL7b+TyZ4TLpR+25xQlqLqRb5blZxWVoPPoOtFLCe3at3NPluc0W69n7Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782658458; c=relaxed/simple;
	bh=z6AOwmdIRLML2D1KhdOoO9G8hdXZg1Kliu2FHRDnlPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gImNCEEk4Zf0vgObGFBho7v9v9J7EluCytbwcQLAL6/P10lAVdL8+YuDcjLYS2m8G/PBOyyiKMMJM5Mc/BCYGl6+KsPVP0+OIRDTeH+Ves7Q34KzX8Ubwik13mrejGuV8JaQhzFmmTHw1NulLzDBve0iGsgfBCJzskNP2g03Gss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKlTsP2M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKlTsP2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBAE1F00A3D;
	Sun, 28 Jun 2026 14:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782658457;
	bh=oS07YqSWpkiVT3UqKLEIP2G04oMvZVTuO+imk72U8qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OKlTsP2M+GePAJzRPp9MNlwExxg7Bh8fd+BU/6dr2yOnoe17g3dAoafib/8ZLNQxf
	 nDWF4qzAKdzQTYlkobehF949VzKjsk128blh7gS7kZTDLuxZtlJKC4BrTarDGFpQGm
	 7jcuFauygF0LulldgN0A2ck4cmBROqXsBIBl6NkN+24F5WStFRQHgFCLe1Agv9f1pP
	 JV5Y3NJuNQDeYNSfDIX4pNkghwuuRxCFsLce1KkQKuC5F42QJLaVoQiwgcTnYpEpjk
	 XEaJ8mHrApeViytv2HaZJBJ8Wijc+bq1ypC9vV4NStP7mwvmAVzmPYXkPkb7uKFhdU
	 73Yp+JyNppAaA==
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
Subject: [PATCH v5 01/19] rust: drm: ioctl: fix unbounded lifetimes in ioctl handler arguments
Date: Sun, 28 Jun 2026 16:53:21 +0200
Message-ID: <20260628145406.2107056-2-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628145406.2107056-1-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
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

Fix this by adding a higher-ranked function pointer coercion that
enforces the handler accepts universally quantified lifetimes:

  let _: for<'a> fn(&'a _, &'a mut _, &'a _) -> _ = $func;

Since the handler must be coercible to a function pointer accepting any
lifetime 'a, it can no longer demand 'static on any parameter.

Cc: stable@vger.kernel.org
Fixes: 9a69570682b1 ("rust: drm: ioctl: Add DRM ioctl abstraction")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260620011346.A47D01F000E9@smtp.kernel.org/
Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/ioctl.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index cf328101dde4..ccf4150d83b6 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -135,6 +135,12 @@ macro_rules! declare_drm_ioctls {
                             // dev/file match the current driver these ioctls are being declared
                             // for, and it's not clear how to enforce this within the type system.
                             let dev = $crate::drm::device::Device::from_raw(raw_dev);
+
+                            // Enforce that the handler accepts higher-ranked
+                            // lifetimes, preventing it from requiring 'static
+                            // references that could escape this scope.
+                            let _: for<'a> fn(&'a _, &'a mut _, &'a _) -> _ = $func;
+
                             // SAFETY: The ioctl argument has size `_IOC_SIZE(cmd)`, which we
                             // asserted above matches the size of this type, and all bit patterns of
                             // UAPI structs must be valid.
-- 
2.54.0

