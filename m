Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794112416;
	b=orMmH1trdt1yzU/2JKJ7EQty7AsZfANyV64VEndiKjU8xhU31K7SKqpy4ZWBAHPyGjwq
	 XalzueJf/l7Xjgx318KveyMMCX3TkWwaK5pdIfzzVd3XbTX3N6W+1MIG+7nxhi+v2EwIP
	 PHtTYLhT0HBb6s2SrcR6nrs9knus5EC91fdEEliup6DLybd9lGE4aejlAe42pU+xQkbtN
	 vh8TC3L2fMmeysxujPullC5rrgpCGOgWZXJ9lQjD6xW/2jVV2Rs9wjaTHw4Iy2X5IhrUy
	 WvT8CB3RDJNt0GLcjw3zordFE1DdOK+FcxZ1VzvuG5nljQgeDYHlufX27YNw/NtbcIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794112416;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IjJ+YLKvMUNCeftBGdY5yg1yaIaf4GYz3NmAgZBC0Qw=;
	b=SbiX2ay1fKTfSE2LZoH1UuSOW2Vbs8ZCSmjgvPRUWi+OVcq3j96jpmK8rQ1diHFWHIe5
	 OeWxsfqFDAQo8ZTSY6WyxSW6+wyMGfHBiYWwp/9gXjEXxGX/KDJRLVNuaHeFK/eqThkig
	 L2WNDfCPO4FykSvf35dEaaZIqOHCmT5rJfxBgWHBQZB0rVhlceWVAt4gOZO6Bw87BwR0J
	 62HhP7hh2/fmI324JzkNChK4D/aN6GRbeeF+AtqZc1AI67K0ePac831F8gy+OtdEf8vdV
	 +w/YI75lS2hPkKL2GEV2D7pGsmVoawj6v+U/JfJ8p4oRXL+r9n9ZlOpZfiHQaXxQYgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CkG3Mib7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F65606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 04:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CkG3Mib7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA711F0089F;
	Sun,  8 Nov 2026 04:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794112415;
	bh=IjJ+YLKvMUNCeftBGdY5yg1yaIaf4GYz3NmAgZBC0Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CkG3Mib7t/Q7s1UXQ/1POE9AuSZd3ekHa+M1L7X5gKTobA6DTvA70dLRFefhA9/4w
	 x3aNa4V+wbEjlHJu2ZAXWE3yyILf/d547e4RFyOsEEWP6DvM5vgU0fu86otFjeuCrQ
	 6BqOsQm9gBPEyPFmkM5LgS68jLi70mpeIXbYtpdZiNrFUeWY0OYuF35MyruCZBtCgH
	 IqkFSa3mZJFXdrmD+Pcf86UUPIn1dH7u38Vui3VIwvVKIGaTrD16PqFTLAgJ4DuEKY
	 TKeX3abRlMGXtw37JwuoDMh22Qroteo0NhxO8ndHQw03cyRzdTW6rBMNV9GOheRdfz
	 EK59NA4H5Tq1w==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org,
	sashal@kernel.org
Cc: ojeda@kernel.org,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: [PATCH 6.18.y 1/2] rust: bug: pass TAINT_WARN to warn_slowpath_fmt() on UML
Date: Sun,  8 Nov 2026 05:33:26 +0100
Message-ID: <20261108043327.98801-1-ojeda@kernel.org>
In-Reply-To: <2026110447-anything-wildcard-f4e0@gregkh>
References: <2026110447-anything-wildcard-f4e0@gregkh>
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

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

commit 951d09ca450ca76a695016ea76c3fa653bd20439 upstream.

On UML, `warn_flags!` calls `warn_slowpath_fmt()` directly. Its third
argument is a taint number, but `warn_on!` passes its bug flags there.

As a result, `add_taint()` gets 2304 instead of 9 (`TAINT_WARN`). The
warning is not recorded: `/proc/sys/kernel/tainted` stays 0 after
`warn_on!` fires, where it should be 512. It also causes an
out-of-bounds write in `add_taint()`.

Pass `TAINT_WARN` directly, as C does on UML.

Cc: stable@vger.kernel.org
Fixes: dff64b072708 ("rust: Add warn_on macro")
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Link: https://patch.msgid.link/20261001123103.2198104-1-tomo@flapping.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
[ Adapted to the single-argument `warn_flags!` macro. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/bug.rs | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
index 53dbdaec3560..364d90c6404c 100644
--- a/rust/kernel/bug.rs
+++ b/rust/kernel/bug.rs
@@ -79,13 +79,17 @@ macro_rules! warn_flags {
 #[cfg(all(CONFIG_BUG, CONFIG_UML))]
 macro_rules! warn_flags {
     ($flags:expr) => {
+        if false {
+            _ = $flags;
+        }
+
         // SAFETY: It is always safe to call `warn_slowpath_fmt()`
         // with a valid null-terminated string.
         unsafe {
             $crate::bindings::warn_slowpath_fmt(
                 $crate::c_str!(::core::file!()).as_char_ptr(),
                 line!() as $crate::ffi::c_int,
-                $flags as $crate::ffi::c_uint,
+                $crate::bindings::TAINT_WARN,
                 ::core::ptr::null(),
             );
         }
-- 
2.56.0

