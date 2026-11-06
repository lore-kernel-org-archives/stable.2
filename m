Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976452;
	b=XL9MsRZJpy/3Qrw8MDKFI8+I+9lIoybQYngoEhNs/OI+kAz2/rAG+q1oy3IkgHRvH0dQ
	 al5+GVOhAKdAAL+UtXTOAbd9Iw2OAQrP5shFeV6jXEAX3jK5oBEg9BWs+r8SiA1WbJ3Sj
	 Q2RsomiCArB9pzEJx9tl2CDl+eh428NLSRgo69pG5jiiCccRRGgU98UgrwkSVoKGSO+Rl
	 kBrNurBUr8JPZgJM6De8MX9D7cw4gtzRfQZc2BM9qDnkxN2+jKKU894Watavx7E1/fCe1
	 wGQBoBLSoQ5lf+a4luMblU94EFvZ7bDFyYCH1hcZ9uBe6f3Dl0epa1AgVoT8+dUiclA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976452;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aUBFo9g7MY/LWqA2of0e8iwyMDuwjTaMliEoJkcs9GE=;
	b=h/upGcJnWd+NP1wvPRXmMWCp9noUT2xMku+mR5QFX9Bu6w6rWQNLHmMgeqjNXc3/sPkD
	 mU2koCN9LhN4O4/tbKRPaf14F/Gjy/kq6mC0WQvgnR/kOm+EeoGCsisOzo8l9jZtiZNoB
	 iUH7uXwLArZJbWFJ45RSQ/X5zzxCdL0n6IGoHwoSx09XduT4SsczqQEOJKQQUFaUopif9
	 lLo3xkQLL70fF0rWdHFfYb9dHagHgeNK0jY37j/DakRPI84diyvRh0PTg38GsLT5CeEA1
	 EQ/oMMwcy2ihIjmHglvNfEHXprPpRUyMPDHSblkvnKi6Gt+e0UJdR7WPMaA1Ev6qVtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPneP3RP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B1606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPneP3RP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE411F0089F;
	Fri,  6 Nov 2026 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976451;
	bh=aUBFo9g7MY/LWqA2of0e8iwyMDuwjTaMliEoJkcs9GE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fPneP3RPVveOZc0jdExfxCPQq7tRpaBIS81iM7hqJQiJ7xXEKuR6Tw/0JmxGgU1l3
	 6zLRbdbEYPuUXE9Q1kqo00pbYCuTg15Q3LVP7zX+LMP7AcZPD+hV8f0u8099bTzULs
	 OwZJ5MOL8QFei39LciOMhb1g5ehlrsU/a+v92fP48ALDsdue0GXhjoHwiwgaqL6djV
	 5KdDKmVS3Ux5ZBvSbK42pIZc12PqXqCHbs8b3dMLNiej+zCUtZ5NC+4BXSTolx3vsT
	 FczHu7jRxASc3UHbAB0TtKkieh8vU32zj5O+HPXDhHbu3wD6sgFSNM2DaApGK/ksnv
	 jJJe4UeAsDkAQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org,
	sashal@kernel.org
Cc: aliceryhl@google.com,
	dakr@kernel.org,
	gary@garyguo.net,
	ojeda@kernel.org,
	samitolvanen@google.com,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH 6.18.y 1/2] rust: hrtimer: declare cfi_encoding for hrtimer_restart
Date: Fri,  6 Nov 2026 15:47:20 +0100
Message-ID: <20261106144721.29080-1-ojeda@kernel.org>
In-Reply-To: <20261104223318.627233-1-sashal@kernel.org>
References: <20261104223318.627233-1-sashal@kernel.org>
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

From: Sami Tolvanen <samitolvanen@google.com>

commit 39fe6892fd52faed6325ff7f13a92da01ab35727 upstream.

The hrtimer callbacks return bindings::hrtimer_restart, which bindgen
generates as c_uint. C calls them through hrtimer->function, which
returns enum hrtimer_restart. kCFI encodes enum types by name even with
integer normalization, so the type ids never match and every call fails
the CFI check.

Generate hrtimer_restart as a newtype with a cfi_encoding, as is done
for lru_status, and adapt HrTimerRestart to the newtype.

Fixes: 8a8afe9349fb ("rust: hrtimer: introduce hrtimer support")
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Tested-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261019-rust-cfi-fixes-v1-2-9503472ba738@google.com
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
[ Replaced bindgen's custom enum attribute option with sed
  post-processing to support older bindgen. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/Makefile               | 1 +
 rust/bindgen_parameters     | 1 +
 rust/kernel/time/hrtimer.rs | 6 +++---
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 3867ff14fbde..3f1abad648e6 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -368,6 +368,7 @@ $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags = \
     $(shell grep -Ev '^#|^$$' $(src)/bindgen_parameters)
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_extra = ; \
     sed -Ei 's/pub const RUST_CONST_HELPER_([a-zA-Z0-9_]*)/pub const \1/g' $@; \
+    sed -Ei 's/^pub struct hrtimer_restart\(/#[cfi_encoding="15hrtimer_restart"]\n&/' $@; \
     sed -Ei 's/^pub struct irqreturn\(/#[cfi_encoding="9irqreturn"]\n&/' $@
 $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
     $(src)/bindgen_parameters FORCE
diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 9e02500dc979..6f76fdcffd58 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -24,6 +24,7 @@
 --opaque-type spinlock
 
 # enums that appear in indirect function calls should specify a cfi type
+--newtype-enum hrtimer_restart
 --newtype-enum irqreturn
 
 # `seccomp`'s comment gets understood as a doctest
diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 856d2d929a00..35ff2ef7d944 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -498,14 +498,14 @@ unsafe fn start(this: *const Self, expires: <Self::TimerMode as HrTimerMode>::Ex
 #[repr(u32)]
 pub enum HrTimerRestart {
     /// Timer should not be restarted.
-    NoRestart = bindings::hrtimer_restart_HRTIMER_NORESTART,
+    NoRestart = bindings::hrtimer_restart::HRTIMER_NORESTART.0,
     /// Timer should be restarted.
-    Restart = bindings::hrtimer_restart_HRTIMER_RESTART,
+    Restart = bindings::hrtimer_restart::HRTIMER_RESTART.0,
 }
 
 impl HrTimerRestart {
     fn into_c(self) -> bindings::hrtimer_restart {
-        self as bindings::hrtimer_restart
+        bindings::hrtimer_restart(self as c_uint)
     }
 }
 
-- 
2.56.0

