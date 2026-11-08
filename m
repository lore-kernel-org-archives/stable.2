Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794112417;
	b=bOUMyhUwK77o8/HN5mQlCcs/gNaf+Qf/YiC7tDONyjW6BLutARayGh5QKCwGMfbT6tb6
	 /WQUuZGtN3FkHX4qIvJIvsJy4HUDg5JJv8Sm5gwnPWHMkiItXYHXiOOHJcxfCiE1mSmMD
	 KU8A31BD+yzzwPDyoHhgrOe6PIxQzQ7d5nNfVqF7e1ptse/R0DpSKcsU0DaOnThjiXIAy
	 jOoQxAUOH7VC3YFlbnUYTNmwe17lEpGLXSO5eQT6qwBvMkqhSF/ZoY+3qXCMq2DgZqNpe
	 GTkaQf8RJtazLlxW6gCADtmbvMPhe8rFPV34tI5z/WxC85DaKtdeReAH5ya7MIIbBlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794112417;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m5wC+ND2tw7mQ4Wa5Fky7OdAk7ixZn1pqas+JgcIOw4=;
	b=PPeD/JKr7m1+wSofHGmLVIfOmO+wYKey4MlDKDubxzl/7B21jcg8hnpENl5j0+hKM73n
	 wWX5bHvSAJ3o5Lg7RwlnGnUmouWmZZwHQjHGjoNj1x57bm27E+tWvpxk4V/gB/7QShLMq
	 aDUbD52DveOK2RT7HFpAXMXdyPnrrzSFFtowRTcN+KUEAwcrR2DiGTUnxUbLGYnBq/Y0M
	 rJUaMx/RL0m36ViqaSsvsM6LcG5o8hE0qhjvib1UnW87+JzSVceBjpy7+73kwUdYXhN/k
	 dgk54t/QInwot2xFe57/R01BfLdFNx4LSPHu7dVstqJO6xqb/8cArNpGGIRj34SHMoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zbt6jJDn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6F606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 04:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zbt6jJDn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4571F008A1;
	Sun,  8 Nov 2026 04:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794112416;
	bh=m5wC+ND2tw7mQ4Wa5Fky7OdAk7ixZn1pqas+JgcIOw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zbt6jJDnq5Xi0fuwm9sY5izzCko6CtIkNBW6He+itoPZlA3lNzeTUk//Nq703Fi8E
	 Y7MzQUTAFXQd3/OTaXiV/5pjXyeMa9tOMf0YAi6ccm9Fc7BrqSAAcvsxt+nc6kuqaQ
	 nFVDr2/zpjM9NStnLIHPXlAcjHVeG3ZJqv7yOjE1U0KAnKSD1QoFWGxFL/wHuldC//
	 5dDKaJebYlCT78KiC7R/votlBdVu0hArRMX7/EbnMwUgLSuGDFNa/RnM8K5HBZQg40
	 4IT3JPXMmDfVOvQYCuoU4ht2OmXfDogmWida+UhNLeRyZIhcyuKF4qN6t/89tf+zKl
	 3Ofqypa3zEhOw==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org,
	sashal@kernel.org
Cc: ojeda@kernel.org,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: [PATCH 6.18.y 2/2] rust: bug: update the SAFETY comment for warn_slowpath_fmt() on UML
Date: Sun,  8 Nov 2026 05:33:27 +0100
Message-ID: <20261108043327.98801-2-ojeda@kernel.org>
In-Reply-To: <20261108043327.98801-1-ojeda@kernel.org>
References: <2026110447-anything-wildcard-f4e0@gregkh>
 <20261108043327.98801-1-ojeda@kernel.org>
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

commit 5c94956f2bfb87025c1eaded6c51d5841d38d333 upstream.

The SAFETY comment says that it is always safe to call
`warn_slowpath_fmt()` with a valid null-terminated string. This is not
true. The taint argument must also be a valid taint number.
Commit 951d09ca450c ("rust: bug: pass TAINT_WARN to warn_slowpath_fmt()
on UML") fixed a bug where it was not.

List each condition that the call meets: the file name, the taint
number, and the null `fmt`.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Link: https://patch.msgid.link/20261002104550.2877930-1-tomo@flapping.org
Cc: stable@vger.kernel.org
Fixes: dff64b072708 ("rust: Add warn_on macro")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/bug.rs | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
index 364d90c6404c..95bfd195c986 100644
--- a/rust/kernel/bug.rs
+++ b/rust/kernel/bug.rs
@@ -83,8 +83,10 @@ macro_rules! warn_flags {
             _ = $flags;
         }
 
-        // SAFETY: It is always safe to call `warn_slowpath_fmt()`
-        // with a valid null-terminated string.
+        // SAFETY:
+        // - The file name is a null-terminated string with `'static` lifetime.
+        // - `TAINT_WARN` is a valid taint number.
+        // - `fmt` can be NULL, and NULL is passed.
         unsafe {
             $crate::bindings::warn_slowpath_fmt(
                 $crate::c_str!(::core::file!()).as_char_ptr(),
-- 
2.56.0

