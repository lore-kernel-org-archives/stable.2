Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823483;
	b=LYgM925Xqrbkz/ybqXe1Pl17DEOxWtXh3Qn3S+LFDKKAvk2YPlfB1TXX8sCaZy3vFg6c
	 X8d//FIDqCma0dlwYUUeI8N0buuAMXWjkP+YoBizfldZv4abiKqqf5IQpmQPCw4FE5WuN
	 ohzq1P6WNF6PChQRQF8Q/iQKNDe7BsXDDGmJgAUyFg6foMDXy/Sv0i6UBJ+y8L4pxY7rP
	 zA54LIaSv6R8TDHHde3B8+TtTCln+d2/p/zhpUJ3M1VrSy4XxS/+57C9KIA0p/VaaLI+u
	 lyTaB92853xdPPYrVy0jeJuUqvKRwulDNJDVo8Aq6OtAlzocbaerlIbYWYkyaJtRK5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823483;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aDOv6PsXoAQL6u2vo1US1p8FLhKg2iRCJfEJpWeJz3E=;
	b=3OKrnec5Ifbzec0XroWtNHRfMDBRNJilUCsgd9P7jrc+XpwHK2vjBtHcU6uZBMQzQXcn
	 xv/bCedhYMFf70ZVAKisb8VBgi+P7GZ0vK7R5gm+JOFBpE7An3B38surUV7mR4XySwugf
	 ML2lsYnEBr8U237I/ahiu+s3NcAL1MHN0z6Z/zdGeASsGsJWOHlfeCvvMhKXGo1QYetGF
	 P83YfTiT6Tq33GDrXESIVafVZ38LkGRYu0YtH+6mdQKbgD2l6soVDUF50wN7isnvz+IHw
	 pyyO80Pg1l8T+Z/Y529euh7OV9ee2xkEb3qc/0+w4T5FKK++Dj5HV3LIjp/Nt+7v68w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ceaHdx1w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2039D606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ceaHdx1w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F281F000C1;
	Wed,  4 Nov 2026 20:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793823483;
	bh=aDOv6PsXoAQL6u2vo1US1p8FLhKg2iRCJfEJpWeJz3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ceaHdx1wrjwpzvdaycuulLgTQl3EIIk3A5OZLRdL9JeeTWqvs5IJBYhrMwVYAmJiG
	 HfgGqTNmSLqb6Tj7HVwNkzkKr+tu4Sod1xElv+2p8UGrbbRW/j7+W4X2C4kgvDDZud
	 rkK/nLnwJTFQBKitPl0/A17KpckKG0SFTy/qv6xZbyoRdk3gtYJOlPZ4DbHtXFNeip
	 FEs5aoqaSj04XENDlABzf3e+WWgGGxoorCU52LdX6K4DaXVrwLcOXPrSPgs1tfDFHT
	 FDaI1jKSC2TsXhV0VCxVZC3riNIprzZ8GPlirlHaT5EPcZhutGZ9nKlGrBAvJi/Pfm
	 R3KGs7gyrdQXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] rust: bug: pass TAINT_WARN to warn_slowpath_fmt() on UML
Date: Wed,  4 Nov 2026 15:18:01 -0500
Message-ID: <20261104201749.344995-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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

[ Upstream commit 951d09ca450ca76a695016ea76c3fa653bd20439 ]

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
[ sashal: adapted warning handling to the single-argument warn_flags! macro and existing CStr API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/kernel/bug.rs | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
index 15a84e553fd4d..7e540954d67a0 100644
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
-                $crate::str::CStrExt::as_char_ptr($crate::c_str!(::core::file!())),
+                $crate::str::CStr::as_char_ptr($crate::c_str!(::core::file!())),
                 line!() as $crate::ffi::c_int,
-                $flags as $crate::ffi::c_uint,
+                $crate::bindings::TAINT_WARN,
                 ::core::ptr::null(),
             );
         }
-- 
2.53.0

